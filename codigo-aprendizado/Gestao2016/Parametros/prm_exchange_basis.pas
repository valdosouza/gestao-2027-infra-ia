unit prm_exchange_basis;

interface

uses
      System.SysUtils, prm_dsk_base, tblExchangeBasis;

Type
  TPrmExchangeBase = class(TPrmDskBase)
  private
    FCodCliente: String;
    FDescCliente: String;
    FVendedor: Integer;
    FMarca: Integer;
    FCodProduto: String;
    FSubGRupo: Integer;
    FDescProduto: String;
    FGRupo: Integer;
    procedure setFCodCliente(const Value: String);
    procedure setFCodProduto(const Value: String);
    procedure setFDescCliente(const Value: String);
    procedure setFDescProduto(const Value: String);
    procedure setFGrupo(const Value: Integer);
    procedure setFMarca(const Value: Integer);
    procedure setFSubGrupo(const Value: Integer);
    procedure setFVendedor(const Value: Integer);



  public
    constructor Create;
    destructor Destroy;
    procedure Clear;Override;
    property CodProduto : String read FCodProduto write setFCodProduto;
    property DescProduto : String read FDescProduto write setFDescProduto;
    property GRupo : Integer read FGRupo write setFGrupo;
    property SubGRupo : Integer read FSubGRupo write setFSubGrupo;
    property Marca : Integer read FMarca write setFMarca;
    property CodCliente: String read FCodCliente write setFCodCliente;
    property DescCliente: String read FDescCliente write setFDescCliente;
    property Vendedor : Integer read FVendedor write setFVendedor;
  end;

implementation



procedure TPrmExchangeBase.Clear;
begin
  Inherited;
  FCodCliente := '';
  FDescCliente := '';
  FVendedor := 0;
  FMarca := 0;
  FCodProduto := '';
  FSubGRupo := 0;
  FDescProduto := '';
  FGRupo := 0;
end;

constructor TPrmExchangeBase.Create;
begin


end;

destructor TPrmExchangeBase.Destroy;
begin


end;

procedure TPrmExchangeBase.setFCodCliente(const Value: String);
begin
  FCodCliente := Value;
end;

procedure TPrmExchangeBase.setFCodProduto(const Value: String);
begin
  FCodProduto := Value;
end;

procedure TPrmExchangeBase.setFDescCliente(const Value: String);
begin
  FDescCliente := Value;
end;

procedure TPrmExchangeBase.setFDescProduto(const Value: String);
begin
  FDescProduto := Value;
end;

procedure TPrmExchangeBase.setFGrupo(const Value: Integer);
begin
  FGRupo := Value;
end;

procedure TPrmExchangeBase.setFMarca(const Value: Integer);
begin
  FMarca := Value;
end;

procedure TPrmExchangeBase.setFSubGrupo(const Value: Integer);
begin
  FSubGRupo := Value;
end;

procedure TPrmExchangeBase.setFVendedor(const Value: Integer);
begin
  FVendedor := Value;
end;

end.
