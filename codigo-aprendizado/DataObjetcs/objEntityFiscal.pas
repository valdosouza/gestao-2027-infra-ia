unit objEntityFiscal;

interface

uses tblPerson, tblCompany,tblnoDocNumber,objEntity, System.Classes,
  System.SysUtils,ObjBase;

Type

  TObjEntityFiscal = Class (TObjBase)
  private
    FEntidade: TObjEntity;
    FJuridica: TCompany;
    FFisica: TPerson;
    FNoDocNumber: TNoDocNumber;

    procedure setFEntidade(const Value: TObjEntity);
    procedure setFFisica(const Value: TPerson);
    procedure setFJuridica(const Value: TCompany);
    procedure setFNoDocNumber(const Value: TNoDocNumber);
  public
    constructor Create; override;
    destructor Destroy;override;
    procedure clear;
    property Entidade : TObjEntity read FEntidade write setFEntidade;
    property Fisica : TPerson read FFisica write setFFisica;
    property Juridica : TCompany read FJuridica write setFJuridica;
    property NoDocNumber : TNoDocNumber read FNoDocNumber write setFNoDocNumber;
  End;

implementation

{ TObjEntityFiscal }

uses GenericDao;


procedure TObjEntityFiscal.clear;
begin
  TGenericDAO._Clear(FEntidade);
  TGenericDAO._Clear(FJuridica);
  TGenericDAO._Clear(FFisica);
end;

constructor TObjEntityFiscal.Create;
begin
  FEntidade := TObjEntity.Create;
  FJuridica := TCompany.Create;
  FFisica   := TPerson.Create;
end;

destructor TObjEntityFiscal.Destroy;
begin
  {$IFDEF WIN32}
  FreeAndNil(FEntidade);
  FreeAndNil(FJuridica);
  FreeAndNil(FFisica);
  {$ENDIF }
end;


procedure TObjEntityFiscal.setFEntidade(const Value: TObjEntity);
begin
  FEntidade := Value;
end;

procedure TObjEntityFiscal.setFFisica(const Value: TPerson);
begin
  FFisica := Value;
end;

procedure TObjEntityFiscal.setFJuridica(const Value: TCompany);
begin
  FJuridica := Value;
end;

procedure TObjEntityFiscal.setFNoDocNumber(const Value: TNoDocNumber);
begin
  FNoDocNumber := Value;
end;

end.
