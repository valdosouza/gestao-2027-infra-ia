unit UN_Imp_CtasGerenciais;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, DBClient, OleServer, StdCtrls, Grids, DBGrids, Buttons, Gauges, STQuery, DBCtrls, Mask, ExtCtrls, Excel2000, ComCtrls, ExcelXP, Un_Fm_CentroCusto, Un_Fm_CentroResultado, ComObj, Un_Fm_ListaMultiEmpresa, base_frame_list;

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

    procedure SB_ImprimirClick(Sender: TObject);
    procedure SB_VoltarClick(Sender: TObject);
    procedure Sb_ExportarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CB_TipoChange(Sender: TObject);

  private
    { Private declarations }
      DataInicialAnterior : TDate;
      DataFinalAnterior : TDate;
      function getCodigoPLano(Codigo:String):String;
  public
    { Public declarations }
  It_Matriz : Array of Array of string;
  It_Reg_Matriz : Integer;
  It_Visualizar :Boolean;
  It_Imprimir :Boolean;
  It_Exportar :Boolean;
  procedure Pc_DefineDataAnteriror;
  procedure PC_MontaMatriz;
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

procedure TFr_Imp_CtasGerenciais.PC_MontaMatriz;
Var
  Lc_SqlTxt : String;
  Lc_Data, Lc_Plano : Boolean;
Begin
  It_Reg_Matriz := 0;
  Qr_plano.Active := False;
  Qr_plano.SQL.Clear;

  Lc_SqlTxt := 'SELECT * '+
               'FROM TB_PLANOCONTAS '+
               'WHERE PLC_CODIGO IS NOT NULL ';

  if ( Fm_CentroCustoInicial.DBLCB_Plano.Text = '  /  /    ') or (Fm_CentroCustoFinal.DBLCB_Plano.Text = '  /  /    ') then Lc_Plano := False else Lc_Plano := True;

  if Lc_Plano then Lc_Sqltxt := Lc_Sqltxt +'AND (PLC_CODPLANO LIKE :PLANOINI) ';
  if Lc_Plano then Lc_Sqltxt := Lc_Sqltxt +'AND (PLC_CODPLANO LIKE :PLANOFIM) ';

  Qr_plano.SQL.Add(Lc_SqlTxt+ 'ORDER BY PLC_CODPLANO ');

  if Lc_Plano then Qr_plano.ParamByName('PLANOINI').AsString := Fm_CentroCustoInicial.DBLCB_Plano.Text + '%';
  if Lc_Plano then Qr_plano.ParamByName('PLANOFIM').AsString := '%' + Fm_CentroCustoFinal.DBLCB_Plano.Text;

  Qr_plano.Active := True;
  Qr_plano.FetchAll;
  It_Reg_Matriz := Qr_plano.RecordCount;

  Qr_Acao.Active := False;
  Qr_Acao.Transaction := DM.IB_Transacao;
  Qr_Acao.SQL.Clear;

  Lc_SqlTxt := 'SELECT CTG_DATA                              '+
               'FROM VW_CTAS_GERENCIAIS                      '+
               'WHERE CTG_DATA IS NOT NULL                   '+
               'AND (CTG_DATA BETWEEN :DATAINI AND :DATAFIM) ';

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('DATAINI').AsDate := E_Data_Ini.DatE;
  Qr_Acao.ParamByName('DATAFIM').AsDate :=  E_Data_Fim.Date;

  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  It_Reg_Matriz := It_Reg_Matriz + Qr_Acao.RecordCount;
  SetLength(It_Matriz,8,It_Reg_Matriz);
end;

procedure TFr_Imp_CtasGerenciais.PC_PreencheMatriz;
Var
  Lc_SqlTxt : String;
  Lc_Data, Lc_Plano : Boolean;
  Lc_I : Integer;
Begin
  Gg_Progresso.MinValue := 0;
  Gg_Progresso.MaxValue := It_Reg_Matriz - 1;
  Lb_Processo.Caption := 'Preenchendo a Tabela';

  Qr_Movimento.Active := False;
  Qr_Movimento.SQL.Clear;

  Lc_SqlTxt := 'SELECT CTG_DATA, CTG_TIPO, CTG_CONTA, CTG_HISTORISCO, CTG_VL_CREDITO, CTG_VL_DEBITO '+
                'FROM VW_CTAS_GERENCIAIS                                                            '+
                'WHERE (CTG_DATA IS NOT NULL)                                                       '+
                ' AND (CTG_CONTA =:CTG_CONTA) AND (CTG_DATA BETWEEN :DATAINI AND :DATAFIM)          ';

  Qr_Movimento.SQL.Add(Lc_SqlTxt);
  Qr_plano.First;
  Lc_I := 0;
  while not Qr_plano.Eof do
  begin
    if Qr_plano.FieldByName('PLC_NIVEL').AsString = 'S' then
    Begin
      It_Matriz[0,Lc_I] := Qr_plano.FieldByName('PLC_CODIGO').asstring;
      It_Matriz[1,Lc_I] := Qr_plano.FieldByName('PLC_CODPLANO').asstring;
      It_Matriz[2,Lc_I] := Qr_plano.FieldByName('PLC_DESCRICAO').asstring;
      It_Matriz[4,Lc_I] := Qr_plano.FieldByName('PLC_NATUREZA').asstring;
      It_Matriz[5,Lc_I] := Qr_plano.FieldByName('PLC_TIPO').asstring;
    end
    else
    Begin
      It_Matriz[0,Lc_I] := Qr_plano.FieldByName('PLC_CODIGO').asstring;
      It_Matriz[1,Lc_I] := Qr_plano.FieldByName('PLC_CODPLANO').asstring;
      It_Matriz[2,Lc_I] := Qr_plano.FieldByName('PLC_DESCRICAO').asstring;
      It_Matriz[4,Lc_I] := Qr_plano.FieldByName('PLC_NATUREZA').asstring;
      It_Matriz[5,Lc_I] := Qr_plano.FieldByName('PLC_TIPO').asstring;
      //Preenche com os dados do Movimento
      Qr_Movimento.Active := False;
      Qr_Movimento.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      Qr_Movimento.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
      Qr_Movimento.ParamByName('CTG_CONTA').AsInteger := Qr_Plano.FieldByName('PLC_CODIGO').AsInteger;
      Qr_Movimento.Active := True;
      Qr_Movimento.FetchAll;
      Qr_Movimento.First;
      Inc(Lc_I);
      while not Qr_Movimento.Eof do
      Begin
        It_Matriz[0,Lc_I] := '';
        It_Matriz[1,Lc_I] := '';
        It_Matriz[2,Lc_I] := Qr_Movimento.FieldByName('CTG_DATA').asstring;
        It_Matriz[3,Lc_I] := Qr_Movimento.FieldByName('CTG_HISTORISCO').asstring;
        It_Matriz[4,Lc_I] := Qr_Movimento.FieldByName('CTG_TIPO').AsString;
        It_Matriz[5,Lc_I] := 'D';
        if Qr_Movimento.FieldByName('CTG_TIPO').AsString = 'C' then
        Begin
          It_Matriz[6,Lc_I] :=  FloatToStrF(ABS(Qr_Movimento.FieldByName('CTG_VL_CREDITO').AsCurrency - Qr_Movimento.FieldByName('CTG_VL_DEBITO').AsCurrency), ffFixed,10,2);
          It_Matriz[7,Lc_I] := '0,00';
        end
        else
        Begin
          It_Matriz[6,Lc_I] := '0,00';
          It_Matriz[7,Lc_I] := FloatToStrF(ABS(Qr_Movimento.FieldByName('CTG_VL_DEBITO').AsCurrency - Qr_Movimento.FieldByName('CTG_VL_CREDITO').AsCurrency), ffFixed,10,2);
        end;
        Inc(Lc_I);
        Gg_Progresso.Progress := Lc_I;
        Application.ProcessMessages;
        Qr_Movimento.Next;
      end;
      Lc_I := Lc_I - 1;
    end;
    Inc(Lc_I);
    Gg_Progresso.Progress := Lc_I;
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
  Gg_Progresso.MaxValue := It_Reg_Matriz - 1;
  Lc_Vl_Cred_Analitico := 0;
  Lc_Vl_Debi_Analitico := 0;
  Lc_Vl_Cred_Sintetico := 0;
  Lc_Vl_Debi_Sintetico := 0;
  Lb_Processo.Caption := 'Totalizando a Tabela';
  for lc_I := It_Reg_Matriz - 1  downto 0 do
  Begin
    if It_Matriz[5,Lc_I] = 'D' then
    Begin
      Lc_Vl_Cred_Analitico := Lc_Vl_Cred_Analitico + StrToFloatDef(It_Matriz[6,Lc_I],0);
      Lc_Vl_Debi_Analitico := Lc_Vl_Debi_Analitico + StrToFloatDef(It_Matriz[7,Lc_I],0);
      Lc_Vl_Cred_Sintetico := Lc_Vl_Cred_Sintetico + StrToFloatDef(It_Matriz[6,Lc_I],0);
      Lc_Vl_Debi_Sintetico := Lc_Vl_Debi_Sintetico + StrToFloatDef(It_Matriz[7,Lc_I],0);
    end
    else
    Begin
      if It_Matriz[5,Lc_I] = 'A' then
      Begin
        It_Matriz[6,Lc_I] := FloatToStrF(Lc_Vl_Cred_Analitico,ffFixed,10,2);
        It_Matriz[7,Lc_I] := FloatToStrF(Lc_Vl_Debi_Analitico,ffFixed,10,2);
        Lc_Vl_Cred_Analitico := 0;
        Lc_Vl_Debi_Analitico := 0;
      end
      else
      Begin
        It_Matriz[6,Lc_I] := FloatToStrF(Lc_Vl_Cred_Sintetico,ffFixed,10,2);
        It_Matriz[7,Lc_I] := FloatToStrF(Lc_Vl_Debi_Sintetico,ffFixed,10,2);
        Lc_Vl_Cred_Sintetico := 0;
        Lc_Vl_Debi_Sintetico := 0;
        Lc_Vl_Cred_Analitico := 0;
        Lc_Vl_Debi_Analitico := 0;
      end;
    end;
    inc(lc_J);
    Gg_Progresso.Progress := Lc_I;
    Application.ProcessMessages;
  end;
End;

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
  Gg_Progresso.MaxValue := It_Reg_Matriz - 1;
  Lb_Processo.Caption := 'Exportando para Arquivo ' + Lc_NomeArquivo;
  if FileExists(Lc_NomeArquivo)then DeleteFile(Lc_NomeArquivo);
  Lc_ID := GetUserDefaultLCID;
  Excel.Connect;
    try
      Excel.Visible[LC_ID] := False;
      Excel.Workbooks.Add(EmptyParam, LC_ID);
      for Lc_Linha := 0 to It_Reg_Matriz - 1 do
        Begin
        for Lc_Coluna := 1 to 7 do
          begin
          if (Lc_Coluna = 6) or (Lc_Coluna = 7) then
            Begin
            Lc_StrCell := Fc_PegaLetraColuna(Lc_Coluna) + IntToStr(Lc_Linha + 1);
            Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(xlContinuous, xlThin ,xlAutomatic,xlAutomatic);
            Excel.Range[Lc_StrCell,Lc_StrCell].Value2 := StrToFloatDef(It_MaTriz[Lc_Coluna,Lc_Linha],0);
            Excel.Range[Lc_StrCell,Lc_StrCell].Style := 'Comma'
            end
          else
            Begin
            Lc_StrCell := Fc_PegaLetraColuna(Lc_Coluna) + IntToStr(Lc_Linha + 1);
            Excel.Range[Lc_StrCell, Lc_StrCell].BorderAround(xlContinuous, xlThin ,xlAutomatic,xlAutomatic);
            if (Lc_Coluna = 1) OR (Lc_Coluna = 2) then
              Excel.Range[Lc_StrCell,Lc_StrCell].Value2 := '''' + It_MaTriz[Lc_Coluna,Lc_Linha]
            else
              Excel.Range[Lc_StrCell,Lc_StrCell].Value2 := It_MaTriz[Lc_Coluna,Lc_Linha]
            end;
          end;
        Gg_Progresso.Progress := Lc_Linha;
        end;
      Gg_Progresso.Progress := Lc_Linha;
      Excel.Range['A1','A1'].FormulaR1C1 := '=SUM(RC[2]:RC[' + IntToStr(7) + '])-RC[1]';
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


procedure TFr_Imp_CtasGerenciais.Pc_AtivaTabelas;
begin
  Fm_CentroCustoInicial.Pc_ListaParaUsar;
  Fm_CentroCustoFinal.Pc_ListaParaUsar;
  Fm_CentroResultadoInicial.Pc_ListaParaUsar;
  Fm_CentroResultadoFinal.Pc_ListaParaUsar;
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

  LcResultadoINI := ( Trim(Fm_CentroResultadoFinal.DBLCB_Plano.Text)<> '' );
  LcResultadoFIM := ( Trim(Fm_CentroResultadoInicial.DBLCB_Plano.Text)<>'' );


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
      PC_MontaMatriz;
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
begin
  Try
    Lc_Grid  :=TStringGrid.Create(Self);
    Lc_Grid.Visible := False;
    Lc_Grid.Parent := Self;
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
          Lc_Qry_Det := Fc_DetalhePLC_Financeiro(Qr_Contas.FieldByName('PLC_CODPLANO').AsString,
                                                 E_Data_Ini.Date,
                                                 E_Data_Fim.Date);
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
        Lc_Form := TRl_CtasGerenciaisPrevisto.Create(nil);
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
  Finally
    FreeAndNil(Lc_Grid);
  End;
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
begin
  Pc_DefineDataAnteriror;
  Lc_Grid  :=TStringGrid.Create(Self);
  Lc_Fechamento := TControllerFechaFinanceiro.Create(self);
  with Qr_Contas,Lc_Grid do
  Begin
    Visible := False;
    Parent := Self;
    ColCount := 9;
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
        Lc_Qry_Det := Fc_DetalhePLC_CaixaBanco(FieldByName('PLC_CODPLANO').AsString,
                                               FieldByName('PLC_TIPO').AsString,
                                               E_Data_Ini.Date,
                                               E_Data_Fim.Date);
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

          Cells[2,Lc_Linha] := Lc_Aux + Lc_Qry_Det.Fieldbyname('MVF_HISTORISCO').AsString;
          Lc_Vl_Credito := Lc_Qry_Det.Fieldbyname('MVF_VL_CREDITO').AsCurrency;
          Lc_Vl_Debito  := Lc_Qry_Det.Fieldbyname('MVF_VL_DEBITO').AsCurrency;
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
      TRl_CtasGerenciaisRealizado(Lc_Form).Lc_Grade := Lc_Grid;
      if Fc_Aq_Geral('L','IMPRESSAO','IMP_P_VISUALIZA','S') = 'S' then
        Lc_Form.Qrpt.Preview
      else
        Lc_Form.Qrpt.Print;
    Finally
      Lc_Form.dispoeOf
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
  FreeAndNil(Lc_Grid);
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

