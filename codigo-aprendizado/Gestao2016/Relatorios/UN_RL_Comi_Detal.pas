unit UN_RL_Comi_Detal;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, ExtCtrls, DB, STQuery, QRCtrls, prmComissao;

type
  TRL_Comi_Detal = class(TForm)
    Qrpt: TQuickRep;
    DetalheVenda: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText4: TQRDBText;
    Vendedor: TQRGroup;
    QRDBText6: TQRDBText;
    QRLabel10: TQRLabel;
    QRBand1: TQRBand;
    QRLabel7: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr4: TQRExpr;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRBand4: TQRBand;
    QRLabel8: TQRLabel;
    Qr_Comissao: TSTQuery;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel13: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Lb_Vendedor: TQRLabel;
    QRLabel22: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    FParamComissao: TParamComissao;
    procedure setFParamComissao(const Value: TParamComissao);
    { Private declarations }
  public
    { Public declarations }

  procedure Pc_Busca;
  procedure Pc_Parametros;
  property Parametros : TParamComissao read FParamComissao write setFParamComissao;
  end;

var
  RL_Comi_Detal: TRL_Comi_Detal;

implementation

uses     Mask, Un_DM, UN_Sistema, ComCtrls, un_principal, env;
{$R *.dfm}

procedure TRL_Comi_Detal.Pc_Busca;
begin
  Screen.Cursor:=crHourGlass;
  Qr_Comissao.Close;
  Qr_Comissao.SQL.Clear;
  Qr_Comissao.SQL.add(Concat(
          'SELECT COM_CODIGO, COM_DT_VENDA, COM_CODPED,PED_NUMERO, COM_CODEMP, EMP_NOME,  COM_CODVDO, ',
          'CLB_NOME, COM_VL_DOC, COM_AQ_COM, COM_VL_COM, COM_DT_PAGTO, CLB_CODIGO ',
          'FROM TB_COMISSAO Tb_comissao ',
          '    INNER JOIN TB_EMPRESA Tb_empresa ',
          '    ON  (Tb_empresa.EMP_CODIGO = Tb_comissao.COM_CODEMP) ',
          '    INNER JOIN TB_COLABORADOR Tb_Colaborador ',
          '    ON  (Tb_Colaborador.CLB_CODIGO = Tb_comissao.COM_CODVDO) ',
          '    INNER JOIN TB_PEDIDO Tb_pedido ',
          '    ON  (Tb_pedido.PED_CODIGO = Tb_comissao.COM_CODPED) ',
          'WHERE (COM_CODIGO IS NOT NULL) AND (COM_CODMHA=:COM_CODMHA) '));


  if FParamComissao.CodigoVendedor > 0 then
    Qr_Comissao.SQL.Add(' AND COM_CODVDO =:COM_CODVDO ');

  if FParamComissao.Periodo then
    Qr_Comissao.SQL.Add(' AND COM_DT_VENDA BETWEEN :DATAINI AND :DATAFIM  ');

  if FParamComissao.SituacaoComissao = 'Paga' then
    Qr_Comissao.SQL.Add(' AND COM_DT_PAGTO IS NOT NULL ');
  if FParamComissao.SituacaoComissao = 'Não Paga' then
    Qr_Comissao.SQL.Add(' AND COM_DT_PAGTO IS NULL ');

  Qr_Comissao.SQL.Add(FParamComissao.Ordenacao);
  if FParamComissao.CodigoVendedor > 0 then
    Qr_Comissao.ParamByName('COM_CODVDO').AsInteger:= FParamComissao.CodigoVendedor;
  if FParamComissao.Periodo then
  begin
    Qr_Comissao.ParamByName('DATAINI').AsDate:= FParamComissao.DataInicial;
    Qr_Comissao.ParamByName('DATAFIM').AsDate:= FParamComissao.DataFinal
  end;
  Qr_Comissao.ParamByName('COM_CODMHA').AsInteger := FParamComissao.CodigoEstabelecimento;
  Qr_Comissao.Open;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Comi_Detal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Comi_Detal:=nil;
end;

procedure TRL_Comi_Detal.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Comi_Detal.setFParamComissao(const Value: TParamComissao);
begin
  FParamComissao := Value;
end;

procedure TRL_Comi_Detal.Pc_Parametros;
begin
  with FParamComissao do
  begin
    Lb_Tipo_Doc.Caption := SituacaoComissao;
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

end.
