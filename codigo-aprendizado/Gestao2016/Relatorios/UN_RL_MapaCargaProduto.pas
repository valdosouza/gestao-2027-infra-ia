unit UN_RL_MapaCargaProduto;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, QRCtrls, QuickRpt, ExtCtrls, jpeg, StdCtrls;

type
  TRL_MapaCargaProduto = class(TForm)
    Qrpt: TQuickRep;
    Qrp_Produto: TQRGroup;
    Titulo: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    bndDetalhe: TQRBand;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel8: TQRLabel;
    Qr_MapaCarga: TSTQuery;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel2: TQRLabel;
    E_NomeMotorista: TQRLabel;
    QRLabel6: TQRLabel;
    E_PlacaVeiculo: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand2: TQRBand;
    QRLabel7: TQRLabel;
    E_TL_Peso: TQRLabel;
    ChB_Lote: TQRChildBand;
    Qr_Lotes: TSTQuery;
    E_Lote: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText5: TQRDBText;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndDetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    It_Linha : integer;
  protected

  public
    { Public declarations }
    It_PesoTotal:Currency;
    TipoAgrupamento : Integer;
    MostraLote : Boolean;
    procedure Pc_Buscar;
    function Fc_BuscaLote(CodigoProduto : Integer):String;
  end;

var
  RL_MapaCargaProduto: TRL_MapaCargaProduto;

implementation

uses     UN_Sistema, UN_Imp_MapaCarga;
{$R *.dfm}
procedure TRL_MapaCargaProduto.Pc_Buscar;
Var
  SqlTxt : String;
  Lc_I : Integer;
  Lc_Str_Inclui : String;
Begin
  Screen.Cursor := crHourGlass;
  Qr_MapaCarga.Active := False;
  Qr_MapaCarga.SQL.Clear;
  if TipoAgrupamento = 0 then
  Begin
    sqltxt := concat(
                'SELECT ITF_CODPRO CODPRO, PRO_DESCRICAO, EMB_ABREVIATURA, CAST(COALESCE(SUM(ITF_QTDE), 0) AS DOUBLE PRECISION) TTL_QTDE, ',
                ' CAST(COALESCE(SUM(PRO_PESO * ITF_QTDE), 0) AS DOUBLE PRECISION) TTL_PESO ',
                'FROM TB_PEDIDO pd ',
                ' INNER JOIN TB_ITENS_NFL i ',
                ' ON  (i.ITF_CODPED = pd.PED_CODIGO) ',
                ' INNER JOIN TB_PRODUTO pr ',
                ' ON  (pr.PRO_CODIGO = i.ITF_codpro) ',
                ' INNER JOIN TB_EMBALAGEM eb ',
                ' ON (pr.PRO_CODEMB = eb.EMB_CODIGO) ',
                'WHERE (PED_FATURADO <> ''A'')  '
                );

  End
  else
  Begin
    sqltxt := concat(
                'SELECT CET_CODPRO CODPRO, PRO_DESCRICAO, EMB_ABREVIATURA, CAST(COALESCE(SUM(CET_QTDE), 0) AS DOUBLE PRECISION) TTL_QTDE, ',
                ' CAST(COALESCE(SUM(PRO_PESO * CET_QTDE), 0) AS DOUBLE PRECISION) TTL_PESO ',
                'FROM TB_PEDIDO pd ',
                ' INNER JOIN TB_ITENS_NFL i ',
                ' ON  (i.ITF_CODPED = pd.PED_CODIGO) ',
                ' inner join tb_ctrl_estoque ce ',
                ' on (ce.cet_item_ctrl =i.itf_codigo ) ',
                ' INNER JOIN TB_PRODUTO pr ',
                ' ON  (pr.PRO_CODIGO = ce.cet_codpro) ',
                ' INNER JOIN TB_EMBALAGEM eb ',
                ' ON (pr.PRO_CODEMB = eb.EMB_CODIGO) ',
                'WHERE (PED_FATURADO <> ''A'')  '
                );
  End;

  Lc_Str_Inclui := '';
  with Fr_Imp_MapaCarga do
  Begin
    For Lc_I := 1 to StrGrd_Pedido.RowCount -1 do
    Begin
      if StrGrd_Pedido.Cells[8,Lc_I] = 'X' then
        if Trim(Lc_Str_Inclui)='' then
          Lc_Str_Inclui := Lc_Str_Inclui + StrGrd_Pedido.Cells[1,lc_i]
        else
          Lc_Str_Inclui := Lc_Str_Inclui + ','+StrGrd_Pedido.Cells[1,lc_i];
    End;
  end;
  Lc_Str_Inclui := concat(
                    ' and  (PED_CODIGO IN (',
                    Lc_Str_Inclui,
                    ')) '
                  );

  SqlTxt :=   SqlTxt + Lc_Str_Inclui;
  SqlTxt :=   SqlTxt + ' GROUP BY 1,2,3 ';
  SqlTxt :=   SqlTxt + ' ORDER BY PRO_DESCRICAO ';

  Qr_MapaCarga.SQL.Add(SqlTxt);
  Qr_MapaCarga.Active := TRUE;
  Screen.Cursor := crDefault;
end;

procedure TRL_MapaCargaProduto.bndDetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  LcLote : String;
begin
  inc(It_Linha);
  if (It_Linha mod 2) = 0 then bndDetalhe.Color := clSilver else bndDetalhe.Color := clWhite;
  It_PesoTotal := It_PesoTotal  + Qr_MapaCarga.FieldByName('TTL_PESO').asfloat;
  if MostraLote then
  Begin
    LcLote := Fc_BuscaLote(Qr_MapaCarga.FieldByName('CODPRO').AsInteger);
    if ( Length(LcLote) >0 ) then
    Begin
      ChB_Lote.Height := 17;
      E_Lote.Caption := 'Lotes utilizados : ' +  LcLote;
      ChB_Lote.Visible := True;
    End
    else
    Begin
      ChB_Lote.Height := 0;
      E_Lote.Caption := '';
      ChB_Lote.Visible := False;
    End;
  End;
end;

function TRL_MapaCargaProduto.Fc_BuscaLote(CodigoProduto : Integer):String;
Var
  SqlTxt : String;
  Lc_I : Integer;
  Lc_Str_Inclui : String;
  LcCodigoVinculo : String;
Begin
  Screen.Cursor := crHourGlass;
  with Qr_Lotes do
  Begin
    Active := False;
    SQL.Clear;
    sqltxt := concat(
                  'SELECT ITF_CODIGO ',
                  'FROM TB_PEDIDO pd ',
                  '   INNER JOIN TB_ITENS_NFL i ',
                  '   ON  (i.ITF_CODPED = pd.PED_CODIGO) ',
                  '   inner join tb_ctrl_estoque ce ',
                  '   on (ce.cet_item_ctrl =i.itf_codigo ) ',
                  'WHERE (ce.cet_CODPRO =:PRO_CODIGO) '
              );

    Lc_Str_Inclui := '';
    with Fr_Imp_MapaCarga do
    Begin
      For Lc_I := 1 to StrGrd_Pedido.RowCount -1 do
      Begin
        if StrGrd_Pedido.Cells[8,Lc_I] <> '' then
          if trim(Lc_Str_Inclui) = '' then
            Lc_Str_Inclui := Lc_Str_Inclui + StrGrd_Pedido.Cells[1,lc_i]
          else
            Lc_Str_Inclui := Lc_Str_Inclui + ','+StrGrd_Pedido.Cells[1,lc_i];
      End;
    end;
    Lc_Str_Inclui := concat(
                    ' and  (PED_CODIGO IN (',
                    Lc_Str_Inclui,
                    ')) '
                  );
    SqlTxt := concat(SqlTxt, Lc_Str_Inclui);
    SQL.Add(SqlTxt);
    ParamByName('PRO_CODIGO').AsInteger := CodigoProduto;
    LcCodigoVinculo := '';
    Active := TRUE;
    first;
    if RecordCount > 0 then
    Begin
      //Valor relacionar os ITF_Codigo para procurar no movimento do lote
      LcCodigoVinculo := ' WHERE ( M.MLT_TIPO LIKE ''VENDA%'') AND  (M.MLT_CODVCL IN ( ';
      while not eof do
      Begin
        if bof then
          LcCodigoVinculo := LcCodigoVinculo + FieldByName('ITF_CODIGO').AsString
        else
          LcCodigoVinculo := LcCodigoVinculo + ',' + FieldByName('ITF_CODIGO').AsString;
        Next;
      End;
      LcCodigoVinculo := LcCodigoVinculo +')) ';
    End;
    //Faz a consulta no movimento do lote
    Active := False;
    SQL.Clear;
    sqltxt := concat(
                'SELECT DISTINCT CLT_NUMERO ',
                'FROM TB_CTRL_LOTE L ',
                '  INNER JOIN TB_MOVIMENTO_LOTE M ',
                '  ON (M.mlt_codclt = L.clt_codigo) ',
                LcCodigoVinculo
              );
    SQL.Add(SqlTxt);
    Active := TRUE;
    first;
    Result := '';
    while not eof do
    Begin
      if bof then
        Result := Result + FieldByName('CLT_NUMERO').AsString
      else
        Result := Result + ' / ' + FieldByName('CLT_NUMERO').AsString;
      Next;
    End;
  End;
  Screen.Cursor := crDefault;
end;

procedure TRL_MapaCargaProduto.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  It_Linha := 0;
  It_PesoTotal := 0;
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Buscar;
end;

procedure TRL_MapaCargaProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TRL_MapaCargaProduto.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_TL_Peso.Caption := FloatToStrF(It_PesoTotal,ffFixed,10,2);
end;

end.
