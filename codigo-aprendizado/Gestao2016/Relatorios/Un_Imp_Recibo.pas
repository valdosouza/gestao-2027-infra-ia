unit Un_Imp_Recibo;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, StdCtrls, ExtCtrls, DBCtrls, IniFiles, Mask, DB, STQuery;

type

  TEdit = class(StdCtrls.TEdit)
  private
    { Private declarations }
    FAlignment: TAlignment;
    procedure SetAlignment(Value: TAlignment);

  protected
    { Protected declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property Alignment: TAlignment read FAlignment write SetAlignment
    default taLeftJustify;
  end;

  TFr_Imp_Recibo = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    SB_Sair: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    E_Data: TMaskEdit;
    E_Valor: TEdit;
    GBx_extenso: TGroupBox;
    E_Extenso: TMemo;
    E_Referente: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    E_Cedente: TMaskEdit;
    procedure SB_SairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure E_ValorExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Fr_Imp_Recibo: TFr_Imp_Recibo;

implementation

uses     UN_RL_Vendas_1, UN_RL_VendasDetalhada, UN_MSG, Un_Funcoes, Un_Excel, UN_DM, UN_Sistema;

{$R *.dfm}


constructor TEdit.Create(AOwner: TComponent);
begin
  FAlignment := taLeftJustify;
  inherited Create(AOwner);
end;

procedure TEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array [TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'EDIT');
  Params.Style := Params.Style and
    not (ES_AUTOVSCROLL or ES_AUTOHSCROLL) or ES_MULTILINE or
      Alignments[FAlignment];
end;





procedure TFr_Imp_Recibo.SB_SairClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Imp_Recibo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
//      VK_F2  : if Sb_Exportar.Enabled then Sb_ExportarClick(Sender);
//      VK_F3  : if SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
      VK_Escape : if SB_Sair.Enabled then SB_SairClick(Sender);
    end;
  end;
end;

procedure TFr_Imp_Recibo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  
end;

procedure TFr_Imp_Recibo.FormCreate(Sender: TObject);
begin

  E_Data.Text := DateToStr(Date);
  E_Extenso.Clear;
  E_Referente.Clear;
  E_Valor.Alignment:= TAlignment(1);
end;

procedure TFr_Imp_Recibo.E_ValorExit(Sender: TObject);
begin
  E_Valor.Text := FloatToStrF(StrToFloatDef(E_Valor.text,0),ffFixed,10,2);
  E_Extenso.Text := '(' + Fc_Extenso(StrToFloat(E_Valor.text)) + ')-x-x-x';
end;

end.
