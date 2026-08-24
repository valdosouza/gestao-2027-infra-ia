unit Un_RL_PedidoCompra_3;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, DB, StdCtrls, STQuery, jpeg, grimgctrl, System.Math;

type
  TRL_PedidoCompra_3 = class(TForm)
    Qrpt: TQuickRep;
    Cabecalho: TQRGroup;
    QRPDFShape5: TQRMemo;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    Lb_for_Endereco: TQRLabel;
    Lb_For_Nome: TQRLabel;
    Lb_for_bairro: TQRLabel;
    Lb_for_cnpj: TQRLabel;
    Lb_for_cep: TQRLabel;
    Lb_for_ie: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    Lb_for_Fone: TQRLabel;
    QRLabel13: TQRLabel;
    Lb_for_fax: TQRLabel;
    QRLabel34: TQRLabel;
    Lb_for_celular: TQRLabel;
    QRLabel36: TQRLabel;
    Lb_for_email: TQRLabel;
    QRLabel33: TQRLabel;
    Lb_For_Pedido: TQRLabel;
    Lb_For_Data: TQRLabel;
    QRLabel38: TQRLabel;
    QRLabel9: TQRLabel;
    Lb_For_Cidade: TQRLabel;
    QRLabel15: TQRLabel;
    Lb_For_UF: TQRLabel;
    QRLabel7: TQRLabel;
    Lb_For_Fantasia: TQRLabel;
    Rodape: TQRBand;
    QRPDFShape10: TQRMemo;
    QRPDFShape8: TQRMemo;
    QRPDFShape6: TQRMemo;
    QRPDFShape4: TQRMemo;
    QRPDFShape3: TQRMemo;
    QRPDFShape2: TQRMemo;
    QRPDFShape1: TQRMemo;
    Lb_Total: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel14: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel35: TQRLabel;
    Lb_Trp_endereco: TQRLabel;
    Lb_Trp_Nome: TQRLabel;
    Lb_Trp_bairro: TQRLabel;
    Lb_Trp_cnpj: TQRLabel;
    Lb_Trp_cep: TQRLabel;
    Lb_Trp_cidade: TQRLabel;
    Lb_Trp_ie: TQRLabel;
    QRLabel47: TQRLabel;
    QRLabel48: TQRLabel;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    Lb_Trp_fone: TQRLabel;
    QRLabel52: TQRLabel;
    Lb_Trp_ac: TQRLabel;
    QRLabel54: TQRLabel;
    Lb_Trp_Celular: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel46: TQRLabel;
    QRLabel56: TQRLabel;
    QRLabel57: TQRLabel;
    Lb_Fat_endereco: TQRLabel;
    Lb_Fat_nome: TQRLabel;
    Lb_Fat_bairro: TQRLabel;
    Lb_Fat_cnpj: TQRLabel;
    Lb_Fat_cep: TQRLabel;
    Lb_Fat_cidade: TQRLabel;
    Lb_Fat_ie: TQRLabel;
    QRLabel65: TQRLabel;
    QRLabel66: TQRLabel;
    QRLabel67: TQRLabel;
    QRLabel68: TQRLabel;
    Lb_Fat_fone: TQRLabel;
    QRLabel70: TQRLabel;
    Lb_Fat_ac: TQRLabel;
    QRLabel72: TQRLabel;
    Lb_Fat_celular: TQRLabel;
    QRLabel74: TQRLabel;
    QRLabel75: TQRLabel;
    QRLabel76: TQRLabel;
    QRLabel77: TQRLabel;
    Lb_Ent_endereco: TQRLabel;
    Lb_Ent_nome: TQRLabel;
    Lb_Ent_bairro: TQRLabel;
    Lb_Ent_cnpj: TQRLabel;
    Lb_Ent_cep: TQRLabel;
    Lb_Ent_cidade: TQRLabel;
    Lb_Ent_ie: TQRLabel;
    QRLabel85: TQRLabel;
    QRLabel86: TQRLabel;
    QRLabel87: TQRLabel;
    QRLabel88: TQRLabel;
    Lb_Ent_fone: TQRLabel;
    QRLabel90: TQRLabel;
    Lb_Ent_ac: TQRLabel;
    QRLabel92: TQRLabel;
    Lb_Ent_celular: TQRLabel;
    QRLabel94: TQRLabel;
    QRLabel95: TQRLabel;
    QRLabel96: TQRLabel;
    QRLabel97: TQRLabel;
    Lb_Cob_endereco: TQRLabel;
    Lb_Cob_Nome: TQRLabel;
    Lb_Cob_bairro: TQRLabel;
    Lb_Cob_cnpj: TQRLabel;
    Lb_Cob_cep: TQRLabel;
    Lb_Cob_cidade: TQRLabel;
    Lb_Cob_ie: TQRLabel;
    QRLabel105: TQRLabel;
    QRLabel106: TQRLabel;
    QRLabel107: TQRLabel;
    QRLabel108: TQRLabel;
    Lb_Cob_fone: TQRLabel;
    QRLabel110: TQRLabel;
    Lb_Cob_ac: TQRLabel;
    QRLabel112: TQRLabel;
    Lb_Cob_celular: TQRLabel;
    QRPDFShape9: TQRMemo;
    QRLabel17: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    QRLabel45: TQRLabel;
    Lb_Assina_2: TQRLabel;
    Lb_Assina_1: TQRLabel;
    QRMemo6: TQRMemo;
    QRMemo7: TQRMemo;
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
    QRLabel27: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel1: TQRLabel;
    Lb_Venc_11: TQRLabel;
    Lb_Valor_11: TQRLabel;
    Lb_Venc_21: TQRLabel;
    Lb_Valor_21: TQRLabel;
    Lb_Venc_12: TQRLabel;
    Lb_Valor_12: TQRLabel;
    Lb_Venc_22: TQRLabel;
    Lb_Valor_22: TQRLabel;
    Lb_Venc_13: TQRLabel;
    Lb_Valor_13: TQRLabel;
    Lb_Venc_23: TQRLabel;
    Lb_Valor_23: TQRLabel;
    Lb_Valor_24: TQRLabel;
    Lb_Venc_24: TQRLabel;
    Lb_Valor_14: TQRLabel;
    Lb_Venc_14: TQRLabel;
    Lb_Venc_15: TQRLabel;
    Lb_Valor_15: TQRLabel;
    Lb_Venc_25: TQRLabel;
    Lb_Valor_25: TQRLabel;
    QRMemo8: TQRMemo;
    Lb_PrzEntrega: TQRLabel;
    Bd_DetalheStr: TQRStringsBand;
    QRBand1: TQRBand;
    QRPDFShape7: TQRMemo;
    Img_Logo: TQRImage;
    Lb_Emp_Nome: TQRLabel;
    Lb_Emp_Doc: TQRLabel;
    Lb_Emp_End: TQRLabel;
    Lb_Emp_Fones: TQRLabel;
    Lb_Emp_www: TQRLabel;
    Lb_Emp_email: TQRLabel;
    Qr_Fornecedor: TSTQuery;
    Qr_Entrega: TSTQuery;
    Qr_Ordem: TSTQuery;
    Qr_Itens: TSTQuery;
    Qr_Parcelamento: TSTQuery;
    qr_transportadora: TSTQuery;
    E_Descricao: TQRMemo;
    E_CodigoInterno: TQRMemo;
    E_Qtde: TQRMemo;
    E_VL_Unitario: TQRMemo;
    E_VL_Subtotal: TQRMemo;
    QRMemo9: TQRMemo;
    QRMemo10: TQRMemo;
    QRMemo11: TQRMemo;
    QRMemo13: TQRMemo;
    QRMemo15: TQRMemo;
    QRMemo1: TQRMemo;
    QRMemo2: TQRMemo;
    E_PrecoCusto: TQRMemo;
    E_Tx_Dif_Custo: TQRMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RodapeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    It_Vl_Pedido: Currency;
    It_Vl_Imposto: Currency;
  public
    { Public declarations }
    It_cd_Transporte: Integer;
    It_cd_Entrega: Integer;
    It_cd_Fatura: Integer;
    It_cd_Cobranca: Integer;
    It_cd_Pedido: Integer;
    It_Sequencia : Integer;
    It_NItens : Real;
    Procedure PC_PreencheCampos;
    Procedure PC_VAlidaCampos(Pc_Print : Boolean);
    procedure Pc_Cabecalho;
    procedure Pc_Rodape;
    procedure Pc_PreenheFOR;
    procedure Pc_PreenheTRP;
    procedure Pc_PreenheENT;
    procedure Pc_PreenheFAT;
    procedure Pc_PreenheCOB;
    procedure Pc_Parcelamento;
  end;

var
  RL_PedidoCompra_3: TRL_PedidoCompra_3;

implementation

uses     Un_DM, UN_MSG, Un_Sistema, UN_Pedido_Cpa, Un_Regra_Negocio, UN_Principal, env;
{$R *.dfm}

procedure TRL_PedidoCompra_3.Pc_Parcelamento;
Var
  Lc_Nr_Parcelas : Integer;
  lc_Mtz_Prazo : Array[1..2, 1..10] of string;
  Lc_St_Parcela : String;
  Lc_Vl_Parcela : Real;
  Lc_Tamanho:Integer;
  Lc_I, Lc_J : Integer;
  Lc_Prazo : String;
Begin
  Qr_Parcelamento.Active := False;
  Qr_Parcelamento.ParamByName('PAR_CODPED').AsInteger := it_cd_Pedido;
  Qr_Parcelamento.Active := True;
  Qr_Parcelamento.FetchAll;

  if Qr_Parcelamento.RecordCount = 0 then
    Begin
    Lc_Nr_Parcelas := StrToIntDef(Copy(Qr_Ordem.FieldByName('PED_PRAZO').AsString,1,3),0);
      For Lc_I := 1 to 10 do
        For Lc_J := 1 to 2 do
          lc_Mtz_Prazo[Lc_J, Lc_I] := '';

    if Lc_Nr_Parcelas = 0 then
      Begin
      lc_Mtz_Prazo[1,1] := Qr_Ordem.FieldByName('PED_DATA').AsString;
      lc_Mtz_Prazo[2,1] := FloatToStrF(Qr_Ordem.FieldByName('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2);
      end
    else
      Begin
      //Resolvemos o problema da Divisão e dizima periodica
      Lc_St_Parcela := FloatToStrF((Qr_Ordem.FieldByName('PED_VL_PEDIDO').AsCurrency / Lc_Nr_Parcelas),ffFixed,10,2);
      Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);

      if Lc_Nr_Parcelas > 10 then Lc_Nr_Parcelas := 10;
      
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
        if (Lc_I <=10) then
        Begin
          lc_Mtz_Prazo[2,Lc_I] := FloatToStrF(Qr_Parcelamento.FieldByName('PAR_VALOR').AsCurrency,ffFixed,10,2);
          lc_Mtz_Prazo[1,Lc_I] := Qr_Parcelamento.FieldByName('PAR_DATA').AsString;
          inc(Lc_I);
        End;
        Qr_Parcelamento.Next;
      end;
    end;


  Lb_Venc_11.Caption := lc_Mtz_Prazo[1,1];
  Lb_Venc_12.Caption := lc_Mtz_Prazo[1,2];
  Lb_Venc_13.Caption := lc_Mtz_Prazo[1,3];
  Lb_Venc_14.Caption := lc_Mtz_Prazo[1,4];
  Lb_Venc_15.Caption := lc_Mtz_Prazo[1,5];
  Lb_Venc_21.Caption := lc_Mtz_Prazo[1,6];
  Lb_Venc_22.Caption := lc_Mtz_Prazo[1,7];
  Lb_Venc_23.Caption := lc_Mtz_Prazo[1,8];
  Lb_Venc_24.Caption := lc_Mtz_Prazo[1,9];
  Lb_Venc_25.Caption := lc_Mtz_Prazo[1,10];

  Lb_Valor_11.Caption := lc_Mtz_Prazo[2,1];
  Lb_Valor_12.Caption := lc_Mtz_Prazo[2,2];
  Lb_Valor_13.Caption := lc_Mtz_Prazo[2,3];
  Lb_Valor_14.Caption := lc_Mtz_Prazo[2,4];
  Lb_Valor_15.Caption := lc_Mtz_Prazo[2,5];
  Lb_Valor_21.Caption := lc_Mtz_Prazo[2,6];
  Lb_Valor_22.Caption := lc_Mtz_Prazo[2,7];
  Lb_Valor_23.Caption := lc_Mtz_Prazo[2,8];
  Lb_Valor_24.Caption := lc_Mtz_Prazo[2,9];
  Lb_Valor_25.Caption := lc_Mtz_Prazo[2,10];


end;


procedure TRL_PedidoCompra_3.Pc_PreenheFOR;
BEgin
  with Qr_Fornecedor do
  Begin
    Active := False;
    ParamByName('EMP_CODIGO').AsInteger := Qr_Ordem.FieldByName('PED_CODEMP').AsInteger;
    Active := True;
    FetchAll;
    First;
    if RecordCount > 0 then
    Begin
      Lb_For_Nome.Caption     := FieldByName('EMP_NOME').AsString;
      Lb_For_Fantasia.Caption := FieldByName('EMP_FANTASIA').AsString;
      Lb_For_endereco.Caption := FieldByName('END_ENDER').AsString;
      Lb_For_cep.Caption      := Fc_MascaraCep(FieldByName('END_CEP').AsString);
      Lb_For_fone.Caption     := fc_MascaraFone(FieldByName('END_FONE').AsString);
      Lb_For_bairro.Caption   := FieldByName('END_BAIRRO').AsString;
      Lb_For_cidade.Caption   := FieldByName('CDD_DESCRICAO').AsString;
      Lb_For_UF.Caption       := FieldByName('UFE_SIGLA').AsString;
      Lb_For_Celular.Caption  := fc_MascaraFone(FieldByName('END_CELULAR').AsString);
      Lb_for_fax.Caption      := fc_MascaraFone(FieldByName('END_FAX').AsString);
      if Length(FieldByName('EMP_CNPJ').AsString)=11 then
        Lb_For_cnpj.Caption   := fc_MascaraCPF(FieldByName('EMP_CNPJ').AsString)
      else
        Lb_For_cnpj.Caption   := fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString);
      Lb_For_ie.Caption       := FieldByName('EMP_INSC_EST').AsString;
      Lb_for_email.Caption    := FieldByName('EMP_EMAIL').AsString;
    end
    else
    Begin
      Lb_For_Nome.Caption := '';
      Lb_For_endereco.Caption := '';
      Lb_For_cep.Caption := '';
      Lb_For_fone.Caption := '';
      Lb_For_bairro.Caption := '';
      Lb_For_cidade.Caption := '';
      Lb_For_Celular.Caption := '';
      Lb_For_cnpj.Caption := '';
      Lb_For_ie.Caption := '';

    end;
  End;
end;

procedure TRL_PedidoCompra_3.Pc_PreenheTRP;
BEgin
  with qr_transportadora do
  Begin
    Active := False;
    ParamByName('EMP_CODIGO').AsInteger := It_cd_Transporte;
    Active := True;
    First;
    if RecordCount > 0 then
    Begin
      Lb_Trp_Nome.Caption     := FieldByName('EMP_NOME').AsString + ' - ' + FieldByName('EMP_FANTASIA').AsString;
      Lb_Trp_endereco.Caption := FieldByName('END_ENDER').AsString;
      Lb_Trp_cep.Caption      := Fc_MascaraCep(FieldByName('END_CEP').AsString);
      Lb_Trp_fone.Caption     := fc_MascaraFone(FieldByName('END_FONE').AsString);
      Lb_Trp_bairro.Caption   := FieldByName('END_BAIRRO').AsString;
      Lb_Trp_cidade.Caption   := FieldByName('CDD_DESCRICAO').AsString;
      Lb_Trp_celular.Caption  := fc_MascaraFone(FieldByName('END_CELULAR').AsString);
      if Length(FieldByName('EMP_CNPJ').AsString)=11 then
        Lb_Trp_cnpj.Caption   := fc_MascaraCPF(FieldByName('EMP_CNPJ').AsString)
      else
        Lb_Trp_cnpj.Caption   := fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString);
      Lb_Trp_ie.Caption       := FieldByName('EMP_INSC_EST').AsString;
      Lb_Trp_ac.Caption       := FieldByName('END_CONTATO').AsString;
    end
    else
    Begin
      Lb_Trp_Nome.Caption := '';
      Lb_Trp_endereco.Caption := '';
      Lb_Trp_cep.Caption := '';
      Lb_Trp_fone.Caption := '';
      Lb_Trp_bairro.Caption := '';
      Lb_Trp_cidade.Caption := '';
      Lb_Trp_celular.Caption := '';
      Lb_Trp_cnpj.Caption := '';
      Lb_Trp_ie.Caption := '';
      Lb_Trp_ac.Caption := '';
    end;
  End;
end;

procedure TRL_PedidoCompra_3.Pc_PreenheENT;
BEgin
  with Qr_Entrega do
  Begin
    Active := False;
    ParamByName('END_CODIGO').AsInteger := It_cd_Entrega;
    Active := True;
    FetchAll;
    First;
    if RecordCount > 0 then
    Begin
      Lb_Ent_Nome.Caption     := FieldByname('EMP_NOME').AsString + ' - ' + FieldByname('EMP_FANTASIA').AsString;
      Lb_Ent_endereco.Caption := FieldByname('END_ENDER').AsString;
      Lb_Ent_cep.Caption      := Fc_MascaraCep(FieldByname('END_CEP').AsString);
      Lb_Ent_fone.Caption     := fc_MascaraFone(FieldByname('END_FONE').AsString);
      Lb_Ent_bairro.Caption   := FieldByname('END_BAIRRO').AsString;
      Lb_Ent_cidade.Caption   := FieldByname('CDD_DESCRICAO').AsString;
      Lb_Ent_celular.Caption  := fc_MascaraFone(FieldByname('END_CELULAR').AsString);
      if Length(FieldByname('EMP_CNPJ').AsString)=11 then
        Lb_Ent_cnpj.Caption   := fc_MascaraCPF(FieldByname('EMP_CNPJ').AsString)
      else
        Lb_Ent_cnpj.Caption   := fc_MascaraCNPJ(FieldByname('EMP_CNPJ').AsString);
      Lb_Ent_ie.Caption := FieldByname('EMP_INSC_EST').AsString;
      Lb_Ent_ac.Caption := FieldByname('END_CONTATO').AsString;
    end
    else
    Begin
      Lb_Ent_Nome.Caption := '';
      Lb_Ent_endereco.Caption := '';
      Lb_Ent_cep.Caption := '';
      Lb_Ent_fone.Caption := '';
      Lb_Ent_bairro.Caption := '';
      Lb_Ent_cidade.Caption := '';
      Lb_Ent_celular.Caption := '';
      Lb_Ent_cnpj.Caption := '';
      Lb_Ent_ie.Caption := '';
      Lb_Ent_ac.Caption := '';
    end;
  End;
end;

procedure TRL_PedidoCompra_3.Pc_PreenheFAT;
BEgin

  with Qr_Entrega do
  Begin
    Active := False;
    ParamByName('END_CODIGO').AsInteger := It_cd_Fatura;
    Active := True;
    FetchAll;
    First;
    if RecordCount > 0 then
    Begin
      Lb_Fat_Nome.Caption     := FieldByname('EMP_NOME').AsString + ' - ' + FieldByname('EMP_FANTASIA').AsString;
      Lb_Fat_endereco.Caption := Qr_Entrega.FieldByname('END_ENDER').AsString;
      Lb_Fat_cep.Caption      := Fc_MascaraCep(FieldByname('END_CEP').AsString);
      Lb_Fat_fone.Caption     := fc_MascaraFone(FieldByname('END_FONE').AsString);
      Lb_Fat_bairro.Caption   := FieldByname('END_BAIRRO').AsString;
      Lb_Fat_cidade.Caption   := FieldByname('CDD_DESCRICAO').AsString;
      Lb_Fat_Celular.Caption  := fc_MascaraFone(FieldByname('END_CELULAR').AsString);
      if Length(FieldByname('EMP_CNPJ').AsString)=11 then
        Lb_Fat_cnpj.Caption   := fc_MascaraCPF(FieldByname('EMP_CNPJ').AsString)
      else
        Lb_Fat_cnpj.Caption   := fc_MascaraCNPJ(FieldByname('EMP_CNPJ').AsString);
      Lb_Fat_ie.Caption       := FieldByname('EMP_INSC_EST').AsString;
      Lb_Fat_ac.Caption       := FieldByname('END_CONTATO').AsString;
    end
    else
    Begin
      Lb_Fat_Nome.Caption := '';
      Lb_Fat_endereco.Caption := '';
      Lb_Fat_cep.Caption := '';
      Lb_Fat_fone.Caption := '';
      Lb_Fat_bairro.Caption := '';
      Lb_Fat_cidade.Caption := '';
      Lb_Fat_Celular.Caption := '';
      Lb_Fat_cnpj.Caption := '';
      Lb_Fat_ie.Caption := '';
      Lb_Fat_ac.Caption := '';
    end;
  End;


end;

procedure TRL_PedidoCompra_3.Pc_PreenheCOB;
BEgin
  with Qr_Entrega do
  Begin
    Active := False;
    ParamByName('END_CODIGO').AsInteger := It_cd_Cobranca;
    Active := True;
    FetchAll;
    First;
    if RecordCount > 0 then
    Begin
      Lb_Cob_Nome.Caption     := FieldByname('EMP_NOME').AsString + ' - ' + FieldByname('EMP_FANTASIA').AsString;
      Lb_Cob_endereco.Caption := FieldByname('END_ENDER').AsString;
      Lb_Cob_cep.Caption      := Fc_MascaraCep(FieldByname('END_CEP').AsString);
      Lb_Cob_fone.Caption     := fc_MascaraFone(FieldByname('END_FONE').AsString);
      Lb_Cob_bairro.Caption   := FieldByname('END_BAIRRO').AsString;
      Lb_Cob_cidade.Caption   := FieldByname('CDD_DESCRICAO').AsString;
      Lb_Cob_Celular.Caption  := fc_MascaraFone(FieldByname('END_CELULAR').AsString);
      if Length(FieldByname('EMP_CNPJ').AsString)=11 then
        Lb_Cob_cnpj.Caption   := fc_MascaraCPF(FieldByname('EMP_CNPJ').AsString)
      else
        Lb_Cob_cnpj.Caption   := fc_MascaraCNPJ(FieldByname('EMP_CNPJ').AsString);
      Lb_Cob_ie.Caption       := FieldByname('EMP_INSC_EST').AsString;
      Lb_Cob_ac.Caption       := FieldByname('END_CONTATO').AsString;
    end
    else
    Begin
      Lb_Cob_Nome.Caption := '';
      Lb_Cob_endereco.Caption := '';
      Lb_Cob_cep.Caption := '';
      Lb_Cob_fone.Caption := '';
      Lb_Cob_bairro.Caption := '';
      Lb_Cob_cidade.Caption := '';
      Lb_Cob_Celular.Caption := '';
      Lb_Cob_cnpj.Caption := '';
      Lb_Cob_ie.Caption := '';
      Lb_Cob_ac.Caption := '';
    end;
  End;


end;


Procedure TRL_PedidoCompra_3.PC_VAlidaCampos(Pc_Print : Boolean);
Var
  Lc_Altura:Integer;
Begin
  E_Descricao.Lines.Clear;
  E_PrecoCusto.Lines.Clear;
  E_Tx_Dif_Custo.Lines.Clear;
  E_CodigoInterno.Lines.Clear;
  E_Qtde.Lines.Clear;
  E_VL_Unitario.Lines.Clear;
  E_VL_Subtotal.Lines.Clear;
  //Ajusta Altura dos Campos
  Lc_Altura := 20;
  Bd_DetalheStr.Height := Lc_Altura + 1;
  E_Descricao.Height := Lc_Altura;
  E_Qtde.Height := Lc_Altura;
  E_VL_Unitario.Height := Lc_Altura;
  E_VL_Subtotal.Height := Lc_Altura;
  Bd_DetalheStr.Repaint;
  Bd_DetalheStr.Refresh;
end;

Procedure TRL_PedidoCompra_3.PC_PreencheCampos;
Var
  Lc_Altura : Integer;
  Lc_Obs : TMemo;
  Lc_Produto : String;
  LcTxDifCusto : Real;
  LcValor : Real;
Begin
  if trim(Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString) = '' then
    Lc_Produto := Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString + ' - ' +Qr_Itens.FieldByname('PRO_DESCRICAO').AsString + ' / ' + Qr_Itens.FieldByname('MRC_DESCRICAO').AsString
  else
    Lc_Produto := Qr_Itens.FieldByname('PRO_CODIGOFOR').AsString + ' - ' +Qr_Itens.FieldByname('PRO_DESCRICAO').AsString + ' / ' + Qr_Itens.FieldByname('MRC_DESCRICAO').AsString;

  lc_obs := TMemo.Create(Self);
  lc_obs.Visible := false;
  lc_obs.Parent := Self;
  Lc_Obs.Width := E_Descricao.Width;
  Lc_Obs.Lines.Clear;
  Lc_Obs.Font.Size := 8;
  Lc_Obs.Lines.Add(Lc_Produto);
  Lc_Altura := Lc_Obs.Lines.Count;
  FreeAndNil(Lc_Obs);
  IF (Lc_Altura > 1) then
    Lc_Altura := Lc_Altura * 15
  else
    Lc_Altura := Lc_Altura * 20;
  //Ajusta Altura dos Campos
  Bd_DetalheStr.Height := Lc_Altura + 1;
  E_Descricao.Height := Lc_Altura;
  E_PrecoCusto.Height := Lc_Altura;
  E_Tx_Dif_Custo.Height := Lc_Altura;

  E_CodigoInterno.Height := Lc_Altura;
  E_Qtde.Height := Lc_Altura;
  E_VL_Unitario.Height := Lc_Altura;
  E_VL_Subtotal.Height := Lc_Altura;
  //Impressão dos campos
  E_Descricao.Lines.Add(' ' + Lc_Produto);
  E_Descricao.Refresh;
  E_Descricao.Repaint;

  if Qr_Ordem.FieldByName('PED_APROVADO').AsString = 'S' then
    E_PrecoCusto.Lines.Add(Qr_Itens.FieldByname('PRO_VL_CUSTO_LAST').AsString +  ' ');
  E_PrecoCusto.Refresh;
  E_PrecoCusto.Repaint;

  LcTxDifCusto :=
    RoundTo(
      ( ( Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency - Qr_Itens.FieldByName('PRO_VL_CUSTO_LAST').AsCurrency )/ Qr_Itens.FieldByName('PRO_VL_CUSTO_LAST').AsCurrency ) *100
    ,-2);
  if Qr_Ordem.FieldByName('PED_APROVADO').AsString = 'S' then
    E_Tx_Dif_Custo.Lines.Add(FloatToStrF(LcTxDifCusto,ffFixed,10,2) + '% '  );
  E_Tx_Dif_Custo.Refresh;
  E_Tx_Dif_Custo.Repaint;

  E_CodigoInterno.Lines.Add(' ' + Qr_Itens.FieldByname('ITF_CODPRO').AsString);
  E_CodigoInterno.Refresh;
  E_CodigoInterno.Repaint;

  E_Qtde.Lines.Add(FloatToStrF(Qr_Itens.FieldByname('ITF_QTDE').AsFloat,ffFixed,10,0) +' ');
  E_Qtde.Refresh;
  E_Qtde.Repaint;

  E_VL_Unitario.Lines.Add(formatFloat(Gb_Casa_Dec_Compra, Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency) + ' ');
  E_VL_Unitario.Refresh;
  E_VL_Unitario.Repaint;

  LcValor := Qr_Itens.FieldByName('ITF_QTDE').AsFloat * Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency;
  LcValor := RoundTo(LcValor,-2);
  E_VL_Subtotal.Lines.Add(FloatToStrf(LcValor,ffFixed, 10,2) + ' ');
  E_VL_Subtotal.Refresh;
  E_VL_Subtotal.Repaint;
end;

procedure TRL_PedidoCompra_3.Pc_Cabecalho;
begin
  with DM do
  Begin
    Pc_AtivaEstabelecimento;
    Lb_Emp_Nome.Caption := Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString;
    Lb_Emp_Doc.Caption := 'C.N.P.J: '+fc_MascaraCNPJ(Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsString) + ' -  I.E.: '+ Qr_Estabelecimento.FieldByname('EMP_INSC_EST').AsString;
    Lb_Emp_End.Caption := Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ' - ' +Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString + ' - ' + Fc_MascaraCep(Qr_Estabelecimento.FieldByname('END_CEP').AsString) + ' - ' +Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' +Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString + ' - Fone: ' +fc_MascaraFone(Qr_Estabelecimento.FieldByname('END_FONE').AsString);
    Lb_Emp_www.Caption := Qr_Estabelecimento.FieldByname('EMP_SITE').AsString;
    Lb_Emp_email.Caption := Qr_Estabelecimento.FieldByname('EMP_EMAIL').AsString;
    Lb_For_Pedido.Caption := Qr_Ordem.FieldByName('PED_NUMERO').AsString;
    Lb_For_Data.Caption := Qr_Ordem.FieldByName('PED_DATA').AsString;
    Fc_BuscaImagemEmpresa(Img_Logo.Picture,'LOGO');
  end;
end;


procedure TRL_PedidoCompra_3.Pc_Rodape;
begin
  Lb_Total.Caption := FloattoStrf(Qr_Ordem.FieldByName('PED_VL_PEDIDO').AsCurrency,ffCurrency,10,2);
  Lb_Assina_1.Caption := GB_Nm_Usuario;
  Lb_Assina_2.Caption := DM.Qr_Estabelecimento.FieldByname('END_CONTATO').AsString;
  Lb_PrzEntrega.Caption := 'PRAZO DE ENTREGA : ' + Qr_Ordem.FieldByName('PED_DT_ENTREGA').AsString;
end;


procedure TRL_PedidoCompra_3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=Cafree;
  RL_PedidoCompra_3:=nil;
end;

procedure TRL_PedidoCompra_3.FormCreate(Sender: TObject);
begin
  Pc_AtivaEstabelecimento;
end;

procedure TRL_PedidoCompra_3.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_I : Integer;
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  It_NItens := 0;
  It_Sequencia := 0;

  //Pedido
  Qr_Ordem.Active := False;
  Qr_Ordem.ParamByName('PED_CODIGO').AsInteger := it_cd_Pedido;
  Qr_Ordem.Active := True;
  Qr_Ordem.First;

  It_cd_Entrega:= Qr_Ordem.FIeldbyname('PED_CODENT').AsInteger;
  It_cd_Transporte:= Qr_Ordem.FIeldbyname('PED_CODTRP').AsInteger;
  It_cd_Fatura:= Qr_Ordem.FIeldbyname('PED_CODFAT').AsInteger;
  It_cd_Cobranca:= Qr_Ordem.FIeldbyname('PED_CODCOB').AsInteger;

  //Itens do Pedido
  Qr_Itens.Active := False;
  Qr_Itens.ParamByName('ITF_CODPED').AsInteger := it_cd_Pedido;
  Qr_Itens.Active := True;
  Qr_Itens.Last;
  Qr_Itens.First;
  Bd_DetalheStr.Items.Clear;
  if Qr_Itens.RecordCount >10 then
    Begin
    For Lc_I:= 1 to Qr_Itens.RecordCount do
      Bd_DetalheStr.Items.Add(IntTostr(Lc_I));
    end
  else
    Begin
    For Lc_I:= 1 to 10 do
      Bd_DetalheStr.Items.Add(IntTostr(Lc_I));
    end;
  Pc_Cabecalho;
  Pc_PreenheFOR;
end;

procedure TRL_PedidoCompra_3.Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
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

procedure TRL_PedidoCompra_3.RodapeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_Parcelamento;
  Pc_Rodape;
  Pc_PreenheTRP;
  Pc_PreenheENT;
  Pc_PreenheFAT;
  Pc_PreenheCOB;
end;

end.
