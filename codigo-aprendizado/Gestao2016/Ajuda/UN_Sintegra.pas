unit UN_Sintegra;

interface

uses
      STQuery, Data.DB, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Controls, Classes, Vcl.ExtCtrls, Vcl.Forms, SysUtils, Vcl.Graphics, Winapi.Messages, Winapi.Windows, ACBrBase, ACBrSintegra, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.Samples.Gauges, Vcl.CheckLst, System.Math;


type
  TGeraSintegra=class(TThread)
  private
    FCounter: Integer;
    FCountTo: Integer;

    procedure DoProgress;
    procedure SetCountTo(const Value: Integer);
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
    property CountTo: Integer read FCountTo write SetCountTo;
  end;

  TFr_Sintegra = class(TForm)
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Cb_Convenio: TComboBox;
    Cb_Natureza: TComboBox;
    Cb_Finalidade: TComboBox;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    E_Responsavel: TEdit;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox4: TGroupBox;
    ChLBx_Registro: TCheckListBox;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    E_CNPJ: TEdit;
    Label2: TLabel;
    E_Insc_Estadual: TEdit;

    Panel1: TPanel;
    ComboBox5: TComboBox;
    Label10: TLabel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    SB_Sair: TSpeedButton;
    SB_Gerar: TSpeedButton;
    Qr_Registro: TSTQuery;
    Qr_ItensRegistro: TSTQuery;
    Lb_Processamento: TLabel;
    Gg_Progresso: TGauge;
    Qr_Registro70: TSTQuery;
    Qr_Registro53: TSTQuery;
    Qr_EqptoECF: TSTQuery;
    Qr_VendasECF: TSTQuery;
    Qr_Acao: TSTQuery;
    GroupBox5: TGroupBox;
    Dbg_Inventario: TDBGrid;
    Qr_Inventario: TSTQuery;
    Ds_Inventario: TDataSource;
    ACBrSintegra: TACBrSintegra;
    procedure SB_GerarClick(Sender: TObject);
    procedure SB_SairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ChLBx_RegistroClick(Sender: TObject);
  private
    { Private declarations }
    wretorno: Integer;
    it_Cd_Crt : Integer;
    It_Sb_Trib : Boolean;

    procedure Pc_IniciaVariavel;
    procedure Pc_GravaParametros;
    procedure Pc_GeraSintegraNormal;
    procedure Pc_AbreItensRegistro;
    procedure GerarRegistro10;
    procedure GerarRegistro11;
    procedure GerarRegistro50;
    procedure GerarRegistro51;
    procedure GerarRegistro53;
    procedure GerarRegistro54;

    procedure GerarRegistro60M;
    procedure GerarRegistro70;
    procedure GerarRegistro74;
    procedure GerarRegistro85;
    procedure GerarRegistro86;
    Function Fc_VerificaRegistro:iNTEGER;
    procedure Pc_VerificaCodnatZeroICMS;
    function Fc_ECF_SequenciaCOO(Fc_Tipo:String;Fc_Dia:TDate):Integer;
    function Fc_ECF_VendaBruta(Fc_Dia:TDate):Real;
    Function Fc_VerificaSomaICMS(Fc_Tipo:String;Fc_cd_nota:Integer):real;
    //geração do Sintegra direto do ECF
    procedure Pc_GeraSintegraECF;
    procedure Pc_GeraSintegraECF_Bematech;
    procedure Pc_GeraSintegraECF_Epson;
    procedure Pc_OrganizaSintegraECF_Epson;
  public
    { Public declarations }
    function Fc_ValidaSintegra: Boolean;
  end;

  //funcoes de inicializacao;

function ACBr_SintegraAtivar: Integer; stdcall; external 'ACBr.dll';
function ACBr_SintegraDesativar: Integer; stdcall; external 'ACBr.dll';

  //funcoes sintegra
function ACBr_SintegraRegistro10(CNPJ, Inscricao, RazaoSocial, Cidade, Estado,
  Telefone, DataInicial, DataFinal, CodigoConvenio, NaturezaInformacoes,
  FinalidadeArquivo: PChar): Integer; stdcall; external 'ACBr.dll';
function ACBr_SintegraRegistro11(Endereco, Numero, Bairro, Cep, Responsavel,
  Telefone: PChar): Integer; stdcall; external 'ACBr.dll';
function ACBr_SintegraRegistro50(CPFCNPJ, Inscricao, DataDocumento, UF, Modelo,
  Serie, Numero, Cfop, EmissorDocumento, ValorContabil, BasedeCalculo, Icms,
  Isentas, Outras, Aliquota, Situacao: PChar): Integer; stdcall; external 'ACBr.dll';
function ACBr_SintegraRegistro51(CPFCNPJ, Inscricao, DataDocumento, Estado,
  Serie, Numero, CFOP, ValorContabil, ValorIpi, ValorOutras, ValorIsentas,
  Situacao: PChar): Integer; stdcall; external 'ACBr.dll';
function ACBr_SintegraRegistro53(CPFCNPJ, Inscricao, DataDocumento, Estado,
  Modelo, Serie, Numero, CFOP, Emitente, BaseST, IcmsRetido, Despesas,
  Situacao, CodigoAntecipacao: PChar): Integer; stdcall; external 'ACBr.dll';
function ACBr_SintegraRegistro54(CPFCNPJ, Modelo, Serie, Numero, CFOP, CST,
  NumeroItem, Codigo, Descricao, Quantidade, Valor, ValorDescontoDespesa,
  BasedeCalculo, BaseST, ValorIpi, Aliquota: PChar): Integer; stdcall; external 'ACBr.dll';
function ACBr_SintegraRegistro60M(Emissao, NumSerie, NumOrdem, ModeloDoc,
  CooInicial, CooFinal, CRZ, CRO, VendaBruta, ValorGT: PChar): Integer; stdcall; external 'ACBr.dll';
function ACBr_SintegraRegistro60A(Emissao, NumSerie, Aliquota,
  Valor: PChar): Integer; stdcall; external 'ACBr.dll';
function ACBr_SintegraRegistro70(CPFCNPJ, Inscricao, DataDocumento, UF,
  Modelo, Serie, SubSerie, Numero, Cfop, ValorContabil,
  BasedeCalculo, Icms, Isentas, Outras, CifFobOutros,
  Situacao: PChar): Integer; stdcall; external 'ACBr.dll';
function ACBr_SintegraRegistro75(DataInicial, DataFinal, Codigo, NCM,
  Descricao, Unidade, AliquotaIpi, AliquotaICMS, Reducao,
  BaseST: PChar): Integer; stdcall; external 'ACBr.dll';
function ACBr_SintegraGeraArquivo(Arquivo: PChar;
  VersaoValidador: Integer): Integer; stdcall; external 'ACBr.dll';

  //funcoes de informacao
function ACBr_VersaoDll(var Versao: ShortString): Integer; stdcall;
external 'ACBr.dll';
var
  Fr_Sintegra: TFr_Sintegra;

implementation

uses     Un_DM, UN_Sistema, Un_Funcoes, UN_MSG, UN_Principal, env, un_Padrao, Un_Regra_Negocio;
constructor TGeraSintegra.Create(CreateSuspended: Boolean);
begin
  inherited;
  FCounter := 0;
  FCountTo := MAXINT;
end;

procedure TGeraSintegra.DoProgress;
begin
  application.ProcessMessages;
end;
procedure TGeraSintegra.SetCountTo(const Value: Integer);
Begin
  FCountTo := Value;
end;

procedure TGeraSintegra.Execute;
const
  Interval = 1000000;
begin
  FreeOnTerminate := True;
  while FCounter < FCountTo do
    begin
    if FCounter mod Interval = 0 then
      Synchronize(DoProgress);

    Inc(FCounter);
    end;
end;


{$R *.dfm}

//geração do Sintegra Registros 50/52/53/54 etc
procedure TFr_Sintegra.Pc_GeraSintegraNormal;
Begin
  //Pc_VerificaCodnatZeroICMS;
  ACBrSintegra.FileName := SaveDialog1.FileName;
  ACBrSintegra.VersaoValidador := TVersaoValidador(ComboBox5.ItemIndex);
  IF Fc_VerificaRegistro > 0 then // se tem movimento
  begin
    GerarRegistro10;
    GerarRegistro11;
    Pc_AbreItensRegistro;
    if ChLBx_Registro.Checked[0]  then  GerarRegistro50;
    if ChLBx_Registro.Checked[1]  then  GerarRegistro51;
    if ChLBx_Registro.Checked[2]  then  GerarRegistro53;
    if ChLBx_Registro.Checked[3]  then  GerarRegistro54;
    if ChLBx_Registro.Checked[5]  then  GerarRegistro70;
    if ChLBx_Registro.Checked[6]  then  GerarRegistro74;
    if ChLBx_Registro.Checked[7]  then  GerarRegistro85;
    if ChLBx_Registro.Checked[8] then  GerarRegistro86;
    ACBrSintegra.GeraArquivo;
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Arquivo Gerado com Sucesso.' + EOLN,
                   ['OK'], [bEscape], mpConfirmacao);
  end
  else
  Begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Não foi encontrado movimento no período Informado.' + EOLN,
                   ['OK'], [bEscape], mpConfirmacao);
  end;
end;

//geração do Sintegra direto do ECF

procedure TFr_Sintegra.Pc_GeraSintegraECF;
Begin
{  IF Fc_Verifica_ECF then // se tem ECF
    Begin
    Qr_EqptoECF.Active := True;
    if Qr_EqptoECFMEF_MODELO.AsString = 'ecfEpson' then
      Begin
      //Pc_GeraSintegraECF_Epson;
      LC_processo := TProcesso.Create(true);
      
      Pc_OrganizaSintegraECF_Epson;


      MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                     'Arquivo Gerado com Sucesso.' + EOLN,
                     ['OK'], [bEscape], mpConfirmacao);
      end
    else
    if Qr_EqptoECFMEF_MODELO.AsString = 'ecfBematech' then
      Begin
      Pc_GeraSintegraECF_Bematech
      end
    else
      Begin
      MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                     'Geração de Arquivo Sintegra não disponível para o modelo Atual.' + EOLN,
                     ['OK'], [bEscape], mpConfirmacao);
      end;
    end;
}
end;

procedure TFr_Sintegra.Pc_GeraSintegraECF_Bematech;
Begin

end;

procedure TFr_Sintegra.Pc_GeraSintegraECF_Epson;
Var
  Lc_Veloc :Integer;
  Lc_Porta : Integer;
  Lc_dataIni,Lc_dataFim:PAnsiChar;
  Lc_Aux : String;
  Lc_Result : Integer;
Begin
{  Lc_Veloc := StrToIntDef(Fc_Aq_Geral('L','COMUNICA_ECF','BAUDRATE',''),38400);
  Lc_Porta := Qr_EqptoECFPEF_CODIGO.AsInteger -1;
  //Abrir a porta de comunica
  EPSON_Serial_Abrir_Fechar_Porta_CMD (Lc_Veloc, Lc_Porta);
  //Informa os dados da Empresa para abrir os dados do Sintegra
 Pc_AtivaEstabelecimento;

  EPSON_Config_Dados_Sintegra(pchar( DM.Qr_Estabelecimento.FieldByname('EMP_NOME').AsString),
                              pchar( DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString),
                              pchar( DM.Qr_Estabelecimento.FieldByname('END_NUMERO').AsString),
                              pchar( DM.Qr_Estabelecimento.FieldByname('END_COMPLEM').AsString),
                              pchar( DM.Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString),
                              pchar( DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString),
                              pchar( DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString),
                              pchar( DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString),
                              pchar( DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString),
                              pchar( DM.Qr_Estabelecimento.FieldByname('END_FAX').AsString),
                              pchar( E_Responsavel.Text));
  Lc_Aux := DateToStr(E_Data_Ini.Date);
  Lc_dataIni := pchar(copy(Lc_Aux,1,2) + copy(Lc_Aux,4,2) + copy(Lc_Aux,7,4));
  Lc_Aux := DateToStr(E_Data_Fim.Date);
  Lc_dataFim := pchar(copy(Lc_Aux,1,2) + copy(Lc_Aux,4,2) + copy(Lc_Aux,7,4));
  //Gerar o Registro 60M
  Lc_Result := EPSON_Obter_Dados_MF_MFD(Lc_dataIni, Lc_datafim, 0 , 0 , 0 , 115, Pchar(GbPathExe + '\60M'));
  EPSON_Serial_Fechar_Porta( );
}
end;

procedure TFr_Sintegra.Pc_OrganizaSintegraECF_Epson;
var
  Lc_Le_arq: TextFile;
  Lc_Le_linha: String;
  Lc_Grava_arq: TextFile;
  Lc_Grava_linha: String;
  Lc_Compara_R : String;
  Lc_Compara_V : String;
  Lc_1P,Lc_2P,Lc_3P:String;
  lc_Cd_produto : Real;
  Lc_Ordena60R : TStringList;
  Lc_I : Integer;
  Lc_Linhas : Integer;
  Lc_Linhas60 : Integer;
  Lc_Linhas75 : Integer;
begin
  //Abre Arquivo para Gravação
  AssignFile ( Lc_Grava_arq,SaveDialog1.FileName );
  Rewrite ( Lc_Grava_arq );
  //Abre Arquivo para Leitura
  AssignFile ( Lc_Le_arq, GbPathExe + '\60M_SIN.txt' );
  Reset ( Lc_Le_arq );
  ReadLn ( Lc_Le_arq, Lc_Le_linha );
  Lc_Linhas := 1;
  Lc_Linhas60 := 0;
  Lc_Linhas75 := 0;
  inc(Lc_Linhas);
  while not Eof ( Lc_Le_arq ) do
    begin
    Lc_Compara_R := Copy(Lc_Le_linha,1,3);
    Lc_Compara_V := Copy(Lc_Le_linha,36,12);
    if not ((Lc_Compara_R = '60A') and (Lc_Compara_V = '000000000000')) then
      Begin
      //Verifica se é o grupo 60R então coloca numa lista para ordenar por produto
      if (Lc_Compara_R = '60R') then
        Begin
        Lc_Ordena60R := TStringList.Create;
        Lc_Ordena60R.Clear;
        repeat
          begin
          Lc_1P := Copy(Lc_Le_linha,1,9);
          Lc_2P := Copy(Lc_Le_linha,10,14);
          Lc_3P := Copy(Lc_Le_linha,24,103);
          lc_Cd_produto := StrToInt(trim(Lc_2P));
          Lc_2P := StrZero(lc_Cd_produto,14,0);
          Lc_Ordena60R.Add(Lc_2P + ';' + Lc_1P + Lc_2P + Lc_3P);
          ReadLn ( Lc_Le_arq, lc_le_linha );
          inc(Lc_Linhas);
          Lc_Compara_R := Copy(Lc_Le_linha,1,3);
          end;
        until (Lc_Compara_R <> '60R');

        //Sai do Loop interno 60r 3 grava no arquivo
        Lc_Ordena60R.Sort;
        For Lc_I := 0 to Lc_Ordena60R.Count - 1 do
          Begin
          inc(Lc_Linhas60);
          Lc_Grava_linha := Copy(Lc_Ordena60R.Strings[lc_I],16,(Length(Lc_Ordena60R.Strings[lc_I])-14));
          WriteLn(Lc_Grava_arq,Lc_Grava_linha);
          end;
        FreeAndNil(Lc_Ordena60R);
        end;
      //Verifica se é o registro 75 para renumerar o codcódcódcódigo do produto com os zeros esquerda
      Lc_Compara_R := Copy(Lc_Le_linha,1,2);
      if (Lc_Compara_R = '75') then
        Begin
        repeat
          begin
          Lc_1P := Copy(Lc_Le_linha,1,18);
          Lc_2P := Copy(Lc_Le_linha,19,14);
          Lc_3P := Copy(Lc_Le_linha,33,94);
          lc_Cd_produto := StrToInt(trim(Lc_2P));
          Lc_2P := StrZero(lc_Cd_produto,14,0);
          Lc_Grava_linha := Lc_1P + Lc_2P + Lc_3P;
          inc(Lc_Linhas75);
          WriteLn(Lc_Grava_arq,Lc_Grava_linha);
          ReadLn ( Lc_Le_arq, lc_le_linha );
          inc(Lc_Linhas);
          Lc_Compara_R := Copy(Lc_Le_linha,1,2);
          end;
        until (Lc_Compara_R <> '75');
        end;
      Lc_Compara_R := Copy(Lc_Le_linha,1,2);
      if (Lc_Compara_R = '90') then
        Begin
        Lc_1P := Copy(Lc_Le_linha,1,30);
        Lc_3P := Copy(Lc_Le_linha,61,66);
        Lc_Grava_linha := Lc_1P;
        //Registro 60
        Lc_Grava_linha := Lc_Grava_linha + '60';
        Lc_2P := StrZero(Lc_Linhas60 - 2,8,0);
        Lc_Grava_linha := Lc_Grava_linha + Lc_2P;
        //Registro 75
        Lc_Grava_linha := Lc_Grava_linha + '75';
        Lc_2P := StrZero(Lc_Linhas75,8,0);
        Lc_Grava_linha := Lc_Grava_linha + Lc_2P;
        //Registro 99
        Lc_2P := '99' + StrZero((Lc_Linhas60 +  Lc_Linhas75 + 1),8,0);
        Lc_Grava_linha :=  Lc_Grava_linha + Lc_2P;
        //Ultima campo Branco
        Lc_Grava_linha := Lc_Grava_linha + Lc_3P;
        WriteLn(Lc_Grava_arq,Lc_Grava_linha);
        end
      else
        Begin
        inc(Lc_Linhas60);
        Lc_Grava_linha := Lc_Le_linha;
        WriteLn(Lc_Grava_arq,Lc_Grava_linha);
        end;
      end;
    ReadLn ( Lc_Le_arq, lc_le_linha );
    inc(Lc_Linhas);
    end;
  CloseFile ( Lc_Le_arq );
  CloseFile ( Lc_Grava_arq );
end;


procedure TFr_Sintegra.Pc_IniciaVariavel;
var
  Lc_dia, Lc_Mes, Lc_Ano: string;
begin
  Pc_AtivaEstabelecimento;
  E_CNPJ.Text := DM.Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsString;
  E_Insc_Estadual.Text := DM.Qr_Estabelecimento.FieldByname('EMP_INSC_EST').AsString;
  E_Responsavel.Text := DM.Qr_Estabelecimento.FieldByname('END_CONTATO').AsString;
  Lc_dia := formatdatetime('dd', Date);
  Lc_Mes := formatdatetime('mm', Date);
  Lc_Ano := formatdatetime('yyyy', Date);

  Lc_dia := '01';
  if Lc_Mes = '01' then
    Lc_Ano := inttostr((Strtoint(Lc_Ano) - 1));
  if Lc_Mes = '01' then
    Lc_Mes := '12'
  else
    Lc_Mes := StrZero((Strtoint(Lc_Mes) - 1), 2, 0);
  E_Data_Ini.Date := StrToDate(Lc_dia + '/' + Lc_Mes + '/' + Lc_Ano);
  Lc_dia := Fc_Ult_Dia_Mes(E_Data_Ini.Date);
  E_Data_Fim.Date := StrToDate(Lc_dia + '/' + Lc_Mes + '/' + Lc_Ano);

  ChLBx_Registro.Checked[0]  := (Fc_Tb_Geral('L','STG_REGISTRO_00','S')= 'S');
  ChLBx_Registro.Checked[1]  := (Fc_Tb_Geral('L','STG_REGISTRO_01','S')= 'S');
  ChLBx_Registro.Checked[2]  := (Fc_Tb_Geral('L','STG_REGISTRO_02','S')= 'S');
  ChLBx_Registro.Checked[3]  := (Fc_Tb_Geral('L','STG_REGISTRO_03','S')= 'S');
  ChLBx_Registro.Checked[4]  := (Fc_Tb_Geral('L','STG_REGISTRO_04','S')= 'S');
  ChLBx_Registro.Checked[5]  := (Fc_Tb_Geral('L','STG_REGISTRO_05','S')= 'S');
  ChLBx_Registro.Checked[6]  := (Fc_Tb_Geral('L','STG_REGISTRO_06','S')= 'S');
  ChLBx_Registro.Checked[7]  := (Fc_Tb_Geral('L','STG_REGISTRO_07','S')= 'S');
  ChLBx_Registro.Checked[8]  := (Fc_Tb_Geral('L','STG_REGISTRO_08','S')= 'S');
end;

procedure TFr_Sintegra.Pc_GravaParametros;
Begin
  if ChLBx_Registro.Checked[0]  then Fc_Tb_Geral('G','STG_REGISTRO_00','S') else Fc_Tb_Geral('G','STG_REGISTRO_00','N');
  if ChLBx_Registro.Checked[1]  then Fc_Tb_Geral('G','STG_REGISTRO_01','S') else Fc_Tb_Geral('G','STG_REGISTRO_01','N');
  if ChLBx_Registro.Checked[2]  then Fc_Tb_Geral('G','STG_REGISTRO_02','S') else Fc_Tb_Geral('G','STG_REGISTRO_02','N');
  if ChLBx_Registro.Checked[3]  then Fc_Tb_Geral('G','STG_REGISTRO_03','S') else Fc_Tb_Geral('G','STG_REGISTRO_03','N');
  if ChLBx_Registro.Checked[4]  then Fc_Tb_Geral('G','STG_REGISTRO_04','S') else Fc_Tb_Geral('G','STG_REGISTRO_04','N');
  if ChLBx_Registro.Checked[5]  then Fc_Tb_Geral('G','STG_REGISTRO_05','S') else Fc_Tb_Geral('G','STG_REGISTRO_05','N');
  if ChLBx_Registro.Checked[6]  then Fc_Tb_Geral('G','STG_REGISTRO_06','S') else Fc_Tb_Geral('G','STG_REGISTRO_06','N');
  if ChLBx_Registro.Checked[7]  then Fc_Tb_Geral('G','STG_REGISTRO_07','S') else Fc_Tb_Geral('G','STG_REGISTRO_07','N');
  if ChLBx_Registro.Checked[8]  then Fc_Tb_Geral('G','STG_REGISTRO_08','S') else Fc_Tb_Geral('G','STG_REGISTRO_08','N');
end;

Function TFr_Sintegra.Fc_VerificaSomaICMS(Fc_Tipo:String;Fc_cd_nota:Integer):real;
Begin
{  with DM.Qr_Acao do
    Begin
    Active := False;
    Transaction := DM.IB_Transacao;
    SQL.Clear;
    SQL.Add(')



    end;
}
end;


procedure TFr_Sintegra.Pc_VerificaCodnatZeroICMS;
Begin
  with Qr_Acao do
  Begin
    Active := False;
    Transaction := DM.IB_Transacao;
    SQL.Clear;
    SQL.Add('UPDATE TB_ITENS_ICMS SET '+
            'ICM_CODNAT =:ICM_CODNAT '+
            'WHERE ICM_CODIGO =:ICM_CODIGO ');
    end;

  with Qr_Registro do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT PED_TIPO, EMP_PESSOA,  EMP_CNPJ, EMP_INSC_EST, EMP_NOME, UFE_SIGLA, NFL_DT_EMISSAO,NFL_STATUS, '+
            'NFL_TIPO, NFL_MODELO, NFL_SERIE, NFL_NUMERO, NAT_CFOP, NAT_CODIGO, NFL_BS_ICMS,  NFL_VL_ICMS,  NFL_BS_ICMS_SUBST, '+
            'NFL_VL_ICMS_SUBST, NFL_VL_TL_PROD, NFL_VL_FRETE, NFL_VL_SEGURO, NFL_VL_DESP_ACESS, NFL_VL_IPI, NFL_VL_TL_NOTA, '+
            'ICM_CODIGO, ICM_VL_BC_NR, ICM_AQ_NR, ICM_CODNAT, SUM((ITF_VL_UNIT * ITF_QTDE)) ICM_SB_PRODUTO '+
            'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
            '  INNER JOIN TB_NATUREZA tb_natureza '+
            '  ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT) '+
            '  INNER JOIN TB_PEDIDO tb_pedido '+
            '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
            '  INNER JOIN TB_EMPRESA tb_empresa '+
            '  ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
            '  INNER JOIN TB_ENDERECO tb_endereco '+
            '  ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND) '+
            '  INNER JOIN TB_UF tb_uf '+
            '  ON (tb_endereco.END_CODUFE = tb_uf.UFE_CODIGO) '+
            '  INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
            '  ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO ) '+
            '  LEFT OUTER JOIN TB_ITENS_ICMS tb_itens_icms '+
            '  ON (tb_itens_icms.ICM_CODITF = tb_itens_nfl.ITF_CODIGO ) '+
            '  LEFT OUTER JOIN TB_ITENS_IPI tb_itens_ipi '+
            '  ON (tb_itens_ipi.IPI_CODITF = tb_itens_nfl.ITF_CODIGO ) '+
            '  INNER JOIN TB_PRODUTO tb_produto '+
            '  ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) '+
            'WHERE NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM '+
            '  AND (NFL_NUMERO <> '''') '+
            '  AND (NFL_NUMERO <> ''0'') '+
            '  AND (ICM_CODNAT = 0) '+
            '  AND ((NAT_REGISTRO = 0) OR (NAT_REGISTRO IS NULL)) '+
            '  AND (NFL_CODMHA=:NFL_CODMHA) '+
            'GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28 '+
            'ORDER BY NFL_DT_EMISSAO, NFL_NUMERO ');

    Qr_Registro.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
    Qr_Registro.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    Qr_Registro.ParamByName('NFL_CODMHA').AsInteger:=Gb_CodMha;
    Qr_Registro.Active := True;
    Qr_Registro.FetchAll;
    Qr_Registro.First;
    while not Qr_Registro.Eof do
      Begin
      if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
      Qr_Acao.Active := False;
      Qr_Acao.ParamByName('ICM_CODIGO').AsInteger := Qr_Registro.FieldByName('ICM_CODIGO').AsInteger;
      Qr_Acao.ParamByName('ICM_CODNAT').AsInteger := Qr_Registro.FieldByName('NAT_CODIGO').AsInteger;
      Qr_Acao.ExecSQL;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      Qr_Registro.Next;
      end;
    end;
end;

procedure TFr_Sintegra.GerarRegistro10;
begin
  Pc_AtivaEstabelecimento;
  //Codigo do regime Tributario
  it_Cd_Crt  := StrToIntdef(DM.Qr_Estabelecimento.FieldByname('EMP_CRT').AsString,3);
  It_Sb_Trib := (Length(Trim(DM.Qr_Estabelecimento.FieldByname('EMP_NUMINSC_SUBS').AsString))>0);
  with ACBrSintegra.Registro10 do
    begin
    CNPJ := DM.Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsString;
    Inscricao := DM.Qr_Estabelecimento.FieldByname('EMP_INSC_EST').AsString;
    RazaoSocial := DM.Qr_Estabelecimento.FieldByname('EMP_NOME').AsString;
    Cidade := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString;
    Estado := DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString;
    Telefone := DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString;
    DataInicial := E_Data_Ini.Date;
    DataFinal := E_Data_Fim.Date;
    CodigoConvenio := IntToStr(Cb_Convenio.ItemIndex + 1);
    NaturezaInformacoes := IntToStr(Cb_Natureza.ItemIndex + 1);
    FinalidadeArquivo := Copy(Cb_Finalidade.Items[Cb_Finalidade.ItemIndex], 1, 1);
    end;
end;



procedure TFr_Sintegra.GerarRegistro11;
begin
  Pc_AtivaEstabelecimento;
  with ACBrSintegra.Registro11 do
    begin
    Endereco := DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString;
    Numero := DM.Qr_Estabelecimento.FieldByname('END_NUMERO').AsString;
    Bairro := DM.Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString;
    Cep := DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString;
    Responsavel := E_Responsavel.Text;
    Telefone := DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString;
    end;
end;


procedure TFr_Sintegra.GerarRegistro50;
var
  wregistro50: TRegistro50;
  Lc_Cfop: string;
  Lc_Nota :String;
begin
  Lb_Processamento.Caption := 'Abrindo Tabelas de Notas';
  Application.ProcessMessages;
  Qr_Registro.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
  Qr_Registro.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
  Qr_Registro.ParamByName('NFL_CODMHA').AsInteger:=Gb_CodMha;
  Qr_Registro.Active := True;
  Qr_Registro.FetchAll;
  Qr_Registro.First;
  Gg_Progresso.progress := 0;
  Gg_Progresso.MinValue := 1;
  Gg_Progresso.MaxValue := Qr_Registro.RecordCount;
  Lb_Processamento.Caption := 'Processando Registro 50';
  with ACBrSintegra,Qr_Registro do
  begin
    if not IsEmpty then
    begin
      Lc_Nota :='';
      while not Eof do
      begin
        wregistro50 := TRegistro50.Create;
        wregistro50.CPFCNPJ := fc_MascaraCNPJ(FieldbyName('EMP_CNPJ').AsString);
        if FieldbyName('EMP_PESSOA').AsString = 'J' then
        Begin
          if Trim(FieldbyName('EMP_INSC_EST').AsString) <> '' then
            wregistro50.Inscricao := FieldbyName('EMP_INSC_EST').AsString
          else
            wregistro50.Inscricao := 'ISENTO';
        end;
        wregistro50.DataDocumento := FieldbyName('NFL_DT_EMISSAO').AsDateTime;
        wregistro50.UF := FieldbyName('UFE_SIGLA').AsString;

        IF (Trim(FieldbyName('NFL_MODELO').AsString) <> '') and
           (Trim(FieldbyName('NFL_MODELO').AsString) <> '00') then
          wregistro50.Modelo := FieldbyName('NFL_MODELO').AsString
        else
          wregistro50.Modelo := '01';

       if (trim(FieldByName('NFL_SERIE').AsString) <> '') AND
           (trim(FieldByName('NFL_SERIE').AsString) <> '0') then
          wregistro50.Serie := FieldbyName('NFL_SERIE').AsString
        else
          wregistro50.Serie := '1';
        wregistro50.Numero := COPY(FieldbyName('NFL_NUMERO').AsString, 1, 6);
        wregistro50.Cfop := FieldbyName('nat_cfop').AsString;
        wregistro50.ValorContabil := FieldbyName('ITF_VL_PRODUTO').AsCurrency +
                                     FieldbyName('icm_vl_frete').AsCurrency +
                                     FieldbyName('icm_vl_seguro').AsCurrency +
                                     FieldbyName('icm_vl_outras').AsCurrency +
                                     FieldbyName('ICM_VL_ST').AsCurrency +
                                     FieldbyName('IPI_VALOR').AsCurrency;

        if FieldbyName('NFL_TIPO').AsString = 'SI' then
          wregistro50.EmissorDocumento := 'P'
        else
          wregistro50.EmissorDocumento := 'T';
        wregistro50.BasedeCalculo := FieldbyName('ICM_VL_BC_NR').AsCurrency;
        wregistro50.Icms := (FieldbyName('ICM_VL_BC_NR').AsCurrency * FieldbyName('ICM_AQ_NR').AsFloat)/100;
        wregistro50.Icms := Roundto( wregistro50.Icms,-2);
        wregistro50.Aliquota := FieldbyName('ICM_AQ_NR').AsFloat;

        if FieldbyName('NFL_STATUS').AsString <> 'C' then
          wregistro50.Situacao := 'N'
        else
          wregistro50.Situacao := 'S';
        ACBrSintegra.Registros50.Add(wregistro50);
        Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
        Application.ProcessMessages;
        Lc_Nota := Qr_Registro.FieldbyName('NFL_NUMERO').AsString;
        Next;
      end;
    end;
  end;
end;


procedure TFr_Sintegra.GerarRegistro51;
var
  wregistro51: TRegistro51;
begin
  Lb_Processamento.Caption := 'Abrindo Tabelas de Notas';
  Application.ProcessMessages;
  Qr_Registro.Active := False;
  Qr_Registro.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
  Qr_Registro.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
  Qr_Registro.ParamByName('NFL_CODMHA').AsInteger:=Gb_CodMha;
  Qr_Registro.Active := True;
  Qr_Registro.FetchAll;
  Qr_Registro.First;
  Gg_Progresso.MinValue := 1;
  Gg_Progresso.MaxValue := Qr_Registro.RecordCount;
  Lb_Processamento.Caption := 'Processando Registro 51';
  if not Qr_Registro.IsEmpty then
    begin
    while not Qr_Registro.Eof do
      begin
      if (Qr_Registro.FieldByName('NFL_VL_IPI').AsCurrency > 0) then
        Begin
        with ACBrSintegra do
          begin
          with Qr_Registro do
            Begin
            wregistro51 := TRegistro51.Create;
            wregistro51.CPFCNPJ := fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString);
            if FieldByName('EMP_PESSOA').AsString = 'J' then
              wregistro51.Inscricao := FieldByName('EMP_INSC_EST').AsString
            else
              wregistro51.Inscricao := 'ISENTO';
            wregistro51.DataDocumento := FieldByName('NFL_DT_EMISSAO').AsDateTime;
            wregistro51.Estado := FieldByName('UFE_SIGLA').AsString;

            if (trim(FieldByName('NFL_SERIE').AsString) <> '') AND
               (trim(FieldByName('NFL_SERIE').AsString) <> '0') then
              wregistro51.Serie := FieldbyName('NFL_SERIE').AsString
            else
              wregistro51.Serie := '1';
            wregistro51.Numero := COPY(FieldByName('NFL_NUMERO').AsString, 1, 6);
            wregistro51.Cfop := FieldByName('NFL_CFOP').AsString;

            wregistro51.ValorContabil := FieldByName('NFL_VL_TL_NOTA').AsCurrency;
            wregistro51.ValorIpi := FieldByName('NFL_VL_IPI').AsCurrency;
            wregistro51.ValorIsentas := 0;
            wregistro51.ValorOutras := 0;
            if FieldByName('NFL_STATUS').AsString <> 'C' then
              wregistro51.Situacao := 'N'
            else
              wregistro51.Situacao := 'S';
            end;
          ACBrSintegra.Registros51.Add(wregistro51);
          end;
        end;
      Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
      Application.ProcessMessages;
      Qr_Registro.Next;
    end;
  end;
end;


procedure TFr_Sintegra.GerarRegistro53;
var
  wregistro53: TRegistro53;
begin
  Lb_Processamento.Caption := 'Abrindo Tabelas de Notas';
  Application.ProcessMessages;

  Qr_Registro53.Active := False;
  Qr_Registro53.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
  Qr_Registro53.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
  Qr_Registro53.ParamByName('NFL_CODMHA').AsInteger:=Gb_CodMha;
  Qr_Registro53.Active := True;
  Qr_Registro53.FetchAll;
  Qr_Registro53.First;
  Gg_Progresso.MinValue := 1;
  Gg_Progresso.MaxValue := Qr_Registro.RecordCount;
  Lb_Processamento.Caption := 'Processando Registro 53';
  if not Qr_Registro53.IsEmpty then
    begin
    while not Qr_Registro53.Eof do
      begin
      with ACBrSintegra do
        begin
          wregistro53 := TRegistro53.Create;
          wregistro53.CPFCNPJ := fc_MascaraCNPJ(Qr_Registro53.FieldByName('EMP_CNPJ').AsString);
          if Qr_Registro53.FieldByName('EMP_PESSOA').AsString = 'J' then
            wregistro53.Inscricao := Qr_Registro53.FieldByName('EMP_INSC_EST').AsString
          else
            wregistro53.Inscricao := 'ISENTO';
          wregistro53.DataDocumento := Qr_Registro53.FieldByName('NFL_DT_EMISSAO').AsDateTime;
          wregistro53.Estado := Qr_Registro53.FieldByName('UFE_SIGLA').AsString;
          IF (Trim(Qr_Registro53.FieldbyName('NFL_MODELO').AsString) <> '') and
             (Trim(Qr_Registro53.FieldbyName('NFL_MODELO').AsString) <> '00') then
            wregistro53.Modelo := Qr_Registro53.FieldbyName('NFL_MODELO').AsString
          else
            wregistro53.Modelo := '01';

         if (trim(Qr_Registro53.FieldByName('NFL_SERIE').AsString) <> '') AND
             (trim(Qr_Registro53.FieldByName('NFL_SERIE').AsString) <> '0') then
            wregistro53.Serie := Qr_Registro53.FieldbyName('NFL_SERIE').AsString
          else
            wregistro53.Serie := '1';

          wregistro53.Numero := COPY(Qr_Registro53.FieldByName('NFL_NUMERO').AsString, 1, 6);
          wregistro53.Cfop := Qr_Registro53.FieldByName('NAT_CFOP').AsString;
          if Qr_Registro53.FieldByName('NFL_TIPO').AsString = 'SI' then
            wregistro53.Emitente := 'P'
          else
            wregistro53.Emitente := 'T';
          wregistro53.BaseST := Qr_Registro53.FieldByName('NFL_BS_ICMS_SUBST').AsCurrency;
          wregistro53.IcmsRetido := Qr_Registro53.FieldByName('NFL_VL_ICMS_SUBST').AsCurrency;
          wregistro53.Despesas := Qr_Registro53.FieldByName('NFL_VL_DESP_ACESS').AsCurrency;
          if Qr_Registro53.FieldByName('NFL_STATUS').AsString <> 'C' then
            wregistro53.Situacao := 'N'
          else
            wregistro53.Situacao := 'S';

          if (Qr_Registro53.FieldByName('NFL_TIPO').AsString = 'EE') and (Qr_Registro53.FieldByName('NFL_VL_ICMS_SUBST').AsCurrency > 0) then
          begin
            wregistro53.CodigoAntecipacao := '4';
          end
          else
          begin
            if (Qr_Registro53.FieldByName('NFL_TIPO').AsString = 'SI') and (Qr_Registro53.FieldByName('NFL_VL_ICMS_SUBST').AsCurrency > 0) then
            begin
              wregistro53.CodigoAntecipacao := '3';
            end
            else
            begin
              wregistro53.CodigoAntecipacao := '';
            end;
          end;
          ACBrSintegra.Registros53.Add(wregistro53);
        end;
      Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
      Application.ProcessMessages;
      Qr_Registro53.Next;
      end;
    end;
end;

procedure TFr_Sintegra.Pc_AbreItensRegistro;
Begin
  with Qr_ItensRegistro do
  Begin
    Active := False;
    sql.Clear;
    sql.Add('SELECT DISTINCT '+
            'EMP_PESSOA, '+
            'EMP_CNPJ, '+
            'NAT_CFOP, '+
            'NFL_MODELO, '+
            'NFL_SERIE, '+
            'NFL_NUMERO, '+
            'NFL_TIPO, '+
            'PRO_DESCRICAO, '+
            'PRO_CODIGONCM, '+
            'MED_ABREVIATURA, '+
            'ITF_CODIGO, '+
            'ITF_CODPRO, '+
            'ITF_QTDE, '+
            '(ITF_QTDE * ITF_VL_UNIT) ITF_VL_PRODUTO, '+
            'ITF_VL_DESC, '+
            'ICM_VL_BC_NR, '+
            'ICM_VL_NR, '+
            '( (IPI_VL_BC * IPI_AQ_NR) /100) IPI_VL_IPI, '+
            'ICM_VL_BC_ST, '+
            'ICM_AQ_NR, '+
            'nr.TBI_GRUPO nr_cst, '+
            'sn.TBI_GRUPO sn_cst, '+
            'ICM_ORIGEM '+
            'FROM TB_NOTA_FISCAL '+
            '   INNER JOIN TB_PEDIDO '+
            '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
            '   INNER JOIN TB_EMPRESA '+
            '   ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
            '   INNER JOIN TB_ITENS_NFL '+
            '   ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO ) '+
            '   INNER JOIN TB_ITENS_ICMS '+
            '   ON (tb_itens_icms.ICM_CODITF = tb_itens_nfl.ITF_CODIGO ) '+
            '   INNER JOIN TB_NATUREZA '+
            '   ON (tb_natureza.NAT_CODIGO = tb_itens_icms.ICM_CODNAT) '+
            '   LEFT OUTER JOIN tb_trib_icms_nr nr '+
            '   ON (nr.TBI_CODIGO = ICM_CODTBI_NR) '+
            '   LEFT OUTER JOIN tb_trib_icms_sn sn '+
            '   ON (sn.TBI_CODIGO = ICM_CODTBI_SN) '+
            '   LEFT OUTER JOIN TB_ITENS_IPI '+
            '   ON (tb_itens_ipi.IPI_CODITF = tb_itens_nfl.ITF_CODIGO ) '+
            '   INNER JOIN TB_PRODUTO '+
            '   ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) '+
            '   INNER JOIN TB_MEDIDA '+
            '   ON (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED) '+
            'WHERE NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM '+
            '  AND (NFL_NUMERO <> '''') '+
            '  AND (NFL_NUMERO <> ''0'') '+
            '  AND ((NAT_REGISTRO = 0) OR (NAT_REGISTRO IS NULL)) '+
            '  AND NFL_CODMHA =:NFL_CODMHA '+
            'ORDER BY NFL_CODIGO, ITF_CODIGO ');

    ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
    ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    ParamByName('NFL_CODMHA').AsInteger:=Gb_CodMha;
    Active := True;
    FetchAll;
    First;
  end;
end;

procedure TFr_Sintegra.GerarRegistro54;
var
  wregistro54: TRegistro54;
  wregistro75: TRegistro75;
  Lc_Item: Integer;
  Lc_Nr_Nota: string;
begin
  Lb_Processamento.Caption := 'Abrindo Tabelas de Notas';
  Application.ProcessMessages;
  Pc_AbreItensRegistro;
  Gg_Progresso.MinValue := 1;
  Gg_Progresso.MaxValue := Qr_ItensRegistro.RecordCount;
  Lb_Processamento.Caption := 'Processando Registro 54 e 75';
  with ACBrSintegra,Qr_ItensRegistro do
  begin
    if not IsEmpty then
    begin
      Lc_Item := 0;
      Lc_Nr_Nota := Qr_ItensRegistro.FieldByName('NFL_NUMERO').AsString;
      while not Eof do
      begin
        if Lc_Nr_Nota = Qr_ItensRegistro.FieldByName('NFL_NUMERO').AsString then
        begin
          Inc(Lc_Item)
        end
        else
        begin
          Lc_Item := 1;
          Lc_Nr_Nota := Qr_ItensRegistro.FieldByName('NFL_NUMERO').AsString;
        end;
        wregistro54 := TRegistro54.Create;
        wregistro54.CPFCNPJ := fc_MascaraCNPJ(Qr_ItensRegistro.FieldByName('EMP_CNPJ').AsString);
        IF (Trim(Qr_ItensRegistro.FieldByName('NFL_MODELO').AsString) = '') OR (Trim(Qr_ItensRegistro.FieldByName('NFL_MODELO').AsString) = '00') then
          wregistro54.Modelo := '01'
        else
          wregistro54.Modelo := Qr_ItensRegistro.FieldByName('NFL_MODELO').AsString;
        if (trim(Qr_ItensRegistro.FieldByName('NFL_SERIE').AsString) <> '') AND
           (trim(Qr_ItensRegistro.FieldByName('NFL_SERIE').AsString) <> '0') then
          wregistro54.Serie := Qr_ItensRegistro.FieldByName('NFL_SERIE').AsString
        else
          wregistro54.Serie := '1';
        wregistro54.Numero := COPY(Qr_ItensRegistro.FieldByName('NFL_NUMERO').AsString, 1, 6);
        wregistro54.Cfop := Qr_ItensRegistro.FieldByName('NAT_CFOP').AsString;
        if ( Length( Trim(Qr_ItensRegistro.FieldByName('nr_cst').AsString) )>0 ) then
        Begin
          wregistro54.CST := Qr_ItensRegistro.FieldByName('ICM_ORIGEM').AsString + Qr_ItensRegistro.FieldByName('nr_cst').AsString;
        End
        else
        Begin
          wregistro54.CST := Qr_ItensRegistro.FieldByName('ICM_ORIGEM').AsString + Qr_ItensRegistro.FieldByName('sn_cst').AsString;
        End;
        wregistro54.NumeroItem := Lc_Item;
        wregistro54.Codigo := StrZero(Qr_ItensRegistro.FieldByName('ITF_CODPRO').AsInteger,14,0);
        wregistro54.Descricao := Qr_ItensRegistro.FieldByName('PRO_DESCRICAO').AsString;
        wregistro54.Quantidade := Qr_ItensRegistro.FieldByName('ITF_QTDE').AsFloat;
        wregistro54.Valor := Qr_ItensRegistro.FieldByName('ITF_VL_PRODUTO').AsCurrency;
        wregistro54.ValorDescontoDespesa := Qr_ItensRegistro.FieldByName('ITF_VL_DESC').AsCurrency;
        wregistro54.BasedeCalculo := Qr_ItensRegistro.FieldByName('ICM_VL_BC_NR').AsCurrency;

        wregistro54.BasedeCalculo := Qr_ItensRegistro.FieldByName('ICM_VL_BC_NR').AsCurrency;
        wregistro54.Aliquota := Qr_ItensRegistro.FieldByName('ICM_AQ_NR').AsFloat;
        {
        if it_Cd_Crt = 3 then
        Begin
          wregistro54.BasedeCalculo := Qr_ItensRegistro.FieldByName('ICM_VL_BC_NR').AsCurrency;
          wregistro54.Aliquota := Qr_ItensRegistro.FieldByName('ICM_AQ_NR').AsFloat;
        end
        else
        Begin
          wregistro54.BasedeCalculo := 0;
          wregistro54.Aliquota := 0;
        end;
        }
        wregistro54.BaseST := Qr_ItensRegistro.FieldByName('ICM_VL_BC_ST').AsCurrency;
        wregistro54.ValorIpi := Qr_ItensRegistro.FieldByName('IPI_VL_IPI').AsCurrency;
        {11.1.12.1. Colocar o valor da base de cálculo do ICMS, quando não se tratar de operação ou prestação com
                    substituição tributária;}
        ACBrSintegra.Registros54.Add(wregistro54);
        //tratamento especifigo para o registro 75
        wregistro75 := TRegistro75.Create;
        wregistro75.Codigo := StrZero(Qr_ItensRegistro.FieldByName('ITF_CODPRO').AsInteger,14,0);
        wregistro75.AliquotaICMS := wregistro54.Aliquota;
        wregistro75.DataInicial := ACBrSintegra.Registro10.DataInicial;
        wregistro75.DataFinal := ACBrSintegra.Registro10.DataFinal;
        wregistro75.Descricao := Qr_ItensRegistro.FieldByName('PRO_DESCRICAO').AsString;
        wregistro75.Unidade := Qr_ItensRegistro.FieldByName('MED_ABREVIATURA').AsString;
        wregistro75.NCM := Qr_ItensRegistro.FieldByName('PRO_CODIGONCM').AsString;
        if Qr_ItensRegistro.FieldByName('ICM_VL_BC_ST').AsCurrency > 0 then
          wregistro75.BaseST := Qr_ItensRegistro.FieldByName('ICM_VL_BC_NR').AsCurrency
        else
          wregistro75.BaseST := 0;
        ACBrSintegra.Registros75.Add(wregistro75);
        Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
      end;
    end;
  end;
end;


procedure TFr_Sintegra.ChLBx_RegistroClick(Sender: TObject);
begin
  //Alterado  no dia 12/01/20018 para gerar somente qt maior que zero
  if ChLBx_Registro.Checked[6]  then
  Begin
    with Qr_Inventario do
    Begin
      Active := False;
      ParamByName('IVT_CODMHA').AsInteger := Gb_CodMha;
      Active := True;
      Last;
    end;
  End;
end;

function TFr_Sintegra.Fc_ECF_SequenciaCOO(Fc_Tipo:String;Fc_Dia:TDate):Integer;
Begin
  Qr_Acao.Active := False;
  Qr_Acao.SQL.Clear;
  if (Fc_Tipo = 'P') then //Primeiro
    Qr_Acao.SQL.Add('select Min(PED_NUMERO) PEDIDO ')
  else                    //Segundo
    Qr_Acao.SQL.Add('select Min(PED_NUMERO) PEDIDO ');
  Qr_Acao.SQL.Add('FROM TB_PEDIDO '+
                  '  INNER JOIN TB_NOTA_FISCAL '+
                  '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
                  'WHERE (PED_TIPO = 1) AND (PED_FATURADO = ''S'') '+
                  'AND (NFL_DT_EMISSAO =:NFL_DT_EMISSAO) ');
  Qr_Acao.ParamByName('NFL_DT_EMISSAO').AsDate := Fc_Dia;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Result := Qr_Acao.FieldByname('PEDIDO').AsInteger;
end;

function TFr_Sintegra.Fc_ECF_VendaBruta(Fc_Dia:TDate):Real;
Begin
  Qr_Acao.Active := False;
  Qr_Acao.SQL.Clear;
  Qr_Acao.SQL.Add('select Sum(NFL_VL_TL_NOTA) TOTAL '+
                  'FROM TB_PEDIDO '+
                  '  INNER JOIN TB_NOTA_FISCAL '+
                  '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
                  'WHERE (PED_TIPO = 1) AND (PED_FATURADO = ''S'') '+
                  'AND (NFL_DT_EMISSAO =:NFL_DT_EMISSAO) ');
  Qr_Acao.ParamByName('NFL_DT_EMISSAO').AsDate := Fc_Dia;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Result := Qr_Acao.FieldByname('TOTAL').AsCurrency;
end;
procedure TFr_Sintegra.GerarRegistro60M;
var
  wregistro60M: TRegistro60M;
  wregistro60A: TRegistro60A;
  wregistro60R: TRegistro60R;
  wregistro75 : TRegistro75;
  Lc_Qry : TSTQuery;
  Lc_Sqltxt : String;
begin
  Lc_Qry := TSTQuery.Create(Fr_Sintegra);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;

    //Registro 60M
    Active := False;
    SQL.Clear;
    Lc_Sqltxt := 'SELECT DISTINCT '+
                 'PED_DATA, '+
                 'PED_VL_PRODUTO, '+
                 'PED_VL_PEDIDO, '+
                 'ECF_CODNSF, '+
                 'ECF_EQPSEQ, '+
                 'ECF_CODPED, '+
                 'ECF_MOD_DOC_FIS, '+
                 'ECF_COO_INI, '+
                 'ECF_COO_FIM, '+
                 'ECF_NR_CRZ, '+
                 'ECF_NR_CRO '+
                 'FROM TB_PEDIDO '+
                 '  INNER JOIN TB_VENDAS_ECF '+
                 '  ON (PED_CODIGO = ECF_CODPED) '+
                 'WHERE PED_DATA BETWEEN :DATAINI AND :DATAFIM '+
                 'ORDER  BY  PED_DATA,ECF_CODNSF ';
    SQL.Add(Lc_Sqltxt);
    ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
    ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    Active := True;
    FetchAll;
    if (RecordCount > 0) then
      Begin
      while not eof do
        Begin
        //60M
        wregistro60M := TRegistro60M.Create;
        wregistro60M.Emissao := FieldByName('PED_DATA').AsDateTime;
        wregistro60M.NumSerie := FieldByName('ECF_CODNSF').AsString;
        wregistro60M.NumOrdem := FieldByName('ECF_EQPSEQ').AsInteger;
        wregistro60M.ModeloDoc := FieldByName('ECF_MOD_DOC_FIS').AsString;
        wregistro60M.CooInicial :=FieldByName('ECF_COO_INI').AsInteger;
        wregistro60M.CooFinal := FieldByName('ECF_COO_FIM').AsInteger;
        wregistro60M.CRZ := FieldByName('ECF_NR_CRZ').AsInteger;
        wregistro60M.CRO := FieldByName('ECF_NR_CRO').AsInteger;
        wregistro60M.VendaBruta := FieldByName('PED_VL_PEDIDO').AsCurrency;
        wregistro60M.ValorGT := FieldByName('PED_VL_PEDIDO').AsCurrency;
        ACBrSintegra.Registros60M.Add(wregistro60M);
        Next;
        end;
      end;
    //Registro 60A
    Active := False;
    SQL.Clear;
    Lc_Sqltxt := 'SELECT DISTINCT '+
                 'PED_DATA, '+
                 'PED_VL_PRODUTO, '+
                 'PED_VL_PEDIDO, '+
                 'ECF_CODNSF, '+
                 'ECF_EQPSEQ, '+
                 'ECF_CODPED, '+
                 'ECF_MOD_DOC_FIS, '+
                 'ECF_COO_INI, '+
                 'ECF_COO_FIM, '+
                 'ECF_NR_CRZ, '+
                 'ECF_NR_CRO, '+
                 'ECF_SIT_TRIB, '+
                 'ECF_VL_PARCIAL '+
                 'FROM TB_PEDIDO '+
                 '   INNER JOIN TB_VENDAS_ECF '+
                 '   ON (PED_CODIGO = ECF_CODPED) '+
                 'WHERE PED_DATA BETWEEN :DATAINI AND :DATAFIM '+
                 'ORDER BY PED_DATA,ECF_CODNSF ';
    SQL.Add(Lc_Sqltxt);
    ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
    ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    Active := True;
    FetchAll;
    if (RecordCount > 0) then
      Begin
      while not eof do
        Begin
        wregistro60A := TRegistro60A.Create;
        wregistro60A.Emissao := FieldByName('PED_DATA').AsDateTime;
        wregistro60A.NumSerie := FieldByName('ECF_CODNSF').AsString;
        wregistro60A.StAliquota := FieldByName('ECF_SIT_TRIB').AsString;
        wregistro60A.Valor := FieldByName('ECF_VL_PARCIAL').AsCurrency;
        ACBrSintegra.Registros60A.Add(wregistro60A);
        Next;
        end;
      end
    else
      Begin
      ShowMessage('sem registro');
      Exit;
      end;
    //Executa outra consulta para o resumo Mensal - //60R
    Active := False;
    SQL.Clear;
    Lc_Sqltxt := 'select DISTINCT '+
                 ' PED_DATA, '+
                 ' ITF_CODPRO, '+
                 ' PRO_DESCRICAO, '+
                 ' PRO_CODIGONCM,'+
                 ' MED_ABREVIATURA, '+
                 ' ITF_QTDE, '+
                 ' ITF_VL_UNIT, '+
                 ' ICM_VL_BC_NR, '+
                 ' ICM_AQ_NR, '+
                 ' ICM_VL_BC_ST, '+
                 ' ECF_SIT_TRIB '+
                 ' from tb_pedido '+
                 '    INNER JOIN tb_itens_nfl '+
                 '    ON (tb_itens_nfl.ITF_CODPED = tb_pedido.PED_CODIGO) '+
                 '    INNER JOIN tb_itens_icms '+
                 '    ON (tb_itens_icms.icm_coditf = tb_itens_nfl.ITF_CODIGO) '+
                 '    INNER JOIN TB_PRODUTO '+
                 '    ON (PRO_CODIGO = ITF_CODPRO) '+
                 '    INNER JOIN TB_MEDIDA '+
                 '    ON (MED_CODIGO = PRO_CODMED) '+
                 '    INNER JOIN TB_VENDAS_ECF '+
                 '    ON (tb_pedido.PED_CODIGO = tb_vendas_ecf.ECF_CODPED) '+
                 'WHERE  PED_DATA BETWEEN :DATAINI AND :DATAFIM '+
                 'ORDER BY 2 ';
    SQL.Add(Lc_Sqltxt);
    ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
    ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    Active := True;
    FetchAll;
    if (RecordCount > 0) then
      Begin
      while not eof do
        Begin
        wregistro60R := TRegistro60R.Create;
        wregistro60R.MesAno := copy(FieldByName('PED_DATA').AsString,4,2) + copy(FieldByName('PED_DATA').AsString,7,4);
        wregistro60R.Codigo := StrZero(FieldByName('ITF_CODPRO').AsInteger,14,0);
        wregistro60R.Qtd := FieldByName('ITF_QTDE').AsFloat;
        wregistro60R.Valor := FieldByName('ITF_VL_UNIT').AsCurrency;
        wregistro60R.BaseDeCalculo := FieldByName('ICM_VL_BC_NR').AsCurrency;
        wregistro60R.Aliquota := FieldByName('ECF_SIT_TRIB').AsString;
        ACBrSintegra.Registros60R.Add(wregistro60R);

        //tratamento especifigo para o registro 75
        wregistro75 := TRegistro75.Create;
        wregistro75.Codigo := StrZero(FieldByName('ITF_CODPRO').AsInteger,14,0);
        wregistro75.AliquotaICMS := FieldByName('ICM_AQ_NR').AsFloat;
        wregistro75.DataInicial := ACBrSintegra.Registro10.DataInicial;
        wregistro75.DataFinal := ACBrSintegra.Registro10.DataFinal;
        wregistro75.Descricao := FieldByName('PRO_DESCRICAO').AsString;
        wregistro75.Unidade := FieldByName('MED_ABREVIATURA').AsString;
        wregistro75.NCM := FieldByName('PRO_CODIGONCM').AsString;
        if FieldByName('ICM_VL_BC_ST').AsCurrency > 0 then
          Begin
          wregistro75.BaseST := FieldByName('ICM_VL_BC_ST').AsCurrency;
          end
        else
          Begin
          wregistro75.BaseST := 0;
          end;
        ACBrSintegra.Registros75.Add(wregistro75);

        Next;
        end;
      end;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;



procedure TFr_Sintegra.GerarRegistro70;
var
  wregistro70: TRegistro70;
  Lc_Item: Integer;
  Lc_Nr_Nota: string;
begin
  Lb_Processamento.Caption := 'Abrindo Tabelas de Notas';
  Application.ProcessMessages;

  Qr_Registro70.Active := False;
  Qr_Registro70.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
  Qr_Registro70.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
  Qr_Registro70.ParamByName('NFL_CODMHA').AsInteger:=Gb_CodMha;
  Qr_Registro70.Active := True;
  Qr_Registro70.FetchAll;
  if Qr_Registro70.RecordCount = 0 then
    exit;
  Qr_Registro70.First;
  Gg_Progresso.MinValue := 1;
  Gg_Progresso.MaxValue := Qr_Registro70.RecordCount;
  Lb_Processamento.Caption := 'Processando Registro 70';
  if not Qr_Registro70.IsEmpty then
  begin
    Lc_Item := 0;
    Lc_Nr_Nota := Qr_Registro70.FieldByName('NFL_NUMERO').AsString;
    while not Qr_Registro70.Eof do
    begin
      with ACBrSintegra do
      begin
        if Lc_Nr_Nota = Qr_Registro70.FieldByName('NFL_NUMERO').AsString then
        begin
          Inc(Lc_Item)
        end
        else
        begin
          Lc_Item := 1;
          Lc_Nr_Nota := Qr_Registro70.FieldByName('NFL_NUMERO').AsString;
        end;
        wregistro70 := TRegistro70.Create;

        wregistro70.CPFCNPJ := fc_MascaraCNPJ(Qr_Registro70.FieldByName('eMP_CNPJ').AsString);
        wregistro70.Inscricao := Qr_Registro70.FieldByName('EMP_INSC_EST').AsString;
        wregistro70.DataDocumento := Qr_Registro70.FieldByName('NFL_DT_EMISSAO').AsDateTime;
        wregistro70.UF := Qr_Registro70.FieldByName('UFE_SIGLA').AsString;

        IF (Trim(Qr_Registro70.FieldbyName('NFL_MODELO').AsString) <> '') and
           (Trim(Qr_Registro70.FieldbyName('NFL_MODELO').AsString) <> '00') then
          wregistro70.Modelo := Qr_Registro70.FieldbyName('NFL_MODELO').AsString
        else
          wregistro70.Modelo := '01';

       if (trim(Qr_Registro70.FieldByName('NFL_SERIE').AsString) <> '') AND
           (trim(Qr_Registro70.FieldByName('NFL_SERIE').AsString) <> '0') then
          wregistro70.Serie := Qr_Registro70.FieldbyName('NFL_SERIE').AsString
        else
          wregistro70.Serie := '1';
        wregistro70.SubSerie := '';
        wregistro70.Numero := COPY(Qr_Registro70.FieldByName('NFL_NUMERO').AsString, 1, 6);
        wregistro70.Cfop := Qr_Registro70.FieldByName('NAT_CFOP').AsString;
        wregistro70.ValorContabil := Qr_Registro70.FieldByName('NFL_VL_TL_NOTA').AsCurrency;
        wregistro70.BasedeCalculo := Qr_Registro70.FieldByName('NFL_BS_ICMS').AsCurrency;
        wregistro70.Icms := Qr_Registro70.FieldByName('NFL_VL_ICMS').AsCurrency;
        wregistro70.Isentas := 0;
        wregistro70.Outras := Qr_Registro70.FieldByName('NFL_VL_DESP_ACESS').AsCurrency;
        if Qr_Registro70.FieldByName('NFL_CTA_FRETE').AsInteger = 0 then
          wregistro70.CifFobOutros := '1'
        else
          wregistro70.CifFobOutros := '2';
        wregistro70.Situacao := 'N';
        ACBrSintegra.Registros70.Add(wregistro70);

      end;
      Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
      Application.ProcessMessages;
      Qr_Registro70.Next;
    end;
  end;


end;

procedure TFr_Sintegra.GerarRegistro74;
var
  lc_Qry : TSTQuery;
  wregistro74: TRegistro74;
  wregistro75: TRegistro75;
  Lc_Item: Integer;
  Lc_Nr_Nota: string;
begin
  try
    lc_Qry := TSTQuery.Create(nil);
    with lc_Qry do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      ForcedRefresh := True;

      SQL.Clear;
      SQL.Add('SELECT DISTINCT '+
              '  IVT_DATA, '+
              '  IVT_CODPRO, '+
              '  PRO_DESCRICAO, '+
              '  MED_ABREVIATURA, '+
              '  IVT_QT_ATUAL, '+
              '  IVT_VL_CUSTO '+
              'FROM TB_INVENTARIO tb_inventario '+
              '  INNER JOIN TB_PRODUTO tb_produto '+
              '  ON (tb_produto.PRO_CODIGO = tb_inventario.IVT_CODPRO)  '+
              '  INNER JOIN TB_MEDIDA tb_medida '+
              '  ON (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED) '+
              'WHERE IVT_DATA =:IVT_DATA '+
              '  AND IVT_CODMHA=:IVT_CODMHA AND (IVT_QT_ATUAL >0) '+
              'ORDER BY IVT_DATA, IVT_CODPRO');

      Active := False;
      ParamByName('IVT_DATA').AsDateTime := Qr_Inventario.FieldByName('IVT_DATA').AsDateTime;
      ParamByName('IVT_CODMHA').AsInteger := Gb_CodMha;
      Active := True;
      FetchAll;
      if RecordCount = 0 then exit;

      First;
      Gg_Progresso.Progress := 0;
      Gg_Progresso.MinValue := 1;
      Gg_Progresso.MaxValue :=  RecordCount;
      Lb_Processamento.Caption := 'Processando Registro 74';
      Application.ProcessMessages;
      while not Eof do
        begin
        with ACBrSintegra do
          begin
          wregistro74 := TRegistro74.Create;
          wregistro74.Data := FieldByname('IVT_DATA').AsDateTime;
          wregistro74.Codigo := StrZero(FieldByname('IVT_CODPRO').AsInteger,14,0);
          wregistro74.Quantidade := FieldByname('IVT_QT_ATUAL').AsFloat;
          wregistro74.ValorProduto := FieldByname('IVT_VL_CUSTO').AsCurrency;
          wregistro74.CodigoPosse := '1';
          wregistro74.CNPJPossuidor := '';
          wregistro74.InscricaoPossuidor := '';
          wregistro74.UFPossuidor := DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString;
          ACBrSintegra.Registros74.Add(wregistro74);

          wregistro75 := TRegistro75.Create;
          wregistro75.Codigo := StrZero(StrToFloatDef(wregistro74.Codigo,0),14,0);
          wregistro75.AliquotaICMS := 0;
          wregistro75.DataInicial := ACBrSintegra.Registro10.DataInicial;
          wregistro75.DataFinal := ACBrSintegra.Registro10.DataFinal;
          wregistro75.Descricao := FieldByname('PRO_DESCRICAO').AsString;
          wregistro75.Unidade := FieldByname('MED_ABREVIATURA').AsString;
          ACBrSintegra.Registros75.Add(wregistro75);
          end;
        Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
        Application.ProcessMessages;
        Next;
        end;
      end;
  finally
    lc_Qry.Close;
    FreeAndNil(lc_Qry);
  end;
end;


procedure TFr_Sintegra.GerarRegistro85;
var
  wregistro85: TRegistro85;
  Lc_Qry_Registro: TSTQuery;
  Lc_SqlTxt: string;
begin
  wregistro85 := TRegistro85.Create;
  wregistro85.Declaracao := '';
  wregistro85.DataDeclaracao := Date;
  wregistro85.NaturezaExportacao := '';
  wregistro85.RegistroExportacao := '00000000001';
  wregistro85.DataRegistro := Date;
  wregistro85.Conhecimento := 'CONHECIMENTO';
  wregistro85.DataConhecimento := Date;
  wregistro85.TipoConhecimento := '';
  wregistro85.Pais := '1058';
  wregistro85.DataAverbacao := Date;
  wregistro85.NumeroNotaFiscal := '0015';
  wregistro85.DataNotaFiscal := Date;
  wregistro85.Modelo := '1';
  wregistro85.Serie := '3';
  ACBrSintegra.Registros85.Add(wregistro85);
end;

procedure TFr_Sintegra.GerarRegistro86;
var
  wregistro86: TRegistro86;
  Lc_Qry_Registro: TSTQuery;
  Lc_SqlTxt: string;
begin
  wregistro86 := TRegistro86.Create;
  wregistro86.RegistroExportacao := '00000000001';
  wregistro86.DataRegistro := DATE;
  wregistro86.CPFCNPJ := '77828226000100';
  wregistro86.Inscricao := '1012228100';
  wregistro86.UF := 'PR';
  wregistro86.NumeroNotaFiscal := '0000';
  wregistro86.DataDocumento := DATE;
  wregistro86.Modelo := '1';
  wregistro86.Serie := '3';
  wregistro86.Codigo := '1';
  wregistro86.Quantidade := 5;
  wregistro86.ValorUnitario := 1530;
  wregistro86.ValorTotalProduto := 7650;
  wregistro86.Relacionamento := '0';
  ACBrSintegra.Registros86.Add(wregistro86);
end;

procedure TFr_Sintegra.SB_GerarClick(Sender: TObject);
begin
  SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  if SaveDialog1.Execute then
  begin
    if Fc_ValidaSintegra then
      Pc_GeraSintegraNormal;
  end;
end;

procedure TFr_Sintegra.SB_SairClick(Sender: TObject);
begin
  Close;
end;

function TFr_Sintegra.Fc_ValidaSintegra: Boolean;
begin
  Result := True;
  if E_Responsavel.text = '' then
    begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Informe o nome do responsável.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    IF E_Responsavel.CanFocus then E_Responsavel.setfocus;
    Result := False;
    exit;
    end;

  if (E_Data_Fim.Date < E_Data_Ini.Date) then
    begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Data Final não pode ser menor que a inicial.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    if E_Data_Fim.CanFocus then E_Data_Fim.setfocus;
    Result := False;
    exit;
    end;

  if (E_Data_Fim.Date > date) then
    begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Data Final não pode ser maior que a data atual.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    if E_Data_Fim.CanFocus then E_Data_Fim.setfocus;
    Result := False;
    exit;
    end;
end;

Function TFr_Sintegra.Fc_VerificaRegistro:iNTEGER;
begin
  with Qr_Registro do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT '+
            '  PED_TIPO, '+
            '  EMP_PESSOA, '+
            '  EMP_CNPJ, '+
            '  EMP_INSC_EST, '+
            '  EMP_NOME, '+
            '  UFE_SIGLA, '+
            '  NFL_DT_EMISSAO, '+
            '  NFL_STATUS, '+
            '  NFL_TIPO, '+
            '  NFL_MODELO, '+
            '  NFL_SERIE, '+
            '  NFL_NUMERO, '+
            '  tb_natureza.nat_cfop, '+
            '  icms.ICM_AQ_NR, '+
            '  SUM(((itens.itf_qtde * itens.itf_vl_unit) - itens.itf_vl_desc)) ITF_VL_PRODUTO, '+
            '  SUM(icms.icm_vl_frete) icm_vl_frete, '+
            '  SUM(icms.icm_vl_seguro) icm_vl_seguro, '+
            '  SUM(icms.icm_vl_outras) icm_vl_outras, '+
            '  SUM(icms.ICM_VL_ST) ICM_VL_ST, '+
            '  SUM( ( ( ipi.ipi_vl_bc * ipi.ipi_aq_nr ) /100 ) ) IPI_VALOR, '+
            '  SUM(icms.ICM_VL_BC_NR) ICM_VL_BC_NR '+
            '  FROM TB_NOTA_FISCAL tb_nota_fiscal '+
            '     INNER JOIN TB_PEDIDO tb_pedido '+
            '     ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
            '     INNER JOIN TB_EMPRESA tb_empresa '+
            '    ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
            '     INNER JOIN TB_ENDERECO tb_endereco '+
            '    ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND) '+
            '     INNER JOIN TB_UF tb_uf '+
            '    ON (tb_endereco.END_CODUFE = tb_uf.UFE_CODIGO) '+
            '     INNER JOIN TB_ITENS_NFL itens '+
            '     ON (itens.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO ) '+
            '     INNER JOIN TB_ITENS_ICMS icms  '+
            '     ON (icms.ICM_CODITF = itens.ITF_CODIGO ) '+
            '     INNER JOIN TB_NATUREZA tb_natureza '+
            '     ON (tb_natureza.NAT_CODIGO = icms.ICM_CODNAT) '+
            '     LEFT OUTER JOIN TB_ITENS_IPI ipi '+
            '     ON (ipi.IPI_CODITF = itens.ITF_CODIGO ) '+
            '     INNER JOIN TB_PRODUTO tb_produto '+
            '    ON (tb_produto.PRO_CODIGO = itens.ITF_CODPRO) '+
            '  WHERE NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM '+
            '    AND (NFL_NUMERO <> '''') '+
            '    AND (NFL_NUMERO <> ''0'') '+
            '    AND ((NAT_REGISTRO = 0) OR (NAT_REGISTRO IS NULL)) '+
            '    AND (NFL_CODMHA=:NFL_CODMHA) '+
            '  GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14 '+
            '  ORDER BY NFL_DT_EMISSAO, NFL_NUMERO');

    ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
    ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    Active := True;
    FetchAll;
    Result:= RecordCount;
  end;
end;


procedure TFr_Sintegra.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Pc_GravaParametros;
end;

procedure TFr_Sintegra.FormShow(Sender: TObject);
begin
  Pc_IniciaVariavel;
end;

end.

