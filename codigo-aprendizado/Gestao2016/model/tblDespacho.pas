unit tblDespacho;

interface

Uses     GenericEntity, CAtribEntity, System.Classes, System.SysUtils;

Type
  [TableName('tb_despacho')]
  TDespacho = Class(TGenericEntity)

  private
    Fdsp_codigo: Integer;
    Fdsp_coditf: Integer;
    Fdsp_dt_prevista: TDate;
    Fdsp_qtde: Real;
    Fdsp_dt_realizada: TDate;
    Fdsp_codped: Integer;
    Fdsp_codpro: Integer;
    Fdsp_situacao: String;
    Fdsp_impresso: String;
    Fdsp_conferido: Real;
    procedure setFdsp_codigo(const Value: Integer);
    procedure setFdsp_coditf(const Value: Integer);
    procedure setFdsp_dt_prevista(const Value: TDate);
    procedure setFdsp_qtde(const Value: Real);
    procedure setFdsp_dt_realizada(const Value: TDate);
    procedure setFdsp_codped(const Value: Integer);
    procedure setFdsp_codpro(const Value: Integer);
    procedure setFdsp_situacao(const Value: String);
    procedure setFdsp_impresso(const Value: String);
    procedure setFdsp_conferido(const Value: Real);

  public
    [FieldName('dsp_codigo')]
    [KeyField('dsp_codigo')]
    property Codigo: Integer read Fdsp_codigo write setFdsp_codigo;

    [FieldName('dsp_coditf')]
    property ItemPedido: Integer read Fdsp_coditf write setFdsp_coditf;

    [FieldName('dsp_dt_prevista')]
    property DataPrevista: TDate read Fdsp_dt_prevista write setFdsp_dt_prevista;

    [FieldName('dsp_qtde')]
    property Qtde: Real read Fdsp_qtde write setFdsp_qtde;

    [FieldName('dsp_dt_realizada')]
    property DataRealizada: TDate read Fdsp_dt_realizada write setFdsp_dt_realizada;

    [FieldName('dsp_codped')]
    property Pedido: Integer read Fdsp_codped write setFdsp_codped;

    [FieldName('dsp_codpro')]
    property Produto: Integer read Fdsp_codpro write setFdsp_codpro;

    [FieldName('dsp_situacao')]
    property Situacao: String read Fdsp_situacao write setFdsp_situacao;

    [FieldName('dsp_impresso')]
    property Impresso: String read Fdsp_impresso write setFdsp_impresso;

    [FieldName('dsp_conferido')]
    property Conferido: Real read Fdsp_conferido write setFdsp_conferido;

  End;

implementation

{ TDespacho }

procedure TDespacho.setFdsp_codigo(const Value: Integer);
begin
  Fdsp_codigo := Value;
end;

procedure TDespacho.setFdsp_coditf(const Value: Integer);
begin
  Fdsp_coditf := Value;
end;

procedure TDespacho.setFdsp_dt_prevista(const Value: TDate);
begin
  Fdsp_dt_prevista := Value;
end;

procedure TDespacho.setFdsp_qtde(const Value: Real);
begin
  Fdsp_qtde := Value;
end;

procedure TDespacho.setFdsp_dt_realizada(const Value: TDate);
begin
  Fdsp_dt_realizada := Value;
end;

procedure TDespacho.setFdsp_codped(const Value: Integer);
begin
  Fdsp_codped := Value;
end;

procedure TDespacho.setFdsp_codpro(const Value: Integer);
begin
  Fdsp_codpro := Value;
end;

procedure TDespacho.setFdsp_situacao(const Value: String);
begin
  Fdsp_situacao := Value;
end;

procedure TDespacho.setFdsp_impresso(const Value: String);
begin
  Fdsp_impresso := Value;
end;

procedure TDespacho.setFdsp_conferido(const Value: Real);
begin
  Fdsp_conferido := Value;
end;

end.
