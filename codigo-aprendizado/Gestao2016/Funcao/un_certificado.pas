unit un_certificado;

interface
uses     ACBrDFeSSL, ACBrDFeConfiguracoes, SysUtils, blcksock, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Graphics, Classes, pcnConversao, pmdfeConversaoMDFe;

Type
  TCertificado = Class(TComponent)

  private
    FSSLLib: TSSLLib;
    FSSLXmlSignLib: TSSLXmlSignLib;
    FSSLCryptLib: TSSLCryptLib;
    FSSLType: TSSLType;
    FDataVencimento: TDAte;
    FNumero: String;
    FSenha: String;
    FSSLHttpLib: TSSLHttpLib;
    procedure SetFDataVencimento(const Value: TDAte);
    procedure SetFNumero(const Value: String);
    procedure SetFSenha(const Value: String);
    procedure setFSSLCryptLib(const Value: TSSLCryptLib);
    procedure setFSSLHttpLib(const Value: TSSLHttpLib);
    procedure setfSSLLib(const Value: TSSLLib);
    procedure setFSSLType(const Value: TSSLType);
    procedure setFSSLXmlSignLib(const Value: TSSLXmlSignLib);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Numero : String read FNumero write SetFNumero;
    property Senha : String read FSenha write SetFSenha;
    property DataVencimento : TDAte read FDataVencimento write SetFDataVencimento;
    property SSLLib: TSSLLib read FSSLLib write setfSSLLib;
    property SSLCryptLib: TSSLCryptLib read FSSLCryptLib write setFSSLCryptLib;
    property SSLHttpLib: TSSLHttpLib read FSSLHttpLib write setFSSLHttpLib;
    property SSLXmlSignLib: TSSLXmlSignLib read FSSLXmlSignLib write setFSSLXmlSignLib;
    property SSLType: TSSLType read FSSLType write setFSSLType;

  End;

implementation

uses      Un_Regra_Negocio, UN_Sistema, Un_DM;

{ TCertificado }

constructor TCertificado.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TCertificado.Destroy;
begin
  inherited;
end;



procedure TCertificado.SetFDataVencimento(const Value: TDAte);
begin
  FDataVencimento := Value;
end;

procedure TCertificado.SetFNumero(const Value: String);
begin
  FNumero := Value;
end;

procedure TCertificado.SetFSenha(const Value: String);
begin
  FSenha := Value;
end;

procedure TCertificado.setFSSLCryptLib(const Value: TSSLCryptLib);
begin
  FSSLCryptLib := Value;
end;

procedure TCertificado.setFSSLHttpLib(const Value: TSSLHttpLib);
begin
  FSSLHttpLib := Value;
end;

procedure TCertificado.setfSSLLib(const Value: TSSLLib);
begin
  FSSLLib := Value;
end;

procedure TCertificado.setFSSLType(const Value: TSSLType);
begin
  FSSLType := Value;
end;

procedure TCertificado.setFSSLXmlSignLib(const Value: TSSLXmlSignLib);
begin
  FSSLXmlSignLib := Value;
end;

end.
