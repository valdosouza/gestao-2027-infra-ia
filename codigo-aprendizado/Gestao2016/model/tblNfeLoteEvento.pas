unit tblNfeLoteEvento;

interface

uses
      GenericEntity, CAtribEntity;

Type
  [TableName('TB_NFE_LOTE_EVENTO')]
  TNfeLoteEvento = class(TGenericEntity)
  private
    FNLtCodigo: Integer;
    FNLtNumero: string;
    FNLtChave: string;
    FNLtCodnvt: Integer;
    FNLtData: TDateTime;
    FNLtSequencia: string;
    FNLtSitNfe: string;
    FNLtSitConf: string;
    FNLtTpNf: string;
    FNLtJustificativa: string;
    FNLtStatus: string;
    procedure SetNLtCodigo(const Value: Integer);
    procedure SetNLtNumero(const Value: string);
    procedure SetNLtChave(const Value: string);
    procedure SetNLtCodnvt(const Value: Integer);
    procedure SetNLtData(const Value: TDateTime);
    procedure SetNLtSequencia(const Value: string);
    procedure SetNLtSitNfe(const Value: string);
    procedure SetNLtSitConf(const Value: string);
    procedure SetNLtTpNf(const Value: string);
    procedure SetNLtJustificativa(const Value: string);
    procedure SetNLtStatus(const Value: string);
  published
    [KeyField('NLT_CODIGO')]
    [FieldName('NLT_CODIGO')]
    property Codigo: Integer read FNLtCodigo write SetNLtCodigo;

    [FieldName('NLT_NUMERO')]
    property Numero: string read FNLtNumero write SetNLtNumero;

    [FieldName('NLT_CHAVE')]
    property Chave: string read FNLtChave write SetNLtChave;

    [FieldName('NLT_CODNVT')]
    property Codnvt: Integer read FNLtCodnvt write SetNLtCodnvt;

    [FieldName('NLT_DATA')]
    property DataEvento: TDateTime read FNLtData write SetNLtData;

    [FieldName('NLT_SEQUENCIA')]
    property Sequencia: string read FNLtSequencia write SetNLtSequencia;

    [FieldName('NLT_SIT_NFE')]
    property SituacaoNfe: string read FNLtSitNfe write SetNLtSitNfe;

    [FieldName('NLT_SIT_CONF')]
    property SituacaoConfirmacao: string read FNLtSitConf write SetNLtSitConf;

    [FieldName('NLT_TP_NF')]
    property TipoNf: string read FNLtTpNf write SetNLtTpNf;

    [FieldName('NLT_JUSTIFICATIVA')]
    property Justificativa: string read FNLtJustificativa write SetNLtJustificativa;

    [FieldName('NLT_STATUS')]
    property StatusEvento: string read FNLtStatus write SetNLtStatus;
  end;

implementation

{ TNfeLoteEvento }

procedure TNfeLoteEvento.SetNLtCodigo(const Value: Integer);
begin
  FNLtCodigo := Value;
end;

procedure TNfeLoteEvento.SetNLtNumero(const Value: string);
begin
  FNLtNumero := Value;
end;

procedure TNfeLoteEvento.SetNLtChave(const Value: string);
begin
  FNLtChave := Value;
end;

procedure TNfeLoteEvento.SetNLtCodnvt(const Value: Integer);
begin
  FNLtCodnvt := Value;
end;

procedure TNfeLoteEvento.SetNLtData(const Value: TDateTime);
begin
  FNLtData := Value;
end;

procedure TNfeLoteEvento.SetNLtSequencia(const Value: string);
begin
  FNLtSequencia := Value;
end;

procedure TNfeLoteEvento.SetNLtSitNfe(const Value: string);
begin
  FNLtSitNfe := Value;
end;

procedure TNfeLoteEvento.SetNLtSitConf(const Value: string);
begin
  FNLtSitConf := Value;
end;

procedure TNfeLoteEvento.SetNLtTpNf(const Value: string);
begin
  FNLtTpNf := Value;
end;

procedure TNfeLoteEvento.SetNLtJustificativa(const Value: string);
begin
  FNLtJustificativa := Value;
end;

procedure TNfeLoteEvento.SetNLtStatus(const Value: string);
begin
  FNLtStatus := Value;
end;

end.

