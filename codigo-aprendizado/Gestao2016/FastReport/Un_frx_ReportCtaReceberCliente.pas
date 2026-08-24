unit Un_frx_ReportCtaReceberCliente;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_ReportCtaReceber, frxClass, frxIBXComponents, Data.DB, STQuery, frxExportCSV, frxExportPDF, frxDBSet, frxExportXLS;

type
  Tfrx_ReportCtaReceberCliente = class(Tfrx_ReportCtaReceber)
    Qr_ConsultaFIN_CODQTC: TIntegerField;
    Qr_ConsultaFIN_DT_VENCIMENTO: TDateField;
    Qr_ConsultaFIN_DT_PAGTO: TDateField;
    Qr_ConsultaFIN_CODEMP: TIntegerField;
    Qr_ConsultaEMP_NOME: TStringField;
    Qr_ConsultaEMP_FANTASIA: TStringField;
    Qr_ConsultaEND_FONE: TStringField;
    Qr_ConsultaEND_REGIAO: TStringField;
    Qr_ConsultaFIN_NUMERO: TStringField;
    Qr_ConsultaFIN_VL_PARCELA: TBCDField;
    Qr_ConsultaFIN_VL_PAGO: TBCDField;
    Qr_ConsultaFIN_CODFPG: TIntegerField;
    Qr_ConsultaFIN_BAIXA: TStringField;
    Qr_ConsultaNFL_DT_EMISSAO: TDateField;
    Qr_ConsultaFIN_OPERACAO: TStringField;
    Qr_ConsultaFIN_CODMHA: TIntegerField;
    Qr_ConsultaFIN_CODPED: TIntegerField;
    Qr_ConsultaFIN_CODCHQ: TIntegerField;
    Qr_ConsultaFIN_CODNFL: TIntegerField;
    Qr_ConsultaFIN_TIPO: TStringField;
    Qr_ConsultaFIN_SITUACAO: TStringField;
    Qr_ConsultaFIN_DT_REPROGRAMADA: TDateField;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frx_ReportCtaReceberCliente: Tfrx_ReportCtaReceberCliente;

implementation

{$R *.dfm}

end.
