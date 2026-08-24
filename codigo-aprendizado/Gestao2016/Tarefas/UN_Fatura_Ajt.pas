unit UN_Fatura_Ajt;
{04-06-2019 - testando todas as criações como Self e deixar o owner cuidar da limpeza}
interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, System.Math, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Printers, ControllerCtrlEstoque, QEdit_Setes, tributacao, ControllerDevolIPI, ControllerBase, Actions, Vcl.ActnList, Vcl.DBCtrls, Vcl.ComCtrls, base_frame_list, un_fm_lista_cfop;


type
  TFr_Fatura_Ajt = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    PrintDialog1: TPrintDialog;
    Label9: TLabel;
    E_Obs: TMemo;
    E_M_Fisco: TMemo;
    RG_Tipo_S_E: TRadioGroup;
    GroupBox4: TGroupBox;
    E_Dt_Emissao: TDateTimePicker;
    E_Dt_Saida: TDateTimePicker;
    Panel4: TPanel;
    ChBx_Retorno: TCheckBox;
    ChBx_Baixa: TCheckBox;
    Label22: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    E_Vl_Bs_Icms_St: TEdit_Setes;
    E_Vl_Icms_St: TEdit_Setes;
    E_Vl_Seguro: TEdit_Setes;
    E_Vl_Outras: TEdit_Setes;
    E_VL_Produto: TPanel;
    E_VL_ICMS: TEdit_Setes;
    E_VL_Bs_ICMS: TEdit_Setes;
    E_VL_IPI: TEdit_Setes;
    E_VL_Frete: TEdit_Setes;
    Label10: TLabel;
    E_Qt_Produto: TEdit_Setes;
    E_RNTC: TEdit;
    E_Marca: TEdit;
    Label12: TLabel;
    E_Vol_Numero: TEdit;
    E_VL_Nota: TPanel;
    Label5: TLabel;
    Label11: TLabel;
    Label34: TLabel;
    Label39: TLabel;
    E_Vl_desconto: TPanel;
    GroupBox5: TGroupBox;
    Label7: TLabel;
    Label33: TLabel;
    DBLCB_Transportadora: TDBLookupComboBox;
    Dblcb_Modal_Frete: TDBLookupComboBox;
    Ds_Moral_Frete: TDataSource;
    chbx_data_saida: TCheckBox;
    Label35: TLabel;
    Label36: TLabel;
    Label38: TLabel;
    Label37: TLabel;
    Label4: TLabel;
    E_Especie: TEdit;
    E_PesoLiq: TEdit_Setes;
    E_PesoBruto: TEdit_Setes;
    E_PlacaVeiculo: TMaskEdit;
    E_Uf_Veiculo: TDBLookupComboBox;
    GroupBox6: TGroupBox;
    Lb_Controle: TLabel;
    Rb_Ctrl_Pedido: TRadioButton;
    Rb_Ctrl_Nf: TRadioButton;
    E_DocVinculado: TEdit_Setes;
    Panel3: TPanel;
    Label3: TLabel;
    Chbx_Financeiro: TCheckBox;
    ChBx_AutorizacaoNFE: TCheckBox;
    ChBx_SomaICMS: TCheckBox;
    ChBx_Nota_Manual: TCheckBox;
    Chbx_SomaIPI_Bs_ICMS: TCheckBox;
    Chbx_SomaIPI_Bs_ICMS_St: TCheckBox;
    ChBx_DevolucaoMercadoria: TCheckBox;
    Chbx_NaoAtualizarEstoque: TCheckBox;
    ChBx_Distribuir_ICMS: TCheckBox;
    ChBx_Distribuir_ICMS_ST: TCheckBox;
    ChBx_Distribuir_IPI: TCheckBox;
    chbx_Mva_Original: TCheckBox;
    ChBx_ListaNcm: TCheckBox;
    Sb_Pesq_Cliente: TSpeedButton;
    Sb_Transportadora: TSpeedButton;
    Label1: TLabel;
    E_vIPIDevolv: TPanel;
    AcaoMostra: TActionList;
    Action1: TAction;
    chbx_Cancela_fora_prazo: TCheckBox;
    Fm_lista_cfop: TFm_lista_cfop;
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLCB_TransportadoraKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_TransportadoraClick(Sender: TObject);
    procedure ChBx_RetornoClick(Sender: TObject);
    procedure ChBx_BaixaClick(Sender: TObject);
    procedure Rg_TipoDocClick(Sender: TObject);
    procedure RG_Tipo_S_EClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Rb_Ctrl_PedidoClick(Sender: TObject);
    procedure E_DocVinculadoKeyPress(Sender: TObject; var Key: Char);
    procedure Rb_Ctrl_NfClick(Sender: TObject);
    Procedure Pc_Controla_retorno;
    procedure E_Qt_ProdutoChange(Sender: TObject);
    procedure ChBx_AutorizacaoNFEClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Sb_Pesq_ClienteClick(Sender: TObject);

  private
    { Private declarations }
      It_Usa_Nfe : Boolean;
     Tributacao : ttributacao;
   public
    { Public declarations }
    It_Cd_Pedido: Integer;
    It_Cd_Pedido_Devolvido: Integer;
    It_Nr_Pedido: String;
    It_Dt_Pedido : String;
    It_Oper_Estoque : String;
    It_Fatura_Ok : boolean;

    //Controla entrada ou saida conforme a informação de serie ou Loe
    It_Operacao : Integer;
    procedure Pc_AtivarTabela;


    Procedure Pc_ImprimeCupom;
    Procedure Pc_Gera_Financeiro;
    function  Fc_ConfirmaValores():boolean;

    procedure Pc_Inicia_Variaveis;
    procedure Pc_FormataTela;


    function Fc_ValidaFaturamento(): Boolean;


    function Fc_Faturar():Boolean;
    function  Fc_validacao_retorno:Boolean;
    Function Fc_VerificaItemDevolvido(Fc_Nr_Pedido:String):Boolean;
    Function VerificaExistenciaDevolvido(Fc_Nr_Pedido:String):Boolean;
    procedure Pc_MarcaProdutoDevolvido(Pc_Cd_Pedido_Devolvido:Integer);
    procedure Pc_GeraComissaoNegativaDevolucao(Pc_Cd_Pedido_Devolvido:Integer);
    Procedure Pc_Estoque(Pc_Itens:TSTQuery);
    procedure Pc_Faturar_Ajuste;
    procedure Pc_ImagemBotao;
    procedure Pc_CarregaComponenteTributacao;
    procedure Pc_VerificaSeAtualizarEstoque;
  end;

var
  Fr_Fatura_Ajt: TFr_Fatura_Ajt;

implementation


uses     Un_DM, Un_Msg, Un_Funcoes, UN_Sistema, UN_NF, Un_Liberacao, Un_Fc_Sored_Procedures, un_Padrao, Un_Imp_Mod_Impressao, Un_Transportadora, Un_Regra_Negocio, UN_Principal, env, RN_Inventario, RN_Estoque, RN_Financeiro, RN_NotaFiscal, RN_Transportadora, RN_FormaPagto, RN_Permissao, RN_Pedido, RN_Produto, RN_NotaFiscalEletronica3X, RN_Crud, UN_TabelasEmListas, RN_Empresa, tas_gera_nfe_autorizacao, un_geranfe_ajt;
{$R *.dfm}

procedure TFr_Fatura_Ajt.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
    CarregaImagemBotao(SB_Sair_0,'SAIR');
  END;
end;

procedure TFr_Fatura_Ajt.Pc_CarregaComponenteTributacao;
Begin
  with Tributacao do
  Begin
    estabelecimento.Registro.Codigo := Gb_CodMha;
    NotaFiscal.Pedido.Registro.Codigo := Self.It_Cd_Pedido;
    NotaFiscal.Clear;
    with NotaFiscal.Registro do
    Begin
      CodigoEstabelecimento := Gb_CodMha;
      CodigoPedido :=  Self.It_Cd_Pedido;
      DataEmissao := E_Dt_Emissao.Date;
      if chbx_data_saida.Checked then
        DataSaida := E_Dt_Saida.Date
      else
        DataSaida := 0;
      if chbx_Cancela_fora_prazo.Checked then
      Begin
        Finalidade := '3';
      End
      else
      Begin
        if (pos('DEVOLUCAO',upper(Fm_lista_cfop.Dblcb_Lista.Text)) > 0) or
           (pos('DEVOLUÇÃO',upper( Fm_lista_cfop.Dblcb_Lista.Text)) > 0) then
        begin
          Finalidade := '4';
        end
        else
        Begin
          Finalidade := '1';
        end;
      End;

      if Trim(DBLCB_Transportadora.Text) <> '' then
        CodigoTransportadora := DBLCB_Transportadora.KeyValue
      else
        CodigoTransportadora := 0;
      if Trim(Dblcb_Modal_Frete.Text) <> '' then
        ContaFrete := Dblcb_Modal_Frete.KeyValue
      else
        ContaFrete := 0;
     End;
    if Fm_lista_cfop.Chbx_cfop.Checked then
      It_Cd_Natureza := Fm_lista_cfop.Dblcb_Lista.KeyValue;

    It_AutorizacaoNFE := ChBx_AutorizacaoNFE.Checked;
    It_AutorizacaoNFCE := False;
    It_AutorizacaoNFSE := False;
    It_SomaICMSNaNota := ChBx_SomaICMS.Checked;
    it_SomaIPI_Bs_ICMS := Chbx_SomaIPI_Bs_ICMS.Checked;
    It_SomaIPI_Bs_ICMS_St := Chbx_SomaIPI_Bs_ICMS_St.Checked;
    UtilizarMvaOrginal := chbx_Mva_Original.Checked;
    It_Dist_Icms_NR := ChBx_Distribuir_ICMS.Checked;
    It_Dist_Icms_ST := ChBx_Distribuir_ICMS_ST.Checked;
    It_Dist_IPI := ChBx_Distribuir_IPI.Checked;
    It_ValidaListaNCM := ChBx_ListaNcm.Checked;
    It_RevendaCarro := (Fc_Tb_Geral('L','PRO_G_LABEL_PRO','')='S');
    IF RG_Tipo_S_E.ItemIndex = 0 then
      It_Sentido := 'S'
    else
      It_Sentido := 'E';
    It_Tipo_OPer := 'A';
    It_Aq_Cred_Icms := StrtoFloatDef(Fc_Tb_Geral('L','GRL_G_AQ_CRED_ICMS','0'),0);
    It_Decreto108352014 :=(Fc_Tb_Geral('L','GRL_G_DECRETO108352014','N') = 'S');
    Tributacao.Pc_CriaConsultas;
    Tributacao.Pc_Pedido;
    with It_Nfe.NotasFiscais[0].NFe do
    Begin
      //Valor do Base do Icms
      Total.ICMSTot.vBC := StrToFloatDef(E_VL_Bs_ICMS.Text, 0);
      //Valor do ICMS
      Total.ICMSTot.vICMS := StrToFloatDef(E_Vl_Icms.Text, 0);
      //Valor do Base do Icms ST
      Total.ICMSTot.vBCST := StrToFloatDef(E_Vl_Bs_Icms_St.Text, 0);
      //Valor do ICMS St
      Total.ICMSTot.vST := StrToFloatDef(E_Vl_Icms_St.Text, 0);
      //Valor do Produto
      Total.ICMSTot.vprod := StrToFloatDef(E_VL_Produto.Caption, 0);
      //Valor do Frete
      Total.ICMSTot.vFrete := StrToFloatDef(E_VL_Frete.Text, 0);
      //Valor do Seguro
      Total.ICMSTot.vSeg := StrToFloatDef(E_Vl_Seguro.Text, 0);
      //Valor das outras despesas
      Total.ICMSTot.vOutro := StrToFloatDef(E_Vl_Outras.Text, 0);
      //Valor do IPI
      Total.ICMSTot.vIPI := StrToFloatDef(E_VL_IPI.Text, 0);
    end;
    It_Qt_Produto := StrToFloatDef(E_Qt_Produto.Text,0);
    It_Especie := E_Especie.Text;
    It_PesoBruto := E_PesoBruto.Text;
    It_PesoLiquido := E_PesoLiq.Text;
    It_PlacaVeiculo := E_PlacaVeiculo.Text;
    It_Uf_Veiculo := E_Uf_Veiculo.Text;
    It_RNTC := E_RNTC.Text;
    It_Marca := E_Marca.Text;
    It_Volume := E_vol_Numero.Text;
    It_Despachar := Fc_Tb_Geral('L','DSP_G_CTRL_DESPACHO','N');
  end;


end;

Procedure TFr_Fatura_Ajt.Pc_MarcaProdutoDevolvido(Pc_Cd_Pedido_Devolvido:Integer);
Var
  Lc_Qry:TSTQuery;
  Lc_Upd:TSTQuery;
Begin
  Try
    Lc_Qry := TSTQuery.Create(Self);
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IBT_Faturamento;

    lC_Upd := TSTQuery.Create(Self);
    lC_Upd.Database := DM.IBD_Gestao;
    lC_Upd.Transaction := DM.IBT_Faturamento;

    //Seleciona o item do pedido devolvido para a atualizar depois
    Lc_Qry.Active := False;
    Lc_Qry.SQL.Clear;
    Lc_Qry.SQL.Add('SELECT ITF_CODIGO '+
                    'FROM TB_PEDIDO '+
                    '  INNER JOIN TB_ITENS_NFL '+
                    '  ON (ITF_CODPED = PED_CODIGO) '+
                    'WHERE (PED_CODIGO=:PED_CODIGO) '+
                    '  AND (PED_TIPO =:PED_TIPO) '+
                    '  AND (ITF_CODPRO = :ITF_CODPRO) ');
    //Cria o SQL para atualizar o item devolvido
    Lc_Upd.Active := False;
    Lc_Upd.Transaction := DM.IBT_Faturamento;
    Lc_Upd.SQL.Clear;
    Lc_Upd.SQL.Add('INSERT INTO TB_ITENS_DEV( '+
                   '  ITD_CODITF_ORIG, '+
                   '  ITD_CODITF_DEST) '+
                   'VALUES( '+
                   ' :ITD_CODITF_ORIG, '+
                   ' :ITD_CODITF_DEST) ');
    //Selecion os itens do pedido atual
    with Tributacao do
    Begin
      Qr_ItensPedido.First;
      while not Qr_ItensPedido.Eof do
      Begin
        if not DM.IBT_Faturamento.InTransaction then DM.IBT_Faturamento.StartTransaction;
        //Procura o Item do Pedido devolvido
        Lc_Qry.Active := False;
        Lc_Qry.ParamByName('PED_CODIGO').AsInteger := Pc_Cd_Pedido_Devolvido;
        if RG_Tipo_S_E.ItemIndex = 0 then
          Lc_Qry.ParamByName('PED_TIPO').AsInteger := 2
        else
          Lc_Qry.ParamByName('PED_TIPO').AsInteger := 1;
        Lc_Qry.ParamByName('ITF_CODPRO').AsInteger := Qr_ItensPedido.FieldByName('ITF_CODPRO').AsInteger;
        Lc_Qry.Active := True;
        //Atualiza o Item como devolvido
        Lc_Upd.Active := False;
        Lc_Upd.ParamByName('ITD_CODITF_ORIG').AsInteger := Lc_Qry.FieldByName('ITF_CODIGO').AsInteger;
        Lc_Upd.ParamByName('ITD_CODITF_DEST').AsInteger := Qr_ItensPedido.FieldByName('ITF_CODIGO').AsInteger;
        Lc_Upd.Active := True;
        if DM.IBT_Faturamento.InTransaction then DM.IBT_Faturamento.CommitRetaining;
        Qr_ItensPedido.Next;
      end;
    end;
  Finally
    Lc_Qry.Close;
    Lc_Upd.close;
  End;
end;

procedure TFr_Fatura_Ajt.Pc_GeraComissaoNegativaDevolucao(Pc_Cd_Pedido_Devolvido:Integer);
Var
  Lc_Vl_Comissao : real;
  Lc_Vl_Doc : real;
  Lc_Vl_Temp : Real;
  Lc_SqlTxt: string;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Begin
  //Se a comissão for paga no Faturamento e O tipo de Operação for entrada (cliente devolvido mercadoria)
  if (Fc_Tb_Geral('L','TP_COMISSAO','') ='F') and (RG_Tipo_S_E.ItemIndex = 1) then
  Begin
    Try
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        Lc_SqlTxt := 'SELECT  ITF_QTDE, ITF_VL_UNIT, VEN_PROPORCAO,VEN_CODCLB '+
                    'FROM TB_ITENS_NFL Tb_itens_nfl '+
                    '   INNER JOIN TB_VENDEDOR Tb_vendedor '+
                    '   ON  (Tb_itens_nfl.ITF_CODIGO = Tb_vendedor.VEN_CODITF)'+
                    'WHERE (ITF_CODPED =:PED_CODIGO) ';
        SQL.Add(Lc_SqlTxt);
        ParamByName('PED_CODIGO').AsInteger := Pc_Cd_Pedido_Devolvido;
        Active := True;
        FetchAll;
        First;
        Lc_Vl_Comissao := 0;
        Lc_Vl_Doc := 0;
        while not Eof do
        Begin
          Lc_Vl_Temp := 0;
          Lc_Vl_Temp := (FieldByName('ITF_QTDE').AsFloat * FieldByName('ITF_VL_UNIT').AsCurrency);
          //Define o Valor do Documento para a Comissão
          Lc_Vl_Doc := Lc_Vl_Doc + Lc_Vl_Temp;
          //Define o valor da Comissão
          Lc_Vl_Temp := Lc_Vl_Temp * (StrtoFloatDef(FieldByName('VEN_PROPORCAO').AsString,0) /100);
          Lc_Vl_Comissao := Lc_Vl_Comissao +  Lc_Vl_Temp;
          Next;
        end;
        if (Lc_Vl_Comissao > 0) then
        Begin
          Pc_Comissao(DM.IBT_Faturamento,
                      E_Dt_Emissao.Date,
                      Pc_Cd_Pedido_Devolvido,
                      0,
                      tributacao.NotaFiscal.Pedido.Registro.Empresa,
                      FieldByName('VEN_CODCLB').AsInteger,
                      Lc_Vl_Doc * (-1),
                      Lc_Vl_Comissao * (-1),
                      'P');
        end;
      End;
    Finally
      LcBase.FinalizaQuery(Lc_Qry);
      FreeAndNil(LcBase);
    End;
  end;
end;

Function TFr_Fatura_Ajt.Fc_VerificaItemDevolvido(Fc_Nr_Pedido:String):Boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Begin
  Result := true;
  It_Cd_Pedido_Devolvido := 0;
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('select PED_CODIGO, PED_CODEMP, PED_CODVDO, ITF_CODPRO, PRO_DESCRICAO, ITF_QTDE, ITF_VL_UNIT '+
              'FROM TB_PEDIDO '+
              '  INNER JOIN TB_ITENS_NFL '+
              '  ON (ITF_CODPED = PED_CODIGO) '+
              '  INNER JOIN TB_PRODUTO '+
              '  ON (PRO_CODIGO = ITF_CODPRO) '+
              'WHERE PED_NUMERO=:PED_NUMERO ');
      if RG_Tipo_S_E.ItemIndex = 0 then
        SQL.Add('AND (PED_TIPO = 2) ')
      else
        SQL.Add('AND (PED_TIPO = 1) ');
      ParamByName('PED_NUMERO').AsString := Fc_Nr_Pedido;
      Active := true;
      FetchAll;
      //Verifica se o Pedido Existe
      if (RecordCount = 0) then
      Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Pedido ' + Fc_Nr_Pedido + ' não encontrado !'+EOLN+
                       'Verique e tente novamente!'+EOLN,
                       ['OK'],[bEscape],mpAlerta);
        Result := False;
        exit;
      end;

      //Verifica se a devolução está sendo efetuada no nome da empresa que fez o pedido
      if (Tributacao.NotaFiscal.Pedido.Registro.Empresa <> FieldByName('PED_CODEMP').AsInteger) then
      Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'A empresa informada não é a mesma do pedido Nº' + Fc_Nr_Pedido + '!'+EOLN+
                       'Verique e tente novamente!'+EOLN,
                       ['OK'],[bEscape],mpAlerta);
        Result := False;
        exit;
      end;
      //Verifica se a devolução está sendo efetuada no nome do vendedor que fez o pedido
      if (Tributacao.NotaFiscal.Pedido.Registro.Vendedor <> FieldByName('PED_CODVDO').AsInteger) then
      Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'O vendedor informado não é a mesmo do pedido Nº' + Fc_Nr_Pedido + '!'+EOLN+
                       'Verique e tente novamente!'+EOLN,
                       ['OK'],[bEscape],mpAlerta);
        Result := False;
        exit;
      end;
      //Reafaz o Sql com mais um parametro para veirifcar os itens
      Active := False;
      SQL.Add(' AND (ITF_CODPRO =:ITF_CODPRO) ');
      SQL.Add('ORDER BY ITF_cODIGO DESC ');
      //Seleciona os itens deste pedido para verificar se estão no pedido anterior
      with tributacao do
      Begin
        Qr_ItensPedido.First;
        while not Qr_ItensPedido.Eof do
        Begin
          Active := False;
          ParamByName('PED_NUMERO').AsString := Fc_Nr_Pedido;
          ParamByName('ITF_CODPRO').AsInteger := Qr_ItensPedido.FieldByName('ITF_CODPRO').AsInteger;
          Active := true;
          FetchAll;
          if (RecordCount = 0) then
          Begin
            MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                           'O produto ' + Qr_ItensPedido.FieldByName('ITF_CODPRO').AsString + ' - ' + Qr_ItensPedido.FieldByName('PRO_DESCRICAO').AsString +EOLN+
                           'Não consta no pedido original Nº '+Fc_Nr_Pedido +EOLN,
                           ['OK'],[bEscape],mpAlerta);
            Result := False;
            exit;
          end
          else
          Begin
            //Verifica se a quantidade do item do pedido atual maior do que a do pedido original
            if (Qr_ItensPedido.FieldByName('ITF_QTDE').AsFloat > FieldByName('ITF_QTDE').AsFloat) then
            Begin
              MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                             'O quantidade informada no produto ' + FieldByName('ITF_CODPRO').AsString + ' - ' + FieldByName('PRO_DESCRICAO').AsString +EOLN+
                             'não pode ser maior do que (' + FloatToStrF(FieldByName('ITF_QTDE').AsFloat,ffFixed,10,3) + ') conforme consta no pedido original Nº '+Fc_Nr_Pedido +EOLN,
                             ['OK'],[bEscape],mpAlerta);
              Result := False;
              exit;
            end;
            //Verifica se o valor do item do pedido atual maior do que a do pedido original
            if (Qr_ItensPedido.FieldByName('ITF_VL_UNIT').AsCurrency > FieldByName('ITF_VL_UNIT').AsCurrency) then
            Begin
              MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                             'O valor unitário informada no produto ' + FieldByName('ITF_CODPRO').AsString + ' - ' + FieldByName('PRO_DESCRICAO').AsString +EOLN+
                             'não pode ser maior do que (' + FloatToStrF(FieldByName('ITF_VL_UNIT').AsCurrency,ffFixed,10,2) + ') conforme consta no pedido original Nº '+Fc_Nr_Pedido +EOLN,
                             ['OK'],[bEscape],mpAlerta);
              Result := False;
              exit;
            end;
          end;
          Qr_ItensPedido.next;
        end;
      end;
      It_Cd_Pedido_Devolvido := FieldByName('PED_CODIGO').AsInteger;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

Function TFr_Fatura_Ajt.VerificaExistenciaDevolvido(Fc_Nr_Pedido:String):Boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Begin
  Result := true;
  It_Cd_Pedido_Devolvido := 0;
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat('select P.ped_codigo, IO.itf_qtde QO, ID.itf_qtde QD ',
                     ' FROM TB_PEDIDO P ',
                     '   INNER JOIN TB_ITENS_NFL IO ',
                     '   ON (IO.ITF_CODPED = P.PED_CODIGO) ',
                     '   INNER JOIN TB_ITENS_DEV O ',
                     '   ON (O.itd_coditf_orig = IO.ITF_CODIGO ) ',
                     '   INNER JOIN TB_ITENS_NFL ID ',
                     '   ON (ID.itf_codigo = O.itd_coditf_dest) ',
                     ' WHERE PED_NUMERO=:PED_NUMERO ',
                     ' AND (IO.ITF_CODPRO =:ITF_CODPRO) '
             ));

      //Seleciona os itens deste pedido para verificar se estão no pedido anterior
      with tributacao do
      Begin
        Qr_ItensPedido.First;
        while not Qr_ItensPedido.Eof do
        Begin
          Active := False;
          ParamByName('PED_NUMERO').AsString := Fc_Nr_Pedido;
          ParamByName('ITF_CODPRO').AsInteger := Qr_ItensPedido.FieldByName('ITF_CODPRO').AsInteger;
          Active := true;
          FetchAll;
          if (RecordCount > 0) then
          Begin
            //Verifica se a quantidade do item do pedido atual maior do que a do pedido original
            if (StrToFloatDef(FieldByName('QO').AsString,0) > 0  ) then
            Begin
              MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                             'JÁ exite uma devolução do produto ' + Qr_ItensPedido.FieldByName('ITF_CODPRO').AsString + ' - ' + Qr_ItensPedido.FieldByName('PRO_DESCRICAO').AsString +EOLN+
                             'a quantidade informada anteriormente foi (' + FloatToStrF(Qr_ItensPedido.FieldByName('ITF_QTDE').AsFloat,ffFixed,10,3) + ') conforme consta no pedido original Nº '+Fc_Nr_Pedido +EOLN,
                             ['OK'],[bEscape],mpAlerta);
              Result := False;
              exit;
            end;
            if (Qr_ItensPedido.FieldByName('ITF_QTDE').AsFloat > ( StrToFloatDef(FieldByName('QO').AsString,0) - StrToFloatDef(FieldByName('QD').AsString,0) ) ) then
            Begin
              MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                             'A soma das devoluções do produto ' + Qr_ItensPedido.FieldByName('ITF_CODPRO').AsString + ' - ' + Qr_ItensPedido.FieldByName('PRO_DESCRICAO').AsString +EOLN+
                             'ultrapassam a quantidade permitida anteriormente foi (' + FloatToStrF(StrToFloatDef(FieldByName('QO').AsString,0),ffFixed,10,3) + ') conforme consta no pedido original Nº '+Fc_Nr_Pedido +EOLN,
                             ['OK'],[bEscape],mpAlerta);
              Result := False;
              exit;
            end;



          end;
          Qr_ItensPedido.next;
        end;
      end;
      It_Cd_Pedido_Devolvido := FieldByName('PED_CODIGO').AsInteger;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Fatura_Ajt.Pc_Inicia_Variaveis;
Begin
  It_Usa_Nfe := Fc_VerificaFormularioDisponivel('Fr_GeraNFe');
  if It_Usa_Nfe then
    Begin
    ChBx_AutorizacaoNFE.Checked := True;
    ChBx_AutorizacaoNFE.Enabled := true;
    end
  else
    Begin
    ChBx_AutorizacaoNFE.State := cbUnchecked;
    ChBx_AutorizacaoNFE.Enabled := False;
    end;

  Chbx_Financeiro.Enabled := (Fc_Tb_Geral('L','FIN_G_ATIVAR','') = 'S');
  Dblcb_Modal_Frete.KeyValue := DM.Qr_Modal_Frete.FieldByname('MDF_CODIGO').AsInteger;

  //Observação do Veiculo
  if (Fc_Tb_Geral('L','OSR_G_OBS_VEICULO_NF','S') = 'S') then
    E_Obs.Lines.Add(Fc_ObsVeiculoNotaFiscal(It_Cd_Pedido));

  E_Especie.Text:='VOLUME';
  E_Dt_Emissao.Date := Date;
  E_Dt_Saida.Date := Date;
  Dblcb_Modal_Frete.KeyValue := StrToIntDef(Fc_Tb_Geral('L', 'FAT_TIPOFRETE', '0'),0);

  if E_Dt_Saida.CanFocus then E_Dt_Saida.SetFocus;

  Fm_lista_cfop.Sentido := 'S';
  Fm_lista_cfop.Alcada  := Fc_AchaEndereco(It_Cd_Pedido);
  Fm_lista_cfop.Listar;
  Chbx_NaoAtualizarEstoque.Checked := (Fc_Tb_Geral('L','AJT_G_CTRL_ESTOQUE','N') = 'S')
end;

procedure TFr_Fatura_Ajt.Pc_FormataTela;
Begin
  case  It_Operacao of
    1:Begin
        RG_Tipo_S_E.ItemIndex := 1;
        RG_Tipo_S_E.Enabled := False;
      end;
    2:Begin
        RG_Tipo_S_E.ItemIndex := 0;
        RG_Tipo_S_E.Enabled := False;
      end
    else
      Begin
        RG_Tipo_S_E.ItemIndex := 0;
        RG_Tipo_S_E.Enabled := True;
      end;
  end;
end;




function TFr_Fatura_Ajt.fc_ValidaFaturamento(): Boolean;
Var
  Lc_Aux : String;
  Lc_Nr_Nota: Integer;
  Lc_Nr_Ped_Devolvido:String;
  Lc_Dt_Inventario : TDate;
begin
  Result:=true;

  if Tributacao.NotaFiscal.Pedido.InconsistenciaFaturado(true) then
  BEgin
    Result := FAlse;
    Self.close;
  end;

  //vERIFICA SE o CLIENTE escolheu atualizar estoque ou não
  Pc_VerificaSeAtualizarEstoque;

  if Fm_lista_cfop.Chbx_cfop.Checked and (Fm_lista_cfop.Dblcb_Lista.Text = '') then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'FAvor informar o CFOP!'+EOLN+
                   'Verique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
  end;

  //Verifica Inventario
  if not Fc_ValidaDataPedido(E_Dt_Emissao.Date) then
  Begin
    Result := FAlse;
    E_Dt_Emissao.SetFocus;
    E_Dt_Emissao.Date := Date;
    Exit;
  end;

  if ChBx_Nota_Manual.Checked then
  Begin
    if not(InputQuery('Informar o Número da Nota Fiscal ', 'Número', Lc_Aux)) then
    Begin
      Result := False;
      exit;
    end;
    If trim(Lc_Aux) = '' then
    Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'O número da nota não foi informado !'+EOLN+
                     'Se escolheu informar manualmente digite um número'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
    end;
    if Fc_VerificaNumeroNota('T',Tributacao.NotaFiscal.Pedido.Registro.Empresa,Lc_Aux) then
    Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'O número de nota Informada já existe !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
    end;
    Lc_Aux     := Fc_RemoveCaracterInformado(Lc_Aux, ['.',',','/','-',' ']);
    Tributacao.NotaFiscal.registro.Numero := Lc_Aux;
  end;

  if (ChBx_DevolucaoMercadoria.Checked) then
  Begin
    if not(InputQuery('Controle de Devolução', 'Número do pedido Original', Lc_Nr_Ped_Devolvido)) then
    Begin
      Result := False;
      exit;
    end;

    if trim(Lc_Nr_Ped_Devolvido) = '' then
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Usando a opção controle de devolução de mercadoria '+EOLN+
                     'é obrigatório informar o número do pedido original. '+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpAlerta);
      Result := False;
      exit;                     
    end;

    if not VerificaExistenciaDevolvido(Lc_Nr_Ped_Devolvido) then
    Begin
      Result := False;
      exit;
    end;


    if not Fc_VerificaItemDevolvido(Lc_Nr_Ped_Devolvido) then
    Begin
      Result := False;
      exit;
    end;
  end;

  //Gerar Financeiro e Tipo entrada significa devolução de Cliente - Obrigar colocar o vendedor
  If Chbx_Financeiro.Checked and (RG_Tipo_S_E.ItemIndex = 1) then
  Begin
    if Tributacao.NotaFiscal.Pedido.Registro.Vendedor = 0 then
    begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Para devolução de mercadoria gerando crédito '+EOLN+
                     'é obrigatório informar o nome do Vendedor. '+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
       Result:=false;
       exit;
    end;
  end;

  //Operação de Devolução de mercadoria informar o Vendedor
  If ChBx_DevolucaoMercadoria.Checked and (RG_Tipo_S_E.ItemIndex = 1) then
  Begin
    if Tributacao.NotaFiscal.Pedido.Registro.Vendedor = 0 then
    begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Para devolução de mercadoria '+EOLN+
                     'é obrigatório informar o nome do Vendedor. '+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
       Result:=false;
       exit;
    end;
  end;


    
  If It_Usa_Nfe or ChBx_AutorizacaoNFE.Checked then
  begin
    if (Trim(Dblcb_Modal_Frete.Text) = '') then
    begin
      MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                   ' Modalidade de frete não foi preenchida.' + EOLN +
                   ' Favor preencher e tentar novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
      Result := False;
      exit;
    end;
  end;

  If (It_Usa_Nfe AND ChBx_AutorizacaoNFE.Checked) then
  begin
    IF NOT Tributacao.Fc_Valida then
    Begin
      Result := False;
      exit;
    end;
  end;
   //valida estoque no caso de saida de produtos
  IF RG_Tipo_S_E.ItemIndex = 0 then
  Begin
    if not FC_Valida_produto(Tributacao.Qr_ItensPedido) then
    Begin

      Result := False;
      exit;
    end;
  end;
  
  if ChBx_Baixa.Checked then
  begin
    if not Fc_validacao_retorno then
    Begin

      Result := False;
      exit;
    end;
  end;
end;


function TFr_Fatura_Ajt.Fc_Faturar():boolean;
Begin
  //Calcula os impostos
  Tributacao.Pc_PreencheDadosDanfe;
//  Tributacao.It_Nfe.NotasFiscais.SaveToFile(GbPathExe + '\temp\PED_' + IntToStr(It_Nr_Pedido) + 'NFE.XML');
  if Fc_ConfirmaValores then
  begin
    Tributacao.Pc_Pedido;
    Tributacao.Pc_Gera_NotaFiscal;
    Tributacao.Pc_AtualizarItens;
    Tributacao.Pc_Obs_NotaFiscal(E_Obs);
    if DM.IBT_Faturamento.InTransaction then DM.IBT_Faturamento.Commit;
    tributacao.NotaFiscal.Pedido.Registro.Codigo := It_Cd_Pedido;
    tributacao.NotaFiscal.Pedido.Registro.Faturado := 'S';
    tributacao.NotaFiscal.Pedido.alteraStatus;
    MensagemPadrao(MENSAGEM, TITULO_CONFIRMACAO + EOLN + EOLN +
                   'Faturamento realizado com Sucesso.' + EOLN+
                   'Número do Pedido : ' + It_Nr_Pedido + EOLN,
                   ['OK'], [bEscape], mpConfirmacao);
    Result := True;
  end
  else
  Begin
    Result := False;
  end;
end;

function  TFr_Fatura_Ajt.Fc_ConfirmaValores():boolean;
Var
  LcIpiDevol : TControllerDevolIPI;
Begin
  Result := True;
  //Preenche os campos com os totais
  with Tributacao.It_Nfe.NotasFiscais[0].NFe do
  BEgin
    E_VL_Bs_ICMS.Text := FloatToStrF(Total.ICMSTot.vBC, ffFixed, 10, 2);
    E_VL_ICMS.Text := FloatToStrF(Total.ICMSTot.vICMS, ffFixed, 10, 2);
    E_Vl_Bs_Icms_St.Text := FloatToStrF(Total.ICMSTot.vBCST, ffFixed, 10, 2);
    E_Vl_Icms_St.Text := FloatToStrF(Total.ICMSTot.vST, ffFixed, 10, 2);
    if ( Total.ICMSTot.vST < 0 ) then
    begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     ' O valor do ICMS de Substituição Tributária' + EOLN +
                     'não pode estar negativo. Por favor Verifique!' + EOLN,
                     ['OK'], [bEscape], mpInformacao);
      Result := False;
      Pc_AtivarTabela;
    end;
    E_VL_IPI.Text := FloatToStrF(Total.ICMSTot.vIPI, ffFixed, 10, 2);
    E_VL_FRETE.Text := FloatToStrF(Total.ICMSTot.vFrete, ffFixed, 10, 2);
    E_Vl_Seguro.Text := FloatToStrF(Total.ICMSTot.vSeg, ffFixed, 10, 2);
    E_Vl_Outras.Text := FloatToStrF(Total.ICMSTot.vOutro, ffFixed, 10, 2);
    E_VL_Produto.Caption := FloatToStrF(Total.ICMSTot.vProd , ffFixed, 10, 2);

    LcIpiDevol := TControllerDevolIPI.Create(Self);
    LcIpiDevol.Registro.Ordem := It_Cd_Pedido;
    Total.ICMSTot.vIPIDevol := LcIpiDevol.GetValorTotal;
    E_vIPIDevolv.Caption := FloatToStrF( Total.ICMSTot.vIPIDevol, ffFixed, 10, 2);
    if Tributacao.It_SomaICMSNaNota then
      E_VL_Nota.Caption := FloatToStrF(Total.ICMSTot.vNF + Total.ICMSTot.vICMS, ffFixed, 10, 2)
    else
      E_VL_Nota.Caption := FloatToStrF(Total.ICMSTot.vNF, ffFixed, 10, 2);
  end;
  if Result then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                        'Favor Conferir os valores totais da nota.' + EOLN + EOLN +
                        'Confirmar os Valores ?',
                        [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
    begin
      result := True;
    end
    else
    begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Operação Abortada pelo Usuário.' + EOLN,
                     ['OK'], [bEscape], mpInformacao);
                     Result := False;
    end;
  End;
end;


Procedure TFr_Fatura_Ajt.Pc_Gera_Financeiro;
Var
  Lc_Nr_Duplicata : String;
Begin
  with Tributacao do
  Begin
    if StrToIntDef(NotaFiscal.registro.Numero,0) > 0 then
      Lc_Nr_Duplicata := NotaFiscal.Pedido.Registro.Numero.ToString + '/' + NotaFiscal.registro.Numero + '/' +IntToStr(1) + '-' + IntToStr(1)
    else
      Lc_Nr_Duplicata := NotaFiscal.Pedido.Registro.Numero.ToString + '/' + IntToStr(1) + '-' + IntToStr(1);
    if RG_Tipo_S_E.ItemIndex = 0 then
    Begin
      Pc_Financeiro(DM.IBT_Crud,
                    'I',
                     0,
                    NotaFiscal.Pedido.Registro.Empresa,
                    E_Dt_Emissao.DateTime,
                    NotaFiscal.Pedido.Registro.Codigo,
                    NotaFiscal.Registro.Codigo,
                    Fc_PegaParteFormaPgto('CARTEIRA'),
                    '000 - A VISTA',
                    E_Dt_Emissao.Date,
                    Lc_Nr_Duplicata,
                    NotaFiscal.Pedido.Registro.ValorPedido,
                    0,
                    0,
                    0,
                    0,
                    Date,
                    Date,
                    'N',
                    1,
                    'PA',
                    'N',
                    0,
                    'C',
                    'N',
                    0);
    end
  else
    Begin
      Pc_Financeiro(DM.IBT_Crud,
                    'I',
                     0,
                    NotaFiscal.Pedido.Registro.Empresa,
                    E_Dt_Emissao.Date,
                    NotaFiscal.Pedido.Registro.Codigo,
                    NotaFiscal.Registro.Codigo,
                    Fc_PegaParteFormaPgto('CARTEIRA'),
                    '000 - A VISTA',
                    E_Dt_Emissao.Date,
                    Lc_Nr_Duplicata,
                    NotaFiscal.Pedido.Registro.ValorPedido,
                    0,
                    0,
                    0,
                    0,
                    Date,
                    Date,
                    'N',
                    1,
                    'RA',
                    'N',
                    0,
                    'D',
                    'N',
                    0);
    end;
  END;
end;

Procedure TFr_Fatura_aJT.Pc_ImprimeCupom;
Var
  Lc_Imp: TimpModImpressao;
Begin
  if (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_TP_CUPOM_FAT','')) = 'S' then
  Begin
    Try
      Lc_Imp := TimpModImpressao.create(nil);
      IF RG_Tipo_S_E.ItemIndex = 0 THEN
        Lc_Imp.It_Tp_Doc:='AJUSTE SAIDA : '
      else
        Lc_Imp.It_Tp_Doc:='AJUSTE ENTRADA : ';
      Lc_Imp.CodigoPedido :=It_cd_Pedido;
      Lc_Imp.Pc_Imp_Cupom;
    finally
      FreeandNil(Lc_Imp);
    end;
  end;
end;

procedure TFr_Fatura_Ajt.Pc_AtivarTabela;
Begin
  DM.Qr_UF.Active := true;
  DM.Qr_Modal_Frete.Active := true;
  DM_ListaConsultas.Pc_ListaTranportadoras('EMP_NOME');
end;

Procedure TFr_Fatura_Ajt.Pc_Estoque(Pc_Itens:TSTQuery);
Var
  LcCtrlEstoque : TControllerCtrlEstoque;
Begin
  Try
    LcCtrlEstoque := TControllerCtrlEstoque.create(nil);
    with Pc_Itens do
    Begin
      First;
      while not Eof do
      Begin
        if (FieldByName('ITF_ESTOQUE').AsString = 'S') then
        Begin
          with LcCtrlEstoque.Registro do
          Begin
            Codigo      := 0;
            Vinculo     := 'P';
            Terminal    := Gb_Terminal;
            Ordem       := It_Cd_Pedido;
            Item        := FieldByname('ITF_CODIGO').AsInteger;
            Estoque     := FieldByname('ITF_CODEST').AsInteger;
            operacao    := It_Oper_Estoque;
            Produto     := FieldByname('ITF_CODPRO').AsInteger;
            Quantidade  := FieldByname('ITF_QTDE').AsFloat;
            Data        := E_Dt_Emissao.Date;
            Tipo        := 'Ajuste';
            UpdateAt    := Now;
          End;
          LcCtrlEstoque.Registra;
        end;
        Next;
      end;
    end;
  Finally
    FreeAndNil(LcCtrlEstoque);
  End;
end;

procedure TFr_Fatura_Ajt.SB_ConfirmarClick(Sender: TObject);
begin
  TRY
    Self.Enabled := False;
    Pc_ProcesoAguarde(Self,'I');
    Pc_CarregaComponenteTributacao;
    if fc_ValidaFaturamento then
    Begin
      Pc_Faturar_Ajuste;
    end;
  Finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;

procedure TFr_Fatura_Ajt.Pc_VerificaSeAtualizarEstoque;
Begin
  with Tributacao.NotaFiscal.Pedido do
  Begin
    Itens.Registro.CodigoPedido := It_cd_Pedido;
    if Chbx_NaoAtualizarEstoque.Checked then
      Itens.Registro.Estoque := 'N'
    else
      Itens.Registro.Estoque := 'S';
    Itens.setITF_Estoque;

  End;
end;

procedure TFr_Fatura_Ajt.Pc_Faturar_Ajuste;
var
  Lc_Form : TFr_GeraNfe_Ajt;
Begin
  if RG_Tipo_S_E.ItemIndex = 0 then It_Oper_Estoque := 'S' else It_Oper_Estoque := 'E';
  Pc_Define_FormatoRegional;
  It_Fatura_Ok := Fc_Faturar;
  if It_Fatura_Ok then
  Begin
    if Chbx_Financeiro.Checked then
      Pc_Gera_Financeiro;
    if ChBx_Baixa.Checked then
    Begin
      Tributacao.NotaFiscal.Registro.NotaVinculada  := E_DocVinculado.Text;
      Tributacao.NotaFiscal.BaixaRetorno;
      MensagemPadrao('Mensagem ','S U C E S S O!.'+EOLN+EOLN+
                     'A atualização de Retorno foi executada com sucesso.'+EOLN+
                     'O Documento '+ E_DocVinculado.Text + ' está baixado.'+EOLN,
                    ['OK'],[bEscape],mpInformacao);
    End;
    if ChBx_Retorno.Checked then
      Pc_Controla_retorno;
    //Atualiza as séries
//    if RG_Tipo_S_E.ItemIndex = 1 then
//      NotaFiscal.Pedido.Itens.Produto.AtualizaSeries(DM.IBT_Faturamento,Tributacao.Qr_ItensPedido,'S');
    //Verifica se trata-se de devolução de mecadoria
    if (ChBx_DevolucaoMercadoria.Checked) then
    Begin
      Pc_MarcaProdutoDevolvido(It_Cd_Pedido_Devolvido);
      Pc_GeraComissaoNegativaDevolucao(It_Cd_Pedido_Devolvido);
    end;
    //Registra movimentação do Estoque local
    Pc_Estoque(Tributacao.Qr_ItensPedido);

    Pc_ImprimeCupom;
    //Disponibiliza as Series de Produtos no caso de existir
    //Atualiza os numeros de Serie
    if RG_Tipo_S_E.ItemIndex = 0 then
      Tributacao.NotaFiscal.AtualizaSeries('N',Tributacao.Qr_ItensPedido)
    else
      Tributacao.NotaFiscal.AtualizaSeries('S',Tributacao.Qr_ItensPedido);
    if ChBx_AutorizacaoNFE.Checked then
    begin
      Lc_Form := TFr_GeraNfe_Ajt.Create(Self);
      try
        TRy
          Lc_Form.It_Cd_Pedido      := Tributacao.NotaFiscal.Pedido.Registro.Codigo;
          Lc_Form.It_cd_Cliente     := Tributacao.NotaFiscal.Pedido.Registro.Empresa;
          Lc_Form.It_cd_Consumidor  := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
          Lc_Form.It_Cd_Nota        := Tributacao.NotaFiscal.Registro.Codigo;
          Lc_Form.It_Nr_Nota        := 0;
          Lc_Form.It_Nf_Terceiro    := FAlse;
          Lc_Form.ValorRecebido     := 0;
          Lc_Form.ValorTroco        := 0;

          //Operação Normal
          Pc_CarregaDadosEmitente(true);
          Lc_Form.TipoOperacao := 'NF-e';
          Lc_Form.ShowModal;
        except
          on e:Exception do
            MensagemPadrao('NMensagem de erro', ATENCAO + EOLN + EOLN +
                           e.Message + EOLN +
                           'Informe ao Desenvolvedor do Sistema.' + EOLN,
                           ['OK'], [bEscape], mpErro);
        End;
      finally
        FreeAndNil(Lc_Form);
        SetWindowPos(Gb_Handle,Hwnd_TopMost,0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or  SWP_SHOWWINDOW);
      end;
    end;
    self.Close;
  end
  else
  Begin
    It_Fatura_Ok := False;
    self.Close;
  end;
end;

procedure TFr_Fatura_Ajt.Sb_Pesq_ClienteClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(3,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    DBLCB_Transportadora.KeyValue := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
  end;
end;

procedure TFr_Fatura_Ajt.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Fatura_Ajt.FormCreate(Sender: TObject);
begin
  Tributacao := ttributacao.create(Self);
end;

procedure TFr_Fatura_Ajt.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) and not (ActiveControl is TMemo) then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

procedure TFr_Fatura_Ajt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F10 : if SB_Confirmar.Enabled then SB_ConfirmarClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
    end;
   end;

end;

procedure TFr_Fatura_Ajt.DBLCB_TransportadoraKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Transportadora.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_Fatura_Ajt.Sb_TransportadoraClick(Sender: TObject);
Var
  Lc_Form : TFr_Transportadora;
begin
  Try
    Lc_Form := TFr_Transportadora.Create(nil);
    if (Trim(DBLCB_Transportadora.Text) <> '') then
      Lc_Form.Empresa.Registro.Codigo := DBLCB_Transportadora.KeyValue;
    Lc_Form.ShowModal;
    DM_ListaConsultas.Pc_ListaTranportadoras('EMP_NOME');
    DBLCB_Transportadora.KeyValue := Lc_Form.Empresa.Registro.Codigo;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;


procedure TFr_Fatura_Ajt.ChBx_RetornoClick(Sender: TObject);
begin
  if ChBx_Retorno.Checked then
    Begin
    ChBx_Baixa.Checked := False;
    Rb_Ctrl_Pedido.Checked:=true;
    Rb_Ctrl_Nf.Checked:=false;
    end
  else
    begin
    E_DocVinculado.Clear;
    Rb_Ctrl_Pedido.Checked:=false;
    Rb_Ctrl_Nf.Checked:=false;
    end;
end;

procedure TFr_Fatura_Ajt.ChBx_BaixaClick(Sender: TObject);
begin
  if ChBx_Baixa.Checked then
  begin
    ChBx_Retorno.Checked := False;
    Rb_Ctrl_Pedido.Checked:=true;
    Rb_Ctrl_Nf.Checked:=false;
    E_DocVinculado.Enabled := true;
    E_DocVinculado.ReadOnly := false;
  end
  else
  begin
    E_DocVinculado.Enabled := false;
    E_DocVinculado.ReadOnly := true;
    ChBx_Retorno.Checked := False;
    Rb_Ctrl_Pedido.Checked:=false;
    Rb_Ctrl_Nf.Checked:=false;
    E_DocVinculado.Clear;
  end
end;

procedure TFr_Fatura_Ajt.Rg_TipoDocClick(Sender: TObject);
begin
  ChBx_RetornoClick(Self);
  if Rb_Ctrl_Pedido.Checked then Lb_Controle.Caption := 'Número do Pedido';
  if Rb_Ctrl_Nf.Checked then Lb_Controle.Caption := 'Número da Nota Fiscal';
end;


procedure TFr_Fatura_Ajt.RG_Tipo_S_EClick(Sender: TObject);
begin
  If RG_Tipo_S_E.ItemIndex = 0 then
  Begin
    Fm_lista_cfop.Sentido := 'S';
    Chbx_Financeiro.Caption := 'Gerar crédito no Contas É Pagar';
  end
  else
  Begin
    Fm_lista_cfop.Sentido := 'E';
    Chbx_Financeiro.Caption := 'Gerar crédito no Contasá Receber';
  end;
  Fm_lista_cfop.Alcada := Fc_AchaEndereco(It_Cd_Pedido);
  Fm_lista_cfop.Listar;
end;

procedure TFr_Fatura_Ajt.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_ImagemBotao;
  Pc_AtivarTabela;
  Pc_Inicia_Variaveis;
end;

procedure TFr_Fatura_Ajt.Rb_Ctrl_PedidoClick(Sender: TObject);
begin
  if Rb_Ctrl_Pedido.Checked then
    begin
    Lb_Controle.Caption := 'Número do Pedido';
    end;
end;

function TFr_Fatura_Ajt.Fc_validacao_retorno: Boolean;
var
qr_aux:TSTQuery;
lc_tp_controle:String;
begin
  Result:=true;
  if ((Trim(E_DocVinculado.Text)) ='') and (ChBx_Baixa.Checked) then
    begin
      Result:=false;
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Nenhum Número de Vinculo foi digitado.'+EOLN+
                     'Digite e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      exit;
    end;

  qr_aux:=TSTQuery.Create(self);
  qr_aux.Database :=DM.IBD_Gestao;
  qr_aux.Transaction := DM.IBT_Faturamento;
  qr_aux.Active:=false;
  qr_aux.SQL.Clear;
  if Rb_Ctrl_Pedido.Checked then  lc_tp_controle:='Pedido' ELSE   lc_tp_controle:='Nota Fiscal';
  qr_aux.SQL.Add(' select ped_numero from tb_pedido                                                             ');
  qr_aux.SQL.Add(' inner join tb_nota_fiscal tb_nota_fiscal on tb_nota_fiscal.nfl_codped = tb_pedido.ped_codigo ');
  qr_aux.SQL.Add(' where NFL_NFL_VINCULO =:NFL_NFL_VINCULO and tb_nota_fiscal.nfl_ctrl_retorno <> ''N''                   ');
  qr_aux.ParamByName('NFL_NFL_VINCULO').AsString := E_DocVinculado.Text;
  qr_aux.Active:=true;
  if qr_aux.RecordCount = 0 then Result:=false;
  if not Result then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   lc_tp_controle + ' vinculado não encontrado.'+EOLN+
                   'Verifique o número e tente novamente'+EOLN,
                  ['OK'],[bEscape],mpErro);
    end;
end;

procedure TFr_Fatura_Ajt.E_DocVinculadoKeyPress(Sender: TObject;
  var Key: Char);
begin
if not (Key in ['0'..'9',',']) Then
  Key := #0;  ;
end;

procedure TFr_Fatura_Ajt.Rb_Ctrl_NfClick(Sender: TObject);
begin
  if Rb_Ctrl_Nf.Checked then
     Lb_Controle.Caption := 'Número da Nota';
end;

procedure TFr_Fatura_Ajt.Pc_Controla_retorno;
begin
  with Tributacao do
  Begin
    if Rb_Ctrl_Pedido.Checked then
    Begin
      NotaFiscal.Registro.ControlaRetorno :='P';
      NotaFiscal.Registro.NotaVinculada := It_Nr_Pedido;
    end
    else
    Begin
      NotaFiscal.Registro.ControlaRetorno :='F';
      NotaFiscal.Registro.NotaVinculada := Tributacao.NotaFiscal.Registro.Numero;
    end;
    NotaFiscal.ControlaRetorno;
  End;
end;


procedure TFr_Fatura_Ajt.E_Qt_ProdutoChange(Sender: TObject);
Var
  Lc_Ativa : boolean;
begin
  Lc_Ativa := (StrToFloatDef(E_Qt_Produto.Text,0) > 0);
  if Lc_Ativa then
    Begin
    E_Especie.Enabled := True;
    E_PesoBruto.Enabled := True;
    E_PesoLiq.Enabled := True;
    E_Marca.Enabled := True;
    E_Vol_Numero.Enabled := True;
    E_PesoLiq.Text := FloatToStrF(Fc_MostraPesoPedido(It_Cd_Pedido),ffFixed,10,2);
    E_PesoBruto.Text := E_PesoLiq.Text;
    end
  else
    Begin
    E_Especie.Enabled := False;
    E_PesoBruto.Enabled := False;
    E_PesoLiq.Enabled := False;
    E_Marca.Enabled := False;
    E_Vol_Numero.Enabled := False;
    // Zera os Campos
    E_PesoBruto.Clear;
    E_PesoLiq.Clear;
    E_Marca.Clear;
    E_Vol_Numero.Clear;    
    end;   
end;

procedure TFr_Fatura_Ajt.Action1Execute(Sender: TObject);
Var
  Lc_Form :TFr_Liberacao;
begin
  try
    Lc_Form := TFr_Liberacao.Create(Self);
    Lc_Form.Liberado := False;
    Lc_Form.It_Interface := 'Fr_Cotacao';
    Lc_Form.It_Nome_Menu := 'Orçamento';
    Lc_Form.It_Privilegio := 'AUTORIZAR';
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Fatura_Ajt.ChBx_AutorizacaoNFEClick(Sender: TObject);
begin
  if (ChBx_AutorizacaoNFE.Checked) then
  Begin
    ChBx_Nota_Manual.Checked := False;
    ChBx_Nota_Manual.Enabled := False;
  end
  else
  Begin
    ChBx_Nota_Manual.Enabled := True;
  end;
end;

end.





