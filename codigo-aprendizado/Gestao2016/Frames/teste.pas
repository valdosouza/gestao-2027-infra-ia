unit teste;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Un_Fm_MetodoPagamento, Vcl.Mask, QEdit_Setes, Vcl.ExtCtrls;

type
  TFr_Testes = class(TForm)
    Pnl_FormaPagto: TPanel;
    Grp_Pagamento: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    LB_TL_RECEBIDO: TLabel;
    Label1: TLabel;
    E_Vl_Pagar: TEdit_Setes;
    E_VL_Troco: TEdit_Setes;
    e_vl_recebido: TEdit_Setes;
    E_VL_Total: TEdit_Setes;
    Panel2: TPanel;
    Button1: TButton;
    E_Cd_FormaPagto: TEdit;
    E_Descricao: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
    procedure Pc_CriarFrame();
  public
    { Public declarations }
    It_DescricaoFPagto : TStringList;
    It_CodigoFPagto : TStringList;
  end;

var
  Fr_Testes: TFr_Testes;
  Frame :TFm_MetodoPagamento;
implementation

{$R *.dfm}

uses     Un_Regra_Negocio, Un_DM;

procedure TFr_Testes.Pc_CriarFrame();
Var
  Lc_Indice : Integer;
begin
  Lc_Indice := It_CodigoFPagto.Count - 1;

  Frame := TFm_MetodoPagamento.Create(Self);
  with Frame do
  begin
    Parent := Pnl_FormaPagto;
    Name := 'Fm_' + It_CodigoFPagto[Lc_Indice];
    Fm_FormaPagto.Lb_FormaPagamento.Caption := It_DescricaoFPagto[Lc_Indice] + 'º - Forma de Pagamento';
    Top := 0 + (74 * (It_CodigoFPagto.Count - 1));
    Left := 3;
    Height := 74;
    Width := 526;
    Fm_FormaPagto.Pc_Listar(3,false,0);
  end;
  Height := (74 * (It_CodigoFPagto.Count )) + Grp_Pagamento.Height + Panel2.Height + 41;
//  Pnl_FormaPagto.Height := (105 * (It_CodigoFPagto.Count ));

  repaint;
end;

procedure TFr_Testes.Button2Click(Sender: TObject);
Var
  Lc_Edit: TEdit;
  variavel : TComponent;
begin
  variavel := findcomponent('Fm_1');
  Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
  ShowMessage(Lc_Edit.Text);
end;

procedure TFr_Testes.Button3Click(Sender: TObject);
Var
  Lc_Edit: TEdit;
  variavel : TComponent;
begin
  variavel := findcomponent('Fm_2');
  Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
  ShowMessage(Lc_Edit.Text);

end;

procedure TFr_Testes.Button4Click(Sender: TObject);
Var
  Lc_Edit: TEdit;
  variavel : TComponent;
begin
  variavel := findcomponent('Fm_3');
  Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
  ShowMessage(Lc_Edit.Text);

end;

procedure TFr_Testes.Button5Click(Sender: TObject);
Var
  Lc_Edit: TEdit;
  variavel : TComponent;
  I :Integer;
  Lc_Texto : String;
begin
  Lc_Texto := '';
  for I := 0 to It_CodigoFPagto.Count - 1 do
  Begin
    variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
    Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
    Lc_Texto := Lc_Texto + It_CodigoFPagto[I] + ' - ' + It_DescricaoFPagto[I]  + ' - ' + Lc_Edit.Text + #13;

  End;
  ShowMessage(Lc_Texto);
end;

procedure TFr_Testes.Button6Click(Sender: TObject);
begin
  ShowMessage(IntToStr(Pnl_FormaPagto.Height))
end;

procedure TFr_Testes.Button7Click(Sender: TObject);
begin
  ShowMessage(IntToStr(Height))
end;

procedure TFr_Testes.FormCreate(Sender: TObject);
begin
  It_DescricaoFPagto := TStringList.Create;
  It_CodigoFPagto := TStringList.Create;
end;

end.
