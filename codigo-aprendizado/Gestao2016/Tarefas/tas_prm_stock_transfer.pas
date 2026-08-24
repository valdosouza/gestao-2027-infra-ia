unit tas_prm_stock_transfer;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Fm_ListaEmpresas, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TTasPrmStockTransfer = class(TForm)
    pnl_EmitenteDestinatario: TPanel;
    Fm_ListaEmitenteDestinatario: TFm_ListaEmpresas;
    pnl_Message: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Pnl_Botton: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    SB_Buscar: TSpeedButton;
    Label8: TLabel;
    procedure SB_BuscarClick(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function validaEmitente:Boolean;
    procedure IniciaVariaveis;
  public
    { Public declarations }
    escolha : Integer;
  end;

var
  TasPrmStockTransfer: TTasPrmStockTransfer;

implementation

uses     Un_Msg, env;

{$R *.dfm}

procedure TTasPrmStockTransfer.FormShow(Sender: TObject);
begin
  IniciaVariaveis;
end;

procedure TTasPrmStockTransfer.IniciaVariaveis;
begin
  Fm_ListaEmitenteDestinatario.Pc_AtivaEmpresa(-1);
end;

procedure TTasPrmStockTransfer.SB_BuscarClick(Sender: TObject);
begin
  if validaEmitente then
  Begin
    Escolha := 1;
    Close;
  End;
end;

procedure TTasPrmStockTransfer.SB_ConfirmarClick(Sender: TObject);
begin
  if validaEmitente then
  Begin
    Escolha := 2;
    Close;
  End;end;

procedure TTasPrmStockTransfer.SB_Sair_0Click(Sender: TObject);
begin
  Escolha := 0;
  Close;
end;

function TTasPrmStockTransfer.validaEmitente: Boolean;
begin
  Result := true;
  If (TRIM(Fm_ListaEmitenteDestinatario.DBLCB_Empresa.Text) ='') then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Preenchimento do Campo Emitente/Destinatário é obrigatório.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
  end;

end;

end.
