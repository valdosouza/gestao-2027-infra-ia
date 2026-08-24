unit sea_production;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Un_Fm_ListaProdutos, STQuery;

type
  TSeaProduction = class(TBaseSearch)
    Label1: TLabel;
    Label6: TLabel;
    edCod: TEdit;
    Cb_Situacao: TComboBox;
    Fm_ListaProdutos: TFm_ListaProdutos;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    cbDatas: TComboBox;
    Label8: TLabel;
    cds_searchORP_DTCAD: TDateField;
    cds_searchORP_DTPREV: TDateField;
    cds_searchORP_INDSIT: TWideStringField;
    cds_searchORP_CODPRO: TIntegerField;
    cds_searchORP_QTDPREV: TBCDField;
    cds_searchORP_DTINI: TDateTimeField;
    cds_searchORP_DTFIM: TDateTimeField;
    cds_searchORP_QTDREAL: TBCDField;
    cds_searchPRO_DESCRICAO: TWideStringField;
    cds_searchORP_CODIGO: TIntegerField;
    cds_searchORP_NUMERO: TWideStringField;
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
  SeaProduction: TSeaProduction;

implementation

{$R *.dfm}

uses     Un_DM, UN_Principal, env, tas_production, Un_Sistema;
procedure TSeaProduction.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TSeaProduction.GetView;
Var
  Lc_Form : TTasProduction;
begin
  Try
    Lc_Form := TTasProduction.create(nil);
    Lc_Form.CodigoRegistro := cds_searchORP_CODIGO.AsInteger;
    Lc_Form.showModal;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TSeaProduction.IniciaVariaveis;
begin
  inherited;
  ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_ DT_PESQUISA','S') = 'S');
  E_Data_Ini.DateTime := Date;
  E_Data_Fim.DateTime := Date;
end;

procedure TSeaProduction.InnerJoinSql;
begin
  InnerJoinTxt := Concat(
                    '  INNER JOIN TB_PRODUTO           ',
                    '  ON ( PRO_CODIGO=ORP_CODPRO )    '
                  );

end;

procedure TSeaProduction.OrderBySql;
begin
  OrderByTxt := Concat(
                  'Order by ORP_DTCAD '
                );
end;


procedure TSeaProduction.SelectSql;
begin
  SelectTxt := Concat(
                 'select ORP_CODIGO, ORP_NUMERO,ORP_DTCAD,ORP_DTPREV,ORP_INDSIT,        ',
                 'ORP_CODPRO, ORP_QTDPREV, ORP_DTINI,ORP_DTFIM,             ',
                 'ORP_QTDREAL,PRO_DESCRICAO                                 ',
                 ' FROM TB_ORP                                              '
                )
end;

procedure TSeaProduction.SetParameters(Param: TSTQuery);
begin
  with Param do
  Begin
    ParamByName('ORP_CODMHA').AsInteger := GB_CODMHA;

    if ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
      ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
    End;

    if Cb_Situacao.itemindex > 0 then
    Begin
      case Cb_Situacao.ItemIndex of
        1:ParamByName('ORP_INDSIT').AsString := 'A';
        2:ParamByName('ORP_INDSIT').AsString := 'I';
        3:ParamByName('ORP_INDSIT').AsString := 'P';
        4:ParamByName('ORP_INDSIT').AsString := 'F';
      end;
    End;

    if edCod.text <> '' then
      ParamByName('ORP_NUMERO').AsString := edCod.text;

    if Trim(Fm_ListaProdutos.E_Cd_Produto.Text) <> '' then
      ParamByName('ORP_CODPRO').AsString := Fm_ListaProdutos.E_Cd_Produto.Text;
  End;
end;

procedure TSeaProduction.SetRegister;
Var
  Lc_Form : TTasProduction;
begin
  Try
    Lc_Form := TTasProduction.create(nil);
    Lc_Form.CodigoRegistro := 0;
    Lc_Form.showModal;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TSeaProduction.WhereSql;
Var
  campo : String;
begin
  WhereTxt := Concat(
                'Where ( ORP_CODMHA=:ORP_CODMHA ) '
              );

  if ChBx_Periodo.Checked then
  Begin
    Case cbDatas.itemindex of
      0: campo := ' AND ( ORP_DTCAD BETWEEN :DATAINI AND :DATAFIM )';
      1: campo := ' AND ( ORP_DTPREV BETWEEN :DATAINI AND :DATAFIM )';
      2: campo := ' AND ( ORP_DTINI  BETWEEN :DATAINI AND :DATAFIM )';
      3: campo := ' AND ( ORP_DTFIM  BETWEEN :DATAINI AND :DATAFIM )';
    end;
    WhereTxt := Concat(
                  WhereTxt,
                  Campo
                );
  End;
  if Cb_Situacao.itemindex > 0 then
  Begin
    WhereTxt := Concat(
                  WhereTxt,
                  ' and ( ORP_INDSIT =:ORP_INDSIT ) '
                );
  End;

  if edCod.text <> '' then
  Begin
    WhereTxt := Concat(
                  WhereTxt,
                  ' and (ORP_NUMERO =:ORP_NUMERO )'
                );
  End;
  if Trim(Fm_ListaProdutos.E_Cd_Produto.Text) <> '' then
  Begin
    WhereTxt := Concat(
                  WhereTxt,
                  ' and (ORP_CODPRO =:ORP_CODPRO )'
                );
  End;
end;

end.

