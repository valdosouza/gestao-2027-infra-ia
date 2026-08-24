unit Un_SPEDPisCofins;

{$IFDEF FPC}
  {$mode objfpc}{$H+}
{$ENDIF}

interface

uses
    {$IFNDEF FPC}
  Windows, Messages, {$ENDIF}
  SysUtils, Variants, Classes, Graphics, Controls, Forms, ACBrEPCBlocos, Dialogs, StdCtrls, ACBrSpedPisCofins, ExtCtrls, ComCtrls, ACBrUtil, ACBrTXTClass, DB, STQuery, Buttons, Gauges, System.Math, DBCtrls, ACBrBase;

type
    
  { TFrmSPEDPisCofins }

  TFr_SPEDPisCofins = class(TForm)
    ACBrSPEDPisCofins1: TACBrSPEDPisCofins;
    Qr_0150: TSTQuery;
    Qr_0190: TSTQuery;
    Qr_0200: TSTQuery;
    Qr_C170: TSTQuery;
    Qr_c100: TSTQuery;
    Panel1: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    GroupBox1: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Cb_Tp_Escrituracao: TComboBox;
    Cb_Indi_Sit_Especial: TComboBox;
    E_Path_Arquivo_SPED: TEdit;
    Label1: TLabel;
    SB_Sair: TSpeedButton;
    SB_Gerar: TSpeedButton;
    Pnl_Progresso: TPanel;
    Gg_Progresso: TGauge;
    Lb_Processamento: TLabel;
    GroupBox2: TGroupBox;
    ChBx_Bloco_A: TLabel;
    ChBx_Bloco_C: TLabel;
    ChBx_Bloco_D: TLabel;
    ChBx_Bloco_F: TLabel;
    ChBx_Bloco_M: TLabel;
    ChBx_Bloco_1: TLabel;
    E_Nr_Rec_Esc_Ant: TEdit;
    Label2: TLabel;
    Qr_0400: TSTQuery;
    Qr_M100: TSTQuery;
    Qr_M105: TSTQuery;
    PageControl1: TPageControl;
    tbs_Bloco_Principal: TTabSheet;
    Pnl_Bloco_000: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Cb_Ind_Nat_Pes_Jur: TComboBox;
    Cb_Ind_Tip_Ati_Prep: TComboBox;
    Cb_Cd_Ind_Inc_trib_Per: TComboBox;
    Cb_Cd_Ind_Tip_Con_Apu_Per: TComboBox;
    Cb_Apro_Cred: TComboBox;
    Cb_Cd_Ind_Cri_Esc_Apu_ado: TComboBox;
    tbs_Blobo_A: TTabSheet;
    Panel3: TPanel;
    tbs_Bloco_C: TTabSheet;
    Panel2: TPanel;
    Label3: TLabel;
    Cb_Ind_Apu_Con_Cre_Esc_Ope_Nfe_ECF: TComboBox;
    tbs_bloco_d: TTabSheet;
    Panel4: TPanel;
    tbs_bloco_F: TTabSheet;
    Panel5: TPanel;
    tb_Bloco_M: TTabSheet;
    Panel6: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Cb_Ind_Op_Uti_Cre_Dis_Per: TComboBox;
    Cb_Cd_Bas_Cal_Credito: TComboBox;
    Dblcb_Situacao_tributaria_PIS: TDBLookupComboBox;
    ChBx_Cst_PIS_Entrada_Padrao: TCheckBox;
    Cb_Cd_Con_Soc_Apu: TComboBox;
    tbs_Bloco_1: TTabSheet;
    Panel7: TPanel;
    procedure SB_SairClick(Sender: TObject);
    procedure SB_GerarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    //Bloco F
    It_F500 :Boolean;
    It_F550 :Boolean;
    It_VL_Rec_Brt_M210 : Real;
  public
    { Public declarations }
    Procedure Pc_IniciaVariaveis;
    procedure Pc_AtivarTabelas;
    procedure Pc_DadosFormulario(Pc_Operacao:String);
    function Fc_validaGeracaoArquivo:Boolean;
    procedure Pc_Bloco_0;
    procedure Pc_Bloco_A;
    procedure Pc_Bloco_C;
    procedure Pc_Bloco_D;
    procedure Pc_Bloco_F;
    procedure Pc_Bloco_M;
    procedure Pc_Bloco_1;
    procedure Pc_Bloco_9;
    procedure Pc_GerarArquivoSPED;
    procedure Pc_GerarArquivoERRO;
  end;

var
  Fr_SPEDPisCofins: TFr_SPEDPisCofins;

implementation

uses
ACBrEPCBloco_0, ACBrEPCBloco_1, ACBrEPCBloco_A, ACBrEPCBloco_C, ACBrEPCBloco_D, ACBrEPCBloco_F, ACBrEPCBloco_M, Un_DM, Un_Regra_Negocio, UN_Sistema, UN_MSG, Un_Funcoes, ACBrEPCBloco_C_Class, ACBrEPCBloco_M_Class, ACBrEPCBloco_A_Class, un_Padrao, un_principal, env;

{$IFDEF FPC}
 {$R *.lfm}
{$ELSE}
 {$R *.dfm}
{$ENDIF}

Procedure TFr_SPEDPisCofins.Pc_IniciaVariaveis;
var
  Lc_dia, Lc_Mes, Lc_Ano: string;
Begin
  //Define Data
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

  // Dados do estabelecimento
  Pc_AtivaEstabelecimento;

  //Inicia  os Primeiros Campos
  Pc_DadosFormulario('L');

  //Controla quais blocos seráo gerados
  It_F500 := False;
  It_F500 := True;
  //Indicador de situação especial
  Cb_Indi_Sit_Especial.ItemIndex := 5;
end;

procedure TFr_SPEDPisCofins.Pc_AtivarTabelas;
Begin
  DM.qr_trib_pis.Active:=false;
  DM.qr_trib_pis.Active:=True;
  DM.qr_trib_pis.FetchAll;
end;

procedure TFr_SPEDPisCofins.Pc_DadosFormulario(Pc_Operacao:String);
Begin
  if (Pc_Operacao = 'L') then
    Begin
    Cb_Tp_Escrituracao.ItemIndex := StrToIntDef(Fc_Tb_Geral('L',Cb_Tp_Escrituracao.Name,IntToStr(Cb_Tp_Escrituracao.ItemIndex)),0);
    Cb_Indi_Sit_Especial.ItemIndex := StrToIntDef(Fc_Tb_Geral('L',Cb_Indi_Sit_Especial.Name,IntToStr(Cb_Indi_Sit_Especial.ItemIndex)),0);
    Cb_Ind_Nat_Pes_Jur.ItemIndex := StrToIntDef(Fc_Tb_Geral('L',Cb_Ind_Nat_Pes_Jur.Name,IntToStr(Cb_Ind_Nat_Pes_Jur.ItemIndex)),0);
    Cb_Ind_Tip_Ati_Prep.ItemIndex := StrToIntDef(Fc_Tb_Geral('L',Cb_Ind_Tip_Ati_Prep.Name,IntToStr(Cb_Ind_Tip_Ati_Prep.ItemIndex)),0);
    Cb_Cd_Ind_Inc_trib_Per.ItemIndex := StrToIntDef(Fc_Tb_Geral('L',Cb_Cd_Ind_Inc_trib_Per.Name,IntToStr(Cb_Cd_Ind_Inc_trib_Per.ItemIndex)),0);
    Cb_Cd_Ind_Tip_Con_Apu_Per.ItemIndex := StrToIntDef(Fc_Tb_Geral('L',Cb_Cd_Ind_Tip_Con_Apu_Per.Name,IntToStr(Cb_Cd_Ind_Tip_Con_Apu_Per.ItemIndex)),0);
    Cb_Apro_Cred.ItemIndex := StrToIntDef(Fc_Tb_Geral('L',Cb_Apro_Cred.Name,IntToStr(Cb_Apro_Cred.ItemIndex)),0);
    Cb_Cd_Ind_Cri_Esc_Apu_ado.ItemIndex := StrToIntDef(Fc_Tb_Geral('L',Cb_Cd_Ind_Cri_Esc_Apu_ado.Name,IntToStr(Cb_Cd_Ind_Cri_Esc_Apu_ado.ItemIndex)),0);
    //Bloco C
    Cb_Ind_Apu_Con_Cre_Esc_Ope_Nfe_ECF.ItemIndex := StrToIntDef(Fc_Tb_Geral('L',Cb_Ind_Apu_Con_Cre_Esc_Ope_Nfe_ECF.Name,IntToStr(Cb_Ind_Apu_Con_Cre_Esc_Ope_Nfe_ECF.ItemIndex)),0);
    //Bloco M
    Cb_Ind_Op_Uti_Cre_Dis_Per.ItemIndex := StrToIntDef(Fc_Tb_Geral('L',Cb_Ind_Op_Uti_Cre_Dis_Per.Name,IntToStr(Cb_Ind_Op_Uti_Cre_Dis_Per.ItemIndex)),0);
    Cb_Cd_Bas_Cal_Credito.ItemIndex := StrToIntDef(Fc_Tb_Geral('L',Cb_Cd_Bas_Cal_Credito.Name,IntToStr(Cb_Cd_Bas_Cal_Credito.ItemIndex)),0);
    ChBx_Cst_PIS_Entrada_Padrao.Checked := (Fc_Tb_Geral('L',ChBx_Cst_PIS_Entrada_Padrao.Name,'S') = 'S');
    Dblcb_Situacao_tributaria_PIS.KeyValue := Fc_Tb_Geral('L',Dblcb_Situacao_tributaria_PIS.Name,'0');

    Cb_Cd_Con_Soc_Apu.ItemIndex := StrToIntDef(Fc_Tb_Geral('L',Cb_Cd_Con_Soc_Apu.Name,IntToStr(Cb_Cd_Con_Soc_Apu.ItemIndex)),0)
    end
  else
    Begin
    Fc_Tb_Geral('G',Cb_Tp_Escrituracao.Name,IntToStr(Cb_Tp_Escrituracao.ItemIndex));
    Fc_Tb_Geral('G',Cb_Indi_Sit_Especial.Name,IntToStr(Cb_Indi_Sit_Especial.ItemIndex));
    Fc_Tb_Geral('G',Cb_Ind_Nat_Pes_Jur.Name,IntToStr(Cb_Ind_Nat_Pes_Jur.ItemIndex));
    Fc_Tb_Geral('G',Cb_Ind_Tip_Ati_Prep.Name,IntToStr(Cb_Ind_Tip_Ati_Prep.ItemIndex));
    Fc_Tb_Geral('G',Cb_Cd_Ind_Inc_trib_Per.Name,IntToStr(Cb_Cd_Ind_Inc_trib_Per.ItemIndex));
    Fc_Tb_Geral('G',Cb_Cd_Ind_Tip_Con_Apu_Per.Name,IntToStr(Cb_Cd_Ind_Tip_Con_Apu_Per.ItemIndex));
    Fc_Tb_Geral('G',Cb_Apro_Cred.Name,IntToStr(Cb_Apro_Cred.ItemIndex));
    Fc_Tb_Geral('G',Cb_Cd_Ind_Cri_Esc_Apu_ado.Name,IntToStr(Cb_Cd_Ind_Cri_Esc_Apu_ado.ItemIndex));
    //Bloco C
    Fc_Tb_Geral('G',Cb_Ind_Apu_Con_Cre_Esc_Ope_Nfe_ECF.Name,IntToStr(Cb_Ind_Apu_Con_Cre_Esc_Ope_Nfe_ECF.ItemIndex));
    //Bloco M
    Fc_Tb_Geral('G',Cb_Ind_Op_Uti_Cre_Dis_Per.Name,IntToStr(Cb_Ind_Op_Uti_Cre_Dis_Per.ItemIndex));
    Fc_Tb_Geral('G',Cb_Cd_Bas_Cal_Credito.Name,IntToStr(Cb_Cd_Bas_Cal_Credito.ItemIndex));
    IF ChBx_Cst_PIS_Entrada_Padrao.Checked then
      Fc_Tb_Geral('G',ChBx_Cst_PIS_Entrada_Padrao.Name,'S')
    else
      Fc_Tb_Geral('G',ChBx_Cst_PIS_Entrada_Padrao.Name,'N');
    Fc_Tb_Geral('G',Dblcb_Situacao_tributaria_PIS.Name,Dblcb_Situacao_tributaria_PIS.KeyValue);
    Fc_Tb_Geral('G',Cb_Cd_Con_Soc_Apu.Name,IntToStr(Cb_Cd_Con_Soc_Apu.ItemIndex));
    end;


end;



function TFr_SPEDPisCofins.Fc_validaGeracaoArquivo:Boolean;
Begin
  Result := True;
  if (E_Data_Fim.Date < E_Data_Ini.Date) then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Data Final não pode ser menor que a inicial.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    if E_Data_Fim.CanFocus then E_Data_Fim.setfocus;
    Result := False;
    exit;
  end;

  if (E_Data_Fim.Date > date) then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Data Final não pode ser maior que a data atual.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    if E_Data_Fim.CanFocus then E_Data_Fim.setfocus;
    Result := False;
    exit;
  end;

  //bloco 0
  if (Cb_Tp_Escrituracao.ItemIndex = 1) and (Trim(E_Nr_Rec_Esc_Ant.Text) = '') then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Para o Tipo de Escrituração Retificadora.'+EOLN+
                   'O número do recibo da escrituração anterior é obrigatria.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    if E_Nr_Rec_Esc_Ant.CanFocus then E_Nr_Rec_Esc_Ant.setfocus;
    Result := False;
    exit;
  end;

  if (Trim(E_Path_Arquivo_SPED.Text) = '') then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Favor Informar um nome de Arquivo Valido.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    if E_Path_Arquivo_SPED.CanFocus then E_Path_Arquivo_SPED.setfocus;
    Result := False;
    exit;
  end;
end;

procedure TFr_SPEDPisCofins.Pc_Bloco_0;
Var
  Lc_Aux : String;
begin
  //Zerar Variaveis
  It_VL_Rec_Brt_M210 := 0;

    with ACBrSPEDPisCofins1 do
    begin
    DT_INI := E_Data_Ini.Date;
    DT_FIN := E_Data_Fim.Date;
    //Tinha um campo com o Valor 1000 - Verificar se é o numero de Notas que vai no arquivo
    //LinhasBuffer := StrToIntDef( edBufLinhas.Text, 0 );
    ACBrSPEDPisCofins1.LinhasBuffer := 1000;
    // Informa o pasta onde será salvo o arquivo TXT.
    ACBrSPEDPisCofins1.Path := GbPathExe;
    ACBrSPEDPisCofins1.Arquivo := E_Path_Arquivo_SPED.Text;
    IniciaGeracao;
    end;

  with ACBrSPEDPisCofins1.Bloco_0 do
    begin
    // 0000 - Abertura do Arquivo Digital e Identificação da Pessoa Jurídica
    with Registro0000New do
      begin
      COD_VER          := vlVersao201;
      case Cb_Tp_Escrituracao.ItemIndex of
        0:TIPO_ESCRIT := tpEscrOriginal;     // 0 - Original
        1:TIPO_ESCRIT := tpEscrRetificadora; // 1 - Retificadora
      end;
      //Número do Recibo da Escrituração anterior a ser retificada, utilizado quando TIPO_ESCRIT for igual a 1
      NUM_REC_ANTERIOR := E_Nr_Rec_Esc_Ant.Text;

      // Indicador de situação especial
      case Cb_Indi_Sit_Especial.ItemIndex of
        0:IND_SIT_ESP      := indSitAbertura;     // 0 - Abertura
        1:IND_SIT_ESP      := indSitCisao;        // 1 - Cisão
        2:IND_SIT_ESP      := indSitFusao;        // 2 - Fusão
        3:IND_SIT_ESP      := indSitIncorporacao; // 3 - Incorporação
        4:IND_SIT_ESP      := indSitEncerramento; // 4 - Encerramento
        5:IND_SIT_ESP      := indNenhum;          // 5 - Vazio
      end;

      //Nome do Estabelecimento
      NOME             := DM.Qr_Estabelecimento.FieldByName('EMP_NOME').AsString;
      //CNPJ do Estabelecimento
      CNPJ             := DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString;
      //UF do Estabelecimento
      UF               := DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString;
      //Codigo do Municipio do Estabelecimento
      COD_MUN          := DM.Qr_Estabelecimento.FieldByName('CDD_IBGE').AsInteger;
      //Codigo Suframa
      SUFRAMA          := '';
      // Indicador da natureza da pessoa juridica
      case Cb_Ind_Nat_Pes_Jur.ItemIndex of
        0:IND_NAT_PJ := indNatPJSocEmpresariaGeral;   // 0 - Sociedade empresaria geral
        1:IND_NAT_PJ := indNatPJSocCooperativa;       // 1 - Sociedade Cooperativa
        2:IND_NAT_PJ := indNatPJEntExclusivaFolhaSal; // 2 - Entidade sujeita ao PIS/Pasep exclusivamente com base  na folha de salírios
      end;
      //Indicador de tipo de atividade prepoderante
      case Cb_Ind_Tip_Ati_Prep.ItemIndex of
        0:IND_ATIV := indAtivIndustrial;       // 0 - Industrial ou equiparado a industrial
        1:IND_ATIV := indAtivPrestadorServico; // 1 - Prestador de serviços
        2:IND_ATIV := indAtivComercio;         // 2 - Atividade de comércios
        3:IND_ATIV := indAtivoFincanceira;     // 3 - Atividade Financeira
        4:IND_ATIV := indAtivoImobiliaria;     // 4 - Atividade Imobiliária
        5:IND_ATIV := indAtivoOutros;           // 9 - Outros
      end;
      end;

    with Registro0001New do
      begin
      IND_MOV := imComDados;
       // FILHO - Dados do contador.
      with Registro0100New do
        begin
        NOME       := 'NOME DO CONTADOR';
        CPF        := '12345678909'; // Deve ser uma informação valida
        CRC        := '123456';
        CNPJ       := '22222222000000';
        CEP        := '';
        ENDERECO   := '';
        NUM        := '';
        COMPL      := '';
        BAIRRO     := '';
        FONE       := '';
        FAX        := '';
        EMAIL      := '';
        COD_MUN    := 3200607;
        end;

      // FILHO - Regime de Apuração
      with Registro0110New do
        begin
        //Codigo indicador da incidencia tributária no período (0110)
        case Cb_Cd_Ind_Inc_trib_Per.ItemIndex of
          0:COD_INC_TRIB  := codEscrOpIncNaoCumulativo; // 0 - Escrituração de operações com incidencia exclusivamente no regime não cumulativo
          1:COD_INC_TRIB  := codEscrOpIncCumulativo;    // 1 - Escrituração de operações com incidencia exclusivamente no regime cumulativo
          2:COD_INC_TRIB  := codEscrOpIncAmbos;         // 2 - Escrituração de operações com incidencia nos regimes cumulativo e não cumulativo
        end;

        //Código indicador de  método  de apropriação de  créditos  comuns, no caso  de incidencia no regime não cumulativo(COD_INC_TRIB = 1 ou 3)(0110)
        case Cb_Apro_Cred.ItemIndex of
          0:IND_APRO_CRED := indMetodoApropriacaoDireta;    // 0 - Método de apropriação direta
          1:IND_APRO_CRED := indMetodoDeRateioProporcional; // 1 - Método de rateio proporcional(Receita Bruta);
        end;
 
        {Código indicador do critério de escrituração e apuração adotado, no caso de incidência exclusivamente no
         regime cumulativo (COD_INC_TRIB = 2), pela pessoa jurídica submetida ao regime de tributação com base no
         lucro presumido:
         1 Regime de Caixa Escrituração consolidada (Registro F500);
         2 Regime de Competência - Escrituração consolidada (Registro F550);
         9 Regime de Competência - Escrituração detalhada, com base nos registros dos Blocos A, C, D e F.}
        case Cb_Cd_Ind_Cri_Esc_Apu_ado.ItemIndex of
          0:Begin
            IND_REG_CUM  := codRegimeCaixa;
            It_F500 := True;
            end;
          1:Begin
            IND_REG_CUM  := codRegimeCompetEscritConsolidada;
            It_F550 := True;
            end;
          2:IND_REG_CUM  := codRegimeCompetEscritDetalhada;
          end;

        //Código indicador do Tipo de Contribuição Apurada no Período(0110)
        case Cb_Cd_Ind_Tip_Con_Apu_Per.ItemIndex of
          0:COD_TIPO_CONT := codIndTipoConExclAliqBasica;  // 0 - Apuração da Contribuição Exclusivamente a Alíquota Básica
          1:COD_TIPO_CONT := codIndTipoAliqEspecificas;    // 1 - Apuração da Contribuição a Alíquotas Específicas (Diferenciadas e/ou por Unidade de Medida de Produto)
        end;
        end;
      //0140 - Tabela de Cadastro de Estabelecimento
      // Dados da Empresa
      Pc_AtivaEstabelecimento;
      with Registro0140New do
        begin
        COD_EST := DM.Qr_Estabelecimento.FieldByName('EMP_CODIGO').AsString;
        NOME    := DM.Qr_Estabelecimento.FieldByName('EMP_NOME').AsString;
        CNPJ    := DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString;
        UF      := DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString;
        Lc_Aux := Trim(DM.Qr_Estabelecimento.FieldByName('EMP_INSC_EST').AsString);
        Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux, ['.',',','/','-',' ']);
        IE      := Lc_Aux;
        COD_MUN := DM.Qr_Estabelecimento.FieldByName('CDD_IBGE').AsInteger;
        IM      := DM.Qr_Estabelecimento.FieldByName('EMP_INSC_MUN').AsString;
        SUFRAMA := '';
        //0150 - Tabela de Cadastro do Participante //Clientes por estabelecimento
        Qr_0150.Active := False;
        Qr_0150.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
        Qr_0150.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
        Qr_0150.ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
        Qr_0150.Active := True;
        Qr_0150.First;
        while not Qr_0150.Eof do
          begin
          with Registro0150New do
            begin
            COD_PART := Qr_0150.FieldByName('EMP_CODIGO').AsString;
            NOME     := Qr_0150.FieldByName('EMP_NOME').AsString;
            COD_PAIS := Qr_0150.FieldByName('PAI_CODBACEN').AsString;
            IF (Length(Trim(Qr_0150.FieldByName('EMP_CNPJ').AsString)) =14) then
              Begin
              CNPJ     := Qr_0150.FieldByName('EMP_CNPJ').AsString;
              CPF      := '';
              Lc_Aux := Trim(Qr_0150.FieldByName('EMP_INSC_EST').AsString);
              if (Lc_Aux <> 'ISENTO') AND (Lc_Aux <> '') then
                Begin
                Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux, ['.',',','/','-',' ']);
                IE     := Lc_Aux;
                end;
              end
            else
              Begin
              CNPJ     := '';
              CPF      := Qr_0150.FieldByName('EMP_CNPJ').AsString;
              end;
            COD_MUN  := Qr_0150.FieldByName('CDD_IBGE').AsInteger;
            SUFRAMA  := '';
            ENDERECO := Qr_0150.FieldByName('END_ENDER').AsString;
            NUM      := Qr_0150.FieldByName('END_NUMERO').AsString;
            COMPL    := Qr_0150.FieldByName('END_COMPLEM').AsString;
            BAIRRO   := Qr_0150.FieldByName('END_BAIRRO').AsString;
            end;
          Qr_0150.Next;
          end;

      // 0190 - Identificação das Unidades de Medida
      Qr_0190.Active := False;
      Qr_0190.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      Qr_0190.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
      Qr_0190.ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
      Qr_0190.Active := True;
      Qr_0190.First;
      while not Qr_0190.Eof do
        begin
        with Registro0190New do
          begin
          UNID  := Qr_0190.FieldByname('MED_CODIGO').AsString;
          DESCR := Qr_0190.FieldByname('MED_ABREVIATURA').AsString;
          end;
        Qr_0190.Next;
        end;

      // 0200 - Tabela de Identificação do Item (Produtos e Serviços)
      Qr_0200.Active := False;
      Qr_0200.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      Qr_0200.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
      Qr_0200.ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
      Qr_0200.Active := True;
      Qr_0200.First;
      while not Qr_0200.Eof do
        begin
        with Registro0200New do
          begin
          COD_ITEM     := FormatFloat('0000000000', Qr_0200.FieldByName('PRO_CODIGO').AsInteger);
          DESCR_ITEM   := Qr_0200.FieldByName('PRO_DESCRICAO').AsString;
          COD_BARRA    := Qr_0200.FieldByName('PRO_CODIGOBAR').AsString;
          COD_ANT_ITEM := FormatFloat('0000000000', Qr_0200.FieldByName('PRO_CODIGO').AsInteger);
          UNID_INV     := Qr_0200.FieldByName('MED_CODIGO').AsString;
          if Qr_0200.FieldByName('PRO_TIPO').AsString = 'P' then
            TIPO_ITEM    := tiProdutoAcabado
          else
          if Qr_0200.FieldByName('PRO_TIPO').AsString = 'M' then
            TIPO_ITEM    := tiMateriaPrima
          else
            TIPO_ITEM    := tiServicos;
          COD_NCM      := Qr_0200.FieldByName('PRO_CODIGONCM').AsString;
          EX_IPI       := '';
          COD_GEN      := '';
          COD_LST      := '';
          ALIQ_ICMS    := 0;
          end;
        Qr_0200.Next;
        end;

      // 0400 - Tabela de Identificação do Item (Produtos e Serviços)
      Qr_0400.Active := False;
      Qr_0400.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      Qr_0400.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
      Qr_0400.ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
      Qr_0400.Active := True;
      Qr_0400.First;
      while not Qr_0400.Eof do
        begin
        with Registro0400New do
          begin
          COD_NAT   := Qr_0400.FieldByName('NAT_CFOP').AsString;
          DESCR_NAT := Qr_0400.FieldByName('NAT_RESUMIDO').AsString;
          end;
        Qr_0400.Next;
        end;


      // FILHO - REGISTRO 0500: PLANO DE CONTAS CONTÁBEIS
      {
      with Registro0500New do
        begin
        DT_ALT := StrToDate('01/04/2011');
        COD_NAT_CC := ncgAtivo;
        IND_CTA := indCTASintetica;
        NIVEL := '0';
        COD_CTA := '01';
        NOME_CTA := 'NOME CTA';
        COD_CTA_REF := '0';
        CNPJ_EST := '33333333000191';
        end;
      }
      end;
    end;
  end;
  ACBrSPEDPisCofins1.WriteBloco_0;
end;

procedure TFr_SPEDPisCofins.Pc_Bloco_A;

begin
  with ACBrSPEDPisCofins1.Bloco_A do
    begin
    with RegistroA001New do
      Begin
      IND_MOV := imSemDados;
      end;
    end;



 // Alimenta o componente com informações para gerar todos os registros do
 { // Bloco A.
  btnB_A.Enabled := false;
  ProgressBar1.Visible := cbConcomitante.Checked ;
  ProgressBar1.Max     := NNotas;
  ProgressBar1.Position:= 0 ;

  with ACBrSPEDPisCofins1.Bloco_A do
    begin
    with RegistroA001New do
      Begin
      IND_MOV := imComDados;
      with RegistroA010New do
        begin
        CNPJ := DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString;
        For
        while not Qr_A100.Eof do
          begin
          with RegistroA100New do
            begin
            IND_OPER      := itoContratado;
            IND_EMIT      := iedfProprio;
            COD_PART      := '2'; // baseado no registro 0150
            COD_SIT       := sdfRegular;
            SER           := '';
            SUB           := '';
            NUM_DOC       := FormatFloat('NF000000',INotas);
            CHV_NFSE      := '';
            DT_DOC        := DT_INI + INotas;
            DT_EXE_SERV   := DT_INI + INotas;
            VL_DOC        := 0.01; //Deve ser maior que zero
            IND_PGTO      := tpSemPagamento;
            VL_DESC       := 0;
            VL_BC_PIS     := 0;
            VL_PIS        := 0;
            VL_BC_COFINS  := 0;
            VL_COFINS     := 0;
            VL_PIS_RET    := 0;
            VL_COFINS_RET := 0;
            VL_ISS        := 0;
            //A170
            for IItens := 1 to 5 do
              begin
              with RegistroA170New do   //Inicio Adicionar os Itens:
                begin
                NUM_ITEM         := IItens;
                COD_ITEM         := FormatFloat('000000', NUM_ITEM); //Código deve ser baseado no registro 0200
                //COD_ITEM         := IntToStr(NUM_ITEM);
                DESCR_COMPL      := FormatFloat('NF000000',INotas)+' -> ITEM '+COD_ITEM;
                VL_ITEM          := 0;
                VL_DESC          := 0;
                NAT_BC_CRED      := bccOutrasOpeComDirCredito;
                IND_ORIG_CRED    := opcMercadoInterno;
                CST_PIS          := stpisOutrasOperacoes;
                VL_BC_PIS        := 0;
                ALIQ_PIS         := 0;
                VL_PIS           := 0;
                CST_COFINS       := stcofinsOutrasOperacoes;
                VL_BC_COFINS     := 0;
                ALIQ_COFINS      := 0;
                VL_COFINS        := 0;
                COD_CTA          := '01';
                COD_CCUS         := '';
                //COD_CCUS         := '123'; //Para usar o COD_CCUS é necessário gerar, primeiro, um registro 0600 correspondente.
                //Prepara Campo para o REgistro M210
                if  (IND_OPER = itoPrestado) then
                  It_VL_Rec_Brt_M210 := It_VL_Rec_Brt_M210 + VL_ITEM;
                end; //Fim dos Itens;
              end;
            end;
          if cbConcomitante.Checked then
            begin
            if (INotas mod BNotas) = 0 then   // Gravar a cada N notas
              begin
              // Grava registros na memoria para o TXT, e limpa memoria
              ACBrSPEDPisCofins1.WriteBloco_A( False );  // False, NAO fecha o Bloco
              ProgressBar1.Position := INotas;
              Application.ProcessMessages;
              end;
            end;
          end;
        end;
      end;
    end;
  if cbConcomitante.Checked then
    begin
    ACBrSPEDPisCofins1.WriteBloco_A(True);  // True, fecha o Bloco
    LoadToMemo;
    end;

   ProgressBar1.Visible := False ;
  }
end;


procedure TFr_SPEDPisCofins.Pc_Bloco_C;
var
  Lc_Tamanho : Integer;
  Lc_Cd_Situacao : String;
  Lc_Vl_Aux : Real;
  Lc_I : Integer;
  Lc_VL_Pis : Real;
  Lc_VL_Cfs : Real;
begin
  //BLOCO C - Documentos Fiscais I É Mercadorias (ICMS/IPI)

  //Abre a Tabela de Impostos no caso de Precisar
  DM.Qr_Impostos.Active := True;

  with ACBrSPEDPisCofins1.Bloco_C do
    begin
    with RegistroC001New do
      begin
      Qr_c100.Active := False;
      Qr_c100.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      Qr_c100.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
      Qr_c100.ParamByName('NFL_CODMHA').AsInteger:=Gb_CodMha;
      Qr_c100.Active := True;
      Qr_c100.FetchAll;
      Qr_c100.First;
      //Verifica se Tem ou não movimento
      if Qr_c100.RecordCount > 0 then
        Begin
        //Atualiza o Componente de Progresso
        Gg_Progresso.MinValue := 0;
        Gg_Progresso.MaxValue := Qr_c100.RecordCount;
        Gg_Progresso.Progress := 0 ;
        Application.ProcessMessages;

        IND_MOV := imComDados;
        //C010 - Identificação do Estabelecimento
        with RegistroC010New do
          begin
          CNPJ := DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString;
          //Indicador da apuração das contribuições e créditos, na escrituração das operações por NF-e e ECF, no período:
          case Cb_Ind_Apu_Con_Cre_Esc_Ope_Nfe_ECF.ItemIndex of
            0:Begin
              IND_ESCRI := IndEscriConsolidado;
              //REGISTRO C180: CONSOLIDAÇÃO DE NOTAS FISCAIS ELETRÔNICAS EMITIDAS PELA PESSOA JURÍDICA (CÓDIGO 55) É OPERAÇÕES DE VENDAS
              with RegistroC180New do
                BEgin
                //Detalhamento da Consolidação - Operações de Vendas - PIS/PASEP
                with RegistroC181 do
                  BEgin
                  end;
                //Detalhamento da Consolidação - Operações de Vendas É COFINS
                with RegistroC185 do
                  BEgin
                  end;
                end;
              //REGISTRO C190: CONSOLIDAÇÃO DE NOTAS FISCAIS ELETRÔNICAS (CÓDIGO55)
              //OPERAÇÕES DE AQUISIÇÃO COM DIREITO A CRÉDITO, E OPERAÇÕES DE DEVOLUÇÃO DE COMPRAS E VENDAS.
              with RegistroC190New do
                BEgin
                //Detalhamento da Consolidação É Operações de Aquisição com Direito a
                //Crédito, e Operações de Devolução de Compras e Vendas É PIS/PASEP
                with RegistroC191 do
                  BEgin
                  //CNPJ_CPF_PART
                  //CST_PIS  Código da Situação Tributária referente ao PIS
                  //CFOP  Código fiscal de operação e prestação
                  //VL_ITEM  Valor do item
                  //VL_DESC  Valor do desconto comercial / Exclusão
                  //VL_BC_PIS   Valor da base de cálculo do PIS/PASEP
                  //ALIQ_PIS    Alíquota do PIS/PASEP (em percentual)
                  //QUANT_BC_PIS Quantidade É Base de cálculo PIS/PASEP
                  //ALIQ_PIS_QUANT Alíquota do PIS/PASEP (em reais)
                  //VL_PIS  Valor do PIS/PASEP
                  //COD_CTA Código da conta analítica contábil debitada/creditada
                  end;
                //Detalhamento da Consolidação - Operações de Aquisição com Direito a
                //Crédito, e Operações de Devolução de Compras e Vendas É COFINS
                with RegistroC195 do
                  BEgin
                  //CNPJ_CPF_PART
                  //CST_COFINS Código da Situação Tributária referente a COFINS
                  //CFOP  Código fiscal de operação e prestação
                  //VL_ITEM  Valor do item
                  //VL_DESC Valor do desconto comercial / Exclusão
                  //VL_BC_COFINS  Valor da base de cálculo da COFINS
                  //ALIQ_COFINS  Alíquota da COFINS (em percentual)
                  //QUANT_BC_COFINS  Quantidade É Base de cálculo da COFINS
                  //ALIQ_COFINS_QUANT Alíquota da COFINS (em reais)
                  //VL_COFINS   Valor da COFINS
                  //COD_CTA   Código da conta analítica contábil debitada/creditada
                  end;
                end;
              end;
            1:Begin
              IND_ESCRI := IndEscriIndividualizado;
              //Inserir Notas...
              while not Qr_c100.Eof do
                begin
                Lb_Processamento.Caption := 'Processamento Bloco C - Nota ' + Qr_c100.FieldByName('NFL_NUMERO').AsString;
                Application.ProcessMessages;
                //C100 - Documento - Nota Fiscal (igo 01), Nota Fiscal Avulsa (igo 1B), Nota
                // Fiscal de Produtor (igo 04) e NF-e (igo 55)
                with RegistroC100New do
                  begin
                  //Verifica se Entrada ou Saida
                  if Copy(Qr_c100.FieldByName('NFL_TIPO').AsString,1,1) = 'S' then
                    IND_OPER      := tpSaidaPrestacao
                  else
                    IND_OPER      := tpEntradaAquisicao;
                  //Verifica se é de Terceira ou Propria
                  if Qr_c100.FieldByName('NFE_CODIGO').IsNull then
                    IND_EMIT      := edTerceiros
                  else
                    IND_EMIT      := edEmissaoPropria;
                  //Verifica o Tipo de Documento se é nota Normal ou eletronica
                  if Qr_c100.FieldByName('NFE_CODIGO').IsNull then
                    Begin
                    COD_MOD       := '01';
                    end
                  else
                    Begin
                    COD_MOD       := '55';
                    end;
                  //Verifica a Situação do Documento
                  if Qr_c100.FieldByName('NFE_CODIGO').IsNull then
                    Begin
                    COD_SIT       := sdRegular;
                    end
                  else
                    Begin
                    // 2 AUTORIZADA / 3 CANCELADA / 4 INUTILIZADA / 5 DENEGADA
                    case Qr_c100.FieldByName('NFE_CODSIT').AsInteger of
                      2:COD_SIT       := sdRegular;
                      3:COD_SIT       := sdCancelado;
                      4:COD_SIT       := sdDoctoNumInutilizada;
                      5:COD_SIT       := sdDoctoDenegado;
                      end;
                    end;
                  //Serie da Nota Fiscal
                  SER           := StrZero(StrToIntDef(Qr_c100.FieldByName('NFL_SERIE').AsString,1),3,0);
                  //Numero da Nota Fiscal
                  NUM_DOC       := FormatFloat('000000000',StrToIntDef(Qr_c100.FieldByName('NFL_NUMERO').AsString,0)); //
                  //Chave de Acesso da Nota Fiscal
                  if Qr_c100.FieldByName('NFE_CODIGO').IsNull then
                    Begin
                    CHV_NFE       := '';
                    end
                  else
                    Begin
                    Lc_Tamanho := length(Qr_c100.FieldByName('NFE_ARQUIVO').AsString)-51;
                    Lc_Cd_Situacao := Qr_c100.FieldByName('NFE_CODSIT').AsString;
                    CHV_NFE       := copy(Qr_c100.FieldByName('NFE_ARQUIVO').AsString,Lc_Tamanho,length(Qr_c100.FieldByName('NFE_ARQUIVO').AsString));
                    CHV_NFE      :=  copy(CHV_NFE,1,(length(CHV_NFE)-8));
                    end;
                  //Datas do emissao
                  DT_DOC        := Qr_c100.FieldByName('NFL_DT_EMISSAO').AsDateTime;
                  //Datas de entrada ou saida
                  DT_E_S        := Qr_c100.FieldByName('NFL_DT_SAIDA').AsDateTime;

                  Qr_C170.Active := False;
                  Qr_C170.ParamByName('NFL_CODIGO').AsInteger := Qr_c100.FieldByName('NFL_CODIGO').AsInteger;
                  Qr_C170.Active := True;
                  Qr_C170.FetchAll;
                  Lc_I := 1;
                  Lc_VL_Pis := 0;
                  Lc_VL_Cfs := 0;
                  while not Qr_C170.Eof do
                    begin
                    if (Qr_c100.FieldByName('NFE_CODSIT').AsInteger = 2)or (Qr_c100.FieldByName('NFE_CODSIT').IsNull) then
                      Begin
                      //c170 - Complemento de Documento Itens do Documento (igos 01, 1B, 04 e 55)
                      with RegistroC170New do   //Inicio Adicionar os Itens:
                        begin
                        NUM_ITEM         := FormatFloat('000', Lc_I);
                        COD_ITEM         := FormatFloat('0000000000',Qr_C170.FieldByName('PRO_CODIGO').AsInteger);
                        DESCR_COMPL      := Qr_C170.FieldByName('PRO_DESCRICAO').AsString;
                        QTD              := Qr_C170.FieldByName('ITF_QTDE').AsFloat;
                        UNID             := Qr_C170.FieldByName('MED_CODIGO').AsString;
                        VL_ITEM          := Qr_C170.FieldByName('ITF_VL_SUBTOTAL').AsCurrency;
                        //Prepara Campo para Preencher M210
                        if Copy(Qr_c100.FieldByName('NFL_TIPO').AsString,1,1) = 'S' then
                          Begin
                          if (Cb_Ind_Apu_Con_Cre_Esc_Ope_Nfe_ECF.ItemIndex = 1) then
                            It_VL_Rec_Brt_M210 := It_VL_Rec_Brt_M210 + VL_ITEM;
                          end;
                        VL_DESC          := Qr_C170.FieldByName('ITF_VL_DESC').AsCurrency;
                        IF Qr_C170.FieldByName('ITF_ESTOQUE').AsString = 'S' then
                          IND_MOV          := mfSim
                        else
                          IND_MOV          := mfNao;

                        case Qr_C170.FieldByName('ITF_CST_ICMS').AsInteger of
                          1:CST_ICMS         := sticmsTributadaIntegralmente;
                          2:CST_ICMS         := sticmsTributadaComCobracaPorST;
                          3:CST_ICMS         := sticmsComReducao;
                          4:CST_ICMS         := sticmsIsentaComCobracaPorST;
                          5:CST_ICMS         := sticmsIsenta;
                          6:CST_ICMS         := sticmsNaoTributada;
                          7:CST_ICMS         := sticmsSuspensao;
                          8:CST_ICMS         := sticmsCobradoAnteriormentePorST;
                          9:CST_ICMS         := sticmsComReducaoPorST;
                          10:CST_ICMS         := sticmsOutros;
                        end;

                        CFOP             := Qr_C170.FieldByName('NAT_CFOP').AsString;
                        COD_NAT          := Qr_C170.FieldByName('NAT_CFOP').AsString;
                        //se existir no mínimo 1 CFOP iniciado em 3 e constar da tabela
                        //CFOP  - Operações Geradoras de Créditos)
                        if (Copy(Qr_C170.FieldByName('NAT_CFOP').AsString,1,1) = '3') then
                          Begin
                          with RegistroC120New do
                            BEgin
                            COD_DOC_IMP := diImportacao;
                            NUM_DOC__IMP := '';
                            //VL_PIS_IMP
                            //VL_COFINS_IMP
                            NUM_ACDRAW := '';
                            end;
                          end;
                        VL_BC_ICMS       := Qr_C170.FieldByName('ITF_CST_ICMS').AsCurrency;
                        ALIQ_ICMS        := Qr_C170.FieldByName('ICM_AQ_NR').AsFloat;
                        VL_ICMS          := Qr_C170.FieldByName('ICM_VL_NR').AsCurrency;
                        VL_BC_ICMS_ST    := Qr_C170.FieldByName('ICM_VL_BC_ST').AsCurrency;
                        ALIQ_ST          := Qr_C170.FieldByName('ICM_AQ_ST').AsFloat;
                        VL_ICMS_ST       := Qr_C170.FieldByName('ICM_VL_ST').AsCurrency;
                        IND_APUR         := iaMensal;
                        //CST do IPI
                        if (Qr_C170.FieldByName('ITF_CST_IPI').AsInteger > 0) then
                          Begin
                          case Qr_C170.FieldByName('ITF_CST_IPI').AsInteger of
                            1:CST_IPI          := stipiEntradaRecuperacaoCredito;
                            2:CST_IPI          := stipiEntradaTributradaZero;
                            3:CST_IPI          := stipiEntradaIsenta;
                            4:CST_IPI          := stipiEntradaNaoTributada;
                            5:CST_IPI          := stipiEntradaImune;
                            6:CST_IPI          := stipiEntradaComSuspensao;
                            7:CST_IPI          := stipiOutrasEntradas;
                            8:CST_IPI          := stipiSaidaTributada;
                            9:CST_IPI          := stipiSaidaTributadaZero;
                            10:CST_IPI          := stipiSaidaIsenta;
                            11:CST_IPI          := stipiSaidaNaoTributada;
                            12:CST_IPI          := stipiSaidaImune;
                            13:CST_IPI          := stipiSaidaComSuspensao;
                            14:CST_IPI          := stipiOutrasSaidas;
                          end;
                          COD_ENQ          := Qr_C170.FieldByName('IPI_CL_ENQD').AsString;
                          VL_BC_IPI        := Qr_C170.FieldByName('IPI_VL_BC').AsCurrency;
                          ALIQ_IPI         := Qr_C170.FieldByName('IPI_AQ_NR').AsCurrency;
                          VL_IPI           := Qr_C170.FieldByName('IPI_VL_BC').AsCurrency * (Qr_C170.FieldByName('IPI_AQ_NR').AsCurrency / 100);
                          end
                        else
                          Begin
                          if (Copy(Qr_c100.FieldByName('NFL_TIPO').AsString,1,1)='S') then
                            Begin
                            if (Qr_C170.FieldByName('IPI_VL_BC').AsCurrency>0) then
                              Begin
                              CST_IPI          := stipiSaidaTributada;
                              VL_BC_IPI        := Qr_C170.FieldByName('IPI_VL_BC').AsCurrency;
                              ALIQ_IPI         := Qr_C170.FieldByName('IPI_AQ_NR').AsCurrency;
                              VL_IPI           := VL_BC_IPI * (ALIQ_IPI / 100);
                              end;
                            end
                          else
                            Begin
                            if (Qr_C170.FieldByName('IPI_VL_BC').AsCurrency>0) then
                              Begin
                              CST_IPI          := stipiEntradaRecuperacaoCredito;
                              VL_BC_IPI        := Qr_C170.FieldByName('IPI_VL_BC').AsCurrency;
                              ALIQ_IPI         := Qr_C170.FieldByName('IPI_AQ_NR').AsCurrency;
                              VL_IPI           := Qr_C170.FieldByName('IPI_VL_BC').AsCurrency * (Qr_C170.FieldByName('IPI_AQ_NR').AsCurrency / 100);
                              end;
                            end;
                          end;
                        //CST do PIS
                        if Copy(Qr_c100.FieldByName('NFL_TIPO').AsString,1,1) = 'S' then
                          Begin
                          case Qr_C170.FieldByName('ITF_CST_PIS').AsInteger of
                            10:CST_PIS          := stpisValorAliquotaNormal;
                            11:CST_PIS          := stpisValorAliquotaDiferenciada;
                            12:CST_PIS          := stpisQtdeAliquotaUnidade;
                            13:CST_PIS          := stpisMonofaticaAliquotaZero;
                            14:CST_PIS          := stpisOperAquiAliquotaZero;
                            15:CST_PIS          := stpisIsentaContribuicao;
                            16:CST_PIS          := stpisSemIncidenciaContribuicao;
                            17:CST_PIS          := stpisOperAquiComSuspensao;
                            18:CST_PIS          := stpisOutrasOperacoes;
                          else
                            CST_PIS          := stpisValorAliquotaNormal;
                           END;
                          end
                        else
                          Begin
                          case Qr_C170.FieldByName('ITF_CST_PIS').AsInteger of
                            50:CST_PIS := stpisOperCredExcRecTribMercInt;                     // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA EXCLUSIVAMENTE A RECEITA TRIBUTADA NO MERCADO INTERNO
                            51:CST_PIS := stpisOperCredExcRecNaoTribMercInt;                  // OPERAÇÃO COM DIREITO A CRÉDITO VINCULADA EXCLUSIVAMENTE A RECEITA NÃO TRIBUTADA NO MERCADO INTERNO
                            52:CST_PIS := stpisOperCredExcRecExportacao;                      // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA EXCLUSIVAMENTE A RECEITA DE EXPORTAÇÃO
                            53:CST_PIS := stpisOperCredRecTribNaoTribMercInt;                 // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO
                            54:CST_PIS := stpisOperCredRecTribMercIntEExportacao;             // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO
                            55:CST_PIS := stpisOperCredRecNaoTribMercIntEExportacao;          // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS NÃO-TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO
                            56:CST_PIS := stpisOperCredRecTribENaoTribMercIntEExportacao;     // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO, E DE EXPORTAÇÃO
                            60:CST_PIS := stpisCredPresAquiExcRecTribMercInt;                 // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA EXCLUSIVAMENTE A RECEITA TRIBUTADA NO MERCADO INTERNO
                            61:CST_PIS := stpisCredPresAquiExcRecNaoTribMercInt;              // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA EXCLUSIVAMENTE A RECEITA NÃO-TRIBUTADA NO MERCADO INTERNO
                            62:CST_PIS := stpisCredPresAquiExcExcRecExportacao;               // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA EXCLUSIVAMENTE A RECEITA DE EXPORTAÇÃO
                            63:CST_PIS := stpisCredPresAquiRecTribNaoTribMercInt;             // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO
                            64:CST_PIS := stpisCredPresAquiRecTribMercIntEExportacao;         // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA A RECEITAS TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO
                            65:CST_PIS := stpisCredPresAquiRecNaoTribMercIntEExportacao;      // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA A RECEITAS NÃO-TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO
                            66:CST_PIS := stpisCredPresAquiRecTribENaoTribMercIntEExportacao; // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO, E DE EXPORTAÇÃO
                            70:CST_PIS := stpisOperAquiSemDirCredito;                         // OPERAÇÃO DE AQUISIÇÃO SEM DIREITO A CRÉDITO
                            71:CST_PIS := stpisOperAquiComIsensao;                            // OPERAÇÃO DE AQUISIÇÃO COM ISENÇÃO
                            72:CST_PIS := stpisOperAquiComSuspensao;                          // OPERAÇÃO DE AQUISIÇÃO COM SUSPENSÃO
                            73:CST_PIS := stpisOperAquiAliquotaZero;                          // OPERAÇÃO DE AQUISIÇÃO A ALÍQUOTA ZERO
                            74:CST_PIS := stpisOperAqui_SemIncidenciaContribuicao;            // OPERAÇÃO DE AQUISIÇÃO SEM INCIDÊNCIA DA CONTRIBUIÇÃO
                            75:CST_PIS := stpisOperAquiPorST;                                 // OPERAÇÃO DE AQUISIÇÃO POR SUBSTITUIÇÃO TRIBUTÁRIA
                          else
                            CST_PIS := stpisOutrasOperacoesEntrada;                           // OUTRAS OPERAÇÕES DE ENTRADA
                           END;
                          end;
                        //Verifica se o valor vem da Regra ou usa o padrão

                        if (Qr_C170.FieldByName('PIS_VL_BC').AsCurrency > 0) then
                          Begin
                          VL_BC_PIS        := Qr_C170.FieldByName('PIS_VL_BC').AsCurrency;
                          ALIQ_PIS_PERC    := Qr_C170.FieldByName('PIS_AQ_NR').AsCurrency;
                          QUANT_BC_PIS     := Qr_C170.FieldByName('PIS_QT_VDA').AsCurrency;
                          ALIQ_PIS_R       := Qr_C170.FieldByName('PIS_VL_AQ').AsCurrency;
                          VL_PIS           := Qr_C170.FieldByName('PIS_VL_NR').AsCurrency;
                          end
                        else
                          Begin
                          VL_BC_PIS        := Qr_C170.FieldByName('ITF_VL_SUBTOTAL').AsCurrency;
                          ALIQ_PIS_PERC    := DM.Qr_Impostos.FieldByName('IPT_PIS').AsCurrency;
                          QUANT_BC_PIS     := 0;
                          ALIQ_PIS_R       := 0;
                          VL_PIS           := Qr_C170.FieldByName('ITF_VL_SUBTOTAL').AsCurrency * (DM.Qr_Impostos.FieldByName('IPT_PIS').AsCurrency/100);
                          end;
                        //Totaliza o Valor do PIS
                        Lc_VL_Pis := Lc_VL_Pis + VL_PIS;

                         //CST do Cofins
                        if Copy(Qr_c100.FieldByName('NFL_TIPO').AsString,1,1) = 'S' then
                          Begin
                          case Qr_C170.FieldByName('ITF_CST_CFS').AsInteger of
                            1:CST_COFINS          := stCofinsValorAliquotaNormal;
                            2:CST_COFINS          := stCofinsValorAliquotaDiferenciada;
                            3:CST_COFINS          := stcofinsQtdeAliquotaUnidade;
                            4:CST_COFINS          := stcofinsMonofaticaAliquotaZero;
                            5:CST_COFINS          := stCofinsOperAquiAliquotaZero;
                            6:CST_COFINS          := stCofinsIsentaContribuicao;
                            7:CST_COFINS          := stCofinsSemIncidenciaContribuicao;
                            8:CST_COFINS          := stCofinsOperAquiComSuspensao;
                            9:CST_COFINS          := stCofinsOutrasOperacoes;
                          else
                            CST_COFINS          := stCofinsValorAliquotaNormal;
                          end;
                          end
                        else
                          Begin
                          case Qr_C170.FieldByName('ITF_CST_CFS').AsInteger of
                            50:CST_COFINS := stCofinsOperCredExcRecTribMercInt;                     // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA EXCLUSIVAMENTE A RECEITA TRIBUTADA NO MERCADO INTERNO
                            51:CST_COFINS := stCofinsOperCredExcRecNaoTribMercInt;                  // OPERAÇÃO COM DIREITO A CRÉDITO VINCULADA EXCLUSIVAMENTE A RECEITA NÃO TRIBUTADA NO MERCADO INTERNO
                            52:CST_COFINS := stCofinsOperCredExcRecExportacao;                      // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA EXCLUSIVAMENTE A RECEITA DE EXPORTAÇÃO
                            53:CST_COFINS := stCofinsOperCredRecTribNaoTribMercInt;                 // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO
                            54:CST_COFINS := stCofinsOperCredRecTribMercIntEExportacao;             // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO
                            55:CST_COFINS := stCofinsOperCredRecNaoTribMercIntEExportacao;          // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS NÃO-TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO
                            56:CST_COFINS := stCofinsOperCredRecTribENaoTribMercIntEExportacao;     // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO, E DE EXPORTAÇÃO
                            60:CST_COFINS := stCofinsCredPresAquiExcRecTribMercInt;                 // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA EXCLUSIVAMENTE A RECEITA TRIBUTADA NO MERCADO INTERNO
                            61:CST_COFINS := stCofinsCredPresAquiExcRecNaoTribMercInt;              // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA EXCLUSIVAMENTE A RECEITA NÃO-TRIBUTADA NO MERCADO INTERNO
                            62:CST_COFINS := stCofinsCredPresAquiExcExcRecExportacao;               // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA EXCLUSIVAMENTE A RECEITA DE EXPORTAÇÃO
                            63:CST_COFINS := stCofinsCredPresAquiRecTribNaoTribMercInt;             // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO
                            64:CST_COFINS := stCofinsCredPresAquiRecTribMercIntEExportacao;         // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA A RECEITAS TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO
                            65:CST_COFINS := stCofinsCredPresAquiRecNaoTribMercIntEExportacao;      // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA A RECEITAS NÃO-TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO
                            66:CST_COFINS := stCofinsCredPresAquiRecTribENaoTribMercIntEExportacao; // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO, E DE EXPORTAÇÃO
                            70:CST_COFINS := stCofinsOperAquiSemDirCredito;                         // OPERAÇÃO DE AQUISIÇÃO SEM DIREITO A CRÉDITO
                            71:CST_COFINS := stCofinsOperAquiComIsensao;                            // OPERAÇÃO DE AQUISIÇÃO COM ISENÇÃO
                            72:CST_COFINS := stCofinsOperAquiComSuspensao;                          // OPERAÇÃO DE AQUISIÇÃO COM SUSPENSÃO
                            73:CST_COFINS := stCofinsOperAquiAliquotaZero;                          // OPERAÇÃO DE AQUISIÇÃO A ALÍQUOTA ZERO
                            74:CST_COFINS := stCofinsOperAqui_SemIncidenciaContribuicao;            // OPERAÇÃO DE AQUISIÇÃO SEM INCIDÊNCIA DA CONTRIBUIÇÃO
                            75:CST_COFINS := stCofinsOperAquiPorST;                                 // OPERAÇÃO DE AQUISIÇÃO POR SUBSTITUIÇÃO TRIBUTÁRIA
                          else
                            CST_COFINS := stCofinsOutrasOperacoesEntrada;                           // OUTRAS OPERAÇÕES DE ENTRADA
                          END;
                          end;
                        //Verifica se o valor vem da Regra ou usa o padrão
                        if (Qr_C170.FieldByName('CFS_VL_BC').AsCurrency > 0) then
                          Begin
                          VL_BC_COFINS     := Qr_C170.FieldByName('CFS_VL_BC').AsCurrency;
                          ALIQ_COFINS_PERC := Qr_C170.FieldByName('CFS_AQ_NR').AsFloat;
                          QUANT_BC_COFINS  := Qr_C170.FieldByName('CFS_QT_UNID').AsFloat;
                          ALIQ_COFINS_R    := Qr_C170.FieldByName('CFS_VL_AQ').AsCurrency;
                          VL_COFINS        := Qr_C170.FieldByName('CFS_VL_NR').AsCurrency;
                          end
                        else
                          Begin
                          VL_BC_COFINS     := Qr_C170.FieldByName('ITF_VL_SUBTOTAL').AsCurrency;
                          ALIQ_COFINS_PERC := DM.Qr_Impostos.FieldByName('IPT_COFINS').AsCurrency;
                          QUANT_BC_COFINS  := 0;
                          ALIQ_COFINS_R    := 0;
                          VL_COFINS        := Qr_C170.FieldByName('ITF_VL_SUBTOTAL').AsCurrency * (DM.Qr_Impostos.FieldByName('IPT_COFINS').AsCurrency/100);
                          end;
                        //Totaliza o Valor do PIS
                        Lc_VL_Cfs := Lc_VL_Cfs + VL_COFINS;
                        end;
                      Inc(Lc_I);
                      end;
                    Qr_C170.Next;
                    end; //Fim dos Itens;
                  //Totalizadores e Valores da Nota para Notas Autorizadas
                  if (Qr_c100.FieldByName('NFE_CODSIT').AsInteger = 2)or (Qr_c100.FieldByName('NFE_CODSIT').IsNull) then
                    Begin
                    //Codigo do Participante
                    COD_PART      := Qr_c100.FieldByName('EMP_CODIGO').AsString;
                    //Valor do Documento
                    VL_DOC        := Qr_c100.FieldByName('NFL_VL_TL_NOTA').AsCurrency;
                    //Forma de Pagamento
                    if (Qr_c100.FieldByName('PED_TIPO').AsInteger = 3)  THEN
                      Begin
                      IND_PGTO      := tpSemPagamento;
                      end
                    else
                      BEgin
                      if (copy(Qr_c100.FieldByName('PED_PRAZO').AsString,1,3) = '000') then
                        IND_PGTO      := tpVista
                      else
                        IND_PGTO      := tpPrazo;
                      end;

                    //Valor do DEsconto
                    VL_DESC       := Qr_c100.FieldByName('NFL_VL_TL_NOTA').AsCurrency;
                    //Abatimento não tributado e não comercial
                    VL_ABAT_NT    := 0;
                    //VAlor da Mercadoria
                    VL_MERC       := Qr_c100.FieldByName('NFL_VL_TL_PROD').AsCurrency;
                    //Frete por Conta
                    case Qr_c100.FieldByName('NFL_CTA_FRETE').AsInteger of
                      0:IND_FRT       := tfPorContaEmitente;
                      1:IND_FRT       := tfPorContaDestinatario;
                      2:IND_FRT       := tfPorContaTerceiros;
                      9:IND_FRT       := tfSemCobrancaFrete;
                    end;
                    //Valor do Frete
                    VL_FRT        := Qr_c100.FieldByName('NFL_VL_FRETE').AsCurrency;
                    //VAlor do Seguro
                    VL_SEG        :=  Qr_c100.FieldByName('NFL_VL_SEGURO').AsCurrency;
                    //Valor de Outras Despesas
                    VL_OUT_DA     :=  Qr_c100.FieldByName('NFL_VL_DESP_ACESS').AsCurrency;
                    //Valor da Base do ICMS
                    VL_BC_ICMS    := Qr_c100.FieldByName('NFL_BS_ICMS').AsCurrency;
                    //Valor do ICMS
                    VL_ICMS       := Qr_c100.FieldByName('NFL_VL_ICMS').AsCurrency;
                    //Valor da Base do ICMS S.T
                    VL_BC_ICMS_ST := Qr_c100.FieldByName('NFL_BS_ICMS_SUBST').AsCurrency;
                    //Valor do ICMS ST
                    VL_ICMS_ST    := Qr_c100.FieldByName('NFL_VL_ICMS_SUBST').AsCurrency;
                    //Valor do IPI
                    VL_IPI        := Qr_c100.FieldByName('NFL_VL_IPI').AsCurrency;
                    //VAlor do PIS
                    VL_PIS           := Ceil(Lc_VL_Pis);
                    //Valor do PIS S.T
                    VL_PIS_ST        := 0;
                    //VAlor do PIS
                    VL_COFINS        := Ceil(Lc_VL_Cfs);
                    //Valor do Cofins S.T
                    VL_COFINS_ST     := 0;
                    end;
                  end;
                Qr_c100.Next;
                Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
                Application.ProcessMessages;
                end; //Fim das Notas
              end;//fim da Escrituração Individual;
            end;
          end;
        end
      else
        Begin
        IND_MOV := imComDados;
        end;
      end;
    end;
  ACBrSPEDPisCofins1.WriteBloco_C(True);  // True, fecha o Bloco
end;

procedure TFr_SPEDPisCofins.Pc_Bloco_D;
begin
  //BLOCO D - Documentos Fiscais II Serviços (ICMS)
  //Em Desenvolvimento  - Enviar sem dados
  with ACBrSPEDPisCofins1.Bloco_D do
    begin
    with RegistroD001New do
      begin
      IND_MOV := imSemDados;
      end;
    end;
  //Em Desenvolvimento  - Sair da Função
  exit;
  ACBrSPEDPisCofins1.WriteBloco_D;
end;

procedure TFr_SPEDPisCofins.Pc_Bloco_F;
begin
  //BLOCO F - Demais Documentos e Operações
  //Em Desenvolvimento  - Enviar sem dados
  with ACBrSPEDPisCofins1.Bloco_F do
    begin
    with RegistroF001New do
      begin
      IND_MOV := imSemDados;
      end;
    end;
  ACBrSPEDPisCofins1.WriteBloco_F;
end;

procedure TFr_SPEDPisCofins.Pc_Bloco_M;
Var
  Lc_VL_Pis : Real;
  Lc_VL_Cfs : Real;
  Lc_Cst_PIs : Integer;
  Lc_14_M100 : Real;
  Lc_13_M200_NC : Real;
  Lc_13_M200_CUM : Real;
  Lc_VL_faturamento : real;
  Lc_Vl_Bc : real;
  Lc_02_M600_NC : Real;
begin
  //BLOCO M - Apuração da Contribuição e Crédito de PIS/PASEP e da COFINS
  //Em Desenvolvimento  - Enviar sem dados

  with ACBrSPEDPisCofins1.Bloco_M do
    begin
    with RegistroM001New do
      begin
      Qr_M100.Active := False;
      Qr_M100.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      Qr_M100.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
      Qr_M100.ParamByName('NFL_CODMHA').AsInteger:=Gb_CodMha;
      Qr_M100.Active := True;
      Qr_M100.FetchAll;
      Qr_M100.First;
      Lc_VL_faturamento := 0;
      Lc_Vl_Bc := 0;
      //Verifica se Tem ou não movimento
      if Qr_M100.RecordCount > 0 then
        Begin
        //M100 - Crédito de PIS/PASEP Relativo ao Período
        IND_MOV := imComDados;
        //Atualiza o Componente de Progresso
        Gg_Progresso.MinValue := 1;
        Gg_Progresso.MaxValue := Qr_M100.RecordCount;
        Gg_Progresso.Progress := 0 ;
        Application.ProcessMessages;
        while not Qr_M100.Eof do
          Begin
          Lb_Processamento.Caption := 'Processamento Bloco M - Nota ' + Qr_M100.FieldByName('NFL_NUMERO').AsString;
          Application.ProcessMessages;
          Lc_VL_faturamento := Lc_VL_faturamento + Ceil(Qr_M100.FieldByName('NFL_VL_TL_NOTA').AsCurrency);
          Lc_Vl_Bc          := Lc_Vl_Bc + Ceil(Qr_M100.FieldByName('NFL_VL_TL_NOTA').AsCurrency);
          {
          with RegistroM100New do
            begin
            COD_CRED       := '101';
            IND_CRED_ORI   := icoOperProprias;
            VL_BC_PIS      := Qr_M100.FieldByName('NFL_VL_TL_NOTA').AsCurrency;
            ALIQ_PIS       := DM.Qr_Impostos.FieldByName('IPT_PIS').AsCurrency / 100;
            QUANT_BC_PIS   := 0;
            ALIQ_PIS_QUANT := 0;
            VL_CRED        := Qr_M100.FieldByName('NFL_VL_TL_NOTA').AsCurrency * (DM.Qr_Impostos.FieldByName('IPT_PIS').AsCurrency / 100);
            VL_AJUS_ACRES  := 0;
            VL_AJUS_REDUC  := 0;
            VL_CRED_DIF    := 0;
            VL_CRED_DISP   := (VL_CRED + VL_AJUS_ACRES) - (VL_AJUS_REDUC + VL_CRED_DIF);
            case Cb_Ind_Op_Uti_Cre_Dis_Per.ItemIndex of
              0:IND_DESC_CRED  := idcTotal;
              1:IND_DESC_CRED  := idcParcial;
            end;
            //Valor do Crédito disponível, descontado da contribuição apurada no ppróprio período.
            //Se IND_DESC_CRED=0, informar o valor total do Campo 12; Se IND_DESC_CRED=1, informar o valor parcial do Campo 12.
            Lc_14_M100    := VL_CRED_DISP;
            VL_CRED_DESC  := Lc_14_M100;
            SLD_CRED      := 0;

            Qr_M105.Active := False;
            Qr_M105.ParamByName('NFL_CODIGO').AsInteger := Qr_M100.FieldByName('NFL_CODIGO').AsInteger;
            Qr_M105.Active := True;
            Qr_M105.FetchAll;
            Lc_VL_Pis := 0;
            Lc_VL_Cfs := 0;
            while not Qr_M105.Eof do
              begin
              with RegistroM105New do
                begin
                case Cb_Cd_Bas_Cal_Credito.ItemIndex of
                  0:NAT_BC_CRED := bccAqBensRevenda;                  // 01 - Aquisição de bens para revenda
                  1:NAT_BC_CRED := bccAqBensUtiComoInsumo;            // 02 - Aquisição de bens utilizados como insumo
                  2:NAT_BC_CRED := bccAqServUtiComoInsumo;            // 03 - Aquisição de serviços utilizados como insumo
                  3:NAT_BC_CRED := bccEnergiaEletricaTermica;         // 04 - Energia elétrica e térmica, inclusive sob a forma de vapor
                  4:NAT_BC_CRED := bccAluguelPredios;                 // 05 - Aluguíis de prédios
                  5:NAT_BC_CRED := bccAluguelMaqEquipamentos;         // 06 - Aluguíis de máquinas e equipamentos
                  6:NAT_BC_CRED := bccArmazenagemMercadoria;          // 07 - Armazenagem de mercadoria e frete na operação de venda
                  7:NAT_BC_CRED := bccConArrendamentoMercantil;       // 08 - Contraprestações de arrendamento mercantil
                  8:NAT_BC_CRED := bccMaqCredDepreciacao;             // 09 -  Máquinas, equipamentos e outros bens incorporados ao ativo imobilizado (crédito sobre encargos de depreciação).
                  9:NAT_BC_CRED := bccMaqCredAquisicao;               // 10 -  Máquinas, equipamentos e outros bens incorporados ao ativo imobilizado (crédito com base no valor de aquisição).
                  10:NAT_BC_CRED := bccAmortizacaoDepreciacaoImoveis; // 11 - Amortização e Depreciação de edificações e benfeitorias em imóveis
                  11:NAT_BC_CRED := bccDevolucaoSujeita;              // 12 - Devolução de Vendas Sujeitas Incidência Não-Cumulativa
                  12:NAT_BC_CRED := bccOutrasOpeComDirCredito;        // 13 - Outras Operações com Direito a Crédito
                  13:NAT_BC_CRED := bccAtTransporteSubcontratacao;    // 14 - Atividade de Transporte de Cargas Subcontratação
                  14:NAT_BC_CRED := bccAtImobCustoIncorrido;          // 15 - Atividade Imobiliária É Custo Incorrido de Unidade Imobiliária
                  15:NAT_BC_CRED := bccAtImobCustoOrcado;             // 16 - Atividade Imobiliária É Custo Orçado de unidade não concluída
                  16:NAT_BC_CRED := bccAtPresServ;                    // 17 - Atividade de Prestação de Serviços de Limpeza, Conservação e Manutenção é vale-transporte, vale-refeição ou vale-alimentação, fardamento ou uniforme.
                  17:NAT_BC_CRED := bccEstoqueAberturaBens;           // 18 - Estoque de abertura de bens
                end;
                //CST do PIS
                if ChBx_Cst_PIS_Entrada_Padrao.Checked then
                  Begin
                  Lc_Cst_PIs := Dblcb_Situacao_tributaria_PIS.KeyValue;
                  end
                else
                  Begin
                  Lc_Cst_PIs := Qr_M105.FieldByName('ITF_CST_PIS').AsInteger
                  end;
               case Lc_Cst_PIs of
                 50:CST_PIS := stpisOperCredExcRecTribMercInt;                      // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA EXCLUSIVAMENTE A RECEITA TRIBUTADA NO MERCADO INTERNO
                 51:CST_PIS := stpisOperCredExcRecNaoTribMercInt;                   // OPERAÇÃO COM DIREITO A CRÉDITO VINCULADA EXCLUSIVAMENTE A RECEITA NÃO TRIBUTADA NO MERCADO INTERNO
                 52:CST_PIS := stpisOperCredExcRecExportacao;                       // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA EXCLUSIVAMENTE A RECEITA DE EXPORTAÇÃO
                 53:CST_PIS := stpisOperCredRecTribNaoTribMercInt;                  // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO
                 54:CST_PIS := stpisOperCredRecTribMercIntEExportacao;              // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO
                 55:CST_PIS := stpisOperCredRecNaoTribMercIntEExportacao;           // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS NÃO-TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO
                 56:CST_PIS := stpisOperCredRecTribENaoTribMercIntEExportacao;      // OPERAÇÃO COM DIREITO A CRÉDITO - VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO, E DE EXPORTAÇÃO
                 60:CST_PIS := stpisCredPresAquiExcRecTribMercInt;                  // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA EXCLUSIVAMENTE A RECEITA TRIBUTADA NO MERCADO INTERNO
                 61:CST_PIS := stpisCredPresAquiExcRecNaoTribMercInt;               // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA EXCLUSIVAMENTE A RECEITA NÃO-TRIBUTADA NO MERCADO INTERNO
                 62:CST_PIS := stpisCredPresAquiExcExcRecExportacao;                // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA EXCLUSIVAMENTE A RECEITA DE EXPORTAÇÃO
                 63:CST_PIS := stpisCredPresAquiRecTribNaoTribMercInt;              // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO
                 64:CST_PIS := stpisCredPresAquiRecTribMercIntEExportacao;        // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA A RECEITAS TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO
                 65:CST_PIS := stpisCredPresAquiRecNaoTribMercIntEExportacao;       // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA A RECEITAS NÃO-TRIBUTADAS NO MERCADO INTERNO E DE EXPORTAÇÃO
                 66:CST_PIS := stpisCredPresAquiRecTribENaoTribMercIntEExportacao   // CRÉDITO PRESUMIDO - OPERAÇÃO DE AQUISIÇÃO VINCULADA A RECEITAS TRIBUTADAS E NÃO-TRIBUTADAS NO MERCADO INTERNO, E DE EXPORTAÇÃO
                end;
                //Verifica se o valor vem da Regra ou usa o padrão
                if (Qr_M105.FieldByName('PIS_VL_BC').AsCurrency > 0) then
                  Begin
                  VL_BC_PIS_TOT := Qr_M105.FieldByName('PIS_VL_BC').AsCurrency;
                  VL_BC_PIS_CUM := 0;
                  VL_BC_PIS_NC := VL_BC_PIS_TOT - VL_BC_PIS_CUM;
                  VL_BC_PIS  := VL_BC_PIS_NC;
                  QUANT_BC_PIS_TOT := 0;
                  QUANT_BC_PIS := 0;
                  DESC_CRED := '';
                  end
                else
                  Begin
                  VL_BC_PIS_TOT := Qr_M105.FieldByName('ITF_VL_SUBTOTAL').AsCurrency;
                  VL_BC_PIS_CUM := 0;
                  VL_BC_PIS_NC := VL_BC_PIS_TOT - VL_BC_PIS_CUM;
                  VL_BC_PIS  := VL_BC_PIS_NC;
                  QUANT_BC_PIS_TOT := 0;
                  QUANT_BC_PIS := 0;
                  DESC_CRED := '';
                  end;
                end; //fim do m105
              Qr_M105.Next;
              end; //Fim dos Itens;
            end;//fim do M100
          }
          Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
          Application.ProcessMessages;
          Qr_M100.Next;
          end;
        end
      else
        Begin
        IND_MOV := imSemDados;
        end;
        
        with RegistroM200New do
          begin
          //Preenche o REgime M210
          with RegistroM210New do
            begin
            case Cb_Cd_Con_Soc_Apu.ItemIndex of
              0:COD_CONT := ccNaoAcumAliqBasica;                // 01 - Contribuição não-cumulativa apurada a alíquota básica
              1:COD_CONT := ccNaoAcumAliqDiferenciada;          // 02 - Contribuição não-cumulativa apurada a alíquotas diferenciadas
              2:COD_CONT := ccNaoAcumAliqUnidProduto;           // 03 - Contribuição não-cumulativa apurada a alíquota por unidade de medida de produto
              3:COD_CONT := ccNaoAcumAliqBasicaAtivImobiliaria; // 04 - Contribuição não-cumulativa apurada a alíquota básica - Atividade Imobiliária
              4:COD_CONT := ccApuradaPorST;                     // 31 - Contribuição apurada por substituição tributária
              5:COD_CONT := ccApuradaPorSTManaus;               // 32 - Contribuição apurada por substituição tributária - Vendas Zona Franca de Manaus
              6:COD_CONT := ccAcumAliqBasica;                   // 51 - Contribuição cumulativa apurada a alíquota básic
              7:COD_CONT := ccAcumAliqDiferenciada;             // 52 - Contribuição cumulativa apurada a alíquotas diferenciadas
              8:COD_CONT := ccAcumAliqUnidProduto;              // 53 - Contribuição cumulativa apurada a alíquota por unidade de medida de produto
              9:COD_CONT := ccAcumAliqBasicaAtivImobiliaria;    // 54 - Contribuição cumulativa apurada a alíquota básica - Atividade Imobiliária
              10:COD_CONT := ccApuradaAtivImobiliaria;          // 70 - Contribuição apurada da Atividade Imobiliária - RET
              11:COD_CONT := ccApuradaSCPNaoCumulativa;         // 71 - Contribuição apurada de SCP - Incidência Não Cumulativa
              12:COD_CONT := ccApuradaSCPCumulativa;            // 72 - Contribuição apurada de SCP - Incidência Cumulativa
              13:COD_CONT := ccPISPasepSalarios;                // 99 - Contribuição para o PIS/Pasep -  Folha de Salírios
              end;
            VL_REC_BRT := It_VL_Rec_Brt_M210;
            VL_BC_CONT := VL_REC_BRT;
            ALIQ_PIS := DM.Qr_Impostos.FieldByName('IPT_PIS').AsCurrency;
            QUANT_BC_PIS := 0;
            ALIQ_PIS_QUANT := 0;
            //Valor do Crédito Descontado, Apurado no Próprio Período da Escrituração (recuperado do campo 14 do Registro M100)
            VL_CONT_APUR := VL_BC_CONT * (DM.Qr_Impostos.FieldByName('IPT_PIS').AsCurrency/100);
            VL_AJUS_ACRES := 0;
            VL_AJUS_REDUC := 0;
            VL_CONT_DIFER := 0;
            VL_CONT_DIFER_ANT := 0;
            VL_CONT_PER := (VL_CONT_APUR + VL_AJUS_ACRES - VL_AJUS_REDUC - VL_CONT_DIFER + VL_CONT_DIFER_ANT);
            //Prepara campo para preencher o M200
            case Cb_Cd_Con_Soc_Apu.ItemIndex of
              0:Lc_13_M200_NC  := VL_CONT_PER;   // 01 - Contribuição não-cumulativa apurada a alíquota básica
              1:Lc_13_M200_NC  := VL_CONT_PER;   // 02 - Contribuição não-cumulativa apurada a alíquotas diferenciadas
              2:Lc_13_M200_NC  := VL_CONT_PER;   // 03 - Contribuição não-cumulativa apurada a alíquota por unidade de medida de produto
              3:Lc_13_M200_NC  := VL_CONT_PER;   // 04 - Contribuição não-cumulativa apurada a alíquota básica - Atividade Imobiliária
              5:Lc_13_M200_NC  := VL_CONT_PER;   // 32 - Contribuição apurada por substituição tributária - Vendas Zona Franca de Manaus
              11:Lc_13_M200_NC := VL_CONT_PER;  // 71 - Contribuição apurada de SCP - Incidência Não Cumulativa
              end;
              Lc_02_M600_NC := Lc_13_M200_NC;
            //Prepara campo para preencher o M200
            case Cb_Cd_Con_Soc_Apu.ItemIndex of
              4:Lc_13_M200_CUM  := VL_CONT_PER;    // 31 - Contribuição apurada por substituição tributária
              5:Lc_13_M200_CUM  := VL_CONT_PER;    // 32 - Contribuição apurada por substituição tributária - Vendas Zona Franca de Manaus
              6:Lc_13_M200_CUM  := VL_CONT_PER;    // 51 - Contribuição cumulativa apurada a alíquota básica
              7:Lc_13_M200_CUM  := VL_CONT_PER;    // 52 - Contribuição cumulativa apurada a alíquotas diferenciadas
              8:Lc_13_M200_CUM  := VL_CONT_PER;    // 53 - Contribuição cumulativa apurada a alíquota por unidade de medida de produto
              9:Lc_13_M200_CUM  := VL_CONT_PER;    // 54 - Contribuição cumulativa apurada a alíquota básica - Atividade Imobiliária
              12:Lc_13_M200_CUM := VL_CONT_PER;   // 72 - Contribuição apurada de SCP - Incidência Cumulativa
              end;

            end;//Preenche o REgime M210
          //Preenche o REgime M200
          VL_TOT_CONT_NC_PER := Lc_13_M200_NC;
          VL_TOT_CRED_DESC := 0;
          VL_TOT_CRED_DESC_ANT := 0;
          VL_TOT_CONT_NC_DEV := VL_TOT_CONT_NC_PER -VL_TOT_CRED_DESC -VL_TOT_CRED_DESC_ANT;
          VL_RET_NC := 0;
          VL_OUT_DED_NC := 0;
          VL_CONT_NC_REC := VL_TOT_CONT_NC_DEV - VL_RET_NC - VL_OUT_DED_NC;
          VL_TOT_CONT_CUM_PER := Lc_13_M200_CUM;
          VL_RET_CUM := 0;
          VL_OUT_DED_CUM := 0;
          VL_CONT_CUM_REC := VL_TOT_CONT_CUM_PER - VL_RET_CUM - VL_OUT_DED_CUM;
          VL_TOT_CONT_REC := VL_CONT_NC_REC + VL_CONT_CUM_REC;
          end;//fim M200
        //preeche dados M600
        with RegistroM600New do
          begin
          VL_TOT_CONT_NC_PER := StrToCurr(FormatCurr('#####0.00',(It_VL_Rec_Brt_M210 * (DM.Qr_Impostos.FieldByName('IPT_COFINS').AsCurrency / 100))));
          VL_TOT_CRED_DESC := 0;
          VL_TOT_CRED_DESC_ANT := 0;
          VL_TOT_CONT_NC_DEV := StrToCurr(FormatCurr('#####0.00',(It_VL_Rec_Brt_M210 * (DM.Qr_Impostos.FieldByName('IPT_COFINS').AsCurrency / 100))));
          VL_RET_NC := 0;
          VL_OUT_DED_NC := 0;
          VL_CONT_NC_REC := StrToCurr(FormatCurr('#####0.00',(It_VL_Rec_Brt_M210 * (DM.Qr_Impostos.FieldByName('IPT_COFINS').AsCurrency / 100))));
          VL_TOT_CONT_CUM_PER := 0;
          VL_RET_CUM := 0;
          VL_OUT_DED_CUM := 0;
          VL_CONT_CUM_REC := 0;
          VL_TOT_CONT_REC := StrToCurr(FormatCurr('#####0.00',(It_VL_Rec_Brt_M210 * (DM.Qr_Impostos.FieldByName('IPT_COFINS').AsCurrency / 100))));
          with RegistroM610New do
            begin
            case Cb_Cd_Con_Soc_Apu.ItemIndex of
              0:COD_CONT := ccNaoAcumAliqBasica;                // 01 - Contribuição não-cumulativa apurada a alíquota básica
              1:COD_CONT := ccNaoAcumAliqDiferenciada;          // 02 - Contribuição não-cumulativa apurada a alíquotas diferenciadas
              2:COD_CONT := ccNaoAcumAliqUnidProduto;           // 03 - Contribuição não-cumulativa apurada a alíquota por unidade de medida de produto
              3:COD_CONT := ccNaoAcumAliqBasicaAtivImobiliaria; // 04 - Contribuição não-cumulativa apurada a alíquota básica - Atividade Imobiliária
              4:COD_CONT := ccApuradaPorST;                     // 31 - Contribuição apurada por substituição tributária
              5:COD_CONT := ccApuradaPorSTManaus;               // 32 - Contribuição apurada por substituição tributária - Vendas Zona Franca de Manaus
              6:COD_CONT := ccAcumAliqBasica;                   // 51 - Contribuição cumulativa apurada a alíquota básic
              7:COD_CONT := ccAcumAliqDiferenciada;             // 52 - Contribuição cumulativa apurada a alíquotas diferenciadas
              8:COD_CONT := ccAcumAliqUnidProduto;              // 53 - Contribuição cumulativa apurada a alíquota por unidade de medida de produto
              9:COD_CONT := ccAcumAliqBasicaAtivImobiliaria;    // 54 - Contribuição cumulativa apurada a alíquota básica - Atividade Imobiliária
              10:COD_CONT := ccApuradaAtivImobiliaria;          // 70 - Contribuição apurada da Atividade Imobiliária - RET
              11:COD_CONT := ccApuradaSCPNaoCumulativa;         // 71 - Contribuição apurada de SCP - Incidência Não Cumulativa
              12:COD_CONT := ccApuradaSCPCumulativa;            // 72 - Contribuição apurada de SCP - Incidência Cumulativa
              13:COD_CONT := ccPISPasepSalarios;                // 99 - Contribuição para o PIS/Pasep -  Folha de Salírios
              end;
            //Utiliza o mesmo valor do M210 pois segue o mesmo criterio
            VL_REC_BRT := It_VL_Rec_Brt_M210;
            VL_BC_CONT := It_VL_Rec_Brt_M210;
            ALIQ_COFINS := DM.Qr_Impostos.FieldByName('IPT_COFINS').AsCurrency;
            QUANT_BC_COFINS := 0;
            ALIQ_COFINS_QUANT := 0;
            VL_CONT_APUR := StrToCurr(FormatCurr('#####0.00',(It_VL_Rec_Brt_M210 * (DM.Qr_Impostos.FieldByName('IPT_COFINS').AsCurrency / 100))));
            VL_AJUS_ACRES := 0;
            VL_AJUS_REDUC := 0;
            VL_CONT_DIFER := 0;
            VL_CONT_DIFER_ANT:= 0;
            VL_CONT_PER := StrToCurr(FormatCurr('#####0.00',(It_VL_Rec_Brt_M210 * (DM.Qr_Impostos.FieldByName('IPT_COFINS').AsCurrency / 100))));
            end;
          end; //fim do M600
      end;
    end;
  ACBrSPEDPisCofins1.WriteBloco_M;
end;

procedure TFr_SPEDPisCofins.Pc_Bloco_1;
begin
  with ACBrSPEDPisCofins1.Bloco_1 do
    begin
    with Registro1001New do
      begin
      IND_MOV := imSemDados;
      end;
    end;

  ACBrSPEDPisCofins1.WriteBloco_1;
end;

procedure TFr_SPEDPisCofins.Pc_Bloco_9;
begin
   ACBrSPEDPisCofins1.WriteBloco_9;
end;

procedure TFr_SPEDPisCofins.Pc_GerarArquivoSPED;
begin
  // Método que gera o arquivo TXT.
  ACBrSPEDPisCofins1.SaveFileTXT ;
end;

procedure TFr_SPEDPisCofins.Pc_GerarArquivoERRO;
begin
  with ACBrSPEDPisCofins1 do
    begin
    DT_INI := E_Data_Ini.Date;
    DT_FIN := E_Data_Fim.Date;
    end;

  // Método que gera o arquivo TXT.
  ACBrSPEDPisCofins1.SaveFileTXT ;

end;

procedure TFr_SPEDPisCofins.SB_SairClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_SPEDPisCofins.SB_GerarClick(Sender: TObject);
begin
  If Fc_validaGeracaoArquivo then
    Begin
    Pc_DadosFormulario('G');
    Pc_Bloco_0;
    Pc_Bloco_A;
    Pc_Bloco_C;
    Pc_Bloco_D;
    Pc_Bloco_F;
    Pc_Bloco_M;
    Pc_Bloco_1;
    Pc_Bloco_9;
    Pc_GerarArquivoSPED;
    Lb_Processamento.Caption := 'Processamento concluído';
    Application.ProcessMessages;
    end;
end;

procedure TFr_SPEDPisCofins.FormShow(Sender: TObject);
begin
  Pc_AtivarTabelas;
  Pc_IniciaVariaveis;
end;

end.
