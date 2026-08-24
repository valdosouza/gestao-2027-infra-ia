unit UN_Imp_MapaCarga;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, StdCtrls, Grids, DBGrids, Mask, Buttons, ExtCtrls, DBCtrls, ComCtrls, QEdit_Setes, ControllerCtrlLote, UN_TabelasEmListas;

type
   TFr_Imp_MapaCarga = class(TForm)
      DS_Qr_MapaCarga: TDataSource;
      Qr_Pesquisa: TSTQuery;
    Pg_MapaCarga: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    Pnl_Fundo: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    SB_Add_Tudo: TSpeedButton;
    SB_Retirar_Tudo: TSpeedButton;
    Label6: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    E_PedINI: TMaskEdit;
    E_PedFIM: TMaskEdit;
    DBLCB_Vendedor: TDBLookupComboBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    CB_Tipo: TComboBox;
    Pnl_Botao: TPanel;
    SB_Imprimir: TSpeedButton;
    SB_Filtrar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Sb_RetiraPedido: TSpeedButton;
    StrGrd_Pedido: TStringGrid;
    GroupBox1: TGroupBox;
    Pnl_Busca: TGroupBox;
    SB_Buscar: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    Sb_Voltar: TSpeedButton;
    DBG_Pesquisa: TDBGrid;
    Label36: TLabel;
    Lb_Placa: TLabel;
    E_BuscaMotorista: TEdit;
    E_BuscaPedido: TEdit_Setes;
    E_Busca_Data_Ini: TDateTimePicker;
    E_Busca_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Label2: TLabel;
    Qr_MapaCarga: TSTQuery;
    Ds_MapaCarga: TDataSource;
    E_BuscaPlaca: TMaskEdit;
    Sb_Pesq_MapaCarga: TSpeedButton;
    Sb_Salvar: TSpeedButton;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label8: TLabel;
    E_Placa: TMaskEdit;
    E_Motorista: TMaskEdit;
    Sb_Apl_Lote: TSpeedButton;
    Rg_Agrupamento: TRadioGroup;
    ChBx_NaoMostraLote: TCheckBox;
      procedure SB_FiltrarClick(Sender: TObject);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure StrGrd_PedidoDrawCell(Sender: TObject; ACol, ARow: Integer;
         Rect: TRect; State: TGridDrawState);
      procedure Sb_RetiraPedidoClick(Sender: TObject);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure StrGrd_PedidoKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure SB_ImprimirClick(Sender: TObject);
      procedure DBLCB_VendedorKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure chbx_EmpresasClick(Sender: TObject);
    procedure StrGrd_PedidoClick(Sender: TObject);
    procedure SB_Add_TudoClick(Sender: TObject);
    procedure SB_Retirar_TudoClick(Sender: TObject);
    procedure Sb_Pesq_MapaCargaClick(Sender: TObject);
    procedure Sb_VoltarClick(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure DBG_PesquisaTitleClick(Column: TColumn);
    procedure Sb_SalvarClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure Sb_Apl_LoteClick(Sender: TObject);
    procedure CB_TipoChange(Sender: TObject);
   private
    { Private declarations }
   public
    { Public declarations }
    It_Visualizar :Boolean;
    It_Imprimir :Boolean;
    It_Retirar :Boolean;
    It_Filtrar  :Boolean;
    procedure Pc_Buscar;
    procedure Pc_PreencherMapaCarga;
    procedure Pc_Del_Lin_Grid(Pc_strGrid: TStringGrid);
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;
    procedure Pc_AgrupadoProdutos;
    procedure Pc_AgrupadoVendedor;
    procedure Pc_DadosFinanceiros;
    procedure Pc_FormaPagamento;
    procedure Pc_FormataTela;
    procedure Pc_BuscarMapaCArga;
    procedure Pc_VisualizarMapaCArga;
    procedure Pc_GravaMapaCarga;
    function Fc_LastIdMapaCarga():Integer;
   end;

var
   Fr_Imp_MapaCarga: TFr_Imp_MapaCarga;

implementation

uses     Un_DM, UN_Sistema, Un_MSG, Un_Regra_Negocio, RN_Estoque, UN_Principal, env, Un_RL_MapaCargaFinanceiro, UN_RL_MapaCargaVendedor, UN_RL_MapaCargaProduto, Un_RL_ReportMapaCarga;
{$R *.dfm}




procedure TFr_Imp_MapaCarga.Pc_Buscar;
var
  sqltxt: string;
  Lc_Pedido, Lc_vendedor: Boolean;
begin
  sqltxt := '';
  Screen.Cursor := crHourGlass;
  with Qr_Pesquisa do
    Begin
    Close;
    Sql.Clear;
    sqltxt := 'SELECT PED_DATA, PED_CODIGO, PED_NUMERO, EMP_FANTASIA, ' +
              'CLB_NOME, PED_VL_PEDIDO ' +
              'FROM TB_PEDIDO tb_pedido ' +
              '   INNER JOIN TB_EMPRESA tb_empresa ' +
              '   ON  (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP) ' +
              '   LEFT OUTER JOIN  TB_NOTA_FISCAL tb_nota_fiscal' +
              '   ON  (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) ' +
              '   LEFT OUTER JOIN TB_COLABORADOR Tb_colaborador ' +
              '   ON  (Tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO) ' +

              'WHERE (PED_TIPO <> 2) AND (PED_CODMHA=:PED_CODMHA) ';

    if (E_PedINI.Text = '') or (E_PedFIM.Text = '') then
      Lc_Pedido := False
    else
      Lc_Pedido := True;
    if trim(DBLCB_Vendedor.Text) = '' then
      Lc_vendedor := False
    else
      Lc_vendedor := True;

    sqltxt := sqltxt + 'AND (PED_DATA BETWEEN :DATAINICIO AND :DATAFIM) ';
    if Lc_Pedido then
      sqltxt := sqltxt + 'AND (PED_NUMERO BETWEEN :PED_INICIO AND :PED_FIM) ';
    if Lc_vendedor then
      sqltxt := sqltxt + 'AND (PED_CODVDO =:PED_CODVDO) ';

    SQL.Add(Sqltxt + 'ORDER BY PED_DATA, PED_NUMERO');

    ParamByName('DATAINICIO').AsDate := E_Data_Ini.Date;
    ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    if Lc_Pedido then
      ParamByName('PED_INICIO').AsString := E_PedIni.Text;
    if Lc_Pedido then
      ParamByName('PED_FIM').AsString := E_PedFIM.Text;
    if Lc_vendedor then
      ParamByName('PED_CODVDO').AsInteger := DBLCB_Vendedor.KeyValue;

   ParamByName('PED_CODMHA').AsInteger := Gb_CodMha;      
   Active := True;
   end;
  Screen.Cursor := crDefault;
end;

procedure TFr_Imp_MapaCarga.Pc_PreencherMapaCarga;
VAr
   Lc_I, Lc_J, Lc_registro: Integer;
BEgin
  Screen.Cursor := crHourGlass;
  Lc_registro := 0;
  with Qr_Pesquisa do
    Begin
    First;
    while not Eof do
      begin
      Lc_registro := Lc_registro + 1;
      StrGrd_Pedido.RowCount := Lc_registro + 1;
      StrGrd_Pedido.Cells[1, Lc_registro] := Qr_Pesquisa.FieldByName('PED_CODIGO').AsString;
      StrGrd_Pedido.Cells[3, Lc_registro] := Qr_Pesquisa.FieldByName('PED_DATA').AsString;
      StrGrd_Pedido.Cells[4, Lc_registro] := Qr_Pesquisa.FieldByName('PED_NUMERO').AsString;
      StrGrd_Pedido.Cells[5, Lc_registro] := Qr_Pesquisa.FieldByName('EMP_FANTASIA').AsString;
      StrGrd_Pedido.Cells[6, Lc_registro] := Qr_Pesquisa.FieldByName('CLB_NOME').AsString;
      StrGrd_Pedido.Cells[7, Lc_registro] := FloatToStrF(Qr_Pesquisa.FieldByName('PED_VL_PEDIDO').AsCurrency, ffFixed, 10, 2);
      Next;
      end;
    StrGrd_Pedido.Repaint;
    IF RecordCount > 0 THEN
      Begin
      SB_Add_Tudo.Enabled:= True;
      SB_Retirar_Tudo.Enabled:= True;
      end
    ELSE
      Begin
      SB_Add_Tudo.Enabled:= False;
      SB_Retirar_Tudo.Enabled:= False;
      end;
    end;
  Screen.Cursor := crDefault;
end;

procedure TFr_Imp_MapaCarga.SB_FiltrarClick(Sender: TObject);
begin
  pc_Buscar;
  Pc_LimpaStringGrid(StrGrd_Pedido);
  Pc_PreencherMapaCarga;
end;

procedure TFr_Imp_MapaCarga.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_MapaCarga.StrGrd_PedidoDrawCell(Sender: TObject; ACol,
   ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  with StrGrd_Pedido do
    Begin
    if (ACol = 2)and(ARow>0) Then
      begin
      if (Cells[1,ARow] <> '') then
        Begin
        if (Cells[8,ARow] = 'X') then
          DrawFrameControl(Canvas.Handle, Rect,DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED) // Desenha o CheckBox desmarcado
        else
          DrawFrameControl(Canvas.Handle, Rect,   DFC_BUTTON, DFCS_BUTTONCHECK); // Desenha o CheckBox marcado
        end;
      end
    else
      Begin
      If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
        Begin
        if (Cells[8,ARow] = '') then
          Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clCream;
          end
        else
          Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clMoneyGreen;
          end;
        Canvas.FillRect(Rect); // redesenha a celula
        Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.
        // Pega o texto da célula
        Texto := Cells[acol, ARow];

        //{ Calcura largura e altura (em pontos) do texto
        LarguraTexto := Canvas.TextWidth(Texto);
        AlturaTexto := Canvas.TextHeight(Texto);

        // Calcula a posição horizontal do início do texto
        if  (ACol = 5) or (ACol = 6) then // esquerda
          X := Rect.Left + 2
        else
        if  (ACol = 3)   then // Centro
          X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
        else // Direita
          X := Rect.Right - LarguraTexto - 2;

        // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
        Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
        Canvas.TextRect(Rect, X, Y, Texto);
        end;
      end;
    end;
end;

procedure TFr_Imp_MapaCarga.Pc_Del_Lin_Grid(Pc_strGrid: TStringGrid);
var
   Lc_I, Lc_J: Integer;

//   lC_LISTA : String
//   Lc_Lista : Array of string;
   Lc_Lista: array of array of string;

   Lc_Linha: Integer;
begin
  Lc_Linha := 0;
  SetLength(Lc_Lista, Pc_strGrid.RowCount, Pc_strGrid.ColCount);
  //Guarda os dados que não estão marcados
  for Lc_I := 1 to Pc_strGrid.RowCount - 1 do
    begin
    if (Pc_strGrid.Cells[8,Lc_I] <> 'X') then
      begin
      Lc_Linha := Lc_Linha + 1;
      for Lc_J := 1 to Pc_strGrid.ColCount - 1 do
        Lc_Lista[Lc_Linha, Lc_J] := Pc_strGrid.Cells[Lc_J, Lc_I];
      end;
    end;

  //Limpa a Matriz antes de incluir a diferenca
   for Lc_I := 1 to Pc_strGrid.RowCount - 1 do
      for Lc_J := 1 to Pc_strGrid.ColCount - 1 do
         Pc_strGrid.Cells[Lc_J, Lc_I] := '';

   Pc_strGrid.RowCount := 2;

  //Grava novamente os dados que não foram marcados e que estão na matriz
   if (Lc_Linha > 0) then
   begin
      for Lc_I := 1 to Lc_Linha do
      begin
         Pc_strGrid.RowCount := Lc_I + 1;
         for Lc_J := 1 to Pc_strGrid.ColCount - 1 do
            Pc_strGrid.Cells[Lc_J, Lc_I] := Lc_Lista[Lc_I, Lc_J];
      end;
   end;
end;

procedure TFr_Imp_MapaCarga.Sb_RetiraPedidoClick(Sender: TObject);
begin
  Pc_Del_Lin_Grid(StrGrd_Pedido);
end;

procedure TFr_Imp_MapaCarga.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

procedure TFr_Imp_MapaCarga.StrGrd_PedidoKeyDown(Sender: TObject;
   var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete: if Sb_RetiraPedido.Enabled then Sb_RetiraPedidoClick(Sender);
    end;
end;

procedure TFr_Imp_MapaCarga.Pc_AgrupadoProdutos;
Var
  RL_MapaCargaProduto : TRL_MapaCargaProduto;
Begin
  try
    Self.Enabled := False;
    RL_MapaCargaProduto := TRL_MapaCargaProduto.create(Self);
    RL_MapaCargaProduto.TipoAgrupamento := Rg_Agrupamento.ItemIndex;
    RL_MapaCargaProduto.E_NomeMotorista.Caption := E_Motorista.Text;
    RL_MapaCargaProduto.E_PlacaVeiculo.Caption := Copy(E_Placa.Text,1,3) + '-' + Copy(E_Placa.Text,4,4);
    RL_MapaCargaProduto.MostraLote := not ChBx_NaoMostraLote.checked;
    RL_MapaCargaProduto.Qrpt.Preview;
  finally
    RL_MapaCargaProduto.Close;
    FreeAndNil(RL_MapaCargaProduto);
    Self.Enabled := True;
  end;
end;

procedure TFr_Imp_MapaCarga.Pc_AgrupadoVendedor;
Begin
  try
    Self.Enabled := False;
    if not Assigned(RL_MapaCargaVendedor) then Application.CreateForm(TRL_MapaCargaVendedor, RL_MapaCargaVendedor);
    RL_MapaCargaVendedor.Qrpt.Preview;
  finally
    RL_MapaCargaVendedor.Close;
    Self.Enabled := True;
  end;
end;

procedure TFr_Imp_MapaCarga.Pc_FormaPagamento;
Var
  I : Integer;
  Lista : Boolean;
  form : TRL_ReportMapaCarga;
Begin
  Lista := False;
  with StrGrd_Pedido do
  Begin
    for I := 1 to RowCount - 1 do
    Begin
      if Cells[8,I] = 'X' then
      Begin
        lista := True;
        break;
      End;
    End;
  End;
  if Lista then
  Begin
    try
      Self.Enabled := False;
      form := TRL_ReportMapaCarga.Create(Self);
      form.Lista := StrGrd_Pedido;
      form.Qrpt.Preview;
    finally
      form.Close;
      FreeAndNil(form);
      Self.Enabled := true;
    end;
  End
  else
  Begin
    MensagemPadrao(' Mensagem',ATENCAO+EOLN+EOLN+
                   ' Por favor Selecione algum registro na lista.'+EOLN+
                   ' Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpErro);
  End;
end;


procedure TFr_Imp_MapaCarga.Pc_DadosFinanceiros;
Begin
  try
    Self.Enabled := False;
    if not Assigned(RL_MapaCargaFinanceiro) then Application.CreateForm(TRL_MapaCargaFinanceiro, RL_MapaCargaFinanceiro);
    RL_MapaCargaFinanceiro.Qrpt.Preview;
  finally
    RL_MapaCargaFinanceiro.Close;
    Self.Enabled := true;
  end;
end;

procedure TFr_Imp_MapaCarga.SB_ImprimirClick(Sender: TObject);
begin
  Pc_LimpaQrPreviweMemoria;
  if Qr_Pesquisa.RecordCount < 1 then
  begin
    MensagemPadrao(' Mensagem',ATENCAO+EOLN+EOLN+
                   ' Nenhum registo para impressão.'+EOLN+
                   ' Verifique os filtros e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    exit;
  end;

  case CB_Tipo.ItemIndex of
    0:Pc_AgrupadoProdutos;
    1:Pc_AgrupadoVendedor;
    2:Pc_DadosFinanceiros;
    3:Pc_FormaPagamento;
  end;

end;



procedure TFr_Imp_MapaCarga.DBLCB_VendedorKeyDown(Sender: TObject;
   var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:DBLCB_Vendedor.KeyValue := Null;
    end;
end;

procedure TFr_Imp_MapaCarga.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin

  if shift = [] then
    begin
    case Pg_MapaCarga.ActivePageIndex of
      0:begin
        case Key of
          VK_F2: if SB_Imprimir.Enabled then     SB_ImprimirClick(Sender);
          VK_F3: if Sb_RetiraPedido.Enabled then Sb_RetiraPedidoClick(Sender);
          VK_F4: if SB_Filtrar.Enabled then      SB_FiltrarClick(Sender);
          VK_F5:if Sb_Salvar.Enabled then Sb_SalvarClick(Sender);
          VK_F7: if Sb_Pesq_MapaCarga.Enabled then Sb_Pesq_MapaCargaClick(Sender);
          VK_Escape: if SB_Sair_0.Enabled then   SB_Sair_0Click(Sender);
          end;
        end;
      1:Begin
        case Key of
          VK_F7: if SB_Buscar.Enabled     then SB_BuscarClick(Sender);
          VK_F8: if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
          VK_Escape: if Sb_Voltar.Enabled then Sb_VoltarClick(Sender);
          end;
        end;
      end;
   end;
end;

procedure TFr_Imp_MapaCarga.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Imprimir     := True;
    It_Retirar      := True;
    It_Filtrar      := True;
    end
  else
    begin
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    if not It_Visualizar then exit;
    It_Imprimir      := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    It_Retirar       := Fc_HabilitaPermissao(Pc_Menu,'RETIRAR','S');
    It_Filtrar       := Fc_HabilitaPermissao(Pc_Menu,'FILTRAR','S');
    end;
   SB_Imprimir.Enabled:= It_Imprimir;
   Sb_RetiraPedido.Enabled := It_Retirar;
   SB_Filtrar.Enabled := It_Filtrar;
end;

procedure TFr_Imp_MapaCarga.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_FormataTela;
  Pc_PermissaoBotao('Mapa Carregamento');
  DM_ListaConsultas.Pc_ListaVendedor;
  E_Data_Ini.Date   := Date-30;
  E_Data_Fim.Date   := Date;
  E_Busca_Data_Ini.Date  := Date-30;
  E_Busca_Data_Fim.Date  := Date;
end;

procedure TFr_Imp_MapaCarga.Pc_FormataTela;
Var
  Lc_X:Integer;
Begin
  Height := 610 - 15;
  For Lc_X:=1 to Pg_MapaCarga.PageCount do Pg_MapaCarga.Pages[Lc_X-1].TabVisible:=False;
  Pg_MapaCarga.ActivePageIndex := 0;
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  //Definir tamanho Da grade de Parcelas
  with StrGrd_Pedido do
  Begin
    ColWidths[0] := 17;
    ColWidths[1] := -1;
    ColWidths[2] := 54;
    ColWidths[3] := 64;
    ColWidths[4] := 70;
    ColWidths[5] := 195;
    ColWidths[6] := 150;
    ColWidths[7] := 64;
    ColWidths[8] := -1;
    Cols[2].Add('Selecionar');
    Cols[3].Add('Data');
    Cols[4].Add('Pedido');
    Cols[5].Add('Nome');
    Cols[6].Add('Vendedor');
    Cols[7].Add('Valor');
  end;
  CB_Tipo.ItemIndex := 0; 
end;
procedure TFr_Imp_MapaCarga.CB_TipoChange(Sender: TObject);
begin
  Rg_Agrupamento.Visible := ( cb_tipo.itemindex = 0 );
end;

procedure TFr_Imp_MapaCarga.chbx_EmpresasClick(Sender: TObject);
begin
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
end;

procedure TFr_Imp_MapaCarga.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Geral;
    SB_Imprimir.Glyph := (Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Salvar.Glyph := (Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Pesq_MapaCarga.Glyph := (Fc_CarregaImagemBotao('PESQUISAR'));
    Sb_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));

    //Page 1
    SB_Buscar.Glyph := (Fc_CarregaImagemBotao('BUSCAR'));
    SB_Visualizar.Glyph := (Fc_CarregaImagemBotao('VISUALIZAR'));
    Sb_Voltar.Glyph := (Fc_CarregaImagemBotao('VOLTAR'));
  END;
end;
procedure TFr_Imp_MapaCarga.StrGrd_PedidoClick(Sender: TObject);
begin
  with StrGrd_Pedido do
  Begin
    IF Cells[8,Row]= 'X' then
      Cells[8,Row] := ''
    else
      Cells[8,Row] := 'X';
    Repaint;
  end;
end;

procedure TFr_Imp_MapaCarga.SB_Add_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  with StrGrd_Pedido do
  Begin
    For LC_I := 1 to RowCount -1 do
    Begin
      Cells[8,Lc_I] := 'X';
    end;
    Repaint;
  end;
end;

procedure TFr_Imp_MapaCarga.Sb_Apl_LoteClick(Sender: TObject);
Var
  I : Integer;
  LcLote : TControllerCtrlLote;
  LcPedido : Integer;
begin
  try
    Self.Enabled := False;
    Pc_ProcesoAguarde(Self,'I');
    Application.ProcessMessages;
    LcLote := TControllerCtrlLote.Create(nil);
    with StrGrd_Pedido do
    Begin
      for I := 1 to RowCount - 1 do
      Begin
        IF Cells[8,Row]= 'X' then
        Begin
          LcPedido := StrToIntDef(StrGrd_Pedido.Cells[1, I],0);
          if LcPedido > 0 then
          Begin
            //Faz auditoria no pedido para garantir que os itens estão na movimentação do estoque
            Fc_AuditoriaEstoquePedido(LcPedido,'N');

            LcLote.AplicaLotePedido(LcPedido);
          End;
          Application.ProcessMessages;
        End;
      End;
    End;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Application.ProcessMessages;
    Self.Enabled := True;
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Processo Finalizado com Sucesso' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    FreeAndNil(LcLote);
  end;
end;

procedure TFr_Imp_MapaCarga.SB_Retirar_TudoClick(
  Sender: TObject);
Var
  Lc_I : Integer;
begin
  with StrGrd_Pedido do
    Begin
    For LC_I := 1 to RowCount -1 do
      Begin
      Cells[8,Lc_I] := '';
      end;
    Repaint;
    end;
end;

procedure TFr_Imp_MapaCarga.Sb_Pesq_MapaCargaClick(Sender: TObject);
begin
  Pg_MapaCarga.ActivePageIndex := 1;
end;

procedure TFr_Imp_MapaCarga.Sb_VoltarClick(Sender: TObject);
begin
  Pg_MapaCarga.ActivePageIndex := 0;
end;

procedure TFr_Imp_MapaCarga.SB_BuscarClick(Sender: TObject);
begin
  Pc_BuscarMapaCArga;
end;

procedure TFr_Imp_MapaCarga.SB_VisualizarClick(Sender: TObject);
begin
  Pc_VisualizarMapaCArga;
end;

procedure TFr_Imp_MapaCarga.Pc_BuscarMapaCArga;
Var
  Lc_Pedido,Lc_Placa,Lc_Motorista:Boolean;
  Lc_SqlTxt : String;
Begin
  if Trim(E_BuscaPedido.Text) <> '' then  Lc_Pedido := True else Lc_Pedido := False;
  if Trim(E_BuscaPlaca.Text) <> '' then  Lc_Placa := True else Lc_Placa := False;
  if Trim(E_BuscaMotorista.Text) <> '' then  Lc_Motorista := True else Lc_Motorista := False;
  with Qr_MapaCarga do
    Begin
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'select '+
                  'ID '+
                  ',DT_PRINT '+
                  ',PLAQUE '+
                  ',DRIVER '+
                  ',ORDERS '+
                  ',ORDERS_id '+
                  'from TB_MAPACARGA '+
                  'Where (id is not null) ';

    if Lc_Pedido then Lc_SqlTxt := Lc_SqlTxt + 'and (ORDERS LIKE :ORDERS) ';
    if Lc_Placa then Lc_SqlTxt := Lc_SqlTxt + 'and (PLAQUE =:PLAQUE) ';
    IF ChBx_Periodo.Checked then
      Lc_SqlTxt := Lc_SqlTxt + '  and (DT_PRINT BETWEEN :dATAINI AND :DATAFIM) ';

    if Lc_Motorista then Lc_SqlTxt := Lc_SqlTxt + 'and (DRIVER LIKE :DRIVER) ';
    SQL.Add(Lc_SqlTxt + ' ORDER BY 1,2,3 ');

    if Lc_Pedido then
      ParamByName('ORDERS').AsString := '%' + E_BuscaPedido.Text + '%';

    if Lc_Placa then
      paramByName('PLAQUE').AsString := E_BuscaPlaca.Text;
    IF ChBx_Periodo.Checked then
      Begin
      ParamByName('DATAINI').AsDate := E_Busca_Data_Ini.Date;
      ParamByName('DATAFIM').AsDate := E_Busca_Data_Fim.Date;
      end;

    if Lc_Motorista then
      ParamByName('DRIVER').AsString := '%' + E_BuscaMotorista.Text + '%';

    Active := True;
    end;
end;


procedure TFr_Imp_MapaCarga.Pc_VisualizarMapaCArga;
var
  sqltxt: string;
  Lc_Pedido, Lc_vendedor: Boolean;
begin
  if Qr_MapaCarga.RecordCount > 0 then
    begin
    sqltxt := '';
    Screen.Cursor := crHourGlass;
    with Qr_Pesquisa do
      Begin
      Close;
      Sql.Clear;
      sqltxt := 'SELECT PED_DATA, PED_CODIGO, PED_NUMERO, EMP_FANTASIA, ' +
                'CLB_NOME, PED_VL_PEDIDO ' +
                'FROM TB_PEDIDO tb_pedido ' +
                '   INNER JOIN TB_EMPRESA tb_empresa ' +
                '   ON  (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP) ' +
                '   INNER JOIN TB_COLABORADOR Tb_colaborador ' +
                '   ON  (Tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO) ' +
                'WHERE (PED_TIPO <> 2) ';

      sqltxt := sqltxt + 'AND PED_CODIGO IN (' + Qr_MapaCarga.FieldByName('ORDERS_ID').AsString + ')';
      SQL.Add(Sqltxt + ' ORDER BY PED_DATA, PED_NUMERO');
     Active := True;
     end;
    Screen.Cursor := crDefault;
    Pc_PreencherMapaCarga;
    E_Motorista.Text := Qr_MapaCarga.FieldByName('DRIVER').AsString;
    E_Placa.Text := Qr_MapaCarga.FieldByName('PLAQUE').AsString;
    Pg_MapaCarga.ActivePageIndex := 0;
    end;
end;

procedure TFr_Imp_MapaCarga.Pc_GravaMapaCarga;
Var
  Lc_I:Integer;
  Lc_Pedidos : String;
  Lc_Ids : String;
  Lc_Qry : TSTQuery;
BEgin
  //Codigos dos pedidos
  Lc_Ids := '';
  For Lc_I := 1 to StrGrd_Pedido.RowCount -1 do
    if StrGrd_Pedido.Cells[1,Lc_I] <> '' then
      if Lc_I = 1 then
        Lc_Ids := StrGrd_Pedido.Cells[1,lc_i]
      else
        Lc_Ids := Lc_Ids + ',' + StrGrd_Pedido.Cells[1,lc_i];

  //Numeros dos dos pedidos
  Lc_Pedidos := '';
  For Lc_I := 1 to StrGrd_Pedido.RowCount -1 do
    if StrGrd_Pedido.Cells[4,Lc_I] <> '' then
      if Lc_I = 1 then
        Lc_Pedidos := StrGrd_Pedido.Cells[4,lc_i]
      else
        Lc_Pedidos := Lc_Pedidos + ',' + StrGrd_Pedido.Cells[4,lc_i];

  Lc_Qry  := TSTQuery.Create(Fr_Imp_MapaCarga);
  with Lc_Qry do
    BEgin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := true;

    Active := False;
    SQL.Clear;
    SQL.Add('insert into "TB_MAPACARGA"( '+
            '  "ID" '+
            ', "DT_PRINT" '+
            ', "PLAQUE" '+
            ', "DRIVER" '+
            ', "ORDERS_ID" '+
            ', "ORDERS") '+
            'values( '+
            '  :"ID" '+
            ', :"DT_PRINT" '+
            ', :"PLAQUE" '+
            ', :"DRIVER" '+
            ', :"ORDERS_ID" '+
            ', :"ORDERS") ');
    ParamByName('ID').AsInteger := Fc_LastIdMapaCarga;
    ParamByName('DT_PRINT').AsDate := Date;
    ParamByName('PLAQUE').AsString := E_Placa.Text;
    ParamByName('DRIVER').AsString := E_Motorista.Text;
    ParamByName('ORDERS').AsString := Lc_Pedidos;
    ParamByName('ORDERS_ID').AsString := Lc_Ids;
    ExecSQL;
    if Transaction.InTransaction then Transaction.CommitRetaining;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

function TFr_Imp_MapaCarga.Fc_LastIdMapaCarga():Integer;
Var
  Lc_Qry : TSTQuery;
BEgin
  Lc_Qry  := TSTQuery.Create(Fr_Imp_MapaCarga);
  with Lc_Qry do
    BEgin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := true;

    Active := False;
    SQL.Clear;
    SQL.Add('select max(id) last from TB_MAPACARGA ');
    Active := True;
    FetchAll;
    if recordCount > 0 then
      Result := FieldByname('last').AsInteger  + 1
    else
      Result := 1;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

procedure TFr_Imp_MapaCarga.DBG_PesquisaTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(DBG_Pesquisa, Column);
end;

procedure TFr_Imp_MapaCarga.Sb_SalvarClick(Sender: TObject);
Var
  Lc_Imprime : Boolean;
begin
  if Qr_Pesquisa.RecordCount < 1 then
    begin
    MensagemPadrao(' Mensagem',ATENCAO+EOLN+EOLN+
                   ' Nenhum registo para Salvar.'+EOLN+
                   ' Verifique os filtros e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    exit;
    end;
  Lc_Imprime := True;
  if (Trim(E_Placa.Text) = '') or (Trim(E_Motorista.Text) = '') then
    Begin
    If (MensagemPadrao(TITULO_CONFIRMACAO,
                       'A Placa ou o nome do motorista não foram informados.'+EOLN+
                       'Este mapa de carregamento não será salvo neste momento.'+EOLN+EOLN+
                       'Continua mesmo assim ?',
                      [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clBtnFace) = mrBotao2) then
      Lc_Imprime := False;
    end;

  if Lc_Imprime then
    BEgin
    Pc_GravaMapaCarga;
    MensagemPadrao(' Mensagem','S U C E S S O!.'+EOLN+EOLN+
                   ' Mapa de carregamento salvo com sucesso.'+EOLN+
                   ' Clique em OK para continuar.'+EOLN,
                   ['OK'],[bEscape],mpInformacao);
    end;
end;

procedure TFr_Imp_MapaCarga.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Busca_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Busca_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

end.

