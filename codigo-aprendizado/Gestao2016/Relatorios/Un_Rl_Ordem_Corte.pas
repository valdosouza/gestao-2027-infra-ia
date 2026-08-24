unit Un_Rl_Ordem_Corte;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, jpeg, DB, STQuery, QRPDFFilt, StdCtrls, System.Math;

type
  TRl_Ordem_Corte = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    DetalheVenda: TQRStringsBand;
    Bnd_Sumario: TQRBand;
    Lb_Data: TQRLabel;
    Lb_Ordemcorte: TQRLabel;
    Lb_Produto: TQRLabel;
    Lb_Consumo: TQRLabel;
    Lb_Quantidade: TQRLabel;
    QRLabel8: TQRLabel;
    Lb_Qt_Geral: TQRLabel;
    Qr_Itens: TSTQuery;
    QRBand1: TQRBand;
    QRMemo3: TQRMemo;
    QRMemo5: TQRMemo;
    QRMemo7: TQRMemo;
    QRLabel19: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel27: TQRLabel;
    QRMemo1: TQRMemo;
    QRMemo8: TQRMemo;
    QRMemo10: TQRMemo;
    QRMemo11: TQRMemo;
    QRMemo2: TQRMemo;
    QRMemo4: TQRMemo;
    Lb_Tecido: TQRLabel;
    Lb_Cor: TQRLabel;
    QRLabel13: TQRLabel;
    Qr_Ordem: TSTQuery;
    QRMemo12: TQRMemo;
    QRMemo13: TQRMemo;
    QRMemo14: TQRMemo;
    QRMemo16: TQRMemo;
    QRMemo17: TQRMemo;
    QRMemo18: TQRMemo;
    QRMemo19: TQRMemo;
    QRMemo20: TQRMemo;
    QRMemo21: TQRMemo;
    QRMemo22: TQRMemo;
    QRMemo23: TQRMemo;
    QRMemo24: TQRMemo;
    QRMemo25: TQRMemo;
    QRMemo26: TQRMemo;
    Lb_T01: TQRLabel;
    Lb_T02: TQRLabel;
    Lb_T03: TQRLabel;
    Lb_T04: TQRLabel;
    Lb_T05: TQRLabel;
    Lb_T06: TQRLabel;
    Lb_T07: TQRLabel;
    Lb_QT07: TQRLabel;
    Lb_QT06: TQRLabel;
    Lb_QT05: TQRLabel;
    Lb_QT04: TQRLabel;
    Lb_QT03: TQRLabel;
    Lb_QT02: TQRLabel;
    Lb_QT01: TQRLabel;
    Qr_Tamanho: TSTQuery;
    QRMemo15: TQRMemo;
    QRLabel1: TQRLabel;
    Lb_Cli_Nome: TQRLabel;
    Lb_Cli_Fantasia: TQRLabel;
    QRLabel7: TQRLabel;
    Lb_Obs: TQRMemo;
    QRLabel3: TQRLabel;
    QRLabel2: TQRLabel;
    Lb_PrazoEntrega: TQRLabel;
    Qr_Imagem: TSTQuery;
    Img_Frente: TQRImage;
    E_obsOrcamento: TMemo;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Bnd_SumarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_cd_Pedido : Integer;
    Procedure PC_VAlidaCampos(Pc_Print : Boolean);
    Procedure PC_PreencheCampos;
    Procedure Pc_PreencheGrade;
    function Pc_MostraImagem(): TJpegImage;
  end;

var
  Rl_Ordem_Corte: TRl_Ordem_Corte;

implementation

uses     Un_Cotacao, Un_Funcoes, UN_Sistema, Un_DM, UN_Pedido_Vda;
{$R *.dfm}

function TRl_Ordem_Corte.Pc_MostraImagem(): TJpegImage;
var
  St_Image:TStream;
  Jp_IMage: TJpegImage;
begin
  Jp_IMage := nil;
  // transferindo a fotografia para o objeto TStream
  St_Image := Qr_Imagem.CreateBlobStream(Qr_Imagem.FieldByName('IMG_IMAGEM'),bmRead);
  // Verifica se existe imagem
  if St_Image.Size > 0 then
    begin
      try
        Jp_IMage := TJpegImage.Create;
        Jp_IMage.LoadFromStream(St_Image);
        Result :=Jp_IMage;
      except
        exit;
      end;
    end;
end;

Procedure TRl_Ordem_Corte.PC_VAlidaCampos(Pc_Print : Boolean);
Begin
  if Pc_Print then
    BEgin
    Lb_Produto.Font.Color := clBlack;
    Lb_Tecido.Font.Color := clBlack;
    Lb_Cor.Font.Color := clBlack;
    Lb_Consumo.Font.Color := clRed;
    Lb_Consumo.Font.Style := [fsBold];
    Lb_Quantidade.Font.Color := clRed;
    Lb_Quantidade.Font.Style := [fsBold];
    end
  else
    BEgin
    Lb_Produto.Font.Color := clWhite;
    Lb_Tecido.Font.Color := clWhite;
    Lb_Cor.Font.Color := clWhite;
    Lb_Consumo.Font.Color := clWhite;
    Lb_Quantidade.Font.Color := clWhite;
    end;

end;

Procedure TRl_Ordem_Corte.Pc_PreencheGrade;
Var
  Lc_I : integer;
  Lc_Name : String;
Begin
  Qr_Tamanho.Active := False;
  Qr_Tamanho.ParamByName('GRT_CODICT').AsInteger := Qr_Itens.FieldByName('ICT_CODIGO').AsInteger;
  Qr_Tamanho.Active := True;
  Qr_Tamanho.FetchAll;
  Qr_Tamanho.First;
  For Lc_I := 1 to 7 do
    Begin
    Lc_Name := 'Lb_T0' + IntToStr(Lc_I);
    TQRLabel(FindComponent(Lc_Name)).Font.Color := clWhite;
    Lc_Name := 'Lb_QT0' + IntToStr(Lc_I);
    TQRLabel(FindComponent(Lc_Name)).Font.Color := clWhite;
    end;
  Lc_I := 1;
  while not Qr_Tamanho.Eof do
    Begin
    Lc_Name := 'Lb_T0' + IntToStr(Lc_I);
    TQRLabel(FindComponent(Lc_Name)).Font.Color := clBlack;
    TQRLabel(FindComponent(Lc_Name)).Caption := Qr_Tamanho.FieldByName('GRT_TAMANHO').AsString;
    Lc_Name := 'Lb_T0' + IntToStr(Lc_I);
    TQRLabel(FindComponent(Lc_Name)).Font.Color := clBlack;
    TQRLabel(FindComponent(Lc_Name)).Caption := Qr_Tamanho.FieldByName('GRT_TAMANHO').AsString;
    Lc_Name := 'Lb_QT0' + IntToStr(Lc_I);
    TQRLabel(FindComponent(Lc_Name)).Font.Color := clBlack;
    TQRLabel(FindComponent(Lc_Name)).Caption := Qr_Tamanho.FieldByName('GRT_QTDE').AsString;
    Qr_Tamanho.Next;
    Inc(Lc_I);
    end;

end;

Procedure TRl_Ordem_Corte.PC_PreencheCampos;
Begin
  Lb_Produto.Caption := Qr_Itens.FieldByName('ICT_DESCRICAO').AsString;
  Lb_Tecido.Caption := Qr_Itens.FieldByName('ICT_TECIDO').AsString;
  Lb_Cor.Caption := Qr_Itens.FieldByName('ICT_COR').AsString;
  Pc_PreencheGrade;
  Lb_Consumo.Caption := '0';
  Lb_Quantidade.Caption := FloatToStrf(Qr_Itens.FieldByName('ICT_QTDE').AsFloat,ffFixed,10,0);
end;

procedure TRl_Ordem_Corte.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_Ano,Lc_mes,Lc_dia:String ;
  Lc_I:Integer;
begin
  Pc_Cab_Relatorio(Qrpt);
  Qr_Ordem.Active := False;
  Qr_Ordem.ParamByName('CTC_CODPED').AsInteger := It_cd_Pedido;
  Qr_Ordem.Active := True;
  Qr_Ordem.FetchAll;
  E_obsOrcamento.Text := Qr_Ordem.FieldByName('CTC_OBS_CORTE').AsString;

  if Assigned(Fr_Cotacao) then Lb_Ordemcorte.Caption := 'Ordem de Corte Nº '+ Qr_Ordem.FieldByName('CTC_NUMERO').AsString;
  if Assigned(Fr_Pedido_Vda) then Lb_Ordemcorte.Caption := 'Ordem de Corte Nº '+ Qr_Ordem.FieldByName('CTC_NUMERO').AsString + ' - Pedido Nº ' + Qr_Ordem.FieldByName('PED_NUMERO').AsString;
  Lc_dia := Copy(Qr_Ordem.FieldByName('CTC_DATA').AsString,1,2);
  Lc_mes := Fc_DesMes(Fc_Month(Qr_Ordem.FieldByName('CTC_DATA').AsDateTime),True);
  Lc_Ano := Copy(Qr_Ordem.FieldByName('CTC_DATA').AsString,7,4);

  Lb_Data.Caption := 'Curitiba, '+ Lc_dia + ' de ' + Lc_mes + ' de '+ Lc_Ano;



  Qr_Itens.Active := False;
  Qr_Itens.ParamByName('CTC_CODIGO').AsInteger := Qr_Ordem.FieldByName('CTC_CODIGO').AsInteger;
  Qr_Itens.Active := True;
  Qr_Itens.FetchAll;
  DetalheVenda.Items.Clear;
  For Lc_I:=1 to Qr_Itens.RecordCount do
    DetalheVenda.Items.Add(IntTOStr(lc_I));
  Qr_Itens.First;

  Qr_Imagem.Close;
  Qr_Imagem.ParamByName('IMG_CODPRO').AsInteger := Qr_Itens.FieldByName('ICT_CODVCL').AsInteger;
  Qr_Imagem.Open;
  Qr_Imagem.FetchAll;
{  if Qr_Imagem.RecordCount > 0 then
    Begin
    Bnd_Sumario.Height := 465;
    Img_Frente.Visible := true;
    end
  else
    Begin
    Bnd_Sumario.Height := 111;
    Img_Frente.Visible := False;
    end;
}
end;

procedure TRl_Ordem_Corte.DetalheVendaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Not Qr_Itens.Eof then
    Begin
    pc_ValidaCampos(True);
    Pc_PreencheCAmpos;
    Qr_Itens.Next;
    end
  else
    pc_ValidaCampos(False);
end;

procedure TRl_Ordem_Corte.Bnd_SumarioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_I : Integer;
  Lc_data : TDate;
  St_Image:TStream;
  Jp_IMage: TJpegImage;
begin
  DM.Qr_Geral.Active := True;
  Lb_Qt_Geral.Caption := Qr_Ordem.FieldByName('CTC_QT_PRODUTO').AsString;
  If Length(Qr_Ordem.FieldByName('CTC_PRZ_ENTREGA').AsString)>0 then
    Lb_PrazoEntrega.Caption := DateToStr(Qr_Ordem.FieldByName('CTC_PRZ_ENTREGA').AsDateTime - 2)
  else
    Lb_PrazoEntrega.Caption := '';

  Lb_Obs.Lines.Clear;
  For Lc_I := 0 to E_obsOrcamento.Lines.Count - 1 do
    Lb_Obs.Lines.Add(E_obsOrcamento.Lines[lc_I]);
  if Qr_Imagem.RecordCount > 0 then
    Begin
    Qr_Imagem.First;
    Jp_IMage := nil;
    // transferindo a fotografia para o objeto TStream
    St_Image := Qr_Imagem.CreateBlobStream(Qr_Imagem.FieldByName('IMG_IMAGEM'),bmRead);
    // Verifica se existe imagem
    if St_Image.Size > 0 then
      begin
      Jp_IMage := TJpegImage.Create;
      Jp_IMage.LoadFromStream(St_Image);
      Img_Frente.Picture.Assign(Jp_IMage);
      end;
    end;

end;

procedure TRl_Ordem_Corte.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Qrpt.Destroy;
  Qrpt := Nil;
  Rl_Ordem_Corte := nil;
end;

procedure TRl_Ordem_Corte.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Cli_Nome.Caption := Qr_Ordem.FieldByName('EMP_NOME').AsString;
  Lb_Cli_Fantasia.Caption := Qr_Ordem.FieldByName('EMP_FANTASIA').AsString;
end;

end.

