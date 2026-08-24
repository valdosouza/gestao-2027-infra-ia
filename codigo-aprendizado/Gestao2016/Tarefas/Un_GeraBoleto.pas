unit Un_GeraBoleto;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ComCtrls, DBCtrls, DB, STQuery, Buttons, Grids, Mask, ACBrBase, ACBrBoleto, ACBrUtil, ACBrBoletoFCFortesFr, QEdit_Setes, ControllerBoletoBancario, ControllerFinanceiro;

type
  TFr_GeraBoleto = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label8: TLabel;
    MM_Instrucoes: TMemo;
    Pnl_Botao: TPanel;
    Sb_Sair_0: TSpeedButton;
    Sb_BoletoEletronico: TSpeedButton;
    RG_Aceite: TRadioGroup;
    Label13: TLabel;
    Cb_Protesto: TComboBox;
    Label15: TLabel;
    E_VL_Tarifa: TEdit_Setes;
    GroupBox1: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    E_Tx_Multa: TEdit_Setes;
    E_Tx_Juros: TEdit_Setes;
    E_Tx_Mora: TEdit_Setes;
    Label3: TLabel;
    E_Tx_Descontos: TEdit_Setes;
    Qr_Acao: TSTQuery;
    Qr_Boleto: TSTQuery;
    Sb_Gravar: TSpeedButton;
    ACBrBoleto1: TACBrBoleto;
    Qr_BoletoFIN_CODIGO: TIntegerField;
    Qr_BoletoBLT_DT_VENCIMENTO: TDateField;
    Qr_BoletoBLT_DATA: TDateField;
    Qr_BoletoBLT_NUMERO: TStringField;
    Qr_BoletoBLT_NOSSONUMERO: TStringField;
    Qr_BoletoEPD_SIGLA: TStringField;
    Qr_BoletoBLT_ACEITE: TStringField;
    Qr_BoletoBLT_DT_PROCESSAMENTO: TDateField;
    Qr_BoletoCTR_NUMERO: TStringField;
    Qr_BoletoEMP_FANTASIA: TStringField;
    Qr_BoletoEMP_CNPJ: TStringField;
    Qr_BoletoEND_ENDER: TStringField;
    Qr_BoletoEND_NUMERO: TStringField;
    Qr_BoletoEND_BAIRRO: TStringField;
    Qr_BoletoCDD_DESCRICAO: TStringField;
    Qr_BoletoUFE_SIGLA: TStringField;
    Qr_BoletoEND_CEP: TStringField;
    Qr_BoletoBLE_LOCALPAG: TStringField;
    Qr_BoletoBLT_VALOR: TBCDField;
    Qr_BoletoBLT_VL_MORA: TBCDField;
    Qr_BoletoBLT_VL_DESCONTO: TBCDField;
    Qr_BoletoBLT_TX_MULTA: TBCDField;
    Qr_BoletoBLE_INSTR_1: TStringField;
    Qr_BoletoBLE_INSTR_2: TStringField;
    Qr_BoletoBLT_INSTRUCOES: TMemoField;
    Qr_BoletoBLT_DT_PROTESTO: TDateField;
    E_Dt_Vencimento: TDateTimePicker;
    Label4: TLabel;
    E_VL_MORA_MIN: TEdit_Setes;
    E_Dt_Venc_Ate: TDateTimePicker;
    ChBx_Desc_Ate: TCheckBox;
    Chbx_Agrupar: TCheckBox;
    ChBx_Dt_Vencimento: TCheckBox;
    DBLCB_CarteiraCobranca: TDBLookupComboBox;
    Label_1: TLabel;
    E_Dias_Protesto: TEdit_Setes;
    Label1: TLabel;
    Label5: TLabel;
    CB_negativacao: TComboBox;
    E_Dias_Negativacao: TEdit_Setes;
    procedure Sb_BoletoEletronicoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure Sb_GravarClick(Sender: TObject);
    procedure Chbx_AgruparClick(Sender: TObject);
    procedure DBLCB_CarteiraCobrancaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Financeiro : TControllerFinanceiro;
  public
    { Public declarations }
    CodigoQuitacao : Integer;
    It_Nr_Registros : Integer;
    It_StrGridDuplicata : TStringGrid;
    BoletoBancario : TControllerBoletoBancario;
    procedure Pc_Formatatela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_AtivarTabelas;

    function Fc_ValidaGravaBoleto():Boolean;
    procedure Pc_SalvaBoleto(Pc_Indice,Pc_CodigoQuitacao:Integer;ValorBoleto:Real);
    procedure Pc_GravaBoletoAgrupado;
    procedure Pc_GravaBoletoIndividual;

    function Fc_VerificaExisteBoleto(Fc_Cd_Financeiro:Integer):Boolean;
    procedure Pc_ImagemBotao;
    procedure Pc_AtualizaVencimentosFinanceiro;
    end;

var
  Fr_GeraBoleto: TFr_GeraBoleto;

implementation

uses     Un_Regra_Negocio, UN_Sistema, Un_DM, UN_MSG, sea_electronic_slip, Un_Funcoes, RN_FormaPagto, Un_Principal, env;
{$R *.dfm}

procedure TFr_GeraBoleto.Pc_Formatatela;
Var
  Lc_I:Integer;
Begin
end;

procedure TFr_GeraBoleto.Pc_IniciaVariaveis;
Begin
  CodigoQuitacao := 0;
  DBLCB_CarteiraCobranca.KeyValue := DM.Qr_Carteiras.FieldByName('CTR_CODIGO').AsInteger;
  E_Dt_Vencimento.Date := Date;
  E_Dt_Venc_Ate.Date := Date;
end;

procedure TFr_GeraBoleto.Pc_AtivarTabelas;
Begin
  with DM.Qr_Carteiras do
    Begin
    Active := False;
    ParamByName('CTB_CODMHA').AsInteger := Gb_CodMha;
    Active := True;
    end;
end;
function TFr_GeraBoleto.Fc_ValidaGravaBoleto():Boolean;
Begin
  Result := True;


end;


function TFr_GeraBoleto.Fc_VerificaExisteBoleto(Fc_Cd_Financeiro:Integer):Boolean;
Begin
  Result := True;
  Qr_Boleto.Active := False;
  Qr_Boleto.ParamByName('FIN_CODIGO').AsInteger := Fc_Cd_Financeiro;
  Qr_Boleto.Active := True;
  Qr_Boleto.FetchAll;
  Result := (Qr_Boleto.RecordCount > 0);

end;

procedure TFr_GeraBoleto.Pc_SalvaBoleto(Pc_Indice,Pc_CodigoQuitacao:Integer;ValorBoleto:Real);
Begin
  BoletoBancario.clear;
  with BoletoBancario.Registro,It_StrGridDuplicata do
  Begin
    Codigo := 0;
    CodigoEmpresa := StrtoIntDef(cells[8,Pc_Indice],0);
    if Trim(cells[5,Pc_Indice])<> '' then
      Numero := cells[5,Pc_Indice] + '-' + cells[24,Pc_Indice]
    else
      Numero := cells[4,Pc_Indice] + '-' + cells[24,Pc_Indice];

    Numero := IntToStr( Pc_CodigoQuitacao );
    Data := Date;
    CodigoContaCorrente := DM.Qr_Carteiras.FieldByName('CTB_CODIGO').AsInteger;
    TaxaDesconto := StrtoFloatdef(E_Tx_Descontos.Text,0);
    Baixado := 'N';
    Valor := ValorBoleto;
    CodigoQuitacao := Pc_CodigoQuitacao;
    TaxaJuros := StrToFloatDef(E_Tx_Juros.Text,0);
    TaxaMora := StrToFloatDef(E_Tx_Mora.Text,0);
    ValorMora := StrToFloatDef(E_VL_MORA_MIN.Text,0);
    if (StrtoFloatdef(E_Tx_Descontos.Text,0) > 0) then
    begin
      ValorDesconto := (StrToFloatDef(cells[11,Pc_Indice],0) * StrtoFloatdef(E_Tx_Descontos.Text,0))/100;
      if ChBx_Desc_Ate.Checked then
        DataDescVencimento :=E_Dt_Venc_Ate.Date;
    end;
    TaxaMulta := StrToFloatDef(E_Tx_Multa.Text,0);
    ValorTarifa := StrToFloatDef(E_VL_Tarifa.Text,0);
    CodigoBoletoEletronica := DM.Qr_Carteiras.FieldByName('BLE_CODIGO').AsInteger;
    if ChBx_Dt_Vencimento.Checked then
      DataVencimento := E_Dt_Vencimento.Date
    else
      DataVencimento := StrToDateDef(cells[7,Pc_Indice],Date);

    DataProcessamento := Date;
    IF (RG_Aceite.ItemIndex = 0) then
      Aceite := 'S'
    else
      Aceite := 'N';
    Parcela := cells[24,Pc_Indice];
    Instrucao := MM_Instrucoes.Text;
    CodigoRemessa := 0;
    CodigoRetorno := 0;
    Status := '0';
    NossoNumero := IntToStr(Pc_CodigoQuitacao);
    MensagemRetorno := 'Em Aberto';
    NumeroRemessa := 0;
    case Cb_Protesto.ItemIndex of
      1..2 :Begin
              DiasProtesto := StrtoIntDef(E_Dias_Protesto.Text, 3);
              DataProtesto := DataVencimento + StrToIntDef(E_Dias_Protesto.Text,0);
              case Cb_Protesto.ItemIndex of
                1:TipoDiaProtesto := 'C';
                2:TipoDiaProtesto := 'U';
              end;
          end;
      else
        Begin
          DiasProtesto := 0;
          TipoDiaProtesto := 'N';
        End;
    end;
    if CB_negativacao.Text = SIM then
    Begin
      DataNegativacao := DataVencimento + StrtoIntDef(E_Dias_Negativacao.Text, 3);
      DiasNegativacao := StrtoIntDef(E_Dias_Negativacao.Text, 3);
    End
    else
    Begin
      DataNegativacao := 0;
      DiasNegativacao := 0;
    End;

  end;
  BoletoBancario.insere;
End;

procedure TFr_GeraBoleto.Pc_GravaBoletoAgrupado;
Var
  Lc_I        : Integer;
  Lc_Vl_total : Real;
Begin
  with It_StrGridDuplicata do
  Begin
    //Comeca a Gravar os Boletos a partir da Vetor de controle Financeiro
    Lc_Vl_total := 0 ;
    CodigoQuitacao := Fc_GeraCod_BAixa;
    For Lc_I := 1 to RowCount -1 do
    Begin
      Lc_Vl_total := Lc_Vl_total +  StrToFloatDef(cells[11,Lc_I],0);
      //Atualiza Financeiro
      Financeiro.Clear;
      Financeiro.Registro.codigo := StrtoIntDef(cells[3,Lc_I],0);
      Financeiro.Registro.codigoQuitacao := CodigoQuitacao;
      Financeiro.Registro.FormaPagamento := Fc_PegaFormaPgto('BOLETO');
      Financeiro.Destinar;
    end;
    Pc_SalvaBoleto(1,CodigoQuitacao,Lc_Vl_total);
  end;
end;


procedure TFr_GeraBoleto.Pc_GravaBoletoIndividual;
Var
  Lc_I        : Integer;
  Lc_Cd_Boleto : Integer;
  Lc_ValorBoleto : Real;
Begin
  with It_StrGridDuplicata do
  Begin
    //Comeca a Gravar os Boletos a partir da Vetor de controle Financeiro
    For Lc_I := 1 to RowCount -1 do
    Begin
      CodigoQuitacao := Fc_GeraCod_BAixa;
      Lc_ValorBoleto := StrToFloatDef(cells[11,Lc_I],0);
      Pc_SalvaBoleto(Lc_I,CodigoQuitacao,Lc_ValorBoleto);
      //Atualiza Financeiro
      Financeiro.Clear;
      Financeiro.Registro.codigo := StrtoIntDef(cells[3,Lc_I],0);
      Financeiro.Registro.codigoQuitacao := CodigoQuitacao;
      Financeiro.Registro.FormaPagamento := Fc_PegaFormaPgto('BOLETO');
      Financeiro.Destinar;
    end;
  end;
end;


procedure TFr_GeraBoleto.Sb_BoletoEletronicoClick(Sender: TObject);
Var
  Lc_Form : TSeaElectronicSlip;
begin
  Lc_Form := TSeaElectronicSlip.Create(Self);
  Try
    Lc_Form.ShowModal;
  Finally
    DM.Qr_Carteiras.Active := False;
    DM.Qr_Carteiras.Active := True;
    DBLCB_CarteiraCobranca.KeyValue := Lc_Form.cds_searchcodigo.AsInteger;
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_GeraBoleto.FormCreate(Sender: TObject);
begin
  BoletoBancario := TControllerBoletoBancario.create(Self);
  Financeiro := TControllerFinanceiro.create(Self);
end;

procedure TFr_GeraBoleto.FormShow(Sender: TObject);
begin
  Pc_Formatatela;
  Pc_ImagemBotao;
  Pc_AtivarTabelas;
  Pc_IniciaVariaveis;
end;

procedure TFr_GeraBoleto.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    Sb_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_GeraBoleto.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_GeraBoleto.Pc_AtualizaVencimentosFinanceiro;
Var
  Lc_Qry:TSTQuery;
  Lc_I : Integer;
Begin
  if ChBx_Dt_Vencimento.Checked then
  Begin
    Lc_Qry := TSTQuery.Create(Fr_GeraBoleto);
    with Lc_Qry,It_StrGridDuplicata do
    Begin
      DAtabase := DM.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      ForcedRefresh := True;
      Active := False;
      sql.Clear;
      sql.Add('UPDATE TB_FINANCEIRO SET '+
              'FIN_DT_VENCIMENTO =:FIN_DT_VENCIMENTO '+
              'WHERE (FIN_CODIGO =:FIN_CODIGO) ');
      For Lc_I := 1 to RowCount-1 do
      Begin
        Active := False;
        ParamByName('FIN_DT_VENCIMENTO').AsDate := E_Dt_Vencimento.Date;
        ParamByName('FIN_CODIGO').AsString := It_StrGridDuplicata.Cells[3,Lc_I];
        ExecSQL;
        if Transaction.InTransaction then Transaction.CommitRetaining;
      end;
    end;
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
  end;
end;

procedure TFr_GeraBoleto.Sb_GravarClick(Sender: TObject);
begin
  if Fc_ValidaGravaBoleto then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja gerar Boletos com estas dados informados.' + EOLN + EOLN +
                       'Confirmar a confirmação ?',
                       [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
      Pc_AtualizaVencimentosFinanceiro;
      //Efetivamente grava os boletos;
      if Chbx_Agrupar.Checked then
        Pc_GravaBoletoAgrupado
      else
        Pc_GravaBoletoIndividual;
      Close;
    end;
  end;
end;

procedure TFr_GeraBoleto.Chbx_AgruparClick(Sender: TObject);
begin
  if Chbx_Agrupar.Checked then
  Begin
    ChBx_Dt_Vencimento.Checked := True;
    ChBx_Dt_Vencimento.Enabled := false;
  end
  else
  Begin
    ChBx_Dt_Vencimento.Checked := True;
    ChBx_Dt_Vencimento.Enabled := True;
  end;
end;

procedure TFr_GeraBoleto.DBLCB_CarteiraCobrancaClick(Sender: TObject);
Var
  I:Integer;
begin
  if (Trim(DBLCB_CarteiraCobranca.Text)<> '') then
  Begin
    MM_Instrucoes.Text := DM.Qr_Carteiras.FieldByName('BLE_INSTRUCOES').AsString;
    E_Tx_Descontos.Text := FloatToStrF(DM.Qr_Carteiras.FieldByName('BLE_TX_DESCONTO').AsCurrency,ffFixed,10,2);
    E_Tx_Juros.Text := FloatToStrF(DM.Qr_Carteiras.FieldByName('BLE_TX_JUROS').AsFloat,ffFixed,10,2);
    E_Tx_Mora.Text := FloatToStrF(DM.Qr_Carteiras.FieldByName('BLE_TX_MORA').AsCurrency,ffFixed,10,2);
    E_Tx_Multa.Text := FloatToStrF(DM.Qr_Carteiras.FieldByName('BLE_TX_MULTA').AsCurrency,ffFixed,10,2);
    E_VL_MORA_MIN.Text := FloatToStrF(DM.Qr_Carteiras.FieldByName('BLE_VL_MORA_MIN').AsCurrency,ffFixed,10,2);
    if (DM.Qr_Carteiras.FieldByName('BLE_ACEITE').AsString = 'S') then
      RG_Aceite.ItemIndex := 0
    else
      RG_Aceite.ItemIndex := 1;
    Cb_Protesto.ItemIndex := StrToIntDef(DM.Qr_Carteiras.FieldByName('BLE_PROTESTO').AsString,0);
    E_VL_Tarifa.Text := FloatToStrF(DM.Qr_Carteiras.FieldByName('BLE_VL_TARIFA').AsCurrency,ffFixed,10,2);
    E_Dias_Protesto.Text := DM.Qr_Carteiras.FieldByName('BLE_DIAS_PROTESTO').AsString;

    for I := 0 to (Cb_Negativacao.Items.Count - 1) do
    Begin
      if (Cb_Negativacao.Items[I] = DM.Qr_Carteiras.FieldByName('BLE_NEGATIVACAO').AsString  ) then
        Cb_Negativacao.ItemIndex := I;
    End;
    E_Dias_Negativacao.Text := DM.Qr_Carteiras.FieldByName('BLE_DIAS_NEGATIVACAO').AsString;
  end;
end;

end.
