unit UN_RL_Cta_Rec_P;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery, Grids, DBGrids, System.Math;

type
  TRL_Cta_Rec_P = class(TForm)
    Qr_Vendas: TSTQuery;    
    Qr_Produtos: TSTQuery;
    Qrpt: TQuickRep;
    Bnd_Titulo: TQRBand;
    QRLabel10: TQRLabel;
    Lb_Titulo: TQRLabel;
    QRLabel2: TQRLabel;
    lb_Qt_6: TQRLabel;
    Lb_Dia_6: TQRLabel;
    lb_Qt_5: TQRLabel;
    Lb_Dia_5: TQRLabel;
    lb_Qt_4: TQRLabel;
    Lb_Dia_4: TQRLabel;
    lb_Qt_3: TQRLabel;
    Lb_Dia_3: TQRLabel;
    lb_Qt_2: TQRLabel;
    Lb_Dia_2: TQRLabel;
    lb_Qt_1: TQRLabel;
    Lb_Dia_1: TQRLabel;
    lb_preco: TQRLabel;
    QRGroup1: TQRGroup;
    Dtl_Produto: TQRBand;
    E_Qt_Dia_5: TQRLabel;
    E_Vl_Dia_5: TQRLabel;
    E_Qt_Dia_4: TQRLabel;
    E_Vl_Dia_4: TQRLabel;
    E_Qt_Dia_3: TQRLabel;
    E_Vl_Dia_3: TQRLabel;
    E_Qt_Dia_2: TQRLabel;
    E_Vl_Dia_2: TQRLabel;
    E_Qt_Dia_1: TQRLabel;
    E_Vl_Dia_1: TQRLabel;
    E_VL_Preco: TQRLabel;
    Lb_Produto: TQRLabel;
    E_Qt_Dia_6: TQRLabel;
    E_Vl_Dia_6: TQRLabel;
    Sumario: TQRBand;
    QRLabel7: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel52: TQRLabel;
    E_Qt_Tot_2: TQRLabel;
    E_Vl_Tot_2: TQRLabel;
    E_Qt_Tot_1: TQRLabel;
    E_Vl_Tot_1: TQRLabel;
    E_Qt_Tot_5: TQRLabel;
    E_Vl_Tot_5: TQRLabel;
    E_Qt_Tot_4: TQRLabel;
    E_Vl_Tot_4: TQRLabel;
    E_Qt_Tot_3: TQRLabel;
    E_Vl_Tot_3: TQRLabel;
    E_Qt_Tot_6: TQRLabel;
    E_Vl_Tot_6: TQRLabel;
    E_Qt_Dev_2: TQRLabel;
    E_Vl_Dev_2: TQRLabel;
    E_Qt_Dev_1: TQRLabel;
    E_Vl_Dev_1: TQRLabel;
    E_Qt_Dev_5: TQRLabel;
    E_Vl_Dev_5: TQRLabel;
    E_Qt_Dev_4: TQRLabel;
    E_Vl_Dev_4: TQRLabel;
    E_Qt_Dev_3: TQRLabel;
    E_Vl_Dev_3: TQRLabel;
    E_Qt_Dev_6: TQRLabel;
    E_Vl_Dev_6: TQRLabel;
    E_Qt_Ger_2: TQRLabel;
    E_VL_Ger_2: TQRLabel;
    E_Qt_Ger_1: TQRLabel;
    E_VL_Ger_1: TQRLabel;
    E_Qt_Ger_5: TQRLabel;
    E_VL_Ger_5: TQRLabel;
    E_Qt_Ger_4: TQRLabel;
    E_VL_Ger_4: TQRLabel;
    E_Qt_Ger_3: TQRLabel;
    E_VL_Ger_3: TQRLabel;
    E_Qt_Ger_6: TQRLabel;
    E_VL_Ger_6: TQRLabel;
    E_Vl_total: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel20: TQRLabel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;



    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Dtl_ProdutoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SumarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Dtl_ProdutoAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
  private
    { Private declarations }
    It_Totalizador : Array[1..12,1..3] of Real;
  public
    { Public declarations }
  It_Dt_Inicial, It_Dt_Final : TDate;
  It_Dia : Integer;
  procedure Pc_Busca;
  procedure Pc_Vendas;
  procedure Pc_Devolucao;
  end;

var
  RL_Cta_Rec_P: TRL_Cta_Rec_P;

implementation

uses     UN_Imp_CtasReceber, Un_Funcoes, UN_Sistema, ComCtrls, UN_MSG, Un_DM, env, Un_Principal;
{$R *.dfm}
procedure TRL_Cta_Rec_P.Pc_Busca;
Var
  sqltxt:String;
  Lc_DataINI, Lc_DataFIM : String;
  Lc_I,Lc_J : Integer;
begin
  Screen.Cursor:=crHourGlass;
  For Lc_I := 1 to 12 do
    For Lc_J := 1 to 3 do
     it_Totalizador[Lc_I,lc_J] :=0;
  It_Dia := DayOfWeek(Fr_Imp_CtasReceber.E_Data_Ini.Date);
  It_Dt_Inicial := Fr_Imp_CtasReceber.E_Data_Ini.Date-(It_Dia-2);
  It_Dt_Final := Fr_Imp_CtasReceber.E_Data_Ini.Date+(7-It_dia);
  Lc_DataINI := DateToStr(It_Dt_Inicial);
  Lc_DataFIM := DateToStr(It_Dt_Final);
  Qr_Vendas.Close;
  Qr_Vendas.ParamByName('PED_CODEMP').AsInteger := Fr_Imp_CtasReceber.DBLCB_Empresa.KeyValue;
  Qr_Vendas.ParamByName('DATAINI').AsDate := It_Dt_Inicial;
  Qr_Vendas.ParamByName('DATAFIM').AsDate := It_Dt_Final;
  Qr_Vendas.ParamByName('PED_CODMHA').AsInteger := Gb_CodMha;
  Qr_Vendas.Active := True;
  Qr_Vendas.FetchAll;
  if Qr_Vendas.IsEmpty then
    Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Nenhum registro encontrado.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    exit;
    end;
  Qr_Vendas.First;
  Lc_I := Qr_Vendas.FieldByName('ITF_CODPRO').Value;
  Lb_Dia_1.Caption := Copy(DateToStr(It_Dt_Inicial+0),1,2) + '/' + Copy(Fc_DesMes(StrToInt(Copy(DateToStr(It_Dt_Inicial+0),4,2)),True),1,3);
  Lb_Dia_2.Caption := Copy(DateToStr(It_Dt_Inicial+1),1,2) + '/' + Copy(Fc_DesMes(StrToInt(Copy(DateToStr(It_Dt_Inicial+1),4,2)),True),1,3);
  Lb_Dia_3.Caption := Copy(DateToStr(It_Dt_Inicial+2),1,2) + '/' + Copy(Fc_DesMes(StrToInt(Copy(DateToStr(It_Dt_Inicial+2),4,2)),True),1,3);
  Lb_Dia_4.Caption := Copy(DateToStr(It_Dt_Inicial+3),1,2) + '/' + Copy(Fc_DesMes(StrToInt(Copy(DateToStr(It_Dt_Inicial+3),4,2)),True),1,3);
  Lb_Dia_5.Caption := Copy(DateToStr(It_Dt_Inicial+4),1,2) + '/' + Copy(Fc_DesMes(StrToInt(Copy(DateToStr(It_Dt_Inicial+4),4,2)),True),1,3);
  Lb_Dia_6.Caption := Copy(DateToStr(It_Dt_Inicial+5),1,2) + '/' + Copy(Fc_DesMes(StrToInt(Copy(DateToStr(It_Dt_Inicial+5),4,2)),True),1,3);

  Screen.Cursor:=crDefault;
end;

procedure TRL_Cta_Rec_P.Pc_Vendas;
Var
  LC_I:Integer;
  Lc_Qt : Real;
  Lc_VL : Real;
begin
  For Lc_I:= 0 to 5 do
    Begin
    Qr_Produtos.Active := False;
    Qr_Produtos.ParamByName('PED_CODEMP').AsInteger := Fr_Imp_CtasReceber.DBLCB_Empresa.KeyValue;
    Qr_Produtos.ParamByName('DATAINI').AsDate := It_Dt_Inicial + LC_I;
    Qr_Produtos.ParamByName('DATAFIM').AsDate := It_Dt_Inicial + LC_I;
    Qr_Produtos.ParamByName('ITF_OPER').AsString := 'V';
    Qr_Produtos.ParamByName('ITF_CODPRO').AsInteger := Qr_Vendas.FieldByName('ITF_CODPRO').Value;
    Qr_Produtos.Active := True;
    Qr_Produtos.First;
    Lc_Qt := 0;
    Lc_VL := 0;
    while not Qr_Produtos.Eof do
      Begin
      Lc_Qt := Lc_Qt + Qr_Produtos.FieldByName('ITF_QTDE').AsFloat;
      Lc_VL := Lc_VL + (Qr_Produtos.FieldByName('ITF_VL_UNIT').AsCurrency * Qr_Produtos.FieldByName('ITF_QTDE').AsFloat);
      Qr_Produtos.Next;
      end;
    case LC_I of
      0:Begin
        Lb_Produto.Caption := Qr_Vendas.FieldByName('PRO_DESCRICAO').AsString;
        If (StrToFloatDef(E_VL_Preco.Caption,0) = 0) then
          E_VL_Preco.Caption := FloatToStrF(Qr_Produtos.FieldByName('ITF_VL_UNIT').AsCurrency,ffFixed,10,2);
        E_Qt_Dia_1.Caption := FloatToStrF(Lc_Qt,ffFixed,10,0);
        E_Vl_Dia_1.Caption := FloatToStrF(Lc_VL,ffFixed,10,2);
        It_Totalizador[1,1] := It_Totalizador[1,1] + Lc_Qt;
        It_Totalizador[2,1] := It_Totalizador[2,1] + Lc_VL;
        end;
      1:Begin
        If (StrToFloatDef(E_VL_Preco.Caption,0) = 0) then
          E_VL_Preco.Caption := FloatToStrF(Qr_Produtos.FieldByName('ITF_VL_UNIT').AsCurrency,ffFixed,10,2);
        E_Qt_Dia_2.Caption := FloatToStrF(Lc_Qt,ffFixed,10,0);
        E_Vl_Dia_2.Caption := FloatToStrF(Lc_VL,ffFixed,10,2);
        It_Totalizador[3,1] := It_Totalizador[3,1] + Lc_Qt;
        It_Totalizador[4,1] := It_Totalizador[4,1] + Lc_VL;
        end;
      2:Begin
        If (StrToFloatDef(E_VL_Preco.Caption,0) = 0) then
          E_VL_Preco.Caption := FloatToStrF(Qr_Produtos.FieldByName('ITF_VL_UNIT').AsCurrency,ffFixed,10,2);
        E_Qt_Dia_3.Caption := FloatToStrF(Lc_Qt,ffFixed,10,0);
        E_Vl_Dia_3.Caption := FloatToStrF(Lc_VL,ffFixed,10,2);
        It_Totalizador[5,1] := It_Totalizador[5,1] + Lc_Qt;
        It_Totalizador[6,1] := It_Totalizador[6,1] + Lc_VL;
        end;
      3:Begin
        If (StrToFloatDef(E_VL_Preco.Caption,0) = 0) then
          E_VL_Preco.Caption := FloatToStrF(Qr_Produtos.FieldByName('ITF_VL_UNIT').AsCurrency,ffFixed,10,2);
        E_Qt_Dia_4.Caption := FloatToStrF(Lc_Qt,ffFixed,10,0);
        E_Vl_Dia_4.Caption := FloatToStrF(Lc_VL,ffFixed,10,2);
        It_Totalizador[7,1] := It_Totalizador[7,1] + Lc_Qt;
        It_Totalizador[8,1] := It_Totalizador[8,1] + Lc_VL;
        end;
      4:Begin
        If (StrToFloatDef(E_VL_Preco.Caption,0) = 0) then
          E_VL_Preco.Caption := FloatToStrF(Qr_Produtos.FieldByName('ITF_VL_UNIT').AsCurrency,ffFixed,10,2);
        E_Qt_Dia_5.Caption := FloatToStrF(Lc_Qt,ffFixed,10,0);
        E_Vl_Dia_5.Caption := FloatToStrF(Lc_VL,ffFixed,10,2);
        It_Totalizador[9,1] := It_Totalizador[9,1] + Lc_Qt;
        It_Totalizador[10,1] := It_Totalizador[10,1] + Lc_VL;
        end;
      5:Begin
        If (StrToFloatDef(E_VL_Preco.Caption,0) = 0) then
          E_VL_Preco.Caption := FloatToStrF(Qr_Produtos.FieldByName('ITF_VL_UNIT').AsCurrency,ffFixed,10,2);
        E_Qt_Dia_6.Caption := FloatToStrF(Lc_Qt,ffFixed,10,0);
        E_Vl_Dia_6.Caption := FloatToStrF(Lc_VL,ffFixed,10,2);
        It_Totalizador[11,1] := It_Totalizador[11,1] + Lc_Qt;
        It_Totalizador[12,1] := It_Totalizador[12,1] + Lc_VL;
        end;
    end;
    end;
end;

procedure TRL_Cta_Rec_P.Pc_Devolucao;
Var
  LC_I:Integer;
  Lc_Qt : Real;
  Lc_VL : Real;
begin
  For Lc_I:= 0 to 5 do
    Begin
    Qr_Produtos.Active := False;
    Qr_Produtos.ParamByName('PED_CODEMP').AsInteger := Fr_Imp_CtasReceber.DBLCB_Empresa.KeyValue;
    Qr_Produtos.ParamByName('DATAINI').AsDate := It_Dt_Inicial + LC_I;
    Qr_Produtos.ParamByName('DATAFIM').AsDate := It_Dt_Inicial + LC_I;
    Qr_Produtos.ParamByName('ITF_OPER').AsString := 'D';
    Qr_Produtos.ParamByName('ITF_CODPRO').AsString := Qr_Vendas.FieldByName('ITF_CODPRO').AsString;
    Qr_Produtos.Active := True;
    Qr_Produtos.FetchAll;
    Qr_Produtos.First;
    Lc_Qt := 0;
    Lc_VL := 0;
    while not Qr_Produtos.Eof do
      Begin
      Lc_Qt := Lc_Qt + Qr_Produtos.FieldByName('ITF_QTDE').AsFloat;
      Lc_VL := Lc_VL + (Qr_Produtos.FieldByName('ITF_VL_UNIT').AsCurrency * Qr_Produtos.FieldByName('ITF_QTDE').AsFloat);
      Qr_Produtos.Next;
      end;
    case LC_I of
      0:Begin
        It_Totalizador[1,2] := It_Totalizador[1,2] + Lc_Qt;
        It_Totalizador[2,2] := It_Totalizador[2,2] + Lc_VL;
        end;
      1:Begin
        It_Totalizador[3,2] := It_Totalizador[3,2] + Lc_Qt;
        It_Totalizador[4,2] := It_Totalizador[4,2] + Lc_VL;
        end;
      2:Begin
        It_Totalizador[5,2] := It_Totalizador[5,2] + Lc_Qt;
        It_Totalizador[6,2] := It_Totalizador[6,2] + Lc_VL;
        end;
      3:Begin
        It_Totalizador[7,2] := It_Totalizador[7,2] + Lc_Qt;
        It_Totalizador[8,2] := It_Totalizador[8,2] + Lc_VL;
        end;
      4:Begin
        It_Totalizador[9,2] := It_Totalizador[9,2] + Lc_Qt;
        It_Totalizador[10,2] := It_Totalizador[10,2] + Lc_VL;
        end;
      5:Begin
        It_Totalizador[11,2] := It_Totalizador[11,2] + Lc_Qt;
        It_Totalizador[12,2] := It_Totalizador[12,2] + Lc_VL;
        end;
    end;
    end;
end;

procedure TRL_Cta_Rec_P.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Lb_Titulo.Caption := 'Contas é Receber por Produtos - ' + Fr_Imp_CtasReceber.DBLCB_Empresa.Text;
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
end;

procedure TRL_Cta_Rec_P.Dtl_ProdutoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  IF Qr_Vendas.RecordCount > 0 THEN
    BEGIN
    Pc_Vendas;
    Pc_Devolucao;
    END
  ELSE
    Screen.Cursor:=crDefault;  
end;


procedure TRL_Cta_Rec_P.SumarioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := 0;
  //Quantidade Totais
  E_Qt_Tot_1.Caption := FloatToStrF(it_totalizador[1,1],ffFixed,10,0);
  E_Vl_Tot_1.Caption := FloatToStrF(it_totalizador[2,1],ffFixed,10,2);

  E_Qt_Tot_2.Caption := FloatToStrF(it_totalizador[3,1],ffFixed,10,0);
  E_Vl_Tot_2.Caption := FloatToStrF(it_totalizador[4,1],ffFixed,10,2);

  E_Qt_Tot_3.Caption := FloatToStrF(it_totalizador[5,1],ffFixed,10,0);
  E_Vl_Tot_3.Caption := FloatToStrF(it_totalizador[6,1],ffFixed,10,2);

  E_Qt_Tot_4.Caption := FloatToStrF(it_totalizador[7,1],ffFixed,10,0);
  E_Vl_Tot_4.Caption := FloatToStrF(it_totalizador[8,1],ffFixed,10,2);

  E_Qt_Tot_5.Caption := FloatToStrF(it_totalizador[9,1],ffFixed,10,0);
  E_Vl_Tot_5.Caption := FloatToStrF(it_totalizador[10,1],ffFixed,10,2);

  E_Qt_Tot_6.Caption := FloatToStrF(it_totalizador[11,1],ffFixed,10,0);
  E_Vl_Tot_6.Caption := FloatToStrF(it_totalizador[12,1],ffFixed,10,2);

  E_Qt_Dev_1.Caption := FloatToStrF(it_totalizador[1,2],ffFixed,10,0);
  E_Vl_Dev_1.Caption := FloatToStrF(it_totalizador[2,2],ffFixed,10,2);

  E_Qt_Dev_2.Caption := FloatToStrF(it_totalizador[3,2],ffFixed,10,0);
  E_Vl_Dev_2.Caption := FloatToStrF(it_totalizador[4,2],ffFixed,10,2);

  E_Qt_Dev_3.Caption := FloatToStrF(it_totalizador[5,2],ffFixed,10,0);
  E_Vl_Dev_3.Caption := FloatToStrF(it_totalizador[6,2],ffFixed,10,2);

  E_Qt_Dev_4.Caption := FloatToStrF(it_totalizador[7,2],ffFixed,10,0);
  E_Vl_Dev_4.Caption := FloatToStrF(it_totalizador[8,2],ffFixed,10,2);

  E_Qt_Dev_5.Caption := FloatToStrF(it_totalizador[9,2],ffFixed,10,0);
  E_Vl_Dev_5.Caption := FloatToStrF(it_totalizador[10,2],ffFixed,10,2);

  E_Qt_Dev_6.Caption := FloatToStrF(it_totalizador[11,2],ffFixed,10,0);
  E_Vl_Dev_6.Caption := FloatToStrF(it_totalizador[12,2],ffFixed,10,2);

  E_Qt_Ger_1.Caption := FloatToStrF(it_totalizador[1,1] - it_totalizador[1,2],ffFixed,10,0);
  E_Vl_Ger_1.Caption := FloatToStrF(it_totalizador[2,1] - it_totalizador[2,2],ffFixed,10,2);
  Lc_Valor := Lc_Valor + it_totalizador[2,1] - it_totalizador[2,2];

  E_Qt_Ger_2.Caption := FloatToStrF(it_totalizador[3,1] - it_totalizador[3,2],ffFixed,10,0);
  E_Vl_Ger_2.Caption := FloatToStrF(it_totalizador[4,1] - it_totalizador[4,2],ffFixed,10,2);
  Lc_Valor := Lc_Valor + it_totalizador[4,1] - it_totalizador[4,2];

  E_Qt_Ger_3.Caption := FloatToStrF(it_totalizador[5,1] - it_totalizador[5,2],ffFixed,10,0);
  E_Vl_Ger_3.Caption := FloatToStrF(it_totalizador[6,1] - it_totalizador[6,2],ffFixed,10,2);
  Lc_Valor := Lc_Valor + it_totalizador[6,1] - it_totalizador[6,2];

  E_Qt_Ger_4.Caption := FloatToStrF(it_totalizador[7,1] - it_totalizador[7,2],ffFixed,10,0);
  E_Vl_Ger_4.Caption := FloatToStrF(it_totalizador[8,1] - it_totalizador[8,2],ffFixed,10,2);
  Lc_Valor := Lc_Valor + it_totalizador[8,1] - it_totalizador[8,2];

  E_Qt_Ger_5.Caption := FloatToStrF(it_totalizador[9,1] - it_totalizador[9,2],ffFixed,10,0);
  E_Vl_Ger_5.Caption := FloatToStrF(it_totalizador[10,1] - it_totalizador[10,2],ffFixed,10,2);
  Lc_Valor := Lc_Valor + it_totalizador[10,1] - it_totalizador[10,2];

  E_Qt_Ger_6.Caption := FloatToStrF(it_totalizador[11,1] - it_totalizador[11,2],ffFixed,10,0);
  E_Vl_Ger_6.Caption := FloatToStrF(it_totalizador[12,1] - it_totalizador[12,2],ffFixed,10,2);
  Lc_Valor := Lc_Valor + it_totalizador[12,1] - it_totalizador[12,2];
  E_Vl_total.Caption := FloatToStrF(Lc_Valor,ffFixed,10,2);

end;

procedure TRL_Cta_Rec_P.Dtl_ProdutoAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  E_VL_Preco.Caption := '0,00';
end;

end.
