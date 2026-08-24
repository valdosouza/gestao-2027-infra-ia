unit Un_Prod_Confeccao;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Grids, DBGrids, Mask, Buttons, DB, STQuery, DBClient;

type
  TFr_Prod_Confeccao = class(TForm)
    Ds_ItensPrd: TDataSource;
    Ds_Producao: TDataSource;
    Ds_Retorno_Prd: TDataSource;
    Pg_Tarefas: TPageControl;
    TabSheet1: TTabSheet;
    Panel2: TPanel;
    DBG_Producao: TDBGrid;
    E_Data_Prd_Ini: TDateTimePicker;
    E_Data_Prd_fim: TDateTimePicker;
    ChBx_Data_Producao: TCheckBox;
    E_BuscaFornecedor: TMaskEdit;
    ChBx_Nome_For: TCheckBox;
    ChBx_Fantasia_For: TCheckBox;
    E_Data_Prz_Ini: TDateTimePicker;
    E_Data_Prz_Fim: TDateTimePicker;
    ChBx_Data_Prazo: TCheckBox;
    TabSheet2: TTabSheet;
    Panel3: TPanel;
    DBG_Retorno: TDBGrid;
    E_Data_Env_Ini: TDateTimePicker;
    E_Data_Env_Fim: TDateTimePicker;
    ChBx_Data_Envio: TCheckBox;
    E_BuscaFornecedor_2: TMaskEdit;
    ChBx_Nome_For_2: TCheckBox;
    ChBx_Fantasia_For_2: TCheckBox;
    E_Data_Ret_Ini: TDateTimePicker;
    E_Data_Ret_Fim: TDateTimePicker;
    ChBx_Data_Retorno: TCheckBox;
    SB_Ins_Tarefa_1: TSpeedButton;
    SB_Alt_Tarefa: TSpeedButton;
    SB_Exc_Tarefa: TSpeedButton;
    SB_Ret_Tarefa: TSpeedButton;
    Sb_Buscar_1: TSpeedButton;
    Sb_Sair_1: TSpeedButton;
    SB_Imp_Romaneio: TSpeedButton;
    Sb_Ins_Retorno: TSpeedButton;
    Sb_Alt_Retorno: TSpeedButton;
    Sb_Exc_Retorno: TSpeedButton;
    Sb_Buscar_2: TSpeedButton;
    Sb_Sair_2: TSpeedButton;
    SB_Imp_Retorno: TSpeedButton;
    Qr_ItensPrd: TSTQuery;
    Qr_Producao: TSTQuery;
    Qr_Retorno_Prd: TSTQuery;
    tbs_producao: TTabSheet;
    Panel4: TPanel;
    DBG_Itens_Prd: TDBGrid;
    E_Data_Ped_Ini: TDateTimePicker;
    E_Data_Ped_Fim: TDateTimePicker;
    ChBx_Data_Pedido: TCheckBox;
    E_BuscaCliente: TMaskEdit;
    ChBx_Nome_Cli: TCheckBox;
    ChBx_Fantasia_Cli: TCheckBox;
    E_Data_Ent_Ini: TDateTimePicker;
    E_Data_Ent_Fim: TDateTimePicker;
    ChBx_Data_Entrega: TCheckBox;
    Sb_Buscar_0: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    SB_Ins_Tarefa_0: TSpeedButton;
    Chbx_ProdutoParaProducao: TCheckBox;
    Chbx_FornecedorParaRetorno: TCheckBox;
    Qr_Retorno_PrdRPC_CODIGO: TIntegerField;
    Qr_Retorno_PrdPCF_CODIGO: TIntegerField;
    Qr_Retorno_PrdPCF_ROMANEIO: TStringField;
    Qr_Retorno_PrdPRO_DESCRICAO: TStringField;
    Qr_Retorno_PrdPCF_DT_ENTREGA: TDateField;
    Qr_Retorno_PrdRPC_QTDE: TBCDField;
    Qr_Retorno_PrdRPC_DT_RETORNO: TDateField;
    Qr_Retorno: TSTQuery;
    Qr_ItensPrdPED_NUMERO: TIntegerField;
    Qr_ItensPrdPRO_DESCRICAO: TStringField;
    Qr_ItensPrdITF_QTDE: TBCDField;
    Qr_ItensPrdGRT_TAMANHO: TStringField;
    Qr_ItensPrdGRT_QTDE: TBCDField;
    Qr_ItensPrdEMP_NOME: TStringField;
    Qr_ItensPrdEMP_FANTASIA: TStringField;
    Qr_ItensPrdPED_CODIGO: TIntegerField;
    Qr_ItensPrdGRT_CODIGO: TIntegerField;
    Qr_ItensPrdPED_DT_ENTREGA: TDateField;
    Qr_RetornoRPC_TOTAL: TBCDField;
    Qr_ProducaoPCF_CODIGO: TIntegerField;
    Qr_ProducaoPCF_ROMANEIO: TStringField;
    Qr_ProducaoPCF_DATA: TDateField;
    Qr_ProducaoPCF_CODFOR: TIntegerField;
    Qr_ProducaoEMP_NOME: TStringField;
    Qr_ProducaoPCF_CODSRV: TIntegerField;
    Qr_ProducaoPRO_DESCRICAO: TStringField;
    Qr_ProducaoPCF_VL_UNIT: TFMTBCDField;
    Qr_ProducaoPCF_QTDE: TBCDField;
    Qr_ProducaoPCF_VL_SUBTOTAL: TFMTBCDField;
    Qr_ProducaoPCF_DT_ENTREGA: TDateField;
    procedure ChBx_Data_PedidoClick(Sender: TObject);
    procedure ChBx_Data_EntregaClick(Sender: TObject);
    procedure ChBx_Nome_CliClick(Sender: TObject);
    procedure ChBx_Fantasia_CliClick(Sender: TObject);
    procedure SB_Ins_Tarefa_1Click(Sender: TObject);
    procedure SB_Alt_TarefaClick(Sender: TObject);
    procedure Sb_Sair_1Click(Sender: TObject);
    procedure SB_Exc_TarefaClick(Sender: TObject);
    procedure ChBx_Data_ProducaoClick(Sender: TObject);
    procedure ChBx_Data_PrazoClick(Sender: TObject);
    procedure ChBx_Nome_ForClick(Sender: TObject);
    procedure ChBx_Fantasia_ForClick(Sender: TObject);
    procedure SB_Ret_TarefaClick(Sender: TObject);
    procedure Sb_Ins_RetornoClick(Sender: TObject);
    procedure Sb_Alt_RetornoClick(Sender: TObject);
    procedure ChBx_Nome_For_2Click(Sender: TObject);
    procedure Sb_Buscar_2Click(Sender: TObject);
    procedure DBG_ProducaoDblClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure Sb_Sair_2Click(Sender: TObject);
    procedure Sb_Exc_RetornoClick(Sender: TObject);
    procedure ChBx_Data_EnvioClick(Sender: TObject);
    procedure ChBx_Data_RetornoClick(Sender: TObject);
    procedure DBG_Itens_PrdCellClick(Column: TColumn);
    procedure Sb_Buscar_0Click(Sender: TObject);
    procedure Sb_Buscar_1Click(Sender: TObject);
    procedure SB_Ins_Tarefa_0Click(Sender: TObject);
    procedure Qr_ProducaoAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure Qr_Retorno_PrdAfterOpen(DataSet: TDataSet);
    procedure DBG_ProducaoCellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pc_IniciaVariavel;
    procedure Pc_FormataTela;
    procedure Pc_Busca_Itens_Producao;
    procedure Pc_Busca_Producao;
    procedure Pc_Busca_Retorno;
    function  Fc_Qtde_Retorno(Fc_Cd_Producao:Integer):Real;
    Function Fc_ValidaCadastroTarefa:Boolean;
    procedure Pc_ImagemBotao;
  end;

var
  Fr_Prod_Confeccao: TFr_Prod_Confeccao;

implementation

uses     Un_DM, UN_Sistema, UN_MSG, Un_Prod_Ret_Confeccao, Un_Prod_Tar_Confeccao, UN_Principal, env;
{$R *.dfm}

function  TFr_Prod_Confeccao.Fc_Qtde_Retorno(Fc_Cd_Producao:Integer):Real;
Begin
  Qr_Retorno.Active := False;
  Qr_Retorno.ParamByName('RPC_CODPCF').AsInteger := Fc_Cd_Producao;
  Qr_Retorno.Active := True;
  Result := Qr_RetornoRPC_TOTAL.AsCurrency;
end;


procedure TFr_Prod_Confeccao.Pc_FormataTela;
Begin
  Pg_Tarefas.ActivePageIndex := 0;
end;

procedure TFr_Prod_Confeccao.Pc_IniciaVariavel;
Begin
  //Aba de itens para Produção
  E_Data_Ped_Ini.Date := Date;
  E_Data_Ped_Fim.Date := Date;
  E_Data_Ent_Ini.Date := Date;
  E_Data_Ent_Fim.Date := Date;

  //Aba de Tarefas de  Produção
  E_Data_Prd_Ini.Date := Date;
  E_Data_Prd_fim.Date := Date;
  E_Data_Prz_Ini.Date := Date;
  E_Data_Prz_Fim.Date := Date;

  //Aba de Retorno de Produção
  E_Data_Env_Ini.Date := Date;
  E_Data_Env_Fim.Date := Date;
  E_Data_Ret_Ini.Date := Date;
  E_Data_Ret_Fim.Date := Date;
end;

procedure TFr_Prod_Confeccao.Pc_Busca_Itens_Producao;
var
  Lc_Sqltxt: string;
  Lc_Data, Lc_Cliente, Lc_Prazo : boolean;
begin
  Screen.Cursor:=crHourGlass;
  Lc_Sqltxt := '';
  Qr_ItensPrd.Close;
  Qr_ItensPrd.SQL.Clear;
  Lc_Sqltxt := 'SELECT PED_NUMERO, PRO_DESCRICAO, ITF_QTDE,GRT_TAMANHO,GRT_QTDE,EMP_NOME, '+
               'EMP_FANTASIA, PED_CODIGO,GRT_CODIGO,PED_DT_ENTREGA                         '+
               'FROM TB_PEDIDO tb_pedido                                                   '+
               '  INNER JOIN TB_ITENS_NFL tb_itens_nfl                                     '+
               '  ON(tb_itens_nfl.ITF_CODPED = tb_pedido.PED_CODIGO)                       '+
               '  INNER JOIN TB_PRODUTO tb_produto                                         '+
               '  ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO)                     '+
               '  INNER JOIN TB_GRADETAMANHO tb_gradetamanho                               '+
               '  ON (tb_gradetamanho.GRT_CODITF = tb_itens_nfl.ITF_CODIGO)                '+
               '  INNER JOIN TB_EMPRESA tb_empresa                                         '+
               '  ON (tb_empresa.EMP_CODIGO =  tb_pedido.PED_CODEMP)                       '+
               'WHERE PED_CODIGO IS NOT NULL                                               ';

  if ChBx_Data_Pedido.Checked then Lc_Data := True else Lc_Data := false;
  IF E_BuscaCliente.Text <> '' then Lc_Cliente := True else Lc_Cliente := false;
  if ChBx_Data_Entrega.Checked then lc_Prazo := True else lc_Prazo := false;

  if Lc_Data then Lc_Sqltxt := Lc_Sqltxt + ' AND PED_DATA BETWEEN :DATAINI AND :DATAFIM ';
  if Lc_Cliente then Lc_sqltxt := Lc_sqltxt +'AND ( (EMP_NOME LIKE :EMP_NOME) OR (EMP_FANTASIA LIKE :EMP_NOME))';
  if Lc_Prazo then Lc_Sqltxt := Lc_Sqltxt + ' AND PED_DT_ENTREGA BETWEEN :PRAZOINI AND :PRAZOFIM ';

  Qr_ItensPrd.SQL.Add(Lc_sqltxt + ' ORDER BY EMP_NOME');

  if Lc_Data then Qr_ItensPrd.ParamByName('DATAINI').AsDate := E_Data_Ped_Ini.Date;
  if Lc_Data then Qr_ItensPrd.ParamByName('DATAFIM').AsDate := E_Data_Ped_Fim.Date;
  if Lc_Cliente then Qr_ItensPrd.ParamByName('EMP_NOME').AsString :='%'+E_BuscaCliente.Text+'%';
  if Lc_Prazo then Qr_ItensPrd.ParamByName('PRAZOINI').AsDate := E_Data_Ent_Ini.Date;
  if Lc_Prazo then Qr_ItensPrd.ParamByName('PRAZOFIM').AsDate := E_Data_Ent_Fim.Date;

  Qr_ItensPrd.Active := True;
  Qr_ItensPrd.FetchAll;
  Qr_ItensPrd.First;
  DBG_Itens_PrdCellClick(DBG_Itens_Prd.Columns[1]);
  Screen.Cursor:=crDefault;
end;

procedure TFr_Prod_Confeccao.Pc_Busca_Producao;
var
  Lc_Sqltxt: string;
  Lc_Data, Lc_Fornece, Lc_Prazo : boolean;
begin
  Screen.Cursor:=crHourGlass;
  Lc_Sqltxt := '';
  Qr_Producao.Close;
  Qr_Producao.SQL.Clear;
  Lc_Sqltxt := 'SELECT   PCF_CODIGO ,  PCF_ROMANEIO,  PCF_DATA,  PCF_CODFOR,  tb_fornecedor.EMP_NOME,  PCF_CODSRV,               '+
               'tb_servico.PRO_DESCRICAO,  PCF_VL_UNIT,  PCF_QTDE,  (PCF_VL_UNIT *  PCF_QTDE) PCF_VL_SUBTOTAL,  PCF_DT_ENTREGA '+
               ' FROM TB_PROD_CONFECCAO tb_producao                                                                              '+
               '    INNER JOIN TB_EMPRESA tb_fornecedor                                                                          '+
               '    ON (tb_fornecedor.EMP_CODIGO =  tb_producao.PCF_CODFOR)                                                      '+
               '    INNER JOIN TB_PRODUTO tb_servico                                                                             '+
               '    ON (tb_servico.PRO_CODIGO = tb_producao.PCF_CODSRV)                                                          '+
               'WHERE PCF_CODIGO IS NOT NULL                                                                                     ';

  if Chbx_ProdutoParaProducao.Checked then
    Begin
    Lc_Sqltxt := Lc_Sqltxt + ' AND (PCF_CODGRT =:PCF_CODGRT) ';
    Qr_Producao.SQL.Add(Lc_sqltxt + ' ORDER BY EMP_NOME');
    Qr_Producao.ParamByName('PCF_CODGRT').AsInteger := Qr_ItensPrdGRT_CODIGO.AsInteger;
    end
  else
    Begin
    if ChBx_Data_Producao.Checked then Lc_Data := True else Lc_Data := false;
    IF E_BuscaFornecedor.Text <> '' then Lc_Fornece := True else Lc_Fornece := false;
    if ChBx_Data_Prazo.Checked then lc_Prazo := True else lc_Prazo := false;

    if Lc_Data then Lc_Sqltxt := Lc_Sqltxt + ' AND PCF_DATA BETWEEN :DATAINI AND :DATAFIM ';
    if Lc_Fornece then Lc_sqltxt := Lc_sqltxt +'AND ( (EMP_NOME LIKE :EMP_NOME) OR (EMP_FANTASIA LIKE :EMP_NOME))';
    if Lc_Prazo then Lc_Sqltxt := Lc_Sqltxt + ' AND PCF_DT_ENTREGA BETWEEN :PRAZOINI AND :PRAZOFIM ';

    Qr_Producao.SQL.Add(Lc_sqltxt + ' ORDER BY EMP_NOME');

    if Lc_Data then Qr_Producao.ParamByName('DATAINI').AsDate := E_Data_Prd_Ini.Date;
    if Lc_Data then Qr_Producao.ParamByName('DATAFIM').AsDate := E_Data_Prd_fim.Date;
    if Lc_Fornece then Qr_Producao.ParamByName('EMP_NOME').AsString :='%'+E_BuscaFornecedor.Text+'%';
    if Lc_Prazo then Qr_Producao.ParamByName('PRAZOINI').AsDate := E_Data_Prz_Ini.Date;
    if Lc_Prazo then Qr_Producao.ParamByName('PRAZOFIM').AsDate := E_Data_Prz_Fim.Date;
    end;
  Qr_Producao.Active := True;
  Qr_Producao.FetchAll;
  DBG_ProducaoCellClick(DBG_Producao.Columns[1]);
  Screen.Cursor:=crDefault;

end;

procedure TFr_Prod_Confeccao.Pc_Busca_Retorno;
var
  Lc_Sqltxt: string;
  Lc_Prazo, Lc_Fornece, Lc_Retorno : boolean;
begin
  Screen.Cursor:=crHourGlass;
  Lc_Sqltxt := '';
  Qr_Retorno_Prd.Close;
  Qr_Retorno_Prd.SQL.Clear;
  Lc_Sqltxt := 'SELECT RPC_CODIGO,  PCF_CODIGO,  PCF_ROMANEIO,  PRO_DESCRICAO,  PCF_DT_ENTREGA,  '+
               '   RPC_QTDE,  RPC_DT_RETORNO                                                     '+
               ' FROM TB_PROD_CONFECCAO tb_producao                                              '+
               '    INNER JOIN TB_RET_PROD_CONFECCAO tb_retorno                                  '+
               '    ON (tb_retorno.RPC_CODPCF = tb_producao.PCF_CODIGO)                          '+
               '    INNER JOIN TB_PRODUTO tb_servico                                             '+
               '    ON (tb_servico.PRO_CODIGO = tb_producao.PCF_CODSRV)                          '+
               '    INNER JOIN TB_EMPRESA tb_fornecedor                                          '+
               '    ON (tb_fornecedor.EMP_CODIGO = tb_producao.PCF_CODFOR)                       '+
               'WHERE PCF_CODIGO IS NOT NULL                                                     ';


  if Pg_Tarefas.ActivePageIndex = 0 then
    Begin
    if Qr_Producao.RecordCount = 0 then exit;
    Lc_Sqltxt := Lc_Sqltxt + ' AND (RPD_CODPRD =:RPD_CODPRD) ';
    Qr_Retorno_Prd.SQL.Add(Lc_sqltxt + ' ORDER BY PRO_DESCRICAO ');
//    Qr_Retorno_Prd.ParamByName('RPD_CODPRD').AsInteger := Qr_ProducaoPRD_CODIGO.AsInteger;
    Qr_Retorno_Prd.Active := True;
    end
  else
    Begin
    if ChBx_Data_Envio.Checked then Lc_Prazo := True else Lc_Prazo := false;
    IF E_BuscaFornecedor_2.Text <> '' then Lc_Fornece := True else Lc_Fornece := false;
    if ChBx_Data_Retorno.Checked then Lc_Retorno := True else Lc_Retorno := false;

    if Lc_Prazo then Lc_Sqltxt := Lc_Sqltxt + ' AND PRD_PRZ_ENTREGA BETWEEN :PRAZOINI AND :PRAZOFIM ';
    if Lc_Fornece then Lc_sqltxt := Lc_sqltxt +'AND ( (EMP_NOME LIKE :EMP_NOME) OR (EMP_FANTASIA LIKE :EMP_NOME))';
    if Lc_Retorno then Lc_Sqltxt := Lc_Sqltxt + ' AND RPD_DATA BETWEEN :DATAINI AND :DATAFIM ';

    Qr_Retorno_Prd.SQL.add(Lc_sqltxt + ' ORDER BY PRO_DESCRICAO ');


    if Lc_Prazo then Qr_Retorno_Prd.ParamByName('PRAZOINI').AsDate   := E_Data_Env_Ini.Date;
    if Lc_Prazo then Qr_Retorno_Prd.ParamByName('PRAZOFIM').AsDate   := E_Data_Env_Fim.Date;
    if Lc_Fornece then Qr_Retorno_Prd.ParamByName('EMP_NOME').AsString :='%'+E_BuscaFornecedor_2.Text+'%';
    if Lc_Retorno then Qr_Retorno_Prd.ParamByName('DATAINI').AsDate  := E_Data_Ret_Ini.Date;
    if Lc_Retorno then Qr_Retorno_Prd.ParamByName('DATAFIM').AsDate  := E_Data_Ret_Fim.Date;
    end;
  Qr_Retorno_Prd.Active := True;

  Screen.Cursor:=crDefault;

end;


procedure TFr_Prod_Confeccao.ChBx_Data_PedidoClick(Sender: TObject);
begin
  E_Data_Ped_Ini.Enabled := ChBx_Data_Pedido.Checked;
  E_Data_Ped_Fim.Enabled := ChBx_Data_Pedido.Checked;
end;

procedure TFr_Prod_Confeccao.ChBx_Data_EntregaClick(Sender: TObject);
begin
  E_Data_Ent_Ini.Enabled := ChBx_Data_Entrega.Checked;
  E_Data_Ent_Fim.Enabled := ChBx_Data_Entrega.Checked;
end;

procedure TFr_Prod_Confeccao.ChBx_Nome_CliClick(Sender: TObject);
begin
  if ChBx_Nome_Cli.Checked then
    Begin
    DBG_Producao.Columns.Items[4].Title.Caption := 'Nome/Razão Social';
    DBG_Producao.Columns.Items[4].FieldName := 'EMP_NOME'   ;
    ChBx_Fantasia_Cli.Checked := False;
    end;
end;

procedure TFr_Prod_Confeccao.ChBx_Fantasia_CliClick(Sender: TObject);
begin
  if ChBx_Fantasia_Cli.Checked then
    Begin
    DBG_Producao.Columns.Items[4].Title.Caption := 'Nome Fantasia';
    DBG_Producao.Columns.Items[4].FieldName := 'EMP_FANTASIA'   ;
    ChBx_Nome_Cli.Checked := False;
    end;
end;

Function TFr_Prod_Confeccao.Fc_ValidaCadastroTarefa:Boolean;
Begin
  Result := True;
  if (Qr_ItensPrd.RecordCount = 0) then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Informe o Item para Produção.'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Tarefas.ActivePageIndex := 0;
    Sb_Buscar_0Click(Self);
    Result := False;
    exit;
    end;
end;

procedure TFr_Prod_Confeccao.SB_Ins_Tarefa_1Click(Sender: TObject);
begin
  if not Fc_ValidaCadastroTarefa then exit;
  if not Assigned(Fr_Prod_Tar_Confeccao) then Application.CreateForm(TFr_Prod_Tar_Confeccao, Fr_Prod_Tar_Confeccao);
  Fr_Prod_Tar_Confeccao.Tag := 1;
  Fr_Prod_Tar_Confeccao.It_Cd_Producao := 0;
  Fr_Prod_Tar_Confeccao.It_Cd_Grade := Qr_ItensPrdGRT_CODIGO.AsInteger;
  Fr_Prod_Tar_Confeccao.It_Qtde := Qr_ItensPrdGRT_QTDE.AsInteger;
  Fr_Prod_Tar_Confeccao.ShowModal;
  Qr_Producao.Active := False;
  Qr_Producao.Active := true;
end;

procedure TFr_Prod_Confeccao.SB_Alt_TarefaClick(Sender: TObject);
begin
  if not Assigned(Fr_Prod_Tar_Confeccao) then Application.CreateForm(TFr_Prod_Tar_Confeccao, Fr_Prod_Tar_Confeccao);
  Fr_Prod_Tar_Confeccao.Tag := 2;
  Fr_Prod_Tar_Confeccao.It_Cd_Producao := Qr_ProducaoPCF_CODIGO.AsInteger;
  Fr_Prod_Tar_Confeccao.It_Cd_Grade := Qr_ItensPrdGRT_CODIGO.AsInteger;
  Fr_Prod_Tar_Confeccao.It_Qtde := Qr_ItensPrdGRT_QTDE.AsInteger;
  Fr_Prod_Tar_Confeccao.ShowModal;
  Qr_Producao.Active := False;
  Qr_Producao.Active := true;
end;

procedure TFr_Prod_Confeccao.Sb_Sair_1Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Prod_Confeccao.SB_Exc_TarefaClick(Sender: TObject);
begin
{  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o item '+Qr_ProducaoEMP_NOME.AsString +' desta Base.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
    exit;
  try
  Pc_Producao('A',
              Qr_ProducaoPRD_CODIGO.AsInteger,
              Qr_ProducaoPRD_CODPED.AsInteger,
              Qr_ProducaoPRD_CODGRT.AsInteger,
              '',
              Qr_ProducaoPRD_DATA.AsDateTime,
              Qr_ProducaoPRD_CODEMP.AsInteger,
              Qr_ProducaoPRD_CODSRV.AsInteger,
              Qr_ProducaoPRD_VL_UNIT.AsCurrency,
              Qr_ProducaoPRD_QTDE.AsFloat,
              Qr_ProducaoPRD_PRZ_ENTREGA.AsDateTime);
  Qr_Producao.Active := False;
  Qr_Producao.Active := True;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                   ['OK'],[bEscape],mpErro);
  end;
}
end;

procedure TFr_Prod_Confeccao.ChBx_Data_ProducaoClick(Sender: TObject);
begin
  E_Data_Prd_Ini.Enabled := ChBx_Data_Producao.Checked;
  E_Data_Prd_Fim.Enabled := ChBx_Data_Producao.Checked;
end;

procedure TFr_Prod_Confeccao.ChBx_Data_PrazoClick(Sender: TObject);
begin
  E_Data_Prz_Ini.Enabled := ChBx_Data_Prazo.Checked;
  E_Data_Prz_Fim.Enabled := ChBx_Data_Prazo.Checked;
end;

procedure TFr_Prod_Confeccao.ChBx_Nome_ForClick(Sender: TObject);
begin
  if ChBx_Nome_For.Checked then
    Begin
    DBG_Itens_Prd.Columns.Items[0].Title.Caption := 'Nome/Razão Social';
    DBG_Itens_Prd.Columns.Items[0].FieldName := 'EMP_NOME'   ;
    ChBx_Fantasia_For.Checked := False;
    end;
end;

procedure TFr_Prod_Confeccao.ChBx_Fantasia_ForClick(Sender: TObject);
begin
  if ChBx_Fantasia_For.Checked then
    Begin
    DBG_Itens_Prd.Columns.Items[0].Title.Caption := 'Nome Fantasia';
    DBG_Itens_Prd.Columns.Items[0].FieldName := 'EMP_FANTASIA'   ;
    ChBx_Nome_For.Checked := False;
    end;
end;

procedure TFr_Prod_Confeccao.SB_Ret_TarefaClick(Sender: TObject);
begin
  Pg_Tarefas.ActivePageIndex := 2;
  if not Assigned(Fr_Prod_Ret_Confeccao) then Application.CreateForm(TFr_Prod_Ret_Confeccao, Fr_Prod_Ret_Confeccao);
  Fr_Prod_Ret_Confeccao.It_Cd_Retorno := 0;
  Fr_Prod_Ret_Confeccao.It_Cd_Producao := Qr_ProducaoPCF_CODIGO.AsInteger;
  if Fr_Prod_Ret_Confeccao.Fc_MostraBusca(Qr_ProducaoPCF_ROMANEIO.AsString) then
    Fr_Prod_Ret_Confeccao.ShowModal
  else
    Fr_Prod_Ret_Confeccao.Close;
  Qr_Retorno_Prd.Active := False;
  Qr_Retorno_Prd.Active := true;
end;

procedure TFr_Prod_Confeccao.Sb_Ins_RetornoClick(Sender: TObject);
Var
  Lc_Numero : String;
begin
  if not(InputQuery('Informe o Romaneio ', 'Número', Lc_numero)) then
    exit;
  if not Assigned(Fr_Prod_Ret_Confeccao) then Application.CreateForm(TFr_Prod_Ret_Confeccao, Fr_Prod_Ret_Confeccao);
  Fr_Prod_Ret_Confeccao.It_Cd_Retorno := 0;
  if Fr_Prod_Ret_Confeccao.Fc_MostraBusca(Lc_Numero) then
    Fr_Prod_Ret_Confeccao.ShowModal
  else
    Fr_Prod_Ret_Confeccao.Close;
  Qr_Retorno_Prd.Active := False;
  Qr_Retorno_Prd.Active := true;
end;

procedure TFr_Prod_Confeccao.Sb_Alt_RetornoClick(Sender: TObject);
begin
  if not Assigned(Fr_Prod_Ret_Confeccao) then Application.CreateForm(TFr_Prod_Ret_Confeccao, Fr_Prod_Ret_Confeccao);
  Fr_Prod_Ret_Confeccao.It_Cd_Retorno  := Qr_Retorno_PrdRPC_CODIGO.AsInteger;
  Fr_Prod_Ret_Confeccao.It_Cd_Producao := Qr_Retorno_PrdPCF_CODIGO.AsInteger;
  if Fr_Prod_Ret_Confeccao.Fc_MostraBusca(Qr_Retorno_PrdPCF_ROMANEIO.AsString) then
    Fr_Prod_Ret_Confeccao.ShowModal
  else
    Fr_Prod_Ret_Confeccao.Close;
  Qr_Retorno_Prd.Active := False;
  Qr_Retorno_Prd.Active := True;
end;

procedure TFr_Prod_Confeccao.ChBx_Nome_For_2Click(Sender: TObject);
begin
  if ChBx_Nome_For_2.Checked then
    Begin
    DBG_Retorno.Columns.Items[0].Title.Caption := 'Nome/Razão Social';
    DBG_Retorno.Columns.Items[0].FieldName := 'EMP_NOME'   ;
    ChBx_Fantasia_For_2.Checked := False;
    end;
end;

procedure TFr_Prod_Confeccao.Sb_Buscar_2Click(Sender: TObject);
begin
  Pc_Busca_Retorno;
end;

procedure TFr_Prod_Confeccao.DBG_ProducaoDblClick(Sender: TObject);
begin
  IF Qr_Producao.RecordCount = 0 then exit;
  Pc_Busca_Retorno;
  Pg_Tarefas.ActivePageIndex := 1;
end;

procedure TFr_Prod_Confeccao.FormDblClick(Sender: TObject);
begin
  Pg_Tarefas.ActivePageIndex := 0;
end;

procedure TFr_Prod_Confeccao.Sb_Sair_2Click(Sender: TObject);
begin
  close;
end;

procedure TFr_Prod_Confeccao.Sb_Exc_RetornoClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o retorno do dia '+Qr_Retorno_PrdPCF_DT_ENTREGA.AsString +' do romaneio ' +Qr_Retorno_PrdPCF_ROMANEIO.AsString  +EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
    Begin
    try
      if not Assigned(Fr_Prod_Ret_Confeccao) then Application.CreateForm(TFr_Prod_Ret_Confeccao, Fr_Prod_Ret_Confeccao);
      Fr_Prod_Ret_Confeccao.Tb_Ret_Producao.Active := False;
      Fr_Prod_Ret_Confeccao.Tb_Ret_Producao.ParamByName('RPC_CODIGO').AsInteger := Qr_Retorno_PrdRPC_CODIGO.AsInteger;
      Fr_Prod_Ret_Confeccao.Tb_Ret_Producao.Active := True;
      Fr_Prod_Ret_Confeccao.Tb_Ret_Producao.Delete;
      Fr_Prod_Ret_Confeccao.Close;
      Qr_Retorno_Prd.Active := False;
      Qr_Retorno_Prd.Active := True;
    except
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                     'Entre em contato com o suporte técnico.'+EOLN,
                     ['OK'],[bEscape],mpErro);
    end;
    END;
end;

procedure TFr_Prod_Confeccao.ChBx_Data_EnvioClick(Sender: TObject);
begin
  E_Data_Env_Ini.Enabled := ChBx_Data_Envio.Checked;
  E_Data_Env_Fim.Enabled := ChBx_Data_Envio.Checked;
end;

procedure TFr_Prod_Confeccao.ChBx_Data_RetornoClick(Sender: TObject);
begin
  E_Data_Ret_Ini.Enabled := ChBx_Data_Retorno.Checked;
  E_Data_Ret_Fim.Enabled := ChBx_Data_Retorno.Checked;
end;

procedure TFr_Prod_Confeccao.DBG_Itens_PrdCellClick(Column: TColumn);
begin
  Caption := 'Produção - ' + Qr_ItensPrdPRO_DESCRICAO.AsString + ' - ' + UpperCase(Qr_ItensPrdGRT_TAMANHO.AsString);
  if Qr_ItensPrd.RecordCount > 0 then
    Begin
    Chbx_ProdutoParaProducao.Enabled := true;
    Chbx_ProdutoParaProducao.Caption := 'Filtrar por ' + Qr_ItensPrdPRO_DESCRICAO.AsString + ' - ' + UpperCase(Qr_ItensPrdGRT_TAMANHO.AsString);
    end
  else
    Begin
    Chbx_ProdutoParaProducao.Checked := False;
    Chbx_ProdutoParaProducao.Enabled := False;
    Chbx_ProdutoParaProducao.Caption := 'Produto não selecionado';
    end;
end;

procedure TFr_Prod_Confeccao.Sb_Buscar_0Click(Sender: TObject);
begin
  Pc_Busca_Itens_Producao;
end;

procedure TFr_Prod_Confeccao.Sb_Buscar_1Click(Sender: TObject);
begin
  Pc_Busca_Producao;
end;

procedure TFr_Prod_Confeccao.SB_Ins_Tarefa_0Click(Sender: TObject);
begin
  if not Fc_ValidaCadastroTarefa then exit;
  Pg_Tarefas.ActivePageIndex := 1;
  SB_Ins_Tarefa_1Click(Sender);
end;

procedure TFr_Prod_Confeccao.Qr_ProducaoAfterOpen(DataSet: TDataSet);
begin
  SB_Alt_Tarefa.Enabled := (Qr_Producao.RecordCount > 0);
  SB_Exc_Tarefa.Enabled := (Qr_Producao.RecordCount > 0);
  SB_Ret_Tarefa.Enabled := (Qr_Producao.RecordCount > 0);
end;

procedure TFr_Prod_Confeccao.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Relação de Itens para Produção
    SB_Ins_Tarefa_0.Glyph.Assign(Fc_CarregaImagemBotao('INSERIR'));
    Sb_Buscar_0.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    //tarefas de Produção
    SB_Ins_Tarefa_1.Glyph.Assign(Fc_CarregaImagemBotao('INSERIR'));
    SB_Alt_Tarefa.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    SB_Exc_Tarefa.Glyph.Assign(Fc_CarregaImagemBotao('EXCLUIR'));
    Sb_Buscar_1.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    Sb_Sair_1.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    //REtorno de Tarefas
    Sb_Ins_Retorno.Glyph.Assign(Fc_CarregaImagemBotao('INSERIR'));
    Sb_Alt_Retorno.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    Sb_Exc_Retorno.Glyph.Assign(Fc_CarregaImagemBotao('EXCLUIR'));
    Sb_Buscar_2.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    Sb_Sair_2.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));

    END;
end;

procedure TFr_Prod_Confeccao.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_FormataTela;
  Pc_IniciaVariavel;
end;

procedure TFr_Prod_Confeccao.Qr_Retorno_PrdAfterOpen(DataSet: TDataSet);
begin
  Sb_Alt_Retorno.Enabled := (Qr_Retorno_Prd.RecordCount > 0);
  Sb_Exc_Retorno.Enabled := (Qr_Retorno_Prd.RecordCount > 0);
  SB_Imp_Retorno.Enabled := (Qr_Retorno_Prd.RecordCount > 0);
end;

procedure TFr_Prod_Confeccao.DBG_ProducaoCellClick(Column: TColumn);
begin
  if Qr_Producao.RecordCount > 0 then
    Begin
    Chbx_FornecedorParaRetorno.Enabled := true;
    Chbx_FornecedorParaRetorno.Caption := 'Filtrar pelo fornecedor ' + Qr_ProducaoEMP_NOME.AsString ;
    end
  else
    Begin
    Chbx_FornecedorParaRetorno.Checked := False;
    Chbx_FornecedorParaRetorno.Enabled := False;
    Chbx_FornecedorParaRetorno.Caption := 'Fornecedor não selecionado';
    end;
end;

end.
