unit tas_lanca_item_produto;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, ControllerProduto, Un_Pesq_Produto, Un_Msg, Data.DB, Datasnap.DBClient;

type
  TTasLancaItemProdutos = class(TFr_Base)
    Panel1: TPanel;
    Label1: TLabel;
    Label13: TLabel;
    SB_Gravar: TSpeedButton;
    Sb_Pesquisar: TSpeedButton;
    E_Cd_Produto: TEdit;
    E_Produto: TEdit;
    Panel2: TPanel;
    Sb_Sair_0: TSpeedButton;
    procedure E_Cd_ProdutoExit(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure Sb_PesquisarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure E_ProdutoExit(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;

    procedure getByCodigo;
    procedure getByDescricao;
    procedure MostraBusca;Virtual;

    procedure ShowData;Virtual;
    procedure ShowNoData;Virtual;

    function ValidaProduto:Boolean;Virtual;
    function ValidaGravacao:Boolean;Virtual;
    procedure Gravar;Virtual;

    procedure execShorCutKeyF5;Override;
    procedure execShorCutKeyF7;Override;
    procedure execShorCutEsc;Override;


  public
    { Public declarations }
    Produto : TControllerProduto;
    TipoItem : String;
    Confirma : Boolean;
  end;

var
  TasLancaItemProdutos: TTasLancaItemProdutos;

implementation

{$R *.dfm}

uses     env;

{ TTasLancaItemProdutos }

procedure TTasLancaItemProdutos.getByCodigo;
Var
  Lc_Cd_Produto : Integer;
begin
  Lc_Cd_Produto := StrToIntDef(E_Cd_Produto.Text,0);
  if Lc_Cd_Produto > 0 then
  BEgin
    Produto.Registro.Codigo := Lc_Cd_Produto;
    Produto.getById;
    if Produto.exist then
      E_Produto.Text := Produto.Registro.DEscricao;
  End;

end;

procedure TTasLancaItemProdutos.getByDescricao;
begin
  if not Produto.exist then
  Begin
    if (Produto.getByDescricao(E_Produto.Text) = 1) then
    Begin
      E_Cd_Produto.Text := Produto.Registro.Codigo.ToString;
      E_Produto.Text := Produto.Registro.DEscricao;
    End
    else
    Begin
      MostraBusca;
    End;
  End;
end;

procedure TTasLancaItemProdutos.Gravar;
begin

end;

procedure TTasLancaItemProdutos.CriarVariaveis;
begin
  inherited;
  Produto := TControllerProduto.Create(Self);
  Confirma := False;
end;

procedure TTasLancaItemProdutos.execShorCutEsc;
begin
  Self.Close;

end;

procedure TTasLancaItemProdutos.execShorCutKeyF5;
begin
  SB_GravarClick(Self);
end;

procedure TTasLancaItemProdutos.execShorCutKeyF7;
begin
  Sb_PesquisarClick(self);
end;

procedure TTasLancaItemProdutos.E_Cd_ProdutoExit(Sender: TObject);
BEGIN
  if not E_Cd_Produto.ReadOnly then
    getByCodigo;
end;

procedure TTasLancaItemProdutos.E_ProdutoExit(Sender: TObject);
begin
  if not E_Produto.ReadOnly then
    getByDescricao;
end;

procedure TTasLancaItemProdutos.FormataTela;
begin
  inherited;
  if (CodigoRegistro > 0) then
  Begin
    E_Cd_Produto.ReadOnly := True;
    E_Produto.ReadOnly := True;
  End
  else
  Begin
    E_Cd_Produto.ReadOnly := False;
    E_Produto.ReadOnly := False;
    E_Cd_Produto.SetFocus;
  End;

end;

procedure TTasLancaItemProdutos.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(Sb_Gravar,'GRAVAR');
  CarregaImagemBotao(Sb_Pesquisar,'BUSCAR');
  CarregaImagemBotao(Sb_Sair_0,'SAIR');
end;

procedure TTasLancaItemProdutos.IniciaVariaveis;
begin
  if ( CodigoRegistro > 0 ) then
    ShowData
  else
    ShowNoData;
end;

procedure TTasLancaItemProdutos.MostraBusca;
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  try
    Lc_Form := TFr_Pesq_Produto.Create(Self);
    Lc_Form.it_Modalidade_preco := 'A';
    Lc_Form.Pc_Tabelas_Disponiveis;
    Lc_Form.E_BuscaCodigo.Clear;
    Lc_Form.E_BuscaDescricao.Text := E_Produto.Text;
    Lc_Form.It_Tipo_Especifico := TipoItem;
    Lc_Form.ShowModal;
    if Lc_Form.It_Visualizar then
    Begin
      E_Cd_Produto.Text:=  Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
      E_Produto.Text:= Lc_Form.Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString;
    end;
  Finally
    FreeAndNil(Lc_Form) ;
  end;
end;

procedure TTasLancaItemProdutos.SB_GravarClick(Sender: TObject);
begin
  if ValidaGravacao then
    Gravar;

end;

procedure TTasLancaItemProdutos.Sb_PesquisarClick(Sender: TObject);
begin
  MostraBusca;
end;

procedure TTasLancaItemProdutos.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TTasLancaItemProdutos.ShowData;
begin

end;

procedure TTasLancaItemProdutos.ShowNoData;
begin

end;

function TTasLancaItemProdutos.ValidaGravacao: Boolean;
begin
  REsult := True;
end;

function TTasLancaItemProdutos.ValidaProduto: Boolean;
begin
  REsult := True;
  if StrToIntDef(E_Cd_Produto.Text,0) = 0 then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Favor Preencher o campo código de produto.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := True;
    exit;
  End;

  if Trim(E_Produto.Text) = '' then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Favor Preencher o descrição do produto.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := True;
    exit;
  End;

end;

end.
