unit Un_Baixa_Dup_Desc;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls, Data.DB, STQuery, QEdit_Setes, ControllerFinanceiro, Un_Fm_FormaPagto, Vcl.ComCtrls;

type
  TFr_Baixa_Dup_Desc = class(TFr_Base)
    Panel2: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label24: TLabel;
    Label1: TLabel;
    E_N_Parcela: TEdit_Setes;
    E_Vl_Pagar: TEdit_Setes;
    E_Vencimento: TEdit_Setes;
    Panel1: TPanel;
    Sb_Sair_0: TSpeedButton;
    SB_Confirmar: TSpeedButton;
    E_Valor_Pago: TEdit_Setes;
    E_Juros: TEdit_Setes;
    E_Mora: TEdit_Setes;
    E_Desconto: TEdit_Setes;
    Fm_FormaPagto: TFm_FormaPagto;
    E_Data_Pagto: TDateTimePicker;
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure E_JurosExit(Sender: TObject);
    procedure E_MoraExit(Sender: TObject);
    procedure E_DescontoExit(Sender: TObject);
  private
    { Private declarations }
    procedure Totalizador;
    function validagravacao:Boolean;
    procedure Gravar;
  protected
    procedure ImagemBotao;override;
  public
    { Public declarations }
    Financeiro : TControllerFinanceiro;
    procedure IniciaVariaveis;


  end;

var
  Fr_Baixa_Dup_Desc: TFr_Baixa_Dup_Desc;

implementation

{$R *.dfm}

uses     UN_Principal, env, Un_Msg;

procedure TFr_Baixa_Dup_Desc.E_DescontoExit(Sender: TObject);
begin
  Totalizador;
end;

procedure TFr_Baixa_Dup_Desc.E_JurosExit(Sender: TObject);
begin
  Totalizador;
end;

procedure TFr_Baixa_Dup_Desc.E_MoraExit(Sender: TObject);
begin
  Totalizador;
end;

procedure TFr_Baixa_Dup_Desc.FormCreate(Sender: TObject);
begin
  Financeiro := TControllerFinanceiro.Create(Self);
end;

procedure TFr_Baixa_Dup_Desc.ImagemBotao;
Begin
  CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
  CarregaImagemBotao(SB_Sair_0,'SAIR');

end;

procedure TFr_Baixa_Dup_Desc.FormShow(Sender: TObject);
begin
  IniciaVariaveis;
  ImagemBotao;
end;

procedure TFr_Baixa_Dup_Desc.IniciaVariaveis;
begin
  Financeiro.getById;
  with Financeiro.Registro do
  Begin
    E_N_Parcela.Text := NumeroDuplicata;
    E_Vl_Pagar.Text := FloatToStrF(ValorParcela,ffFixed,10,2);
    E_Vencimento.Text := DateToStr(DataVencimento);
    Fm_FormaPagto.Pc_Listar(3,False,0);
    Fm_FormaPagto.DBLCB_FormaPagto.KeyValue := FormaPagamento;
    E_Data_Pagto.DateTime := Date;
    E_Valor_Pago.Text :=  FloatToStrF(ValorParcela,ffFixed,10,2);
    E_Juros.Text := '0,00';
    E_Mora.Text := '0,00';
    E_Desconto.Text := '0,00';
  End;
end;

function TFr_Baixa_Dup_Desc.validagravacao:Boolean;
Begin
  Result := True;
  if ( E_Data_Pagto.DateTime < StrtoDate(E_Vencimento.Text) ) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'A data de pagamento não pode ser '+EOLN+
                   'menor do que a data de vencimento. '+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  End;

  if ( StrtoFloatDef(E_Valor_Pago.Text,0) <= 0 ) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O valor pago não pode ser menor ou igual a (0,00).'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  End;
End;

procedure TFr_Baixa_Dup_Desc.Gravar;
Begin
  with Financeiro.Registro do
  Begin
    DataPagamento := E_Data_Pagto.DateTime;
    ValorPago := StrToFloatDef( E_Valor_Pago.Text,0);
    ValorJuros := StrToFloatDef(  E_Juros.Text,0);
    ValorMora := StrToFloatDef( E_Mora.Text,0);
    ValorDesconto := StrToFloatDef( E_Desconto.Text,0);
    DocumentoBaixado := 'S';
    DataBaixa := Date;
  End;
  Financeiro.salva;
End;

procedure TFr_Baixa_Dup_Desc.SB_ConfirmarClick(Sender: TObject);
begin
  if validagravacao then
  Begin
    Gravar;
    Close;
  End;
end;

procedure TFr_Baixa_Dup_Desc.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Baixa_Dup_Desc.Totalizador;
Var
  Lc_Aux : Real;
begin
  Lc_Aux := StrToFloatDef(E_Vl_Pagar.Text,0);
  Lc_Aux := Lc_Aux + StrToFloatDef(E_Juros.Text,0);
  Lc_Aux := Lc_Aux + StrToFloatDef(E_Mora.Text,0);
  Lc_Aux := Lc_Aux - StrToFloatDef(E_Desconto.Text,0);

  E_Valor_Pago.Text := FloatToStrF(Lc_Aux, ffFixed, 10,2);
end;

end.
