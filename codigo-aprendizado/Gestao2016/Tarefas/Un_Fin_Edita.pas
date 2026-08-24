unit Un_Fin_Edita;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, StdCtrls, Mask, Grids, DBGrids, ExtCtrls, DB, Buttons, ComCtrls, STStoredProc, STQuery, Printers, jpeg, Menus, QEdit_Setes, Un_Fm_FormaPagto, ControllerFinanceiro, ControllerFormaPagamento;

type

  TFr_Fin_Edita = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    E_N_Parcela: TEdit;
    E_Vl_PARCELA: TEdit_Setes;
    SB_Gravar: TSpeedButton;
    Sb_Cancelar: TSpeedButton;
    E_Data_Venc: TDateTimePicker;
    Label9: TLabel;
    E_Obs: TMemo;
    sb_obs_nfe: TSpeedButton;
    Qr_Obs_Nfe: TSTQuery;
    Fm_FormaPagto: TFm_FormaPagto;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    E_Aliq_Desconto: TEdit_Setes;
    E_DataLimite: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    E_condicoesEspeciais: TEdit;
    Label4: TLabel;
    E_Dt_Reprogramacao: TDateTimePicker;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure Sb_CancelarClick(Sender: TObject);
    procedure sb_obs_nfeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Financeiro : TControllerFinanceiro;
    It_Inserir : Boolean;
    It_Alterar : Boolean;
    It_Excluir : Boolean;
    It_Visualizar : Boolean;
    procedure Pc_AtivarTabelas;
    procedure Pc_Preenche_Campos;
    procedure Pc_ImagemBotao;
  end;

var
  Fr_Fin_Edita: TFr_Fin_Edita;

implementation

uses     Un_DM, UN_Sistema, UN_MSG, UN_Receber_Multipla, Un_Pagar_Multipla, Un_Fich_Fin_Cli, Un_Fich_Fin_For, Un_Fc_Sored_Procedures, un_Obs_nfe, Un_Regra_Negocio, UN_Principal, env, RN_FormaPagto;
{$R *.dfm}

procedure TFr_Fin_Edita.FormCreate(Sender: TObject);
begin
  Financeiro := TControllerFinanceiro.Create(Self);
end;

procedure TFr_Fin_Edita.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F4 : if SB_Gravar.Enabled then SB_GravarClick(Sender);
      VK_F5 : if Sb_Cancelar.Enabled then Sb_CancelarClick(Sender);
    end;
    end;
end;

procedure TFr_Fin_Edita.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Fin_Edita.Pc_AtivarTabelas;
Begin
  Fm_FormaPagto.Pc_Listar(3,False,0);
end;

procedure TFr_Fin_Edita.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_AtivarTabelas;
  Financeiro.getById;
  Pc_Preenche_Campos;
end;

procedure TFr_Fin_Edita.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    END;
end;

procedure TFr_Fin_Edita.Pc_Preenche_Campos;
Begin
  with Financeiro do
  Begin
    with Registro do
    Begin
      //Preeche campos na interface
      E_Data_Venc.Date := DataVencimento;
      E_N_Parcela.Text := NumeroDuplicata;
      E_Vl_PARCELA.Text := FloatToSTrF(ValorParcela,ffFixed,10,2);
      Fm_FormaPagto.DBLCB_FormaPagto.KeyValue := FormaPagamento;
      E_Dt_Reprogramacao.Date := Reprogramacao;
      E_Aliq_Desconto.Text := FloatToStrF(AliquotaDesconto,ffFixed,10,2);
      E_DataLimite.Date := DataLimite;
      E_condicoesEspeciais.Text := CondicoesEspeciais;
    End;
  End;
  Qr_Obs_Nfe.Active := false;
  Qr_Obs_Nfe.ParamByName('OBN_CODNFL').AsInteger := Financeiro.Registro.CodigoNota;
  Qr_Obs_Nfe.Active := True;
  if (Qr_Obs_Nfe.RecordCount >0 ) then
    E_Obs.Text := Qr_Obs_Nfe.FieldByName('OBN_DETALHE').AsString
  else
    E_Obs.Clear;
end;

procedure TFr_Fin_Edita.SB_GravarClick(Sender: TObject);
Var
  Lc_FormaPagto : TControllerFormaPagamento;
  TipoEdicao : String;
begin
  //Gravar O financeiro
  with Financeiro do
  Begin
    with Registro do
    Begin
      //Registra log de Operações
      IF ( NumeroDuplicata <> E_N_Parcela.Text ) then
        Pc_Log_Sistema(Gb_CodMha, Gb_Cd_Usuario, (Now), 'Editar Registro do Financeiro', Codigo,'Alteracao de Parcela ', 'Parcela Anterior:'+ NumeroDuplicata + ' para Parcela:' + E_N_Parcela.Text);
      if ( DataVencimento <> E_Data_Venc.Date ) then
        Pc_Log_Sistema(Gb_CodMha, Gb_Cd_Usuario, (Now), 'Editar Registro do Financeiro', Codigo,'Alteracao Data Venc. ', 'Data Venc. Anterior:'+ DateToStr(DataVencimento) + ' para Data Venc' + DateToStr(E_Data_Venc.Date));
      if (ValorParcela <> StrToFloatDef(E_Vl_PARCELA.Text,0) ) then
        Pc_Log_Sistema(Gb_CodMha, Gb_Cd_Usuario, (Now), 'Editar Registro do Financeiro', Codigo,'Alteracao do Valor ', 'Valor Anterior:'+ FloatToStrF(ValorParcela,ffFixed,10,2) + ' para valor:' + E_Vl_PARCELA.Text);
      if (FormaPagamento <> Fm_FormaPagto.DBLCB_FormaPagto.KeyValue ) then
      Begin
        Lc_FormaPagto := TControllerFormaPagamento.create(Self);
        Lc_FormaPagto.Registro.Codigo := FormaPagamento;
        Lc_FormaPagto.getById;
        Pc_Log_Sistema(Gb_CodMha, Gb_Cd_Usuario, (Now), 'Editar Registro do Financeiro', Codigo,'Alteracao Forma de pagamento. ', 'Forma Pag. Anterior:'+ IntToStr(FormaPagamento)+ ' para Forma Pag:' + Fm_FormaPagto.DBLCB_FormaPagto.Text);
      End;

      DataVencimento := E_Data_Venc.Date;
      NumeroDuplicata := E_N_Parcela.Text;
      ValorParcela := StrToFloatDef(E_Vl_PARCELA.Text,0);
      FormaPagamento := Fm_FormaPagto.DBLCB_FormaPagto.KeyValue;
      AliquotaDesconto := StrToFloatDef(E_Aliq_Desconto.Text,0);
      Reprogramacao := E_Dt_Reprogramacao.DateTime;
      DataLimite := E_DataLimite.Date;
      CondicoesEspeciais := E_condicoesEspeciais.Text;
    End;
    salva;
  End;
  IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
  //verifica se há um observação.
  Qr_Obs_Nfe.Active := False;
  Qr_Obs_Nfe.ParamByName('OBN_CODNFL').AsInteger := Financeiro.Registro.CodigoNota;
  Qr_Obs_Nfe.Active := True;
  Qr_Obs_Nfe.FetchAll;
  //Se encontrar Edita a Observação
  if Length(Trim(E_Obs.Text)) > 0 then
  Begin
    IF (Qr_Obs_Nfe.RecordCount > 0) then
      TipoEdicao := 'E'
    else
      TipoEdicao := 'I';
    Pc_Observacao(DM.IB_Transacao,
                  TipoEdicao,
                  Qr_Obs_Nfe.FieldByName('OBN_CODIGO').AsInteger,
                  0,
                  Financeiro.Registro.CodigoNota,
                  'M',
                  E_Obs.Text);
  End;
  IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
  IF Assigned(Fr_Receber_Multipla) then Fr_Receber_Multipla.SB_BuscarClick(Self);
  close;
end;

procedure TFr_Fin_Edita.Sb_CancelarClick(Sender: TObject);
begin
  //Cancelar
  Close;
end;

procedure TFr_Fin_Edita.sb_obs_nfeClick(Sender: TObject);
begin
  if not Assigned(fr_obs_nfe) then Application.CreateForm(tfr_obs_nfe,fr_obs_nfe);
  fr_obs_nfe.it_cd_nfl:= Financeiro.Registro.CodigoNota;
  fr_obs_nfe.showmodal
end;

end.
