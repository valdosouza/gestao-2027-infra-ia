unit Un_NF_55;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, DBCtrls, DB, Mask, STQuery, Grids, DBGrids, ExtCtrls, Buttons, ComCtrls, dbcgrids, STStoredProc, Menus, pcnLeitor, DBClient, QEdit_Setes;

type
  TFr_NF_55 = class(TForm)
    Qr_ItensNota: TSTQuery;
    Qr_ItensNotaITF_CODIGO: TIntegerField;
    Qr_ItensNotaITF_CODPRO: TIntegerField;
    Qr_ItensNotaMED_ABREVIATURA: TStringField;
    Qr_ItensNotaPRO_CODIGOFAB: TStringField;
    Qr_ItensNotaPRO_DESCRICAO: TStringField;
    Qr_ItensNotaITF_QTDE: TBCDField;
    Qr_ItensNotaITF_VL_UNIT: TFloatField;
    Qr_ItensNotaITF_SUBTOTAL: TFloatField;
    Qr_ItensNotaITF_VL_COM: TFloatField;
    Qr_ItensNotaITF_VL_DESC: TBCDField;
    Qr_ItensNotaPRO_TIPO: TStringField;
    Qr_ItensNotaPRO_SERIE: TStringField;
    Qr_ItensNotaEMB_ABREVIATURA: TStringField;
    Qr_ItensNotaITF_ESTOQUE: TStringField;
    Qr_ItensNotaITF_OPER: TStringField;
    Qr_ItensNotaITF_CODEST: TIntegerField;
    Qr_ItensNotaITF_VL_TOTAL: TFloatField;
    Qr_ItensNotaITF_AQ_COM: TBCDField;
    Qr_ItensNotaPRO_VL_CUSTOMED: TFloatField;
    Qr_ItensNotaITF_AQ_DESC: TBCDField;
    Qr_ItensNotaITF_AQ_IPI: TBCDField;
    Qr_ItensNotaITF_AQ_ICMS: TBCDField;
    Qr_ItensNotaITF_CODTPR: TIntegerField;
    Qr_ItensNotaITF_VL_CUSTO: TFloatField;
    Qr_ItensNotaITD_CODITF_ORIG: TIntegerField;
    Qr_ItensNotaNAT_CFOP: TStringField;
    Qr_ItensNotaPRO_CODIGONCM: TStringField;
    Qr_ItensNotaPRO_ORIGEM: TStringField;
    Qr_ItensNotaITF_IMP_APROX: TBCDField;
    Ds_ItensNota: TDataSource;
    Qr_Nota: TSTQuery;
    Qr_NotaEMP_TIPO: TIntegerField;
    Qr_NotaPED_CODIGO: TIntegerField;
    Qr_NotaNFL_CODIGO: TIntegerField;
    Qr_NotaNFL_CODPED: TIntegerField;
    Qr_NotaPED_CODFPG: TIntegerField;
    Qr_NotaNAT_CODIGO: TIntegerField;
    Qr_NotaNAT_DESCRICAO: TStringField;
    Qr_NotaNAT_CFOP: TStringField;
    Qr_NotaPED_NUMERO: TIntegerField;
    Qr_NotaNFL_NUMERO: TStringField;
    Qr_NotaNFL_VL_TL_NOTA: TBCDField;
    Qr_NotaEMP_CODIGO: TIntegerField;
    Qr_NotaEMP_NOME: TStringField;
    Qr_NotaEMP_CNPJ: TStringField;
    Qr_NotaEND_ENDER: TStringField;
    Qr_NotaEND_BAIRRO: TStringField;
    Qr_NotaEND_CEP: TStringField;
    Qr_NotaEND_FONE: TStringField;
    Qr_NotaEMP_INSC_EST: TStringField;
    Qr_NotaNFL_DT_EMISSAO: TDateField;
    Qr_NotaNFL_DT_SAIDA: TDateField;
    Qr_NotaNFL_BS_ICMS: TBCDField;
    Qr_NotaNFL_VL_ICMS: TBCDField;
    Qr_NotaNFL_BS_ICMS_SUBST: TBCDField;
    Qr_NotaNFL_VL_ICMS_SUBST: TBCDField;
    Qr_NotaNFL_VL_TL_PROD: TBCDField;
    Qr_NotaNFL_VL_FRETE: TBCDField;
    Qr_NotaNFL_VL_SEGURO: TBCDField;
    Qr_NotaNFL_VL_DESP_ACESS: TBCDField;
    Qr_NotaNFL_VL_IPI: TBCDField;
    Qr_NotaNFL_QT_PRODUTO: TBCDField;
    Qr_NotaNFL_ESPECIE: TStringField;
    Qr_NotaNFL_MARCA: TStringField;
    Qr_NotaNFL_PESO_BRUTO: TStringField;
    Qr_NotaNFL_PESO_LIQ: TStringField;
    Qr_NotaCLB_NOME: TStringField;
    Qr_NotaNFL_STATUS: TStringField;
    Qr_NotaNFL_TIPO: TStringField;
    Qr_NotaPED_OBS: TBlobField;
    Qr_NotaNFL_VL_TL_SRV: TBCDField;
    Qr_NotaPED_VL_DESCONTO: TBCDField;
    Qr_NotaPED_DT_ALTERA: TSQLTimeStampField;
    Qr_NotaPED_CODTRP: TIntegerField;
    Qr_NotaNFE_CODSIT: TIntegerField;
    Qr_NotaPED_PRAZO: TStringField;
    Qr_NotaCDD_DESCRICAO: TStringField;
    Qr_NotaUFE_SIGLA: TStringField;
    Qr_NotaPED_TIPO: TIntegerField;
    Qr_NotaNFL_CODMHA: TIntegerField;
    Qr_NotaNFL_CODTRP: TIntegerField;
    Qr_NotaEMP_EMAIL: TStringField;
    Qr_NotaNFL_VOL_NUMERO: TStringField;
    DS_Nota: TDataSource;
    Ds_Obs_Nota: TDataSource;
    Qr_ItensSrv: TSTQuery;
    Qr_ItensSrvITF_CODIGO: TIntegerField;
    Qr_ItensSrvITF_CODPED: TIntegerField;
    Qr_ItensSrvITF_CODNFL: TIntegerField;
    Qr_ItensSrvITF_CODPRO: TIntegerField;
    Qr_ItensSrvPRO_DESCRICAO: TStringField;
    Qr_ItensSrvEMB_ABREVIATURA: TStringField;
    Qr_ItensSrvITF_QTDE: TBCDField;
    Qr_ItensSrvITF_VL_CUSTO: TFloatField;
    Qr_ItensSrvITF_VL_DESC: TBCDField;
    Qr_ItensSrvITF_VL_UNIT: TFloatField;
    Qr_ItensSrvITF_AQ_COM: TBCDField;
    Qr_ItensSrvMED_ABREVIATURA: TStringField;
    Qr_ItensSrvITF_VL_SUBTOTAL: TFloatField;
    Qr_ItensSrvITF_VL_TOTAL: TFloatField;
    Ds_FormaPgto: TDataSource;
    Qr_FPgto: TSTQuery;
    Qr_FPgtoFIN_DATA: TDateField;
    Qr_FPgtoFIN_PRAZO: TStringField;
    Qr_FPgtoFIN_DT_VENCIMENTO: TDateField;
    Qr_FPgtoFIN_NUMERO: TStringField;
    Qr_FPgtoFIN_VL_PARCELA: TBCDField;
    Qr_FPgtoFIN_DT_PAGTO: TDateField;
    Qr_FPgtoFIN_VL_PAGO: TBCDField;
    Qr_FPgtoFIN_DT_BAIXA: TDateField;
    Qr_FPgtoFIN_TIPO: TStringField;
    Qr_FPgtoFIN_OPERACAO: TStringField;
    dst_ItensSrv: TDataSource;
    Pop_Produto: TPopupMenu;
    CadastrodoProduto: TMenuItem;
    RegistraNmerodolote1: TMenuItem;
    Mnu_Operacao: TMainMenu;
    Mnu_Operacao_Tarefas: TMenuItem;
    Itm_CadastroDestinatrio: TMenuItem;
    N1: TMenuItem;
    Itm_Nfe_Operacao: TMenuItem;
    Itm_Nfe_Compl: TMenuItem;
    Itm_Carta_Correcao: TMenuItem;
    N3: TMenuItem;
    Itm_ImprimirPedido: TMenuItem;
    N4: TMenuItem;
    AtualizarosCustos1: TMenuItem;
    CalcularaComisso1: TMenuItem;
    AuditoriaEstoque1: TMenuItem;
    CpiadePedidoNota1: TMenuItem;
    N5: TMenuItem;
    MnuLucratividade: TMenuItem;
    Panel1: TPanel;
    Sb_Sair_0: TSpeedButton;
    Pg_Notas: TPageControl;
    tbs_nota: TTabSheet;
    Pnl_Cliente: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label39: TLabel;
    GroupBox2: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    E_RazaoSocial: TEdit;
    E_Cnpj_CPf: TEdit;
    E_Endereco: TEdit;
    E_Bairro: TEdit;
    E_Cep: TEdit;
    E_Cidade: TEdit;
    E_Fone: TEdit;
    E_Estado: TEdit;
    E_Insc_Est: TEdit;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    E_Dt_Emissao: TEdit;
    E_Dt_Saida: TEdit;
    E_Nr_Nota: TEdit;
    E_Natureza: TEdit;
    E_Vl_Total: TEdit_Setes;
    TabSheet6: TTabSheet;
    Panel4: TPanel;
    tbs_adicional: TTabSheet;
    Panel6: TPanel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label24: TLabel;
    Label34: TLabel;
    Label37: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    E_Obs: TMemo;
    Panel3: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label2: TLabel;
    E_Bs_Icms: TEdit_Setes;
    E_Vl_Icms: TEdit_Setes;
    E_Bs_Icms_St: TEdit_Setes;
    E_Vl_Icms_St: TEdit_Setes;
    E_Vl_frete: TEdit_Setes;
    E_Vl_Seguro: TEdit_Setes;
    E_Vl_Outras: TEdit_Setes;
    E_Vl_IPI: TEdit_Setes;
    E_VL_Produto: TEdit_Setes;
    E_VL_Nota: TEdit_Setes;
    E_Qtde: TEdit_Setes;
    E_Especie: TEdit;
    E_MArca: TEdit;
    E_Numero: TEdit;
    E_PesoBruto: TEdit_Setes;
    E_PesoLiquido: TEdit_Setes;
    E_Vl_Desconto: TEdit_Setes;
    TabSheet1: TTabSheet;
    Panel2: TPanel;
    procedure btnPesquisarClick(Sender: TObject);
    procedure B_SFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DS_NotaStateChange(Sender: TObject);
    procedure tbs_PesquisaShow(Sender: TObject);
    procedure Sb_ServicoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_TecnicoClick(Sender: TObject);
    procedure Itm_ImprimirPedidoClick(Sender: TObject);
    procedure Itm_Nfe_OperacaoClick(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure Itm_CadastroDestinatrioClick(Sender: TObject);
    procedure sb_obs_nfeClick(Sender: TObject);
    procedure Itm_Nfe_ComplClick(Sender: TObject);
    procedure AtualizarosCustos1Click(Sender: TObject);
    procedure CalcularaComisso1Click(Sender: TObject);
    procedure Dbg_FinanceiroDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBG_ProdutosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure Itm_Carta_CorrecaoClick(Sender: TObject);
    procedure Qr_ItensSrvAfterOpen(DataSet: TDataSet);
    procedure CadastrodoProdutoClick(Sender: TObject);
    procedure AuditoriaEstoque1Click(Sender: TObject);
    procedure RegistraNmerodolote1Click(Sender: TObject);
    procedure Qr_ItensNotaAfterOpen(DataSet: TDataSet);
    procedure Qr_NotaAfterOpen(DataSet: TDataSet);
    procedure Tbs_ServicoShow(Sender: TObject);
    procedure CpiadePedidoNota1Click(Sender: TObject);
    procedure MnuLucratividadeClick(Sender: TObject);


  private
    { Private declarations }
     It_Supervisor : Boolean;
    procedure LucratividadePedidoFechado;
    procedure LucratividadeNotaFiscal;

  public
    It_Tipo_Nota : String;
    It_Oper_Reg : String;
    It_Cd_Nota : Integer;
    It_Nr_Nota : String;
    It_cd_Pedido : Integer;
    It_Nfe_Cancelada : Boolean;

    IT_Cd_Empresa : Integer;
    //controle de menu;
    function Fc_ValidaexistenciaNota():Boolean;
    procedure Pc_AtivarTabelas;
    procedure Pc_BuscaNota;
    procedure Pc_BuscaUnitulizada;
    procedure Pc_Visualizar;

    procedure Pc_Soma;



    Procedure Pc_EstornaCustoCompra;
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_ImpNCupom;

    procedure Pc_MontaMenuOperacao;
    procedure Pc_PermissaoBotao(Pc_Menu: string);

    Function  Fc_ValidaGeracaoNotaFiscalEletronica():Boolean;
    function Fc_GerarNotaFiscalEletronica():Boolean;

    function Fc_ValidaAberturaCartaCorrecao():boolean;
    procedure Pc_ImagemBotao;
    procedure Pc_ConectaBanco;
  end;

var
  Fr_NF_55: TFr_NF_55;

implementation

uses
Un_DM, UN_MSG, UN_OrdemServico, UN_Sistema, Un_Clta_Csto, Un_RL_PedidoAjuste, Un_Fich_Fin_Cli, Un_Tecnicos, Un_RL_Servico, Un_Fc_Sored_Procedures, UN_DetalheOrdem, Un_RL_PedidoCompra_1, Un_RL_PedidoCompra_2, Un_RL_PedidoCompra_3, un_Obs_nfe, Un_Nfe_Complementar, Un_Funcoes, Un_Imp_Mod_Impressao, Un_Fc_Comissao, Un_Regra_Negocio, Un_Produtos, RN_Permissao, UN_Principal, env, RN_Inventario, RN_Estoque, Un_Ctrl_Lote_Entrada, Un_Ctrl_Lote_Saida, Un_CopiaPedidoNota, Un_Parcelamento, RN_NotaFiscalEletronica3X, RN_Cliente, RN_Empresa, RN_NotaFiscal, UN_TabelasEmListas, un_RL_ReportLucratividadeNotaFiscal, un_RL_ReportLucratividadePedidoFechado, prmLucratividade;

{$R *.dfm}



procedure TFr_NF_55.Pc_FormataTela;
Var
  Lc_X:Integer;
Begin
  For Lc_X:=1 to PG_Notas.PageCount do PG_Notas.Pages[Lc_x-1].TabVisible:=False;
  PG_Notas.ActivePageIndex := 1;
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Height := 738 - 15;
  Tbs_Servico.TabVisible := (Fc_Tb_Geral('L','OSR_G_ATIVAR','S') = 'S');
  Tbs_Devolucao.TabVisible := (Fc_Tb_Geral('L','GRL_G_TAR_DEVOLUCAO','S') = 'S');
  Tbs_Conserto.TabVisible := (Fc_Tb_Geral('L','GRL_G_TAR_CONSERTO','S') = 'S');
  PG_Itens.ActivePage := Tbs_Produto;
  //Quando tela de Venda desativa o tipo de opera��o pois ser� sempre saida
  if (It_Tipo_Nota = '(PED_TIPO = ''1'')') then
  Begin
    RG_Tipo_S_E.ItemIndex := 0;
    RG_Tipo_S_E.Enabled := False;
    MnuLucratividade.Visible := True;
  end
  else
  Begin
    MnuLucratividade.Visible := False;
    //Quando tela de Compra desativa o tipo de opera��o pois ser� sempre Entrada
    if (It_Tipo_Nota = '(PED_TIPO = ''2'')') then
    Begin
      RG_Tipo_S_E.ItemIndex := 1;
      RG_Tipo_S_E.Enabled := False;
    end;
  end;
end;






function TFr_NF_55.Fc_ValidaexistenciaNota():Boolean;
Begin
  Result := true;
  if not Fc_GerarNotaFiscalEletronica then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Para continuar � preciso um cliente diferente de consumidor.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
    end;

  if (Trim(Qr_NotaNFL_NUMERO.AsString) = '') AND  (Qr_NotaNFL_DT_EMISSAO.AsDateTime < StrToDate('30/10/2014'))then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'N�mero da Nota n�o encontrado.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
    end;
end;


procedure TFr_NF_55.btnPesquisarClick(Sender: TObject);
begin
  PG_Notas.ActivePageIndex := 0;

end;

procedure TFr_NF_55.B_SFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_NF_55.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(Fr_Clta_Csto) OR Assigned(Fr_Fich_Fin_Cli) then
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining
  else
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.Commit;
end;



Procedure TFr_NF_55.Pc_EstornaCustoCompra;
Var
  Lc_Qry : TSTQuery;
Begin
  if (Qr_NotaPED_TIPO.AsInteger = 2) then
    Begin
    Lc_Qry := TSTQuery.Create(nil);
    with Lc_Qry do
      Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      ForcedRefresh := True;
      SQL.Clear;
      SQL.Add('UPDATE TB_PRODUTO SET '+
              'PRO_VL_CUSTO =PRO_VL_CUSTOANT, '+
              'PRO_VL_CUSTOMED = PRO_VL_CUSTOMEDANT '+
              'WHERE (PRO_CODIGO   =:PRO_CODIGO) ');

      Qr_ItensNota.Active := True;
      Qr_ItensNota.First;
      while not Qr_ItensNota.Eof do
        Begin
        Active := False;
        Transaction := DM.IB_Transacao;
        ParamByName('PRO_CODIGO').AsInteger := Qr_ItensNota.FieldByName('ITF_CODPRO').AsInteger;
        ExecSQL;
        IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
        Qr_ItensNota.Next;
        end;
      end;
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
    end;
end;

procedure TFr_NF_55.Pc_BuscaUnitulizada;
var
  Lc_SqlTxt:string;
begin
  Lc_SqlTxt := '';
  Screen.Cursor := crHourGlass;
  Qr_Inutilizada.Close;
  Qr_Inutilizada.Sql.Clear;
  Lc_SqlTxt := 'SELECT * '+
               ' FROM TB_RETORNO_NFE '+
               ' WHERE NFE_CODSIT = 5 ' ;

  if not Grb_MnhaEmpresa.Visible then
    Begin
    Lc_Sqltxt := Lc_Sqltxt + ' AND (NFE_CODMHA =:NFE_CODMHA) ';
    end
  else
    Begin
    if not chbx_Empresas.Checked then
      Lc_Sqltxt := Lc_Sqltxt + ' AND (NFE_CODMHA =:NFE_CODMHA) ';
    end;

  Qr_Inutilizada.SQL.Add(Lc_SqlTxt);
  if not Grb_MnhaEmpresa.Visible then
    Begin
    Qr_Inutilizada.ParamByName('NFE_CODMHA').AsInteger := Gb_CodMha;
    end
  else
    Begin
    if not chbx_Empresas.Checked then
      Qr_Inutilizada.ParamByName('NFE_CODMHA').AsInteger := Dblcb_Mha_Empresa.KeyValue;
    end;


  Qr_Inutilizada.Open;
  Screen.Cursor:=crDefault;

end;

procedure TFr_NF_55.Pc_BuscaNota;
var
  Lc_SqlTxt:string;
  Lc_NotaFiscal, Lc_Pedido, Lc_Empresa, Lc_Cd_Empresa, Lc_Natureza : Boolean;
begin
  Lc_SqlTxt := '';
  Screen.Cursor := crHourGlass;

  Qr_Pesquisa.Close;
  Qr_Pesquisa.Sql.Clear;
  Lc_SqlTxt := 'SELECT NFL_CODIGO, PED_NUMERO, NFL_NUMERO, NFL_DT_EMISSAO, EMP_FANTASIA, EMP_NOME, '+
             'NFL_VL_TL_NOTA, NAT_DESCRICAO, EMP_CODIGO '+
             'FROM TB_NOTA_FISCAL Tb_nota_fiscal '+
             '  INNER JOIN TB_EMPRESA tb_empresa '+
             '  ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
             '  INNER JOIN TB_PEDIDO tb_pedido '+
             '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
             '  INNER JOIN TB_NATUREZA tb_natureza '+
             '  ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT) ';
  IF (Rg_Sit_Nfe.ItemIndex < 6) then
  BEgin
    IF (Rg_Sit_Nfe.ItemIndex > 0) then
    BEgin
      Lc_SqlTxt := Lc_SqlTxt +
               '  INNER JOIN TB_RETORNO_NFE tb_retorno_nfe '+
               '  ON (tb_retorno_nfe.NFE_CODNFL = tb_nota_fiscal.NFL_CODIGO) ';
    end
    else
    BEgin
      Lc_SqlTxt := Lc_SqlTxt +
               '  LEFT OUTER JOIN TB_RETORNO_NFE tb_retorno_nfe '+
               '  ON (tb_retorno_nfe.NFE_CODNFL = tb_nota_fiscal.NFL_CODIGO) ';
    end;
  end;
  Lc_SqlTxt := Lc_SqlTxt +
               'WHERE (NFL_CODIGO IS NOT NULL) AND ((NFL_MODELO <> ''65'') OR (NFL_MODELO is null) ) AND '+It_Tipo_Nota     ;

  if not Grb_MnhaEmpresa.Visible then
    Begin
    Lc_Sqltxt := Lc_Sqltxt + ' AND (NFL_CODMHA =:NFL_CODMHA) ';
    end
  else
    Begin
    if not chbx_Empresas.Checked then
      Lc_Sqltxt := Lc_Sqltxt + ' AND (NFL_CODMHA =:NFL_CODMHA) ';
    end;

  if E_NumNota.Text = '' then Lc_NotaFiscal := False else Lc_NotaFiscal := True;
  if E_CodPedido.Text = '' then Lc_Pedido := False else Lc_Pedido := True;
  if E_Busca_Cd_Empresa.text = '' then Lc_cd_Empresa := False else Lc_Cd_Empresa := True;
  if E_Busca_Empresa.text = '' then Lc_Empresa := False else Lc_Empresa := True;
  if DBLCB_Natureza.KeyValue <= 0 then Lc_Natureza := False else Lc_Natureza := True;


  if Lc_NotaFiscal then
    Begin
    Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_NUMERO = :NFL_NUMERO) ';
    end
  else
    Begin
    if Lc_Pedido then
      Begin
      Rg_Sit_Nfe.ItemIndex := 6;
      Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_NUMERO = :PED_NUMERO) ';
      end
    else
      BEgin
      case Rg_Sit_Nfe.ItemIndex of
        0:Lc_SqlTxt := Lc_SqlTxt + 'AND ((NFE_CODSIT = :NFE_CODSIT) OR (NFE_CODSIT IS NULL))';
        1:Lc_SqlTxt := Lc_SqlTxt + 'AND ( NFE_CODSIT = :NFE_CODSIT) ';
        2:Lc_SqlTxt := Lc_SqlTxt + 'AND ( NFE_CODSIT = :NFE_CODSIT) ';
        3:Lc_SqlTxt := Lc_SqlTxt + 'AND ( NFE_CODSIT = :NFE_CODSIT)';
        5:Lc_SqlTxt := Lc_SqlTxt + 'AND ( NFE_CODSIT = :NFE_CODSIT) ';
      end;

      if ChBx_Periodo.Checked then
        Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_DT_EMISSAO BETWEEN :NFL_DATAINICIO AND :NFL_DATAFIM) ';
      if Lc_Natureza then Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_CODNAT = :NFL_CODNAT) ';
      IF RG_Tipo_S_E.ItemIndex = 0 THEN
        Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_TIPO LIKE ''%S%'') '
      else
        Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_TIPO LIKE ''%E%'') ';

      if Lc_cd_Empresa then
        Begin
        Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_CODEMP =:NFL_CODEMP) '
        end;
                
      if Lc_Empresa then
        Begin
        if ChBx_Nome.Checked then
           Lc_SqlTxt := Lc_SqlTxt + 'AND (EMP_NOME LIKE :EMP_FANTASIA) '
        else
           Lc_SqlTxt := Lc_SqlTxt + 'AND (EMP_FANTASIA LIKE :EMP_FANTASIA) ';
        end;
      end;
    end;
  Qr_Pesquisa.SQL.Add(Lc_Sqltxt + ' ORDER BY EMP_FANTASIA');

  if not Grb_MnhaEmpresa.Visible then
    Begin
    Qr_Pesquisa.ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    end
  else
    Begin
    if not chbx_Empresas.Checked then
      Qr_Pesquisa.ParamByName('NFL_CODMHA').AsInteger := Dblcb_Mha_Empresa.KeyValue;
    end;

  if Lc_NotaFiscal then
    Begin
    qr_Pesquisa.ParamByName('NFL_NUMERO').AsString:=StrZero(StrToIntDEf(E_NumNota.Text,0),6,0);
    end
  else
    Begin
    if Lc_Pedido then
      Begin
      qr_Pesquisa.ParamByName('PED_NUMERO').AsInteger:=StrToIntDef(E_CodPedido.Text,0);
      end
    else
      Begin
      case Rg_Sit_Nfe.ItemIndex of
        0:Begin
          Qr_Pesquisa.ParamByName('NFE_CODSIT').AsInteger := 0;
          end;
        1:Qr_Pesquisa.ParamByName('NFE_CODSIT').AsInteger := 0;
        2:Qr_Pesquisa.ParamByName('NFE_CODSIT').AsInteger := 0;
        3:Qr_Pesquisa.ParamByName('NFE_CODSIT').AsInteger := 0;
      end;

      if (Rg_Sit_Nfe.ItemIndex < 6) then
        Qr_Pesquisa.ParamByName('NFE_CODSIT').AsInteger := Rg_Sit_Nfe.ItemIndex;

      if ChBx_Periodo.Checked then
        Begin
        Qr_Pesquisa.ParamByName('NFL_DATAINICIO').AsDate:=E_Data_Ini.Date;
        qr_Pesquisa.ParamByName('NFL_DATAFIM').AsDate:=E_Data_Fim.Date;
        end;
      if Lc_CD_Empresa then qr_Pesquisa.ParamByName('NFL_CODEMP').AsString := E_Busca_Cd_Empresa.Text;
      if Lc_Empresa then qr_Pesquisa.ParamByName('EMP_FANTASIA').AsString := '%'+E_Busca_Empresa.Text+'%';
      if Lc_Natureza then qr_Pesquisa.ParamByName('NFL_CODNAT').AsInteger:=DBLCB_Natureza.KeyValue;
      end;
    end;

  qr_Pesquisa.active := True;
  (Qr_Pesquisa.FieldByName('NFL_VL_TL_NOTA') as TNumericField).DisplayFormat  := '0.00##';
  Screen.Cursor:=crDefault;
end;


procedure TFr_NF_55.Pc_Soma;
var
  Lc_Sqltxt :string;
  Lc_NotaFiscal, Lc_Pedido, Lc_Empresa, Lc_Natureza : Boolean;
begin
  Lc_Sqltxt :='';
  E_TotalVenda.Caption:='';
  Screen.Cursor := crHourGlass;
  Qr_Acao.Close;
  Qr_Acao.Sql.Clear;
  Lc_SqlTxt := 'SELECT SUM(NFL_VL_TL_NOTA) NFL_SOMA '+
             'FROM TB_NOTA_FISCAL Tb_nota_fiscal '+
             '  INNER JOIN TB_EMPRESA tb_empresa '+
             '  ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
             '  INNER JOIN TB_PEDIDO tb_pedido '+
             '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
             '  INNER JOIN TB_NATUREZA tb_natureza '+
             '  ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT) ';
  IF (Rg_Sit_Nfe.ItemIndex < 6) then
    BEgin
    IF (Rg_Sit_Nfe.ItemIndex > 0) then
      BEgin
      Lc_SqlTxt := Lc_SqlTxt +
               '  INNER JOIN TB_RETORNO_NFE tb_retorno_nfe '+
               '  ON (tb_retorno_nfe.NFE_CODNFL = tb_nota_fiscal.NFL_CODIGO) ';
      end
    else
      BEgin
      Lc_SqlTxt := Lc_SqlTxt +
               '  LEFT OUTER JOIN TB_RETORNO_NFE tb_retorno_nfe '+
               '  ON (tb_retorno_nfe.NFE_CODNFL = tb_nota_fiscal.NFL_CODIGO) ';
      end;
    end;
  Lc_SqlTxt := Lc_SqlTxt +
               'WHERE (NFL_CODIGO IS NOT NULL) AND ((NFL_MODELO <> ''65'') OR (NFL_MODELO is null) ) AND '+It_Tipo_Nota     ;

  if not Grb_MnhaEmpresa.Visible then
    Begin
    Lc_Sqltxt := Lc_Sqltxt + ' AND (NFL_CODMHA =:NFL_CODMHA) ';
    end
  else
    Begin
    if not chbx_Empresas.Checked then
      Lc_Sqltxt := Lc_Sqltxt + ' AND (NFL_CODMHA =:NFL_CODMHA) ';
    end;


  if E_NumNota.Text = '' then Lc_NotaFiscal := False else Lc_NotaFiscal := True;
  if E_CodPedido.Text = '' then Lc_Pedido := False else Lc_Pedido := True;
  if E_Busca_Empresa.text = '' then Lc_Empresa := False else Lc_Empresa := True;
  if DBLCB_Natureza.KeyValue <= 0 then Lc_Natureza := False else Lc_Natureza := True;

  if Lc_NotaFiscal then
    Begin
    Lc_Sqltxt := Lc_Sqltxt + 'AND (NFL_NUMERO = :NFL_NUMERO) ';
    end
  else
    Begin
    if Lc_Pedido then
      Begin
      Lc_Sqltxt := Lc_Sqltxt + 'AND (PED_NUMERO = :PED_NUMERO) ';
      end
    else
      Begin
      if ChBx_Periodo.Checked then
        Lc_Sqltxt := Lc_Sqltxt + 'AND (NFL_DT_EMISSAO BETWEEN :NFL_DATAINICIO AND :NFL_DATAFIM) ';
      if Lc_Natureza then Lc_Sqltxt := Lc_Sqltxt + 'AND (NFL_CODNAT = :NFL_CODNAT) ';
      IF RG_Tipo_S_E.ItemIndex = 0 THEN
        Lc_Sqltxt := Lc_Sqltxt + 'AND (NFL_TIPO LIKE ''%S%'') '
      else
        Lc_Sqltxt := Lc_Sqltxt + 'AND (NFL_TIPO LIKE ''%E%'') ';
      if Lc_Empresa then
        Begin
        if ChBx_Nome.Checked then
           Lc_Sqltxt := Lc_Sqltxt + 'AND (EMP_NOME LIKE :EMP_FANTASIA) '
        else
           Lc_Sqltxt := Lc_Sqltxt + 'AND (EMP_FANTASIA LIKE :EMP_FANTASIA) ';
        end;
      end;
    end;
     case Rg_Sit_Nfe.ItemIndex of
        0:Lc_Sqltxt := Lc_Sqltxt + 'AND ((NFE_CODSIT = :NFE_CODSIT) OR (NFE_CODSIT IS NULL))';
        1:Lc_Sqltxt := Lc_Sqltxt + 'AND (NFE_CODSIT = :NFE_CODSIT)  ';
        2:Lc_Sqltxt := Lc_Sqltxt + 'AND (NFE_CODSIT = :NFE_CODSIT)  ';
        3:Lc_Sqltxt := Lc_Sqltxt + 'AND ( NFE_CODSIT = :NFE_CODSIT) ';
        4:Lc_Sqltxt := Lc_Sqltxt + 'AND ( NFE_CODSIT = :NFE_CODSIT) ';
        5:Lc_Sqltxt := Lc_Sqltxt + 'AND ( NFE_CODSIT = :NFE_CODSIT) ';
      end;

//  Sqltxt := Sqltxt + ' group by 2,3 ';
  Qr_Acao.SQL.Add(Lc_Sqltxt);
  if not Grb_MnhaEmpresa.Visible then
    Begin
    Qr_Acao.ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    end
  else
    Begin
    if not chbx_Empresas.Checked then
      Qr_Acao.ParamByName('NFL_CODMHA').AsInteger := Dblcb_Mha_Empresa.KeyValue;
    end;
  if Lc_NotaFiscal then
    Begin
    Qr_Acao.ParamByName('NFL_NUMERO').AsString:=(E_NumNota.Text);
    end
  else
    Begin
    if Lc_Pedido then
      Begin
      Qr_Acao.ParamByName('PED_NUMERO').AsInteger:=StrToIntDEf(E_CodPedido.Text,0);
      end
    else
      BEgin
      if ChBx_Periodo.Checked then
        Begin
        Qr_Acao.ParamByName('NFL_DATAINICIO').AsDate:=E_Data_Ini.Date;
        Qr_Acao.ParamByName('NFL_DATAFIM').AsDate:=E_Data_Fim.Date;
        end;
      if Lc_Empresa then Qr_Acao.ParamByName('EMP_FANTASIA').AsString:='%'+E_Busca_Empresa.Text+'%';
      if Lc_Natureza then Qr_Acao.ParamByName('NFL_CODNAT').Value:=DBLCB_Natureza.KeyValue;
      end;
    end;

    if (Rg_Sit_Nfe.ItemIndex < 6) then
      Qr_Acao.ParamByName('NFE_CODSIT').AsInteger := Rg_Sit_Nfe.ItemIndex;

  Qr_Acao.Open;
  E_TotalVenda.Caption := FloatToStrF(Qr_Acao.fieldbyname('NFL_SOMA').AsFloat,ffNumber,10,2);
  Screen.Cursor:=crDefault;
end;

procedure TFr_NF_55.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_NF_55.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_NF_55.Pc_Visualizar;
begin
  if Qr_Pesquisa.RecordCount > 0 then
    begin
    Qr_Nota.Active:=FALSE;
    Qr_Conserto.Active:=FALSE;
    It_Cd_Nota := Qr_Pesquisa.FieldByName('NFL_CODIGO').AsInteger;
    Qr_Nota.ParamByName('NFL_CODIGO').AsInteger:=It_Cd_Nota;
    Pc_AtivarTabelas;
    PG_Notas.Pages[1].TabVisible := False;
    PG_Notas.ActivePageIndex := 0;
    PG_Totalizador.ActivePageIndex := 0;
    if (Qr_Conserto.RecordCount>0) then
      Begin
      PG_Itens.ActivePage:= Tbs_Conserto;
      end;
    end;
end;

procedure TFr_NF_55.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case PG_Notas.ActivePageIndex of
  0:begin
    if shift = [] then
      begin
        case Key of
        VK_F7  : if SB_Pesquisar.Enabled then SB_PesquisarClick(Sender);
        VK_Escape : if  Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
        end;
      end;
    end;
  else
    begin
    if shift = [] then
      begin
      case Key of
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_F8 : if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
      VK_Escape : if  Sb_Sair_1.Enabled then Sb_Sair_1Click(Sender);
      end;
      end;
    end;
  end;
end;

procedure TFr_NF_55.Pc_AtivarTabelas;
begin
  Qr_Nota.Active      := True;
end;

procedure TFr_NF_55.DS_NotaStateChange(Sender: TObject);
begin
  Sb_Servico.Enabled := (It_Tipo_Nota = '(PED_TIPO = ''1'')') ;
end;

procedure TFr_NF_55.Pc_ConectaBanco;
Begin

end;

procedure TFr_NF_55.tbs_PesquisaShow(Sender: TObject);
begin
  DM.Qr_Natureza.Active := True;
  Mnu_Operacao_Tarefas.Visible := False;
end;

procedure TFr_NF_55.Sb_ServicoClick(Sender: TObject);
Var
  Lc_Form : TFr_VehicleSo;
begin
  Lc_Form := TFr_VehicleSo.Create(nil);
  TRy
    with Lc_Form do
    begin
      with OrdemServico do
      Begin
        Registro.CodigoEstabelecimento := Gb_Codmha;
        Registro.CodigoCotacao := 0;
        Registro.CodigoPedido := Qr_Nota.FieldByname('PED_CODIGO').AsInteger;
        with Vehicle do
        Begin
          Registro.CodigoEmpresa := Qr_Nota.FieldByname('EMP_CODIGO').AsInteger;
        End;
      End;
      ShowModal;
    End;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_NF_55.Pc_IniciaVariaveis;
Begin
  E_Data_Ini.Date := date;
  E_Data_Fim.date :=date;

  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  if It_Tipo_Nota = '(PED_TIPO = ''1'')' then
  Begin
    Fr_Nota_Fiscal.Caption:= 'Manuten��o - Notas Fiscais de Vendas';
    It_Supervisor := Fc_VerificaPermissao('Fr_Nota_Fiscal','Notas Fiscais de Venda','SUPERVISOR',GB_Cd_Usuario,'N');
  end;
  if It_Tipo_Nota = '(PED_TIPO = ''2'')' then
  Begin
    Fr_Nota_Fiscal.Caption:= 'Manuten��o - Notas Fiscais de Compras';
    It_Supervisor := Fc_VerificaPermissao('Fr_Nota_Fiscal','Notas Fiscais de Compra','SUPERVISOR',GB_Cd_Usuario,'N');
  end;
  if It_Tipo_Nota = '(PED_TIPO = ''3'')' then
  Begin
    Fr_Nota_Fiscal.Caption:= 'Manuten��o - Notas Fiscais de Ajustes';
    It_Supervisor := Fc_VerificaPermissao('Fr_Nota_Fiscal','Notas Fiscais de Ajuste','SUPERVISOR',GB_Cd_Usuario,'N');
  end;
  if It_Tipo_Nota = '(PED_TIPO = ''4'')' then
  Begin
    Fr_Nota_Fiscal.Caption:= 'Manuten��o - Notas Fiscais de Vendas pela Internet';
    It_Supervisor := Fc_VerificaPermissao('Fr_Nota_Fiscal','Notas Fiscais de Venda','SUPERVISOR',GB_Cd_Usuario,'N');
  end;
  if It_Cd_Nota > 0 then
  Begin
    Sb_Pesquisar.Visible := False;
    Qr_Nota.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
    Pc_AtivarTabelas;
    if (Qr_NotaNFL_CODMHA.AsInteger <> Gb_CodMha) then
      Pc_DefineEmpresaAtiva(Qr_NotaNFL_CODMHA.AsInteger);
    PG_Notas.Pages[1].TabVisible := False;
    if (Qr_Conserto.RecordCount>0) then
    Begin
      PG_Itens.ActivePage:= Tbs_Conserto;
    end;
    PG_Notas.ActivePageIndex := 0;
    PG_Totalizador.ActivePageIndex := 0;
  end
  else
  Begin
    PG_Notas.ActivePageIndex:=1;
  end;

  if It_Supervisor then
  BEgin
    Lb_TotalVendas.Visible := True;
    E_TotalVenda.Visible := True;
  end
  else
  Begin
    Lb_TotalVendas.Visible := False;
    E_TotalVenda.Visible := False;
  end;
end;

procedure TFr_NF_55.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_ImagemBotao;
  Pc_IniciaVariaveis;
end;

procedure TFr_NF_55.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    Sb_Pesquisar.Glyph.Assign(Fc_CarregaImagemBotao('PESQUISAR'));
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    SB_Buscar.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    SB_Visualizar.Glyph.Assign(Fc_CarregaImagemBotao('VISUALIZAR'));
    SB_Sair_1.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_NF_55.Sb_TecnicoClick(Sender: TObject);
begin
  if not Assigned(Fr_Tecnicos) then Application.CreateForm(TFr_Tecnicos, Fr_Tecnicos);
  with Fr_Tecnicos do
    Begin
    It_Cd_Pedido := Qr_Nota.FieldByname('PED_CODIGO').AsInteger;
    It_Cd_Item := Qr_ItensSrv.FieldByname('ITF_CODIGO').AsInteger;
    if (Gb_Nivel = 0) then
      Begin
      Fr_Tecnicos.Height := 288;
      StrGrd_Tecnico.Enabled := False;
      end;
    ShowModal;
    end
end;

procedure TFr_NF_55.Pc_ImpNCupom;
var
  subtotal, total: currency;
  linha: integer;
  traco: string;
  Lc_Forma: Real;
begin
  total := 0;
  Lc_Forma := Qr_Nota.FieldByName('NFL_VL_TL_NOTA').AsCurrency;
  Traco := '-------------------------------------------------------';
  (*rdprint1.TamanhoQteLinhas := 1; // Linhas (deve ser 1 quando for CUPOM)
  rdprint1.TamanhoQteColunas := 55; // Largura da Bobina aprox. 7 cm (7 / 2.54 * 20)
  rdprint1.FonteTamanhoPadrao := s20cpp; // Fonte Comprimido em 20 cpp
  RDprint1.Acentuacao := Transliterate;
  rdprint1.OpcoesPreview.Preview := false;

     // Cabe�alho do Cupom...
  with rdprint1 do
    begin
      try
      abrir;

      DM.Qr_MhaEmpresa.Active := True;
      DM.Qr_MhaEmpresa.First;
{
      Qr_Pedido.Active := False;
      Qr_Pedido.ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
      Qr_Pedido.Active := True;
      Qr_Pedido.FetchAll;
      Qr_Pedido.First;

      if Qr_Pedido.RecordCount > 0 then
        begin
        DM.Qr_Endereco.Active := False;
        DM.Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := Qr_PedidoPED_CODEMP.AsInteger;
        DM.Qr_Endereco.Active := true;
        end;
}
      impc(01, 28, DM.Qr_MhaEmpresaEMP_FANTASIA.AsString, [Comp12]);
      impc(02, 28, DM.Qr_MhaEmpresaEMP_NOME.AsString, [Comp12]);
      impc(03, 28, DM.Qr_MhaEmpresaEND_ENDER.AsString, [Comp12]);
      impc(04, 28, DM.Qr_MhaEmpresaEND_CEP.AsString + ' - ' + DM.Qr_MhaEmpresaCDD_DESCRICAO.AsString + ' - ' + DM.Qr_MhaEmpresaUFE_SIGLA.AsString, [Comp12]);
      impc(05, 28, DM.Qr_MhaEmpresaEND_FONE.AsString, [Comp12]);
      imp(06, 01, 'N� ' + Qr_Nota.FieldByName('PED_NUMERO').AsString + '   ' + Qr_Nota.FieldByName('NFL_DT_EMISSAO').AsString);
      imp(07, 01, traco);
      imp(08, 01, 'Descri�ao dos Produtos         Unit�rio  Qte  Sub-Total');
      imp(09, 01, traco);
      Except
      fechar;
      end;
    end;

     // Imprime itens do pedido...
  linha := 10;
{  Qr_ItensNota.Active := False;
  Qr_Itens.ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
  Qr_Itens.Active := True;
  Qr_Itens.FetchAll;
  Qr_Itens.First;}
  while not Qr_ItensNota.eof do
  begin
    with rdprint1 do
    begin
      impf(linha, 01, Copy(Qr_ItensNota.FieldByName('PRO_DESCRICAO').AsString, 1, 31), []);
      impval(linha, 35, '#,##0.00', Qr_ItensNota.FieldByName('ITF_VL_UNIT').Value, []);
      impval(linha, 42, '###0', Qr_ItensNota.FieldByName('ITF_QTDE').Value, []);
      subtotal := Qr_ItensNota.FieldByName('ITF_QTDE').Value * Qr_ItensNota.FieldByName('ITF_VL_UNIT').Value;
      total := total + subtotal;
      impval(linha, 47, '##,##0.00', subtotal, []);
      inc(linha);
    end;
    Qr_ItensNota.Next;
  end;

  with rdprint1 do
  begin
        // Total...
    imp(linha, 01, traco);
    inc(linha);
    imp(linha, 01, 'Total Geral do Cupom');
    impval(linha, 42, '###,###,##0.00', total, []);
        // Desconto Global
    if Qr_Nota.FieldByName('PED_VL_DESCONTO').AsCurrency > 0 then
    begin
      inc(linha);
      imp(linha, 01, '(-) Desconto Global');
      impval(linha, 42, '-##,###,##0.00', StrToFloatDef(Qr_Nota.FieldByName('PED_VL_DESCONTO').Text, 0), []);
          // Total Liquido...
      inc(linha);
      impf(linha, 01, 'VALOR A PAGAR R$', []);
      impval(linha, 42, '###,###,##0.00', StrToFloatDef(Qr_Nota.FieldByName('NFL_VL_TL_NOTA').Text, 0), []);
    end;

    if (Qr_Nota.FieldByName('NFL_VL_TL_NOTA').Text <> '0,00') then
    begin
      inc(linha);
      impf(linha, 01, 'VALOR RECEBIDO R$ ', []);
      impval(linha, 42, '###,###,##0.00', Lc_Forma, []);

      inc(linha);
      impf(linha, 01, 'VALOR DO TROCO R$ ', []);
      impval(linha, 42, '###,###,##0.00', StrToFloatDef('0', 0), []);
    end;

    linha := linha + 3;
    inc(linha);
    impc(linha, 28, '***  SEM VALOR FISCAL  ***', []);
    linha := linha + StrToIntDef(Fc_Aq_Geral('L', 'IMPRESSORA', 'SALTO', '0'), 1);
    imp(linha, 01, ' ');

    rdprint1.OpcoesPreview.Preview := False;
    rdprint1.TamanhoQteLinhas := linha;

    RDprint1.Impressora := Grafico;
    fechar;
  end;
  rdprint1.OpcoesPreview.Preview := false;
  rdprint1.TamanhoQteLinhas := 1;
  *)
end;





procedure TFr_NF_55.Pc_MontaMenuOperacao;
Begin
  Mnu_Operacao_Tarefas.Visible := True;
   if It_Tipo_Nota = '(PED_TIPO = ''1'')' then
     Pc_PermissaoBotao('Notas Fiscais de Venda')
   else
    if It_Tipo_Nota = '(PED_TIPO = ''2'')' then
     Pc_PermissaoBotao('Notas Fiscais de Compra')
   else
    if It_Tipo_Nota = '(PED_TIPO = ''3'')' then
     Pc_PermissaoBotao('Notas Fiscais de Ajuste');

  IF (It_Tipo_Nota = '(PED_TIPO = ''2'')') then
  Begin;
    if (Fc_Tb_Geral('L','CPA_G_OPER_COMPRA_NFE','S') = 'N') then
    Begin
      Itm_Nfe_Compl.Visible           := False;
      Itm_Carta_Correcao.Visible      := False;
    end;
  end;
end;

procedure TFr_NF_55.Itm_ImprimirPedidoClick(Sender: TObject);
Var
  Lc_Imp: TimpModImpressao;
begin
  Try
    Lc_Imp := TimpModImpressao.create(nil);
    Lc_Imp.Pc_Inicializa;
    Self.Enabled := False;
    if Fc_VerificaPermissao('Fr_Nota_Fiscal','Imprimir Nora Fiscal','IMPRIMIR',GB_Cd_Usuario,'S') then
      Begin
      Lc_Imp.Pc_Imp_Tipo(Qr_NotaPED_TIPO.AsInteger,Qr_NotaPED_CODIGO.AsInteger,Qr_NotaNFL_CODIGO.AsInteger);
      end;
  Finally
    Lc_Imp.Pc_Finaliza;
    Self.Enabled := True;
  end;
end;

procedure TFr_NF_55.Itm_Nfe_OperacaoClick(Sender: TObject);
begin
  Fc_ChamarGeraNFE3X('NF-e',
                     Qr_Nota.FieldByName('PED_CODIGO').AsInteger,
                     Qr_Nota.FieldByName('NFL_CODIGO').AsInteger,
                     Qr_Nota.FieldByName('NFL_NUMERO').AsString,
                     Qr_Nota.FieldByName('EMP_CODIGO').AsInteger,
                     StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0));
  Qr_Nota.Active := False;
  Qr_Nota.Active := True;
  Qr_Nota.FetchAll;
  if Qr_Nota.RecordCount = 0 then
  Begin
    SB_BuscarClick(Self)
  end;
end;

procedure TFr_NF_55.LucratividadeNotaFiscal;
Var
  Lc_Form : TRL_ReportLucratividadeNotaFiscal;
  Lc_Param : TParamLucratividade.Create;
begin
  Try
    Lc_Form := TRL_ReportLucratividadeNotaFiscal.create(nil);
    Lc_Param := TParamLucratividade.Create;
    Lc_Form.Periodo := False;
    Lc_Form.Numero := Qr_NotaNFL_NUMERO.AsString;
    Lc_Form.Parametros := Lc_Param;
    Lc_Form.Qrpt.ReportTitle := 'LUCRATIVIDADE - NOTA FISCAL';
    Lc_Form.Qrpt.Preview;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_NF_55.LucratividadePedidoFechado;
Var
  Lc_Form : TRL_ReportLucratividadePedidoFEchado;
  Lc_Param : TParamLucratividade.Create;
begin
  Try
    Lc_Form := TRL_ReportLucratividadePedidoFEchado.create(nil);
    Lc_Param := TParamLucratividade.Create;
    Lc_Param.Perido := False;
    Lc_Param.Numero := Qr_NotaPED_NUMERO.AsString;
    Lc_Form.Parametros := Lc_Param;
    Lc_Form.Qrpt.ReportTitle := 'LUCRATIVIDADE - PEDIDO FECHADO';
    Lc_Form.Qrpt.Preview;
  Finally
    FreeAndNil(Lc_Form);
  End;


end;

procedure TFr_NF_55.TabSheet1Show(Sender: TObject);
begin
  Qr_FPgto.Active     := True;
end;

procedure TFr_NF_55.Itm_CadastroDestinatrioClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Cadastro do Destinat�rio','CADASTRO DESTINATARIO',GB_Cd_Usuario,'S') then
  Begin
    Fc_AbreTelaEmpresa(Qr_NotaEMP_CODIGO.AsInteger );
  end;
end;

procedure TFr_NF_55.sb_obs_nfeClick(Sender: TObject);
begin
  if not Assigned(fr_obs_nfe) then Application.CreateForm(tfr_obs_nfe,fr_obs_nfe);
  fr_obs_nfe.it_cd_nfl:=Qr_NotaNFL_CODIGO.AsInteger;
  fr_obs_nfe.showmodal
end;

procedure TFr_NF_55.Itm_Nfe_ComplClick(Sender: TObject);
var
  lc_qry:TSTQuery;
  sql_txt:String;
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Nota Fiscal Complementar','GERAR COMPLEMENTAR',GB_Cd_Usuario,'S') then
    Begin
    lc_qry:= TSTQuery.Create(Self);
    WITH lc_qry DO
      Begin
      Database:= DM.IBD_Gestao;
      Transaction:= DM.IB_Transacao;
      sql_txt:= ' select * from tb_retorno_nfe '+
              ' where NFE_CODSIT = 2'+
              ' AND NFE_CODNFL =:NFE_CODNFL  ';
      Active:=FALSE;
      SQL.Clear;
      SQL.Add(sql_txt);
      ParamByName('NFE_CODNFL').AsInteger:=Qr_Nota.fieldbyname('NFL_CODIGO').AsInteger;
      Active:=TRUE;
      IF IsEmpty THEN
        Begin
        MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                       'Nota n�o autorizada.'+EOLN+
                       'Solicite a autoriza��o e tente novamente.'+EOLN,
                       ['OK'],[bEscape],mpErro);
        end
      else
        Begin
        Application.CreateForm(TFr_Complementar,Fr_Complementar);
        Fr_Complementar.It_Cd_Nota_Ant    := Qr_NotaNFL_CODIGO.AsInteger;
        Fr_Complementar.ShowModal;
        FreeAndNil(Fr_Complementar);
        end;
      end;
    lc_qry.Close;
    FreeAndNil(lc_qry);
    END;
end;


procedure TFr_NF_55.Pc_PermissaoBotao(Pc_Menu: string);
begin

end;

procedure TFr_NF_55.AtualizarosCustos1Click(Sender: TObject);
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Atualizar Custos','ATUALIZAR CUSTO',GB_Cd_Usuario,'S') then
    Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       '   Esta opera��o vai atualizar o custo dos produtos deste Documento. ' + EOLN +
                       'Antes de continuar tenha certeza de que estes custos est�o corretos.'+ EOLN +
                       '                      Confirmar a atualiza��o ?',
                       [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
      begin
      Pc_Atualiza_Custo_venda(Qr_NotaNFL_CODIGO.AsInteger);
      end;
    end;
end;

procedure TFr_NF_55.CalcularaComisso1Click(Sender: TObject);
Var
  Lc_Cd_Pedido : Integer;
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Recalcular Comiss�o','RECALCULAR COMISS�O',GB_Cd_Usuario,'S') then
    Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja recalcular a comiss�o do Pedido N� '+ Qr_NotaPED_NUMERO.AsString +'.'+EOLN+EOLN+
                       'Confirmar o rec�lculo ?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
      begin
      //Gera��o de Comiss�o no faturamento
      Lc_Cd_Pedido := Qr_NotaPED_CODIGO.AsInteger;
      Pc_Construtor_Comissao(DM.IB_Transacao);
      Pc_DeletaComissao(DM.IB_Transacao, Lc_Cd_Pedido,0);
      Pc_Deleta_Vdo_Pedido(DM.IB_Transacao, Lc_Cd_Pedido,0,'');
      Pc_Registra_Vdo_Pedido(DM.IB_Transacao, Lc_Cd_Pedido);
      if Fc_Tb_Geral('L','TP_COMISSAO','') ='F' then
        Begin
        Pc_Gerar_Comissao_Vda_Fat(DM.IB_Transacao, Lc_Cd_Pedido);
        Pc_Gerar_Comissao_Srv_Fat(DM.IB_Transacao, Lc_Cd_Pedido);
        Pc_Gerar_Comissao_Srv_Vdo_Fat(DM.IB_Transacao, Lc_Cd_Pedido);
        end;
      Pc_Destrutor_Comissao;
      MensagemPadrao(MENSAGEM,'S U C E S S O !.'+EOLN+EOLN+
                     'A comiss�o foi recalculada com sucesso.'+EOLN,
                    ['OK'],[bEscape],mpInformacao);
      end;
    end;
end;

procedure TFr_NF_55.Dbg_FinanceiroDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  with Ds_FormaPgto.DataSet do
    Begin
    if (((FieldByName('FIN_TIPO').AsString = 'RA') or (FieldByName('FIN_TIPO').AsString = 'RM')) and (FieldByName('FIN_OPERACAO').AsString = 'D')) or
       (((FieldByName('FIN_TIPO').AsString = 'PA') or (FieldByName('FIN_TIPO').AsString = 'PM')) and (FieldByName('FIN_OPERACAO').AsString = 'C')) then 
      Dbg_Financeiro.Canvas.Font.Color := clRed;
    end;
  Dbg_Financeiro.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

Function TFr_NF_55.Fc_ValidaGeracaoNotaFiscalEletronica():Boolean;
Begin
  Result := true;
  if (Trim(Qr_NotaNAT_DESCRICAO.AsString) = '') then
    Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Natureza da opera��o n�o informada. Execute o processo padr�o.' + EOLN +
                   'Cancele e fature novamente pelo tela de Origem.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
    end;

  if (Trim(Qr_NotaNFL_NUMERO.AsString) <> '') then
    Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'J� existe n�mero de nota. Execute o processo padr�o.' + EOLN +
                   'Cancele e fature novamente pelo tela de Origem.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
    end;

  if (Qr_NotaNFL_DT_EMISSAO.AsDateTime <> Date) then
    Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'A data da nota n�o � v�lida. Execute o processo padr�o.' + EOLN +
                   'Cancele e fature novamente pelo tela de Origem.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
    end;

end;

function TFr_NF_55.Fc_GerarNotaFiscalEletronica:Boolean;
Var
  Lc_Cd_Empresa : Integer;
  Lc_Escolha : Integer;
begin
{
  Result := True;
  Lc_Cd_Empresa := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
  if (Qr_NotaEMP_CODIGO.AsInteger = Lc_Cd_Empresa) then
    Begin
    if (MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                    'Por favor informe o nome de um cliente para a gera��o da nota' + EOLN +
                    'Este processo muito importante pois altera o codigo do cliente na nota.' + EOLN+
                    'Confirma a opera��o? ' + EOLN,
                    [SIM, NAO], [bNormal,bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
      Begin
      Lc_Form := TForm.Create(Fr_Empresas);
      Application.CreateForm(TFr_Empresas, Lc_Form);
      TFr_Empresas(Lc_Form).It_Tipo_empresa_Cad := Qr_Nota.fieldbyname('EMP_TIPO').AsInteger;
      TFr_Empresas(Lc_Form).It_Cd_Empresa := 0;
      TFr_Empresas(Lc_Form).ShowModal;
      if (TFr_Empresas(Lc_Form).It_Cd_Empresa > 0) and (TFr_Empresas(Lc_Form).It_Cd_Empresa <> Lc_Cd_Empresa) then
        Begin
        //ATUALIZA O PEDIDO COM NOVO CADASTRO DO CLIENTE
        Qr_Acao.Active := False;
        Qr_Acao.Transaction := DM.IB_Transacao;
        Qr_Acao.SQL.Clear;
        Qr_Acao.SQL.Add('UPDATE TB_PEDIDO SET PED_CODEMP =:EMP_CODIGO WHERE PED_CODIGO =:PED_CODIGO ');
        Qr_Acao.ParamByName('EMP_CODIGO').AsInteger := TFr_Empresas(Lc_Form).It_Cd_Empresa;
        Qr_Acao.ParamByName('PED_CODIGO').AsInteger := Qr_NotaPED_CODIGO.AsInteger;
        Qr_Acao.ExecSQL;
        IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
        //ATUALIZA A NOTA COM NOVO ENDERECO NO PEDIDO
        DM.Qr_Endereco.Active := False;
        DM.Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := TFr_Empresas(Lc_Form).It_Cd_Empresa;
        DM.Qr_Endereco.Active := True;
        Qr_Acao.Active := False;
        Qr_Acao.Transaction := DM.IB_Transacao;
        Qr_Acao.SQL.Clear;
        Qr_Acao.SQL.Add('UPDATE TB_PEDIDO SET PED_CODEND =:END_CODIGO WHERE PED_CODIGO =:PED_CODIGO ');
        Qr_Acao.ParamByName('END_CODIGO').AsInteger := DM.Qr_EnderecoEND_CODIGO.AsInteger;
        Qr_Acao.ParamByName('PED_CODIGO').AsInteger := Qr_NotaPED_CODIGO.AsInteger;
        Qr_Acao.ExecSQL;
        IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;

        //ATUALIZA A NOTA COM NOVO CADASTRO DO CLIENTE
        Qr_Acao.Active := False;
        Qr_Acao.Transaction := DM.IB_Transacao;
        Qr_Acao.SQL.Clear;
        Qr_Acao.SQL.Add('UPDATE TB_NOTA_FISCAL SET NFL_CODEMP =:EMP_CODIGO WHERE NFL_CODIGO =:NFL_CODIGO ');
        Qr_Acao.ParamByName('EMP_CODIGO').AsInteger := TFr_Empresas(Lc_Form).It_Cd_Empresa;
        Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := Qr_NotaNFL_CODIGO.AsInteger;
        Qr_Acao.ExecSQL;
        IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
        end
      else
        Begin
        MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                       'Cliente n�o informado.' + EOLN +
                       'Opera��o ser� finalizada.' + EOLN,
                       ['OK'], [bEscape], mpErro);
        Result := False;
        exit;
        end;
      FreeAndNil(Lc_Form);
      //ATUALIZA A NOTA COM um NUMERO VALIDO DE NOTA FISCAL
      Qr_Acao.Active := False;
      Qr_Acao.Transaction := DM.IB_Transacao;
      Qr_Acao.SQL.Clear;
      Qr_Acao.SQL.Add('UPDATE TB_NOTA_FISCAL SET NFL_NUMERO =:NFL_NUMERO WHERE NFL_CODIGO =:NFL_CODIGO ');
      Qr_Acao.ParamByName('NFL_NUMERO').AsString := StrZero(Fc_GeraNumeroNota, 6,0);
      Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := Qr_NotaNFL_CODIGO.AsInteger;
      Qr_Acao.ExecSQL;
      IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
      Qr_Nota.Active      := False;
      Qr_Nota.Active      := True;
      end
    else
      Begin
      Result := False;
      exit;
      end;
    end;
}
end;

function TFr_NF_55.Fc_ValidaAberturaCartaCorrecao():boolean;
Begin
  Result := True;
  if (PG_Notas.ActivePageIndex  = 1 ) then
    Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Por favor escolha uma nota e clique em visualizar.' + EOLN +
                   'Esta opera��o n�o � permitida na tela de pesquisa.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
    end;

  if not Fc_ValidaexistenciaNota then
    Begin
    Result := False;
    exit;
    end;

  {
  if Fc_VerificaSituacaoNFe(It_Cd_Nota) <> 2 then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Esta nota ainda n�o est� autorizada.'+EOLN+
                   'Esta opera��o s� � permitida para Notas autorizadas.' + EOLN+
                   'Atualize a situa��o desta Nota e tente novamente.' + EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
    end;
  }
end;

procedure TFr_NF_55.DBG_ProdutosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if Ds_ItensNota.DataSet.FieldByName('ITD_CODITF_ORIG').AsInteger > 0 then
    DBG_Produtos.Canvas.Font.Color := clRed;
  DBG_Produtos.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TFr_NF_55.Itm_Carta_CorrecaoClick(Sender: TObject);
Var
  Lc_Chave : String;
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Gerar Carta de Corre��o','CARTA DE CORRE��O',GB_Cd_Usuario,'S') then
    Begin
    if Fc_ValidaAberturaCartaCorrecao then
      Begin
      If not Assigned(Fr_CartaCorrecao)then (Application.CreateForm(TFr_CartaCorrecao, Fr_CartaCorrecao));
      Fr_CartaCorrecao.It_Cd_NotaFiscal := Qr_NotaNFL_CODIGO.AsInteger;
      Lc_Chave := Fc_ChaveDanfe_XMl(Qr_NotaNFL_CODIGO.AsInteger);
      //Retiramos o Texto e a extens�o XML
      Lc_Chave := Copy(Lc_Chave,1,(Length(Lc_Chave)-8));
      Fr_CartaCorrecao.It_Chave := Lc_Chave;
      Fr_CartaCorrecao.ShowModal;
      end;
    END;
end;

procedure TFr_NF_55.Qr_ItensSrvAfterOpen(DataSet: TDataSet);
begin
  Qr_ItensSrv.FetchAll;
  Sb_Tecnico.Enabled := (Qr_ItensSrv.RecordCount>0);
end;

procedure TFr_NF_55.CadastrodoProdutoClick(Sender: TObject);
Var
  Lc_Form : TFr_Produtos;
begin
  if Fc_VerificaPermissao('Fr_Produtos','Cadastro de Produtos','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Try
      Lc_Form := TFr_Produtos.Create(Self);
      Lc_Form.It_Cd_Cadastro := Qr_ItensNota.FieldByName('ITF_CODPRO').AsInteger;
      Lc_Form.ShowModal;
      Qr_ItensNota.Active := False;
      Qr_ItensNota.Active := true;
    Finally
      FreeAndNil( Lc_Form );
    End;
  end;
end;

procedure TFr_NF_55.AuditoriaEstoque1Click(Sender: TObject);
begin
  if Fc_AuditoriaEstoquePedido(Qr_NotaPED_CODIGO.AsInteger,'S') then
    Begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A � � O!.' + EOLN + EOLN +
                   'Foi atualizado o estoque dos produtos deste documento .' + EOLN +
                   'Veja na confer�ncia de movimenta��o.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    end
  else
    Begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A � � O!.' + EOLN + EOLN +
                   'O movimento dos produtos deste documento j� est�o registrados no estoque.' + EOLN +
                   'Veja na confer�ncia de movimenta��o.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    end;
end;

procedure TFr_NF_55.RegistraNmerodolote1Click(Sender: TObject);
var
  Lc_Escolha: Integer;
  Lc_Form:TForm;
  Lc_Tipo : String;
begin
  case Qr_NotaPED_TIPO.AsInteger of
    1:Lc_Tipo := 'VENDA';
    2:Lc_Tipo := 'COMPRA';
    3:Lc_Tipo := 'AJUSTE';
  end;

  if (Copy(Qr_NotaNFL_TIPO.AsString,1,1) = 'E') then
    Begin
    Lc_Form := TForm.Create(Fr_Ctrl_Lote_Entrada);
    Application.CreateForm(TFr_Ctrl_Lote_Entrada, Lc_Form);
    TFr_Ctrl_Lote_Entrada(Lc_Form).It_Cd_Item := Qr_ItensNota.FieldByname('ITF_CODIGO').AsInteger;
    TFr_Ctrl_Lote_Entrada(Lc_Form).It_Tipo := Lc_Tipo;
    TFr_Ctrl_Lote_Entrada(Lc_Form).it_Cd_produto := Qr_ItensNota.FieldByname('ITF_CODPRO').AsInteger;
    TFr_Ctrl_Lote_Entrada(Lc_Form).It_Cd_Empresa := Qr_NotaEMP_CODIGO.AsInteger;
    TFr_Ctrl_Lote_Entrada(Lc_Form).It_Qtde_Lote := Qr_ItensNota.FieldByname('ITF_QTDE').AsFloat;
    TFr_Ctrl_Lote_Entrada(Lc_Form).ShowModal;
    FreeAndNil(Lc_Form);
    end
  else
    Begin
    Lc_Form := TForm.Create(Fr_Ctrl_Lote_Saida);
    Application.CreateForm(TFr_Ctrl_Lote_Saida, Lc_Form);
    TFr_Ctrl_Lote_Saida(Lc_Form).It_Cd_Item := Qr_ItensNota.FieldByname('ITF_CODIGO').AsInteger;
    TFr_Ctrl_Lote_Saida(Lc_Form).It_Tipo := Lc_Tipo;
    TFr_Ctrl_Lote_Saida(Lc_Form).it_Cd_produto := Qr_ItensNota.FieldByname('ITF_CODPRO').AsInteger;
    TFr_Ctrl_Lote_Saida(Lc_Form).It_Cd_Empresa := Qr_NotaEMP_CODIGO.AsInteger;
    TFr_Ctrl_Lote_Saida(Lc_Form).It_Qtde_Lote := Qr_ItensNota.FieldByname('ITF_QTDE').AsFloat;
    TFr_Ctrl_Lote_Saida(Lc_Form).ShowModal;
    FreeAndNil(Lc_Form);
    end;
end;

procedure TFr_NF_55.Qr_ItensNotaAfterOpen(DataSet: TDataSet);
begin
  if Qr_Nota.FieldByName('NFL_TIPO').AsString = 'SI' then
    Begin
    (Qr_ItensNota.FieldByName('ITF_VL_UNIT') as TNumericField).DisplayFormat  := Gb_Casa_Dec_Venda;
    (Qr_ItensNota.FieldByName('ITF_SUBTOTAL') as TNumericField).DisplayFormat  := Gb_Casa_Dec_Venda;
    end
  else
    Begin
    (Qr_ItensNota.FieldByName('ITF_VL_UNIT') as TNumericField).DisplayFormat  := Gb_Casa_Dec_Compra;
    (Qr_ItensNota.FieldByName('ITF_SUBTOTAL') as TNumericField).DisplayFormat  := Gb_Casa_Dec_Compra;
    end;

end;

procedure TFr_NF_55.Qr_NotaAfterOpen(DataSet: TDataSet);
begin
  Qr_ItensNota.Active := False;
  Qr_ItensNota.ParamByName('NFL_CODIGO').AsInteger := Qr_NotaNFL_CODIGO.AsInteger;
  Qr_ItensNota.Active := True;
end;

procedure TFr_NF_55.Tbs_ServicoShow(Sender: TObject);
begin
  Qr_ItensSrv.Active := False;
  Qr_ItensSrv.ParamByName('PED_CODIGO').AsInteger := Qr_NotaPED_CODIGO.AsInteger;
  Qr_ItensSrv.Active := True;
end;

procedure TFr_NF_55.CpiadePedidoNota1Click(Sender: TObject);
Var
  Lc_Form : TFr_CopiaPedidoNota;
begin
  Lc_Form := TFr_CopiaPedidoNota.Create(Self);
  Lc_Form.ShowModal;
  FreeAndNil(Lc_Form);
end;

procedure TFr_NF_55.MnuLucratividadeClick(Sender: TObject);
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Notas Fiscais de Venda','LUCRATIVIDADE',GB_Cd_Usuario,'S') then
  Begin
    if (trim(Qr_NotaNF