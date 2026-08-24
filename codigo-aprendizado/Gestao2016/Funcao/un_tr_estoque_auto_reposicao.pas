unit un_tr_estoque_auto_reposicao;

interface

uses
      Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls, ACBrMail, types, ACBrBase, ExtCtrls, ControllerCtrlEstoque, tblCtrlEstoque, STQuery, ControllerNotification, System.StrUtils;

type
  TTrEstoqueAutoReposicao = class(TThread)
  private
    FCtrlEstoque : TControllerCtrlEstoque;
    FNotification : TControllerNotification;
    FRegistro: TCtrlEstoque;
    FComposicao : TSTQuery;
    procedure setFRegistro(const Value: TCtrlEstoque);
    procedure OpenListaComposicao;
    procedure RetirarSaldoDoItem;
    procedure AdicionarSaldoNoItem;
    procedure RegistraNotificacaoPositiva;
    procedure RegistraNotificacaoNegativa;
    procedure MetodoNegativo;
    procedure MetodoCascata;
    procedure MetodoSortido;

  public
    constructor Create();
    destructor Destroy; override;
    procedure execute;override;
    property Registro:TCtrlEstoque read FRegistro write setFRegistro;
  end;

implementation

{ TTrEstoqueAutoReposicao }

uses     ENV;

procedure TTrEstoqueAutoReposicao.AdicionarSaldoNoItem;
begin
  FCtrlEstoque.ClonarObj(FRegistro,FCtrlEstoque.Registro);
  FCtrlEstoque.Registro.Codigo     := 0;
  FCtrlEstoque.Registro.operacao   := 'E';
  FCtrlEstoque.Registro.Vinculo    := 'A';
  FCtrlEstoque.Registro.Ordem      := 0;
  FCtrlEstoque.Registro.Item       := 0;
  FCtrlEstoque.Registro.Produto    := FComposicao.FieldByname('PRO_CODIGO').AsInteger;
  FCtrlEstoque.Registro.Quantidade := FComposicao.FieldByname('PPD_QTDE').AsFloat;
  FCtrlEstoque.Registro.Tipo       := 'AUTO REPOSICAO';
  FCtrlEstoque.Registro.UpdateAt   := Now;
  FCtrlEstoque.Insert;
end;

constructor TTrEstoqueAutoReposicao.Create;
begin
  inherited Create (True);
  FRegistro := TCtrlEstoque.Create;
  FCtrlEstoque := TControllerCtrlEstoque.create(nil);
  FNotification := TControllerNotification.create(nil);
  FComposicao := FCtrlEstoque.GeraQuery;
  FreeOnTerminate := True;
end;

destructor TTrEstoqueAutoReposicao.Destroy;
begin
  FreeAndNil( FRegistro );
  FCtrlEstoque.FinalizaQuery(FComposicao);
  FreeAndNil( FCtrlEstoque );
  FreeAndNil( FNotification );
  inherited;
end;

procedure TTrEstoqueAutoReposicao.execute;
Var
  Lc_Qtde : String;

  LcReg : TCtrlEstoque;
  LcSaldo : Real;
Begin
  OpenListaComposicao;
  with FComposicao do
  Begin
    CASE AnsiIndexStr(UpperCase(FieldByName('PPD_METODO').AsString), ['NEGATIVO', 'CASCATA','SORTIDO']) OF
      0:MetodoNegativo;
      1:MetodoCascata;
      2:MetodoSortido;
    END;
  End;
end;


procedure TTrEstoqueAutoReposicao.MetodoCascata;
begin
  {Em cascata quer dizer que o sistema vai procurar na lista quem tem saldo
  se não encontrar saldo, o sistema vai emitr a mensagem de falta de saldo e vai
  pr�ximo item da lista at� encontrar saldo ou at� chegar ao final dela
  }
  with FComposicao do
  Begin
    while not Eof do
    Begin
      if ( FieldByName('EST_QTDE').AsFloat >= FieldByname('PPD_QTDE_USED').AsInteger) then
      Begin
        //Retirar este item da composição do estoque
        RetirarSaldoDoItem;
        //Adicionar este item pricipal ao Estoque
        AdicionarSaldoNoItem;
        //Notificção na area de trabalho
        RegistraNotificacaoPositiva;
        break;
      end
      else
      Begin
        RegistraNotificacaoNegativa;
      End;
      Next;
    end;
  End;
end;

procedure TTrEstoqueAutoReposicao.MetodoNegativo;
begin
  {Aqui pega o primeiro da lista e retira do estoque mesmo sem estoque
  }
  with FComposicao do
  Begin
    //Retirar este item da composição do estoque
    RetirarSaldoDoItem;
    //Adicionar este item pricipal ao Estoque
    AdicionarSaldoNoItem;
    //Notificção na area de trabalho
    RegistraNotificacaoPositiva;
  End;
end;

procedure TTrEstoqueAutoReposicao.MetodoSortido;
begin
  {No Sortido o sistema vai retirar do estoque cada item da lista e abastecer o mesmo produto
  lembrando que fisicamente eles estar�o sendo misturados nos pacotes...
  }
  with FComposicao do
  Begin
    while not Eof do
    Begin
      //Retirar este item da composição do estoque
      RetirarSaldoDoItem;
      //Adicionar este item pricipal ao Estoque
      AdicionarSaldoNoItem;
      //Notificção na area de trabalho
      RegistraNotificacaoPositiva;
      Next;
    end;
  End;

end;

procedure TTrEstoqueAutoReposicao.OpenListaComposicao;
begin
  with FComposicao do
  BEgin
    Active := false;
    SQL.Clear;
    SQL.Add(concat(
               'SELECT ',
               '  PRO_CODIGO, ',
               '  PRO_DESCRICAO, ',
               '  PRO_COMPOSICAO, ',
               '  PRO_QTDE_MIN_AUTO_REPO, ',
               '  PPD_QTDE_USED, ',
               '  PPD_TIPO, ',
               '  PPD_QTDE , ',
               '  PPD_CODPRO_D, ',
               '  et.est_qtde, ',
               '  PPD_METODO ',
               ' FROM TB_PRODUTO pd ',
               '    INNER JOIN TB_PROD_PROD pdm ',
               '    ON (pdm.PPD_CODPRO_M = pd.PRO_CODIGO) ',
               '    inner join tb_estoque et ',
               '    on (et.est_codpro = pdm.ppd_codpro_d) ',
               'WHERE PRO_CODIGO =:PRO_CODIGO ',
               ' AND PPD_TIPO =:PPD_TIPO '
    ));
    ParamByName('PRO_CODIGO').AsInteger := Registro.Produto;
    ParamByName('PPD_TIPO').AsString := 'REPOSICAO';
    Active := True;
    FetchAll;
    First;
  End;
end;

procedure TTrEstoqueAutoReposicao.RegistraNotificacaoNegativa;
begin
  FNotification.Registro.Estabelecimento := Gb_CodMha;
  FNotification.Registro.Codigo := 0;
  FNotification.Registro.Categoria := 'ESTOQUE';
  FNotification.Registro.Observacao := concat(
                                            'Pproduto ',FComposicao.FieldByName('PRO_CODIGO').AsString,' sem saldo. ',
                                            'Verifique!'
                                        );
  FNotification.Registro.Ativo := 'S';
  FNotification.insert;
end;

procedure TTrEstoqueAutoReposicao.RegistraNotificacaoPositiva;
begin
  FNotification.Registro.Estabelecimento := Gb_CodMha;
  FNotification.Registro.Codigo := 0;
  FNotification.Registro.Categoria := 'ESTOQUE';
  FNotification.Registro.Observacao := concat(
                                            'Reposição automatica do produto ',FComposicao.FieldByName('PRO_CODIGO').AsString,' foi realizado com sucesso. ',
                                            '( ',FComposicao.FieldByName('PPD_QTDE_USED').AsString,' => ',FComposicao.FieldByName('PPD_QTDE').AsString,' )',
                                             FComposicao.FieldByName('PRO_DESCRICAO').AsString, ' deve ser reposto(a) na area de venda'
                                        );
  FNotification.Registro.Ativo := 'S';
  FNotification.insert;
end;

procedure TTrEstoqueAutoReposicao.RetirarSaldoDoItem;
begin
  FCtrlEstoque.ClonarObj(FRegistro,FCtrlEstoque.Registro);
  FCtrlEstoque.Registro.Codigo     := 0;
  FCtrlEstoque.Registro.operacao   := 'S';
  FCtrlEstoque.Registro.Vinculo    := 'A';
  FCtrlEstoque.Registro.Ordem      := 0;
  FCtrlEstoque.Registro.Item       := 0;
  FCtrlEstoque.Registro.Produto    := FComposicao.FieldByname('PPD_CODPRO_D').AsInteger;
  FCtrlEstoque.Registro.Quantidade := FComposicao.FieldByname('PPD_QTDE_USED').AsInteger;
  FCtrlEstoque.Registro.Tipo       := 'AUTO RETIRADA';
  FCtrlEstoque.Registro.UpdateAt   := Now;
  FCtrlEstoque.Insert
end;

procedure TTrEstoqueAutoReposicao.setFRegistro(const Value: TCtrlEstoque);
begin
  FRegistro := Value;
end;

end.
