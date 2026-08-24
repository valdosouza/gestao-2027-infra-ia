unit Un_RL_ReportMapaCarga;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportList, Data.DB, Vcl.Grids, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportMapaCarga = class(TRL_ReportList)
    Qrb_Detalhe: TQRBand;
    Qrb_Rodape: TQRBand;
    Qr_Total: TQRExpr;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel8: TQRLabel;
    Qrb_Sumario: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel12: TQRLabel;
    E_Cliente: TQRLabel;
    E_ValorPedido: TQRLabel;
    E_FormaPagto: TQRLabel;
    E_Data: TQRLabel;
    E_Nr_Pedido: TQRLabel;
    QRLabel1: TQRLabel;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure Qrb_DetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Qrb_SumarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

    Lista : TStringGrid;
    Function MontaListaPedido : String;
    procedure PreecheDetalhe;
    procedure ResumoFormaPagto;
    procedure CriarComponente(Indice:Integer;FormaPagto:String;Valor:Real);
  end;

var
  RL_ReportMapaCarga: TRL_ReportMapaCarga;

implementation

{$R *.dfm}

uses     Un_DM;

{ TRL_ReportMapaCarga }


procedure TRL_ReportMapaCarga.InnerJoinSql;
begin
  InnerJoinTxt :=
  '  INNER JOIN tb_empresa E '+
  '  ON (E.emp_codigo = N.nfl_codemp) '+
  '  INNER JOIN TB_PEDIDO P '+
  '  ON (P.ped_codigo = N.nfl_codped) '+
  '  INNER JOIN tb_formapagto F '+
  '  ON (F.fpt_codigo = P.ped_codfpg)';
end;

function TRL_ReportMapaCarga.MontaListaPedido: String;
Var
  I : Integer;
  Contador : Integer;
begin
  Result := ' ';
  Contador := 0;
  For I := 1 to Lista.RowCount -1 do
  Begin
    if Lista.Cells[8,I] = 'X' then
    Begin
      inc(Contador);
      if Contador = 1 then
        Result := Lista.Cells[1,i]
      else
        Result := Result + ','+Lista.Cells[1,I];
    End;
  end;
end;

procedure TRL_ReportMapaCarga.OrderBy;
begin
  OrderByTxt := ' Order By EMP_FANTASIA, FPT_DESCRICAO ';
end;

procedure TRL_ReportMapaCarga.PreecheDetalhe;
begin
  With Qr_Consulta do
  Begin
    E_Data.Caption        := FieldByName('PED_DATA').AsString;
    E_Nr_Pedido.Caption   := FieldByName('PED_NUMERO').AsString;
    E_Cliente.Caption     := FieldByName('EMP_FANTASIA').AsString;
    E_FormaPagto.Caption  := FieldByName('FPT_DESCRICAO').AsString;
    E_ValorPedido.Caption := FloatToStrF(FieldByName('NFL_VL_TL_NOTA').AsCurrency,ffFixed,10,2);
  End;
end;

procedure TRL_ReportMapaCarga.Qrb_DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PreecheDetalhe;
end;

procedure TRL_ReportMapaCarga.Qrb_SumarioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  ResumoFormaPagto;
end;

procedure TRL_ReportMapaCarga.CriarComponente(Indice:Integer;FormaPagto:String;Valor:Real);
Var
  Lc_Descricao : TQrLabel;
  Lc_Valor : TQrLabel;
Begin
  //Descrição
  Lc_Descricao := TQrLabel.Create(Self);
  Lc_Descricao.Parent := Qrb_Sumario;
  Lc_Descricao.Height := 17;
  Lc_Descricao.Width := 140;
  Lc_Descricao.Left := 489;
  Lc_Descricao.Top := 23 + (17 * indice);
  Lc_Descricao.Caption := FormaPagto;
  //Valor
  Lc_Valor := TQrLabel.Create(Self);
  Lc_Valor.Parent := Qrb_Sumario;
  Lc_Valor.Height := 17;
  Lc_Valor.Width := 99;
  Lc_Valor.Alignment := taRightJustify;
  Lc_Valor.Left := 634;
  Lc_Valor.Top := 23 + (17 * indice);
  Lc_Valor.Caption := FloatToStrF(Valor,ffFixed,10,2);
End;


procedure TRL_ReportMapaCarga.ResumoFormaPagto;
Var
  Contador :Integer;
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := TSTQuery.Create(Self);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IBT_Consulta;
    ForcedRefresh := True;
    Active := False;
    sql.Clear;
    sql.Add('SELECT FPT_DESCRICAO,  SUM(NFL_VL_TL_NOTA) TOTAL '+
            'FROM tb_nota_fiscal N '+
            '  INNER JOIN TB_PEDIDO P '+
            '  ON (P.ped_codigo = N.nfl_codped) '+
            '  INNER JOIN tb_formapagto F '+
            '  ON (F.fpt_codigo = P.ped_codfpg)'+
            'WHERE N.nfl_codped  IN (' + MontaListaPedido + ')'+
            'GROUP BY 1 ');
    Active := True;
    first;
    Contador := 0;
    while not eof do
    Begin
      CriarComponente(Contador,FieldByName('FPT_DESCRICAO').AsString,FieldByName('TOTAL').AsCurrency);
      Next;
      inc(Contador);
      Qrb_Sumario.Height := 23 * Contador
    End;
  End;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

procedure TRL_ReportMapaCarga.SelectSql;
begin
  SelectTxt := 'SELECT PED_DATA, PED_NUMERO, EMP_FANTASIA, FPT_DESCRICAO,  NFL_VL_TL_NOTA '+
               'FROM tb_nota_fiscal N ';
end;

procedure TRL_ReportMapaCarga.WhereSql;
begin
  WhereTxt :=
  ' WHERE PED_CODIGO IN (' + MontaListaPedido + ')' ;
end;

end.
