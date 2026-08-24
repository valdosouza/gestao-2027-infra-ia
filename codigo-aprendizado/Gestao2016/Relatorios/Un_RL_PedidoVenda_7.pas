unit Un_RL_PedidoVenda_7;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, QuickRpt, QRCtrls, ExtCtrls, QRPDFFilt, grimgctrl, StdCtrls, jpeg, DBCtrls, System.Math;

type
  TRL_PedidoVenda_7 = class(TForm)
    Qr_Itens: TSTQuery;
    DataSource1: TDataSource;
    Qr_Ordem: TSTQuery;
    Ds_Ordem: TDataSource;
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
    QRMemo15: TQRMemo;
    QRMemo16: TQRMemo;
    QRLabel23: TQRLabel;
    Lb_Cli_UF: TQRLabel;
    Cabecalho: TQRBand;
    Img_Logo: TQRImage;
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
    E_Operacao: TQRMemo;
    QRMemo62: TQRMemo;
    E_VL_SubTotal: TQRMemo;
    QRMemo69: TQRMemo;
    E_VL_Desconto: TQRMemo;
    QRMemo79: TQRMemo;
    E_VL_Outras_Despesas: TQRMemo;
    QRMemo84: TQRMemo;
    E_Vl_Frete: TQRMemo;
    QRMemo89: TQRMemo;
    E_VL_Total_C_Desconto: TQRMemo;
    QRMemo2: TQRMemo;
    QRMemo3: TQRMemo;
    QRMemo5: TQRMemo;
    QRMemo10: TQRMemo;
    QRMemo12: TQRMemo;
    Lb_Est_Nome: TQRLabel;
    Lb_Est_Endereco: TQRLabel;
    Lb_Est_cep: TQRLabel;
    Lb_Est_Cidade: TQRLabel;
    Lb_Est_Fone: TQRLabel;
    Lb_Est_CNPJ: TQRLabel;
    Lb_Est_Email: TQRLabel;
    Qr_Parcelamento: TSTQuery;
    Qr_ParcelamentoPAR_CODPED: TIntegerField;
    Qr_ParcelamentoPAR_PARCELA: TIntegerField;
    Qr_ParcelamentoPAR_DATA: TDateField;
    Qr_ParcelamentoPAR_VALOR: TBCDField;
    Qr_ParcelamentoFPT_DESCRICAO: TStringField;
    QRLabel1: TQRLabel;
    e_Obs: TQRMemo;
    QRLabel21: TQRLabel;
    Lb_Nr_Pedido: TQRLabel;
    QRLabel14: TQRLabel;
    Lb_Dt_Pedido: TQRLabel;
    Qr_Entrega: TSTQuery;
    QRMemo11: TQRMemo;
    QRLabel11: TQRLabel;
    Label2: TLabel;
    QRLabel2: TQRLabel;
    QRLabel15: TQRLabel;
    Lb_Ent_Endereco: TQRLabel;
    Lb_Ent_bairro: TQRLabel;
    Lb_Ent_cep: TQRLabel;
    Lb_Ent_Cidade: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel31: TQRLabel;
    Lb_Ent_FoneC: TQRLabel;
    QRLabel33: TQRLabel;
    Lb_Ent_Fax: TQRLabel;
    QRLabel37: TQRLabel;
    Lb_Ent_UF: TQRLabel;
    QRMemo4: TQRMemo;
    QRLabel7: TQRLabel;
    Label3: TLabel;
    QRLabel17: TQRLabel;
    Lb_Cob_Forma: TQRLabel;
    Lb_Cob_Parcelas: TQRLabel;
    QRLabel38: TQRLabel;
    Lb_Cob_Prazo: TQRLabel;
    ChildBand1: TQRChildBand;
    QRLabel6: TQRLabel;
    QRMemo1: TQRMemo;
    QRMemo17: TQRMemo;
    E_VL_Credito: TQRMemo;
    QRMemo14: TQRMemo;
    ChB_Lote: TQRChildBand;
    E_Lote: TQRLabel;
    Qr_Lotes: TSTQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
    It_Sld_Devedor : Real;
    It_Sld_Boleto : Real;
    It_Sld_Cheque : Real;

    It_VL_TL_Produtos: Currency;
    It_VL_TL_Desconto: Currency;
    It_VL_TL_Credito: Currency;
    It_VL_TL_Geral: Currency;
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
    function Fc_BuscaLote(CodigoViculo : Integer):String;
  end;

var
  RL_PedidoVenda_7: TRL_PedidoVenda_7;

implementation

uses     UN_Sistema, Un_DM, UN_Pedido_Vda, Un_Funcoes, Un_Regra_Negocio, RN_Financeiro, UN_Principal, env;
{$R *.dfm}
procedure TRL_PedidoVenda_7.Pc_IniciaVariaveis;
Begin
  ///Variaveis internas
  It_VL_TL_Produtos := 0;
  It_VL_TL_Desconto := 0;
  It_VL_TL_Credito := 0;
  It_VL_TL_Geral := 0;

  //Totais
  E_VL_SubTotal.Lines.Clear;
  E_VL_Desconto.Lines.Clear;
  E_VL_Outras_Despesas.Lines.Clear;
  E_Vl_Frete.Lines.Clear;
  E_VL_Credito.Lines.Clear;
  E_VL_Total_C_Desconto.Lines.Clear;

end;

procedure TRL_PedidoVenda_7.Pc_Parcelamento;
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
      //Resolvemos o problema da Divisão e dizima periodica
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
      Lc_Nr_Parcelas := Qr_Parcelamento.RecordCount;
      while not Qr_Parcelamento.Eof do
        begin
        lc_Mtz_Prazo[2,Lc_I] := FloatToStrF(Qr_ParcelamentoPAR_VALOR.AsCurrency,ffFixed,10,2);
        lc_Mtz_Prazo[1,Lc_I] := Qr_ParcelamentoPAR_DATA.AsString;
        lc_Mtz_Prazo[3,Lc_I] := Qr_ParcelamentoFPT_DESCRICAO.AsString;
        inc(Lc_I);
        Qr_Parcelamento.Next;
        end;
    end;
  Lc_Prazo :='';
  For Lc_I := 1 to (Lc_Nr_Parcelas) do
    Begin
    if Lc_I = 1 then
      Lc_Prazo := lc_Mtz_Prazo[1,Lc_I] + ' - ' +  lc_Mtz_Prazo[2,Lc_I]
    else
      Lc_Prazo := Lc_Prazo + ' | ' + lc_Mtz_Prazo[1,Lc_I] + ' - ' +  lc_Mtz_Prazo[2,Lc_I]
    end;
   Lb_Cob_Parcelas.Caption := Lc_Prazo;
   case Lc_Nr_Parcelas of
    6:Lb_Cob_Parcelas.Font.Size := 9;
    7:Lb_Cob_Parcelas.Font.Size := 8;
    8:Lb_Cob_Parcelas.Font.Size := 7;
    end;
{
  //Vencimento


  Lc_Prazo := lc_Mtz_Prazo[1,1];
  if Trim(Lc_Prazo)<>'' then
    Lb_Cob_Parcelas.Caption := lc_Mtz_Prazo[1,1] + ' - ' +  lc_Mtz_Prazo[2,1];
  Lc_Prazo := lc_Mtz_Prazo[1,1] + ' - ' +  lc_Mtz_Prazo[2,1];

  Lc_Prazo := lc_Mtz_Prazo[1,2];
  if Trim(Lc_Prazo)<>'' then
    Lb_Cob_Parcelas.Caption := Lb_Cob_Parcelas.Caption + ' | ' + lc_Mtz_Prazo[1,2] + ' - ' +  lc_Mtz_Prazo[2,2];

  Lc_Prazo := lc_Mtz_Prazo[1,3];
  if Trim(Lc_Prazo)<>'' then
    Lb_Cob_Parcelas.Caption := Lb_Cob_Parcelas.Caption + ' | ' + lc_Mtz_Prazo[1,3] + ' - ' +  lc_Mtz_Prazo[2,3];
}
end;

Procedure TRL_PedidoVenda_7.Pc_Historico;
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

Procedure TRL_PedidoVenda_7.PC_VAlidaCampos(Pc_Print : Boolean);
Var
  Lc_Altura:Integer;
Begin
  E_Cd_Produto.Lines.Clear;
  E_Descricao.Lines.Clear;
  E_Operacao.Lines.Clear;
  E_Qtde.Lines.Clear;
  E_VL_Unitario.Lines.Clear;
  E_Vl_Unit_Desconto.Lines.Clear;
  E_VL_Total_DEsconto.Lines.Clear;
  E_Lote.Lines.Clear;
  //Ajusta Altura dos Campos
  Lc_Altura := 20;
  Bd_DetalheStr.Height := Lc_Altura + 1;
  E_Cd_Produto.Height := Lc_Altura;
  E_Descricao.Height := Lc_Altura;
  E_Operacao.Height := Lc_Altura;
  E_Qtde.Height := Lc_Altura;
  E_VL_Unitario.Height := Lc_Altura;
  E_Vl_Unit_Desconto.Height := Lc_Altura;
  E_VL_Total_DEsconto.Height := Lc_Altura;
  Bd_DetalheStr.Repaint;
  Bd_DetalheStr.Refresh;
  ChB_Lote.Height := 0;
  E_Lote.Caption := '';

end;

Procedure TRL_PedidoVenda_7.PC_PreencheCampos;
Var
  Lc_Altura : Integer;
  Lc_Obs : TMemo;
  LcLote : String;
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
  E_Operacao.Height := Lc_Altura;
  E_Qtde.Height := Lc_Altura;
  E_VL_Unitario.Height := Lc_Altura;
  E_Vl_Unit_Desconto.Height := Lc_Altura;
  E_VL_Total_DEsconto.Height := Lc_Altura;

  //Impressão dos campos
  E_Cd_Produto.Lines.Add(' ' + Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString);
  E_Descricao.Lines.Add(' ' + Qr_Itens.FieldByname('PRO_DESCRICAO').AsString);
  E_Descricao.Refresh;
  E_Descricao.Repaint;
  if (Qr_Itens.FieldByname('ITF_OPER').AsString = 'V') then
    E_Operacao.Lines.Add(' ' + 'Venda')
  else
    E_Operacao.Lines.Add(' ' + 'Troca');
  E_Qtde.Lines.Add(formatFloat('#,##0.###',Qr_Itens.FieldByName('ITF_QTDE').AsFloat) + ' ');

  IF Qr_Itens.FieldByname('ITF_OPER').AsString = 'V' then
  Begin
    E_VL_Unitario.Lines.Add(FloatToStrf(Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency,ffFixed,10,2) + ' ');
    LcValor := Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency - (Qr_Itens.FieldByname('ITF_VL_DESC').AsCurrency/ Qr_Itens.FieldByname('ITF_Qtde').AsFloat) ;
    LcValor := RoundTo( LcValor , -2);
    E_Vl_Unit_Desconto.Lines.Add(FloatToStrf( LcValor ,ffFixed,10,2) + ' ');

    E_VL_Total_DEsconto.Lines.Add(FloatToStrf(Qr_Itens.FieldByname('ITF_VL_LINHA').AsCurrency ,ffFixed,10,2) + ' ');

    LcValor := (Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.FieldByname('ITF_Qtde').AsFloat) ;
    LcValor := RoundTo( LcValor , -2);

    It_VL_TL_Produtos := It_VL_TL_Produtos + LcValor;
    It_VL_TL_Desconto := It_VL_TL_Desconto + Qr_Itens.FieldByname('ITF_VL_DESC').AsCurrency;

    It_VL_TL_Geral :=It_VL_TL_Geral +Qr_Itens.FieldByname('ITF_VL_LINHA').AsCurrency;
  end
  else
  Begin
    E_Vl_Unit_Desconto.Lines.Add('0,00 ');
    E_VL_Total_DEsconto.Lines.Add('0,00 ');
    E_VL_Unitario.Lines.Add('0,00 ');
  end;

  LcLote := Fc_BuscaLote(Qr_Itens.FieldByName('ITF_CODIGO').AsInteger);
  if ( Length(LcLote) >0 ) then
  Begin
    ChB_Lote.Height := 17;
    E_Lote.Caption := 'Lotes utilizados : ' +  LcLote;
  End;
end;

procedure TRL_PedidoVenda_7.Pc_Cabecalho;
begin
  with DM.Qr_Estabelecimento do
    Begin
    Active := False;
    ParamByName('EMP_CODIGO').AsInteger := Gb_CodMha;
    Active := True;
    FetchAll;
    First;
    Fc_BuscaImagemEmpresa(Img_Logo.Picture,'LOGO');
    Lb_Est_Nome.Caption := FieldByName('EMP_FANTASIA').AsString;
    Lb_Est_Endereco.Caption := FieldByName('END_ENDER').AsString + ', '+ FieldByName('END_NUMERO').AsString;
    Lb_Est_cep.Caption := Fc_MascaraCep(FieldByName('END_CEP').AsString);
    Lb_Est_Cidade.Caption := FieldByName('CDD_DESCRICAO').AsString + ' - ' + FieldByName('UFE_SIGLA').AsString;
    Lb_Est_Fone.Caption := fc_MascaraFone(FieldByName('END_FONE').AsString);
    IF TRIM(FieldByName('END_FAX').AsString) <> '' then
      Lb_Est_Fone.Caption := Lb_Est_Fone.Caption + ' / ' + fc_MascaraFone(FieldByName('END_FAX').AsString);
    IF TRIM(FieldByName('END_COMERCIAL').AsString) <> '' then
      Lb_Est_Fone.Caption := Lb_Est_Fone.Caption + ' / ' + fc_MascaraFone(FieldByName('END_COMERCIAL').AsString);

    Lb_Est_CNPJ.Caption := fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString);
    Lb_Est_Email.Caption := FieldByName('EMP_EMAIL').AsString;
    end;
end;


procedure TRL_PedidoVenda_7.Pc_Rodape;
Var
  Lc_I : Integer;
  Lc_Texto: TMemoryStream;
  Lc_Dia, Lc_Mes, Lc_Ano: Integer;
  Lc_Data : String;
  Lc_Vl_Credito : Real;
begin
  E_VL_SubTotal.Lines.Add(FloatToStrF(It_VL_TL_Produtos,ffFixed,10,2)+'  ');
  E_VL_Desconto.Lines.Add(FloatToStrF(It_VL_TL_Desconto,ffFixed,10,2)+'  ');
  E_VL_Outras_Despesas.Lines.Add(FloatToStrF(Qr_Ordem.FieldByName('PED_VL_ODESPESA').AsCurrency,ffFixed,10,2)+'  ');
  It_VL_TL_Geral := It_VL_TL_Geral + Qr_Ordem.FieldByName('PED_VL_ODESPESA').AsCurrency;
  E_Vl_Frete.Lines.Add(FloatToStrF(Qr_Ordem.FieldByName('PED_VL_FRETE').AsCurrency,ffFixed,10,2)+'  ');
  It_VL_TL_Geral := It_VL_TL_Geral + Qr_Ordem.FieldByName('PED_VL_FRETE').AsCurrency;
  Lc_Vl_Credito := Fc_SaldoCredorCliente(Qr_Ordem.FieldByName('EMP_CODIGO').AsInteger);
  E_VL_Credito.Lines.Add(FloatToStrF(Lc_Vl_Credito ,ffFixed,10,2)+'  ');
  E_VL_Total_C_Desconto.Lines.Add(FloatToStrF(It_VL_TL_Geral - Lc_Vl_Credito ,ffFixed,10,2)+'  ');



  //Observação
  Lc_Texto := TMemoryStream.Create;
  Lc_Texto.LoadFromStream(Qr_Ordem.CreateBlobStream(Qr_Ordem.FieldByName('PED_OBS'), bmRead));
  E_Obs.Lines.LoadFromStream(lC_Texto);
  E_Obs.AutoStretch := True;
  Lc_Texto.Free;
  if (E_Obs.Height > 96) then
    Rodape.Height := E_Obs.Height;

end;

procedure TRL_PedidoVenda_7.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action := Cafree;
end;


procedure TRL_PedidoVenda_7.QrptBeforePrint(Sender: TCustomQuickRep;
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
  if (Fc_Tb_Geral('L','GRL_G_MOSTRAESTABELECIMENTO','N') = 'S') then
    Begin
    Cabecalho.Height := 99;
    Pc_Cabecalho;
    end
  else
    Begin
    Cabecalho.Height := 0;
    end;

end;

procedure TRL_PedidoVenda_7.Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
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
  Begin
    pc_ValidaCampos(False);
  End;
end;

procedure TRL_PedidoVenda_7.RodapeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_Rodape;
end;

procedure TRL_PedidoVenda_7.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
VAR
 Lc_CPF_CNPJ:String;
begin
  Lb_Nr_Pedido.Caption := Qr_Ordem.FieldByName('PED_NUMERO').AsString;
  Lb_Dt_Pedido.Caption := Qr_Ordem.FieldByName('PED_DATA').AsString;


  Lb_Cli_Fantasia.Caption := Qr_Ordem.FieldByName('EMP_FANTASIA').AsString + ' | ' + Qr_Ordem.FieldByName('EMP_NOME').AsString;
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

  //Dados da Entrega
  Qr_Entrega.Active := False;
  Qr_Entrega.ParamByName('END_CODIGO').AsInteger := Qr_Ordem.FieldByName('PED_CODEND').AsInteger;
  Qr_Entrega.Active := True;
  Lb_Ent_Endereco.Caption := Qr_Entrega.FieldByName('END_ENDER').AsString +', '+Qr_Entrega.FieldByName('END_NUMERO').AsString;
  Lb_Ent_cep.Caption := fc_MascaraCep(Qr_Entrega.FieldByName('END_CEP').AsString);
  Lb_Ent_FoneC.Caption := fc_MascaraFone(Qr_Entrega.FieldByName('END_FONE').AsString);
  Lb_Ent_bairro.Caption := Qr_Entrega.FieldByName('END_BAIRRO').AsString;
  Lb_Ent_Cidade.Caption := Qr_Entrega.FieldByName('CDD_DESCRICAO').AsString;
  Lb_Ent_UF.Caption := Qr_Entrega.FieldByName('UFE_SIGLA').AsString;
  Lb_Ent_Fax.Caption :=fc_MascaraFone(Qr_Entrega.FieldByName('END_FAX').AsString);

  //Dados da Cobranca
  Lb_Cob_Forma.Caption := Qr_Ordem.FieldByName('FPT_DESCRICAO').AsString;
  Lb_Cob_Prazo.Caption := Qr_Ordem.FieldByName('PED_PRAZO').AsString;
  Pc_Parcelamento;
end;


function TRL_PedidoVenda_7.Fc_BuscaLote(CodigoViculo : Integer):String;
Var
  SqlTxt : String;
  Lc_I : Integer;
  LcCodigoVinculo : String;
Begin
  Screen.Cursor := crHourGlass;
  with Qr_Lotes do
  Begin
    Active := False;
    SQL.Clear;
    sqltxt := concat(
                'SELECT DISTINCT CLT_NUMERO ',
                'FROM TB_CTRL_LOTE L ',
                '  INNER JOIN TB_MOVIMENTO_LOTE M ',
                '  ON (M.mlt_codclt = L.clt_codigo) ',
                ' WHERE (M.MLT_CODVCL =:ITF_CODIGO ) '
              );
    SQL.Add(SqlTxt);
    ParamByName('ITF_CODIGO').AsInteger := CodigoViculo;
    Active := TRUE;
    first;
    Result := '';
    while not eof do
    Begin
      if bof then
        Result := Result + FieldByName('CLT_NUMERO').AsString
      else
        Result := Result + ' / ' + FieldByName('CLT_NUMERO').AsString;
      Next;
    End;
  End;
  Screen.Cursor := crDefault;
end;

end.
