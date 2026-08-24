unit Un_Fm_ListaUnidades;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.DBCtrls, Vcl.StdCtrls;

type
  TFm_ListaUnidades = class(TFrame)
    Label19: TLabel;
    DBLCB_Medida: TDBLookupComboBox;
    Sb_Medida: TSpeedButton;
    procedure Sb_MedidaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses     UN_TabelasEmListas, sea_measure;

procedure TFm_ListaUnidades.Sb_MedidaClick(Sender: TObject);
Var
  Lc_Form : TSeaMeasure;
begin
  Lc_Form := TSeaMeasure.Create(nil);
  Try
    if (Trim(DBLCB_Medida.Text) <> '') then
      Lc_Form.CodigoRegistro := DBLCB_Medida.KeyValue;
    Lc_Form.ShowModal;
    DM_ListaConsultas.Pc_ListaMedida('','');
    DBLCB_Medida.KeyValue := Lc_Form.CodigoRegistro;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

end.
