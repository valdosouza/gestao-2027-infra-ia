unit UN_RL_TabelaProdutos;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, jpeg, QRCtrls, QRExport, DB, QuickRpt, ExtCtrls, STQuery, QRPDFFilt;

type
  TRL_TabelaProduto = class(TForm)
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    QRLabel10: TQRLabel;
    QRLabel15: TQRLabel;
    QRGroup1: TQRGroup;
    QRDBText1: TQRDBText;
    QRGroup2: TQRGroup;
    QRDBText2: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand2: TQRBand;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    Qr_Produtos: TSTQuery;
    QRBand3: TQRBand;
    QRLabel4: TQRLabel;
    QRLabel1: TQRLabel;
    Lb_Tab_Preco: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel19: TQRLabel;
    Lb_Grupo: TQRLabel;
    QRLabel23: TQRLabel;
    Lb_Subgrupo: TQRLabel;
    QRLabel24: TQRLabel;
    Lb_Marca: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    E_Un_emb: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  procedure Pc_Busca;
  procedure Pc_Parametros;
  end;

var
  RL_TabelaProduto: TRL_TabelaProduto;

implementation

uses     Un_DM, UN_Imp_Produtos, UN_Sistema;
{$R *.dfm}


procedure TRL_TabelaProduto.Pc_Busca;
VaR
  SqlTxt:String;
  Lc_Grupo, Lc_SubGrupo, Lc_Marca,Lc_Fornece, Lc_Produto: Boolean;
begin
  with Fr_Imp_Produtos do
  Begin
    Qr_Produtos.Close;
    Qr_Produtos.SQL.Clear;
    if DBLCB_Grupos.Text ='' then Lc_Grupo := False else Lc_Grupo := True;
    if DBLCB_SubGrupos.Text ='' then Lc_SubGrupo := False else Lc_SubGrupo := True;
    if DBLCB_Marca.Text ='' then Lc_Marca := False else Lc_Marca := True;
    if DBLCB_Empresa.Text ='' then Lc_Fornece := False else Lc_Fornece := True;
    if E_BuscaDescricaoProduto.Text ='' then Lc_Produto := False else Lc_Produto := True;
    SqlTxt:='SELECT DISTINCT PRO_CODIGO, PRO_DESCRICAO,  PRO_CODGRP, PRO_CODSBG,  '+
            'PRC_VL_VDA , GRP_DESCRICAO, SBG_DESCRICAO,  PRO_CODIGOFAB, EMB_DESCRICAO, MED_DESCRICAO, PRO_DIVISOR '+
            'FROM TB_PRODUTO Tb_produto '+
            '   INNER JOIN TB_ESTOQUE tb_estoque '+
            '   ON (tb_estoque.EST_CODPRO = tb_produto.PRO_CODIGO) '+
            '   INNER JOIN TB_GRUPOS Tb_grupos '+
            '   ON  (Tb_produto.PRO_CODGRP = Tb_grupos.GRP_CODIGO) '+
            '   INNER JOIN TB_SUBGRUPOS Tb_subgrupos '+
            '   ON  (Tb_produto.PRO_CODSBG = Tb_subgrupos.SBG_CODIGO) '+
            '   INNER JOIN TB_MEDIDA Tb_medida '+
            '   ON  (Tb_medida.MED_CODIGO = Tb_produto.PRO_CODMED) '+
            '   LEFT OUTER JOIN TB_EMBALAGEM Tb_embalagem '+
            '   ON  (Tb_embalagem.EMB_CODIGO = Tb_produto.PRO_CODEMB) '+
            '   INNER JOIN TB_PRECO PRE ' +
            '   ON (PRE.PRC_CODPRO = Tb_produto.PRO_CODIGO) ' ;

    if Lc_Fornece then
    Begin
      SqlTxt:= SqlTxt + '  INNER JOIN TB_PROD_FORN Tb_prod_forn '+
                        '   ON  (Tb_prod_forn.PFR_CODPRO = Tb_produto.PRO_CODIGO) '+
                        '   INNER JOIN  TB_EMPRESA Tb_fornecedor '+
                        '   ON  (Tb_prod_forn.PFR_CODFOR = Tb_fornecedor.EMP_CODIGO) ';
    end;

    SqlTxt:= SqlTxt + 'WHERE (PRO_IMPRIME=''S'') AND ((PRO_TIPO = ''P'') OR (PRO_TIPO = ''M'')OR (PRO_TIPO = ''C'')) ';

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      SqlTxt:= SqlTxt + ' AND (PRO_CODMHA =:PRO_CODMHA) ' ;

    if trim(Fm_ListaEstoques.DBLCB_Estoque.Text) <> '' then
      Sqltxt := Sqltxt + ' AND EST_CODETS = :ETS_CODIGO ';

    if Lc_Grupo then SqlTxt := SqlTxt +'AND (PRO_CODGRP =:PRO_CODGRP) ';
    if Lc_SubGrupo then SqlTxt := SqlTxt +'AND (PRO_CODSBG =:PRO_CODSBG) ';
    if Lc_Marca then SqlTxt := SqlTxt +'AND (PRO_CODMRC =:PRO_CODMRC) ';
    if Lc_Fornece then SqlTxt := SqlTxt +'AND (PFR_CODFOR =:PFR_CODFOR) ';
    if Lc_Produto then SqlTxt := SqlTxt +'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

    if ChBx_InternetPublished.Checked then
      SqlTxt := SqlTxt +'AND ( PRO_INTERNET = ''S'' ) ';


    //Sobre as TAbelas de Pre�o
    SqlTxt := SqlTxt +'AND ( PRC_CODTPR =:PRC_CODTPR ) ';
    if (DBLCB_Tabela_Preco.KeyValue = 2) then
    Begin
      SqlTxt := SqlTxt +'AND ( PRO_CAMPANHA = ''S'') ';
      SqlTxt := SqlTxt +'AND ( PRC_VL_VDA > 0) ';
    end;

    if ChBx_Est_Min.Checked then SqlTxt := SqlTxt + ' AND ( (EST_QTDE < PRO_QTDE_MIN) AND (PRO_QTDE_MIN > 0) )';
    if Chbx_Positivo.Checked then SqlTxt := SqlTxt +'AND (EST_QTDE > 0)';
    if chbx_negativo.Checked then SqlTxt := SqlTxt +'AND (EST_QTDE < 0)';
    if not Chbx_Inativos.Checked then SqlTxt := SqlTxt +'AND (PRO_ATIVO = ''S'') ';
    if Chbx_Vl_Venda_Maior_Zero.Checked then SqlTxt := SqlTxt +'AND (PRC_VL_VDA > 0) ';

    if CB_Ordena.ItemIndex = 0 then
      Qr_Produtos.SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_DESCRICAO')
    else
      if CB_Ordena.ItemIndex = 1 then
        Qr_Produtos.SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGOFAB')
      else
        Qr_Produtos.SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGO');

    Qr_Produtos.ParamByName('PRC_CODTPR').AsInteger:= DBLCB_Tabela_Preco.KeyValue;

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      Qr_Produtos.ParamByName('PRO_CODMHA').AsInteger:= Fm_LME.Dblcb_Lista.KeyValue;

    if trim(Fm_ListaEstoques.DBLCB_Estoque.Text) <> '' then
      Qr_Produtos.ParamByName('ETS_CODIGO').AsInteger:= Fm_ListaEstoques.DBLCB_Estoque.KeyValue;


    if Lc_Grupo then Qr_Produtos.ParamByName('PRO_CODGRP').AsInteger:=DBLCB_Grupos.KeyValue;
    if Lc_SubGrupo then Qr_Produtos.ParamByName('PRO_CODSBG').AsInteger:=DBLCB_SubGrupos.KeyValue;
    if Lc_Marca then Qr_Produtos.ParamByName('PRO_CODMRC').AsInteger:=DBLCB_Marca.KeyValue;
    if Lc_Fornece then Qr_Produtos.ParamByName('PFR_CODFOR').AsInteger:=DBLCB_Empresa.KeyValue;
    if Lc_Produto then Qr_Produtos.ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(E_BuscaDescricaoProduto.Text,1,98) + '%';

    Qr_Produtos.Open;
    Screen.Cursor:=crDefault;
    end;
end;


procedure TRL_TabelaProduto.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
//  Pc_Parametros;
end;

procedure TRL_TabelaProduto.Pc_Parametros;
begin
  with Fr_Imp_Produtos do
    begin    // Verifica data de Inatividade da empresa solicitada
    // Verifica se o campo Tabela de Pre�o
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
    end;
end;

procedure TRL_TabelaProduto.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if (Qr_Produtos.FieldByName('PRO_DIVISOR').AsFloat > 0) AND (not Qr_Produtos.FieldByName('PRO_DIVISOR').IsNull) then
    E_Un_emb.Caption := FloatToStrF(Qr_Produtos.FieldByName('PRC_VL_VDA').AsCurrency/Qr_Produtos.FieldByName('PRO_DIVISOR').AsFloat,ffFixed,10,2)
  else
    E_Un_emb.Caption := FloatToStrF(Qr_Produtos.FieldByName('PRC_VL_VDA').AsCurrency/1,ffFixed,10,2);
end;

procedure TRL_TabelaProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(QRPT);
  Action:=caFree;
  RL_TabelaProduto := nil;
end;

end.
