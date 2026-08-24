unit sea_ctrl_estoque_zerado;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Un_Fm_ListaEstoques, Un_Fm_ListaProdutos, Vcl.ComCtrls, ControllerCtrlEstoqueZerado, STQuery;

type
  TSeaCtrlEstoqueZerado = class(TBaseSearch)
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Fm_ListaProdutos: TFm_ListaProdutos;
    Fm_ListaEstoques: TFm_ListaEstoques;
  private
  protected
    procedure CriarVariaveis;Override;
    procedure ImagemBotao;Override;
    procedure IniciaVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure setPerfil;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBySql;Override;
    procedure GroupBySql;Override;
    procedure SetParameters(Param: TSTQuery);Override;



  public
    Controle : TControllerCtrlEstoqueZerado;
  end;

var
  SeaCtrlEstoqueZerado: TSeaCtrlEstoqueZerado;

implementation

{$R *.dfm}

uses     UN_Sistema, UN_Principal, env;
procedure TSeaCtrlEstoqueZerado.CriarVariaveis;
begin
  inherited;
  Controle := TControllerCtrlEstoqueZerado.create(Self);
end;

procedure TSeaCtrlEstoqueZerado.FinalizaVariaveis;
begin
  inherited;

end;

procedure TSeaCtrlEstoqueZerado.GroupBySql;
begin
  inherited;

end;

procedure TSeaCtrlEstoqueZerado.ImagemBotao;
begin
  SB_Cadastrar.Visible := False;
  SB_Visualizar.Visible := False;
  CarregaImagemBotao(SB_Buscar,'BUSCAR');
  CarregaImagemBotao(Sb_Sair_0,'SAIR');


end;

procedure TSeaCtrlEstoqueZerado.IniciaVariaveis;
begin
  inherited;
  Fm_ListaEstoques.AtivaLista(Gb_CodMha);
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;

end;

procedure TSeaCtrlEstoqueZerado.InnerJoinSql;
begin
  InnerJoinTxt := concat(
                   'inner join tb_estoque est ',
                   'on (est.est_codets = cez.tb_estoque_id) ',
                   '  AND (est.est_codpro = cez.tb_product_id) ',
                   'inner join tb_produto prt ',
                   'on (prt.pro_codigo = cez.tb_product_id) '
  );

end;

procedure TSeaCtrlEstoqueZerado.OrderBySql;
begin
  inherited;
  OrderByTxt := 'ORDER BY DT_RECORD, prt.pro_descricao ';

end;

procedure TSeaCtrlEstoqueZerado.SelectSql;
begin
  SelectTxt := concat(
                  'select ID,DT_RECORD,TB_ESTOQUE_ID,TB_PRODUCT_ID, ',
                  ' prt.pro_descricao, BALANCE_FOUND, EST.est_qtde ',
                  'from tb_ctrl_estoque_zerado cez '
  );
end;

procedure TSeaCtrlEstoqueZerado.SetParameters(Param: TSTQuery);
begin
  wITH Param DO
  Begin
    IF ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').AsDatetime := E_Data_Ini.DateTime;
      ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
    end;

    if Trim(Fm_ListaProdutos.E_Cd_Produto.Text) <> '' then
    Begin
      IF (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S') then
      Begin
        ParamByName('PRO_CODIGO').AsString := Fm_ListaProdutos.E_Cd_Produto.Text;
      end
      else
      Begin
        ParamByName('PRO_CODIGO').AsString := '%' + Fm_ListaProdutos.E_Cd_Produto.Text + '%';
      end;
    end;

    if Trim(Fm_ListaProdutos.E_Busca_Produto.Text) <> '' then
      ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(Fm_ListaProdutos.E_Busca_Produto.Text,1,98) + '%';

    if Fm_ListaEstoques.Dblcb_Estoque.Text <> '' then
      ParamByName('TB_ESTOQUE_ID').AsInteger := Fm_ListaEstoques.Dblcb_Estoque.KeyValue;

  End;
end;

procedure TSeaCtrlEstoqueZerado.setPerfil;
begin
  inherited;

end;

procedure TSeaCtrlEstoqueZerado.WhereSql;
begin
  WhereTxt := 'where id is not null ';

  if ChBx_Periodo.Checked then
    WhereTxt := concat(
                  WhereTxt,
                  ' and ( DT_RECORD BETWEEN :DATAINI AND :DATAFIM ) '
                );

    //incrementa SQL
    if Trim(Fm_ListaProdutos.E_Cd_Produto.Text) <> '' then
    Begin
      IF (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S') then
      Begin
        If StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0) >0 then
        Begin
              WhereTxt := concat(
                  WhereTxt,
                  'AND ( (PRO_CODIGO =:PRO_CODIGO) or (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO) ) '
              );
        end
        else
        begin
              WhereTxt := concat(
                  WhereTxt,
                  'AND ( (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO) ) '
              )
        end;
      end
      else
      Begin
        If StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0) >0 then
        Begin
          WhereTxt := concat(
              WhereTxt,
              ' AND ( (PRO_CODIGO LIKE :PRO_CODIGO) or (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) ) '
          );
        end
        else
        begin
          WhereTxt := concat(
              WhereTxt,
              ' AND ( (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) ) '
          );
        end;
      end;
    end;

    if Trim(Fm_ListaProdutos.E_Busca_Produto.Text) <> '' then
      WhereTxt := concat(
          WhereTxt,
          ' AND ( PRO_DESCRICAO LIKE :PRO_DESCRICAO ) '
      );

    //incrementa SQL
  if Fm_ListaEstoques.Dblcb_Estoque.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' AND TB_ESTOQUE_ID =:TB_ESTOQUE_ID '
                );


end;

end.

