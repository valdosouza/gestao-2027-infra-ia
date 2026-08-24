unit Un_Navegador;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Menus, StdCtrls, ComCtrls, ToolWin, OleCtrls, SHDocVw, pngextra, pngimage, ExtCtrls, frxClass;

type
  TFr_Navegador = class(TForm)
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    mNovaJanela: TMenuItem;
    Abrir1: TMenuItem;
    SalvarComo1: TMenuItem;
    N1: TMenuItem;
    Imprimir1: TMenuItem;
    VisualizarImpresso1: TMenuItem;
    ConfigurarPgina1: TMenuItem;
    mConfigurarBrowser: TMenuItem;
    mPadrao: TMenuItem;
    mFABaixo: TMenuItem;
    N2: TMenuItem;
    Propriedades1: TMenuItem;
    N3: TMenuItem;
    Sair1: TMenuItem;
    Editar1: TMenuItem;
    Recortar1: TMenuItem;
    Copiar1: TMenuItem;
    Colar1: TMenuItem;
    N4: TMenuItem;
    LocalizaNestaPgina1: TMenuItem;
    OpenDialog1: TOpenDialog;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    URLs: TComboBox;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Panel1: TPanel;
    Image1: TImage;
    Page: TPageControl;
    Tbs_Page1: TTabSheet;
    WebBrowser1: TWebBrowser;
    procedure mNovaJanelaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_Navegador: TFr_Navegador;

implementation

{$R *.dfm}

procedure TFr_Navegador.mNovaJanelaClick(Sender: TObject);
begin
  Page.
end;

end.
