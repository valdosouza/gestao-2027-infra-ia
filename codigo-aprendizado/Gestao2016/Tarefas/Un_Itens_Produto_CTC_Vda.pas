unit Un_Itens_Produto_CTC_Vda;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Actions, Vcl.ActnList, Data.DB, STQuery, Vcl.StdCtrls, Un_Fm_ListaEstoques, Vcl.DBCtrls, Vcl.Mask, QEdit_Setes, Vcl.Buttons, Vcl.ExtCtrls, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Un_fm_ListaTributacao, ControllerItensCotacao, Un_Itens_Produto;

type
  TFr_Itens_Produto_CTC_Vda = class(TFr_Itens_Produto)
    Sb_Detalhe: TBitBtn;
    procedure E_Qt_ProdutoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure E_DescricaoExit(Sender: TObject);
    procedure Sb_LimparClick(Sender: TObject);
  private
    { Private declarations }
   protected
    procedure DefineValoresEspecificos(Pc_Cd_Tabela : Integer);Override;
    procedure Pc_StateChange(Pc_Tipo: integer);Override;
    procedure Pc_DefineCasaDecimalLocal;Override;
    procedure Pc_InsereServicoRelacionado(Pc_Codpro: Integer);Override;
    function validaGravacao:Boolean;Override;
    procedure Pc_FormataTela;override;
    procedure InsertItemns();Override;
    procedure DeleteItems();Override;
    function grava:boolean;Override;
    PROcedure Pc_Tip_Busca(Pc_Tipo:char; Pc_cd_Tabela :Integer; Pc_cd_Prod:String; Pc_Desc_prod:String);Override;

  public
    { Public declarations }
    It_Cd_Itens : Integer;
    It_Cd_Cotacao : Integer;
    It_Cd_Pedido : Integer;
    procedure LoadItems(Items:TSTQuery);Override;
    procedure editItems(CodigoItem: Integer);Override;
  end;

var
  Fr_Itens_Produto_CTC_Vda: TFr_Itens_Produto_CTC_Vda;

implementation

{$R *.dfm}

uses     Un_Fc_Sored_Procedures, RN_Cotacao, UN_Sistema, Un_Msg, UN_Principal, env, RN_Produto, RN_Permissao, tas_item_obs;
procedure TFr_Itens_Produto_CTC_Vda.DefineValoresEspecificos(Pc_Cd_Tabela : Integer);
begin
  //ItensNFL.Registro.CodigoTabela := FC_DefineTabela( ItensNFL.Registro.CodigoTabela);
  inherited;
  PC_Busca_Preco_Qtde(ItensNFL.Registro.CodigoTabela, It_Cd_Produto );

  ItensNFL.Registro.ValorUnitario := Qr_Preco_Qtde.FieldByName('PRC_VL_VDA').AsCurrency * It_MultiplicadorPreco;
  ItensNFL.Registro.Quantidade := Qr_Preco_Qtde.FieldByName('PRC_QT_MIN').AsFloat;
  if (It_Cd_Vendedor > 0 ) then
  Begin
    ItensNFL.Registro.AliqComissao := Fc_Aliquota_Comissao(It_Cd_Vendedor, ItensNFL.Registro.CodigoTabela,StrToIntDef(Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,0));
  End;

end;

procedure TFr_Itens_Produto_CTC_Vda.DeleteItems;
begin
  if StrToIntDef( cds_itemsITF_CODIGO.AsString,0) >0 then
  Begin
    If (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Excluir o item '+E_Descricao.Text +' desta venda.'+EOLN+EOLN+
                       'Confirmar a exclusão ?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
    Begin
      ItensNFL.clear;
      ItensCTC.Registro.Codigo := cds_itemsITF_CODIGO.AsInteger;
      ItensCTC.delete;
      cds_items.Delete;
      SomaItems;
    End;
  End;

end;

procedure TFr_Itens_Produto_CTC_Vda.editItems(CodigoItem: Integer);
begin
  inherited;
  ItensCTC.Registro.Codigo := CodigoItem;
  ItensCTC.getById;
  It_Cd_Produto := ItensCTC.Registro.Vinculo;
  ItensCTC.Produto.Registro.Codigo := It_Cd_Produto;
  ItensCTC.Produto.Medida.Registro.Codigo := ItensNFL.Produto.Registro.MedidaComercial;

  E_CodPro.Text           := It_Cd_Produto.ToString();  
  E_Descricao.Text        := ItensCTC.Produto.getDescricao;
  if E_Descricao.Text = '' then
    E_Descricao.Text  := ItensCTC.Registro.Descricao;
  E_Vl_Unitario.Text      := FormatFloat(Gb_Casa_Dec_Venda , ItensCTC.Registro.ValorUnitario);
  E_Qt_Produto.Text       := FloatToStr(ItensCTC.Registro.Quantidade);
  ItensNFL.Produto.Medida.getbyId;
  E_Unidade.Text          := ItensCTC.Produto.Medida.Registro.Descricao;
  E_Aq_Com.Text           := FloatToStrF( ItensCTC.Registro.AliqComissao ,ffFixed,10,2);
  E_Aq_Desconto.Text      := FloatToStrF( ItensCTC.Registro.ALiqDesc ,ffFixed,10,2);
  E_VL_Desconto.Text      := FloatToStrF( ItensCTC.Registro.ValorDEsc ,ffFixed,10,2);
  E_CustoUnitario.Text    := FloatToStrF( ItensCTC.Registro.ValorCusto ,ffFixed,10,2);
  It_Aq_IPI               := ItensCTC.Registro.AliqIPI;
  E_Aq_IPI.Text           := FloatToStrF( ItensCTC.Registro.AliqIPI ,ffFixed,10,2);
  E_Aq_Icms.Text          := FloatToStrF(ItensCTC.Registro.AliqICMS , ffFixed, 10, 2);
  It_Aq_icms              := ItensCTC.Registro.AliqICMS;

  E_Largura.Text          := FloatToStrF(ItensCTC.Registro.Largura,ffFixed,10,0);
  E_Altura.Text           := FloatToStrF(ItensCTC.Registro.Altura,ffFixed,10,0);

  Fm_ListaEstoques.AtivaLista(Gb_CodMha);
  Fm_ListaEstoques.Dblcb_Estoque.KeyValue := ItensCTC.Registro.CodigoEstoque;
  Qr_Tabela.Active        := True;
  Dblcb_Tabelas.KeyValue  := ItensCTC.Registro.TabelaPreco;

  Chbx_Estoque.Checked  := True;
end;

procedure TFr_Itens_Produto_CTC_Vda.E_DescricaoExit(Sender: TObject);
begin
  if not it_bt_pesquisa then  // se for falso nao foi clicando no pesquisado , nem apertado f7
  Begin
    if It_StateChange = 1 then
      exit;
    if (E_Descricao.Text <> '') and ( StrToIntDef(E_CodPro.Text,0) = 0) THEN
    Begin
      if E_Vl_Unitario.CanFocus then E_Vl_Unitario.SetFocus;
      exit;
    end;
    Pc_Tip_Busca('B', Dblcb_Tabelas.KeyValue,'',Copy(E_Descricao.Text,1,50));
    Pc_MostraSaldo;
  end;

end;

procedure TFr_Itens_Produto_CTC_Vda.E_Qt_ProdutoExit(Sender: TObject);
VAR
  Lc_Qtde: Real;
Begin
  Lc_Qtde := StrToFloatDef(E_Qt_Produto.Text, 0);
  if (Fc_Tb_Geral('L','VDA_G_PROMOCAO_QUANTIDADE','S') = 'S') then
    PC_Verifica_Preco_Qtde(2, It_Cd_Produto );
  Pc_Totalizador;
end;


procedure TFr_Itens_Produto_CTC_Vda.FormShow(Sender: TObject);
begin
  inherited;
  PosicaoCampoComissao;
end;
function TFr_Itens_Produto_CTC_Vda.grava:boolean;
Begin
  ItensCTC.Registro.Cotacao       := It_Cd_Cotacao;
  if Fc_ExisteItemNaCotacao then
  Begin
    ItensCTC.Registro.Cotacao       := It_Cd_Cotacao;
    ItensCTC.Registro.Tipo          := 'P';
    ItensCTC.Registro.Vinculo       := It_Cd_Produto;
    ItensCTC.Registro.DEscricao     := E_Descricao.Text;
    ItensCTC.Registro.Quantidade    := StrToFloatDef(E_Qt_Produto.Text,0);
    ItensCTC.Registro.ValorUnitario := StrToFloatDef(E_Vl_Unitario.Text,0);
    ItensCTC.Registro.Disponivel    := 'S';
    ItensCTC.Registro.AliqComissao  := StrToFloatDef(E_Aq_Com.Text,0);
    ItensCTC.Registro.ValorDEsc     := StrToFloatDef(E_VL_Desconto.Text,0);
    ItensCTC.Registro.ALiqDesc      := StrToFloatDef(E_Aq_Desconto.Text,0);
    ItensCTC.Registro.AliqIPI       := StrToFloatDef(E_Aq_IPI.Text,0);
    ItensCTC.Registro.AliqICMS      := StrToFloatDef(E_Aq_Icms.Text,0);
    ItensCTC.Registro.CodigoEstoque := Fm_ListaEstoques.Dblcb_Estoque.Keyvalue;
    ItensCTC.Registro.TabelaPreco   := Dblcb_Tabelas.KeyValue;
    ItensCTC.Registro.ValorCusto    := StrToFloatDef(E_CustoUnitario.Text,0);
    //ItensCTC.Registro.MargemLucro :=
    //ItensCTC.Registro.AliqCtFinanceiro
    //ItensCTC.Registro.PRazoPraticado
    //ItensCTC.Registro.ValorPratica
    //ItensCTC.Registro.AliqVendedor
    //ItensCTC.Registro.Tecido
    //ItensCTC.Registro.Cor
    ItensCTC.Registro.Pedido        := It_Cd_Pedido;
    ItensCTC.Registro.Altura        := StrtoFloatDef(e_Altura.Text,0);
    ItensCTC.Registro.Largura       := StrtoFloatDef(e_Largura.Text,0);
    ItensCTC.save;
    //Salva detalhe do item
    if ( Length(Trim(ItensCTC.Detalhe.Registro.Detalhe)) > 0 )  then
    Begin
      ItensCTC.Detalhe.Registro.ItemOrcamento := ItensCTC.Registro.Codigo;
      ItensCTC.Detalhe.Save;
    End;

    Pc_InsereServicoRelacionado( ItensCTC.Registro.Pedido );
    Result := True;
  end
  else
  Begin
    Result := False;
  End;

end;

procedure TFr_Itens_Produto_CTC_Vda.InsertItemns;
begin
  if not cds_items.Active then cds_items.CreateDataSet;
  cds_items.Append;
  cds_items.FieldByName('itf_sequencia').AsInteger  := 0;
  cds_items.FieldByName('pro_codigofab').AsString   := ItensCTC.Produto.getField(ItensCTC.Registro.Vinculo,'PRO_CODIGOFAB');
  cds_items.FieldByName('pro_descricao').AsString   := E_Descricao.Text;
  cds_items.FieldByName('med_abreviatura').AsString := E_Unidade.Text;
  cds_items.FieldByName('itf_qtde').AsFloat         := StrToFloatDef(E_Qt_Produto.Text,0);
  cds_items.FieldByName('itf_vl_unit').AsCurrency      := StrToFloatDef(E_Vl_Unitario.Text,0);
  cds_items.FieldByName('ITF_VL_DESC').AsCurrency      := StrToFloatDef(E_VL_Desconto.Text,0);
  cds_items.FieldByName('ITF_VL_SUBTOTAL').AsCurrency  := StrToFloatDef(E_VL_Produto.Caption,0);
  cds_items.FieldByName('ITF_VL_TOTAL').AsCurrency     := StrToFloatDef(E_Vl_SubTotal.Caption,0);
  cds_items.FieldByName('ITF_AQ_COM').AsFloat       := StrToFloatDef(E_Aq_Com.Text,0);
  cds_items.FieldByName('ITF_VL_IPI').AsCurrency       := StrToFloatDef(E_Aq_IPI.Text,0);
  cds_items.FieldByName('tpr_nome').AsString        := Dblcb_Tabelas.Text;
  cds_items.Post;





end;

procedure TFr_Itens_Produto_CTC_Vda.LoadItems(Items: TSTQuery);
Var
  LcValor : Real;
begin
  if not cds_items.Active then cds_items.CreateDataSet;
  cds_items.EmptyDataSet;
  LcValor := 0;
  Items.First;
  while not Items.Eof do
  Begin
    cds_items.Append;
    cds_items.FieldByName('itf_CODIGO').AsInteger     := Items.FieldByName('ICT_CODIGO').AsInteger;
    //cds_items.FieldByName('itf_sequencia').AsInteger  := Items.FieldByName('itf_sequencia').AsInteger;
    cds_items.FieldByName('pro_codigofab').AsString   := Items.FieldByName('pro_codigofab').AsString;
    cds_items.FieldByName('pro_descricao').AsString   := Items.FieldByName('ICT_descricao').AsString;
    //cds_items.FieldByName('med_abreviatura').AsString := Items.FieldByName('med_abreviatura').AsString;
    cds_items.FieldByName('itf_qtde').AsFloat         := Items.FieldByName('ICT_QTDE').AsFloat;
    cds_items.FieldByName('itf_vl_unit').AsCurrency      := Items.FieldByName('ICT_vl_unit').AsCurrency;
    cds_items.FieldByName('ITF_VL_DESC').AsCurrency      := Items.FieldByName('ICT_VL_DESC').AsCurrency;
    //cds_items.FieldByName('ITF_VL_SUBTOTAL').AsFloat  := Items.FieldByName('ITF_VL_SUBTOTAL').AsFloat;
    cds_items.FieldByName('ITF_VL_TOTAL').AsCurrency     := Items.FieldByName('ICT_VL_SUBTOTAL').AsCurrency;
    cds_items.FieldByName('ITF_AQ_COM').AsFloat       := Items.FieldByName('ICT_AQ_COM').AsFloat;
    cds_items.FieldByName('ITF_VL_IPI').AsCurrency       := Items.FieldByName('ICT_AQ_IPI').AsCurrency;
    cds_items.FieldByName('tpr_nome').AsString        := Items.FieldByName('tpr_nome').AsString;
    cds_items.Post;
    LcValor := LcValor  + Items.FieldByName('ICT_VL_SUBTOTAL').AsCurrency;
    Items.Next;
  End;
  E_VL_Pedido.Caption := FloatToStrF(LcValor,ffFixed,10,2);

end;

procedure TFr_Itens_Produto_CTC_Vda.Pc_DefineCasaDecimalLocal;
begin
  inherited;
  It_Casa_Decimal := Gb_Casa_Dec_Venda;
end;

procedure TFr_Itens_Produto_CTC_Vda.Pc_FormataTela;
Var
  I : Integer;
begin
  inherited;
  IF (Gb_Nivel =0) then
  Begin
    if (Fc_Tb_Geral('L','ORC_G_EDIT_VL_UNIT','S') = 'S') then
      E_Vl_Unitario.ReadOnly := False
    else
      E_Vl_Unitario.ReadOnly := True;
  end;
  //For I:=1 to Pg_Main.PageCount do Pg_Main.Pages[I-1].TabVisible:=False;
//  /  Pg_Main.ActivePage :=tbs_item;
end;

procedure TFr_Itens_Produto_CTC_Vda.Pc_InsereServicoRelacionado(Pc_Codpro: Integer);
Var
  Lc_Itens : TControllerItensCotacao;
Begin
  try
    Lc_Itens := TControllerItensCotacao.Create(Self);
    Screen.Cursor := crHourGlass;
    Qr_Servico.Active := False;
    Qr_Servico.ParamByName('PRO_CODIGO').AsInteger := Pc_Codpro;
    Qr_Servico.Active := True;
    Qr_Servico.FetchAll;
    Qr_Servico.RecordCount;
    Qr_Servico.First;
    while not Qr_Servico.Eof do
    Begin
      Lc_Itens.clear;
      Lc_Itens.Registro.Cotacao       := 0;
      Lc_Itens.Registro.Tipo          := 'S';
      Lc_Itens.Registro.Vinculo       := Qr_Servico.FieldByname('PSI_CODSRV').AsInteger;
      Lc_Itens.Registro.DEscricao     := Qr_Servico.FieldByname('PRO_DESCRICAO').AsString;
      Lc_Itens.Registro.Quantidade    := 1;
      Lc_Itens.Registro.ValorUnitario := Qr_Servico.FieldByname('PRC_VL_VDA').AsCurrency;
      Lc_Itens.Registro.Disponivel    := 'S';
      Lc_Itens.Registro.AliqComissao  := Qr_Servico.FieldByname('PRC_AQ_COM').AsFloat;
      Lc_Itens.Registro.ValorDEsc     := StrToFloatDef(E_VL_Desconto.Text,0);
      Lc_Itens.Registro.ALiqDesc      := StrToFloatDef(E_Aq_Desconto.Text,0);
      Lc_Itens.Registro.AliqIPI       := StrToFloatDef(E_Aq_IPI.Text,0);
      Lc_Itens.Registro.AliqICMS      := StrToFloatDef(E_Aq_Icms.Text,0);
      Lc_Itens.Registro.CodigoEstoque := Fm_ListaEstoques.Dblcb_Estoque.Keyvalue;
      Lc_Itens.Registro.TabelaPreco   := Dblcb_Tabelas.KeyValue;
      Lc_Itens.Registro.ValorCusto    := StrToFloatDef(E_CustoUnitario.Text,0);
      //Lc_Itens.Registro.MargemLucro :=
      //Lc_Itens.Registro.AliqCtFinanceiro
      //Lc_Itens.Registro.PRazoPraticado
      //Lc_Itens.Registro.ValorPratica
      //Lc_Itens.Registro.AliqVendedor
      //Lc_Itens.Registro.Tecido
      //Lc_Itens.Registro.Cor
      //Lc_Itens.Registro.Pedido
      Lc_Itens.Registro.Altura        := StrtoFloatDef(e_Altura.Text,0);
      Lc_Itens.Registro.Largura       := StrtoFloatDef(e_Largura.Text,0);
      Lc_Itens.save;
      Qr_Servico.Next;
    end;
  finally
    FreeAndNil(Lc_Itens);
    Screen.Cursor := crDefault;
  end;
end;

procedure TFr_Itens_Produto_CTC_Vda.Pc_StateChange(Pc_Tipo: integer);
begin
  inherited;
  case Pc_Tipo of
    2:Begin //Inserindo
        Height := 690;
      end;
    3:Begin //Alterando
        Height := 308;
      end;
   end;

end;

procedure TFr_Itens_Produto_CTC_Vda.Pc_Tip_Busca(Pc_Tipo: char;
  Pc_cd_Tabela: Integer; Pc_cd_Prod, Pc_Desc_prod: String);
Var
   Lc_Nr_Itens : Integer;
   Lc_Cd_Tabela : Integer;
   Lc_Vl_Produto : Real;
   Lc_Qt_Minima : real;
   Lc_Aliq_Comissao : Real;
Begin
  if (Pc_cd_Prod = '') and (Pc_Desc_prod = '') then exit;
  Lc_Nr_Itens:= Fc_Busca_Cod_barra(Pc_cd_Prod);
  if Lc_Nr_Itens > 1 then // houve duplicidade de codigo de barra
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Encontrado duplicidade de código de barra.' + EOLN +
                   'Verifique o cadastro e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
  end;
  if Lc_Nr_Itens = 0 then  Lc_Nr_Itens := FC_Buscar(Pc_Tipo, Pc_cd_Tabela,Pc_cd_Prod,Pc_Desc_prod);  // nao encontrou codigo de baarra pesquisa normal
  case Lc_Nr_Itens of
    0:Begin
        It_Inserir := true;
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Produto não encontrado ou inativo.'+EOLN+
                       'Verfique e tente novamente.'+EOLN,
                        ['OK'],[bEscape],mpErro);
        Screen.Cursor := crDefault;
        Pc_LimpaCampos;
        if E_CodPro.CanFocus then E_CodPro.SetFocus;
        exit;
      end;
    1:Begin
        //vERifICA SE O PRODUTO ESTA ATIVO
        if Qr_Pesquisa.FieldByName('PRO_ATIVO').AsString <> 'S' then
        Begin
          MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                         'Este produto não está inativo.'+EOLN+
                         'Verfique e tente novamente.'+EOLN,
                        ['OK'],[bEscape],mpErro);
          Screen.Cursor := crDefault;
          if E_CodPro.CanFocus then E_CodPro.SetFocus;
          E_CodPro.Clear;
          exit;
        end;
        //Pc_Define Tabela
        Lc_Cd_Tabela := FC_DefineTabela(Pc_cd_Tabela);
        PC_Busca_Preco_Qtde(Lc_Cd_Tabela, It_Cd_Produto );
        Lc_Vl_Produto := Qr_Preco_Qtde.FieldByName('PRC_VL_VDA').AsCurrency * It_MultiplicadorPreco;
        Lc_Qt_Minima := Qr_Preco_Qtde.FieldByName('PRC_QT_MIN').AsFloat;
        if (It_Cd_Vendedor > 0 ) then
        Begin
          Lc_Aliq_Comissao := Fc_Aliquota_Comissao(It_Cd_Vendedor, Lc_Cd_Tabela,StrToIntDef(Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,0));
        End;
        Pc_PreencheTela(Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,
                        Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString,
                        Lc_Vl_Produto,
                        Qr_Pesquisa.FieldByName('PRO_VL_CUSTO').AsCurrency,
                        Qr_Pesquisa.FieldByName('MED_ABREVIATURA').AsString,
                        Lc_Aliq_Comissao,
                        Lc_Qt_Minima,
                        StrToIntDef(Qr_Pesquisa.FieldByName('PRO_COMPOSICAO').AsString,1),
                        Qr_Pesquisa.FieldByName('PRO_SUB_TRIB').AsString,
                        Qr_Pesquisa.FieldByName('PRO_VL_BASE_TROCA').AsCurrency);
        Pc_Totalizador;
        It_Inserir:=True;
      end;
    else
      Pc_MostraBusca;
  end;
   Screen.Cursor := crDefault;


end;

procedure TFr_Itens_Produto_CTC_Vda.Sb_LimparClick(Sender: TObject);
Var
  Lc_Form : TTasItemObs;
begin
  try
    Lc_Form := TTasItemObs.Create(Self);
    if ( Length(Trim(ItensCTC.Detalhe.Registro.Detalhe)) = 0 )  then
    Begin
      if  (ItensCTC.Registro.Codigo > 0) then
      Begin
        ItensCTC.Detalhe.Registro.ItemOrcamento := ItensCTC.Registro.Codigo;
        ItensCTC.Detalhe.getbyId;
      End;
    End;
    Lc_Form.E_Detalhe.Text := ItensCTC.Detalhe.Registro.Detalhe;
    Lc_Form.ShowModal;
    if (Lc_Form.Confirma) then
    Begin
      ItensCTC.Detalhe.Registro.Detalhe := Lc_Form.E_Detalhe.Text;
    End;
    ItensCTC.Detalhe.Registro.Detalhe := Lc_Form.E_Detalhe.Text;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

function TFr_Itens_Produto_CTC_Vda.validaGravacao: Boolean;
Var
  LcPRecoPadrao : String;
begin
  Result := True;
  if ( Fc_Tb_Geral('L','ORC_G_PRODUCT_REGISTRADO','N') = 'S') then
  Begin
    IF ( (Trim(E_CodPro.Text) = '') or (Trim(E_CodPro.Text) = '0') ) then
    Begin
      MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                     'Foi configurado no sistema para que somente produtos cadastrados sejam usados.'+ EOLN +
                     'Campo Código do Produto É Obrigatório.' + EOLN+
                     'Preencha antes de continuar.' + EOLN,
                      ['OK'], [bEscape], mpErro);
      if E_CodPro.CanFocus then E_CodPro.SetFocus;
      Result := False;
      exit;
    end;
  End;

  if not ValidacaoInicial then
  Begin
    result := False;
    exit;
  End;

  if not validaPreenchePreco then
  Begin
    Result := False;
    exit;
  End;
  if not validaQuantidadePromocao then
  Begin
    Result := False;
    Exit;
  End;
  if (Fc_Tb_Geral('L','VDA_G_PRECO_ACIMA','S') = 'S') then
  Begin
    LcPRecoPadrao := PrecoUnitarioCompara(Dblcb_Tabelas.KeyValue,StrtoIntDef(E_CodPro.Text,0));
    if (StrToFloatDef(E_Vl_Unitario.Text,0) >=   StrToFloatDef(LcPRecoPadrao,0) ) or GB_Liberado  then
    Begin
      if (Gb_Nivel = 0)  then Gb_Liberado := False;
    end
    else
    begin

      if not (Fc_VerificaPermissao('Fr_Pedido_Vda','Pedido de Venda','AUTORIZAR', GB_Cd_Usuario,'N')) then
      Begin
        MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                       'Valor Unitário menor do que o preço de tabela permitido ' + LcPRecoPadrao + '. '  + EOLN +
                       'Caso Necessário Peça Autorização.' + EOLN,
                        ['OK'], [bEscape], mpAlerta);
        E_Vl_Unitario.Text := LcPRecoPadrao;
        Result := False;
      end;
    end;
  End;
  //Não bloqueia a gravação  - Apenas Alerta
  if (StrToFloatDef(E_Qtde_Disp.Caption,0) = 0 ) then
  Begin
    MensagemPadrao(MENSAGEM, 'A L E R T A.' + EOLN + EOLN +
                   'Confirme preço pois este produto está sem estoque.'  + EOLN +
                   'Clique em ok para avançar com a gravação.' + EOLN,
                    ['OK'], [bEscape], mpAlerta);

  end;

end;


end.
