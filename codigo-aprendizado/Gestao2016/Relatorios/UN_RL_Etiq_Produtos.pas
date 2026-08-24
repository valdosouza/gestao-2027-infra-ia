unit UN_RL_Etiq_Produtos;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, DB, STQuery;

type
  TRL_Etiq_Produtos = class(TForm)
    Qrpt: TQuickRep;
    Qr_Etiqueta: TQRStringsBand;
    Qr_MalaDireta: TSTQuery;
    Qr_MalaDiretaEMP_CODIGO: TIntegerField;
    Qr_MalaDiretaEMP_TIPO: TIntegerField;
    Qr_MalaDiretaEMP_FANTASIA: TStringField;
    Qr_MalaDiretaEMP_NOME: TStringField;
    Qr_MalaDiretaEMP_DT_FUNDA: TDateField;
    Qr_MalaDiretaEMP_DT_CADASTRO: TDateField;
    Qr_MalaDiretaEND_ENDER: TStringField;
    Qr_MalaDiretaEND_CONTATO: TStringField;
    Qr_MalaDiretaEND_BAIRRO: TStringField;
    Qr_MalaDiretaEND_CEP: TStringField;
    Qr_MalaDiretaEND_COMPLEM: TStringField;
    Qr_MalaDiretaCDD_DESCRICAO: TStringField;
    Qr_MalaDiretaUFE_SIGLA: TStringField;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Qr_EtiquetaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Excecao : Boolean;
    It_Nr_Etiquetas : Integer;
    It_I : Integer ;
    It_J : Integer;
    It_Qtde : Integer;
  end;

var
  RL_Etiq_Produtos: TRL_Etiq_Produtos;

implementation

uses     Un_Maladireta, Un_Imp_EtiqProdutos, Un_Funcoes, UN_MSG, UN_Sistema;
{$R *.dfm}


procedure TRL_Etiq_Produtos.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_I : Integer;
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  It_I := 1;
  It_J := 0;
  Qr_Etiqueta.Items.Clear;
  For Lc_I:= 1 to It_Nr_Etiquetas do
    Qr_Etiqueta.Items.Add(IntTostr(Lc_I));


  //Configura Etiqueta
  Qrpt.Page.Length:=Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_PG_ALTURA').AsFloat;
  Qrpt.Page.Width:=Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_PG_LARGURA').AsFloat;

  Qrpt.Page.TopMargin:=Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_SUPERIOR').AsFloat;
  Qrpt.Page.BottomMargin:=Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_INFERIOR').AsFloat;

  Qrpt.Page.ColumnSpace:=Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_DIS_COLUNA').AsFloat;
  Qrpt.Page.Columns:=Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_NR_COLUNA').AsInteger;

  Qrpt.Page.LeftMargin:=Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_ESQUERA').AsFloat;
  Qrpt.Page.RightMargin:=Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_DIREITA').AsFloat;
  Qr_Etiqueta.Size.Height:=Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_ET_ALTURA').AsFloat;
  Qr_Etiqueta.Size.Width:=Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_ET_LARGURA').AsFloat;

{  Lb_Produto.Font.Size:=Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger;
  if Fr_Imp_EtiqProdutos.ChBx_Tipo.Checked then
    Begin
    Lb_Produto.Font.Color := clBlack;
    Lb_Valor.Font.Color := clBlack;
    Lb_Barra.Top := 35;
    end
  else
    Begin
    Lb_Produto.Font.Color := clWhite;
    Lb_Valor.Font.Color := clWhite;
    Lb_Barra.Top := 2;
    end;

  Lb_Valor.Font.Size := Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger + 2;
  Lb_Barra.Font.Size := Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger * 6;

  Qrpt.Font.Name := Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_TYPEFONTE').AsVariant;
  Lb_Produto.Font.Name := Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_TYPEFONTE').AsVariant;
  Lb_Barra.Font.Name := Fr_Imp_EtiqProdutos.Cb_Fonte.Text;
  Lb_BairroCidadeUF.Name := Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_TYPEFONTE').AsVariant;
  Lb_Cep.Font.Name := Fr_Imp_EtiqProdutos.Qr_Etiqueta.FieldByName('CGE_TYPEFONTE').AsVariant;
}


end;

procedure TRL_Etiq_Produtos.Qr_EtiquetaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_I : Real;
Begin
//  Lb_Produto.Caption := Fr_Imp_EtiqProdutos.StrGrd_Escolhidos.Cells[3,It_I];
//  Lb_Valor.Caption := Fr_Imp_EtiqProdutos.StrGrd_Escolhidos.Cells[5,It_I];
//  Lb_Barra.Digits := Copy(Fr_Imp_EtiqProdutos.StrGrd_Escolhidos.Cells[2,It_I],1,Lc_Tamanho);
  Lc_I := StrToFloatDef(Fr_Imp_EtiqProdutos.StrGrd_Escolhidos.Cells[4,It_I],0);
  It_Qtde := Trunc(Lc_I);
  inc(It_J);
  if It_J = It_Qtde  then
    Begin
    inc(It_I);
    It_J :=0;
    end;
end;

procedure TRL_Etiq_Produtos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Etiq_Produtos := Nil;
end;

end.
