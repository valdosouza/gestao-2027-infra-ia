unit un_conferente;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, DBCtrls, ComCtrls, Mask, QEdit_Setes, DB, STQuery, COntrollerPedido;

type
  TFr_Conferente = class(TForm)
    Pg_Conferente: TPageControl;
    tbs_Confere: TTabSheet;
    Pnl_Fundo: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    E_Cliente: TEdit_Setes;
    E_Nr_Pedido: TEdit_Setes;
    Pnl_Botao: TPanel;
    SB_Faturar: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Pesquisar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    tbs_Pesquisa: TTabSheet;
    Pnl_Busca: TGroupBox;
    SB_Buscar: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    Sb_Sair_1: TSpeedButton;
    DBG_Pesquisa: TDBGrid;
    GroupBox1: TGroupBox;
    Label36: TLabel;
    Label10: TLabel;
    E_BuscaCliente: TEdit;
    E_BuscaPedido: TEdit_Setes;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Busca_Nome: TCheckBox;
    ChBx_Busca_Fantasia: TCheckBox;
    ChBx_Periodo: TCheckBox;
    Dblcb_Busca_Vendedor: TDBLookupComboBox;
    Panel1: TPanel;
    Panel2: TPanel;
    DBG_Produtos: TDBGrid;
    Label3: TLabel;
    E_Vendedor: TEdit_Setes;
    E_Data: TEdit_Setes;
    Qr_Pesquisa: TSTQuery;
    Ds_Pesquisa: TDataSource;
    Rg_Filtro: TRadioGroup;
    Label5: TLabel;
    Qr_Itens: TSTQuery;
    Ds_Itens: TDataSource;
    E_Conferencia: TEdit_Setes;
    Label6: TLabel;
    Qr_Conferir: TSTQuery;
    E_Cd_Barras: TEdit;
    Sb_Pesq_Empresa: TSpeedButton;
    procedure SB_BuscarClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure ChBx_Busca_NomeClick(Sender: TObject);
    procedure ChBx_Busca_FantasiaClick(Sender: TObject);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure DBG_PesquisaDblClick(Sender: TObject);
    procedure DBG_PesquisaTitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure Rg_FiltroClick(Sender: TObject);
    procedure Qr_ItensAfterOpen(DataSet: TDataSet);
    procedure E_Cd_BarrasKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_FaturarClick(Sender: TObject);
    procedure SB_ImprimirClick(Sender: TObject);
    procedure Sb_PesquisarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_Sair_1Click(Sender: TObject);
    procedure E_ConferenciaEnter(Sender: TObject);
    procedure DBG_ProdutosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure Sb_Pesq_EmpresaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    It_Cd_PedidoVda : Integer;
    It_Faturar : Boolean;
    It_Visualizar : Boolean;
    It_IMPRIMIR : Boolean;

  public
    { Public declarations }
    Pedido : TCOntrollerPedido;
    procedure Pc_ImagemBotao;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_AtivarTabelas;
    Procedure Pc_Buscar;
    procedure Pc_Visualizar;
    procedure Pc_PreencherPedido;
    procedure Pc_AtualizaConferencia;
    Function Fc_ValidaConferencia():Boolean;
    procedure Pc_EfetuarConferencia(Pc_Cd_Despacho:Integer;Pc_Qtde:Real);
    procedure Pc_ProcuraItem(Pc_Cd_Barras:String);
    function Fc_VerificaConferencia:Boolean;
    function Fc_ValidaFaturamento:Boolean;
  end;

var
  Fr_Conferente: TFr_Conferente;

implementation

uses     Un_DM, UN_Sistema, UN_Principal, env, UN_MSG, Un_Regra_Negocio, Un_Imp_Mod_Impressao, UN_Fatura_Vda, RN_Empresa, RN_NotaFiscal, UN_TabelasEmListas;
{$R *.dfm}

procedure TFr_Conferente.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Pesquisar.Glyph.Assign(Fc_CarregaImagemBotao('PESQUISAR'));
    SB_Faturar.Glyph.Assign(Fc_CarregaImagemBotao('FATURAR'));
    SB_Imprimir.Glyph.Assign(Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    SB_Buscar.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    SB_Visualizar.Glyph.Assign(Fc_CarregaImagemBotao('VISUALIZAR'));
    Sb_Sair_1.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Conferente.Pc_PermissaoBotao(Pc_Menu: string);
Begin
  If Gb_Nivel = 1 then
    Begin
    It_Faturar := True;
    It_Visualizar := True;
    It_IMPRIMIR   := true;
    end
  else
    Begin
    It_Faturar    := Fc_HabilitaPermissao(Pc_Menu,'FATURAR','S');
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    It_IMPRIMIR   := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    end;
end;

procedure TFr_Conferente.Pc_FormataTela;
Var
  Lc_X : Integer;
Begin
  Pc_ImagemBotao;
  For Lc_X:=1 to Pg_Conferente.PageCount do Pg_Conferente.Pages[Lc_X-1].TabVisible:=False;
  E_Data_Ini.Date := Date-30;
  E_Data_Fim.Date := Date;
  ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
  Pc_PermissaoBotao('Pedido de Venda');
end;

procedure TFr_Conferente.Pc_IniciaVariaveis;
Begin
  Pc_AtivarTabelas;
  Pg_Conferente.ActivePage := tbs_Pesquisa;
  DM_ListaConsultas.Pc_ListaVendedor;
end;

procedure TFr_Conferente.Pc_AtivarTabelas;
Begin
  DM_ListaConsultas.Pc_ListaVendedor;
end;

Procedure TFr_Conferente.Pc_Buscar;
Var
  Lc_Pedido : Boolean;
  Lc_Cliente : Boolean;
  Lc_SqlTxt : String;
Begin
  Lc_SqlTxt := '';
  Screen.Cursor:=crHourGlass;
  If (E_BuscaPedido.Text = '') then Lc_Pedido := False else Lc_Pedido := True;
  If (E_BuscaCliente.Text = '') then Lc_Cliente := False else Lc_Cliente := True;

  If DM.IB_Transacao.InTransaction then dm.IB_Transacao.CommitRetaining;
  Qr_Pesquisa.Close;
  Qr_Pesquisa.Sql.Clear;
  //Define Clausula Select
  Lc_SqlTxt := 'SELECT distinct PED_CODIGO, PED_DATA, PED_NUMERO, EMP_FANTASIA, '+
               ' PED_VL_PEDIDO, EMP_NOME, PED_CODMHA,CLB_NOME,EMP_CODIGO '+
               'FROM TB_PEDIDO tb_pedido '+
               '  INNER JOIN TB_EMPRESA tb_empresa '+
               '  ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP ) '+
               '  INNER JOIN TB_COLABORADOR tb_vendedor '+
               '  ON (tb_vendedor.CLB_CODIGO = tb_pedido.ped_codvdo) '+
               '  INNER JOIN TB_DESPACHO '+
               '  ON ( DSP_CODPED = PED_CODIGO) AND ( DSP_SITUACAO =''P'') '+
               'WHERE (PED_TIPO = 1) AND (PED_FATURADO = ''N'')  ';

  //Complementa a Clausula Where
  If ChBx_Periodo.Checked then
    Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_DATA BETWEEN :PED_DATAINI AND :PED_DATAFIM) ';

  If Lc_Pedido  then Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_NUMERO = :PED_NUMERO) ';
  If Lc_Cliente then Lc_SqlTxt := Lc_SqlTxt + 'AND ((EMP_FANTASIA LIKE :EMP_FANTASIA) OR (EMP_NOME LIKE :EMP_FANTASIA)) ';
  If Trim(Dblcb_Busca_Vendedor.Text)<> '' then
    Lc_SqlTxt := Lc_SqlTxt + 'AND ((PED_CODVDO =:PED_CODVDO)) ';

  Qr_Pesquisa.SQL.Add(Lc_SqlTxt + ' ORDER BY EMP_FANTASIA ');

  //Passsagem de Paramentos
  If Trim(Dblcb_Busca_Vendedor.Text)<> '' then
    Qr_Pesquisa.ParamByName('PED_CODVDO').AsInteger := Dblcb_Busca_Vendedor.KeyValue;

  If ChBx_Periodo.Checked then
    Begin
    Qr_Pesquisa.ParamByName('PED_DATAINI').AsDate :=E_Data_Ini.date;
    Qr_Pesquisa.ParamByName('PED_DATAFIM').AsDate := E_Data_Fim.Date;
    end;
  If Lc_Pedido then Qr_Pesquisa.ParamByName('PED_NUMERO').AsString := E_BuscaPedido.Text;
  If Lc_Cliente then Qr_Pesquisa.ParamByName('EMP_FANTASIA').AsString := '%'+E_BuscaCliente.Text+'%';

  Qr_Pesquisa.Open;
  Screen.Cursor:=crDefault;
  If ChBx_Busca_Nome.Checked then
    ChBx_Busca_NomeClick(SELF)
  else
  If ChBx_Busca_Fantasia.Checked then
    ChBx_Busca_FantasiaClick(SELF);
end;

procedure TFr_Conferente.Pc_PreencherPedido;
Begin
  E_Nr_Pedido.Text := Qr_Pesquisa.FieldByName('PED_NUMERO').AsString;
  E_Data.Text := Qr_Pesquisa.FieldByName('PED_DATA').AsString;
  E_Cliente.Text := Qr_Pesquisa.FieldByName('EMP_FANTASIA').AsString;
  E_Vendedor.Text := Qr_Pesquisa.FieldByName('CLB_NOME').AsString;
end;

procedure TFr_Conferente.Pc_AtualizaConferencia;
Begin
  with Qr_Itens do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT distinct '+
            '  DSP.DSP_CODIGO, '+
            '  PRO_CODIGO, '+
            '  PRO_CODIGOFAB, '+
            '  PRO_CODIGOBAR, '+
            '  PRO_DESCRICAO, '+
            '  DSP_DT_PREVISTA, '+
            '  DSP.DSP_CONFERIDO, '+
            '  ITF.ITF_CODIGO, '+
            '  ITF.ITF_CODPED, '+
            '  ITF.ITF_CODPRO, '+
            '  ITF.ITF_QTDE, '+
            '  ITF.ITF_VL_UNIT, '+
            '  ((ITF.ITF_QTDE * ITF.ITF_VL_UNIT) - ITF.ITF_VL_DESC) ITF_VL_TOTAL, '+
            '  ( ITF.ITF_QTDE - DSP.DSP_CONFERIDO) Saldo '+
            'FROM TB_ITENS_NFL ITF '+
            '  INNER JOIN TB_DESPACHO DSP '+
            '  ON (DSP.DSP_CODITF = ITF.ITF_CODIGO) '+
            '  INNER JOIN TB_PRODUTO PRO '+
            '  ON (ITF.ITF_CODPRO = PRO.PRO_CODIGO) '+
            'WHERE (ITF_CODPED =:PED_CODIGO) AND (PRO_TIPO <> ''S'') ');

    case Rg_Filtro.ItemIndex of
      0:SQL.Add(' AND (DSP.DSP_CONFERIDO < ITF.ITF_QTDE) ');
      1:SQL.Add(' AND (DSP.DSP_CONFERIDO = ITF.ITF_QTDE) ');
    end;

    SQL.Add('order by PRO_DESCRICAO ');
    ParamByName('PED_CODIGO').AsInteger := Qr_Pesquisa.FieldByName('PED_CODIGO').AsInteger;
    Active := True;
    end;
end;

Function TFr_Conferente.Fc_ValidaConferencia():Boolean;
Begin
  Result := true;
  if Qr_Itens.RecordCount = 0 then
    Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Não há itens para conferir.'+EOLN+
                   'Verifique e tente novamente' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := false;
    E_Cd_Barras.SetFocus;
    exit;
    end;

  if StrToFloatDef(E_Conferencia.Text,0)=0 then
    Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Quantidade da conferência não informada.'+EOLN+
                   'Verifique e tente novamente' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := false;
    E_Conferencia.SetFocus;
    exit;
    end;

  if StrToFloatDef(E_Conferencia.Text,0)> Qr_Itens.FieldByName('SALDO').AsCurrency then
    Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Quantidade informada maior do que o Saldo.'+EOLN+
                   'Verifique e tente novamente' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := false;
    exit;
    end;

end;

procedure TFr_Conferente.Pc_EfetuarConferencia(Pc_Cd_Despacho:Integer;Pc_Qtde:Real);
Begin
  with Qr_Conferir do
    Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    ParamByName('DSP_CONFERIDO').AsFloat := Pc_Qtde;
    ParamByName('DSP_CODIGO').AsInteger := Pc_Cd_Despacho;
    ExecSQL;
    if Transaction.InTransaction then Transaction.CommitRetaining;
    end;
end;

procedure TFr_Conferente.Pc_ProcuraItem(Pc_Cd_Barras:String);
Begin
  with Qr_Itens do
    Begin
    Active := True;
    First;
    if (Locate('PRO_CODIGOBAR',Pc_Cd_Barras,[])) then
      Begin
      if Fc_ValidaConferencia then
        Begin
        Pc_EfetuarConferencia(Qr_Itens.FieldByName('DSP_CODIGO').AsInteger,StrToFloatDef(E_Conferencia.Text,1)); ;
        E_Conferencia.Text := '1';
        E_Cd_Barras.Clear;
        Pc_AtualizaConferencia;
        end;
      end
    else
      Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Item não localizado.'+EOLN+
                     'Verifique e tente novamente' +EOLN,
                     ['OK'], [bEscape], mpAlerta);
      end;
    end;
end;

function TFr_Conferente.Fc_VerificaConferencia:Boolean;
Begin
  Result := True;
  Rg_Filtro.ItemIndex := 2;
  with Qr_Itens do
    Begin
    First;
    while not eof do
      Begin
      if (Qr_Itens.FieldByName('SALDO').AsCurrency > 0) then
        Begin
        Result := False;
        break;
        end;
      next;
      end;
    end;
end;

function TFr_Conferente.Fc_ValidaFaturamento:Boolean;
Begin
  Result := true;

  if not Fc_VerificaConferencia then
    Begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Existem itens sem conferir.' + EOLN +
                   'Verifique e tente novamente.' + EOLN ,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
    end;

  pedido.Registro.Codigo := Qr_Pesquisa.FieldByName('PED_CODIGO').AsInteger;
  if not pedido.VerificaFaturado(True) then
    Begin
    Result := False;
    Pg_Conferente.ActivePage := tbs_Pesquisa;
    exit;
    end;

end;

procedure TFr_Conferente.Pc_Visualizar;
Begin
  If Qr_Pesquisa.RecordCount > 0 then
  Begin
    It_Cd_PedidoVda := Qr_Pesquisa.FieldByName('PED_CODIGO').AsInteger;
    Pc_AtivarTabelas;
    Pg_Conferente.ActivePageIndex := 0;
    Pc_PreencherPedido;
    Pc_AtualizaConferencia;
    E_Cd_Barras.SetFocus;
  end;
end;

procedure TFr_Conferente.SB_BuscarClick(Sender: TObject);
begin
  Pc_Buscar;
end;

procedure TFr_Conferente.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Conferente.ChBx_Busca_NomeClick(Sender: TObject);
begin
  If ChBx_Busca_Nome.Checked then
    Begin
    ChBx_Busca_Fantasia.Checked := False;
    if not Qr_Pesquisa.Active then exit;
    DBG_Pesquisa.Columns[2].Title.Caption := 'Nome/Razão Social';
    DBG_Pesquisa.Columns[2].FieldName := 'EMP_NOME';
    end;
end;

procedure TFr_Conferente.ChBx_Busca_FantasiaClick(Sender: TObject);
begin
  If ChBx_Busca_Fantasia.Checked then
    Begin
    ChBx_Busca_Nome.Checked := False;
    if not Qr_Pesquisa.Active then exit;
    DBG_Pesquisa.Columns[2].Title.Caption := 'Nome Fantasia';
    DBG_Pesquisa.Columns[2].FieldName := 'EMP_FANTASIA';
  end;
end;

procedure TFr_Conferente.SB_VisualizarClick(Sender: TObject);
begin
  Pc_Visualizar;
end;

procedure TFr_Conferente.DBG_PesquisaDblClick(Sender: TObject);
begin
  Pc_Visualizar;
end;

procedure TFr_Conferente.DBG_PesquisaTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(DBG_Pesquisa, Column);
end;

procedure TFr_Conferente.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_IniciaVariaveis;
end;

procedure TFr_Conferente.Rg_FiltroClick(Sender: TObject);
begin
  Pc_AtualizaConferencia;
end;

procedure TFr_Conferente.Qr_ItensAfterOpen(DataSet: TDataSet);
begin
  Qr_Itens.FetchAll;
end;

procedure TFr_Conferente.E_Cd_BarrasKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
  Begin
    if Trim(E_Cd_Barras.Text)<> '' then
      Pc_ProcuraItem(E_Cd_Barras.Text);
  end;
end;

procedure TFr_Conferente.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Conferente.SB_FaturarClick(Sender: TObject);
Var
  Lc_Form : TFr_Fatura_Vda;
  Lc_Faturado_Ok : Boolean;
begin
  if Fc_ValidaFaturamento then
  Begin
    Lc_Form := TFr_Fatura_Vda.Create(Fr_Conferente);
    Lc_Form.It_Cd_Pedido := Qr_Itens.FieldByName('ITF_CODPED').AsInteger;
    Lc_Form.ShowModal;
    Lc_Faturado_Ok := Lc_Form.it_fatura_ok;
    if Lc_Faturado_Ok then
    Begin
      IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
      Pg_Conferente.ActivePage := tbs_Pesquisa;
      Pc_Buscar;
    end;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Conferente.SB_ImprimirClick(Sender: TObject);
var
  Lc_Imp : TimpModImpressao;
begin
  Try
    Lc_Imp := TimpModImpressao.create(nil);
    Lc_Imp.Pc_Imp_Conferencia(Qr_Itens.FieldByName('ITF_CODPED').AsInteger);
  Finally
    FreeandNil(Lc_Imp);
  end;
end;

procedure TFr_Conferente.Sb_PesquisarClick(Sender: TObject);
begin
  Pg_Conferente.ActivePage := tbs_Pesquisa;
end;

procedure TFr_Conferente.FormCreate(Sender: TObject);
begin
  pedido := TControllerPedido.Create(Self);
end;

procedure TFr_Conferente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case Pg_Conferente.ActivePageIndex of
  0:Begin
    If shIft = [] then
      Begin
        case Key of
        VK_F2  : E_Conferencia.SetFocus;
        VK_F7  : If SB_Pesquisar.Enabled then SB_PesquisarClick(Sender);
        VK_F10  : If SB_Faturar.Enabled then SB_FaturarClick(Sender);
        VK_F11  : If SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
        VK_Escape : If Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
        end;
      end;
    end
  else
    Begin
    If shIft = [] then
      Begin
      case Key of
      VK_F7  : If SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_F8 : If SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
      VK_Escape : If Sb_Sair_1.Enabled then Sb_Sair_1Click(Sender);
      end;
      end;
    end;
  end;

end;

procedure TFr_Conferente.Sb_Sair_1Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Conferente.E_ConferenciaEnter(Sender: TObject);
begin
  E_Conferencia.SelectAll;
end;

procedure TFr_Conferente.DBG_ProdutosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if Rg_Filtro.ItemIndex = 2 then
    Begin
    if Ds_Itens.DataSet.FieldByName('SALDO').AsCurrency > 0 then
      DBG_Produtos.Canvas.Font.Color := clRed;
    DBG_Produtos.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    end;
end;

procedure TFr_Conferente.Sb_Pesq_EmpresaClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(1,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_Cliente.Text := Lc_Retorno.It_Dados[1,1];
  end;
end;

end.
