unit reg_electronic_card;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, System.StrUtils, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, ControllerCartaoEletronico, Un_Fm_CentroResultado, Un_Fm_CentroCusto, Un_Fm_ListaContaBancaria, Un_Fm_FormaPagto;

type
  TRegElectronicCard = class(TBaseRegistry)
    pnl_fundos: TPanel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    E_Codigo: TEdit;
    grbx_vista: TGroupBox;
    Label4: TLabel;
    Label8: TLabel;
    E_Aliq_Cred: TEdit;
    E_Prz_Cred: TEdit;
    grbx_parcela: TGroupBox;
    Label9: TLabel;
    Label5: TLabel;
    E_Aliq_Debi: TEdit;
    E_Prz_DEbi: TEdit;
    E_Contato: TEdit;
    E_Fone: TEdit;
    E_Validade: TEdit;
    dbrg_tipo: TRadioGroup;
    Fm_ListaContaBancaria: TFm_ListaContaBancaria;
    Fm_CentroCusto: TFm_CentroCusto;
    Fm_CentroResultado: TFm_CentroResultado;
    Fm_FormaPagto: TFm_FormaPagto;
  protected
    procedure AtivaTabelas;override;
    procedure ClearAllFields; Override;
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure ShowData; Override;
    procedure ShowNoData; Override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;
  private
    EletronicCard : TControllerCartaoEletronico;
  end;

var
  RegElectronicCard: TRegElectronicCard;

implementation

uses     UN_MSG, env;

{$R *.dfm}

procedure TRegElectronicCard.AtivaTabelas;
begin
  inherited;
  Fm_ListaContaBancaria.Listar;
  Fm_FormaPagto.Pc_Listar(3,False,0);
  Fm_CentroCusto.Pc_ListaParaUsar;
  Fm_CentroResultado.Pc_ListaParaUsar;
end;

procedure TRegElectronicCard.Change;
begin
  inherited;
  dbrg_tipo.SetFocus;
end;

procedure TRegElectronicCard.ClearAllFields;
begin
  inherited;
  //
end;

procedure TRegElectronicCard.CriarVariaveis;
begin
  inherited;
  EletronicCard := TControllerCartaoEletronico.create(self);
end;

procedure TRegElectronicCard.Delete;
begin
  EletronicCard.delete;
  inherited;
end;

procedure TRegElectronicCard.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(EletronicCard);
end;

procedure TRegElectronicCard.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    EletronicCard.Registro.Codigo := Self.CodigoRegistro;
    EletronicCard.getbyId;
  End;
  inherited;
end;

procedure TRegElectronicCard.Insert;
begin
  inherited;
  dbrg_tipo.SetFocus;
end;

procedure TRegElectronicCard.Save;
begin
  with EletronicCard do
  Begin
    Registro.FormaPagamento := Fm_FormaPagto.DBLCB_FormaPagto.KeyValue;
    Registro.Descricao := Fm_FormaPagto.DBLCB_FormaPagto.Text;
    Registro.Tipo := ifthen(dbrg_tipo.ItemIndex = 0, 'C', 'D');
    Registro.AliqCredito := StrToFloatDef(E_Aliq_Cred.Text, 0);
    Registro.PrazoCredito := StrToIntDef(E_Prz_Cred.Text, 0);
    Registro.AliqDebito := StrToFloatDef(E_Aliq_Debi.Text, 0);
    Registro.PrazoDebito := StrToIntDef(E_Prz_DEbi.Text, 0);
    Registro.Contato := E_Contato.Text;
    Registro.Fone := E_Fone.Text;
    if E_Validade.Text <> EmptyStr then
      registro.Validade := StrToDate(E_Validade.Text);

    Registro.ContaCorrente := Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue;

    if Fm_CentroCusto.DBLCB_Plano.Text <> '' then
      Registro.PlanoDebito := Fm_CentroCusto.DBLCB_Plano.KeyValue
    else
      Registro.PlanoDebito := 0;

    if Fm_CentroResultado.DBLCB_Plano.Text <> '' then
      Registro.PlanoCredito := Fm_CentroResultado.DBLCB_Plano.KeyValue
    else
      Registro.PlanoCredito := 0;

    salva;
  End;
  CodigoRegistro := EletronicCard.Registro.Codigo;
  inherited;
end;

procedure TRegElectronicCard.ShowData;
begin
  with EletronicCard do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    Fm_FormaPagto.DBLCB_FormaPagto.KeyValue := Registro.FormaPagamento;
    if Registro.Tipo = 'C' then
      dbrg_tipo.ItemIndex := 0
    else
      dbrg_tipo.ItemIndex := 1;
    E_Aliq_Cred.Text := FloatToStrF(Registro.AliqCredito, ffFixed, 10, 2);
    E_Prz_Cred.Text := IntToStr(Registro.PrazoCredito);
    E_Aliq_Debi.Text := FloatToStrF(Registro.AliqDebito, ffFixed, 10, 2);
    E_Prz_DEbi.Text := IntToStr(Registro.PrazoDebito);
    E_Contato.Text := Registro.Contato;
    E_Fone.Text := Registro.Fone;
    E_Validade.Text := DateToStr(registro.Validade);
    Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue := Registro.ContaCorrente;
    Fm_CentroCusto.DBLCB_Plano.KeyValue := Registro.PlanoDebito;
    Fm_CentroResultado.DBLCB_Plano.KeyValue := Registro.PlanoCredito;
  End;
  inherited;
end;

procedure TRegElectronicCard.ShowNoData;
begin
  //
end;

function TRegElectronicCard.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegElectronicCard.ValidateSave: boolean;
begin
  Result:=true;
  if (trim(Fm_FormaPagto.DBLCB_formaPagto.Text) = '') then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(Fm_FormaPagto.Lb_FormaPagamento.Caption);
    Result:=false;
    Fm_FormaPagto.DBLCB_formaPagto.SetFocus;
    Exit;
  end;

  if dbrg_tipo.ItemIndex < 0 THEN
  begin
    TMsgSetes.ValidaPreenchimentoCampo(dbrg_tipo.Caption);
    Result:=false;
    dbrg_tipo.SetFocus;
    Exit;
  end;

  if StrToFloatDef(E_Aliq_Cred.Text,0) =0  then
  begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Taxa de Desconto � vista tem que ser maior que zero.'+EOLN+
                       'Preencha a Taxa de desconto a vista deste Cartão.'+EOLN+
                       'Caso continue assim, ter� problemas no cálculo de taxas.'+EOLN+
                       'Deseja continuar mesmo assim ?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
    Begin
      Result:=false;
      E_Aliq_Cred.SetFocus;
      Exit;
    End;
  end;
  {
  if StrToIntDef(trim(E_Prz_Cred.Text),0) = 0  then
  begin
    MensagemPadrao(' Mensagem de erro',ATENCAO+EOLN+EOLN+
                   ' Prazo de Pagamento a vista tem que ser maior que zero.'+EOLN+
                   ' Preencha o Prazo de Pagamento a vista deste Cartão.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    Result:=false;
    E_Prz_Cred.SetFocus;
    Exit;
  end;
  }

  if dbrg_tipo.ItemIndex = 0 then
  begin

    if StrToFloatDef(E_Aliq_Debi.Text,0) =0 then
    begin
      if (MensagemPadrao(TITULO_CONFIRMACAO,
                         'Taxa de Desconto parcelado tem que ser maior que zero.'+EOLN+
                         'Preencha a Taxa de desconto a vista deste Cartão.'+EOLN+
                         'Caso continue assim, ter� problemas no cálculo de taxas.'+EOLN+
                         'Deseja continuar mesmo assim ?',
                        [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
      Begin
        Result:=false;
        E_Aliq_Debi.SetFocus;
        Exit;
      End;
    end;
    {
    if StrToIntDef(trim(E_Prz_DEbi.Text),0) = 0  then
    begin
      MensagemPadrao(' Mensagem de erro',ATENCAO+EOLN+EOLN+
                     ' Prazo de Pagamento parcelado tem que ser maior que zero.'+EOLN+
                     ' Preencha o Prazo Parcelado deste Cartão.'+EOLN,
                      ['OK'],[bEscape],mpErro);
      Result:=false;
      E_Prz_DEbi.SetFocus;
      Exit;
    end;
    }
  end;


  if (trim(E_Contato.Text) = '') then
  begin
    MensagemPadrao(' Mensagem de erro',ATENCAO+EOLN+EOLN+
                   ' Contato do Cartão não informado.'+EOLN+
                   ' Preencha o Contato deste Cartão.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    Result:=false;
    E_Contato.SetFocus;
    Exit;
  end;


  if (trim(Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text) = '') then
  begin
    MensagemPadrao(' Mensagem de erro',ATENCAO+EOLN+EOLN+
                   ' Conta Corrente Vinculada não informado.'+EOLN+
                   ' Preencha a Conta Corrente deste Cartão.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    Result:=false;
    Fm_ListaContaBancaria.DBLCB_ContaBancaria.SetFocus;
    Exit;
  end;

end;

end.
