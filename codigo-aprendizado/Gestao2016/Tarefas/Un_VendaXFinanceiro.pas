unit Un_VendaXFinanceiro;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons, Mask, QEdit_Setes, DB, STQuery, Grids;

type
  TFr_VendaXFinanceiro = class(TForm)
    GroupBox1: TGroupBox;
    SB_Sair: TSpeedButton;
    SB_Buscar: TSpeedButton;
    Sb_Empresa: TSpeedButton;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    L_CodigoCliente: TLabel;
    E_BuscaCliente: TEdit;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    E_BuscaCodigo: TEdit;
    Qr_Vendas: TSTQuery;
    StrGrd_Vendas: TStringGrid;
    Qr_Financeiro: TSTQuery;
    ChBx_Suprimir: TCheckBox;
    procedure SB_BuscarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SB_SairClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure StrGrd_VendasDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ChBx_SuprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Cd_Nota:Integer;
    It_Nr_Registro : Integer;
    It_Vl_Vendas: Currency;
    Procedure Pc_Formata_Tela;
    Procedure Pc_Inicia_Variaveis;
    procedure Pc_Definir_Grade_Vendas;
    procedure Pc_PreencherGrade;
    function Fc_ValidaBusca:Boolean;
    Procedure Pc_BuscaVendas;
    procedure Pc_PreencherVendas;
    Procedure Pc_BuscaFinanceiro;
    procedure Pc_PreencherFinanceiro;

  end;

var
  Fr_VendaXFinanceiro: TFr_VendaXFinanceiro;

implementation

uses     Un_DM, UN_MSG, UN_Sistema, Un_Regra_Negocio, Un_Principal, env;
{$R *.dfm}

Procedure TFr_VendaXFinanceiro.Pc_Inicia_Variaveis;
Begin
  It_Cd_Nota := 0;
  It_Nr_Registro :=0;
end;

Procedure TFr_VendaXFinanceiro.Pc_Formata_Tela;
Begin
  Pc_LimpaStringGrid(StrGrd_Vendas);
  Pc_Definir_Grade_Vendas;
end;

function  TFr_VendaXFinanceiro.Fc_ValidaBusca:Boolean;
Begin
  Result := True;
  if ((Trim(E_BuscaCodigo.Text)='') and (Trim(E_BuscaCliente.Text) ='')) then
    Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'O Cliente deve ser informado.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
    end;
end;

procedure TFr_VendaXFinanceiro.Pc_Definir_Grade_Vendas;
begin
  StrGrd_Vendas.ColWidths[0]:=17;
  StrGrd_Vendas.ColWidths[1]:=-1;
  StrGrd_Vendas.ColWidths[2]:=64;
  StrGrd_Vendas.ColWidths[3]:=70;
  StrGrd_Vendas.ColWidths[4]:=80;
  StrGrd_Vendas.ColWidths[5]:=80;
  StrGrd_Vendas.ColWidths[6]:=-1;
  StrGrd_Vendas.ColWidths[7]:=80;
  StrGrd_Vendas.ColWidths[8]:=80;
  StrGrd_Vendas.ColWidths[9]:=80;
  StrGrd_Vendas.ColWidths[10]:=80;
  StrGrd_Vendas.ColWidths[11]:=80;
  StrGrd_Vendas.ColWidths[12]:=100;
  StrGrd_Vendas.ColWidths[13]:=-1;
  StrGrd_Vendas.Cols[1].Add('nfl_codigo');
  StrGrd_Vendas.Cols[2].Add('Pedido');
  StrGrd_Vendas.Cols[3].Add('Nota Fiscal');
  StrGrd_Vendas.Cols[4].Add('Data');
  StrGrd_Vendas.Cols[5].Add('Valor Pedido');
  StrGrd_Vendas.Cols[6].Add('fin_codigo');
  StrGrd_Vendas.Cols[7].Add('Duplicata');
  StrGrd_Vendas.Cols[8].Add('Vencimento');
  StrGrd_Vendas.Cols[9].Add('Parcela');
  StrGrd_Vendas.Cols[10].Add('Pagamento');
  StrGrd_Vendas.Cols[11].Add('Valor Pago');
  StrGrd_Vendas.Cols[12].Add('Saldo');
  StrGrd_Vendas.Cols[13].Add('Operação');

end;

Procedure TFr_VendaXFinanceiro.Pc_BuscaVendas;
var
  Lc_SqlTxt:string;
  Lc_Cliente, Lc_codigo: Boolean;
begin
  Lc_SqlTxt := '';
  Screen.Cursor := crHourGlass;
  Qr_Vendas.Close;
  Qr_Vendas.Sql.Clear;
  Lc_SqlTxt := 'SELECT NFL_CODIGO, PED_NUMERO, NFL_NUMERO, NFL_DT_EMISSAO, EMP_FANTASIA, EMP_NOME, '+
               'NFL_VL_TL_NOTA                                                      '+
               'FROM TB_NOTA_FISCAL Tb_nota_fiscal                                                 '+
               '  INNER JOIN TB_EMPRESA tb_empresa                                                 '+
               '  ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)                           '+
               '  INNER JOIN TB_PEDIDO tb_pedido                                                   '+
               '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)                            '+
               'WHERE (NFL_CODIGO IS NOT NULL) AND (NFL_CODMHA=:NFL_CODMHA) AND (PED_TIPO = ''1'') ' ;

  if Trim(E_BuscaCodigo.text) = '' then Lc_codigo := False else Lc_codigo := True;
  if Trim(E_BuscaCliente.text)= '' then Lc_Cliente := False else Lc_Cliente := True;

  if Lc_codigo  then Lc_SqlTxt := Lc_SqlTxt + 'AND (EMP_CODIGO =:EMP_CODIGO) ';
  if Lc_Cliente then Lc_SqlTxt := Lc_SqlTxt + 'AND ((EMP_NOME LIKE :EMP_NOME) or (EMP_FANTASIA LIKE :EMP_NOME) ) ';
  if ChBx_Periodo.Checked then
    Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_DT_EMISSAO BETWEEN :NFL_DATAINICIO AND :NFL_DATAFIM) ';
  Qr_Vendas.SQL.Add(Lc_Sqltxt + ' ORDER BY PED_NUMERO, PED_DATA');

  if Lc_codigo  then Qr_Vendas.ParamByName('EMP_CODIGO').AsString := E_BuscaCodigo.Text;
  if Lc_Cliente then Qr_Vendas.ParamByName('EMP_NOME').AsString := '%'+E_BuscaCliente.Text+'%';

  if ChBx_Periodo.Checked then
    Begin
    Qr_Vendas.ParamByName('NFL_DATAINICIO').AsDate:=E_Data_Ini.Date;
    Qr_Vendas.ParamByName('NFL_DATAFIM').AsDate:=E_Data_Fim.Date;
    end;
  Qr_Vendas.ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
  Qr_Vendas.Open;
  Screen.Cursor:=crDefault;
end;

procedure TFr_VendaXFinanceiro.Pc_PreencherVendas;
Begin
  inc(It_Nr_Registro);
  StrGrd_Vendas.RowCount := It_Nr_Registro + 1;
  //codigo
  StrGrd_Vendas.Cells[1,It_Nr_Registro] := Qr_Vendas.FieldByname('NFL_CODIGO').AsString;
  //PEdido
  StrGrd_Vendas.Cells[2,It_Nr_Registro] := Qr_Vendas.FieldByname('PED_NUMERO').AsString;
  //nota
  StrGrd_Vendas.Cells[3,It_Nr_Registro] := Qr_Vendas.FieldByname('NFL_NUMERO').AsString;
  //Data
  StrGrd_Vendas.Cells[4,It_Nr_Registro] := Qr_Vendas.FieldByname('NFL_DT_EMISSAO').AsString;
  //Valor do Pedido
  StrGrd_Vendas.Cells[5,It_Nr_Registro] := FloatToStrF(Qr_Vendas.FieldByname('NFL_VL_TL_NOTA').AsCurrency,ffFixed,10,2);

end;

Procedure TFr_VendaXFinanceiro.Pc_BuscaFinanceiro;
var
  Lc_SqlTxt:string;
  Lc_Cliente, Lc_codigo: Boolean;
begin
  Lc_SqlTxt := '';
  Screen.Cursor := crHourGlass;
  Qr_Financeiro.Close;
  Qr_Financeiro.Sql.Clear;
  Lc_SqlTxt := 'SELECT FIN_CODIGO,FIN_NUMERO,FIN_DT_VENCIMENTO, FIN_VL_PARCELA, FIN_DT_PAGTO,         '+
               ' FIN_VL_PAGO, FIN_OPERACAO                                                            '+
               'FROM TB_FINANCEIRO tb_financeiro                                                      '+
               '  INNER JOIN TB_NOTA_FISCAL Tb_nota_fiscal                                            '+
               '  ON (tb_financeiro.FIN_CODNFL = Tb_nota_fiscal.NFL_CODIGO)                           '+
               '  INNER JOIN TB_EMPRESA tb_empresa                                                    '+
               '  ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)                              '+
               '  INNER JOIN TB_PEDIDO tb_pedido                                                      '+
               '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)                               '+
               'WHERE (FIN_CODNFL =:NFL_CODIGO)                                                       ';

  Qr_Financeiro.SQL.Add(Lc_Sqltxt + ' ORDER BY FIN_DT_VENCIMENTO');
  Screen.Cursor:=crDefault;
End;

procedure TFr_VendaXFinanceiro.Pc_PreencherFinanceiro;
Var
  Lc_valor : Real;
  Lc_J : Integer;
Begin
  Qr_Financeiro.Active := False;
  Qr_Financeiro.ParamByName('NFL_CODIGO').AsString := Qr_Vendas.FieldByname('NFL_CODIGO').AsString;
  It_Vl_Vendas := It_Vl_Vendas + Qr_Vendas.FieldByname('NFL_VL_TL_NOTA').AsCurrency;
  Qr_Financeiro.Active := True;
  Qr_Financeiro.FetchAll;
  Qr_Financeiro.First;
  Lc_valor := 0;
  while not Qr_Financeiro.Eof do
    Begin
    if not Qr_Financeiro.Bof then
       StrGrd_Vendas.RowCount := It_Nr_Registro + 1;
    //fin_codigo
    StrGrd_Vendas.Cells[6,It_Nr_Registro] := Qr_Vendas.FieldByname('NFL_CODIGO').AsString;
    //Duplicata
    StrGrd_Vendas.Cells[7,It_Nr_Registro] := Qr_Financeiro.FieldByname('FIN_NUMERO').AsString;
    //Vencimento
    StrGrd_Vendas.Cells[8,It_Nr_Registro] := Qr_Financeiro.FieldByname('FIN_DT_VENCIMENTO').AsString;
    //Parcela
    StrGrd_Vendas.Cells[9,It_Nr_Registro] := FloatToStrF(Qr_Financeiro.FieldByname('FIN_VL_PARCELA').AsCurrency,ffFixed,10,2);
    if Qr_Financeiro.FieldByname('FIN_OPERACAO').AsString = 'C' then
      Lc_valor := Lc_valor + Qr_Financeiro.FieldByname('FIN_VL_PARCELA').AsCurrency
    else
      Lc_valor := Lc_valor - Qr_Financeiro.FieldByname('FIN_VL_PARCELA').AsCurrency;
    //Pagamento
    StrGrd_Vendas.Cells[10,It_Nr_Registro] := Qr_Financeiro.FieldByname('FIN_DT_PAGTO').AsString;
    //Valor Pago
    StrGrd_Vendas.Cells[11,It_Nr_Registro] := FloatToStrF(Qr_Financeiro.FieldByname('FIN_VL_PAGO').AsCurrency,ffFixed,10,2);
    //Registra a operação
    StrGrd_Vendas.Cells[13,It_Nr_Registro] := Qr_Financeiro.FieldByname('FIN_OPERACAO').AsString;
    Qr_Financeiro.Next;
    if not Qr_Financeiro.Eof then inc(It_Nr_Registro);
    end;
    //Saldo da Parcela
    if Lc_valor > 0 then
      Begin
      StrGrd_Vendas.Cells[12,It_Nr_Registro] := FloatToStrF(It_Vl_Vendas - Lc_valor,ffFixed,10,2);
      It_Vl_Vendas := 0;
      end;


end;


procedure TFr_VendaXFinanceiro.Pc_PreencherGrade;
Begin
  Pc_BuscaFinanceiro;
  Qr_Vendas.First;
  It_Nr_Registro := 0;
  It_Vl_Vendas := 0;
  while not Qr_Vendas.Eof do
    Begin
    Pc_PreencherVendas;
    Pc_PreencherFinanceiro;
    Qr_Vendas.Next;
    end;
end;

procedure TFr_VendaXFinanceiro.SB_BuscarClick(Sender: TObject);
begin
  if not Fc_ValidaBusca then exit;
  Pc_BuscaVendas;
  Pc_LimpaStringGrid(StrGrd_Vendas);
  Pc_PreencherGrade;
end;

procedure TFr_VendaXFinanceiro.FormShow(Sender: TObject);
begin
  Pc_Formata_Tela;
  Pc_Inicia_Variaveis;
end;

procedure TFr_VendaXFinanceiro.SB_SairClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_VendaXFinanceiro.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_VendaXFinanceiro.StrGrd_VendasDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
    Begin
    if (StrGrd_Vendas.Cells[13,arow]='C') then
      begin // verifica se a linha impar
      StrGrd_Vendas.Canvas.Font.Color:= clBlack;
      StrGrd_Vendas.Canvas.Brush.Color:= clCream;
      end
    else
      begin
      StrGrd_Vendas.Canvas.Font.Color:= clRed;
      StrGrd_Vendas.Canvas.Brush.Color:= clCream;
      end;
    end;
  StrGrd_Vendas.Canvas.FillRect(Rect); // redesenha a celula
  StrGrd_Vendas.Canvas.TextOut(Rect.Left+2,Rect.Top,StrGrd_Vendas.Cells[acol,arow]); // reimprime o texto.


  { Pega o texto da célula }
  Texto := StrGrd_Vendas.Cells[acol, ARow];

  { Calcura largura e altura (em pontos) do texto }
  LarguraTexto := StrGrd_Vendas.Canvas.TextWidth(Texto);
  AlturaTexto := StrGrd_Vendas.Canvas.TextHeight(Texto);

  { Calcula a posição horizontal do início do texto }
  if  (ACol = 2) or (ACol = 3) then { esquerda }
    X := Rect.Left + 2
  else if  (ACol = 4)   or (ACol = 8) or (ACol = 10) then { Centro }
    X := Rect.Left + (Rect.Right - Rect.Left) div 2 -
      LarguraTexto div 2
  else { Direita }
    X := Rect.Right - LarguraTexto - 2;

  { Calcula a posição vertical do início do texto para
    que seja impresso no centro (verticalmente) da célula }
  Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -
    AlturaTexto div 2;

  { Pinta o texto }
  StrGrd_Vendas.Canvas.TextRect(Rect, X, Y, Texto);


end;

procedure TFr_VendaXFinanceiro.ChBx_SuprimirClick(Sender: TObject);
Var
  Lc_I,lC_j,Lc_Linha: Integer;
  Lc_Lista: array of array of string;
begin
   Lc_Linha := 0;
   SetLength(Lc_Lista, StrGrd_Vendas.RowCount, StrGrd_Vendas.ColCount);
  //Guarda os dados que não estão marcados

   for Lc_I := 1 to StrGrd_Vendas.RowCount - 1 do
   begin
     if StrToFloatDef(StrGrd_Vendas.Cells[12,Lc_I],0) <> 0 then
      begin
         Lc_Linha := Lc_Linha + 1;
         for Lc_J := 1 to StrGrd_Vendas.ColCount - 1 do
            Lc_Lista[Lc_Linha, Lc_J] := StrGrd_Vendas.Cells[Lc_J, Lc_I];
      end;
   end;

  //Limpa a Matriz antes de incluir a diferenca
   for Lc_I := 1 to StrGrd_Vendas.RowCount - 1 do
      for Lc_J := 1 to StrGrd_Vendas.ColCount - 1 do
         StrGrd_Vendas.Cells[Lc_J, Lc_I] := '';

   StrGrd_Vendas.RowCount := 2;

  //Grava novamente os dados que não foram marcados e que estão na matriz
   if (Lc_Linha > 0) then
   begin
      for Lc_I := 1 to Lc_Linha do
      begin
         StrGrd_Vendas.RowCount := Lc_I + 1;
         for Lc_J := 1 to StrGrd_Vendas.ColCount - 1 do
            StrGrd_Vendas.Cells[Lc_J, Lc_I] := Lc_Lista[Lc_I, Lc_J];
      end;
   end;

end;

end.
