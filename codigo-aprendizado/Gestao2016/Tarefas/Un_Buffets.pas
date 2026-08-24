unit Un_Buffets;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ComCtrls, jpeg, Grids, DBGrids, Buttons, DB, STQuery, ACBrBase, ACBrBAL, ACBrDevice, FavoritoButtons, pngimage, Mask, QEdit_Setes, ACBrDeviceSerial;

type
   TFr_Buffets = class(TForm)
      Panel1: TPanel;
      Panel2: TPanel;
      Label1: TLabel;
      Lb_Vl_Total: TLabel;
      Sb_Adiciona: TSpeedButton;
      Sb_Retira: TSpeedButton;
      Sb_Confirma: TSpeedButton;
      Panel8: TPanel;
      Sb_7: TSpeedButton;
      Sb_8: TSpeedButton;
      Sb_9: TSpeedButton;
      Sb_4: TSpeedButton;
      Sb_5: TSpeedButton;
      Sb_6: TSpeedButton;
      Sb_1: TSpeedButton;
      Sb_2: TSpeedButton;
      Sb_3: TSpeedButton;
      Sb_0: TSpeedButton;
      Grp_Pagamento: TGroupBox;
      Label6: TLabel;
      Label19: TLabel;
      Label20: TLabel;
      Label7: TLabel;
    E_VL_Dinheiro: TEdit_Setes;
    E_VL_Debito: TEdit_Setes;
    E_Vl_Credito: TEdit_Setes;
      Label9: TLabel;
    E_Vl_Pagar: TEdit_Setes;
      Label10: TLabel;
    E_VL_Troco: TEdit_Setes;
      Sb_Cancelar: TSpeedButton;
      Sb_Limpa: TSpeedButton;
      Qr_Ins_Ordem: TSTQuery;
      Qr_Itens: TSTQuery;
      Qr_Pedido: TSTQuery;
      Qr_PedidoPED_CODEMP: TIntegerField;
      Qr_PedidoPED_CODVDO: TIntegerField;
      Qr_PedidoEMP_CONSUMIDOR: TStringField;
      Qr_PedidoEMP_MICRO: TStringField;
      Qr_PedidoUFE_CODIGO: TIntegerField;
      Qr_PedidoUFE_SIGLA: TStringField;
      Qr_PedidoEMP_FABRICA: TStringField;
      Qr_PedidoEMP_SUB_TRIB: TStringField;
      Qr_PedidoPED_CODIGO: TIntegerField;
    Balanca: TACBrBAL;
    Qr_Produtos: TSTQuery;
    Ds_Produtos: TDataSource;
    Tm_PegaPeso: TTimer;
    Qr_Preco: TSTQuery;
    Qr_ProdutosPRO_CODIGO: TIntegerField;
    Qr_ProdutosPRO_DESCRICAO: TStringField;
    Qr_ProdutosPRO_VALOR: TFloatField;
    Qr_ProdutosPRO_CAMPANHA: TStringField;
    E_Vl_total: TLabel;
    Panel3: TPanel;
    Pg_Terminal: TPageControl;
    Tbh_Buffet: TTabSheet;
    Panel4: TPanel;
    Label8: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    E_Preco_Buffet: TPanel;
    E_Peso_Balanca: TPanel;
    E_Vl_Buffet: TPanel;
    StrGrd_Itens_Vda: TStringGrid;
    Label3: TLabel;
    Lb_Data_Caixa: TLabel;
    IM_Logo: TImage;
    Tbh_Pesquisa: TTabSheet;
    Pnl_Pesquisa: TPanel;
    E_Bebidas: TEdit;
    DBGrid2: TDBGrid;
    Sb_Pesquisa: TButton;
      procedure FormCreate(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure Sb_1Click(Sender: TObject);
      procedure Sb_2Click(Sender: TObject);
      procedure Sb_3Click(Sender: TObject);
      procedure Sb_4Click(Sender: TObject);
      procedure Sb_5Click(Sender: TObject);
      procedure Sb_6Click(Sender: TObject);
      procedure Sb_7Click(Sender: TObject);
      procedure Sb_8Click(Sender: TObject);
      procedure Sb_9Click(Sender: TObject);
      procedure E_VL_DinheiroEnter(Sender: TObject);
      procedure E_VL_DinheiroExit(Sender: TObject);
      procedure Sb_LimpaClick(Sender: TObject);
      procedure Sb_0Click(Sender: TObject);
      procedure E_Vl_CreditoExit(Sender: TObject);
      procedure E_VL_DebitoExit(Sender: TObject);
      procedure E_Vl_CreditoEnter(Sender: TObject);
      procedure E_VL_DebitoEnter(Sender: TObject);
      procedure Pg_TerminalChange(Sender: TObject);
      procedure Sb_ConfirmaClick(Sender: TObject);
      procedure StrGrd_Itens_VdaDrawCell(Sender: TObject; ACol,
         ARow: Integer; Rect: TRect; State: TGridDrawState);
      procedure Sb_RetiraClick(Sender: TObject);
      procedure Sb_AdicionaClick(Sender: TObject);
      procedure E_VL_DinheiroChange(Sender: TObject);
      procedure E_Vl_CreditoChange(Sender: TObject);
      procedure E_VL_DebitoChange(Sender: TObject);
      procedure BalancaLePeso(Peso: Double; Resposta: string);
    procedure Sb_CancelarClick(Sender: TObject);
    procedure SB_1_1Click(Sender: TObject);
    procedure Tm_PegaPesoTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Qr_ProdutosCalcFields(DataSet: TDataSet);
    procedure E_BebidasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_PesquisaClick(Sender: TObject);
    procedure IM_LogoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

   private
    { Private declarations }
    //Caixa
      It_Vl_Valor: string;
      It_Usa_Gaveta: boolean;
      It_Usa_Balanca: boolean;
      It_VL_Pedido: Currency;
      It_Vl_Recebido: Currency;
      It_Cd_Preco : Integer;
    //Vendas
      It_Nr_Item: Integer;
    //Impressão
      It_Porta: string;

    //Pedido
      It_Cd_Pedido: Integer;
      It_Nr_Pedido: string;
      It_Cd_Nota: Integer;
      It_Nr_Nota: string;
      It_Cd_Natureza: Integer;
      It_Cd_Vendedor: Integer;
      It_Cd_Buffet: Integer;
      It_Qt_Produto: real;
    //Cliente
      It_Cd_Cliente: Integer;
      It_Cd_Endereco: Integer;
    //Mover componente
    it_captura : Boolean;
    It_Act_Page :Integer;

   public
    { Public declarations }
      procedure Pc_FormataTela;
      procedure Pc_Monta_Grade_Itens_Vda;
      procedure Pc_Totalizador;
      procedure Pc_Soma_Produto;
      procedure Pc_Preenche_Produto(Pc_Cd_Codigo: string; Pc_Qtde: string);
      procedure Pc_Preenche_valores(Pc_Valor: string);
      function Fc_Valida_Faturamento(): Boolean;
      procedure Pc_Gerar_Pedido;
      procedure Pc_AtualizarItensNota;
      procedure Pc_Nota_Fiscal;
      procedure Pc_Lanca_Caixa;
      procedure Pc_Imprime;
      procedure Pc_Limpa_Campos;
      procedure Pc_Ativa_Balanca;
      procedure Pc_Lista_Produtos(Pc_botao:String;Pc_Grupo:String;Pc_Descricao:String);
      procedure Pc_Cria_Abas;
      procedure Pc_Cria_Botao(Pc_Grupo : String; Pc_Painel:TScrollBox);
      procedure Pc_Sb_AdicionaItem(Sender: TObject);
      procedure Pc_CaixaPesquisa(Pc_Operacao:String);
   end;

var
   Fr_Buffets: TFr_Buffets;

implementation

uses     UN_Sistema, UN_MSG, Un_DM, Un_Fc_Sored_Procedures, Un_Funcoes, Un_Regra_Negocio, UN_TabelasEmListas, RI_MovimentoFinanceiro, UN_NF, UN_Principal, env;
{$R *.dfm}


{Frente de Caixa - Buffets}

procedure TFr_Buffets.Pc_Sb_AdicionaItem(Sender: TObject);
Var
  Lc_Botao : TBitBtn;
begin
  Lc_Botao := TBitBtn.Create(Self);
  Lc_Botao := TBitBtn(Sender);
  It_Act_Page := Pg_Terminal.ActivePageIndex;
  Pc_Lista_Produtos(Lc_Botao.Caption, '','');

end;

procedure TFr_Buffets.Pc_Cria_Abas;
Var
  Lc_Qry_SubGrupos : TSTQuery;
  Lc_SqlTxt : String;
  Lc_TabSheet: TTabSheet;
  Lc_Scroolbox : TScrollBox;
  Lc_Label : TLAbel;
  Lc_I : Integer;
begin
  Lc_Qry_SubGrupos := TSTQuery.Create(Self);
  Lc_Qry_SubGrupos.Database := DM.IBD_Gestao;
  Lc_Qry_SubGrupos.Transaction := DM.IB_Transacao;
  Lc_Qry_SubGrupos.ForcedRefresh := true;

  Lc_Qry_SubGrupos.SQL.Clear;
  Lc_SqlTxt := 'SELECT SBG_ABAS, SBG_DESCRICAO                                              '+
               ' FROM TB_GRUPOS                                                             '+
               '   INNER JOIN tb_subgrupos                                                  '+
               '   ON (tb_grupos.grp_codigo = tb_subgrupos.sbg_codgrp)                      '+
               ' WHERE  tb_subgrupos.sbg_abas IS NOT NULL AND tb_subgrupos.sbg_abas <> '''' ';

  Lc_Qry_SubGrupos.SQL.Add(Lc_SqlTxt);
  Lc_Qry_SubGrupos.Active := True;
  Lc_Qry_SubGrupos.FetchAll;
  Lc_Qry_SubGrupos.First;
  Lc_I := 2;
  while not Lc_Qry_SubGrupos.Eof do
    begin
    //Cria a Pagina do Page Control
    Lc_TabSheet := TTabSheet.Create(Pg_Terminal);
    Lc_TabSheet.PageControl := Pg_Terminal;
    Lc_TabSheet.Name := 'tbs_ref_' + InttoStr(Lc_I);
    Lc_TabSheet.Caption := Lc_Qry_SubGrupos.FieldByName('SBG_ABAS').AsString;
    //Cria o Painel Scroolbox
    Lc_Scroolbox := TScrollBox.Create(Lc_TabSheet);
    Lc_Scroolbox.Parent := Lc_TabSheet;
    Lc_Scroolbox.Width := Lc_TabSheet.Width;
    Lc_Scroolbox.Align := alLeft;
    //Cria a Label Favoritos
    Lc_Label := TLabel.Create(Self);
    Lc_Label.Parent := Lc_Scroolbox;
    Lc_Label.Color := clNavy;
    Lc_Label.Caption := 'MEUS FAVORITOS';
    Lc_Label.Font.Size := 12;
    Lc_Label.Font.Name := 'Arial';
    Lc_Label.Font.Style := [fsBold];
    Lc_Label.Font.Color := clWhite;
    Lc_Label.Align := alTop;
    Lc_Label.Alignment := taCenter;
    Pc_Cria_Botao(Lc_Qry_SubGrupos.FieldByName('SBG_DESCRICAO').AsString,Lc_Scroolbox);
    Lc_Qry_SubGrupos.Next;
    inc(Lc_I);
    end;
end;

procedure TFr_Buffets.Pc_Cria_Botao(Pc_Grupo : String; Pc_Painel:TScrollBox);
Var
  Lc_Qry_Produtos : TSTQuery;
  Lc_SqlTxt : String;
  Lc_Botao : TBitBtn;
  Lc_Codigo : string;
  Lc_Linha, Lc_Coluna, Lc_Nr_botao : Integer;
  St_Image:TStream;
  Jp_IMage: TBitmap; // sem a unit 'jpeg' essa classe não existiria
  Lc_Pos_Top : Integer;
  Lc_Pos_Left : Integer;
  Lc_Nr_Colunas : Integer;
begin
  Lc_Qry_Produtos := TSTQuery.Create(Self);
  Lc_Qry_Produtos.Database := DM.IBD_Gestao;
  Lc_Qry_Produtos.Transaction := DM.IB_Transacao;
  Lc_Qry_Produtos.ForcedRefresh := true;

  Lc_Qry_Produtos.SQL.Clear;
  Lc_SqlTxt := 'SELECT DISTINCT BTN_CODIGO, IBT_SEQUENCIA, BTN_ALTURA, BTN_LARGURA, '+
               'BTN_LABEL, BTN_MRG_SUP, BTN_IMAGEM '+
               'FROM TB_PRODUTO tb_produto '+
               '   INNER JOIN TB_ITENS_BTN tb_itens_btn '+
               '   ON (tb_itens_btn.IBT_CODPRO = tb_produto.PRO_CODIGO) '+
               '   INNER JOIN TB_BOTAO tb_botao '+
               '   ON (tb_botao.BTN_CODIGO = tb_itens_btn.IBT_CODBTN) '+
               '   INNER JOIN TB_SUBGRUPOS tb_subgrupos '+
               '   ON (tb_subgrupos.SBG_CODIGO = tb_produto.PRO_CODSBG) '+
               'WHERE SBG_DESCRICAO=:SBG_DESCRICAO '+
               'ORDER BY IBT_SEQUENCIA ';

  Lc_Qry_Produtos.SQL.Add(Lc_SqlTxt);
  Lc_Qry_Produtos.ParamByName('SBG_DESCRICAO').AsString :=  Pc_Grupo;
  Lc_Qry_Produtos.Active := True;
  Lc_Qry_Produtos.FetchAll;
  Lc_Qry_Produtos.First;
  Lc_Linha := 1;
  Lc_Nr_botao := 1;
  Lc_Pos_Top := 19;
  Lc_Pos_Left := 2;
  Lc_Nr_Colunas := trunc(Pc_Painel.Width / Lc_Qry_Produtos.fieldByName('BTN_LARGURA').AsInteger);
  while not Lc_Qry_Produtos.Eof do
    begin
    for Lc_Coluna := 1 to Lc_Nr_Colunas  do
      Begin
      //Cria Componentes
      if not Lc_Qry_Produtos.Eof then
        Begin
        if Assigned(FindComponent('Sb_' + Pc_Grupo + '_' + IntToStr(Lc_Nr_botao))) then
          FreeAndNil(Lc_Botao);
        Lc_Botao := TBitBtn.Create(Self);
        Lc_Botao.Parent := Pc_Painel;
        Lc_Botao.Name := 'Sb_' + Pc_Grupo + '_' + IntToStr(Lc_Nr_botao);
        Lc_Botao.Font.Size := 9;
        Lc_Botao.Font.Color := clNavy;
        Lc_Botao.Font.Style := [fsBold];
        Lc_Botao.Top := Lc_Pos_Top;
        Lc_Botao.Left := Lc_Pos_Left;
        Lc_Pos_Left := Lc_Pos_Left + Lc_Qry_Produtos.fieldByName('BTN_LARGURA').AsInteger + 1;
        Lc_Botao.Width := Lc_Qry_Produtos.fieldByName('BTN_LARGURA').AsInteger;
        Lc_Botao.Height := Lc_Qry_Produtos.fieldByName('BTN_ALTURA').AsInteger;
        Lc_Botao.Caption := Lc_Qry_Produtos.fieldByName('BTN_LABEL').AsString;
//        Lc_Botao.CodigoEscolhido := Lc_Qry_Produtos.fieldByName('PRO_CODIGO').AsInteger;
        Lc_Botao.Layout := blGlyphTop;
        Jp_IMage := nil;
        St_Image := Lc_Qry_Produtos.CreateBlobStream(Lc_Qry_Produtos.FieldByName('BTN_IMAGEM'),bmRead);
        if St_Image.Size > 0 then
          begin
          Jp_IMage := TBitmap.Create;
          Jp_IMage.LoadFromStream(St_Image);
          Lc_Botao.Margin := Lc_Qry_Produtos.fieldByName('BTN_MRG_SUP').AsInteger;
          Lc_Botao.Glyph.Assign(Jp_IMage);
          end;
        Lc_Botao.OnClick := Pc_Sb_AdicionaItem;
        Inc(Lc_Nr_botao);
        Lc_Qry_Produtos.Next;
        end;
      end;
   Lc_Pos_Top := Lc_Pos_Top + Lc_Qry_Produtos.fieldByName('BTN_ALTURA').AsInteger  ;
   Lc_Pos_Left := 2;
   Inc(Lc_Linha);
   end;

end;

procedure TFr_Buffets.Pc_Ativa_Balanca;
begin
   // se houver conecção aberta, Fecha a conecção
   if Balanca.Ativo then
      Balanca.Desativar;

   Balanca.Modelo := TACBrBALModelo(StrToInt(Fc_Aq_Geral('L', 'BALANCA', 'BAL_P_MODELO', '')));
   Balanca.Device.HandShake := TACBrHandShake(StrToInt(Fc_Aq_Geral('L', 'BALANCA', 'BAL_P_HANDSHAKE', '')));
   Balanca.Device.Parity := TACBrSerialParity(StrToInt(Fc_Aq_Geral('L', 'BALANCA', 'BAL_P_PARIDADE', '')));
   Balanca.Device.Stop := TACBrSerialStop(StrToInt(Fc_Aq_Geral('L', 'BALANCA', 'BAL_P_BITSPARADA', '')));
   Balanca.Device.Data := StrToInt(Fc_Aq_Geral('L', 'BALANCA', 'BAL_P_DATABITS', ''));
   Balanca.Device.Baud := StrToInt(Fc_Aq_Geral('L', 'BALANCA', 'BAL_P_BAUDRATE', ''));
   Balanca.Device.Porta := Fc_Aq_Geral('L', 'BALANCA', 'BAL_P_PORTA', '');
   Tm_PegaPeso.Interval := StrToIntdef(Fc_Aq_Geral('L','BALANCA','BAL_P_TIMER',''),2000);

   // Conecta com a balança
   Balanca.Ativar;


end;

procedure TFr_Buffets.Pc_Monta_Grade_Itens_Vda;
begin
   StrGrd_Itens_Vda.ColWidths[0] := -1;

   StrGrd_Itens_Vda.ColWidths[1] := trunc(StrGrd_Itens_Vda.Width * 0.72);
   StrGrd_Itens_Vda.ColWidths[2] := -1;
   StrGrd_Itens_Vda.ColWidths[3] := -1;
   StrGrd_Itens_Vda.ColWidths[4] := trunc(StrGrd_Itens_Vda.Width * 0.26);
   StrGrd_Itens_Vda.ColWidths[5] := -1;
   StrGrd_Itens_Vda.ColWidths[6] := -1;
   StrGrd_Itens_Vda.ColWidths[7] := -1;
   StrGrd_Itens_Vda.ColWidths[8] := -1;
   StrGrd_Itens_Vda.Cols[0].Add('Código');
   StrGrd_Itens_Vda.Cols[1].Add('Descrição');
   StrGrd_Itens_Vda.Cols[2].Add('Qtde');
   StrGrd_Itens_Vda.Cols[3].Add('Vl_Unit');
   StrGrd_Itens_Vda.Cols[4].Add('Subtotal');
   StrGrd_Itens_Vda.Cols[5].Add('Cód Barras');
   StrGrd_Itens_Vda.Cols[6].Add('Cód Pré-Venda');
   StrGrd_Itens_Vda.Cols[7].Add('Unidade');
   StrGrd_Itens_Vda.Cols[8].Add('Vl. Custo');
end;

procedure TFr_Buffets.Pc_Totalizador;
var
   Lc_Vl_Dinheiro, Lc_Vl_Credito, Lc_Vl_Debito: Real;
begin
   Lb_Vl_Total.Caption := 'R$ ' + FloatToStrF(It_Vl_PEdido, ffFixed, 10, 2);
   E_Vl_Total.Caption := FloatToStrF(It_Vl_PEdido, ffFixed, 10, 2);
   Lc_Vl_Dinheiro := StrToFloatDef(E_VL_Dinheiro.Text, 0);
   Lc_Vl_Credito := StrToFloatDef(E_Vl_Credito.Text, 0);
   Lc_Vl_Debito := StrToFloatDef(E_VL_Debito.Text, 0);
   It_Vl_Recebido := (Lc_Vl_Dinheiro + Lc_vl_Credito + Lc_Vl_Debito);
   if (It_VL_Pedido - It_Vl_Recebido) > 0 then
      E_Vl_Pagar.Text := FloatToStrF(It_VL_Pedido - It_Vl_Recebido, ffFixed, 10, 2)
   else
      E_Vl_Pagar.Text := '0,00';

   if (It_Vl_Recebido - It_VL_Pedido) > 0 then
      E_VL_Troco.Text := FloatToStrF(It_Vl_Recebido - It_VL_Pedido, ffFixed, 10, 2)
   else
      E_VL_Troco.Text := '0,00';

end;

procedure TFr_Buffets.Pc_Soma_Produto;
var
   Lc_I: Integer;
begin
   It_Vl_Pedido := 0;
   for Lc_I := 1 to StrGrd_Itens_Vda.RowCount - 1 do
   begin
      It_Vl_Pedido := It_Vl_Pedido + StrToFloatDef(StrGrd_Itens_Vda.Cells[4, LC_I], 0);
   end;
   Pc_Totalizador;
end;

procedure TFr_Buffets.Pc_Preenche_Produto(Pc_Cd_Codigo: string; Pc_Qtde: string);
var
   Lc_Qry_Produto: TSTQuery;
   Lc_Sql_Txt: string;
   Lc_VL_Unitatio: Real;
   Lc_VL_Total: Real;
begin
   Lc_Qry_Produto := TSTQuery.Create(Self);
   Lc_Qry_Produto.Database := DM.IBD_Gestao;
   Lc_Qry_Produto.Transaction := DM.IB_Transacao;
   Lc_Qry_Produto.ForcedRefresh := true;

   Lc_Qry_Produto.SQL.Clear;
   Lc_Sql_Txt := ' SELECT DISTINCT PRO_CODIGO, PRO_DESCRICAO,  PRO_VL_CUSTOMED , '+
                 ' MED_ABREVIATURA, PRO_CAMPANHA, PRO_CODIGOBAR                  '+
                 ' FROM TB_PRODUTO tb_produto                                    '+
                 ' inner JOIN tb_medida tb_medida                                '+
                 ' ON tb_medida.med_codigo = tb_produto.pro_codmed               ';
  if (Length(Pc_Cd_Codigo) >= 8) then
    Lc_Sql_Txt := Lc_Sql_Txt + 'WHERE (PRO_CODIGOBAR =:PRO_CD_CODIGO)                          '
  else
    Lc_Sql_Txt := Lc_Sql_Txt + 'WHERE (PRO_CODIGO =:PRO_CD_CODIGO)                          ';

  Lc_Qry_Produto.SQL.Add(Lc_Sql_Txt);
  Lc_Qry_Produto.ParamByName('PRO_CD_CODIGO').AsString := Pc_Cd_Codigo;
  Lc_Qry_Produto.Active := True;
  Lc_Qry_Produto.FetchAll;

  if Lc_Qry_Produto.RecordCount > 0 then
    begin
    Qr_Preco.Active := False;
    Qr_Preco.ParamByName('PRO_CODIGO').AsInteger := Lc_Qry_Produto.FieldByName('PRO_CODIGO').AsInteger;
    if (Lc_Qry_Produto.FieldByName('PRO_CAMPANHA').AsString = 'N') then
      It_Cd_Preco := 1
    else
      It_Cd_Preco := 2;
    Qr_Preco.ParamByName('PRC_CODTPR').AsInteger := It_Cd_Preco;
    Qr_Preco.Active := True;
    Qr_Preco.FetchAll;
    Qr_Preco.First;
    Lc_VL_Unitatio := Qr_Preco.FieldByName('PRC_VL_VDA').AsCurrency;
    //Calcula o Subtotal
    if StrToFloatDef(Pc_Qtde, 0) > 0 then
      Begin
      Lc_VL_Total := Lc_VL_Unitatio * StrToFloatDef(Pc_Qtde, 0)
      end
    else
      Begin
      Lc_VL_Total := Lc_VL_Unitatio * 1;
      Pc_Qtde := '1';
      end;


    // Preencher Grid
    It_Nr_Item := It_Nr_Item + 1;
    StrGrd_Itens_Vda.RowCount := It_Nr_Item + 1;
    StrGrd_Itens_Vda.Cells[0, It_Nr_Item] := Lc_Qry_Produto.FieldByName('PRO_CODIGO').AsString; // Codigo
    StrGrd_Itens_Vda.Cells[1, It_Nr_Item] := Lc_Qry_Produto.FieldByName('PRO_DESCRICAO').AsString; // Descrição
    StrGrd_Itens_Vda.Cells[2, It_Nr_Item] := Pc_Qtde; // Quantidade


    StrGrd_Itens_Vda.Cells[3, It_Nr_Item] := FloatToStrF(Lc_VL_Unitatio, ffFixed, 10, 2); // Valor Unitario
    StrGrd_Itens_Vda.Cells[4, It_Nr_Item] := FloatToStrF(Lc_VL_Total, ffFixed, 10, 2); // Valor Unit
    StrGrd_Itens_Vda.Cells[5, It_Nr_Item] := FloatToStrF(Lc_VL_Total, ffFixed, 10, 2); // SubTotal
    StrGrd_Itens_Vda.Cells[6, It_Nr_Item] := Lc_Qry_Produto.FieldByName('PRO_CODIGOBAR').AsString; // Codigo de Barras
    StrGrd_Itens_Vda.Cells[7, It_Nr_Item] := Lc_Qry_Produto.FieldByName('MED_ABREVIATURA').AsString; // Unidade
    StrGrd_Itens_Vda.Cells[8, It_Nr_Item] := Lc_Qry_Produto.FieldByName('PRO_VL_CUSTOMED').AsString; // Valor Custo
    end
  else
    Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Produto não Cadastrado.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    end;
end;

procedure TFr_Buffets.Pc_Preenche_valores(Pc_Valor: string);
begin
   It_Vl_Valor := It_Vl_Valor + Pc_Valor;
   if E_VL_Dinheiro.CanFocus then
      E_VL_Dinheiro.Text := Fc_ColocaVirgula(It_Vl_Valor);
   if E_Vl_Credito.CanFocus then
      E_Vl_Credito.Text := Fc_ColocaVirgula(It_Vl_Valor);
   if E_VL_Debito.CanFocus then
      E_VL_Debito.Text := Fc_ColocaVirgula(It_Vl_Valor);
end;

function TFr_Buffets.Fc_Valida_Faturamento(): Boolean;
var
   Lc_Vl_Pagar: Real;
   Lc_Vl_Pedido: Real;
begin
  //Validar se tem valor a Pagar
   Lc_Vl_Pedido := StrToFloatDef(E_Vl_total.Caption , 0);
   if Lc_Vl_Pedido <= 0 then
   begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
         'O valor do pedido deve ser maior do que Zero.' + EOLN +
         'Verifique os valores do pedido e tente novamente.' + EOLN,
         ['OK'], [bEscape], mpErro);
      Result := False;
      exit;
   end;

  //Validar se Falta valor a pagar
   Lc_Vl_Pagar := StrToFloatDef(E_Vl_Pagar.Text, 0);
   if Lc_Vl_Pagar > 0 then
   begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
         'O valor a pagar não pode ser maior do que Zero.' + EOLN +
         'Verifique os valores recebidos e tente novamente.' + EOLN,
         ['OK'], [bEscape], mpErro);
      Result := False;
      exit;
   end;
   Result := True;
end;

procedure TFr_Buffets.Pc_Gerar_Pedido;
var
   Lc_I: Integer;
   Lc_Str : String;
begin
  //Insere o Pedido
   DM_ListaConsultas.Pc_ListaVendedor;
   Qr_Ins_Ordem.Active := False;
   It_Cd_Pedido := 0;
   It_Nr_Pedido := '';
   It_Cd_Nota := Fc_Generator('GN_NOTA_FISCAL','','NFL_CODIGO');
   Qr_Ins_Ordem.ParamByName('PED_CODIGO').Value := It_Cd_Pedido;
   Qr_Ins_Ordem.ParamByName('PED_NUMERO').AsString := It_Nr_Pedido;
   Qr_Ins_Ordem.ParamByName('PED_CODUSU').Value := Gb_Cd_Usuario;
   Qr_Ins_Ordem.ParamByName('PED_DATA').AsDate := Gb_DataCaixa;
   Qr_Ins_Ordem.ParamByName('PED_CODEMP').AsInteger := It_Cd_Cliente;
   Qr_Ins_Ordem.ParamByName('PED_CODVDO').Value := It_Cd_Vendedor;
   Qr_Ins_Ordem.ParamByName('PED_CODFPG').Value := 4;
   Qr_Ins_Ordem.ParamByName('PED_PRAZO').Value := '000 - A VISTA';
   Qr_Ins_Ordem.ParamByName('PED_CODEND').Value := It_Cd_Endereco;
   Qr_Ins_Ordem.ParamByName('PED_QT_PRODUTO').Value := It_Qt_Produto;
   Qr_Ins_Ordem.ParamByName('PED_VL_PRODUTO').Value := StrToFloatDef(E_Vl_Total.Caption, 0);
   Qr_Ins_Ordem.ParamByName('PED_VL_SERVICO').Value := 0;
   Qr_Ins_Ordem.ParamByName('PED_VL_IPI').Value := 0;
   Qr_Ins_Ordem.ParamByName('PED_VL_FRETE').Value := 0;
   Qr_Ins_Ordem.ParamByName('PED_ALIQ_DESCONTO').Value := 0;
   Qr_Ins_Ordem.ParamByName('PED_VL_DESCONTO').Value := 0;
   Qr_Ins_Ordem.ParamByName('PED_VL_PEDIDO').Value := StrToFloatDef(E_Vl_Total.Caption, 0);
   Qr_Ins_Ordem.ParamByName('PED_TP_CONTATO').Value := 0;
   Qr_Ins_Ordem.ParamByName('PED_OBS').Value := '';
   Qr_Ins_Ordem.ParamByName('PED_DT_ENTREGA').AsString := '';
   Qr_Ins_Ordem.ParamByName('PED_CODMHA').AsInteger := Gb_CodMha;
   Qr_Ins_Ordem.ExecSQL;
//   Fc_GeraNumeroPedido('T',1,It_Cd_Pedido);

  //Insere os itens de produto
   for Lc_I := 1 to StrGrd_Itens_Vda.RowCount - 1 do
   begin
     Lc_Str := StrGrd_Itens_Vda.Cells[3, lc_I];
      Fc_AtualizaItensNfl(DM.IB_Transacao,
                           'I',
                           0,
                           It_Cd_Pedido,
                           It_Cd_Nota,
                           StrToInt(StrGrd_Itens_Vda.Cells[0, lc_I]),
                           StrToFloatdef(StrGrd_Itens_Vda.Cells[2, lc_I], 1),
                           StrToFloatdef(StrGrd_Itens_Vda.Cells[8, lc_I], 0),
                           StrToFloatdef(StrGrd_Itens_Vda.Cells[3, lc_I], 1),
                           0,
                           0,
                           0,
                           'V',
                           'S',
                           'N',
                           0,
                           0,
                           Gb_Estoque,
                           It_Cd_Preco,
                           'S',
                           0,0,0);
   end;
end;

procedure TFr_Buffets.Pc_AtualizarItensNota;
var
lc_sentido,Lc_Despachar:String;
begin
  //Atualiza os itens Primarios da nota
  Qr_Itens.Active := False;
  Qr_Itens.ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
  Qr_Itens.Active := True;
  Qr_Itens.FetchAll;
  Qr_Itens.First;

  if Fc_Tb_Geral('L','DSP_G_CTRL_DESPACHO','S')='S' then
    Lc_Despachar :='N'
  else
    Lc_Despachar :='S';

  IF Qr_Itens.FieldByName('ITF_OPER').AsString = 'V' THEN //se for venda
    lc_sentido:= 'S'
  ELSE
    lc_sentido:= 'E';


  while not Qr_Itens.Eof do
    begin
    Fc_AtualizaItensNfl(DM.IB_Transacao,
                        'E',
                        Qr_Itens.FieldByName('ITF_CODIGO').AsInteger,
                        It_Cd_Pedido,
                        It_Cd_Nota,
                        Qr_Itens.FieldByName('ITF_CODPRO').AsInteger,
                        Qr_Itens.FieldByName('ITF_QTDE').AsFloat,
                        Qr_Itens.FieldByName('PRO_VL_CUSTOMED').AsCurrency,
                        Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency,
                        Qr_Itens.FieldByName('ITF_AQ_DESC').AsFloat,
                        Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency,
                        Qr_Itens.FieldByName('ITF_AQ_COM').AsFloat,
                        Qr_Itens.FieldByName('ITF_OPER').AsString,
                        Qr_Itens.FieldByName('ITF_ESTOQUE').AsString,
                        Lc_Despachar,
                        Qr_Itens.FieldByName('ITF_AQ_IPI').AsCurrency,
                        Qr_Itens.FieldByName('ITF_AQ_ICMS').AsCurrency,
                        Qr_Itens.FieldByName('ITF_CODEST').AsInteger,
                        Qr_Itens.FieldByName('ITF_CODTPR').AsInteger,
                       lc_sentido,
                       0,0,0);
   Qr_Itens.Next;
   end;
end;

procedure TFr_Buffets.Pc_Nota_Fiscal;
var
  Lc_SerieNF: Integer;
  Lc_TpAmbiente: Integer;
  Lc_Transportadora : Integer;
begin
  Lc_SerieNF := 1;
  Lc_Transportadora := 0;
  It_Nr_Nota  := '';

  //Gerar Nota Fiscal
  Pc_NotaFiscal(DM.IB_Transacao,
                It_Cd_Nota,
                'SI',
                1,
                It_Nr_Nota,
                Lc_SerieNF,
                It_Cd_Natureza,
                IT_CD_Pedido,
                It_Cd_Cliente,
                Date,
                DateToStr(Gb_DataCaixa),
                time,
                0,
                0,
                0,
                0,
                StrToFloatDef(E_Vl_Total.Caption,0),
                0,
                0,
                0,
                0,
                StrToFloatDef(E_Vl_Total.Caption,0),
                Lc_Transportadora,
                0,
                1,
                '',
                '',
                '',
                '',
                'N',
                '',
                'F',
                0,
                (0 * 0.05),
                '',
                '',
                '',
                '',
                Gb_CodMha);
  IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
end;

procedure TFr_Buffets.Pc_Lanca_Caixa;
var
   Lc_Vl_Dinheiro, Lc_Vl_Credito, Lc_Vl_Debito: Real;
   Lc_data: TDate;
   Lc_Qt_Rec: Integer;
begin
   Lc_Vl_Dinheiro := StrToFloatDef(E_VL_Dinheiro.Text, 0);
   Lc_Vl_Credito := StrToFloatDef(E_Vl_Credito.Text, 0);
   Lc_Vl_Debito := StrToFloatDef(E_VL_Debito.Text, 0);
   if Lc_Vl_Dinheiro > 0 then
   begin
      Lc_Qt_Rec := Fc_GeraCod_BAixa;
      Pc_Movim_Financeiro(DM.IB_Transacao,
                           'I',
                          0,
                          0,
                          Lc_data,
                          0,
                          0,
                          0,
                          Lc_Vl_Dinheiro,
                          0,
                          'PEDIDO Nº ' + It_Nr_Pedido,
                          'C',
                          Lc_Qt_Rec,
                          Gb_Cd_Usuario,
                          0,
                          Lc_data,
                          It_Nr_Pedido,
                          'N',
                          'S',
                          Gb_CodMha,
                          1);
      Pc_Financeiro(DM.IB_Transacao,'I', 0, It_Cd_Cliente, Date, It_Cd_Pedido, It_Cd_Nota, 4, '000 - A VISTA', Date, It_Nr_Pedido + '/' + It_Nr_Pedido + '/' + IntToStr(1) + '-' + IntToStr(1),
         Lc_Vl_Dinheiro, 0, 0, 0, Lc_Vl_Dinheiro, Date, Date, 'S', 1, 'RA', 'D', Lc_Qt_Rec, 'C', 'P',0);
   end;

   if Lc_Vl_Credito > 0 then
   begin
      Lc_Qt_Rec := Fc_GeraCod_BAixa;
      Pc_Movim_Financeiro(DM.IB_Transacao,'I',
                          0,
                          0,
                          Lc_data,
                          0,
                          0,
                          0,
                          Lc_Vl_Credito,
                          0,
                          'PEDIDO Nº ' + It_Nr_Pedido,
                          'C',
                          Lc_Qt_Rec,
                          Gb_Cd_Usuario,
                          0,
                          Lc_data,
                          It_Nr_Pedido,
                          'N',
                          'S',
                          Gb_CodMha,
                          1);
      Pc_Financeiro(DM.IB_Transacao,'I', 0, It_Cd_Cliente, Date, It_Cd_Pedido, It_Cd_Nota, 3, '000 - A VISTA', Date, It_Nr_Pedido + '/' + It_Nr_Pedido + '/' + IntToStr(1) + '-' + IntToStr(1),
         Lc_Vl_Credito, 0, 0, 0, Lc_Vl_Credito, Date, Date, 'S', 1, 'RA', 'D', Lc_Qt_Rec, 'C', 'P',0);
   end;

   if Lc_Vl_Debito > 0 then
   begin
      Lc_Qt_Rec := Fc_GeraCod_BAixa;
      Pc_Movim_Financeiro(DM.IB_Transacao,'I',
                          0,
                          0,
                          Lc_data,
                          0,
                          0,
                          0,
                          Lc_Vl_Debito,
                          0,
                          'PEDIDO Nº ' + It_Nr_Pedido,
                          'C',
                          Lc_Qt_Rec,
                          Gb_Cd_Usuario,
                          0,
                          Lc_data,
                          It_Nr_Pedido,
                          'N',
                          'S',
                          Gb_CodMha,
                          1);
      Pc_Financeiro(DM.IB_Transacao,'I', 0, It_Cd_Cliente, Date, It_Cd_Pedido, It_Cd_Nota, 5, '000 - VISTA', Date, It_Nr_Pedido + '/' + It_Nr_Pedido + '/' + IntToStr(1) + '-' + IntToStr(1),
         Lc_Vl_Debito, 0, 0, 0, Lc_Vl_Debito, Date, Date, 'S', 1, 'RA', 'D', Lc_Qt_Rec, 'C', 'P',0);
   end;

end;

procedure TFr_Buffets.Pc_Imprime;
Begin


end;

procedure TFr_Buffets.Pc_Limpa_Campos;
var
   Lc_I, Lc_J: Integer;
begin
   Lb_Vl_Total.Caption := 'R$ 0,00';
   E_Vl_total.Caption := '0,00';
   E_Peso_Balanca.Caption := '0,00';
   E_Vl_Buffet.Caption := '0,00';
  // Limpa StrinGrid
   for Lc_I := 1 to StrGrd_Itens_Vda.RowCount - 1 do
      for Lc_J := 0 to StrGrd_Itens_Vda.ColCount do
         StrGrd_Itens_Vda.Cells[Lc_J, Lc_I] := '';
   StrGrd_Itens_Vda.RowCount := 2;

   It_Vl_Valor := '';
   It_VL_Pedido := 0;
   It_Vl_Recebido := 0;
   It_Nr_Item := 0;
   It_Cd_Pedido := 0;
   It_Nr_Pedido := '';
   It_Cd_Nota := 0;
   It_Nr_Nota := '';
   It_Cd_Natureza := 0;
   It_Qt_Produto := 0;

   E_VL_Dinheiro.Text := '0,00';
   E_Vl_Credito.Text := '0,00';
   E_VL_Debito.Text := '0,00';
   E_Vl_Pagar.Text := '0,00';
   E_VL_Troco.Text := '0,00';
end;

procedure TFr_Buffets.Pc_FormataTela;
Begin
  //Interface
  Pg_Terminal.Pages[1].TabVisible:=False;
  Pnl_Pesquisa.BringToFront;
  Top := 0;
  Left := 0;
  Width := Screen.Width;
  Height := Screen.Height;
  Pg_Terminal.ActivePageIndex := 0;
  Pc_SetTaskBar(Self,False);
  Pc_Monta_Grade_Itens_Vda;
  Pc_Cria_Abas;

end;


procedure TFr_Buffets.FormCreate(Sender: TObject);
begin
   Pc_DefineEmpresa;
  //Interface - Alinhamento dos Edits
   It_Usa_Balanca := (Fc_Aq_Geral('L','BALANCA','BAL_P_ATIVACAO','') = 'S');

  //Caixa
   It_Usa_Gaveta := (Fc_Aq_Geral('L', 'PARAMETRO', 'GAVETA', '') = 'S');
   Lb_Data_Caixa.Caption := 'DATA DO CAIXA - ' + DateToStr(Gb_DataCaixa);

  //Pedido
   Lb_Vl_Total.Caption := 'R$ 0,00';
   E_Vl_Total.Caption := 'R$ 0,00';
   It_Cd_Buffet := StrToIntDef(Fc_Tb_Geral('L','PRO_G_CD_PRO_BUFFET',''), 0);
   {
   DM.Qr_Produto.Active := true;
   DM.Qr_Produto.First;
   Qr_Preco.Active := true;
   DM.Qr_Produto.First;
   if (DM.Qr_Produto.Locate('PRO_CODIGO',It_Cd_Buffet,[])) then
    Begin
    Qr_Preco.Active := False;
    Qr_Preco.ParamByName('PRO_CODIGO').AsInteger := It_Cd_Buffet;
    if (DM.Qr_Produto.FieldByName('PRO_CAMPANHA').AsString = 'N') then
      It_Cd_Preco := 1
    else
      It_Cd_Preco := 2;
    Qr_Preco.ParamByName('PRC_CODTPR').AsInteger := It_Cd_Preco;
    Qr_Preco.Active := True;
    Qr_Preco.FetchAll;
    Qr_Preco.First;
    E_Preco_Buffet.Caption := FloatToStrF(Qr_Preco.FieldByName('PRC_VL_VDA').AsCurrency,ffFixed,10,2);
    end
  else
    E_Preco_Buffet.Caption := '0,00';
   }

   It_Cd_Cliente := StrToIntDef(Fc_Tb_Geral('L', 'VDA_G_CODCONS', ''), 0);
   DM.Qr_Endereco.Active := False;
   DM.Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Cliente;
   DM.Qr_Endereco.Active := True;
   DM.Qr_Endereco.FetchAll;
   It_Cd_Endereco := DM.Qr_Endereco.FieldByname('END_CODIGO').AsInteger;
   It_Nr_Item := 0;
  //Chama o Vendedor
   DM_ListaConsultas.Pc_ListaVendedor;
  //Impressão
   It_Porta := Fc_Aq_Geral('L', 'CONTROLE DE VENDA', 'VDA_P_PORTA', '');
end;

procedure TFr_Buffets.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Pc_SetTaskBar(Self,True);
end;

procedure TFr_Buffets.Sb_1Click(Sender: TObject);
begin
   Pc_Preenche_valores('1');
end;

procedure TFr_Buffets.Sb_2Click(Sender: TObject);
begin
   Pc_Preenche_valores('2');
end;

procedure TFr_Buffets.Sb_3Click(Sender: TObject);
begin
   Pc_Preenche_valores('3');
end;

procedure TFr_Buffets.Sb_4Click(Sender: TObject);
begin
   Pc_Preenche_valores('4');
end;

procedure TFr_Buffets.Sb_5Click(Sender: TObject);
begin
   Pc_Preenche_valores('5');
end;

procedure TFr_Buffets.Sb_6Click(Sender: TObject);
begin
   Pc_Preenche_valores('6');
end;

procedure TFr_Buffets.Sb_7Click(Sender: TObject);
begin
   Pc_Preenche_valores('7');
end;

procedure TFr_Buffets.Sb_8Click(Sender: TObject);
begin
   Pc_Preenche_valores('8');
end;

procedure TFr_Buffets.Sb_9Click(Sender: TObject);
begin
   Pc_Preenche_valores('9');
end;

procedure TFr_Buffets.E_VL_DinheiroEnter(Sender: TObject);
begin
   E_VL_Dinheiro.Clear;
   It_Vl_Valor := '';
   Pc_Totalizador;
end;

procedure TFr_Buffets.E_VL_DinheiroExit(Sender: TObject);
var
   Lc_valor: Real;
begin
   Lc_valor := StrToFloatDef(E_VL_Dinheiro.Text, 0);
   E_VL_Dinheiro.Text := FloatToStrF(Lc_valor, ffFixed, 10, 2);
end;

procedure TFr_Buffets.Sb_LimpaClick(Sender: TObject);
begin
   It_Vl_Valor := '';
   if E_VL_Dinheiro.CanFocus then
      E_VL_Dinheiro.Clear;
   if E_Vl_Credito.CanFocus then
      E_Vl_Credito.Clear;
   if E_VL_Debito.CanFocus then
      E_VL_Debito.Clear;
   Pc_Totalizador;
end;

procedure TFr_Buffets.Sb_0Click(Sender: TObject);
begin
   Pc_Preenche_valores('0');
end;

procedure TFr_Buffets.E_Vl_CreditoExit(Sender: TObject);
var
   Lc_valor: Real;
begin
   Lc_valor := StrToFloatDef(E_Vl_Credito.Text, 0);
   E_Vl_Credito.Text := FloatToStrF(Lc_valor, ffFixed, 10, 2);
end;

procedure TFr_Buffets.E_VL_DebitoExit(Sender: TObject);
var
   Lc_valor: Real;
begin
   Lc_valor := StrToFloatDef(E_VL_Debito.Text, 0);
   E_VL_Debito.Text := FloatToStrF(Lc_valor, ffFixed, 10, 2);
end;

procedure TFr_Buffets.E_Vl_CreditoEnter(Sender: TObject);
begin
   E_Vl_Credito.Clear;
   It_Vl_Valor := '';
   Pc_Totalizador;
end;

procedure TFr_Buffets.E_VL_DebitoEnter(Sender: TObject);
begin
   E_VL_Debito.Clear;
   It_Vl_Valor := '';
   Pc_Totalizador;
end;

procedure TFr_Buffets.Pc_Lista_Produtos(Pc_botao:String; Pc_Grupo:String;Pc_Descricao:String);
Begin
  Qr_Produtos.Active := False;
  Qr_Produtos.SQL.Clear;
  if (Pc_botao <> '') then
    Begin
    Qr_Produtos.SQL.Add('SELECT PRO_CODIGO, PRO_DESCRICAO, PRO_CAMPANHA         '+
               'FROM TB_PRODUTO tb_produto                                      '+
               '   INNER JOIN TB_ITENS_BTN tb_itens_btn                         '+
               '   ON (tb_itens_btn.IBT_CODPRO = tb_produto.PRO_CODIGO)         '+
               '   INNER JOIN TB_BOTAO tb_botao                                 '+
               '   ON (tb_botao.BTN_CODIGO = tb_itens_btn.IBT_CODBTN)           '+
               '   INNER JOIN TB_GRUPOS tb_grupos                               '+
               '   ON (tb_grupos.GRP_CODIGO = tb_produto.PRO_CODGRP)            '+
               'WHERE BTN_LABEL =:BTN_LABEL                             ');

    Qr_Produtos.ParamByName('BTN_LABEL').AsString := Pc_botao;
    Qr_Produtos.Active := True;
    Qr_Produtos.FetchAll;
    if Qr_Produtos.RecordCount = 1 then
      Begin
      Sb_AdicionaClick(Self);
      end
    else
      Begin
      It_Act_Page := Pg_Terminal.ActivePageIndex;
      Pc_CaixaPesquisa('A');
      end;
    exit;
    end;
  if Pc_Descricao <> '' then
    Begin
    Qr_Produtos.SQL.Add('SELECT PRO_CODIGO, PRO_DESCRICAO, PRO_CAMPANHA             '+
                        '  FROM TB_PRODUTO PRO                                      '+
                        '     INNER JOIN TB_GRUPOS tb_grupo                         '+
                        '     ON (tb_grupo.GRP_CODIGO = PRO.PRO_CODGRP)             '+
                        '  WHERE (PRO_TIPO = ''P'')  AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) '+
                        '  AND GRP_DESCRICAO=:GRP_DESCRICAO ');
    Qr_Produtos.ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(Pc_Descricao,1,98) + '%';
    Qr_Produtos.ParamByName('GRP_DESCRICAO').AsString := Pc_Grupo;
    end
  else
    Begin
    Qr_Produtos.SQL.Add('SELECT PRO_CODIGO, PRO_DESCRICAO, PRO_CAMPANHA             '+
                        '  FROM TB_PRODUTO PRO                                      '+
                        '     INNER JOIN TB_GRUPOS tb_grupo                         '+
                        '     ON (tb_grupo.GRP_CODIGO = PRO.PRO_CODGRP)             '+
                        '  WHERE PRO_TIPO = ''P''  AND GRP_DESCRICAO=:GRP_DESCRICAO ');
    Qr_Produtos.ParamByName('GRP_DESCRICAO').AsString := Pc_Grupo;
    end;
  Qr_Produtos.Active := True;
  Qr_Produtos.FetchAll;
end;

procedure TFr_Buffets.Pg_TerminalChange(Sender: TObject);
begin
  it_captura := False;
  case Pg_Terminal.ActivePageIndex of
    0:begin
      Sb_Adiciona.Enabled := True;
      Sb_Retira.Enabled := True;
      Tm_PegaPeso.Enabled := True;
      end;
    1:begin
      Tm_PegaPeso.Enabled := false;
      Sb_Adiciona.Enabled := True;
      Sb_Retira.Enabled := False;
      Pc_Lista_Produtos('','BEBIDAS','');
      end;
    2:begin
      Tm_PegaPeso.Enabled := false;
      Sb_Adiciona.Enabled := True;
      Sb_Retira.Enabled := False;
      Pc_Lista_Produtos('','OUTRAS','');
      end;
  end;
end;

procedure TFr_Buffets.Sb_ConfirmaClick(Sender: TObject);
begin
   if Fc_Valida_Faturamento then
   begin
      Pc_Gerar_Pedido;
      Pc_Nota_Fiscal;
      Pc_AtualizarItensNota;
      Pc_Lanca_Caixa;
      if (Fc_Aq_Geral('L', 'IMPRESSAO', 'IMP_P_CUPOM_FRENTE', '')) = 'S' then
        Begin
        if (MensagemPadrao(TITULO_CONFIRMACAO,
                           'Deseja Imprimir cupom?'+EOLN+EOLN,
                          [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
          begin
          try
            Pc_Imprime;
          except
            MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                           'Um erro impossibilitou a impressão dos dados.'+EOLN+
                           'Verifique e tente novamente.'+EOLN,
                          ['OK'],[bEscape],mpErro);
          end;
          end;
        end;
      Pc_Limpa_Campos;
   end;
end;

procedure TFr_Buffets.StrGrd_Itens_VdaDrawCell(Sender: TObject; ACol,
   ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   LarguraTexto, AlturaTexto, X, Y: integer;
   Texto: string;
begin
   if (arow > 0) then // testa se não é a primeira linha (fixa)
      if (odd(arow)) then
      begin // verifica se a linha impar
         StrGrd_Itens_Vda.Canvas.Font.Color := clBlack;
         StrGrd_Itens_Vda.Canvas.Brush.Color := clCream;
      end
      else
      begin
         StrGrd_Itens_Vda.Canvas.Font.Color := clBlack;
         StrGrd_Itens_Vda.Canvas.Brush.Color := clScrollBar;
      end;
   StrGrd_Itens_Vda.Canvas.FillRect(Rect); // redesenha a celula
   StrGrd_Itens_Vda.Canvas.TextOut(Rect.Left + 2, Rect.Top, StrGrd_Itens_Vda.Cells[acol, arow]); // reimprime o texto.


  { Pega o texto da célula }
   Texto := StrGrd_Itens_Vda.Cells[acol, ARow] +  ' ';

  { Calcura largura e altura (em pontos) do texto }
   LarguraTexto := StrGrd_Itens_Vda.Canvas.TextWidth(Texto);
   AlturaTexto := StrGrd_Itens_Vda.Canvas.TextHeight(Texto);

  { Calcula a posição horizontal do início do texto }
   if (ACol = 1) then { Esquerda }
      X := Rect.Left + 2
   else if (ACol = 4) then { Direita }
      X := Rect.Right - LarguraTexto - 2;



  { Calcula a posição vertical do início do texto para
    que seja impresso no centro (verticalmente) da célula }
   Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -
      AlturaTexto div 2;

  { Pinta o texto }
   StrGrd_Itens_Vda.Canvas.TextRect(Rect, X, Y, Texto);


end;

procedure TFr_Buffets.Sb_RetiraClick(Sender: TObject);
begin
   Pc_Deleta_Linha_Grid(StrGrd_Itens_Vda, StrGrd_Itens_Vda.Row);
   if It_Nr_Item > 0 then
     It_Nr_Item := It_Nr_Item - 1;
   Pc_Soma_Produto;
end;

procedure TFr_Buffets.Sb_AdicionaClick(Sender: TObject);
begin
   case Pg_Terminal.ActivePageIndex of
      0:begin
        It_Act_Page := 0;
        Pc_Preenche_Produto(IntToStr(It_cd_Buffet), E_Peso_Balanca.Caption);
        Pc_Soma_Produto;
        Pc_Totalizador;
        end;
      else
        begin
        Pc_Preenche_Produto(IntToStr(Qr_ProdutosPRO_CODIGO.AsInteger), '1');
        Pc_Soma_Produto;
        Pc_Totalizador;
        end;
    end;
   Pc_CaixaPesquisa('F');
end;

procedure TFr_Buffets.E_VL_DinheiroChange(Sender: TObject);
begin
   Pc_Totalizador;
end;

procedure TFr_Buffets.E_Vl_CreditoChange(Sender: TObject);
begin
   Pc_Totalizador;
end;

procedure TFr_Buffets.E_VL_DebitoChange(Sender: TObject);
begin
   Pc_Totalizador;
end;

procedure TFr_Buffets.BalancaLePeso(Peso: Double; Resposta: string);
begin
   E_Peso_Balanca.Caption := formatFloat('##0.000', Peso);
end;

procedure TFr_Buffets.Sb_CancelarClick(Sender: TObject);
begin
  Pc_Limpa_Campos;
end;

procedure TFr_Buffets.SB_1_1Click(Sender: TObject);
begin
  Pc_Preenche_Produto('1','1');
end;

procedure TFr_Buffets.Tm_PegaPesoTimer(Sender: TObject);
var
  Lc_Vl_Unit, Lc_Peso, Lc_total : Real;
  Lc_Time : Integer;
begin
  TRY
     if not It_Usa_Balanca then exit;
     Lc_time := StrToIntDef(Fc_Aq_Geral('L','BALANCA','BAL_P_TIMER',''),100);
     Balanca.Ativar;
     E_Peso_Balanca.Caption := FloatToStrF(Balanca.LePeso(Lc_time),ffFixed,10,3);
     Balanca.Desativar;
     Lc_Vl_Unit := StrToFloatDef(E_Preco_Buffet.Caption,0);
     Lc_Peso := StrToFloatDef(E_Peso_Balanca.Caption,0);
     Lc_total := Lc_Vl_Unit * Lc_Peso;
     E_Vl_Buffet.Caption := FloatToStrF(Lc_total,ffFixed,10,2);
  FINALLY
    Balanca.Desativar;
  END;
end;

procedure TFr_Buffets.FormActivate(Sender: TObject);
begin
  If It_Cd_Cliente = 0 then
    begin
    MensagemPadrao('Mensagem ', 'E R R O!.' + EOLN + EOLN +
                   'O código do cliente venda ao Consumidor não foi definido.' + EOLN +
                   'Vá para a tela de configurações e informe o código corretamente.',
                   ['OK'], [bEscape], mpAlerta);
   Fr_Buffets.close;
   exit;
   end;

  if It_Cd_Buffet = 0 then
    begin
    MensagemPadrao('Mensagem ', 'E R R O!.' + EOLN + EOLN +
                   'O código do Produto Buffet não foi definido.' + EOLN +
                   'Vá para a tela de configurações e informe o código corretamente.',
                   ['OK'], [bEscape], mpAlerta);
   Fr_Buffets.close;
   exit;
   end;
end;

procedure TFr_Buffets.Qr_ProdutosCalcFields(DataSet: TDataSet);
begin
  Qr_Preco.Active := False;
  Qr_Preco.ParamByName('PRO_CODIGO').AsInteger := Qr_Produtos.FieldByName('PRO_CODIGO').AsInteger;
  if (Qr_Produtos.FieldByName('PRO_CAMPANHA').AsString = 'N') then
      Qr_Preco.ParamByName('PRC_CODTPR').AsInteger := 1
    else
      Qr_Preco.ParamByName('PRC_CODTPR').AsInteger := 2;
  Qr_Preco.Active := True;
  Qr_Preco.FetchAll;
  Qr_Preco.First;
  Qr_ProdutosPRO_VALOR.AsCurrency := Qr_Preco.FieldByName('PRC_VL_VDA').AsCurrency;
end;

procedure TFr_Buffets.E_BebidasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    if Key = VK_RETURN then Pc_Lista_Produtos('','BEBIDAS',E_Bebidas.Text);
end;

procedure TFr_Buffets.Pc_CaixaPesquisa(Pc_Operacao:String);
begin
  if (Pc_Operacao ='A') then
    Begin
    Pnl_Pesquisa.Visible := true;
    Pg_Terminal.ActivePageIndex := 1;
    Application.ProcessMessages;
    end
  else
    Begin
    Pnl_Pesquisa.Visible := False;
    Pg_Terminal.ActivePageIndex := It_Act_Page;
    Application.ProcessMessages;
    end;
end;

procedure TFr_Buffets.Sb_PesquisaClick(Sender: TObject);
begin
  Pc_CaixaPesquisa('F');
end;

procedure TFr_Buffets.IM_LogoClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
     'Deseja realmente sair desta tela ?' + EOLN + EOLN +
     'Confirmar a saida ?',
     [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
    begin
      try
        Pg_Terminal.ActivePageIndex := 0;
        Fr_Buffets.Close;
      except
         MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
            'Um erro impossibilitou a execução da tarefa.' + EOLN +
            'Entre em contato com o suporte técnico.' + EOLN,
            ['OK'], [bEscape], mpErro);
      end;
   end;
end;

procedure TFr_Buffets.FormShow(Sender: TObject);
begin
  Pc_FormataTela

end;

end.

