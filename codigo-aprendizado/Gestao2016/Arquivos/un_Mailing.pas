unit un_Mailing;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Grids, DBGrids, StdCtrls, Mask, Buttons, ExtCtrls, DB, STQuery;

type
  TFr_Mailing = class(TForm)
    Panel2: TPanel;
    SB_Ins_Mailing: TSpeedButton;
    SB_Alt_Mailing: TSpeedButton;
    SB_Exc_Mailing: TSpeedButton;
    SB_Grv_Mailing: TSpeedButton;
    SB_Can_Mailing: TSpeedButton;
    SB_Pes_Mailing: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    GroupBox2: TGroupBox;
    Label28: TLabel;
    Label1: TLabel;
    E_EMAIL: TMaskEdit;
    Cb_Tipo_Email: TComboBox;
    Dbg_Pesq_Cliente: TDBGrid;
    Qr_Mailing: TSTQuery;
    Ds_Qr_Mailing: TDataSource;
    E_Contato: TMaskEdit;
    Label2: TLabel;
    Qr_MailingMLG_CODEMP: TIntegerField;
    Qr_MailingMLG_TIPO: TStringField;
    Qr_MailingMLG_EMAIL: TStringField;
    Qr_MailingMLG_NOME: TStringField;
    procedure FormShow(Sender: TObject);
    procedure SB_Ins_MailingClick(Sender: TObject);
    procedure SB_Alt_MailingClick(Sender: TObject);
    procedure SB_Exc_MailingClick(Sender: TObject);
    procedure SB_Grv_MailingClick(Sender: TObject);
    procedure SB_Can_MailingClick(Sender: TObject);
    procedure SB_Pes_MailingClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    It_EstadoEdicao:String;
    procedure Pc_EstadoEdicao;
  public
    { Public declarations }
    It_Cd_Empresa:Integer;
    procedure Pc_IniciaVariaveis;
    procedure Pc_LimpaCampos;
    procedure Pc_Buscar;
    Function Fc_Valida_Grava_Mailing():Boolean;
    procedure Pc_ImagemBotao;

  end;

var
  Fr_Mailing: TFr_Mailing;

implementation

uses     Un_DM, UN_MSG, UN_Principal, env, RN_Crud, RN_Mailing;
{$R *.dfm}

procedure TFr_Mailing.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    SB_Ins_Mailing.Glyph := (Fc_CarregaImagemBotao('INSERIR'));
    SB_Alt_Mailing.Glyph := (Fc_CarregaImagemBotao('ALTERAR'));
    SB_Exc_Mailing.Glyph := (Fc_CarregaImagemBotao('EXCLUIR'));
    SB_Grv_Mailing.Glyph := (Fc_CarregaImagemBotao('GRAVAR'));
    SB_Can_Mailing.Glyph := (Fc_CarregaImagemBotao('CANCELAR'));
    SB_Pes_Mailing.Glyph := (Fc_CarregaImagemBotao('PESQUISAR'));
    Sb_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Mailing.Pc_Buscar;
var
   Lc_Sqltxt: string;
   Lc_Contato,Lc_Email: boolean;
begin
  Lc_Sqltxt := '';
  Screen.Cursor := crHourGlass;
  if E_Contato.Text    = '' then Lc_Contato   := False else Lc_Contato   := True;
  if E_EMAIL.Text    = '' then Lc_Email   := False else Lc_Email   := True;

  with Qr_Mailing do
  Begin
    Close;
    Sql.Clear;
    Lc_Sqltxt := 'select * '+
                 'from tb_mailing '+
                 'where MLG_CODEMP=:EMP_CODIGO ';
    if Lc_Contato then
      Lc_Sqltxt := Lc_Sqltxt + ' AND MLG_NOME LIKE :MLG_NOME';

    if Lc_Email then
      Lc_Sqltxt := Lc_Sqltxt + ' AND MLG_EMAIL LIKE :MLG_EMAIL';

    SQL.Add(Lc_Sqltxt + ' Order By MLG_EMAIL ');

    ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empresa;
    if Lc_Contato then
      ParamByName('MLG_NOME').AsString := '%' + E_Contato.Text + '%';

    if Lc_Email then
      ParamByName('MLG_EMAIL').AsString := '%' + E_EMAIL.Text + '%';

    Open;
    First;
  end;
  Screen.Cursor := crDefault;
end;

procedure TFr_Mailing.Pc_IniciaVariaveis;
Begin
  Qr_Mailing.Active := False;
  Qr_Mailing.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empresa;
  Qr_Mailing.Active := True;
  It_EstadoEdicao := 'B';
  Pc_EstadoEdicao;
end;

procedure TFr_Mailing.Pc_LimpaCampos;
Begin
  E_Contato.Clear;
  E_EMAIL.Clear;
  Cb_Tipo_Email.ItemIndex := 0;
end;

procedure TFr_Mailing.FormShow(Sender: TObject);
begin
  Pc_IniciaVariaveis;
  Pc_ImagemBotao;
end;

procedure TFr_Mailing.SB_Ins_MailingClick(Sender: TObject);
begin
  It_EstadoEdicao := 'I';
  Pc_EstadoEdicao;
  Pc_LimpaCampos;
  E_Contato.SetFocus;
end;

procedure TFr_Mailing.SB_Alt_MailingClick(Sender: TObject);
begin
  It_EstadoEdicao := 'E';
  Pc_EstadoEdicao;
  E_Contato.Text := Qr_Mailing.FieldByName('MLG_NOME').AsString;
  E_EMAIL.Text := Qr_Mailing.FieldByName('MLG_EMAIL').AsString;
  Cb_Tipo_Email.Text := Qr_Mailing.FieldByName('MLG_TIPO').AsString;
  E_EMAIL.SetFocus;
end;

procedure TFr_Mailing.SB_Exc_MailingClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir ' + Qr_Mailing.FieldByname('MLG_EMAIL').AsString + ' de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
  begin
    with Qr_Mailing do
    Begin
      Fc_ApagarRegistro('TB_MAILING',
                        ['MLG_CODEMP','MLG_TIPO'],
                        [FieldByname('MLG_CODEMP').AsString,FieldByname('MLG_TIPO').AsString])
    end;
    Pc_Buscar;
  end;
end;

Function TFr_Mailing.Fc_Valida_Grava_Mailing():Boolean;
BEgin
  Result := True;
  if trim(E_EMAIL.Text) = '' then
    begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Campo endereço de e-mail não informado.'+EOLN+
                   'Preencha o campo para continuar.' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    if E_EMAIL.CanFocus then E_EMAIL.SetFocus;
    Result := False;
    exit;
    end;
end;

procedure TFr_Mailing.SB_Grv_MailingClick(Sender: TObject);
begin
  if Fc_Valida_Grava_Mailing then
  Begin
    Fc_AtualizaMailing(IntToStr(It_Cd_Empresa),
                       Cb_Tipo_Email.Text,
                       E_Email.Text,
                       E_Contato.Text);
    Pc_LimpaCampos;
    It_EstadoEdicao := 'B';
    Pc_EstadoEdicao;
    Pc_Buscar;
  end;
end;

procedure TFr_Mailing.SB_Can_MailingClick(Sender: TObject);
begin
  It_EstadoEdicao := 'B';
  Pc_EstadoEdicao;
  Pc_LimpaCampos;
end;

procedure TFr_Mailing.Pc_EstadoEdicao;
Begin
  SB_Ins_Mailing.Enabled := (It_EstadoEdicao = 'B') ;
  SB_Alt_Mailing.Enabled := (It_EstadoEdicao = 'B') and (Qr_Mailing.RecordCount > 0);
  SB_Exc_Mailing.Enabled := (It_EstadoEdicao = 'B') and (Qr_Mailing.RecordCount > 0);
  SB_Grv_Mailing.Enabled := (It_EstadoEdicao = 'I') or (It_EstadoEdicao = 'E');
  SB_Can_Mailing.Enabled := (It_EstadoEdicao = 'I') or (It_EstadoEdicao = 'E');
  SB_Pes_Mailing.Enabled := (It_EstadoEdicao = 'B');
  Sb_Sair_0.Enabled := (It_EstadoEdicao = 'B');
end;

procedure TFr_Mailing.SB_Pes_MailingClick(Sender: TObject);
begin
  Pc_Buscar;
end;

procedure TFr_Mailing.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Mailing.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F2:if SB_Ins_Mailing.enabled then SB_Ins_MailingClick(Sender);
      VK_F3:if SB_Alt_Mailing.enabled then SB_Alt_MailingClick(Sender);
      VK_F4:if SB_Exc_Mailing.enabled then SB_Exc_MailingClick(Sender);
      VK_F5:if SB_Grv_Mailing.enabled then SB_Grv_MailingClick(Sender);
      VK_F6:if SB_Can_Mailing.enabled then SB_Can_MailingClick(Sender);
      VK_F7:if SB_Pes_Mailing.enabled then SB_Pes_MailingClick(Sender);
      VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
  end;
end;

end.
