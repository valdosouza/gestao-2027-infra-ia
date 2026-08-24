unit tblItensInd;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_ITENS_IND')]
  TItensInd = Class(TGenericEntity)
  private
    FIIN_CODIGO: Integer;
    FIIN_CODIND: Integer;
    FIIN_CODPED: Integer;
    FIIN_CODNFL: Integer;
    FIIN_CODPRO: Integer;
    FIIN_QTDE: Real;
    FIIN_VL_UNIT: Real;
    procedure setFIIN_CODIGO(const Value: Integer);
    procedure setFIIN_CODIND(const Value: Integer);
    procedure setFIIN_CODPED(const Value: Integer);
    procedure setFIIN_CODNFL(const Value: Integer);
    procedure setFIIN_CODPRO(const Value: Integer);
    procedure setFIIN_QTDE(const Value: Real);
    procedure setFIIN_VL_UNIT(const Value: Real);
  public
    [KeyField('IIN_CODIGO')]
    [FieldName('IIN_CODIGO')]
    property Codigo: Integer read FIIN_CODIGO write setFIIN_CODIGO;

    [FieldName('IIN_CODIND')]
    property CodigoIndustrializa: Integer read FIIN_CODIND write setFIIN_CODIND;

    [FieldName('IIN_CODPED')]
    property CodigoPedido: Integer read FIIN_CODPED write setFIIN_CODPED;

    [FieldName('IIN_CODNFL')]
    property CodigoNota: Integer read FIIN_CODNFL write setFIIN_CODNFL;

    [FieldName('IIN_CODPRO')]
    property CodigoProduto: Integer read FIIN_CODPRO write setFIIN_CODPRO;

    [FieldName('IIN_QTDE')]
    property Quantidade: Real read FIIN_QTDE write setFIIN_QTDE;

    [FieldName('IIN_VL_UNIT')]
    property ValorUnitario: Real read FIIN_VL_UNIT write setFIIN_VL_UNIT;
  End;

implementation

procedure TItensInd.setFIIN_CODIGO(const Value: Integer);
begin
  FIIN_CODIGO := Value;
end;

procedure TItensInd.setFIIN_CODIND(const Value: Integer);
begin
  FIIN_CODIND := Value;
end;

procedure TItensInd.setFIIN_CODPED(const Value: Integer);
begin
  FIIN_CODPED := Value;
end;

procedure TItensInd.setFIIN_CODNFL(const Value: Integer);
begin
  FIIN_CODNFL := Value;
end;

procedure TItensInd.setFIIN_CODPRO(const Value: Integer);
begin
  FIIN_CODPRO := Value;
end;

procedure TItensInd.setFIIN_QTDE(const Value: Real);
begin
  FIIN_QTDE := Value;
end;

procedure TItensInd.setFIIN_VL_UNIT(const Value: Real);
begin
  FIIN_VL_UNIT := Value;
end;

end.
