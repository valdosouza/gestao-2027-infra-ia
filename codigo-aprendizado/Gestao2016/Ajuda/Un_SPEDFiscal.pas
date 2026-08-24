unit Un_SPEDFiscal;

{$IFDEF FPC}
  {$mode objfpc}{$H+}
{$ENDIF}

interface

uses
    {$IFNDEF FPC}
  Windows, Messages, {$ENDIF}
  SysUtils, Variants, Classes, Graphics, Controls, Forms, ACBrEFDBlocos, Dialogs, StdCtrls, ACBrSpedPisCofins, ExtCtrls, ComCtrls, ACBrUtil, ACBrTXTClass, DB, STQuery, Buttons, Gauges, System.Math, DBCtrls, ACBrSpedFiscal, ACBrBase;

type
    
  { TFrmSPEDPisCofins }

  TFr_SPEDFiscal = class(TForm)
    Qr_0150: TSTQuery;
    Qr_0190: TSTQuery;
    Qr_0200: TSTQuery;
    Qr_C170: TSTQuery;
    Qr_c100: TSTQuery;
    Panel1: TPanel;
    Qr_0400: TSTQuery;
    Pg_Blocos: TPageControl;
    tbs_Bloco_Principal: TTabSheet;
    tbs_Bloco_C: TTabSheet;
    Pnl_Bloco_000: TPanel;
    Panel2: TPanel;
    tbs_bloco_d: TTabSheet;
    Panel4: TPanel;
    tbs_Bloco_1: TTabSheet;
    Panel7: TPanel;
    SPFiscal: TACBrSPEDFiscal;
    TabSheet1: TTabSheet;
    Panel3: TPanel;
    TabSheet2: TTabSheet;
    Panel5: TPanel;
    chbx_H_Inventario: TCheckBox;
    Qr_C190: TSTQuery;
    TabSheet3: TTabSheet;
    Panel6: TPanel;
    ChBx_Reg_1100: TCheckBox;
    ChBx_Reg_1200: TCheckBox;
    ChBx_Reg_1390: TCheckBox;
    ChBx_Reg_1300: TCheckBox;
    ChBx_Reg_1700: TCheckBox;
    ChBx_Reg_1600: TCheckBox;
    ChBx_Reg_1500: TCheckBox;
    ChBx_Reg_1400: TCheckBox;
    ChBx_Reg_1800: TCheckBox;
    Qr_C176: TSTQuery;
    Label3: TLabel;
    Cb_PerfilContruibuinte: TComboBox;
    Qr_Aux: TSTQuery;
    SaveDialog1: TSaveDialog;
    GroupBox2: TGroupBox;
    ChBx_Bloco_A: TLabel;
    ChBx_Bloco_C: TLabel;
    ChBx_Bloco_D: TLabel;
    ChBx_Bloco_F: TLabel;
    ChBx_Bloco_M: TLabel;
    ChBx_Bloco_1: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel8: TPanel;
    GroupBox1: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Label9: TLabel;
    Cb_Tp_Escrituracao: TComboBox;
    Cb_Versao: TComboBox;
    Label4: TLabel;
    Panel9: TPanel;
    Label1: TLabel;
    SB_Sair: TSpeedButton;
    SB_Gerar: TSpeedButton;
    Lb_Processamento: TLabel;
    E_Path_Arquivo_SPED: TEdit;
    ChBx_Reg_1250: TCheckBox;
    Pnl_Progresso: TPanel;
    Gg_Progresso: TGauge;
    procedure SB_SairClick(Sender: TObject);
    procedure SB_GerarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    //Bloco F
    It_F500 :Boolean;
    It_F550 :Boolean;
    It_VL_Rec_Brt_M210 : Real;
    CodigoRegimeTributario : Integer;
    function FC_Vl_TotalIcmsDebito:Real;
    function FC_Vl_TotalIcmsCredito:Real;
  public
    { Public declarations }
    Procedure Pc_IniciaVariaveis;
    procedure Pc_AtivarTabelas;
    function Fc_validaGeracaoArquivo:Boolean;

    procedure AtualizaNFmodelo55;
    procedure OpenRegistroC170;
    procedure OpenRegistroC190;
    procedure Pc_preparaGeracao;

    procedure Pc_Bloco_0;
    procedure Pc_RegistroC0100(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC0150(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC0190(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC0200(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC0300(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC0400(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC0450(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC0460(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC0500(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC0600(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_Bloco_C;
    procedure Pc_RegistroC100(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC105(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC110(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC120(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC130(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC170(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC176(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC190(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC197(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC400(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC405(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC410(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC420(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC425(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC460(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC470(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC490(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroC495(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_Bloco_D;
    procedure Pc_RegistroD100(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroD190(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_Bloco_E;
    procedure Pc_RegistroE100(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroE110(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroE111(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroE112(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroE113(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroE115(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroE116(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroE200(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroE210(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroE220(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroE230(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroE240(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroE250(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroE500(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroE510(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroE520(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroE530(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_Bloco_G;
    procedure Pc_RegistroG110(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroG125(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroG126(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroG130(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroG140(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_Bloco_H;
    procedure Pc_RegistroH005(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroH010(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_RegistroH020(Pc_SPEDFiscal: TACBrSPEDFiscal);
    procedure Pc_Bloco_1;
    procedure Pc_Bloco_9;
    procedure Pc_GerarArquivoSPED;
    procedure Pc_GerarArquivoERRO;
  end;

var
  Fr_SPEDFiscal: TFr_SPEDFiscal;

implementation

uses
ACBrEPCBloco_0, ACBrEPCBloco_1, UN_Principal, env, ACBrEPCBloco_A, ACBrEPCBloco_C, ACBrEPCBloco_D, ACBrEPCBloco_F, ACBrEPCBloco_M, Un_DM, Un_Regra_Negocio, UN_Sistema, UN_MSG, Un_Funcoes, ACBrEPCBloco_C_Class, ACBrEPCBloco_M_Class, ACBrEPCBloco_A_Class, un_Padrao, Un_SPEDPisCofins, ACBrEFDBloco_0, ACBrEFDBloco_C, ControllerBase;

{$IFDEF FPC}
 {$R *.lfm}
{$ELSE}
 {$R *.dfm}
{$ENDIF}

function TFr_SPEDFiscal.FC_Vl_TotalIcmsDebito:Real;
Begin
  with Qr_Aux do
  Begin
    SQL.Clear;
    SQL.Add('select  DISTINCT '+
            'SUM(tb_itens_icms.icm_vl_nr) VL_TOT_DEBITOS '+
            'from tb_nota_fiscal '+
            '    inner join tb_itens_icms '+
            '    on (tb_itens_icms.icm_codnfl = tb_nota_fiscal.nfl_codigo) '+
            '    INNER JOIN tb_natureza '+
            '    ON (tb_natureza.nat_codigo = tb_itens_icms.icm_codnat) '+
            'WHERE NFL_DT_EMISSAO between :DATAINI AND :DATAFIM '+
            ' AND (  (NAT_CFOP LIKE ''5%'') '+
            '        OR (NAT_CFOP LIKE ''6%'') '+
            '        OR (NAT_CFOP LIKE ''7%'')  '+
            '        OR (NAT_CFOP = ''1605'') ) '+
            ' AND (NFL_NUMERO <> '''') '+
            ' AND (NFL_NUMERO <> ''0'') '+
            ' AND (NFL_STATUS = ''F'') '+
            ' AND NFL_CODMHA=:NFL_CODMHA');
    ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
    ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
    ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    Active := True;
    if recordcount > 0 then
      Result := FieldByName('VL_TOT_DEBITOS').AsCurrency
    else
      Result := 0;
  end;
end;

function TFr_SPEDFiscal.FC_Vl_TotalIcmsCredito:Real;
Begin
  with Qr_Aux do
  Begin
    SQL.Clear;
    SQL.Add('select  DISTINCT '+
            'SUM(tb_itens_icms.icm_vl_nr) VL_TOT_CREDITO '+
            'from tb_nota_fiscal '+
            '    inner join tb_itens_icms '+
            '    on (tb_itens_icms.icm_codnfl = tb_nota_fiscal.nfl_codigo) '+
            '    INNER JOIN tb_natureza '+
            '    ON (tb_natureza.nat_codigo = tb_itens_icms.icm_codnat) '+
            'WHERE NFL_DT_EMISSAO between :DATAINI AND :DATAFIM '+
            ' AND (  (NAT_CFOP LIKE ''1%'') '+
            '        OR (NAT_CFOP LIKE ''2%'') '+
            '        OR (NAT_CFOP LIKE ''3%'') ) '+
            ' AND (NFL_NUMERO <> '''') '+
            ' AND (NFL_NUMERO <> ''0'') '+
            'AND NFL_CODMHA=:NFL_CODMHA');
    ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
    ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
    ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    Active := True;
    if recordcount > 0 then
      Result := FieldByName('VL_TOT_CREDITO').AsCurrency
    else
      Result := 0;
  end;
end;

Procedure TFr_SPEDFiscal.Pc_IniciaVariaveis;
var
  Lc_dia, Lc_Mes, Lc_Ano: string;
Begin

  Cb_Versao.itemIndex := Cb_Versao.Items.Count -1;
  //Define Data
  Lc_dia := formatdatetime('dd', Date);
  Lc_Mes := formatdatetime('mm', Date);
  Lc_Ano := formatdatetime('yyyy', Date);

  Lc_dia := '01';
  if Lc_Mes = '01' then
    Lc_Ano := inttostr((Strtoint(Lc_Ano) - 1));
  if Lc_Mes = '01' then
    Lc_Mes := '12'
  else
    Lc_Mes := StrZero((Strtoint(Lc_Mes) - 1), 2, 0);
  E_Data_Ini.Date := StrToDate(Lc_dia + '/' + Lc_Mes + '/' + Lc_Ano);
  Lc_dia := Fc_Ult_Dia_Mes(E_Data_Ini.Date);
  E_Data_Fim.Date := StrToDate(Lc_dia + '/' + Lc_Mes + '/' + Lc_Ano);

  // Dados do estabelecimento
  Pc_AtivaEstabelecimento;

  //Controla quais blocos seráo gerados
  It_F500 := False;
  It_F500 := True;
end;

procedure TFr_SPEDFiscal.OpenRegistroC170;
Var
  sqltxt : String;
Begin
  with Qr_c170 do
  Begin
    Active := False;
    sql.Clear;
    sqltxt := concat(
                  'SELECT DISTINCT ',
                  'PRO_CODIGO, ',
                  'PRO_DESCRICAO, ',
                  'ITF_QTDE, ',
                  'MED_CODIGO, ',
                  '((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC )ITF_VL_SUBTOTAL, ',
                  'ITF_VL_DESC, ',
                  'ITF_ESTOQUE, ',
                  'regNR.tbi_grupo CST_ICMS, ',
                  'regSN.tbi_grupo CSO_ICMS, ',
                  'ICM_VL_BC_NR, ',
                  'ICM_AQ_NR, ',
                  'ICM_VL_NR, ',
                  'ICM_VL_BC_ST, ',
                  'ICM_AQ_ST, ',
                  'ICM_VL_ST, ',
                  'NAT_CFOP, ',
                  'trib_ipi.tbi_grupo ITF_CST_IPI, ',
                  'IPI_CL_ENQD, ',
                  'IPI_VL_BC, ',
                  'IPI_AQ_NR, ',
                  'trib_pis.tbp_grupo ITF_CST_PIS, ',
                  'PIS_VL_BC, ',
                  'PIS_AQ_NR, ',
                  'PIS_VL_NR, ',
                  'PIS_QT_VDA, ',
                  'PIS_VL_AQ, ',
                  'trib_cfs.tbc_grupo ITF_CST_CFS, ',
                  'CFS_VL_BC, ',
                  'CFS_AQ_NR, ',
                  'CFS_VL_NR, ',
                  'CFS_QT_UNID, ',
                  'CFS_VL_AQ, ',
                  'CFS_VL_NR ',
                  'from tb_nota_fiscal nf ',
                  '   inner join tb_itens_nfl itens ',
                  '   on (itens.itf_codnfl = nf.nfl_codigo ) ',
                  '   INNER JOIN TB_PRODUTO pro ',
                  '   ON (pro.PRO_CODIGO = itens.ITF_CODPRO) ',
                  '   INNER JOIN TB_MEDIDA med ',
                  '   ON (med.MED_CODIGO = pro.PRO_CODMED) ',
                  '   inner join tb_itens_icms icms ',
                  '   on (icms.icm_coditf = itens.itf_codigo) ',
                  '   INNER JOIN tb_natureza nat ',
                  '   ON (nat.nat_codigo = icms.icm_codnat) ',
                  '   LEFT OUTER JOIN TB_TRIB_ICMS_NR regNR ',
                  '   ON (regNR.tbi_codigo = icms.ICM_CODTBI_NR) ',
                  '   LEFT OUTER JOIN TB_TRIB_ICMS_SN regSN ',
                  '   ON (regSN.tbi_codigo = icms.ICM_CODTBI_SN) ',
                  '   LEFT OUTER join tb_itens_ipi ipi ',
                  '   on (ipi.ipi_coditf = itens.itf_codigo) ',
                  '   LEFT OUTER JOIN TB_TRIB_IPI trib_ipi ',
                  '   ON (ipi.ipi_codtbi = trib_ipi.tbi_codigo ) ',
                  '   LEFT OUTER JOIN TB_ITENS_PIS pis ',
                  '   ON (pis.PIS_CODITF = itens.ITF_CODIGO ) ',
                  '   LEFT OUTER JOIN TB_TRIB_PIS trib_pis ',
                  '   ON (ipi.ipi_codtbi = trib_ipi.tbi_codigo ) ',
                  '   LEFT OUTER JOIN TB_ITENS_CFS cfs ',
                  '   ON (cfs.CFS_CODITF = itens.ITF_CODIGO ) ',
                  '   LEFT OUTER JOIN TB_TRIB_CFS trib_cfs ',
                  '   ON (cfs.cfs_codtbc = trib_cfs.tbc_codigo ) ',
                  'WHERE (NFL_CODIGO=:NFL_CODIGO) ',
                  '  AND (NFL_NUMERO <> '''') ',
                  ' AND (NFL_NUMERO <> ''0'') ',
                  '  AND (NFL_TIPO like ''E%'') ',
                  'ORDER BY NFL_CODIGO, ITF_CODIGO '
              );
    sql.add( sqltxt );
  End;


end;

procedure TFr_SPEDFiscal.OpenRegistroC190;
Var
  sqltxt : String;
Begin
  with Qr_c190 do
  Begin
    Active := False;
    sql.Clear;
    sqltxt := concat(
                  'select ',
                  'regNR.tbi_grupo CST_ICMS, ',
                  'regSN.tbi_grupo CSO_ICMS, ',
                  'NAT_CFOP CFOP, ',
                  'icms.icm_aq_nr ALIQ_ICMS, ',
                  'Sum( (itens.itf_qtde * itens.itf_vl_unit) - ',
                  '     itens.itf_vl_desc + (icms.icm_vl_frete + ',
                  '     icms.icm_vl_seguro + icms.icm_vl_outras + ',
                  '     icms.icm_vl_st)) VL_OPR, ',
                  'sum(icms.icm_vl_bc_nr) VL_BC_ICMS, ',
                  'sum(icms.icm_vl_nr)VL_ICMS, ',
                  'sum(icms.icm_vl_bc_st) VL_BC_ICMS_ST, ',
                  'sum(icms.icm_vl_st) VL_ICMS_ST, ',
                  'sum(0) VL_RED_BC, ',
                  'sum( (ipi.ipi_vl_bc * ipi.ipi_aq_nr) /100 ) VL_IPI ',
                  'from tb_nota_fiscal nf ',
                  '   inner join tb_itens_nfl itens ',
                  '   on (itens.itf_codnfl = nf.nfl_codigo ) ',
                  '   inner join tb_itens_icms icms ',
                  '   on (icms.icm_coditf = itens.itf_codigo) ',
                  '   INNER JOIN tb_natureza nat ',
                  '   ON (nat.nat_codigo = icms.icm_codnat) ',
                  '   LEFT OUTER JOIN TB_TRIB_ICMS_NR regNR ',
                  '   ON (regNR.tbi_codigo = icms.ICM_CODTBI_NR)',
                  '   LEFT OUTER JOIN TB_TRIB_ICMS_SN regSN ',
                  '   ON (regSN.tbi_codigo = icms.ICM_CODTBI_SN)',
                  '   LEFT OUTER join tb_itens_ipi ipi',
                  '   on (ipi.ipi_coditf = itens.itf_codigo)',
                  'WHERE NFL_CODIGO =:NFL_CODIGO ',
                  'AND NFL_CODMHA=:NFL_CODMHA ',
                  'group by 1,2,3,4 ',
                  'order by 3 '
              );
    sql.add( sqltxt );
  End;


End;



procedure TFr_SPEDFiscal.Pc_preparaGeracao;
begin
  Pc_AtivaEstabelecimento;
  CodigoRegimeTributario := DM.Qr_Estabelecimento.FieldByName('EMP_CRT').AsInteger;
  AtualizaNFmodelo55;
  OpenRegistroC170;
  OpenRegistroC190;
end;

procedure TFr_SPEDFiscal.AtualizaNFmodelo55;
Var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := TSTQuery.Create(Self);
    with Lc_Qry do
    Begin
      Database := dm.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      ForcedRefresh := True;
      sql.Clear;
      sql.Add('update tb_nota_fiscal set '+
              'NFL_MODELO = ''55'' '+
              'WHERE (NFL_MODELO IS NULL) '+
              ' or (NFL_MODELO  = ''0'') '+
              ' or (NFL_MODELO  = ''00'') '+
              ' or (NFL_MODELO  = '''')');
      ExecSQL;
      if Transaction.InTransaction then  Transaction.CommitRetaining;
    End;
  finally
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
  end;

end;


procedure TFr_SPEDFiscal.Pc_AtivarTabelas;
Begin
  DM.qr_trib_pis.Active:=false;
  DM.qr_trib_pis.Active:=True;
  DM.qr_trib_pis.FetchAll;
end;


function TFr_SPEDFiscal.Fc_validaGeracaoArquivo:Boolean;
Begin
  Result := True;
  if (E_Data_Fim.Date < E_Data_Ini.Date) then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Data Final não pode ser menor que a inicial.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    if E_Data_Fim.CanFocus then E_Data_Fim.setfocus;
    Result := False;
    exit;
  end;

  if (E_Data_Fim.Date > date) then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Data Final não pode ser maior que a data atual.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    if E_Data_Fim.CanFocus then E_Data_Fim.setfocus;
    Result := False;
    exit;
  end;

  SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  if not SaveDialog1.Execute then
  begin
    Result := False;
    exit;
  end;
  E_Path_Arquivo_SPED.Text := SaveDialog1.FileName;
  if (Trim(E_Path_Arquivo_SPED.Text) = '') then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Favor Informar um nome de Arquivo Valido.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    if E_Path_Arquivo_SPED.CanFocus then E_Path_Arquivo_SPED.setfocus;
    Result := False;
    exit;
  end;
end;

procedure TFr_SPEDFiscal.Pc_Bloco_0;
const
  strUNID: array [0 .. 4] of string = ('PC', 'UN', 'LT', 'PC', 'MT');
var
  int0150: integer;
  int0175: integer;
  int0300: integer;
  int0190: integer;
  int0500: Integer;
  int0600: Integer;
  Lc_Aux : String;
begin
  // Alimenta o componente com informações para gerar todos os registros do
  // Bloco 0.

  //Definindo
  with SPFiscal do
  begin
    DT_INI := E_Data_Ini.Date;
    DT_FIN := E_Data_Fim.Date;
    //Tinha um campo com o Valor 1000 - Verificar se é o numero de Notas que vai no arquivo
    //LinhasBuffer := StrToIntDef( edBufLinhas.Text, 0 );
    LinhasBuffer := 1000;
    // Informa o pasta onde será salvo o arquivo TXT.
    Path := GbPathExe;
    Arquivo := E_Path_Arquivo_SPED.Text;
    IniciaGeracao;
  end;

  with SPFiscal.Bloco_0 do
  begin
    // Dados da Empresa
    Pc_AtivaEstabelecimento;
    Application.ProcessMessages;
    with Registro0000New,DM.Qr_Estabelecimento do
    begin
      case Cb_Versao.ItemIndex of
        0:COD_VER := vlVersao100;
        1:COD_VER := vlVersao101;
        2:COD_VER := vlVersao102;
        3:COD_VER := vlVersao103;
        4:COD_VER := vlVersao104;
        5:COD_VER := vlVersao105;
        6:COD_VER := vlVersao106;
        7:COD_VER := vlVersao107;
        8:COD_VER := vlVersao108;
        9:COD_VER := vlVersao109;
        10:COD_VER := vlVersao110;
        11:COD_VER := vlVersao111;
        12:COD_VER := vlVersao112;
        13:COD_VER := vlVersao113;
        14:COD_VER := vlVersao114;
        15:COD_VER := vlVersao115;
        16:COD_VER := vlVersao116;
      end;


      COD_FIN := raOriginal;
      NOME := Copy(Trim(FieldByName('EMP_NOME').AsString),1,60);
      CNPJ := FieldByName('EMP_CNPJ').AsString;
      CPF := '';
      UF := FieldByName('UFE_SIGLA').AsString;
      Lc_Aux := FieldByName('EMP_INSC_EST').AsString;
      Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux, ['.',',','/','-',' ']);
      IE     := Lc_Aux;
      COD_MUN := FieldByName('CDD_IBGE').AsInteger;
      IM := '';
      SUFRAMA := '';
      if Cb_PerfilContruibuinte.ItemIndex = 0 then
        IND_PERFIL := pfPerfilA
      else
        IND_PERFIL := pfPerfilB;
      IND_ATIV := atOutros;
    end;

    with Registro0001New do
    begin
      IND_MOV := imComDados;
      // FILHO - Dados complementares da Empresa
      with Registro0005New,DM.Qr_Estabelecimento do
      begin
        FANTASIA := Copy(Trim(FieldByName('EMP_FANTASIA').AsString),1,60);
        CEP := FieldByName('END_CEP').AsString;
        ENDERECO := Trim(FieldByName('END_ENDER').AsString);
        NUM := Trim(FieldByName('END_NUMERO').AsString);
        COMPL := Trim(FieldByName('END_COMPLEM').AsString);
        BAIRRO := FieldByName('END_BAIRRO').AsString;
        FONE := Trim(FieldByName('END_FONE').AsString);
        FAX := Trim(FieldByName('END_FAX').AsString);
        EMAIL := FieldByName('EMP_EMAIL').AsString;
      end;

      //with Registro0015New do
      //begin
      //UF_ST := 'SC';
      //IE_ST := '254504230';
      //end;

      // 0100 - DADOS DO CONTABILISTA
        {Registro utilizado para identificação do contabilista responsável pela
         escrituração fiscal do estabelecimento,mesmo que o contabilista seja
          funcionário da empresa ou prestador de serviço.}
      Pc_RegistroC0100(SPFiscal);

      //0150 - Tabela de Cadastro do Participante //Clientes por estabelecimento
      Pc_RegistroC0150(SPFiscal);
      //0175 - ALTERAÇÃO DA TABELA DE CADASTRO DE PARTICIPANTE
        {Este registro é de preenchimento obrigatório quando houver, dentro do
         período, alteração nos dados informados no registro 0150}

      // 0190 - Identificação das Unidades de Medida
      Pc_RegistroC0190(SPFiscal);

      // 0200 - Tabela de Identificação do Item (Produtos e Serviços)
      Pc_RegistroC0200(SPFiscal);

      // 0205 - ALTERAÇÃO DO ITEM
        {Este registro tem por objetivo informar alterações ocorridas na descrição
         do produto ou quando ocorrer alteração na codificação do produto}

      // 0206 - CÓDIGO DE PRODUTO CONFORME TABELA PUBLICADA PELA ANP (COMBUSTÍVEIS)
        {Este registro tem por objetivo informar o códcódcódigo correspondente ao
        produto constante na Tabela da Agência Nacional de Petróleo (ANP) }

      // 0210 - CONSUMO ESPECÍFICO PADRONIZADO
        {Este registro deve ser apresentado, caso exista produção e/ou consumo
        nos Registros K230/K235 e K250/K255.}

      //REGISTRO 0220: FATORES DE CONVERSÃO DE UNIDADES
        {Este registro tem por objetivo informar os fatores de conversão dos
         itens discriminados na Tabela de Identificação do Item (Produtos e
         Serviços) entre a unidade informada no registro 0200 e as unidades
         informadas nos registros dos documentos fiscais ou nos registros do
         controle da produção e do estoque - Bloco K}

      // 0300 -CADASTRO DE BENS OU COMPONENTES DO ATIVO IMOBILIZADO
        {Este registro tem o objetivo de identificar e caracterizar todos os
         bens ou componentes arrolados no registro G125 do Bloco G e os bens
         em construção
        Pc_RegistroC0300(SPFiscal);}

      // 0305 - INFORMAÇÃO SOBRE A UTILIZAÇÃO DO BEM
        {Este registro tem o objetivo de prestar informações sobre a utilização
         do bem, sendo obrigatório quando o conteúdo do campo IDENT_MERC do
         registro 0300 for igual a 1º (Bem).}

      // 0400: TABELA DE NATUREZA DA OPERAÇÃO/PRESTAÇÃO
        {Este registro tem por objetivo codificar os textos das diferentes
         naturezas da operação/prestação discriminadas nos documentos fiscais.
         Esta codificação e suas descrições são livremente criadas e mantidas pelo contribuinte.}
        Pc_RegistroC0400(SPFiscal);

      // 0450 - TABELA DE INFORMAÇÃO COMPLEMENTAR DO DOCUMENTO FISCAL
        {Este registro tem por objetivo codificar todas as informações complementares
         dos documentos fiscais exigidas pela legislação fiscal. Estas informações
         constam no campo Dados Adicionais dos documentos fiscais.
        Pc_RegistroC0450(SPFiscal) }

      // 0460 - TABELA DE OBSERVAÇÕES DO LANÇAMENTO FISCAL
        {Este registro é utilizado para informar anotações de escrituração determinadas
         pela legislação pertinente aos lançamentos fiscais, tais como: ajustes
         efetuados por diferimento parcial de imposto, antecipações, diferencial
         de alíquota e outros
        Pc_RegistroC0460(SPFiscal) }

      // 0500 - PLANO DE CONTAS CONTÁBEIS
        {Este registro tem o objetivo de identificar as contas contábeis utilizadas
         pelo contribuinte informante em sua Contabilidade Geral, relativas àscontas
         referenciadas no registro 0300. Não podem ser informados dois ou mais registros
         com a mesma combinação de conteúdo nos campos DT_ALT e COD_CTA.
        Pc_RegistroC0500(SPFiscal) }

      // 0600 - CENTRO DE CUSTOS
        {Este registro tem o objetivo de identificar os centros de custos referenciados
         no registro 0305 Informação sobre utilização do bem
        Pc_RegistroC0600(SPFiscal) }
    end;
  end;
  SPFiscal.WriteBloco_0;
end;

procedure TFr_SPEDFiscal.Pc_RegistroC0100(Pc_SPEDFiscal: TACBrSPEDFiscal);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry,Pc_SPEDFiscal.Bloco_0 do
    Begin
      sql.add(concat(
                'SELECT * ',
                'FROM TB_EMPRESA tb_empresa ',
                '  INNER JOIN TB_ENDERECO tb_endereco ',
                '  ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO) ',
                '  INNER JOIN TB_CIDADE tb_cidade ',
                '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD) ',
                '  INNER JOIN TB_UF tb_uf ',
                '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE) ',
                '  INNER JOIN TB_PAIS tb_pais ',
                '  ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS) ',
                'WHERE EMP_ATIVA = ''S'' and EMP_TIPO = 9 ',
                'ORDER BY EMP_NOME '
      ));
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
      Begin
        with Registro0100New do
        begin
          NOME := Copy(FieldByName('EMP_NOME').AsString,1,60);
          CPF := FieldByName('EMP_CNPJ').AsString;
          CRC := '65924';
          CNPJ := '';
          CEP := FieldByName('END_CEP').AsString;
          ENDERECO := Trim(FieldByName('END_ENDER').AsString);
          NUM := Trim(FieldByName('END_NUMERO').AsString);
          COMPL := Trim(FieldByName('END_COMPLEM').AsString);
          BAIRRO := FieldByName('END_BAIRRO').AsString;
          FAX := FieldByName('END_FAX').AsString;
          EMAIL := FieldByName('EMP_EMAIL').AsString;
          EMAIL := FieldByName('EMP_EMAIL').AsString;
          COD_MUN := FieldByName('CDD_IBGE').AsInteger;
        end;
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
End;

procedure TFr_SPEDFiscal.Pc_RegistroC0150(Pc_SPEDFiscal: TACBrSPEDFiscal);
Var
  Lc_aux:String;
Begin
  with Pc_SPEDFiscal.Bloco_0,Qr_0150 do
  Begin
    //0150 - Tabela de Cadastro do Participante //Clientes por estabelecimento
    Active := False;
    ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
    ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    Active := True;
    First;
    while not Eof do
    begin
      if FieldByName('NFL_STATUS').AsString = 'F' then
      Begin
        with Registro0150New do
        begin
          COD_PART := FieldByName('EMP_CODIGO').AsString;
          NOME     := Trim(FieldByName('EMP_NOME').AsString);
          COD_PAIS := FieldByName('PAI_CODBACEN').AsString;
          IF (Length(Trim(FieldByName('EMP_CNPJ').AsString)) =14) then
          Begin
            CNPJ     := FieldByName('EMP_CNPJ').AsString;
            CPF      := '';
            Lc_Aux := Trim(FieldByName('EMP_INSC_EST').AsString);
            if (Lc_Aux <> 'ISENTO') AND (Lc_Aux <> '') then
            Begin
              Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux, ['.',',','/','-',' ']);
              IE     := Lc_Aux;
            end;
          end
          else
          Begin
            CNPJ     := '';
            CPF      := FieldByName('EMP_CNPJ').AsString;
          end;
          COD_MUN  := FieldByName('CDD_IBGE').AsInteger;
          SUFRAMA  := '';
          ENDERECO := Trim(FieldByName('END_ENDER').AsString);
          NUM      := Trim(FieldByName('END_NUMERO').AsString);
          COMPL    := Trim(FieldByName('END_COMPLEM').AsString);
          BAIRRO   := FieldByName('END_BAIRRO').AsString;
        end;
      End;
      Application.ProcessMessages;
      Next;
      Application.ProcessMessages;
    end;
  End;

End;

procedure TFr_SPEDFiscal.Pc_RegistroC0190(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_0,Qr_0190 do
  Begin
    Active := False;
    ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
    ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    Active := True;
    First;
    while not Eof do
    begin
      with Registro0190New do
      begin
        UNID  := FieldByname('MED_CODIGO').AsString;
        DESCR := FieldByname('MED_ABREVIATURA').AsString;
      end;
      Next;
      Application.ProcessMessages;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroC0200(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_0,Qr_0200 do
  Begin
    Active := False;
    ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
    ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    Active := True;
    First;
    while not Eof do
    begin
      with Registro0200New do
      begin
        COD_ITEM     := FormatFloat('0000000000', FieldByName('PRO_CODIGO').AsInteger);
        DESCR_ITEM   := Trim(FieldByName('PRO_DESCRICAO').AsString);
        COD_BARRA    := FieldByName('PRO_CODIGOBAR').AsString;
        //Não preencher. Se houver a informação, esta deve ser prestada no registro 0205.
        //COD_ANT_ITEM := FormatFloat('0000000000', FieldByName('PRO_CODIGO').AsInteger);
        UNID_INV     := FieldByName('MED_CODIGO').AsString;
        if FieldByName('PRO_TIPO').AsString = 'P' then
          TIPO_ITEM    := tiProdutoAcabado
        else
        if FieldByName('PRO_TIPO').AsString = 'M' then
          TIPO_ITEM    := tiMateriaPrima
        else
          TIPO_ITEM    := tiServicos;
        COD_NCM      := FieldByName('PRO_CODIGONCM').AsString;
        EX_IPI       := '';
        COD_GEN      := '';
        COD_LST      := '';
        ALIQ_ICMS    := 0;
      end;
      //REGISTRO 0206: CÓDIGO DE PRODUTO CONFORME TABELA PUBLICADA PELA ANP (COMBUSTÍVEIS)
      //With Registro0206New do
      //begin
      //COD_COMB := '910101001';
      //end;
      Next;
      Application.ProcessMessages;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroC0300(Pc_SPEDFiscal: TACBrSPEDFiscal);
Var
  Lc_I : Integer;
Begin
  with Pc_SPEDFiscal.Bloco_0 do
  Begin
    for Lc_I := 1 to 10 do
    begin
      // 10 Bens Imobilizados
      with Registro0300New do
      begin
        COD_IND_BEM := FormatFloat('000000', Lc_I);
        IDENT_MERC := 1;
        DESCR_ITEM := 'DESCRIÇÃO DO ITEM';
        COD_PRNC := '';
        COD_CTA := '';
        NR_PARC := 10;
        // FILHO
        with Registro0305New do
        begin
          COD_CCUS := '1';
          //FUNC := 'BREVE DESCRIÇÃO DA FUNÇÃO DO IMOBILIZADO ' +FormatFloat('000000', int0300);
          VIDA_UTIL := 60;
        end;
      end;
    end;
  end;
end;
procedure TFr_SPEDFiscal.Pc_RegistroC0400(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_0, Qr_0400 do
  Begin
    Active := False;
    ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
    ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    Active := True;
    First;
    while not Eof do
    begin
      with Registro0400New do
      begin
        COD_NAT   := FieldByName('NAT_CFOP').AsString;
        DESCR_NAT := FieldByName('NAT_RESUMIDO').AsString;
      end;
      Next;
      Application.ProcessMessages;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroC0450(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_0 do
  Begin
    with Registro0450New do
    begin
      COD_INF := '000001';
      TXT := 'INFORMAÇÃO COMPLEMENTAR DO DOCUMENTO FISCAL';
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroC0460(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_0 do
  Begin
    with Registro0460New do
    begin
      COD_OBS := '000001';
      TXT := 'TEXTO DE OBSERVAÇÃO DO DOCUMENTO FISCAL ';
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroC0500(Pc_SPEDFiscal: TACBrSPEDFiscal);
Var
  Lc_I : Integer;
Begin
  with Pc_SPEDFiscal.Bloco_0 do
  Begin
    for Lc_I := 1 to 10 do
    begin
      with Registro0500New do
      begin
        DT_ALT := StrToDate('30/11/2011');
        COD_NAT_CC := '01';
        IND_CTA := 'A';
        NIVEL := '1';
        COD_CTA := IntToStr(Lc_I);
        NOME_CTA := 'CONTA CONTÁBIL ' + IntToStr(Lc_I);
      end;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroC0600(Pc_SPEDFiscal: TACBrSPEDFiscal);
Var
  Lc_I : Integer;
Begin
  with Pc_SPEDFiscal.Bloco_0 do
  Begin
    for Lc_I := 1 to 10 do
    begin
      with Registro0600New do
      begin
        DT_ALT := StrToDate('30/11/2011');
        COD_CCUS := IntToStr(Lc_I);
        CCUS := 'CENTRO DE CUSTOS ' + IntToStr(Lc_I);
      end;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroC100(Pc_SPEDFiscal: TACBrSPEDFiscal);
Var
  Lc_Tamanho : Integer;
Begin
  with Pc_SPEDFiscal.Bloco_C do
  Begin
    with RegistroC100New do
    begin
      //Verifica se Entrada ou Saida
      if Copy(Qr_c100.FieldByName('NFL_TIPO').AsString,1,1) = 'S' then
        IND_OPER      := tpSaidaPrestacao
      else
        IND_OPER      := tpEntradaAquisicao;
      //Verifica o Tipo de Documento se é nota Normal ou eletronica
      COD_MOD       := Qr_c100.FieldByName('NFL_MODELO').AsString;
      //Chave de Acesso da Nota Fiscal
      CHV_NFE      :=  Qr_c100.FieldByName('CHAVE').AsString;
      //Numero da Nota Fiscal
      NUM_DOC       := FormatFloat('000000000',StrToIntDef(Qr_c100.FieldByName('NFL_NUMERO').AsString,0)); //
      //Serie da Nota Fiscal
      SER           := StrZero(StrToIntDef(Qr_c100.FieldByName('NFL_SERIE').AsString,1),3,0);

      //Verifica a Situação do Documento
      IF (Qr_c100.FieldByName('CD_SITUACAO').AsInteger= 2) then
      Begin
        COD_SIT       := sdRegular;

        //Verifica se é de Terceira ou Propria
        if Copy(Qr_c100.FieldByName('NFL_TIPO').AsString,1,1) = 'E' then
          IND_EMIT      := edTerceiros
        else
          IND_EMIT      := edEmissaoPropria;
        //Participante
        COD_PART := Qr_c100.FieldByName('EMP_CODIGO').AsString;

        //Datas do emissao
        DT_DOC        := Qr_c100.FieldByName('NFL_DT_EMISSAO').AsDateTime;
        //Datas de entrada ou saida
        DT_E_S        := Qr_c100.FieldByName('NFL_DT_SAIDA').AsDateTime;

        VL_DOC := Qr_c100.FieldByName('NFL_VL_TL_NOTA').AsCurrency;

        if (Copy(Qr_c100.FieldByName('PED_PRAZO').AsString,1,3) = '000') then
          IND_PGTO := tpVista
        else
          IND_PGTO := tpPrazo;

        VL_DESC := Qr_c100.FieldByName('PED_VL_DESCONTO').AsCurrency;

        VL_MERC := Qr_c100.FieldByName('NFL_VL_TL_PROD').AsCurrency;

        case Qr_c100.FieldByName('NFL_CTA_FRETE').AsInteger of
          0:IND_FRT := tfPorContaEmitente;            // 0 - Contratação do Frete por conta do Remetente(CIF)
          1:IND_FRT := tfPorContaDestinatario;        // 1 - Contratação do Frete por conta do Destinatário(FOB)
          2:IND_FRT := tfPorContaTerceiros;           // 2 - Contratação do Frete por conta do terceiros
          3:IND_FRT := tfProprioPorContaRemetente;    // 3 - Transporte Próprio por conta do Remetente
          4:IND_FRT := tfProprioPorContaDestinatario; // 4 - Transporte Próprio por conta do Destinatário
        else
          IND_FRT := tfSemCobrancaFrete;             // 9 - Sem Ocorrência de Transporte
        end;

        VL_FRT := Qr_c100.FieldByName('NFL_VL_FRETE').AsCurrency;

        VL_SEG := Qr_c100.FieldByName('NFL_VL_SEGURO').AsCurrency;

        VL_OUT_DA := Qr_c100.FieldByName('NFL_VL_DESP_ACESS').AsCurrency;

        VL_BC_ICMS := Qr_c100.FieldByName('NFL_BS_ICMS').AsCurrency;

        VL_ICMS := Qr_c100.FieldByName('NFL_VL_ICMS').AsCurrency;

        VL_BC_ICMS_ST := Qr_c100.FieldByName('NFL_BS_ICMS_SUBST').AsCurrency;

        VL_ICMS_ST := Qr_c100.FieldByName('NFL_VL_ICMS_SUBST').AsCurrency;

        VL_IPI := Qr_c100.FieldByName('NFL_VL_IPI').AsCurrency;

        VL_PIS := 0; //Qr_c100.FieldByName('NFL_VL_ICMS').AsCurrency;

        VL_COFINS := 0; //Qr_c100.FieldByName('NFL_VL_ICMS').AsCurrency;

        VL_PIS_ST := 0; //Qr_c100.FieldByName('NFL_VL_ICMS').AsCurrency;

        VL_COFINS_ST := 0; //Qr_c100.FieldByName('NFL_VL_ICMS').AsCurrency;

        // REGISTRO C110: INFORMAÇÃO COMPLEMENTAR DA NOTA FISCAL (CÓDIGO 01, 1B, 04 e 55).
        Pc_RegistroC110(SPFiscal);

        // REGISTRO C120: COMPLEMENTO DE DOCUMENTO - OPERAÇÕES DE IMPORTAÇÃO (CÓDIGOS 01 e 55).
          {Este registro tem por objetivo informar detalhes }
        Pc_RegistroC120(SPFiscal);

        //REGISTRO C130: ISSQN, IRRF E PREVIDÊNCIA SOCIAL.
          {Este registro tem por objetivo informar dados da prestação de serviços
            sob não-incidência ou não tributados pelo ICMS e ainda detalhes sobre
            a retenção de Imposto de Renda Retido na Fonte (IRRF) e de contribuições
            previdenciarias. Essas trás situações possuem características ppróprias
            e tratamentos específicos na legislação, não guardando entre elas nenhuma relação.}
        Pc_RegistroC130(SPFiscal);

        //REGISTRO C170: ITENS DO DOCUMENTO (CÓDIGO 01, 1B, 04 e 55).
        Pc_RegistroC170(SPFiscal);

        // REGISTRO C190: REGISTRO ANALÍTICO DO DOCUMENTO (CÓDIGO 01, 1B, 04,55 e 65).
          {Este registro tem por objetivo representar a escrituração dos documentos
           fiscais totalizados por CST, CFOP e Alíquota de ICMS.}
          Pc_RegistroC190(SPFiscal);
      end
      else
      Begin
        // 3 CANCELADA / 4 INUTILIZADA / 5 DENEGADA depreciado
        case Qr_c100.FieldByName('CD_SITUACAO').AsInteger of
          3:COD_SIT       := sdCancelado;
          4:COD_SIT       := sdDoctoNumInutilizada;
          5:COD_SIT       := sdDoctoDenegado;
        end;
      end;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroC105(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_C do
  Begin

  End;

End;

procedure TFr_SPEDFiscal.Pc_RegistroC110(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_C do
  Begin
    {
    With RegistroC110New do
    begin
      COD_INF := '000001';
      TXT_COMPL := '';
      with RegistroC113New do
      begin
        IND_OPER := tpEntradaAquisicao;
        IND_EMIT := edTerceiros;
        COD_PART := '001';
        COD_MOD := '1';
        SER := '1';
        SUB := '1';
        NUM_DOC := '333';
        DT_DOC := StrToDate('02/11/2011');
      end;
    end;
    }
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroC120(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_C do
  Begin
    {
    with RegistroC120New do
    begin
      COD_DOC_IMP := diSimplificadaImport;
      NUM_DOC__IMP := '1024879531';
      PIS_IMP := 0.00;
      COFINS_IMP := 0.00;
      NUM_ACDRAW := '';
    end;
    }
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroC130(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_C do
  Begin
    {
    with RegistroC130New do
    begin
      VL_SERV_NT := 10.12;
      VL_BC_ISSQN := 10.12;
      VL_ISSQN := 10.12;
      VL_BC_IRRF := 10.12;
      VL_IRRF := 10.12;
      VL_BC_PREV := 10.12;
      VL_PREV := 10.12;
    end;
    }
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroC170(Pc_SPEDFiscal: TACBrSPEDFiscal);
Var
  Lc_I: integer;
  Lc_VL_Pis : Real;
  Lc_VL_Cfs : Real;
Begin
  with Pc_SPEDFiscal.Bloco_C, Qr_C170 do
  Begin
    //c170 - Complemento de Documento Itens do Documento (igos 01, 1B, 04 e 55)
    Active := False;
    ParamByName('NFL_CODIGO').AsInteger := Qr_c100.FieldByName('NFL_CODIGO').AsInteger;
    Active := True;
    FetchAll;
    First;
    Lc_I := 1;
    while not Eof do
    begin
      with RegistroC170New do   //Inicio Adicionar os Itens:
      begin
        NUM_ITEM         := FormatFloat('000', Lc_I);
        COD_ITEM         := FormatFloat('0000000000',FieldByName('PRO_CODIGO').AsInteger);
        DESCR_COMPL      := Trim(FieldByName('PRO_DESCRICAO').AsString);
        QTD              := FieldByName('ITF_QTDE').AsFloat;
        UNID             := FieldByName('MED_CODIGO').AsString;
        VL_ITEM          := FieldByName('ITF_VL_SUBTOTAL').AsCurrency;
        VL_DESC          := FieldByName('ITF_VL_DESC').AsCurrency;
        IF FieldByName('ITF_ESTOQUE').AsString = 'S' then
          IND_MOV          := mfSim
        else
          IND_MOV          := mfNao;

        //Código da Situação Tributária referente ao ICMS, conforme a Tabela indicada no item 4.3.1
        if not FieldByName('CST_ICMS').IsNull then
          CST_ICMS      := FieldByName('CST_ICMS').AsString
        else
          CST_ICMS      := FieldByName('CSO_ICMS').AsString;

        CFOP             := FieldByName('NAT_CFOP').AsString;
        COD_NAT          := FieldByName('NAT_CFOP').AsString;
        VL_BC_ICMS       := FieldByName('ICM_VL_BC_NR').AsCurrency;
        ALIQ_ICMS        := FieldByName('ICM_AQ_NR').AsFloat;
        VL_ICMS          := FieldByName('ICM_VL_NR').AsCurrency;
        VL_BC_ICMS_ST    := FieldByName('ICM_VL_BC_ST').AsCurrency;
        ALIQ_ST          := FieldByName('ICM_AQ_ST').AsFloat;
        VL_ICMS_ST       := FieldByName('ICM_VL_ST').AsCurrency;
        IND_APUR         := iaMensal;
        //CST do IPI
        if (Qr_C170.FieldByName('IPI_VL_BC').AsCurrency > 0) then
        Begin
          /// Código da Situação Tributária referente ao IPI, conforme a Tabela indicada no item 4.3.2.
          CST_IPI          := FieldByName('ITF_CST_IPI').AsString;
          COD_ENQ          := FieldByName('IPI_CL_ENQD').AsString;
          VL_BC_IPI        := FieldByName('IPI_VL_BC').AsCurrency;
          ALIQ_IPI         := FieldByName('IPI_AQ_NR').AsCurrency;
          VL_IPI           := FieldByName('IPI_VL_BC').AsCurrency * (FieldByName('IPI_AQ_NR').AsCurrency / 100);
        end
        else
        Begin
          if (Copy(Qr_c100.FieldByName('NFL_TIPO').AsString,1,1)='S') then
          Begin
            if (Qr_C170.FieldByName('IPI_VL_BC').AsCurrency>0) then
            Begin
              // Código da Situação Tributária referente ao IPI, conforme a Tabela indicada no item 4.3.2.
              CST_IPI          := FieldByName('ITF_CST_IPI').AsString;
              VL_BC_IPI        := FieldByName('IPI_VL_BC').AsCurrency;
              ALIQ_IPI         := FieldByName('IPI_AQ_NR').AsCurrency;
              VL_IPI           := VL_BC_IPI * (ALIQ_IPI / 100);
            end;
          end
          else
          Begin
            if (Qr_C170.FieldByName('IPI_VL_BC').AsCurrency>0) then
            Begin
              // Código da Situação Tributária referente ao IPI, conforme a Tabela indicada no item 4.3.2.
              CST_IPI          := FieldByName('ITF_CST_IPI').AsString;
              VL_BC_IPI        := FieldByName('IPI_VL_BC').AsCurrency;
              ALIQ_IPI         := FieldByName('IPI_AQ_NR').AsCurrency;
              VL_IPI           := FieldByName('IPI_VL_BC').AsCurrency * (FieldByName('IPI_AQ_NR').AsCurrency / 100);
            end;
          end;
        end;
        //CST do PIS
        // Código da Situação Tributária referente ao IPI, conforme a Tabela indicada no item 4.3.2.
        CST_PIS          := Qr_C170.FieldByName('ITF_CST_PIS').AsString;
        //Verifica se o valor vem da Regra ou usa o padrão
        if (Qr_C170.FieldByName('PIS_VL_BC').AsCurrency > 0) then
        Begin
          VL_BC_PIS        := FieldByName('PIS_VL_BC').AsCurrency;
          ALIQ_PIS_PERC    := FieldByName('PIS_AQ_NR').AsCurrency;
          QUANT_BC_PIS     := FieldByName('PIS_QT_VDA').AsCurrency;
          ALIQ_PIS_R       := FieldByName('PIS_VL_AQ').AsCurrency;
          VL_PIS           := FieldByName('PIS_VL_NR').AsCurrency;
        end
        else
        Begin
          VL_BC_PIS        := FieldByName('ITF_VL_SUBTOTAL').AsCurrency;
          ALIQ_PIS_PERC    := DM.Qr_Impostos.FieldByName('IPT_PIS').AsCurrency;
          QUANT_BC_PIS     := 0;
          ALIQ_PIS_R       := 0;
          VL_PIS           := FieldByName('ITF_VL_SUBTOTAL').AsCurrency * (DM.Qr_Impostos.FieldByName('IPT_PIS').AsCurrency/100);
        end;
        //Totaliza o Valor do PIS
        Lc_VL_Pis := Lc_VL_Pis + VL_PIS;

        //CST do Cofins
        /// Código da Situação Tributária referente ao COFINS.
        CST_COFINS          := FieldByName('ITF_CST_CFS').AsString;
        //Verifica se o valor vem da Regra ou usa o padrão
        if (FieldByName('CFS_VL_BC').AsCurrency > 0) then
        Begin
          VL_BC_COFINS     := FieldByName('CFS_VL_BC').AsCurrency;
          ALIQ_COFINS_PERC := FieldByName('CFS_AQ_NR').AsFloat;
          QUANT_BC_COFINS  := FieldByName('CFS_QT_UNID').AsFloat;
          ALIQ_COFINS_R    := FieldByName('CFS_VL_AQ').AsCurrency;
          VL_COFINS        := FieldByName('CFS_VL_NR').AsCurrency;
        end
        else
        Begin
          VL_BC_COFINS     := FieldByName('ITF_VL_SUBTOTAL').AsCurrency;
          ALIQ_COFINS_PERC := DM.Qr_Impostos.FieldByName('IPT_COFINS').AsCurrency;
          QUANT_BC_COFINS  := 0;
          ALIQ_COFINS_R    := 0;
          VL_COFINS        := FieldByName('ITF_VL_SUBTOTAL').AsCurrency * (DM.Qr_Impostos.FieldByName('IPT_COFINS').AsCurrency/100);
        end;
        //Totaliza o Valor do PIS
        Lc_VL_Cfs := Lc_VL_Cfs + VL_COFINS;
      end;

      //REGISTRO C176: RESSARCIMENTO DE ICMS EM OPERAÇÕES COM
      //SUBSTITUIÇÃO TRIBUTÁRIA (CÓDIGO 01, 55).
      if (DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString <> Qr_c100.FieldByName('UFE_SIGLA').AsString) then
      Begin
        IF (FieldByName('ICM_VL_ST').AsCurrency > 0) then
          Pc_RegistroC176(SPFiscal);
      end;
      Inc(Lc_I);

      Next;
      Application.ProcessMessages;
    end; //Fim dos Itens;
  end;
end;


procedure TFr_SPEDFiscal.Pc_RegistroC176(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_C,Qr_C176 do
  Begin
    //REGISTRO C176: RESSARCIMENTO DE ICMS EM OPERAÇÕES COM
    //SUBSTITUIÇÃO TRIBUTÁRIA (CÓDIGO 01, 55).
    Active := False;
    ParamByName('PRO_CODIGO').AsInteger := Qr_c170.FieldByName('PRO_CODIGO').AsInteger;
    Active := True;
    FetchAll;
    First;
    if (RecordCount > 1) then
    begin
      with RegistroC176New do
      begin
        COD_MOD_ULT_E := '55';
        NUM_DOC_ULT_E := FieldByName('nfl_numero').AsString;
        SER_ULT_E := FieldByName('NFL_SERIE').AsString;
        DT_ULT_E := FieldByName('nfl_dt_emissao').AsDateTime;
        COD_PART_ULT_E := FieldByName('NFL_CODEMP').AsString;
        QUANT_ULT_E := FieldByName('itf_qtde').AsFloat;
        VL_UNIT_ULT_E := FieldByName('itf_vl_unit').AsCurrency;
        VL_UNIT_BC_ST := FieldByName('icm_vl_st').AsCurrency;
      end;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroC190(Pc_SPEDFiscal: TACBrSPEDFiscal);
Var
  IItens : Integer;
  Lc_Vl_Aux:real;
Begin
  with Pc_SPEDFiscal.Bloco_C,Qr_C190 do
  Begin
    // REGISTRO C190: REGISTRO ANALÍTICO DO DOCUMENTO (CÓDIGO 01, 1B, 04 E 55).
    //c170 - Complemento de Documento Itens do Documento (igos 01, 1B, 04 e 55)
    Active := False;
    ParamByName('NFL_CODIGO').AsInteger := QR_C100.FieldByName('NFL_CODIGO').asInteger;
    ParamByName('NFL_CODMHA').AsInteger := gb_codmha;
    Active := True;
    FetchAll;
    First;
    if QR_C100.FieldByName('NFL_CODIGO').asInteger =138631 then
      First;

    while not Eof do
    begin
      with RegistroC190New do
      begin
        if not FieldByName('CST_ICMS').IsNull then
          CST_ICMS      := FieldByName('CST_ICMS').AsString
        else
          CST_ICMS      := FieldByName('CSO_ICMS').AsString;
        CFOP          := FieldByName('CFOP').AsString;
        ALIQ_ICMS     := FieldByName('ALIQ_ICMS').AsCurrency;
        //a Soma do IPI está sendo feito por aqui, por que não foi possivel fazer pelo sql
        VL_OPR        := FieldByName('VL_OPR').AsCurrency + FieldByName('VL_IPI').AsCurrency;
        VL_BC_ICMS    := FieldByName('VL_BC_ICMS').AsCurrency;
        VL_ICMS       := FieldByName('VL_ICMS').AsCurrency;
        VL_BC_ICMS_ST := FieldByName('VL_BC_ICMS_ST').AsCurrency;
        VL_ICMS_ST    := FieldByName('VL_ICMS_ST').AsCurrency;
        if ( CST_ICMS = '20') or ( CST_ICMS = '70') then
        begin
          VL_RED_BC   := FieldByName('VL_OPR').AsCurrency - FieldByName('VL_BC_ICMS').AsCurrency;
        end
        else
        Begin
          VL_RED_BC   := 0;
        End;
        VL_IPI        := FieldByName('VL_IPI').AsCurrency;
        COD_OBS       := '';
      end; // Fim dos Itens;
      Next;
      Application.ProcessMessages;
    end;

  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroC197(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_C,Qr_C190 do
  Begin
    with RegistroC197New do
    Begin

    End;
  End;
end;

procedure TFr_SPEDFiscal.Pc_RegistroC400(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  {
  with Pc_SPEDFiscal.Bloco_C do
  Begin
    //REGISTRO C400 - EQUIPAMENTO ECF (CÓDIGO 02 e 2D).
    With RegistroC400New do
    begin
      COD_MOD := '2D';
      ECF_MOD := 'DARUMA FS600';
      ECF_FAB := '21098765432123456789';
      ECF_CX := '001';
      Pc_RegistroC405(Pc_SPEDFiscal);
    end;
  end;
  }
end;

procedure TFr_SPEDFiscal.Pc_RegistroC405(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  {
  with Pc_SPEDFiscal.Bloco_C do
  Begin
    With RegistroC405New do
    begin
      DT_DOC := DT_FIN; //StrToDate('30/11/2011');
      CRO := 1;
      CRZ := 1;
      NUM_COO_FIN := 1;
      GT_FIN := 100.00;
      VL_BRT := 100.00;
      Pc_RegistroC410(Pc_SPEDFiscal);
      Pc_RegistroC420(Pc_SPEDFiscal);
      if Bloco_0.Registro0000.IND_PERFIL <> pfPerfilB then
      begin
        Pc_RegistroC460(Pc_SPEDFiscal);
      end;
      Pc_RegistroC470(Pc_SPEDFiscal);
      Pc_RegistroC490(Pc_SPEDFiscal);
      // SÓ envia este registro se o contribuinte for da BA
      if Bloco_0.Registro0000.UF = 'BA' then
      begin
      Pc_RegistroC495(Pc_SPEDFiscal);
      end;
    end;
  end;
  }
end;

procedure TFr_SPEDFiscal.Pc_RegistroC410(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  {
  with Pc_SPEDFiscal.Bloco_C do
  Begin
    With RegistroC410New do
    begin
      VL_PIS := 0.00;
      VL_COFINS := 0.00;
    end;
  end;
  }
end;

procedure TFr_SPEDFiscal.Pc_RegistroC420(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  {
  with Pc_SPEDFiscal.Bloco_C do
  Begin
    With RegistroC420New do
    begin
      COD_TOT_PAR := 'T1700';
      VLR_ACUM_TOT := 100.00;
      NR_TOT := 1;
      DESCR_NR_TOT := 'TOTALIZADOR T1700';
      // Gera este registro somente para empresas do pergil B de apresentação
      if Bloco_0.Registro0000.IND_PERFIL = pfPerfilB then
      begin
        Pc_RegistroC425(Pc_SPEDFiscal);
      end;
    end;
  end;
  }
end;

procedure TFr_SPEDFiscal.Pc_RegistroC425(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  {
  with Pc_SPEDFiscal.Bloco_C do
  Begin
    With RegistroC425New do
    begin
      COD_ITEM := '000001';
      QTD := 1;
      UNID := 'PC';
      VL_ITEM := 100.00;
      VL_PIS := 0.00;
      VL_COFINS := 0.00;
    end;
  end;
  }
end;

procedure TFr_SPEDFiscal.Pc_RegistroC460(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  {
  with Pc_SPEDFiscal.Bloco_C do
  Begin
    with REgistroC460New do
    begin
      COD_MOD := '2D';
      COD_SIT := sdRegular;
      NUM_DOC := '000001';
      DT_DOC := StrToDate('30/11/2011');
      VL_DOC := 100.00;
      VL_PIS := 0.00;
      VL_COFINS := 0.00;
      CPF_CNPJ := '33333333333';
      NOM_ADQ := 'TESTE';
      Pc_RegistroC470(Pc_SPEDFiscal);
    end;
  end;
  }
end;

procedure TFr_SPEDFiscal.Pc_RegistroC470(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  {
  with Pc_SPEDFiscal.Bloco_C do
  Begin
    with RegistroC470New do
    begin
      COD_ITEM := '000001';
      QTD := 1;
      QTD_CANC := 0;
      UNID := 'UN';
      VL_ITEM := 100.00;
      CST_ICMS := '000';
      CFOP := '5102';
      ALIQ_ICMS := 17.00;
      VL_PIS := 0.00;
      VL_COFINS := 0.00;
    end;
  end;
  }
end;

procedure TFr_SPEDFiscal.Pc_RegistroC490(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  {
  with Pc_SPEDFiscal.Bloco_C do
  Begin
    with RegistroC490New do
    begin
      CST_ICMS := '000';
      CFOP := '5102';
      ALIQ_ICMS := 17.00;
      VL_OPR := 100.00;
      VL_BC_ICMS := 100.00;
      VL_ICMS := 17.00;
      COD_OBS := '000001'
    end;
  end;
  }
end;

procedure TFr_SPEDFiscal.Pc_RegistroC495(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  {
  with Pc_SPEDFiscal.Bloco_C do
  Begin
    with RegistroC495New do
    begin
      ALIQ_ICMS := 17.00;
      COD_ITEM := '000001';
      QTD := 1.00;
      QTD_CANC := 0.00;
      UNID := 'UN';
      VL_ITEM := 100.00;
      VL_DESC := 0.00;
      VL_CANC := 0.00;
      VL_ACMO := 0.00;
      VL_BC_ICMS := 100.00;
      VL_ICMS := 17.00;
      VL_ISEN := 0.00;
      VL_ICMS_ST := 0.00;
    end;
  end;
  }
end;

procedure TFr_SPEDFiscal.Pc_Bloco_C;
var
  Lc_Tamanho : Integer;

  Lc_I : Integer;
  Lc_VL_Pis:Real;
  Lc_VL_Cfs : real;
begin
  // Alimenta o componente com informações para gerar todos os registros do
  // Bloco C.
  //Abre a Tabela de Impostos no caso de Precisar
  DM.Qr_Impostos.Active := True;
  with SPFiscal.Bloco_C,Qr_c100 do
  Begin
    Active := False;
    ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
    ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    ParamByName('NFL_CODMHA').AsInteger:=Gb_CodMha;
    Active := True;
    FetchAll;
    First;
    if RecordCount > 0 then
    Begin
      with RegistroC001New do
      Begin
        Gg_Progresso.progress := 0;
        Gg_Progresso.MinValue := 0;
        Gg_Progresso.MaxValue := RecordCount;
        IND_MOV := imComDados;
        while not Eof do
        begin
          Pc_RegistroC100(SPFiscal);
          Next;
          Gg_Progresso.progress := Gg_Progresso.progress + 1;
          Application.ProcessMessages;
        end;
      end;
    end
    else
    Begin
      with RegistroC001New do
      Begin
        IND_MOV := imSemDados;
      End;
    end;
  end;
  SPFiscal.WriteBloco_C(True);  // True, fecha o Bloco
end;

procedure TFr_SPEDFiscal.Pc_Bloco_D;
begin
  // Alimenta o componente com informações para gerar todos os registros do Bloco D.
  with SPFiscal.Bloco_D do
  begin
    with RegistroD001New do
    begin
      IND_MOV := imSemDados;
      //Pc_RegistroD100(SPFiscal);
      //Pc_RegistroD190(SPFiscal);
    end;
  end;
  SPFiscal.WriteBloco_D;
end;


procedure TFr_SPEDFiscal.Pc_RegistroD100(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_D do
  Begin
    with RegistroD100New do
    begin
      IND_OPER := tpEntradaAquisicao;
      IND_EMIT := edTerceiros;
      COD_PART := '000001';
      COD_MOD := '57';
      COD_SIT := sdRegular;
      SER := '1';
      NUM_DOC := '012345';
      CHV_CTE := '';
      DT_DOC := DT_FIN - 1; //StrToDate('30/11/2011');
      DT_A_P := DT_FIN - 1; //StrToDate('30/11/2011');
      TP_CT_e := '1';
      VL_DOC := 100.00;
      VL_DESC := 0.00;
      IND_FRT := tfPorContaEmitente;
      VL_SERV := 100.00;
      VL_BC_ICMS := 100.00;
      VL_ICMS := 17.00;
      VL_NT := 10.10;
      COD_INF := '000001';
      COD_CTA := '111';
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroD190(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_D do
  Begin
    with RegistroD190New do
    begin
      CST_ICMS := '000';
      CFOP := '1252';
      ALIQ_ICMS := 17.00;
      VL_OPR := 100.00;
      VL_BC_ICMS := 100.00;
      VL_ICMS := 17.00;
      VL_RED_BC := 0.00;
      COD_OBS := '000001';
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_Bloco_E;
const
  ESTADOS: array [0 .. 1] of String = ('RS', 'SC');
var
  I: Integer;
begin
  // Alimenta o componente com informações para gerar todos os registros do Bloco E.
  with SPFiscal.Bloco_E do
  begin
    with RegistroE001New do
    begin
      IND_MOV := imComDados;
      Pc_RegistroE100(SPFiscal);

      // Gera um registro E200 e filhos para cada estado onde o contribuinte possui inscrição estadual
      //Pc_RegistroE200(SPFiscal);
      //Pc_RegistroE500(SPFiscal);
    end;
  end;
  SPFiscal.WriteBloco_E;
end;

procedure TFr_SPEDFiscal.Pc_RegistroE100(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_E do
  Begin
    with RegistroE100New do
    begin
      DT_INI := E_Data_Ini.DateTime;
      DT_FIN := E_Data_Fim.DateTime;
      Pc_RegistroE110(SPFiscal);
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroE110(Pc_SPEDFiscal: TACBrSPEDFiscal);
Var
  Lc_Tl_Debito : Real;
  Lc_Tl_Credito: Real;
Begin
  with Pc_SPEDFiscal.Bloco_E do
  Begin
    Lc_Tl_Debito := FC_Vl_TotalIcmsDebito;
    Lc_Tl_Credito := FC_Vl_TotalIcmsCredito;
    IF ((Lc_Tl_Debito - Lc_Tl_Credito) <> 0) then
    Begin
      with RegistroE110New do
      begin
        VL_TOT_DEBITOS := Lc_Tl_Debito;
        VL_AJ_DEBITOS := 0;//Lc_Tl_Credito;
        VL_TOT_AJ_DEBITOS := 0.00;
        VL_ESTORNOS_CRED := 0;
        VL_TOT_CREDITOS := Lc_Tl_Credito;
        VL_AJ_CREDITOS := 0;
        VL_TOT_AJ_CREDITOS := 0;
        VL_ESTORNOS_DEB := 0;
        VL_SLD_CREDOR_ANT := 0;
        if (Lc_Tl_Debito - Lc_Tl_Credito  ) >0 then
          VL_SLD_APURADO := Lc_Tl_Debito - Lc_Tl_Credito
        else
          VL_SLD_APURADO := 0;
        VL_TOT_DED := 0; //
        VL_ICMS_RECOLHER := VL_SLD_APURADO - VL_TOT_DED;

        VL_SLD_CREDOR_TRANSPORTAR := 0;
        DEB_ESP := 0;
        //Pc_RegistroE111(SPFiscal);
        //Pc_RegistroE112(SPFiscal);
        //Pc_RegistroE113(SPFiscal);
        //Rio Grande do Sul não possui as tabelas do registro E115, então este não precisa ser gerado
        //Pc_RegistroE115(SPFiscal);
        Pc_RegistroE116(SPFiscal);
      end;
    End;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroE111(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin

  with Pc_SPEDFiscal.Bloco_E do
  Begin
    with RegistroE111New do
    begin
      COD_AJ_APUR    := 'RS009999';
      DESCR_COMPL_AJ := '';
      VL_AJ_APUR     := 1.00;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroE112(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_E do
  Begin
    with RegistroE112New do
    begin
      NUM_DA    := '123';
      NUM_PROC  := '123';
      IND_PROC  := opOutros;
      PROC      := 'DESCRIÇÃO RESUMIDA';
      TXT_COMPL := 'COMPLEMENTO';
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroE113(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin

  with Pc_SPEDFiscal.Bloco_E do
  Begin
    with RegistroE113New do
      begin
      COD_PART := '000001';
      COD_MOD  := '01';
      SER      := 'SERI';
      SUB      := '';
      NUM_DOC  := '123456789';
      DT_DOC   := Now;
      COD_ITEM := '000001';
      VL_AJ_ITEM := 0;
      end;
  end;
end;


procedure TFr_SPEDFiscal.Pc_RegistroE115(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin

  with Pc_SPEDFiscal.Bloco_E do
  Begin
    with RegistroE115New do
    begin
      COD_INF_ADIC   := 'RS000001';
      VL_INF_ADIC    := 0;
      DESCR_COMPL_AJ := '';
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroE116(Pc_SPEDFiscal: TACBrSPEDFiscal);
Var
  Lc_Data, Lc_Mes, Lc_Ano:String;
  Lc_Tl_Debito : Real;
  Lc_Tl_Credito: Real;
Begin
  with Pc_SPEDFiscal.Bloco_E do
  Begin
    with RegistroE116New do
    begin
      Lc_Tl_Debito := FC_Vl_TotalIcmsDebito;
      Lc_Tl_Credito := FC_Vl_TotalIcmsCredito;
      COD_OR := '000';
      IF ((Lc_Tl_Debito - Lc_Tl_Credito) > 0) then
        VL_OR := Lc_Tl_Debito - Lc_Tl_Credito
      else
        VL_OR := 0;
      DT_VCTO := Now;
      COD_REC := '1015';
      NUM_PROC := '';
      IND_PROC := opNenhum;
      PROC := '';
      TXT_COMPL := '';
      Lc_Data := DateToStr(E_Data_Ini.DateTime);
      Lc_Mes := Copy(Lc_Data,1,2);
      Lc_Ano := Copy(Lc_Data,7,4);
      MES_REF := Lc_Mes + Lc_Ano;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroE200(Pc_SPEDFiscal: TACBrSPEDFiscal);
const
  ESTADOS: array [0 .. 1] of String = ('RS', 'SC');
var
  LC_I: Integer;
Begin

  with Pc_SPEDFiscal.Bloco_E do
  Begin
    // Gera um registro E200 e filhos para cada estado onde o contribuinte possui inscrição estadual
    for Lc_I := Low(ESTADOS) to High(ESTADOS) do
    begin
      with RegistroE200New do
      begin
        DT_INI := StrToDate('01/11/2011');
        DT_FIN := StrToDate('30/11/2011');
        UF := ESTADOS[Lc_I];
        Pc_RegistroE210(SPFiscal);
        Pc_RegistroE220(SPFiscal);
        Pc_RegistroE230(SPFiscal);
        Pc_RegistroE240(SPFiscal);
        Pc_RegistroE250(SPFiscal);
      end;
    end;
  end;
end;
procedure TFr_SPEDFiscal.Pc_RegistroE210(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin

  with Pc_SPEDFiscal.Bloco_E do
  Begin
    with RegistroE210New do
    begin
      IND_MOV_ST := mstSemOperacaoST;
      VL_SLD_CRED_ANT_ST := 0;
      VL_DEVOL_ST := 0;
      VL_RESSARC_ST := 0;
      VL_OUT_CRED_ST := 0;
      VL_AJ_CREDITOS_ST := 0;
      VL_SLD_DEV_ANT_ST := 0.00;
      VL_DEDUCOES_ST := 0;
      VL_ICMS_RECOL_ST := 0.00;
      VL_SLD_CRED_ST_TRANSPORTAR := 0;
      VL_OUT_DEB_ST := 0.00;
      DEB_ESP_ST := 0;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroE220(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin

  with Pc_SPEDFiscal.Bloco_E do
  Begin
    with RegistroE220New do
    begin
      COD_AJ_APUR    := 'RS109999';
      DESCR_COMPL_AJ := '';
      VL_AJ_APUR     := 0.00;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroE230(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin

  with Pc_SPEDFiscal.Bloco_E do
  Begin
    with RegistroE230New do
    begin
      NUM_DA    := '123';
      NUM_PROC  := '123';
      IND_PROC  := opOutros;
      PROC      := 'DESCRIÇÃO RESUMIDA';
      TXT_COMPL := 'COMPLEMENTO';
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroE240(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin

  with Pc_SPEDFiscal.Bloco_E do
  Begin
    with RegistroE250New do
    begin
      COD_OR := '000';
      VL_OR := 0;
      DT_VCTO := Now;
      COD_REC := '123';
      NUM_PROC := '1020304050';
      IND_PROC := opOutros;
      PROC := 'DESCRIÇÃO RESUMIDA';
      TXT_COMPL := '';
      MES_REF := '112011';
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroE250(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin

  with Pc_SPEDFiscal.Bloco_E do
  Begin
    with RegistroE240New do
    begin
      COD_PART   := '000001';
      COD_MOD    := '01';
      SER        := 'SERI';
      SUB        := '';
      NUM_DOC    := '123456789';
      DT_DOC     := Now;
      COD_ITEM   := '000001';
      VL_AJ_ITEM := 0;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroE500(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin

  with Pc_SPEDFiscal.Bloco_E do
  Begin
    with RegistroE500New do
    begin
      IND_APUR := iaMensal;
      DT_INI := StrToDate('01/11/2011');
      DT_FIN := StrToDate('30/11/2011');
      Pc_RegistroE510(SPFiscal);
      Pc_RegistroE520(SPFiscal);
      Pc_RegistroE530(SPFiscal);
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroE510(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin

  with Pc_SPEDFiscal.Bloco_E do
  Begin
    with RegistroE510New do
    begin
      CFOP := '5120';
      CST_IPI := '50';
      VL_CONT_IPI := 0;
      VL_BC_IPI := 0;
      VL_IPI := 0;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroE520(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin

  with Pc_SPEDFiscal.Bloco_E do
  Begin
    with RegistroE520New do
    begin
      VL_SD_ANT_IPI := 0;
      VL_DEB_IPI := 0;
      VL_CRED_IPI := 0;
      VL_OD_IPI := 10.00;
      VL_OC_IPI := 0;
      VL_SC_IPI := 0;
      VL_SD_IPI := 10.00;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroE530(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin

  with Pc_SPEDFiscal.Bloco_E do
  Begin
    with RegistroE530New do
    begin
      IND_AJ := ajDebito;
      VL_AJ := 10;
      COD_AJ := '001';
      IND_DOC := odOutros;
      NUM_DOC := '123';
      DESCR_AJ := 'DESCRIÇÃO DETALHADA';
    end;

  end;
end;


procedure TFr_SPEDFiscal.Pc_RegistroG110(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin

  with Pc_SPEDFiscal.Bloco_G do
  Begin
    With RegistroG110New do
    begin
      DT_INI := Now;
      DT_FIN := Now;
      SALDO_IN_ICMS := 44.00;
      SOM_PARC := 4.40;
      VL_TRIB_EXP := 10.999;
      VL_TOTAL := 10.999;
      IND_PER_SAI := 1.00;
      ICMS_APROP := 4.40;
      SOM_ICMS_OC := 10.999;
      Pc_RegistroG125(SPFiscal);
      Pc_RegistroG126(SPFiscal);
      Pc_RegistroG130(SPFiscal);
      Pc_RegistroG140(SPFiscal);
    end;
  end;
end;
procedure TFr_SPEDFiscal.Pc_RegistroG125(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_G do
  Begin
    With RegistroG125New do
    begin
      COD_IND_BEM := '000001';
      DT_MOV := StrToDate('01/11/2011');
      TIPO_MOV := mbcSI;
      VL_IMOB_ICMS_OP := 10.999;
      VL_IMOB_ICMS_ST := 10.999;
      VL_IMOB_ICMS_FRT := 10.999;
      VL_IMOB_ICMS_DIF := 10.999;
      NUM_PARC := 10;
      VL_PARC_PASS := 4.40;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroG126(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_G do
  Begin
    With RegistroG126New do
    begin
      DT_INI := StrToDate('01/10/2011');
      DT_FIN := StrToDate('30/10/2011');
      NUM_PARC := 1234;
      VL_PARC_PASS := 10.999;
      VL_TRIB_OC := 10.999;
      VL_TOTAL := 10.999;
      IND_PER_SAI := 1.00;
      VL_PARC_APROP := 10.999;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroG130(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_G do
  Begin
    With RegistroG130New do
    begin
      IND_EMIT := edEmissaoPropria;
      COD_PART := '000001';
      COD_MOD := '55';
      SERIE := '1';
      NUM_DOC := '000068849';
      CHV_NFE_CTE := '35100260318797000100550010000688490882775007';
      DT_DOC := Now;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_RegistroG140(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_G do
  Begin
    With RegistroG140New do
    begin
      NUM_ITEM := '9999';
      COD_ITEM := '000001';
    end;

  end;
end;

procedure TFr_SPEDFiscal.Pc_Bloco_G;
begin
  //BLOCO G
  with SPFiscal.Bloco_G do
    begin
      with RegistroG001New do
      begin
        IND_MOV := imSemDados;
        //Pc_RegistroG110(SPFiscal);
      end;
    end;
  SPFiscal.WriteBloco_G;
end;

procedure TFr_SPEDFiscal.Pc_RegistroH005(Pc_SPEDFiscal: TACBrSPEDFiscal);
var
  IInvent: integer;
Begin
  with Pc_SPEDFiscal.Bloco_H do
  Begin
    with RegistroH005New do
    begin
      DT_INV := DT_FIN; //o valor informado no campo deve ser menor ou igual ao valor no campo DT_FIN do registro 0000
      VL_INV := 1000;
      // FILHO
      for IInvent := 1 to 10 do
      begin
        Pc_RegistroH010(SPFiscal);
        Pc_RegistroH020(SPFiscal);
      end;
    end;

  end;

end;

procedure TFr_SPEDFiscal.Pc_RegistroH010(Pc_SPEDFiscal: TACBrSPEDFiscal);
var
  IInvent: integer;
Begin
  with Pc_SPEDFiscal.Bloco_H do
  Begin
    with RegistroH010New do
    begin
      COD_ITEM := FormatFloat('00000000000000', IInvent);
      UNID := 'UN';
      QTD := 1;
      VL_UNIT := 100;
      VL_ITEM := 100;
      IND_PROP := piInformante;
      COD_PART := '';
      TXT_COMPL := '';
      COD_CTA := '';
    end;
  end;

end;

procedure TFr_SPEDFiscal.Pc_RegistroH020(Pc_SPEDFiscal: TACBrSPEDFiscal);
Begin
  with Pc_SPEDFiscal.Bloco_H do
  Begin
    with RegistroH020New do
    begin
      CST_ICMS := '00';
      BC_ICMS  := 1;
      VL_ICMS := 2;
    end;
  end;
end;

procedure TFr_SPEDFiscal.Pc_Bloco_H;
var
  IInvent: integer;
begin
  with SPFiscal.Bloco_H do
  begin
    with RegistroH001New do
    begin
      if chbx_H_Inventario.Checked then
      Begin
        IND_MOV := imComDados;
        Pc_RegistroH005(SPFiscal);
      end
      else
      Begin
        IND_MOV := imSemDados;
      end;
    end;
  SPFiscal.WriteBloco_H;
  end;
end;

procedure TFr_SPEDFiscal.Pc_Bloco_1;
begin
  with SPFiscal.Bloco_1 do
  begin
    with Registro1001New do
    begin
      IND_MOV := imComDados;
      with Registro1010New do
      begin
        // Reg. 1100 - Ocorreu averbação (conclusão) de exportação no período:
        if ChBx_Reg_1100.Checked then IND_EXP   := 'S' else IND_EXP   := 'N';
        // Reg. 1200 Existem informações acerca de créditos de ICMS a serem controlados, definidos pela Sefaz:
        if ChBx_Reg_1200.Checked then IND_CCRF  := 'S' else IND_CCRF  := 'N';
        // Reg. 1250: Possui informações consolidadas de saldos de restituição, ressarcimento e complementação do ICMS?
        if ChBx_Reg_1250.Checked then IND_REST_RESSARC_COMPL_ICMS  := 'S' else IND_REST_RESSARC_COMPL_ICMS  := 'N';
        // Reg. 1300 é comercio varejista de combustíveis:
        if ChBx_Reg_1300.Checked then IND_COMB  := 'S' else IND_COMB  := 'N';
        // Reg. 1390 Usinas de açucar e/àlcool É O estabelecimento é produtor de açucar e/ou àlcool carburante:
        if ChBx_Reg_1390.Checked then IND_USINA := 'S' else IND_USINA := 'N';
        // Reg. 1400 Existem informações a serem prestadas neste registro e o registro é obrigatório em sua Unidade da Federação:
        if ChBx_Reg_1400.Checked then IND_VA    := 'S' else IND_VA    := 'N';
        // Reg. 1500 - A empresa é distribuidora de energia e ocorreu fornecimento de energia elétrica para consumidores de outra UF:
        if ChBx_Reg_1500.Checked then IND_EE    := 'S' else IND_EE    := 'N';
        // Reg. 1600 - Realizou vendas com Cartão de Crédito ou de Débito:
        if ChBx_Reg_1600.Checked then IND_CART  := 'S' else IND_CART  := 'N';
        // Reg. 1700 - é obrigatório em sua unidade da federação o controle de utilização de documentos  fiscais em papel:
        if ChBx_Reg_1700.Checked then IND_FORM  := 'S' else IND_FORM  := 'N';
        // Reg. 1800 A empresa prestou serviços de transporte aéreo de cargas e de passageiros:
        if ChBx_Reg_1800.Checked then IND_AER   := 'S' else IND_AER   := 'N';
        if( DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString = 'PE') then
          IND_GIAF1 := 'S'
        else
          IND_GIAF1 := 'N';
        if( DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString = 'PE') then
          IND_GIAF3 := 'S'
        else
          IND_GIAF3 := 'N';

        IND_GIAF4 := 'N';

      end;
    end;
  end;

  SPFiscal.WriteBloco_1;
end;

procedure TFr_SPEDFiscal.Pc_Bloco_9;
begin
   SPFiscal.WriteBloco_9;
end;

procedure TFr_SPEDFiscal.Pc_GerarArquivoSPED;
begin
  // Método que gera o arquivo TXT.
  SPFiscal.SaveFileTXT ;
end;

procedure TFr_SPEDFiscal.Pc_GerarArquivoERRO;
begin
  with SPFiscal do
    begin
    DT_INI := E_Data_Ini.Date;
    DT_FIN := E_Data_Fim.Date;
    end;

  // Método que gera o arquivo TXT.
  SPFiscal.SaveFileTXT ;

end;

procedure TFr_SPEDFiscal.SB_SairClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_SPEDFiscal.SB_GerarClick(Sender: TObject);
begin
  If Fc_validaGeracaoArquivo then
  Begin
    TRY
      Pc_ProcesoAguarde(Self,'I');
      Self.Enabled := False;
      Pc_preparaGeracao;
      Pc_Bloco_0;
      Pc_Bloco_C;
      Pc_Bloco_D;
      Pc_Bloco_E;
      Pc_Bloco_G;
      Pc_Bloco_H;
      Pc_Bloco_1;
      Pc_Bloco_9;
      Pc_GerarArquivoSPED;
      Lb_Processamento.Caption := 'Processamento concluído';
      Application.ProcessMessages;
    Finally
      Pc_ProcesoAguarde(Self,'F');
      Self.Enabled := true;
    end;      
  end;
end;

procedure TFr_SPEDFiscal.FormShow(Sender: TObject);
begin
  Pc_AtivarTabelas;
  Pc_IniciaVariaveis;
end;

end.

