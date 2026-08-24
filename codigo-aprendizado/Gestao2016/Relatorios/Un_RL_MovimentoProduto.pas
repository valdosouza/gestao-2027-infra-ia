{Problema de Quebra de Pagina foi resolvida alterando as seguintes opçães
GRoup - FooterBand = Rodape
        LinkBand = Detalhe
        precalculateBanc = True
        ForceNewPage = True
Detalhe = LinkBand = Rodape
Rodape = Sem vinculos



}
unit Un_RL_MovimentoProduto;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery, StdCtrls, ComCtrls, Mask, DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TRL_MovimentoProduto = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    DetalheVenda: TQRBand;
    QRLabel8: TQRLabel;
    Grp_Produto: TQRGroup;
    E_FORNECEDOR: TQRDBText;
    QRDBText9: TQRDBText;
    QRLabel11: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel12: TQRLabel;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRLabel13: TQRLabel;
    E_DATA: TQRDBText;
    QRLabel2: TQRLabel;
    RodapeSubGrupo: TQRBand;
    Lb_SaldoAtual: TQRLabel;
    Qr_Produtos: TSTQuery;
    QRLabel1: TQRLabel;
    lb_Tipo: TQRLabel;
    Qr_Saldo: TSTQuery;
    E_Saldo_Atual: TQRLabel;
    Qr_Inventario: TSTQuery;
    Lb_UlttimoInventario: TQRLabel;
    E_Inventario: TQRLabel;
    E_Entrada: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand1: TQRBand;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel20: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Estoque: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Tab_Preco: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Ordenacao: TQRLabel;
    QRLabel22: TQRLabel;
    Lb_Gerar_Invent: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel19: TQRLabel;
    Lb_Grupo: TQRLabel;
    QRLabel23: TQRLabel;
    Lb_Subgrupo: TQRLabel;
    QRLabel24: TQRLabel;
    Lb_Marca: TQRLabel;
    QRLabel25: TQRLabel;
    Lb_Empresa: TQRLabel;
    QRLabel27: TQRLabel;
    Lb_Estoq_Min: TQRLabel;
    QRLabel28: TQRLabel;
    Lb_Saldo_Positivo: TQRLabel;
    QRLabel29: TQRLabel;
    Lb_Inativos: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    E_Saida: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel30: TQRLabel;
    E_Saldo_Movim: TQRLabel;
    QRLabel32: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel33: TQRLabel;
    lbl_acumulado: TQRLabel;
    QRMemo1: TQRMemo;
    QRLabel36: TQRLabel;
    E_CodigoProduto: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel7: TQRLabel;
    Qr_Nota: TSTQuery;
    E_Nr_Nota: TQRLabel;
    Divergencia: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RodapeSubGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure Grp_ProdutoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    It_caminhoErro:String;
    It_Divergencia : Boolean;
    PrmGrupo, PrmSubGrupo, Prmmarca, PrmCodProduto,PrmProduto, PrmEmpresa :Boolean;
    procedure VerificaParamentros;
    procedure PassagemParametros;

    function  SqlPedidoVenda:String;
    function  SqlPedidoCompra:String;
    function  SqlPedidoAjuste:String;
    function  SqlProducaoMP:String;
    function  SqlProducaoPA:String;
    function  SqlConsumoExtintor:String;
    function  SqlLancamentoLote:String;
    function  SqlLancamentoAvulso:String;

    function  SqlParametroProduto:String;
    function  SqlParametroGeral:String;
    function  SqlParametroInnerEmpresa:String;

    procedure Pc_DefineSqlSaldoEstoque;
    procedure Pc_DefineSqlInventario;
    procedure Pc_IniciaAberturaArquivo();

  public
    { Public declarations }
    It_Tp_Movimento : Integer;
    It_Qt_Entrada : Real;
    It_Qt_Saida   : Real;
    It_Qt_Inventario :Real;
    It_Qt_Acumulada :Real;
    It_Qt_SaldoAnterior: Currency;
    DataInventario : TDate;
    procedure Pc_Buscar;
    procedure Pc_Parametros;

  end;

var
  RL_MovimentoProduto: TRL_MovimentoProduto;

implementation

uses     Un_DM, UN_Imp_Produtos, UN_Sistema, UN_MSG, Un_Regra_Negocio, RN_Estoque, RN_Inventario, Un_Funcoes, un_Padrao, Un_Fm_ListaEstoques, env;
{$R *.dfm}

procedure TRL_MovimentoProduto.Pc_DefineSqlSaldoEstoque;
Begin
  Qr_Saldo.Active := False;
  Qr_Saldo.Transaction := DM.IB_Transacao;
  Qr_Saldo.SQL.Clear;
  if Trim(Fr_Imp_Produtos.Fm_ListaEstoques.DBLCB_Estoque.Text)<> '' then
    Begin
    Qr_Saldo.SQL.Add('SELECT CAST(COALESCE(SUM(EST_QTDE), 0) AS DOUBLE PRECISION) EST_QTDE '+
                     ' FROM TB_ESTOQUE '+
                     ' WHERE EST_CODPRO =:EST_CODPRO AND EST_CODETS=:EST_CODETS ');
    end
  else
    Begin
    Qr_Saldo.SQL.Add('SELECT CAST(COALESCE(SUM(EST_QTDE), 0) AS DOUBLE PRECISION) EST_QTDE '+
                     ' FROM TB_ESTOQUE '+
                     ' WHERE (EST_CODPRO =:EST_CODPRO)' );
    end;
end;

procedure TRL_MovimentoProduto.Pc_DefineSqlInventario;
Begin
  Qr_Inventario.Active := False;
  Qr_Inventario.Transaction := DM.IB_Transacao;
  Qr_Inventario.SQL.Clear;
  Qr_Inventario.SQL.Add('SELECT CAST(COALESCE(SUM(IVT_QT_ATUAL), 0) AS DOUBLE PRECISION) IVT_QT_ATUAL '+
                        'FROM TB_INVENTARIO '+
                        'WHERE IVT_DATA=:IVT_DATA AND '+
                        'IVT_CODPRO=:IVT_CODPRO '+
                        'and (IVT_CODMHA=:IVT_CODMHA)' );

end;

function TRL_MovimentoProduto.SqlConsumoExtintor: String;
VaR
  SqlTxt:String;
begin
  with Fr_Imp_Produtos do
  Begin
    Screen.Cursor:=crHourGlass;
    It_Qt_Saida := 0;
    It_Qt_Entrada := 0;
    SqlTxt:= concat(
                'SELECT DISTINCT ',
                'pd.PRO_CODIGO, ',
                'CET_DATA, ',
                'PRO_DESCRICAO, ',
                'os.ors_numero  PED_NUMERO, ',
                'CET_CODIGO, ',
                'ORS_CODIGO, ',
                'CET_OPERACAO, ',
                'CET_CODPRO, ',
                ' ''Exintor - Produto Consumo'' EMP_FANTASIA, ',
                ' CET_QTDE, ',
                ' pd.pro_vl_custo as ITF_VL_UNIT , ',
                ' 6 PED_TIPO, ''Exintor - Produto Consumo'' EMP_nome, ',
                ' (ios.ios_qtde * pd.pro_vl_custo ) as ITV_SUBTOTAL, ',
                ' pd.PRO_VL_CUSTOMED, ',
                ' ORS_CODIGO PED_CODIGO ',
                'FROM tb_ext_itens_ors ios ',
                '    INNER JOIN tb_ext_ordem_servico os ',
                '    ON (os.ors_codigo = ios.ios_codors) ',
                '    INNER join tb_estoque et ',
                '    on (et.est_codpro = ios.ios_codvcl) ',
                '    INNER JOIN tb_ctrl_estoque ce ',
                '    ON (ce.cet_item_ctrl = ios.ios_codigo) ',
                '    inner join tb_produto pd ',
                '    on (pd.pro_codigo = ios.ios_codvcl) ',
                ' WHERE (ORS_CODIGO IS NOT NULL) ',
                '  and ce.cet_vinculo = ''E'' '
          );

    SqlTxt:= SqlTxt + SqlParametroGeral;

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      SqlTxt:= SqlTxt + ' AND (ORS_CODMHA =:PRO_CODMHA) ' ;

    SqlTxt  := SqlTxt + SqlParametroProduto;

    Result := SqlTxt;
  end;


end;

function TRL_MovimentoProduto.SqlLancamentoAvulso: String;
VaR
  SqlTxt:String;
begin
  with Fr_Imp_Produtos do
  Begin
    Screen.Cursor:=crHourGlass;
    It_Qt_Saida := 0;
    It_Qt_Entrada := 0;
    SqlTxt:= concat(
                'SELECT DISTINCT PD.PRO_CODIGO , CET_DATA, PRO_DESCRICAO, ce.cet_codigo PED_NUMERO, ',
                ' CET_CODIGO, ce.cet_codigo, CET_OPERACAO, CET_CODPRO, ',
                ' ''Lancamento Avulso'' EMP_FANTASIA, ',
                ' CET_QTDE, pd.pro_vl_custo as ITF_VL_UNIT , 8 PED_TIPO, ''Lancamento Avulso'' EMP_nome, ',
                '(CET_QTDE * pd.pro_vl_custo ) as ITV_SUBTOTAL, pd.PRO_VL_CUSTOMED, CET_CODIGO PED_CODIGO ',
                'FROM  tb_ctrl_estoque ce ',
                '    INNER JOIN TB_PRODUTO pd ',
                '    ON (pd.PRO_CODIGO = ce.cet_codpro) ',
                'WHERE CE.cet_vinculo = ''A'' '
    );

    SqlTxt:= SqlTxt + SqlParametroGeral;

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      SqlTxt:= SqlTxt + ' AND (PRO_CODMHA =:PRO_CODMHA) ' ;

    SqlTxt  := SqlTxt + SqlParametroProduto;

    Result := SqlTxt;
  end;


end;

function TRL_MovimentoProduto.SqlLancamentoLote: String;
VaR
  SqlTxt:String;
begin
  with Fr_Imp_Produtos do
  Begin
    Screen.Cursor:=crHourGlass;
    It_Qt_Saida := 0;
    It_Qt_Entrada := 0;
    SqlTxt:= concat(
              'SELECT DISTINCT PD.PRO_CODIGO , CET_DATA, PRO_DESCRICAO, CLT_NUMERO PED_NUMERO, CET_CODIGO, ',
              ' ml.mlt_codigo, CET_OPERACAO, CET_CODPRO, ',
              ' ''Lote - Lancamento Entrada'' EMP_FANTASIA, ',
              ' CET_QTDE, pd.pro_vl_custo as ITF_VL_UNIT , 7 PED_TIPO, ''Lote - Lancamento Entrada'' EMP_nome, ',
              '(CET_QTDE * pd.pro_vl_custo ) as ITV_SUBTOTAL, pd.PRO_VL_CUSTOMED, CLT_CODIGO PED_CODIGO ',
              'FROM tb_ctrl_lote cl ',
              '    INNER JOIN tb_movimento_lote ml ',
              '    ON (ml.mlt_codclt = cl.clt_codigo) ',
              '    INNER JOIN tb_ctrl_estoque ce ',
              '    ON (ce.cet_item_ctrl = ml.mlt_codigo) ',
              '    INNER JOIN TB_PRODUTO pd ',
              '    ON (pd.PRO_CODIGO = cl.clt_codpro) ',
              'WHERE ml.mlt_sentido = ''E'' ' ,
              '  AND CE.cet_operacao = ''E'' ',
              '  AND ce.cet_vinculo = ''L'' '

    );

    SqlTxt:= SqlTxt + SqlParametroGeral;

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      SqlTxt:= SqlTxt + ' AND (CLT_CODMHA =:PRO_CODMHA) ' ;


    SqlTxt  := SqlTxt + SqlParametroProduto;
    Result := SqlTxt;
  end;

end;

function TRL_MovimentoProduto.SqlParametroGeral: String;
Var
  SqlTxt : String;
begin
   SqlTxt := SqlTxt + 'AND (CET_DATA BETWEEN :DATAINI AND :DATAFIM) ';

  if trim(Fr_Imp_Produtos.Fm_ListaEstoques.DBLCB_Estoque.Text) <> '' then
    Sqltxt := Sqltxt + ' AND CET_CODETS = :ETS_CODIGO ';
  Result := SqlTxt;
end;

function TRL_MovimentoProduto.SqlParametroInnerEmpresa: String;
Var
  SqlTxt : String;
begin
  Result := '';
  if prmEmpresa then
  begin
    SqlTxt := SqlTxt + '    LEFT OUTER JOIN TB_PROD_FORN Tb_prod_forn ' ;
    SqlTxt := SqlTxt + '    ON  (Tb_prod_forn.PFR_CODPRO = Tb_produto.PRO_CODIGO) ';
    SqlTxt := SqlTxt + '    LEFT OUTER JOIN  TB_EMPRESA Tb_fornecedor ';
    SqlTxt := SqlTxt + '    ON  (Tb_prod_forn.PFR_CODFOR = Tb_fornecedor.EMP_CODIGO) ';
    Result := SqlTxt;
  end;
end;

function TRL_MovimentoProduto.SqlParametroProduto: String;
Var
  SqlTxt : String;
begin
  SqlTxt := '';
  if prmGrupo       then SqlTxt := SqlTxt +'AND (PRO_CODGRP =:PRO_CODGRP) ';
  if prmSubGrupo    then SqlTxt := SqlTxt +'AND (PRO_CODSBG =:PRO_CODSBG) ';
  if prmmarca       then SqlTxt := SqlTxt +'AND (PRO_CODMRC =:PRO_CODMRC) ';
  if prmCodProduto  then SqlTxt := SqlTxt +'AND (PRO_CODIGO =:PRO_CODIGO) ';
  if prmProduto     then SqlTxt := SqlTxt +'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

  Result := SqlTxt;
end;

function TRL_MovimentoProduto.SqlPedidoAjuste: String;
VaR
  SqlTxt:String;
begin
  Screen.Cursor:=crHourGlass;
  It_Qt_Saida := 0;
  It_Qt_Entrada := 0;
  Qr_Produtos.Close;
  Qr_Produtos.SQL.Clear;

  SqlTxt:= 'SELECT DISTINCT PRO_CODIGO , CET_DATA, PRO_DESCRICAO, PED_NUMERO, CET_CODIGO, ITF_CODIGO, CET_OPERACAO, CET_CODPRO,   '+
           ' tb_cliente.EMP_FANTASIA, CET_QTDE,ITF_VL_UNIT, '+
           ' PED_TIPO,tb_cliente.EMP_nome, (CET_QTDE * ITF_VL_UNIT) as ITV_SUBTOTAL,PRO_VL_CUSTOMED,PED_CODIGO '+
          'FROM TB_PEDIDO tb_pedido '+
          '    INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
          '    ON (tb_itens_nfl.ITF_CODPED = tb_pedido.PED_CODIGO) '+
          '    INNER JOIN tb_ctrl_estoque ce '+
          '    ON (ce.cet_item_ctrl = tb_itens_nfl.itf_codigo) '+
          '    INNER JOIN TB_PRODUTO tb_produto '+
          '    ON (tb_produto.PRO_CODIGO = ce.cet_CODPRO) '+
          '    INNER JOIN TB_EMPRESA tb_cliente '+
          '    ON (tb_cliente.EMP_CODIGO = tb_pedido.PED_CODEMP) '+
          '    INNER JOIN TB_ESTOQUE tb_estoque '+
          '    ON (tb_estoque.EST_CODPRO = ce.CET_CODPRO) '+
          '    INNER JOIN TB_ESTOQUES tb_estoques '+
          '    ON (tb_estoques.ETS_CODIGO = tb_estoque.EST_CODETS) '+
          'WHERE ( PED_TIPO =3)  '+
          '  and ce.cet_vinculo = ''P'' ';

  SqlTxt:= SqlTxt + SqlParametroInnerEmpresa;

  SqlTxt:= SqlTxt + SqlParametroGeral;

  if ( Trim(Fr_Imp_Produtos.Fm_LME.Dblcb_Lista.Text) <> '' ) then
    SqlTxt:= SqlTxt + ' AND (PED_CODMHA =:PRO_CODMHA) ' ;

  SqlTxt  := SqlTxt + SqlParametroProduto;
  if prmEmpresa     then SqlTxt := SqlTxt +'AND (PED_CODEMP =:PED_CODEMP) ';

  Result := SqlTxt;

end;

function TRL_MovimentoProduto.SqlPedidoCompra: String;
VaR
  SqlTxt:String;
begin
  Screen.Cursor:=crHourGlass;
  It_Qt_Saida := 0;
  It_Qt_Entrada := 0;
  Qr_Produtos.Close;
  Qr_Produtos.SQL.Clear;

  SqlTxt:= 'SELECT DISTINCT PRO_CODIGO , CET_DATA, PRO_DESCRICAO, PED_NUMERO, CET_CODIGO, ITF_CODIGO, CET_OPERACAO, CET_CODPRO,   '+
           ' tb_cliente.EMP_FANTASIA, CET_QTDE,ITF_VL_UNIT, '+
           ' PED_TIPO,tb_cliente.EMP_nome, (CET_QTDE * ITF_VL_UNIT) as ITV_SUBTOTAL,PRO_VL_CUSTOMED,PED_CODIGO '+
          'FROM TB_PEDIDO tb_pedido '+
          '    INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
          '    ON (tb_itens_nfl.ITF_CODPED = tb_pedido.PED_CODIGO) '+
          '    INNER JOIN tb_ctrl_estoque ce '+
          '    ON (ce.cet_item_ctrl = tb_itens_nfl.itf_codigo) '+
          '    INNER JOIN TB_PRODUTO tb_produto '+
          '    ON (tb_produto.PRO_CODIGO = ce.cet_CODPRO) '+
          '    INNER JOIN TB_EMPRESA tb_cliente '+
          '    ON (tb_cliente.EMP_CODIGO = tb_pedido.PED_CODEMP) '+
          '    INNER JOIN TB_ESTOQUE tb_estoque '+
          '    ON (tb_estoque.EST_CODPRO = ce.CET_CODPRO) '+
          '    INNER JOIN TB_ESTOQUES tb_estoques '+
          '    ON (tb_estoques.ETS_CODIGO = tb_estoque.EST_CODETS) '+
          'WHERE ( PED_TIPO =2)  '+
          '  and ce.cet_vinculo = ''P'' ';

  SqlTxt:= SqlTxt + SqlParametroInnerEmpresa;

  SqlTxt:= SqlTxt + SqlParametroGeral;

  if ( Trim(Fr_Imp_Produtos.Fm_LME.Dblcb_Lista.Text) <> '' ) then
    SqlTxt:= SqlTxt + ' AND (PED_CODMHA =:PRO_CODMHA) ' ;

  SqlTxt  := SqlTxt + SqlParametroProduto;
  if prmEmpresa     then SqlTxt := SqlTxt +'AND (PED_CODEMP =:PED_CODEMP) ';

  Result := SqlTxt;

end;

function TRL_MovimentoProduto.SqlPedidoVenda: String;
VaR
  SqlTxt:String;
begin
  Screen.Cursor:=crHourGlass;
  It_Qt_Saida := 0;
  It_Qt_Entrada := 0;
  Qr_Produtos.Close;
  Qr_Produtos.SQL.Clear;

  SqlTxt:= 'SELECT DISTINCT PRO_CODIGO , CET_DATA, PRO_DESCRICAO, PED_NUMERO, CET_CODIGO, ITF_CODIGO, CET_OPERACAO, CET_CODPRO,   '+
           ' tb_cliente.EMP_FANTASIA, CET_QTDE,ITF_VL_UNIT, '+
           ' PED_TIPO,tb_cliente.EMP_nome, (CET_QTDE * ITF_VL_UNIT) as ITV_SUBTOTAL,PRO_VL_CUSTOMED,PED_CODIGO '+
          'FROM TB_PEDIDO tb_pedido '+
          '    INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
          '    ON (tb_itens_nfl.ITF_CODPED = tb_pedido.PED_CODIGO) '+
          '    INNER JOIN tb_ctrl_estoque ce '+
          '    ON (ce.cet_item_ctrl = tb_itens_nfl.itf_codigo) '+
          '    INNER JOIN TB_PRODUTO tb_produto '+
          '    ON (tb_produto.PRO_CODIGO = ce.cet_CODPRO) '+
          '    INNER JOIN TB_EMPRESA tb_cliente '+
          '    ON (tb_cliente.EMP_CODIGO = tb_pedido.PED_CODEMP) '+
          '    INNER JOIN TB_ESTOQUE tb_estoque '+
          '    ON (tb_estoque.EST_CODPRO = ce.CET_CODPRO) '+
          '    INNER JOIN TB_ESTOQUES tb_estoques '+
          '    ON (tb_estoques.ETS_CODIGO = tb_estoque.EST_CODETS) '+
          'WHERE ((PED_TIPO =1) or (PED_TIPO =4) ) '+
          '  and ce.cet_vinculo = ''P'' ';

  SqlTxt:= SqlTxt + SqlParametroInnerEmpresa;

  SqlTxt:= SqlTxt + SqlParametroGeral;

  if ( Trim(Fr_Imp_Produtos.Fm_LME.Dblcb_Lista.Text) <> '' ) then
    SqlTxt:= SqlTxt + ' AND (PED_CODMHA =:PRO_CODMHA) ' ;

  SqlTxt  := SqlTxt + SqlParametroProduto;

  if prmEmpresa     then SqlTxt := SqlTxt +'AND (PED_CODEMP =:PED_CODEMP) ';

  Result := SqlTxt;
end;

function TRL_MovimentoProduto.SqlProducaoMP:String;
VaR
  SqlTxt:String;
begin
  with Fr_Imp_Produtos do
  Begin
    Screen.Cursor:=crHourGlass;
    It_Qt_Saida := 0;
    It_Qt_Entrada := 0;
    SqlTxt:= concat(
                'SELECT DISTINCT pd.PRO_CODIGO,CET_DATA, PRO_DESCRICAO, ORP_NUMERO PED_NUMERO, CET_CODIGO, PRE_CODIGO, CET_OPERACAO, CET_CODPRO, ',
                ' ''Producão - Matéria Prima'' EMP_FANTASIA, ',
                'CET_QTDE, pd.pro_vl_custo as ITF_VL_UNIT , 4 PED_TIPO, ''Producão - Matéria Prima'' EMP_nome, ',
                '(orpma.pre_qtduni * pd.pro_vl_custo ) as ITV_SUBTOTAL, pd.PRO_VL_CUSTOMED, ORP_CODIGO PED_CODIGO ',
                'FROM TB_ORP orp ',
                '    INNER JOIN tb_orpprev orpma ',
                '    ON (orpma.pre_codorp = orp.orp_codigo) ',
                '    INNER JOIN tb_ctrl_estoque ce ',
                '    ON (ce.cet_item_ctrl = orpma.pre_codigo) ',
                '    INNER JOIN TB_PRODUTO pd ',
                '    ON (pd.PRO_CODIGO = orpma.PRE_codpro) ',
                ' WHERE (ORP_CODIGO IS NOT NULL) ',
                '  and ce.cet_vinculo = ''M'' '
    );

    SqlTxt:= SqlTxt + SqlParametroGeral;

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      SqlTxt:= SqlTxt + ' AND (ORP_CODMHA =:PRO_CODMHA) ' ;

    SqlTxt  := SqlTxt + SqlParametroProduto;

    Result := SqlTxt;
  end;
End;

function TRL_MovimentoProduto.SqlProducaoPA: String;
VaR
  SqlTxt:String;
begin
  with Fr_Imp_Produtos do
  Begin
    Screen.Cursor:=crHourGlass;
    It_Qt_Saida := 0;
    It_Qt_Entrada := 0;
    SqlTxt:= concat(

                'SELECT DISTINCT pd.PRO_CODIGO,CET_DATA, PRO_DESCRICAO, ORP_NUMERO  PED_NUMERO, CET_CODIGO, ORP_CODIGO, CET_OPERACAO, CET_CODPRO, ',
                ' ''Producão - Produto Acabado'' EMP_FANTASIA, ',
                ' CET_QTDE, pd.pro_vl_custo as ITF_VL_UNIT , 5 PED_TIPO, ''Producão - Produto Acabado'' EMP_nome, ',
                ' (orppa.ORL_QTDTOT * pd.pro_vl_custo ) as ITV_SUBTOTAL, ',
                ' pd.PRO_VL_CUSTOMED, ORP_CODIGO PED_CODIGO ',
                ' FROM TB_ORP orp ',
                '    INNER JOIN tb_orpreal orppa ',
                '    ON (orppa.orl_codorp = orp.orp_codigo) ',
                '    INNER JOIN tb_ctrl_estoque ce ',
                '    ON (ce.cet_item_ctrl = orppa.orl_codigo) ',
                '    INNER JOIN TB_PRODUTO pd ',
                '    ON (pd.PRO_CODIGO = orppa.ORL_codpro) ',
                ' WHERE (ORP_CODIGO IS NOT NULL) ',
                '  and ce.cet_vinculo = ''O'' '
          );

    SqlTxt:= SqlTxt + SqlParametroGeral;

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      SqlTxt:= SqlTxt + ' AND (ORP_CODMHA =:PRO_CODMHA) ' ;

    SqlTxt  := SqlTxt + SqlParametroProduto;


    Result := SqlTxt;
  end;
end;


procedure TRL_MovimentoProduto.VerificaParamentros;
begin
  It_Qt_Saida := 0;
  It_Qt_Entrada := 0;
  Qr_Produtos.Close;
  Qr_Produtos.SQL.Clear;
  if Fr_Imp_Produtos.DBLCB_Grupos.Text =''    then prmGrupo       := False else prmGrupo      := True;
  if Fr_Imp_Produtos.DBLCB_SubGrupos.Text ='' then prmSubGrupo    := False else prmSubGrupo   := True;
  if Fr_Imp_Produtos.DBLCB_Marca.Text =''     then prmmarca       := False else prmmarca      := True;
  if Fr_Imp_Produtos.E_BuscaCodigoProduto.Text =''   then prmCodProduto  := False else prmCodProduto := True;
  if Fr_Imp_Produtos.E_BuscaDescricaoProduto.Text ='' then prmProduto     := False else prmProduto    := True;
  if Fr_Imp_Produtos.DBLCB_Empresa.Text =''   then prmEmpresa     := False else prmEmpresa    := True;
end;

procedure TRL_MovimentoProduto.PassagemParametros;
begin
  if ( Trim(Fr_Imp_Produtos.Fm_LME.Dblcb_Lista.Text) <> '' ) then
    Qr_Produtos.ParamByName('PRO_CODMHA').AsInteger:= Fr_Imp_Produtos.Fm_LME.Dblcb_Lista.KeyValue;

  if trim(Fr_Imp_Produtos.Fm_ListaEstoques.DBLCB_Estoque.Text) <> '' then
    Qr_Produtos.ParamByName('ETS_CODIGO').AsInteger:= Fr_Imp_Produtos.Fm_ListaEstoques.DBLCB_Estoque.KeyValue;

  IF Fr_Imp_Produtos.Chbx_AnaliseMovimento.Checked then
  Begin
    Qr_Produtos.ParamByName('DATAINI').AsDate := Fr_Imp_Produtos.E_Data_Ini.Date;
    Qr_Produtos.ParamByName('DATAFIM').AsDate := Fr_Imp_Produtos.E_Data_Fim.Date;
  end
  else
  Begin
    Qr_Produtos.ParamByName('DATAINI').AsDate := DataInventario;
    Qr_Produtos.ParamByName('DATAFIM').AsDate := StrToDate('31/12/9999');
  end;
  if prmGrupo then Qr_Produtos.ParamByName('PRO_CODGRP').AsInteger:=Fr_Imp_Produtos.DBLCB_Grupos.KeyValue;
  if PrmSubGrupo then Qr_Produtos.ParamByName('PRO_CODSBG').AsInteger:=Fr_Imp_Produtos.DBLCB_SubGrupos.KeyValue;
  if PrmMarca then Qr_Produtos.ParamByName('PRO_CODMRC').AsInteger:=Fr_Imp_Produtos.DBLCB_Marca.KeyValue;
  if PrmCodProduto then Qr_Produtos.ParamByName('PRO_CODIGO').AsInteger := StrToIntDef( Fr_Imp_Produtos.E_BuscaCodigoProduto.Text,0);
  if PrmProduto then Qr_Produtos.ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(Fr_Imp_Produtos.E_BuscaDescricaoProduto.Text,1,98)+ '%';
  if PrmEmpresa then Qr_Produtos.ParamByName('PED_CODEMP').AsInteger := Fr_Imp_Produtos.DBLCB_Empresa.KeyValue;
  if ( Trim(Fr_Imp_Produtos.Fm_LME.Dblcb_Lista.Text) <> '' ) then
    Qr_Produtos.ParamByName('PRO_CODMHA').AsInteger := Fr_Imp_Produtos.Fm_LME.Dblcb_Lista.KeyValue;
end;

procedure TRL_MovimentoProduto.Pc_Buscar;
VaR
  SqlTxt:String;
begin
  try
    Screen.Cursor:=crHourGlass;
    VerificaParamentros;
    case It_Tp_Movimento of
      1:SqlTxt := SqlPedidoVenda;
      2:SqlTxt := SqlPedidoCompra;
      3:SqlTxt := SqlPedidoAjuste;
      4:SqlTxt := SqlProducaoMP;
      5:SqlTxt := SqlProducaoPA;
      6:SqlTxt := SqlConsumoExtintor;
      7:SqlTxt := SqlLancamentoLote;
      8:SqlTxt := SqlLancamentoAvulso;
      else
      Begin
        SqlTxt := SqlPedidoVenda;
        SqlTxt := concat(SqlTxt , ' Union ' , SqlPedidoCompra);
        SqlTxt := concat(SqlTxt , ' Union ' , SqlPedidoAjuste);
        SqlTxt := concat(SqlTxt , ' Union ' , SqlProducaoMP);
        SqlTxt := concat(SqlTxt , ' Union ' , SqlProducaoPA);
        SqlTxt := concat(SqlTxt , ' Union ' , SqlConsumoExtintor);
        SqlTxt := concat(SqlTxt , ' Union ' , SqlLancamentoLote);
        SqlTxt := concat(SqlTxt , ' Union ' , SqlLancamentoAvulso);
      End;
    end;
    Qr_Produtos.SQL.Add(SqlTxt+' ORDER BY 1 , 2, 3, 4, 5 ');
    Try
      PassagemParametros;
      Qr_Produtos.Prepare;
      Qr_Produtos.active := True;
      Qr_Produtos.FetchAll;
      Qr_Produtos.First;

    Except
      on E : Exception do
        ShowMessage(E.ClassName+' error raised, with message : '+E.Message);
    End;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TRL_MovimentoProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(QRPT);
  Action:=caFree;
  RL_MovimentoProduto := nil;
end;

procedure TRL_MovimentoProduto.DetalheVendaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_Tipo : String;
  lc_cst_medio:double;
  lc_qt_estoque:Double;
begin
  lc_cst_medio := 0;
  case Qr_Produtos.FieldByName('PED_TIPO').AsInteger of
    1:Lc_Tipo := 'V - ';
    2:Lc_Tipo := 'C - ';
    3:Lc_Tipo := 'A - ';
    4:Lc_Tipo := 'V - ';
    5:Lc_Tipo := 'P - ';
    6:Lc_Tipo := 'E - ';
    7:Lc_Tipo := 'L - ';
    8:Lc_Tipo := 'U - ';
  end;

  if (Qr_Produtos.FieldByName('CET_OPERACAO').AsString = 'S') THEN
  begin
    Lc_Tipo := Lc_Tipo + 'Saída';
    It_Qt_Acumulada :=  It_Qt_Acumulada - Qr_Produtos.fieldbyname('CET_QTDE').AsFloat;
    lbl_acumulado.Caption := FormatFloat('#,##0.00', It_Qt_Acumulada )
  end;

  if (Qr_Produtos.FieldByName('CET_OPERACAO').AsString = 'E') THEN
  begin
    Lc_Tipo := Lc_Tipo + 'Entrada';
    It_Qt_Acumulada :=  It_Qt_Acumulada + Qr_Produtos.fieldbyname('CET_QTDE').AsFloat;
    lbl_acumulado.Caption := FormatFloat('#,##0.00', It_Qt_Acumulada )
  end;

  Qr_Nota.Active := False;
  Qr_Nota.ParamByName('PED_CODIGO').AsInteger := Qr_Produtos.fieldbyname('PED_CODIGO').AsInteger;
  Qr_Nota.Active := True;
  E_Nr_Nota.Caption := Qr_Nota.FieldByName('NFL_NUMERO').AsString;

  lc_qt_estoque:= (StrToFloatDef(lbl_acumulado.Caption,0) - Qr_Produtos.fieldbyname('CET_QTDE').AsFloat);
  if lc_qt_estoque +Qr_Produtos.fieldbyname('CET_QTDE').AsFloat > 0 then
  Begin
    lc_cst_medio:= ((lc_cst_medio+ Qr_Produtos.fieldbyname('PRO_VL_CUSTOMED').AsCurrency) +
                     (Qr_Produtos.fieldbyname('ITF_VL_UNIT').AsCurrency * Qr_Produtos.fieldbyname('CET_QTDE').AsFloat))
                    /(lc_qt_estoque +Qr_Produtos.fieldbyname('CET_QTDE').AsFloat);
  end
  else
  Begin
     lc_cst_medio:= ((lc_cst_medio+ Qr_Produtos.fieldbyname('PRO_VL_CUSTOMED').AsCurrency) +
                     (Qr_Produtos.fieldbyname('ITF_VL_UNIT').AsCurrency * Qr_Produtos.fieldbyname('CET_QTDE').AsFloat)) /1;
  end;

  lb_Tipo.Caption := Lc_Tipo;

  if Copy(Lc_Tipo,5,5) = 'Saída'    then It_Qt_Saida    := It_Qt_Saida    + Qr_Produtos.FieldByName('CET_QTDE').AsFloat;
  if Copy(Lc_Tipo,5,7) = 'Entrada'  then It_Qt_Entrada  := It_Qt_Entrada  + Qr_Produtos.FieldByName('CET_QTDE').AsFloat;

end;

procedure TRL_MovimentoProduto.RodapeSubGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
Var
  Lc_Sld_Acumulado : String;
  Lc_Sld_Estoque : String;
  Lc_Linha : String;
  Lc_Aux : String;
begin
  Lc_Linha := '';
  with Fr_Imp_Produtos do
  Begin
    if Chbx_AnaliseMovimento.Checked then
    Begin
      //Quando for apenas verificacão de Periodo não devem ser influenciados por inventário nem saldo atual
      Lb_SaldoAtual.Font.Color := clWhite;
      E_Saldo_Atual.Font.Color := clWhite;
    end;
    E_Inventario.Caption := FloatToStrF(It_Qt_Inventario,ffFixed,10,2);
    It_Qt_Inventario:=0;
    //Quantidade movimentada
    E_Entrada.Caption := FormatFloat('0.####', It_Qt_Entrada);
    E_Saida.Caption := FormatFloat('0.####', It_Qt_Saida);
    //E_Saldo_Movim.Caption := FormatFloat('0.####', (Qr_Inventario.FieldByName('IVT_QT_ATUAL').AsFloat +  It_Qt_Entrada) - It_Qt_Saida);
    E_Saldo_Movim.Caption := FormatFloat('0.####', It_Qt_Entrada - It_Qt_Saida);
    It_Qt_Entrada := 0;
    It_Qt_Saida := 0;

    //Saldo do Estoque
    Qr_Saldo.Active := False;
    Qr_Saldo.ParamByName('EST_CODPRO').AsInteger := Qr_Produtos.FieldByName('CET_CODPRO').AsInteger;
    if Trim(Fm_ListaEstoques.DBLCB_Estoque.Text) <> '' then
      Qr_Saldo.ParamByName('EST_CODETS').AsInteger := Fm_ListaEstoques.DBLCB_Estoque.KeyValue;
    Qr_Saldo.Active := True;
    Qr_Saldo.First;


    if (It_Tp_Movimento = 0) then
    Begin
      Lc_Sld_Acumulado := FloatToStrF(It_Qt_Acumulada + It_Qt_Inventario,ffFixed,10,3);
      Lc_Sld_Estoque := FloatToStrF(Qr_Saldo.FieldByName('EST_QTDE').AsFloat,ffFixed,10,3);

      IF ( Lc_Sld_Estoque <> Lc_Sld_Acumulado ) and (not Chbx_AnaliseMovimento.Checked) then
      Begin
        It_Divergencia := true;
        //Código alfanumérico do item
        Lc_Aux := Qr_Produtos.FieldByName('CET_CODPRO').AsString;
        Lc_Linha := Lc_Linha + Padr(Lc_Aux,7);
        //Descricão do produto
        Lc_Aux := Copy(' ' + Qr_Produtos.FieldByName('PRO_DESCRICAO').AsString,1,50);
        Lc_Aux := Fc_CriaEspaco(Lc_Aux,50);
        Lc_Linha := Lc_Linha + Lc_Aux;
        //Acumulado
        Lc_Aux := Lc_Sld_Acumulado;
        Lc_Linha := Lc_Linha + Padr(Lc_Aux,14);
        //Saldo do Estoque -
        Lc_Aux := Lc_Sld_Estoque;
        Lc_Linha := Lc_Linha + Padr(Lc_Aux,14);
        //Grava a linha no arquivo
        Divergencia.Lines.Add(Lc_Linha);
      end;
    end;
    E_Saldo_Atual.Caption := Qr_Saldo.FieldByName('EST_QTDE').AsString;
    It_Qt_Acumulada := 0;
  end;
end;

procedure TRL_MovimentoProduto.Pc_IniciaAberturaArquivo();
Var
  Lc_Aux : String;
  Lc_Linha : String;
Begin
  It_Divergencia := False;
  Divergencia.Clear;
  It_caminhoErro := GbPathExe + '\ProdutoQtdeDivergente.txt';
  IF FileExists(It_caminhoErro) then DeleteFile(It_caminhoErro);
  //Código alfanumérico do item
  Lc_Aux := 'Código ';
  Lc_Linha := Lc_Aux;
  Lc_Aux := ' DESCRICAO DO PRODUTO';
  Lc_Aux := Fc_CriaEspaco(Lc_Aux,50);
  Lc_Linha := Lc_Linha + Lc_Aux;
  //Acumulado
  Lc_Aux := ' QTDE ACUMUL ';
  Lc_Aux := Fc_CriaEspaco(Lc_Aux,14);
  Lc_Linha := Lc_Linha + Lc_Aux;
  //Saldo do Estoque
  Lc_Aux := ' SALDO ATUAL';
  Lc_Aux := Fc_CriaEspaco(Lc_Aux,14);
  Lc_Linha := Lc_Linha + Lc_Aux;
  //Grava a linha no arquivo
  Divergencia.Lines.Add(Lc_Linha);

end;

procedure TRL_MovimentoProduto.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  //Arquivo para verificar quais produtos estão com qtde divergente
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_DefineSqlSaldoEstoque;
  Pc_DefineSqlInventario;
  Pc_Buscar;
  if (Qr_Produtos.RecordCount > 0) then Pc_IniciaAberturaArquivo; 
  Pc_Parametros;
end;

procedure TRL_MovimentoProduto.Pc_Parametros;
begin
  with Fr_Imp_Produtos do
    begin
    // Verifica tipos de documento
    case LBx_TipoRelatorio.ItemIndex of
      0 : Lb_Tipo_Doc.Caption := 'Cadastro de Produtos';
      1 : Lb_Tipo_Doc.Caption := 'Saldo do Estoque';
      2 : Lb_Tipo_Doc.Caption := 'Movimentacão';
      3 : Lb_Tipo_Doc.Caption := 'Tabela de Producão';
      4 : Lb_Tipo_Doc.Caption := 'Curva ABC';
      5 : Lb_Tipo_Doc.Caption := 'Inventário';
    end;
    // Verifica data de Inatividade da empresa solicitada
    if ChBx_Periodo.Checked then
      Begin
      Lb_Data_Ini.Caption := DateToStr( E_Data_Ini.Date);
      Lb_Data_Fim.Caption := DateToStr( E_Data_Fim.Date);
      end
    else
      Begin
      Lb_Data_Ini.Caption := '';
      Lb_Data_Fim.Caption := '';
      end;
    // Verifica o nome do estoque foi preenchido
    if Fm_ListaEstoques.DBLCB_Estoque.Text = '' then
      Lb_Estoque.Caption := 'Todos'
    else
      Lb_Estoque.Caption := Fm_ListaEstoques.DBLCB_Estoque.Text;
    // Verifica se o campo cliente foi preenchido
    if DBLCB_Tabela_Preco.Text = '' then
      Lb_Tab_Preco.Caption := 'Todos'
    else
      Lb_Tab_Preco.Caption := DBLCB_Tabela_Preco.Text;
    // Verifica o nome do grupo foi preenchido
    if DBLCB_Grupos.Text = '' then
      Lb_Grupo.Caption := 'Todos'
    else
      Lb_Grupo.Caption := DBLCB_Grupos.Text;
    // Verifica se o subgrupo foi preenchido
    if DBLCB_SubGrupos.Text = '' then
      Lb_Subgrupo.Caption := 'Todos'
    else
      Lb_Subgrupo.Caption := DBLCB_SubGrupos.Text;
    // Verifica o nome da marca foi preenchido
    if DBLCB_Marca.Text = '' then
      Lb_Marca.Caption := 'Todos'
    else
      Lb_Marca.Caption := DBLCB_Marca.Text;
    // Verifica se o nome da empresa foi preenchido
    if trim(DBLCB_Empresa.Text) = '' then
      Lb_Empresa.Caption := 'Todos'
    else
      Lb_Empresa.Caption := DBLCB_Empresa.Text;
    // Verifica se a ordenacão foi preenchida
    case Cb_Ordena.ItemIndex of
      0 : Lb_Ordenacao.Caption := 'Descricão';
      1 : Lb_Ordenacao.caption := 'Código de Fábrica';
      2 : Lb_Ordenacao.Caption := 'Código Interno';
    end;
    // Verifica opcão Sem movimento

    // Verifica opcão Estoque Minimo
    if ChBx_Est_Min.Checked = true then
      begin
      Lb_Estoq_Min.Caption := SIM
      end
    else
      begin
      Lb_Estoq_Min.Caption := NAO;
      end;
    // Verifica opcão Saldo Positivo
    if ChBx_Positivo.Checked = true then
      begin
      Lb_Saldo_Positivo.Caption := SIM
      end
    else
      begin
      Lb_Saldo_Positivo.Caption := NAO;
      end;
    // Verifica opcão Mostrar Inativos
    if ChBx_Inativos.Checked = true then
      begin
      Lb_Inativos.Caption := SIM
      end
    else
      begin
      Lb_Inativos.Caption := NAO;
      end;
    end;
end;

procedure TRL_MovimentoProduto.QRBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  if It_Divergencia then
    Begin
    Divergencia.Lines.SaveToFile(It_caminhoErro);
    Pc_Executar_Arquivo(It_caminhoErro);
    end;
end;

procedure TRL_MovimentoProduto.Grp_ProdutoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Fr_Imp_Produtos.Chbx_AnaliseMovimento.Checked then
  Begin
    Lb_UlttimoInventario.Caption := 'Saldo Anterior';
    if Trim(Fr_Imp_Produtos.Fm_ListaEstoques.DBLCB_Estoque.Text)<> '' then
      It_Qt_SaldoAnterior := Fc_SaldoAnteriorEstoque(Qr_Produtos.FieldByName('CET_CODPRO').AsInteger,Fr_Imp_Produtos.Fm_ListaEstoques.DBLCB_Estoque.KeyValue,Fr_Imp_Produtos.E_Data_Ini.Date)
    else
      It_Qt_SaldoAnterior := Fc_SaldoAnteriorEstoque(Qr_Produtos.FieldByName('CET_CODPRO').AsInteger,0,Fr_Imp_Produtos.E_Data_Ini.Date);
    It_Qt_Acumulada  := It_Qt_SaldoAnterior;
  end
  else
  Begin
    //Inventário
    Lb_UlttimoInventario.Caption := 'último Inventário';
    It_Qt_Inventario := Fc_SaldoInventario(Qr_Produtos.FieldByName('CET_CODPRO').AsInteger,
                                           Fr_Imp_Produtos.Fm_LME.Dblcb_Lista.KeyValue,
                                           DataInventario);
    It_Qt_Acumulada  := It_Qt_Inventario;
  end;
end;

end.
