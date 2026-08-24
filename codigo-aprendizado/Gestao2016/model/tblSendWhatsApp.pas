unit tblSendWhatsApp;

interface

Uses     GenericEntity, CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_SEND_WHATSAPP')]
  TSendWhatsApp = Class(TGenericEntity)
  private
    FPATH_FILE: String;
    FID: Integer;
    FSTATUS: String;
    FHR_SENT: TDateTime;
    FTB_INSTITUTION_ID: Integer;
    FNOTE: String;
    FNUMBER_SEND: String;
    procedure setFHR_SENT(const Value: TDateTime);
    procedure setFID(const Value: Integer);
    procedure setFNOTE(const Value: String);
    procedure setFNUMBER_SEND(const Value: String);
    procedure setFPATH_FILE(const Value: String);
    procedure setFSTATUS(const Value: String);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);

  public

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento : Integer  read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer  read FID write setFID;

    [FieldName('NUMBER_SEND')]
    property NumeroEnviado: String  read FNUMBER_SEND write setFNUMBER_SEND;

    [FieldName('NOTE')]
    property Mensagem: String  read FNOTE write setFNOTE;

    [FieldName('PATH_FILE')]
    property PathFile: String read FPATH_FILE write setFPATH_FILE;

    [FieldName('HR_SENT')]
    property HoraEnviada: TDateTime  read FHR_SENT write setFHR_SENT;

    [FieldName('STATUS')]
    property Situacao: String  read FSTATUS write setFSTATUS;

  End;

implementation


{ TSendWhatsApp }

procedure TSendWhatsApp.setFHR_SENT(const Value: TDateTime);
begin
  FHR_SENT := Value;
end;

procedure TSendWhatsApp.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TSendWhatsApp.setFNOTE(const Value: String);
begin
  FNOTE := Value;
end;

procedure TSendWhatsApp.setFNUMBER_SEND(const Value: String);
begin
  FNUMBER_SEND := Value;
end;

procedure TSendWhatsApp.setFPATH_FILE(const Value: String);
begin
  FPATH_FILE := Value;
end;

procedure TSendWhatsApp.setFSTATUS(const Value: String);
begin
  FSTATUS := Value;
end;

procedure TSendWhatsApp.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

end.
