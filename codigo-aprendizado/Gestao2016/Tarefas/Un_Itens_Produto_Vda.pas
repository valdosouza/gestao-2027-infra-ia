unit Un_Itens_Produto_Vda;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Itens_Produto, Actions, Vcl.ActnList, Data.DB, STQuery, Vcl.StdCtrls, Un_Fm_ListaEstoques, Vcl.DBCtrls, Vcl.Mask, QEdit_Setes, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, Vcl.ComCtrls, Un_fm_ListaTributacao, ControllerPedido;


type
  TFr_Itens_Produto_Vda = class(TFr_Itens_Produto)
    E_VL_Base_troca: TEdit_Setes;
    Chbx_sem_base_troca: TCheckBox;
    pnl_base_troca: TPanel;
    Sb_last_sales_items: TSpeedButton;
    procedure E_Qt_ProdutoExit(Sender: TObject);
    procedure E_Vl_UnitarioExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_last_sales_itemsClick(Sender: TObject);

  private
    { Private declarations }
    FValorBaseTroca : Real;
    FValorVenda : Real;
    FValorCusto : Real;
    function ValidaAberturaLastItemsSold:Boolean;
    procedure AberturaLastItemsSold;
    procedure Pc_StateChange(Pc_Tipo: integer);Override;
    procedure ListaTributacao;
    function ValidaInfoBaseTroca:Boolean;
    procedure Chbx_sem_base_trocaClick(Sender: TObject);
   protected
    procedure Pc_DefineCasaDecimalLocal;Override;
    function validaGravacao:Boolean;Override;
    procedure Pc_formatatela;Override;
    function grava:Boolean;Override;
    function SqlEspecifico:String;Override;
    procedure LoadItems(Items:TSTQuery);Override;
    procedure Pc_IniciaVariaveis;Override;
    procedure editItems(CodigoItem: Integer);Override;
    procedure verificaBaseTroca; Override;
    procedure DefineValoresEspecificos(Pc_Cd_Tabela : Integer);Override;
    procedure Pc_PreencheTela(Pc_Codpro: string;
                              Pc_DESCRICAO: string;
                              Pc_VL_Venda: Real;
                              Pc_Custo: Real;
                              Pc_Unidade: string;
                              Pc_Aliq_Com: Real;
                              Pc_Qtde: Real;
                              Pc_Composicao:Integer;
                              Pc_Subs_Trib:String;
                              Pc_Vl_Base_Troca:Real);Override;
  public
    { Public declarations }
    procedure Pc_MostraSaldo;Override;
  end;

var
  Fr_Itens_Produto_Vda: TFr_Itens_Produto_Vda;

implementation

{$R *.dfm}

uses     ControllerItensNFL, UN_Sistema, RN_Estoque, RN_Lotes, Un_Regra_Negocio, Un_Msg, UN_Principal, env, RN_Permissao, Un_Liberacao, tas_items_sales_before;
procedure TFr_Itens_Produto_Vda.Chbx_sem_base_trocaClick(Sender: TObject);
begin
  if (TCheckBox(Sender).Checked) then
  Begin
    E_Vl_Unitario.Text := FormatFloat(It_Casa_Decimal, (FValorVenda + FValorBaseTroca));
    E_CustoUnitario.Text := FormatFloat(It_Casa_Decimal, (FValorCusto + FValorBaseTroca));
    E_VL_Base_troca.Text := FormatFloat(It_Casa_Decimal, (FValorBaseTroca ));

    ItensNFL.BaseTroca.Registro.Estabelecimento := Gb_CodMha;
    ItensNFL.BaseTroca.Registro.Ordem := ItensNFL.Registro.CodigoPedido;
    ItensNFL.BaseTroca.Registro.Item := ItensNFL.Registro.Codigo;
    ItensNFL.BaseTroca.delete;
  End
  else
  Begin
    E_Vl_Unitario.Text := FormatFloat(It_Casa_Decimal, FValorVenda );
    E_CustoUnitario.Text := FormatFloat(It_Casa_Decimal, FValorCusto);
    E_VL_Base_troca.Text := '0,00';

  End;
  Pc_Totalizador;
end;

procedure TFr_Itens_Produto_Vda.DefineValoresEspecificos(Pc_Cd_Tabela : Integer);
begin
  inherited;
  PC_Busca_Preco_Qtde(ItensNFL.Registro.CodigoTabela, It_Cd_Produto );

  ItensNFL.Registro.ValorUnitario := Qr_Preco_Qtde.FieldByName('PRC_VL_VDA').AsCurrency * It_MultiplicadorPreco;
  //ItensNFL.Registro.Quantidade := Qr_Preco_Qtde.FieldByName('PRC_QT_MIN').AsFloat;
  ItensNFL.Registro.Quantidade := StrToFloatDef(E_Qt_Produto.Text,1);
  if (It_Cd_Vendedor > 0 ) then
  Begin
    ItensNFL.Registro.AliqComissao := Fc_Aliquota_Comissao(It_Cd_Vendedor, ItensNFL.Registro.CodigoTabela,StrToIntDef(Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,0));
  End;


end;

procedure TFr_Itens_Produto_Vda.editItems(CodigoItem: Integer);
begin
  inherited;
  Try
    ItensNFL.Produto.Registro.Codigo := ItensNFL.Registro.CodigoProduto;
    ItensNFL.Produto.getbyId;
    pnl_base_troca.Visible := (ItensNFL.Produto.Registro.ValorBaseTroca > 0);
    if pnl_base_troca.Visible then
    Begin
      FValorBaseTroca := ItensNFL.Produto.Registro.ValorBaseTroca;
      ItensNFL.BaseTroca.Registro.Estabelecimento := Gb_CodMha;
      ItensNFL.BaseTroca.Registro.Ordem := ItensNFL.Registro.CodigoPedido;
      ItensNFL.BaseTroca.Registro.Item := ItensNFL.Registro.Codigo;
      ItensNFL.BaseTroca.getByKey;
      Chbx_sem_base_troca.OnClick := nil;
      if (ItensNFL.BaseTroca.exist) then
      Begin
        Chbx_sem_base_troca.Checked := False;
        E_VL_Base_troca.Text := '0,00';
        FValorVenda := ItensNFL.Registro.ValorUnitario;
        FValorCusto := ItensNFL.Registro.ValorCusto;
      End
      else
      Begin
        Chbx_sem_base_troca.Checked := true;
        E_VL_Base_troca.Text := FloatToStrF(FValorBaseTroca,ffNumber,10,2);
        FValorVenda := ItensNFL.Registro.ValorUnitario - FValorBaseTroca;
        FValorCusto := ItensNFL.Registro.ValorCusto - FValorBaseTroca;
      End;
    End;
  Finally
    Chbx_sem_base_troca.OnClick := Chbx_sem_base_trocaClick;
  End;
end;

procedure TFr_Itens_Produto_Vda.E_Qt_ProdutoExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := 0;
  Lc_Valor := StrToFloatDef(E_Qt_Produto.Text, 0);
  if (Lc_Valor >= 100000) then Lc_Valor := 1;
  E_Qt_Produto.Text := FloatToStr(Lc_Valor);

  if (Fc_Tb_Geral('L','VDA_G_PROMOCAO_QUANTIDADE','S') = 'S') then
    PC_Verifica_Preco_Qtde(2, It_Cd_Produto );
  Pc_Totalizador;
end;

procedure TFr_Itens_Produto_Vda.E_Vl_UnitarioExit(Sender: TObject);
begin
  E_Vl_Unitario.Text := FormatFloat(It_Casa_Decimal, StrToFloatDef(E_Vl_Unitario.Text, 0));
  Pc_Totalizador;
end;

procedure TFr_Itens_Produto_Vda.Pc_formatatela;
begin
  inherited;
  IF (Gb_Nivel =0) then
  Begin
    if (Fc_Tb_Geral('L','VDA_G_EDIT_VL_UNIT','S') = 'S') then
      E_Vl_Unitario.ReadOnly := False
    else
      E_Vl_Unitario.ReadOnly := True;
  end;
end;

procedure TFr_Itens_Produto_Vda.Pc_IniciaVariaveis;
begin
  inherited;
  ListaTributacao;
  Chbx_sem_base_troca.OnClick := Chbx_sem_Base_trocaClick;
end;

procedure TFr_Itens_Produto_Vda.Pc_MostraSaldo;
Var
  Lc_Qtde : real;
begin
  E_Qtde_Disp.ParentColor := False;
  E_Qtde_Disp.ParentFont := False;
  Lb_Tipo.Font.Color := clGreen;
  E_Qtde_Disp.Color := clGreen;
  if ( It_Cd_Produto > 0) then
    Lc_Qtde := Fc_SaldoEstoque(StrToIntDef(E_CodPro.Text,0),Fm_ListaEstoques.Dblcb_Estoque.KeyValue);
  if (It_StateChange = 3)  AND  ( ItensNFL.Registro.Estoque = 'S')then
    Lc_Qtde := Lc_Qtde + (StrToFloatDef(E_Qt_Produto.Text,1));
  if (Lc_Qtde <= 0) and (trim(E_CodPro.Text) <> '') then
    Begin
    Lb_Tipo.Font.Color := clRed;
    E_Qtde_Disp.Color := clRed;
    end;
  E_Qtde_Disp.Caption := formatFloat('0.##',Lc_Qtde );

end;

procedure TFr_Itens_Produto_Vda.Pc_PreencheTela(Pc_Codpro, Pc_DESCRICAO: string; Pc_VL_Venda, Pc_Custo: Real;
  Pc_Unidade: string; Pc_Aliq_Com, Pc_Qtde: Real; Pc_Composicao: Integer;
  Pc_Subs_Trib: String; Pc_Vl_Base_Troca: Real);
begin
  inherited;
  FValorVenda := Pc_VL_Venda;
  FValorCusto := Pc_Custo;
  if (Pc_Vl_Base_Troca > 0) then
  Begin
    pnl_base_troca.Visible := True;
    FValorBaseTroca := Pc_Vl_Base_Troca;
  End
  else
  Begin
    pnl_base_troca.Visible := False;
    FValorBaseTroca := 0;
  End;
  Sb_last_sales_items.Enabled := (Pc_Codpro <> '');
end;

procedure TFr_Itens_Produto_Vda.Pc_StateChange(Pc_Tipo: integer);
begin
  inherited;
  case Pc_Tipo of
    2:Begin //Inserindo
        Height := 690;
      end;
    3:Begin //Alterando
        Height := 360;
      end;
   end;
end;

procedure TFr_Itens_Produto_Vda.FormShow(Sender: TObject);
begin
  inherited;
  PosicaoCampoComissao;
end;

function TFr_Itens_Produto_Vda.grava:Boolean;
Var
  Lc_Estoque : String;

Begin
  if Fc_ExisteItemNoPedido('V') then
  Begin
    if Chbx_Estoque.Checked then Lc_Estoque := 'S' else Lc_Estoque := 'N';
    //Verfica se lanca os itens da composição
    if It_Composicao <> 5 then
    Begin
      with ItensNFL.Registro do
      Begin
        CodigoPedido := ItensNFL.Registro.CodigoPedido;
        CodigoProduto := It_Cd_Produto;
        Quantidade := StrToFloatDef(E_Qt_Produto.Text,0);
        ValorCusto := StrToFloatDef(E_CustoUnitario.Text,0);
        ValorUnitario := StrToFloatDef(E_Vl_Unitario.Text,0);
        AliqDesconto := StrToFloatDef(E_Aq_Desconto.Text,0);
        ValorDesconto := StrToFloatDef(E_VL_Desconto.Text,0);
        AliqComissao := StrToFloatDef(E_Aq_Com.Text,0);
        Operacao := 'V';
        Estoque := Lc_Estoque;
        Despachar := 'S';
        AliqIPI := StrToFloatDef(E_Aq_IPI.Text,0);
        AliqICMS := StrToFloatDef(E_Aq_Icms.Text,0);
        CodigoEstoque := Fm_ListaEstoques.Dblcb_Estoque.Keyvalue;
        CodigoTabela := Dblcb_Tabelas.KeyValue;
        Largura := StrtoFloatDef(e_Largura.Text,0);
        Altura := StrtoFloatDef(e_Altura.Text,0);
        NumeroPecas := StrtoFloatDef(E_Nr_Peca.Text,0);
      End;
      ItensNFL.salva;
      if (It_StateChange = 2) then
        Pc_InsereServicoRelacionado( It_Cd_Produto );
      //Baixa simples produto a produto
      if Lc_Estoque = 'S' then
      Begin
        //Baixa simples produto a produto
        with CtrlEstoque.Registro do
        Begin
          Codigo      := 0;
          Terminal    := Self.Terminal;
          Vinculo     := 'P';
          Ordem       := ItensNFL.Registro.CodigoPedido;
          Item        :=  ItensNFL.Registro.Codigo;
          Estoque     := Fm_ListaEstoques.Dblcb_Estoque.Keyvalue;
          operacao    := 'S';
          Produto     := It_Cd_Produto;
          Quantidade  := StrToFloatDef(E_Qt_Produto.Text,0);
          Data        := It_Dt_Operacao;
          Tipo        := 'Venda';
          UpdateAt    := Now;
        End;
        CtrlEstoque.Registra;
      end;

      if (Fc_Tb_Geral('L','DSP_G_CTRL_SEPARACAO','S') = 'S') then
      Begin
        Pc_SeparacaoMercadoria(ItensNFL.Registro.CodigoPedido,
                               ItensNFL.Registro.Codigo,
                               It_Cd_Produto,
                               It_Dt_Operacao,
                               StrToFloatdef(E_Qt_Produto.Text,1));
      end;
    end
    else
    Begin
      Pc_InserecomposicaoVenda( It_Cd_Produto );
    end;
    Result := True;
  end
  else
  Begin
    Result := FAlse;
  End;
end;

procedure TFr_Itens_Produto_Vda.ListaTributacao;
begin
  fm_ListaTributacao.Estado := SElf.Estado;
  fm_ListaTributacao.Sentido := 'S';
  fm_ListaTributacao.Listar;
end;

procedure TFr_Itens_Produto_Vda.LoadItems(Items: TSTQuery);
begin
  inherited;
  (cds_items.FieldByName('ITF_VL_UNIT') as TNumericField).DisplayFormat     := Gb_Casa_Dec_Venda;
  (cds_items.FieldByName('ITF_VL_DESC') as TNumericField).DisplayFormat     := '0.00######';
  (cds_items.FieldByName('ITF_VL_SUBTOTAL') as TNumericField).DisplayFormat := '0.00';
  (cds_items.FieldByName('ITF_AQ_COM') as TNumericField).DisplayFormat := '0.00######';
  (cds_items.FieldByName('ITF_VL_TOTAL') as TNumericField).DisplayFormat := '0.00';
  (cds_items.FieldByName('ITF_VL_IPI') as TNumericField).DisplayFormat := '0.00######';
end;

procedure TFr_Itens_Produto_Vda.Pc_DefineCasaDecimalLocal;
begin
  It_Casa_Decimal := Gb_Casa_Dec_Venda;
end;


procedure TFr_Itens_Produto_Vda.Sb_last_sales_itemsClick(Sender: TObject);
Begin
  if ValidaAberturaLastItemsSold then
    AberturaLastItemsSold;
end;

function TFr_Itens_Produto_Vda.SqlEspecifico: String;
begin
  if (Fc_Aq_Geral('L','PRODUTO','PRO_P_DISTG_PA_MP','S') = 'S') then
  Begin
    REsult := ' and (PRO_TIPO = ''P'') '
  end
  else
    REsult :=  ' and (PRO_TIPO <> ''S'') ';
end;

function TFr_Itens_Produto_Vda.ValidaAberturaLastItemsSold: Boolean;
begin
  Result := True;
end;

procedure TFr_Itens_Produto_Vda.AberturaLastItemsSold;
var
  Lc_form : TTasItemsSalesBefore;
begin
  Try
    Lc_form := TTasItemsSalesBefore.Create(Self);
    Lc_form.CodigoCliente := it_Cd_Empresa;
    Lc_form.CodigoProduto := It_Cd_Produto;
    Lc_form.ShowModal;
  Finally
    FreeAndNil( Lc_form );
  End;
end;

function TFr_Itens_Produto_Vda.validaGravacao: Boolean;
Var
  LcPRecoPadrao : String;
begin
  REsult := True;
  if not ValidacaoInicial then
  Begin
    result := False;
    exit;
  End;

  if not validaPreencheEstoque then
  Begin
    REsult := False;
    exit;
  End;
  if not validaPreencheCodigo then
  Begin
    REsult := False;
    exit;
  End;
  IF (Trim(E_Aq_Com.Text) = '') then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Comissão com conteúdo inválido.' + EOLN+
                   'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Aq_Com.CanFocus then E_Aq_Com.SetFocus;
    Result := False;
    exit;
  end;
  if not validaQuantidadePromocao then
  Begin
    Result := False;
    Exit;
  End;

  if (Fc_Tb_Geral('L','VDA_G_CTRL_EST_PEDIDO','N') = 'S') then
  Begin
    if (StrToFloatDef(E_Qtde_Disp.Caption,0) < StrToFloatDef(E_Qt_Produto.Text,0)) then
    Begin
      MensagemPadrao(' Mensagem ', ATENCAO + EOLN + EOLN +
                     ' Verifique que há uma configuração que impede ' +  EOLN+
                     ' a inclusão de itens sem saldo de estoque. ' +  EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result:=false;
      exit;
    end;
  end;
  if (Fc_Tb_Geral('L','VDA_G_PRECO_ACIMA','S') = 'S') then
  Begin
    LcPRecoPadrao := PrecoUnitarioCompara(Dblcb_Tabelas.KeyValue,StrtoIntDef(E_CodPro.Text,0));
    if (StrToFloatDef(E_Vl_Unitario.Text,0) >= StrToFloatDef(LcPRecoPadrao,0)) or GB_Liberado  then
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
  if Chbx_sem_Base_troca.Checked then
  Begin
    if StrToFloatDef(E_VL_Base_troca.Text,0) = 0 then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Valor Base de troca não pode ser igual a Zero'  + EOLN +
                     'Verifique e tente novamente' + EOLN,
                      ['OK'], [bEscape], mpAlerta);
      E_VL_Base_troca.SetFocus;
      Result := False;
    end;
  End;

end;

function TFr_Itens_Produto_Vda.ValidaInfoBaseTroca: Boolean;
begin
  REsult := True;
  if StrToIntDeF(E_CodPro.Text,0) = 0 then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Um produto precisa ser escolhido antes.'  + EOLN +
                   'Verifique e tente novamente' + EOLN,
                    ['OK'], [bEscape], mpAlerta);
    Result := False;
  End;
end;

procedure TFr_Itens_Produto_Vda.verificaBaseTroca;
Var
  LcPEdido : TControllerPedido;
begin
  try
    //Pega os dados do pedido
    LcPEdido := TControllerPedido.create(nil);
    LcPEdido.Registro.Codigo := ItensNFL.Registro.CodigoPedido;
    LcPEdido.getbyId;
    //Para pegar peso do produto
    ItensNFL.Produto.Registro.Codigo := ItensNFL.Registro.CodigoProduto;
    //Dados da base de troca
    ItensNFL.BaseTroca.Registro.Item  := ItensNFL.Registro.Codigo;
    ItensNFL.BaseTroca.Registro.Estabelecimento := LcPEdido.Registro.CodigoEstabelecimento;
    ItensNFL.BaseTroca.Registro.Ordem := LcPEdido.Registro.Codigo;
    if (not Chbx_sem_base_troca.Checked ) and (FValorBaseTroca > 0 ) then
    Begin
      ItensNFL.BaseTroca.Registro.Usuario     := LcPEdido.Registro.Usuario;
      ItensNFL.BaseTroca.Registro.Cliente     := LcPEdido.Registro.Empresa;
      ItensNFL.BaseTroca.Registro.Vendedor    := LcPEdido.Registro.Vendedor;
      ItensNFL.BaseTroca.Registro.Produto     := ItensNFL.Registro.CodigoProduto;
      ItensNFL.BaseTroca.Registro.DataSaida   := Date;
      ItensNFL.BaseTroca.Registro.Preco       := StrToFloatDef(E_VL_Base_troca.Text,0);
      ItensNFL.BaseTroca.Registro.PesoSaida   := ItensNFL.Produto.getPeso * ItensNFL.Registro.Quantidade ;
      ItensNFL.BaseTroca.Registro.Observacao  := '';
      ItensNFL.BaseTroca.save;
    End
    else
      ItensNFL.BaseTroca.delete;
  finally
    FreeAndNil(LcPEdido);
  end;
end;

end.
