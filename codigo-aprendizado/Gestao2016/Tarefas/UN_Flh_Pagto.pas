unit UN_Flh_Pagto;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask, DB, ComCtrls, STQuery, CheckLst, QEdit_Setes, Un_Fm_ListaColaboradores, ControllerFolhaPagto;

type
  TFr_Flh_Pagto = class(TForm)
    Qr_Pesquisa: TSTQuery;
    Ds_Pesquisa: TDataSource;
    Ds_Colaborador: TDataSource;
    Qr_Comissao: TSTQuery;
    Qr_Acao: TSTQuery;
    Ds_Folha: TDataSource;
    Panel1: TPanel;
    SB_Inserir: TSpeedButton;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    SB_Filtrar: TSpeedButton;
    SB_Folha: TSpeedButton;
    Sb_Ficha: TSpeedButton;
    Label22: TLabel;
    Label12: TLabel;
    Label7: TLabel;
    Lb_Vl_Vencimento: TLabel;
    Lb_Vl_Descontos: TLabel;
    Lb_Vl_Liquido: TLabel;
    Label17: TLabel;
    Lb_Vl_Comissao: TLabel;
    Sb_Sair_0: TSpeedButton;
    Label3: TLabel;
    Lb_Colaborador: TLabel;
    DBG_Servicos: TDBGrid;
    GroupBox1: TGroupBox;
    Label28: TLabel;
    Label11: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    E_BuscaHistor: TEdit;
    CB_Mes: TComboBox;
    E_Ano: TEdit;
    UpD_Ano: TUpDown;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    E_BuscaValor: TEdit_Setes;
    Qr_PesquisaFPT_CODIGO: TIntegerField;
    Qr_PesquisaFPT_CODCLB: TIntegerField;
    Qr_PesquisaFPT_DATA: TDateField;
    Qr_PesquisaFPT_MES: TIntegerField;
    Qr_PesquisaFPT_ANO: TIntegerField;
    Qr_PesquisaFPT_HISTORICO: TStringField;
    Qr_PesquisaFPT_VL_CREDITO: TBCDField;
    Qr_PesquisaFPT_VL_DEBITO: TBCDField;
    Qr_PesquisaFPT_CODMHA: TIntegerField;
    Qr_PesquisaCLB_CODIGO: TIntegerField;
    Qr_PesquisaCLB_NOME: TStringField;
    Qr_PesquisaCLB_SEXO: TStringField;
    Qr_PesquisaCLB_ENDER: TStringField;
    Qr_PesquisaCLB_BAIRRO: TStringField;
    Qr_PesquisaCLB_CEP: TStringField;
    Qr_PesquisaCLB_CIDADE: TStringField;
    Qr_PesquisaCLB_UF: TStringField;
    Qr_PesquisaCLB_FONE: TStringField;
    Qr_PesquisaCLB_CELULAR: TStringField;
    Qr_PesquisaCLB_EMAIL: TStringField;
    Qr_PesquisaCLB_CODCRG: TIntegerField;
    Qr_PesquisaCLB_SITUACAO: TStringField;
    Qr_PesquisaCLB_ADMISSAO: TDateField;
    Qr_PesquisaCLB_DEMISSAO: TDateField;
    Qr_PesquisaCLB_SALARIO: TBCDField;
    Qr_PesquisaCLB_CPF: TStringField;
    Qr_PesquisaCLB_PIS: TStringField;
    Qr_PesquisaCLB_IDENTIDADE: TStringField;
    Qr_PesquisaCLB_NASCIMENTO: TDateField;
    Qr_PesquisaCLB_NOMEPAI: TStringField;
    Qr_PesquisaCLB_NOMEMAE: TStringField;
    Qr_PesquisaCLB_HABILITACAO: TStringField;
    Qr_PesquisaCLB_TIT_ELEITOR: TStringField;
    Qr_PesquisaCLB_TIT_ZONA: TStringField;
    Qr_PesquisaCLB_TIT_SECAO: TStringField;
    Qr_PesquisaCLB_CERT_MILITAR: TStringField;
    Qr_PesquisaCLB_OBSERV: TStringField;
    Qr_PesquisaCLB_CODUSU: TIntegerField;
    Qr_PesquisaCLB_AQ_COM_VDA: TBCDField;
    Qr_PesquisaCLB_CODPAI: TIntegerField;
    Qr_PesquisaCLB_AQ_COM_SRV: TBCDField;
    Qr_PesquisaCLB_COM_VDA: TStringField;
    Qr_PesquisaCLB_COM_SRV: TStringField;
    Qr_PesquisaCLB_CODMHA: TIntegerField;
    Qr_PesquisaCLB_CALC_COM_VDA: TStringField;
    Qr_PesquisaCLB_CALC_COM_SRV: TStringField;
    Fm_ListaColaborador: TFm_ListaColaboradores;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SB_InserirClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure SB_FiltrarClick(Sender: TObject);

    procedure DBG_ServicosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_FichaClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_FolhaClick(Sender: TObject);
    procedure SB_ImprimirClick(Sender: TObject);
    procedure CB_MesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Ds_PesquisaStateChange(Sender: TObject);
    procedure Qr_PesquisaAfterScroll(DataSet: TDataSet);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure DBG_ServicosTitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    It_VL_Vencimento: Currency;
    It_VL_Desconto: Currency;
    It_Vl_Comissao:Currency;
    IT_Vl_Liquido: Currency;
    It_Inserir : Boolean;
    It_folha : Boolean;    
    It_Alterar : Boolean;
    It_Excluir : Boolean;
    It_Ficha   : Boolean;
    It_Imprimir: Boolean;
    It_Visualizar : Boolean;    
  public
    { Public declarations }
    it_BaixaOK : Boolean;
    It_Vl_Pagar: Currency;
    It_Vl_Pago: Currency;
    IT_DATA : TDate;
    IT_HISTORISCO : String;
    IT_MES : Integer;
    IT_ANO : String;
    procedure Pc_Buscar;
    procedure Pc_CalculaFolha;
    procedure Pc_CalculaCommissao;
    procedure Pc_Totalizador;
    procedure Pc_LancaEventoFuturo;
    Function Fc_ValidaDados : Boolean;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;
  end;

var
  Fr_Flh_Pagto: TFr_Flh_Pagto;

implementation

uses     Un_Msg, UN_Fich_Colaborador, Un_DM, Un_Lanca_Folha, Un_Regra_Negocio, UN_Sistema, UN_RL_Flh_Pagto, reg_receipt, UN_Principal, env, RI_MovimentoFinanceiro, Un_Lanca_Caixa, Un_Lanca_Banco;
{$R *.dfm}


function  TFr_Flh_Pagto.Fc_ValidaDados : Boolean;
Var
  Lc_resul : Boolean;
Begin
  Result := True;
  if (CB_Mes.Text = '') AND (E_Ano.Text = '')  then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Favor Preencher com uma Data Válida.'+EOLN+EOLN,
                   ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
  end;
  if Fm_ListaColaborador.Dblcb_Vendedor.Text = '' then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Favor Informe o Nome do Vendedor.'+EOLN+EOLN,
                   ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
  end;
end;

procedure TFr_Flh_Pagto.Pc_Totalizador;
begin
  Lb_Vl_Vencimento.Caption := FloatToStrF(It_VL_Vencimento,ffFixed,18,2);
  Lb_Vl_Descontos.Caption := FloatToStrF(It_VL_Desconto,ffFixed,18,2);
  Lb_Vl_Comissao.Caption := FloatToStrF(It_Vl_Comissao,ffFixed,18,2);
  IT_Vl_Liquido := It_VL_Vencimento + It_Vl_Comissao - It_VL_Desconto;
  Lb_Vl_Liquido.Caption := FloatToStrF(IT_Vl_Liquido,ffFixed,18,2);
end;

procedure TFr_Flh_Pagto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Flh_Pagto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
      case Key of
      VK_F2  : if SB_Inserir.Enabled then SB_InserirClick(Sender);
      VK_F3  : if SB_Alterar.Enabled then SB_AlterarClick(Sender);
      VK_F4  : if SB_Excluir.Enabled then SB_ExcluirClick(Sender);
      VK_F8  : if SB_Filtrar.Enabled then SB_FiltrarClick(Sender);
      VK_F9  : if SB_Folha.Enabled then SB_FolhaClick(Sender);
      VK_F10  : if Sb_Ficha.Enabled then Sb_FichaClick(Sender);
      VK_F11  : if SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
      end;
    end;

end;

procedure TFr_Flh_Pagto.FormCreate(Sender: TObject);
begin
  CB_Mes.ItemIndex:=StrToInt(Copy(DateToStr(date),4,2));
  UpD_Ano.Position:=StrToInt(Copy(DateToStr(date),7,4));
  E_Ano.Text:=Copy(DateToStr(date),7,4);
  Fm_ListaColaborador.ListaColaborador;
  Ds_PEsquisaStateChange(Qr_Pesquisa);
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
  IT_DATA := Date;
  IT_HISTORISCO := '';
  IT_MES :=  StrToInt(Copy(DateToStr(Date),4,2));
  IT_ANO :=  Copy(DateToStr(Date),7,4);
end;

procedure TFr_Flh_Pagto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.Commit;
  Action:=caFree;
  Fr_Flh_Pagto:=nil;
end;

procedure TFr_Flh_Pagto.SB_InserirClick(Sender: TObject);
Var
  Form : TFr_Lanca_Folha;
begin
  Try
    Form := TFr_Lanca_Folha.create(nil);
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
    Fm_ListaColaborador.ListaColaborador;
    SB_FiltrarClick(sender);
  End;
end;
procedure TFr_Flh_Pagto.SB_AlterarClick(Sender: TObject);
Var
  Form : TFr_Lanca_Folha;
begin
  Try
    Form := TFr_Lanca_Folha.create(Self);
    Form.Codigo := Qr_Pesquisa.FieldByName('FPT_CODIGO').AsInteger;
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
    SB_FiltrarClick(sender);
  End;
end;

procedure TFr_Flh_Pagto.PC_bUSCAR;
Var
  SqlTxt:String;
  LC_Mes,Lc_Ano,Lc_Colab,Lc_Histor,LC_Valor:Boolean;
begin
  sqltxt := '';
  Screen.Cursor:=crHourGlass;
  Qr_Pesquisa.Close;
  Qr_Pesquisa.Sql.Clear;
  SqlTxt:='SELECT *   '+
          'FROM TB_FOLHAPAGTO Tb_flhpagto '+
          '   INNER JOIN TB_COLABORADOR tb_colaborador '+
          '   ON (tb_colaborador.CLB_CODIGO = Tb_flhpagto.FPT_CODCLB) '+
          'WHERE (FPT_CODIGO IS NOT NULL) ';

  if CB_Mes.Text = '' then Lc_Mes := False else Lc_Mes := True;
  if E_Ano.Text = '' then Lc_Ano := False else Lc_Ano := True;
  if Fm_ListaColaborador.Dblcb_Vendedor.Text = '' then Lc_Colab := False else Lc_Colab := True;

  if E_BuscaHistor.Text = '' then Lc_Histor := False else Lc_Histor := True;
  if E_BuscaValor.Text = '' then Lc_Valor := False else Lc_Valor := True;

  if ChBx_Periodo.Checked then
    Begin
    sqltxt := sqltxt + ' AND FPT_DATA BETWEEN :DATAINI AND :DATAFIM ';
    end
  else
    Begin
    if LC_Mes then sqltxt := sqltxt +'AND (FPT_MES =:FPT_MES) ';
    if Lc_Ano then sqltxt := sqltxt +'AND (FPT_ANO =:FPT_ANO) ';
    end;

  if Lc_Colab then sqltxt := sqltxt +'AND (FPT_CODCLB =:FPT_CODCLB) ';
  if Lc_Histor then sqltxt := sqltxt +'AND (FPT_HISTORICO LIKE :FPT_HISTORICO) ';
  if LC_Valor then sqltxt := sqltxt +'AND ((FPT_VL_CREDITO=:FPT_VALOR) OR (FPT_VL_DEBITO=:FPT_VALOR)) ';

  Qr_Pesquisa.SQL.Add(sqltxt+' ORDER BY FPT_MES,FPT_DATA,FPT_HISTORICO ');

  if ChBx_Periodo.Checked then
    Begin
    Qr_Pesquisa.ParamByName('DATAINI').AsDate :=E_Data_Ini.Date;
    Qr_Pesquisa.ParamByName('DATAFIM').AsDate:=E_Data_Fim.Date;
    end
  else
    Begin
    if LC_Mes then Qr_Pesquisa.ParamByName('FPT_MES').AsInteger:=CB_Mes.ItemIndex;
    if Lc_Ano then Qr_Pesquisa.ParamByName('FPT_ANO').AsString := E_Ano.Text;
    end;
  if Lc_Colab then Qr_Pesquisa.ParamByName('FPT_CODCLB').AsInteger := Fm_ListaColaborador.Dblcb_Vendedor.KeyValue;
  if Lc_Histor then Qr_Pesquisa.ParamByName('FPT_HISTORICO').AsString:='%'+E_BuscaHistor.Text+'%';
  if LC_Valor then Qr_Pesquisa.ParamByName('FPT_VALOR').AsCurrency := StrToFloatDef(E_BuscaValor.Text,0);
  Qr_Pesquisa.Open;
  Screen.Cursor:=crDefault;

end;

procedure TFr_Flh_Pagto.ScrollBar1Scroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  ShowMessage(IntToStr(ScrollPos));
end;

procedure TFr_Flh_Pagto.SB_FiltrarClick(Sender: TObject);
begin
  Pc_Buscar;
  Pc_CalculaFolha;
  Pc_CalculaCommissao;
  Pc_Totalizador;
  Ds_PesquisaStateChange(Qr_Pesquisa);
end;

procedure TFr_Flh_Pagto.Pc_CalculaFolha;
begin
  It_VL_Vencimento := 0;
  It_VL_Desconto := 0;
  Qr_Pesquisa.First;
  while not Qr_Pesquisa.Eof do
    begin
    It_VL_Vencimento := It_VL_Vencimento + Qr_Pesquisa.FieldByName('FPT_VL_CREDITO').AsCurrency;
    It_VL_Desconto := It_VL_Desconto + Qr_Pesquisa.FieldByName('FPT_VL_DEBITO').AsCurrency;
    Qr_Pesquisa.Next;
    end;
end;

procedure TFr_Flh_Pagto.Pc_CalculaCommissao;
begin
  IF Fm_ListaColaborador.Dblcb_Vendedor.Text = '' then exit;
  Screen.Cursor:=crHourGlass;
  It_Vl_Comissao := 0;
  Qr_Comissao.Active := False;
  Qr_Comissao.ParamByName('COM_CODVDO').AsInteger := Fm_ListaColaborador.Dblcb_Vendedor.KeyValue;
  Qr_Comissao.Active := True;
  It_Vl_Comissao := Qr_Comissao.FieldByName('COM_VL_TOTAL').AsCurrency;
  Screen.Cursor:=crDefault;
end;




procedure TFr_Flh_Pagto.Pc_LancaEventoFuturo;
Var
  Lc_Dia,Lc_Mes,Lc_Ano:String;
  lc_Valor : Real;
  Form : TFr_Lanca_Folha;
  Lc_Folha : TControllerFolhaPagto;
Begin
  if (It_Vl_Pago = It_Vl_Pagar ) then exit;
  lc_Valor := It_Vl_Pago - It_Vl_Pagar;
  if CB_Mes.ItemIndex =12 then
  Begin
    Lc_Dia:='01';
    Lc_Mes:='01';
    Lc_Ano:=IntToStr((StrToInt((Copy(DateToStr(date),7,4)))+1));
  end
  else
  Begin
    Lc_Dia:='01';
    Lc_Mes:=IntToStr((StrToInt((Copy(DateToStr(date),4,2)))+1));
    Lc_Ano:=Copy(DateToStr(date),7,4);
  end;
  Lc_Folha := TControllerFolhaPagto.create(self);
  Try
    with Lc_Folha do
    Begin
      Registro.Codigo          := 0;
      Registro.Colaborador     := Fm_ListaColaborador.Dblcb_Vendedor.KeyValue;
      Registro.Data            := StrToDate(Lc_Dia+'/'+Lc_Mes+'/'+Lc_Ano);
      Registro.Mes             := StrToInt(Lc_Mes);
      Registro.Ano             := StrToIntdef(Lc_Ano,0);
      Registro.Historico       := 'DIFERENÇA MÊS ANTERIOR';
      if lc_Valor < 0 then
        Registro.Credito       :=  lc_Valor * -1
      else
        Registro.Credito       :=  0;
      if lc_Valor > 0 then
        Registro.Debito        := lc_Valor
      else
        Registro.Debito        := 0;
      Registro.Estabelecimento := Gb_CodMha;
    End;
    Lc_Folha.insert;
  Finally
    FreeAndNil( Lc_Folha );
  End;
End;



procedure TFr_Flh_Pagto.DBG_ServicosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    if SB_Excluir.Enabled then SB_ExcluirClick(Sender);
    end;
  end;
end;

procedure TFr_Flh_Pagto.Sb_FichaClick(Sender: TObject);
begin
  if not Fc_ValidaDados then exit;
  if not Assigned(Fr_FichaColab)then (Application.CreateForm(TFr_FichaColab, Fr_FichaColab));
  Fr_FichaColab.It_Cd_Colaborador := Fm_ListaColaborador.Dblcb_Vendedor.KeyValue;
  Fr_FichaColab.It_Nm_Colaborador := Fm_ListaColaborador.Dblcb_Vendedor.Text;
  Fr_FichaColab.It_Ano := StrToIntDef(E_Ano.Text,0);
  Fr_FichaColab.ShowModal;
end;

procedure TFr_Flh_Pagto.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Flh_Pagto.SB_ExcluirClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o item '+ Qr_Pesquisa.FieldByName('FPT_HISTORICO').AsString +' do Banco.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                     [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
    exit;
  if not DM.ib_Transacao.InTransaction Then DM.ib_Transacao.StartTransaction;
    try
    Qr_Acao.Close;
    Qr_Acao.Sql.Clear;
    Qr_Acao.SQL.Add('DELETE FROM TB_FOLHAPAGTO  WHERE (FPT_CODIGO =:FPT_CODIGO) ');
    Qr_Acao.ParamByName('FPT_CODIGO').AsInteger := Qr_Pesquisa.FieldByName('FPT_CODIGO').AsInteger;
    Qr_Acao.Active := True;
    IF DM.IB_Transacao.InTransaction THEN DM.ib_Transacao.CommitRetaining;
    SB_FiltrarClick(sender);
    except
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                     'Entre em contato com o suporte técnico.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      DM.IB_Transacao.Rollback;
    end;

end;

procedure TFr_Flh_Pagto.SB_FolhaClick(Sender: TObject);
Var
  Lc_Escolha, Lc_I : Integer;
  Lc_StrPAgto : String;
  LfFormCaixa : TFr_Lanca_Caixa;
  LfFormBanco : TFr_Lanca_Banco;
begin
  if Fc_ValidaDados then
  Begin
    Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                  'Baixar as Folha do Mês Selecionado.'+EOLN+EOLN+
                                  'Confirmar a Baixa ?',
                                  ['Caixa','Banco','Cancelar'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
    try
      It_Vl_Pagar := StrToFloatDef(Lb_Vl_Liquido.caption,0);
      case Lc_Escolha of
        0:Begin
            if Fc_VErificaCaixaAberto(True) then
            Begin
              Try
                LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
                LfFormCaixa.Codigo           := 0;
                LfFormCaixa.Quitacao         := 0;
                LfFormCaixa.Titulo          := 'Lançamentos no caixa da Folha de Pagamento';
                LfFormCaixa.Operacao         := 'I';
                LfFormCaixa.PlanoResultado   := 0;
                LfFormCaixa.PlanoCentroCusto := 0;
                LfFormCaixa.Historico        := 'Pagto Vencimentos : ' + DateToStr( E_Data_Ini.date)+ ' - '+DateToStr( E_Data_Fim.date);
                LfFormCaixa.ValorCredito     := 0;
                LfFormCaixa.ValorDebito      := It_Vl_Pagar;
                LfFormCaixa.FormaPagto       := 0;
                LfFormCaixa.Mensagem         := True;
                LfFormCaixa.LiberaCampo      := False;
                LfFormCaixa.AutoFill;
                LfFormCaixa.ShowModal;
                It_Vl_Pago := StrToFloatDef(LfFormCaixa.E_Credito.Text,0);
                if LfFormCaixa.Resultado then Pc_LancaEventoFuturo;
              Finally
                FreeAndNil(LfFormCaixa);
              End;
            End;
          end;
        1:Begin
            Try
              LfFormBanco := TFr_Lanca_Banco.Create(nil);
              LfFormBanco.Codigo           := 0;
              LfFormBanco.Quitacao         := 0;
              LfFormBanco.Caption          := 'Lançamentos no caixa da Folha de Pagamento';
              LfFormBanco.Data             := Date;
              LfFormBanco.ContaCorrente    := 0;
              LfFormBanco.Operacao         := 'I';
              LfFormBanco.PlanoResultado   := 0;
              LfFormBanco.PlanoCentroCusto := 0;
              LfFormBanco.Historico        := 'Pagto Vencimentos : '+ DateToStr( E_Data_Ini.date)+ ' - '+DateToStr( E_Data_Fim.date);
              LfFormBanco.HistoricoBanco   := 0;
              LfFormBanco.ValorCredito     := 0;
              LfFormBanco.ValorDebito      := It_Vl_Pagar;
              LfFormBanco.FormaPagto       := 0;
              LfFormBanco.Mensagem         := True;
              LfFormBanco.LiberaCampo      := False;
              LfFormBanco.AutoFill;
              LfFormBanco.ShowModal;
              It_Vl_Pago := StrToFloatDef(LfFormBanco.E_Credito.Text,0);
              if LfFormBanco.Resultado then Pc_LancaEventoFuturo;
            Finally
              FreeAndNil(LfFormBanco);
            End;
          end
        else
          Exit;
      end;

    except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a Baixa dos Lançamentos.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                   ['OK'],[bEscape],mpErro);
    end;
  End;
end;

procedure TFr_Flh_Pagto.SB_ImprimirClick(Sender: TObject);
Var
  Lc_Escolha, Lc_I : Integer;
  Form : TRegReceipt;
begin
  Lc_Escolha:=(MensagemPadrao(TITULO_INFORMACAO,
                          'Escolha o Tipo de Impressão.',
                          ['RECIBO','HOLERITE','CANCELA'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
  case Lc_Escolha of
    0:Begin
        if Qr_Pesquisa.RecordCount > 0 then
        Begin
          TRy
            Pc_AtivaEstabelecimento;
            Form := TRegReceipt.create(nil);
            if Qr_Pesquisa.FieldByName('FPT_VL_DEBITO').AsCurrency > 0 then
              Form.Recibo.Registro.Valor := Qr_Pesquisa.FieldByName('FPT_VL_DEBITO').AsCurrency
            else
              Form.Recibo.Registro.Valor := Qr_Pesquisa.FieldByName('FPT_VL_CREDITO').AsCurrency;
            Form.Recibo.Registro.Emitente := Qr_Pesquisa.FieldByName('CLB_NOME').AsString;
            Form.Recibo.Registro.sacado := DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString;
            Form.Recibo.Registro.Referencia := Qr_Pesquisa.FieldByName('FPT_HISTORICO').AsString;
            Form.Recibo.Registro.Data := Qr_Pesquisa.FieldByName('FPT_DATA').AsDateTime;
            Form.autofill := True;
            Form.ShowModal;
          Finally
            FreeAndNil(Form)
          End;
        End;
      End;
    1:Begin
      if not Fc_ValidaDados then exit;
      if not Assigned(RL_Flh_Pagto) then Application.CreateForm(TRL_Flh_PAgto,RL_Flh_PAgto);
      if Trim(Fm_ListaColaborador.Dblcb_Vendedor.Text) <> '' then
        RL_Flh_PAgto.It_Codigo := Fm_ListaColaborador.Dblcb_Vendedor.KeyValue;
      RL_Flh_PAgto.It_Mes := CB_Mes.ItemIndex;
      RL_Flh_PAgto.It_Ano := StrToInt(E_Ano.Text);
      RL_Flh_PAgto.Qrpt.Preview;
      End;
    end;

end;

procedure TFr_Flh_Pagto.CB_MesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    CB_Mes.ItemIndex := -1;
    end;
  end;

end;

procedure TFr_Flh_Pagto.Ds_PesquisaStateChange(Sender: TObject);
begin
  SB_Inserir.Enabled := It_Inserir;
  SB_Alterar.Enabled := It_Alterar and (Qr_Pesquisa.RecordCount > 0);
  SB_Excluir.Enabled := It_Excluir and (Qr_Pesquisa.RecordCount > 0);
  SB_Imprimir.Enabled := It_Imprimir and (Qr_Pesquisa.RecordCount > 0);
  Sb_Ficha.Enabled := It_Ficha and (Qr_Pesquisa.RecordCount > 0);
  SB_Folha.Enabled := It_folha and (Qr_Pesquisa.RecordCount > 0);  
end;

procedure TFr_Flh_Pagto.Qr_PesquisaAfterScroll(DataSet: TDataSet);
begin
  Lb_Colaborador.Caption := Qr_Pesquisa.FieldByName('CLB_NOME').AsString;
end;

procedure TFr_Flh_Pagto.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Flh_Pagto.DBG_ServicosTitleClick(Column: TColumn);
begin
 Pc_Pintar_Grid_Ordenar(DBG_Servicos, Column);
end;

procedure TFr_Flh_Pagto.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Inserir := True;
    It_Alterar := True;
    It_Excluir := True;
    It_Ficha   := True;
    It_Visualizar := True;
    It_Imprimir:= True;
    It_folha := True;
    end
  else
    begin
    It_Inserir    := Fc_HabilitaPermissao(Pc_Menu,'INSERIR','S');
    It_Alterar    := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
    It_Excluir    := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
    It_Ficha      := Fc_HabilitaPermissao(Pc_Menu,'FICHA FINANCEIRA','S');
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    It_Imprimir  := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    It_folha  := Fc_HabilitaPermissao(Pc_Menu,'FOLHA','S');    
    end;
  SB_Inserir.Enabled := It_Inserir;
end;
procedure TFr_Flh_Pagto.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Inserir.Glyph.Assign(Fc_CarregaImagemBotao('INSERIR'));
    SB_Alterar.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    SB_Excluir.Glyph.Assign(Fc_CarregaImagemBotao('EXCLUIR'));
    SB_Imprimir.Glyph.Assign(Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Flh_Pagto.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_PermissaoBotao('Folha de Pagamento');
end;

end.
