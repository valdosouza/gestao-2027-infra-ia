unit UN_RL_Duplicatas_Saldo;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, QRCtrls, QuickRpt, ExtCtrls, STQuery;

type
   TRL_Duplicatas_Saldo = class(TForm)
      Qrpt: TQuickRep;
      Titulo: TQRBand;
      QRLabel7: TQRLabel;
      Sumario: TQRBand;
      PageHeaderBand1: TQRBand;
      QRLabel10: TQRLabel;
      Lb_Titulo: TQRLabel;
      Qr_Duplicatas: TSTQuery;
      QRBand4: TQRBand;
      QRSysData1: TQRSysData;
      QRSysData2: TQRSysData;
      QRLabel18: TQRLabel;
      QRLabel17: TQRLabel;
      QRLabel1: TQRLabel;
      QRLabel2: TQRLabel;
      Detalhe: TQRBand;
      QRLabel4: TQRLabel;
      Qr_DuplicatasEMP_FANTASIA: TStringField;
      Qr_DuplicatasDIVIDA: TBCDField;
      Qr_DuplicatasPAGO: TBCDField;
      Qr_DuplicatasSALDO: TBCDField;
      QRExpr1: TQRExpr;
      QRExpr4: TQRExpr;
      QRExpr6: TQRExpr;
    QRBand1: TQRBand;
    E_Empresa: TQRDBText;
    QRExpr3: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr7: TQRExpr;
      procedure QrptBeforePrint(Sender: TCustomQuickRep;
         var PrintReport: Boolean);
   private
    { Private declarations }
   public
    { Public declarations }
      It_Tipo: string;
      It_Direct: string;
      procedure Pc_Busca;

   end;

var
   RL_Duplicatas_Saldo: TRL_Duplicatas_Saldo;

implementation

uses     Un_DM, UN_Imp_Duplicatas, UN_Sistema, ComCtrls;
{$R *.dfm}

procedure TRL_Duplicatas_Saldo.Pc_Busca;
var
   sqltxt: string;
   P_nome: Boolean;
   Tipo: string;
begin
   Screen.Cursor := crHourGlass;
   if Fr_Imp_Duplicatas.ChBx_Nome.Checked then
      E_Empresa.DataField := 'EMP_NOME';
   if Fr_Imp_Duplicatas.ChBx_Fantasia.Checked then
      E_Empresa.DataField := 'EMP_FANTASIA';

   Qr_Duplicatas.Close;
   Qr_Duplicatas.SQL.Clear;

   sqltxt := '';
   sqltxt := 'SELECT EMP_FANTASIA, CAST(SUM(FIN_VL_PARCELA) AS NUMERIC(18, 2)) DIVIDA, CAST(SUM(FIN_VL_PAGO) AS NUMERIC(18, 2)) PAGO, ' +
      'CAST(SUM(FIN_VL_PARCELA - FIN_VL_PAGO) AS NUMERIC(18, 2)) SALDO ' +
      'FROM TB_FINANCEIRO tb_financeiro ' +
      '   INNER JOIN TB_EMPRESA tb_empresa ' +
      '   ON (tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP) ' +
      It_Tipo;
   if (Fr_Imp_Duplicatas.RG_Financeiro.ItemIndex = 0) then
   begin
      sqltxt := sqltxt + 'AND (FIN_TIPO=''RM'') OR (FIN_TIPO=''RA'')';
      if Fr_Imp_Duplicatas.ChBxConfere.Checked = true then
         sqltxt := sqltxt + 'AND (FIN_DT_PAGTO BETWEEN :DATAINI AND :DATAFIM) '
      else
         sqltxt := sqltxt + 'AND (FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM) ';
   end
   else
   begin
      sqltxt := sqltxt + 'AND (FIN_TIPO=''PM'') OR (FIN_TIPO=''PA'')';
      sqltxt := sqltxt + 'AND (FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM) ';
   end;

   if Fr_Imp_Duplicatas.DBLCB_Cliente.Text = '' then
      P_Nome := false
   else
      P_Nome := true;

   if P_Nome then
      sqltxt := sqltxt + 'AND (FIN_CODEMP =:FIN_CODEMP) ';
   if Fr_Imp_Duplicatas.RG_Tipo.ItemIndex = 0 then
      sqltxt := sqltxt + 'AND (FIN_BAIXA=''S'') ';
   if Fr_Imp_Duplicatas.RG_Tipo.ItemIndex = 1 then
      sqltxt := sqltxt + 'AND (FIN_BAIXA=''N'') ';

   Qr_Duplicatas.SQL.Add(sqltxt + ' Group by EMP_FANTASIA ');

   Qr_Duplicatas.ParamByName('DATAINI').AsDate := Fr_Imp_Duplicatas.E_Data_INI.Date;
   Qr_Duplicatas.ParamByName('DATAFIM').AsDate := Fr_Imp_Duplicatas.E_Data_FIM.Date;
   if P_nome then
      Qr_Duplicatas.ParamByName('FIN_CODEMP').AsInteger := Fr_Imp_Duplicatas.DBLCB_Cliente.KeyValue;

   Qr_Duplicatas.Active := True;
   Screen.Cursor := crDefault;
end;

procedure TRL_Duplicatas_Saldo.QrptBeforePrint(Sender: TCustomQuickRep;
   var PrintReport: Boolean);
begin
   Pc_Cab_Relatorio(Qrpt);
   case Fr_Imp_Duplicatas.RG_Financeiro.ItemIndex of
      0:
         begin
            Lb_Titulo.Caption := 'Duplicatas - Contas � Receber';
            It_Tipo := 'WHERE ((FIN_TIPO = ''RA'') or (FIN_TIPO = ''RM''))';
         end;
      1:
         begin
            Lb_Titulo.Caption := 'Duplicatas - Contas � Pagar';
            It_Tipo := 'WHERE ((FIN_TIPO = ''PA'') or (FIN_TIPO = ''PM''))';
         end;
   end;
   Pc_Busca;
end;

end.

