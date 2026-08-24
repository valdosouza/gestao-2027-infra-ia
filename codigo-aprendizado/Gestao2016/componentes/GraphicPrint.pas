unit GraphicPrint;

interface

uses
       SysUtils, Vcl.Printers, Vcl.Graphics, System.Classes;
type
  TGraphicPrint = class
    private
      Margem : AnsiString;
      Arquivo: TextFile;
      NomeImpressora: String;
      FLinhas: Integer;
      FSaltos: Integer;
      procedure configuraRDPRINT;

      procedure setFLinhas(const Value: Integer);
      procedure setFSaltos(const Value: Integer);
    public
      constructor Create;
      destructor Destroy;
      procedure Iniciar;
      procedure Saltar;
      procedure Fechar;
      procedure print(c:TStringList);

      property Linhas : Integer read FLinhas write setFLinhas;
      Property Saltos : Integer read FSaltos write setFSaltos;
  end;
implementation

uses     UN_Sistema;


procedure TGraphicPrint.configuraRDPRINT;
begin
  {
  with RdPrint_DP do
  Begin
    ImpressoraPersonalizada.NomeImpressora  :=  Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NOME_IMPRESSORA','' );
    ImpressoraPersonalizada.AvancaOitavos   := '27 48';
    ImpressoraPersonalizada.AvancaSextos    := '27 50';
    ImpressoraPersonalizada.SaltoPagina     := '12';
    ImpressoraPersonalizada.TamanhoPagina   := '27 67 66';
    ImpressoraPersonalizada.Negrito         := '27 69';
    ImpressoraPersonalizada.Italico         := '27 52';
    ImpressoraPersonalizada.Sublinhado      := '27 45 49';
    ImpressoraPersonalizada.Expandido       := '27 14';
    ImpressoraPersonalizada.Normal10        := '18 27 80';
    ImpressoraPersonalizada.Comprimir12     := '18 27 77';
    ImpressoraPersonalizada.Comprimir17     := '27 80 27 15';
    ImpressoraPersonalizada.Comprimir20     := '27 77 27 15';
    ImpressoraPersonalizada.Reset           := '27 80 18 20 27 53 27 70 27 45 48';
    ImpressoraPersonalizada.Inicializar     := '27 64';
    OpcoesPreview.PaginaZebrada   := False;
    OpcoesPreview.Remalina        := False;
    OpcoesPreview.CaptionPreview  := 'Visualiza'#231#227'o';
    OpcoesPreview.PreviewZoom     := 100;
    OpcoesPreview.CorPapelPreview := clWhite;
    OpcoesPreview.CorLetraPreview := clBlack;
    OpcoesPreview.Preview         := False;
    //OpcoesPreview.BotaoSetup.Invisivel. := 2;
    //OpcoesPreview.BotaoImprimir.Ativo;
    //OpcoesPreview.BotaoGravar.Invisivel;
    //OpcoesPreview.BotaoLer.Invisivel;
    //OpcoesPreview.BotaoProcurar.Invisivel;
    //OpcoesPreview.BotaoPDF.Ativo;
    //OpcoesPreview.BotaoEMAIL.Invisivel;
    Margens.Left        := 3;
    Margens.Right       := 3;
    Margens.Top         := 3;
    Margens.Bottom      := 3;
    Acentuacao          := Transliterate;
    CorForm             := clBtnFace;
    CorFonte            := clBlack;
    TamanhoQteLPP       := Oito;
    NumerodeCopias      := 1;
    FonteTamanhoPadrao  := S17cpp;
    Orientacao          := poPortrait;
    FonteGrafica        := sCourierNew;
    ReduzParaCaber      := False;
    TamanhoQteLinhas    := Linhas + Saltos;
    TamanhoQteColunas   := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NR_COLUNAS', '55'),55);
    MostrarProgresso    := False;
    UsaGerenciadorImpr  := true;
  end
  }
end;


constructor TGraphicPrint.Create;
begin
  inherited;
  //RdPrint_DP := TRDprint.create(nil);
  NomeImpressora := Printer.Printers[Printer.PrinterIndex];
end;

destructor TGraphicPrint.Destroy;
begin
  Printer.Printers[Printer.PrinterIndex] := NomeImpressora;
  //FreeAndNil(RdPrint_DP);
  inherited;
end;

procedure TGraphicPrint.Fechar;
begin
//  RdPrint_DP.TamanhoQteLinhas := FLinhas;
//  RdPrint_DP.Impressora := Grafico;
//  RdPrint_DP.fechar;
end;

procedure TGraphicPrint.Iniciar;
begin
  configuraRDPRINT;
//  /RdPrint_DP.abrir;
end;

procedure TGraphicPrint.print(c:TStringList);
  Var xRow,xCol:LongInt;
Var
  I:Integer;
Begin
//  for I := 0 to c.Count - 1 do
//    RdPrint_DP.impc(I+1,1,c.Strings[I], [comp17]);
end;

procedure TGraphicPrint.Saltar;
Var
  I : Integer;
begin
  if FSaltos > 0 then
  Begin
    For I := 1 to FSaltos do
    Begin
      FLinhas := FLinhas + 1;
      //RdPrint_DP.imp(FLinhas,1, '' );
    End;
  End;
end;


procedure TGraphicPrint.setFLinhas(const Value: Integer);
begin
  FLinhas := Value;
end;

procedure TGraphicPrint.setFSaltos(const Value: Integer);
begin
  FSaltos := Value;
end;

end.

