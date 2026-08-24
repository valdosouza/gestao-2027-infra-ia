unit cfg_assistance;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus;

type
  TCfgAssistance = class(TFr_Base)
    Panel2: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Cbx_ModeloImpressao: TComboBox;
    Btn_Ok_Local: TButton;
    Btn_Cn_Local: TButton;
    Btn_Ap_Local: TButton;
    procedure Btn_Ok_LocalClick(Sender: TObject);
    procedure Btn_Ap_LocalClick(Sender: TObject);
  private
    procedure Pc_Grava_Config_Local;
    procedure Pc_Abre_Config_Local;
  public
    { Public declarations }
  end;

var
  CfgAssistance: TCfgAssistance;

implementation

{$R *.dfm}

uses     UN_Sistema;

procedure TCfgAssistance.Btn_Ap_LocalClick(Sender: TObject);
begin
  Pc_Grava_Config_Local;
end;

procedure TCfgAssistance.Btn_Ok_LocalClick(Sender: TObject);
begin
  inherited;
  Pc_Grava_Config_Local;
  Close;
end;

procedure TCfgAssistance.Pc_Abre_Config_Local;
begin
  //modelo de impressao estilo matricial
  Fc_Aq_Geral('G','ASSISTENCIA TECNICA','ASS_P_MOD_LASER', IntToStr(Cbx_ModeloImpressao.ItemIndex+1));

end;

procedure TCfgAssistance.Pc_Grava_Config_Local;
begin
  Cbx_ModeloImpressao.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','ASSISTENCIA TECNICA','ASS_P_MOD_LASER', '1'),1)-1;
end;

end.
