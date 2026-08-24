unit tblCfgGrid;

interface

Uses     GenericEntity, CAtribEntity, System.Classes, System.SysUtils;

Type
  [TableName('TB_CFG_GRID')]
  TCfgGrid = Class(TGenericEntity)
  private
    FCFG_CODIGO: Integer;
    FCFG_CODUSU: Integer;
    FCFG_IDGRID: Integer;
    FCFG_CAMPO: String;
    FCFG_LABEL: String;
    FCFG_LARGURA: Integer;
    FCFG_POSICAO: Integer;
    FCFG_VISIBLE: String;
    procedure setFCFG_CAMPO(const Value: String);
    procedure setFCFG_CODIGO(const Value: Integer);
    procedure setFCFG_CODUSU(const Value: Integer);
    procedure setFCFG_IDGRID(const Value: Integer);
    procedure setFCFG_LABEL(const Value: String);
    procedure setFCFG_LARGURA(const Value: Integer);
    procedure setFCFG_POSICAO(const Value: Integer);
    procedure setFCFG_VISIBLE(const Value: String);

  public
    [KeyField('CFG_CODIGO')]
    [FieldName('CFG_CODIGO')]
    property Codigo: Integer read FCFG_CODIGO write setFCFG_CODIGO;

    [FieldName('CFG_CODUSU')]
    property Usuario: Integer read FCFG_CODUSU write setFCFG_CODUSU;

    [FieldName('CFG_IDGRID')]
    property IdGrid: Integer read FCFG_IDGRID write setFCFG_IDGRID;

    [FieldName('CFG_CAMPO')]
    property Campo: String read FCFG_CAMPO write setFCFG_CAMPO;

    [FieldName('CFG_LABEL')]
    property Legenda: String read FCFG_LABEL write setFCFG_LABEL;

    [FieldName('CFG_LARGURA')]
    property Largura: Integer read FCFG_LARGURA write setFCFG_LARGURA;

    [FieldName('CFG_POSICAO')]
    property Posicao: Integer read FCFG_POSICAO write setFCFG_POSICAO;

    [FieldName('CFG_VISIBLE')]
    property Visivel: String read FCFG_VISIBLE write setFCFG_VISIBLE;
  End;

implementation

{ TCfgGrid }

procedure TCfgGrid.setFCFG_CAMPO(const Value: String);
begin
  FCFG_CAMPO := Value;
end;

procedure TCfgGrid.setFCFG_CODIGO(const Value: Integer);
begin
  FCFG_CODIGO := Value;
end;

procedure TCfgGrid.setFCFG_CODUSU(const Value: Integer);
begin
  FCFG_CODUSU := Value;
end;

procedure TCfgGrid.setFCFG_IDGRID(const Value: Integer);
begin
  FCFG_IDGRID := Value;
end;

procedure TCfgGrid.setFCFG_LABEL(const Value: String);
begin
  FCFG_LABEL := Value;
end;

procedure TCfgGrid.setFCFG_LARGURA(const Value: Integer);
begin
  FCFG_LARGURA := Value;
end;

procedure TCfgGrid.setFCFG_POSICAO(const Value: Integer);
begin
  FCFG_POSICAO := Value;
end;

procedure TCfgGrid.setFCFG_VISIBLE(const Value: String);
begin
  FCFG_VISIBLE := Value;
end;

end.
