unit Un_CopiaPedidoNota;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, Mask, QEdit_Setes, STDatabase, DB, System.Math, ControllerNotaFiscal, ControllerPedido, Un_Fm_ListaEstoques;

type
  TFr_CopiaPedidoNota = class(TForm)
    Pnl_CopiaDoc: TPanel;
    Sb_CopiaDoc: TSpeedButton;
    Sb_Can_CopiaDoc: TSpeedButton;
    Label4: TLabel;
    Rg_TipoMovimentacao: TRadioGroup;
    Rg_TipoDoc: TRadioGroup;
    E_Nr_Doc: TEdit_Setes;
    E_Nr_Pedido: TEdit_Setes;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    E_Tx_Altera_Unit: TEdit_Setes;
    Label2: TLabel;
    Rb_Acrescimo: TRadioButton;
    Rb_Desconto: TRadioButton;
    PNL_bottom: TPanel;
    Fm_ListaEstoques: TFm_ListaEstoques;
    procedure Sb_CopiaDocClick(Sender: TObject);
    procedure Sb_Can_CopiaDocClick(Sender: TObject);
    procedure Rg_TipoDocClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    It_cd_Pedido : Integer;
    It_Tipo_Pedido : Integer;
    It_Confirma :Boolean;
    procedure IniciaVariaveis;
    procedure Pc_FormataTela;
    procedure Pc_ImagemBotao;
    function Fc_ValidaCopia: boolean;

  end;

var
  Fr_CopiaPedidoNota: TFr_CopiaPedidoNota;

implementation

uses     UN_Principal, env, UN_MSG, RN_Pedido, RN_Crud, Un_Funcoes, UN_Sistema;

{$R *.dfm}


procedure TFr_CopiaPedidoNota.Pc_FormataTela;
begin
  Pc_ImagemBotao;
end;

procedure TFr_CopiaPedidoNota.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Painel da Copia
    Sb_CopiaDoc.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    SB_Can_CopiaDoc.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    END;
end;

function TFr_CopiaPedidoNota.Fc_ValidaCopia: boolean;
Var
  Lc_Texto:String;
  Nota : TControllerNotaFiscal;
  Pedido : TControllerPedido;
begin
  Result:= true;
  if TRIM(E_Nr_Doc.Text) ='' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Preencha com o número válido '+EOLN+
                   'para copiar os itens.'+EOLN,
               ['OK'],[bEscape],mpAlerta);
    result:=false;
    E_Nr_Doc.SetFocus;
    exit;
  end;

  Pedido := TControllerPedido.Create(Self);
  Try
    if Rg_TipoDoc.itemindex = 0 then
    Begin
      Lc_Texto := 'Pedido';
      Pedido.Registro.Codigo := 0;
      Pedido.Registro.Numero := StrToIntDef( E_Nr_Doc.Text ,0);
      Pedido.Registro.CodigoEstabelecimento := Gb_CodMha;
      case Rg_TipoMovimentacao.ItemIndex of
        0:Pedido.Registro.Tipo := 2;
        1:Pedido.Registro.Tipo := 1;
        2:Pedido.Registro.Tipo := 3;
      end;
      pedido.getIdByNumero;
      It_cd_Pedido := pedido.Registro.Codigo;
    end
    else
    Begin
      Lc_Texto := 'Nota Fiscal';
      //Valores para pesquisar
      Nota := TControllerNotaFiscal.Create(Self);
      Try
        Nota.Registro.Numero := StrZero(StrToIntDef(E_Nr_Doc.Text,0),6,0);
        Nota.Registro.CodigoEstabelecimento := Gb_CodMha;
        if Rg_TipoMovimentacao.ItemIndex = 0 then
          Nota.Registro.Tipo := 'P'
        else
          Nota.Registro.Tipo := 'T';
        It_cd_Pedido := Nota.getCodigoPedidoByNota;
      Finally
        FreeAndNil(Nota);
      End;

    end;


    if (It_cd_Pedido = 0)  then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     ' Número de ' + Lc_Texto + ' informado não encontrado. ' +EOLN +
                     ' Verifique e tente novamente.'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result:=false;
      exit;
    end;

    if StrToIntDef(E_Nr_Pedido.Text,0) > 0 then
    Begin
      Pedido.Clear;
      Pedido.Registro.Codigo := 0;
      Pedido.Registro.Numero := StrToIntDef( E_Nr_Pedido.Text,0);
      Pedido.Registro.CodigoEstabelecimento := Gb_CodMha;
      case Rg_TipoMovimentacao.ItemIndex of
        0:Pedido.Registro.Tipo := 2;
        1:Pedido.Registro.Tipo := 1;
        2:Pedido.Registro.Tipo := 3;
      end;
      pedido.getIdByNumero;
      if pedido.Registro.Codigo > 0 then
      Begin
        MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                       ' Este numero de pedido está sendo usado. ' +EOLN +
                       ' Verifique e tente novamente.'+EOLN,
                       ['OK'], [bEscape], mpAlerta);
        Result:=false;
      End;
    end;
  Finally
    FreeAndNil(Pedido);
  End;

end;

procedure TFr_CopiaPedidoNota.Sb_CopiaDocClick(Sender: TObject);
Var
  Lc_Altera:String;
  Lc_Tx_Altera : Real;
begin
  if Fc_ValidaCopia then
  Begin
    Lc_Tx_Altera := StrToFloatDef(E_Tx_Altera_Unit.Text,0);
    Lc_Altera := 'N';
    if Lc_Tx_Altera > 0 then
    Begin
      if Rb_Acrescimo.Checked then
        Lc_Altera := 'A'
      else
        Lc_Altera := 'D'
    end;
    if Fm_ListaEstoques.Dblcb_Estoque.Text = '' then
      Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Gb_Estoque;
    It_cd_Pedido := Fc_CopiarPedido(It_cd_Pedido,
                                    StrToIntDef(E_Nr_Pedido.Text,0),
                                    Fm_ListaEstoques.Dblcb_Estoque.KeyValue,
                                    It_Tipo_Pedido,
                                    Lc_Altera,
                                    Lc_Tx_Altera);
    MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                   'Cópia realizada com sucesso'+EOLN+
                   'Verifique a área de pedidos.'+EOLN,
                   ['OK'],[bEscape],mpInformacao);
    Close;
  end;

end;

procedure TFr_CopiaPedidoNota.Sb_Can_CopiaDocClick(Sender: TObject);
begin
  It_Confirma := False;
  Close;
end;

procedure TFr_CopiaPedidoNota.Rg_TipoDocClick(Sender: TObject);
begin
  IF Rg_TipoDoc.ItemIndex = 0 then
  Begin
    Rg_TipoMovimentacao.Items.Clear;
    Rg_TipoMovimentacao.Items.Add('Compra');
    Rg_TipoMovimentacao.Items.Add('Venda');
    Rg_TipoMovimentacao.Items.Add('Ajuste');
    Rg_TipoMovimentacao.ItemIndex := 0;
  end
  else
  Begin
    Rg_TipoMovimentacao.Items.Clear;
    Rg_TipoMovimentacao.Items.Add('Própria');
    Rg_TipoMovimentacao.Items.Add('Terceiro');
    Rg_TipoMovimentacao.ItemIndex := 0;
  end;
end;

procedure TFr_CopiaPedidoNota.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If shIft = [] then
  Begin
    case Key of
      VK_F5  : If Sb_CopiaDoc.Enabled then Sb_Can_CopiaDocClick(Sender);
      VK_F6  : If Sb_Can_CopiaDoc.Enabled then Sb_Can_CopiaDocClick(Sender);
    end;
  end;
end;

procedure TFr_CopiaPedidoNota.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  IniciaVariaveis;

end;

procedure TFr_CopiaPedidoNota.IniciaVariaveis;
begin
  Fm_ListaEstoques.AtivaLista(Gb_CodMha);
  Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Gb_Estoque;
end;

end.

