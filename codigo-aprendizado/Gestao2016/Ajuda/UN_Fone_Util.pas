unit UN_Fone_Util;

interface

uses
      STQuery, Data.DB, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Controls, Classes, Vcl.ExtCtrls, Vcl.Forms, SysUtils, Vcl.Graphics, Winapi.Messages, Winapi.Windows, Vcl.Menus, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, QEdit_Setes, ControllerDskPhone;


type
  TFr_Fone_Util = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label28: TLabel;
    E_BuscaContato: TEdit;
    SB_A: TSpeedButton;
    SB_B: TSpeedButton;
    SB_C: TSpeedButton;
    SB_D: TSpeedButton;
    SB_E: TSpeedButton;
    SB_F: TSpeedButton;
    SB_G: TSpeedButton;
    SB_H: TSpeedButton;
    SB_I: TSpeedButton;
    SB_J: TSpeedButton;
    SB_K: TSpeedButton;
    SB_L: TSpeedButton;
    SB_M: TSpeedButton;
    SB_N: TSpeedButton;
    SB_O: TSpeedButton;
    SB_P: TSpeedButton;
    SB_Q: TSpeedButton;
    SB_R: TSpeedButton;
    SB_S: TSpeedButton;
    SB_T: TSpeedButton;
    SB_U: TSpeedButton;
    SB_V: TSpeedButton;
    SB_Z: TSpeedButton;
    SB_Y: TSpeedButton;
    SB_X: TSpeedButton;
    Qr_Pesquisa: TSTQuery;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label20: TLabel;
    Ds_pesquisa: TDataSource;
    SB_Inserir: TSpeedButton;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    SB_Pesquisar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    DBGrid1: TDBGrid;
    Sb_W: TSpeedButton;
    E_Numero: TEdit_Setes;
    Qr_PesquisaID: TIntegerField;
    Qr_PesquisaKIND: TStringField;
    Qr_PesquisaCONTACT: TStringField;
    Qr_PesquisaNUMBER: TStringField;
    Qr_PesquisaADDRESS_KIND: TStringField;
    Cb_Tipo: TComboBox;
    Label1: TLabel;
    E_Contato: TEdit;
    E_BuscaEmpresa: TEdit;
    Label3: TLabel;
    Qr_PesquisaEMP_NOME: TStringField;
    Qr_PesquisaEMP_FANTASIA: TStringField;
    Qr_PesquisaFONE: TStringField;
    Mnu_Tarefas: TMainMenu;
    arefas1: TMenuItem;
    SincronizarcomCadastros1: TMenuItem;
    procedure SB_AClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_PesquisarClick(Sender: TObject);
    procedure E_BuscaContatoChange(Sender: TObject);
    procedure SB_InserirClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Qr_PesquisaCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure SincronizarcomCadastros1Click(Sender: TObject);
  private
    { Private declarations }
    It_Edicao : String;
    Phone : TControllerDskPhone;
    procedure LimpaCampo;
    procedure IniciaVariaveis;
    Function VerificaExistencia:Boolean;
    Function ValidaAlteracao:Boolean;
    Function ValidaGravacao:Boolean;
    Function ValidaExclusao:Boolean;
    procedure Gravar;
    procedure Delete;
  public
    { Public declarations }
    procedure Pc_EstadoEdicao;
    procedure Pc_BuscaInd_geral(pc_Botao :TSpeedButton);
    procedure Pc_ResetaCorBotao;
    procedure Pc_Buscar;
    procedure Pc_ImagemBotao;
  end;

var
  Fr_Fone_Util: TFr_Fone_Util;

implementation

uses     Un_DM, UN_Sistema, UN_MSG, UN_Principal, env, Un_Funcoes;
{$R *.dfm}



procedure TFr_Fone_Util.Pc_ResetaCorBotao;
Begin
  SB_A.Font.Color := clBlack;
  SB_B.Font.Color := clBlack;
  SB_C.Font.Color := clBlack;
  SB_D.Font.Color := clBlack;
  SB_E.Font.Color := clBlack;
  SB_F.Font.Color := clBlack;
  SB_G.Font.Color := clBlack;
  SB_H.Font.Color := clBlack;
  SB_I.Font.Color := clBlack;
  SB_J.Font.Color := clBlack;
  SB_K.Font.Color := clBlack;
  SB_L.Font.Color := clBlack;
  SB_M.Font.Color := clBlack;
  SB_N.Font.Color := clBlack;
  SB_O.Font.Color := clBlack;
  SB_P.Font.Color := clBlack;
  SB_Q.Font.Color := clBlack;
  SB_R.Font.Color := clBlack;
  SB_S.Font.Color := clBlack;
  SB_T.Font.Color := clBlack;
  SB_U.Font.Color := clBlack;
  SB_V.Font.Color := clBlack;
  SB_X.Font.Color := clBlack;
  SB_Y.Font.Color := clBlack;
  SB_W.Font.Color := clBlack;
  SB_Z.Font.Color := clBlack;
end;

procedure TFr_Fone_Util.Qr_PesquisaCalcFields(DataSet: TDataSet);
begin
  with Qr_Pesquisa do
  BEgin
    FieldByname('FONE').asAnsiString    := fc_MascaraFone( FieldByname('NUMBER').asAnsiString );
  End;
end;

procedure TFr_Fone_Util.Pc_BuscaInd_geral(pc_Botao :TSpeedButton);
var
  Lc_Sqltxt:string;
  Lc_Letra : String;
begin
  Screen.Cursor := crHourGlass;
  with Qr_Pesquisa do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    Pc_ResetaCorBotao;
    pc_Botao.Font.Color := clRed;
    Lc_Letra := pc_Botao.Caption;
    Lc_Sqltxt := '';
    Screen.Cursor:=crHourGlass;
    Close;
    Sql.Clear;
    Lc_Sqltxt := 'SELECT f.*, emp_nome, emp_fantasia '+
                 'FROM Tb_PHONE f '+
                 '  left outer join tb_empresa '+
                 '  on (emp_codigo = id)'+
                 'where  (CONTACT LIKE :CONTACT ) ';

    if Trim(E_BuscaEmpresa.Text) <> '' then
      Lc_Sqltxt := Lc_Sqltxt + ' AND ( (EMP_NOME LIKE :EMP_NOME ) OR (EMP_FANTASIA LIKE :EMP_NOME) ) ';

    SQL.Add(Lc_Sqltxt + ' ORDER BY CONTACT');

    if Trim(E_BuscaEmpresa.Text) <> '' then
      ParamByName('EMP_NOME').AsString:= '%' + E_BuscaEmpresa.Text + '%';
    ParamByName('CONTACT').AsString:= Lc_Letra + '%';
    Open;
  end;
  Screen.Cursor := crDefault;
end;

procedure TFr_Fone_Util.Pc_Buscar;
var
  Lc_Sqltxt:string;
  Lc_Letra : String;
begin
  Screen.Cursor := crHourGlass;
  with Qr_Pesquisa do
  Begin
    if Transaction.InTransaction then Transaction.Commit;    
    Pc_ResetaCorBotao;
    Lc_letra := E_BuscaContato.Text;
    Lc_Sqltxt := '';
    Screen.Cursor:=crHourGlass;
    Close;
    Sql.Clear;
    Lc_Sqltxt := 'SELECT f.*, emp_nome, emp_fantasia '+
                 'FROM Tb_PHONE f '+
                 '  left outer join tb_empresa '+
                 '  on (emp_codigo = id)'+
                 'where  ( ID IS NOT NULL ) ';

    if Trim(E_BuscaContato.Text) <> '' then
      Lc_Sqltxt := Lc_Sqltxt + ' AND (CONTACT LIKE :CONTACT ) ';

    if Trim(E_BuscaEmpresa.Text) <> '' then
      Lc_Sqltxt := Lc_Sqltxt + ' AND ( (EMP_NOME LIKE :EMP_NOME ) OR (EMP_FANTASIA LIKE :EMP_NOME) ) ';

    SQL.Add(Lc_Sqltxt + ' ORDER BY CONTACT');

    if Trim(E_BuscaEmpresa.Text) <> '' then
      ParamByName('EMP_NOME').AsString:= '%' + E_BuscaEmpresa.Text + '%';

    if Trim(E_BuscaContato.Text) <> '' then
      ParamByName('CONTACT').AsString:= '%' + Lc_Letra + '%';
    Open;
  End;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Fone_Util.SB_AClick(Sender: TObject);
begin
  Pc_BuscaInd_geral(sender as TSpeedButton);
end;

procedure TFr_Fone_Util.FormCreate(Sender: TObject);
begin
  Phone := TControllerDskPhone.create(Self);
end;

procedure TFr_Fone_Util.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Fone_Util.SincronizarcomCadastros1Click(Sender: TObject);
begin
  TRY
    Self.enabled := False;
    Pc_ProcesoAguarde(Self,'I');
    Phone.SyncronizeAddress;
    Phone.SyncronizeFoneUtil;
  Finally
    Self.enabled := True;
    Pc_ProcesoAguarde(Self,'F');
  end;
end;

function TFr_Fone_Util.ValidaGravacao: Boolean;
Var
  Lc_Fone : String;
begin
  Result := True;
  if Trim(E_Contato.Text) = '' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Um campo nome de contato é obrigatorio.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                   ['OK'],[bEscape],mpErro);
    Result := False;
    E_Contato.SetFocus;
    Exit;
  End;

  Lc_Fone := Fc_RemoveCaracterInformado(E_Numero.Text, ['(',')','-',' ']);
  if  Length(Trim(Lc_Fone)) < 8 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O número de Telefone Informado deve ter mais de 7 dígitos.'+EOLN+
                   'Verique para continuar.'+EOLN,
                   ['OK'],[bEscape],mpErro);
    Result := False;
    E_Numero.SetFocus;
    Exit;
  End;

end;

function TFr_Fone_Util.VerificaExistencia: Boolean;
begin
  Result := True;
  if (Qr_Pesquisa.RecordCount = 0) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não há registros para esta operação.'+EOLN+
                   'Verifique antes de Continuar.'+EOLN,
                   ['OK'],[bEscape],mpErro);
    Result := False;
    Exit;
  End;

end;

procedure TFr_Fone_Util.SB_ExcluirClick(Sender: TObject);
begin
  if ValidaExclusao then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Excluir '+ fc_MascaraFone( Qr_Pesquisa.FieldByName('NUMBER').AsString ) +' de seus arquivos.'+EOLN+EOLN+
                       'Confirmar a exclusão ?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
    begin
      Delete;
      Pc_Buscar;
    end;
  End;
end;

procedure TFr_Fone_Util.SB_PesquisarClick(Sender: TObject);
begin
  Pc_Buscar;
end;

procedure TFr_Fone_Util.E_BuscaContatoChange(Sender: TObject);
begin
  Pc_Buscar;
end;

procedure TFr_Fone_Util.Pc_EstadoEdicao;
BEgin
  SB_Inserir.Enabled := (It_Edicao = 'B');
  SB_Alterar.Enabled :=   (It_Edicao = 'B') ;
  SB_Excluir.Enabled :=  (It_Edicao = 'B') ;
  SB_Gravar.Enabled := ( (It_Edicao = 'I') OR (It_Edicao = 'E') );
  SB_Cancelar.Enabled := ( (It_Edicao = 'I') OR (It_Edicao = 'E') );
  SB_Pesquisar.Enabled :=  (It_Edicao = 'B') ;
end;

procedure TFr_Fone_Util.SB_InserirClick(Sender: TObject);
begin
  It_Edicao := 'I';
  Pc_EstadoEdicao;
  E_Contato.SetFocus;
end;

Function TFr_Fone_Util.ValidaAlteracao:Boolean;
Begin
  Result := True;
  if not VerificaExistencia then
  Begin
    Result := False;
    Exit;
  End;
End;

function TFr_Fone_Util.ValidaExclusao: Boolean;
begin
  Result := True;
  if not VerificaExistencia then
  Begin
    Result := False;
    Exit;
  End;
end;

procedure TFr_Fone_Util.SB_AlterarClick(Sender: TObject);
begin
  if ValidaAlteracao then
  Begin
    With Qr_Pesquisa do
    Begin
      E_Contato.Text := FieldByName('CONTACT').asAnsiString;
      Cb_Tipo.Text := FieldByName('KIND').asAnsiString;
      E_Numero.Text := FieldByName('NUMBER').asAnsiString;
    End;
    It_Edicao := 'E';
    Pc_EstadoEdicao;
    E_Contato.SetFocus;
  End;
end;

procedure TFr_Fone_Util.Gravar;
Begin
  with Phone.Registro do
  Begin
    if ( It_Edicao = 'I' ) then
      Codigo := 0
    else
      Codigo := Qr_Pesquisa.FieldByName('ID').asInteger;
    Tipo := CB_TIPO.Text;
    Contato := E_Contato.Text;
    Numero := Fc_RemoveCaracterInformado(E_Numero.Text, ['(',')','-',' ']);
    TipoEndereco := ''
  End;
  Phone.salva;
End;

procedure TFr_Fone_Util.IniciaVariaveis;
begin
  It_Edicao := 'B';
  Pc_EstadoEdicao;
end;

procedure TFr_Fone_Util.LimpaCampo;
begin
  E_Contato.Clear;
  Cb_Tipo.ItemIndex := 1;
  E_Numero.Clear;
end;

procedure TFr_Fone_Util.Delete;
Begin
  with Phone.Registro,Qr_Pesquisa do
  Begin
    Codigo := FieldByName('ID').asInteger;
    Tipo := FieldByName('KIND').asAnsiString;
    Numero := FieldByName('NUMBER').asAnsiString;
  End;
  Phone.delete;
End;

procedure TFr_Fone_Util.SB_GravarClick(Sender: TObject);
begin
  if ValidaGravacao then
  Begin
    Gravar;
    It_Edicao := 'B';
    Pc_EstadoEdicao;
  end;
  Pc_Buscar;
end;

procedure TFr_Fone_Util.SB_CancelarClick(Sender: TObject);
begin
  It_Edicao := 'B';
  Pc_EstadoEdicao;
end;

procedure TFr_Fone_Util.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F2  : if SB_Inserir.Enabled then SB_InserirClick(Sender);
      VK_F3  : if SB_Alterar.Enabled then SB_AlterarClick(Sender);
      VK_F4  : if SB_Excluir.Enabled then SB_ExcluirClick(Sender);
      VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
      VK_F6  : if SB_Cancelar.Enabled then SB_CancelarClick(Sender);
      VK_F7  : if SB_Pesquisar.Enabled then SB_PesquisarClick(Sender);
      VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_Fone_Util.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Inserir.Glyph := (Fc_CarregaImagemBotao('INSERIR'));
    SB_Alterar.Glyph := (Fc_CarregaImagemBotao('ALTERAR'));
    SB_Excluir.Glyph := (Fc_CarregaImagemBotao('EXCLUIR'));
    SB_Gravar.Glyph := (Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancelar.Glyph := (Fc_CarregaImagemBotao('CANCELAR'));
    SB_Pesquisar.Glyph := (Fc_CarregaImagemBotao('PESQUISAR'));
    Sb_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Fone_Util.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  IniciaVariaveis;
end;

end.
 
