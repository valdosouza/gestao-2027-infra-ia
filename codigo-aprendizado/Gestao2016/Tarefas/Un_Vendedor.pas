unit Un_Vendedor;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.Math, Dialogs, DB, STQuery, Grids, Buttons, StdCtrls, ExtCtrls;

type

  TFr_Vendedores = class(TForm)
    Panel1: TPanel;
    Label5: TLabel;
    SB_Cofirmar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    StrGrd_Vendedor: TStringGrid;
    Qr_Todos: TSTQuery;
    Qr_Vendedores: TSTQuery;
    Qr_Delete: TSTQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SB_CofirmarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure StrGrd_VendedorDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StrGrd_VendedorSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    It_Vl_PEdido, It_VL_Troco, It_VL_Receber : Real;
  public
    { Public declarations }
    It_Tipo_Oper : char;
    It_Cd_Item : integer;
    It_Cd_Pedido : Integer;
    It_Editar : Boolean;
    procedure Pc_PreencheTodos;
    procedure Pc_PreencheVendedores;
    Function Fc_Valida():Boolean;
    procedure Pc_Atualiza;
  end;

var
  Fr_Vendedores: TFr_Vendedores;

implementation

uses     UN_MSG, Un_DM, UN_Sistema, Un_Fc_Comissao, env;
{$R *.dfm}


Function TFr_Vendedores.Fc_Valida():Boolean;
var
  Lc_I, Lc_J : Integer;
  Lc_Valor : Real;
begin
  Result := true;
  Lc_Valor := 0;
  For Lc_I :=1 to StrGrd_Vendedor.RowCount - 1 do
    Lc_Valor := Lc_Valor + StrToFloatDef(StrGrd_Vendedor.Cells[3,lc_I],0);

  if (Lc_Valor > 100) then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'O Percentual não pode ser maior que 100%.'+EOLN+
                   'Confira os Percentuais.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
    end;

  //Verifica se foi informado algum percentual  
{  if (Lc_Valor <= 0) then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Não foi informado nenhum percentual de Comissão%.'+EOLN+
                   'Confira os Percentuais.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
    end;
}
  Result := true;
end;

procedure TFr_Vendedores.Pc_PreencheTodos;
var
  Lc_I, Lc_J : Integer;
  Lc_Registro : Integer;
begin
  Screen.Cursor:=crHourGlass;
  Qr_Todos.Open;
  Qr_Todos.First;
  // Limpa a Grid de Pesquisa Parcelas

  For Lc_I :=1 to StrGrd_Vendedor.RowCount - 1 do
    For Lc_J := 1 to 4 do
      StrGrd_Vendedor.Cells[Lc_J, Lc_I] := '';
  StrGrd_Vendedor.RowCount := 2;
  Lc_Registro := 0;

  while not Qr_Todos.Eof do
    Begin
    Lc_registro := Lc_registro + 1;
    StrGrd_Vendedor.RowCount := Lc_registro + 1;
    StrGrd_Vendedor.Cells[1,Lc_registro] := Qr_Todos.FieldByName('CLB_CODIGO').AsString;
    StrGrd_Vendedor.Cells[2,Lc_registro] := Qr_Todos.FieldByName('CLB_NOME').AsString;
    Qr_Todos.Next;
    end;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Vendedores.Pc_PreencheVendedores;
var
  Lc_I, Lc_J : Integer;
  Lc_Registro : Integer;
Label
  lb_Sai;
begin
  Screen.Cursor:=crHourGlass;
  Qr_Vendedores.Active := False;
  Qr_Vendedores.ParamByName('VEN_CODITF').AsInteger := It_Cd_Item;
  Qr_Vendedores.Active := True;
  Qr_Vendedores.First;

  For Lc_I := 1 to StrGrd_Vendedor.RowCount-1 do
    Begin
    Qr_Vendedores.First;
    while not Qr_Vendedores.Eof do
      Begin
      if (StrGrd_Vendedor.Cells[1,Lc_I] = Qr_Vendedores.FieldByName('VEN_CODCLB').AsString) then
        Begin
        StrGrd_Vendedor.Cells[4,Lc_I] := 'X';
        StrGrd_Vendedor.Cells[3,Lc_I] := Qr_Vendedores.FieldByName('VEN_PROPORCAO').AsString;
        StrGrd_Vendedor.Repaint;
        goto lb_sai;
        end;
      Qr_Vendedores.Next;
      end;
   lb_sai:
    end;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Vendedores.Pc_Atualiza;
Var
  Lc_I:Integer;
Begin
  Try
    Pc_Construtor_Comissao(DM.IB_Transacao);
    For Lc_I := 1 to StrGrd_Vendedor.RowCount-1 do
      Pc_Deleta_Vdo_Pedido(DM.IB_Transacao,0,It_Cd_Item,'M');

    For Lc_I := 1 to StrGrd_Vendedor.RowCount-1 do
    Begin
      Pc_Ins_Vdo_Itf_Vda(DM.IB_Transacao,
                         It_Cd_Item,
                         It_Cd_Pedido,
                         StrToIntDef(StrGrd_Vendedor.Cells[1,Lc_I],0),
                         'M',
                         StrToFloatDef(StrGrd_Vendedor.Cells[3,Lc_I],0));
    end;
  Finally
    Pc_Destrutor_Comissao;
  End;

end;

procedure TFr_Vendedores.FormCreate(Sender: TObject);
begin
  It_Editar := False;
  //Definir tamanho Da grade de Parcelas

  StrGrd_Vendedor.ColWidths[0]:=17;
  StrGrd_Vendedor.ColWidths[1]:=-1;
  StrGrd_Vendedor.ColWidths[2]:=380;
  StrGrd_Vendedor.ColWidths[3]:=80;
  StrGrd_Vendedor.ColWidths[4]:=-1;

  StrGrd_Vendedor.Cols[2].Add('Vendedor');
  StrGrd_Vendedor.Cols[3].Add('Com. %');
end;

procedure TFr_Vendedores.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Vendedores.SB_CofirmarClick(Sender: TObject);
begin
  If It_Editar then
    if Fc_Valida then
    Begin
      Pc_Atualiza;
      Close;
    end;
end;

procedure TFr_Vendedores.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Vendedores.StrGrd_VendedorDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  If (arow > 0) and (acol >0) then // testa se não � a primeira linha (fixa)
    begin
    StrGrd_Vendedor.Canvas.Font.Color:= clBlack;
    StrGrd_Vendedor.Canvas.Brush.Color:= clCream;
    end
  else
    begin
    StrGrd_Vendedor.Canvas.Font.Color:= clBlack;
    StrGrd_Vendedor.Canvas.Brush.Color:= clBtnFace;
    end;
    Texto := StrGrd_Vendedor.Cells[acol, ARow];
  if (ACol = 3) and (ARow > 0) then Texto := FloatToStrF(StrToFloatDef(Texto,0),ffFixed,10,2);
  { Calcura largura e altura (em pontos) do texto }
  LarguraTexto := StrGrd_Vendedor.Canvas.TextWidth(Texto);
  AlturaTexto := StrGrd_Vendedor.Canvas.TextHeight(Texto);

  { Calcula a posição horizontal do in�cio do texto }
  if  (ACol = 2) then { esquerda }
    X := Rect.Left + 2
  else if (ACol = 0)  then { Centro }
    X := Rect.Left + (Rect.Right - Rect.Left) div 2 -
      LarguraTexto div 2
  else { Direita }
    X := Rect.Right - LarguraTexto - 2;

  { Calcula a posição vertical do in�cio do texto para
    que seja impresso no centro (verticalmente) da c�lula }
  Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -
    AlturaTexto div 2;

  { Pinta o texto }
  StrGrd_Vendedor.Canvas.TextRect(Rect, X, Y, Texto);
end;

procedure TFr_Vendedores.StrGrd_VendedorSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if ACol = 2 then
    StrGrd_Vendedor.Options:= [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect]
  else
    BeGin
    StrGrd_Vendedor.Options:= [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goEditing];
    It_Editar := True;
    end;
end;

procedure TFr_Vendedores.FormShow(Sender: TObject);
begin
  Pc_PreencheTodos;
  Pc_PreencheVendedores;
end;

end.
