unit UN_RL_PedidoVenda_6;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, QuickRpt, QRCtrls, ExtCtrls, QRPDFFilt, grimgctrl, StdCtrls, jpeg, DBCtrls, System.Math;

type
  TRL_PedidoVenda_6 = class(TForm)
    Qr_Itens: TSTQuery;
    DataSource1: TDataSource;
    Qr_Ordem: TSTQuery;
    Ds_Ordem: TDataSource;
    Qr_Parcelamento: TSTQuery;
    Qrpt: TQuickRep;
    Rodape: TQRBand;
    Bd_DetalheStr: TQRStringsBand;
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
    Lb_Cli_Fantasia: TQRLabel;
    QRLabel7: TQRLabel;
    QRMemo15: TQRMemo;
    QRMemo16: TQRMemo;
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
    Lb_Cli_Contato: TQRLabel;
    QRLabel46: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRMemo57: TQRMemo;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    E_VL_Total_DEsconto: TQRMemo;
    E_Vl_Unit_Desconto: TQRMemo;
    E_VL_Unitario: TQRMemo;
    E_Cd_Produto: TQRMemo;
    E_Descricao: TQRMemo;
    E_Qtde: TQRMemo;
    E_Marca: TQRMemo;
    e_Obs: TQRMemo;
    QRStringsBand1: TQRStringsBand;
    QRMemo11: TQRMemo;
    Lb: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel25: TQRLabel;
    E_PrazoEntrega: TQRLabel;
    E_DadosGarantia: TQRLabel;
    E_Data: TQRLabel;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    QRMemo59: TQRMemo;
    QRMemo60: TQRMemo;
    QRMemo61: TQRMemo;
    QRMemo62: TQRMemo;
    E_VL_SubTotal: TQRMemo;
    E_Dt_Venc_1: TQRMemo;
    E_Vl_Parc_1: TQRMemo;
    E_FormaPagto_1: TQRMemo;
    QRMemo69: TQRMemo;
    E_VL_Desconto: TQRMemo;
    E_Dt_Venc_2: TQRMemo;
    E_Vl_Parc_2: TQRMemo;
    E_FormaPagto_2: TQRMemo;
    QRMemo74: TQRMemo;
    E_VL_Credito_Loja: TQRMemo;
    E_Dt_Venc_3: TQRMemo;
    E_Vl_Parc_3: TQRMemo;
    E_FormaPagto_3: TQRMemo;
    QRMemo79: TQRMemo;
    E_VL_Outras_Despesas: TQRMemo;
    E_Dt_Venc_4: TQRMemo;
    E_Vl_Parc_4: TQRMemo;
    E_FormaPagto_4: TQRMemo;
    QRMemo84: TQRMemo;
    E_Vl_Frete: TQRMemo;
    E_Dt_Venc_5: TQRMemo;
    E_Vl_Parc_5: TQRMemo;
    E_FormaPagto_5: TQRMemo;
    QRMemo89: TQRMemo;
    E_VL_Total_C_Desconto: TQRMemo;
    E_Dt_Venc_6: TQRMemo;
    E_Vl_Parc_6: TQRMemo;
    E_FormaPagto_6: TQRMemo;
    E_Dt_Venc_7: TQRMemo;
    E_Vl_Parc_7: TQRMemo;
    E_FormaPagto_7: TQRMemo;
    E_Dt_Venc_8: TQRMemo;
    E_Vl_Parc_8: TQRMemo;
    E_FormaPagto_8: TQRMemo;
    E_Dt_Venc_9: TQRMemo;
    E_Vl_Parc_9: TQRMemo;
    E_FormaPagto_9: TQRMemo;
    E_Dt_Venc_10: TQRMemo;
    E_Vl_Parc_10: TQRMemo;
    E_FormaPagto_10: TQRMemo;
    E_Dt_Venc_11: TQRMemo;
    E_Vl_Parc_11: TQRMemo;
    E_FormaPagto_11: TQRMemo;
    E_Dt_Venc_12: TQRMemo;
    E_Vl_Parc_12: TQRMemo;
    E_FormaPagto_12: TQRMemo;
    E_Dt_Venc_13: TQRMemo;
    E_Vl_Parc_13: TQRMemo;
    E_FormaPagto_13: TQRMemo;
    E_Dt_Venc_14: TQRMemo;
    E_Vl_Parc_14: TQRMemo;
    E_FormaPagto_14: TQRMemo;
    E_Dt_Venc_15: TQRMemo;
    E_Vl_Parc_15: TQRMemo;
    E_FormaPagto_15: TQRMemo;
    E_Dt_Venc_16: TQRMemo;
    E_Vl_Parc_16: TQRMemo;
    E_FormaPagto_16: TQRMemo;
    E_Slt_Anterior: TQRMemo;
    E_Boletos_Vencer: TQRMemo;
    E_Cheque_Pre: TQRMemo;
    QRMemo2: TQRMemo;
    QRMemo3: TQRMemo;
    QRMemo4: TQRMemo;
    QRMemo5: TQRMemo;
    QRMemo10: TQRMemo;
    QRMemo12: TQRMemo;
    QRLabel21: TQRLabel;
    QRLabel6: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRStringsBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RodapeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    It_Sld_Devedor : Real;
    It_Sld_Boleto : Real;
    It_Sld_Cheque : Real;

    It_VL_TL_Produtos: Currency;
    It_VL_TL_Credito: Currency;
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
    procedure Pc_IniciaVariaveis;
  end;

var
  RL_PedidoVenda_6: TRL_PedidoVenda_6;

implementation

uses     UN_Sistema, Un_DM, UN_Pedido_Vda, Un_Funcoes, Un_Regra_Negocio, RN_Financeiro;
{$R *.dfm}
procedure TRL_PedidoVenda_6.Pc_IniciaVariaveis;
Begin
  ///Variaveis internas
  It_VL_TL_Produtos := 0;
  It_VL_TL_Credito := 0;

  //Historico
  E_Slt_Anterior.Lines.Clear;
  E_Boletos_Vencer.Lines.Clear;
  E_Cheque_Pre.Lines.Clear;
  
  //Totais
  E_VL_SubTotal.Lines.Clear;
  E_VL_Desconto.Lines.Clear;
  E_VL_Credito_Loja.Lines.Clear;
  E_VL_Outras_Despesas.Lines.Clear;
  E_Vl_Frete.Lines.Clear;
  E_VL_Total_C_Desconto.Lines.Clear;
  

  //Vencimento
  E_Dt_Venc_1.Lines.Clear;
  E_Dt_Venc_2.Lines.Clear;
  E_Dt_Venc_3.Lines.Clear;
  E_Dt_Venc_4.Lines.Clear;
  E_Dt_Venc_5.Lines.Clear;
  E_Dt_Venc_6.Lines.Clear;
  E_Dt_Venc_7.Lines.Clear;
  E_Dt_Venc_8.Lines.Clear;
  E_Dt_Venc_9.Lines.Clear;
  E_Dt_Venc_10.Lines.Clear;
  E_Dt_Venc_11.Lines.Clear;
  E_Dt_Venc_12.Lines.Clear;
  E_Dt_Venc_13.Lines.Clear;
  E_Dt_Venc_14.Lines.Clear;
  E_Dt_Venc_15.Lines.Clear;
  E_Dt_Venc_16.Lines.Clear;
  //Valores
  E_Vl_Parc_1.Lines.Clear;
  E_Vl_Parc_2.Lines.Clear;
  E_Vl_Parc_3.Lines.Clear;
  E_Vl_Parc_4.Lines.Clear;
  E_Vl_Parc_5.Lines.Clear;
  E_Vl_Parc_6.Lines.Clear;
  E_Vl_Parc_7.Lines.Clear;
  E_Vl_Parc_8.Lines.Clear;
  E_Vl_Parc_9.Lines.Clear;
  E_Vl_Parc_10.Lines.Clear;
  E_Vl_Parc_11.Lines.Clear;
  E_Vl_Parc_12.Lines.Clear;
  E_Vl_Parc_13.Lines.Clear;
  E_Vl_Parc_14.Lines.Clear;
  E_Vl_Parc_15.Lines.Clear;
  E_Vl_Parc_16.Lines.Clear;
  //Forma de Pagamento
  //Forma de Pagamento
  E_FormaPagto_1.Lines.Clear;
  E_FormaPagto_2.Lines.Clear;
  E_FormaPagto_3.Lines.Clear;
  E_FormaPagto_4.Lines.Clear;
  E_FormaPagto_5.Lines.Clear;
  E_FormaPagto_6.Lines.Clear;
  E_FormaPagto_7.Lines.Clear;
  E_FormaPagto_8.Lines.Clear;
  E_FormaPagto_9.Lines.Clear;
  E_FormaPagto_10.Lines.Clear;
  E_FormaPagto_11.Lines.Clear;
  E_FormaPagto_12.Lines.Clear;
  E_FormaPagto_13.Lines.Clear;
  E_FormaPagto_14.Lines.Clear;
  E_FormaPagto_15.Lines.Clear;
  E_FormaPagto_16.Lines.Clear;
end;

procedure TRL_PedidoVenda_6.Pc_Parcelamento;
Var
  Lc_Nr_Parcelas : Integer;
  lc_Mtz_Prazo : Array[1..3, 1..16] of string;
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
      lc_Mtz_Prazo[3,1] := Qr_Ordem.FieldByname('FPT_DESCRICAO').AsString;
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
        lc_Mtz_Prazo[1,Lc_I] := DateToStr(Qr_Ordem.FieldByName('PED_DATA').AsDateTime + StrToIntDef(Lc_Prazo,0));
        end;
      end;
    end
  else
  Begin
    Lc_I := 1;
    while not Qr_Parcelamento.Eof do
    begin
      if Lc_I > 16 then break;      //o Layout preve apenas 16 parcelas
      lc_Mtz_Prazo[2,Lc_I] := FloatToStrF(Qr_Parcelamento.FieldByNAme('PAR_VALOR').AsCurrency,ffFixed,10,2);
      lc_Mtz_Prazo[1,Lc_I] := Qr_Parcelamento.FieldByNAme('PAR_DATA').AsString;
      lc_Mtz_Prazo[3,Lc_I] := Qr_Parcelamento.FieldByNAme('FPT_DESCRICAO').AsString;
      inc(Lc_I);


      Qr_Parcelamento.Next;
    end;
  end;
  //Vencimento
  E_Dt_Venc_1.Lines.Add(lc_Mtz_Prazo[1,1]);
  E_Dt_Venc_2.Lines.Add(lc_Mtz_Prazo[1,2]);
  E_Dt_Venc_3.Lines.Add(lc_Mtz_Prazo[1,3]);
  E_Dt_Venc_4.Lines.Add(lc_Mtz_Prazo[1,4]);
  E_Dt_Venc_5.Lines.Add(lc_Mtz_Prazo[1,5]);
  E_Dt_Venc_6.Lines.Add(lc_Mtz_Prazo[1,6]);
  E_Dt_Venc_7.Lines.Add(lc_Mtz_Prazo[1,7]);
  E_Dt_Venc_8.Lines.Add(lc_Mtz_Prazo[1,8]);
  E_Dt_Venc_9.Lines.Add(lc_Mtz_Prazo[1,9]);
  E_Dt_Venc_10.Lines.Add(lc_Mtz_Prazo[1,10]);
  E_Dt_Venc_11.Lines.Add(lc_Mtz_Prazo[1,11]);
  E_Dt_Venc_12.Lines.Add(lc_Mtz_Prazo[1,12]);
  E_Dt_Venc_13.Lines.Add(lc_Mtz_Prazo[1,13]);
  E_Dt_Venc_14.Lines.Add(lc_Mtz_Prazo[1,14]);
  E_Dt_Venc_15.Lines.Add(lc_Mtz_Prazo[1,15]);
  E_Dt_Venc_16.Lines.Add(lc_Mtz_Prazo[1,16]);
  //Valores
  E_Vl_Parc_1.Lines.Add(lc_Mtz_Prazo[2,1] + '  ');
  E_Vl_Parc_2.Lines.Add(lc_Mtz_Prazo[2,2] + '  ');
  E_Vl_Parc_3.Lines.Add(lc_Mtz_Prazo[2,3] + '  ');
  E_Vl_Parc_4.Lines.Add(lc_Mtz_Prazo[2,4] + '  ');
  E_Vl_Parc_5.Lines.Add(lc_Mtz_Prazo[2,5] + '  ');
  E_Vl_Parc_6.Lines.Add(lc_Mtz_Prazo[2,6] + '  ');
  E_Vl_Parc_7.Lines.Add(lc_Mtz_Prazo[2,7] + '  ');
  E_Vl_Parc_8.Lines.Add(lc_Mtz_Prazo[2,8] + '  ');
  E_Vl_Parc_9.Lines.Add(lc_Mtz_Prazo[2,9] + '  ');
  E_Vl_Parc_10.Lines.Add(lc_Mtz_Prazo[2,10] + '  ');
  E_Vl_Parc_11.Lines.Add(lc_Mtz_Prazo[2,11] + '  ');
  E_Vl_Parc_12.Lines.Add(lc_Mtz_Prazo[2,12] + '  ');
  E_Vl_Parc_13.Lines.Add(lc_Mtz_Prazo[2,13] + '  ');
  E_Vl_Parc_14.Lines.Add(lc_Mtz_Prazo[2,14] + '  ');
  E_Vl_Parc_15.Lines.Add(lc_Mtz_Prazo[2,15] + '  ');
  E_Vl_Parc_16.Lines.Add(lc_Mtz_Prazo[2,16] + '  ');
  //Forma de Pagamento
  E_FormaPagto_1.Lines.Add('  ' + lc_Mtz_Prazo[3,1]);
  E_FormaPagto_2.Lines.Add('  ' + lc_Mtz_Prazo[3,2]);
  E_FormaPagto_3.Lines.Add('  ' + lc_Mtz_Prazo[3,3]);
  E_FormaPagto_4.Lines.Add('  ' + lc_Mtz_Prazo[3,4]);
  E_FormaPagto_5.Lines.Add('  ' + lc_Mtz_Prazo[3,5]);
  E_FormaPagto_6.Lines.Add('  ' + lc_Mtz_Prazo[3,6]);
  E_FormaPagto_7.Lines.Add('  ' + lc_Mtz_Prazo[3,7]);
  E_FormaPagto_8.Lines.Add('  ' + lc_Mtz_Prazo[3,8]);
  E_FormaPagto_9.Lines.Add('  ' + lc_Mtz_Prazo[3,9]);
  E_FormaPagto_10.Lines.Add('  ' + lc_Mtz_Prazo[3,10]);
  E_FormaPagto_11.Lines.Add('  ' + lc_Mtz_Prazo[3,11]);
  E_FormaPagto_12.Lines.Add('  ' + lc_Mtz_Prazo[3,12]);
  E_FormaPagto_13.Lines.Add('  ' + lc_Mtz_Prazo[3,13]);
  E_FormaPagto_14.Lines.Add('  ' + lc_Mtz_Prazo[3,14]);
  E_FormaPagto_15.Lines.Add('  ' + lc_Mtz_Prazo[3,15]);
  E_FormaPagto_16.Lines.Add('  ' + lc_Mtz_Prazo[3,16]);
end;

Procedure TRL_PedidoVenda_6.Pc_Historico;
Var
  Lc_TExto : String;
  Lc_Cd_Cliente : Integer;
Begin
  Lc_Cd_Cliente := StrToIntdef(Qr_Ordem.FieldByName('EMP_CODIGO').AsString,0);

  //Cheque Pre-Datado
  It_Sld_Cheque := Fc_SaldoChequePreDatado(Lc_Cd_Cliente);

  //Saldo Devedor
  It_Sld_Devedor := Fc_SaldoDevedorCliente(Lc_Cd_Cliente);

  //bOLETOS A Vencer
  It_Sld_Boleto := Fc_SaldoPorFormaPagamento('BOLETO',Lc_Cd_Cliente);
  
end;

Procedure TRL_PedidoVenda_6.PC_VAlidaCampos(Pc_Print : Boolean);
Var
  Lc_Altura:Integer;
Begin
  E_Cd_Produto.Lines.Clear;
  E_Descricao.Lines.Clear;
  E_Marca.Lines.Clear;
  E_Qtde.Lines.Clear;
  E_VL_Unitario.Lines.Clear;
  E_Vl_Unit_Desconto.Lines.Clear;
  E_VL_Total_DEsconto.Lines.Clear;
  //Ajusta Altura dos Campos
  Lc_Altura := 20;
  Bd_DetalheStr.Height := Lc_Altura + 1;
  E_Cd_Produto.Height := Lc_Altura;
  E_Descricao.Height := Lc_Altura;
  E_Marca.Height := Lc_Altura;
  E_Qtde.Height := Lc_Altura;
  E_VL_Unitario.Height := Lc_Altura;
  E_Vl_Unit_Desconto.Height := Lc_Altura;
  E_VL_Total_DEsconto.Height := Lc_Altura;
  Bd_DetalheStr.Repaint;
  Bd_DetalheStr.Refresh;
end;

Procedure TRL_PedidoVenda_6.PC_PreencheCampos;
Var
  Lc_Altura : Integer;
  Lc_Obs : TMemo;
  LcValorProduto : REal;
  LcValor : Real;
Begin
  lc_obs := TMemo.Create(Self);
  lc_obs.Visible := false;
  lc_obs.Parent := Self;
  Lc_Obs.Width := E_Descricao.Width;
  Lc_Obs.Lines.Clear;
  Lc_Obs.Font.Size := 8;
  Lc_Obs.Lines.Add(Qr_Itens.FieldByname('PRO_DESCRICAO').AsString);
  Lc_Altura := Lc_Obs.Lines.Count;
  FreeAndNil(Lc_Obs);
  IF (Lc_Altura > 1) then
    Lc_Altura := Lc_Altura * 15
  else
    Lc_Altura := Lc_Altura * 20;
  //Ajusta Altura dos Campos
  Bd_DetalheStr.Height := Lc_Altura + 1;
  E_Cd_Produto.Height := Lc_Altura;
  E_Descricao.Height := Lc_Altura;
  E_Marca.Height := Lc_Altura;
  E_Qtde.Height := Lc_Altura;
  E_VL_Unitario.Height := Lc_Altura;
  E_Vl_Unit_Desconto.Height := Lc_Altura;
  E_VL_Total_DEsconto.Height := Lc_Altura;

  //Impress�o dos campos
  E_Cd_Produto.Lines.Add(' ' + Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString);
  E_Descricao.Lines.Add(' ' + Qr_Itens.FieldByname('PRO_DESCRICAO').AsString);
  E_Descricao.Refresh;
  E_Descricao.Repaint;
  E_Marca.Lines.Add(' ' + Qr_Itens.FieldByname('MRC_DESCRICAO').AsString);
  E_Qtde.Lines.Add(formatFloat('#,##0.###',Qr_Itens.FieldByName('ITF_QTDE').AsFloat) + ' ');
  E_VL_Unitario.Lines.Add(FloatToStrf(Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency,ffFixed,10,2) + ' ');
  LcValorProduto := Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency * Qr_Itens.FieldByName('ITF_QTDE').AsFloat;
  LcValorProduto := RoundTo( LcValorProduto ,-2);

  It_VL_TL_Produtos := It_VL_TL_Produtos + LcValorProduto;
  //It_VL_TL_Produtos := It_VL_TL_Produtos + (Qr_Itens.FieldByname('ITF_VL_UNIT').AsFloat * Qr_Itens.FieldByname('ITF_Qtde').AsFloat);
  LcValor := Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency - (Qr_Itens.FieldByname('ITF_VL_DESC').AsCurrency/Qr_Itens.FieldByname('ITF_Qtde').AsFloat);
  E_Vl_Unit_Desconto.Lines.Add(FloatToStrf(LcValor ,ffFixed,10,2) + ' ');
  LcValor := Qr_Itens.FieldByName('ITF_QTDE').AsFloat * LcValor;
  LcValor := RoundTo(LcValor,-2);
  E_VL_Total_DEsconto.Lines.Add(FloatToStrf( LcValor ,ffFixed,10,2) + ' ');

end;

procedure TRL_PedidoVenda_6.Pc_Cabecalho;
begin
  with DM do
 Begin
    Pc_AtivaEstabelecimento;
    Fc_BuscaImagemEmpresa(Img_Logo.Picture,'LOGO');
    Lb_Emp_Nome.Caption   := DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('EMP_NOME').AsString;
    Lb_Emp_Doc.Caption    := 'C.N.P.J: '+fc_MascaraCNPJ(DM.Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsString) + ' -  I.E.: '+ DM.Qr_Estabelecimento.FieldByname('EMP_INSC_EST').AsString;
    Lb_Emp_End.Caption    := DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ', ' + DM.Qr_Estabelecimento.FieldByname('END_NUMERO').AsString + ' - ' +DM.Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString + ' - ' +copy(DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString,1,5) + '-' +copy(DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString,6,3) + ' - ' +DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' +DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString;
    Lb_Emp_Fones.Caption  := concat('TELEVENDAS: ',fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString));
    Lb_Emp_www.Caption    := Copy(DM.Qr_Estabelecimento.FieldByname('EMP_SITE').AsString,8,Length(DM.Qr_Estabelecimento.FieldByname('EMP_SITE').AsString)-7);
    Lb_Emp_email.Caption  := DM.Qr_Estabelecimento.FieldByname('EMP_EMAIL').AsString;
    end;
end;


procedure TRL_PedidoVenda_6.Pc_Rodape;
Var
  Lc_I : Integer;
  Lc_Dia, Lc_Mes, Lc_Ano: Integer;
  Lc_Data : String;
begin
  E_VL_SubTotal.Lines.Add(FloatToStrF(It_VL_TL_Produtos,ffFixed,10,2)+'  ');
  E_VL_Desconto.Lines.Add(FloatToStrF(Qr_Ordem.FieldByName('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2)+'  ');
  E_VL_Credito_Loja.Lines.Add(FloatToStrF(Qr_Ordem.FieldByName('PED_VL_CREDITO').AsCurrency,ffFixed,10,2)+'  ');
  E_VL_Outras_Despesas.Lines.Add(FloatToStrF(Qr_Ordem.FieldByName('PED_VL_ODESPESA').AsCurrency,ffFixed,10,2)+'  ');
  E_Vl_Frete.Lines.Add(FloatToStrF(Qr_Ordem.FieldByName('PED_VL_FRETE').AsCurrency,ffFixed,10,2)+'  ');
  E_VL_Total_C_Desconto.Lines.Add(FloatToStrF(Qr_Ordem.FieldByName('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2)+'  ');
  //Historico
  Pc_Historico;
  E_Slt_Anterior.Lines.Add('  SALDO DEVEDOR ANTERIOR : ' + FloatToStrF(It_Sld_Devedor,ffFixed,10,2)+'  ');
  E_Boletos_Vencer.Lines.Add('  BOLETOS � VENCER : ' + FloatToStrF(It_Sld_Boleto,ffFixed,10,2)+'  ');
  E_Cheque_Pre.Lines.Add('  CHEQUES PR�-DATADOS : ' + FloatToStrF(It_Sld_Cheque,ffFixed,10,2)+'  ');
  //Dados da Entrega
  E_PrazoEntrega.Caption := Qr_Ordem.FieldByName('PED_ENTREGA').AsString;
  //DAdos da Garantia
  E_DadosGarantia.Caption := Qr_Ordem.FieldByName('PED_GARANTIA').AsString;
  //Data
  lc_dia := StrToInt(Copy(Qr_Ordem.FieldByName('PED_DATA').AsString,1,2));
  Lc_Mes := StrToInt(Copy(Qr_Ordem.FieldByName('PED_DATA').AsString,4,2));
  Lc_Ano := StrToInt(Copy(Qr_Ordem.FieldByName('PED_DATA').AsString,7,4));
  E_Data.Caption := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ', ' + IntToStr(Lc_Dia) + ' de ' + Fc_DesMes(Lc_Mes,True) + ' de ' + IntToStr(Lc_Ano)+'.';
end;

procedure TRL_PedidoVenda_6.QrptBeforePrint(Sender: TCustomQuickRep;
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
  Pc_IniciaVariaveis;
  Pc_Cabecalho;    
end;

procedure TRL_PedidoVenda_6.Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
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

procedure TRL_PedidoVenda_6.QRBand1BeforePrint(Sender: TQRCustomBand;
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
  Lb_Cli_Cidade.Caption := Qr_Ordem.FieldByName('CDD_DESCRICAO').AsString;
  Lb_Cli_UF.Caption := Qr_Ordem.FieldByName('UFE_SIGLA').AsString;
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
  Lb_Cli_Vendedor.Caption := Qr_Ordem.FieldByName('CLB_NOME').AsString;
  Lb_Cli_Contato.Caption := Qr_Ordem.FieldByName('END_CONTATO').AsString;
end;

procedure TRL_PedidoVenda_6.QRStringsBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Pc_Parcelamento;
  Pc_Rodape;
end;

procedure TRL_PedidoVenda_6.RodapeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //Observção
  E_Obs.Lines.Text := Qr_Ordem.FieldByName('PED_OBS').AsString;
end;

end.
