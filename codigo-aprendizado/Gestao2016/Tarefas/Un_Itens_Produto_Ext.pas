unit Un_Itens_Produto_Ext;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, ExtCtrls, Buttons, DB, StdCtrls, Mask, STStoredProc, ComCtrls, Grids, DBGrids, STQuery, ActnList, QEdit_Setes, System.Math, Actions, Un_Fm_ListaEstoques, ControllerCtrlEstoque;

type
   TFr_Itens_Produto_Ext = class(TForm)
    Qr_Pesquisa: TSTQuery;
    Ds_Pesquisa: TDataSource;
    AcaoMostra: TActionList;
    Action1: TAction;
    Qr_Preco_Qtde: TSTQuery;
    Qr_Preco_QtdePRC_CODIGO: TIntegerField;
    Qr_Preco_QtdePRC_VL_VDA: TFloatField;
    Qr_Preco_QtdePRC_QT_MIN: TBCDField;
    Qr_Preco_QtdePRO_CAMPANHA: TStringField;
    Action2: TAction;
    Qr_Acao: TSTQuery;
    Panel1: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    lb_Aq_com: TLabel;
    Lb_DescricaoProduto: TLabel;
    Label2: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Lb_Tipo: TLabel;
    Lb_CustoUnitario: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Sb_Corte: TSpeedButton;
    SB_Gravar: TBitBtn;
    Sb_Sair_0: TBitBtn;
    E_CodPro: TEdit;
    E_Qt_Produto: TEdit_Setes;
    E_Vl_Unitario: TEdit_Setes;
    E_Aq_IPI: TEdit_Setes;
    E_Aq_Com: TEdit_Setes;
    E_Descricao: TEdit;
    E_Unidade: TEdit;
    E_VL_Desconto: TEdit_Setes;
    E_Aq_Desconto: TEdit_Setes;
    E_CustoUnitario: TEdit_Setes;
    E_Aq_Icms: TEdit_Setes;
    Chbx_Estoque: TCheckBox;
    Dblcb_Tabelas: TDBLookupComboBox;
    Sb_Limpar: TBitBtn;
    E_VL_Produto: TPanel;
    E_Vl_SubTotal: TPanel;
    E_Qtde_Disp: TPanel;
    Ds_Tabela: TDataSource;
    Qr_Tabela: TSTQuery;
    Qr_TabelaTPR_CODIGO: TIntegerField;
    Qr_TabelaTPR_CODEMP: TIntegerField;
    Qr_TabelaTPR_NOME: TStringField;
    Qr_TabelaTPR_VALIDADE: TDateField;
    Fm_ListaEstoques: TFm_ListaEstoques;
    Sb_Pesquisar: TBitBtn;
    procedure SB_GravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure E_Vl_UnitarioExit(Sender: TObject);
    procedure E_Qt_ProdutoExit(Sender: TObject);
    procedure E_Aq_IPIExit(Sender: TObject);
    procedure E_CodProExit(Sender: TObject);
    procedure E_Vl_UnitarioEnter(Sender: TObject);
    procedure E_Qt_ProdutoEnter(Sender: TObject);
    procedure E_Aq_ComEnter(Sender: TObject);
    procedure E_CodProEnter(Sender: TObject);
    procedure E_DescricaoEnter(Sender: TObject);
    procedure E_Aq_DescontoExit(Sender: TObject);
    procedure E_VL_DescontoExit(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Qr_TabelaAfterOpen(DataSet: TDataSet);
    procedure Dblcb_TabelasClick(Sender: TObject);
    procedure E_CustoUnitarioExit(Sender: TObject);
    procedure Sb_LimparClick(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure E_UnidadeEnter(Sender: TObject);
    procedure E_Aq_DescontoEnter(Sender: TObject);
    procedure E_VL_DescontoEnter(Sender: TObject);
    procedure E_Aq_IPIEnter(Sender: TObject);
    procedure E_Aq_IcmsEnter(Sender: TObject);
    procedure Sb_CorteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_PesquisarClick(Sender: TObject);
    procedure E_DescricaoExit(Sender: TObject);
    procedure Sb_PesquisarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SB_GravarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Sb_Sair_0MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
   private
    { Private declarations }
    It_Casa_Decimal : String;
   public
    { Public declarations }
      It_MultiplicadorPreco: Currency;
      It_Pes_cod_barra:String;
      It_ITF_ESTOQUE: string;
      It_Dt_Operacao : Tdate;

      It_Inserir: Boolean;
      it_Cd_Empresa: integer;
      It_Cd_Pedido: Integer;
      It_Cd_Itens: Integer;
      It_Cd_Produto: Integer;
      It_Disponivel: string;
      It_Cd_Vendedor:Integer;
      //TOTALIZADORES
      It_Vl_Campanha: Currency;
      It_Aliq_Comissao: Currency;
      It_Qt_Produto: Real;
      It_VL_Unitario: Currency;
      It_VL_Produto: Currency;
      It_Vl_Subtotal: Currency;
      it_Modalidade_preco:string;

      It_VL_bs_Icms: Currency;
      It_Aq_IPI: Real;
      It_Vl_IPI:Currency;
      It_Aq_icms: Real;
      It_Vl_Icms: Currency;
      It_StateChange: Integer;
      IT_VL_Ant, It_Vl_Atual: Real;
      It_Composicao: Integer;
      it_bt_pesquisa:Boolean;
      CtrlEstoque : TControllerCtrlEstoque;
      Function FC_Buscar(Pc_Tipo: char; Pc_Cd_Tabela:Integer; Pc_Codigo: string; Pc_Descricao: string):Integer;
      function FC_DefineTabela(Pc_Cd_Tabela : Integer):Integer;
      Procedure PC_Busca_Preco_Qtde(Pc_Cd_Tabela,Pc_Cd_Produto :Integer);
      Procedure PC_Verifica_Preco_Qtde(Pc_Cd_Tabela :Integer;Pc_Qt_Produto:Real);
      procedure Pc_MostraBusca;
      PROcedure Pc_Tip_Busca(Pc_Tipo:char; Pc_cd_Tabela :Integer; Pc_cd_Prod:String; Pc_Desc_prod:String);
      procedure Pc_PreencheTela(Pc_Cd_Tabela : Integer;
      Pc_Codpro: string;
                                Pc_DESCRICAO: string;
                                Pc_VL_Venda: Real;
                                Pc_Custo: Real;
                                Pc_Unidade: string;
                                Pc_Aliq_Com: Real;
                                Pc_Qtde: Real;
                                Pc_Composicao:Integer;
                                Pc_Subs_Trib:String);
      procedure Pc_MostraSaldo;
      function Fc_ValidaCampos(): Boolean;
      function Fc_ProduraIPI(fc_cd_Produto: string): Real;
      procedure Pc_Totalizador;
      procedure Pc_LimpaCampos;
//------------------------------------------------------------------------------
      procedure Pc_FormataTela;
      procedure Pc_IniciaVariaveis;
      procedure Pc_InserirNovoItem;

      procedure Pc_InserecomposicaoVenda(Pc_Cd_Produto: Integer);
      function Fc_ExisteItemNoPedido(Pc_Tp_Operacao:String): Boolean;

      procedure Pc_GravaItemVenda;

      function Fc_Busca_Cod_barra(Pc_cod_barra:String): Integer;
      procedure Pc_StateChange(Pc_Tipo: integer);

      function Fc_Preco_Campanha(Fc_Cd_Produto : Integer):real;
      procedure Pc_Tabelas_Disponiveis(Pc_Cd_preco:integer);//0 se a qtdade for = ou > do q a qtd tabela preco na promocao senao passa 2(se nao possui a quantidade minina a promocao nao e necessario mostra promocao
      Function  Fc_Aliquota_Comissao(fc_cd_vendedor, fc_Cd_TabelaPreco,Fc_Cd_Produto:Integer):Double;
      procedure Pc_DefineCasaDecimalLocal;
   end;

var
   Fr_Itens_Produto_Ext: TFr_Itens_Produto_Ext;

implementation

uses     Un_DM, Un_Msg, UN_Sistema, UN_Principal, env, Un_Pesq_Produto, Un_Fc_Sored_Procedures, Un_Liberacao, Un_Corte_Chapa, Un_Regra_Negocio, RN_Estoque, RN_Produto, Un_WebService, RN_Lotes;
{$R *.dfm}


procedure TFr_Itens_Produto_Ext.Pc_Tabelas_Disponiveis(Pc_Cd_preco:integer);
Var
 Lc_SqlTxt : String;
Begin
  Lc_SqlTxt := 'SELECT * FROM TB_TABELA_PRECO TP ' +
               'WHERE (TPR_CODIGO is not null) '+
               ' and (TPR_CODIGO <>:TPR_CODIGO) '+
               ' AND ( TPR_ATIVA = ''S'') ';

  //Trata telas de Venda
  if (Fc_Tb_Geral('L','VDA_G_CTRL_TABELA_X_PRAZO','') = 'S') then
  Begin
    if it_Modalidade_preco <> 'A' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ((TPR_MODALIDADE = '''+ it_Modalidade_preco + ''') OR (TPR_MODALIDADE = ''A'')) ';
  end;

  with Qr_Tabela do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(Lc_SqlTxt  + ' ORDER BY TPR_PRINCIPAL DESC');
    ParamByName('TPR_CODIGO').AsInteger := Pc_Cd_preco;
    Open;
    Dblcb_Tabelas.KeyValue := FieldByName('TPR_CODIGO').AsInteger
  end;
end;

function TFr_Itens_Produto_Ext.Fc_Preco_Campanha(Fc_Cd_Produto : Integer):real;
var
   Lc_Qry: TSTQuery;
   Lc_SqlTxt: string;
   Lc_Qtde: Real;
Begin
  //Cria a Consulta de Estoques Disponiveis
  Lc_Qry := TSTQuery.Create(Self);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT PRC_VL_VDA,PRC_AQ_COM ' +
                ' FROM TB_PRECO Tb_preco ' +
                ' WHERE (PRC_CODPRO=:PRC_CODPRO) AND (PRC_CODTPR=:PRC_CODTPR) ';
    SQL.Add(Lc_SqlTxt);
    Active := False;
    ParamByName('PRC_CODPRO').AsInteger := fc_cd_Produto;
    ParamByName('PRC_CODTPR').AsInteger := 2;
    Active := True;
    FetchAll;
    First;
    if not IsEmpty then
      Begin
      It_Vl_Campanha := FieldByName('PRC_VL_VDA').AsCurrency;
      end
    else
      Begin
      It_Vl_Campanha := 0;
      end;
    end;
  Lc_Qry.close;
  FreeandNil(Lc_Qry);      
end;


function TFr_Itens_Produto_Ext.Fc_ProduraIPI(fc_cd_Produto: string): Real;
var
   Lc_Qry: TSTQuery;
   Lc_SqlTxt: string;
   Lc_Qtde: Real;
Begin
  //Cria a Consulta de Estoques Disponiveis
   Lc_Qry := TSTQuery.Create(Self);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT TRB_AQ_IPI ' +
                 ' FROM TB_TRIBUTACAO Tb_tributacao ' +
                ' WHERE (TRB_CODPRO=:PRO_CODIGO) and (TRB_CODMHA=:TRB_CODMHA) '+
                'ORDER BY TRB_AQ_IPI  DESC ';
    SQL.Add(Lc_SqlTxt);
    Active := False;
    ParamByName('PRO_CODIGO').AsString := fc_cd_Produto;
    ParamByName('TRB_CODMHA').AsInteger := Gb_CodMha;
    Active := True;
    FetchAll;
    First;
    if not IsEmpty then
      Result := FieldByName('TRB_AQ_IPI').AsCurrency
    else
      Result := 0;
    end;
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
end;

function TFr_Itens_Produto_Ext.Fc_ExisteItemNoPedido(Pc_Tp_Operacao:String): Boolean;
var
   Lc_Qry: TSTQuery;
   Lc_SqlTxt: string;
   Lc_Qtde: Real;
   Lc_Escolha: Integer;
Begin
  Result := True;
  //Cria a Consulta de Estoques Disponiveis
  Lc_Qry := TSTQuery.Create(Self);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    Active := False;
    SQL.Clear;
    Lc_SqlTxt :=  'SELECT PRO_CODIGO, ITF_QTDE, ITF_CODIGO ' +
                  ' FROM TB_ITENS_NFL Tb_itens_nfl ' +
                  '    INNER JOIN TB_PRODUTO Tb_produto ' +
                  '    ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO) ' +
                  ' WHERE PRO_CODIGO=:PRO_CODIGO AND (ITF_CODPED=:ITF_CODPED) and (ITF_OPER=:ITF_OPER) ';
    SQL.Add(Lc_SqlTxt);
    Active := False;
    ParamByName('ITF_OPER').AsString := Pc_Tp_Operacao;
    ParamByName('ITF_CODPED').AsInteger := It_Cd_Pedido;
    ParamByName('PRO_CODIGO').AsInteger := It_Cd_Produto;
    Active := True;
    FetchAll;
    First;
    if (RecordCount > 0) and (It_StateChange = 2) then
      Begin
       Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                     'O Produto ' + E_Descricao.Text + ' já está no relação.' + EOLN + EOLN +
                                     'O que deseja fazer ?',
                                     ['Atualizar', 'Inserir','Cancelar'], [bNormal,bNormal, bEscape], mpConfirmacao, clBtnFace));
       case Lc_Escolha of
          0:Begin
            It_Cd_Itens := FieldByName('ITF_CODIGO').AsInteger;
            It_StateChange := 3;
            Lc_Qtde := StrToFloatDef(E_Qt_Produto.Text,1);
            E_Qt_Produto.Text := FloatToStrF(Lc_Qtde + FieldByName('ITF_QTDE').AsFloat, ffFixed, 10, 2);
            Result := true;
            end;
          1:Begin
            Result := True;
            end;
          2:Begin
            Result := False;
            end;
        end;
      end;
    end;
  Lc_Qry.close;
  FreeandNil(Lc_Qry);
end;



function TFr_Itens_Produto_Ext.FC_Buscar(Pc_Tipo: char; Pc_Cd_Tabela:Integer; Pc_Codigo: string; Pc_Descricao: string):Integer;
var
   Lc_SqlTxt: string;
   Lc_Codigo: boolean;
   Lc_Descricao: boolean;
   Lc_CodigoInteiro: Integer;
   Lc_Barras: Integer;
Begin
  Lc_SqlTxt := '';
  It_Cd_Produto := 0;
  Screen.Cursor := crHourGlass;
  Qr_Pesquisa.Close;
  Qr_Pesquisa.Sql.Clear;

  Lc_SqlTxt :=  'SELECT '+
                '   PRO_CODIGO, '+
                '   PRO_CODIGOFAB, '+
                '   PRO_CODIGOFOR, '+
                '   PRO_CODIGOBAR, '+
                '   PRO_DESCRICAO, '+
                '   PRO_VL_CUSTO,  '+
                '   MED_ABREVIATURA, '+
                '   PRO_CAMPANHA, '+
                '   PRO_ATIVO, '+
                '   PRO_COMPOSICAO, '+
                '   PRO_SUB_TRIB '+
                'FROM TB_PRODUTO tb_produto  '+
                '   INNER JOIN TB_MEDIDA MED '+
                '   ON  (MED.MED_CODIGO = tb_produto.PRO_CODMED)  '+
                '   INNER JOIN TB_ESTOQUE EST '+
                '   ON  (EST.EST_CODPRO = tb_produto.PRO_CODIGO)  '+
                'WHERE (PRO_CODIGO IS NOT NULL) AND (PRO_ATIVO = ''S'')  ';

  IF Trim(Fm_ListaEstoques.Dblcb_Estoque.Text)<>'' then
    Lc_SqlTxt :=  Lc_SqlTxt + 'AND (EST_CODETS =:EST_CODIGO) ';

  if Pc_Tipo = 'P' then
    Begin
    if Pc_Codigo = '' then    Lc_Codigo := False else  Lc_Codigo := True;
    Lc_CodigoInteiro := StrToIntDef(Pc_Codigo, 0);
    if Lc_Codigo THEN
      Begin
     //Verifica se é um numero ou se é alfa-numerico
     IF Lc_CodigoInteiro = 0 THEN
       Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO))'
     else
       Lc_Sqltxt := Lc_Sqltxt + 'AND (PRO_CODIGO =:PRO_CODIGO) ';
      end;

    if (Fc_Aq_Geral('L','PRODUTO','PRO_P_DISTG_PA_MP','S') = 'S') then
      Lc_SqlTxt := Lc_SqlTxt + ' and (PRO_TIPO = ''P'') '
    else
      Lc_SqlTxt := Lc_SqlTxt + ' and (PRO_TIPO <> ''S'') ';

    if not GB_ProdCompartilha then   Lc_SqlTxt := Lc_SqlTxt+ ' AND PRO_CODMHA = :PRO_CODMHA';
    end
  else
    Begin
    if Pc_Codigo = '' then    Lc_Codigo := False else  Lc_Codigo := True;
    if Pc_Descricao = '' then Lc_Descricao := False  else Lc_Descricao := True;

    Lc_CodigoInteiro := StrToIntDef(Pc_Codigo, 0);
    Lc_Barras := Length(Pc_Codigo);
    if Lc_Codigo THEN
      Begin
      //Verifica se a busca será pelo codigo Exato
      if (Fc_Aq_Geral('L', 'PRODUTO','PRO_P_COD_EXATO', 'S')='S') then
        Begin
        //Verifica se é um numero ou se é alfa-numerico
        IF Lc_CodigoInteiro = 0 THEN
           Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO))'
        else
           Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGO =:PRO_CODIGO) or (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO))';
        end
      else
        Begin
        //Verifica se é um numero ou se é alfa-numerico
        IF Lc_CodigoInteiro = 0 THEN
           Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE:PRO_CODIGO))'
        else
           Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGO LIKE :PRO_CODIGO) or (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO))';
        end;
      end;

    if Lc_Descricao then   Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

    if (Fc_Aq_Geral('L','PRODUTO','PRO_P_DISTG_PA_MP','S') = 'S') then
      Lc_SqlTxt := Lc_SqlTxt + ' and (PRO_TIPO = ''P'') '
    else
      Lc_SqlTxt := Lc_SqlTxt + ' and (PRO_TIPO <> ''S'') ';
  
     if not GB_ProdCompartilha  then   Lc_SqlTxt := Lc_SqlTxt+ ' AND PRO_CODMHA = :PRO_CODMHA';
    end;

  Qr_Pesquisa.SQL.Add(Lc_SqlTxt);

  //PASSAGEM de parametro

  IF Trim(Fm_ListaEstoques.Dblcb_Estoque.Text)<>'' then
    Qr_Pesquisa.ParamByName('EST_CODIGO').AsInteger := Fm_ListaEstoques.Dblcb_Estoque.KeyValue;

  if Lc_Codigo THEN
    Begin
    //Verifica se a busca será pelo codigo Exato
    if (Fc_Aq_Geral('L', 'PRODUTO','PRO_P_COD_EXATO', 'S')='S') then
      Begin
      Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := Pc_Codigo;
      end
    else
      Begin
      if Pc_Tipo = 'P' then
        Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := Pc_Codigo
      else
        Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := '%' + Pc_Codigo + '%';
      end;
    end;


  if Lc_Descricao THEN  Qr_Pesquisa.ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(Pc_Descricao,1,98) + '%';
  if not GB_ProdCompartilha  then  Qr_Pesquisa.ParamByName('PRO_CODMHA').AsInteger:=Gb_CodMha;

  Qr_Pesquisa.Active := True;
  Qr_Pesquisa.FetchAll;
  Result := Qr_Pesquisa.RecordCount;
  if Result = 1 THEN
    It_Cd_Produto:= Qr_Pesquisa.FIELDBYNAME('PRO_CODIGO').AsInteger;
end;

function TFr_Itens_Produto_Ext.FC_DefineTabela(Pc_Cd_Tabela : Integer):Integer;
Begin
  if Pc_Cd_Tabela > 2 then
    Begin
    Result := Pc_Cd_Tabela;
    end
  else
    Begin
    if (Qr_Pesquisa.FieldByName('PRO_CAMPANHA').AsString = 'N') then
      Begin
      Result := 1;
      end
    else
      Begin
      Pc_Tabelas_Disponiveis(0);
      Dblcb_Tabelas.KeyValue:=2;
      Result := 2;
      end;
  end;
end;

Procedure TFr_Itens_Produto_Ext.PC_Verifica_Preco_Qtde(Pc_Cd_Tabela :Integer;Pc_Qt_Produto:Real);
Begin
  Qr_Preco_Qtde.Active := False;
  Qr_Preco_Qtde.ParamByName('PRC_CODPRO').AsInteger := It_Cd_Produto;
  Qr_Preco_Qtde.ParamByName('PRC_CODTPR').AsInteger := 2;
  Qr_Preco_Qtde.Active := True;
  Qr_Preco_Qtde.FetchAll;
  Qr_Preco_Qtde.First;
  if ((StrToFloatDef(E_Qt_Produto.Text,1))>=Qr_Preco_QtdePRC_QT_MIN.AsCurrency)AND(Qr_Preco_QtdePRO_CAMPANHA.AsString = 'S') then
  Begin
    E_Vl_Unitario.Text := FormatFloat(It_Casa_Decimal, Qr_Preco_QtdePRC_VL_VDA.AsCurrency);
    Pc_Tabelas_Disponiveis(0);
    Dblcb_Tabelas.KeyValue:=2;
  end
  else
  Begin
    Pc_Tabelas_Disponiveis(2); 
    Qr_Preco_Qtde.Active := False;
    Qr_Preco_Qtde.ParamByName('PRC_CODPRO').AsInteger := It_Cd_Produto;
    Qr_Preco_Qtde.ParamByName('PRC_CODTPR').AsInteger := Dblcb_Tabelas.KeyValue;
    Qr_Preco_Qtde.Active := True;
    Qr_Preco_Qtde.FetchAll;
    Qr_Preco_Qtde.First;
    E_Vl_Unitario.Text := FormatFloat(It_Casa_Decimal, Qr_Preco_QtdePRC_VL_VDA.AsCurrency * It_MultiplicadorPreco);
  end;
end;

Procedure TFr_Itens_Produto_Ext.PC_Busca_Preco_Qtde(Pc_Cd_Tabela,Pc_Cd_Produto :Integer);
Var
  Lc_VL_Poduto: Real;
  Lc_Qt_Poduto: Real;
  Lc_Aq_Com: Real;
Begin
  Qr_Preco_Qtde.Active := False;
  Qr_Preco_Qtde.ParamByName('PRC_CODPRO').AsInteger := Pc_Cd_Produto;
  Qr_Preco_Qtde.ParamByName('PRC_CODTPR').AsInteger := Pc_Cd_Tabela;
  Qr_Preco_Qtde.Active := True;
  Qr_Preco_Qtde.FetchAll;
  Qr_Preco_Qtde.First;

end;


procedure TFr_Itens_Produto_Ext.Pc_PreencheTela(Pc_Cd_Tabela : Integer;
                                            Pc_Codpro: string;
                                            Pc_DESCRICAO: string;
                                            Pc_VL_Venda: Real;
                                            Pc_Custo: Real;
                                            Pc_Unidade: string;
                                            Pc_Aliq_Com: Real;
                                            Pc_Qtde: Real;
                                            Pc_Composicao:Integer;
                                            Pc_Subs_Trib:String);
var
   Lc_Codigo: integer;
Begin
  if (It_StateChange = 2) then
    Begin
    E_CodPro.Text := Pc_Codpro;
    E_Descricao.Text := COPY(Pc_DESCRICAO,1,100);
    end;
  //Informa se o produto tem substitução ou não 
  if Pc_Subs_Trib = 'S' then
    Lb_DescricaoProduto.Caption := 'Descrição do Produto - PRODUTO SUJEITO A SUBSTITUIÇÃO TRIBUTÁRIA '
  else
    Lb_DescricaoProduto.Caption := 'Descrição do Produto ';
    
  It_Composicao := Pc_Composicao;
  E_Vl_Unitario.Text := formatFloat(It_Casa_Decimal,Pc_VL_Venda);
  if (StrToFloatDEf(E_Vl_Unitario.Text,0) = 0) then
    Begin
    E_Qt_Produto.Text := formatFloat('0.###', Pc_Qtde);
    end;
  E_Unidade.Text := Pc_Unidade;
  E_Aq_Com.Text := FloatToStrF(Pc_Aliq_Com, ffFixed, 10, 2);
  IF StrtoFloatDef(E_Aq_IPI.Text,0) = 0 THEN
    Begin
    It_Aq_IPI := Fc_ProduraIPI(Pc_Codpro);
    E_Aq_IPI.Text := FloatToStrF(It_Aq_IPI, ffFixed, 10, 2);
    //Quando tem IPI refaz o Calculo inverso do Valor Unitário
    if (It_Aq_IPI >0) then
      Begin
      Pc_VL_Venda := Pc_VL_Venda / (1 + (It_Aq_IPI/100));
      E_Vl_Unitario.Text := formatFloat(It_Casa_Decimal,Pc_VL_Venda);
      end;
    end;
  if Pc_Qtde = 0 then Pc_Qtde := 1;
  E_Qt_Produto.Text := formatFloat('#,##0.##',Pc_Qtde);
  E_CustoUnitario.Text := FloatToStrF(Pc_Custo, ffFixed, 14, 6);

  if E_Vl_Unitario.CanFocus then E_Vl_Unitario.SetFocus;
  if (It_Pes_cod_barra = 'S') and E_Qt_Produto.CanFocus THEN
  if E_Qt_Produto.CanFocus then E_Qt_Produto.SetFocus;
  Pc_Totalizador;
end;

procedure TFr_Itens_Produto_Ext.Pc_MostraSaldo;
Var
  Lc_Qtde : real;
begin
  E_Qtde_Disp.ParentColor := False;
  E_Qtde_Disp.ParentFont := False;
  Lb_Tipo.Font.Color := clGreen;
  E_Qtde_Disp.Color := clGreen;
  if (It_Cd_Produto > 0) then
    Lc_Qtde := Fc_SaldoEstoque(StrToIntDef(E_CodPro.Text,0),Fm_ListaEstoques.Dblcb_Estoque.KeyValue);
  if (It_StateChange = 3) and (It_ITF_ESTOQUE = 'S')then
    Lc_Qtde := Lc_Qtde + (StrToFloatDef(E_Qt_Produto.Text,1));
  if (Lc_Qtde <= 0) and (trim(E_CodPro.Text) <> '') then
    Begin
    Lb_Tipo.Font.Color := clRed;
    E_Qtde_Disp.Color := clRed;
    end;
  E_Qtde_Disp.Caption := formatFloat('0.##',Lc_Qtde );
end;

procedure TFr_Itens_Produto_Ext.Pc_MostraBusca;
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  Lc_Form := TFr_Pesq_Produto.Create(Self);
  Lc_Form.it_Modalidade_preco := it_Modalidade_preco;
  Lc_Form.Pc_Tabelas_Disponiveis;
  Lc_Form.It_MultiplicadorPreco := It_MultiplicadorPreco;
  Lc_Form.E_BuscaCodigo.Text := E_CodPro.Text;
  Lc_Form.E_BuscaDescricao.Text := E_Descricao.Text;

  Lc_Form.It_Pedido_Vda := True;
  Lc_Form.It_Pedido_Dev := False;
  Lc_Form.It_Pedido_Tro := False;
  Lc_Form.It_Cotacao_Vda := False;
  Lc_Form.It_Cotacao_Cmv := False;
  Lc_Form.It_Pedido_Cpa := False;
  Lc_Form.It_Pedido_Ajt := False;

  Lc_Form.ShowModal;
  //Depois que Fecha o Relatorio
  if Lc_Form.It_Visualizar then
  Begin
    Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Lc_Form.Fm_ListaEstoques.Dblcb_Estoque.KeyValue;
    E_CodPro.Text:= Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
    E_Descricao.Text:='';
    E_Vl_Unitario.Text := '0';
    Pc_Tip_Busca('P',Lc_Form.Dblcb_Tabelas.KeyValue,Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,'');
    Pc_MostraSaldo;
  end;
  FreeAndNil(Lc_Form) ;
end;

procedure TFr_Itens_Produto_Ext.Pc_Totalizador;
Var
  Lc_Vl_aux : Real;
  Lc_Vl_Total : Real;
  Lc_Qt_aux : Real;
  Lc_VL_IPI : Real;
begin
  Lc_Vl_Total := 0;
  //Quanatidade PRodutos
  Lc_Qt_aux := StrToFloatDef(E_Qt_Produto.Text,1);
  E_Qt_Produto.Text := FormatFloat('0.00#', Lc_Qt_aux);
  //Valor dos Produtos
  Lc_Vl_aux := StrToFloatDef(E_Vl_Unitario.Text, 0);
  //Valor Subtotal Do Produto
  Lc_Vl_aux := Lc_Vl_aux * Lc_Qt_aux;
  E_VL_Produto.Caption := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Ipi
  Lc_Vl_aux := StrToFloatDef(E_Aq_IPI.Text, 0);
  Lc_VL_IPI := StrToFloatDef(E_VL_Produto.Caption, 0)  * (Lc_Vl_aux/100);
  E_Aq_IPI.Text := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Desconto
  Lc_Vl_aux := StrToFloatDef(E_VL_Desconto.Text, 0);
  E_VL_Desconto.Text := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Valor total
  Lc_Vl_aux := StrToFloatDef(E_VL_Produto.Caption,0);
  Lc_Vl_aux := Lc_Vl_aux + Lc_VL_IPI;
  Lc_Vl_aux := Lc_Vl_aux - StrToFloatDef(E_VL_Desconto.Text, 0);
  E_Vl_SubTotal.Caption := FloattoStrf(Lc_Vl_aux,ffFixed,10,2);

end;

procedure TFr_Itens_Produto_Ext.Pc_LimpaCampos;
Begin
  It_Cd_Itens := 0;
  It_Cd_Produto := 0;

  E_CodPro.Text := '';
  E_Descricao.Clear;
  E_Vl_Unitario.Text := '0,00';
  E_Qt_Produto.Text := '1';
  E_Vl_Produto.Caption := '0,00';
  E_Unidade.Clear;
  E_Aq_Com.Text := '0,00';
  E_Aq_Desconto.Text := '0,00';
  E_VL_Desconto.Text := '0,00';
  E_Aq_IPI.Text := '0,00';
  E_Aq_Icms.Text := '0,00';
  E_Vl_SubTotal.Caption := '0,00';
  E_Qtde_Disp.Caption := '0';
  E_CustoUnitario.Text := '0,00';
end;

function TFr_Itens_Produto_Ext.Fc_ValidaCampos(): Boolean;
Begin
  Result := true;
  IF (Trim(Fm_ListaEstoques.Dblcb_Estoque.Text) = '') then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Estoque é Obrigatório.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if Fm_ListaEstoques.Dblcb_Estoque.CanFocus then Fm_ListaEstoques.Dblcb_Estoque.SetFocus;
    Result := False;
    exit;
    end;

  IF (Trim(Dblcb_Tabelas.Text) = '')  then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Tabela de Preço É Obrigatório.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if Dblcb_Tabelas.CanFocus then Dblcb_Tabelas.SetFocus;
    Result := False;
    exit;
    end;


  IF ( (Trim(E_CodPro.Text) = '') or (Trim(E_CodPro.Text) = '0') ) then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Código do Produto É Obrigatório.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_CodPro.CanFocus then E_CodPro.SetFocus;
    Result := False;
    exit;
    end;

  IF (Trim(E_Descricao.Text) = '') then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Descrição do Produto É Obrigatório.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_CodPro.CanFocus then E_CodPro.SetFocus;
    Result := False;
    exit;
    end;

  IF (Trim(E_Vl_Unitario.Text) = '') or (StrToFloatDef(E_Vl_Unitario.Text,0) <= 0) then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Valor Unitário É Obrigatório e maior do que zero.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Vl_Unitario.CanFocus then E_Vl_Unitario.SetFocus;
    Result := False;
    exit;
    end;

  IF (Trim(E_Qt_Produto.Text) = '') or (StrToFloatDef(E_Qt_Produto.Text,0) <= 0)then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Quantidade É Obrigatório e maior do que zero.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Qt_Produto.CanFocus then E_Qt_Produto.SetFocus;
    Result := False;
    exit;
    end;

  IF not Fc_ValidaEscalaUnidadeProduto(It_Cd_Produto,StrToFloatDef(E_Qt_Produto.Text,0)) then
    Begin
    Result := False;
    exit;
    end;


  IF (Trim(E_Aq_Com.Text) = '') then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Comissão com conteúdo inválido.' + EOLN+
                   'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Aq_Com.CanFocus then E_Aq_Com.SetFocus;
    Result := False;
    exit;
    end;

  IF (Trim(E_Aq_Desconto.Text) = '') then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Alíquota de Desconto com conteúdo inválido.' + EOLN+
                   'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Aq_Desconto.CanFocus then E_Aq_Desconto.SetFocus;
    Result := False;
    exit;
    end;

  IF (Trim(E_VL_Desconto.Text) = '') then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Valor de Desconto com conteúdo inválido.' + EOLN+
                   'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_VL_Desconto.CanFocus then E_VL_Desconto.SetFocus;
    Result := False;
    exit;
    end;

  IF (Trim(E_Aq_IPI.Text) = '') then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Alíquota de IPI com conteúdo inválido.' + EOLN+
                   'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Aq_IPI.CanFocus then E_Aq_IPI.SetFocus;
    Result := False;
    exit;
    end;

  IF (Trim(E_Aq_Icms.Text) = '') then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Alíquota de ICMS com conteúdo inválido.' + EOLN+
                   'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Aq_Icms.CanFocus then E_Aq_Icms.SetFocus;
    Result := False;
    exit;
    end;

  if (Fc_Tb_Geral('L','VDA_G_PROMOCAO_QUANTIDADE','S') = 'S') then
    Begin
    if (StrToFloatDef(E_Qt_Produto.Text,0) < (Fc_Valida_Itens_QtdMIn(StrToInt64Def(E_CodPro.Text,0),Dblcb_Tabelas.KeyValue))) then
      Begin
      MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                     ' A quantidade informada inferior do que Permitida.' +  EOLN,
                     ['OK'], [bEscape], mpErro);
      if E_Qt_Produto.CanFocus then E_Qt_Produto.SetFocus;
      Result := False;
      exit;
      end;
    end;

  if (Fc_Tb_Geral('L','VDA_G_CTRL_EST_PEDIDO','N') = 'S') then
  Begin
    if (StrToFloatDef(E_Qtde_Disp.Caption,0) < StrToFloatDef(E_Qt_Produto.Text,0)) then
    Begin
      MensagemPadrao(' Mensagem ', ATENCAO + EOLN + EOLN +
                     ' Verifique que há uma configuração que impede ' +  EOLN+
                     ' a inclusão de itens sem saldo de estoque. ' +  EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result:=false;
      exit;
    end;
  end;
end;

procedure TFr_Itens_Produto_Ext.Pc_StateChange(Pc_Tipo: integer);
Begin
  It_StateChange := Pc_Tipo;
  case Pc_Tipo of
    2:Begin //Inserindo
      Fm_ListaEstoques.Dblcb_Estoque.Enabled := True;
      Dblcb_Tabelas.Enabled := True;
      E_CodPro.Enabled := True;
      E_Descricao.Enabled := True;
      E_Qt_Produto.Enabled := True;
      E_Aq_IPI.Enabled := True;
      SB_Gravar.Enabled := True;
      end;
    3:Begin //Alterando
      Fm_ListaEstoques.Dblcb_Estoque.Enabled := False;
      Dblcb_Tabelas.Enabled := False;
      E_CodPro.Enabled := False;
      E_Descricao.Enabled := False;
      E_Qt_Produto.Enabled := True;
      E_Aq_IPI.Enabled := True;
      SB_Gravar.Enabled := True;
      end;
   end;
end;




procedure TFr_Itens_Produto_Ext.Pc_InserecomposicaoVenda(Pc_Cd_Produto:Integer);
var
  Lc_Qr_Produtos: TSTQuery;
  Lc_SqlTxt: string;
  Lc_Vl_Unitario:real;
  Lc_Estoque : String;
  Lc_Cd_Item : Integer;
Begin
  if Chbx_Estoque.Checked then Lc_Estoque := 'S' else Lc_Estoque := 'N';
  Lc_Qr_Produtos := TSTQuery.Create(Self);
  with Lc_Qr_Produtos do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT '+
                  '   PRO_CODIGOFAB, '+
                  '   PRO_DESCRICAO, '+
                  '   PPD_QTDE, '+
                  '   PPD_CODPRO_D '+
                  'FROM TB_PRODUTO tb_produto '+
                  '   INNER JOIN TB_PROD_PROD tb_prod_prod '+
                  '   ON (tb_prod_prod.PPD_CODPRO_D = tb_produto.PRO_CODIGO) '+
                  'WHERE PPD_CODPRO_M=:PRO_CODIGO ';
    SQL.Add(Lc_SqlTxt);
    ParamByName('PRO_CODIGO').AsInteger := Pc_Cd_Produto;
    Active := True;
    FetchAll;
    if (RecordCount > 0) then
      Begin
      First;
      while not Eof do
        Begin
        PC_Busca_Preco_Qtde(Dblcb_Tabelas.KeyValue,FieldByname('PPD_CODPRO_D').AsInteger);
        Lc_Vl_Unitario := Qr_Preco_QtdePRC_VL_VDA.AsCurrency;
        Lc_Cd_Item := Fc_AtualizaItensNfl(DM.IB_Transacao,
                                          'I',
                                           0,
                                           It_Cd_Pedido,
                                            0,
                                            FieldByname('PPD_CODPRO_D').AsInteger,
                                            Lc_Qr_Produtos.FieldByname('PPD_QTDE').AsFloat * (StrToFloatDef(E_Qt_Produto.Text,0)),
                                            0,
                                            Lc_Vl_Unitario,
                                            StrToFloatDef(E_Aq_Desconto.Text, 0),
                                            (Lc_Vl_Unitario * (StrToFloatDef(E_Aq_Desconto.Text, 0) / 100)),
                                            Fc_Aliquota_Comissao(It_Cd_Vendedor, Dblcb_Tabelas.KeyValue,It_Cd_Produto),
                                            'V',
                                            Lc_estoque,
                                            'S',
                                            0,
                                            0,
                                            Fm_ListaEstoques.Dblcb_Estoque.KeyValue,
                                            Dblcb_Tabelas.KeyValue,
                                            '',
                                            0,0,0);
        //Baixa simples produto a produto
        with CtrlEstoque.Registro do
        Begin
          Codigo      := 0;
          Vinculo     := 'P';
          Terminal    := Gb_Terminal;
          Ordem       := It_Cd_Pedido;
          Item        := Lc_Cd_Item;
          Estoque     := Fm_ListaEstoques.Dblcb_Estoque.Keyvalue;
          operacao    := 'S';
          Produto     := FieldByname('PPD_CODPRO_D').AsInteger;
          Quantidade  := StrToFloatDef(E_Qt_Produto.Text,0);
          Data        := It_Dt_Operacao;
          Tipo        := 'Venda';
          UpdateAt    := Now;
        End;
        CtrlEstoque.Registra;

        if (Fc_Tb_Geral('L','DSP_G_CTRL_SEPARACAO','S') = 'S') then
          Begin
          Pc_SeparacaoMercadoria(It_Cd_Pedido,
                                 Lc_Cd_Item,
                                 FieldByname('PPD_CODPRO_D').AsInteger,
                                 It_Dt_Operacao,
                                 StrToFloatdef(E_Qt_Produto.Text,1));
          end;
        //Atualiza estoque na internet
        if (Fc_Tb_Geral('L','GRL_G_COM_ELETRONICO','') = 'S') then
        Begin
          Case Gb_Cd_Wsr of
            2:Pc_Ws_Estoque('I',Fc_BuscaCodigoEstoqueProduto(Fm_ListaEstoques.Dblcb_Estoque.KeyValue,FieldByname('PPD_CODPRO_D').AsInteger));
          End;
        End;
        Next;
      end;
    end;
  end;
end;



procedure TFr_Itens_Produto_Ext.Pc_GravaItemVenda;
Var
  Lc_Estoque : String;
Begin
  if Fc_ExisteItemNoPedido('V') then
  Begin
    if Chbx_Estoque.Checked then Lc_Estoque := 'S' else Lc_Estoque := 'N';
    //Verfica se lanca os itens da composição
    if It_Composicao <> 5 then
    Begin
      It_Cd_Itens :=Fc_AtualizaItensNfl(DM.IB_Transacao,
                                        'I',
                                        It_Cd_Itens,
                                        It_Cd_Pedido,
                                        0,
                                        It_Cd_Produto,
                                        StrToFloatDef(E_Qt_Produto.Text,0),
                                        StrToFloatDef(E_CustoUnitario.Text,0),
                                        StrToFloatDef(E_Vl_Unitario.Text,0),
                                        StrToFloatDef(E_Aq_Desconto.Text,0),
                                        StrToFloatDef(E_VL_Desconto.Text,0),
                                        StrToFloatDef(E_Aq_Com.Text,0),
                                        'V',
                                        Lc_Estoque,
                                        'S',
                                        StrToFloatDef(E_Aq_IPI.Text,0),
                                        StrToFloatDef(E_Aq_Icms.Text,0),
                                        Fm_ListaEstoques.Dblcb_Estoque.Keyvalue,
                                        Dblcb_Tabelas.KeyValue,
                                        '',
                                        0,0,0);
      //Baixa simples produto a produto
      if Lc_Estoque = 'S' then
      Begin
        with CtrlEstoque.Registro do
        Begin
          Codigo      := 0;
          Terminal    := Gb_Terminal;
          Vinculo     := 'P';
          Ordem       := It_Cd_Pedido;
          Item        := It_Cd_Itens;
          Estoque     := Fm_ListaEstoques.Dblcb_Estoque.Keyvalue;
          operacao    := 'S';
          Produto     := It_Cd_Produto;
          Quantidade  := StrToFloatDef(E_Qt_Produto.Text,0);
          Data        := It_Dt_Operacao;
          Tipo        := 'Venda';
          UpdateAt    := Now;
        End;
        CtrlEstoque.Registra;
      end;

      if (Fc_Tb_Geral('L','DSP_G_CTRL_SEPARACAO','S') = 'S') then
      Begin
        Pc_SeparacaoMercadoria(It_Cd_Pedido,
                               It_Cd_Itens,
                               It_Cd_Produto,
                               It_Dt_Operacao,
                               StrToFloatdef(E_Qt_Produto.Text,1));
      end;
      //Atualiza estoque na internet
      if (Fc_Tb_Geral('L','GRL_G_COM_ELETRONICO','') = 'S') then
      Begin
        Case Gb_Cd_Wsr of
          2:Pc_Ws_Estoque('I',Fc_BuscaCodigoEstoqueProduto(0,It_Cd_Produto));
        End;
      end;
    end
    else
    Begin
      Pc_InserecomposicaoVenda(It_Cd_Produto);
    end;
  end;
end;


procedure TFr_Itens_Produto_Ext.SB_GravarClick(Sender: TObject);
Begin
  if Fc_ValidaCampos then
  Begin
    Pc_GravaItemVenda;
    Pc_LimpaCampos;
    Pc_InserirNovoItem;
  end;
end;


procedure TFr_Itens_Produto_Ext.SB_GravarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  it_bt_pesquisa:=TRUE;
  if SB_Gravar.CanFocus then SB_Gravar.SetFocus;
end;

procedure TFr_Itens_Produto_Ext.FormCreate(Sender: TObject);
begin
  CtrlEstoque := TControllerCtrlEstoque.create(self);
end;

procedure TFr_Itens_Produto_Ext.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
Begin
  if shift = [] then
    Begin
    case Key of
      VK_F5: if SB_Gravar.Enabled then  SB_GravarClick(Sender);
      VK_F7: if SB_Pesquisar.Enabled then
                Begin
                  it_bt_pesquisa:=true;
                  if Sb_Pesquisar.CanFocus then Sb_Pesquisar.SetFocus;
                  Pc_MostraBusca;
                end;
      VK_F8: if Sb_Limpar.Enabled then  Sb_LimparClick(Sender);
      VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
    end;
end;

procedure TFr_Itens_Produto_Ext.FormKeyPress(Sender: TObject; var Key: Char);
Begin
   if (Key = #13) and not (ActiveControl is TDBMemo) then
   Begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

procedure TFr_Itens_Produto_Ext.Sb_Sair_0Click(Sender: TObject);
Begin
  Pc_LimpaCampos;
  close;
end;

procedure TFr_Itens_Produto_Ext.Sb_Sair_0MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  it_bt_pesquisa:=TRUE;
  if Sb_Sair_0.CanFocus then Sb_Sair_0.SetFocus;
end;

procedure TFr_Itens_Produto_Ext.Pc_FormataTela;
Begin
  if (Fc_Tb_Geral('L','PED_G_EST_AUTO','S') = 'S') then
    Begin
    if (It_ITF_ESTOQUE <> 'N') then
      Begin
      Chbx_Estoque.Checked :=true;
      Chbx_Estoque.Enabled:=false;
      end
    else
      Begin
      Chbx_Estoque.Checked :=False;
      Chbx_Estoque.Enabled:=true;
      end
    end
  else
    Begin
    if (StrToIntDef(Fc_Tb_Geral('L','PED_G_BAIXA_ESTOQUE','1'),1) = 2) then
      Begin
      Chbx_Estoque.Checked:=false;
      Chbx_Estoque.Enabled:=false;
      end
    else
      Begin
      if (It_ITF_ESTOQUE = 'S') OR (It_StateChange = 2) then
        Chbx_Estoque.Checked:=true
      else
        Chbx_Estoque.Checked:=false;
      Chbx_Estoque.Enabled:=true;
      end;
    end;
  //Sb_Corte.Visible := E_ALTURA.Visible;
  Dblcb_Tabelas.Enabled := (It_StateChange = 2);
  if (Fc_Tb_Geral('L','VDA_G_EDIT_AQ_COM','') = 'S') then
    Begin
    E_VL_Produto.Width := 79;
    lb_Aq_com.Visible := true;
    e_Aq_com.Visible := true;
    end
  else
    Begin
    E_VL_Produto.Width := 133;
    lb_Aq_com.Visible := false;
    e_Aq_com.Visible := False;
    end;
  E_Vl_Unitario.ReadOnly := False;
  IF (Gb_Nivel =0) then
  Begin
    if (Fc_Tb_Geral('L','VDA_G_EDIT_VL_UNIT','S') = 'S') then
      E_Vl_Unitario.ReadOnly := False
    else
      E_Vl_Unitario.ReadOnly := True;
  end;
  if E_CodPro.CanFocus then E_CodPro.SetFocus;
end;

procedure TFr_Itens_Produto_Ext.Pc_IniciaVariaveis;
Begin
  Fm_ListaEstoques.AtivaLista(Gb_CodMha);
  if (It_StateChange <> 3) then
  Begin
    Fm_ListaEstoques.Dblcb_Estoque.KeyValue:= Gb_Estoque;
  end
  else
  Begin

  end;
  It_Pes_cod_barra:= Fc_Tb_Geral('L','GRL_G_PES_COD_BARRA','');
  Pc_MostraSaldo;
  Pc_DefineCasaDecimalLocal;
  it_bt_pesquisa:=FALSE;
  Pc_Tabelas_Disponiveis(2);
end;


procedure TFr_Itens_Produto_Ext.Pc_InserirNovoItem;
Begin
  Pc_StateChange(2);
  if E_CodPro.CanFocus then E_CodPro.SetFocus;
  E_CodPro.SelectAll;
end;

procedure TFr_Itens_Produto_Ext.Pc_DefineCasaDecimalLocal;
Begin
  It_Casa_Decimal := Gb_Casa_Dec_Venda;
end;

procedure TFr_Itens_Produto_Ext.E_Vl_UnitarioExit(Sender: TObject);
Begin
  E_Vl_Unitario.Text := FormatFloat(It_Casa_Decimal, StrToFloatDef(E_Vl_Unitario.Text, 0));
  E_CustoUnitario.Text:=FormatFloat(It_Casa_Decimal, StrToFloatDef(E_Vl_Unitario.Text, 0));
  Pc_Totalizador;
end;

procedure TFr_Itens_Produto_Ext.E_Qt_ProdutoExit(Sender: TObject);
VAR
Lc_Qtde: Real;
Begin
  Lc_Qtde := StrToFloatDef(E_Qt_Produto.Text, 0);
  if (Fc_Tb_Geral('L','VDA_G_PROMOCAO_QUANTIDADE','S') = 'S') then
    PC_Verifica_Preco_Qtde(2,It_Cd_Produto);
  Pc_Totalizador;
end;

procedure TFr_Itens_Produto_Ext.E_Aq_IPIExit(Sender: TObject);
Begin
  if It_StateChange > 1 then
    Begin
    It_Aq_IPI := StrToFloatDef(E_Aq_IPI.Text, 0);
    E_Aq_IPI.Text := FloatToStrF(It_Aq_IPI, ffFixed, 10, 2);
    Pc_Totalizador;
    end;
end;

procedure TFr_Itens_Produto_Ext.E_CodProExit(Sender: TObject);
Begin
  if not it_bt_pesquisa then  // se for falso nao foi clicando no pesquisado , nem apertado f7
  Begin
    if It_StateChange = 1 then  exit;
    if (E_CodPro.Text = '') THEN
    Begin
      if E_Descricao.CanFocus then E_Descricao.SetFocus;
      exit;
    end;
    if (IntToStr(It_Cd_Produto) <> E_CodPro.Text) then  E_Vl_Unitario.Text := '0,00';
    if (E_CodPro.Text <> '') then
      E_Descricao.Text:=''
    else
      if (IntToStr(It_Cd_Produto) <> E_CodPro.Text) then  E_Vl_Unitario.Text := '0,00';
    if (E_CodPro.Text <> '') then
      E_Descricao.Text:='';
    if It_StateChange = 3 THEN
      pc_Tip_Busca('P', Dblcb_Tabelas.KeyValue, E_CodPro.text,'')
    else
      pc_Tip_Busca('B', Dblcb_Tabelas.KeyValue,E_CodPro.text,'');
    Pc_MostraSaldo;
  end;
end;

Procedure TFr_Itens_Produto_Ext.Pc_Tip_Busca(Pc_Tipo:char; Pc_cd_Tabela :Integer; Pc_cd_Prod:String; Pc_Desc_prod:String);
Var
   Lc_Nr_Itens : Integer;
   Lc_Cd_Tabela : Integer;
   Lc_Vl_Produto : Real;
   Lc_Qt_Minima : real;
Begin
  if (Pc_cd_Prod = '') and (Pc_Desc_prod = '') then exit;
  Lc_Nr_Itens:= Fc_Busca_Cod_barra(Pc_cd_Prod);
  if Lc_Nr_Itens > 1 then // houve duplicidade de codigo de barra
    Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Encontrado duplicidade de código de barra.' + EOLN +
                   'Verifique o cadastro e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    end;
  if Lc_Nr_Itens = 0 then  Lc_Nr_Itens := FC_Buscar(Pc_Tipo, Pc_cd_Tabela,Pc_cd_Prod,Pc_Desc_prod);  // nao encontrou codigo de baarra pesquisa normal
  case Lc_Nr_Itens of
    0:Begin
        It_Inserir := False;
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Produto não encontrado ou inativo.'+EOLN+
                       'Verfique e tente novamente.'+EOLN,
                        ['OK'],[bEscape],mpErro);
        Screen.Cursor := crDefault;
        Pc_LimpaCampos;
        if E_CodPro.CanFocus then E_CodPro.SetFocus;
        if E_Descricao.CanFocus then E_Descricao.SetFocus;
        exit;
        end;
    1:Begin
      //vERifICA SE O PRODUTO ESTA ATIVO
      if Qr_Pesquisa.FieldByName('PRO_ATIVO').AsString <> 'S' then
        Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Este produto está inativo.'+EOLN+
                       'Verfique e tente novamente.'+EOLN,
                      ['OK'],[bEscape],mpErro);
        Screen.Cursor := crDefault;
        E_CodPro.Clear;
        exit;
        end;
      //Pc_Define Tabela
      Lc_Cd_Tabela := FC_DefineTabela(Pc_cd_Tabela);

      PC_Busca_Preco_Qtde(Lc_Cd_Tabela,It_Cd_Produto);
      Lc_Vl_Produto := Qr_Preco_Qtde.FieldByName('PRC_VL_VDA').AsCurrency * It_MultiplicadorPreco;
      Lc_Qt_Minima := Qr_Preco_Qtde.FieldByName('PRC_QT_MIN').AsFloat;

      Pc_PreencheTela(Lc_Cd_Tabela,
                      Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,
                      Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString,
                      Lc_Vl_Produto,
                      Qr_Pesquisa.FieldByName('PRO_VL_CUSTO').AsCurrency,
                      Qr_Pesquisa.FieldByName('MED_ABREVIATURA').AsString,
                      Fc_Aliquota_Comissao(GB_Cd_Vendedor, Lc_Cd_Tabela,StrToIntDef(Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,0)),
                      Lc_Qt_Minima,
                      StrToIntDef(Qr_Pesquisa.FieldByName('PRO_COMPOSICAO').AsString,1),
                      Qr_Pesquisa.FieldByName('PRO_SUB_TRIB').AsString);
      It_Inserir:=True;
      end;
    else
      Pc_MostraBusca;
    end;
   Screen.Cursor := crDefault;
end;

procedure TFr_Itens_Produto_Ext.E_Vl_UnitarioEnter(Sender: TObject);
Begin
  E_Vl_Unitario.SelectAll;
  IT_VL_Ant := StrToFloatDef(E_Vl_Unitario.Text, 0);

end;

procedure TFr_Itens_Produto_Ext.E_Qt_ProdutoEnter(Sender: TObject);
Begin
  E_Qt_Produto.SelectAll;
end;

procedure TFr_Itens_Produto_Ext.E_Aq_ComEnter(Sender: TObject);
Begin
   E_Aq_Com.SelectAll;
end;

procedure TFr_Itens_Produto_Ext.E_CodProEnter(Sender: TObject);
Begin
  it_bt_pesquisa:=FALSE;
  E_CodPro.SelectAll;
end;

procedure TFr_Itens_Produto_Ext.E_DescricaoEnter(Sender: TObject);
Begin
  it_bt_pesquisa:=FALSE;
  E_CodPro.Text:='';
end;

procedure TFr_Itens_Produto_Ext.E_DescricaoExit(Sender: TObject);
begin
  if not it_bt_pesquisa then  // se for falso nao foi clicando no pesquisado , nem apertado f7
  Begin
    if It_StateChange = 1 then
      exit;
    if (E_Descricao.Text = '') THEN
    Begin
      if E_Vl_Unitario.CanFocus then E_Vl_Unitario.SetFocus;
      exit;
    end;
    Pc_Tip_Busca('B', Dblcb_Tabelas.KeyValue,'',Copy(E_Descricao.Text,1,50));
    Pc_MostraSaldo;
  end;
end;

procedure TFr_Itens_Produto_Ext.E_Aq_DescontoExit(Sender: TObject);
Var
  Lc_Aq_Desconto:Real;
  Lc_Vl_Produto : Real;
  Lc_Vl_Desconto : Real;
begin
  Lc_Vl_Produto := StrtoFloatDef(E_VL_Produto.Caption,0);
  Lc_Aq_Desconto := StrToFloatDef(E_Aq_Desconto.Text,0);
  Lc_Vl_Desconto := Lc_Vl_Produto * (Lc_Aq_Desconto/100);
  E_VL_Desconto.Text := FloatToStrf(Lc_Vl_Desconto,ffFixed,10,2);
  if (Lc_Aq_Desconto < 0) then Lc_Aq_Desconto := 0;
  E_Aq_Desconto.Text := FloatToStrf(Lc_Aq_Desconto,ffFixed,10,2);
  Pc_totalizador;
end;

procedure TFr_Itens_Produto_Ext.E_VL_DescontoExit(Sender: TObject);
Var
  Lc_VL_Desconto:Real;
  Lc_Vl_Produto : Real;
  Lc_Aq_Desconto : Real;
begin
  Lc_Vl_Produto := StrtoFloatDef(E_VL_Produto.Caption,0);
  Lc_VL_Desconto := StrtoFloatDef(E_VL_Desconto.Text,0);
  Lc_Aq_Desconto := (Lc_VL_Desconto / Lc_Vl_Produto);
  Lc_Aq_Desconto := RoundTo( Lc_Aq_Desconto,-2);
  if (Lc_Aq_Desconto < 0) then Lc_Aq_Desconto := 0;
  E_Aq_Desconto.Text := FloatToStrF(Lc_Aq_Desconto,ffFixed,10,2);
  Pc_totalizador;
end;

procedure TFr_Itens_Produto_Ext.Action1Execute(Sender: TObject);
Begin
   E_CustoUnitario.Visible := (not E_CustoUnitario.Visible);
   Lb_CustoUnitario.Visible := (not Lb_CustoUnitario.Visible);
end;

procedure TFr_Itens_Produto_Ext.Qr_TabelaAfterOpen(DataSet: TDataSet);
Begin
  Qr_Tabela.FetchAll
end;

procedure TFr_Itens_Produto_Ext.Dblcb_TabelasClick(Sender: TObject);
Begin
  E_CodPro.Clear;
  E_Descricao.Clear;
  E_Vl_Unitario.Text := '0,00';
end;

procedure TFr_Itens_Produto_Ext.E_CustoUnitarioExit(Sender: TObject);
var
   Lc_Valor: Real;
Begin
  Lc_Valor := StrToFloatDef(E_CustoUnitario.Text, 0);
  E_CustoUnitario.Text := FormatFloat(It_Casa_Decimal, StrToFloatDef(E_CustoUnitario.Text, 0));
  if Lc_Valor <= 0 then
    Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'O Valor Informado não é valido.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpErro);
    if E_CustoUnitario.CanFocus then E_CustoUnitario.SetFocus;
    end
  else
    Begin
    Pc_Totalizador;
    end;
end;

function TFr_Itens_Produto_Ext.Fc_Aliquota_comissao(fc_cd_vendedor,fc_Cd_TabelaPreco,Fc_Cd_Produto: Integer): Double;
var
  Lc_Aq_Com : Real;
  Lc_Tp_Com : String;
  lc_txt:String;
Begin
  Qr_Acao.Active := false;
  Qr_Acao.Transaction := DM.IB_Transacao;
  Qr_Acao.SQL.Clear;
  lc_txt:='';
  lc_txt:= ' select prc_aq_com, tb_produto.pro_tipo from tb_preco '+
           ' inner join TB_PRODUTO TB_PRODUTO on (TB_PRODUTO.PRO_CODIGO = TB_PRECO.PRC_CODPRO) '+
           ' where '+
           ' PRC_CODPRO = :PRC_CODPRO '+
           ' AND PRC_CODTPR =:PRC_CODTPR ';
  Qr_Acao.SQL.Add(lc_txt);
  Qr_Acao.ParamByName('PRC_CODPRO').AsInteger:=Fc_Cd_Produto;
  Qr_Acao.ParamByName('PRC_CODTPR').AsInteger:=fc_Cd_TabelaPreco;
  Qr_Acao.Active:=True;
  Lc_Aq_Com := Qr_Acao.FieldByName('prc_aq_com').asfloat;
  Lc_Tp_Com := Qr_Acao.FieldByName('pro_tipo').AsString;

  Qr_Acao.Active := False;
  Qr_Acao.Transaction := DM.IB_Transacao;
  Qr_Acao.SQL.Clear;
  lc_txt:= ' select CLB_AQ_COM_VDA, CLB_AQ_COM_SRV,  CLB_COM_VDA, CLB_COM_SRV,CLB_CALC_COM_VDA, CLB_CALC_COM_SRV '+
           ' from tb_colaborador '+
           'where  clb_codigo =:CLB_CODIGO ';
  Qr_Acao.SQL.Add(lc_txt);
  Qr_Acao.ParamByName('CLB_CODIGO').asinteger:= fc_cd_vendedor;
  Qr_Acao.Active:=True;

  if Lc_Tp_Com = 'P' then
    Begin
    if Qr_Acao.FieldByName('CLB_CALC_COM_VDA').AsString = 'V' then                      //'V' //Calculo pela soma da Aliquota ao item de venda
      Lc_Aq_Com := Lc_Aq_Com + Qr_Acao.FieldByName('CLB_AQ_COM_VDA').AsFloat;
    end
  else
    Begin
    if Qr_Acao.FieldByName('CLB_CALC_COM_SRV').AsString = 'S' then                      //'V' //Calculo pela soma da Aliquota ao item de venda
      Lc_Aq_Com := Lc_Aq_Com + Qr_Acao.FieldByName('CLB_AQ_COM_SRV').AsFloat;
    end;

  Result:= Lc_Aq_Com;
end;

procedure TFr_Itens_Produto_Ext.Sb_LimparClick(Sender: TObject);
Begin
  Pc_LimpaCampos;
  if E_CodPro.CanFocus then E_CodPro.SetFocus;
end;


procedure TFr_Itens_Produto_Ext.Sb_PesquisarClick(Sender: TObject);
begin
  it_bt_pesquisa:=true;
  Pc_MostraBusca;
end;

procedure TFr_Itens_Produto_Ext.Sb_PesquisarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  it_bt_pesquisa:=TRUE;
  if Sb_Pesquisar.CanFocus then Sb_Pesquisar.SetFocus;
end;

procedure TFr_Itens_Produto_Ext.Action2Execute(Sender: TObject);
Var
  Lc_Form :TFr_Liberacao;
Begin
  Lc_Form := TFr_Liberacao.Create(Fr_Itens_Produto_Ext);
  Lc_Form.Liberado := False;
  Lc_Form.It_Interface := 'Fr_Produtos';
  Lc_Form.It_Nome_Menu := 'Cadastro Produtos';
  Lc_Form.It_Privilegio := 'AUTORIZAR';
  Lc_Form.ShowModal;
  FreeAndNil(Lc_Form);
end;

procedure TFr_Itens_Produto_Ext.E_UnidadeEnter(Sender: TObject);
Begin
 E_Unidade.SelectAll;
end;

procedure TFr_Itens_Produto_Ext.E_Aq_DescontoEnter(Sender: TObject);
Begin
 E_Aq_Desconto.SelectAll;
end;

procedure TFr_Itens_Produto_Ext.E_VL_DescontoEnter(Sender: TObject);
Begin
 E_VL_Desconto.SelectAll;
end;

procedure TFr_Itens_Produto_Ext.E_Aq_IPIEnter(Sender: TObject);
Begin
 E_Aq_IPI.SelectAll;
end;

procedure TFr_Itens_Produto_Ext.E_Aq_IcmsEnter(Sender: TObject);
Begin
 E_Aq_Icms.SelectAll;
end;



function TFr_Itens_Produto_Ext.Fc_Busca_Cod_barra(Pc_cod_barra:String): integer;
var
   Lc_SqlTxt: string;
Begin
  Lc_SqlTxt:='';
  Qr_Pesquisa.Active:=FALSE;
  Qr_Pesquisa.SQL.Clear;
  Result:=0;// ja comeco como falso so fica verdadeiro se encontra codigo de barra
  if It_Pes_cod_barra <> 'S' then
    Begin
    exit;
    end;
  Lc_SqlTxt :=  'SELECT  '+
                '   PRO_CODIGO,'+
                '   PRO_CODIGOFAB, '+
                '   PRO_CODIGOFOR, '+
                '   PRO_CODIGOBAR, '+
                '   PRO_DESCRICAO, '+
                '   PRO_VL_CUSTO, '+
                '   MED_ABREVIATURA, '+
                '   PRO_CAMPANHA, '+
                '  PRO_COMPOSICAO, '+
                '   PRO_ATIVO, '+
                '   PRO_SUB_TRIB '+
                'FROM TB_PRODUTO tb_produto '+
                '   INNER JOIN TB_MEDIDA MED '+
                '   ON  (MED.MED_CODIGO = tb_produto.PRO_CODMED)  '+
                ' WHERE (PRO_CODIGO IS NOT NULL) '+
                ' AND (PRO_CODIGOBAR =:PRO_CODIGOBAR) ';
  if not GB_ProdCompartilha  then   Lc_SqlTxt:=Lc_SqlTxt+ 'AND PRO_CODMHA = :PRO_CODMHA';
  Qr_Pesquisa.SQL.Add(Lc_SqlTxt);

  Qr_Pesquisa.ParamByName('PRO_CODIGOBAR').AsString := Copy(Pc_cod_barra,1,20);
  if not GB_ProdCompartilha then  Qr_Pesquisa.ParamByName('PRO_CODMHA').AsInteger:=Gb_CodMha;

  Qr_Pesquisa.Active := True;
  Qr_Pesquisa.FetchAll;
  Result:=Qr_Pesquisa.RecordCount;
  if Result = 1 THEN
    It_Cd_Produto:= Qr_Pesquisa.FIELDBYNAME('PRO_CODIGO').Value;
end;

procedure TFr_Itens_Produto_Ext.Sb_CorteClick(Sender: TObject);
Var
  Lc_Form : TFr_Corte_Chapa;
begin
  Try
    Lc_Form := TFr_Corte_Chapa.Create(nil);
    Lc_Form.It_Confirma := False;
    Lc_Form.ShowModal;
    if Lc_Form.It_Confirma then
    Begin
      E_Qt_Produto.Text := Lc_Form.StrGrd_Informacao.Cells[2,3];
    end;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Itens_Produto_Ext.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_IniciaVariaveis;
end;

end.

