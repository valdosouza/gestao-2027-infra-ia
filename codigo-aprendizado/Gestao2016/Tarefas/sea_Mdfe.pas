unit sea_Mdfe;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, base_search, STQuery, Vcl.Menus, Vcl.Grids, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Mask, Datasnap.Provider, Datasnap.DBClient, Vcl.DBGrids;

type
  TSeaMdfe = class(TBaseSearch)
    ChBx_Periodo: TCheckBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Label1: TLabel;
    E_BuscaMdfe: TEdit;
    cds_searchID: TIntegerField;
    cds_searchNUMBER: TWideStringField;
    cds_searchDT_EMISSION: TDateTimeField;
    Rg_Situacao: TRadioGroup;
    procedure ChBx_PeriodoClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBySql;Override;
    procedure SetParameters(Param: TSTQuery);Override;
    procedure GetView;Override;
    procedure SetRegister;Override;
  public
    { Public declarations }
  end;

var
  SeaMdfe: TSeaMdfe;

implementation

{$R *.dfm}

uses     Un_DM, UN_Principal, env, tas_mdfe;
procedure TSeaMdfe.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TSeaMdfe.GetView;
Var
  Lc_Form : TTasMdfe;
begin
  Try
    Lc_Form := TTasMdfe.create(nil);
    Lc_Form.CodigoRegistro := cds_searchID.AsInteger;
    Lc_Form.showModal;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TSeaMdfe.IniciaVariaveis;
begin
  inherited;
  E_Data_Ini.DateTime := Date;
  E_Data_Fim.DateTime := Date;
end;

procedure TSeaMdfe.InnerJoinSql;
begin
  InnerJoinTxt :=  InnerJoinTxt +
                         '  INNER JOIN TB_MDFE_RETORNO mr '+
                         '  ON (mr.TB_MDFE_ID = m.ID) ';
end;

procedure TSeaMdfe.OrderBySql;
begin
  OrderByTxt := Concat(
                  'Order by NUMBER '
                );
end;

procedure TSeaMdfe.SelectSql;
begin
  SelectTxt := Concat(
                 'select ID, NUMBER, DT_EMISSION        ',
                 ' FROM TB_MDFE m                        '
                )
end;

procedure TSeaMdfe.SetParameters(Param: TSTQuery);
begin
  with Param do
  Begin
    ParamByName('TB_INSTITUTION_ID').AsInteger := GB_CODMHA;

  if Rg_Situacao.ItemIndex < 5 then
  Begin
    ParamByName('TB_SITUATION_ID').AsInteger := Rg_Situacao.ItemIndex;
  End;


    if ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
      ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
    End;

    if E_BuscaMdfe.text <> '' then
      ParamByName('NUMBER').AsString := E_BuscaMdfe.text;
  End;
end;

procedure TSeaMdfe.SetRegister;
Var
  Lc_Form : TTasMdfe;
begin
  Try
    Lc_Form := TTasMdfe.create(nil);
    Lc_Form.CodigoRegistro := 0;
    Lc_Form.showModal;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TSeaMdfe.WhereSql;
begin
  WhereTxt := Concat(
                'Where ( m.TB_INSTITUTION_ID=:TB_INSTITUTION_ID ) '
               );

  if Rg_Situacao.ItemIndex < 5 then
  Begin
    WhereTxt := Concat(
                  WhereTxt,
                  ' and (mr.TB_SITUATION_ID =:TB_SITUATION_ID)'
                 );
  End;


  if ChBx_Periodo.Checked then
  Begin
    WhereTxt := Concat(
                  WhereTxt,
                ' and ( m.DT_EMISSION BETWEEN :DATAINI AND :DATAFIM )'
                );
  End;
  if E_BuscaMdfe.text <> '' then
  Begin
    WhereTxt := Concat(
                  WhereTxt,
                  ' and (NUMBER =:NUMBER )'
                );
  End;
end;

end.
