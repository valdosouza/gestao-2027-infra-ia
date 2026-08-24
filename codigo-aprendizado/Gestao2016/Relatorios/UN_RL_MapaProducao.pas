unit UN_RL_MapaProducao;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, QRCtrls, QuickRpt, ExtCtrls, jpeg, StdCtrls;

type
  TRL_MapaProducao = class(TForm)
    Qrpt: TQuickRep;
    Titulo: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel8: TQRLabel;
    Qr_MapaProducao: TSTQuery;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText3: TQRDBText;
    QRExpr3: TQRExpr;
    QRDBText1: TQRDBText;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pc_Buscar;
  end;

var
  RL_MapaProducao: TRL_MapaProducao;

implementation

uses     UN_Sistema, UN_Imp_MapaProducao;
{$R *.dfm}
procedure TRL_MapaProducao.Pc_Buscar;
Var
  SqlTxt : String;
  Lc_I : Integer;
  Lc_Str_Inclui : String;
Begin
  Screen.Cursor := crHourGlass;
  Qr_MapaProducao.Active := False;
  Qr_MapaProducao.SQL.Clear;
  {
  //comando substituido para pegar a composição via ctrl etoque
  SqlTxt := ' SELECT PED_DATA, PED_CODIGO, PED_NUMERO,  ITF_CODPRO, PRO_DESCRICAO, ITF_QTDE, PED_VL_PEDIDO '+
            ' FROM TB_PEDIDO tb_pedido                                                                     '+
            '   INNER JOIN TB_ITENS_NFL tb_itens_nfl                                                       '+
            '   ON  (tb_itens_nfl.ITF_CODPED = tb_pedido.PED_CODIGO)                                       '+
            '   INNER JOIN TB_PRODUTO Tb_produto                                                           '+
            '   ON  (Tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO)';
  }

  SqlTxt := concat(
                'SELECT PRO_DESCRICAO, CAST(COALESCE(SUM(ce.cet_qtde), 0) AS DOUBLE PRECISION) TOTAL                  ',
                'FROM TB_PEDIDO pd                                             ',
                '   INNER JOIN TB_ITENS_NFL i                                  ',
                '   ON  (i.ITF_CODPED = pd.PED_CODIGO)                         ',
                '   inner join tb_ctrl_estoque ce                              ',
                '   on (ce.cet_item_ctrl =i.itf_codigo )                       ',
                '   INNER JOIN TB_PRODUTO pr                                   ',
                '   ON  (pr.PRO_CODIGO = ce.cet_codpro)                        '
            );

  Lc_Str_Inclui := 'WHERE (ITF_OPER = ''V'') and ce.cet_tipo = ''VENDA'' AND (PED_CODIGO IN (';
  with Fr_Imp_MapaProducao do
    Begin
    For Lc_I := 1 to StrGrd_Pedido.RowCount -1 do
      if StrGrd_Pedido.Cells[1,Lc_I] <> '' then
        if Lc_I = 1 then
          Lc_Str_Inclui := Lc_Str_Inclui + StrGrd_Pedido.Cells[1,lc_i]
        else
          Lc_Str_Inclui := Lc_Str_Inclui + ','+StrGrd_Pedido.Cells[1,lc_i];
      end;
  Lc_Str_Inclui := Lc_Str_Inclui +')) ';

  SqlTxt :=  concat(
                 SqlTxt,
                 Lc_Str_Inclui,
                 ' group by 1 ',
                 ' ORDER BY PRO_DESCRICAO '
            );

  Qr_MapaProducao.SQL.Add(SqlTxt);
  Qr_MapaProducao.Active := TRUE;
  Qr_MapaProducao.RecordCount;  
  Screen.Cursor := crDefault;
end;

procedure TRL_MapaProducao.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Buscar;
end;

end.
