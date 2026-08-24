unit Un_Ctrl_Lote_Entrada;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBCtrls, ControllerCtrlLote, System.Math;

type
  TFr_Ctrl_Lote_Entrada = class(TForm)
    Qr_Lote: TSTQuery;
    Ds_Qr_Lote: TDataSource;
    Panel4: TPanel;
    dbgrid_lote: TDBGrid;
    Pnl_Botao: TPanel;
    Sb_Gravar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    Sb_Excluir: TSpeedButton;
    Sb_Alterar: TSpeedButton;
    Sb_Cancelar: TSpeedButton;
    Sb_Inserir: TSpeedButton;
    Pnl_Fundos: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    Label18: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    E_Nr_Lote: TEdit;
    E_Qt_Produto: TEdit;
    E_Nr_Certificado: TEdit;
    E_Dt_Lote: TMaskEdit;
    E_Dt_Vencimento: TMaskEdit;
    Label41: TLabel;
    Sb_Marca: TSpeedButton;
    Dblcb_MarcaAE: TDBLookupComboBox;
    procedure FormShow(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure Sb_ExcluirClick(Sender: TObject);
    procedure Sb_InserirClick(Sender: TObject);
    procedure Sb_AlterarClick(Sender: TObject);
    procedure Sb_CancelarClick(Sender: TObject);
    procedure Sb_GravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Qr_LoteAfterScroll(DataSet: TDataSet);
    procedure Sb_MarcaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
    { Public declarations }
    CtrlLote : TControllerCtrlLote;
    It_Edicao : String;
    It_Cd_Controle : Integer;
    It_Cd_Movimento : Integer;
    It_Cd_Item : Integer;
    It_Tipo : String;
    It_Cd_produto:Integer;
    It_Cd_Empresa:Integer;
    It_Qtde_Lote : Real;
    It_Nr_Lote : String;
    It_Dt_Lote : String;
    It_Dt_Vencimento : String;

    procedure Pc_ImagemBotao;
    procedure Pc_FormataTela;
    procedure Pc_AtivaListaLote;
    procedure Pc_IniciaVariaveis;

    procedure Pc_LimpaCampos;
    procedure Pc_EstadoEdicao;

    procedure Pc_PreencheLote;

    function Fc_SomaQtde(Fc_Cd_Lote,Fc_Cd_Item:Integer):Real;

    Function Fc_ValidaGravacaoEntrada:Boolean;
 end;

var
  Fr_Ctrl_Lote_Entrada: TFr_Ctrl_Lote_Entrada;

implementation

uses     UN_Sistema, UN_Pedido_Vda, UN_Pedido_Cpa, Un_DM, MaskUtils, UN_Principal, env, un_Padrao, RN_Lotes, Un_Regra_Negocio, sea_product_brand, RN_Crud, Un_Funcoes, Un_Msg;
{$R *.dfm}


procedure TFr_Ctrl_Lote_Entrada.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    Sb_Inserir.Glyph := (Fc_CarregaImagemBotao('INSERIR'));
    Sb_Alterar.Glyph := (Fc_CarregaImagemBotao('ALTERAR'));
    Sb_Excluir.Glyph := (Fc_CarregaImagemBotao('EXCLUIR'));
    Sb_Gravar.Glyph := (Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Cancelar.Glyph := (Fc_CarregaImagemBotao('CANCELAR'));
    SB_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Ctrl_Lote_Entrada.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_ImagemBotao;
  Pc_IniciaVariaveis;
end;

procedure TFr_Ctrl_Lote_Entrada.SB_Sair_0Click(Sender: TObject);
begin
  close;
end;

procedure TFr_Ctrl_Lote_Entrada.Sb_ExcluirClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir ' + Qr_Lote.FieldByName('CLT_NUMERO').AsString + ' de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clRed) = mrBotao1) then
    begin
    Fc_ApagarRegistro('TB_MOVIMENTO_LOTE',['MLT_CODIGO'],[IntToStr(It_Cd_Movimento)]);
    Fc_ApagarRegistro('TB_CTRL_LOTE',['CLT_CODIGO'],[IntToStr(It_Cd_Controle)]);
    Pc_LimpaCampos;
    Pc_EstadoEdicao;
    Pc_AtivaListaLote;
    end;
end;

procedure TFr_Ctrl_Lote_Entrada.Pc_FormataTela;
begin

end;

procedure TFr_Ctrl_Lote_Entrada.Pc_AtivaListaLote;
Begin
  Qr_Lote.Active := False;
  Qr_Lote.ParamByName('MLT_CODVCL').AsInteger := It_Cd_Item;
  Qr_Lote.ParamByName('MLT_TIPO').AsString := It_Tipo;
  Qr_Lote.Active := True;
end;

procedure TFr_Ctrl_Lote_Entrada.Pc_IniciaVariaveis;
Begin
  DM.Qr_MarcaProduto.Active := True;
  Pc_AtivaListaLote;
  It_Edicao := 'B';
  Pc_EstadoEdicao;
end;

procedure TFr_Ctrl_Lote_Entrada.Pc_LimpaCampos;
Begin
  It_Cd_Controle := 0;
  It_Cd_Movimento := 0;
  E_Dt_Lote.Clear;
  E_Nr_Lote.Clear;
  E_Nr_Certificado.Clear;
  E_Qt_Produto.Text := '0';
  E_Dt_Vencimento.Clear;
end;

procedure TFr_Ctrl_Lote_Entrada.Pc_EstadoEdicao;
Begin
  Sb_Inserir.Enabled := (It_Edicao = 'B');
  Sb_Alterar.Enabled := (It_Edicao = 'B') and (Qr_Lote.RecordCount>0);
  Sb_Excluir.Enabled := (It_Edicao = 'B') and (Qr_Lote.RecordCount>0) ;
  Sb_Gravar.Enabled := (It_Edicao = 'I') OR (It_Edicao = 'E');
  Sb_Cancelar.Enabled := (It_Edicao = 'I') OR (It_Edicao = 'E');
  SB_Sair_0.Enabled := (It_Edicao = 'B');
  Pnl_Fundos.Enabled:= (It_Edicao = 'I') OR (It_Edicao = 'E');

end;

procedure TFr_Ctrl_Lote_Entrada.Pc_PreencheLote;
Begin
  It_Cd_Controle := Qr_Lote.FieldByName('CLT_CODIGO').AsInteger;
  It_Cd_Movimento := Qr_Lote.FieldByName('MLT_CODIGO').AsInteger;
  E_Dt_Lote.Text := Qr_Lote.FieldByName('MLT_DATA').AsString;
  E_Nr_Lote.Text := Qr_Lote.FieldByName('CLT_NUMERO').AsString;
  E_Nr_Certificado.Text := Qr_Lote.FieldByName('CLT_CERTIFICADO').AsString;
  Dblcb_MarcaAE.KeyValue := Qr_Lote.FieldByName('CLT_CODMRC').AsInteger;
  E_Qt_Produto.Text := Qr_Lote.FieldByName('MLT_QTDE').AsString;
  E_Dt_Vencimento.Text := Qr_Lote.FieldByName('CLT_DT_VENCIMENTO').AsString;
end;


function TFr_Ctrl_Lote_Entrada.Fc_SomaQtde(Fc_Cd_Lote,Fc_Cd_Item:Integer):Real;
var
  Lc_Qry: TSTQuery;
  Lc_SqlTxt: string;
begin
  Lc_Qry := TSTQuery.Create(Self);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    Active := False;
    Lc_SqlTxt:='SELECT CAST(COALESCE(SUM(CLT_QT_SALDO), 0) AS DOUBLE PRECISION) CLT_TOTAL '+
               'FROM TB_CTRL_LOTE '+
               '  INNER JOIN TB_MOVIMENTO_LOTE '+
               '  ON (MLT_CODCLT = CLT_CODIGO) '+
               'WHERE (MLT_CODVCL =:MLT_CODVCL) and (CLT_CODIGO <>:CLT_CODIGO) AND MLT_SENTIDO = ''E'' ';
    SQL.Add(Lc_SqlTxt);
    ParamByName('CLT_CODIGO').AsInteger:= Fc_Cd_Lote;
    ParamByName('MLT_CODVCL').AsInteger:= Fc_Cd_Item;
    Active :=True;
    Result:= FieldByName('CLT_TOTAL').AsCurrency;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

procedure TFr_Ctrl_Lote_Entrada.Sb_InserirClick(Sender: TObject);
begin
  It_Edicao := 'I';
  Pc_EstadoEdicao;
  try
    if E_Dt_Lote.CanFocus then
       E_Dt_Lote.SetFocus;
  except
  end;
  Pc_LimpaCampos;
  E_Nr_Lote.Text        := It_Nr_Lote;
  E_Dt_Lote.Text        := It_Dt_Lote;
  E_Dt_Vencimento.Text  := It_Dt_Vencimento;
end;

procedure TFr_Ctrl_Lote_Entrada.Sb_AlterarClick(Sender: TObject);
begin
  It_Edicao := 'E';
  Pc_EstadoEdicao;
  try
  if E_Dt_Lote.CanFocus then
     E_Dt_Lote.SetFocus;
  except
  end;
end;

procedure TFr_Ctrl_Lote_Entrada.Sb_CancelarClick(Sender: TObject);
begin
  if (It_Edicao = 'I') then
    BEGIN
    Pc_LimpaCampos;
    END;
  It_Edicao := 'B';
  Pc_EstadoEdicao;
  Pc_AtivaListaLote;
  Pc_PreencheLote;   
end;

procedure TFr_Ctrl_Lote_Entrada.Sb_GravarClick(Sender: TObject);
Var
  Lc_Lst_Lote : TStringList;
begin
  if Fc_ValidaGravacaoEntrada then
  Begin
    Lc_Lst_Lote := TStringList.Create;
    Lc_Lst_Lote.Clear;
    It_Cd_Controle := Fc_AtualizaCtrlLote(IntToStr(It_Cd_Controle),
                                          IntToStr(Gb_CodMha),
                                          IntToStr(It_Cd_Empresa),
                                          E_Nr_Lote.Text,
                                          IntToStr(Dblcb_MarcaAE.KeyValue),
                                          E_Nr_Certificado.Text,
                                          IntToStr(It_Cd_produto),
                                          E_Dt_Vencimento.Text);

    It_Cd_Movimento := Fc_AtualizaMovimentoLote(IntToStr(It_Cd_Movimento),
                                                IntToStr(It_Cd_Controle),
                                                E_Dt_Lote.Text,
                                                It_Tipo,
                                                IntToStr(It_Cd_Item),
                                                'E',
                                                E_Qt_Produto.Text,
                                                '',
                                                concat(GB_Nm_Usuario,'-',TimeToStr(Now)),
                                                0);
    Lc_Lst_Lote.Add(IntToStr(It_Cd_Controle));
    CtrlLote.movimento.AtualizaSaldoLote(Lc_Lst_Lote);

    It_Edicao := 'B';
    Pc_AtivaListaLote;
    Pc_PreencheLote;
    Pc_EstadoEdicao;
  end;
end;



function TFr_Ctrl_Lote_Entrada.Fc_ValidaGravacaoEntrada: Boolean;
Var
  Lc_Qtde : Real;
begin
  Result:=true;
  if(not Fc_ValData(E_Dt_Lote.Text)) or (Trim(E_Dt_Lote.Text) = '/  /') then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Data não informada ou incorreta.'+EOLN+
                   'Preencha o campo antes para continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    result:=False;
    if E_Dt_Lote.CanFocus then E_Dt_Lote.SetFocus;
    Exit;
  end;

  if Trim(E_Nr_Lote.Text)='' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Número do Lote não informado.'+EOLN+
                   'Preencha o Número para continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    result:=False;
    if E_Nr_Lote.CanFocus then E_Nr_Lote.SetFocus;
    exit;
  end;

  if Fc_VerificaExistenciaNumeroLote(E_Nr_Lote.Text,
                                     It_Cd_Controle,
                                     It_Cd_Empresa,
                                     It_Cd_produto) then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Número de Lote para este produto já existe.'+ EOLN +EOLN ,
                   ['OK'], [bEscape], mpAlerta);
    result:=False;
    E_Nr_Lote.Clear;
    if E_Nr_Lote.CanFocus then E_Nr_Lote.SetFocus;
    Exit;
  end;

  if Trim(Dblcb_MarcaAE.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Marca do produto não informada.'+EOLN+
                   'Preencha a marca para continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    result:=False;
    if Dblcb_MarcaAE.CanFocus then Dblcb_MarcaAE.SetFocus;
    Exit;
  end ;

  if StrToFloatDef(E_Qt_Produto.Text,0)=0 then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                  'Quantidade de Lote tem que ser maior que zero.'+EOLN+
                  'Preencha a quantidade deste Lote.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    result:=False;
    if E_Qt_Produto.CanFocus then E_Qt_Produto.SetFocus;
    Exit;
  end ;

  //Valida se o lote está dentro da quantidade informada
  Lc_Qtde := Fc_SomaQtde(It_Cd_Controle, It_Cd_Item) + StrToFloatDef(E_Qt_Produto.Text,0);
  if (Lc_Qtde > It_Qtde_Lote) then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                  'Quantidade informada está acima do que foi informada no item relacionado.'+EOLN+
                  'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    result:=False;
    if E_Qt_Produto.CanFocus then E_Qt_Produto.SetFocus;
    Exit;
  end ;

  IF Fc_Tb_Geral('L','PRO_VENC_LOTE','')='S' Then
  Begin
    if(not Fc_ValData(E_Dt_Vencimento.Text)) or (Trim(E_Dt_Vencimento.Text) = '') then
    begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'A Data de Vencimento não foi informada.' + EOLN +
                     'Favor preecher os dados e tentar novamente.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      result:=False;
    end;
  end;

  if(Trim(E_Dt_Vencimento.Text) <> '/  /') then
  begin
    if ( StrToDate(E_Dt_Vencimento.Text) <= StrToDate(E_Dt_Lote.Text) ) then
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'O vencimento não pode ser menor ou igual a data do Lote.'+EOLN+
                     'Verifique antes de continuar.'+EOLN,
                     ['OK'],[bEscape],mpAlerta);
      result:=False;
      if E_Dt_Vencimento.CanFocus then E_Dt_Vencimento.SetFocus;
      Exit;
    end;
  end;
end;

procedure TFr_Ctrl_Lote_Entrada.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = []) then
    begin
      case Key of
      VK_F2  : if Sb_Inserir.Enabled then Sb_InserirClick(Sender);
      VK_F3  : if Sb_Alterar.Enabled then Sb_AlterarClick(Sender);
      VK_F4  : if Sb_Excluir.Enabled then Sb_ExcluirClick(Sender);
      VK_F5  : if Sb_Gravar.Enabled then Sb_GravarClick(Sender);
      VK_F6  : if Sb_Cancelar.Enabled then Sb_CancelarClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
      end;
    end;
end;

procedure TFr_Ctrl_Lote_Entrada.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Ctrl_Lote_Entrada.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (It_Edicao = 'I') or (It_Edicao = 'E') then
    Begin
    canClose := False;
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O registro está sendo editado.'+EOLN+
                   'Grave ou cancele a edição antes de sair da tela.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    end;
end;

procedure TFr_Ctrl_Lote_Entrada.FormCreate(Sender: TObject);
begin
  CtrlLote := TControllerCtrlLote.create(Self);
end;

procedure TFr_Ctrl_Lote_Entrada.Qr_LoteAfterScroll(DataSet: TDataSet);
begin
  Pc_PreencheLote;
end;

procedure TFr_Ctrl_Lote_Entrada.Sb_MarcaClick(
  Sender: TObject);
Var
  Lc_Form : TSeaProductBrand;
begin
  Lc_Form := TSeaProductBrand.Create(nil);
  Try
    if (Trim(Dblcb_MarcaAE.Text) <> '') then
      Lc_Form.CodigoRegistro := Dblcb_MarcaAE.KeyValue;
    Lc_Form.ShowModal;
  Finally
    DM.Qr_MarcaProduto.Active := False;
    DM.Qr_MarcaProduto.Active := True;
    Dblcb_MarcaAE.KeyValue := Lc_Form.CodigoRegistro;
    FreeAndNil(Lc_Form);
  End;
end;

end.




