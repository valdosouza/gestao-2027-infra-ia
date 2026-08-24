unit UN_RL_Inventario;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, QuickRpt, QRCtrls, DB, STQuery, StdCtrls;

type
  TRL_Inventario = class(TForm)
    Qrpt: TQuickRep;
    Bnd_Titulo: TQRBand;
    Bnd_Detalhe: TQRBand;
    QRDBText3: TQRDBText;
    E_CODPRODUTO: TQRDBText;
    E_QT_ENT_CPA: TQRDBText;
    Bnd_Rodape: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    QRSysData3: TQRSysData;
    QRLabel1: TQRLabel;
    Lb_Titulo: TQRLabel;
    Qr_Produtos: TSTQuery;
    E_VL_ENT_CPA: TQRDBText;
    E_QT_ENT_OTR: TQRDBText;
    E_VL_ENT_OTR: TQRDBText;
    E_QT_SAI_VDA: TQRDBText;
    E_VL_SAI_VDA: TQRDBText;
    E_QT_SAI_OTR: TQRDBText;
    E_VL_SAI_OTR: TQRDBText;
    E_QT_ATUAL: TQRDBText;
    E_VL_CUSTO: TQRDBText;
    QRDBText4: TQRDBText;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    Bnd_Sumario: TQRBand;
    Label1: TQRLabel;
    Label2: TQRLabel;
    Label3: TQRLabel;
    Label4: TQRLabel;
    E_QT_TL_ENT_CPA: TQRLabel;
    E_VL_TL_ENT_CPA: TQRLabel;
    E_QT_TL_ENT_OTR: TQRLabel;
    E_VL_TL_ENT_OTR: TQRLabel;
    Label9: TQRLabel;
    Label10: TQRLabel;
    Label11: TQRLabel;
    Label12: TQRLabel;
    E_QT_TL_SAI_VDA: TQRLabel;
    E_VL_TL_SAI_VDA: TQRLabel;
    E_QT_TL_SAI_OTR: TQRLabel;
    E_VL_TL_SAI_OTR: TQRLabel;
    Label17: TQRLabel;
    Label18: TQRLabel;
    E_QT_TL_SALDO: TQRLabel;
    E_VL_TL_SALDO: TQRLabel;
    Bnd_parameter: TQRBand;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Estoque: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Tab_Preco: TQRLabel;
    QRLabel37: TQRLabel;
    Lb_Ordenacao: TQRLabel;
    QRLabel38: TQRLabel;
    Lb_Gerar_Invent: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    Lb_Grupo: TQRLabel;
    QRLabel41: TQRLabel;
    Lb_Subgrupo: TQRLabel;
    QRLabel42: TQRLabel;
    Lb_Marca: TQRLabel;
    QRLabel43: TQRLabel;
    Lb_Empresa: TQRLabel;
    QRLabel45: TQRLabel;
    Lb_Estoq_Min: TQRLabel;
    QRLabel46: TQRLabel;
    Lb_Saldo_Positivo: TQRLabel;
    QRLabel47: TQRLabel;
    Lb_Inativos: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Qr_ProdutosPRO_CODIGO: TIntegerField;
    Qr_ProdutosPRO_DESCRICAO: TStringField;
    Qr_ProdutosGRP_DESCRICAO: TStringField;
    Qr_ProdutosGRP_CODIGO: TIntegerField;
    Qr_ProdutosSBG_CODIGO: TIntegerField;
    Qr_ProdutosSBG_DESCRICAO: TStringField;
    Qr_ProdutosIVT_CODIGO: TIntegerField;
    Qr_ProdutosIVT_DATA: TDateField;
    Qr_ProdutosIVT_CODPRO: TIntegerField;
    Qr_ProdutosIVT_QT_ANT: TBCDField;
    Qr_ProdutosIVT_VL_CUSTO_ANT: TBCDField;
    Qr_ProdutosIVT_QT_ENT_CPA: TBCDField;
    Qr_ProdutosIVT_VL_ENT_CPA: TBCDField;
    Qr_ProdutosIVT_QT_ENT_OTR: TBCDField;
    Qr_ProdutosIVT_VL_ENT_OTR: TBCDField;
    Qr_ProdutosIVT_QT_SAI_VDA: TBCDField;
    Qr_ProdutosIVT_VL_SAI_VDA: TBCDField;
    Qr_ProdutosIVT_QT_SAI_OTR: TBCDField;
    Qr_ProdutosIVT_VL_SAI_OTR: TBCDField;
    Qr_ProdutosIVT_QT_ATUAL: TBCDField;
    Qr_ProdutosIVT_VL_CUSTO: TBCDField;
    Qr_ProdutosIVT_SUBTOTAL: TFMTBCDField;
    grp_SubgRupo: TQRGroup;
    QRDBText2: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    E_Grupo: TQRDBText;
    Qr_ProdutosIVT_QT_AUTO: TBCDField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Bnd_DetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Bnd_SumarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    //Compras e outras Entradas
    It_QT_TL_ENT_CPA : Real;
    It_VL_TL_ENT_CPA: Currency;
    It_QT_TL_ENT_OTR : Real;
    It_VL_TL_ENT_OTR: Currency;
    //Vendas e outras Saidas
    It_QT_TL_SAI_VDA : Real;
    It_VL_TL_SAI_VDA: Currency;
    It_QT_TL_SAI_OTR : Real;
    It_VL_TL_SAI_OTR: Currency;
    //Saldos
    It_QT_TL_SALDO: Currency;
    It_VL_TL_SALDO: Currency;


  procedure Pc_Busca;
  procedure Pc_Parametros;
  end;

var
  RL_Inventario: TRL_Inventario;

implementation

uses     Un_DM, UN_Imp_Produtos, UN_Sistema, UN_Principal, env;
{$R *.dfm}


procedure TRL_Inventario.Pc_Busca;
VaR
   Lc_Desc_Produto,  SqlTxt:String;
  Lc_Grupo, Lc_SubGrupo,Lc_Marca, Lc_Fornece:Boolean;
begin
  Screen.Cursor:=crHourGlass;
  Lc_Desc_Produto:= Fr_Imp_Produtos.E_BuscaDescricaoProduto.Text;
  //Compras e outras Entradas
  It_QT_TL_ENT_CPA := 0;
  It_VL_TL_ENT_CPA := 0;
  It_QT_TL_ENT_OTR := 0;
  It_VL_TL_ENT_OTR := 0;
  //Vendas e outras Saidas
  It_QT_TL_SAI_VDA := 0;
  It_VL_TL_SAI_VDA := 0;
  It_QT_TL_SAI_OTR := 0;
  It_VL_TL_SAI_OTR := 0;
  //Saldos
  It_QT_TL_SALDO := 0;
  It_VL_TL_SALDO := 0;

  with Qr_Produtos,Fr_Imp_Produtos do
  Begin
    Qr_Produtos.Active := False;
    SQL.Clear;

    SqlTxt:= ' SELECT PRO_CODIGO, PRO_DESCRICAO, GRP_DESCRICAO, GRP_CODIGO, SBG_CODIGO, SBG_DESCRICAO, IVT_CODIGO, IVT_DATA, IVT_CODPRO, IVT_VL_SAI_VDA,     '+
             ' IVT_QT_ANT, IVT_VL_CUSTO_ANT, IVT_QT_ENT_CPA, IVT_VL_ENT_CPA, IVT_QT_ENT_OTR, IVT_VL_ENT_OTR, IVT_QT_SAI_VDA, IVT_QT_SAI_OTR, IVT_VL_SAI_OTR, '+
             ' IVT_QT_ATUAL,IVT_VL_CUSTO  ,(IVT_VL_CUSTO * IVT_QT_ATUAL) IVT_SUBTOTAL, IVT_QT_AUTO '+
             ' FROM TB_PRODUTO Tb_produto  '+
             '   INNER JOIN TB_INVENTARIO tb_inventario '+
             '   ON (tb_inventario.IVT_CODPRO = tb_produto.PRO_CODIGO) '+
             '   INNER JOIN TB_GRUPOS Tb_grupos '+
             '   ON  (Tb_produto.PRO_CODGRP = Tb_grupos.GRP_CODIGO) '+
             '   INNER JOIN TB_SUBGRUPOS Tb_subgrupos '+
             '   ON  (Tb_produto.PRO_CODSBG = Tb_subgrupos.SBG_CODIGO) '+
             ' WHERE ( IVT_DATA   =:IVT_DATA ) '+
             '   AND ( IVT_CODMHA =:IVT_CODMHA )';
             { NÃO PRECISA INFORMAR O CODIGO DA EMPRESA POIS A SEQUENCIA DO INVENTARIO UNICA
             ' and ( IVT_CODMHA=:IVT_CODMHA ) '; // o ivt_codmha é usado pois tem multi empresa onde o pro_codmha não vai funcioar
             }

    if DBLCB_Grupos.Text =''    then Lc_Grupo := False else Lc_Grupo := True;
    if DBLCB_SubGrupos.Text ='' then Lc_SubGrupo := False else Lc_SubGrupo := True;
    if DBLCB_Marca.Text =''     then Lc_Marca := False else Lc_Marca := True;
    if DBLCB_Empresa.Text =''   then Lc_Fornece := False else Lc_Fornece := True;


    if Lc_Grupo then SqlTxt := SqlTxt +'AND (PRO_CODGRP =:PRO_CODGRP) ';
    if Lc_SubGrupo then SqlTxt := SqlTxt +'AND (PRO_CODSBG =:PRO_CODSBG) ';
    if Lc_Marca then SqlTxt := SqlTxt +'AND (PRO_CODMRC =:PRO_CODMRC) ';
    if Lc_Fornece then SqlTxt := SqlTxt +'AND (PFR_CODFOR =:PFR_CODFOR) ';
    if Lc_Desc_Produto <> '' then SqlTxt := SqlTxt +' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO)';
    if chbx_positivo.Checked then  SqlTxt := SqlTxt + ' and (IVT_QT_ATUAL > 0 ) ';

    if CB_Ordena.ItemIndex = 0 then
      SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_DESCRICAO')
    else
      if CB_Ordena.ItemIndex = 1 then
        SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGOFAB')
      else
        SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGO');

    ParamByName('IVT_DATA').AsDateTime  := Qr_Invetario.FieldByName('IVT_DATA').AsDateTime;
    ParamByName('IVT_CODMHA').AsInteger := Gb_CodMha;

    if Lc_Grupo     then ParamByName('PRO_CODGRP').AsInteger  := DBLCB_Grupos.KeyValue;
    if Lc_SubGrupo  then ParamByName('PRO_CODSBG').AsInteger  := DBLCB_SubGrupos.KeyValue;
    if Lc_Marca     then ParamByName('PRO_CODMRC').AsInteger  := DBLCB_Marca.KeyValue;
    if Lc_Fornece   then ParamByName('PFR_CODFOR').AsInteger  := DBLCB_Empresa.KeyValue;
    IF Lc_Desc_Produto <> '' THEN ParamByName('PRO_DESCRICAO').AsString:='%'+Copy(Lc_Desc_Produto,1,98)+'%';

    Open;
    Lb_Titulo.Caption := 'Inventário do Estoque do Dia ' + FieldbyName('IVT_DATA').AsString;
  End;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Inventario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(QRPT);
  Action:=caFree;
  RL_Inventario:=nil;
end;

procedure TRL_Inventario.QrptBeforePrint(Sender: TCustomQuickRep;
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

procedure TRL_Inventario.Bnd_DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  It_QT_TL_ENT_CPA := It_QT_TL_ENT_CPA + Qr_Produtos.FieldByName('IVT_QT_ENT_CPA').AsFloat;
  It_VL_TL_ENT_CPA := It_VL_TL_ENT_CPA + Qr_Produtos.FieldByName('IVT_VL_ENT_CPA').AsCurrency;
  It_QT_TL_ENT_OTR := It_QT_TL_ENT_OTR + Qr_Produtos.FieldByName('IVT_QT_ENT_OTR').AsFloat;
  It_VL_TL_ENT_OTR := It_VL_TL_ENT_OTR + Qr_Produtos.FieldByName('IVT_VL_ENT_OTR').AsCurrency;
  //Vendas e outras Saidas
  It_QT_TL_SAI_VDA := It_QT_TL_SAI_VDA + Qr_Produtos.FieldByName('IVT_QT_SAI_VDA').AsFloat;
  It_VL_TL_SAI_VDA := It_VL_TL_SAI_VDA + Qr_Produtos.FieldByName('IVT_VL_SAI_VDA').AsCurrency;
  It_QT_TL_SAI_OTR := It_QT_TL_SAI_OTR + Qr_Produtos.FieldByName('IVT_QT_SAI_OTR').AsFloat;
  It_VL_TL_SAI_OTR := It_VL_TL_SAI_OTR + Qr_Produtos.FieldByName('IVT_VL_SAI_OTR').AsCurrency;
  //Saldos
  It_QT_TL_SALDO := It_QT_TL_SALDO + Qr_Produtos.FieldByName('IVT_QT_ATUAL').AsFloat;
  It_VL_TL_SALDO := It_VL_TL_SALDO + Qr_Produtos.FieldByName('IVT_SUBTOTAL').AsCurrency;
end;

procedure TRL_Inventario.Bnd_SumarioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_QT_TL_ENT_CPA.Caption := FloatToStrF(It_QT_TL_ENT_CPA,ffNumber,10,2);
  E_VL_TL_ENT_CPA.Caption := FloatToStrF(It_VL_TL_ENT_CPA,ffNumber,10,2);
  E_QT_TL_ENT_OTR.Caption := FloatToStrF(It_QT_TL_ENT_OTR,ffNumber,10,2);
  E_VL_TL_ENT_OTR.Caption := FloatToStrF(It_VL_TL_ENT_OTR,ffNumber,10,2);

  E_QT_TL_SAI_VDA.Caption := FloatToStrF(It_QT_TL_SAI_VDA,ffNumber,10,2);
  E_VL_TL_SAI_VDA.Caption := FloatToStrF(It_VL_TL_SAI_VDA,ffNumber,10,2);
  E_QT_TL_SAI_OTR.Caption := FloatToStrF(It_QT_TL_SAI_OTR,ffNumber,10,2);
  E_VL_TL_SAI_OTR.Caption := FloatToStrF(It_VL_TL_SAI_OTR,ffNumber,10,2);

  E_QT_TL_SALDO.Caption := FloatToStrF(It_QT_TL_SALDO,ffNumber,10,2);
  E_VL_TL_SALDO.Caption := FloatToStrF(It_VL_TL_SALDO,ffNumber,10,2);
end;

procedure TRL_Inventario.Pc_Parametros;
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
    if ChBx_Periodo.Checked = true then
    begin
      Lb_Data_Ini.Caption := DateToStr( E_Data_Ini.Date);
      Lb_Data_Fim.Caption := DateToStr( E_Data_Fim.Date);
    end
    else
    begin
      Lb_Data_Ini.Font.Color := clWhite;
      Lb_Data_Fim.Font.Color := clWhite;
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


