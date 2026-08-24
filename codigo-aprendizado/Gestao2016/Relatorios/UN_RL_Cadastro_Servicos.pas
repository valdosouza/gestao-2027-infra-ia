unit UN_RL_Cadastro_Servicos;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_Cadastro_Servicos = class(TForm)
    Qrpt: TQuickRep;
    QRGroup1: TQRGroup;
    QRDBText1: TQRDBText;
    Qr_Produtos: TSTQuery;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    QRSysData3: TQRSysData;
    QRGroup2: TQRGroup;
    QRDBText2: TQRDBText;
    QRGroup3: TQRGroup;
    QRDBText3: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand1: TQRBand;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    E_CODPRODUTO: TQRDBText;
    QRBand2: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    Ft_SubGrupo: TQRBand;
    QRLabel6: TQRLabel;
    QRExpr1: TQRExpr;
    QRBand3: TQRBand;
    QRLabel12: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Ordenacao: TQRLabel;
    QRLabel10: TQRLabel;
    Lb_Grupo: TQRLabel;
    QRLabel11: TQRLabel;
    Lb_Subgrupo: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  procedure Pc_Busca;
  procedure Pc_Parametros;
  function Fc_Calc_Mrg_Valor():String;
  end;

var
  RL_Cadastro_Servicos: TRL_Cadastro_Servicos;

implementation

uses     Un_DM, UN_Imp_Produtos, UN_Aniversariante, UN_Sistema;
{$R *.dfm}

procedure TRL_Cadastro_Servicos.Pc_Busca;
VaR
  SqlTxt:String;
  Lc_Grupo, Lc_SubGrupo, Lc_Marca, Lc_Fornece, Lc_Produto: Boolean;
begin
  Qr_Produtos.Close;
  Qr_Produtos.SQL.Clear;
  with Fr_Imp_Produtos do
    Begin
    if DBLCB_Grupos.Text ='' then Lc_Grupo := False else Lc_Grupo := True;
    if DBLCB_SubGrupos.Text ='' then Lc_SubGrupo := False else Lc_SubGrupo := True;
    if DBLCB_Marca.Text ='' then Lc_Marca := False else Lc_Marca := True;
    if E_BuscaDescricaoProduto.Text ='' then Lc_Produto := False else Lc_Produto := True;
    if Trim(DBLCB_Empresa.Text) = '' then Lc_Fornece := False else Lc_Fornece := true;
    
    SqlTxt:='SELECT DISTINCT PRO_CODIGO, PRO_DESCRICAO,  PRO_CODGRP, PRO_CODSBG, PRO_VL_CUSTO, '+
            'PRC_VL_VDA , GRP_DESCRICAO, SBG_DESCRICAO,  PRO_CODIGOFAB, PRC_MAR_LRC '+
            'FROM TB_PRODUTO Tb_produto '+
            '   INNER JOIN TB_ESTOQUE tb_estoque '+
            '   ON (tb_estoque.EST_CODPRO = tb_produto.PRO_CODIGO) '+
            '   INNER JOIN TB_GRUPOS Tb_grupos '+
            '   ON  (Tb_produto.PRO_CODGRP = Tb_grupos.GRP_CODIGO) '+
            '   INNER JOIN TB_SUBGRUPOS Tb_subgrupos '+
            '   ON  (Tb_produto.PRO_CODSBG = Tb_subgrupos.SBG_CODIGO) '+
            '   INNER JOIN TB_PRECO PRE ' +
            '   ON (PRE.PRC_CODPRO = Tb_produto.PRO_CODIGO) ' ;

  SqlTxt:= SqlTxt + 'WHERE  (PRO_TIPO = ''S'') ';

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      SqlTxt:= SqlTxt + ' AND (PRO_CODMHA =:PRO_CODMHA) ' ;

    if trim(Fm_ListaEstoques.DBLCB_Estoque.Text) <> '' then
      Sqltxt := Sqltxt + ' AND EST_CODETS = :ETS_CODIGO ';
    

    if Lc_Grupo then SqlTxt := SqlTxt +'AND (PRO_CODGRP =:PRO_CODGRP) ';
    if Lc_SubGrupo then SqlTxt := SqlTxt +'AND (PRO_CODSBG =:PRO_CODSBG) ';
    if Lc_Produto then SqlTxt := SqlTxt +'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

    if not Fr_Imp_Produtos.Chbx_Inativos.Checked then SqlTxt := SqlTxt +'AND (PRO_ATIVO = ''S'') ';

    SqlTxt := SqlTxt +'AND (PRC_CODTPR=:PRC_CODTPR) ';

    if Fr_Imp_Produtos.CB_Ordena.ItemIndex = 0 then
      Qr_Produtos.SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_DESCRICAO')
    else
      if Fr_Imp_Produtos.CB_Ordena.ItemIndex = 1 then
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
    if Lc_Produto then Qr_Produtos.ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(E_BuscaDescricaoProduto.Text,1,98) + '%';
    end;
  Qr_Produtos.Open;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Cadastro_Servicos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  FreeAndNil(QRPT);
//  Action:=caFree;
//  RL_Cadastro_Servicos:=nil;
end;

procedure TRL_Cadastro_Servicos.QrptBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  if Fr_Imp_Produtos.CB_Ordena.ItemIndex = 1 then
    Begin
    E_CODPRODUTO.DataField := 'PRO_CODIGOFAB';
    end
  else
    BEgin
    E_CODPRODUTO.DataField := 'PRO_CODIGO';
    end;
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Cadastro_Servicos.Pc_Parametros;
begin
  with Fr_Imp_Produtos do
    begin
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
    // Verifica se a ordenção foi preenchida
    case Cb_Ordena.ItemIndex of
      0 : Lb_Ordenacao.Caption := 'Descrição';
      1 : Lb_Ordenacao.caption := 'Código de F�brica';
      2 : Lb_Ordenacao.Caption := 'Código Interno';
    end;
    end;
end;

function TRL_Cadastro_Servicos.Fc_Calc_Mrg_Valor():String;
var
  Lc_Vl_Margem: Double;
  Lc_Vl_Venda: Double;
begin
  Lc_Vl_Margem:= 0;
  Lc_Vl_Venda := 0;

  Lc_Vl_Venda :=  Qr_Produtos.fieldbyname('PRC_VL_VDA').AsCurrency;

  if (Fc_Tb_Geral('L','PRO_G_CALC_MRG_LUCRO','') = '1') then
    Begin
    if Lc_Vl_Venda > 0 then
      Lc_Vl_Margem := (1-(Qr_Produtos.fieldbyname('PRO_VL_CUSTO').AsCurrency / Lc_Vl_Venda))*100
    else
      Lc_Vl_Margem := (1-(Qr_Produtos.fieldbyname('PRO_VL_CUSTO').AsCurrency / 1))*100;
    end;
  if (Fc_Tb_Geral('L','PRO_G_CALC_MRG_LUCRO','') = '2') then
    Begin
    if Qr_Produtos.fieldbyname('PRO_VL_CUSTO').AsCurrency > 0 then
      Lc_Vl_Margem := ((Lc_Vl_Venda - Qr_Produtos.fieldbyname('PRO_VL_CUSTO').AsCurrency)/Qr_Produtos.fieldbyname('PRO_VL_CUSTO').AsCurrency)*100
    else
      Lc_Vl_Margem := ((Lc_Vl_Venda - Qr_Produtos.fieldbyname('PRO_VL_CUSTO').AsCurrency)/1)*100;
    end;
  Result := FloatToStrF(Lc_Vl_Margem,ffFixed,4,2);
end;

end.
