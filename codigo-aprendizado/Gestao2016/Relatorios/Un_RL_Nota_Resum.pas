unit Un_RL_Nota_Resum;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_Nota_Resum = class(TForm)
    Qrpt: TQuickRep;
    DetalheVenda: TQRBand;
    Vendedor: TQRGroup;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRBand4: TQRBand;
    Qr_Notas: TSTQuery;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Vendedor: TQRLabel;
    QRLabel22: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    E_Natureza: TQRDBText;
    E_VL_ICMS: TQRLabel;
    E_VL_ICMS_ST: TQRLabel;
    E_VL_PRODUTO: TQRLabel;
    E_VL_FRETE: TQRLabel;
    E_VL_SEGURO: TQRLabel;
    E_VL_DESPESAS: TQRLabel;
    E_VL_DESCONTO: TQRLabel;
    E_VL_NOTA: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel6: TQRLabel;
    E_VL_IPI: TQRLabel;
    QRLabel14: TQRLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

  procedure Pc_Busca;
  procedure Pc_Parametros;
  end;

var
  RL_Nota_Resum: TRL_Nota_Resum;

implementation

uses     UN_Imp_Notas, Mask, Un_DM, UN_Sistema, ComCtrls, Un_Principal, env;
{$R *.dfm}

procedure TRL_Nota_Resum.Pc_Busca;
VaR
  SqlTxt:String;
  Lc_Cliente, Lc_Natureza, Lc_Data:Boolean;
begin
  Screen.Cursor:=crHourGlass;
  Qr_Notas.Close;
  Qr_Notas.SQL.Clear;

  SqlTxt := 'select (nat.nat_cfop || '' - '' || nat.nat_descricao) NAT_NATUREZA, '+
            ' NFL_STATUS, '+
            ' NFL_MODELO, '+
            '  sum( (icms.icm_vl_bc_nr * icms.icm_aq_nr)/100) NFL_VL_ICMS, '+
            '  sum(icms.icm_vl_st) NFL_VL_ICMS_SUBST, '+
            '  sum(  nf.nfl_vl_ipi) NFL_VL_IPI, '+
            '  sum(itens.itf_vl_unit * itens.itf_qtde) NFL_VL_TL_PROD, '+
            '  sum(icms.icm_vl_frete) NFL_VL_FRETE, '+
            '  sum(icms.icm_vl_seguro) NFL_VL_SEGURO, '+
            '  sum(icms.icm_vl_outras) NFL_VL_DESP_ACESS, '+
            '  sum(itens.itf_vl_desc) PED_VL_DESCONTO, '+
            ' sum( (itens.itf_vl_unit * itens.itf_qtde) - itens.itf_vl_desc) NFL_VL_TL_NOTA '+
            '  from tb_itens_icms icms '+
            '    inner join tb_itens_nfl itens '+
            '    on (itens.itf_codigo = icms.icm_coditf) '+
            '    inner join tb_nota_fiscal nf '+
            '    on (nf.nfl_codigo = icms.icm_codnfl) '+
            '     INNER JOIN TB_NATUREZA nat '+
            '     ON (nat.NAT_CODIGO = icms.icm_codnat) '+
            '     LEFT OUTER JOIN TB_ITENS_IPI ipi '+
            '     on (itens.itf_codigo = ipi.ipi_coditf) '+
            'WHERE (NFL_CODMHA=:NFL_CODMHA) '+
            '  AND ( ((NFL_NUMERO <> '''') AND (NFL_NUMERO <> ''0'')) OR (NFL_MODELO = 65) ) ';

  if Fr_Imp_Notas.ChBx_Periodo.Checked then SqlTxt:= SqlTxt +' AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ';
  if Fr_Imp_Notas.DBLCB_Empresa.Text  = '' then Lc_Cliente  := False else Lc_Cliente  := True;
  if Fr_Imp_Notas.Fm_lista_cfop.Dblcb_Lista.Text = '' then Lc_Natureza := False else Lc_Natureza := True;


  if Lc_Cliente then SqlTxt := SqlTxt +'AND (NFL_CODEMP =:NFL_CODEMP) ';
  if Lc_Natureza then SqlTxt := SqlTxt +'AND (NFL_CODNAT =:NFL_CODNAT) ';

  Qr_Notas.SQL.Add(SqlTxt+' GROUP BY 1,2,3  ORDER BY 1,2,3 ');

  if Lc_Cliente  then Qr_Notas.ParamByName('NFL_CODEMP').AsInteger := Fr_Imp_Notas.DBLCB_Empresa.KeyValue;
  if Lc_Natureza then Qr_Notas.ParamByName('NFL_CODNAT').AsInteger := Fr_Imp_Notas.Fm_lista_cfop.Dblcb_Lista.KeyValue;
  Qr_Notas.ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;

  if Fr_Imp_Notas.ChBx_Periodo.Checked then
  begin
    Qr_Notas.ParamByName('DATAINI').AsDate := Fr_Imp_Notas.E_Data_Ini.Date;
    Qr_Notas.ParamByName('DATAFIM').AsDate := Fr_Imp_Notas.E_Data_Fim.Date;
  end;

  Qr_Notas.Open;
  Qr_Notas.FetchAll;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Nota_Resum.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Nota_Resum:=nil;
end;

procedure TRL_Nota_Resum.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Nota_Resum.Pc_Parametros;
begin
  with Fr_Imp_Notas do
  begin
    // Verifica data solicitada
    if ChBx_Periodo.Checked then
    Begin
      Lb_Data_Ini.Caption := DateToStr( E_Data_Ini.Date);
      Lb_Data_Fim.Caption := DateToStr( E_Data_Fim.Date);
    end
    else
    Begin
      Lb_Data_Ini.Caption := '';
      Lb_Data_Fim.Caption := '';
    end;
  end;
end;

procedure TRL_Nota_Resum.DetalheVendaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with Qr_Notas do
  Begin
    if FieldByName('NFL_STATUS').AsString = 'C' then
    Begin
      E_Natureza.Font.Color := clRed;
      E_Natureza.Font.Style := [fsStrikeOut];
    end
    else
    Begin
      E_Natureza.Font.Color := clBlack;
      E_Natureza.Font.Style := [];
    end;
    E_VL_ICMS.Caption     := FloatToStrF(FieldByName('NFL_VL_ICMS').AsCurrency,ffNumber,10,2);
    E_VL_ICMS_ST.Caption  := FloatToStrF(FieldByName('NFL_VL_ICMS_SUBST').AsCurrency,ffNumber,10,2);
    E_VL_IPI.Caption      := FloatToStrF(FieldByName('NFL_VL_IPI').AsCurrency,ffNumber,10,2);
    E_VL_PRODUTO.Caption  := FloatToStrF(FieldByName('NFL_VL_TL_PROD').AsCurrency,ffNumber,10,2);
    E_VL_FRETE.Caption    := FloatToStrF(FieldByName('NFL_VL_FRETE').AsCurrency,ffNumber,10,2);
    E_VL_SEGURO.Caption   := FloatToStrF(FieldByName('NFL_VL_SEGURO').AsCurrency,ffNumber,10,2);
    E_VL_DESPESAS.Caption := FloatToStrF(FieldByName('NFL_VL_DESP_ACESS').AsCurrency,ffNumber,10,2);
    E_VL_DESCONTO.Caption := FloatToStrF(FieldByName('PED_VL_DESCONTO').AsCurrency,ffNumber,10,2);
    E_VL_NOTA.Caption     := FloatToStrF(FieldByName('NFL_VL_TL_NOTA').AsCurrency +
                                         FieldByName('NFL_VL_FRETE').AsCurrency +
                                         FieldByName('NFL_VL_IPI').AsCurrency +
                                         FieldByName('NFL_VL_SEGURO').AsCurrency +
                                         FieldByName('NFL_VL_DESP_ACESS').AsCurrency,ffNumber,10,2);
  end;
  Application.ProcessMessages;
end;

end.
