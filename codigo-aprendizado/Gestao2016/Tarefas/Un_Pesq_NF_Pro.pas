unit Un_Pesq_NF_Pro;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Un_Pesq_NotaFiscal, Un_Fm_ListaMultiEmpresa, Vcl.DBCtrls, QEdit_Setes, Vcl.ComCtrls, base_frame_list, un_fm_lista_cfop;


type
  TFr_Pesq_NF_Pro = class(TFr_Pesq_NotaFiscal)
    Rg_Modelo: TRadioGroup;
    Qr_Res_Hora: TSTQuery;
    Ds_Res_Hora: TDataSource;
    DBGrid1: TDBGrid;
    Qr_Res_HoraHORA: TSmallintField;
    Qr_Res_HoraTOTALVENDA: TBCDField;
    Qr_Res_HoraQTDEVENDA: TIntegerField;
    Qr_Res_HoraTICKETMEDIO: TBCDField;
    procedure Rg_ModeloClick(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
  private
    procedure BuscarPorHora;
  protected
    procedure Pc_Visualizar;Override;
    procedure Pc_FormataTela;Override;
    procedure FormataGrid55;
    procedure FormataGrid65;

    procedure Buscar; Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure PassarParametros(Qry: TSTQuery);Override;


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_Pesq_NF_Pro: TFr_Pesq_NF_Pro;

implementation

uses     Un_Funcoes, Un_NF_65, RN_NotaFiscalConsumidor, RN_NotaFiscalEletronica3X, RN_NotaFiscal, RN_Permissao, Un_Regra_Negocio, Un_Msg, UN_Principal, env, UN_Sistema;
{$R *.dfm}

procedure TFr_Pesq_NF_Pro.Buscar;
begin
  inherited;
 (Qr_Pesquisa.FieldByName('NFL_VL_TL_NOTA') as TNumericField).DisplayFormat  := '0.00##';
  SomaNotas('NFL_VL_TL_NOTA');
end;

procedure TFr_Pesq_NF_Pro.SB_BuscarClick(Sender: TObject);
begin
  inherited;
  if tbs_resumo.Visible then
    BuscarPorHora;
end;

procedure TFr_Pesq_NF_Pro.SelectSql;
begin
  if Rg_Modelo.ItemIndex = 1 then
  Begin
    SelectTxt := 'SELECT NFL_CODIGO,  PED_NUMERO, NFC_CODIGO, NFC_TP_EMISSAO, '+
                 'NFL_DT_EMISSAO, NFL_HR_SAIDA, NFL_TIPO,EMP_FANTASIA, EMP_NOME,NFL_VL_TL_NOTA, '+
                 'NFL_MODELO, NFL_SERIE,PED_CODVDO, PED_TIPO  '+
                 'FROM TB_NOTA_FISCAL Tb_nota_fiscal '+
                 '  INNER JOIN TB_EMPRESA tb_empresa '+
                 '  ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
                 '  INNER JOIN TB_PEDIDO tb_pedido '+
                 '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) ';


  End
  else
  Begin
    SelectTxt := 'SELECT NFL_CODIGO, PED_NUMERO, NFL_NUMERO, NFL_DT_EMISSAO, '+
                 'EMP_FANTASIA,NFL_HR_SAIDA, EMP_NOME,NFL_VL_TL_NOTA,NFL_MODELO, NFL_SERIE,PED_CODVDO, PED_TIPO '+
                 'FROM TB_NOTA_FISCAL Tb_nota_fiscal '+
                 '  INNER JOIN TB_EMPRESA tb_empresa '+
                 '  ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
                 '  INNER JOIN TB_PEDIDO tb_pedido '+
                 '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) ';
  End;
end;

procedure TFr_Pesq_NF_Pro.InnerJoinSql;
begin
  if (It_Bairro or It_Regiao or It_Fone) and (not (It_Estado or It_Cidade) )   then
  Begin
    InnerJoinTxt :=  InnerJoinTxt +
                 '  INNER JOIN TB_ENDERECO '+
                 '  ON (END_CODEMP = PED_CODEND) ';
  end
  else
  Begin
    if (It_Estado or It_Cidade) then
      InnerJoinTxt :=  InnerJoinTxt +
                   '  INNER JOIN TB_ENDERECO '+
                   '  ON (END_CODIGO = PED_CODEND) '+
                   '  INNER JOIN TB_UF '+
                   '  ON (UFE_CODIGO = END_CODUFE) '+
                   '  INNER JOIN TB_CIDADE '+
                   '  ON (CDD_CODIGO = END_CODCDD)';
  end;

  if It_Obs then
    InnerJoinTxt :=  InnerJoinTxt +
                '  INNER JOIN TB_OBS_NFE '+
                '  ON (OBN_CODNFL = NFL_CODIGO) ';

  if It_CFOP then
    InnerJoinTxt :=  InnerJoinTxt +
                '  INNER JOIN TB_NATUREZA '+
                '  ON (NAT_CODIGO = NFL_CODNAT) ';
  if Rg_Modelo.ItemIndex = 1 then
  Begin
    case Rg_Sit_Nfe.ItemIndex of
      1..4: InnerJoinTxt :=  InnerJoinTxt +
                           '  INNER JOIN TB_RETORNO_NFC '+
                           '  ON (NFC_CODNFL = NFL_CODIGO) ';
      else
        InnerJoinTxt :=  InnerJoinTxt +
                                 '  LEFT OUTER JOIN TB_RETORNO_NFC '+
                                 '  ON (NFC_CODNFL = NFL_CODIGO) ';
    End;
  End;
  if Rg_Modelo.ItemIndex = 0 then
  Begin
    case Rg_Sit_Nfe.ItemIndex of
      1..4:InnerJoinTxt :=  InnerJoinTxt +
                            '  INNER JOIN TB_RETORNO_NFE '+
                           '  ON (NFE_CODNFL = NFL_CODIGO) ';
      else
        InnerJoinTxt :=  InnerJoinTxt +
                         '  LEFT OUTER JOIN TB_RETORNO_NFE '+
                         '  ON (NFE_CODNFL = NFL_CODIGO) ';

    end;
  End;

end;

procedure TFr_Pesq_NF_Pro.WhereSql;
begin
  inherited;
  case Rg_Modelo.ItemIndex of
    0:Begin
        WhereTxt := WhereTxt  + ' AND (NFL_MODELO <> ''65'') ';

        if It_Nota then
          WhereTxt := WhereTxt + 'AND NFL_NUMERO LIKE :NFL_NUMERO ';

        if onlyNnumbered then
          WhereTxt := WhereTxt + ' AND (NFL_NUMERO is not null) and (NFL_NUMERO <> '''') ';

        case Rg_Sit_Nfe.ItemIndex of
          0:WhereTxt := WhereTxt + 'AND ( ( NFE_CODSIT is null) or ( NFE_CODSIT = 0 ) )';
          1..4:WhereTxt := WhereTxt + ' AND ( NFE_CODSIT = :NFE_CODSIT) ';
        end;
      end;
    1:Begin
        WhereTxt := WhereTxt  + ' AND (NFL_MODELO = ''65'') ';

        if It_Nota then
          WhereTxt := WhereTxt + ' AND (NFC_CODIGO =:NFC_CODIGO) ';

        if onlyNnumbered then
          WhereTxt := WhereTxt + 'AND (NFC_CODIGO > 0) ';

        case Rg_Sit_Nfe.ItemIndex of
          0:Begin
              WhereTxt := WhereTxt + 'AND ( ( NFC_CODSIT is null) or ( NFC_CODSIT = 0 ) )';
          End;
          1..4:WhereTxt := WhereTxt + ' AND ( NFC_CODSIT = :NFC_CODSIT) ';
        end;
      end;
    2:Begin
        if It_Nota then
          WhereTxt := WhereTxt + 'AND NFL_NUMERO LIKE :NFL_NUMERO ';
      End;
  end;

  WhereTxt := WhereTxt  + ' AND  ( (PED_TIPO = 0 ) ';
  if ChBx_Vendas.Checked  then WhereTxt := WhereTxt  + ' OR (PED_TIPO = 1) OR (PED_TIPO = 4 ) ';
  if ChBx_Compras.Checked then WhereTxt := WhereTxt  + ' OR (PED_TIPO = 2) ';
  if ChBx_Ajustes.Checked then WhereTxt := WhereTxt  + ' OR (PED_TIPO = 3) ';
  WhereTxt := WhereTxt  + ' ) ';

  case RG_Tipo_Operacao.ItemIndex of
    0:WhereTxt := WhereTxt  +' AND (NFL_TIPO LIKE ''E%'') ';
    1:WhereTxt := WhereTxt  +' AND (NFL_TIPO LIKE ''S%'') ';
  end;
end;


procedure TFr_Pesq_NF_Pro.PassarParametros(Qry: TSTQuery);
Begin
  inherited;
  with Qr_Pesquisa do
  Begin
    case Rg_Modelo.ItemIndex of
      0:Begin
          if It_nota then
            ParamByName('NFL_NUMERO').AsString := '%' + E_BuscaNota.Text;
          case Rg_Sit_Nfe.ItemIndex of
            1..3:ParamByName('NFE_CODSIT').AsInteger := Rg_Sit_Nfe.ItemIndex;
            4:ParamByName('NFE_CODSIT').AsInteger := 5;
          end;
        End;
      1:Begin
          if It_Nota then
            ParamByName('NFC_CODIGO').AsString:= E_BuscaNota.Text;

          case Rg_Sit_Nfe.ItemIndex of
            1..3:ParamByName('NFC_CODSIT').AsInteger := Rg_Sit_Nfe.ItemIndex;
            4:ParamByName('NFC_CODSIT').AsInteger := 5;
          end;
        End;
      2:Begin
          if It_nota then
            ParamByName('NFL_NUMERO').AsString := '%' + E_BuscaNota.Text;
        End;
    end;
  End;
end;

procedure TFr_Pesq_NF_Pro.Pc_FormataTela;
Begin
  tbs_resumo.TabVisible := (Fc_Tb_Geral('L','VDA_G_RES_HORA','N') = 'S');
  if Rg_Modelo.ItemIndex = 1 then
    FormataGrid65
  else
    FormataGrid55;
End;


procedure TFr_Pesq_NF_Pro.BuscarPorHora;
begin
  with Qr_Res_Hora do
  Begin
    Active := false;
    sql.clear;
    sql.add(concat(
              'SELECT extract(HOUR FROM nfl_hr_saida) Hora, CAST(sum(nfl_vl_tl_nota) AS NUMERIC(18, 2)) TotalVenda ,',
              'count(nfl_codigo) QtdeVenda,  CAST(avg(nfl_vl_tl_nota) AS NUMERIC(18, 2)) TicketMedio ',
              'FROM TB_NOTA_FISCAL Tb_nota_fiscal ',
              '  INNER JOIN TB_EMPRESA tb_empresa ',
              '  ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) ',
              '  INNER JOIN TB_PEDIDO tb_pedido ',
              '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) ',
              InnerJoinTxt,
              WhereTxt
    ));
    sql.add('GROUP BY extract(HOUR FROM nfl_hr_saida) ');
  End;
  PassarParametros(Qr_Res_Hora);
  Qr_Res_Hora.Active := true;
end;

procedure TFr_Pesq_NF_Pro.FormataGrid55;
begin
  //Grade de Pesquisa
  DBG_Pesquisa.Columns.Clear;
  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'NFL_DT_EMISSAO';
    width := 74;
    Title.Caption := 'Data Emissão';
  end;

  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'NFL_HR_SAIDA';
    width := 74;
    Title.Caption := 'Hora Emissão';
  end;

  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'PED_NUMERO';
    width := 71;
    Title.Caption := 'Pedido';
  end;
    with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'PED_CODWEB';
    width := 71;
    Title.Caption := 'Cod.Web';
  end;
  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'NFL_NUMERO';
    width := 80;
    Title.Caption := 'Nº Nota Fiscal';
  end;
  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'NFL_SERIE';
    width := 30;
    Title.Caption := 'Série';
  end;
  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'EMP_NOME';
    width := 390;
    Title.Caption := 'Nome/Razão';
  end;
  IndGrid := 6;
  if ( Gb_Nivel = 1 ) or ( not ( Fc_Tb_Geral('L','VDA_G_NO_SHOW_VALUES','S') = 'S') ) then
  Begin
    with DBG_Pesquisa.Columns.Add do
    Begin
      FieldName := 'NFL_VL_TL_NOTA';
      width := 111;
      Title.Caption := 'Valor Nota';
    end;
  End;
end;


procedure TFr_Pesq_NF_Pro.FormataGrid65;
begin
  //Grade de Pesquisa
  DBG_Pesquisa.Columns.Clear;
  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'NFL_DT_EMISSAO';
    width := 74;
    Title.Caption := 'Data Emissão';
    Alignment := taCenter;
  end;

  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'NFL_HR_SAIDA';
    width := 74;
    Title.Caption := 'Hora Emissão';
  end;

  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'PED_NUMERO';
    width := 71;
    Title.Caption := 'Pedido';
  end;
  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'NFC_CODIGO';
    width := 80;
    Title.Caption := 'Nº Nota Fiscal';
    Alignment := taCenter;
  end;
  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'NFL_SERIE';
    width := 30;
    Title.Caption := 'Série';
  end;

  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'NFC_TP_EMISSAO';
    width := 80;
    Title.Caption := 'Tipo Emissão';
    Alignment := taCenter;
  end;

  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'EMP_NOME';
    width := 390;
    Title.Caption := 'Nome/Razão';
  end;
  IndGrid := 6;

  if ( Gb_Nivel = 1 ) or ( not ( Fc_Tb_Geral('L','VDA_G_NO_SHOW_VALUES','S') = 'S') ) then
  Begin
    with DBG_Pesquisa.Columns.Add do
    Begin
      FieldName := 'NFL_VL_TL_NOTA';
      width := 111;
      Title.Caption := 'Valor Nota';
      Alignment := taRightJustify;
    end;
  End;
end;

procedure TFr_Pesq_NF_Pro.Pc_Visualizar;
Begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Operações NFe','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    with Qr_Pesquisa do
    BEgin
      if (FieldByName('NFL_MODELO').AsString = '65') and (FieldByName('PED_TIPO').AsString = '1') then
        Pc_AbreTelaNotaFiscal65('N',FieldByName('NFL_CODIGO').AsInteger)
      else
        Pc_AbreTelaNotaFiscal(FieldByName('NFL_CODIGO').AsInteger,Self);
    end;
  End;
end;

procedure TFr_Pesq_NF_Pro.Rg_ModeloClick(Sender: TObject);
begin
  if Rg_Modelo.ItemIndex = 1 then FormataGrid65 else FormataGrid55;
  Buscar;

end;

end.
