unit UN_RL_Ordem_Servico;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_Ordem_Servico = class(TForm)
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    DetalheVenda: TQRBand;
    E_DATA: TQRDBText;
    E_CODCOMPRA: TQRDBText;
    QRBand4: TQRBand;
    QRLabel10: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    Qr_Servicos: TSTQuery;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel6: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRDBText4: TQRDBText;
    QRLabel9: TQRLabel;
    QRDBText5: TQRDBText;
    Qr_ServicosORD_NUMERO: TStringField;
    Qr_ServicosVEI_PLACA: TStringField;
    Qr_ServicosEMP_FANTASIA: TStringField;
    Qr_ServicosPED_VL_SERVICO: TBCDField;
    Qr_ServicosPED_VL_PRODUTO: TBCDField;
    Qr_ServicosPED_VL_DESCONTO: TBCDField;
    Qr_ServicosPED_VL_PEDIDO: TBCDField;
    Qr_ServicosDATA: TDateField;
    Qr_ServicosEMP_NOME: TStringField;
    E_Cliente: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Cliente: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel19: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Qr_ServicosVEI_FROTA: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pc_Buscar;
    procedure Pc_Parametros;
  end;

var
  RL_Ordem_Servico: TRL_Ordem_Servico;

implementation

uses     Un_DM, UN_Imp_Servico, UN_Sistema, ComCtrls, Mask;
{$R *.dfm}

procedure TRL_Ordem_Servico.Pc_Buscar;
VaR
  Lc_SqlTxt:String;
  Lc_Cliente, Lc_Placa,Lc_Frota,Lc_Vendedor:Boolean;
begin
  Screen.Cursor:=crHourGlass;
  QR_Servicos.Active := False;
  QR_Servicos.SQL.Clear;
  with Fr_Imp_Servico do
    Begin
    case RG_Tipo.ItemIndex of
      0: Lc_SqlTxt:='SELECT PED_DATA AS DATA, ';
      1: Lc_SqlTxt:='SELECT NFL_DT_EMISSAO AS DATA, ';
      2: Lc_SqlTxt:='SELECT ORD_DT_ENTRADA AS DATA, ';
    End;

    Lc_SqlTxt := Lc_SqlTxt + ' ORD_NUMERO, VEI_FROTA, VEI_PLACA, EMP_FANTASIA, PED_VL_SERVICO, '+
                             ' PED_VL_PRODUTO, PED_VL_DESCONTO, PED_VL_PEDIDO, EMP_NOME        '+
                             ' FROM TB_PEDIDO tb_pedido '+
                             '   INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal '+
                             '   ON  (tb_nota_fiscal.NFL_CODPED = tb_pedido.PED_CODIGO) '+
                             '   INNER JOIN TB_EMPRESA tb_empresa '+
                             '   ON  (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP) ';
      Lc_SqlTxt := Lc_SqlTxt + '   LEFT OUTER JOIN  TB_ORDEMSERVICO Tb_ordemservico '+
                               '   ON  (Tb_ordemservico.ORD_CODPED = tb_pedido.PED_CODIGO) '+
                               '   LEFT OUTER JOIN  TB_VEICULO Tb_veiculo '+
                               '   ON  (TB_VEICULO.VEI_CODIGO=Tb_ordemservico.ORD_CODVEI ) '+
                               'WHERE (PED_CODIGO IS NOT NULL) AND PED_TIPO = 1 ';


    if DBLCB_Empresa.Text ='' then Lc_Cliente := False else Lc_Cliente := True;

    if (ME_PlacaINI.Text = '') or (ME_PlacaFIM.Text = '') then Lc_Placa := False else Lc_Placa := True;
    if (ME_FrotaINI.Text = '') or (ME_FrotaFIM.Text = '') then Lc_Frota := False else Lc_Frota := True;
    if DBLCB_Vendedor.Text ='' then Lc_Vendedor := False else Lc_Vendedor := True;

    if Lc_Cliente then Lc_SqlTxt := Lc_SqlTxt +'AND PED_CODEMP =:PED_CODEMP ';

    if ChBx_Periodo.Checked then
      Begin
      case RG_Tipo.ItemIndex of
        0: Lc_SqlTxt := Lc_SqlTxt +'AND PED_DATA BETWEEN :DATAINI AND :DATAFIM  ';
        1: Lc_SqlTxt := Lc_SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';
        2: Lc_SqlTxt := Lc_SqlTxt +'AND ORD_DT_ENTRADA BETWEEN :DATAINI AND :DATAFIM  ';
      End;
      End;

    if Lc_Placa then Lc_SqlTxt := Lc_SqlTxt +'AND VEI_PLACA BETWEEN :PLACAINI AND :PLACAFIM  ';
    if Lc_Frota then Lc_SqlTxt := Lc_SqlTxt +'AND VEI_FROTA BETWEEN :FROTAINI AND :FROTAFIM  ';

    if Lc_vendedor then
      Begin
      if Rb_Vend_Clliente.Checked then
        Lc_SqlTxt := Lc_SqlTxt +'AND (tb_empresa.EMP_CODVDOR =:PED_CODVDO) '
      else
        Lc_SqlTxt := Lc_SqlTxt +'AND (PED_CODVDO =:PED_CODVDO) '
      end;

    case RG_Tipo.ItemIndex of
      0: Qr_Servicos.SQL.Add(Lc_SqlTxt+' ORDER BY PED_DATA, ORD_NUMERO ');
      1: Qr_Servicos.SQL.Add(Lc_SqlTxt+' ORDER BY NFL_DT_EMISSAO, ORD_NUMERO ');
      2: Qr_Servicos.SQL.Add(Lc_SqlTxt+' ORDER BY ORD_DT_ENTRADA, ORD_NUMERO ');
    END;

    if Lc_Cliente then Qr_Servicos.ParamByName('PED_CODEMP').AsInteger:=DBLCB_Empresa.KeyValue;

    if ChBx_Periodo.Checked then
      Begin
      Qr_Servicos.ParamByName('DATAINI').AsDate:= E_Data_INI.Date;
      Qr_Servicos.ParamByName('DATAFIM').AsDate:= E_Data_FIM.Date;
      END;
    if Lc_Placa then Qr_Servicos.ParamByName('PLACAINI').AsString := ME_PlacaINI.Text;
    if Lc_Placa then Qr_Servicos.ParamByName('PLACAFIM').AsString := ME_PlacaFIM.Text;
    if Lc_Frota then Qr_Servicos.ParamByName('FROTAINI').AsString := ME_FrotaINI.Text;
    if Lc_Frota then Qr_Servicos.ParamByName('FROTAFIM').AsString := ME_FrotaFIM.Text;
    if Lc_Vendedor then Qr_Servicos.ParamByName('PED_CODVDO').AsInteger := DBLCB_Vendedor.KeyValue;
    Qr_Servicos.Active := True;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Ordem_Servico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Ordem_Servico:=nil;
end;

procedure TRL_Ordem_Servico.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Buscar;
  Pc_Parametros;
end;

procedure TRL_Ordem_Servico.DetalheVendaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Fr_Imp_Servico.ChBx_Nome.Checked then
    E_Cliente.Caption := Qr_ServicosEMP_NOME.AsString
  else
    E_Cliente.Caption := Qr_ServicosEMP_FANTASIA.AsString;
end;

procedure TRL_Ordem_Servico.Pc_Parametros;
begin
  with Fr_Imp_Servico do
    begin
    // Verifica tipos de documento
    case RG_Tipo.ItemIndex of
      0 : Lb_Tipo_Doc.Caption := 'Pedido';
      1 : Lb_Tipo_Doc.Caption := 'Nota Fiscal';
      2 : Lb_Tipo_Doc.Caption := 'Ordem de Serviço';
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
    // Verifica se o campo cliente foi preenchido
    if trim(DBLCB_Empresa.Text) = '' then
      Lb_Cliente.Caption := 'Todos'
    else
      Lb_Cliente.Caption := DBLCB_Empresa.Text;
    // Verifica a placa do carro e a frota
    Lb_Placa.Caption := ME_PlacaINI.Text;
    Lb_Placa.Caption := ME_PlacaFIM.Text;
    Lb_Frota.Caption := ME_FrotaINI.Text;
    Lb_Frota.Caption := ME_FrotaFIM.Text;
    // Verifica se o tipo do relatorio
    case Cb_Estilo.ItemIndex of
      0 : Lb_Tipo_Rl.Caption := 'NORMAL';
      1 : Lb_Tipo_Rl.caption := 'DETALHADO';
    end;
  end;
end;


end.
