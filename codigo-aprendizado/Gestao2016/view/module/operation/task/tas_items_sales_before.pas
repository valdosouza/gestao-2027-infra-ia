unit tas_items_sales_before;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, STQuery, STTransaction;

type
  TTasItemsSalesBefore = class(TFr_Base)
    DBG_Servicos: TDBGrid;
    ds_items: TDataSource;
    Qr_Items: TSTQuery;
    Qr_ItemsPED_DATA: TDateField;
    Qr_ItemsPED_NUMERO: TIntegerField;
    Qr_ItemsITF_VL_UNIT: TFMTBCDField;
    Qr_ItemsITF_QTDE: TBCDField;
    IBT_Items: TSTTransaction;
    procedure FormShow(Sender: TObject);
    procedure Qr_ItemsAfterOpen(DataSet: TDataSet);
  private
    FCodigoProduto: Integer;
    FCodigoCliente: Integer;
    { Private declarations }
    procedure  GetLastItems;
    procedure setFCodigoCliente(const Value: Integer);
    procedure setFCodigoProduto(const Value: Integer);
  public
    { Public declarations }
    property CodigoCliente : Integer read FCodigoCliente write setFCodigoCliente;
    property CodigoProduto : Integer read FCodigoProduto write setFCodigoProduto;
  end;

var
  TasItemsSalesBefore: TTasItemsSalesBefore;

implementation

{$R *.dfm}

uses     Un_DM, env;
procedure TTasItemsSalesBefore.FormShow(Sender: TObject);
begin
  inherited;
  GetLastItems;
end;

procedure TTasItemsSalesBefore.GetLastItems;
begin
  if IBT_Items.InTransaction then IBT_Items.Commit;
  if not IBT_Items.InTransaction then IBT_Items.StartTransaction;
  Qr_Items.Active := False;
  Qr_Items.ParamByName('EMP_CODIGO').AsInteger := FCodigoCliente;
  Qr_Items.ParamByName('itf_codpro').AsInteger := FCodigoProduto;
  Qr_Items.Active := True;
  Qr_Items.FetchAll;
end;

procedure TTasItemsSalesBefore.Qr_ItemsAfterOpen(DataSet: TDataSet);
begin
  if Qr_Items.RecordCount > 0 then
  Begin
    (Qr_ItemsITF_VL_UNIT as TNumericField).DisplayFormat     := Gb_Casa_Dec_Venda;
    (Qr_ItemsITF_QTDE as TNumericField).DisplayFormat     := '0.00######';
  End;
end;

procedure TTasItemsSalesBefore.setFCodigoCliente(const Value: Integer);
begin
  FCodigoCliente := Value;
end;

procedure TTasItemsSalesBefore.setFCodigoProduto(const Value: Integer);
begin
  FCodigoProduto := Value;
end;

end.
