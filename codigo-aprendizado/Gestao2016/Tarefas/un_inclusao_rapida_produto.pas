unit un_inclusao_rapida_produto;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, Data.DB, STQuery, ControllerTabelaPreco, ControllerItensNFL, tblItensnfl, RN_Estoque, ControllerCtrlEstoque;

type
  TFr_InclusaoRapidaProduto = class(TFr_Base)
    Pnl_Prod_Sem_Registro: TPanel;
    Label28: TLabel;
    Label37: TLabel;
    E_Avl_Subtotal: TPanel;
    E_Avl_Descricao: TEdit;
    Sb_Confirma: TButton;
    Sb_Cancela: TButton;
    Label1: TLabel;
    Qr_PesqProduto: TSTQuery;
    E_BuscaCodigo: TEdit;
    procedure E_BuscaCodigoExit(Sender: TObject);
    procedure Sb_ConfirmaClick(Sender: TObject);
    procedure Sb_CancelaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    BalBarraCodigoProduto :Integer;
    BalBarraPrecoPeso : Integer;
    It_cd_Tabela: Integer;
    ObjItensProduto : TItensNFL;
    function Fc_LancaItem:Boolean;
    procedure Pc_PreencheProdutoCodigoReduzido(Pc_Cd_Produto:String);
    function FC_BuscarProduto(Pc_Codigo,Fc_Campo: string):Integer;
    procedure Pc_PreencheProdutoCodigoBarrasBalanca(Pc_Cd_Barras:String);
    procedure Pc_PreencheProdutoCodigoBarras(Pc_Cd_Barras:String);
    function Fc_ValidaPreencheProduto(Pc_Vl_Venda:Real):boolean;
    procedure Pc_PreencheItensVenda(Pc_Cd_Produto:String;
                                    Pc_Cd_Fabrica:String;
                                    Pc_Descricao:String;
                                    Pc_Qtde:Real;
                                    Pc_Vl_Venda:Real;
                                    Pc_Abreviatura:String;
                                    Pc_VL_Custo:Real;
                                    Pc_NCM:String;
                                    Pc_Origem:String;
                                    Pc_Vl_Original:Real);
    procedure ProdutoDifDeUm(Nr_Registro:Integer);
    procedure Pc_MostraBusca;
  protected
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
    procedure CriarVariaveis;Override;
  public
    { Public declarations }
    It_Usa_Cd_Fabrica : Boolean;
    It_NFCe : Boolean;
    It_Nr_Item: Integer;
    It_Cd_Pedido : Integer;
    CtrlEstoque : TControllerCtrlEstoque;
    Terminal : Integer;
    function validaGravacao:Boolean;
    procedure grava;
  end;

var
  Fr_InclusaoRapidaProduto: TFr_InclusaoRapidaProduto;

implementation

uses     AnsiStrings, UN_Sistema, Un_Msg, Un_Pesq_Produto, env;
{$R *.dfm}

procedure TFr_InclusaoRapidaProduto.CriarVariaveis;
begin
  inherited;
  ObjItensProduto := TItensNFL.Create;
end;

procedure TFr_InclusaoRapidaProduto.E_BuscaCodigoExit(Sender: TObject);
begin
  Fc_LancaItem
end;

function TFr_InclusaoRapidaProduto.FC_BuscarProduto(Pc_Codigo,
  Fc_Campo: string): Integer;
var
  Lc_Sqltxt: string;
begin
  Screen.Cursor := crHourGlass;
  Lc_Sqltxt := 'SELECT DISTINCT '+
               'PRO_CODIGO, '+
               'PRO_CODIGOFAB, '+
               'PRO_ORIGEM, '+
               'PRO_CODIGOBAR, '+
               'PRO_CODIGOFOR, '+
               'PRO_CODIGONCM, '+
               'PRO_DESCRICAO, '+
               'PRO_VL_CUSTO, '+
               'MED_ABREVIATURA, '+
               'PRC_VL_VDA, '+
               'PRC_AQ_COM, '+
               'PRO_CAMPANHA '+
               'FROM TB_PRODUTO tb_produto '+
               '  INNER JOIN TB_PRECO tb_preco '+
               '  ON (tb_preco.PRC_CODPRO = tb_produto.PRO_CODIGO) '+
               '  INNER JOIN tb_medida tb_medida '+
               '  ON (tb_medida.med_codigo = tb_produto.pro_codmed) '+
               'WHERE (PRO_ATIVO = ''S'') AND (PRC_CODTPR =:PRC_CODTPR) '+
               ' AND (PRO_TIPO <> ''S'') ';

  Lc_Sqltxt := Lc_Sqltxt + ' AND (' + Fc_Campo + ' =:' + Fc_Campo + ') ';

  Qr_PesqProduto.Close;
  Qr_PesqProduto.SQL.Clear;
  Qr_PesqProduto.SQL.Add(Lc_Sqltxt);
  Qr_PesqProduto.ParamByName(FC_CAMPO).AsString := Pc_Codigo;
  Qr_PesqProduto.ParamByName('PRC_CODTPR').AsInteger := It_Cd_Tabela;
  Qr_PesqProduto.Open;
  Qr_PesqProduto.FetchAll;
  Qr_PesqProduto.First;
  if Qr_PesqProduto.RecordCount > 0 then
  Begin
    if Qr_PesqProduto.FieldByName('PRO_CAMPANHA').AsString = 'S' then
    Begin
      Qr_PesqProduto.Close;
      Qr_PesqProduto.ParamByName(FC_CAMPO).AsString := Pc_Codigo;
      Qr_PesqProduto.ParamByName('PRC_CODTPR').AsInteger := 2;
      Qr_PesqProduto.Open;
      Qr_PesqProduto.FetchAll;
      Qr_PesqProduto.First;
    end;
    Result := Qr_PesqProduto.RecordCount;
  end
  else
  Begin
    Qr_PesqProduto.Close;
    Result := 0;
  end;
  Screen.Cursor := crDefault;

end;

function TFr_InclusaoRapidaProduto.Fc_LancaItem: Boolean;
begin
  Result := False;
  if Length(Trim(E_BuscaCodigo.Text)) > 0 then
  Begin
    Result := True;
    //Busca Pelo Codigo Reduzido
    if Length(Trim(E_BuscaCodigo.Text)) <= 6 then
    Begin
      Pc_PreencheProdutoCodigoReduzido(E_BuscaCodigo.Text);
    end
    else
    Begin
      //VErifica se o codigo de barras é de balança
      if (Copy(E_BuscaCodigo.Text,1,1) = '2') and (Length(E_BuscaCodigo.Text)< 14) then
      Begin
        Pc_PreencheProdutoCodigoBarrasBalanca(E_BuscaCodigo.Text);
      end
      else
      Begin
        Pc_PreencheProdutoCodigoBarras(E_BuscaCodigo.Text);
      end;
    end;
  end;
end;

function TFr_InclusaoRapidaProduto.Fc_ValidaPreencheProduto(
  Pc_Vl_Venda: Real): boolean;
Var
  Lc_Preco:String;
Begin
  Result := true;
  If It_NFCe then
  Begin
    if (trim(Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString) = '') or
       (Length(Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString) < 8) then
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Código de NCM não preenchido ou incompleto.'+EOLN +
                     'Verifique antes de continuar.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
      Result := false;
      exit;
    end;
  end;

  IF (Pc_Vl_Venda =0)  then
  Begin
      MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                    'Este produto está com o Preço Zerado.' + EOLN +
                    'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpAlerta);
      Result := false;
      exit;
  end;
  if Trim(Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString)='' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O produto está com problemas em sua descrição.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;
end;

procedure TFr_InclusaoRapidaProduto.FormataTela;
begin
  E_BuscaCodigo.selectAll;
end;

procedure TFr_InclusaoRapidaProduto.FormCreate(Sender: TObject);
begin
  inherited;
  CtrlEstoque := TControllerCtrlEstoque.Create(Self);
end;

procedure TFr_InclusaoRapidaProduto.grava;
Var
  Lc_Itens : TControllerItensNFL;
Begin
  try
    Lc_Itens := TControllerItensNFL.Create(nil);
    Lc_Itens.Registro := ObjItensProduto;
    Lc_Itens.salva;
    with CtrlEstoque.Registro do
    Begin
      Codigo      := 0;
      Terminal    := Self.Terminal;
      Vinculo     := 'P';
      Ordem       := It_Cd_Pedido;
      Item        := Lc_Itens.Registro.Codigo;
      Estoque     := Lc_Itens.Registro.CodigoEstoque;
      operacao    := 'S';
      Produto     := Lc_Itens.Registro.CodigoProduto;
      Quantidade  := Lc_Itens.Registro.Quantidade;
      Data        := DAte;
      Tipo        := 'Venda';
      UpdateAt    := Now;
    End;
    CtrlEstoque.Registra;
  finally
    FreeAndNil(Lc_Itens);
    Self.Close;
  end;
end;

procedure TFr_InclusaoRapidaProduto.IniciaVariaveis;
Var
  LcTabela : TControllerTabelaPreco;
begin
  Try
    It_Usa_Cd_Fabrica := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_PESQ_COD_FAB', 'N') = 'S');
    It_NFCe := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_VDA_NFCE', 'N') = 'S');
    LcTabela := TControllerTabelaPreco.create(nil);
    It_Cd_Tabela := LcTabela.getPrincipal;
  Finally
    FReeAndNil(LcTabela);
  End;
end;

procedure TFr_InclusaoRapidaProduto.Pc_MostraBusca;
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  Try
    Lc_Form := TFr_Pesq_Produto.Create(nil);
    Lc_Form.it_Modalidade_preco := 'A';
    Lc_Form.Pc_Tabelas_Disponiveis;
    if (E_BuscaCodigo.Text <> '') then
      Lc_Form.E_BuscaCodigo.Text :=  E_BuscaCodigo.Text
    else
      Lc_Form.E_BuscaCodigo.Text := '';
    Lc_Form.ShowModal;
  Finally
    //Depois que Fecha o Relatorio
    if Lc_Form.It_Visualizar then
    Begin
      IF (It_Usa_Cd_Fabrica)then
        E_BuscaCodigo.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGOFAB').AsString
      else
        E_BuscaCodigo.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
      //if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus; - Comentado em 20/12/2016 - 23:55
      Fc_LancaItem;
    end;
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_InclusaoRapidaProduto.Pc_PreencheItensVenda(Pc_Cd_Produto,
  Pc_Cd_Fabrica, Pc_Descricao: String; Pc_Qtde, Pc_Vl_Venda: Real;
  Pc_Abreviatura: String; Pc_VL_Custo: Real; Pc_NCM, Pc_Origem: String;
  Pc_Vl_Original: Real);
begin
//  Aqui deve fazer a inclusão do produto no pedido
  E_Avl_Descricao.Text := Pc_Descricao;
  E_Avl_Descricao.Tag   :=  StrToIntDef(Pc_Cd_Produto,0);
  E_Avl_Subtotal.Caption := FloatToStrf(Pc_Vl_Original,ffFixed,10,2);

  with ObjItensProduto do
  Begin
    Codigo        := Fc_Generator('GN_ITENS_NFL','','ITF_CODIGO');
    CodigoPedido  := It_Cd_Pedido;
    CodigoProduto := StrToIntDef(Pc_Cd_Produto,0);
    Quantidade    := 1;
    ValorCusto    := Pc_VL_Custo;
    ValorUnitario := Pc_Vl_Venda;
    AliqDesconto  := 0;
    ValorDesconto := 0;
    AliqComissao  := 0;
    Operacao      := 'V';
    Estoque       := 'S';
    Despachar     := 'S';
    AliqIPI       := 0;
    AliqICMS      := 0;
    CodigoEstoque := Gb_Estoque;
    CodigoTabela  := It_cd_Tabela;
    Largura       := 0;
    Altura        := 0;
    NumeroPecas   := 0;
  End;

end;

procedure TFr_InclusaoRapidaProduto.Pc_PreencheProdutoCodigoBarras(
  Pc_Cd_Barras: String);
Var
  Lc_Nr_Registro:Integer;
Begin
  Lc_Nr_Registro := Fc_BuscarProduto(E_BuscaCodigo.Text,'PRO_CODIGOBAR');
  if (Lc_Nr_Registro = 1) then
  begin
    if (Fc_ValidaPreencheProduto(Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency)) then
    Begin
      Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                            Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                            Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString,
                            1,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                            Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString,
                            Qr_PesqProduto.FieldByName('PRO_VL_CUSTO').AsCurrency,
                            Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                            Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency);
    end;
  end
  else
  Begin
    ProdutoDifDeUm(Lc_Nr_Registro);
  end;
end;

procedure TFr_InclusaoRapidaProduto.Pc_PreencheProdutoCodigoBarrasBalanca(
  Pc_Cd_Barras: String);
Var
  Lc_Cd_produto,Lc_Total : String;
  Lc_Peso : Real;
  Lc_Nr_Registro:Integer;

Begin
  Lc_Cd_produto := Copy(E_BuscaCodigo.Text,2,BalBarraCodigoProduto);
  Lc_Cd_produto := IntToStr( StrToIntDef(Lc_Cd_produto,0) );
  IF (It_Usa_Cd_Fabrica)then
    Lc_Nr_Registro := Fc_BuscarProduto(Lc_Cd_produto,'PRO_CODIGOFAB')
  else
    Lc_Nr_Registro := Fc_BuscarProduto(Lc_Cd_produto,'PRO_CODIGO');
  if (Lc_Nr_Registro = 1) then
  begin
    //SE O TIPO DE LEITURA é POR PESO entãO O PRODUTO PRECISA TER PreçO PARA CALCULAR
    if (Fc_ValidaPreencheProduto(Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency)) then
    Begin
      Lc_Total := Copy(E_BuscaCodigo.Text,BalBarraCodigoProduto + 2 ,BalBarraPrecoPeso );
      //Colocando a Virgula
      Lc_Total := Copy(Lc_Total,1,BalBarraPrecoPeso-2)+','+Copy(Lc_Total,BalBarraPrecoPeso-1,2);
      Lc_Peso := StrToFloatDEf(Lc_Total,1) / Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency;
      Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                            Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                            Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString,
                            Lc_Peso,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                            Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString,
                            Qr_PesqProduto.FieldByName('PRO_VL_CUSTO').AsCurrency,
                            Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                            Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency);
    end;
  end
  else
  Begin
    ProdutoDifDeUm(Lc_Nr_Registro);
  end;
end;

procedure TFr_InclusaoRapidaProduto.Pc_PreencheProdutoCodigoReduzido(
  Pc_Cd_Produto: String);
Var
  Lc_Nr_Registro:Integer;
Begin
  IF It_Usa_Cd_Fabrica then
    Lc_Nr_Registro := Fc_BuscarProduto(E_BuscaCodigo.Text,'PRO_CODIGOFAB')
  else
    Lc_Nr_Registro := Fc_BuscarProduto(E_BuscaCodigo.Text,'PRO_CODIGO');

  if (Lc_Nr_Registro = 1) then
  begin
    if (Fc_ValidaPreencheProduto(Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency)) then
    Begin
      Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                            Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                            Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString,
                            1,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                            Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString,
                            Qr_PesqProduto.FieldByName('PRO_VL_CUSTO').AsCurrency,
                            Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                            Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency);
    end;
  end
  else
  Begin
    ProdutoDifDeUm(Lc_Nr_Registro);
  end;
end;

procedure TFr_InclusaoRapidaProduto.ProdutoDifDeUm(Nr_Registro: Integer);
begin
  if (Nr_Registro > 1) then
  begin
    if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
    Pc_MostraBusca;
  end
  else
  Begin
    if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
    ShowMessage('Produto Não encontrado');
  end;
end;

procedure TFr_InclusaoRapidaProduto.Sb_CancelaClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TFr_InclusaoRapidaProduto.Sb_ConfirmaClick(Sender: TObject);
begin
  if validaGravacao then
    grava;
end;

function TFr_InclusaoRapidaProduto.validaGravacao: Boolean;
begin
  Result := True;
  IF (Trim(E_BuscaCodigo.Text) = '') then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Códcódcódcódigo do produto é Obrigatário.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;
  IF (Trim(E_Avl_Descricao.Text) = '') then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo descrição do produto é Obrigatário.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;
  IF (StrToFloatDef(E_Avl_Subtotal.caption,0) = 0 ) then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Valor unitário está zero.' + EOLN+
                   'Não é possível continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;

end;

end.
