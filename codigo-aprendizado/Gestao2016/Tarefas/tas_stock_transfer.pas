unit tas_stock_transfer;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.ExtCtrls, Data.DB, Un_Fm_ListaEstoques, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Datasnap.DBClient, Un_DM, STQuery, Datasnap.Provider, QEdit_Setes, Vcl.DBCtrls, Vcl.Buttons, ControllerNotaFiscal;

type
  TTasStockTransfer = class(TFr_Base)
    pnl_fundo: TPanel;
    Pnl_Botton: TPanel;
    pnl_Origem: TPanel;
    pnl_estoque_Origem: TPanel;
    Lb_Titlle_Origem: TLabel;
    DBGrid1: TDBGrid;
    Fm_ListaEstoques_Origem: TFm_ListaEstoques;
    cds_estoque: TClientDataSet;
    qr_pesquisa: TSTQuery;
    DSP: TDataSetProvider;
    ds_estoque_origem: TDataSource;
    pnl_estoque_destino: TPanel;
    Lb_Titlle_Destino: TLabel;
    Fm_ListaEstoques_Destino: TFm_ListaEstoques;
    GrBx_Pesquisa: TGroupBox;
    Lb_Codigo: TLabel;
    Lb_Descricao: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LBL_CD_BARRA: TLabel;
    Label3: TLabel;
    E_BuscaCodigo: TMaskEdit;
    E_BuscaDescricao: TMaskEdit;
    E_BuscaMarca: TMaskEdit;
    E_BuscaSubgrupo: TMaskEdit;
    E_BuscaGrupo: TMaskEdit;
    E_BuscaCodBarras: TEdit_Setes;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    cds_estoquePRO_CODIGO: TIntegerField;
    cds_estoquePRO_CODIGOFAB: TWideStringField;
    cds_estoquePRO_DESCRICAO: TWideStringField;
    cds_estoqueORIGEM: TFMTBCDField;
    cds_estoqueDESTINO: TFMTBCDField;
    cds_estoqueEST_TRANSF: TBCDField;
    SB_Buscar: TSpeedButton;
    Label1: TLabel;
    E_BuscaFabrica: TMaskEdit;
    cds_estoquePRO_CODIGOBAR: TWideStringField;
    cds_estoqueGRP_DESCRICAO: TWideStringField;
    cds_estoqueSBG_DESCRICAO: TWideStringField;
    cds_estoqueMRC_DESCRICAO: TWideStringField;
    Rg_Escolhidos: TRadioGroup;
    cds_estoquePRO_VL_CUSTO: TFMTBCDField;
    procedure SB_BuscarClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cds_estoqueEST_TRANSFChange(Sender: TField);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
  private
    { Private declarations }
    NFOrigem : TControllerNotaFiscal;
    NFDestino : TControllerNotaFiscal;
    procedure ImagemBotao;Override;
    function validaBusca:Boolean;
    procedure Busca;
    procedure Filtro;
    procedure preencherListaEstoque;
    function validaTransferencia:Boolean;
    procedure LimparObjetos;
    procedure gerarPedidoOrigem;
    procedure gerarItensPedidoOrigem;
    procedure AtualizaEstoquePedidoOrigem;
    procedure gerarPedidoDestino;
    procedure gerarItensPedidoDestino;
    procedure AtualizaEstoquePedidoDestino;
    procedure faturaPedidoOrigem;
    procedure faturaPedidoDestino;
  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;

  public
    { Public declarations }
  end;

var
  TasStockTransfer: TTasStockTransfer;

implementation

{$R *.dfm}

uses     UN_Principal, env, Un_Msg, tas_prm_stock_transfer, UN_Sistema;
procedure TTasStockTransfer.AtualizaEstoquePedidoDestino;
Var
  I:Integer;
begin
  NFDestino.Pedido.Itens.Registro.CodigoPedido := NFDestino.Pedido.Registro.Codigo;
  NFDestino.Pedido.Itens.getList;
  for I := 0 to NFDestino.Pedido.Itens.Lista.Count-1 do
  Begin
    //Atualiza Estoque
    with NFDestino.Pedido.CtrlEstoque.Registro do
    Begin
      Codigo      := 0;
      Terminal    := Gb_Terminal;
      Vinculo    := 'P';
      Ordem      := NFDestino.Pedido.Registro.Codigo;
      Item       := NFDestino.Pedido.Itens.Lista[I].Codigo;
      Estoque    := NFDestino.Pedido.Itens.Lista[I].CodigoEstoque;
      operacao   := 'E';
      Produto    := NFDestino.Pedido.Itens.Lista[I].CodigoProduto;
      Quantidade := NFDestino.Pedido.Itens.Lista[I].Quantidade;
      Tipo        := 'Ajuste';
      Data       := NFDestino.Pedido.Registro.Data;
    End;
    NFDestino.Pedido.CtrlEstoque.Registra;
  End;

end;

procedure TTasStockTransfer.AtualizaEstoquePedidoOrigem;
Var
  I:Integer;
begin
  NFOrigem.Pedido.Itens.Registro.CodigoPedido := NFOrigem.Pedido.Registro.Codigo;
  NFOrigem.Pedido.Itens.getList;
  for I := 0 to NFOrigem.Pedido.Itens.Lista.Count-1 do
  Begin
    //Atualiza Estoque
    with NFOrigem.Pedido.CtrlEstoque.Registro do
    Begin
      Codigo      := 0;
      Terminal    := Gb_Terminal;
      Vinculo    := 'P';
      Ordem      := NFOrigem.Pedido.Registro.Codigo;
      Item       := NFOrigem.Pedido.Itens.Lista[I].Codigo;
      Estoque    := NFOrigem.Pedido.Itens.Lista[I].CodigoEstoque;
      operacao   := 'S';
      Produto    := NFOrigem.Pedido.Itens.Lista[I].CodigoProduto;
      Quantidade := NFOrigem.Pedido.Itens.Lista[I].Quantidade;
      Tipo        := 'Ajuste';
      Data       := NFOrigem.Pedido.Registro.Data;
    End;
    NFOrigem.Pedido.CtrlEstoque.Registra;
  End;
end;

procedure TTasStockTransfer.Busca;
begin
  Screen.Cursor := crHourGlass;
  cds_estoque.Active := False;
  with qr_pesquisa do
  Begin
    Active := False;
    sql.Clear;
    sql.Add(concat(
              'SELECT ',
              '  PRO_CODIGO ',
              ' ,PRO_CODIGOFAB ',
              ' ,PRO_CODIGOBAR ',
              ' ,PRO_DESCRICAO ',
              ' ,PRO_VL_CUSTO ',
              ' ,GRP_DESCRICAO ',
              ' ,SBG_DESCRICAO ',
              ' ,MRC_DESCRICAO ',
              ' ,EO.est_qtde ORIGEM ',
              ' ,ED.est_qtde DESTINO ',
              ' ,CAST(0.0 AS NUMERIC(18, 1)) EST_TRANSF ',
              'FROM TB_PRODUTO P ',
              '  INNER JOIN TB_GRUPOS Gp ',
              '  ON (P.PRO_CODGRP = Gp.GRP_CODIGO) ',
              '  INNER JOIN TB_SUBGRUPOS SB ',
              '  ON (P.PRO_CODSBG = SB.SBG_CODIGO) ',
              '  left OUTER JOIN TB_MARCA_PRODUTO MR ',
              '  ON (P.PRO_CODMRC = MR.MRC_CODIGO ) ',
              '  LEFT OUTER JOIN tb_estoque EO ',
              '  ON (P.pro_codigo = EO.est_codpro) ',
              '  LEFT OUTER JOIN tb_estoque ED ',
              '  ON (P.pro_codigo = ED.est_codpro) ',
              'WHERE (EO.est_qtde > 0 ) and ( p.pro_ativo = ''S'' ) ',
              ' and ( EO.est_codets = :ORIGEM  ) ',
              ' AND ( ED.est_codets = :DESTINO ) ',
              ' AND ( PRO_TIPO <> ''S'') '
    )) ;
    ParamByName('ORIGEM').AsInteger := Fm_ListaEstoques_Origem.Dblcb_Estoque.KeyValue;
    ParamByName('DESTINO').AsInteger := Fm_ListaEstoques_Destino.Dblcb_Estoque.KeyValue;
    Active := True;
  End;
  cds_estoque.Active := True;
    Screen.Cursor := crDefault;
end;

procedure TTasStockTransfer.cds_estoqueEST_TRANSFChange(Sender: TField);
begin
  inherited;
  if TField(Sender).AsFloat > cds_estoqueORIGEM.AsFloat then
  Begin
     TField(Sender).AsFloat := cds_estoqueORIGEM.AsFloat;
  End;

end;

procedure TTasStockTransfer.CriarVariaveis;
begin
  inherited;
  NFOrigem := TControllerNotaFiscal.Create(Self);
  NFDestino := TControllerNotaFiscal.Create(Self);

end;

procedure TTasStockTransfer.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  begin
    if (TDBGrid(Sender).Columns.Count = 6) then
    Begin
      cds_estoque.Next;
      TDBGrid(Sender).Columns[5].field.FocusControl;
    end;
  end;

end;

procedure TTasStockTransfer.faturaPedidoDestino;
begin
  with NFDestino.Registro do
  Begin
    CodigoEstabelecimento := Gb_CodMha;
    Finalidade            := '1';
    DataEmissao           := Date;
    DataSaida             := Date;
    Tipo                  := 'EE';
    Serie                 := '1';
    CodigoPedido          := NFDestino.Pedido.Registro.Codigo;
    CodigoEmpresa         := NFDestino.Pedido.Registro.Empresa;
    HoraSaida             := time;
    ValorBaseICMS         := 0;
    ValorICMS             := 0;
    ValorBaseICMSST       := 0;
    ValorICMSST           := 0;
    ValorProdutos         := NFDestino.Pedido.Registro.ValorProdutos;
    ValorFrete            := 0;
    ValorSeguro           := 0;
    ValorOutrasDespesas   := 0;
    ValorIPI              := 0;
    ValorNota             := NFDestino.Pedido.Registro.ValorPedido;
    QtdeProdutos          := NFDestino.Pedido.Registro.QtdeProdutos;
    Especie               := '';
    Marca                 := '';
    PesoBruto             := '';
    PesoLiquido           := '';
    ControlaRetorno       := 'N';
    NotaVinculada         := '';
    Situacao              := 'F';
    ValorServico          := 0;
    ValorISS              := 0;
    NumeroVolume          := '';
    PlacaVeiculo          := '';
    EstadoVeiculo         := '';
    RNTC                  := '';
    CFOP                  := '0000';
    ValorISSRetido        := 0;
    Modelo                := '55';
    CodigoCFOP            := 0;
  end;
  NFDestino.insere;
end;

procedure TTasStockTransfer.faturaPedidoOrigem;
begin
  with NFOrigem.Registro do
  Begin
    CodigoEstabelecimento := Gb_CodMha;
    Finalidade            := '1';
    DataEmissao           := Date;
    DataSaida             := Date;
    Tipo                  := 'SI';
    Serie                 := '1';
    CodigoPedido          := NFOrigem.Pedido.Registro.Codigo;
    CodigoEmpresa         := NFOrigem.Pedido.Registro.Empresa;
    HoraSaida             := time;
    ValorBaseICMS         := 0;
    ValorICMS             := 0;
    ValorBaseICMSST       := 0;
    ValorICMSST           := 0;
    ValorProdutos         := NFOrigem.Pedido.Registro.ValorProdutos;
    ValorFrete            := 0;
    ValorSeguro           := 0;
    ValorOutrasDespesas   := 0;
    ValorIPI              := 0;
    ValorNota             := NFOrigem.Pedido.Registro.ValorPedido;
    QtdeProdutos          := NFOrigem.Pedido.Registro.QtdeProdutos;
    Especie               := '';
    Marca                 := '';
    PesoBruto             := '';
    PesoLiquido           := '';
    ControlaRetorno       := 'N';
    NotaVinculada         := '';
    Situacao              := 'F';
    ValorServico          := 0;
    ValorISS              := 0;
    NumeroVolume          := '';
    PlacaVeiculo          := '';
    EstadoVeiculo         := '';
    RNTC                  := '';
    CFOP                  := '0000';
    ValorISSRetido        := 0;
    Modelo                := '55';
    CodigoCFOP            := 0;
  end;
  NFOrigem.insere;
end;

procedure TTasStockTransfer.Filtro;
begin
  with cds_estoque do
  Begin
    Filtered := False;
    Filter := '( PRO_CODIGO  > 0 ) ';

    if Trim(E_BuscaCodigo.Text) <>  '' then
    Begin
      Filter := concat(Filter,
                       ' AND ( PRO_CODIGO  = ',E_BuscaCodigo.Text,' )'
      );
    End;

    if Trim(E_BuscaFabrica.Text) <> '' then
    Begin
      Filter := concat(Filter,
                       ' AND ( PRO_CODIGOFAB  = ',E_BuscaFabrica.Text,' )'
      );
    End;

   if Trim(E_BuscaDescricao.Text) <> '' then
   Begin
      Filter := concat(Filter,
                       ' AND ( PRO_DESCRICAO  = ',E_BuscaDescricao.Text,' )'
      );
   End;

   if Trim(E_BuscaCodBarras.Text) <> '' then
   Begin
      Filter := concat(Filter,
                       ' AND  ( PRO_CODIGOBAR  = ',E_BuscaCodBarras.Text,' )'
      );
   End;

   if Trim(E_BuscaGrupo.Text) <> '' then
   BEgin
      Filter := concat(Filter,
                       ' AND ( GRP_DESCRICAO  = ',E_BuscaGrupo.Text,' )'
      );
   End;

   if Trim(E_BuscaSubgrupo.Text) <> '' then
   BEgin
      Filter := concat(Filter,
                       ' AND ( SBG_DESCRICAO  = ',E_BuscaSubgrupo.Text,' )'
      );
   End;

   if Trim(E_BuscaSubgrupo.Text) <> '' then
   BEgin
      Filter := concat(Filter,
                       ' AND ( MRC_DESCRICAO  = ',E_BuscaMarca.Text,' )'
      );
   End;

   case Rg_Escolhidos.ItemIndex of
    0:BEgin
        Filter := concat(Filter,
                       ' AND ( EST_TRANSF > 0 ) '
        );
    End;
    1:BEgin
        Filter := concat(Filter,
                       ' AND ( EST_TRANSF = 0 ) '
        );
    End;
   end;

    Filtered := True;
  End;
end;

procedure TTasStockTransfer.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and  ( not (ActiveControl is TDBGrid) ) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TTasStockTransfer.gerarItensPedidoDestino;
var
  LcSeq : Integer;
begin
  with cds_estoque do
  Begin
    First;
    while not Eof do
    Begin
      with NFDestino.Pedido.Itens.Registro do
      BEgin
        Codigo            := 0;
        inc(LcSeq);
        Sequencia         := LcSeq;
        CodigoPedido      := NFDestino.Pedido.Registro.codigo;
        CodigoNota        := NFDestino.Registro.Codigo;
        CodigoProduto     := FieldByName('PRO_CODIGO').AsInteger;
        Quantidade        := FieldByName('EST_TRANSF').AsFloat;
        ValorCusto        := fIeldByName('PRO_VL_CUSTO').AsCurrency;
        ValorUnitario     := FieldByName('PRO_VL_CUSTO').AsCurrency;
        Despachar         := 'S';
        Estoque           := 'S';
        AliqComissao      := 0;
        ValorDesconto     := 0;
        AliqDesconto      := 0;
        AliqIPI           := 0;
        Operacao          := 'A';
        AliqICMS          := 0;
        CodigoEstoque     := Fm_ListaEstoques_Destino.Dblcb_Estoque.KeyValue;
        CodigoTabela      := 1;
        Altura            := 0;
        Largura           := 0;
        Sentido           := 'S';
        PedidoCompra      := '';
        ItemCompra        := '';
        ImpostoAproximado := 0;
        NumeroPecas       := 0;
      End;
      NFDestino.Pedido.Itens.insere;
      Next;
    end;
  End;
end;

procedure TTasStockTransfer.gerarItensPedidoOrigem;
var
  LcSeq : Integer;
begin
  with cds_estoque do
  Begin
    First;
    while not Eof do
    Begin
      with NFOrigem.Pedido.Itens.Registro do
      BEgin
        Codigo            := 0;
        inc(LcSeq);
        Sequencia         := LcSeq;
        CodigoPedido      := NFOrigem.Pedido.Registro.codigo;
        CodigoNota        := NFOrigem.Registro.Codigo;
        CodigoProduto     := FieldByName('PRO_CODIGO').AsInteger;
        Quantidade        := FieldByName('EST_TRANSF').AsFloat;
        ValorCusto        := fIeldByName('PRO_VL_CUSTO').AsCurrency;
        ValorUnitario     := FieldByName('PRO_VL_CUSTO').AsCurrency;
        Despachar         := 'S';
        Estoque           := 'S';
        AliqComissao      := 0;
        ValorDesconto     := 0;
        AliqDesconto      := 0;
        AliqIPI           := 0;
        Operacao          := 'A';
        AliqICMS          := 0;
        CodigoEstoque     := Fm_ListaEstoques_Origem.Dblcb_Estoque.KeyValue;
        CodigoTabela      := 1;
        Altura            := 0;
        Largura           := 0;
        Sentido           := 'S';
        PedidoCompra      := '';
        ItemCompra        := '';
        ImpostoAproximado := 0;
        NumeroPecas       := 0;
      End;
      NFOrigem.Pedido.Itens.insere;
      Next;
    end;
  End;

end;

procedure TTasStockTransfer.gerarPedidoDestino;
Var
  Lc_Qt_Produto : Real;
  Lc_Vl_Produto : Real;
  Lc_Vl_Pedido : REal;
begin
  Lc_Vl_Produto := 0;
  Lc_Qt_Produto := 0;
  Lc_Vl_Pedido  := 0;
  with cds_estoque do
  Begin
    First;
    while not Eof do
    Begin
      Lc_Vl_Produto := Lc_Vl_Produto + ( FieldByName('PRO_VL_CUSTO').AsCurrency* FieldByName('EST_TRANSF').AsFloat );
      Lc_Vl_Pedido := Lc_Vl_Pedido    + ( FieldByName('PRO_VL_CUSTO').AsCurrency* FieldByName('EST_TRANSF').AsFloat );
      Lc_Qt_Produto := Lc_Qt_Produto + FieldByName('EST_TRANSF').AsFloat;
      Next;
    end;
  End;

  with NFDestino.Pedido.Registro do
  Begin
    EmUso := '';
    Tipo := 3;
    Faturado := 'S';
    Numero := 0;
    Usuario := Gb_Cd_Usuario;
    Prazo := '';
    //Empresa := Preenchido no retorno da mensagem de confirmação
    Vendedor := 0;
    FormaPagto := 0;
    QtdeProdutos := Lc_Qt_Produto;
    ValorProdutos := Lc_Vl_Produto;
    ValorIPI := 0;
    ValorFrete := 0;
    AliqDesconto := 0;
    ValorDesconto := 0;
    ValorPedido := Lc_Vl_Pedido;
    Data := Date;
    CodigoEstabelecimento := Gb_CodMha;
    Entrega := '';
    Garantia := '';
    IndicaPresenca := 0;
    Aprovado := 'N';
    NFDestino.Pedido.Empresa.Endereco.Registro.CodigoEmpresa := Gb_CodMha;
    NFDestino.Pedido.Empresa.Endereco.getByEmpresa;
    Endereco := NFDestino.Pedido.Empresa.Endereco.Registro.Codigo;
    Observacao := 'TRANSFERENCIA DE ESTOQUE - ENTRADA - DESTINO';
    CodigoNegocio := 0;
    Transportadora := 0;
    EnderecoFaturamento := 0;
    EnderecoCobranca := 0;
  End;
  NFDestino.Pedido.Salva;
  NFDestino.Pedido.nextNumber('T');

end;

procedure TTasStockTransfer.gerarPedidoOrigem;
Var
  Lc_Qt_Produto : Real;
  Lc_Vl_Produto : Real;
  Lc_Vl_Pedido : REal;
begin
  Lc_Vl_Produto := 0;
  Lc_Qt_Produto := 0;
  Lc_Vl_Pedido  := 0;
  with cds_estoque do
  Begin
    First;
    while not Eof do
    Begin
      Lc_Vl_Produto := Lc_Vl_Produto + ( FieldByName('PRO_VL_CUSTO').AsCurrency* FieldByName('EST_TRANSF').AsFloat );
      Lc_Vl_Pedido := Lc_Vl_Pedido + ( FieldByName('PRO_VL_CUSTO').AsCurrency* FieldByName('EST_TRANSF').AsFloat );
      Lc_Qt_Produto := Lc_Qt_Produto + FieldByName('ORIGEM').AsFloat;
      Next;
    end;
  End;

  with NFOrigem.Pedido.Registro do
  Begin
    EmUso := '';
    Tipo := 3;
    Faturado := 'S';
    Numero := 0;
    Usuario := Gb_Cd_Usuario;
    Prazo := '';
    //Empresa := Preenchido no retorno da mensagem de confirmação
    Vendedor := 0;
    FormaPagto := 0;
    QtdeProdutos := Lc_Qt_Produto;
    ValorProdutos := Lc_Vl_Produto;
    ValorIPI := 0;
    ValorFrete := 0;
    AliqDesconto := 0;
    ValorDesconto := 0;
    ValorPedido := Lc_Vl_Pedido;
    Data := Date;
    CodigoEstabelecimento := Gb_CodMha;
    Entrega := '';
    Garantia := '';
    IndicaPresenca := 0;
    Aprovado := 'N';
    NFOrigem.Pedido.Empresa.Endereco.Registro.CodigoEmpresa := Gb_CodMha;
    NFOrigem.Pedido.Empresa.Endereco.getByEmpresa;
    Endereco := NFOrigem.Pedido.Empresa.Endereco.Registro.Codigo;
    Observacao := 'TRANSFERENCIA DE ESTOQUE - SAIDA - ORIGEM';
    CodigoNegocio := 0;
    Transportadora := 0;
    EnderecoFaturamento := 0;
    EnderecoCobranca := 0;
  End;
  NFOrigem.Pedido.Salva;
  NFOrigem.Pedido.nextNumber('T');

end;

procedure TTasStockTransfer.ImagemBotao;
begin
  CarregaImagemBotao(SB_Buscar,'BUSCAR');
  CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
  CarregaImagemBotao(SB_Sair_0,'SAIR');

end;

procedure TTasStockTransfer.IniciaVariaveis;
begin
  inherited;
  qr_pesquisa.Active := FAlse;
  cds_estoque.Active := False;
  //Origem
  Fm_ListaEstoques_Origem.AtivaLista(0);
  Fm_ListaEstoques_Origem.ChBx_Estoques.Enabled := True;
  Fm_ListaEstoques_Origem.Dblcb_Estoque.KeyValue := Gb_Estoque;
  //DEstino
  Fm_ListaEstoques_Destino.AtivaLista(0);
  Fm_ListaEstoques_Destino.ChBx_Estoques.Enabled := True;
  Fm_ListaEstoques_Destino.Dblcb_Estoque.KeyValue := 0;

end;

procedure TTasStockTransfer.LimparObjetos;
begin
  NFOrigem.Pedido.Itens.clear;
  NFOrigem.Pedido.Itens.Lista.Clear;
  NFOrigem.Pedido.clear;
  NFOrigem.clear;
  NFDestino.Pedido.Itens.clear;
  NFDestino.Pedido.Itens.Lista.Clear;
  NFDestino.Pedido.clear;
  NFDestino.clear;

end;

procedure TTasStockTransfer.preencherListaEstoque;
begin
end;

procedure TTasStockTransfer.SB_BuscarClick(Sender: TObject);
begin
  if validaBusca then
  Begin
    if (not cds_estoque.Active)or ( (cds_estoque.Active) and (cds_estoque.RecordCount = 0)) then
      Busca;
    Filtro;
  End;
end;

procedure TTasStockTransfer.SB_ConfirmarClick(Sender: TObject);
Var
  Lc_Escolha : Integer;
  LcForm : TTasPrmStockTransfer;
begin
  if validaTransferencia then
  Begin
    try
      LcForm := TTasPrmStockTransfer.Create(nil);
      LcForm.ShowModal;
      LimparObjetos;
      if ( LcForm.Escolha > 0 ) then
      Begin
        NFOrigem.Pedido.Registro.Empresa  := LcForm.Fm_ListaEmitenteDestinatario.DBLCB_Empresa.KeyValue;
        NFDestino.Pedido.Registro.Empresa := LcForm.Fm_ListaEmitenteDestinatario.DBLCB_Empresa.KeyValue;
      End;
      case LcForm.Escolha of
        1:Begin
            gerarPedidoOrigem;
            faturaPedidoOrigem;
            gerarItensPedidoOrigem;
            AtualizaEstoquePedidoOrigem;

            gerarPedidoDestino;
            faturaPedidoDestino;
            gerarItensPedidoDestino;
            AtualizaEstoquePedidoDestino;
            MensagemPadrao(MENSAGEM, 'S U C E S S O!.' + EOLN + EOLN +
                           'Transferência realizada com sucesso' + EOLN ,
                           ['OK'], [bEscape], mpInformacao);
            Close;
        End;
        2:Begin
            gerarPedidoOrigem;
            gerarItensPedidoOrigem;
            gerarPedidoDestino;
            gerarItensPedidoDestino;
            MensagemPadrao(MENSAGEM, 'S U C E S S O!.' + EOLN + EOLN +
                           'Ajuste de saída e entrada gerados com sucesso' + EOLN +
                           'Agora busque e fature individualmente no modo tradicional' + EOLN ,
                           ['OK'], [bEscape], mpInformacao);
            Close;
        End;
      end;




    finally
      FreeAndNil(LcForm);
    end;
  End;
end;

procedure TTasStockTransfer.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

function TTasStockTransfer.validaBusca: Boolean;
begin
  Result := True;
  if Fm_ListaEstoques_Origem.Dblcb_Estoque.Text = '' then
  BEgin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Informe o estoque de Origem.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;

  if Fm_ListaEstoques_Destino.Dblcb_Estoque.Text = '' then
  BEgin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Informe o estoque de Destino.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;

  if Fm_ListaEstoques_Origem.Dblcb_Estoque.KeyValue = Fm_ListaEstoques_Destino.Dblcb_Estoque.KeyValue then
  BEgin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'O Estoque de Destino não pode ser igual ao Origem.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;
end;

function TTasStockTransfer.validaTransferencia: Boolean;
begin
  Result := True;
  if not validaBusca then
  Begin
    REsult := FAlse;
    exit;
  End;
  if Rg_Escolhidos.ItemIndex > 0  then
  BEgin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Clique em SIM no campo produtos a serem Transferidos' + EOLN +
                   'E revise a lista dos itens.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  End;
  if cds_estoque.RecordCount = 0 then
  BEgin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Não há produtos na lista para transferência.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  End;
end;

end.
