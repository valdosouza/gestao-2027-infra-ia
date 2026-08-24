unit un_frx_recibo;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_base_report, frxExportXLS, frxClass, frxExportPDF, Data.DB, STQuery, frxDBSet;

type
  TFrx_Recibo = class(TFrxBaseReport)
    procedure frxBaseBeforePrint(Sender: TfrxReportComponent);
  private
    FNumero: String;
    FDetalhe: String;
    FLocaData: String;
    FCodigo: Integer;
    FSacado: String;
    procedure IniciaVariaveis;Override;
    procedure setFDetalhe(const Value: String);
    procedure setFNumero(const Value: String);
    procedure body;
    procedure setFLocaData(const Value: String);
    procedure setFCodigo(const Value: Integer);
    procedure setFSacado(const Value: String);
  public
    { Public declarations }
    procedure Buscar; Override;
    property Codigo : Integer read FCodigo write setFCodigo;
    property Numero : String read FNumero Write setFNumero;
    property Detalhe : String read FDetalhe write setFDetalhe;
    property Sacado:String read FSacado write setFSacado;
    property LocalData: String read FLocaData write setFLocaData;
  end;

var
  Frx_Recibo: TFrx_Recibo;

implementation

{$R *.dfm}

uses     UN_Sistema;

{ TFrx_Recibo }

procedure TFrx_Recibo.body;
begin
  frxBase.variables['NUMERO']   := QuotedStr( FNumero);
  frxBase.Variables['DETALHE']  :=  QuotedStr(FDetalhe);
  frxBase.Variables['SACADO']  := QuotedStr( FSacado );
  frxBase.Variables['LOCAL_DATA']  := QuotedStr( FLocaData );
end;

procedure TFrx_Recibo.Buscar;
begin
  inherited;
  with Qr_Consulta do
  Begin
    Active := False;
    IF Transaction.InTransaction then Transaction.Commit  else Transaction.StartTransaction;
    ParamByName('REC_CODIGO').AsInteger := FCodigo;
    Active := True;
    FetchAll;
    First;
  End;
end;

procedure TFrx_Recibo.frxBaseBeforePrint(Sender: TfrxReportComponent);
begin
  inherited;
  body;
end;

procedure TFrx_Recibo.IniciaVariaveis;
begin
  inherited;
  TfrxReportPage(frxBase.Pages[1]).PaperWidth := StrToFloatDef(Fc_Aq_Geral('L','NFCE','LARG_BOB_NOVO', '80'),80);
  TfrxReportPage(frxBase.Pages[1]).RightMargin  := StrToFloatDef(Fc_Aq_Geral('L','NFCE','MARESQ_BOB_NOVO', '0'),0);
  TfrxReportPage(frxBase.Pages[1]).LeftMargin   := StrToFloatDef(Fc_Aq_Geral('L','NFCE','MARDIR_BOB_NOVO', '0'),0);

end;

procedure TFrx_Recibo.setFCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TFrx_Recibo.setFDetalhe(const Value: String);
begin
  FDetalhe := Value;
end;

procedure TFrx_Recibo.setFLocaData(const Value: String);
begin
  FLocaData := Value;
end;

procedure TFrx_Recibo.setFNumero(const Value: String);
begin
  FNumero := Value;
end;

procedure TFrx_Recibo.setFSacado(const Value: String);
begin
  FSacado := Value;
end;

end.
