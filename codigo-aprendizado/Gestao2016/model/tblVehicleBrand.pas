unit tblVehicleBrand;

interface

Uses     GenericEntity, CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_MARCA_VEICULO')]
  TVehicleBrand = Class(TGenericEntity)
  private
    FMRC_DESCRICAO: String;
    FMarcasVazio: boolean;
    FMRC_CODIGO: Integer;
    FMRC_CODFAB: Integer;
    FModeloDescricao: string;
    FCodigoModelo: Integer;
    procedure setFCodigoModelo(const Value: Integer);
    procedure setFMarcasVazio(const Value: boolean);
    procedure setFModeloDescricao(const Value: string);
    procedure setFMRC_CODFAB(const Value: Integer);
    procedure setFMRC_CODIGO(const Value: Integer);
    procedure setFMRC_DESCRICAO(const Value: String);

  public

    [KeyField('MRC_CODIGO')]
    [FieldName('MRC_CODIGO')]
    property Codigo: Integer read FMRC_CODIGO write setFMRC_CODIGO;

    [FieldName('MRC_DESCRICAO')]
    property Descricao: String read FMRC_DESCRICAO write setFMRC_DESCRICAO;

    [FieldName('MRC_CODFAB')]
    property Fabricante: Integer read FMRC_CODFAB write setFMRC_CODFAB;

    property CodigoModelo : Integer read FCodigoModelo write setFCodigoModelo;
    property ModeloDescricao: string read FModeloDescricao write setFModeloDescricao;
    property MarcasVazio: boolean read FMarcasVazio write setFMarcasVazio;

  End;

implementation

{ TVehicleBrand }

procedure TVehicleBrand.setFCodigoModelo(const Value: Integer);
begin
  FCodigoModelo := Value;
end;

procedure TVehicleBrand.setFMarcasVazio(const Value: boolean);
begin
  FMarcasVazio := Value;
end;

procedure TVehicleBrand.setFModeloDescricao(const Value: string);
begin
  FModeloDescricao := Value;
end;

procedure TVehicleBrand.setFMRC_CODFAB(const Value: Integer);
begin
  FMRC_CODFAB := Value;
end;

procedure TVehicleBrand.setFMRC_CODIGO(const Value: Integer);
begin
  FMRC_CODIGO := Value;
end;

procedure TVehicleBrand.setFMRC_DESCRICAO(const Value: String);
begin
  FMRC_DESCRICAO := Value;
end;

end.
