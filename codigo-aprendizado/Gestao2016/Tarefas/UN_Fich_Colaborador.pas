unit UN_Fich_Colaborador;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Grids, StdCtrls, Buttons, ComCtrls, DBGrids, DB, STQuery, ExtCtrls;

type
  TFr_FichaColab = class(TForm)
    Qr_Ficha: TSTQuery;
    Ds_Ficha: TDataSource;
    StrGrid_Mostra: TStringGrid;
    Pnl_botao: TPanel;
    SB_Imprimir: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure StrGrid_MostraDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure SB_ImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Cd_Colaborador:Integer;
    It_Nm_Colaborador : String;
    It_Ano : Integer;
    procedure Pc_FormataTela;
    procedure CalculaFicha;
    procedure Pc_TotalizadorLinha;
    procedure Pc_TotalizadorColuna;
    procedure Pc_ImagemBotao;
  end;

var
  Fr_FichaColab: TFr_FichaColab;

implementation

uses     Un_Funcoes, UN_RL_Fich_Colaborador, UN_Sistema, UN_Principal, env;
{$R *.dfm}



procedure TFr_FichaColab.CalculaFicha;
Var
  Lc_I : Integer;
  Lc_Desc_Hist:String;
LAbel Volta;
begin
  Qr_Ficha.Active := False;
  Qr_Ficha.ParamByName('FPT_CODCLB').AsInteger:= It_Cd_Colaborador;
  Qr_Ficha.ParamByName('FPT_ANO').AsInteger:= It_Ano;
  Qr_Ficha.Active:=True;
  Qr_Ficha.First;
  Lc_I:=1;
  StrGrid_Mostra.Cols[0].Add(Qr_Ficha.FieldByName('FPT_HISTORICO').AsString) ;
  Volta:
  Lc_Desc_Hist := Qr_Ficha.FieldByName('FPT_HISTORICO').AsString;
  WHILE NOT Qr_Ficha.Eof DO
    BEGIN
    if (Lc_Desc_Hist = Qr_Ficha.FieldByName('FPT_HISTORICO').AsString) then
      begin
      StrGrid_Mostra.Cells[Qr_Ficha.FieldByName('FPT_MES').AsInteger,Lc_I] := FloatToStrF(abs(Qr_Ficha.FieldByName('FPT_VENC').AsFloat-Qr_Ficha.FieldByName('FPT_DESC').AsFloat),ffFixed,10,2);
      if (Qr_Ficha.FieldByName('FPT_VENC').AsFloat > 0) then
        StrGrid_Mostra.Cells[Qr_Ficha.FieldByName('FPT_MES').AsInteger + 12,Lc_I] := 'V'
      else
        StrGrid_Mostra.Cells[Qr_Ficha.FieldByName('FPT_MES').AsInteger + 12,Lc_I] := 'D';
      end
    else
      Begin
      Lc_I := Lc_I + 1;
      StrGrid_Mostra.RowCount:=StrGrid_Mostra.RowCount+1;
      StrGrid_Mostra.Cols[0].Add(Qr_Ficha.FieldByName('FPT_HISTORICO').AsString);
      goto Volta;
      end;
    Lc_Desc_Hist := Qr_Ficha.FieldByName('FPT_HISTORICO').AsString;
    Qr_Ficha.Next;
    END;

end;

procedure TFr_FichaColab.Pc_TotalizadorLinha;
Var
  Lc_I,Lc_J:Integer;
  Lc_Valor : Real;
Begin
  for Lc_J:= 1 to StrGrid_Mostra.rowCount - 1 do
    Begin
    Lc_Valor := 0;
    for Lc_I:= 1 to 12 do
      Begin
      Lc_Valor := Lc_Valor + StrToFloatDef(StrGrid_Mostra.Cells[Lc_I,Lc_J],0)
      end;
    StrGrid_Mostra.Cells[25,lc_J] := FloatToStrF(Lc_Valor,ffFixed,10,2);
    end;
end;

procedure TFr_FichaColab.Pc_TotalizadorColuna;
Var
  Lc_I,Lc_J:Integer;
  Lc_Vl_Vencimento : Real;
  Lc_Vl_Desconto : Real;
Begin
  StrGrid_Mostra.RowCount := StrGrid_Mostra.RowCount + 4;
  StrGrid_Mostra.Cells[0,StrGrid_Mostra.RowCount - 3] := 'Total de Vencimentos';
  StrGrid_Mostra.Cells[0,StrGrid_Mostra.RowCount - 2] := 'Total de Desconto';
  StrGrid_Mostra.Cells[0,StrGrid_Mostra.RowCount - 1] := 'Totalizador';
  for Lc_J:= 1 to StrGrid_Mostra.ColCount do
    Begin
    Lc_Vl_Vencimento := 0;
    Lc_Vl_Desconto := 0;
    for Lc_I:= 1 to StrGrid_Mostra.RowCount - 4 do
      Begin
      if (Lc_J <= 12) then
        Begin
        if (StrGrid_Mostra.Cells[Lc_J +12 ,Lc_I]) = 'V' then
          Lc_Vl_Vencimento := Lc_Vl_Vencimento + StrToFloatDef(StrGrid_Mostra.Cells[Lc_J,Lc_I],0)
        else
          Lc_Vl_Desconto := Lc_Vl_Desconto + StrToFloatDef(StrGrid_Mostra.Cells[Lc_J,Lc_I],0);
        end;
      end;
    StrGrid_Mostra.Cells[Lc_J,StrGrid_Mostra.RowCount - 3] := FloatToStrF(Lc_Vl_Vencimento,ffFixed,10,2);
    StrGrid_Mostra.Cells[Lc_J,StrGrid_Mostra.RowCount - 2] := FloatToStrF(Lc_Vl_Desconto,ffFixed,10,2);
    StrGrid_Mostra.Cells[Lc_J,StrGrid_Mostra.RowCount - 1] := FloatToStrF(Lc_Vl_Vencimento - Lc_Vl_Desconto,ffFixed,10,2);
    end;
end;

procedure TFr_FichaColab.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  Fr_FichaColab:=nil;
end;

procedure TFr_FichaColab.Pc_FormataTela;
Begin
  StrGrid_Mostra.ColWidths[0]  := 300;
  StrGrid_Mostra.ColWidths[1]  := 65;
  StrGrid_Mostra.ColWidths[2]  := 65;
  StrGrid_Mostra.ColWidths[3]  := 65;
  StrGrid_Mostra.ColWidths[4]  := 65;
  StrGrid_Mostra.ColWidths[5]  := 65;
  StrGrid_Mostra.ColWidths[6]  := 65;
  StrGrid_Mostra.ColWidths[7]  := 65;
  StrGrid_Mostra.ColWidths[8]  := 65;
  StrGrid_Mostra.ColWidths[9]  := 65;
  StrGrid_Mostra.ColWidths[10] := 65;
  StrGrid_Mostra.ColWidths[11] := 65;
  StrGrid_Mostra.ColWidths[12] := 65;
  StrGrid_Mostra.ColWidths[13] := -1;
  StrGrid_Mostra.ColWidths[14] := -1;
  StrGrid_Mostra.ColWidths[15] := -1;
  StrGrid_Mostra.ColWidths[16] := -1;
  StrGrid_Mostra.ColWidths[17] := -1;
  StrGrid_Mostra.ColWidths[18] := -1;
  StrGrid_Mostra.ColWidths[19] := -1;
  StrGrid_Mostra.ColWidths[20] := -1;
  StrGrid_Mostra.ColWidths[21] := -1;
  StrGrid_Mostra.ColWidths[22] := -1;
  StrGrid_Mostra.ColWidths[23] := -1;
  StrGrid_Mostra.ColWidths[24] := -1;
  StrGrid_Mostra.ColWidths[25] := 80;
  
  StrGrid_Mostra.Cols[0].Add('Descrição Evento');
  StrGrid_Mostra.Cols[1].Add('JANEIRO');
  StrGrid_Mostra.Cols[2].Add('FEVEREIRO');
  StrGrid_Mostra.Cols[3].Add('MARÇO');
  StrGrid_Mostra.Cols[4].Add('ABRIL');
  StrGrid_Mostra.Cols[5].Add('MAIO');
  StrGrid_Mostra.Cols[6].Add('JUNHO');
  StrGrid_Mostra.Cols[7].Add('JULHO');
  StrGrid_Mostra.Cols[8].Add('AGOSTO');
  StrGrid_Mostra.Cols[9].Add('SETEMBRO');
  StrGrid_Mostra.Cols[10].Add('OUTUBRO');
  StrGrid_Mostra.Cols[11].Add('NOVEMBRO');
  StrGrid_Mostra.Cols[12].Add('DEZEMBRO');
  StrGrid_Mostra.Cols[25].Add('VALOR TOTAL');
  Caption := 'Ficha Financeira do Colaborador - ' + It_Nm_Colaborador;
end;

procedure TFr_FichaColab.FormShow(Sender: TObject);
begin
  Pc_Formatatela;
  CalculaFicha;
  Pc_TotalizadorColuna;
  Pc_TotalizadorLinha;
  Pc_ImagemBotao;
end;

procedure TFr_FichaColab.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Imprimir.Glyph.Assign(Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_FichaColab.StrGrid_MostraDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin

  If (arow = (StrGrid_Mostra.RowCount - 2)) and (acol>0)  then
    Begin // verifica se a linha impar
    StrGrid_Mostra.Canvas.Font.Color:= clRed;
    StrGrid_Mostra.Canvas.Brush.Color:= clCream;
    end;

  StrGrid_Mostra.Canvas.FillRect(Rect); // redesenha a celula
  StrGrid_Mostra.Canvas.TextOut(Rect.Left+2,Rect.Top,StrGrid_Mostra.Cells[acol,arow]); // reimprime o texto.


  //Pega o texto da célula
  Texto := StrGrid_Mostra.Cells[acol, ARow];

  //Calcura largura e altura (em pontos) do texto
  LarguraTexto := StrGrid_Mostra.Canvas.TextWidth(Texto);
  AlturaTexto := StrGrid_Mostra.Canvas.TextHeight(Texto);



  //Calcula a posição horizontal do início do texto
  if  (ACol = 0) then //esquerda
    X := Rect.Left + 2
  else if  (ACol = 13) then //Centro
    X := Rect.Left + (Rect.Right - Rect.Left) div 2 -
      LarguraTexto div 2
  else //Direita
    X := Rect.Right - LarguraTexto - 2;


  //Calcula a posição vertical do início do texto para
  //que seja impresso no centro (verticalmente) da célula
  Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -
    AlturaTexto div 2;

  //Pinta o texto
  StrGrid_Mostra.Canvas.TextRect(Rect, X, Y, Texto);
end;

procedure TFr_FichaColab.SB_Sair_0Click(Sender: TObject);
begin
  close;
end;

procedure TFr_FichaColab.SB_ImprimirClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    if not Assigned(RL_Fich_Colaborador) then (Application.CreateForm(TRL_Fich_Colaborador, RL_Fich_Colaborador));
    RL_Fich_Colaborador.Qrpt.Preview;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
    RL_Fich_Colaborador.Close;
  end;
end;

end.
