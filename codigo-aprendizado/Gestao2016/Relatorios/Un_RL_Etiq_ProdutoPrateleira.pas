unit Un_RL_Etiq_ProdutoPrateleira;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, DB, STQuery, StdCtrls, QRPrntr;

type
  TRL_Etiq_ProdutoPrateleira = class(TForm)
    Qrpt: TQuickRep;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    iT_Etiqueta: TQRBand;
    It_Linha_1 : TQRLabel;
    It_Linha_2 : TQRLabel;
  public
    { Public declarations }
    //Numero de Etiquetas e repetições
    It_Linhas : Integer;
    It_Repeticao : Integer;
    It_Cd_Etiqueta : Integer;
    It_Nr_Etiquetas : integer;
    It_Criterio : String;
    procedure Pc_configuraEtiqueta;
  end;

var
  RL_Etiq_ProdutoPrateleira: TRL_Etiq_ProdutoPrateleira;

implementation

uses      UN_Sistema, CheckLst, Un_DM, Un_Imp_EtiqProdutos;


{$R *.dfm}




procedure TRL_Etiq_ProdutoPrateleira.Pc_configuraEtiqueta;
Var
  Lc_topo : Integer;
Begin
  with Fr_Imp_EtiqProdutos do
  Begin
    iT_Etiqueta := TQRBand.Create(Qrpt);
    iT_Etiqueta.Parent := Qrpt;
    iT_Etiqueta.BandType := rbDetail;

    Qr_Etiqueta.First;
    Qr_Etiqueta.Locate('CGE_CODIGO',It_Cd_Etiqueta,[]);
    Qrpt.Page.Length := Qr_Etiqueta.FieldByName('CGE_PG_ALTURA').AsFloat;
    Qrpt.Page.Width  := Qr_Etiqueta.FieldByName('CGE_PG_LARGURA').AsFloat;

    Qrpt.Page.TopMargin := Qr_Etiqueta.FieldByName('CGE_SUPERIOR').AsFloat;
    Qrpt.Page.BottomMargin := Qr_Etiqueta.FieldByName('CGE_INFERIOR').AsFloat;

    Qrpt.Page.ColumnSpace := Qr_Etiqueta.FieldByName('CGE_DIS_COLUNA').AsFloat;
    Qrpt.Page.Columns := Qr_Etiqueta.FieldByName('CGE_NR_COLUNA').AsInteger;

    Qrpt.Page.LeftMargin := Qr_Etiqueta.FieldByName('CGE_ESQUERA').AsFloat;
    Qrpt.Page.RightMargin := Qr_Etiqueta.FieldByName('CGE_DIREITA').AsFloat;
    It_Etiqueta.Size.Units := MM;
    It_Etiqueta.Size.Height := Qr_Etiqueta.FieldByName('CGE_ET_ALTURA').AsFloat;
    It_Etiqueta.Size.Width := Qr_Etiqueta.FieldByName('CGE_ET_LARGURA').AsFloat;

    It_Linha_1 := TQRLabel.Create(iT_Etiqueta);
    It_Linha_1.Parent := It_Etiqueta;
    Lc_topo := Qr_Etiqueta.FieldByName('CGE_ETI_SUPERIOR').AsInteger;
    It_Linha_1.Top := Lc_topo ;
    It_Linha_1.Font.Name := Qr_Etiqueta.FieldByName('CGE_TYPEFONTE').AsVariant;
    It_Linha_1.Font.Size := (Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger * 2) + 5;
    It_Linha_1.WordWrap := true;
    It_Linha_1.AutoStretch := True;
    It_Linha_1.Caption := 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
    It_Linha_1.Refresh;
    It_Linha_1.Repaint;
    Lc_topo := Lc_topo + It_Linha_1.Height;
    It_Linha_1.Font.Size := Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger;
    It_Linha_1.AutoSize := False;
    It_Linha_1.AutoStretch := False;
    It_Linha_1.Width := It_Etiqueta.Width - 6;
    It_Linha_1.Alignment := taCenter;
    It_Linha_1.AlignToBand := True;


    It_Linha_2 := TQRLabel.Create(iT_Etiqueta);
    It_Linha_2.Parent := It_Etiqueta;
    It_Linha_2.Height := 5;
    It_Linha_2.Font.Name := Qr_Etiqueta.FieldByName('CGE_TYPEFONTE').AsVariant ;
    It_Linha_2.Font.Size := Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger +5;
    It_Linha_2.Caption := 'LOCAL';
    Lc_topo := Lc_topo; ;
    It_Linha_2.Top := Lc_topo;
    It_Linha_2.Alignment := taCenter;
    It_Linha_2.AlignToBand := True;
    It_Linha_2.WordWrap := False;
    It_Linha_2.AutoSize := True;
    It_Linha_2.AutoStretch := True;
    It_Linha_2.Refresh;
    It_Linha_2.Repaint;
    end;
end;

procedure TRL_Etiq_ProdutoPrateleira.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(It_Linha_1);
  FreeAndNil(It_Linha_2);
  FreeAndNil(iT_Etiqueta);
  Action := Cafree;
  Qrpt := Nil;
  RL_Etiq_ProdutoPrateleira := Nil;
end;



procedure TRL_Etiq_ProdutoPrateleira.QrptNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  with Fr_Imp_EtiqProdutos do
  Begin
    //Verifica se chegou no fim
    Inc(It_Repeticao);
    MoreData := True;
    if (It_Repeticao > StrToIntDef(StrGrd_Escolhidos.Cells[4, It_Linhas],1)) then
      Begin
      Inc(It_Linhas);
      IF not (It_Linhas > (StrGrd_Escolhidos.RowCount - 1)) then
      Begin
        It_Repeticao := 1;
      end
      else
      Begin
        MoreData := False;
      end;
    end;

    It_Etiqueta.Size.Units := MM;
    It_Etiqueta.Size.Height := Qr_Etiqueta.FieldByName('CGE_ET_ALTURA').AsFloat;
    //Descrição do Produto
    It_Linha_1.Caption := StrGrd_Escolhidos.Cells[3, It_Linhas];
    It_Linha_1.Repaint;
    //Localiza�� do Produto
    It_Linha_2.Caption := StrGrd_Escolhidos.Cells[9, It_Linhas];

    if MoreData then Next;
  end;
end;

procedure TRL_Etiq_ProdutoPrateleira.QrptBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
    Pc_Define_Impressora_Qrpt(RL_Etiq_ProdutoPrateleira.Qrpt);
    RL_Etiq_ProdutoPrateleira.Pc_configuraEtiqueta;
end;

end.
