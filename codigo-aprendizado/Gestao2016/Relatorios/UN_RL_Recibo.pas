unit UN_RL_Recibo;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, jpeg, DB, STQuery;

type
  TRL_Recibo = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    E_destinatario: TQRLabel;
    QRBand1: TQRBand;
    Lb_Frota: TQRLabel;
    Lb_Equipamento: TQRLabel;
    E_Importancia: TQRLabel;
    QRLabel3: TQRLabel;
    E_Vl_Recibo: TQRLabel;
    E_Data: TQRLabel;
    E_Emitente: TQRLabel;
    E_Numero: TQRLabel;
    E_Referencia: TQRExprMemo;
    Qr_Recibo: TSTQuery;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  RL_Recibo: TRL_Recibo;

implementation

uses     Un_Cotacao, Un_Funcoes, UN_Sistema, Un_DM, UN_Flh_Pagto, Un_Regra_Negocio;
{$R *.dfm}

procedure TRL_Recibo.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_Ano,Lc_mes,Lc_dia, Lc_Cidade:String ;
  Lc_I:Integer;
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  E_Numero.Caption := Qr_Recibo.FieldByName('REC_NUMERO').AsString;

  E_Vl_Recibo.Caption := 'R$ '+ FloatToSTrf(Qr_Recibo.FieldByName('REC_VALOR').AsCurrency,ffNumber, 10,2);

  Pc_AtivaEstabelecimento;
  Lc_Cidade := UCWord(DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString);

  Lc_dia := Copy(DateTimeToStr( Qr_Recibo.FieldByName('REC_DATA').AsDateTime ),1,2);
  Lc_mes := Fc_DesMes(Fc_Month( Qr_Recibo.FieldByName('REC_DATA').AsDateTime ),True);
  Lc_Ano := Copy(DateTimeToStr( Qr_Recibo.FieldByName('REC_DATA').AsDateTime ),7,4);

  E_destinatario.Caption := UpperCase(Qr_Recibo.FieldByName('REC_SACADO').AsString);
  E_Importancia.Caption := E_Vl_Recibo.Caption + ' ('+
                            Fc_Extenso(Qr_Recibo.FieldByName('REC_VALOR').AsCurrency)+')';
  E_Referencia.Lines.Clear;
  E_Referencia.Lines.Text := Qr_Recibo.FieldByName('REC_OBS').AsString;
 // For Lc_I := 0 to Fr_Recibo.E_Referencia.Lines.Count - 1 do
 //   E_Referencia.Lines.Add(Fr_Recibo.E_Referencia.Lines[Lc_I]);

  E_Data.Caption := Lc_Cidade + ', '+ Lc_dia + ' de ' + Lc_mes + ' de '+ Lc_Ano;

  E_Emitente.Caption := Qr_Recibo.FieldByName('REC_EMITENTE').AsString;

end;

procedure TRL_Recibo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action := caFree;
  RL_Recibo := nil;
end;

end.

