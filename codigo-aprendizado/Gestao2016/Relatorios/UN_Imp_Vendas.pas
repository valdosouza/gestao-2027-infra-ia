unit UN_Imp_Vendas;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, StdCtrls, ExtCtrls, DBCtrls, IniFiles, Mask, DB, STQuery, ComCtrls, QuickRpt, Gauges, prmVendas, Un_Fm_ListaMultiEmpresa, base_frame_list;


type
  TFr_Imp_Vendas = class(TForm)
    Qr_Exporta: TSTQuery;
    Qr_Transportadora: TSTQuery;
    Ds_Regiao: TDataSource;
    Qr_Regiao: TSTQuery;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Panel1: TPanel;
    LBx_TipoRelatorio: TListBox;
    Label4: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Pnl_Parametro: TPanel;
    Label3: TLabel;
    Label6: TLabel;
    Lb_Processo: TLabel;
    Gg_Progresso: TGauge;
    Label9: TLabel;
    Label2: TLabel;
    DBLCB_Empresa: TDBLookupComboBox;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    DBLCB_Transportadora: TDBLookupComboBox;
    E_Empresa: TEdit;
    DBLCB_Regiao: TDBLookupComboBox;
    GroupBox2: TGroupBox;
    Rb_Vend_Clliente: TRadioButton;
    Rb_Vend_Pedido: TRadioButton;
    DBLCB_Vendedor: TDBLookupComboBox;
    E_BuscaCodigo: TMaskEdit;
    ChBx_Periodo: TCheckBox;
    RG_Tipo: TRadioGroup;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Panel2: TPanel;
    ChBx_InternetPublished: TCheckBox;
    Fm_LME: TFm_ListaMultiEmpresa;
    Chbx_obs_field: TCheckBox;
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_ImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sb_ExportarClick(Sender: TObject);
    procedure DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure DBLCB_VendedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLCB_TransportadoraKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure DBLCB_RegiaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure E_BuscaCodigoExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure LBx_TipoRelatorioClick(Sender: TObject);


  private

    { Private declarations }
  public
    { Public declarations }
    It_Visualizar :Boolean;
    It_Imprimir :Boolean;
    It_Exportar :Boolean;

    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_AtivarTabelas;
    //Relação de Relatorios
    procedure Pc_VendasNormal(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_VendasDetalhada(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_VendasItens(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_VendasGeral(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_VendasMensal(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_VendasProdutos(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_Consertos(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_PedidoPendente(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_VendasTotalProdutos(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_VendasResumidaCliente(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_TrocasNasVendas(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_DevolucaoNasVendas(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_VendasCustoUnico(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_ImagemBotao;
    procedure Pc_AtivaParametros;
    procedure Pc_TrataParametros_9;



    function getParametros: TParamVendas;
  end;

var
  Fr_Imp_Vendas: TFr_Imp_Vendas;

implementation

uses     UN_MSG, Un_Funcoes, Un_Excel, UN_DM, UN_Sistema, UN_Principal, env, Un_RL_Venda_Item, UN_RL_VendaMensal, UN_RL_VendasProdutos, Un_RL_VendaMeses, un_rl_pedido_pendente, Un_Regra_Negocio, RN_Cliente, UN_TabelasEmListas, UN_RL_Vda_Total_Produto, Un_RL_Vendas_Res_Cliente, Un_RL_ReportVendasItens, Un_RL_ReportVendas, Un_RL_ReportVendasGeral, Un_RL_ReportVendasConserto, Un_RL_ReportVendasCustoUnico;
{$R *.dfm}

function TFr_Imp_Vendas.getParametros: TParamVendas;
begin
  Result := TParamVendas.Create;
  with Result do
  Begin
    TipoDocumento := RG_Tipo.ItemIndex;
    Periodo := ChBx_Periodo.Checked;
    DataInicial := E_Data_Ini.DateTime;
    DataFinal := E_Data_Fim.DateTime;
    if Trim(DBLCB_Empresa.Text) <> '' then
      CodigoCliente := DBLCB_Empresa.KeyValue;
    NomeCliente := E_Empresa.Text;
    if Trim(DBLCB_Transportadora.Text) <> '' then
      CodigoTransportadora := DBLCB_Transportadora.KeyValue;
    if Rb_Vend_Clliente.Checked and (Trim(DBLCB_Vendedor.Text) <> '') then
      CodigoVendedorCliente := DBLCB_Vendedor.KeyValue;
    if Rb_Vend_Pedido.Checked and (Trim(DBLCB_Vendedor.Text) <> '') then
      CodigoVendedorPedido := DBLCB_Vendedor.KeyValue;
    NomeDaRegiao := DBLCB_Regiao.Text;
    if Fm_LME.chbx_Empresas.Checked then
      CodigoEstabelecimento := 0
    else
      CodigoEstabelecimento := Fm_LME.Dblcb_Lista.KeyValue;
    TipoItem := 'V';
    ShowObsField := Chbx_obs_field.Checked;
  end;
end;

procedure TFr_Imp_Vendas.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

//Relação de Relatorios
procedure TFr_Imp_Vendas.Pc_VendasNormal(Pc_Operacao,Pc_Caminho:String);
Var
  Form : TRL_ReportVendasGeral;
Begin
  Try
    Form := TRL_ReportVendasGeral.Create(Self);
    Form.Parametros := getParametros;
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Form.Qrpt.ReportTitle := 'RELAÇÃO DE VENDAS';
      Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      Form.Buscar;
      Fr_Excel.Pc_Excel(Form.Qr_Consulta,Pc_Caminho);
    end;
  finally
    Form.Close;
    FreeAndNil(Form);
  end;
end;


procedure TFr_Imp_Vendas.Pc_VendasCustoUnico(Pc_Operacao, Pc_Caminho: String);
Var
  Form : TRL_ReportVendasCustoUnico;
Begin
  Try
    Form := TRL_ReportVendasCustoUnico.Create(Self);
    Form.Parametros := getParametros;
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Form.Qrpt.ReportTitle := 'RELAÇÃO DE VENDAS X CUSTO UNICO';
      Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      Form.Buscar;
      Fr_Excel.Pc_Excel(Form.Qr_Consulta,Pc_Caminho);
    end;
  finally
    Form.Close;
    FreeAndNil(Form);
  end;
end;

procedure TFr_Imp_Vendas.Pc_VendasDetalhada(Pc_Operacao,Pc_Caminho:String);
Var
  Form : TRL_ReportVendasItens;
begin
  Try
    Form  := TRL_ReportVendasItens.Create(Self);
    Form.Parametros := getParametros;
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Form.Parametros.TipoItem := 'V';
      Form.Qrpt.ReportTitle := 'RELAÇÃO DAS VENDAS COM DETALHANDO OS ITENS';
      Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      Form.Buscar;
      fr_Excel.Pc_Excel(Form.Qr_Consulta,Pc_Caminho);
    end;
  finally
    Form.Close;
    FreeAndNil(Form);
  end;
end;

procedure TFr_Imp_Vendas.Pc_VendasItens(Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Rel : TForm;
begin
  Lc_Rel := TForm.Create(RL_Venda_Item);
  Application.CreateForm(TRL_Venda_Item, Lc_Rel);
  with TRL_Venda_Item(Lc_Rel) do
  Begin
    if Pc_Operacao = 'I' then
    Begin
      Qrpt.Preview;
    end
    else
    Begin
      Pc_BuscarVendas;
      Fr_Excel.Pc_Excel(Qr_Vendas,Pc_CAminho);
    end;
  end;
  FreeAndNil(Lc_Rel);

end;

procedure TFr_Imp_Vendas.Pc_VendasGeral(Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Rel : TRL_VendaMeses;
begin
  if Pc_Operacao = 'I' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Esta opção é apenas para exportação para Excel.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpInformacao);
  end
  else
  Begin
    Try
      Lc_Rel := TRL_VendaMeses.Create(nil);
      Lc_Rel.Pc_LimiteDatas;
      Lc_Rel.Pc_BuscaCliente;
      Lc_Rel.Pc_PreencheMatrizVendas;
      Lc_Rel.Pc_PreencheMatrizVendasMarcas;
      Lc_Rel.ExportDados;
//      Lc_Rel.SHowModal;
    Finally
      FreeAndNil(Lc_Rel);
    End;

  end;
end;

procedure TFr_Imp_Vendas.Pc_VendasMensal(Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Rel : TForm;
begin
  Lc_Rel := TForm.Create(Rl_VendaMensal);
  Application.CreateForm(TRl_VendaMensal, Lc_Rel);
  with TRl_VendaMensal(Lc_Rel) do
    Begin
    if Pc_Operacao = 'I' then
      Begin
      Qrpt.Preview;
      end
    else
      Begin
       MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Opções para exportar não habilitada .'+EOLN+EOLN,
                      ['OK'],[bEscape],mpInformacao);
      end;
    end;
  FreeAndNil(Lc_Rel);
end;

procedure TFr_Imp_Vendas.Pc_VendasProdutos(Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Rel : TForm;
begin
  Lc_Rel := TForm.Create(RL_VendasProdutos);
  Application.CreateForm(TRL_VendasProdutos, Lc_Rel);
  with TRL_VendasProdutos(Lc_Rel) do
    Begin
    if Pc_Operacao = 'I' then
      Begin
      Qrpt.Preview;
      end
    else
      Begin
      Pc_Busca;
      Fr_Excel.Pc_Excel(Qr_Produtos,Pc_CAminho);
      end;
    end;
  FreeAndNil(Lc_Rel);
end;

procedure TFr_Imp_Vendas.Pc_Consertos(Pc_Operacao,Pc_Caminho:String);
Var
  Form : TRL_ReportVendasConserto;
Begin
  Try
    Form := TRL_ReportVendasConserto.Create(Self);
    Form.Parametros := getParametros;
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Form.Qrpt.ReportTitle := 'RELAÇÃO DE CONSERTOS';
      Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      Form.Buscar;
      fr_Excel.Pc_Excel(Form.Qr_Consulta,Pc_Caminho);
    end;
  finally
    Form.Close;
    FreeAndNil(Form);
  end;
end;


procedure TFr_Imp_Vendas.Pc_PedidoPendente(Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Rel : TForm;
begin
  Lc_Rel := TForm.Create(rl_pedido_pendente);
  Application.CreateForm(Trl_pedido_pendente, Lc_Rel);
  with Trl_pedido_pendente(Lc_Rel) do
    Begin
    if Pc_Operacao = 'I' then
      Begin
      Qrpt.Preview;
      end
    else
      Begin
      Pc_Busca;
      Fr_Excel.Pc_Excel(Qr_Vendas,Pc_CAminho);
      end;
    end;
  FreeAndNil(Lc_Rel);
end;


procedure TFr_Imp_Vendas.Pc_VendasTotalProdutos(Pc_Operacao,Pc_Caminho:String);
Begin
  Try
    If not Assigned(RL_Vda_Total_Produto) then (Application.CreateForm(TRL_Vda_Total_Produto, RL_Vda_Total_Produto));
    with RL_Vda_Total_Produto do
    Begin
      if Fm_LME.chbx_Empresas.Checked then
        It_Cd_Estabelecimento := 0
      else
        It_Cd_Estabelecimento := Fm_LME.Dblcb_Lista.KeyValue;
      It_PedidoAberto := False;
      It_Cd_Pedido := 0;
      It_PedidoFechado := (RG_Tipo.ItemIndex = 0);
      It_NotaFiscal := (RG_Tipo.ItemIndex = 1);
      It_PedidoNota  := (RG_Tipo.ItemIndex = 2);
      It_Periodo := ChBx_Periodo.Checked;
      It_Dt_Inicio := E_Data_Ini.Date;
      It_Dt_Fim := E_Data_Fim.Date;
      if Trim(DBLCB_Empresa.Text) <> '' then
        It_Cd_Cliente := DBLCB_Empresa.KeyValue;
      It_Nm_Cliente := E_Empresa.Text;
      if Rb_Vend_Clliente.Checked and (Trim(DBLCB_Vendedor.Text) <> '') then
        it_Cd_VendedorCliente := DBLCB_Vendedor.KeyValue;
      if Rb_Vend_Pedido.Checked and (Trim(DBLCB_Vendedor.Text) <> '') then
        it_Cd_VendedorPedido := DBLCB_Vendedor.KeyValue;
      It_End_Regiao := DBLCB_Regiao.Text;
      if ChBx_Nome.Checked then
        It_OrdenaNome := 'N'
      else
        It_OrdenaNome := 'S';
    end;
    if Pc_Operacao = 'I' then
    Begin
      RL_Vda_Total_Produto.Qrpt.Preview;
    end
    else
    Begin
      RL_Vda_Total_Produto.Pc_Busca;
      Fr_Excel.Pc_Excel(RL_Vda_Total_Produto.Qr_Vendas,Pc_CAminho);
    end;
  finally
    RL_Vda_Total_Produto.Close;
  end;
end;

procedure TFr_Imp_Vendas.Pc_VendasResumidaCliente(Pc_Operacao,Pc_Caminho:String);
Begin
  Try
    If not Assigned(RL_Vendas_Res_Cliente) then (Application.CreateForm(TRL_Vendas_Res_Cliente, RL_Vendas_Res_Cliente));
    with RL_Vendas_Res_Cliente do
    Begin
      if Fm_LME.chbx_Empresas.Checked then
        It_Cd_Estabelecimento := 0
      else
        It_Cd_Estabelecimento := Fm_LME.Dblcb_Lista.KeyValue;
      It_PedidoAberto := False;
      It_Cd_Pedido := 0;
      It_PedidoFechado := (RG_Tipo.ItemIndex = 0);
      It_NotaFiscal := (RG_Tipo.ItemIndex = 1);
      It_PedidoNota  := (RG_Tipo.ItemIndex = 2);
      It_Periodo := ChBx_Periodo.Checked;
      It_Dt_Inicio := E_Data_Ini.Date;
      It_Dt_Fim := E_Data_Fim.Date;
      if Trim(DBLCB_Empresa.Text) <> '' then
        It_Cd_Cliente := DBLCB_Empresa.KeyValue;
      It_Nm_Cliente := E_Empresa.Text;
      if Trim(DBLCB_Transportadora.Text) <> '' then
        It_Cd_Transportadora := DBLCB_Transportadora.KeyValue;
      if Rb_Vend_Clliente.Checked and (Trim(DBLCB_Vendedor.Text) <> '') then
        it_Cd_VendedorCliente := DBLCB_Vendedor.KeyValue;
      if Rb_Vend_Pedido.Checked and (Trim(DBLCB_Vendedor.Text) <> '') then
        it_Cd_VendedorPedido := DBLCB_Vendedor.KeyValue;
      It_End_Regiao := DBLCB_Regiao.Text;
      if ChBx_Nome.Checked then
        It_OrdenaNome := 'N'
      else
        It_OrdenaNome := 'S';
      end;
    if Pc_Operacao = 'I' then
      Begin
      RL_Vendas_Res_Cliente.Qrpt.Preview;
      end
    else
      Begin
      RL_Vendas_Res_Cliente.Pc_Busca;
      Fr_Excel.Pc_Excel(RL_Vendas_Res_Cliente.Qr_Vendas,Pc_CAminho);
      end;
  finally
    RL_Vendas_Res_Cliente.Close;
  end;
end;

procedure TFr_Imp_Vendas.SB_ImprimirClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Self.KeyPreview := False;
    Pc_LimpaQrPreviweMemoria;
    case LBx_TipoRelatorio.ItemIndex of
      0:Pc_VendasNormal('I','');
      1:Pc_VendasDetalhada('I','');
      2:Pc_VendasItens('I','');
      3:Pc_VendasGeral('I','');
      4:Pc_VendasMensal('I','');
      5:Pc_VendasProdutos('I','');
      6:Pc_Consertos('I','');
      7:Pc_PedidoPendente('I','');
      8:Pc_VendasTotalProdutos('I','');
      9:Pc_VendasResumidaCliente('I','');
      10:Pc_TrocasNasVendas('I','');
      11:Pc_DevolucaoNasVendas('I','');
      12:Pc_VendasCustoUnico('I','');
      end;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
    Self.KeyPreview := True;
  end;
end;

procedure TFr_Imp_Vendas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F2  : if Sb_Exportar.Enabled then Sb_ExportarClick(Sender);
      VK_F3  : if SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_Imp_Vendas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  Fr_Imp_Vendas:=nil;
end;

procedure TFr_Imp_Vendas.Sb_ExportarClick(Sender: TObject);
Var
  Lc_CAminho : String;
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    case LBx_TipoRelatorio.ItemIndex of
      3:Pc_VendasGeral('E',Lc_CAminho);
    else
      Begin
        IF (Fr_Principal.SaveDialogo.Execute) then
        Begin
          if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
          Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
          Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
          case LBx_TipoRelatorio.ItemIndex of
            0:Pc_VendasNormal('E',Lc_CAminho);
            1:Pc_VendasDetalhada('E',Lc_CAminho);
            2:Pc_VendasItens('E',Lc_CAminho);
            4:Pc_VendasMensal('E',Lc_CAminho);
            5:Pc_VendasProdutos('E',Lc_CAminho);
            6:Pc_Consertos('E',Lc_CAminho);
            7:Pc_PedidoPendente('E',Lc_CAminho);
            8:Pc_VendasTotalProdutos('E',Lc_CAminho);
            9:Pc_VendasResumidaCliente('E',Lc_CAminho);
            10:Pc_TrocasNasVendas('E',Lc_CAminho);
            11:Pc_DevolucaoNasVendas('E',Lc_CAminho);
            12:Pc_VendasCustoUnico('E',Lc_CAminho);
          end;
        End;
      End;
    end;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;

procedure TFr_Imp_Vendas.DBLCB_EmpresaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
        begin
        DBLCB_Empresa.KeyValue := Null;
        E_BuscaCodigo.Clear;
        end;
      end;
end;

procedure TFr_Imp_Vendas.ChBx_FantasiaClick(Sender: TObject);
begin
  Pc_ListaClienteDbLookUpComboBox('EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
end;

procedure TFr_Imp_Vendas.ChBx_NomeClick(Sender: TObject);
begin
  Pc_ListaClienteDbLookUpComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa)
end;

procedure TFr_Imp_Vendas.DBLCB_VendedorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Vendedor.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_Imp_Vendas.DBLCB_TransportadoraKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Transportadora.KeyValue:=Null;
    end;
  end;
end;
procedure TFr_Imp_Vendas.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Imprimir     := True;
    It_Exportar     := True;
    end
  else
    begin
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    if not It_Visualizar then exit;
    It_Imprimir      := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    It_Exportar      := Fc_HabilitaPermissao(Pc_Menu,'EXPORTAR','S');
    end;
   SB_Imprimir.Enabled:= It_Imprimir;
   Sb_Exportar.Enabled:= It_Exportar;
end;

procedure TFr_Imp_Vendas.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Fm_LME.Listar('EMP_NOME');
  Fm_LME.HabilitarMultiEmpresa;
  Pc_PermissaoBotao('Vendas');
  RG_Tipo.ItemIndex:=0;
  LBx_TipoRelatorio.ItemIndex:=0;
  ChBx_NomeClick(Self);
  DM_ListaConsultas.Pc_ListaVendedor;
  DM_ListaConsultas.Pc_ListaTranportadoras('EMP_NOME');
  E_Data_INI.Date:=Date;
  E_Data_FIM.Date:=Date;
  ChBx_Periodo.Checked:= Fc_Marca_data_pesquisa;
  Pc_AtivarTabelas  
end;

procedure TFr_Imp_Vendas.Pc_AtivarTabelas;
begin
  Qr_Regiao.Active := False;
  Qr_Regiao.ParamByName('EMP_TIPO').AsInteger := 1;
  Qr_Regiao.Active := True;
  Qr_Regiao.FetchAll;
  Qr_Regiao.First;
end;

procedure TFr_Imp_Vendas.DBLCB_RegiaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Regiao.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_Imp_Vendas.E_BuscaCodigoExit(Sender: TObject);
begin
  DBLCB_Empresa.KeyValue := StrToIntDef(E_BuscaCodigo.Text,0);
end;

procedure TFr_Imp_Vendas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Imp_Vendas.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Imp_Vendas.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Geral;
    Sb_Exportar.Glyph := (Fc_CarregaImagemBotao('EXPORTAR'));
    SB_Imprimir.Glyph := (Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
  END;
end;

procedure TFr_Imp_Vendas.Pc_AtivaParametros;
Begin
  EnblControl(DBLCB_Transportadora);
end;

procedure TFr_Imp_Vendas.Pc_TrataParametros_9;
Begin
  DsblControl(DBLCB_Transportadora);
end;

procedure TFr_Imp_Vendas.Pc_TrocasNasVendas(Pc_Operacao, Pc_Caminho: String);
Var
  Lc_Form : TRL_ReportVendasItens;
  Lc_Parametros : TParamVendas;
begin
  Try
    Lc_Form  := TRL_ReportVendasItens.Create(Self);
    Lc_Form.Parametros := getParametros;
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Lc_Form.Parametros.TipoItem := 'T';
      Lc_Form.Qrpt.ReportTitle := 'RELAÇÃO DE TROCAS NAS VENDAS';
      Lc_Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      Lc_Form.Buscar;
      fr_Excel.Pc_Excel(Lc_Form.Qr_Consulta,Pc_Caminho);
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;

end;

procedure TFr_Imp_Vendas.Pc_DevolucaoNasVendas(Pc_Operacao, Pc_Caminho: String);
Var
  Lc_Form : TRL_ReportVendasItens;
begin
  Try
    Lc_Form  := TRL_ReportVendasItens.Create(Self);
    Lc_Form.Parametros := getParametros;
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Lc_Form.Parametros.TipoItem := 'D';
      Lc_Form.Qrpt.ReportTitle := 'RELAÇÃO DE DEVOLUÇÃO NAS VENDAS';
      Lc_Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      Lc_Form.Buscar;
      fr_Excel.Pc_Excel(Lc_Form.Qr_Consulta,Pc_Caminho);
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;


procedure TFr_Imp_Vendas.LBx_TipoRelatorioClick(Sender: TObject);
begin
  Pc_AtivaParametros;
  case LBx_TipoRelatorio.ItemIndex of
    9:Pc_TrataParametros_9;
  end;
end;

end.
