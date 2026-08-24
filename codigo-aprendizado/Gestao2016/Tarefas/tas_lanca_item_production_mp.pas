unit tas_lanca_item_production_mp;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, QEdit_Setes, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, ControllerProductionForeCast, Data.DB, Datasnap.DBClient, tas_lanca_item_produto;

type
  TTasLancaItemProductionMP = class(TTasLancaItemProdutos)
    Label10: TLabel;
    E_Cons_Unitario: TEdit_Setes;
  private
    { Private declarations }
  protected
    procedure MostraBusca;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;

    procedure ShowData;Override;
    procedure ShowNoData;Override;

    function ValidaGravacao:Boolean;Override;
    procedure Gravar;Override;

  public
    { Public declarations }
    Item : TControllerProductionForeCast;
  end;

var
  TasLancaItemProductionMP: TTasLancaItemProductionMP;

implementation

uses     Un_Msg, env;
{$R *.dfm}

{ TTasLancaItemProductionMP }

procedure TTasLancaItemProductionMP.CriarVariaveis;
begin
  inherited;
  Item := TControllerProductionForeCast.create(nil);
end;

procedure TTasLancaItemProductionMP.Gravar;
begin
  with item do
  BEgin
    Registro.Produto := StrToIntDef(E_Cd_Produto.Text,0);
    Registro.QtdeUnitario := StrToFloatDef(E_Cons_Unitario.Text,1);
  End;
  Item.salva;
  Confirma := True;
  Close;
end;

procedure TTasLancaItemProductionMP.IniciaVariaveis;
begin
  if CodigoRegistro > 0 then
  Begin
    Item.Registro.Codigo := CodigoRegistro;
    Item.getbyId;
    //Produto
    if Item.exist then
    Begin
      Produto.Registro.Codigo := item.Registro.Produto;
      Produto.getbyId;
    End;
  End;
  inherited;
end;

procedure TTasLancaItemProductionMP.MostraBusca;
begin
  inherited;
  E_Cons_Unitario.SetFocus;
end;

procedure TTasLancaItemProductionMP.ShowData;
begin
  E_Cd_Produto.Text := Item.Registro.Produto.ToString;
  E_Produto.Text := Produto.Registro.Descricao;
  E_Cons_Unitario.Text  := FloatToStrF(Item.Registro.QtdeUnitario,ffFixed,10,2);
  inherited;
end;


procedure TTasLancaItemProductionMP.ShowNoData;
begin
  ClearFields(Self);
end;

function TTasLancaItemProductionMP.ValidaGravacao: Boolean;
begin
  REsult := True;
  if not ValidaProduto then
  Begin
    Result := False;
    exit;
  End;

  if StrToFloatDef(E_Cons_Unitario.Text,0) = 0 then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Favor Preencher o campo consumo unitário.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    E_Cons_Unitario.SetFocus;
    Result := False;
    exit;
  End;
end;

end.
