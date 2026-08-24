unit Un_RL_Crm;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, ExtCtrls, DB, STQuery, jpeg, QRCtrls;

type
  TRL_Crm = class(TForm)
    Qrpt: TQuickRep;
    PageHeaderBand1: TQRBand;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    Qr_Faturamento: TSTQuery;
    QRBand1: TQRBand;
    Lb_VL_Tl_Empresa: TQRLabel;
    Lb_Periodo: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    Lb_VL_Periodo_1: TQRLabel;
    Lb_VL_Periodo_2: TQRLabel;
    Lb_VL_Periodo_3: TQRLabel;
    Lb_VL_Periodo_4: TQRLabel;
    Lb_VL_Periodo_5: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    Lb_Qt_Periodo_1: TQRLabel;
    Lb_Qt_Periodo_2: TQRLabel;
    Lb_Qt_Periodo_3: TQRLabel;
    Lb_Qt_Periodo_4: TQRLabel;
    Lb_Qt_Periodo_5: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    Im_Grande: TQRImage;
    Im_1: TQRImage;
    Im_2: TQRImage;
    Im_3: TQRImage;
    Im_4: TQRImage;
    Im_5: TQRImage;
    QRLabel45: TQRLabel;
    QRLabel46: TQRLabel;
    QRLabel47: TQRLabel;
    QRLabel48: TQRLabel;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    Lb_VL_Medio_1: TQRLabel;
    Lb_VL_Medio_2: TQRLabel;
    Lb_VL_Medio_3: TQRLabel;
    Lb_VL_Medio_4: TQRLabel;
    Lb_VL_Medio_5: TQRLabel;
    Lb_Vl_Geral: TQRLabel;
    Lb_Vl_Medio: TQRLabel;
    Lb_Maior: TQRLabel;
    Lb_Menor: TQRLabel;
    Lb_Estrela_1: TQRLabel;
    Lb_Estrela_2: TQRLabel;
    Lb_Estrela_3: TQRLabel;
    Lb_Estrela_4: TQRLabel;
    Lb_Estrela_5: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pc_MontaGrafico(Pc_Obj:TQrimage ; Pc_R1 : Real; Pc_R2 : Real; Pc_R3 : Real; Pc_R4 : Real; Pc_R5 : Real);
    procedure DrawHand (Pc_Obj:TQrimage;XCenter, YCenter, Radius,
    BackRadius: Integer; Angle: Real);
    function Fc_MaiorVenda():Real;
    function Fc_MenorVenda():Real;
    function Fc_VendaMedia(Pc_Vl_Min : Real; Pc_Vl_Max : Real):Real;

  end;

var
  RL_Crm: TRL_Crm;

implementation

uses     Un_DM, Un_Crm, UN_Sistema;
{$R *.dfm}




function TRL_Crm.Fc_MaiorVenda():Real;
Var
  Lc_Venda: TSTQuery;
  Lc_SqlTxt : String;
BEgin
  Screen.Cursor:=crHourGlass;
  Lc_Venda := TSTQuery.Create(Self);
  Lc_Venda.Database := DM.IBD_Gestao;
  Lc_Venda.Transaction := DM.IB_Transacao;
  Lc_Venda.SQL.Clear;

  Lc_SqlTxt := 'SELECT MAX(NFL_VL_TL_NOTA) as NFL_TOTAL '+
            'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
            '    INNER JOIN TB_PEDIDO tb_pedido '+
            '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
            'WHERE (NFL_CODIGO IS NOT NULL) AND (NFL_TIPO = ''SI'') AND (PED_TIPO = 1) '+
            'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';

  Lc_Venda.SQL.Add(Lc_SqlTxt);
  Lc_Venda.ParamByName('DATAINI').AsDate:=FR_CRM.E_DataIni.Date;
  Lc_Venda.ParamByName('DATAFIM').AsDate:=FR_CRM.E_DataFim.Date;
  Lc_Venda.Active := True;
  Lc_Venda.First;
  Screen.Cursor:=crDefault;

  Result := Lc_Venda.FieldByName('NFL_TOTAL').AsCurrency;
  Lc_Venda.Destroy;
  Lc_Venda := nil;
end;

function TRL_Crm.Fc_MenorVenda():Real;
Var
  Lc_Venda: TSTQuery;
  Lc_SqlTxt : String;
BEgin
  Screen.Cursor:=crHourGlass;
  Lc_Venda := TSTQuery.Create(Self);
  Lc_Venda.Database := DM.IBD_Gestao;
  Lc_Venda.Transaction := DM.IB_Transacao;
  Lc_Venda.SQL.Clear;

  Lc_SqlTxt := 'SELECT MIN(NFL_VL_TL_NOTA) as NFL_TOTAL '+
            'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
            '    INNER JOIN TB_PEDIDO tb_pedido '+
            '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
            'WHERE (NFL_CODIGO IS NOT NULL) AND (NFL_TIPO = ''SI'') AND (PED_TIPO = 1) '+
            'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';

  Lc_Venda.SQL.Add(Lc_SqlTxt);
  Lc_Venda.ParamByName('DATAINI').AsDate:=FR_CRM.E_DataIni.Date;
  Lc_Venda.ParamByName('DATAFIM').AsDate:=FR_CRM.E_DataFim.Date;
  Lc_Venda.Active := True;
  Lc_Venda.First;
  Screen.Cursor:=crDefault;

  Result := Lc_Venda.FieldByName('NFL_TOTAL').AsCurrency;
  Lc_Venda.Destroy;
  Lc_Venda := nil;

end;

function TRL_Crm.Fc_VendaMedia(Pc_Vl_Min : Real; Pc_Vl_Max : Real):Real;
Var
  Lc_Venda: TSTQuery;
  Lc_SqlTxt : String;
BEgin
  Screen.Cursor:=crHourGlass;
  Lc_Venda := TSTQuery.Create(Self);
  Lc_Venda.Database := DM.IBD_Gestao;
  Lc_Venda.Transaction := DM.IB_Transacao;
  Lc_Venda.SQL.Clear;

  Lc_SqlTxt := 'SELECT AVG(NFL_VL_TL_NOTA) as NFL_TOTAL '+
            'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
            '    INNER JOIN TB_PEDIDO tb_pedido '+
            '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
            'WHERE (NFL_CODIGO IS NOT NULL) AND (NFL_TIPO = ''SI'') AND (PED_TIPO = 1) '+
            'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  '+
            'AND (NFL_VL_TL_NOTA BETWEEN :VL_MIN AND :VL_MAX)  ';

  Lc_Venda.SQL.Add(Lc_SqlTxt);
  Lc_Venda.ParamByName('DATAINI').AsDate:=FR_CRM.E_DataIni.Date;
  Lc_Venda.ParamByName('DATAFIM').AsDate:=FR_CRM.E_DataFim.Date;
  Lc_Venda.ParamByName('VL_MIN').AsCurrency := Pc_Vl_Min;
  Lc_Venda.ParamByName('VL_MAX').AsCurrency := Pc_Vl_Max;
  Lc_Venda.Active := True;
  Lc_Venda.First;
  Screen.Cursor:=crDefault;

  Result := Lc_Venda.FieldByName('NFL_TOTAL').AsCurrency;
  Lc_Venda.Destroy;
  Lc_Venda := nil;

end;

procedure TRL_Crm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Crm :=nil;
end;


procedure TRL_Crm.FormCreate(Sender: TObject);
Var
  Lc_RG : TRect;
  Lc_RP : TRect;
begin
  Lc_RG := Im_Grande.Canvas.ClipRect;
  Lc_RP := Im_1.Canvas.ClipRect;
  Im_Grande.Canvas.pie(Lc_RG.Left,Lc_RG.Top,Lc_RG.Right,Lc_RG.Bottom,100,90,90,100);

  Im_1.Canvas.Brush.Color := clGray;
  Im_1.Canvas.Rectangle(Lc_RP);
  Im_2.Canvas.Brush.Color := clBlue;
  Im_2.Canvas.Rectangle(Lc_RP);
  Im_3.Canvas.Brush.Color := clGreen;
  Im_3.Canvas.Rectangle(Lc_RP);
  Im_4.Canvas.Brush.Color := clAqua;
  Im_4.Canvas.Rectangle(Lc_RP);
  Im_5.Canvas.Brush.Color := clRed;
  Im_5.Canvas.Rectangle(Lc_RP);
end;

procedure TRL_Crm.DrawHand (Pc_Obj:TQrimage;XCenter, YCenter,
Radius, BackRadius: Integer; Angle: Real);
begin
  with Pc_Obj do
    Begin
    Angle := (Angle + 3*Pi/2);
    Canvas.MoveTo (
    XCenter - Round (BackRadius * Cos (Angle)),
    YCenter - Round (BackRadius * Sin (Angle)));
    Canvas.LineTo (
    XCenter + Round (Radius * Cos (Angle)),
    YCenter + Round (Radius * Sin (Angle)));
    end;
end;


procedure TRL_Crm.Pc_MontaGrafico(Pc_Obj:TQrimage ;Pc_R1 : Real; Pc_R2 : Real; Pc_R3 : Real; Pc_R4 : Real; Pc_R5 : Real);
var
  Lc_Angle: Real;
  Lc_I : Integer;
  Lc_R1,Lc_R2,Lc_R3,Lc_R4,Lc_R5 : integer;
  Lc_Total : REal;
  Lc_XCenter, Lc_YCenter, Lc_Radius: Integer;
begin
  {calcula os Resultados}
  Lc_Total := Pc_R1 + Pc_R2 + Pc_R3 + Pc_R4 + Pc_R5;
  Lc_R1:= Round(((Pc_R1/ Lc_Total) * 60) );
  Lc_R2:= Round(((Pc_R2/ Lc_Total) * 60) );
  Lc_R3:= Round(((Pc_R3/ Lc_Total) * 60) );
  Lc_R4:= Round(((Pc_R4/ Lc_Total) * 60) );
  Lc_R5:= Round(((Pc_R5/ Lc_Total) * 60) );

  {calcula o centro do formulário}
  Lc_XCenter := Pc_Obj.Width div 2;
  Lc_YCenter := Pc_Obj.Height div 2;
  if Lc_XCenter > Lc_YCenter then
    Lc_Radius := Lc_YCenter
  else
    Lc_Radius := Lc_XCenter;

  //lEGENDA

  Lb_Estrela_1.Caption := '1 Estrela    : ' + FloatToStrF((Pc_R1/ Lc_Total) * 100,ffNumber,10,2) + ' %';
  Lb_Estrela_2.Caption := '2 Estrelas   : ' + FloatToStrF((Pc_R2/ Lc_Total) * 100,ffNumber,10,2) + ' %';
  Lb_Estrela_3.Caption := '3 Estrelas   : ' + FloatToStrF((Pc_R3/ Lc_Total) * 100,ffNumber,10,2) + ' %';
  Lb_Estrela_4.Caption := '4 Estrelas   : ' + FloatToStrF((Pc_R4/ Lc_Total) * 100,ffNumber,10,2) + ' %';
  Lb_Estrela_5.Caption := '5 Estrelas   : ' + FloatToStrF((Pc_R5/ Lc_Total) * 100,ffNumber,10,2) + ' %';

  with Pc_Obj do
    Begin
    Canvas.Pen.Width := 2;
    {1. Desenha o primeiro resultado}

    Canvas.Pen.Color := clGray;
    Canvas.Brush.Color := clGray;
    For Lc_I:=0 to Lc_R1 * 60 do
      Begin
      Lc_Angle := 2 * Pi * Lc_I / 3600;
      DrawHand (Pc_Obj, Lc_XCenter, Lc_YCenter, Lc_Radius * 100 div 100, 0, Lc_Angle);
      end;

    {2. Desenha o segundo resultado}

    Canvas.Pen.Color := clblue;
    Canvas.Brush.Color := clblue;
    For Lc_I:=Lc_R1 * 60 to (Lc_R1+Lc_R2) * 60 do
      Begin
      Lc_Angle := 2 * Pi * Lc_I / 3600;
      DrawHand (Pc_Obj, Lc_XCenter, Lc_YCenter, Lc_Radius * 100 div 100, 0, Lc_Angle);
      end;

    {3. Desenha o terceiro resultado}
    Canvas.Pen.Color := clGreen;
    Canvas.Brush.Color := clGreen;
    For Lc_I:=(Lc_R1+Lc_R2) * 60 to (Lc_R1+LC_R2 +Lc_R3) * 60 do
      Begin
      Lc_Angle := 2 * Pi * Lc_I / 3600;
      DrawHand (Pc_Obj, Lc_XCenter, Lc_YCenter, Lc_Radius * 100 div 100, 0, Lc_Angle);
      end;

    {4. Desenha o quarto resultado}
    Canvas.Pen.Color := clAqua;
    Canvas.Brush.Color := clAqua;
    For Lc_I:=(Lc_R1+LC_R2+Lc_R3)  * 60 to (Lc_R1+LC_R2+Lc_R3 + Lc_R4) * 60 do
      Begin
      Lc_Angle := 2 * Pi * Lc_I / 3600;
      DrawHand (Pc_Obj, Lc_XCenter, Lc_YCenter, Lc_Radius * 100 div 100, 0, Lc_Angle);
      end;

    {5. Desenha o quinto resultado}
    Canvas.Pen.Color := clRed;
    Canvas.Brush.Color := clRed;
    For Lc_I:=(Lc_R1+LC_R2+Lc_R3 + Lc_R4) * 60 to (Lc_R1+LC_R2+Lc_R3+Lc_R4 + Lc_R5)* 60 do
      Begin
      Lc_Angle := 2 * Pi * Lc_I / 3600;
      DrawHand (Pc_Obj, Lc_XCenter, Lc_YCenter, Lc_Radius * 100 div 100, 0, Lc_Angle);
      end;
    end;
end;

procedure TRL_Crm.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
vAR
  Lc_Vl_Cliente : Real;
  Lc_Qt_Cliente : real;
  Lc_Vl_1,Lc_Vl_2,Lc_Vl_3,Lc_Vl_4,Lc_Vl_5 : Real;
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Lb_Periodo.Caption := 'Baseado em Vendas do Per�odo de '+ DateToStr(Fr_Crm.E_DataIni.Date) + ' at� ' +DateToStr(Fr_Crm.E_DataFim.Date)+'.';
  Lc_Vl_Cliente := Fr_Crm.Fc_Totalvendas('P');
  Lb_Vl_Geral.Caption := FloatToStrF(Lc_Vl_Cliente,ffNumber,10,2);
  Lc_Qt_Cliente := Fr_Crm.Fc_TotalCliente('T','P',0,0);

  IF Lc_Qt_Cliente >0 then
    Lb_Vl_Medio.Caption := FloatToStrF(Lc_Vl_Cliente/Lc_Qt_Cliente,ffNumber,10,2)
  else
    Lb_Vl_Medio.Caption := FloatToStrF(Lc_Vl_Cliente,ffNumber,10,2);

  Lb_Maior.Caption := FloatToStrF(Fc_MaiorVenda,ffNumber,10,2);
  Lb_Menor.Caption := FloatToStrF(Fc_MenorVenda,ffNumber,10,2);

  Fr_Crm.Pc_Classificacao('P');
  Fr_Crm.Pc_Segmentacao('P');
  Lb_VL_Periodo_1.Caption := Fr_Crm.E_Vl_Periodo_1.Text;
  Lb_VL_Periodo_2.Caption := Fr_Crm.E_Vl_Periodo_2.Text;
  Lb_VL_Periodo_3.Caption := Fr_Crm.E_Vl_Periodo_3.Text;
  Lb_VL_Periodo_4.Caption := Fr_Crm.E_Vl_Periodo_4.Text;
  Lb_VL_Periodo_5.Caption := Fr_Crm.E_Vl_Periodo_5.Text;

  Lb_Qt_Periodo_1.Caption := Fr_Crm.E_Qt_Periodo_1.Text;
  Lb_Qt_Periodo_2.Caption := Fr_Crm.E_Qt_Periodo_2.Text;
  Lb_Qt_Periodo_3.Caption := Fr_Crm.E_Qt_Periodo_3.Text;
  Lb_Qt_Periodo_4.Caption := Fr_Crm.E_Qt_Periodo_4.Text;
  Lb_Qt_Periodo_5.Caption := Fr_Crm.E_Qt_Periodo_5.Text;


  Pc_MontaGrafico(im_Grande,
                  StrtoFloatDef(Fr_Crm.E_Vl_Periodo_1.Text,0),
                  StrtoFloatDef(Fr_Crm.E_Vl_Periodo_2.Text,0),
                  StrtoFloatDef(Fr_Crm.E_Vl_Periodo_3.Text,0),
                  StrtoFloatDef(Fr_Crm.E_Vl_Periodo_4.Text,0),
                  StrtoFloatDef(Fr_Crm.E_Vl_Periodo_5.Text,0));

  Lc_Vl_1 := StrToFloatDef(Fr_Crm.E_Vl_Periodo_1.Text,0);
  Lc_Vl_2 := StrToFloatDef(Fr_Crm.E_Vl_Periodo_2.Text,0);
  Lc_Vl_3 := StrToFloatDef(Fr_Crm.E_Vl_Periodo_3.Text,0);
  Lc_Vl_4 := StrToFloatDef(Fr_Crm.E_Vl_Periodo_4.Text,0);
  Lc_Vl_5 := StrToFloatDef(Fr_Crm.E_Vl_Periodo_5.Text,0);

  Lb_VL_Medio_1.Caption := FloatToStrF(Fc_VendaMedia(0,Lc_Vl_1),ffNumber,10,2);
  Lb_VL_Medio_2.Caption := FloatToStrF(Fc_VendaMedia(Lc_Vl_1 + 0.01,Lc_Vl_2),ffNumber,10,2);
  Lb_VL_Medio_3.Caption := FloatToStrF(Fc_VendaMedia(Lc_Vl_2 + 0.01,Lc_Vl_3),ffNumber,10,2);
  Lb_VL_Medio_4.Caption := FloatToStrF(Fc_VendaMedia(Lc_Vl_3 + 0.01,Lc_Vl_4),ffNumber,10,2);
  Lb_VL_Medio_5.Caption := FloatToStrF(Fc_VendaMedia(Lc_Vl_4 + 0.01,1000000),ffNumber,10,2);

end;

end.
