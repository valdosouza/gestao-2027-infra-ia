unit tblIfood;

interface

Uses     GenericEntity, CAtribEntity, Classes, SysUtils, System.DateUtils;
Type
  //nome da classe de entidade
  [TableName('TB_IFOOD')]
  TIFood = Class(TGenericEntity)
  private
    FREFRESH_TOKEN: String;
    FSH_ID: String;
    FMERCHANT_ID: String;
    FCLIENT_SECRET: String;
    FTB_INSTITUTION_ID: Integer;
    FCLIENT_ID: String;
    FAUTHORIZATION_CODE: String;
    FKIND_RECORD_ORDER: String;
    procedure setFCLIENT_ID(const Value: String);
    procedure setFCLIENT_SECRET(const Value: String);
    procedure setFMERCHANT_ID(const Value: String);
    procedure setFREFRESH_TOKEN(const Value: String);
    procedure setFSH_ID(const Value: String);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFAUTHORIZATION_CODE(const Value: String);
    procedure setFKIND_RECORD_ORDER(const Value: String);

  public


    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [FieldName('CLIENT_ID')]
    property ClienteID: String read FCLIENT_ID write setFCLIENT_ID;

    [FieldName('CLIENT_SECRET')]
    property ClientSecret: String read FCLIENT_SECRET write setFCLIENT_SECRET;

    [FieldName('REFRESH_TOKEN')]
    property RefreshToken: String read FREFRESH_TOKEN write setFREFRESH_TOKEN;

    [FieldName('SH_ID')]
    property SoftwareHouseId: String read FSH_ID write setFSH_ID;

    [FieldName('MERCHANT_ID')]
    property MerchantId: String read FMERCHANT_ID write setFMERCHANT_ID;

    [FieldName('AUTHORIZATION_CODE')]
    property AuthotizationCode: String read FAUTHORIZATION_CODE write setFAUTHORIZATION_CODE;


    [FieldName('KIND_RECORD_ORDER')]
    property TipoGRavacaoPedido: String read FKIND_RECORD_ORDER write setFKIND_RECORD_ORDER;

  End;
implementation

{ TIFood }

procedure TIFood.setFAUTHORIZATION_CODE(const Value: String);
begin
  FAUTHORIZATION_CODE := Value;
end;

procedure TIFood.setFCLIENT_ID(const Value: String);
begin
  FCLIENT_ID := Value;
end;

procedure TIFood.setFCLIENT_SECRET(const Value: String);
begin
  FCLIENT_SECRET := Value;
end;

procedure TIFood.setFKIND_RECORD_ORDER(const Value: String);
begin
  FKIND_RECORD_ORDER := Value;
end;

procedure TIFood.setFMERCHANT_ID(const Value: String);
begin
  FMERCHANT_ID := Value;
end;

procedure TIFood.setFREFRESH_TOKEN(const Value: String);
begin
  FREFRESH_TOKEN := Value;
end;

procedure TIFood.setFSH_ID(const Value: String);
begin
  FSH_ID := Value;
end;

procedure TIFood.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

end.
