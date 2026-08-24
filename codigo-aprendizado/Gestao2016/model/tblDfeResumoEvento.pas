unit tblDfeResumoEvento;

interface

Uses
      SysUtils, Classes, GenericEntity, CAtribEntity;

type
  [TableName('DFE_RESUMO_EVENTO')]
  TDfeResumoEvento = class(TGenericEntity)
  private
    FNSU: String;
    FCorGao: Integer;
    FTpAmb: Integer;
    FDhEvento: TDateTime;
    FTpEvento: Integer;
    FNSeqEvento: Integer;
    FVerEvento: String;
    FXEvento: String;

    procedure SetNSU(const Value: String);
    procedure SetCorGao(const Value: Integer);
    procedure SetTpAmb(const Value: Integer);
    procedure SetDhEvento(const Value: TDateTime);
    procedure SetTpEvento(const Value: Integer);
    procedure SetNSeqEvento(const Value: Integer);
    procedure SetVerEvento(const Value: String);
    procedure SetXEvento(const Value: String);

  public
    [KeyField('NSU')]
    [FieldName('NSU')]
    property NSU: String read FNSU write SetNSU;

    [FieldName('CORGAO')]
    property CorGao: Integer read FCorGao write SetCorGao;

    [FieldName('TPAMB')]
    property TpAmb: Integer read FTpAmb write SetTpAmb;

    [FieldName('DHEVENTO')]
    property DhEvento: TDateTime read FDhEvento write SetDhEvento;

    [FieldName('TPEVENTO')]
    property TpEvento: Integer read FTpEvento write SetTpEvento;

    [FieldName('NSEQEVENTO')]
    property NSeqEvento: Integer read FNSeqEvento write SetNSeqEvento;

    [FieldName('VEREVENTO')]
    property VerEvento: String read FVerEvento write SetVerEvento;

    [FieldName('XEVENTO')]
    property XEvento: String read FXEvento write SetXEvento;
  end;

implementation

{ TDfeResumoEvento }

procedure TDfeResumoEvento.SetCorGao(const Value: Integer);
begin
  FCorGao := Value;
end;

procedure TDfeResumoEvento.SetDhEvento(const Value: TDateTime);
begin
  FDhEvento := Value;
end;

procedure TDfeResumoEvento.SetNSU(const Value: String);
begin
  FNSU := Value;
end;

procedure TDfeResumoEvento.SetNSeqEvento(const Value: Integer);
begin
  FNSeqEvento := Value;
end;

procedure TDfeResumoEvento.SetTpAmb(const Value: Integer);
begin
  FTpAmb := Value;
end;

procedure TDfeResumoEvento.SetTpEvento(const Value: Integer);
begin
  FTpEvento := Value;
end;

procedure TDfeResumoEvento.SetVerEvento(const Value: String);
begin
  FVerEvento := Value;
end;

procedure TDfeResumoEvento.SetXEvento(const Value: String);
begin
  FXEvento := Value;
end;

end.

