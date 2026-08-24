unit UN_RL_Cadastro_Colaborador;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, ExtCtrls, DB, STQuery, QRCtrls;

type
  TRL_Cadastro_Colaborador = class(TForm)
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    QRSysData3: TQRSysData;
    QRBand2: TQRBand;
    Lb_Bairro: TQRLabel;
    Lb_CEP: TQRLabel;
    Lb_Ciddade: TQRLabel;
    Label9: TQRLabel;
    Lb_Fone: TQRLabel;
    Lb_Fax: TQRLabel;
    Lb_NomeConta: TQRLabel;
    Lb_Endereco: TQRLabel;
    Lb_Razao: TQRLabel;
    Lb_Codigo: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText12: TQRDBText;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    Qr_Colaborador: TSTQuery;
    QRDBText3: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText5: TQRDBText;
    E_Fone: TQRLabel;
    E_Celular: TQRLabel;
    QRBand4: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    Lb_Sit_Clb: TQRLabel;
    Lb_Nome_Clb: TQRLabel;
    QRLabel6: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Pc_Parametros;
  private
    { Private declarations }
  public
    { Public declarations }

  procedure Pc_Busca;
  end;

var
  RL_Cadastro_Colaborador: TRL_Cadastro_Colaborador;

implementation

uses     Un_DM, DBCtrls, Un_Excel, UN_Sistema, UN_Imp_Colaborador;
{$R *.dfm}



procedure TRL_Cadastro_Colaborador.Pc_Busca;
Var
  Lc_Sqltxt : String;
  Lc_Colaborador:Boolean;
Begin

  Qr_Colaborador.SQL.Clear;
  Lc_Sqltxt := 'SELECT  * FROM TB_COLABORADOR '+
               '   LEFT OUTER JOIN TB_CARGO tb_cargo '+
               '   ON (tb_cargo.CRG_CODIGO = CLB_CODCRG) ';

  case Fr_Imp_Colaborador.RG_Tipo.itemindex of
    0 : Lc_Sqltxt := Lc_Sqltxt + 'WHERE CLB_DEMISSAO IS NULL ';
    1 : Lc_Sqltxt := Lc_Sqltxt + 'WHERE CLB_DEMISSAO IS NOT NULL ';
  end;

  if (Fr_Imp_Colaborador.DBLCB_Colaborador.Text ='')THEN Lc_Colaborador := False else Lc_Colaborador := True;

  if Lc_Colaborador  then Lc_Sqltxt := Lc_Sqltxt +'AND (CLB_CODIGO =:CLB_CODIGO) ';

  Lc_Sqltxt := Lc_Sqltxt + 'Order By CLB_NOME ';

  Qr_Colaborador.SQL.Add(Lc_Sqltxt);

  if Lc_Colaborador then (Qr_Colaborador.ParamByName('CLB_CODIGO').AsInteger := Fr_Imp_Colaborador.DBLCB_Colaborador.KeyValue);
  Qr_Colaborador.Open;
  Screen.Cursor:=crDefault;
end;
procedure TRL_Cadastro_Colaborador.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Cadastro_Colaborador:=nil;
end;

procedure TRL_Cadastro_Colaborador.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Cadastro_Colaborador.QRBand2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  E_Fone.Caption := fc_MascaraFone(Qr_Colaborador.FieldByName('CLB_FONE').AsString);
  E_Celular.Caption := fc_MascaraFone(Qr_Colaborador.FieldByName('CLB_CELULAR').AsString);
end;

procedure TRL_Cadastro_Colaborador.Pc_Parametros;
begin
  with Fr_Imp_Colaborador do
    begin
    // Verifica tipos de documento
    case RG_Tipo.ItemIndex of
      0 : Lb_Sit_Clb.Caption := 'Ativo';
      1 : Lb_Sit_Clb.Caption := 'Demitido';
      2 : Lb_Sit_Clb.Caption := 'Todos';
    end;
    // Verifica se o campo cliente foi preenchido
    if DBLCB_Colaborador.Text = '' then
      Lb_Nome_Clb.Caption := 'Todos'
    else
      Lb_Nome_Clb.Caption := DBLCB_Colaborador.Text;
  end;
end;

end.
