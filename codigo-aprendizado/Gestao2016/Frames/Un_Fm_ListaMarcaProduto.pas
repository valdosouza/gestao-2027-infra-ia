unit Un_Fm_ListaMarcaProduto;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.DBCtrls, Vcl.StdCtrls, Data.DB, STQuery, Un_DM,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFm_ListaMarcaProduto = class(TFrame)
    Label32: TLabel;
    Dblcb_Marca: TDBLookupComboBox;
    Sb_Recipiente_Fabricante_3: TSpeedButton;
    Qr_ListaMarca: TSTQuery;
    Ds_ListaMarca: TDataSource;
    procedure Sb_Recipiente_Fabricante_3Click(Sender: TObject);
    procedure Dblcb_MarcaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
     procedure Pc_ListaMedida();
  end;

implementation

{$R *.dfm}

uses     sea_product_brand;
procedure TFm_ListaMarcaProduto.Dblcb_MarcaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
      begin
        Dblcb_Marca.KeyValue := Null;
      end;
    end;
end;

procedure TFm_ListaMarcaProduto.Pc_ListaMedida;
begin
  Qr_ListaMarca.Active := False;
  Qr_ListaMarca.Active  := True;
  Qr_ListaMarca.FetchAll
end;

procedure TFm_ListaMarcaProduto.Sb_Recipiente_Fabricante_3Click(Sender: TObject);
Var
  Lc_Form : TSeaProductBrand;
begin
  Lc_Form := TSeaProductBrand.Create(nil);
  Try
    If trim(Dblcb_Marca.Text) <> '' THEN
      Lc_Form.CodigoRegistro := Dblcb_Marca.KeyValue;
    Lc_Form.ShowModal;
    Dblcb_Marca.KeyValue := Lc_Form.CodigoRegistro;
    Dblcb_Marca.SetFocus;
  Finally
   FreeAndNil(Lc_Form);
  End;
end;

end.
