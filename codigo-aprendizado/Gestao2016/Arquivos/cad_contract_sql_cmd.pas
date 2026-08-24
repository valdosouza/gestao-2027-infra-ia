unit cad_contract_sql_cmd;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, ControllerContract, STQuery;

type
  TCadContractSqlCmd = class(TFr_Base)
    Panel1: TPanel;
    Panel2: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    E_SQL: TMemo;
    Label1: TLabel;
    procedure SB_Sair_0Click(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    function ValidaConfirma:Boolean;
    function ValidaComandoSQL:Boolean;
    procedure Confirma;
  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure ImagemBotao;Override;

  public
    { Public declarations }
    Contrato : TControllerContract;
  end;

var
  CadContractSqlCmd: TCadContractSqlCmd;

implementation

{$R *.dfm}

uses     Un_Msg, env;
procedure TCadContractSqlCmd.Confirma;
begin
  contrato.Registro.SqlComando := trim(E_SQL.Text);
  Close;
end;

procedure TCadContractSqlCmd.CriarVariaveis;
begin
  inherited;
  Contrato := TControllerContract.create(Self);
end;

procedure TCadContractSqlCmd.FinalizaVariaveis;
begin
  inherited;
  //FreeAndNil(Contrato); quando preciso do retorno em outra tela não pode usar;
end;

procedure TCadContractSqlCmd.ImagemBotao;
begin
  CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
  CarregaImagemBotao(SB_Sair_0,'SAIR');
end;

procedure TCadContractSqlCmd.IniciaVariaveis;
begin
  inherited;

end;

procedure TCadContractSqlCmd.SB_ConfirmarClick(Sender: TObject);
begin
  if ValidaConfirma then
    Confirma;
end;

procedure TCadContractSqlCmd.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

function TCadContractSqlCmd.ValidaComandoSQL: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  REsult := False;
  try
    try
      Lc_Qry := Contrato.GeraQuery;
      Lc_Qry.SQL.Add(E_SQL.Text);
      //Lc_Qry.Prepare;
      Lc_Qry.Active := True;
      Result := True;
    Except
      on E: Exception do
        Result := False;
    end;
  finally
    Contrato.FinalizaQuery(Lc_Qry);
  end;
end;

function TCadContractSqlCmd.ValidaConfirma: Boolean;
begin
  REsult := True;
  if (trim(E_SQL.text) = '') then
  Begin
    MensagemPadrao(ATENCAO,
                   'Comando SQL não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if E_SQL.CanFocus then E_SQL.SetFocus;
    Exit;
  End;

  if not ValidaComandoSQL then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Comando SQL inválido.'+EOLN+
                   '� necessário ter conhecimento técnico para isso.'+EOLN+
                   'Solicite suporte ao desenvolvedor.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if E_SQL.CanFocus then E_SQL.SetFocus;
    Exit;
  End;


end;

end.
