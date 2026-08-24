unit list_spl_produto;

interface
type
  TListSplProduto = class
  private
    FDescricao: String;
    FCodigo: Integer;
    FEstoque: Real;
    FCodigoFabrica: String;
    FEmbalagem: String;
    procedure setFCodigo(const Value: Integer);
    procedure setFCodigoFabrica(const Value: String);
    procedure setFDescricao(const Value: String);
    procedure setFEmbalagem(const Value: String);
    procedure setFEstoque(const Value: Real);
  public
    property Codigo : Integer read FCodigo write setFCodigo;
    property CodigoFabrica : String read FCodigoFabrica write setFCodigoFabrica;
    property Descricao : String Read FDescricao write setFDescricao;
    property Embalagem : String read FEmbalagem write setFEmbalagem;
    property Estoque : Real read FEstoque write setFEstoque;
  end;

implementation

{ TListSplProduto }

procedure TListSplProduto.setFCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TListSplProduto.setFCodigoFabrica(const Value: String);
begin
  FCodigoFabrica := Value;
end;

procedure TListSplProduto.setFDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TListSplProduto.setFEmbalagem(const Value: String);
begin
  FEmbalagem := Value;
end;

procedure TListSplProduto.setFEstoque(const Value: Real);
begin
  FEstoque := Value;
end;

end.
