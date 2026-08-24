unit Un_Ctrl_Lotes;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, controllerCtrlLote, ControllerItensNFL, Un_Fm_ListaProdutos, Un_Fm_ListaEmpresas;


type
  TFr_Ctrl_Lote = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    E_Nr_Lote: TMaskEdit;
    Qr_Ctrl_Lote: TSTQuery;
    Ds_Ctrl_Lote: TDataSource;
    Pg_Controle: TPageControl;
    tbs_Lotes: TTabSheet;
    DBG_Pesquisa: TDBGrid;
    tbs_Movimento: TTabSheet;
    Dbg_Movim_Lote: TDBGrid;
    Qr_Movim_AE: TSTQuery;
    Ds_Movim_Ae: TDataSource;
    SB_Buscar_Lote: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Sb_CalculaLote: TSpeedButton;
    Lb_Label_Agente_Entintor: TLabel;
    Sb_Ins_Lote: TSpeedButton;
    ChBx_SaldoLotePositivo: TCheckBox;
    Fm_ListaProdutos: TFm_ListaProdutos;
    Fm_ListaEmpresas: TFm_ListaEmpresas;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Sb_Visualizar: TSpeedButton;
    Sb_Inserir: TSpeedButton;
    Panel1: TPanel;
    Sb_Sair_1: TSpeedButton;
    SB_ExcluirQuebra: TSpeedButton;
    Sb_Detalhe: TSpeedButton;
    chbx_lote_exato: TCheckBox;
    Qr_Movim_AEMLT_CODIGO: TIntegerField;
    Qr_Movim_AEMLT_DATA: TDateField;
    Qr_Movim_AEMLT_TIPO: TStringField;
    Qr_Movim_AEMLT_CODVCL: TIntegerField;
    Qr_Movim_AEMLT_SENTIDO: TStringField;
    Qr_Movim_AEMLT_QTDE: TBCDField;
    Qr_Movim_AEMLT_CODEXT: TIntegerField;
    Qr_Movim_AEEMP_NOME: TStringField;
    Qr_Movim_AEMLT_OBSERVACAO: TStringField;
    Qr_Movim_AEMLT_LOG: TStringField;
    procedure SB_Buscar_LoteClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure DBG_PesquisaTitleClick(Column: TColumn);
    procedure Sb_CalculaLoteClick(Sender: TObject);
    procedure Sb_Ins_LoteClick(Sender: TObject);
    procedure SB_ExcluirQuebraClick(Sender: TObject);
    procedure Dbg_Movim_LoteDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure Sb_DetalheClick(Sender: TObject);
    procedure Fm_ListaEmpresasDBLCB_EmpresaClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure Sb_VisualizarClick(Sender: TObject);
    procedure Sb_InserirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Fm_ListaEmpresasSB_EmpresasClick(Sender: TObject);
    procedure Pg_ControleChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FItemNota : TControllerItensNfl;
    FAutoPreenchimento: Boolean;
    FCodigoproduto: Integer;
    FSentido: String;
    FCodigoVinculo: Integer;
    function validaVisualiza:Boolean;
    procedure OpenCadLote(Codigo:Integer);
    procedure setFAutoPreenchimento(const Value: Boolean);
    procedure AutoPreencherDados;
    procedure setFCodigoproduto(const Value: Integer);
    procedure setFCodigoVinculo(const Value: Integer);
    procedure setFSentido(const Value: String);
  protected
    procedure IniciarVariavies;
  public
    CtrlLote : TControllerCtrlLote;
    procedure Pc_Ativartabelas;
    procedure Pc_BuscarLotes;
    procedure Pc_ImagemBotao;
    procedure Pc_FormataTela;
    function Fc_VerificaRegistroLote():Boolean;
    function Fc_ValidaRecalculaLote():Boolean;
    function Fc_ValidaInsereQuebra():Boolean;
    function Fc_ValidaMostraMovimentoLoteAE():Boolean;
    procedure Pc_RecalculaLote(LoteID:String);
    property AutoPreenchimento: Boolean read FAutoPreenchimento write setFAutoPreenchimento;
    property Sentido : String read FSentido write setFSentido;
    property Codigoproduto : Integer read FCodigoproduto write setFCodigoproduto;
    property CodigoVinculo : Integer read FCodigoVinculo write setFCodigoVinculo;

  end;

var
  Fr_Ctrl_Lote: TFr_Ctrl_Lote;

implementation

uses     Un_DM, Un_Produtos, UN_Sistema, UN_MSG, UN_Principal, env, Un_Regra_Negocio, RN_Lotes, Un_Ctrl_Lote_Saida, RN_Crud, RN_Empresa, RN_Fornecedor, RN_Permissao, RN_NotaFiscal, cad_lote;
{$R *.dfm}

procedure TFr_Ctrl_Lote.Fm_ListaEmpresasSB_EmpresasClick(Sender: TObject);
begin
  Fm_ListaEmpresas.SB_EmpresasClick(Sender);

end;

procedure TFr_Ctrl_Lote.Pc_FormataTela;
Begin
  E_Data_Ini.DateTime := Date;
  E_Data_Fim.DateTime := Date;
  //Mostra a Tela de movimento de Lote deAgente Extintor
  Pg_Controle.ActivePageIndex := 0;

end;

procedure TFr_Ctrl_Lote.Pc_Ativartabelas;
begin
  Fm_ListaEmpresas.Pc_AtivaEmpresa(-1);
end;

procedure TFr_Ctrl_Lote.Pc_BuscarLotes;
var
  Lc_Sqltxt :string;
  Lc_Nr_Lote, Lc_Cd_Empresa, Lc_Empresa: Boolean;
begin
  Screen.Cursor:=crHourGlass;
  with Qr_Ctrl_Lote do
  Begin
    sql.Clear;

    if E_Nr_Lote.Text           = '' Then Lc_Nr_Lote    := False else Lc_Nr_Lote    := True;
    if Fm_ListaEmpresas.E_Cd_Empresa.Text  = '' Then Lc_Cd_Empresa := False else Lc_Cd_Empresa := True;
    if Fm_ListaEmpresas.DBLCB_Empresa.Text    = '' Then Lc_Empresa    := False else Lc_Empresa    := True;

    Lc_Sqltxt := 'SELECT '+
                 '    CLT_CODIGO, '+
                 '    CLT_CODMHA, '+
                 '    CLT_CODEMP, '+
                 '    EMP_NOME, '+
                 '    EMP_FANTASIA, '+
                 '    CLT_NUMERO, '+
                 '    CLT_CERTIFICADO, '+
                 '    CLT_CODPRO, '+
                 '    PRO_DESCRICAO, '+
                 '    CLT_DT_VENCIMENTO, '+
                 '    CLT_QT_ENTRADA, '+
                 '    CLT_QT_SAIDA, '+
                 '    CLT_QT_SALDO '+
                 'FROM TB_CTRL_LOTE '+
                 '   INNER JOIN TB_EMPRESA '+
                 '   ON (EMP_CODIGO = CLT_CODEMP) '+
                 '   LEFT OUTER JOIN TB_PRODUTO '+
                 '    ON (PRO_CODIGO = CLT_CODPRO)'+
                 'WHERE (CLT_CODIGO IS NOT NULL) ';

    if ChBx_SaldoLotePositivo.Checked then
      Lc_Sqltxt := Lc_Sqltxt +'AND (CLT_QT_SALDO > 0) ';

    IF Lc_Nr_Lote then
      if chbx_lote_exato.Checked then
        Lc_Sqltxt := Lc_Sqltxt +'AND (CLT_NUMERO =:CLT_NUMERO) '
      else
        Lc_Sqltxt := Lc_Sqltxt +'AND (CLT_NUMERO like :CLT_NUMERO) ';

    IF Lc_Cd_Empresa then
      Lc_Sqltxt := Lc_Sqltxt +'AND (CLT_CODEMP =:EMP_CODIGO) ';

    IF Lc_Empresa THEN
      Lc_Sqltxt := Lc_Sqltxt +'AND ((EMP_NOME LIKE :EMP_NOME) OR (EMP_FANTASIA LIKE :EMP_NOME) ) ';


    if Trim(Fm_ListaProdutos.E_Cd_Produto.Text) <> '' then
    Begin
      IF (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S') then
      Begin
        If StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0) >0 then
        Begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGO =:PRO_CODIGO) or (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO) ) ';
        end
        else
        begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO) ) ';
        end;
      end
      else
      Begin
        If StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0) >0 then
        Begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGO LIKE :PRO_CODIGO) or (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) ) ';
        end
        else
        begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) ) ';
        end;
      end;
    end;

    if Trim(Fm_ListaProdutos.E_Busca_Produto.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

    if ChBx_Periodo.Checked then
    BEgin
      Lc_SqlTxt := Lc_SqlTxt + 'AND ( CLT_DT_VENCIMENTO between :DATAINI AND :DATAFIM ) ';
    End;


    SQL.Add(Lc_Sqltxt+ ' ORDER BY CLT_NUMERO ');

    IF Lc_Nr_Lote then
      if chbx_lote_exato.Checked then
        ParamByName('CLT_NUMERO').AsString := E_Nr_Lote.Text
      else
        ParamByName('CLT_NUMERO').AsString := E_Nr_Lote.Text + '%';

    IF Lc_Cd_Empresa then
      ParamByName('EMP_CODIGO').AsString := Fm_ListaEmpresas.E_Cd_Empresa.Text;

    IF Lc_Empresa THEN
      ParamByName('EMP_NOME').AsString := '%' + Fm_ListaEmpresas.DBLCB_Empresa.Text +'%';

    if Trim(Fm_ListaProdutos.E_Cd_Produto.Text) <> '' then
    Begin
      IF (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S') then
      Begin
        ParamByName('PRO_CODIGO').AsString := Fm_ListaProdutos.E_Cd_Produto.Text;
      end
      else
      Begin
        ParamByName('PRO_CODIGO').AsString := '%' + Fm_ListaProdutos.E_Cd_Produto.Text + '%';
      end;
    end;

    if Trim(Fm_ListaProdutos.E_Busca_Produto.Text) <> '' then
      ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(Fm_ListaProdutos.E_Busca_Produto.Text,1,98) + '%';

    if ChBx_Periodo.Checked then
    BEgin
      ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
      ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
    End;

    Active:=true;
    end;
  Screen.Cursor:=crDefault;
end;


procedure TFr_Ctrl_Lote.SB_Buscar_LoteClick(Sender: TObject);
begin
  if Pg_Controle.ActivePageIndex = 0 then Pc_BuscarLotes;
end;

procedure TFr_Ctrl_Lote.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Ctrl_Lote.Sb_VisualizarClick(Sender: TObject);
begin
  if validaVisualiza then
    OpenCadLote(Qr_Ctrl_Lote.FieldByName('CLT_CODIGO').AsInteger);
end;

procedure TFr_Ctrl_Lote.setFAutoPreenchimento(const Value: Boolean);
begin
  FAutoPreenchimento := Value;
end;

procedure TFr_Ctrl_Lote.setFCodigoproduto(const Value: Integer);
begin
  FCodigoproduto := Value;
end;

procedure TFr_Ctrl_Lote.setFCodigoVinculo(const Value: Integer);
begin
  FCodigoVinculo := Value;
end;

procedure TFr_Ctrl_Lote.setFSentido(const Value: String);
begin
  FSentido := Value;
end;

function TFr_Ctrl_Lote.validaVisualiza: Boolean;
begin
  REsult := True;
  if not (Fc_VerificaRegistroLote) then
  Begin
    Result := FAlse;
    exit;
  end;
end;

procedure TFr_Ctrl_Lote.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Ctrl_Lote.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil( CtrlLote );
  FreeAndNil( FItemNota );
end;

procedure TFr_Ctrl_Lote.FormCreate(Sender: TObject);
begin
  CtrlLote := TControllerCtrlLote.Create(self);
  FItemNota := TControllerItensNfl.Create(self);
end;

procedure TFr_Ctrl_Lote.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Pg_Controle.ActivePageIndex of
      0:Begin
        case Key of
          VK_F7  : if SB_Buscar_Lote.Enabled then SB_Buscar_LoteClick(Sender);
          VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
          end;
        end;
      1:Begin
        case Key of
          VK_Escape : if Sb_Sair_1.Enabled then Sb_Sair_0Click(Sender);
          end;
        end;
      end;
  end;
end;

procedure TFr_Ctrl_Lote.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    CarregaImagemBotao(Sb_Inserir,'INSERIR');
    CarregaImagemBotao(SB_Visualizar,'VISUALIZAR');

    SB_Buscar_Lote.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    Sb_Sair_1.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    //
    SB_ExcluirQuebra.Glyph.Assign(Fc_CarregaImagemBotao('EXCLUIR'));
    Sb_CalculaLote.Glyph.Assign(Fc_CarregaImagemBotao('RECALCULAR COMISSÃO'));
  END;
end;

procedure TFr_Ctrl_Lote.FormShow(Sender: TObject);
begin
  Pc_Ativartabelas;
  IniciarVariavies;
  Pc_ImagemBotao;
  Pc_FormataTela;
end;

procedure TFr_Ctrl_Lote.IniciarVariavies;
begin
  if FAutoPreenchimento then
     AutoPreencherDados;

end;

procedure TFr_Ctrl_Lote.OpenCadLote(Codigo: Integer);
Var
  Form : TCadLote;
begin
  Form := TCadLote.Create(Self);
  try
    Form.CodigoRegistro := Codigo;
    Form.ShowModal;
    Pc_RecalculaLote(form.Lote.Registro.Codigo.ToString);
    SB_Buscar_LoteClick(Self);
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_Ctrl_Lote.DBG_PesquisaTitleClick(Column: TColumn);
begin
 Pc_Pintar_Grid_Ordenar(DBG_Pesquisa, Column);
end;

function TFr_Ctrl_Lote.Fc_VerificaRegistroLote():Boolean;
Begin
  result := True;
  Qr_Ctrl_Lote.FetchAll;
  if (Qr_Ctrl_Lote.RecordCount = 0) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não há registro para esta operação.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
end;

procedure TFr_Ctrl_Lote.Fm_ListaEmpresasDBLCB_EmpresaClick(Sender: TObject);
begin
  Fm_ListaEmpresas.DBLCB_EmpresaClick(Sender);

end;

function TFr_Ctrl_Lote.Fc_ValidaRecalculaLote():Boolean;
Begin
  result := True;
  if not (Fc_VerificaRegistroLote) then
  Begin
    Result := FAlse;
    exit;
  end;
end;

procedure TFr_Ctrl_Lote.Pc_RecalculaLote(LoteID:String);
Var
  Lc_Lst_Lote : TStringList;
Begin

  //aTUALIZA lOTE
  Lc_Lst_Lote := TStringList.Create;
  Lc_Lst_Lote.Clear;
  Lc_Lst_Lote.Add( LoteID );
  CtrlLote.Movimento.AtualizaSaldoLote(Lc_Lst_Lote);
  FreeAndNil(Lc_Lst_Lote);
end;

procedure TFr_Ctrl_Lote.Pg_ControleChange(Sender: TObject);
begin
  if Fc_ValidaMostraMovimentoLoteAE then
  Begin
    if (Pg_Controle.ActivePage = tbs_Movimento) then
    Begin
      With Qr_Movim_AE do
      Begin
        Close;
        Open;
        FetchAll;
        if RecordCount > 0 then
          Lb_Label_Agente_Entintor.Caption := 'Lista de Movimentação do Lote ' +
                                               Qr_Ctrl_Lote.fieldByName('CLT_NUMERO').AsString +
                                               ' com vencimento em ' + Qr_Ctrl_Lote.fieldByName('CLT_DT_VENCIMENTO').AsString
        else
          Lb_Label_Agente_Entintor.Caption := '';
      end;
    end;
  end;
end;

procedure TFr_Ctrl_Lote.Sb_CalculaLoteClick(Sender: TObject);
Begin
  if Fc_ValidaRecalculaLote then
  Begin
    Pc_RecalculaLote(Qr_Ctrl_Lote.FieldByName('CLT_CODIGO').AsString);
    SB_Buscar_LoteClick(Sender);
  end;
end;

procedure TFr_Ctrl_Lote.Sb_DetalheClick(Sender: TObject);
Var
  LcTipo : String;
begin
  if Qr_Movim_AE.RecordCount >0 then
  Begin
    if Fc_VerificaPermissao('Fr_Nota_Fiscal','Operações NFe','VISUALIZAR',GB_Cd_Usuario,'S') then
    Begin
      LcTipo := Qr_Movim_AE.FieldByName('MLT_TIPO').asString;
      if (LcTipo = 'AJUSTE') or (Copy(LcTipo,1,5) = 'VENDA') OR (LcTipo = 'COMPRA') then
      Begin
        FItemNota.clear;
        FItemNota.Registro.Codigo := Qr_Movim_AE.FieldByName('MLT_CODVCL').asInteger;
        FItemNota.getById;
        if FItemNota.exist and (FItemNota.Registro.CodigoNota > 0) then
        Begin
          Pc_AbreTelaNotaFiscal(FItemNota.Registro.CodigoNota,Self);
        End
        else
        Begin
          MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                         'Não foi possível encontar detalhes do movimento.' + EOLN +
                         'Verifique se o documento foi devidamente baixado' + EOLN,
                         ['OK'], [bEscape], mpAlerta);
        End;
      End
      else
      Begin
        if (LcTipo = 'PRODUÇÃO') then
        Begin
          MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                         'Não foi implementado o detalhe ' + EOLN +
                         '  para movimento de Produção.' + EOLN,
                         ['OK'], [bEscape], mpAlerta);
        End
        else
        Begin
          MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                         'Não foi implementado o detalhe ' + EOLN +
                         '  para este tipo de movimento.' + EOLN,
                         ['OK'], [bEscape], mpAlerta);
        End;
      End;
    End;
  end
  else
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Não há registro para mostrar detalhes.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
  end;
end;

function TFr_Ctrl_Lote.Fc_ValidaMostraMovimentoLoteAE():Boolean;
Begin
  result := True;
  if not (Fc_VerificaRegistroLote) then
    Begin
    Result := FAlse;
    Pg_Controle.ActivePageIndex := 0;
    exit;
    end;
end;

function TFr_Ctrl_Lote.Fc_ValidaInsereQuebra():Boolean;
Begin
  result := True;
  if not (Fc_VerificaRegistroLote) then
    Begin
    Result := FAlse;
    exit;
    end;
end;

procedure TFr_Ctrl_Lote.Sb_InserirClick(Sender: TObject);
begin
  OpenCadLote(0);
end;

procedure TFr_Ctrl_Lote.Sb_Ins_LoteClick(Sender: TObject);
Var
  Lc_Form : TFr_Ctrl_Lote_Saida;
begin
  if Fc_ValidaInsereQuebra then
  Begin
    try
      Lc_Form := TFr_Ctrl_Lote_Saida.Create(Self);
      Lc_Form.It_Cd_Item := 0;
      Lc_Form.It_cd_Lote := Qr_Ctrl_Lote.FieldByname('CLT_CODIGO').AsInteger;
      Lc_Form.It_Tipo := 'EXT_QUEBRA';
      Lc_Form.it_Cd_produto := Qr_Ctrl_Lote.FieldByname('CLT_CODPRO').AsInteger;
      Lc_Form.It_Cd_Empresa := Gb_CodMha;
      Lc_Form.It_Qtde_Lote := Qr_Ctrl_Lote.FieldByname('CLT_QT_SALDO').AsCurrency;
      Lc_Form.ShowModal;
    finally
      FreeAndNil(Lc_Form);
      SB_Buscar_LoteClick(Sender);
    end;
  end;
end;

procedure TFr_Ctrl_Lote.SB_ExcluirQuebraClick(Sender: TObject);
Var
  LcLoteId : Integer;
begin
  if Qr_Movim_AE.FieldByName('MLT_TIPO').AsString = 'EXT_QUEBRA' then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir este registro de quebra de lote de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
      Fc_ApagarRegistro('TB_MOVIMENTO_LOTE',['MLT_CODIGO'],[Qr_Movim_AE.FieldByName('MLT_CODIGO').AsString]);
      With Qr_Movim_AE do
      Begin
        Close;
        Open;
        FetchAll;
      end;
      //Guarda o registro que está na aba Lote
      LcLoteId := Qr_Ctrl_Lote.FieldByName('CLT_CODIGO').AsInteger;
      //Faz as operações que já faziam antes
      Pc_RecalculaLote(Qr_Ctrl_Lote.FieldByName('CLT_CODIGO').AsString);
      Pc_BuscarLotes;
      //Agora vamos reposicionar o registro (dando foco no registro que guardamos usando o comando locate
      Qr_Ctrl_Lote.Locate('CLT_CODIGO',LcLoteId,[]);
    end;
  end
  else
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Este movimento não é uma Quebra de Lote.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
  end;
end;

procedure TFr_Ctrl_Lote.AutoPreencherDados;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := CtrlLote.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.add(concat(
                  'SELECT CLT_NUMERO, CLT_CODPRO, PRO_DESCRICAO ',
                  'FROM TB_CTRL_LOTE ',
                  '    INNER JOIN TB_MOVIMENTO_LOTE ',
                  '    ON (MLT_CODCLT = CLT_CODIGO) ',
                  '    INNER JOIN TB_PRODUTO  ',
                  '    on ( PRO_CODIGO = CLT_CODPRO) ',
                  'WHERE CLT_CODPRO =:CLT_CODPRO ',
                  ' AND MLT_SENTIDO =:MLT_SENTIDO ',
                  ' AND MLT_CODVCL=:MLT_CODVCL '
                  ));
      ParamByName('MLT_SENTIDO').AsString := FSentido;
      ParamByName('CLT_CODPRO').AsInteger := FCodigoproduto;
      ParamByName('MLT_CODVCL').AsInteger := FCodigoVinculo;
      Active := True;
      if RecordCount > 0 then
      Begin
        Pg_Controle.ActivePageIndex := 0;
        E_Nr_Lote.Text := fieldByName('CLT_NUMERO').asString;
        ChBx_Periodo.Checked := false;
        Fm_ListaProdutos.E_Cd_Produto.Text := fieldByName('CLT_CODPRO').asString;
        Fm_ListaProdutos.E_Busca_Produto.Text := fieldByName('PRO_DESCRICAO').asString;
        Pc_BuscarLotes;
      End;
    End;
  Finally
    CtrlLote.FinalizaQuery(Lc_Qry);
  End;
end;

procedure TFr_Ctrl_Lote.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Ctrl_Lote.Dbg_Movim_LoteDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if Ds_Movim_Ae.DataSet.FieldByName('MLT_TIPO').AsString = 'EXT_REUTILIZADO' then
    Dbg_Movim_Lote.Canvas.Font.Color := clRed;
  Dbg_Movim_Lote.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

end.

