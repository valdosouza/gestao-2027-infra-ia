unit UN_RL_OS_Veiculo;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_OS_Veiculo = class(TForm)
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    DetalheVenda: TQRBand;
    E_DATA: TQRDBText;
    QRBand4: TQRBand;
    QRLabel10: TQRLabel;
    QRLabel1: TQRLabel;
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
    QRLabel20: TQRLabel;
    QRDBText6: TQRDBText;
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
  RL_OS_Veiculo: TRL_OS_Veiculo;

implementation

uses     Un_DM, UN_Imp_Servico, UN_Sistema, ComCtrls, Mask;
{$R *.dfm}

procedure TRL_OS_Veiculo.Pc_Buscar;
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
    End;

    Lc_SqlTxt := Lc_SqlTxt + ' PED_NUMERO, VEI_FROTA, VEI_PLACA, EMP_FANTASIA, PED_VL_SERVICO, '+
                             ' PED_VL_PRODUTO, PED_VL_DESCONTO, PED_VL_PEDIDO, EMP_NOME        '+
                             ' FROM TB_PEDIDO tb_pedido '+
                             '   INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal '+
                             '   ON  (tb_nota_fiscal.NFL_CODPED = tb_pedido.PED_CODIGO) '+
                             '   INNER JOIN TB_EMPRESA tb_empresa '+
                             '   ON  (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP) ';


    if not chbx_Without_vehicle.Checked then
    BEgin
      Lc_SqlTxt := Lc_SqlTxt + '   INNER JOIN TB_VEHICLE_SO OS '+
                         '   ON  (OS.TB_ORDER_ID = tb_pedido.PED_CODIGO) '+
                         '   INNER JOIN TB_VEICULO Tb_veiculo  '+
                         '   ON  (TB_VEICULO.VEI_PLACA = OS.TB_VEHICLE_ID ) '+
                         '   INNER JOIN TB_MARCA_VEICULO tb_marca_veiculo '+
                         '   ON  (tb_marca_veiculo.MRC_CODIGO = Tb_veiculo.VEI_CODMRC) '+
                         '   INNER JOIN TB_MODELO tb_modelo  '+
                         '   ON  (tb_modelo.MOD_CODIGO = Tb_veiculo.VEI_CODMOD)  ';
    End
    else
    BEgin
      Lc_SqlTxt := Lc_SqlTxt + '   LEFT JOIN TB_VEHICLE_SO OS '+
                         '   ON  (OS.TB_ORDER_ID = tb_pedido.PED_CODIGO) '+
                         '   LEFT JOIN TB_VEICULO Tb_veiculo  '+
                         '   ON  (TB_VEICULO.VEI_PLACA = OS.TB_VEHICLE_ID ) '+
                         '   LEFT JOIN TB_MARCA_VEICULO tb_marca_veiculo '+
                         '   ON  (tb_marca_veiculo.MRC_CODIGO = Tb_veiculo.VEI_CODMRC) '+
                         '   LEFT JOIN TB_MODELO tb_modelo  '+
                         '   ON  (tb_modelo.MOD_CODIGO = Tb_veiculo.VEI_CODMOD)  ';
    End;

    Lc_SqlTxt := Lc_SqlTxt +  '   left outer join TB_VEHICLE_CHECKLIST vck '+
                              '    on (vck.TB_ORDER_ID = OS.TB_ORDER_ID)'+
                              'WHERE (PED_CODIGO IS NOT NULL) AND (NFL_STATUS = ''F'') AND (PED_TIPO = 1) ';

    if DBLCB_Empresa.Text ='' then Lc_Cliente := False else Lc_Cliente := True;

    if (E_PlacaINI.Text = '') or (E_PlacaFIM.Text = '') then Lc_Placa := False else Lc_Placa := True;
    if (E_FrotaINI.Text = '') or (E_FrotaFIM.Text = '') then Lc_Frota := False else Lc_Frota := True;
    if DBLCB_Vendedor.Text ='' then Lc_Vendedor := False else Lc_Vendedor := True;

    if Lc_Cliente then Lc_SqlTxt := Lc_SqlTxt +'AND PED_CODEMP =:PED_CODEMP ';

    if ChBx_Periodo.Checked then
      Begin
      case RG_Tipo.ItemIndex of
        0: Lc_SqlTxt := Lc_SqlTxt +'AND PED_DATA BETWEEN :DATAINI AND :DATAFIM  ';
        1: Lc_SqlTxt := Lc_SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';
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
      0: Qr_Servicos.SQL.Add(Lc_SqlTxt+' ORDER BY PED_DATA, PED_NUMERO ');
      1: Qr_Servicos.SQL.Add(Lc_SqlTxt+' ORDER BY NFL_DT_EMISSAO, PED_NUMERO ');
      2: Qr_Servicos.SQL.Add(Lc_SqlTxt+' ORDER BY PED_DATA, PED_NUMERO ');
    END;

    if Lc_Cliente then Qr_Servicos.ParamByName('PED_CODEMP').AsInteger:=DBLCB_Empresa.KeyValue;

    if ChBx_Periodo.Checked then
      Begin
      Qr_Servicos.ParamByName('DATAINI').AsDate:= E_Data_INI.Date;
      Qr_Servicos.ParamByName('DATAFIM').AsDate:= E_Data_FIM.Date;
      END;
    if Lc_Placa then Qr_Servicos.ParamByName('PLACAINI').AsString := E_PlacaINI.Text;
    if Lc_Placa then Qr_Servicos.ParamByName('PLACAFIM').AsString := E_PlacaFIM.Text;
    if Lc_Frota then Qr_Servicos.ParamByName('FROTAINI').AsString := E_FrotaINI.Text;
    if Lc_Frota then Qr_Servicos.ParamByName('FROTAFIM').AsString := E_FrotaFIM.Text;
    if Lc_Vendedor then Qr_Servicos.ParamByName('PED_CODVDO').AsInteger := DBLCB_Vendedor.KeyValue;
    Qr_Servicos.Active := True;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TRL_OS_Veiculo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_OS_Veiculo := nil;
end;

procedure TRL_OS_Veiculo.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Buscar;
  Pc_Parametros;
end;

procedure TRL_OS_Veiculo.DetalheVendaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Fr_Imp_Servico.ChBx_Nome.Checked then
    E_Cliente.Caption := Qr_Servicos.FieldByName('EMP_NOME').AsString
  else
    E_Cliente.Caption := Qr_Servicos.FieldByName('EMP_FANTASIA').AsString;
end;

procedure TRL_OS_Veiculo.Pc_Parametros;
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
    Lb_Placa.Caption := E_PlacaINI.Text;
    Lb_Placa.Caption := E_PlacaFIM.Text;
    Lb_Frota.Caption := E_FrotaINI.Text;
    Lb_Frota.Caption := E_FrotaFIM.Text;
    // Verifica se o tipo do relatorio
    case Cb_Tipo.ItemIndex of
      0 : Lb_Tipo_Rl.Caption := 'NORMAL';
      1 : Lb_Tipo_Rl.caption := 'DETALHADO';
    end;
  end;
end;


end.
