unit Un_Corte_Chapa;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Mask, QEdit_Setes, ExtCtrls, Buttons, ComCtrls, Grids;

type
  TFr_Corte_Chapa = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    E_Altura_total: TEdit_Setes;
    E_Largura_Total: TEdit_Setes;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    E_Altura_Peca: TEdit_Setes;
    E_Largura_Peca: TEdit_Setes;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    E_Espessura: TEdit_Setes;
    Sb_Sair_0: TSpeedButton;
    Sb_Calcular: TSpeedButton;
    StrGrd_Informacao: TStringGrid;
    SB_Aplicar: TSpeedButton;
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Sb_CalcularClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure StrGrd_InformacaoDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure SB_AplicarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Confirma : Boolean;
    procedure Pc_Formata_Tela;
    function  Fc_valida_Calculo():Boolean;
    procedure Pc_Calc_Area_Quadrado;
    procedure Pc_Calc_Area_Retangulo;
    procedure Pc_Calc_Area_Triangulo;
    procedure Pc_Calc_Area_Losango;
    procedure Pc_ImagemBotao;
    procedure Pc_MontaGradeInformacao;
  end;

var
  Fr_Corte_Chapa: TFr_Corte_Chapa;

implementation

uses     UN_MSG, UN_Principal, env;

{$R *.dfm}

procedure TFr_Corte_Chapa.Pc_MontaGradeInformacao;
Begin
  with StrGrd_Informacao do
    Begin
    //Define tamanho
    Cells[1, 0] := 'Descrição do Resultado';
    Cells[2, 0] := 'Cálculo';
    ColWidths[0] := 17;
    ColWidths[1] := 359;
    ColWidths[2] := 100;
    //Define texto das linhas
    Cells[1,1] := 'A área da Chapa (mm)';
    Cells[1,2] := 'A área da Peça (mm)';
    Cells[1,3] := 'A quantidade de peças no formato quadrado';
    Cells[1,4] := 'A perda de área com a espessura da Serra (mm)';
    Cells[1,5] := 'A perda de área com a sobra de material (mm) ';
    end;
end;

procedure TFr_Corte_Chapa.Pc_Formata_Tela;
Begin
  Pc_MontaGradeInformacao;
end;

function  TFr_Corte_Chapa.Fc_valida_Calculo():Boolean;
Begin
  Result := True;
  If Trim(E_Altura_total.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por Favor informe a altura da Chapa Inteira.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    E_Altura_total.Setfocus;
    exit;
    end;

  If Trim(E_Largura_Total.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por Favor informe a largura da Chapa Inteira.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    E_Largura_Total.Setfocus;
    exit;
    end;

  If Trim(E_Altura_Peca.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por Favor informe a altura da Peça.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    E_Altura_Peca.Setfocus;
    exit;
    end;

  If Trim(E_Largura_Peca.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por Favor informe a largura da peça.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    E_Largura_Peca.Setfocus;
    exit;
    end;

  If Trim(E_Espessura.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por Favor informe a espessura da Serra.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    E_Espessura.Setfocus;
    exit;
    end;
        
end;

procedure TFr_Corte_Chapa.Pc_Calc_Area_Quadrado;
Var
  Lc_Area_Chapa : REal;
  Lc_Area_Total : Real;
  Lc_Area_Peca : Real;
  Lc_Area_Serra : real;
  Lc_Nr_Peca : Integer;
  Lc_Area_Serra_Total : REal;
Begin
  if not Fc_valida_Calculo then exit;
  //Calcula area perdida com a espesssuda da Serra
  Lc_Area_Total  := StrToFloatDef(E_Altura_total.Text,0)  * StrToFloatDef(E_Largura_Total.Text,0) ;
  Lc_Area_Chapa := Lc_Area_Total;
  Lc_Area_Serra  := StrToFloatDef(E_Espessura.Text,0);
  Lc_Area_Peca  := StrToFloatDef(E_Altura_Peca.Text,0)   * StrToFloatDef(E_Largura_Peca.Text,0) ;

  Lc_Nr_Peca := 0;
  Lc_Area_Serra_Total := 0;
  while (Lc_Area_Total > Lc_Area_Peca) do
    Begin
    //Tira a Area da Peça
    Lc_Area_Total := Lc_Area_Total - Lc_Area_Peca;
    //Conta quantas Peças
    Lc_Nr_Peca := Lc_Nr_Peca + 1;
    //Conta quanto da Area da serra será usada no corte
    Lc_Area_Serra := StrToFloatDef(E_Altura_Peca.Text,0) * StrToFloatDef(E_Espessura.Text,0);
    Lc_Area_Serra := Lc_Area_Serra + (StrToFloatDef(E_Largura_Peca.Text,0) * StrToFloatDef(E_Espessura.Text,0));
    Lc_Area_Serra_Total := Lc_Area_Serra_Total + Lc_Area_Serra;
    //Retira a arera da Serra
    if (Lc_Area_Total > Lc_Area_Serra) then
      Lc_Area_Total := Lc_Area_Total - Lc_Area_Serra;
    end;

  with StrGrd_Informacao do
    Begin
    Cells[2,1] := FloatToStrF(Lc_Area_Chapa,ffNumber,10,0);
    Cells[2,2] := FloatToStrF(Lc_Area_Peca,ffNumber,10,0);
    Cells[2,3] := IntToStr(Lc_Nr_Peca);
    Cells[2,4] := FloatToStrF(Lc_Area_Serra_Total,ffNumber,10,0);
    Cells[2,5] := FloatToStrF(Lc_Area_Total,ffNumber,10,0);
    end;
end;

procedure TFr_Corte_Chapa.Pc_Calc_Area_Retangulo;
Begin
  if not Fc_valida_Calculo then exit;

end;

procedure TFr_Corte_Chapa.Pc_Calc_Area_Triangulo;
Begin
  if not Fc_valida_Calculo then exit;

end;

procedure TFr_Corte_Chapa.Pc_Calc_Area_Losango;
Begin
  if not Fc_valida_Calculo then exit;

end;

procedure TFr_Corte_Chapa.Sb_Sair_0Click(Sender: TObject);
begin
  It_Confirma := False;
  Close;
end;

procedure TFr_Corte_Chapa.FormCreate(Sender: TObject);
begin
  Pc_Formata_Tela;
end;

procedure TFr_Corte_Chapa.Sb_CalcularClick(Sender: TObject);
begin
  Pc_Calc_Area_Quadrado;
end;

procedure TFr_Corte_Chapa.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
end;

procedure TFr_Corte_Chapa.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Corte_Chapa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Corte_Chapa.StrGrd_InformacaoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  With StrGrd_Informacao do
    Begin
    If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
      Begin
      Canvas.Font.Color:= clBlack;
      Canvas.Brush.Color:= clCream;
      end;
    Canvas.FillRect(Rect); // redesenha a celula
    Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.

    { Pega o texto da célula }
    Texto := Cells[acol, ARow];

    { Calcura largura e altura (em pontos) do texto }
    LarguraTexto := Canvas.TextWidth(Texto);
    AlturaTexto := Canvas.TextHeight(Texto);

    { Calcula a posição horizontal do início do texto }
    if  (ACol = 1)then { esquerda }
      X := Rect.Left + 2
    else if  (ACol = 0)   or (ACol = 15) then { Centro }
      X := Rect.Left + (Rect.Right - Rect.Left) div 2 -
        LarguraTexto div 2
    else { Direita }
      X := Rect.Right - LarguraTexto - 2;


    { Calcula a posição vertical do início do texto para
      que seja impresso no centro (verticalmente) da célula }
    Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -
      AlturaTexto div 2;

    { Pinta o texto }
    Canvas.TextRect(Rect, X, Y, Texto);
    end;
end;

procedure TFr_Corte_Chapa.SB_AplicarClick(Sender: TObject);
begin
  It_Confirma := True;
  Close;
end;

end.
