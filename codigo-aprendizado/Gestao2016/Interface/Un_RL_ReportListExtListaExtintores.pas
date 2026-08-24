unit Un_RL_ReportListExtListaExtintores;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportList, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportListExtListaExtintores = class(TRL_ReportList)
    QRMemo10: TQRMemo;
    QRMemo9: TQRMemo;
    QRMemo8: TQRMemo;
    QRMemo7: TQRMemo;
    QRMemo6: TQRMemo;
    QRMemo5: TQRMemo;
    QRMemo4: TQRMemo;
    QRMemo2: TQRMemo;
    QRMemo1: TQRMemo;
    QRMemo11: TQRMemo;
    QRMemo3: TQRMemo;
    QRBand1: TQRBand;
    E_Ext_Cliente: TQRMemo;
    E_Ext_Carga: TQRMemo;
    E_Ext_Tipo: TQRMemo;
    E_Ext_Serie: TQRMemo;
    E_Ext_Marca: TQRMemo;
    E_Mnt_Selo: TQRMemo;
    E_Mnt_Dt_Carga: TQRMemo;
    E_Mnt_Ensaio: TQRMemo;
    E_Ext_Numero: TQRMemo;
    E_Ext_Ano: TQRMemo;
    E_Ext_Localizacao: TQRMemo;
    procedure Buscar; Override;
    procedure IncrementarSQl; Override;
    procedure PassarParametros; Override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RL_ReportListExtListaExtintores: TRL_ReportListExtListaExtintores;

implementation

{$R *.dfm}

{ TRL_ReportList1 }

procedure TRL_ReportListExtListaExtintores.Buscar;
begin
  inherited;
  //
end;

procedure TRL_ReportListExtListaExtintores.IncrementarSQl;
begin
  inherited;
  //
end;

procedure TRL_ReportListExtListaExtintores.PassarParametros;
begin
  inherited;
  //
end;

end.
