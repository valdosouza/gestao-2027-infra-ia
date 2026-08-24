unit tblAssistencia;

interface

Uses     GenericEntity, CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_assistencia')]
  TAssistencia = Class(TGenericEntity)

  private
    FSituacaoId: Integer;
    Fass_codemp: Integer;
    Fass_pedido: Integer;
    Fass_codmha: Integer;
    Fass_codigo: Integer;
    FApelidoFantasia: String;
    Fass_prazo: TDate;
    FSituacaoDesc: String;
    Fass_numero: Integer;
    FNomeRazao: String;
    procedure setFApelidoFantasia(const Value: String);
    procedure setFass_codemp(const Value: Integer);
    procedure setFass_codigo(const Value: Integer);
    procedure setFass_codmha(const Value: Integer);
    procedure setFass_numero(const Value: Integer);
    procedure setFass_pedido(const Value: Integer);
    procedure setFass_prazo(const Value: TDate);
    procedure setFNomeRazao(const Value: String);
    procedure setFSituacaoDesc(const Value: String);
    procedure setFSituacaoId(const Value: Integer);

   public
    [FieldName('ass_codigo')]
    [KeyField('ass_codigo')]
    property Codigo: Integer read Fass_codigo write setFass_codigo;

    [KeyField('ass_codmha')]
    [FieldName('ass_codmha')]
    property CodMha: Integer read Fass_codmha write setFass_codmha;

    [FieldName('ass_numero')]
    property Numero: Integer read Fass_numero write setFass_numero;

   [FieldName('ass_pedido')]
    property Pedido: Integer read Fass_pedido write setFass_pedido;

    [FieldName('ass_codemp')]
    property Codemp: Integer read Fass_codemp write setFass_codemp;

    [FieldName('ass_prazo')]
    property Prazo: TDate read Fass_prazo write setFass_prazo;

    property NomeRazao : String read FNomeRazao write setFNomeRazao;

    property ApelidoFantasia : String read FApelidoFantasia write setFApelidoFantasia;

    property SituacaoId : Integer read FSituacaoId write setFSituacaoId;

    property SituacaoDesc : String read FSituacaoDesc write setFSituacaoDesc;
  End;

  implementation


{ TAssistencia }

procedure TAssistencia.setFApelidoFantasia(const Value: String);
begin
  FApelidoFantasia := Value;
end;

procedure TAssistencia.setFass_codemp(const Value: Integer);
begin
  Fass_codemp := Value;
end;

procedure TAssistencia.setFass_codigo(const Value: Integer);
begin
  Fass_codigo := Value;
end;

procedure TAssistencia.setFass_codmha(const Value: Integer);
begin
  Fass_codmha := Value;
end;

procedure TAssistencia.setFass_numero(const Value: Integer);
begin
  Fass_numero := Value;
end;

procedure TAssistencia.setFass_pedido(const Value: Integer);
begin
  Fass_pedido := Value;
end;

procedure TAssistencia.setFass_prazo(const Value: TDate);
begin
  Fass_prazo := Value;
end;

procedure TAssistencia.setFNomeRazao(const Value: String);
begin
  FNomeRazao := Value;
end;

procedure TAssistencia.setFSituacaoDesc(const Value: String);
begin
  FSituacaoDesc := Value;
end;

procedure TAssistencia.setFSituacaoId(const Value: Integer);
begin
  FSituacaoId := Value;
end;

end.
