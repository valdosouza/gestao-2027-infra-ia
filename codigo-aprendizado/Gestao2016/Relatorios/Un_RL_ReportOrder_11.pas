unit Un_RL_ReportOrder_11;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportOrder, Data.DB, STQuery, QuickRpt, QRCtrls, Vcl.ExtCtrls;

type
  TRL_ReportOrder_11 = class(TRL_ReportOrder)
    QRShape14: TQRShape;
    Lb_Altura: TQRLabel;
    QRShape16: TQRShape;
    Lb_Largura: TQRLabel;
    QRShape17: TQRShape;
    Lb_Nr_Pecas: TQRLabel;
    E_Nr_Pedido: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  protected
    procedure Cabecalho; Override;
    Procedure ValidaProdutos(Pc_Print : Boolean);Override;
    Procedure PreencheProdutos;Override;
    procedure CustomerGroup; Override;

  public
    { Public declarations }
  end;

var
  RL_ReportOrder_11: TRL_ReportOrder_11;

implementation

{$R *.dfm}

uses     UN_Sistema;

{ TRL_ReportOrder_11 }

{ TRL_ReportOrder_11 }

procedure TRL_ReportOrder_11.Cabecalho;
begin
  inherited;
  E_Nr_Pedido.Caption := Qr_Pedido.FieldByName('PED_NUMERO').AsString;
end;

procedure TRL_ReportOrder_11.CustomerGroup;
begin
  with Qr_Pedido do
  Begin

    Lb_Cli_Nome.Caption     := FieldByName('EMP_FANTASIA').AsString;
    Lb_Cli_Codigo.Caption   := FieldByName('EMP_CODIGO').AsString;
    Lb_Cli_Endereco.Caption := FieldByName('END_ENDER').AsString + ', ' + FieldByName('END_NUMERO').AsString;
    Lb_Cli_cep.Caption      := fc_MascaraCep(FieldByName('END_CEP').AsString);
    Lb_Cli_FoneC.Caption    := fc_MascaraFone(FieldByName('END_FONE').AsString);
    Lb_Cli_Complemento.Caption := FieldByName('END_COMPLEM').AsString;
    Lb_Cli_Contato.Caption     := FieldByName('END_CONTATO').AsString;
    Lb_Cli_bairro.Caption   := FieldByName('END_BAIRRO').AsString;
    Lb_Cli_Cidade.Caption   := FieldByName('CDD_DESCRICAO').AsString;
    Lb_Cli_Fax.Caption      := fc_MascaraFone(FieldByName('END_FAX').AsString);
    if Length(FieldByName('EMP_CNPJ').AsString)=11 then
    Begin
      Lb_CNPJ.Caption := 'C.P.F: ';
      Lb_Ie.Caption   := 'Identidade: ';
      Lb_Cli_Cnpj.Caption   := fc_MascaraCPF(FieldByName('EMP_CNPJ').AsString);
    end
    else
    Begin
      Lb_CNPJ.Caption := 'C.N.P.J: ';
      Lb_Ie.Caption   := 'Insc. Estadual :';
      Lb_Cli_Cnpj.Caption   := fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString);
    end;
    Lb_Cli_IncEst.Caption := FieldByName('EMP_INSC_EST').AsString;
    Lb_Cli_Celular.Caption := fc_MascaraFone(FieldByName('END_CELULAR').AsString);
  end;

end;

procedure TRL_ReportOrder_11.PreencheProdutos;
begin
  inherited;
  with Qr_ItensPro do
  Begin
    Lb_Nr_Pecas.Caption := FloatToStrf(FieldByname('ITF_NR_PECAS').AsFloat,ffFixed,10,2);
    Lb_Largura.Caption := FloatToStrf(FieldByname('ITF_LARGURA').AsFloat,ffFixed,10,2);
    Lb_Altura.Caption := FloatToStrf(FieldByname('ITF_ALTURA').AsFloat,ffFixed,10,2);
  End;
end;

procedure TRL_ReportOrder_11.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  DefineImpressora;
  IniciaVariaveis;
  Pc_Cab_Relatorio(Qrpt);
  CustomerGroup;
end;

procedure TRL_ReportOrder_11.ValidaProdutos(Pc_Print: Boolean);
begin
  inherited;
  if Pc_Print then
  BEgin
    Lb_Nr_Pecas.Font.Style := [];
    Lb_Largura.Font.Style := [];
    Lb_Altura.Font.Style := [];

    Lb_Nr_Pecas.Alignment := taCenter;
    Lb_Largura.Alignment := taRightJustify;
    Lb_Altura.Alignment := taRightJustify;

    Lb_Nr_Pecas.Font.Color := clBlack;
    Lb_Largura.Font.Color := clBlack;
    Lb_Altura.Font.Color := clBlack;
  end
  else
  BEgin
    Lb_Nr_Pecas.Font.Color := clWhite;
    Lb_Largura.Font.Color := clWhite;
    Lb_Largura.Font.Color := clWhite;
  end;
end;



end.
