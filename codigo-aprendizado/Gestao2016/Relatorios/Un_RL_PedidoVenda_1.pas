unit Un_RL_PedidoVenda_1;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ControllerBase, Dialogs, DB, STQuery, QuickRpt, QRCtrls, ExtCtrls, StdCtrls, System.Math;

type
  TRL_PedidoVenda_1 = class(TForm)
    Qrpt: TQuickRep;
    Grupo: TQRGroup;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    Lb_CPFCNPJ: TQRLabel;
    Lb_Cli_Endereco: TQRLabel;
    Lb_Cli_Nome: TQRLabel;
    Lb_Cli_bairro: TQRLabel;
    Lb_Cli_Cnpj: TQRLabel;
    Lb_Cli_cep: TQRLabel;
    Lb_Cli_Cidade: TQRLabel;
    Lb_Cli_IncEst: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    Lb_Cli_FoneC: TQRLabel;
    QRLabel13: TQRLabel;
    Lb_Cli_Fax: TQRLabel;
    QRLabel34: TQRLabel;
    Lb_Cli_Celular: TQRLabel;
    QRLabel36: TQRLabel;
    Lb_Cli_Email: TQRLabel;
    QRLabel48: TQRLabel;
    Lb_Cli_Vendedor: TQRLabel;
    Lb_Pedido: TQRLabel;
    Lb_Cli_Pedido: TQRLabel;
    Lb_Cli_Data: TQRLabel;
    QRLabel38: TQRLabel;
    Rodape: TQRBand;
    Lb_NItens: TQRLabel;
    Lb_QItens: TQRLabel;
    Lb_Desconto: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    Lb_Total: TQRLabel;
    QRLabel31: TQRLabel;
    Lb_TipoCob: TQRLabel;
    QRLabel1: TQRLabel;
    Lb_Frete: TQRLabel;
    Bd_DetalheStr: TQRStringsBand;
    Lb_Codigo: TQRLabel;
    Lb_DescricaoProduto: TQRLabel;
    Lb_Qtde: TQRLabel;
    Lb_VlUnit: TQRLabel;
    Lb_SubTotal: TQRLabel;
    Qr_Ordem: TSTQuery;
    Qr_Itens: TSTQuery;
    QRLabel2: TQRLabel;
    QRMemo2: TQRMemo;
    QRMemo3: TQRMemo;
    QRMemo4: TQRMemo;
    QRMemo5: TQRMemo;
    QRMemo6: TQRMemo;
    QRMemo7: TQRMemo;
    QRMemo8: TQRMemo;
    QRMemo9: TQRMemo;
    QRMemo10: TQRMemo;
    QRMemo11: TQRMemo;
    QRLabel6: TQRLabel;
    QRMemo12: TQRMemo;
    lb_abreviatura: TQRLabel;
    QRMemo1: TQRMemo;
    DataSource1: TDataSource;
    E_Obs: TQRMemo;
    Cabecalho: TQRBand;
    QRLabel7: TQRLabel;
    E_VL_sUBTOTAL: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RodapeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Qr_ItensAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Codigo : Integer;
    It_Sequencia : Integer;
    It_NItens : Real;
    It_Vl_Credito: Currency;
    Procedure PC_PreencheCampos;
    Procedure PC_VAlidaCampos(Pc_Print : Boolean);
    procedure Pc_Cabecalho;
    procedure Pc_Rodape;
    procedure Pc_DefineObservacao;
  end;

var
  RL_PedidoVenda_1: TRL_PedidoVenda_1;

implementation

uses     UN_Sistema, Un_DM, un_principal, env;
{$R *.dfm}

Procedure TRL_PedidoVenda_1.PC_VAlidaCampos(Pc_Print : Boolean);
Begin
  if Pc_Print then
    BEgin
    Lb_Codigo.Font.Color := clBlack;
    Lb_DescricaoProduto.Font.Color := clBlack;
    Lb_Qtde.Font.Color := clBlack;
    lb_abreviatura.Font.Color := clBlack;
    Lb_VlUnit.Font.Color := clBlack;
    Lb_SubTotal.Font.Color := clBlack;
    end
  else
    BEgin
    Lb_Codigo.Font.Color := clWhite;
    Lb_DescricaoProduto.Font.Color := clWhite;
    Lb_Qtde.Font.Color := clWhite;
    lb_abreviatura.Font.Color := clWhite;
    Lb_VlUnit.Font.Color := clWhite;
    Lb_SubTotal.Font.Color := clWhite;
    end;

end;
Procedure TRL_PedidoVenda_1.PC_PreencheCampos;
Var
  LcValor : Real;
Begin
  Lb_Codigo.Caption := Qr_Itens.FieldByName('PRO_CODIGOFAB').AsString;
  Lb_DescricaoProduto.Caption := Qr_Itens.FieldByName('PRO_DESCRICAO').AsString;
  lb_abreviatura.Caption := Qr_Itens.FieldByName('EMB_ABREVIATURA').AsString;
  Lb_Qtde.Caption := formatFloat('#,##0.###',Qr_Itens.FieldByName('ITF_QTDE').AsFloat);
  Lb_VlUnit.Caption := formatFloat('#,##0.00####',Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency);
  LcValor := Qr_Itens.FieldByName('ITF_QTDE').AsFloat * Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency;
  LcValor := RoundTo(LcValor,-2);
  Lb_SubTotal.Caption := FloatToStrf(LcValor,ffFixed,10,2);
end;

procedure TRL_PedidoVenda_1.Pc_Cabecalho;
Var
  Lc_CPF_CNPJ:String;
  Lc_Zr_CNPF: String;

begin

  Lb_Cli_Pedido.Caption := Qr_Ordem.FieldByName('PED_NUMERO').AsString;
  if Qr_Ordem.FieldByName('PED_FATURADO').AsString = 'S' then
    Lb_Cli_Data.Caption := Qr_Ordem.FieldByName('PED_DT_ALTERA').AsString
  else
    Lb_Cli_Data.Caption := Qr_Ordem.FieldByName('PED_DATA').AsString + ' ' + Copy(TimeToStr(time),1,5) + ' hs';

  Lb_Cli_Nome.Caption := Qr_Ordem.FieldByName('EMP_CODIGO').AsString + ' - ' + Qr_Ordem.FieldByName('EMP_NOME').AsString;
  Lb_Cli_Endereco.Caption := Qr_Ordem.FieldByName('END_ENDER').AsString +', '+Qr_Ordem.FieldByName('END_NUMERO').AsString;
  Lb_Cli_cep.Caption := Fc_MascaraCep(Qr_Ordem.FieldByName('END_CEP').AsString);
  Lb_Cli_FoneC.Caption := fc_MascaraFone(Qr_Ordem.FieldByName('END_FONE').AsString);
  Lb_Cli_bairro.Caption := Qr_Ordem.FieldByName('END_BAIRRO').AsString;
  Lb_Cli_Cidade.Caption := concat(Qr_Ordem.FieldByName('CDD_DESCRICAO').AsString,'/',Qr_Ordem.FieldByName('UFE_SIGLA').AsString);
  Lb_Cli_Fax.Caption := fc_MascaraFone(Qr_Ordem.FieldByName('END_FAX').AsString);
  if Length(Qr_Ordem.FieldByName('EMP_CNPJ').AsString)=11 then
    Begin
    Lb_CPFCNPJ.Caption := 'C.P.F:';
    QRLabel10.Caption := 'RG:';
    Lc_Zr_CNPF := Qr_Ordem.FieldByName('EMP_CNPJ').AsString;
    Lc_CPF_CNPJ:=Copy(Lc_Zr_CNPF,1,3)+'.'+
                 Copy(Lc_Zr_CNPF,4,3)+'.'+
                 Copy(Lc_Zr_CNPF,7,3)+'-'+
                 Copy(Lc_Zr_CNPF,10,2);
    end
  else
    Begin
    Lb_CPFCNPJ.Caption := 'C.N.P.J:';
    Lc_Zr_CNPF := Qr_Ordem.FieldByName('EMP_CNPJ').AsString;
    Lc_CPF_CNPJ:=Copy(Lc_Zr_CNPF,1,2)+'.'+
                 Copy(Lc_Zr_CNPF,3,3)+'.'+
                 Copy(Lc_Zr_CNPF,6,3)+'/'+
                 Copy(Lc_Zr_CNPF,9,4)+'-'+
                 Copy(Lc_Zr_CNPF,13,2);
    end;
  Lb_Cli_Cnpj.Caption := Lc_CPF_CNPJ;
  Lb_Cli_IncEst.Caption := Qr_Ordem.FieldByName('EMP_INSC_EST').AsString;
  Lb_Cli_Celular.Caption := fc_MascaraFone(Qr_Ordem.FieldByName('END_CELULAR').AsString);
  Lb_Cli_Email.Caption := Qr_Ordem.FieldByName('EMP_EMAIL').AsString;
  Lb_Cli_Vendedor.Caption := Qr_Ordem.FieldByName('CLB_NOME').AsString;
end;


procedure TRL_PedidoVenda_1.Pc_Rodape;
Begin
  Lb_TipoCob.Caption := Qr_Ordem.FieldByName('FPT_DESCRICAO').AsString + ' - ' + Qr_Ordem.FieldByName('PED_PRAZO').AsString;
  Lb_NItens.Caption := FloattoStrf(It_NItens,ffFixed,10,0);
  Lb_QItens.Caption := FloattoStrf(Qr_Ordem.FieldByName('PED_QT_PRODUTO').AsFloat,ffFixed,10,2);
  E_VL_sUBTOTAL.Caption := FloattoStrf(Qr_Ordem.FieldByName('PED_VL_PRODUTO').AsCurrency,ffFixed,10,2);
  Lb_Frete.Caption := FloattoStrf(Qr_Ordem.FieldByName('PED_VL_FRETE').AsCurrency,ffFixed,10,2);
  Lb_Desconto.Caption := FloattoStrf(Qr_Ordem.FieldByName('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2);
  Lb_Total.Caption := FloattoStrf(Qr_Ordem.FieldByName('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2);
end;

procedure TRL_PedidoVenda_1.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_I : Integer;
  Lc_Nr_Itens : Integer;
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  if (Fc_Tb_Geral('L','GRL_G_MOSTRAESTABELECIMENTO','N') = 'S') then
  Begin
    Cabecalho.Height := 105;
    Pc_Cab_Relatorio(Qrpt);
  end
  else
  Begin
    Cabecalho.Height := 0;
  end;
  It_NItens := 0;
  It_Sequencia := 0;
  Lc_Nr_Itens := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_ITENS_FOLHA',''),10);

  //Pedido
  Qr_Ordem.Active := False;
  Qr_Ordem.ParamByName('PED_CODIGO').AsInteger := It_Codigo;
  Qr_Ordem.ParamByName('PED_CODMHA').AsInteger := Gb_CodMha;
  Qr_Ordem.Active := True;
  Qr_Ordem.FetchAll;
  Qr_Ordem.First;
  Pc_DefineObservacao;
  if Qr_Ordem.FieldByName('PED_FATURADO').AsString = 'S' then
    Lb_Pedido.Caption := 'Revisão:'
  else
    Lb_Pedido.Caption := 'Pedido:' ;
  //Itens do Pedido
  Qr_Itens.Active := False;
  Qr_Itens.ParamByName('ITF_CODPED').AsInteger := It_Codigo;
  Qr_Itens.Active := True;
  Qr_Itens.Last;
  Qr_Itens.First;

  if Qr_Itens.RecordCount > Lc_Nr_Itens then
  Begin
    Bd_DetalheStr.Items.Clear;
    For Lc_I:= 1 to Qr_Itens.RecordCount do
      Bd_DetalheStr.Items.Add(IntTostr(Lc_I));
  end
  else
  begin
    Bd_DetalheStr.Items.Clear;
    For Lc_I:= 1 to Lc_Nr_Itens do
      Bd_DetalheStr.Items.Add(IntTostr(Lc_I));
  end;
  Pc_Cabecalho;
end;

procedure TRL_PedidoVenda_1.Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Not Qr_Itens.Eof then
  Begin
    It_NItens := It_NItens +1;
    It_Sequencia := It_Sequencia + 1;
    pc_ValidaCampos(True);
    Pc_PreencheCAmpos;
    Qr_Itens.Next;
  end
  else
    pc_ValidaCampos(False);
end;

procedure TRL_PedidoVenda_1.RodapeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_Rodape;
end;

procedure TRL_PedidoVenda_1.Qr_ItensAfterOpen(DataSet: TDataSet);
begin
  (Qr_Itens.FieldByName('ITF_QTDE') as TNumericField).DisplayFormat := '0.######';
  (Qr_Itens.FieldByName('ITF_VL_UNIT') as TNumericField).DisplayFormat := '0.00##';
end;

procedure TRL_PedidoVenda_1.Pc_DefineObservacao;
Var
  Lc_Observacao : TMemo;
  Lc_SqlTxt : String;
  Lc_Texto: TMemoryStream;
  Lc_str_aux : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_Observacao:= TMemo.Create(Self);
      Lc_Observacao.Parent:= Self;
      Lc_Observacao.Visible:=FALSE;
      Lc_Observacao.Width := 640;
      Lc_Observacao.Height := 90;
      Lc_Observacao.Top := 0;
      Lc_Observacao.Left := 0;
      Lc_Observacao.Lines.Clear;
      //Observação do Pedido
      if Copy(Qr_Ordem.FieldByName('PED_PRAZO').AsString,1,3) <> '000' then
        Lc_Observacao.Lines.Add('Prazos: ' + Fc_Parcelamento('T',Qr_Ordem));

      if Trim(Qr_Ordem.FieldByName('PED_OBS').AsString) <> '' then
        Lc_Observacao.Lines.Add(Qr_Ordem.FieldByName('PED_OBS').AsString);
      //Cheque Devolvido
      if (Fc_Tb_Geral('L','FIN_G_INF_CHQ_DEV','') = 'S') then
      Begin
        Lc_str_aux := Fc_HistoricoFinanceiro(1,Qr_Ordem.FieldByname('EMP_CODIGO').AsInteger);
        if Trim(Lc_str_aux) <> '' then
          Lc_Observacao.Lines.Add(Lc_str_aux);
      end;
      //Cheque Pre-Datado
      if (Fc_Tb_Geral('L','FIN_G_INF_CHQ_PRE','') = 'S') then
      Begin
        Lc_str_aux := Fc_HistoricoFinanceiro(2,Qr_Ordem.FieldByname('EMP_CODIGO').AsInteger);
        if Trim(Lc_str_aux) <> '' then
          Lc_Observacao.Lines.Add(Lc_str_aux);
      end;
      //Saldo Devedor
      if (Fc_Tb_Geral('L','FIN_G_INF_SALDO_DEV','') = 'S') then
      Begin
        Lc_str_aux := Fc_HistoricoFinanceiro(3,Qr_Ordem.FieldByname('EMP_CODIGO').AsInteger);
        if Trim(Lc_str_aux) <> '' then
          Lc_Observacao.Lines.Add(Lc_str_aux);
      end;

      //Observação do Cadastro de observações
      Lc_SqlTxt := 'SELECT DISTINCT OBS_CODIGO, OBS_DETALHES '+
                   'FROM TB_OBSERVACAO tb_observacao         '+
                   'WHERE (OBS_GERAL = ''3'')                '+
                   ' AND (OBS_CODMHA =:OBS_CODMHA)           ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;
      Active := True;
      First;
      while not Eof do
      begin
        //Registra a Observação
        Lc_Observacao.Lines.Add(FieldByname('OBS_DETALHES').AsString);
        Next;
      end;
    end;
    E_OBS.Lines.Assign(Lc_Observacao.Lines);
    E_OBS.AutoStretch := True;
    Rodape.Height := E_OBS.Height + 58;

  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
    FreeAndNil(Lc_Observacao);
  End;
end;
end.
