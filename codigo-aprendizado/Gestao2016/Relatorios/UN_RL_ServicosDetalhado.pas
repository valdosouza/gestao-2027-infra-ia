unit UN_RL_ServicosDetalhado;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_ServicosDetalhado = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    QRLabel8: TQRLabel;
    Gr_Cliente: TQRGroup;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel1: TQRLabel;
    Qr_Servico: TSTQuery;
    Gr_Frota: TQRGroup;
    QRDBText6: TQRDBText;
    QRLabel12: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel20: TQRLabel;
    QRDBText5: TQRDBText;
    QRDBText1: TQRDBText;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel19: TQRLabel;
    Detalhe: TQRBand;
    QRDBVenda: TQRDBText;
    QRDBITV_LINHA: TQRDBText;
    QRDBITV_QTDE: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText14: TQRDBText;
    Ft_Frota: TQRBand;
    QRLabel17: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    E_VeiculoMo: TQRLabel;
    E_VeiculoPecas: TQRLabel;
    E_VeiculoTotal: TQRLabel;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel23: TQRLabel;
    QRBand1: TQRBand;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    E_TotalMo: TQRLabel;
    E_TotalPecas: TQRLabel;
    E_TotalGeral: TQRLabel;
    QRDBText2: TQRDBText;
    Qr_ServicoEXT_CODORD: TIntegerField;
    Qr_ServicoPED_DATA: TDateField;
    Qr_ServicoITF_CODPED: TIntegerField;
    Qr_ServicoPRO_TIPO: TStringField;
    Qr_ServicoPRO_DESCRICAO: TStringField;
    Qr_ServicoITF_QTDE: TBCDField;
    Qr_ServicoITF_VL_UNIT: TBCDField;
    Qr_ServicoITF_VL_SUBTOTAL: TFloatField;
    Qr_ServicoITF_CODIGO: TIntegerField;
    Qr_ServicoEMP_NOME: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Ft_FrotaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Ft_FrotaAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_PecasV,It_MoV:Real;
    It_PecasT,It_MoT:Real;
    procedure Pc_buscar;
  end;

var
  RL_ServicosDetalhado: TRL_ServicosDetalhado;

implementation

uses     UN_DM, UN_Imp_Servico, UN_Sistema, ComCtrls;
{$R *.dfm}

procedure TRL_ServicosDetalhado.Pc_buscar;
VaR
  SqlTxt:String;
  Lc_Cliente,Lc_Data,Lc_Placa,Lc_Frota,Lc_OrdemI,Lc_ORdemF:Boolean;
begin
  with Fr_Imp_Servico do
    Begin
    Screen.Cursor:=crHourGlass;
    It_PecasT:=0;
    It_MoT:=0;
    It_PecasV:=0;
    It_MoV:=0;
    Qr_Servico.Close;
    Qr_Servico.SQL.Clear;

    SqlTxt:='SELECT EXT_CODORD, PED_DATA, ITF_CODPED, PRO_TIPO, PRO_DESCRICAO, ITF_QTDE,  ITF_VL_UNIT, '+
            '(ITF_QTDE * ITF_VL_UNIT) AS ITF_VL_SUBTOTAL, ITF_CODIGO,EMP_NOME '+
            'FROM TB_PEDIDO tb_pedido '+
            '   INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
            '   ON  (tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO) '+
            '   INNER JOIN TB_EMPRESA tb_empresa '+
            '   ON  (tb_empresa.EMP_CODIGO = Tb_pedido.PED_CODEMP) '+
            '   INNER JOIN TB_VENC_EXTINTOR tb_venc_extintor '+
            '   ON  (tb_venc_extintor.EXT_CODPED = Tb_pedido.PED_CODIGO) '+
            '  INNER JOIN TB_PRODUTO tb_produto '+
            '  ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) '+
            'WHERE (PED_FATURADO=''S'') ';


    if DBLCB_Empresa.Text ='' then Lc_Cliente := False else Lc_Cliente := True;

    if Lc_Cliente then SqlTxt := SqlTxt +'AND (PED_CODEMP =:PED_CODEMP) ';
    if ChBx_Periodo.Checked then  SqlTxt := SqlTxt +'AND PED_DATA BETWEEN :DATAINI AND :DATAFIM  ';

    if RG_Tipo.ItemIndex =0 then SqlTxt := SqlTxt + 'AND (PRO_TIPO=''P'')';
    if RG_Tipo.ItemIndex =1 then SqlTxt := SqlTxt + 'AND (PRO_TIPO=''S'')';

    Qr_Servico.SQL.Add(SqlTxt+'ORDER BY EMP_NOME,PED_NUMERO,PRO_TIPO,PRO_DESCRICAO');

    if lc_Cliente then Qr_Servico.ParamByName('PED_CODEMP').AsInteger:=DBLCB_Empresa.KeyValue;
    if ChBx_Periodo.Checked then Qr_Servico.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
    if ChBx_Periodo.Checked then Qr_Servico.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;

    Qr_Servico.Open;
    Screen.Cursor:=crDefault;
    end;
end;

procedure TRL_ServicosDetalhado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qRPT);
  Action:=caFree;
  RL_ServicosDetalhado:=nil;
end;

procedure TRL_ServicosDetalhado.DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Qr_ServicoPRO_TIPO.Value='P' then
    Begin
    It_PecasT:=It_PecasT+Qr_ServicoITF_VL_SUBTOTAL.Value;
    It_PecasV:=It_PecasV+Qr_ServicoITF_VL_SUBTOTAL.Value;
    end
  else
    begin
    It_MoT:=It_MoT+Qr_ServicoITF_VL_SUBTOTAL.Value;
    It_MoV:=It_MoV+Qr_ServicoITF_VL_SUBTOTAL.Value;
    end;

end;

procedure TRL_ServicosDetalhado.Ft_FrotaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_VeiculoPecas.Caption:=FloatToStrf(It_PecasV,ffNumber,18,2);
  E_VeiculoMo.Caption:=FloatToStrf(It_MoV,ffNumber,18,2);
  E_VeiculoTotal.Caption:=FloatToStrf(It_MoV+It_PecasV,ffNumber,18,2);
end;

procedure TRL_ServicosDetalhado.Ft_FrotaAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  It_PecasV:=0;
  It_MoV:=0;
end;

procedure TRL_ServicosDetalhado.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_TotalPecas.Caption:=FloatToStrf(It_PecasT,ffNumber,18,2);
  E_TotalMo.Caption:=FloatToStrf(It_MoT,ffNumber,18,2);
  E_TotalGeral.Caption:=FloatToStrf(It_MoT+It_PecasT,ffNumber,18,2);

end;

procedure TRL_ServicosDetalhado.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_BuscaR;
end;

end.
