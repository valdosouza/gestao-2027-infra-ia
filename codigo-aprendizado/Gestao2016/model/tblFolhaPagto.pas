unit tblFolhaPagto;

interface

Uses     GenericEntity, CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_FOLHAPAGTO')]
  TFolhaPagto = Class(TGenericEntity)
  private
    FFPT_HISTORICO: String;
    FFPT_VL_DEBITO: Real;
    FFPT_CODIGO: Integer;
    FFPT_MES: Integer;
    FFPT_CODCLB: Integer;
    FFPT_ANO: Integer;
    FFPT_CODMHA: Integer;
    FFPT_VL_CREDITO: Real;
    FFPT_DATA: TDAte;
    procedure setFFPT_ANO(const Value: Integer);
    procedure setFFPT_CODCLB(const Value: Integer);
    procedure setFFPT_CODIGO(const Value: Integer);
    procedure setFFPT_CODMHA(const Value: Integer);
    procedure setFFPT_DATA(const Value: TDAte);
    procedure setFFPT_HISTORICO(const Value: String);
    procedure setFFPT_MES(const Value: Integer);
    procedure setFFPT_VL_CREDITO(const Value: Real);
    procedure setFFPT_VL_DEBITO(const Value: Real);

  public
    [KeyField('FPT_CODIGO')]
    [FieldName('FPT_CODIGO')]
    property Codigo: Integer  read FFPT_CODIGO write setFFPT_CODIGO ;

    [FieldName('FPT_CODCLB')]
    property Colaborador: Integer  read FFPT_CODCLB write setFFPT_CODCLB ;

    [FieldName('FPT_DATA')]
    property Data: TDAte  read FFPT_DATA write setFFPT_DATA ;

    [FieldName('FPT_MES')]
    property Mes: Integer read FFPT_MES write setFFPT_MES ;

    [FieldName('FPT_ANO')]
    property Ano: Integer  read FFPT_ANO write setFFPT_ANO ;

    [FieldName('FPT_HISTORICO')]
    property Historico: String  read FFPT_HISTORICO write setFFPT_HISTORICO ;

    [FieldName('FPT_VL_CREDITO')]
    property Credito: Real  read FFPT_VL_CREDITO write setFFPT_VL_CREDITO ;

    [FieldName('FPT_VL_DEBITO')]
    property Debito: Real  read FFPT_VL_DEBITO write setFFPT_VL_DEBITO ;

    [FieldName('FPT_CODMHA')]
    property Estabelecimento: Integer  read FFPT_CODMHA write setFFPT_CODMHA ;


  End;


implementation

{ TFolhaPagto }

procedure TFolhaPagto.setFFPT_ANO(const Value: Integer);
begin
  FFPT_ANO := Value;
end;

procedure TFolhaPagto.setFFPT_CODCLB(const Value: Integer);
begin
  FFPT_CODCLB := Value;
end;

procedure TFolhaPagto.setFFPT_CODIGO(const Value: Integer);
begin
  FFPT_CODIGO := Value;
end;

procedure TFolhaPagto.setFFPT_CODMHA(const Value: Integer);
begin
  FFPT_CODMHA := Value;
end;

procedure TFolhaPagto.setFFPT_DATA(const Value: TDAte);
begin
  FFPT_DATA := Value;
end;

procedure TFolhaPagto.setFFPT_HISTORICO(const Value: String);
begin
  FFPT_HISTORICO := Value;
end;

procedure TFolhaPagto.setFFPT_MES(const Value: Integer);
begin
  FFPT_MES := Value;
end;

procedure TFolhaPagto.setFFPT_VL_CREDITO(const Value: Real);
begin
  FFPT_VL_CREDITO := Value;
end;

procedure TFolhaPagto.setFFPT_VL_DEBITO(const Value: Real);
begin
  FFPT_VL_DEBITO := Value;
end;

end.
