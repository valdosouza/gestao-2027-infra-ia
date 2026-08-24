unit Un_Clta_CNPJ;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, ACBrBase, ACBrSocket, ACBrConsultaCNPJ, Mask;

{$IFDEF CONDITIONALEXPRESSIONS}
   {$IF CompilerVersion >= 20.0}
     {$DEFINE DELPHI2009_UP}
   {$IFEND}
{$ENDIF}

{.$DEFINE SUPPORT_PNG}  // Remova o Ponto, se seu Delphi suporta PNG

{$IFDEF DELPHI2009_UP}
  {$DEFINE SUPPORT_PNG}
{$ENDIF}

type
  TFr_Clta_CNPJ = class(TForm)
    Panel1: TPanel;
    Label14: TLabel;
    ButBuscar: TBitBtn;
    EditCaptcha: TEdit;
    Panel3: TPanel;
    Image1: TImage;
    LabAtualizarCaptcha: TLabel;
    CNPJ: TACBrConsultaCNPJ;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure ButBuscarClick(Sender: TObject);
    procedure LabAtualizarCaptchaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Consulta : Boolean;
    It_CNPJ:String;
  end;

var
  Fr_Clta_CNPJ: TFr_Clta_CNPJ;

implementation

uses
      JPEG
{$IFDEF SUPPORT_PNG}, pngimage
{$ENDIF}, UN_Sistema, Un_Regra_Negocio, Un_Msg, env;

{$R *.dfm}

procedure TFr_Clta_CNPJ.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:= False;
  LabAtualizarCaptchaClick(LabAtualizarCaptcha);
end;

procedure TFr_Clta_CNPJ.ButBuscarClick(Sender: TObject);
begin
  if EditCaptcha.Text <> '' then
  begin
    try
      It_Consulta := CNPJ.Consulta(fc_MascaraCNPJ(It_CNPJ) , EditCaptcha.Text);
    except
      It_Consulta := False;
      MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                     'A receita estadual pode estar recusando esta pesquisa' + EOLN +
                     'Com certificado digital, utilize a instância Estadual.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
    end;
    if It_Consulta then
      Self.Close;
  end
  else
  begin
    ShowMessage('� necessário digitar o captcha.');
    EditCaptcha.SetFocus;
  end;
end;

procedure TFr_Clta_CNPJ.LabAtualizarCaptchaClick(Sender: TObject);
var
  Stream: TMemoryStream;
//  Jpg: TJPEGImage;
{$IFDEF DELPHI2009_UP}
  png: TPngImage;
{$ELSE}
  ImgArq: String;
{$ENDIF}
begin
  {$IFNDEF SUPPORT_PNG}
    ShowMessage('Atenção: Seu Delphi não d� suporte nativo a imagens PNG. Queira verificar o código fonte deste exemplo para saber como proceder.');
    Exit;
    // COMO PROCEDER:
    //
    // 1) Caso o site da receita esteja utilizando uma imagem do tipo JPG, voc� pode utilizar o código comentado abaixo.
    //    * Comente ou apague o código que trabalha com PNG, incluindo o IFDEF/ENDIF;
    //    * descomente a declaração da vari�vel jpg
    //    * descomente o código abaixo;
    // 2) Caso o site da receita esteja utilizando uma imagem do tipo PNG, voc� ter� que utilizar uma biblioteca de terceiros para
    //conseguir trabalhar com imagens PNG.
    //  Neste caso, recomendamos verificar o manual da biblioteca em como fazer a implementação. Algumas sugest�es:
    //    * Procure no F�rum do ACBr sobre os erros que estiver recebendo. Uma das maneiras mais simples está no link abaixo:
    //      - http://www.projetoacbr.com.br/forum/topic/20087-imagem-png-delphi-7/
    //    * O exemplo acima utiliza a biblioteca GraphicEX. Mas existem outras bibliotecas, caso prefira:
    //      - http://synopse.info/forum/viewtopic.php?id=115
    //      - http://graphics32.org/wiki/
    //      - http://cc.embarcadero.com/Item/25631
    //      - V�rias outras: http://torry.net/quicksearchd.php?String=png&Title=Yes
  {$ENDIF}

  Stream:= TMemoryStream.Create;
  try
    CNPJ.Captcha(Stream);

   {$IFDEF DELPHI2009_UP}
    //Use esse código quando a imagem do site for do tipo PNG
    png:= TPngImage.Create;
    try
      png.LoadFromStream(Stream);
      Image1.Picture.Assign(png);
    finally
      FreeAndNil(png);
    end;
    { //Use esse código quando a imagem do site for do tipo JPG
      Jpg:= TJPEGImage.Create;
      try
        Jpg.LoadFromStream(Stream);
        Image1.Picture.Assign(Jpg);
      finally
        FreeAndNil(Jpg);
      end;
    }
   {$ELSE}
    ImgArq := ExtractFilePath(ParamStr(0))+PathDelim+'captch.png';
    Stream.SaveToFile( ImgArq );
    Image1.Picture.LoadFromFile( ImgArq );
   {$ENDIF}

    EditCaptcha.Clear;
    EditCaptcha.SetFocus;
  finally
    FreeAndNil(Stream);
  end;
end;

procedure TFr_Clta_CNPJ.FormShow(Sender: TObject);
begin
  //Verifica se tem proxy para baixar o arquivo
  Fc_VerificaProxy;
  CNPJ.ProxyHost := Gb_PXY_PATH;
  CNPJ.ProxyPort := IntToStr(Gb_PXY_PORTA);
  CNPJ.ProxyUser := Gb_PXY_USER;
  CNPJ.ProxyPass := Gb_PXY_PWS;
  Timer1.Enabled:= True;
end;

end.
