unit Un_Imp_MapaProducao;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, StdCtrls, Grids, DBGrids, Mask, Buttons, ExtCtrls, DBCtrls, QEdit_Setes, Un_Fm_ListaColaboradores;

type
  TFr_Imp_MapaProducao = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    E_DataIni: TMaskEdit;
    E_DataFim: TMaskEdit;
    E_PedINI: TEdit_Setes;
    E_PedFIN: TEdit_Setes;
    DS_Qr_MapaCarga: TDataSource;
    Qr_Pesquisa: TSTQuery;
    DBLCB_Empresa: TDBLookupComboBox;
    Label9: TLabel;
    SB_Filtrar: TSpeedButton;
    Sb_RetiraPedido: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Fm_ListaVendedores: TFm_ListaColaboradores;
    pnl_Rodape: TPanel;
    StrGrd_Pedido: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure SB_FiltrarClick(Sender: TObject);
    procedure StrGrd_PedidoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Sb_RetiraPedidoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure StrGrd_PedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_ImprimirClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Visualizar :Boolean;
    It_Imprimir :Boolean;
    It_Retirar :Boolean;
    It_Filtrar  :Boolean;
  procedure Pc_Buscar;
  procedure Pc_Del_Lin_Grid(Pc_strGrid :TStringGrid; Pc_Linha:Integer) ;
  procedure Pc_PermissaoBotao(Pc_Menu: string);
  procedure Pc_ImagemBotao;
  end;

var
  Fr_Imp_MapaProducao: TFr_Imp_MapaProducao;

implementation

uses     Un_DM, UN_Sistema, UN_RL_MapaProducao, UN_Principal, env, UN_TabelasEmListas;
{$R *.dfm}



procedure TFr_Imp_MapaProducao.Pc_Buscar;
var
  sqltxt:string;
  Lc_Pedido, Lc_Data, Lc_Cliente,Lc_Vendedor : Boolean;
  Lc_I, Lc_J, Lc_registro : Integer;
begin
  sqltxt:='';
  Screen.Cursor := crHourGlass;
  Qr_Pesquisa.Close;
  Qr_Pesquisa.Sql.Clear;
  sqltxt := 'SELECT PED_DATA, PED_CODIGO, PED_NUMERO, EMP_FANTASIA, '+
            'PED_VL_PEDIDO '+
            'FROM TB_PEDIDO tb_pedido  '+
            '   INNER JOIN TB_EMPRESA tb_empresa '+
            '   ON  (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP) '+
            'WHERE (PED_TIPO = ''1'') AND (PED_FATURADO <> ''A'') '+
            'AND (PED_CODMHA =:PED_CODMHA )';

  if (E_DataIni.Text = '  /  /    ') OR (E_DataFim.Text = '  /  /    ') then Lc_Data := False else Lc_Data := True;
  if (E_PedINI.Text = '') OR (E_PedFIN.Text = '') then Lc_Pedido := False else Lc_Pedido := True;
  if trim(DBLCB_Empresa.Text) = '' then Lc_Cliente := False else Lc_Cliente := True;
  if trim( Fm_ListaVendedores.Dblcb_Vendedor.Text) = '' then Lc_Vendedor := False else Lc_Vendedor := True;

  if Lc_Data then sqltxt := sqltxt + 'AND (PED_DATA BETWEEN :DATAINICIO AND :DATAFIM) ';
  if Lc_Pedido then sqltxt := sqltxt + 'AND (PED_NUMERO BETWEEN :PED_INICIO AND :PED_FIM) ';
  if Lc_Cliente then sqltxt := sqltxt + 'AND (PED_CODEMP =:PED_CODEMP) ';
  if Lc_Vendedor then  sqltxt := sqltxt + ' AND (PED_CODVDO =:PED_CODVDO) ';
  

  Qr_Pesquisa.SQL.Add(Sqltxt + 'ORDER BY PED_DATA, PED_NUMERO');

  Qr_Pesquisa.ParamByName('PED_CODMHA').AsInteger :=  Gb_CodMha;
  if Lc_Data then Qr_Pesquisa.ParamByName('DATAINICIO').AsDate:=(StrToDate(E_DataIni.Text));
  if Lc_Data then qr_Pesquisa.ParamByName('DATAFIM').AsDate:=(StrTodate(E_DataFim.Text));
  if Lc_Pedido then Qr_Pesquisa.ParamByName('PED_INICIO').AsString:=E_PedINI.Text;
  if Lc_Pedido then qr_Pesquisa.ParamByName('PED_FIM').AsString:=E_PedFIN.Text;
  if Lc_Cliente then qr_Pesquisa.ParamByName('PED_CODEMP').AsInteger:=DBLCB_Empresa.KeyValue;
  if Lc_Vendedor then qr_Pesquisa.ParamByName('PED_CODVDO').AsInteger := Fm_ListaVendedores.Dblcb_Vendedor.KeyValue;

 // Limpa a Grid de Pesquisa Parcelas

  For Lc_I :=1 to StrGrd_Pedido.RowCount - 1 do
    For Lc_J := 1 to 6 do
      StrGrd_Pedido.Cells[Lc_J, Lc_I] := '';
  StrGrd_Pedido.RowCount := 2;
  Lc_registro := 0;
  Qr_Pesquisa.Active := True;
  Qr_Pesquisa.First;
  while not Qr_Pesquisa.Eof do
  Begin
    Lc_registro := Lc_registro + 1;
    StrGrd_Pedido.RowCount := Lc_registro + 1;
    StrGrd_Pedido.Cells[1,Lc_registro] := Qr_Pesquisa.FieldByName('PED_CODIGO').AsString;
    StrGrd_Pedido.Cells[2,Lc_registro] := Qr_Pesquisa.FieldByName('PED_DATA').AsString;
    StrGrd_Pedido.Cells[3,Lc_registro] := Qr_Pesquisa.FieldByName('PED_NUMERO').AsString;
    StrGrd_Pedido.Cells[4,Lc_registro] := Qr_Pesquisa.FieldByName('EMP_FANTASIA').AsString;
    StrGrd_Pedido.Cells[5,Lc_registro] := FloatToStrF(Qr_Pesquisa.FieldByName('PED_VL_PEDIDO').AsCurrency, ffFixed, 10,2);
    Qr_Pesquisa.Next;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Imp_MapaProducao.FormCreate(Sender: TObject);
begin
//Definir tamanho Da grade de Parcelas
  StrGrd_Pedido.ColWidths[0]:=17;
  StrGrd_Pedido.ColWidths[1]:=-1;
  StrGrd_Pedido.ColWidths[2]:=64;
  StrGrd_Pedido.ColWidths[3]:=70;
  StrGrd_Pedido.ColWidths[4]:=195;
  StrGrd_Pedido.ColWidths[5]:=64;
  StrGrd_Pedido.Cols[2].Add('Data');
  StrGrd_Pedido.Cols[3].Add('Pedido');
  StrGrd_Pedido.Cols[4].Add('Nome');
  StrGrd_Pedido.Cols[5].Add('Valor');
  E_DataIni.Text := DateToStr(Date);
  E_DataFim.Text := DateToStr(Date);
end;

procedure TFr_Imp_MapaProducao.SB_FiltrarClick(Sender: TObject);
begin
  pc_Buscar;
end;

procedure TFr_Imp_MapaProducao.StrGrd_PedidoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
  if (StrGrd_Pedido.Cells[14,arow]='X') then
    begin // verifica se a linha impar
    StrGrd_Pedido.Canvas.Font.Color:= clBlack;
    StrGrd_Pedido.Canvas.Brush.Color:= clBtnFace;
    end
  else
    begin
    StrGrd_Pedido.Canvas.Font.Color:= clBlack;
    StrGrd_Pedido.Canvas.Brush.Color:= clCream;
    end;
  StrGrd_Pedido.Canvas.FillRect(Rect); // redesenha a celula
  StrGrd_Pedido.Canvas.TextOut(Rect.Left+2,Rect.Top,StrGrd_Pedido.Cells[acol,arow]); // reimprime o texto.


  { Pega o texto da célula }
  Texto := StrGrd_Pedido.Cells[acol, ARow];

  { Calcura largura e altura (em pontos) do texto }
  LarguraTexto := StrGrd_Pedido.Canvas.TextWidth(Texto);
  AlturaTexto := StrGrd_Pedido.Canvas.TextHeight(Texto);

  { Calcula a posição horizontal do início do texto }
  if  (ACol = 3) or (ACol = 4) or (ACol = 5)  then { esquerda }
    X := Rect.Left + 2
  else if  (ACol = 2) then { Centro }
    X := Rect.Left + (Rect.Right - Rect.Left) div 2 -
      LarguraTexto div 2
  else { Direita }
    X := Rect.Right - LarguraTexto - 2;


  { Calcula a posição vertical do início do texto para
    que seja impresso no centro (verticalmente) da célula }
  Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -
    AlturaTexto div 2;

  { Pinta o texto }
  StrGrd_Pedido.Canvas.TextRect(Rect, X, Y, Texto);


end;

procedure TFr_Imp_MapaProducao.Pc_Del_Lin_Grid(Pc_strGrid :TStringGrid ; Pc_Linha:Integer) ;
Var
  Lc_I, Lc_J : Integer;
  Lc_Lista : Array of Array of string;
  Lc_Linha : Integer;
begin
  if Pc_strGrid.Cells[2,Pc_Linha] = '' then exit;
  Lc_Linha := 0;
  SetLength(Lc_Lista,Pc_strGrid.RowCount,Pc_strGrid.ColCount);
  //Guarda os dados que não estão marcados

  for Lc_I := 1 to Pc_strGrid.RowCount-1 do
    Begin
    if Lc_I <> Pc_Linha then
      Begin
      Lc_Linha := Lc_Linha + 1;
      for Lc_J := 1 to Pc_strGrid.ColCount-1 do
        Lc_Lista[Lc_Linha,Lc_J] := Pc_strGrid.Cells[Lc_J, Lc_I];
      end;
    end;

  //Limpa a Matriz antes de incluir a diferenca
  For Lc_I :=1 to Pc_strGrid.RowCount - 1 do
    For Lc_J := 1 to Pc_strGrid.ColCount - 1 do
      Pc_strGrid.Cells[Lc_J, Lc_I] := '';

  Pc_strGrid.RowCount := 2;

  //Grava novamente os dados que não foram marcados e que estão na matriz
  if (Lc_Linha > 0) then
    Begin
    for Lc_I := 1 to Lc_Linha do
      Begin
      Pc_strGrid.RowCount := Lc_I+1;
      for Lc_J := 1 to Pc_strGrid.ColCount-1 do
        Pc_strGrid.Cells[Lc_J, Lc_I] := Lc_Lista[Lc_I,Lc_J];
      end;
    end;
end;

procedure TFr_Imp_MapaProducao.Sb_RetiraPedidoClick(Sender: TObject);
begin
  Pc_Del_Lin_Grid(StrGrd_Pedido,StrGrd_Pedido.Row);
end;

procedure TFr_Imp_MapaProducao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13)  then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Imp_MapaProducao.StrGrd_PedidoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  : if Sb_RetiraPedido.Enabled then Sb_RetiraPedidoClick(Sender);
  end;
end;



procedure TFr_Imp_MapaProducao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if shift = [] then
  begin
    case Key of
      VK_F2  : if SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
      VK_F3  : if Sb_RetiraPedido.Enabled then Sb_RetiraPedidoClick(Sender);
      VK_F4  : if SB_Filtrar.Enabled then SB_FiltrarClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_Imp_MapaProducao.SB_ImprimirClick(Sender: TObject);
Var
  Form :TRL_MapaProducao;
begin
  Pc_LimpaQrPreviweMemoria;
  if StrGrd_Pedido.Cells[1,1] = '' then exit;
  try
    Form := TRL_MapaProducao.create(nil);
    Form.Qrpt.Preview;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_Imp_MapaProducao.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Imp_MapaProducao.Pc_PermissaoBotao(Pc_Menu: string);
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

procedure TFr_Imp_MapaProducao.FormShow(Sender: TObject);
begin
  DM_ListaConsultas.Pc_ListaClientes('EMP_NOME');
  Fm_ListaVendedores.ListaVendedor;
  Pc_ImagemBotao;
  Pc_PermissaoBotao('Mapa Produção');
end;

procedure TFr_Imp_MapaProducao.DBLCB_EmpresaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
        begin
        DBLCB_Empresa.KeyValue := Null;
        end;
      end;
end;

procedure TFr_Imp_MapaProducao.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Imprimir.Glyph := (Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
    END;
end;
end.
