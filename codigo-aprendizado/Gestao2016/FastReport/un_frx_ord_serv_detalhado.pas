unit un_frx_ord_serv_detalhado;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_base_report, frxExportCSV, frxClass, frxExportPDF, frxDBSet, Data.DB, STQuery, frxExportXLS;

type
  TFrxOrdServDetalhado = class(TFrxBaseReport)
  private
    { Private declarations }
  protected

    procedure SelectSql;override;
    procedure IncrementarSQl; override;
    procedure InnerJoinSql;override;
    procedure WhereSql;override;
    procedure OrderBy;override;
    procedure GroupBy;override;
    procedure PassarParametros; override;
    procedure Rodape;override;
    procedure PreencherDetalhe;override;
  public
    { Public declarations }
    It_VL_Servico, It_VL_Produto : Real;
    It_VL_TL_Servico, It_VL_TL_Produto : Real;
    procedure Buscar;override;
  end;

var
  FrxOrdServDetalhado: TFrxOrdServDetalhado;

implementation

{$R *.dfm}

uses     UN_Imp_Servico;

{ TFrxOrdServDetalhado }

procedure TFrxOrdServDetalhado.Buscar;
VaR
  SqlTxt:String;
  Lc_Cliente, Lc_Placa,Lc_Frota:Boolean;
begin
  with Fr_Imp_Servico, Qr_Consulta do
  Begin
    Screen.Cursor:=crHourGlass;
    It_VL_Servico := 0;
    It_VL_Produto := 0;
    It_VL_TL_Servico := 0;
    It_VL_TL_Produto := 0;
    Active := False;
    SQL.Clear;
    case RG_Tipo.ItemIndex of
      0: SqlTxt:='SELECT PED_DATA AS DATA, ';
      1: SqlTxt:='SELECT NFL_DT_EMISSAO AS DATA, ';
    End;


    SqlTxt := concat(SqlTxt,
                    'PED_CODIGO, PED_NUMERO,PRO_TIPO, PRO_DESCRICAO, ITF_QTDE, ITF_VL_UNIT, ',
                    '((ITF_QTDE *  ITF_VL_UNIT)- ITF_VL_DESC) AS ITF_VL_SUBTOTAL,EMP_NOME, VEI_FROTA, VEI_PLACA, ',
                    'vck.km, OS.obs, MRC_DESCRICAO, MOD_DESCRICAO,ITF_CODIGO, PRO_CODIGOFAB ',
                    ' FROM TB_PEDIDO tb_pedido ',
                    '   INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal ',
                    '   ON  (tb_nota_fiscal.NFL_CODPED = tb_pedido.PED_CODIGO) ',
                    '   INNER JOIN TB_EMPRESA tb_empresa  ',
                    '   ON  (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP) ',
                    '   INNER JOIN TB_ITENS_NFL tb_itens_nfl ',
                    '   ON  (tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO ) ',
                    '   INNER JOIN TB_PRODUTO Tb_produto ',
                    '   ON  (Tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) '
                    );

    if not chbx_Without_vehicle.Checked then
    BEgin
      SqlTxt := SqlTxt + '   INNER JOIN TB_VEHICLE_SO OS '+
                         '   ON  (OS.TB_ORDER_ID = tb_pedido.PED_CODIGO) '+
                         '   INNER JOIN TB_VEICULO Tb_veiculo  '+
                         '   ON  (TB_VEICULO.VEI_PLACA = OS.TB_VEHICLE_ID ) '+
                         '   INNER JOIN TB_MARCA_VEICULO tb_marca_veiculo '+
                         '   ON  (tb_marca_veiculo.MRC_CODIGO = Tb_veiculo.VEI_CODMRC) '+
                         '   INNER JOIN TB_MODELO tb_modelo  '+
                         '   ON  (tb_modelo.MOD_CODIGO = Tb_veiculo.VEI_CODMOD)  ';
    End
    else
    BEgin
      SqlTxt := SqlTxt + '   LEFT JOIN TB_VEHICLE_SO OS '+
                         '   ON  (OS.TB_ORDER_ID = tb_pedido.PED_CODIGO) '+
                         '   LEFT JOIN TB_VEICULO Tb_veiculo  '+
                         '   ON  (TB_VEICULO.VEI_PLACA = OS.TB_VEHICLE_ID ) '+
                         '   LEFT JOIN TB_MARCA_VEICULO tb_marca_veiculo '+
                         '   ON  (tb_marca_veiculo.MRC_CODIGO = Tb_veiculo.VEI_CODMRC) '+
                         '   LEFT JOIN TB_MODELO tb_modelo  '+
                         '   ON  (tb_modelo.MOD_CODIGO = Tb_veiculo.VEI_CODMOD)  ';
    End;
    SqlTxt := SqlTxt +   '   left outer join TB_VEHICLE_CHECKLIST vck '+
                         '    on (vck.TB_ORDER_ID = OS.TB_ORDER_ID)'+
                         'WHERE (PED_CODIGO IS NOT NULL) AND (NFL_STATUS = ''F'') AND (PED_TIPO = 1) ';

    if DBLCB_Empresa.Text ='' then Lc_Cliente := False else Lc_Cliente := True;

    if (E_PlacaINI.Text = '') or (Fr_Imp_Servico.E_PlacaFIM.Text = '') then Lc_Placa := False else Lc_Placa := True;
    if (E_FrotaINI.Text = '') or (Fr_Imp_Servico.E_FrotaFIM.Text = '') then Lc_Frota := False else Lc_Frota := True;

    if Lc_Cliente then SqlTxt := SqlTxt +'AND PED_CODEMP =:PED_CODEMP ';

    if ChBx_Periodo.Checked then
      Begin
      case Fr_Imp_Servico.RG_Tipo.ItemIndex of
        0: SqlTxt := SqlTxt +'AND PED_DATA BETWEEN :DATAINI AND :DATAFIM  ';
        1: SqlTxt := SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';
      End;
      End;

    if Lc_Placa then SqlTxt := SqlTxt +'AND VEI_PLACA BETWEEN :PLACAINI AND :PLACAFIM  ';
    if Lc_Frota then SqlTxt := SqlTxt +'AND VEI_FROTA BETWEEN :FROTAINI AND :FROTAFIM  ';

    case RG_Tipo.ItemIndex of
      0: SQL.Add(SqlTxt+' ORDER BY PED_DATA, PED_NUMERO, PRO_DESCRICAO, PRO_TIPO ');
      1: SQL.Add(SqlTxt+' ORDER BY NFL_DT_EMISSAO, PED_NUMERO, PRO_DESCRICAO, PRO_TIPO ');
    END;

    if Lc_Cliente then ParamByName('PED_CODEMP').AsInteger:= DBLCB_Empresa.KeyValue;
    if ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').Asdate := E_Data_INI.Date;
      ParamByName('DATAFIM').AsDate := E_Data_FIM.Date;
    end;
    if Lc_Placa then ParamByName('PLACAINI').AsString := E_PlacaINI.Text;
    if Lc_Placa then ParamByName('PLACAFIM').AsString := E_PlacaFIM.Text;
    if Lc_Frota then ParamByName('FROTAINI').AsString := E_FrotaINI.Text;
    if Lc_Frota then ParamByName('FROTAFIM').AsString := E_FrotaFIM.Text;
    Active := True;
    Screen.Cursor:=crDefault;
  End;
end;

procedure TFrxOrdServDetalhado.GroupBy;
begin
  inherited;

end;

procedure TFrxOrdServDetalhado.IncrementarSQl;
begin
  inherited;

end;

procedure TFrxOrdServDetalhado.InnerJoinSql;
begin
  inherited;

end;

procedure TFrxOrdServDetalhado.OrderBy;
begin
  inherited;

end;

procedure TFrxOrdServDetalhado.PassarParametros;
begin
  inherited;

end;

procedure TFrxOrdServDetalhado.PreencherDetalhe;
begin
  inherited;

end;

procedure TFrxOrdServDetalhado.Rodape;
begin
  inherited;

end;

procedure TFrxOrdServDetalhado.SelectSql;
begin
  inherited;

end;

procedure TFrxOrdServDetalhado.WhereSql;
begin
  inherited;

end;

end.
