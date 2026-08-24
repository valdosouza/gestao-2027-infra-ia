unit UN_RL_Duplicatas;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.Math, ComCtrls, Dialogs, DB, QRCtrls, QuickRpt, ExtCtrls, STQuery;

type
  TRL_Duplicatas = class(TForm)
    Qr_Duplicatas: TSTQuery;
    Qrpt: TQuickRep;
    Titulo: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel19: TQRLabel;
    Grupo1: TQRGroup;
    E_Empresa: TQRDBText;
    QRLabel4: TQRLabel;
    QRExpr5: TQRExpr;
    Detalhe: TQRBand;
    E_PEd_numero: TQRDBText;
    E_NFL_Numero: TQRDBText;
    E_Fin_Numero: TQRDBText;
    E_Fin_Dt_Vencimento: TQRDBText;
    E_FIN_VL_Parcela: TQRDBText;
    E_FIn_VL_Pago: TQRDBText;
    E_Fin_Dt_Pagto: TQRDBText;
    E_Situacao: TQRExpr;
    E_FIn_Dt_Baixa: TQRDBText;
    SubTotal: TQRBand;
    Lb_Sb_VL_Original: TQRLabel;
    Sumario: TQRBand;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Nome_Cli: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    QRLabel27: TQRLabel;
    Lb_Finan: TQRLabel;
    QRLabel20: TQRLabel;
    PageHeaderBand1: TQRBand;
    QRLabel10: TQRLabel;
    Lb_Titulo: TQRLabel;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel23: TQRLabel;
    Lb_Tipo_Data: TQRLabel;
    E_Sb_VL_Receber: TQRLabel;
    Lb_Sb_VL_Credito_Pedidos: TQRLabel;
    E_Sb_VL_Credito_Pedido: TQRLabel;
    Lb_Sb_VL_Saldo: TQRLabel;
    E_Sb_VL_Saldo: TQRLabel;
    Lb_TL_VL_Original: TQRLabel;
    E_TL_VL_Receber: TQRLabel;
    Lb_TL_VL_Credito: TQRLabel;
    E_TL_VL_Credito: TQRLabel;
    Lb_TL_VL_Saldo: TQRLabel;
    E_TL_VL_Saldo: TQRLabel;
    QRLabel11: TQRLabel;
    E_Sb_VL_Pago: TQRLabel;
    QRLabel12: TQRLabel;
    E_TL_VL_Pago: TQRLabel;
    Lb_Sb_VL_Credito_Manual: TQRLabel;
    E_Sb_VL_Credito_Manual: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SubTotalBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SumarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    procedure FormataLinhas;
    procedure PreencheValores;
  public
    { Public declarations }
  It_Tipo : String;
  SubtotalReceber : Real;
  SubtotalRecebido : Real;
  SubtotalCreditoPedido : Real;
  SubtotalCreditoManual : Real;
  TotalReceber : Real;
  TotalRecebido : Real;
  TotalCredito : Real;

  procedure Pc_Formata_Tela;
  procedure Pc_Busca;
  procedure Pc_Parametros;
  end;

var
  RL_Duplicatas: TRL_Duplicatas;

implementation

uses     Un_DM, UN_Imp_Duplicatas, UN_Sistema, Un_Principal, env;
{$R *.dfm}

procedure TRL_Duplicatas.Pc_Busca;
Var
  sqltxt:string;
  Lc_nome:Boolean;
begin
  Screen.Cursor:=crHourGlass;
  with Fr_Imp_Duplicatas do
  begin
    with Qr_Duplicatas do
    Begin
      SubtotalReceber := 0;
      SubtotalRecebido := 0;
      SubtotalCreditoPedido := 0;
      SubtotalCreditoManual := 0;

      TotalReceber := 0;
      TotalRecebido := 0;
      TotalCredito := 0;

      IF ChBx_Nome.Checked then E_Empresa.DataField := 'EMP_NOME';
      IF ChBx_Fantasia.Checked then E_Empresa.DataField := 'EMP_FANTASIA';
      Close;
      SQL.Clear;
      sqltxt:='SELECT FIN_NUMERO,PED_NUMERO, NFL_NUMERO,FIN_NR_PARCELA,FIN_VL_PARCELA,FIN_DT_VENCIMENTO,FIN_VL_PAGO, '+
              'FIN_DT_PAGTO,FIN_BAIXA,FIN_CODEMP,EMP_FANTASIA, EMP_NOME, FIN_DT_BAIXA, FIN_CODMHA, FIN_OPERACAO,FIN_TIPO  '+
              'FROM TB_FINANCEIRO tb_financeiro '+
              '    INNER JOIN TB_NOTA_FISCAL tb_nota_Fiscal '+
              '    ON (tb_nota_Fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL) '+
              '    LEFT OUTER JOIN TB_PEDIDO tb_pedido '+
              '    ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED) '+
              '    INNER JOIN TB_EMPRESA tb_empresa '+
              '    ON (tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP) ';

      case RG_Financeiro.ItemIndex of
        0:Begin
            sqltxt := sqltxt + 'WHERE (((FIN_TIPO = ''RA'') or (FIN_TIPO = ''RM'')) )';
            case Rg_TipoOperacao.ItemIndex of
              0:sqltxt:=sqltxt+'AND (FIN_OPERACAO = ''C'') ';
              1:sqltxt:=sqltxt+'AND (FIN_OPERACAO = ''D'') ';
            end;
          end;
        1:Begin
            sqltxt := sqltxt + 'WHERE (((FIN_TIPO = ''PA'') or (FIN_TIPO = ''PM'')))';
            case Rg_TipoOperacao.ItemIndex of
              0:sqltxt:=sqltxt+'AND (FIN_OPERACAO = ''D'') ';
              1:sqltxt:=sqltxt+'AND (FIN_OPERACAO = ''C'') ';
            end;
          end;
      end;

      if (not Grb_MnhaEmpresa.Visible) or (not chbx_Empresas.Checked) then
      Begin
        SqlTxt := SqlTxt + ' AND (FIN_CODMHA=:FIN_CODMHA) ';
      end;

      IF ChBx_Periodo.Checked THEN
      begin
        if (Rg_Datas.ItemIndex = 0) then
          sqltxt:=sqltxt+'AND (FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM) '
        else
          sqltxt:=sqltxt+'AND (FIN_DT_PAGTO BETWEEN :DATAINI AND :DATAFIM) ';
      end;

      if DBLCB_Empresa.Text='' then Lc_Nome := false else Lc_Nome := true;

      if Lc_Nome then sqltxt:=sqltxt+' AND (FIN_CODEMP =:FIN_CODEMP) ';
      if RG_Tipo.ItemIndex=0 then sqltxt:=sqltxt+'AND (FIN_BAIXA=''S'') ';
      if RG_Tipo.ItemIndex=1 then sqltxt:=sqltxt+'AND (FIN_BAIXA=''N'') ';

      if Trim( E_BuscaFinanceiro.Text ) <> '' then
        sqltxt:=sqltxt+'AND (FIN_NUMERO LIKE :FIN_NUMERO) ';

      if Chbx_mostrar_creditos_Manuais.Checked then
        sqltxt:=sqltxt+ 'AND ( (FIN_TIPO = ''RM'') OR (FIN_TIPO = ''PM'') )  ';

      if ChBx_Nome.Checked then
        SQL.Add(sqltxt+ ' ORDER BY EMP_NOME, FIN_DT_VENCIMENTO,FIN_CODIGO ')
      else
        SQL.Add(sqltxt+ ' ORDER BY EMP_FANTASIA, FIN_DT_VENCIMENTO,FIN_CODIGO ');

      IF ChBx_Periodo.Checked THEN
      begin
        ParamByName('DATAINI').AsDate:=E_Data_INI.Date;
        ParamByName('DATAFIM').AsDate:=E_Data_FIM.Date;
      end;
      if not Grb_MnhaEmpresa.Visible then
      Begin
        ParamByName('FIN_CODMHA').AsInteger := Gb_CodMha;
      end
      else
      Begin
        if not chbx_Empresas.Checked then
          ParamByName('FIN_CODMHA').AsInteger := Dblcb_Mha_Empresa.KeyValue;
      end;

      if Lc_nome then ParamByName('FIN_CODEMP').AsInteger:=DBLCB_Empresa.KeyValue;

      if Trim( E_BuscaFinanceiro.Text ) <> '' then
        ParamByName('FIN_NUMERO').AsString := E_BuscaFinanceiro.Text + '%';

      Active:=True;
      end;
    end;
  Screen.Cursor:=crDefault;    
end;


procedure TRL_Duplicatas.Pc_Formata_Tela;
Begin
  with Fr_Imp_Duplicatas do
  Begin
    If (RG_Financeiro.ItemIndex = 0) then
    Begin
      Lb_Titulo.Caption := 'Duplicatas - Contasá Receber :';
      Lb_Sb_VL_Original.Caption := 'Valor à receber :';
      Lb_Sb_VL_Credito_Pedidos.Caption := 'Créditos de Pedidos :';
      Lb_Sb_VL_Credito_Manual.Caption := 'Créditos Manuais :';
      Lb_Sb_VL_Saldo.Caption := 'Saldo à receber :';
      Lb_TL_VL_Original.Caption := 'Valor total à receber :';
      Lb_TL_VL_Credito.Caption := 'Valor total dos créditos :';
      Lb_TL_VL_Saldo.Caption := 'Saldo total à receber :';
    end
    else
    Begin
      Lb_Titulo.Caption := 'Duplicatas - Contas É Pagar :';
      Lb_Sb_VL_Original.Caption := 'Valor É Pagar :';
      Lb_Sb_VL_Credito_Pedidos.Caption := 'Créditos de Pedidos :';
      Lb_Sb_VL_Credito_Manual.Caption := 'Créditos Manuais :';
      Lb_Sb_VL_Saldo.Caption := 'Saldo é pagar :';
      Lb_TL_VL_Original.Caption := 'Valor total é pagar :';
      Lb_TL_VL_Credito.Caption := 'Valor total dos créditos :';
      Lb_TL_VL_Saldo.Caption := 'Saldo total é pagar :';
    end;
  end;
end;

procedure TRL_Duplicatas.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Formata_Tela;
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Duplicatas.Pc_Parametros;
begin
  with Fr_Imp_Duplicatas do
    begin
    // Verifica o tipo do Relatorio
    case RG_Tipo.ItemIndex of
      0 : Lb_Tipo_Doc.Caption := 'Baixadas';
      1 : Lb_Tipo_Doc.Caption := 'Abertas';
      2 : Lb_Tipo_Doc.Caption := 'Todas';
    end;
    // Verifica o tipo do Financeiro
    case RG_Financeiro.ItemIndex of
      0 : Lb_Finan.Caption := 'Contasá Receber';
      1 : Lb_Finan.Caption := 'Contas É Pagar';
    end;
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
    // Verifica se o campo empresa foi preenchido
    if trim(DBLCB_Empresa.Text) = '' then
      Lb_Nome_Cli.Caption := 'Todos'
    else
      Lb_Nome_Cli.Caption := DBLCB_Empresa.Text;
    // Verifica opção disposnivel no caixa

    if Rg_Datas.ItemIndex = 0 then
      begin
      Lb_Tipo_Data.Caption := 'Vencimento'
      end
    else
      begin
      Lb_Tipo_Data.Caption := 'Pagamento';
      end;
    end;
end;

procedure TRL_Duplicatas.PreencheValores;
Var
  LcVlAux : REal;
begin

  with Qr_Duplicatas do
  Begin
    if (FieldByName('FIN_BAIXA').AsString = 'S') then
    Begin //quando está baixado soma o campo valor pago
      //Contas a receber
      if (FieldByName('FIN_TIPO').AsString = 'RA') OR (FieldByName('FIN_TIPO').AsString = 'RM') then
      Begin
        //Recebe o credito quan
        if (FieldByName('FIN_OPERACAO').AsString = 'C') then
        Begin
          SubtotalReceber := SubtotalReceber + FieldByName('FIN_VL_PAGO').AsCurrency;
          SubtotalRecebido := SubtotalRecebido + FieldByName('FIN_VL_PAGO').AsCurrency;
        end
        else
        Begin
          if (FieldByName('FIN_TIPO').AsString = 'RA') then
            SubtotalCreditoPedido := SubtotalCreditoPedido + FieldByName('FIN_VL_PAGO').AsCurrency
          else
            SubtotalCreditoManual := SubtotalCreditoManual + FieldByName('FIN_VL_PAGO').AsCurrency
        end;
      End
      else
      Begin
        //Contas a pagar
        //Paga quando É D e recebe credito quando É C
        if (FieldByName('FIN_OPERACAO').AsString = 'D') then
        Begin
          SubtotalReceber := SubtotalReceber + FieldByName('FIN_VL_PAGO').AsCurrency;
          SubtotalRecebido := SubtotalRecebido + FieldByName('FIN_VL_PAGO').AsCurrency;
        end
        else
        Begin
          if (FieldByName('FIN_TIPO').AsString = 'PA') then
            SubtotalCreditoPedido := SubtotalCreditoPedido + FieldByName('FIN_VL_PAGO').AsCurrency
          else
            SubtotalCreditoManual := SubtotalCreditoManual + FieldByName('FIN_VL_PAGO').AsCurrency
        end;
      End;
    End
    else
    Begin //quando está Pendente soma o campo valor parcela
      //Contas a receber
      if (FieldByName('FIN_TIPO').AsString = 'RA') OR (FieldByName('FIN_TIPO').AsString = 'RM') then
      Begin
        //Recebe o C e credito quando
        if (FieldByName('FIN_OPERACAO').AsString = 'C') then
        Begin
          SubtotalReceber := SubtotalReceber + FieldByName('FIN_VL_PARCELA').AsCurrency;
        end
        else
        Begin
          if (FieldByName('FIN_TIPO').AsString = 'RA') then
            SubtotalCreditoPedido := SubtotalCreditoPedido + FieldByName('FIN_VL_PARCELA').AsCurrency
          else
            SubtotalCreditoManual := SubtotalCreditoManual + FieldByName('FIN_VL_PARCELA').AsCurrency
        end;
       End
      else
      Begin
        //Contas a pagar
        //Paga quando É D e recebe credito quando É C
        if (FieldByName('FIN_OPERACAO').AsString = 'D') then
        Begin
          SubtotalReceber := SubtotalReceber + FieldByName('FIN_VL_PARCELA').AsCurrency;
        end
        else
        Begin
          if (FieldByName('FIN_TIPO').AsString = 'PA') then
            SubtotalCreditoPedido := SubtotalCreditoPedido + FieldByName('FIN_VL_PARCELA').AsCurrency
          else
            SubtotalCreditoManual := SubtotalCreditoManual + FieldByName('FIN_VL_PARCELA').AsCurrency
        end;
      End;
    End;
  End;
end;

procedure TRL_Duplicatas.FormataLinhas;
Var
  Lc_Cor : TColor;
begin
  Lc_Cor := clBlack;
  with Qr_Duplicatas do
  Begin
    //Contas a receber
    if (FieldByName('FIN_TIPO').AsString = 'RA') OR (FieldByName('FIN_TIPO').AsString = 'RM') then
    Begin
      //Recebe o C credito quando
      if (FieldByName('FIN_OPERACAO').AsString = 'C') then
      Begin
        Lc_Cor := clBlack;
      end
      else
      Begin
        if (FieldByName('FIN_TIPO').AsString = 'RA') then
          Lc_Cor := clRed
        else
          Lc_Cor := clGreen;
      end;
    End
    else
    Begin
      //Contas a pagar
      //Paga quando É D e recebe credito quando É C
      if (FieldByName('FIN_OPERACAO').AsString = 'D') then
      Begin
        Lc_Cor := clBlack;
      end
      else
      Begin
        if (FieldByName('FIN_TIPO').AsString = 'PA') then
          Lc_Cor := clRed
        else
          Lc_Cor := clGreen;
      end;
    End;
  End;
  E_PEd_numero.Font.Color         := lc_cor;
  E_NFL_Numero.Font.Color         := lc_cor;
  E_Fin_Numero.Font.Color         := lc_cor;
  E_Fin_Dt_Vencimento.Font.Color  := lc_cor;
  E_FIN_VL_Parcela.Font.Color     := lc_cor;
  E_FIn_VL_Pago.Font.Color        := lc_cor;
  E_Fin_Dt_Pagto.Font.Color       := lc_cor;
  E_Situacao.Font.Color           := lc_cor;

end;

procedure TRL_Duplicatas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Duplicatas:=nil;
end;

procedure TRL_Duplicatas.DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Begin
  FormataLinhas;
  PreencheValores;
end;

procedure TRL_Duplicatas.SubTotalBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_Sb_VL_Receber.Caption := FloatToStrF(SubtotalReceber,ffNumber,10,2);
  E_Sb_VL_Pago.Caption := FloatToStrF(SubtotalRecebido,ffNumber,10,2);
  E_Sb_VL_Credito_Pedido.Caption := FloatToStrF(SubtotalCreditoPedido,ffNumber,10,2);
  E_Sb_VL_Credito_Manual.Caption := FloatToStrF(SubtotalCreditoManual,ffNumber,10,2);
  E_Sb_VL_Saldo.Caption := FloatToStrF(SubtotalReceber - SubtotalRecebido - (SubtotalCreditoPedido + SubtotalCreditoManual ) ,ffNumber,10,2);
  TotalReceber := TotalReceber + SubtotalReceber;
  TotalRecebido := TotalRecebido + SubtotalRecebido;
  TotalCredito := TotalCredito + (SubtotalCreditoPedido + SubtotalCreditoManual );
  //Zera os subtotais
  SubtotalReceber := 0;
  SubtotalRecebido := 0;
  SubtotalCreditoPedido := 0;
  SubtotalCreditoManual := 0;
end;

procedure TRL_Duplicatas.SumarioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_TL_VL_Receber.Caption := FloatToStrF(TotalReceber,ffNumber,10,2);
  E_TL_VL_Pago.Caption := FloatToStrF(TotalRecebido,ffNumber,10,2);
  E_TL_VL_Credito.Caption := FloatToStrF(TotalCredito,ffNumber,10,2);
  E_TL_VL_Saldo.Caption := FloatToStrF(TotalReceber - TotalRecebido - TotalCredito,ffNumber,10,2);
end;

end.
