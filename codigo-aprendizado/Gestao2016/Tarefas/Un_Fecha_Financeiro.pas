unit Un_Fecha_Financeiro;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Data.DB, STQuery, Vcl.Buttons, Vcl.Menus;

type
  TFR_Fecha_Financeiro = class(TFr_Base)
    Panel1: TPanel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    StrGrd_Valores: TStringGrid;
    Label6: TLabel;
    Qr_Valores: TSTQuery;
    Ds_Valores: TDataSource;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    SB_Confirmar: TSpeedButton;
    SB_Sair: TSpeedButton;
    procedure StrGrd_ValoresDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SB_SairClick(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure StrGrd_ValoresSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
    Function ValidaFechamento:Boolean;
    Function ExecutaFechamento:Boolean;
  protected
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
    procedure ImagemBotao;Override;

  public
    { Public declarations }

    procedure Pc_Buscar;
    procedure Pc_CtaGerencialRealizado;
  end;

var
  FR_Fecha_Financeiro: TFR_Fecha_Financeiro;

implementation

{$R *.dfm}

uses     RN_PlanoContas, ControllerFechaFinanceiro, Un_Funcoes, Un_Msg, env;
procedure TFR_Fecha_Financeiro.FormataTela;
Var
  Lc_I : Integer;
begin
  with StrGrd_Valores do
  Begin
    ColCount := 5;
    ColWidths[0]:=17;
    ColWidths[1]:=-1;
    Cols[1].Add('Codigo');
    ColWidths[2]:=70;
    Cols[2].Add('Plano');
    ColWidths[3]:=300;
    Cols[3].Add('Descrição');
    ColWidths[4]:=80;
    Cols[4].Add('Saldo');
  end;
end;

procedure TFR_Fecha_Financeiro.ImagemBotao;
begin
  CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
  CarregaImagemBotao(Sb_Sair,'SAIR');
end;

procedure TFR_Fecha_Financeiro.IniciaVariaveis;
begin
  E_Data_Ini.DateTime:= Now-31;
  E_Data_Fim.DateTime:= Now;
end;

procedure TFR_Fecha_Financeiro.Pc_Buscar;
Var
  Lc_SqlTxt : String;
Begin
  with Qr_Valores do
  Begin
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := ' SELECT '+
                 ' PLC_CODIGO,  '+
                 ' PLC_CODPLANO,  '+
                 ' PLC_DESCRICAO,  '+
                 ' PLC_NATUREZA,  '+
                 ' PLC_TIPO,  '+
                 ' PLC_CODMHA,  '+
                 ' PLC_NIVEL  '+
                 'FROM  tb_planocontas '+
                 'WHERE (PLC_TIPO = ''R'') ';

    Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY 2 ';
    SQL.Add(Lc_SqlTxt );
    Active := True;
  end;
end;

procedure TFR_Fecha_Financeiro.Pc_CtaGerencialRealizado;
Var
  Lc_Linha : Integer;
  Lc_Registro : Integer;
  Lc_Vl_Credito,Lc_Vl_Debito : REAL;
  Lc_Fechamento : TControllerFechaFinanceiro;
  Lc_Vl_Anterior : Real;
begin
  Lc_Fechamento := TControllerFechaFinanceiro.create(Self);
  with Qr_Valores,StrGrd_Valores do
  Begin
    Pc_Buscar;
    First;
    Lc_Linha := 1;
    Lc_Registro := 1;
    while not eof do
    Begin
      inc(Lc_Linha);
      RowCount := Lc_Linha;
      Lc_Vl_Credito := 0;
      Lc_Vl_Debito := 0;
      //Credito
      Lc_Vl_Credito := Fc_ValorContaRealizada(FieldByName('PLC_TIPO').AsString,
                                              FieldByName('PLC_CODPLANO').AsString,
                                              'MVF_VL_CREDITO',
                                              E_Data_Ini.Date,
                                              E_Data_Fim.Date);
      //Debito
      Lc_Vl_Debito := Fc_ValorContaRealizada(FieldByName('PLC_TIPO').AsString,
                                             FieldByName('PLC_CODPLANO').AsString,
                                              'MVF_VL_DEBITO',
                                              E_Data_Ini.Date,
                                              E_Data_Fim.Date);

      Cells[1,Lc_Registro] := FieldByName('PLC_CODIGO').AsString;
      Cells[2,Lc_Registro] := FieldByName('PLC_CODPLANO').AsString;
      Cells[3,Lc_Registro] := FieldByName('PLC_DESCRICAO').AsString;
      Lc_Vl_Anterior := Lc_Fechamento.getSaldoAnterior(FieldByName('PLC_CODIGO').AsInteger,E_Data_Ini.Date);

      Cells[4,Lc_Registro] := FloatToStrF((Lc_Vl_Credito + Lc_Vl_Anterior ) - Lc_Vl_Debito ,ffFixed,10,2);
      next;
      inc(Lc_Registro);
    end;
  end;

end;

Function  TFR_Fecha_Financeiro.ValidaFechamento:Boolean;
BEgin
  Result := True;

End;

Function  TFR_Fecha_Financeiro.ExecutaFechamento:Boolean;
Var
  Lc_Fechamento : TControllerFechaFinanceiro;
  I : Integer;
  Lc_Valor : String;
Begin
  Lc_Fechamento := TControllerFechaFinanceiro.Create(self);
  with Lc_Fechamento.Registro, StrGrd_Valores do
  BEgin
    for I := 1 to Rowcount - 1 do
    Begin
      Data := E_Data_Fim.Date;
      CodigoPlanoContas := StrToIntDef(cells[1,I],0);
      Lc_Valor := Fc_RemoveCaracterInformado(cells[4,I], ['.']);
      Valor := StrToFloatDef(Lc_Valor,0);
      Lc_Fechamento.salva;
    End;
  End;
  FreeAndNil(Lc_Fechamento);
  MensagemPadrao(MENSAGEM,'S U C E S S O!!.'+EOLN+EOLN+
                 'O Fechamento do Financeiro foi'+EOLN+
                 '     realizado com sucesso.'+EOLN,
                ['OK'],[bEscape],mpInformacao);
End;

procedure TFR_Fecha_Financeiro.SB_ConfirmarClick(Sender: TObject);
begin
  if ValidaFechamento then
  BEgin
    ExecutaFechamento;
  End;

end;

procedure TFR_Fecha_Financeiro.SB_SairClick(Sender: TObject);
begin
  Close;
end;

procedure TFR_Fecha_Financeiro.SpeedButton1Click(Sender: TObject);
begin
  Pc_CtaGerencialRealizado;
end;

procedure TFR_Fecha_Financeiro.StrGrd_ValoresDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  If (arow > 0) and (acol >0) then  // testa se não é a primeira linha (fixa)
  Begin
    with StrGrd_Valores do
    Begin
      Canvas.Font.Color:= clBlack;
      Canvas.Brush.Color:= clMoneyGreen;
      Canvas.FillRect(Rect); // redesenha a celula
      Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.

      { Pega o texto da célula }
      Texto := Cells[acol, ARow];
      if (ACol = 4) and (arow> 0) then
        Texto := FloatToStrF(StrToFloatDef(Texto,0),ffNumber,10,2);
      { Calcura largura e altura (em pontos) do texto }
      LarguraTexto := Canvas.TextWidth(Texto);
      AlturaTexto := Canvas.TextHeight(Texto);

      { Calcula a posição horizontal do início do texto }
      if  (ACol = 2)or (ACol = 3) then { esquerda }
        X := Rect.Left + 2
      else if  (ACol = 0) then { Centro }
        X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
      else { Direita }
        X := Rect.Right - LarguraTexto - 2;

      { Calcula a posição vertical do início do texto para
        que seja impresso no centro (verticalmente) da célula }
      Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -  AlturaTexto div 2;

      { Pinta o texto }
      Canvas.TextRect(Rect, X, Y, Texto);
    end;
  end;

end;

procedure TFR_Fecha_Financeiro.StrGrd_ValoresSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := ( (ACol = 4)  and (ARow >0) );
end;

end.
