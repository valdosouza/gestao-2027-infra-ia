unit un_Imp_Saldo;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, DB, STQuery, DBCtrls, StdCtrls, ComCtrls, ExtCtrls;

type
  TFr_Imp_Saldo = class(TForm)
    SB_Imprimir: TSpeedButton;
    SB_Sair: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Qr_Cliente: TSTQuery;
    Qr_ClienteEMP_CODIGO: TIntegerField;
    Qr_ClienteEMP_NOME: TStringField;
    Qr_ClienteEMP_FANTASIA: TStringField;
    Ds_Cliente: TDataSource;
    Label5: TLabel;
    Label4: TLabel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    DBLCB_Cliente: TDBLookupComboBox;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    CB_Classificacao: TComboBox;
    Label3: TLabel;
    procedure Sb_ExportarClick(Sender: TObject);
    procedure SB_SairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_Imp_Saldo: TFr_Imp_Saldo;

implementation

uses     Un_DM, Un_Excel, UN_RL_Contas_Receber, UN_RL_Contas_Receber_C;
{$R *.dfm}

procedure TFr_Imp_Saldo.Sb_ExportarClick(Sender: TObject);
Var
  Lc_CAminho : String;
begin
  if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
  if Fr_Excel.SaveDialogo.Execute then
    Begin
    Lc_CAminho := Fr_Excel.SaveDialogo.FileName;
    case CB_Classificacao.ItemIndex of
      0:Begin
        If not Assigned(RL_Contas_Receber) then (Application.CreateForm(TRL_Contas_Receber, RL_Contas_Receber));
        RL_Contas_Receber.Pc_Busca;
        Fr_Excel.Pc_Excel(RL_Contas_Receber.Qr_CtasReceber,Lc_CAminho);
        End;
      1:Begin
        If not Assigned(RL_Contas_Receber_C) then (Application.CreateForm(TRL_Contas_Receber_C, RL_Contas_Receber_C));
        RL_Contas_Receber_C.Pc_Busca;
        Fr_Excel.Pc_Excel(RL_Contas_Receber_C.Qr_CtasReceber,Lc_CAminho);
        End;
    end;
    end;
end;

procedure TFr_Imp_Saldo.SB_SairClick(Sender: TObject);
begin
  Close;
end;

end.
