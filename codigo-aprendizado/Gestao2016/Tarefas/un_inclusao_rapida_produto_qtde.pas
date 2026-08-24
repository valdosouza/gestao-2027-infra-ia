unit un_inclusao_rapida_produto_qtde;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, QEdit_Setes, Vcl.Buttons, ControllerItensNFL, ControllerCtrlEstoque, ControllerItensCotacao;

type
  TFr_InclusaoRapidaProdutoQtde = class(TFr_Base)
    Pnl_corpo: TPanel;
    Label37: TLabel;
    Label1: TLabel;
    E_Descricao: TEdit;
    Sb_Confirma: TButton;
    Sb_Cancela: TButton;
    E_Codigo: TEdit;
    Label25: TLabel;
    Label28: TLabel;
    Label35: TLabel;
    E_Subtotal: TPanel;
    E_Qtde: TEdit_Setes;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    E_Vl_Unitario: TEdit_Setes;
    pnl_rodape: TPanel;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure E_QtdeExit(Sender: TObject);
    procedure E_QtdeEnter(Sender: TObject);
    procedure Sb_ConfirmaClick(Sender: TObject);
    procedure Sb_CancelaClick(Sender: TObject);
    procedure E_Vl_UnitarioEnter(Sender: TObject);
    procedure E_Vl_UnitarioExit(Sender: TObject);
  private
    { Private declarations }
    Procedure Totalizador;
  protected
    procedure IniciaVariaveis;Override;
    function validagravaVenda:Boolean;
    function validagravaCotacao:Boolean;
    procedure grava;
    procedure gravaVenda;
    procedure gravaCotacao;
  public
    { Public declarations }
    Venda : TControllerItensNFL;
    Cotacao : TControllerItensCotacao;
    It_Pedido_Vda : Boolean;
    It_Cotacao_Vda : Boolean;
    CtrlEstoque : TControllerCtrlEstoque;
    Terminal : Integer;
  end;

var
  Fr_InclusaoRapidaProdutoQtde: TFr_InclusaoRapidaProdutoQtde;

implementation

{$R *.dfm}

uses     UN_Principal, env, RN_Permissao, Un_Msg, UN_Sistema, RN_Estoque;

procedure TFr_InclusaoRapidaProdutoQtde.E_QtdeEnter(Sender: TObject);
begin
  inherited;
  E_Qtde.SelectAll;
end;

procedure TFr_InclusaoRapidaProdutoQtde.E_QtdeExit(Sender: TObject);
begin
  inherited;
  Totalizador
end;

procedure TFr_InclusaoRapidaProdutoQtde.E_Vl_UnitarioEnter(Sender: TObject);
begin
  TEdit_Setes(Sender).SelectAll;
end;

procedure TFr_InclusaoRapidaProdutoQtde.E_Vl_UnitarioExit(Sender: TObject);
begin
  Totalizador;
end;

procedure TFr_InclusaoRapidaProdutoQtde.FormCreate(Sender: TObject);
begin
  inherited;
  Venda   := TControllerItensNFL.Create(Self);
  Cotacao := TControllerItensCotacao.Create(Self);
  CtrlEstoque := TControllerCtrlEstoque.Create(Self);
  It_Pedido_Vda := False;
  It_Cotacao_Vda := False;
end;

procedure TFr_InclusaoRapidaProdutoQtde.grava;
Begin
  if It_Pedido_Vda then
    if validagravaVenda then
      gravaVenda;

  if It_Cotacao_Vda then
    if validagravaCotacao then
      gravaCotacao;
end;

procedure TFr_InclusaoRapidaProdutoQtde.gravaCotacao;
begin
  with Cotacao.Registro do
  Begin
    Codigo        := 0;
    Quantidade    := StrToFloatDef(E_Qtde.Text,1);
    ValorUnitario := StrToFloatDef(E_Vl_Unitario.Text,1);
  End;
  Cotacao.insert;

end;

procedure TFr_InclusaoRapidaProdutoQtde.gravaVenda;
begin
  with Venda.Registro do
  Begin
    Codigo        := 0;
    Quantidade    := StrToFloatDef(E_Qtde.Text,1);
    ValorUnitario := StrToFloatDef(E_Vl_Unitario.Text,1);
  End;
  VEnda.insere;
  with CtrlEstoque.Registro do
  Begin
    Codigo      := 0;
    Terminal    := Self.Terminal;
    Vinculo     := 'P';
    Ordem       := VEnda.Registro.CodigoPedido;
    Item        := VEnda.Registro.Codigo;
    Estoque     := VEnda.Registro.CodigoEstoque;
    operacao    := 'S';
    Produto     := VEnda.Registro.CodigoProduto;
    Quantidade  := VEnda.Registro.Quantidade;
    Data        := DAte;
    Tipo        := 'Venda';
    UpdateAt    := Now;
  End;
  CtrlEstoque.Registra;

end;

procedure TFr_InclusaoRapidaProdutoQtde.IniciaVariaveis;
begin
  inherited;
  E_Codigo.Text := Venda.Registro.CodigoProduto.ToString;
  E_VL_Unitario.Text := FloatToStrF( Venda.Registro.ValorUnitario,fffixed,10,2);
  Totalizador;
end;

procedure TFr_InclusaoRapidaProdutoQtde.Sb_CancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFr_InclusaoRapidaProdutoQtde.Sb_ConfirmaClick(Sender: TObject);
begin
  grava;
  Close;
end;

procedure TFr_InclusaoRapidaProdutoQtde.SpeedButton1Click(Sender: TObject);
Var
  LcQtde : Real;
begin
  LcQtde := StrToFloatDef(E_Qtde.Text,1);
  LcQtde := LcQtde + 1;
  E_Qtde.Text := FloatToStr(LcQtde);
  Totalizador;
end;

procedure TFr_InclusaoRapidaProdutoQtde.SpeedButton2Click(Sender: TObject);
Var
  LcQtde : Real;
begin
  LcQtde := StrToFloatDef(E_Qtde.Text,1);
  LcQtde := LcQtde - 1;
  if LcQtde = 0 then LcQtde := 1;
  E_Qtde.Text := FloatToStr(LcQtde);
  Totalizador;
end;

procedure TFr_InclusaoRapidaProdutoQtde.Totalizador;
Var
  Lc_Qtde : Real;
  Lc_Valor : Real;
  Lc_Total : Real;
Begin
  Lc_Qtde := StrToFloatDef(E_Qtde.Text,0);
  Lc_Valor := StrToFloatDef(E_Vl_Unitario.Text,0);
  Lc_Total := Lc_Qtde * Lc_Valor;
  E_Subtotal.Caption := FloatToStrf(Lc_Total,ffFixed,10,2);

end;

function TFr_InclusaoRapidaProdutoQtde.validagravaCotacao: Boolean;
Var
  LcPRecoPadrao : String;
begin
  REsult := True;
  if (Fc_Tb_Geral('L','VDA_G_PRECO_ACIMA','S') = 'S') then
  Begin
    Cotacao.Produto.TabelaPreco.Preco.Registro.CodigoTabela := Venda.Registro.CodigoTabela;
    Cotacao.Produto.TabelaPreco.Preco.Registro.CodigoProduto := Venda.Registro.CodigoProduto;
    Cotacao.Produto.TabelaPreco.Preco.getByTabelaProduto;

    LcPRecoPadrao := FormatFloat('0.00####', Cotacao.Produto.TabelaPreco.Preco.Registro.Valor);

    if (StrToFloatDef(E_Vl_Unitario.Text,0) >=   StrToFloatDef(LcPRecoPadrao,0) ) or GB_Liberado  then
    Begin
      if (Gb_Nivel = 0)  then Gb_Liberado := False;
    end
    else
    begin

      if not (Fc_VerificaPermissao('Fr_Cotacao','Orçamento de Venda','AUTORIZAR', GB_Cd_Usuario,'N')) then
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

end;

function TFr_InclusaoRapidaProdutoQtde.validagravaVenda: Boolean;
Var
  LcPRecoPadrao : String;
begin
  REsult := True;
  if (Fc_Tb_Geral('L','VDA_G_PRECO_ACIMA','S') = 'S') then
  Begin
    Venda.Produto.TabelaPreco.Preco.Registro.CodigoTabela := Venda.Registro.CodigoTabela;
    Venda.Produto.TabelaPreco.Preco.Registro.CodigoProduto := Venda.Registro.CodigoProduto;
    Venda.Produto.TabelaPreco.Preco.getByTabelaProduto;

    LcPRecoPadrao := FormatFloat('0.00####', Venda.Produto.TabelaPreco.Preco.Registro.Valor);

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

end;

end.
