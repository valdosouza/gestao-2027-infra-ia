unit Un_RL_PedidoVenda_4;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, QuickRpt, QRCtrls, ExtCtrls, QRPDFFilt, grimgctrl, StdCtrls, jpeg, DBCtrls, System.Math;

type
  TRL_PedidoVenda_4 = class(TForm)
    Qr_Itens: TSTQuery;
    DataSource1: TDataSource;
    Qr_Ordem: TSTQuery;
    Ds_Ordem: TDataSource;
    Qr_Parcelamento: TSTQuery;
    Qrpt: TQuickRep;
    Rodape: TQRBand;
    QRMemo44: TQRMemo;
    QRMemo2: TQRMemo;
    QRMemo11: TQRMemo;
    Lb_Vl_Bruto: TQRLabel;
    Lb: TQRLabel;
    QRLabel2: TQRLabel;
    QRMemo1: TQRMemo;
    QRLabel6: TQRLabel;
    QRLabel32: TQRLabel;
    QRMemo3: TQRMemo;
    QRLabel33: TQRLabel;
    QRMemo4: TQRMemo;
    QRMemo5: TQRMemo;
    QRMemo12: TQRMemo;
    QRMemo14: TQRMemo;
    QRMemo23: TQRMemo;
    QRMemo24: TQRMemo;
    QRMemo25: TQRMemo;
    QRMemo26: TQRMemo;
    QRMemo27: TQRMemo;
    QRMemo28: TQRMemo;
    QRMemo29: TQRMemo;
    QRMemo30: TQRMemo;
    QRMemo31: TQRMemo;
    QRMemo32: TQRMemo;
    QRMemo33: TQRMemo;
    QRMemo34: TQRMemo;
    QRMemo35: TQRMemo;
    QRMemo36: TQRMemo;
    QRMemo37: TQRMemo;
    QRMemo38: TQRMemo;
    QRMemo39: TQRMemo;
    QRMemo40: TQRMemo;
    QRMemo41: TQRMemo;
    QRMemo42: TQRMemo;
    QRLabel31: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel38: TQRLabel;
    Lb_Venc_11: TQRLabel;
    Lb_Venc_12: TQRLabel;
    Lb_Venc_13: TQRLabel;
    Lb_Venc_14: TQRLabel;
    Lb_Venc_15: TQRLabel;
    Lb_Venc_21: TQRLabel;
    Lb_Venc_22: TQRLabel;
    Lb_Venc_23: TQRLabel;
    Lb_Venc_24: TQRLabel;
    Lb_Venc_25: TQRLabel;
    Lb_Valor_11: TQRLabel;
    Lb_Valor_12: TQRLabel;
    Lb_Valor_13: TQRLabel;
    Lb_Valor_14: TQRLabel;
    Lb_Valor_15: TQRLabel;
    Lb_Valor_21: TQRLabel;
    Lb_Valor_22: TQRLabel;
    Lb_Valor_23: TQRLabel;
    Lb_Valor_24: TQRLabel;
    Lb_Valor_25: TQRLabel;
    QRMemo43: TQRMemo;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRLabel45: TQRLabel;
    QRShape6: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    Lb_Prazoentrega: TQRLabel;
    Lb_Garantia: TQRLabel;
    Lb_Frete: TQRLabel;
    Lb_Data: TQRLabel;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    e_Obs: TQRMemo;
    QRLabel21: TQRLabel;
    Lb_Despesa: TQRLabel;
    QRMemo10: TQRMemo;
    QRMemo45: TQRMemo;
    QRMemo46: TQRMemo;
    QRMemo47: TQRMemo;
    QRMemo48: TQRMemo;
    QRMemo49: TQRMemo;
    QRMemo50: TQRMemo;
    QRMemo51: TQRMemo;
    Lb_Venc_16: TQRLabel;
    Lb_Venc_17: TQRLabel;
    Lb_Venc_26: TQRLabel;
    Lb_Venc_27: TQRLabel;
    Lb_Valor_16: TQRLabel;
    Lb_Valor_17: TQRLabel;
    Lb_Valor_26: TQRLabel;
    Lb_Valor_27: TQRLabel;
    QRMemo52: TQRMemo;
    QRMemo53: TQRMemo;
    QRMemo54: TQRMemo;
    QRMemo55: TQRMemo;
    Lb_Venc_18: TQRLabel;
    Lb_Venc_28: TQRLabel;
    Lb_Valor_18: TQRLabel;
    Lb_Valor_28: TQRLabel;
    QRMemo56: TQRMemo;
    Lb_VL_Liquido: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel27: TQRLabel;
    Lb_DEsconto: TQRLabel;
    Bd_DetalheStr: TQRStringsBand;
    QRMemo20: TQRMemo;
    QRMemo17: TQRMemo;
    QRMemo18: TQRMemo;
    QRMemo19: TQRMemo;
    QRMemo21: TQRMemo;
    QRMemo22: TQRMemo;
    Lb_DescricaoProduto: TQRLabel;
    Lb_Qtde: TQRLabel;
    Lb_VlUnit: TQRLabel;
    Lb_SubTotal: TQRLabel;
    Lb_Codigo: TQRLabel;
    Lb_Marca: TQRLabel;
    QRBand1: TQRBand;
    Label1: TLabel;
    QRMemo13: TQRMemo;
    QRMemo6: TQRMemo;
    QRMemo7: TQRMemo;
    QRMemo8: TQRMemo;
    QRMemo9: TQRMemo;
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
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel16: TQRLabel;
    Lb_Cli_Fantasia: TQRLabel;
    QRLabel7: TQRLabel;
    QRMemo15: TQRMemo;
    QRMemo16: TQRMemo;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel23: TQRLabel;
    Lb_Cli_UF: TQRLabel;
    QRBand2: TQRBand;
    Img_Logo: TQRImage;
    Lb_Emp_Nome: TQRLabel;
    Lb_Emp_Doc: TQRLabel;
    Lb_Emp_End: TQRLabel;
    Lb_Emp_Fones: TQRLabel;
    Lb_Emp_www: TQRLabel;
    Lb_Emp_email: TQRLabel;
    Lb_Cli_Pedido: TQRLabel;
    QRLabel22: TQRLabel;
    Lb_Credito: TQRLabel;
    Lb_Cli_Contato: TQRLabel;
    QRLabel46: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RodapeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    It_Vl_Chq_DEv, It_Vl_Chq_Pre, It_Sld_Devedor: Real;
  public
    { Public declarations }
    It_Cd_Pedido : Integer;
    It_Nr_Pedido : Integer;
    It_Sequencia : Integer;
    It_NItens : Real;
    Procedure PC_PreencheCampos;
    Procedure PC_VAlidaCampos(Pc_Print : Boolean);
    procedure Pc_Cabecalho;
    procedure Pc_Rodape;
    Procedure Pc_Historico;
    procedure Pc_Parcelamento;
  end;

var
  RL_PedidoVenda_4: TRL_PedidoVenda_4;

implementation

uses     UN_Sistema, Un_DM, UN_Pedido_Vda, Un_Funcoes, Un_Regra_Negocio, RN_Financeiro;
{$R *.dfm}

procedure TRL_PedidoVenda_4.Pc_Parcelamento;
Var
  Lc_Nr_Parcelas : Integer;
  lc_Mtz_Prazo : Array[1..2, 1..16] of string;
  Lc_St_Parcela : String;
  Lc_Vl_Parcela : Real;
  Lc_Tamanho:Integer;
  Lc_I, Lc_J : Integer;
  Lc_Prazo : String;
Begin
  Qr_Parcelamento.Active := False;
  Qr_Parcelamento.ParamByName('PAR_CODPED').AsInteger := It_Cd_Pedido;
  Qr_Parcelamento.Active := True;
  Qr_Parcelamento.FetchAll;

  if Qr_Parcelamento.RecordCount = 0 then
    Begin
    Lc_Nr_Parcelas := StrToIntDef(Copy(Qr_Ordem.FieldByName('PED_PRAZO').AsString,1,3),0);
      For Lc_I := 1 to 16 do
        For Lc_J := 1 to 2 do
          lc_Mtz_Prazo[Lc_J, Lc_I] := '';

    if Lc_Nr_Parcelas = 0 then
      Begin
      lc_Mtz_Prazo[1,1] := Qr_Ordem.FieldByName('PED_DATA').AsString;
      lc_Mtz_Prazo[2,1] := FloatToStrF(Qr_Ordem.FieldByName('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2);
      end
    else
      Begin
      //Resolvemos o problema da Divis�o e dizima periodica
      Lc_St_Parcela := FloatToStrF((Qr_Ordem.FieldByName('PED_VL_PEDIDO').AsCurrency / Lc_Nr_Parcelas),ffFixed,10,2);
      Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);

      For Lc_I := 1 to (Lc_Nr_Parcelas) do
        begin
        Lc_Prazo := Copy(Qr_Ordem.FieldByName('PED_PRAZO').AsString,7,(Length(Qr_Ordem.FieldByName('PED_PRAZO').AsString)-6));
        Lc_Prazo :=  Copy(Lc_Prazo,(((Lc_I - 1) * 4)+1),3);
        if not (Lc_I = Lc_Nr_Parcelas) then
          lc_Mtz_Prazo[2,Lc_I] := Lc_St_Parcela
        else
          lc_Mtz_Prazo[2,Lc_I] := FloatToStrF((Qr_Ordem.FieldByName('PED_VL_PEDIDO').AsCurrency -(Lc_Vl_Parcela * (Lc_Nr_Parcelas - 1))),ffFixed,10,2);
        lc_Mtz_Prazo[1,Lc_I] := DateToStr(Qr_Ordem.FieldByName('PED_DATA').AsDateTime + StrToInt(Lc_Prazo));
        end;
      end;
    end
  else
    Begin
      Lc_I := 1;
      while not Qr_Parcelamento.Eof do
        begin
        lc_Mtz_Prazo[2,Lc_I] := FloatToStrF(Qr_Parcelamento.FieldByname('PAR_VALOR').AsCurrency,ffFixed,10,2);
        lc_Mtz_Prazo[1,Lc_I] := Qr_Parcelamento.FieldByname('PAR_DATA').AsString;
        inc(Lc_I);
        Qr_Parcelamento.Next;
        end;
    end;
  Lb_Venc_11.Caption := lc_Mtz_Prazo[1,1];
  Lb_Venc_12.Caption := lc_Mtz_Prazo[1,2];
  Lb_Venc_13.Caption := lc_Mtz_Prazo[1,3];
  Lb_Venc_14.Caption := lc_Mtz_Prazo[1,4];
  Lb_Venc_15.Caption := lc_Mtz_Prazo[1,5];
  Lb_Venc_16.Caption := lc_Mtz_Prazo[1,6];
  Lb_Venc_17.Caption := lc_Mtz_Prazo[1,7];
  Lb_Venc_18.Caption := lc_Mtz_Prazo[1,8];



  Lb_Venc_21.Caption := lc_Mtz_Prazo[1,9];
  Lb_Venc_22.Caption := lc_Mtz_Prazo[1,10];
  Lb_Venc_23.Caption := lc_Mtz_Prazo[1,11];
  Lb_Venc_24.Caption := lc_Mtz_Prazo[1,12];
  Lb_Venc_25.Caption := lc_Mtz_Prazo[1,13];
  Lb_Venc_26.Caption := lc_Mtz_Prazo[1,14];
  Lb_Venc_27.Caption := lc_Mtz_Prazo[1,15];
  Lb_Venc_28.Caption := lc_Mtz_Prazo[1,16];


  Lb_Valor_11.Caption := lc_Mtz_Prazo[2,1];
  Lb_Valor_12.Caption := lc_Mtz_Prazo[2,2];
  Lb_Valor_13.Caption := lc_Mtz_Prazo[2,3];
  Lb_Valor_14.Caption := lc_Mtz_Prazo[2,4];
  Lb_Valor_15.Caption := lc_Mtz_Prazo[2,5];
  Lb_Valor_16.Caption := lc_Mtz_Prazo[2,6];
  Lb_Valor_17.Caption := lc_Mtz_Prazo[2,7];
  Lb_Valor_18.Caption := lc_Mtz_Prazo[2,8];


  Lb_Valor_21.Caption := lc_Mtz_Prazo[2,9];
  Lb_Valor_22.Caption := lc_Mtz_Prazo[2,10];
  Lb_Valor_23.Caption := lc_Mtz_Prazo[2,11];
  Lb_Valor_24.Caption := lc_Mtz_Prazo[2,12];
  Lb_Valor_25.Caption := lc_Mtz_Prazo[2,13];
  Lb_Valor_26.Caption := lc_Mtz_Prazo[2,14];
  Lb_Valor_27.Caption := lc_Mtz_Prazo[2,15];
  Lb_Valor_28.Caption := lc_Mtz_Prazo[2,16];


end;


Procedure TRL_PedidoVenda_4.Pc_Historico;
Var
  Lc_TExto : String;
  Lc_Cd_Cliente : Integer;
Begin
  Lc_Cd_Cliente := StrToIntdef(Qr_Ordem.FieldByName('EMP_CODIGO').AsString,0);

  //Cheque Devolvido
  It_Vl_Chq_DEv := Fc_SaldoChequeDevolvido(Lc_Cd_Cliente);

  //Cheque Pre-Datado
  It_Vl_Chq_Pre := Fc_SaldoChequePreDatado(Lc_Cd_Cliente);

  //Saldo Devedor
  It_Sld_Devedor := Fc_SaldoDevedorCliente(Lc_Cd_Cliente);


end;

Procedure TRL_PedidoVenda_4.PC_VAlidaCampos(Pc_Print : Boolean);
Begin
  if Pc_Print then
    BEgin
    Lb_Codigo.Font.Color := clBlack;
    Lb_DescricaoProduto.Font.Color := clBlack;
    Lb_Marca.Font.Color := clBlack;
    Lb_Qtde.Font.Color := clBlack;
    Lb_VlUnit.Font.Color := clBlack;
    Lb_SubTotal.Font.Color := clBlack;
    end
  else
    BEgin
    Lb_Codigo.Font.Color := clWhite;
    Lb_DescricaoProduto.Font.Color := clWhite;
    Lb_Marca.Font.Color := clWhite;
    Lb_Qtde.Font.Color := clWhite;
    Lb_VlUnit.Font.Color := clWhite;
    Lb_SubTotal.Font.Color := clWhite;
    end;

end;
Procedure TRL_PedidoVenda_4.PC_PreencheCampos;
Var
  LcValor : Real;
Begin
  Lb_Codigo.Caption := Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString;
  Lb_DescricaoProduto.Caption :=  Qr_Itens.FieldByname('PRO_DESCRICAO').AsString;
  Lb_Marca.Caption := Qr_Itens.FieldByname('MRC_DESCRICAO').AsString;
  Lb_Qtde.Caption := formatFloat('#,##0.###',Qr_Itens.FieldByName('ITF_QTDE').AsFloat);
  Lb_VlUnit.Caption := FloatToStrf(Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency,ffFixed,10,2);
  LcValor := Qr_Itens.FieldByName('ITF_QTDE').AsFloat * Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency;
  LcValor := RoundTo(LcValor,-2);
  Lb_SubTotal.Caption := FloatToStrf(LcValor,ffFixed,10,2);
end;
procedure TRL_PedidoVenda_4.Pc_Cabecalho;
Var
  Lc_Dia, Lc_Mes, Lc_Ano: Integer;
  Lc_Data : String;
begin
  with DM do
    Begin
    Pc_AtivaEstabelecimento;
    Fc_BuscaImagemEmpresa(Img_Logo.Picture,'LOGO');
    Lb_Emp_Nome.Caption := Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString + ' - ' + Qr_Estabelecimento.FieldByname('EMP_NOME').AsString;
    Lb_Emp_Doc.Caption := 'C.N.P.J: '+fc_MascaraCNPJ(Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsString) + ' -  I.E.: '+ Qr_Estabelecimento.FieldByname('EMP_INSC_EST').AsString;
    Lb_Emp_End.Caption := Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ' - ' +Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString + ' - ' +copy(Qr_Estabelecimento.FieldByname('END_CEP').AsString,1,5) + '-' +copy(Qr_Estabelecimento.FieldByname('END_CEP').AsString,6,3) + ' - ' +Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' +Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString;
    Lb_Emp_www.Caption := Qr_Estabelecimento.FieldByname('EMP_SITE').AsString;
    Lb_Emp_email.Caption := Qr_Estabelecimento.FieldByname('EMP_EMAIL').AsString;
    lc_dia := StrToInt(Copy(Qr_Ordem.FieldByName('PED_DATA').AsString,1,2));
    Lc_Mes := StrToInt(Copy(Qr_Ordem.FieldByName('PED_DATA').AsString,4,2));
    Lc_Ano := StrToInt(Copy(Qr_Ordem.FieldByName('PED_DATA').AsString,7,4));
    Lb_Data.Caption := Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ', ' + IntToStr(Lc_Dia) + ' de ' + Fc_DesMes(Lc_Mes,True) + ' de ' + IntToStr(Lc_Ano)+'.';
    end;
end;


procedure TRL_PedidoVenda_4.Pc_Rodape;
Var
  Lc_Obs : TDBMemo;
  Lc_I : Integer;
begin
  Lc_Obs := TDBMemo.Create(Self);
  Lc_Obs.Parent := Qrpt;
  Lc_Obs.Width := e_Obs.Width;
  Lc_Obs.Height := e_Obs.Height;
  Lc_Obs.DataField := 'PED_OBS';
  Lc_Obs.DataSource := Ds_Ordem;
  Lb_Frete.Caption := FloattoStrf(Qr_Ordem.FieldByName('PED_VL_FRETE').AsCurrency,ffFixed,10,2);
  Lb_Vl_Bruto.Caption := FloattoStrf(Qr_Ordem.FieldByName('PED_VL_PRODUTO').AsCurrency + Qr_Ordem.FieldByName('PED_VL_ODESPESA').AsCurrency ,ffCurrency,10,2);
  Lb_Despesa.Caption := FloatToStrf(Qr_Ordem.FieldByName('PED_VL_ODESPESA').AsCurrency,ffCurrency,10,2);
  Lb_DEsconto.Caption := FloattoStrf(Qr_Ordem.FieldByName('PED_VL_DESCONTO').AsCurrency ,ffCurrency,10,2);
  Lb_Credito.Caption := FloattoStrf(Qr_Ordem.FieldByName('PED_VL_CREDITO').AsCurrency ,ffCurrency,10,2);
  Lb_VL_Liquido.Caption := FloatToStrf(Qr_Ordem.FieldByName('PED_VL_PEDIDO').AsCurrency - Qr_Ordem.FieldByName('PED_VL_CREDITO').AsCurrency ,ffCurrency,10,2);


  Lb_Prazoentrega.Caption := Qr_Ordem.FieldByName('PED_DT_ENTREGA').AsString;
  e_Obs.Lines.Clear;
  e_Obs.Lines.Add('  Observções');
  for Lc_I := 0 to Lc_Obs.Lines.Count - 1 do
    e_Obs.Lines.Add('  ' + Lc_Obs.Lines[LC_i]);
  FReeAndNil(Lc_Obs);
end;

procedure TRL_PedidoVenda_4.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_I : Integer;
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  It_NItens := 0;
  It_Sequencia := 0;

  //Pedido
  Qr_Ordem.Active := False;
  Qr_Ordem.ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
  Qr_Ordem.Active := True;
  Qr_Ordem.First;

  //Itens do Pedido
  Qr_Itens.Active := False;
  Qr_Itens.ParamByName('ITF_CODPED').AsInteger := It_Cd_Pedido;
  Qr_Itens.Active := True;
  Qr_Itens.Last;
  Qr_Itens.First;

  if Qr_Itens.RecordCount >10 then
    Begin
    Bd_DetalheStr.Items.Clear;
    For Lc_I:= 1 to Qr_Itens.RecordCount do
      Bd_DetalheStr.Items.Add(IntTostr(Lc_I));
    end
  else
    Begin
    Bd_DetalheStr.Items.Clear;
    For Lc_I:= 1 to 10 do
      Bd_DetalheStr.Items.Add(IntTostr(Lc_I));
    end;

  Pc_Cabecalho;    
end;

procedure TRL_PedidoVenda_4.Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
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

procedure TRL_PedidoVenda_4.RodapeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_Parcelamento;
  Pc_Rodape;
end;

procedure TRL_PedidoVenda_4.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
VAR
 Lc_CPF_CNPJ:String;
begin
  Lb_Cli_Pedido.Caption := Qr_Ordem.FieldByName('PED_NUMERO').AsString;
  Lb_Cli_Nome.Caption := Qr_Ordem.FieldByName('EMP_NOME').AsString;
  Lb_Cli_Fantasia.Caption := Qr_Ordem.FieldByName('EMP_FANTASIA').AsString;
  Lb_Cli_Endereco.Caption := Qr_Ordem.FieldByName('END_ENDER').AsString +', '+Qr_Ordem.FieldByName('END_NUMERO').AsString;
  Lb_Cli_cep.Caption := fc_MascaraCep(Qr_Ordem.FieldByName('END_CEP').AsString);
  Lb_Cli_FoneC.Caption := fc_MascaraFone(Qr_Ordem.FieldByName('END_FONE').AsString);
  Lb_Cli_bairro.Caption := Qr_Ordem.FieldByName('END_BAIRRO').AsString;
  Lb_Cli_Cidade.Caption := Qr_Ordem.FieldByname('CDD_DESCRICAO').AsString;
  Lb_Cli_UF.Caption := Qr_Ordem.FieldByname('UFE_SIGLA').AsString;
  Lb_Cli_Fax.Caption :=fc_MascaraFone(Qr_Ordem.FieldByName('END_FAX').AsString);

  if Length(Qr_Ordem.fieldByName('EMP_CNPJ').AsString)=11 then
    Begin
    Lb_CPFCNPJ.Caption := 'C.P.F:';
    Lb_Cli_Cnpj.Caption := fc_MascaraCPF(Qr_Ordem.fieldByName('EMP_CNPJ').AsString);
    end
  else
    Begin
    Lb_CPFCNPJ.Caption := 'C.N.P.J:';
     Lb_Cli_Cnpj.Caption := fc_MascaraCNPJ(Qr_Ordem.fieldByName('EMP_CNPJ').AsString);
    end;

  Lb_Cli_IncEst.Caption := Qr_Ordem.FieldByName('EMP_INSC_EST').AsString;
  Lb_Cli_Celular.Caption := fc_MascaraFone(Qr_Ordem.FieldByName('END_CELULAR').AsString);
  Lb_Cli_Email.Caption := Qr_Ordem.FieldByName('EMP_EMAIL').AsString;
  Lb_Cli_Vendedor.Caption := Qr_Ordem.FieldByname('CLB_NOME').AsString;
  Lb_Cli_Contato.Caption := Qr_Ordem.FieldByName('END_CONTATO').AsString;
end;

end.
