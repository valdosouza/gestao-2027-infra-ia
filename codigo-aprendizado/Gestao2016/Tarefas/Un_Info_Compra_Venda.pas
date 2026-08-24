unit Un_Info_Compra_Venda;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, QEdit_Setes;

type
  TFr_Info_Compra_Venda = class(TForm)
    Pnl_Fundo: TPanel;
    Btn_Ok_5: TButton;
    Btn_Cn_5: TButton;
    chbx_Todos: TCheckBox;
    Label1: TLabel;
    E_Nr_Pedido: TEdit;
    Label2: TLabel;
    E_Nr_Item_Pedido: TEdit;
    procedure Btn_Ok_5Click(Sender: TObject);
    procedure Btn_Cn_5Click(Sender: TObject);
    procedure E_Nr_Item_PedidoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Cd_Pedido : Integer;
    It_Cd_Item : Integer;
    procedure Pc_AtualizarItensPedido;
    function Fc_ValidaGravacao():Boolean;
  end;

var
  Fr_Info_Compra_Venda: TFr_Info_Compra_Venda;

implementation

uses     Un_DM, UN_MSG, env;
{$R *.dfm}

function TFr_Info_Compra_Venda.Fc_ValidaGravacao():Boolean;
Begin
  Result := True;
  exit;//pode deixar em branco caso queira retirar o numero
  if (Trim(E_Nr_Pedido.Text) = '') then
    Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por favor informe o Número da Compra.'+EOLN+
                   'Verifique e tente novamente.' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    end;
end;

procedure TFr_Info_Compra_Venda.Pc_AtualizarItensPedido;
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(Self);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;

    if chbx_Todos.Checked then
      Begin
      SQL.Add('UPDATE TB_ITENS_NFL SET '+
              'ITF_COMPRA=:ITF_COMPRA '+
              'WHERE ITF_CODPED=:ITF_CODPED ');
      ParamByName('ITF_COMPRA').AsString := E_Nr_Pedido.Text;
      ParamByName('ITF_CODPED').AsInteger := It_Cd_Pedido;
      end
    else
      Begin
      SQL.Add('UPDATE TB_ITENS_NFL SET '+
              'ITF_COMPRA=:ITF_COMPRA, '+
              'ITF_ITEM_COMPRA =:ITF_ITEM_COMPRA '+
              'WHERE ITF_CODIGO=:ITF_CODIGO');
      ParamByName('ITF_COMPRA').AsString := E_Nr_Pedido.Text;
      ParamByName('ITF_ITEM_COMPRA').AsString := E_Nr_Item_Pedido.Text;
      ParamByName('ITF_CODIGO').AsInteger := It_Cd_Item;
      end;
    ExecSQL;
    if Transaction.InTransaction then Transaction.CommitRetaining;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

procedure TFr_Info_Compra_Venda.Btn_Ok_5Click(Sender: TObject);
begin
  if Fc_ValidaGravacao then
  Begin
    Pc_AtualizarItensPedido;
    close;
  end;
end;

procedure TFr_Info_Compra_Venda.Btn_Cn_5Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Info_Compra_Venda.E_Nr_Item_PedidoChange(Sender: TObject);
begin
  if (Trim(E_Nr_Item_Pedido.Text) <>'') then
    Begin
    chbx_Todos.Checked := False;
    chbx_Todos.Enabled := False;
    end
  else
    chbx_Todos.Enabled := True;
end;

end.
