unit reg_customer_prospection;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Empresa, Data.DB, STQuery, Vcl.Menus, Un_Fm_ListaColaboradores, Vcl.ComCtrls, Vcl.StdCtrls, QEdit_Setes, Vcl.DBCtrls, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls;

type
  TRegCustomerProspection = class(TFr_Empresa)
  private
      function Fc_EmailExiste(Fc_Email:TCustomEdit): boolean;
      function Fc_FoneExiste(Fc_Fone:TCustomEdit;Fc_Label:String): boolean;
      procedure Pc_MostraRegistro(Pc_Cd_Empresa:Integer;Pc_Campo:TCustomEdit;Pc_Label:String);
  protected
    function Fc_ValidaGravacao(): boolean;Override;
    procedure Pc_GravaEmpresa;Override;
  public
    { Public declarations }

  end;

var
  RegCustomerProspection: TRegCustomerProspection;

implementation

{$R *.dfm}

uses     Un_Funcoes, un_msg;

{ TRegCustomerProspection }

function TRegCustomerProspection.Fc_EmailExiste(Fc_Email: TCustomEdit): boolean;
Var
  Lc_Msg:String;
Begin
  Result := False;
  if (Length(TRim(Fc_Email.Text)) >0) then
  Begin
    with Qr_BuscaEmail do
    bEGIN
      Active := FAlse;
      ParamByName('EMP_CODIGO').AsInteger := StrToIntDef(E_Codigo.Text,0);
      ParamByName('email').AsString := Fc_Email.Text;
      Active := True;;
      FetchAll;

      if (FieldByName('EMP_CODIGO').AsInteger > 0)  then
      begin
        Pc_MostraRegistro(FieldByName('EMP_CODIGO').AsInteger,Fc_Email,'E-mail');
        Result := True;
        exit;
      end;
    end;
  end;
end;

function TRegCustomerProspection.Fc_FoneExiste(Fc_Fone: TCustomEdit;
  Fc_Label: String): boolean;
Var
  Lc_Msg:String;
  Lc_Fone : String;
Begin
  Result := False;
  Lc_fone := Fc_RemoveCaracterInformado(Fc_Fone.Text, ['(',')',' ','-','-']);
  if (Length(TRim(Lc_fone)) >= 8) then
  Begin
    with Qr_BuscaFone do  //4130952158
    bEGIN                 //0800411910
      case Length(Lc_fone) of
        10: Lc_fone := Copy(Lc_Fone,3,8);
        11: Lc_fone := Copy(Lc_Fone,3,9);
        12: Lc_fone := Copy(Lc_Fone,3,10);
      end;
      Active := FAlse;
      ParamByName('EMP_CODIGO').AsInteger := StrToIntDef(E_Codigo.Text,0);
      ParamByName('fone').AsString := '%' + Lc_FOne;
      Active := True;;
      FetchAll;
      if (FieldByName('EMP_CODIGO').AsInteger > 0)  then
      begin
        Pc_MostraRegistro(FieldByName('EMP_CODIGO').AsInteger,Fc_Fone,Fc_Label);
        Result := True;
        exit;
      end;
    end;
  end;
end;

function TRegCustomerProspection.Fc_ValidaGravacao: boolean;
Var
  lc_nome,  Lc_aux:String;
  Lc_Escolha:Integer;
Begin
   Lc_aux:='';
  Result := TRUE;
  if trim(E_Nome.Text) = '' then
  begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Nome ' +  lc_nome + ' não informado.'+EOLN+
                   'Preencha o Nome '  +lc_nome +EOLN,
                   ['OK'], [bEscape], mpErro);
    if E_Nome.CanFocus then E_Nome.SetFocus;
    Result := False;
    exit;
  end;

  IF Fc_EmailExiste(E_Email) THEN
  Begin
    Result := False;
    exit;
  end;
  if Fc_FoneExiste(E_Fone,'Fone') then
  Begin
    Result := False;
    exit;
  end;
  if Fc_FoneExiste(E_Fax,'Fax') then
  Begin
    Result := False;
    exit;
  end;
  if Fc_FoneExiste(E_Celular,'Celular') then
  Begin
    Result := False;
    exit;
  end;
  if Fc_FoneExiste(E_Fone_Coml,'Fone Comercial') then
  Begin
    Result := False;
    exit;
  end;
  if Fc_FoneExiste(E_Fone_Port,'Fone Portaria') then
  Begin
    Result := False;
    exit;
  end;
end;

procedure TRegCustomerProspection.Pc_GravaEmpresa;
begin
  Empresa.Registro.Tipo := -1;
  inherited;
end;

procedure TRegCustomerProspection.Pc_MostraRegistro(Pc_Cd_Empresa: Integer;
  Pc_Campo: TCustomEdit; Pc_Label: String);
begin
  if (MensagemPadrao(' Mensagem',
                      Pc_Label +' já registrado.' + EOLN +
                     ' Mostar este Registro agora ?',
                      ['Sim', 'N�o'], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
  begin
    FCodigoEmpresa := PC_cd_Empresa;
    Empresa.Registro.Codigo := FCodigoEmpresa;
    Empresa.getById;
    Pc_AtivarTabelas;
    SB_AlterarClick(Self);
  end
  else
  begin
    if Pc_Campo.CanFocus then
    Begin
      Pc_Campo.SetFocus;
      Pc_Campo.SelectAll;
    end;
  end;
end;

end.
