unit UN_RL_OS_Extintor;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_OS_Extintor = class(TForm)
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
    E_Cliente: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Cliente: TQRLabel;
    QRLabel17: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    QRLabel8: TQRLabel;
    E_Endereco: TQRLabel;
    QRLabel9: TQRLabel;
    QRDBText4: TQRDBText;
    QRExpr4: TQRExpr;
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
  RL_OS_Extintor: TRL_OS_Extintor;

implementation

uses     Un_DM, UN_Imp_Servico, UN_Sistema, ComCtrls, Mask;
{$R *.dfm}

procedure TRL_OS_Extintor.Pc_Buscar;
Var
  Lc_SqlTxt:String;
  Lc_Cliente, Lc_Vendedor:Boolean;
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


    Lc_SqlTxt := Lc_SqlTxt +
                 ' NFL_NUMERO, EMP_FANTASIA, nfl_vl_tl_srv, '+
                 'nfl_vl_tl_prod, PED_VL_DESCONTO, nfl_vl_tl_nota, EMP_NOME,  '+
                 'END_ENDER, END_NUMERO '+
                 'FROM TB_PEDIDO tb_pedido '+
                 '   INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal '+
                 '   ON  (tb_nota_fiscal.NFL_CODPED = tb_pedido.PED_CODIGO) '+
                 '   INNER JOIN TB_EMPRESA tb_empresa '+
                 '   ON  (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP) '+
                 '   INNER JOIN TB_ENDERECO tb_endereco '+
                 '   ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND) '+
                 'WHERE (PED_CODIGO IS NOT NULL) AND (NFL_STATUS = ''F'') AND (PED_TIPO = 1) ';


    if DBLCB_Empresa.Text ='' then Lc_Cliente := False else Lc_Cliente := True;
    if DBLCB_Vendedor.Text ='' then Lc_Vendedor := False else Lc_Vendedor := True;

    if Lc_Cliente then Lc_SqlTxt := Lc_SqlTxt +'AND PED_CODEMP =:PED_CODEMP ';
    if ChBx_Periodo.Checked then
      Lc_SqlTxt := Lc_SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';

    if Lc_vendedor then
      Begin
      if Rb_Vend_Clliente.Checked then
        Lc_SqlTxt := Lc_SqlTxt +'AND (tb_empresa.EMP_CODVDOR =:PED_CODVDO) '
      else
        Lc_SqlTxt := Lc_SqlTxt +'AND (PED_CODVDO =:PED_CODVDO) '
      end;

    Qr_Servicos.SQL.Add(Lc_SqlTxt+' ORDER BY NFL_DT_EMISSAO, NFL_NUMERO ');

    if Lc_Cliente then Qr_Servicos.ParamByName('PED_CODEMP').AsInteger:=DBLCB_Empresa.KeyValue;

    if ChBx_Periodo.Checked then
      Begin
      Qr_Servicos.ParamByName('DATAINI').AsDate:= E_Data_INI.Date;
      Qr_Servicos.ParamByName('DATAFIM').AsDate:= E_Data_FIM.Date;
      END;
    if Lc_Vendedor then Qr_Servicos.ParamByName('PED_CODVDO').AsInteger := DBLCB_Vendedor.KeyValue;
    Qr_Servicos.Active := True;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TRL_OS_Extintor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_OS_Extintor := nil;
end;

procedure TRL_OS_Extintor.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Buscar;
  Pc_Parametros;
end;

procedure TRL_OS_Extintor.DetalheVendaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Fr_Imp_Servico.ChBx_Nome.Checked then
    E_Cliente.Caption := Qr_Servicos.FieldByName('EMP_NOME').AsString
  else
    E_Cliente.Caption := Qr_Servicos.FieldByName('EMP_FANTASIA').AsString;
    E_Endereco.Caption := Qr_Servicos.FieldByName('END_ENDER').AsString + ', ' + Qr_Servicos.FieldByName('END_NUMERO').AsString;
end;

procedure TRL_OS_Extintor.Pc_Parametros;
begin
  with Fr_Imp_Servico do
    begin
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
    end;

end;


end.
