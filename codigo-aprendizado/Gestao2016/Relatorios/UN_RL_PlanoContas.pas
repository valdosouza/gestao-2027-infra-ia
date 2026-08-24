unit UN_RL_PlanoContas;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, ExtCtrls, QuickRpt, QRCtrls, STQuery;

type
  TRL_PlanoContas = class(TForm)
    Qrpt: TQuickRep;
    PageHeaderBand1: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel7: TQRLabel;
    Qr_PlanoContas: TSTQuery;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRBand2: TQRBand;
    QRDBText3: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText1: TQRDBText;
    QRDBText5: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }

  procedure Pc_Busca;
  end;

var
  RL_PlanoContas: TRL_PlanoContas;

implementation

uses      Un_DM, UN_Sistema, Un_Principal, env;
{$R *.dfm}



procedure TRL_PlanoContas.Pc_Busca;
Var
  SqlTxt:String;
  Lc_Codigo : Boolean;
begin
  Screen.Cursor:=crHourGlass;
  Qr_PlanoContas.Active := False;
  Qr_PlanoContas.SQL.Clear;

  Sqltxt:='SELECT PLC_CODIGO, PLC_CODPLANO, PLC_DESCRICAO, PLC_NATUREZA, PLC_TIPO, PLC_CODMHA '+
          'FROM  TB_PLANOCONTAS tb_planocontas '+
          'WHERE (PLC_CODIGO IS NOT NULL)AND(PLC_CODMHA=:PLC_CODMHA) ';

  if lc_Codigo then SqlTxt := SqlTxt +'AND (PLC_CODPLANO LIKE :PLC_CODPLANO) ';

  Qr_PlanoContas.SQL.Add(SqlTxt+' ORDER BY PLC_CODPLANO ');
//  if lc_Codigo then Qr_PlanoCOntas.ParamByName('PLC_CODPLANO').AsString:=Fr_Imp_Balancete.It_CodPLano+'%';
  Qr_PlanoCOntas.ParamByName('PLC_CODMHA').AsInteger := Gb_CodMha;
  Qr_PlanoContas.Open;
  Screen.Cursor:=crDefault;
end;

procedure TRL_PlanoContas.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
end;

procedure TRL_PlanoContas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action := Cafree;
  RL_PlanoContas := Nil
end;

end.
