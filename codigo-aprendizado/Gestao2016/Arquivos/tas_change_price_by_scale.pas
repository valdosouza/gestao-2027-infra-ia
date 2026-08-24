unit tas_change_price_by_scale;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, ControllerTabelaPreco, Datasnap.Provider, Vcl.ExtCtrls, Vcl.Buttons;

type
  TTasChangePriceByScale = class(TFr_Base)
    DBG_Tabela: TDBGrid;
    Cds_Pesquisa: TClientDataSet;
    Ds_Pesquisa: TDataSource;
    Cds_PesquisaTPR_CODIGO: TIntegerField;
    Cds_PesquisaTPR_NOME: TWideStringField;
    Cds_PesquisaTPR_MODALIDADE: TWideStringField;
    Panel1: TPanel;
    Cds_PesquisaTPR_MAR_VIA_ESCALA: TBCDField;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    Cds_PesquisaTPR_MAR_LRC: TFloatField;
    procedure SB_Sair_0DblClick(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure DBG_TabelaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    FProduto: Integer;
    FValorCusto: Real;
    procedure setFProduto(const Value: Integer);
    procedure FillListPriceList;
    function Valida:Boolean;
    procedure Execute;
    procedure setFValorCusto(const Value: Real);
    function  RetIdxUltimaColVisivel(DBGrid: TDBGrid): integer;
    function NaoInsereDBGrid(DBGrid: TDBGrid; DataSet: TDataSet; Key: Word): Word;
  protected
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure setPerfil;Override;
    procedure FormataTela;Override;
    procedure AtivaTabelas;Override;
  public
    { Public declarations }
    Tabela : TControllerTabelaPreco;
    Property Produto : Integer read FProduto write setFProduto;
    property ValorCusto : Real read FValorCusto write setFValorCusto;
  end;

var
  TasChangePriceByScale: TTasChangePriceByScale;

implementation

{$R *.dfm}

uses     Un_Msg, Un_DM, env;

{ TTasChangePriceByScale }

function  TTasChangePriceByScale.RetIdxUltimaColVisivel(DBGrid: TDBGrid): integer;
var
  x: integer;
begin
  Result := -1;
  for x := DBGrid.Columns.Count-1 downto 0 do
  begin
    if  DBGrid.Columns.Items[x].Visible then
    begin
      Result := x;
      Break;
    end;
  end;
end;

function  TTasChangePriceByScale.NaoInsereDBGrid(DBGrid: TDBGrid; DataSet: TDataSet; Key: Word): Word;
begin
  { Não deixa inserir registros no DBGrid caso:
    1- estiver em modo de edição: E
    1.1- se clicar na tecla "Insert"; OU
    1.2- se clicar na tecla "Seta para baixo" E estiver no �ltimo registro; OU
    1.2- se clicar na tecla "Tab" E estiver no �ltimo registro E estiver na
         última coluna vis�vel. }
  Result := Key;

  if  dgEditing in DBGrid.Options then
  begin
    if  ( Key = VK_INSERT )or
        ( (Key = VK_DOWN) and (DataSet.RecNo = DataSet.RecordCount) ) then
          Result := 0
        else
          if  ( Key = VK_TAB ) and ( DataSet.RecNo = DataSet.RecordCount ) then
          begin
            if  ( DBGrid.SelectedIndex = RetIdxUltimaColVisivel(DBGrid) ) then
                Result := 0;
          end;
  end;
end;

procedure TTasChangePriceByScale.AtivaTabelas;
begin
  inherited;

end;

procedure TTasChangePriceByScale.CriarVariaveis;
begin
  inherited;
  Tabela := TControllerTabelaPreco.create(Self);
end;

procedure TTasChangePriceByScale.DBG_TabelaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  { Não permite excluir }
  if  Key = VK_DELETE then Key := VK_NONAME;
  { Não permite incluir }
  Key := NaoInsereDBGrid( TDBGrid(Sender), TDBGrid(Sender).DataSource.DataSet, Key );
end;

procedure TTasChangePriceByScale.Execute;
Var
  LcMrVista: Real;
begin
  Cds_Pesquisa.First;
  LcMrVista := Cds_PesquisaTPR_MAR_LRC.AsFloat;
  while not Cds_Pesquisa.Eof do
  Begin
    Tabela.Preco.Registro.CodigoTabela := Cds_PesquisaTPR_CODIGO.AsInteger;
    Tabela.Preco.Registro.CodigoProduto := FProduto;
    Tabela.Preco.getByTabelaProduto;
    Tabela.Preco.Registro.MargemLucro := LcMrVista + Cds_PesquisaTPR_MAR_VIA_ESCALA.AsFloat;
    Tabela.Preco.Registro.Valor :=  Tabela.Preco.CalcularPrecoPelaMargemLucro(FValorCusto,Tabela.Preco.Registro.MargemLucro);
    Tabela.Preco.salva;
    Cds_Pesquisa.Next;
  End;
end;

procedure TTasChangePriceByScale.FillListPriceList;
Var
  I : Integer;
begin
  Tabela.getListByScale;
  if not cds_Pesquisa.active then cds_Pesquisa.CreateDataSet;
  cds_Pesquisa.LogChanges := False;
  cds_Pesquisa.EmptyDataSet;

  for I := 0 to Tabela.Lista.Count -1 do
  Begin
    cds_Pesquisa.Append;
    Cds_PesquisaTPR_CODIGO.AsInteger        := Tabela.Lista[I].Codigo;
    Cds_PesquisaTPR_NOME.AsString           := Tabela.Lista[I].Descricao;
    Cds_PesquisaTPR_MODALIDADE.AsString     := Tabela.Lista[I].Modalidade;
    Cds_PesquisaTPR_MAR_VIA_ESCALA.AsFloat  := Tabela.Lista[I].MargemViaEscala;
    Cds_PesquisaTPR_MAR_LRC.AsFloat         := Tabela.Lista[I].MargemLucro;
    Cds_Pesquisa.Post;
  End;
  Cds_Pesquisa.LogChanges := True;
  Cds_Pesquisa.First;
end;

procedure TTasChangePriceByScale.FormataTela;
begin
  inherited;

end;

procedure TTasChangePriceByScale.ImagemBotao;
begin
  CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
  CarregaImagemBotao(SB_Sair_0,'SAIR');
end;

procedure TTasChangePriceByScale.IniciaVariaveis;
begin
  inherited;
  FillListPriceList;
  Caption := Concat('Alterar Preço por Escala - Margem Inicial : ', FloatToStrF(Cds_PesquisaTPR_MAR_LRC.AsFloat,ffFixed, 10,2),'%');
end;

procedure TTasChangePriceByScale.SB_ConfirmarClick(Sender: TObject);
begin
  if Valida then
  Begin
    Execute;
  End;

end;

procedure TTasChangePriceByScale.SB_Sair_0Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TTasChangePriceByScale.SB_Sair_0DblClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TTasChangePriceByScale.setFProduto(const Value: Integer);
begin
  FProduto := Value;
end;

procedure TTasChangePriceByScale.setFValorCusto(const Value: Real);
begin
  FValorCusto := Value;
end;

procedure TTasChangePriceByScale.setPerfil;
begin
  inherited;

end;

function TTasChangePriceByScale.Valida: Boolean;
Var
  LcAchou : Boolean;
begin
  Result := True;
  Cds_Pesquisa.First;
  LcAchou := False;
  while not Cds_Pesquisa.Eof do
  Begin
    if Cds_PesquisaTPR_MODALIDADE.AsString = 'V' then
    Begin
      LcAchou := True;
      break;
    End;
    Cds_Pesquisa.Next;
  End;
  if not LcAchou then
  BEgin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Não foi encontrada uma Tabela com a Modalidade � Vista.'+EOLN+
                   'Verifique antes de Continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    result:=False;
    exit;
  End;

  Cds_Pesquisa.First;
  LcAchou := False;
  while not Cds_Pesquisa.Eof do
  Begin
    if (Cds_PesquisaTPR_MAR_VIA_ESCALA.AsFloat = 0) and (Cds_PesquisaTPR_MODALIDADE.AsString <> 'V') then
    Begin
      LcAchou := True;
      break;
    End;
    Cds_Pesquisa.Next;
  End;

  if LcAchou then
  BEgin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Foi encontrada uma Margem Zerada.'+EOLN+
                   'Verifique antes de Continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    result:=False;
    exit;
  End;
end;

end.
