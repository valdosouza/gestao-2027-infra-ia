unit UN_Imp_CtasGerenciais;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, DBClient, OleServer, StdCtrls, Grids, DBGrids, ControllerBase, Buttons, Gauges, STQuery, DBCtrls, Mask, ExtCtrls, Excel2000, ComCtrls, ExcelXP, Un_Fm_CentroCusto, Un_Fm_CentroResultado, ComObj, Un_Fm_ListaMultiEmpresa, base_frame_list;


type
  TFr_Imp_CtasGerenciais = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    SaveDialogo: TSaveDialog;
    Qr_plano: TSTQuery;
    Qr_Acao: TSTQuery;
    Qr_Movimento: TSTQuery;
    Label4: TLabel;
    CB_Tipo: TComboBox;
    SB_Imprimir: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Qr_Contas: TSTQuery;
    Rg_Tipo: TRadioGroup;
    Panel3: TPanel;
    Lb_Processo: TLabel;
    Gg_Progresso: TGauge;
    PageControl1: TPageControl;
    tbs_CentroCusto: TTabSheet;
    Tbs_CentroResultado: TTabSheet;
    Fm_CentroCustoInicial: TFm_CentroCusto;
    Fm_CentroCustoFinal: TFm_CentroCusto;
    Fm_CentroResultadoInicial: TFm_CentroResultado;
    Fm_CentroResultadoFinal: TFm_CentroResultado;
    Label1: TLabel;
    Label2: TLabel;
    ChBx_MovimentoMensal: TCheckBox;
    Fm_LME: TFm_ListaMultiEmpresa;
    cds_Movimento: TClientDataSet;
    cds_MovimentoPLC_CODIGO: TStringField;
    cds_MovimentoPLC_CODPLANO: TStringField;
    cds_MovimentoPLC_DESCRICAO: TStringField;
    cds_MovimentoPLC_NATUREZA: TStringField;
    cds_MovimentoPLC_TIPO: TStringField;
    cds_MovimentoPLC_VL_CREDITO: TFloatField;
    cds_MovimentoPLC_VL_DEBITO: TFloatField;
    Qr_MovimentoCTG_DATA: TDateField;
    Qr_MovimentoCTG_TIPO: TStringField;
    Qr_MovimentoCTG_CONTA: TIntegerField;
    Qr_MovimentoCTG_HISTORISCO: TStringField;
    Qr_MovimentoCTG_VL_CREDITO: TBCDField;
    Qr_MovimentoCTG_VL_DEBITO: TBCDField;
    DataSource1: TDataSource;
    cds_MovimentoPLC_NIVEL: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SB_ImprimirClick(Sender: TObject);
    procedure SB_VoltarClick(Sender: TObject);
    procedure Sb_ExportarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CB_TipoChange(Sender: TObject);
    procedure Fm_CentroCustoInicialSb_PlanoClick(Sender: TObject);

  private
    { Private declarations }
      DataInicialAnterior : TDate;
      DataFinalAnterior : TDate;
      function getCodigoPLano(Codigo:String):String;
  public
    { Public declarations }
  It_Visualizar :Boolean;
  It_Imprimir :Boolean;
  It_Exportar :Boolean;
  procedure Pc_DefineDataAnteriror;

  procedure Pc_PreencheMatriz;
  procedure Pc_TotalizaMatriz;
  procedure Pc_ExportaContas;

  procedure Pc_PermissaoBotao(Pc_Menu: string);
  procedure Pc_ImagemBotao;
  procedure Pc_CtaGerencialPrevisto(Pc_Operacao,Pc_Caminho:String);
  procedure Pc_CtaGerencialRealizado(Pc_Operacao,Pc_Caminho:String);
  procedure Pc_CtaGerencialExcel(Pc_Operacao,Pc_Caminho:String);
  procedure Pc_Buscar(Tipo:String);
  procedure Pc_AtivaTabelas;
  procedure GeraExcel(Grid:TStringGrid);
  end;

var
  Fr_Imp_CtasGerenciais: TFr_Imp_CtasGerenciais;

implementation

uses     UN_RL_CtasGerenciais, UN_Sistema, Un_DM, UN_Principal, env, Un_Rl_CtasGerenciaisRealizado, Un_Regra_Negocio, Un_Rl_CtasGerenciaisPrevisto, RN_PlanoContas, UN_TabelasEmListas, Un_Funcoes, ControllerFechaFinanceiro, Un_Excel, Un_Msg;
{$R *.DFM}


procedure TFr_Imp_CtasGerenciais.PC_PreencheMatriz;
Var
  Lc_Data, Lc_Plano : Boolean;
  Lc_Sequencia : Integer;
  Lc_Seq_Sintetico : String;
  Lc_Progresso : Integer;
  Lc_TotalCredito : Real;
  Lc_TotalDebito : Real;
Begin
  Qr_Movimento.Active := False;
  Qr_Movimento.SQL.Clear;
  Qr_Movimento.SQL.Add(
                   concat('SELECT CTG_DATA, CTG_TIPO, CTG_CONTA,          ',
                          'CTG_HISTORISCO, CTG_VL_CREDITO, CTG_VL_DEBITO  ',
                          'FROM VW_CTAS_GERENCIAIS                        ',
                          'WHERE (CTG_DATA IS NOT NULL)                   ',
                          ' AND (CTG_CONTA =:CTG_CONTA)                   ',
                          ' AND (CTG_DATA BETWEEN :DATAINI AND :DATAFIM)  ',
                          'Order by CTG_DATA,CTG_HISTORISCO               '
                   ));

  Qr_plano.Active := True;
  Qr_plano.FetchAll;
  Gg_Progresso.MinValue := 0;
  Gg_Progresso.Progress := 0;
  Gg_Progresso.MaxValue := Qr_plano.RecordCount;
  Lb_Processo.Caption := 'Processando a Tabela';
  Application.ProcessMessages;

  IF NOT cds_Movimento.Active THEN cds_Movimento.CreateDataSet;
  cds_Movimento.LogChanges := False;
  cds_Movimento.EmptyDataSet;
  Lc_Sequencia := 0;
  Lc_Progresso := 0;

  while not Qr_plano.Eof do
  begin
    Lb_Processo.Caption := concat('Exportando detalhes de ',Qr_plano.FieldByName('PLC_DESCRICAO').asstring);
    Application.ProcessMessages;
    Lc_Progresso := Lc_Progresso + 1;
    Lc_Sequencia := Lc_Sequencia + 1;
    cds_Movimento.Append;
    cds_MovimentoPLC_CODIGO.AsString    := Qr_plano.FieldByName('PLC_CODIGO').asstring;
    cds_MovimentoPLC_CODPLANO.AsString  := Qr_plano.FieldByName('PLC_CODPLANO').asstring;
    cds_MovimentoPLC_DESCRICAO.AsString := Qr_plano.FieldByName('PLC_DESCRICAO').asstring;
    cds_MovimentoPLC_NIVEL.AsString     := Qr_plano.FieldByName('PLC_NIVEL').asstring;
    cds_MovimentoPLC_TIPO.AsString      := Qr_plano.FieldByName('PLC_TIPO').asstring;
    if Qr_plano.FieldByName('PLC_NIVEL').AsString = 'S' then
    Begin
      Lc_Seq_Sintetico := IntToStr(Lc_Sequencia);
      //Salva o registro sintetico
      cds_Movimento.Post;
    end
    else
    Begin
      //Salva o registro Analitico
      cds_Movimento.Post;
      //Preenche com os dados do Movimento dEtalhadado
      Qr_Movimento.Active := False;
      Qr_Movimento.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      Qr_Movimento.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
      Qr_Movimento.ParamByName('CTG_CONTA').AsInteger := Qr_Plano.FieldByName('PLC_CODIGO').AsInteger;
      Qr_Movimento.Active := True;
      Qr_Movimento.FetchAll;
      Qr_Movimento.First;
      Lc_TotalCredito := 0;
      Lc_TotalDebito  := 0;
      while not Qr_Movimento.Eof do
      Begin
        Lc_Sequencia := Lc_Sequencia + 1;
        cds_Movimento.Append;
        cds_MovimentoPLC_CODIGO.AsString    := '';
        cds_MovimentoPLC_CODPLANO.AsString  := '';
        cds_MovimentoPLC_DESCRICAO.AsString := FormatDateTime('mm/dd/yyyy', Qr_Movimento.FieldByName('CTG_DATA').AsDateTime );
        cds_MovimentoPLC_NATUREZA.AsString  := Qr_Movimento.FieldByName('CTG_HISTORISCO').asstring;
        cds_MovimentoPLC_TIPO.AsString      := Qr_Movimento.FieldByName('CTG_TIPO').AsString;
        cds_MovimentoPLC_NIVEL.AsString     := 'D';
        if Qr_Movimento.FieldByName('CTG_TIPO').AsString = 'C' then
        Begin
          cds_MovimentoPLC_VL_CREDITO.AsCurrency := ABS(Qr_Movimento.FieldByName('CTG_VL_CREDITO').AsCurrency - Qr_Movimento.FieldByName('CTG_VL_DEBITO').AsCurrency);
          Lc_TotalCredito := Lc_TotalCredito + cds_MovimentoPLC_VL_CREDITO.AsCurrency;
          cds_MovimentoPLC_VL_DEBITO.AsCurrency := 0;
        end
        else
        Begin
          cds_MovimentoPLC_VL_CREDITO.AsCurrency := 0;
          cds_MovimentoPLC_VL_DEBITO.AsCurrency  := ABS(Qr_Movimento.FieldByName('CTG_VL_DEBITO').AsCurrency - Qr_Movimento.FieldByName('CTG_VL_CREDITO').AsCurrency);
          Lc_TotalDebito := Lc_TotalDebito + cds_MovimentoPLC_VL_DEBITO.AsCurrency;
        end;
        cds_Movimento.Post;
        Qr_Movimento.Next;
      end;
    end;
    Gg_Progresso.Progress := Lc_Progresso;
    Application.ProcessMessages;
    Qr_plano.Next;
  end;
End;



procedure TFr_Imp_CtasGerenciais.Pc_TotalizaMatriz;
Var
  lc_I, lc_J : Integer;
  Lc_Vl_Cred_Analitico,Lc_Vl_Debi_Analitico : Real;
  Lc_Vl_Cred_Sintetico,Lc_Vl_Debi_Sintetico : Real;
Begin
  Lc_J := 0;
  Gg_Progresso.MinValue := 0;
  Gg_Progresso.MaxValue := cds_Movimento.RecordCount;
  Lc_Vl_Cred_Analitico := 0;
  Lc_Vl_Debi_Analitico := 0;
  Lc_Vl_Cred_Sintetico := 0;
  Lc_Vl_Debi_Sintetico := 0;
  Lb_Processo.Caption := 'Totalizando a Tabela';
  cds_Movimento.Last;
  for lc_I := cds_Movimento.RecordCount  downto 1 do
  Begin
    if cds_MovimentoPLC_NIVEL.AsString = 'D' then
    Begin
      Lc_Vl_Cred_Analitico := Lc_Vl_Cred_Analitico + cds_MovimentoPLC_VL_CREDITO.AsCurrency;
      Lc_Vl_Debi_Analitico := Lc_Vl_Debi_Analitico + cds_MovimentoPLC_VL_DEBITO.AsCurrency;
      Lc_Vl_Cred_Sintetico := Lc_Vl_Cred_Sintetico + cds_MovimentoPLC_VL_CREDITO.AsCurrency;
      Lc_Vl_Debi_Sintetico := Lc_Vl_Debi_Sintetico + cds_MovimentoPLC_VL_DEBITO.AsCurrency;
    end
    else
    Begin
      if cds_MovimentoPLC_NIVEL.AsString = 'A' then
      Begin
        cds_Movimento.Edit;
        cds_MovimentoPLC_VL_CREDITO.AsCurrency := Lc_Vl_Cred_Analitico;
        cds_MovimentoPLC_VL_DEBITO.AsCurrency := Lc_Vl_Debi_Analitico;
        cds_Movimento.Post;
        Lc_Vl_Cred_Analitico := 0;
        Lc_Vl_Debi_Analitico := 0;
      end
      else
      Begin
        cds_Movimento.Edit;
        cds_MovimentoPLC_VL_CREDITO.AsCurrency := Lc_Vl_Cred_Sintetico;
        cds_MovimentoPLC_VL_DEBITO.AsCurrency := Lc_Vl_Debi_Sintetico;
        cds_Movimento.Post;
        Lc_Vl_Cred_Sintetico := 0;
        Lc_Vl_Debi_Sintetico := 0;
        Lc_Vl_Cred_Analitico := 0;
        Lc_Vl_Debi_Analitico := 0;
      end;
    end;
    inc(lc_J);
    Gg_Progresso.Progress := Lc_J;
    cds_Movimento.Prior;
    Application.ProcessMessages;
  end;
end;

procedure TFr_Imp_CtasGerenciais.Pc_ExportaContas;
var
  Lc_Linha, Lc_Coluna, Lc_ID  : Integer;
  Lc_StrCell                    : String;
  // Criado Vaviaveis by Gustavo
  AdtoMru, CreateBck, ROREcommended : OleVariant;
  Lc_NomeArquivo : String;
  Excel : TExcelApplication;
begin
  Excel := TExcelApplication.Create(Self);
  Lc_NomeArquivo := SaveDialogo.FileName;
  Gg_Progresso.Visible := true;
  Gg_Progresso.Progress := 0;
  Gg_Progresso.MaxValue := cds_Movimento.RecordCount;
  Lb_Processo.Caption := 'Exportando para Arquivo ' + Lc_NomeArquivo;
  if FileExists(Lc_NomeArquivo)then DeleteFile(Lc_NomeArquivo);
  Lc_ID := GetUserDefaultLCID;
  Excel.Connect;
    try
      Excel.Visible[LC_ID] := False;
      Excel.Workbooks.Add(EmptyParam, LC_ID);

      Lc_Linha := 0;
      IF NOT cds_Movimento.Active THEN cds_Movimento.CreateDataSet;
      cds_Movimento.First;
      while not cds_Movimento.Eof do
      Begin
        Lc_Linha := Lc_Linha + 1;
        for Lc_Coluna := 1 to cds_Movimento.Fields.Count -1 do
        begin
          if  (cds_Movimento.Fields.Fields[Lc_Coluna].DataType = ftFloat) or
              (cds_Movimento.Fields.Fields[Lc_Coluna].DataType = ftBCD) or
              (cds_Movimento.Fields.Fields[Lc_Coluna].DataType = ftCurrency) or
              (cds_Movimento.Fields.Fields[Lc_Coluna].DataType = ftFloat) or
              (cds_Movimento.Fields.Fields[Lc_Coluna].DataType = ftFMTBcd) then
          Begin
            Lc_StrCell := Fc_PegaLetraColuna(Lc_Coluna) + IntToStr(Lc_Linha);
            Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(xlContinuous, xlThin ,xlAutomatic,xlAutomatic);
            Excel.Range[Lc_StrCell,Lc_StrCell].Value2 := cds_Movimento.Fields[Lc_Coluna].AsFloat;
            Excel.Range[Lc_StrCell,Lc_StrCell].Style := 'Comma'
          end
          else
          Begin
              Lc_StrCell := Fc_PegaLetraColuna(Lc_Coluna) + IntToStr(Lc_Linha);
              Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(xlContinuous, xlThin ,xlAutomatic,xlAutomatic);
              if Length(cds_Movimento.Fields[Lc_Coluna].AsString) = 3 then
                Excel.Range[Lc_StrCell,Lc_StrCell].Value2 := concat('''',cds_Movimento.Fields[Lc_Coluna].AsString)
              else
                Excel.Range[Lc_StrCell,Lc_StrCell].Value2 := cds_Movimento.Fields[Lc_Coluna].AsString;
          end;
        end;
        cds_Movimento.Next;
        Gg_Progresso.Progress := Lc_Linha;
        Application.ProcessMessages;
      end;
      Gg_Progresso.Progress := Lc_Linha;
      Application.ProcessMessages;
      //Excel.Range['A1','A1'].FormulaR1C1 := '=SUM(RC[2]:RC[' + IntToStr(7) + '])-RC[1]';
      Excel.Range['A1', Lc_StrCell].EntireColumn.Autofit;

      // Atribuido Valor as variaveis by Gustavo
      AdtoMru       := False;
      CreateBck     := False;
      ROREcommended := False;
      // Alterado Parametros .. by Gustavo
      Excel.ActiveWorkbook.SaveAs(Lc_NomeArquivo, xlnormal, EmptyParam, EmptyParam, ROREcommended, CreateBck,
      xlNoChange, xlUserResolution, AdtoMru, Emptyparam, emptyparam,emptyparam,Lc_ID);


//      ActiveWorkbook.SaveAs(Lc_NomeArquivo, xlnormal, EmptyParam, EmptyParam, ROREcommended, CreateBck,xlNoChange, xlUserResolution, AdtoMru, Emptyparam, emptyparam,emptyparam,Lc_ID);
    finally
      Excel.Quit;
      Excel.Disconnect;
    end;
  Lb_Processo.Caption := 'Exportação concluída com Sucesso!';
end;


procedure TFr_Imp_CtasGerenciais.Fm_CentroCustoInicialSb_PlanoClick(
  Sender: TObject);
begin
  Fm_CentroCustoInicial.Sb_PlanoClick(Sender);

end;

procedure TFr_Imp_CtasGerenciais.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    Action:=caFree;
    Fr_Imp_CtasGerenciais:=nil;
end;


procedure TFr_Imp_CtasGerenciais.Pc_AtivaTabelas;
begin
  Fm_CentroCustoInicial.Pc_ListaParaFiltrar;
  Fm_CentroCustoFinal.Pc_ListaParaFiltrar;
  Fm_CentroResultadoInicial.Pc_ListaParaFiltrar;
  Fm_CentroResultadoFinal.Pc_ListaParaFiltrar;
end;

procedure TFr_Imp_CtasGerenciais.Pc_Buscar(Tipo:String);
Var
  Lc_SqlTxt : String;
  LcCentroCustoINI,LcCentroCustoFIM : Boolean;
  LcResultadoINI, LcResultadoFIM : Boolean;
Begin
  //Verificar se há parametros
  LcCentroCustoINI := ( Trim(Fm_CentroCustoInicial.DBLCB_Plano.Text)<>'' );
  LcCentroCustoFIM := ( Trim(Fm_CentroCustoFinal.DBLCB_Plano.Text)<>'' );

  LcResultadoINI := ( Trim(Fm_CentroResultadoInicial.DBLCB_Plano.Text)<> '' );
  LcResultadoFIM := ( Trim(Fm_CentroResultadoFinal.DBLCB_Plano.Text)<>'' );


  with Qr_Contas do
  Begin
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT  '+
                 'PLC_CODIGO,  '+
                 'PLC_CODPLANO,  '+
                 'PLC_DESCRICAO,  '+
                 'PLC_NATUREZA,  '+
                 'PLC_TIPO,  '+
                 'PLC_CODMHA,  '+
                 'PLC_NIVEL  '+
                 'FROM  tb_planocontas '+
                 'WHERE (PLC_TIPO = ''C'') ';

    if Rg_Tipo.ItemIndex = 0 then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PLC_NIVEL = ''S'') ';

    if LcCentroCustoINI then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PLC_CODPLANO >=:C_PLANOINI) ';

    if LcCentroCustoFIM then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PLC_CODPLANO <=:C_PLANOFIM) ';

    if ( Tipo = 'R')  and ( (not LcCentroCustoINI) and (not LcCentroCustoFIM)) then
    Begin
      Lc_SqlTxt := Lc_SqlTxt + ' UNION SELECT '+
                               ' PLC_CODIGO,  '+
                               ' PLC_CODPLANO,  '+
                               ' PLC_DESCRICAO,  '+
                               ' PLC_NATUREZA,  '+
                               ' PLC_TIPO,  '+
                               ' PLC_CODMHA,  '+
                               ' PLC_NIVEL  '+
                               'FROM  tb_planocontas '+
                               'WHERE (PLC_TIPO = ''R'') ';

      if Rg_Tipo.ItemIndex = 0 then
        Lc_SqlTxt := Lc_SqlTxt + ' AND (PLC_NIVEL = ''S'') ';

      if LcResultadoINI OR LcResultadoFIM then
      Begin
        if LcResultadoINI then
          Lc_SqlTxt := Lc_SqlTxt + ' AND (PLC_CODPLANO >=:R_PLANOINI) ';

        if LcResultadoFIM then
          Lc_SqlTxt := Lc_SqlTxt + ' AND (PLC_CODPLANO <=:R_PLANOFIM) ';

      End;
    End;
    Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY 2 ';
    SQL.Add(Lc_SqlTxt );
    //Passagem de Parametros
    if Trim(Fm_CentroCustoInicial.DBLCB_Plano.Text)<>'' then
      ParamByName('C_PLANOINI').AsString := getCodigoPLano(Fm_CentroCustoInicial.DBLCB_Plano.Text);

    if Trim(Fm_CentroCustoFinal.DBLCB_Plano.Text)<>'' then
      ParamByName('C_PLANOFIM').AsString := getCodigoPLano(Fm_CentroCustoFinal.DBLCB_Plano.Text);

    if ( Tipo = 'R')  and ( (not LcCentroCustoINI) and (not LcCentroCustoFIM)) then
    Begin
      if LcResultadoINI OR LcResultadoFIM then
      Begin
        //Passagem de Parametros
        if LcResultadoINI then
          ParamByName('R_PLANOINI').AsString := getCodigoPLano(Fm_CentroResultadoInicial.DBLCB_Plano.Text);

        if LcResultadoFIM then
          ParamByName('R_PLANOFIM').AsString := getCodigoPLano(Fm_CentroResultadoFinal.DBLCB_Plano.Text);
      End;
    End;
    Active := True;
  end;
end;


procedure TFr_Imp_CtasGerenciais.Pc_CtaGerencialExcel(Pc_Operacao, Pc_Caminho: String);
begin
  if Pc_Operacao = 'I' then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Esta opção permite apenas a exportação.'+EOLN,
                   ['OK'], [bEscape], mpErro);

  End
  else
  Begin
    if SaveDialogo.Execute then
    Begin
      Pc_PreencheMatriz;
      Pc_TotalizaMatriz;
      Pc_ExportaContas;
    end;
  End;
end;

procedure TFr_Imp_CtasGerenciais.Pc_CtaGerencialPrevisto(Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Form : TRl_CtasGerenciaisPrevisto;
  Lc_Grid :TStringGrid;
  Lc_Linha : Integer;
  Lc_Qry_Det : TSTQuery;
  Lc_Vl_Conta : REAL;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Grid  := TStringGrid.Create( Self );
    Lc_Qry_Det := LcBase.GeraQuery;
    with Lc_Qry_Det do
    Begin
      SQL.Add('SELECT '+
              'EMP_FANTASIA, '+
              'FIN_NUMERO, '+
              'FIN_VL_PARCELA, '+
              'FIN_VL_PAGO '+
              'FROM TB_FINANCEIRO Tb_financeiro '+
              '  INNER JOIN TB_EMPRESA Tb_empresa '+
              '  ON  (Tb_empresa.EMP_CODIGO = Tb_financeiro.FIN_CODEMP) '+
              '  INNER JOIN tb_planocontas '+
              '  ON (tb_planocontas.plc_codigo = Tb_financeiro.fin_plc_debito) '+
              'WHERE (FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM) '+
              '  AND (PLC_CODPLANO =:PLANO) ');
    end;

    Lc_Grid.Visible := False;
    Lc_Grid.Parent := self;
    Lc_Grid.FixedCols := 0;
    Lc_Grid.FixedRows := 0;
    Lc_Grid.ColCount := 5;
    Pc_Buscar('C');
    with Qr_Contas do
    Begin
      First;
      Lc_Linha := 0;
      while not eof do
      Begin
        inc(Lc_Linha);
        Lc_Grid.RowCount := Lc_Linha;
        Lc_Vl_Conta := Fc_ValorContaPrevista(Qr_Contas.FieldByName('PLC_CODPLANO').AsString,
                                             E_Data_Ini.Date,
                                             E_Data_Fim.Date);
        Lc_Grid.Cells[0,Lc_Linha] := Qr_Contas.FieldByName('PLC_NIVEL').AsString;
        Lc_Grid.Cells[1,Lc_Linha] := Qr_Contas.FieldByName('PLC_CODPLANO').AsString;
        Lc_Grid.Cells[2,Lc_Linha] := Qr_Contas.FieldByName('PLC_DESCRICAO').AsString;
        Lc_Grid.Cells[3,Lc_Linha] := FloatToStrF(Lc_Vl_Conta,ffFixed,10,2);
        Lc_Grid.Cells[4,Lc_Linha] := Qr_Contas.FieldByName('PLC_NATUREZA').AsString;
        if (Qr_Contas.FieldByName('PLC_NIVEL').AsString = 'A') AND (Rg_Tipo.ItemIndex = 2) then
        Begin
          Lc_Qry_Det.Active := False;
          Lc_Qry_Det.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
          Lc_Qry_Det.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
          Lc_Qry_Det.ParamByName('PLANO').AsString := Qr_Contas.FieldByName('PLC_CODPLANO').AsString;
          Lc_Qry_Det.Active := True;
          Lc_Qry_Det.FetchAll;
          while not Lc_Qry_Det.Eof do
          Begin
            inc(Lc_Linha);
            Lc_Grid.RowCount := Lc_Linha;
            Lc_Grid.Cells[1,Lc_Linha] := '';
            Lc_Grid.Cells[2,Lc_Linha] := Lc_Qry_Det.Fieldbyname('FIN_NUMERO').AsString + ' | ' + Lc_Qry_Det.Fieldbyname('EMP_FANTASIA').AsString;
            Lc_Grid.Cells[3,Lc_Linha] := FloatToStrF(Lc_Qry_Det.Fieldbyname('FIN_VL_PARCELA').AsCurrency,ffNumber,10,2);
            Lc_Qry_Det.Next;
          end;
        end;
        next;
      end;
    end;
    if Pc_Operacao = 'I' then
    Begin
      Try
        Lc_Form := TRl_CtasGerenciaisPrevisto.Create( nil );
        Lc_Form.Lc_Grade := Lc_Grid;
        if Fc_Aq_Geral('L','IMPRESSAO','IMP_P_VISUALIZA','S') = 'S' then
          Lc_Form.Qrpt.Preview
        else
          Lc_Form.Qrpt.Print;
      Finally
        Lc_Form.Close;
        FreeAndNil(Lc_Form);
      End;
    End
    else
    Begin
      IF (Fr_Principal.SaveDialogo.Execute) then
      Begin
        if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
        Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
        Pc_Caminho := Fr_Principal.SaveDialogo.FileName;
        Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
        Fr_Excel.Pc_StringGridToExcel(Lc_Grid,Pc_Caminho)
      End;
    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry_Det);
    FreeAndNil(Lc_Grid);
    FreeAndNil(LcBase);
  end;
end;


procedure TFr_Imp_CtasGerenciais.Pc_CtaGerencialRealizado(Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Form : TRl_CtasGerenciaisRealizado;
  Lc_Grid :TStringGrid;
  Lc_Linha : Integer;
  Lc_Qry_Det : TSTQuery;
  Lc_Vl_Credito,Lc_Vl_Debito : REAL;
  excel: variant;
  lin,col : integer;
  Lc_Aux : String;
  Lc_Fechamento : TControllerFechaFinanceiro;
  Lc_SaldoAnterior : Real;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry_Det := LcBase.GeraQuery;
    Pc_DefineDataAnteriror;
    Lc_Grid  :=TStringGrid.Create(Self);
    Lc_Fechamento := TControllerFechaFinanceiro.Create(nil);
    with Qr_Contas,Lc_Grid do
    Begin
      Visible := False;
      Parent := Self;
      ColCount := 10;
      FixedCols := 0;
      FixedRows := 0;
      Pc_Buscar('R');
      First;
      Lc_Linha := 0;
      while not eof do
      Begin
        inc(Lc_Linha);
        RowCount := Lc_Linha;
        if (FieldByName('PLC_TIPO').AsString = 'R') then
        Begin
          //Esse comando já existia antes do fechamento
          Lc_Vl_Credito := 0;
          //Cololoca o saldo anterior àscontas de resultado
          if not ChBx_MovimentoMensal.Checked then
            Lc_SaldoAnterior := 0
          else
            Lc_SaldoAnterior := Lc_Fechamento.getSaldoAnterior(FieldByName('PLC_CODIGO').AsInteger,E_Data_Ini.Date);
          Cells[8,Lc_Linha] := FloatToStrF(Lc_SaldoAnterior,ffNumber,10,2);
        End;

        //Credito
        Lc_Vl_Credito := Fc_ValorContaRealizada(FieldByName('PLC_TIPO').AsString,
                                                FieldByName('PLC_CODPLANO').AsString,
                                                'MVF_VL_CREDITO',
                                                E_Data_Ini.Date,
                                                E_Data_Fim.Date);
        //Debito
        Lc_Vl_Debito := Fc_ValorContaRealizada(FieldByName('PLC_TIPO').AsString,
                                               FieldByName('PLC_CODPLANO').AsString,
                                                'MVF_VL_DEBITO',
                                                E_Data_Ini.Date,
                                                E_Data_Fim.Date);


        Cells[0,Lc_Linha] := FieldByName('PLC_NIVEL').AsString;
        Cells[1,Lc_Linha] := FieldByName('PLC_CODPLANO').AsString;
        Cells[2,Lc_Linha] := FieldByName('PLC_DESCRICAO').AsString;
        if (Lc_Vl_Credito < 0 ) then
          Cells[3,Lc_Linha] := FloatToStrF(Lc_Vl_Credito ,ffFixed,10,2)
        else
          Cells[3,Lc_Linha] := FloatToStrF(Lc_Vl_Credito,ffFixed,10,2);
        IF (Lc_Vl_Debito < 0) then
          Cells[4,Lc_Linha] := FloatToStrF(Lc_Vl_Debito ,ffFixed,10,2)
        else
          Cells[4,Lc_Linha] := FloatToStrF(Lc_Vl_Debito,ffFixed,10,2);
        if (FieldByName('PLC_TIPO').AsString = 'R') then
        Begin
          Cells[5,Lc_Linha] := FloatToStrF(Lc_Vl_Credito -  Lc_Vl_Debito,ffFixed,10,2);
        End
        else
        Begin
          if (Lc_Vl_Credito -  Lc_Vl_Debito) < 0 then
            Cells[5,Lc_Linha] := FloatToStrF((Lc_Vl_Credito -  Lc_Vl_Debito),ffFixed,10,2)
          else
            Cells[5,Lc_Linha] := FloatToStrF(Lc_Vl_Credito -  Lc_Vl_Debito,ffFixed,10,2);
        End;
        Cells[6,Lc_Linha] := FieldByName('PLC_TIPO').AsString;
        Cells[7,Lc_Linha] := FieldByName('PLC_NATUREZA').AsString;
        if (Qr_Contas.FieldByName('PLC_NIVEL').AsString = 'A') AND (Rg_Tipo.ItemIndex = 2) then
        Begin
          Lc_Qry_Det.Active := False;
          Lc_Qry_Det.SQL.clear;
          Lc_Qry_Det.SQL.Add('SELECT '+
                              'MVF_CODCTB, '+
                              'MVF_HISTORISCO, '+
                              'MVF_VL_CREDITO, '+
                              'MVF_VL_DEBITO, '+
                              'MVF_VL_FUTURO, '+
                              'MVF_DATA '+
                              'FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro ');
          if FieldByName('PLC_TIPO').AsString = 'C' then
          Begin
            Lc_Qry_Det.SQL.Add('  INNER JOIN tb_planocontas '+
                    '  ON (tb_planocontas.plc_codigo = tb_movim_financeiro.MVF_CODPLC_D) ');
          End
          else
          Begin
            Lc_Qry_Det.SQL.Add('  INNER JOIN tb_planocontas '+
                    '  ON (tb_planocontas.plc_codigo = tb_movim_financeiro.MVF_CODPLC_C) ');
          End;
          Lc_Qry_Det.SQL.Add('WHERE (MVF_DATA BETWEEN :DATAINI AND :DATAFIM) '+
                             '  AND (PLC_CODPLANO =:PLANO) AND (MVF_CODMHA =:MVF_CODMHA)');
          Lc_Qry_Det.SQL.Add('ORDER BY MVF_DATA, MVF_HISTORISCO ASC ');

          Lc_Qry_Det.ParamByName('MVF_CODMHA').AsInteger := Gb_CodMha;
          Lc_Qry_Det.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
          Lc_Qry_Det.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
          Lc_Qry_Det.ParamByName('PLANO').AsString := FieldByName('PLC_CODPLANO').AsString;
          Lc_Qry_Det.Active := True;
          Lc_Qry_Det.FetchAll;
          while not Lc_Qry_Det.Eof do
          Begin
            inc(Lc_Linha);
            Lc_Grid.RowCount := Lc_Linha;
            Cells[1,Lc_Linha] := '';
            if (Lc_Qry_Det.Fieldbyname('MVF_CODCTB').AsInteger = 0) then
              Lc_Aux := '( C ) '
            else
              Lc_Aux := '( B ) ';

            Cells[2,Lc_Linha] := concat(Lc_Aux + Lc_Qry_Det.FieldByName('MVF_DATA').AsString, ' | ', Lc_Qry_Det.Fieldbyname('MVF_HISTORISCO').AsString);

            Lc_Vl_Credito := 0;
            Lc_Vl_Debito  := 0;

            if ( Lc_Qry_Det.Fieldbyname('MVF_VL_FUTURO').AsCurrency <>  0) then
            Begin
              if ( Lc_Qry_Det.Fieldbyname('MVF_VL_FUTURO').AsCurrency > 0 ) then
                Lc_Vl_Credito := Lc_Qry_Det.Fieldbyname('MVF_VL_FUTURO').AsCurrency;
              if ( Lc_Qry_Det.Fieldbyname('MVF_VL_FUTURO').AsCurrency < 0 ) then
                Lc_Vl_Debito := Lc_Qry_Det.Fieldbyname('MVF_VL_FUTURO').AsCurrency * -1;

            End
            else
            Begin
              Lc_Vl_Credito := Lc_Qry_Det.Fieldbyname('MVF_VL_CREDITO').AsCurrency;
              Lc_Vl_Debito  := Lc_Qry_Det.Fieldbyname('MVF_VL_DEBITO').AsCurrency;
            End;
            Cells[3,Lc_Linha] := FloatToStrF(Lc_Vl_Credito,ffFixed,10,2);
            Cells[4,Lc_Linha] := FloatToStrF(Lc_Vl_Debito,ffFixed,10,2);
            Cells[5,Lc_Linha] := FloatToStrF(Lc_Vl_Credito -  Lc_Vl_Debito,ffFixed,10,2);
            Lc_Qry_Det.Next;
          end;
        end;
        next;
      end;
    end;
    FreeAndNil(Lc_Fechamento);
    if Pc_Operacao = 'I' then
    Begin
      Try
        Lc_Form := TRl_CtasGerenciaisRealizado.Create(nil);
        Lc_Form.Lc_Grade := Lc_Grid;
        if Fc_Aq_Geral('L','IMPRESSAO','IMP_P_VISUALIZA','S') = 'S' then
          Lc_Form.Qrpt.Preview
        else
          Lc_Form.Qrpt.Print;
      Finally
        Lc_Form.close;
        FreeAndNil(Lc_Form);
      End;

    End
    else
    Begin
      IF (Fr_Principal.SaveDialogo.Execute) then
      Begin
        if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
        Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
        Pc_Caminho := Fr_Principal.SaveDialogo.FileName;
        Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
        Fr_Excel.Pc_StringGridToExcel(Lc_Grid,Pc_Caminho)
      End;
    End;
  finally
    FreeAndNil(Lc_Grid);
    Lcbase.FinalizaQuery(Lc_Qry_Det);
    FreeAndNil(Lcbase);
  end;
end;


procedure TFr_Imp_CtasGerenciais.Pc_DefineDataAnteriror;
Var
  Lc_Mes : String;
  Lc_Ano : String;
  Lc_Dia : String;
begin
  //01/01/2016
  Lc_Mes := Copy( DateToStr(E_Data_Ini.Date),4,2);
  Lc_Ano := Copy( DateToStr(E_Data_Ini.Date),7,4);
  if Lc_Mes = '01' then
  Begin
    Lc_Mes := '12';
    Lc_Ano := IntToStr( StrToInt( Lc_Ano ) - 1 );
  End
  else
  Begin
    Lc_Mes := StrZero( StrToInt( Lc_Mes ) - 1,2,0 );
  End;
  Lc_Dia := '01';
  DataInicialAnterior := StrToDate(lc_Dia + '/' + Lc_Mes + '/' + Lc_ano);
  Lc_Dia := StrZero( UltDiaDoMes(DataInicialAnterior) , 2,0);
  DataFinalAnterior   := StrToDate(Lc_Dia + '/' + Lc_Mes + '/' + Lc_ano);

end;

procedure TFr_Imp_CtasGerenciais.SB_ImprimirClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Pc_LimpaQrPreviweMemoria;
    case CB_Tipo.ItemIndex of
      0:Pc_CtaGerencialPrevisto('I','');
      1:Pc_CtaGerencialRealizado('I','');
      2:Pc_CtaGerencialExcel('I','');
      end;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;

procedure TFr_Imp_CtasGerenciais.SB_VoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Imp_CtasGerenciais.Sb_ExportarClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Pc_LimpaQrPreviweMemoria;
    case CB_Tipo.ItemIndex of
      0:Pc_CtaGerencialPrevisto('E','');
      1:Pc_CtaGerencialRealizado('E','');
      2:Pc_CtaGerencialExcel('E','');
      end;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;

procedure TFr_Imp_CtasGerenciais.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Imp_CtasGerenciais.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Fm_LME.Listar('EMP_NOME');
  Fm_LME.HabilitarMultiEmpresa;
  E_Data_Ini.DateTime:= Now-31;
  E_Data_Fim.DateTime:= Now;
  Pc_PermissaoBotao('Gerencial');
  Pc_AtivaTabelas;
end;

procedure TFr_Imp_CtasGerenciais.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if shift = [] then
   begin
      case Key of
         VK_F2: if Sb_Exportar.Enabled then Sb_ExportarClick(Sender);
         VK_F3: if SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
         VK_Escape: if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
      end;
   end;
end;

procedure TFr_Imp_CtasGerenciais.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Imprimir     := True;
    It_Exportar     := True;
    end
  else
    begin
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    if not It_Visualizar then exit;
    It_Imprimir      := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    It_Exportar      := Fc_HabilitaPermissao(Pc_Menu,'EXPORTAR','S');
    end;
   SB_Imprimir.Enabled:= It_Imprimir;
   Sb_Exportar.Enabled:= It_Exportar;
end;

procedure TFr_Imp_CtasGerenciais.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    Sb_Exportar.Glyph := (Fc_CarregaImagemBotao('EXPORTAR'));
    SB_Imprimir.Glyph := (Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
    END;
end;
procedure TFr_Imp_CtasGerenciais.CB_TipoChange(Sender: TObject);
begin
  if CB_Tipo.ItemIndex = 1 then
  Begin
    ChBx_MovimentoMensal.Enabled := True;
    ChBx_MovimentoMensal.Checked := False;
  End
  else
  Begin
    ChBx_MovimentoMensal.Checked := False;
    ChBx_MovimentoMensal.Enabled := False;
  End;
end;

procedure TFr_Imp_CtasGerenciais.GeraExcel(Grid:TStringGrid);
var excel: variant;
    lin,col : integer;
begin
  excel := CreateOleObject('Excel.Application');
  excel.Workbooks.add(1);
  excel.Cells.Select;
//  excel.Selection.NumberFormat := '@';

  for lin := 1 to Grid.RowCount  do
    for col := 1 to Grid.ColCount do
    begin
      if (col = 3) or (col = 4) or (col = 5) then
        excel.Columns.Columns[Col].NumberFormat := '#.##0,00'
      else
        excel.Columns.Columns[Col].NumberFormat := '@';
      excel.cells[lin,col] := Grid.cells[col,lin];
      excel.columns.AutoFit;
      excel.cells[lin,col].Select;
    end;
  excel.visible := true;
end;
function TFr_Imp_CtasGerenciais.getCodigoPLano(Codigo: String): String;
Var
  LcPos : Integer;
begin
  LcPos := Pos('-',Trim(Codigo));
  Result := TRim(Copy(Codigo,1,LcPos-1));
end;

{
var
  Lc_Excel, Lc_Sheet : Variant;
  lin,col : integer;
  Lc_Formato : String;
  Lc_Alinha : Integer;
begin
  //cria a aplicação
  Lc_Excel := CreateOleObject('Excel.Application');
  //adiciona pasta de trabalho
  Lc_Excel.WorkBooks.Add;
  //planilha recebendo variável nome
  Lc_Excel.WorkSheets[1].Name := 'Exporta';
  //Repassando variável
  Lc_Sheet := Lc_Excel.WorkSheets['Exporta'];
  //Configura as Margens
  Lc_Sheet.PageSetup.LeftMargin := Lc_Excel.InchesToPoints(0.236220472440945);
  Lc_Sheet.PageSetup.RightMargin := Lc_Excel.InchesToPoints(0.118110236220472);
  Lc_Sheet.PageSetup.TopMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.BottomMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.HeaderMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.FooterMargin := Lc_Excel.InchesToPoints(0.393700787401575);

  for lin := 1 to Grid.RowCount  do
  Begin
    for col := 1 to Grid.ColCount - 1 do
    Begin
      if (col = 3) or (col = 4) or (col = 5) then
      Begin
        Lc_Alinha := 3;
        Lc_Formato := '0,00';
      End
      else
      BEgin
        Lc_Alinha := 1;
        Lc_Formato := '@';
      End;
      Pc_PreenceCelulaExcel(fALSE,
                            Lc_Sheet,
                            lin,
                            col,
                            col,
                            100,
                            Lc_Alinha,
                            Lc_Formato,
                            Grid.cells[col,lin]);


    end;
  End;

  Lc_excel.columns.AutoFit;
 //Abre o excel
  Lc_Excel.Visible := true;

end;
  }
end.

