unit Un_RL_Financeiro_Comissao;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, QRCtrls, QuickRpt, ExtCtrls, STQuery, StdCtrls, prmComissao;

type
  TRL_Financeiro_Comissao = class(TForm)
    Qr_Duplicatas: TSTQuery;
    Qrpt: TQuickRep;
    Grupo1: TQRGroup;
    E_Empresa: TQRDBText;
    QRLabel4: TQRLabel;
    QRExpr5: TQRExpr;
    Detalhe: TQRBand;
    E_Pedido: TQRDBText;
    E_Financeiro: TQRDBText;
    E_Vl_Parcela: TQRDBText;
    E_VL_Pago: TQRDBText;
    E_Dt_Pagto: TQRDBText;
    Sumario: TQRBand;
    Lb_Data_Fim: TQRLabel;
    PageHeaderBand1: TQRBand;
    QRLabel10: TQRLabel;
    Lb_Titulo: TQRLabel;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    E_Nome: TQRDBText;
    E_VL_Comissao: TQRDBText;
    Lb_Vl_Tl_Baixas: TQRLabel;
    Lb_Vl_Sd_p_comissao: TQRLabel;
    Lb_Vl_Tl_Pagar: TQRLabel;
    Lb_Vl_Sd_Comissao: TQRLabel;
    E_Aq_Comissao: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Vendedor: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    Lb_Vl_Tl_devolucoes: TQRLabel;
    QRLabel23: TQRLabel;
    Lb_Vl_Tl_Pago: TQRLabel;
    lB_cONTADOR: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetalheAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure SumarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    FParamComissao: TParamComissao;
    { Private declarations }
    procedure Pc_totalizar_Recebimento;
    procedure Pc_totalizar_Comissao;
    procedure Pc_Parametros;
    procedure setFParamComissao(const Value: TParamComissao);
  public
    { Public declarations }

  //Totais
  It_Nome : String;
  It_Nr_Financeiro : String;

  procedure Pc_Busca;
  property Parametros : TParamComissao read FParamComissao write setFParamComissao;
  end;

var
  RL_Financeiro_Comissao: TRL_Financeiro_Comissao;

implementation

uses     Un_DM, UN_Sistema, ComCtrls, ControllerBase;
{$R *.dfm}

procedure TRL_Financeiro_Comissao.Pc_totalizar_Recebimento;
Var
  Lc_Vendedor: boolean;
  Lc_Pedido : boolean;
  Lc_Cd_Financeiro : Integer;
  Lc_Vl_Recebido : Real;
  Lc_Vl_Devolvido : Real;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                    'SELECT COM_CODFIN, COM_VL_DOC ',
                    'FROM TB_COMISSAO Tb_comissao ' ,
                    '    INNER JOIN TB_FINANCEIRO Tb_financeiro ' ,
                    '    ON  (Tb_financeiro.FIN_CODIGO = Tb_comissao.COM_CODFIN) ' ,
                    '    INNER JOIN TB_PEDIDO Tb_pedido ' ,
                    '    ON  (Tb_pedido.PED_CODIGO = Tb_financeiro.FIN_CODPED) ' ,
                    '    INNER JOIN TB_EMPRESA Tb_empresa ' ,
                    '    ON  (Tb_empresa.EMP_CODIGO = Tb_comissao.COM_CODEMP) ' ,
                    '    INNER JOIN TB_COLABORADOR Tb_Colaborador ' ,
                    '    ON  (Tb_Colaborador.CLB_CODIGO = Tb_comissao.COM_CODVDO) ' ,
                    'WHERE (COM_CODMHA =:COM_CODMHA) '));

      if FParamComissao.CodigoVendedor > 0 then SQL.Add(' AND ( COM_CODVDO =:COM_CODVDO ) ');
      if FParamComissao.Periodo then SQL.Add( 'AND COM_DT_VENDA BETWEEN :DATAINI AND :DATAFIM  ');
      if FParamComissao.SituacaoComissao = 'Paga' then
        SQL.Add(' AND COM_DT_PAGTO IS NOT NULL ');
      if FParamComissao.SituacaoComissao = 'Não Paga' then
        SQL.Add(' AND COM_DT_PAGTO IS NULL ');

      SQL.Add(' ORDER BY COM_CODFIN ');

      IF FParamComissao.Periodo THEN
      begin
        ParamByName('DATAINI').AsDate:= FParamComissao.dataInicial;
        ParamByName('DATAFIM').AsDate:= FParamComissao.DataFinal;
      end;

      if FParamComissao.CodigoVendedor > 0 then
        ParamByName('COM_CODVDO').AsInteger := FParamComissao.CodigoVendedor;

      ParamByName('COM_CODMHA').AsInteger := FParamComissao.CodigoEstabelecimento;
      Active := True;
      FetchAll;
      First;
      Lc_Cd_Financeiro := 0;
      Lc_Vl_Recebido := 0;
      Lc_Vl_Devolvido := 0;
      while not Eof do
      Begin
        if (Lc_Cd_Financeiro <> FieldByName('COM_CODFIN').AsInteger) then
        Begin
          if (FieldByName('COM_VL_DOC').AsCurrency > 0) then
            Lc_Vl_Recebido := Lc_Vl_Recebido + FieldByName('COM_VL_DOC').AsCurrency
          else
            Lc_Vl_Devolvido := Lc_Vl_Devolvido + FieldByName('COM_VL_DOC').AsCurrency;
        end;
        Lc_Cd_Financeiro := FieldByName('COM_CODFIN').AsInteger;
        Next;
      end;
      Lb_Vl_Tl_Baixas.Caption := FloatToStrF(Lc_Vl_Recebido,ffNumber,10,2);
      Lc_Vl_Devolvido := Lc_Vl_Devolvido * -1;
      Lb_Vl_Tl_devolucoes.Caption := FloatToStrF(Lc_Vl_Devolvido,ffNumber,10,2);
      Lb_Vl_Sd_p_comissao.Caption := FloatToStrF(Lc_Vl_Recebido - Lc_Vl_Devolvido,ffNumber,10,2);
      Screen.Cursor := crDefault;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TRL_Financeiro_Comissao.Pc_totalizar_Comissao;
Var
  Lc_SqlTxt : String;
  Lc_Vendedor: boolean;
  Lc_Pedido: boolean;
  Lc_Vl_Pago  : Real;
  Lc_Vl_Pagar : Real;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                  'SELECT COM_VL_COM, COM_DT_PAGTO ' ,
                  'FROM TB_COMISSAO Tb_comissao ' ,
                  '    INNER JOIN TB_PEDIDO Tb_pedido ' ,
                  '    ON  (Tb_pedido.PED_CODIGO = Tb_comissao.COM_CODPED) ' ,
                  '    INNER JOIN TB_COLABORADOR Tb_Colaborador ' ,
                  '    ON  (Tb_Colaborador.CLB_CODIGO = Tb_comissao.COM_CODVDO) ',
                  'WHERE (COM_CODMHA =:COM_CODMHA) '
                  ));


      if FParamComissao.CodigoVendedor > 0 then SQL.Add(' AND ( COM_CODVDO =:COM_CODVDO ) ');
      if FParamComissao.Periodo then SQL.Add( 'AND COM_DT_VENDA BETWEEN :DATAINI AND :DATAFIM  ');
      if FParamComissao.SituacaoComissao = 'Paga' then
        SQL.Add(' AND COM_DT_PAGTO IS NOT NULL ');
      if FParamComissao.SituacaoComissao = 'Não Paga' then
        SQL.Add(' AND COM_DT_PAGTO IS NULL ');

      SQL.Add(' ORDER BY COM_CODFIN ');

      IF FParamComissao.Periodo THEN
      begin
        ParamByName('DATAINI').AsDate:= FParamComissao.dataInicial;
        ParamByName('DATAFIM').AsDate:= FParamComissao.DataFinal;
      end;

      if FParamComissao.CodigoVendedor > 0 then
        ParamByName('COM_CODVDO').AsInteger := FParamComissao.CodigoVendedor;

      ParamByName('COM_CODMHA').AsInteger := FParamComissao.CodigoEstabelecimento;
      Active := True;
      FetchAll;
      First;
      Lc_Vl_Pago := 0;
      Lc_Vl_Pagar := 0;
      while not Eof do
        Begin
        if (FieldByName('COM_DT_PAGTO').AsString) = '' then
          Lc_Vl_Pagar := Lc_Vl_Pagar + FieldByName('COM_VL_COM').AsCurrency
        else
          Lc_Vl_Pago := Lc_Vl_Pago + FieldByName('COM_VL_COM').AsCurrency;
        Next;
        end;
      Lb_Vl_Tl_Pago.Caption := FloatToStrF(Lc_Vl_Pago,ffNumber,10,2);
      Lb_Vl_Tl_Pagar.Caption := FloatToStrF(Lc_Vl_Pagar,ffNumber,10,2);
      Lb_Vl_Sd_comissao.Caption := FloatToStrF(Lc_Vl_Pagar - Lc_Vl_Pago,ffNumber,10,2);
      Screen.Cursor := crDefault;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TRL_Financeiro_Comissao.Pc_Busca;
Var
  Lc_SqlTxt:string;
  Lc_nome:Boolean;
  Lc_Vendedor : boolean;
begin
  Screen.Cursor:=crHourGlass;
  Qr_Duplicatas.Close;
  Qr_Duplicatas.SQL.Clear;
  Qr_Duplicatas.SQL.add(concat(
                'SELECT FIN_CODEMP, EMP_NOME, EMP_FANTASIA,CLB_NOME, FIN_CODIGO, ',
                'FIN_NUMERO,PED_NUMERO, FIN_VL_PARCELA, COM_VL_DOC, FIN_DT_PAGTO,',
                'COM_VL_COM, FIN_OPERACAO, COM_DT_PAGTO                          ',
                'FROM TB_COMISSAO Tb_comissao ' ,
                '    INNER JOIN TB_FINANCEIRO Tb_financeiro ' ,
                '    ON  (Tb_financeiro.FIN_CODIGO = Tb_comissao.COM_CODFIN) ' ,
                '    INNER JOIN TB_PEDIDO Tb_pedido ' ,
                '    ON  (Tb_pedido.PED_CODIGO = Tb_financeiro.FIN_CODPED) ' ,
                '    INNER JOIN TB_EMPRESA Tb_empresa ' ,
                '    ON  (Tb_empresa.EMP_CODIGO = Tb_comissao.COM_CODEMP) ' ,
                '    INNER JOIN TB_COLABORADOR Tb_Colaborador ' ,
                '    ON  (Tb_Colaborador.CLB_CODIGO = Tb_comissao.COM_CODVDO) ' ,
               'WHERE ( (FIN_TIPO = ''RA'') or (FIN_TIPO = ''RM'') )            ',
               '  AND   (FIN_BAIXA=''S'') AND (FIN_CODMHA=:FIN_CODMHA)          '));

  if FParamComissao.CodigoVendedor > 0 then Qr_Duplicatas.SQL.Add(' AND ( COM_CODVDO =:COM_CODVDO ) ');
  if FParamComissao.Periodo then Qr_Duplicatas.SQL.Add( 'AND COM_DT_VENDA BETWEEN :DATAINI AND :DATAFIM  ');
  if FParamComissao.SituacaoComissao = 'Paga' then
    Qr_Duplicatas.SQL.Add(' AND COM_DT_PAGTO IS NOT NULL ');
  if FParamComissao.SituacaoComissao = 'Não Paga' then
    Qr_Duplicatas.SQL.Add(' AND COM_DT_PAGTO IS NULL ');

  Qr_Duplicatas.SQL.Add(' ORDER BY COM_CODFIN ');

  IF FParamComissao.Periodo THEN
  begin
    Qr_Duplicatas.ParamByName('DATAINI').AsDate:= FParamComissao.dataInicial;
    Qr_Duplicatas.ParamByName('DATAFIM').AsDate:= FParamComissao.DataFinal;
  end;

  if FParamComissao.CodigoVendedor > 0 then
    Qr_Duplicatas.ParamByName('COM_CODVDO').AsInteger := FParamComissao.CodigoVendedor;

  Qr_Duplicatas.ParamByName('FIN_CODMHA').AsInteger := FParamComissao.CodigoEstabelecimento;
  Qr_Duplicatas.Active:=True;
  Qr_Duplicatas.FetchAll;
  Qr_Duplicatas.First;

  Screen.Cursor:=crDefault;


end;

procedure TRL_Financeiro_Comissao.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  It_Nome := '';
  It_Nr_Financeiro := '';
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Financeiro_Comissao.setFParamComissao(
  const Value: TParamComissao);
begin
  FParamComissao := Value;
end;

procedure TRL_Financeiro_Comissao.Pc_Parametros;
begin
  with FParamComissao do
  begin
    // Verifica data solicitada
    if Periodo then
    Begin
      Lb_Data_Ini.Caption := DateToStr( DataInicial);
      Lb_Data_Fim.Caption := DateToStr( DataFinal);
    end
    else
    Begin
      Lb_Data_Ini.Caption := '';
      Lb_Data_Fim.Caption := '';
    end;
    // Verifica se o campo cliente foi preenchido
    if CodigoVendedor = 0 then
      Lb_Vendedor.Caption := 'Todos'
    else
      Lb_Vendedor.Caption := NomeVendedor;
  end;
end;

procedure TRL_Financeiro_Comissao.DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_Aq_Com : Real;
begin
  if (Qr_Duplicatas.FieldByname('CLB_NOME').AsString = It_Nome) then
    E_Nome.Font.Color := clWhite
  else
    E_Nome.Font.Color := clBlack;
{
  if (Qr_DuplicatasFIN_NUMERO.AsString = It_Nr_Financeiro) then
    Begin
    E_Financeiro.Font.Color := clWhite;
    E_Pedido.Font.Color := clWhite;
    E_Vl_Parcela.Font.Color := clWhite;
    E_VL_Pago.Font.Color := clWhite;
    E_Dt_Pagto.Font.Color := clWhite;
    end
  else
    Begin
    E_Financeiro.Font.Color := clBlack;
    E_Pedido.Font.Color := clBlack;
    E_Vl_Parcela.Font.Color := clBlack;
    E_VL_Pago.Font.Color := clBlack;
    E_Dt_Pagto.Font.Color := clBlack;
    end;
  }
  //Aliquota no Detalhe
  Lc_Aq_Com := (Qr_Duplicatas.FieldByname('COM_VL_COM').AsCurrency / Qr_Duplicatas.FieldByname('COM_VL_DOC').AsCurrency) *100;
  E_Aq_Comissao.Caption := FloatToStrF(Lc_Aq_Com,ffFixed,2,2);
end;

procedure TRL_Financeiro_Comissao.DetalheAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  It_Nome := Qr_Duplicatas.FieldByname('CLB_NOME').AsString;
  It_Nr_Financeiro := Qr_Duplicatas.FieldByname('FIN_NUMERO').AsString;
end;

procedure TRL_Financeiro_Comissao.SumarioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_totalizar_Recebimento;
  Pc_totalizar_Comissao;
end;

end.
