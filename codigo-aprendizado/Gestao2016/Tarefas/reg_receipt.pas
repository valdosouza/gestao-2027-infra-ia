unit reg_receipt;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, ControllerRecibo;

type
  TRegReceipt = class(TBaseRegistry)
    Panel1: TPanel;
    L_Numero: TLabel;
    L_Data: TLabel;
    L_Emitente: TLabel;
    L_Vl_Recibo: TLabel;
    L_Sacado: TLabel;
    L_Referencia: TLabel;
    E_Numero: TEdit;
    E_Vl_Recibo: TEdit;
    E_Emitente: TEdit;
    E_Sacado: TEdit;
    E_Referencia: TMemo;
    E_Data: TDateTimePicker;
    SB_Imprimir: TSpeedButton;
    procedure E_Vl_ReciboExit(Sender: TObject);
    procedure SB_ImprimirClick(Sender: TObject);
  private
    FAutoFill: boolean;
    procedure setFAutoFill(const Value: boolean);
    procedure ImprimeCupom(Tipo:String);
  protected
    //Variaveis
    procedure ClearAllFields;Override;
    procedure CriarVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure setPerfil;Override;
    procedure ImagemBotao;Override;
    procedure ShowData;override;
    procedure EditionControl;Override;
    //inserir
    procedure Insert;override;
    //Editar
    function ValidateChange():boolean;override;
    procedure Change;override;
    //Deletar
    procedure Delete;override;
    //Salvar
    function ValidateSave():boolean;override;
    procedure Save;override;

  public
    Recibo : TControllerRecibo;
    property AutoFill : boolean read FAutoFill write setFAutoFill;
  end;

var
  RegReceipt: TRegReceipt;

implementation

{$R *.dfm}

uses     un_msg, env, un_func_img_button, un_frx_recibo, Un_DM, un_funcoes, un_sistema, un_RL_Recibo;

{ TRegReceipt }

procedure TRegReceipt.Change;
begin
  inherited;
  E_Numero.SetFocus;
end;

procedure TRegReceipt.ClearAllFields;
begin
  inherited;
  Recibo.clear;
end;

procedure TRegReceipt.CriarVariaveis;
begin
  inherited;
  Recibo := TControllerRecibo.create(Self);
end;

procedure TRegReceipt.Delete;
begin
  Recibo.Delete;
end;

procedure TRegReceipt.EditionControl;
begin
  inherited;
  SB_Imprimir.Enabled := ( EditionState = 'B' );
end;

procedure TRegReceipt.E_Vl_ReciboExit(Sender: TObject);
Var
  Lc_valor : Real;
begin
  inherited;
  Lc_valor := StrToFloatDef(RemoveCaracterInformado(TEdit(sender).Text,['.']),0);
  TEdit(sender).Text := FloatToStrF(Lc_valor,ffNumber,10,2);
end;

procedure TRegReceipt.FinalizaVariaveis;
begin
  FreeAndNil(Recibo);
  inherited;
end;

procedure TRegReceipt.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(SB_Imprimir,'IMPRIMIR');
end;

procedure TRegReceipt.ImprimeCupom(Tipo: String);
Var
  Lc_Ano,Lc_mes,Lc_dia:String ;
  Lc_Rec : TFrx_Recibo;
  Lc_valor : real;
begin
  try
    Lc_dia := Copy(DateTimeToStr(E_Data.Date),1,2);
    Lc_mes := Fc_DesMes(Fc_Month(E_Data.Date),True);
    Lc_Ano := Copy(DateTimeToStr(E_Data.Date),7,4);

    Lc_Rec := TFrx_Recibo.create(Nil);
    Lc_Rec.Codigo := Recibo.Registro.codigo;
    Lc_Rec.Numero := E_Numero.Text;
    Lc_valor := StrToFloatDef(E_Vl_Recibo.Text,0);
    Lc_Rec.Detalhe := Concat(
        'Recebemos de ',
        E_Sacado.Text,
        ' a importância de R$ ', FloatToStrF(lc_valor,ffCurrency,10,2)  ,'(',Fc_Extenso(StrToFloatDef(E_Vl_Recibo.Text,0)),')',
        ' REFERENTE A ',E_Referencia.Text
    );
     Lc_Rec.sacado := E_Sacado.Text;
    Lc_Rec.LocalData := concat(DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString ,  ', ' , Lc_dia , ' de ' , Lc_mes , ' de ', Lc_Ano , ' - ' , TimeToStr(time));
    Lc_Rec.frxBase.ShowReport;
  finally
    Lc_Rec.Close;
    FreeAndNil(Lc_Rec)
  end;
end;

procedure TRegReceipt.IniciaVariaveis;
begin
  if not FAutoFill then
  Begin
    if Self.CodigoRegistro > 0 then
    Begin
      Recibo.Registro.Codigo := Self.CodigoRegistro;
      Recibo.Registro.Estabelecimento := Gb_CodMha;
      Recibo.getbyId;
    End;
    inherited;
  End;
end;

procedure TRegReceipt.Insert;
begin
  inherited;
  E_Sacado.Enabled:= true;
  E_Data.Date:= Now;
  E_Numero.SetFocus;
end;

procedure TRegReceipt.Save;
begin
  with Recibo do
  Begin
    Registro.Numero := StrToIntDef(E_Numero.Text,0);
    Registro.Valor := StrToFloatDef(RemoveCaracterInformado(E_Vl_Recibo.Text,['.']),0);
    Registro.Data:= E_Data.DateTime;
    Registro.Sacado := E_Sacado.Text;
    Registro.referencia := E_Referencia.Text;
    Registro.Emitente := E_Emitente.Text;
  End;
  Recibo.salva;
  CodigoRegistro := Recibo.Registro.Codigo;
  E_Numero.Text := Recibo.Registro.Numero.toString;
  inherited;
end;

procedure TRegReceipt.SB_ImprimirClick(Sender: TObject);
VAR
  Lc_Escolha : Integer;
begin
  Lc_Escolha:=(MensagemPadrao(TITULO_INFORMACAO,
                              'Imprimir?',
                              ['CUPOM','NORMAL','CANCELA'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
  case Lc_Escolha of
    0:Begin
        ImprimeCupom('RECIBO');
      end;
    1:Begin
        if not Assigned(RL_Recibo) then Application.CreateForm(TRL_Recibo, RL_Recibo);
        RL_Recibo.Qr_Recibo.Active := False;
        RL_Recibo.Qr_Recibo.ParamByName('REC_CODIGO').AsInteger := Recibo.Registro.Codigo;
        RL_Recibo.Qr_Recibo.Active := True;
        TRY
          RL_Recibo.Qrpt.Preview
        finally
          RL_Recibo.Close;
        end;
      end;
    end;
end;

procedure TRegReceipt.setFAutoFill(const Value: boolean);
begin
  FAutoFill := value;
  if FAutoFill then
  Begin
    EditionState := 'I';
    EditionControl;
    E_Sacado.Enabled:= true;
    E_Data.Date:= Now;
    with Recibo do
    Begin
      E_Numero.Text     := '0';
      E_Vl_Recibo.Text  := FloatToStrF(Registro.Valor,ffFixed,10,2);
      E_Data.DateTime   := Registro.Data;
      E_Sacado.Text     := Registro.Sacado;
      E_Referencia.Text := Registro.referencia;
      E_Emitente.Text   := Registro.Emitente;
    End;
  End;
end;

procedure TRegReceipt.setPerfil;
begin
  inherited;

end;

procedure TRegReceipt.ShowData;
begin
  with Recibo do
  Begin
    E_Numero.Text     := Registro.Numero.ToString;
    E_Vl_Recibo.Text  := FloatToStrF(Registro.Valor,ffFixed,10,2);
    E_Data.DateTime   := Registro.Data;
    E_Sacado.Text     := Registro.Sacado;
    E_Referencia.Text := Registro.referencia;
    E_Emitente.Text   := Registro.Emitente;
  End;

end;


function TRegReceipt.ValidateChange: boolean;
begin
  Result := True;
  if ( Recibo.Registro.CodigoQuitacao > 0 ) then
  begin
    MensagemPararExecucao('Recibo com vánculo no financeiro.' + EOLN +
                          'Não é possível a alteração deste recibo.');
    exit;
  end;
  inherited;
end;


function TRegReceipt.ValidateSave: boolean;
begin
  Result:=TRUE;
  Recibo.Registro.Estabelecimento := Gb_CodMha;
  Recibo.Registro.Numero := StrToIntDef(E_Numero.Text,0);
  if Recibo.VerificaNumRecibo then
  begin
    MensagemPararExecucao(' Número de Recibo já existe.' + EOLN +
                          ' Digite outro número para o Recibo.');
    Result:=false;
    exit;
  end;


  if StrToFloatDef(RemoveCaracterInformado(E_Vl_Recibo.Text,['.']),0) = 0 then
  begin
    MensagemValidaPreenchimentoCampo(L_Vl_Recibo.Caption);
    Result:=false;
    exit;
  end;

  if TRim(E_Sacado.Text) ='' then
  begin
    MensagemValidaPreenchimentoCampo(L_Sacado.Caption);
    Result:=false;
    exit;
  end;

  if TRim(E_Emitente.Text) ='' then
  begin
    MensagemValidaPreenchimentoCampo(L_Emitente.Caption);
    Result:=false;
    exit;
  end;

  if TRim(E_Referencia.Text) ='' then
  begin
    MensagemValidaPreenchimentoCampo(L_Referencia.Caption);
    Result:=false;
    exit;
  end;

end;

end.
