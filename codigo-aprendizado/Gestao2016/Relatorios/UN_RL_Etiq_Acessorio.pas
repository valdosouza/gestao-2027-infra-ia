unit UN_RL_Etiq_Acessorio;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, QRExport, DB, STQuery, QRPrntr, QRAbout;

type
  TRL_Etiq_Acessorio = class(TForm)
    Etiqueta: TSTQuery;
    EtiquetaEXT_CODIGO: TIntegerField;
    EtiquetaEXT_CODTPE: TIntegerField;
    EtiquetaTPE_DESCRICAO: TStringField;
    EtiquetaEXT_DESCRICAO: TStringField;
    EtiquetaEXT_NUMERO: TStringField;
    EtiquetaEXT_RECARREGADO: TDateField;
    EtiquetaEXT_PRX_RECARGA: TDateField;
    EtiquetaEXT_VENC_RETESTE: TDateField;
    EtiquetaEXT_OBS: TStringField;
    EtiquetaEXT_LOTE: TStringField;
    EtiquetaEXT_QTDE: TIntegerField;
    EtiquetaEXT_TIPO_MED: TStringField;
    EtiquetaEXT_IMPRIME: TStringField;
    QRTextFilter1: TQRTextFilter;
    EtiquetaEXT_CODORD: TIntegerField;
    EtiquetaEXT_CODEMP: TIntegerField;
    EtiquetaEMP_NOME: TStringField;
    EtiquetaEND_ENDER: TStringField;
    EtiquetaEXT_CODPED: TIntegerField;
    EtiquetaEXT_DT_VISTORIA: TDateField;
    Qrpt: TQuickRep;
    QR_Etiqueta: TQRLoopBand;
    Lb_Ordem: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QR_EtiquetaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Etiqueta : Integer;
    It_Sequencia : Integer;
  end;

var
  RL_Etiq_Acessorio: TRL_Etiq_Acessorio;

implementation

uses     UN_Imp_Etiq_Extintores, Un_DM, Un_Funcoes, UN_Sistema, Un_Regra_Negocio;
{$R *.dfm}

procedure TRL_Etiq_Acessorio.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_I:Integer;
  Lc_Page:TQRPaperSize;
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
 It_Sequencia := 1;
 It_Etiqueta := 1;
  //Configura Etiqueta
  Pc_AtivaEstabelecimento;
 for Lc_Page:= Default to Custom do
    if QRPaperName(Lc_page) = Fr_Imp_Etiq_Extintores.Qr_Etiqueta.FieldByName('CGE_PAGESIZE').AsVariant then
       Qrpt.Page.PaperSize:=Lc_Page;
  Qr_etiqueta.Frame.DrawTop:=Fr_Imp_Etiq_Extintores.I_Grade;
  QR_Etiqueta.Frame.DrawBottom:=Fr_Imp_Etiq_Extintores.I_Grade;
  QR_Etiqueta.Frame.DrawLeft:=Fr_Imp_Etiq_Extintores.I_Grade;
  QR_Etiqueta.Frame.DrawRight:=Fr_Imp_Etiq_Extintores.I_Grade;


  Qrpt.Page.LeftMargin:=Fr_Imp_Etiq_Extintores.Qr_Etiqueta.FieldByName('CGE_DIREITA').AsFloat;
  Qrpt.Page.RightMargin:=Fr_Imp_Etiq_Extintores.Qr_Etiqueta.FieldByName('CGE_ESQUERA').AsFloat;

  Qrpt.Page.TopMargin:=Fr_Imp_Etiq_Extintores.Qr_Etiqueta.FieldByName('CGE_SUPERIOR').AsFloat;
  Qrpt.Page.Length:=Fr_Imp_Etiq_Extintores.Qr_Etiqueta.FieldByName('CGE_PG_ALTURA').AsFloat;
  Qrpt.Page.Width:=Fr_Imp_Etiq_Extintores.Qr_Etiqueta.FieldByName('CGE_PG_LARGURA').AsFloat;
  Qrpt.Page.BottomMargin:=Fr_Imp_Etiq_Extintores.Qr_Etiqueta.FieldByName('CGE_INFERIOR').AsFloat;

  Qrpt.Page.ColumnSpace:=Fr_Imp_Etiq_Extintores.Qr_Etiqueta.FieldByName('CGE_DIS_COLUNA').AsFloat;
  QR_Etiqueta.SIZE.Height:=Fr_Imp_Etiq_Extintores.Qr_Etiqueta.FieldByName('CGE_ET_ALTURA').Asfloat;
  QR_Etiqueta.Size.Width:=Fr_Imp_Etiq_Extintores.Qr_Etiqueta.FieldByName('CGE_ET_LARGURA').AsFloat;
  Qrpt.PrinterSettings.UseStandardprinter := True;
  Lb_Ordem.Font.Size := Fr_Imp_Etiq_Extintores.Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger;
  Lb_Ordem.Font.Name := Fr_Imp_Etiq_Extintores.Qr_Etiqueta.FieldByName('CGE_TYPEFONTE').AsString;

  //SA    Qr_Etiqueta.Items.Clear;
  Etiqueta.Active:=False;
  if Fr_Imp_Etiq_Extintores.CB_TipoEtiqueta.ItemIndex=0 then Etiqueta.ParamByName('TIPOETQ').AsString:='N';
  if Fr_Imp_Etiq_Extintores.CB_TipoEtiqueta.ItemIndex=1 then Etiqueta.ParamByName('TIPOETQ').AsString:='T';
  if Fr_Imp_Etiq_Extintores.CB_TipoEtiqueta.ItemIndex=2 then Etiqueta.ParamByName('TIPOETQ').AsString:='V';
  if Fr_Imp_Etiq_Extintores.CB_TipoEtiqueta.ItemIndex=3 then Etiqueta.ParamByName('TIPOETQ').AsString:='R';
  if Fr_Imp_Etiq_Extintores.CB_TipoEtiqueta.ItemIndex=5 then Etiqueta.ParamByName('TIPOETQ').AsString:='N';
  Etiqueta.Active:=True;
  Etiqueta.FetchAll;
  QR_Etiqueta.PrintCount := Etiqueta.RecordCount *3;
  Etiqueta.First;
  Fr_Imp_Etiq_Extintores.Tb_Venc_Extintor.First;

end;

procedure TRL_Etiq_Acessorio.QR_EtiquetaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_Ordem : String;
begin
  if It_Etiqueta < 3 then
    Begin
    Lb_Ordem.Caption := EtiquetaEXT_CODORD.AsString + '/' + StrZero(It_Sequencia,3,0);
    inc(It_Etiqueta);
    end
  else
    Begin
    Lb_Ordem.Caption := EtiquetaEXT_CODORD.AsString + '/' + StrZero(It_Sequencia,3,0);
    It_Etiqueta := 1;
    Lc_Ordem := EtiquetaEXT_CODORD.AsString;
    Etiqueta.Next;
    if (Lc_Ordem <> EtiquetaEXT_CODORD.AsString) then It_Sequencia :=1 else inc(It_Sequencia);
    end;

end;

procedure TRL_Etiq_Acessorio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  RL_Etiq_Acessorio.Destroy;
  RL_Etiq_Acessorio := nil;
end;

end.
