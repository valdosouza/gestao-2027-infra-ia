unit cfg_pay_back;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_config, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerGeral;

type
  TCfgPayBack = class(TFr_Base_Config)
    E_Tx_Payback: TEdit;
    Label1: TLabel;
    E_VL_Minimo: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    E_Titulo_Payback: TEdit;
    Label4: TLabel;
    E_Dias_Expired: TEdit;
    Chbx_ImprimirCredito: TCheckBox;
  private
    { Private declarations }
  protected
    //Mostrar

    procedure ShowData;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;
  public
    { Public declarations }
  end;

var
  CfgPayBack: TCfgPayBack;

implementation

{$R *.dfm}

uses     RN_FormaPagto;

{ TCfgPayBack }


procedure TCfgPayBack.Save;
begin
  inherited;
  Fc_PegaParteFormaPgto('PAYBACK');
  ExecConfig('G','PAYBACK_TAXA',E_Tx_Payback.Text);
  ExecConfig('G','PAYBACK_VL_MINIMO',E_VL_Minimo.Text);
  ExecConfig('G','PAYBACK_TITTLE',E_Titulo_Payback.Text);
  ExecConfig('G','PAYBACK_DT_EXPIRED',E_Dias_Expired.Text);
  if Chbx_ImprimirCredito.checked then
    ExecConfig('G','PAYBACK_IMP_CREDIT','S')
  else
    ExecConfig('G','PAYBACK_IMP_CREDIT','N');

end;

procedure TCfgPayBack.ShowData;
begin
  Config := TControllerGeral.create(Self);
  E_Tx_Payback.Text     := ExecConfig('L','PAYBACK_TAXA','0');
  E_VL_Minimo.Text      := ExecConfig('L','PAYBACK_VL_MINIMO','0');
  E_Titulo_Payback.Text := ExecConfig('L','PAYBACK_TITTLE','');
  E_Dias_Expired.Text   := ExecConfig('L','PAYBACK_DT_EXPIRED','365');
  Chbx_ImprimirCredito.checked := (ExecConfig('L','PAYBACK_IMP_CREDIT','S') = 'S');
end;

function TCfgPayBack.ValidateSave: boolean;
begin
  REsult := True;
end;

end.
