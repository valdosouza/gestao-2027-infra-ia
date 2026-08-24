unit trayCategory2;

interface

type
  TTrayCategory2 = class
  private
    FId: string;
    FName: string;
    FMainCategory: string;
  public
    property Id: string read FId write FId;
    property Name: string read FName write FName;
    property MainCategory: string read FMainCategory write FMainCategory;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

end.
