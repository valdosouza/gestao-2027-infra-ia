unit Un_Crp_Itens;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, ExtCtrls, Buttons, DB, StdCtrls, Mask, STStoredProc, ComCtrls, Grids, DBGrids, STQuery, QEdit_Setes, Un_Fm_ListaProdutos, ControllerCrpItens;

type
  TFr_Crp_Itens = class(TForm)
    Qr_Crp_Itens: TSTQuery;
    Panel2: TPanel;
    SB_Inserir: TSpeedButton;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    DBG_Produtos: TDBGrid;
    Pnl_Edicao: TPanel;
    LB_Cnpj: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    E_Qtde: TEdit_Setes;
    E_Sequencia: TEdit_Setes;
    E_Vl_Extra: TEdit_Setes;
    Fm_ListaProdutos: TFm_ListaProdutos;
    Ds_Crp_Itens: TDataSource;
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_InserirClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Fm_ListaProdutosSb_ProdutoClick(Sender: TObject);
  private
    { Private declarations }
    It_Inserir : Boolean;
    It_Alterar : Boolean;
    It_Excluir : Boolean;
    It_Visualizar : Boolean;
    it_Edicao : String;
    Procedure Pc_IniciaVariaveis;
    procedure Pc_AtivarTabelas;
    procedure Pc_ControleEdicao;
    procedure Pc_ImagemBotao;
    procedure Pc_LimpaCampos;
    procedure Pc_PreencherCampos;
    procedure AbreLista;
    function Fc_ValidaGravacao():Boolean;
    Procedure Pc_Grava;
    function Fc_ValidaEdicao():Boolean;
    function fc_ValidaExclusao():Boolean;

  public
    { Public declarations }
    CodigoRegistro : Integer;
    CodigoGrupo : Integer;
    CardapioItens : TControllerCrpItens;
  end;

var
  Fr_Crp_Itens: TFr_Crp_Itens;

implementation

uses     Un_DM, Un_Msg, Un_Principal, env, UN_Sistema, UN_TabelasEmListas, RN_Crud, Un_Pesq_Produto;
{$R *.dfm}

Procedure TFr_Crp_Itens.Pc_IniciaVariaveis;
Begin
  AbreLista;
  it_Edicao := 'B';
  Pc_ControleEdicao;
end;

function TFr_Crp_Itens.Fc_ValidaGravacao():Boolean;
Begin
  REsult := True;
  if StrToIntDef(E_Sequencia.Text,0) = 0 then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Sequencia não informado.'+EOLN+
                   'Preencha a sequencia antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    E_Sequencia.SetFocus;
    exit;
  end;

  if StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0) = 0 then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Código do Produto não informado.'+EOLN+
                   'Preencha o campo antes de continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result:=false;
    Fm_ListaProdutos.E_Cd_Produto.SetFocus;
    exit;
  end;

end;

procedure TFr_Crp_Itens.Fm_ListaProdutosSb_ProdutoClick(Sender: TObject);
begin
  Fm_ListaProdutos.Sb_ProdutoClick(Sender);

end;

Procedure TFr_Crp_Itens.Pc_Grava;
Begin
  with CardapioItens.Registro do
  Begin
    Codigo        := CodigoRegistro;
    Sequencia     := StrToIntDef( E_Sequencia.Text,0);
    CodigoProduto := StrToIntDef( Fm_ListaProdutos.E_Cd_Produto.Text,0);
    Qtde          := StrToFloatDef( E_Qtde.Text , 0);
    Valor         := StrToFloatDef( E_Vl_Extra.Text , 0);
    Grupo         := CodigoGrupo;
  End;
  CardapioItens.salva;
end;

procedure TFr_Crp_Itens.Pc_AtivarTabelas;
begin
  DM_ListaConsultas.Pc_ListaProdutos('P');
end;

procedure TFr_Crp_Itens.Pc_ControleEdicao;
Begin
  Pnl_Edicao.Enabled := (it_Edicao ='I') or (it_Edicao ='E');
  SB_Inserir.Enabled := (it_Edicao ='B');
  SB_Alterar.Enabled := (it_Edicao ='B') and (Qr_Crp_Itens.RecordCount > 0);
  SB_Excluir.Enabled := (it_Edicao ='B') and (Qr_Crp_Itens.RecordCount > 0);
  SB_Gravar.Enabled := (it_Edicao ='I') or (it_Edicao ='E');
  SB_Cancelar.Enabled := (it_Edicao ='I') or (it_Edicao ='E');
  Sb_Sair_0.Enabled := (it_Edicao ='B');
end;

procedure TFr_Crp_Itens.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    SB_Inserir.Glyph := (Fc_CarregaImagemBotao('INSERIR'));
    SB_Alterar.Glyph := (Fc_CarregaImagemBotao('ALTERAR'));
    SB_Excluir.Glyph := (Fc_CarregaImagemBotao('EXCLUIR'));
    SB_Gravar.Glyph := (Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancelar.Glyph := (Fc_CarregaImagemBotao('CANCELAR'));
    SB_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
  END;
end;
procedure TFr_Crp_Itens.Pc_LimpaCampos;
BEgin
  E_Sequencia.Clear;
  Fm_ListaProdutos.E_Cd_Produto.Clear;
  Fm_ListaProdutos.E_Busca_Produto.Clear;
  E_Qtde.Clear;
  E_Vl_Extra.Clear;
end;

procedure TFr_Crp_Itens.Pc_PreencherCampos;
BEgin
  with Qr_Crp_Itens,Fm_ListaProdutos do
  Begin
    CodigoRegistro        := FieldByName('CPI_CODIGO').AsInteger;
    E_Sequencia.Text      := FieldByName('CPI_SEQUENCIA').AsString;
    E_Cd_Produto.Text     := FieldByName('CPI_CODPRO').AsString;
    E_Busca_Produto.Text  := FieldByName('PRO_DESCRICAO').AsString;
    E_Qtde.Text           := FieldByName('CPI_QTDE').AsString;
    E_Vl_Extra.Text       := FloatToStrF(FieldByName('CPI_VALOR').AsCurrency,ffNumber,10,2);
  End;
end;

procedure TFr_Crp_Itens.AbreLista;
Begin
  with Qr_Crp_Itens do
  Begin
    active := False;
    ParamByName('CPI_SABOR').AsString   := CardapioItens.Registro.Sabor;
    ParamByName('CPI_TIPO').AsString    := CardapioItens.Registro.Tipo;
    ParamByName('CPI_CODGRP').AsInteger := CodigoGrupo;
    active := true;
  End;
end;
// Procedures Internas

procedure TFr_Crp_Itens.SB_ExcluirClick(Sender: TObject);
begin
  if fc_ValidaExclusao then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Excluir o item '+ Qr_Crp_Itens.FieldByName('PRO_DESCRICAO').AsString +' desta relação.'+EOLN+EOLN+
                       'Confirmar a exclusão ?',
                       [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
    Begin
      with CardapioItens.Registro, Qr_Crp_Itens do
        CodigoProduto := FieldByName('CPI_CODPRO').AsInteger;
      CardapioItens.delete;
      AbreLista;
      it_Edicao := 'B';
      Pc_ControleEdicao;
      Pc_LimpaCampos;
    end;
  end;
end;

procedure TFr_Crp_Itens.SB_InserirClick(Sender: TObject);
begin
  it_Edicao := 'I';
  CodigoRegistro := 0;
  Pc_ControleEdicao;
  Pc_LimpaCampos;
  E_Sequencia.SetFocus;
end;

function TFr_Crp_Itens.fc_ValidaEdicao():Boolean;
Begin
  Result := True;
  if (Qr_Crp_Itens.RecordCount = 0) then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não há registro para editar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    exit;
  end;
end;

function TFr_Crp_Itens.fc_ValidaExclusao():Boolean;
Begin
  Result := True;
  if (Qr_Crp_Itens.RecordCount = 0) then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não há registro para excluir.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    exit;
  end;
end;

procedure TFr_Crp_Itens.SB_AlterarClick(Sender: TObject);
begin
  if fc_ValidaEdicao then
  Begin
    it_Edicao := 'E';
    Pc_ControleEdicao;
    Pc_PreencherCampos;
    E_Sequencia.SetFocus;
  end;
end;

procedure TFr_Crp_Itens.SB_GravarClick(Sender: TObject);
begin
  if Fc_ValidaGravacao then
  Begin
    Pc_Grava;
    it_Edicao := 'B';
    Pc_ControleEdicao;
    Pc_LimpaCampos;
    AbreLista;
  end;
end;

procedure TFr_Crp_Itens.FormCreate(Sender: TObject);
begin
  CardapioItens := TControllerCrpItens.Create(Self);
end;

procedure TFr_Crp_Itens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
      case Key of
      VK_F2  : if SB_Inserir.Enabled then SB_InserirClick(Sender);
      VK_F3  : if SB_Alterar.Enabled then SB_AlterarClick(Sender);
      VK_F4  : if SB_Excluir.Enabled then SB_ExcluirClick(Sender);
      VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
      VK_F6  : if SB_Cancelar.Enabled then SB_CancelarClick(Sender);
      VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
    end;
end;

procedure TFr_Crp_Itens.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Crp_Itens.Sb_Sair_0Click(Sender: TObject);
begin
  close;
end;

procedure TFr_Crp_Itens.FormShow(Sender: TObject);
begin
  Pc_AtivarTabelas;
  Pc_ImagemBotao;
  Pc_IniciaVariaveis;
end;

procedure TFr_Crp_Itens.SB_CancelarClick(Sender: TObject);
begin
  it_Edicao := 'B';
  Pc_ControleEdicao;
  Pc_LimpaCampos;
end;

end.





