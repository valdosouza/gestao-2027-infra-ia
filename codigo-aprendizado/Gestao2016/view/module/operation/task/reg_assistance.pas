unit reg_assistance;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.ComCtrls, Un_Fm_ListaSituacao, Datasnap.DBClient, ControllerAssistencia, Un_Fm_ListaEmpresas, Un_Fm_ListaClientes;

type
  TRegAssistance = class(TBaseRegistry)
    Pnl_Abertura: TPanel;
    L_Prazo: TLabel;
    Label1: TLabel;
    Lb_Numero: TLabel;
    L_NumeroPedido: TLabel;
    E_Prazo: TDateTimePicker;
    E_Pedido: TEdit;
    GroupBox1: TGroupBox;
    DBG_Produtos: TDBGrid;
    grp_etapas: TGroupBox;
    L_Etapa: TLabel;
    L_DataRegistro: TLabel;
    L_DataPrevista: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    E_Etapa: TEdit;
    E_Dt_Registro: TDateTimePicker;
    E_Descritivo: TMemo;
    E_Vl_Custo: TEdit;
    E_Vl_Cliente: TEdit;
    E_Dt_Realizada: TMaskEdit;
    E_Dt_Prevista: TDateTimePicker;
    E_Hr_Prevista: TEdit;
    Fm_ListaSituacao: TFm_ListaSituacao;
    SB_Imprimir: TSpeedButton;
    SB_Faturar: TSpeedButton;
    cds_itens: TClientDataSet;
    ds_itens: TDataSource;
    cds_itensIAS_CODIGO: TIntegerField;
    cds_itensIAS_CODASS: TIntegerField;
    cds_itensIAS_ETAPA: TIntegerField;
    cds_itensIAS_DATA: TDateField;
    cds_itensIAS_DESCRITIVO: TMemoField;
    cds_itensIAS_DT_PREVISTA: TDateField;
    cds_itensIAS_VL_CLIENTE: TBCDField;
    cds_itensIAS_VL_CUSTO: TBCDField;
    cds_itensIAS_DT_REALIZADA: TDateField;
    cds_itensSIT_DESCRICAO: TStringField;
    cds_itensIAS_CODSIT: TIntegerField;
    cds_itensIAS_HOUR: TStringField;
    Fm_ListaClientes: TFm_ListaClientes;
    procedure SB_ImprimirClick(Sender: TObject);
    procedure SB_FaturarClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
  private
    function getNextEtapa:Integer;
    procedure Imp_Mod_Genio;
    procedure Imp_Mod_Balanca_Pinhais;

  protected
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure ImagemBotao;Override;
    procedure FormataTela;Override;
    procedure setPerfil;Override;
    //Teclas de atalhos
    procedure execShorCutKeyF10;Override;
    procedure execShorCutKeyF11;Override;

    procedure ShowData;Override;
    procedure ShowDataMain;
    procedure ShowDataItensList;
    procedure ShowDataItens;
    procedure ShowNoData;Override;
    procedure ShowNoDataItens;
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
    procedure SaveAssistencia;
    procedure SaveAssistenciaItens;
    procedure Save;Override;
    //Cancelar
    function ValidateCancel():boolean;Override;
    procedure Cancel;Override;

    procedure EditionControl;Override;

  public
    Assistencia : TControllerAssistencia;
  end;

var
  RegAssistance: TRegAssistance;

implementation

{$R *.dfm}

uses     env, UN_MSG, UN_RL_Assistencia, Un_RL_ReportAssistencia_BalancaPinhais, UN_Lanca_Pagto, UN_Sistema;

{ TBaseRegistry1 }

procedure TRegAssistance.Cancel;
begin
  ClearAllFields;
end;

procedure TRegAssistance.Change;
begin
  inherited;
  E_Dt_Registro.SetFocus;
end;

procedure TRegAssistance.ClearAllFields;
begin
  inherited;
end;

procedure TRegAssistance.CriarVariaveis;
begin
  inherited;
  Assistencia := TControllerAssistencia.Create(self);
end;

procedure TRegAssistance.Delete;
begin
  Assistencia.Itens.Registro.Codigo := cds_itensIAS_CODIGO.AsInteger;
  Assistencia.Itens.delete;
  ShowNoDataItens;
end;

procedure TRegAssistance.EditionControl;
begin
  inherited;
  Pnl_Abertura.Enabled := (( EditionState = 'I' ) or ( EditionState = 'E' ) ) and (Assistencia.Registro.Codigo = 0 );
  grp_etapas.Enabled := (( EditionState = 'I' ) or ( EditionState = 'E' ) ) ;
  SB_Imprimir.Enabled := ( EditionState = 'B' ) and ( CodigoRegistro > 0 );
  SB_Faturar.Enabled := ( EditionState = 'B' ) and ( CodigoRegistro > 0 );
end;

procedure TRegAssistance.execShorCutKeyF10;
begin
  inherited;

end;

procedure TRegAssistance.execShorCutKeyF11;
begin
  inherited;

end;

procedure TRegAssistance.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(Assistencia);
end;

procedure TRegAssistance.FormataTela;
begin
  inherited;

end;

function TRegAssistance.getNextEtapa: Integer;
begin
  if not cds_Itens.Active then cds_Itens.CreateDataSet;
  cds_itens.Last;
  Result := cds_itensIAS_ETAPA.AsInteger + 1;
end;

procedure TRegAssistance.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(SB_Faturar,'FATURAR');
  CarregaImagemBotao(SB_Imprimir,'IMPRIMIR');
end;

procedure TRegAssistance.Imp_Mod_Balanca_Pinhais;
Var
  Lc_form : TRL_ReportAssistencia_BalancaPinhais;
Begin
  Lc_form := TRL_ReportAssistencia_BalancaPinhais.Create(Self);
  Try
    Lc_form.CodigoAssistencia := Assistencia.Registro.Codigo;
    Lc_form.Qrpt.Preview;
  finally
    FreeAndNil(Lc_form);
  end;
end;

procedure TRegAssistance.Imp_Mod_Genio;
Var
  Lc_form : TRL_Assistencia;
begin
  Lc_form := TRL_Assistencia.create(self);
  Try
    Lc_form.It_Codigo := Assistencia.Registro.Codigo;
    Lc_form.Qrpt.Preview;
  finally
    FreeAndNil(Lc_form);
  end;

end;

procedure TRegAssistance.IniciaVariaveis;
begin
  Fm_ListaClientes.ListaClientes('');
  Fm_ListaSituacao.Modulo := 2;
  Fm_ListaSituacao.Listar;
  if Self.CodigoRegistro > 0 then
  Begin
    Assistencia.Registro.Codigo := Self.CodigoRegistro;
    Assistencia.Registro.CodMha := gb_Codmha;
    Assistencia.getByKey;
    Assistencia.Itens.Search;
    inherited;
  End
  else
  Begin
    ShowNoData;
    if cds_Itens.active then cds_Itens.EmptyDataSet;
    EditionState := 'I';
    EditionControl;
  End;

end;

procedure TRegAssistance.Insert;
begin
  ShowNoDataItens;
  if Pnl_Abertura.Enabled then
    E_Pedido.SetFocus
  else
    E_Dt_Registro.SetFocus;
end;

procedure TRegAssistance.Save;
begin
  SaveAssistencia;
  SaveAssistenciaItens;
  ShowDataItensList;
end;

procedure TRegAssistance.SaveAssistencia;
begin
  with Assistencia do
  Begin
    Registro.CodMha     := Gb_CodMha;
    Registro.Pedido     := StrToIntDef(E_Pedido.Text,0);
    Registro.Codemp     := Fm_ListaClientes.DBLCB_Empresa.KeyValue;
    Registro.Prazo      := E_Prazo.Date;
    Registro.SituacaoId := Fm_ListaSituacao.DBLCB_Situacao.KeyValue;
  End;
  Assistencia.save;
  CodigoRegistro := Assistencia.Registro.Codigo;
end;

procedure TRegAssistance.SaveAssistenciaItens;
begin
  with Assistencia.Itens do
  Begin
    Registro.Assistencia    := Assistencia.Registro.codigo;
    Registro.Etapa          := getNextEtapa;
    Registro.Data           := E_Dt_Registro.Date;
    Registro.Descritivo     := E_Descritivo.Text;
    Registro.DataPrevista   := E_Dt_Prevista.Date;
    Registro.ValorCliente   := StrToFloatDef(E_Vl_Cliente.Text,0);
    Registro.ValorCusto     := StrToFloatDef(E_Vl_Custo.Text,0);
    if (E_Dt_Realizada.Text <> '  /  /    ') then
      Registro.DataRealizada  := StrToDateDef(E_Dt_Realizada.Text,Date)
    else
      Registro.DataRealizada  := 0;
    Registro.SituacaoId     := Fm_ListaSituacao.DBLCB_Situacao.KeyValue;
    Registro.Hora           := E_Hr_Prevista.Text;
  End;
  Assistencia.Itens.save;
end;

procedure TRegAssistance.SB_ExcluirClick(Sender: TObject);
begin
  if ValidateDelete then
  Begin
    Delete;
    ShowDataItensList;
  End;
end;

procedure TRegAssistance.SB_FaturarClick(Sender: TObject);
Var
  Lc_form :TFr_Lanca_Pagto;
begin
  Lc_form := TFr_Lanca_Pagto.create(Self);
  Lc_form.Caption := 'Lançamento do Contas � Receber';
  Lc_form.Grb_Empresa.Caption := 'Cliente';
  Lc_form.It_Tipo_Fin := 'RM';
  Lc_form.It_Operacao := 'C';
  Try
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TRegAssistance.SB_ImprimirClick(Sender: TObject);
Var
  Lc_Tipo : Integer;
Begin
  Lc_Tipo := StrToIntDef(Fc_Aq_Geral('L','ASSISTENCIA TECNICA','ASS_P_MOD_LASER','1'),1);
  case  Lc_Tipo of
    1:Imp_Mod_Genio;
    2:Imp_Mod_Balanca_Pinhais;
    else
      Imp_Mod_Genio;
  end;
end;

procedure TRegAssistance.setPerfil;
begin
  pfMenu := 'Assistência T�cnica';
  inherited;
end;

procedure TRegAssistance.ShowData;
begin
  ShowDataMain;
  ShowDataItensList;
  ShowDataItens;
end;

procedure TRegAssistance.ShowDataItens;
Begin
  Assistencia.Itens.Registro.Codigo := cds_itensIAS_CODIGO.AsInteger;
  Assistencia.Itens.getByKey;
  if Assistencia.Itens.exist then
  Begin
    with Assistencia.Itens do
    Begin
      E_Etapa.Text := Registro.Etapa.ToString;
      E_Dt_Registro.DateTime := Registro.Data;
      E_Dt_Prevista.DateTime := Registro.DataPrevista;
      Fm_ListaSituacao.DBLCB_Situacao.KeyValue := Registro.SituacaoId;
      E_Vl_Custo.Text := FloatToStrF(Registro.ValorCusto,ffFixed,10,2);
      E_Vl_Cliente.Text := FloatToStrF(Registro.ValorCliente,ffFixed,10,2);
      E_Descritivo.Text := Registro.Descritivo;
      if Registro.DataRealizada > 0 then
      Begin
        E_Dt_Realizada.Text := DateToSTr(Registro.DataRealizada);
        E_Hr_Prevista.Text := Registro.Hora;
      End;
    End;
  End
  else
  Begin
    ShowNoDataItens;
  End;
end;

procedure TRegAssistance.ShowDataItensList;
var
  i: Integer;
begin
  Assistencia.ITens.Parametros.FieldName.Assistencia := Assistencia.Registro.codigo;
  Assistencia.Itens.Search;
  if not cds_Itens.Active then
    cds_Itens.CreateDataSet;

  cds_Itens.EmptyDataSet;

  for i := 0 to Pred(Assistencia.Itens.Lista.Count) do
    cds_Itens.AppendRecord([Assistencia.Itens.Lista[I].Codigo,
                            Assistencia.Itens.Lista[I].Assistencia,
                            Assistencia.Itens.Lista[I].Etapa,
                            Assistencia.Itens.Lista[I].Data,
                            Assistencia.Itens.Lista[I].Descritivo,
                            Assistencia.Itens.Lista[I].DataPrevista,
                            Assistencia.Itens.Lista[I].ValorCliente,
                            Assistencia.Itens.Lista[I].ValorCusto,
                            Assistencia.Itens.Lista[I].DataRealizada,
                            Assistencia.Itens.Lista[I].SituacaoDesc,
                            Assistencia.Itens.Lista[I].SituacaoId,
                            Assistencia.Itens.Lista[I].Hora ]);
  cds_Itens.First;

end;

procedure TRegAssistance.ShowDataMain;
begin
  with Assistencia do
  Begin
    Lb_Numero.Caption := Registro.Numero.ToString();
    E_Pedido.Text := Registro.Pedido.ToString();
    Fm_ListaClientes.E_Cd_Empresa.Text := Registro.Codemp.ToString;
    Fm_ListaClientes.DBLCB_Empresa.KeyValue := Registro.Codemp;
    E_Prazo.Date := Registro.Prazo;
  End;

end;

procedure TRegAssistance.ShowNoData;
begin
  inherited;
  Lb_Numero.Caption := '';
  E_Pedido.Clear;
  Fm_ListaClientes.E_Cd_Empresa.Clear;
  Fm_ListaClientes.DBLCB_Empresa.KeyValue := Null;
  E_Prazo.DateTime := Date;
  ShowNoDataItens;
end;

procedure TRegAssistance.ShowNoDataItens;
begin
  Assistencia.Itens.clear;
  E_Etapa.clear;
  E_Dt_Registro.DateTime := Date;
  E_Dt_Prevista.DateTime := Date;
  Fm_ListaSituacao.DBLCB_Situacao.KeyValue := 0;
  E_Vl_Custo.Text := '0,00';
  E_Vl_Cliente.Text := '0,00';
  E_Descritivo.Lines.Clear;
  E_Dt_Realizada.Clear;
  E_Hr_Prevista.Clear;
end;

function TRegAssistance.ValidaInsert: boolean;
begin
  Result := True;
end;

function TRegAssistance.ValidateCancel: boolean;
begin
  Result := True;
end;

function TRegAssistance.ValidateChange: boolean;
begin
  Result := True;

end;

function TRegAssistance.ValidateDelete: boolean;
begin
  Result := True;
  if cds_itens.RecordCount = 0 then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Nenhum registro encontrato .',
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  End;
  if (not TMsgSetes.Excluir) then
  Begin
    Result := False;
    exit;
  End;
end;

function TRegAssistance.ValidateSave: boolean;
begin
  Result := True;
  if ( Assistencia.Registro.Codigo = 0 ) then
  Begin
    if ( MensagemPadrao(TITULO_CONFIRMACAO,
                       '           Tem certeza que deseja Registrar este Chamado?'+EOLN+
                       'Apos a confirmção não será mais possivel editar os dados de Abertura.'+EOLN+
                      'Confirmar a abertura do Chamado ?',
                  [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao2) then
    begin
      Result := False;
      Exit;
    end;
  End;

  if trim(Fm_ListaClientes.DBLCB_Empresa.Text) = EmptyStr then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Cliente da Assistência não informado.'+EOLN+
                   'Preencha o Cliente da Assitencia.'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Fm_ListaClientes.DBLCB_Empresa.SetFocus;
    Result := False;
    exit;
  end;

  if trim(Fm_ListaSituacao.DBLCB_Situacao.Text) = EmptyStr then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Situção do Item não informado.'+EOLN+
                   'Preencha a situção do Item da Assitencia.'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Fm_ListaSituacao.DBLCB_Situacao.SetFocus;
    Result := False;
    exit;
  end;

end;

end.
