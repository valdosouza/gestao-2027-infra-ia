unit Un_Atualiza;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Samples.Gauges, Vcl.StdCtrls, ControllerEstoque, STQuery, ControllerDskCategory, controllerProduto, RN_Financeiro, ControllerCliente, ACBrBase, ACBrValidador, ControllerGRupos, ControllerCrpItens, ControllerInventario, ControllerSubGrupos, ControllerMarcaProduto, ControllerEmbalagem, ControllerMedida, ControllerPayBack, Un_Fm_ListaEstoques, Data.DB, ControllerTabelaPreco, ControllerItensIcms, ControllerArquivo, Data.SqlExpr, Vcl.Imaging.jpeg, STScript, System.StrUtils, Data.FMTBcd,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFr_Atualiza = class(TForm)
    PageControl1: TPageControl;
    tbs_migracao: TTabSheet;
    Panel1: TPanel;
    Sb_Sair_0: TSpeedButton;
    gg_progresso: TGauge;
    Panel2: TPanel;
    Label1: TLabel;
    pnl_migracao_Local_banco: TPanel;
    E_migracao_Local_banco: TEdit;
    Sb_migracao_Local_banco: TSpeedButton;
    Sb_migracao: TSpeedButton;
    tbs_produtos: TTabSheet;
    Panel3: TPanel;
    Sb_ReordenaProduto: TButton;
    Sb_AjustaGenerator: TButton;
    Sb_VincularTabelaPreco: TButton;
    tbs_ler_arquivo_Diretorio: TTabSheet;
    Panel7: TPanel;
    SpeedButton3: TSpeedButton;
    E_PathDiretorio: TEdit;
    Button57: TButton;
    E_Dt_Ini_Ler_Arquivo: TDateTimePicker;
    E_Dt_Fim_Ler_Arquivo: TDateTimePicker;
    MM_ListaArquivos: TMemo;
    Sb_GrupoToCategoria: TButton;
    SpeedButton27: TSpeedButton;
    tbs_financeiro: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    BitBtn2: TBitBtn;
    E_Dt_Inicial_R: TDateTimePicker;
    E_Dt_Final_R: TDateTimePicker;
    Cb_TipoBancoDados: TComboBox;
    tbs_pizzaria: TTabSheet;
    Sb_Clone_Pizza_Calzone: TBitBtn;
    tbs_payback: TTabSheet;
    Button1: TButton;
    Pnl_Invent_movimentacao: TPanel;
    Label3: TLabel;
    Chbx_Inventario_Movimento: TCheckBox;
    E_Dt_Inicio_Movimento: TDateTimePicker;
    E_Dt_Fim_Movimento: TDateTimePicker;
    SpeedButton1: TSpeedButton;
    Fm_ListaEstoques: TFm_ListaEstoques;
    Qr_Produto: TSTQuery;
    SpeedButton2: TSpeedButton;
    Button2: TButton;
    Button3: TButton;
    DBUniplus: TSQLConnection;
    Qr_UniPlus_Produto: TSQLQuery;
    Qr_UniPlus_Produtoid: TLargeintField;
    Qr_UniPlus_Produtodataalteracao: TSQLTimeStampField;
    Qr_UniPlus_Produtocodigo: TWideStringField;
    Qr_UniPlus_Produtoean: TWideStringField;
    Qr_UniPlus_Produtoinativo: TSmallintField;
    Qr_UniPlus_Produtonome: TWideStringField;
    Qr_UniPlus_Produtotipo: TWideStringField;
    Qr_UniPlus_Produtopreco: TFMTBCDField;
    Qr_UniPlus_Produtolucrobruto: TBCDField;
    Qr_UniPlus_Produtopeso: TBCDField;
    Qr_UniPlus_Produtoobservacao: TWideMemoField;
    Qr_UniPlus_Produtoprecocusto: TFMTBCDField;
    Qr_UniPlus_Produtocustomedio: TFMTBCDField;
    Qr_UniPlus_Produtoquantidademinima: TFMTBCDField;
    Qr_UniPlus_Produtoncm: TWideStringField;
    Qr_UniPlus_Produtocest: TWideStringField;
    Qr_UniPlus_Produtounidademedida: TWideStringField;
    SQLConnection1: TSQLConnection;
    Qr_prod_xls: TSTQuery;
    Qr_prod_xlsCODIGO_PROD: TStringField;
    Qr_prod_xlsCODFORN_PROD: TIntegerField;
    Qr_prod_xlsCODMARCA_PROD: TFloatField;
    Qr_prod_xlsUNIDADE_PROD: TStringField;
    Qr_prod_xlsCODCATEG_PROD: TFloatField;
    Qr_prod_xlsDESCRICAO_PROD: TStringField;
    Qr_prod_xlsPRECOPADRAO_PROD: TFloatField;
    Qr_prod_xlsPRECOCUSTO_PROD: TFloatField;
    Qr_prod_xlsREFERENCIA_PROD: TStringField;
    Qr_prod_xlsTRIBUTACAO_PROD: TStringField;
    Qr_prod_xlsLUCRO_PROD: TFloatField;
    Qr_prod_xlsPRECOVISTA_PROD: TFloatField;
    Qr_prod_xlsPRECOPRAZO_PROD: TFloatField;
    Qr_prod_xlsFIS_NCM_PROD: TStringField;
    Qr_prod_xlsCEST: TStringField;
    Qr_Pessoa_tecno: TSTQuery;
    Qr_Pessoa_tecnoID: TIntegerField;
    Qr_Pessoa_tecnoUUID: TStringField;
    Qr_Pessoa_tecnoCODIGO: TIntegerField;
    Qr_Pessoa_tecnoNOME: TStringField;
    Qr_Pessoa_tecnoNOMEUSUAL: TStringField;
    Qr_Pessoa_tecnoTIPOPESSOA: TSmallintField;
    Qr_Pessoa_tecnoCPF_CNPJ: TStringField;
    Qr_Pessoa_tecnoIDESTRANGEIRO: TStringField;
    Qr_Pessoa_tecnoINDICADORIE: TSmallintField;
    Qr_Pessoa_tecnoIE: TStringField;
    Qr_Pessoa_tecnoIM: TStringField;
    Qr_Pessoa_tecnoDATAINICIO: TDateField;
    Qr_Pessoa_tecnoGRUPOPESSOA_ID: TSmallintField;
    Qr_Pessoa_tecnoLOGRADOURO: TStringField;
    Qr_Pessoa_tecnoNUMIMOVEL: TStringField;
    Qr_Pessoa_tecnoCOMPENDERECO: TStringField;
    Qr_Pessoa_tecnoBAIRRO: TStringField;
    Qr_Pessoa_tecnoCEP: TStringField;
    Qr_Pessoa_tecnoLOCALIDADE_ID: TIntegerField;
    Qr_Pessoa_tecnoVENDEDOR: TSmallintField;
    Qr_Pessoa_tecnoCLIENTE: TSmallintField;
    Qr_Pessoa_tecnoFORNECEDOR: TSmallintField;
    Qr_Pessoa_tecnoTRANSPORTADOR: TSmallintField;
    Qr_Pessoa_tecnoAVISO: TStringField;
    Qr_Pessoa_tecnoOBS: TWideMemoField;
    Qr_Pessoa_tecnoDATACAD: TDateField;
    Qr_Pessoa_tecnoTELEFONE: TStringField;
    Qr_Pessoa_tecnoEMAIL: TStringField;
    Qr_Pessoa_tecnoSUFRAMA: TStringField;
    Qr_Pessoa_tecnoBACKUPCODIGO: TIntegerField;
    Qr_Pessoa_tecnoMIGRACAOVENDEDOR: TSmallintField;
    Qr_Pessoa_tecnoMIGRACAOFORNECEDOR: TSmallintField;
    Qr_Pessoa_tecnoMIGRACAOTELEFONE: TSmallintField;
    Qr_Pessoa_tecnoCIDADE: TStringField;
    Qr_Pessoa_tecnoSIGLA: TStringField;
    Qr_Image: TSTQuery;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    DbSnack: TSQLConnection;
    Qr_Snack_Clientes: TSQLQuery;
    Qr_Snack_Clientescod_cli: TWideStringField;
    Qr_Snack_Clientesgrp_cli: TWideStringField;
    Qr_Snack_Clientescliente: TWideStringField;
    Qr_Snack_Clientesbairro: TWideStringField;
    Qr_Snack_Clientescep: TWideStringField;
    Qr_Snack_Clientesfone: TWideStringField;
    Qr_Snack_Clientesramal: TWideStringField;
    Qr_Snack_Clientesfax: TWideStringField;
    Qr_Snack_Clientescontato: TWideStringField;
    Qr_Snack_Clientese_bairro: TWideStringField;
    Qr_Snack_Clientese_cep: TWideStringField;
    Qr_Snack_Clientese_fone: TWideStringField;
    Qr_Snack_Clientese_ramal: TWideStringField;
    Qr_Snack_Clientese_fax: TWideStringField;
    Qr_Snack_Clientese_contato: TWideStringField;
    Qr_Snack_Clientescnpj: TBCDField;
    Qr_Snack_Clientesinsc_est: TWideStringField;
    Qr_Snack_Clientesdesconto: TFloatField;
    Qr_Snack_Clientescod_rep: TWideStringField;
    Qr_Snack_Clientescred_total: TBCDField;
    Qr_Snack_Clientesatraso_max: TIntegerField;
    Qr_Snack_Clientesnegra: TSmallintField;
    Qr_Snack_Clienteshistorico: TWideMemoField;
    Qr_Snack_Clientesnome_fantasia: TWideStringField;
    Qr_Snack_Clientescod_municipio: TWideStringField;
    Qr_Snack_Clienteslogradouro: TWideStringField;
    Qr_Snack_Clientesnumero: TWideStringField;
    Qr_Snack_Clientescomplemento: TWideStringField;
    Qr_Snack_Clientese_logradouro: TWideStringField;
    Qr_Snack_Clientese_numero: TWideStringField;
    Qr_Snack_Clientese_complemento: TWideStringField;
    Qr_Snack_Clientese_cod_municipio: TWideStringField;
    Qr_Snack_Clientesemail: TWideStringField;
    Qr_Snack_Clientestipo_cliente: TSmallintField;
    Qr_Snack_Clientestipo_pessoa: TSmallintField;
    Qr_Snack_Produtos: TSQLQuery;
    Qr_Snack_Produtosfilial: TWideStringField;
    Qr_Snack_Produtoscod_pro: TWideStringField;
    Qr_Snack_Produtosgrp_pro: TWideStringField;
    Qr_Snack_Produtosdescricao: TWideStringField;
    Qr_Snack_Produtosunidade: TWideStringField;
    Qr_Snack_Produtosprec_venda: TBCDField;
    Qr_Snack_Produtosprec_medio: TBCDField;
    Qr_Snack_Produtosprec_custo: TBCDField;
    Qr_Snack_Produtosmoeda: TWideStringField;
    Qr_Snack_Produtosipi: TFloatField;
    Qr_Snack_Produtosremarque: TIntegerField;
    Qr_Snack_Produtosult_remarq: TDateField;
    Qr_Snack_Produtoscomissao: TFloatField;
    Qr_Snack_Produtosult_sai: TDateField;
    Qr_Snack_Produtosult_cli: TWideStringField;
    Qr_Snack_Produtosult_ent: TDateField;
    Qr_Snack_Produtosult_for: TWideStringField;
    Qr_Snack_Produtoslocal: TWideStringField;
    Qr_Snack_Produtosestoque: TFloatField;
    Qr_Snack_Produtoscod_ncm: TWideStringField;
    Qr_Snack_Produtosstatus_exclusao: TSmallintField;
    Qr_Snack_Produtosdata_status_exclusao: TSQLTimeStampField;
    Qr_Snack_Produtosnat_op_venda: TIntegerField;
    Qr_Snack_Produtosnat_op_devolucao: TIntegerField;
    Qr_Snack_Produtosaliq_icms: TFloatField;
    Qr_Snack_Produtosreduc_bc_icms: TFloatField;
    Qr_Snack_Produtosiva_st: TFloatField;
    Qr_Snack_Produtoscst: TWideStringField;
    Qr_Snack_Produtoscod_ean: TWideStringField;
    Qr_Snack_Produtoscest: TWideStringField;
    Qr_Snack_Produtostipo_fiscal: TSmallintField;
    TabSheet1: TTabSheet;
    Button7: TButton;
    AScript: TSTScript;
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure Sb_ReordenaProdutoClick(Sender: TObject);
    procedure Sb_AjustaGeneratorClick(Sender: TObject);
    procedure Sb_VincularTabelaPrecoClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Sb_GrupoToCategoriaClick(Sender: TObject);
    procedure SpeedButton27Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Sb_migracaoClick(Sender: TObject);
    procedure Sb_Clone_Pizza_CalzoneClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure tbs_produtosShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Cb_TipoBancoDadosChange(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
    procedure MigraSistemaAntigo;
    procedure MigraClientesSistemaAntigo;
    procedure MigraGrupoSistemaAntigo;
    procedure MigraSubGrupoSistemaAntigo;
    procedure MigraMarcaSistemaAntigo;
    procedure MigraEmbalagemSistemaAntigo;
    procedure MigraMedidaSistemaAntigo;
    procedure MigraProdutosSistemaAntigo;

    procedure MigraSistemaGDOOR;
    procedure MigraCientesSistemaGDOOR;
    procedure MigraProdutosSistemaGDOOR;

    procedure MigraSistemaGestaoGestaoCompara;
    procedure MigraProduto_Para_TB_PRODUTOS;

    procedure  MigraSistemaPantera;
    procedure MigraSistemaPantera_PRODUTOS;

    procedure MigraSistemaWinsic;
    procedure MigraTB_PROD_MIGRA;
    procedure MigraSistemaWinsic_Produtos;
    procedure MigraTB_PROD_SIST_UNICO;
    procedure MigraXML_TO_XML_gestao;
    procedure MigraExcellent;
    procedure MigraUniPlus;
    procedure MigraExcelLourenco;
    procedure Alegrito;
    procedure AlegritoProdutos;
    procedure AlegritoClientes;

    procedure MigraTecno;
    procedure MigraTecnoCliente;
    procedure MigraTecnoMarca;
    procedure MigraTecnoGrupo;
    procedure MigraTecnoProduto;


    function TemAtributo(Attr, Val: Integer): Boolean;
    procedure ListarArquivos(Diretorio: string; Sub:Boolean);

    Function Fc_ConsultaCategory(Pc_Grupo,Pc_Subgrupo:String):TStringList;
    procedure Pc_AtualizaCategory(Pc_Cd_Produto,Pc_Categoria:Integer);
    Function Fc_CriaCategory(Pc_Categoria:TStringList;Pc_Grp_Descricao,Pc_Sbg_Descricao:String):Integer;

    procedure DesativaProdutosPizzaKilo;
    procedure CriarGrupoCalzone;
    procedure CriarSubGrupoCalzone;
    procedure ClonarMedidasPizzaParaCAlzone;
    procedure ClonarPizzaParaCalzone;
    procedure Pc_AtualizaEstoque;

    procedure ExecuteSQLFileIndividually(const AFileName: string);

  public
    { Public declarations }
  end;

var
  Fr_Atualiza: TFr_Atualiza;

implementation

{$R *.dfm}

uses      Un_DM, UN_Principal, env, Un_Funcoes, ControllerBase, UN_Sistema, Un_Msg;

procedure TFr_Atualiza.Alegrito;
begin
  AlegritoProdutos;
  AlegritoClientes;
end;

procedure TFr_Atualiza.AlegritoClientes;
Var
  LcCliente   : TControllerCliente;
  I : Integer;
  Lc_Fone : String;
begin
  LcCliente   := TControllerCliente.CREATE(NIL);
  Try
    DbSnack.Connected := true;
    Qr_Snack_Clientes.Active := True;
    Qr_Snack_Clientes.First;
    gg_progresso.MinValue := 0;
    gg_progresso.MaxValue := Qr_Snack_Clientes.RecordCount;
    gg_progresso.Progress := 0;
    Application.ProcessMessages;
    while not Qr_Snack_Clientes.eof do
    BEgin
      //Empresa
      with LcCliente do
      Begin
        Empresa.clear;
        Empresa.Registro.Codigo             := 0;
        Empresa.Registro.Tipo               := 1;
        Empresa.Registro.DataCadastro       := Date;
        Empresa.Registro.NomeRazaoSocial    := Copy(Qr_Snack_Clientescliente.AsString,1,99);
        Empresa.Registro.ApelidoFantasia    := Copy(Qr_Snack_Clientesnome_fantasia.AsString,1,99);
        Empresa.Registro.CpfCNPJ            := Fc_RemoveCaracterInformado(Qr_Snack_Clientescnpj.AsString,['.','.','.','-','/',' ']);
        Empresa.Registro.InscricaoEstadual  := Qr_Snack_Clientesinsc_est.AsString;
        Empresa.Registro.Observacao         := Qr_Snack_Clienteshistorico.AsString;
        //Empresa.Registro.DataFundacao       :=
        if Qr_Snack_Clientestipo_pessoa.AsString = '1' then
          Empresa.Registro.TipoPessoa         := 'J'
        else
          Empresa.Registro.TipoPessoa         := 'F';
        Empresa.Registro.Email              := Qr_Snack_Clientesemail.AsString;
        Empresa.Registro.WebSite            := '';
        Empresa.Registro.ConsumidorFinal    := 'S';
        Empresa.Registro.Multiplicador      := 1;
        Empresa.Registro.Ativa              := 'S';
        Empresa.Registro.OptantePeloSimples := 'N';
        Empresa.Registro.IndicadorInscricaoEstadual := '1';
        Empresa.insert;
        //Endereco
        Empresa.Endereco.clear;
        Empresa.Endereco.Registro.Codigo        := 0;
        Empresa.Endereco.Registro.CodigoEmpresa := Empresa.Registro.Codigo;
        Empresa.Endereco.Registro.Cnpj          := Empresa.Registro.CpfCNPJ;
        Empresa.Endereco.Registro.Tipo          := 'COMERCIAL';
        Empresa.Endereco.Registro.EnderecoPrincipal := 'S';
        Empresa.Endereco.Registro.Logradouro    := Qr_Snack_Clienteslogradouro.AsString;
        Empresa.Endereco.Registro.Complemento   := Qr_Snack_Clientescomplemento.AsString;
        Empresa.Endereco.Registro.Bairro        := Qr_Snack_Clientesbairro.AsString;
        Empresa.Endereco.Registro.Cep           := Fc_RemoveCaracterInformado( Qr_Snack_Clientescep.AsString ,['-',' ']);
        Empresa.Endereco.Registro.Contato       := Qr_Snack_Clientescontato.AsString;

        Lc_Fone := Fc_RemoveCaracterInformado( Qr_Snack_Clientesfone.AsString ,['(','x',')','-',' ']);
        if Copy(Lc_Fone,1,1) = '0' then
          Empresa.Endereco.Registro.Fone          := Copy(Lc_Fone,2,Length(Lc_Fone)-1)
        else
          Empresa.Endereco.Registro.Fone          := Lc_Fone;

        Lc_Fone := Fc_RemoveCaracterInformado( Qr_Snack_Clientesfax.AsString ,['(','x',')','-',' ']);
        if Copy(Lc_Fone,1,1) = '0' then
          Empresa.Endereco.Registro.Fax          := Copy(Lc_Fone,2,Length(Lc_Fone)-1)
        else
          Empresa.Endereco.Registro.Fax          := Lc_Fone;

        Empresa.Endereco.Registro.NumeroPredial := Qr_Snack_Clientesnumero.AsString;
        Empresa.Endereco.Registro.CodigoPais    := 1058;
        if Qr_Snack_Clientescod_municipio.AsString <> '' then
        Begin
          Empresa.Endereco.Cidade.Registro.Codigo := Qr_Snack_Clientescod_municipio.AsInteger;
          Empresa.Endereco.Cidade.getByIBGE;
          Empresa.Endereco.Registro.CodigoCidade  := Empresa.Endereco.Cidade.Registro.Codigo;
          Empresa.Endereco.Registro.CodigoEstado  := Fc_BuscaCodigoEstado(Empresa.Endereco.Cidade.Registro.Estado);
        End
        else
        Begin
          Empresa.Endereco.Registro.CodigoCidade  := 4004;
          Empresa.Endereco.Registro.CodigoEstado  := 41;

        End;
        Empresa.Endereco.insert;
        //Cliente
        Registro.Codigo             := LcCliente.Empresa.Registro.Codigo;
        Registro.Ativo              := 'S';
        Registro.EnviarSomenteXML   := 'N';
        Registro.ValorEntrega       := 0;
        Registro.EnviaEmailNFeAuto  := 'N';
        salva;
      End;
      gg_progresso.Progress := gg_progresso.Progress + 1;
      Application.ProcessMessages;
      Qr_Snack_Clientes.Next;
    End;

  Finally
    FreeAndNil(LcCliente);
  End;
end;

procedure TFr_Atualiza.AlegritoProdutos;
Var
  LcProduto : TControllerProduto;
  LcCliente   : TControllerCliente;
  I : Integer;
  LcVAlida: TACBrValidador;
  LcAchou : Boolean;
begin
  LcVAlida := TACBrValidador.Create(nil);
  LcVAlida.TipoDocto := docGTIN;
  LcProduto := TControllerProduto.Create(Nil);

  try
    DbSnack.Connected := true;
    Qr_Snack_Produtos.Active := True;
    gg_progresso.MinValue := 0;
    gg_progresso.MaxValue := Qr_Snack_Produtos.RecordCount;
    gg_progresso.Progress := 0;
    Application.ProcessMessages;

    while not Qr_Snack_Produtos.eof do
    BEgin
      LcProduto.Clear;
      LcVAlida.Documento := TRIM(Qr_Snack_Produtoscod_ean.AsString);
      if LcVAlida.Validar then
      Begin
        LcProduto.Registro.CodigoBarras := TRIM(Qr_Snack_Produtoscod_ean.AsString);
        LcProduto.getbyBarCode;
        LcAchou := LcProduto.exist;
      End
      else
      Begin
        LcProduto.Registro.CodigoBarras := '';
      End;


      with LcPRoduto.Registro do
      Begin
        Codigo                := 0;
        CodigoEstabelecimento := Gb_CodMha;
        CodigoFabrica         := Qr_Snack_Produtoscod_pro.AsString;
        //CodigoBarras          := TRIM(FieldByName('CODIGO').AsString); foi preenchido no inicio
        CodigoNCM              := TRIM(Qr_Snack_Produtoscod_ncm.AsString);
        CEST                  := Copy(TRIM(Qr_Snack_Produtoscest.AsString),1,7);
        Descricao             := Copy( UpperCase( TRIM(Qr_Snack_Produtosdescricao.AsString) ),1,98);


        LcProduto.Medida.Registro.Descricao   := UpperCase( TRIM( Qr_Snack_Produtosunidade.AsString) );
        LcProduto.Medida.Registro.Abreviatura := UpperCase( TRIM( Qr_Snack_Produtosunidade.AsString) );
        LcProduto.Medida.getIdAutoByDesc;
        MedidaComercial       := LcProduto.Medida.Registro.Codigo;

        LcProduto.Embalagem.Registro.Descricao := 'NORMAL';
        LcProduto.Embalagem.Registro.Abreviatura := 'NRL';
        LcProduto.Embalagem.getIdAutoByDesc;
        CodigoEmbalagem       := LcProduto.Embalagem.Registro.Codigo;

        CodigoGrupo           := LcProduto.Grupo.autocreate('GERAL');
        CodigoSubgrupo        := LcProduto.Grupo.SubGRupo.autocreate(CodigoGrupo,'DIVERSOS');

        Divisor               := 1;
        Origem                := '0';
        Tipo                  := 'P';
        ValorFabrica          :=  0;
        ValorCustoMedio       := Qr_Snack_Produtosprec_medio.AsFloat;
        ValorCustoMedioAnt    := Qr_Snack_Produtosprec_medio.AsFloat;
        ValorCusto            := Qr_Snack_Produtosprec_custo.AsCurrency;
        ValorCustoAnt         := Qr_Snack_Produtosprec_custo.AsCurrency;
        if Qr_Snack_Produtoscest.AsString <> '' then
          SubsTrib              := 'S'
        else
          SubsTrib              := 'N';
        Campanha              := 'N';
        Destaque              := 'N';
        Ativo                 := 'S';
        Imprime               := 'S';
        EstoqueNegativo       := 'S';
        Exclusivo             := 'N';
        Internet              := 'N';
        MaisVendido           := 'N';
        Composicao            := '1';
        CodigoMarca           := 1;
        FinalidadeTributacao  := '1';
        UtilizaSerie          := 'N';
        Venda                 := 'S';
        ForaLinha             := 'N';
        CEST                  := '';
        IndicacaoEscala       := 'S';
        Localizacao           := '';
      end;
      LcProduto.insert;

      //TAbela 1
      LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
      LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
      LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
      LcProduto.TabelaPreco.Preco.Registro.Valor          := Qr_Snack_Produtosprec_venda.AsFloat;
      LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
      LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
      LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
      LcProduto.TabelaPreco.Preco.Insert;
      //TAbela 2
      LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
      LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 2;
      LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
      LcProduto.TabelaPreco.Preco.Registro.Valor          := 0;
      LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
      LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
      LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
      LcProduto.TabelaPreco.Preco.Insert;

      LcProduto.Estoque.SaldoEstoque.Registro.Codigo := 0;
      LcProduto.Estoque.SaldoEstoque.Registro.CodigoProduto := LcProduto.Registro.Codigo;
      LcProduto.Estoque.SaldoEstoque.Registro.CodigoEstoque := 1;
      LcProduto.Estoque.SaldoEstoque.Registro.QtdeDisp := 0;
      LcProduto.Estoque.SaldoEstoque.Insert;

      gg_progresso.Progress := gg_progresso.Progress + 1;
      Application.ProcessMessages;
      Qr_Snack_Produtos.Next;
    End;
  finally
    LcProduto.setGenerator('GN_PRODUTO', Qr_UniPlus_Produtoid.AsString);
    FreeAndNil(LcProduto);
  end;


end;

procedure TFr_Atualiza.BitBtn2Click(Sender: TObject);
Var
  LcQry : TSTQuery;
Begin
  LcQry := TSTQuery.create(nil);
  with LcQry do
  Begin
    LcQry.DataBase := DM.IBD_Gestao;
    LcQry.Transaction := DM.IBT_Consulta;
    if DM.IBT_Consulta.InTransaction then DM.IBT_Consulta.Commit;

    LcQry.Sql.Clear;
    LcQry.Sql.Add(concat(
                    'SELECT ',
                    'NFL_DT_EMISSAO, ',
                    'PED_CODIGO, ',
                    'PEd_NUMERO, ',
                    'NFL_CODIGO, ',
                    'NFL_NUMERO, ',
                    'PED_CODEMP, ',
                    'PED_CODFPG, ',
                    'PED_PRAZO, ',
                    'nfl_vl_tl_nota ',
                    'FROM tb_nota_fiscal ',
                    '  INNER JOIN tb_pedido ',
                    '  ON (PED_CODIGO = NFL_CODPED) ',
                    '  LEFT  OUTER JOIN tb_financeiro ',
                    '  ON (FIN_CODNFL = NFL_CODIGO) ',
                    'WHERE PED_TIPO <> 3 AND PED_TIPO <> 2 ',
                    'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ',
                    'AND NFL_STATUS = ''F''  ',
                    'AND FIN_CODIGO IS NULL  '
    ));
    Active := False;
    ParamByName('DATAINI').AsDate := E_Dt_Inicial_R.Date;
    ParamByName('DATAFIM').AsDate := E_Dt_Final_R.Date;
    Active := True;
    FetchAll;
    First;
    gg_progresso.Progress := 0;
    gg_progresso.MinValue := 0;
    gg_progresso.MaxValue := RecordCount;
    while not eof do
    Begin
      Pc_GeraContasReceber(DM.IB_Transacao,
                           FieldByName('NFL_DT_EMISSAO').AsDateTime,
                           FieldByName('PED_CODIGO').AsInteger,
                           FieldByName('PED_NUMERO').AsString,
                           FieldByName('NFL_CODIGO').AsInteger,
                           FieldByName('NFL_NUMERO').AsString,
                           FieldByName('PED_CODEMP').asinteger,
                           FieldByName('PED_CODFPG').AsInteger,
                           StrToIntDef(Copy(FieldByName('PED_PRAZO').AsString,1,3),1),
                           FieldByName('PED_PRAZO').AsString,
                           FieldByName('NFL_VL_TL_NOTA').AsCurrency);
      gg_progresso.Progress := gg_progresso.Progress + 1;
      Application.ProcessMessages;
      Next;
    end;
    ShowMessage('Operação realizada com sucesso.');
  end;
end;

procedure TFr_Atualiza.Button1Click(Sender: TObject);
Var
  LcPayBack : TControllerPayBack;
  I : Integer;
begin
  LcPayBack := TControllerPayBack.create(nil);
  Try
    //Apaga os creditos expirados para fazer novamente
    LcPayBack.Parametros.Estabelecimento := Gb_Codmha;
    LcPayBack.Parametros.PayBack.Historico := 'Crédito expirado periodo';
    LcPayBack.DeletaRegistrosCreditoExpirados;

    //PEga dados de configuração
    LcPayBack.Parametros.Dias := StrToIntDef(Fc_Tb_Geral('L','PAYBACK_DT_EXPIRED','365'),365);
    LcPayBack.Parametros.ValorMinimo := StrToFloatDEf(Fc_Tb_Geral('L','PAYBACK_VL_MINIMO','0'),0.0);
    LcPayBack.Parametros.Estabelecimento := Gb_CodMha;
    LcPayBack.Parametros.Terminal := Gb_Terminal;
    //PEga a lista completa do payback
    LcPayBack.getList;
    gg_progresso.Progress := 0;
    gg_progresso.MinValue := 0;
    gg_progresso.MaxValue := LcPayBack.Lista.Count;
    //Atualiza o vencimento
    for I := 0 to LcPayBack.Lista.Count - 1 do
    Begin
      LcPayBack.ClonarObj(LcPayBack.Lista[I],LcPayBack.Registro);
      LcPayBack.registro.DataExpira := LcPayBack.registro.Data + LcPayBack.Parametros.Dias;
      LcPayBack.update;
      gg_progresso.Progress := gg_progresso.Progress + 1;
      Application.ProcessMessages;
    End;

  Finally
    gg_progresso.Progress := gg_progresso.MaxValue;
    Application.ProcessMessages;
    FreeAndNil(LcPayBack);
  End;
end;

procedure TFr_Atualiza.Button2Click(Sender: TObject);
Var
  Lc_Qry : TSTQuery;
  Lc_Qry_Last : TSTQuery;
  LcProduto : TControllerProduto;
  I : Integer;
begin
  LcProduto := TControllerProduto.create(nil);
  try
    Lc_Qry_Last := LcProduto.GeraQuery;
    with Lc_Qry_Last do
    Begin
       sql.Add(concat(
                'select first 1 pr.pro_codigo, it.itf_vl_unit , Max(nf.nfl_dt_emissao + nf.nfl_hr_saida) Data ',
                'from tb_itens_nfl it ',
                '   inner join tb_pedido pe ',
                '   on (pe.ped_codigo = it.itf_codped) ',
                '   inner join tb_nota_fiscal nf ',
                '   on (nf.nfl_codped = pe.ped_codigo ) ',
                '   inner join tb_produto pr ',
                '   on (pr.pro_codigo = it.itf_codpro) ',
                'where pe.ped_tipo = 2 ',
                'and pe.ped_faturado = ''S'' ',
                'and pro_codigo =:pro_codigo ',
                'group by 1,2 ',
                'order by 3 desc '
      ));
    End;

    Lc_Qry := LcProduto.GeraQuery;
    with Lc_Qry do
    Begin
       sql.Add(concat(
                'select PRO_CODIGO ',
                'from tb_PRODUTO '
      ));
      Active := True;
      FetchAll;
      gg_progresso.Progress := 0;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      Application.ProcessMessages;
      First;
      while not eof do
      Begin
        Lc_Qry_Last.Active := False;
        Lc_Qry_Last.ParamByName('pro_codigo').AsInteger := FieldByName('PRO_CODIGO').AsInteger;
        Lc_Qry_Last.Active := True;
        Lc_Qry_Last.FetchAll;
        if Lc_Qry_Last.RecordCount > 0 then
        Begin
          LcProduto.Registro.Codigo       := Lc_Qry_Last.FieldByName('PRO_CODIGO').AsInteger;
          LcProduto.Registro.UltimoCusto  := Lc_Qry_Last.FieldByName('itf_vl_unit').AsCurrency;
          LcProduto.AtualizaUltimoCusto
        End;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;
  Finally
    gg_progresso.Progress := gg_progresso.MaxValue;
    Application.ProcessMessages;
    LcProduto.FinalizaQuery(Lc_Qry);
    LcProduto.FinalizaQuery(Lc_Qry_Last);
    FreeAndNil(LcProduto);
  End;
end;

procedure TFr_Atualiza.Button3Click(Sender: TObject);
Var
  Lc_Qry : TSTQuery;
  ItensIcms : TControllerItensIcms;
  I : Integer;
begin
  ItensIcms := TControllerItensIcms.create(nil);
  try
    Lc_Qry := ItensIcms.GeraQuery;
    with Lc_Qry do
    Begin
       sql.Add(concat(
                 ' select NFL_CODIGO, ITF_cODIGO ',
                 ' from tb_nota_fiscal N ',
                 '   INNER JOIN tb_retorno_nfc NC ',
                 '   ON (NC.nfc_codnfl = N.nfl_codigo) ',
                 '   INNER JOIN tb_itens_nfl I ',
                 '   ON (I.itf_codnfl = N.nfl_codigo) ',
                 '   LEFT OUTER JOIN tb_itens_icms  ICM ',
                 '   ON (ICM.icm_coditf = I.itf_codigo) ',
                 ' where N.nfl_dt_emissao =:nfl_dt_emissao ',
                 ' AND ICM.icm_codigo IS NULL '
      ));
      ParamByname('nfl_dt_emissao').AsDateTime := StrtoDate('18/10/2021');
      Active := True;
      FetchAll;
      gg_progresso.Progress := 0;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      Application.ProcessMessages;
      First;
      while not eof do
      Begin

        ItensIcms.Registro.codigo             := 0;
        ItensIcms.Registro.Nota               := FieldByName('NFL_CODIGO').AsInteger;
        ItensIcms.Registro.ItemNota           := FieldByName('ITF_CODIGO').AsInteger;
        ItensIcms.Registro.CST                := 0;
        ItensIcms.Registro.CSOSN              := 2;
        ItensIcms.Registro.Origem             := '0';
        ItensIcms.Registro.Determinacao       := '3';
        ItensIcms.Registro.AliqRedBase        := 0;
        ItensIcms.Registro.ValorBase          := 0;
        ItensIcms.Registro.Aliquota           := 0;
        ItensIcms.Registro.AliquotaReduzida   := 0;
        ItensIcms.Registro.Valor              := 0;
        ItensIcms.Registro.DeterminacaoBaseST := '0';
        ItensIcms.Registro.AliqRedBaseST      := 0;
        ItensIcms.Registro.MVA                := 0;
        ItensIcms.Registro.ValorBaseST        := 0;
        ItensIcms.Registro.AliquotaST         := 0;
        ItensIcms.Registro.AliqRedST          := 0;
        ItensIcms.Registro.ValorST            := 0;
        ItensIcms.Registro.Desoneracao        := 0;
        ItensIcms.Registro.VAlorBaseSTRetido  := 0;
        ItensIcms.Registro.ValorSTRetido      := 0;
        ItensIcms.Registro.Partilha           := '';
        ItensIcms.Registro.Repasse            := '';
        ItensIcms.Registro.BaseICMSRetido     := 0;
        ItensIcms.Registro.ValorICMSRetido    := 0;
        ItensIcms.Registro.AliqCalcCred       := 0;
        ItensIcms.Registro.CreditoAprox       := 0;
        ItensIcms.Registro.ValorFrete         := 0;
        ItensIcms.Registro.Seguro             := 0;
        ItensIcms.Registro.OutrasDespesas     := 0;
        ItensIcms.Registro.CFOP               := 251;
        ItensIcms.Registro.Destacar           := 'N';
        ItensIcms.Registro.Observacao         := 0;
        ItensIcms.insere;

        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;
  Finally
    gg_progresso.Progress := gg_progresso.MaxValue;
    Application.ProcessMessages;
    ItensIcms.FinalizaQuery(Lc_Qry);
    FreeAndNil(ItensIcms);
  End;
end;

procedure TFr_Atualiza.Button4Click(Sender: TObject);
Var
  LcPayBack : TControllerPayBack;
  I : Integer;
begin
  LcPayBack := TControllerPayBack.create(nil);
  Try
    //PEga dados de configuração
    LcPayBack.Parametros.Dias := StrToIntDef(Fc_Tb_Geral('L','PAYBACK_DT_EXPIRED','365'),365);
    LcPayBack.Parametros.ValorMinimo := StrToFloatDEf(Fc_Tb_Geral('L','PAYBACK_VL_MINIMO','0'),0.0);
    LcPayBack.Parametros.Estabelecimento := Gb_CodMha;
    LcPayBack.Parametros.Terminal := Gb_Terminal;

    //PEga a lista completa do payback
    LcPayBack.Parametros.PayBack.Historico := 'Utilização Crédito';
    LcPayBack.getListCreditoUtilizado;

    gg_progresso.Progress := 0;
    gg_progresso.MinValue := 0;
    gg_progresso.MaxValue := LcPayBack.Lista.Count;
    //Atualiza o vencimento
    for I := 0 to LcPayBack.Lista.Count - 1 do
    Begin
      LcPayBack.Parametros.Estabelecimento := Gb_Codmha;
      LcPayBack.Parametros.PayBack.Data := LcPayBack.Lista[i].Data;
      LcPayBack.Parametros.PayBack.Cliente := LcPayBack.Lista[i].Cliente;
      LcPayBack.Parametros.PayBack.ValorDebito := LcPayBack.Lista[i].ValorDebito;
      LcPayBack.UtilizaCredito;

      gg_progresso.Progress := gg_progresso.Progress + 1;
      Application.ProcessMessages;
    End;

  Finally
    gg_progresso.Progress := gg_progresso.MaxValue;
    Application.ProcessMessages;
    FreeAndNil(LcPayBack);
  End;
end;

procedure TFr_Atualiza.Button5Click(Sender: TObject);
Var
  LcPayBack : TControllerPayBack;
  I : Integer;
begin
  LcPayBack := TControllerPayBack.create(nil);
  Try
    //PEga dados de configuração
    LcPayBack.Parametros.Dias := StrToIntDef(Fc_Tb_Geral('L','PAYBACK_DT_EXPIRED','365'),365);
    LcPayBack.Parametros.ValorMinimo := StrToFloatDEf(Fc_Tb_Geral('L','PAYBACK_VL_MINIMO','0'),0.0);
    LcPayBack.Parametros.Estabelecimento := Gb_CodMha;
    LcPayBack.Parametros.Terminal := Gb_Terminal;

    //PEga a lista completa do payback
    LcPayBack.Parametros.PayBack.Historico := 'Expirado';
    LcPayBack.Parametros.PayBack.Data := Date -LcPayBack.Parametros.Dias;
    LcPayBack.RegistraCreditoExpirado;

  Finally
    gg_progresso.Progress := gg_progresso.MaxValue;
    Application.ProcessMessages;
    FreeAndNil(LcPayBack);
  End;
end;

procedure TFr_Atualiza.Button6Click(Sender: TObject);
Var
  LcPayBack : TControllerPayBack;
  I : Integer;
begin
  LcPayBack := TControllerPayBack.create(nil);
  Try
    //PEga dados de configuração
    LcPayBack.Parametros.Dias := StrToIntDef(Fc_Tb_Geral('L','PAYBACK_DT_EXPIRED','365'),365);
    LcPayBack.Parametros.ValorMinimo := StrToFloatDEf(Fc_Tb_Geral('L','PAYBACK_VL_MINIMO','0'),0.0);
    LcPayBack.Parametros.Estabelecimento := Gb_CodMha;
    LcPayBack.Parametros.Terminal := Gb_Terminal;

    //PEga a lista completa do payback
    LcPayBack.Parametros.PayBack.Historico := 'Utilização Crédito';
    LcPayBack.getListCreditEstornado;

    gg_progresso.Progress := 0;
    gg_progresso.MinValue := 0;
    gg_progresso.MaxValue := LcPayBack.ListaCreditoEstornado.Count;
    //Atualiza o vencimento
    for I := 0 to LcPayBack.ListaCreditoEstornado.Count - 1 do
    Begin
      LcPayBack.ClonarObj(LcPayBack.ListaCreditoEstornado[i],LcPayBack.Registro);
      LcPayBack.Registro.ValorCredito := LcPayBack.Registro.ValorDebito * -1;
      LcPayBack.Registro.ValorDebito := 0;
      LcPayBack.Registro.Historico := StringReplace(LcPayBack.Registro.Historico,'Extorno','Estorno',[rfReplaceAll, rfIgnoreCase]);
      LcPayBack.Registro.Situacao := 'Estornado';
      LcPayBack.update;

      gg_progresso.Progress := gg_progresso.Progress + 1;
      Application.ProcessMessages;
    End;

  Finally
    gg_progresso.Progress := gg_progresso.MaxValue;
    Application.ProcessMessages;
    FreeAndNil(LcPayBack);
  End;

end;

procedure TFr_Atualiza.Button7Click(Sender: TObject);
begin
   ExecuteSQLFileIndividually(
      ExtractFilePath(Application.ExeName) + 'TB_ECLASS_StringPK_Populate_Corrected.sql' );

end;

procedure TFr_Atualiza.Cb_TipoBancoDadosChange(Sender: TObject);
begin
  case Cb_TipoBancoDados.ItemIndex of
    10:Begin
        E_migracao_Local_banco.Clear;
        E_migracao_Local_banco.Enabled := False;
    End
    else
    Begin
      E_migracao_Local_banco.Enabled := True;
    End;
  end;
end;

procedure TFr_Atualiza.ClonarMedidasPizzaParaCAlzone;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  LcProduto : TControllerProduto;
begin
  LcProduto := TControllerProduto.create(nil);
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
       sql.Add(concat(
                'select MED_CODIGO ',
                'from tb_medida M ',
                'where M.med_especial = ''PIZZA'' ',
                ' AND M.med_descricao = ''CALZONE'' '
      ));
      Active := True;
      First;
      while not eof do
      Begin
        LcProduto.Medida.Clear;
        LcProduto.Medida.Registro.Codigo := FieldByName('MED_CODIGO').AsInteger;
        LcProduto.Medida.getbyId;
        LcProduto.Medida.Registro.Codigo := 0;
        LcProduto.Medida.Registro.MedidaCardapio := 'CALZONE';
        LcProduto.Medida.getbyDescricaoMedidaCardapio;
        if not LcProduto.Medida.exist then
          LcProduto.Medida.insere;
        Next;
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
    FreeAndNil(LcProduto);
  End;


end;

procedure TFr_Atualiza.ClonarPizzaParaCalzone;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  LcProduto : TControllerProduto;
  LcIngredientes : TControllerCrpItens;
  Lc_Grupo : Integer;
  Lc_SubGrupo : Integer;
  Lc_Medida : Integer;
  I : Integer;
begin
  LcProduto := TControllerProduto.create(nil);
  Try
    LcIngredientes := TControllerCrpItens.create(nil);
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    //Guardar os codigo de grupo e Subgrupo;
    Lc_Grupo    := LcProduto.Grupo.autocreate('CALZONE');
    //Medida
    LcProduto.Medida.Registro.Descricao      := 'CALZONE';
    LcProduto.Medida.Registro.MedidaCardapio := 'CALZONE';
    LcProduto.Medida.getbyDescricaoMedidaCardapio;
    Lc_Medida := LcProduto.Medida.Registro.Codigo;
    with Lc_Qry do
    Begin
       sql.Add(concat(
                'select distinct  pro_Codigo,PRO_DESCRICAO, m.med_descricao, s.sbg_descricao,PRO_CODGRP ',
                'from tb_produto p ',
                '  inner join tb_grupos g ',
                '  on (g.grp_codigo = p.pro_codgrp) ',
                '  inner join tb_medida m ',
                '  on (m.med_codigo = p.pro_codmed) ',
                '  inner join tb_subgrupos s ',
                '  on (s.sbg_codigo = p.pro_codsbg) ',
                'where p.pro_ativo = ''S'' ',
                ' and g.grp_descricao = ''PIZZA'' ',
                ' AND M.med_descricao = ''CALZONE'' ',
                'ORDER BY PRO_DESCRICAO '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.Progress := 0;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      Application.ProcessMessages;
      while not eof do
      Begin
        LcProduto.clear;
        LcProduto.Registro.Codigo := FieldByName('PRO_CODIGO').AsInteger;
        LcProduto.getbyId;
        LcProduto.Registro.Codigo := 0;
        LcProduto.Registro.CodigoGrupo := Lc_Grupo;
        LcProduto.Registro.CodigoSubgrupo := LcProduto.Grupo.SubGRupo.autocreate(Lc_Grupo, FieldByName('SBG_DESCRICAO').AsString);
        LcProduto.Registro.MedidaComercial := Lc_Medida;
        LcProduto.insert;
        //Ingredientes
        LcIngredientes.Clear;
        LcIngredientes.Registro.Grupo := FieldByName('PRO_CODGRP').AsInteger;
        LcIngredientes.Registro.Sabor :=  FieldByName('PRO_DESCRICAO').AsString;
        LcIngredientes.getList;
        for I := 0 to LcIngredientes.Lista.Count -1 do
        Begin
          LcIngredientes.Clear;
          LcIngredientes.ClonarObj(LcIngredientes.Lista[I],LcIngredientes.Registro);
          LcIngredientes.Registro.Codigo := 0;
          LcIngredientes.Registro.CodigoProduto := LcProduto.Registro.Codigo;
          LcIngredientes.Registro.Grupo := Lc_Grupo;
          LcIngredientes.insert;
        End;
        //Preco
        LcProduto.TabelaPreco.Preco.clear;
        LcProduto.TabelaPreco.Preco.Registro.CodigoProduto := FieldByName('PRO_CODIGO').AsInteger;
        LcProduto.TabelaPreco.Preco.getList;
        for I := 0 to LcProduto.TabelaPreco.Preco.Lista.Count -1 do
        Begin
          LcProduto.TabelaPreco.Preco.clear;
          LcProduto.ClonarObj(LcProduto.TabelaPreco.Preco.Lista[I],LcProduto.TabelaPreco.Preco.Registro);
          LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
          LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
          //LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := LcProduto.TabelaPreco.Preco.Lista[I].CodigoTabela;
          //LcProduto.TabelaPreco.Preco.Registro.Valor          := LcProduto.TabelaPreco.Preco.Lista[I].Valor;
          //LcProduto.TabelaPreco.Preco.Registro.AliComissao    := LcProduto.TabelaPreco.Preco.Lista[I].AliComissao;
          //LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := LcProduto.TabelaPreco.Preco.Lista[I].QtdeMinima;
//          /LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := LcProduto.TabelaPreco.Preco.Lista[I].MargemLucro;
          LcProduto.TabelaPreco.Preco.Insert;
        End;
        //EStoque
        LcProduto.Estoque.SaldoEstoque.CriaRegistroAutomatico(LcProduto.Registro.Codigo);
        Next;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
      End;
    End;
  Finally
    gg_progresso.Progress := gg_progresso.MaxValue;
    Application.ProcessMessages;
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
    FreeAndNil(LcProduto);
    FreeAndNil(LcIngredientes);
  End;


end;

procedure TFr_Atualiza.CriarGrupoCalzone;
Var
  LcProduto : TControllerProduto;
begin
  LcProduto := TControllerProduto.create(nil);
  Try
    LcProduto.Grupo.getByDescricao('Calzone');
    if not LcProduto.Grupo.exist then
    Begin
      LcProduto.Grupo.getByDescricao('Pizza');
      if LcProduto.Grupo.exist then
      Begin
        LcProduto.Grupo.Registro.Codigo := 0;
        LcProduto.Grupo.Registro.Descricao := 'CALZONE';
        LcProduto.Grupo.insert;
      End;
    End;
  Finally
    FreeAndNil(LcProduto);
  End;
end;

procedure TFr_Atualiza.CriarSubGrupoCalzone;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  LcProduto : TControllerProduto;
  Lc_Grupo : Integer;
begin
  LcProduto := TControllerProduto.create(nil);
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    Lc_Grupo  := LcProduto.Grupo.autocreate('CALZONE');
    with Lc_Qry do
    Begin
       sql.Add(concat(
                'select S.* ',
                'from tb_subgrupos s ',
                '    inner join tb_grupos g ',
                '    on (g.grp_codigo = s.sbg_codgrp) ',
                'where g.grp_descricao = ''PIZZA'' ',
                ' and SBG_ATIVO = ''S'' '
      ));
      Active := True;
      First;
      while not eof do
      Begin
        with LcProduto.Grupo do
        Begin
          SubGRupo.Clear;
          SubGRupo.Registro.Codigo      := 0;
          SubGRupo.Registro.Grupo       := Lc_Grupo;
          SubGRupo.Registro.Descricao   := FieldByName('SBG_DESCRICAO').AsString;
          SubGRupo.Registro.Abas        := FieldByName('SBG_ABAS').AsString;
          SubGRupo.Registro.Impressora  := FieldByName('SBG_CODIMP').AsInteger;
          SubGRupo.Registro.Sequencia   := FieldByName('SBG_SEQUENCIA').AsInteger;
          SubGRupo.Registro.ATivos      := FieldByName('SBG_ATIVO').AsString;
        End;
        LcProduto.Grupo.SubGRupo.getByDescricao(Lc_Grupo,FieldByName('SBG_DESCRICAO').AsString);
        if not LcProduto.Grupo.SubGRupo.exist then
          LcProduto.Grupo.SubGRupo.insert
        else
          LcProduto.Grupo.SubGRupo.salva;
        Next;
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
    FreeAndNil(LcProduto);
  End;


end;

procedure TFr_Atualiza.DesativaProdutosPizzaKilo;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  LcProduto : TControllerProduto;
begin
  LcProduto := TControllerProduto.create(nil);
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
       sql.Add(concat(
                'select PRO_CODIGO ',
                'from tb_produto p ',
                'where p.pro_codgrp = 1 ',
                'and p.pro_codmed = 39 ',
                'and p.pro_ativo = ''S'' '
      ));
      Active := True;
      First;
      while not eof do
      Begin
        LcProduto.Registro.Codigo  := FieldByName('PRO_CODIGO').AsInteger;
        LcProduto.Registro.Ativo := 'N';
        LcProduto.Ativa;
        Next;
      End;
      //Altera Tirando Grupo Kilo do Cardapio
      Active := false;
      sql.Clear;
      sql.Add(concat(
                'UPDATE TB_MEDIDA SET ',
                '    MED_ESPECIAL = null, ',
                '    MED_PROPORCAO = 0, ',
                '    MED_SEQUENCIA = 0 ',
                'WHERE MED_CODIGO in ( ',
                'select med_codigo ',
                'from tb_medida m ',
                'where upper( m.med_descricao) = ''KILO''  ',
                'AND  upper( m.med_especial) = ''PIZZA'' ',
                ')'
      ));
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
    FreeAndNil(LcProduto);
  End;


end;

procedure TFr_Atualiza.ExecuteSQLFileIndividually(const AFileName: string);
var
  AllLines, StmtLines: TStringList;
  Line: string;
begin
  AllLines := TStringList.Create;
  StmtLines := TStringList.Create;
  try
    // 1. Carrega todo o arquivo
    AllLines.LoadFromFile(AFileName);

    // 2. Percorre cada linha, acumulando até encontrar ';' no fim
    for Line in AllLines do
    begin
      // Ignora linhas em branco
      if Trim(Line) = '' then
        Continue;

      StmtLines.Add(Line);

      // Quando a linha termina em ';', executa o bloco
      if AnsiEndsText(';', Trim(Line)) then
      begin

        AScript.Script.Clear;
        AScript.Script.AddStrings(StmtLines);

        try
          if not DM.IBT_Crud.InTransaction then
            DM.IBT_Crud.StartTransaction;
          // TODO : Script.ExecuteScript
          //AScript.ExecuteScript;
          if DM.IBT_Crud.InTransaction then
            DM.IBT_Crud.Commit;
        except
          StmtLines.Clear;
          //on E: Exception do
          //  raise Exception.CreateFmt(
          //    'Erro ao executar bloco:' + sLineBreak +
          //    '%s' + sLineBreak +
          //    'Mensagem: %s',
          //    [StmtLines.Text, E.Message]
//          /  );
        end;

        StmtLines.Clear;
      end;
    end;

    // Caso reste algum bloco sem ';' final
    if StmtLines.Count > 0 then
    begin
      AScript.Script.Clear;
      AScript.Script.AddStrings(StmtLines);
      DM.IBT_Crud.StartTransaction;
     // TODO : Script.ExecuteScript
      //AScript.ExecuteScript;
      DM.IBT_Crud.Commit;
    end;

  finally
    AllLines.Free;
    StmtLines.Free;
  end;

end;

function TFr_Atualiza.Fc_ConsultaCategory(Pc_Grupo,
  Pc_Subgrupo: String): TStringList;
var
  Lc_Qry: TSTQuery;
  Lc_Txt: String;
  Lc_Nivel : String;
begin
  Result := TStringList.Create;
  Lc_Qry := TSTQuery.Create(Self);
  Try
    Lc_Nivel := '';
    Result.Clear;
    Result.Add('0');
    Result.Add('0');
    with Lc_Qry do
    Begin
      Database := Dm.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      ForcedRefresh := True;
      Active := False;
      SQL.Clear;
      Lc_Txt:= 'SELECT ID, DESCRIPTION,POSIT_LEVEL '+
               'FROM TB_CATEGORY '+
               'WHERE DESCRIPTION =:DESCRIPTION AND (CHARACTER_LENGTH(POSIT_LEVEL) =3) '+
               'ORDER BY POSIT_LEVEL';
      SQL.add(Lc_Txt);
      ParamByName('DESCRIPTION').AsString := Pc_Grupo;
      Active := True;
      FetchAll;
      if (recordCount>0) then
      Begin
        Result.ValueFromIndex[0] := fieldByName('ID').AsString;
        Lc_Nivel := fieldByName('POSIT_LEVEL').AsString;
        Active := False;
        SQL.Clear;
        Lc_Txt:= 'SELECT ID, DESCRIPTION,POSIT_LEVEL '+
                 'FROM TB_CATEGORY '+
                 'WHERE (POSIT_LEVEL > :POSIT_LEVEL) '+
                 'ORDER BY POSIT_LEVEL';
        SQL.add(Lc_Txt);
        ParamByName('POSIT_LEVEL').AsString := Lc_Nivel;
        Active := True;
        FetchAll;


        while not eof do
        Begin
          if (fieldByName('DESCRIPTION').AsString = Pc_Subgrupo) then
            Begin
            Result.ValueFromIndex[1] := fieldByName('ID').AsString;
            break;
            end;
          next;
        end;
      end;
    end;
  Finally
    Lc_Qry.close;
    FreeAndNil(Lc_Qry);
  end;
end;



function TFr_Atualiza.Fc_CriaCategory(Pc_Categoria: TStringList;
  Pc_Grp_Descricao, Pc_Sbg_Descricao: String): Integer;
Var
  Lc_Grupo,Lc_SubGrupo:Integer;
  LcCategory : TControllerDskCategory;
  LcNivel : String;
Begin
  LcCategory := TControllerDskCategory.create(nil);
  TRy
    Lc_Grupo := StrToIntDef(Pc_Categoria.ValueFromIndex[0],0);
    Lc_SubGrupo := StrToIntDef(Pc_Categoria.ValueFromIndex[1],0);
    if Lc_Grupo > 0 then
    Begin
      LcCategory.registro.codigo := Lc_Grupo;
      LcCategory.getByKey;
      LcNivel := LcCategory.registro.NivelPosicao;
    end
    else
    Begin
      LcCategory.Registro.Codigo := 0;
      LcCategory.registro.NivelPosicao := '';
      LcCategory.registro.Descricao := Pc_Grp_Descricao;
      LcCategory.registro.Ativo := 'S';
      LcCategory.registro.Estabelecimento := Gb_CodMha;
      LcCategory.insert;
      LcNivel := LcCategory.Registro.NivelPosicao;
    end;
    LcCategory.Registro.Codigo := 0;
    LcCategory.Registro.NivelPosicao := lcNivel;
    LcCategory.Registro.Descricao := Pc_Sbg_Descricao;
    LcCategory.registro.Estabelecimento := Gb_CodMha;
    LcCategory.insert;
    Result := LcCategory.Registro.Codigo
  finally
    FreeAndNil(LcCategory);
  end;

end;

procedure TFr_Atualiza.ListarArquivos(Diretorio: string; Sub: Boolean);
var
  F: TSearchRec;
  Ret: Integer;
  TempNome: string;
begin
  Ret := FindFirst(Diretorio+'\*.*', faAnyFile, F);
  try
    while Ret = 0 do
      begin
      if TemAtributo(F.Attr, faDirectory) then
        begin
        if (F.Name <> '.') And (F.Name <> '..') then
          if Sub = True then
            begin
            TempNome := Diretorio+'\' + F.Name;
            ListarArquivos(TempNome, True);
            end;
        end
      else
        begin
        MM_ListaArquivos.Lines.Add(Diretorio+'\'+F.Name);
        end;
      Ret := FindNext(F);
      end;
  finally
    begin
    FindClose(F);
    end;
  end;

end;

procedure TFr_Atualiza.MigraCientesSistemaGDOOR;
Var
  LCQry : TSTQuery;
  LcCliente   : TControllerCliente;
  I : Integer;
  Lc_Fone : String;
begin
  LcCliente   := TControllerCliente.CREATE(NIL);
  Try
    DM.IBD_Servidor.DatabaseName := E_migracao_Local_banco.Text;
    DM.IBD_Servidor.Connected := TRue;
    LCQry := TSTQuery.create(nil);
    with LCQry do
    Begin
      Database := DM.IBD_Servidor;
      Transaction := DM.IBT_Servidor;
      active := FAlse;
      sql.clear;
      sql.add(concat(
                'SELECT * ',
                'FROM CLIENTE '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        if FieldByName('CODIGO').asInteger > 0 then
        Begin
          //Empresa
          with LcCliente do
          Begin
            Empresa.clear;
            Empresa.Registro.Codigo := 0;
            Empresa.Registro.Tipo               := FieldByName('CODIGO').asInteger;
            Empresa.Registro.DataCadastro       := FieldByName('CADASTRO').asDateTime;
            Empresa.Registro.NomeRazaoSocial    := FieldByName('NOME').asString;
            Empresa.Registro.ApelidoFantasia    := FieldByName('FANTASIA').asString;
            Empresa.Registro.CpfCNPJ            := Fc_RemoveCaracterInformado(FieldByName('CNPJ_CNPF').asString,['.','.','.','-','/',' ']);
            Empresa.Registro.InscricaoEstadual  := FieldByName('IE_RG').asString;
            Empresa.Registro.Observacao         := FieldByName('OBSERVACOES').asString;
            Empresa.Registro.DataFundacao       := FieldByName('NASCIMENTO').AsDateTime;
            if Length(Empresa.Registro.CpfCNPJ) >11 then
              Empresa.Registro.TipoPessoa         := 'J'
            else
              Empresa.Registro.TipoPessoa         := 'F';
            Empresa.Registro.Email              := FieldByName('EMAIL').asString;
            Empresa.Registro.WebSite            := '';
            Empresa.Registro.ConsumidorFinal    := 'S';
            Empresa.Registro.Multiplicador      := 1;
            Empresa.Registro.Ativa              := 'S';
            if FieldByName('REG_SIMPLES').asString = 'SIMPLES' then
              Empresa.Registro.OptantePeloSimples := 'S'
            else
              Empresa.Registro.OptantePeloSimples := 'N';
            if FieldByName('INDIEDEST').asString = 'N' then
              Empresa.Registro.IndicadorInscricaoEstadual := '1'
            else
              if FieldByName('INDIEDEST').asString = 'I' then
                Empresa.Registro.IndicadorInscricaoEstadual := '2'
              else
                Empresa.Registro.IndicadorInscricaoEstadual := '9';

            Empresa.insert;
            //Endereco
            Empresa.Endereco.clear;
            Empresa.Endereco.Registro.Codigo        := 0;
            Empresa.Endereco.Registro.CodigoEmpresa := Empresa.Registro.Codigo;
            Empresa.Endereco.Registro.Cnpj          := Empresa.Registro.CpfCNPJ;
            Empresa.Endereco.Registro.Tipo          := 'COMERCIAL';
            Empresa.Endereco.Registro.EnderecoPrincipal := 'S';
            Empresa.Endereco.Registro.Logradouro    := FieldByName('ENDERECO').asString;
            Empresa.Endereco.Registro.Complemento   := FieldByName('COMPLEMENTO').asString;
            Empresa.Endereco.Registro.Bairro        := FieldByName('BAIRRO').asString;
            Empresa.Endereco.Registro.Cep           := Fc_RemoveCaracterInformado(FieldByName('CEP').asString,['-',' ']);
            Empresa.Endereco.Registro.Contato       := FieldByName('CONTATO').asString;

            Lc_Fone := Fc_RemoveCaracterInformado(FieldByName('TELEFONE').asString,['(','x',')','-',' ']);
            if Copy(Lc_Fone,1,1) = '0' then
              Empresa.Endereco.Registro.Fone          := Copy(Lc_Fone,2,Length(Lc_Fone)-1)
            else
              Empresa.Endereco.Registro.Fone          := Lc_Fone;

            Lc_Fone := Fc_RemoveCaracterInformado(FieldByName('CELULAR').asString,['(','x',')','-',' ']);
            if Copy(Lc_Fone,1,1) = '0' then
              Empresa.Endereco.Registro.Celular          := Copy(Lc_Fone,2,Length(Lc_Fone)-1)
            else
              Empresa.Endereco.Registro.Celular          := Lc_Fone;

            Empresa.Endereco.Registro.NumeroPredial := FieldByName('NUMERO').asString;
            Empresa.Endereco.Registro.CodigoPais    := 1058;
            Empresa.Endereco.Registro.CodigoCidade  := Fc_BuscaCodigoCidade(0,FieldByName('CIDADE').asString,FieldByName('UF').asString);
            Empresa.Endereco.Registro.CodigoEstado  := Fc_BuscaCodigoEstado(FieldByName('UF').asString);
            Empresa.Endereco.insert;
            //Cliente
            Registro.Codigo             := LcCliente.Empresa.Registro.Codigo;
            Registro.Ativo              := 'S';
            Registro.EnviarSomenteXML   := 'N';
            Registro.ValorEntrega       := 0;
            Registro.EnviaEmailNFeAuto  := 'N';
            salva;
          End;
        End;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;

  Finally
    FreeAndNil(LcCliente);
    LCQry.Close;
    FreeAndNil(LCQry);
  End;


end;

procedure TFr_Atualiza.MigraClientesSistemaAntigo;
Var
  LCQry : TSTQuery;
  LcCliente   : TControllerCliente;
  I : Integer;
begin
  LcCliente   := TControllerCliente.CREATE(NIL);
  LCQry := TSTQuery.create(nil);
  Try
    with LCQry do
    Begin
      Database := DM.IBD_Servidor;
      Transaction := DM.IBT_Servidor;
      active := FAlse;
      sql.clear;
      sql.add(concat(
                'SELECT * ',
                'FROM TB_EMPRESA EP ',
                '  INNER JOIN TB_ENDERECO EN ',
                '  ON (EN.END_CODEMP = EP.EMP_CODIGO) ',
                'where (en.end_codemp > 1 ) AND ',
                ' ( (en.end_fone is not null and en.end_fone <> '''' ) oR ',
                ' (en.end_fax is not null and en.end_fax <> '''' ) ) ',
                ' AND (EP.EMP_NOME IS NOT NULL) AND (EP.EMP_FANTASIA IS NOT NULL) '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        LcCliente.Empresa.Endereco.Registro.Fone  := FieldByName('END_FONE').AsString;
        LcCliente.Empresa.Endereco.getIdByFone;
        if not LcCliente.Empresa.Endereco.exist then
        Begin
          //Empresa
          with LcCliente do
          Begin
            Empresa.Registro.Codigo := 0;
            Empresa.Registro.Tipo               := FieldByName('EMP_CODIGO').asInteger;
            Empresa.Registro.NomeRazaoSocial    := FieldByName('EMP_NOME').asString;
            Empresa.Registro.ApelidoFantasia    := FieldByName('EMP_FANTASIA').asString;
            Empresa.Registro.CpfCNPJ            := FieldByName('EMP_CNPJ').asString;
            //Empresa.Registro.InscricaoEstadual  := FieldByName('EMP_INSC_EST').asString;
            Empresa.Registro.InscricaoEstadual  := FieldByName('EMP_NUMINSC').asString;
            Empresa.Registro.Observacao         := FieldByName('EMP_OBSERV').asString;
            Empresa.Registro.DataCadastro       := FieldByName('EMP_DT_CADASTRO').AsDateTime;
            Empresa.Registro.TipoPessoa         := FieldByName('EMP_PESSOA').asString;
            Empresa.Registro.Email              := FieldByName('EMP_EMAIL').asString;
            Empresa.Registro.WebSite            := FieldByName('EMP_SITE').asString;
            Empresa.Registro.ConsumidorFinal    := FieldByName('EMP_CONSUMIDOR').asString;
            Empresa.Registro.Multiplicador      := FieldByName('EMP_MULTIPLICADOR').asInteger;
            Empresa.Registro.Ativa              := 'S';
            Empresa.insert;
            //Endereco
            Empresa.Endereco.Registro.Codigo        := 0;
            Empresa.Endereco.Registro.CodigoEmpresa := Empresa.Registro.Codigo;
            Empresa.Endereco.Registro.Cnpj          := FieldByName('EMP_CNPJ').AsString;
            Empresa.Endereco.Registro.Tipo          := FieldByName('END_TIPO').asString;
            Empresa.Endereco.Registro.Logradouro    := FieldByName('END_ENDER').asString;
            Empresa.Endereco.Registro.Complemento   := FieldByName('END_COMPLEM').asString;
            Empresa.Endereco.Registro.Bairro        := FieldByName('END_BAIRRO').asString;
            Empresa.Endereco.Registro.Cep           := FieldByName('END_CEP').asString;
            Empresa.Endereco.Registro.Contato       := FieldByName('END_CONTATO').asString;
            Empresa.Endereco.Registro.Fone          := FieldByName('END_FONE').asString;
            Empresa.Endereco.Registro.Fax           := FieldByName('END_FAX').asString;
            Empresa.Endereco.Registro.NumeroPredial := FieldByName('END_NUMERO').asString;
            Empresa.Endereco.Registro.CodigoPais    := 1058;
            Empresa.Endereco.Registro.CodigoCidade  := 4004;
            Empresa.Endereco.Registro.CodigoEstado  := 41;
            Empresa.Endereco.insert;
            //Cliente
            Registro.Codigo             := LcCliente.Empresa.Registro.Codigo;
            Registro.Ativo              := 'S';
            Registro.EnviarSomenteXML   := 'N';
            Registro.ValorEntrega       := FieldByName('EMP_VL_ENTREGA').AsCurrency;
            Registro.EnviaEmailNFeAuto  := 'N';
            salva;
          End;
        End;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;

  Finally
    FreeAndNil(LcCliente);
    LCQry.Close;
    FreeAndNil(LCQry);
  End;
end;

procedure TFr_Atualiza.MigraEmbalagemSistemaAntigo;
Var
  LcEmbalagem : TControllerEmbalagem;
  LCQry : TSTQuery;
begin
  LcEmbalagem := TControllerEmbalagem.Create(Nil);
  LCQry := TSTQuery.create(nil);
  Try
    with LCQry do
    Begin
      Database := DM.IBD_Servidor;
      Transaction := DM.IBT_Servidor;
      active := FAlse;
      sql.clear;
      sql.add(concat(
                'SELECT * ',
                'FROM TB_EMBALAGEM '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        LcEmbalagem.Registro.Codigo       :=  FieldByName('EMB_CODIGO').AsInteger;
        LcEmbalagem.Registro.Descricao    :=  FieldByName('EMB_DESCRICAO').AsString;
        LcEmbalagem.Registro.Abreviatura  :=  FieldByName('EMB_ABREVIATURA').AsString;
        LcEmbalagem.salva;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;
  Finally
    LcEmbalagem.setGenerator('GN_EMBALAGEM',LcEmbalagem.Registro.Codigo.ToString());
    FreeAndNil(LcEmbalagem);
    LCQry.Close;
    FreeAndNil(LCQry);
  End;


end;

procedure TFr_Atualiza.MigraExcellent;
Var
  LcProduto : TControllerProduto;
  LCQry : TSTQuery;
  LcCliente   : TControllerCliente;
  I : Integer;
  LcVAlida: TACBrValidador;
  LcAchou : Boolean;
begin
  LcVAlida := TACBrValidador.Create(nil);
  LcProduto := TControllerProduto.Create(Nil);
  LCQry := LcProduto.GeraQuery;
  Try
    LcVAlida.TipoDocto := docGTIN;
    DM.IBD_Servidor.DatabaseName := E_migracao_Local_banco.Text;
    DM.IBD_Servidor.Connected := TRue;
    LCQry.Database := Dm.IBD_Servidor;
    LCQry.Transaction := DM.IBT_Servidor;
    with LCQry do
    Begin
      sql.add(concat(
                'SELECT * ',
                'FROM PRODUTO  ',
                'order by CODIGO_INTERNO DESC '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;

      while not eof do
      BEgin
        LcProduto.Clear;
        LcVAlida.Documento := TRIM(FieldByName('COD_BARRA').AsString);
        if LcVAlida.Validar then
        Begin
          LcProduto.Registro.CodigoBarras := FieldByName('COD_BARRA').AsString;
          LcProduto.getbyBarCode;
          LcAchou := LcProduto.exist;
        End
        else
        Begin
          LcProduto.Registro.CodigoBarras := '';
        End;


        with LcPRoduto.Registro do
        Begin
          Codigo                := 0;
          CodigoEstabelecimento := Gb_CodMha;
          CodigoFabrica         := '';
          //CodigoBarras          := TRIM(FieldByName('CODIGO').AsString); foi preenchido no inicio
          CodigoNCM              := FieldByName('NCM').AsString;
          CEST                  := FieldByName('CEST').AsString;
          Descricao             := Copy( UpperCase( FieldByName('DESCRICAO').AsString ),1,98);

          MedidaComercial       := 1;

          CodigoEmbalagem       := 1;

          CodigoGrupo           := 1;
          CodigoSubgrupo        := 1;
          Divisor               := 1;
          Origem                := '0';
          Tipo                  := 'P';
          ValorFabrica          :=  0;
          ValorCustoMedio       :=  FieldByName('CUSTO').AsCurrency;
          ValorCustoMedioAnt    :=  FieldByName('CUSTO').AsCurrency;
          ValorCusto            :=  FieldByName('CUSTO').AsCurrency;
          ValorCustoAnt         :=  FieldByName('CUSTO').AsCurrency;
          SubsTrib              := 'N';
          Campanha              := 'N';
          Destaque              := 'N';
          Ativo                 := FieldByName('ATIVO').AsString;
          Imprime               := 'S';
          EstoqueNegativo       := 'S';
          Exclusivo             := 'N';
          Internet              := 'N';
          MaisVendido           := 'N';
          Composicao            := '1';
          CodigoMarca           := 1;
          FinalidadeTributacao  := '1';
          UtilizaSerie          := 'N';
          Venda                 := 'S';
          ForaLinha             := 'N';
          CEST                  := '';
          IndicacaoEscala       := 'S';
          Localizacao           := FieldByName('LOCALIZACAO').AsString;
        end;
        LcProduto.insert;

        //TAbela 1
        LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
        LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
        LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
        LcProduto.TabelaPreco.Preco.Registro.Valor          := FieldByName('VR_UNIT').AsFloat;
        LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
        LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
        LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := FieldByName('MARGEM_LUCRO').AsCurrency;
        LcProduto.TabelaPreco.Preco.Insert;
        //TAbela 2
        LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
        LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 2;
        LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
        LcProduto.TabelaPreco.Preco.Registro.Valor          := 0;
        LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
        LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
        LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
        LcProduto.TabelaPreco.Preco.Insert;
        //TAbela 3
        LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
        LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 3;
        LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
        LcProduto.TabelaPreco.Preco.Registro.Valor          := FieldByName('VR_ATACADO').AsFloat;
        LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
        LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
        LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
        LcProduto.TabelaPreco.Preco.Insert;

        LcProduto.Estoque.SaldoEstoque.Registro.Codigo := 0;
        LcProduto.Estoque.SaldoEstoque.Registro.CodigoProduto := LcProduto.Registro.Codigo;
        LcProduto.Estoque.SaldoEstoque.Registro.CodigoEstoque := 1;
        LcProduto.Estoque.SaldoEstoque.Registro.QtdeDisp := 0;
        LcProduto.Estoque.SaldoEstoque.Insert;

        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;
  Finally
    LcProduto.FinalizaQuery( LCQry );
  End;

end;

procedure TFr_Atualiza.MigraExcelLourenco;
Var
  LcProduto : TControllerProduto;
  LcCliente   : TControllerCliente;
  I : Integer;
  LcVAlida: TACBrValidador;
  LcAchou : Boolean;
begin
  LcVAlida := TACBrValidador.Create(nil);
  LcProduto := TControllerProduto.Create(Nil);
  try
    LcVAlida.TipoDocto := docGTIN;
    DBUniplus.Connected := true;
    Qr_prod_xls.Active := True;
    Qr_prod_xls.FetchAll;
    gg_progresso.MinValue := 0;
    gg_progresso.MaxValue := Qr_prod_xls.RecordCount;
    gg_progresso.Progress := 0;
    Application.ProcessMessages;

    while not Qr_prod_xls.eof do
    BEgin
      LcProduto.Clear;
      LcVAlida.Documento := TRIM(Qr_prod_xlsCODIGO_PROD.AsString);
      if LcVAlida.Validar then
      Begin
        LcProduto.Registro.CodigoBarras := TRIM(Qr_prod_xlsCODIGO_PROD.AsString);
        LcProduto.getbyBarCode;
        LcAchou := LcProduto.exist;
      End
      else
      Begin
        LcProduto.Registro.CodigoBarras := '';
      End;


      with LcPRoduto.Registro do
      Begin
        Codigo                := 0;
        CodigoEstabelecimento := Gb_CodMha;
        CodigoFabrica         := Qr_prod_xlsREFERENCIA_PROD.AsString;
        //CodigoBarras          := TRIM(FieldByName('CODIGO').AsString); foi preenchido no inicio
        CodigoNCM              := TRIM(Qr_prod_xlsFIS_NCM_PROD.AsString);
        CEST                  := TRIM(Qr_prod_xlsCEST.AsString);
        Descricao             := Copy( UpperCase( TRIM( Qr_prod_xlsDESCRICAO_PROD.AsString) ),1,98);


        LcProduto.Medida.Registro.Descricao   := UpperCase( TRIM(  Qr_prod_xlsUNIDADE_PROD.AsString) );
        LcProduto.Medida.Registro.Abreviatura := UpperCase( TRIM(  Qr_prod_xlsUNIDADE_PROD.AsString) );
        LcProduto.Medida.getIdAutoByDesc;
        MedidaComercial       := LcProduto.Medida.Registro.Codigo;

        LcProduto.Embalagem.Registro.Descricao := 'NORMAL';
        LcProduto.Embalagem.Registro.Abreviatura := 'NRL';
        LcProduto.Embalagem.getIdAutoByDesc;
        CodigoEmbalagem       := LcProduto.Embalagem.Registro.Codigo;

        CodigoGrupo           := LcProduto.Grupo.autocreate('GERAL');
        CodigoSubgrupo        := LcProduto.Grupo.SubGRupo.autocreate(CodigoGrupo,'DIVERSOS');

        Divisor               := 1;
        Origem                := '0';
        Tipo                  := 'P';
        ValorFabrica          :=  0;
        ValorCustoMedio       := Qr_prod_xlsPRECOCUSTO_PROD.AsCurrency;
        ValorCustoMedioAnt    := Qr_prod_xlsPRECOCUSTO_PROD.AsCurrency;
        ValorCusto            := Qr_prod_xlsPRECOCUSTO_PROD.AsCurrency;
        ValorCustoAnt         := Qr_prod_xlsPRECOCUSTO_PROD.AsCurrency;
        if Qr_prod_xlsCEST.AsString <> '' then
          SubsTrib              := 'S'
        else
          SubsTrib              := 'N';
        Campanha              := 'N';
        Destaque              := 'N';
        Ativo                 := 'S';
        Imprime               := 'S';
        EstoqueNegativo       := 'S';
        Exclusivo             := 'N';
        Internet              := 'N';
        MaisVendido           := 'N';
        Composicao            := '1';
        CodigoMarca           := 1;
        FinalidadeTributacao  := '1';
        UtilizaSerie          := 'N';
        Venda                 := 'S';
        ForaLinha             := 'N';
        IndicacaoEscala       := 'S';
        Localizacao           := '';
      end;
      LcProduto.insert;

      //TAbela 1
      LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
      LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
      LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
      LcProduto.TabelaPreco.Preco.Registro.Valor          := Qr_prod_xlsPRECOPADRAO_PROD.AsCurrency;
      LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
      LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
      LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := Qr_UniPlus_Produtolucrobruto.AsCurrency;
      LcProduto.TabelaPreco.Preco.Insert;
      //TAbela 2
      LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
      LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 2;
      LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
      LcProduto.TabelaPreco.Preco.Registro.Valor          := 0;
      LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
      LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
      LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
      LcProduto.TabelaPreco.Preco.Insert;

      //TAbela 3
      LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
      LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 3;
      LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
      LcProduto.TabelaPreco.Preco.Registro.Valor          := Qr_prod_xlsPRECOVISTA_PROD.AsCurrency;
      LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
      LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
      LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
      LcProduto.TabelaPreco.Preco.Insert;


      LcProduto.Estoque.SaldoEstoque.Registro.Codigo := 0;
      LcProduto.Estoque.SaldoEstoque.Registro.CodigoProduto := LcProduto.Registro.Codigo;
      LcProduto.Estoque.SaldoEstoque.Registro.CodigoEstoque := 1;
      LcProduto.Estoque.SaldoEstoque.Registro.QtdeDisp := 0;
      LcProduto.Estoque.SaldoEstoque.Insert;

      gg_progresso.Progress := gg_progresso.Progress + 1;
      Application.ProcessMessages;
      Qr_prod_xls.Next;
    End;
  finally
    LcProduto.setGenerator('GN_PRODUTO', Qr_UniPlus_Produtoid.AsString);
    FreeAndNil(LcProduto);
  end;


end;

procedure TFr_Atualiza.MigraGrupoSistemaAntigo;
Var
  LcGrupo : TControllerGRupos;
  LCQry : TSTQuery;
begin
  LcGrupo := TControllerGRupos.Create(Nil);
  LCQry := TSTQuery.create(nil);
  Try
    with LCQry do
    Begin
      Database := DM.IBD_Servidor;
      Transaction := DM.IBT_Servidor;
      active := FAlse;
      sql.clear;
      sql.add(concat(
                'SELECT * ',
                'FROM TB_GRUPOS '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        LcGrupo.Registro.Codigo :=  FieldByName('GRP_CODIGO').AsInteger;
        LcGrupo.Registro.Descricao := FieldByName('GRP_DESCRICAO').AsString;
        LcGrupo.Registro.ValorDesconto := FieldByName('GRP_VL_DESCONTO').AsCurrency;
        LcGrupo.Registro.Composicao := FieldByName('GRP_COMPOSICAO').AsString;
        LcGrupo.Registro.ControleInterface := FieldByName('GRP_INTERFACE').AsString;
        LcGrupo.Registro.Tamanhos := FieldByName('GRP_TAMANHOS').AsString;
        LcGrupo.Registro.PropagaTamanho := FieldByName('GRP_PROG_TAM').AsString;
        LcGrupo.Registro.Agrupar := FieldByName('GRP_AGRUPAR').AsString;
        LcGrupo.Registro.Sequencia := FieldByName('GRP_SEQUENCIA').AsInteger;
        LcGrupo.salva;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;
  Finally
    LcGrupo.setGenerator('GN_GRUPO',LcGrupo.Registro.Codigo.ToString());
    FreeAndNil(LcGrupo);
    LCQry.Close;
    FreeAndNil(LCQry);
  End;


end;

procedure TFr_Atualiza.MigraMarcaSistemaAntigo;
Var
  LcMarca : TControllerMarcaProduto;
  LCQry : TSTQuery;
begin
  LcMarca := TControllerMarcaProduto.Create(Nil);
  LCQry := TSTQuery.create(nil);
  Try
    with LCQry do
    Begin
      Database := DM.IBD_Servidor;
      Transaction := DM.IBT_Servidor;
      active := FAlse;
      sql.clear;
      sql.add(concat(
                'SELECT * ',
                'FROM TB_MARCA_PRODUTO '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        LcMarca.Registro.Codigo :=  FieldByName('MRC_CODIGO').AsInteger;
        LcMarca.Registro.Descricao :=  FieldByName('MRC_DESCRICAO').AsString;
        LcMarca.Registro.Fabrica :=  FieldByName('MRC_CODFAB').AsInteger;
        LcMarca.salva;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;
  Finally
    LcMarca.setGenerator('GN_MARCAMODELO',LcMarca.Registro.Codigo.ToString());
    FreeAndNil(LcMarca);
    LCQry.Close;
    FreeAndNil(LCQry);
  End;

end;

procedure TFr_Atualiza.MigraMedidaSistemaAntigo;
Var
  LcMedida : TControllerMedida;
  LCQry : TSTQuery;
begin
  Try
    LcMedida := TControllerMedida.Create(Nil);
    LCQry := TSTQuery.create(nil);
    with LCQry do
    Begin
      Database := DM.IBD_Servidor;
      Transaction := DM.IBT_Servidor;
      active := FAlse;
      sql.clear;
      sql.add(concat(
                'SELECT * ',
                'FROM TB_MEDIDA '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        LcMedida.Registro.Codigo          :=  FieldByName('MED_CODIGO').AsInteger;
        LcMedida.Registro.Descricao       :=  FieldByName('MED_DESCRICAO').AsString;
        LcMedida.Registro.Abreviatura     :=  FieldByName('MED_ABREVIATURA').AsString;
        LcMedida.Registro.Escala          :=  FieldByName('MED_ESCALA').AsFloat;
        LcMedida.Registro.MedidaCardapio  :=  FieldByName('MED_ESPECIAL').AsString;
        LcMedida.Registro.Proporcao       :=  FieldByName('MED_PROPORCAO').AsFloat;
        LcMedida.Registro.Sequencia       :=  FieldByName('MED_SEQUENCIA').AsInteger;
        LcMedida.salva;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;
  Finally
    LcMedida.setGenerator('GN_MEDIDA',LcMedida.Registro.Codigo.ToString());
    FreeAndNil(LcMedida);
    LCQry.Close;
    FreeAndNil(LCQry);
  End;


end;

procedure TFr_Atualiza.MigraProdutosSistemaAntigo;
Var
  LcProduto : TControllerProduto;
  LCQry : TSTQuery;
  LcCliente   : TControllerCliente;
  I : Integer;
  LcVAlida: TACBrValidador;
begin
  Try
    LcVAlida := TACBrValidador.Create(nil);

    LcVAlida.TipoDocto := docGTIN;

    LcProduto := TControllerProduto.Create(Nil);
    LCQry := TSTQuery.create(nil);
    with LCQry do
    Begin
      Database := DM.IBD_Servidor;
      Transaction := DM.IBT_Servidor;
      active := FAlse;
      sql.clear;
      sql.add(concat(
                'SELECT PD.* ,PR.prc_vl_vda ',
                'FROM TB_PRODUTO PD ',
                '  INNER JOIN tb_preco PR ',
                '  ON (PR.prc_codpro = PD.pro_codigo) ',
                'WHERE PR.prc_codtpr = 1 '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      LcProduto.deleteaLL;
      while not eof do
      BEgin
        LcProduto.Clear;

        with LcProduto.Registro do
        Begin
          Codigo := FieldByName('PRO_CODIGO').AsInteger;
          CodigoEstabelecimento := Gb_CodMha;
          CodigoFabrica         := TRIM(FieldByName('PRO_CODIGOFAB').AsString);
          LcVAlida.Documento := TRIM(FieldByName('PRO_CODIGOBAR').AsString);
          if LcVAlida.Validar then
            CodigoBarras := TRIM(FieldByName('PRO_CODIGOBAR').AsString)
          else
            CodigoBarras := '';
          CodigoNCM := '';
          Descricao := Copy( UpperCase( FieldByName('PRO_DESCRICAO').AsString ),1,98);
          MedidaComercial := FieldByName('PRO_CODMED').AsInteger;
          CodigoEmbalagem := FieldByName('PRO_CODEMB').AsInteger;
          CodigoGrupo := FieldByName('PRO_CODGRP').AsInteger;
          CodigoSubgrupo := FieldByName('PRO_CODSBG').AsInteger;
          Divisor := FieldByName('PRO_DIVISOR').AsInteger;
          Origem := FieldByName('PRO_ORIGEM').AsString;
          Tipo := FieldByName('PRO_TIPO').AsString;
          ValorFabrica        :=  FieldByName('PRO_VL_FABRICA').AsCurrency;
          ValorCustoMedio     :=  FieldByName('PRO_VL_CUSTOMED').AsCurrency;
          ValorCustoMedioAnt  :=  FieldByName('PRO_VL_CUSTOMEDANT').AsCurrency;
          ValorCusto          :=  FieldByName('PRO_VL_CUSTO').AsCurrency;
          ValorCustoAnt       :=  FieldByName('PRO_VL_CUSTOANT').AsCurrency;
          SubsTrib := 'S';
          Campanha := 'N';
          Destaque := 'N';
          Ativo := FieldByName('PRO_ATIVO').AsString;
          Imprime := 'S';
          EstoqueNegativo := 'S';
          Exclusivo := 'N';
          Internet := 'N';
          MaisVendido := 'N';
          Composicao := '1';
          CodigoMarca := FieldByName('PRO_CODMRC').AsInteger;
          FinalidadeTributacao := '1';
          UtilizaSerie := 'N';
          Venda := 'S';
          ForaLinha := 'N';
          CEST := FieldByName('PRO_CEST').AsString;
          IndicacaoEscala := 'S';
          Detalhes  :=  FieldByName('PRO_DETALHES').AsString;
        end;
        LcProduto.insert;

        //TAbela 1
        LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
        LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
        LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
        LcProduto.TabelaPreco.Preco.Registro.Valor          := FieldByName('PRC_VL_VDA').AsCurrency;
        LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
        LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
        LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
        LcProduto.TabelaPreco.Preco.Insert;
        //TAbela 2
        LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
        LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 2;
        LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
        LcProduto.TabelaPreco.Preco.Registro.Valor          := 0;
        LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
        LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
        LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
        LcProduto.TabelaPreco.Preco.Insert;

        LcProduto.Estoque.SaldoEstoque.CriaRegistroAutomatico(LcProduto.Registro.Codigo);
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;
  Finally
    LcProduto.setGenerator('GN_PRODUTO',LcProduto.Registro.Codigo.ToString());
    LcProduto.setGenerator('GN_PRECO',LcProduto.TabelaPreco.Preco.Registro.Codigo.ToString());
    LcProduto.setGenerator('GN_ESTOQUE',LcProduto.Estoque.Registro.Codigo.ToString());

    FreeAndNil(LcCliente);
    LCQry.Close;
    FreeAndNil(LCQry);
  End;

end;

procedure TFr_Atualiza.MigraProdutosSistemaGDOOR;
Var
  LcProduto : TControllerProduto;
  LCQry : TSTQuery;
  LcCliente   : TControllerCliente;
  I : Integer;
  LcVAlida: TACBrValidador;
begin
  Try
    LcVAlida := TACBrValidador.Create(nil);
    LcVAlida.TipoDocto := docGTIN;

    LcProduto := TControllerProduto.Create(Nil);
    DM.IBD_Servidor.DatabaseName := E_migracao_Local_banco.Text;
    DM.IBD_Servidor.Connected := TRue;
    LCQry := TSTQuery.create(nil);
    with LCQry do
    Begin
      Database := DM.IBD_Servidor;
      Transaction := DM.IBT_Servidor;
      active := FAlse;
      sql.clear;
      sql.add(concat(
                'SELECT * ',
                'FROM ESTOQUE '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        LcProduto.Clear;
        with LcPRoduto.Registro do
        Begin
          Codigo := StrToIntDef(FieldByNAme('CODIGO').AsString,0);
          CodigoEstabelecimento := Gb_CodMha;
          CodigoFabrica := Codigo.ToString;
          LcVAlida.Documento := TRIM(FieldByName('BARRAS').AsString);
          if LcVAlida.Validar then
            CodigoBarras := TRIM(FieldByName('BARRAS').AsString)
          else
            CodigoBarras := '';
          CodigoNCM       := FieldByName('COD_NCM').AsString;
          Descricao       := Copy( UpperCase( FieldByName('DESCRICAO').AsString ),1,98);

          LcProduto.Medida.Registro.Descricao   := 'UNIDADE';
          LcProduto.Medida.Registro.Abreviatura := 'UND';
          LcProduto.Medida.getIdAutoByDesc;
          MedidaComercial := LcProduto.Medida.Registro.Codigo;

          LcProduto.Embalagem.Registro.Descricao := 'NORMAL';
          LcProduto.Embalagem.Registro.Abreviatura := 'NRL';
          LcProduto.Embalagem.getIdAutoByDesc;
          CodigoEmbalagem := LcProduto.Embalagem.Registro.Codigo;

          CodigoGrupo     := LcProduto.Grupo.autocreate('GERAL');
          CodigoSubgrupo  := LcProduto.Grupo.SubGRupo.autocreate(CodigoGrupo,'DIVERSOS');
          Divisor := 1;
          Origem := '0';
          Tipo := 'P';
          ValorFabrica        :=  FieldByName('CUSTO_MEDIO').AsCurrency;
          ValorCustoMedio     :=  FieldByName('CUSTO_MEDIO').AsCurrency;
          ValorCustoMedioAnt  :=  FieldByName('CUSTO_MEDIO').AsCurrency;
          ValorCusto          :=  FieldByName('CUSTO_MEDIO').AsCurrency;
          ValorCustoAnt       :=  FieldByName('CUSTO_MEDIO').AsCurrency;
          SubsTrib := 'N';
          Campanha := 'N';
          Destaque := 'N';
          Ativo := 'S';
          Imprime := 'S';
          EstoqueNegativo := 'S';
          Exclusivo := 'N';
          Internet := 'N';
          MaisVendido := 'N';
          Composicao := '1';
          LcProduto.Marca.Registro.Descricao := 'NÃO INFORMADA';
          LcProduto.Marca.getIdAutoByDesc;
          CodigoMarca := LcProduto.Marca.Registro.Codigo;
          FinalidadeTributacao := '1';
          UtilizaSerie := 'N';
          Venda := 'S';
          ForaLinha := 'N';
          CEST := '';
          IndicacaoEscala := 'S';
        end;
        LcProduto.save;

        //TAbela 1
        LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
        LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
        LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
        LcProduto.TabelaPreco.Preco.Registro.Valor          := FieldByName('PRECO_VENDA').AsCurrency;
        LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
        LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
        LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
        LcProduto.TabelaPreco.Preco.Insert;
        //TAbela 2
        LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
        LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 2;
        LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
        LcProduto.TabelaPreco.Preco.Registro.Valor          := 0;
        LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
        LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
        LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
        LcProduto.TabelaPreco.Preco.Insert;

        LcProduto.Estoque.SaldoEstoque.CriaRegistroAutomatico(LcProduto.Registro.Codigo);
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;
  Finally
    FreeAndNil(LcCliente);
    LCQry.Close;
    FreeAndNil(LCQry);
  End;
end;

procedure TFr_Atualiza.MigraProduto_Para_TB_PRODUTOS;
Var
  LcProduto : TControllerProduto;
  LCQry : TSTQuery;
  LcCliente   : TControllerCliente;
  I : Integer;
  LcVAlida: TACBrValidador;
begin
  Try
    LcVAlida := TACBrValidador.Create(nil);
    LcVAlida.TipoDocto := docGTIN;

    LcProduto := TControllerProduto.Create(Nil);
    LCQry := TSTQuery.create(nil);
    with LCQry do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IBT_Consulta;
      active := FAlse;
      sql.clear;
      sql.add(concat(
                'SELECT * ',
                'FROM PRODUTOS_1 '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        LcVAlida.Documento := TRIM(FieldByName('BARRA').AsString);
        if LcVAlida.Validar then
        Begin
          LcProduto.Registro.CodigoBarras := TRIM(FieldByName('BARRA').AsString);
          if not LcProduto.getbyBarCode then
          Begin
            LcProduto.Clear;
            with LcPRoduto.Registro do
            Begin
              Codigo := 0;
              CodigoEstabelecimento := Gb_CodMha;
              CodigoFabrica         := TRIM(FieldByName('REFERENCIA').AsString);
              CodigoBarras := TRIM(FieldByName('BARRA').AsString);
              CodigoNCM := '';
              Descricao := Copy( UpperCase( FieldByName('DESCRICAO').AsString ),1,98);
              //MedidaComercial := Fc_CriaMedidaAuto('UNIDADE', 'UND');
              //CodigoEmbalagem := Fc_CriaEmbalagemAuto('NORMAL', 'NRL');
              //CodigoGrupo := Fc_CriaGrupoAuto('IMPORTACAO');
              //CodigoSubgrupo := Fc_CriaSubGrupoAuto(CodigoGrupo, 'GERAL');
              Divisor := 1;
              Origem := '0';
              Tipo := 'P';
              ValorFabrica        :=  FieldByName('P_CUSTO').AsCurrency;
              ValorCustoMedio     :=  FieldByName('P_CUSTO').AsCurrency;
              ValorCustoMedioAnt  :=  FieldByName('P_CUSTO').AsCurrency;
              ValorCusto          :=  FieldByName('P_CUSTO').AsCurrency;
              ValorCustoAnt       :=  FieldByName('P_CUSTO').AsCurrency;
              SubsTrib := 'N';
              Campanha := 'N';
              Destaque := 'N';
              Ativo := 'S';
              Imprime := 'S';
              EstoqueNegativo := 'S';
              Exclusivo := 'N';
              Internet := 'N';
              MaisVendido := 'N';
              Composicao := '1';
              ///CodigoMarca := Fc_CriaMarca_ProdutoAuto('NÃO INFORMADA');
              FinalidadeTributacao := '1';
              UtilizaSerie := 'N';
              Venda := 'S';
              ForaLinha := 'N';
              CEST := '';
              IndicacaoEscala := 'S';
              Detalhes  :=  FieldByName('MENSAGEM').AsString;
            end;
            LcProduto.save;

            //TAbela 1
            LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
            LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
            LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
            LcProduto.TabelaPreco.Preco.Registro.Valor          := FieldByName('P_VENDA').AsFloat;
            LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
            LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
            LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
            LcProduto.TabelaPreco.Preco.Insert;
            //TAbela 2
            LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
            LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 2;
            LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
            LcProduto.TabelaPreco.Preco.Registro.Valor          := 0;
            LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
            LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
            LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
            LcProduto.TabelaPreco.Preco.Insert;

            LcProduto.Estoque.SaldoEstoque.CriaRegistroAutomatico(LcProduto.Registro.Codigo);
          End;
        End;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;
  Finally
    FreeAndNil(LcCliente);
    LCQry.Close;
    FreeAndNil(LCQry);
  End;

end;

procedure TFr_Atualiza.MigraSistemaAntigo;
begin
  DM.IBD_Servidor.Connected := False;
  DM.IBD_Servidor.DatabaseName := E_migracao_Local_banco.Text;
  DM.IBD_Servidor.Connected := TRue;
  MigraClientesSistemaAntigo;
//  MigraGrupoSistemaAntigo;
//  MigraSubGrupoSistemaAntigo;
//  MigraMarcaSistemaAntigo;
//  MigraEmbalagemSistemaAntigo;
//  MigraMedidaSistemaAntigo;
//  MigraProdutosSistemaAntigo;
end;

procedure TFr_Atualiza.MigraSistemaGDOOR;
begin
  MigraCientesSistemaGDOOR;
  MigraProdutosSistemaGDOOR;
end;

procedure TFr_Atualiza.MigraSistemaGestaoGestaoCompara;
Var
  LcProduto : TControllerProduto;
  LCQryProduto : TSTQuery;
  LCQryPreco : TSTQuery;
  I : Integer;
  LcVAlida: TACBrValidador;
begin
  Try
    LcVAlida := TACBrValidador.Create(nil);
        LcVAlida.TipoDocto := docGTIN;

    LcProduto := TControllerProduto.Create(Nil);
    DM.IBD_Servidor.DatabaseName := E_migracao_Local_banco.Text;
    DM.IBD_Servidor.Connected := TRue;

    LCQryPreco := TSTQuery.create(nil);
    with LCQryPreco do
    Begin
      Database := DM.IBD_Servidor;
      Transaction := DM.IBT_Servidor;
      active := FAlse;
      sql.clear;
      sql.add(concat(
                'SELECT * ',
                'FROM TB_PRECO ',
                'WHERE PRC_CODPRO=:PRO_CODIGO '
      ));
    End;

    LCQryProduto := TSTQuery.create(nil);
    with LCQryProduto do
    Begin
      Database := DM.IBD_Servidor;
      Transaction := DM.IBT_Servidor;
      active := FAlse;
      sql.clear;
      sql.add(concat(
                'SELECT * ',
                'FROM TB_PRODUTO '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        LcProduto.Clear;
        LcVAlida.Documento := TRIM(FieldByName('PRO_CODIGOBAR').AsString);
        if LcVAlida.Validar then
        Begin
          LcProduto.Registro.CodigoBarras := FieldByname('PRO_CODIGOBAR').AsString;
          LcProduto.getbyBarCode;
          if not LcProduto.exist then
          Begin
            LcProduto.MigraSelf(LCQryProduto);
            LcProduto.save;

            LCQryPreco.active := False;
            LCQryPreco.ParambyName('PRO_CODIGO').AsInteger := FieldByname('PRO_CODIGO').asinteger;
            LCQryPreco.active := True;
            LCQryPreco.first;
            while not LCQryPreco.eof do
            Begin
              //TAbela 1
              LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
              LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := LCQryPreco.FieldByName('PRC_CODTPR').AsInteger;
              LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LCQryPreco.FieldByName('PRC_CODPRO').AsInteger;
              LcProduto.TabelaPreco.Preco.Registro.Valor          := LCQryPreco.FieldByName('PRC_VL_VDA').AsCurrency;
              LcProduto.TabelaPreco.Preco.Registro.AliComissao    := LCQryPreco.FieldByName('PRC_AQ_COM').AsFloat;
              LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := LCQryPreco.FieldByName('PRC_QT_MIN').AsFloat;
              LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := LCQryPreco.FieldByName('PRC_MAR_LRC').AsFloat;
              LcProduto.TabelaPreco.Preco.Insert;
              LCQryPreco.Next;
            End;

            LcProduto.Estoque.SaldoEstoque.CriaRegistroAutomatico(LcProduto.Registro.Codigo);
          End;
        End;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;
  Finally
    LCQryProduto.Close;
    FreeAndNil(LCQryProduto);
    LCQryPreco.Close;
    FreeAndNil(LCQryPreco);
  End;
end;

procedure TFr_Atualiza.MigraSistemaPantera;
begin
  MigraSistemaPantera_PRODUTOS
end;

procedure TFr_Atualiza.MigraSistemaPantera_PRODUTOS;
Var
  LcProduto : TControllerProduto;
  Lc_Qry : TSTQuery;
  LcCliente   : TControllerCliente;
  I : Integer;
  LcVAlida: TACBrValidador;
  Lc_MedidaComercial : integer;
  Lc_CodigoEmbalagem : integer;
  Lc_CodigoGrupo : integer;
  Lc_CodigoSubgrupo : integer;
  Lc_CodigoMarca : integer;
  LcBase : TControllerBase;
begin
  Try
    LcVAlida := TACBrValidador.Create(nil);
    LcVAlida.TipoDocto := docGTIN;
    LcProduto := TControllerProduto.Create(Nil);
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;

    Lc_MedidaComercial  := LcProduto.Medida.autocreate('UNIDADE', 'UND');
    LcProduto.Embalagem.Registro.Descricao := 'NORMAL';
    LcProduto.Embalagem.Registro.Abreviatura := 'NRL';
    LcProduto.Embalagem.getIdAutoByDesc;
    Lc_CodigoEmbalagem  := LcProduto.Embalagem.registro.codigo;

    Lc_CodigoGrupo      := LcProduto.Grupo.autocreate('GERAL');
    Lc_CodigoSubgrupo   := LcProduto.Grupo.SubGRupo.autocreate(Lc_CodigoGrupo, 'DIVERSOS');
    LcProduto.Marca.Registro.Descricao := 'NÃO INFORMADA';
    LcProduto.Marca.getIdAutoByDesc;
    Lc_CodigoMarca      := LcProduto.Marca.Registro.Codigo;


    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT P.cd,  P.vl, P.ncm,P.nm, P.unid, P.preco_custo, P.estoque_min, P.ativo,P.tipo ',
                'FROM PRODUTO P ',
                'WHERE P.vl > 0 '
//                ' AND P.ncm IS NOT NULL ',
              //  ' AND P.ativo = ''S''  '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        LcProduto.Clear;
        with LcPRoduto.Registro do
        Begin
          Codigo                := 0;
          CodigoEstabelecimento := Gb_CodMha;
          CodigoFabrica         := '';
          LcVAlida.Documento := TRIM(FieldByName('CD').AsString);
          if LcVAlida.Validar then
            CodigoBarras := TRIM(FieldByName('CD').AsString)
          else
            CodigoBarras := '';
          CodigoNCM := FieldByName('NCM').AsString;
          Descricao := Copy( UpperCase( FieldByName('NM').AsString ),1,98);
          MedidaComercial :=  Lc_MedidaComercial;
          CodigoEmbalagem := Lc_CodigoEmbalagem;
          CodigoGrupo     := Lc_CodigoGrupo;
          CodigoSubgrupo  := Lc_CodigoSubgrupo;
          Divisor := 1;
          Origem := '0';
          Tipo := 'P';
          ValorFabrica        :=  FieldByName('PRECO_CUSTO').AsCurrency;
          ValorCustoMedio     :=  FieldByName('PRECO_CUSTO').AsCurrency;
          ValorCustoMedioAnt  :=  FieldByName('PRECO_CUSTO').AsCurrency;
          ValorCusto          :=  FieldByName('PRECO_CUSTO').AsCurrency;
          ValorCustoAnt       :=  FieldByName('PRECO_CUSTO').AsCurrency;
          SubsTrib := 'N';
          Campanha := 'N';
          Destaque := 'N';
          Ativo := 'S';
          Imprime := 'S';
          EstoqueNegativo := 'S';
          Exclusivo := 'N';
          Internet := 'N';
          MaisVendido := 'N';
          Composicao := '1';
          CodigoMarca := Lc_CodigoMarca;
          FinalidadeTributacao := '1';
          UtilizaSerie := 'N';
          Venda := 'S';
          ForaLinha := 'N';
          CEST := '';
          IndicacaoEscala := 'S';
        end;
        LcProduto.Insert;

        //TAbela 1
        LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
        LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
        LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
        LcProduto.TabelaPreco.Preco.Registro.Valor          := FieldByName('VL').AsFloat;
        LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
        LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
        LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
        LcProduto.TabelaPreco.Preco.Insert;
        //TAbela 2
        LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
        LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 2;
        LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
        LcProduto.TabelaPreco.Preco.Registro.Valor          := 0;
        LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
        LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
        LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
        LcProduto.TabelaPreco.Preco.Insert;

        //LcProduto.Estoque.SaldoEstoque.Registro.CodigoProduto := LcProduto.Registro.Codigo;
        //LcProduto.Estoque.SaldoEstoque.CriaRegistroAutomatico;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;

end;

procedure TFr_Atualiza.MigraSistemaWinsic;
begin
  MigraSistemaWinsic_Produtos;
end;

procedure TFr_Atualiza.MigraSistemaWinsic_Produtos;
Var
  LcProduto : TControllerProduto;
  LCQry : TSTQuery;
  LcCliente   : TControllerCliente;
  I : Integer;
begin
  Try
    LcProduto := TControllerProduto.Create(Nil);
    LCQry := LcProduto.GeraQuery;
    with LCQry do
    Begin
      sql.add(concat(
                'SELECT * ',
                'FROM TB_BRECHO '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        LcProduto.Clear;
        with LcPRoduto.Registro do
        Begin
          Codigo                := 0;
          CodigoEstabelecimento := Gb_CodMha;
          CodigoFabrica         := TRIM(FieldByName('CODIGO').AsString);
          CodigoBarras          := TRIM(FieldByName('CODIGO').AsString);
          CodigoNCM             := '62114300';
          Descricao             := Copy( UpperCase( FieldByName('PRODUTO').AsString ),1,98);

          LcProduto.Medida.Registro.Descricao   := 'UNIDADE';
          LcProduto.Medida.Registro.Abreviatura := 'UND';
          LcProduto.Medida.getIdAutoByDesc;
          MedidaComercial       := LcProduto.Medida.Registro.Codigo;

          LcProduto.Embalagem.Registro.Descricao := 'NORMAL';
          LcProduto.Embalagem.Registro.Abreviatura := 'NRL';
          LcProduto.Embalagem.getIdAutoByDesc;
          CodigoEmbalagem       := LcProduto.Embalagem.Registro.Codigo;

          CodigoGrupo           := LcProduto.Grupo.autocreate('GERAL');
          CodigoSubgrupo        := LcProduto.Grupo.SubGRupo.autocreate(CodigoGrupo,'DIVERSOS');
          Divisor               := 1;
          Origem                := '0';
          Tipo                  := 'P';
          ValorFabrica          :=  0;
          ValorCustoMedio       :=  0;
          ValorCustoMedioAnt    :=  0;
          ValorCusto            :=  0;
          ValorCustoAnt         :=  0;
          SubsTrib              := 'N';
          Campanha              := 'N';
          Destaque              := 'N';
          Ativo                 := 'S';
          Imprime               := 'S';
          EstoqueNegativo       := 'S';
          Exclusivo             := 'N';
          Internet              := 'N';
          MaisVendido           := 'N';
          Composicao            := '1';
          LcProduto.Marca.Registro.Descricao := 'NÃO INFORMADA';
          LcProduto.Marca.getIdAutoByDesc;
          CodigoMarca           := LcProduto.Marca.Registro.Codigo;
          FinalidadeTributacao  := '1';
          UtilizaSerie          := 'N';
          Venda                 := 'S';
          ForaLinha             := 'N';
          CEST                  := '';
          IndicacaoEscala       := 'S';
        end;
        LcProduto.insert;

        //TAbela 1
        LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
        LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
        LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
        LcProduto.TabelaPreco.Preco.Registro.Valor          := FieldByName('PRECOVENDA').AsCurrency;
        LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
        LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
        LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
        LcProduto.TabelaPreco.Preco.Insert;
        //TAbela 2
        LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
        LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 2;
        LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
        LcProduto.TabelaPreco.Preco.Registro.Valor          := 0;
        LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
        LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
        LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
        LcProduto.TabelaPreco.Preco.Insert;

        LcProduto.Estoque.SaldoEstoque.Registro.Codigo := 0;
        LcProduto.Estoque.SaldoEstoque.Registro.CodigoProduto := LcProduto.Registro.Codigo;
        LcProduto.Estoque.SaldoEstoque.Registro.CodigoEstoque := 1;
        LcProduto.Estoque.SaldoEstoque.Registro.QtdeDisp := FieldByName('QUANTIDADE').AsInteger;
        LcProduto.Estoque.SaldoEstoque.Insert;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;
  Finally
    LcProduto.FinalizaQuery( LCQry );
  End;
end;

procedure TFr_Atualiza.MigraSubGrupoSistemaAntigo;
Var
  LcSubGrupo : TControllerSubGRupos;
  LCQry : TSTQuery;
begin
  Try
    LcSubGrupo := TControllerSubGRupos.Create(Nil);
    LCQry := TSTQuery.create(nil);
    with LCQry do
    Begin
      Database := DM.IBD_Servidor;
      Transaction := DM.IBT_Servidor;
      active := FAlse;
      sql.clear;
      sql.add(concat(
                'SELECT * ',
                'FROM TB_SUBGRUPOS '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        LcSubGrupo.Registro.Codigo :=  FieldByName('SBG_CODIGO').AsInteger;
        LcSubGrupo.Registro.Grupo :=  FieldByName('SBG_CODGRP').AsInteger;
        LcSubGrupo.Registro.Descricao :=  FieldByName('SBG_DESCRICAO').AsString;
        LcSubGrupo.Registro.Abas :=  FieldByName('SBG_ABAS').AsString;
        LcSubGrupo.Registro.Impressora :=  FieldByName('SBG_CODIMP').AsInteger;
        LcSubGrupo.Registro.Sequencia :=  FieldByName('SBG_SEQUENCIA').AsInteger;
        LcSubGrupo.salva;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;
  Finally
    LcSubGrupo.setGenerator('GN_SUBGRUPO',LcSubGrupo.Registro.Codigo.ToString());
    FreeAndNil(LcSubGrupo);
    LCQry.Close;
    FreeAndNil(LCQry);
  End;


end;

procedure TFr_Atualiza.MigraTB_PROD_MIGRA;
Var
  LcProduto : TControllerProduto;
  LCQry : TSTQuery;
  LcCliente   : TControllerCliente;
  I : Integer;
  LcVAlida: TACBrValidador;
  LcAchou : Boolean;
begin
  Try
    LcVAlida := TACBrValidador.Create(nil);
    LcVAlida.TipoDocto := docGTIN;

    LcProduto := TControllerProduto.Create(Nil);
    LCQry := LcProduto.GeraQuery;
    with LCQry do
    Begin
      sql.add(concat(
                'SELECT * ',
                'FROM TB_PROD_MIGRA '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        LcProduto.Clear;
        LcVAlida.Documento := TRIM(FieldByName('EAN').AsString);
        if LcVAlida.Validar then
        Begin
          LcProduto.Registro.CodigoBarras := FieldByName('EAN').AsString;
          LcProduto.getbyBarCode;
          LcAchou := LcProduto.exist;
        End
        else
        Begin
          LcProduto.Registro.CodigoBarras := '';
          LcAchou :=  False;
        End;

        if LcAchou then
        Begin
          with LcPRoduto.Registro do
          Begin
            Descricao := Copy( UpperCase( FieldByName('DESCRICAO').AsString ),1,98);
          End;
          LcPRoduto.update;

          LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
          LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
          LcProduto.TabelaPreco.Preco.getByTabelaProduto;
          if LcProduto.TabelaPreco.Preco.exist then
          Begin
            LcProduto.TabelaPreco.Preco.Registro.Valor          := FieldByName('PRECO').AsCurrency;
            LcProduto.TabelaPreco.Preco.update;
          End
          else
          Begin
            //TAbela 1
            LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
            LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
            LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
            LcProduto.TabelaPreco.Preco.Registro.Valor          := FieldByName('PRECO').AsCurrency;
            LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
            LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
            LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
            LcProduto.TabelaPreco.Preco.Insert;
          End;
        End
        else
        Begin
          {
          with LcPRoduto.Registro do
          Begin
            Codigo                := 0;
            CodigoEstabelecimento := Gb_CodMha;
            CodigoFabrica         := '';
            //CodigoBarras          := TRIM(FieldByName('CODIGO').AsString); foi preenchido no inicio
            CodigoNCM             := '62114300';
            Descricao             := Copy( UpperCase( FieldByName('DESCRICAO').AsString ),1,98);

            LcProduto.Medida.Registro.Descricao   := 'UNIDADE';
            LcProduto.Medida.Registro.Abreviatura := 'UND';
            LcProduto.Medida.getIdAutoByDesc;
            MedidaComercial       := LcProduto.Medida.Registro.Codigo;

            LcProduto.Embalagem.Registro.Descricao := 'NORMAL';
            LcProduto.Embalagem.Registro.Abreviatura := 'NRL';
            LcProduto.Embalagem.getIdAutoByDesc;
            CodigoEmbalagem       := LcProduto.Embalagem.Registro.Codigo;

            CodigoGrupo           := LcProduto.Grupo.autocreate('GERAL');
            CodigoSubgrupo        := LcProduto.Grupo.SubGRupo.autocreate(CodigoGrupo,'DIVERSOS');
            Divisor               := 1;
            Origem                := '0';
            Tipo                  := 'P';
            ValorFabrica          :=  0;
            ValorCustoMedio       :=  0;
            ValorCustoMedioAnt    :=  0;
            ValorCusto            :=  0;
            ValorCustoAnt         :=  0;
            SubsTrib              := 'N';
            Campanha              := 'N';
            Destaque              := 'N';
            Ativo                 := 'S';
            Imprime               := 'S';
            EstoqueNegativo       := 'S';
            Exclusivo             := 'N';
            Internet              := 'N';
            MaisVendido           := 'N';
            Composicao            := '1';
            LcProduto.Marca.Registro.Descricao := 'NÃO INFORMADA';
            LcProduto.Marca.getIdAutoByDesc;
            CodigoMarca           := LcProduto.Marca.Registro.Codigo;
            FinalidadeTributacao  := '1';
            UtilizaSerie          := 'N';
            Venda                 := 'S';
            ForaLinha             := 'N';
            CEST                  := '';
            IndicacaoEscala       := 'S';
          end;
          LcProduto.insert;

          //TAbela 1
          LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
          LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
          LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
          LcProduto.TabelaPreco.Preco.Registro.Valor          := FieldByName('PRECO').AsCurrency;
          LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
          LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
          LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
          LcProduto.TabelaPreco.Preco.Insert;
          //TAbela 2
          LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
          LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 2;
          LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
          LcProduto.TabelaPreco.Preco.Registro.Valor          := 0;
          LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
          LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
          LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
          LcProduto.TabelaPreco.Preco.Insert;

          LcProduto.Estoque.SaldoEstoque.Registro.Codigo := 0;
          LcProduto.Estoque.SaldoEstoque.Registro.CodigoProduto := LcProduto.Registro.Codigo;
          LcProduto.Estoque.SaldoEstoque.Registro.CodigoEstoque := 1;
          LcProduto.Estoque.SaldoEstoque.Registro.QtdeDisp := 0;
          LcProduto.Estoque.SaldoEstoque.Insert;
          }
        End;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;
  Finally
    LcProduto.FinalizaQuery( LCQry );
  End;

end;

procedure TFr_Atualiza.MigraTB_PROD_SIST_UNICO;
Var
  LcProduto : TControllerProduto;
  LCQry : TSTQuery;
  LcCliente   : TControllerCliente;
  I : Integer;
  LcVAlida: TACBrValidador;
  LcAchou : Boolean;
begin
  Try
    LcVAlida := TACBrValidador.Create(nil);
    LcVAlida.TipoDocto := docGTIN;

    LcProduto := TControllerProduto.Create(Nil);
    LCQry := LcProduto.GeraQuery;
    with LCQry do
    Begin
      sql.add(concat(
                'SELECT * ',
                'FROM TB_PROD_UNICO  ',
                'order by codigo asc '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        LcProduto.Clear;
        LcVAlida.Documento := TRIM(FieldByName('PRO_CODIGOBAR').AsString);
        if LcVAlida.Validar then
        Begin
          LcProduto.Registro.CodigoBarras := FieldByName('PRO_CODIGOBAR').AsString;
          LcProduto.getbyBarCode;
          LcAchou := LcProduto.exist;
        End
        else
        Begin
          LcProduto.Registro.CodigoBarras := '';
          LcAchou :=  False;
        End;
        if LcProduto.Registro.CodigoBarras <> '' then
        Begin
          if LcAchou then
          Begin
            LcPRoduto.Registro.CodigoNCM := FieldByName('NCM').AsString;
            LcPRoduto.Registro.CEST := FieldByName('CEST').AsString;
            LcPRoduto.update;

            LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
            LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
            LcProduto.TabelaPreco.Preco.getByTabelaProduto;
            if LcProduto.TabelaPreco.Preco.exist then
            Begin
              if ( FieldByName('PRO_PRECO').AsCurrency > LcProduto.TabelaPreco.Preco.Registro.Valor ) then
              Begin
                LcProduto.TabelaPreco.Preco.Registro.Valor          := FieldByName('PRO_PRECO').AsCurrency;
                LcProduto.TabelaPreco.Preco.update;
              End;
            End
            else
            Begin
              //TAbela 1
              LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
              LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
              LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
              LcProduto.TabelaPreco.Preco.Registro.Valor          := FieldByName('PRO_PRECO').AsCurrency;
              LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
              LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
              LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
              LcProduto.TabelaPreco.Preco.Insert;
            End;
          End
          else
          Begin
            with LcPRoduto.Registro do
            Begin
              Codigo                := 0;
              CodigoEstabelecimento := Gb_CodMha;
              CodigoFabrica         := '';
              //CodigoBarras          := TRIM(FieldByName('CODIGO').AsString); foi preenchido no inicio
              CodigoNCM              := FieldByName('NCM').AsString;
              CEST                  := FieldByName('CEST').AsString;
              Descricao             := Copy( UpperCase( FieldByName('PRO_DESCRICAO').AsString ),1,98);

              LcProduto.Medida.Registro.Descricao   := 'UNIDADE';
              LcProduto.Medida.Registro.Abreviatura := 'UND';
              LcProduto.Medida.getIdAutoByDesc;
              MedidaComercial       := LcProduto.Medida.Registro.Codigo;

              LcProduto.Embalagem.Registro.Descricao := 'NORMAL';
              LcProduto.Embalagem.Registro.Abreviatura := 'NRL';
              LcProduto.Embalagem.getIdAutoByDesc;
              CodigoEmbalagem       := LcProduto.Embalagem.Registro.Codigo;

              CodigoGrupo           := LcProduto.Grupo.autocreate('GERAL');
              CodigoSubgrupo        := LcProduto.Grupo.SubGRupo.autocreate(CodigoGrupo,'DIVERSOS');
              Divisor               := 1;
              Origem                := '0';
              Tipo                  := 'P';
              ValorFabrica          :=  0;
              ValorCustoMedio       :=  0;
              ValorCustoMedioAnt    :=  0;
              ValorCusto            :=  0;
              ValorCustoAnt         :=  0;
              SubsTrib              := 'N';
              Campanha              := 'N';
              Destaque              := 'N';
              Ativo                 := 'S';
              Imprime               := 'S';
              EstoqueNegativo       := 'S';
              Exclusivo             := 'N';
              Internet              := 'N';
              MaisVendido           := 'N';
              Composicao            := '1';
              LcProduto.Marca.Registro.Descricao := 'NÃO INFORMADA';
              LcProduto.Marca.getIdAutoByDesc;
              CodigoMarca           := LcProduto.Marca.Registro.Codigo;
              FinalidadeTributacao  := '1';
              UtilizaSerie          := 'N';
              Venda                 := 'S';
              ForaLinha             := 'N';
              CEST                  := '';
              IndicacaoEscala       := 'S';
            end;
            LcProduto.insert;

            //TAbela 1
            LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
            LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
            LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
            LcProduto.TabelaPreco.Preco.Registro.Valor          := FieldByName('PRO_PRECO').AsCurrency;
            LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
            LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
            LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
            LcProduto.TabelaPreco.Preco.Insert;
            //TAbela 2
            LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
            LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 2;
            LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
            LcProduto.TabelaPreco.Preco.Registro.Valor          := 0;
            LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
            LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
            LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
            LcProduto.TabelaPreco.Preco.Insert;

            LcProduto.Estoque.SaldoEstoque.Registro.Codigo := 0;
            LcProduto.Estoque.SaldoEstoque.Registro.CodigoProduto := LcProduto.Registro.Codigo;
            LcProduto.Estoque.SaldoEstoque.Registro.CodigoEstoque := 1;
            LcProduto.Estoque.SaldoEstoque.Registro.QtdeDisp := 0;
            LcProduto.Estoque.SaldoEstoque.Insert;
          End;
          gg_progresso.Progress := gg_progresso.Progress + 1;
          Application.ProcessMessages;
        End;
        Next;
      End;
    End;
  Finally
    LcProduto.FinalizaQuery( LCQry );
  End;


end;

procedure TFr_Atualiza.MigraTecno;
begin
  //MigraTecnoCliente;
  //MigraTecnoMarca;
  //MigraTecnoGrupo;
  MigraTecnoProduto;
end;

procedure TFr_Atualiza.MigraTecnoCliente;
Var
  LCQry : TSTQuery;
  LcCliente   : TControllerCliente;
  I : Integer;
  Lc_Fone : String;
begin
  Try
    LcCliente   := TControllerCliente.CREATE(NIL);
    DM.IBD_Servidor.Connected := False;
    DM.IBD_Servidor.DatabaseName := E_migracao_Local_banco.Text;
    DM.IBD_Servidor.Connected := TRue;
    LCQry := TSTQuery.create(nil);
    with LCQry do
    Begin
      Database := DM.IBD_Servidor;
      Transaction := DM.IBT_Servidor;
      active := FAlse;
      sql.clear;
      sql.add(concat(
            'select ',
            '    psa.ID, ',
            '    psa.CODIGO, ',
            '    psa.NOME, ',
            '    psa.NOMEUSUAL, ',
            '    psa.CPF_CNPJ, ',
            '    psa.INDICADORIE, ',
            '    psa.IE, ',
            '    psa.IM, ',
            '    psa.DATAINICIO, ',
            '    psa.GRUPOPESSOA_ID, ',
            '    psa.LOGRADOURO, ',
            '    psa.NUMIMOVEL, ',
            '    psa.COMPENDERECO, ',
            '    psa.BAIRRO, ',
            '    psa.CEP, ',
            '    psa.LOCALIDADE_ID, ',
            '    psa.DATACAD, ',
            '    psa.TELEFONE, ',
            '    psa.EMAIL, ',
            '    lcl.nome cidade, ',
            '    UF.sigla UF ',
            'from pessoa psa ',
            '   LEFT OUTER JOIN LOCALIDADE LCL ',
            '   ON (LCL.ID = PSA.localidade_id) ',
            '   left outer join UF ',
            '   ON (UF.id = LCL.uf_id) ',
            'where psa.cpf_cnpj is not null '
      ));

      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        if FieldByName('CODIGO').asInteger > 0 then
        Begin
          //Empresa
          with LcCliente do
          Begin
            Empresa.clear;
            Empresa.Registro.Codigo             := 0;
            Empresa.Registro.Tipo               := 1;
            Empresa.Registro.DataCadastro       := FieldByName('DATACAD').asDateTime;
            Empresa.Registro.NomeRazaoSocial    := FieldByName('NOME').asString;
            Empresa.Registro.ApelidoFantasia    := FieldByName('NOMEUSUAL').asString;
            Empresa.Registro.CpfCNPJ            := Fc_RemoveCaracterInformado(FieldByName('CPF_CNPJ').asString,['.','.','.','-','/',' ']);
            Empresa.Registro.InscricaoEstadual  := FieldByName('IE').asString;
            Empresa.Registro.InscricaoMunicipal := FieldByName('IM').asString;
            //Empresa.Registro.Observacao         := FieldByName('OBS').asString;
            Empresa.Registro.DataFundacao       := FieldByName('DATAINICIO').AsDateTime;
            if Length(Empresa.Registro.CpfCNPJ) >11 then
              Empresa.Registro.TipoPessoa         := 'J'
            else
              Empresa.Registro.TipoPessoa         := 'F';
            Empresa.Registro.Email              := FieldByName('EMAIL').asString;
            Empresa.Registro.WebSite            := '';
            Empresa.Registro.ConsumidorFinal    := 'S';
            Empresa.Registro.Multiplicador      := 1;
            Empresa.Registro.Ativa              := 'S';
            Empresa.Registro.OptantePeloSimples := 'N';
            if  FieldByName('INDICADORIE').asString = '1' then
              Empresa.Registro.IndicadorInscricaoEstadual := '1'
            else
              if FieldByName('INDICADORIE').asString = '2' then
                Empresa.Registro.IndicadorInscricaoEstadual := '2'
              else
                Empresa.Registro.IndicadorInscricaoEstadual := '9';
            if (FieldByName('ID').asInteger = 382) then
            Begin
              Empresa.Endereco.clear;
            End;

            Empresa.insert;
            //Endereco
            Empresa.Endereco.clear;
            Empresa.Endereco.Registro.Codigo        := 0;
            Empresa.Endereco.Registro.CodigoEmpresa := Empresa.Registro.Codigo;
            Empresa.Endereco.Registro.Cnpj          := Empresa.Registro.CpfCNPJ;
            Empresa.Endereco.Registro.Tipo          := 'COMERCIAL';
            Empresa.Endereco.Registro.EnderecoPrincipal := 'S';
            Empresa.Endereco.Registro.Logradouro    := FieldByName('LOGRADOURO').asString;
            Empresa.Endereco.Registro.NumeroPredial := FieldByName('NUMIMOVEL').asString;
            Empresa.Endereco.Registro.Complemento   := FieldByName('COMPENDERECO').asString;
            Empresa.Endereco.Registro.Bairro        := FieldByName('BAIRRO').asString;
            Empresa.Endereco.Registro.Cep           := Copy(Fc_RemoveCaracterInformado(FieldByName('CEP').asString,['-',' ']),1,8);
            Empresa.Endereco.Registro.Contato       := '';//FieldByName('CONTATO').asString;

            Lc_Fone := Fc_RemoveCaracterInformado(FieldByName('TELEFONE').asString,['(','x',')','-',' ']);
            if Copy(Lc_Fone,1,1) = '0' then
              Empresa.Endereco.Registro.Fone          := Copy(Lc_Fone,2,Length(Lc_Fone)-1)
            else
              Empresa.Endereco.Registro.Fone          := Lc_Fone;


            Empresa.Endereco.Registro.CodigoPais    := 1058;
            Empresa.Endereco.Registro.CodigoCidade  := Fc_BuscaCodigoCidade(0,FieldByName('CIDADE').asString,FieldByName('UF').asString);
            Empresa.Endereco.Registro.CodigoEstado  := Fc_BuscaCodigoEstado(FieldByName('UF').asString);
            Empresa.Endereco.insert;
            //Cliente
            Registro.Codigo             := LcCliente.Empresa.Registro.Codigo;
            Registro.Ativo              := 'S';
            Registro.EnviarSomenteXML   := 'N';
            Registro.ValorEntrega       := 0;
            Registro.EnviaEmailNFeAuto  := 'N';
            salva;
          End;
        End;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
    End;

  Finally
    FreeAndNil(LcCliente);
    LCQry.Close;
    FreeAndNil(LCQry);
  End;

end;

procedure TFr_Atualiza.MigraTecnoGrupo;
Var
  LcGrupo : TControllerGrupos;
  LCQry : TSTQuery;
  LcCliente   : TControllerCliente;
  I : Integer;
begin
  Try
    LcGrupo := TControllerGrupos.Create(Nil);
    LcGrupo.Registro.Codigo := 0;
    LcGrupo.Registro.Descricao := 'Geral';
    LcGrupo.Registro.Ativo := 'S';
    LcGrupo.insert;
    DM.IBD_Servidor.DatabaseName := E_migracao_Local_banco.Text;
    DM.IBD_Servidor.Connected := TRue;
    LCQry := TSTQuery.create(nil);
    with LCQry do
    Begin
      Database := DM.IBD_Servidor;
      Transaction := DM.IBT_Servidor;
      active := FAlse;
      sql.clear;
      sql.add(concat(
                'SELECT ID, NOME ',
                'FROM GRUPOPRODUTO   ',
                'ORDER BY ID '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        LcGrupo.SubGRupo.Clear;
        with LcGrupo.SubGRupo.Registro do
        Begin
          Codigo := StrToIntDef(FieldByNAme('ID').AsString,0);
          Grupo  := LcGrupo.Registro.Codigo;
          Descricao := FieldByNAme('NOME').AsString;
        end;
        LcGrupo.SubGRupo.salva;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
      LcGrupo.SubGRupo.setGenerator('GN_SUBGRUPO',FieldByNAme('ID').AsString);
    End;
  Finally
    FreeAndNil(LcGrupo);
    LCQry.Close;
    FreeAndNil(LCQry);
  End;


end;

procedure TFr_Atualiza.MigraTecnoMarca;
Var
  LcMarca : TControllerMarcaProduto;
  LCQry : TSTQuery;
  LcCliente   : TControllerCliente;
  I : Integer;
  LcVAlida: TACBrValidador;
begin
  Try
    LcVAlida := TACBrValidador.Create(nil);
    LcVAlida.TipoDocto := docGTIN;

    LcMarca := TControllerMarcaProduto.Create(Nil);
    DM.IBD_Servidor.DatabaseName := E_migracao_Local_banco.Text;
    DM.IBD_Servidor.Connected := TRue;
    LCQry := TSTQuery.create(nil);
    with LCQry do
    Begin
      Database := DM.IBD_Servidor;
      Transaction := DM.IBT_Servidor;
      active := FAlse;
      sql.clear;
      sql.add(concat(
                'SELECT ID, NOME ',
                'FROM FABRICANTE ',
                'ORDER BY ID '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        LcMarca.Clear;
        with LcMarca.Registro do
        Begin
          Codigo := StrToIntDef(FieldByNAme('ID').AsString,0);
          Descricao := FieldByNAme('NOME').AsString;
        end;
        LcMarca.salva;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
      LcMarca.setGenerator('GN_MARCAPRODUTO',FieldByNAme('ID').AsString);
    End;
  Finally
    FreeAndNil(LcMarca);
    LCQry.Close;
    FreeAndNil(LCQry);
  End;


end;

procedure TFr_Atualiza.MigraTecnoProduto;
Var
  LcProduto : TControllerProduto;
  LCQry : TSTQuery;
  LcCliente   : TControllerCliente;
  I : Integer;
  LcVAlida: TACBrValidador;
begin
  Try
    LcVAlida := TACBrValidador.Create(nil);
    LcVAlida.TipoDocto := docGTIN;

    LcProduto := TControllerProduto.Create(Nil);
    DM.IBD_Servidor.DatabaseName := E_migracao_Local_banco.Text;
    DM.IBD_Servidor.Connected := TRue;
    LCQry := TSTQuery.create(nil);
    with LCQry do
    Begin
      Database := DM.IBD_Servidor;
      Transaction := DM.IBT_Servidor;
      active := FAlse;
      sql.clear;
      sql.add(concat(
              'SELECT ',
              '    P.ID, ',
              '    P.TIPO, ',
              '    P.CODIGO, ',
              '    P.CODIGOBARRAS, ',
              '    P.REFERENCIA, ',
              '    P.DESCRICAO, ',
              '    P.UNIDADE, ',
              '    P.FABRICANTE_ID, ',
              '    P.GRUPOPRODUTO_ID, ',
              '    P.ST, ',
              '    P.ESTOQUE, ',
              '    P.ESTOQUEMIN, ',
              '    P.PRECOCUSTO, ',
              '    P.PRECOVENDA, ',
              '    P.PERCCOMISSAO, ',
              '    ncm.codigo pro_ncm, ',
              '    CEST.codigo pro_cest, ',
              '    P.ORIGEMPRODUTO_ID, ',
              '    P.GRUPOCFOP_ID, ',
              '    P.ATIVO ',
              'FROM PRODUTO p ',
              '    left outer join ncm ',
              '    on (ncm.id = p.ncm_id) ',
              '    left outer join cest ',
              '    on (cest.id = p.cest_id) ',
              'where p.id > 4635',
              ' order by p.id '
      ));
      Active := True;
      FetchAll;
      First;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RecordCount;
      gg_progresso.Progress := 0;
      Application.ProcessMessages;
      while not eof do
      BEgin
        LcProduto.Clear;
        with LcPRoduto.Registro do
        Begin
          Codigo := StrToIntDef(FieldByNAme('ID').AsString,0);
          CodigoEstabelecimento := Gb_CodMha;
          CodigoFabrica := FieldByNAme('ID').AsString;

          LcVAlida.Documento := TRIM(FieldByName('CODIGOBARRAS').AsString);
          if LcVAlida.Validar then
            CodigoBarras := TRIM(FieldByName('CODIGOBARRAS').AsString)
          else
            CodigoBarras := '';
          CodigoNCM       := FieldByName('PRO_NCM').AsString;
          Descricao       := Copy( UpperCase( FieldByName('DESCRICAO').AsString ),1,98);

          LcProduto.Medida.Registro.Descricao   := FieldByName('UNIDADE').AsString;
          LcProduto.Medida.Registro.Abreviatura := FieldByName('UNIDADE').AsString;
          LcProduto.Medida.getIdAutoByDesc;
          MedidaComercial := LcProduto.Medida.Registro.Codigo;

          CodigoEmbalagem := 1;

          CodigoGrupo     := 1;
          CodigoSubgrupo  := StrToIntDef(FieldByNAme('GRUPOPRODUTO_ID').AsString,1);
          Divisor := 1;
          Origem := '0';
          Tipo := 'P';
          ValorFabrica        :=  0;
          ValorCustoMedio     :=  FieldByName('PRECOCUSTO').AsCurrency;
          ValorCustoMedioAnt  :=  FieldByName('PRECOCUSTO').AsCurrency;
          ValorCusto          :=  FieldByName('PRECOCUSTO').AsCurrency;
          ValorCustoAnt       :=  0;
          if Length(FieldByName('PRO_NCM').AsString)>0 then
            SubsTrib := 'S'
          else
            SubsTrib := 'N';
          Campanha := 'N';
          Destaque := 'N';
          if FieldByName('ATIVO').AsInteger = 1 then
            Ativo := 'S'
          else
            Ativo := 'N';
          Imprime := 'S';
          EstoqueNegativo := 'S';
          Exclusivo := 'N';
          Internet := 'N';
          MaisVendido := 'N';
          Composicao := '1';
          CodigoMarca := StrToIntDef(FieldByNAme('FABRICANTE_ID').AsString,1);
          FinalidadeTributacao := '1';
          UtilizaSerie := 'N';
          Venda := 'S';
          ForaLinha := 'N';
          CEST := FieldByNAme('PRO_CEST').AsString;
          IndicacaoEscala := 'S';
        end;
        LcProduto.save;

        //TAbela 1
        LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
        LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
        LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
        LcProduto.TabelaPreco.Preco.Registro.Valor          := FieldByName('PRECOVENDA').AsCurrency;
        LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
        LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
        LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
        LcProduto.TabelaPreco.Preco.Insert;
        //TAbela 2
        LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
        LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 2;
        LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
        LcProduto.TabelaPreco.Preco.Registro.Valor          := 0;
        LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
        LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
        LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
        LcProduto.TabelaPreco.Preco.Insert;

        LcProduto.Estoque.SaldoEstoque.REgistro.Codigo := 0;
        LcProduto.Estoque.SaldoEstoque.REgistro.CodigoEstoque := 1;
        LcProduto.Estoque.SaldoEstoque.REgistro.CodigoProduto := LcProduto.Registro.Codigo;
        LcProduto.Estoque.SaldoEstoque.Registro.QtdeDisp := 0;
        LcProduto.Estoque.SaldoEstoque.Insert;

        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      End;
      LcProduto.setGenerator('GN_PRODUTYO',FieldByName('ID').AsString);
    End;
  Finally
    FreeAndNil(LcProduto);
    LCQry.Close;
    FreeAndNil(LCQry);
  End;
end;

procedure TFr_Atualiza.MigraUniPlus;
Var
  LcProduto : TControllerProduto;
  LcCliente   : TControllerCliente;
  I : Integer;
  LcVAlida: TACBrValidador;
  LcAchou : Boolean;
begin
  try
    LcVAlida := TACBrValidador.Create(nil);
    LcVAlida.TipoDocto := docGTIN;
    LcProduto := TControllerProduto.Create(Nil);
    DBUniplus.Connected := true;
    Qr_UniPlus_Produto.Active := True;
    gg_progresso.MinValue := 0;
    gg_progresso.MaxValue := Qr_UniPlus_Produto.RecordCount;
    gg_progresso.Progress := 0;
    Application.ProcessMessages;

    while not Qr_UniPlus_Produto.eof do
    BEgin
      LcProduto.Clear;
      LcVAlida.Documento := TRIM(Qr_UniPlus_Produtoean.AsString);
      if LcVAlida.Validar then
      Begin
        LcProduto.Registro.CodigoBarras := TRIM(Qr_UniPlus_Produtoean.AsString);
        LcProduto.getbyBarCode;
        LcAchou := LcProduto.exist;
      End
      else
      Begin
        LcProduto.Registro.CodigoBarras := '';
      End;


      with LcPRoduto.Registro do
      Begin
        Codigo                := Qr_UniPlus_Produtoid.AsInteger;
        CodigoEstabelecimento := Gb_CodMha;
        CodigoFabrica         := '';
        //CodigoBarras          := TRIM(FieldByName('CODIGO').AsString); foi preenchido no inicio
        CodigoNCM              := TRIM(Qr_UniPlus_Produtoncm.AsString);
        CEST                  := TRIM(Qr_UniPlus_Produtocest.AsString);
        Descricao             := Copy( UpperCase( TRIM(Qr_UniPlus_Produtonome.AsString) ),1,98);


        LcProduto.Medida.Registro.Descricao   := UpperCase( TRIM(Qr_UniPlus_Produtounidademedida.AsString) );
        LcProduto.Medida.Registro.Abreviatura := UpperCase( TRIM(Qr_UniPlus_Produtounidademedida.AsString) );
        LcProduto.Medida.getIdAutoByDesc;
        MedidaComercial       := LcProduto.Medida.Registro.Codigo;

        LcProduto.Embalagem.Registro.Descricao := 'NORMAL';
        LcProduto.Embalagem.Registro.Abreviatura := 'NRL';
        LcProduto.Embalagem.getIdAutoByDesc;
        CodigoEmbalagem       := LcProduto.Embalagem.Registro.Codigo;

        CodigoGrupo           := LcProduto.Grupo.autocreate('GERAL');
        CodigoSubgrupo        := LcProduto.Grupo.SubGRupo.autocreate(CodigoGrupo,'DIVERSOS');

        Divisor               := 1;
        Origem                := '0';
        Tipo                  := 'P';
        ValorFabrica          :=  0;
        ValorCustoMedio       := Qr_UniPlus_Produtocustomedio.AsCurrency;
        ValorCustoMedioAnt    := Qr_UniPlus_Produtocustomedio.AsCurrency;
        ValorCusto            := Qr_UniPlus_Produtoprecocusto.AsCurrency;
        ValorCustoAnt         := Qr_UniPlus_Produtoprecocusto.AsCurrency;
        if Qr_UniPlus_Produtocest.AsString <> '' then
          SubsTrib              := 'S'
        else
          SubsTrib              := 'N';
        Campanha              := 'N';
        Destaque              := 'N';
        Ativo                 := 'S';
        Imprime               := 'S';
        EstoqueNegativo       := 'S';
        Exclusivo             := 'N';
        Internet              := 'N';
        MaisVendido           := 'N';
        Composicao            := '1';
        CodigoMarca           := 1;
        FinalidadeTributacao  := '1';
        UtilizaSerie          := 'N';
        Venda                 := 'S';
        ForaLinha             := 'N';
        CEST                  := '';
        IndicacaoEscala       := 'S';
        Localizacao           := '';
      end;
      LcProduto.insert;

      //TAbela 1
      LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
      LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
      LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
      LcProduto.TabelaPreco.Preco.Registro.Valor          := Qr_UniPlus_Produtopreco.AsCurrency;
      LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
      LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
      LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := Qr_UniPlus_Produtolucrobruto.AsCurrency;
      LcProduto.TabelaPreco.Preco.Insert;
      //TAbela 2
      LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
      LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 2;
      LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Registro.Codigo;
      LcProduto.TabelaPreco.Preco.Registro.Valor          := 0;
      LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
      LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
      LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
      LcProduto.TabelaPreco.Preco.Insert;

      LcProduto.Estoque.SaldoEstoque.Registro.Codigo := 0;
      LcProduto.Estoque.SaldoEstoque.Registro.CodigoProduto := LcProduto.Registro.Codigo;
      LcProduto.Estoque.SaldoEstoque.Registro.CodigoEstoque := 1;
      LcProduto.Estoque.SaldoEstoque.Registro.QtdeDisp := 0;
      LcProduto.Estoque.SaldoEstoque.Insert;

      gg_progresso.Progress := gg_progresso.Progress + 1;
      Application.ProcessMessages;
      Qr_UniPlus_Produto.Next;
    End;
  finally
    LcProduto.setGenerator('GN_PRODUTO', Qr_UniPlus_Produtoid.AsString);
    FreeAndNil(LcProduto);
  end;

end;

procedure TFr_Atualiza.MigraXML_TO_XML_gestao;
Var
  LcArquivos : TControllerArquivo;
  Lc_First,Lc_Skip : Integer;
  Lc_Ciclo : Integer;
  N : Integer;
  I : Integer;
Label
  Reinicia;
begin
  try
    Lc_Ciclo := 1;
    Lc_First := 1;
    Lc_Skip  := 0;

    DM.IBD_Servidor.DatabaseName := E_migracao_Local_banco.Text;
    DM.IBD_Servidor.Connected := TRue;
    LcArquivos := TControllerArquivo.create(nil);
    LcArquivos.DataBase := DM.IBD_Servidor;
    Reinicia:
    LcArquivos.getFirst;
    if LcArquivos.exist then
    Begin
      LcArquivos.DataBase := DM.IBD_Gestao;
      //LcArquivos.ClonarObj(LcArquivos.Lista[I],LcArquivos.Registro);
      LcArquivos.insere;

      LcArquivos.DataBase := DM.IBD_Servidor;
      //Apagar o registros que já forma lidos. para pegar outros 50
      //LcArquivos.ClonarObj(LcArquivos.Lista[I],LcArquivos.Registro);
      LcArquivos.Delete;
      //Verifica se tem mais - novo ciclo
      LcArquivos.getFirst;
      if LcArquivos.exist then
        goto Reinicia;
    End;
  finally
    FreeAndNil(LcArquivos);
  end;
end;

procedure TFr_Atualiza.Pc_AtualizaCategory(Pc_Cd_Produto,
  Pc_Categoria: Integer);
Var
  LcQry : TSTQuery;
begin
  Try
    //Tanto faz o objeto e somente para usar a função do Generator
    LcQry := TSTQuery.create(Self);
    with LcQry do
    Begin
      Active := False;
      Database := DM.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      //GN_Produto
      Active := false;
      sql.clear;
      sql.add(concat('UPDATE TB_PRODUTO SET ',
                     'PRO_CODCAT=:PRO_CODCAT ',
                     'WHERE PRO_CODIGO=:PRO_CODIGO'
      ));
      Active := False;
      ParamByName('PRO_CODIGO').AsInteger := Pc_Cd_Produto;
      ParamByName('PRO_CODCAT').AsInteger := Pc_Categoria;
      ExecSQL;
    End;
  Finally
    LcQry.Close;
    FreeAndNil(LcQry);
  end;

end;

procedure TFr_Atualiza.Pc_AtualizaEstoque;
Var
  Lc_Inventario : TControllerInventario;
begin
  Lc_Inventario := TControllerInventario.create(nil);
  Qr_Produto.Active := False;
  Qr_Produto.ParamByName('DATAINI').AsDateTime := E_Dt_Inicio_Movimento.DateTime;
  Qr_Produto.ParamByName('DATAFIM').AsDateTime := E_Dt_fim_Movimento.DateTime;
  Qr_Produto.ParamByName('EST_CODIGO').AsInteger:= Fm_ListaEstoques.DBLCB_Estoque.KeyValue;
  Qr_Produto.Active := True;
  Qr_Produto.FetchAll;

  Gg_Progresso.MinValue := 0;
  Gg_Progresso.MaxValue := Qr_Produto.RecordCount;
  Qr_Produto.First;
  Qr_Produto.FetchAll;
  while not Qr_Produto.Eof do
  Begin
    Lc_Inventario.DataInicial   := E_Dt_Inicio_Movimento.DateTime;
    Lc_Inventario.DataFinal     := E_Dt_Fim_Movimento.DateTime;
    Lc_Inventario.CodigoProduto := Qr_Produto.FieldByName('PRO_CODIGO').AsInteger;
    Lc_Inventario.CodigoEstoque       := Fm_ListaEstoques.DBLCB_Estoque.KeyValue;
    Lc_Inventario.DeletarMovimento;
    Lc_Inventario.GerarMovimento;
    Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
    Application.ProcessMessages;
    Qr_Produto.Next;
  end;
  Gg_Progresso.Progress := Gg_Progresso.MaxValue;
  Application.ProcessMessages;
end;

procedure TFr_Atualiza.Sb_AjustaGeneratorClick(Sender: TObject);
Var
  LcQry : TSTQuery;
  LcEstoque : TControllerEstoque;
begin
  Try
    //Tanto faz o objeto e somente para usar a função do Generator
    LcEstoque := TControllerEstoque.create(Self);
    LcQry := TSTQuery.create(Self);
    with LcQry do
    Begin
      Active := False;
      Database := DM.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      //GN_Produto
      Active := false;
      sql.clear;
      sql.add('select max(pro_codigo) total from tb_produto');
      active := True;

      LcEstoque.SetGenerator('GN_PRODUTO',FieldByName('total').AsString);
      //GN_grupo
      Active := false;
      sql.clear;
      sql.add('select max(GRP_codigo) total from tb_GRUPOS ');
      active := True;
      LcEstoque.SetGenerator('GN_GRUPO',FieldByName('total').AsString);
      //GN_SUBGRUPO
      Active := false;
      sql.clear;
      sql.add('select max(SBG_codigo) total from tb_SUBGRUPOS ');
      active := True;
      LcEstoque.SetGenerator('GN_SUBGRUPO',FieldByName('total').AsString);
      //GN_MARCAPRODUTO
      Active := false;
      sql.clear;
      sql.add('select max(MRC_codigo) total from tb_MARCA_PRODUTO ');
      active := True;
      LcEstoque.SetGenerator('GN_MARCAPRODUTO',FieldByName('total').AsString);
      //GN_MEDIDA
      Active := false;
      sql.clear;
      sql.add('select max(MED_codigo) total from tb_MEDIDA ');
      active := True;
      LcEstoque.SetGenerator('GN_MEDIDA',FieldByName('total').AsString);
      //GN_EMBALAGEM
      Active := false;
      sql.clear;
      sql.add('select max(EMB_codigo) total from tb_EMBALAGEM ');
      active := True;
      LcEstoque.SetGenerator('GN_EMBALAGEM',FieldByName('total').AsString);
      //GN_ESTOQUE
      Active := false;
      sql.clear;
      sql.add('select max(EST_codigo) total from tb_ESTOQUE ');
      active := True;
      LcEstoque.SetGenerator('GN_ESTOQUE',FieldByName('total').AsString);
      //GN_PRECO
      Active := false;
      sql.clear;
      sql.add('select max(PRC_codigo) total from tb_PRECO ');
      active := True;
      LcEstoque.SetGenerator('GN_PRECO',FieldByName('total').AsString);
      //GN_eMPRESA
      Active := false;
      sql.clear;
      sql.add('select max(EMP_codigo) total from tb_EMPRESA ');
      active := True;
      LcEstoque.SetGenerator('GN_EMPRESA',FieldByName('total').AsString);
      //GN_Endereco
      Active := false;
      sql.clear;
      sql.add('select max(END_codigo) total from tb_ENDERECO ');
      active := True;
      LcEstoque.SetGenerator('GN_ENDERECO',FieldByName('total').AsString);

    End;
  Finally
    FreeAndNil( LcEstoque );
    FreeAndNil( LcQry );
  End;
end;

procedure TFr_Atualiza.Sb_Clone_Pizza_CalzoneClick(Sender: TObject);
Begin
  DesativaProdutosPizzaKilo;
  CriarGrupoCalzone;
  CriarSubGrupoCalzone;
  ClonarMedidasPizzaParaCAlzone;
  ClonarPizzaParaCalzone;
end;

procedure TFr_Atualiza.Sb_GrupoToCategoriaClick(Sender: TObject);
Var
  Lc_Categorias:TStringList;
  Lc_Cd_Categoria : Integer;
  Lc_SqlTxt : String;
  LcProduto : TControllerProduto;

  I : Integer;
  LcQry : TSTQuery;
begin
  Try
    LcProduto := TControllerProduto.create(nil);
    LcQry := TSTQuery.create(nil);
    with LcQry do
    Begin
      Active := False;
      Transaction := DM.IBT_Estoque;
      SQL.Clear;
      Lc_SqlTxt := 'select PRO_CODIGO, GRP_DESCRICAO, SBG_DESCRICAO '+
                   ' FROM tb_produto '+
                   '  INNER JOIN tb_grupos '+
                   '  ON (grp_CODIGO = pro_codGRP) '+
                   '  INNER JOIN tb_subgrupos '+
                   '  ON (sbg_CODIGO = pro_codSBG) '+
                   ' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO ';
      SQL.Add(Lc_SqlTxt);
      Active := True;
      FetchAll;
      gg_progresso.Progress := 0;
      gg_progresso.MinValue := 0;
      gg_progresso.MaxValue := RECORDCOUNT;
      Application.ProcessMessages;
      First;
      Lc_Categorias := TStringList.Create;
      while not Eof do
      Begin
        Lc_Categorias.Clear;
        //Verifica se tem a Categoria
        Lc_Categorias := Fc_ConsultaCategory(FieldByName('GRP_DESCRICAO').AsString,
                                             FieldByName('sbg_DESCRICAO').AsString);
        Lc_Cd_Categoria := StrToIntDef(Lc_Categorias.ValueFromIndex[1],0);
        If (Lc_Cd_Categoria = 0) then
          Lc_Cd_Categoria :=  Fc_CriaCategory(Lc_Categorias,
                                              FieldByName('GRP_DESCRICAO').AsString,
                                              FieldByName('SBG_DESCRICAO').AsString);
        Pc_AtualizaCategory(FieldByName('PRO_CODIGO').AsInteger,
                            Lc_Cd_Categoria);
        Next;
        gg_progresso.Progress := gg_progresso.Progress + 1;
        Application.ProcessMessages;
      end;
    end;
  Finally
    LcQry.close;
    FreeAndNil(LcQry);
    FreeAndNil(LcProduto);
  End;

end;

procedure TFr_Atualiza.Sb_migracaoClick(Sender: TObject);
begin
  case Cb_TipoBancoDados.ItemIndex of
    0:MigraSistemaAntigo;
    1:MigraSistemaGDOOR;
    2:MigraSistemaGestaoGestaoCompara;
    3:MigraProduto_Para_TB_PRODUTOS;
    4:MigraSistemaPantera;
    5:MigraSistemaWinsic;
    6:MigraTB_PROD_MIGRA;
    7:MigraTB_PROD_SIST_UNICO;
    8:MigraXML_TO_XML_gestao;
    9:MigraExcellent;
    10:MigraUniPlus;
    11:MigraExcelLourenco;
    12:MigraTecno;
    13:Alegrito;
  end;
end;

procedure TFr_Atualiza.Sb_ReordenaProdutoClick(Sender: TObject);
Var
  LcProduto : TControllerProduto;
  I : Integer;
begin
  Try
    LcProduto := TControllerProduto.Create(Nil);
    LcProduto.Progresso := gg_progresso;
    LcProduto.ReOrdenaSequenciaCodigo;
    Application.ProcessMessages
  Finally
    FreeAndNil(LcProduto);
  End;
end;

procedure TFr_Atualiza.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Atualiza.Sb_VincularTabelaPrecoClick(Sender: TObject);
Var
  LcProduto : TControllerProduto;
  I : Integer;
begin
  Try
    LcProduto := TControllerProduto.Create(Nil);
    LcProduto.getList('');
    gg_progresso.Progress := 0;
    gg_progresso.MinValue := 0;
    gg_progresso.MaxValue := LcProduto.Lista.Count;
    Application.ProcessMessages;
    //TAbela 1
    for I := 0 to LcProduto.Lista.Count -1 do
    Begin
      LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
      LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 1;
      LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Lista[I].Codigo;
      LcProduto.TabelaPreco.Preco.Registro.Valor          := 0;
      LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
      LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
      LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
      LcProduto.TabelaPreco.Preco.Insert;
    End;
    //TAbela 2
    for I := 0 to LcProduto.Lista.Count -1 do
    Begin
      LcProduto.TabelaPreco.Preco.Registro.Codigo         := 0;
      LcProduto.TabelaPreco.Preco.Registro.CodigoTabela   := 2;
      LcProduto.TabelaPreco.Preco.Registro.CodigoProduto  := LcProduto.Lista[I].Codigo;
      LcProduto.TabelaPreco.Preco.Registro.Valor          := 0;
      LcProduto.TabelaPreco.Preco.Registro.AliComissao    := 0;
      LcProduto.TabelaPreco.Preco.Registro.QtdeMinima     := 0;
      LcProduto.TabelaPreco.Preco.Registro.MargemLucro    := 0;
      LcProduto.TabelaPreco.Preco.Insert;
    End;

  Finally
    FreeAndNil(LcProduto);
  End;
end;

procedure TFr_Atualiza.SpeedButton1Click(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja Recontar todos o estoque movimentado no Sistema?'+EOLN+EOLN+
                     'Isso pode levar vários Minutos. Confirma a Operação?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
  begin
    try
      Pc_ProcesoAguarde(Self,'I');
      Self.Enabled := False;
      Pc_LimpaQrPreviweMemoria;
      if trim(Fm_ListaEstoques.DBLCB_Estoque.Text)<> '' then
      Begin
        Pc_AtualizaEstoque;
      end
      else
      Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Favor selecionar um Estoque para a contagem.'+EOLN+
                       'Verifique e tente novamente.'+EOLN,
                      ['OK'],[bEscape],mpAlerta);
      end;
    finally
      Pc_ProcesoAguarde(Self,'F');
      Self.Enabled := True;
    end;
  end;
end;

procedure TFr_Atualiza.SpeedButton27Click(Sender: TObject);
Var
  I : Integer;
  Lc_in : String;
  LcQry : TSTQuery;
  LcInicio : Boolean;
  LcProdutoID : Integer;
  LcTabelaID : Integer;
  Lc_Tabela : TControllerTabelaPreco;
begin
  Lc_Tabela  := TControllerTabelaPreco.create(Self);
  LcQry       := Lc_Tabela.GeraQuery;
  Lc_Tabela.getList;
  try
    for I := 0 to Lc_Tabela.Lista.Count -1 do
    Begin
      with LcQry do
      Begin
        Active := False;
        sql.Clear;
        sql.Add(concat(
                  'select p.prc_codpro ',
                  'from tb_preco p ',
                  'where PRC_CODTPR =:PRC_CODTPR ',
                  'group by p.prc_codpro ',
                  'having count(p.prc_codpro)>1 '
        ));
        ParamByName('PRC_CODTPR').AsInteger := Lc_Tabela.Lista[I].Codigo;
        Active := True;
        FetchAll;
        Lc_in := '';
        if recordCount > 0 then
        Begin
          First;
          Lc_in := ' PRC_CODPRO in (' ;
          while not eof do
          Begin
            if bof then
              Lc_in := concat(Lc_in, FieldByName('prc_codpro').AsString)
            else
              Lc_in := concat(Lc_in, ',', FieldByName('prc_codpro').AsString);
            Next;
          End;
          Lc_in := concat(Lc_in, ')');
        End;
      End;

      if Length(Lc_in) > 0 then
      Begin
        with LcQry do
        Begin
          Active := False;
          sql.Clear;
          sql.Add(concat(
                    'SELECT PR.* ',
                    'FROM TB_PRECO PR ',
                    'WHERE PRC_CODTPR =:PRC_CODTPR ',
                    ' and ' ,Lc_in,
                    ' ORDER BY pr.prc_codtpr, pr.prc_codpro ASC, PR.prc_vl_vda DESC '
          ));
          ParamByName('PRC_CODTPR').AsInteger := Lc_Tabela.Lista[I].Codigo;
          Active := True;
          FetchAll;
          gg_progresso.Progress := 0;
          gg_progresso.MinValue := 0;
          gg_progresso.MaxValue := RecordCount;
          Application.ProcessMessages;
          First;
          LcInicio := True;
          LcProdutoID := 0;
          Repeat
            LcProdutoID := FieldByName('PRC_CODPRO').asInteger;
            LcTabelaID  := FieldByName('PRC_CODTPR').asInteger ;

            next;
            gg_progresso.Progress := gg_progresso.Progress  + 1;
            Application.ProcessMessages;

            Repeat

              if ( LcTabelaID = FieldByName('PRC_CODTPR').asInteger ) and
                 ( LcProdutoID = FieldByName('PRC_CODPRO').asInteger ) then
                BEgin
                  //Lc_Tabela.Preco.Registro.CodigoTabela  := FieldByName('PRC_CODTPR').asInteger;
                  //Lc_Tabela.Preco.Registro.CodigoProduto := FieldByName('PRC_CODPRO').asInteger;
                  Lc_Tabela.Preco.Registro.Codigo := FieldByName('PRC_CODIGO').asInteger;
                  Lc_Tabela.Preco.deleteByID;
                end;

              Next;
              gg_progresso.Progress := gg_progresso.Progress  + 1;
              Application.ProcessMessages;

            Until (( LcProdutoID <> FieldByName('PRC_CODPRO').asInteger) or eof) ;



            gg_progresso.Progress := gg_progresso.Progress  + 1;
            Application.ProcessMessages;
          Until eof;

        End;
      End
      else
      Begin
        ShowMessage(concat('Não tem preco duplicado na tabela ',Lc_Tabela.Lista[I].Descricao));
      End;
    End;
  finally
    Lc_Tabela.FinalizaQuery(LcQry);
    freeAndNil(Lc_Tabela);
  end;
end;

procedure TFr_Atualiza.SpeedButton2Click(Sender: TObject);
var
  St_Image:TStream;
  Jp_IMage: TJpegImage; // sem a unit 'jpeg' essa classe não existiria
begin
  Try

    with Qr_Image do
    Begin
      Active := True;
      First;
      while not eof do
      Begin
        Jp_IMage := nil;
        St_Image := CreateBlobStream(FieldByName('content'),bmRead);
        if St_Image.Size > 0 then
        begin
          if (FieldByName('extension').AsString = 'jpg') then
          Begin
            Try
              Jp_IMage := TJpegImage.Create;
              Jp_IMage.LoadFromStream(St_Image);
              Jp_IMage.SaveToFile(GbPathExe + FieldByName('file_name').AsString);
            Finally
              FreeAndNil(Jp_IMage);
            End;
          end
          else
          if (FieldByName('extension').AsString = 'png') then
          Begin
            TBlobField(FieldByName('content')).SaveToFile(GbPathExe + FieldByName('file_name').AsString);
          end;
        end;
        Next;
      End;
    end;
  Finally
    if Assigned(Jp_IMage) then Jp_IMage.Free;
    if Assigned(St_Image) then St_Image.Destroy;
  End;
end;

procedure TFr_Atualiza.SpeedButton3Click(Sender: TObject);
var
  F: TSearchRec;
  Ret: Integer;
 TempNome: string;
 Lc_Diretorio:String;
  Lc_Sub : Boolean;
begin
  Lc_Sub := False;
  MM_ListaArquivos.Lines.Clear;
  Lc_Diretorio := E_PathDiretorio.Text;
  Ret := FindFirst(Lc_Diretorio+'\*.*', faAnyFile, F);
  try
    while Ret = 0 do
      begin
      if TemAtributo(F.Attr, faDirectory) then
        begin
        if (F.Name <> '.') And (F.Name <> '..') then
          if Lc_Sub = True then
            begin
            TempNome := Lc_Diretorio+'\' + F.Name;
            ListarArquivos(TempNome, True);
            end;
        end
      else
        begin
        MM_ListaArquivos.Lines.Add(F.Name);
        end;
      Ret := FindNext(F);
      end;
  finally
    begin
    FindClose(F);
    end;
  end;

end;

procedure TFr_Atualiza.tbs_produtosShow(Sender: TObject);
begin
  Fm_ListaEstoques.AtivaLista(Gb_CodMha);
end;

function TFr_Atualiza.TemAtributo(Attr, Val: Integer): Boolean;
begin
  Result := Attr and Val = Val;
end;

end.
