unit uDataCM;

interface

uses
      System.SysUtils, System.Classes, Datasnap.DSClientRest, uDataComandaCC, uDataProdutoCC, uDataPrecoCC, uDataUsuarioCC, UnFunctions;

type
  TDataCM = class(TDataModule)
    DSRC: TDSRestConnection;
    procedure DataModuleCreate(Sender: TObject);
   private
    FInstanceOwner: Boolean;
    FSMProdutoClient: TSMProdutoClient;
    FSMCommandClient: TSMCommandClient;
    FSMPrecoClient: TSMPrecoClient;
    FSMUsuarioClient: TSMUsuarioClient;
    function GetSMProdutoClient: TSMProdutoClient;
    function GetSMCommandClient: TSMCommandClient;
    function GetSMPrecoClient: TSMPrecoClient;
    function GetSMUsuarioClient: TSMUsuarioClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property SMProdutoClient: TSMProdutoClient read GetSMProdutoClient write FSMProdutoClient;
    property SMCommandClient: TSMCommandClient read GetSMCommandClient write FSMCommandClient;
    property SMPrecoClient: TSMPrecoClient read GetSMPrecoClient write FSMPrecoClient;
    property SMUsuarioClient: TSMUsuarioClient read GetSMUsuarioClient write FSMUsuarioClient;

end;

var
  DataCM: TDataCM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}


{$R *.dfm}

constructor TDataCM.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

procedure TDataCM.DataModuleCreate(Sender: TObject);
begin
  DSRC.Host := GetConfig('MOBILE','SERVER');
end;

destructor TDataCM.Destroy;
begin
  FSMProdutoClient.Free;
  FSMCommandClient.Free;
  FSMPrecoClient.Free;
  FSMUsuarioClient.Free;
  inherited;
end;

function TDataCM.GetSMProdutoClient: TSMProdutoClient;
begin
  if FSMProdutoClient = nil then
    FSMProdutoClient:= TSMProdutoClient.Create(DSRC, FInstanceOwner);
  Result := FSMProdutoClient;
end;
function TDataCM.GetSMCommandClient: TSMCommandClient;
begin
  if FSMCommandClient = nil then
    FSMCommandClient:= TSMCommandClient.Create(DSRC, FInstanceOwner);
  Result := FSMCommandClient;
end;
function TDataCM.GetSMPrecoClient: TSMPrecoClient;
begin
  if FSMPrecoClient = nil then
    FSMPrecoClient:= TSMPrecoClient.Create(DSRC, FInstanceOwner);
  Result := FSMPrecoClient;
end;
function TDataCM.GetSMUsuarioClient: TSMUsuarioClient;
begin
  if FSMUsuarioClient = nil then
    FSMUsuarioClient:= TSMUsuarioClient.Create(DSRC, FInstanceOwner);
  Result := FSMUsuarioClient;
end;

end.

