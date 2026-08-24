unit Un_Baixa_Boleto;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, DB, STQuery, DBCtrls, StdCtrls, Mask, QEdit_Setes, Buttons, ComCtrls;

type
  TFr_Baixa_Boleto = class(TForm)
    Panel1: TPanel;
    E_Codigo_Baixa: TEdit;
    E_Descricao_Baixa: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    E_Valor_Pago: TEdit_Setes;
    Label24: TLabel;
    E_Dt_Pagto: TDateTimePicker;
    SB_Sai_Tarefa: TSpeedButton;
    SB_Faturar: TSpeedButton;
    procedure SB_Sai_TarefaClick(Sender: TObject);
    procedure SB_FaturarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure Pc_ProcessoBaixaManual;
  public
    { Public declarations }
    It_NossoNumero:String;
  end;

var
  Fr_Baixa_Boleto: TFr_Baixa_Boleto;

implementation

uses     Un_DM, RN_BoletoEletronico, RN_Financeiro, Un_Fc_Sored_Procedures, UN_Sistema, UN_MSG, Un_Regra_Negocio, RN_FormaPagto, ControllerHistoricoBancario, UN_Principal, env;
{$R *.dfm}

procedure TFr_Baixa_Boleto.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) and not ((ActiveControl is TDBMemo) OR (ActiveControl is TMemo) )then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

procedure TFr_Baixa_Boleto.FormShow(Sender: TObject);
begin
  E_Dt_Pagto.Date := Date;
end;

procedure TFr_Baixa_Boleto.Pc_ProcessoBaixaManual;
Var
  Lc_Qry : TSTQuery;
  Lc_Qry_Aux : TSTQuery;
  Lc_HistBancario : TControllerHistoricoBancario;
Begin
  Lc_HistBancario := TControllerHistoricoBancario.Create(Self);

  Lc_Qry_Aux := TSTQuery.Create(Self);
  Lc_Qry_Aux.Database := DM.IBD_Gestao;
  Lc_Qry_Aux.Transaction := DM.IB_Transacao;
  Lc_Qry_Aux.ForcedRefresh := True;

  Lc_Qry := TSTQuery.Create(Self);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT BLT_CODIGO,BLT_DATA,  BLT_CODCTB,BLT_CODQTC FROM TB_BOLETO_BANCARIO WHERE BLT_NOSSONUMERO=:BLT_NOSSONUMERO ');
    Active := false;
    ParamByName('BLT_NOSSONUMERO').AsString := It_NossoNumero;
    Active := True;
    FetchAll;
    Pc_ProcessoBaixaBoleto(Lc_Qry_Aux,
                           FieldByName('BLT_CODIGO').AsInteger,
                           E_Codigo_Baixa.Text,
                           E_Descricao_Baixa.Text);

    //Baixa no Financeiro
    Pc_ProcessoBaixaFinanceiro(StrToFloatDef(E_Valor_Pago.Text,0),
                               E_Dt_Pagto.DateTime,
                               FieldByName('BLT_CODQTC').AsInteger);
    //Lanca valor Recebido na conta corrente

    Pc_Movim_Financeiro(DM.IB_Transacao,
                        'I',
                        0,
                        FieldByName('BLT_CODCTB').AsInteger,
                        FieldByName('BLT_DATA').AsDateTime,
                        Lc_HistBancario.getIdByDescription('RECEBIMENTO BOLETO'),
                        0, //PC_CODPLC_C
                        0, //PC_CODPLC_D
                        StrToFloatDef(E_Valor_Pago.Text,0),
                        0,//      PC_VL_DEBITO :Real;
                        'RECEBIMENTO BOLETO ' + It_NossoNumero,//      PC_HISTORISCO : String;
                        'C', //      PC_TIPO : String;
                        FieldByName('BLT_CODQTC').AsInteger,
                        Gb_Cd_Usuario,
                        0,
                        FieldByName('BLT_DATA').AsDateTime,
                        It_NossoNumero,
                        'S',
                        'S',
                        Gb_CodMha,
                        Fc_PegaFormaPgto('BOLETO'));
  end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
  FreeAndNil(Lc_HistBancario);
end;

procedure TFr_Baixa_Boleto.SB_Sai_TarefaClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Baixa_Boleto.SB_FaturarClick(Sender: TObject);
Var
  Lc_Escolha : Integer;
begin
  Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                'Baixar o Boleto com os dados informados ?'+EOLN+
                                'Confirmar a Baixa ?',
                                ['Confirmar','Cancelar'],[bEscape,bNormal],mpConfirmacao,clBtnFace));
  if Lc_Escolha = 0 then
  Begin
    Pc_ProcessoBaixaManual;
    Close;
  End;
end;

end.
