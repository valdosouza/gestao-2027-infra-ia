unit UN_RL_Flh_Pagto;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, QuickRpt, QRCtrls, ExtCtrls;

type
  TRL_Flh_Pagto = class(TForm)
    Qrpt: TQuickRep;
    Cabecalho: TQRGroup;
    QRShape6: TQRShape;
    QRShape3: TQRShape;
    QRShape8: TQRShape;
    QRShape2: TQRShape;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel3: TQRLabel;
    Lb_Clb_Nome: TQRLabel;
    QRLabel33: TQRLabel;
    Lb_Referencia: TQRLabel;
    Rodape: TQRBand;
    Lb_TL_Vencimento: TQRLabel;
    Lb_TL_Desconto: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    Lb_TipoCob: TQRLabel;
    QRLabel1: TQRLabel;
    Lb_VL_Liquido: TQRLabel;
    Bd_DetalheStr: TQRStringsBand;
    QRShape9: TQRShape;
    QRShape5: TQRShape;
    QRShape4: TQRShape;
    QRShape10: TQRShape;
    Lb_Data: TQRLabel;
    Lb_Evento: TQRLabel;
    Lb_VL_Desconto: TQRLabel;
    Lb_VL_Vencimento: TQRLabel;
    Qr_Folha: TSTQuery;
    QRLabel2: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RodapeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Desconto : Real;
    It_Vencimento : Real;
    It_Codigo : Integer;
    It_Mes : Integer;
    It_Ano : Integer;
    Procedure PC_PreencheCampos;
    Procedure PC_VAlidaCampos(Pc_Print : Boolean);
    procedure Pc_Cabecalho;
    procedure Pc_Rodape;
  end;

var
  RL_Flh_Pagto: TRL_Flh_Pagto;

implementation

uses     UN_Sistema, Un_Principal, env;
{$R *.dfm}

Procedure TRL_Flh_Pagto.PC_VAlidaCampos(Pc_Print : Boolean);
Begin
  if Pc_Print then
    BEgin
    Lb_Data.Font.Color := clBlack;
    Lb_Evento.Font.Color := clBlack;
    Lb_VL_Desconto.Font.Color := clBlack;
    Lb_VL_Vencimento.Font.Color := clBlack;
    end
  else
    BEgin
    Lb_Data.Font.Color := clWhite;
    Lb_Evento.Font.Color := clWhite;
    Lb_VL_Desconto.Font.Color := clWhite;
    Lb_VL_Vencimento.Font.Color := clWhite;
    end;

end;

Procedure TRL_Flh_Pagto.PC_PreencheCampos;
Begin
  Lb_Data.Caption := Qr_Folha.FieldByName('FPT_DATA').AsString;
  Lb_Evento.Caption := Qr_Folha.FieldByName('FPT_HISTORICO').AsString;
  Lb_VL_Desconto.Caption := FloatToStrf(Qr_Folha.FieldByName('FPT_VL_DEBITO').AsCurrency,ffFixed,10,2);
  Lb_VL_Vencimento.Caption := FloatToStrf(Qr_Folha.FieldByName('FPT_VL_CREDITO').AsCurrency,ffFixed,10,2);
end;

procedure TRL_Flh_Pagto.Pc_Cabecalho;
begin
  Lb_Referencia.Caption := Qr_Folha.FieldByName('FPT_MES').AsString + '/' + Qr_Folha.FieldByName('FPT_ANO').AsString;
  Lb_Clb_Nome.Caption := Qr_Folha.FieldByName('CLB_NOME').AsString;
end;


procedure TRL_Flh_Pagto.Pc_Rodape;
begin
  Lb_TL_Desconto.Caption := FloatToStrF(It_Desconto,ffFixed,10,2);
  Lb_TL_Vencimento.Caption := FloattoStrf(It_Vencimento,ffFixed,10,2);
  Lb_VL_Liquido.Caption := FloattoStrf(It_Vencimento - It_Desconto,ffFixed,10,2);
end;

procedure TRL_Flh_Pagto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action := Cafree;
  RL_Flh_Pagto := nil;
end;

procedure TRL_Flh_Pagto.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_I : Integer;
  Lc_sqlTxt : String;
  Lc_Compartilha : Boolean;
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  It_Desconto := 0;
  It_Vencimento := 0;
  Lc_Compartilha := (Fc_Tb_Geral('L','PES_G_COMPARTILHA','S')= 'S');

  //MONTA SQL                                                              '+
  Lc_sqlTxt := 'SELECT *                                                   '+
               'FROM TB_FOLHAPAGTO Tb_flhpagto                             '+
               '    INNER JOIN TB_COLABORADOR tb_colaborador               '+
               '    ON (tb_colaborador.CLB_CODIGO = Tb_flhpagto.FPT_CODCLB)'+
               ' WHERE (FPT_CODCLB=:FPT_CODCLB) AND                        '+
               ' (FPT_MES=:FPT_MES) AND (FPT_ANO=:FPT_ANO)                 ';

  if Lc_Compartilha then Lc_sqlTxt := Lc_sqlTxt + ' AND (CLB_CODMHA=:CLB_CODMHA) ';



  //Pedido
  Qr_Folha.Active := False;
  Qr_Folha.ParamByName('FPT_CODCLB').AsInteger := It_Codigo;
  Qr_Folha.ParamByName('FPT_MES').AsInteger := It_MES;
  Qr_Folha.ParamByName('FPT_ANO').AsInteger := It_ANO;
  if Lc_Compartilha then
    Qr_Folha.ParamByName('CLB_CODMHA').AsInteger := Gb_CodMha;
  Qr_Folha.Active := True;
  Qr_Folha.FetchAll;
  Qr_Folha.First;


  if Qr_Folha.RecordCount >10 then
    Begin
    Bd_DetalheStr.Items.Clear;
    For Lc_I:= 1 to Qr_Folha.RecordCount do
      Bd_DetalheStr.Items.Add(IntTostr(Lc_I));
    end;
  Pc_Cabecalho;
end;

procedure TRL_Flh_Pagto.Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Not Qr_Folha.Eof then
    Begin
    It_Desconto := It_Desconto + Qr_Folha.FieldByName('FPT_VL_DEBITO').AsCurrency;
    It_Vencimento := It_Vencimento + Qr_Folha.FieldByName('FPT_VL_CREDITO').AsCurrency;
    pc_ValidaCampos(True);
    Pc_PreencheCAmpos;
    Qr_Folha.Next;
    end
  else
    pc_ValidaCampos(False);
end;

procedure TRL_Flh_Pagto.RodapeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_Rodape;
end;

end.
