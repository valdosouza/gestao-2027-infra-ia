unit UN_RL_ANAL_ALT_PRECO;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_ANAL_ALT_PRECO = class(TForm)
    Qrpt: TQuickRep;
    QRGroup1: TQRGroup;
    QRDBText1: TQRDBText;
    Qr_Produtos: TSTQuery;
    QRGroup2: TQRGroup;
    QRDBText2: TQRDBText;
    QRGroup3: TQRGroup;
    QRDBText3: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand1: TQRBand;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    E_CODPRODUTO: TQRDBText;
    QRBand2: TQRBand;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    QRSysData3: TQRSysData;
    Ft_SubGrupo: TQRBand;
    QRLabel6: TQRLabel;
    QRExpr1: TQRExpr;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    QRBand3: TQRBand;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel20: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Estoque: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Lb_Tab_Preco: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Ordenacao: TQRLabel;
    QRLabel22: TQRLabel;
    Lb_Gerar_Invent: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    Lb_Grupo: TQRLabel;
    QRLabel11: TQRLabel;
    Lb_Subgrupo: TQRLabel;
    QRLabel19: TQRLabel;
    Lb_Marca: TQRLabel;
    QRLabel23: TQRLabel;
    Lb_Empresa: TQRLabel;
    QRLabel24: TQRLabel;
    Lb_Estoq_Min: TQRLabel;
    QRLabel25: TQRLabel;
    Lb_Saldo_Positivo: TQRLabel;
    QRLabel26: TQRLabel;
    Lb_Inativos: TQRLabel;
    QRLabel27: TQRLabel;
    QRDBText7: TQRDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  procedure Pc_Busca;
  procedure Pc_Parametros;
  end;

var
  RL_ANAL_ALT_PRECO: TRL_ANAL_ALT_PRECO;

implementation

uses     Un_DM, UN_Imp_Produtos, UN_Aniversariante, UN_Sistema, ComCtrls, env;
{$R *.dfm}

procedure TRL_ANAL_ALT_PRECO.Pc_Parametros;
begin
  with Fr_Imp_Produtos do
    begin
    // Verifica tipos de documento
    case LBx_TipoRelatorio.ItemIndex of
      0 : Lb_Tipo_Doc.Caption := 'Cadastro de Produtos';
      1 : Lb_Tipo_Doc.Caption := 'Saldo do Estoque';
      2 : Lb_Tipo_Doc.Caption := 'Movimentação';
      3 : Lb_Tipo_Doc.Caption := 'Tabela de Produção';
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
    // Verifica se a ordenação foi preenchida
    case Cb_Ordena.ItemIndex of
      0 : Lb_Ordenacao.Caption := 'Descrição';
      1 : Lb_Ordenacao.caption := 'Código de Fábrica';
      2 : Lb_Ordenacao.Caption := 'Código Interno';
    end;
    // Verifica opção Sem movimento

    // Verifica opção Estoque Minimo
    if ChBx_Est_Min.Checked = true then
      begin
      Lb_Estoq_Min.Caption := SIM
      end
    else
      begin
      Lb_Estoq_Min.Caption := NAO;
      end;
    // Verifica opção Saldo Positivo
    if ChBx_Positivo.Checked = true then
      begin
      Lb_Saldo_Positivo.Caption := SIM
      end
    else
      begin
      Lb_Saldo_Positivo.Caption := NAO;
      end;
    // Verifica opção Mostrar Inativos
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

procedure TRL_ANAL_ALT_PRECO.Pc_Busca;
VaR
  SqlTxt:String;
  Lc_produto, Lc_Grupo, Lc_SubGrupo,Lc_Marca, Lc_Fornece:Boolean;
begin
  Qr_Produtos.Close;
  Qr_Produtos.SQL.Clear;

  SQLtxt := 'SELECT DISTINCT PRO_CODIGO, PRO_DESCRICAO, PRO_CODGRP, GRP_DESCRICAO,  '+
            'PRO_CODSBG, SBG_DESCRICAO, PRO_VL_CUSTOANT, PRO_VL_CUSTO, PRC_VL_VDA   '+
            'FROM TB_PRODUTO tb_produto                                             '+
            '  INNER JOIN TB_ITENS_NFL tb_itens_nfl                                 '+
            '  ON (tb_itens_nfl.ITF_CODPRO = tb_produto.PRO_CODIGO )                '+
            '  INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal                             '+
            '  ON (tb_nota_fiscal.NFL_CODIGO = tb_itens_nfl.ITF_CODNFL )            '+
            '  INNER JOIN TB_GRUPOS tb_grupo                                        '+
            '  ON  (tb_produto.PRO_CODGRP = tb_grupo.GRP_CODIGO)                    '+
            '  INNER JOIN TB_SUBGRUPOS tb_subgrupo                                  '+
            '  ON  (tb_produto.PRO_CODSBG = tb_subgrupo.SBG_CODIGO)                 '+
            '  INNER JOIN TB_PRECO tb_preco                                         '+
            '  ON (tb_preco.PRC_CODPRO = tb_produto.PRO_CODIGO)                     '+
            '  INNER JOIN  TB_PROD_FORN Tb_prod_forn                                '+
            '   ON  (Tb_prod_forn.PFR_CODPRO = Tb_produto.PRO_CODIGO)               '+
            'WHERE (NFL_TIPO = ''EE'')                                ';

  if Fr_Imp_Produtos.DBLCB_Grupos.Text ='' then Lc_Grupo := False else Lc_Grupo := True;
  if Fr_Imp_Produtos.DBLCB_SubGrupos.Text ='' then Lc_SubGrupo := False else Lc_SubGrupo := True;
  if Fr_Imp_Produtos.DBLCB_Marca.Text ='' then Lc_Marca := False else Lc_Marca := True;
  if Fr_Imp_Produtos.DBLCB_Empresa.Text ='' then Lc_Fornece := False else Lc_Fornece := True;
  if Fr_Imp_Produtos.E_BuscaCodigoProduto.Text ='' then Lc_produto := False else Lc_produto := True;
  if Lc_Grupo then SqlTxt := SqlTxt +'AND (PRO_CODGRP =:PRO_CODGRP) ';
  if Lc_SubGrupo then SqlTxt := SqlTxt +'AND (PRO_CODSBG =:PRO_CODSBG) ';
  if Lc_Marca then SqlTxt := SqlTxt +'AND (PRO_CODMRC =:PRO_CODMRC) ';
  if Lc_Fornece then SqlTxt := SqlTxt +'AND (PFR_CODFOR =:PFR_CODFOR) ';
  if Lc_Produto then SqlTxt := SqlTxt +'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';
  if Fr_Imp_Produtos.ChBx_Periodo.Checked then
    SqlTxt := SqlTxt +'AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ';
  SqlTxt := SqlTxt +'AND (PRC_CODTPR=:PRC_CODTPR) ';

  if Fr_Imp_Produtos.Chbx_AlteracaoPrecoCompra.Checked then
    SqlTxt := SqlTxt +'AND (PRO_VL_CUSTOANT <> PRO_VL_CUSTO) ';

  if Fr_Imp_Produtos.CB_Ordena.ItemIndex = 0 then
    Qr_Produtos.SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_DESCRICAO ASC ')
  else
    if Fr_Imp_Produtos.CB_Ordena.ItemIndex = 1 then
      Qr_Produtos.SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGO ASC ')
    else
      Qr_Produtos.SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGO ASC ');

  Qr_Produtos.ParamByName('PRC_CODTPR').AsInteger:= Fr_Imp_Produtos.DBLCB_Tabela_Preco.KeyValue;

  if Lc_Grupo then Qr_Produtos.ParamByName('PRO_CODGRP').AsInteger:=Fr_Imp_Produtos.DBLCB_Grupos.KeyValue;
  if Lc_SubGrupo then Qr_Produtos.ParamByName('PRO_CODSBG').AsInteger:=Fr_Imp_Produtos.DBLCB_SubGrupos.KeyValue;
  if Lc_Marca then Qr_Produtos.ParamByName('PRO_CODMRC').AsInteger:=Fr_Imp_Produtos.DBLCB_Marca.KeyValue;
  if Lc_Fornece then Qr_Produtos.ParamByName('PFR_CODFOR').AsInteger:=Fr_Imp_Produtos.DBLCB_Empresa.KeyValue;
  if Fr_Imp_Produtos.ChBx_Periodo.Checked then
    begin
    Qr_Produtos.ParamByName('DATAINI').AsDate := Fr_Imp_Produtos.E_Data_Ini.Date;
    Qr_Produtos.ParamByName('DATAFIM').AsDate := Fr_Imp_Produtos.E_Data_Fim.Date;
    end;
  if Lc_Produto then Qr_Produtos.ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(Fr_Imp_Produtos.E_BuscaCodigoProduto.Text,1,98) + '%';
  Qr_Produtos.Open;
  Screen.Cursor:=crDefault;
end;

procedure TRL_ANAL_ALT_PRECO.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(QRPT);
  Action:=caFree;
  RL_ANAL_ALT_PRECO :=nil;
end;

procedure TRL_ANAL_ALT_PRECO.QrptBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
end;


procedure TRL_ANAL_ALT_PRECO.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_Parametros;
end;

end.
