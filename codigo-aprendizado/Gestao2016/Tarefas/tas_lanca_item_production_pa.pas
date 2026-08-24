unit tas_lanca_item_production_pa;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, QEdit_Setes, ControllerProductionRealized, tas_lanca_item_produto;

type
  TTasLancaItemProductionPA = class(TTasLancaItemProdutos)
    Label10: TLabel;
    E_Qtde_Produzida: TEdit_Setes;
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
        Item : TControllerProductionRealized;
  end;

var
  TasLancaItemProductionPA: TTasLancaItemProductionPA;

implementation

uses     Un_Msg, env;
{$R *.dfm}

{ TTasLancaItemProductionPA }

procedure TTasLancaItemProductionPA.CriarVariaveis;
begin
  inherited;
  Item := TControllerProductionRealized.create(nil);
end;

procedure TTasLancaItemProductionPA.Gravar;
begin
  with item do
  BEgin
    Registro.Produto := StrToIntDef(E_Cd_Produto.Text,0);
    Registro.QtdeProduzida := StrToFloatDef(E_Qtde_Produzida.Text,1);
  End;
  Item.salva;
  Confirma := True;
  Close;
end;

procedure TTasLancaItemProductionPA.IniciaVariaveis;
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

procedure TTasLancaItemProductionPA.MostraBusca;
begin
  inherited;
  E_Qtde_Produzida.SetFocus;
end;

procedure TTasLancaItemProductionPA.ShowData;
begin
  E_Cd_Produto.Text := Item.Registro.Produto.ToString;
  E_Produto.Text := Produto.Registro.Descricao;
  E_Qtde_Produzida.Text  := FloatToStrF(Item.Registro.QtdeProduzida,ffFixed,10,2);
  inherited;
end;

procedure TTasLancaItemProductionPA.ShowNoData;
begin
  ClearFields(Self);
end;

function TTasLancaItemProductionPA.ValidaGravacao: Boolean;
begin
  REsult := True;
  if not ValidaProduto then
  Begin
    Result := False;
    exit;
  End;

  if StrToFloatDef(E_Qtde_Produzida.Text,0) = 0 then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Favor Preencher o quantidade produzida.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    E_Qtde_Produzida.SetFocus;
    Result := False;
    exit;
  End;
end;

end.
