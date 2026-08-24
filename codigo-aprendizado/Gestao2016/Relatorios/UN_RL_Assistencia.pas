unit UN_RL_Assistencia;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, QuickRpt, QRCtrls, ExtCtrls, grimgctrl, StdCtrls, jpeg, DBCtrls;

type
  TRL_Assistencia = class(TForm)
    Qr_Itens_ass: TSTQuery;
    DataSource1: TDataSource;
    Qr_Assistencia: TSTQuery;
    Qrpt: TQuickRep;
    Rodape: TQRBand;
    QRMemo11: TQRMemo;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    Bd_DetalheStr: TQRStringsBand;
    QRMemo20: TQRMemo;
    QRMemo17: TQRMemo;
    QRMemo19: TQRMemo;
    QRMemo21: TQRMemo;
    QRMemo22: TQRMemo;
    Lb_DescricaoProduto: TQRLabel;
    Lb_VlUnit: TQRLabel;
    Lb_SubTotal: TQRLabel;
    Lb_Codigo: TQRLabel;
    Lb_Marca: TQRLabel;
    QRBand1: TQRBand;
    Label1: TLabel;
    QRMemo13: TQRMemo;
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
    QRBand2: TQRBand;
    Img_Logo: TQRImage;
    Lb_Emp_Nome: TQRLabel;
    Lb_Emp_Doc: TQRLabel;
    Lb_Emp_End: TQRLabel;
    Lb_Emp_Fones: TQRLabel;
    Lb_Emp_www: TQRLabel;
    Lb_Emp_email: TQRLabel;
    Lb_Cli_Pedido: TQRLabel;
    QRImage2: TQRImage;
    Ds_Ordem: TDataSource;
    Lb_Data: TQRLabel;
    QRMemo1: TQRMemo;
    QRLabel1: TQRLabel;
    QRMemo2: TQRMemo;
    QRLabel2: TQRLabel;
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
    E_Obs: TQRMemo;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RodapeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }

  public
    { Public declarations }
    It_Codigo : Integer;
    It_Sequencia : Integer;
    It_NItens : Real;
    Procedure PC_PreencheCampos;
    Procedure PC_VAlidaCampos(Pc_Print : Boolean);
    procedure Pc_Cabecalho;
    procedure Pc_Rodape;
  end;

var
  RL_Assistencia: TRL_Assistencia;

implementation

uses     UN_Sistema, Un_DM, UN_Pedido_Vda, Un_Funcoes, Un_Regra_Negocio, env;
{$R *.dfm}




Procedure TRL_Assistencia.PC_VAlidaCampos(Pc_Print : Boolean);
Begin
  if Pc_Print then
    BEgin
    Lb_Codigo.Font.Color := clBlack;
    Lb_DescricaoProduto.Font.Color := clBlack;
    Lb_Marca.Font.Color := clBlack;
    Lb_VlUnit.Font.Color := clBlack;
    Lb_SubTotal.Font.Color := clBlack;
    end
  else
    BEgin
    Lb_Codigo.Font.Color := clWhite;
    Lb_DescricaoProduto.Font.Color := clWhite;
    Lb_Marca.Font.Color := clWhite;
    Lb_VlUnit.Font.Color := clWhite;
    Lb_SubTotal.Font.Color := clWhite;
    end;
end;

Procedure TRL_Assistencia.PC_PreencheCampos;
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
  Lb_Marca.Caption := Qr_Itens_assIAS_DATA.AsString;
  Lb_VlUnit.Caption := Qr_Itens_assIAS_DT_PREVISTA.AsString;
  Lb_SubTotal.Caption := Qr_Itens_assIAS_DT_REALIZADA.AsString;
end;

procedure TRL_Assistencia.Pc_Cabecalho;
Var
  Lc_Dia, Lc_Mes, Lc_Ano: Integer;
  Lc_Data : String;
begin
  with DM do
    Begin
    Qr_Estabelecimento.Active := False;
    Qr_Estabelecimento.Active := True;
    Lb_Emp_Nome.Caption := Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString;
    Lb_Emp_Doc.Caption := 'C.N.P.J: '+fc_MascaraCNPJ(Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsString) + ' -  I.E.: '+ Qr_Estabelecimento.FieldByname('EMP_INSC_EST').AsString;
    Lb_Emp_End.Caption := Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ' - ' +Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString + ' - ' + Fc_MascaraCep(Qr_Estabelecimento.FieldByname('END_CEP').AsString) + ' - ' +Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' +Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString + ' - Fone: ' +fc_MascaraFone(Qr_Estabelecimento.FieldByname('END_FONE').AsString);
    Lb_Emp_www.Caption := Qr_Estabelecimento.FieldByname('EMP_SITE').AsString;
    Lb_Emp_email.Caption := Qr_Estabelecimento.FieldByname('EMP_EMAIL').AsString;
    Lb_Cli_Pedido.Caption := Qr_Assistencia.FieldByName('ASS_NUMERO').AsString;
    Fc_BuscaImagemEmpresa(Img_Logo.Picture,'LOGO');
    if Trim(Qr_Assistencia.FieldByName('ASS_PRAZO').AsString) <> '' then
      Begin
      lc_dia := StrToInt(Copy(Qr_Assistencia.FieldByName('ASS_PRAZO').AsString,1,2));
      Lc_Mes := StrToInt(Copy(Qr_Assistencia.FieldByName('ASS_PRAZO').AsString,4,2));
      Lc_Ano := StrToInt(Copy(Qr_Assistencia.FieldByName('ASS_PRAZO').AsString,7,4));
      end
    else
      Begin
      Pc_Define_FormatoRegional;
      Lc_Data := DateToStr(Date);
      lc_dia := StrToInt(Copy(Lc_Data,1,2));
      Lc_Mes := StrToInt(Copy(Lc_Data,4,2));
      Lc_Ano := StrToInt(Copy(Lc_Data,7,4));
      end;
    Lb_Data.Caption := Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ', ' + IntToStr(Lc_Dia) + ' de ' + Fc_DesMes(Lc_Mes,True) + ' de ' + IntToStr(Lc_Ano)+'.';
    end;
end;


procedure TRL_Assistencia.Pc_Rodape;
Var
  Lc_Obs : TDBMemo;
  Lc_I : Integer;
begin
  Lc_Obs := TDBMemo.Create(Self);
  Lc_Obs.Parent := Qrpt;
  Lc_Obs.Width := 500;
  Lc_Obs.Height := 50;
  Lc_Obs.DataSource := Ds_Ordem;
  e_Obs.Lines.Clear;
  e_Obs.Lines.Add('  Observções');
  for Lc_I := 0 to Lc_Obs.Lines.Count - 1 do
    e_Obs.Lines.Add('  ' + Lc_Obs.Lines[LC_i]);
  Lc_Obs.Free;
  Lc_Obs := nil;
end;

procedure TRL_Assistencia.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_I : Integer;
begin
  //Baixa o arquivo da imagem
  try
    if not FileExists(GbPathExe + 'imagem\genio_assistencia.jpg') then
      Pc_BaixarArquivosSite('img','genio_assistencia.jpg','imagem');
    if FileExists(GbPathExe + 'imagem\genio_assistencia.jpg') then
      QRImage2.Picture.LoadFromFile(GbPathExe + 'imagem\genio_assistencia.jpg');
  Except
    QRImage2.Picture.Graphic := nil;
    QRImage2.Visible := False;
  end;
  Pc_Define_Impressora_Qrpt(Qrpt);
  It_NItens := 0;
  It_Sequencia := 0;

  //Pedido
  Qr_Assistencia.Active := False;
  Qr_Assistencia.ParamByName('ASS_CODIGO').AsInteger := It_Codigo;
  Qr_Assistencia.Active := True;
  Qr_Assistencia.First;

  //Itens do Pedido
  Qr_Itens_ass.Active := False;
  Qr_Itens_ass.ParamByName('ASS_CODIGO').AsInteger := It_Codigo;
  Qr_Itens_ass.Active := True;
  Qr_Itens_ass.Last;
  Qr_Itens_ass.First;

  Bd_DetalheStr.Items.Clear;
  For Lc_I:= 1 to Qr_Itens_ass.RecordCount do
    Bd_DetalheStr.Items.Add(IntTostr(Lc_I));

  Pc_Cabecalho;
end;

procedure TRL_Assistencia.Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Not Qr_Itens_ass.Eof then
    Begin
    It_NItens := It_NItens +1;
    It_Sequencia := It_Sequencia + 1;
    pc_ValidaCampos(True);
    Pc_PreencheCAmpos;
    Qr_Itens_ass.Next;
    end
  else
    pc_ValidaCampos(False);
end;

procedure TRL_Assistencia.RodapeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//  Pc_Rodape;
end;

procedure TRL_Assistencia.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Cli_Pedido.Caption := Qr_Assistencia.FieldByName('ASS_NUMERO').AsString;
  Lb_Cli_Nome.Caption := Qr_Assistencia.FieldByName('EMP_NOME').AsString;
  Lb_Cli_Fantasia.Caption := Qr_Assistencia.FieldByName('EMP_FANTASIA').AsString;
  Lb_Cli_Endereco.Caption := Qr_Assistencia.FieldByName('END_ENDER').AsString + ', ' + Qr_Assistencia.FieldByName('END_NUMERO').AsString;
  Lb_Cli_cep.Caption := fc_MascaraCep(Qr_Assistencia.FieldByName('END_CEP').AsString);
  Lb_Cli_FoneC.Caption := fc_MascaraFone(Qr_Assistencia.FieldByName('END_FONE').AsString);
  Lb_Cli_bairro.Caption := Qr_Assistencia.FieldByName('END_BAIRRO').AsString;
  Lb_Cli_Cidade.Caption := Qr_Assistencia.FieldByName('CDD_DESCRICAO').AsString;
  Lb_Cli_UF.Caption := Qr_Assistencia.FieldByName('UFE_SIGLA').AsString;
  Lb_Cli_Fax.Caption :=fc_MascaraFone(Qr_Assistencia.FieldByName('END_FAX').AsString);
  Lb_Cli_Cnpj.Caption := fc_MascaraCNPJ(Qr_Assistencia.FieldByName('EMP_CNPJ').AsString);
  Lb_Cli_IncEst.Caption := Qr_Assistencia.FieldByName('EMP_INSC_EST').AsString;
  Lb_Cli_Celular.Caption := fc_MascaraFone(Qr_Assistencia.FieldByName('END_CELULAR').AsString);
  Lb_Cli_Email.Caption := Qr_Assistencia.FieldByName('EMP_EMAIL').AsString;
end;

end.
