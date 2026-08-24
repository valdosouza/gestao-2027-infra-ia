unit UN_RL_Etiq_NomeProduto;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, DB, STQuery, StdCtrls, QRPrntr;

type
  TRL_Etiq_NomeProduto = class(TForm)
    Qrpt: TQuickRep;
    It_Etiqueta: TQRStringsBand;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure It_EtiquetaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    It_Linha_1 : TQRExprMemo;
    It_Linha_2 : TQRLabel;
    It_Linha_3 : TQRLabel;
    It_Linha_4 : TQRLabel;
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
  RL_Etiq_NomeProduto: TRL_Etiq_NomeProduto;

implementation

uses      UN_Sistema, CheckLst, Un_DM, Un_Imp_EtiqProdutos;


{$R *.dfm}




procedure TRL_Etiq_NomeProduto.Pc_configuraEtiqueta;
Var
  Lc_topo : Integer;
  Lc_Linhas : Integer;
  I,J : Integer;
Begin
  with Fr_Imp_EtiqProdutos do
  Begin
    //iT_Etiqueta := TQRStringsBand.Create(Qrpt);
    //iT_Etiqueta.Parent := Qrpt;
    //iT_Etiqueta.BandType := rbDetail;
    iT_Etiqueta.Items.Clear;
    //Configura
    Lc_Linhas := 0;
    for I := 1 to ( StrGrd_Escolhidos.RowCount - 1) do
    Begin
      For J:= 1 to  StrToIntDef(StrGrd_Escolhidos.Cells[4, I],1) do
      Begin
        inc(Lc_Linhas);
        iT_Etiqueta.Items.Add(IntToStr(Lc_Linhas));
      End;
    End;
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

    It_Linha_1 := TQRExprMemo.Create(iT_Etiqueta);
    It_Linha_1.Parent := It_Etiqueta;
    Lc_topo := Qr_Etiqueta.FieldByName('CGE_ETI_SUPERIOR').AsInteger;
    It_Linha_1.Top := Lc_topo ;
    It_Linha_1.Font.Name := Qr_Etiqueta.FieldByName('CGE_TYPEFONTE').AsVariant;
    It_Linha_1.Font.Size := (Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger * 2) + 5;
    It_Linha_1.Caption := 'Descrição do Produto';
    Lc_topo := Lc_topo + It_Linha_1.Height;
    It_Linha_1.Font.Size := Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger;
    It_Linha_1.AutoSize := False;
    It_Linha_1.AutoStretch := True;
    It_Linha_1.Width := It_Etiqueta.Width - 6;
    It_Linha_1.Alignment := taCenter;
    It_Linha_1.AlignToBand := True;
    It_Linha_1.WordWrap := true;
    //It_Linha_1.Color := clSilver;
    It_Linha_1.Refresh;
    It_Linha_1.Repaint;

    It_Linha_2 := TQRLabel.Create(iT_Etiqueta);
    It_Linha_2.Parent := It_Etiqueta;
    It_Linha_2.Height := 5;
    It_Linha_2.Font.Name := Qr_Etiqueta.FieldByName('CGE_TYPEFONTE').AsVariant;
    It_Linha_2.Font.Size := Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger -1;
    It_Linha_2.Caption := 'PROMO��O';
    It_Linha_2.Top := Lc_topo;
    It_Linha_2.Alignment := taCenter;
    It_Linha_2.AlignToBand := True;
    It_Linha_2.WordWrap := False;
    It_Linha_2.AutoSize := True;
    It_Linha_2.AutoStretch := True;
    //It_Linha_2.Color := clSilver;
    It_Linha_2.Refresh;
    It_Linha_2.Repaint;

    It_Linha_3 := TQRLabel.Create(iT_Etiqueta);
    It_Linha_3.Parent := It_Etiqueta;
    It_Linha_3.Height := 5;
    It_Linha_3.Font.Name := Qr_Etiqueta.FieldByName('CGE_TYPEFONTE').AsVariant ;
    It_Linha_3.Font.Size := Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger +10;
    It_Linha_3.Caption := 'PRE�O';
    Lc_topo := Lc_topo + It_Linha_2.Height -5 ;
    It_Linha_3.Top := Lc_topo;
    It_Linha_3.Alignment := taCenter;
    It_Linha_3.AlignToBand := True;
    It_Linha_3.WordWrap := False;
    It_Linha_3.AutoSize := True;
    It_Linha_3.AutoStretch := True;
    It_Linha_3.Refresh;
    //It_Linha_3.Color := clSilver;
    It_Linha_3.Repaint;

    It_Linha_4 := TQRLabel.Create(iT_Etiqueta);
    It_Linha_4.Parent := It_Etiqueta;
    It_Linha_4.Height := 5;
    It_Linha_4.Font.Name := Qr_Etiqueta.FieldByName('CGE_TYPEFONTE').AsVariant;
    It_Linha_4.Font.Size := Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger - 2;
    It_Linha_4.Caption := 'C�DIGO';
    Lc_topo := Lc_topo + It_Linha_3.Height ;
    It_Linha_4.Top := Lc_topo;
    It_Linha_4.Alignment := taCenter;
    It_Linha_4.AlignToBand := True;
    It_Linha_4.WordWrap := False;
    It_Linha_4.AutoSize := True;
    It_Linha_4.AutoStretch := True;
    //It_Linha_4.Color := clSilver;
    It_Linha_4.Refresh;
    It_Linha_4.Repaint;
  end;
  It_Linhas := 1;
  It_Repeticao := 0;
end;

procedure TRL_Etiq_NomeProduto.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_configuraEtiqueta;

end;

procedure TRL_Etiq_NomeProduto.It_EtiquetaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with Fr_Imp_EtiqProdutos do
  Begin
    inc(It_Repeticao);
    if It_Repeticao > StrToIntDef(StrGrd_Escolhidos.Cells[4, It_Linhas],1) then
    Begin
      inc(It_Linhas);
      It_Repeticao := 1;
    End;
    //Descrição do Produto
    It_Linha_1.Lines.Clear;
    It_Linha_1.Lines.Add(StrGrd_Escolhidos.Cells[3, It_Linhas]);

    //Verifica se está em Promo�ao
    if (StrGrd_Escolhidos.Cells[8, It_Linhas] = 'S') then
    Begin
      //Seta a Fonte para a Palavra Promoção
      It_Linha_2.BringToFront;
      It_Linha_2.Font.Color := clRed;
      It_Linha_2.Caption := 'PROMO��O';
    End
    else
    Begin
      It_Linha_2.SendToBack;
      It_Linha_2.Font.Color := clWhite;
    end;

    //Preço do Produto
    It_Linha_3.Caption := 'R$ ' + StrGrd_Escolhidos.Cells[5, It_Linhas];
    //codigo interno do produto
    It_Linha_4.Caption := 'C�DIGO: '+ StrGrd_Escolhidos.Cells[1, It_Linhas];
  end;
end;

procedure TRL_Etiq_NomeProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(It_Linha_1);
  FreeAndNil(It_Linha_2);
  FreeAndNil(It_Linha_3);
  FreeAndNil(It_Linha_4);
  FreeAndNil(iT_Etiqueta);
  Action := Cafree;
  Qrpt := Nil;
  RL_Etiq_NomeProduto := Nil;
end;

end.
