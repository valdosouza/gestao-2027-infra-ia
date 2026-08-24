unit Un_RL_ReportOrder_12;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportOrder, Data.DB, STQuery, QuickRpt, QRCtrls, Vcl.ExtCtrls;

type
  TRL_ReportOrder_12 = class(TRL_ReportOrder)
    E_Nr_Pedido: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel2: TQRLabel;
    E_Data_Pedido: TQRLabel;
    QRLabel15: TQRLabel;
    E_Hora: TQRLabel;
    QRLabel20: TQRLabel;
    QRShape2: TQRShape;
    Und: TQRLabel;
    QRLabel23: TQRLabel;
    E_Vl_frete: TQRLabel;
    QRShape3: TQRShape;
    QRLabel24: TQRLabel;
    QRShape4: TQRShape;
    QRLabel25: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    img: TQRImage;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  protected
    procedure Cabecalho; Override;
    procedure Rodape; Override;
    Procedure ValidaProdutos(Pc_Print : Boolean);Override;
    Procedure PreencheProdutos;Override;
    procedure CustomerGroup; Override;
  public
    { Public declarations }
  end;

var
  RL_ReportOrder_12: TRL_ReportOrder_12;

implementation

{$R *.dfm}

uses     UN_Sistema, Un_Regra_Negocio;

procedure TRL_ReportOrder_12.Cabecalho;
begin

  Fc_BuscaImagemEmpresa(Img.Picture,'LOGO');
  E_Nr_Pedido.Caption := Qr_Pedido.FieldByName('PED_NUMERO').AsString;
  E_Data_Pedido.Caption := Qr_Pedido.FieldByName('PED_DATA').AsString;
  E_Hora.Caption := timeToStr(Time);
end;

procedure TRL_ReportOrder_12.CustomerGroup;
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

procedure TRL_ReportOrder_12.PreencheProdutos;
begin
  inherited;
  with Qr_ItensPro do
  Begin
    Und.Caption := FieldByname('MEDIDA').AsString;
  End;
end;

procedure TRL_ReportOrder_12.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  DefineImpressora;
  IniciaVariaveis;
  Cabecalho;
  CustomerGroup;
end;

procedure TRL_ReportOrder_12.Rodape;
begin
  ValorFrete := Qr_Pedido.FieldByName('PED_VL_FRETE').AsCurrency;
  E_Vl_frete.Caption := FloattoStrF(ValorFrete,ffFixed,10,2);
  inherited;
end;

procedure TRL_ReportOrder_12.ValidaProdutos(Pc_Print: Boolean);
begin
  inherited;
  if Pc_Print then
  BEgin

  end
  else
  BEgin

  end;
end;

end.
