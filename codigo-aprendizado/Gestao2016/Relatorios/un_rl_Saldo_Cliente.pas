unit un_rl_Saldo_Cliente;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRl_Saldo = class(TForm)
    Qrpt: TQuickRep;
    PageHeaderBand1: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    QRBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel13: TQRLabel;
    Detalhe: TQRBand;
    E_EMPRESA: TQRLabel;
    Lb_Vl_Parcela: TQRLabel;
    SubTotal: TQRBand;
    QRLabel18: TQRLabel;
    Lb_vl_Subtotal: TQRLabel;
    Sumario: TQRBand;
    QRLabel20: TQRLabel;
    Lb_vl_Total: TQRLabel;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel6: TQRLabel;
    Ds_CtasReceber: TDataSource;
    Qr_CtasReceber: TSTQuery;
    Qr_CtasReceberCTR_CODQTC: TIntegerField;
    Qr_CtasReceberCTR_DT_VENCIMENTO: TDateField;
    Qr_CtasReceberCTR_DT_PAGTO: TDateField;
    Qr_CtasReceberCTR_CODEMP: TIntegerField;
    Qr_CtasReceberCTR_NOME: TStringField;
    Qr_CtasReceberCTR_FANTASIA: TStringField;
    Qr_CtasReceberCTR_FONE: TStringField;
    Qr_CtasReceberCTR_NUMERO: TStringField;
    Qr_CtasReceberCTR_NOMEEMITENTE: TStringField;
    Qr_CtasReceberCTR_VL_PARCELA: TBCDField;
    Qr_CtasReceberCTR_VL_PAGO: TBCDField;
    Qr_CtasReceberCTR_FORMAPAG: TIntegerField;
    Qr_CtasReceberCTR_BAIXA: TStringField;
    Qr_CtasReceberCTR_OPERACAO: TStringField;
    Qr_Clientes: TSTQuery;
    Qr_ClientesEMP_CODIGO: TIntegerField;
    Qr_ClientesEMP_FANTASIA: TStringField;
    Qr_ClientesEMP_NOME: TStringField;
    Qr_ClientesEMP_VL_CRED: TFloatField;
    Qr_ClientesEMP_DT_CADASTRO: TDateField;
    Qr_ClientesEND_FONE: TStringField;
    Qr_Nota: TSTQuery;
    Qr_NotaNFL_DT_EMISSAO: TDateField;
    Qr_NotaNFL_VL_TL_NOTA: TBCDField;
    Qr_NotaNFL_CODIGO: TIntegerField;
    Qr_NotaPED_NUMERO: TIntegerField;
    Qr_NotaNFL_NUMERO: TStringField;
    QRLabel7: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Rl_Saldo: TRl_Saldo;

implementation

{$R *.dfm}

end.
