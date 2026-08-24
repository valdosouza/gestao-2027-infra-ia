unit Un_RL_CadastroProduto;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_Report, QuickRpt, QRCtrls, Data.DB, STQuery, Vcl.ExtCtrls;

type
  TRL_CadastroProduto = class(TRL_Report)
    QRGroup3: TQRGroup;
    QRDBText3: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel27: TQRLabel;
    QRGroup2: TQRGroup;
    QRDBText2: TQRDBText;
    QRBand1: TQRBand;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    E_CODPRODUTO: TQRDBText;
    QRDBText7: TQRDBText;
    Lb_Margem: TQRLabel;
    procedure Pc_Buscar; Override;
  private
    { Private declarations }

  public
    { Public declarations }
    It_Cd_Estoque : Integer;
    It_Grupos, It_SubGrupos, Lc_SubGrupo, It_Marca, It_Produto,It_Empresa : String;
  end;

var
  RL_CadastroProduto: TRL_CadastroProduto;

implementation

{$R *.dfm}

procedure RL_CadastroProduto.Pc_Buscar;
VaR
  SqlTxt:String;
begin
  with Qr_Consulta do
  Begin
    SQL.Clear;
    SqlTxt:='SELECT DISTINCT pro.PRO_CODIGO,pro.PRO_CODIGOFAB,pro.PRO_CODIGOFOR,pro.PRO_DESCRICAO, '+
            '  med.MED_DESCRICAO,pro.PRO_CODGRP,grp.GRP_DESCRICAO,pro.PRO_CODSBG,sbg.SBG_DESCRICAO, '+
            '  pro.PRO_CODIGONCM,pro.pro_peso,mar.MRC_DESCRICAO,pro.pro_vl_fabrica,pro.pro_vl_customed, '+
            '  pro.PRO_VL_CUSTO,pre.PRC_VL_VDA ,pre.PRC_MAR_LRC '+
            '  FROM TB_PRODUTO pro '+
            '     INNER JOIN TB_ESTOQUE est '+
            '     ON (est.EST_CODPRO = pro.PRO_CODIGO) '+
            '     INNER JOIN TB_GRUPOS grp '+
            '     ON  (pro.PRO_CODGRP = grp.GRP_CODIGO) '+
            '     INNER JOIN TB_SUBGRUPOS sbg '+
            '     ON  (pro.PRO_CODSBG = sbg.SBG_CODIGO) '+
            '     inner join tb_medida med '+
            '     ON(med.med_codigo = pro.pro_codmed) '+
            '     INNER JOIN TB_MARCA_PRODUTO mar '+
            '     ON  (pro.PRO_CODMRC = mar.mrc_CODIGO) '+
            '     INNER JOIN TB_PRECO PRE '+
            '     ON (PRE.PRC_CODPRO = pro.PRO_CODIGO)' ;

    if (It_Empresa <> '') then
    Begin
      SqlTxt:= SqlTxt +
            '   INNER JOIN TB_PROD_FORN Tb_prod_forn  '+
            '   ON  (Tb_prod_forn.PFR_CODPRO = pro.PRO_CODIGO) '+
            '   INNER JOIN  TB_EMPRESA Tb_fornecedor '+
            '   ON  (Tb_prod_forn.PFR_CODFOR = Tb_fornecedor.EMP_CODIGO) ';
    end;

    SqlTxt:= SqlTxt + 'WHERE  ((PRO_TIPO = ''P'') OR (PRO_TIPO = ''M'') OR (PRO_TIPO = ''C'')) ';

    if not It_MultiEmpresa then
    Begin
      if not It_CompartilhaME then
        Sqltxt := Sqltxt + ' AND PRO_CODMHA = :PRO_CODMHA ';
    end
    else
    Begin
      if (not It_EmpresaSelecionada) and (not It_CompartilhaME) then
        Sqltxt := Sqltxt + ' AND PRO_CODMHA = :PRO_CODMHA ';
    end;

    if It_Cd_Estoque > 0  then
      Sqltxt := Sqltxt + ' AND EST_CODETS = :ETS_CODIGO ';

    if Trim(It_Grupos)    <> '' then SqlTxt := SqlTxt +'AND (PRO_CODGRP =:PRO_CODGRP) ';
    if Trim(It_SubGrupos) <> '' then SqlTxt := SqlTxt +'AND (PRO_CODSBG =:PRO_CODSBG) ';
    if Trim(It_Marca)     <> '' then SqlTxt := SqlTxt +'AND (PRO_CODMRC =:PRO_CODMRC) ';
    if Trim(It_Produto)   <> '' then SqlTxt := SqlTxt +'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';
    if Trim(It_Empresa)   <> '' then SqlTxt := SqlTxt +'AND (PFR_CODFOR =:PFR_CODFOR) ';


    if It_Estoque_Minimo then SqlTxt := SqlTxt +'AND (EST_QTDE <= PRO_QTDE_MIN)';
    if It_Saldo_Positivo then SqlTxt := SqlTxt +'AND (EST_QTDE > 0)';
    if It_Saldo_Negativo then SqlTxt := SqlTxt +'AND (EST_QTDE < 0)';
    if It_Produtos_Ativos then SqlTxt := SqlTxt +'AND (PRO_ATIVO = ''S'') ';

    SqlTxt := SqlTxt +'AND (PRC_CODTPR=:PRC_CODTPR) ';

    if Fr_Imp_Produtos.CB_Ordena.ItemIndex = 0 then
      Qr_Produtos.SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_DESCRICAO')
    else
      if Fr_Imp_Produtos.CB_Ordena.ItemIndex = 1 then
        Qr_Produtos.SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGOFAB')
      else
        Qr_Produtos.SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGO');

    Qr_Produtos.ParamByName('PRC_CODTPR').AsInteger:= DBLCB_Tabela_Preco.KeyValue;

    if not Grb_MnhaEmpresa.Visible then
      Begin
      if not GB_ProdCompartilha then
        Qr_Produtos.ParamByName('PRO_CODMHA').AsInteger:= Gb_CodMha;
      end
    else
      Begin
      if (not chbx_Empresas.Checked) and (not GB_ProdCompartilha) then
        Qr_Produtos.ParamByName('PRO_CODMHA').AsInteger:= Dblcb_Mha_Empresa.KeyValue;
      end;
    if trim(DBLCB_Estoque.Text) <> '' then
      Qr_Produtos.ParamByName('ETS_CODIGO').AsInteger:= DBLCB_Estoque.KeyValue;

    if Lc_Grupo then Qr_Produtos.ParamByName('PRO_CODGRP').AsInteger:=DBLCB_Grupos.KeyValue;
    if Lc_SubGrupo then Qr_Produtos.ParamByName('PRO_CODSBG').AsInteger:=DBLCB_SubGrupos.KeyValue;
    if Lc_Marca then Qr_Produtos.ParamByName('PRO_CODMRC').AsInteger:=DBLCB_Marca.KeyValue;
    if Lc_Fornece then Qr_Produtos.ParamByName('PFR_CODFOR').AsInteger:=DBLCB_Empresa.KeyValue;
    if Lc_Produto then Qr_Produtos.ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(E_Busca_Produto.Text,1,98) + '%';
    end;
  Qr_Produtos.Open;
  Screen.Cursor:=crDefault;
end;

end.
