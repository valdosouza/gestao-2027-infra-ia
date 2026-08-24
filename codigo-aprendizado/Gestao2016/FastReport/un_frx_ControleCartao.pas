unit un_frx_ControleCartao;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_base_report, frxClass, frxExportPDF, Data.DB, STQuery, frxDBSet, Un_DM, frxExportXLS;

type
  Tfrx_ControleCartao = class(TFrxBaseReport)
  private
    FCodigoQuitacao: Integer;
    FCodigoFinanceiro: Integer;
    procedure setFCodigoFinanceiro(const Value: Integer);
    procedure setFCodigoQuitacao(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }
    procedure Buscar;
    property CodigoQuitacao:Integer read FCodigoQuitacao write setFCodigoQuitacao;
    property CodigoFinanceiro : Integer read FCodigoFinanceiro write setFCodigoFinanceiro;

  end;

var
  frx_ControleCartao: Tfrx_ControleCartao;

implementation

{$R *.dfm}

{ Tfrx_ControleCartao }

procedure Tfrx_ControleCartao.Buscar;
begin
  if DM.IBT_Report.InTransaction then DM.IBT_Report.Commit;
  Qr_Consulta.Active := False;
  Qr_Consulta.ParamByName('FIN_CODQTC').AsInteger := FCodigoQuitacao;
  Qr_Consulta.ParamByName('FIN_CODIGO').AsInteger := FCodigoFinanceiro;
  Qr_Consulta.Active := True;
  Qr_Consulta.FetchAll;
  Qr_Consulta.First;
  frxBase.Variables['It_Nr_Parcelas'] := Qr_Consulta.RecordCount;
end;

procedure Tfrx_ControleCartao.setFCodigoFinanceiro(const Value: Integer);
begin
  FCodigoFinanceiro := Value;
end;

procedure Tfrx_ControleCartao.setFCodigoQuitacao(const Value: Integer);
begin
  FCodigoQuitacao := Value;
end;

end.
