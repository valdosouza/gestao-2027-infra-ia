unit sea_pay_back;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider, ControllerEmpresa, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, ControllerPayBAck, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, QEdit_Setes, Vcl.ComCtrls, STQuery;

type
  TSeaPayBack = class(TBaseSearch)
    ChBx_Periodo: TCheckBox;
    E_Data_Fim: TDateTimePicker;
    E_Data_Ini: TDateTimePicker;
    Rg_Tipo_Valor: TRadioGroup;
    Label42: TLabel;
    E_BuscaFone: TEdit_Setes;
    Lb_TotalCredito: TLabel;
    E_CreditoTotal: TLabel;
    Lb_TotalDebito: TLabel;
    E_CreditoExpirado: TLabel;
    Lb_Saldo: TLabel;
    E_Saldo: TLabel;
    cds_searchDT_RECORD: TDateField;
    cds_searchCREDIT_VALUE: TBCDField;
    cds_searchDEBIT_VALUE: TBCDField;
    cds_searchHISTORY: TWideStringField;
    cds_searchEMP_FANTASIA: TWideStringField;
    cds_searchEMP_CNPJ: TWideStringField;
    cds_searchEND_FONE: TWideStringField;
    MnuConfigurao: TMenuItem;
    PopupMenu: TPopupMenu;
    VisualizarPedido1: TMenuItem;
    cds_searchTB_ORDER_ID: TIntegerField;
    L_CodigoCliente: TLabel;
    Sb_Pesq_Empresa: TSpeedButton;
    E_Busca_Cliente: TEdit;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    E_Busca_Cd_Cliente: TEdit;
    cds_searchEMP_NOME: TWideStringField;
    Label3: TLabel;
    E_BuscaEndereco: TEdit;
    RegistrarCrditosExpirados1: TMenuItem;
    CadastrodeCliente1: TMenuItem;
    cds_searchSTATUS: TWideStringField;
    cds_searchDT_EXPIRE: TDateField;
    Label1: TLabel;
    E_CreditoUtilizado: TLabel;
    procedure MnuConfiguraoClick(Sender: TObject);
    procedure VisualizarPedido1Click(Sender: TObject);
    procedure E_BuscaFoneExit(Sender: TObject);
    procedure Sb_Pesq_EmpresaClick(Sender: TObject);
    procedure E_Busca_Cd_ClienteExit(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure RegistrarCrditosExpirados1Click(Sender: TObject);
    procedure CadastrodeCliente1Click(Sender: TObject);
  private
    { Private declarations }
    Empresa : TControllerEmpresa;
    procedure Totalizer;
    procedure RegistraCreditosExpirados;
  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure ImagemBotao;Override;
    procedure FormataTela;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBySQl;Override;
    procedure SetParameters(Param: TSTQuery);Override;
    procedure SetRegister;Override;
    procedure Search;Override;
  public
    PayBack : TControllerPayBAck;
  end;

var
  SeaPayBack: TSeaPayBack;

implementation

{$R *.dfm}

uses     Un_DM, UN_Principal, env, RN_EMpresa, Un_Funcoes, cfg_pay_back, RN_NotaFiscalConsumidor, Un_Pesq_Empresa, UN_Sistema, Un_CliResumo, Un_Msg;
procedure TSeaPayBack.CadastrodeCliente1Click(Sender: TObject);
Var
  Lc_Form_res : TFr_CliResumo;
  Lc_Form : TFr_Pesq_Empresa;
begin
  if not Fc_VerificaFormularioDisponivel('Fr_CliResumo') then
  Begin
    Lc_Form := TFr_Pesq_Empresa.Create( nil );
    Try
      Lc_Form.TipoEmpresa := 1;
      Lc_Form.ShowModal;
    finally
      FreeAndNil(Lc_Form);
    end;
  end
  else
  Begin
    Try
      Lc_Form_res := TFr_CliResumo.Create(Self);
      Lc_Form_res.ShowModal;
    Finally
      FreeAndNil(Lc_Form_res);
    end;
  end;
end;

procedure TSeaPayBack.ChBx_FantasiaClick(Sender: TObject);
begin
  ChBx_Nome.OnClick := nil;
  DBG_Pesquisa.Columns[2].Visible := TCheckBox(Sender).Checked;
  DBG_Pesquisa.Columns[2].Width  := 335;
  DBG_Pesquisa.Columns[3].Visible := not TCheckBox(Sender).Checked;
  ChBx_Nome.Checked := not TCheckBox(Sender).Checked;
  ChBx_Nome.OnClick := ChBx_NomeClick;
end;

procedure TSeaPayBack.ChBx_NomeClick(Sender: TObject);
begin
  ChBx_Fantasia.OnClick := nil;
  DBG_Pesquisa.Columns[2].Visible := not TCheckBox(Sender).Checked;
  DBG_Pesquisa.Columns[3].Visible := TCheckBox(Sender).Checked;
  DBG_Pesquisa.Columns[3].Width  := 335;
  ChBx_Fantasia.Checked := not TCheckBox(Sender).Checked;
  ChBx_Fantasia.OnClick := ChBx_FantasiaClick;
end;

procedure TSeaPayBack.CriarVariaveis;
begin
  inherited;
  PayBack := TControllerPayBAck.create(Self);
end;

procedure TSeaPayBack.E_BuscaFoneExit(Sender: TObject);
begin
  if (trim(E_BuscaFone.text) <>'')  then
  Begin
    Empresa.Endereco.Registro.Fone := Fc_RemoveCaracterInformado(E_BuscaFone.Text, ['(',')','-',' ']);
    Empresa.Endereco.getIdByFone;
    if ( Empresa.Endereco.Registro.Codigo > 0 ) then
    Begin
      Empresa.Registro.Codigo := Empresa.Endereco.Registro.CodigoEmpresa;
      Empresa.getById;
      if Empresa.exist then
      Begin
        E_Busca_Cd_Cliente.Text := Empresa.Registro.Codigo.ToString;
        E_Busca_Cliente.Text := Empresa.Registro.ApelidoFantasia
      End
      else
      Begin
        E_Busca_Cd_Cliente.Clear;
        E_Busca_Cliente.Clear;
      End;
    End
    else
    Begin
      Empresa.clear;
      Empresa.Endereco.clear;
    End;
  End;
end;

procedure TSeaPayBack.E_Busca_Cd_ClienteExit(Sender: TObject);
begin
  if StrToIntDef(E_Busca_Cd_Cliente.Text,0) > 0 then
  BEgin
    Empresa.Registro.Codigo := StrToIntDef(E_Busca_Cd_Cliente.Text,0);
    Empresa.getById;
    if Empresa.exist then
    Begin
      if ChBx_Nome.checked then
        E_Busca_Cliente.Text := Empresa.Registro.NomeRazaoSocial
      else
        E_Busca_Cliente.Text := Empresa.Registro.ApelidoFantasia;
    End;
  End;
end;

procedure TSeaPayBack.FormataTela;
begin
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;

end;

procedure TSeaPayBack.ImagemBotao;
begin
  inherited;

end;

procedure TSeaPayBack.IniciaVariaveis;
begin
  inherited;
  Empresa := TControllerEmpresa.create(self);
end;

procedure TSeaPayBack.InnerJoinSql;
begin
  inherited;
  InnerJoinTxt := concat(
            'INNER JOIN TB_EMPRESA EP ' ,
            '  ON (EP.EMP_CODIGO = PB.TB_CUSTOMER_ID ) ',
            'INNER JOIN TB_ENDERECO ED ' ,
            '  ON (EP.EMP_CODIGO = ED.END_CODEMP ) '
  );
end;

procedure TSeaPayBack.MnuConfiguraoClick(Sender: TObject);
Var
  Form : TCfgPayBack;
Begin
  try
    Form := TCfgPayBack.Create(nil);
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TSeaPayBack.OrderBySQl;
begin
  inherited;
  OrderByTxt := 'ORDER BY EMP_NOME, DT_RECORD, ID ';
end;

procedure TSeaPayBack.RegistraCreditosExpirados;
begin
  //PEga dados de configuração
  PayBack.Parametros.Dias := StrToIntDef(Fc_Tb_Geral('L','PAYBACK_DT_EXPIRED','365'),365);
  PayBack.Parametros.ValorMinimo := StrToFloatDEf(Fc_Tb_Geral('L','PAYBACK_VL_MINIMO','0'),0.0);
  PayBack.Parametros.Estabelecimento := Gb_CodMha;
  PayBack.Parametros.Terminal := Gb_Terminal;

  PayBack.Parametros.PayBack.Historico := 'Expirado';
  PayBack.Parametros.PayBack.Data := Date - PayBack.Parametros.Dias;
  PayBack.RegistraCreditoExpirado;

end;

procedure TSeaPayBack.RegistrarCrditosExpirados1Click(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja efetuar o registro de créditos expirados.'+EOLN+
                     'Confirmar a operação ?',
                     [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
  Begin
    try
      Self.Enabled := False;
      Pc_ProcesoAguarde(Self,'I');
      Self.Update;
      RegistraCreditosExpirados;
    finally
      Pc_ProcesoAguarde(Self,'F');
      Self.Enabled := True;
      Self.Update;
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Créditos expirados foram devidamente registrados.' + EOLN +
                     'Clique em ok para fechar.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);

    end;
  End;
end;

procedure TSeaPayBack.Sb_Pesq_EmpresaClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(1,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_Busca_Cd_Cliente.Text := Lc_Retorno.It_Dados[1,0];
    E_Busca_Cliente.Text := Lc_Retorno.It_Dados[1,1];
  end;
end;

procedure TSeaPayBack.Search;
begin
  inherited;
  Totalizer;
end;

procedure TSeaPayBack.SelectSql;
begin
  SelectTxt := concat(
              'SELECT PB.*, EP.emp_fantasia, EP.emp_cnpj, ED.end_fone, EMP_NOME ',
              'FROM TB_PAY_BACK PB '
            );

end;

procedure TSeaPayBack.SetParameters(Param: TSTQuery);
begin
  with Param do
  Begin
    ParamByName('TB_INSTITUTION_ID').AsInteger := Gb_CodMha;

    if ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
      ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
    End;

    if Trim(E_BuscaFone.Text) <> '' then
    Begin
     ParamByName('END_FONE').AsString := concat('%',Fc_RemoveCaracterInformado(E_BuscaFone.Text, ['(',')','-','-',' ']));
    End;

    if StrToIntDef(E_Busca_cd_Cliente.Text,0) > 0 then
    Begin
      ParamByName('TB_CUSTOMER_ID').AsInteger := StrToIntDef(E_Busca_cd_Cliente.Text,0);
    End;

    if Trim(E_Busca_Cliente.Text) <> '' then
    Begin
      ParamByName('EMP_NOME').AsString :='%'+ E_Busca_Cliente.Text+'%';
    End;

    if Trim(E_BuscaEndereco.Text) <> '' then
    Begin
      ParamByName('END_ENDER').Asstring :='%'+ E_BuscaEndereco.Text+'%';
    End;
  End;
end;

procedure TSeaPayBack.SetRegister;
begin
  inherited;

end;

procedure TSeaPayBack.Totalizer;
Var
  LcCreditoTotal : Real;
  LcCreditoExpirado : Real;
  LcCreditoUtilizado : Real;
  LcSaldo : Real;
begin
  LcCreditoTotal  := 0;
  LcCreditoExpirado  := 0;
  LcCreditoUtilizado  := 0;
  LcSaldo   := 0;
  if cds_search.RecordCount > 0 then
  Begin
    cds_search.First;
    DBG_Pesquisa.Visible := FAlse;
    while not cds_search.Eof do
    Begin
      LcCreditoTotal := LcCreditoTotal + cds_searchCREDIT_VALUE.AsFloat;
      if cds_searchStatus.AsString = 'Expirado' then
        LcCreditoExpirado := LcCreditoExpirado + cds_searchCREDIT_VALUE.AsFloat;

      if (cds_searchStatus.AsString = 'Utilizado')or (cds_searchStatus.AsString = 'Estornado') then
        LcCreditoUtilizado := LcCreditoUtilizado + cds_searchCREDIT_VALUE.AsFloat;

      cds_search.Next;
    End;
    LcSaldo := LcCreditoTotal - (LcCreditoExpirado + LcCreditoUtilizado);
    cds_search.First;
    DBG_Pesquisa.Visible := True;
  End;

  E_CreditoTotal.Caption  := FloatToStrF(LcCreditototal ,ffNumber,10,2);
  E_CreditoExpirado.Caption   := FloatToStrF(LccreditoExpirado,ffNumber,10,2);
  E_CreditoUtilizado.Caption   := FloatToStrF(LcCreditoUtilizado,ffNumber,10,2);
  E_Saldo.Caption         := FloatToStrF(LcSaldo,ffNumber,10,2);

end;

procedure TSeaPayBack.VisualizarPedido1Click(Sender: TObject);
begin
  if cds_searchTB_ORDER_ID.AsInteger = 0 then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Este é um lançamento Avulso e não está vinculado a Pedidos.' + EOLN +
                   'Clique OK para continuar.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    exit;
  End;
  Pc_AbreTelaNotaFiscal65('P', cds_searchTB_ORDER_ID.AsInteger )
end;

procedure TSeaPayBack.WhereSql;
begin
  inherited;
  WhereTxt := concat(
              'WHERE (PB.TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) '
  );

  if ChBx_Periodo.Checked then
  Begin
    WhereTxt := concat(
                WhereTxt,
                ' AND ( PB.DT_RECORD BETWEEN :DATAINI AND :DATAFIM ) '
    );
  End;

  if Trim(E_BuscaFone.Text) <> '' then
  Begin
    WhereTxt := concat(
                WhereTxt,
                ' AND (ED.END_FONE like :END_FONE)   '
    );
  End;

  if StrToIntDef(E_Busca_cd_Cliente.Text,0) > 0 then
  Begin
    WhereTxt := concat(
                WhereTxt,
                ' AND ( (PB.TB_CUSTOMER_ID =:TB_CUSTOMER_ID ) ) '
    );
  End;

  if Trim(E_Busca_Cliente.Text) <> '' then
  Begin
    WhereTxt := concat(
                WhereTxt,
                ' AND ( (EP.EMP_NOME LIKE :EMP_NOME) OR (EP.EMP_FANTASIA LIKE:EMP_NOME ) ) '
    );
  End;

  if Trim(E_BuscaEndereco.Text) <> '' then
  Begin
    WhereTxt := concat(
                WhereTxt,
                ' AND (ED.END_ENDER LIKE :END_ENDER ) '
    );
  End;

  case Rg_Tipo_Valor.ItemIndex of
    0: WhereTxt := concat( WhereTxt,' AND ( PB.CREDIT_VALUE > 0 ) ');
    1: WhereTxt := concat( WhereTxt,' AND ( PB.DEBIT_VALUE > 0 ) ');
  end;

end;

end.
