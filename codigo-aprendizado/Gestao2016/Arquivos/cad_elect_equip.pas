unit cad_elect_equip;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Un_Fm_ListaEmpresas, QEdit_Setes, Vcl.StdCtrls, Vcl.Mask, ControllerElectEquip;

type
  TCadElectEquip = class(TBaseRegistry)
    Fm_ListaEmpresas: TFm_ListaEmpresas;
    Label28: TLabel;
    Label29: TLabel;
    Label26: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    E_Serie: TEdit;
    E_IMei: TEdit;
    Label3: TLabel;
    E_Accessories: TEdit;
    CB_Device: TComboBox;
    CB_Brand: TComboBox;
    CB_Model: TComboBox;
  private
    procedure LimpaCampos;
    procedure setPerfil;Override;
  protected
    procedure CriarVariaveis;Override;
    procedure ShowData;Override;
    procedure IniciaVariaveis;Override;

    procedure Insert;Override;

    function ValidateDeleteItems:Boolean;
    procedure DeleteItem;


    function ValidateChange:Boolean;Override;
    procedure Change;Override;

    function ValidateDelete():boolean;Override;
    procedure Delete;Override;

    function ValidateSave:Boolean;Override;
    procedure Save;Override;

    function ValidateCancel:Boolean;Override;
    procedure Cancel;Override;

  public
    { Public declarations }
    Equipamento : TControllerElectEquip;
  end;

var
  CadElectEquip: TCadElectEquip;

implementation

{$R *.dfm}

uses     UN_Principal, env, UN_Sistema, Un_Msg;

{ TCadElectEquip }

procedure TCadElectEquip.Cancel;
begin
  inherited;

end;

procedure TCadElectEquip.Change;
begin
  inherited;
  Fm_ListaEmpresas.E_Cd_Empresa.SetFocus;
end;

procedure TCadElectEquip.CriarVariaveis;
begin
  inherited;
  Equipamento := TControllerElectEquip.Create(Self);
  Fm_ListaEmpresas.Pc_AtivaEmpresa(1);
  Equipamento.ComboDevice(CB_Device);
  Equipamento.ComboBrand(CB_Brand);
  Equipamento.ComboModel(CB_Model);
end;

procedure TCadElectEquip.Delete;
begin
  inherited;
  Equipamento.delete;
  Close;
end;

procedure TCadElectEquip.DeleteItem;
begin
  Equipamento.delete;
end;

procedure TCadElectEquip.IniciaVariaveis;
begin
  if CodigoRegistro > 0 then
  Begin
    Equipamento.Registro.Codigo := Self.CodigoRegistro;
    Equipamento.getbyId;
  End;
  inherited;
end;

procedure TCadElectEquip.Insert;
begin
  inherited;
  LimpaCampos;
  Fm_ListaEmpresas.E_Cd_Empresa.SetFocus;
end;


procedure TCadElectEquip.LimpaCampos;
begin
  Fm_ListaEmpresas.DBLCB_Empresa.KeyValue := null;
  Fm_ListaEmpresas.E_Cd_Empresa.clear;
  Equipamento.ComboDevice(CB_Device);
  Equipamento.ComboBrand(CB_Brand);
  Equipamento.ComboModel(CB_Model);
  E_Serie.clear;
  E_IMei.clear;
  E_Accessories.clear;
end;

procedure TCadElectEquip.Save;
begin
  with Equipamento do
  Begin
    Registro.Customer     := Fm_ListaEmpresas.DBLCB_Empresa.KeyValue;
    Registro.Dispositivo  := CB_Device.Text;
    Registro.Marca        := CB_Brand.Text;
    Registro.Modelo       := CB_Model.Text;
    Registro.Serie        := E_Serie.Text;
    Registro.Imei         := E_IMei.Text;
    Registro.Acessorios   := E_Accessories.Text;
    salva;
  End;
  CodigoRegistro := Equipamento.Registro.Codigo;
  EditionState := 'B';
  EditionControl;
end;

procedure TCadElectEquip.setPerfil;
Var
  Lc_Menu : String;
begin
  Lc_Menu := 'SeaElectEquip';
  if Gb_Nivel = 1 then
  begin
    Pf_Inserir    := True;
    Pf_Alterar    := True;
    Pf_Excluir    := True;
    Pf_Visualizar := True;
  end
  else
  begin
    Pf_Inserir    := Fc_HabilitaPermissao(Lc_Menu,'INSERIR','S');
    Pf_Alterar    := Fc_HabilitaPermissao(Lc_Menu,'ALTERAR','S');
    Pf_Excluir    := Fc_HabilitaPermissao(Lc_Menu,'EXCLUIR','S');
    Pf_Visualizar := Fc_HabilitaPermissao(Lc_Menu,'VISUALIZAR','S');
  end;

end;

procedure TCadElectEquip.ShowData;
begin
  with Equipamento do
  Begin
    Fm_ListaEmpresas.DBLCB_Empresa.KeyValue := Registro.Customer;
    Fm_ListaEmpresas.E_Cd_Empresa.Text := Registro.Customer.ToString();
    Cb_Device.Text       := Registro.Dispositivo;
    CB_Brand.Text        := Registro.Marca;
    CB_Model.Text       := Registro.Modelo;
    E_Serie.Text        := Registro.Serie;
    E_IMei.Text         := Registro.Imei;
    E_Accessories.Text  := Registro.Acessorios;
  End;
end;

function TCadElectEquip.ValidateCancel: Boolean;
begin
  REsult := True;
end;

function TCadElectEquip.ValidateChange: Boolean;
begin
  Result := True;
end;

function TCadElectEquip.ValidateDelete: boolean;
begin
  Result := True;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Deseja relamente excluir este Equipamento?.' + EOLN +EOLN +
                      'Confirmar a exclusão ?',
                      [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
  Begin
    Result := False;
    Exit;
  End;

end;

function TCadElectEquip.ValidateDeleteItems: Boolean;
begin
  Result := True;
  //quando a pergunta esta dentro da validação verifica-se o botão da negativa
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja Delete este item?'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                      [NAO,SIM],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;

end;


function TCadElectEquip.ValidateSave: Boolean;
begin
  REsult := True;
  if Trim( Fm_ListaEmpresas.DBLCB_Empresa.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Nome do cliente não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if Fm_ListaEmpresas.DBLCB_Empresa.CanFocus then Fm_ListaEmpresas.DBLCB_Empresa.SetFocus;
    Exit;
  end;

  if Trim(Cb_Device.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Dispositivo não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if Cb_Device.CanFocus then Cb_Device.SetFocus;
    Exit;
  end;

  if Trim(CB_Brand.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Marca não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if CB_Brand.CanFocus then CB_Brand.SetFocus;
    Exit;
  end;

  if Trim(CB_Model.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Modelo não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if CB_Model.CanFocus then CB_Model.SetFocus;
    Exit;
  end;

  if Trim(E_Serie.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Série não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if E_Serie.CanFocus then E_Serie.SetFocus;
    Exit;
  end;



end;

end.
