unit Un_Log_Operacao;

interface

uses
      Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, ComCtrls, Buttons, Grids, DBGrids, jpeg, STQuery, Variants, Menus, QEdit_Setes;

type
  TFr_Log_Operacao = class(TForm)
    GroupBox2: TGroupBox;
    DBG_Pesquisa: TDBGrid;
    Qr_Pesquisa: TSTQuery;
    Ds_Cliente: TDataSource;
    Ds_Produtos: TDataSource;
    SB_Sair_0: TSpeedButton;
    SB_Buscar: TSpeedButton;
    Qr_Acao: TSTQuery;
    Sb_Exc_Todos: TSpeedButton;
    Sb_Exc_Visualizados: TSpeedButton;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label14: TLabel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Cb_Busca_Interface: TComboBox;
    Cb_Busca_Operacao: TComboBox;
    Cb_Busca_Usuario: TComboBox;
    Label3: TLabel;
    e_buscaDescricao: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_BuscarClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure DBG_PesquisaTitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure Cb_Busca_InterfaceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Cb_Busca_OperacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Cb_Busca_UsuarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_Exc_VisualizadosClick(Sender: TObject);
    procedure Sb_Exc_TodosClick(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pc_Formatatela;
    procedure Pc_ImagemBotao;
    procedure Pc_IniciaVariaveis;
    procedure Pc_Ativartabelas;
    procedure Pc_Buscar;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_PreencheComboNomeTelas(Pc_Lista:TComboBox);
    procedure Pc_PreencheComboOperacao(Pc_Lista:TComboBox);
    procedure Pc_ExcluirTodos;
    procedure Pc_Excluirvisualizados;
  end;

var
  Fr_Log_Operacao: TFr_Log_Operacao;

implementation

uses     Un_DM, Un_Produtos, UN_Sistema, Un_Fich_Fin_Cli, Un_Nota_Fiscal, ControllerBase, Un_Imp_Mod_Impressao, Un_Regra_Negocio, UN_MSG, UN_Principal, env;
{$R *.DFM}

procedure TFr_Log_Operacao.Pc_Ativartabelas;
Begin

end;

procedure TFr_Log_Operacao.Pc_IniciaVariaveis;
Begin
  ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','') = 'S'); 
  E_Data_Ini.Date:=date;
  E_Data_Fim.Date:=date;
  Pc_PreencheComboNomeTelas(Cb_Busca_Interface);
  Pc_PreencheComboOperacao(Cb_Busca_Operacao);
  Pc_MontaUsuario(Cb_Busca_Usuario);
end;

procedure TFr_Log_Operacao.Pc_Formatatela;
Begin
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  Pc_ImagemBotao
end;

procedure TFr_Log_Operacao.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    Sb_Exc_Visualizados.Glyph.Assign(Fc_CarregaImagemBotao('EXCLUIR'));
    Sb_Exc_Todos.Glyph.Assign(Fc_CarregaImagemBotao('EXCLUIR'));
    SB_Buscar.Glyph.Assign(Fc_CarregaImagemBotao('PESQUISAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Log_Operacao.Pc_PreencheComboNomeTelas(Pc_Lista:TComboBox);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('select distinct LOG_INTERFACE '+
            'from tb_log_operacao '+
            '   INNER JOIN tb_usuario '+
            '   ON (tb_usuario.USU_CODIGO = tb_log_operacao.log_codusu) '+
            'ORDER BY LOG_INTERFACE ');
      Active := True;
      First;
      while not Eof do
      begin
        Pc_Lista.Items.Add(FieldByName('LOG_INTERFACE').AsString);
        Next;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Log_Operacao.Pc_PreencheComboOperacao(Pc_Lista:TComboBox);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('select distinct LOG_OPERACAO '+
            'from tb_log_operacao '+
            '   INNER JOIN tb_usuario '+
            '   ON (tb_usuario.USU_CODIGO = tb_log_operacao.log_codusu) '+
            'ORDER BY LOG_OPERACAO ');
      Active := True;
      First;
      while not Eof do
      begin
        Pc_Lista.Items.Add(FieldByName('LOG_OPERACAO').AsString);
        Next;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Log_Operacao.Pc_ExcluirTodos;
Begin
  with Qr_Acao do
    Begin
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    //deleta todos os dados
    Active := False;
    SQL.Clear;
    SQL.Add('delete from tb_log_operacao ');
    ExecSQL;
    //reposiciona o Generator
    Active := False;
    SQL.Clear;
    SQL.Add('SET GENERATOR GN_LOG_OPERACAO TO 0;');
    ExecSQL;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.Commit;
    end;
end;

procedure TFr_Log_Operacao.Pc_Excluirvisualizados;
var
  Lc_SqlTxt :String;
Begin
  with Qr_Acao do
    Begin
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    Close;
    SQL.Clear;
    Lc_SqlTxt := 'DELETE from tb_log_operacao '+
                 'WHERE (LOG_CODIGO IS NOT NULL) ';

    IF ChBx_Periodo.Checked then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (LOG_TIMESTAMP BETWEEN :DATAINI AND :DATAFIM) ';

    IF Trim(Cb_Busca_Interface.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (LOG_INTERFACE =:LOG_INTERFACE) ';

    IF Trim(Cb_Busca_Operacao.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (LOG_OPERACAO =:LOG_OPERACAO) ';

    IF Trim(Cb_Busca_Usuario.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (USU_LOGIN =:USU_LOGIN) ';

    SQL.Add(Lc_SqlTxt + ' ORDER BY  LOG_TIMESTAMP, LOG_INTERFACE ');

    //Passagem de Paramentros
    IF ChBx_Periodo.Checked then
      Begin
      ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;// + StrToTime('00:00:00');
      ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;// + StrToTime('23:59:59');
      end;

    IF Trim(Cb_Busca_Interface.Text) <> '' then
      ParamByName('LOG_INTERFACE').AsString := Cb_Busca_Interface.Text;

    IF Trim(Cb_Busca_Operacao.Text) <> '' then
      ParamByName('LOG_OPERACAO').AsString := Cb_Busca_Operacao.Text;

    IF Trim(Cb_Busca_Usuario.Text) <> '' then
      ParamByName('USU_LOGIN').AsString := Cb_Busca_Usuario.Text;

    ExecSQL;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.Commit;
    end;
end;

procedure TFr_Log_Operacao.FormClose(Sender: TObject;
var
    Action: TCloseAction);
begin
  Action:=caFree;
  Fr_Log_Operacao := Nil;
end;

procedure TFr_Log_Operacao.Pc_Buscar;
VaR
  Lc_SqlTxt : String;
begin
  Screen.Cursor:=crHourGlass;
  with Qr_Pesquisa do
    Begin
    Close;
    SQL.Clear;
    Lc_SqlTxt := 'select LOG_TIMESTAMP, LOG_INTERFACE, LOG_OPERACAO, LOG_DESCRICAO, USU_LOGIN '+
                 'from tb_log_operacao '+
                 '   INNER JOIN tb_usuario '+
                 '   ON (tb_usuario.USU_CODIGO = tb_log_operacao.log_codusu) '+
                 'WHERE (LOG_CODIGO IS NOT NULL) ';

    IF ChBx_Periodo.Checked then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (LOG_TIMESTAMP BETWEEN :DATAINI AND :DATAFIM) ';

    IF Trim(Cb_Busca_Interface.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (LOG_INTERFACE =:LOG_INTERFACE) ';

    IF Trim(Cb_Busca_Operacao.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (LOG_OPERACAO =:LOG_OPERACAO) ';

    IF Trim(Cb_Busca_Usuario.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (USU_LOGIN =:USU_LOGIN) ';

    if trim(e_buscaDescricao.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (LOG_DESCRICAO like :LOG_DESCRICAO) ';



    SQL.Add(Lc_SqlTxt + ' ORDER BY  LOG_TIMESTAMP, LOG_INTERFACE ');

    //Passagem de Paramentros
    IF ChBx_Periodo.Checked then
      Begin
      ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;// + StrToTime('00:00:00');
      ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;// + StrToTime('23:59:59');
      end;

    IF Trim(Cb_Busca_Interface.Text) <> '' then
      ParamByName('LOG_INTERFACE').AsString := Cb_Busca_Interface.Text;

    IF Trim(Cb_Busca_Operacao.Text) <> '' then
      ParamByName('LOG_OPERACAO').AsString := Cb_Busca_Operacao.Text;

    IF Trim(Cb_Busca_Usuario.Text) <> '' then
      ParamByName('USU_LOGIN').AsString := Cb_Busca_Usuario.Text;

    if trim(e_buscaDescricao.Text) <> '' then
      ParamByName('LOG_DESCRICAO').AsString := '%'+e_buscaDescricao.Text+'%';

    Open;
    Screen.Cursor:=crDefault;
    end;
end;


procedure TFr_Log_Operacao.SB_Sair_0Click(Sender: TObject);
begin
    Close;
end;

procedure TFr_Log_Operacao.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;

end;

procedure TFr_Log_Operacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
      case Key of
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
      end;
    end;
end;
procedure TFr_Log_Operacao.SB_BuscarClick(Sender: TObject);
begin
  Pc_Buscar;
end;

procedure TFr_Log_Operacao.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Log_Operacao.DBG_PesquisaTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(DBG_Pesquisa, Column);
end;

procedure TFr_Log_Operacao.Pc_PermissaoBotao(Pc_Menu: string);
begin

end;

procedure TFr_Log_Operacao.FormShow(Sender: TObject);
begin
  Pc_Ativartabelas;
  Pc_IniciaVariaveis;
  Pc_Formatatela;
//  Pc_PermissaoBotao('Consulta Vendas');
end;

procedure TFr_Log_Operacao.Cb_Busca_InterfaceKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    Cb_Busca_Interface.ItemIndex := -1
    end;
  end;
end;

procedure TFr_Log_Operacao.Cb_Busca_OperacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    Cb_Busca_Operacao.ItemIndex := -1
    end;
  end;
end;

procedure TFr_Log_Operacao.Cb_Busca_UsuarioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    Cb_Busca_Usuario.ItemIndex := -1
    end;
  end;
end;

procedure TFr_Log_Operacao.Sb_Exc_VisualizadosClick(Sender: TObject);
begin

  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir os registros visualizados nesta consulta.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
    Pc_Excluirvisualizados;
    end;
end;

procedure TFr_Log_Operacao.Sb_Exc_TodosClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir todos os registros do log de operação.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
    Pc_ExcluirTodos;
    end;

end;

end.
