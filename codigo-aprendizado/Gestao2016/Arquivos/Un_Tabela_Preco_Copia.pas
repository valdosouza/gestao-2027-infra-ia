unit Un_Tabela_Preco_Copia;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.Menus, Un_Fm_ListaTabelaPreco, Data.DB, STQuery;

type
  TFr_Tabela_Preco_Copia = class(TFr_Base)
    Panel1: TPanel;
    Fm_ListaTabelaPreco: TFm_ListaTabelaPreco;
    Rg_Tipo: TRadioGroup;
    Label4: TLabel;
    E_Aliquota: TMaskEdit;
    Button1: TButton;
    Button2: TButton;
    STQuery1: TSTQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure Copiar;
  protected
    procedure IniciaVariaveis;Override;
  public
    { Public declarations }
  end;

var
  Fr_Tabela_Preco_Copia: TFr_Tabela_Preco_Copia;

implementation

{$R *.dfm}

{ TFr_Tabela_Preco_Copia }

procedure TFr_Tabela_Preco_Copia.Button1Click(Sender: TObject);
begin
  inherited;
  Copiar;
end;

procedure TFr_Tabela_Preco_Copia.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFr_Tabela_Preco_Copia.Copiar;
begin
  ModalResult := mrOk;
end;

procedure TFr_Tabela_Preco_Copia.IniciaVariaveis;
begin
  inherited;

end;

end.
