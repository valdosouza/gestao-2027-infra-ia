unit Un_RL_ReportList;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_Report, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportList = class(TRL_Report)
    PageHeader: TQRBand;
    E_Titulo: TQRLabel;
    Img_Logo: TQRImage;
    Lb_Emp_Nome: TQRLabel;
    Lb_Emp_Doc: TQRLabel;
    Lb_Emp_End: TQRLabel;
    Lb_Emp_Fones: TQRLabel;
    Lb_Emp_www: TQRLabel;
    Lb_Emp_email: TQRLabel;

    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);

  private
    { Private declarations }
  protected
   procedure Cabecalho;Virtual;
  public
    { Public declarations }
  end;

var
  RL_ReportList: TRL_ReportList;

implementation

{$R *.dfm}

uses     Un_DM, UN_Sistema, Un_Regra_Negocio;

procedure TRL_ReportList.Cabecalho;
Var
  Lc_Aux: String;
begin
  Pc_AtivaEstabelecimento;
  WITH DM.Qr_Estabelecimento DO
  bEGIN
    Fc_BuscaImagemEmpresa(Img_Logo.Picture,'LOGO');
    Lb_Emp_Nome.Caption := FieldByName('EMP_FANTASIA').AsString;
    Lb_Emp_Doc.Caption := 'C.N.P.J: '+fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString) + ' -  I.E.: '+ FieldByName('EMP_INSC_EST').AsString;
    IF (trim(FieldByName('END_COMPLEM').asString) = '') then
    Begin
      Lc_Aux := FieldByName('END_ENDER').AsString + ', '+
                FieldByName('END_NUMERO').asString + ' - ' +
                FieldByName('END_BAIRRO').AsString + ' - ' +
                Fc_MascaraCep(FieldByName('END_CEP').AsString) + ' - ' +
                FieldByName('CDD_DESCRICAO').AsString + ' - ' +
                FieldByName('UFE_SIGLA').AsString ;
    end
    else
    Begin
      Lc_Aux := FieldByName('END_ENDER').AsString + ', '+
                FieldByName('END_NUMERO').asString + ' - ' +
                FieldByName('END_COMPLEM').asString + ' - ' +
                FieldByName('END_BAIRRO').AsString + ' - ' +
                Fc_MascaraCep(FieldByName('END_CEP').AsString) + ' - ' +
                FieldByName('CDD_DESCRICAO').AsString + ' - ' +
                FieldByName('UFE_SIGLA').AsString ;
    end;
    Lb_Emp_End.Caption := Lc_Aux;
    Lc_Aux :='';
    if (trim(FieldByName('END_FONE').AsString) <> '') then
      Lc_Aux := fc_MascaraFone(FieldByName('END_FONE').AsString);
    if (Trim(Lc_Aux) <> '') and (trim(FieldByName('END_CELULAR').AsString) <> '') then
      Lc_Aux := Lc_Aux + ' / ' + fc_MascaraFone(FieldByName('END_CELULAR').AsString)
    else
    if (trim(FieldByName('END_CELULAR').AsString) <> '') then
      Lc_Aux := fc_MascaraFone(FieldByName('END_CELULAR').AsString);

    Lb_Emp_Fones.Caption := 'Fones: ' +  Lc_Aux;
    Lb_Emp_www.Caption := 'Site: ' + FieldByName('EMP_SITE').AsString;
    Lb_Emp_email.Caption := 'e-mail: ' + FieldByName('EMP_EMAIL').AsString;
  END;
  E_Titulo.Caption := Qrpt.ReportTitle;
end;

procedure TRL_ReportList.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  inherited;
  Cabecalho
end;

end.
