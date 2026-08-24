unit prm_pay_back;

interface

uses
      System.SysUtils, prm_dsk_base, tblPayBack;

Type
  TPrmPayBack = class(TPrmDskBase)
  private
    FPayBack: TPayBAck;
    FDias: Integer;
    FValorMinimo: Real;
    procedure setFPayBack(const Value: TPayBAck);
    procedure setFDias(const Value: Integer);
    procedure setFValorMinimo(const Value: Real);

  public
    constructor Create;
    destructor Destroy;

    property PayBack : TPayBAck read FPayBack write setFPayBack;
    property Dias : Integer read FDias write setFDias;
    property ValorMinimo : Real read FValorMinimo write setFValorMinimo;
  end;

implementation



constructor TPrmPayBack.Create;
begin
  inherited;
  FPayBack := TPayBack.Create;
end;

destructor TPrmPayBack.Destroy;
begin
  FreeAndNil(FPayBack);
  inherited;
end;

procedure TPrmPayBack.setFDias(const Value: Integer);
begin
  FDias := Value;
end;

procedure TPrmPayBack.setFPayBack(const Value: TPayBAck);
begin
  FPayBack := Value;
  Estabelecimento := FPayBack.Estabelecimento;
end;

procedure TPrmPayBack.setFValorMinimo(const Value: Real);
begin
  FValorMinimo := Value;
end;

end.
