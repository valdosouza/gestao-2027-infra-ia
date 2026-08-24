unit Un_RL_Reposicao;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, QuickRpt, QRCtrls, DB, STQuery;

type
  TRL_Reposicao = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    QRGroup1: TQRGroup;
    QRDBText1: TQRDBText;
    QRGroup2: TQRGroup;
    QRDBText2: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand1: TQRBand;
    QRDBText3: TQRDBText;
    E_CODPRODUTO: TQRDBText;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    QRSysData3: TQRSysData;
    QRLabel1: TQRLabel;
    QRLabel10: TQRLabel;
    Qr_Produtos: TSTQuery;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel9: TQRLabel;
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
    QRLabel11: TQRLabel;
    QRLabel15: TQRLabel;
    Lb_Grupo: TQRLabel;
    QRLabel19: TQRLabel;
    Lb_Subgrupo: TQRLabel;
    QRLabel23: TQRLabel;
    Lb_Marca: TQRLabel;
    QRLabel24: TQRLabel;
    Lb_Empresa: TQRLabel;
    QRLabel25: TQRLabel;
    Lb_Sem_Movi: TQRLabel;
    QRLabel26: TQRLabel;
    Lb_Estoq_Min: TQRLabel;
    QRLabel27: TQRLabel;
    Lb_Saldo_Positivo: TQRLabel;
    QRLabel28: TQRLabel;
    Lb_Inativos: TQRLabel;
    Lb_Tabela_Preco: TQRLabel;
    E_Reposicao: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_VL_SubTotal: Currency;
    It_VL_Total: Currency;
    It_Qt_Total: Currency;
    It_Qt_SubTotal: Currency;
  procedure Pc_Busca;
  procedure Pc_Parametros;
  end;

var
  RL_Reposicao: TRL_Reposicao;

implementation

uses     Un_DM, UN_Imp_Produtos, UN_Sistema, ComCtrls, Un_Regra_Negocio, env;
{$R *.dfm}


procedure TRL_Reposicao.Pc_Busca;
VaR
  Lc_SqlTxt :String;
  Lc_Grupo, Lc_SubGrupo,Lc_Marca, Lc_Produto, Lc_Fornece:Boolean;
begin
  with Fr_Imp_Produtos do
    Begin
    Screen.Cursor:=crHourGlass;
    It_VL_SubTotal := 0;
    It_VL_Total := 0;
    It_Qt_Total := 0;
    It_Qt_SubTotal := 0;

    if Trim(DBLCB_Grupos.Text) =''     then Lc_Grupo := False else Lc_Grupo := True;
    if Trim(DBLCB_SubGrupos.Text) = '' then Lc_SubGrupo := False else Lc_SubGrupo := True;
    if Trim(DBLCB_Marca.Text) =''      then Lc_Marca := False else Lc_Marca := True;
    if Trim(DBLCB_Empresa.Text) =''   then Lc_Fornece := False else Lc_Fornece := True;
    if Trim(E_BuscaDescricaoProduto.Text) = '' then Lc_Produto := False else Lc_Produto := True;

    Qr_Produtos.Close;
    Qr_Produtos.SQL.Clear;

    Lc_SqlTxt:='SELECT DISTINCT PRO_CODIGO, PRO_CODIGOFAB, PRO_DESCRICAO, PRO_QTDE_MIN, PRO_CODGRP, '+
            ' PRO_CODSBG,GRP_DESCRICAO, SBG_DESCRICAO, CAST(COALESCE(SUM(EST_QTDE), 0) AS DOUBLE PRECISION) EST_QTDE '+
            'FROM TB_PRODUTO Tb_produto '+
            '   INNER JOIN TB_ESTOQUE tb_estoque '+
            '   ON (tb_estoque.EST_CODPRO = tb_produto.PRO_CODIGO) '+
            '   INNER JOIN TB_GRUPOS Tb_grupos '+
            '   ON  (Tb_produto.PRO_CODGRP = Tb_grupos.GRP_CODIGO) '+
            '   INNER JOIN TB_SUBGRUPOS Tb_subgrupos  '+
            '   ON  (Tb_produto.PRO_CODSBG = Tb_subgrupos.SBG_CODIGO) ';
    if (Lc_Fornece) then
      Begin
      Lc_SqlTxt:= Lc_SqlTxt +
              '   LEFT OUTER JOIN TB_PROD_FORN Tb_prod_forn '+
              '   ON  (Tb_prod_forn.PFR_CODPRO = Tb_produto.PRO_CODIGO) '+
              '   LEFT OUTER JOIN  TB_EMPRESA Tb_fornecedor '+
              '   ON  (Tb_prod_forn.PFR_CODFOR = Tb_fornecedor.EMP_CODIGO) ';
      end;
    Lc_SqlTxt:= Lc_SqlTxt +
            'WHERE (PRO_IMPRIME=''S'') AND ((PRO_TIPO = ''P'') OR (PRO_TIPO = ''M'') OR (PRO_TIPO = ''C'')) ';
    Lc_SqlTxt := Lc_SqlTxt +'AND (PRO_QTDE_MIN > EST_QTDE) ';

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      Lc_SqlTxt:= Lc_SqlTxt + ' AND (PRO_CODMHA =:PRO_CODMHA) ' ;


    if trim(Fm_ListaEstoques.DBLCB_Estoque.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + ' AND EST_CODETS = :ETS_CODIGO ';

    if ChBx_Est_Min.Checked then Lc_SqlTxt := Lc_SqlTxt + ' AND ( (EST_QTDE < PRO_QTDE_MIN) AND (PRO_QTDE_MIN > 0) )';
    if Chbx_Positivo.Checked then Lc_SqlTxt := Lc_SqlTxt +'AND (EST_QTDE > 0)';
    if chbx_negativo.Checked then Lc_SqlTxt := Lc_SqlTxt +'AND (EST_QTDE < 0)';
    if Lc_Grupo then Lc_SqlTxt := Lc_SqlTxt +'AND (PRO_CODGRP =:PRO_CODGRP) ';
    if Lc_SubGrupo then Lc_SqlTxt := Lc_SqlTxt +'AND (PRO_CODSBG =:PRO_CODSBG) ';
    if Lc_Marca then Lc_SqlTxt := Lc_SqlTxt +'AND (PRO_CODMRC =:PRO_CODMRC) ';
    if Lc_Fornece then Lc_SqlTxt := Lc_SqlTxt +'AND (PFR_CODFOR =:PFR_CODFOR) ';
    if Lc_Produto then Lc_SqlTxt := Lc_SqlTxt +'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO)';
    IF not Chbx_Inativos.Checked then Lc_SqlTxt := Lc_SqlTxt +'AND (PRO_ATIVO = ''S'')';
    if ChBx_SemMov.Checked then
      Begin
      Fc_ProdutosVendidos(E_Data_Ini.Date,E_Data_Fim.Date);
      Lc_SqlTxt := Lc_SqlTxt + 'AND (EST_QTDE > 0) AND (PRO_VENDA = ''N'') ';
      end;
    //Define o Agrupamento
    Lc_SqlTxt := Lc_SqlTxt + 'Group By 1,2,3,4,5,6,7,8 ';

    if CB_Ordena.ItemIndex = 0 then
      Qr_Produtos.SQL.Add(Lc_SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_DESCRICAO')
    else
      if CB_Ordena.ItemIndex = 1 then
        Qr_Produtos.SQL.Add(Lc_SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGOFAB')
      else
        Qr_Produtos.SQL.Add(Lc_SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGO');

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      Qr_Produtos.ParamByName('PRO_CODMHA').AsInteger:= Fm_LME.Dblcb_Lista.KeyValue;


    if trim(Fm_ListaEstoques.DBLCB_Estoque.Text) <> '' then
      Qr_Produtos.ParamByName('ETS_CODIGO').AsInteger:= Fm_ListaEstoques.DBLCB_Estoque.KeyValue;
      
    if Lc_Grupo then Qr_Produtos.ParamByName('PRO_CODGRP').AsInteger:=DBLCB_Grupos.KeyValue;
    if Lc_SubGrupo then Qr_Produtos.ParamByName('PRO_CODSBG').AsInteger:=DBLCB_SubGrupos.KeyValue;
    if Lc_Marca then Qr_Produtos.ParamByName('PRO_CODMRC').AsInteger:=DBLCB_Marca.KeyValue;
    if Lc_Fornece then Qr_Produtos.ParamByName('PFR_CODFOR').AsInteger:=DBLCB_Empresa.KeyValue;
    if Lc_Produto then  Qr_Produtos.ParamByName('PRO_DESCRICAO').AsString := '%'+Copy(E_BuscaDescricaoProduto.Text,1,98)+'%';
    Qr_Produtos.Open;
    Screen.Cursor:=crDefault;
    end;
end;

procedure TRL_Reposicao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(QRPT);
  Action:=caFree;
  RL_Reposicao := nil;
end;

procedure TRL_Reposicao.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if (Qr_Produtos.FieldByName('EST_QTDE').AsFloat < 0) then
    E_Reposicao.Caption := FloatToStrF((Qr_Produtos.FieldByName('EST_QTDE').AsFloat * -1) + Qr_Produtos.FieldByName('PRO_QTDE_MIN').AsFloat,ffFixed,10,3);

  if (Qr_Produtos.FieldByName('EST_QTDE').AsFloat = 0) then
    E_Reposicao.Caption := FloatToStrF(Qr_Produtos.FieldByName('PRO_QTDE_MIN').AsFloat,ffFixed,10,3);

  if (Qr_Produtos.FieldByName('EST_QTDE').AsFloat > 0) then
    Begin
    if (Qr_Produtos.FieldByName('EST_QTDE').AsFloat - Qr_Produtos.FieldByName('PRO_QTDE_MIN').AsFloat) >0 then
      E_Reposicao.Caption := FloatToStrF((Qr_Produtos.FieldByName('EST_QTDE').AsFloat - Qr_Produtos.FieldByName('PRO_QTDE_MIN').AsFloat),ffFixed,10,3);

    if (Qr_Produtos.FieldByName('EST_QTDE').AsFloat - Qr_Produtos.FieldByName('PRO_QTDE_MIN').AsFloat) =0 then
      E_Reposicao.Caption := '0,00';

    if (Qr_Produtos.FieldByName('EST_QTDE').AsFloat - Qr_Produtos.FieldByName('PRO_QTDE_MIN').AsFloat) < 0 then
      E_Reposicao.Caption := FloatToStrF(Qr_Produtos.FieldByName('PRO_QTDE_MIN').AsFloat - Qr_Produtos.FieldByName('EST_QTDE').AsFloat,ffFixed,10,3);
     
    end;
end;

procedure TRL_Reposicao.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
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

procedure TRL_Reposicao.Pc_Parametros;
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
    if ChBx_SemMov.Checked = true then
      begin
      Lb_Sem_Movi.Caption := SIM
      end
    else
      begin
      Lb_Sem_Movi.Caption := NAO;
      end;
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

end.
