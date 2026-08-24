unit Un_Ctrl_Lote_Saida;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, System.Math, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, ControllerCtrlLote;

type
  TFr_Ctrl_Lote_Saida = class(TForm)
    Qr_Lote: TSTQuery;
    Ds_Qr_Lote: TDataSource;
    Panel4: TPanel;
    dbgrid_lote: TDBGrid;
    Pnl_Botao: TPanel;
    Sb_Gravar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    Sb_Excluir: TSpeedButton;
    Sb_Cancelar: TSpeedButton;
    Sb_Inserir: TSpeedButton;
    Pnl_Fundos: TPanel;
    Label1: TLabel;
    E_Qt_Produto: TEdit;
    DBGrid1: TDBGrid;
    Qr_LoteDisponivel: TSTQuery;
    Ds_LoteDisponivel: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure Sb_ExcluirClick(Sender: TObject);
    procedure Sb_InserirClick(Sender: TObject);
    procedure Sb_CancelarClick(Sender: TObject);
    procedure Sb_GravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Qr_LoteAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    It_Just_Quebra_Lote : String;
  public
    { Public declarations }
    CtrlLote : TControllerCtrlLote;
    It_Edicao : String;
    It_cd_Lote : Integer;
    It_Cd_Movimento : Integer;
    It_Cd_Item : Integer;
    It_Tipo : String;
    It_Cd_produto:Integer;
    It_Cd_Empresa:Integer;
    It_Qtde_Lote : Real;
    procedure Pc_ImagemBotao;
    procedure Pc_FormataTela;
    procedure Pc_AtivaListaLote;
    procedure Pc_AtivaListaLoteDisponivel;
    procedure Pc_IniciaVariaveis;

    procedure Pc_LimpaCampos;
    procedure Pc_EstadoEdicao;

    procedure Pc_PreencheLote;


    function Fc_SomaQtde(Fc_Cd_Lote,Fc_Cd_Item:Integer):Real;
    function Fc_SomaQtdeItem(Fc_Cd_Produto:Integer;Fc_Qt_Produto:Real):Real;

    Function Fc_ValidaGravacaoSaida:Boolean;
 end;

var
  Fr_Ctrl_Lote_Saida: TFr_Ctrl_Lote_Saida;

implementation

uses     UN_Sistema, UN_Pedido_Vda, UN_Pedido_Cpa, Un_DM, MaskUtils, Un_Msg, UN_Principal, env, un_Padrao, RN_Lotes, Un_Regra_Negocio, RN_Crud;
{$R *.dfm}


procedure TFr_Ctrl_Lote_Saida.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    Sb_Inserir.Glyph := (Fc_CarregaImagemBotao('INSERIR'));
    Sb_Excluir.Glyph := (Fc_CarregaImagemBotao('EXCLUIR'));
    Sb_Gravar.Glyph := (Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Cancelar.Glyph := (Fc_CarregaImagemBotao('CANCELAR'));
    SB_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Ctrl_Lote_Saida.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_ImagemBotao;
  Pc_IniciaVariaveis;
end;

procedure TFr_Ctrl_Lote_Saida.SB_Sair_0Click(Sender: TObject);
begin
  close;
end;

procedure TFr_Ctrl_Lote_Saida.Sb_ExcluirClick(Sender: TObject);
Var
  Lc_Lst_Lote : TStringList;
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir ' + Qr_Lote.FieldByName('CLT_NUMERO').AsString + ' de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clRed) = mrBotao1) then
    begin
    Fc_ApagarRegistro('TB_MOVIMENTO_LOTE',['MLT_CODIGO'],[IntToStr(It_Cd_Movimento)]);
    Pc_LimpaCampos;
    Lc_Lst_Lote := TStringList.Create;
    Lc_Lst_Lote.Clear;
    Lc_Lst_Lote.Add(IntToStr(Qr_Lote.FieldByName('CLT_CODIGO').AsInteger));
    CtrlLote.movimento.AtualizaSaldoLote(Lc_Lst_Lote);
    Pc_AtivaListaLoteDisponivel;
    Pc_AtivaListaLote;
    It_Edicao := 'B';
    Pc_EstadoEdicao;
    end;
end;

procedure TFr_Ctrl_Lote_Saida.Pc_FormataTela;
begin
  if It_Tipo = 'VENDA' then CAption := 'Controle de Saida de Lotes - Venda';
  if It_Tipo = 'EXT_QUEBRA' then CAption := 'Controle de Saida de Lotes - Quebra';
  if It_Tipo = 'PRODUÇÃO M.P.' then CAption := 'Controle de Saida de Lotes - Matéria Prima';
  if It_Tipo = 'PRODUÇÃO P.A.' then CAption := 'Controle de Entrada de Lotes - Produto Acabado';
end;

procedure TFr_Ctrl_Lote_Saida.Pc_AtivaListaLote;
Begin
  Qr_Lote.Active := False;
  Qr_Lote.SQL.Clear;
  Qr_Lote.SQL.add(concat(
                'SELECT    CLT_CODIGO,   CLT_CODMHA, CLT_CODEMP,  CLT_NUMERO,   CLT_CERTIFICADO, ',
                'CLT_CODPRO, CLT_DT_VENCIMENTO, CLT_QT_ENTRADA,    CLT_QT_SAIDA,    CLT_QT_SALDO, ',
                'MLT_CODIGO,    MLT_DATA,    MLT_QTDE ',
                'FROM TB_CTRL_LOTE ',
                '    INNER JOIN TB_MOVIMENTO_LOTE ',
                '    ON (MLT_CODCLT = CLT_CODIGO) ',
                'WHERE CLT_CODPRO =:CLT_CODPRO ',
                ' AND MLT_SENTIDO =:MLT_SENTIDO ',
                ' AND MLT_CODVCL=:MLT_CODVCL '
                ));
  Qr_Lote.ParamByName('MLT_SENTIDO').AsString := 'S';
  Qr_Lote.ParamByName('CLT_CODPRO').AsInteger := it_Cd_produto;
  Qr_Lote.ParamByName('MLT_CODVCL').AsInteger := It_Cd_Item;
  Qr_Lote.Active := True;
end;

procedure TFr_Ctrl_Lote_Saida.Pc_AtivaListaLoteDisponivel;
Begin
  IF (It_Tipo = 'EXT_QUEBRA') then
  BEgin
    with Qr_LoteDisponivel do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT '+
              '    CLT_CODIGO, '+
              '   MLT_DATA, '+
              '    CLT_CODMHA, '+
              '    CLT_CODEMP, '+
              '    CLT_NUMERO, '+
              '    CLT_CERTIFICADO, '+
              '    CLT_CODPRO, '+
              '    CLT_DT_VENCIMENTO, '+
              '    CLT_QT_SALDO '+
              'FROM TB_CTRL_LOTE '+
              '   INNER JOIN TB_MOVIMENTO_LOTE '+
              '   ON (MLT_CODCLT = CLT_CODIGO) '+
              'WHERE (CLT_CODIGO =:CLT_CODIGO) AND (CLT_QT_SALDO > 0) AND MLT_SENTIDO = ''E'' ');
      ParamByName('CLT_CODIGO').AsInteger := It_cd_Lote;
      Active := True;

    end;
  end
  else
  Begin
    with Qr_LoteDisponivel do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT '+
              '    CLT_CODIGO, '+
              '   MLT_DATA, '+
              '    CLT_CODMHA, '+
              '    CLT_CODEMP, '+
              '    CLT_NUMERO, '+
              '    CLT_CERTIFICADO, '+
              '    CLT_CODPRO, '+
              '    CLT_DT_VENCIMENTO, '+
              '    CLT_QT_SALDO '+
              'FROM TB_CTRL_LOTE '+
              '   INNER JOIN TB_MOVIMENTO_LOTE '+
              '   ON (MLT_CODCLT = CLT_CODIGO) '+
              'WHERE (CLT_CODPRO =:CLT_CODPRO) AND (CLT_QT_SALDO > 0) AND MLT_SENTIDO = ''E'' ');
      ParamByName('CLT_CODPRO').AsInteger := It_Cd_produto;
      Active := True;
    end;
  end;
end;

procedure TFr_Ctrl_Lote_Saida.Pc_IniciaVariaveis;
Begin
  It_Just_Quebra_Lote := '';
  Pc_AtivaListaLoteDisponivel;
  Pc_AtivaListaLote;
  It_Edicao := 'B';
  Pc_EstadoEdicao;

end;

procedure TFr_Ctrl_Lote_Saida.Pc_LimpaCampos;
Begin
  It_Cd_Movimento := 0;
  E_Qt_Produto.Text := '0';
end;

procedure TFr_Ctrl_Lote_Saida.Pc_EstadoEdicao;
Begin
  Sb_Inserir.Enabled := (It_Edicao = 'B');
  Sb_Excluir.Enabled := (It_Edicao = 'B') and (Qr_Lote.RecordCount>0) ;
  Sb_Gravar.Enabled := (It_Edicao = 'I') OR (It_Edicao = 'E');
  Sb_Cancelar.Enabled := (It_Edicao = 'I') OR (It_Edicao = 'E');
  SB_Sair_0.Enabled := (It_Edicao = 'B');
  Pnl_Fundos.Enabled:= (It_Edicao = 'I') OR (It_Edicao = 'E');

end;

procedure TFr_Ctrl_Lote_Saida.Pc_PreencheLote;
Begin
  It_Cd_Movimento := 0;
  E_Qt_Produto.Text := '';
  if Qr_Lote.active then
  Begin
    if Qr_Lote.recordCount > 0 then
    Begin
      It_Cd_Movimento := Qr_Lote.FieldByName('MLT_CODIGO').AsInteger;
      E_Qt_Produto.Text := Qr_Lote.FieldByName('MLT_QTDE').AsString;
    End;
  End;
end;


function TFr_Ctrl_Lote_Saida.Fc_SomaQtde(Fc_Cd_Lote,Fc_Cd_Item:Integer):Real;
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
    Lc_SqlTxt:='SELECT CAST(COALESCE(SUM(MLT_QTDE), 0) AS DOUBLE PRECISION) CLT_TOTAL '+
               'FROM TB_MOVIMENTO_LOTE '+
               'WHERE (MLT_CODVCL =:MLT_CODVCL) and (MLT_CODIGO <>:MLT_CODIGO) ';
    SQL.Add(Lc_SqlTxt);
    ParamByName('MLT_CODIGO').AsInteger:= Fc_Cd_Lote;
    ParamByName('MLT_CODVCL').AsInteger:= Fc_Cd_Item;
    Active :=True;
    Result:= FieldByName('CLT_TOTAL').AsCurrency;
  end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

function TFr_Ctrl_Lote_Saida.Fc_SomaQtdeItem(Fc_Cd_Produto:Integer;Fc_Qt_Produto:Real):Real;
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
    Lc_SqlTxt:='SELECT ppd_qtde '+
               ' FROM tb_prod_prod '+
               ' WHERE (ppd_codpro_m =:PRO_CODIGO)';
    SQL.Add(Lc_SqlTxt);
    ParamByName('PRO_CODIGO').AsInteger:= Fc_Cd_Produto;
    Active :=True;
    FetchAll;
    IF RecordCount > 0 then
    Begin
      Result:= FieldByName('ppd_qtde').AsFloat * Fc_Qt_Produto;
    end
    else
    Begin
      Result:= Fc_Qt_Produto;
    end;
  end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

procedure TFr_Ctrl_Lote_Saida.Sb_InserirClick(Sender: TObject);
begin
  It_Edicao := 'I';
  Pc_EstadoEdicao;
  Pc_LimpaCampos;
  E_Qt_Produto.SetFocus;
end;

procedure TFr_Ctrl_Lote_Saida.Sb_CancelarClick(Sender: TObject);
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

procedure TFr_Ctrl_Lote_Saida.Sb_GravarClick(Sender: TObject);
Var
  Lc_Lst_Lote : TStringList;
begin
  if Fc_ValidaGravacaoSaida then
  Begin
    Lc_Lst_Lote := TStringList.Create;
    Lc_Lst_Lote.Clear;
    //Registra a Saida do Lote
    It_Cd_Movimento := Fc_AtualizaMovimentoLote(IntToStr(It_Cd_Movimento),
                                                Qr_LoteDisponivel.FieldByName('CLT_CODIGO').AsString,
                                                DateToStr(Date),
                                                It_Tipo,
                                                IntToStr(It_Cd_Item),
                                                'S',
                                                E_Qt_Produto.Text,
                                                It_Just_Quebra_Lote,
                                                concat(GB_Nm_Usuario,'-',TimeToStr(Now)),
                                                0);
    //Atualiza o saldo do Lote;
    Lc_Lst_Lote.Add(IntToStr(Qr_LoteDisponivel.FieldByName('CLT_CODIGO').AsInteger));
    CtrlLote.movimento.AtualizaSaldoLote(Lc_Lst_Lote);
    Pc_AtivaListaLoteDisponivel;
    Pc_AtivaListaLote;
    Pc_LimpaCampos;
    Pc_PreencheLote;
    It_Edicao := 'B';
    Pc_EstadoEdicao;
  end;
end;



function TFr_Ctrl_Lote_Saida.Fc_ValidaGravacaoSaida: Boolean;
Var
  Lc_Qtde_Info,Lc_Qtde_Lote : Real;
begin
  Result:=true;
  if(Qr_LoteDisponivel.RecordCount = 0) then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não há lote disponível.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    E_Qt_Produto.SetFocus;
    Exit;
  end;

  if StrToFloatDef(E_Qt_Produto.Text,0)=0 then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                  'Quantidade utilizada do Lote tem que ser maior que zero.'+EOLN+
                  'Preencha a quantidade antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    result:=False;
    E_Qt_Produto.SetFocus;
    Exit;
  end ;
  Lc_Qtde_Info := StrToFloatDef(E_Qt_Produto.Text,0);
  Lc_Qtde_Lote := Qr_LoteDisponivel.FieldByName('CLT_QT_SALDO').AsCurrency;
  if (Lc_Qtde_Info > Lc_Qtde_Lote ) then
    begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                  'Quantidade informada maior do que o Saldo disponível.'+EOLN+
                  'Verifique a quantidade antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    result:=False;
    E_Qt_Produto.Text := FloatToStrF(Qr_LoteDisponivel.FieldByName('CLT_QT_SALDO').AsCurrency,ffFixed,10,2);
    E_Qt_Produto.SetFocus;
    Exit;
    end ;

  if (It_Tipo <> 'EXT_QUEBRA')then
  Begin
    //Valida se o lote está dentro da quantidade informada
    Lc_Qtde_Info := Fc_SomaQtde(0, It_Cd_Item) + StrToFloatDef(E_Qt_Produto.Text,0);

    if (Lc_Qtde_Info > It_Qtde_Lote) then
    begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                    'Quantidade informada está diferente do que foi informada no item relacionado.'+EOLN+
                    'Verifique e tente novamente.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
      result:=False;
      E_Qt_Produto.SetFocus;
      Exit;
    end ;
  end;

  if (It_Tipo = 'EXT_QUEBRA')then
  Begin
    if not(InputQuery('Informações sobre a Quebra de Lote ', 'Justificativa', It_Just_Quebra_Lote)) then
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                    'Por favor informe uma justficativa.'+EOLN+
                    'Verifique e tente novamente.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
      Result := False;
      exit;
    end;
    if Length(It_Just_Quebra_Lote) < 15 then
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                    'A justificativa deve ter peo meno 15 caracteres.'+EOLN+
                    'Verifique e tente novamente.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
      Result := False;
      exit;
    end;
  end;
end;

procedure TFr_Ctrl_Lote_Saida.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = []) then
    begin
      case Key of
      VK_F2  : if Sb_Inserir.Enabled then Sb_InserirClick(Sender);
      VK_F4  : if Sb_Excluir.Enabled then Sb_ExcluirClick(Sender);
      VK_F5  : if Sb_Gravar.Enabled then Sb_GravarClick(Sender);
      VK_F6  : if Sb_Cancelar.Enabled then Sb_CancelarClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
      end;
    end;
end;

procedure TFr_Ctrl_Lote_Saida.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Ctrl_Lote_Saida.FormCloseQuery(Sender: TObject;
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

procedure TFr_Ctrl_Lote_Saida.FormCreate(Sender: TObject);
begin
  CtrlLote := TControllerCtrlLote.create(Self);
end;

procedure TFr_Ctrl_Lote_Saida.Qr_LoteAfterScroll(DataSet: TDataSet);
begin
  Pc_PreencheLote;
end;

end.



