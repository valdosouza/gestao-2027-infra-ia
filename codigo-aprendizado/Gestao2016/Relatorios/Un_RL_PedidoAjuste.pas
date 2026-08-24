unit Un_RL_PedidoAjuste;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, QuickRpt, QRCtrls, ExtCtrls, System.Math;

type
  TRL_PedidoAjuste = class(TForm)
    Qrpt: TQuickRep;
    Cabecalho: TQRGroup;
    QRShape6: TQRShape;
    QRShape3: TQRShape;
    QRShape8: TQRShape;
    QRShape2: TQRShape;
    QRShape1: TQRShape;
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
    Lb_Cli_Codigo: TQRLabel;
    Lb_Cli_cep: TQRLabel;
    Lb_Cli_Cidade: TQRLabel;
    Lb_Cli_IncEst: TQRLabel;
    QRLabel7: TQRLabel;
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
    QRLabel33: TQRLabel;
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
    QRLabel1: TQRLabel;
    Lb_Frete: TQRLabel;
    Bd_DetalheStr: TQRStringsBand;
    QRShape9: TQRShape;
    QRShape5: TQRShape;
    QRShape7: TQRShape;
    QRShape4: TQRShape;
    QRShape10: TQRShape;
    Lb_Codigo: TQRLabel;
    Lb_DescricaoProduto: TQRLabel;
    Lb_Qtde: TQRLabel;
    Lb_VlUnit: TQRLabel;
    Lb_SubTotal: TQRLabel;
    Qr_Ordem: TSTQuery;
    Qr_Itens: TSTQuery;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    Qr_ItensITF_CODIGO: TIntegerField;
    Qr_ItensITF_CODPED: TIntegerField;
    Qr_ItensITF_CODPRO: TIntegerField;
    Qr_ItensPRO_CODIGOFAB: TStringField;
    Qr_ItensITF_QTDE: TBCDField;
    Qr_ItensITF_VL_UNIT: TFMTBCDField;
    Qr_ItensITF_VL_LINHA: TFMTBCDField;
    Qr_ItensPRO_DESCRICAO: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
    Procedure PC_PreencheCampos;
    Procedure PC_VAlidaCampos(Pc_Print : Boolean);
    procedure Pc_Cabecalho;
    procedure Pc_Rodape;
  end;

var
  RL_PedidoAjuste: TRL_PedidoAjuste;

implementation

uses     UN_Sistema;
Procedure TRL_PedidoAjuste.PC_VAlidaCampos(Pc_Print : Boolean);
Begin
  if Pc_Print then
    BEgin
    Lb_Codigo.Font.Color := clBlack;
    Lb_DescricaoProduto.Font.Color := clBlack;
    Lb_Qtde.Font.Color := clBlack;
    Lb_VlUnit.Font.Color := clBlack;
    Lb_SubTotal.Font.Color := clBlack;
    end
  else
    BEgin
    Lb_Codigo.Font.Color := clWhite;
    Lb_DescricaoProduto.Font.Color := clWhite;
    Lb_Qtde.Font.Color := clWhite;
    Lb_VlUnit.Font.Color := clWhite;
    Lb_SubTotal.Font.Color := clWhite;
    end;

end;
Procedure TRL_PedidoAjuste.PC_PreencheCampos;
Var
  LcValor : Real;
Begin
  Lb_Codigo.Caption := Qr_Itens.FieldByName('PRO_CODIGOFAB').AsString;
  Lb_DescricaoProduto.Caption := Qr_Itens.FieldByName('PRO_DESCRICAO').AsString;
  Lb_Qtde.Caption             := formatFloat('#,##0.###',Qr_Itens.FieldByName('ITF_QTDE').AsFloat);
  Lb_VlUnit.Caption           := formatFloat('#,##0.00####',Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency);
  LcValor := Qr_Itens.FieldByName('ITF_QTDE').AsFloat * Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency;
  LcValor := RoundTo(LcValor,-2);
  Lb_SubTotal.Caption := FloatToStrf(LcValor,ffFixed,10,2);
end;
procedure TRL_PedidoAjuste.Pc_Cabecalho;
Var
  Lc_CPF_CNPJ:String;
  Lc_Zr_CNPF: String;
  Lc_Hora : TTime;
begin
  Lc_Hora := Qr_Ordem.FieldByName('PED_DT_ALTERA').AsDateTime;
  Lb_Cli_Pedido.Caption := Qr_Ordem.FieldByName('PED_NUMERO').AsString;
  Lb_Cli_Data.Caption := Qr_Ordem.FieldByName('PED_DATA').AsString + ' ' + Copy(TimeToStr(time),1,5) + ' hs';
  Lb_Cli_Nome.Caption := Qr_Ordem.FieldByName('EMP_NOME').AsString;
  Lb_Cli_Codigo.Caption := Qr_Ordem.FieldByName('EMP_CODIGO').AsString;
  Lb_Cli_Endereco.Caption := Qr_Ordem.FieldByName('END_ENDER').AsString +', '+Qr_Ordem.FieldByName('END_NUMERO').AsString;
  Lb_Cli_cep.Caption := Fc_MascaraCep(Qr_Ordem.FieldByName('END_CEP').AsString);
  Lb_Cli_FoneC.Caption := fc_MascaraFone(Qr_Ordem.FieldByName('END_FONE').AsString);
  Lb_Cli_bairro.Caption := Qr_Ordem.FieldByName('END_BAIRRO').AsString;
  Lb_Cli_Cidade.Caption := Qr_Ordem.FieldByName('CDD_DESCRICAO').AsString;
  Lb_Cli_Fax.Caption := fc_MascaraFone(Qr_Ordem.FieldByName('END_FAX').AsString);
  if Length(Qr_Ordem.FieldByName('EMP_CNPJ').AsString)=11 then
    Begin
    Lb_CPFCNPJ.Caption := 'C.P.F:';
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
end;


procedure TRL_PedidoAjuste.Pc_Rodape;
begin
  Lb_NItens.Caption := FloattoStrf(It_NItens,ffFixed,10,0);
  Lb_QItens.Caption := FloattoStrf(Qr_Ordem.FieldByName('PED_QT_PRODUTO').AsFloat,ffFixed,10,2);
  Lb_Frete.Caption := FloattoStrf(Qr_Ordem.FieldByName('PED_VL_FRETE').AsCurrency,ffFixed,10,2);
  Lb_Desconto.Caption := FloattoStrf(Qr_Ordem.FieldByName('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2);
  Lb_Total.Caption := FloattoStrf(Qr_Ordem.FieldByName('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2);
end;

procedure TRL_PedidoAjuste.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action := Cafree;
  RL_PedidoAjuste := nil;
end;

procedure TRL_PedidoAjuste.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_I : Integer;
  Lc_Nr_Itens : Integer;
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  It_NItens := 0;
  It_Sequencia := 0;
  Lc_Nr_Itens := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_ITENS_FOLHA',''),10);
  //Pedido
  Qr_Ordem.Active := False;
  Qr_Ordem.ParamByName('PED_CODIGO').AsInteger := It_Codigo;
  Qr_Ordem.Active := True;
  Qr_Ordem.First;

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

procedure TRL_PedidoAjuste.Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
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

procedure TRL_PedidoAjuste.RodapeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_Rodape;
end;

procedure TRL_PedidoAjuste.Qr_ItensAfterOpen(DataSet: TDataSet);
begin
  (Qr_Itens.FieldByName('ITF_QTDE') as TNumericField).DisplayFormat := '0.######';
  (Qr_Itens.FieldByName('ITF_VL_UNIT') as TNumericField).DisplayFormat := '0.00##';
end;

end.
