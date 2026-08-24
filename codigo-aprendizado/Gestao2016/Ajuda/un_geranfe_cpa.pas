unit un_geranfe_cpa;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, tas_gera_nfe_autorizacao, Vcl.Menus, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Data.DB, STQuery, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, ControllerCustoPedido, Vcl.AppEvnts, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, STDataSet;

type
  TFr_geranfe_cpa = class(TTasGeraNfeAutorizacao)
  private
    { Private declarations }
  protected
    function ValidaCancelamentoNotas: Boolean;Override;
    procedure Pc_CancelaNFe_Pendente;Override;
    procedure Iniciavariaveis;Override;

  public
    { Public declarations }
  end;

var
  Fr_geranfe_cpa: TFr_geranfe_cpa;

implementation

{$R *.dfm}

uses     UN_Sistema, RN_Permissao, UN_Principal, Un_DM, Un_Regra_Negocio, RN_Compras, Un_Msg, env, Un_Fc_Sored_Procedures;

{ TFr_geranfe_cpa }


function TFr_geranfe_cpa.ValidaCancelamentoNotas: Boolean;
begin
  Result := True;
  MM_Acompanhamento.Lines.Clear;
  MM_Acompanhamento.Lines.Add('Validando o cancelamento...');

  if not validaCancelaCarregarNota then
  Begin
    Result := False;
    Exit;
  end;

  if not Fc_VerificaPermissao('Fr_GeraNFe', 'Cancelar Nota Fiscal', 'CANCELAR',
    GB_Cd_Usuario, 'S') then
  Begin
    Result := False;
    Exit;
  end;

  // Verifica Inventario
  if not validaCancelaInventario then
  Begin
    Result := False;
    Exit;
  end;

  if not validaCancelaFinanceiro then
  Begin
    Result := False;
    Exit;
  end;

  if not validaCancelaLote then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                    'Existe lote desta nota que já foi utilizado.' + EOLN +
                    'Não é possível cancelar' + EOLN, ['OK'], [bEscape],
                    mpAlerta);
    Result := False;
    Exit;
  end;

  if not It_Nf_Terceiro then
  Begin
    If (Qr_RetornoNFe.REcordCount > 0) then
    Begin
      if (Qr_Nota.FieldByName('NFL_NUMERO').AsString <> '') and (Qr_Itens.RecordCount > 0) then
      Begin
        Pc_ConsultaNFe;
      End;
    End;
  End;
end;

procedure TFr_geranfe_cpa.Pc_CancelaNFe_Pendente;
var
  Lc_nfl_tipo: String;
  Lc_CustoPedido : TControllerCustoPedido;
Begin
  Try
    Lc_CustoPedido := TControllerCustoPedido.create(nil);
    IF (Qr_Nota.FieldByName('NFL_TIPO').AsString = 'SC') or (Qr_Nota.FieldByName('NFL_TIPO').AsString = 'EC') THEN  // diferente de  COMPLEMENTAR
      Lc_nfl_tipo := 'C' // complementar
    else
      Lc_nfl_tipo := 'N';

    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    if Lc_nfl_tipo = 'N' then
    Begin
      //Foi retirado por que para cancelar deve cancelar a baixa no caixa/banco e o o novo metodo de cancelamento do caixa não apaga o movimento
      Financeiro.Clear;
      Financeiro.Registro.CodigoNota := It_Cd_Nota;
      Financeiro.deleteByNota;

      Pc_EstornaCustoCompra(Qr_Nota.FieldByName('PED_TIPO').AsInteger, Qr_Itens);
      Pc_DeleteREgistroCustos(Qr_Nota.FieldByName('PED_TIPO').AsInteger, It_Cd_Pedido);

      NotaFiscal.Registro.Codigo := It_Cd_Nota;
      NotaFiscal.ApagarImpostos;

      Pc_ApagaRetornoNFE(It_Cd_Nota);
      Pc_ApagaObservacao(It_Cd_Nota);

      NotaFiscal.Delete;

      NotaFiscal.AtualizaSeries(Qr_Nota.FieldByName('NFL_TIPO').AsString, Qr_Itens);
      Pc_AtualizarItensNota(Qr_Nota.FieldByName('NFL_TIPO').AsString, 'PENDENTE', It_Cd_Nota, It_Cd_Pedido, Qr_Itens);

      Pc_AtualizacaoEstoqueNota('PENDENTE', Qr_Nota.FieldByName('PED_TIPO').AsInteger, Qr_Nota.FieldByName('PED_CODIGO').AsInteger);

      if NotaFiscal.Registro.XMLImportado = 'S' then
        DeleteLote;

      NotaFiscal.Pedido.Registro.Codigo   := It_Cd_Pedido;
      NotaFiscal.Pedido.Registro.Faturado := 'N';
      NotaFiscal.Pedido.alteraStatus;
    END
    ELSE
    BEGIN
      cancelaNotaComplementar;
    END;
    //Delete os custos da tabela Tb_Custo_Pedido
    Lc_CustoPedido.Registro.CodigoPedido := It_Cd_Pedido;
    Lc_CustoPedido.deleteOrigensAutomatica;
  Finally
    FreeAndNil(Lc_CustoPedido);
    Pc_Log_Sistema( Gb_CodMha,
                    GB_Cd_Usuario,
                    (Now),
                    'Operações NF-e - Compras/Importação',
                    Qr_Nota.FieldByName('PED_CODIGO').AsInteger,
                    'Cancelamento NF-e',
                    concat('PEDIDO: ',Qr_Nota.FieldByName('PED_NUMERO').AsString ));
    //Finaliza com mensagem
    MensagemPadrao(MENSAGEM, 'S U C E S S O !.' + EOLN + EOLN +
                   'Nota Fiscal Cancelada com Sucesso.' + EOLN +
                   '  Clique em OK para continuar.' + EOLN, ['OK'], [bEscape], mpInformacao);

  End;

end;


procedure TFr_geranfe_cpa.IniciaVariaveis;
begin
  inherited;
  if It_Nf_Terceiro or (Fc_Tb_Geral('L','CPA_G_OPER_COMPRA_NFE','S') <> 'S') then
  BEgin
    Sb_NF_Conferir.Visible := False;
    Sb_NF_Autorizar.Visible := False;
    Sb_NF_Consultar.Visible := False;
    Sb_NF_Envia.Visible := False;
  End;
end;


end.
