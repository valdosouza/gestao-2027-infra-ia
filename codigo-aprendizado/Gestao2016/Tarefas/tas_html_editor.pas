unit tas_html_editor;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.OleCtrls, SHDocVw, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, MSHTML, Winapi.ActiveX, System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin;

const
   IDM_MARCADOR = 2184;
   IDM_MARCADOR_LISTA = 2185;
   IDM_OUTDENT = 2187;
   IDM_INDENT = 2186;
   IDM_ALINHARESQ = 59;
   IDM_CENTRALIZAR = 57;
   IDM_JUSTIFYFULL = 50;
   IDM_ALINHADIR = 60;
   IDM_IMAGEM = 2168;
   IDM_LINHAHORIZ = 2150;
   IDM_RECORTAR = 16;
   IDM_COPIAR = 15;
   IDM_COLAR = 26;
   IDM_HYPERLINK = 2124;
   IDM_DESFAZER = 43;

type
  TTasHtmlEditor = class(TFr_Base)
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    sb_negrito: TSpeedButton;
    Sb_Italico: TSpeedButton;
    Sb_Sublinhado: TSpeedButton;
    Sb_Cor: TSpeedButton;
    Panel14: TPanel;
    Sb_NumList: TSpeedButton;
    Sb_btnBullet: TSpeedButton;
    btnDecreaseIndent: TSpeedButton;
    btnIncreaseIndent: TSpeedButton;
    Panel15: TPanel;
    btnAlignLeft: TSpeedButton;
    btnCenter: TSpeedButton;
    btnAlignRight: TSpeedButton;
    btnAlignJustity: TSpeedButton;
    Panel17: TPanel;
    btnHR: TSpeedButton;
    Panel18: TPanel;
    Panel19: TPanel;
    btnCut: TSpeedButton;
    btnCopy: TSpeedButton;
    btnPaste: TSpeedButton;
    Sb_Hiperlink: TSpeedButton;
    Sb_Desfazer: TSpeedButton;
    Label5: TLabel;
    Label8: TLabel;
    combofont: TComboBox;
    ComboSize: TComboBox;
    WebBrowser: TWebBrowser;
    cdColor: TColorDialog;
    ToolBar1: TToolBar;
    ZoomPickButton: TSpeedButton;
    Spacer3: TToolButton;
    PrintSetup: TToolButton;
    Print: TToolButton;
    Images: TImageList;
    SB_Alterar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    SB_Gravar: TSpeedButton;
    Sb_Limpar: TSpeedButton;
    procedure sb_negritoClick(Sender: TObject);
    procedure Sb_SublinhadoClick(Sender: TObject);
    procedure Sb_CorClick(Sender: TObject);
    procedure Sb_ItalicoClick(Sender: TObject);
    procedure Sb_NumListClick(Sender: TObject);
    procedure Sb_btnBulletClick(Sender: TObject);
    procedure btnDecreaseIndentClick(Sender: TObject);
    procedure btnIncreaseIndentClick(Sender: TObject);
    procedure btnAlignJustityClick(Sender: TObject);
    procedure btnAlignLeftClick(Sender: TObject);
    procedure btnCenterClick(Sender: TObject);
    procedure btnAlignRightClick(Sender: TObject);
    procedure btnHRClick(Sender: TObject);
    procedure btnCutClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnPasteClick(Sender: TObject);
    procedure Sb_DesfazerClick(Sender: TObject);
    procedure Sb_HiperlinkClick(Sender: TObject);
    procedure combofontChange(Sender: TObject);
    procedure ComboSizeChange(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure PrintSetupClick(Sender: TObject);
    procedure ZoomPickButtonClick(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure Sb_LimparClick(Sender: TObject);


    Private
    FConteudo: STring;
    procedure setFConteudo(const Value: STring);
    function GetIEHandle(WebBrowser: TWebBrowser; ClassName: string): HWND;
  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure ImagemBotao;Override;
  public
    { Public declarations }
    property Conteudo:STring read FConteudo write setFConteudo;
  end;

var
  TasHtmlEditor: TTasHtmlEditor;
  HTMLDocumento: IHTMLDocument2;
  TempFile: string;
  xBody   : IHTMLElement;
  xLoaded : Boolean;
  onlyOnce: Boolean;

implementation

{$R *.dfm}

{ TTasHtmlEditor }

procedure TTasHtmlEditor.btnAlignJustityClick(Sender: TObject);
begin

  SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
    WM_COMMAND, IDM_JUSTIFYFULL, 0);
end;

procedure TTasHtmlEditor.btnAlignLeftClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_ALINHARESQ, 0);

end;

procedure TTasHtmlEditor.btnAlignRightClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_ALINHADIR, 0);

end;

procedure TTasHtmlEditor.btnCenterClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_CENTRALIZAR, 0);

end;

procedure TTasHtmlEditor.btnCopyClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_COPIAR, 0);

end;

procedure TTasHtmlEditor.btnCutClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_RECORTAR, 0);

end;

procedure TTasHtmlEditor.btnDecreaseIndentClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_OUTDENT, 0);
end;

procedure TTasHtmlEditor.btnHRClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_LINHAHORIZ, 0);
end;

procedure TTasHtmlEditor.btnIncreaseIndentClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_INDENT, 0);
end;

procedure TTasHtmlEditor.btnPasteClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_COLAR, 0);

end;

procedure TTasHtmlEditor.ComboSizeChange(Sender: TObject);
begin
   HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
   case Combosize.ItemIndex of
      0: HTMLDocumento.execCommand('FontSize', False, 1);
      1: HTMLDocumento.execCommand('FontSize', False, 2);
      2: HTMLDocumento.execCommand('FontSize', False, 3);
      3: HTMLDocumento.execCommand('FontSize', False, 5);
      4: HTMLDocumento.execCommand('FontSize', False, 6);
      5: HTMLDocumento.execCommand('FontSize', False, 7);
   end;
end;

procedure TTasHtmlEditor.combofontChange(Sender: TObject);
begin
   HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
   HTMLDocumento.execCommand('FontName', False, ComboFont.Text);

end;

procedure TTasHtmlEditor.CriarVariaveis;
begin
end;

function TTasHtmlEditor.GetIEHandle(WebBrowser: TWebBrowser;
  ClassName: string): HWND;
var
   hwndChild, hwndTmp: HWND;
   oleCtrl: TOleControl;
   szClass: array[0..255] of char;
begin
  oleCtrl := WebBrowser;
  hwndTmp := oleCtrl.Handle;
  while (true) do
  begin
    hwndChild := GetWindow(hwndTmp, GW_CHILD);
    GetClassName(hwndChild, szClass, SizeOf(szClass));
    if (string(szClass) = ClassName) then
    begin
      Result := hwndChild;
      Exit;
    end;
    hwndTmp := hwndChild;
  end;
  Result := 0;
end;

procedure TTasHtmlEditor.ImagemBotao;
begin
  CarregaImagemBotao(SB_Alterar,'ALTERAR');
  CarregaImagemBotao(SB_Gravar,'GRAVAR');
  CarregaImagemBotao(Sb_Sair_0,'SAIR');

end;

procedure TTasHtmlEditor.IniciaVariaveis;
var
  sl: TStringList;
  ms: TMemoryStream;
begin
  xLoaded := False;
  WebBrowser.Navigate('about:blank');
  while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
   Application.ProcessMessages;

  if Assigned(WebBrowser.Document) then
  begin
    sl := TStringList.Create;
    try
      ms := TMemoryStream.Create;
      try
        sl.Text := FConteudo;
        sl.SaveToStream(ms);
        ms.Seek(0, 0);
        (WebBrowser.Document as IHTMLDocument2).designMode := 'On';
        (WebBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(ms));

      finally
        ms.Free;
      end;
    finally
      sl.Free;
      HTMLDocumento :=  WebBrowser.Document as IHTMLDocument2;
    end;
  end;
end;

procedure TTasHtmlEditor.PrintClick(Sender: TObject);
var
  vaIn, vaOut: OleVariant;
begin
  WebBrowser.ControlInterface.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_PROMPTUSER,
    vaIn, vaOut);
end;

procedure TTasHtmlEditor.PrintSetupClick(Sender: TObject);
var
  vaIn, vaOut: OleVariant;
begin
  WebBrowser.ControlInterface.ExecWB(OLECMDID_PAGESETUP, OLECMDEXECOPT_PROMPTUSER,
    vaIn, vaOut);
end;

procedure TTasHtmlEditor.SB_AlterarClick(Sender: TObject);
begin
  inherited;
 (WebBrowser.Document as IHTMLDocument2).designMode := 'On';
end;

procedure TTasHtmlEditor.Sb_btnBulletClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_MARCADOR_LISTA, 0);
end;

procedure TTasHtmlEditor.Sb_CorClick(Sender: TObject);
begin
   HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
   if cdColor.Execute then
      HTMLDocumento.execCommand('ForeColor', False, cdColor.Color)
   else
      abort;
end;

procedure TTasHtmlEditor.Sb_DesfazerClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_DESFAZER, 0);

end;

procedure TTasHtmlEditor.SB_GravarClick(Sender: TObject);
begin
  FConteudo := WebBrowser.OleObject.Document.documentElement.innerHTML;
  if ( FConteudo = '' ) or ( FConteudo = '<HEAD></HEAD>'#$D#$A'<BODY></BODY>') then
    FConteudo := '';
  Close;
end;

procedure TTasHtmlEditor.Sb_HiperlinkClick(Sender: TObject);
begin

   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_HYPERLINK, 0);
end;

procedure TTasHtmlEditor.Sb_ItalicoClick(Sender: TObject);
begin
  HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
  HTMLDocumento.execCommand('Italic', False, 0);
end;

procedure TTasHtmlEditor.Sb_LimparClick(Sender: TObject);
begin
  WebBrowser.Navigate('about:blank');
  FConteudo:= '';
end;

procedure TTasHtmlEditor.sb_negritoClick(Sender: TObject);
begin
  HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
  HTMLDocumento.execCommand('Bold', False, 0);

end;

procedure TTasHtmlEditor.Sb_NumListClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_MARCADOR, 0);
end;

procedure TTasHtmlEditor.SB_Sair_0Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TTasHtmlEditor.Sb_SublinhadoClick(Sender: TObject);
begin

  HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
  HTMLDocumento.execCommand('Underline', False, 0);
end;

procedure TTasHtmlEditor.setFConteudo(const Value: STring);
begin
  FConteudo := Value;
end;

procedure TTasHtmlEditor.ZoomPickButtonClick(Sender: TObject);
var
  vaIn, vaOut: OleVariant;
begin
  WebBrowser.ControlInterface.ExecWB(OLECMDID_PRINTPREVIEW,
    OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);
end;

end.

