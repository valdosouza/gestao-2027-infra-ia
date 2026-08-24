unit ControllerMvaUfNcm;

interface

uses     System.Classes, System.SysUtils, Generics.Collections, STQuery, ControllerBase, tblMvaUfNcm, prm_mva_uf_ncm;

Type
  TListaMVA = TObjectList<TMvaUfNcm>;

  TControllerMvaUfNcm = Class(TControllerBase)

  private
    FParametros: TPrmMvaUFNcm;
    procedure setFParametros(const Value: TPrmMvaUFNcm);

  protected

  public
    Registro : TMvaUfNcm;
    Lista : TListaMVA;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    procedure insert;
    procedure update;
    procedure save;
    procedure delete;
    procedure clear;
    procedure Search;
    property Parametros : TPrmMvaUFNcm read FParametros write setFParametros;
  End;


implementation

{ TControllerMvaUfNcm }

procedure TControllerMvaUfNcm.clear;
begin
  ClearObj(Registro);
end;

constructor TControllerMvaUfNcm.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMvaUfNcm.Create;
  Lista := TListaMVA.Create;
  FParametros := TPrmMvaUFNcm.Create;
end;

procedure TControllerMvaUfNcm.delete;
begin
  DeleteObj(Registro);
end;

destructor TControllerMvaUfNcm.Destroy;
begin
  FreeAndNil( Registro );
  FreeAndNil( Lista );
  FreeAndNil( FParametros );
  inherited;
end;

procedure TControllerMvaUfNcm.getbyId;
begin
  _getByKey(Registro);
end;

procedure TControllerMvaUfNcm.insert;
begin
  insertObj(Registro);
end;

procedure TControllerMvaUfNcm.save;
begin
  saveObj(Registro);
end;

procedure TControllerMvaUfNcm.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TMvaUfNcm;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.add(concat(
                'SELECT * ',
                'FROM TB_MVA_UF_NCM ',
                'WHERE MUN_CODUFE=:UFE_CODIGO ',
                'and MUN_CODMHA=:MUN_CODMHA '
      ));
      ParamByName('UFE_CODIGO').AsInteger := FParametros.FieldName.CodigoUF;
      ParamByName('MUN_CODMHA').AsInteger := FParametros.FieldName.Estabelecimento;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TMvaUfNcm.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerMvaUfNcm.setFParametros(const Value: TPrmMvaUFNcm);
begin
  FParametros := Value;
end;

procedure TControllerMvaUfNcm.update;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.add(concat(
                'update TB_MVA_UF_NCM ',
                'set ',
                '  MUN_CODIGONCM = :MUN_CODIGONCM, ',
                '  MUN_MR_VL_AGREGADO = :MUN_MR_VL_AGREGADO, ',
                '  MUN_MVA_AJUSTADO=:MUN_MVA_AJUSTADO, ',
                '  MUN_ALIQ_INTERNA =:MUN_ALIQ_INTERNA ',
                'where ',
                '  MUN_CODUFE = :MUN_CODUFE and ',
                '  MUN_CODIGONCM = :OLD_MUN_CODIGONCM AND ',
                '  MUN_CODMHA =:MUN_CODMHA '
      ));
      ParamByName('MUN_CODUFE').AsInteger := Registro.CodigoUF;
      ParamByName('MUN_CODMHA').AsInteger := Registro.Estabelecimento;
      ParamByName('MUN_CODIGONCM').AsString := Registro.NCM;

      ParamByName('MUN_MR_VL_AGREGADO').AsCurrency := Registro.MVA;
      ParamByName('MUN_MVA_AJUSTADO').AsFloat := Registro.MvaAjustado;
      ParamByName('MUN_ALIQ_INTERNA').AsFloat := Registro.AliqInterna;
      ParamByName('OLD_MUN_CODIGONCM').AsString := Registro.OldNCM;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
