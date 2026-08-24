unit Un_Caixa;

interface

uses
      Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, ComCtrls, Buttons, Un_Base, Grids, DBGrids, jpeg, STQuery, Menus, StrUtils, Variants, QEdit_Setes, Un_Fm_FormaPagto, ControllerMovimentoFinanceiro, ControllerBase;

type

  TFr_Caixa = class(TFr_Base)
    Qr_Pesquisa: TSTQuery;
    Ds_Pesquisa: TDataSource;
    Ds_Usuario: TDataSource;
    Qr_Totais_FPT: TSTQuery;
    Ds_Totais_FPT: TDataSource;
    Ppm_Caixa: TPopupMenu;
    AplicarPlanoContas1: TMenuItem;
    Panel4: TPanel;
    Dbg_DetalheCaixa: TDBGrid;
    GroupBox3: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label24: TLabel;
    Label4: TLabel;
    E_HistoricoInterno: TMaskEdit;
    CB_Caixa: TComboBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    DBLCB_Usuario: TDBLookupComboBox;
    ChBx_Periodo: TCheckBox;
    E_Valor: TEdit_Setes;
    Panel6: TPanel;
    SB_AbreCaixa: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    SB_Inserir: TSpeedButton;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Buscar: TSpeedButton;
    Panel1: TPanel;
    Lb_Atual: TLabel;
    Lb_Ultimo: TLabel;
    E_VL_Sld_Ant: TLabel;
    Label8: TLabel;
    Label26: TLabel;
    E_Dt_Ultimo: TLabel;
    E_Dt_Atual: TLabel;
    E_VL_Sld_Atual: TLabel;
    Dbg_Totalizador: TDBGrid;
    Sb_Fechar_Caixa: TSpeedButton;
    Qr_PesquisaMVF_CODIGO: TIntegerField;
    Qr_PesquisaMVF_CODCTB: TIntegerField;
    Qr_PesquisaMVF_DATA: TDateField;
    Qr_PesquisaMVF_CODHTB: TIntegerField;
    Qr_PesquisaMVF_CODPLC_C: TIntegerField;
    Qr_PesquisaPLC_CREDITO: TStringField;
    Qr_PesquisaMVF_CODPLC_D: TIntegerField;
    Qr_PesquisaPLC_DEBITO: TStringField;
    Qr_PesquisaMVF_VL_CREDITO: TBCDField;
    Qr_PesquisaMVF_VL_DEBITO: TBCDField;
    Qr_PesquisaMVF_HISTORISCO: TStringField;
    Qr_PesquisaMVF_TIPO: TStringField;
    Qr_PesquisaMVF_CODQTC: TIntegerField;
    Qr_PesquisaMVF_CODUSU: TIntegerField;
    Qr_PesquisaFPT_DESCRICAO: TStringField;
    Fm_FormaPagto: TFm_FormaPagto;
    EfetuarRetirada2: TMenuItem;
    RelatriodeCaixa2: TMenuItem;
    RelatoriodeCheques2: TMenuItem;
    TransferirparaoBanco: TMenuItem;
    Qr_Totais_FPTMVF_CODFPT: TIntegerField;
    Qr_Totais_FPTFPT_DESCRICAO: TStringField;
    Qr_Totais_FPTMVF_VALOR: TBCDField;
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_InserirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SB_AlterarClick(Sender: TObject);
    procedure SB_AbreCaixaClick(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure Ds_PesquisaStateChange(Sender: TObject);
    procedure DBLCB_CaixaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Dbg_DetalheCaixaDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure DBLCB_UsuarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure Dbg_DetalheCaixaTitleClick(Column: TColumn);
    procedure AplicarPlanoContas1Click(Sender: TObject);
    procedure Sb_Fechar_CaixaClick(Sender: TObject);
    procedure EfetuarRetirada2Click(Sender: TObject);
    procedure RelatriodeCaixa2Click(Sender: TObject);
    procedure RelatoriodeCheques2Click(Sender: TObject);
    procedure TransferirparaoBancoClick(Sender: TObject);
  private
    { Private declarations }
    BaseController :TControllerBase;
    pf_AbreCaixa: Boolean;
    pf_FechaCaixa: Boolean;
    procedure ImprimirSangria(MovimentoID:Integer);
    function validaMovimento:Boolean;
    procedure EfeturarRetirada;
    procedure TransferirParaBanco;
    function GetVinculoCaixaBancoByTransferencia:Boolean;
    procedure DeleteVinculoCaixaBancoByTransferencia;
    function Fc_ValidaExclusao: Boolean;
  protected
    procedure CriarVariaveis;Override;
    procedure ImagemBotao;Override;
    procedure IniciaVariaveis;Override;
    procedure setPerfil;Override;
    procedure AtivaTabelas;Override;

  public
    { Public declarations }
    Movimento : TControllerMovimentoFinanceiro;

    procedure PC_Buscar;

    procedure Pc_Dt_UltMov;
    procedure Pc_SaldoAnterior;
    procedure Pc_SaldoDiario;
    procedure Pc_DataCaixa;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    function Fc_ValidaAlteracao: Boolean;


    Function Fc_ValidaAberturaCaixa():Boolean;

    procedure Pc_Totaliza_Formas_Pagto;


    function Fc_VerificaExistenciaRegistro():Boolean;
    function Fc_ValidaRegistraCheque():Boolean;
    procedure Pc_RegistraCheque;

  end;

var
  Fr_Caixa: TFr_Caixa;

implementation

uses     Un_DM, UN_MSG, Un_Funcoes, UN_Sistema, UN_Imp_CtrlCheques, UN_RL_Resumo_Caixa, UN_RL_Lanca_Caixa, UN_Imp_Caixa, Un_Regra_Negocio, UN_Principal, env, un_Padrao, RN_PlanoContas, Un_Caixa_Fechamento, ControllerDskCashier, RI_MovimentoFinanceiro, ControllerCheque, prmCheques, Un_Fm_CentroCusto, Un_Fm_CentroResultado, Un_Lanca_Banco, un_frx_report_sangria, Un_Lanca_Caixa;
{$R *.dfm}


procedure TFr_Caixa.Pc_Dt_UltMov;
var
  Lc_Qry : TSTQuery;
  Lc_Usuario : boolean;
begin
  Try
    Lc_Qry := BaseController.GeraQuery;
    with Lc_Qry do
    Begin
      Sql.add(concat(
                'SELECT  MAX(MVF_DATA) MVF_DT_ANT '+
                'FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro '+
                'WHERE (MVF_CODCTB = 0) AND (MVF_CODMHA =:MVF_CODMHA)'
      ));

      if (DateToStr(Gb_DataCaixa) <> '30/12/1899' ) then
        Sql.add( ' AND (MVF_DATA < :MVF_DATA) ');
      if Trim(DBLCB_Usuario.Text) = '' then Lc_Usuario := False else Lc_Usuario := True;
      IF Lc_Usuario then
        Sql.add(' AND (MVF_CODUSU =:MVF_CODUSU)');

      if (DateToStr(Gb_DataCaixa) <> '30/12/1899' ) then
        ParamByName('MVF_DATA').AsDateTime := gb_DataCaixa;
      IF Lc_Usuario then
        ParamByName('MVF_CODUSU').AsInteger := DBLCB_Usuario.KeyValue;
      ParamByName('MVF_CODMHA').AsInteger := Gb_CodMha;
      Active := True;
      Fetchall;
      if recordCount > 0 then
      Begin
        if (DateToStr(fieldbyname('MVF_DT_ANT').AsDateTime) <> '30/12/1899' ) then
          E_Dt_Ultimo.Caption := DateToStr(fieldbyname('MVF_DT_ANT').AsDateTime);
      End
      else
      Begin
        if (DateToStr(Gb_DataCaixa) <> '30/12/1899' ) then
          E_Dt_Ultimo.Caption := DateToStr(Gb_DataCaixa);
      End;
    End;
  Finally
    BaseController.FinalizaQuery(Lc_Qry);
  End;
end;

procedure TFr_Caixa.Pc_SaldoAnterior;
var
  Lc_Qry     : TSTQuery;
  Lc_Usuario : Boolean;
  vSaldo     : Currency;
  sSaldoRaw  : string;

  procedure MontaSQLComoNumerico(Q: TSTQuery);
  begin
    Q.SQL.Clear;
    Q.SQL.Add(
      'SELECT COALESCE(SUM(COALESCE(MVF_VL_CREDITO,0) - COALESCE(MVF_VL_DEBITO,0)),0) AS MVF_VL_SLD_ANT '+
      'FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro '+
      'WHERE (MVF_CODCTB = 0) AND (MVF_CODMHA = :MVF_CODMHA)'
    );
    if (E_Dt_Atual.Caption <> '') then
      Q.SQL.Add(' AND (MVF_DATA < :DATAINICIO) ')
    else
      Q.SQL.Add(' AND (MVF_DATA <= :DATAINICIO) ');

    if Lc_Usuario then
      Q.SQL.Add(' AND (MVF_CODUSU = :MVF_CODUSU) ');
  end;

  procedure MontaSQLComoTexto(Q: TSTQuery);
  begin
    Q.SQL.Clear;
    // Mesma soma, mas convertida para texto para capturar a string que est� dando problema
    Q.SQL.Add(
      'SEECT '+
      'COALESCE( '+
      '  SUM( '+
      '    CAST(COALESCE(MVF_VL_CREDITO, 0) AS NUMERIC(18,2)) - '+
      '    CAST(COALESCE(MVF_VL_DEBITO , 0) AS NUMERIC(18,2))  '+
      '  ), 0 '+
      ') AS MVF_VL_SLD_ANT '+
      'FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro '+
      'WHERE (MVF_CODCTB = 0) AND (MVF_CODMHA = :MVF_CODMHA)'
    );
    if (E_Dt_Atual.Caption <> '') then
      Q.SQL.Add(' AND (MVF_DATA < :DATAINICIO) ')
    else
      Q.SQL.Add(' AND (MVF_DATA <= :DATAINICIO) ');

    if Lc_Usuario then
      Q.SQL.Add(' AND (MVF_CODUSU = :MVF_CODUSU) ');
  end;

  procedure AtribuiParams(Q: TSTQuery);
  begin
    if (E_Dt_Atual.Caption <> '') then
      Q.ParamByName('DATAINICIO').AsDate := StrToDateDef(E_Dt_Atual.Caption, Date - 1)
    else
      Q.ParamByName('DATAINICIO').AsDate := StrToDateDef(E_Dt_Ultimo.Caption, Date);

    if Lc_Usuario then
      Q.ParamByName('MVF_CODUSU').AsInteger := DBLCB_Usuario.KeyValue;

    Q.ParamByName('MVF_CODMHA').AsInteger := Gb_CodMha;
  end;

  procedure CorrigeZerandoValoresSaldo(Q: TSTQuery);
  begin
    Q.SQL.Clear;
    // Mesma soma, mas convertida para texto para capturar a string que est� dando problema
    Q.SQL.Add(
          'UPDATE tb_movim_financeiro SET '+
          'mvf_vl_credito  = 0, '+
          'mvf_vl_DEBITO = 0, '+
          'mvf_historisco = mvf_historisco || '' - Zerado por corre��o''  '+
          'WHERE mvf_codctb = 0 '+
          'AND mvf_codusu = :mvf_codusu '+
          'AND mvf_historisco LIKE :mvf_historisco '+
          'AND ((mvf_vl_credito > 1000000) or ((mvf_vl_debito > 1000000))   )  '
          );

  end;
begin
  Lc_Usuario := Trim(DBLCB_Usuario.Text) <> '';

  Lc_Qry := BaseController.GeraQuery;
  try
    // 1) Tenta como num�rico (normal)
    MontaSQLComoNumerico(Lc_Qry);
    AtribuiParams(Lc_Qry);
    try
      Lc_Qry.Prepare;
      Lc_Qry.Active := True;
      Lc_Qry.FetchAll;

      if Lc_Qry.RecordCount > 0 then
      begin
        vSaldo := Lc_Qry.FieldByName('MVF_VL_SLD_ANT').AsCurrency;
        E_VL_Sld_Ant.Caption := FloatToStrF(vSaldo, ffNumber, 15, 2);
      end
      else
        E_VL_Sld_Ant.Caption := '0,00';

    except
      on E: Exception  do
      begin
        // 2) Falhou na convers�o: captura o valor bruto como texto
        try
          Lc_Qry.Close;
          CorrigeZerandoValoresSaldo(Lc_Qry);
          Lc_Qry.ParamByName('MVF_CODUSU').AsInteger := DBLCB_Usuario.KeyValue;
          Lc_Qry.ParamByName('mvf_historisco').AsString := 'FECH CAIXA%';
          Lc_Qry.ExecSQL;
          Lc_Qry.Close;
          MontaSQLComoNumerico(Lc_Qry);
          AtribuiParams(Lc_Qry);
          Lc_Qry.Prepare;
          Lc_Qry.Active := True;
          Lc_Qry.FetchAll;

          if Lc_Qry.RecordCount > 0 then
          begin
            vSaldo := Lc_Qry.FieldByName('MVF_VL_SLD_ANT').AsCurrency;
            E_VL_Sld_Ant.Caption := FloatToStrF(vSaldo, ffNumber, 15, 2);
          end
          else
            E_VL_Sld_Ant.Caption := '0,00';
        except
          // Se at� o fallback falhar, garante zero
          E_VL_Sld_Ant.Caption := '0,00';
        end;
      end;
    end;

  finally
    BaseController.FinalizaQuery(Lc_Qry);
  end;
end;


procedure TFr_Caixa.Pc_SaldoDiario;
var
  Lc_Qry : TSTQuery;
  Lc_Usuario : Boolean;
  Lc_SaldoAnterior, Lc_SaldoAtual : real;
begin
  Try
   //Valores do Dia
    Lc_SaldoAnterior := 0;
    Lc_SaldoAtual := 0;
    Lc_Qry := BaseController.GeraQuery;
    with Lc_Qry do
    Begin
      if ( E_Dt_Atual.Caption <> '') then
      Begin
        SQL.add(concat(
                  'SELECT  SUM (MVF_VL_CREDITO) AS MVF_VL_CRED_D,  SUM (MVF_VL_DEBITO) AS MVF_VL_DEBI_D ',
                  'FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro ',
                  'WHERE (MVF_DATA =:MVF_DATA) AND (MVF_CODCTB = 0) AND (MVF_CODMHA=:MVF_CODMHA)'
        ));

        if Trim(DBLCB_Usuario.Text) = '' then Lc_Usuario := False else Lc_Usuario := True;
        IF Lc_Usuario then
          SQL.add(' AND (MVF_CODUSU =:MVF_CODUSU)');


        if CB_Caixa.Text = '' then
          ParamByName('MVF_DATA').AsDateTime :=  Gb_DataCaixa
        else
          ParamByName('MVF_DATA').AsDateTime :=  StrToDateDef(CB_Caixa.Text,Date);
        IF Lc_Usuario then ParamByName('MVF_CODUSU').AsInteger := DBLCB_Usuario.KeyValue;
          ParamByName('MVF_CODMHA').AsInteger := Gb_CodMha;
        Active := True;
        Fetchall;
        Lc_SaldoAtual := fieldbyname('MVF_VL_CRED_D').AsCurrency - fieldbyname('MVF_VL_DEBI_D').AsCurrency;
      End;
      Lc_SaldoAnterior := StrToFloatDef(Fc_RemoveCaracterInformado(E_VL_Sld_Ant.Caption,['.']),0);
      E_VL_Sld_Atual.Caption := FloatToStrF(Lc_SaldoAnterior + Lc_SaldoAtual,ffNumber,15,2);
    End;
  Finally
    BaseController.FinalizaQuery(Lc_Qry);
  End;
end;

procedure TFr_Caixa.Pc_DataCaixa;
var
  Lc_Qry : TSTQuery;
  Lc_Usuario : boolean;
begin
  Lc_Qry := BaseController.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'SELECT DISTINCT MVF_DATA ',
                'FROM TB_MOVIM_FINANCEIRO ',
                ' WHERE MVF_CODCTB = 0 AND (MVF_CODMHA =:MVF_CODMHA)'
      ));
      ParamByName('MVF_CODMHA').AsInteger := Gb_CodMha;
      Active := true;
      FetchAll;
      First;
      while not Eof do
      Begin
        CB_Caixa.Items.Add(fieldbyname('MVF_DATA').AsString);
        Next;
      end;
    End;
  Finally
    BaseController.FinalizaQuery(Lc_Qry);
  End;
end;

procedure TFr_Caixa.AtivaTabelas;
begin
  Fm_FormaPagto.Pc_Listar(3,false,0);
end;

procedure TFr_Caixa.Pc_Buscar;
var
  Sqltxt:string;
  lc_Hist_Interno, Lc_Valor, Lc_Usuario: boolean;
begin
  with Qr_Pesquisa do
  Begin
    Sqltxt := '';
    Screen.Cursor:=crHourGlass;
    Close;
    Sql.Clear;
    Sqltxt := 'SELECT  MVF_CODIGO, MVF_CODCTB, MVF_DATA, MVF_CODHTB,   '+
              '  MVF_CODPLC_C,  tb_ctacredito.PLC_DESCRICAO AS PLC_CREDITO,  MVF_CODPLC_D, '+
              '  tb_ctadebito.PLC_DESCRICAO AS PLC_DEBITO,  MVF_VL_CREDITO,  MVF_VL_DEBITO, '+
              '  MVF_HISTORISCO,  MVF_TIPO,  MVF_CODQTC,  MVF_CODUSU, FPT_DESCRICAO '+
              'FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro '+
              '   LEFT OUTER JOIN TB_PLANOCONTAS tb_ctacredito '+
              '   ON (tb_ctacredito.PLC_CODIGO = tb_movim_financeiro.MVF_CODPLC_C) '+
              '   LEFT OUTER  JOIN TB_PLANOCONTAS tb_ctadebito '+
              '   ON (tb_ctadebito.PLC_CODIGO = tb_movim_financeiro.MVF_CODPLC_D) '+
              '   INNER JOIN TB_FORMAPAGTO '+
              '   ON (fpt_codigo = MVF_CODFPT) '+
              'WHERE (MVF_CODCTB = 0) and (MVF_CODMHA =:MVF_CODMHA)';

    if E_HistoricoInterno.Text = '' then lc_Hist_Interno := False else lc_Hist_Interno := True;
    if E_Valor.Text = '' then Lc_Valor := False else Lc_Valor := True;
    if Trim(DBLCB_Usuario.Text) = '' then Lc_Usuario := False else Lc_Usuario := True;

    if ChBx_Periodo.Checked then
    Begin
      sqltxt := sqltxt + ' AND MVF_DATA BETWEEN :DATAINI AND :DATAFIM ';
    end
    else
      sqltxt := sqltxt + ' AND (MVF_DATA = :DATACAIXA) ';

    if lc_Hist_Interno then sqltxt := sqltxt + ' AND (MVF_HISTORISCO LIKE :MVF_HISTORISCO)  ';
    if Lc_Valor then sqltxt := sqltxt + ' AND ((MVF_VL_CREDITO =:MVF_VALOR) OR (MVF_VL_DEBITO =:MVF_VALOR))';
    if Lc_Usuario then sqltxt := sqltxt + ' AND (MVF_CODUSU =:MVF_CODUSU)';

    if Fm_FormaPagto.DBLCB_FormaPagto.Text <> '' then
      sqltxt := sqltxt + ' AND ( MVF_CODFPT =:FPT_CODIGO ) ';

    SQL.Add(sqltxt +' ORDER BY MVF_DATA');

    if ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    end
    else
      ParamByName('DATACAIXA').AsDate:=(StrTodateDef(CB_Caixa.Text,Date));
    If lc_Hist_Interno Then
      Parambyname('MVF_HISTORISCO').AsString:='%'+E_HistoricoInterno.text+'%';
    if Lc_Valor then
      ParamByName('MVF_VALOR').AsCurrency := StrToFloatDef(E_Valor.Text,0);
    if Lc_Usuario then
      ParamByName('MVF_CODUSU').AsInteger := DBLCB_Usuario.KeyValue;
    ParamByName('MVF_CODMHA').AsInteger := Gb_CodMha;
    if Fm_FormaPagto.DBLCB_FormaPagto.Text <> '' then
      ParamByName('FPT_CODIGO').asInteger := Fm_FormaPagto.DBLCB_FormaPagto.KeyValue;
    Open;
    Screen.Cursor:=crDefault;
  End;
end;


procedure TFr_Caixa.SB_ExcluirClick(Sender: TObject);
begin
  if Fc_ValidaExclusao then
  begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Excluir o item '+ Qr_Pesquisa.FieldByName('MVF_HISTORISCO').AsString +' do Banco.'+EOLN+EOLN+
                       'Confirmar a exclus�o ?',
                       [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
    Begin
      DeleteVinculoCaixaBancoByTransferencia;
      Movimento.Registro.Codigo := Qr_Pesquisa.FieldByName('MVF_CODIGO').AsInteger;
      Movimento.delete;
      SB_BuscarClick(sender);
    end;
  end;
end;





procedure TFr_Caixa.Sb_Fechar_CaixaClick(Sender: TObject);
Var
  Lc_Form : TFr_Caixa_Fechamento;
begin
  if Fc_VerificaCaixaAberto(True) then
  Begin
    Lc_Form := TFr_Caixa_Fechamento.create(Self);
    Lc_Form.ShowModal;
    DBLCB_Usuario.KeyValue := Gb_Cd_Usuario;
    PC_Buscar;
    Pc_SaldoAnterior;
    Pc_SaldoDiario;
    Pc_Totaliza_Formas_Pagto;
  End;
end;

procedure TFr_Caixa.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Caixa.setPerfil;
Var
  Lc_Menu : String;
begin
  Lc_Menu := 'Lan�amento Caixa';
  if Gb_Nivel = 1 then
  begin
    Pf_Inserir    := True;
    Pf_Alterar    := True;
    Pf_Excluir    := True;
    Pf_Visualizar := True;
    Pf_AbreCaixa  := True;
    Pf_FechaCaixa := True;
  end
  else
  begin
    Pf_Inserir    := Fc_HabilitaPermissao(Lc_Menu,'INSERIR','S');
    Pf_Alterar    := Fc_HabilitaPermissao(Lc_Menu,'ALTERAR','S');
    Pf_Excluir    := Fc_HabilitaPermissao(Lc_Menu,'EXCLUIR','S');
    Pf_Visualizar := Fc_HabilitaPermissao(Lc_Menu,'VISUALIZAR','S');
    Pf_AbreCaixa  := Fc_HabilitaPermissao(Lc_Menu,'ABRE CAIXA','S');
    Pf_FechaCaixa := Fc_HabilitaPermissao(Lc_Menu,'ABRE CAIXA','S');
  end;
  SB_Inserir.Enabled   :=  Pf_Inserir;
  SB_Alterar.Enabled   :=  Pf_Alterar and (Qr_Pesquisa.RecordCount > 0);
  SB_Excluir.Enabled   :=  Pf_Excluir and (Qr_Pesquisa.RecordCount > 0);
  SB_AbreCaixa.Enabled :=  Pf_AbreCaixa;
  Sb_Fechar_Caixa.Enabled := Pf_FechaCaixa;
end;

procedure TFr_Caixa.TransferirParaBanco;
Var
  Lc_Cd_FormaPagto : Integer;
  Lc_Valor : Real;
  Lc_cd_Quitacao : Integer;
  Lc_Historico : String;
  LfFormCaixa : TFr_Lanca_Caixa;
  LfFormBanco : TFr_Lanca_Banco;
  Lc_OK : Boolean;
begin
  MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                 'Esta transa��o executar� as seguintes opera��es de transfer�ncia.'+EOLN+
                 '1� - Retirar do caixa o valor correspondente.'+EOLN+
                 '� - Lan�ar este mesmo valor em conta corrente informada.'+EOLN,
                ['OK'],[bEscape],mpErro);
  Lc_OK := False;
  Lc_cd_Quitacao := Fc_GeraCod_BAixa;
  Lc_Historico := 'Transfer�ncia do Caixa para o Banco �s'+ TimeToStr(Now);
  if Fc_VErificaCaixaAberto(True) then
  Begin
    Try
      LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
      LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
      LfFormCaixa.Titulo           := 'Lan�amento de Transfer�ncia para Banco';
      LfFormCaixa.Codigo           := 0;
      LfFormCaixa.Quitacao         := Lc_cd_Quitacao;
      LfFormCaixa.Caption          := '';
      LfFormCaixa.Operacao         := 'I';
      LfFormCaixa.PlanoResultado   := 0;
      LfFormCaixa.PlanoCentroCusto := 0;
      LfFormCaixa.Historico        := Lc_Historico;
      LfFormCaixa.ValorCredito     := 0;
      LfFormCaixa.ValorDebito      := Qr_Totais_FPT.FieldByName('MVF_VALOR').AsCurrency;
      LfFormCaixa.FormaPagto       := Qr_Totais_FPT.FieldByName('MVF_CODFPT').AsInteger;
      LfFormCaixa.Mensagem         := True;
      LfFormCaixa.LiberaCampo      := True;
      LfFormCaixa.AutoFill;
      LfFormCaixa.E_Historico.ReadOnly := True;
      LfFormCaixa.E_Credito.ReadOnly := True;
      LfFormCaixa.ShowModal;
      Lc_OK := LfFormCaixa.Resultado;
      Lc_Cd_FormaPagto  := LfFormCaixa.Movimento.Registro.FormaPagto;
      Lc_Valor          := LfFormCaixa.Movimento.Registro.ValorDebito;
    Finally
      FreeAndNil(LfFormCaixa);
    End;
  End;
  if not Lc_OK then exit;

  Try
    //Efetua a deposito na Conta corrente
    LfFormBanco := TFr_Lanca_Banco.Create(nil);
    LfFormBanco.ForcarLancamento := True;
    LfFormBanco.Titulo           := 'Lan�amento de Transfer�ncia do Caixa';
    LfFormBanco.Codigo           := 0;
    LfFormBanco.Quitacao         := Lc_cd_Quitacao;
    LfFormBanco.Caption          := '';
    LfFormBanco.Data             := Date;
    LfFormBanco.ContaCorrente    := 0;
    LfFormBanco.Operacao         := 'I';
    LfFormBanco.PlanoResultado   := 0;
    LfFormBanco.PlanoCentroCusto := 0;
    LfFormBanco.Historico        := Lc_Historico;
    LfFormBanco.HistoricoBanco   := 0;
    LfFormBanco.ValorCredito     := Lc_Valor;
    LfFormBanco.ValorDebito      := 0;
    LfFormBanco.FormaPagto       := Lc_Cd_FormaPagto;
    LfFormBanco.Mensagem         := True;
    LfFormBanco.LiberaCampo      := False;
    LfFormBanco.AutoFill;
    LfFormBanco.E_Historico.ReadOnly := True;
    LfFormBanco.ShowModal;
  Finally
    FreeAndNil(LfFormBanco);
    Pc_Dt_UltMov;
    PC_Buscar;
    Pc_SaldoAnterior;
    Pc_SaldoDiario;
    Pc_Totaliza_Formas_Pagto;
  End;
end;

function TFr_Caixa.validaMovimento: Boolean;
begin
  REsult := True;
  if Qr_Totais_FPT.RecordCount = 0 then
  Begin
    MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                   ' N�o h� valores a serem movimentados.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  End;

  if not Fc_VErificaCaixaAberto(True) then
  Begin
    Result := False;
    Exit;
  end;


end;

procedure TFr_Caixa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
      case Key of
      VK_F2  : if SB_Inserir.Enabled then SB_InserirClick(Sender);
      VK_F3  : if SB_Alterar.Enabled then SB_AlterarClick(Sender);
      VK_F4  : if SB_Excluir.Enabled then SB_ExcluirClick(Sender);
      VK_F5  : if SB_AbreCaixa.Enabled then SB_AbreCaixaClick(Sender);
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
      end;
    end;
end;

procedure TFr_Caixa.SB_InserirClick(Sender: TObject);
var
    LfFormCaixa : TFr_Lanca_Caixa;
begin
  if Fc_VErificaCaixaAberto(True) then
  Begin
    Try
      LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
      LfFormCaixa.Codigo           := 0;
      LfFormCaixa.Quitacao         := 0;
      LfFormCaixa.Caption          := '';
      LfFormCaixa.Operacao         := 'I';
      LfFormCaixa.PlanoResultado   := 0;
      LfFormCaixa.PlanoCentroCusto := 0;
      LfFormCaixa.Historico        := '';
      LfFormCaixa.ValorCredito     := 0;
      LfFormCaixa.ValorDebito      := 0;
      LfFormCaixa.FormaPagto       := 0;
      LfFormCaixa.Mensagem         := True;
      LfFormCaixa.LiberaCampo      := True;
      LfFormCaixa.AutoFill;
      LfFormCaixa.ShowModal;
    Finally
      FreeAndNil(LfFormCaixa);
      Pc_Dt_UltMov;
      PC_Buscar;
      Pc_SaldoAnterior;
      Pc_SaldoDiario;
      Pc_Totaliza_Formas_Pagto;
    End;
  End;
end;

procedure TFr_Caixa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

function TFr_Caixa.GetVinculoCaixaBancoByTransferencia: Boolean;
Var
  LcMovimento : TControllerMovimentoFinanceiro;
begin
  try
    LcMovimento := TControllerMovimentoFinanceiro.create(nil);
    LcMovimento.Registro.Historico := Qr_Pesquisa.FieldByName('mvf_historisco').AsString;
    LcMovimento.Registro.Quitacao := Qr_Pesquisa.FieldByName('MVF_CODQTC').AsInteger;
    Result := LcMovimento.GetVinculoCaixaBancoByTransferencia;
  finally
    FreeAndNil(LcMovimento);
  end;
end;

procedure TFr_Caixa.IniciaVariaveis;
Begin
  Pc_DataCaixa;
  //Verifica Caixa Aberto
  Fc_VerificaCaixaAberto(False);
  E_Dt_Atual.Caption := '';
  E_Dt_Ultimo.Caption := '';
  if (DateToStr(Gb_DataCaixa) <> '30/12/1899' ) then
  Begin
    CB_Caixa.Text := DateToStr(Gb_DataCaixa);
    E_Dt_Atual.Caption := DateToStr(Gb_DataCaixa);
  End;
  DM.Qr_ListaUsuario.Active := True;
  DBLCB_Usuario.KeyValue := Gb_Cd_Usuario;
  if (Gb_Nivel = 0) then
    DBLCB_Usuario.Enabled := false
  else
    DBLCB_Usuario.Enabled := True;
  E_Data_INI.Date:=Date;
  E_Data_FIM.Date:=Date;
  Pc_Dt_UltMov;
  PC_Buscar;
  Pc_SaldoAnterior;
  Pc_SaldoDiario;
  Pc_Totaliza_Formas_Pagto;
  Ds_PesquisaStateChange(Qr_Pesquisa);
end;


function TFr_Caixa.Fc_VerificaExistenciaRegistro():Boolean;
Begin
  Result := true;
  Qr_Pesquisa.FetchAll;
  if (Qr_Pesquisa.RecordCount  = 0) then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'N�o � h� registros na lista.'+EOLN+EOLN+
                   'Verifique antes de Continuar.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := false;
    Exit;
  end;
end;



procedure TFr_Caixa.SB_AlterarClick(Sender: TObject);
Var
 LfFormCaixa : TFr_Lanca_Caixa;
begin
  if Fc_ValidaAlteracao then
  Begin
    Try
      LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
      LfFormCaixa.Codigo           := Qr_Pesquisa.FieldByName('MVF_CODIGO').AsInteger;
      LfFormCaixa.Quitacao         := 0;
      LfFormCaixa.Caption          := '';
      LfFormCaixa.Operacao         := 'E';
      LfFormCaixa.PlanoResultado   := 0;
      LfFormCaixa.PlanoCentroCusto := 0;
      LfFormCaixa.Historico        := '';
      LfFormCaixa.ValorCredito     := 0;
      LfFormCaixa.ValorDebito      := 0;
      LfFormCaixa.FormaPagto       := 0;
      LfFormCaixa.Mensagem         := True;
      LfFormCaixa.LiberaCampo      := True;
      LfFormCaixa.AutoFill;
      LfFormCaixa.ShowModal;
    Finally
      FreeAndNil(LfFormCaixa);
      Pc_Dt_UltMov;
      PC_Buscar;
      Pc_SaldoAnterior;
      Pc_SaldoDiario;
      Pc_Totaliza_Formas_Pagto;
    end;
  End;
end;

procedure TFr_Caixa.Pc_Totaliza_Formas_Pagto;
Var
  Lc_Data : TDateTime;
begin
  Qr_Totais_FPT.Active := False;
  Qr_Totais_FPT.SQL.Clear;
  Qr_Totais_FPT.SQL.ADD('SELECT MVF_CODFPT, fpt_descricao, CAST(SUM (MVF_VL_CREDITO - MVF_VL_DEBITO) AS NUMERIC(18, 2)) as MVF_VALOR '+
                        'FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro  '+
                        '  LEFT JOIN tb_formapagto '+
                        '  ON (tb_formapagto.fpt_codigo = tb_movim_financeiro.mvf_codfpt)  '+
                        'WHERE (MVF_CODCTB = 0)  '+
                        'AND (MVF_CODMHA =:MVF_CODMHA) ');

  if trim(DBLCB_Usuario.Text) <>'' then
    Qr_Totais_FPT.SQL.ADD('AND (MVF_CODUSU =:MVF_CODUSU)                                                    ');

  Qr_Totais_FPT.SQL.ADD('GROUP BY MVF_CODFPT,fpt_descricao '+
                        'having SUM (MVF_VL_CREDITO - MVF_VL_DEBITO) <> 0 ');

  if trim(DBLCB_Usuario.Text) <>'' then
    Qr_Totais_FPT.ParamByName('MVF_CODUSU').AsInteger := DBLCB_Usuario.KeyValue;
  Qr_Totais_FPT.ParamByName('MVF_CODMHA').AsInteger := Gb_CodMha;
  Qr_Totais_FPT.Active := True;
  Qr_Totais_FPT.FetchAll;
end;

procedure TFr_Caixa.TransferirparaoBancoClick(Sender: TObject);
begin
  if ( validaMovimento ) then
  Begin
    TransferirParaBanco;
  End;
end;

procedure TFr_Caixa.RelatoriodeCheques2Click(Sender: TObject);
Var
  Lc_Cheques : TControllerCheque;
  Lc_Param : TParamCheques;
begin
  try
    Lc_Param := TParamCheques.Create;
    with Lc_Param do
    Begin
      Periodo := False;
      CodigoEmpresa := 0;
      CodigoEstabelecimento := Gb_Codmha;
      CampoOrdenacao := 'EMITENTE';
    end;
    Lc_Cheques := TControllerCheque.create(Self);
    Lc_Cheques.ReportDisponivelCaixa('I','',Lc_Param);
  finally
    FreeAndNil(Lc_Param);
    FreeAndNil(Lc_Cheques);
  end;
end;

procedure TFr_Caixa.RelatriodeCaixa2Click(Sender: TObject);
begin
  If not Assigned(Fr_Imp_Caixa) then Application.CreateForm(TFr_Imp_Caixa, Fr_Imp_Caixa);
  Fr_Imp_Caixa.ShowModal;
end;

procedure TFr_Caixa.SB_AbreCaixaClick(Sender: TObject);
Var
  Lc_Cashier : TControllerDskCashier;
begin
  if Fc_ValidaAberturaCaixa then
  Begin
    Try
      Lc_Cashier := TControllerDskCashier.Create(nil);
      Lc_Cashier.Registro.Usuario := GB_Cd_Usuario;
      Lc_Cashier.AbrirCaixa;
      Fc_VerificaCaixaAberto(False);
      MensagemPadrao('Mensagem ','S U C E S S O!.'+EOLN+EOLN+
                     'Caixa aberto com sucesso.'+EOLN+EOLN,
                    ['OK'],[bEscape],mpInformacao);

      CB_Caixa.Text := DateToStr(Gb_DataCaixa);
      E_Dt_Atual.Caption := DateToStr(Gb_DataCaixa);
      PC_Buscar;
      Pc_SaldoAnterior;
      Pc_SaldoDiario;
      Pc_Totaliza_Formas_Pagto;
    Finally
      FreeAndNil(Lc_Cashier);
    End;
  End;
end;

procedure TFr_Caixa.SB_BuscarClick(Sender: TObject);
begin
  Pc_Dt_UltMov;
  PC_Buscar;
  Pc_SaldoAnterior;
  Pc_SaldoDiario;
  Pc_Totaliza_Formas_Pagto;
end;

procedure TFr_Caixa.Ds_PesquisaStateChange(Sender: TObject);
Begin
  SB_Alterar.Enabled :=  pf_Alterar and (Qr_Pesquisa.RecordCount > 0) ;
  SB_Excluir.Enabled :=  pf_Excluir and (Qr_Pesquisa.RecordCount > 0);
end;

procedure TFr_Caixa.EfetuarRetirada2Click(Sender: TObject);
begin
  if ( validaMovimento ) then
  Begin
    EfeturarRetirada;
  End;
end;

procedure TFr_Caixa.EfeturarRetirada;
Var
  LfFormCaixa : TFr_Lanca_Caixa;
  CodigoMovimento : Integer;
begin
  try
    LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
    LfFormCaixa.Titulo           := 'Lan�amento de Retirada/Sangria';
    LfFormCaixa.Codigo           := 0;
    LfFormCaixa.Quitacao         := 0;
    LfFormCaixa.Caption          := '';
    LfFormCaixa.Operacao         := 'I';
    LfFormCaixa.PlanoResultado   := 0;
    LfFormCaixa.PlanoCentroCusto := 0;
    LfFormCaixa.Historico        := 'Retirada/Sangria �s'+ TimeToStr(Now);
    LfFormCaixa.ValorCredito     := 0;
    LfFormCaixa.ValorDebito      := Qr_Totais_FPT.FieldByName('MVF_VALOR').AsCurrency;
    LfFormCaixa.FormaPagto       := Qr_Totais_FPT.FieldByName('MVF_CODFPT').AsInteger;
    LfFormCaixa.Mensagem         := True;
    LfFormCaixa.LiberaCampo      := True;
    LfFormCaixa.AutoFill;
    LfFormCaixa.E_Credito.ReadOnly := True;
    LfFormCaixa.ShowModal;
    CodigoMovimento := LfFormCaixa.Movimento.registro.codigo
  finally
    if LfFormCaixa.Movimento.registro.codigo > 0 then
      ImprimirSangria(CodigoMovimento);
    FreeAndNil(LfFormCaixa);
    Pc_Dt_UltMov;
    PC_Buscar;
    Pc_SaldoAnterior;
    Pc_SaldoDiario;
    Pc_Totaliza_Formas_Pagto;
  end;
end;

procedure TFr_Caixa.DBLCB_CaixaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  : CB_Caixa.Text := Null;
  end;
end;

procedure TFr_Caixa.Dbg_DetalheCaixaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if Ds_Pesquisa.DataSet.FieldByName('MVF_VL_CREDITO').AsCurrency = 0 then
    dbg_DetalheCaixa.Canvas.Font.Color := clRed;
  dbg_DetalheCaixa.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TFr_Caixa.DBLCB_UsuarioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Usuario.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_Caixa.DeleteVinculoCaixaBancoByTransferencia;
Var
  LcMovimento : TControllerMovimentoFinanceiro;
begin
  try
    LcMovimento := TControllerMovimentoFinanceiro.create(nil);
    LcMovimento.Registro.Historico := Qr_Pesquisa.FieldByName('mvf_historisco').AsString;
    LcMovimento.Registro.Quitacao := Qr_Pesquisa.FieldByName('MVF_CODQTC').AsInteger;
    LcMovimento.DeleteVinculoCaixaBancoByTransferencia;
  finally
    FreeAndNil(LcMovimento);
  end;
end;

procedure TFr_Caixa.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Caixa.CriarVariaveis;
begin
  inherited;
  Movimento := TControllerMovimentoFinanceiro.create(Self);
  BaseController := TControllerBase.create(Self);
end;

procedure TFr_Caixa.Dbg_DetalheCaixaTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(dbg_DetalheCaixa, Column);
end;

procedure TFr_Caixa.Pc_PermissaoBotao(Pc_Menu: string);
begin



end;

procedure TFr_Caixa.Pc_RegistraCheque;

begin

end;

function TFr_Caixa.Fc_ValidaAberturaCaixa: Boolean;
begin
  Result := true;
  if Fc_VerificaCaixaAberto(false) then
  Begin
    MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                   ' Existe um caixa aberto para este Usu�rio.' + EOLN +
                   ' Feche o caixa atual e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := false;
    exit;
  End;

  if Fc_VerificaCaixaFechadoAtual then
  Begin
    Result := false;
    exit;
  End;


end;

function TFr_Caixa.Fc_ValidaAlteracao: Boolean;
begin
  result := True;
  if not Fc_VErificaCaixaAberto(True) then
  Begin
    result := False;
    exit;
  End;

  if not Fc_VerificaExistenciaRegistro then
  Begin
    result := False;
    exit;
  End;
end;

function TFr_Caixa.Fc_ValidaExclusao: Boolean;
Var
  LcMovimento : TControllerMovimentoFinanceiro;
begin
  Result := True;
  If (StrToIntDef(Qr_Pesquisa.FieldByName('MVF_CODQTC').AsString,0) > 0) then
  begin
    if not GetVinculoCaixaBancoByTransferencia then
    Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'N�o � poss�vel a exclus�o dos dados.'+EOLN+EOLN+
                     'Lan�amento vinculado ao Financeiro.'+EOLN+EOLN,
                    ['OK'],[bEscape],mpAlerta);
      Result := False;
      exit;
    End;
  end;

  if not Fc_VerificaCaixaAberto(True) then
  Begin
    Result := False;
    exit;
  End;

  If (Qr_Pesquisa.FieldByName('MVF_DATA').AsDateTime <> Gb_DataCaixa ) then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'N�o � poss�vel a exclus�o dos dados.'+EOLN+EOLN+
                   'A data do lan�amento � diferente da data do Caixa.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;



end;


function TFr_Caixa.Fc_ValidaRegistraCheque: Boolean;
begin
  Result := True;
  if not Fc_VerificaExistenciaRegistro then
  Begin
    Result := False;
    exit;
  End;

  if Qr_PesquisaFPT_DESCRICAO.AsString <> 'CHEQUE' then
  Begin
    MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                   ' Este lan�amento n�o foi efetuado com cheque.' + EOLN +
                   ' Verique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := false;
    exit;
  End;

end;

procedure TFr_Caixa.ImagemBotao;
Begin
  CarregaImagemBotao(SB_Inserir,'INSERIR');
  CarregaImagemBotao(SB_Alterar,'ALTERAR');
  CarregaImagemBotao(SB_Excluir,'EXCLUIR');
  CarregaImagemBotao(SB_Buscar,'BUSCAR');
  CarregaImagemBotao(Sb_Sair_0,'SAIR');
end;

procedure TFr_Caixa.ImprimirSangria(MovimentoID:Integer);
Var
  Lc_Form: TFrx_report_sangria;
begin
  Try
    Lc_Form := TFrx_report_sangria.create(nil);
    Lc_Form.Caption := 'Retirada/Sangria';
    Lc_Form.CodigoMovimento := MovimentoID;
    Lc_Form.IniciaVariaveis;
    Lc_Form.frxBase.ShowReport;
  Finally
    Lc_Form.close;
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Caixa.AplicarPlanoContas1Click(Sender: TObject);
begin
  Qr_Pesquisa.FetchAll;
  if (Qr_Pesquisa.RecordCount=0) then
  Begin
    MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                   ' N�o h� registro selecionado.' + EOLN +
                   ' Verifique antes de continuar.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Exit;
  end;

  Pc_AplicarPlanoContasMovimentoFinanceiro(
    Qr_PesquisaMVF_CODPLC_D.AsInteger,
    Qr_PesquisaMVF_CODPLC_c.AsInteger,
    Qr_Pesquisa.FieldByName('MVF_CODIGO').AsInteger,
    '');
end;

end.

