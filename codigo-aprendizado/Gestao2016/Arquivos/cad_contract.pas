unit cad_contract;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, ControllerContract;

type
  TCadContract = class(TBaseRegistry)
    Label1: TLabel;
    Label26: TLabel;
    E_Tittle: TEdit;
    CB_Kind: TComboBox;
    Sb_edit_contract: TSpeedButton;
    Sb_select_data: TSpeedButton;
    Sb_Chaves: TSpeedButton;
    procedure Sb_edit_contractClick(Sender: TObject);
    procedure Sb_select_dataClick(Sender: TObject);
    procedure Sb_ChavesClick(Sender: TObject);
  private
    procedure LimpaCampos;
  protected
    procedure CriarVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure ShowData;Override;


    procedure Insert;Override;

    function ValidateChange:Boolean;Override;
    procedure Change;Override;

    function ValidateDelete():boolean;Override;
    procedure Delete;Override;

    function ValidateSave:Boolean;Override;
    procedure Save;Override;

    function ValidateCancel:Boolean;Override;
    procedure Cancel;Override;
  public
    Contrato : TControllerContract;
  end;

var
  CadContract: TCadContract;

implementation

{$R *.dfm}

uses     UN_Principal, env, Un_Msg, tas_html_editor, cad_contract_sql_cmd, cad_contract_chaves_tags;

{ TCadContract }

procedure TCadContract.Cancel;
begin
  inherited;

end;

procedure TCadContract.Change;
begin
  E_Tittle.SetFocus
end;

procedure TCadContract.CriarVariaveis;
begin
  inherited;
  Contrato := TControllerContract.create(Self);
  Contrato.ComboKind(CB_Kind);
end;

procedure TCadContract.Delete;
begin
  inherited;
  Contrato.delete;
  close;
end;

procedure TCadContract.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(Contrato);
end;

procedure TCadContract.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    Contrato.Registro.Codigo := Self.CodigoRegistro;
    Contrato.Registro.Estabelecimento := Gb_Codmha;
    Contrato.getbyId;
  End;
  inherited;


end;

procedure TCadContract.Insert;
begin
  LimpaCampos;
  E_Tittle.SetFocus
end;

procedure TCadContract.LimpaCampos;
begin
  e_tittle.clear;
  Contrato.ComboKind(CB_Kind);
end;

procedure TCadContract.Save;
begin
  with contrato do
  Begin
    Registro.EsTabelecimento := Gb_Codmha;
    Registro.Titulo    := E_Tittle.Text;
    Registro.Tipo      := CB_KInd.Text ;
    salva;
  End;
  CodigoRegistro := Contrato.Registro.Codigo;
  EditionState := 'B';
  EditionControl;
end;

procedure TCadContract.ShowData;
begin
  with Contrato do
  Begin
    E_Tittle.Text           := Registro.Titulo;
    CB_Kind.Text            := Registro.Tipo;
  End;
end;

procedure TCadContract.Sb_ChavesClick(Sender: TObject);
Var
  Lc_Form : TCadContractChavesTags;
begin
  try
    Lc_Form := TCadContractChavesTags.create(nil);
    Lc_Form.CodigoContrato := Contrato.Registro.Codigo;
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;

end;

procedure TCadContract.Sb_edit_contractClick(Sender: TObject);
Var
  Lc_form : TTasHtmlEditor;
begin
  try
    Lc_form := TTasHtmlEditor.create(nil);
    Lc_form.Conteudo := Contrato.Registro.Conteudo;
    Lc_form.ShowModal;
    Contrato.Registro.Conteudo := Lc_form.Conteudo;
  finally
    FreeAndNil(Lc_form);
  end;
end;

procedure TCadContract.Sb_select_dataClick(Sender: TObject);
Var
  LcContrato: TControllerContract;
  Lc_Form : TCadContractSqlCMd;
begin
  try
    Lc_Form := TCadContractSqlCMd.create(self);
    Lc_Form.Contrato.ClonarObj(Contrato.Registro,Lc_Form.Contrato.Registro);
    Lc_Form.ShowModal;
    Contrato.ClonarObj(Lc_Form.Contrato.Registro,Contrato.Registro);
  finally
    LcContrato := Lc_Form.Contrato;
    Lc_Form.Contrato := nil;
    FreeAndNil(LcContrato);
    FreeAndNil(Lc_Form);
  end;
end;

function TCadContract.ValidateCancel: Boolean;
begin
  REsult := True;
end;

function TCadContract.ValidateChange: Boolean;
begin
  Result := True;
end;

function TCadContract.ValidateDelete: boolean;
begin
  Result := True;
  //quando a pergunta esta dentro da validação verifica-se o botão da negativa
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja delete este item?'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                      [NAO,SIM],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;

end;

function TCadContract.ValidateSave: Boolean;
begin
  REsult := True;
  if Trim(E_Tittle.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Título do contrato não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if E_Tittle.CanFocus then E_Tittle.SetFocus;
    Exit;
  end;


  if Trim(CB_Kind.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Tipo do Contrato não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if CB_Kind.CanFocus then CB_Kind.SetFocus;
    Exit;
  end;
end;

end.
