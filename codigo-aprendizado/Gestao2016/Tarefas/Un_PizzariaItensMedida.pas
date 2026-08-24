unit Un_PizzariaItensMedida;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Grids, ExtCtrls, Buttons, DB, STQuery, ControllerDskRestMenu, StdCtrls, ComCtrls, Mask, QEdit_Setes, Vcl.Menus, ControllerBotao, ControllerProduto;

type
  TFr_PizzariaItensMedida = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    StrGrd_Medidas: TStringGrid;
    Qr_Medidas: TSTQuery;
    SB_Sair_0: TSpeedButton;
    SB_Confirmar: TSpeedButton;
    UpDown1: TUpDown;
    e_Quantidade: TEdit_Setes;
    Label1: TLabel;
    Qr_Preco: TSTQuery;
    PopupMenu: TPopupMenu;
    Desativar1: TMenuItem;
    PausarVenda1: TMenuItem;
    HabilitarVenda1: TMenuItem;
    procedure StrGrd_MedidasDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure StrGrd_MedidasClick(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Desativar1Click(Sender: TObject);
    procedure PausarVenda1Click(Sender: TObject);
    procedure HabilitarVenda1Click(Sender: TObject);
  private
    { Private declarations }
    procedure Pc_ImagemBotao;
    function ValidaDesativaProduto:Boolean;
    procedure DesativaProduto;
    procedure PausarHabilitarItemByCodigo(Pausa:Boolean;Produto:Integer);
    function VerificaProdutoPausadoByCodigo(Produto:Integer):Boolean;

  public
    { Public declarations }
    It_Confirma : Boolean;
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
  end;

var
  Fr_PizzariaItensMedida: TFr_PizzariaItensMedida;

implementation

uses     Un_DM, Un_Regra_Negocio, UN_MSG, UN_Principal, env;
{$R *.dfm}

procedure TFr_PizzariaItensMedida.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Geral;
    CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
    CarregaImagemBotao(Sb_Sair_0,'SAIR');
  END;
end;

procedure TFr_PizzariaItensMedida.PausarHabilitarItemByCodigo(Pausa:Boolean;Produto:Integer);
Var
  Lc_DskRestMenu : TControllerDskRestMenu;
begin
  try
    Lc_DskRestMenu := TControllerDskRestMenu.Create(nil);
    if Pausa then
      Lc_DskRestMenu.PausarHabilitarItemByCodigo('S',Produto)
    else
      Lc_DskRestMenu.PausarHabilitarItemByCodigo('N',Produto);
  finally
    FreeAndNil(Lc_DskRestMenu);
  end;
end;

procedure TFr_PizzariaItensMedida.PausarVenda1Click(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja relamente Pausar a Venda deste Item?.' + EOLN +
                     'Confirmar a Operação ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
  Begin
    PausarHabilitarItemByCodigo(True,StrToIntDef(StrGrd_Medidas.Cells[4,StrGrd_Medidas.Row],0));
    StrGrd_Medidas.Cells[6,StrGrd_Medidas.Row] := 'S';
    StrGrd_Medidas.Repaint;
  End;
end;

Procedure TFr_PizzariaItensMedida.Pc_FormataTela;
Begin
  //Grade das devoluções
  with StrGrd_Medidas do
  Begin
    ColCount := 7;
    ColWidths[0]  := -1;
    ColWidths[1]  := 200;
    ColWidths[2]  := 100;
    ColWidths[3]  := 100;
    ColWidths[4]  := -1;
    ColWidths[5]  := -1;
    ColWidths[6]  := -1;
    Cols[0].Add('');
    Cols[1].Add('Medidas');
    Cols[2].Add('Preço');
    Cols[3].Add('Disponível');
    Cols[4].Add('PRO_CODIGO');
    Cols[5].Add('PRO_CODSBG');
    Cols[6].Add('PRO_FORA_LINHA');
  end;
end;

Procedure TFr_PizzariaItensMedida.Pc_IniciaVariaveis;
Var
  Lc_I : Integer;
BEgin
  with Qr_Medidas,StrGrd_Medidas do
  Begin
    Active := FAlse;
    ParamByName('BTN_CODIGO').AsInteger := It_Cd_Botao;
    Active := True;
    FetchAll;
    first;
    Caption := FieldByName('PRO_DESCRICAO').AsString;
    Pc_LimpaStringGrid(StrGrd_Medidas);
    Lc_I := 1;
    while not eof do
    Begin
      RowCount := Lc_I + 1;
      Cells[0,Lc_I] := FieldByName('MED_CODIGO').AsString;
      Cells[1,Lc_I] := FieldByName('MED_DESCRICAO').AsString;
      //if FieldByName('PRO_CAMPANHA').AsString = 'N' then
      if FieldByName('PRO_VL_PROMOCAO').AsCurrency = 0 then     
        Cells[2,Lc_I] := FloatToStrF(FieldByName('PRO_VL_NORMAL').AsCurrency,ffFixed,10,2)
      else
        Cells[2,Lc_I] := FloatToStrF(FieldByName('PRO_VL_PROMOCAO').AsCurrency,ffFixed,10,2);
      Cells[3,Lc_I] := FieldByName('EST_QTDE').AsString;
      Cells[4,Lc_I] := FieldByName('PRO_CODIGO').AsString;
      Cells[5,Lc_I] := FieldByName('PRO_CODSBG').AsString;
      Cells[6,Lc_I] := FieldByName('PRO_FORA_LINHA').AsString;
      Inc(Lc_I);
      next;
    end;
  end;
end;

procedure TFr_PizzariaItensMedida.StrGrd_MedidasDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  with StrGrd_Medidas do
  Begin
    If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
    Begin
      if (Cells[6,ARow] = 'N') then
      Begin
        if (Cells[7,ARow] = '') then
        Begin
          Canvas.Font.Color:= clBlack;
          canvas.Brush.Color:= clCream;
        end
        else
        Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clMoneyGreen;
        end;
      End
      else
      Begin
        if (Cells[7,ARow] = '') then
        Begin
          Canvas.Font.Color:= clRed;
          canvas.Brush.Color:= clCream;
        end
        else
        Begin
          Canvas.Font.Color:= clRed;
          Canvas.Brush.Color:= clMoneyGreen;
        end;


      End;
      Canvas.FillRect(Rect); // redesenha a celula
      Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.
      // Pega o texto da célula
      Texto := Cells[acol, ARow];

      //{ Calcura largura e altura (em pontos) do texto
      LarguraTexto := Canvas.TextWidth(Texto);
      AlturaTexto := Canvas.TextHeight(Texto);

      // Calcula a posição horizontal do início do texto
      if  (ACol = 1)  then // esquerda
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

function TFr_PizzariaItensMedida.ValidaDesativaProduto: Boolean;
begin
  Result := True;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Tem certeza que deseja desativar este item do cardápio.' + EOLN + EOLN +
                      'Confirmar a operação ?',
                      [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
  Begin
    Result := False;
    Exit;
  End;

  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Ao desativar este produto, só poderá ativa-lo pela tela do Cardápio.' + EOLN + EOLN +
                      'Confirmar novamente a operação ?',
                      [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBlue) = mrBotao2) then
  Begin
    Result := False;
    Exit;
  End;

end;

function TFr_PizzariaItensMedida.VerificaProdutoPausadoByCodigo(Produto: Integer): Boolean;
Var
  Lc_DskRestMenu : TControllerDskRestMenu;
begin
  try
    Lc_DskRestMenu := TControllerDskRestMenu.Create(nil);
    Result := Lc_DskRestMenu.VerificaProdutoPausadoByCodigo(Produto);
  finally
    FreeAndNil(Lc_DskRestMenu);
  end;
end;

procedure TFr_PizzariaItensMedida.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_ImagemBotao;
  Pc_IniciaVariaveis;
end;

procedure TFr_PizzariaItensMedida.HabilitarVenda1Click(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja relamente Habilitar a Venda deste Item?.' + EOLN +
                     'Confirmar a Operação ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao1) then
  Begin
    PausarHabilitarItemByCodigo(False,StrToIntDef(StrGrd_Medidas.Cells[4,StrGrd_Medidas.Row],0));
    StrGrd_Medidas.Cells[6,StrGrd_Medidas.Row] := 'N';
    StrGrd_Medidas.Repaint;
  End;
end;

procedure TFr_PizzariaItensMedida.StrGrd_MedidasClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  with StrGrd_Medidas do
  Begin
    for Lc_I := 1 to RowCount - 1 do
      Cells[7,Lc_I] := '';
    Cells[7,Row] := 'X';
    Repaint;
  end;
end;

procedure TFr_PizzariaItensMedida.SB_Sair_0Click(Sender: TObject);
begin
  It_Confirma := False;
  Close;
end;

function TFr_PizzariaItensMedida.Fc_VerificaMarcado(Fc_grid:TStringGrid):Boolean;
Var
  Lc_I : Integer;
Begin
  with Fc_grid do
  Begin
    Result := False;
    For Lc_I := 1 to RowCount - 1 do
    Begin
      if Cells[7,Lc_I] = 'X' then
      Begin
        Result := true;
        break;
      end;
    end;
 end;
  if not Result then
    Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Nenhum registro foi selecionado.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    end;
end;


procedure TFr_PizzariaItensMedida.DesativaProduto;
Var
  LcBotao : TControllerBotao;
  LcPRoduto : TControllerProduto;
  Lc_Produto : Integer;
begin
  Try
    LcBotao := TControllerBotao.Create(nil);
    LcPRoduto := TControllerProduto.Create(nil);
    //Desvincular produto do botão
    Lc_Produto  := StrToIntDef(StrGrd_Medidas.Cells[4, StrGrd_Medidas.row],0);
    LcBotao.DeleteitemProduto(It_Cd_Botao,Lc_Produto);
    //Desativar botão
    LcPRoduto.Registro.Codigo := Lc_Produto;
    LcPRoduto.Registro.Ativo := 'N';
    LcPRoduto.Ativa;
  Finally
    FreeAndNil(LcBotao);
    FreeAndNil(LcPRoduto);
  End;
end;

procedure TFr_PizzariaItensMedida.Desativar1Click(Sender: TObject);
begin
  if ValidaDesativaProduto then
  Begin
    DesativaProduto;
    Pc_IniciaVariaveis;
  End;
end;

function TFr_PizzariaItensMedida.Fc_ValidaInclusao():Boolean;
Begin
  REsult := True;
  if VerificaProdutoPausadoByCodigo(StrToIntDef(StrGrd_Medidas.Cells[4,StrGrd_Medidas.row],0)) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Este Produto está pausado para vendas.' + EOLN +
                   'Não é possível continuar.'+ EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  End;

  if not Fc_VerificaMarcado(StrGrd_Medidas) then
  Begin
    Result := False;
    exit;
  end;

  if StrToFloatDef(StrGrd_Medidas.Cells[2,StrGrd_Medidas.row],0) = 0 then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Produto com o Preço Zerado.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

  if StrToIntDef(e_Quantidade.Text,0) = 0 then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Por favor informe a quantidade.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    e_Quantidade.SetFocus;
    Result := False;
    exit;
  end;

end;


procedure TFr_PizzariaItensMedida.SB_ConfirmarClick(Sender: TObject);
Var
  Lc_I:Integer;
begin
  If Fc_ValidaInclusao then
  Begin
    with StrGrd_Medidas do
    Begin
      for Lc_I := 1 to RowCount - 1 do
      Begin
        if (Cells[7,Lc_I]  = 'X') then
        Begin
          It_Cd_Produto := StrToInt(StrGrd_Medidas.Cells[4,Lc_I]);
          It_Ds_Produto := Caption;
          It_Ds_Medida := StrGrd_Medidas.Cells[1,Lc_I];
          It_Cd_SubGrupo := StrToInt(StrGrd_Medidas.Cells[5,Lc_I]);
          It_qtde := StrToFloatDef(e_Quantidade.Text,1);
          It_VL_Unit := StrToFloatDef(StrGrd_Medidas.Cells[2,Lc_I],0);
          It_Confirma := true;
        end;
      end;
    end;
    close;
  end;
end;

procedure TFr_PizzariaItensMedida.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (shift = []) then
  begin
    case Key of
    VK_F10  : SB_ConfirmarClick(Sender);
    VK_Escape : Sb_Sair_0Click(Sender);
    end
  END;
end;

end.
