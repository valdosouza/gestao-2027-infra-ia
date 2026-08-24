unit Un_Pesq_NotaFiscal;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Un_Fm_ListaMultiEmpresa, Vcl.DBCtrls, QEdit_Setes, Vcl.ComCtrls, base_frame_list, un_fm_lista_cfop;


type
  TFr_Pesq_NotaFiscal = class(TForm)
    GroupBox1: TGroupBox;
    Label33: TLabel;
    Label42: TLabel;
    E_BuscaRazao: TMaskEdit;
    E_BuscaObs: TMaskEdit;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Panel4: TPanel;
    DBG_Pesquisa: TDBGrid;
    Label21: TLabel;
    Label49: TLabel;
    E_BuscaBairro: TMaskEdit;
    E_BuscaRegiao: TMaskEdit;
    E_BuscaEstado: TMaskEdit;
    E_BuscaCidade: TMaskEdit;
    Label23: TLabel;
    Label47: TLabel;
    E_BuscaFone: TEdit_Setes;
    Dblcb_BuscaVendedor: TDBLookupComboBox;
    Ds_Pesquisa: TDataSource;
    Qr_Pesquisa: TSTQuery;
    Label2: TLabel;
    RG_Tipo_Operacao: TRadioGroup;
    Label36: TLabel;
    Label37: TLabel;
    L_CodigoCliente: TLabel;
    E_BuscaNota: TMaskEdit;
    E_BuscaPedido: TMaskEdit;
    E_BuscaEmpresa: TEdit;
    ChBx_Periodo: TCheckBox;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    Rg_Sit_Nfe: TRadioGroup;
    Fm_LME: TFm_ListaMultiEmpresa;
    Rg_Tipo_Nota: TGroupBox;
    ChBx_Vendas: TCheckBox;
    ChBx_Compras: TCheckBox;
    ChBx_Ajustes: TCheckBox;
    Label1: TLabel;
    E_BuscaSerie: TMaskEdit;
    Panel1: TPanel;
    SB_Buscar: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    Lb_TotalVendas: TLabel;
    E_TotalVenda: TLabel;
    Lb_NumeroVendas: TLabel;
    E_NumeroVendas: TLabel;
    Lb_TicketMedia: TLabel;
    E_TicketMedia: TLabel;
    ChBx_Venda_Numerada: TCheckBox;
    Pg_Resultado: TPageControl;
    tbs_resultado: TTabSheet;
    tbs_resumo: TTabSheet;
    Fm_lista_cfop: TFm_lista_cfop;
    procedure SB_BuscarClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure Dblcb_BuscaVendedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBG_PesquisaTitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure DBG_PesquisaDblClick(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure RG_Tipo_OperacaoClick(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);

  protected
    function fc_Valida_Visualizacao(): Boolean; Virtual;
    procedure Pc_Visualizar; Virtual;
    procedure Pc_IniciaVariaveis; Virtual;
    procedure Pc_AtivarTabelas; Virtual;

    procedure FeaturesPesquisa; Virtual;
    procedure Pc_FormataTela; Virtual;

    procedure VerificaParametros; Virtual;
    procedure Buscar; Virtual;
    procedure SelectSql; Virtual;
    procedure InnerJoinSql; Virtual;
    procedure WhereSql; Virtual;
    procedure OrderBySql; Virtual;
    procedure PassarParametros(Qry: TSTQuery); Virtual;
  private
    { Private declarations }
    It_Supervisor: Boolean;
  public
    { Public declarations }

    IndGrid: Integer;
    SelectTxt: String;
    InnerJoinTxt: String;
    WhereTxt: String;
    UnionSelectTxt: String;
    UnionInnerJoinTxt: String;
    UnionWhereTxt: String;
    OrderByTxt: String;
    procedure Pc_ImagemBotao;
    procedure SomaNotas(Campo: String);
  end;

var
  Fr_Pesq_NotasFiscais: TFr_Pesq_NotaFiscal;
  It_Nota, onlyNnumbered, It_Serie, It_Pedido, It_Cd_Empresa, It_Razao,
    It_Bairro, It_Regiao, It_Estado, It_Cidade, It_Fone, It_Vendedor, It_Obs,
    It_CFOP: Boolean;

implementation

uses     UN_Sistema, Un_DM, UN_Principal, env, Un_Funcoes, UN_TabelasEmListas, RN_NotaFiscal, UN_MSG, RN_Permissao, Un_Regra_Negocio, tas_processamento;
{$R *.dfm}

procedure TFr_Pesq_NotaFiscal.Pc_IniciaVariaveis;
Begin
  Pg_Resultado.ActivePage := tbs_resultado;
  Fm_LME.Listar('EMP_NOME');
  Fm_LME.HabilitarMultiEmpresa;
  E_Data_Ini.DateTime := Date;
  E_Data_Fim.DateTime := Date;
  ChBx_Vendas.Checked := False;
  ChBx_Vendas.Enabled := False;
  ChBx_Compras.Checked := False;
  ChBx_Compras.Enabled := False;
  ChBx_Ajustes.Checked := False;
  ChBx_Ajustes.Enabled := False;
  if Fc_VerificaPermissao('Fr_Pesq_NF_Pro', 'Notas Fiscais de Produtos',
    'CONSULTA VENDAS', GB_Cd_Usuario, 'N') then
    ChBx_Vendas.Enabled := True;
  if Fc_VerificaPermissao('Fr_Pesq_NF_Pro', 'Notas Fiscais de Produtos',
    'CONSULTA COMPRAS', GB_Cd_Usuario, 'N') then
    ChBx_Compras.Enabled := True;
  if Fc_VerificaPermissao('Fr_Pesq_NF_Pro', 'Notas Fiscais de Produtos',
    'CONSULTA AJUSTES', GB_Cd_Usuario, 'N') then
    ChBx_Ajustes.Enabled := True;

  if ChBx_Vendas.Enabled then
    ChBx_Vendas.Checked := True
  else if ChBx_Compras.Enabled then
    ChBx_Compras.Checked := True
  else if ChBx_Ajustes.Enabled then
    ChBx_Ajustes.Checked := True;

  It_Supervisor := Fc_VerificaPermissao('Fr_Nota_Fiscal',
    'Notas Fiscais de Venda', 'SUPERVISOR', GB_Cd_Usuario, 'N');
  if It_Supervisor then
  BEgin
    Lb_TotalVendas.Visible := True;
    E_TotalVenda.Visible := True;
    Lb_NumeroVendas.Visible := True;
    E_NumeroVendas.Visible := True;
    Lb_TicketMedia.Visible := True;
    E_TicketMedia.Visible := True;
  end
  else
  Begin
    Lb_TotalVendas.Visible := False;
    E_TotalVenda.Visible := False;
    Lb_NumeroVendas.Visible := False;
    E_NumeroVendas.Visible := False;
    Lb_TicketMedia.Visible := False;
    E_TicketMedia.Visible := False;
  end;
end;

procedure TFr_Pesq_NotaFiscal.Pc_AtivarTabelas;
Begin
  Fm_lista_cfop.Sentido := '';
  Fm_lista_cfop.Alcada := '';
  Fm_lista_cfop.Listar;
  DM_ListaConsultas.Pc_ListaVendedor;
end;

procedure TFr_Pesq_NotaFiscal.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    CarregaImagemBotao(SB_Buscar, 'BUSCAR');
    CarregaImagemBotao(SB_Visualizar, 'VISUALIZAR');
    CarregaImagemBotao(SB_Sair_0, 'SAIR');
  END;
end;

Procedure TFr_Pesq_NotaFiscal.VerificaParametros;
Begin
  if Trim(E_BuscaNota.Text) = '' then
    It_Nota := False
  else
    It_Nota := True;
  if Trim(E_BuscaSerie.Text) = '' then
    It_Serie := False
  else
    It_Serie := True;
  if Trim(E_BuscaPedido.Text) = '' then
    It_Pedido := False
  else
    It_Pedido := True;
  if Trim(E_BuscaEmpresa.Text) = '' then
    It_Cd_Empresa := False
  else
    It_Cd_Empresa := True;
  if Trim(E_BuscaRazao.Text) = '' then
    It_Razao := False
  else
    It_Razao := True;
  if Trim(E_BuscaBairro.Text) = '' then
    It_Bairro := False
  else
    It_Bairro := True;
  if Trim(E_BuscaRegiao.Text) = '' then
    It_Regiao := False
  else
    It_Regiao := True;
  if Trim(E_BuscaEstado.Text) = '' then
    It_Estado := False
  else
    It_Estado := True;
  if Trim(E_BuscaCidade.Text) = '' then
    It_Cidade := False
  else
    It_Cidade := True;
  IF Trim(E_BuscaFone.Text) = '' then
    It_Fone := False
  else
    It_Fone := True;
  if Trim(Dblcb_BuscaVendedor.Text) = '' then
    It_Vendedor := False
  else
    It_Vendedor := True;
  IF Trim(E_BuscaObs.Text) = '' then
    It_Obs := False
  else
    It_Obs := True;
  if Trim( Fm_lista_cfop.Dblcb_Lista.Text) = '' then
    It_CFOP := False
  else
    It_CFOP := True;
  onlyNnumbered := ChBx_Venda_Numerada.Checked;
end;

procedure TFr_Pesq_NotaFiscal.PassarParametros(Qry: TSTQuery);
Begin
  with Qry do
  Begin
    if (Trim(Fm_LME.Dblcb_Lista.Text) <> '') then
      ParamByName('NFL_CODMHA').AsInteger := Fm_LME.Dblcb_Lista.KeyValue;

    if ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    end;

    if It_Serie then
      ParamByName('NFL_SERIE').AsString := E_BuscaSerie.Text;

    if It_Pedido then
      ParamByName('PED_NUMERO').AsInteger := StrToIntDef(E_BuscaPedido.Text, 0);
    if It_Cd_Empresa then
      ParamByName('EMP_CODIGO').AsInteger :=
        StrToIntDef(E_BuscaEmpresa.Text, 0);
    if It_Razao then
      ParamByName('EMP_NOME').AsString := '%' + Copy(E_BuscaRazao.Text, 1,
        98) + '%';
    if It_Bairro then
      ParamByName('END_BAIRRO').AsString := '%' + E_BuscaBairro.Text + '%';
    if It_Regiao then
      ParamByName('END_REGIAO').AsString := '%' + E_BuscaRegiao.Text + '%';
    if It_Estado then
      ParamByName('UFE_SIGLA').AsString := E_BuscaEstado.Text;
    if It_Cidade then
      ParamByName('CDD_DESCRICAO').AsString := '%' + E_BuscaCidade.Text + '%';
    if It_Fone then
      ParamByName('END_FONE').AsString := '%' + Fc_RemoveCaracterInformado
        (E_BuscaFone.Text, ['(', ')', ' ', '-', '-']);
    if It_Vendedor then
      ParamByName('PED_CODVDO').AsInteger := Dblcb_BuscaVendedor.KeyValue;
    if It_Obs then
      ParamByName('OBN_DETALHE').AsString := '%' + E_BuscaObs.Text + '%';
    if It_CFOP then
      ParamByName('NAT_CODIGO').AsInteger := Fm_lista_cfop.Dblcb_Lista.KeyValue;
  end;
end;

procedure TFr_Pesq_NotaFiscal.FeaturesPesquisa;
begin
  if ChBx_Fantasia.Checked then
  begin
    DBG_Pesquisa.Columns.Items[IndGrid].Title.Caption :=
      'Nome Fantasia/Apelido/Codnome';
    DBG_Pesquisa.Columns.Items[IndGrid].FieldName := 'EMP_FANTASIA'
  end
  else
  begin
    DBG_Pesquisa.Columns.Items[IndGrid].Title.Caption := 'Nome/Razão Social';
    DBG_Pesquisa.Columns.Items[IndGrid].FieldName := 'EMP_NOME';
  end;
end;

procedure TFr_Pesq_NotaFiscal.Pc_FormataTela;
begin
  // Sera implementado
end;

procedure TFr_Pesq_NotaFiscal.Buscar;
Begin
  with Qr_Pesquisa do
  Begin
    VerificaParametros;
    IF Transaction.InTransaction then
      Transaction.Commit;
    IF not Transaction.InTransaction then
      Transaction.StartTransaction;
    Active := False;
    sql.Clear;
    SelectTxt := '';
    InnerJoinTxt := '';
    WhereTxt := '';
    UnionSelectTxt := '';
    UnionInnerJoinTxt := '';
    UnionWhereTxt := '';
    OrderByTxt := '';
    SelectSql;
    InnerJoinSql;
    WhereSql;
    OrderBySql;
    sql.Add(SelectTxt);
    sql.Add(InnerJoinTxt);
    sql.Add(WhereTxt);
    if Trim(UnionSelectTxt) <> '' then
    Begin
      sql.Add(' Union ');
      sql.Add(UnionSelectTxt);
    End;
    if Trim(UnionInnerJoinTxt) <> '' then
      sql.Add(UnionInnerJoinTxt);
    if Trim(UnionWhereTxt) <> '' then
      sql.Add(UnionWhereTxt);
    sql.Add(OrderByTxt);
    PassarParametros(Qr_Pesquisa);
    FeaturesPesquisa;
    Active := True;
    FetchAll;
    First;
    tbs_resultado.Caption := 'Resultado da pesquisa : ' + IntTostr(recordCount)
      + ' registro(s)';
  End;
end;

function TFr_Pesq_NotaFiscal.fc_Valida_Visualizacao(): Boolean;
Begin
  Result := True;
  if not Qr_Pesquisa.Active then
  Begin
    MensagemPadrao('Mensagem ', 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
      'Nenhuma pesquisa foi efetuada.' + EOLN + 'Verifique antes de continuar.'
      + EOLN, ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
  end;

  if Qr_Pesquisa.recordCount = 0 then
  Begin
    MensagemPadrao('Mensagem ', 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
      'Não há registro para visualizar.' + EOLN +
      'Verifique antes de continuar.' + EOLN, ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
  end;

  if Qr_Pesquisa.FieldByNAme('PED_CODVDO').AsInteger > 0 then
  Begin
    if Gb_Nivel = 0 then
    Begin
      if (Fc_Tb_Geral('L', 'VDA_G_SO_VENDEDOR_VISUALIZA', 'N') = 'S') then
      Begin
        if (Qr_Pesquisa.FieldByNAme('PED_CODVDO').AsInteger <> GB_Cd_Vendedor)
          and (GB_Cd_Vendedor > 0) then
        Begin
          MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
            'Somente o próprio vendedor pode visualizar este pedido.' + EOLN +
            'Verifique antes para continuar.' + EOLN, ['OK'],
            [bEscape], mpErro);
          Result := False;
          exit;
        End;
      End;
    End;
  End;
end;

procedure TFr_Pesq_NotaFiscal.Pc_Visualizar;
Begin
  // Implementação nas telas que herdaram

end;

procedure TFr_Pesq_NotaFiscal.SB_BuscarClick(Sender: TObject);

begin
  try
    Pc_ProcesoAguarde(Self, 'I');
    Buscar;
  finally
    Pc_ProcesoAguarde(Self, 'F');
  end;
end;

procedure TFr_Pesq_NotaFiscal.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Pesq_NotaFiscal.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Pesq_NotaFiscal.Dblcb_BuscaVendedorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
        begin
          Dblcb_BuscaVendedor.KeyValue := Null;
        end;
    end;
end;

procedure TFr_Pesq_NotaFiscal.DBG_PesquisaTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(DBG_Pesquisa, Column);
end;

procedure TFr_Pesq_NotaFiscal.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_AtivarTabelas;
  Pc_IniciaVariaveis;
  Pc_ImagemBotao;
end;

procedure TFr_Pesq_NotaFiscal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not((ActiveControl is TDBMemo) OR (ActiveControl is TMemo))
  then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFr_Pesq_NotaFiscal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
  begin
    case Key of
      VK_F7:
        if SB_Buscar.Enabled then
          SB_BuscarClick(Sender);
      VK_F8:
        if SB_Visualizar.Enabled then
          SB_VisualizarClick(Sender);
      VK_Escape:
        if SB_Sair_0.Enabled then
          SB_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_Pesq_NotaFiscal.SB_VisualizarClick(Sender: TObject);
beGIN
  if fc_Valida_Visualizacao then
  Begin
    Pc_Visualizar;
  end;
end;

procedure TFr_Pesq_NotaFiscal.SelectSql;
begin
  //
end;

procedure TFr_Pesq_NotaFiscal.SomaNotas(Campo: String);
Var
  Lc_Valor: Real;
begin
  with Qr_Pesquisa do
  Begin
    DBG_Pesquisa.Visible := False;
    First;
    Lc_Valor := 0;
    while not eof do
    Begin
      Lc_Valor := Lc_Valor + FieldByNAme(Campo).AsFloat;
      Next;
    End;
    First;
    DBG_Pesquisa.Visible := True;
    E_TotalVenda.Caption := FloatToStrF(Lc_Valor, ffNumber, 10, 2);
    E_NumeroVendas.Caption := IntTostr(recordCount);
    if (recordCount > 0) then
      Lc_Valor := Lc_Valor / recordCount
    else
      Lc_Valor := 0;
    E_TicketMedia.Caption := FloatToStrF(Lc_Valor, ffNumber, 10, 2);
  End;
end;

procedure TFr_Pesq_NotaFiscal.InnerJoinSql;
begin
  //
end;

procedure TFr_Pesq_NotaFiscal.WhereSql;
begin
  WhereTxt := WhereTxt + 'WHERE (NFL_CODIGO IS NOT NULL) ';

  if (Trim(Fm_LME.Dblcb_Lista.Text) <> '') then
    WhereTxt := WhereTxt + ' AND (NFL_CODMHA =:NFL_CODMHA) ';

  if It_Serie then
    WhereTxt := WhereTxt + 'AND NFL_SERIE =:NFL_SERIE  ';

  if It_Pedido then
    WhereTxt := WhereTxt + 'AND PED_NUMERO =:PED_NUMERO ';

  if It_Cd_Empresa then
    WhereTxt := WhereTxt + 'AND NFL_CODEMP =:EMP_CODIGO ';
  if It_Razao then
    WhereTxt := WhereTxt +
      'AND ( (EMP_NOME LIKE :EMP_NOME) or (EMP_FANTASIA LIKE :EMP_NOME) )  ';
  if It_Bairro then
    WhereTxt := WhereTxt + 'AND END_BAIRRO LIKE :END_BAIRRO ';
  if It_Regiao then
    WhereTxt := WhereTxt + 'AND END_REGIAO LIKE :END_REGIAO ';
  if It_Estado then
    WhereTxt := WhereTxt + 'AND UFE_SIGLA =:UFE_SIGLA ';
  if It_Cidade then
    WhereTxt := WhereTxt + 'AND CDD_DESCRICAO LIKE :CDD_DESCRICAO ';
  if It_Fone then
    WhereTxt := WhereTxt +
      'AND ((END_FONE LIKE :END_FONE) OR (END_FAX LIKE :END_FONE) OR (END_CELULAR LIKE :END_FONE)) ';
  if It_Vendedor then
    WhereTxt := WhereTxt + 'AND PED_CODVDO =:PED_CODVDO ';
  if It_CFOP then
    WhereTxt := WhereTxt + 'AND (NFL_CODNAT =:NAT_CODIGO) ';
  if It_Obs then
    WhereTxt := WhereTxt + 'AND (OBN_DETALHE LIKE :OBN_DETALHE) ';
  if ChBx_Periodo.Checked then
    WhereTxt := WhereTxt +
      ' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ';

end;

procedure TFr_Pesq_NotaFiscal.OrderBySql;
begin
  OrderByTxt := OrderByTxt + ' ORDER BY EMP_FANTASIA';
end;

procedure TFr_Pesq_NotaFiscal.DBG_PesquisaDblClick(Sender: TObject);
begin
  if fc_Valida_Visualizacao then
  Begin
    Pc_Visualizar;
  end;
end;

procedure TFr_Pesq_NotaFiscal.ChBx_NomeClick(Sender: TObject);
begin
  IF ChBx_Nome.Checked THEN
  Begin
    ChBx_Fantasia.Checked := False;
    DBG_Pesquisa.Columns.Items[IndGrid].Title.Caption := 'Nome/Razão Social';
    DBG_Pesquisa.Columns.Items[IndGrid].FieldName := 'EMP_NOME';
  end;
end;

procedure TFr_Pesq_NotaFiscal.ChBx_FantasiaClick(Sender: TObject);
Var
  Lc_Coluna: Integer;
begin
  IF ChBx_Fantasia.Checked THEN
  Begin
    ChBx_Nome.Checked := False;
    DBG_Pesquisa.Columns.Items[IndGrid].Title.Caption :=
      'Fantasia/Apelido/Codnome';
    DBG_Pesquisa.Columns.Items[IndGrid].FieldName := 'EMP_FANTASIA'
  end;
end;

procedure TFr_Pesq_NotaFiscal.RG_Tipo_OperacaoClick(Sender: TObject);
begin
  Fm_lista_cfop.Sentido := '';
  Fm_lista_cfop.Alcada  := '';
  case RG_Tipo_Operacao.ItemIndex of
    0:Fm_lista_cfop.Sentido := 'E';
    1:Fm_lista_cfop.Sentido := 'S';
  end;
  Fm_lista_cfop.Listar;
end;

end.
