unit Un_RL_ORCAMENTODETALHADO;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery, QRExport;

type
  TRL_OrcamentoDetalhada = class(TForm)
    qr_orcamento: TSTQuery;
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    QRLabel8: TQRLabel;
    QRGroup2: TQRGroup;
    E_DATA: TQRDBText;
    E_CODCOMPRA: TQRDBText;
    QRDBText3: TQRDBText;
    E_EMPRESA: TQRDBText;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel9: TQRLabel;
    Lb_Vl_Unitario: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand5: TQRBand;
    QRDBText9: TQRDBText;
    QRDBText11: TQRDBText;
    E_Vl_Unitario: TQRDBText;
    QRDBText13: TQRDBText;
    Ft_Vendas: TQRBand;
    QRLabel6: TQRLabel;
    Lb_Tl_cotacao: TQRLabel;
    QRBand7: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel7: TQRLabel;
    QRBand6: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    Lb_Nome_Emp: TQRLabel;
    Lb_Tipo: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    Lb_Vendedor: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Ft_VendasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qr_orcamentoAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    IT_Vl_Venda, It_Vl_TL_Venda : Real;

    procedure Pc_Busca;
    procedure Pc_Parametros;
  end;

var
  RL_OrcamentoDetalhada: TRL_OrcamentoDetalhada;

implementation

uses      UN_DM, DBCtrls, UN_Sistema, ComCtrls, Un_Imp_Orcamento, Un_Principal, env;
{$R *.dfm}



procedure TRL_OrcamentoDetalhada.Pc_Busca;
VaR
  Lc_SqlTxt:String;
  Lc_Cliente, Lc_Vendedor, Lc_transportadora, Lc_Auxiliar:Boolean;
begin
  Screen.Cursor:=crHourGlass;
  with Fr_Imp_Orcamento do
  Begin
    IF ChBx_Nome.Checked then E_Empresa.DataField := 'EMP_NOME';
    IF ChBx_Fantasia.Checked then E_Empresa.DataField := 'EMP_FANTASIA';
    IT_Vl_Venda := 0;
    It_Vl_TL_Venda := 0;
    qr_orcamento.Close;
    qr_orcamento.SQL.Clear;

    Lc_SqlTxt :=  ' select tb_pedido.ped_numero, tb_cotacao.ctc_data,tb_cotacao.ctc_numero, '+
                  ' tb_cotacao.ctc_vl_custo, tb_cotacao.ctc_vl_cotacao,ctc_fantasia, '+
                  ' tb_itens_ctc.ict_qtde, tb_itens_ctc.ict_vl_unit, tb_itens_ctc.ict_vl_custo,  '+
                  ' tb_itens_ctc.ict_descricao, clb_nome   '+
                  ' FROM TB_COTACAO  '+
                  '   LEFT OUTER JOIN TB_CONSERTO tb_conserto  ON (tb_cotacao.CTC_CODPED =  tb_conserto.CST_CODPED) ' +
                  '   INNER JOIN tb_itens_ctc tb_itens_ctc on tb_itens_ctc.ict_codctc = tb_cotacao.ctc_codigo        '+
                  '   left outer JOIN tb_pedido tb_pedido on tb_pedido.ped_codigo = TB_COTACAO.ctc_codped '+
                  '   left outer join tb_colaborador on (clb_codigo = CTC_CODVDO) ';

      if (DBLCB_UF.Text <> '') or (DBLCB_CIDADE.Text <> '') then
      Begin
       Lc_SqlTxt:= Lc_SqlTxt +
                    ' INNER JOIN tb_empresa tb_empresa on tb_empresa.emp_codigo = TB_COTACAO.ctc_codemp '+
                    ' INNER JOIN tb_endereco tb_endereco on tb_endereco.end_codemp = tb_empresa.emp_codigo '+
                    ' INNER JOIN tb_cidade tb_cidade on tb_cidade.cdd_codigo = tb_endereco.end_codcdd '+
                    ' INNER JOIN tb_uf tb_uf on tb_uf.ufe_sigla = tb_cidade.cdd_uf ';
      end;
    case RG_Tipo.ItemIndex of
      0:Begin
          Lc_SqlTxt:= Lc_SqlTxt +
            'WHERE ((CTC_CODIGO IS NOT NULL) AND CST_CODIGO IS NULL) '+
            ' AND ((PED_FATURADO = ''C'') OR (PED_CODIGO IS NULL) or (PED_FATURADO = ''A'')) '+
            ' AND (CTC_STATUS <> ''A'') ';

        End;
      1:Begin
          Lc_SqlTxt:= Lc_SqlTxt +
            'WHERE ((CTC_CODIGO IS NOT NULL) AND (CST_CODIGO IS NULL)) '+
            ' AND (PED_FATURADO = ''S'' ) '+
            ' AND (CTC_STATUS <> ''A'') ';
        End
      else
        Lc_SqlTxt:= Lc_SqlTxt + 'WHERE ( CTC_CODIGO IS NOT NULL) ';
    end;


     if not Fm_LME.chbx_Empresas.Checked then
        Lc_SqlTxt := Lc_SqlTxt + ' AND (CTC_CODMHA =:CTC_CODMHA) ';

    if DBLCB_Empresa.Text ='' then Lc_Cliente := False else Lc_Cliente := True;
    if DBLCB_Vendedor.Text ='' then Lc_Vendedor := False else Lc_Vendedor := True;
    if Fm_ListaAuxiliarVenda.Dblcb_Vendedor.Text ='' then Lc_Auxiliar := False else Lc_Auxiliar := True;

    if Lc_Cliente then Lc_SqlTxt := Lc_SqlTxt +'AND (EMP_CODIGO =:EMP_CODIGO) ';
    if Lc_Vendedor then
      if RG_Tipo.ItemIndex =1 then
        Lc_SqlTxt := Lc_SqlTxt +'AND (CTC_CODVDO =:PED_CODVDO) '
      else
        Lc_SqlTxt := Lc_SqlTxt +'AND (PED_CODVDO =:PED_CODVDO) ';

    if Lc_Auxiliar then
      Lc_SqlTxt := Lc_SqlTxt +'AND ( CTC_CODVDO_AUX=:CTC_CODVDO_AUX ) ';



    if ChBx_Periodo.Checked then Lc_SqlTxt := Lc_SqlTxt +'AND ctc_data BETWEEN :DATAINI AND :DATAFIM  ';

    if (DBLCB_CIDADE.Text <> '') then
      Lc_SqlTxt:= Lc_SqlTxt + 'and tb_cidade.cdd_descricao like :cdd_descricao';

    if (DBLCB_UF.Text <> '') then
      Lc_SqlTxt:= Lc_SqlTxt + ' and tb_uf.ufe_sigla = :sigla';


    qr_orcamento.SQL.Add(Lc_SqlTxt + ' ORDER BY  CTC_DATA, CTC_FANTASIA ');

    if Lc_Cliente then qr_orcamento.ParamByName('EMP_CODIGO').AsInteger:=DBLCB_Empresa.KeyValue;
    if Lc_Vendedor then qr_orcamento.ParamByName('CTC_CODVDO').AsInteger:=DBLCB_Vendedor.KeyValue;
    if Lc_Auxiliar then qr_orcamento.ParamByName('CTC_CODVDO_AUX').AsInteger:= Fm_ListaAuxiliarVenda.Dblcb_Vendedor.KeyValue;

    if not Fm_LME.chbx_Empresas.Checked then
      Qr_Orcamento.ParamByName('CTC_CODMHA').AsInteger := Fm_LME.Dblcb_Lista.KeyValue;

    if Fr_Imp_Orcamento.ChBx_Periodo.Checked then
      begin
      qr_orcamento.ParamByName('DATAINI').AsDate:=E_Data_INI.Date;
      qr_orcamento.ParamByName('DATAFIM').AsDate:=E_Data_FIM.Date;
      end;
    if (DBLCB_CIDADE.Text <> '') then  qr_orcamento.ParamByName('cdd_descricao').AsString:='%' +DBLCB_CIDADE.Text + '%';
    if (DBLCB_UF.Text <> '') then qr_orcamento.ParamByName('sigla').AsString:=DBLCB_UF.Text;

    qr_orcamento.Open;
    qr_orcamento.FetchAll;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TRL_OrcamentoDetalhada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_OrcamentoDetalhada:=nil;
end;

procedure TRL_OrcamentoDetalhada.Ft_VendasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Tl_cotacao.Caption := FloatToStrF(qr_orcamento.fieldbyname('CTC_VL_COTACAO').AsCurrency,ffFixed,18,2);
end;

procedure TRL_OrcamentoDetalhada.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_OrcamentoDetalhada.Pc_Parametros;
begin
  with Fr_Imp_Orcamento do
    begin
    // Verifica qual localização cliente
    case RG_Tipo.ItemIndex of
    0 : Lb_Tipo_Rl.Caption := 'Aberto';
    1 : Lb_Tipo_Rl.Caption := 'Fechado';
    2 : Lb_Tipo_Rl.Caption := 'Todos';
    end;
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
    // Verifica o nome da Cidade

    // Verifica o tipo dO Relatorio
   case LBx_TipoRelatorio.ItemIndex of
      0 : Lb_Tipo.Caption := 'Orçamento';
      1 : Lb_Tipo.Caption := 'Orçamento Detalhado';
    end;
    // Verificar o nome do Vendedor
    if trim(DBLCB_Vendedor.Text) = '' then
      Lb_Vendedor.Caption := 'Todos'
    else
      Lb_Vendedor.Caption := DBLCB_Vendedor.Text;
  end;
end;

procedure TRL_OrcamentoDetalhada.qr_orcamentoAfterOpen(DataSet: TDataSet);
begin
  (qr_orcamento.FieldByName('ICT_QTDE') as TNumericField).DisplayFormat  := '#,##0.00';
  (qr_orcamento.FieldByName('ICT_VL_UNIT') as TNumericField).DisplayFormat    := '#,##0.00';
  (qr_orcamento.FieldByName('ICT_VL_CUSTO') as TNumericField).DisplayFormat    := '#,##0.00';
  (qr_orcamento.FieldByName('CTC_VL_COTACAO') as TNumericField).DisplayFormat    := '#,##0.00';
end;

end.
