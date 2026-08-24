unit Un_RL_ReportAssistencia;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportList, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportAssistencia = class(TRL_ReportList)
    Qr_Itens_ass: TSTQuery;
    Qr_Itens_assIAS_CODIGO: TIntegerField;
    Qr_Itens_assIAS_CODASS: TIntegerField;
    Qr_Itens_assIAS_ETAPA: TIntegerField;
    Qr_Itens_assIAS_DATA: TDateField;
    Qr_Itens_assIAS_DESCRITIVO: TMemoField;
    Qr_Itens_assIAS_DT_PREVISTA: TDateField;
    Qr_Itens_assIAS_VL_CLIENTE: TBCDField;
    Qr_Itens_assIAS_VL_CUSTO: TBCDField;
    Qr_Itens_assIAS_DT_REALIZADA: TDateField;
    Qr_Itens_assIAS_CODSIT: TIntegerField;
    Qr_Itens_assSIT_DESCRICAO: TStringField;
    Ds_Consulta: TDataSource;
    procedure IniciaVariaveis;Override;
  private
    { Private declarations }
  public
    { Public declarations }
    NumeroItens : Integer;
    Sequencia : Integer;
    CodigoAssistencia : Integer;
  end;

var
  RL_ReportAssistencia: TRL_ReportAssistencia;

implementation

{$R *.dfm}

{ TRL_ReportAssistencia }

procedure TRL_ReportAssistencia.IniciaVariaveis;
begin
  NumeroItens := 0;
  Sequencia := 0;
  with qr_Consulta do
  Begin
    Active := False;
    ParamByName('ASS_CODIGO').AsInteger := CodigoAssistencia;
    Active := True;
    First;
  End;

  //Itens do Pedido
  with Qr_Itens_ass do
  Begin
    Active := False;
    ParamByName('ASS_CODIGO').AsInteger := CodigoAssistencia;
    Active := True;
    FetchAll;
    First;
  End;
end;

end.
