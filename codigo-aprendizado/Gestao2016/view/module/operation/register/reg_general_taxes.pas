unit reg_general_taxes;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.ComCtrls, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, System.StrUtils, base_registry, ControllerImpostos, Vcl.Mask, QEdit_Setes;

type
  TRegGeneralTaxes = class(TBaseRegistry)
    Panel2: TPanel;
    L_Aq_Pis: TLabel;
    L_Aq_Cofins: TLabel;
    L_Aq_CSLL: TLabel;
    L_Aq_Irpj: TLabel;
    L_Aq_Icms: TLabel;
    E_Aq_Pis: TEdit_Setes;
    E_Aq_Cofins: TEdit_Setes;
    E_Aq_CSLL: TEdit_Setes;
    E_Aq_Irpj: TEdit_Setes;
    E_Aq_Icms: TEdit_Setes;
  private
  protected
    procedure ClearAllFields; Override;
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure ShowData;Override;
    procedure Insert; Override;
    procedure Change; Override;
    //Save
    function ValidateSave():boolean; Override;
    procedure Save; Override;
    //Cancelar
    function ValidateCancel():boolean;Override;
    procedure Cancel;Override;

  public
    impostos : TControllerImpostos;
  end;

var
  RegGeneralTaxes: TRegGeneralTaxes;

implementation

{$R *.dfm}

{ TRegTaxes }

procedure TRegGeneralTaxes.Cancel;
begin
  Close;
end;

procedure TRegGeneralTaxes.Change;
begin
  inherited;
  E_Aq_Icms.SetFocus;
end;

procedure TRegGeneralTaxes.ClearAllFields;
begin
  inherited;
  impostos.Clear;
end;

procedure TRegGeneralTaxes.CriarVariaveis;
begin
  inherited;
  impostos := TControllerImpostos.create(self);
end;

procedure TRegGeneralTaxes.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(impostos);
end;

procedure TRegGeneralTaxes.IniciaVariaveis;
begin
  CodigoRegistro := 0;
  impostos.Registro.Codigo := Self.CodigoRegistro;
  impostos.getFirst;
  if (impostos.exist) then
  Begin
    EditionState := 'E';
    ShowData;
  End
  else
  Begin
    EditionState := 'I';
    ShowNoData;
  end;
  EditionControl;
end;

procedure TRegGeneralTaxes.Insert;
begin
  inherited;
  E_Aq_Icms.SetFocus;
end;

procedure TRegGeneralTaxes.Save;
begin
  with impostos do
  Begin
    registro.Icms       := StrToFloatDef(E_Aq_Icms.Text, 0);
    registro.ContSocial := StrToFloatDef(E_Aq_CSLL.Text, 0);
    registro.pis        := StrToFloatDef(E_Aq_Pis.Text, 0);
    registro.Irpj       := StrToFloatDef(E_Aq_Irpj.Text, 0);
    registro.Cofins     := StrToFloatDef(E_Aq_Cofins.Text, 0);
    salva;
  End;
  CodigoRegistro := impostos.Registro.Codigo;
  inherited;
  Close;
end;

procedure TRegGeneralTaxes.ShowData;
begin
  with impostos do
  Begin
    E_Aq_Icms.Text    := FloatToStrF( registro.Icms,ffFixed,10,2 );
    E_Aq_CSLL.Text    := FloatToStrF( registro.ContSocial,ffFixed,10,2 );
    E_Aq_Pis.Text     := FloatToStrF( registro.pis,ffFixed,10,2 );
    E_Aq_Irpj.Text    := FloatToStrF( registro.Irpj,ffFixed,10,2 );
    E_Aq_Cofins.Text  := FloatToStrF( registro.Cofins,ffFixed,10,2 );
  End;
end;


function TRegGeneralTaxes.ValidateCancel: boolean;
begin
  REsult := true;
end;

function TRegGeneralTaxes.ValidateSave: boolean;
begin
  Result := True;
end;

end.
