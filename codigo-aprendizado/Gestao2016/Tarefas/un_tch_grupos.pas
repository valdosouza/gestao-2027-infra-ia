unit un_tch_grupos;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Buttons;

type
  TFr_tch_grupos = class(TFr_Base)
    ScrollBox1: TScrollBox;
    Panel1: TPanel;
    Panel2: TPanel;
    img_sonho: TImage;
    Panel3: TPanel;
    img_donuts: TImage;
    Panel4: TPanel;
    img_roscas: TImage;
    Panel5: TPanel;
    img_combos: TImage;
    Panel6: TPanel;
    img_alfajor: TImage;
    Panel7: TPanel;
    img_bebidas: TImage;
    Panel8: TPanel;
    img_diversos: TImage;
    Sb_Cancelar: TSpeedButton;
    procedure Sb_CancelarClick(Sender: TObject);
    procedure img_sonhoClick(Sender: TObject);
    procedure img_combosClick(Sender: TObject);
    procedure img_donutsClick(Sender: TObject);
    procedure img_roscasClick(Sender: TObject);
    procedure img_alfajorClick(Sender: TObject);
    procedure img_diversosClick(Sender: TObject);
    procedure img_bebidasClick(Sender: TObject);
  private
    { Private declarations }
    procedure openTouchProdutos(Subgrupo:Integer) ;
  public
    { Public declarations }
    ConfirmInsert : Boolean;
  end;

var
  Fr_tch_grupos: TFr_tch_grupos;

implementation

uses     un_tch_produtos;

{$R *.dfm}

procedure TFr_tch_grupos.img_alfajorClick(Sender: TObject);
begin
  inherited;
  openTouchProdutos(3);
end;

procedure TFr_tch_grupos.img_bebidasClick(Sender: TObject);
begin
  inherited;
  openTouchProdutos(8);
end;

procedure TFr_tch_grupos.img_combosClick(Sender: TObject);
begin
  inherited;
  openTouchProdutos(7);
end;

procedure TFr_tch_grupos.img_diversosClick(Sender: TObject);
begin
  inherited;
  openTouchProdutos(5);
end;

procedure TFr_tch_grupos.img_donutsClick(Sender: TObject);
begin
  inherited;
  openTouchProdutos(2);
end;

procedure TFr_tch_grupos.img_roscasClick(Sender: TObject);
begin
  inherited;
  openTouchProdutos(4);
end;

procedure TFr_tch_grupos.img_sonhoClick(Sender: TObject);
begin
  inherited;
  openTouchProdutos(1);
end;

procedure TFr_tch_grupos.openTouchProdutos(Subgrupo: Integer);
Var
  Lc_Form : TFr_tch_produtos;
begin
  Try
    Lc_Form := TFr_tch_produtos.create(Self);
    Lc_Form.SubGrupo := Subgrupo;
    Self.Hide;
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
    Self.Close;
  End;
end;

procedure TFr_tch_grupos.Sb_CancelarClick(Sender: TObject);
begin
  Close;
end;

end.
