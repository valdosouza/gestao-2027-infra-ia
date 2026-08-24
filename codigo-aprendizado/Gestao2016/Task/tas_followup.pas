unit tas_followup;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Datasnap.DBClient, Datasnap.Provider, ControllerFollowup, base_registry;


type
  TTasFollowup = class(TBaseRegistry)
    pnl_Botton: TPanel;
    Pnl_Body: TPanel;
    DBGrid1: TDBGrid;
    Dtp_Prevista: TDateTimePicker;
    Dtp_Conclusao: TDateTimePicker;
    Label36: TLabel;
    Label1: TLabel;
    E_Obs: TMemo;
    ChBx_Conclusao: TCheckBox;
    Cds_Pesquisa: TClientDataSet;
    Ds_Pesquisa: TDataSource;
    Cds_PesquisaTB_INSTITUTION_ID: TIntegerField;
    Cds_PesquisaTERMINAL: TIntegerField;
    Cds_PesquisaTB_ORDER_ID: TIntegerField;
    Cds_PesquisaID: TIntegerField;
    Cds_PesquisaPROCESS: TWideStringField;
    Cds_PesquisaDT_RECORD: TDateTimeField;
    Cds_PesquisaDT_FORECAST: TDateField;
    Cds_PesquisaDETAIL: TBlobField;
    Cds_PesquisaDONE: TWideStringField;
    Cds_PesquisaDT_DONE: TStringField;
    procedure Cds_PesquisaDETAILGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure ChBx_ConclusaoClick(Sender: TObject);
    procedure posicionaregistro(DataSet: TDataSet);
  private
    { Private declarations }
    procedure FillListFollowUp;
    procedure SaveDataSet;
    procedure LimpaCampos;
  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure ImagemBotao;Override;

    procedure ShowData;Override;
    procedure ShowNoData;Override;
    procedure ClearAllFields;Override;
    //inserir
    function ValidaInsert():boolean;Override;
    procedure Insert;Override;
    //Editar
    function ValidateChange():boolean;Override;
    procedure Change;Override;
    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;

    //Cancelar

    procedure EditionControl;Override;

  public
    { Public declarations }
    Followup : TControllerFollowup;
  end;

var
  TasFollowup: TTasFollowup;

implementation

{$R *.dfm}

uses     UN_Principal, env, UN_Sistema, Un_Msg, Un_DM;


procedure TTasFollowup.Cds_PesquisaDETAILGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := Sender.Asstring;
end;

procedure TTasFollowup.Change;
begin
  E_Obs.SetFocus;
end;

procedure TTasFollowup.ChBx_ConclusaoClick(Sender: TObject);
begin
  inherited;
  Dtp_Conclusao.Visible := ChBx_Conclusao.Checked;
end;

procedure TTasFollowup.ClearAllFields;
begin
  inherited;

end;

procedure TTasFollowup.CriarVariaveis;
begin
  inherited;
  Followup := TControllerFollowup.Create(Self);
  LimpaCampos;
end;

procedure TTasFollowup.Delete;
begin
  Followup.Registro.Estabelecimento := Cds_PesquisaTB_INSTITUTION_ID.AsInteger;
  Followup.Registro.Terminal        := Cds_PesquisaTERMINAL.AsInteger;
  Followup.Registro.Ordem           := Cds_PesquisaTB_ORDER_ID.AsInteger;
  Followup.Registro.Codigo          := Cds_PesquisaID.AsInteger;
  Followup.Registro.Processo        := Cds_PesquisaPROCESS.AsString;
  Followup.delete;
  Cds_Pesquisa.delete;
end;

procedure TTasFollowup.EditionControl;
begin
  inherited;
  pnl_Botton.Enabled :=  ( EditionState = 'I' ) or ( EditionState = 'E' );
end;

procedure TTasFollowup.FillListFollowUp;
Var
  I : Integer;
begin
  with Followup do
  Begin
    Registro.Estabelecimento  := Gb_CodMha;
    Registro.Terminal         := Gb_Terminal;
    Registro.Ordem            := CodigoRegistro;
    Registro.Processo         := 'TB_PEDIDO';
    getlist;
    if not cds_Pesquisa.active then cds_Pesquisa.CreateDataSet;
    cds_Pesquisa.LogChanges := False;
    cds_Pesquisa.EmptyDataSet;

    for I := 0 to Lista.Count -1 do
    Begin
      cds_Pesquisa.Append;
      Cds_PesquisaTB_INSTITUTION_ID.AsInteger := Lista[I].Estabelecimento;
      Cds_PesquisaTERMINAL.AsInteger          := Lista[I].Terminal;
      Cds_PesquisaTB_ORDER_ID.AsInteger       := Lista[I].Ordem;
      Cds_PesquisaID.AsInteger                := Lista[I].Codigo;
      Cds_PesquisaPROCESS.AsString            := Lista[I].Processo;
      Cds_PesquisaDT_RECORD.AsDateTime        := Lista[I].Data;
      Cds_PesquisaDT_FORECAST.AsDateTime      := Lista[I].DataPrevista;
      if Lista[I].Finalizada = 'S' then
        Cds_PesquisaDT_DONE.AsString          := DateToStr( Lista[I].DataRealizada )
      else
        Cds_PesquisaDT_DONE.AsString          := '';
      Cds_PesquisaDETAIL.AsString             := Lista[I].Detalhes;
      Cds_PesquisaDONE.AsString               := Lista[I].Finalizada;
      Cds_Pesquisa.Post;
    End;
    Cds_Pesquisa.LogChanges := True;
  End;
end;

procedure TTasFollowup.ImagemBotao;
begin
  CarregaImagemBotao(SB_Inserir,'INSERIR');
  CarregaImagemBotao(SB_Alterar,'ALTERAR');
  CarregaImagemBotao(SB_Excluir,'EXCLUIR');
  CarregaImagemBotao(SB_Gravar,'GRAVAR');
  CarregaImagemBotao(SB_Cancelar,'CANCELAR');
  CarregaImagemBotao(Sb_Sair_0,'SAIR');
end;

procedure TTasFollowup.IniciaVariaveis;
begin
  inherited;
  Dtp_Prevista.DateTime := Date;
  Dtp_Conclusao.DateTime := Date;
  FillListFollowUp;
  Cds_Pesquisa.AfterScroll := posicionaregistro;
  Cds_Pesquisa.First;
end;

procedure TTasFollowup.Insert;
begin
  Cds_Pesquisa.AfterScroll := nil;
  LimpaCampos;
  E_Obs.SetFocus;
end;

procedure TTasFollowup.LimpaCampos;
begin
  Followup.Clear;
  Dtp_Prevista.Date := Date;
  Dtp_Conclusao.Date := Date;
  ChBx_Conclusao.Checked := False;
  E_Obs.Clear;
end;

procedure TTasFollowup.posicionaregistro(DataSet: TDataSet);
begin
  with Followup.Registro, Cds_Pesquisa do
  Begin
    Estabelecimento := fieldByname('TB_INSTITUTION_ID').AsInteger;
    Terminal        := fieldByname('TERMINAL').AsInteger;
    Ordem           := fieldByname('TB_ORDER_ID').AsInteger;
    Codigo          := fieldByname('ID').AsInteger;
    Processo        := fieldByname('PROCESS').AsString;
  End;
  Followup.getbyKey;

  ShowData;
  EditionState := 'B';
  EditionControl;
end;

procedure TTasFollowup.Save;
begin
  Cds_Pesquisa.AfterScroll := nil;
  SaveDataSet;
  with Followup.Registro do
  Begin
    Estabelecimento := Cds_PesquisaTB_INSTITUTION_ID.AsInteger;
    Terminal        := Cds_PesquisaTERMINAL.AsInteger;
    Ordem           := Cds_PesquisaTB_ORDER_ID.AsInteger;
    Codigo          := Cds_PesquisaID.AsInteger;
    Processo        := Cds_PesquisaPROCESS.AsString;
    Data            := Cds_PesquisaDT_RECORD.AsDateTime;
    DataPrevista    := Cds_PesquisaDT_FORECAST.AsDateTime;
    if Cds_PesquisaDONE.AsString = 'S' then
    Begin
      DataRealizada := Cds_PesquisaDT_DONE.AsDateTime;
      Finalizada    := 'S';
    End
    else
    Begin
      Finalizada    := 'N';
    End;
    Detalhes := E_Obs.Text;
  End;
  Followup.salva;
  Cds_Pesquisa.AfterScroll := posicionaregistro;
end;

procedure TTasFollowup.SaveDataSet;
begin
  if not Cds_Pesquisa.Active then Cds_Pesquisa.CreateDataSet;
  if EditionState = 'E' then
    Cds_Pesquisa.edit
  else
  Begin
    Cds_Pesquisa.Append;
    Cds_PesquisaTB_INSTITUTION_ID.AsInteger := Gb_CodMha;
    Cds_PesquisaTERMINAL.AsInteger          := Gb_Terminal;
    Cds_PesquisaTB_ORDER_ID.AsInteger       := CodigoRegistro;
    Cds_PesquisaID.AsInteger                := 0;
  End;
  Cds_PesquisaPROCESS.AsString            := Followup.Registro.Processo;
  Cds_PesquisaDT_RECORD.AsDateTime        := Date;
  Cds_PesquisaDT_FORECAST.AsDateTime      := Dtp_Prevista.DateTime;
  Cds_PesquisaPROCESS.AsString            := 'TB_PEDIDO';
  if ChBx_Conclusao.Checked then
  Begin
    Cds_PesquisaDT_DONE.AsDateTime          := Dtp_Conclusao.DateTime;
    Cds_PesquisaDONE.AsString               := 'S';
  End
  else
  Begin
    Cds_PesquisaDT_DONE.AsString          := '';
    Cds_PesquisaDONE.AsString               := 'N';
  End;
  Cds_PesquisaDETAIL.AsString             := E_Obs.Text;
  Cds_Pesquisa.POST;
end;

procedure TTasFollowup.ShowData;
begin
  inherited;
  Dtp_Prevista.DateTime := Followup.Registro.DataPrevista;
  E_Obs.Text            := Followup.Registro.Detalhes;
  if Followup.Registro.Finalizada = 'S' then
  Begin
    Dtp_Conclusao.Visible := True;
    Dtp_Conclusao.DateTime := Followup.Registro.DataRealizada;
    ChBx_Conclusao.Checked := True;
  End
  else
  Begin
    Dtp_Conclusao.Visible := False;
    ChBx_Conclusao.Checked := False;
  End;
end;

procedure TTasFollowup.ShowNoData;
begin
  inherited;

end;

function TTasFollowup.ValidaInsert: boolean;
begin
  Result := True;

end;

function TTasFollowup.ValidateChange: boolean;
begin
  Result := True;
end;

function TTasFollowup.ValidateDelete: boolean;
begin
  Result := True;
  if  Cds_Pesquisa.RecordCount = 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não há registro para excluir.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result:=false;
    exit;
  End;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o registro de Atual?' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
  Begin
    Result:=false;
    exit;
  End;
end;

function TTasFollowup.ValidateSave: boolean;
begin
  Result := True;
  if Length(E_Obs.Text)<10 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Informe o detalhe da Tarefa com no minimo 10 caracteres.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    if E_Obs.CanFocus then E_Obs.SetFocus;
    Result:=false;
    exit;
  End;

end;

end.
