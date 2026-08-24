unit UN_NCM;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, QEdit_Setes;

type
  TFr_ncm = class(TForm)
    pnl_fundos: TPanel;
    pnl_botoes: TPanel;
    SB_Gravar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Label1: TLabel;
    E_ncm: TEdit_Setes;
    Label2: TLabel;
    E_Descricao: TEdit;
    Label5: TLabel;
    E_Aliq_Nacional: TEdit_Setes;
    Label6: TLabel;
    E_Aliq_Importado: TEdit_Setes;
    Qr_Atualiza: TSTQuery;
    E_Aliq_Estadual: TEdit_Setes;
    E_Aliq_Municipal: TEdit_Setes;
    Label3: TLabel;
    Label4: TLabel;
    Qr_Ncm: TSTQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SB_GravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    It_Inserir : Boolean;
    It_Alterar : Boolean;
    It_Excluir : Boolean;
    It_Visualizar : Boolean;
  public
    { Public declarations }
    It_Cd_Ncm : String;
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_AtivarTabelas;
    procedure Pc_PreencheCampos;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    Function Fc_ValidaGravacao:Boolean;
    procedure Pc_ImagemBotao;
  end;

var
  Fr_ncm: TFr_ncm;

implementation

uses     Un_DM, Un_Msg, Un_Principal, env, UN_Sistema, RN_Crud;
{$R *.dfm}


procedure TFr_ncm.Pc_AtivarTabelas;
begin
  Qr_Ncm.Active:=True;
end;

procedure TFr_ncm.Pc_PreencheCampos;
Begin
  E_ncm.Text := Qr_Ncm.FieldByName('NCM_N_NCM').AsString;
  E_Descricao.Text := Qr_Ncm.FieldByName('NCM_DESCRICAO').AsString;
  E_Aliq_Nacional.Text := FloatToStrF(Qr_Ncm.FieldByName('NCM_AQ_NAC').AsFloat,ffFixed,10,2);
  E_Aliq_Importado.Text := FloatToStrF(Qr_Ncm.FieldByName('NCM_AQ_IMP').AsFloat,ffFixed,10,2);
  E_Aliq_Estadual.Text := FloatToStrF(Qr_Ncm.FieldByName('NCM_AQ_ESTADUAL').AsFloat,ffFixed,10,2);
  E_Aliq_Municipal.Text := FloatToStrF(Qr_Ncm.FieldByName('NCM_AQ_MUNICIPAL').AsFloat,ffFixed,10,2);
end;
// Procedures Internas

procedure TFr_ncm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  It_Cd_Ncm := Qr_Ncm.FieldByName('NCM_N_NCM').AsString;
end;

procedure TFr_ncm.SB_GravarClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  if Fc_ValidaGravacao then
  begin
    try
      with Qr_Atualiza do
      Begin
        Active := False;
        if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
        ParamByName('NCM_N_NCM').AsString := E_ncm.Text;
        ParamByName('NCM_DESCRICAO').AsString := E_Descricao.Text;
        ParamByName('NCM_AQ_NAC').AsFloat := StrToFloatDef(E_Aliq_Nacional.Text,0);
        ParamByName('NCM_AQ_IMP').AsFloat := StrToFloatDef(E_Aliq_Importado.Text,0);
        ParamByName('NCM_AQ_ESTADUAL').AsFloat := StrToFloatDef(E_Aliq_Estadual.Text,0);
        ParamByName('NCM_AQ_MUNICIPAL').AsFloat := StrToFloatDef(E_Aliq_Municipal.Text,0);
        ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      end;
      Close;
    except
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Um erro impossibilitou a gravação dos dados.'+EOLN+
                     'Entre em contato com o suporte técnico.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      DM.IB_Transacao.RollbackRetaining;
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TFr_ncm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = []) then
    begin
      case Key of
      VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
      VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
    end;
end;

procedure TFr_ncm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_ncm.Pc_FormataTela;
begin
  E_Aliq_Nacional.Alignment:= TAlignment(1);
  E_Aliq_Importado.Alignment:= TAlignment(1);
  E_Aliq_Estadual.Alignment:= TAlignment(1);
  E_Aliq_Municipal.Alignment:= TAlignment(1);
end;


procedure TFr_ncm.Pc_IniciaVariaveis;
Begin
  if (Trim(It_Cd_Ncm) <> '')  then
    begin
    Qr_Ncm.Active:=FALSE;
    Qr_Ncm.ParamByName('NCM_N_NCM').AsString := It_Cd_Ncm;
    Pc_AtivarTabelas;
    Pc_PreencheCampos;
    E_Descricao.SetFocus;
    end
  else
    Begin
    Pc_AtivarTabelas;
    end;
end;

procedure TFr_ncm.Sb_Sair_0Click(Sender: TObject);
begin
  close;
end;


function TFr_ncm.Fc_ValidaGravacao: Boolean;
begin
  Result:=true;
  if (trim(E_ncm.Text) = '') then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Código do NCM não informado.'+EOLN+
                   'Preencha o campo antes de continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    Result:=false;
    E_ncm.SetFocus;
  end;

  if (trim(E_Descricao.Text) = '') then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Descrição do NCM não informado.'+EOLN+
                   'Preencha o campo antes de continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    Result:=false;
    E_Descricao.SetFocus;
  end;

  if (StrToFloatDef(E_Aliq_Nacional.Text,0) = 0) then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Imposto Federal para produto nacional não informado.'+EOLN+
                   'Preencha o campo antes de continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    Result:=false;
    E_Aliq_Nacional.SetFocus;
  end;

  if (StrToFloatDef(E_Aliq_Importado.Text,0) = 0) then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Imposto Federal para produto importado não informado.'+EOLN+
                   'Preencha o campo antes de continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    Result:=false;
    E_Aliq_Importado.SetFocus;
  end;

  if (StrToFloatDef(E_Aliq_Estadual.Text,0) = 0) then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Imposto Estadual não informado.'+EOLN+
                   'Preencha o campo antes de continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    Result:=false;
    E_Aliq_Estadual.SetFocus;
  end;

  if (StrToFloatDef(E_Aliq_Municipal.Text,0) = 0) then
  begin
    If (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Imposto Municipal não informado.'+EOLN+EOLN+
                       'Se estiver sujeito a esta tributação, teré problemas na autorização'+EOLN+
                       'Continuar sem o preenchimento ?',
                       [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clRed) = mrBotao1) then
    Begin
      E_Aliq_Municipal.Text := '0,00';
    end
    else
    BEgin
      Result:=false;
      E_Aliq_Municipal.SetFocus;
    end;
  end;

end;

procedure TFr_ncm.Pc_PermissaoBotao(Pc_Menu: string);
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
end;

procedure TFr_ncm.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_ncm.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_IniciaVariaveis;
  Pc_ImagemBotao;
  Pc_PermissaoBotao('Cargos');
end;

end.



