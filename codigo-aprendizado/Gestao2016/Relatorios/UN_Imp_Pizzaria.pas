unit UN_Imp_Pizzaria;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ComCtrls, Vcl.Mask, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Samples.Gauges, Vcl.ExtCtrls, PrintPizzaria;

type
  TFr_Imp_Pizzaria = class(TForm)
    Panel1: TPanel;
    Label4: TLabel;
    LBx_TipoRelatorio: TListBox;
    Pnl_Parametro: TPanel;
    ChBx_Periodo: TCheckBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_ImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure ImagemBotao;
    procedure IniciaVariaveis;
  public
    { Public declarations }
    procedure VendaDetalhada;
    procedure VendaPorGRupo;
    procedure VendaPorTamanhoPizzaCalzone;
    procedure VendaPorTamanhoBorda;
    procedure VendaPorGrupoMassa;
    procedure VendaPorGrupoBebidas;


  end;

var
  Fr_Imp_Pizzaria: TFr_Imp_Pizzaria;

implementation

{$R *.dfm}

uses     UN_Sistema, Un_DM, Un_Regra_Negocio, UN_Principal, env;

procedure TFr_Imp_Pizzaria.FormShow(Sender: TObject);
begin
  ImagemBotao;
  IniciaVariaveis;

end;

procedure TFr_Imp_Pizzaria.ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    Sb_Exportar.Glyph.Assign(Fc_CarregaImagemBotao('EXPORTAR'));
    SB_Imprimir.Glyph.Assign(Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Imp_Pizzaria.IniciaVariaveis;
Begin
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
  LBx_TipoRelatorio.ItemIndex := 0;
End;

procedure TFr_Imp_Pizzaria.VendaDetalhada;
Var
  Lc_Imp : TPrintPizzaria;
begin
  Try
    Lc_Imp := TPrintPizzaria.Create(nil);
    with Lc_Imp do
    Begin
      Periodo := ChBx_Periodo.Checked;
      DataInicial := E_Data_Ini.DateTime;
      DataFinal   := E_Data_Fim.DateTime;
      NomeEstabelecimento := DM.Qr_Estabelecimento.FieldByNAme('EMP_FANTASIA').AsString;
      FoneEstabelecimento := DM.Qr_Estabelecimento.FieldByNAme('END_FONE').AsString;
      NomeUsuario := GB_Nm_Usuario;
      PrintVendaDetalhada;
    end;
  Finally
    FreeAndNil(Lc_Imp);
  End;
End;

procedure TFr_Imp_Pizzaria.VendaPorGrupoBebidas;
Var
  Lc_Imp : TPrintPizzaria;
begin
  Try
    Lc_Imp := TPrintPizzaria.Create(nil);
    with Lc_Imp do
    Begin
      Periodo := ChBx_Periodo.Checked;
      DataInicial := E_Data_Ini.DateTime;
      DataFinal   := E_Data_Fim.DateTime;
      NomeEstabelecimento := DM.Qr_Estabelecimento.FieldByNAme('EMP_FANTASIA').AsString;
      FoneEstabelecimento := DM.Qr_Estabelecimento.FieldByNAme('END_FONE').AsString;
      NomeUsuario := GB_Nm_Usuario;
      PrintVendaPorGrupoBebidas;
    end;
  Finally
    FreeAndNil(Lc_Imp);
  End;

end;

procedure TFr_Imp_Pizzaria.VendaPorGRupo;
Var
  Lc_Imp : TPrintPizzaria;
begin
  Try
    Lc_Imp := TPrintPizzaria.Create(nil);
    with Lc_Imp do
    Begin
      Periodo := ChBx_Periodo.Checked;
      DataInicial := E_Data_Ini.DateTime;
      DataFinal   := E_Data_Fim.DateTime;
      NomeEstabelecimento := DM.Qr_Estabelecimento.FieldByNAme('EMP_FANTASIA').AsString;
      FoneEstabelecimento := DM.Qr_Estabelecimento.FieldByNAme('END_FONE').AsString;
      NomeUsuario := GB_Nm_Usuario;
      PrintVendaPorGrupo;
    end;
  Finally
    FreeAndNil(Lc_Imp);
  End;
End;

procedure TFr_Imp_Pizzaria.VendaPorGrupoMassa;
Var
  Lc_Imp : TPrintPizzaria;
begin
  Try
    Lc_Imp := TPrintPizzaria.Create(nil);
    with Lc_Imp do
    Begin
      Periodo := ChBx_Periodo.Checked;
      DataInicial := E_Data_Ini.DateTime;
      DataFinal   := E_Data_Fim.DateTime;
      NomeEstabelecimento := DM.Qr_Estabelecimento.FieldByNAme('EMP_FANTASIA').AsString;
      FoneEstabelecimento := DM.Qr_Estabelecimento.FieldByNAme('END_FONE').AsString;
      NomeUsuario := GB_Nm_Usuario;
      PrintVendaPorGrupoMassa;
    end;
  Finally
    FreeAndNil(Lc_Imp);
  End;

end;

procedure TFr_Imp_Pizzaria.VendaPorTamanhoBorda;
Var
  Lc_Imp : TPrintPizzaria;
begin
  Try
    Lc_Imp := TPrintPizzaria.Create(nil);
    with Lc_Imp do
    Begin
      Periodo := ChBx_Periodo.Checked;
      DataInicial := E_Data_Ini.DateTime;
      DataFinal   := E_Data_Fim.DateTime;
      NomeEstabelecimento := DM.Qr_Estabelecimento.FieldByNAme('EMP_FANTASIA').AsString;
      FoneEstabelecimento := DM.Qr_Estabelecimento.FieldByNAme('END_FONE').AsString;
      NomeUsuario := GB_Nm_Usuario;
      PrintVendaPorTamanhoBorda;
    end;
  Finally
    FreeAndNil(Lc_Imp);
  End;

end;

procedure TFr_Imp_Pizzaria.VendaPorTamanhoPizzaCalzone;
Var
  Lc_Imp : TPrintPizzaria;
begin
  Try
    Lc_Imp := TPrintPizzaria.Create(nil);
    with Lc_Imp do
    Begin
      Periodo := ChBx_Periodo.Checked;
      DataInicial := E_Data_Ini.DateTime;
      DataFinal   := E_Data_Fim.DateTime;
      NomeEstabelecimento := DM.Qr_Estabelecimento.FieldByNAme('EMP_FANTASIA').AsString;
      FoneEstabelecimento := DM.Qr_Estabelecimento.FieldByNAme('END_FONE').AsString;
      NomeUsuario := GB_Nm_Usuario;
      PrintVendaPorTamanhoPizzaCalzone;
    end;
  Finally
    FreeAndNil(Lc_Imp);
  End;
End;

procedure TFr_Imp_Pizzaria.SB_ImprimirClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Self.KeyPreview := False;
    Pc_AtivaEstabelecimento;
    case LBx_TipoRelatorio.ItemIndex of
      0:VendaDetalhada;
      1:VendaPorGRupo;
      2:VendaPorTamanhoPizzaCalzone;
      3:VendaPorTamanhoBorda;
      4:VendaPorGrupoMassa;
      5:VendaPorGrupoBebidas;
      end;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
    Self.KeyPreview := True;
  end;
end;

procedure TFr_Imp_Pizzaria.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

end.
