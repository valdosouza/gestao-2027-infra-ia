unit UN_RL_Producao;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, DB, STQuery;

type
  TRL_Producao = class(TForm)
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    Qr_Producao: TSTQuery;
    QRGroup1: TQRGroup;
    QRDBText1: TQRDBText;
    QRGroup2: TQRGroup;
    QRBand2: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    Lb_TipoProducao: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    Ft_Producao: TQRBand;
    QRExpr1: TQRExpr;
    QRExpr3: TQRExpr;
    QRLabel6: TQRLabel;
    QRBand3: TQRBand;
    QRLabel7: TQRLabel;
    QRExpr2: TQRExpr;
    QRExpr4: TQRExpr;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Lb_Cliente: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    Lb_Produto: TQRLabel;
    QRLabel31: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pc_Busca;
    procedure Pc_Parametros;
  end;

var
  RL_Producao: TRL_Producao;

implementation

uses     Un_DM, UN_Sistema, UN_Imp_Producao, ComCtrls;
{$R *.dfm}

procedure TRL_Producao.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Producao.Pc_Busca;
Var
  SqlTxt:String;
  PProduto:Boolean;
begin
  Screen.Cursor:=crHourGlass;
  Qr_Producao.SQL.Clear;
  SqlTxt:=' SELECT PRD_CODIGO, PRD_DATA, PRD_VL_MP, PRD_VL_PA, PRD_VL_CUSTO, PRD_BAIXA, ITP_TP_PRO,                     '+
          ' ITP_CODIGO, PRO_CODIGOFAB, PRO_DESCRICAO, ITP_QTDE, ITP_VL_UNIT, (ITP_QTDE* ITP_VL_UNIT) AS ITP_VL_SUBTOTAL '+
          ' FROM TB_PRODUCAO Tb_producao                                                                                '+
          '    INNER JOIN TB_ITENS_PRD tb_itens_prd                                                                     '+
          '    ON (tb_itens_prd.ITP_CODPRD = Tb_producao.PRD_CODIGO)                                                    '+
          '    INNER JOIN TB_PRODUTO tb_produto                                                                         '+
          '    ON (tb_produto.PRO_CODIGO = tb_itens_prd.ITP_CODPRO)                                                     '+
          ' WHERE (PRD_CODIGO IS NOT NULL)                                                                              ';

  if Fr_Imp_Producao.DBLCB_Produto.Text ='' then PProduto := False else PProduto := True;

  if PProduto then SqlTxt := SqlTxt +'AND (ITP_CODPRO =:ITP_CODPRO) ';
  if Fr_Imp_Producao.ChBx_Periodo.Checked then SqlTxt := SqlTxt +'AND (PRD_DATA BETWEEN :DATAINI AND :DATAFIM)  ';
  if Fr_Imp_Producao.RG_Tipo.ItemIndex =0 then SqlTxt := SqlTxt + 'AND (ITP_TP_PRO = ''P'') ';
  if Fr_Imp_Producao.RG_Tipo.ItemIndex =1 then SqlTxt := SqlTxt + 'AND (ITP_TP_PRO = ''M'') ';

  Qr_Producao.SQL.Add(SqlTxt+'ORDER BY PRD_DATA,ITP_TP_PRO,PRO_DESCRICAO');
  if PProduto then Qr_Producao.ParamByName('ITP_CODPRO').AsInteger:=Fr_Imp_Producao.DBLCB_Produto.KeyValue;
  if Fr_Imp_Producao.ChBx_Periodo.Checked then
    begin
    Qr_Producao.ParamByName('DATAINI').AsDate:=Fr_Imp_Producao.E_Data_INI.Date;
    Qr_Producao.ParamByName('DATAFIM').AsDate:=Fr_Imp_Producao.E_Data_FIM.Date;
    end;
  Qr_Producao.Open;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Producao.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Qr_Producao.FieldByname('ITP_TP_PRO').AsString= 'M' then Lb_TipoProducao.Caption:='Mat�ria Prima';
  if Qr_Producao.FieldByname('ITP_TP_PRO').AsString= 'P' then Lb_TipoProducao.Caption:='Produto Acabado';

end;

procedure TRL_Producao.Pc_Parametros;
begin
  with Fr_Imp_Producao do
    begin
    // Verifica tipos de documento
    case RG_Tipo.ItemIndex of
      0 : Lb_Tipo_Doc.Caption := 'Produto Acabado';
      1 : Lb_Tipo_Doc.Caption := 'Mat�ria Prima';
      2 : Lb_Tipo_Doc.Caption := 'Todos';
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
    if DBLCB_Produto.Text = '' then
      Lb_Produto.Caption := 'Todos'
    else
      Lb_Produto.Caption := DBLCB_Produto.Text;
  end;
end;

procedure TRL_Producao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Producao:=nil;
end;

end.
