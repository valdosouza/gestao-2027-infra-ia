unit un_Obs_nfe;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, DBCtrls, Buttons, DB, STQuery;

type
  Tfr_obs_nfe = class(TForm)
    Panel1: TPanel;
    DBMemo1: TDBMemo;
    dst_obs_nfe: TDataSource;
    qr_Obs_nfe: TSTQuery;
    Panel2: TPanel;
    Sb_Last_end: TSpeedButton;
    Sb_Prior_end: TSpeedButton;
    Sb_Next_end: TSpeedButton;
    Sb_First_end: TSpeedButton;
    Label32: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Sb_First_endClick(Sender: TObject);
    procedure Sb_Next_endClick(Sender: TObject);
    procedure Sb_Prior_endClick(Sender: TObject);
    procedure Sb_Last_endClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    it_cd_nfl:Integer;
  end;

var
  fr_obs_nfe: Tfr_obs_nfe;

implementation

uses
Un_DM, UN_Sistema;


{$R *.dfm}

procedure Tfr_obs_nfe.FormShow(Sender: TObject);
begin
  qr_Obs_nfe.Active:=false;
  qr_Obs_nfe.ParamByName('obn_codnfl').AsInteger:= it_cd_nfl;
  qr_Obs_nfe.Active:=True;
  qr_Obs_nfe.FetchAll;

  if qr_Obs_nfe.RecordCount < 2 then
    begin
    Sb_Last_end.Enabled:=false;
    Sb_Prior_end.Enabled:=false;
    Sb_Next_end.Enabled:=false;
    Sb_First_end.Enabled:=false;
    end
  else
    begin
    Sb_Last_end.Enabled:=True;
    Sb_Prior_end.Enabled:=True;
    Sb_Next_end.Enabled:=True;
    Sb_First_end.Enabled:=True;
    end;
end;

procedure Tfr_obs_nfe.Sb_First_endClick(Sender: TObject);
begin
  qr_Obs_nfe.First;
end;

procedure Tfr_obs_nfe.Sb_Next_endClick(Sender: TObject);
begin
  qr_Obs_nfe.Next;
end;

procedure Tfr_obs_nfe.Sb_Prior_endClick(Sender: TObject);
begin
  qr_Obs_nfe.Prior;
end;

procedure Tfr_obs_nfe.Sb_Last_endClick(Sender: TObject);
begin
  qr_Obs_nfe.Last;
end;

end.
