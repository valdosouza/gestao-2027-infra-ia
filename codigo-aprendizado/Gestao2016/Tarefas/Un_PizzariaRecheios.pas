unit Un_PizzariaRecheios;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Grids, ExtCtrls, Buttons, DB, STQuery, StdCtrls, ComCtrls, Mask, QEdit_Setes, CheckLst;

type
  TFr_PizzariaRecheios = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    SB_Sair_0: TSpeedButton;
    SB_Confirmar: TSpeedButton;
    E_OpcaoLivre: TEdit;
    Qr_Crp_Itens: TSTQuery;
    StrGrd_Recheio: TStringGrid;
    Label1: TLabel;
    Qr_Crp_ItensCPI_CODPRO: TIntegerField;
    Qr_Crp_ItensPRO_DESCRICAO: TStringField;
    Qr_Crp_ItensCPI_TIPO: TStringField;
    Qr_Crp_ItensCPI_QTDE: TBCDField;
    Qr_Crp_ItensCPI_VALOR: TBCDField;
    procedure FormShow(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure StrGrd_RecheioDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StrGrd_RecheioClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Confirma : Boolean;
    It_Ds_Sabor : String;

    It_Cd_Botao : Integer;
    It_Cd_Produto : Integer;
    It_Cd_SubGrupo : Integer;
    It_Ds_Produto : String;
    It_Ds_Medida : String;
    It_qtde : Real;
    It_VL_Unit: Currency;
    Procedure Pc_FormataTela;
    Procedure Pc_IniciaVariaveis;
    function Fc_ValidaInclusao():Boolean;
    function Fc_VerificaMarcado(Fc_grid:TStringGrid):Boolean;
    procedure Pc_ImagemBotao;
  end;

var
  Fr_PizzariaRecheios: TFr_PizzariaRecheios;

implementation

uses     Un_DM, Un_Regra_Negocio, UN_MSG, UN_Principal, env;
{$R *.dfm}
Procedure TFr_PizzariaRecheios.Pc_FormataTela;
Var
  Lc_I : Integer;
Begin
  with StrGrd_Recheio,Qr_Crp_Itens do
  Begin
    ColCount := FieldCount + 3;
    ColWidths[0]:=17;
    ColWidths[1]:=54;
    ColWidths[2]:=-1;
    Cols[1].Add('Selecionar');
    For Lc_I:= 0 to FieldCount -1 do
    Begin
      ColWidths[Lc_I + 3]:= Fields[Lc_I].Tag;
      Cols[Lc_I + 3].Add(Fields[Lc_I].DisplayLabel);
    end;
  end;
end;

procedure TFr_PizzariaRecheios.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    SB_Confirmar.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;


Procedure TFr_PizzariaRecheios.Pc_IniciaVariaveis;
Var
  Lc_I,Lc_J : Integer;
  Lc_registro : Integer;
Begin
  It_Confirma := False;
  with Qr_Crp_Itens,StrGrd_Recheio do
  Begin
    Active := False;
    ParamByName('CPI_SABOR').AsString := It_Ds_Sabor;
    Active := True;
    First;
    Lc_registro := 0;
    while not Eof do
    Begin
      Lc_registro := Lc_registro + 1;
      RowCount := Lc_registro + 1;
      For Lc_I:= 0 to FieldCount -1 do
        if (Fields.Fields[Lc_I].DataType = ftFloat) OR (Fields.Fields[Lc_I].DataType = ftBCD) then
        Begin
          Cells[Lc_I + 3,Lc_registro] := FloatToStrF(Fields[Lc_I].AsFloat,ffFixed,10,2);
        end
        else
        Begin
          if (Fields.Fields[Lc_I].FieldName = 'CPI_TIPO') then
          Begin
            if (Fields[Lc_I].AsString = 'P') then
            Begin
              Cells[Lc_I + 3,Lc_registro] := 'Padrão';
              Cells[2,Lc_registro] := 'X';
            end
            else
            Begin
              Cells[Lc_I + 3,Lc_registro] := 'Opcional';
              Cells[2,Lc_registro] := '';
            end;
          end
          else
          Begin
            Cells[Lc_I + 3,Lc_registro] := Fields[Lc_I].AsString;
          end;
        end;
      Next;
    end;
    Repaint;
  end;
end;

procedure TFr_PizzariaRecheios.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F10:if SB_Confirmar.enabled then SB_ConfirmarClick(Sender);
      VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_PizzariaRecheios.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_FormataTela;
  Pc_IniciaVariaveis;
end;

procedure TFr_PizzariaRecheios.SB_Sair_0Click(Sender: TObject);
begin
  It_Confirma := False;
  Close;
end;

function TFr_PizzariaRecheios.Fc_VerificaMarcado(Fc_grid:TStringGrid):Boolean;
Begin

end;


function TFr_PizzariaRecheios.Fc_ValidaInclusao():Boolean;
Begin
  REsult := True;
end;


procedure TFr_PizzariaRecheios.SB_ConfirmarClick(Sender: TObject);
Var
  Lc_I:Integer;
begin
  If Fc_ValidaInclusao then
  Begin
    It_Confirma := True;
    close;
  end;
end;

procedure TFr_PizzariaRecheios.StrGrd_RecheioDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  with Qr_Crp_Itens, StrGrd_Recheio do
  Begin
    if (ACol = 1)and(ARow>0) Then
    begin
      if (Cells[3,ARow] <> '') then
      Begin
        if (Cells[2,ARow] = 'X') then
          DrawFrameControl(Canvas.Handle, Rect,DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED) // Desenha o CheckBox desmarcado
        else
          DrawFrameControl(Canvas.Handle, Rect,   DFC_BUTTON, DFCS_BUTTONCHECK); // Desenha o CheckBox marcado
      end;
    end
    else
    Begin
      If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
      Begin
        if (Cells[2,ARow] = '') then
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
        if (Acol > 2) then
        Begin
          if (Fields[ACol-3].Alignment = taLeftJustify) then   // esquerda
            X := Rect.Left + 2
          else
          if (Fields[ACol-3].Alignment = taCenter) then // Centro
            X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
          else // Direita
            X := Rect.Right - LarguraTexto - 2;
        end;
        // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
        Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
        Canvas.TextRect(Rect, X, Y, Texto);
      end;
    end;
  end;
end;

procedure TFr_PizzariaRecheios.StrGrd_RecheioClick(Sender: TObject);
begin
  with StrGrd_Recheio do
  Begin
    IF Cells[2,Row]= 'X' then
      Cells[2,Row] := ''
    else
      Cells[2,Row] := 'X';
    Repaint;
  end;
end;

end.
