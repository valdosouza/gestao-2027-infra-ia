unit cad_lote;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Un_Fm_ListaProdutos, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, Vcl.StdCtrls, ControllerCtrlLote, ControllerCtrlEstoque;

type
  TCadLote = class(TBaseRegistry)
    Fm_ListaProdutos: TFm_ListaProdutos;
    Label11: TLabel;
    Label12: TLabel;
    Label18: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    E_Nr_Lote: TEdit;
    E_Qt_Produto: TEdit;
    E_Nr_Certificado: TEdit;
    E_Dt_Lote: TMaskEdit;
    E_Dt_Vencimento: TMaskEdit;
    Label3: TLabel;
    E_Observacao: TMemo;
    ChBx_Atualiza_Estoque: TCheckBox;
    procedure E_Qt_ProdutoExit(Sender: TObject);
  private
    { Private declarations }
    Estoque : TControllerCtrlEstoque;
    function TemMovimento:boolean;
  protected
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
    procedure setPerfil;Override;

    procedure ShowData;Override;
    procedure ShowNoData;Override;
    procedure ClearAllFields;Override;
    //inserir
    function ValidaInsert():boolean;Override;
    procedure Insert;Override;
    //Alterar
    function ValidateChange():boolean;override;
    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;

    procedure EditionControl;Override;


  public
    { Public declarations }
    Lote : TControllerCtrlLote;
  end;

var
  CadLote: TCadLote;

implementation

{$R *.dfm}

uses     RN_Lotes, UN_Sistema, UN_Principal, env, Un_Msg, Un_Funcoes;

{ TCadLote }


procedure TCadLote.CriarVariaveis;
begin
  inherited;
  Lote := TControllerCtrlLote.create(Self);
end;

procedure TCadLote.Delete;
Begin
  //Desregistra o Estoque
  Lote.Estoque.Desregistra('L',
                           Lote.Registro.Codigo,
                           0);
  //Excluir o Controle do Lote
  Lote.delete;
  Close;
end;

procedure TCadLote.EditionControl;
begin
  inherited;
  ChBx_Atualiza_Estoque.Enabled := ( EditionState = 'I' );
  Fm_ListaProdutos.Enabled := ( EditionState = 'I' );
  pnl_fundo.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
end;


procedure TCadLote.E_Qt_ProdutoExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := 0;
  Lc_Valor := StrToFloatDef(E_Qt_Produto.Text, 0);
  //if Lc_Valor >= 10000 then Lc_Valor := 1;
  E_Qt_Produto.Text := FloatToStr(Lc_Valor);
end;

procedure TCadLote.FormataTela;
begin
  inherited;

end;

procedure TCadLote.IniciaVariaveis;
begin
  if CodigoRegistro > 0 then
  Begin
    Lote.Registro.Codigo := Self.CodigoRegistro;
    Lote.Registro.Estabelecimento := Gb_CodMha;
    Lote.getbyId;
    Lote.Movimento.Registro.Lote := Lote.Registro.Codigo;
    Lote.Movimento.getFirstByLote;
  End;
  inherited;
end;

procedure TCadLote.Insert;
begin
  ClearAllFields;
  ChBx_Atualiza_Estoque.Checked := True;
  Fm_ListaProdutos.E_Cd_Produto.SetFocus;
end;

procedure TCadLote.ClearAllFields;
begin
  inherited;
  Lote.clear;
  Lote.Movimento.clear;
  Fm_ListaProdutos.E_Cd_Produto.Clear;
  Fm_ListaProdutos.E_Busca_Produto.Clear;
  E_Dt_Lote.Clear;
  E_Nr_Lote.Clear;
  E_Nr_Certificado.Clear;
  E_Qt_Produto.Clear;
  E_Dt_Vencimento.Clear;
end;


procedure TCadLote.Save;
begin
  Lote.Registro.Estabelecimento := Gb_CodMha;
  Lote.Registro.Empresa         := Gb_CodMha;
  Lote.Registro.Produto := StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0);
  Lote.Registro.Numero := E_Nr_Lote.Text;
  Lote.Registro.Certificado := E_Nr_Certificado.Text ;
  Lote.Registro.Vencimento := StrToDateDef(E_Dt_Vencimento.Text,Date) ;
  if ChBx_Atualiza_Estoque.Checked then
    Lote.Registro.AtualizaEstoque := 'S'
  else
    Lote.Registro.AtualizaEstoque := 'N';
  Lote.Registro.Estoque := Gb_Estoque;
  Lote.salva;
  //para controlar o editioncontrol
  CodigoRegistro := Lote.Registro.Codigo;
  //Faz anotação na Observação quando não atualiza o estoque
  if not ChBx_Atualiza_Estoque.Checked then
    E_Observacao.Lines.Add('Opções de atualizar o saldo de estoque não foi marcada!');
  Lote.Movimento.Registro.Lote := Lote.Registro.Codigo;
  Lote.Movimento.Registro.Data := StrToDate(E_Dt_Lote.Text);
  Lote.Movimento.Registro.Tipo := 'AVULSO';
  Lote.Movimento.Registro.Vinculo := 0;
  Lote.Movimento.Registro.Sentido := 'E';
  Lote.Movimento.Registro.Qtde := StrToFloatDeF(E_Qt_Produto.Text,0);
  Lote.Movimento.Registro.Observacao := E_Observacao.Text;
  Lote.Movimento.Registro.Log := concat('Usuario: ',GB_Nm_Usuario);
  Lote.Movimento.salva;

  //Baixa simples produto a produto
  if ChBx_Atualiza_Estoque.Checked then
  Begin
    with Lote.Estoque.Registro do
    Begin
      Codigo      := 0;
      Terminal    := 1;
      Vinculo     := 'L';
      Ordem       := Lote.Registro.Codigo;
      Item        := lote.Movimento.Registro.Codigo;
      Estoque     := Gb_Estoque;
      operacao    := 'E';
      Produto     := lote.Registro.Produto;
      Quantidade  := StrToFloatDef(E_Qt_Produto.Text,0);
      Data        := lote.Movimento.Registro.Data;
      Tipo        := 'Lote';
      UpdateAt    := Now;
    End;
    Lote.Estoque.Registra;
  End;
end;

procedure TCadLote.setPerfil;
begin
  inherited;

end;

procedure TCadLote.ShowData;
begin
  Fm_ListaProdutos.E_Cd_Produto.Text := Lote.Registro.Produto.ToString;
  Fm_ListaProdutos.E_Cd_ProdutoExit(Self);
  E_Dt_Lote.Text := DateToStr(Lote.Movimento.Registro.Data);
  E_Nr_Lote.Text := Lote.Registro.Numero;
  E_Nr_Certificado.Text := Lote.Registro.Certificado;
  E_Qt_Produto.Text := FloatToStr(Lote.Movimento.Registro.Qtde);
  E_Dt_Vencimento.Text := DateToStr(Lote.Registro.Vencimento);
  E_Observacao.Text := Lote.Movimento.Registro.Observacao;
  ChBx_Atualiza_Estoque.Checked := ( Lote.Registro.AtualizaEstoque = 'S');
end;

procedure TCadLote.ShowNoData;
begin
  ClearAllFields;
end;

function TCadLote.TemMovimento: boolean;
begin
  Result := False;
  Lote.Movimento.Registro.Lote := Lote.Registro.Codigo;
  if Lote.Movimento.ComMovimento then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Este lote já tem movimento.'+EOLN+
                   'Não é possivel alterar/excluir.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    result := True;
    Exit;
  end;

end;

function TCadLote.ValidaInsert: boolean;
begin
  Result := True;
end;


function TCadLote.ValidateChange: boolean;
begin
  Result := True;
  if TemMovimento then
  Begin
    result:=False;
    Exit;
  End;
end;

function TCadLote.ValidateDelete: boolean;
begin
  Result := True;
  if TemMovimento then
  Begin
    result:=False;
    Exit;
  End;

  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir este Lote de seus arquivos.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
  begin
    Result := False;
    exit;
  end;
end;

function TCadLote.ValidateSave: boolean;
begin
  Result:=true;
  if(not Fc_ValData(E_Dt_Lote.Text)) or (Trim(E_Dt_Lote.Text) = '/  /') then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Data não informada ou incorreta.'+EOLN+
                   'Preencha o campo antes para continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    result:=False;
    if E_Dt_Lote.CanFocus then E_Dt_Lote.SetFocus;
    Exit;
  end;

  if Trim(E_Nr_Lote.Text)='' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Número do Lote não informado.'+EOLN+
                   'Preencha o Número para continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    result:=False;
    if E_Nr_Lote.CanFocus then E_Nr_Lote.SetFocus;
    exit;
  end;

  if Fc_VerificaExistenciaNumeroLote(E_Nr_Lote.Text,
                                     lote.Registro.Codigo,
                                     lote.Registro.Empresa,
                                     lote.Registro.Produto) then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Número de Lote para este produto já existe.'+ EOLN +EOLN ,
                   ['OK'], [bEscape], mpAlerta);
    result:=False;
    E_Nr_Lote.Clear;
    if E_Nr_Lote.CanFocus then E_Nr_Lote.SetFocus;
    Exit;
  end;

  if StrToFloatDef(E_Qt_Produto.Text,0)=0 then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                  'Quantidade de Lote tem que ser maior que zero.'+EOLN+
                  'Preencha a quantidade deste Lote.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    result:=False;
    if E_Qt_Produto.CanFocus then E_Qt_Produto.SetFocus;
    Exit;
  end ;

  if(not Fc_ValData(E_Dt_Vencimento.Text)) or (Trim(E_Dt_Vencimento.Text) = '') then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'A Data de Vencimento não foi informada.' + EOLN +
                   'Favor preecher os dados e tentar novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    result:=False;
  end;

  if(Trim(E_Dt_Vencimento.Text) <> '/  /') then
  begin
    if ( StrToDate(E_Dt_Vencimento.Text) <= StrToDate(E_Dt_Lote.Text) ) then
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'O vencimento não pode ser menor ou igual a data do Lote.'+EOLN+
                     'Verifique antes de continuar.'+EOLN,
                     ['OK'],[bEscape],mpAlerta);
      result:=False;
      if E_Dt_Vencimento.CanFocus then E_Dt_Vencimento.SetFocus;
      Exit;
    end;
  end;

end;

end.
