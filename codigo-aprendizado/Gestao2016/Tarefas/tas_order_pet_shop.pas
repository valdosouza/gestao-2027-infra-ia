unit tas_order_pet_shop;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, ControllerPetOrder, un_fm_lista_pet, Vcl.StdCtrls, Vcl.Mask;


type
  TTasOrderPetShop = class(TBaseRegistry)
    Fm_ListaPet: TFm_ListaPet;
    Label13: TLabel;
    E_Dt_Entrada: TMaskEdit;
    E_Hr_Entrada: TMaskEdit;
    Label1: TLabel;
    E_Dt_Prevista: TMaskEdit;
    E_Hr_Prevista: TMaskEdit;
    Label9: TLabel;
    E_Obs: TMemo;
    Label2: TLabel;
    E_Dt_Saida: TMaskEdit;
    E_Hr_Saida: TMaskEdit;
    ProcedimentosPeridicos1: TMenuItem;
    Contatos1: TMenuItem;
    procedure ProcedimentosPeridicos1Click(Sender: TObject);
    procedure Contatos1Click(Sender: TObject);
  private
    FCliente: Integer;
    procedure setFCliente(const Value: Integer);
    function ValidaOpenDeadLine:Boolean;
    procedure OpenDeadLine;
    function ValidaOpenContact:Boolean;
    procedure OpenContact;
  protected
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure setPerfil;Override;

    procedure ShowData;Override;
    procedure ShowNoData;Override;

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
    //Cancelar
    function ValidateCancel():boolean;Override;
    procedure Cancel;Override;

  public
    { Public declarations }
    Atendimento : TControllerPetOrder;
    property Cliente : Integer read FCliente write setFCliente;
  end;

var
  TasOrderPetShop: TTasOrderPetShop;

implementation

uses     Un_Msg, cad_pet_contact, cad_pet_deadline, env;
{$R *.dfm}

{ TTasOrderPetShop }

procedure TTasOrderPetShop.Cancel;
begin

end;

procedure TTasOrderPetShop.Change;
begin
  if Atendimento.Registro.Pet = 0 then
  Begin
    E_Dt_Entrada.Text   := DateToStr(Date);
    E_Hr_Entrada.Text   := Copy(TimeToStr(Time),1,5);
    E_Dt_Prevista.Text  := DateToStr(Date);
  End;
  E_Dt_Entrada.SetFocus;
end;

procedure TTasOrderPetShop.Contatos1Click(Sender: TObject);
begin
  if ValidaOpenContact then
    OpenContact;
end;

procedure TTasOrderPetShop.CriarVariaveis;
begin
  inherited;
  Atendimento := TControllerPetOrder.Create(Self);

end;

procedure TTasOrderPetShop.Delete;
begin
  inherited;
  Atendimento.delete;
  Close;
end;

procedure TTasOrderPetShop.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    Atendimento.Registro.Pedido := Self.CodigoRegistro;
    Atendimento.getbyId;
  End;
  Fm_ListaPet.Cliente := FCliente;
  Fm_ListaPet.Listar;
  inherited;
end;

procedure TTasOrderPetShop.Insert;
begin
  E_Dt_Entrada.Text := DateToStr(Date);
  E_Hr_Entrada.Text := Copy(TimeToStr(Time),1,5);
  E_Dt_Entrada.SetFocus;
end;

procedure TTasOrderPetShop.OpenContact;
Var
  Lc_Form : TCadPetContact;
Begin
  Try
    Lc_Form := TCadPetContact.Create(nil);
    Lc_Form.CodigoRegistro := Atendimento.Registro.Pet;
    Lc_Form.ShowModal
  Finally
    FreeAndNil(Lc_Form);
  End;

end;

procedure TTasOrderPetShop.OpenDeadLine;
Var
  Lc_Form : TCadPetDeadline;
Begin
  Try
    Lc_Form := TCadPetDeadline.Create(nil);
    Lc_Form.CodigoRegistro := Atendimento.Registro.Pet;
    Lc_Form.ShowModal
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TTasOrderPetShop.ProcedimentosPeridicos1Click(Sender: TObject);
Begin
  if ValidaOpenDeadLine then
    OpenDeadLine;

end;

procedure TTasOrderPetShop.Save;
begin
  with Atendimento do
  Begin
    if E_Dt_Entrada.Text = '  /  /    ' then
      registro.DataEntrada := 0
    else
      registro.DataEntrada := StrToDateDef(E_Dt_Entrada.Text,0);
    registro.HoraEntrada := E_Hr_Entrada.Text;
    Registro.Pet         := Fm_ListaPet.Dblcb_Lista.KeyValue;
    if E_Dt_Prevista.Text = '  /  /    ' then
      registro.DataPrevista := 0
    else
      registro.DataPrevista := StrToDateDef(E_Dt_Prevista.Text,0);
    registro.HoraPrevista := E_Hr_Prevista.Text;

    Registro.Observacao := E_Obs.Text;
    if E_Dt_Saida.Text = '  /  /    ' then
      registro.DataSaida := 0
    else
      registro.DataSaida := StrToDateDef(E_Dt_Saida.Text,0);
    registro.HoraSaida := E_Hr_Saida.Text;


    salva;
  End;
  CodigoRegistro := Atendimento.Registro.Pedido;
  EditionState := 'B';
  EditionControl;

end;

procedure TTasOrderPetShop.setFCliente(const Value: Integer);
begin
  FCliente := Value;
end;

procedure TTasOrderPetShop.setPerfil;
begin
  inherited;

end;

procedure TTasOrderPetShop.ShowData;
begin
  with Atendimento do
  Begin
    Fm_ListaPet.Dblcb_Lista.KeyValue := Registro.Pet;
    if registro.DataEntrada >0 then
      E_Dt_Entrada.Text := DateToStr(registro.DataEntrada)
    else
      E_Dt_Entrada.Clear;
    E_Hr_Entrada.Text := Registro.HoraEntrada;

    if registro.DataPrevista >0 then
      E_Dt_Prevista.Text := DateToStr(registro.DataPrevista)
    else
      E_Dt_Prevista.Clear;
    E_Hr_Prevista.Text := Registro.HoraPrevista;

    E_Obs.Text := Registro.Observacao;

    if registro.DataSaida >0 then
      E_Dt_Saida.Text := DateToStr(registro.DataSaida)
    else
      E_Dt_Saida.Clear;
    E_Hr_Saida.Text := Registro.HoraSaida;

  End;

end;

procedure TTasOrderPetShop.ShowNoData;
begin
  ClearAllFields;
end;

function TTasOrderPetShop.ValidaInsert: boolean;
begin
  Result := True;
end;

function TTasOrderPetShop.ValidaOpenContact: Boolean;
begin
  Result := True;
  if Atendimento.Registro.Pet = 0 then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Pet ainda não registrado.'+EOLN+
                   'Registre  para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    Exit;
  end;


end;

function TTasOrderPetShop.ValidaOpenDeadLine: Boolean;
begin
  Result := True;
  if Atendimento.Registro.Pet = 0 then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Pet ainda não registrado.'+EOLN+
                   'Registre  para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    Exit;
  end;


end;

function TTasOrderPetShop.ValidateCancel: boolean;
begin
  Result := True;
end;

function TTasOrderPetShop.ValidateChange: boolean;
begin
  Result := True;
end;

function TTasOrderPetShop.ValidateDelete: boolean;
begin
  Result := True;
  //quando a pergunta esta dentro da validação verifica-se o botão da negativa
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja Delete este item?'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                      [NAO, SIM],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;

end;

function TTasOrderPetShop.ValidateSave: boolean;
begin
  REsult := True;
  if StrToDateDef(E_Dt_Entrada.Text,0) = 0 then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Data de Entrada não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if E_Dt_Entrada.CanFocus then E_Dt_Entrada.SetFocus;
   Exit;
  end;

  if StrToTimeDef(E_Hr_Entrada.Text,0) = 0 then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'HOra de Entrada não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if E_Dt_Entrada.CanFocus then E_Dt_Entrada.SetFocus;
   Exit;
  end;

  if Trim(Fm_ListaPet.Dblcb_Lista.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Informar o nome do PET.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if Fm_ListaPet.Dblcb_Lista.CanFocus then Fm_ListaPet.Dblcb_Lista.SetFocus;
   Exit;
  end;

end;

end.
