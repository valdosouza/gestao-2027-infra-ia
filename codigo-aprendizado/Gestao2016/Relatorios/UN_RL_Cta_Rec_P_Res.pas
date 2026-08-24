unit UN_RL_Cta_Rec_P_Res;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_Cta_Rec_P_Res = class(TForm)    
    Qr_Produtos: TSTQuery;
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    Qrp_Produto: TQRGroup;
    Ftp_PRoduto: TQRBand;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRExpr1: TQRExpr;
    QRDBText2: TQRDBText;
    QRLabel10: TQRLabel;
    Lb_Titulo: TQRLabel;
    QRBand3: TQRBand;
    QRExpr2: TQRExpr;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    It_Totalizador : Array[1..2,1..3] of Real;
  public
    { Public declarations }
  It_Dt_Inicial, It_Dt_Final : TDate;
  It_Dia : Integer;
  It_Qt_Total: Currency;
  It_Gr_Total: Currency;
  It_Vl_Total: Currency;
  It_Vl_Geral: Currency;
  procedure Pc_Busca;
  procedure Pc_Vendas;
  procedure Pc_Devolucao;
  end;

var
  RL_Cta_Rec_P_Res: TRL_Cta_Rec_P_Res;

implementation

uses     UN_Imp_CtasReceber, Un_Funcoes, UN_Sistema, ComCtrls, Un_Principal, env;
{$R *.dfm}
procedure TRL_Cta_Rec_P_Res.Pc_Busca;
Var
  sqltxt:String;
  Lc_DataINI, Lc_DataFIM : String;
  Lc_I,Lc_J : Integer;
  Lc_Cliente : boolean;
  Lc_TxtSql : String;
begin
  Screen.Cursor:=crHourGlass;
  Qr_Produtos.Active := False;
  Qr_Produtos.SQL.Clear;
  Lc_TxtSql := 'SELECT ITF_CODPRO, ITF_QTDE, ITF_VL_UNIT, ITF_OPER, NFL_CODEMP,PRO_DESCRICAO '+
                'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
                '    INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
                '    ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO) '+
                '    INNER JOIN TB_PRODUTO tb_produto '+
                '   ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) '+
                'WHERE (ITF_OPER =:ITF_OPER) AND (NFL_CODMHA=:NFL_CODMHA) ';

  if Fr_Imp_CtasReceber.DBLCB_Empresa.Text = '' then Lc_Cliente := False else Lc_Cliente := True;

  if Lc_Cliente then Lc_TxtSql := Lc_TxtSql + ' AND (NFL_CODEMP =:NFL_CODEMP) ';
  if Fr_Imp_CtasReceber.ChBx_Periodo.Checked then  Lc_TxtSql := Lc_TxtSql + ' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ';

  Qr_Produtos.SQL.Add(Lc_TxtSql + ' ORDER BY PRO_DESCRICAO ');
  Qr_Produtos.ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;

  For Lc_I := 1 to 2 do
    For Lc_J := 1 to 3 do
      It_Totalizador[Lc_I,lc_J] :=0;
  It_Dia := DayOfWeek(Fr_Imp_CtasReceber.E_Data_Ini.Date);
  It_Dt_Inicial := Fr_Imp_CtasReceber.E_Data_Ini.Date-(It_Dia-2);
  It_Dt_Final := Fr_Imp_CtasReceber.E_Data_Ini.Date+(7-It_dia);
  Lc_DataINI := DateToStr(It_Dt_Inicial);
  Lc_DataFIM := DateToStr(It_Dt_Final);
  Qr_Produtos.Active := False;
  if Lc_Cliente then Qr_Produtos.ParamByName('NFL_CODEMP').AsInteger := Fr_Imp_CtasReceber.DBLCB_Empresa.KeyValue;
  if Fr_Imp_CtasReceber.ChBx_Periodo.Checked then
    begin
    Qr_Produtos.ParamByName('DATAINI').AsDate := It_Dt_Inicial;
    Qr_Produtos.ParamByName('DATAFIM').AsDate := It_Dt_Inicial + 5;
    end;
  Qr_Produtos.ParamByName('ITF_OPER').AsString := 'V';
  Qr_Produtos.Active := True;
  Qr_Produtos.FetchAll;
  Qr_Produtos.First;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Cta_Rec_P_Res.Pc_Vendas;
Var
  Lc_Qt : Real;
  Lc_VL : Real;
begin

  Lc_Qt := 0;
  Lc_VL := 0;
  while not Qr_Produtos.Eof do
    Begin
    Lc_Qt := Lc_Qt + Qr_Produtos.FieldByName('ITF_QTDE').AsFloat;
    Lc_VL := Lc_VL + (Qr_Produtos.FieldByName('ITF_VL_UNIT').AsCurrency * Qr_Produtos.FieldByName('ITF_QTDE').AsFloat);
    Qr_Produtos.Next;
    end;
  It_Totalizador[1,1] := It_Totalizador[1,1] + Lc_Qt;
  It_Totalizador[2,1] := It_Totalizador[2,1] + Lc_VL;

end;

procedure TRL_Cta_Rec_P_Res.Pc_Devolucao;
Var
  Lc_Qt : Real;
  Lc_VL : Real;
begin
  Qr_Produtos.Active := False;
  Qr_Produtos.ParamByName('NFL_CODEMP').AsInteger := Fr_Imp_CtasReceber.DBLCB_Empresa.KeyValue;
  Qr_Produtos.ParamByName('DATAINI').AsDate := It_Dt_Inicial;
  Qr_Produtos.ParamByName('DATAFIM').AsDate := It_Dt_Final;
  Qr_Produtos.ParamByName('ITF_OPER').AsString := 'D';
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
  It_Totalizador[1,2] := It_Totalizador[1,2] + Lc_Qt;
  It_Totalizador[2,2] := It_Totalizador[2,2] + Lc_VL;

end;

procedure TRL_Cta_Rec_P_Res.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TRL_Cta_Rec_P_Res.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
end;

end.
