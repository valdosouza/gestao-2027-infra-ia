unit Un_RL_ControleCartao;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, StdCtrls, DB, STQuery, System.Math;

type
  TRL_ControleCartao = class(TForm)
    Qr_Consulta: TSTQuery;
    Qrpt: TQuickRep;
    QR_Etiqueta: TQRBand;
    Label1: TQRLabel;
    E_NomeCliente: TQRLabel;
    Label3: TQRLabel;
    E_Data: TQRLabel;
    Label5: TQRLabel;
    E_Nr_Pedido: TQRLabel;
    Label7: TQRLabel;
    E_VL_Receber: TQRLabel;
    Label11: TQRLabel;
    E_Ordem: TQRLabel;
    Label13: TQRLabel;
    E_VL_NotaFiscal: TQRLabel;
    Label15: TQRLabel;
    E_Parcelado: TQRLabel;
    Label19: TQRLabel;
    E_Vl_Parcela: TQRLabel;
    Label21: TQRLabel;
    E_Taxa_Cartao: TQRLabel;
    Label23: TQRLabel;
    E_Banco: TQRLabel;
    Label25: TQRLabel;
    E_Cartao: TQRLabel;
    Qr_ConsultaNOMECLIENTE: TStringField;
    Qr_ConsultaNFL_DT_EMISSAO: TDateField;
    Qr_ConsultaPED_NUMERO: TIntegerField;
    Qr_ConsultaCTE_DESCRICAO: TStringField;
    Qr_ConsultaCTE_PRZO_DEBI: TIntegerField;
    Qr_ConsultaNFL_VL_TL_NOTA: TBCDField;
    Qr_ConsultaFIN_VL_PARCELA: TBCDField;
    Qr_ConsultaCTE_ALIQ_CRED: TBCDField;
    Qr_ConsultaNOMEBANCO: TStringField;
    Qr_ConsultaMVF_VL_CREDITO: TBCDField;
    Qr_ConsultaMVF_VL_DEBITO: TBCDField;
    Qr_ConsultaMVF_VL_FUTURO: TBCDField;
    Qr_ConsultaFIN_CODFPG: TIntegerField;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QR_EtiquetaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Cd_Quitacao : Integer;
    It_Repeticao : Integer;
    It_Nr_Parcelas : Integer;
  end;

var
  RL_ControleCartao: TRL_ControleCartao;

implementation

uses     UN_Sistema, Un_DM, Un_Regra_Negocio;
{$R *.dfm}

procedure TRL_ControleCartao.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_AtivaEstabelecimento;
  Qr_Consulta.Active := False;
  Qr_Consulta.ParamByName('FIN_CODQTC').AsInteger := It_Cd_Quitacao;
  Qr_Consulta.Active := True;
  Qr_Consulta.FetchAll;
  Qr_Consulta.First;
  It_Repeticao := 1;
  It_Nr_Parcelas := Qr_Consulta.RecordCount;
end;

procedure TRL_ControleCartao.QR_EtiquetaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_Vl_Parcela, Lc_Vl_Receber : Real;
  Lc_Data : TDate;
begin
  with Qr_Consulta do
  Begin
    E_NomeCliente.Caption := FieldByName('NOMECLIENTE').AsString ;
    Lc_Data               := FieldByName('NFL_DT_EMISSAO').AsDateTime;
    Lc_Data               := Lc_Data + (FieldByName('CTE_PRZO_DEBI').AsInteger * It_Repeticao);
    E_Data.Caption        := DateToStr(Lc_Data) ;
    E_Nr_Pedido.Caption   := FieldByName('PED_NUMERO').AsString ;
    if Fieldbyname('MVF_VL_FUTURO').AsCurrency > 0 then
      Lc_Vl_Parcela       := Fieldbyname('MVF_VL_FUTURO').AsCurrency
    else
      Lc_Vl_Parcela       := Fieldbyname('MVF_VL_CREDITO').AsCurrency;
    Lc_Vl_Receber         := (Lc_Vl_Parcela /100 * Qr_Consulta.FieldByName('CTE_ALIQ_CRED').AsFloat);
    Lc_Vl_Receber         := RoundTo(Lc_Vl_Receber,-2);

    Lc_Vl_Receber         := Lc_Vl_Parcela - Lc_Vl_Receber;
    E_VL_Receber.Caption  := FloatToStrF(Lc_Vl_Receber ,ffNumber,10,2);


    E_Ordem.Caption         := IntToStr(It_Repeticao) + '/' + IntToStr(It_Nr_Parcelas);
    E_VL_NotaFiscal.Caption := FloatToStrF( FieldByName('NFL_VL_TL_NOTA').AsCurrency,ffNumber,10,2) ;
    E_Parcelado.Caption     := IntToStr(It_Nr_Parcelas);
    E_Vl_Parcela.Caption    := FloatToStrF(Lc_Vl_Parcela ,ffNumber,10,2) ;
    E_Taxa_Cartao.Caption   := FloatToStrF( FieldByName('CTE_ALIQ_CRED').AsFloat,ffNumber,10,2) ;
    E_Banco.Caption         := FieldByName('NOMEBANCO').AsString ;
    E_Cartao.Caption        := FieldByName('CTE_DESCRICAO').AsString ;

    inc(It_Repeticao);
  End;
end;

end.
