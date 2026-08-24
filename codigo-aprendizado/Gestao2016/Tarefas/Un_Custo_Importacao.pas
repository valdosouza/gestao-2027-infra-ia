unit Un_Custo_Importacao;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, ControllerItensImport, Vcl.Grids, Vcl.DBGrids, STQuery, Datasnap.Provider, Datasnap.DBClient, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, QEdit_Setes, System.Math, ControllerOrderImport, ControllerItensNFL;

type
  TFr_Custo_Importacao = class(TForm)
    cds_operacao: TClientDataSet;
    Dsp_operacao: TDataSetProvider;
    Qr_Operacao: TSTQuery;
    Panel5: TPanel;
    ds_operacao: TDataSource;
    cds_operacaoCTP_CODIGO: TIntegerField;
    cds_operacaoCTP_CODPED: TIntegerField;
    cds_operacaoCTP_DESCRICAO: TWideStringField;
    cds_operacaoCTP_BS_CALCULO: TFMTBCDField;
    cds_operacaoCTP_VL_ORIG: TFMTBCDField;
    cds_operacaoCTP_VL_REAL: TFMTBCDField;
    cds_operacaoCTP_CODITF: TIntegerField;
    cds_operacaoCTP_CODPRO: TIntegerField;
    cds_operacaoCTP_ORIGEM: TWideStringField;
    SB_Sair_0: TSpeedButton;
    cds_operacaoCTP_NF: TWideStringField;
    cds_operacaoCTP_TIPO: TWideStringField;
    cds_operacaoCTP_CALC: TWideStringField;
    SB_Confirmar: TSpeedButton;
    cds_operacaoCTP_REFERENCIA: TWideStringField;
    cds_operacaoCTP_COTACAO: TBCDField;
    Panel3: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    E_Data: TDateTimePicker;
    E_Cotacao_Gov: TEdit_Setes;
    Label9: TLabel;
    Pg_Geral: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Sb_Ins_Mercadoria: TSpeedButton;
    Sb_Def_Mercadoria: TSpeedButton;
    Sb_Exc_Mercadoria: TSpeedButton;
    dbg_operacao: TDBGrid;
    Rg_Options: TRadioGroup;
    Panel1: TPanel;
    Label8: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    E_VL_Mercadoria: TEdit;
    E_VL_Imposto: TEdit;
    E_VL_Diversos: TEdit;
    E_VL_Despesas: TEdit;
    E_VL_DEpositado: TEdit;
    E_VL_Saldo: TEdit;
    Panel4: TPanel;
    dbg_itens: TDBGrid;
    Panel6: TPanel;
    Label15: TLabel;
    E_VL_Produtos: TEdit;
    Sb_Ins_Produto: TBitBtn;
    Sb_Alt_Produto: TBitBtn;
    Sb_Exc_Produto: TBitBtn;
    Qr_itens: TSTQuery;
    ds_itens: TDataSource;
    Qr_itensTB_PRODUCT_ID: TIntegerField;
    Qr_itensPRO_DESCRICAO: TStringField;
    Qr_itensQTDE: TBCDField;
    Qr_itensUNIT_VALUE: TFMTBCDField;
    Qr_itensQUOTATION: TBCDField;
    Qr_itensSUBTOTAL: TFMTBCDField;
    Qr_itensID: TIntegerField;
    Qr_itensTB_ORDER_ID: TIntegerField;
    RG_TradeSystem: TRadioGroup;
    Qr_Order: TSTQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    IBStringField1: TStringField;
    IBBCDField1: TBCDField;
    FMTBCDField1: TFMTBCDField;
    IBBCDField2: TBCDField;
    FMTBCDField2: TFMTBCDField;
    E_Nr_Invoice: TEdit;
    E_Cotacao_Compra: TEdit_Setes;
    Label10: TLabel;
    Button1: TButton;
    Sb_LancaItensPedidoCompra: TBitBtn;
    procedure InsereAvulso(cds: TClientDataSet;Descricao:String;Tipo,NF,CUSTO:String);
    procedure initVariable;
    procedure setVariable;
    procedure Sb_Def_MercadoriaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_Ins_MercadoriaClick(Sender: TObject);
    procedure Sb_Exc_MercadoriaClick(Sender: TObject);
    procedure Rg_OptionsClick(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure cds_operacaoBeforePost(DataSet: TDataSet);
    procedure dbg_operacaoTitleClick(Column: TColumn);
    procedure cds_operacaoAfterOpen(DataSet: TDataSet);
    procedure cds_operacaoAfterPost(DataSet: TDataSet);
    procedure cds_operacaoAfterDelete(DataSet: TDataSet);
    procedure Sb_Ins_ProdutoClick(Sender: TObject);
    procedure Sb_Alt_ProdutoClick(Sender: TObject);
    procedure Sb_Exc_ProdutoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Sb_LancaItensPedidoCompraClick(Sender: TObject);
  private
    { Private declarations }
    procedure ShowData;
    procedure save;
    procedure Pc_ImagemBotao;
    function ValidaInsMercadoriaPadrao:boolean;
    procedure InsMercadoriaPadrao;
    procedure InsMercadoriaAvulso;
    function validaDeteteItems:Boolean;
    procedure DeleteItem(cds: TClientDataSet);
    function getNext:Integer;
    procedure SomaItens;
    procedure SomaProdutos;
    procedure UpdateOrderImporter;
    procedure LancaItensPedidoCompra;
  public
    CodigoPedido : Integer;
    OrderImport : TControllerOrderImport;
  end;

var
  Fr_Custo_Importacao: TFr_Custo_Importacao;

implementation

{$R *.dfm}

uses     Un_Msg, Un_DM, UN_Principal, env, un_itens_importacao, Un_Funcoes, UN_Sistema;
procedure TFr_Custo_Importacao.Button1Click(Sender: TObject);
Var
  LcVLCompra : REal;
  LcVLDepositado : REal;
  LcVlGoverno : Real;
  LcVlOutros : Real;
  LcVLCotacao : REal;
begin
  //Cotação de Compra
  LcVLCompra := StrToFloatDEf(Fc_RemoveCaracterInformado(E_VL_Produtos.Text, ['.']),0);
  LcVLDepositado := StrToFloatDEf(Fc_RemoveCaracterInformado(E_VL_DEpositado.Text, ['.']),0);
  if LcVLCompra > 0 then
    LcVLCotacao := LcVLDepositado / LcVLCompra
  else
    LcVLCotacao := 1;
  E_Cotacao_Compra.text := FloatToSTrF(LcVLCotacao,ffFixed,10,2);
  //cotação do governo
  LcVlGoverno := StrToFloatDEf(Fc_RemoveCaracterInformado(E_VL_Mercadoria.Text, ['.']),0);
  cds_Operacao.Filter := concat(' ( CTP_TIPO = ''MER'' ) AND ( CTP_CALC = ''',SIM,''' ) ');
  cds_Operacao.Filtered := True;
  with cds_Operacao do
  Begin
    First;
    LcVlOutros := 0;
    while not eof do
    Begin
      LcVlOutros := LcVlOutros + FieldByName('CTP_VL_ORIG').AsCurrency;
      next;
    End;
  End;
  cds_Operacao.Filtered := False;
  LcVLCompra  := LcVLCompra + LcVlOutros;
  if LcVLCompra > 0 then
    LcVLCotacao := LcVlGoverno / LcVLCompra
  else
    LcVLCotacao := 1;
  E_Cotacao_Gov.text := FloatToSTrF(LcVLCotacao,ffFixed,10,2);
end;

procedure TFr_Custo_Importacao.cds_operacaoAfterDelete(DataSet: TDataSet);
begin
  SomaItens;
end;

procedure TFr_Custo_Importacao.cds_operacaoAfterOpen(DataSet: TDataSet);
begin
  SomaItens;
end;

procedure TFr_Custo_Importacao.cds_operacaoAfterPost(DataSet: TDataSet);
begin
  SomaItens;
end;

procedure TFr_Custo_Importacao.cds_operacaoBeforePost(DataSet: TDataSet);
begin
  cds_OperacaoCTP_VL_REAL.AsCurrency := cds_OperacaoCTP_VL_ORIG.AsCurrency * cds_OperacaoCTP_COTACAO.AsFloat;
end;

procedure TFr_Custo_Importacao.dbg_operacaoTitleClick(Column: TColumn);
begin
  cds_Operacao.IndexFieldNames := Column.FieldName;
end;

procedure TFr_Custo_Importacao.DeleteItem(cds: TClientDataSet);
begin
  cds.Delete;
end;

procedure TFr_Custo_Importacao.FormCreate(Sender: TObject);
begin
  initVariable;
end;

procedure TFr_Custo_Importacao.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  setVariable;
  ShowData;
end;

function TFr_Custo_Importacao.getNext: Integer;
var
  marcador:TBookmark;//
begin
  with cds_Operacao do
  Begin
    marcador:= GetBookmark;
    try
      DisableControls;
      Result := 0;
      try
        filtered :=False;
        First;
        while not Eof do
        begin
          if FieldByName('ctp_codigo').AsInteger >Result then
            Result :=  fieldbyname('ctp_codigo').AsInteger;
          Next;
        end;
      finally
        filtered :=True;
        EnableControls;
      end;
    finally
      GotoBookmark(marcador);
      FreeBookmark(marcador);
    end;
  End;
  inc(Result);
end;

procedure TFr_Custo_Importacao.initVariable;
begin
  OrderImport := TControllerOrderImport.create(Self);
end;

procedure TFr_Custo_Importacao.InsereAvulso(cds: TClientDataSet;Descricao:String;Tipo,NF,CUSTO:String);
Var
  LcCodigo : Integer;
begin
  with cds do
  Begin
    LcCodigo := getNext;
    Append;
    FieldByName('CTP_CODIGO').AsInteger := LcCodigo;
    FieldByName('CTP_CODPED').AsInteger := CodigoPedido;
    FieldByName('CTP_DESCRICAO').AsString := Descricao;
    FieldByName('CTP_BS_CALCULO').AsFloat := 0;
    FieldByName('CTP_VL_ORIG').AsCurrency := 0;
    FieldByName('CTP_COTACAO').AsFloat := 1;
    FieldByName('CTP_VL_REAL').AsCurrency := 0;
    FieldByName('CTP_CODITF').AsInteger := 0;
    FieldByName('CTP_CODPRO').AsInteger := 0;
    FieldByName('CTP_ORIGEM').AsString := 'A';
    FieldByName('CTP_CALC').AsString := CUSTO;
    FieldByName('CTP_NF').AsString := NF;
    FieldByName('CTP_TIPO').AsString := Tipo;

    Post;
  End;
end;

procedure TFr_Custo_Importacao.InsMercadoriaAvulso;
begin

end;

procedure TFr_Custo_Importacao.InsMercadoriaPadrao;
Var
  I: Integer;
begin
  if not cds_Operacao.Active then cds_Operacao.CreateDataSet;
  //Mercadoria
  if ( Rg_Options.ItemIndex = 0 ) then
  Begin
    Rg_OptionsClick(self);
    if cds_Operacao.RecordCount = 0 then
    Begin
      InsereAvulso(cds_Operacao,'VALOR DA MERCADORIA','MER',SIM,NAO);
      InsereAvulso(cds_Operacao,'VALOR FRETE','MER',SIM,NAO);
    End
    else
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'A lista não está ativa.'+EOLN+
                     'Não é possível efetuar essa operação.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    End;
  End;
  //Imposto
  if ( Rg_Options.ItemIndex = 1 ) then
  Begin
    Rg_OptionsClick(self);
    if cds_Operacao.RecordCount = 0 then
    Begin
      InsereAvulso(cds_Operacao,'IPI - ','IMP',SIM,SIM);
      InsereAvulso(cds_Operacao,'II - ','IMP',SIM,SIM);
      InsereAvulso(cds_Operacao,'OUTRAS - PIS','IMP',SIM,SIM);
      InsereAvulso(cds_Operacao,'OUTRAS - COFINS','IMP',SIM,SIM);
      InsereAvulso(cds_Operacao,'OUTRAS - TAXA SISCOMEX','IMP',SIM,SIM);
      InsereAvulso(cds_Operacao,'ICMS','IMP',SIM,SIM);
      InsereAvulso(cds_Operacao,'BASE ICMS','IMP',SIM,NAO);
    End
    else
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'A lista não está ativa.'+EOLN+
                     'Não é possível efetuar essa operação.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    End;
  End;
  //despesas diversas
  if ( Rg_Options.ItemIndex = 2 ) then
  Begin
    Rg_OptionsClick(self);
    if cds_Operacao.RecordCount = 0 then
    Begin
      InsereAvulso(cds_Operacao,'FRETE - LIBERAÇÃO DOC JUNTO AGENCIA','DIV',SIM,SIM);
      InsereAvulso(cds_Operacao,'FRETE - DESEMBARAÇO','DIV',SIM,SIM);
      InsereAvulso(cds_Operacao,'FRETE - ACOMPANHAMENTO PARANAGUA','DIV',SIM,SIM);
      InsereAvulso(cds_Operacao,'OUTRAS - TAXA LIBERAÇÃO TCP','DIV',SIM,SIM);
      InsereAvulso(cds_Operacao,'OUTRAS - AFRMM','DIV',SIM,SIM);
      InsereAvulso(cds_Operacao,'OUTRAS - S.D.A','DIV',SIM,SIM);
    End
    else
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'A lista não está ativa.'+EOLN+
                     'Não é possível efetuar essa operação.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    End;
  End;
end;

procedure TFr_Custo_Importacao.LancaItensPedidoCompra;
Var
  LcItens : TControllerItensNFL;
  LcValorProdutos : Real;
  LcValorGoverno : Real;
  LcVlCotacao : Real;
  LcTxPropor : Real;
  LcValorSutotal : Real;
  LcValorUnitario : Real;
begin
  LcVlCotacao := StrToFloatDEf(Fc_RemoveCaracterInformado(E_Cotacao_Gov.Text, ['.']),0);
  LcValorProdutos := StrToFloatDEf(Fc_RemoveCaracterInformado(E_VL_Produtos.Text, ['.']),0);
  LcValorGoverno := StrToFloatDEf(Fc_RemoveCaracterInformado(E_VL_Mercadoria.Text, ['.']),0);

  LcItens := TControllerItensNFL.Create(Self);
  with Qr_itens,LcItens.Registro do
  Begin
    Active := True;
    First;
    while not eof do
    Begin
      //Calcula a proporção de cada item
      LcTxPropor := fIeldByName('SUBTOTAL').AsCurrency / LcValorProdutos;
      LcValorSutotal := (LcValorGoverno * LcTxPropor);
      LcValorUnitario := LcValorSutotal / fIeldByName('QTDE').AsFloat;
      LcValorUnitario := RoundTo( LcValorUnitario ,-3);
      Codigo            := 0;
      CodigoPedido      := Self.CodigoPedido;
      CodigoNota        := 0;
      CodigoProduto     := fIeldByName('TB_PRODUCT_ID').AsInteger;
      Quantidade        := fIeldByName('QTDE').AsFloat;
      ValorCusto        := LcValorUnitario;
      ValorUnitario     := LcValorUnitario;
      Despachar         := 'S';
      Estoque           := 'S';
      Operacao          := 'C';
      CodigoEstoque     := Gb_Estoque;
      CodigoTabela      := 1;
      Sentido           := 'E';
      LcItens.insere;
      next;
    End;
  End;
end;

procedure TFr_Custo_Importacao.Pc_ImagemBotao;
begin
  with fr_principal do
  Begin
    SB_Confirmar.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

procedure TFr_Custo_Importacao.Rg_OptionsClick(Sender: TObject);
begin
  case Rg_Options.ItemIndex of
    0:cds_Operacao.Filter := ' ( CTP_TIPO = ''MER'' ) ';
    1:cds_Operacao.Filter := ' ( CTP_TIPO = ''IMP'' ) ';
    2:cds_Operacao.Filter := ' ( CTP_TIPO = ''DIV'' ) ';
    3:cds_Operacao.Filter := ' ( CTP_TIPO = ''DEP'' ) ';
  else
    cds_Operacao.Filter := '';
  end;
  cds_Operacao.Filtered := ( cds_Operacao.Filter <> '');
  SomaItens;
end;

procedure TFr_Custo_Importacao.save;
begin
  with OrderImport.Registro do
  Begin
    NumeroInvoice := E_Nr_Invoice.Text;
    Data := E_Data.DateTime;
    CotacaoGoverno := StrToFloatDef(E_Cotacao_Gov.Text,0);
    CotacaoCompra := StrToFloatDef(E_Cotacao_Compra.Text,0);
    TradeSystem := IntToStr(RG_TradeSystem.ItemIndex);
  End;
  OrderImport.salva;
end;

procedure TFr_Custo_Importacao.Sb_Alt_ProdutoClick(Sender: TObject);
Var
  Lc_Form: TFr_itens_importacao;
begin
  //Cria O Formulario
  Lc_Form := TFr_itens_importacao.Create(Self);
  Lc_Form.Itens.Registro.Codigo := Qr_itensID.AsInteger;
  Lc_Form.Itens.Registro.Ordem := Qr_itensTB_ORDER_ID.AsInteger;
  //Interface
  Lc_Form.E_CodPro.ReadOnly := True;
  Lc_Form.E_Descricao.ReadOnly := True;
  Lc_Form.E_CodPro.Text := Qr_itensTB_PRODUCT_ID.AsString;
  Lc_Form.E_Descricao.Text := Qr_itensPRO_DESCRICAO.AsString;
  Lc_Form.E_Qt_Produto.Text := Qr_itensQTDE.AsString;
  Lc_Form.E_Vl_Unitario.Text := Qr_itensUNIT_VALUE.AsString;
  Lc_Form.E_Cotacao.Text := FloatToStrF(Qr_itensQUOTATION.AsFloat,ffFixed,10,2);
  Lc_Form.E_Vl_SubTotal.Caption := FloatToStrF(Qr_itensSUBTOTAL.AsCurrency,ffFixed,10,2);
  Lc_Form.ShowModal;
  FreeAndNil(Lc_Form);
  SomaProdutos

end;

procedure TFr_Custo_Importacao.SB_ConfirmarClick(Sender: TObject);
begin
  try
    save;
    cds_Operacao.ApplyUpdates(-1);
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    MensagemPadrao(MENSAGEM, 'S U C E S S O!.' + EOLN + EOLN +
                   'Tabela Atualizada com sucesso' + EOLN + EOLN ,
                   ['OK'], [bEscape], mpInformacao);
  except
    on e:exception do
    begin
      MensagemPadrao(MENSAGEM, 'E R R O!.' + EOLN + EOLN +
                     E.Message + EOLN ,
                     ['OK'], [bEscape], mpErro);
    end;
  end;
end;

procedure TFr_Custo_Importacao.Sb_Def_MercadoriaClick(Sender: TObject);
begin
  if ValidaInsMercadoriaPadrao then
    InsMercadoriaPadrao;
end;

procedure TFr_Custo_Importacao.Sb_Exc_MercadoriaClick(Sender: TObject);
begin
  if validaDeteteItems then
    DeleteItem(cds_Operacao);
end;

procedure TFr_Custo_Importacao.Sb_Exc_ProdutoClick(Sender: TObject);
Var
  LcItens : TControllerItensImport;
begin
  If (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o item '+Qr_itensPRO_DESCRICAO.AsString +EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    if ( Qr_itensID.AsInteger > 0 ) then
    Begin
      LcItens := TControllerItensImport.Create(Self);
      LcItens.Registro.Codigo := Qr_itensID.AsInteger;
      LcItens.Registro.Ordem := Qr_itensTB_ORDER_ID.AsInteger;
      LcItens.delete;
      SomaProdutos
    End;
  End;
end;

procedure TFr_Custo_Importacao.Sb_Ins_MercadoriaClick(Sender: TObject);
begin
  if not cds_Operacao.Active then cds_Operacao.CreateDataSet;
  case Rg_Options.ItemIndex of
    0:InsereAvulso(cds_Operacao,'INFORME A DESCRIÇÃO','MER',SIM,SIM);
    1:InsereAvulso(cds_Operacao,'INFORME A DESCRIÇÃO','IMP',SIM,SIM);
    2:InsereAvulso(cds_Operacao,'INFORME A DESCRIÇÃO','DIV',SIM,SIM);
    3:InsereAvulso(cds_Operacao,'INFORME A DESCRIÇÃO','DEP',SIM,SIM);
  else
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Não é posivel inserir com o Filtro TODOS'+EOLN+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    End;
  end;

end;

procedure TFr_Custo_Importacao.Sb_Ins_ProdutoClick(Sender: TObject);
Var
  Lc_Form: TFr_itens_importacao;
begin
  //Cria O Formulario
  Lc_Form := TFr_itens_importacao.Create(Self);
  Lc_Form.E_CodPro.ReadOnly := False;
  Lc_Form.E_Descricao.ReadOnly := False;
  Lc_Form.Itens.Registro.Codigo := 0;
  Lc_Form.Itens.Registro.Ordem := CodigoPedido;
  Lc_Form.E_Qt_Produto.Text := '1,00';
  Lc_Form.E_Cotacao.Text := '1,00';
  Lc_Form.ShowModal;
  FreeAndNil(Lc_Form);
  SomaProdutos
end;

procedure TFr_Custo_Importacao.Sb_LancaItensPedidoCompraClick(Sender: TObject);
begin
  LancaItensPedidoCompra;
end;

procedure TFr_Custo_Importacao.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Custo_Importacao.setVariable;
begin
  OrderImport.Registro.Estabelecimento := Gb_CodMha;
  OrderImport.Registro.Ordem := CodigoPedido;
  OrderImport.getbyId;

  Qr_Operacao.Active := False;
  Qr_Operacao.ParamByName('CTP_CODPED').AsInteger := CodigoPedido;
  Qr_Operacao.Active := True;
  cds_Operacao.Active := True;
  //Itens
  Qr_Itens.Active := False;
  Qr_Itens.ParamByName('ORDER_ID').AsInteger := CodigoPedido;
  Qr_Itens.Active := True;
  SomaProdutos;
end;

procedure TFr_Custo_Importacao.ShowData;
begin
  E_Nr_Invoice.Text := OrderImport.Registro.NumeroInvoice;
  E_Data.DateTime := OrderImport.Registro.Data;
  E_Cotacao_Gov.Text := FloatToStrF(OrderImport.Registro.CotacaoGoverno,ffFixed,10,2);
  E_Cotacao_Compra.Text := FloatToStrF(OrderImport.Registro.CotacaoCompra,ffFixed,10,2);
  RG_TradeSystem.ItemIndex := StrToIntDef(OrderImport.Registro.TradeSystem,0);
end;

procedure TFr_Custo_Importacao.SomaItens;
Var
  LcFilter : Boolean;

  Lc_Vl_Mercadoria : Real;
  Lc_Vl_Imposto : Real;
  Lc_Vl_Diversos : Real;
  Lc_VL_Depositado : Real;
begin
  with cds_Operacao do
  Begin
    LcFilter := Filtered;
    if LcFilter then Filtered := False;
    Lc_Vl_Mercadoria  := 0;
    Lc_Vl_Imposto     := 0;
    Lc_Vl_Diversos    := 0;
    Lc_VL_Depositado  := 0;
    First;
    while not eof do
    Begin
      if (FieldByName('ctp_calc').AsString = SIM ) then
      Begin
        if (FieldByName('ctp_tipo').AsString = 'MER' ) then
          Lc_Vl_Mercadoria  := Lc_Vl_Mercadoria + FieldByName('ctp_vl_real').AsCurrency;
        if (FieldByName('ctp_tipo').AsString = 'IMP' ) then
          Lc_Vl_Imposto     := Lc_Vl_Imposto    + FieldByName('ctp_vl_real').AsCurrency;
        if (FieldByName('ctp_tipo').AsString = 'DIV' ) then
          Lc_Vl_Diversos    := Lc_Vl_Diversos   + FieldByName('ctp_vl_real').AsCurrency;
        if (FieldByName('ctp_tipo').AsString = 'DEP' ) then
          Lc_VL_Depositado  := Lc_VL_Depositado + FieldByName('ctp_vl_real').AsCurrency;
      End;
      next;
    End;
  if LcFilter then Filtered := true;
  End;
  E_VL_Mercadoria.Text := FloattoStrF(Lc_Vl_Mercadoria,ffNumber,10,2);
  E_VL_Imposto.Text := FloattoStrF(Lc_Vl_Imposto,ffNumber,10,2);
  E_VL_Diversos.Text := FloattoStrF(Lc_Vl_Diversos,ffNumber,10,2);
  E_VL_Despesas.Text := FloattoStrF(Lc_Vl_Imposto + Lc_Vl_Diversos,ffNumber,10,2);
  E_VL_DEpositado.Text := FloattoStrF(Lc_VL_Depositado,ffNumber,10,2);
  E_VL_Saldo.Text := FloattoStrF( Lc_VL_Depositado - (Lc_Vl_Imposto + Lc_Vl_Diversos),ffNumber,10,2);
end;

procedure TFr_Custo_Importacao.SomaProdutos;
Var
  LcValor : Real;
begin
  with Qr_itens do
  Begin
    Active := False;
    ParamByName('order_id').AsInteger := CodigoPedido;
    Active := True;
    First;
    LcValor := 0;
    while not eof do
    Begin
      LcValor := LcValor + FieldByName('SUBTOTAL').AsCurrency;
      next;
    End;
  End;
  E_VL_Produtos.Text := FloattoStrF(LcValor,ffNumber,10,2);
end;

procedure TFr_Custo_Importacao.UpdateOrderImporter;
begin
//  with Qr_Order do
//  Begin
//    ParamByName('TB_INSTITUTION_ID').AsInteger := Gb_CodMha;
//    ParamByName('TB_ORDER_ID').AsInteger := CodigoPedido;
//    ParamByName('NUMBER').AsString := '';
//    ParamByName('DATA').AsDate := E_Data.DateTime;
//    ParamByName('INVOICE_NUMBER').AsString := E_Nr_Invoice.Text;
//    ParamByName('QUOTATION_STATE').AsFloat := StrToFloatDef(E_Cotacao.Text,1);
//    ParamByName('TRADE_SYSTEM').AsInteger := IntToStr(RG_TradeItemIndex) ;
//    ExecSQL;
//    ApplyUpdates(-1);
//  End;
end;

function TFr_Custo_Importacao.validaDeteteItems: Boolean;
begin
  Result := True;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir este registro de seus arquivos'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                      [NAO,SIM],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;

  if cds_Operacao.RecordCount = 0 then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'A lista não contém itens.'+EOLN+
                   'Não é possivel excluir.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
  End;
end;

function TFr_Custo_Importacao.ValidaInsMercadoriaPadrao: boolean;
begin
  Result := True;

end;

end.
