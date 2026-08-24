unit Un_Pesq_Produto;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Grids, DBGrids, Buttons, ExtCtrls, ComCtrls, DB, System.Math, STQuery, Mask, Menus, DBCtrls, CheckLst, Vcl.Clipbrd, FavoritoButtons, QEdit_Setes, Un_Fm_ListaEstoques, ControllerCliente, ControllerCfgGrid, Un_Fm_ListaMultiEmpresa, STDatabase, base_frame_list,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;


type
   TFr_Pesq_Produto = class(TForm)
     Qr_Pesquisa: TSTQuery;
     Ds_Pesquisa: TDataSource;
     PuMnu: TPopupMenu;
     Aplicao1: TMenuItem;
     Qr_Tabela: TSTQuery;
     Ds_Tabela: TDataSource;
     N1: TMenuItem;
     Configurao1: TMenuItem;
     Qr_Preco_Qtde: TSTQuery;
    Qr_Movimento: TSTQuery;
    Pn_Pesquisa: TPanel;
    Pn_Config: TPanel;
    Sb_Confirma: TSpeedButton;
    Sb_Cancela: TSpeedButton;
    Sb_Limpa_Config: TSpeedButton;
    Pn_Titulo: TPanel;
    Chbx_Visualizar: TCheckListBox;
    Grd_Pesquisa: TDBGrid;
    GrBx_Pesquisa: TGroupBox;
    Lb_Codigo: TLabel;
    Lb_Descricao: TLabel;
    Lb_Aplicacao: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LBL_CD_BARRA: TLabel;
    Label3: TLabel;
    E_BuscaAplicacao: TMaskEdit;
    E_BuscaCodigo: TMaskEdit;
    E_BuscaDescricao: TMaskEdit;
    E_BuscaMarca: TMaskEdit;
    Dblcb_Tabelas: TDBLookupComboBox;
    E_BuscaSubgrupo: TMaskEdit;
    E_BuscaGrupo: TMaskEdit;
    E_BuscaCodBarras: TEdit_Setes;
    Panel1: TPanel;
    SB_Buscar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    Sb_Imagem: TSpeedButton;
    Sb_Aplicacao: TSpeedButton;
    Pnl_Observacao: TPanel;
    Label13: TLabel;
    Label36: TLabel;
    MM_Observacao: TMemo;
    Chbx_Promocao: TCheckBox;
    Chbx_Disponivel: TCheckBox;
    ChBx_Imagem: TCheckBox;
    Chb_Digitacao: TCheckBox;
    ChBx_ProdutosInativos: TCheckBox;
    Sb_Produtos: TSpeedButton;
    Sb_AlternaServico: TSpeedButton;
    Fm_ListaEstoques: TFm_ListaEstoques;
    Qr_PesquisaPRO_CODIGO: TIntegerField;
    Qr_PesquisaPRO_CODIGOFAB: TStringField;
    Qr_PesquisaPRO_CODIGOBAR: TStringField;
    Qr_PesquisaPRO_CODIGOFOR: TStringField;
    Qr_PesquisaPRO_DESCRICAO: TStringField;
    Qr_PesquisaPRO_APLICACAO: TWideMemoField;
    Qr_PesquisaPRO_VL_CUSTO: TFMTBCDField;
    Qr_PesquisaPRO_LOCAL: TStringField;
    Qr_PesquisaPRO_CAMPANHA: TStringField;
    Qr_PesquisaPRO_VL_INSTALA: TFMTBCDField;
    Qr_PesquisaMED_ABREVIATURA: TStringField;
    Qr_PesquisaGRP_DESCRICAO: TStringField;
    Qr_PesquisaSBG_DESCRICAO: TStringField;
    Qr_PesquisaMRC_DESCRICAO: TStringField;
    Qr_PesquisaIMG_PRODUTO: TIntegerField;
    Qr_PesquisaPRC_VL_NORMAL: TFMTBCDField;
    Qr_PesquisaPRC_VL_PROMOCAO: TFMTBCDField;
    Qr_PesquisaPRC_QTDE: TBCDField;
    Qr_PesquisaEST_QTDE: TFMTBCDField;
    Qr_PesquisaPRC_VL_INSTALADO: TFloatField;
    Qr_PesquisaPRC_VL_ESPECIAL: TFloatField;
    Fm_LME: TFm_ListaMultiEmpresa;
    Sb_InclusaoRapida: TSpeedButton;
    N2: TMenuItem;
    Copiardescriodoproduto1: TMenuItem;
    Lb_ResultadoPesquisa: TLabel;
     procedure SB_BuscarClick(Sender: TObject);
     procedure SB_VisualizarClick(Sender: TObject);
     procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
     procedure FormKeyPress(Sender: TObject; var Key: Char);
     procedure Sb_Sair_0Click(Sender: TObject);
     procedure E_BuscaDescricaoChange(Sender: TObject);
     procedure FormShow(Sender: TObject);
     procedure Sb_ImagemClick(Sender: TObject);
     procedure Label36Click(Sender: TObject);
     procedure Sb_AplicacaoClick(Sender: TObject);
     procedure Qr_TabelaAfterOpen(DataSet: TDataSet);
     procedure Dblcb_TabelasClick(Sender: TObject);
     procedure Qr_PesquisaAfterOpen(DataSet: TDataSet);
     procedure Sb_CancelaClick(Sender: TObject);
     procedure Configurao1Click(Sender: TObject);
     procedure Sb_ConfirmaClick(Sender: TObject);
     procedure Grd_PesquisaTitleClick(Column: TColumn);
    procedure FormActivate(Sender: TObject);
    procedure Grd_PesquisaCellClick(Column: TColumn);
    procedure Sb_Limpa_ConfigClick(Sender: TObject);
    procedure Chb_DigitacaoClick(Sender: TObject);
    procedure Grd_PesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure Grd_PesquisaDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure Qr_PesquisaCalcFields(DataSet: TDataSet);
    procedure Dblcb_Mha_EmpresaClick(Sender: TObject);
    procedure Dblcb_EstoqueClick(Sender: TObject);
    procedure Grd_PesquisaDblClick(Sender: TObject);
    procedure Sb_ProdutosClick(Sender: TObject);
    procedure Sb_AlternaServicoClick(Sender: TObject);
    procedure Fm_ListaEstoquesDblcb_EstoqueClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Sb_InclusaoRapidaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Copiardescriodoproduto1Click(Sender: TObject);
   private
    { Private declarations }
    Cliente : TControllerCliente;
    CfgGrid : TControllerCfgGrid;
    procedure InclusaoRapida;
    function validaexisteRegistro:Boolean;
    procedure InclusaoRapidaPedido;
    procedure InclusaoRapidaCotacao;
   public
    { Public declarations }
      It_Pedido_Vda : Boolean;
      It_Pedido_Dev : Boolean;
      It_Pedido_Tro : Boolean;
      It_Cotacao_Vda : Boolean;
      It_Cotacao_Cmv : Boolean;
      It_Pedido_Cpa : Boolean;
      It_Pedido_Ajt : Boolean;


     It_Cd_Tabela: Integer;
     It_Cd_Empresa : Integer;
     It_Col_VL_Normal : Integer;
     It_Col_VL_Promocao : Integer;
     it_Modalidade_preco : String;
     it_TipoCliente:string;

     It_MultiplicadorPreco: Currency;
     It_Tipo_Especifico : String;
     It_Visualizar : boolean;
     CodigoPedido : Integer;
     CodigoCotacao : Integer;
     procedure PC_Buscar;
     procedure Pc_Tabelas_Disponiveis;
     procedure Pc_FormataCasas;
     procedure Pc_Busca_Preco_Qtde(Pc_Cd_Tabela :Integer; Pc_Cd_Produto :Integer);
     procedure Pc_NomeLabel;
    procedure Pc_Monta_PainelConfig;
    procedure Pc_Monta_Grid_Padrao;
    procedure Pc_Monta_Grid;
    procedure Pc_Grava_Grid;
    procedure Pc_Grava_Confir_Configuracao;
    procedure Pc_Grava_Campo_Grid(Pc_Campo: String;Pc_lABEL:String;Pc_Usuario: Integer;Pc_largura:Integer;Pc_posicao:Integer;PC_visible:String);
   end;

var
   Fr_Pesq_Produto: TFr_Pesq_Produto;

implementation

uses     Un_DM, Un_Funcoes, UN_Pedido_Vda, UN_Pedido_Cpa, un_inclusao_rapida_produto_qtde, UN_Sistema, UN_FotoProduto, UN_Pedido_Ajt, Un_Cotacao, Un_Composicao, Un_Liberacao, UN_Imp_Produtos, Un_FrenteCaixa, Un_Regra_Negocio, Un_Produtos, RN_Permissao, RN_Estoque, Un_Pesq_Servico, Un_Img_Site_Produto, UN_Principal, env, Un_Msg;
{$R *.dfm}


procedure TFr_Pesq_Produto.Pc_Busca_Preco_Qtde(Pc_Cd_Tabela :Integer; Pc_Cd_Produto :Integer);
BEgin
  Qr_Preco_Qtde.Active := False;
  Qr_Preco_Qtde.ParamByName('PRC_CODPRO').AsInteger := Pc_Cd_Produto;
  Qr_Preco_Qtde.ParamByName('PRC_CODTPR').AsInteger := Pc_Cd_Tabela;
  Qr_Preco_Qtde.Active := True;
  Qr_Preco_Qtde.FetchAll;
  Qr_Preco_Qtde.First;
end;


procedure TFr_Pesq_Produto.Pc_Tabelas_Disponiveis;
Var
  Lc_SqlTxt : String;
BEGIN
  Lc_SqlTxt := 'SELECT * FROM TB_TABELA_PRECO TP ' +
               'WHERE (TPR_CODIGO is not null) '+
               ' and (TPR_CODIGO <>:TPR_CODIGO) '+
               ' AND ( TPR_ATIVA = ''S'') ';

  //Trata telas de Venda

  if (It_Pedido_Vda) or (It_Cotacao_Vda) then
  Begin
    if (Fc_Tb_Geral('L','VDA_G_CTRL_TABELA_X_PRAZO','') = 'S') then
    Begin
      if it_Modalidade_preco <> 'A' then
        Lc_SqlTxt := Lc_SqlTxt + 'AND ((TPR_MODALIDADE = '''+ it_Modalidade_preco + ''') OR (TPR_MODALIDADE = ''A'')) ';
    end;

    if  ( Fc_Tb_Geral('L','VDA_G_CTRL_TB_TP_CLIENTE','N') = 'S') then
    Begin
      Lc_SqlTxt := Lc_SqlTxt + 'AND (( TPR_TIPO_CLIENTE = '''+ it_TipoCliente + ''') OR ( TPR_TIPO_CLIENTE = ''A'')) ';
    End;
  end;

  //Trata telas de Compras
  if it_Pedido_Cpa then
  Begin
    Lc_SqlTxt := 'SELECT * FROM TB_TABELA_PRECO TP ' +
                 'WHERE (TP.TPR_CODIGO = 1) '+
                 ' and (TPR_CODIGO <> :TPR_CODIGO)' +
                 ' AND ( TPR_ATIVA = ''S'') ';
  end;

  //Trata telas de Ajustes
  if It_Pedido_Ajt then
  Begin
    Lc_SqlTxt := 'SELECT * FROM TB_TABELA_PRECO TP '+
                 'WHERE (TP.TPR_CODIGO = 1) '+
                 ' and (TPR_CODIGO <> :TPR_CODIGO) '+
                 ' AND ( TPR_ATIVA = ''S'') ';
  end;

  with Qr_Tabela do
  begin
    Close;
    SQL.Clear;
    SQL.Add(Lc_SqlTxt + ' ORDER BY TPR_PRINCIPAL DESC');
    ParamByName('TPR_CODIGO').AsInteger := 2;
    Open;
    Dblcb_Tabelas.KeyValue := FieldByName('TPR_CODIGO').AsInteger
  end;
  Cliente.Registro.Codigo := It_Cd_Empresa;
  Cliente.getById;
  if Cliente.exist then
  Begin
    if Cliente.Registro.TabelaPreco > 0 then
      Dblcb_Tabelas.KeyValue := Cliente.Registro.TabelaPreco;
  End;

END;



procedure TFr_Pesq_Produto.PC_Buscar;
var
   Sqltxt: string;
   Lc_Codigo: boolean;
   Lc_Descricao: boolean;
   Lc_Grupo: boolean;
   Lc_SubGrupoo: boolean;
   Lc_Marca: boolean;
   Lc_Aplicacao: boolean;
   Lc_CodigoInteiro: Integer;
   Lc_Barras: Boolean;
begin
  sqltxt := '';
  Screen.Cursor := crHourGlass;
  if Trim(E_BuscaCodigo.Text)    = '' then Lc_Codigo    := False else Lc_Codigo    := True;
  if Trim(E_BuscaDescricao.Text) = '' then Lc_Descricao := False else Lc_Descricao := True;
  if Trim(E_BuscaCodBarras.Text) = '' then Lc_Barras    := False else Lc_Barras := True;
  if Trim(E_BuscaGrupo.Text)     = '' then Lc_Grupo     := False else Lc_Grupo     := True;
  if Trim(E_BuscaSubgrupo.Text)  = '' then Lc_SubGrupoo := False else Lc_SubGrupoo := True;
  if Trim(E_BuscaMarca.Text)     = '' then Lc_Marca     := False else Lc_Marca     := True;
  if Trim(E_BuscaAplicacao.Text) = '' then Lc_Aplicacao := False else Lc_Aplicacao := True;


   Qr_Pesquisa.Close;
   Qr_Pesquisa.SQL.Clear;
   Sqltxt := ' SELECT DISTINCT '+
             '  PRO_CODIGO '+
             ' ,PRO_CODIGOFAB '+
             ' ,PRO_CODIGOBAR '+
             ' ,PRO_CODIGOFOR '+
             ' ,PRO_DESCRICAO '+
             ' ,PRO_APLICACAO '+
             ' ,PRO_VL_CUSTO '+
             ' ,PRO_LOCAL '+
             ' ,PRO_CAMPANHA '+
             ' ,PRO_VL_INSTALA '+
             ' ,MED_ABREVIATURA '+
             ' ,GRP_DESCRICAO '+
             ' ,SBG_DESCRICAO '+
             ' ,MRC_DESCRICAO ';
  if ChBx_Imagem.Checked then
    Begin
    Sqltxt := Sqltxt + ',tb_imagem.table_id IMG_PRODUTO  ';
    end
  else
    Begin
    Sqltxt := Sqltxt + ',0 IMG_PRODUTO ';
    end;

  Sqltxt := Sqltxt +
             ' ,tb_normal.prc_vl_vda PRC_VL_NORMAL '+
             ' ,tb_promocao.prc_vl_vda PRC_VL_PROMOCAO '+
             ' ,tb_promocao.PRC_QT_MIN PRC_QTDE '+
             ' ,CAST(SUM(EST_QTDE) AS NUMERIC(18, 6)) EST_QTDE '+
             'FROM TB_PRODUTO tb_produto '+
             '  INNER JOIN tb_preco tb_normal '+
             '  ON ((tb_normal.prc_codpro = tb_produto.pro_codigo) and (tb_normal.PRC_CODTPR = :TPR_CODIGO)) '+
             '  INNER JOIN tb_preco tb_promocao '+
             '  ON ((tb_promocao.prc_codpro = tb_produto.pro_codigo) and (tb_promocao.prc_codtpr = 2)) '+
             '  INNER JOIN TB_MEDIDA tb_medida                      '+
             '  ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)  '+
             '  INNER JOIN TB_GRUPOS tb_grupos                      '+
             '  ON (tb_produto.PRO_CODGRP = tb_grupos.GRP_CODIGO)   '+
             '  INNER JOIN TB_SUBGRUPOS tb_subgrupo                 '+
             '  ON (tb_produto.PRO_CODSBG = tb_subgrupo.SBG_CODIGO) '+
             '  INNER JOIN TB_MARCA_PRODUTO tb_marca            '+
             '  ON (tb_marca.MRC_CODIGO = tb_produto.PRO_CODMRC)    '+
             '  Inner JOIN  TB_ESTOQUE tb_estoque                   '+
             '  ON (tb_estoque.EST_CODPRO = tb_produto.PRO_CODIGO)  ';

  if ChBx_Imagem.Checked then
    Begin
    Sqltxt := Sqltxt +
    '  INNER JOIN TB_IMAGES tb_imagem '+
    '  ON ( tb_imagem.table_id = tb_produto.PRO_CODIGO )             ';
    end;
  if not ChBx_ProdutosInativos.Checked then
    Sqltxt := Sqltxt +  'WHERE  (PRO_ATIVO = ''S'') '
  else
    Sqltxt := Sqltxt +  'WHERE  (PRO_CODIGO IS NOT NULL) ';

  Sqltxt := Sqltxt +  '  and (PRO_TIPO <> ''A'')' ;

  if not Fm_ListaEstoques.ChBx_Estoques.Checked then
    SqlTxt := SqlTxt + ' and (EST_CODETS=:ETS_CODIGO) ';

  IF (It_Tipo_Especifico = '') then
  Begin
    if (Fc_Aq_Geral('L','PRODUTO','PRO_P_DISTG_PA_MP','S') = 'S') then
      Begin
      if It_Pedido_Vda or It_Cotacao_Vda or It_Cotacao_Cmv then
        SqlTxt := SqlTxt + ' and (PRO_TIPO = ''P'') '
      else
        SqlTxt := SqlTxt + ' and (PRO_TIPO <> ''S'') ';
      end
    else
      SqlTxt := SqlTxt + ' and (PRO_TIPO <> ''S'') ';
  end
  else
  Begin
     SqlTxt := SqlTxt + ' and (PRO_TIPO = ''' + It_Tipo_Especifico + ''') ';
  end;

  Lc_CodigoInteiro := StrToIntDef(E_BuscaCodigo.Text, 0);

  IF Lc_Codigo THEN
    Begin
    if (Fc_Aq_Geral('L', 'PRODUTO','PRO_P_COD_EXATO', 'S')='S') THEN
      Begin
      if (Lc_CodigoInteiro>0) THEN
        Sqltxt := Sqltxt + ' AND ( (PRO_CODIGO =:PRO_CODIGO) OR (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO)) '
      else
        Sqltxt := Sqltxt + ' and PRO_CODIGOFAB =:PRO_CODIGO ';
      end
    else
      Begin
      if (Lc_CodigoInteiro>0) THEN
        Sqltxt := Sqltxt + ' AND ((PRO_CODIGO LIKE :PRO_CODIGO) OR  (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO))'
      else
        Sqltxt := Sqltxt + ' AND ((PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO)) ';

      end;
    end;

   if Lc_Descricao then
      Sqltxt := Sqltxt + ' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

   if Lc_Grupo then
      Sqltxt := Sqltxt + ' AND (GRP_DESCRICAO LIKE :GRP_DESCRICAO) ';

   if Lc_SubGrupoo then
      Sqltxt := Sqltxt + ' AND (SBG_DESCRICAO LIKE :SBG_DESCRICAO) ';

   if Lc_Marca then
      Sqltxt := Sqltxt + 'AND (MRC_DESCRICAO LIKE :MRC_DESCRICAO) ';

   if Lc_Aplicacao then
      Sqltxt := Sqltxt + 'AND (PRO_APLICACAO LIKE :PRO_APLICACAO) ';

   if Lc_Barras then
      Sqltxt := Sqltxt + 'AND (PRO_CODIGOBAR =:PRO_CODIGOBAR) ';

   if Chbx_Promocao.Checked then Sqltxt := Sqltxt + ' AND (PRO_CAMPANHA = ''S'') ';
   if Chbx_Disponivel.Checked then Sqltxt := Sqltxt + ' AND (EST_QTDE > 0) ';

   if not GB_ProdCompartilha then   Sqltxt:=Sqltxt+ ' AND PRO_CODMHA = :PRO_CODMHA ';

   Qr_Pesquisa.SQL.Add(sqltxt + ' GROUP by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18 ORDER BY PRO_DESCRICAO');

  if not GB_ProdCompartilha then  Qr_Pesquisa.ParamByName('PRO_CODMHA').AsInteger:=Gb_CodMha;
  if Lc_Codigo then
    Begin
    if (Fc_Aq_Geral('L', 'PRODUTO','PRO_P_COD_EXATO', 'S') = 'S') then
      Begin
      Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := E_BuscaCodigo.Text;
      end
    else
      Begin
      Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := '%' + E_BuscaCodigo.Text + '%';
      end;
    end;
  if Lc_Descricao then  Qr_Pesquisa.ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(E_BuscaDescricao.Text,1,98) + '%';
  if Lc_Grupo then      Qr_Pesquisa.ParamByName('GRP_DESCRICAO').AsString := '%' + E_BuscaGrupo.Text + '%';
  if Lc_SubGrupoo then  Qr_Pesquisa.ParamByName('SBG_DESCRICAO').AsString := '%' + E_BuscaSubgrupo.Text + '%';
  Qr_Pesquisa.ParamByName('TPR_CODIGO').AsInteger := Dblcb_Tabelas.KeyValue;

  if Lc_Marca then  Qr_Pesquisa.ParamByName('MRC_DESCRICAO').AsString := '%' + E_BuscaMarca.Text + '%';
  if Lc_Aplicacao then Qr_Pesquisa.ParamByName('PRO_APLICACAO').AsString := '%' + E_BuscaAplicacao.Text + '%';
  if Lc_Barras then Qr_Pesquisa.ParamByName('PRO_CODIGOBAR').AsString := E_BuscaCodBarras.Text;

  if not Fm_ListaEstoques.ChBx_Estoques.Checked then
    Qr_Pesquisa.ParamByName('ETS_CODIGO').AsInteger := Fm_ListaEstoques.Dblcb_Estoque.KeyValue;

  if DM.IBT_Estoque.InTransaction then
    DM.IBT_Estoque.Commit;
  Qr_Pesquisa.Open;
  Qr_Pesquisa.FetchAll;
  Lb_ResultadoPesquisa.Caption := 'Resultado da pesquisa : ' + IntTostr(Qr_Pesquisa.recordCount) + ' registro(s)';
  Screen.Cursor := crDefault;
end;

procedure TFr_Pesq_Produto.SB_BuscarClick(Sender: TObject);
begin
  PC_Buscar;
end;

procedure TFr_Pesq_Produto.SB_VisualizarClick(Sender: TObject);
begin
  It_Visualizar := True;
  close;
end;

function TFr_Pesq_Produto.validaexisteRegistro: Boolean;
begin
  Result := True;
  if not Qr_Pesquisa.Active  then
  Begin
        MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                       'Efetuar a Pesquisa antes de prosseguir.' + EOLN +
                       'Verifique e tente novamente.' + EOLN,
                       ['OK'], [bEscape], mpErro);
                       //Nenhum produto encontrado.

    Result := False;
    Exit;
  End;

  if Qr_Pesquisa.FieldByName('PRO_CODIGO').AsInteger = 0 then
  Begin
        MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                       'Nenhum produto encontrado.' + EOLN +
                       'Verifique e tente novamente.' + EOLN,
                       ['OK'], [bEscape], mpErro);

    Result := False;
    Exit;
  End;



end;

procedure TFr_Pesq_Produto.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_RETURN :Begin
                 if Grd_Pesquisa.Focused then
                 if SB_Visualizar.Enabled then SB_VisualizarClick(sender);
                 end;
      VK_F6: if Sb_Aplicacao.Enabled  then Sb_AplicacaoClick(Sender);
      VK_F7: if SB_Buscar.Enabled     then SB_BuscarClick(Sender);
      VK_F8: if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
      VK_F9: if Sb_Imagem.Enabled     then Sb_ImagemClick(Sender);
      VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
    end;
end;

procedure TFr_Pesq_Produto.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13)  and not (ActiveControl is TDBGrid) then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

procedure TFr_Pesq_Produto.Sb_Sair_0Click(Sender: TObject);
begin
  It_Visualizar := False;
  close;
end;

procedure TFr_Pesq_Produto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(CfgGrid);
  FreeAndNil(Cliente);
end;

procedure TFr_Pesq_Produto.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  Pc_Grava_Grid;
  if (Gb_Nivel = 1) then Gb_Liberado := True else Gb_Liberado := False;
  Pc_Tabelas_Disponiveis;
end;

procedure TFr_Pesq_Produto.FormCreate(Sender: TObject);
begin
  Cliente := TControllerCliente.create(Self);
  CfgGrid := TControllerCfgGrid.Create(Self);
  CodigoPedido := 0;
end;

procedure TFr_Pesq_Produto.E_BuscaDescricaoChange(Sender: TObject);
begin
  if Chb_Digitacao.Checked then
    Begin
    PC_Buscar;
    end;
end;

procedure TFr_Pesq_Produto.FormShow(Sender: TObject);
begin
  Fm_LME.Listar('EMP_NOME');
  Fm_LME.HabilitarMultiEmpresa;
  IF Fm_LME.chbx_Empresas.Checked then
  Begin
    Fm_ListaEstoques.AtivaLista(0);
    Fm_ListaEstoques.ChBx_Estoques.Enabled := True;
    Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Gb_Estoque;
  end
  else
  Begin
    Fm_ListaEstoques.ChBx_Estoques.Checked := False;
    Fm_ListaEstoques.ChBx_Estoques.Enabled := False;
    Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Gb_Estoque;
    if Trim(Fm_LME.Dblcb_Lista.Text)<> '' then
      Fm_ListaEstoques.AtivaLista(Fm_LME.Dblcb_Lista.KeyValue)
    else
      Fm_ListaEstoques.AtivaLista(Gb_CodMha);
    Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Gb_Estoque;
  end;
  Sb_InclusaoRapida.visible := (CodigoPedido > 0);
  Sb_AlternaServico.Visible := (Fc_Tb_Geral('L','OSR_G_ATIVAR','S') = 'S');
  Pc_Monta_Grid;
//  Pc_Tabelas_Disponiveis;
  Pc_NomeLabel;
  Chb_Digitacao.Checked := (Fc_Aq_Geral('L','PESQUISA','DIGITACAO','') = 'S');
  Fm_ListaEstoques.AtivaLista(Gb_CodMha);
  Fm_ListaEstoques.Dblcb_Estoque.KeyValue :=Gb_Estoque;
  //Se os campos de pesquisa foram preenchidos executar pesquisa;
  if (Trim(E_BuscaCodigo.Text)<> '') or (Trim(E_BuscaDescricao.Text)<> '') then
    PC_Buscar; 
  if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
end;

procedure TFr_Pesq_Produto.Sb_ImagemClick(Sender: TObject);
Var
  Lc_Form : TFr_FotoProduto;
begin
  if validaexisteRegistro then
  begin
    Try
      Lc_Form := TFr_FotoProduto.Create(Fr_Pesq_Produto);
      Lc_Form.It_Cd_Produto := StrToIntDef(Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString, 0);
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
    End;
  end;
end;

procedure TFr_Pesq_Produto.Sb_InclusaoRapidaClick(Sender: TObject);
begin
  if validaexisteRegistro then
    InclusaoRapida;
end;

procedure TFr_Pesq_Produto.Label36Click(Sender: TObject);
begin
   Pnl_Observacao.Visible := False;
end;

procedure TFr_Pesq_Produto.Sb_AplicacaoClick(Sender: TObject);
begin
  if validaexisteRegistro then
  Begin
    Pnl_Observacao.Visible := True;
    MM_Observacao.Text := Qr_Pesquisa.FieldByName('PRO_APLICACAO').AsString;
  End;
end;

procedure TFr_Pesq_Produto.Qr_TabelaAfterOpen(DataSet: TDataSet);
begin
   Qr_Tabela.FetchAll;
end;

procedure TFr_Pesq_Produto.Dblcb_TabelasClick(Sender: TObject);
begin
  PC_Buscar;
end;

procedure TFr_Pesq_Produto.Qr_PesquisaAfterOpen(DataSet: TDataSet);
begin
  Qr_Tabela.FetchAll;
  Pc_FormataCasas;
end;

procedure TFr_Pesq_Produto.Pc_FormataCasas;
begin
  if (Qr_Pesquisa.Active = True) then
    begin
    (Qr_Pesquisa.FieldByName('PRC_VL_NORMAL') as TNumericField).DisplayFormat     := Gb_Casa_Dec_Venda;
    (Qr_Pesquisa.FieldByName('PRC_VL_PROMOCAO') as TNumericField).DisplayFormat := Gb_Casa_Dec_Venda;
    (Qr_Pesquisa.FieldByName('PRC_VL_INSTALADO') as TNumericField).DisplayFormat := Gb_Casa_Dec_Venda;
    (Qr_Pesquisa.FieldByName('PRC_VL_ESPECIAL') as TNumericField).DisplayFormat := Gb_Casa_Dec_Venda;
    (Qr_Pesquisa.FieldByName('PRO_VL_INSTALA') as TNumericField).DisplayFormat := Gb_Casa_Dec_Venda;
    (Qr_Pesquisa.FieldByName('PRO_VL_CUSTO') as TNumericField).DisplayFormat := Gb_Casa_Dec_Compra;
    (Qr_Pesquisa.FieldByName('EST_QTDE') as TNumericField).DisplayFormat := '0.######';
    (Qr_Pesquisa.FieldByName('PRC_QTDE') as TNumericField).DisplayFormat := '0.######';
    end;
end;


procedure TFr_Pesq_Produto.Sb_CancelaClick(Sender: TObject);
begin
  Pn_Config.Visible := False;
end;

procedure TFr_Pesq_Produto.Configurao1Click(Sender: TObject);
Var
  Lc_Form :TFr_Liberacao;
begin
  if (Gb_Nivel = 1) OR Gb_Liberado then
  begin
    Pc_Monta_PainelConfig;
    Pn_Config.Visible := True;
  end
  else
  begin
    Gb_Liberado := False;
    try
      Lc_Form := TFr_Liberacao.Create(Self);
      Lc_Form.Liberado := False;
      Lc_Form.It_Interface := 'Fr_Produtos';
      Lc_Form.It_Nome_Menu := 'Cadastro Produtos';
      Lc_Form.It_Privilegio := 'AUTORIZAR';
      Lc_Form.ShowModal;
    finally
      FreeAndNil(Lc_Form);
    end;
  end;
end;

procedure TFr_Pesq_Produto.Copiardescriodoproduto1Click(Sender: TObject);
begin
  Clipboard.AsText := Qr_PesquisaPRO_DESCRICAO.AsString;
end;

procedure TFr_Pesq_Produto.Sb_ConfirmaClick(Sender: TObject);
begin
  Pn_Config.Visible := False;
  Pc_Grava_Confir_Configuracao;
  Pc_Monta_Grid;
end;
procedure TFr_Pesq_Produto.Grd_PesquisaTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(Grd_Pesquisa, Column);
end;

procedure TFr_Pesq_Produto.InclusaoRapida;
begin
  if self.It_Pedido_Vda then
  Begin
    InclusaoRapidaPedido
  End;
  if self.It_Cotacao_Vda then
  Begin
    InclusaoRapidaCotacao
  End;
end;

procedure TFr_Pesq_Produto.InclusaoRapidaCotacao;
Var
  Lc_Form : TFr_InclusaoRapidaProdutoQtde;
begin
  TRy
    Lc_Form := TFr_InclusaoRapidaProdutoQtde.create(Self);
    Lc_Form.e_Descricao.Text := Qr_PesquisaPRO_DESCRICAO.AsString;
    with Lc_Form.Cotacao do
    Begin
      Lc_Form.It_Cotacao_Vda  := self.It_Cotacao_Vda;
      Registro.Cotacao        := CodigoCotacao;
      Registro.Tipo           := 'P';
      Registro.Vinculo        := Qr_PesquisaPRO_CODIGO.asInteger;
      Registro.DEscricao      := Qr_PesquisaPRO_DESCRICAO.AsString;
      Registro.Quantidade     := 0;
      Registro.ValorUnitario  := Qr_PesquisaPRC_VL_NORMAL.AsCurrency;
      Registro.Disponivel     := 'S';
      Registro.AliqComissao   := 0;
      Registro.ValorDEsc      := 0;
      Registro.ALiqDesc       := 0;
      Registro.AliqIPI        := 0;
      Registro.AliqICMS       := 0;
      if Fm_ListaEstoques.Dblcb_Estoque.Text <> '' then
        Registro.CodigoEstoque  := Fm_ListaEstoques.Dblcb_Estoque.KeyValue
      else
        Registro.CodigoEstoque  := Gb_Estoque;
      if Dblcb_Tabelas.Text <> '' then
        Registro.TabelaPreco  := Dblcb_Tabelas.KeyValue
      else
        Registro.TabelaPreco  := It_Cd_Tabela;
      Registro.ValorCusto     := Qr_PesquisaPRO_VL_CUSTO.AsCurrency;
      Registro.MargemLucro    := 0;
    End;
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
  End;

end;

procedure TFr_Pesq_Produto.InclusaoRapidaPedido;
Var
  Lc_Form : TFr_InclusaoRapidaProdutoQtde;
begin
  TRy
    Lc_Form := TFr_InclusaoRapidaProdutoQtde.create(Self);
    Lc_Form.e_Descricao.Text := Qr_PesquisaPRO_DESCRICAO.AsString;
    with Lc_Form.Venda.Registro do
    Begin
      Lc_Form.It_Pedido_Vda := self.It_Pedido_Vda;
      CodigoPedido  := Self.CodigoPedido;
      CodigoProduto := Qr_PesquisaPRO_CODIGO.asInteger;
      ValorCusto    := Qr_PesquisaPRO_VL_CUSTO.AsCurrency;
      ValorUnitario := Qr_PesquisaPRC_VL_NORMAL.AsCurrency;
      AliqDesconto  := 0;
      ValorDesconto := 0;
      AliqComissao  := 0;
      Operacao      := 'V';
      Estoque       := 'S';
      Despachar     := 'S';
      AliqIPI       := 0;
      AliqICMS      := 0;
      if Fm_ListaEstoques.Dblcb_Estoque.Text <> '' then
        CodigoEstoque := Fm_ListaEstoques.Dblcb_Estoque.KeyValue
      else
        CodigoEstoque := Gb_Estoque;
      if Dblcb_Tabelas.Text <> '' then
        CodigoTabela  := Dblcb_Tabelas.KeyValue
      else
        CodigoTabela  := It_Cd_Tabela;
      Largura       := 0;
      Altura        := 0;
      NumeroPecas   := 0;
    End;
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
  End;

end;

procedure TFr_Pesq_Produto.Fm_ListaEstoquesDblcb_EstoqueClick(Sender: TObject);
begin
  PC_Buscar;
end;

procedure TFr_Pesq_Produto.FormActivate(Sender: TObject);
begin
  if Assigned(Fr_Liberacao) then
    Fr_Liberacao.BringToFront;
end;

procedure TFr_Pesq_Produto.Grd_PesquisaCellClick(Column: TColumn);
begin
  if ChBx_Imagem.Checked then
    Begin
    if (Qr_Pesquisa.FieldByName('IMG_PRODUTO').AsInteger > 0) then
      Sb_Imagem.Enabled:= true
    else
      Sb_Imagem.Enabled:= False;
      
    end;
end;



procedure TFr_Pesq_Produto.Pc_Grava_Grid;
var
Lc_I:Integer;
lc_boolean:STRING;
begin
  for Lc_I:= 0 to Grd_Pesquisa.Columns.Count -1 do
  begin
    if Grd_Pesquisa.Columns[Lc_I].Visible = true then
      lc_boolean:= 'S'
   else
      lc_boolean:= 'N';
    Pc_Grava_Campo_Grid(Grd_Pesquisa.Columns[LC_I].FieldName, Grd_Pesquisa.Columns[Lc_I].Title.Caption,Gb_Cd_Usuario,Grd_Pesquisa.Columns[Lc_I].Width,Grd_Pesquisa.Columns[Lc_I].Index,lc_boolean);
  end;
end;

procedure TFr_Pesq_Produto.Pc_Grava_Campo_Grid(Pc_Campo: String;Pc_lABEL:String;Pc_Usuario: Integer;Pc_largura:Integer;Pc_posicao:Integer;PC_visible:String);
var
  I: Integer;
begin
  CfgGrid.Registro.Usuario  := Gb_Cd_Usuario;
  CfgGrid.Registro.Legenda  := Pc_lABEL;
  CfgGrid.getByUsuarioLabel;

  CfgGrid.Registro.Usuario  := Gb_Cd_Usuario;
  CfgGrid.Registro.Campo          := Pc_Campo;
  CfgGrid.Registro.legenda          := Pc_lABEL;
  CfgGrid.Registro.Largura        := Pc_Largura;
  CfgGrid.Registro.Posicao        := Pc_Posicao;
  CfgGrid.Registro.Visivel        := Pc_Visible;
  if CfgGrid.exist then
    CfgGrid.Update
  else
    CfgGrid.insert;

end;

procedure TFr_Pesq_Produto.Pc_Monta_Grid_Padrao;
Begin
  Sb_Limpa_ConfigClick(Self);
  Chbx_Visualizar.Checked[0] := true;
  Chbx_Visualizar.Checked[4] := true;
  Chbx_Visualizar.Checked[13]:= true;
  Chbx_Visualizar.Checked[16] := true;
  Pc_Grava_Confir_Configuracao;
  Pc_Monta_Grid;
end;

procedure TFr_Pesq_Produto.Pc_Monta_Grid;
VAR
  Lc_I: Integer;
  LC_VISIBLE:Boolean;
  LC_LARGURA:Integer;
begin
  CfgGrid.loadByUsuario(Gb_Cd_Usuario, 1);
  Grd_Pesquisa.Columns.Clear;

  IF CfgGrid.Lista.Count = 0 then
  Begin
    Pc_Monta_Grid_Padrao;
    exit;
  end;

  for Lc_I := 0 to CfgGrid.Lista.Count - 1 do
  BEGIN
    Grd_Pesquisa.Columns.Add;
    with CfgGrid.Lista[Lc_I] do
    Begin
      IF Visivel = 'S' THEN
        LC_VISIBLE:=True
      ELSE
        LC_VISIBLE:= FALSE;

      LC_LARGURA:= Largura;

      if (Campo = 'PRC_VL_NORMAL') then
        It_Col_VL_Normal := Posicao;

      if (Campo = 'PRC_VL_PROMOCAO') then
        It_Col_VL_Promocao := Posicao;

      Grd_Pesquisa.Columns[Posicao].Visible        := LC_VISIBLE;
      Grd_Pesquisa.Columns[Posicao].Width          := LC_LARGURA;
      Grd_Pesquisa.Columns[Posicao].FieldName      := Campo;
      Grd_Pesquisa.Columns[Posicao].Title.Caption  := Legenda;
    End;
  END;
end;


procedure TFr_Pesq_Produto.Pc_Grava_Confir_Configuracao;
var
  LC_LARGURA,Lc_I:Integer;
  LC_NOME_CAMPO,lc_boolean:STRING;
begin
  for Lc_I:= 0 to Chbx_Visualizar.Count -1 do
    begin
    IF (Lc_I = 0) OR(Lc_I = 5)OR (Lc_I =7) THEN
      LC_LARGURA:=64
    ELSE
    IF (Lc_I = 1) OR(Lc_I = 3)OR (Lc_I =9) THEN
      LC_LARGURA:=304
    ELSE
    IF (Lc_I = 4) OR(Lc_I = 6)OR (Lc_I =8) OR (lC_I=10)THEN
      LC_LARGURA:=604
    ELSE
      LC_LARGURA:=80;

    //PEGA NOME DO CAMPO
    IF (Lc_I = 0) THEN LC_NOME_CAMPO := 'PRO_CODIGO'       ELSE
    IF (Lc_I = 1) THEN LC_NOME_CAMPO := 'PRO_CODIGOFAB'    ELSE
    IF (Lc_I = 2) THEN LC_NOME_CAMPO := 'PRO_CODIGOBAR'    ELSE
    IF (Lc_I = 3) THEN LC_NOME_CAMPO := 'PRO_CODIGOFOR'    ELSE
    IF (Lc_I = 4) THEN LC_NOME_CAMPO := 'PRO_DESCRICAO'    ELSE
    IF (Lc_I = 5) THEN LC_NOME_CAMPO := 'MED_ABREVIATURA'  ELSE
    IF (Lc_I = 6) THEN LC_NOME_CAMPO := 'GRP_DESCRICAO'    ELSE
    IF (Lc_I = 7) THEN LC_NOME_CAMPO := 'SBG_DESCRICAO'    ELSE
    IF (Lc_I = 8) THEN LC_NOME_CAMPO := 'MRC_DESCRICAO'    ELSE
    IF (Lc_I = 9) THEN LC_NOME_CAMPO := 'PRO_APLICACAO'    ELSE
    IF (Lc_I = 10)THEN LC_NOME_CAMPO := 'PRO_LOCAL'        ELSE
    IF (Lc_I = 11)THEN LC_NOME_CAMPO := 'PRO_VL_CUSTO'     ELSE
    IF (Lc_I = 12) THEN LC_NOME_CAMPO := 'PRO_VL_INSTALA'  ELSE
    IF (Lc_I = 13) THEN LC_NOME_CAMPO := 'EST_QTDE'        ELSE
    IF (Lc_I = 14) THEN LC_NOME_CAMPO := 'PRC_QTDE'        ELSE
    IF (Lc_I = 15) THEN LC_NOME_CAMPO := 'PRC_VL_PROMOCAO' ELSE
    IF (Lc_I = 16) THEN LC_NOME_CAMPO := 'PRC_VL_NORMAL'   ELSE
    IF (Lc_I = 17) THEN LC_NOME_CAMPO := 'PRC_VL_INSTALADO' ELSE
    IF (Lc_I = 18) THEN LC_NOME_CAMPO := 'PRC_VL_ESPECIAL';

    if Chbx_Visualizar.Checked[Lc_I] = true then
      lc_boolean:= 'S'
   else
      lc_boolean:= 'N';
    Pc_Grava_Campo_Grid(LC_NOME_CAMPO,Chbx_Visualizar.Items[LC_I], Gb_Cd_Usuario,LC_LARGURA,Lc_I,lc_boolean);
  end;
end;

procedure TFr_Pesq_Produto.Pc_Monta_PainelConfig;
var
  lc_I:Integer;
begin
  for lc_I:= 0 to Chbx_Visualizar.Count -1 do
  begin
    CfgGrid.Registro.Usuario  := Gb_Cd_Usuario;
    CfgGrid.Registro.Legenda  := Chbx_Visualizar.Items.Strings[Lc_I];
    CfgGrid.getByUsuarioLabel;
    if CfgGrid.exist then
    Begin
      IF CfgGrid.Registro.Visivel = 'S' THEN
        Chbx_Visualizar.Checked[lc_I] :=TRUE
      else
        Chbx_Visualizar.Checked[lc_I] :=False;
    End
    else
      Chbx_Visualizar.Checked[lc_I] := False;
  end;
end;

procedure TFr_Pesq_Produto.Sb_Limpa_ConfigClick(Sender: TObject);
begin
  CfgGrid.deleteByUsuario(Gb_Cd_Usuario);
end;

procedure TFr_Pesq_Produto.Chb_DigitacaoClick(Sender: TObject);
begin
  if Chb_Digitacao.Checked then Fc_Aq_Geral('G','PESQUISA','DIGITACAO','S') else Fc_Aq_Geral('G','PESQUISA','DIGITACAO','N');
end;

procedure TFr_Pesq_Produto.Pc_NomeLabel;
begin
  if Fc_Tb_Geral('L','PRO_G_LABEL_PRO','') = 'S' then
    begin
    Lb_Codigo.Caption:='Códgos (Chassi./ Renavan.)';
    lbl_cd_barra.Caption:= 'Placa';
    end
  else
    begin
    Lb_Codigo.Caption:='Códgos (Interno / Fab./ Forn.)';
    lbl_cd_barra.Caption:= 'Código de Barras';
    end
end;

procedure TFr_Pesq_Produto.Grd_PesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13)   then
    begin
    Key := #0;
    if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
    end;
end;

procedure TFr_Pesq_Produto.Grd_PesquisaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Font.Color := clBlack;
  TDBGrid(Sender).Canvas.Font.Style := [];
  if TDBGrid(Sender).DataSource.DataSet.FieldByName('EST_QTDE').AsFloat <= 0 then
  Begin
    TDBGrid(Sender).Canvas.Font.Color := clRed;
  end
  else
  Begin
    if TDBGrid(Sender).DataSource.DataSet.FieldByName('PRO_CAMPANHA').AsString = 'S' then
    Begin
      IF (DataCol = It_Col_VL_Normal) then
        TDBGrid(Sender).Canvas.Font.Style := [fsStrikeOut];
      if (not(State = [gdSelected]))  then
        TDBGrid(Sender).Canvas.Font.Color := clNavy
      else
        TDBGrid(Sender).Canvas.Font.Color := clBlack;
    end;
  end;

  try
    TDBGrid(Sender).Canvas.FillRect(Rect);
    TDBGrid(Sender).Canvas.TextOut(Rect.Left+2,Rect.Top,Column.Field.AsString);
    TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
  except
    Sb_Limpa_ConfigClick(Sender);
    Pc_Monta_Grid_Padrao;
  end;
end;

procedure TFr_Pesq_Produto.Qr_PesquisaCalcFields(DataSet: TDataSet);
begin
  WITH Qr_Pesquisa do
  Begin
    FieldByName('PRC_VL_INSTALADO').AsCurrency:= 0;
    FieldByName('PRC_VL_ESPECIAL').AsCurrency:= 0;
//    FieldByName('PRC_VL_PROMOCAO').AsFloat := 0;
//    if FieldByName('PRO_CAMPANHA').AsString = 'N' then FieldByName('PRC_VL_PROMOCAO').AsFloat := 0;
    IF (FieldByName('PRO_CAMPANHA').AsString = 'S') AND (FieldByName('PRC_VL_PROMOCAO').AsCurrency > 0 )  then
    Begin
      FieldByName('PRC_VL_INSTALADO').AsCurrency:= FieldByName('PRC_VL_PROMOCAO').AsCurrency + FieldByName('PRO_VL_INSTALA').AsCurrency;
    end
    else
    Begin

      FieldByName('PRC_VL_INSTALADO').AsCurrency:= FieldByName('PRC_VL_NORMAL').AsCurrency + FieldByName('PRO_VL_INSTALA').AsCurrency;
    end;
    if (It_MultiplicadorPreco <> 1) then
      FieldByName('PRC_VL_ESPECIAL').AsCurrency:= FieldByName('PRC_VL_NORMAL').AsCurrency * It_MultiplicadorPreco
  end;
end;



procedure TFr_Pesq_Produto.Dblcb_Mha_EmpresaClick(Sender: TObject);
begin
  Fm_ListaEstoques.AtivaLista(DM.Qr_Estabelecimento.FieldByname('EMP_CODIGO').AsInteger);
end;

procedure TFr_Pesq_Produto.Dblcb_EstoqueClick(Sender: TObject);
begin
  PC_Buscar;
end;

procedure TFr_Pesq_Produto.Grd_PesquisaDblClick(Sender: TObject);
begin
  if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
end;

procedure TFr_Pesq_Produto.Sb_ProdutosClick(Sender: TObject);
Var
  Lc_Form : TFr_Produtos;
begin
  if Fc_VerificaPermissao('Fr_Produtos','Cadastro de Produtos','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Try
      Lc_Form := TFr_Produtos.Create(Self);
      if Qr_Pesquisa.Active  then
        Lc_Form.Produto.Registro.Codigo := Qr_Pesquisa.FieldByname('PRO_CODIGO').AsInteger
      else
        Lc_Form.Produto.Registro.Codigo := 0;
      Lc_Form.ShowModal;
    Finally
      FreeAndNil( Lc_Form );
    End;
  end;
end;

procedure TFr_Pesq_Produto.Sb_AlternaServicoClick(Sender: TObject);
begin
  If not Assigned(Fr_Pesq_Servico)then (Application.CreateForm(TFr_Pesq_Servico, Fr_Pesq_Servico));
  Fr_Pesq_Servico.Show;
  Fr_Pesq_Servico.BringToFront;
  Close;
end;

end.


