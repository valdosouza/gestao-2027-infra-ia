unit Un_PizzariaImpressao;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Un_Cupom_Fiscal, tributacao, ControllerRestaurante, ACBrTEFD, Actions, Vcl.ActnList, QEdit_Setes, Vcl.DBCtrls, Vcl.Touch.Keyboard, Un_Fm_MetodoPagamento, ControllerBase;

type
  TFr_PizzariaImpressao = class(TFr_Cupom_Fiscal)
    ChBx_Sache: TCheckBox;
    ChBx_Fatiada: TCheckBox;
    ChBx_Palito: TCheckBox;
    ChBx_Cozinha: TCheckBox;
    procedure Sb_ConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    function PedidoWEbAlterado(PedidoId:Integer):Boolean;
    Procedure Pc_MontaParcelamento;
    Procedure Pc_MontaFormaPagamentoWeb;
    procedure Pc_Inicia_Variaveis;override;
  public
    { Public declarations }

    procedure Imprime;
    procedure EnvioWhatsApp;
  end;

var
  Fr_PizzariaImpressao: TFr_PizzariaImpressao;

implementation

{$R *.dfm}

uses     Un_DM, Un_Regra_Negocio, Un_Fm_FormaPagto, Un_Msg, Un_Sistema, PrintPizzaria, UN_Principal, env, WhatsApp, PagamentoEscolhido;
procedure TFr_PizzariaImpressao.EnvioWhatsApp;
Var
  LcEnviaWhats : TThread;
begin
  if ( Fc_Tb_Geral('L','WTA_LC_ATIVO','N') = 'S') then
  Begin
    LcEnviaWhats := TThread.CreateAnonymousThread(
      procedure
      Var
        LcW : TWhatsApp;
      begin

      end
    );
    LcEnviaWhats.FreeOnTerminate := True;
    LcEnviaWhats.Start;
  End;
end;

procedure TFr_PizzariaImpressao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F2 : if Self.Enabled then Sb_NovaFormaPagtoClick(Sender);
      VK_ESCAPE : if Self.Enabled then Sb_CancelarClick(Sender);
      VK_F10 : if Self.Enabled then Sb_ConfirmaClick(Sender);
    end;
  end;
end;

procedure TFr_PizzariaImpressao.Imprime;
Var
  Lc_Imp : TPrintPizzaria;
  //Novos
  variavel : TComponent;
  Lc_Edit: TEdit;
  Lc_Valor :real;
  Lc_Dblookup : TDBLookupComboBox;
  Lc_cd_Forma_Pagto : Integer;
  MetodoPagamento : TFm_FormaPagto;
  I : Integer;
  LcPagEscolhido : TPagamentoEscolhido;
begin
  Pnl_Caixa.Caption := 'Iniciando as impressões...';
  Application.ProcessMessages;
  Lc_Imp := TPrintPizzaria.Create(nil);
  Lc_Imp.FormaPagto.Clear;

  for I := 0 to It_CodigoFPagto.Count - 1 do
  begin
    //Encontrar os campos para pegar os valores
    variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
    //Encontra o valor a receber
    Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
    Lc_Valor := (StrToFloatDef(Lc_Edit.Text,0));
    if (Lc_Valor > 0) then
    Begin
      //Encontra a forma de pagamento
      MetodoPagamento := TFm_FormaPagto(Fc_LocalizaComponente(variavel,TFm_FormaPagto));
      Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(MetodoPagamento,TDBLookupComboBox));
      //Preenche uma Lista
      LcPagEscolhido := TPagamentoEscolhido.Create;
      LcPagEscolhido.Forma := Lc_Dblookup.Text;
      LcPagEscolhido.Valor := StrToFloatDef(Lc_Edit.Text,0);
      Lc_Imp.FormaPagto.Add(LcPagEscolhido);
    End;
  end;



  with Lc_Imp do
  Begin
    CodigoConsumidor := It_Cd_Consumidor;
    Estabelecimento := Gb_CodMha;
    CodigoPedido := Self.It_Cd_Pedido;
    NomeEstabelecimento := DM.Qr_Estabelecimento.FieldByNAme('EMP_FANTASIA').AsString;
    FoneEstabelecimento := DM.Qr_Estabelecimento.FieldByNAme('END_FONE').AsString;
    NomeUsuario := GB_Nm_Usuario;
    ModeloImpressao := StrToIntdef(Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_P_IMPRESSORA','0'),0);
    case ModeloImpressao of
      0:ModeloMatricial := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_P_MOD_MATRICIAL', '1'),0);
      1:ModeloTermica   := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_P_MOD_TERMICA', '1'),0);
    end;
    Sache := ChBx_Sache.Checked;
    Fatiado := ChBx_Fatiada.Checked;
    Palito := ChBx_Palito.Checked;
    ValorRecebido := E_VL_Recebido.Text;
    ValorTroco := E_VL_Troco.Text;

    Pnl_Caixa.Caption := 'Imprimindo Cupom Principal...';
    Application.ProcessMessages;
    PrintModeloPrincipal;
    if ChBx_Cozinha.Checked then
    Begin
      Pnl_Caixa.Caption := 'Imprimindo Cupom para a Cozinha...';
      Application.ProcessMessages;
      PrintModeloCozinha;
    End;
  end;
  FreeAndNil(Lc_Imp);
  Pnl_Caixa.Caption := 'Impressão Finalizada...';
  Fechar := True;
  Application.ProcessMessages;
end;


procedure TFr_PizzariaImpressao.Pc_Inicia_Variaveis;
Var
  LcTxPayBack : Real;
  Lc_LiberaDigitacao : Boolean;
begin
  inherited;
  LcTxPayBack := StrToFloatDef(Fc_Tb_Geral('L','PAYBACK_TAXA','0'),0);
  if (( PEdido.Registro.Faturado = 'S') and (LcTxPayBack > 0)) or (PEdido.Registro.CodigoWeb > 0) then
  BEgin
    Pc_LimpaParcelamento;
    if (PEdido.Registro.CodigoWeb = 0) then
    Begin
      Pc_MontaParcelamento;
    End
    else
    Begin
      Pc_MontaFormaPagamentoWeb;
    End;
    Lc_LiberaDigitacao :=  PedidoWEbAlterado(PEdido.Registro.Codigo);
    Scx_Parcela.Enabled := Lc_LiberaDigitacao;
    Grp_Pagamento.Enabled := Lc_LiberaDigitacao;
    Pc_Totalizar;
  End;
end;

procedure TFr_PizzariaImpressao.Pc_MontaFormaPagamentoWeb;
Var
  Lc_Qry : TSTQuery;
  Lc_I : integer;
  Lc_Valor : real;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'SELECT fp.fpt_descricao,pd.ped_vl_pedido, ',
                're.value_recived, re.value_change ',
                'FROM tb_pedido pd ',
                '  INNER JOIN TB_FORMAPAGTO fp ',
                '  ON (pd.ped_codfpg = fp.fpt_codigo) ',
                '  inner join tb_restaurante re ',
                '  on (re.tb_pedido_id = pd.ped_codigo) ',
                'WHERE pd.ped_codigo=:ped_codigo '
      ));

      ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
      Active := True;
      FetchAll;
      while not eof do
      Begin
        It_CodigoFPagto.Add( IntToStr( It_CodigoFPagto.Count + 1 ) );
        Pc_CriarFrame(FieldByName('FPT_DESCRICAO').AsString,
                      FieldByName('value_recived').AsFloat,
                      95);
        Next;
      End;
     e_vl_recebido.Text := FloatToStrF(FieldByName('value_recived').AsFloat,ffFixed,10,2);
     E_VL_Troco.Text := FloatToStrF(FieldByName('value_change').AsFloat,ffFixed,10,2);
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_PizzariaImpressao.Pc_MontaParcelamento;
Var
  Lc_Qry : TSTQuery;
  Lc_I : integer;
  Lc_Valor : real;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'SELECT fp.fpt_descricao,fn.fin_vl_parcela ',
                'FROM tb_financeiro fn ',
                '  INNER JOIN TB_FORMAPAGTO fp ',
                '  ON (fn.fin_codfpg = fp.fpt_codigo) ',
                'WHERE fn.fin_codped=:PED_CODIGO '
      ));

      ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
      Active := True;
      FetchAll;
      while not eof do
      Begin
        It_CodigoFPagto.Add( IntToStr( It_CodigoFPagto.Count + 1 ) );
        Pc_CriarFrame(FieldByName('FPT_DESCRICAO').AsString,
                      FieldByName('FIN_VL_PARCELA').AsCurrency,
                      95);
        Next;
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;


end;

function TFr_PizzariaImpressao.PedidoWEbAlterado(PedidoId:Integer): Boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select ped_codigo ',
                'from tb_pedido p ',
                '   inner join tb_log_operacao lo ',
                '   on (lo.log_registro = p.ped_codigo) ',
                'where p.ped_codweb > 0 ',
                ' and ped_codigo =:PED_CODIGO ',
                ' AND PED_FATURADO = ''N'' ',
                'and lo.log_operacao = ''Alteração Pedido Aplicativo'' '
      ));
      ParamByName('PED_CODIGO').AsInteger := PedidoId;
      Active := True;
      FetchAll;
      Result := (RecordCount > 0);


    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;

end;

procedure TFr_PizzariaImpressao.Sb_ConfirmaClick(Sender: TObject);
begin
  if Valida then
  Begin
    try
      Pc_ProcesoAguarde(Self,'I');
      Self.Enabled := False;
      Fechar := False;
      if ( ( Fc_Tb_Geral('L','PIZ_AUTO_FATURA_ENTREGA','S') = 'S' ) and ( PEdido.Registro.TipoContato = '0') ) OR
         ( ( Fc_Tb_Geral('L','PIZ_AUTO_FATURA_BALCAO','N') = 'S' )  and ( PEdido.Registro.TipoContato = '1') ) OR
         ( ( Fc_Tb_Geral('L','PIZ_AUTO_FATURA_MESA','N') = 'S' )    and ( PEdido.Registro.TipoContato = '2') ) then
      Begin
        if PEdido.Registro.Faturado = 'N' then
        Begin
          Pc_Executar;
        End;
      End;
      Pc_AtivaEstabelecimento;
      Imprime;
      EnvioWhatsApp;
    finally
      Pc_ProcesoAguarde(Self,'F');
      Self.Enabled := True;
      if Fechar then
        Self.Close;
    end;
  End;
end;

end.
