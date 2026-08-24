unit Un_Tecnicos;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.Math, Dialogs, StdCtrls, ExtCtrls, Buttons, Grids, DB, STQuery;

type

 TFr_Tecnicos = class(TForm)
    Panel1: TPanel;
    Label5: TLabel;
    SB_Cofirmar: TSpeedButton;
    Qr_Todos: TSTQuery;
    Qr_Atualiza: TSTQuery;
    StrGrd_Tecnico: TStringGrid;
    Sb_Sair_0: TSpeedButton;
    Qr_Tecnicos: TSTQuery;
    Qr_Delete: TSTQuery;
    procedure FormCreate(Sender: TObject);
    procedure SB_SairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure StrGrd_TecnicoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure StrGrd_TecnicoSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure StrGrd_TecnicoDblClick(Sender: TObject);
    procedure SB_CofirmarClick(Sender: TObject);
  private
    { Private declarations }
    It_Vl_PEdido, It_VL_Troco, It_VL_Receber : Real;
  public
    { Public declarations }
    It_Tipo_Oper : char;
    It_Cd_Item : integer;
    It_Cd_Pedido : Integer;
    It_Editar : Boolean;
    It_Tp_Vinculo : String;
    procedure Pc_PreencheTodos;
    procedure Pc_PreencheTecnicos;
    Function Fc_Valida():Boolean;
    procedure Pc_Atualiza;

  end;

var
  Fr_Tecnicos: TFr_Tecnicos;

implementation

uses     UN_MSG, Un_DM, UN_Sistema, Un_Fc_Comissao, Un_Regra_Negocio, env;
{$R *.dfm}

Function TFr_Tecnicos.Fc_Valida():Boolean;
var
  Lc_I, Lc_J : Integer;
  Lc_Valor : Real;
begin
  Lc_Valor := 0;
  For Lc_I :=1 to StrGrd_Tecnico.RowCount - 1 do
    Lc_Valor := Lc_Valor + StrToFloatDef(StrGrd_Tecnico.Cells[3,lc_I],0);

  if Lc_Valor > 100 then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'O Percentual não pode ser maior que 100%.'+EOLN+
                   'Confira os valores dos Técnicos.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    end
  else
    Result := True;
end;

procedure TFr_Tecnicos.Pc_PreencheTodos;
var
  Lc_I, Lc_J : Integer;
  Lc_Registro : Integer;
begin
  Screen.Cursor:=crHourGlass;
  Qr_Todos.Open;
  Qr_Todos.First;
  // Limpa a Grid de Pesquisa Parcelas

  Pc_LimpaStringGrid(StrGrd_Tecnico);
  Lc_Registro := 0;
  while not Qr_Todos.Eof do
    Begin
    Lc_registro := Lc_registro + 1;
    StrGrd_Tecnico.RowCount := Lc_registro + 1;
    StrGrd_Tecnico.Cells[1,Lc_registro] := Qr_Todos.FieldByName('CLB_CODIGO').AsString;
    StrGrd_Tecnico.Cells[2,Lc_registro] := Qr_Todos.FieldByName('CLB_NOME').AsString;
    Qr_Todos.Next;
    end;
  Screen.Cursor:=crDefault;

end;

procedure TFr_Tecnicos.Pc_PreencheTecnicos;
var
  Lc_I, Lc_J : Integer;
  Lc_Registro : Integer;
Label
  lb_Sai;
begin
  Screen.Cursor:=crHourGlass;
  Qr_Tecnicos.Active := False;
  Qr_Tecnicos.ParamByName('TEC_CODITF').AsInteger := It_Cd_Item;
  Qr_Tecnicos.Active := True;
  Qr_Tecnicos.First;

  For Lc_I := 1 to StrGrd_Tecnico.RowCount-1 do
    Begin
    Qr_Tecnicos.First;
    while not Qr_Tecnicos.Eof do
      Begin
      if (StrGrd_Tecnico.Cells[1,Lc_I] = Qr_Tecnicos.FieldByName('TEC_CODCLB').AsString) then
        Begin
        StrGrd_Tecnico.Cells[4,Lc_I] := 'X';
        StrGrd_Tecnico.Cells[3,Lc_I] := FloatToStrF(Qr_Tecnicos.FieldByName('TEC_PROPORCAO').AsFloat,ffFixed,10,2);
        StrGrd_Tecnico.Repaint;
        goto lb_sai;
        end;
      Qr_Tecnicos.Next;
      end;
   lb_sai:
    end;
  Screen.Cursor:=crDefault;

end;

procedure TFr_Tecnicos.Pc_Atualiza;
Var
  Lc_I:Integer;
Begin
  For Lc_I := 1 to StrGrd_Tecnico.RowCount-1 do
  Begin
    Pc_Ins_Tec_Itf_Srv(DM.IB_Transacao,
                       It_Cd_Item,
                       It_Cd_Pedido,
                       StrToIntDef(StrGrd_Tecnico.Cells[1,Lc_I],0),
                       StrToFloatDef(StrGrd_Tecnico.Cells[3,Lc_I],0),
                       It_Tp_Vinculo);
  end;
end;

procedure TFr_Tecnicos.FormCreate(Sender: TObject);
begin
  It_Editar := False;
  //Definir tamanho Da grade de Parcelas
  with StrGrd_Tecnico do
  Begin
    ColWidths[0]:=17;
    ColWidths[1]:=-1;
    ColWidths[2]:=380;
    ColWidths[3]:=80;
    ColWidths[4]:=-1;
    Cols[2].Add('T�cnico');
    Cols[3].Add('Paga %');
  end;
end;

procedure TFr_Tecnicos.SB_SairClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Tecnicos.FormShow(Sender: TObject);
begin
  Pc_PreencheTodos;
  Pc_PreencheTecnicos;
end;

procedure TFr_Tecnicos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Tecnicos.StrGrd_TecnicoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  If (arow > 0) and (acol >0) then // testa se não � a primeira linha (fixa)
  if (StrGrd_Tecnico.Cells[4,arow]='X') then
    begin // verifica se a linha � impar
    StrGrd_Tecnico.Canvas.Font.Color:= clBlack;
    StrGrd_Tecnico.Canvas.Brush.Color:= clBtnFace;
    end
  else
    begin
    StrGrd_Tecnico.Canvas.Font.Color:= clBlack;
    StrGrd_Tecnico.Canvas.Brush.Color:= clCream;
    end;
     Texto := StrGrd_Tecnico.Cells[acol, ARow];

  if (ACol = 3) and (ARow > 0) then Texto := FloatToStrF(StrToFloatDef(Texto,0),ffFixed,10,2);

  { Calcura largura e altura (em pontos) do texto }
  LarguraTexto := StrGrd_Tecnico.Canvas.TextWidth(Texto);
  AlturaTexto := StrGrd_Tecnico.Canvas.TextHeight(Texto);

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
  StrGrd_Tecnico.Canvas.TextRect(Rect, X, Y, Texto);

end;

procedure TFr_Tecnicos.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Tecnicos.StrGrd_TecnicoSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if ACol = 2 then
    StrGrd_Tecnico.Options:= [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect]
  else
   StrGrd_Tecnico.Options:= [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goEditing];
end;

procedure TFr_Tecnicos.StrGrd_TecnicoDblClick(Sender: TObject);
Var
  lc_I: Integer;
  lc_Numero : Integer;
begin
  It_Editar := True;
  lc_Numero := 0;
  if StrGrd_Tecnico.Cells[4,StrGrd_Tecnico.Row] = '' then
    Begin
    StrGrd_Tecnico.Cells[4,StrGrd_Tecnico.Row] :=  'X';
    end
  else
    Begin
    StrGrd_Tecnico.Cells[4,StrGrd_Tecnico.Row] := '';
    end;
  for lc_I := 1 to StrGrd_Tecnico.RowCount - 1 do
    Begin
    if StrGrd_Tecnico.Cells[4,lc_I] =  'X' then inc(lc_Numero);
    end;
  for lc_I := 1 to StrGrd_Tecnico.RowCount - 1 do
    Begin
    if StrGrd_Tecnico.Cells[4,lc_I] =  'X' then
      StrGrd_Tecnico.Cells[3,lc_I] :=  FloatToStrF(100/lc_Numero,ffFixed,10,2)
    else
      StrGrd_Tecnico.Cells[3,lc_I] := '';
    end;

    StrGrd_Tecnico.Repaint;
end;

procedure TFr_Tecnicos.SB_CofirmarClick(Sender: TObject);
begin
  If It_Editar then
    if Fc_Valida then
    Begin
      Pc_Atualiza;
      Close;
    end;
end;

end.
