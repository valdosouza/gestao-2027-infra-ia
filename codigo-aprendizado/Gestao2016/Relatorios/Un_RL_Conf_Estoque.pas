unit Un_RL_Conf_Estoque;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, QuickRpt, QRCtrls, DB, STQuery;

type
  TRL_Conf_Estoque = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    QRGroup1: TQRGroup;
    QRDBText1: TQRDBText;
    QRGroup2: TQRGroup;
    QRDBText2: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRBand1: TQRBand;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    E_CODPRODUTO: TQRDBText;
    RodapeSubGrupo: TQRBand;
    QRLabel7: TQRLabel;
    QRBand3: TQRBand;
    QRLabel8: TQRLabel;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    QRSysData3: TQRSysData;
    QRLabel1: TQRLabel;
    QRLabel10: TQRLabel;
    LB_Qt_SubTotal: TQRLabel;
    Lb_Qt_Total: TQRLabel;
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
    QRLabel5: TQRLabel;
    Qr_Produtos: TSTQuery;
    QRShape1: TQRShape;
    QRLabel6: TQRLabel;
    DataSource1: TDataSource;
    QRDBText4: TQRDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RodapeSubGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_VL_SubTotal: Currency;
    It_Qt_Total: Currency;
    It_Qt_SubTotal: Currency;
  procedure Pc_Busca;
  procedure Pc_Parametros;
  end;

var
  RL_Conf_Estoque: TRL_Conf_Estoque;

implementation

uses     Un_DM, UN_Imp_Produtos, UN_Sistema, ComCtrls, Un_Regra_Negocio, StdCtrls, UN_Principal, env;
{$R *.dfm}


procedure TRL_Conf_Estoque.Pc_Busca;
VaR
  SqlTxt:String;
  Lc_Grupo, Lc_SubGrupo, Lc_Marca,Lc_Local, Lc_Fornece:Boolean;
  Lc_Desc_Produto, Lc_Tipo_Custo, Lc_Custo :String;
begin
  Screen.Cursor:=crHourGlass;
  with Fr_Imp_Produtos do
  Begin
    with Qr_Produtos do
    Begin
      Lc_Desc_Produto:= E_BuscaDescricaoProduto.Text;
      It_VL_SubTotal := 0;
      It_Qt_Total := 0;
      It_Qt_SubTotal := 0;
      Active := false;
      SQL.Clear;
      if (Fc_Tb_Geral('L','PRO_G_CUSTO_INVENTARIO','') = 'C' ) then
        begin
        Lc_Tipo_Custo :=  'PRO_VL_CUSTO';
        Lc_Custo :=  'PRO_VL_CUSTO';
        end
      else
        begin
        Lc_Tipo_Custo :=  'PRO_VL_CUSTOMED AS PRO_VL_CUSTO ';
        Lc_Custo :=  'PRO_VL_CUSTOMED';
        end;

      SqlTxt:='SELECT DISTINCT PRO_CODIGO, PRO_CODIGOFAB, PRO_DESCRICAO,  EST_QTDE, PRO_QTDE_MIN, PRO_CODGRP, tb_produto.PRO_LOCAL,   '+
              ' PRO_CODSBG, ' +Lc_Tipo_Custo + ',GRP_DESCRICAO, SBG_DESCRICAO, (' +Lc_Custo + ' * EST_QTDE) AS PRO_SUBTOTAL '+
              'FROM TB_PRODUTO Tb_produto '+
              '   INNER JOIN TB_ESTOQUE tb_estoque '+
              '   ON (tb_estoque.EST_CODPRO = tb_produto.PRO_CODIGO)        '+
              '   INNER JOIN TB_GRUPOS Tb_grupos                            '+
              '   ON  (Tb_produto.PRO_CODGRP = Tb_grupos.GRP_CODIGO)        '+
              '   INNER JOIN TB_SUBGRUPOS Tb_subgrupos                      '+
              '   ON  (Tb_produto.PRO_CODSBG = Tb_subgrupos.SBG_CODIGO)     '+
              '   LEFT OUTER JOIN TB_PROD_FORN Tb_prod_forn                 '+
              '   ON  (Tb_prod_forn.PFR_CODPRO = Tb_produto.PRO_CODIGO)     '+
              '   LEFT OUTER JOIN  TB_EMPRESA Tb_fornecedor                 '+
              '   ON  (Tb_prod_forn.PFR_CODFOR = Tb_fornecedor.EMP_CODIGO)  '+
              'WHERE (PRO_IMPRIME=''S'') AND ((PRO_TIPO = ''P'') OR (PRO_TIPO = ''M'') OR (PRO_TIPO = ''C''))    ';
      SqlTxt := SqlTxt +'AND (EST_CODETS =:EST_CODETS) ';
      IF not GB_ProdCompartilha then
        SqlTxt := SqlTxt +' AND (PRO_CODMHA=:PRO_CODMHA) ';

      if DBLCB_Grupos.Text ='' then Lc_Grupo := False else Lc_Grupo := True;
      if DBLCB_SubGrupos.Text ='' then Lc_SubGrupo := False else Lc_SubGrupo := True;
      if DBLCB_Marca.Text ='' then Lc_Marca := False else Lc_Marca := True;
      if E_Busca_Local.Text ='' then Lc_Local := False else Lc_Local := True;
      if DBLCB_Empresa.Text ='' then Lc_Fornece := False else Lc_Fornece := True;

      if ChBx_Est_Min.Checked then SqlTxt := SqlTxt + ' AND ( (EST_QTDE < PRO_QTDE_MIN) AND (PRO_QTDE_MIN > 0) )';
      if Chbx_Positivo.Checked then SqlTxt := SqlTxt +'AND (EST_QTDE > 0)';
      if chbx_negativo.Checked then SqlTxt := SqlTxt +'AND (EST_QTDE < 0)';
      if not Chbx_Inativos.Checked then SqlTxt := SqlTxt +'AND (PRO_ATIVO = ''S'')';
      if Lc_Grupo then SqlTxt := SqlTxt +'AND (PRO_CODGRP =:PRO_CODGRP) ';
      if Lc_SubGrupo then SqlTxt := SqlTxt +'AND (PRO_CODSBG =:PRO_CODSBG) ';
      if Lc_Marca then SqlTxt := SqlTxt +'AND (PRO_CODMRC =:PRO_CODMRC) ';
      if Lc_Local then SqlTxt := SqlTxt +'and (PRO_LOCAL=:PRO_LOCAL) ';
      if Lc_Fornece then SqlTxt := SqlTxt +'AND (PFR_CODFOR =:PFR_CODFOR) ';
      if Lc_Desc_Produto <> '' then SqlTxt := SqlTxt +'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO)';

      if ChBx_SemMov.Checked then
      Begin
        Fc_ProdutosVendidos(E_Data_Ini.Date,E_Data_Fim.Date);
        SqlTxt := SqlTxt + 'AND (EST_QTDE > 0) AND (PRO_VENDA = ''N'') ';
      end;

      case CB_Ordena.ItemIndex of
        0: SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_DESCRICAO');
        1: SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGOFAB');
        2: SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGO');
        3: SQL.Add(SqlTxt+' ORDER BY tb_produto.PRO_LOCAL, GRP_DESCRICAO, SBG_DESCRICAO, PRO_DESCRICAO');
      end;

      ParamByName('EST_CODETS').AsInteger:= Fm_ListaEstoques.DBLCB_Estoque.KeyValue;
      IF not GB_ProdCompartilha then
        ParamByName('PRO_CODMHA').AsInteger:= Gb_CodMha;
      if Lc_Grupo then ParamByName('PRO_CODGRP').AsInteger:=DBLCB_Grupos.KeyValue;
      if Lc_SubGrupo then ParamByName('PRO_CODSBG').AsInteger:=DBLCB_SubGrupos.KeyValue;
      if Lc_Marca then ParamByName('PRO_CODMRC').AsInteger:=DBLCB_Marca.KeyValue;
      if Lc_Local then ParamByName('PRO_LOCAL').AsString := E_Busca_Local.Text;
      if Lc_Fornece then ParamByName('PFR_CODFOR').AsInteger:=DBLCB_Empresa.KeyValue;
      IF Lc_Desc_Produto <>'' THEN ParamByName('PRO_DESCRICAO').AsString:='%'+ Copy(Lc_Desc_Produto,1,98)+'%';

      Open;
      FetchAll;
      Screen.Cursor:=crDefault;
      end;
    end;

end;

procedure TRL_Conf_Estoque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(QRPT);
  Action:=caFree;
  RL_Conf_Estoque:=nil;
end;

procedure TRL_Conf_Estoque.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  It_Qt_SubTotal := It_Qt_SubTotal + Qr_Produtos.FieldByName('EST_QTDE').AsFloat;
  It_Vl_SubTotal := It_Vl_SubTotal + Qr_Produtos.FieldByName('PRO_SUBTOTAL').AsCurrency;
end;

procedure TRL_Conf_Estoque.RodapeSubGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  LB_Qt_SubTotal.Caption := FloatToStrF(It_Qt_SubTotal,ffFixed,10,3);
  It_Qt_Total := It_Qt_Total + It_Qt_SubTotal;
  It_Qt_SubTotal := 0;
  It_VL_SubTotal := 0;
end;

procedure TRL_Conf_Estoque.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  LB_Qt_Total.Caption := FloatToStrF(It_Qt_Total,ffFixed,10,3);
end;

procedure TRL_Conf_Estoque.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  if fr_Imp_Produtos.CB_Ordena.ItemIndex = 1 then
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

procedure TRL_Conf_Estoque.Pc_Parametros;
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
