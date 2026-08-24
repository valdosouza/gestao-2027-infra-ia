unit UN_RL_Ajuste;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, ExtCtrls, DB, STQuery, QRCtrls;

type
  TRL_Ajuste = class(TForm)
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
    Qr_Ajustes: TSTQuery;
    QRLabel8: TQRLabel;
    Ftr_Data: TQRBand;
    Grp_Data: TQRGroup;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    E_NomeFantasia: TQRDBText;
    QRLabel9: TQRLabel;
    Lb_Tl_Dia: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel15: TQRLabel;
    Lb_VL_Desconto: TQRLabel;
    QRLabel19: TQRLabel;
    Lb_Tl_Total: TQRLabel;
    QRLabel10: TQRLabel;
    Lb_Sbt_Vendas: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel11: TQRLabel;
    E_Retorno: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel20: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Tipo_Oper: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Lb_Empresa: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    QRLabel22: TQRLabel;
    Lb_Pendente: TQRLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Ftr_DataBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
      It_VL_Desconto, IT_Vl_Venda,  It_Vl_Total : Real;
  public
    { Public declarations }
    procedure Pc_Busca;
    procedure Pc_Parametros;
  end;

var
  RL_Ajuste: TRL_Ajuste;

implementation

uses      Un_DM, UN_Sistema, UN_Imp_Ajuste, ComCtrls, Un_Regra_Negocio, Un_Principal, env;
{$R *.dfm}

procedure TRL_Ajuste.Pc_Busca;
VaR
  Lc_SqlTxt:String;
  Lc_Cliente, Lc_Vendedor, Lc_Data:Boolean;
  Pc_Quick: TCustomQuickRep;
begin
  with Fr_Imp_Ajuste do
    Begin
    Screen.Cursor:=crHourGlass;
    It_VL_Desconto := 0;
    IT_Vl_Venda := 0;
    It_Vl_Total := 0;

    Qr_Ajustes.Close;
    Qr_Ajustes.SQL.Clear;

    Lc_SqlTxt := 'SELECT DISTINCT NFL_CODIGO,NFL_DT_EMISSAO,PED_NUMERO,PED_VL_DESCONTO,NFL_NUMERO, '+
              'EMP_NOME,EMP_FANTASIA, '+
              'NFL_VL_TL_NOTA,NFL_CTRL_RETORNO '+
              'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
              '    INNER JOIN TB_EMPRESA tb_empresa '+
              '    ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
              '    INNER JOIN TB_PEDIDO tb_pedido  '+
              '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
              'WHERE (PED_TIPO = 3) AND (NFL_STATUS = ''F'')     ';

  if (not Grb_MnhaEmpresa.Visible) or (not chbx_Empresas.Checked) then
    Begin
    Lc_SqlTxt := Lc_SqlTxt + ' AND (NFL_CODMHA =:NFL_CODMHA) ';
    end;

    if ChBx_Periodo.Checked then
      Lc_SqlTxt := Lc_SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';

    if DBLCB_Empresa.Text ='' then Lc_Cliente := False else Lc_Cliente := True;

    if Lc_Cliente then Lc_SqlTxt := Lc_SqlTxt +'AND (NFL_CODEMP =:NFL_CODEMP) ';
    if Rg_Operacao.ItemIndex = 0 then Lc_SqlTxt := Lc_SqlTxt +'AND (NFL_TIPO LIKE ''E%'') ';
    if Rg_Operacao.ItemIndex = 1 then Lc_SqlTxt := Lc_SqlTxt +'AND (NFL_TIPO LIKE ''S%'') ';

    if RG_Tipo.ItemIndex =0 then Lc_SqlTxt := Lc_SqlTxt + ' AND ( (NFL_NUMERO ='''') or (NFL_NUMERO is null) ) ';
    if RG_Tipo.ItemIndex =1 then Lc_SqlTxt := Lc_SqlTxt + ' AND ( (NFL_NUMERO <>'''') or (NFL_NUMERO is not null) )  ';
    if ChBx_Pendente.Checked then Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_CTRL_RETORNO <> ''N'') ';

    IF ChBx_Nome.Checked then
      Qr_Ajustes.SQL.Add(Lc_SqlTxt+'ORDER BY  NFL_DT_EMISSAO,NFL_NUMERO, EMP_NOME ')
    ELSE
      Qr_Ajustes.SQL.Add(Lc_SqlTxt+'ORDER BY  NFL_DT_EMISSAO,NFL_NUMERO, EMP_FANTASIA ');

    if Lc_Cliente then Qr_Ajustes.ParamByName('NFL_CODEMP').AsInteger:=DBLCB_Empresa.KeyValue;

  if not Grb_MnhaEmpresa.Visible then
    Begin
    Qr_Ajustes.ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    end
  else
    Begin
    if not chbx_Empresas.Checked then
      Qr_Ajustes.ParamByName('NFL_CODMHA').AsInteger := Dblcb_Mha_Empresa.KeyValue;
    end;

    if ChBx_Periodo.Checked then
      begin
      Qr_Ajustes.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      Qr_Ajustes.ParamByName('DATAFIM').AsDate:=E_Data_Fim.Date;
      end;

    Qr_Ajustes.Open;
    Screen.Cursor:=crDefault;
    end;
end;

procedure TRL_Ajuste.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Ajuste:=nil;
end;

procedure TRL_Ajuste.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Sbt_Vendas.Caption:=FloatToStrF(It_Vl_Total,ffNumber,18,2);
  Lb_VL_Desconto.Caption:=FloatToStrF(It_VL_Desconto,ffNumber,18,2);
  Lb_Tl_Total.Caption:=FloatToStrF(It_Vl_Total,ffNumber,18,2);
end;

procedure TRL_Ajuste.DetalheVendaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  IT_Vl_Venda := IT_Vl_Venda + Qr_Ajustes.FieldByName('NFL_VL_TL_NOTA').AsCurrency;
  It_VL_Desconto := It_VL_Desconto + Qr_Ajustes.FieldByName('PED_VL_DESCONTO').AsCurrency;
  if Qr_Ajustes.FieldByName('NFL_CTRL_RETORNO').AsString = 'N' then
    Begin
    E_Retorno.Caption := NAO;
    end
  else
    begin
    if Qr_Ajustes.FieldByName('NFL_CTRL_RETORNO').AsString = 'P' then
      E_Retorno.Caption := 'Pedido'
    else
      E_Retorno.Caption := 'Nota';
    end;
end;

procedure TRL_Ajuste.FormCreate(Sender: TObject);
begin
 Pc_AtivaEstabelecimento;
  with Fr_Imp_Ajuste do
    Begin
    IF ChBx_Nome.Checked then E_NomeFantasia.DataField := ('EMP_NOME');
    if ChBx_Fantasia.Checked then E_NomeFantasia.DataField := ('EMP_FANTASIA');
    end;
end;

procedure TRL_Ajuste.Ftr_DataBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Tl_Dia.Caption := FloatToStrF(IT_Vl_Venda,ffNumber,18,2);
  It_Vl_Total := It_Vl_Total + IT_Vl_Venda;
  IT_Vl_Venda := 0;
end;

procedure TRL_Ajuste.Pc_Parametros;
begin
  with Fr_Imp_Ajuste do
    begin
    // Verifica tipos de documento
    case RG_Tipo.ItemIndex of
      0 : Lb_Tipo_Doc.Caption := 'Pedido';
      1 : Lb_Tipo_Doc.Caption := 'Notas';
      2 : Lb_Tipo_Doc.Caption := 'Todos';
    end;
    // Verifica qual é a operação
    if Rg_Operacao.ItemIndex = 0 then
      Lb_Tipo_Oper.Caption := 'Entrada'
    else
      Lb_Tipo_Oper.Caption := 'Saída';
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

    // Verifica se o campo cliente foi preenchido
    if trim(DBLCB_Empresa.Text) = '' then
      Lb_Empresa.Caption := 'Todos'
    else
      Lb_Empresa.Caption := DBLCB_Empresa.Text;
         // Verifica se o tipo do relatorio
    case Cb_Tipo.ItemIndex of
      0 : Lb_Tipo_Rl.Caption := 'NORMAL';
      1 : Lb_Tipo_Rl.caption := 'DETALHADO';
      2 : Lb_Tipo_Rl.Caption := 'CONSERTOS';
    end;
     // Verifica opção Pendente
    if ChBx_Pendente.Checked = true then
      begin
      Lb_Pendente.Caption := SIM
      end
    else
      begin
      Lb_Pendente.Caption := NAO;
      end;
    end;
end;

procedure TRL_Ajuste.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

end.
