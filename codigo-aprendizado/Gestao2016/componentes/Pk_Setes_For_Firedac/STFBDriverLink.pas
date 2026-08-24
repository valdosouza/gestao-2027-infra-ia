unit STFBDriverLink;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB;

type
  TSTFBDriverLink = class(TFDPhysFBDriverLink)
  published
    property VendorLib;
    property VendorHome;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Setes', [TSTFBDriverLink]);
end;

end.
