unit Un_Tsk_FormaPagamento;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, tributacao, System.Actions, Vcl.ActnList, STDatabase, Vcl.StdCtrls, Vcl.Mask, QEdit_Setes, Vcl.Buttons, Vcl.ExtCtrls, STTransaction;

type
  TFr_Tsk_FormaPagamento = class(TForm)
    Lb_FormaPagto: TLabel;
    Pnl_Botao: TPanel;
    Sb_Confirma: TSpeedButton;
    Sb_Cancelar: TSpeedButton;
    Grp_Pagamento: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    LB_TL_RECEBIDO: TLabel;
    Label1: TLabel;
    Sb_NovaFormaPagto: TSpeedButton;
    E_Vl_Pagar: TEdit_Setes;
    E_VL_Troco: TEdit_Setes;
    e_vl_recebido: TEdit_Setes;
    E_VL_Total: TEdit_Setes;
    E_M_Fisco: TMemo;
    E_M_Nota: TMemo;
    Pnl_FormaPagto: TPanel;
    IBT_Faturamento: TSTTransaction;
    Ac_Funcoes: TActionList;
    Ac_Gaveta: TAction;
    Ac_Log: TAction;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_Tsk_FormaPagamento: TFr_Tsk_FormaPagamento;

implementation

{$R *.dfm}


end.
