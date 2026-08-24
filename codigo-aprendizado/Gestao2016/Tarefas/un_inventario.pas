unit un_inventario;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Un_Fm_ListaEstoques, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Samples.Gauges, ControllerInventario;

type
  TFr_Inventario = class(TFr_Base)
    Panel3: TPanel;
    Label1: TLabel;
    E_Data: TDateTimePicker;
    Fm_ListaEstoques: TFm_ListaEstoques;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    pnl_botao: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    Pnl_Progresso: TPanel;
    Gg_Progresso: TGauge;
    Lb_Processamento: TLabel;
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
  private
    { Private declarations }
    function  ValidaInventario:boolean;
    procedure ProcesssaInventario;

  protected
    procedure ImagemBotao;override;
    procedure CriarVariaveis;override;
    procedure IniciaVariaveis;override;
  public
    { Public declarations }
    Inventario : TControllerInventario;
  end;

var
  Fr_Inventario: TFr_Inventario;

implementation

{$R *.dfm}

uses     UN_Principal, env;

{ TFr_Base1 }



{ TFr_Base1 }

procedure TFr_Inventario.CriarVariaveis;
begin
  inherited;
  Inventario := TControllerInventario.Create(self);
end;

procedure TFr_Inventario.ImagemBotao;
begin
  CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
  CarregaImagemBotao(SB_Sair_0,'SAIR');

end;

procedure TFr_Inventario.IniciaVariaveis;
begin
  inherited;
  Fm_ListaEstoques.AtivaLista(gb_codmha);
end;

procedure TFr_Inventario.ProcesssaInventario;
Var
  I : Integer;
  Lc_Saldo : Real;
begin
  Try
    Inventario.Produto.Registro.Tipo := 'P';
    Inventario.Produto.getList('');
    Pnl_Progresso.Visible := True;
    Gg_Progresso.MinValue := 0;
    Gg_Progresso.MaxValue := Inventario.Produto.Lista.Count;
    Gg_Progresso.Progress := 0;
    Application.ProcessMessages;
    for I := 0 to Inventario.Produto.Lista.Count -1 do
    Begin
      Lb_Processamento.caption := concat('Calculando saldo do produto ', Inventario.Produto.Lista[I].descricao);
      Application.ProcessMessages;
      inventario.DataInicial      := E_Data_Ini.DateTime;
      inventario.DataFinal        := E_Data_Fim.DateTime;
      inventario.CodigoEstoque          := Fm_ListaEstoques.Dblcb_Estoque.KeyValue;
      inventario.CodigoProduto    := Inventario.Produto.Lista[I].Codigo;
      inventario.Estabelecimento  := Gb_CodMha;
      Lc_Saldo := inventario.recontar;
      if inventario.CodigoProduto = 214 then
        Lb_Processamento.caption := '';
      Lc_Saldo := Lc_Saldo + inventario.GetUltimoSaldo;

      inventario.clear;
      inventario.Registro.Codigo          := 0;
      inventario.Registro.Data            := E_Data.Date;
      inventario.Registro.Produto         := Inventario.Produto.Lista[I].Codigo;
      inventario.Registro.QtdeAtual       := Lc_Saldo;
      inventario.Registro.Estabelecimento := Gb_CodMha;
      inventario.Registro.Estoque         := Fm_ListaEstoques.Dblcb_Estoque.KeyValue;
      inventario.Registro.QtdeAutomatica  := Lc_Saldo;
      inventario.salva;
      Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
      Application.ProcessMessages;
    End;
  Finally
    Pnl_Progresso.Visible := False;
  End;
end;

procedure TFr_Inventario.SB_ConfirmarClick(Sender: TObject);
begin
  if ValidaInventario then
    ProcesssaInventario;
end;

procedure TFr_Inventario.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

function TFr_Inventario.ValidaInventario: boolean;
begin
  Result := True;
end;

end.
