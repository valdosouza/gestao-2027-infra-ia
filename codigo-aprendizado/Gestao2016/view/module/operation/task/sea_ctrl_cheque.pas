unit sea_ctrl_cheque;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerCheque, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls, base_frame_list, Un_Fm_ListaMultiEmpresa;

type
  TSeaCtrlCheque = class(TBaseSearch)
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label20: TLabel;
    Label13: TLabel;
    Lb_Total: TLabel;
    E_NR_Banco: TMaskEdit;
    E_Emitente: TMaskEdit;
    E_Numero: TMaskEdit;
    E_Valor: TMaskEdit;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    E_Cliente: TMaskEdit;
    RG_Destino: TRadioGroup;
    RG_Devolvido: TRadioGroup;
    cds_searchCHQ_DATA: TDateField;
    cds_searchCHQ_AGENCIA: TStringField;
    cds_searchCHQ_NR_BANCO: TIntegerField;
    cds_searchCHQ_NUMERO: TStringField;
    cds_searchCHQ_VALOR: TBCDField;
    cds_searchCHQ_VL_AMORT: TBCDField;
    cds_searchCHQ_CODIGO: TIntegerField;
    cds_searchCHQ_EMITENTE: TStringField;
    cds_searchCHQ_VL_SALDO: TBCDField;
    Fm_ListaMultiEmpresa: TFm_ListaMultiEmpresa;
    OperaesemLote1: TMenuItem;
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure OperaesemLote1Click(Sender: TObject);
  private
    procedure SomaValores;


    Function ValidaDepositarLote:Boolean;
    procedure OpenDepositLote;

    Function ValidaDEscontoLote:Boolean;
    procedure OpenDescontoLote;

  private
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure IniciaVariaveis;Override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;

  public
    Cheque : TControllerCheque;
  end;

var
  SeaCtrlCheque: TSeaCtrlCheque;

implementation

{$R *.dfm}

uses     un_sistema, Un_Regra_Negocio, env, reg_ctrl_cheque, dpt_ctrl_cheque, dct_ctrl_cheque, RI_MovimentoFinanceiro, un_msg;

{ TSeaCtrlCheque }

procedure TSeaCtrlCheque.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TSeaCtrlCheque.CriarVariaveis;
begin
  inherited;
  Cheque := TControllerCheque.create(self);
end;



procedure TSeaCtrlCheque.FinalizaVariaveis;
begin
  FreeAndNil(Cheque);
  inherited;
end;

procedure TSeaCtrlCheque.GetView;
begin
  inherited;
  openRegister(cds_searchCHQ_CODIGO.AsInteger);
end;

procedure TSeaCtrlCheque.IniciaVariaveis;
begin
  inherited;
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
  ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
  Fm_ListaMultiEmpresa.Listar('');
  Fm_ListaMultiEmpresa.Dblcb_Lista.KeyValue := Gb_CodMha;
end;

procedure TSeaCtrlCheque.OpenDepositLote;
Var
  Lc_Form : TDptCtrlCheque;
begin
  Lc_Form := TDptCtrlCheque.Create(Self);
  Try
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TSeaCtrlCheque.OpenDescontoLote;
Var
  Lc_Form : TDctCtrlCheque;
begin
  Lc_Form := TDctCtrlCheque.Create(Self);
  Lc_Form.cds_search := self.cds_search;
  Try
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TSeaCtrlCheque.openRegister(pCodigo: Integer);
var
  Lc_form : TRegCtrlCheque;
begin
  Lc_form := TRegCtrlCheque.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaCtrlCheque.OperaesemLote1Click(Sender: TObject);
Var
  Lc_Escolha : Integer;
Begin
  if Fc_VerificaCaixaAberto(True) then
  Begin
    Lc_Escolha:=(MensagemPadrao(TITULO_INFORMACAO,
                                'Escolha o Tipo de Operção em Lote',
                                ['DEPOSITAR','DESCONTAR','CANCELAR'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
    case Lc_Escolha of
      0:if ValidaDepositarLote then OpenDepositLote;
      1:if ValidaDEscontoLote then OpenDescontoLote;
    end;
  End;
end;

procedure TSeaCtrlCheque.SB_BuscarClick(Sender: TObject);
begin
  inherited;
  SomaValores;
end;

procedure TSeaCtrlCheque.Search;
var
  i: Integer;
begin
  Cheque.Clear;
  Cheque.Parametros.Periodo := ChBx_Periodo.Checked;
  Cheque.Parametros.DataInicial := E_Data_Ini.Date;
  Cheque.Parametros.DataFinal   := E_Data_Fim.Date;
  Cheque.Parametros.FieldName.NumeroBanco := StrToIntDef(E_NR_Banco.Text,0);
  Cheque.Parametros.FieldName.Emitente := E_Emitente.Text;
  Cheque.Parametros.FieldName.Numero := E_Numero.Text;
  Cheque.Parametros.FieldName.Valor := StrToFloatDef(E_Valor.Text,0);
  Cheque.Parametros.FieldName.NomeCliente := E_Cliente.Text;
  case RG_Destino.ItemIndex of
    0: Cheque.Parametros.FieldName.Destino := 'N';
    1: Cheque.Parametros.FieldName.Destino := 'S';
    2: Cheque.Parametros.FieldName.Destino := 'T';
  end;

  case RG_Devolvido.ItemIndex of
    0: Cheque.Parametros.FieldName.Devolvido := 'N';
    1: Cheque.Parametros.FieldName.Devolvido := 'S';
    2: Cheque.Parametros.FieldName.Devolvido := 'T';
  end;
  Cheque.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  for i := 0 to Pred(Cheque.Lista.Count) do
    cds_search.AppendRecord([
           Cheque.Lista[I].Data,
           Cheque.Lista[I].Agencia,
           Cheque.Lista[I].NumeroBanco,
           Cheque.Lista[I].Numero,
           Cheque.Lista[I].Valor,
           Cheque.Lista[I].ValorAmortizado,
           Cheque.Lista[I].Codigo,
           Cheque.Lista[I].Emitente,
           Cheque.Lista[I].Saldo
          ]);

end;

procedure TSeaCtrlCheque.SetRegister;
begin
  openRegister(0);
end;

procedure TSeaCtrlCheque.SomaValores;
Var
  Lc_Soma : Real;
begin
  Lc_Soma := 0;
  cds_search.First;
  while not cds_search.Eof do
  begin
    Lc_Soma := Lc_Soma +  cds_search.FIELDBYNAME('CHQ_VALOR').AsCurrency;
    cds_search.Next;
  end;
  cds_search.First;
  Lb_Total.Caption :=FormatFloat('#,##0.00',Lc_Soma);
end;

function TSeaCtrlCheque.ValidaDepositarLote: Boolean;
begin
  Result := True;
  if not validateGetView then
  Begin
    Result := false;
    exit;
  end;
end;


function TSeaCtrlCheque.ValidaDEscontoLote: Boolean;
begin
  Result := True;
  if not validateGetView then
  Begin
    Result := false;
    exit;
  end;

end;

end.

