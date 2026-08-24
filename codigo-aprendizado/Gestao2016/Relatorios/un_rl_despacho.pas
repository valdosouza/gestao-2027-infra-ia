unit un_rl_despacho;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_despacho = class(TForm)
    qr_despacho: TSTQuery;
    dts_despacho: TDataSource;
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    QRLabel8: TQRLabel;
    QRLabel1: TQRLabel;
    Qrg_Empresa: TQRGroup;
    QRLabel2: TQRLabel;
    QRDBText5: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand2: TQRBand;
    QRGroup1: TQRGroup;
    QRLabel11: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel7: TQRLabel;
    Detalhe: TQRBand;
    QRDBText8: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRGroup2: TQRGroup;
    QRDBText1: TQRDBText;
    QRLabel9: TQRLabel;
    QRDBText2: TQRDBText;
    QRBand3: TQRBand;
    QRShape2: TQRShape;
    QRLabel10: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRDBText4Print(sender: TObject; var Value: String);
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText7Print(sender: TObject; var Value: String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Linha: Integer;
  procedure Pc_Busca;
  Function Fc_Qtd_N_Despachada(Fc_Cd_itf:Integer):String;
  end;

var
  RL_despacho: TRL_despacho;

implementation

{$R *.dfm}

uses
Un_DM, un_sistema, Un_Despacho, env;
{ TRL_despacho }

procedure TRL_despacho.Pc_Busca;
var
  Lc_Sqltxt: string;
  Lc_Codped, Lc_Cliente, Lc_Codpro, Lc_Produto: Boolean;
begin
  with Fr_Despacho do
    Begin
    Lc_Sqltxt := '';
    qr_despacho.Active:=false;
    qr_despacho.sql.Clear;

    if E_CodPed.Text = '' then Lc_Codped := False else Lc_Codped := True;
    if Cb_Busca_Empresa.Text = '' then Lc_Cliente := False else Lc_Cliente := True;
    if (Fm_ListaProdutos.E_Cd_Produto.Text = '') then Lc_Codpro := false else Lc_Codpro := true;
    if (Fm_ListaProdutos.E_Busca_Produto.Text = '') then Lc_Produto := false else Lc_Produto := true;

    Lc_Sqltxt := 'SELECT '+
                 '   ITF_CODIGO, '+
                 '   PRO_CODIGO, '+
                 '   PRO_CODIGOFAB, '+
                 '   PRO_DESCRICAO, '+
                 '   ITF_QTDE, '+
                 '   ITF_VL_UNIT, '+
                 '   ITF_CODPRO, '+
                 '   (ITF_QTDE* ITF_VL_UNIT) ITF_VL_SB_TOTAL,  '+
                 '   PED_DATA, '+
                 '   PRO_CODIGOFOR, '+
                 '   ITF_DESPACHO, '+
                 '   NFL_CODIGO, '+
                 '   EMP_NOME, '+
                 '   EMP_FANTASIA, '+
                 '   PED_NUMERO,  '+
                 '   NFL_NUMERO, '+
                 '   NFL_DT_EMISSAO, '+
                 '   NFL_VL_TL_NOTA, '+
                 '  PED_CODIGO,  '+
                 '  PED_DT_ENTREGA, '+
                 '  DSP_DT_PREVISTA, '+
                 '  DSP_DT_REALIZADA, '+
                 '  DSP_QTDE '+
                 'FROM TB_DESPACHO DSP  '+
                 '   INNER JOIN TB_ITENS_NFL ITF  '+
                 '   ON (ITF.ITF_CODIGO = DSP.DSP_CODITF) '+
                 '   INNER JOIN TB_NOTA_FISCAL NFL  '+
                 '   ON (NFL.nfl_codigo = ITF.itf_codnfl)  '+
                 '   INNER JOIN TB_PEDIDO PED  '+
                 '   ON (PED.PED_CODIGO = NFL.NFL_CODPED) '+
                 '   INNER JOIN TB_PRODUTO PRO '+
                 '   ON (PRO.PRO_CODIGO = ITF.ITF_CODPRO) '+
                 '   INNER JOIN TB_EMPRESA EMP  '+
                 '   ON (EMP.EMP_CODIGO = NFL.nfl_codemp)  '+
                 'WHERE (PED_TIPO = 1) ';

    if rg_Filtro.ItemIndex = 0 then
      Begin
      Lc_Sqltxt := Lc_Sqltxt + ' AND (DSP_SITUACAO = ''P'') ';
      end
    else
    if Rg_Filtro.ItemIndex = 1 then
      Begin
      Lc_Sqltxt := Lc_Sqltxt + ' AND (DSP_SITUACAO = ''S'') ';
      end;

    if Lc_Codped then Lc_Sqltxt := Lc_Sqltxt + 'AND (PED_NUMERO =:PED_NUMERO) ';
    IF ChBx_Periodo.Checked then Lc_Sqltxt := Lc_Sqltxt + 'AND (PED_DATA BETWEEN :DATAINI AND :DATAFIM) ';
    if Lc_Cliente then Lc_Sqltxt := Lc_Sqltxt + 'AND ( (EMP_NOME LIKE :EMP_NOME) or (EMP_FANTASIA LIKE :EMP_NOME) ) ';
    if Lc_Codpro then Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGO =:PRO_CODIGO) or (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO))';
    if Lc_Produto then Lc_Sqltxt := Lc_Sqltxt + 'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

    qr_despacho.SQL.Add(Lc_Sqltxt + 'ORDER BY EMP_NOME,PED_NUMERO,ITF_CODIGO,  PED_DATA ');

    if Lc_Codped then qr_despacho.ParamByName('PED_NUMERO').AsString := E_CodPed.Text;
    IF ChBx_Periodo.Checked then
      Begin
      qr_despacho.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      qr_despacho.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
      end;
    if Lc_Cliente then qr_despacho.ParamByName('EMP_NOME').AsString := '%' + Copy(Cb_Busca_Empresa.Text,1,98) + '%';
    if Lc_Codpro then qr_despacho.ParamByName('PRO_CODIGO').AsString := Fm_ListaProdutos.E_Cd_Produto.Text;
    if Lc_Produto then qr_despacho.ParamByName('PRO_DESCRICAO').AsString := '%'+Copy(Fm_ListaProdutos.E_Busca_Produto.Text,1,98)+'%';

    qr_despacho.Active := true;
    qr_despacho.FetchAll;
    qr_despacho.First;
    end;
end;

procedure TRL_despacho.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
end;

procedure TRL_despacho.QRDBText4Print(sender: TObject; var Value: String);
begin
  if qr_despacho.FieldByName('DSP_DT_REALIZADA').IsNull then Value:= SIM else Value:= NAO
end;

procedure TRL_despacho.QRDBText1Print(sender: TObject; var Value: String);
begin
  if qr_despacho.FieldByName('DSP_DT_REALIZADA').IsNull then Color := clBlack else Color := clRed;
end;

procedure TRL_despacho.QRDBText7Print(sender: TObject; var Value: String);
begin
  if qr_despacho.FieldByName('DSP_QTDE').AsFloat = 0 then  Value:= Fc_Qtd_N_Despachada(qr_despacho.FieldByName('ITF_CODIGO').AsInteger) else Value:= FormatFloat('#,##0.00',qr_despacho.FieldByName('DSP_QTDE').AsFloat);
end;

function TRL_despacho.Fc_Qtd_N_Despachada(Fc_Cd_itf: Integer): String;
var
qr_aux:TSTQuery;
begin
 qr_aux:=TSTQuery.Create(selF);
 qr_aux.Database:= DM.IBD_Gestao;
 qr_aux.Transaction:= DM.IB_Transacao;
 

 qr_aux.Active:=false;
 qr_aux.SQL.Clear;
 qr_aux.SQL.Add('select Sum(dsp_qtde) Qtd from tb_despacho where dsp_coditf =:dsp_coditf ');
 qr_aux.ParamByName('dsp_coditf').AsInteger:=Fc_Cd_itf;
 qr_aux.Active:=true;

 Result:= FormatFloat('#,##0.00', qr_despacho.FieldByName('ITF_QTDE').AsFloat - qr_aux.fieldbyname('Qtd').AsFloat);

 FreeAndNil(qr_aux);
end;

procedure TRL_despacho.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_despacho:=nil;
end;

end.
