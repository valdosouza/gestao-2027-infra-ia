unit un_thread_generator;

interface

uses
      Classes, SysUtils, Vcl.Forms, UnFunctions, System.Threading, Winapi.Windows, StackTrace, ControllerEstabelecimento;

type
  TThreadGenerator = class(TThread)
  private

  protected
    //procedure TerminatedSet; override;
  public
    constructor Create();
    destructor Destroy; override;
    procedure stop;
    procedure execute;override;
  end;


implementation

{ TTrata_Excecao }

uses     UN_Sistema;

constructor TThreadGenerator.Create;
begin
  inherited Create (True);
  FreeOnTerminate := True;
end;

destructor TThreadGenerator.Destroy;
begin
  inherited;
end;

procedure TThreadGenerator.execute;
Var
  LcSequencia : Integer;
begin
  try
    if not Terminated then
    Begin
      LcSequencia := GetMaxCodigo('TB_LOG_OPERACAO','LOG_CODIGO');
      AjustaGenerators('GN_LOG_OPERACAO',LcSequencia);
    End;
    if not Terminated then
    Begin
      LcSequencia := GetMaxCodigo('TB_FINANCEIRO','FIN_CODIGO');
      AjustaGenerators('GN_FINANCEIRO',LcSequencia);
    End;
    if not Terminated then
    Begin
      LcSequencia := GetMaxCodigo('tb_MOVIM_financeiro','MVF_CODIGO');
      AjustaGenerators('GN_MOVIM_FINANCEIRO',LcSequencia);
    end;
    if not Terminated then
    Begin
      LcSequencia := GetMaxCodigo('TB_ITENS_ICMS','ICM_CODIGO');
      AjustaGenerators('GN_ITENS_ICMS',LcSequencia);
    end;
    if not Terminated then
    Begin
      LcSequencia := GetMaxCodigo('TB_ITENS_IPI','IPI_CODIGO');
      AjustaGenerators('GN_ITENS_IPI',LcSequencia);
    end;
    if not Terminated then
    Begin
      LcSequencia := GetMaxCodigo('TB_ITENS_CFS','CFS_CODIGO');
      AjustaGenerators('GN_ITENS_CFS',LcSequencia);
    end;
    if not Terminated then
    Begin
      LcSequencia := GetMaxCodigo('TB_ITENS_PIS','PIS_CODIGO');
      AjustaGenerators('GN_ITENS_PIS',LcSequencia);
    end;
    if not Terminated then
    Begin
      LcSequencia := GetMaxCodigo('TB_ITENS_II','IIP_CODIGO');
      AjustaGenerators('GN_ITENS_II',LcSequencia);
    end;
    if not Terminated then
    Begin
      LcSequencia := GetMaxCodigo('TB_ITENS_ISSQN','ISS_CODIGO');
      AjustaGenerators('GN_ITENS_ISSQN',LcSequencia);
    end;
    if not Terminated then
    Begin
      LcSequencia := GetMaxCodigo('TB_CTRL_ESTOQUE','CET_CODIGO');
      AjustaGenerators('GN_CTRL_ESTOQUE',LcSequencia);
    end;
    if not Terminated then
    Begin
      LcSequencia := GetMaxCodigo('TB_GRUPOS','GRP_CODIGO');
      AjustaGenerators('GN_GRUPO',LcSequencia);
    end;
    if not Terminated then
    Begin
      LcSequencia := GetMaxCodigo('TB_SUBGRUPOS','SBG_CODIGO');
      AjustaGenerators('GN_SUBGRUPO',LcSequencia);
    end;
    if not Terminated then
    Begin
      LcSequencia := GetMaxCodigo('TB_EMBALAGEM','EMB_CODIGO');
      AjustaGenerators('GN_EMBALAGEM',LcSequencia);
    end;
    if not Terminated then
    Begin
      LcSequencia := GetMaxCodigo('TB_MARCA_PRODUTO','MRC_CODIGO');
      AjustaGenerators('GN_MARCA',LcSequencia);
    end;
    if not Terminated then
    Begin
      LcSequencia := GetMaxCodigo('TB_MEDIDA','MED_CODIGO');
      AjustaGenerators('GN_MEDIDA',LcSequencia);

    end;
    if not Terminated then
    Begin
      LcSequencia := GetMaxCodigo('TB_PRODUTO','PRO_CODIGO');
      AjustaGenerators('GN_PRODUTO',LcSequencia);

    end;
    if not Terminated then
    Begin
      if existTabela('TB_CRP_ITENS') then
      Begin
        LcSequencia := GetMaxCodigo('TB_CRP_ITENS','CPI_CODIGO');
        AjustaGenerators('GN_CRP_ITENS',LcSequencia);
      end;
    End;
  finally
    Terminate;
  end;
end;

procedure TThreadGenerator.stop;
begin
  // define a flag Terminated como True para sinalizar a interrupção da Thread
  Terminate;

  // aguarda a finalizção da Thread antes de liberar a mem�ria dos objetos criados
  WaitFor;
end;


end.
