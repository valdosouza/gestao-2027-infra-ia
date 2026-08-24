unit Un_Itens_Servico;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, ExtCtrls, Buttons, DB, StdCtrls, Mask, STStoredProc, ComCtrls, Grids, DBGrids, STQuery, ActnList, QEdit_Setes, System.Math, Actions, ControllerItensNFL, ControllerItensCotacao;

type
   TFr_Itens_Servico = class(TForm)
    Qr_Pesquisa: TSTQuery;
    Ds_Pesquisa: TDataSource;
    AcaoMostra: TActionList;
    Qr_Preco: TSTQuery;
    Action2: TAction;
    Panel1: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    lb_Aq_com: TLabel;
    Lb_DescricaoServico: TLabel;
    Label2: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label11: TLabel;
    SB_Gravar: TBitBtn;
    Sb_Pesquisar: TBitBtn;
    Sb_Sair_0: TBitBtn;
    E_Cd_Servico: TEdit;
    E_Qt_Servico: TEdit_Setes;
    E_Vl_Unitario: TEdit_Setes;
    E_Aq_Com: TEdit_Setes;
    E_Descricao: TEdit;
    E_Unidade: TEdit;
    E_VL_Desconto: TEdit_Setes;
    E_Aq_Desconto: TEdit_Setes;
    Sb_Limpar: TBitBtn;
    E_VL_Servico: TPanel;
    E_Vl_SubTotal: TPanel;
    Lb_CustoUnitario: TLabel;
    E_CustoUnitario: TEdit_Setes;
      procedure SB_GravarClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure Sb_PesquisarClick(Sender: TObject);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure E_Vl_UnitarioExit(Sender: TObject);
      procedure E_Qt_ServicoExit(Sender: TObject);
      procedure E_Cd_ServicoExit(Sender: TObject);
      procedure E_DescricaoExit(Sender: TObject);
      procedure E_Vl_UnitarioEnter(Sender: TObject);
      procedure E_Qt_ServicoEnter(Sender: TObject);
      procedure E_Cd_ServicoEnter(Sender: TObject);
      procedure E_DescricaoEnter(Sender: TObject);
      procedure E_Aq_DescontoExit(Sender: TObject);
      procedure E_VL_DescontoExit(Sender: TObject);
    procedure Sb_LimparClick(Sender: TObject);
    procedure E_UnidadeEnter(Sender: TObject);
    procedure E_Aq_DescontoEnter(Sender: TObject);
    procedure E_VL_DescontoEnter(Sender: TObject);
    procedure Sb_PesquisarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SB_GravarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure Sb_Sair_0MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
   private
    { Private declarations }
    It_Casa_Decimal : String;
   public
    { Public declarations }
    ItensNFL : TControllerItensNFL;
    ItensCTC : TControllerItensCotacao;
    It_Pedido_Vda : Boolean;
    It_OrdemServico : Boolean;
    It_Cotacao_Vda : Boolean;
    It_Cotacao_Cmv : Boolean;
    It_Cotacao_Osr : Boolean;

    It_MultiplicadorPreco: Currency;
    it_bt_pesquisa:Boolean;
    It_Inserir: Boolean;
    it_Cd_Empresa: integer;
    It_Cd_Pedido: Integer;
    It_Cd_Cotacao: Integer;
    It_Cd_Itens: Integer;
    It_Cd_Servico: Integer;
    It_Cd_Vendedor:Integer;
    //TOTALIZADORES
    It_Vl_Campanha: Currency;
    It_Aliq_Comissao: Currency;
    It_StateChange: Integer;
    IT_VL_Ant, It_Vl_Atual: Real;

      Function FC_Buscar(Pc_Codigo: string; Pc_Descricao: string):Integer;

      Procedure PC_Busca_Preco(Pc_Cd_Tabela,Pc_Cd_Servico :Integer);
      procedure Pc_MostraBusca;
      PROcedure Pc_Tip_Busca(Pc_Tipo:char; Pc_cd_Servico:String; Pc_Desc_Servico:String);
      procedure Pc_PreencheTela(Pc_Cd_Tabela : Integer;
                                Pc_Cd_Servico: string;
                                Pc_DESCRICAO: string;
                                Pc_VL_Venda: Real;
                                Pc_VL_custo : Real;
                                Pc_Unidade: string;
                                Pc_Aliq_Com: Real);

      function Fc_ValidaCampos(): Boolean;
      procedure Pc_Totalizador;
      procedure Pc_LimpaCampos;
//------------------------------------------------------------------------------
      procedure Pc_FormataTela;
      procedure Pc_IniciaVariaveis;
      procedure Pc_InserirNovoItem;

      function Fc_ExisteItemNoPedido(Pc_Tp_Operacao:String): Boolean;
      function Fc_ExisteItemNaCotacao(): Boolean;

      procedure Pc_GravaItemVenda;
      procedure Pc_GravaItemCotacaoVda;
      procedure Pc_GravaItemCotacaoCmv;
      procedure Pc_GravaItemCotacaoOsr;

      procedure Pc_StateChange(Pc_Tipo: integer);

      function Fc_Preco_Campanha(Fc_Cd_Servico : Integer):real;
      Function  Fc_Aliquota_Comissao(fc_cd_vendedor, fc_Cd_TabelaPreco,Fc_Cd_Servico:Integer):Double;
      procedure Pc_DefineCasaDecimalLocal;
      function FC_DefineTabela():Integer;
   end;

var
   Fr_Itens_Servico: TFr_Itens_Servico;

implementation

uses     Un_DM, Un_Msg, Un_Principal, env, UN_Sistema, Un_Fc_Sored_Procedures, Un_Liberacao, Un_Corte_Chapa, Un_Regra_Negocio, Un_WebService, RN_Compras, RN_Estoque, RN_Cotacao, Un_Pesq_Servico, UN_TabelasEmListas;
{$R *.dfm}

function TFr_Itens_Servico.Fc_Preco_Campanha(Fc_Cd_Servico : Integer):real;
var
  Lc_Qry: TSTQuery;
  Lc_Qtde: Real;
Begin
  try
    //Cria a Consulta de Estoques Disponiveis
    Lc_Qry := ItensNFL.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.add(concat(
                  'SELECT PRC_VL_VDA,PRC_AQ_COM ' ,
                  ' FROM TB_PRECO Tb_preco ' ,
                  ' WHERE (PRC_CODPRO=:PRC_CODPRO) AND (PRC_CODTPR=:PRC_CODTPR) '
      ));
      Active := False;
      ParamByName('PRC_CODPRO').AsInteger := fc_cd_Servico;
      ParamByName('PRC_CODTPR').AsInteger := 2;
      Active := True;
      FetchAll;
      First;
      if not IsEmpty then
      Begin
        It_Vl_Campanha := FieldByName('PRC_VL_VDA').AsCurrency;
      end
      else
      Begin
        It_Vl_Campanha := 0;
      end;
      end;
  finally
    ItensNFL.FinalizaQuery(Lc_Qry);
  end;
end;



function TFr_Itens_Servico.Fc_ExisteItemNoPedido(Pc_Tp_Operacao:String): Boolean;
var
   Lc_Qtde: Real;
   Lc_Escolha: Integer;
Begin
  Result := True;
  ItensNFL.Registro.CodigoPedido := It_Cd_Pedido;
  ItensNFL.Registro.CodigoProduto := It_Cd_Servico;
  ItensNFL.ExisteItemNoPedido(Pc_Tp_Operacao);
  if (ItensNFL.exist) and (It_StateChange = 2) then
  Begin
    Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                   'O Produto ' + E_Descricao.Text + ' já está no relação.' + EOLN + EOLN +
                                   'O que deseja fazer ?',
                                   ['Atualizar', 'Inserir','Cancelar'], [bNormal,bNormal, bEscape], mpConfirmacao, clBtnFace));
    case Lc_Escolha of
    0:Begin
        It_Cd_Itens := ItensNFL.Registro.Codigo;
        It_StateChange := 3;
        Lc_Qtde := StrToFloatDef(E_Qt_Servico.Text,0);
        E_Qt_Servico.Text := FloatToStrF(Lc_Qtde + ItensNFL.Registro.Quantidade , ffFixed, 10, 2);
        Result := true;
      end;
    1:Begin
        It_Cd_Itens := 0;
        ItensNFL.Registro.Codigo := 0;
        Result := True;
      end;
    2:Begin
        Result := False;
      end;
    end;
  end;
end;

function TFr_Itens_Servico.Fc_ExisteItemNaCotacao(): Boolean;
var
   Lc_Qtde: Real;
   Lc_Escolha: Integer;
Begin
  Result := True;
  ItensCTC.Registro.Cotacao := It_Cd_Cotacao;
  ItensCTC.Registro.Vinculo := It_Cd_Servico;
  ItensCTC.ExisteItemNoCotacao;
  if ( ItensCTC.exist ) and (It_StateChange = 2) then
  Begin
    Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                     'O Serviço ' + E_Descricao.Text + ' já está no relação.' + EOLN + EOLN +
                                     'O que deseja fazer ?',
                                     ['Atualizar', 'Inserir','Cancelar'], [bNormal,bNormal, bEscape], mpConfirmacao, clBtnFace));
    case Lc_Escolha of
    0:Begin
        It_Cd_Itens := ItensCTC.Registro.Codigo;
        It_StateChange := 3;
        Lc_Qtde := StrToFloatDef(E_Qt_Servico.Text,0);
        E_Qt_Servico.Text := FloatToStrF(Lc_Qtde + ItensCTC.Registro.Quantidade, ffFixed, 10, 2);
        Result := true;
      end;
    1:Begin
        It_Cd_Itens := 0;
        ItensCTC.clear;
        Result := True;
      end;
    2:Begin
        It_Cd_Itens := 0;
        ItensCTC.clear;
        Result := False;
      end;
    end;
  end;
end;


function TFr_Itens_Servico.FC_Buscar(Pc_Codigo: string; Pc_Descricao: string):Integer;
var
  Lc_SqlTxt: string;
  Lc_Codigo: boolean;
  Lc_Descricao: boolean;
Begin
  Screen.Cursor := crHourGlass;
  with Qr_Pesquisa do
    Begin
    Close;
    Sql.Clear;
    Lc_SqlTxt :=  'SELECT '+
                  '   PRO_CODIGO, '+
                  '   PRO_CODIGOFAB, '+
                  '   PRO_CODIGOFOR, '+
                  '   PRO_CODIGOBAR, '+
                  '   PRO_DESCRICAO, '+
                  '   PRO_VL_CUSTO,  '+
                  '   MED_ABREVIATURA, '+
                  '   PRO_CAMPANHA, '+
                  '   PRO_ATIVO, '+
                  '   PRO_COMPOSICAO, '+
                  '   PRO_SUB_TRIB '+
                  'FROM TB_PRODUTO tb_produto  '+
                  '   INNER JOIN TB_MEDIDA MED '+
                  '   ON  (MED.MED_CODIGO = tb_produto.PRO_CODMED)  '+
                  'WHERE (PRO_CODIGO IS NOT NULL) AND (PRO_ATIVO = ''S'') AND (PRO_TIPO =''S'')  ';

    if Pc_Codigo = ''    then Lc_Codigo    := False else Lc_Codigo    := True;
    if Pc_Descricao = '' then Lc_Descricao := False else Lc_Descricao := True;

    if Lc_Codigo THEN
      Lc_Sqltxt := Lc_Sqltxt + 'AND (PRO_CODIGO =:PRO_CODIGO) ';
    if Lc_Descricao then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

    if not GB_ProdCompartilha  then   Lc_SqlTxt := Lc_SqlTxt+ ' AND PRO_CODMHA = :PRO_CODMHA';

    SQL.Add(Lc_SqlTxt);

    //PASSAGEM de parametro
    if Lc_Codigo THEN
      ParamByName('PRO_CODIGO').AsString := Pc_Codigo;
    if Lc_Descricao THEN
      ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(Pc_Descricao,1,98) + '%';
    if not GB_ProdCompartilha  then
      ParamByName('PRO_CODMHA').AsInteger:=Gb_CodMha;

    Active := True;
    FetchAll;
    Result := Qr_Pesquisa.RecordCount;
    if Result = 1 THEN
      It_Cd_Servico:= FIELDBYNAME('PRO_CODIGO').AsInteger;
    end;
end;

Procedure TFr_Itens_Servico.PC_Busca_Preco(Pc_Cd_Tabela,Pc_Cd_Servico :Integer);
Begin
  Qr_Preco.Active := False;
  Qr_Preco.ParamByName('PRC_CODPRO').AsInteger := Pc_Cd_Servico;
  Qr_Preco.ParamByName('PRC_CODTPR').AsInteger := Pc_Cd_Tabela;
  Qr_Preco.Active := True;
  Qr_Preco.FetchAll;
  Qr_Preco.First;
end;


procedure TFr_Itens_Servico.Pc_PreencheTela(Pc_Cd_Tabela : Integer;
                                            Pc_Cd_Servico: string;
                                            Pc_DESCRICAO: string;
                                            Pc_VL_Venda: Real;
                                            Pc_VL_custo : Real;
                                            Pc_Unidade: string;
                                            Pc_Aliq_Com: Real);
var
   Lc_Codigo: integer;
Begin
  if (It_StateChange = 2) then
    Begin
    E_Cd_Servico.Text := Pc_Cd_Servico;
    E_Descricao.Text := COPY(Pc_DESCRICAO,1,100);
    end;

  E_Vl_Unitario.Text := formatFloat(It_Casa_Decimal,Pc_VL_Venda);
  E_CustoUnitario.Text := formatFloat(It_Casa_Decimal,Pc_VL_Custo);
  E_Qt_Servico.Text := formatFloat('#,##0.##',1);
  E_Unidade.Text := Pc_Unidade;
  E_Aq_Com.Text := FloatToStrF(Pc_Aliq_Com, ffFixed, 10, 2);

  if E_Vl_Unitario.CanFocus then E_Vl_Unitario.SetFocus;
  if E_Qt_Servico.CanFocus then E_Qt_Servico.SetFocus;
  Pc_Totalizador;
end;

procedure TFr_Itens_Servico.Pc_MostraBusca;
Var
  Lc_Form : TFr_Pesq_Servico;
begin
  Try
    Lc_Form := TFr_Pesq_Servico.Create(nil);
    Lc_Form.It_MultiplicadorPreco := It_MultiplicadorPreco;
    Lc_Form.E_BuscaCodigo.Text := E_Cd_Servico.Text;
    Lc_Form.E_BuscaDescricao.Text := E_Descricao.Text;
    Lc_Form.ShowModal;
    //Depois que Fecha o Relatorio
    if TFr_Pesq_Servico(Lc_Form).It_Visualizar then
    Begin
      E_Cd_Servico.Text:= Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
      E_Descricao.Text:='';
      E_Vl_Unitario.Text := '0';
      Pc_Tip_Busca('P', Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,'');
    end;

  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Itens_Servico.Pc_Totalizador;
Var
  Lc_Vl_aux : Real;
  Lc_Vl_Total : Real;
  Lc_Qt_aux : Real;
  Lc_VL_IPI : Real;
begin
  Lc_Vl_Total := 0;
  //Quanatidade Serviço
  Lc_Qt_aux := StrToFloatDef(E_Qt_Servico.Text, 0);
  E_Qt_Servico.Text := FloatToStrF(Lc_Qt_aux, ffFixed, 10, 2);
  //Valor dos Serviços
  Lc_Vl_aux := StrToFloatDef(E_Vl_Unitario.Text, 0);
  //Valor Subtotal Do Serviços
  Lc_Vl_aux := Lc_Vl_aux * Lc_Qt_aux;
  E_VL_Servico.Caption := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Desconto
  Lc_Vl_aux := StrToFloatDef(E_VL_Desconto.Text, 0);
  E_VL_Desconto.Text := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Valor total
  Lc_Vl_aux := StrToFloatDef(E_VL_Servico.Caption,0);
  Lc_Vl_aux := Lc_Vl_aux + Lc_VL_IPI;
  Lc_Vl_aux := Lc_Vl_aux - StrToFloatDef(E_VL_Desconto.Text, 0);
  E_Vl_SubTotal.Caption := FloattoStrf(Lc_Vl_aux,ffFixed,10,2);

end;

procedure TFr_Itens_Servico.Pc_LimpaCampos;
Begin
  ItensNFL.Registro.Codigo := 0;
  ItensCTC.Registro.Codigo := 0;

  It_Cd_Itens := 0;
  It_Cd_Servico := 0;

  E_Cd_Servico.Text := '';
  E_Descricao.Clear;
  E_Vl_Unitario.Text := '0,00';
  E_Qt_Servico.Text := '1';
  E_VL_Servico.Caption := '0,00';
  E_Unidade.Clear;
  E_Aq_Com.Text := '0,00';
  E_Aq_Desconto.Text := '0,00';
  E_VL_Desconto.Text := '0,00';
  E_Vl_SubTotal.Caption := '0,00';
end;

function TFr_Itens_Servico.Fc_ValidaCampos(): Boolean;
Begin
  Result := true;
  IF ( (Trim(E_Cd_Servico.Text) = '') or (Trim(E_Cd_Servico.Text) = '0') ) then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Código do Serviço É Obrigatório.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Cd_Servico.CanFocus then E_Cd_Servico.SetFocus;
    Result := False;
    exit;
    end;

  IF (Trim(E_Descricao.Text) = '') then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Descrição do Serviço É Obrigatório.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Cd_Servico.CanFocus then E_Cd_Servico.SetFocus;
    Result := False;
    exit;
    end;

  IF (Trim(E_Vl_Unitario.Text) = '') or (StrToFloatDef(E_Vl_Unitario.Text,0) <= 0) then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Valor Unitário É Obrigatório e maior do que zero.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Vl_Unitario.CanFocus then E_Vl_Unitario.SetFocus;
    Result := False;
    exit;
    end;

  IF (Trim(E_Qt_Servico.Text) = '') or (StrToFloatDef(E_Qt_Servico.Text,0) <= 0)then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Quantidade É Obrigatório e maior do que zero.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Qt_Servico.CanFocus then E_Qt_Servico.SetFocus;
    Result := False;
    exit;
    end;

  IF (Trim(E_Aq_Com.Text) = '') then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Comissão com conteúdo inválido.' + EOLN+
                   'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Aq_Com.CanFocus then E_Aq_Com.SetFocus;
    Result := False;
    exit;
    end;

  IF (Trim(E_Aq_Desconto.Text) = '') then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Alíquota de Desconto com conteúdo inválido.' + EOLN+
                   'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Aq_Desconto.CanFocus then E_Aq_Desconto.SetFocus;
    Result := False;
    exit;
    end;

  IF (Trim(E_VL_Desconto.Text) = '') then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Valor de Desconto com conteúdo inválido.' + EOLN+
                   'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_VL_Desconto.CanFocus then E_VL_Desconto.SetFocus;
    Result := False;
    exit;
    end;

  if not Fc_ValidaDesconto(StrToFloatDef(E_Vl_Unitario.Text,0),StrToFloatDef(E_VL_Desconto.Text,0),'000') then
    Begin
    Result:=false;
    exit;
    end;
end;

procedure TFr_Itens_Servico.Pc_StateChange(Pc_Tipo: integer);
Begin
  It_StateChange := Pc_Tipo;
  case Pc_Tipo of
    2:Begin //Inserindo
      E_Cd_Servico.Enabled := True;
      E_Descricao.Enabled := True;
      E_Qt_Servico.Enabled := True;
      SB_Gravar.Enabled := True;
      Sb_Pesquisar.Enabled := True;
      end;
    3:Begin //Alterando
      E_Cd_Servico.Enabled := False;
      E_Descricao.Enabled := False;
      E_Qt_Servico.Enabled := True;
      SB_Gravar.Enabled := True;
      Sb_Pesquisar.Enabled := True;
      end;
   end;
end;

procedure TFr_Itens_Servico.Pc_GravaItemVenda;
Begin
  if Fc_ExisteItemNoPedido('V') then
  Begin
    with ItensNFL.Registro do
    Begin
      CodigoPedido := ItensNFL.Registro.CodigoPedido;
      CodigoProduto := It_Cd_Servico;
      Quantidade := StrToFloatDef(E_Qt_Servico.Text,0);
      ValorCusto := StrToFloatDef(E_CustoUnitario.Text,0);
      ValorUnitario := StrToFloatDef(E_Vl_Unitario.Text,0);
      AliqDesconto := StrToFloatDef(E_Aq_Desconto.Text,0);
      ValorDesconto := StrToFloatDef(E_VL_Desconto.Text,0);
      AliqComissao := StrToFloatDef(E_Aq_Com.Text,0);
      Operacao := 'V';
      Estoque := 'N';
      Despachar := 'S';
      CodigoEstoque := 1;
      CodigoTabela := 1;
    End;
    ItensNFL.salva;
    It_Cd_Itens := ItensNFL.Registro.Codigo;
  end;
end;


procedure TFr_Itens_Servico.Pc_GravaItemCotacaoVda;
Begin
  if Fc_ExisteItemNaCotacao then
  Begin
    ItensCTC.Registro.Cotacao       := It_Cd_Cotacao;
    ItensCTC.Registro.Pedido        := It_Cd_Pedido;
    ItensCTC.Registro.Tipo          := 'S';
    ItensCTC.Registro.Vinculo       := It_Cd_Servico;
    ItensCTC.Registro.DEscricao     := E_Descricao.Text;
    ItensCTC.Registro.Quantidade    := StrToFloatDef(E_Qt_Servico.Text,0);
    ItensCTC.Registro.ValorUnitario := StrToFloatDef(E_Vl_Unitario.Text,0);
    ItensCTC.Registro.Disponivel    := 'S';
    ItensCTC.Registro.AliqComissao  := StrToFloatDef(E_Aq_Com.Text,0);
    ItensCTC.Registro.ValorDEsc     := StrToFloatDef(E_VL_Desconto.Text,0);
    ItensCTC.Registro.ALiqDesc      := StrToFloatDef(E_Aq_Desconto.Text,0);
    ItensCTC.Registro.AliqIPI       := 0;
    ItensCTC.Registro.AliqICMS      := 0;
    ItensCTC.Registro.CodigoEstoque := 0;
    ItensCTC.Registro.TabelaPreco   := 0;
    ItensCTC.Registro.ValorCusto    := StrToFloatDef(E_CustoUnitario.Text,0);
    //ItensCTC.Registro.MargemLucro :=
    //ItensCTC.Registro.AliqCtFinanceiro
    //ItensCTC.Registro.PRazoPraticado
    //ItensCTC.Registro.ValorPratica
    //ItensCTC.Registro.AliqVendedor
    //ItensCTC.Registro.Tecido
    //ItensCTC.Registro.Cor
    //ItensCTC.Registro.Pedido
    ItensCTC.Registro.Altura        := 0;
    ItensCTC.Registro.Largura       := 0;
    ItensCTC.save;
  end;
end;

procedure TFr_Itens_Servico.Pc_GravaItemCotacaoCmv;
Begin
  if Fc_ExisteItemNaCotacao then
    Begin
    It_Cd_Itens := Fc_AtualizaItensCotacao(IntToStr(It_Cd_Itens),
                                           IntToStr(It_Cd_Cotacao),
                                           'S',
                                           IntToStr(It_Cd_Servico),
                                           E_Descricao.Text,
                                           E_Qt_Servico.Text,
                                           E_Vl_Unitario.Text,
                                           'S',
                                           E_Aq_Com.Text,
                                           E_VL_Desconto.Text,
                                           E_Aq_Desconto.Text,
                                           '0',
                                           '0',
                                           '0',
                                           '1',
                                           E_CustoUnitario.Text,
                                           '',   //FC_MR_LUCRO,
                                           '',   //FC_ALIQ_CT_FINANCEIRO,
                                           '',   //FC_PRZ_PRATICADO,
                                           '',   //FC_VL_PRATICADO,
                                           '',   //FC_AQ_VENDEDOR,
                                           '',   //FC_TECIDO,
                                           '',   //FC_COR,
                                           IntToStr(It_Cd_Pedido));
    if (It_StateChange = 2) then
      Begin
      Pc_PreencheDespesaFinanceira(It_Cd_Itens);
      Fc_AtualizaVendaUnitario(IntToStr(It_Cd_Itens),
                               '0',
                                Fc_Tb_Geral('L','EMP_LUCRODESEJADO',''),
                                Fc_Tb_Geral('L','EMP_CUSTOFINANCEIRO',''),
                                '0',
                                '0',
                                '0');
      end;

    end;
end;

procedure TFr_Itens_Servico.Pc_GravaItemCotacaoOsr;
Begin
  if Fc_ExisteItemNaCotacao then
    Begin
    It_Cd_Itens := Fc_AtualizaItensCotacao(IntToStr(It_Cd_Itens),
                                           IntToStr(It_Cd_Cotacao),
                                           'S',
                                           IntToStr(It_Cd_Servico),
                                           E_Descricao.Text,
                                           E_Qt_Servico.Text,
                                           E_Vl_Unitario.Text,
                                           'S',
                                           E_Aq_Com.Text,
                                           E_VL_Desconto.Text,
                                           E_Aq_Desconto.Text,
                                           '0',
                                           '0',
                                           '0',
                                           '1',
                                           E_CustoUnitario.Text,
                                           '',   //FC_MR_LUCRO,
                                           '',   //FC_ALIQ_CT_FINANCEIRO,
                                           '',   //FC_PRZ_PRATICADO,
                                           '',   //FC_VL_PRATICADO,
                                           '',   //FC_AQ_VENDEDOR,
                                           '',   //FC_TECIDO,
                                           '',   //FC_COR,
                                           IntToStr(It_Cd_Pedido));
    end;
end;

procedure TFr_Itens_Servico.SB_GravarClick(Sender: TObject);
Begin
  if Fc_ValidaCampos then
  Begin
    if It_Pedido_Vda  then
      Pc_GravaItemVenda;
    if It_Cotacao_Vda then
      Pc_GravaItemCotacaoVda;
    if It_Cotacao_Cmv then
      Pc_GravaItemCotacaoCmv;
    if It_Cotacao_OSr then
      Pc_GravaItemCotacaoOsr;
    Pc_LimpaCampos;
    Pc_InserirNovoItem;        
  end;
end;


procedure TFr_Itens_Servico.FormCreate(Sender: TObject);
begin
  ItensNFL := TControllerItensNFL.create(Self);
  ItensCTC := TControllerItensCotacao.create(Self);
end;

procedure TFr_Itens_Servico.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
Begin
  if shift = [] then
    Begin
    case Key of
      VK_F5: if SB_Gravar.Enabled then  SB_GravarClick(Sender);
      VK_F7: if SB_Pesquisar.Enabled then
                Begin
                it_bt_pesquisa:=true;
                if Sb_Pesquisar.CanFocus then Sb_Pesquisar.SetFocus;
                Pc_MostraBusca;
                end;
      VK_F8: if Sb_Limpar.Enabled then  Sb_LimparClick(Sender);
      VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
    end;
end;

procedure TFr_Itens_Servico.FormKeyPress(Sender: TObject; var Key: Char);
Begin
   if (Key = #13) and not (ActiveControl is TDBMemo) then
   Begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

procedure TFr_Itens_Servico.Sb_PesquisarClick(Sender: TObject);
Begin
  it_bt_pesquisa:=true;
  Pc_MostraBusca;
end;

procedure TFr_Itens_Servico.Sb_Sair_0Click(Sender: TObject);
Begin
  Pc_LimpaCampos;
  close;
end;

procedure TFr_Itens_Servico.Pc_FormataTela;
Begin
  if ((Fc_Tb_Geral('L','VDA_G_EDIT_AQ_COM','') = 'S') and
     ((It_Pedido_Vda) or (It_Cotacao_Vda))) then
    Begin
    E_VL_Servico.Width := 79;
    lb_Aq_com.Visible := true;
    e_Aq_com.Visible := true;
    end
  else
    Begin
    E_VL_Servico.Width := 133;
    lb_Aq_com.Visible := false;
    e_Aq_com.Visible := False;
    end;
  E_Vl_Unitario.ReadOnly := False;
  IF It_Pedido_Vda and (Gb_Nivel =0) then
    Begin
    if (Fc_Tb_Geral('L','VDA_G_EDIT_VL_UNIT','S') = 'S') then
      E_Vl_Unitario.ReadOnly := False
    else
      E_Vl_Unitario.ReadOnly := True;
    end;
  if E_Cd_Servico.CanFocus then E_Cd_Servico.SetFocus;
end;

procedure TFr_Itens_Servico.Pc_IniciaVariaveis;
Begin
  Pc_DefineCasaDecimalLocal;
  it_bt_pesquisa:=FALSE;
end;


procedure TFr_Itens_Servico.Pc_InserirNovoItem;
Begin
  Pc_StateChange(2);
  if E_Cd_Servico.CanFocus then E_Cd_Servico.SetFocus;
  E_Cd_Servico.SelectAll;
end;

procedure TFr_Itens_Servico.Pc_DefineCasaDecimalLocal;
Begin
  It_Casa_Decimal := Gb_Casa_Dec_Venda;
end;

procedure TFr_Itens_Servico.E_Vl_UnitarioExit(Sender: TObject);
Begin
  E_Vl_Unitario.Text := FormatFloat(It_Casa_Decimal, StrToFloatDef(E_Vl_Unitario.Text, 0));
  Pc_Totalizador;
end;

procedure TFr_Itens_Servico.E_Qt_ServicoExit(Sender: TObject);
VAR
  Lc_Qtde: Real;
Begin
  Lc_Qtde := StrToFloatDef(E_Qt_Servico.Text, 0);
  Pc_Totalizador;
end;

procedure TFr_Itens_Servico.E_Cd_ServicoExit(Sender: TObject);
Begin
  if not it_bt_pesquisa then  // se for falso nao foi clicando no pesquisado , nem apertado f7
  Begin
    if It_StateChange = 1 then  exit;
    if (E_Cd_Servico.Text = '') THEN
    Begin
      if E_Descricao.CanFocus then E_Descricao.SetFocus;
      exit;
    end;
    if (IntToStr(It_Cd_Servico) <> E_Cd_Servico.Text) then  E_Vl_Unitario.Text := '0,00';

    if (E_Cd_Servico.Text <> '') then
      E_Descricao.Text:=''
    else
      if (IntToStr(It_Cd_Servico) <> E_Cd_Servico.Text) then  E_Vl_Unitario.Text := '0,00';

    if (E_Cd_Servico.Text <> '') then
      E_Descricao.Text:='';
    if It_StateChange = 3 THEN
      pc_Tip_Busca('P',  E_Cd_Servico.text,'')
    else
      pc_Tip_Busca('B', E_Cd_Servico.text,'');

    end;
end;

function TFr_Itens_Servico.FC_DefineTabela():Integer;
Begin
  if (Qr_Pesquisa.FieldByName('PRO_CAMPANHA').AsString = 'N') then
    Result := 1
  else
    Result := 2;
end;

Procedure TFr_Itens_Servico.Pc_Tip_Busca(Pc_Tipo:char; Pc_cd_Servico:String; Pc_Desc_Servico:String);
Var
  Lc_Nr_Itens : Integer;
  Lc_Cd_Tabela : Integer;
  Lc_Vl_Servico : Real;
Begin
  if (Pc_cd_Servico = '') and (Pc_Desc_Servico = '') then exit;
  Lc_Nr_Itens := FC_Buscar(Pc_cd_Servico,Pc_Desc_Servico);  // nao encontrou codigo de baarra pesquisa normal
  case Lc_Nr_Itens of
    0:Begin
      if It_Cotacao_Vda or It_Cotacao_Cmv then
        Begin
        It_Inserir := true;
        if E_Vl_Unitario.CanFocus then E_Vl_Unitario.SetFocus;
        end
      else
        Begin
        It_Inserir := False;
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Serviço não encontrado ou inativo.'+EOLN+
                       'Verfique e tente novamente.'+EOLN,
                        ['OK'],[bEscape],mpErro);
        Screen.Cursor := crDefault;
        Pc_LimpaCampos;
        if E_Cd_Servico.CanFocus then E_Cd_Servico.SetFocus;
        if E_Descricao.CanFocus then E_Descricao.SetFocus;
        exit;
        end;
      end;
    1:Begin
      //vERifICA SE O Serciço ESTA ATIVO
        if Qr_Pesquisa.FieldByName('PRO_ATIVO').AsString <> 'S' then
        Begin
          MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                         'Este serviço está inativo.'+EOLN+
                         'Verfique e tente novamente.'+EOLN,
                        ['OK'],[bEscape],mpErro);
          Screen.Cursor := crDefault;
          E_Cd_Servico.Clear;
          exit;
        end;
              
        if (Qr_Pesquisa.FieldByName('PRO_CAMPANHA').AsString = 'N') then
        Begin
          Lc_Cd_Tabela := 1;
          PC_Busca_Preco(1,It_Cd_Servico);
        end
        else
        Begin
          Lc_Cd_Tabela := 2;
          PC_Busca_Preco(2,It_Cd_Servico);
        end;

        Lc_Vl_Servico := Qr_Preco.FieldByName('PRC_VL_VDA').AsCurrency * It_MultiplicadorPreco;
        Pc_PreencheTela(Lc_Cd_Tabela,
                        Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,
                        Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString,
                        Lc_Vl_Servico,
                        Qr_Pesquisa.FieldByName('PRO_VL_CUSTO').AsCurrency,
                        Qr_Pesquisa.FieldByName('MED_ABREVIATURA').AsString,
                        Fc_Aliquota_Comissao(It_Cd_Vendedor, Lc_Cd_Tabela,StrToIntDef(Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,0)));
      It_Inserir:=True;
    end;
    else
      Pc_MostraBusca;
   end;
  Screen.Cursor := crDefault;
end;

procedure TFr_Itens_Servico.E_DescricaoExit(Sender: TObject);
Begin
  if not it_bt_pesquisa then  // se for falso nao foi clicando no pesquisado , nem apertado f7
    Begin
    if It_StateChange = 1 then
      exit;
    if (E_Descricao.Text = '') THEN
      Begin
      if E_Vl_Unitario.CanFocus then E_Vl_Unitario.SetFocus;
      exit;
      end;
    Pc_Tip_Busca('B','',Copy(E_Descricao.Text,1,50));
    end;
end;

procedure TFr_Itens_Servico.E_Vl_UnitarioEnter(Sender: TObject);
Begin
  E_Vl_Unitario.SelectAll;
  IT_VL_Ant := StrToFloatDef(E_Vl_Unitario.Text, 0);

end;

procedure TFr_Itens_Servico.E_Qt_ServicoEnter(Sender: TObject);
Begin
  E_Qt_Servico.SelectAll;
end;

procedure TFr_Itens_Servico.E_Cd_ServicoEnter(Sender: TObject);
Begin
  it_bt_pesquisa:=FALSE;
  E_Cd_Servico.SelectAll;
end;

procedure TFr_Itens_Servico.E_DescricaoEnter(Sender: TObject);
Begin
  it_bt_pesquisa:=FALSE;
  E_Cd_Servico.Text:='';
end;

procedure TFr_Itens_Servico.E_Aq_DescontoExit(Sender: TObject);
Var
  Lc_Aq_Desconto:Real;
  Lc_Vl_Servico : Real;
  Lc_Vl_Desconto : Real;
begin
  Lc_Vl_Servico := StrtoFloatDef(E_VL_Servico.Caption,0);
  Lc_Aq_Desconto := StrToFloatDef(E_Aq_Desconto.Text,0);
  Lc_Vl_Desconto := Lc_Vl_Servico * (Lc_Aq_Desconto/100);
  E_VL_Desconto.Text := FloatToStrf(Lc_Vl_Desconto,ffFixed,10,2);
  E_Aq_Desconto.Text := FloatToStrf(Lc_Aq_Desconto,ffFixed,10,2);
  Pc_totalizador;
end;

procedure TFr_Itens_Servico.E_VL_DescontoExit(Sender: TObject);
Var
  Lc_VL_Desconto:Real;
  Lc_Vl_Servico : Real;
  Lc_Aq_Desconto : Real;
begin
  Lc_Vl_Servico := StrtoFloatDef(E_VL_Servico.Caption,0);
  Lc_VL_Desconto := StrtoFloatDef(E_VL_Desconto.Text,0);
  Lc_Aq_Desconto := (Lc_VL_Desconto / Lc_Vl_Servico) * 100;
  Lc_Aq_Desconto := RoundTo( Lc_Aq_Desconto,-2);
  E_Aq_Desconto.Text := FloatToStrF(Lc_Aq_Desconto,ffFixed,10,2);
  Pc_totalizador;
end;

function TFr_Itens_Servico.Fc_Aliquota_comissao(fc_cd_vendedor,fc_Cd_TabelaPreco,Fc_Cd_Servico: Integer): Double;
var
  Lc_Qry : TSTQuery;
  Lc_Aq_Com : Real;
  Lc_Tp_Com : String;
  lc_txt:String;
  RecebePorServico : Boolean;
Begin
  Try
    Lc_Qry := ItensNFL.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.add(concat(
                ' select CLB_AQ_COM_VDA, CLB_AQ_COM_SRV,  ',
                ' CLB_COM_VDA, CLB_COM_SRV,CLB_CALC_COM_VDA, CLB_CALC_COM_SRV ',
                ' from tb_colaborador ',
                'where  clb_codigo =:CLB_CODIGO '
      ));
      ParamByName('CLB_CODIGO').asinteger:= fc_cd_vendedor;
      Active:=True;
      //Pega a aliquota do cadastro do vendedor
      Lc_Aq_Com := FieldByname('CLB_AQ_COM_VDA').asFloat;
      //Verifica se ele recebera por produto
      RecebePorServico := ( FieldByname('CLB_COM_VDA').asString = 'S');

      if RecebePorServico then
      Begin
        Active := false;
        SQL.Clear;
        lc_txt:='';
        lc_txt:= ' select prc_aq_com, tb_produto.pro_tipo from tb_preco '+
                 ' inner join TB_PRODUTO TB_PRODUTO on (TB_PRODUTO.PRO_CODIGO = TB_PRECO.PRC_CODPRO) '+
                 ' where '+
                 ' PRC_CODPRO = :PRC_CODPRO '+
                 ' AND PRC_CODTPR =:PRC_CODTPR ';
        SQL.Add(lc_txt);
        ParamByName('PRC_CODPRO').AsInteger:= Fc_Cd_Servico;
        ParamByName('PRC_CODTPR').AsInteger:= fc_Cd_TabelaPreco;
        Active:=True;
        Lc_Aq_Com := Lc_Aq_Com + FieldByName('prc_aq_com').asfloat;
        Lc_Tp_Com := FieldByName('pro_tipo').AsString;
      End;
    End;
    Result:= Lc_Aq_Com;
  Finally
    ItensNFL.FinalizaQuery(Lc_Qry);
  End;

end;

procedure TFr_Itens_Servico.Sb_LimparClick(Sender: TObject);
Begin
  Pc_LimpaCampos;
  if E_Cd_Servico.CanFocus then E_Cd_Servico.SetFocus;
end;


procedure TFr_Itens_Servico.E_UnidadeEnter(Sender: TObject);
Begin
 E_Unidade.SelectAll;
end;

procedure TFr_Itens_Servico.E_Aq_DescontoEnter(Sender: TObject);
Begin
 E_Aq_Desconto.SelectAll;
end;

procedure TFr_Itens_Servico.E_VL_DescontoEnter(Sender: TObject);
Begin
 E_VL_Desconto.SelectAll;
end;

procedure TFr_Itens_Servico.Sb_PesquisarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
Begin
  it_bt_pesquisa:=TRUE;
  if Sb_Pesquisar.CanFocus then Sb_Pesquisar.SetFocus;
end;


procedure TFr_Itens_Servico.SB_GravarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
Begin
  it_bt_pesquisa:=TRUE;
  if SB_Gravar.CanFocus then SB_Gravar.SetFocus;
end;

procedure TFr_Itens_Servico.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_IniciaVariaveis;
end;

procedure TFr_Itens_Servico.Sb_Sair_0MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  it_bt_pesquisa:=TRUE;
  if Sb_Sair_0.CanFocus then Sb_Sair_0.SetFocus;
end;

end.

