unit prm_pre_paid_card;

interface

uses
      System.SysUtils, prm_dsk_base, tblPrePaidCard;

Type
  TPrmPrePaidCard = class(TPrmDskBase)
  private
    FPrePago: TPrePaidCard;
    procedure setFPrePago(const Value: TPrePaidCard);

  public
    constructor Create;
    destructor Destroy;

    property PrePago : TPrePaidCard read FPrePago write setFPrePago;
  end;

implementation

{ TPrmPrePaidCard }

constructor TPrmPrePaidCard.Create;
begin

  FPrePago := TPrePaidCard.Create;
end;

destructor TPrmPrePaidCard.Destroy;
begin
  FreeAndNil(FPrePago);

end;

procedure TPrmPrePaidCard.setFPrePago(const Value: TPrePaidCard);
begin
  FPrePago := Value;
end;

end.
