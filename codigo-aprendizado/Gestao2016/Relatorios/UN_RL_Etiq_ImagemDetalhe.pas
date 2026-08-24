unit UN_RL_Etiq_ImagemDetalhe;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, DB, STQuery, StdCtrls, QRPrntr, Vcl.Imaging.jpeg, synacode;

type
  TRL_Etiq_ImagemDetalhe = class(TForm)
    Qrpt: TQuickRep;
    Qr_Image: TSTQuery;
    qrMarca: TQRLabel;
    qrNumFab_Sku: TQRLabel;
    qrValor: TQRLabel;
    qrImagem: TQRImage;
    qrAplicacao: TQRMemo;
    qrStringBand: TQRStringsBand;
    QRShape: TQRShape;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QrptNeedData(Sender: TObject; var MoreData: Boolean);
    procedure qrStringBandBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    FLinhas : Integer;
    FRepeticao: Integer;

    procedure CarregarImagem(vPro_Codigo: integer);
    procedure Pc_configuraEtiqueta;
    procedure setFRepeticao(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }

    property Repeticao :Integer read FRepeticao write setFRepeticao;
  end;

  TDPI = (DPI96 = 96, DPI120 = 120, DPI144 = 144, DPI192 = 192);

  TConversor = class
  public
    /// <summary> -Converte um valor em centímetros para pixels.
    /// -A unidade padrão do Delphi é o pixel.
    /// -Para converter centímetros para pixels, você precisa levar em conta a densidade de pixels da tela,
    /// que pode variar, mas você pode fazer isso considerando uma média de 96 pixels por polegada (dpi)
    /// para telas com resolução padrão.
    /// </summary>
    /// <param name="Cm">Valor em centímetros a ser convertido.
    /// </param>
    /// <param name="DPI">Densidade de pixels por polegada (DPI) da tela.
    /// </param>
    /// <returns>O valor correspondente em pixels.
    /// </returns>

    class function CmParaPixels(vCm: Double; vDPI: TDPI): Integer;
  end;

var
  RL_Etiq_ImagemDetalhe: TRL_Etiq_ImagemDetalhe;

implementation

uses      UN_Sistema, Un_Imp_EtiqProdutos, env, Un_DM;
{$R *.dfm}

procedure TRL_Etiq_ImagemDetalhe.Pc_configuraEtiqueta;
Var
  I,J : Integer;
Begin
  with Fr_Imp_EtiqProdutos do
  begin
    qrStringBand.Items.Clear;
    //Configura
    FLinhas := 0;
    for I := 1 to ( StrGrd_Escolhidos.RowCount - 1) do
    begin
      for J:= 1 to StrToIntDef(StrGrd_Escolhidos.Cells[4, I],1) do
      begin
        inc(FLinhas);
        qrStringBand.Items.Add(IntToStr(FLinhas));
      end;
    end;
  end;

  {QRShape.Left := 3;
  QRShape.Top := 3;
  QRShape.Height := TConversor.CmParaPixels(4.5, DPI96); //170;
  QRShape.Width :=  TConversor.CmParaPixels(7.5, DPI96); //284;

  qrImagem.Left := 6;
  qrImagem.Top := 5;
  qrImagem.Height := TConversor.CmParaPixels(3.4, DPI96);
  qrImagem.Width := TConversor.CmParaPixels(2.5, DPI96);

  qrValor.Left := 6;
  qrValor.Top := 135;
  qrValor.Height := 11;
  qrValor.Width := TConversor.CmParaPixels(2.5, DPI96);

  qrNumFab_Sku.Left := 6;
  qrNumFab_Sku.Top := 147;
  qrNumFab_Sku.Height := 11;
  qrNumFab_Sku.Width := TConversor.CmParaPixels(2.5, DPI96);

  qrMarca.Left := 6;
  qrMarca.Top := 160;
  qrMarca.Height := 11;
  qrMarca.Width := TConversor.CmParaPixels(2.5, DPI96);

  qrAplicacao.Left := 104;
  qrAplicacao.Top := 5;
  qrAplicacao.Height := TConversor.CmParaPixels(4.5, DPI96);
  qrAplicacao.Width :=  TConversor.CmParaPixels(5, DPI96);  }

  FLinhas := 1;
  FRepeticao := 0;
end;

procedure TRL_Etiq_ImagemDetalhe.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_configuraEtiqueta;
end;

procedure TRL_Etiq_ImagemDetalhe.QrptNeedData(Sender: TObject;
  var MoreData: Boolean);
  var s: string;
begin

end;

procedure TRL_Etiq_ImagemDetalhe.qrStringBandBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with Fr_Imp_EtiqProdutos do
  Begin
    inc(FRepeticao);
    if FRepeticao > StrToIntDef(StrGrd_Escolhidos.Cells[4, FLinhas],1) then
    begin
      inc(FLinhas);
      FRepeticao := 1;
    end;

    CarregarImagem(StrToInt(Fr_Imp_EtiqProdutos.StrGrd_Escolhidos.Cells[1, FLinhas]));
    qrValor.Caption       := 'R$ ' + StrGrd_Escolhidos.Cells[5, FLinhas];  //TB_PRECO - PRC_VL_VDA
    qrNumFab_Sku.Caption  := StrGrd_Escolhidos.Cells[2, FLinhas] + '-' + StrGrd_Escolhidos.Cells[1, FLinhas];//PRO_CODIGOFAB + PRO_CODIGO
    qrMarca.Caption       := StrGrd_Escolhidos.Cells[10, FLinhas];      //TB_MARCA_PRODUTO - MRC_DESCRICAO
    qrAplicacao.Lines.Text := DecodeBase64(StrGrd_Escolhidos.Cells[11, FLinhas]); //TB_PRODUTO - PRO_APLICACAO
  end;
end;

procedure TRL_Etiq_ImagemDetalhe.setFRepeticao(const Value: Integer);
begin
  FRepeticao := Value;
end;

procedure TRL_Etiq_ImagemDetalhe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := Cafree;
  Qrpt := Nil;
  RL_Etiq_ImagemDetalhe := Nil;
end;

procedure TRL_Etiq_ImagemDetalhe.CarregarImagem(vPro_Codigo: integer);
var
  St_Image: TStream;
  Jp_IMage: TJpegImage;
begin
  Jp_IMage := nil;
  Qr_Image.Close;
  Qr_Image.ParamByName('PRO_CODIGO').AsInteger := vPro_Codigo;
  Qr_Image.Open;

  St_Image := Qr_Image.CreateBlobStream(Qr_Image.FieldByName('content'),bmRead);
  Try
    if St_Image.Size > 0 then
    begin
      try
        if (Qr_Image.FieldByName('extension').AsString = 'jpg') then
        Begin
          Jp_IMage := TJpegImage.Create;
          Try
            Jp_IMage.LoadFromStream(St_Image);
            qrImagem.Picture.Assign(Jp_IMage);
            qrImagem.Visible := true;
          Finally
            FreeAndNil(Jp_IMage);
          End;
        end
        else
        if (Qr_Image.FieldByName('extension').AsString = 'png') then
        Begin
          TBlobField(Qr_Image.FieldByName('content')).SaveToFile(GbPathExe + Qr_Image.FieldByName('file_name').AsString);
          qrImagem.Picture.LoadFromFile(GbPathExe + Qr_Image.FieldByName('file_name').AsString);
        end;
      except
        qrImagem.Picture.LoadFromFile('');
        qrImagem.Visible := false;
      end;
    end
    else
    begin
      qrImagem.Picture.LoadFromFile('');
      qrImagem.Visible := False;
    end;
  Finally
    St_Image.Destroy;
  End;
end;

{ TConversor }

class function TConversor.CmParaPixels(vCm: Double; vDPI: TDPI): Integer;
begin
  Result := Round(vCm * Integer(vDPI) / 2.54);
end;

end.
