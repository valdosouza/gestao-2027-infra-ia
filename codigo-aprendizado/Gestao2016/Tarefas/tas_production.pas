unit tas_production;

interface

uses
      Windows, base_registry, Data.DB, Datasnap.DBClient, Datasnap.Provider, Vcl.Graphics, STQuery, Vcl.Grids, Vcl.DBGrids, Un_Fm_ListaEstoques, ControllerBase, Vcl.StdCtrls, Vcl.Mask, Vcl.Forms, Un_Fm_ListaProdutos, Vcl.ComCtrls, SysUtils, Vcl.Controls, Vcl.Menus, Vcl.Buttons, Classes, Vcl.ExtCtrls, ControllerCtrlLote, ControllerProduction, ControllerMovimentoLote, un_Ctrl_Lotes, ControllerProductionForeCast, tblProductionForeCast, StrUtils;

type
  TTasProduction = class(TBaseRegistry)
    E_Numero: TEdit;
    Label1: TLabel;
    Dtp_Cadastro: TDateTimePicker;
    Dtp_Prevista: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    Cb_Situacao: TComboBox;
    Label4: TLabel;
    pg_Geral: TPageControl;
    tsPrevisto: TTabSheet;
    tbs_Producao: TTabSheet;
    Pnl_Item_Produzir: TPanel;
    Label8: TLabel;
    Label5: TLabel;
    Fm_ListaProdutos: TFm_ListaProdutos;
    E_Qtde_Produzir: TEdit;
    gbProducao: TGroupBox;
    Label6: TLabel;
    Label11: TLabel;
    Label7: TLabel;
    edDtInicio: TMaskEdit;
    edDtFim: TMaskEdit;
    E_Qtde_Produzida: TEdit;
    Sb_Info_Lote_PA: TButton;
    Pnl_MP_Lista: TPanel;
    DBG_MP: TDBGrid;
    Qr_Lote_MP_Disponivel: TSTQuery;
    Fm_ListaEstoquesMP: TFm_ListaEstoques;
    Fm_ListaEstoquesPA: TFm_ListaEstoques;
    DSP_MP: TDataSetProvider;
    cds_itemsMP: TClientDataSet;
    ds_itemsMP: TDataSource;
    cds_itemsMPPRE_CODIGO: TIntegerField;
    cds_itemsMPPRE_CODORP: TIntegerField;
    cds_itemsMPPRO_CODIGO: TIntegerField;
    cds_itemsMPPRO_DESCRICAO: TWideStringField;
    cds_itemsMPPRE_QTDUNI: TBCDField;
    cds_itemsMPQTDE_LOTE_INFO: TFMTBCDField;
    Pnl_MP_Botoes: TPanel;
    Sb_Ins_MP: TSpeedButton;
    Sb_Alt_MP: TSpeedButton;
    Sb_Exc_MP: TSpeedButton;
    Sb_Lote_MP: TSpeedButton;
    Sb_Gerar_MP: TSpeedButton;
    Qr_Mp_Similar: TSTQuery;
    Qr_Mp_SimilarTB_PRODUCT_ID_SIMILAR: TIntegerField;
    Qr_Mp_SimilarCLT_DT_VENCIMENTO: TDateField;
    Qr_Mp_SimilarCLT_QT_SALDO: TBCDField;
    Qr_Mp_SimilarPRO_DESCRICAO: TStringField;
    tbs_embalagem: TTabSheet;
    Pnl_PA_Lista: TPanel;
    DBG_PA: TDBGrid;
    Pnl_PA_Botoes: TPanel;
    Sb_Ins_PA: TSpeedButton;
    Sb_Alt_PA: TSpeedButton;
    Sb_Exc_PA: TSpeedButton;
    cds_itemsPA: TClientDataSet;
    ds_itemsPA: TDataSource;
    DSP_PA: TDataSetProvider;
    cds_itemsPAORL_CODIGO: TIntegerField;
    cds_itemsPAORL_CODORP: TIntegerField;
    cds_itemsPAPRO_CODIGO: TIntegerField;
    cds_itemsPAPRO_DESCRICAO: TWideStringField;
    cds_itemsPAORL_QTDTOT: TBCDField;
    cds_itemsPAQTDE_LOTE_INFO: TFMTBCDField;
    Sb_Lote_PA: TSpeedButton;
    Sb_Imp_Mp: TSpeedButton;
    Pnl_PA_totalizador: TPanel;
    Pnl_MP_Totalizador: TPanel;
    Label9: TLabel;
    E_VL_Custo_Producao: TPanel;
    cds_itemsMPSUBTOTAL_CUSTO: TFloatField;
    Qr_Mp_SimilarPRO_VL_CUSTO: TFMTBCDField;
    cds_itemsMPSUBTOTAL: TFloatField;
    popMenuMP: TPopupMenu;
    Informa1: TMenuItem;
    popMenuPA: TPopupMenu;
    MenuItem1: TMenuItem;
    Qr_Lote_MP_DisponivelPRO_DESCRICAO: TStringField;
    Qr_Lote_MP_DisponivelCLT_CODIGO: TIntegerField;
    Qr_Lote_MP_DisponivelCLT_NUMERO: TStringField;
    Qr_Lote_MP_DisponivelCLT_DT_VENCIMENTO: TDateField;
    Qr_Lote_MP_DisponivelCLT_QT_SALDO: TBCDField;
    procedure Sb_Info_Lote_PAClick(Sender: TObject);
    procedure Sb_Gerar_MPClick(Sender: TObject);
    procedure Sb_Lote_MPClick(Sender: TObject);
    procedure Sb_Ins_MPClick(Sender: TObject);
    procedure Pnl_MP_BotoesClick(Sender: TObject);
    procedure Sb_Alt_MPClick(Sender: TObject);
    procedure Sb_Exc_MPClick(Sender: TObject);
    procedure Sb_Imp_MpClick(Sender: TObject);
    procedure Sb_Ins_PAClick(Sender: TObject);
    procedure Sb_Alt_PAClick(Sender: TObject);
    procedure Sb_Exc_PAClick(Sender: TObject);
    procedure Sb_Lote_PAClick(Sender: TObject);
    procedure E_Qtde_ProduzirExit(Sender: TObject);
    procedure Informa1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private
    { Private declarations }
    FLote : TControllerMovimentoLote;

    function ValidaAberturaLoteMP:Boolean;
    procedure AberturaloteMP;

    function ValidaAberturaLotePA:Boolean;
    procedure AberturalotePA;

    function validaMapaMateriaPrima:boolean;
    procedure AplicaMateriaPrima;
    function ValidaInsereLoteMp:Boolean;
    procedure AplicaLoteMPautomatico;
    function  AplicaInsereLoteMPautomatico:Real;
    procedure Adiciona_mp_similar(CodigoProduto:Integer;ConsPrevisto,Qtde:Real);
    procedure AplicaLoteMP;

    function ValidaLancaAutoEmbalagem:Boolean;
    procedure AplicaLotePA;
    procedure LancaAutoReembalagem;
    function ValidaInsereLotePAReembalagem:Boolean;
    procedure AplicaLotePAReembalagem;

    function ValidaExisteLoteProdutoAcabado:boolean;
    function ValidaLoteListaProdutoAcabado:Boolean;

    function ValidaLoteListaMateriaPrima:Boolean;
    function validaimpressao:Boolean;
    procedure ImprimirMapaMP;

  protected

    //Variaveis
    procedure CriarVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
    procedure setPerfil;Override;
    procedure ImagemBotao;Override;
    //Teclas de atalhos
    procedure execShorCutKeyF2;Override;
    procedure execShorCutKeyF3;Override;
    procedure execShorCutKeyF4;Override;
    procedure execShorCutKeyF7;Override;
    procedure execShorCutKeyF8;Override;
    //
    procedure ShowData;Override;
    procedure ShowNoData;Override;

    procedure ShowDataOrder;
    procedure ShowDatalisttItemsMP();
    procedure ShowDatalisttItemsPA();
    //
    procedure TotalizadorCustoProducao;

    //inserir
    function ValidaInsert():boolean;Override; //// QIQIQIQIQIQ ADRIANO
    procedure Insert;Override;
    //Editar
    function ValidateChange():boolean;Override;
    procedure Change;Override;
    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;
    //Salvar
    function ValidateProducao():boolean;
    function ValidateSave():boolean;Override;
    procedure Save;Override;
    procedure SaveOrder;
    procedure SaveItemsMP;

    function ValidaEncerramento:Boolean;
    procedure EncerraProducao;
    procedure CancelaEncerraProducao;
    procedure AtualizaEstoqueMateriaPrima;
    procedure AtualizaEstoqueProdutoAcabado;

    procedure EditionControl;Override;
  public
    { Public declarations }
    Producao : TControllerProduction;
    CtrlLote : TControllerCtrlLote;
  end;

var
  TasProduction: TTasProduction;

implementation

{$R *.dfm}

uses     Un_Ctrl_Lote_Entrada, RN_Permissao, UN_Principal, env, Un_DM, UN_Sistema, Un_Ctrl_Lote_Saida, Un_Msg, tas_lanca_item_production_mp, un_frx_ReportProducaoMP, tas_lanca_item_production_pa,
  RN_Estoque, RN_Lotes;
procedure TTasProduction.AberturaloteMP;
Var
  Lc_Form : TFr_Ctrl_Lote;
begin
  Lc_Form := TFr_Ctrl_Lote.Create(nil);
  Lc_Form.CodigoVinculo := cds_itemsMPPRE_CODIGO.AsInteger;
  Lc_Form.Codigoproduto := cds_itemsMPPRO_CODIGO.AsInteger;
  Lc_Form.Sentido       := 'S';
  Lc_Form.AutoPreenchimento := True;
  try
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TTasProduction.AberturalotePA;
Var
  Lc_Form : TFr_Ctrl_Lote;
begin
  Lc_Form := TFr_Ctrl_Lote.Create(nil);
  Lc_Form.CodigoVinculo := cds_itemsPAORL_CODIGO.AsInteger;
  Lc_Form.Codigoproduto := cds_itemsPAPRO_CODIGO.AsInteger;
  Lc_Form.Sentido       := 'E';
  Lc_Form.AutoPreenchimento := True;
  try
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TTasProduction.Adiciona_mp_similar(CodigoProduto:Integer;ConsPrevisto,Qtde:Real);
Var
  LcSaldoLote : Real;
  LcNewQtde : Real;
begin
  Qr_Mp_Similar.Active := False;
  Qr_Mp_Similar.ParamByName('tb_product_id_master').AsInteger := CodigoProduto;
  Qr_Mp_Similar.Active := True;
  Qr_Mp_Similar.FetchAll;
  Qr_Mp_Similar.First;
  while not Qr_Mp_Similar.Eof do
  Begin
    LcSaldoLote := Qr_Mp_SimilarCLT_QT_SALDO.AsCurrency;
    if ( LcSaldoLote > 0) and (Qtde > 0) then
    Begin
      if ( LcSaldoLote > Qtde) then
        LcNewQtde := Qtde
      else
        LcNewQtde := LcSaldoLote;
      //Ajusta as variaveis para saber se faré o proximo loop caso tenho oustros produtos similares
      Qtde        := Qtde - LcNewQtde;

      //Insere no banco de dados
      with Producao do
      BEgin
        ProducaoPrevista.Registro.Codigo        := 0;
        ProducaoPrevista.Registro.Ordem         := Producao.Registro.Codigo;
        ProducaoPrevista.Registro.Produto       := Qr_Mp_SimilarTB_PRODUCT_ID_SIMILAR.AsInteger;
        ProducaoPrevista.Registro.QtdeUnitario  := ConsPrevisto;
        ProducaoPrevista.Registro.ValorCusto    := Qr_Mp_SimilarPRO_VL_CUSTO.AsCurrency;
        ProducaoPrevista.insere;
      End;
      //Insere no dataset
      cds_itemsMP.Append;
      cds_itemsMPPRE_CODIGO.AsInteger         := Producao.ProducaoPrevista.Registro.Codigo;
      cds_itemsMPPRE_CODORP.AsInteger         := Producao.Registro.Codigo;
      cds_itemsMPPRO_CODIGO.AsInteger         := Qr_Mp_SimilarTB_PRODUCT_ID_SIMILAR.AsInteger;
      cds_itemsMPPRO_DESCRICAO.AsString       := Qr_Mp_SimilarPRO_DESCRICAO.AsString;
      cds_itemsMPPRE_QTDUNI.AsFloat           := ConsPrevisto;
      cds_itemsMPSUBTOTAL.AsCurrency             := ConsPrevisto * StrToFloatDef(E_Qtde_Produzir.Text,0);
      cds_itemsMPSUBTOTAL_CUSTO.AsCurrency       := Producao.ProducaoPrevista.Registro.ValorCusto * cds_itemsMP.FieldByName('SUBTOTAL').AsCurrency;
      cds_itemsMPQTDE_LOTE_INFO.AsFloat       := 0;
      cds_itemsMP.Post;
    End;
    Qr_Mp_Similar.Next;
  End;

  if Qtde > 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Atenção não tem lote suficiente para o produtos similar '+EOLN+
                   Qr_Mp_SimilarPRO_DESCRICAO.AsString+EOLN+
                   'Verifiqque'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
  End;
end;

function TTasProduction.AplicaInsereLoteMPautomatico:real;
Var
  LcSaldoMP : Real;
  LcProdOrig : Integer;
  LcSldLote : Real;
  LcQtdeLote : Real;
begin
  LcSaldoMP   := cds_itemsMPSUBTOTAL.AsCurrency - cds_itemsMPQTDE_LOTE_INFO.AsFloat;
  //Guarda o codcódcódcódigo do produto caso o saldo do lote não seja o suficiente e tenha que chamar o similar
  LcProdOrig :=  cds_itemsMPPRO_CODIGO.AsInteger;
  Qr_Lote_MP_Disponivel.Active := False;
  Qr_Lote_MP_Disponivel.ParamByName('materiaprima').AsInteger := cds_itemsMPPRO_CODIGO.AsInteger;
    Qr_Lote_MP_Disponivel.Active := True;
  Qr_Lote_MP_Disponivel.FetchAll;
  Qr_Lote_MP_Disponivel.First;
  if Qr_Lote_MP_Disponivel.RecordCount > 0 then
  Begin
    LcSldLote := Qr_Lote_MP_DisponivelCLT_QT_SALDO.AsCurrency;
    if (LcSldLote >= LcSaldoMP) then
    Begin
      //Informa a quantidade para repassar ao movimento do estoque
      LcQtdeLote := LcSaldoMP;
    End
    else
    Begin
      //Informa a quantidade para repassar ao movimento do estoque
      LcQtdeLote := LcSldLote;
    End;
    //Atualizar o saldo para saber se vamos passar para o proximo Lote
    LcSaldoMP := LcSaldoMP - LcQtdeLote;
    Fc_AtualizaMovimentoLote('0',
                             Qr_Lote_MP_DisponivelCLT_CODIGO.AsString,
                             DateToStr(Date),
                             'PRODUÇÃO M.P.',
                             cds_itemsMPPRE_CODIGO.AsString,
                             'S',
                             FloatToStr(LcQtdeLote),
                             '',
                             concat('SISTEMA','-',DateTimeToStr(Now)),
                             0);
    //Atualiza o saldo do lote informado na grade
    cds_itemsMP.Edit;
    cds_itemsMPQTDE_LOTE_INFO.AsFloat := cds_itemsMPQTDE_LOTE_INFO.AsFloat + LcQtdeLote;
    cds_itemsMP.Post;
    REsult := LcSaldoMP;
  End
  else
  Begin
    REsult :=LcSaldoMP;
  End;
end;

procedure TTasProduction.AplicaLoteMP;
Var
  Lc_Form : TFr_Ctrl_Lote_Saida;
begin
  Lc_Form := TFr_Ctrl_Lote_Saida.Create(nil);
  Lc_Form.It_Cd_Item := cds_itemsMPPRE_CODIGO.AsInteger;
  Lc_Form.It_Tipo := 'PRODUÇÃO M.P.';
  Lc_Form.it_Cd_produto := cds_itemsMPPRO_CODIGO.AsInteger;
  Lc_Form.It_Cd_Empresa := Gb_CodMha;
  Lc_Form.It_Qtde_Lote := cds_itemsMPSUBTOTAL.AsCurrency;
  try
    Lc_Form.ShowModal;
  finally
    ShowDatalisttItemsMP;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TTasProduction.AplicaLoteMPautomatico;
Var
  LcSldLote : Real;
  LcSaldoMP   : Real;
  LcQtdeLote  : REal;
  Lc_Lst_Lote : TStringList;
  LcProdOrig : Integer;
  LcConsPrev : Real;
  LcConsReal : Real;
  LcNovaQtdeProduzida : Integer;
  Lc_CodigoProduto : Integer;
Label
  Reinicia;
begin
  Lc_Lst_Lote := TStringList.Create;
  Lc_Lst_Lote.Clear;
Reinicia:
  {O sistema procura lote da MP informada, se não encontra então devemos zerar a quantidade da MP original e
    incluir um produto similar (se houver).
    Também altera a quantidade caso tenha algum saldo de lote do produto. O restante incluido
    na quantidade do produto similar se houver
  }
  cds_itemsMP.First;
  while not cds_itemsMP.eof do
  Begin
    if cds_itemsMPQTDE_LOTE_INFO.AsFloat = 0 then
    Begin
      Repeat
        LcSaldoMP := AplicaInsereLoteMPautomatico;
        //Adiciona o numero do lote para ser atualizados
        Lc_Lst_Lote.Clear;
        if Qr_Lote_MP_DisponivelCLT_CODIGO.AsInteger > 0 then
        Begin
          Lc_Lst_Lote.Add(IntToStr(Qr_Lote_MP_DisponivelCLT_CODIGO.AsInteger));
          CtrlLote.Movimento.AtualizaSaldoLote(Lc_Lst_Lote);
        End;
        Qr_Lote_MP_Disponivel.Next;
      Until (Qr_Lote_MP_Disponivel.eof) or (LcSaldoMP <= 0) ;
      //Se o saldo da Materia prima for maior que zero então criar produto similar repassando a quantidade para ele
      if ( LcSaldoMP > 0 ) then
      Begin
        LcConsPrev := cds_itemsMPPRE_QTDUNI.AsFloat;
        if cds_itemsMPQTDE_LOTE_INFO.AsFloat > 0 then
        Begin

          //Atualiza o Consumo real no item a partir da quantidade de lote informada
          LcNovaQtdeProduzida := Trunc( cds_itemsMPQTDE_LOTE_INFO.AsFloat / LcConsPrev );
          LcConsReal := cds_itemsMPQTDE_LOTE_INFO.AsFloat;
          //Insere no banco de dados
          with Producao do
          BEgin
            ProducaoPrevista.Registro.Codigo        := cds_itemsMPPRE_CODIGO.AsInteger;
            ProducaoPrevista.Registro.Ordem         := cds_itemsMPPRE_CODORP.AsInteger;
            ProducaoPrevista.Registro.Produto       := cds_itemsMPPRO_CODIGO.AsInteger;
            ProducaoPrevista.Registro.QtdeUnitario  := cds_itemsMPPRE_QTDUNI.AsFloat;
            ProducaoPrevista.salva;
          End;
        End;
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Atenção não tem Matéria Prima suficiente do produto '+EOLN+
                       cds_itemsMPPRO_DESCRICAO.AsString +EOLN+EOLN+
                       'Verifique o lote deste item ou delete ele da lista.' +EOLN+
                       'O sistema vai inserir um produto similar caso ele tenha sido informado.'+EOLN+EOLN+
                       'Você pode optar por reduzir a quantidade a produzir.'  +EOLN+
                       'Se optar por reducão da producão, retire os produtos desta lista  e reincie o processo  '+EOLN,
                       ['OK'],[bEscape],mpAlerta);
        Lc_CodigoProduto := cds_itemsMPPRO_CODIGO.AsInteger;
        //deleta o item que foi processado esta lista sera aberta ao final
        cds_itemsMP.delete;

        //Atualiza a quantidade prevista para o novo item a ser inserido
        Adiciona_mp_similar(Lc_CodigoProduto,LcConsPrev,LcSaldoMP);
      End;
    End
    else
    Begin
      cds_itemsMP.delete;
    End;
    goto Reinicia;
  End;
end;

procedure TTasProduction.AplicaLotePA;
Var
  Lc_Form : TFr_Ctrl_Lote_Entrada;
begin
  try
    Lc_Form := TFr_Ctrl_Lote_Entrada.Create(nil);
    Lc_Form.It_Cd_Item := Producao.Registro.Codigo;
    Lc_Form.It_Tipo := 'PRODUÇÃO P.A. (U)';
    Lc_Form.it_Cd_produto := StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0);
    Lc_Form.It_Cd_Empresa := Gb_CODMHA;
    Lc_Form.It_Qtde_Lote := StrToFloatDef(E_Qtde_Produzida.Text,0);
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
  end;
end;


procedure TTasProduction.AplicaLotePAReembalagem;
Var
  Lc_Form : TFr_Ctrl_Lote_Entrada;
begin
  Lc_Form := TFr_Ctrl_Lote_Entrada.Create(nil);
  Lc_Form.It_Cd_Item        := cds_itemsPAORL_CODIGO.AsInteger;
  Lc_Form.It_Tipo           := 'PRODUÇÃO P.A.';
  Lc_Form.it_Cd_produto     := cds_itemsPAPRO_CODIGO.AsInteger;
  Lc_Form.It_Cd_Empresa     := Gb_CODMHA;
  Lc_Form.It_Qtde_Lote      := cds_itemsPAORL_QTDTOT.AsFloat;
  Lc_Form.It_Nr_Lote        := E_Numero.Text;
  Lc_Form.It_Dt_Lote        := DateToStr(Date);
  Lc_Form.It_Dt_Vencimento  := DateToStr(Date+20);
  try
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
    ShowDatalisttItemsPA;
  end;
end;

procedure TTasProduction.AplicaMateriaPrima;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
              'SELECT                               ',
              '  ft.FTC_CODVCL,                     ',
              '  ft.ftc_cs_unit,                    ',
              '    p.pro_vl_custo                   ',
              'FROM TB_FICHA_TECNICA ft             ',
              '  inner join tb_produto p            ',
              '  on (p.pro_codigo = ft.ftc_codvcl)  ',
              'where (ft.ftc_codpro=:PRO_CODIGO)    ',
              '   AND (FTC_TIPO = ''F'')            '
      ));
      ParamByName('PRO_CODIGO').AsInteger := StrToIntDef( Fm_ListaProdutos.E_Cd_Produto.Text,0 );
      Active := True;
      first;
      if not cds_itemsMP.Active then cds_itemsMP.CreateDataSet;
      while not eof do
      Begin
        //Verifica se o item já não se encontra no na lista
        if not cds_itemsMP.Locate('PRO_CODIGO',FieldByName('FTC_CODVCL').AsInteger,[]) then
        Begin
          with Producao do
          BEgin
            ProducaoPrevista.clear;
            ProducaoPrevista.Registro.Codigo        := 0;
            ProducaoPrevista.Registro.Ordem         := Producao.Registro.Codigo;
            ProducaoPrevista.Registro.Produto       := FieldByName('FTC_CODVCL').AsInteger;
            ProducaoPrevista.Registro.QtdeUnitario  := FieldByName('ftc_cs_unit').AsFloat;
            ProducaoPrevista.Registro.ValorCusto    := FieldByName('pro_vl_custo').AsCurrency;
            ProducaoPrevista.insere;
          End;
        End;
        Next;
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TTasProduction.AtualizaEstoqueMateriaPrima;
begin
  ShowDatalisttItemsMP;
  cds_itemsMP.First;
  while not cds_itemsMP.Eof do
  Begin
    with Producao.CtrlEstoque.Registro do
    Begin
      Codigo      := 0;
      Terminal    := gb_Terminal;
      Vinculo     := 'M';
      Ordem       := Producao.Registro.Codigo;
      Item        := cds_itemsMPPRE_CODIGO.AsInteger;
      Estoque     := Producao.Registro.EstoqueMP;
      operacao    := 'S';
      Produto     := cds_itemsMPPRO_CODIGO.AsInteger;
      Quantidade  := cds_itemsMPSUBTOTAL.AsCurrency;
      Data        := Producao.Registro.DataCadastro;
      Tipo        := 'PRODUÇÃO MP';
      UpdateAt    := Now;
    End;
    Producao.CtrlEstoque.Registra;
    cds_itemsMP.Next;
  end;
end;

procedure TTasProduction.AtualizaEstoqueProdutoAcabado;
begin
  cds_itemsPA.First;
  while not cds_itemsPA.Eof do
  BEgin
    with Producao.CtrlEstoque.Registro do
    Begin
      Codigo      := 0;
      Terminal    := Gb_Terminal;
      Vinculo     := 'O';
      Ordem       := cds_itemsPAORL_CODORP.AsInteger;
      Item        := cds_itemsPAORL_CODIGO.AsInteger;
      Estoque     := Producao.Registro.EstoquePA;
      operacao    := 'E';
      Produto     := cds_itemsPAPRO_CODIGO.asInteger;
      Quantidade  := cds_itemsPAORL_QTDTOT.AsFloat;
      Data        := Producao.Registro.DataCadastro;
      Tipo        := 'PRODUÇÃO PA';
      UpdateAt    := Now;
    End;
    Producao.CtrlEstoque.Registra;
    cds_itemsPA.Next;
  End;
end;


procedure TTasProduction.CancelaEncerraProducao;
begin
  Cb_Situacao.ItemIndex := 0;
  SaveOrder;
end;

procedure TTasProduction.Change;
begin
  E_Numero.SetFocus;
end;

procedure TTasProduction.CriarVariaveis;
begin
  inherited;
  Producao  := TControllerProduction.create(Self);
  CtrlLote  := TControllerCtrlLote.create(Self);
  FLote     := TControllerMovimentoLote.create(Self);
end;


procedure TTasProduction.Delete;
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o registro de produção?' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
  Begin
    //Deleta os itens da produção
    ShowDatalisttItemsMP;
    TotalizadorCustoProducao;
    cds_itemsMP.first;
    while not cds_itemsMP.Eof do
    Begin
      FLote.registro.Sentido := 'S';
      FLote.Registro.Vinculo := cds_itemsMPPRE_CODIGO.AsInteger;
      FLote.registro.Tipo := 'PRODUÇÃO M.P.';
      FLote.deleteByVinculo;
      //DELETA O REGISTRO
      Producao.ProducaoPrevista.Registro.Codigo := cds_itemsMPPRE_CODIGO.AsInteger;
      Producao.ProducaoPrevista.delete;
      cds_itemsMP.Next
    End;

    ShowDatalisttItemsPA;
    cds_itemsPA.first;
    while not cds_itemsPA.Eof do
    Begin
      FLote.registro.Sentido := 'E';
      FLote.Registro.Vinculo := cds_itemsMPPRE_CODIGO.AsInteger;
      FLote.registro.Tipo := 'PRODUÇÃO P.A.';
      FLote.deleteByVinculo;
      //DELETA O REGISTRO
      Producao.ProducaoRealizada.Registro.Codigo := cds_itemsPAORL_CODIGO.AsInteger;
      Producao.ProducaoRealizada.delete;
      cds_itemsPA.Next
    End;
    Producao.delete;
    Self.Close;
  End;
end;

procedure TTasProduction.EditionControl;
begin
  inherited;
  Pnl_Item_Produzir.Enabled :=  ( EditionState = 'I' ) or ( EditionState = 'E' );
  Sb_Info_Lote_PA.Enabled :=  ( EditionState = 'I' ) or ( EditionState = 'E' );
  Sb_Imp_Mp.Enabled := ( EditionState = 'B' ) and (cds_itemsMP.RecordCount > 0);

  Sb_Ins_MP.Enabled :=  ( EditionState = 'I' ) or ( EditionState = 'E' );


  Sb_Alt_MP.Enabled :=  ( EditionState = 'I' ) or ( EditionState = 'E' ) and (cds_itemsMP.RecordCount > 0);
  Sb_Exc_MP.Enabled :=  ( EditionState = 'I' ) or ( EditionState = 'E' )and (cds_itemsMP.RecordCount > 0);
  Sb_Lote_MP.Enabled :=  ( EditionState = 'I' ) or ( EditionState = 'E' )and (cds_itemsMP.RecordCount > 0);
  Sb_Gerar_MP.Enabled :=  ( EditionState = 'I' ) or ( EditionState = 'E' );

  Sb_Ins_Pa.Enabled :=  ( EditionState = 'I' ) or ( EditionState = 'E' );
  Sb_Alt_Pa.Enabled :=  ( EditionState = 'I' ) or ( EditionState = 'E' ) and (cds_itemsPA.RecordCount > 0);
  Sb_Exc_Pa.Enabled :=  ( EditionState = 'I' ) or ( EditionState = 'E' )and (cds_itemsPA.RecordCount > 0);
  Sb_Lote_Pa.Enabled :=  ( EditionState = 'I' ) or ( EditionState = 'E' )and (cds_itemsPA.RecordCount > 0);




end;

procedure TTasProduction.EncerraProducao;
begin
  AtualizaEstoqueMateriaPrima;
  AtualizaEstoqueProdutoAcabado;
end;

procedure TTasProduction.execShorCutKeyF2;
begin
  if ( EditionState = 'I' ) or ( EditionState = 'E' ) then
  Begin
    case pg_Geral.ActivePageIndex of
      1:if Sb_Ins_MP.Enabled then Sb_Ins_MPClick(Self);
      2:if Sb_Ins_PA.Enabled then Sb_Ins_PAClick(Self);
    end;
  End
  else
  Begin
    if SB_Inserir.Enabled then SB_InserirClick(Self);
  End;
end;

procedure TTasProduction.execShorCutKeyF3;
begin
  if ( EditionState = 'I' ) or ( EditionState = 'E' ) then
  Begin
    case pg_Geral.ActivePageIndex of
      1:if Sb_Alt_MP.Enabled then Sb_Alt_MPClick(Self);
      2:if Sb_Alt_PA.Enabled then Sb_Alt_PAClick(Self);
    end;
  End
  else
  Begin
    if SB_Alterar.Enabled then SB_alterarClick(Self);
  End;
end;

procedure TTasProduction.execShorCutKeyF4;
begin
  if ( EditionState = 'I' ) or ( EditionState = 'E' ) then
  Begin
    case pg_Geral.ActivePageIndex of
      1:if Sb_Exc_MP.Enabled then Sb_Exc_MPClick(Self);
      2:if Sb_Exc_PA.Enabled then Sb_Exc_PAClick(Self);
    end;
  End
  else
  Begin
    if SB_Excluir.Enabled then SB_ExcluirClick(Self);
  End;

end;

procedure TTasProduction.execShorCutKeyF7;
begin
  if ( EditionState = 'I' ) or ( EditionState = 'E' ) then
  Begin
    case pg_Geral.ActivePageIndex of
      1:if Sb_Lote_MP.Enabled then Sb_Lote_MPClick(Self);
      2:if Sb_Lote_PA.Enabled then Sb_Lote_PAClick(Self);
    end;
  End
  else
  Begin
    if SB_Gravar.Enabled then SB_gravarClick(Self);
  End;
end;

procedure TTasProduction.execShorCutKeyF8;
begin
  if ( EditionState = 'I' ) or ( EditionState = 'E' ) then
  Begin
    case pg_Geral.ActivePageIndex of
      1:if Sb_Gerar_MP.Enabled then Sb_Gerar_MPClick(Self);
    end;
  End
  else
  Begin
    if SB_Cancelar.Enabled then SB_CancelarClick(Self);
  End;
end;

procedure TTasProduction.E_Qtde_ProduzirExit(Sender: TObject);
begin
  inherited;
  if StrToIntDef(E_Qtde_Produzida.Text,0) = 0 then
    E_Qtde_Produzida.Text := E_Qtde_Produzir.Text;

end;

procedure TTasProduction.FinalizaVariaveis;
begin
  FreeAndNil(Producao);
  FreeAndNil(CtrlLote);
  FreeAndNil(FLote);
  inherited;
end;

procedure TTasProduction.FormataTela;
begin
  inherited;
  pg_Geral.ActivePage := tbs_Producao;
end;

procedure TTasProduction.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(Sb_Gerar_MP,'EXPORTAR');
  CarregaImagemBotao(Sb_Ins_MP,'INSERIR');
  CarregaImagemBotao(Sb_Alt_MP,'ALTERAR');
  CarregaImagemBotao(Sb_Exc_MP,'EXCLUIR');
  CarregaImagemBotao(Sb_Lote_MP,'ENCERRAR');
  //PA
  CarregaImagemBotao(Sb_Ins_Pa,'INSERIR');
  CarregaImagemBotao(Sb_Alt_Pa,'ALTERAR');
  CarregaImagemBotao(Sb_Exc_Pa,'EXCLUIR');
  CarregaImagemBotao(Sb_Lote_Pa,'ENCERRAR');
  CarregaImagemBotao(Sb_Imp_Mp,'IMPRIMIR');
end;

procedure TTasProduction.Informa1Click(Sender: TObject);
Begin
  if ValidaAberturaLoteMP then
    AberturaloteMP;

End;

procedure TTasProduction.IniciaVariaveis;
begin
  Fm_ListaEstoquesPA.AtivaLista(Gb_CodMha);
  Fm_ListaEstoquesMP.AtivaLista(Gb_CodMha);
  Producao.Registro.Codigo := CodigoRegistro;
  Producao.getbyId;
  inherited;
end;

procedure TTasProduction.Insert;
begin
  E_Numero.SetFocus;
  Dtp_Cadastro.DateTime := Date;
  Dtp_Prevista.DateTime := Date;
  edDtInicio.Text := DateToStr(Date);
  edDtFim.Text := DateToStr(Date);
end;

procedure TTasProduction.LancaAutoReembalagem;
begin
  with Producao.ProducaoRealizada do
  Begin
    Registro.Codigo := 0;
    Registro.Ordem := Producao.Registro.Codigo;
    Registro.Produto := StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0);
    Registro.QtdeProduzida := StrToFloatDef(E_Qtde_Produzida.Text,1);
    Producao.ProducaoRealizada.insere;
    //LAnca na Grid
    cds_itemsPA.Append;
    cds_itemsPAORL_CODIGO.AsInteger   := Registro.Codigo;
    cds_itemsPAORL_CODORP.AsInteger   := Registro.Ordem;
    cds_itemsPAPRO_CODIGO.AsInteger   := Registro.Produto;
    cds_itemsPAPRO_DESCRICAO.AsString := Fm_ListaProdutos.E_Busca_Produto.Text;
    cds_itemsPAORL_QTDTOT.AsFloat     := Registro.QtdeProduzida;
    cds_itemsPA.Post;
  End;
end;

procedure TTasProduction.MenuItem1Click(Sender: TObject);
begin
  if ValidaAberturaLotePA then
    AberturalotePA;
end;

procedure TTasProduction.Pnl_MP_BotoesClick(Sender: TObject);
Var
  Form : TTasLancaItemProductionMP;
begin
  Try
    Form := TTasLancaItemProductionMP.create(nil);
//    Form.CodigoRegistro := cds_itemMP;
    Form.showModal;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TTasProduction.Save;
begin
  if Cb_Situacao.Text = 'Finalizada' then
  Begin
    if ValidaEncerramento then
    Begin
      SaveOrder;
      SaveItemsMP;
      EncerraProducao;
    End;
  End
  else
  Begin
    SaveOrder;
    SaveItemsMP;
  End;
end;

procedure TTasProduction.SaveItemsMP;
begin

end;

procedure TTasProduction.SaveOrder;
begin
  With Producao do
  begin
    Registro.Numero := E_Numero.Text;
    Registro.DataCadastro := Dtp_Cadastro.Date;
    Registro.DataPrevista := Dtp_Prevista.Date;
    //Ativo / Inativo / Produzindo / Finalizado
    Registro.Situacao := UpperCase(Copy(Cb_Situacao.Text,1,1));
    Registro.Produto := StrToIntDef( Fm_ListaProdutos.E_Cd_Produto.Text,0 );
    Registro.QtdePrevista := StrToFloatDef( E_Qtde_Produzir.Text , 0);
    if (edDtInicio.Text <> '  /  /    ' ) then
      registro.DataInicio := StrToDate(edDtInicio.Text)
    else
      registro.DataInicio := 0;
    if (edDtFim.Text <> '  /  /    ' ) then
      registro.DataFinal := StrToDate(edDtFim.Text)
    else
      registro.DataFinal := 0;
    Registro.QtdeProduzida := StrToFloatDef(E_Qtde_Produzida.Text,0);
    REgistro.EstoqueMP := Fm_ListaEstoquesMP.Dblcb_Estoque.KeyValue;
    REgistro.EstoquePA := Fm_ListaEstoquesPA.Dblcb_Estoque.KeyValue;
    REgistro.Estabelecimento := Gb_CodMha;
  end;
  Producao.salva;
  CodigoRegistro := Producao.Registro.Codigo;
end;

procedure TTasProduction.Sb_Alt_MPClick(Sender: TObject);
Var
  Form : TTasLancaItemProductionMP;
begin
  if not cds_itemsMP.Active then cds_itemsMP.CreateDataSet;
  if cds_itemsMP.RecordCount = 0 then
  BEgin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não há itens para Alterar.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    exit;
  End;

  Try
    Form := TTasLancaItemProductionMP.create(nil);
    Form.CodigoRegistro         := cds_itemsMPPRE_CODIGO.AsInteger;
    Form.Item.Registro.Codigo   := cds_itemsMPPRE_CODIGO.AsInteger;
    Form.Item.Registro.Ordem    := cds_itemsMPPRE_CODORP.AsInteger;
    Form.Item.Registro.Produto  := cds_itemsMPPRO_CODIGO.AsInteger;
    Form.showModal;
    if Form.Confirma then
    Begin
      cds_itemsMP.Edit;
      cds_itemsMPPRE_QTDUNI.AsFloat := Form.Item.Registro.QtdeUnitario;
      cds_itemsMPSUBTOTAL.AsCurrency  := Form.Item.Registro.QtdeUnitario * StrToFloatDef(E_Qtde_Produzir.Text,0);
      cds_itemsMP.Post;
    End;
  Finally
    FreeAndNil(Form);
    EditionControl;
  End;

end;

procedure TTasProduction.Sb_Alt_PAClick(Sender: TObject);
Var
  Form : TTasLancaItemProductionPA;
begin
  if not cds_itemsPA.Active then cds_itemsPA.CreateDataSet;
  if cds_itemsPA.RecordCount = 0 then
  BEgin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não há itens para Alterar.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    exit;
  End;

  Try
    Form := TTasLancaItemProductionPA.create(nil);
    Form.CodigoRegistro         := cds_itemsPAORL_CODIGO.AsInteger;
    Form.Item.Registro.Codigo   := cds_itemsPAORL_CODIGO.AsInteger;
    Form.Item.Registro.Ordem    := cds_itemsPAORL_CODORP.AsInteger;
    Form.Item.Registro.Produto  := cds_itemsPAPRO_CODIGO.AsInteger;
    Form.showModal;
    if Form.Confirma then
    Begin
      cds_itemsPA.Edit;
      cds_itemsPAORL_QTDTOT.AsFloat := Form.Item.Registro.QtdeProduzida;
      cds_itemsPA.Post;
    End;
  Finally
    FreeAndNil(Form);
    EditionControl;
  End;
end;

procedure TTasProduction.Sb_Exc_MPClick(Sender: TObject);
begin
  if not cds_itemsMP.Active then cds_itemsMP.CreateDataSet;
  if cds_itemsMP.RecordCount = 0 then
  BEgin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não há itens para Excluir.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    exit;
  End;

  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o item selecionado de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
  Begin
    //Deleta o Lote relacionado
    try
      FLote.registro.Sentido := 'S';
      FLote.Registro.Vinculo := cds_itemsMPPRE_CODIGO.AsInteger;
      FLote.registro.Tipo := 'PRODUÇÃO M.P.';
      FLote.deleteByVinculo;
      //DELETA O REGISTRO prevista
      Producao.ProducaoPrevista.Registro.Codigo := cds_itemsMPPRE_CODIGO.AsInteger;
      Producao.ProducaoPrevista.delete;
      cds_itemsMP.Delete;
    finally
      EditionControl;
    end;
  End;
end;

procedure TTasProduction.Sb_Exc_PAClick(Sender: TObject);
begin
  if not cds_itemsPA.Active then cds_itemsPA.CreateDataSet;
  if cds_itemsPA.RecordCount = 0 then
  BEgin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não há itens para Excluir.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    exit;
  End;

  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o item selecionado de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
  Begin
    //Deleta o Lote relacionado
    try
      FLote := TControllerMovimentoLote.Create(nil);
      FLote.Registro.Vinculo := cds_itemsPAORL_CODIGO.AsInteger;
      FLote.deleteByVinculo;
      //DELETA O REGISTRO
      Producao.ProducaoRealizada.Registro.Codigo := cds_itemsPAORL_CODIGO.AsInteger;
      Producao.ProducaoRealizada.delete;
      //
      cds_itemsPA.Delete;
    finally
      EditionControl;
    end;
  End;

end;

procedure TTasProduction.Sb_Gerar_MPClick(Sender: TObject);
begin
  if validaMapaMateriaPrima then
  Begin
    SaveOrder;
    AplicaMateriaPrima;
    ShowDatalisttItemsMP;
    AplicaLoteMpautomatico;
    ShowDatalisttItemsMP;
    TotalizadorCustoProducao;
    EditionControl;
  End;
end;

function TTasProduction.validaimpressao:Boolean;
Begin
  Result := True;
  if ( cds_itemsMP.RecordCount = 0 ) then
  Begin
    ShowDatalisttItemsMP;
    if ( cds_itemsMP.RecordCount = 0 ) then
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Não há itens selecionados.'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpAlerta);
      Result:=false;
      exit;
    End;
  End;

  if not ValidaLoteListaMateriaPrima then
  Begin
    Result:=false;
    exit;
  End;
End;

procedure TTasProduction.ImprimirMapaMP;
Var
  Form : Tfrx_ReportProducaoMP;
Begin
  Form := Tfrx_ReportProducaoMP.create(Self);
  Try
    Form.CodigoProducao := Self.Producao.Registro.Codigo;
    Form.Caption := 'MAPA DE PRODUTOS DE MATÉRIA PRIMA';
    Form.buscar;
    Form.frxBase.ShowReport;
  Finally
    FreeAndNil(Form);
  End;
End;

procedure TTasProduction.Sb_Imp_MpClick(Sender: TObject);
begin
  if validaimpressao then
  Begin
    ImprimirMapaMP;
  End;
end;

procedure TTasProduction.Sb_Lote_MPClick(Sender: TObject);
begin
  if ValidaInsereLoteMP then
  Begin
    AplicaLoteMP;
  end;
end;

procedure TTasProduction.Sb_Info_Lote_PAClick(Sender: TObject);
begin
  if ValidaLancaAutoEmbalagem then
  BEgin
    SaveOrder;
    LancaAutoReembalagem;
    pg_Geral.ActivePage := tbs_embalagem;
  End;
end;

procedure TTasProduction.Sb_Ins_MPClick(Sender: TObject);
Var
  Form : TTasLancaItemProductionMP;
begin
  Form := TTasLancaItemProductionMP.create(nil);
  Try
    SaveOrder;
    Form.CodigoRegistro         := 0;
    Form.Item.Clear;
    Form.Item.Registro.Codigo   := 0;
    Form.Item.Registro.Ordem    := Producao.Registro.Codigo;
    Form.showModal;
    if Form.Confirma then
    Begin
      if Form.Item.Registro.Codigo > 0 then
      Begin
        cds_itemsMP.Append;
        cds_itemsMPPRE_CODIGO.AsInteger   := Form.Item.Registro.Codigo;
        cds_itemsMPPRE_CODORP.AsInteger   := Form.Item.Registro.Ordem;
        cds_itemsMPPRO_CODIGO.AsInteger   := Form.Produto.Registro.Codigo;
        cds_itemsMPPRO_DESCRICAO.AsString := Form.E_Produto.Text;
        cds_itemsMPPRE_QTDUNI.AsFloat     := Form.Item.Registro.QtdeUnitario;
        cds_itemsMPSUBTOTAL.AsCurrency      := Form.Item.Registro.QtdeUnitario * StrToFloatDef(E_Qtde_Produzir.Text,0);
        cds_itemsMP.Post;
      End;
    End;
  Finally
    FreeAndNil(Form);
    EditionControl;
  End;
end;

procedure TTasProduction.Sb_Ins_PAClick(Sender: TObject);
Var
  Form : TTasLancaItemProductionPA;
begin
  Try
    SaveOrder;
    Form := TTasLancaItemProductionPA.create(nil);
    Form.CodigoRegistro         := 0;
    Form.Item.Clear;
    Form.Item.Registro.Codigo   := 0;
    Form.Item.Registro.Ordem    := Producao.Registro.Codigo;
    Form.showModal;
    if Form.Confirma then
    Begin
      if Form.Item.Registro.Codigo > 0 then
      Begin
        cds_itemsPA.Append;
        cds_itemsPAORL_CODIGO.AsInteger   := Form.Item.Registro.Codigo;
        cds_itemsPAORL_CODORP.AsInteger   := Form.Item.Registro.Ordem;
        cds_itemsPAPRO_CODIGO.AsInteger   := Form.Produto.Registro.Codigo;
        cds_itemsPAPRO_DESCRICAO.AsString := Form.E_Produto.Text;
        cds_itemsPAORL_QTDTOT.AsFloat     := Form.Item.Registro.QtdeProduzida;
        cds_itemsPA.Post;
      End;
    End;
  Finally
    FreeAndNil(Form);
    EditionControl;
  End;
end;

procedure TTasProduction.Sb_Lote_PAClick(Sender: TObject);
begin
  if ValidaInsereLotePAReembalagem then
    AplicaLotePAReembalagem;
end;

procedure TTasProduction.setPerfil;
begin
  inherited;

end;

procedure TTasProduction.ShowData;
begin
  ShowDataOrder;
  ShowDatalisttItemsMP;
  TotalizadorCustoProducao;
  ShowDatalisttItemsPA;
end;

procedure TTasProduction.ShowDatalisttItemsMP;
Var
  I : Integer;
  LcItem : TProductionForeCast;
  Lc_Valor : Real;
begin
  Producao.ProducaoPrevista.Registro.Ordem := Producao.Registro.Codigo;
  Producao.ProducaoPrevista.getlist;
  if not cds_itemsMP.Active then cds_itemsMP.CreateDataSet;
  cds_itemsMP.EmptyDataSet;
  for I := 0 to Producao.ProducaoPrevista.Lista.Count - 1 do
  Begin
    cds_itemsMP.Append;
    cds_itemsMP.FieldByName('PRE_CODIGO').AsInteger   := Producao.ProducaoPrevista.Lista[I].Codigo;
    cds_itemsMP.FieldByName('PRE_CODORP').AsInteger   := Producao.ProducaoPrevista.Lista[I].Ordem;
    cds_itemsMP.FieldByName('PRO_CODIGO').AsInteger   := Producao.ProducaoPrevista.Lista[I].Produto;
    cds_itemsMP.FieldByName('PRO_DESCRICAO').AsString := Producao.ProducaoPrevista.Produto.getField( Producao.ProducaoPrevista.Lista[I].Produto,'PRO_DESCRICAO');
    cds_itemsMP.FieldByName('PRE_QTDUNI').AsFloat     := Producao.ProducaoPrevista.Lista[I].QtdeUnitario;

    Lc_Valor := Producao.ProducaoPrevista.Lista[I].QtdeUnitario * StrToFloatDef(E_Qtde_Produzir.Text,0);
    cds_itemsMP.FieldByName('SUBTOTAL').AsCurrency      := Lc_Valor;

    Lc_Valor := Lc_Valor * StrToFloatDef(Producao.ProducaoPrevista.Produto.getField(Producao.ProducaoPrevista.Lista[I].Produto,'PRO_VL_CUSTO'),0);
    cds_itemsMP.FieldByName('SUBTOTAL_CUSTO').AsCurrency := Lc_Valor;
    Producao.ProducaoPrevista.Registro.Codigo := Producao.ProducaoPrevista.Lista[I].Codigo;
    cds_itemsMP.FieldByName('QTDE_LOTE_INFO').AsFloat := Producao.ProducaoPrevista.getSaldoLoteInfo;
    cds_itemsMP.Post;
  End;
end;

procedure TTasProduction.ShowDatalisttItemsPA;
Var
  I : Integer;
  LcItem : TProductionForeCast;
begin
  with Producao.ProducaoRealizada do
  Begin
    Registro.Ordem := Producao.Registro.Codigo;
    getlist;
    with cds_itemsPA  do
    Begin
      if not Active then CreateDataSet;
      cds_itemsPA.EmptyDataSet;
      for I := 0 to Lista.Count - 1 do
      Begin
        Append;
        FieldByName('ORL_CODIGO').AsInteger         := Lista[I].Codigo;
        FieldByName('ORL_CODORP').AsInteger         := Lista[I].Ordem;
        FieldByName('PRO_CODIGO').AsInteger         := Lista[I].Produto;
        FieldByName('PRO_DESCRICAO').AsString       := Produto.getField(Lista[I].Produto,'PRO_DESCRICAO');
        FieldByName('ORL_QTDTOT').AsFloat           := Lista[I].QtdeProduzida;
        Registro.Codigo := Lista[I].Codigo;
        FieldByName('QTDE_LOTE_INFO').AsFloat       := getSaldoLoteInfo;
        Post;
      End;
    End;
  End;
end;

procedure TTasProduction.ShowDataOrder;
begin
  With Producao do
  begin
    E_Numero.Text                 := Registro.Numero;
    Dtp_Cadastro.DateTime         := Registro.DataCadastro;
    Dtp_Prevista.DateTime         := Registro.DataPrevista;
    //Ativo / Inativo / Produzindo / Finalizado
    Cb_Situacao.ItemIndex := AnsiIndexStr(UpperCase(Registro.Situacao), ['A','I','P','F']);
    Fm_ListaProdutos.E_Cd_Produto.Text := Registro.Produto.ToString;
    Fm_ListaProdutos.E_Cd_ProdutoExit(Self);
    E_Qtde_Produzir.Text := FloatToStrF(Registro.QtdePrevista,ffFixed,10,2);
    if DateToStr(registro.DataInicio) <> '30/12/1899' then
      edDtInicio.Text := DateToSTr(registro.DataInicio)
    else
      edDtInicio.Clear;
    if DateToStr(registro.DataFinal) <> '30/12/1899' then
      edDtFim.Text := DateToSTr(registro.DataFinal)
    else
      edDtFim.Clear;
    E_Qtde_Produzida.Text := FloatToStrF(Registro.QtdeProduzida,ffFixed,10,2);
    Fm_ListaEstoquesMP.Dblcb_Estoque.KeyValue := REgistro.EstoqueMP;
    Fm_ListaEstoquesPA.Dblcb_Estoque.KeyValue := REgistro.EstoquePA;
  end;
end;

procedure TTasProduction.ShowNoData;
begin
  ClearAllFields;
  ShowDatalisttItemsMP;
  TotalizadorCustoProducao;
  ShowDatalisttItemsPA;

end;



procedure TTasProduction.TotalizadorCustoProducao;
Var
  LcValor : Real;
begin
  with cds_itemsMP  do
  Begin
    First;
    LcValor := 0;
    while not eof do
    Begin
      LcValor := LcValor + FieldByName('SUBTOTAL_CUSTO').AsCurrency;
      Next;
    End;
  End;
  E_VL_Custo_Producao.Caption := FloatToStrF(LcValor,ffNumber,10,2);
end;

function TTasProduction.ValidaAberturaLoteMP: Boolean;
begin
  Result := True;
  if cds_itemsMPQTDE_LOTE_INFO.AsFloat = 0 then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Nao informado lote neste item'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result:=false;
    exit;
  End;
end;

function TTasProduction.ValidaAberturaLotePA: Boolean;
begin
  Result := True;
  if cds_itemsPAQTDE_LOTE_INFO.AsFloat = 0 then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Nao informado lote neste item'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result:=false;
    exit;
  End;

end;

function TTasProduction.ValidaEncerramento: Boolean;
begin
  Result := True;

  if not ValidaLoteListaMateriaPrima then
  Begin
    Result:=false;
    exit;
  End;

  if not ValidaExisteLoteProdutoAcabado then
  Begin
    Result:=false;
    exit;
  End;

  if not ValidaLoteListaProdutoAcabado then
  Begin
    Result:=false;
    exit;
  End;

  ShowDatalisttItemsPA;
  if cds_itemsPA.RecordCount = 0 then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Não é possivel finalizar a produção sem que seja informado o produto acabado.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result:=false;
    exit;
  End;

  if (MensagemPadrao(TITULO_CONFIRMACAO,EOLN+
                     'A situação da produção foi marcada com finalizada?' + EOLN + EOLN +
                     'Confirmar o encerramento ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
  Begin
    Result := False;
    Exit;
  End;

  if (MensagemPadrao(MENSAGEM,
                     'A partir deste momento as seguintes operações seráo executadas' + EOLN + EOLN +
                     '1º - Saída da Matéria Prima' + EOLN +
                     'º - Entrada do Produto Acabado' + EOLN +
                     '3º - Encerramento defintivo desta produção' + EOLN + EOLN +
                     'Esta operação não tem como ser cancelada' + EOLN + EOLN +
                     'Confirma a execução?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clbtnface) = mrBotao2) then
  Begin
    Result := False;
    Exit;
  End;


end;

function TTasProduction.ValidaExisteLoteProdutoAcabado: boolean;
begin
  Result := True;
  cds_itemsPA.First;
  if  cds_itemsPA.recordCount = 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'PRODUTO ACABADO'+EOLN+EOLN+
                   'Informe o item de produzido.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    result := false;
    exit;
  End;

end;

function TTasProduction.ValidaInsereLoteMP: Boolean;
begin
  Result := True;
  if not cds_itemsMP.Active then cds_itemsMP.CreateDataSet;
  if cds_itemsMP.RecordCount = 0 then
  BEgin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não há itens para informar Lote.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  End;

end;

function TTasProduction.ValidaLancaAutoEmbalagem: Boolean;
begin
  REsult := True;
  ShowDatalisttItemsPA;
  if cds_itemsPA.recordCount > 0 then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'A Listagem de embalagem já contém itens.'+EOLN+
                   'Não é possivel fazer lançamento automaticamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result:=false;
    exit;
  End;

  if StrToFloatDef(E_Qtde_Produzida.Text,0) =0 then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Por favor informe a quantidade produzida.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result:=false;
    exit;
  End;
end;

function TTasProduction.ValidaLoteListaMateriaPrima: Boolean;
Var
  Lc_valor1,Lc_valor2 : String;
begin
  Result := True;
  cds_itemsMP.First;
  while not cds_itemsMP.eof do
  Begin
    Lc_valor1 := FloattoStrF(cds_itemsMPSUBTOTAL.AsCurrency,ffFixed,10,3);
    Lc_valor2 := FloattoStrF(cds_itemsMPQTDE_LOTE_INFO.AsFloat,ffFixed,10,3);
    if not (Lc_valor1 = Lc_valor1 ) then
    Begin
      Result := false;
      break;
    End;
    cds_itemsMP.next;
  End;

  if  not Result then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'MATÉRIA PRIMA'+EOLN+EOLN+
                   'Verifique o consumo e o lote não estão iguais no item '+EOLN+
                   cds_itemsMPPRO_DESCRICAO.AsString+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
  End;

end;

function TTasProduction.ValidaLoteListaProdutoAcabado: Boolean;
const
  EPSILON = 0.00001;
begin
  Result := True;
  cds_itemsPA.First;
  while not cds_itemsPA.eof do
  Begin
    if not (Abs( cds_itemsPAORL_QTDTOT.AsFloat - cds_itemsPAQTDE_LOTE_INFO.AsFloat  ) < EPSILON ) then
    Begin
      Result := false;
      break;
    End;
    cds_itemsPA.next;
  End;

  if  not Result then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'PRODUTO ACABADO'+EOLN+EOLN+
                   'Verifique a quantidade e o lote não estão iguais no item '+EOLN+
                   cds_itemsPAPRO_DESCRICAO.AsString+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
  End;

end;

function TTasProduction.ValidaInsereLotePAReembalagem: Boolean;
begin
  REsult := True;
  if not cds_itemsPA.Active then cds_itemsPA.Active := True;
  if cds_itemsPA.RecordCount = 0 then
  BEgin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Não há itens produzidos para informar Lote.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result:=false;
    exit;

  End;

end;

function TTasProduction.ValidaInsert: boolean;
begin
  Result := true;
end;

function TTasProduction.validaMapaMateriaPrima: boolean;
begin
  REsult := True;
  if not ValidateProducao  then
  Begin
    Result:=false;
    exit;
  End;
end;

function TTasProduction.ValidateChange: boolean;
begin
  REsult := True;
  if Producao.Registro.Situacao = 'F' then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Não é possivel manipular este registro, produção finalizada.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result:=false;
    exit;
  End;

end;

function TTasProduction.ValidateDelete: boolean;
begin
  Result := True;
  if Producao.Registro.Codigo = 0 then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Registro não encontrado.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result:=false;
    exit;
  End;

  if Producao.Registro.Situacao = 'F' then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Não é possivel manipular este registro, produção finalizada.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result:=false;
    exit;
  End;
end;

function TTasProduction.ValidateProducao: boolean;
begin
  REsult := True;
  if StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0)=0 then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Informar o código do Produto a produzir'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    pg_Geral.ActivePage := tbs_Producao;
    Fm_ListaProdutos.E_Cd_Produto.SetFocus;
    Result:=false;
    exit;
  End;

  if Trim(Fm_ListaProdutos.E_Busca_Produto.Text) = '' then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Informar a descrição do Produto a produzir'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    pg_Geral.ActivePage := tbs_Producao;
    Fm_ListaProdutos.E_Busca_Produto.SetFocus;
    Result:=false;
    exit;
  End;

  if StrToFloatDef(E_Qtde_Produzir.Text,0) =0 then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Por favor informe a quantidade a ser produzida.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result:=false;
    exit;
  End;

end;

function TTasProduction.ValidateSave: boolean;
begin
  REsult := True;
  if not ValidateProducao  then
  Begin
    Result:=false;
    exit;
  End;
end;

end.
