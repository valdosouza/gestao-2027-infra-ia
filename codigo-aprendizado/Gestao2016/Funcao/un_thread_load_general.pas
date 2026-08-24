unit un_thread_load_general;

interface

uses
      Classes, SysUtils, Vcl.Forms, UnFunctions, System.Threading, Winapi.Windows, StackTrace, ControllerEstabelecimento, STQuery, ControllerBase;

type
  TThreadLoadGeneral = class(TThread)
  private
    procedure Pc_UpdateAtivaCliente;
  protected

  public
    constructor Create();
    destructor Destroy; override;
    procedure execute;override;
  end;


implementation

{ TThreadLoadGeneral }

uses     UN_Sistema, RN_NotaFiscalEletronica3X, UN_Principal, env;
constructor TThreadLoadGeneral.Create;
begin
  inherited Create (True);
  FreeOnTerminate := True;
end;

destructor TThreadLoadGeneral.Destroy;
begin

  inherited;
end;

procedure TThreadLoadGeneral.execute;
begin
  inherited;
  if not Terminated then
    TThread.Synchronize(nil,
      procedure
      begin
        if not Terminated then
          Pc_VerificaDesativacaoProdutos;
        if not Terminated then
          Pc_Define_CasasDecimais;
        if not Terminated then
          Pc_UpdateAtivaCliente;
        if not Terminated then
          Pc_Excluir_Orcamentos;
        if not Terminated then
          Pc_CarregaDadosEmitente(true);
      end);
  if not Terminated then
  Begin
    TThread.Synchronize(nil,
        procedure
        begin
          fr_Principal.SB_Status.Panels[8].Text := 'Validade do Certificado Digital: ';
          //Nfe.Configuracoes.Certificados.VerificarValidade
          IF ( Trim(fr_Principal.Nfe.Configuracoes.Certificados.NumeroSerie) <> '' ) or
             ( (fr_Principal.Nfe.Configuracoes.Certificados.ArquivoPFX<> '') and FileExists(fr_Principal.Nfe.Configuracoes.Certificados.ArquivoPFX) ) then
          Begin
            Try
              fr_Principal.SB_Status.Panels[8].Text := 'Validade do Certificado Digital: ' + DateToStr(fr_Principal.Nfe.SSL.CertDataVenc);
            Except
              fr_Principal.SB_Status.Panels[8].Text := 'Validade do Certificado Digital: ';
            end;
          end;
          fr_Principal.SB_Status.update;
        end
      );
  End;
  Terminate;
end;

procedure TThreadLoadGeneral.Pc_UpdateAtivaCliente;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(' update tb_empresa set emp_ativa = ''S'' where emp_ativa is null ');
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;



end.
