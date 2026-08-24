unit tas_contract_order;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Un_Base, ControllerContractOrder, STQuery, ComObj;

type
  TTasContractOrder = class(TBaseRegistry)
    Label1: TLabel;
    E_Tittle: TEdit;
    SpeedButton1: TSpeedButton;
    E_Last_Update: TEdit;
    Label2: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
  private
    procedure LimpaCampos;
    procedure AtualizaDadosContrato;
    procedure AjustaChavesCampos(Qry:TSTQuery);


    function AjustaChave(chave:String):String;

    procedure PrintHTMLByIE(const url: string);
  protected
    procedure CriarVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure ImagemBotao;Override;
    procedure ShowData;Override;
    procedure ShowNoData;Override;
    function ValidaInsert():boolean;Override;
    procedure Insert;Override;

    function ValidateChange():boolean;Override;

    function ValidateDelete():boolean;Override;
    procedure Delete;Override;

    function ValidateSave:Boolean;Override;
    procedure Save;Override;
    procedure EditionControl;Override;
  public
    { Public declarations }
    OrdemContrato : TControllerContractOrder;
  end;

var
  TasContractOrder: TTasContractOrder;

implementation

{$R *.dfm}

uses     Un_Msg, tas_html_editor, UN_Principal, env, sea_contract;
function TTasContractOrder.AjustaChave(chave: String): String;
begin
  Chave := StringReplace(Chave,'<','&lt;',[]);
  Chave := StringReplace(Chave,'>','&gt;',[]);
  Result := Chave;
end;

procedure TTasContractOrder.AjustaChavesCampos(Qry:TSTQuery);
Var
  I : Integer;
  Lc_Conteudo : String;
  Lc_Posicao : Integer;
  Lc_Chave : String;
  Lc_Field : String;
  Lc_valor : String;
begin
//      Delete(Linha,Posicao,Length(Enc));
//      Insert(Subs,Linha,Posicao);

  Lc_Conteudo := OrdemContrato.Registro.Conteudo;
  OrdemContrato.Contrato.ChavesField.Registro.contrato := OrdemContrato.Contrato.Registro.codigo;
  OrdemContrato.Contrato.ChavesField.getList;
  for I := 0 to OrdemContrato.Contrato.ChavesField.Lista.Count-1 do
  Begin
    Lc_Chave := AjustaChave(OrdemContrato.Contrato.ChavesField.Lista[I].Chave);
    Lc_Field := OrdemContrato.Contrato.ChavesField.Lista[I].Campo;
    Lc_valor := Qry.FieldByName(Lc_Field).AsString;
    Lc_Posicao := Pos(Lc_Chave,Lc_Conteudo);
    if Lc_Posicao > 0 then
    Begin
      Lc_Conteudo := StringReplace(Lc_Conteudo,Lc_Chave,Lc_valor,[rfReplaceAll, rfIgnoreCase]);
    End;
  End;
  OrdemContrato.Registro.Conteudo := Lc_Conteudo;
end;

procedure TTasContractOrder.AtualizaDadosContrato;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    OrdemContrato.Contrato.Registro.Estabelecimento := GB_CODMHA;
    OrdemContrato.Contrato.Registro.Codigo := OrdemContrato.Registro.Contrato;
    OrdemContrato.Contrato.getbyId;
    Lc_Qry := OrdemContrato.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(OrdemContrato.Contrato.Registro.SqlComando);
      sql.Add('WHERE PED_CODIGO=:PED_CODIGO');
      ParamByName('PED_CODIGO').AsInteger := OrdemContrato.Registro.Ordem;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
      Begin
        AjustaChavesCampos(Lc_Qry);
      End;
    End;
  Finally
    OrdemContrato.FinalizaQuery(Lc_Qry);
  End;
end;

procedure TTasContractOrder.CriarVariaveis;
begin
  inherited;
  OrdemContrato := TControllerContractOrder.create(Self);
end;

procedure TTasContractOrder.Delete;
begin
  OrdemContrato.delete;
  Close;
end;

procedure TTasContractOrder.EditionControl;
begin
  inherited;

end;

procedure TTasContractOrder.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(OrdemContrato);
end;

procedure TTasContractOrder.ImagemBotao;
begin
  inherited;

end;


procedure TTasContractOrder.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    OrdemContrato.Registro.Ordem := Self.CodigoRegistro;
    OrdemContrato.getbyId;
  End;
  inherited;

end;

procedure TTasContractOrder.Insert;
Var
  Lc_Form : TSeaContract;
begin
  try
    Lc_Form := TSeaContract.create(nil);
    Lc_Form.Selecionar := True;
    Lc_Form.ShowModal;
    if Lc_Form.Selecionado then
    Begin
      E_Tittle.Text := Lc_Form.Contrato.Registro.Titulo;
      OrdemContrato.Registro.Contrato := Lc_Form.Contrato.Registro.Codigo;
      OrdemContrato.Registro.Titulo := Lc_Form.Contrato.Registro.Titulo;
      OrdemContrato.Registro.Conteudo := Lc_Form.Contrato.Registro.Conteudo;
      AtualizaDadosContrato;
    End;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TTasContractOrder.LimpaCampos;
begin

end;


procedure TTasContractOrder.PrintHTMLByIE(const url: string);
const
  OLECMDID_PRINT = $00000006;
  OLECMDEXECOPT_DONTPROMPTUSER = $00000002;
var
  ie, vaIn, vaOut: Variant;
begin
  ie := CreateOleObject('InternetExplorer.Application');
  ie.Navigate('file:\\c:\temp\teste.html');
  ie.Visible := True;
  ie.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);

end;

procedure TTasContractOrder.Save;
begin
  with OrdemContrato do
  Begin
    Registro.Titulo    := E_Tittle.Text;
    Registro.UltimaAlteracao := Now;
    E_Last_Update.Text := DateTimeToStr(Registro.UltimaAlteracao);
    salva;
  End;
  CodigoRegistro := OrdemContrato.Registro.Ordem;
  EditionState := 'B';
  EditionControl;
end;

procedure TTasContractOrder.ShowData;
begin
  if OrdemContrato.exist then
  Begin
    with OrdemContrato do
    Begin
      E_Tittle.Text := Registro.Titulo;
      E_Last_Update.Text := DateTimeToStr(Registro.UltimaAlteracao)
    End;
  End
  else
  Begin
    ShowNoData;
  End;
end;

procedure TTasContractOrder.ShowNoData;
begin
  E_Tittle.Text  := 'NENHUM CONTRATO GERADO';
      E_Last_Update.Text := DateTimeToStr(Now)
end;

procedure TTasContractOrder.SpeedButton1Click(Sender: TObject);
Var
  Lc_form : TTasHtmlEditor;
begin
  try
    Lc_form := TTasHtmlEditor.create(nil);
    Lc_form.Conteudo := OrdemContrato.Registro.Conteudo;
    Lc_form.ShowModal;
    OrdemContrato.Registro.Conteudo := Lc_form.Conteudo;
  finally
    FreeAndNil(Lc_form);
  end;
end;


function TTasContractOrder.ValidaInsert: boolean;
begin
  Result := True;
  if (E_Tittle.Text  <> 'NENHUM CONTRATO GERADO') then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'JÁ existe um contrato atribuído a este pedido.'+EOLN+
                   'Por questão de responsabilidade por favor exclua antes de inserir um novo.'+EOLN+
                   'Execute a instrução acima caso queira continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    result:=False;
    Exit;
  End;
end;

function TTasContractOrder.ValidateChange: boolean;
begin
  Result := True;
  if (E_Tittle.Text  = 'NENHUM CONTRATO GERADO') then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Não existe contrato gerado para este Pedido.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    result:=False;
    Exit;
  End;

end;

function TTasContractOrder.ValidateDelete: boolean;
begin
  Result := True;
  if (E_Tittle.Text  = 'NENHUM CONTRATO GERADO') then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Não existe contrato gerado para este Pedido.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    result:=False;
    Exit;
  End;

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

function TTasContractOrder.ValidateSave: Boolean;
begin
  result := True;
  if (E_Tittle.Text  = 'NENHUM CONTRATO GERADO') then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Não foi definido um contrato para este pedido'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    result:=False;
    Exit;
  End;

end;

end.
