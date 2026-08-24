unit Un_Despacho;

interface

uses
       Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, ComCtrls, Buttons, Grids, DBGrids, jpeg, STQuery, Variants, Menus, STStoredProc, QEdit_Setes, Un_Fm_ListaProdutos, ControllerProduto, System.Actions, Vcl.ActnList, ControllerDespacho;

type
  TFr_Despacho = class(TForm)
    Ds_Vendas: TDataSource;
    Ds_ItensVda: TDataSource;
    GroupBox1: TGroupBox;
    Label11: TLabel;
    DBG_Pesquisa: TDBGrid;
    Qr_Vendas: TSTQuery;
    Qr_ItensVda: TSTQuery;
    Ds_Cliente: TDataSource;
    Ds_Produto: TDataSource;
    Qr_Produtos: TSTQuery;
    Qr_Clientes: TSTQuery;
    E_CodPed: TMaskEdit;
    Pg_Info: TPageControl;
    Tbs_ItensPedido: TTabSheet;
    Tbs_Despachado: TTabSheet;
    Pn_Fundo1: TPanel;
    Pn_Fundo2: TPanel;
    Lb_DetalhePedido: TLabel;
    Lb_detalheDepacho: TLabel;
    Qr_Despachados: TSTQuery;
    Ds_Despacho: TDataSource;
    Tbs_Pendente: TTabSheet;
    Rg_Filtro: TRadioGroup;
    Pnl_despachar: TPanel;
    Dbg_Pendente: TDBGrid;
    Qr_Acao: TSTQuery;
    Qr_Pendente: TSTQuery;
    Ds_Pendente: TDataSource;
    Pnl_botao: TPanel;
    SB_Imprimir: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    SB_Despachar: TSpeedButton;
    Sb_Retornar: TSpeedButton;
    SB_Buscar: TSpeedButton;
    Dbg_ItensVda: TDBGrid;
    Qr_Itens_Despachados: TSTQuery;
    Lb_DetalhePendente: TLabel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    L_CodigoCliente: TLabel;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    E_cd_Empresa: TEdit;
    Cb_Busca_Empresa: TComboBox;
    Tbs_Devolucao: TTabSheet;
    Qr_Devolvidos: TSTQuery;
    Ds_Devolvidos: TDataSource;
    Pnl_devolucao: TPanel;
    StrGrd_Devolucao: TStringGrid;
    Label1: TLabel;
    SB_Add_Tudo_Devolucao: TSpeedButton;
    SB_Retirar_Tudo_Devolucao: TSpeedButton;
    Sb_Exc_ItensSelecionados: TSpeedButton;
    StrGrd_Despachados: TStringGrid;
    SB_Add_Tudo_Despachados: TSpeedButton;
    SB_Retirar_Tudo_Despachados: TSpeedButton;
    Sb_Pesq_Empresa: TSpeedButton;
    Fm_ListaProdutos: TFm_ListaProdutos;
    Pnl_Top_Despachar: TPanel;
    E_BuscaCodigo: TEdit_Setes;
    Lb_Item_lancado: TLabel;
    Label30: TLabel;
    Ac_Funcoes: TActionList;
    Liberacao: TAction;
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SB_BuscarClick(Sender: TObject);
    procedure SB_DespacharClick(Sender: TObject);
    procedure Sb_RetornarClick(Sender: TObject);
    procedure Rg_FiltroClick(Sender: TObject);
    procedure SB_ImprimirClick(Sender: TObject);
    procedure DBG_PesquisaTitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure Pg_InfoChange(Sender: TObject);
    procedure Dbg_ItensVdaTitleClick(Column: TColumn);
    procedure Dbg_PendenteTitleClick(Column: TColumn);
    procedure Qr_VendasAfterOpen(DataSet: TDataSet);
    procedure Qr_PendenteAfterOpen(DataSet: TDataSet);
    procedure Qr_ItensVdaAfterOpen(DataSet: TDataSet);
    procedure Qr_VendasAfterScroll(DataSet: TDataSet);
    procedure E_cd_EmpresaExit(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure Qr_DespachadosAfterOpen(DataSet: TDataSet);
    procedure StrGrd_DevolucaoDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StrGrd_DevolucaoClick(Sender: TObject);
    procedure SB_Add_Tudo_DevolucaoClick(Sender: TObject);
    procedure SB_Retirar_Tudo_DevolucaoClick(Sender: TObject);
    procedure Sb_Exc_ItensSelecionadosClick(Sender: TObject);
    procedure SB_Add_Tudo_DespachadosClick(Sender: TObject);
    procedure SB_Retirar_Tudo_DespachadosClick(Sender: TObject);
    procedure StrGrd_DespachadosDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StrGrd_DespachadosClick(Sender: TObject);
    procedure Sb_Pesq_EmpresaClick(Sender: TObject);
    procedure E_BuscaCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure LiberacaoExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    It_Despacho, It_Retornar,It_Imprimir,It_Exc_Devolvidos : Boolean;
    FProduto : TControllerProduto;
    FDespacho : TControllerDespacho;
    F_DespachoByBarCode : Boolean;
    procedure FormataUsoLeitorCodigoBarras;
    procedure FocoCampoCodigoBarras;
    function ValidaLancaItem:Boolean;
    procedure LancaItem;
    procedure RetornoTotal;
    procedure RetornoManual;
    function ValidafinalizacaoDespachados:Boolean;
    function ValidaItensDespachados:Boolean;
    Function ValidaItensPendentes:boolean;
    function ValidaRetornoManualDespacho:Boolean;
    function ValidaRetornoTotalDespacho:Boolean;
  public
    { Public declarations }
    PathExe: string;
    procedure Pc_BuscarPedidos;
    function Fc_Criterio(): string;
    procedure Pc_formataTela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_ImprimeDespacho;
    procedure Pc_ImprimeDespachados;
    procedure Pc_ImprimeSeparacao;
    procedure Pc_ImprimeItensPedido;
    procedure Pc_ImprimeDevolucao;
    procedure Pc_MostrarDespachados;
    procedure Pc_buscarDevolvidos;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_RegistraImpressao;
    procedure Pc_ImagemBotao;
  end;

var
   Fr_Despacho: TFr_Despacho;

implementation

uses
Un_DM, Un_Produtos, UN_Sistema, Un_Fich_Fin_Cli, ControllerBase, Un_Nota_Fiscal, un_rl_despacho, Un_Lanca_Despacho, UN_MSG, Un_Regra_Negocio, Un_Imp_Mod_Impressao, UN_Principal, env, RN_Cliente, RN_Empresa, RN_NotaFiscal, RN_NotaFiscalConsumidor, Un_Liberacao, UN_FotoProduto, Un_Pesq_Produto;

{$R *.DFM}

procedure TFr_Despacho.Pc_PermissaoBotao(Pc_Menu: string);
begin
  It_Despacho    := Fc_HabilitaPermissao(Pc_Menu,'DESPACHAR','S');
  It_Retornar    := Fc_HabilitaPermissao(Pc_Menu,'RETORNAR','S');
  It_Imprimir    := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
  It_Exc_Devolvidos := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
  //Ativa ou Desativa os Botões
  SB_Despachar.Enabled := It_Despacho;
  Sb_Retornar.Enabled := It_Retornar;
  SB_Imprimir.Enabled := It_Imprimir;
  Sb_Exc_ItensSelecionados.Enabled := It_Exc_Devolvidos;

end;

procedure TFr_Despacho.Pc_MostrarDespachados;
Var
  Lc_registro : Integer;
  Lc_I,Lc_J : Integer;
Begin
  //Buscar itens do Pedido
  Screen.Cursor := crHourGlass;
  Qr_Despachados.Active := False;
  Qr_Despachados.ParamByName('PED_CODIGO').AsInteger := Qr_Vendas.Fieldbyname('PED_CODIGO').AsInteger;
  Qr_Despachados.Active := True;
  Qr_Despachados.FetchAll;
  Qr_Despachados.FetchAll;
  Lc_registro := 0;
  For Lc_I:= 1 to (StrGrd_Despachados.RowCount - 1) do
    For Lc_J:= 0 to StrGrd_Despachados.ColCount do
      StrGrd_Despachados.Cells[Lc_J,Lc_I] := '';
  StrGrd_Despachados.RowCount := 2;

  while not Qr_Despachados.Eof do
    Begin
    Lc_registro := Lc_registro + 1;
    StrGrd_Despachados.RowCount := Lc_registro + 1;
    StrGrd_Despachados.Cells[1,Lc_registro] := Qr_Despachados.FieldByname('DSP_CODIGO').AsString;
    StrGrd_Despachados.Cells[3,Lc_registro] := Qr_Despachados.FieldByname('PRO_CODIGO').AsString;
    StrGrd_Despachados.Cells[4,Lc_registro] := Qr_Despachados.FieldByname('PRO_DESCRICAO').AsString;
    StrGrd_Despachados.Cells[5,Lc_registro] := Qr_Despachados.FieldByname('DSP_DT_PREVISTA').AsString;
    StrGrd_Despachados.Cells[6,Lc_registro] := Qr_Despachados.FieldByname('DSP_QTDE').AsString;
    StrGrd_Despachados.Cells[7,Lc_registro] := Qr_Despachados.FieldByname('DSP_DT_REALIZADA').AsString;
    if (Qr_Despachados.FieldByname('DSP_IMPRESSO').AsString<>'S') then
      StrGrd_Despachados.Cells[8,Lc_registro] := 'X'
    else
      StrGrd_Despachados.Cells[8,Lc_registro] := '';
    Qr_Despachados.Next;
    end;
  StrGrd_Despachados.Repaint;
  IF Qr_Despachados.RecordCount > 0 THEN
    Begin
    SB_Add_Tudo_Despachados.Enabled:= True;
    SB_Retirar_Tudo_Despachados.Enabled:= True;
    end
  ELSE
    Begin
    SB_Add_Tudo_Despachados.Enabled:= False;
    SB_Retirar_Tudo_Despachados.Enabled:= False;
    end;

  Screen.Cursor:=crDefault;



end;
        
procedure TFr_Despacho.Pc_buscarDevolvidos;
Var
  Lc_registro : Integer;
  Lc_I,Lc_J : Integer;
Begin
  //Buscar itens do Pedido
  Screen.Cursor := crHourGlass;
  Qr_Devolvidos.Active := False;
  Qr_Devolvidos.Active := True;
  Qr_Devolvidos.FetchAll;
  Lc_registro := 0;
  For Lc_I:= 1 to (StrGrd_Devolucao.RowCount - 1) do
    For Lc_J:= 0 to StrGrd_Devolucao.ColCount do
      StrGrd_Devolucao.Cells[Lc_J,Lc_I] := '';
  StrGrd_Devolucao.RowCount := 2;
  while not Qr_Devolvidos.Eof do
    Begin
    Lc_registro := Lc_registro + 1;
    StrGrd_Devolucao.RowCount := Lc_registro + 1;
    StrGrd_Devolucao.Cells[1,Lc_registro] := Qr_Devolvidos.FieldByname('DSP_CODIGO').AsString;
    StrGrd_Devolucao.Cells[3,Lc_registro] := Qr_Devolvidos.FieldByname('PRO_CODIGO').AsString;
    StrGrd_Devolucao.Cells[4,Lc_registro] := Qr_Devolvidos.FieldByname('PRO_DESCRICAO').AsString;
    StrGrd_Devolucao.Cells[5,Lc_registro] := Qr_Devolvidos.FieldByname('DSP_DT_REALIZADA').AsString;
    StrGrd_Devolucao.Cells[6,Lc_registro] := Qr_Devolvidos.FieldByname('DSP_QTDE').AsString;
    Qr_Devolvidos.Next;
    end;
  StrGrd_Devolucao.Repaint;
  IF Qr_Devolvidos.RecordCount > 0 THEN
    Begin
    Sb_Exc_ItensSelecionados.Enabled:=TRUE;
    SB_Add_Tudo_Devolucao.Enabled:= True;
    SB_Retirar_Tudo_Devolucao.Enabled:= True;
    end
  ELSE
    Begin
    Sb_Exc_ItensSelecionados.Enabled := False;
    SB_Add_Tudo_Devolucao.Enabled:= False;
    SB_Retirar_Tudo_Devolucao.Enabled:= False;
    end;

  Screen.Cursor:=crDefault;
end;

procedure TFr_Despacho.Pc_formataTela;
Begin
  //Pendentes
  Lb_DetalhePendente.ParentColor := False;
  Lb_DetalhePendente.Transparent := false;
  Lb_DetalhePendente.Color := clRed;
  //Despachados
  Lb_detalheDepacho.ParentColor := False;
  Lb_detalheDepacho.Transparent := false;
  Lb_detalheDepacho.Color := clGreen;
  //Itens do Pedido
  Lb_DetalhePedido.ParentColor := False;
  Lb_DetalhePedido.Transparent := false;
  Lb_DetalhePedido.Color := clNavy;
  Pg_Info.ActivePageIndex := 0;
  //Grade dos Despachados
  StrGrd_Despachados.ColWidths[0]  := 17;
  StrGrd_Despachados.ColWidths[1]  := -1;
  StrGrd_Despachados.ColWidths[2]  := 54;
  StrGrd_Despachados.ColWidths[3]  := 132;
  StrGrd_Despachados.ColWidths[4]  := 400;
  StrGrd_Despachados.ColWidths[5]  := 89;
  StrGrd_Despachados.ColWidths[6]  := 60;
  StrGrd_Despachados.ColWidths[7]  := 89;
  StrGrd_Despachados.ColWidths[8]  := -1;

  StrGrd_Despachados.Cols[2].Add('Selecionar');
  StrGrd_Despachados.Cols[3].Add('Cód. Produto');
  StrGrd_Despachados.Cols[4].Add('Descrição do produto');
  StrGrd_Despachados.Cols[5].Add('Data Prevista');
  StrGrd_Despachados.Cols[6].Add('Qtd. Despacho');
  StrGrd_Despachados.Cols[7].Add('Data Realizada');




  //Grade das devoluções
  StrGrd_Devolucao.ColWidths[0]  := 17;
  StrGrd_Devolucao.ColWidths[1]  := -1;
  StrGrd_Devolucao.ColWidths[2]  := 54;
  StrGrd_Devolucao.ColWidths[3]  := 132;
  StrGrd_Devolucao.ColWidths[4]  := 400;
  StrGrd_Devolucao.ColWidths[5]  := 89;
  StrGrd_Devolucao.ColWidths[6]  := 60;
  StrGrd_Devolucao.ColWidths[7]  := -1;
  StrGrd_Devolucao.Cols[2].Add('Selecionar');
  StrGrd_Devolucao.Cols[3].Add('Cód. Produto');
  StrGrd_Devolucao.Cols[4].Add('Descrição do produto');
  StrGrd_Devolucao.Cols[5].Add('Data Entrega');
  StrGrd_Devolucao.Cols[6].Add('Qtde');
  Pg_Info.Pages[3].TabVisible := (Fc_Tb_Geral('L','DSP_G_CTRL_SEPARACAO','S') = 'S') ;

end;

procedure TFr_Despacho.Pc_IniciaVariaveis;
Begin
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
  ChBx_Periodo.Checked:= Fc_Marca_data_pesquisa;
  Rg_Filtro.ItemIndex := 0;
  E_CodPed.Clear;
  Pc_ListaClienteComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,Cb_Busca_Empresa);
  FProduto := TControllerProduto.Create(Self);
  FDespacho := TControllerDespacho.Create(Self);
  F_DespachoByBarCode := ( Fc_Tb_Geral('L','DSP_BY_COD_BARRAS','N') = 'S');
end;

function TFr_Despacho.Fc_Criterio(): string;
var
  Lc_Qr_Criterio: TSTQuery;
  Lc_SqlTxt: string;
  Lc_Criterio: string;
begin
  try
    Lc_Qr_Criterio := TSTQuery.Create(nil);
    Lc_Qr_Criterio.Database := DM.IBD_Gestao;
    Lc_Qr_Criterio.Transaction := DM.IB_Transacao;
    Lc_Qr_Criterio.ForcedRefresh := True;


    Lc_SqlTxt := 'SELECT FIRST 1490 DISTINCT ITF_CODPED  '+
                 'FROM TB_ITENS_NFL ITF                  '+
                 '  INNER JOIN TB_DESPACHO DSP           '+
                 '  ON (DSP.DSP_CODITF = ITF.ITF_CODIGO) '+
                 'WHERE (ITF_ESTOQUE = ''N'')            ';

    Lc_Qr_Criterio.SQL.Add(Lc_SqlTxt);

    Lc_Qr_Criterio.Active := true;
    Lc_Qr_Criterio.FetchAll;
    if Lc_Qr_Criterio.RecordCount > 0 then
      begin
      Lc_Qr_Criterio.First;
      Lc_Criterio := 'WHERE (PED_CODIGO IN ( ';
      while not Lc_Qr_Criterio.Eof do
        begin
        if Lc_Qr_Criterio.Bof then
          Lc_Criterio := Lc_Criterio + Lc_Qr_Criterio.FieldByName('ITF_CODPED').AsString
        else
          Lc_Criterio := Lc_Criterio + ',' + Lc_Qr_Criterio.FieldByName('ITF_CODPED').AsString;
          Lc_Qr_Criterio.Next;
        end;
      Result := Lc_Criterio + '))';
      end
    else
      Result := '';
  finally
    FreeAndNil(Lc_Qr_Criterio);
  end;
end;

procedure TFr_Despacho.Pc_BuscarPedidos;
var
  Lc_Sqltxt: string;
  Lc_Codped, Lc_Cliente, Lc_Codpro, Lc_Produto: boolean;
begin
  Lc_Sqltxt := '';
  Screen.Cursor := crHourGlass;
  Qr_Vendas.Active:=FALSE;
  Qr_Vendas.sql.Clear;

  if E_CodPed.Text = '' then Lc_Codped := False else Lc_Codped := True;
  if Cb_Busca_Empresa.Text = ''  then Lc_Cliente := False else Lc_Cliente := True;
  if (Fm_ListaProdutos.E_Cd_Produto.Text = '') then Lc_Codpro := false else Lc_Codpro := true;
  if (Fm_ListaProdutos.E_Busca_Produto.Text = '') then Lc_Produto := false else Lc_Produto := true;

  Lc_Sqltxt := ' SELECT DISTINCT PED_CODIGO, '+
               ' EMP_NOME, '+
               ' EMP_FANTASIA, '+
               ' PED_DATA, '+
               ' PED_NUMERO, '+
               ' PED_VL_PEDIDO '+
               ' FROM tb_despacho tb_despacho '+
               '   INNER JOIN TB_PEDIDO Tb_pedido '+
               '   ON  (Tb_pedido.PED_codigo = tb_despacho.DSP_CODPED)   '+
               '   inner JOIN tb_empresa tb_empresa ON '+
               '  (tb_empresa.emp_codigo = Tb_pedido.PED_codemp)  ';

  if (Lc_Codpro)  then
    Begin
    Lc_Sqltxt:=   Lc_Sqltxt +
             '   INNER JOIN TB_PRODUTO Tb_produto                          '+
             '   ON  (Tb_produto.PRO_CODIGO = tb_despacho.DSP_CODPRO)     ';
    end;

  Lc_Sqltxt := Lc_Sqltxt + ' WHERE (PED_TIPO = 1) ';

  if Rg_Filtro.ItemIndex = 0 then
    Begin
      Lc_Sqltxt := Lc_Sqltxt + ' AND DSP_SITUACAO = ''P'' ';
    end;
  if Rg_Filtro.ItemIndex = 1 then
    beGIN
      Lc_Sqltxt := Lc_Sqltxt + ' AND DSP_SITUACAO = ''S'' ';
    end;

  if Lc_Codped then Lc_Sqltxt := Lc_Sqltxt + 'AND (PED_NUMERO =:PED_NUMERO)' ;
  IF ChBx_Periodo.Checked then Lc_Sqltxt := Lc_Sqltxt + 'AND (PED_DATA BETWEEN :DATAINI AND :DATAFIM) ';
  if Lc_Cliente then Lc_Sqltxt := Lc_Sqltxt + 'AND ( (EMP_NOME LIKE :EMP_NOME) or (EMP_FANTASIA LIKE :EMP_NOME) ) ';

  IF Lc_Codpro THEN
    BEGIN
      IF StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0) = 0 THEN
         Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO))'
      ELSE
         Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGO =:PRO_CODIGO) or (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO))';
    END;

  if Lc_Produto then Lc_Sqltxt := Lc_Sqltxt + 'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

  if ChBx_Fantasia.Checked then
    begin
      DBG_Pesquisa.Columns.Items[0].Title.Caption := 'Nome Fantasia/Apelido/Codnome';
      DBG_Pesquisa.Columns.Items[0].FieldName := 'EMP_FANTASIA'
    end
  else
    begin
      DBG_Pesquisa.Columns.Items[0].Title.Caption := 'Nome/Razão Social';
      DBG_Pesquisa.Columns.Items[0].FieldName := 'EMP_NOME';
    end;

  Qr_Vendas.SQL.Add(Lc_Sqltxt + ' ORDER BY EMP_NOME, PED_DATA ');

  if Lc_Codped then
    Qr_Vendas.ParamByName('PED_NUMERO').AsString := E_CodPed.Text;


  IF ChBx_Periodo.Checked then
    Begin
      Qr_Vendas.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      Qr_Vendas.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    end;

  if Lc_Cliente then Qr_Vendas.ParamByName('EMP_NOME').AsString := '%' + Cb_Busca_Empresa.Text + '%';
  if Lc_Codpro then Qr_Vendas.ParamByName('PRO_CODIGO').AsString := Fm_ListaProdutos.E_Cd_Produto.Text;
  if Lc_Produto then Qr_Vendas.ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(Fm_ListaProdutos.E_Busca_Produto.Text,1,98) + '%';

  Qr_Vendas.Active := true;
  Qr_ItensVda.Active := true;
  Screen.Cursor := crDefault;
end;

procedure TFr_Despacho.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Despacho.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and (ActiveControl = E_BuscaCodigo) then
  begin
    Key := #0;

    if ValidaLancaItem then
      LancaItem;

    Exit;
  end;

  if (Key = #13) and not (ActiveControl is TDBMemo) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Despacho.FocoCampoCodigoBarras;
begin
  if not F_DespachoByBarCode then exit;
  Pg_Info.ActivePage := Tbs_Pendente;
  if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
end;

procedure TFr_Despacho.FormataUsoLeitorCodigoBarras;
begin
  Pnl_Top_Despachar.Visible := F_DespachoByBarCode;
  SB_Despachar.Visible := not F_DespachoByBarCode;

end;

procedure TFr_Despacho.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil( FDespacho);
end;

procedure TFr_Despacho.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
       VK_F2: FocoCampoCodigoBarras;
       VK_F3:if SB_Despachar.Visible then SB_DespacharClick(Sender);
       VK_F4:if Sb_Retornar.Visible then Sb_RetornarClick(Sender);
       VK_F7:if SB_Buscar.Enabled then SB_BuscarClick(Sender);
       VK_F8:if SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
       VK_Escape: if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
    end;
    end;
end;

procedure TFr_Despacho.SB_BuscarClick(Sender: TObject);
begin
  Pc_BuscarPedidos;
  Pg_Info.ActivePage:= Tbs_Pendente;
  Pg_InfoChange(Self);

end;

procedure TFr_Despacho.SB_DespacharClick(Sender: TObject);
Var
  Lc_Form : TFr_Lanca_Despacho;
begin
  Lc_Form := Nil;
  Try
    Pg_Info.ActivePage:= Tbs_Pendente;
    Lc_Form := TFr_Lanca_Despacho.create(Nil);
    Lc_Form.E_Cd_Produto.Text := Qr_Pendente.FieldByName('PRO_CODIGO').AsString;
    Lc_Form.E_Descricao.Text  := Qr_Pendente.FieldByName('PRO_DESCRICAO').AsString;
    Lc_Form.E_Quantidade.Text := FloatToStrF(Qr_Pendente.FieldByName('DSP_QTDE').AsFloat,ffFixed,10,3);
    Lc_Form.It_Cd_Despacho    := Qr_Pendente.fieldbyname('DSP_CODIGO').AsInteger;
    Lc_Form.It_Cd_Pedido      := Qr_Pendente.fieldbyname('ITF_CODPED').AsInteger;
    Lc_Form.It_Cd_Item        := Qr_Pendente.fieldbyname('ITF_CODIGO').AsInteger;
    Lc_Form.It_cd_Produto     := Qr_Pendente.FieldByName('PRO_CODIGO').AsInteger;
    Lc_Form.It_Qt_Item        := Qr_Pendente.FieldByName('DSP_QTDE').AsFloat;
    Lc_Form.Pc_ConsultaDespacho;
    Lc_Form.ShowModal;
  Finally
    FreeAndnil( Lc_Form );
    Qr_Pendente.Active := False;
    Qr_Pendente.Active := True;
  End;
end;

procedure TFr_Despacho.Sb_RetornarClick(Sender: TObject);
begin
  Pg_Info.ActivePage:= Tbs_Despachado;
  if F_DespachoByBarCode then
  Begin
    if ValidaRetornoTotalDespacho then
      RetornoTotal;
  end
  else
  Begin
    if ValidaRetornoManualDespacho then
      RetornoManual;
  end;
  Sb_Retornar.Enabled := It_Retornar;
end;

procedure TFr_Despacho.RetornoManual;
Var
  Lc_I : Integer;
  Lc_Contador : Integer;
begin
  For Lc_I := 1 to StrGrd_Despachados.RowCount - 1 do
    Begin
    if (StrGrd_Despachados.Cells[8,Lc_I] = 'X') then
      Begin
      Qr_Despachados.Active := true;
      Qr_Despachados.First;
      if (Qr_Despachados.Locate('DSP_CODIGO',StrGrd_Despachados.Cells[1,Lc_I],[] )) then
        Begin
          FDespacho.DeletaDespacho(Qr_Despachados.FieldByName('ITF_CODIGO').AsInteger,
                            Qr_Despachados.FieldByName('DSP_CODIGO').AsInteger);
        end;
      end;
    end;
  Pc_MostrarDespachados;
end;

procedure TFr_Despacho.RetornoTotal;
Var
  Lc_I : Integer;
begin
  For Lc_I := 1 to StrGrd_Despachados.RowCount - 1 do
  Begin
    Qr_Despachados.Active := true;
    Qr_Despachados.First;
    if (Qr_Despachados.Locate('DSP_CODIGO',StrGrd_Despachados.Cells[1,Lc_I],[] )) then
      Begin
        FDespacho.DeletaDespacho(Qr_Despachados.FieldByName('ITF_CODIGO').AsInteger,
                          Qr_Despachados.FieldByName('DSP_CODIGO').AsInteger);
      end;
  end;
  Pc_MostrarDespachados;
end;

procedure TFr_Despacho.Rg_FiltroClick(Sender: TObject);
begin
  Pc_BuscarPedidos;
  Pg_Info.ActivePageIndex := Rg_Filtro.ItemIndex;  
  Pg_InfoChange(Self);  
end;

procedure TFr_Despacho.Pc_ImprimeDespacho;
begin
  if Qr_Vendas.RecordCount > 0 then
    Begin
    try
      if not Assigned(RL_despacho) then Application.CreateForm(TRL_despacho, RL_despacho);
      RL_despacho.Qrpt.Preview;
    finally
      RL_despacho.Close;
    end;
    end
  else
    Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Não existem dados para imprimir.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'], [bEscape], mpInformacao);
    end;
end;

procedure TFr_Despacho.Pc_ImprimeSeparacao;
Var
  Lc_Imp: TimpModImpressao;
begin
  Pg_Info.ActivePage := Tbs_Pendente;
  if Qr_Pendente.RecordCount > 0 then
  Begin
    Try
      Lc_Imp := TimpModImpressao.create(nil);
      Lc_Imp.Pc_Imp_Cupom_Dsp_Separacao(Qr_Pendente.FieldByName('ITF_CODPED').AsInteger);
    Finally
      FreeandNil(Lc_Imp);
    end;
  end
  else
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Não existem dados para imprimir.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'], [bEscape], mpInformacao);
  end;
end;

procedure TFr_Despacho.Pc_ImprimeDevolucao;
Var
  Lc_I : Integer;
  Lc_SqlCriterio : String;
  Lc_Imp : TimpModImpressao;
begin
  Pg_Info.ActivePage := Tbs_Devolucao;
  Lc_SqlCriterio := '';
  For Lc_I := 1 to StrGrd_Devolucao.RowCount - 1 do
  Begin
    if (StrGrd_Devolucao.Cells[7,Lc_I] = 'X') then
    Begin
      if (Trim(Lc_SqlCriterio) = '') then
        Lc_SqlCriterio := StrGrd_Devolucao.Cells[1,Lc_I]
      else
        Lc_SqlCriterio := Lc_SqlCriterio + ',' + StrGrd_Devolucao.Cells[1,Lc_I];
    end;
  end;
  if (Trim(Lc_SqlCriterio) <> '') then
  Begin
    try
      Lc_Imp := TimpModImpressao.create(nil);
      Lc_Imp.Pc_Imp_Cupom_Dsp_Devolucao(Lc_SqlCriterio);
    finally
      FreeandNil(Lc_Imp);
    end;
  end
  else
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Não existem dados para imprimir.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'], [bEscape], mpInformacao);
  end;
end;

procedure TFr_Despacho.Pc_RegistraImpressao;
Var
  Lc_I : Integer;
  Lc_SqlCriterio : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Lc_SqlCriterio := '';
  For Lc_I := 1 to StrGrd_Despachados.RowCount - 1 do
  Begin
    if (StrGrd_Despachados.Cells[8,Lc_I] = 'X') then
    Begin
      if (Trim(Lc_SqlCriterio) = '') then
        Lc_SqlCriterio := StrGrd_Despachados.Cells[1,Lc_I]
      else
        Lc_SqlCriterio := Lc_SqlCriterio + ',' + StrGrd_Despachados.Cells[1,Lc_I];
    end;
  end;
  if (Trim(Lc_SqlCriterio) <> '') then
  Begin
    Try
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        SQL.Add('UPDATE TB_DESPACHO SET '+
                 'DSP_IMPRESSO = ''S'' '+
                 'WHERE ( DSP_CODIGO IN (' + Lc_SqlCriterio + '))');
        ExecSQL;
      end;
    Finally
      LcBase.FinalizaQuery(Lc_Qry);
      FreeAndNil(LcBase);
    End;
  End;
end;

procedure TFr_Despacho.Pc_ImprimeDespachados;
Var
  Lc_I : Integer;
  Lc_SqlCriterio : String;
  Lc_Imp : TimpModImpressao;
begin
  Pg_Info.ActivePage := Tbs_Despachado;
  Lc_SqlCriterio := '';
  For Lc_I := 1 to StrGrd_Despachados.RowCount - 1 do
  Begin
    if (StrGrd_Despachados.Cells[8,Lc_I] = 'X') then
    Begin
      if (Trim(Lc_SqlCriterio) = '') then
        Lc_SqlCriterio := StrGrd_Despachados.Cells[1,Lc_I]
      else
        Lc_SqlCriterio := Lc_SqlCriterio + ',' + StrGrd_Despachados.Cells[1,Lc_I];
    end;
  end;
  if (Trim(Lc_SqlCriterio) <> '') then
  Begin
    Try
      Lc_Imp := TimpModImpressao.create(nil);
      Lc_Imp.Pc_Imp_Cupom_Dsp_Despachados(Lc_SqlCriterio);
    Finally
      FreeandNil(Lc_Imp);
    end;
  end
  else
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Não existem dados para imprimir.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'], [bEscape], mpInformacao);
  end;
end;

procedure TFr_Despacho.Pc_ImprimeItensPedido;
Begin
  MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                 'Não há impressão para a aba de Itens do Pedido.'+EOLN+
                 'Posicione em Pendentes/Depachados ou controle de Devolução'+EOLN,
                 ['OK'], [bEscape], mpInformacao);
end;

procedure TFr_Despacho.SB_ImprimirClick(Sender: TObject);
Var
  Lc_Escolha : Integer;
Begin
  if (Fc_Tb_Geral('L','DSP_G_CTRL_SEPARACAO','S') = 'S') then
    Begin
    case Pg_Info.ActivePageIndex of
      0:Begin
        Pc_ImprimeSeparacao;
        end;
      1:Begin
        Pc_ImprimeDespachados;
        Pc_RegistraImpressao;
        Pc_MostrarDespachados;
        end;
      2:Begin
        Pc_ImprimeItensPedido;
        end;
      3:Begin
        Pc_ImprimeDevolucao;
        end;
      end;
    end
  else
    Begin
    Pc_ImprimeDespacho;
    end;
end;

procedure TFr_Despacho.DBG_PesquisaTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(DBG_Pesquisa, Column);
end;

procedure TFr_Despacho.FormShow(Sender: TObject);
begin
  Pc_formataTela;
  Pc_ImagemBotao;
  Pc_PermissaoBotao('Despacho de Mercadorias');
  Pc_IniciaVariaveis;
  FormataUsoLeitorCodigoBarras;
end;

procedure TFr_Despacho.LancaItem;
var
  Lc_qtde : Real;
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Application.ProcessMessages;
    Self.Enabled := False;
    Lb_Item_lancado.Caption := Qr_Pendente.fieldbyname('PRO_DESCRICAO').AsString;

    Lc_qtde := Qr_Pendente.FieldByName('DSP_QTDE').AsFloat;

    FDespacho.Registro.Codigo        := Qr_Pendente.fieldbyname('DSP_CODIGO').AsInteger;
    FDespacho.Registro.Pedido        := Qr_Pendente.fieldbyname('ITF_CODPED').AsInteger;
    FDespacho.Registro.ItemPedido    := Qr_Pendente.fieldbyname('ITF_CODIGO').AsInteger;
    FDespacho.Registro.Produto       := Qr_Pendente.FieldByName('PRO_CODIGO').AsInteger;
    FDespacho.Registro.DataRealizada := Date;
    FDespacho.Registro.Qtde          := 1;
    FDespacho.AtualizaDespacho;

    Lc_qtde := Lc_qtde - 1;

    if (Lc_qtde > 0 ) then
    Begin
      FDespacho.Clear;
      FDespacho.Registro.Codigo        := 0;
      FDespacho.Registro.Pedido        := Qr_Pendente.fieldbyname('ITF_CODPED').AsInteger;
      FDespacho.Registro.ItemPedido    := Qr_Pendente.fieldbyname('ITF_CODIGO').AsInteger;
      FDespacho.Registro.Produto       := Qr_Pendente.FieldByName('PRO_CODIGO').AsInteger;
      FDespacho.Registro.DataRealizada := Date;
      FDespacho.Registro.Qtde          := Lc_qtde;
      FDespacho.Registro.Situacao      := 'P';
      FDespacho.Insert;
    End;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
    Application.ProcessMessages;
    Qr_Pendente.Active := False;
    Qr_Pendente.Active := True;
    E_BuscaCodigo.Clear;
    ValidafinalizacaoDespachados;
  end;
end;

procedure TFr_Despacho.LiberacaoExecute(Sender: TObject);
Var
  Form : TFr_Liberacao;
begin
  Try
    Form := TFr_Liberacao.Create(nil);
    with Form do
    begin
      Liberado := False;
      It_Interface := 'Fr_Despacho';
      It_Nome_Menu := 'Despacho de Mercadorias';
      It_Privilegio := 'RETORNAR';
      ShowModal;
      Sb_Retornar.Enabled := GB_Liberado;

    end;
  Finally
    FreeAndNil(Form);
  End;

end;

procedure TFr_Despacho.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //SB_Despachar.Glyph.Assign(Fc_CarregaImagemBotao('INSERIR'));
    //Sb_Retornar.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    SB_Buscar.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    SB_Imprimir.Glyph.Assign(Fc_CarregaImagemBotao('IMPRIMIR'));
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Despacho.Pg_InfoChange(Sender: TObject);
begin
  Qr_Pendente.Active := False;
  Qr_Despachados.Active := False;
  Qr_ItensVda.Active := False;
  IF Qr_Vendas.RecordCount > 0 then
    Begin
    Case Pg_Info.ActivePageIndex of
      0:Begin
        //Buscar somente entregues
        Qr_Pendente.ParamByName('PED_CODIGO').AsInteger := Qr_Vendas.Fieldbyname('PED_CODIGO').AsInteger;
        Qr_Pendente.Active := True;
        Qr_Pendente.FetchAll;
        end;
      1:Begin
        //Buscar somente despachados
        Pc_MostrarDespachados;
        end;
      2:Begin
        //Buscar itens do Pedido
        Qr_ItensVda.ParamByName('PED_CODIGO').AsInteger := Qr_Vendas.Fieldbyname('PED_CODIGO').AsInteger;
        Qr_ItensVda.Active := True;
        Qr_ItensVda.FetchAll;
        end;
      end;
    end;
  Case Pg_Info.ActivePageIndex of
    3:Begin
      Pc_buscarDevolvidos;
      end;
    end;
end;


procedure TFr_Despacho.Dbg_ItensVdaTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(Dbg_ItensVda, Column);
end;

procedure TFr_Despacho.Dbg_PendenteTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(Dbg_Pendente, Column);
end;

procedure TFr_Despacho.Qr_VendasAfterOpen(DataSet: TDataSet);
begin
  (Qr_Vendas.FieldByName('PED_VL_PEDIDO') as TNumericField).DisplayFormat  := '0.00##';
  Pg_InfoChange(Self);
end;

procedure TFr_Despacho.Qr_PendenteAfterOpen(DataSet: TDataSet);
begin
  (Qr_Pendente.FieldByName('DSP_QTDE') as TNumericField).DisplayFormat  := '0.00##';
end;

procedure TFr_Despacho.Qr_ItensVdaAfterOpen(DataSet: TDataSet);
begin
  (Qr_ItensVda.FieldByName('ITF_QTDE') as TNumericField).DisplayFormat  := '0.00##';

  (Qr_ItensVda.FieldByName('ITF_VL_UNIT') as TNumericField).DisplayFormat  := '0.00##';
  (Qr_ItensVda.FieldByName('ITF_VL_SB_TOTAL') as TNumericField).DisplayFormat  := '0.00##';
end;

procedure TFr_Despacho.Qr_VendasAfterScroll(DataSet: TDataSet);
begin
  Pg_InfoChange(Self);
end;

procedure TFr_Despacho.E_BuscaCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    If ValidaLancaItem then LancaItem;
end;

procedure TFr_Despacho.E_cd_EmpresaExit(Sender: TObject);
begin
  if ChBx_Nome.checked then
    Cb_Busca_Empresa.Text := Fc_BuscaNomeCliente('EMP_NOME',E_Cd_Empresa.Text)
  else
    Cb_Busca_Empresa.Text := Fc_BuscaNomeCliente('EMP_FANTASIA',E_Cd_Empresa.Text);
end;

procedure TFr_Despacho.ChBx_NomeClick(Sender: TObject);
begin
  Pc_ListaClienteComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,Cb_Busca_Empresa);
  If ChBx_Nome.Checked and Qr_vendas.Active then
  Begin
    DBG_Pesquisa.Columns[0].Title.Caption := 'Nome/Razão Social';
    DBG_Pesquisa.Columns[0].FieldName := 'EMP_NOME';
  end;
end;

procedure TFr_Despacho.ChBx_FantasiaClick(Sender: TObject);
begin
  Pc_ListaClienteComboBox('EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,Cb_Busca_Empresa);
  If ChBx_Nome.Checked and Qr_vendas.Active then
  Begin
    DBG_Pesquisa.Columns[0].Title.Caption := 'Apelido/Nome Fantasia';
    DBG_Pesquisa.Columns[0].FieldName := 'EMP_FANTASIA';
  end;  
end;

procedure TFr_Despacho.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Despacho.Qr_DespachadosAfterOpen(DataSet: TDataSet);
begin
  (Qr_Despachados.FieldByName('DSP_QTDE') as TNumericField).DisplayFormat  := '0.00##';
end;

procedure TFr_Despacho.StrGrd_DevolucaoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  if (ACol = 2)and(ARow>0) Then
    begin
    if (StrGrd_Devolucao.Cells[1,ARow] <> '') then
      Begin
      if (StrGrd_Devolucao.Cells[7,ARow] = 'X') then
        DrawFrameControl(StrGrd_Devolucao.Canvas.Handle, Rect,DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED) // Desenha o CheckBox desmarcado
      else
        DrawFrameControl(StrGrd_Devolucao.Canvas.Handle, Rect,   DFC_BUTTON, DFCS_BUTTONCHECK); // Desenha o CheckBox marcado
      end;
    end
  else
    Begin
    If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
      Begin
      if (StrGrd_Devolucao.Cells[7,ARow] = '') then
        Begin
        StrGrd_Devolucao.Canvas.Font.Color:= clBlack;
        StrGrd_Devolucao.Canvas.Brush.Color:= clCream;
        end
      else
        Begin
        StrGrd_Devolucao.Canvas.Font.Color:= clBlack;
        StrGrd_Devolucao.Canvas.Brush.Color:= clMoneyGreen;
        end;
      StrGrd_Devolucao.Canvas.FillRect(Rect); // redesenha a celula
      StrGrd_Devolucao.Canvas.TextOut(Rect.Left+2,Rect.Top,StrGrd_Devolucao.Cells[acol,arow]); // reimprime o texto.
      // Pega o texto da célula
      Texto := StrGrd_Devolucao.Cells[acol, ARow];

      //{ Calcura largura e altura (em pontos) do texto
      LarguraTexto := StrGrd_Devolucao.Canvas.TextWidth(Texto);
      AlturaTexto := StrGrd_Devolucao.Canvas.TextHeight(Texto);

      // Calcula a posição horizontal do início do texto
      if  (ACol = 3) or (ACol = 4) then // esquerda
        X := Rect.Left + 2
      else
      if  (ACol = 5)   then // Centro
        X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
      else // Direita
        X := Rect.Right - LarguraTexto - 2;

      // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
      Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
      StrGrd_Devolucao.Canvas.TextRect(Rect, X, Y, Texto);
      end;
    end;

end;

function TFr_Despacho.ValidafinalizacaoDespachados: Boolean;
begin
  Result := True;
  if Qr_Pendente.RecordCount = 0 then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                  'Todos os itens foram conferidos.'+EOLN+
                  'Processo de despacho efetivado com Sucesso'+EOLN,
                  ['OK'], [bEscape], mpInformacao);
    Result := False;
    Exit;
  end;

end;

function TFr_Despacho.ValidaItensDespachados: Boolean;
begin
  Result := True;
  if StrGrd_Despachados.RowCount = 0 then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Não existem itens na lista para retornar.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
  end;
end;

function TFr_Despacho.ValidaItensPendentes: boolean;
Begin
  Result := true;
  IF not Qr_Pendente.Active then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Consulta de Pendentes não esta ativa.'+EOLN+
                   'Refaça a pesquisa'+EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    Exit;
  end;

  if not ValidafinalizacaoDespachados then
  Begin
    Result := False;
    Exit;
  end;
end;

function TFr_Despacho.ValidaLancaItem: Boolean;
var
  Lc_Form : TFr_FotoProduto;
begin
  REsult := True;
  if not Qr_Vendas.Active then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Nenhum pesquisa foi efetuada.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
  end;

  if Qr_Vendas.recordCount = 0 then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Nenhum pedido encontrado, não é possivel lancar item.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
  end;

  if Qr_Vendas.recordCount > 1 then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Com a opção de leitura de código de barras para despacho de produto.'+EOLN+
                   'Apenas um pedido deve ser pesquisado por vez para evitar erros de despachos entre pedidos.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
  end;

  if not ValidaItensPendentes then
  Begin
    Result := False;
    exit;
  end;

  if Length(Trim(E_BuscaCodigo.Text)) <= 6 then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Código de barras não existente ou inválido com menos de 7 digitos por exemplo.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
  end;

  Qr_Pendente.First;
  if not Qr_Pendente.Locate('PRO_CODIGOBAR',E_BuscaCodigo.Text,[]) then
  Begin
    Lb_Item_lancado.Caption := 'Código de barras informado não encontrado na lista de pendentes.';
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   Lb_Item_lancado.Caption+EOLN+
                   'O item pode ter sido já despachado ou então'+EOLN+
                   'entregue o item não localizado no despacho ao teu supervior'+EOLN+
                   'Clique em OK para continuar a conferência dos próximos itens.'+EOLN,
                   ['OK'], [bEscape], mpInformacao);

    Result := False;
    exit;
  end;

  Try
    Lc_Form := TFr_FotoProduto.Create(Fr_Pesq_Produto);
    Lc_Form.It_Cd_Produto := StrToIntDef(Qr_Pendente.FieldByName('PRO_CODIGO').AsString, 0);
    Lc_Form.ModoDespacho := True;
    Lc_Form.ShowModal;
    Result := Lc_Form.ModoDespacho;
  Finally
    FreeAndNil(Lc_Form);
  End;

  if not Result then
  Begin
    E_BuscaCodigo.Clear;
    E_BuscaCodigo.SetFocus;
  End;


end;

function TFr_Despacho.ValidaRetornoManualDespacho: Boolean;
Var
  Lc_I : Integer;
  Lc_Contador : Integer;
begin
  Result := True;

  if not ValidaItensDespachados then
  Begin
    Result := False;
    exit;
  End;

  Lc_Contador := 0;
  For Lc_I := 1 to StrGrd_Despachados.RowCount - 1 do
  Begin
    if (StrGrd_Despachados.Cells[8,Lc_I] = 'X') and (Trim(StrGrd_Despachados.Cells[1,Lc_I]) <>'') then Inc(Lc_Contador);
  end;
  if Lc_Contador = 0 then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Não existem itens selecionados para retornar.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
  end;

  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja realmente retornar os despachos selecionados.' + EOLN + EOLN +
                     'Confirmar a operação ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
  Begin
    Result := False;
    exit;
  End;
end;

function TFr_Despacho.ValidaRetornoTotalDespacho: Boolean;
begin
  Result := True;

  if not ValidaItensDespachados then
  Begin
    Result := False;
    exit;
  End;

  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja realmente todos os itens despachos.' + EOLN + EOLN +
                     'Confirmar a operação ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
  Begin
    Result := False;
    exit;
  End;

end;

procedure TFr_Despacho.StrGrd_DevolucaoClick(Sender: TObject);
begin
  IF StrGrd_Devolucao.Cells[7,StrGrd_Devolucao.Row]= 'X' then
    StrGrd_Devolucao.Cells[7,StrGrd_Devolucao.Row] := ''
  else
    StrGrd_Devolucao.Cells[7,StrGrd_Devolucao.Row] := 'X';
  StrGrd_Devolucao.Repaint;
end;

procedure TFr_Despacho.SB_Add_Tudo_DevolucaoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For LC_I := 1 to StrGrd_Devolucao.RowCount -1 do
    Begin
    StrGrd_Devolucao.Cells[7,Lc_I] := 'X';
    end;
  StrGrd_Devolucao.Repaint;
end;

procedure TFr_Despacho.SB_Retirar_Tudo_DevolucaoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For LC_I := 1 to StrGrd_Devolucao.RowCount -1 do
    Begin
    StrGrd_Devolucao.Cells[7,Lc_I] := '';
    end;
  StrGrd_Devolucao.Repaint;

end;

procedure TFr_Despacho.Sb_Exc_ItensSelecionadosClick(Sender: TObject);
Var
  Lc_I : Integer;
  Lc_Nr_Itens : Integer;
begin
  Lc_Nr_Itens := 0;
  For LC_I := 1 to StrGrd_Devolucao.RowCount -1 do
    Begin
    if (StrGrd_Devolucao.Cells[7,Lc_I] = 'X') then
      Lc_Nr_Itens := Lc_Nr_Itens + 1;
    end;
  if (Lc_Nr_Itens =0) then
    Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN +EOLN +
                   'Nenhum item foi marcado para excluir.' + EOLN + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    end
  else
    Begin
    If (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja realmente excluir os itens selecionados.'+EOLN+EOLN+
                       'Confirmar a exclusão ?',
                      [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clRed) = mrBotao1) then
      Begin
      Qr_Acao.Close;
      Qr_Acao.Transaction := DM.IB_Transacao;
      Qr_Acao.SQL.Clear;
      Qr_Acao.SQL.Add('DELETE FROM TB_DESPACHO WHERE DSP_CODIGO=:DSP_CODIGO ');
      For LC_I := 1 to StrGrd_Devolucao.RowCount -1 do
        Begin
        if (StrGrd_Devolucao.Cells[7,Lc_I] = 'X') then
          Begin
          if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
          Qr_Acao.Active := False;
          Qr_Acao.ParamByName('DSP_CODIGO').AsString := StrGrd_Devolucao.Cells[1,lC_I];
          Qr_Acao.ExecSQL;
          if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
          end;
        end;
      Pc_buscarDevolvidos;
      end;
    end;
end;

procedure TFr_Despacho.SB_Add_Tudo_DespachadosClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For LC_I := 1 to StrGrd_Despachados.RowCount -1 do
    Begin
    StrGrd_Despachados.Cells[8,Lc_I] := 'X';
    end;
  StrGrd_Despachados.Repaint;

end;

procedure TFr_Despacho.SB_Retirar_Tudo_DespachadosClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For LC_I := 1 to StrGrd_Despachados.RowCount -1 do
    Begin
    StrGrd_Despachados.Cells[8,Lc_I] := '';
    end;
  StrGrd_Despachados.Repaint;

end;

procedure TFr_Despacho.StrGrd_DespachadosDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  if (ACol = 2)and(ARow>0) Then
    begin
    if (StrGrd_Despachados.Cells[1,ARow] <> '') then
      Begin
      if (StrGrd_Despachados.Cells[8,ARow] = 'X') then
        DrawFrameControl(StrGrd_Despachados.Canvas.Handle, Rect,DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED) // Desenha o CheckBox desmarcado
      else
        DrawFrameControl(StrGrd_Despachados.Canvas.Handle, Rect,   DFC_BUTTON, DFCS_BUTTONCHECK); // Desenha o CheckBox marcado
      end;
    end
  else
    Begin
    If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
      Begin
      if (StrGrd_Despachados.Cells[8,ARow] = '') then
        Begin
        StrGrd_Despachados.Canvas.Font.Color:= clBlack;
        StrGrd_Despachados.Canvas.Brush.Color:= clCream;
        end
      else
        Begin
        StrGrd_Despachados.Canvas.Font.Color:= clBlack;
        StrGrd_Despachados.Canvas.Brush.Color:= clMoneyGreen;
        end;
      StrGrd_Despachados.Canvas.FillRect(Rect); // redesenha a celula
      StrGrd_Despachados.Canvas.TextOut(Rect.Left+2,Rect.Top,StrGrd_Despachados.Cells[acol,arow]); // reimprime o texto.
      // Pega o texto da célula
      Texto := StrGrd_Despachados.Cells[acol, ARow];

      //{ Calcura largura e altura (em pontos) do texto
      LarguraTexto := StrGrd_Despachados.Canvas.TextWidth(Texto);
      AlturaTexto := StrGrd_Despachados.Canvas.TextHeight(Texto);

      // Calcula a posição horizontal do início do texto
      if  (ACol = 3) or (ACol = 4) then // esquerda
        X := Rect.Left + 2
      else
      if  (ACol = 5)   then // Centro
        X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
      else // Direita
        X := Rect.Right - LarguraTexto - 2;

      // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
      Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
      StrGrd_Despachados.Canvas.TextRect(Rect, X, Y, Texto);
      end;
    end;


end;

procedure TFr_Despacho.StrGrd_DespachadosClick(Sender: TObject);
begin
  IF StrGrd_Despachados.Cells[8,StrGrd_Despachados.Row]= 'X' then
    StrGrd_Despachados.Cells[8,StrGrd_Despachados.Row] := ''
  else
    StrGrd_Despachados.Cells[8,StrGrd_Despachados.Row] := 'X';
  StrGrd_Despachados.Repaint;
end;

procedure TFr_Despacho.Sb_Pesq_EmpresaClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(1,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
    Cb_Busca_Empresa.Text := Lc_Retorno.It_Dados[1,1];
  end;
end;

end.

