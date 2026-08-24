unit UN_RL_Fich_Colaborador;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, QuickRpt, QRCtrls;

type
  TRL_Fich_Colaborador = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    Lb_Dezembro: TQRLabel;
    Lb_Titulo: TQRLabel;
    QRLabel1: TQRLabel;
    Lb_Outubro: TQRLabel;
    Lb_Setembro: TQRLabel;
    Lb_Agosto: TQRLabel;
    Lb_Julho: TQRLabel;
    Lb_junho: TQRLabel;
    Lb_Maio: TQRLabel;
    Lb_Abril: TQRLabel;
    Lb_Marco: TQRLabel;
    Lb_Fevereiro: TQRLabel;
    Lb_Janeiro: TQRLabel;
    QRLabel15: TQRLabel;
    Lb_Novembro: TQRLabel;
    Detalhe: TQRBand;
    E_Dezembro: TQRLabel;
    E_Outubro: TQRLabel;
    E_Setembro: TQRLabel;
    E_Agosto: TQRLabel;
    E_Julho: TQRLabel;
    E_Junho: TQRLabel;
    E_Maio: TQRLabel;
    E_Abril: TQRLabel;
    E_Marco: TQRLabel;
    E_Fevereiro: TQRLabel;
    E_Janeiro: TQRLabel;
    E_DescricaoEvento: TQRLabel;
    E_Novembro: TQRLabel;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel2: TQRLabel;
    E_VL_Total: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QrptNeedData(Sender: TObject; var MoreData: Boolean);
  private
    { Private declarations }
    It_Detalhe: TQRBand;
    It_DescricaoEvento : TQRLabel;
    It_Janeiro : TQRLabel;
    It_Fevereiro : TQRLabel;
    It_Marco : TQRLabel;
    It_Abril : TQRLabel;
    It_Maio : TQRLabel;
    It_Junho : TQRLabel;
    It_Julho : TQRLabel;
    It_Agosto : TQRLabel;
    It_Setembro : TQRLabel;
    It_Outubro : TQRLabel;
    It_Novembro : TQRLabel;
    It_Dezembro : TQRLabel;
    It_Linha : Integer;
  public
    { Public declarations }
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;
  end;

var
  RL_Fich_Colaborador: TRL_Fich_Colaborador;

implementation

uses     UN_Sistema, UN_Fich_Colaborador, Grids;

{$R *.dfm}

procedure TRL_Fich_Colaborador.Pc_FormataTela;
Begin

end;

procedure TRL_Fich_Colaborador.Pc_IniciaVariaveis;
Begin
  with Fr_FichaColab do
    Begin
    Lb_Titulo.Caption := 'Ficha Financeira do Colaborador do Ano de ' + IntToStr(It_Ano) + ' - Nome do Colaborador: ' + It_Nm_Colaborador;
    end;  
  It_Linha := 1;
end;

procedure TRL_Fich_Colaborador.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Fich_Colaborador:=nil;
end;

procedure TRL_Fich_Colaborador.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_IniciaVariaveis;
end;

procedure TRL_Fich_Colaborador.QrptNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  with Fr_FichaColab.StrGrid_Mostra do
    Begin
    if Odd(It_Linha) then
      Detalhe.Color := cl3DLight
    else
      Detalhe.Color := clWhite;
    E_DescricaoEvento.Caption := Cells[0,It_Linha];
    E_Janeiro.Caption := Cells[1,It_Linha];
    E_Fevereiro.Caption := Cells[2,It_Linha];
    E_Marco.Caption := Cells[3,It_Linha];
    E_Abril.Caption := Cells[4,It_Linha];
    E_Maio.Caption := Cells[5,It_Linha];
    E_Junho.Caption := Cells[6,It_Linha];
    E_Julho.Caption := Cells[7,It_Linha];
    E_Agosto.Caption := Cells[8,It_Linha];
    E_Setembro.Caption := Cells[9,It_Linha];
    E_Outubro.Caption := Cells[10,It_Linha];
    E_Novembro.Caption := Cells[11,It_Linha];
    E_Dezembro.Caption := Cells[12,It_Linha];
    E_VL_Total.Caption := Cells[25,It_Linha];
    MoreData := not (It_Linha = (rowcount));
    It_Linha := It_Linha + 1;
    if MoreData then Next;
    end;
end;

end.
