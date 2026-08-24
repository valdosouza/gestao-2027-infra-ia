unit un_ctrl_base_troca;

interface

uses
      Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, ComCtrls, Buttons, Grids, DBGrids, jpeg, STQuery, Variants, Menus, QEdit_Setes, Un_Fm_ListaProdutos, Un_Fm_ListaEmpresas, Un_Fm_ListaMultiEmpresa, Un_Fm_ListaMarcaProduto, Un_Fm_ListaGrupoSubGrupo, Un_Fm_ListaColaboradores, prm_exchange_basis, base_frame_list;


type
  TFr_Ctrl_base_troca = class(TForm)
    GroupBox1: TGroupBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    GroupBox2: TPanel;
    SB_Sair_0: TSpeedButton;
    SB_Buscar: TSpeedButton;
    Panel1: TPanel;
    GroupBox5: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    E_Peso_Entrada: TEdit_Setes;
    E_Peso_Saida: TEdit_Setes;
    E_Peso_Saldo: TEdit_Setes;
    Fm_ListaProdutos: TFm_ListaProdutos;
    Fm_ListaEmpresas: TFm_ListaEmpresas;
    Fm_LME: TFm_ListaMultiEmpresa;
    Pg_Resultado: TPageControl;
    tbs_pedido: TTabSheet;
    Qr_Exchange: TSTQuery;
    Ds_Exchange: TDataSource;
    Dbg_Exchange: TDBGrid;
    Fm_ListaMarca_Produto: TFm_ListaMarcaProduto;
    Fm_ListaGrupoSubGrupo: TFm_ListaGrupoSubGrupo;
    Fm_ListaVendedores: TFm_ListaColaboradores;
    Qr_ExchangeTB_INSTITUTION_ID: TIntegerField;
    Qr_ExchangeTB_ORDER_ID: TIntegerField;
    Qr_ExchangeTB_ORDER_ITEM_ID: TIntegerField;
    Qr_ExchangePRO_DESCRICAO: TStringField;
    Qr_ExchangeEMP_NOME: TStringField;
    Qr_ExchangeEMP_FANTASIA: TStringField;
    Qr_ExchangeCLB_NOME: TStringField;
    Qr_ExchangeITF_QTDE: TBCDField;
    Qr_ExchangeITF_VL_UNIT: TFMTBCDField;
    Qr_ExchangePRICE_TAG: TFMTBCDField;
    Qr_ExchangeWEIGHT_IN: TBCDField;
    Qr_ExchangeWEIGHT_OUT: TBCDField;
    Qr_ExchangeNOTE: TStringField;
    Qr_ExchangeUSU_NOME: TStringField;
    Qr_ExchangeSALDO: TBCDField;
    SB_Alterar: TSpeedButton;
    Sb_Lote: TSpeedButton;
    Qr_ExchangeDT_IN: TDateField;
    Qr_ExchangeDT_OUT: TDateField;
    Qr_ExchangePED_NUMERO: TIntegerField;
    SB_Imprimir: TSpeedButton;
    MainMenu: TMainMenu;
    arefas1: TMenuItem;
    AjustaPreo1: TMenuItem;
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_BuscarClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure Rg_Filtro_SituacaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Dbg_ExchangeTitleClick(Column: TColumn);
    procedure Fm_ListaEmpresasChBx_FantasiaClick(Sender: TObject);
    procedure Fm_ListaEmpresasChBx_NomeClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure Sb_LoteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SB_ImprimirClick(Sender: TObject);
    procedure AjustaPreo1Click(Sender: TObject);


  private
    { Private declarations }
    PesoEntrada : Real;
    PesoSaida : Real;
    function ValidateGetView:Boolean;
    procedure getParametros(Par : TPrmExchangeBase);
    procedure PrintReport;
  public
    { Public declarations }
    Parametros : TPrmExchangeBase;
    procedure Pc_Formatatela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_Ativartabelas;
    procedure Pc_Buscar;
    procedure Pc_Calcula;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;

  end;

var
  Fr_Ctrl_base_troca: TFr_Ctrl_base_troca;

implementation

uses     Un_DM, Un_Produtos, UN_Sistema, Un_Fich_Fin_Cli, Un_Nota_Fiscal, Un_Excel, Un_Msg, cad_base_troca, lote_base_troca, un_frx_report_base_troca, Un_Imp_Mod_Impressao, Un_Regra_Negocio, UN_Principal, env, RN_Estoque, RN_Empresa, RN_Fornecedor, RN_Cliente, RN_NotaFiscal, RN_NotaFiscalConsumidor, UN_Pedido_Ajt, UN_Pedido_Cpa, UN_Pedido_Vda, RN_Permissao, Un_Clta_Mov_Produtos, Un_Ajusta_Preco_Custo;
{$R *.DFM}

procedure TFr_Ctrl_base_troca.Pc_Ativartabelas;
Begin
  Fm_ListaGrupoSubGrupo.Listar(false);
  Fm_ListaMarca_Produto.Pc_ListaMedida;
  Fm_ListaEmpresas.Pc_AtivaEmpresa(1);
  Fm_ListaVendedores.ListaVendedor;
end;

procedure TFr_Ctrl_base_troca.Pc_IniciaVariaveis;
var
   Lc_X: Integer;
Begin
  for Lc_X := 0 to Pg_Resultado.PageCount -1 do
    Pg_Resultado.Pages[Lc_X].TabVisible := False;

  Pg_Resultado.ActivePage := tbs_PEdido;
  Fm_LME.Listar('EMP_NOME');
  Fm_LME.HabilitarMultiEmpresa;
  E_Data_Ini.Date:=date;
  E_Data_Fim.Date:=date;
  Fm_ListaMarca_Produto.Pc_ListaMedida;
  Fm_ListaEmpresas.Pc_AtivaEmpresa(1);
  Fm_ListaVendedores.ListaVendedor;
end;

procedure TFr_Ctrl_base_troca.Pc_Formatatela;
Begin


end;


procedure TFr_Ctrl_base_troca.Fm_ListaEmpresasChBx_FantasiaClick(
  Sender: TObject);
begin
  Fm_ListaEmpresas.ChBx_FantasiaClick(Sender);
end;

procedure TFr_Ctrl_base_troca.Fm_ListaEmpresasChBx_NomeClick(Sender: TObject);
begin
  Fm_ListaEmpresas.ChBx_NomeClick(Sender);

end;


procedure TFr_Ctrl_base_troca.Pc_Buscar;
VaR
  Lc_SqlTxt : String;
begin
  Screen.Cursor:=crHourGlass;
  with Qr_Exchange do
  Begin
    IF Transaction.InTransaction then Transaction.Commit; Transaction.StartTransaction;
    Close;
    SQL.Clear;
    Lc_SqlTxt := concat(
                  'Select eb.tb_institution_id, eb.tb_order_id, eb.tb_order_item_id, eb.dt_in, eb.dt_out, ',
                  'pr.pro_descricao, ep.emp_nome, ep.emp_fantasia, cl.clb_nome, ',
                  'it.itf_qtde, it.itf_vl_unit, eb.price_tag, eb.weight_in, eb.weight_out, eb.note, ',
                  'us.usu_nome, (weight_out - weight_in) saldo, pd.PED_NUMERO ',
                  'from tb_exchange_basis eb ',
                  '   inner join tb_produto pr ',
                  '   on (pr.pro_codigo = eb.tb_product_id) ',
                  '   inner join tb_colaborador cl ',
                  '   on (cl.clb_codigo = eb.tb_salesman_id) ',
                  '   inner join tb_itens_nfl it ',
                  '   on (it.itf_codigo = eb.tb_order_item_id) ',
                  '   inner join tb_usuario us ',
                  '   on (us.usu_codigo = eb.tb_user_id) ',
                  '   left outer join tb_pedido pd ',
                  '   on (pd.PED_CODIGO = eb.TB_ORDER_ID) ',
                  '   inner join tb_empresa ep ',
                  '   on (ep.emp_codigo = pd.PED_CODEMP ) ',
                  'WHERE (eb.TB_INSTITUTION_ID >0 )  '
                  );

    if ( parametros.Estabelecimento > 0 ) then
      Lc_SqlTxt := Lc_SqlTxt + ' AND ( TB_INSTITUTION_ID=:TB_INSTITUTION_ID ) ' ;

    IF parametros.Periodo then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ( dt_OUT BETWEEN :DATAINI AND :DATAFIM) ';

    if parametros.CodProduto <> '' then
    Begin
      IF (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S') then
      Begin
        If StrToIntDef(parametros.CodProduto,0) >0 then
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
        If StrToIntDef(parametros.CodProduto,0) >0 then
        Begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGO LIKE :PRO_CODIGO) or (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) ) ';
        end
        else
        begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) ) ';
        end;
      end;
    end;

    if parametros.DescProduto <> '' then
      Lc_SqlTxt := Lc_SqlTxt + ' AND  ( PRO_DESCRICAO LIKE :PRO_DESCRICAO ) ';

    IF parametros.GRupo > 0 then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ( PRO_CODGRP =:PRO_CODGRP ) ';

    IF parametros.SubGRupo > 0 then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ( PRO_CODSBG =:PRO_CODSBG ) ';

    if parametros.Marca > 0 then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_CODMRC =:PRO_CODMRC) ';

    IF parametros.CodCliente <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (TB_CUSTOMER_ID =:TB_CUSTOMER_ID) ';

    IF parametros.DescCliente <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ( (EMP_NOME LIKE :EMP_NOME) OR (EMP_FANTASIA LIKE :EMP_NOME) )';

    IF parametros.Vendedor > 0 then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ( TB_SALESMAN_ID =:TB_SALESMAN_ID )';

    SQL.Add(Lc_SqlTxt + ' ORDER BY  1, 2 ');

    if Parametros.Estabelecimento > 0 then
      ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;


    IF Parametros.Periodo then
    Begin
      ParamByName('DATAINI').AsDate := Parametros.DataInicial;
      ParamByName('DATAFIM').AsDate := Parametros.DataFinal
    end;

    if Parametros.CodProduto <> '' then
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

    if Parametros.DescProduto <> '' then
      ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(Parametros.DescProduto,1,98) + '%';

    if Parametros.GRupo > 0 then
      ParamByName('PRO_CODGRP').AsInteger := Parametros.GRupo;

    if Parametros.SubGRupo > 0 then
      ParamByName('PRO_CODSBG').AsInteger := Parametros.SubGRupo;

    if Parametros.Marca > 0 then
      ParamByName('PRO_CODMRC').AsInteger := Parametros.Marca;

    IF Parametros.CodCliente <> '' then
      ParamByName('TB_CUSTOMER_ID').AsString := Parametros.CodCliente;

    IF Parametros.DescCliente <> '' then
      ParamByName('EMP_NOME').AsString := '%' + Copy(Parametros.DescCliente,1,98) + '%';

    if Parametros.Vendedor > 0 then
      ParamByName('TB_SALESMAN_ID').AsInteger := Parametros.Vendedor;

    Open;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFr_Ctrl_base_troca.Pc_Calcula;
begin
  Dbg_Exchange.Visible := False;
  PesoEntrada := 0;
  PesoSaida   := 0;
  Qr_Exchange.First;
  while not Qr_Exchange.Eof do
  Begin
    PesoEntrada := PesoEntrada + Qr_ExchangeWEIGHT_IN.AsFloat;
    PesoSaida   := PesoSaida   + Qr_ExchangeWEIGHT_OUT.AsFloat;
    Qr_Exchange.Next;
  End;
  Qr_Exchange.First;
  E_Peso_Entrada.Text := FloatToStrF(PesoEntrada,ffNumber,10,2);
  E_Peso_Saida.Text := FloatToStrF(PesoSaida,ffNumber,10,2);
  E_Peso_Saldo.Text := FloatToStrF(PesoSaida - PesoEntrada ,ffNumber,10,2);
  Dbg_Exchange.Visible := true;
end;


procedure TFr_Ctrl_base_troca.SB_Sair_0Click(Sender: TObject);
begin
    Close;
end;

function TFr_Ctrl_base_troca.ValidateGetView: Boolean;
begin
  result := True;
  if not Qr_Exchange.Active then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Nenhuma busca foi efetuada.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

  if Qr_Exchange.RecordCount = 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não há registros para visualizar.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;
end;

procedure TFr_Ctrl_base_troca.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;

end;

procedure TFr_Ctrl_base_troca.FormCreate(Sender: TObject);
begin
  Parametros := TPrmExchangeBase.create;
end;

procedure TFr_Ctrl_base_troca.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
      case Key of
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
      end;
    end;
end;
procedure TFr_Ctrl_base_troca.SB_AlterarClick(Sender: TObject);
Var
  LcForm : TCadBaseTroca;
begin
  if ValidateGetView then
  Begin
    Try
      LcForm := TCadBaseTroca.Create(nil);
      LcForm.ItensNFL.BaseTroca.Registro.Estabelecimento := Qr_ExchangeTB_INSTITUTION_Id.AsInteger;
      LcForm.ItensNFL.BaseTroca.Registro.Item            := Qr_ExchangeTB_ORDER_ITEM_ID.AsInteger;
      LcForm.ItensNFL.BaseTroca.Registro.Ordem           := Qr_ExchangeTB_ORDER_ID.AsInteger;
      LcForm.ShowModal;
    Finally
      FreeAndNil(LcForm);
    End;
  End;
end;

procedure TFr_Ctrl_base_troca.SB_BuscarClick(Sender: TObject);
begin
  TRY
    Pc_ProcesoAguarde(Self,'I');
    getParametros(Parametros);
    Pc_Buscar;
    Pc_Calcula;
  Finally
    Pc_ProcesoAguarde(Self,'F');
  end;

end;

procedure TFr_Ctrl_base_troca.SB_ImprimirClick(Sender: TObject);
begin
  if ValidateGetView then
  Begin
    PrintReport;
  End;
end;

procedure TFr_Ctrl_base_troca.Sb_LoteClick(Sender: TObject);
Var
  LcForm : Tlotebasetroca;
begin
  Try
    LcForm := Tlotebasetroca.Create(nil);
    LcForm.ShowModal;
  Finally
    FreeAndNil(LcForm);
    Pc_Buscar;
    Pc_Calcula;
  End;
end;

procedure TFr_Ctrl_base_troca.AjustaPreo1Click(Sender: TObject);
Var
  Lc_form : TFr_AjustaPrecoCusto;
begin
  try
    Lc_form := TFr_AjustaPrecoCusto.create(self);
    Lc_form.ShowModal;
  finally
    FreeAndNil(Lc_form);
  end;
end;

procedure TFr_Ctrl_base_troca.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Ctrl_base_troca.Dbg_ExchangeTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(Dbg_Exchange, Column);
end;

procedure TFr_Ctrl_base_troca.Rg_Filtro_SituacaoClick(Sender: TObject);
begin
  SB_BuscarClick(self);
end;

procedure TFr_Ctrl_base_troca.Pc_PermissaoBotao(Pc_Menu: string);
begin
end;

procedure TFr_Ctrl_base_troca.PrintReport;
Var
  Lc_Form : TFrxReportBaseTroca;
begin
  TRY
    Lc_Form := TFrxReportBaseTroca.create(Self);
    getParametros(Lc_Form.Parametros);
    Lc_Form.Caption := 'RELATÓRIO SUCATA/BASE DE TROCA';
    Lc_Form.buscar;
    Lc_Form.frxBase.ShowReport;
  Finally
    FreeAndNil(Lc_Form);
  end;

end;


procedure TFr_Ctrl_base_troca.FormShow(Sender: TObject);
begin
  Pc_Ativartabelas;
  Pc_IniciaVariaveis;
  Pc_Formatatela;
  Pc_ImagemBotao;
  Pc_PermissaoBotao('Consulta Vendas');
  ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','') = 'S'); 
end;

procedure TFr_Ctrl_base_troca.getParametros(Par : TPrmExchangeBase);
begin
  Par.Clear;
  if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
    Par.Estabelecimento := Fm_LME.Dblcb_Lista.KeyValue;

  Par.Periodo := ChBx_Periodo.Checked;
  Par.DataInicial := E_Data_Ini.DateTime;
  Par.DataFinal := E_Data_Fim.DateTime;

  if Trim(Fm_ListaProdutos.E_Cd_Produto.Text) <> '' then
    Par.codProduto := Fm_ListaProdutos.E_Cd_Produto.Text;

  if Trim(Fm_ListaProdutos.E_Busca_Produto.Text) <> '' then
    Par.DescProduto  := Fm_ListaProdutos.E_Busca_Produto.Text;

  IF Trim(Fm_ListaGrupoSubGrupo.DBLCB_Grupo.Text) <> '' then
    Par.GRupo := Fm_ListaGrupoSubGrupo.DBLCB_Grupo.KeyValue;

  IF Trim(Fm_ListaGrupoSubGrupo.DBLCB_SubGrupo.Text) <> '' then
    Par.SubGRupo := Fm_ListaGrupoSubGrupo.DBLCB_SubGrupo.KeyValue;

  if Trim(Fm_ListaMarca_Produto.DBLCB_Marca.Text) <> '' then
    Par.Marca := Fm_ListaMarca_Produto.DBLCB_Marca.KeyValue;

  IF Trim(Fm_ListaEmpresas.E_Cd_Empresa.Text) <> '' then
    Par.CodCliente := Fm_ListaEmpresas.E_Cd_Empresa.Text;

  IF Trim(Fm_ListaEmpresas.DBLCb_Empresa.Text) <> '' then
    Par.DescCliente := Fm_ListaEmpresas.DBLCb_Empresa.Text;

  IF Trim(Fm_ListaVendedores.Dblcb_Vendedor.Text) <> '' then
    Par.Vendedor := Fm_ListaVendedores.Dblcb_Vendedor.KeyValue;

end;

procedure TFr_Ctrl_base_troca.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Geral;
    SB_Imprimir.Glyph.Assign(Fc_CarregaImagemBotao('IMPRIMIR'));
    SB_Lote.Glyph.Assign(Fc_CarregaImagemBotao('DESPUBLICAR'));
    SB_Alterar.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    SB_Buscar.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

end.
