unit Un_ContasCorrente;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, StdCtrls, ExtCtrls, DBCtrls, IniFiles, Mask, DB, STQuery, Grids, DBGrids, ComCtrls, QEdit_Setes, Menus, Un_Fm_FormaPagto, Un_Fm_ListaHistoricoBancario, Un_Fm_ListaContaBancaria, ControllerMovimentoFinanceiro;

type
  TFr_ContasCorrente = class(TForm)
    Pg_ContaCorrente: TPageControl;
    tbs_ContaCorrente: TTabSheet;
    tbs_Antecipar: TTabSheet;
    Panel1: TPanel;
    SB_Filtrar: TSpeedButton;
    Panel2: TPanel;
    SB_Sair_0: TSpeedButton;
    SB_Inserir: TSpeedButton;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Buscar: TSpeedButton;
    GroupBox2: TGroupBox;
    Label21: TLabel;
    Label12: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    E_HistoricoInterno: TMaskEdit;
    E_HistBancario: TMaskEdit;
    E_Valor: TEdit_Setes;
    E_Nr_Doc: TMaskEdit;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    E_Dt_Original: TDateTimePicker;
    ChBx_Dt_Orig: TCheckBox;
    CB_Ordena: TComboBox;
    ChBx_Periodo: TCheckBox;
    Panel4: TPanel;
    StrGrd_Lancamento: TStringGrid;
    Panel7: TPanel;
    Label31: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label25: TLabel;
    Lb_Vl_Sld_Ant: TLabel;
    Lb_Vl_Credito: TLabel;
    Lb_Vl_Debito: TLabel;
    Lb_Vl_Sld_Atual: TLabel;
    Label3: TLabel;
    Lb_Vl_Futuro: TLabel;
    Label6: TLabel;
    Lb_Vl_SLd_Futuro: TLabel;
    GroupBox1: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    E_VL_Tl_Credito_Atual: TLabel;
    E_VL_Tl_Debito_Atual: TLabel;
    E_VL_Tl_Saldo_Atual: TLabel;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    E_VL_Tl_Credito_Futuro: TLabel;
    E_VL_Tl_Debito_Futuro: TLabel;
    E_VL_Tl_Saldo_Futuro: TLabel;
    Ds_ContaBancaria: TDataSource;
    Ds_Cliente: TDataSource;
    Ppm_Banco: TPopupMenu;
    AplicarPlanoContas1: TMenuItem;
    Sb_Antecipar: TSpeedButton;
    pn_geral: TPanel;
    SB_Add_Tudo: TSpeedButton;
    SB_Retirar_Tudo: TSpeedButton;
    StrGrd_Antecipa: TStringGrid;
    Panel3: TPanel;
    SB_Confirmar: TSpeedButton;
    SpeedButton1: TSpeedButton;
    GroupBox4: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Lb_Vl_Rec_Sel: TLabel;
    Lb_Vl_Pag_Sel: TLabel;
    GroupBox5: TGroupBox;
    Label17: TLabel;
    E_Vl_Juros: TEdit_Setes;
    Label18: TLabel;
    Lb_VL_Liquido: TLabel;
    Adicionarantecipao1: TMenuItem;
    E_Historico: TEdit;
    Label16: TLabel;
    Fm_FormaPagto: TFm_FormaPagto;
    RGp_Conciliacao: TRadioGroup;
    ChBx_MoverData: TCheckBox;
    Fm_ListaHistoricoBancario: TFm_ListaHistoricoBancario;
    Fm_ListaContaBancaria: TFm_ListaContaBancaria;
    RG_TipoLancamento: TRadioGroup;
    E_Dt_Antecipacao: TDateTimePicker;
    Label2: TLabel;
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_FiltrarClick(Sender: TObject);
    procedure DetalheCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DetalheCaixaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_InserirClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure StrGrd_LancamentoDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StrGrd_LancamentoDblClick(Sender: TObject);
    procedure ChBx_Dt_OrigClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AplicarPlanoContas1Click(Sender: TObject);
    procedure StrGrd_AntecipaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SB_Add_TudoClick(Sender: TObject);
    procedure SB_Retirar_TudoClick(Sender: TObject);
    procedure StrGrd_AntecipaClick(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure Sb_AnteciparClick(Sender: TObject);
    procedure E_Vl_JurosChange(Sender: TObject);
    procedure E_Vl_JurosExit(Sender: TObject);
    procedure Adicionarantecipao1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    It_Inserir : Boolean;
    It_Alterar : Boolean;
    It_Excluir : Boolean;
    It_Visualizar : Boolean;
    Movimento : TControllerMovimentoFinanceiro;
  public
    { Public declarations }
    It_VL_Sld_Anterior: Currency;
    It_VL_Sld_Atual: Currency;
    It_VL_Credito, It_VL_Debito, It_VL_Futuro: Real;
    procedure Pc_SaldoAnterior;
    procedure Pc_SaldoAtual;
    procedure Pc_ValorFuturo;

    procedure Pc_AtivarTAbelas;
    procedure Pc_montaGradeLancamento;
    procedure Pc_montaGradeAntecipa;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;


    Function Fc_Buscar(Fc_Sql,Fc_Order:String):TSTQuery;
    procedure Pc_PreencheGradeLancamentos(Pc_Qry:TSTQuery);
    procedure Pc_PreencheGradeAntecipa;
    procedure Pc_BuscaHistorico;
    procedure Pc_TotalizaHistoricoSaldoAtual;
    procedure Pc_TotalizaHistoricoSaldoFuturo;
    function Fc_VerificaExistenciaRegistro():Boolean;
    function Fc_VerificaVinculo: Boolean;
    function Fc_ValidaExclusao(): Boolean;
    function Fc_ValidaConfirmaAntecipacao():Boolean;
    function Fc_VerificaMarcado():Boolean;
    procedure Pc_FormataTela;
    procedure Pc_TotalizaSelecao;
    procedure Pc_TotalizaAntecipacao;
    function fc_ValidaAntecipacao():boolean;
    procedure Pc_AlteraDataAntecipacao(Pc_Data:TDate);
    procedure Pc_AdicionarAntecipacao(Pc_Linha:Integer);
    procedure Pc_LancaValorFuturo;
    procedure Pc_AlteraDataLancamento;
    procedure Pc_LImpaAntecipacao;
  end;

var
  Fr_ContasCorrente: TFr_ContasCorrente;

implementation

uses
Un_DM, UN_Sistema, UN_MSG, UN_Principal, env, RN_PlanoContas, Un_Fc_Sored_Procedures, Un_Lanca_PlanoContas, Un_Regra_Negocio, RN_FormaPagto, RI_MovimentoFinanceiro, Un_Lanca_Banco;

{$R *.dfm}

procedure TFr_ContasCorrente.Pc_TotalizaSelecao;
Var
  Lc_I : Integer;
  Lc_Vl_Receber : Real;
  Lc_Vl_Pagar : Real;
  Lc_aux : Real;
Begin
  Lc_Vl_Receber := 0;
  Lc_Vl_Pagar := 0;
  For Lc_I := 1 to (StrGrd_Antecipa.RowCount - 1) do
    Begin
    IF StrGrd_Antecipa.Cells[13,Lc_I]= 'X' then
      Begin
      Lc_aux := StrToFloatDef(StrGrd_Antecipa.Cells[5,Lc_I],0);
      Lc_aux := Lc_aux + (StrToFloatDef(StrGrd_Antecipa.Cells[6,Lc_I],0) * -1);
      Lc_aux := Lc_aux + StrToFloatDef(StrGrd_Antecipa.Cells[7,Lc_I],0);
      if (Lc_aux > 0) then
        Lc_Vl_Receber := Lc_Vl_Receber + Lc_aux
      else
        Lc_Vl_Pagar := Lc_Vl_Pagar + Lc_aux
      end;
    end;
  Lb_Vl_Rec_Sel.Caption := FloatToStrF(Lc_Vl_Receber,ffNumber,10,2);
  Lb_Vl_Pag_Sel.Caption := FloatToStrF(Lc_Vl_Pagar * -1,ffNumber,10,2);

end;

procedure TFr_ContasCorrente.Pc_TotalizaAntecipacao;
Var
  Lc_Vl_Selecionado:Real;
  Lc_VL_juros : real;
  Lc_Vl_Liquido : Real;
Begin
  Lc_Vl_Selecionado := StrToFloatDef(Lb_Vl_Rec_Sel.Caption,0);
  Lc_VL_juros  := StrToFloatdef(E_Vl_Juros.Text,0);
  Lc_Vl_Liquido := Lc_Vl_Selecionado - Lc_VL_juros;
  Lb_VL_Liquido.Caption := FloatToStrF(Lc_Vl_Liquido,ffFixed,10,2);
  E_Dt_Antecipacao.Date := Date;
end;

function TFr_ContasCorrente.Fc_VerificaExistenciaRegistro():Boolean;
Begin
  Result := true;
  if (Trim(StrGrd_Lancamento.Cells[2,StrGrd_Lancamento.row]) = '') then
  Begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Não é há registros na lista.'+EOLN+EOLN+
                   'Verifique antes de Continuar.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := false;
    Exit;
  end;
end;

function TFr_ContasCorrente.Fc_VerificaVinculo: Boolean;
begin
  Result := True;
  if (StrToIntDef(StrGrd_Lancamento.Cells[14,StrGrd_Lancamento.row],0) > 0) then
  begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Não é possível a exclusão dos dados.'+EOLN+EOLN+
                   'Identifique a origem deste Lançamentoa e execute pela Origem Financeiro.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
  end;
end;

function TFr_ContasCorrente.Fc_ValidaExclusao(): Boolean;
Begin
  Result := True;
  if not Fc_VerificaExistenciaRegistro then
  Begin
    Result := False;
    exit
  end;

  if not Fc_VerificaVinculo then
  Begin
    Result := False;
    exit
  end;

  if (MensagemPadrao('Mensagem de Confirmação',
                   'Excluir o item '+' do Banco.'+EOLN+EOLN+
                   'Confirmar a exclusão ?',
                   ['Sim','Não'],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
  Begin
    Result := False;
    exit
  end;
end;

Function TFr_ContasCorrente.Fc_Buscar(Fc_Sql,Fc_Order:String):TSTQuery;
var
  Lc_Conta, Lc_Nr_Doc, Lc_Dt_Orig, Lc_Hist_Bancario, lc_Hist_Interno, Lc_Valor : boolean;
  Lc_Sql_Txt : String;
begin
  Result := Movimento.GeraQuery;
  with Result do
  Begin
    Lc_Sql_Txt := Fc_Sql;

    if Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text = ''  then Lc_Conta         := False  else Lc_Conta         := True;
    if E_Nr_Doc.Text = ''             then Lc_Nr_Doc        := False  else Lc_Nr_Doc        := True;
    if ChBx_Dt_Orig.Checked           then Lc_Dt_Orig       := true   else Lc_Dt_Orig       := False;
    if E_HistBancario.Text = ''       then Lc_Hist_Bancario := False  else Lc_Hist_Bancario := True;
    if E_HistoricoInterno.Text = ''   then lc_Hist_Interno  := False  else lc_Hist_Interno  := True;
    if E_Valor.Text = ''              then Lc_Valor         := False  else Lc_Valor         := True;

    if Lc_Conta then
      Lc_Sql_Txt := Lc_Sql_Txt + ' AND (MVF_CODCTB =:MVF_CODCTB) ';

    if Lc_Nr_Doc then
     Lc_Sql_Txt := Lc_Sql_Txt + ' AND (MVF_NR_DOC =:MVF_NR_DOC) ';

    if Lc_Dt_Orig then
      Lc_Sql_Txt := Lc_Sql_Txt + ' AND (MVF_DT_ORIG =:MVF_DT_ORIG) ';

    if ChBx_Periodo.Checked then
      Lc_Sql_Txt := Lc_Sql_Txt + ' AND MVF_DATA BETWEEN :DATAINI AND :DATAFIM ';

    if Lc_Hist_Bancario then
      Lc_Sql_Txt := Lc_Sql_Txt + ' AND (HTB_DESCRICAO like :HTB_DESCRICAO) ';

    if lc_Hist_Interno then
      Lc_Sql_Txt := Lc_Sql_Txt + ' AND (MVF_HISTORISCO LIKE :MVF_HISTORISCO)  ';

    if Lc_Valor then
      Lc_Sql_Txt := Lc_Sql_Txt + ' AND ( (MVF_VL_CREDITO =:MVF_VALOR) OR (MVF_VL_DEBITO =:MVF_VALOR) OR (MVF_VL_FUTURO =:MVF_VALOR) )';

    if Fm_FormaPagto.DBLCB_FormaPagto.Text <> '' then
      Lc_Sql_Txt := Lc_Sql_Txt + ' AND ( MVF_CODFPT =:FPT_CODIGO ) ';

    case RG_TipoLancamento.ItemIndex of
      0:Lc_Sql_Txt := Lc_Sql_Txt + ' AND ( MVF_CODQTC > 0 ) ';
      1:Lc_Sql_Txt := Lc_Sql_Txt + ' AND ( ( MVF_CODQTC = 0 ) or ( MVF_CODQTC is null ) ) ';
    end;

    case RGp_Conciliacao.ItemIndex of
      0:Lc_Sql_Txt := Lc_Sql_Txt + ' AND ( MVF_CONFERIDO = ''S'' ) ';
      1:Lc_Sql_Txt := Lc_Sql_Txt + ' AND ( MVF_CONFERIDO = ''N'' ) ';
    end;

    SQL.Add(Lc_Sql_Txt +Fc_Order);

    //Passagem de PAramettros
    if Lc_Conta then
      ParamByName('MVF_CODCTB').AsInteger := Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue;

    if Lc_Nr_Doc then
      ParamByName('MVF_NR_DOC').AsString := E_Nr_Doc.Text;

    if Lc_Dt_Orig then
      ParamByName('MVF_DT_ORIG').AsDate := E_Dt_Original.Date;

    if ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    end;

    If Lc_Hist_Bancario Then
      Parambyname('HTB_DESCRICAO').AsString:='%'+E_HistBancario.text+'%';

    If lc_Hist_Interno Then
      Parambyname('MVF_HISTORISCO').AsString:='%'+E_HistoricoInterno.text+'%';

    if Lc_Valor then
      ParamByName('MVF_VALOR').AsCurrency := StrToFloatDef(E_Valor.Text,0);

    ParamByName('MVF_CODMHA').AsInteger := Gb_CodMha;

    if Fm_FormaPagto.DBLCB_FormaPagto.Text <> '' then
      ParamByName('FPT_CODIGO').asInteger := Fm_FormaPagto.DBLCB_FormaPagto.KeyValue;

    Active:=TRUE;
  end;
end;

procedure TFr_ContasCorrente.Pc_PreencheGradeLancamentos(Pc_Qry:TSTQuery);
var
  sql_busca,Sqltxt:string;
  Lc_registro, Lc_I, Lc_J : Integer;
  Lc_Conta, Lc_Nr_Doc, Lc_Dt_Orig, Lc_Hist_Bancario, lc_Hist_Interno, Lc_Valor : boolean;
  R :TRect;
  State: TGridDrawState;
  Lc_Sql_Txt: String;
  Lc_Sql_Sldo_Atual:String;

Begin
  Try
    with Pc_Qry,StrGrd_Lancamento do
    Begin
      First;
      FetchAll;
      Lc_registro := 0;

      For Lc_I :=1 to RowCount -1 do
        For Lc_J :=0 to ColCount -1 do
          Cells[Lc_J,Lc_I] := '';
      RowCount := 2;

      while not Eof do
      Begin
        Lc_registro := Lc_registro + 1;
        RowCount := Lc_registro + 1;
        Cells[2,Lc_registro] := FieldByname('MVF_CODIGO').AsString;
        Cells[3,Lc_registro] := FieldByname('MVF_DATA').AsString;
        Cells[4,Lc_registro] := FieldByname('MVF_HISTORISCO').AsString;
        Cells[5,Lc_registro] := FloatToStrF(FieldByname('MVF_VL_CREDITO').AsCurrency, ffFixed, 10,2 );
        Cells[6,Lc_registro] := FloatToStrF(FieldByname('MVF_VL_DEBITO').AsCurrency, ffFixed, 10,2 );
        Cells[7,Lc_registro] := FloatToStrF(FieldByname('MVF_VL_FUTURO').AsCurrency, ffFixed, 10,2 );
        Cells[8,Lc_registro] := FieldByname('MVF_NR_DOC').AsString;
        Cells[9,Lc_registro] := FieldByname('MVF_DT_ORIG').AsString;
        Cells[10,Lc_registro] := FieldByname('PLC_CREDITO').AsString;
        Cells[11,Lc_registro] := FieldByname('PLC_DEBITO').AsString;
        Cells[12,Lc_registro] := FieldByname('HTB_DESCRICAO').AsString;
        if (FieldByname('MVF_CONFERIDO').AsString = 'S') then
          Cells[13,Lc_registro] := 'X'
        else
          Cells[13,Lc_registro] := '0';

        Cells[14,Lc_registro] := FieldByname('MVF_CODQTC').AsString;
        Cells[15,Lc_registro] := FieldByname('FPT_DESCRICAO').AsString;
        Cells[16,Lc_registro] := FieldByname('MVF_CODPLC_C').AsString;
        Cells[17,Lc_registro] := FieldByname('MVF_CODPLC_D').AsString;
        Next;
        application.ProcessMessages;
      end;
    end;
  Finally
    Movimento.FinalizaQuery(Pc_Qry);
    Screen.Cursor:=crDefault;
  End;

end;

procedure TFr_ContasCorrente.Pc_PreencheGradeAntecipa;
var
  Lc_I: Integer;

  sql_busca,Sqltxt:string;
  Lc_registro, Lc_J : Integer;
  Lc_Conta, Lc_Nr_Doc, Lc_Dt_Orig, Lc_Hist_Bancario, lc_Hist_Interno, Lc_Valor : boolean;
  R :TRect;
  State: TGridDrawState;
  Lc_Sql_Txt: String;
  Lc_Sql_Sldo_Atual:String;

Begin
  For Lc_I :=1 to StrGrd_Antecipa.RowCount -1 do
    For Lc_J :=0 to StrGrd_Antecipa.ColCount -1 do
      StrGrd_Antecipa.Cells[Lc_J,Lc_I] := '';
  StrGrd_Antecipa.RowCount := StrGrd_Lancamento.RowCount;

  For Lc_I := 1 to (StrGrd_Lancamento.RowCount - 1) do
    Begin
    StrGrd_Antecipa.Cells[2,Lc_I] := StrGrd_Lancamento.Cells[2,Lc_I];
    StrGrd_Antecipa.Cells[3,Lc_I] := StrGrd_Lancamento.Cells[3,Lc_I];
    StrGrd_Antecipa.Cells[4,Lc_I] := StrGrd_Lancamento.Cells[4,Lc_I];
    StrGrd_Antecipa.Cells[5,Lc_I] := StrGrd_Lancamento.Cells[5,Lc_I];
    StrGrd_Antecipa.Cells[6,Lc_I] := StrGrd_Lancamento.Cells[6,Lc_I];
    StrGrd_Antecipa.Cells[7,Lc_I] := StrGrd_Lancamento.Cells[7,Lc_I];
    StrGrd_Antecipa.Cells[8,Lc_I] := StrGrd_Lancamento.Cells[8,Lc_I];
    StrGrd_Antecipa.Cells[9,Lc_I] := StrGrd_Lancamento.Cells[9,Lc_I];
    StrGrd_Antecipa.Cells[10,Lc_I] := StrGrd_Lancamento.Cells[10,Lc_I];
    StrGrd_Antecipa.Cells[11,Lc_I] := StrGrd_Lancamento.Cells[13,Lc_I];
    StrGrd_Antecipa.Cells[12,Lc_I] := StrGrd_Lancamento.Cells[14,Lc_I];
    end;
  SB_Add_Tudo.Enabled := true;
  SB_Retirar_Tudo.Enabled := true;
  //Data da antecipação
  Screen.Cursor:=crDefault;
end;

procedure TFr_ContasCorrente.Pc_BuscaHistorico;
Var
  Lc_Sql_Txt : String;
  Lc_Sql_Order : String;
Begin
  Lc_Sql_Txt := 'SELECT  MVF_CODIGO, MVF_CODCTB, MVF_DATA, MVF_CODHTB,  HTB_DESCRICAO, MVF_DT_ORIG, MVF_NR_DOC, '+
                '  MVF_CODPLC_C,  MVF_CODPLC_D,  MVF_VL_CREDITO,  MVF_VL_DEBITO, '+
                '  MVF_HISTORISCO,  MVF_TIPO,  MVF_CODQTC,  MVF_CODUSU, MVF_VL_FUTURO,  MVF_CONFERIDO, FPT_DESCRICAO, '+
                '  tb_ctacredito.PLC_DESCRICAO AS PLC_CREDITO,   '+
                '  tb_ctadebito.PLC_DESCRICAO AS PLC_DEBITO '+
                'FROM TB_MOVIM_FINANCEIRO  '+
                '   INNER JOIN TB_CONTABANCARIA '+
                '   ON (CTB_CODIGO = MVF_CODCTB) '+
                '   LEFT OUTER JOIN TB_HISTBANCARIO  '+
                '   ON (HTB_CODIGO = MVF_CODHTB) '+
                '   INNER JOIN TB_FORMAPAGTO '+
                '   ON (FPT_CODIGO = MVF_CODFPT) '+
                '   LEFT OUTER JOIN TB_PLANOCONTAS tb_ctacredito '+
                '   ON (tb_ctacredito.PLC_CODIGO = tb_movim_financeiro.MVF_CODPLC_C) '+
                '   LEFT OUTER  JOIN TB_PLANOCONTAS tb_ctadebito '+
                '   ON (tb_ctadebito.PLC_CODIGO = tb_movim_financeiro.MVF_CODPLC_D) '+
                'WHERE (MVF_CODCTB > 0)AND (MVF_CODMHA=:MVF_CODMHA) ';
  //Define a Ordernação
  case CB_Ordena.ItemIndex of
    0:Lc_Sql_Order := ' ORDER BY MVF_DATA ';
    1:Lc_Sql_Order := ' ORDER BY MVF_HISTORISCO ';
    2:Lc_Sql_Order := ' ORDER BY MVF_CODIGO ';
    end;

   Pc_PreencheGradeLancamentos(Fc_Buscar(Lc_Sql_Txt,Lc_Sql_Order));
end;

procedure TFr_ContasCorrente.Pc_TotalizaHistoricoSaldoAtual;
var
  Lc_Sql_Txt: String;
  Lc_Qry : TSTQuery;
begin
  Try
  Lc_Sql_Txt := ' SELECT  sum(MVF_VL_CREDITO) CREDITO, sum(MVF_VL_DEBITO) DEBITO       '+
                ' FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro                         '+
                ' INNER JOIN TB_CONTABANCARIA tb_contabacaria                          '+
                '  ON (tb_contabacaria.CTB_CODIGO = tb_movim_financeiro.MVF_CODCTB)    '+
                '  LEFT OUTER JOIN TB_HISTBANCARIO tb_histbancario                     '+
                '  ON (tb_histbancario.HTB_CODIGO = tb_movim_financeiro.MVF_CODHTB)    '+
                ' WHERE (MVF_CODCTB > 0)AND (MVF_CODMHA=:MVF_CODMHA)                   ';
    Lc_Qry := Fc_Buscar(Lc_Sql_Txt,'');
    with Lc_Qry do
    Begin
      E_VL_Tl_Credito_Atual.Caption := FloatToStrF(fieldbyname('credito').AsCurrency,ffFixed,10,2);
      E_VL_Tl_Debito_Atual.Caption  := FloatToStrF(fieldbyname('debito').AsCurrency,ffFixed,10,2);
      E_VL_Tl_Saldo_Atual.Caption   := FloatToStrF(fieldbyname('credito').AsCurrency - fieldbyname('debito').AsCurrency,ffFixed,10,2);
    end;
  Finally
    Movimento.FinalizaQuery(Lc_Qry);
  End;
end;

procedure TFr_ContasCorrente.Pc_TotalizaHistoricoSaldoFuturo;
var
  Lc_Sql_Txt: String;
  Lc_Vl_Saldo : Real;
  Lc_Qry_CF : TSTQuery;
  Lc_Qry_DF : TSTQuery;
Begin
  Try
    //Define o Valor de credito Futuro
    Lc_Sql_Txt := ' SELECT  sum(MVF_VL_FUTURO) CREDITO '+
                  ' FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro '+
                  ' INNER JOIN TB_CONTABANCARIA tb_contabacaria '+
                  '  ON (tb_contabacaria.CTB_CODIGO = tb_movim_financeiro.MVF_CODCTB)    '+
                  '  LEFT OUTER JOIN TB_HISTBANCARIO tb_histbancario '+
                  '  ON (tb_histbancario.HTB_CODIGO = tb_movim_financeiro.MVF_CODHTB)    '+
                  ' WHERE (MVF_VL_FUTURO > 0)AND (MVF_CODMHA=:MVF_CODMHA) ';
    Lc_Qry_CF := Fc_Buscar(Lc_Sql_Txt,'');
    with Lc_Qry_CF do
    Begin
      E_VL_Tl_Credito_Futuro.Caption := FloatToStrF(Fieldbyname('CREDITO').AsCurrency,ffFixed,10,2);
      Lc_Vl_Saldo := Fieldbyname('CREDITO').AsCurrency;
    end;

    //Define o Valor de DEBITO Futuro
    Lc_Sql_Txt := ' SELECT  sum(MVF_VL_FUTURO) DEBITO '+
                  ' FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro '+
                  ' INNER JOIN TB_CONTABANCARIA tb_contabacaria '+
                  '  ON (tb_contabacaria.CTB_CODIGO = tb_movim_financeiro.MVF_CODCTB)    '+
                  '  LEFT OUTER JOIN TB_HISTBANCARIO tb_histbancario '+
                  '  ON (tb_histbancario.HTB_CODIGO = tb_movim_financeiro.MVF_CODHTB)    '+
                  ' WHERE (MVF_VL_FUTURO < 0)AND (MVF_CODMHA=:MVF_CODMHA) ';
    Lc_Qry_DF := Fc_Buscar(Lc_Sql_Txt,'');
    with Lc_Qry_DF do
    Begin
      E_VL_Tl_Debito_Futuro.Caption := FloatToStrF(Fieldbyname('DEBITO').AsCurrency,ffFixed,10,2);
      Lc_Vl_Saldo := Lc_Vl_Saldo  + Fieldbyname('DEBITO').AsCurrency;
    end;
  Finally
    E_VL_Tl_Saldo_Futuro.Caption := FloatToStrF(Lc_Vl_Saldo,ffFixed,10,2);
    movimento.FinalizaQuery(Lc_Qry_CF);
    movimento.FinalizaQuery(Lc_Qry_DF);
  End;


end;

procedure TFr_ContasCorrente.Pc_montaGradeLancamento;
Begin
  //Definir tamanho Da grade de Parcelas
  with StrGrd_Lancamento do
    Begin
    ColWidths[0]:=17;
    ColWidths[1]:=24;
    Cols[1].Add('OK');
    ColWidths[2]:=-1;
    ColWidths[3]:=80;
    ColWidths[4]:=285;
    ColWidths[5]:=76;
    ColWidths[6]:=76;
    ColWidths[7]:=76;
    ColWidths[8]:=76;
    ColWidths[9]:=76;
    ColWidths[10]:=300;
    ColWidths[11]:=300;
    ColWidths[12]:=300;
    ColWidths[13]:=-1;
    ColWidths[14]:=60;
    ColWidths[15]:=300;
    ColWidths[16]:=-1;
    ColWidths[17]:=-1;
    Cols[3].Add('Data');
    Cols[4].Add('Histórico Interno');
    Cols[5].Add('Valor Crédito');
    Cols[6].Add('Valor Débito');
    Cols[7].Add('Valor Futuro');
    Cols[8].Add('Número Doc.');
    Cols[9].Add('Data Doc.');
    Cols[10].Add('Conta Resultado');
    Cols[11].Add('Centro de Custo');
    Cols[12].Add('Histórico Bancário');
    Cols[13].Add('Conferido');
    Cols[14].Add('Quitacao');
    Cols[15].Add('Forma de Pagamento');
    end;
end;

procedure TFr_ContasCorrente.Pc_montaGradeAntecipa;
Begin
  //Definir tamanho Da grade de Parcelas
  with StrGrd_Antecipa do
  Begin
    ColWidths[0]:=17;
    ColWidths[1]:=54;
    Cols[1].Add('Selecionar');
    ColWidths[2]:=-1;
    ColWidths[3]:=80;
    ColWidths[4]:=285;
    ColWidths[5]:=76;
    ColWidths[6]:=76;
    ColWidths[7]:=76;
    ColWidths[8]:=76;
    ColWidths[9]:=76;
    ColWidths[10]:=272;
    ColWidths[11]:=-1;
    ColWidths[12]:=-1;
    ColWidths[13]:=-1;
    ColWidths[14]:=-1;
    Cols[3].Add('Data');
    Cols[4].Add('Histórico Interno');
    Cols[5].Add('Valor Crédito');
    Cols[6].Add('Valor Débito');
    Cols[7].Add('Valor Futuro');
    Cols[8].Add('Número Doc.');
    Cols[9].Add('Data Doc.');
    Cols[10].Add('Histórico Bancário');
    Cols[11].Add('Conta Débito');
    Cols[12].Add('Conta Crédito');
    Cols[13].Add('Conferido');
    Cols[14].Add('Quitacao');
  end;
end;

procedure TFr_ContasCorrente.Pc_AtivarTAbelas;
Begin
  Fm_ListaContaBancaria.Listar;
  Fm_FormaPagto.Pc_Listar(3,False,0);
end;
procedure TFr_ContasCorrente.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_ContasCorrente.FormCreate(Sender: TObject);
begin
  Movimento := TControllerMovimentoFinanceiro.create(self);
  ChBx_Periodo.Checked := True;
  E_Data_Fim.Date := Date;
  E_Data_Ini.Date := Date - 15;
  Pc_AtivarTAbelas;
  Pc_montaGradeLancamento;
  Pc_montaGradeAntecipa
end;

procedure TFr_ContasCorrente.Pc_SaldoAnterior;
var
  Lc_Qry : TSTQuery;
begin
  try
    Screen.Cursor:=crHourGlass;
    Lc_Qry := Movimento.GeraQuery;
    with Lc_Qry do
    Begin
      It_VL_Sld_Anterior := 0;
      Sql.add(concat(
               'SELECT  SUM (MVF_VL_CREDITO - MVF_VL_DEBITO) as MVF_VL_SLD_ANT ',
               'FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro ',
               'WHERE (MVF_DATA < :DATAINICIO) AND (MVF_CODCTB >0) '
      ));

      if Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text <> '' then
        Sql.add(' AND (MVF_CODCTB =:MVF_CODCTB) ');

      if Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text <> '' then
        ParamByName('MVF_CODCTB').AsInteger := Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue;
      ParamByName('DATAINICIO').AsDate := E_Data_Ini.Date;
      Active := True;
      It_VL_Sld_Anterior := fieldbyname('MVF_VL_SLD_ANT').AsCurrency;
    End;
  finally
    Movimento.FinalizaQuery(Lc_Qry);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFr_ContasCorrente.Pc_LancaValorFuturo;
Var
  Lc_Qry : TSTQuery;
  Lc_Upt : TSTQuery;
Begin
  Try
    Lc_Qry  := Movimento.GeraQuery;
    Lc_Upt := Movimento.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('Select '+
              ' mvf_codigo, '+
              ' mvf_data, '+
              ' mvf_vl_credito, '+
              ' mvf_vl_debito '+
              'from tb_movim_financeiro '+
              'where MVF_DATA > :MVF_DATA '+
              'AND ((mvf_vl_credito > 0) or (mvf_vl_debito > 0) ) '+
              'AND (mvf_vl_futuro = 0) '+
              'AND (mvf_conferido =''N'') ');
      ParamByName('MVF_dATA').AsDate := Date;
      Active := true;
    end;

    with Lc_Upt do
    Begin
      SQL.Add('UPDATE tb_movim_financeiro SET '+
              'mvf_vl_credito =0, '+
              'mvf_vl_debito =0, '+
              'mvf_vl_futuro =:mvf_vl_futuro '+
              'WHERE MVF_CODIGO =:MVF_CODIGO ');
      //Executa o Loop para a Mudança
      Lc_Qry.First;
      while not Lc_Qry.Eof do
      Begin
        Active := False;
        ParamByName('MVF_CODIGO').AsInteger := Lc_Qry.fieldByname('MVF_CODIGO').AsInteger;
        if (Lc_Qry.fieldByname('MVF_VL_CREDITO').AsCurrency > 0) then
          ParamByName('MVF_VL_FUTURO').AsCurrency := Lc_Qry.fieldByname('MVF_VL_CREDITO').AsCurrency
        else
          ParamByName('MVF_VL_FUTURO').AsCurrency := Lc_Qry.fieldByname('MVF_VL_DEBITO').AsCurrency * -1;
        ExecSQL;
        Lc_Qry.next;
      end;
    end;
  Finally
    Movimento.FinalizaQuery(Lc_Qry);
    Movimento.FinalizaQuery(Lc_Upt);
  End;

end;

procedure TFr_ContasCorrente.Pc_AlteraDataLancamento;
Var
  Lc_Qry : TSTQuery;
  Lc_Upt : TSTQuery;
Begin
  Try
    Lc_Qry  := Movimento.GeraQuery;
    Lc_Upt := Movimento.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('Select '+
              ' MVF_VL_FUTURO '+
              'from tb_movim_financeiro '+
              'where MVF_CODIGO=:MVF_CODIGO ');
      ParamByName('MVF_CODIGO').AsString := StrGrd_Lancamento.Cells[2,StrGrd_Lancamento.Row];
      Active := true;
    end;

    with Lc_Upt do
    Begin
      SQL.Add('UPDATE tb_movim_financeiro SET '+
              'mvf_vl_credito =0, '+
              'mvf_vl_debito =0, '+
              'mvf_vl_futuro =:mvf_vl_futuro '+
              'WHERE MVF_CODIGO =:MVF_CODIGO ');
      //Executa o Loop para a Mudança
      Lc_Qry.First;
      while not Lc_Qry.Eof do
      Begin
        Active := False;
        ParamByName('MVF_CODIGO').AsInteger := Lc_Qry.fieldByname('MVF_CODIGO').AsInteger;
        if (Lc_Qry.fieldByname('MVF_VL_CREDITO').AsCurrency > 0) then
          ParamByName('MVF_VL_FUTURO').AsCurrency := Lc_Qry.fieldByname('MVF_VL_CREDITO').AsCurrency
        else
          ParamByName('MVF_VL_FUTURO').AsCurrency := Lc_Qry.fieldByname('MVF_VL_DEBITO').AsCurrency * -1;
        ExecSQL;
        Lc_Qry.next;
      end;
    end;
  Finally
    Movimento.FinalizaQuery(Lc_Qry);
    Movimento.FinalizaQuery(Lc_Upt);
  End;

end;

procedure TFr_ContasCorrente.Pc_ValorFuturo;
var
  Lc_Qry : TSTQuery;
begin
  try
    Screen.Cursor:=crHourGlass;
    Lc_Qry := Movimento.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'UPDATE TB_MOVIM_FINANCEIRO ',
                'SET MVF_DATA=:MVF_DATAFUTURO ',
                'WHERE (MVF_CODCTB > 0) AND  (MVF_CODIGO IN ',
                '(SELECT  MVF_CODIGO ',
                'FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro ',
                'WHERE (MVF_CODIGO IS NOT NULL) AND (MVF_DATA < :MVF_DATA) ',
                ' AND ((MVF_VL_FUTURO > 0)OR (MVF_VL_FUTURO < 0)))) '
      ));

      if Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text <> '' then
        sql.Add(' AND (MVF_CODCTB =:MVF_CODCTB) ');

      if Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text <> '' then
        ParamByName('MVF_CODCTB').AsInteger := Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue;
      ParamByName('MVF_DATA').AsDate:=Date;
      ParamByName('MVF_DATAFUTURO').AsDate:=Date+1;
      ExecSQL;
    End;
  finally
    Movimento.FinalizaQuery(Lc_Qry);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFr_ContasCorrente.Pc_SaldoAtual;
var
  Lc_Qry : TSTQuery;
begin
  try
    Screen.Cursor:=crHourGlass;
    Lc_Qry := Movimento.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
            'SELECT  MVF_VL_CREDITO,  MVF_VL_DEBITO,  MVF_VL_FUTURO ',
            'FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro ',
            '   INNER JOIN TB_CONTABANCARIA tb_contabacaria ',
            '   ON (tb_contabacaria.CTB_CODIGO = tb_movim_financeiro.MVF_CODCTB) ' ,
            ' WHERE (MVF_CODCTB > 0)'
      ));

      if Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text <> '' then
        sql.Add(' AND (MVF_CODCTB =:MVF_CODCTB) ');
      sql.Add(' AND MVF_DATA BETWEEN :DATAINI AND :DATAFIM ');
      sql.Add(' ORDER BY MVF_DATA');

      if Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text <> '' then
        ParamByName('MVF_CODCTB').AsInteger := Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue;
      ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;

      Active := True;
      First;
      It_VL_Credito := 0;
      It_VL_Debito := 0;
      It_VL_Futuro := 0;

      while not Eof do
      Begin
        It_VL_Credito := It_VL_Credito + FieldByname('MVF_VL_CREDITO').AsCurrency;
        It_VL_Debito  := It_VL_Debito + FieldByname('MVF_VL_DEBITO').AsCurrency;
        It_VL_Futuro  := It_VL_Futuro + FieldByname('MVF_VL_FUTURO').AsCurrency;
        Next;
      end;
      It_VL_Sld_Atual := It_VL_Sld_Anterior + It_VL_Credito - It_VL_Debito;
    End;
  finally
    movimento.FinalizaQuery(Lc_Qry);
    Screen.Cursor:=crDefault;
  end;
end;





procedure TFr_ContasCorrente.SB_ExcluirClick(Sender: TObject);
begin
  if Fc_ValidaExclusao then
  Begin
    Movimento.Registro.Codigo := StrtoIntDef(StrGrd_Lancamento.Cells[2,StrGrd_Lancamento.Row],0);
    Movimento.delete;
    SB_BuscarClick(Sender);
    SB_FiltrarClick(Sender);
  end;
end;

procedure TFr_ContasCorrente.SB_FiltrarClick(Sender: TObject);
var
  SqlTxt,SqlAnt: String;
  Pconta, PDataIni, PDataFim : boolean;
begin
  if ChBx_MoverData.Checked then Pc_ValorFuturo;
  Pc_SaldoAnterior;
  Pc_SaldoAtual;
  Lb_Vl_Sld_Ant.Caption := FloatToStrf(It_VL_Sld_Anterior,ffFixed,10,2);
  Lb_Vl_Credito.Caption := FloatToStrf(It_VL_Credito,ffFixed,10,2);
  Lb_Vl_Debito.Caption := FloatToStrf(It_VL_Debito,ffFixed,10,2);
  Lb_Vl_Sld_Atual.Caption := FloatToStrf(It_VL_Sld_Atual,ffFixed,10,2);
  Lb_Vl_Futuro.Caption := FloatToStrf(It_VL_Futuro,ffFixed,10,2);
  Lb_Vl_SLd_Futuro.Caption := FloatToStrf(It_VL_Sld_Atual + It_VL_Futuro ,ffFixed,10,2);
end;

procedure TFr_ContasCorrente.DetalheCaixaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;

end;

procedure TFr_ContasCorrente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
      case Key of
      VK_F2  : if SB_Inserir.Enabled then SB_InserirClick(Sender);
      VK_F3  : if SB_Alterar.Enabled then SB_AlterarClick(Sender);
      VK_F4  : if SB_Excluir.Enabled then SB_ExcluirClick(Sender);
      VK_F6 : If SB_Filtrar.Enabled then SB_FiltrarClick(Sender);
      VK_F7 : If SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
      end;
    end;
end;

procedure TFr_ContasCorrente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_ContasCorrente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Movimento);
  Action := CaFree;
  Fr_ContasCorrente:=nil;
end;

procedure TFr_ContasCorrente.DetalheCaixaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete : IF SB_Excluir.Enabled then  SB_ExcluirClick(SENDER);
 end;

end;


procedure TFr_ContasCorrente.SB_InserirClick(Sender: TObject);
Var
  LfFormBanco : TFr_Lanca_Banco;
begin
  Try
    LfFormBanco := TFr_Lanca_Banco.Create(nil);
    LfFormBanco.Codigo           := 0;
    LfFormBanco.Quitacao         := 0;
    LfFormBanco.Caption          := '';
    LfFormBanco.Data             := Date;
    LfFormBanco.ContaCorrente    := 0;
    LfFormBanco.Operacao         := 'I';
    LfFormBanco.PlanoResultado   := 0;
    LfFormBanco.PlanoCentroCusto := 0;
    LfFormBanco.Historico        := '';
    LfFormBanco.HistoricoBanco   := 0;
    LfFormBanco.ValorCredito     := 0;
    LfFormBanco.ValorDebito      := 0;
    LfFormBanco.FormaPagto       := 0;
    LfFormBanco.Mensagem         := True;
    LfFormBanco.LiberaCampo      := True;
    LfFormBanco.AutoFill;
    LfFormBanco.ShowModal;

  Finally
    FreeAndNil(LfFormBanco);
    SB_BuscarClick(Sender);
  End;
end;

procedure TFr_ContasCorrente.SB_AlterarClick(Sender: TObject);
Var
  LfFormBanco : TFr_Lanca_Banco;
begin
  if Fc_VerificaExistenciaRegistro then
  Begin
    Try
      LfFormBanco := TFr_Lanca_Banco.Create(nil);
      LfFormBanco.Codigo           := StrToIntDef(StrGrd_Lancamento.Cells[2,StrGrd_Lancamento.Row],0);
      LfFormBanco.Quitacao         := 0;
      LfFormBanco.Caption          := '';
      LfFormBanco.Data             := Date;
      LfFormBanco.ContaCorrente    := 0;
      LfFormBanco.Operacao         := 'E';
      LfFormBanco.PlanoResultado   := 0;
      LfFormBanco.PlanoCentroCusto := 0;
      LfFormBanco.Historico        := '';
      LfFormBanco.HistoricoBanco   := 0;
      LfFormBanco.ValorCredito     := 0;
      LfFormBanco.ValorDebito      := 0;
      LfFormBanco.FormaPagto       := 0;
      LfFormBanco.Mensagem         := True;
      LfFormBanco.LiberaCampo      := True;
      LfFormBanco.AutoFill;
      LfFormBanco.ShowModal;
    Finally
      FreeAndNil(LfFormBanco);
      SB_BuscarClick(Sender);
    End;
  end;
end;


procedure TFr_ContasCorrente.SB_BuscarClick(Sender: TObject);
begin
  Try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Pc_BuscaHistorico;
    Pc_TotalizaHistoricoSaldoAtual;
    Pc_TotalizaHistoricoSaldoFuturo;
  Finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := true;
  end;
end;

procedure TFr_ContasCorrente.StrGrd_LancamentoDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
  Lc_Conferido: string;
  Lc_ConfCanvas: TCanvas;
  Lc_bmp : TBitmap;
  R: TRect;
const
  L_PAD = 5;  // Amount between right side of image and start of text
  T_PAD = 5;   // Amount between top of cell and top of text
begin
  with StrGrd_Lancamento do
  Begin
    if (ACol = 1)and(ARow>0) Then
    begin
      if (Cells[3,ARow] <> '') then
      Begin
        try
          Lc_bmp:=TBitmap.Create;
          Lc_Conferido := (Sender as TStringGrid).Cells[13, ARow];
          if (Lc_Conferido = 'X') then
            Fr_Principal.ImageGeral.GetBitmap(0,Lc_bmp)
          else
            Fr_Principal.ImageGeral.GetBitmap(1,Lc_bmp);
          Canvas.StretchDraw(CellRect(1,ARow),Lc_Bmp);
        finally
          FreeAndNil(Lc_Bmp);
        end;
      end;
    end
    else
    Begin
      If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
      Begin
        // Pega o texto da célula
        Texto := Cells[acol, ARow];

        //{ Calcura largura e altura (em pontos) do texto
        LarguraTexto := Canvas.TextWidth(Texto);
        AlturaTexto := Canvas.TextHeight(Texto);

        // Calcula a posição horizontal do início do texto
        if (Acol > 2) then
        Begin
          { Calcula a posição horizontal do início do texto }
          if  (ACol = 4)or (ACol = 8)or (ACol = 9)or (ACol = 10) or (ACol = 11) or (ACol = 12) or (ACol = 15)   then { esquerda }
            X := Rect.Left + 2
          else if  (ACol = 3) or (ACol = 14) then { Centro }
            X := Rect.Left + (Rect.Right - Rect.Left) div 2 -
              LarguraTexto div 2
          else { Direita }
            X := Rect.Right - LarguraTexto - 2;
        end;
        // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
        Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
        Canvas.TextRect(Rect, X, Y, Texto);
      end;
    end;
  end;
end;

procedure TFr_ContasCorrente.StrGrd_LancamentoDblClick(Sender: TObject);
begin
  try
    if StrGrd_Lancamento.Cells[13,StrGrd_Lancamento.Row] = '0' then
      StrGrd_Lancamento.Cells[13,StrGrd_Lancamento.Row] :=  'X'
    else
      StrGrd_Lancamento.Cells[13,StrGrd_Lancamento.Row] := '0';

    Movimento.Registro.Codigo := StrtoIntDef(StrGrd_Lancamento.Cells[2,StrGrd_Lancamento.Row],0);
    if (StrGrd_Lancamento.Cells[13,StrGrd_Lancamento.Row] =  'X') then
      Movimento.Registro.Conferido := 'S'
    else
      Movimento.Registro.Conferido := 'N';
    Movimento.UpdateConferido;
  finally
    StrGrd_Lancamento.Repaint;
  end;
end;

procedure TFr_ContasCorrente.ChBx_Dt_OrigClick(Sender: TObject);
begin
  E_Dt_Original.Date := Date;
  E_Dt_Original.Enabled := ChBx_Dt_Orig.Checked;
end;

procedure TFr_ContasCorrente.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_ContasCorrente.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Inserir := True;
    It_Alterar := True;
    It_Excluir := True;
    It_Visualizar := True;
    end
  else
    begin
    It_Inserir    := Fc_HabilitaPermissao(Pc_Menu,'INSERIR','S');
    It_Alterar    := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
    It_Excluir    := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    end;

  SB_Inserir.Enabled:=It_Inserir;  
  SB_Alterar.Enabled := It_Alterar;
  SB_Excluir.Enabled := It_Excluir;    
end;

procedure TFr_ContasCorrente.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Inserir.Glyph.Assign(Fc_CarregaImagemBotao('INSERIR'));
    SB_Alterar.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    SB_Excluir.Glyph.Assign(Fc_CarregaImagemBotao('EXCLUIR'));
    SB_Buscar.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_ContasCorrente.Pc_FormataTela;
Var
  Lc_X : Integer;
Begin
  Pc_ImagemBotao;
  For Lc_X:=1 to Pg_ContaCorrente.PageCount do Pg_ContaCorrente.Pages[Lc_X-1].TabVisible:=False;
  Pg_ContaCorrente.ActivePage := tbs_ContaCorrente;
end;

procedure TFr_ContasCorrente.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_PermissaoBotao('Lançamentos');
  Pc_LancaValorFuturo;
end;

procedure TFr_ContasCorrente.AplicarPlanoContas1Click(Sender: TObject);
begin
  if Trim(StrGrd_Lancamento.Cells[2,StrGrd_Lancamento.Row]) = '' then
    Begin
    MensagemPadrao(' Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   ' Não há registro selecionado.' + EOLN +
                   ' Verifique antes de continuar.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Exit;
  end;
  Pc_AplicarPlanoContasMovimentoFinanceiro(
      StrToIntDef(StrGrd_Lancamento.Cells[17,StrGrd_Lancamento.Row],0),
      StrToIntDef(StrGrd_Lancamento.Cells[16,StrGrd_Lancamento.Row],0),
      StrToIntDef(StrGrd_Lancamento.Cells[2,StrGrd_Lancamento.Row],0),'');
end;

procedure TFr_ContasCorrente.StrGrd_AntecipaDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  with StrGrd_Antecipa do
    Begin
    if (ACol = 1)and(ARow>0) Then
      begin
      if (Cells[3,ARow] <> '') then
        Begin
        if (Cells[13,ARow] = 'X') then
          DrawFrameControl(Canvas.Handle, Rect,DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED) // Desenha o CheckBox desmarcado
        else
          DrawFrameControl(Canvas.Handle, Rect,   DFC_BUTTON, DFCS_BUTTONCHECK); // Desenha o CheckBox marcado
        end;
      end
    else
      Begin
      If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
        Begin
        if (Cells[13,ARow] = '') then
          Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clCream;
          end
        else
          Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clMoneyGreen;
          end;
        Canvas.FillRect(Rect); // redesenha a celula
        Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.
        // Pega o texto da célula
        Texto := Cells[acol, ARow];

        //{ Calcura largura e altura (em pontos) do texto
        LarguraTexto := Canvas.TextWidth(Texto);
        AlturaTexto := Canvas.TextHeight(Texto);

        // Calcula a posição horizontal do início do texto
        if (Acol > 2) then
          Begin
          { Calcula a posição horizontal do início do texto }
          if  (ACol = 4)or (ACol = 10)or (ACol = 12)or (ACol = 13) then { esquerda }
            X := Rect.Left + 2
          else if  (ACol = 3) or (ACol = 11) or (ACol = 9) then { Centro }
            X := Rect.Left + (Rect.Right - Rect.Left) div 2 -
              LarguraTexto div 2
          else { Direita }
            X := Rect.Right - LarguraTexto - 2;
          end;
        // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
        Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
        Canvas.TextRect(Rect, X, Y, Texto);
        end;
      end;
    end;
end;

procedure TFr_ContasCorrente.SB_Add_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For LC_I := 1 to StrGrd_Antecipa.RowCount -1 do
    Begin
    StrGrd_Antecipa.Cells[13,Lc_I] := 'X';
    end;
  StrGrd_Antecipa.Repaint;
  Pc_TotalizaSelecao;
  Pc_TotalizaAntecipacao;
end;

procedure TFr_ContasCorrente.SB_Retirar_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For LC_I := 1 to StrGrd_Antecipa.RowCount -1 do
    Begin
    StrGrd_Antecipa.Cells[13,Lc_I] := '';
    end;
  StrGrd_Antecipa.Repaint;
  Pc_TotalizaSelecao;
  Pc_TotalizaAntecipacao;
end;

procedure TFr_ContasCorrente.StrGrd_AntecipaClick(Sender: TObject);
begin
  IF StrGrd_Antecipa.Cells[13,StrGrd_Antecipa.Row]= 'X' then
    StrGrd_Antecipa.Cells[13,StrGrd_Antecipa.Row] := ''
  else
    StrGrd_Antecipa.Cells[13,StrGrd_Antecipa.Row] := 'X';
  StrGrd_Antecipa.Repaint;
  Pc_TotalizaSelecao;
  Pc_TotalizaAntecipacao;  
end;

function TFr_ContasCorrente.Fc_VerificaMarcado():Boolean;
Var
  Lc_I : Integer;
Begin
  Result := False;
  For Lc_I := 1 to StrGrd_Antecipa.RowCount - 1 do
    Begin
    if StrGrd_Antecipa.Cells[13,Lc_I] = 'X' then
      Begin
      Result := true;
      break;
      end;
    end;
  if not Result then
    Begin
    MensagemPadrao('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Nenhum registro foi selecionado.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    end;



end;

function TFr_ContasCorrente.Fc_ValidaConfirmaAntecipacao():Boolean;
Begin
  Result := true;
  if not Fc_VerificaMarcado then
  Begin
    Result := False;
    exit;
  end;

  if StrToFloatDef(Lb_VL_Liquido.Caption,0) = 0 then
  Begin
    MensagemPadrao('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'O Valor Liquido não pode ser Zero.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

  if (Trim(Fm_ListaHistoricoBancario.DBLCB_Historico.Text) = '') then
  Begin
    MensagemPadrao('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'O campo histórico deve ser preenchido.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;
end;

procedure TFr_ContasCorrente.Pc_AlteraDataAntecipacao(Pc_Data:TDate);
Var
  Lc_I : Integer;
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry  := Movimento.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('UPDATE TB_MOVIM_FINANCEIRO SET '+
              ' MVF_DATA=:MVF_DATA, '+
              ' MVF_HISTORISCO=:MVF_HISTORISCO, '+
              ' MVF_VL_CREDITO=:MVF_VL_CREDITO, '+
              ' MVF_VL_DEBITO =:MVF_VL_DEBITO, '+
              ' MVF_VL_FUTURO=:MVF_VL_FUTURO, '+
              ' MVF_CODHTB=:MVF_CODHTB, '+
              ' MVF_CONFERIDO=:MVF_CONFERIDO '+
              'WHERE MVF_CODIGO=:MVF_CODIGO');
      For Lc_I := 1 to (StrGrd_Antecipa.RowCount - 1) do
      Begin
        IF StrGrd_Antecipa.Cells[13,Lc_I]= 'X' then
        Begin
          Active := False;
          ParamByName('MVF_DATA').AsDate := Pc_Data;
          ParamByName('MVF_CODHTB').AsInteger := Fm_ListaHistoricoBancario.DBLCB_Historico.KeyValue;
          ParamByName('MVF_HISTORISCO').AsString := Copy(E_Historico.text + ' - ' + StrGrd_Antecipa.Cells[4,Lc_I],1,100);
          ParamByName('MVF_CODIGO').AsInteger := StrToIntDef(StrGrd_Antecipa.Cells[2,Lc_I],0);
          ParamByName('MVF_CONFERIDO').AsString := 'S';
          ParamByName('MVF_VL_FUTURO').AsCurrency := 0;
          if (StrToFloatDef(StrGrd_Antecipa.Cells[7,Lc_I],0) <> 0) then
          Begin
            if (StrToFloatDef(StrGrd_Antecipa.Cells[7,Lc_I],0) < 0) then
            Begin
              ParamByName('MVF_VL_DEBITO').AsCurrency := StrToFloatDef(StrGrd_Antecipa.Cells[7,Lc_I],0) * -1;
              ParamByName('MVF_VL_CREDITO').AsCurrency := 0;
            end
            else
            Begin
              ParamByName('MVF_VL_DEBITO').AsCurrency := 0;
              ParamByName('MVF_VL_CREDITO').AsCurrency := StrToFloatDef(StrGrd_Antecipa.Cells[7,Lc_I],0);
            end;
          end
          else
          Begin
            ParamByName('MVF_VL_CREDITO').AsCurrency := StrToFloatDef(StrGrd_Antecipa.Cells[5,Lc_I],0);
            ParamByName('MVF_VL_DEBITO').AsCurrency := StrToFloatDef(StrGrd_Antecipa.Cells[6,Lc_I],0);
          end;
          ExecSQL;
        end;
      end;
    end;
  Finally
    Movimento.FinalizaQuery(Lc_Qry);
  End;
end;

procedure TFr_ContasCorrente.Pc_LImpaAntecipacao;
Begin
  Pc_LimpaStringGrid(StrGrd_Antecipa);
  E_Vl_Juros.Text := '0,00';
  Fm_ListaHistoricoBancario.DBLCB_Historico.KeyValue := Null;
  E_Dt_Antecipacao.Date := Date;
  E_Historico.Clear;
End;


procedure TFr_ContasCorrente.SB_ConfirmarClick(Sender: TObject);
Var
  Lc_Confirma : Boolean;
  LfFormBanco : TFr_Lanca_Banco;
begin
  IF Fc_ValidaConfirmaAntecipacao then
  Begin
    Try
      LfFormBanco := TFr_Lanca_Banco.Create(nil);
      LfFormBanco.Codigo           := 0;
      LfFormBanco.Quitacao         := 0;
      LfFormBanco.Data             := E_Dt_Antecipacao.Date;
      LfFormBanco.ContaCorrente    := 0;
      LfFormBanco.Operacao         := 'I';
      LfFormBanco.PlanoResultado   := 0;
      LfFormBanco.PlanoCentroCusto := 0;
      LfFormBanco.Historico        := 'Juros Antecipação';
      LfFormBanco.HistoricoBanco   := 0;
      LfFormBanco.ValorCredito     := 0;
      LfFormBanco.ValorDebito      := StrToFloatDef(E_Vl_Juros.Text,0);
      LfFormBanco.FormaPagto       := 0;
      LfFormBanco.Mensagem         := True;
      LfFormBanco.LiberaCampo      := False;
      LfFormBanco.AutoFill;
      LfFormBanco.ShowModal;
      Lc_Confirma := LfFormBanco.Resultado;
    Finally
      FreeAndNil(LfFormBanco);
      if (Lc_Confirma) then
      Begin
        Pc_AlteraDataantecipacao(E_Dt_Antecipacao.Date);
        Pc_LImpaAntecipacao;
        SB_BuscarClick(Sender);
        Pg_ContaCorrente.ActivePage := tbs_ContaCorrente;
      end;
    End;
  end;
end;

function TFr_ContasCorrente.fc_ValidaAntecipacao():boolean;
Var
  Lc_I : Integer;
Begin
  Result := True;
  Fm_ListaHistoricoBancario.AtivaLista;
end;

procedure TFr_ContasCorrente.Sb_AnteciparClick(Sender: TObject);
begin
  IF fc_ValidaAntecipacao then
  Begin
    Pg_ContaCorrente.ActivePage := tbs_Antecipar;
    Pc_TotalizaSelecao;
    Pc_TotalizaAntecipacao;
    //Pc_PreencheGradeAntecipa();
  end
end;

procedure TFr_ContasCorrente.E_Vl_JurosChange(Sender: TObject);
begin
  Pc_TotalizaAntecipacao;
end;

procedure TFr_ContasCorrente.E_Vl_JurosExit(Sender: TObject);
Var
  Lc_VL_juros:Real;
begin
  Lc_VL_juros := StrtoFloatDef(E_Vl_Juros.Text,0);
  Lc_VL_juros := StrtoFloatDef(E_Vl_Juros.Text,0);
  Pc_TotalizaAntecipacao;
end;

procedure TFr_ContasCorrente.Pc_AdicionarAntecipacao(Pc_Linha:Integer);
Var
  Lc_Registro : Integer;
  Lc_I : Integer;
Begin
  for Lc_I := 1 to StrGrd_Antecipa.RowCount - 1 do
  BEgin
    if StrGrd_Antecipa.Cells[2,Lc_I] = StrGrd_Lancamento.Cells[2,Pc_Linha] then
    Begin
      MensagemPadrao('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Este Registro já está na lista de antecipação.'+EOLN+
                     'Verifique e tente novamente.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
      exit;
    End;
  End;



  If (StrGrd_Antecipa.RowCount = 2) then
  Begin
    IF StrToIntDef(StrGrd_Antecipa.Cells[2,1],0) = 0 then
      Lc_Registro := 1
    else
      Lc_Registro := 2
  end
  else
  Begin
    Lc_Registro := StrGrd_Antecipa.RowCount;
  end;
  StrGrd_Antecipa.RowCount := 1 + Lc_Registro;
  StrGrd_Antecipa.Cells[2,Lc_Registro] := StrGrd_Lancamento.Cells[2,Pc_Linha];
  StrGrd_Antecipa.Cells[3,Lc_Registro] := StrGrd_Lancamento.Cells[3,Pc_Linha];
  StrGrd_Antecipa.Cells[4,Lc_Registro] := StrGrd_Lancamento.Cells[4,Pc_Linha];
  StrGrd_Antecipa.Cells[5,Lc_Registro] := StrGrd_Lancamento.Cells[5,Pc_Linha];
  StrGrd_Antecipa.Cells[6,Lc_Registro] := StrGrd_Lancamento.Cells[6,Pc_Linha];
  StrGrd_Antecipa.Cells[7,Lc_Registro] := StrGrd_Lancamento.Cells[7,Pc_Linha];
  StrGrd_Antecipa.Cells[8,Lc_Registro] := StrGrd_Lancamento.Cells[8,Pc_Linha];
  StrGrd_Antecipa.Cells[9,Lc_Registro] := StrGrd_Lancamento.Cells[9,Pc_Linha];
  StrGrd_Antecipa.Cells[10,Lc_Registro] := StrGrd_Lancamento.Cells[10,Pc_Linha];
  StrGrd_Antecipa.Cells[11,Lc_Registro] := StrGrd_Lancamento.Cells[11,Pc_Linha];
  StrGrd_Antecipa.Cells[12,Lc_Registro] := StrGrd_Lancamento.Cells[12,Pc_Linha];
  StrGrd_Antecipa.Cells[13,Lc_Registro] := 'X'; 

end;

procedure TFr_ContasCorrente.Adicionarantecipao1Click(Sender: TObject);
Var
  Lc_Ini, Lc_Fim : Integer;
  Lc_I : Integer;
begin
  Lc_Ini := StrGrd_Lancamento.Selection.Top;
  Lc_Fim := StrGrd_Lancamento.Selection.Bottom;
  For Lc_I := Lc_Ini to Lc_Fim do
    Pc_AdicionarAntecipacao(Lc_I);
end;

procedure TFr_ContasCorrente.SpeedButton1Click(Sender: TObject);
begin
Pg_ContaCorrente.ActivePage := tbs_ContaCorrente;
end;

end.



