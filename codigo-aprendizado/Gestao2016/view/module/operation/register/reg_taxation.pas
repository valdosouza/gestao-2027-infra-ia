unit reg_taxation;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Menus, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Classes, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, System.StrUtils, Data.DB, STQuery, base_registry, ControllerTributacao, un_dm, Un_Fm_ListaEstados, base_frame_list;

type
  TRegTaxation = class(TBaseRegistry)
    pl_fundo: TPanel;
    L_Aq_ICMS: TLabel;
    L_Red_Base: TLabel;
    L_Observacao: TLabel;
    Sb_Observacao: TSpeedButton;
    L_Red_Aliq: TLabel;
    L_Natureza: TLabel;
    SB_Natureza: TSpeedButton;
    L_Origem: TLabel;
    E_Aq_ICMS: TEdit;
    E_Red_Base: TEdit;
    E_Red_Aliq: TEdit;
    Pnl_Outros: TGroupBox;
    L_Transacao_Produto: TLabel;
    L_CodigoNCM: TLabel;
    Sb_Classificacao: TSpeedButton;
    chbx_sit_trb: TCheckBox;
    chbx_Consumidor: TCheckBox;
    chbx_micro: TCheckBox;
    chbx_diferido: TCheckBox;
    chbx_destaque: TCheckBox;
    CHBX_ST_ICMS: TCheckBox;
    Cb_Transacao_Produto: TComboBox;
    E_CodigoNCM: TEdit;
    Chbx_Sentido: TCheckBox;
    Pg_Outros: TPageControl;
    tbs_ipi: TTabSheet;
    Panel2: TPanel;
    L_Aq_IPI: TLabel;
    L_Situacao_tributaria_IPI: TLabel;
    Sb_Sit_Trib_IPI: TSpeedButton;
    E_Aq_IPI: TEdit;
    tbs_pis: TTabSheet;
    Panel3: TPanel;
    L_Aq_PIS: TLabel;
    L_Situacao_tributaria_PIS: TLabel;
    Sb_Sit_Trib_PIS: TSpeedButton;
    E_Aq_Pis: TEdit;
    tbs_cofins: TTabSheet;
    Panel4: TPanel;
    L_Aq_Cofins: TLabel;
    L_Situacao_tributaria_CFS: TLabel;
    Sb_Sit_Trib_CFS: TSpeedButton;
    E_Aq_Cofins: TEdit;
    tbs_outros: TTabSheet;
    Panel5: TPanel;
    L_Aq_IRPJ: TLabel;
    L_Aq_CSLL: TLabel;
    L_Aq_Siscomex: TLabel;
    L_Aq_Tec: TLabel;
    L_Aq_ISS: TLabel;
    L_AQ_AFRMM: TLabel;
    E_Aq_IRPJ: TEdit;
    E_Aq_CSLL: TEdit;
    E_Aq_Siscomex: TEdit;
    E_Aq_Tec: TEdit;
    E_Aq_ISS: TEdit;
    E_AQ_AFRMM: TEdit;
    Cb_Origem: TComboBox;
    Chbx_Red_Base_ST: TCheckBox;
    Sb_Sit_Trib_ICMS: TSpeedButton;
    Sb_Sit_Trib_CSOSN: TSpeedButton;
    Sb_Modal_ICMS_St: TSpeedButton;
    Dblcb_Modal_ICMS_ST: TDBLookupComboBox;
    Dblcb_Situacao_tributaria: TDBLookupComboBox;
    L_Situacao_tributaria: TLabel;
    L_Simples_Nacional: TLabel;
    Dblcb_Simples_Nacional: TDBLookupComboBox;
    L_Modal_ICMS: TLabel;
    Dblcb_Modal_ICMS: TDBLookupComboBox;
    L_Modal_ICMS_ST: TLabel;
    Sb_Modal_ICMS: TSpeedButton;
    Sb_Desoneracao: TSpeedButton;
    Dblcb_Desoneracao: TDBLookupComboBox;
    L_Desoneracao: TLabel;
    Dblcb_Situacao_tributaria_IPI: TDBLookupComboBox;
    Dblcb_Situacao_tributaria_PIS: TDBLookupComboBox;
    Dblcb_Situacao_tributaria_CFS: TDBLookupComboBox;
    qr_Desoneracao: TSTQuery;
    Ds_Desoneracao: TDataSource;
    Fm_ListaEstados: TFm_ListaEstados;
    DBLCB_Natureza: TDBLookupComboBox;
    DBLCB_Observacao: TDBLookupComboBox;
    Label1: TLabel;
    E_Aliq_Diferida: TEdit;
    AplicarReformaTributria1: TMenuItem;
    VisualizarReformatributria1: TMenuItem;
    procedure Sb_Sit_Trib_ICMSClick(Sender: TObject);
    procedure Sb_Sit_Trib_CSOSNClick(Sender: TObject);
    procedure Sb_Modal_ICMSClick(Sender: TObject);
    procedure Sb_Modal_ICMS_StClick(Sender: TObject);
    procedure Sb_DesoneracaoClick(Sender: TObject);
    procedure SB_NaturezaClick(Sender: TObject);
    procedure Fm_ListaEstadosDblcb_ListaExit(Sender: TObject);
    procedure Sb_ObservacaoClick(Sender: TObject);
    procedure AplicarReformaTributria1Click(Sender: TObject);
    procedure VisualizarReformatributria1Click(Sender: TObject);

  private
    taxation : TControllerTributacao;

    qr_Situacao_tributaria: TSTQuery;
    ds_Situacao_tributaria: TDataSource;
    qr_Simples_Nacional: TSTQuery;
    ds_Simples_Nacional: TDataSource;
    qr_ICMS: TSTQuery;
    ds_ICMS: TDataSource;
    qr_ICMS_ST: TSTQuery;
    ds_ICMS_ST: TDataSource;
    qr_IPI: TSTQuery;
    ds_IPI: TDataSource;
    qr_PIS: TSTQuery;
    ds_PIS: TDataSource;
    qr_CFS: TSTQuery;
    ds_CFS: TDataSource;

    qr_obs: TSTQuery;
    ds_obs: TDataSource;

    ds_Natureza: TDataSource;

    It_Cd_CRT : Integer;
    FProduto: Integer;
    FEmpresa: Integer;
    function ValidaAplicaReformaTriubutaria:boolean;
    procedure AplicaReformaTriubutaria;
    function  ValidaVisualizarReformaTributaria:boolean;
    procedure VisualizarReformaTributaria;

    procedure carregar_Situacao_tributaria;
    procedure carregar_Simples_Nacional;
    procedure carregar_ICMS;
    procedure carregar_ICMS_ST;
    procedure carregar_IPI;
    procedure carregar_PIS;
    procedure carregar_CFS;
    procedure carregar_Obs;

    function Fc_VerificaRegraExistente: Boolean;
    procedure setFEmpresa(const Value: Integer);
    procedure setFProduto(const Value: Integer);
  protected
    procedure setPerfil;Override;
    procedure formataTela;override;
    procedure ClearAllFields; Override;
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure ShowData; Override;
    procedure ShowNoData; Override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;
    procedure EditionControl;Override;
  public
    property Produto : Integer read FProduto write setFProduto;
    property Empresa :Integer read FEmpresa write setFEmpresa;
  end;

var
  RegTaxation: TRegTaxation;

implementation

uses     UN_MSG, env, un_sistema, un_regra_negocio, sea_tax_icms_sn, sea_tax_icms_nr, sea_cfop, sea_note, sea_tax_mode_det_bc_icms, sea_tax_mode_det_bc_icms_st, sea_tax_relieves_icms, sea_taxes, reg_taxes;
{$R *.dfm}

procedure TRegTaxation.CriarVariaveis;
begin
  inherited;
  Pc_AtivaEstabelecimento;
  It_Cd_CRT := StrToIntDef(DM.Qr_Estabelecimento.FieldByname('EMP_CRT').AsString,3);

  FEmpresa := 0;
  FProduto := 0;
  taxation := TControllerTributacao.create(self);

  qr_Situacao_tributaria := taxation.GeraQuery;
  ds_Situacao_tributaria := TDataSource.Create(nil);

  qr_Simples_Nacional := taxation.GeraQuery;
  ds_Simples_Nacional := TDataSource.Create(nil);

  qr_ICMS := taxation.GeraQuery;
  ds_ICMS := TDataSource.Create(nil);

  qr_ICMS_ST := taxation.GeraQuery;
  ds_ICMS_ST := TDataSource.Create(nil);

  qr_IPI := taxation.GeraQuery;
  ds_IPI := TDataSource.Create(nil);

  qr_PIS := taxation.GeraQuery;
  ds_PIS := TDataSource.Create(nil);

  qr_CFS := taxation.GeraQuery;
  ds_CFS := TDataSource.Create(nil);

  qr_obs := taxation.GeraQuery;
  ds_obs := TDataSource.Create(nil);

end;

procedure TRegTaxation.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(taxation);
  taxation.FinalizaQuery(qr_Situacao_tributaria);
  ds_Situacao_tributaria.Free;

  taxation.FinalizaQuery(qr_Simples_Nacional);
  ds_Simples_Nacional.Free;;

  taxation.FinalizaQuery(qr_ICMS);
  ds_ICMS.Free;

  taxation.FinalizaQuery(qr_ICMS_ST);
  ds_ICMS_ST.Free;

  taxation.FinalizaQuery(qr_IPI);
  ds_IPI.Free;

  taxation.FinalizaQuery(qr_PIS);
  ds_PIS.Free;

  taxation.FinalizaQuery(qr_CFS);
  ds_CFS.Free;

  taxation.FinalizaQuery(qr_obs);
  ds_obs.Free;


end;

procedure TRegTaxation.IniciaVariaveis;
begin
  carregar_Situacao_tributaria;
  carregar_Simples_Nacional;
  carregar_ICMS;
  carregar_ICMS_ST;
  qr_Desoneracao.Open;
  carregar_IPI;
  carregar_PIS;
  carregar_CFS;
  carregar_Obs;
  Fm_ListaEstados.Pc_Listar;
  Fm_ListaEstadosDblcb_ListaExit(Self);

  if Self.CodigoRegistro > 0 then
  Begin
    taxation.Registro.Codigo := Self.CodigoRegistro;
    taxation.getbyId;
  End;
  inherited;
end;

procedure TRegTaxation.Change;
begin
  inherited;
  Cb_Origem.SetFocus;
end;

procedure TRegTaxation.ClearAllFields;
begin
  inherited;
  taxation.clear;
end;

procedure TRegTaxation.Delete;
begin
  taxation.delete;
  inherited;
end;

procedure TRegTaxation.EditionControl;
begin
  inherited;
  if (It_Cd_CRT < 2) then
  Begin
    Dblcb_Situacao_tributaria.KeyValue := 0;
    Dblcb_Situacao_tributaria.Enabled := False;
    Dblcb_Simples_Nacional.Enabled := True;
  end
  else
  Begin
    Dblcb_Simples_Nacional.KeyValue := 0;
    Dblcb_Simples_Nacional.Enabled := False;
    Dblcb_Situacao_tributaria.Enabled := True;
  end
end;

procedure TRegTaxation.Insert;
Var
  Lc_escolha : Integer;
begin
  if taxation.Registro.Codigo > 0 then
  Begin
    Lc_escolha :=  (MensagemPadrao(TITULO_CONFIRMACAO,
                                   'Qual operção executar?'+EOLN+EOLN,
                                   ['Novo','C?pia','Cancelar'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
    case Lc_escolha of
      0:Begin
          inherited;
        end;
      1:Begin
          taxation.Registro.Codigo := 0;
          EditionState := 'I';
          EditionControl;
          ShowData;
        end;
      end;
  End
  else
    inherited;
end;

procedure TRegTaxation.Save;
begin
  with taxation do
  Begin
    Registro.Estabelecimento := Gb_CodMha;

    Registro.Origem := IntToStr(Cb_Origem.ItemIndex);
    if Dblcb_Situacao_tributaria.Text <>  EmptyStr then
      Registro.TribICMS_NR := Dblcb_Situacao_tributaria.KeyValue
    else
      Registro.TribICMS_NR := 0;

    if Dblcb_Simples_Nacional.Text > EmptyStr then
      Registro.TribICMS_SN := Dblcb_Simples_Nacional.KeyValue
    else
      Registro.TribICMS_SN := 0;

    Registro.DeterBC_ICMS_NR  := Dblcb_Modal_ICMS.KeyValue;
    if Dblcb_Modal_ICMS_ST.Text <> EmptyStr then
      Registro.DeterBC_ICMS_ST  := Dblcb_Modal_ICMS_ST.KeyValue
    else
      Registro.DeterBC_ICMS_ST  := 0;

    if Dblcb_Desoneracao.Text <> EmptyStr then
      Registro.Desoneracao      := Dblcb_Desoneracao.KeyValue
    else
      Registro.Desoneracao      := 0;

    Registro.AliqICMS     := StrToFloatDef(E_Aq_ICMS.Text, 0);
    Registro.RedAliqICMS  := StrToFloatDef(E_Red_Aliq.Text, 0);
    Registro.RedBCICMS    := StrToFloatDef(E_Red_Base.Text, 0);
    Registro.AliquotaDiferida := StrToFloatDef(E_Aliq_Diferida.Text, 0);

    Registro.PropRedBCST := IfThen(Chbx_Red_Base_ST.Checked, SIGLA_S, SIGLA_N);

    if (Dblcb_Situacao_tributaria_IPI.Text <> EmptyStr) then
      Registro.TribIPI := Dblcb_Situacao_tributaria_IPI.KeyValue
    else
      Registro.TribIPI := 0;
    Registro.AliqIPI := StrToFloatDef(E_Aq_IPI.Text, 0);

    if Dblcb_Situacao_tributaria_PIS.Text <> EmptyStr then
      Registro.TribPIS := Dblcb_Situacao_tributaria_PIS.KeyValue
    else
      Registro.TribPIS := 0;
    Registro.AliqPIS := StrToFloatDef(E_Aq_PIS.Text, 0);

    if Dblcb_Situacao_tributaria_CFS.Text <> EmptyStr then
      Registro.TribCofins := Dblcb_Situacao_tributaria_CFS.KeyValue
    else
      Registro.TribCofins := 0;
    Registro.AliqCofins := StrToFloatDef(E_Aq_COFINS.Text, 0);

    Registro.AliqIRPJ     := StrToFloatDef(E_Aq_IRPJ.Text, 0);
    Registro.AliqCSLL     := StrToFloatDef(E_Aq_CSLL.Text, 0);
    Registro.AliqSisComex := StrToFloatDef(E_Aq_Siscomex.Text, 0);
    Registro.AliqII       := StrToFloatDef(E_Aq_Tec.Text, 0);
    Registro.AliqISS      := StrToFloatDef(E_Aq_ISS.Text, 0);
    Registro.AliqAFRMM    := StrToFloatDef(E_AQ_AFRMM.Text, 0);

    Registro.TemST        := IfThen(chbx_sit_trb.Checked, SIGLA_S, SIGLA_N);
    Registro.Consumidor   := IfThen(chbx_Consumidor.Checked, SIGLA_S, SIGLA_N);
    Registro.MicroEmpresa := IfThen(chbx_micro.Checked, SIGLA_S, SIGLA_N);
    Registro.Diferido     := IfThen(chbx_diferido.Checked, SIGLA_S, SIGLA_N);
    Registro.Destacar     := IfThen(chbx_destaque.Checked, SIGLA_S, SIGLA_N);
    Registro.SubstitutoTributario := IfThen(CHBX_ST_ICMS.Checked, SIGLA_S, SIGLA_N);
    Registro.SentidoRegra := IfThen(Chbx_Sentido.Checked, 'E', 'S');

    Registro.TipoTransacaoProduto := IntToStr(Cb_Transacao_Produto.ItemIndex);
    Registro.Produto := FProduto;
    Registro.Empresa := FEmpresa;
    if Fm_ListaEstados.Dblcb_Lista.Text <> EmptyStr then
      Registro.Estado := Fm_ListaEstados.Dblcb_Lista.KeyValue
    else
      Registro.Estado := 0;
    Registro.NCM := E_CodigoNCM.Text;

    if DBLCB_Observacao.Text <> EmptyStr then
      Registro.Observacao := DBLCB_Observacao.KeyValue
    else
      Registro.Observacao := 0;

    Registro.CFOP := DBLCB_Natureza.KeyValue;

    salva;
  End;
  CodigoRegistro := taxation.Registro.Codigo;
end;

procedure TRegTaxation.ShowData;
begin
  with taxation do
  begin
    Cb_Origem.ItemIndex := StrToInt(Registro.Origem);
    Dblcb_Situacao_tributaria.KeyValue := Registro.TribICMS_NR;
    Dblcb_Simples_Nacional.KeyValue := Registro.TribICMS_SN;
    Dblcb_Modal_ICMS.KeyValue := Registro.DeterBC_ICMS_NR;
    Dblcb_Modal_ICMS_ST.KeyValue := Registro.DeterBC_ICMS_ST;
    Dblcb_Desoneracao.KeyValue := Registro.Desoneracao;

    E_Aq_ICMS.Text        := FloatToStrF( Registro.AliqICMS,ffFixed,10,2);
    E_Red_Aliq.Text       := FloatToStrF( Registro.RedAliqICMS,ffFixed,10,2);
    E_Red_Base.Text       := FloatToStrF( Registro.RedBCICMS,ffFixed,10,2);
    E_Aliq_Diferida.Text  := FloatToStrF( Registro.AliquotaDiferida,ffFixed,10,2);

    if Registro.PropRedBCST = SIGLA_S then
      Chbx_Red_Base_ST.Checked := True
    else
      Chbx_Red_Base_ST.Checked := False;

    Dblcb_Situacao_tributaria_IPI.KeyValue := Registro.TribIPI;
    E_Aq_IPI.Text := FloatToStr(Registro.AliqIPI);

    Dblcb_Situacao_tributaria_PIS.KeyValue := Registro.TribPIS;
    E_Aq_PIS.Text := FloatToStr(Registro.AliqPIS);

    Dblcb_Situacao_tributaria_CFS.KeyValue := Registro.TribCofins;
    E_Aq_COFINS.Text := FloatToStr(Registro.AliqCofins);

    E_Aq_IRPJ.Text := FloatToStr(Registro.AliqIRPJ);
    E_Aq_CSLL.Text := FloatToStr(Registro.AliqCSLL);
    E_Aq_Siscomex.Text := FloatToStr(Registro.AliqSisComex);
    E_Aq_Tec.Text := FloatToStr(Registro.AliqII);
    E_Aq_ISS.Text := FloatToStr(Registro.AliqISS);
    E_AQ_AFRMM.Text := FloatToStr(Registro.AliqAFRMM);

    chbx_sit_trb.Checked := Registro.TemST = SIGLA_S;

    chbx_Consumidor.Checked := Registro.Consumidor = SIGLA_S;

    chbx_micro.Checked := Registro.MicroEmpresa = SIGLA_S;

    chbx_diferido.Checked := Registro.Diferido = SIGLA_S;

    chbx_destaque.Checked := Registro.Destacar = SIGLA_S;

    CHBX_ST_ICMS.Checked := Registro.SubstitutoTributario = SIGLA_S;

    Chbx_Sentido.Checked := (Registro.SentidoRegra = 'E');

    Cb_Transacao_Produto.ItemIndex := StrtoIntDef(Registro.TipoTransacaoProduto,0);

    Fm_ListaEstados.Dblcb_Lista.KeyValue := Registro.Estado;
    Fm_ListaEstadosDblcb_ListaExit(Self);
    E_CodigoNCM.Text := Registro.NCM;

    DBLCB_Observacao.KeyValue := Registro.Observacao;
    DBLCB_Natureza.KeyValue := Registro.CFOP;
  end;
  inherited;
end;

procedure TRegTaxation.ShowNoData;
begin
//
end;

procedure TRegTaxation.Sb_DesoneracaoClick(Sender: TObject);
Var
  Form : TSeaTaxRelievesIcms;
begin
  Form := TSeaTaxRelievesIcms.Create(self);
  Try
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TRegTaxation.Sb_Modal_ICMSClick(Sender: TObject);
Var
  Form : TSeaTaxModeDetBcIcms;
begin
  Form := TSeaTaxModeDetBcIcms.Create(self);
  Try
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TRegTaxation.Sb_Modal_ICMS_StClick(Sender: TObject);
Var
  Form : TSeaTaxModeDetBcIcmsSt;
begin
  Form := TSeaTaxModeDetBcIcmsSt.Create(self);
  Try
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TRegTaxation.SB_NaturezaClick(Sender: TObject);
Var
  Form : TSeaCFOP;
begin
  Form := TSeaCFOP.Create(self);
  Try
    Form.ShowModal;
  Finally
    Fm_ListaEstadosDblcb_ListaExit(Self);
    FreeAndNil(Form);
  End;
end;

procedure TRegTaxation.Sb_ObservacaoClick(Sender: TObject);
Var
  Form : TSeaNote;
begin
  Form := TSeaNote.Create(self);
  Try
    Form.ShowModal;
  Finally
    carregar_Obs;
    FreeAndNil(Form);
  End;
end;

procedure TRegTaxation.Sb_Sit_Trib_CSOSNClick(Sender: TObject);
Var
  Form : TSeaTaxIcmsSn;
begin
  Form := TSeaTaxIcmsSn.Create(self);
  Try
    Form.ShowModal;
  Finally
    carregar_Simples_Nacional;
    FreeAndNil(Form);
  End;
end;

procedure TRegTaxation.Sb_Sit_Trib_ICMSClick(Sender: TObject);
Var
  Form : TSeaTaxIcmsNr;
begin
  Form := TSeaTaxIcmsNr.Create(self);
  Try
    Form.ShowModal;
    carregar_Situacao_tributaria;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TRegTaxation.setFEmpresa(const Value: Integer);
begin
  FEmpresa := Value;
end;

procedure TRegTaxation.setFProduto(const Value: Integer);
begin
  FProduto := Value;
end;

procedure TRegTaxation.setPerfil;
begin
  pfMenu := 'Tributação';
  inherited;
end;

function TRegTaxation.ValidaAplicaReformaTriubutaria: boolean;
begin
  Result := True;
  if Taxation.Registro.Codigo = 0 then
  Begin
    TMsgSetes.PararExecucao('Selecione uma regra de tributção antes de continuar');
    Result := False;
    exit;
  End;

  if (( EditionState = 'I' ) or ( EditionState = 'E' )) then
  Begin
    TMsgSetes.PararExecucao('Finalize a edição da regra de tributção antes de continuar');
    Result := False;
    exit;
  End;

end;

function TRegTaxation.ValidateDelete: boolean;
begin
  Result := True;
  if (not TMsgSetes.Excluir) then
  Begin
    Result := False;
    exit;
  End;
end;

procedure TRegTaxation.Fm_ListaEstadosDblcb_ListaExit(Sender: TObject);
begin
  if not Chbx_Sentido.Checked then
  Begin
    if (Fm_ListaEstados.Dblcb_Lista.Text = '') then
      Pc_Filtra_CFOP('S','N')
    else
    if (Fm_ListaEstados.Dblcb_Lista.KeyValue = Fc_Estado(Gb_CodMha,'S')) then
      Pc_Filtra_CFOP('S','E')
    else
    if (Fm_ListaEstados.Dblcb_Lista.Text = 'EX') then
      Pc_Filtra_CFOP('S','X')
    else
      Pc_Filtra_CFOP('S','N');
  end
  else
  Begin
    if (Fm_ListaEstados.Dblcb_Lista.Text = '') then
      Pc_Filtra_CFOP('E','N')
    else
    if (Fm_ListaEstados.Dblcb_Lista.KeyValue = Fc_Estado(Gb_CodMha,'S')) then
      Pc_Filtra_CFOP('E','E')
    else
    if (Fm_ListaEstados.Dblcb_Lista.Text = 'EX') then
      Pc_Filtra_CFOP('E','X')
    else
      Pc_Filtra_CFOP('E','N');
  end
end;

procedure TRegTaxation.formataTela;
begin

end;

function TRegTaxation.ValidateSave: boolean;
begin
  Result := True;
  Fm_ListaEstadosDblcb_ListaExit(Self);

  if (It_Cd_CRT  = 3) or (It_Cd_CRT  = 2) then
  begin
    if Trim(Dblcb_Situacao_tributaria.Text) = EmptyStr then
    begin
      TMsgSetes.ValidaPreenchimentoCampo(L_Situacao_tributaria.Caption);
      Result := False;
      Dblcb_Situacao_tributaria.SetFocus;
      Exit;
    end;
  end
  else
  begin
    if TRIM(Dblcb_Simples_Nacional.Text) = EmptyStr then
    begin
      TMsgSetes.ValidaPreenchimentoCampo(L_Simples_Nacional.Caption);
      Result := False;
      Dblcb_Simples_Nacional.SetFocus;
      Exit;
    end;
  end;

  if TRIM(Dblcb_Modal_ICMS.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Modal_ICMS.Caption);
    Dblcb_Modal_ICMS.SetFocus;
    Result := False;
    Exit;
  end;

  if chbx_sit_trb.Checked then
  Begin
    if TRIM(Dblcb_Modal_ICMS_ST.Text) = EmptyStr then
    begin
      TMsgSetes.ValidaPreenchimentoCampo(L_Modal_ICMS_ST.Caption);
      Dblcb_Modal_ICMS_ST.SetFocus;
      Result := False;
      Exit;
    end;
  end;

  if TRIM(DBLCB_Natureza.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Natureza.Caption);
    DBLCB_Natureza.SetFocus;
    Result := False;
    Exit;
  end;

  if (StrToFloatDef(E_Aq_IPI.Text,0) > 0 ) and (trim(Dblcb_Situacao_tributaria_IPI.Text) = EmptyStr) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Situacao_tributaria_IPI.Caption);
    Dblcb_Situacao_tributaria_IPI.SetFocus;
    Result := False;
    Exit;
  end;

  if (StrToFloatDef(E_Aq_Cofins.Text,0) > 0 ) and (trim(Dblcb_Situacao_tributaria_CFS.Text) = EmptyStr) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Situacao_tributaria_CFS.Caption);
    Dblcb_Situacao_tributaria_CFS.SetFocus;
    Result := False;
    Exit;
  end;

  if (StrToFloatDef(E_Aq_Pis.Text,0) > 0 ) and (trim(Dblcb_Situacao_tributaria_PIS.Text) = EmptyStr) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Situacao_tributaria_PIS.Caption);
    Dblcb_Situacao_tributaria_PIS.SetFocus;
    Result := False;
    Exit;
  end;

  if Fc_VerificaRegraExistente then
  begin
    MensagemPadrao(' Mensagem ', 'A T E N Ç Ã O!.' + EOLN+EOLN+
                   'J? existe uma regra com os dados informados.'+EOLN+
                   'Verifique e tente novamente com dados diferente.'+EOLN,
                    [' OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  end;

  if Cb_Transacao_Produto.ItemIndex = 6 then
  Begin
    if StrToFloatDef(E_Aq_ISS.Text,0) = 0 then
    Begin
      MensagemPadrao(' Mensagem ', 'A T E N Ç Ã O!.' + EOLN+EOLN+
                     'Para o Tipo de Transção Prestção de Serviço informa a alíquota I.S.S..'+EOLN+
                     'Verifique e tente novamente.'+EOLN,
                      [' OK'],[bEscape],mpAlerta);
      Result := False;
      Pg_Outros.ActivePageIndex := 3;
      IF E_Aq_ISS.CanFocus then
        E_Aq_ISS.SetFocus;
      Exit;
    end;
  end;
end;

function TRegTaxation.ValidaVisualizarReformaTributaria: boolean;
begin
  Result := True;
  if Taxation.Registro.Codigo = 0 then
  Begin
    TMsgSetes.PararExecucao('Selecione uma regra de tributção antes de continuar');
    Result := False;
    exit;
  End;

  if (( EditionState = 'I' ) or ( EditionState = 'E' )) then
  Begin
    TMsgSetes.PararExecucao('Finalize a edição da regra de tributção antes de continuar');
    Result := False;
    exit;
  End;

 if taxation.Registro.CodigoTaxas = 0 then
  Begin
    TMsgSetes.PararExecucao('Utilize o menu acima para aplicar um registro da reforma tributária');
    Result := False;
    exit;
  End;

end;

procedure TRegTaxation.VisualizarReformaTributaria;
var
  Lc_form : TRegTaxes;
begin
  try
    Lc_form := TRegTaxes.create(Self);
    Lc_form.CodigoRegistro := taxation.Registro.CodigoTaxas;
    Lc_form.Showmodal;
  finally
    FreeAndNil( Lc_form );
  end;


end;

procedure TRegTaxation.VisualizarReformatributria1Click(Sender: TObject);
begin
  if ValidaVisualizarReformaTributaria then
    VisualizarReformaTributaria
end;

function TRegTaxation.Fc_VerificaRegraExistente:Boolean;
begin
  with taxation.Parametros.FieldName do
  Begin
     codigo := taxation.Registro.Codigo;
     Produto := FProduto;
     Empresa := FEmpresa;
     Origem := InttoStr(Cb_Origem.ItemIndex);
    if trim(Dblcb_Situacao_tributaria.Text) <> EmptyStr then
      TribICMS_NR := Dblcb_Situacao_tributaria.KeyValue
    else
      TribICMS_NR := 0;

    if trim(Dblcb_Simples_Nacional.Text) <> EmptyStr then
      TribICMS_SN := Dblcb_Simples_Nacional.KeyValue
    else
      TribICMS_SN := 0;

    if trim(Dblcb_Modal_ICMS.Text) <> EmptyStr then
      DeterBC_ICMS_NR := Dblcb_Modal_ICMS.KeyValue
    else
      DeterBC_ICMS_NR := 0;

    if trim(Dblcb_Modal_ICMS_ST.Text) <> EmptyStr then
      DeterBC_ICMS_ST := Dblcb_Modal_ICMS_ST.KeyValue
    else
      DeterBC_ICMS_ST := 0;

    if trim(Dblcb_Desoneracao.Text) <> EmptyStr then
      Desoneracao := Dblcb_Desoneracao.KeyValue
    else
      Desoneracao := 0;

    AliqICMS := StrToFloatDef(E_Aq_ICMS.Text,0);
    RedAliqICMS := StrToFloatDef(E_Red_Aliq.Text,0);
    RedBCICMS := StrToFloatDef(E_Red_Base.Text,0);

    if trim(Dblcb_Situacao_tributaria_IPI.Text) <> EmptyStr then
      TribIPI := Dblcb_Situacao_tributaria_IPI.KeyValue
    else
      TribIPI := 0;
    AliqIPI := StrToFloatDef(E_Aq_IPI.Text,0);

    if trim(Dblcb_Situacao_tributaria_PIS.Text) <> EmptyStr then
      TribPIS := Dblcb_Situacao_tributaria_PIS.KeyValue
    else
      TribPIS := 0;
    AliqPIS := StrToFloatDef(E_Aq_Pis.Text,0);

    if trim(Dblcb_Situacao_tributaria_CFS.Text) <> EmptyStr then
      TribCofins := Dblcb_Situacao_tributaria_CFS.KeyValue
    else
      TribCofins := 0;

    AliqCofins := StrToFloatDef(E_Aq_Cofins.Text,0);

    AliqIRPJ := StrToFloatDef(E_Aq_IRPJ.Text,0);
    AliqCSLL := StrToFloatDef(E_Aq_CSLL.Text,0);
    AliqSisComex := StrToFloatDef(E_Aq_Siscomex.Text,0);
    AliqII := StrToFloatDef(E_Aq_Tec.Text,0);
    if chbx_sit_trb.Checked then
      TemST := SIGLA_S
    else
      TemST := SIGLA_N;

    if chbx_Consumidor.Checked then
      Consumidor := SIGLA_S
    else
      Consumidor := SIGLA_N;

    IF chbx_micro.Checked then
      MicroEmpresa := SIGLA_S
    else
      MicroEmpresa := SIGLA_N;

    if chbx_diferido.Checked then
      Diferido := SIGLA_S
    else
      Diferido := SIGLA_N;

    IF chbx_destaque.Checked then
      Destacar := SIGLA_S
    else
      Destacar := SIGLA_N;

    if CHBX_ST_ICMS.Checked then
      SubstitutoTributario := SIGLA_S
    else
      SubstitutoTributario := SIGLA_N;

    TipoTransacaoProduto := IntToStr(Cb_Transacao_Produto.ItemIndex);

    IF Trim(DBLCB_Observacao.Text) <> EmptyStr then
      Observacao := DBLCB_Observacao.KeyValue
    else
      Observacao := 0;

    IF Trim(DBLCB_Natureza.Text) <> EmptyStr then
      CFOP := DBLCB_Natureza.KeyValue
    else
      CFOP := 0;

    if Trim(Fm_ListaEstados.Dblcb_Lista.Text) <> EmptyStr then
      Estado := Fm_ListaEstados.Dblcb_Lista.KeyValue
    else
      Estado := 0;

    NCM := E_CodigoNCM.Text;
    Estabelecimento := Gb_CodMha;
  End;
  Result := taxation.VerificaRegraExistente;
end;

procedure TRegTaxation.carregar_Situacao_tributaria;
begin
  ds_Situacao_tributaria.DataSet := qr_Situacao_tributaria;
  Dblcb_Situacao_tributaria.ListSource := ds_Situacao_tributaria;

  qr_Situacao_tributaria.SQL.Text :=
    'select TBI_CODIGO, TBI_GRUPO || '' - '' || TBI_DESCRICAO DESCRICAO from TB_TRIB_ICMS_NR order by TBI_GRUPO';
  qr_Situacao_tributaria.Open;
  qr_Situacao_tributaria.FetchAll;
end;

procedure TRegTaxation.carregar_Simples_Nacional;
begin
  ds_Simples_Nacional.DataSet := qr_Simples_Nacional;
  Dblcb_Simples_Nacional.ListSource := ds_Simples_Nacional;

  qr_Simples_Nacional.SQL.Text :=
    'SELECT TBI_CODIGO, TBI_GRUPO || '' - '' || TBI_DESCRICAO DESCRICAO from TB_TRIB_ICMS_SN order by TBI_GRUPO';
  qr_Simples_Nacional.Open;
  qr_Simples_Nacional.FetchAll;
end;

procedure TRegTaxation.carregar_ICMS;
begin
  ds_ICMS.DataSet := qr_ICMS;
  Dblcb_Modal_ICMS.ListSource := ds_ICMS;

  qr_ICMS.SQL.Text :=
    'SELECT MDB_CODIGO , MDB_GRUPO || '' - '' ||  MDB_DESCRICAO DESCRICAO FROM TB_MOD_DET_BC_ICMS';
  qr_ICMS.Open;
  qr_ICMS.FetchAll;
end;

procedure TRegTaxation.carregar_ICMS_ST;
begin
  ds_ICMS_ST.DataSet := qr_ICMS_ST;
  Dblcb_Modal_ICMS_ST.ListSource := ds_ICMS_ST;

  qr_ICMS_ST.SQL.Text :=
    'SELECT MDB_CODIGO , MDB_GRUPO || '' - '' || MDB_DESCRICAO DESCRICAO FROM TB_MOD_DET_BC_ICMS_ST';
  qr_ICMS_ST.Open;
  qr_ICMS_ST.FetchAll;
end;

procedure TRegTaxation.carregar_IPI;
begin
  ds_IPI.DataSet := qr_IPI;
  Dblcb_Situacao_tributaria_IPI.ListSource := ds_IPI;

  qr_IPI.SQL.Text :=
    'SELECT TBI_CODIGO, TBI_GRUPO || '' - '' || TBI_DESCRICAO DESCRICAO FROM TB_TRIB_IPI';
  qr_IPI.Open;
  qr_IPI.FetchAll;
end;

procedure TRegTaxation.carregar_PIS;
begin
  ds_PIS.DataSet := QR_PIS;
  Dblcb_Situacao_tributaria_PIS.ListSource := ds_PIS;

  QR_PIS.SQL.Text :=
    'SELECT TBP_CODIGO, TBP_GRUPO || '' - '' || TBP_DESCRICAO DESCRICAO FROM TB_TRIB_PIS';
  QR_PIS.Open;
  QR_PIS.FetchAll;
end;

procedure TRegTaxation.AplicaReformaTriubutaria;
var
  Lc_form : TSeaTaxes;
begin
  try
    Lc_form := TSeaTaxes.create(Self);
    Lc_form.Showmodal;
    if lc_form.cds_search.active then
    Begin
      if lc_form.cds_searchID.AsInteger > 0 then
      Begin
        if (MensagemPadrao(TITULO_CONFIRMACAO,
            concat('Deseja vincular ', lc_form.cds_searchDESCRIPTION.AsString,
            ' com a esta regra de tributção?, ', EOLN , EOLN , 'Confirmar a operção ?'),
            [SIM, NAO], [bNormal, bEscape], mpConfirmacao, clBtnFace) = mrBotao1) then
        Begin
          taxation.AplicaReformaTributaria(taxation.Registro.Codigo, lc_form.cds_searchID.AsInteger,'UNICA');
        End;
      End;
    End;
    
  finally
    FreeAndNil( Lc_form );
  end;
end;

procedure TRegTaxation.AplicarReformaTributria1Click(Sender: TObject);
begin
  if ValidaAplicaReformaTriubutaria then
    AplicaReformaTriubutaria;
end;

procedure TRegTaxation.carregar_CFS;
begin
  ds_CFS.DataSet := qr_CFS;
  Dblcb_Situacao_tributaria_CFS.ListSource := ds_CFS;

  qr_CFS.SQL.Text :=
    'SELECT TBC_CODIGO, TBC_GRUPO || '' - '' || TBC_DESCRICAO DESCRICAO FROM TB_TRIB_CFS';
  qr_CFS.Open;
  qr_CFS.FetchAll;
end;

procedure TRegTaxation.carregar_Obs;
begin
  ds_OBS.DataSet := qr_OBS;
  DBLCB_Observacao.ListSource := ds_OBS;

  qr_OBS.SQL.Text :=
    'SELECT OBS_CODIGO, OBS_DESCRICAO FROM TB_OBSERVACAO WHERE OBS_CODMHA =:OBS_CODMHA ORDER BY OBS_DESCRICAO';
  qr_OBS.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;
  qr_OBS.Open;
  qr_OBS.FetchAll;
end;


end.
