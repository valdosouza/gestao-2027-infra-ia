unit tblDfeProtocolo;

interface

Uses
      SysUtils, Classes, GenericEntity, CAtribEntity;

type
  [TableName('DFE_PROTOCOLO')]
  TDfeProtocolo = class(TGenericEntity)
  private
    FNSU: String;
    FIdProtocolo: String;
    FDhRecbto: TDateTime;
    FNProt: String;
    FDigVal: String;

    procedure SetNSU(const Value: String);
    procedure SetIdProtocolo(const Value: String);
    procedure SetDhRecbto(const Value: TDateTime);
    procedure SetNProt(const Value: String);
    procedure SetDigVal(const Value: String);

  public
    [KeyField('NSU')]
    [FieldName('NSU')]
    property NSU: String read FNSU write SetNSU;

    [KeyField('ID_PROTOCOLO')]
    [FieldName('ID_PROTOCOLO')]
    property IdProtocolo: String read FIdProtocolo write SetIdProtocolo;

    [FieldName('DH_RECBTO')]
    property DhRecbto: TDateTime read FDhRecbto write SetDhRecbto;

    [FieldName('NPROT')]
    property NProt: String read FNProt write SetNProt;

    [FieldName('DIGVAL')]
    property DigVal: String read FDigVal write SetDigVal;
  end;

implementation

{ TDfeProtocolo }

procedure TDfeProtocolo.SetNSU(const Value: String);
begin
  FNSU := Value;
end;

procedure TDfeProtocolo.SetIdProtocolo(const Value: String);
begin
  FIdProtocolo := Value;
end;

procedure TDfeProtocolo.SetDhRecbto(const Value: TDateTime);
begin
  FDhRecbto := Value;
end;

procedure TDfeProtocolo.SetNProt(const Value: String);
begin
  FNProt := Value;
end;

procedure TDfeProtocolo.SetDigVal(const Value: String);
begin
  FDigVal := Value;
end;

end.

