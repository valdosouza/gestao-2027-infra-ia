unit UN_RL_Orcamento_13;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, jpeg, DB, STQuery, StdCtrls, QRPDFFilt;

type
  TRL_Orcamento_13 = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    Bd_DetalheStr: TQRStringsBand;
    QRBand4: TQRBand;
    Lb_Data: TQRLabel;
    Lb_Orcamento: TQRLabel;
    QRLabel8: TQRLabel;
    E_Vl_Geral: TQRLabel;
    QRPDFFilter1: TQRPDFFilter;
    QRMemo11: TQRMemo;
    LB_TextoDesconto: TQRLabel;
    E_VL_Desconto: TQRLabel;
    QRLabel1: TQRLabel;
    Lb_Cli_Nome: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel12: TQRLabel;
    Lb_Contato: TQRLabel;
    Lb_Cli_Codigo: TQRLabel;
    QRLabel36: TQRLabel;
    Lb_email: TQRLabel;
    QRBand3: TQRBand;
    Img_Logo: TQRImage;
    Lb_Emp_Nome: TQRLabel;
    Lb_Emp_Doc: TQRLabel;
    Lb_Emp_www: TQRLabel;
    Lb_Emp_email: TQRLabel;
    Qr_Cotacao: TSTQuery;
    Qr_Itens: TSTQuery;
    Qr_Produto: TSTQuery;
    E_Descricao: TQRMemo;
    E_Qtde: TQRMemo;
    E_VL_Unitario: TQRMemo;
    E_Vl_Unit_Total: TQRMemo;
    QRMemo1: TQRMemo;
    QRMemo4: TQRMemo;
    QRMemo8: TQRMemo;
    QRMemo9: TQRMemo;
    QRPDFShape5: TQRMemo;
    Lb_Emp_Fones: TQRLabel;
    QRLabel4: TQRLabel;
    Lb_Obs: TQRMemo;
    E_VL_Frete: TQRLabel;
    Lb_frete: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
   CasaDecimais : Integer;
  public
    { Public declarations }
    It_Vendedor:String;
    It_Cd_Pedido : Integer;
    Procedure PC_VAlidaCampos(Pc_Print : Boolean);
    Procedure PC_PreencheCampos;
    Procedure Pc_PreenheCli;
    procedure Pc_Cabecalho;
  end;

var
  RL_Orcamento_13: TRL_Orcamento_13;

implementation

uses      Un_Funcoes, UN_Sistema, Un_DM, Mask, Un_Regra_Negocio, Un_Principal, env;
{$R *.dfm}

Procedure TRL_Orcamento_13.Pc_PreenheCli;
BEgin
  if trim(Qr_Cotacao.FieldByName('EMP_NOME').AsString)<>'' then
    Lb_Cli_Nome.Caption := Qr_Cotacao.FieldByName('EMP_NOME').AsString + ' - ' + Qr_Cotacao.FieldByName('EMP_FANTASIA').AsString
  else
    Lb_Cli_Nome.Caption := Qr_Cotacao.FieldByName('CTC_FANTASIA').AsString;
  Lb_Cli_Codigo.Caption := Qr_Cotacao.FieldByName('EMP_CODIGO').AsString;
  Lb_Contato.Caption  := Qr_Cotacao.FieldByName('CTC_CONTATO').AsString;
  Lb_email.Caption    := Qr_Cotacao.FieldByName('CTC_EMAIL_E').AsString;
end;

Procedure TRL_Orcamento_13.PC_VAlidaCampos(Pc_Print : Boolean);
Var
  Lc_Altura:Integer;
Begin
  E_Descricao.Lines.Clear;
  E_Qtde.Lines.Clear;
  E_VL_Unitario.Lines.Clear;
  E_Vl_Unit_Total.Lines.Clear;
  //Ajusta Altura dos Campos
  Lc_Altura := 20;
  Bd_DetalheStr.Height := Lc_Altura + 1;
  E_Descricao.Height := Lc_Altura;
  E_Qtde.Height := Lc_Altura;
  E_VL_Unitario.Height := Lc_Altura;
  E_Vl_Unit_Total.Height := Lc_Altura;
  Bd_DetalheStr.Repaint;
  Bd_DetalheStr.Refresh;
end;

Procedure TRL_Orcamento_13.PC_PreencheCampos;
Var
  Lc_Altura : Integer;
  Lc_Obs : TMemo;
  Lc_Produto : String;
Begin
  Qr_Produto.Active := False;
  Qr_Produto.ParamByName('PRO_CODIGO').AsInteger := Qr_Itens.FieldByName('ICT_CODVCL').AsInteger;
  Qr_Produto.Active := True;
  Qr_Produto.FetchAll;
  Qr_Produto.First;
  if Qr_Produto.RecordCount > 0 then
  begin
    Lc_Produto := Qr_Produto.FieldByName('PRO_CODIGOFAB').AsString + ' - ' + Qr_Itens.FieldByName('ICT_DESCRICAO').AsString + ' / ' + Qr_Produto.FieldByName('MRC_DESCRICAO').AsString
  end
  else
  begin
    Lc_Produto := Qr_Itens.FieldByName('ICT_DESCRICAO').AsString;
  end;
  
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
  //Impressão dos campos
  E_Descricao.Lines.Add(' ' + Lc_Produto);
  E_Descricao.Refresh;
  E_Descricao.Repaint;
  E_Qtde.Height := Lc_Altura;
  E_Qtde.Lines.Add(FloatToStrf(Qr_Itens.FieldByName('ICT_QTDE').AsFloat,ffFixed,10,0) + ' ');
  E_Qtde.Refresh;
  E_Qtde.Repaint;
  E_VL_Unitario.Height := Lc_Altura;
  E_VL_Unitario.Lines.Add(FloatToStrf(Qr_Itens.FieldByName('ICT_VL_UNIT').AsCurrency,ffFixed,10,CasaDecimais) + ' ');
  E_VL_Unitario.Refresh;
  E_VL_Unitario.Repaint;
  E_Vl_Unit_Total.Height := Lc_Altura;
  E_Vl_Unit_Total.Lines.Add(FloatToStrf(Qr_Itens.FieldByName('ICT_VL_SUBTOTAL').AsCurrency,ffFixed,10,2) + ' ');
  E_Vl_Unit_Total.Refresh;
  E_Vl_Unit_Total.Repaint;

end;

procedure TRL_Orcamento_13.Pc_Cabecalho;
Var
  LcFone : String;
begin
  WITH DM.Qr_Estabelecimento DO
  bEGIN
    Fc_BuscaImagemEmpresa(img_logo.Picture, 'LOGO');
    Lb_Emp_Nome.Caption := FieldByName('EMP_FANTASIA').AsString;
    Lb_Emp_Doc.Caption := 'C.N.P.J: '+fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString) + ' -  I.E.: '+ FieldByName('EMP_INSC_EST').AsString;
    LcFone := '';
    if FieldByName('END_FONE').AsString <> '' then
      LcFone := concat('FONE: ',fc_MascaraFone(FieldByName('END_FONE').AsString));

    if FieldByName('END_FAX').AsString <> '' then
      if LcFone = '' then
        LcFone := concat('FAX: ',fc_MascaraFone(FieldByName('END_FAX').AsString))
      else
        LcFone := concat(LcFone,' - FAX: ',fc_MascaraFone(FieldByName('END_FAX').AsString));

    if FieldByName('END_CELULAR').AsString <> '' then
      if LcFone = '' then
        LcFone := concat('CELULAR: ',fc_MascaraFone(FieldByName('END_CELULAR').AsString))
      else
        LcFone := concat(LcFone,' - CELULAR: ',fc_MascaraFone(FieldByName('END_CELULAR').AsString));

    if FieldByName('END_COMERCIAL').AsString <> '' then
      if LcFone = '' then
        LcFone := concat('COMERCIAL: ',fc_MascaraFone(FieldByName('END_COMERCIAL').AsString))
      else
        LcFone := concat(LcFone,' - COMERCIAL: ',fc_MascaraFone(FieldByName('END_COMERCIAL').AsString));

    if FieldByName('END_PORTARIA').AsString <> '' then
      if LcFone = '' then
        LcFone := concat(LcFone,'PORTARIA: ',fc_MascaraFone(FieldByName('END_PORTARIA').AsString))
      else
        LcFone := concat(' - PORTARIA: ',fc_MascaraFone(FieldByName('END_PORTARIA').AsString));
    Lb_Emp_Fones.Caption :=  LcFone;
    Lb_Emp_www.Caption := FieldByName('EMP_SITE').AsString;
    Lb_Emp_email.Caption := FieldByName('EMP_EMAIL').AsString;
  END;
end;

procedure TRL_Orcamento_13.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_Ano,Lc_mes,Lc_dia:String ;
  Lc_I:Integer;
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_AtivaEstabelecimento;
  Pc_Cabecalho;
  Qr_Cotacao.Active := False;
  Qr_Cotacao.ParamByName('CTC_CODPED').AsInteger := It_Cd_Pedido;
  Qr_Cotacao.Active := True;


  Lb_Orcamento.Caption := 'Orçamento Nº '+ Qr_Cotacao.FieldByName('CTC_NUMERO').AsString;
  Lc_dia := Copy(Qr_Cotacao.FieldByName('CTC_DATA').AsString,1,2);
  Lc_mes := Fc_DesMes(Fc_Month(Qr_Cotacao.FieldByName('CTC_DATA').AsDateTime),True);
  Lc_Ano := Copy(Qr_Cotacao.FieldByName('CTC_DATA').AsString,7,4);

  Lb_Data.Caption := Lc_dia + ' de ' + Lc_mes + ' de '+ Lc_Ano;
  Pc_PreenheCli;
  Qr_Itens.Active := False;
  Qr_Itens.ParamByName('CTC_CODIGO').AsInteger := Qr_Cotacao.FieldByName('CTC_CODIGO').AsInteger;
  Qr_Itens.Active := True;
  Qr_Itens.Last;
  Bd_DetalheStr.Items.Clear;
  For Lc_I:=1 to Qr_Itens.RecordCount do
    Bd_DetalheStr.Items.Add(IntTOStr(lc_I));
  Qr_Itens.First;



end;

procedure TRL_Orcamento_13.Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Not Qr_Itens.Eof then
    Begin
    pc_ValidaCampos(True);
    Pc_PreencheCAmpos;
    Qr_Itens.Next;
    end
  else
    pc_ValidaCampos(False);
end;

procedure TRL_Orcamento_13.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_I : Integer;
  Lc_obs : TMemo;
begin
  if (Qr_Cotacao.FieldByName('CTC_VL_DESCONTO').AsCurrency > 0) then
  Begin
    LB_TextoDesconto.Font.Color := clBlack;
    E_VL_Desconto.Font.Color := clBlack;
    E_VL_Desconto.Caption := FloatToStrF(Qr_Cotacao.FieldByName('CTC_VL_DESCONTO').AsCurrency,ffFixed,10,2);
  end
  else
  Begin
    LB_TextoDesconto.Font.Color := clWhite;
    E_VL_Desconto.Font.Color := clWhite;
    E_VL_Desconto.Caption := '0,00';
  end;
  if (Qr_Cotacao.FieldByName('CTC_VL_FRETE').AsCurrency > 0) then
  Begin
    Lb_frete.Font.Color := clBlack;
    E_VL_Frete.Font.Color := clBlack;
    E_VL_Frete.Caption := FloatToStrF(Qr_Cotacao.FieldByName('CTC_VL_FRETE').AsCurrency,ffFixed,10,2);
  end
  else
  Begin
    Lb_frete.Font.Color := clWhite;
    E_VL_Frete.Font.Color := clWhite;
    E_VL_Frete.Caption := '0,00';
  end;

  E_Vl_Geral.Caption := 'R$ ' + FloatToStrF(Qr_Cotacao.FieldByName('CTC_VL_COTACAO').AsCurrency,ffFixed,10,2);
  Lc_obs := TMemo.Create(Self);
  Lc_obs.Parent := Self;
  Lc_obs.Visible := False;
  Lc_obs.Width := 725;
  Lc_obs.Text := Qr_Cotacao.FieldByName('CTC_OBS').AsString;
  Lb_obs.Lines.Clear;
  if StrToDateDef(Qr_Cotacao.FieldByName('CTC_PRZ_ENTREGA').AsString,0) > 0 then
    Lb_obs.Lines.Add('Prazo de Entrega : ' + Qr_Cotacao.FieldByName('CTC_PRZ_ENTREGA').AsString);
  For Lc_I := 0 to Lc_obs.Lines.Count - 1 do
    Lb_Obs.Lines.Add(Lc_obs.Lines[lc_I]);
end;

procedure TRL_Orcamento_13.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qrpt);
  Action := caFree;
  RL_Orcamento_13 := nil;
end;

procedure TRL_Orcamento_13.FormCreate(Sender: TObject);
begin
  Pc_Define_CasasDecimais;
  CasaDecimais := Length(Gb_Casa_Dec_Venda)-2;
end;

end.
