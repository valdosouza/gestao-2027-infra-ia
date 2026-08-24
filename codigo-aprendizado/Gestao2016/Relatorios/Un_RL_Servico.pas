unit Un_RL_Servico;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, QuickRpt, QRCtrls, ExtCtrls;

type

  TRL_Servico = class(TForm)
    Qrpt: TQuickRep;
    Grupo: TQRGroup;
    QRShape20: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    Lb_CNPJ: TQRLabel;
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
    Lb_Titulo: TQRLabel;
    Lb_Cli_Pedido: TQRLabel;
    Lb_Cli_Data: TQRLabel;
    QRLabel38: TQRLabel;
    Rodape: TQRBand;
    QRShape11: TQRShape;
    Lb_Vl_Servico: TQRLabel;
    Lb_Vl_Pecas: TQRLabel;
    Lb_Vl_Desconto: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    Lb_Vl_Total: TQRLabel;
    QRLabel31: TQRLabel;
    Lb_TipoCob: TQRLabel;
    QRLabel1: TQRLabel;
    Lb_Vl_SubTotal: TQRLabel;
    QRShape14: TQRShape;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    QRLabel52: TQRLabel;
    QRLabel61: TQRLabel;
    QRLabel62: TQRLabel;
    QRLabel65: TQRLabel;
    QRLabel67: TQRLabel;
    QRLabel69: TQRLabel;
    StrB_Servico: TQRStringsBand;
    QRShape3: TQRShape;
    QRShape2: TQRShape;
    Lb_SubVl_Srv: TQRLabel;
    Lb_Descricao_Srv: TQRLabel;
    Lb_Mecanicos: TQRLabel;
    StrB_Produto: TQRStringsBand;
    QRShape5: TQRShape;
    QRShape7: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    Lb_SubVl_Pro: TQRLabel;
    Lb_VlUnit_Pro: TQRLabel;
    Lb_Qtde_Pro: TQRLabel;
    Lb_Codigo_Pro: TQRLabel;
    Lb_Descricao_Pro: TQRLabel;
    Qr_Tecnico: TSTQuery;
    Qr_TecnicoTEC_CODCLB: TIntegerField;
    Qr_Ordem: TSTQuery;
    Qr_ItensSrv: TSTQuery;
    Qr_ItensPro: TSTQuery;
    Qr_Pedido: TSTQuery;
    Lb_Placa: TQRLabel;
    Lb_Veiculo: TQRLabel;
    Lb_Ano: TQRLabel;
    Lb_Cor: TQRLabel;
    Lb_Frota: TQRLabel;
    Lb_Marca_Modelo: TQRLabel;
    Lb_Km: TQRLabel;
    Lb_Obs: TQRLabel;
    QRShape15: TQRShape;
    QRShape6: TQRShape;
    Qr_Endereco: TSTQuery;
    QRLabel15: TQRLabel;
    Lb_DataSaida: TQRLabel;
    Lb_KmHrSaida: TQRLabel;
    QRLabel19: TQRLabel;
    Lb_Assinatura: TQRLabel;
    Lb_LocalData: TQRLabel;
    QRLabel2: TQRLabel;
    Lb_NomeVendedor: TQRLabel;
    Cabecalho: TQRBand;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure RodapeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure StrB_ServicoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure StrB_ProdutoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Codigo : Integer;
    It_Cab_Pro : boolean;
    It_Cab_Srv : boolean;
    It_Vl_Servico, It_Vl_Produto, It_vl_Desconto : real;
    procedure Pc_PreencheCliente;

    procedure Pc_PreencheOrdemNova;
    Procedure PC_ValidaProdutos(Pc_Print : Boolean);
    Procedure PC_PreencheProdutos;
    Procedure PC_ValidaServicos(Pc_Print : Boolean);
    Procedure PC_PreencheServicos;
    procedure Pc_Rodape;
  end;

var
  RL_Servico: TRL_Servico;

implementation

uses     Un_DM, UN_Sistema, Un_Regra_Negocio;
{$R *.dfm}



procedure TRL_Servico.Pc_PreencheCliente;
Var
  Lc_CPF_CNPJ:String;
begin
  Lb_Cli_Nome.Caption := Qr_Pedido.FieldByname('PED_CODEMP').AsString + ' | ' + Qr_Pedido.FieldByname('EMP_NOME').AsString;
  Lb_Cli_Endereco.Caption := Copy(Qr_Endereco.FieldByname('END_ENDER').AsString + ', ' + Qr_Endereco.FieldByname('END_NUMERO').AsString,1,37);
  Lb_Cli_cep.Caption := fc_MascaraCep(Qr_Endereco.FieldByname('END_CEP').AsString);
  Lb_Cli_FoneC.Caption := fc_MascaraFone(Qr_Endereco.FieldByname('END_FONE').AsString);
  Lb_Cli_bairro.Caption := Qr_Endereco.FieldByname('END_BAIRRO').AsString;
  Lb_Cli_Cidade.Caption := Qr_Endereco.FieldByname('CDD_DESCRICAO').AsString;
  Lb_Cli_Fax.Caption := fc_MascaraFone(Qr_Endereco.FieldByname('END_FAX').AsString);
  if Length(Qr_Pedido.FieldByname('EMP_CNPJ').AsString)=11 then
    BEgin
    Lb_CNPJ.Caption := 'C.P.F: ';
    Lc_CPF_CNPJ:= fc_MascaraCPF(Qr_Pedido.FieldByname('EMP_CNPJ').AsString);
    end
  else
    Begin
    Lb_CNPJ.Caption := 'C.N.P.J: ';
    Lc_CPF_CNPJ:= fc_MascaraCNPJ(Qr_Pedido.FieldByname('EMP_CNPJ').AsString);
    end;
  Lb_Cli_Cnpj.Caption := Lc_CPF_CNPJ;
  Lb_Cli_IncEst.Caption := Qr_Pedido.FieldByname('EMP_INSC_EST').AsString;
  Lb_Cli_Celular.Caption := fc_MascaraFone(Qr_Endereco.FieldByname('END_CELULAR').AsString);
end;



procedure TRL_Servico.Pc_PreencheOrdemNova;
Begin
  with Qr_Ordem do
  Begin
    if (trim(FieldByname('ENTRANCE_DATE').AsString) <> '') and (FieldByname('ENTRANCE_DATE').AsString <>'  /  /    ') then
      Lb_Cli_Data.Caption := FieldByname('ENTRANCE_DATE').AsString + ' - ' + FieldByname('ENTRANCE_HOUR').AsString + ' hs'
    else
      Lb_Cli_Data.Caption :=  Qr_Pedido.FieldByname('PED_DATA').AsString;
    Lb_Placa.Caption := Copy(FieldByName('VEI_PLACA').AsString,1,3) + '-' + Copy(FieldByName('VEI_PLACA').AsString,4,4);
    Lb_Veiculo.Caption := FieldByName('TPV_DESCRICAO').AsString;
    Lb_Ano.Caption := FieldByName('VEI_ANO').AsString;
    Lb_Cor.Caption := FieldByName('COR_DESCRICAO').AsString;
    Lb_Frota.Caption := FieldByName('VEI_FROTA').AsString;
    Lb_Marca_Modelo.Caption := concat(FieldByName('MRC_DESCRICAO').AsString,'/',FieldByName('MOD_DESCRICAO').AsString);
  //  Lb_Motor.Caption := FieldByName('VEI_MOTOR').AsString;
  //  Lb_Chassi.Caption := FieldByName('VEI_CHASSI').AsString;
    Lb_Km.Caption := FieldByName('KM').AsString;
    Lb_Obs.Caption := FieldByName('OBS').AsString;
  end;
end;

Procedure TRL_Servico.PC_ValidaServicos(Pc_Print : Boolean);
Begin
  if Pc_Print then
    BEgin
    Lb_Mecanicos.Font.Style := [];
    Lb_Descricao_Srv.Font.Style := [];
    Lb_SubVl_Srv.Font.Style := [];

    Lb_Mecanicos.Alignment := taLeftJustify;
    Lb_Descricao_Srv.Alignment := taLeftJustify;
    Lb_SubVl_Srv.Alignment := taRightJustify;

    Lb_Mecanicos.Font.Color := clBlack;
    Lb_Descricao_Srv.Font.Color := clBlack;
    Lb_SubVl_Srv.Font.Color := clBlack;
    end
  else
    BEgin
    Lb_Mecanicos.Font.Color := clWhite;
    Lb_Descricao_Srv.Font.Color := clWhite;
    Lb_SubVl_Srv.Font.Color := clWhite;
    end;
end;

Procedure TRL_Servico.PC_PreencheServicos;
Var
  Lc_Mecanicos : String;
Begin
  Qr_Tecnico.Active := False;
  Qr_Tecnico.ParamByName('ITF_CODIGO').AsInteger := Qr_ItensSrv.FieldByname('ITF_CODIGO').AsInteger;
  Qr_Tecnico.Active := True;
  Qr_Tecnico.First;
  Lc_Mecanicos := '';
  while not Qr_Tecnico.eof do
    Begin
    if Qr_Tecnico.Bof then
      Lc_Mecanicos := Qr_TecnicoTEC_CODCLB.AsString
    else
      Lc_Mecanicos := Lc_Mecanicos + '/' +Qr_TecnicoTEC_CODCLB.AsString;
    Qr_Tecnico.Next;
    end;
  Lb_Mecanicos.Caption := Lc_Mecanicos;
  Lb_Descricao_Srv.Caption := Qr_ItensSrv.FieldByname('PRO_DESCRICAO').AsString;
  Lb_SubVl_Srv.Caption := FloatToStrf(Qr_ItensSrv.FieldByname('ITF_VL_SUBTOTAL').AsCurrency,ffFixed,10,2);
  It_Vl_Servico := It_Vl_Servico + Qr_ItensSrv.FieldByname('ITF_VL_SUBTOTAL').AsCurrency;
end;

Procedure TRL_Servico.PC_VAlidaProdutos(Pc_Print : Boolean);
Begin
  if Pc_Print then
    BEgin
    Lb_Codigo_Pro.Font.Style := [];
    Lb_Descricao_Pro.Font.Style := [];
    Lb_Qtde_Pro.Font.Style := [];
    Lb_VlUnit_Pro.Font.Style := [];
    Lb_SubVl_Pro.Font.Style := [];

    Lb_Codigo_Pro.Alignment := taLeftJustify;
    Lb_Descricao_Pro.Alignment := taLeftJustify;
    Lb_Qtde_Pro.Alignment := taRightJustify;
    Lb_VlUnit_Pro.Alignment := taRightJustify;
    Lb_SubVl_Pro.Alignment := taRightJustify;

    Lb_Codigo_Pro.Font.Color := clBlack;
    Lb_Descricao_Pro.Font.Color := clBlack;
    Lb_Qtde_Pro.Font.Color := clBlack;
    Lb_VlUnit_Pro.Font.Color := clBlack;
    Lb_SubVl_Pro.Font.Color := clBlack;
    end
  else
    BEgin
    Lb_Codigo_Pro.Font.Color := clWhite;
    Lb_Descricao_Pro.Font.Color := clWhite;
    Lb_Qtde_Pro.Font.Color := clWhite;
    Lb_VlUnit_Pro.Font.Color := clWhite;
    Lb_SubVl_Pro.Font.Color := clWhite;
    end;

end;

Procedure TRL_Servico.PC_PreencheProdutos;
Begin
  Lb_Codigo_Pro.Caption := Qr_ItensPro.FieldByname('PRO_CODIGOFAB').AsString;
  Lb_Descricao_Pro.Caption := Qr_ItensPro.FieldByname('PRO_DESCRICAO').AsString;
  Lb_Qtde_Pro.Caption := formatFloat('#,##0.###',Qr_ItensPro.FieldByName('ITF_QTDE').AsFloat);
  Lb_VlUnit_Pro.Caption := FloatToStrf(Qr_ItensPro.FieldByname('ITF_VL_UNIT').AsCurrency,ffFixed,10,2);
  Lb_SubVl_Pro.Caption := FloatToStrf(Qr_ItensPro.FieldByname('ITF_VL_SUBTOTAL').AsCurrency,ffFixed,10,2);
  It_Vl_Produto := It_Vl_Produto + Qr_ItensPro.FieldByname('ITF_VL_SUBTOTAL').AsCurrency;
end;


procedure TRL_Servico.Pc_Rodape;
begin
  Lb_TipoCob.Caption := Qr_Pedido.FieldByname('FPT_DESCRICAO').AsString + ' - ' + Qr_Pedido.FieldByname('PED_PRAZO').AsString;
  Lb_DataSaida.Caption := Qr_Ordem.FieldByName('EXIT_DATE').AsString;
  Lb_KmHrSaida.Caption := Qr_Ordem.FieldByName('EXIT_HOUR').AsString;
  Lb_Vl_Servico.Caption := FloattoStrf(It_Vl_Servico,ffFixed,10,2);
  Lb_Vl_Pecas.Caption := FloattoStrf(It_Vl_Produto,ffFixed,10,2);
  Lb_Vl_SubTotal.Caption := FloattoStrf(It_Vl_Servico +  It_Vl_Produto,ffFixed,10,2);
  Lb_Vl_Desconto.Caption := FloattoStrf(It_vl_Desconto ,ffFixed,10,2);
  Lb_Vl_Total.Caption := FloattoStrf(It_Vl_Servico + It_Vl_Produto - It_vl_Desconto,ffFixed,10,2);
  Lb_NomeVendedor.Caption := Qr_Pedido.FieldByname('CLB_NOME').AsString;
  Lb_LocalData.Caption := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + '   ______/______/___________ ';
  Lb_Assinatura.Caption := Qr_Pedido.FieldByname('EMP_NOME').AsString;
end;

procedure TRL_Servico.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_I : Integer;
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_AtivaEstabelecimento;
  It_Vl_Servico := 0;
  It_Vl_Produto := 0;
  It_vl_Desconto := 0;
  It_Cab_Pro := True;
  It_Cab_Srv := True;
  //Cabe�alho
  if (Fc_Tb_Geral('L','GRL_G_MOSTRAESTABELECIMENTO','N') = 'S') then
    Begin
    Cabecalho.Height := 105;
    Pc_Cab_Relatorio(Qrpt);
    end
  else
    Begin
    Cabecalho.Height := 0;
    end;
  //Pedido
  Qr_Pedido.Active := False;
  Qr_Pedido.ParamByName('PED_CODIGO').AsInteger := It_Codigo;
  Qr_Pedido.Active := True;
  Qr_Pedido.FetchAll;
  Qr_Pedido.RecordCount;
  Qr_Pedido.First;
  It_vl_Desconto := Qr_Pedido.FieldByname('PED_VL_DESCONTO').AsCurrency;

  Qr_Endereco.Active := False;
  Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := Qr_Pedido.FieldByname('PED_CODEMP').AsInteger;
  Qr_Endereco.Active := True;

  //Detalhes da Ordem
  Qr_Ordem.Active := False;
  Qr_Ordem.ParamByName('PED_CODIGO').AsInteger := It_Codigo;
  Qr_Ordem.Active := True;
  Qr_Ordem.FetchAll;
  Qr_Ordem.First;

  //Itens de Produto
  Qr_ItensPro.Active := False;
  Qr_ItensPro.ParamByName('ITF_CODPED').AsInteger := It_Codigo;
  Qr_ItensPro.Active := True;
  Qr_ItensPro.FetchAll;
  Qr_ItensPro.First;
  if Qr_ItensPro.RecordCount > 0 then
    Begin
    StrB_Produto.Items.Clear;
    For Lc_I:= 0 to Qr_ItensPro.RecordCount do
    StrB_Produto.Items.Add(IntTostr(Lc_I));
    StrB_Produto.Height := 23;
    end
  else
    StrB_Produto.Height := -1;

  //Itens de Servico
  Qr_ItensSrv.Active := False;
  Qr_ItensSrv.ParamByName('ITF_CODPED').AsInteger := It_Codigo;
  Qr_ItensSrv.Active := True;
  Qr_ItensSrv.FetchAll;
  Qr_ItensSrv.First;
  if Qr_ItensSrv.RecordCount > 0 then
  Begin
    StrB_Servico.Items.Clear;
    For Lc_I:= 0 to Qr_ItensSrv.RecordCount do
      StrB_Servico.Items.Add(IntTostr(Lc_I));
    StrB_Servico.Height := 23;
  end
  else
    StrB_Servico.Height := -1;

  if Qr_Pedido.FieldByname('PED_FATURADO').AsString = 'S' then
    Lb_Titulo.Caption := 'REVIS�O :'
  else
    Lb_Titulo.Caption := 'ORDEM DE SERVI�O :';
  Lb_Cli_Pedido.Caption := Qr_Pedido.FieldByname('PED_NUMERO').AsString;
  Pc_PreencheCliente;
  Pc_PreencheOrdemNova
end;

procedure TRL_Servico.RodapeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_Rodape;
end;

procedure TRL_Servico.StrB_ServicoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if It_Cab_Srv then
    Begin
    Lb_Mecanicos.Font.Color := clBlack;
    Lb_Descricao_Srv.Font.Color := clBlack;
    Lb_SubVl_Srv.Font.Color := clBlack;

    Lb_Mecanicos.Font.Style := [fsBold];
    Lb_Descricao_Srv.Font.Style := [fsBold];
    Lb_SubVl_Srv.Font.Style := [fsBold];

    Lb_Mecanicos.Caption := 'Instalador(es)';
    Lb_Descricao_Srv.Caption := 'Descrição dos Serviços';
    Lb_SubVl_Srv.Caption := 'Sub Total';
    It_Cab_Srv := False;
    end
  else
    Begin
    if Not Qr_ItensSrv.Eof then
      Begin
      PC_ValidaServicos(True);
      PC_PreencheServicos;
      Qr_ItensSrv.Next;
      end
    else
      PC_ValidaServicos(False);
    end;
end;

procedure TRL_Servico.StrB_ProdutoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if It_Cab_Pro then
    Begin
    Lb_Codigo_Pro.Font.Color := clBlack;
    Lb_Descricao_Pro.Font.Color := clBlack;
    Lb_Qtde_Pro.Font.Color := clBlack;
    Lb_VlUnit_Pro.Font.Color := clBlack;
    Lb_SubVl_Pro.Font.Color := clBlack;

    Lb_Codigo_Pro.Font.Style := [fsBold];
    Lb_Descricao_Pro.Font.Style := [fsBold];
    Lb_Qtde_Pro.Font.Style := [fsBold];
    Lb_VlUnit_Pro.Font.Style := [fsBold];
    Lb_SubVl_Pro.Font.Style := [fsBold];

    Lb_Codigo_Pro.Caption := 'Código';
    Lb_Descricao_Pro.Caption := 'Descrição dos Produtos';
    Lb_Qtde_Pro.Caption := 'Qtde';
    Lb_VlUnit_Pro.Caption := 'V. Unit�rio';
    Lb_SubVl_Pro.Caption := 'Sub Total';
    It_Cab_Pro := False;
    end
  else
    Begin
    if Not Qr_ItensPro.Eof then
      Begin
      PC_ValidaProdutos(True);
      PC_PreencheProdutos;
      Qr_ItensPro.Next;
      end
    else
      PC_ValidaProdutos(False);
    end;
end;

end.
