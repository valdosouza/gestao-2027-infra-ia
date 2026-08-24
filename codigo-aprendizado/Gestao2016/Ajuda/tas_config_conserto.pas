unit tas_config_conserto;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, tas_config, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TTasConfigConserto = class(TTasConfig)
    ChBx_Valida_Mao_Obra: TCheckBox;
  private
    { Private declarations }
  protected
    function ValidaGravacao:Boolean;Override;
    procedure Gravar;Override;
    procedure Mostrar;Override;
  public
    { Public declarations }
  end;

var
  TasConfigConserto: TTasConfigConserto;

implementation
uses      UN_Sistema;
{$R *.dfm}

{ TTasConfigConserto }

procedure TTasConfigConserto.Gravar;
begin
  inherited;
  if ChBx_Valida_Mao_Obra.Checked then
    Fc_Tb_Geral('G','CST_VAL_MAO_OBRA', 'S')
  else
    Fc_Tb_Geral('G','CST_VAL_MAO_OBRA', 'N');

end;

procedure TTasConfigConserto.Mostrar;
begin
  inherited;
  ChBx_Valida_Mao_Obra.Checked := ( Fc_Tb_Geral('L','CST_VAL_MAO_OBRA', 'N') = 'S' );
end;

function TTasConfigConserto.ValidaGravacao: Boolean;
begin
  REsult := True;
end;

end.
