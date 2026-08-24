unit Un_RL_VendaMeses;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, RLRichFilter, RLHTMLFilter, RLXLSFilter, RLFilters, RLPDFFilter, RLReport, OleServer, ExcelXP, DB, STQuery, ExtCtrls, StdCtrls, Buttons, Grids, ComObj;

type
  TRL_VendaMeses = class(TForm)
    Qr_Clientes: TSTQuery;
    Qr_ClientesEMP_CODIGO: TIntegerField;
    Qr_ClientesEMP_NOME: TStringField;
    Qr_ClientesEMP_FANTASIA: TStringField;
    Qr_Vendas: TSTQuery;
    Qr_Descontos: TSTQuery;
    Qr_DescontosVDA_VL_DESCONTO: TBCDField;
    Qr_MarcaProduto: TSTQuery;
    Qr_MarcaProdutoMRC_CODIGO: TIntegerField;
    Qr_MarcaProdutoMRC_DESCRICAO: TStringField;
    StrGrd_Vendas: TStringGrid;
    StrGrd_Marcas: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    It_Vendas: array[0..11, 0..3] of string;
    It_Dia: Integer;
    It_Mes: Integer;
    It_Ano: Integer;
    { Private declarations }
  public
    It_Nr_Clientes: Integer;
    It_Nr_MArcas: Integer;
    It_Contador: integer;
    Excel : Variant;
    procedure Pc_LimiteDatas;
    procedure Pc_BuscaCliente;
    procedure Pc_DefineSql(Pc_Agrupa: string; Pc_Cliente: Boolean; Pc_Marca: boolean);
    procedure Pc_PreencheMatrizVendas;
    procedure Pc_PreencheMatrizVendasMarcas;
    function Pc_BuscaVenda(Pc_Periodo: string; Pc_Indice: Integer; Pc_Cd_Cliente: string; Pc_DataIni: string; Pc_DataFim: string): real;
    function Pc_BuscaVendaMarca(Pc_Periodo: string; Pc_Indice: Integer; Pc_Cd_Marca: string; Pc_DataIni: string; Pc_DataFim: string): real;
    function Pc_Cabecalho(Nr_Linha: Integer): Integer;
    function Pc_Corpo(Nr_Linha: Integer): Integer;
    function Pc_Marca(Nr_Linha: Integer): Integer;
    Procedure ExportDados;
    { Public declarations }
  end;

var
  RL_VendaMeses: TRL_VendaMeses;

implementation

uses     UN_Imp_Vendas, Un_Funcoes, UN_Sistema, Un_DM, Un_Regra_Negocio;
{$R *.dfm}

procedure TRL_VendaMeses.Pc_LimiteDatas;
var
  Lc_I: Integer;
begin
  Excel := CreateoleObject('Excel.Application');
  Excel.WorkBooks.add(1);
  Excel.caption := 'Exportando dados Excel';

  It_Mes := StrtoInt(Copy(DateTostr(Fr_Imp_Vendas.E_Data_Ini.Date), 4, 2));
  It_Ano := StrtoInt(Copy(DateTostr(Fr_Imp_Vendas.E_Data_Fim.Date), 7, 4));
  for Lc_I := 11 downto 6 do
  begin
    if It_Mes = 0 then
    begin
      It_Mes := 12;
      It_Ano := It_Ano - 1;
    end;
    It_Dia := UltDiaDoMes(StrToDate('01/' + IntToStr(It_Mes) + '/' + IntToStr(It_Ano)));
    It_Vendas[Lc_I, 0] := StrZero(It_Dia, 2, 0);
    It_Vendas[Lc_I, 1] := StrZero(It_Mes, 2, 0);
    It_Vendas[Lc_I, 2] := StrZero(It_Ano, 4, 0);
    It_Mes := It_Mes - 1;
  end;

  if Fr_Imp_Vendas.ChBx_Nome.Checked then
    StrGrd_Vendas.Cells[1,0] := 'Raz?o Social'
  else
    StrGrd_Vendas.Cells[1,0] := 'Nome Fantasia';
  StrGrd_Vendas.Cells[2,0] := It_Vendas[6, 1] + '/' + It_Vendas[6, 2];
  StrGrd_Vendas.Cells[3,0] := It_Vendas[7, 1] + '/' + It_Vendas[7, 2];
  StrGrd_Vendas.Cells[4,0] := It_Vendas[8, 1] + '/' + It_Vendas[8, 2];
  StrGrd_Vendas.Cells[5,0] := It_Vendas[9, 1] + '/' + It_Vendas[9, 2];
  StrGrd_Vendas.Cells[6,0] := It_Vendas[10, 1] + '/' + It_Vendas[10, 2];
  StrGrd_Vendas.Cells[7,0] := It_Vendas[11, 1] + '/' + It_Vendas[11, 2];
  StrGrd_Vendas.Cells[8,0] := 'Ano Anterior';
  StrGrd_Vendas.Cells[9,0] := 'Valor Total';

  StrGrd_Marcas.Cells[1,0] := 'Marcas';
  StrGrd_Marcas.Cells[2,0] := It_Vendas[6, 1] + '/' + It_Vendas[6, 2];
  StrGrd_Marcas.Cells[3,0] := It_Vendas[7, 1] + '/' + It_Vendas[7, 2];
  StrGrd_Marcas.Cells[4,0] := It_Vendas[8, 1] + '/' + It_Vendas[8, 2];
  StrGrd_Marcas.Cells[5,0] := It_Vendas[9, 1] + '/' + It_Vendas[9, 2];
  StrGrd_Marcas.Cells[6,0] := It_Vendas[10, 1] + '/' + It_Vendas[10, 2];
  StrGrd_Marcas.Cells[7,0] := It_Vendas[11, 1] + '/' + It_Vendas[11, 2];
  StrGrd_Marcas.Cells[8,0] := 'Ano Anterior';
  StrGrd_Marcas.Cells[9,0] := 'Valor Total';
  
end;

procedure TRL_VendaMeses.Pc_BuscaCliente;
var
  SqlTxt: string;
  Lc_Cliente, Lc_Vendedor, Lc_Data: Boolean;
begin
  Screen.Cursor := crHourGlass;

  Qr_Clientes.Close;
  Qr_Clientes.SQL.Clear;

  SqlTxt := 'SELECT DISTINCT EMP_CODIGO, EMP_NOME, EMP_FANTASIA       ' +
            'FROM TB_NOTA_FISCAL tb_nota_fiscal                       ' +
            '    INNER JOIN TB_EMPRESA tb_empresa             ' +
            '   ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) ' +
            '    INNER JOIN TB_PEDIDO tb_pedido ' +
            '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) ' +
            'WHERE NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM '+
            ' AND PED_TIPO = ''1'' ';

  if NOT Fr_Imp_Vendas.Fm_LME.chbx_Empresas.Checked then
    SqlTxt := SqlTxt + 'AND ( NFL_CODMHA =:NFL_CODMHA ) ';

  if Fr_Imp_Vendas.E_Empresa.Text = '' then
    Lc_Cliente := False
  else
    Lc_Cliente := True;
  if Fr_Imp_Vendas.DBLCB_Vendedor.Text = '' then
    Lc_Vendedor := False
  else
    Lc_Vendedor := True;

  if Lc_Cliente then
    SqlTxt := SqlTxt + 'AND ((EMP_NOME LIKE :EMP_NOME)OR (EMP_FANTASIA LIKE :EMP_NOME)) ';
  if Lc_Vendedor then
    SqlTxt := SqlTxt + 'AND (PED_CODVDO =:PED_CODVDO) ';


  SqlTxt := SqlTxt + 'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';
  if Fr_Imp_Vendas.RG_Tipo.ItemIndex = 0 then
    SqlTxt := SqlTxt + ' AND ( (NFL_NUMERO ='''') or (NFL_NUMERO is null) )';
  if Fr_Imp_Vendas.RG_Tipo.ItemIndex = 1 then
    SqlTxt := SqlTxt + ' AND ( (NFL_NUMERO <>'''') or (NFL_NUMERO is not null) ) ';

  if Fr_Imp_Vendas.ChBx_Nome.Checked then
    Qr_Clientes.SQL.Add(SqlTxt + 'ORDER BY  EMP_NOME ')
  else
    Qr_Clientes.SQL.Add(SqlTxt + 'ORDER BY  EMP_FANTASIA ');


  if Lc_Cliente then
    Qr_Clientes.ParamByName('EMP_NOME').AsString := '%' + Fr_Imp_Vendas.E_Empresa.Text + '%';
  if Lc_Vendedor then
    Qr_Clientes.ParamByName('PED_CODVDO').AsInteger := Fr_Imp_Vendas.DBLCB_Vendedor.KeyValue;

  if It_Vendas[6, 1] <> '02' then
    Qr_Clientes.ParamByName('DATAINI').AsString := It_Vendas[6, 0] + '/' + It_Vendas[6, 1] + '/' + It_Vendas[6, 2]
  else
     Qr_Clientes.ParamByName('DATAINI').AsString := '28' + '/' + It_Vendas[6, 1] + '/' + It_Vendas[6, 2];

  if It_Vendas[6, 1] <> '02' then
    Qr_Clientes.ParamByName('DATAFIM').AsString := It_Vendas[11, 0] + '/' + It_Vendas[11, 1] + '/' + It_Vendas[11, 2]
  else
    Qr_Clientes.ParamByName('DATAFIM').AsString := '28' + '/' + It_Vendas[11, 1] + '/' + It_Vendas[11, 2];

  if NOT Fr_Imp_Vendas.Fm_LME.chbx_Empresas.Checked then
    Qr_Clientes.ParamByName('NFL_CODMHA').AsInteger := Fr_Imp_Vendas.Fm_LME.Dblcb_Lista.KeyValue;

  Qr_Clientes.Active := True;
  Qr_Clientes.FetchAll;
  Qr_Clientes.First;
  Fr_Imp_Vendas.Gg_Progresso.Progress := 0;
  Fr_Imp_Vendas.Gg_Progresso.MinValue := 0;
  Fr_Imp_Vendas.Gg_Progresso.MaxValue := Qr_Clientes.RecordCount;
  Fr_Imp_Vendas.Lb_Processo.Caption := 'Processando Lista de Clientes';
  Application.ProcessMessages;

  It_Nr_Clientes := 0;

  while not Qr_Clientes.Eof do
    begin
    inc(It_Nr_Clientes);
    StrGrd_Vendas.RowCount := 1 + It_Nr_Clientes;
    StrGrd_Vendas.Cells[0, It_Nr_Clientes] := Qr_ClientesEMP_CODIGO.AsString;
    if Fr_Imp_Vendas.ChBx_Nome.Checked then
      StrGrd_Vendas.Cells[1, It_Nr_Clientes] := StrZero(Qr_ClientesEMP_CODIGO.AsInteger, 4, 0) + ' - ' + Qr_ClientesEMP_NOME.AsString
    else
      StrGrd_Vendas.Cells[1, It_Nr_Clientes] := StrZero(Qr_ClientesEMP_CODIGO.AsInteger, 4, 0) + ' - ' + Qr_ClientesEMP_FANTASIA.AsString;

    Fr_Imp_Vendas.Gg_Progresso.Progress := It_Nr_Clientes;
    Qr_Clientes.Next;
  end;

  Qr_Clientes.Close;
  //Número de Marcas
  Qr_MarcaProduto.Active := True;
  Qr_MarcaProduto.FetchAll;

  Fr_Imp_Vendas.Gg_Progresso.Progress := 0;
  Fr_Imp_Vendas.Gg_Progresso.MinValue := 0;
  Fr_Imp_Vendas.Gg_Progresso.MaxValue := Qr_MarcaProduto.RecordCount;
  Fr_Imp_Vendas.Lb_Processo.Caption := 'Processando Lista de Marcas';
  Application.ProcessMessages;
  It_Nr_MArcas := 0;
  while not Qr_MarcaProduto.Eof do
    begin
    inc(It_Nr_MArcas);
    StrGrd_Marcas.RowCount := 1 + It_Nr_MArcas;
    StrGrd_Marcas.Cells[0, It_Nr_MArcas ] := Qr_MarcaProdutoMRC_CODIGO.AsString;
    StrGrd_Marcas.Cells[1, It_Nr_MArcas] := Qr_MarcaProdutoMRC_DESCRICAO.AsString;
    Fr_Imp_Vendas.Gg_Progresso.Progress := It_Nr_MArcas;
    Qr_MarcaProduto.Next;
  end;
  Screen.Cursor := crDefault;
end;

procedure TRL_VendaMeses.Pc_DefineSql(Pc_Agrupa: string; Pc_Cliente: Boolean; Pc_Marca: Boolean);
var
  SqlTxt: string;
  Lc_Cliente, Lc_Vendedor: Boolean;
begin
  Screen.Cursor := crHourGlass;
  Fr_Imp_Vendas.Lb_Processo.Caption := 'Gerando Scrip de Consulta';
  Qr_Vendas.Close;
  Qr_Vendas.SQL.Clear;

  if Pc_Agrupa = 'M' then
    SqlTxt := 'SELECT  CAST(EXTRACT( MONTH FROM tb_nota_fiscal.nfl_dt_emissao)  || ''/01/'' || EXTRACT( YEAR FROM tb_nota_fiscal.nfl_dt_emissao) AS DATE) NFL_DATA,  SUM(ITF_VL_UNIT * ITF_QTDE) VDA_VL_TOTAL '
  else
    SqlTxt := 'SELECT  EXTRACT( YEAR FROM tb_nota_fiscal.nfl_dt_emissao)NFL_DATA, SUM(ITF_VL_UNIT * ITF_QTDE) VDA_VL_TOTAL ';

  SqlTxt := SqlTxt +
    'FROM TB_NOTA_FISCAL tb_nota_fiscal ' +
    '   INNER JOIN TB_ITENS_NFL tb_itens_nfl ' +
    '   ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO) ' +
    '   INNER JOIN TB_PRODUTO tb_produto ' +
    '   ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) ' +
    '   INNER JOIN TB_PEDIDO tb_pedido ' +
    '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) ' +
    'WHERE (NFL_CODIGO IS NOT NULL)  AND (PED_TIPO = 1) AND (ITF_OPER = ''V'') ';

  if NOT Fr_Imp_Vendas.Fm_LME.chbx_Empresas.Checked then
    SqlTxt := SqlTxt + 'AND ( NFL_CODMHA =:NFL_CODMHA ) ';

  SqlTxt := SqlTxt + 'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';
  if Pc_Cliente then
    SqlTxt := SqlTxt + 'AND (NFL_CODEMP =:NFL_CODEMP) ';
  if Pc_Marca then
    SqlTxt := SqlTxt + 'AND (PRO_CODMRC =:PRO_CODMRC) ';

  if Fr_Imp_Vendas.RG_Tipo.ItemIndex = 0 then
    SqlTxt := SqlTxt + 'AND (NFL_NUMERO ='''') ';
  if Fr_Imp_Vendas.RG_Tipo.ItemIndex = 1 then
    SqlTxt := SqlTxt + 'AND (NFL_NUMERO <> '''') ';

  SqlTxt := SqlTxt + 'GROUP BY NFL_DATA ';
  SqlTxt := SqlTxt + 'ORDER BY NFL_DATA ';
  Qr_Vendas.SQL.Add(SqlTxt);

  Qr_Descontos.Close;
  Qr_Descontos.SQL.Clear;

  SqlTxt := 'SELECT CAST(SUM(PED_VL_DESCONTO) AS NUMERIC(18, 2)) VDA_VL_DESCONTO ' +
    'FROM TB_NOTA_FISCAL tb_nota_fiscal ' +
    '    INNER JOIN TB_PEDIDO tb_pedido ' +
    '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) ' +
    '    INNER JOIN TB_EMPRESA tb_empresa ' +
    '    ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) ' +
    'WHERE (NFL_CODIGO IS NOT NULL) AND (PED_TIPO = 1) AND (ITF_OPER = ''V'') ';

  if NOT Fr_Imp_Vendas.Fm_LME.chbx_Empresas.Checked then
    SqlTxt := SqlTxt + 'AND ( NFL_CODMHA =:NFL_CODMHA ) ';

  SqlTxt := SqlTxt + 'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';
  SqlTxt := SqlTxt + 'AND (NFL_CODEMP =:NFL_CODEMP) ';

  if Fr_Imp_Vendas.RG_Tipo.ItemIndex = 0 then
    SqlTxt := SqlTxt + 'AND (NFL_NUMERO = '''') ';
  if Fr_Imp_Vendas.RG_Tipo.ItemIndex = 1 then
    SqlTxt := SqlTxt + 'AND (NFL_NUMERO <> '''') ';

  Qr_Descontos.SQL.Add(SqlTxt);
  Screen.Cursor := crDefault;
end;

function TRL_VendaMeses.Pc_BuscaVenda(Pc_Periodo: string; Pc_Indice: Integer; Pc_Cd_Cliente: string; Pc_DataIni: string; Pc_DataFim: string): real;
var
  Lc_valor: real;
  Lc_I: Integer;
begin
  Screen.Cursor := crHourGlass;
  Qr_MarcaProduto.Active := True;
  Qr_MarcaProduto.First;
  Lc_valor := 0;
  //Calcula Vendas
  IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.Commit;
  Qr_Vendas.Active := false;
  if (Pc_Cd_Cliente <> '') then
    Qr_Vendas.ParamByName('NFL_CODEMP').AsString := Pc_Cd_Cliente;
  Qr_Vendas.ParamByName('DATAINI').AsString := Pc_DataIni;
  Qr_Vendas.ParamByName('DATAFIM').AsString := Pc_DataFim;
  if NOT Fr_Imp_Vendas.Fm_LME.chbx_Empresas.Checked then
    Qr_Vendas.ParamByName('NFL_CODMHA').AsInteger := Fr_Imp_Vendas.Fm_LME.Dblcb_Lista.KeyValue;

  Qr_Vendas.Active := true;
  Qr_Vendas.FetchAll;
  Qr_Vendas.First;
  if Pc_Periodo = 'M' then
  begin
    while not Qr_Vendas.Eof do
    begin
      if (Qr_Vendas.FieldByName('NFL_DATA').AsString = ('01/' + It_Vendas[6, 1] + '/' + It_Vendas[6, 2])) then
        StrGrd_Vendas.Cells[2, Pc_Indice ]:= FloatToStrF(Qr_Vendas.FieldByName('VDA_VL_TOTAL').AsCurrency,ffNumber,10,2);

      if (Qr_Vendas.FieldByName('NFL_DATA').AsString = ('01/' + It_Vendas[7, 1] + '/' + It_Vendas[7, 2])) then
        StrGrd_Vendas.Cells[3, Pc_Indice] := FloatToStrF(Qr_Vendas.FieldByName('VDA_VL_TOTAL').AsCurrency,ffNumber,10,2);
      if (Qr_Vendas.FieldByName('NFL_DATA').AsString = ('01/' + It_Vendas[8, 1] + '/' + It_Vendas[8, 2])) then
        StrGrd_Vendas.Cells[4, Pc_Indice] := FloatToStrF(Qr_Vendas.FieldByName('VDA_VL_TOTAL').AsCurrency,ffNumber,10,2);
      if (Qr_Vendas.FieldByName('NFL_DATA').AsString = ('01/' + It_Vendas[9, 1] + '/' + It_Vendas[9, 2])) then
        StrGrd_Vendas.Cells[5, Pc_Indice] := FloatToStrF(Qr_Vendas.FieldByName('VDA_VL_TOTAL').AsCurrency,ffNumber,10,2);
      if (Qr_Vendas.FieldByName('NFL_DATA').AsString = ('01/' + It_Vendas[10, 1] + '/' + It_Vendas[10, 2])) then
        StrGrd_Vendas.Cells[6, Pc_Indice] := FloatToStrF(Qr_Vendas.FieldByName('VDA_VL_TOTAL').AsCurrency,ffNumber,10,2);
      if (Qr_Vendas.FieldByName('NFL_DATA').AsString = ('01/' + It_Vendas[11, 1] + '/' + It_Vendas[11, 2])) then
        StrGrd_Vendas.Cells[7, Pc_Indice] := FloatToStrF(Qr_Vendas.FieldByName('VDA_VL_TOTAL').AsCurrency,ffNumber,10,2);
      Qr_Vendas.Next;
    end;
  end
  else
  begin
    StrGrd_Vendas.Cells[8, Pc_Indice] := FloatToStrF(Qr_Vendas.FieldByName('VDA_VL_TOTAL').AsCurrency,ffNumber,10,2);
  end;
  Screen.Cursor := crDefault;
end;

function TRL_VendaMeses.Pc_BuscaVendaMarca(Pc_Periodo: string; Pc_Indice: Integer; Pc_Cd_Marca: string; Pc_DataIni: string; Pc_DataFim: string): real;
var
  Lc_valor: real;
  Lc_I: Integer;
begin
  Screen.Cursor := crHourGlass;
  Qr_MarcaProduto.Active := True;
  Qr_MarcaProduto.First;
  Lc_valor := 0;
  //Calcula Vendas
  IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.Commit;
  Qr_Vendas.Active := false;
  if (Pc_Cd_Marca <> '') then
    Qr_Vendas.ParamByName('PRO_CODMRC').AsString := Pc_Cd_Marca;
  if NOT Fr_Imp_Vendas.Fm_LME.chbx_Empresas.Checked then
    Qr_Vendas.ParamByName('NFL_CODMHA').AsInteger := Fr_Imp_Vendas.Fm_LME.Dblcb_Lista.KeyValue;

  Qr_Vendas.ParamByName('DATAINI').AsString := Pc_DataIni;
  Qr_Vendas.ParamByName('DATAFIM').AsString := Pc_DataFim;
  Qr_Vendas.Active := true;
  Qr_Vendas.FetchAll;
  Qr_Vendas.First;
  if Pc_Periodo = 'M' then
  begin
    while not Qr_Vendas.Eof do
    begin
      if (Qr_Vendas.FieldByName('NFL_DATA').AsString = ('01/' + It_Vendas[6, 1] + '/' + It_Vendas[6, 2])) then
        StrGrd_Marcas.Cells[2, Pc_Indice] := FloatToStrF( Qr_Vendas.FieldByName('VDA_VL_TOTAL').AsCurrency,ffNumber,10,2);
      if (Qr_Vendas.FieldByName('NFL_DATA').AsString = ('01/' + It_Vendas[7, 1] + '/' + It_Vendas[7, 2])) then
        StrGrd_Marcas.Cells[3, Pc_Indice] := FloatToStrF(Qr_Vendas.FieldByName('VDA_VL_TOTAL').AsCurrency,ffNumber,10,2);
      if (Qr_Vendas.FieldByName('NFL_DATA').AsString = ('01/' + It_Vendas[8, 1] + '/' + It_Vendas[8, 2])) then
        StrGrd_Marcas.Cells[4, Pc_Indice] := FloatToStrF(Qr_Vendas.FieldByName('VDA_VL_TOTAL').AsCurrency,ffNumber,10,2);
      if (Qr_Vendas.FieldByName('NFL_DATA').AsString = ('01/' + It_Vendas[9, 1] + '/' + It_Vendas[9, 2])) then
        StrGrd_Marcas.Cells[5, Pc_Indice] := FloatToStrF(Qr_Vendas.FieldByName('VDA_VL_TOTAL').AsCurrency,ffNumber,10,2);
      if (Qr_Vendas.FieldByName('NFL_DATA').AsString = ('01/' + It_Vendas[10, 1] + '/' + It_Vendas[10, 2])) then
        StrGrd_Marcas.Cells[6, Pc_Indice] := FloatToStrF(Qr_Vendas.FieldByName('VDA_VL_TOTAL').AsCurrency,ffNumber,10,2);
      if (Qr_Vendas.FieldByName('NFL_DATA').AsString = ('01/' + It_Vendas[11, 1] + '/' + It_Vendas[11, 2])) then
        StrGrd_Marcas.Cells[7, Pc_Indice] := FloatToStrF(Qr_Vendas.FieldByName('VDA_VL_TOTAL').AsCurrency,ffNumber,10,2);
      Qr_Vendas.Next;
    end;
  end
  else
  begin
    StrGrd_Marcas.Cells[8, Pc_Indice] := FloatToStrF(Qr_Vendas.FieldByName('VDA_VL_TOTAL').AsCurrency,ffNumber,10,2);
  end;
  Screen.Cursor := crDefault;
end;

procedure TRL_VendaMeses.Pc_PreencheMatrizVendas;
var
  Lc_I, Lc_J, Lc_contador: Integer;
  Lc_DataIni: string;
  Lc_DataFim: string;
  Lc_Vl_Total: Real;
  Lc_Texto: Real;
begin
  Fr_Imp_Vendas.Gg_Progresso.Progress := 0;
  Fr_Imp_Vendas.Gg_Progresso.MinValue := 0;
  Fr_Imp_Vendas.Gg_Progresso.MaxValue := (It_Nr_Clientes);
  Fr_Imp_Vendas.Lb_Processo.Caption := 'Preenchendo a Tabela de Venda';
  Application.ProcessMessages;
  Lc_contador := 0;

  for Lc_I := 1 to (It_Nr_Clientes ) do
  begin
    Pc_DefineSql('M', True, False);
    Fr_Imp_Vendas.Lb_Processo.Caption := 'Processando : Vendas do cliente ' + StrGrd_Vendas.Cells[1, Lc_I];
    Application.ProcessMessages;
    Lc_Vl_Total := 0;
    Lc_DataIni := '01/' + It_Vendas[6, 1] + '/' + It_Vendas[6, 2];
    Lc_DataFim := It_Vendas[11, 0] + '/' + It_Vendas[11, 1] + '/' + It_Vendas[11, 2];
    Pc_BuscaVenda('M', Lc_I, StrGrd_Vendas.Cells[0, Lc_I], Lc_DataIni, Lc_DataFim);
    Lc_Vl_Total := Lc_Vl_Total + StrToFloatDef( StrGrd_Vendas.Cells[2, Lc_I],0);
    Lc_Vl_Total := Lc_Vl_Total + StrToFloatDef( StrGrd_Vendas.Cells[3, Lc_I],0);
    Lc_Vl_Total := Lc_Vl_Total + StrToFloatDef( StrGrd_Vendas.Cells[4, Lc_I],0);
    Lc_Vl_Total := Lc_Vl_Total + StrToFloatDef( StrGrd_Vendas.Cells[5, Lc_I],0);
    Lc_Vl_Total := Lc_Vl_Total + StrToFloatDef( StrGrd_Vendas.Cells[6, Lc_I],0);
    Lc_Vl_Total := Lc_Vl_Total + StrToFloatDef( StrGrd_Vendas.Cells[7, Lc_I],0);
    //Soma dos valores
    StrGrd_Vendas.Cells[9, Lc_I] := FloatToStrF( Lc_Vl_Total,ffNumber,10,2);
    Fr_Imp_Vendas.Gg_Progresso.Progress := Fr_Imp_Vendas.Gg_Progresso.Progress + 1;
    Application.ProcessMessages;

    //Valor Total do Ano Anterior
    Lc_DataIni := '01/' + It_Vendas[6, 1] + '/' + IntToStr(StrToInt(It_Vendas[6, 2]) - 1);
    Lc_DataFim := It_Vendas[11, 0] + '/' + It_Vendas[11, 1] + '/' + IntToStr(StrToInt(It_Vendas[11, 2]) - 1);
    Pc_BuscaVenda('A', Lc_I, StrGrd_Vendas.Cells[0, Lc_I], Lc_DataIni, Lc_DataFim);
  end;
  Application.ProcessMessages;
end;

procedure TRL_VendaMeses.Pc_PreencheMatrizVendasMarcas;
var
  Lc_I, Lc_J, Lc_contador: Integer;
  Lc_DataIni: string;
  Lc_DataFim: string;
  Lc_Vl_Total: Real;
  Lc_Texto: Real;
begin
  Fr_Imp_Vendas.Gg_Progresso.Progress := 0;
  Fr_Imp_Vendas.Gg_Progresso.MinValue := 0;
  Fr_Imp_Vendas.Gg_Progresso.MaxValue := (It_Nr_MArcas);
  Fr_Imp_Vendas.Lb_Processo.Caption := 'Preenchendo a Tabela de Venda por Marca';
  Application.ProcessMessages;
  Lc_contador := 0;

  for Lc_I := 1 to (It_Nr_MArcas) do
  begin
    Pc_DefineSql('M', False, True);
    Fr_Imp_Vendas.Lb_Processo.Caption := 'Processando : Vendas por Marca ' + StrGrd_Marcas.Cells[1, Lc_I];
    Application.ProcessMessages;
    Lc_Vl_Total := 0;
    Lc_DataIni := '01/' + It_Vendas[6, 1] + '/' + It_Vendas[6, 2];
    Lc_DataFim := It_Vendas[11, 0] + '/' + It_Vendas[11, 1] + '/' + It_Vendas[11, 2];
    Pc_BuscaVendaMarca('M', Lc_I, StrGrd_Marcas.Cells[0, Lc_I], Lc_DataIni, Lc_DataFim);
    Application.ProcessMessages;
    Lc_Vl_Total := Lc_Vl_Total + StrToFloatDef( StrGrd_Marcas.Cells[2, Lc_I],0);
    Lc_Vl_Total := Lc_Vl_Total + StrToFloatDef( StrGrd_Marcas.Cells[3, Lc_I],0);
    Lc_Vl_Total := Lc_Vl_Total + StrToFloatDef( StrGrd_Marcas.Cells[4, Lc_I],0);
    Lc_Vl_Total := Lc_Vl_Total + StrToFloatDef( StrGrd_Marcas.Cells[5, Lc_I],0);
    Lc_Vl_Total := Lc_Vl_Total + StrToFloatDef( StrGrd_Marcas.Cells[6, Lc_I],0);
    Lc_Vl_Total := Lc_Vl_Total + StrToFloatDef( StrGrd_Marcas.Cells[7, Lc_I],0);
    //Soma dos valores
    StrGrd_Marcas.Cells[9, Lc_I] := FloatToStrF( Lc_Vl_Total,ffNumber,10,2);
    Fr_Imp_Vendas.Gg_Progresso.Progress := Fr_Imp_Vendas.Gg_Progresso.Progress + 1;
    Application.ProcessMessages;

    //Valor Total do Ano Anterior
    Lc_DataIni := '01/' + It_Vendas[6, 1] + '/' + IntToStr(StrToInt(It_Vendas[6, 2]) - 1);
    Lc_DataFim := It_Vendas[11, 0] + '/' + It_Vendas[11, 1] + '/' + IntToStr(StrToInt(It_Vendas[11, 2]) - 1);
    Pc_BuscaVendaMarca('A', Lc_I, StrGrd_Marcas.Cells[0, Lc_I], Lc_DataIni, Lc_DataFim);
  end;
  Application.ProcessMessages;
end;

function TRL_VendaMeses.Pc_Cabecalho(Nr_Linha: Integer): Integer;
var
  Lc_Coluna, Lc_ID, Lc_I: Integer;
  Lc_StrCell, Lc_StrCell_, Lc_SQLTXT: string;
  AdtoMru, CreateBck, ROREcommended, ReadOnly: OleVariant;
begin
  It_Mes := StrtoInt(Copy(DateToStr(Fr_Imp_Vendas.E_Data_Fim.Date), 4, 2));
  It_Ano := StrtoInt(Copy(DateToStr(Fr_Imp_Vendas.E_Data_FIM.dAte), 7, 4));
  for Lc_I := 11 downto 6 do
  begin
    if It_Mes = 0 then
    begin
      It_Mes := 12;
      It_Ano := It_Ano - 1;
    end;
    It_Dia := UltDiaDoMes(StrToDate('01/' + IntToStr(It_Mes) + '/' + IntToStr(It_Ano)));
    It_Vendas[Lc_I, 0] := StrZero(It_Dia, 2, 0);
    It_Vendas[Lc_I, 1] := StrZero(It_Mes, 2, 0);
    It_Vendas[Lc_I, 2] := StrZero(It_Ano, 4, 0);
    It_Mes := It_Mes - 1;
  end;


    Lc_StrCell := 'A' + IntToStr(Nr_Linha);
    Lc_StrCell_ := 'I' + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell_].Merge(xlCenter);
    Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := DM.Qr_Estabelecimento.FieldByName('EMP_NOME').AsString;

    Inc(Nr_Linha);
    Lc_StrCell := 'A' + IntToStr(Nr_Linha);
    Lc_StrCell_ := 'I' + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell_].Merge(xlAutomatic);
    Excel.Range[Lc_StrCell, Lc_StrCell_].Value2 := DM.Qr_Estabelecimento.FieldByName('END_ENDER').AsString;

    Inc(Nr_Linha);
    Lc_StrCell := 'A' + IntToStr(Nr_Linha);
    Lc_StrCell_ := 'I' + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell_].Merge(xlAutomatic);
    Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := DM.Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString +  ' - ' + DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString +  ', ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString;

    Inc(Nr_Linha);
    Lc_StrCell := 'A' + IntToStr(Nr_Linha);
    Lc_StrCell_ := 'I' + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell_].Merge(xlAutomatic);

    Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := concat('FONE/EMAIL: ',fc_MascaraFone(DM.Qr_Estabelecimento.FieldByName('END_FONE').AsString));

    Inc(Nr_Linha);
    Lc_StrCell := 'A' + IntToStr(Nr_Linha);
    Lc_StrCell_ := 'I' + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell_].Merge(xlCenter);
    Excel.Range[Lc_StrCell,Lc_StrCell].Font.Bold := True;
    Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := 'RELATORIO MENSAL DE VENDAS - CLIENTE';
    Excel.Range[Lc_StrCell, Lc_StrCell_].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));

    Inc(Nr_Linha);
    Lc_StrCell :=  fc_PegaLetraColuna(1) + IntToStr(Nr_Linha);
    Lc_StrCell_ :=  fc_PegaLetraColuna(9) + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell_].Merge(xlCenter);
    Excel.Range[Lc_StrCell, Lc_StrCell_].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));

    Inc(Nr_Linha);
    Lc_StrCell := 'A' + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := 'NOME DA EMPRESA';
    Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));

    Lc_StrCell := 'B' + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := It_Vendas[6, 1] + '/' + It_Vendas[6, 2];
    Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));

    Lc_StrCell := 'C' + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := It_Vendas[7, 1] + '/' + It_Vendas[7, 2];
    Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));

    Lc_StrCell := 'D' + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := It_Vendas[8, 1] + '/' + It_Vendas[8, 2];
    Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));

    Lc_StrCell := 'E' + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := It_Vendas[9, 1] + '/' + It_Vendas[9, 2];
    Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));

    Lc_StrCell := 'F' + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := It_Vendas[10, 1] + '/' + It_Vendas[10, 2];
    Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));

    Lc_StrCell := 'G' + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := It_Vendas[11, 1] + '/' + It_Vendas[11, 2];
    Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));

    Lc_StrCell := 'H' + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := 'Ultimo Ano';
    Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));

    Lc_StrCell := 'I' + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := 'Total';
    Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
    Inc(Nr_Linha);
    Lc_StrCell :=  fc_PegaLetraColuna(1) + IntToStr(Nr_Linha);
    Lc_StrCell_ :=  fc_PegaLetraColuna(9) + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell_].Merge(xlCenter);
    Excel.Range[Lc_StrCell, Lc_StrCell_].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));

    Inc(Nr_Linha);
    Result := Nr_Linha;
end;

function TRL_VendaMeses.Pc_Corpo(Nr_Linha: Integer): Integer;
var
  Lc_Coluna, Lc_ID, Lc_I: Integer;
  Lc_StrCell, Lc_StrCell_, Lc_SQLTXT: string;
  AdtoMru, CreateBck, ROREcommended, ReadOnly: OleVariant;
  Lc_Aux : String;
begin
  Fr_Imp_Vendas.Gg_Progresso.Progress := 0;
  Fr_Imp_Vendas.Gg_Progresso.MinValue := 0;
  Fr_Imp_Vendas.Gg_Progresso.MaxValue := StrGrd_Vendas.RowCount - 1;
  Fr_Imp_Vendas.Lb_Processo.Caption := 'Exportando para Excel';
  Application.ProcessMessages;

  for Lc_I := 1 To StrGrd_Vendas.RowCount - 1 do
  begin
    for Lc_Coluna := 1 To StrGrd_Vendas.ColCount-1 do
    begin
      Lc_StrCell :=  fc_PegaLetraColuna(Lc_Coluna) + IntToStr(Nr_Linha);
      if Lc_Coluna > 1 then
      Begin
        Lc_Aux := Fc_RemoveCaracterInformado(StrGrd_Vendas.Cells[Lc_Coluna, Lc_I], ['.']);
        Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := StrToFloatDef(Lc_Aux,0);
        Excel.Range[Lc_StrCell,Lc_StrCell].Style := 'Comma';
        Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      end
      else
      Begin
        Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := StrGrd_Vendas.Cells[Lc_Coluna, Lc_I] ;
        Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      end;
    end;
    inc(Nr_Linha);
    Fr_Imp_Vendas.Gg_Progresso.Progress := Lc_I;
    Application.ProcessMessages;
  end;

  Lc_StrCell :=  fc_PegaLetraColuna(1) + IntToStr(Nr_Linha);
  Lc_StrCell_ :=  fc_PegaLetraColuna(9) + IntToStr(Nr_Linha);
  Excel.Range[Lc_StrCell, Lc_StrCell_].Merge(xlCenter);
  Excel.Range[Lc_StrCell, Lc_StrCell_].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));

  inc(Nr_Linha);
  Lc_StrCell :=  fc_PegaLetraColuna(1) + IntToStr(Nr_Linha);
  Excel.Range[Lc_StrCell,Lc_StrCell].Font.Bold := True;
  Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := 'VALOR TOTAL DOS CLIENTES';

  for Lc_Coluna := 2 To StrGrd_Vendas.ColCount-1 do
  begin
    Lc_StrCell :=  fc_PegaLetraColuna(Lc_Coluna) + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := '=SUM(R[-' + IntToStr(Nr_Linha - 9 ) + ']C:R[-2]C)';
    Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
    Excel.Range[Lc_StrCell,Lc_StrCell].Style := 'Comma';
    Excel.Range[Lc_StrCell,Lc_StrCell].Font.Bold := True;
  end;

  inc(Nr_Linha);
  Lc_StrCell :=  fc_PegaLetraColuna(1) + IntToStr(Nr_Linha);
  Lc_StrCell_ :=  fc_PegaLetraColuna(9) + IntToStr(Nr_Linha);
  Excel.Range[Lc_StrCell, Lc_StrCell_].Merge(xlCenter);
  Excel.Range[Lc_StrCell, Lc_StrCell_].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));

  Inc(Nr_Linha);
  Result := Nr_Linha;

end;

function TRL_VendaMeses.Pc_Marca(Nr_Linha: Integer): Integer;
var
  Lc_Coluna, Lc_ID, Lc_I: Integer;
  Lc_StrCell, Lc_StrCell_, Lc_SQLTXT: string;
  AdtoMru, CreateBck, ROREcommended, ReadOnly: OleVariant;
  Lc_valor: real;
  Lc_Aux : String;
  Lc_Linha_Marca : Integer;
begin
  Fr_Imp_Vendas.Gg_Progresso.Progress := 0;
  Fr_Imp_Vendas.Gg_Progresso.MinValue := 0;
  Fr_Imp_Vendas.Gg_Progresso.MaxValue := StrGrd_Vendas.RowCount - 1;
  Fr_Imp_Vendas.Lb_Processo.Caption := 'Exportando para Excel';
  Application.ProcessMessages;

  Lc_Linha_Marca:= 1;
  for Lc_I := 1 To StrGrd_Marcas.RowCount - 1 do
  begin
    for Lc_Coluna := 1 To StrGrd_Marcas.ColCount-1 do
    begin
      Lc_StrCell :=  fc_PegaLetraColuna(Lc_Coluna) + IntToStr(Nr_Linha);
      if Lc_Coluna > 1 then
      Begin
        Lc_Aux := Fc_RemoveCaracterInformado(StrGrd_Marcas.Cells[Lc_Coluna, Lc_I], ['.']);
        Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := StrToFloatDef(Lc_Aux,0);
        Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
        Excel.Range[Lc_StrCell,Lc_StrCell].Style := 'Comma';
      end
      else
      Begin
        Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := StrGrd_Marcas.Cells[Lc_Coluna, Lc_I] ;
        Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      end;
    end;
    inc(Nr_Linha);
    inc(Lc_Linha_Marca);
    Fr_Imp_Vendas.Gg_Progresso.Progress := Lc_I;
    Application.ProcessMessages;
  end;

  Lc_StrCell :=  fc_PegaLetraColuna(1) + IntToStr(Nr_Linha);
  Lc_StrCell_ :=  fc_PegaLetraColuna(9) + IntToStr(Nr_Linha);
  Excel.Range[Lc_StrCell, Lc_StrCell_].Merge(xlCenter);
  Excel.Range[Lc_StrCell, Lc_StrCell_].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));

  inc(Nr_Linha);
  Lc_StrCell :=  fc_PegaLetraColuna(1) + IntToStr(Nr_Linha);
  Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
  Excel.Range[Lc_StrCell,Lc_StrCell].Font.Bold := True;
  Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := 'VALOR TOTAL DAS MARCAS';

  for Lc_Coluna := 2 To StrGrd_Vendas.ColCount-1 do
  begin
    Lc_StrCell :=  fc_PegaLetraColuna(Lc_Coluna) + IntToStr(Nr_Linha);
    Excel.Range[Lc_StrCell, Lc_StrCell].Value2 := '=SUM(R[-' + IntToStr(Lc_Linha_Marca ) + ']C:R[-2]C)';
    Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
    Excel.Range[Lc_StrCell,Lc_StrCell].Style := 'Comma';
    Excel.Range[Lc_StrCell,Lc_StrCell].Font.Bold := True;
  end;
  Inc(Nr_Linha);
  Result := Nr_Linha;
end;


procedure TRL_VendaMeses.FormCreate(Sender: TObject);
begin
  StrGrd_Vendas.ColCount := 10;
  StrGrd_Vendas.ColWidths[0] := -1;
  StrGrd_Vendas.ColWidths[1] := 200;
  StrGrd_Vendas.ColWidths[2] := 70;
  StrGrd_Vendas.ColWidths[3] := 70;
  StrGrd_Vendas.ColWidths[4] := 70;
  StrGrd_Vendas.ColWidths[5] := 70;
  StrGrd_Vendas.ColWidths[6] := 70;
  StrGrd_Vendas.ColWidths[7] := 70;
  StrGrd_Vendas.ColWidths[8] := 70;
  StrGrd_Vendas.ColWidths[9] := 70;

  StrGrd_Marcas.ColCount := 10;
  StrGrd_Marcas.ColWidths[0] := 20;
  StrGrd_Marcas.ColWidths[1] := 200;
  StrGrd_Marcas.ColWidths[2] := 70;
  StrGrd_Marcas.ColWidths[3] := 70;
  StrGrd_Marcas.ColWidths[4] := 70;
  StrGrd_Marcas.ColWidths[5] := 70;
  StrGrd_Marcas.ColWidths[6] := 70;
  StrGrd_Marcas.ColWidths[7] := 70;
  StrGrd_Marcas.ColWidths[8] := 70;
  StrGrd_Marcas.ColWidths[9] := 70;
  
end;

procedure TRL_VendaMeses.ExportDados;
Var
  LcLinha : Integer;
begin
  LcLinha := 1;
  Pc_AtivaEstabelecimento;
  LcLinha := Pc_Cabecalho(LcLinha);
  LcLinha := Pc_Corpo(LcLinha);
  LcLinha := Pc_Marca(LcLinha);
  excel.columns.AutoFit;
  excel.visible := true;
end;

procedure TRL_VendaMeses.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  RL_VendaMeses := nil;
end;

end.

