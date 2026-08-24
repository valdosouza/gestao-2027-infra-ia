unit Un_RL_Notas;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_Notas = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel6: TQRLabel;
    DetalheVenda: TQRBand;
    QRBand4: TQRBand;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel7: TQRLabel;
    Qr_Vendas: TSTQuery;
    QRLabel8: TQRLabel;
    Grp_Data: TQRGroup;
    QRDBText1: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel19: TQRLabel;
    Lb_Tl_Emitida: TQRLabel;
    QRLabel1: TQRLabel;
    E_Cliente: TQRLabel;
    E_Motivo: TQRLabel;
    QRLabel9: TQRLabel;
    E_Pedido: TQRLabel;
    QRLabel10: TQRLabel;
    Lb_Tl_Cancelada: TQRLabel;
    QRLabel12: TQRLabel;
    Lb_Tl_Geral: TQRLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    It_Vl_Emitida, It_Vl_Cancelada : Real;
  public
    { Public declarations }
    procedure Pc_Busca;
    function Fc_Uniao_Nf_65():String;
  end;

var
  RL_Notas: TRL_Notas;

implementation

uses      Un_DM, UN_Backup, UN_Sistema, UN_Imp_Notas, ComCtrls, Un_Regra_Negocio, Un_Principal, env;
{$R *.dfm}

procedure TRL_Notas.Pc_Busca;
VaR
  SqlTxt:String;
  Lc_Cliente, Lc_Natureza, Lc_Data:Boolean;
begin
  with Fr_Imp_Notas, Qr_Vendas do
  Begin
    Screen.Cursor:=crHourGlass;
    It_Vl_Emitida := 0;
    It_Vl_Cancelada := 0;
    Close;
    SQL.Clear;
    SqlTxt := 'SELECT DISTINCT NFL_DT_EMISSAO, NFL_NUMERO NF_NUMERO, EMP_FANTASIA, NFL_CODIGO,PED_NUMERO,PED_VL_DESCONTO,NFL_MODELO, '+
              'NFL_VL_TL_NOTA,EMP_NOME, PED_TIPO, NAT_DESCRICAO,NFL_STATUS '+
              'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
              '    INNER JOIN TB_EMPRESA tb_empresa '+
              '    ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
              '    INNER JOIN TB_PEDIDO tb_pedido '+
              '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
              '    INNER JOIN TB_NATUREZA tb_natureza '+
              '    ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT) '+
              'WHERE (NFL_CODMHA=:NFL_CODMHA) '+
              '  AND (NFL_NUMERO <> '''') '+
              '  AND (NFL_NUMERO <> ''0'') '+
              '  AND ((NAT_REGISTRO = 0) OR (NAT_REGISTRO IS NULL))  ';


    if ChBx_Periodo.Checked then SqlTxt:= SqlTxt +' AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ';
    if DBLCB_Empresa.Text  = '' then Lc_Cliente  := False else Lc_Cliente  := True;
    if Fm_lista_cfop.Dblcb_Lista.Text = '' then Lc_Natureza := False else Lc_Natureza := True;


    if Lc_Cliente then SqlTxt := SqlTxt +'AND (NFL_CODEMP =:NFL_CODEMP) ';
    if Lc_Natureza then SqlTxt := SqlTxt +'AND (NFL_CODNAT =:NFL_CODNAT) ';

    SQL.Add( SqlTxt + ' ORDER BY  1,2,3 ');
    if Lc_Cliente  then ParamByName('NFL_CODEMP').AsInteger := DBLCB_Empresa.KeyValue;
    if Lc_Natureza then ParamByName('NFL_CODNAT').AsInteger := Fm_lista_cfop.Dblcb_Lista.KeyValue;
    ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;

    if ChBx_Periodo.Checked then
    begin
      ParamByName('DATAINI').AsDate:= E_Data_Ini.Date;
      ParamByName('DATAFIM').AsDate:= E_Data_Fim.Date;
    end;
    Open;
  end;
  Screen.Cursor:=crDefault;
end;


function TRL_Notas.Fc_Uniao_Nf_65():String;
VaR
  SqlTxt:String;
  Lc_Cliente, Lc_Natureza, Lc_Data:Boolean;
begin
  with Fr_Imp_Notas do
  Begin
    SqlTxt := ' UNION '+
              'SELECT DISTINCT NFL_DT_EMISSAO, NFL_NUMERO NF_NUMERO, EMP_FANTASIA, NFL_CODIGO,PED_NUMERO,PED_VL_DESCONTO,NFL_MODELO, '+
              'NFL_VL_TL_NOTA,EMP_NOME, PED_TIPO, NAT_DESCRICAO,NFL_STATUS '+
              'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
              '    INNER JOIN TB_EMPRESA tb_empresa '+
              '    ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
              '    INNER JOIN TB_PEDIDO tb_pedido '+
              '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
              '    INNER JOIN TB_NATUREZA tb_natureza '+
              '    ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT) '+
              '    INNER JOIN TB_RETORNO_NFC nfc '+
              '    ON (nfc.NFC_CODNFL = tb_nota_fiscal.NFL_CODIGO) '+
              'WHERE (NFL_CODMHA=:NFL_CODMHA) AND (NFL_MODELO = ''65'') ';

    if ChBx_Periodo.Checked then SqlTxt:= SqlTxt +' AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ';
    if DBLCB_Empresa.Text  = '' then Lc_Cliente  := False else Lc_Cliente  := True;
    if Fm_lista_cfop.Dblcb_Lista.Text = '' then Lc_Natureza := False else Lc_Natureza := True;
    if Lc_Cliente then SqlTxt := SqlTxt +'AND (NFL_CODEMP =:NFL_CODEMP) ';
    if Lc_Natureza then SqlTxt := SqlTxt +'AND (NFL_CODNAT =:NFL_CODNAT) ';
    result := SqlTxt;
  end;
end;

procedure TRL_Notas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Notas:=nil;
end;

procedure TRL_Notas.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Tl_Emitida.Caption:=FloatToStrF(It_Vl_Emitida,ffNumber,18,2);
  Lb_Tl_Cancelada.Caption:=FloatToStrF(It_Vl_Cancelada,ffNumber,18,2);
  Lb_Tl_Geral.Caption:=FloatToStrF(It_Vl_Emitida + It_Vl_Cancelada,ffNumber,18,2);
end;

procedure TRL_Notas.DetalheVendaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_Pedido.Caption := Qr_Vendas.FieldByName('PED_NUMERO').AsString;
  E_Motivo.Caption := Copy(Qr_Vendas.FieldByName('NAT_DESCRICAO').AsString,1,12);
  E_Cliente.Caption := Qr_Vendas.FieldByName('EMP_FANTASIA').AsString + ' - ' + Qr_Vendas.FieldByName('EMP_NOME').AsString;
  if Qr_Vendas.FieldByName('NFL_STATUS').AsString = 'C' then
    It_Vl_Cancelada := It_Vl_Cancelada + Qr_Vendas.FieldByName('NFL_VL_TL_NOTA').AsCurrency
  else
    It_Vl_Emitida := It_Vl_Emitida + Qr_Vendas.FieldByName('NFL_VL_TL_NOTA').AsCurrency;

  if Qr_Vendas.FieldByName('NFL_STATUS').AsString = 'C' THEN
    BEGIN
    QRDBText1.Font.Color:=clRed;
    E_Motivo.Font.Color:=clRed;
    E_Pedido.font.Color:=clRed;
    QRDBText4.Font.Color:=clRed;
    E_Cliente.Font.Color:=clRed;
    QRDBText3.Font.Color:=clRed;
    END
  ELSE
    BEGIN
    QRDBText1.Font.Color:=clBlack;
    E_Motivo.Font.Color:=clBlack;
    E_Pedido.Font.Color:=clBlack;
    QRDBText4.Font.Color:=clBlack;
    E_Cliente.Font.Color:=clBlack;
    QRDBText3.Font.Color:=clBlack;
    ENd;    
end;

procedure TRL_Notas.FormCreate(Sender: TObject);
begin
  Pc_AtivaEstabelecimento;
end;

procedure TRL_Notas.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
end;

end.
