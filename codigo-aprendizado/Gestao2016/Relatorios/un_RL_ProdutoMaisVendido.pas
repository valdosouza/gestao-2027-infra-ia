unit un_RL_ProdutoMaisVendido;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_Produto_MaisVendido = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    DetalheVenda: TQRBand;
    QRLabel8: TQRLabel;
    QRDBText11: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    QRSysData3: TQRSysData;
    Qr_Produtos: TSTQuery;
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
    E_FORNECEDOR: TQRDBText;
    QRBand3: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel5: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel7: TQRLabel;
    lb_Vendedor: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel9: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Tp_Ordenacao : Integer;
    procedure Pc_Busca;
    procedure Pc_Parametros;
  end;

var
  RL_Produto_MaisVendido: TRL_Produto_MaisVendido;

implementation

uses     Un_DM, UN_Imp_Produtos, UN_Sistema, Mask, ComCtrls, DBCtrls, StdCtrls, env;
{$R *.dfm}



procedure TRL_Produto_MaisVendido.Pc_Busca;
VaR
  SqlTxt:String;
  Lc_Grupo, Lc_SubGrupo, Lc_marca, Lc_Produto, Lc_Emp_Movim, Lc_Emp_Produto,  lc_Vendedor :Boolean;
begin
  with Fr_Imp_Produtos do
  Begin
    Screen.Cursor:=crHourGlass;
    Qr_Produtos.Close;
    Qr_Produtos.SQL.Clear;

    SqlTxt:='SELECT DISTINCT PRO_CODIGOFAB , PRO_DESCRICAO,PRO_CODIGOBAR  ,sum(itf_qtde * itf_vl_unit) VDA, sum(ITF_QTDE) QTD '+
            ' fROM TB_NOTA_FISCAL tb_nota_fiscal '+
            '    INNER JOIN TB_PEDIDO tb_pedido '+
            '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
            '    INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
            '    ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO) '+
            '    INNER JOIN TB_PRODUTO tb_produto '+
            '    ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) '+
            '    INNER JOIN TB_EMPRESA tb_cliente '+
            '    ON (tb_cliente.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) ';

    if DBLCB_Grupos.Text ='' then Lc_Grupo := False else Lc_Grupo := True;
    if DBLCB_SubGrupos.Text ='' then Lc_SubGrupo := False else Lc_SubGrupo := True;
    if DBLCB_Marca.Text ='' then Lc_marca := False else Lc_marca := True;
    if E_BuscaDescricaoProduto.Text ='' then Lc_Produto := False else Lc_Produto := True;
    if ((Rb_Empresa.Checked) and (DBLCB_Empresa.Text <> '')) then  Lc_Emp_Movim := True else Lc_Emp_Movim := False;
    if ((Rb_Produto.Checked) and (DBLCB_Empresa.Text <> '')) then  Lc_Emp_Produto := True else Lc_Emp_Produto := False;
    if dblcb_Vendedor.Text = '' then  lc_Vendedor := False else lc_Vendedor := True;

    if Lc_Grupo then
    begin
      SqlTxt := SqlTxt + '    INNER JOIN TB_GRUPOS Tb_grupos ';
      SqlTxt := SqlTxt + '    ON  (Tb_produto.PRO_CODGRP = Tb_grupos.GRP_CODIGO) ';
    end;

    if Lc_SubGrupo then
    begin
      SqlTxt := SqlTxt + '    INNER JOIN TB_SUBGRUPOS Tb_subgrupos ';
      SqlTxt := SqlTxt + '    ON  (Tb_produto.PRO_CODSBG = Tb_subgrupos.SBG_CODIGO) ';
    end;

    if Lc_marca then
    begin
      SqlTxt := SqlTxt + '    INNER JOIN TB_MARCA_PRODUTO tb_marcaproduto ';
      SqlTxt := SqlTxt + '    ON  (tb_marcaproduto.MRC_CODIGO = tb_produto.PRO_CODMRC) ';
    end;

    if Lc_Emp_Produto then
    begin
      SqlTxt := SqlTxt + '    INNER JOIN TB_PROD_FORN Tb_prod_forn ' ;
      SqlTxt := SqlTxt + '    ON  (Tb_prod_forn.PFR_CODPRO = Tb_produto.PRO_CODIGO) ';
      SqlTxt := SqlTxt + '    INNER JOIN  TB_EMPRESA Tb_fornecedor ';
      SqlTxt := SqlTxt + '    ON  (Tb_prod_forn.PFR_CODFOR = Tb_fornecedor.EMP_CODIGO) ';
    end;
    SqlTxt := SqlTxt + 'WHERE (NFL_CODIGO IS NOT NULL) and PED_TIPO = 1';

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      SqlTxt:= SqlTxt + ' AND (NFL_CODMHA =:NFL_CODMHA) ' ;


    if trim(Fm_ListaEstoques.DBLCB_Estoque.Text) <> '' then
      Sqltxt := Sqltxt + ' AND ITF_CODEST = :ETS_CODIGO ';


    if ChBx_Periodo.Checked = true then
      SqlTxt := SqlTxt + 'AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ';


    if Lc_Grupo then SqlTxt := SqlTxt +'AND (PRO_CODGRP =:PRO_CODGRP) ';
    if Lc_SubGrupo then SqlTxt := SqlTxt +'AND (PRO_CODSBG =:PRO_CODSBG) ';
    if Lc_marca then SqlTxt := SqlTxt +'AND (PRO_CODMRC =:PRO_CODMRC) ';
    if Lc_Produto then SqlTxt := SqlTxt +'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';
    if Lc_Emp_Movim then SqlTxt := SqlTxt +'AND (NFL_CODEMP =:NFL_CODEMP) ';
    if Lc_Emp_Produto then SqlTxt := SqlTxt +'AND (PFR_CODFOR=:PFR_CODFOR) ';
    if Lc_vendedor then
    Begin
      if Rb_Vend_Cliente.Checked then
        SqlTxt := SqlTxt +'AND (tb_cliente.EMP_CODVDOR =:PED_CODVDO) '
      else
        SqlTxt := SqlTxt +'AND (PED_CODVDO =:PED_CODVDO) '
    end;
    if It_Tp_Ordenacao = 0 then
      Qr_Produtos.SQL.Add(SqlTxt+'   group by 1,2,3 order by 4 desc ') //Ordenarção pelo Valor
    else
      Qr_Produtos.SQL.Add(SqlTxt+'   group by 1,2,3 order by 5 desc'); //Ordenação pela Quantidade

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      Qr_Produtos.ParamByName('NFL_CODMHA').AsInteger:= Fm_LME.Dblcb_Lista.KeyValue;

    if trim(Fm_ListaEstoques.DBLCB_Estoque.Text) <> '' then
      Qr_Produtos.ParamByName('ETS_CODIGO').AsInteger:= Fm_ListaEstoques.DBLCB_Estoque.KeyValue;

    if ChBx_Periodo.Checked = true then
    begin
      Qr_Produtos.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      Qr_Produtos.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    end;
    if Lc_Grupo then Qr_Produtos.ParamByName('PRO_CODGRP').AsInteger:=DBLCB_Grupos.KeyValue;
    if Lc_SubGrupo then Qr_Produtos.ParamByName('PRO_CODSBG').AsInteger:=DBLCB_SubGrupos.KeyValue;
    if Lc_marca then Qr_Produtos.ParamByName('PRO_CODMRC').AsInteger:=DBLCB_Marca.KeyValue;
    if Lc_Produto then Qr_Produtos.ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(E_BuscaDescricaoProduto.Text,1,98)+ '%';
    if Lc_Emp_Movim then Qr_Produtos.ParamByName('NFL_CODEMP').AsInteger := DBLCB_Empresa.KeyValue;
    if Lc_Emp_Produto then Qr_Produtos.ParamByName('PFR_CODFOR').AsInteger := DBLCB_Empresa.KeyValue;
    if lc_Vendedor then Qr_Produtos.ParamByName('PED_CODVDO').AsInteger := dblcb_Vendedor.KeyValue;

    Qr_Produtos.Open;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TRL_Produto_MaisVendido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Produto_MaisVendido := nil;
end;

procedure TRL_Produto_MaisVendido.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Produto_MaisVendido.Pc_Parametros;
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
    // Verifica se o nome do vendedor foi preenchido
    if trim(DBLCB_Vendedor.Text) = '' then
      lb_Vendedor.Caption := 'Todos'
    else
      lb_Vendedor.Caption := dblcb_Vendedor.Text;
    // Verifica se a ordenação foi preenchida
    case Cb_Ordena.ItemIndex of
      0 : Lb_Ordenacao.Caption := 'Descrição';
      1 : Lb_Ordenacao.caption := 'Código de Fábrica';
      2 : Lb_Ordenacao.Caption := 'Código Interno';
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
