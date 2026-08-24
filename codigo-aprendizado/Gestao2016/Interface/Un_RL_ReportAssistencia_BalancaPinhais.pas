unit Un_RL_ReportAssistencia_BalancaPinhais;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportAssistencia, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls;

type
  TRL_ReportAssistencia_BalancaPinhais = class(TRL_ReportAssistencia)
    QRBand1: TQRBand;
    Label1: TLabel;
    QRMemo13: TQRMemo;
    QRMemo2: TQRMemo;
    QRMemo1: TQRMemo;
    QRMemo9: TQRMemo;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    Lb_CPFCNPJ: TQRLabel;
    Lb_Cli_Endereco: TQRLabel;
    Lb_Cli_Nome: TQRLabel;
    Lb_Cli_bairro: TQRLabel;
    Lb_Cli_Cnpj: TQRLabel;
    Lb_Cli_cep: TQRLabel;
    Lb_Cli_Cidade: TQRLabel;
    Lb_Cli_IncEst: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    Lb_Cli_FoneC: TQRLabel;
    QRLabel13: TQRLabel;
    Lb_Cli_Fax: TQRLabel;
    QRLabel34: TQRLabel;
    Lb_Cli_Celular: TQRLabel;
    QRLabel36: TQRLabel;
    Lb_Cli_Email: TQRLabel;
    QRLabel16: TQRLabel;
    Lb_Cli_Fantasia: TQRLabel;
    QRLabel7: TQRLabel;
    QRMemo15: TQRMemo;
    QRMemo16: TQRMemo;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel23: TQRLabel;
    Lb_Cli_UF: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    Bd_DetalheStr: TQRStringsBand;
    QRMemo20: TQRMemo;
    QRMemo22: TQRMemo;
    QRMemo21: TQRMemo;
    QRMemo19: TQRMemo;
    QRMemo17: TQRMemo;
    Lb_DescricaoProduto: TQRLabel;
    E_DT_Prevista: TQRLabel;
    E_DT_Realizada: TQRLabel;
    Lb_Codigo: TQRLabel;
    E_Data: TQRLabel;
    E_Obs: TQRMemo;
    BndRodape: TQRBand;
    QRMemo11: TQRMemo;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    Lb_Data: TQRLabel;
    QRMemo3: TQRMemo;
    QRLabel6: TQRLabel;
    QRMemo4: TQRMemo;
    E_Hora: TQRLabel;
    Qr_Itens_assIAS_HOUR: TStringField;
    procedure IniciaVariaveis;Override;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BndRodapeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    procedure PreencheCliente;
    Procedure PC_VAlidaCampos(Pc_Print : Boolean);
    Procedure PreencheCampos;
    procedure Rodape;
  public
    { Public declarations }


  end;

var
  RL_ReportAssistencia_BalancaPinhais: TRL_ReportAssistencia_BalancaPinhais;

implementation

{$R *.dfm}

uses     UN_Sistema, Un_DM, Un_Funcoes;


procedure TRL_ReportAssistencia_BalancaPinhais.Bd_DetalheStrBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if Not Qr_Itens_ass.Eof then
    Begin
    NumeroItens := NumeroItens +1;
    Sequencia := Sequencia + 1;
    pc_ValidaCampos(True);
    PreencheCAmpos;
    Qr_Itens_ass.Next;
    end
  else
    pc_ValidaCampos(False);
end;

Procedure TRL_ReportAssistencia_BalancaPinhais.PreencheCampos;
Var
  Lc_Texto: TMemoryStream;
begin
  Lc_Texto := TMemoryStream.Create;
  Lc_Texto.LoadFromStream(Qr_Itens_ass.CreateBlobStream(Qr_Itens_assIAS_DESCRITIVO, bmRead));
  E_OBS.Lines.LoadFromStream(lC_Texto);
  E_OBS.AutoStretch := True;
  Lc_Texto.Free;
  Bd_DetalheStr.Height := E_OBS.Height + 23;

  Lb_Codigo.Caption := Qr_Itens_assIAS_ETAPA.AsString;
  Lb_DescricaoProduto.Caption :=  Qr_Itens_assSIT_DESCRICAO.AsString;
  E_Data.Caption := Qr_Itens_assIAS_DATA.AsString;
  E_DT_Prevista.Caption := Qr_Itens_assIAS_DT_PREVISTA.AsString;
  E_DT_Realizada.Caption := Qr_Itens_assIAS_DT_REALIZADA.AsString;
  E_Hora.Caption := Qr_Itens_assIAS_HOUR.AsString;
end;

procedure TRL_ReportAssistencia_BalancaPinhais.BndRodapeBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  Lc_Dia, Lc_Mes, Lc_Ano: Integer;
  Lc_Data : String;
begin
  with Qr_Consulta do
  Begin
    if Trim(FieldByName('ASS_PRAZO').AsString) <> '' then
    Begin
      lc_dia := StrToInt(Copy(FieldByName('ASS_PRAZO').AsString,1,2));
      Lc_Mes := StrToInt(Copy(FieldByName('ASS_PRAZO').AsString,4,2));
      Lc_Ano := StrToInt(Copy(FieldByName('ASS_PRAZO').AsString,7,4));
    end
    else
    Begin
      Pc_Define_FormatoRegional;
      Lc_Data := DateToStr(Date);
      lc_dia := StrToInt(Copy(Lc_Data,1,2));
      Lc_Mes := StrToInt(Copy(Lc_Data,4,2));
      Lc_Ano := StrToInt(Copy(Lc_Data,7,4));
    end;
  End;
  Lb_Data.Caption := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ', ' + IntToStr(Lc_Dia) + ' de ' + Fc_DesMes(Lc_Mes,True) + ' de ' + IntToStr(Lc_Ano)+'.';
end;

procedure TRL_ReportAssistencia_BalancaPinhais.IniciaVariaveis;
Var
  Lc_I : Integer;
begin
  inherited;
  Bd_DetalheStr.Items.Clear;
  For Lc_I:= 1 to Qr_Itens_ass.RecordCount do
    Bd_DetalheStr.Items.Add(IntTostr(Lc_I));
end;

Procedure TRL_ReportAssistencia_BalancaPinhais.PC_VAlidaCampos(Pc_Print : Boolean);
Begin
  if Pc_Print then
  BEgin
    Lb_Codigo.Font.Color := clBlack;
    Lb_DescricaoProduto.Font.Color := clBlack;
    E_Data.Font.Color := clBlack;
    E_DT_Prevista.Font.Color := clBlack;
    E_DT_Realizada.Font.Color := clBlack;
  end
  else
  BEgin
    Lb_Codigo.Font.Color := clWhite;
    Lb_DescricaoProduto.Font.Color := clWhite;
    E_DAta.Font.Color := clWhite;
    E_DT_Prevista.Font.Color := clWhite;
    E_DT_Realizada.Font.Color := clWhite;
  end;
end;

procedure TRL_ReportAssistencia_BalancaPinhais.Rodape;
Var
  Lc_Obs : TDBMemo;
  Lc_I : Integer;
begin
  Lc_Obs := TDBMemo.Create(Self);
  Lc_Obs.Parent := Qrpt;
  Lc_Obs.Width := 500;
  Lc_Obs.Height := 50;
  Lc_Obs.DataSource := Ds_Consulta;
  e_Obs.Lines.Clear;
  e_Obs.Lines.Add('  Observções');
  for Lc_I := 0 to Lc_Obs.Lines.Count - 1 do
    e_Obs.Lines.Add('  ' + Lc_Obs.Lines[LC_i]);
  Lc_Obs.Free;
  Lc_Obs := nil;
end;

procedure TRL_ReportAssistencia_BalancaPinhais.PreencheCliente;
Begin
  with Qr_Consulta do
  Begin
    E_Titulo.Caption        := 'Assistência T�cnica - ' + FieldByName('ASS_NUMERO').AsString;
    Lb_Cli_Nome.Caption     := FieldByName('EMP_NOME').AsString;
    Lb_Cli_Fantasia.Caption := FieldByName('EMP_FANTASIA').AsString;
    Lb_Cli_Endereco.Caption := FieldByName('END_ENDER').AsString + ', ' + FieldByName('END_NUMERO').AsString;
    Lb_Cli_cep.Caption      := fc_MascaraCep(FieldByName('END_CEP').AsString);
    Lb_Cli_FoneC.Caption    := fc_MascaraFone(FieldByName('END_FONE').AsString);
    Lb_Cli_bairro.Caption   := FieldByName('END_BAIRRO').AsString;
    Lb_Cli_Cidade.Caption   := FieldByName('CDD_DESCRICAO').AsString;
    Lb_Cli_UF.Caption       := FieldByName('UFE_SIGLA').AsString;
    Lb_Cli_Fax.Caption      := fc_MascaraFone(FieldByName('END_FAX').AsString);
    Lb_Cli_Cnpj.Caption     := fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString);
    Lb_Cli_IncEst.Caption   := FieldByName('EMP_INSC_EST').AsString;
    Lb_Cli_Celular.Caption  := fc_MascaraFone(FieldByName('END_CELULAR').AsString);
    Lb_Cli_Email.Caption    := FieldByName('EMP_EMAIL').AsString;
  End;
end;

procedure TRL_ReportAssistencia_BalancaPinhais.QrptBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  DefineImpressora;
  IniciaVariaveis;
  Cabecalho;
  PreencheCliente;
end;


end.
