unit prm_group_menu; //TB_GRUPOS

interface

uses
      prm_dsk_base, tblGrupos, System.SysUtils;

Type
  TPrmGroupMenu = class(TPrmDskBase)
  private
    FFieldName: TGrupos;
    FisRestaurant: Boolean;
    FVazio: Boolean;
    procedure setFFieldName(const Value: TGrupos);
    procedure setFisRestaurant(const Value: Boolean);
    procedure setfVazio(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TGrupos read FFieldName write setFFieldName;
    property isRestaurant : Boolean read FisRestaurant write setFisRestaurant;
    property Vazio : Boolean read FVazio write setfVazio;
  end;

implementation

procedure TPrmGroupMenu.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmGroupMenu.Create;
begin
  inherited;
  FFieldName := TGrupos.Create;
end;

destructor TPrmGroupMenu.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmGroupMenu.setFFieldName(const Value: TGrupos);
begin
  FFieldName := Value;
end;

procedure TPrmGroupMenu.setFisRestaurant(const Value: Boolean);
begin
  FisRestaurant := Value;
end;

procedure TPrmGroupMenu.setfVazio(const Value: Boolean);
begin
  FVazio := Value;
end;

end.
