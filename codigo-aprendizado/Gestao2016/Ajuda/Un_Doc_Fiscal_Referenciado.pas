unit Un_Doc_Fiscal_Referenciado;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, ComCtrls, StdCtrls, Mask, QEdit_Setes, DBCtrls, Buttons;

type
  TFr_Doc_Fiscal_Referenciado = class(TForm)
    Pg_Controle: TPageControl;
    tbs_chave: TTabSheet;
    tbs_dados: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    pnl_dados: TPanel;
    E_Chave_Nfe: TEdit_Setes;
    Label1: TLabel;
    Label23: TLabel;
    DBLCB_UF: TDBLookupComboBox;
    E_Ano_Mes: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    E_CNPJ: TMaskEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    E_Modelo: TEdit;
    E_Serie: TEdit;
    E_Numero: TEdit;
    SB_Confirmar: TSpeedButton;
    Label7: TLabel;
    e_InscriEstadual: TMaskEdit;
    Label8: TLabel;
    E_Chave_CT: TEdit_Setes;
    ChBx_NFProd: TCheckBox;
    SB_Cancelar: TSpeedButton;
    procedure tbs_dadosShow(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Pc_ImagemBotao;
    procedure getCodigoChave;
  public
    { Public declarations }
    It_Confirma : Boolean;
    DocReferenciado : Boolean;
    CodigoChaveNotaFiscal : Integer;
    function Fc_ValidaDocVinculado():Boolean;
    function Fc_ValidaDocPreExistente():Boolean;
  end;

var
  Fr_Doc_Fiscal_Referenciado: TFr_Doc_Fiscal_Referenciado;

implementation

uses     Un_DM, UN_MSG, UN_Sistema, UN_Principal, env, Un_Funcoes;

{$R *.dfm}

procedure TFr_Doc_Fiscal_Referenciado.tbs_dadosShow(Sender: TObject);
begin
  DM.Qr_UF.Active := True;
end;

procedure TFr_Doc_Fiscal_Referenciado.FormCreate(Sender: TObject);
begin
  DocReferenciado := False;
end;

procedure TFr_Doc_Fiscal_Referenciado.FormShow(Sender: TObject);
begin
  Pg_Controle.ActivePage := tbs_chave;
  Pc_ImagemBotao;
end;

procedure TFr_Doc_Fiscal_Referenciado.getCodigoChave;
Var
  LcAux: String;
begin
  LcAux := Copy(E_Chave_Nfe.Text,36,8);
  CodigoChaveNotaFiscal := StrToIntDef(LcAux,0);
end;

procedure TFr_Doc_Fiscal_Referenciado.Pc_ImagemBotao;
begin
  with fr_principal do
  Begin
    SB_Confirmar.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    SB_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
  END;
end;

function TFr_Doc_Fiscal_Referenciado.Fc_ValidaDocPreExistente: Boolean;
begin
  REsult := True;
  if (Trim(E_Chave_Nfe.Text) <> '') then
  Begin
    IF (Length(E_Chave_Nfe.Text) <> 44) then
    BEgin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Tamanho da Chave Informada não é válido.' + EOLN +
                     '  Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      result := False;
      exit;
    end;
  End;
end;

function TFr_Doc_Fiscal_Referenciado.Fc_ValidaDocVinculado():Boolean;
Var
  Lc_DocFiscal : String;
Begin
  Result := True;
  if (Trim(E_Chave_Nfe.Text) <> '') then
  Begin
    IF (Length(E_Chave_Nfe.Text) <> 44) then
    BEgin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Tamanho da Chave Informada não é válido.' + EOLN +
                     '  Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      result := False;
      exit;
    end;
  end
  else
  Begin
    Pg_Controle.ActivePageIndex := 1;
    if trim(E_Ano_Mes.Text) = '' then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Preenche com o campo ano e mês no formato AA/MM.' + EOLN +
                     '  Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      result := False;
      exit;
    end;
    Lc_DocFiscal := ValidDocFiscal(E_CNPJ.Text);
    if not (Lc_DocFiscal = OK )  then
    begin
      MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                     Lc_DocFiscal + EOLN,
                     ['OK'], [bEscape], mpErro);
      Result := False;
      exit;
    end;
    if trim(E_Modelo.Text) = '' then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Preenche o campo modelo.' + EOLN +
                     '  Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      result := False;
      exit;
    end;
    if trim(E_Serie.Text) = '' then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Preenche o campo série.' + EOLN +
                     '  Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      result := False;
      exit;
    end;
    if trim(E_Numero.Text) = '' then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Preenche o campo Número da Nota.' + EOLN +
                     '  Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      result := False;
      exit;
    end;
  end;
end;

procedure TFr_Doc_Fiscal_Referenciado.SB_CancelarClick(Sender: TObject);
begin
  if DocReferenciado then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Clicando em cancelar não será possivel enviar a nota para autorização.' + EOLN +
                       'A informação de nota referenciada é obrigatria.' + EOLN +
                       'Confirmar o cancelamento ?',
                       [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
      It_Confirma := False;
      Close;
    end;
  End
  else
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Clicando em cancelar o sistema vai gerar uma chave a partir deste faturamento.' + EOLN +
                       'Se a nota já foi autorizada, vai gerar duplicidade de numero..' + EOLN +
                       '    1º - Não será possivel autorizar a nota.' + EOLN +
                       '    º - Não será possivel pegar o retorno da autorização anterior.' + EOLN +
                       'Confirmar o cancelamento ?',
                       [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
      It_Confirma := False;
      Close;
    end;
  End;
end;

procedure TFr_Doc_Fiscal_Referenciado.SB_ConfirmarClick(Sender: TObject);
begin
  if DocReferenciado then
  Begin
    if Fc_ValidaDocVinculado then
    Begin
      It_Confirma := True;
      Close;
    end;
  End
  else
  Begin
    if Fc_ValidaDocPreExistente then
    BEgin
      getCodigoChave;
      Close;
    End;
  End;
end;

end.
