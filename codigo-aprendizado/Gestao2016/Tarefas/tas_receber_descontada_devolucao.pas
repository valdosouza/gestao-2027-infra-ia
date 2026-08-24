unit tas_receber_descontada_devolucao;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, ControllerNotaFiscal, Vcl.StdCtrls, Vcl.Mask, QEdit_Setes, Vcl.Buttons, Vcl.ExtCtrls, Un_Fc_Sored_Procedures, System.Math;

type
  TTasReceberDescontadaDevolucao = class(TFr_Base)
    Panel1: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    Panel2: TPanel;
    Label14: TLabel;
    Label6: TLabel;
    Label15: TLabel;
    Label1: TLabel;
    E_VL_Original: TEdit_Setes;
    E_VL_Operacao: TEdit_Setes;
    E_VL_Liquido: TEdit_Setes;
    E_Tx_Operacao: TEdit_Setes;
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure E_Tx_OperacaoExit(Sender: TObject);
    procedure E_VL_OperacaoExit(Sender: TObject);
  private
    procedure Execute;
    procedure ExcluiMovimentoBancario;
    procedure LancaDebitoParcelaNaoQuitada;
    procedure LancaDebitoCustoOperacao;

  protected
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure setPerfil;Override;
    procedure FormataTela;Override;
    procedure AtivaTabelas;Override;
  public
    { Public declarations }
    NotaFiscal:TControllerNotaFiscal;
  end;

var
  TasReceberDescontadaDevolucao: TTasReceberDescontadaDevolucao;

implementation

uses     Un_Lanca_Banco, UN_Principal, env;

{$R *.dfm}

{ TTasReceberDescontadaCancelamento }

procedure TTasReceberDescontadaDevolucao.AtivaTabelas;
begin
  inherited;

end;


procedure TTasReceberDescontadaDevolucao.CriarVariaveis;
begin
  NotaFiscal := TControllerNotaFiscal.create(Self);
end;

procedure TTasReceberDescontadaDevolucao.ExcluiMovimentoBancario;
begin
  with NotaFiscal do
  Begin
    Financeiro.Movimento.Registro.Quitacao := Financeiro.Registro.CodigoQuitacao;
    Financeiro.Movimento.DeletaByQuitacao;
  End;
end;

procedure TTasReceberDescontadaDevolucao.Execute;
begin
  with NotaFiscal do
  Begin
    Financeiro.Registro.DocumentoBaixado := 'N';
    Financeiro.Registro.SituacaoFinanceiro := 'N';
    Financeiro.Registro.ValorPago := 0;
    Financeiro.Atualiza;

    LancaDebitoParcelaNaoQuitada;
    LancaDebitoCustoOperacao;

    Pc_Log_Sistema(Gb_CodMha,
                   GB_Cd_Usuario,
                   now,
                   'Desconto de Duplicatas',
                   Financeiro.Registro.Codigo,
                   'Devolução de Desconto de Duplicatas',
                   'FINANCEIRO: ' + Financeiro.Registro.NumeroDuplicata + ' | VALOR: ' + FloatToStrF(Financeiro.Registro.ValorParcela,ffFixed,10,2) );
  End;

end;

procedure TTasReceberDescontadaDevolucao.E_Tx_OperacaoExit(Sender: TObject);
Var
  Lc_Vl_Original : Real;
  Lc_VL_Operacao :Real;
  Lc_Taxa : Real;
begin
  Lc_Vl_Original := StrtoFloatDef(E_VL_Original.Text,0);
  Lc_Taxa := StrToFloatDef(E_Tx_Operacao.Text,0);

  Lc_VL_Operacao := ((Lc_Vl_Original * Lc_Taxa) /100 );
  Lc_VL_Operacao := RoundTo(Lc_VL_Operacao,-2);
  E_Tx_Operacao.Text := FloatToStrF(Lc_Taxa,ffFixed,10,2);
  E_VL_Operacao.Text := FloatToStrF(Lc_VL_Operacao,ffFixed,10,2);
  E_VL_Liquido.Text := FloatToStrF(Lc_Vl_Original - Lc_VL_Operacao,ffFixed,10,2);
end;

procedure TTasReceberDescontadaDevolucao.E_VL_OperacaoExit(Sender: TObject);
Var
  Lc_Vl_Original : Real;
  Lc_VL_Operacao :Real;
  Lc_Taxa : Real;
begin

  Lc_Vl_Original := StrtoFloatDef(E_VL_Original.Text,0);
  Lc_VL_Operacao := StrToFloatDef(E_VL_Operacao.Text,0);

  Lc_Taxa := ( (Lc_VL_Operacao / Lc_Vl_Original) * 100 );
  Lc_Taxa := RoundTo(Lc_Taxa,-2);
  E_Tx_Operacao.Text := FloatToStrF(Lc_Taxa,ffFixed,10,2);
  E_VL_Liquido.Text := FloatToStrF(Lc_Vl_Original - Lc_VL_Operacao,ffFixed,10,2);
end;

procedure TTasReceberDescontadaDevolucao.FormataTela;
begin
  inherited;

end;

procedure TTasReceberDescontadaDevolucao.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
  CarregaImagemBotao(SB_Sair_0,'SAIR');
end;

procedure TTasReceberDescontadaDevolucao.IniciaVariaveis;
begin
  with NotaFiscal do
  Begin
    Financeiro.getById;
    Pedido.Registro.Codigo := Financeiro.Registro.CodigoPedido;
    Pedido.getbyId;

    E_VL_Original.Text  := FloatToStrF(Financeiro.Registro.ValorParcela,ffFixed,10,2);
    E_Tx_Operacao.Text  := '0,00';
    E_VL_Operacao.Text  := '0,00';
    E_VL_Liquido.Text   := FloatToStrF(Financeiro.Registro.ValorParcela,ffFixed,10,2);
  End;
end;

procedure TTasReceberDescontadaDevolucao.LancaDebitoCustoOperacao;
Var
  LfFormBanco : TFr_Lanca_Banco;
Begin
  Try
    with NotaFiscal do
    Begin
      //Efetua a deposito na Conta corrente
      LfFormBanco := TFr_Lanca_Banco.Create(nil);
      LfFormBanco.ForcarLancamento := True;
      LfFormBanco.Titulo           := 'Custo da Operação - Cancelamento de Duplicata Descontada';
      LfFormBanco.Codigo           := 0;
      LfFormBanco.Quitacao         := 0;
      LfFormBanco.Caption          := '';
      LfFormBanco.Data             := Date;
      LfFormBanco.ContaCorrente    := 0;
      LfFormBanco.Operacao         := 'I';
      LfFormBanco.PlanoResultado   := 0;
      LfFormBanco.PlanoCentroCusto := 0;
      LfFormBanco.Historico        := Concat('Taxas de Cancelamento - Pedido ',Pedido.Registro.Numero.toString,' Descontada não Quitada pelo Cliente');
      LfFormBanco.HistoricoBanco   := 0;
      LfFormBanco.ValorCredito     := 0;
      LfFormBanco.ValorDebito      := StrToFloatDef(E_VL_Operacao.Text,0);
      Financeiro.FormaPagto.Registro.Descricao := 'DINHEIRO';
      Financeiro.FormaPagto.getByPartDescription;
      LfFormBanco.FormaPagto       := Financeiro.FormaPagto.Registro.Codigo;
      LfFormBanco.Mensagem         := True;
      LfFormBanco.LiberaCampo      := False;
      LfFormBanco.AutoFill;
      LfFormBanco.E_Historico.ReadOnly := True;
      LfFormBanco.ShowModal;
    End;
  Finally
    FreeAndNil(LfFormBanco);
  End;

end;

procedure TTasReceberDescontadaDevolucao.LancaDebitoParcelaNaoQuitada;
Var
  LfFormBanco : TFr_Lanca_Banco;
Begin
  Try
    with NotaFiscal do
    Begin
      //Efetua a deposito na Conta corrente
      LfFormBanco := TFr_Lanca_Banco.Create(nil);
      LfFormBanco.ForcarLancamento := True;
      LfFormBanco.Titulo           := 'Cancelamento de Duplicata Descontada';
      LfFormBanco.Codigo           := 0;
      LfFormBanco.Quitacao         := 0;
      LfFormBanco.Caption          := '';
      LfFormBanco.Data             := Date;
      LfFormBanco.ContaCorrente    := 0;
      LfFormBanco.Operacao         := 'I';
      LfFormBanco.PlanoResultado   := 0;
      LfFormBanco.PlanoCentroCusto := 0;
      LfFormBanco.Historico        := Concat('Pedido: ',Pedido.Registro.Numero.ToString ,' Descontada e não Quitada pelo Cliente');
      LfFormBanco.HistoricoBanco   := 0;
      LfFormBanco.ValorCredito     := 0;
      LfFormBanco.ValorDebito      := Financeiro.Registro.ValorParcela;
      Financeiro.FormaPagto.Registro.Descricao := 'DINHEIRO';
      Financeiro.FormaPagto.getByPartDescription;
      LfFormBanco.FormaPagto       := Financeiro.FormaPagto.Registro.Codigo;
      LfFormBanco.Mensagem         := True;
      LfFormBanco.LiberaCampo      := False;
      LfFormBanco.AutoFill;
      LfFormBanco.E_Historico.ReadOnly := True;
      LfFormBanco.ShowModal;
    End;
  Finally
    FreeAndNil(LfFormBanco);
  End;
end;

procedure TTasReceberDescontadaDevolucao.SB_ConfirmarClick(Sender: TObject);
begin
  Execute;
  Close;
end;

procedure TTasReceberDescontadaDevolucao.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TTasReceberDescontadaDevolucao.setPerfil;
begin
  inherited;

end;

end.
