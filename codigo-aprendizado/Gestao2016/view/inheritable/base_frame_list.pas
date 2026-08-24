unit base_frame_list;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, STQuery, STTransaction,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  IBX.IBDatabase, IBX.IBCustomDataSet, IBX.IBQuery;

type
  TBaseFrameList = class(TFrame)
    L_name_list: TLabel;
    pnl_linha_1: TPanel;
    Dblcb_Lista: TDBLookupComboBox;
    Sb_open: TSpeedButton;
    Ds_Lista: TDataSource;
    Qr_Lista: TSTQuery;
    IBT_Listas: TSTTransaction;
    pnl_top: TPanel;
    procedure Dblcb_ListaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses     Un_DM;

procedure TBaseFrameList.Dblcb_ListaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
      begin
        Dblcb_Lista.KeyValue := 0;
      end;
    end;
end;

end.
