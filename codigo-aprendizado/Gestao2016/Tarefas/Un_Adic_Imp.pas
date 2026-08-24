unit Un_Adic_Imp;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, DB, StdCtrls, Mask, DBCtrls, ComCtrls, Buttons, Grids, DBGrids, STQuery, STDataSet, ControllerAdicaoImportacao, Un_Fm_ListaEmpresas, Un_Fm_ListaFornecedores;

type
  TFr_Adic_Imp = class(TForm)
    Pnl_Fundos: TPanel;
    Label1: TLabel;
    E_Codigo: TEdit;
    Label3: TLabel;
    E_Numero: TEdit;
    pnl_botoes: TPanel;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Label6: TLabel;
    E_Vl_Desconto: TEdit;
    Label8: TLabel;
    E_Nr_Pedido: TEdit;
    Label9: TLabel;
    E_Item_Cpa: TEdit;
    Label2: TLabel;
    E_Sequencia: TEdit;
    Fm_ListaFornecedores: TFm_ListaFornecedores;
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure E_NumeroKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Procedure Pc_AtivarTabelas;
    Procedure Pc_FormataTela;
    Procedure Pc_IniciaVariavel;
    Procedure Pc_ImagemBotao;
    procedure ShowData;
    procedure ShowNoData;
    Function ValidaGravacao():Boolean;
    procedure Gravar;
  public
    { Public declarations }
    Adicao : TControllerAdicaoImportacao;
    It_Cd_Adicao : Integer;
    It_Cd_DIM : Integer;
  end;

var
  Fr_Adic_Imp: TFr_Adic_Imp;

implementation

uses     Un_DM, UN_Sistema, Un_Regra_Negocio, UN_MSG, un_Padrao, UN_Principal, env, Un_Fornecedor, RN_Fornecedor;

{$R *.dfm}

Procedure TFr_Adic_Imp.Pc_AtivarTabelas;
Begin
  Fm_ListaFornecedores.ListaFornecedores('EMP_NOME');
end;

Procedure TFr_Adic_Imp.Pc_FormataTela;
Begin
  E_Numero.MaxLength := 3;
  E_Sequencia.MaxLength := 3;
end;

Procedure TFr_Adic_Imp.Pc_IniciaVariavel;
Begin
  Adicao.Registro.Codigo := It_Cd_Adicao;
  Adicao.getbyId;
  if Adicao.exist then
    ShowData
  else
    ShowNoData;
end;

Function TFr_Adic_Imp.ValidaGravacao():Boolean;
Begin
  Result := true;
  if trim(E_Numero.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O preenchimento do campo número é obrigatório.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_Numero.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_Sequencia.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O preenchimento do campo sequência é obrigatório.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_Sequencia.SetFocus;
    Result := False;
    exit;
  end;

  if trim(Fm_ListaFornecedores.DBLCB_Empresa.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O preenchimento do campo do fabricante é obrigatório.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Fm_ListaFornecedores.DBLCB_Empresa.SetFocus;
    Result := False;
    exit;
  end;
  //Campos não preenchidos
  if StrToFloatdef(e_vl_Desconto.Text,0) = 0 then
  begin
    e_vl_Desconto.Text := '0,00';
  end;
  if trim(e_Nr_Pedido.Text) = '' then
  begin
    e_Nr_Pedido.Text := '0';
  end;
  if trim(E_Item_Cpa.Text) = '' then
  begin
    E_Item_Cpa.Text := '0';
  end;


end;


Procedure TFr_Adic_Imp.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    END;
end;


procedure TFr_Adic_Imp.SB_GravarClick(Sender: TObject);
begin
  if ValidaGravacao then
  begin
    Gravar;
    Close;
  end;
end;

procedure TFr_Adic_Imp.ShowData;
begin
  With Adicao do
  Begin
    E_Codigo.Text             := Registro.Codigo.ToString();
    E_Numero.Text             := Registro.Numero;
    E_Sequencia.Text          := Registro.Sequencia;
    Fm_ListaFornecedores.DBLCB_Empresa.KeyValue := StrToIntDef(Registro.CodigoFabricante,0);
    E_Vl_Desconto.Text        := FloatToStrf(Registro.ValorDesconto,ffFixed,10,2);
    E_Nr_Pedido.Text          := Registro.CodigoCompra;
    E_Item_Cpa.Text           := Registro.CodigoItemCompra;
  End;
end;

procedure TFr_Adic_Imp.ShowNoData;
begin
  E_Codigo.clear;
  E_Numero.clear;
  E_Sequencia.clear;
  Fm_ListaFornecedores.DBLCB_Empresa.KeyValue := null;
  E_Vl_Desconto.clear;
  E_Nr_Pedido.clear;
  E_Item_Cpa.clear;
end;

procedure TFr_Adic_Imp.SB_CancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Adic_Imp.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_AtivarTabelas;
  Pc_IniciaVariavel;
  Pc_ImagemBotao;
end;

procedure TFr_Adic_Imp.Gravar;
begin
  With Adicao do
  Begin
    Registro.CodigoImportacao := It_Cd_DIM;
    Registro.Numero           := E_Numero.Text;
    Registro.Sequencia        := E_Sequencia.Text;
    Registro.CodigoFabricante := Fm_ListaFornecedores.DBLCB_Empresa.KeyValue;
    Registro.ValorDesconto    := StrToFloatdef(E_Vl_Desconto.Text,0);
    Registro.CodigoCompra     := E_Nr_Pedido.Text;
    Registro.CodigoItemCompra := E_Item_Cpa.Text;
  End;
  Adicao.salva
end;

procedure TFr_Adic_Imp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil( Adicao );
end;

procedure TFr_Adic_Imp.FormCreate(Sender: TObject);
begin
  Adicao := TControllerAdicaoImportacao.Create(Self);
end;

procedure TFr_Adic_Imp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = []) then
    begin
    case Key of
      VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
      VK_F6  : if SB_Cancelar.Enabled then SB_CancelarClick(Sender);
      end;
    end;
end;

procedure TFr_Adic_Imp.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Adic_Imp.E_NumeroKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in['0'..'9',Chr(8),',']) then Key:= #0;
end;

end.
