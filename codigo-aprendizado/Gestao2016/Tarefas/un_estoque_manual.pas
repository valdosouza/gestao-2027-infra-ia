unit un_estoque_manual;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.StdCtrls, Vcl.Mask, QEdit_Setes, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls, Data.DB, STQuery, Vcl.DBCtrls, Un_Fm_ListaEstoques, ControllerCtrlEstoque, ControllerEstoque, controllerProduto;

type
  TFr_Estoque_manual = class(TFr_Base)
    Panel3: TPanel;
    Label5: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    SB_Cad_produto: TSpeedButton;
    Label11: TLabel;
    E_Codigo: TEdit;
    E_Codigo_Barras: TEdit;
    E_Cont_Atual: TEdit;
    E_Produto: TEdit;
    SB_Gravar: TBitBtn;
    Sb_Sair_0: TBitBtn;
    Fm_ListaEstoques: TFm_ListaEstoques;
    Label2: TLabel;
    E_Cont_Anterior: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    procedure SB_Cad_produtoClick(Sender: TObject);
    procedure E_CodigoExit(Sender: TObject);
    procedure E_Codigo_BarrasExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SB_GravarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure E_Cont_AtualEnter(Sender: TObject);
    procedure E_VL_CustoEnter(Sender: TObject);
    procedure E_Cont_AtualExit(Sender: TObject);
  private
    { Private declarations }
    barraSetFocus : Boolean;
    function ValidaGravacao:Boolean;
    procedure PegaProdutoByBarra(Fc_Codigo: String);
    procedure LimpaCampos;
    procedure Dados_Estoque;
    procedure ajusta_estoque;
    procedure AtualizaDados;
  protected
    procedure IniciaVariaveis;Override;
  public
    { Public declarations }
    Movimento : TControllerCtrlEstoque;
    //Estoque  :  TControllerEstoque;
    Produto : TcontrollerProduto;
  end;

var
  Fr_Estoque_manual: TFr_Estoque_manual;

implementation

{$R *.dfm}

uses     Un_Pesq_Produto, RN_Produto, Un_Msg, Un_DM, UN_Principal, env, UN_Sistema, RN_Inventario;
procedure TFr_Estoque_manual.PegaProdutoByBarra(Fc_Codigo: String);
var
  Lc_SQL: String;
  Lc_Qry: TSTQuery;
  Lc_Tp_Descricao : String;
begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;

    Active:=False;
    SQL.Clear;
    Lc_SQL := 'SELECT PRO_CODIGO, PRO_DESCRICAO FROM TB_PRODUTO '+
              'WHERE PRO_CODIGOBAR =:PRO_CODIGOBAR' ;
    SQL.Add(Lc_SQL);
    ParamByName('PRO_CODIGOBAR').AsString := Fc_Codigo;
    Active := True;
    FetchAll;

    if RecordCount > 0 then
    begin
      E_Codigo.Text := FieldByName('PRO_CODIGO').AsString;
      E_Produto.Text := FieldByName('PRO_DESCRICAO').AsString;
      E_Cont_Atual.SetFocus;
      E_Cont_Atual.SelectAll;
    end
    else
    begin
      E_Codigo_Barras.SetFocus;
      E_Codigo_Barras.clear;
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Produto não encontrado.'+EOLN,
                     ['OK'],[bEscape],mpAlerta);
    end;
  end;
  Lc_Qry.close;
  FreeandNil(Lc_Qry);
end;




function TFr_Estoque_manual.ValidaGravacao:Boolean;
Begin
  Result := True;
  If Fm_ListaEstoques.Dblcb_Estoque.Text ='' then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'O campo estoque deve ser preenchido.' + EOLN ,
                   ['Ok'], [bEscape], mpAlerta);
    Fm_ListaEstoques.Dblcb_Estoque.SetFocus;
    Result:=False;
    exit;
  end;

  If StrToIntDef(E_Codigo.Text,0) = 0 then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Código produto deve ser informado.' + EOLN ,
                   ['Ok'], [bEscape], mpAlerta);
    E_Codigo.SetFocus;
    Result:=False;
    exit;
  end;

  If (E_Produto.Text = '') then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Produto não informado.' + EOLN ,
                   ['Ok'], [bEscape], mpAlerta);
    E_Codigo.SetFocus;
    Result:=False;
    exit;
  end;

  If ( StrToFloatDef(E_Cont_Anterior.Text,0)) = (StrToFloatDef(E_Cont_Atual.Text,0)) then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'As quantidade anterior e atual não podem ser iguais.' + EOLN ,
                   ['Ok'], [bEscape], mpAlerta);
    E_Cont_Atual.SetFocus;
    Result:=False;
    exit;
  end;

  if not Fc_ValidaDataPedido(Date) then
  Begin
    Result := FAlse;
  end;
  E_Cont_AtualExit(self);
End;

procedure TFr_Estoque_manual.ajusta_estoque;
Var
  LcQteAnt : Real;
  LcQteAtu : Real;
begin
  with Movimento.Registro do
  Begin
    Codigo      := 0;
    Terminal    := Gb_Terminal;
    Vinculo     := 'A';
    Ordem       := 0;
    Item        := 0;
    Estoque     := Fm_ListaEstoques.Dblcb_Estoque.Keyvalue;
    Produto     := StrToIntDEf(E_Codigo.Text,0);

    LcQteAnt    := StrToFloatDef(E_Cont_Anterior.Text,0);
    LcQteAtu    := StrToFloatDef(E_Cont_Atual.Text,0);
    if LcQteAtu > LcQteAnt then
    Begin
      operacao    := 'E';
      Quantidade  := (LcQteAtu - LcQteAnt);
    End
    else
    Begin
      operacao    := 'S';
      Quantidade  := (LcQteAnt - LcQteAtu);
    End;
    Data        := Date;
    Tipo        := 'Avulso';
    UpdateAt    := Now;
  End;
  Movimento.insert;

end;

procedure TFr_Estoque_manual.AtualizaDados;
begin
  //Ativa o produto
  Produto.registro.codigo := StrToIntDef(E_Codigo.Text,0);
  Produto.registro.Ativo := 'S';
  Produto.Ativa;

end;

procedure TFr_Estoque_manual.Dados_Estoque;
begin
  Produto.registro.codigo := StrToIntDef(E_Codigo.Text,0);
  if not GB_ProdCompartilha then
    Produto.Registro.CodigoEstabelecimento := Gb_CodMha
  else
    Produto.Registro.CodigoEstabelecimento := 0;
  Produto.getbyId;
  if not Produto.exist then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Produto não encontrado ou não ' + EOLN +
                   'é compartilhado com o estabelecimento ativo.' + EOLN,
                   ['OK'], [bEscape], mpErro);
  End
  else
  Begin
    Produto.Estoque.SaldoEstoque.Registro.CodigoProduto := StrToIntDef(E_Codigo.Text,0);
    Produto.Estoque.SaldoEstoque.Registro.CodigoEstoque := Fm_ListaEstoques.Dblcb_Estoque.KeyValue;
    Produto.Estoque.SaldoEstoque.getbyId;
    if Produto.Estoque.SaldoEstoque.exist then
      E_Cont_Anterior.Text := FloatToStr(Produto.Estoque.SaldoEstoque.Registro.QtdeDisp)
    else
      E_Cont_Anterior.Text := '0,00';
  End;
end;

procedure TFr_Estoque_manual.E_CodigoExit(Sender: TObject);
Begin
  If E_Codigo.Text <> '' then
  Begin
    E_Produto.Text := Fc_PegaProduto(E_Codigo.Text,'');
    barraSetFocus := False;
    Dados_Estoque;
    E_Cont_Atual.SetFocus;
  End;
end;

procedure TFr_Estoque_manual.E_Codigo_BarrasExit(Sender: TObject);
begin
  If E_Codigo_Barras.Text <> '' then
  Begin
    PegaProdutoByBarra(E_Codigo_Barras.Text);
    barraSetFocus := True;
    Dados_Estoque;
    E_Cont_Atual.SetFocus;
  End;
end;

procedure TFr_Estoque_manual.E_Cont_AtualEnter(Sender: TObject);
begin
  TEdit(Sender).SelectAll;

end;

procedure TFr_Estoque_manual.E_Cont_AtualExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := 0;
  Lc_Valor := StrToFloatDef(E_Cont_Atual.Text, 0);
  if Lc_Valor >= 10000 then Lc_Valor := 1;
  E_Cont_Atual.Text := FloatToStr(Lc_Valor);
end;

procedure TFr_Estoque_manual.E_VL_CustoEnter(Sender: TObject);
begin
  TEdit(Sender).SelectAll;
end;

procedure TFr_Estoque_manual.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  Begin
    case Key of
      VK_F5: if SB_Gravar.Enabled then  SB_GravarClick(Sender);
      VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_Estoque_manual.IniciaVariaveis;
begin
  inherited;
  Movimento := TControllerCtrlEstoque.Create(Self);
  Produto := TcontrollerProduto.Create(Self);
  Fm_ListaEstoques.AtivaLista(Gb_CodMha);
end;


procedure TFr_Estoque_manual.LimpaCampos;
begin
  E_Codigo.Clear;
  E_Codigo_Barras.Clear;
  E_Produto.Clear;
  E_Cont_Anterior.Text  := '0,00';
  E_Cont_Atual.Text     := '0,00';
  Fm_ListaEstoques.AtivaLista(Gb_CodMha);
end;

procedure TFr_Estoque_manual.SB_Cad_produtoClick(Sender: TObject);
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  TRy
    Lc_Form := TFr_Pesq_Produto.Create(Self);
    Lc_Form.Pc_Tabelas_Disponiveis;
    Lc_Form.it_Modalidade_preco := 'A';
    Lc_Form.ShowModal;
    //Depois que Fecha o Relatorio
    if Lc_Form.It_Visualizar then
    Begin
      E_Codigo.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
      E_Codigo_Barras.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGOBAR').AsString;
      E_Produto.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString;
      Dados_Estoque;
      E_Cont_Atual.SetFocus;
    end;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Estoque_manual.SB_GravarClick(Sender: TObject);
begin
  if ValidaGravacao then
  Begin
    ajusta_estoque;
    AtualizaDados;
    LimpaCampos;
    if barraSetFocus then
      E_Codigo_Barras.SetFocus
    else
      E_Codigo.SetFocus;
  End;
end;

procedure TFr_Estoque_manual.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

end.

