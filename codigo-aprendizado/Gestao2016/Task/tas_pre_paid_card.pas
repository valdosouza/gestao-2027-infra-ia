unit tas_pre_paid_card;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, ControllerPrePaidCard, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask, ControllerProduto;

type
  TTasPrePaidCard = class(TBaseRegistry)
    Label36: TLabel;
    E_Numero: TEdit;
    E_Data: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    E_VL_Credito: TMaskEdit;
    Label3: TLabel;
    E_VL_Debito: TMaskEdit;
    Label4: TLabel;
    E_Historico: TMaskEdit;
    E_Tx_Acrescimo: TMaskEdit;
    GroupBox1: TGroupBox;
  private
    { Private declarations }

  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure ShowData;Override;
    procedure ShowNoData;Override;
    procedure ClearAllFields;Override;
    procedure EditionControl;Override;
    //inserir
    function ValidaInsert():boolean;Override;
    procedure Insert;Override;
    //Editar
    function ValidateChange():boolean;Override;
    procedure Change;Override;
    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;
    procedure SavePrePaid;
    procedure SaveAcrescimoCredito;
    //Cancelar
    function ValidateCancel():boolean;Override;
    procedure Cancel;Override;

    procedure setPerfil;Override;
  public
    { Public declarations }
    Produto : TControllerProduto;
    Prepago : TControllerPrePaidCard;
    procedure Pc_CadastrarProdutosAuto;
  end;

var
  TasPrePaidCard: TTasPrePaidCard;

implementation

{$R *.dfm}

uses     UN_Principal, env, UN_Sistema, Un_Msg;

{ TTasPrePaidCard }

procedure TTasPrePaidCard.Cancel;
begin
  inherited;

end;

procedure TTasPrePaidCard.Change;
begin
  inherited;
  E_Numero.SetFocus;
end;

procedure TTasPrePaidCard.ClearAllFields;
begin
  inherited;
  Prepago.clear;
  E_Data.DateTime   := Date;
  E_Numero.Clear;
  E_VL_Credito.Text := '0,00';
  E_VL_Debito.Text := '0,00';
  E_Historico.Clear;

end;

procedure TTasPrePaidCard.CriarVariaveis;
begin
  inherited;
  Prepago := TControllerPrePaidCard.create(self);
  Produto := TControllerProduto.create(self);
end;

procedure TTasPrePaidCard.Delete;
begin
  inherited;
  Prepago.delete;
  close;
end;

procedure TTasPrePaidCard.EditionControl;
begin
  inherited;
  pnl_fundo.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
end;

procedure TTasPrePaidCard.IniciaVariaveis;
begin
  inherited;
  if CodigoRegistro > 0 then
  Begin
    PrePago.Registro.Codigo := CodigoRegistro;
    PrePago.getbyId;
  End;
  inherited;
end;

procedure TTasPrePaidCard.Insert;
begin
  inherited;
  ClearAllFields;
  Prepago.clear;
  ShowNoData;
  E_Numero.SetFocus;
end;

procedure TTasPrePaidCard.Pc_CadastrarProdutosAuto;
Var
  Lc_Cd_Grupo, Lc_Cd_SubGrupo, Lc_cd_Medida, Lc_Cd_Embalagem,
  Lc_Cd_Marca: Integer;
  Lc_VL_Custo: Real;
Begin
  Lc_Cd_Grupo := Produto.Grupo.autocreate('FINANCEIRO');
  Application.ProcessMessages;
  Lc_Cd_SubGrupo := Produto.Grupo.SubGRupo.autocreate(Lc_Cd_Grupo, 'CREDITO');
  Application.ProcessMessages;
  Lc_cd_Medida := Produto.Medida.autocreate('UNIDADE', 'UND');
  Application.ProcessMessages;
  Produto.Embalagem.Registro.Descricao   := 'NORMAL';
  Produto.Embalagem.Registro.Abreviatura := 'NRL';
  Produto.Embalagem.getIdAutoByDesc;
  Lc_Cd_Embalagem := Produto.Embalagem.Registro.Codigo;
  Application.ProcessMessages;
  Produto.Marca.Registro.Descricao := 'NÃO INFORMADA';
  Produto.Marca.getIdAutoByDesc;
  Lc_Cd_Marca := Produto.Marca.Registro.Codigo;
  Application.ProcessMessages;
  Produto.Clear;
  with Produto.Registro do
  Begin
    Codigo := 0;
    CodigoEstabelecimento := Gb_CodMha;
    CodigoFabrica         := '';
    CodigoBarras          := '';
    CodigoNCM             := '48181000';
    Descricao             := 'CREDITO PRÉ-PAGO';
    MedidaComercial       := Lc_cd_Medida;
    CodigoEmbalagem       := Lc_Cd_Embalagem;
    CodigoGrupo           := Lc_Cd_Grupo;
    CodigoSubgrupo        := Lc_Cd_SubGrupo;
    Divisor               := 1;
    Origem                := '0';
    Tipo                  := 'A';
    ValorFabrica          :=  0;
    ValorCustoMedio       :=  0;
    ValorCustoMedioAnt    :=  0;
    ValorCusto            :=  0;
    ValorCustoAnt         :=  0;
    SubsTrib              := 'N';
    Campanha              := 'N';
    Destaque              := 'N';
    Ativo                 := 'S';
    Imprime               := 'S';
    EstoqueNegativo       := 'S';
    Exclusivo             := 'N';
    Internet              := 'N';
    MaisVendido           := 'N';
    Composicao            := '1';
    CodigoMarca           := Lc_Cd_Marca;
    FinalidadeTributacao  := '1';
    UtilizaSerie          := 'N';
    Venda                 := 'S';
    ForaLinha             := 'N';
    CEST                  := '';
    IndicacaoEscala       := 'S';
  End;
  Produto.save;
  //Tabela Preco 1
  Produto.TabelaPreco.Preco.Registro.Codigo        := 0;
  Produto.TabelaPreco.Preco.Registro.CodigoTabela  := 1;
  Produto.TabelaPreco.Preco.Registro.CodigoProduto := Produto.Registro.Codigo;
  Produto.TabelaPreco.Preco.Registro.Valor         := 0;
  Produto.TabelaPreco.Preco.Registro.AliComissao   := 0;
  Produto.TabelaPreco.Preco.Registro.QtdeMinima    := 0;
  Produto.TabelaPreco.Preco.Registro.MargemLucro   := 0;
  Produto.TabelaPreco.Preco.salva;
  //Tabela Preco 2
  Produto.TabelaPreco.Preco.Registro.Codigo        := 0;
  Produto.TabelaPreco.Preco.Registro.CodigoTabela  := 2;
  Produto.TabelaPreco.Preco.Registro.CodigoProduto := Produto.Registro.Codigo;
  Produto.TabelaPreco.Preco.Registro.Valor         := 0;
  Produto.TabelaPreco.Preco.Registro.AliComissao   := 0;
  Produto.TabelaPreco.Preco.Registro.QtdeMinima    := 0;
  Produto.TabelaPreco.Preco.Registro.MargemLucro   := 0;
  Produto.TabelaPreco.Preco.salva;
  //Tabela Estoque
  Produto.Estoque.SaldoEstoque.CriaRegistroAutomatico(Produto.Registro.Codigo);
end;

procedure TTasPrePaidCard.Save;
begin
  inherited;
  SavePrePaid;
  SaveAcrescimoCredito;
  Close;
end;

procedure TTasPrePaidCard.SaveAcrescimoCredito;
Var
  LcPre : TControllerPrePaidCard;
  LcValor : Real;
begin
  LcValor  := StrToFloatDef(E_VL_Credito.Text,0);
  LcValor  := ( LcValor * StrToFloatDef(E_Tx_Acrescimo.Text,0) )/100;
  if LcValor > 0 then
  Begin
    Try
      LcPre := TControllerPrePaidCard.Create(Self);
      with LcPre do
      Begin
        Registro.Estabelecimento  := Gb_CodMha;
        Registro.Terminal         := Gb_Terminal;
        Registro.Data             := E_Data.DateTime;
        Registro.Numero           := E_Numero.Text;
        LcValor                   := StrToFloatDef(E_VL_Credito.Text,0);
        LcValor                   := ( LcValor * StrToFloatDef(E_Tx_Acrescimo.Text,0) )/100;
        Registro.ValorCredito     := LcValor;

        Registro.ValorDebito      := 0;

        Registro.Historico        := concat('CRÉDITO CEDIDO PELA COMPRA DE R$ ',FloatToStrF( prepago.Registro.ValorCredito,ffFixed,10,2))  ;
      End;
      LcPre.salva;
    Finally
      FreeAndNil(LcPre);
    End;
  End;
end;

procedure TTasPrePaidCard.SavePrePaid;
begin
  with Prepago do
  Begin
    Registro.Estabelecimento  := Gb_CodMha;
    Registro.Terminal         := Gb_Terminal;
    Registro.Data             := E_Data.DateTime;
    Registro.Numero           := E_Numero.Text;
    Registro.ValorCredito     := StrToFloatDef(E_VL_Credito.Text,0);
    Registro.ValorDebito      := StrToFloatDef(E_VL_Debito.Text,0);
    Registro.Historico        := E_Historico.Text;
  End;
  Prepago.salva;
end;


procedure TTasPrePaidCard.setPerfil;
begin
  pfMenu := 'Cadastro de Cartão Pré-Pago';
  inherited;
end;

procedure TTasPrePaidCard.ShowData;
begin
  inherited;
  with Prepago do
  Begin
    E_Data.DateTime   := Registro.Data;
    E_Numero.Text     := Registro.Numero;
    E_VL_Credito.Text := FloatToStrF(Registro.ValorCredito,ffFixed,10,2);
    E_VL_Debito.Text  := FloatToStrF(Registro.ValorDebito,ffFixed,10,2);
    E_Historico.Text  := Registro.Historico;
  End;
end;

procedure TTasPrePaidCard.ShowNoData;
begin
  inherited;
  E_Data.DateTime   := Date;
  E_Numero.Clear;
  E_VL_Credito.Text := '0,00';
  E_VL_Debito.Text := '0,00';
  E_Historico.Clear;
end;

function TTasPrePaidCard.ValidaInsert: boolean;
begin
  Result := TRue;
end;

function TTasPrePaidCard.ValidateCancel: boolean;
begin
  REsult := True;
end;

function TTasPrePaidCard.ValidateChange: boolean;
begin
  Result := True;
  if Prepago.Registro.Ordem > 0 then
  BEgin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Este Registro não pode ser alterado.' + EOLN +
                   'Registro vinculado a pagamento efetuado;' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    Exit;
  End;
end;

function TTasPrePaidCard.ValidateDelete: boolean;
begin
  Result := True;
  if Prepago.Registro.Ordem > 0 then
  BEgin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Este Registro não pode ser excluido.' + EOLN +
                   'Registro vinculado a pagamento efetuado;' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    Exit;
  End;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir este lançamento de seus arquivos.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
  begin
    REsult := False;
  end;

end;

function TTasPrePaidCard.ValidateSave: boolean;
Var
  Lc_Vl_Aux : REal;
  Lc_Dt_Aux : TDate;
  Lc_Vl_Aux_compara : Real;
begin
  Result := True;
  //valida se o telfone do Cliente foi Preenchido
  if Length(E_Numero.Text) = 0 then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Sem informar um número de cartão, será criado um novo.'+EOLN+EOLN+
                       'Confirmar a geração deste número novo?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
    begin
      REsult := False;
    end;
  end;

  if ( StrToFloatDef( E_VL_Credito.Text,0) = 0 ) and ( StrToFloatDef( E_VL_Debito.Text,0) = 0 ) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'é obrigatório o lançamento do valor de Crédito ou Débito.' + EOLN +
                   'Preencha um dos campos para continuar;' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    REsult := False;
    exit;
  End;

  if ( StrToFloatDef( E_VL_Debito.Text,0) > 0 ) then
  Begin
    if Length(E_Numero.Text) = 0 then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Campo débito só pode ser informado caso um número de cartão seja informado.' + EOLN +
                     'Se for o primeiro lançamento, favor infomrar o campo valor crédito.' + EOLN,
                     ['OK'], [bEscape], mpInformacao);
      REsult := False;
      exit;
    End;

    Prepago.Parametros.PrePago.Estabelecimento := Gb_CodMha;
    Prepago.Parametros.PrePago.Numero := E_Numero.Text;
    Lc_Vl_Aux := Prepago.getsaldo;
    Lc_Vl_Aux_compara := StrToFloatDef( E_VL_Debito.Text,0);
    if ( Lc_Vl_Aux < Lc_Vl_Aux_compara ) then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não há saldo suficiente para efetuar esta operação.' + EOLN +
                     'Verifique antes de continuar o ajuste o valor.' + EOLN,
                     ['OK'], [bEscape], mpInformacao);
      REsult := False;
      exit;
    End;
  End;

  Prepago.Parametros.PrePago.Estabelecimento := Gb_CodMha;
  Prepago.Parametros.PrePago.Numero := E_Numero.Text;
  Lc_Dt_Aux := Prepago.getLasData;

  if E_Data.DateTime < Lc_Dt_Aux then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'A Data informada não pode ser menor do que a do último lançamento.' + EOLN +
                   'Verifique antes de continuar o ajuste a data.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    REsult := False;
    exit;
  End;


end;

end.
