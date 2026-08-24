unit Un_Vei_OrdemServico;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, StdCtrls, Mask, QEdit_Setes, Grids, DBGrids, ComCtrls, ControllerVehicle, ExtCtrls, Buttons, DB, STQuery, ControllerPedido;

type
  TFr_Vei_OrdemServico = class(TForm)
    GroupBox1: TGroupBox;
    Label36: TLabel;
    Lb_Placa: TLabel;
    E_Busca_Cliente: TEdit;
    E_Busca_Ordem: TEdit_Setes;
    ChBx_Busca_Nome: TCheckBox;
    E_Busca_Placa: TEdit;
    Label1: TLabel;
    E_Busca_Prisma: TEdit;
    Pnl_Busca: TGroupBox;
    DBG_Pesquisa: TDBGrid;
    Grb_Edicao_Ordem: TPanel;
    Sb_Sair_0: TSpeedButton;
    Panel1: TPanel;
    Pg_OrdemServico: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Pnl_Produto: TPanel;
    DBG_Produtos: TDBGrid;
    Pnl_Servico: TPanel;
    Sb_Tecnico: TSpeedButton;
    DBG_Servicos: TDBGrid;
    Pnl_Annotation: TPanel;
    E_Ann_Reference: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    E_Ann_Obs: TMemo;
    Sb_Ins_Servico: TSpeedButton;
    Sb_Ins_Produto: TSpeedButton;
    Pnl_Controle: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Lb_Km: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Lb_ANo: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Lb_Cilindrada: TLabel;
    E_Ors_Numero: TEdit;
    E_Ors_Obs: TDBMemo;
    E_Dt_Saida: TEdit;
    E_Vei_Placa: TMaskEdit;
    E_Vei_Frota: TMaskEdit;
    E_Vei_Ano: TEdit_Setes;
    E_Ors_Hora_Entrada: TEdit;
    E_Hr_Saida: TEdit;
    E_Ors_Km: TEdit;
    E_Vei_Cilindrada: TEdit_Setes;
    E_Vei_Marca: TEdit;
    E_Vei_Modelo: TEdit;
    E_Vei_Tipo: TEdit;
    E_Ors_Data: TMaskEdit;
    E_Vei_Cor: TEdit;
    Grb_Cientes: TGroupBox;
    Label19: TLabel;
    E_Cli_Nome: TEdit;
    Label25: TLabel;
    E_Cli_Contato: TMaskEdit;
    Label20: TLabel;
    Label26: TLabel;
    Label21: TLabel;
    E_Cli_Fax: TEdit_Setes;
    E_Cli_Fone: TEdit_Setes;
    E_Cli_Celular: TEdit_Setes;
    Label50: TLabel;
    Label53: TLabel;
    E_Cli_Comercial: TEdit_Setes;
    E_Cli_Portaria: TEdit_Setes;
    Label22: TLabel;
    E_Cli_Email: TEdit;
    SB_Buscar: TSpeedButton;
    Qr_OrdemServico: TSTQuery;
    Qr_ItensProdutos: TSTQuery;
    Qr_ItensServicos: TSTQuery;
    Ds_ItensProdutos: TDataSource;
    Ds_ItensServicos: TDataSource;
    Ds_OrdemServico: TDataSource;
    Sb_Servico: TSpeedButton;
    Qr_Annotation: TSTQuery;
    Ds_Annotation: TDataSource;
    Dbg_ListAnnotation: TDBGrid;
    Pnl_Botao_Annotation: TPanel;
    Sb_Alt_Anotacao: TSpeedButton;
    Sb_Exc_Anotacao: TSpeedButton;
    Sb_Ins_Anotacao: TSpeedButton;
    Sb_Grv_Anotacao: TSpeedButton;
    Sb_Can_Anotacao: TSpeedButton;
    Label24: TLabel;
    E_Ors_Prisma: TEdit;
    Sb_CheckList: TSpeedButton;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    ChBx_Busca_Fantasia: TCheckBox;
    Label11: TLabel;
    Dblcb_CorVeiculo: TDBLookupComboBox;
    SB_Visualizar: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SB_BuscarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure Qr_OrdemServicoAfterScroll(DataSet: TDataSet);
    procedure DBG_PesquisaTitleClick(Column: TColumn);

    procedure Sb_Ins_ProdutoClick(Sender: TObject);
    procedure Sb_Ins_ServicoClick(Sender: TObject);
    procedure Qr_AnnotationAfterScroll(DataSet: TDataSet);
    procedure Sb_Exc_AnotacaoClick(Sender: TObject);
    procedure Sb_Grv_AnotacaoClick(Sender: TObject);
    procedure Sb_Ins_AnotacaoClick(Sender: TObject);
    procedure Sb_Alt_AnotacaoClick(Sender: TObject);
    procedure Sb_Can_AnotacaoClick(Sender: TObject);
    procedure TabSheet5Show(Sender: TObject);
    procedure Sb_ServicoClick(Sender: TObject);
    procedure Sb_CheckListClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_TecnicoClick(Sender: TObject);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBG_PesquisaDblClick(Sender: TObject);
  private
    FSelecionar: Boolean;
    FSelecionado: Boolean;

    function validateGetView:Boolean;
    function validateGetViewOrder:Boolean;
    procedure getView;
    procedure OpenBudget;
    procedure OpenOrder;
    Procedure OpenInvoice;

  public
    { Public declarations }
    It_Cd_Ordem_Servico : Integer;
    It_Cd_Annotation : Integer;
    It_cd_link2 : Integer;
    It_Edicao_Annotation : String;
    Ordem :TControllerVehicle;
    procedure Pc_ImagemPermissao;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;
    Function SelectCotacao:String;
    Function SelectPEdido:String;
    procedure Pc_Buscar;
    procedure Pc_PosicicionaOrdemEdicao;
    procedure  Pc_AtivarTabelasOrdem;
    procedure  Pc_FillOrdem(Pc_DataSet:TSTQuery);
    procedure  Pc_LimparCampos;
    procedure  Pc_OpenItensProduto;
    procedure  Pc_OpenItensServico;
    procedure  Pc_OpenAnnotation;
    procedure  Pc_fillAnnotation;
    procedure Pc_CleanAnnotation;
    function Fc_ValidaAnnotation():Boolean;
    procedure Pc_EstadoEdicaoAnnotation;
    Function Fc_ValidaInsereTecnicos():Boolean;
  end;

var
  Fr_Vei_OrdemServico: TFr_Vei_OrdemServico;

implementation

uses     UN_Principal, env, Un_DM, UN_Sistema, UN_MSG, RN_Permissao, RN_NotaFiscal, Un_Itens_Servico, RN_Annotation, RN_Crud, Un_VehicleSo, Un_Funcoes, Un_VehicleCheckList, Un_Tecnicos, Un_Itens_Produto_OSR, UN_Pedido_Vda, Un_Cotacao;
{$R *.dfm}

procedure TFr_Vei_OrdemServico.Pc_ImagemPermissao;
Begin
  with fr_principal do
  Begin
    //Geral;
    Sb_Buscar.Glyph := (Fc_CarregaImagemBotao('BUSCAR'));
    SB_Visualizar.Glyph.Assign(Fc_CarregaImagemBotao('VISUALIZAR'));
    Sb_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
    //Peças
    Sb_Ins_Produto.Glyph := (Fc_CarregaImagemBotao('INSERIR'));
    //Servico
    Sb_Ins_Servico.Glyph := (Fc_CarregaImagemBotao('INSERIR'));
    //Anotações
    Sb_Ins_Anotacao.Glyph := (Fc_CarregaImagemBotao('INSERIR'));
    Sb_Alt_Anotacao.Glyph := (Fc_CarregaImagemBotao('ALTERAR'));
    Sb_Exc_Anotacao.Glyph := (Fc_CarregaImagemBotao('EXCLUIR'));
    Sb_Grv_Anotacao.Glyph := (Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Can_Anotacao.Glyph := (Fc_CarregaImagemBotao('CANCELAR'));
  END;
end;

procedure TFr_Vei_OrdemServico.Pc_PermissaoBotao(Pc_Menu: string);
begin

end;

procedure TFr_Vei_OrdemServico.Pc_IniciaVariaveis;
Begin
  E_Data_Ini.DateTime := Date;
  E_Data_Fim.DateTime := Date;
  DM.Qr_Color.Active := True;
end;

procedure TFr_Vei_OrdemServico.Pc_FormataTela;
Var
  Lc_Mostra : Boolean;
Begin
  Pc_ImagemPermissao;
  Lc_Mostra := not (Fc_Tb_Geral('L','OSR_G_TABLETANDROID','S') = 'S');
  Lb_Km.Visible := Lc_Mostra;
  E_Ors_Km.Visible := Lc_Mostra;
  Lb_ANo.Visible := Lc_Mostra;
  E_Vei_Ano.Visible := Lc_Mostra;
  Lb_Cilindrada.Visible := Lc_Mostra;
  E_Vei_Cilindrada.Visible := Lc_Mostra;
  Pg_OrdemServico.ActivePageIndex := 0;
end;

Function TFr_Vei_OrdemServico.SelectCotacao:String;
Begin
  Result := 'SELECT '+
            '  0 TIPO, '+
            '  CTC_CODIGO codigo, '+
            '  CTC_CODPED CodigoPedido, '+
            '  CTC_DATA Data, '+
            '  CTC_NUMERO numero, '+
            '  CTC_CODEMP CodigoEmpresa, '+
            '  CTC_CODVDO CodigoVendedor, '+
            '  CTC_PRAZO Prazo, '+
            '  PRISMA prisma, '+
            '  ENTRANCE_DATE dataEntrada, '+
            '  ENTRANCE_HOUR HoraEntrada, '+
            '  vso.tb_vehicle_id placa, '+
            '  KM km, '+
            '  vso.OBS Obs, '+
            '  EMP_NOME Nome, '+
            '  EMP_EMAIL email, '+
            '  EMP_MULTIPLICADOR multiplicador, '+
            '  END_CONTATO Contato, '+
            '  END_FONE fone, '+
            '  END_FAX fax, '+
            '  END_CELULAR celular, '+
            '  END_COMERCIAL comercial, '+
            '  END_PORTARIA portaria, '+
            '  CTC_CONTATO contato, '+
            '  MRC_DESCRICAO Marca, '+
            '  MOD_DESCRICAO modelo, '+
            '  TPV_DESCRICAO TipoVeiculo, '+
            '  tb_color.DESCRIPTION CorVeiculo, '+
            '  VEI_FROTA Frota, '+
            '  VEI_ANO anoVeiculo, '+
            '  VEI_KM kmVeiculo, '+
            '  VEI_CILINDRADA Cilindrada, '+
            '  EXIT_DATE DataSaida, '+
            '  EXIT_HOUR HoraSaida '+
            '  FROM tb_cotacao c '+
            '    INNER JOIN tb_empresa '+
            '    ON (tb_empresa.emp_codigo = c.ctc_codemp) '+
            '    INNER JOIN TB_ENDERECO '+
            '    ON (END_CODEMP = EMP_CODIGO) '+
            '    INNER JOIN tb_vehicle_so vso '+
            '    on (vso.tb_order_id = c.ctc_codped) '+
            '    LEFT OUTER JOIN tb_vehicle_checklist '+
            '    ON (tb_vehicle_checklist.tb_order_id = c.ctc_codped) '+
            '    LEFT OUTER JOIN tb_veiculo vei '+
            '    ON (vei.vei_placa = vso.tb_vehicle_id) '+
            '    INNER JOIN tb_marca_veiculo '+
            '    ON (tb_marca_veiculo.mrc_codigo = vei.vei_codmrc) '+
            '    INNER JOIN tb_modelo '+
            '    ON (tb_modelo.mod_codigo = vei.vei_codmod) '+
            '    INNER JOIN tb_tp_veiculo tp_vei '+
            '    ON (tp_vei.tpv_codigo = vei.vei_codtpv) '+
            '    INNER JOIN tb_color '+
            '    ON (tb_color.id = vei.vei_codcor) '+
            '    LEFT OUTER JOIN TB_PEDIDO p '+
            '    ON (p.PED_CODIGO = c.CTC_CODPED) '+
            '  WHERE ( CTC_CODIGO IS NOT NULL ) '+
            '    AND ( END_PRINCIPAL = ''S'' ) '+
            '    AND ( PED_CODIGO IS NULL )';

    if ChBx_Periodo.Checked then
      REsult := Result  + ' and (CTC_DATA BETWEEN :DATAINI AND :DATAFIM) ';
    if Trim(E_Busca_Ordem.Text)<> '' then
      REsult := Result  + ' AND (CTC_NUMERO = :ORDEM) ';
    if Trim(E_Busca_Placa.Text)   <> '' then
      REsult := Result  + ' AND (vso.tb_vehicle_id = :VEI_PLACA) ';
    if Trim(E_Busca_Prisma.Text)  <> '' then
      REsult := Result  + ' AND (PRISMA =:PRISMA)';
    if Trim(E_Busca_Cliente.Text) <> '' then
      REsult := Result  + ' AND ((EMP_FANTASIA LIKE :EMP_FANTASIA) OR (EMP_NOME LIKE :EMP_FANTASIA)) ';
    if Trim(Dblcb_CorVeiculo.Text) <> '' then
      REsult := Result  + ' AND ( vei.vei_codcor = :vei_codcor ) '

End;

Function TFr_Vei_OrdemServico.SelectPEdido:String;
BEgin
  Result := 'SELECT '+
            '  1 TIPO, '+
            '  0 codigo, '+
            '  PED_CODIGO codigopedido, '+
            '  PED_DATA Data, '+
            '  PED_NUMERO Numero, '+
            '  PED_CODEMP codigoempresa, '+
            '  PED_CODVDO codigovendedor, '+
            '  PED_PRAZO prazo, '+
            '  PRISMA prisma, '+
            '  ENTRANCE_DATE dataEntrada, '+
            '  ENTRANCE_HOUR HoraEntrada, '+
            '  vso.tb_vehicle_id placa, '+
            '  KM km, '+
            '  vso.OBS Obs, '+
            '  EMP_NOME Nome, '+
            '  EMP_EMAIL email, '+
            '  EMP_MULTIPLICADOR multiplicador, '+
            '  END_CONTATO Contato, '+
            '  END_FONE fone, '+
            '  END_FAX fax, '+
            '  END_CELULAR celular, '+
            '  END_COMERCIAL comercial, '+
            '  END_PORTARIA portaria, '+
            '  END_CONTATO contato, '+
            '  MRC_DESCRICAO Marca, '+
            '  MOD_DESCRICAO modelo, '+
            '  TPV_DESCRICAO TipoVeiculo, '+
            '  cor.DESCRIPTION CorVeiculo, '+
            '  VEI_FROTA Frota, '+
            '  VEI_ANO anoVeiculo, '+
            '  VEI_KM kmVeiculo, '+
            '  VEI_CILINDRADA Cilindrada, '+
            '  EXIT_DATE DataSaida, '+
            '  EXIT_HOUR HoraSaida '+
            '  FROM tb_pedido p '+
            '    INNER JOIN tb_empresa ep '+
            '    ON (ep.emp_codigo = p.ped_codemp) '+
            '    INNER JOIN TB_ENDERECO en '+
            '    ON (en.END_CODIGO = p.ped_codend) '+
            '    INNER JOIN tb_vehicle_so vso '+
            '    on (vso.tb_order_id = p.ped_codigo) '+
            '    LEFT OUTER JOIN tb_vehicle_checklist cvck '+
            '    ON (cvck.tb_order_id = p.ped_codigo) '+
            '    LEFT OUTER JOIN tb_veiculo vei '+
            '    ON (vei.vei_placa = vso.tb_vehicle_id) '+
            '    LEFT OUTER JOIN tb_marca_veiculo mrc '+
            '    ON (mrc.mrc_codigo = vei.vei_codmrc) '+
            '    LEFT OUTER JOIN tb_modelo mdv '+
            '    ON (mdv.mod_codigo = vei.vei_codmod) '+
            '    LEFT OUTER JOIN tb_tp_veiculo tpv '+
            '    ON (tpv.tpv_codigo = vei.vei_codtpv) '+
            '    LEFT OUTER JOIN tb_color cor '+
            '    ON (cor.id = vei.vei_codcor) '+
            '  WHERE PED_CODIGO IS NOT NULL AND END_PRINCIPAL = ''S'' ';

    if ChBx_Periodo.Checked then
      REsult := Result  + ' and (PED_DATA BETWEEN :DATAINI AND :DATAFIM) ';
    if Trim(E_Busca_Ordem.Text)<> '' then
      REsult := Result  + ' AND (PED_NUMERO = :ORDEM) ';
    if Trim(E_Busca_Placa.Text)   <> '' then
      REsult := Result  + ' AND (vso.tb_vehicle_id = :VEI_PLACA) ';
    if Trim(E_Busca_Prisma.Text)  <> '' then
      REsult := Result  + ' AND (PRISMA =:PRISMA)';
    if Trim(E_Busca_Cliente.Text) <> '' then
      REsult := Result  + ' AND ((EMP_FANTASIA LIKE :EMP_FANTASIA) OR (EMP_NOME LIKE :EMP_FANTASIA)) ';
    if Trim(Dblcb_CorVeiculo.Text) <> '' then
      REsult := Result  + ' AND ( vei.vei_codcor = :vei_codcor ) '

End;

procedure TFr_Vei_OrdemServico.Pc_Buscar;
Var
  Lc_Ordem : Boolean;
  Lc_Placa : Boolean;
  Lc_Prisma : Boolean;
  Lc_Cliente : Boolean;
Begin
  with Qr_OrdemServico do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add(selectCotacao);
    SQL.Add('UNION ');
    SQL.Add(selectPedido);
    SQL.Add('ORDER BY 3,14');
    //Verifica se os campos foram Preenchidos
    if ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    end;
    if Trim(E_Busca_Ordem.Text)   <> '' then
      ParamByName('ORDEM').AsString := E_Busca_Ordem.Text;
    if Trim(E_Busca_Placa.Text)   <> '' then
      ParamByName('VEI_PLACA').AsString := Fc_RemoveCaracterInformado(E_Busca_placa.Text, ['-']);
    if Trim(E_Busca_Prisma.Text)  <> '' then
      ParamByName('PRISMA').AsString := E_Busca_Prisma.Text;
    if Trim(E_Busca_Cliente.Text) <> '' then
      ParamByName('EMP_FANTASIA').AsString := '%'+E_Busca_Cliente.Text+'%';
    if Trim(Dblcb_CorVeiculo.Text) <> '' then
      ParamByName('vei_codcor').AsInteger :=  Dblcb_CorVeiculo.KeyValue;

    Active := True;
  end;
end;

procedure TFr_Vei_OrdemServico.Pc_PosicicionaOrdemEdicao;
Begin
  Pc_AtivarTabelasOrdem;
  Pc_FillOrdem(Qr_OrdemServico);
  Pc_OpenItensProduto;
  Pc_OpenItensServico;
  Pc_OpenAnnotation;
  Pc_fillAnnotation;
end;
procedure  TFr_Vei_OrdemServico.Pc_AtivarTabelasOrdem;
Begin


end;

procedure  TFr_Vei_OrdemServico.Pc_FillOrdem(Pc_DataSet:TSTQuery);
Begin
  with Pc_DataSet do
  Begin
    if (recordCount > 0) then
    Begin
      It_Cd_Ordem_Servico := FieldByName('codigopedido').AsInteger;
      E_Ors_Data.Text := FieldByName('data').AsString;
      E_Ors_Prisma.Text := FieldByName('PRISMA').AsString;
      E_Ors_Numero.Text := FieldByName('NUMERO').AsString;
      E_Ors_Hora_Entrada.Text := FieldByName('HORAENTRADA').AsString;
      E_Vei_Placa.Text := FieldByName('PLACA').AsString;
      E_Vei_Frota.Text := FieldByName('FROTA').AsString;
      E_Ors_Km.Text := FieldByName('KM').AsString;
      E_Vei_Marca.Text := FieldByName('MARCA').AsString;
      E_Vei_Modelo.Text := FieldByName('MODELO').AsString;
      E_Vei_Tipo.Text := FieldByName('TIPOVEICULO').AsString;
      E_Vei_Cor.Text := FieldByName('CORVEICULO').AsString;
      E_Ors_Obs.Text := FieldByName('OBS').AsString;
      //Dados do Cliente
      E_Cli_Nome.Text := FieldByName('NOME').AsString;
      E_Cli_Contato.Text := FieldByName('CONTATO').AsString;
      E_Cli_Email.Text := FieldByName('EMAIL').AsString;
      E_Cli_Fone.Text       := fc_MascaraFone(FieldByName('FONE').AsString);
      E_Cli_Fax.Text        := fc_MascaraFone(FieldByName('FAX').AsString);
      E_Cli_Celular.Text    := fc_MascaraFone(FieldByName('CELULAR').AsString);
      E_Cli_Comercial.Text  := fc_MascaraFone(FieldByName('COMERCIAL').AsString);
      E_Cli_Portaria.Text  := fc_MascaraFone(FieldByName('PORTARIA').AsString);
    end
    else
      Pc_LimparCampos;
  end;

end;

procedure  TFr_Vei_OrdemServico.Pc_LimparCampos;
Begin
  It_Cd_Ordem_Servico := 0;
  E_Ors_Data.Clear;
  E_Ors_Numero.Clear;
  E_Ors_Hora_Entrada.Clear;
  E_Vei_Placa.Clear;
  E_Vei_Frota.Clear;
  E_Ors_Km.Clear;
  E_Vei_Marca.Clear;
  E_Vei_Modelo.Clear;
  E_Vei_Tipo.Clear;
  E_Vei_Cor.Clear;
  E_Ors_Obs.Clear;
  //Dados do Cliente
  E_Cli_Nome.Clear;
  E_Cli_Contato.Clear;
  E_Cli_Email.Clear;
  E_Cli_Fone.Clear;
  E_Cli_Fax.Clear;
  E_Cli_Celular.Clear;
  E_Cli_Comercial.Clear;
  E_Cli_Portaria.Clear;
  Qr_ItensProdutos.Active := False;
  Qr_ItensServicos.Active := False;
end;
     
procedure  TFr_Vei_OrdemServico.Pc_OpenItensProduto;
Begin
  with Qr_ItensProdutos do
  Begin
    Active := False;
    ParamByName('PED_CODIGO').AsInteger := It_Cd_Ordem_Servico;
    Active := True;
  End;
end;

procedure  TFr_Vei_OrdemServico.Pc_OpenItensServico;
Begin
  with Qr_ItensServicos do
  Begin
    Active := False;
    ParamByName('PED_CODIGO').AsInteger := It_Cd_Ordem_Servico;
    Active := True;
  End;
end;

procedure  TFr_Vei_OrdemServico.Pc_OpenAnnotation;
Begin
  Qr_Annotation.Active := False;
  Qr_Annotation.ParamByName('link_id1').AsInteger := It_Cd_Ordem_Servico;
  Qr_Annotation.Active := True;
end;

procedure  TFr_Vei_OrdemServico.Pc_fillAnnotation;
BEgin
  It_Cd_Annotation := Qr_Annotation.FieldByName('id').AsInteger;
  E_Ann_Reference.Text := Qr_Annotation.FieldByName('REFERENCE').AsString;
  E_Ann_Obs.Text := Qr_Annotation.FieldByName('OBSERVATION').AsString;
end;

procedure TFr_Vei_OrdemServico.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_PermissaoBotao('Ordem de Serviço de Veículos');
  Pc_IniciaVariaveis;
end;

procedure TFr_Vei_OrdemServico.getView;
begin
  if validateGetViewOrder then
  Begin
    Ordem.pedido.Registro.codigo := Qr_OrdemServico.FieldByName('CodigoPedido').asinteger;
    Ordem.pedido.getbyId;
    if not Ordem.pedido.exist then
    Begin
      OpenBudget;
    End
    else
    Begin
    if Ordem.pedido.Registro.Faturado = 'N' then
      OpenOrder
    else
      OpenInvoice;
    End;
  End;
end;

procedure TFr_Vei_OrdemServico.OpenBudget;
begin
  if not Assigned(Fr_Cotacao) then (Application.CreateForm(TFr_Cotacao, Fr_Cotacao));
  Fr_Cotacao.COTACAO.Registro.Codigo := Qr_OrdemServico.FieldByName('Codigo').asinteger;
  Fr_Cotacao.ShowModal;
end;

procedure TFr_Vei_OrdemServico.OpenInvoice;
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Operações NFe','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Ordem.NotaFiscal.Registro.CodigoPedido := Ordem.Pedido.Registro.Codigo;
    Pc_AbreTelaNotaFiscal(Ordem.NotaFiscal.getCodigoNotaByPedido,Self);
  End;
end;

procedure TFr_Vei_OrdemServico.OpenOrder;
Var
  LcForm : TFr_Pedido_Vda;
begin
  try
    LcForm := TFr_Pedido_Vda.Create(nil);
    LcForm.Pedido.Registro.Codigo := Ordem.Pedido.Registro.Codigo;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;


procedure TFr_Vei_OrdemServico.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Vei_OrdemServico.SB_BuscarClick(Sender: TObject);
begin
  Pc_Buscar;
end;

procedure TFr_Vei_OrdemServico.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Vei_OrdemServico.Qr_OrdemServicoAfterScroll(
  DataSet: TDataSet);
begin
  Pc_PosicicionaOrdemEdicao;
end;

procedure TFr_Vei_OrdemServico.DBG_PesquisaDblClick(Sender: TObject);
begin
  getView;
end;

procedure TFr_Vei_OrdemServico.DBG_PesquisaTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(DBG_Pesquisa, Column);
end;





procedure TFr_Vei_OrdemServico.Sb_Ins_ProdutoClick(Sender: TObject);
Var
  Lc_Form: TFr_Itens_Produto_OSR;
  Lc_Pedido : TControllerPedido;
begin
  Lc_Pedido := TControllerPedido.create(Self);
  Lc_Pedido.Registro.codigo := Qr_OrdemServico.FieldByName('codigopedido').AsInteger;
  if not Lc_Pedido.VerificaFaturado(True) then
  Begin
    Lc_Form := TFr_Itens_Produto_OSR.Create(Self);
    with Lc_Form, Qr_OrdemServico do
    Begin
      it_Cd_Empresa := FieldByName('codigoempresa').AsInteger;
      Pc_StateChange(2);
      It_Cd_Vendedor := FieldByName('codigovendedor').AsInteger;
      It_MultiplicadorPreco := FieldByName('MULTIPLICADOR').AsFloat;
      Lc_Form.ItensNFL.Registro.CodigoPedido := FieldByName('codigopedido').AsInteger;

      E_Qt_Produto.Text := '1';
      if (COPY(FieldByName('PRAZO').AsString,1,3) = '000') then
        Lc_Form.it_Modalidade_preco := 'V'
      else
        Lc_Form.it_Modalidade_preco :=  'P';
      It_Dt_Operacao := FieldByName('DATA').AsDateTime;
      ShowModal;
    End;
    FreeAndNil(Lc_Form);
    Pc_OpenItensProduto;
  End;
  FreeAndNil(Lc_Pedido);
end;

procedure TFr_Vei_OrdemServico.Sb_Ins_ServicoClick(Sender: TObject);
Var
  Lc_Form:TFr_Itens_Servico;
  Lc_Pedido : TControllerPedido;
begin
  Lc_Pedido := TControllerPedido.create(Self);
  Lc_Pedido.Registro.codigo := Qr_OrdemServico.FieldByName('codigopedido').AsInteger;
  if not Lc_Pedido.VerificaFaturado(True) then
  Begin
    //Cria O Formulario
    Lc_Form := TFr_Itens_Servico.Create(Self);
    with Lc_Form,Qr_OrdemServico do
    Begin
      if FieldByName('codigo').AsInteger > 0 then
      Begin
        It_Cotacao_OSR := True;
        It_Pedido_Vda := False;
      End
      else
      Begin
        It_Cotacao_OSR := False;
        It_Pedido_Vda := True;
      End;
      It_OrdemServico := True;
      It_Cd_Vendedor := FieldByName('codigovendedor').AsInteger;
      it_Cd_Empresa := FieldByName('codigoempresa').AsInteger;
      Pc_StateChange(2);
      It_MultiplicadorPreco := FieldByName('MULTIPLICADOR').AsFloat;
      It_Cd_Pedido := FieldByName('codigopedido').AsInteger;
      It_Cd_Cotacao := FieldByName('codigo').AsInteger;
      It_Aliq_Comissao := 0;
      E_Qt_Servico.Text := '1';
      ShowModal;
    End;
    FreeAndNil(Lc_Form);
    Pc_OpenItensServico;
  End;
  FreeAndNil(Lc_Pedido);
end;

procedure TFr_Vei_OrdemServico.Qr_AnnotationAfterScroll(DataSet: TDataSet);
begin
  It_Edicao_Annotation := 'B';
  Pc_fillAnnotation;
  Pc_EstadoEdicaoAnnotation;
end;

procedure TFr_Vei_OrdemServico.Sb_Exc_AnotacaoClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o extintor ' + Qr_Annotation.FieldByName('reference').AsString + ' de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
    Fc_ApagarRegistro('TB_ANNOTATION',['ID'],[IntToStr(Qr_Annotation.FieldByName('ID').AsInteger)]);
    Qr_Annotation.Active := False;
    Qr_Annotation.Active := True;
    Pc_CleanAnnotation;
    It_Edicao_Annotation := 'B';
    Pc_EstadoEdicaoAnnotation;    
    end;
end;

function TFr_Vei_OrdemServico.Fc_ValidaAnnotation():Boolean;
Begin
  Result := True;
  if Trim(E_Ann_Reference.Text) = '' then
    Begin
    MensagemPadrao(' Mensagem',ATENCAO+EOLN+EOLN+
                   ' Campo Referência deve ser preenchido '+EOLN+
                   ' Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpErro);
    E_Ann_Reference.SetFocus;
    Result := False;
    Exit;
    end;

  if Trim(E_Ann_Obs.Text) = '' then
    Begin
    MensagemPadrao(' Mensagem',ATENCAO+EOLN+EOLN+
                   ' Campo Observação deve ser preenchido '+EOLN+
                   ' Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpErro);
    E_Ann_Obs.SetFocus;
    Result := False;
    Exit;
    end;
end;

procedure TFr_Vei_OrdemServico.Sb_Grv_AnotacaoClick(Sender: TObject);
begin
  if Fc_ValidaAnnotation() then
    Begin
    Fc_AtualizaAnnotation(IntToStr(It_Cd_Annotation),
                          'vei_ordem_servico',
                          DateToStr(Date),  
                          IntToStr(It_Cd_Ordem_Servico),
                          IntToStr(It_cd_link2),
                          E_Ann_Reference.Text,
                          E_Ann_Obs.Text);
    It_Edicao_Annotation := 'B';
    Pc_EstadoEdicaoAnnotation;
    Qr_Annotation.Active := False;
    Qr_Annotation.Active := True;
    Qr_Annotation.Last;    
    end;
end;



procedure TFr_Vei_OrdemServico.Pc_EstadoEdicaoAnnotation;
Begin
  //Desativa a grid de Extintores
  Dbg_ListAnnotation.Enabled := (It_Edicao_Annotation = 'B');

  Sb_Ins_Anotacao.Enabled := (It_Edicao_Annotation = 'B');
  Sb_Alt_Anotacao.Enabled := (It_Edicao_Annotation = 'B') and (Qr_Annotation.RecordCount > 0);
  Sb_Exc_Anotacao.Enabled := (It_Edicao_Annotation = 'B') and (Qr_Annotation.RecordCount > 0);
  Sb_Grv_Anotacao.Enabled := (It_Edicao_Annotation = 'I') OR (It_Edicao_Annotation = 'E');
  Sb_Can_Anotacao.Enabled := (It_Edicao_Annotation = 'I') OR (It_Edicao_Annotation = 'E');
  Pnl_Annotation.Enabled  := (It_Edicao_Annotation = 'I') OR (It_Edicao_Annotation = 'E');
end;

procedure TFr_Vei_OrdemServico.Pc_CleanAnnotation;
Begin
  It_Cd_Annotation := 0;
  It_cd_link2 := 0;
  It_Edicao_Annotation := 'I';
  E_Ann_Reference.Clear;
  E_Ann_Obs.Clear;
end;

procedure TFr_Vei_OrdemServico.Sb_Ins_AnotacaoClick(Sender: TObject);
begin
  Pc_CleanAnnotation;
  Pc_EstadoEdicaoAnnotation;
  E_Ann_Reference.SetFocus;
end;

procedure TFr_Vei_OrdemServico.Sb_Alt_AnotacaoClick(Sender: TObject);
begin
  if Qr_Annotation.RecordCount > 0 then
    Begin
    It_Edicao_Annotation := 'E';
    Pc_fillAnnotation;
    Pc_EstadoEdicaoAnnotation;
    E_Ann_Reference.SetFocus;
    end
  else
    Begin
    MensagemPadrao(' Mensagem',ATENCAO+EOLN+EOLN+
                   ' Nenhuma Annotação foi encontrada '+EOLN+
                   ' Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    end;

end;

procedure TFr_Vei_OrdemServico.Sb_Can_AnotacaoClick(Sender: TObject);
begin
  Pc_fillAnnotation;
  It_Edicao_Annotation := 'B';
  Pc_EstadoEdicaoAnnotation;
end;

procedure TFr_Vei_OrdemServico.TabSheet5Show(Sender: TObject);
begin
  It_Edicao_Annotation := 'B';
  Pc_EstadoEdicaoAnnotation;
end;

function TFr_Vei_OrdemServico.validateGetView: Boolean;
begin
  Result := True;
  if not Qr_OrdemServico.Active then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Nenhuma busca foi efetuada.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

  if Qr_OrdemServico.RecordCount = 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não há registros para visualizar.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;
  FSelecionado := True;

end;

function TFr_Vei_OrdemServico.validateGetViewOrder: Boolean;
begin
  Result := True;
  if not validateGetView then
  Begin
    Result := False;
    exit;
  end;

  if not Fc_VerificaPermissao('Fr_Pedido_Vda','Pedido de Venda','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Result := False;
    exit;
  end;

end;

procedure TFr_Vei_OrdemServico.Sb_ServicoClick(Sender: TObject);
Var
  Lc_Form : TFr_VehicleSo;
begin
  with Qr_OrdemServico do
  Begin
    if (RecordCount > 0) then
    Begin
      Lc_Form := TFr_VehicleSo.Create(nil);
      TRy
        with Lc_Form do
        begin
          with OrdemServico do
          Begin
            Registro.CodigoEstabelecimento := Gb_Codmha;
            Registro.CodigoCotacao := FieldByName('CODIGO').AsInteger;
            Registro.CodigoPedido := FieldByName('CODIGOPEDIDO').AsInteger;
            with Vehicle do
            Begin
              Registro.CodigoEmpresa := FieldByName('CODIGOEMPRESA').AsInteger;
            End;
          End;
          ShowModal;
        End;
      Finally
        FreeAndNil(Lc_Form);
      End;
    end
    else
    Begin
      MensagemPadrao(' Mensagem',ATENCAO+EOLN+EOLN+
                     ' Nenhuma ordem de serviço foi encontrada '+EOLN+
                     ' Verifique e tente novamente.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    end;
  End;
end;

procedure TFr_Vei_OrdemServico.Sb_CheckListClick(Sender: TObject);
Var
  Lc_Form : TFr_VehicleCheckList;
begin
  with Qr_OrdemServico do
  Begin
    if (RecordCount > 0) then
    Begin
      Lc_Form := TFr_VehicleCheckList.Create(nil);
      Try
        with Lc_Form do
        Begin
          It_Budget_id := FieldByName('CODIGO').AsInteger;
          It_Order_id := FieldByName('CODIGOPEDIDO').AsInteger;
          ShowModal;
        End;
      Finally
        FreeAndNil(Lc_Form);
      End;
    end
    else
    Begin
      MensagemPadrao(' Mensagem',ATENCAO+EOLN+EOLN+
                     ' Nenhuma ordem de serviço foi encontrada '+EOLN+
                     ' Verifique e tente novamente.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    end;
  End;
end;

procedure TFr_Vei_OrdemServico.FormCreate(Sender: TObject);
begin
  Ordem := TControllerVehicle.create(self);
end;

procedure TFr_Vei_OrdemServico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  Begin
    case Pg_OrdemServico.ActivePageIndex of
      0:Begin
          case Key of
            VK_F3: if Sb_Servico.Enabled then  Sb_ServicoClick(Sender);
            VK_F8: if Sb_CheckList.Enabled then Sb_CheckListClick(Sender);
          end;
        end;
      1:Begin
          case Key of
            VK_F2: if Sb_Ins_Produto.Enabled then  Sb_Ins_ProdutoClick(Sender);
          end;
        end;
      2:Begin
          case Key of
            VK_F2: if Sb_Ins_Servico.Enabled then  Sb_Ins_ServicoClick(Sender);
            VK_F9: if Sb_Tecnico.Enabled then  Sb_TecnicoClick(Sender);
          end;
        end;
      3:Begin
          case Key of
            VK_F2: if Sb_Ins_Anotacao.Enabled then  Sb_Ins_AnotacaoClick(Sender);
            VK_F3: if Sb_Alt_Anotacao.Enabled then  Sb_Alt_AnotacaoClick(Sender);
            VK_F4: if Sb_Exc_Anotacao.Enabled then  Sb_Exc_AnotacaoClick(Sender);
            VK_F5: if Sb_Grv_Anotacao.Enabled then  Sb_Grv_AnotacaoClick(Sender);
            VK_F6: if Sb_Can_Anotacao.Enabled then  Sb_Can_AnotacaoClick(Sender);
          end;
        end;
    end;
    case Key of
      VK_F7: if SB_Buscar.Enabled then  SB_BuscarClick(Sender);
      VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
    end;
end;

Function TFr_Vei_OrdemServico.Fc_ValidaInsereTecnicos():Boolean;
Begin
  Result := True;
  if Qr_ItensServicos.RecordCount = 0 then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Não há serviço registrado para incluir técnico.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
    end;
end;

procedure TFr_Vei_OrdemServico.Sb_TecnicoClick(Sender: TObject);
Var
  Lc_Form : TFr_Tecnicos;
begin
  if Fc_ValidaInsereTecnicos then
  Begin
    Lc_Form := TFr_Tecnicos.Create(Self);
    Lc_Form.It_Cd_Pedido :=  Qr_OrdemServico.FieldByName('CODIGOPEDIDO').AsInteger;
    Lc_Form.It_Cd_Item := Qr_OrdemServico.FieldByName('CODIGO').AsInteger;
    Lc_Form.It_Tp_Vinculo := 'C';
    Lc_Form.ShowModal;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Vei_OrdemServico.SB_VisualizarClick(Sender: TObject);
begin
  getView;
end;

end.
