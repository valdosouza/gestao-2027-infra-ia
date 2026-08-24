unit Un_RL_Comi_Previsao;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery, prmComissao;

type
  TRL_Comi_Previsao = class(TForm)
    Qrpt: TQuickRep;
    DetalheVenda: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText3: TQRDBText;
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
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    QRBand4: TQRBand;
    QRLabel8: TQRLabel;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRLabel13: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Lb_Vendedor: TQRLabel;
    QRLabel22: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel4: TQRLabel;
    Qr_Comissao: TSTQuery;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Lb_Data_IniPrint(sender: TObject; var Value: String);
    procedure Lb_Data_FimPrint(sender: TObject; var Value: String);
    procedure Lb_VendedorPrint(sender: TObject; var Value: String);
  private
    FParamComissao: TParamComissao;
    procedure setFParamComissao(const Value: TParamComissao);
    procedure Pc_Parametros;
    { Private declarations }
  public
    { Public declarations }
  procedure Pc_Busca;
  property Parametros : TParamComissao read FParamComissao write setFParamComissao;
  end;

var
  RL_Comi_Previsao: TRL_Comi_Previsao;

implementation

uses     Un_sistema;
procedure TRL_Comi_Previsao.Pc_Busca;
var
 SqlTxt:String;
 Lc_Vendedor:Boolean;
begin
  Screen.Cursor:=crHourGlass;
  Qr_Comissao.Close;
  Qr_Comissao.SQL.Clear;
  Qr_Comissao.SQL.add(Concat(
            ' SELECT DISTINCT CLB_CODIGO,PED_CODIGO, PED_DATA, PED_NUMERO, ',
            'PED_CODEMP, EMP_NOME, PED_CODVDO, CLB_NOME, NFL_VL_TL_NOTA ',
            ' FROM TB_PEDIDO tb_pedido ',
            '     INNER JOIN TB_ITENS_NFL tb_itens_nfl ',
            '     ON  (tb_itens_nfl.itf_codped = tb_pedido.ped_codigo) ',
            '     INNER JOIN TB_COLABORADOR Tb_Colaborador ',
            '     ON  (Tb_Colaborador.CLB_CODIGO = tb_pedido.ped_codvdo) ',
            '     inner join TB_EMPRESA tb_empresa ',
            '     ON  (tb_empresa.emp_codigo = tb_pedido.ped_codemp) ',
            '  inner join TB_NOTA_FISCAL tb_nota_fiscal ',
            '    ON  (tb_nota_fiscal.nfl_codped = tb_pedido.ped_codigo) ',
            ' WHERE (PED_CODIGO IS NOT NULL) AND (PED_CODMHA=:PED_CODMHA) '));

  if FParamComissao.CodigoVendedor > 0 then
    Qr_Comissao.SQL.Add(' AND PED_CODVDO =:PED_CODVDO ');

  if FParamComissao.Periodo then
    Qr_Comissao.SQL.Add(' AND PED_DATA BETWEEN :DATAINI AND :DATAFIM  ');

  Qr_Comissao.SQL.Add(' ORDER BY CLB_NOME, PED_DATA ');
  if FParamComissao.CodigoVendedor > 0 then
    Qr_Comissao.ParamByName('PED_CODVDO').AsInteger:= FParamComissao.CodigoVendedor;
  if FParamComissao.Periodo then
  begin
    Qr_Comissao.ParamByName('DATAINI').AsDate:= FParamComissao.DataInicial;
    Qr_Comissao.ParamByName('DATAFIM').AsDate:= FParamComissao.DataFinal
  end;
  Qr_Comissao.ParamByName('PED_CODMHA').AsInteger := FParamComissao.CodigoEstabelecimento;
  Qr_Comissao.Open;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Comi_Previsao.Pc_Parametros;
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

procedure TRL_Comi_Previsao.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Comi_Previsao.setFParamComissao(const Value: TParamComissao);
begin
  FParamComissao := Value;
end;

procedure TRL_Comi_Previsao.Lb_Data_IniPrint(sender: TObject;
  var Value: String);
begin
   Value:=DateToStr( FParamComissao.DataInicial );
end;

procedure TRL_Comi_Previsao.Lb_Data_FimPrint(sender: TObject;
  var Value: String);
begin
   Value:=DateToStr( FParamComissao.DataFinal );
end;

procedure TRL_Comi_Previsao.Lb_VendedorPrint(sender: TObject;
  var Value: String);
begin
  if FParamComissao.CodigoVendedor = 0 then
    Value :=' TODOS'
  else
    Value:= FParamComissao.NomeVendedor;
end;

end.
