unit lote_base_troca;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, QEdit_Setes, Vcl.Buttons, Un_Fm_ListaEmpresas, ControllerItensNFL, Vcl.ComCtrls;


type
  TLoteBaseTroca = class(TFr_Base)
    Panel1: TPanel;
    Panel2: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    Label10: TLabel;
    E_Peso_Entrada: TEdit_Setes;
    Fm_ListaEmpresas: TFm_ListaEmpresas;
    Label2: TLabel;
    E_Data_Entrada: TDateTimePicker;
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
  private
    { Private declarations }
    function validateLote:Boolean;
    procedure LancaLote;

  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure ImagemBotao;Override;
  public
    { Public declarations }
    ItensNFL : TControllerItensNFL;
  end;

var
  LoteBaseTroca: TLoteBaseTroca;

implementation

uses     Un_Msg, env;

{$R *.dfm}

{ TLoteBaseTroca }

procedure TLoteBaseTroca.CriarVariaveis;
begin
  inherited;
  ItensNFL := TControllerItensNFL.create(Self);
end;

procedure TLoteBaseTroca.ImagemBotao;
begin
  CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
  CarregaImagemBotao(SB_Sair_0,'SAIR');
end;

procedure TLoteBaseTroca.IniciaVariaveis;
begin
  inherited;
  Fm_ListaEmpresas.Pc_AtivaEmpresa(1);
  E_Data_Entrada.Date := Date;
end;

procedure TLoteBaseTroca.LancaLote;
Var
  I : Integer;
  Lc_PesoTotal : Real;
  Lc_SaldoRegistro : Real;
begin
  Lc_PesoTotal := StrToFloatDef(E_Peso_Entrada.Text,0);
  with ItensNFL do
  Begin
    BaseTroca.Registro.Cliente := Fm_ListaEmpresas.DBLCB_Empresa.KeyValue;
    BaseTroca.getlistPendente;

    for I := 0 to BaseTroca.Lista.Count-1 do
    Begin
      if ( Lc_PesoTotal > 0 ) then
      Begin
        BaseTroca.ClonarObj(BaseTroca.Lista[I],BaseTroca.Registro);
        Lc_SaldoRegistro :=  BaseTroca.registro.PesoSaida - BaseTroca.registro.PesoEntrada;
        //se o saldo for negativo é por que recebeu mais da ultima vez do que esperado...entao será ajustado no tempo certo em proximos registros;
        if Lc_SaldoRegistro < 0 then
        Begin
           //transforma em positivo
           Lc_SaldoRegistro := Lc_SaldoRegistro * -1;
           BaseTroca.registro.PesoEntrada := BaseTroca.registro.PesoEntrada - Lc_SaldoRegistro;
           BaseTroca.update;
           Lc_PesoTotal := Lc_PesoTotal + Lc_SaldoRegistro;
        End
        else
        Begin
          //se o saldo for positivo é por que recebeu menos da ultima vez do que esperado...entao será ajustado no tempo certo em proximos registros;
          if (Lc_SaldoRegistro > 0) and (BaseTroca.registro.PesoEntrada > 0) then
          Begin
             BaseTroca.registro.PesoEntrada := BaseTroca.registro.PesoSaida;
             BaseTroca.update;
             Lc_PesoTotal := Lc_PesoTotal - Lc_SaldoRegistro;
          End
          else
          Begin
            if Lc_PesoTotal >= Lc_SaldoRegistro then
            Begin
              if ( I = BaseTroca.Lista.Count-1 ) then
              Begin
                BaseTroca.registro.PesoEntrada := Lc_PesoTotal;
              End
              else
              Begin
                BaseTroca.registro.PesoEntrada := Lc_SaldoRegistro;
                Lc_PesoTotal := Lc_PesoTotal - Lc_SaldoRegistro;
              End;
            End
            else
            Begin
              BaseTroca.registro.PesoEntrada := Lc_PesoTotal;
              Lc_PesoTotal := 0;
            End;
            BaseTroca.Registro.DataEntrada := E_Data_Entrada.DateTime;
            BaseTroca.update;
          End;
        End;
      End;
    End;
  End;

end;

procedure TLoteBaseTroca.SB_ConfirmarClick(Sender: TObject);
begin
  if validateLote then
  Begin
    LancaLote;
    Self.Close;
  End;
end;

procedure TLoteBaseTroca.SB_Sair_0Click(Sender: TObject);
begin
  Self.Close;
end;

function TLoteBaseTroca.validateLote:Boolean;
begin
  result := True;
  if StrToIntDef( Fm_ListaEmpresas.E_Cd_Empresa.Text,0) = 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Código cliente não informado.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

  if Fm_ListaEmpresas.DBLCB_Empresa.Text = '' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Nome do cliente não informado.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

  if StrToIntDef( E_Peso_Entrada.Text,0) = 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Peso Entrada deve ser maior que zero.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

end;

end.
