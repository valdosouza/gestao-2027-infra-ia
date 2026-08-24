unit Un_Lucratividade;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Grids, DBGrids, StdCtrls, Mask, Buttons, ExtCtrls, DB, STQuery, DBCtrls, QEdit_Setes;

type
  TFr_Lucratividade = class(TForm)
    Panel2: TPanel;
    SB_Insere: TSpeedButton;
    SB_Altera: TSpeedButton;
    SB_Exclui: TSpeedButton;
    SB_Grava: TSpeedButton;
    SB_Cancela: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    GroupBox2: TGroupBox;
    Lb_Valor: TLabel;
    Label1: TLabel;
    Dbg_Pesq_Cliente: TDBGrid;
    Qr_Lucratividade: TSTQuery;
    Ds_Lucratividade: TDataSource;
    Label2: TLabel;
    Dblcb_Kind_Lucratividade: TDBLookupComboBox;
    Cb_Operacao: TComboBox;
    E_valor: TEdit_Setes;
    Sb_Kind: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure SB_InsereClick(Sender: TObject);
    procedure SB_AlteraClick(Sender: TObject);
    procedure SB_ExcluiClick(Sender: TObject);
    procedure SB_GravaClick(Sender: TObject);
    procedure SB_CancelaClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_KindClick(Sender: TObject);
  private
    { Private declarations }
    It_EstadoEdicao:String;
    procedure Pc_EstadoEdicao;
  public
    { Public declarations }
    It_Cd_Pedido:Integer;
    It_Cd_Item:Integer;
    procedure Pc_IniciaVariaveis;
    procedure Pc_LimpaCampos;

    Function Fc_Valida_Grava():Boolean;
    procedure Pc_ImagemBotao;

  end;

var
  Fr_Lucratividade: TFr_Lucratividade;

implementation

uses     Un_DM, UN_MSG, UN_Principal, env, RN_Crud, UN_TabelasEmListas, RN_LUCRATIVIDADE, sea_kind_profitability;
{$R *.dfm}

procedure TFr_Lucratividade.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    SB_Insere.Glyph := (Fc_CarregaImagemBotao('INSERIR'));
    SB_Altera.Glyph := (Fc_CarregaImagemBotao('ALTERAR'));
    SB_Exclui.Glyph := (Fc_CarregaImagemBotao('EXCLUIR'));
    SB_Grava.Glyph := (Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancela.Glyph := (Fc_CarregaImagemBotao('CANCELAR'));
    Sb_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
  END;
end;


procedure TFr_Lucratividade.Pc_IniciaVariaveis;
Begin
  Qr_Lucratividade.Active := False;
  Qr_Lucratividade.ParamByName('ITF_CODIGO').AsInteger := It_Cd_Item;
  Qr_Lucratividade.Active := True;
  It_EstadoEdicao := 'B';
  Pc_EstadoEdicao;
end;

procedure TFr_Lucratividade.Pc_LimpaCampos;
Begin
  Dblcb_Kind_Lucratividade.KeyValue := Null;
  Cb_Operacao.ItemIndex := 0;
  E_valor.Clear;
end;

procedure TFr_Lucratividade.FormShow(Sender: TObject);
begin
  DM_ListaConsultas.Pc_ListaKindLucratividade;
  Pc_IniciaVariaveis;
  Pc_ImagemBotao;
end;

procedure TFr_Lucratividade.SB_InsereClick(Sender: TObject);
begin
  It_EstadoEdicao := 'I';
  Pc_EstadoEdicao;
  Pc_LimpaCampos;
  Dblcb_Kind_Lucratividade.SetFocus;
end;

procedure TFr_Lucratividade.SB_AlteraClick(Sender: TObject);
begin
  It_EstadoEdicao := 'E';
  Pc_EstadoEdicao;
  with Qr_Lucratividade do
  Begin
    Dblcb_Kind_Lucratividade.KeyValue := FieldByName('TB_KIND_LUCRATIVIDADE_ID').AsInteger;
    Cb_Operacao.text := FieldByName('OPERATION').AsString;
    E_valor.Text := FloatToStrF(FieldByName('current_value').AsFloat,ffFixed,10,2);
  end;
end;

procedure TFr_Lucratividade.SB_ExcluiClick(Sender: TObject);
begin
  with Qr_Lucratividade do
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Excluir ' + FieldByname('DESCRIPTION').AsString + ' de seus arquivos.' + EOLN + EOLN +
                       'Confirmar a exclusão ?',
                       [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
      Fc_ApagarRegistro('TB_LUCRATIVIDADE',
                        ['tb_itensnlf_id','tb_kind_lucratividade_id'],
                        [FieldByname('tb_itensnlf_id').AsString,FieldByname('tb_kind_lucratividade_id').AsString]);
      Active := False;
      Active := True;
    end;
  end;
end;

Function TFr_Lucratividade.Fc_Valida_Grava():Boolean;
BEgin
  Result := True;
  if trim(Dblcb_Kind_Lucratividade.Text) = '' then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Campo Tipo do Item não informado.'+EOLN+
                   'Preencha o campo para continuar.' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    if Dblcb_Kind_Lucratividade.CanFocus then Dblcb_Kind_Lucratividade.SetFocus;
    Result := False;
    exit;
  end;
  if trim(Cb_Operacao.Text) = '' then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Campo Operação não informado.'+EOLN+
                   'Preencha o campo para continuar.' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    if Cb_Operacao.CanFocus then Cb_Operacao.SetFocus;
    Result := False;
    exit;
  end;
  if StrToFloatDef(E_valor.Text,0) = 0 then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Campo Valor não pode ser Zero.'+EOLN+
                   'Preencha o campo para continuar.' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    if E_valor.CanFocus then E_valor.SetFocus;
    Result := False;
    exit;
  end;

end;

procedure TFr_Lucratividade.SB_GravaClick(Sender: TObject);
begin
  if Fc_Valida_Grava then
  Begin
    Fc_AtualizaLucratividade(IntToStr(It_Cd_Item),
                             IntToStr(It_Cd_Pedido),
                             IntToStr(Dblcb_Kind_Lucratividade.KeyValue),
                             Cb_Operacao.Text,
                             E_valor.Text);
    Pc_LimpaCampos;
    It_EstadoEdicao := 'B';
    Pc_EstadoEdicao;
    Qr_Lucratividade.Active := False;
    Qr_Lucratividade.Active := True;
  end;
end;

procedure TFr_Lucratividade.SB_CancelaClick(Sender: TObject);
begin
  It_EstadoEdicao := 'B';
  Pc_EstadoEdicao;
  Pc_LimpaCampos;
end;

procedure TFr_Lucratividade.Pc_EstadoEdicao;
Begin
  SB_Insere.Enabled := (It_EstadoEdicao = 'B') ;
  SB_Altera.Enabled := (It_EstadoEdicao = 'B') and (Qr_Lucratividade.RecordCount > 0);
  SB_Exclui.Enabled := (It_EstadoEdicao = 'B') and (Qr_Lucratividade.RecordCount > 0);
  SB_Grava.Enabled := (It_EstadoEdicao = 'I') or (It_EstadoEdicao = 'E');
  SB_Cancela.Enabled := (It_EstadoEdicao = 'I') or (It_EstadoEdicao = 'E');
  Sb_Sair_0.Enabled := (It_EstadoEdicao = 'B');
end;

procedure TFr_Lucratividade.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Lucratividade.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F2:if SB_Insere.enabled then SB_InsereClick(Sender);
      VK_F3:if SB_Altera.enabled then SB_AlteraClick(Sender);
      VK_F4:if SB_Exclui.enabled then SB_ExcluiClick(Sender);
      VK_F5:if SB_Grava.enabled then SB_GravaClick(Sender);
      VK_F6:if SB_Cancela.enabled then SB_CancelaClick(Sender);
      VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
  end;
end;

procedure TFr_Lucratividade.Sb_KindClick(Sender: TObject);
Var
  Lc_Form : TSeakindprofitability;
begin
  Lc_Form := TSeakindprofitability.Create(Self);
  Try
    Lc_Form.ShowModal;
    DM_ListaConsultas.Pc_ListaKindLucratividade;
    Dblcb_Kind_Lucratividade.KeyValue := Lc_Form.cds_searchcodigo.AsInteger;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

end.
