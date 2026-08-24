Unit Un_Receber_Descontada;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, StdCtrls, Mask, Grids, DBGrids, ExtCtrls, DB, Buttons, ComCtrls, STStoredProc, STQuery, Printers, jpeg, Menus, QEdit_Setes, IBUpdateSQL, System.Math, ACBrBase, ACBrCMC7, Un_Fm_FormaPagto, ControllerFinanceiro, ControllerMovimentoFinanceiro;

type
  TFr_Receber_Descontada = class(TForm)
    Pnl_Total: TPanel;
    Panel1: TPanel;
    SB_Sair_0: TSpeedButton;
    Sb_Descontar: TSpeedButton;
    Qr_Parcelas: TSTQuery;
    Ds_Parcelas: TDataSource;
    Qr_Acao: TSTQuery;
    Qr_Empresa: TSTQuery;
    pnl_Busca: TPanel;
    GroupBox3: TGroupBox;
    Label12: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    L_CodigoCliente: TLabel;
    E_BuscaPedido: TEdit_Setes;
    E_Busca_Empresa: TEdit;
    E_BuscaNota: TEdit;
    E_BuscaFinanceiro: TEdit;
    Rg_Situacao: TRadioGroup;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    Rg_Data: TRadioGroup;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    E_Busca_Cd_Empresa: TEdit;
    StrGrd_Parcela: TStringGrid;
    lc_fornecedor: TLabel;
    SB_fornecedor: TSpeedButton;
    DBLCB_Fornecedor: TDBLookupComboBox;
    chbx_NomeFornecedor: TCheckBox;
    chbx_fantasiaFornecedor: TCheckBox;
    E_Cd_Fornecedor: TDBEdit;
    Label2: TLabel;
    E_Data: TDateTimePicker;
    Label14: TLabel;
    Label6: TLabel;
    Label15: TLabel;
    E_VL_Original: TEdit_Setes;
    E_VL_Operacao: TEdit_Setes;
    E_VL_Liquido: TEdit_Setes;
    Qr_Fornecedor: TSTQuery;
    Ds_Fornecedor: TDataSource;
    Label1: TLabel;
    E_Tx_Operacao: TEdit_Setes;
    Pop_Menu: TPopupMenu;
    Sb_Pesq_Empresa: TSpeedButton;
    Sb_Pesq_Cliente: TSpeedButton;
    Fm_TipoCobranca: TFm_FormaPagto;
    Rg_Baixa: TRadioGroup;
    pnl_botao: TPanel;
    Sb_Duplicata: TSpeedButton;
    SB_Buscar: TSpeedButton;
    SB_Add_Tudo: TSpeedButton;
    SB_Adicionar: TSpeedButton;
    SB_Retirar: TSpeedButton;
    SB_Retirar_Tudo: TSpeedButton;
    Sb_Cancelar: TSpeedButton;
    Sb_Baixa: TSpeedButton;
    StrGrd_Duplicata: TStringGrid;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure SB_Retirar_TudoClick(Sender: TObject);
    procedure SB_RetirarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_BuscarClick(Sender: TObject);
    procedure StrGrd_DuplicataDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StrGrd_ParcelaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Sb_DuplicataClick(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure StrGrd_ParcelaMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure SB_AdicionarClick(Sender: TObject);
    procedure SB_Add_TudoClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure Sb_EmpresaClick(Sender: TObject);
    procedure E_Busca_Cd_EmpresaExit(Sender: TObject);

    procedure Rg_DataClick(Sender: TObject);
    procedure Ds_ParcelasDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure StrGrd_DuplicataDblClick(Sender: TObject);
    procedure Sb_DescontarClick(Sender: TObject);
    procedure E_VL_OperacaoExit(Sender: TObject);
    procedure chbx_NomeFornecedorClick(Sender: TObject);
    procedure chbx_fantasiaFornecedorClick(Sender: TObject);
    procedure SB_fornecedorClick(Sender: TObject);
    procedure Qr_FornecedorAfterOpen(DataSet: TDataSet);
    procedure E_Cd_FornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure E_Cd_FornecedorExit(Sender: TObject);
    procedure DBLCB_FornecedorExit(Sender: TObject);
    procedure Sb_Pesq_EmpresaClick(Sender: TObject);
    procedure Sb_Pesq_ClienteClick(Sender: TObject);
    procedure Sb_BaixaClick(Sender: TObject);
    procedure Rg_BaixaClick(Sender: TObject);
    procedure E_Tx_OperacaoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Sb_CancelarClick(Sender: TObject);
  private
    { Private declarations }
    It_Inserir: Boolean;
    It_Alterar: Boolean;
    It_Excluir: Boolean;
    It_Visualizar: Boolean;
    It_Duplicata: Boolean;
    It_Recibo: Boolean;
    It_Cd_Quitacao   : Integer;
    It_Sql_Txt : String;
    Financeiro:TControllerFinanceiro;
    procedure AtivaBotao;
    function ValidaCancelamento:Boolean;
    procedure BaixaDescontadaPago;
    procedure BaixaDescontadaDevolucao;
  public
    { Public declarations }
    //Varival do comando Sql;



    //Controle da Baixa no Geral
    //It_Vl_Baixa       : Real;
    It_Vl_Pagto: Currency;
    //It_Vl_Credito       : Real;
    It_Indice_Positivo : Integer;
    It_Indice_Negativo : Integer;
    It_PArcela : Integer;
    It_Cta_Bancaria : Integer;


    // Manipulação dos Duplicatas
    It_Registro : Integer; // Registro da Parcela que será incluida

    it_BaixaOK : Boolean;


    //Processo de Interface
    procedure Pc_IniciaVariaveis;
    procedure Pc_FormataTela;
    procedure Pc_ImagemBotao;

    //procedures para Validar a Baixa
    function Fc_ValidaBaixa:boolean;


    //procedures para Executar a Baixa
    procedure Pc_Processo_Baixa;


    procedure Pc_Mostrar_Baixados;
    //Processo com o movimento Financeiro
    procedure Pc_Processo_Movim_Financeiro;
    Procedure Pc_Lancar_Caixa;
    Procedure Pc_Lancar_Banco;
    procedure Pc_Ativar_Tabelas;
    procedure CalculoByTaxa;
    procedure CalculoByValor;
    function MontaHistorico:String;
    procedure Pc_SomaDuplicatas;
    procedure Pc_Buscar_Parcela;
    procedure Pc_Criterio_Sql;

    procedure Pc_Preencher_Parcelas;


    procedure Pc_Adicionar;
    procedure Pc_Adicionar_Tudo;

    procedure Pc_Retirar;
    procedure Pc_Retirar_Tudo;

    Procedure Pc_Definir_Grade_Parcela;
    Procedure Pc_Definir_Grade_Duplicata;
    procedure Pc_LimpaCampos;

    procedure Pc_RegistraDescontoDuplicatas;
    procedure Pc_AlteraStatusDuplicatas(Pc_Cd_Financeiros,Pc_CodigoQuitacao:Integer;Pc_Situacao:String);
end;

var
  Fr_Receber_Descontada: TFr_Receber_Descontada;

implementation

uses     Un_DM, UN_MSG, UN_Fin_Baixado, Un_Lanca_Caixa, Un_Lanca_Banco, UN_Sistema, UN_RL_Duplicata, Un_MinhaEmpresa, Un_Negociar, UN_Lanca_Pagto, Un_Lanca_PlanoContas, Un_Fin_Edita, TypInfo, Un_Nota_Fiscal, Un_Fc_Comissao, Un_Fc_Sored_Procedures, un_Obs_nfe, Un_Liberacao, Un_Funcoes, Un_Regra_Negocio, UN_Principal, env, RN_PlanoContas, RN_Financeiro, RN_FormaPagto, Un_RL_ControleCartao, RN_Cliente, Un_Fornecedor, RN_Fornecedor, RN_Empresa, RI_MovimentoFinanceiro, Un_Baixa_Dup_Desc, tas_receber_descontada_devolucao;
{$R *.dfm}


procedure TFr_Receber_Descontada.Pc_FormataTela;
Begin
end;

procedure TFr_Receber_Descontada.Pc_Mostrar_Baixados;
Var
  LcForm : TFr_Fin_Baixado;
Begin
  LcForm := TFr_Fin_Baixado.create(nil);
  try
    LcForm.CodigoFinanceiro := StrToIntDef(StrGrd_Parcela.Cells[1,StrGrd_Parcela.row],0);
    LcForm.TipoOperacao := 'ContasReceber';
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
End;

procedure TFr_Receber_Descontada.Pc_Criterio_Sql;
var
  Lc_Pedido, Lc_NotaFiscal,Lc_Finaceiro, Lc_Cd_Cliente, Lc_Cliente, Lc_FormaPagto : boolean;
  Lc_Str_Excecao : String;
  Lc_Bln_Excecao : Boolean;
  Lc_I,Lc_j:Integer;
Begin
  if E_BuscaPedido.Text = ''         then Lc_Pedido       := False else Lc_Pedido      := True;
  if E_BuscaNota.Text = ''           then Lc_NotaFiscal   := False else Lc_NotaFiscal  := True;
  if E_BuscaFinanceiro.Text = ''     then Lc_Finaceiro    := False else Lc_Finaceiro   := True;
  if E_Busca_Empresa.Text = ''        then Lc_Cliente      := False else Lc_Cliente     := True;
  if Fm_TipoCobranca.DBLCB_FormaPagto.Text = '' then Lc_FormaPagto   := False else Lc_FormaPagto  := True;
  if E_Busca_Cd_Empresa.Text = ''          then  Lc_Cd_Cliente  := False else Lc_Cd_Cliente  := True;


  if ChBx_Periodo.Checked then
  Begin
    if Rg_Data.ItemIndex = 0 then
     begin
      It_Sql_Txt := It_Sql_Txt + 'AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ';
    end
    else
    begin
      It_Sql_Txt := It_Sql_Txt + 'AND (FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM) ';
    end;
  end;

  if Lc_Pedido     then It_Sql_Txt := It_Sql_Txt + 'AND (PED_NUMERO = :PED_NUMERO) ';
  if Lc_NotaFiscal then It_Sql_Txt := It_Sql_Txt + 'AND (NFL_NUMERO LIKE :NFL_NUMERO) ';
  if Lc_Finaceiro  then It_Sql_Txt := It_Sql_Txt + 'AND (FIN_NUMERO LIKE :FIN_NUMERO) ';
  if Lc_Cd_Cliente then It_Sql_Txt := It_Sql_Txt + 'AND (FIN_CODEMP =:FIN_CODEMP) ';
  if Lc_Cliente    then It_Sql_Txt := It_Sql_Txt + 'AND ((EMP_FANTASIA LIKE :EMP_FANTASIA) OR (EMP_NOME LIKE :EMP_FANTASIA)) ';
  if Lc_FormaPagto then It_Sql_Txt := It_Sql_Txt + 'AND (FIN_CODFPG =:FIN_CODFPG) ';
  if Rg_Situacao.ItemIndex = 0 then  It_Sql_Txt := It_Sql_Txt + 'AND ((FIN_SITUACAO =''N'') OR (FIN_SITUACAO =''D'') )';
  if Rg_Situacao.ItemIndex = 1 then  It_Sql_Txt := It_Sql_Txt + 'AND (FIN_SITUACAO =''T'') ';
  if Rg_Baixa.ItemIndex = 0 then
    It_Sql_Txt := It_Sql_Txt + 'AND (FIN_BAIXA =''N'') '
  else
    It_Sql_Txt := It_Sql_Txt + 'AND (FIN_BAIXA =''S'') ';

  Lc_Str_Excecao := 'AND (FIN_CODIGO NOT IN (';

  For Lc_I := 1 to StrGrd_Duplicata.RowCount -1 do
  Begin
    if StrGrd_Duplicata.Cells[1,Lc_I] <> '' then
    Begin
      Lc_Bln_Excecao := True;
      if Lc_I = 1 then
        Lc_Str_Excecao := Lc_Str_Excecao + StrGrd_Duplicata.Cells[1,lc_i]
      else
        Lc_Str_Excecao := Lc_Str_Excecao + ','+StrGrd_Duplicata.Cells[1,lc_i];
    end;
  end;
  if Lc_Bln_Excecao then It_Sql_Txt := It_Sql_Txt + Lc_Str_Excecao +')) ';

  if Rg_Data.ItemIndex = 0 then
    Qr_Parcelas.SQL.Add(It_Sql_Txt+ 'ORDER BY NFL_DT_EMISSAO, EMP_NOME, PED_NUMERO, FIN_NUMERO ')
  else
    Qr_Parcelas.SQL.Add(It_Sql_Txt+ 'ORDER BY FIN_DT_VENCIMENTO, EMP_NOME, PED_NUMERO, FIN_NUMERO ');

  if ChBx_Periodo.Checked then
    Begin
    Qr_Parcelas.ParamByName('DATAINI').AsDate      := E_Data_Ini.date;
    Qr_Parcelas.ParamByName('DATAFIM').Asdate      := E_Data_Fim.Date;
    end;
  if Lc_Pedido     then Qr_Parcelas.ParamByName('PED_NUMERO').AsString   := E_BuscaPedido.Text;
  if Lc_NotaFiscal then Qr_Parcelas.ParamByName('NFL_NUMERO').AsString   := '%'+ E_BuscaNota.Text+'%';
  if Lc_Finaceiro  then Qr_Parcelas.ParamByName('FIN_NUMERO').AsString   := '%'+ E_BuscaFinanceiro.Text+'%';
  if Lc_Cliente    then Qr_Parcelas.ParamByName('EMP_FANTASIA').AsString := '%'+ E_Busca_Empresa.Text +'%';
  if Lc_FormaPagto then Qr_Parcelas.ParamByName('FIN_CODFPG').AsInteger  := Fm_TipoCobranca.DBLCB_FormaPagto.KeyValue;
end;


procedure TFr_Receber_Descontada.Pc_Buscar_Parcela;
begin
  It_Sql_Txt := '';
  Screen.Cursor:=crHourGlass;
  Qr_Parcelas.Close;
  Qr_Parcelas.Sql.Clear;

  It_Sql_Txt :=' SELECT DISTINCT '+
           '   FIN_CODIGO, '+
           '   NFL_NUMERO, '+
           '   PED_NUMERO, '+
           '   FIN_NUMERO, '+
           '   FIN_DT_VENCIMENTO, '+
           '   FIN_NR_PARCELA, '+
           '   FIN_CODEMP, '+
           '   EMP_FANTASIA, '+
           '   EMP_NOME, '+
           '   FIN_VL_PARCELA, '+
           '   FIN_BAIXA, '+
           '   FIN_SITUACAO, '+
           '   FIN_VL_PAGO, '+
           '   FIN_CODQTC, '+
           '   FIN_CODFPG, '+
           '   PED_CODIGO, '+
           '   NFL_CODIGO, '+
           '   FIN_TIPO, '+
           '   FIN_DT_PAGTO, '+
           '   FIN_OPERACAO, '+
           '   FIN_ETAPA, '+
           '   FIN_CODMHA, '+
           '   FIN_CODCHQ, '+
           '   PLC_CODIGO, '+
           '   PLC_DESCRICAO '+
           ' FROM TB_FINANCEIRO tb_financeiro '+
           '   INNER JOIN TB_NOTA_FISCAL tb_nota_Fiscal '+
           '   ON (tb_nota_Fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL)  '+
           '   LEFT OUTER JOIN TB_PEDIDO tb_pedido '+
           '   ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED) '+
           '   INNER JOIN TB_EMPRESA tb_empresa '+
           '   ON (tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP) '+
           '   LEFT OUTER JOIN TB_PLANOCONTAS '+
           '   ON (PLC_CODIGO = FIN_PLC_DEBITO) '+
           ' WHERE  '+
           '  ((FIN_TIPO = ''RA'') OR '+
           '  (FIN_TIPO = ''RM'')) AND  '+
           '  (FIN_CODMHA=:FIN_CODMHA) ';

  Pc_Criterio_Sql;

  //Passa o paramentro do Codigo da minha Empresa
  Qr_Parcelas.ParamByName('FIN_CODMHA').AsInteger := Gb_CodMha;

  Qr_Parcelas.Open;
  Qr_Parcelas.FetchAll;
end;


procedure TFr_Receber_Descontada.Pc_Preencher_Parcelas;
Var
  Lc_I,Lc_J : Integer;
  Lc_registro : Integer;
  Lc_Valor : Real;
  Lc_Credito : real;
Begin
  Qr_Parcelas.First;
  For Lc_I :=1 to StrGrd_Parcela.RowCount - 1 do
    For Lc_J := 1 to 18 do
      StrGrd_Parcela.Cells[Lc_J, Lc_I] := '';
  StrGrd_Parcela.RowCount := 2;
  Lc_registro := 0;
  while not Qr_Parcelas.Eof do
    Begin
    Lc_registro := Lc_registro + 1;
    StrGrd_Parcela.RowCount := Lc_registro + 1;
    StrGrd_Parcela.Cells[1,Lc_registro] := Qr_Parcelas.FieldByName('FIN_CODIGO').AsString;
    StrGrd_Parcela.Cells[2,Lc_registro] := Qr_Parcelas.FieldByName('PED_NUMERO').AsString;
    StrGrd_Parcela.Cells[3,Lc_registro] := Qr_Parcelas.FieldByName('NFL_NUMERO').AsString;
    StrGrd_Parcela.Cells[4,Lc_registro] := Qr_Parcelas.FieldByName('FIN_NUMERO').AsString;
    if Rg_Data.ItemIndex = 0 then
      StrGrd_Parcela.Cells[5,Lc_registro] := Qr_Parcelas.FieldByName('FIN_DT_VENCIMENTO').AsString
    else
      StrGrd_Parcela.Cells[5,Lc_registro] := Qr_Parcelas.FieldByName('FIN_DT_PAGTO').AsString;
    if ChBx_Fantasia.Checked then
      StrGrd_Parcela.Cells[6,Lc_registro] := Qr_Parcelas.FieldByName('EMP_FANTASIA').AsString
    else
      StrGrd_Parcela.Cells[6,Lc_registro] := Qr_Parcelas.FieldByName('EMP_NOME').AsString;

    if Rg_Data.ItemIndex = 0 then
      StrGrd_Parcela.Cells[7,Lc_registro]   := FloatToStrF(Qr_Parcelas.FieldByName('FIN_VL_PARCELA').AsCurrency, ffFixed, 10, 2)
     else
      StrGrd_Parcela.Cells[7,Lc_registro]   := FloatToStrF(Qr_Parcelas.FieldByName('FIN_VL_PAGO').AsCurrency, ffFixed, 10, 2);

    StrGrd_Parcela.Cells[8,Lc_registro]   := Qr_Parcelas.FieldByName('FIN_BAIXA').AsString;
    StrGrd_Parcela.Cells[9,Lc_registro]   := Qr_Parcelas.FieldByName('FIN_SITUACAO').AsString;
    StrGrd_Parcela.Cells[10,Lc_registro]  := Qr_Parcelas.FieldByName('FIN_CODQTC').AsString;
    StrGrd_Parcela.Cells[11,Lc_registro]  := Qr_Parcelas.FieldByName('FIN_CODFPG').AsString;
    StrGrd_Parcela.Cells[12,Lc_registro]  := Qr_Parcelas.FieldByName('FIN_CODEMP').AsString;
    StrGrd_Parcela.Cells[13,Lc_registro]  := Qr_Parcelas.FieldByName('PED_CODIGO').AsString;
    StrGrd_Parcela.Cells[14,Lc_registro]  := Qr_Parcelas.FieldByName('NFL_CODIGO').AsString;
    StrGrd_Parcela.Cells[15,Lc_registro]  := Qr_Parcelas.FieldByName('FIN_ETAPA').AsString;
    StrGrd_Parcela.Cells[16,Lc_registro]  := Qr_Parcelas.FieldByName('FIN_TIPO').AsString;
    StrGrd_Parcela.Cells[17,Lc_registro]  := '';//Qr_Parcelas.FieldByName('NFL_OBS').AsString;
    StrGrd_Parcela.Cells[18,Lc_registro]  := Qr_Parcelas.FieldByName('FIN_OPERACAO').AsString;
    if Rg_Data.ItemIndex = 0 then
      Begin
      if (Qr_Parcelas.FieldByName('FIN_OPERACAO').AsString = 'C') then
        Lc_Valor := Lc_Valor + Qr_Parcelas.FieldByName('FIN_VL_PARCELA').AsCurrency
      else
        Lc_Credito := Lc_Credito + Qr_Parcelas.FieldByName('FIN_VL_PARCELA').AsCurrency;
      end
    else
      Begin
      if (Qr_Parcelas.FieldByName('FIN_OPERACAO').AsString = 'C') then
        Lc_Valor := Lc_Valor + Qr_Parcelas.FieldByName('FIN_VL_PAGO').AsCurrency
      else
        Lc_Credito := Lc_Credito + Qr_Parcelas.FieldByName('FIN_VL_PAGO').AsCurrency;
      end;

    StrGrd_Parcela.Cells[20,Lc_registro] := Qr_Parcelas.FieldByName('FIN_CODCHQ').AsString;
    StrGrd_Parcela.Cells[21,Lc_registro] := Qr_Parcelas.FieldByName('FIN_NR_PARCELA').AsString;
    StrGrd_Parcela.Cells[22,Lc_registro] := Qr_Parcelas.FieldByName('PLC_CODIGO').AsString;
    StrGrd_Parcela.Cells[23,Lc_registro] := Qr_Parcelas.FieldByName('PLC_DESCRICAO').AsString;
    Qr_Parcelas.Next;
    end;
  Qr_Parcelas.First;
  Screen.Cursor:=crDefault;
end;


procedure TFr_Receber_Descontada.CalculoByTaxa;
Var
  Lc_VL_Original : Real;
  Lc_Tx_Operacao : Real;
  Lc_VL_Operacao : Real;
  Lc_Vl_Liquido : Real;
Begin
  Lc_VL_Original := StrToFloatDef(E_VL_Original.Text,0);

  Lc_Tx_Operacao := StrtoFloatDef(E_Tx_Operacao.Text,0);
  E_Tx_Operacao.Text := FloatToStrF(Lc_Tx_Operacao,ffFixed,10,2);

  Lc_Vl_Operacao := ( (Lc_VL_Original *Lc_Tx_Operacao)/100 );
  E_VL_Operacao.Text := FloatToStrF(Lc_Vl_Operacao, ffFixed, 10, 2);

  if Lc_VL_Original = 0 then Lc_VL_Original := 1;
  Lc_Vl_Liquido := Lc_VL_Original - Lc_Vl_Operacao;
  E_VL_Liquido.Text := FloatToStrF(Lc_Vl_Liquido,ffFixed,10,2);

End;


procedure TFr_Receber_Descontada.CalculoByValor;
Var
  Lc_I : Integer;
  Lc_VL_Original : Real;
  Lc_Tx_Operacao : Real;
  Lc_VL_Operacao : Real;
  Lc_Vl_Liquido : Real;
Begin
  Lc_VL_Original := StrToFloatDef(E_VL_Original.Text,0);

  Lc_VL_Operacao := StrtoFloatDef(E_VL_Operacao.Text,0);
  E_VL_Operacao.Text := FloatToStrF(Lc_VL_Operacao,ffFixed,10,2);

  Lc_Tx_Operacao := (Lc_Vl_Operacao / Lc_VL_Original) * 100;
  Lc_Tx_Operacao := RoundTo( Lc_Tx_Operacao,-2);
  E_Tx_Operacao.Text := FloatToStrF(Lc_Tx_Operacao, ffFixed, 10, 2);

  if Lc_VL_Original = 0 then Lc_VL_Original := 1;
  Lc_Vl_Liquido := Lc_VL_Original - Lc_Vl_Operacao;
  E_VL_Liquido.Text := FloatToStrF(Lc_Vl_Liquido,ffFixed,10,2);
end;

procedure TFr_Receber_Descontada.BaixaDescontadaDevolucao;
Var
  Lc_Form : TTasReceberDescontadaDevolucao;
begin
  Try
    Lc_Form := TTasReceberDescontadaDevolucao.create(nil);
    Lc_Form.NotaFiscal.Financeiro.Registro.Codigo := StrToIntDef(StrGrd_Parcela.Cells[1,StrGrd_Parcela.Row],0);
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
    Pc_Buscar_Parcela;
    Pc_Preencher_Parcelas;
  End;
end;

procedure TFr_Receber_Descontada.BaixaDescontadaPago;
begin
  Financeiro.Registro.Codigo := StrToIntDef(StrGrd_Parcela.Cells[1,StrGrd_Parcela.Row],0);
  Financeiro.getById;
  Financeiro.Registro.DataBaixa := Date;
  Financeiro.Registro.DataPagamento := Financeiro.Registro.DataVencimento;
  Financeiro.Registro.DocumentoBaixado := 'S';
  Financeiro.Registro.SituacaoFinanceiro := 'D';
  Financeiro.Registro.ValorPago := Financeiro.Registro.ValorParcela;
  Financeiro.Atualiza;
end;

procedure TFr_Receber_Descontada.Pc_SomaDuplicatas;
Var
  Lc_I : Integer;
  Lc_VL_Original : Real;
Begin
  Lc_VL_Original := 0;
  For Lc_I:= 1 to StrGrd_Duplicata.RowCount -1 do
  Begin
    Lc_VL_Original := Lc_VL_Original + StrToFloatDef(StrGrd_Duplicata.Cells[7,Lc_I],0);
  end;
  E_VL_Original.Text := FloatToStrF(Lc_VL_Original,ffFixed,10,2);
end;

// Procedimento internos
procedure TFr_Receber_Descontada.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Receber_Descontada.Pc_Ativar_Tabelas;
Begin
  Qr_Fornecedor.Active := True;
end;


procedure TFr_Receber_Descontada.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;




procedure TFr_Receber_Descontada.Pc_Adicionar_Tudo;
Var
  Lc_I : Integer;
begin
  if ((StrGrd_Parcela.Cells[1,StrGrd_Parcela.row] = '') OR (StrGrd_Parcela.Cells[8,StrGrd_Parcela.row] = 'S')) then exit;
  if StrGrd_Parcela.Cells[1,StrGrd_Parcela.row] = '' then exit;
  Pc_Buscar_Parcela;
  Pc_Preencher_Parcelas;

 if StrGrd_Parcela.Cells[1,StrGrd_Parcela.row] = '' then exit;
  For Lc_I := 1 to StrGrd_Parcela.RowCount - 1 do
    Begin
    It_Parcela := It_Parcela +1 ;
    StrGrd_Duplicata.RowCount := It_Parcela + 1;
    StrGrd_Duplicata.Cells[1,It_Parcela] := StrGrd_Parcela.Cells[1,lc_I];
    StrGrd_Duplicata.Cells[2,It_Parcela] := StrGrd_Parcela.Cells[2,lc_I];
    StrGrd_Duplicata.Cells[3,It_Parcela] := StrGrd_Parcela.Cells[3,lc_I];
    StrGrd_Duplicata.Cells[4,It_Parcela] := StrGrd_Parcela.Cells[4,lc_I];
    StrGrd_Duplicata.Cells[5,It_Parcela] := StrGrd_Parcela.Cells[5,lc_I];
    StrGrd_Duplicata.Cells[6,It_Parcela] := StrGrd_Parcela.Cells[6,lc_I];
    StrGrd_Duplicata.Cells[7,It_Parcela] := StrGrd_Parcela.Cells[7,lc_I];
    StrGrd_Duplicata.Cells[8,It_Parcela] := StrGrd_Parcela.Cells[8,lc_I];
    StrGrd_Duplicata.Cells[9,It_Parcela] := StrGrd_Parcela.Cells[9,lc_I];
    StrGrd_Duplicata.Cells[10,It_Parcela] := StrGrd_Parcela.Cells[10,lc_I];
    StrGrd_Duplicata.Cells[11,It_Parcela] := StrGrd_Parcela.Cells[11,lc_I];
    StrGrd_Duplicata.Cells[12,It_Parcela] := StrGrd_Parcela.Cells[12,lc_I];
    StrGrd_Duplicata.Cells[13,It_Parcela] := StrGrd_Parcela.Cells[13,lc_I];
    StrGrd_Duplicata.Cells[14,It_Parcela] := StrGrd_Parcela.Cells[14,lc_I];
    StrGrd_Duplicata.Cells[15,It_Parcela] := StrGrd_Parcela.Cells[18,lc_I];
    StrGrd_Duplicata.Cells[16,It_Parcela] := StrGrd_Parcela.Cells[15,lc_I];
    StrGrd_Duplicata.Cells[18,It_Parcela] := StrGrd_Parcela.Cells[20,lc_I];
    StrGrd_Duplicata.Cells[19,It_Parcela] := StrGrd_Parcela.Cells[21,lc_I];
    end;
end;
procedure TFr_Receber_Descontada.Pc_LimpaCampos;
Begin
  E_Data.Date := Date;
  E_Cd_Fornecedor.Clear;
  DBLCB_Fornecedor.KeyValue := Null;
  E_VL_Original.Text := '0,00';
  E_Tx_Operacao.Text := '0,00';
  E_VL_Operacao.Text := '0,00';
  E_VL_Liquido.Text := '0,00';
end;


procedure TFr_Receber_Descontada.Pc_Retirar;
Var
  Lc_I, Lc_J : Integer;
  Lc_Lista : Array of Array of string;
  Lc_Parcela : Integer;
begin
  if StrGrd_Duplicata.Cells[1,StrGrd_Duplicata.row] = '' then exit;
  Lc_Parcela := 0;
  SetLength(Lc_Lista,StrGrd_Duplicata.ColCount,StrGrd_Duplicata.RowCount - 2);
  //Guarda os dados que não estão marcados
  for Lc_I := 1 to StrGrd_Duplicata.RowCount-1 do
    Begin
    if Lc_I <> StrGrd_Duplicata.Row then
      Begin
      for Lc_J := 0 to StrGrd_Duplicata.ColCount - 1  do
        Lc_Lista[Lc_J,Lc_Parcela] := StrGrd_Duplicata.Cells[LC_J, Lc_I];
      Lc_Parcela := Lc_Parcela + 1;
      end;
    end;
  //Limpa a Matriz antes de incluir a diferenca
  Pc_LimpaStringGrid(StrGrd_Duplicata);
  It_Parcela := 0;
  //Grava novamente os dados que não foram marcados e que estão na matriz
  if Lc_Parcela > 0 then
  Begin
    for Lc_I := 0 to Lc_Parcela - 1 do
    Begin
      It_Parcela := It_Parcela +1 ;
      StrGrd_Duplicata.RowCount := It_Parcela + 1;
      for Lc_J := 0 to StrGrd_Duplicata.ColCount - 1 do
        StrGrd_Duplicata.Cells[LC_J, It_PArcela] := Lc_Lista[Lc_J,Lc_I];
    end;
  end
  else
  Begin
    It_Registro := 0;
    It_Parcela := 0;
  end;
end;

procedure TFr_Receber_Descontada.Pc_Retirar_Tudo;
Begin

end;

procedure TFr_Receber_Descontada.SB_Retirar_TudoClick(Sender: TObject);
begin
  Pc_LimpaStringGrid(StrGrd_Duplicata);
  It_Registro := 0;
  It_Parcela := 0;
  Pc_SomaDuplicatas;
  Pc_Buscar_Parcela;
  Pc_Preencher_Parcelas;

end;

procedure TFr_Receber_Descontada.SB_RetirarClick(Sender: TObject);
Begin
  Pc_Retirar;
  Pc_SomaDuplicatas;

  Pc_Buscar_Parcela;
  Pc_Preencher_Parcelas;
end;

procedure TFr_Receber_Descontada.FormCreate(Sender: TObject);
begin
  Financeiro := TControllerFinanceiro.Create(Self);
end;

procedure TFr_Receber_Descontada.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F3  : if Sb_Duplicata.Enabled then Sb_DuplicataClick(Sender);
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_F9  : if Sb_Descontar.Enabled then Sb_DEscontarClick(Sender);
      VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
    end;
end;

procedure TFr_Receber_Descontada.SB_BuscarClick(Sender: TObject);
begin
  Pc_Buscar_Parcela;
  Pc_Preencher_Parcelas;
end;

procedure TFr_Receber_Descontada.Pc_Adicionar;
begin
  if (StrGrd_Parcela.Cells[1,StrGrd_Parcela.row] = '') OR   (StrGrd_Parcela.Cells[8,StrGrd_Parcela.row] = 'S') then exit;

  It_Registro := StrTOIntDef(StrGrd_Parcela.Cells[1,StrGrd_Parcela.row],0);

  It_Parcela := It_Parcela +1 ;
  StrGrd_Duplicata.RowCount := It_Parcela + 1;
  StrGrd_Duplicata.Cells[1,It_Parcela] := StrGrd_Parcela.Cells[1,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[2,It_Parcela] := StrGrd_Parcela.Cells[2,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[3,It_Parcela] := StrGrd_Parcela.Cells[3,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[4,It_Parcela] := StrGrd_Parcela.Cells[4,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[5,It_Parcela] := StrGrd_Parcela.Cells[5,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[6,It_Parcela] := StrGrd_Parcela.Cells[6,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[7,It_Parcela] := StrGrd_Parcela.Cells[7,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[8,It_Parcela] := StrGrd_Parcela.Cells[8,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[9,It_Parcela] := StrGrd_Parcela.Cells[9,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[10,It_Parcela] := StrGrd_Parcela.Cells[10,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[11,It_Parcela] := StrGrd_Parcela.Cells[11,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[12,It_Parcela] := StrGrd_Parcela.Cells[12,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[13,It_Parcela] := StrGrd_Parcela.Cells[13,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[14,It_Parcela] := StrGrd_Parcela.Cells[14,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[15,It_Parcela] := StrGrd_Parcela.Cells[18,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[16,It_Parcela] := StrGrd_Parcela.Cells[15,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[18,It_Parcela] := StrGrd_Parcela.Cells[20,StrGrd_Parcela.row];
  StrGrd_Duplicata.Cells[19,It_Parcela] := StrGrd_Parcela.Cells[21,StrGrd_Parcela.row];
end;


procedure TFr_Receber_Descontada.Pc_Processo_Movim_Financeiro;
Var
  Lc_Escolha: Integer;
Begin
  it_BaixaOK := False;
  if (It_Vl_Pagto <> 0) then
    Begin
    IF (StrGrd_Duplicata.Cells[16,StrGrd_Duplicata.Row] = 'N') then
      Begin
      //Se a etapa de Baixa for normal
      Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                    'Baixar as Duplicatas Selecionadas.'+EOLN+EOLN+
                                    'Confirmar a Baixa ?',
                                    ['Caixa','Banco','Cancelar'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
        IF It_Cd_Quitacao = 0 THEN It_Cd_Quitacao := Fc_GeraCod_BAixa;
          case Lc_Escolha of
            0:Pc_Lancar_Caixa;
            1:Pc_Lancar_Banco;
            2:Exit;
          end;
        end
      else
        Begin
        it_BaixaOK := True;
        end;
      end
  else
    Begin
    it_BaixaOK := True;
    end;
end;


procedure TFr_Receber_Descontada.StrGrd_DuplicataDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
  if (StrGrd_Duplicata.Cells[15,arow]='C') then
    begin // verifica se a linha impar
    StrGrd_Duplicata.Canvas.Font.Color:= clBlack;
    StrGrd_Duplicata.Canvas.Brush.Color:= clMoneyGreen;
    end
  else
    begin
    StrGrd_Duplicata.Canvas.Font.Color:= clRed;
    StrGrd_Duplicata.Canvas.Brush.Color:= clMoneyGreen;
    end;
  StrGrd_Duplicata.Canvas.FillRect(Rect); // redesenha a celula
  StrGrd_Duplicata.Canvas.TextOut(Rect.Left+2,Rect.Top,StrGrd_Duplicata.Cells[acol,arow]); // reimprime o texto.


  { Pega o texto da célula }
  Texto := StrGrd_Duplicata.Cells[acol, ARow];

  { Calcura largura e altura (em pontos) do texto }
  LarguraTexto := StrGrd_Duplicata.Canvas.TextWidth(Texto);
  AlturaTexto := StrGrd_Duplicata.Canvas.TextHeight(Texto);

  { Calcula a posição horizontal do início do texto }
  if  (ACol = 2) or (ACol = 3) or (ACol = 4) or (ACol = 6) then { esquerda }
    X := Rect.Left + 2
  else if  (ACol = 5) or (ACol = 16) then { Centro }
    X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
  else { Direita }
    X := Rect.Right - LarguraTexto - 2;

  { Calcula a posição vertical do início do texto para
    que seja impresso no centro (verticalmente) da célula }
  Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -
    AlturaTexto div 2;

  { Pinta o texto }
  StrGrd_Duplicata.Canvas.TextRect(Rect, X, Y, Texto);
end;

procedure TFr_Receber_Descontada.StrGrd_ParcelaDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
  Begin
    if (StrGrd_Parcela.Cells[18,arow]='C') then
    begin // verifica se a linha impar
      StrGrd_Parcela.Canvas.Font.Color:= clBlack;
      StrGrd_Parcela.Canvas.Brush.Color:= clCream;
    end
    else
    begin
      StrGrd_Parcela.Canvas.Font.Color:= clRed;
      StrGrd_Parcela.Canvas.Brush.Color:= clCream;
    end;
  end;
  StrGrd_Parcela.Canvas.FillRect(Rect); // redesenha a celula
  StrGrd_Parcela.Canvas.TextOut(Rect.Left+2,Rect.Top,StrGrd_Parcela.Cells[acol,arow]); // reimprime o texto.


  { Pega o texto da célula }
  Texto := StrGrd_Parcela.Cells[acol, ARow];

  { Calcura largura e altura (em pontos) do texto }
  LarguraTexto := StrGrd_Parcela.Canvas.TextWidth(Texto);
  AlturaTexto := StrGrd_Parcela.Canvas.TextHeight(Texto);

  { Calcula a posição horizontal do início do texto }
  if  (ACol = 2) or (ACol = 3) or (ACol = 4) or (ACol = 6) OR (ACol = 22) OR (ACol = 23)then { esquerda }
    X := Rect.Left + 2
  else if  (ACol = 5)   or (ACol = 15) then { Centro }
    X := Rect.Left + (Rect.Right - Rect.Left) div 2 -
      LarguraTexto div 2
  else { Direita }
    X := Rect.Right - LarguraTexto - 2;


  { Calcula a posição vertical do início do texto para
    que seja impresso no centro (verticalmente) da célula }
  Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -
    AlturaTexto div 2;

  { Pinta o texto }
  StrGrd_Parcela.Canvas.TextRect(Rect, X, Y, Texto);

end;

procedure TFr_Receber_Descontada.Sb_CancelarClick(Sender: TObject);
Begin
  if ValidaCancelamento then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Cancelar o desconto efetuado com a Duplicata ' + StrGrd_Parcela.Cells[4,StrGrd_Parcela.row]  +'?' + EOLN + EOLN +
                       'Confirmar o cancelamento?',
                       [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
      Try
        Financeiro.Registro.Codigo := StrToIntDef(StrGrd_Parcela.Cells[1,StrGrd_Parcela.Row],0);
        Financeiro.getById;
        Financeiro.Registro.DocumentoBaixado := 'N';
        Financeiro.Registro.SituacaoFinanceiro := 'N';
        Financeiro.Registro.ValorPago := 0;
        Financeiro.Atualiza;
        Financeiro.Movimento.Registro.Quitacao := Financeiro.Registro.CodigoQuitacao;
        Financeiro.Movimento.DeletaByQuitacao;
        Pc_Log_Sistema(Gb_CodMha,
                       GB_Cd_Usuario,
                       now,
                       'Desconto de Duplicatas',
                       StrtoIntDef(StrGrd_Parcela.Cells[1,StrGrd_Parcela.row],0),
                       'Cancelamento de Desconto de Duplicatas',
                       'FINANCEIRO: ' + StrGrd_Parcela.Cells[4,StrGrd_Parcela.row] + ' | VALOR: ' + StrGrd_Parcela.Cells[7,StrGrd_Parcela.row]);
      Finally
        Pc_Buscar_Parcela;
        Pc_Preencher_Parcelas;
      End;
    end;
  End;
end;

procedure TFr_Receber_Descontada.Sb_DuplicataClick(Sender: TObject);
begin
  Pc_Imprime_Duplicata(StrtointDef(StrGrd_Parcela.Cells[14,StrGrd_Parcela.Row],0));
end;

procedure TFr_Receber_Descontada.ChBx_NomeClick(Sender: TObject);
begin
  if ChBx_Nome.Checked then
  Begin
    ChBx_Fantasia.Checked := False;
    StrGrd_Parcela.Cells[6,0] := 'Nome/Razão';
    Pc_Buscar_Parcela;
    Pc_Preencher_Parcelas;
    ChBx_Nome.Enabled := False;
    ChBx_Fantasia.Enabled := True;
  end;
end;

procedure TFr_Receber_Descontada.ChBx_FantasiaClick(Sender: TObject);
begin
  if ChBx_Fantasia.Checked then
  Begin
    ChBx_Nome.Checked := False;
    StrGrd_Parcela.Cells[6,0] := 'Apelido/Fantasia';
    Pc_Buscar_Parcela;
    Pc_Preencher_Parcelas;
  end;
end;

procedure TFr_Receber_Descontada.StrGrd_ParcelaMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if StrGrd_Parcela.Cells[17,StrGrd_Parcela.row] <> '' then
  Begin
    StrGrd_Parcela.ShowHint := True;
    StrGrd_Parcela.Hint := 'Observação: '+#13 + StrGrd_Parcela.Cells[17,StrGrd_Parcela.row]
  end
  else
    StrGrd_Parcela.ShowHint := False;  
end;


procedure TFr_Receber_Descontada.SB_AdicionarClick(Sender: TObject);
begin
  if Rg_Situacao.ItemIndex = 0 then
  Begin
    Pc_Adicionar;
    Pc_Buscar_Parcela;
    Pc_Preencher_Parcelas;
    Pc_SomaDuplicatas;
  End;
end;

procedure TFr_Receber_Descontada.Sb_BaixaClick(Sender: TObject);
Var
  Lc_Escolha : Integer;
begin
  IF StrGrd_Parcela.Cells[9,StrGrd_Parcela.Row] <> 'T' then
  BEgin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Documentos não foi descontado.'+EOLN,
                   ['OK'],[bEscape],mpInformacao);
    exit;
  End;
  Lc_Escolha := (MensagemPadrao(TITULO_INFORMACAO,
                              'Informe como será a situação da Baixa do documento.',
                              ['PAGO','DEVOLVIDO','CANCELAR'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
  case Lc_Escolha of
    0:Begin
        BaixaDescontadaPago;
    End;
    1:Begin
        BaixaDescontadaDevolucao;
      end;
    End;
  MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                 'Documentos baixado com sucesso.'+EOLN,
                 ['OK'],[bEscape],mpInformacao);
  Pc_Buscar_Parcela;
  Pc_Preencher_Parcelas;

end;

procedure TFr_Receber_Descontada.SB_Add_TudoClick(Sender: TObject);
begin
  Pc_Adicionar_Tudo;
  Pc_SomaDuplicatas;
  Pc_Buscar_Parcela;
  Pc_Preencher_Parcelas;
end;

procedure TFr_Receber_Descontada.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;


{-------------------------------------------------------------------------------
Nome : Felipe Correa
Data : 17/09/2010
Alte : Chama a tela de Cadastro de Clientes.
-------------------------------------------------------------------------------}
procedure TFr_Receber_Descontada.Sb_EmpresaClick(Sender: TObject);

begin

end;

{-------------------------------------------------------------------------------
Nome : Felipe Correa
Data : 17/09/2010
Alte : Efetua a pesquisa quando for digitado no campo Código Cliente.
-------------------------------------------------------------------------------}
procedure TFr_Receber_Descontada.E_Busca_Cd_EmpresaExit(Sender: TObject);
begin
  if ChBx_Nome.checked then
    E_Busca_Empresa.Text := Fc_BuscaNomeCliente('EMP_NOME',E_Busca_Cd_Empresa.Text)
  else
    E_Busca_Empresa.Text := Fc_BuscaNomeCliente('EMP_FANTASIA',E_Busca_Cd_Empresa.Text);
end;


procedure TFr_Receber_Descontada.Pc_Lancar_Caixa;
Var
  LfFormCaixa : TFr_Lanca_Caixa;
Begin
  if Fc_VErificaCaixaAberto(True) then
  Begin
    Try
      LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
      LfFormCaixa.Codigo           := 0;
      LfFormCaixa.Quitacao         := It_Cd_Quitacao;
      LfFormCaixa.Caption          := '';
      LfFormCaixa.Operacao         := 'I';
      LfFormCaixa.PlanoResultado   := 0;
      LfFormCaixa.PlanoCentroCusto := 0;
      LfFormCaixa.Historico        := '';
      LfFormCaixa.ValorCredito     := 0;
      LfFormCaixa.ValorDebito      := 0;
      LfFormCaixa.FormaPagto       := 0;
      LfFormCaixa.Mensagem         := True;
      LfFormCaixa.LiberaCampo      := False;
      LfFormCaixa.AutoFill;
      LfFormCaixa.ShowModal;
      it_BaixaOK := LfFormCaixa.Resultado;
    Finally
      FreeAndNil(LfFormCaixa);
    End;
  End;
end;

procedure TFr_Receber_Descontada.Pc_Lancar_Banco;
Begin

end;

procedure TFr_Receber_Descontada.Pc_Processo_Baixa;
Var
  Lc_I : Integer;
  Lc_Cd_Quitacao : Integer;
begin

  //Baixa os creditos dos clientes e soma ao saldo de Credtios a utilizar
  It_Indice_Positivo := StrGrd_Duplicata.RowCount - 1;
  It_Indice_Negativo := StrGrd_Duplicata.RowCount - 1;

  Lc_Cd_Quitacao := It_Cd_Quitacao;


  MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                'Documentos Baixados com Sucesso.'+EOLN+
                'Código da Baixa: '+IntToStr(Lc_Cd_Quitacao) +EOLN,
               ['OK'],[bEscape],mpInformacao);
end;

procedure TFr_Receber_Descontada.Pc_Definir_Grade_Parcela;
begin
 It_Parcela := 0;
  with StrGrd_Parcela do
    Begin
    ColWidths[0]:=17;
    ColWidths[1]:=-1;
    ColWidths[2]:=64;
    ColWidths[3]:=70;
    ColWidths[4]:=110;
    ColWidths[5]:=80;
    ColWidths[6]:=310;
    ColWidths[7]:=70;
    ColWidths[8]:=-1;
    ColWidths[9]:=-1;
    ColWidths[10]:=-1;
    ColWidths[11]:=-1;
    ColWidths[12]:=-1;
    ColWidths[13]:=-1;
    ColWidths[14]:=-1;
    ColWidths[15]:=20;
    ColWidths[16]:=-1;
    ColWidths[17]:=-1;
    ColWidths[18]:=-1;
    ColWidths[19]:=-1;
    ColWidths[20]:=-1;
    ColWidths[21]:=-1;
    ColWidths[22]:=-1;
    ColWidths[23]:=300;
    Cols[2].Add('Pedido');
    Cols[3].Add('Nota Fiscal');
    Cols[4].Add('Duplicata');
    Cols[5].Add('Vencimento');
    Cols[6].Add('Nome/Razão');
    Cols[7].Add('Valor Parc');
    Cols[23].Add('Centro de Custo');
  end;
end;

procedure TFr_Receber_Descontada.Pc_Definir_Grade_Duplicata;
begin
  with StrGrd_Duplicata do
    Begin
    ColWidths[0]:=17;
    ColWidths[1]:=-1;
    ColWidths[2]:=64;
    ColWidths[3]:=77;
    ColWidths[4]:=100;
    ColWidths[5]:=87;
    ColWidths[6]:=310;
    ColWidths[7]:=80;
    ColWidths[8]:=-1;
    ColWidths[9]:=-1;
    ColWidths[10]:=-1;
    ColWidths[11]:=-1;
    ColWidths[12]:=-1;
    ColWidths[13]:=-1;
    ColWidths[14]:=-1;
    ColWidths[15]:=-1;
    ColWidths[16]:=20;
    Cols[2].Add('Pedido');
    Cols[3].Add('Nota Fiscal');
    Cols[4].Add('Duplicata');
    Cols[5].Add('Vencimento');
    Cols[6].Add('Nome');
    Cols[7].Add('Valor');
    end;
end;

{ Verifica se alguma parcela escolhida foi baixada em outra instancia
  Retorna verdadeiro se encontrar uma das parcelas baixadas.
  Esta parcela será retirada da lista de baixas e o processo será abortado.
  Valdo - 04/03/2011 - 22:24 }

procedure TFr_Receber_Descontada.Rg_BaixaClick(Sender: TObject);
begin
  AtivaBotao;
end;

procedure TFr_Receber_Descontada.Rg_DataClick(Sender: TObject);
begin
  if (Rg_Data.ItemIndex = 0) then
  Begin
    Rg_Situacao.Enabled := True;
    Rg_Situacao.ItemIndex := 0;
  end
  else
  Begin
    Rg_Situacao.Enabled := False;
    Rg_Situacao.ItemIndex := 2;
  end;
  if Rg_Situacao.ItemIndex = 0 then It_Cd_Quitacao := 0;    
end;

procedure TFr_Receber_Descontada.Ds_ParcelasDataChange(Sender: TObject;
  Field: TField);
Begin
  AtivaBotao;
End;

procedure TFr_Receber_Descontada.AtivaBotao;
begin
  if Rg_Situacao.ItemIndex = 0 then
  Begin
    It_Cd_Quitacao := 0;
    Sb_Cancelar.Enabled := False;
    SB_Retirar.Enabled := true;
    SB_Retirar_Tudo.Enabled := true;
    SB_Adicionar.Enabled := true;
    SB_Add_Tudo.Enabled := true;
    Sb_Baixa.Enabled := False;
    Rg_Baixa.ItemIndex := 0;
    Rg_Baixa.Enabled := False;
  end
  else
  Begin
    Sb_Duplicata.Enabled := (Qr_Parcelas.RecordCount > 0) ;
    Sb_Cancelar.Enabled := (Qr_Parcelas.RecordCount > 0) ;
    Sb_Baixa.Enabled := (Qr_Parcelas.RecordCount > 0) ;
    SB_Retirar.Enabled := False;
    SB_Retirar_Tudo.Enabled := False;
    SB_Adicionar.Enabled := False;
    SB_Add_Tudo.Enabled := False;
    Rg_Baixa.Enabled := True;
  end;
end;

procedure TFr_Receber_Descontada.Pc_IniciaVariaveis;
Begin
  E_Data.Date := Date;
  ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
  Pc_Definir_Grade_Parcela;   //Definir tamanho Da grade de Parcelas
  Pc_Definir_Grade_Duplicata;   //Definir tamanho Da grade de Duplicatas
  It_Cd_Quitacao := 0;
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
  Pc_Ativar_Tabelas;
end;

procedure TFr_Receber_Descontada.FormShow(Sender: TObject);
begin
  Pc_IniciaVariaveis;
  Pc_FormataTela;
  Pc_ImagemBotao;

end;

function TFr_Receber_Descontada.MontaHistorico:String;
Var
  I:Integer;
begin
  Result := '';
  for I := 1 to StrGrd_Duplicata.rowCount-1 do
  Begin
    if I = 1 then
      Result := concat('Pedidos: ',StrGrd_Duplicata.Cells[2,I])
    else
      Result := concat(Result,'\',StrGrd_Duplicata.Cells[2,I])
  End;
end;

procedure TFr_Receber_Descontada.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Busca
    Sb_Duplicata.Glyph.Assign(Fc_CarregaImagemBotao('INSERIR'));
    Sb_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    Sb_Baixa.Glyph.Assign(Fc_CarregaImagemBotao('FATURAR'));
    SB_Buscar.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));

    //sb_RECIBO.Glyph.Assign(Fc_CarregaImagemBotao('RECIBO'));
    Sb_Descontar.Glyph.Assign(Fc_CarregaImagemBotao('FATURAR'));
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;


procedure TFr_Receber_Descontada.StrGrd_DuplicataDblClick(Sender: TObject);
begin
  SB_RetirarClick(SELF);
end;

function TFr_Receber_Descontada.Fc_ValidaBaixa:boolean;
Begin
  CalculoByValor;
  Result := True;
  if (Trim(DBLCB_Fornecedor.Text) = '') THEN
    BEGIN
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por Favor Preencha o Nome do Fornecedor.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit
    END;

  Result := True;
  if (StrToFloatDef(E_VL_Liquido.Text,0) <= 0) THEN
    BEGIN
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O campo valor Liquido deve ter um valor positivo.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit
    END;


  if (StrToFloatDef(E_VL_Operacao.Text,0) <= 0) THEN
    BEGIN
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O campo valor operação deve ter um valor positivo.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit
    END;


end;

procedure TFr_Receber_Descontada.Pc_RegistraDescontoDuplicatas;
Var
  Lc_I : Integer;
  Lc_Qry : TSTQuery;
  Lc_Cd_Desconto : Integer;
Begin
  Try
    Lc_Qry := Financeiro.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('insert into "TB_FINAN_DESCT"( '+
              '  "FDT_CODIGO" '+
              ', "FDT_CODEMP" '+
              ', "FDT_VL_ORIGINAL" '+
              ', "FDT_TX_OPERACAO" '+
              ', "FDT_VL_OPERACAO" '+
              ', "FDT_VL_LIQUIDO") '+
              'values( '+
              '  :"FDT_CODIGO" '+
              ', :"FDT_CODEMP" '+
              ', :"FDT_VL_ORIGINAL" '+
              ', :"FDT_TX_OPERACAO" '+
              ', :"FDT_VL_OPERACAO" '+
              ', :"FDT_VL_LIQUIDO")');
      Lc_Cd_Desconto := Fc_Generator('GN_FINAN_DESCT','TB_FINAN_DESCT','FDT_CODIGO');
      ParamByName('FDT_CODIGO').AsInteger := Lc_Cd_Desconto;
      ParamByName('FDT_CODEMP').AsInteger := DBLCB_Fornecedor.KeyValue;
      ParamByName('FDT_VL_ORIGINAL').AsCurrency := StrToFloatDef(E_VL_Original.Text,0);
      ParamByName('FDT_TX_OPERACAO').AsFloat := StrToFloatDef(E_Tx_Operacao.Text,0);
      ParamByName('FDT_VL_OPERACAO').AsCurrency := StrToFloatDef(E_VL_Operacao.Text,0);
      ParamByName('FDT_VL_LIQUIDO').AsCurrency := StrToFloatDef(E_VL_Liquido.Text,0);
      ExecSQL;
      //Registra o movimento das duplicatas descontadas
      Active := False;
      SQL.Clear;
      SQL.Add('insert into "TB_MOVIM_DESCT"( '+
              '  "MVD_CODFIN" '+
              ', "MVD_CODFDT" '+
              ', "MVD_SITUACAO") '+
              'values( '+
              '  :"MVD_CODFIN" '+
              ', :"MVD_CODFDT" '+
              ', :"MVD_SITUACAO")');
      For Lc_I:= 1 to StrGrd_Duplicata.RowCount -1 do
      Begin
        if not Transaction.InTransaction then Transaction.StartTransaction;
        Active := False;
        ParamByName('MVD_CODFIN').AsInteger := StrToIntDef(StrGrd_Duplicata.Cells[1,Lc_I],0);
        ParamByName('MVD_CODFDT').AsFloat := Lc_Cd_Desconto;
        ParamByName('MVD_SITUACAO').AsString := 'B';
        ExecSQL;
        if Transaction.InTransaction then Transaction.Commit;
      end;

    end;
  Finally
    Financeiro.FinalizaQuery(Lc_Qry);
  End;
end;

procedure TFr_Receber_Descontada.Pc_AlteraStatusDuplicatas(Pc_Cd_Financeiros,Pc_CodigoQuitacao:Integer;
   Pc_Situacao:String);
Var
  Lc_I : Integer;
  Lc_Qry : TSTQuery;
  LcSql :String;
Begin
  Try
    Lc_Qry := Financeiro.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      LcSql := concat(
                  'UPDATE TB_FINANCEIRO SET ',
                  ' FIN_SITUACAO=:FIN_SITUACAO '
                );
      if Pc_CodigoQuitacao>0 then
      Begin
        LcSql := concat(
                     LcSql,
                     ',FIN_CODQTC=:FIN_CODQTC '
                );
      End;
        LcSql := concat(
                     LcSql,
                     'WHERE FIN_CODIGO=:FIN_CODIGO'
                );

      SQL.Add(LcSql);
      Active := False;
      ParamByName('FIN_SITUACAO').AsString := Pc_Situacao;
      ParamByName('FIN_CODIGO').AsInteger := Pc_Cd_Financeiros;
      if Pc_CodigoQuitacao > 0 then
        ParamByName('FIN_CODQTC').AsInteger := Pc_CodigoQuitacao;
      ExecSQL;
    end;
  Finally
    Financeiro.FinalizaQuery(Lc_Qry);
  End;
end;

procedure TFr_Receber_Descontada.Sb_DescontarClick(Sender: TObject);
Var
  Lc_Cd_Conta : Integer;
  Lc_Cd_Pagto : Integer;
  Lc_I : Integer;
  Lc_Confirma : Boolean;
  Lc_cd_quitacao:Integer;
  LfFormBanco : TFr_Lanca_Banco;
begin
  if Fc_ValidaBaixa then
  Begin
    Lc_cd_Conta := 0;
    Lc_cd_Pagto := 0;
    Lc_Cd_Quitacao := Fc_GeraCod_Baixa;
    Try
      LfFormBanco := TFr_Lanca_Banco.Create(nil);
      LfFormBanco.Codigo           := 0;
      LfFormBanco.Quitacao         := Lc_Cd_Quitacao;
      LfFormBanco.Data             := Date;
      LfFormBanco.ContaCorrente    := Lc_Cd_Conta;
      LfFormBanco.Operacao         := 'I';
      LfFormBanco.PlanoResultado   := 0;
      LfFormBanco.PlanoCentroCusto := 0;
      LfFormBanco.Historico        := concaT('Valor pago desconto duplicatas | ',MontaHistorico);
      LfFormBanco.HistoricoBanco   := 0;
      LfFormBanco.ValorCredito     := 0;
      LfFormBanco.ValorDebito      := StrToFloatDef(E_VL_Operacao.Text,0);
      LfFormBanco.FormaPagto       := Lc_Cd_Pagto;
      LfFormBanco.Mensagem         := True;
      LfFormBanco.LiberaCampo      := False;
      LfFormBanco.AutoFill;
      LfFormBanco.ShowModal;
      Lc_Confirma := LfFormBanco.Resultado;
    Finally
      FreeAndNil(LfFormBanco);
    End;
    if (Lc_Confirma) then
    Begin
      Try
        LfFormBanco := TFr_Lanca_Banco.Create(nil);
        LfFormBanco.ForcarLancamento := True;
        LfFormBanco.Codigo           := 0;
        LfFormBanco.Quitacao         := Lc_Cd_Quitacao;
        LfFormBanco.Data             := Date;
        LfFormBanco.ContaCorrente    := Lc_Cd_Conta;
        LfFormBanco.Operacao         := 'I';
        LfFormBanco.PlanoResultado   := 0;
        LfFormBanco.PlanoCentroCusto := 0;
        LfFormBanco.Historico        := concat('Valor recebido desconto duplicatas | ',MontaHistorico);
        LfFormBanco.HistoricoBanco   := 0;
        LfFormBanco.ValorCredito     := StrToFloatDef(E_VL_Original.Text,0);
        LfFormBanco.ValorDebito      := 0;
        LfFormBanco.FormaPagto       := Lc_Cd_Pagto;
        LfFormBanco.Mensagem         := True;
        LfFormBanco.LiberaCampo      := False;
        LfFormBanco.AutoFill;
        LfFormBanco.ShowModal;
        Lc_Confirma := LfFormBanco.Resultado;
      Finally
        FreeAndNil(LfFormBanco);
      End;
      if (Lc_Confirma) then
      Begin
         Pc_RegistraDescontoDuplicatas;
        For Lc_I := 1 to (StrGrd_Duplicata.RowCount - 1) do
          Pc_AlteraStatusDuplicatas(StrToIntDef(StrGrd_Duplicata.Cells[1,Lc_I],0),Lc_Cd_Quitacao,'T');
        Pc_LimpaStringGrid(StrGrd_Duplicata);
        It_Registro := 0;
        It_Parcela := 0;
        Pc_Buscar_Parcela;
        Pc_Preencher_Parcelas;
        Pc_LimpaCampos;
      end;
    end;
  end;
end;

procedure TFr_Receber_Descontada.E_VL_OperacaoExit(Sender: TObject);
begin
  CalculoByValor;

end;

procedure TFr_Receber_Descontada.chbx_NomeFornecedorClick(Sender: TObject);
begin
  Pc_ListaFornecedorDbLookUpComboBox('EMP_NOME',chbx_NomeFornecedor,chbx_fantasiaFornecedor,DBLCB_Fornecedor);
end;

procedure TFr_Receber_Descontada.chbx_fantasiaFornecedorClick(
  Sender: TObject);
begin
  Pc_ListaFornecedorDbLookUpComboBox('EMP_FANTASIA',chbx_fantasiaFornecedor,chbx_NomeFornecedor,DBLCB_Fornecedor);
end;

procedure TFr_Receber_Descontada.SB_fornecedorClick(Sender: TObject);
Var
  Lc_Form : TFr_Fornecedor;
begin
  If trim(DBLCB_Fornecedor.Text) <> '' then
  Begin
    Try
      Lc_Form := TFr_Fornecedor.Create(nil);
      Lc_Form.Empresa.Registro.Codigo := DBLCB_Fornecedor.KeyValue;
      Lc_Form.ShowModal;
      Pc_AbreListaFornecedor('EMP_NOME');
      DBLCB_Fornecedor.KeyValue := Lc_Form.Empresa.Registro.Codigo;
      DBLCB_FornecedorExit(Sender);
    Finally
      FreeAndNil(Lc_Form);
    End;
  end;
end;

procedure TFr_Receber_Descontada.Qr_FornecedorAfterOpen(DataSet: TDataSet);
begin
  Qr_Fornecedor.FetchAll
end;

procedure TFr_Receber_Descontada.E_Cd_FornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in['0'..'9',Chr(8)]) then Key:= #0;
end;

procedure TFr_Receber_Descontada.E_Tx_OperacaoExit(Sender: TObject);
begin
  CalculoByTaxa;
end;

procedure TFr_Receber_Descontada.E_Cd_FornecedorExit(Sender: TObject);
begin
  DBLCB_Fornecedor.KeyValue := StrToIntDef(E_Cd_Fornecedor.Text,0);
  If DBLCB_Fornecedor.CanFocus then DBLCB_Fornecedor.SetFocus;
end;

procedure TFr_Receber_Descontada.DBLCB_FornecedorExit(Sender: TObject);
begin
  if Trim(DBLCB_Fornecedor.Text) <> '' then
  Begin
    E_Cd_Fornecedor.Text := IntToStr(DBLCB_Fornecedor.KeyValue);
  end;
end;

function TFr_Receber_Descontada.ValidaCancelamento:Boolean;
Begin
  REsult := True;
  if ( StrToIntDef(StrGrd_Parcela.Cells[1,StrGrd_Parcela.Row],0) =0 ) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não há registros para esta operação.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  End;

  if ( StrGrd_Parcela.Cells[8,StrGrd_Parcela.Row] = 'S' )  then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Esta DupliCata está baixada.'+EOLN+
                   'Efetue primeiro o cancelamento da baixa.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  End;
End;




procedure TFr_Receber_Descontada.Sb_Pesq_EmpresaClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(1,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_Busca_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
    E_Busca_Empresa.Text := Lc_Retorno.It_Dados[1,1];
  end;
end;

procedure TFr_Receber_Descontada.Sb_Pesq_ClienteClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(2,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_Cd_Fornecedor.Text := Lc_Retorno.It_Dados[1,0];
    DBLCB_Fornecedor.KeyValue := StrtoIntDef(Lc_Retorno.It_Dados[1,1],0);
  end;
end;

end.






