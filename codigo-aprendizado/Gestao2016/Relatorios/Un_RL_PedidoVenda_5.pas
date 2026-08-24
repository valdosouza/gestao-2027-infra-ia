unit Un_RL_PedidoVenda_5;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, QuickRpt, QRCtrls, ExtCtrls, System.Math;

type
  TRL_PedidoVenda_5 = class(TForm)
    Qrpt: TQuickRep;
    Cabecalho: TQRGroup;
    QRShape20: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    Lb_CNPJ: TQRLabel;
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
    Lb_Ie: TQRLabel;
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
    QRLabel21: TQRLabel;
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
    StrB_Servico: TQRStringsBand;
    QRShape3: TQRShape;
    QRShape2: TQRShape;
    Lb_SubVl_Srv: TQRLabel;
    Lb_Descricao_Srv: TQRLabel;
    Lb_Cd_Servico: TQRLabel;
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
    Qr_ItensSrv: TSTQuery;
    Qr_ItensPro: TSTQuery;
    Qr_Pedido: TSTQuery;
    QRShape15: TQRShape;
    QRShape6: TQRShape;
    Lb_Assinatura: TQRLabel;
    Lb_LocalData: TQRLabel;
    QRLabel2: TQRLabel;
    Lb_NomeVendedor: TQRLabel;
    QRBand2: TQRBand;
    QRLabel6: TQRLabel;
    E_Obs: TQRMemo;
    QRLabel10: TQRLabel;
    Lb_Cli_Complemento: TQRLabel;
    QRLabel14: TQRLabel;
    Lb_Cli_Contato: TQRLabel;
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
    Procedure PC_ValidaProdutos(Pc_Print : Boolean);
    Procedure PC_PreencheProdutos;
    Procedure PC_ValidaServicos(Pc_Print : Boolean);
    Procedure PC_PreencheServicos;
    procedure Pc_Rodape;
    procedure Pc_IniciaVariaveis;
  end;

var
  RL_PedidoVenda_5: TRL_PedidoVenda_5;

implementation

uses     Un_DM, UN_Sistema, Un_Regra_Negocio;
{$R *.dfm}



procedure TRL_PedidoVenda_5.Pc_PreencheCliente;
begin
  with Qr_Pedido do
    Begin
    Lb_Cli_Nome.Caption     := FieldByName('EMP_NOME').AsString;
    Lb_Cli_Codigo.Caption   := FieldByName('PED_CODEMP').AsString;
    Lb_Cli_Endereco.Caption := FieldByName('END_ENDER').AsString + ', ' + FieldByName('END_NUMERO').AsString;
    Lb_Cli_cep.Caption      := fc_MascaraCep(FieldByName('END_CEP').AsString);
    Lb_Cli_FoneC.Caption    := fc_MascaraFone(FieldByName('END_FONE').AsString);
    Lb_Cli_Complemento.Caption := FieldByName('END_COMPLEM').AsString;
    Lb_Cli_Contato.Caption     := FieldByName('END_CONTATO').AsString;
    Lb_Cli_bairro.Caption   := FieldByName('END_BAIRRO').AsString;
    Lb_Cli_Cidade.Caption   := FieldByName('CDD_DESCRICAO').AsString;
    Lb_Cli_Fax.Caption      := fc_MascaraFone(FieldByName('END_FAX').AsString);
    if Length(FieldByName('EMP_CNPJ').AsString)=11 then
      Begin
      Lb_CNPJ.Caption := 'C.P.F: ';
      Lb_Ie.Caption   := 'Identidade: ';
      Lb_Cli_Cnpj.Caption   := fc_MascaraCPF(FieldByName('EMP_CNPJ').AsString);
      end
    else
      Begin
      Lb_CNPJ.Caption := 'C.N.P.J: ';
      Lb_Ie.Caption   := 'Insc. Estadual :';
      Lb_Cli_Cnpj.Caption   := fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString);
      end;
    Lb_Cli_IncEst.Caption := FieldByName('EMP_INSC_EST').AsString;
    Lb_Cli_Celular.Caption := fc_MascaraFone(FieldByName('END_CELULAR').AsString);
    end;
end;


Procedure TRL_PedidoVenda_5.PC_ValidaServicos(Pc_Print : Boolean);
Begin
  if Pc_Print then
    BEgin
    Lb_Cd_Servico.Font.Style := [];
    Lb_Descricao_Srv.Font.Style := [];
    Lb_SubVl_Srv.Font.Style := [];

    Lb_Cd_Servico.Alignment := taLeftJustify;
    Lb_Descricao_Srv.Alignment := taLeftJustify;
    Lb_SubVl_Srv.Alignment := taRightJustify;

    Lb_Cd_Servico.Font.Color := clBlack;
    Lb_Descricao_Srv.Font.Color := clBlack;
    Lb_SubVl_Srv.Font.Color := clBlack;
    end
  else
    BEgin
    Lb_Cd_Servico.Font.Color := clWhite;
    Lb_Descricao_Srv.Font.Color := clWhite;
    Lb_SubVl_Srv.Font.Color := clWhite;
    end;
end;

Procedure TRL_PedidoVenda_5.PC_PreencheServicos;
Begin
  Lb_Cd_Servico.Caption := Qr_ItensSrv.FieldByname('PRO_CODIGO').AsString;
  Lb_Descricao_Srv.Caption := Qr_ItensSrv.FieldByname('PRO_DESCRICAO').AsString;
  Lb_SubVl_Srv.Caption := FloatToStrf(Qr_ItensSrv.FieldByname('ITF_VL_SUBTOTAL').AsCurrency,ffFixed,10,2);
  It_Vl_Servico := It_Vl_Servico + Qr_ItensSrv.FieldByname('ITF_VL_SUBTOTAL').AsCurrency;
end;

Procedure TRL_PedidoVenda_5.PC_VAlidaProdutos(Pc_Print : Boolean);
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

Procedure TRL_PedidoVenda_5.PC_PreencheProdutos;
Var
  LcValor : Real;
Begin
  Lb_Codigo_Pro.Caption := Qr_ItensPro.FieldByname('PRO_CODIGOFAB').AsString;
  Lb_Descricao_Pro.Caption := Qr_ItensPro.FieldByname('PRO_DESCRICAO').AsString;
  Lb_Qtde_Pro.Caption := formatFloat('#,##0.###',Qr_ItensPro.FieldByName('ITF_QTDE').AsFloat);
  Lb_VlUnit_Pro.Caption := FloatToStrf(Qr_ItensPro.FieldByname('ITF_VL_UNIT').AsCurrency,ffFixed,10,2);
  LcValor := Qr_ItensPro.FieldByName('ITF_QTDE').AsFloat * Qr_ItensPro.FieldByName('ITF_VL_UNIT').AsCurrency;
  LcValor := RoundTo(LcValor,-2);
  Lb_SubVl_Pro.Caption := FloatToStrf(LcValor,ffFixed,10,2);
  It_Vl_Produto := It_Vl_Produto + LcValor;
end;


procedure TRL_PedidoVenda_5.Pc_Rodape;
begin
  with Qr_Pedido do
    Begin
    Lb_TipoCob.Caption      := FieldByname('FPT_DESCRICAO').AsString + ' - ' + FieldByname('PED_PRAZO').AsString;
    Lb_Vl_Servico.Caption   := FloattoStrf(It_Vl_Servico,ffFixed,10,2);
    Lb_Vl_Pecas.Caption     := FloattoStrf(It_Vl_Produto,ffFixed,10,2);
    Lb_Vl_SubTotal.Caption  := FloattoStrf(It_Vl_Servico +  It_Vl_Produto,ffFixed,10,2);
    Lb_Vl_Desconto.Caption  := FloattoStrf(It_vl_Desconto ,ffFixed,10,2);
    Lb_Vl_Total.Caption     := FloattoStrf(It_Vl_Servico + It_Vl_Produto - It_vl_Desconto,ffFixed,10,2);
    E_Obs.Lines.Text        := FieldByname('PED_OBS').AsString;


    Lb_NomeVendedor.Caption := FieldByname('CLB_NOME').AsString;
    Lb_LocalData.Caption    := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + '   ______/______/___________ ';
    Lb_Assinatura.Caption   := FieldByname('EMP_NOME').AsString;
    end;
end;

procedure TRL_PedidoVenda_5.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_AtivaEstabelecimento;
  Pc_IniciaVariaveis;
  Pc_PreencheCliente;
end;


procedure TRL_PedidoVenda_5.Pc_IniciaVariaveis;
Var
  Lc_I : Integer;
Begin
  It_Vl_Servico := 0;
  It_Vl_Produto := 0;
  It_vl_Desconto := 0;
  It_Cab_Pro := True;
  It_Cab_Srv := True;
  //Esabelecimento
  Pc_AtivaEstabelecimento;

  //Pedido
  Qr_Pedido.Active := False;
  Qr_Pedido.ParamByName('PED_CODIGO').AsInteger := It_Codigo;
  Qr_Pedido.Active := True;
  Qr_Pedido.FetchAll;
  Qr_Pedido.RecordCount;
  Qr_Pedido.First;
  It_vl_Desconto := Qr_Pedido.FieldByname('PED_VL_DESCONTO').AsCurrency;

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
  Lb_Cli_Pedido.Caption := Qr_Pedido.FieldByName('PED_NUMERO').AsString;
  if Qr_Pedido.FieldByname('PED_FATURADO').AsString = 'S' then
    Begin
    Lb_Titulo.Caption := 'REVIS�O O.S:';
    Lb_Cli_Data.Caption := Qr_Pedido.FieldByname('PED_DATA').AsString + ' - ' + TimetoStr(Time) + ' hs';
    end
  else
    Begin
    Lb_Titulo.Caption := 'ORDEM DE SERVI�O :';
    Lb_Cli_Data.Caption := Qr_Pedido.FieldByname('PED_DT_ALTERA').AsString + ' hs';
    end;
end;
procedure TRL_PedidoVenda_5.RodapeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_Rodape;
end;

procedure TRL_PedidoVenda_5.StrB_ServicoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if It_Cab_Srv then
    Begin
    Lb_Cd_Servico.Font.Color := clBlack;
    Lb_Descricao_Srv.Font.Color := clBlack;
    Lb_SubVl_Srv.Font.Color := clBlack;

    Lb_Cd_Servico.Font.Style := [fsBold];
    Lb_Descricao_Srv.Font.Style := [fsBold];
    Lb_SubVl_Srv.Font.Style := [fsBold];

    Lb_Cd_Servico.Caption := 'Cd Serviço';
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

procedure TRL_PedidoVenda_5.StrB_ProdutoBeforePrint(Sender: TQRCustomBand;
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
