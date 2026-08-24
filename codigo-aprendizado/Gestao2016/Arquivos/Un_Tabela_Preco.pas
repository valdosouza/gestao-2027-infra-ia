unit Un_Tabela_Preco;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Data.DB, STQuery, Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, Vcl.Samples.Gauges, ControllerTabelaPreco, ControllerPreco, Vcl.CheckLst, AnsiStrings, Datasnap.Provider, Datasnap.DBClient, tblTabelaPreco, ControllerFormaPagamento;

type
  TFr_Tabela_Preco = class(TFr_Base)
    pnl_fundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    E_Descricao: TEdit;
    E_Dt_Validade: TEdit;
    E_Mrg_Lucro: TEdit;
    Chbx_Principal: TCheckBox;
    chbx_mobile: TCheckBox;
    Pnl_Botao: TPanel;
    Sb_Inserir: TSpeedButton;
    Sb_Alterar: TSpeedButton;
    Sb_Excluir: TSpeedButton;
    SB_Gravar: TSpeedButton;
    Sb_Cancelar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Ds_Pesquisa: TDataSource;
    Pnl_Progresso: TPanel;
    Gg_Progresso: TGauge;
    AtualizaodePreodeVenda1: TMenuItem;
    DBG_Tabela: TDBGrid;
    Rg_Casas: TRadioGroup;
    rdg_modalidade: TRadioGroup;
    rdg_Tipo_Cliente: TRadioGroup;
    ChkBx_FormasPAgto: TCheckListBox;
    Panel1: TPanel;
    rG_lojista: TRadioGroup;
    Cds_Pesquisa: TClientDataSet;
    Cds_PesquisaTPR_CODIGO: TIntegerField;
    Cds_PesquisaTPR_CODEMP: TIntegerField;
    Cds_PesquisaTPR_NOME: TWideStringField;
    Cds_PesquisaTPR_VALIDADE: TDateField;
    Cds_PesquisaTPR_MODALIDADE: TWideStringField;
    Cds_PesquisaTPR_MAR_LRC: TFMTBCDField;
    Cds_PesquisaTPR_PRINCIPAL: TWideStringField;
    Cds_PesquisaTPR_MOBILE: TWideStringField;
    Cds_PesquisaTPR_TIPO_CLIENTE: TWideStringField;
    Cds_PesquisaTPR_CASA_DECIMAL: TIntegerField;
    Cds_PesquisaTPR_LOJISTA: TWideStringField;
    CorrigiDuplicidades1: TMenuItem;
    CHBX_Ativa: TCheckBox;
    Cds_PesquisaTPR_ATIVA: TStringField;
    CHBX_Margem_Prioritaria: TCheckBox;
    Cds_PesquisaTPR_MAR_PRIORITARIA: TStringField;
    Label3: TLabel;
    E_Mrg_Via_Escala: TEdit;
    Label4: TLabel;
    Cds_PesquisaTPR_MAR_VIA_ESCALA: TFloatField;
    procedure AtualizaodePreodeVenda1Click(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Sb_InserirClick(Sender: TObject);
    procedure Sb_AlterarClick(Sender: TObject);
    procedure Sb_CancelarClick(Sender: TObject);
    procedure Sb_ExcluirClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure posicionaregistro(DataSet: TDataSet);
    procedure CorrigiDuplicidades1Click(Sender: TObject);
  private
    procedure EditionControl;


  protected
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure SaveDataSet;
  public
      PriceList : TcontrollerTabelaPreco;
      Price     : TcontrollerPreco;
      procedure FillListPriceList;

      procedure ShowData;
      procedure ShowDataFormaPagto;
      procedure save;
      procedure saveFormaPagto;
      procedure CopiaTabela;

      procedure Pc_Gravar_Itens_Tabela(Pc_cd_Codigo: Integer; Pc_cd_Tabela: Integer; Pc_Cd_Produto: Integer; Pc_Valor: Real; Pc_Comisao: Real);
      procedure Pc_Realiza_Calculo(Tabela: TSTQuery);

      Function  Fc_ValidaGravacao:Boolean;
      procedure Pc_DesTroiQrery;
      procedure Pc_CalculoGeral;

  end;

var
  Fr_Tabela_Preco: TFr_Tabela_Preco;

implementation


uses     Un_DM, Un_Produtos, UN_MSG, UN_Sistema, Un_Regra_Negocio, Un_Tabela_Preco_Copia, UN_Principal, env, Un_Funcoes, ControllerBase;
{$R *.dfm}

procedure TFr_Tabela_Preco.AtualizaodePreodeVenda1Click(Sender: TObject);
begin
 if StrToFloatDef(E_Mrg_Lucro.Text,0) > 0 then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja recalcular todos os preços desta tabela.' + EOLN + EOLN +
                       'Confirmar a operação ?',
                       [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
      try
        Pc_ProcesoAguarde(Self,'I');
        Self.Enabled := False;
        Pc_CalculoGeral;
      finally
        Pc_ProcesoAguarde(Self,'F');
        Self.Enabled := True;
      end;
    end;
  end
  else
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Margem de lucro não informada.'+EOLN+
                   'Verifique e tente novamente.' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
  end;
end;

procedure TFr_Tabela_Preco.CopiaTabela;
var
  Lc_SqlTxt: string;
  Lc_Tabela: Integer;
  LcQry : TSTQuery;
  Lc_Aliquota : Real;
  Lc_Vl_Str : String;
  LcFormCopia : TFr_Tabela_Preco_Copia;
begin
  Try
    LcFormCopia := TFr_Tabela_Preco_Copia.create(Nil);
    LcQry := TSTQuery.create(Nil);
    with LcQry do
    Begin
      DataBase := DM.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      Active := False;
      SQL.Clear;
      LcFormCopia.Fm_ListaTabelaPreco.Listar(0);
      LcFormCopia.ShowModal;
      if LcFormCopia.ModalResult = mrOk then
      BEgin
        Lc_SqlTxt := 'SELECT PRO_CODIGO, PRC_VL_VDA, PRC_AQ_COM, '+
                     'PRC_QT_MIN '+
                     'FROM TB_PRODUTO tb_produto' +
                     '  INNER JOIN TB_PRECO tb_preco '+
                     '  ON (tb_preco.PRC_CODPRO = tb_produto.PRO_CODIGO) ' +
                     'WHERE PRC_CODTPR =:PRC_CODTPR ';
        SQL.Add(Lc_SqlTxt);
        ParamByName('PRC_CODTPR').AsInteger := LcFormCopia.Fm_ListaTabelaPreco.Dblcb_Lista.KeyValue;
      End
      else
      Begin
        Lc_SqlTxt := 'SELECT PRO_CODIGO , 0 PRC_VL_VDA, ';
        if (Fc_Tb_Geral('L','PRO_G_CUSTO_ATUAL_PRECO','R') = 'R') then
          Lc_SqlTxt := concat( Lc_SqlTxt, ' PRO_VL_CUSTOMED VL_CUSTO ')
        ELSE
          Lc_SqlTxt := concat( Lc_SqlTxt, ' PRO_VL_CUSTO VL_CUSTO ');
        Lc_SqlTxt := concat( Lc_SqlTxt, ' FROM TB_PRODUTO ');
        SQL.Add(Lc_SqlTxt);
      End;
      Active := True;
      FetchAll;
      Pnl_Progresso.Visible := True;
      Gg_Progresso.Progress :=0;
      Gg_Progresso.MinValue := 0;
      Gg_Progresso.MaxValue := RecordCount;
      Application.ProcessMessages;
      First;
      Lc_Aliquota := StrToFloatDef(LcFormCopia.E_Aliquota.Text,0);
      Price.DefineTipoCalculoPreco;
      while not Eof do
      begin
        with Price.Registro do
        Begin
          Codigo := 0;
          CodigoTabela  := PriceList.Registro.codigo;
          CodigoProduto := FieldByName('PRO_CODIGO').asInteger;
          if LcFormCopia.ModalResult = mrOk then
          Begin
            Valor           := FieldByName('PRC_VL_VDA').AsCurrency;
            AliComissao     := FieldByName('PRC_AQ_COM').AsFloat;
            QtdeMinima      := FieldByName('PRC_QT_MIN').asFloat;
            MargemLucro     := StrToFloatDef(E_Mrg_Lucro.Text,0);
            case LcFormCopia.Rg_Tipo.ItemIndex of
              1:Valor := Valor + ( Valor * ( Lc_Aliquota / 100 ));
              2:Valor := Valor - ( Valor * ( Lc_Aliquota / 100 ));
            end;
            Lc_Vl_Str := FloatToStrF(Valor,ffFixed,10,Rg_Casas.ItemIndex + 2);
            Valor := StrToFloatDef(Lc_Vl_Str,0);
          End
          else
          Begin
            MargemLucro   := StrToFloatDef(E_Mrg_Lucro.Text,0);
            Valor         := Price.CalcularPrecoPelaMargemLucro(FieldByName('VL_CUSTO').AsCurrency,  MargemLucro);
            Lc_Vl_Str := FloatToStrF(Valor,ffFixed,10,Rg_Casas.ItemIndex + 2);
            Valor := StrToFloatDef(Lc_Vl_Str,0);
            AliComissao   := 0;
            QtdeMinima    := 0;
          End;
        End;
        Price.insert;
        Next;
        Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
        Application.ProcessMessages;
      end;
    End;
    MensagemPadrao(MENSAGEM, 'S U C E S S O!.' + EOLN + EOLN +
                   'Tabela criada com Sucesso.' + EOLN ,
                   ['OK'], [bEscape], mpInformacao);
  Finally
    LcQry.Close;
    FreeAndNil(LcQry);
    FreeAndNil(LcFormCopia);
    Pnl_Progresso.Visible := False;
    Application.ProcessMessages
  End;
end;

procedure TFr_Tabela_Preco.CorrigiDuplicidades1Click(Sender: TObject);
Var
  LcPreco : TControllerPreco;
  I : Integer;
  LcProduto : Integer;
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'O Sistema vai excluir duplicidade de produtos na tabela atual.' + EOLN + EOLN +
                      'Confirmar a operação ?',
                      [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao1) then
  begin
    try
      LcPreco := TControllerPreco.Create(self);
      LcPreco.Registro.CodigoTabela := Cds_Pesquisa.FieldByName('TPR_CODIGO').AsInteger;
      LcPreco.getList;
      LcProduto := 0;
      Pnl_Progresso.Visible := True;
      Gg_Progresso.Progress := 0;
      Gg_Progresso.MinValue := 0;
      Gg_Progresso.MaxValue := LcPreco.Lista.Count;
      Application.ProcessMessages;
      for I := 0 to LcPreco.Lista.Count - 1 do
      Begin
        if LcProduto = LcPreco.Lista[I].CodigoProduto then
        Begin
          LcPreco.Registro.Codigo := LcPreco.Lista[I].Codigo;
          LcPreco.deleteByID;
        End;
        LcProduto := LcPreco.Lista[I].CodigoProduto;
        Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
        Application.ProcessMessages;
      End;
    finally
      FreeAndNil(LcPreco);
      //Oculta a Barra de progresso
      Pnl_Progresso.Visible := false;
    end;
  end;
end;

procedure TFr_Tabela_Preco.CriarVariaveis;
begin
  inherited;
  PriceList := TcontrollerTabelaPreco.create(self);
  Price     := TcontrollerPreco.create(self);

end;

procedure TFr_Tabela_Preco.EditionControl;
begin
  //EditionControler(Self);
  pnl_fundo.Enabled   := ( EditionState = 'I' ) or ( EditionState = 'E' );
  SB_inserir.Enabled  := ( EditionState = 'B' );
  SB_Alterar.Enabled  := ( EditionState = 'B' ) and ( PriceList.Registro.Codigo > 0 );
  SB_Excluir.Enabled  := ( EditionState = 'B' ) and ( PriceList.Registro.Codigo > 0 );
  SB_Gravar.Enabled   := ( EditionState = 'I' ) or ( EditionState = 'E' );
  SB_Cancelar.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  DBG_Tabela.Enabled  := ( EditionState = 'B' );
  Sb_Sair_0.Enabled   := ( EditionState = 'B' );
end;

function TFr_Tabela_Preco.Fc_ValidaGravacao: Boolean;
begin
  Result:=true;
  if trim(E_Descricao.Text) ='' then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Campo Descrição não informado.'+EOLN+
                   'Preencha a descrição da Tabela de Preço.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    result:=False;
    E_Descricao.SetFocus;
    exit;
  end;

  if rdg_modalidade.ItemIndex < 0 then
  begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' Informa a modalidade da Tabela de Preço.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    result:=False;
    exit;
  end;

  if rdg_modalidade.ItemIndex = 0 then
  begin
    if StrtoFloatDef(E_Mrg_Via_Escala.text,0) > 0 then
    Begin
      MensagemPadrao(' Mensagem de Alerta', ATENCAO + EOLN + EOLN +
                     ' Para Tabelas Vista o Campo Margem por Escala deve ser Zero.' + EOLN+
                     ' Zere Este Campo para Continuar.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      result:=False;
      exit;
    end;
  end;


  if CHBX_Margem_Prioritaria.Checked then
  BEgin
    if StrToFloatDef(E_Mrg_Lucro.Text,0) = 0 then
    Begin
      MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                     ' Tornar a tabela como prioritária na atualização do preço ' + EOLN+
                     ' requer que o campo margem de lucro seja preechido e maior que zero.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      result:=False;
      exit;
    end;
  End;
end;

procedure TFr_Tabela_Preco.FillListPriceList;
Var
  I : Integer;
  LCReg : TTabelaPreco;
begin
  PriceList.getList;
  if not cds_Pesquisa.active then cds_Pesquisa.CreateDataSet;
  cds_Pesquisa.LogChanges := False;
  cds_Pesquisa.EmptyDataSet;

  for I := 0 to PriceList.Lista.Count -1 do
  Begin
    LCReg := TTabelaPreco.create;
    LCReg := PriceList.Lista[I];
    cds_Pesquisa.Append;
    Cds_PesquisaTPR_CODIGO.AsInteger          := LCReg.Codigo;
    Cds_PesquisaTPR_CODEMP.AsInteger          := LCReg.Estabelecimento;
    Cds_PesquisaTPR_NOME.AsString             := LCReg.Descricao;
    Cds_PesquisaTPR_VALIDADE.AsDateTime       := LCReg.Validade;
    Cds_PesquisaTPR_MODALIDADE.AsString       := LCReg.Modalidade;
    Cds_PesquisaTPR_MAR_LRC.AsFloat           := LCReg.MargemLucro;
    Cds_PesquisaTPR_PRINCIPAL.AsString        := LCReg.Principal;
    Cds_PesquisaTPR_MOBILE.AsString           := LCReg.Mobile;
    Cds_PesquisaTPR_TIPO_CLIENTE.AsString     := LCReg.TipoCliente;
    Cds_PesquisaTPR_CASA_DECIMAL.AsInteger    := LCReg.CasaDecimal;
    Cds_PesquisaTPR_LOJISTA.AsString          := LCReg.Lojista;
    Cds_PesquisaTPR_ATIVA.AsString            := LCReg.Ativa;
    Cds_PesquisaTPR_MAR_PRIORITARIA.AsString  := LCReg.MargemPrioritaria;
    Cds_PesquisaTPR_MAR_VIA_ESCALA.AsFloat    := LCReg.MargemViaEscala;
    Cds_Pesquisa.Post;
  End;
  Cds_Pesquisa.LogChanges := True;
end;

procedure TFr_Tabela_Preco.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F2: if SB_Inserir.Enabled then
          SB_InserirClick(Sender);
      VK_F3: if SB_Alterar.Enabled then
          SB_AlterarClick(Sender);
      VK_F4: if SB_Excluir.Enabled then
          SB_ExcluirClick(Sender);
      VK_F5: if SB_Gravar.Enabled then
          SB_GravarClick(Sender);
      VK_F6: if SB_Cancelar.Enabled then
          SB_CancelarClick(Sender);
     VK_Escape: if Sb_Sair_0.Enabled then
           Sb_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_Tabela_Preco.ImagemBotao;
begin
  CarregaImagemBotao(SB_Inserir,'INSERIR');
  CarregaImagemBotao(SB_Alterar,'ALTERAR');
  CarregaImagemBotao(SB_Excluir,'EXCLUIR');
  CarregaImagemBotao(SB_Gravar,'GRAVAR');
  CarregaImagemBotao(Sb_Cancelar,'CANCELAR');
  CarregaImagemBotao(Sb_Sair_0,'SAIR');
end;

procedure TFr_Tabela_Preco.IniciaVariaveis;
begin
  inherited;
  FillListPriceList;
  Cds_Pesquisa.AfterScroll := posicionaregistro;
  Cds_Pesquisa.First;

end;


procedure TFr_Tabela_Preco.Pc_CalculoGeral;
Var
  LcPreco:TControllerPreco;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      //COMANDO SQL PARA ALTETAR O PREÇO
      LcPreco := TControllerPreco.Create(self);
      //COMANDO SQL PARA CONSULTAR OS PRODUTOS
      //Define or qual campo custo será feito o calculo(Ver Configuração Aba Prodtuos
      IF Fc_Tb_Geral('L','PRO_G_CUSTO_ATUAL_PRECO','') = 'C' THEN
        SQL.add('SELECT PRO_CODIGO, PRO_VL_CUSTO VALOR ')
      else
        SQL.add('SELECT PRO_CODIGO, PRO_VL_CUSTOMED VALOR ');
      SQL.add('FROM TB_PRODUTO ');
      SQL.add('WHERE PRO_ATIVO = ''S'' ');
      Active := true;
      FetchAll;
      First;
      //mostra a Barra de progresso
      Pnl_Progresso.Visible := True;
      Gg_Progresso.Progress := 0;
      Gg_Progresso.MinValue := 0;
      Gg_Progresso.MaxValue := RecordCount;
      Application.ProcessMessages;
      while not Eof do
      Begin
        LcPreco.Registro.Codigo         := 0;
        LcPreco.Registro.CodigoTabela   := Cds_Pesquisa.FieldByName('TPR_CODIGO').AsInteger;
        LcPreco.Registro.CodigoProduto  := FieldByName('PRO_CODIGO').AsInteger;
        LcPreco.getByTabelaProduto;
        LcPreco.Registro.Valor          := Fc_CalcularPrecoPelaMargemLucro(FieldByName('VALOR').AsCurrency,
                                                                           StrToFloatDef(E_Mrg_Lucro.Text,0),
                                                                            Cds_Pesquisa.FieldByName('TPR_CASA_DECIMAL').AsInteger);
        LcPreco.Registro.MargemLucro    := StrToFloatDef(E_Mrg_Lucro.Text,0);
        if LcPreco.exist then
          LcPreco.update
        else
          LcPreco.Insert;
        Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      end;
    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
    //Oculta a Barra de progresso
    Pnl_Progresso.Visible := false;
    FreeAndNil(LcPreco);
  end;
end;


procedure TFr_Tabela_Preco.Pc_DesTroiQrery;
begin

end;


procedure TFr_Tabela_Preco.Pc_Gravar_Itens_Tabela(Pc_cd_Codigo, Pc_cd_Tabela,
  Pc_Cd_Produto: Integer; Pc_Valor, Pc_Comisao: Real);
begin

end;



procedure TFr_Tabela_Preco.Pc_Realiza_Calculo(Tabela: TSTQuery);
begin

end;

procedure TFr_Tabela_Preco.posicionaregistro(DataSet: TDataSet);
begin
  with PriceList.Registro, Cds_Pesquisa do
  Begin
    Codigo := fieldByname('TPR_CODIGO').AsInteger;
  End;
 PriceList.getById;

  ShowData;
  ShowDataFormaPagto;
  EditionState := 'B';
  EditionControl;

end;

procedure TFr_Tabela_Preco.save;
begin
  with PriceList.Registro do
  Begin
    Estabelecimento := Gb_CodMha;
    Descricao := E_Descricao.Text;
    Validade  := StrToDateDef(E_Dt_Validade.text,Date+360);
    MargemLucro := StrToFloatDef(E_Mrg_Lucro.text,0);
    MargemViaEscala := StrToFloatDef(E_Mrg_Via_Escala.text,0);
    case rdg_modalidade.ItemIndex of
      0 : PriceList.Registro.Modalidade := 'V';
      1 : PriceList.Registro.Modalidade := 'P';
      2 : PriceList.Registro.Modalidade := 'A';
    end;
    case rdg_Tipo_Cliente.ItemIndex of
      0 : PriceList.Registro.TipoCliente := 'C';
      1 : PriceList.Registro.TipoCliente := 'R';
      2 : PriceList.Registro.TipoCliente := 'A';
    end;
    case Rg_Casas.ItemIndex of
      0:CasaDecimal := 0;
      1:CasaDecimal := 2;
      2:CasaDecimal := 3;
      3:CasaDecimal := 4;
      4:CasaDecimal := 5;
      5:CasaDecimal := 6;
    end;
    case rG_lojista.ItemIndex of
      0 : PriceList.Registro.Lojista := 'S';
      1 : PriceList.Registro.Lojista := 'N';
      2 : PriceList.Registro.Lojista := 'T';
    end;
    if Chbx_Principal.Checked then
      Principal := 'S'
    else
      Principal := 'N';

    if CHBX_Ativa.Checked then
      Ativa := 'S'
    else
      Ativa := 'N';

    if CHBX_Margem_Prioritaria.Checked then
      MargemPrioritaria := 'S'
    else
      MargemPrioritaria := 'N';

  End;
  PriceList.save;

end;

procedure TFr_Tabela_Preco.SaveDataSet;
begin
  if not Cds_Pesquisa.Active then Cds_Pesquisa.CreateDataSet;
  if EditionState = 'E' then
    Cds_Pesquisa.edit
  else
    Cds_Pesquisa.Append;
  Cds_PesquisaTPR_CODIGO.asInteger        := PriceList.Registro.Codigo;
  Cds_PesquisaTPR_CODEMP.asInteger        := PriceList.Registro.Estabelecimento;
  Cds_PesquisaTPR_NOME.asString           := PriceList.Registro.Descricao;
  Cds_PesquisaTPR_VALIDADE.AsDateTime     := PriceList.Registro.Validade;
  Cds_PesquisaTPR_MODALIDADE.AsString     := PriceList.Registro.Modalidade;
  Cds_PesquisaTPR_MAR_LRC.asFloat         := PriceList.Registro.MargemLucro;
  Cds_PesquisaTPR_PRINCIPAL.AsString      := PriceList.Registro.Principal;
  Cds_PesquisaTPR_MOBILE.AsString         := PriceList.Registro.Mobile;
  Cds_PesquisaTPR_TIPO_CLIENTE.AsString   := PriceList.Registro.TipoCliente;
  Cds_PesquisaTPR_CASA_DECIMAL.AsInteger  := PriceList.Registro.CasaDecimal;
  Cds_PesquisaTPR_LOJISTA.AsString        := PriceList.Registro.Lojista;
  if CHBX_Ativa.Checked then
    Cds_PesquisaTPR_ATIVA.AsString        := 'S'
  else
    Cds_PesquisaTPR_ATIVA.AsString        := 'N';

  if CHBX_Margem_Prioritaria.Checked then
    Cds_PesquisaTPR_MAR_PRIORITARIA.AsString        := 'S'
  else
    Cds_PesquisaTPR_MAR_PRIORITARIA.AsString        := 'N';

  Cds_PesquisaTPR_MAR_VIA_ESCALA.AsFloat := PriceList.Registro.MargemViaEscala;
  Cds_Pesquisa.POST;
end;

procedure TFr_Tabela_Preco.saveFormaPagto;
Var
  I : Integer;
  LcCodigo : Integer;
begin
  for I := 0 to ChkBx_FormasPAgto.Count - 1 do
  BEgin
    PriceList.hasFormaPAgto.Registro.Tabela     := PriceList.Registro.Codigo;
    LcCodigo := StrToIntDef(Copy(ChkBx_FormasPAgto.Items[I],1,3),0);
    PriceList.hasFormaPAgto.Registro.FormaPagto := LcCodigo;
    if ChkBx_FormasPAgto.Checked[I] then
      PriceList.hasFormaPAgto.Registro.Ativo := 'S'
    else
      PriceList.hasFormaPAgto.Registro.Ativo := 'N';
    PriceList.hasFormaPAgto.save;
  End;
end;

procedure TFr_Tabela_Preco.Sb_AlterarClick(Sender: TObject);
begin
  EditionState := 'E';
  EditionControl;
  Cds_Pesquisa.Edit;
end;

procedure TFr_Tabela_Preco.Sb_CancelarClick(Sender: TObject);
begin
  EditionState := 'B';
  EditionControl;
end;

procedure TFr_Tabela_Preco.Sb_ExcluirClick(Sender: TObject);
begin
 With Cds_Pesquisa do
  Begin
    if (FieldByName('TPR_CODIGO').AsInteger <=2) then
    Begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Esta tabela é padrão do sistema.' + EOLN +
                     '      Não pode ser excluida.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      exit;
    end;
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Excluir ' + FieldByName('TPR_NOME').AsString + ' de seus arquivos.' + EOLN + EOLN +
                       'Confirmar a exclusão ?',
                       [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clRed) = mrBotao1) then
    Begin
      if (MensagemPadrao(TITULO_CONFIRMACAO,
                         'Atenção ao excluir esta tabela não há como restaurar automaticamente estes dados.' + EOLN + EOLN +
                         'Você tem certeza que deseja excluir ?',
                         [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clRed) = mrBotao1) then
      Begin
        PriceList.Delete;
        Cds_Pesquisa.Delete;
        EditionState := 'B';
        EditionControl;
      End;
    end;
  End;
end;

procedure TFr_Tabela_Preco.SB_GravarClick(Sender: TObject);
begin
  IF Fc_ValidaGravacao then
  Begin
    try
      Cds_Pesquisa.AfterScroll := nil;
      save;
      SaveDataSet;
      if PriceList.Registro.Principal = 'S' then
        PriceList.DefinePrincipal;
      saveFormaPagto;
      IF ( EditionState = 'I') then
      Begin
        EditionState := '0';
        EditionControl;
        CopiaTabela;
      End;
    finally
      EditionState := 'B';
      EditionControl;
      Cds_Pesquisa.AfterScroll := posicionaregistro;
    end;
  end;
end;

procedure TFr_Tabela_Preco.Sb_InserirClick(Sender: TObject);
begin
  Cds_Pesquisa.AfterScroll := nil;
  PriceList.Clear;
  ClearFields(self);
  EditionState := 'I';
  EditionControl;
  E_Descricao.SetFocus;
end;

procedure TFr_Tabela_Preco.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Tabela_Preco.ShowData;
begin
  with Cds_Pesquisa do
  Begin
    E_Descricao.Text := FieldByName('TPR_NOME').asString;
    E_Mrg_Lucro.Text := FloatToStrF( FieldByName('TPR_MAR_LRC').AsFloat,ffFixed,10,2);
    E_Mrg_Via_Escala.Text := FloatToStrF( FieldByName('TPR_MAR_VIA_ESCALA').AsFloat,ffFixed,10,2);
    E_Dt_Validade.Text := FieldByName('TPR_VALIDADE').asString;
    IF FieldByName('TPR_MODALIDADE').AsString = 'V' then
      rdg_modalidade.ItemIndex:=0
    else
    IF FieldByName('TPR_MODALIDADE').AsString = 'P' then
      rdg_modalidade.ItemIndex:=1
    else
    IF FieldByName('TPR_MODALIDADE').AsString = 'A' then
      rdg_modalidade.ItemIndex:=2
    ELSE
      rdg_modalidade.ItemIndex:=-1;
    Chbx_Principal.checked := (FieldByName('TPR_PRINCIPAL').AsString = 'S');
    chbx_mobile.checked := (FieldByName('TPR_MOBILE').AsString = 'S');

    IF FieldByName('TPR_TIPO_CLIENTE').AsString = 'C' then
      rdg_Tipo_Cliente.ItemIndex:=0
    else
    IF FieldByName('TPR_TIPO_CLIENTE').AsString = 'R' then
      rdg_Tipo_Cliente.ItemIndex:=1
    else
    IF FieldByName('TPR_TIPO_CLIENTE').AsString = 'A' then
      rdg_Tipo_Cliente.ItemIndex:=2
    ELSE
      rdg_modalidade.ItemIndex:=-1;

    case FieldByName('TPR_CASA_DECIMAL').AsInteger of
      0:Rg_Casas.ItemIndex := 0;
      2:Rg_Casas.ItemIndex := 1;
      3:Rg_Casas.ItemIndex := 2;
      4:Rg_Casas.ItemIndex := 3;
      5:Rg_Casas.ItemIndex := 4;
      6:Rg_Casas.ItemIndex := 5;
    end;


    if FieldByName('TPR_LOJISTA').AsString ='S' then
      rG_lojista.ItemIndex := 0
    else
    if FieldByName('TPR_LOJISTA').AsString ='N' then
      rG_lojista.ItemIndex := 1
    else
    if FieldByName('TPR_LOJISTA').AsString ='T' then
      rG_lojista.ItemIndex := 2
    else
      rG_lojista.ItemIndex := -1;

     CHBX_Ativa.Checked := ( FieldByName('TPR_ATIVA').AsString ='S' );
     CHBX_Margem_Prioritaria.Checked := ( FieldByName('TPR_MAR_PRIORITARIA').AsString ='S' );
  End;
end;

procedure TFr_Tabela_Preco.ShowDataFormaPagto;
Var
  I : Integer;
begin
  with PriceList.HasFormaPAgto do
  Begin
    Registro.Tabela := PriceList.Registro.Codigo;
    getListSpl;
    ChkBx_FormasPAgto.Clear;
    for I := 0 to ListaSpl.Count - 1 do
    Begin
      ChkBx_FormasPAgto.Items.Add( concat(StrZero(ListaSpl[I].Codigo,3,0), ' - ', ListaSpl[I].Descricao));
      ChkBx_FormasPAgto.Checked[I] := ListaSpl[I].Ativado;
    End;
  End;


end;

end.
