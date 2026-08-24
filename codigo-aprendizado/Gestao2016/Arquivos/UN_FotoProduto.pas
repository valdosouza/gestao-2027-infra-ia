unit UN_FotoProduto;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, Jpeg, ExtCtrls, StdCtrls, Buttons, DBCtrls, Gauges, ComCtrls, Un_JPEGImageExt, OleCtrls, SHDocVw, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdFTP;

type
  TFr_FotoProduto = class(TForm)
    Panel1: TPanel;
    Qr_Imagem: TSTQuery;
    Image1: TImage;
    Ds_Imagem: TDataSource;
    Ftp_Cliente: TIdFTP;
    Pg_Informa: TPageControl;
    Tbs_Memo: TTabSheet;
    Tbs_Html: TTabSheet;
    Pnl_Fundo1: TPanel;
    MM_Detalhe: TRichEdit;
    Pnl_Fundo2: TPanel;
    WebBrowser: TWebBrowser;
    Pnl_Botao: TPanel;
    Sb_Next: TSpeedButton;
    Sb_Last: TSpeedButton;
    Sb_First: TSpeedButton;
    Sb_Prior: TSpeedButton;
    Lb_Mensagem: TLabel;
    Pnl_navega: TPanel;
    pnl_navega_top: TPanel;
    pnl_navega_botao: TPanel;
    procedure Sb_FirstClick(Sender: TObject);
    procedure Sb_NextClick(Sender: TObject);
    procedure Sb_PriorClick(Sender: TObject);
    procedure Sb_LastClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure Qr_ImagemAfterOpen(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    It_Cd_Prod_Site : String;
    FModoDespacho: boolean;
    procedure IniciaVarriaveis;
    procedure setFModoDespacho(const Value: boolean);
    procedure FinalizarPorEscOuCancelamento;
    procedure FinalizarPorEnterConfirmacao;
  public
    { Public declarations }
    bytesToTransfer: integer;
    It_e_commerce : boolean;
    It_Cd_Produto : Integer;
    It_Cd_ImgProd: Integer;
    procedure Pc_MostraImagem;
    procedure Pc_arquivoImagem(pc_Oper:String);
    procedure Pc_FormataTela;
    property ModoDespacho: boolean read FModoDespacho write setFModoDespacho;
  end;

var
  Fr_FotoProduto: TFr_FotoProduto;

implementation

uses     Un_DM, Un_Produtos, UN_MSG, UN_Sistema, env;
{$R *.dfm}

procedure TFr_FotoProduto.FinalizarPorEscOuCancelamento;
begin
   FModoDespacho := False;
  Close;
end;

procedure TFr_FotoProduto.FinalizarPorEnterConfirmacao;
begin
  FModoDespacho := True;
  Close;
end;

procedure TFr_FotoProduto.Pc_FormataTela;
Begin
  Lb_Mensagem.Visible := FModoDespacho;
end;



procedure TFr_FotoProduto.Pc_arquivoImagem(pc_Oper:String);
Begin
  If pc_Oper = 'C' then
    Begin
    Image1.Picture.SaveToFile(GbPathExe+'temp\'+It_Cd_Prod_Site+'.jpg');
    end
  else
    Begin
    DeleteFile(GbPathExe+'temp\'+It_Cd_Prod_Site+'.jpg');
    end;
end;


procedure TFr_FotoProduto.Pc_MostraImagem;
var
  St_Image:TStream;
  Jp_IMage: TJpegImage; // sem a unit 'jpeg' essa classe não existiria
begin
  Jp_IMage := nil;
  if Qr_Imagem.FieldByName('target').AsString = 'cover' then
    pnl_navega_top.Caption := 'Foto Capa do àlbum - Tipo normal'
  else
  if Qr_Imagem.FieldByName('kind').AsString = 'normal' then
    pnl_navega_top.Caption := 'Foto Secundária - Tipo normal'
  else
  if Qr_Imagem.FieldByName('kind').AsString = 'banner' then
    pnl_navega_top.Caption := 'Foto - Tipo Banner'
  else
  if Qr_Imagem.FieldByName('kind').AsString = 'Text' then
    pnl_navega_top.Caption := 'Foto - Tipo Texto';

  if (Qr_Imagem.FieldByName('kind').AsString = 'banner') or
      (Qr_Imagem.FieldByName('kind').AsString = 'Text') then
    Caption := 'Imagem não redimensionada'
  else
    Caption := 'Imagem 360 x 360';

  St_Image := Qr_Imagem.CreateBlobStream(Qr_Imagem.FieldByName('content'),bmRead);
  if St_Image.Size > 0 then
  begin
    Try
      try
        Jp_IMage := TJpegImage.Create;
        Jp_IMage.LoadFromStream(St_Image);
        Image1.Picture.Assign(Jp_IMage);
        Image1.Visible := true;
      except
      end;
    Finally
      FreeAndNil(Jp_IMage);
    End;
  end
  else
    begin
    Image1.Picture.LoadFromFile('');
    Image1.Visible := False;
    end;
  St_Image.Destroy;
end;
procedure TFr_FotoProduto.Sb_FirstClick(Sender: TObject);
begin
  if (Qr_Imagem.Active) and (not Qr_Imagem.bof)then
    Begin
    Qr_Imagem.First;
    Pc_MostraImagem;
    end;
end;

procedure TFr_FotoProduto.Sb_NextClick(Sender: TObject);
begin
  if (Qr_Imagem.Active) and (not Qr_Imagem.Eof)then
    Begin
    Qr_Imagem.Next;
    Pc_MostraImagem;
    end;
end;

procedure TFr_FotoProduto.Sb_PriorClick(Sender: TObject);
begin
  if (Qr_Imagem.Active) and  (not Qr_Imagem.bof)then 
    Begin
    Qr_Imagem.Prior;
    Pc_MostraImagem;
    end;
end;

procedure TFr_FotoProduto.setFModoDespacho(const Value: boolean);
begin
  FModoDespacho := Value;
end;

procedure TFr_FotoProduto.Sb_LastClick(Sender: TObject);
begin
  if (Qr_Imagem.Active) and (not Qr_Imagem.Eof)then
    Begin
    Qr_Imagem.Last;
    Pc_MostraImagem;
    end;
end;

procedure TFr_FotoProduto.FormShow(Sender: TObject);
begin
  IF not (DirectoryExists(GbPathExe+'temp\')) then ForceDirectories(GbPathExe+'temp\');
  Qr_Imagem.Close;
  Qr_Imagem.ParamByName('IMG_CODPRO').AsInteger := It_Cd_Produto;
  Qr_Imagem.Open;
  Qr_Imagem.First;
  Qr_Imagem.Locate('ID',It_Cd_ImgProd,[loCaseInsensitive]);
  Pc_MostraImagem;
  Pc_FormataTela;
end;



procedure TFr_FotoProduto.IniciaVarriaveis;
begin
  FModoDespacho := False;
end;

procedure TFr_FotoProduto.Qr_ImagemAfterOpen(DataSet: TDataSet);
var
  Lc_Texto: TMemoryStream;
  Lc_Verifica: String;
  Lc_Arquivo: String;
begin
  Qr_Imagem.FetchAll;
  Sb_First.Enabled := (Qr_Imagem.RecordCount > 1);
  Sb_Next.Enabled := (Qr_Imagem.RecordCount > 1);
  Sb_Prior.Enabled := (Qr_Imagem.RecordCount > 1);
  Sb_Last.Enabled := (Qr_Imagem.RecordCount > 1);

  Lc_Arquivo := GbPathExe+'temp\Arquivo_'+ IntToStr(Qr_Imagem.FieldByName('table_id').asInteger) +'.html';
  Lc_Verifica := Copy(Qr_Imagem.FieldByName('PRO_DETALHES').AsString,1,1);

  Lc_Texto := TMemoryStream.Create;
  Lc_Texto.LoadFromStream(Qr_Imagem.CreateBlobStream(Qr_Imagem.FieldByName('PRO_DETALHES'), bmRead));
  MM_Detalhe.Lines.LoadFromStream(lC_Texto);
  Lc_Texto.Free;

  if Lc_Verifica = '<' then
    begin
    Pg_Informa.Pages[0].TabVisible := False;
    Pg_Informa.Pages[1].TabVisible := True;
//    Qr_Imagem.FieldByName('PRO_DETALHES').SaveToFile(Lc_Arquivo);
    WebBrowser.Navigate(Lc_Arquivo);
    end
  else
    begin
    Pg_Informa.Pages[0].TabVisible := True;
    Pg_Informa.Pages[1].TabVisible := False;
    end;
end;




procedure TFr_FotoProduto.FormCreate(Sender: TObject);
begin
  IniciaVarriaveis;
end;

procedure TFr_FotoProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift <> [] then
    Exit;
  case Key of
    VK_ESCAPE:
      begin
        Key := 0;
        FinalizarPorEscOuCancelamento;
      end;
    VK_RETURN:
      begin
        Key := 0;
        FinalizarPorEnterConfirmacao;
      end;
  end;
end;

end.
