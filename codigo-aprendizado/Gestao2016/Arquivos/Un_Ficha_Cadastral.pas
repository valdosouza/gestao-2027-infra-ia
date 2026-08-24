unit Un_Ficha_Cadastral;

interface


uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, ExtCtrls, Buttons, DB, StdCtrls, Mask, STStoredProc, ComCtrls, Grids, DBGrids, STQuery, QEdit_Setes, ControllerEmpresa;

type
  TFr_Ficha_Cadastral = class(TForm)
    Pg_Ficha_Cadastral: TPageControl;
    tbs_cadastro: TTabSheet;
    Pn_Botoes: TPanel;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Qr_DadosGerais: TSTQuery;
    Qr_Endereco: TSTQuery;
    Qr_Gravacao: TSTQuery;
    Qr_DadosProfissionais: TSTQuery;
    Qr_DadosConjuge: TSTQuery;
    Qr_DadosAvalista: TSTQuery;
    Pg_Geral: TPageControl;
    Tbs_DadosGerais: TTabSheet;
    Pnl_Dados_Gerais: TPanel;
    Label2: TLabel;
    Lb_IncEstadual: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label1: TLabel;
    Label16: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label6: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Sb_Dg_Cep: TSpeedButton;
    Label119: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    SB_Cad_cidade: TSpeedButton;
    Label127: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    Sb_Dg_Endereco: TSpeedButton;
    Label3: TLabel;
    E_Dg_Data: TDateTimePicker;
    E_Dg_cpf: TMaskEdit;
    E_Dg_Rg: TEdit;
    E_Dg_Org_Emissao: TEdit;
    E_Dg_Dt_Rg_Emissao: TDateTimePicker;
    E_Dg_Dt_Nascimento: TDateTimePicker;
    E_Dg_Nome: TEdit;
    E_Dg_Nacionalidade: TEdit;
    E_Dg_Naturalidade: TEdit;
    E_Dg_Residencia: TEdit;
    E_Dg_NomePai: TEdit;
    E_Dg_Escolaridade: TEdit;
    E_Dg_NomeMae: TEdit;
    E_Dg_Compl_Endereco: TEdit;
    E_Dg_Bairro: TEdit;
    Dblcb_Dg_Pais: TDBLookupComboBox;
    DBLCB_Dg_Cidade: TDBLookupComboBox;
    E_Dg_Regiao: TEdit;
    E_Dg_Fax: TMaskEdit;
    E_Dg_Fone: TMaskEdit;
    E_Dg_Celular: TMaskEdit;
    E_Dg_Contato: TEdit;
    Chb_Dg_Principal: TCheckBox;
    E_Dg_Fone_Comercial: TMaskEdit;
    E_Dg_Fone_Portaria: TMaskEdit;
    E_Dg_Endereco: TEdit;
    E_Dg_Cnpj_Entrega: TMaskEdit;
    E_Dg_Nr_Endereco: TEdit;
    DBLCB_Dg_Estado: TDBLookupComboBox;
    Cb_Dg_Tipo_Endereco: TComboBox;
    Rg_Dg_EstadoCivil: TRadioGroup;
    Rg_Dg_Sexo: TRadioGroup;
    Rg_Dg_SituacaoImovel: TRadioGroup;
    E_Dg_Dt_Reside_Desde: TEdit;
    E_Dg_Email: TEdit;
    E_Dg_cep: TMaskEdit;
    Tbs_DadosProfissionais: TTabSheet;
    Pnl_Dados_Profissionais: TPanel;
    Label27: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label32: TLabel;
    Label18: TLabel;
    Label33: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    SpeedButton2: TSpeedButton;
    Label43: TLabel;
    Label44: TLabel;
    Label47: TLabel;
    Label135: TLabel;
    Label46: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Sb_Dp_Cep: TSpeedButton;
    Label12: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label31: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Sb_Dp_Endereco: TSpeedButton;
    Label57: TLabel;
    Label147: TLabel;
    Label148: TLabel;
    Label149: TLabel;
    E_Dp_Classe_Prof: TEdit;
    E_Dp_Atividade: TEdit;
    E_Dp_Profissao: TEdit;
    E_Dp_VL_Renda: TEdit_Setes;
    E_Dp_VL_Outros: TEdit_Setes;
    E_Dp_Nr_Beneficio: TEdit;
    E_Dp_Dt_Admissao: TDateTimePicker;
    E_Dp_CNPJ_Empregador: TMaskEdit;
    E_Dp_Insc_Est_Empregador: TEdit;
    E_Dp_Faturamento: TEdit_Setes;
    E_Dp_Empregador: TEdit;
    E_Dp_Capital: TEdit_Setes;
    E_Dp_Natureza_Juridica: TEdit;
    Rg_Dp_Tp_Trabalho: TRadioGroup;
    E_Dp_Compl_Endereco: TEdit;
    E_Dp_Bairro: TEdit;
    Dblcb_Dp_Pais: TDBLookupComboBox;
    DBLCB_Dp_Cidade: TDBLookupComboBox;
    E_Dp_Regiao: TEdit;
    E_Dp_Fax: TMaskEdit;
    E_Dp_Fone: TMaskEdit;
    E_Dp_Celular: TMaskEdit;
    E_Dp_Contato: TEdit;
    Chb_Dp_Principal: TCheckBox;
    E_Dp_Fone_Comercial: TMaskEdit;
    E_Dp_Fone_Portaria: TMaskEdit;
    E_Dp_Endereco: TEdit;
    E_Dp_Cnpj_Entrega: TMaskEdit;
    E_Dp_Nr_Endereco: TEdit;
    DBLCB_Dp_Estado: TDBLookupComboBox;
    Cb_Dp_Tipo_Endereco: TComboBox;
    E_Dp_Valor: TEdit_Setes;
    E_Dp_Ctdr_Fone: TMaskEdit;
    E_Dp_Ctdr_Nome: TEdit;
    E_Dp_Ctdr_Fax: TMaskEdit;
    E_Dp_Ctdr_Celular: TMaskEdit;
    E_Dp_Dt_Funda_Empregador: TMaskEdit;
    E_Dp_Dt_Socio_Desde: TMaskEdit;
    E_Dp_Cep: TMaskEdit;
    Tbs_Conjuge: TTabSheet;
    Pnl_Conjuge: TPanel;
    Label50: TLabel;
    Label132: TLabel;
    Label134: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Sb_Cg_Cidade: TSpeedButton;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Sb_Cg_Cep: TSpeedButton;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label92: TLabel;
    Label95: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Sb_Cg_Endereco: TSpeedButton;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label7: TLabel;
    Label28: TLabel;
    Label113: TLabel;
    E_Cg_Rg: TEdit;
    E_Cg_Org_Emissao: TEdit;
    E_Cg_Dt_Rg_Emissao: TDateTimePicker;
    E_Cg_Dt_Nascimento: TDateTimePicker;
    E_Cg_Nome: TEdit;
    E_Cg_Nacionalidade: TEdit;
    E_Cg_Compl_Endereco: TEdit;
    E_Cg_Bairro: TEdit;
    E_Cg_Cep: TMaskEdit;
    Dblcb_Cg_Pais: TDBLookupComboBox;
    DBLCB_Cg_Cidade: TDBLookupComboBox;
    E_Cg_Regiao: TEdit;
    E_Cg_Fax: TMaskEdit;
    E_Cg_Fone: TMaskEdit;
    E_Cg_Celular: TMaskEdit;
    E_Cg_Contato: TEdit;
    Chb_Cg_Principal: TCheckBox;
    E_Cg_Fone_Comercial: TMaskEdit;
    E_Cg_Fone_Portaria: TMaskEdit;
    E_Cg_Endereco: TEdit;
    E_Cg_Cnpj_Entrega: TMaskEdit;
    E_Cg_Nr_Endereco: TEdit;
    DBLCB_Cg_Estado: TDBLookupComboBox;
    Cb_Cg_Tipo_Endereco: TComboBox;
    E_Cg_Naturalidade: TEdit;
    E_Cg_CPF: TMaskEdit;
    E_Cg_Profissao: TEdit;
    E_Cg_Vl_Renda: TEdit_Setes;
    E_Cg_Correspondencia: TEdit;
    E_Cg_Email: TEdit;
    E_Cg_Cnpj_Empregador: TMaskEdit;
    E_Cg_Insc_Est_Empregador: TEdit;
    E_Cg_Empregador: TEdit;
    Tbs_Dependentes: TTabSheet;
    Pnl_Dependentes: TPanel;
    Label51: TLabel;
    Label52: TLabel;
    Sb_Ins_Dependente: TSpeedButton;
    Sb_Alt_Dependente: TSpeedButton;
    Sb_Exc_Dependente: TSpeedButton;
    E_Dpt_Nome: TEdit;
    E_Dpt_Parentesco: TEdit;
    Dbg_Dependentes: TDBGrid;
    Tbs_Avalista: TTabSheet;
    Pnl_Avalista: TPanel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Sb_Da_Cep: TSpeedButton;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label133: TLabel;
    Label136: TLabel;
    SB_Da_cidade: TSpeedButton;
    Label142: TLabel;
    Label143: TLabel;
    Label144: TLabel;
    Label145: TLabel;
    Label146: TLabel;
    Sb_Da_Endereco: TSpeedButton;
    Label13: TLabel;
    Label150: TLabel;
    Label151: TLabel;
    Label152: TLabel;
    Label153: TLabel;
    Label154: TLabel;
    Label155: TLabel;
    E_Da_Rg: TEdit;
    E_Da_Org_Emissao: TEdit;
    E_Da_Dt_Rg_Emissao: TDateTimePicker;
    E_Da_Dt_Nascimento: TDateTimePicker;
    E_Da_Nome: TEdit;
    E_Da_Naturalidade: TEdit;
    E_Da_Compl_Endereco: TEdit;
    E_Da_Bairro: TEdit;
    E_Da_Cep: TMaskEdit;
    Dblcb_Da_Pais: TDBLookupComboBox;
    DBLCB_Da_Cidade: TDBLookupComboBox;
    E_Da_Regiao: TEdit;
    E_Da_Fax: TMaskEdit;
    E_Da_Fone: TMaskEdit;
    E_Da_Celular: TMaskEdit;
    E_Da_Contato: TEdit;
    Chb_Da_Principal: TCheckBox;
    E_Da_Fone_Comercial: TMaskEdit;
    E_Da_Fone_Portaria: TMaskEdit;
    E_Da_Endereco: TEdit;
    E_Da_Cnpj_Entrega: TMaskEdit;
    E_Da_Nr_Endereco: TEdit;
    DBLCB_Da_Estado: TDBLookupComboBox;
    Cb_Da_Tipo_Endereco: TComboBox;
    E_Da_Nacionalidade: TEdit;
    E_Da_Profissao: TEdit;
    E_Da_Vl_Renda: TEdit_Setes;
    E_Da_Correspondencia: TEdit;
    E_Da_Email: TEdit;
    E_Da_Cnpj_Empregador: TMaskEdit;
    E_Da_Insc_Est_Empregador: TEdit;
    E_Da_Empregador: TEdit;
    E_Da_CPF: TMaskEdit;
    Tbs_RefBancaria: TTabSheet;
    Pnl_Ref_Bancaria: TPanel;
    Label66: TLabel;
    Label67: TLabel;
    Label96: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Sb_Ins_Ref_Bancaria: TSpeedButton;
    Sb_Alt_Ref_Bancaria: TSpeedButton;
    Sb_Exc_Ref_Bancaria: TSpeedButton;
    E_Rb_Banco: TEdit;
    E_Rb_Agencia: TEdit;
    E_Rb_Conta: TEdit;
    E_Rb_Nr_Cheques: TEdit;
    Dbg_Refer_Bancaria: TDBGrid;
    Rg_Rb_Tipo_Conta: TRadioGroup;
    Tbs_RefPessoal: TTabSheet;
    Pnl_Ref_Pessoal: TPanel;
    Label91: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Sb_Ins_Ref_Pessoal: TSpeedButton;
    Sb_Alt_Ref_Pessoal: TSpeedButton;
    Sb_Exc_Ref_Pessoal: TSpeedButton;
    Label87: TLabel;
    E_Rp_Nome: TEdit;
    E_Rp_Afinidade: TEdit;
    DBLCB_Rp_Cidade: TDBLookupComboBox;
    E_Rp_Fone: TMaskEdit;
    Dbg_Refer_Pessoal: TDBGrid;
    Tbs_RefComercial: TTabSheet;
    Pnl_Ref_Comercial: TPanel;
    Label78: TLabel;
    Label80: TLabel;
    Sb_Ins_Ref_Comercial: TSpeedButton;
    Sb_Alt_Ref_Comercial: TSpeedButton;
    Sb_Exc_Ref_Comercial: TSpeedButton;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    E_Rc_Nome: TEdit;
    E_Rc_Fax: TMaskEdit;
    E_Rc_Fone: TMaskEdit;
    E_Rc_Celular: TMaskEdit;
    Dbg_Refer_Comercial: TDBGrid;
    Tbs_BemGarantia: TTabSheet;
    Pnl_Bem_Garantia: TPanel;
    Sb_Ins_Bem_Garantia: TSpeedButton;
    Sb_Alt_Bem_Garantia: TSpeedButton;
    Sb_Exc_Bem_Garantia: TSpeedButton;
    Label45: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    E_Bg_Documento: TEdit;
    E_Bg_Referencia: TEdit;
    E_Bg_Descricao: TEdit;
    E_Bg_Valor: TEdit_Setes;
    Dbg_BemGarantia: TDBGrid;
    Tbs_FormaPagto: TTabSheet;
    Pnl_Forma_Pagto: TPanel;
    Label4: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label79: TLabel;
    Label22: TLabel;
    E_Fp_Vl_Compra: TEdit_Setes;
    E_Fp_Parcelamento: TEdit;
    E_Fp_VL_Taxa: TEdit_Setes;
    DBLCB_Fp_Vendedor: TDBLookupComboBox;
    E_Fp_Nota_Fiscal: TEdit;
    Rg_FP_SituacaoFicha: TRadioGroup;
    Rg_Fp_TipoFicha: TRadioGroup;
    E_Fp_Pedido: TEdit;
    E_Fp_Dt_Entrega: TMaskEdit;
    Qr_Dependentes: TSTQuery;
    Ds_Dependentes: TDataSource;
    Sb_Grv_Dependente: TSpeedButton;
    Sb_Can_Dependente: TSpeedButton;
    Sb_Grv_Ref_Bancaria: TSpeedButton;
    Sb_Can_Ref_Bancaria: TSpeedButton;
    Qr_Ref_Bancaria: TSTQuery;
    Ds_Ref_Bancaria: TDataSource;
    E_Rb_Dt_Abertura: TDateTimePicker;
    Sb_Grv_Ref_Pessoal: TSpeedButton;
    Sb_Can_Ref_Pessoal: TSpeedButton;
    Qr_Ref_Pessoal: TSTQuery;
    Ds_Ref_Pessoal: TDataSource;
    Label156: TLabel;
    DBLCB_Rp_Estado: TDBLookupComboBox;
    Qr_Ref_Comercial: TSTQuery;
    Ds_Ref_Comercial: TDataSource;
    Sb_Grv_Ref_Comercial: TSpeedButton;
    Sb_Can_Ref_Comercial: TSpeedButton;
    Sb_Grv_Bem_Garantia: TSpeedButton;
    Sb_Can_Bem_Garantia: TSpeedButton;
    Qr_BemGarantia: TSTQuery;
    Ds_BemGarantia: TDataSource;
    E_Rc_Dt_Desde: TDateTimePicker;
    E_Fp_Obs: TMemo;
    Label157: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SB_GravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_Dg_CepClick(Sender: TObject);
    procedure E_Dg_cepExit(Sender: TObject);
    procedure Sb_Dg_EnderecoClick(Sender: TObject);
    procedure Sb_Dp_CepClick(Sender: TObject);
    procedure Sb_Dp_EnderecoClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure E_Dp_VL_RendaExit(Sender: TObject);
    procedure E_Dp_VL_OutrosExit(Sender: TObject);
    procedure E_Dp_ValorExit(Sender: TObject);
    procedure E_Dp_FaturamentoExit(Sender: TObject);
    procedure E_Cg_Vl_RendaExit(Sender: TObject);
    procedure E_Da_Vl_RendaExit(Sender: TObject);
    procedure E_Bg_ValorExit(Sender: TObject);
    procedure E_Fp_Vl_CompraExit(Sender: TObject);
    procedure E_Fp_VL_TaxaExit(Sender: TObject);
    procedure Sb_Ins_DependenteClick(Sender: TObject);
    procedure Sb_Alt_DependenteClick(Sender: TObject);
    procedure Sb_Grv_DependenteClick(Sender: TObject);
    procedure Sb_Can_DependenteClick(Sender: TObject);
    procedure Tbs_DependentesShow(Sender: TObject);
    procedure Sb_Exc_DependenteClick(Sender: TObject);
    procedure Sb_Ins_Ref_BancariaClick(Sender: TObject);
    procedure Sb_Alt_Ref_BancariaClick(Sender: TObject);
    procedure Sb_Exc_Ref_BancariaClick(Sender: TObject);
    procedure Sb_Grv_Ref_BancariaClick(Sender: TObject);
    procedure Sb_Can_Ref_BancariaClick(Sender: TObject);
    procedure Tbs_RefBancariaShow(Sender: TObject);
    procedure Sb_Ins_Ref_PessoalClick(Sender: TObject);
    procedure Sb_Alt_Ref_PessoalClick(Sender: TObject);
    procedure Sb_Exc_Ref_PessoalClick(Sender: TObject);
    procedure Sb_Grv_Ref_PessoalClick(Sender: TObject);
    procedure Sb_Can_Ref_PessoalClick(Sender: TObject);
    procedure Tbs_RefPessoalShow(Sender: TObject);
    procedure Sb_Ins_Ref_ComercialClick(Sender: TObject);
    procedure Sb_Alt_Ref_ComercialClick(Sender: TObject);
    procedure Sb_Exc_Ref_ComercialClick(Sender: TObject);
    procedure Sb_Grv_Ref_ComercialClick(Sender: TObject);
    procedure Sb_Can_Ref_ComercialClick(Sender: TObject);
    procedure Tbs_RefComercialShow(Sender: TObject);
    procedure Sb_Ins_Bem_GarantiaClick(Sender: TObject);
    procedure Sb_Alt_Bem_GarantiaClick(Sender: TObject);
    procedure Sb_Exc_Bem_GarantiaClick(Sender: TObject);
    procedure Sb_Grv_Bem_GarantiaClick(Sender: TObject);
    procedure Sb_Can_Bem_GarantiaClick(Sender: TObject);
    procedure Tbs_BemGarantiaShow(Sender: TObject);
    procedure Sb_Cg_CepClick(Sender: TObject);
    procedure Sb_Da_CepClick(Sender: TObject);
    procedure Sb_Cg_EnderecoClick(Sender: TObject);
    procedure Sb_Da_EnderecoClick(Sender: TObject);
  private
    { Private declarations }
    It_Inserir : Boolean;
    It_Alterar : Boolean;
    It_Excluir : Boolean;
    It_Visualizar : Boolean;  
  public
    { Public declarations }
    It_cd_ficha : Integer;
    It_Cd_Empresa : Integer;
    It_Cd_Empregador : Integer;
    It_Cd_Conjuge : Integer;
    It_Cd_Empregador_Cg : Integer;
    It_Cd_Avalista : Integer;
    It_Cd_Empregador_Da : Integer;
    It_Cd_Dependente : Integer;
    It_Cd_Ref_Bancaria : Integer;
    It_Cd_Ref_Pessoal : Integer;
    It_Cd_Ref_Comercial : Integer;
    It_Cd_Bem_Garantia : Integer;
    procedure Pc_AtivarTabelas;
    procedure Pc_formataTela;
    procedure Pc_ImagemBotao;
    procedure Pc_IniciaVariaveis;
    procedure Pc_LimpaCampos;
    procedure Pc_BuscaCep(Pc_Cep: string;
                          Pc_Pais : TDBLookupComboBox;
                          Pc_Estado : TDBLookupComboBox;
                          Pc_Cidade : TDBLookupComboBox;
                          Pc_Endereco : TEdit;
                          Pc_Bairro : TEdit;
                          Pc_Numero : TEdit);
    procedure Pc_BuscaEndereco(Pc_Cep: TMaskEdit;
                               Pc_Pais : TDBLookupComboBox;
                               Pc_Estado : TDBLookupComboBox;
                               Pc_Cidade : TDBLookupComboBox;
                               Pc_Endereco : TEdit;
                               Pc_Bairro : TEdit;
                               Pc_Numero : TEdit);
    Function Fc_ValidaGravacaoEndereco(Pc_TabSheet: TTabSheet;
                                       Pc_Cep:TMaskEdit; 
                                       Pc_Pais : TDBLookupComboBox;
                                       Pc_Estado : TDBLookupComboBox;
                                       Pc_Cidade : TDBLookupComboBox;
                                       Pc_Endereco : TEdit;
                                       Pc_Bairro : TEdit;
                                       Pc_Numero : TEdit):Boolean;

    function Fc_ValidaGravacao():boolean;
    //Aba dados Gerais
    procedure Pc_BuscaDadosGerais;
    procedure Pc_MostraDadosGerais;
    function Fc_ValidaDadosGerais():boolean;
    procedure Pc_GravaDadosGerais;
    procedure Pc_GravaDadosFichaCadastral;
    procedure Pc_GravaDadosPessoafisica(Pc_CODEMP : Integer;
                                        Pc_NACIONALIDADE : String;
                                        Pc_NATURALIDADE : String;
                                        Pc_RG_ORG_EMISSAO : String;
                                        Pc_RG_DT_EMISSAO :TDate;
                                        Pc_EST_CIVIL : String;
                                        Pc_SEXO : String;
                                        Pc_RESIDENCIA : String;
                                        Pc_SIT_RESIDENCIA : String;
                                        Pc_TEMPO_RESIDENCIA : String;
                                        Pc_ESCOLARIDADE : String;
                                        Pc_NOME_PAI : String;
                                        Pc_NOME_MAE : String;
                                        Pc_CORRESPONDENCIA : String);
    //Aba dados Profissionais
    procedure Pc_BuscaDadosProfissionais;
    procedure Pc_MostraDadosProfissionais;
    function Fc_ValidaDadosProfissionais():boolean;
    procedure Pc_GravaDadosProfissionais;
    procedure Pc_GravaDadosFichaProfissional(Pc_CODEMP : Integer;
                                             Pc_TP_TRABALHO : Integer;
                                             Pc_CLASSE : String;
                                             Pc_ATIVIDADE : String;
                                             Pc_PROFISSAO : String;
                                             Pc_VL_RENDA : Real;
                                             Pc_VL_OUTROS : Real;
                                             Pc_VALOR : Real;
                                             Pc_DT_ADMISSAO :Tdate;
                                             Pc_NR_BENEFICIO : String;
                                             Pc_CODEPG : Integer;
                                             Pc_EPG_NAT_JUR : String;
                                             Pc_EPG_FATURAMENTO : Real;
                                             Pc_EPG_CAPITAL : Real;
                                             Pc_EPG_DT_SOCIO : String;
                                             Pc_CTDR_NOME : String;
                                             Pc_CTDR_FONE : String;
                                             Pc_CTDR_FAX : String;
                                             Pc_CTDR_CELULAR : String);
    //Aba Conjuge
    procedure Pc_BuscaDadosConjuge;
    procedure Pc_MostraDadosConjuge;
    function Fc_ValidaDadosConjuge():boolean;
    procedure Pc_GravaDadosConjuge;
    procedure Pc_GravaDadosEmpregadorConjuge;
    //Aba Dependentes
    procedure Pc_LimpaCamposDependentes;
    procedure Pc_StateChangeDependentes(Pc_Estado:String);
    procedure Pc_MostraDadosDependentes;
    function Fc_ValidaDadosDependetes():boolean;
    procedure Pc_GravaDadosDependentes;
    procedure Pc_AlteraDadosDependentes;
    procedure Pc_ExcluiDadosDependentes;
    //Aba Dados Avalista
    procedure Pc_BuscaDadosAvalista;
    procedure Pc_MostraDadosAvalista;
    function Fc_ValidaDadosAvalista():boolean;
    procedure Pc_GravaDadosAvalista;
    procedure Pc_GravaDadosEmpregadorAvalista;
    //Aba Referencia Bancaria
    procedure Pc_LimpaCamposReferenciaBancaria;
    procedure Pc_StateChangeReferenciaBancaria(Pc_Estado:String);
    procedure Pc_MostraDadosReferenciaBancaria;
    function Fc_ValidaDadosReferenciaBancaria():boolean;
    procedure Pc_GravaDadosReferenciaBancaria;
    procedure Pc_AlteraDadosReferenciaBancaria;
    procedure Pc_ExcluiDadosReferenciaBancaria;
    //Aba Referencia Pessoal
    procedure Pc_LimpaCamposReferenciaPessoal;
    procedure Pc_StateChangeReferenciaPessoal(Pc_Estado:String);
    procedure Pc_MostraDadosReferenciaPessoal;
    function Fc_ValidaDadosReferenciaPessoal():boolean;
    procedure Pc_GravaDadosReferenciaPessoal;
    procedure Pc_AlteraDadosReferenciaPessoal;
    procedure Pc_ExcluiDadosReferenciaPessoal;
    //Aba Referencia comecial
    procedure Pc_LimpaCamposReferenciaComercial;
    procedure Pc_StateChangeReferenciaComercial(Pc_Estado:String);
    procedure Pc_MostraDadosReferenciaComercial;
    function Fc_ValidaDadosReferenciaComercial():boolean;
    procedure Pc_GravaDadosReferenciaComercial;
    procedure Pc_AlteraDadosReferenciaComercial;
    procedure Pc_ExcluiDadosReferenciaComercial;
    //Aba Bem em Garantia
    procedure Pc_LimpaCamposBemGarantia;
    procedure Pc_StateChangeBemGarantia(Pc_Estado:String);
    procedure Pc_MostraDadosBemGarantia;
    function Fc_ValidaDadosBemGarantia():boolean;
    procedure Pc_GravaDadosBemGarantia;
    procedure Pc_AlteraDadosBemGarantia;
    procedure Pc_ExcluiDadosBemGarantia;
    //Aba Formas de pagamentos
    procedure Pc_MostraFormasPagamento;
  end;

var
  Fr_Ficha_Cadastral: TFr_Ficha_Cadastral;

implementation

uses     Un_DM, Un_Msg, Un_Principal, env, UN_Sistema, Un_RL_Ficha_Cadastro, DateUtils, Un_WebService, Un_PesqEndereco, RN_Endereco, RN_Empresa, UN_TabelasEmListas, api_route_cep, Un_Funcoes;
{$R *.dfm}

procedure TFr_Ficha_Cadastral.Pc_BuscaCep(Pc_Cep: string;
                                          Pc_Pais : TDBLookupComboBox;
                                          Pc_Estado : TDBLookupComboBox;
                                          Pc_Cidade : TDBLookupComboBox;
                                          Pc_Endereco : TEdit;
                                          Pc_Bairro : TEdit;
                                          Pc_Numero : TEdit);
Var
  Lc_Cep : TCependereco;
begin
  Lc_Cep := Fc_BuscaPorCep(Pc_Cep);
  if (trim(Lc_Cep.FLogradouro) = '') then
  Begin
    Pc_Pais.KeyValue := 1058;
    Pc_Estado.KeyValue := Lc_Cep.FCd_UF;
    Pc_Cidade.KeyValue := Lc_Cep.FCd_Cidade;
    Pc_Endereco.Text := Lc_Cep.FLogradouro;
    PC_Bairro.Text := Lc_Cep.FBairro;
    if Pc_Numero.CanFocus then Pc_Numero.SetFocus;
  end;
end;

procedure TFr_Ficha_Cadastral.Pc_BuscaEndereco(Pc_Cep: TMaskEdit;
                                               Pc_Pais : TDBLookupComboBox;
                                               Pc_Estado : TDBLookupComboBox;
                                               Pc_Cidade : TDBLookupComboBox;
                                               Pc_Endereco : TEdit;
                                               Pc_Bairro : TEdit;
                                               Pc_Numero : TEdit);
begin
  if not Assigned(Fr_PesqEndereco) then Application.CreateForm(TFr_PesqEndereco, Fr_PesqEndereco);
  if Fr_PesqEndereco.showmodal = mrOk then
  begin
    with Fr_PesqEndereco do
    Begin
      if (StrGrd_Logradouro.RowCount > 1) and (StrGrd_Logradouro.Cells[1,StrGrd_Logradouro.row]<>'') then
      Begin
        Pc_cep.Text := StrGrd_Logradouro.Cells[1,StrGrd_Logradouro.row];
        Pc_Pais.KeyValue := 1058;
        Pc_Estado.KeyValue := StrTointdef(StrGrd_Logradouro.Cells[7,StrGrd_Logradouro.row],0);
        Pc_Cidade.KeyValue := StrTointdef(StrGrd_Logradouro.Cells[6,StrGrd_Logradouro.row],0);
        Pc_Endereco.Text := StrGrd_Logradouro.Cells[2,StrGrd_Logradouro.row];
        Pc_Bairro.Text := StrGrd_Logradouro.Cells[3,StrGrd_Logradouro.row];
        if Pc_Numero.CanFocus then Pc_Numero.SetFocus;
      end;
    end;
  end;

end;

Function TFr_Ficha_Cadastral.Fc_ValidaGravacaoEndereco(Pc_TabSheet: TTabSheet;
                                                       Pc_Cep:TMaskEdit;
                                                       Pc_Pais : TDBLookupComboBox;
                                                       Pc_Estado : TDBLookupComboBox;
                                                       Pc_Cidade : TDBLookupComboBox;
                                                       Pc_Endereco : TEdit;
                                                       Pc_Bairro : TEdit;
                                                       Pc_Numero : TEdit):Boolean;
Begin
  Result := true;
  if TRIM(Pc_Cep.Text) ='' then
    begin
    Result := false;
    Exit;
    end;

  if TRIM(Pc_Pais.Text) ='' then
    begin
    Result := false;
    Exit;
    end;

  if TRIM(Pc_Estado.Text) ='' then
    begin
    Result := false;
    Exit;
    end;

  if TRIM(Pc_Cidade.Text) ='' then
    begin
    Result := false;
    Exit;
    end;

  if (TRIM(Pc_Cep.Text) <> '') and (TRIM(Pc_Pais.Text) <>'') and (TRIM(Pc_Pais.Text) <>'') and (TRIM(Pc_Pais.Text) <> '') then
    begin
    if TRIM(Pc_Endereco.Text) ='' then
      begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Campo endereço não preenchido. Verifique.' + EOLN + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := false;
      Pg_Geral.ActivePage := Pc_TabSheet;
      Pc_Endereco.SetFocus;
      Exit;
      end;

    if TRIM(Pc_Numero.Text) ='' then
      begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Campo número do endereço não preenchido. Verifique.' + EOLN + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := false;
      Pg_Geral.ActivePage := Pc_TabSheet;
      Pc_Numero.SetFocus;
      Exit;
      end;

    if TRIM(Pc_Bairro.Text) ='' then
      begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Campo bairro não preenchido. Verifique.' + EOLN + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := false;
      Pg_Geral.ActivePage := Pc_TabSheet;
      Pc_Bairro.SetFocus;
      Exit;
      end;
    end;
end;


procedure TFr_Ficha_Cadastral.Pc_ImagemBotao;
bEGIN
  with fr_principal do
    Begin
    //BOTOES GERAIS
    SB_Gravar.Glyph := (Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancelar.Glyph := (Fc_CarregaImagemBotao('CANCELAR'));
    Sb_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));

    Sb_Ins_Dependente.Glyph := (Fc_CarregaImagemBotao('INSERIR'));
    Sb_Alt_Dependente.Glyph := (Fc_CarregaImagemBotao('ALTERAR'));
    Sb_Exc_Dependente.Glyph := (Fc_CarregaImagemBotao('EXCLUIR'));
    Sb_Grv_Dependente.Glyph := (Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Can_Dependente.Glyph := (Fc_CarregaImagemBotao('CANCELAR'));

    Sb_Ins_Ref_Bancaria.Glyph := (Fc_CarregaImagemBotao('INSERIR'));
    Sb_Alt_Ref_Bancaria.Glyph := (Fc_CarregaImagemBotao('ALTERAR'));
    Sb_Exc_Ref_Bancaria.Glyph := (Fc_CarregaImagemBotao('EXCLUIR'));
    Sb_Grv_Ref_Bancaria.Glyph := (Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Can_Ref_Bancaria.Glyph := (Fc_CarregaImagemBotao('CANCELAR'));

    Sb_Ins_Ref_Pessoal.Glyph := (Fc_CarregaImagemBotao('INSERIR'));
    Sb_Alt_Ref_Pessoal.Glyph := (Fc_CarregaImagemBotao('ALTERAR'));
    Sb_Exc_Ref_Pessoal.Glyph := (Fc_CarregaImagemBotao('EXCLUIR'));
    Sb_Grv_Ref_Pessoal.Glyph := (Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Can_Ref_Pessoal.Glyph := (Fc_CarregaImagemBotao('CANCELAR'));

    Sb_Ins_Ref_Comercial.Glyph := (Fc_CarregaImagemBotao('INSERIR'));
    Sb_Alt_Ref_Comercial.Glyph := (Fc_CarregaImagemBotao('ALTERAR'));
    Sb_Exc_Ref_Comercial.Glyph := (Fc_CarregaImagemBotao('EXCLUIR'));
    Sb_Grv_Ref_Comercial.Glyph := (Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Can_Ref_Comercial.Glyph := (Fc_CarregaImagemBotao('CANCELAR'));

    Sb_Ins_Bem_Garantia.Glyph := (Fc_CarregaImagemBotao('INSERIR'));
    Sb_Alt_Bem_Garantia.Glyph := (Fc_CarregaImagemBotao('ALTERAR'));
    Sb_Exc_Bem_Garantia.Glyph := (Fc_CarregaImagemBotao('EXCLUIR'));
    Sb_Grv_Bem_Garantia.Glyph := (Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Can_Bem_Garantia.Glyph := (Fc_CarregaImagemBotao('CANCELAR'));

    END;
END;
procedure TFr_Ficha_Cadastral.Pc_formataTela;
Var
  Lc_X:integer;
Begin
  For Lc_X:=1 to Pg_Ficha_Cadastral.PageCount do Pg_Ficha_Cadastral.Pages[Lc_X-1].TabVisible:=False;
  Pg_Ficha_Cadastral.ActivePage := tbs_cadastro;
  Pc_ImagemBotao;
end;

procedure TFr_Ficha_Cadastral.Pc_IniciaVariaveis;
Begin
  Pg_Geral.ActivePage := Tbs_DadosGerais;
  //Aba dados Gerais;
  E_Dg_Data.Date := Date;
  E_Dg_Dt_Rg_Emissao.Date := Date;
  E_Dg_Dt_Nascimento.Date := Date;
  It_Cd_Conjuge := 0;
  It_Cd_Avalista := 0;
  //Aba Forma de pagamento
  Rg_FP_SituacaoFicha.ItemIndex := 0;
  Rg_Fp_TipoFicha.ItemIndex := 0;
  E_Fp_Obs.Clear;
end;

procedure TFr_Ficha_Cadastral.Pc_AtivarTabelas;
begin
  DM.Qr_Pais.Active := True;
  DM.Qr_UF.Active := True;
  DM.Qr_Cidades.Active := True;
  DM_ListaConsultas.Pc_ListaVendedor;
end;

procedure TFr_Ficha_Cadastral.Pc_LimpaCampos;
vAR
  Lc_I : Integer;
Begin
  for Lc_I := 0 to Fr_Ficha_Cadastral.ComponentCount - 1 do
    begin
    if (Fr_Ficha_Cadastral.Components[Lc_I].ClassType = TEdit) then
      begin
      TEdit(Fr_Ficha_Cadastral.Components[Lc_I]).Clear;
      end
    else
    if (Fr_Ficha_Cadastral.Components[Lc_I].ClassType = TDBLookupComboBox) then
      begin
      TDBLookupComboBox(Fr_Ficha_Cadastral.Components[Lc_I]).KeyValue := Null;
      end
    else
    if (Fr_Ficha_Cadastral.Components[Lc_I].ClassType = TRadioGroup) then
      begin
      TRadioGroup(Fr_Ficha_Cadastral.Components[Lc_I]).ItemIndex := 0;
      end
    end;
end;

function TFr_Ficha_Cadastral.Fc_ValidaGravacao():boolean;
Begin
  Result := True;
  //Valida gravação da Aba Dados gerais
  if not Fc_ValidaDadosGerais then
    Begin
    Result := False;
    exit;
    end;
  //Valida gravação da Aba Dados Profissionais
  if not Fc_ValidaDadosProfissionais then
    Begin
    Result := False;
    exit;
    end;
  //Valida gravação da Aba Dados do Conjuge
  if not Fc_ValidaDadosConjuge then
    Begin
    Result := False;
    exit;
    end;
  //Valida gravação da Aba Dados do Avalista
  if not Fc_ValidaDadosAvalista then
    Begin
    Result := False;
    exit;
    end;

end;

//Aba dados Gerais
procedure TFr_Ficha_Cadastral.Pc_BuscaDadosGerais;
Begin
  With Qr_DadosGerais do
    Begin
    Active := false;
    SQL.Clear;
    SQL.Add('select  FCT_DATA, EMP_CNPJ,  EMP_INSC_EST,  PFS_RG_ORG_EMISSAO,  PFS_RG_DT_EMISSAO,  emp.emp_dt_funda,  emp.emp_nome, '+
            'PFS_NACIONALIDADE,  PFS_NATURALIDADE,  PFS_EST_CIVIL,  PFS_SEXO, EMP_EMAIL, PFS_ESCOLARIDADE,  PFS_NOME_PAI,  PFS_NOME_MAE, '+
            'PFS_SIT_RESIDENCIA, PFS_TEMPO_RESIDENCIA,  PFS_CORRESPONDENCIA,  FCT_CODIGO,  FCT_CODEMP,  FCT_CONJUGE,  FCT_AVALISTA, '+
            'FCT_NR_PEDIDO,  FCT_VL_COMPRA,  FCT_PARCELAS,  FCT_VL_TAXA,  FCT_CODVDO,  FCT_NR_NOTA,  FCT_DT_ENTREGA,  FCT_SIT_FICHA, '+
            'FCT_TP_FICHA, PFS_RESIDENCIA, FCT_OBS '+
            'FROM tb_empresa EMP ');
    if (It_cd_ficha > 0) and (It_Cd_Empresa > 0) then
      Begin
      SQL.Add(' INNER join tb_ficha_cadastral FCH '+
              ' ON (EMP.emp_codigo = FCH.fct_codemp) '+
              ' LEFT OUTER join  tb_pessoa_fisica PSF '+
              ' ON (PSF.pfs_codemp = EMP.emp_codigo) '+
              'WHERE (FCT_CODIGO=:FCT_CODIGO) AND (FCT_CODEMP=:EMP_CODIGO) ');
      ParamByName('FCT_CODIGO').AsInteger := It_cd_ficha;
      ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empresa;
      end
    else
      begin
      SQL.Add(' left outer join tb_ficha_cadastral FCH '+
              ' ON (EMP.emp_codigo = FCH.fct_codemp) '+
              ' left outer join  tb_pessoa_fisica PSF '+
              ' ON (PSF.pfs_codemp = EMP.emp_codigo) '+
              'WHERE (EMP_CODIGO=:EMP_CODIGO) ');
      ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empresa;
      end;
    Active := True;
    FetchAll;
    First;
    end;
end;

procedure TFr_Ficha_Cadastral.Pc_MostraDadosGerais;
Begin
  It_Cd_Conjuge := Qr_DadosGerais.FieldByName('FCT_CONJUGE').AsInteger;
  It_Cd_Avalista := Qr_DadosGerais.FieldByName('FCT_AVALISTA').AsInteger;
  if trim(Qr_DadosGerais.FieldByName('FCT_DATA').AsString) <> '' then
    E_Dg_Data.Date := Qr_DadosGerais.FieldByName('FCT_DATA').AsDateTime
  else
    E_Dg_Data.Date := Date;
  E_Dg_cpf.Text :=  Qr_DadosGerais.FieldByName('EMP_CNPJ').AsString;
  E_Dg_Rg.Text := Qr_DadosGerais.FieldByName('EMP_INSC_EST').AsString;
  E_Dg_Org_Emissao.Text := Qr_DadosGerais.FieldByName('PFS_RG_ORG_EMISSAO').AsString;
  if trim(Qr_DadosGerais.FieldByName('PFS_RG_DT_EMISSAO').AsString) <> '' then
    E_Dg_Dt_Rg_Emissao.Date := Qr_DadosGerais.FieldByName('PFS_RG_DT_EMISSAO').AsDateTime
  else
    E_Dg_Dt_Rg_Emissao.Date := Date;
  if Trim(Qr_DadosGerais.FieldByName('EMP_DT_FUNDA').AsString)<> '' then
    E_Dg_Dt_Nascimento.Date := Qr_DadosGerais.FieldByName('EMP_DT_FUNDA').AsDateTime
  else
    E_Dg_Dt_Nascimento.Date := Date;
  E_Dg_Nome.Text := Qr_DadosGerais.FieldByName('EMP_NOME').AsString;
  E_Dg_Nacionalidade.Text := Qr_DadosGerais.FieldByName('PFS_NACIONALIDADE').AsString;
  E_Dg_Naturalidade.Text := Qr_DadosGerais.FieldByName('PFS_NATURALIDADE').AsString;
  Rg_Dg_EstadoCivil.ItemIndex := StrToIntdEF(Qr_DadosGerais.FieldByName('PFS_EST_CIVIL').AsString,0);
  Rg_Dg_Sexo.ItemIndex := StrToIntdEF(Qr_DadosGerais.FieldByName('PFS_SEXO').AsString,0);
  E_Dg_Escolaridade.Text := Qr_DadosGerais.FieldByName('PFS_ESCOLARIDADE').AsString;
  E_Dg_Email.Text := Qr_DadosGerais.FieldByName('EMP_EMAIL').AsString;
  E_Dg_NomePai.Text := Qr_DadosGerais.FieldByName('PFS_NOME_PAI').AsString;
  E_Dg_NomeMae.Text := Qr_DadosGerais.FieldByName('PFS_NOME_MAE').AsString;
  //dados do Endereco
  Qr_Endereco.Active := False;
  Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empresa;
  Qr_Endereco.Active := True;
  E_Dg_Cnpj_Entrega.Text := Qr_Endereco.FieldByName('END_CNPJ').AsString;
  E_Dg_Cep.Text := Qr_Endereco.FieldByName('END_CEP').AsString;
  Dblcb_Dg_Pais.KeyValue := Qr_Endereco.FieldByName('END_PAIS').AsInteger;
  DBLCB_Dg_Estado.KeyValue := Qr_Endereco.FieldByName('END_CODUFE').AsInteger;
  DBLCB_Dg_Cidade.KeyValue := Qr_Endereco.FieldByName('END_CODCDD').AsInteger;
  E_Dg_Endereco.Text := Qr_Endereco.FieldByName('END_ENDER').AsString;
  E_Dg_Nr_Endereco.Text := Qr_Endereco.FieldByName('END_NUMERO').AsString;
  Cb_Dg_Tipo_Endereco.ItemIndex:= StrToIntDef(Qr_Endereco.FieldByName('END_TIPO').AsString,0);
  E_Dg_Compl_Endereco.Text := Qr_Endereco.FieldByName('END_COMPLEM').AsString;
  E_Dg_Bairro.Text := COPY(Qr_Endereco.FieldByName('END_BAIRRO').AsString,1,100);
  E_Dg_Regiao.Text := Qr_Endereco.FieldByName('END_REGIAO').AsString;
  E_Dg_Contato.Text := Qr_Endereco.FieldByName('END_CONTATO').AsString;
  E_Dg_Fone.Text := Qr_Endereco.FieldByName('END_FONE').AsString;
  E_Dg_Fax.Text := Qr_Endereco.FieldByName('END_FAX').AsString;
  E_Dg_Celular.Text := Qr_Endereco.FieldByName('END_CELULAR').AsString;
  E_Dg_Fone_Comercial.Text := Qr_Endereco.FieldByName('END_COMERCIAL').AsString;
  E_Dg_Fone_Portaria.Text := Qr_Endereco.FieldByName('END_PORTARIA').AsString;
  Chb_Dg_Principal.Checked := (Qr_Endereco.FieldByName('END_PRINCIPAL').AsString = 'S');
  E_Dg_Residencia.Text := Qr_DadosGerais.FieldByName('PFS_RESIDENCIA').AsString;
  E_Dg_Dt_Reside_Desde.text :=  Qr_DadosGerais.FieldByName('PFS_TEMPO_RESIDENCIA').AsString;
  Rg_Dg_SituacaoImovel.ItemIndex := StrToIntDef(Qr_DadosGerais.FieldByName('PFS_SIT_RESIDENCIA').AsString,0);

end;

function TFr_Ficha_Cadastral.Fc_ValidaDadosGerais():boolean;
Var
  Lc_DocFiscal : String;
begin
  Result := True;
  Lc_DocFiscal := ValidDocFiscal(E_Dg_cpf.Text);
  if not ( Lc_DocFiscal = OK ) then
  begin
    MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                   ' Número de C.P.F. Inválido.' + EOLN +
                   ' Verifique o C.P.F.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
     Result := False;
     Screen.Cursor := crDefault;
     E_Dg_cpf.SetFocus;
     exit;
  end;

  if trim(E_dg_Nome.Text) = '' then
    begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Campo Nome não informado Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_DadosGerais;
    E_Dg_Nome.SetFocus;
    Result := False;
    exit;
    end;

  if trim(E_Dg_Cep.Text) = '' then
    begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Campo Cep não informado Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_DadosGerais;
    E_Dg_Cep.SetFocus;
    Result := False;
    exit;
    end;
  //Aba Forma de Pagamento
  if StrToFloatDef(E_Fp_Vl_Compra.Text,0) =0 then
    begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Campo Valor da Compra não informado Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_FormaPagto;
    E_Fp_Vl_Compra.SetFocus;
    Result := False;
    exit;
    end;

  if Trim(DBLCB_Fp_Vendedor.Text) = ''  then
    begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Campo Vendedor não informado Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_FormaPagto;
    DBLCB_Fp_Vendedor.SetFocus;
    Result := False;
    exit;
    end;

end;

procedure TFr_Ficha_Cadastral.Pc_GravaDadosGerais;
Var
  Lc_St_Credito : string;
  Lc_Cd_Empresa : Integer;
  Lc_Cd_Endereco : Integer;
  Lc_Ds_Endereco : char;
  Lc_Tipo_Endereco : String;
  Empresa : TcontrollerEmpresa;
Begin
  //Verifica se a Empresa esta com o codigo Zero e Grava os dados da empresa
  //Verifica se o CNPJ Existe;
  Lc_Cd_Empresa := Fc_VerificaCNPJ_CPF(It_Cd_Empresa,E_Dg_cpf.Text);
  if Lc_Cd_Empresa > 0 then It_Cd_Empresa := Lc_Cd_Empresa;   
  if Rg_FP_SituacaoFicha.ItemIndex = 0 then Lc_St_Credito := 'L' else Lc_St_Credito := 'B';
  Empresa := TcontrollerEmpresa.Create(Self);
  with Empresa.Registro do
  Begin
    Codigo := It_Cd_Empresa;
    Tipo := 1;
    NomeRazaoSocial := E_Dg_Nome.Text;
    ApelidoFantasia := E_Dg_Nome.Text;
    CpfCNPJ := E_Dg_cpf.Text;
    InscricaoEstadual := E_Dg_Rg.Text;
    SituacaoCredito := Lc_St_Credito;
    TipoPessoa := 'F';
    CodigoVendedor := DBLCB_Fp_Vendedor.KeyValue;
    UtilizarMalaDireta := SIM;
    Email := E_Dg_Email.Text;
    DataFundacao := E_Dg_Dt_Nascimento.date;
    Ativa := 'S';
  End;
  Empresa.Salva;

  //Verifica se o Endereco com a empresa já existe
  Lc_Cd_Endereco := Fc_VerificaCepEmpresa(E_Dg_Cep.Text,E_Dg_cpf.Text);
  if Lc_Cd_Endereco > 0 then Lc_Ds_Endereco := 'U' else Lc_Ds_Endereco := 'I';
  IF Chb_Dg_Principal.Checked then Lc_Tipo_Endereco := 'S' else Lc_Tipo_Endereco := 'N';
  Fc_GravaEndereco( Lc_Cd_Endereco,
                    It_Cd_Empresa,
                    '',
                    Cb_Dg_Tipo_Endereco.Text,
                    E_Dg_Endereco.Text,
                    E_Dg_Compl_Endereco.Text,
                    E_Dg_Bairro.Text,
                    E_Dg_Cep.Text,
                    E_Dg_Contato.Text,
                    E_Dg_Fone.Text,
                    E_Dg_Fax.Text,
                    E_Dg_Celular.Text,
                    E_Dg_Fone_Comercial.Text,
                    E_Dg_Fone_Portaria.Text,
                    E_Dg_Regiao.Text,
                    E_Dg_Nr_Endereco.Text,
                    Dblcb_Dg_Pais.KeyValue,
                    DBLCB_Dg_Cidade.KeyValue,
                    DBLCB_Dg_Estado.KeyValue,
                    Lc_Tipo_Endereco,
                    False);
  Pc_GravaDadosPessoafisica(It_Cd_Empresa,
                            E_Dg_Nacionalidade.Text,
                            E_Dg_Nacionalidade.Text,
                            E_Dg_Org_Emissao.Text,
                            E_Dg_Dt_Rg_Emissao.Date,
                            IntToStr(Rg_Dg_EstadoCivil.ItemIndex),
                            IntToStr(Rg_Dg_Sexo.ItemIndex),
                            E_Dg_Residencia.Text,
                            IntToStr(Rg_Dg_SituacaoImovel.ItemIndex),
                            E_Dg_Dt_Reside_Desde.Text,
                            E_Dg_Escolaridade.Text,
                            E_Dg_NomePai.Text,
                            E_Dg_NomeMae.Text,
                            '');
end;

procedure TFr_Ficha_Cadastral.Pc_GravaDadosFichaCadastral;
Begin
  with Qr_Gravacao do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE OR INSERT INTO "TB_FICHA_CADASTRAL"( '+
            '  "FCT_CODIGO" '+
            ', "FCT_DATA" '+
            ', "FCT_CODEMP" '+
            ', "FCT_CONJUGE" '+
            ', "FCT_AVALISTA" '+
            ', "FCT_NR_PEDIDO" '+
            ', "FCT_VL_COMPRA" '+
            ', "FCT_PARCELAS" '+
            ', "FCT_VL_TAXA" '+
            ', "FCT_CODVDO" '+
            ', "FCT_NR_NOTA" '+
            ', "FCT_DT_ENTREGA" '+
            ', "FCT_SIT_FICHA" '+
            ', "FCT_TP_FICHA" '+
            ', "FCT_OBS" ) '+
            'values( '+
            '  :"FCT_CODIGO" '+
            ', :"FCT_DATA" '+
            ', :"FCT_CODEMP" '+
            ', :"FCT_CONJUGE" '+
            ', :"FCT_AVALISTA" '+
            ', :"FCT_NR_PEDIDO" '+
            ', :"FCT_VL_COMPRA" '+
            ', :"FCT_PARCELAS" '+
            ', :"FCT_VL_TAXA" '+
            ', :"FCT_CODVDO" '+
            ', :"FCT_NR_NOTA" '+
            ', :"FCT_DT_ENTREGA" '+
            ', :"FCT_SIT_FICHA" '+
            ', :"FCT_TP_FICHA" '+
            ', :"FCT_OBS" ) '+
            'MATCHING (FCT_CODIGO,FCT_CODEMP)');
    if (It_cd_ficha = 0) then It_cd_ficha := Fc_Generator('GN_FICHA_CADASTRAL','TB_FICHA_CADASTRAL','FCT_CODIGO');

    //Passagem de Parametro
    ParamByName('FCT_CODIGO').AsInteger := It_cd_ficha;
    ParamByName('FCT_DATA').AsDate := E_Dg_Data.Date;
    ParamByName('FCT_CODEMP').AsInteger := It_Cd_Empresa;
    ParamByName('FCT_CONJUGE').AsInteger := It_Cd_Conjuge;
    ParamByName('FCT_AVALISTA').AsInteger := It_Cd_Avalista;
    ParamByName('FCT_NR_PEDIDO').AsInteger := StrToIntDef(E_Fp_Pedido.Text,0);
    ParamByName('FCT_VL_COMPRA').AsCurrency := StrToFloatDef(E_Fp_Vl_Compra.Text,0);
    ParamByName('FCT_PARCELAS').AsString := E_Fp_Parcelamento.Text;
    ParamByName('FCT_VL_TAXA').AsCurrency := StrToFloatDef(E_Fp_VL_Taxa.Text,0);
    ParamByName('FCT_CODVDO').AsInteger := DBLCB_Fp_Vendedor.KeyValue;
    ParamByName('FCT_NR_NOTA').AsString := E_Fp_Nota_Fiscal.Text;
    if trim(E_Fp_Dt_Entrega.Text) = '/  /' then
      ParamByName('FCT_DT_ENTREGA').Value := null
    else
      ParamByName('FCT_DT_ENTREGA').AsDate := StrToDate(E_Fp_Dt_Entrega.Text);
    ParamByName('FCT_SIT_FICHA').AsInteger := Rg_FP_SituacaoFicha.ItemIndex;
    ParamByName('FCT_TP_FICHA').AsInteger :=  Rg_Fp_TipoFicha.ItemIndex;
    ParamByName('FCT_OBS').AsString := E_Fp_Obs.Text;
    ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    end;
end;

procedure TFr_Ficha_Cadastral.Pc_GravaDadosPessoafisica(Pc_CODEMP : Integer;
                                                        Pc_NACIONALIDADE : String;
                                                        Pc_NATURALIDADE : String;
                                                        Pc_RG_ORG_EMISSAO : String;
                                                        Pc_RG_DT_EMISSAO :TDate;
                                                        Pc_EST_CIVIL : String;
                                                        Pc_SEXO : String;
                                                        Pc_RESIDENCIA : String;
                                                        Pc_SIT_RESIDENCIA : String;
                                                        Pc_TEMPO_RESIDENCIA : String;
                                                        Pc_ESCOLARIDADE : String;
                                                        Pc_NOME_PAI : String;
                                                        Pc_NOME_MAE : String;
                                                        Pc_CORRESPONDENCIA : String);
Begin
  with Qr_Gravacao do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE OR INSERT INTO "TB_PESSOA_FISICA"( '+
            '  "PFS_CODEMP" '+
            ', "PFS_NACIONALIDADE" '+
            ', "PFS_NATURALIDADE" '+
            ', "PFS_RG_ORG_EMISSAO" '+
            ', "PFS_RG_DT_EMISSAO" '+
            ', "PFS_EST_CIVIL" '+
            ', "PFS_SEXO" '+
            ', "PFS_RESIDENCIA" '+
            ', "PFS_SIT_RESIDENCIA" '+
            ', "PFS_TEMPO_RESIDENCIA" '+
            ', "PFS_ESCOLARIDADE" '+
            ', "PFS_NOME_PAI" '+
            ', "PFS_NOME_MAE" '+
            ', "PFS_CORRESPONDENCIA" ) '+
            'values ( '+
            '  :"PFS_CODEMP" '+
            ', :"PFS_NACIONALIDADE" '+
            ', :"PFS_NATURALIDADE" '+
            ', :"PFS_RG_ORG_EMISSAO" '+
            ', :"PFS_RG_DT_EMISSAO" '+
            ', :"PFS_EST_CIVIL" '+
            ', :"PFS_SEXO" '+
            ', :"PFS_RESIDENCIA" '+
            ', :"PFS_SIT_RESIDENCIA" '+
            ', :"PFS_TEMPO_RESIDENCIA" '+
            ', :"PFS_ESCOLARIDADE" '+
            ', :"PFS_NOME_PAI" '+
            ', :"PFS_NOME_MAE" '+
            ', :"PFS_CORRESPONDENCIA" ) '+
            'MATCHING (PFS_CODEMP)');

    //Passagem de Parametro
    ParamByName('PFS_CODEMP').AsInteger := Pc_CODEMP;
    ParamByName('PFS_NACIONALIDADE').AsString := Pc_NACIONALIDADE;
    ParamByName('PFS_NATURALIDADE').AsString := Pc_NACIONALIDADE;
    ParamByName('PFS_RG_ORG_EMISSAO').AsString := Pc_RG_ORG_EMISSAO;
    ParamByName('PFS_RG_DT_EMISSAO').AsDate := Pc_RG_DT_EMISSAO;
    ParamByName('PFS_EST_CIVIL').AsString := Pc_EST_CIVIL;
    ParamByName('PFS_SEXO').AsString := Pc_SEXO;
    ParamByName('PFS_RESIDENCIA').AsString := Pc_RESIDENCIA;
    ParamByName('PFS_SIT_RESIDENCIA').AsString := Pc_SIT_RESIDENCIA;
    ParamByName('PFS_TEMPO_RESIDENCIA').AsString := Pc_TEMPO_RESIDENCIA;
    ParamByName('PFS_ESCOLARIDADE').AsString := Pc_ESCOLARIDADE;
    ParamByName('PFS_NOME_PAI').AsString := Pc_NOME_PAI;
    ParamByName('PFS_NOME_MAE').AsString := Pc_NOME_MAE;
    ParamByName('PFS_CORRESPONDENCIA').AsString := Pc_CORRESPONDENCIA;
    ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    end;

end;
//Aba dados Profissionais
procedure TFr_Ficha_Cadastral.Pc_BuscaDadosProfissionais;
Begin
  With Qr_DadosProfissionais do
    Begin
    Active := false;
    SQL.Clear;
    SQL.Add('select FCP_CODEMP, EMP_NOME, EMP_CNPJ, EMP_INSC_EST, EMP_DT_FUNDA, FCP_TP_TRABALHO, FCP_CLASSE, FCP_ATIVIDADE, FCP_PROFISSAO, FCP_VL_RENDA, FCP_VL_OUTROS, FCP_VALOR '+
            ', FCP_DT_ADMISSAO, FCP_NR_BENEFICIO, FCP_CODEPG, FCP_EPG_NAT_JUR, FCP_EPG_FATURAMENTO, FCP_EPG_CAPITAL, FCP_EPG_DT_SOCIO '+
            ', FCP_CTDR_NOME, FCP_CTDR_FONE, FCP_CTDR_FAX, FCP_CTDR_CELULAR '+
            'from tb_ficha_profissional FCP '+
            '   LEFT OUTER JOIN tb_empresa tb_empregador '+
            '   On (tb_empregador.emp_codigo = FCP.fcp_codepg) '+
            'WHERE (FCP_CODEMP=:EMP_CODIGO) ');
    ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empresa;
    Active := True;
    FetchAll;
    First;
    end;
end;

procedure TFr_Ficha_Cadastral.Pc_MostraDadosProfissionais;
Begin
  Rg_Dp_Tp_Trabalho.ItemIndex := StrToIntDef(Qr_DadosProfissionais.FieldByName('FCP_TP_TRABALHO').AsString,0);
  E_Dp_Classe_Prof.Text := Qr_DadosProfissionais.FieldByName('FCP_CLASSE').AsString;
  E_Dp_Atividade.Text := Qr_DadosProfissionais.FieldByName('FCP_ATIVIDADE').AsString;
  E_Dp_Profissao.Text := Qr_DadosProfissionais.FieldByName('FCP_PROFISSAO').AsString;
  E_Dp_VL_Renda.Text := FloatToStrF(Qr_DadosProfissionais.FieldByName('FCP_VL_RENDA').AsCurrency,ffFixed,10,2);
  E_Dp_Dt_Admissao.Date := Qr_DadosProfissionais.FieldByName('FCP_DT_ADMISSAO').AsDateTime;
  E_Dp_Nr_Beneficio.Text := Qr_DadosProfissionais.FieldByName('FCP_NR_BENEFICIO').AsString;
  E_Dp_VL_Outros.Text := FloatToStrF(Qr_DadosProfissionais.FieldByName('FCP_VL_OUTROS').AsCurrency,ffFixed,10,2);
  E_Dp_Valor.Text := FloatToStrF(Qr_DadosProfissionais.FieldByName('FCP_VALOR').AsCurrency,ffFixed,10,2);
  E_Dp_Empregador.Text := Qr_DadosProfissionais.FieldByName('EMP_NOME').AsString;
  E_Dp_CNPJ_Empregador.Text := Qr_DadosProfissionais.FieldByName('EMP_CNPJ').AsString;
  E_Dp_Insc_Est_Empregador.Text := Qr_DadosProfissionais.FieldByName('EMP_INSC_EST').AsString;
  E_Dp_Natureza_Juridica.Text := Qr_DadosProfissionais.FieldByName('FCP_EPG_NAT_JUR').AsString;
  E_Dp_Dt_Funda_Empregador.Text := Qr_DadosProfissionais.FieldByName('EMP_DT_FUNDA').AsString;
  E_Dp_Faturamento.Text := FloatToStrF(Qr_DadosProfissionais.FieldByName('FCP_EPG_FATURAMENTO').AsFloat,ffFixed,10,2);
  E_Dp_Capital.Text := FloatToStrF(Qr_DadosProfissionais.FieldByName('FCP_EPG_CAPITAL').AsFloat,ffFixed,10,2);
  E_Dp_Dt_Socio_Desde.Text := Qr_DadosProfissionais.FieldByName('FCP_EPG_DT_SOCIO').AsString;
  E_Dp_Ctdr_Nome.Text := Qr_DadosProfissionais.FieldByName('FCP_CTDR_NOME').AsString;
  E_Dp_Ctdr_Fone.Text := Qr_DadosProfissionais.FieldByName('FCP_CTDR_FONE').AsString;
  E_Dp_Ctdr_Fax.Text := Qr_DadosProfissionais.FieldByName('FCP_CTDR_FAX').AsString;
  E_Dp_Ctdr_Celular.Text := Qr_DadosProfissionais.FieldByName('FCP_CTDR_CELULAR').AsString;
  //Dados do Endereco
  It_Cd_Empregador := Qr_DadosProfissionais.FieldByName('FCP_CODEPG').AsInteger;
  Qr_Endereco.Active := False;
  Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empregador;
  Qr_Endereco.Active := True;
  E_Dp_Cnpj_Entrega.Text := Qr_Endereco.FieldByName('END_CNPJ').AsString;
  E_Dp_Cep.Text := Qr_Endereco.FieldByName('END_CEP').AsString;
  Dblcb_Dp_Pais.KeyValue := Qr_Endereco.FieldByName('END_PAIS').AsInteger;
  DBLCB_Dp_Estado.KeyValue := Qr_Endereco.FieldByName('END_CODUFE').AsInteger;
  DBLCB_Dp_Cidade.KeyValue := Qr_Endereco.FieldByName('END_CODCDD').AsInteger;
  E_Dp_Endereco.Text := Qr_Endereco.FieldByName('END_ENDER').AsString;
  E_Dp_Nr_Endereco.Text := Qr_Endereco.FieldByName('END_NUMERO').AsString;
  Cb_Dp_Tipo_Endereco.ItemIndex:= StrToIntDef(Qr_Endereco.FieldByName('END_TIPO').AsString,0);
  E_Dp_Compl_Endereco.Text := Qr_Endereco.FieldByName('END_COMPLEM').AsString;
  E_Dp_Bairro.Text := COPY(Qr_Endereco.FieldByName('END_BAIRRO').AsString,1,100);
  E_Dp_Regiao.Text := Qr_Endereco.FieldByName('END_REGIAO').AsString;
  E_Dp_Contato.Text := Qr_Endereco.FieldByName('END_CONTATO').AsString;
  E_Dp_Fone.Text := Qr_Endereco.FieldByName('END_FONE').AsString;
  E_Dp_Fax.Text := Qr_Endereco.FieldByName('END_FAX').AsString;
  E_Dp_Celular.Text := Qr_Endereco.FieldByName('END_CELULAR').AsString;
  E_Dp_Fone_Comercial.Text := Qr_Endereco.FieldByName('END_COMERCIAL').AsString;
  E_Dp_Fone_Portaria.Text := Qr_Endereco.FieldByName('END_PORTARIA').AsString;
  Chb_Dp_Principal.Checked := (Qr_Endereco.FieldByName('END_PRINCIPAL').AsString = 'S');
end;

function TFr_Ficha_Cadastral.Fc_ValidaDadosProfissionais():boolean;
Var
  Lc_DocFiscal : String;
Begin
  Result := TRUE;
  if trim(E_Dp_Profissao.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo profissão não informado. Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_DadosProfissionais;
    E_Dp_Profissao.SetFocus;
    Result := False;
    exit;
    end;

  if StrToFloatDef(E_Dp_VL_Renda.Text,0) = 0 then
    begin
    MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                   ' Valor da renda não informada. Verifique.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpAlerta);
     Result := False;
     Pg_Geral.ActivePage := Tbs_DadosProfissionais;
     E_Dp_VL_Renda.SetFocus;
     exit;
     end;

  if trim(E_Dp_Empregador.Text) <> '' then
  begin
    if TRIM(E_Dp_CNPJ_Empregador.Text) = '' then
    Begin
      MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                     ' Informando o Empregado o numero do CNPJ É Obrigatório.' + EOLN +EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      Pg_Geral.ActivePage := Tbs_DadosProfissionais;
      E_Dp_CNPJ_Empregador.SetFocus;
      exit;
    end;

    Lc_DocFiscal := ValidDocFiscal(E_Dp_CNPJ_Empregador.Text);
    if not ( Lc_DocFiscal = OK ) then
    begin
      MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                     Lc_DocFiscal + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      Pg_Geral.ActivePage := Tbs_DadosProfissionais;
      E_Dp_CNPJ_Empregador.SetFocus;
      exit;
    end;
  end;
end;

procedure TFr_Ficha_Cadastral.Pc_GravaDadosProfissionais;
Var
  Lc_St_Credito : string;
  Lc_Cd_Empregador : Integer;
  Lc_Cd_Endereco : Integer;
  Lc_Ds_Endereco : char;
  Lc_Tipo_Endereco : String;
  Empresa : TcontrollerEmpresa;
Begin
  //Verifica se a Empresa esta com o codigo Zero e Grava os dados da empresa
  //Verifica se o CNPJ do emprefador Existe para atualizar
  Lc_Cd_Empregador := Fc_VerificaCNPJ_CPF(It_Cd_Empregador,E_Dp_CNPJ_Empregador.Text);
  if Lc_Cd_Empregador > 0 then It_Cd_Empregador := Lc_Cd_Empregador;   
  Lc_St_Credito := 'L';
  Empresa := TcontrollerEmpresa.Create(Self);
  with Empresa.Registro do
  Begin
    Codigo := It_Cd_Empresa;
    Tipo := 1;
    NomeRazaoSocial := E_Dp_Empregador.Text;
    ApelidoFantasia := E_Dp_Empregador.Text;
    CpfCNPJ := E_Dp_CNPJ_Empregador.Text;
    InscricaoEstadual := E_Dp_Insc_Est_Empregador.Text;
    SituacaoCredito := Lc_St_Credito;
    TipoPessoa := 'J';
    CodigoVendedor := DBLCB_Fp_Vendedor.KeyValue;
    UtilizarMalaDireta := SIM;
    Email := E_Dg_Email.Text;
    DataFundacao := StrToDateDef(E_Dp_Dt_Funda_Empregador.Text,date);
    Ativa := 'S';
  End;
  Empresa.salva;

  //Verifica se o Endereco com a empresa já existe
  if Fc_ValidaGravacaoEndereco(Tbs_DadosProfissionais,
                               E_Dp_Cep,
                               Dblcb_Dp_Pais,
                               DBLCB_Dp_Estado,
                               DBLCB_Dp_Cidade,
                               E_Dp_Endereco,
                               E_Dp_Bairro,
                               E_Dp_Nr_Endereco) then
    Begin
    Lc_Cd_Endereco := Fc_VerificaCepEmpresa(E_Dp_Cep.Text,E_Dp_CNPJ_Empregador.Text);
    if Lc_Cd_Endereco > 0 then Lc_Ds_Endereco := 'U' else Lc_Ds_Endereco := 'I';
    IF Chb_Dp_Principal.Checked then Lc_Tipo_Endereco := 'S' else Lc_Tipo_Endereco := 'N';
    Fc_GravaEndereco( Lc_Cd_Endereco,
                      It_Cd_Empregador,
                      '',
                      Cb_Dp_Tipo_Endereco.Text,
                      E_Dp_Endereco.Text,
                      E_Dp_Compl_Endereco.Text,
                      E_Dp_Bairro.Text,
                      E_Dp_Cep.Text,
                      E_Dp_Contato.Text,
                      E_Dp_Fone.Text,
                      E_Dp_Fax.Text,
                      E_Dp_Celular.Text,
                      E_Dp_Fone_Comercial.Text,
                      E_Dp_Fone_Portaria.Text,
                      E_Dp_Regiao.Text,
                      E_Dp_Nr_Endereco.Text,
                      Dblcb_Dp_Pais.KeyValue,
                      DBLCB_Dp_Cidade.KeyValue,
                      DBLCB_Dp_Estado.KeyValue,
                      Lc_Tipo_Endereco,
                      false);
    end;
    Pc_GravaDadosFichaProfissional(It_Cd_Empresa,
                                   Rg_Dp_Tp_Trabalho.ItemIndex,
                                   E_Dp_Classe_Prof.Text,
                                   E_Dp_Atividade.Text,
                                   E_Dp_Profissao.Text,
                                   StrToFloatDef(E_Dp_VL_Renda.Text,0),
                                   StrToFloatDef(E_Dp_VL_Outros.Text,0),
                                   StrToFloatDef(E_Dp_Valor.Text,0),
                                   E_Dp_Dt_Admissao.Date,
                                   E_Dp_Nr_Beneficio.Text,
                                   It_Cd_Empregador,
                                   E_Dp_Natureza_Juridica.Text,
                                   StrToFloatDef(E_Dp_Faturamento.Text,0),
                                   StrToFloatDef(E_Dp_Capital.Text,0),
                                   E_Dp_Dt_Socio_Desde.Text,
                                   E_Dp_Ctdr_Nome.Text,
                                   E_Dp_Ctdr_FONE.Text,
                                   E_Dp_Ctdr_FAX.Text,
                                   E_Dp_Ctdr_CELULAR.Text);
end;

procedure TFr_Ficha_Cadastral.Pc_GravaDadosFichaProfissional(Pc_CODEMP : Integer;
                                                             Pc_TP_TRABALHO : Integer;
                                                             Pc_CLASSE : String;
                                                             Pc_ATIVIDADE : String;
                                                             Pc_PROFISSAO : String;
                                                             Pc_VL_RENDA : Real;
                                                             Pc_VL_OUTROS : Real;
                                                             Pc_VALOR : Real;
                                                             Pc_DT_ADMISSAO :Tdate;
                                                             Pc_NR_BENEFICIO : String;
                                                             Pc_CODEPG : Integer;
                                                             Pc_EPG_NAT_JUR : String;
                                                             Pc_EPG_FATURAMENTO : Real;
                                                             Pc_EPG_CAPITAL : Real;
                                                             Pc_EPG_DT_SOCIO : String;
                                                             Pc_CTDR_NOME : String;
                                                             Pc_CTDR_FONE : String;
                                                             Pc_CTDR_FAX : String;
                                                             Pc_CTDR_CELULAR : String);
Begin
  with Qr_Gravacao do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE OR INSERT INTO "TB_FICHA_PROFISSIONAL"( '+
            '  "FCP_CODEMP" '+
            ', "FCP_TP_TRABALHO" '+
            ', "FCP_CLASSE" '+
            ', "FCP_ATIVIDADE" '+
            ', "FCP_PROFISSAO" '+
            ', "FCP_VL_RENDA" '+
            ', "FCP_VL_OUTROS" '+
            ', "FCP_VALOR" '+
            ', "FCP_DT_ADMISSAO" '+
            ', "FCP_NR_BENEFICIO" '+
            ', "FCP_CODEPG" '+
            ', "FCP_EPG_NAT_JUR" '+
            ', "FCP_EPG_FATURAMENTO" '+
            ', "FCP_EPG_CAPITAL" '+
            ', "FCP_EPG_DT_SOCIO" '+
            ', "FCP_CTDR_NOME" '+
            ', "FCP_CTDR_FONE" '+
            ', "FCP_CTDR_FAX" '+
            ', "FCP_CTDR_CELULAR" ) '+
            'values( '+
            '  :"FCP_CODEMP" '+
            ', :"FCP_TP_TRABALHO" '+
            ', :"FCP_CLASSE" '+
            ', :"FCP_ATIVIDADE" '+
            ', :"FCP_PROFISSAO" '+
            ', :"FCP_VL_RENDA" '+
            ', :"FCP_VL_OUTROS" '+
            ', :"FCP_VALOR" '+
            ', :"FCP_DT_ADMISSAO" '+
            ', :"FCP_NR_BENEFICIO" '+
            ', :"FCP_CODEPG" '+
            ', :"FCP_EPG_NAT_JUR" '+
            ', :"FCP_EPG_FATURAMENTO" '+
            ', :"FCP_EPG_CAPITAL" '+
            ', :"FCP_EPG_DT_SOCIO" '+
            ', :"FCP_CTDR_NOME" '+
            ', :"FCP_CTDR_FONE" '+
            ', :"FCP_CTDR_FAX" '+
            ', :"FCP_CTDR_CELULAR" ) '+
            'MATCHING (FCP_CODEMP)');

    //Passagem de Parametro
    ParamByName('FCP_CODEMP').AsInteger := Pc_CODEMP;
    ParamByName('FCP_TP_TRABALHO').AsInteger := Pc_TP_TRABALHO;
    ParamByName('FCP_CLASSE').AsString := Pc_CLASSE;
    ParamByName('FCP_ATIVIDADE').AsString := Pc_ATIVIDADE;
    ParamByName('FCP_PROFISSAO').AsString := Pc_PROFISSAO;
    ParamByName('FCP_VL_RENDA').AsCurrency := Pc_VL_RENDA;
    ParamByName('FCP_VL_OUTROS').AsCurrency := pc_Vl_Outros;
    ParamByName('FCP_VALOR').AsCurrency := Pc_VALOR;
    ParamByName('FCP_DT_ADMISSAO').AsDate := Pc_DT_ADMISSAO;
    ParamByName('FCP_NR_BENEFICIO').AsString := Pc_NR_BENEFICIO;
    ParamByName('FCP_CODEPG').AsInteger := Pc_CODEPG;
    ParamByName('FCP_EPG_NAT_JUR').AsString := Pc_EPG_NAT_JUR;
    ParamByName('FCP_EPG_FATURAMENTO').AsFloat := Pc_EPG_FATURAMENTO;
    ParamByName('FCP_EPG_CAPITAL').AsFloat := Pc_EPG_CAPITAL;
    if trim(Pc_EPG_DT_SOCIO) = '/  /' then
      ParamByName('FCP_EPG_DT_SOCIO').Value := Null
    else
      ParamByName('FCP_EPG_DT_SOCIO').AsDate := StrToDateDef(Pc_EPG_DT_SOCIO,Date);
    ParamByName('FCP_CTDR_NOME').AsString := Pc_CTDR_NOME;
    ParamByName('FCP_CTDR_FONE').AsString := Pc_CTDR_FONE;
    ParamByName('FCP_CTDR_FAX').AsString := Pc_CTDR_FAX;
    ParamByName('FCP_CTDR_CELULAR').AsString := Pc_CTDR_CELULAR;
    ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    end;
end;

//Aba Conjuge
procedure TFr_Ficha_Cadastral.Pc_BuscaDadosConjuge;
Begin
  With Qr_DadosConjuge do
    Begin
    Active := false;
    SQL.Clear;
    SQL.Add('select  CJG.EMP_CNPJ,  CJG.EMP_INSC_EST,  CJG.emp_dt_funda, '+
            'CJG.EMP_NOME, CJG.EMP_EMAIL,PFS_RG_ORG_EMISSAO,  PFS_RG_DT_EMISSAO, '+
            'PFS_NACIONALIDADE,  PFS_NATURALIDADE,  FCP.fcp_profissao, FCP.fcp_vl_renda, PFS_CORRESPONDENCIA, FCP_CODEPG, '+
            'EPR.emp_nome EPR_NOME,EPR.emp_cnpj EPR_CNPJ,EPR.emp_insc_est EPR_INSC_EST '+
            'FROM tb_empresa CJG '+
            ' LEFT OUTER join  tb_pessoa_fisica PSF '+
            ' ON (PSF.pfs_codemp = CJG.emp_codigo) '+
            ' LEFT OUTER join  tb_ficha_profissional FCP '+
            ' ON (FCP.fcp_codemp = CJG.emp_codigo) '+
            ' LEFT OUTER JOIN tb_empresa EPR '+
            ' ON (EPR.emp_codigo = FCP.fcp_codepg) '+
            'WHERE (CJG.EMP_CODIGO=:EMP_CODIGO) ');
    ParamByName('EMP_CODIGO').AsInteger := It_Cd_Conjuge;
    Active := True;
    FetchAll;
    First;
    end;
end;

procedure TFr_Ficha_Cadastral.Pc_MostraDadosConjuge;
Begin
  E_Cg_CPF.Text :=  Qr_DadosConjuge.FieldByName('EMP_CNPJ').AsString;
  E_Cg_Rg.Text := Qr_DadosConjuge.FieldByName('EMP_INSC_EST').AsString;
  E_Cg_Org_Emissao.Text := Qr_DadosConjuge.FieldByName('PFS_RG_ORG_EMISSAO').AsString;
  if trim(Qr_DadosConjuge.FieldByName('PFS_RG_DT_EMISSAO').AsString) <> '' then
    E_Cg_Dt_Rg_Emissao.Date := Qr_DadosConjuge.FieldByName('PFS_RG_DT_EMISSAO').AsDateTime
  else
    E_Cg_Dt_Rg_Emissao.Date := Date;
  if Trim(Qr_DadosConjuge.FieldByName('EMP_DT_FUNDA').AsString)<> '' then
    E_Cg_Dt_Nascimento.Date := Qr_DadosConjuge.FieldByName('EMP_DT_FUNDA').AsDateTime
  else
    E_Cg_Dt_Nascimento.Date := Date;
  E_Cg_Nome.Text := Qr_DadosConjuge.FieldByName('EMP_NOME').AsString;
  E_Cg_Nacionalidade.Text := Qr_DadosConjuge.FieldByName('PFS_NACIONALIDADE').AsString;
  E_Cg_Naturalidade.Text := Qr_DadosConjuge.FieldByName('PFS_NATURALIDADE').AsString;
  E_Cg_Correspondencia.Text := Qr_DadosConjuge.FieldByName('PFS_CORRESPONDENCIA').AsString;
  E_cg_Email.Text := Qr_DadosConjuge.FieldByName('EMP_EMAIL').AsString;
  E_Cg_Profissao.Text := Qr_DadosConjuge.FieldByName('FCP_PROFISSAO').AsString;
  //Dados do empregador
  It_Cd_Empregador_Cg := Qr_DadosConjuge.FieldByName('FCP_CODEPG').AsInteger;
  E_Cg_Empregador.Text := Qr_DadosConjuge.FieldByName('EPR_NOME').AsString;
  E_Cg_Cnpj_Empregador.Text := Qr_DadosConjuge.FieldByName('EPR_CNPJ').AsString;
  E_Cg_Insc_Est_Empregador.Text := Qr_DadosConjuge.FieldByName('EPR_INSC_EST').AsString;
  E_Cg_Vl_Renda.Text := FloatToStrF(Qr_DadosConjuge.FieldByName('FCP_VL_RENDA').AsCurrency,ffFixed,10,2);
  //dados do Endereco
  Qr_Endereco.Active := False;
  Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empregador_Cg;
  Qr_Endereco.Active := True;
  E_Cg_Cnpj_Entrega.Text := Qr_Endereco.FieldByName('END_CNPJ').AsString;
  E_Cg_Cep.Text := Qr_Endereco.FieldByName('END_CEP').AsString;
  Dblcb_Cg_Pais.KeyValue := Qr_Endereco.FieldByName('END_PAIS').AsInteger;
  DBLCB_Cg_Estado.KeyValue := Qr_Endereco.FieldByName('END_CODUFE').AsInteger;
  DBLCB_Cg_Cidade.KeyValue := Qr_Endereco.FieldByName('END_CODCDD').AsInteger;
  E_Cg_Endereco.Text := Qr_Endereco.FieldByName('END_ENDER').AsString;
  E_Cg_Nr_Endereco.Text := Qr_Endereco.FieldByName('END_NUMERO').AsString;
  Cb_Cg_Tipo_Endereco.ItemIndex:= StrToIntDef(Qr_Endereco.FieldByName('END_TIPO').AsString,0);
  E_Cg_Compl_Endereco.Text := Qr_Endereco.FieldByName('END_COMPLEM').AsString;
  E_Cg_Bairro.Text := COPY(Qr_Endereco.FieldByName('END_BAIRRO').AsString,1,100);
  E_Cg_Regiao.Text := Qr_Endereco.FieldByName('END_REGIAO').AsString;
  E_Cg_Contato.Text := Qr_Endereco.FieldByName('END_CONTATO').AsString;
  E_Cg_Fone.Text := Qr_Endereco.FieldByName('END_FONE').AsString;
  E_Cg_Fax.Text := Qr_Endereco.FieldByName('END_FAX').AsString;
  E_Cg_Celular.Text := Qr_Endereco.FieldByName('END_CELULAR').AsString;
  E_Cg_Fone_Comercial.Text := Qr_Endereco.FieldByName('END_COMERCIAL').AsString;
  E_Cg_Fone_Portaria.Text := Qr_Endereco.FieldByName('END_PORTARIA').AsString;
  Chb_Cg_Principal.Checked := (Qr_Endereco.FieldByName('END_PRINCIPAL').AsString = 'S');
end;

function TFr_Ficha_Cadastral.Fc_ValidaDadosConjuge():boolean;
Var
  Lc_DocFiscal : String;
Begin
  Result := TRUE;
  if (trim(E_Cg_cpf.Text) <> '') OR (trim(E_Cg_Nome.Text) <> '')  then
  begin
    Lc_DocFiscal := ValidDocFiscal(E_Cg_CPF.Text);
    if not ( Lc_DocFiscal = OK ) then
    begin
      MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                     ' Número de C.P.F. do conjuge Inválido. Verifique' + EOLN +EOLN,
                     ['OK'], [bEscape], mpAlerta);
       Result := False;
       Pg_Geral.ActivePage := Tbs_Conjuge;
       E_Cg_cpf.SetFocus;
       exit;
    end;

    if trim(E_Cg_Nome.Text) = '' then
    begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Campo nome do conjuge não informado. Verifique.'+EOLN+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Pg_Geral.ActivePage := Tbs_Conjuge;
      E_Cg_Nome.SetFocus;
      Result := False;
      exit;
    end;
  end;

  if (trim(E_Cg_Empregador.Text) <> '') then
  begin
    Lc_DocFiscal := ValidDocFiscal(E_Dp_CNPJ_Empregador.Text);
    if not ( Lc_DocFiscal = OK ) then
    begin
      MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                     Lc_DocFiscal + EOLN,
                     ['OK'], [bEscape], mpAlerta);
       Result := False;
       Pg_Geral.ActivePage := Tbs_Conjuge;
       E_Cg_Cnpj_Empregador.SetFocus;
       exit;
    end;

    if StrToFloatDef(E_Cg_Vl_Renda.Text,0) = 0 then
    begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Campo Valor da Renda não informado Verifique.'+EOLN+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Pg_Geral.ActivePage := Tbs_Conjuge;
      E_Cg_Vl_Renda.SetFocus;
      Result := False;
      exit;
    end;
  end;
end;

procedure TFr_Ficha_Cadastral.Pc_GravaDadosConjuge;
Var
  Lc_St_Credito : string;
  Lc_Cd_Empresa : Integer;
  Lc_Cd_Endereco : Integer;
  Lc_Ds_Endereco : char;
  Lc_Tipo_Endereco : String;
  Lc_Sexo : String;
  Empresa : TcontrollerEmpresa;
Begin
  if (trim(E_Cg_cpf.Text) <> '') OR (trim(E_Cg_Nome.Text) <> '')  then
  Begin
    //Verifica se o Conjuge esta com o codigo Zero e Grava os dados da empresa
    //Verifica se o CNPJ Existe;
    Lc_Cd_Empresa := Fc_VerificaCNPJ_CPF(It_Cd_Conjuge,E_Cg_cpf.Text);
    if Lc_Cd_Empresa > 0 then It_Cd_Conjuge := Lc_Cd_Empresa;
    if Rg_FP_SituacaoFicha.ItemIndex = 0 then Lc_St_Credito := 'L' else Lc_St_Credito := 'B';
    Empresa := TcontrollerEmpresa.Create(Self);
    with Empresa.Registro do
    Begin
      Codigo := It_Cd_Conjuge;
      Tipo := 1;
      NomeRazaoSocial := E_Cg_Nome.Text;
      ApelidoFantasia := E_Cg_Nome.Text;
      CpfCNPJ := E_Cg_cpf.Text;
      InscricaoEstadual := E_Cg_Rg.Text;
      SituacaoCredito := Lc_St_Credito;
      TipoPessoa := 'F';
      CodigoVendedor := DBLCB_Fp_Vendedor.KeyValue;
      UtilizarMalaDireta := SIM;
      Email := E_Dg_Email.Text;
      DataFundacao := Date;
      Ativa := 'S';
    End;
    Empresa.Salva;

    //Verifica se o Endereco com a empresa já existe
    Lc_Cd_Endereco := Fc_VerificaCepEmpresa(E_dg_Cep.Text,E_cg_cpf.Text);
    if Lc_Cd_Endereco > 0 then Lc_Ds_Endereco := 'U' else Lc_Ds_Endereco := 'I';
    IF Chb_Dg_Principal.Checked then Lc_Tipo_Endereco := 'S' else Lc_Tipo_Endereco := 'N';
    if Fc_ValidaGravacaoEndereco(Tbs_DadosGerais,
                                 E_Dg_Cep,
                                 Dblcb_Dg_Pais,
                                 DBLCB_Dg_Estado,
                                 DBLCB_Dg_Cidade,
                                 E_Dg_Endereco,
                                 E_Dg_Bairro,
                                 E_Dg_Nr_Endereco) then
      Begin
      Fc_GravaEndereco( Lc_Cd_Endereco,
                        It_Cd_Conjuge,
                        E_Cg_CPF.Text,
                        Cb_Dg_Tipo_Endereco.Text,
                        E_Dg_Endereco.Text,
                        E_Dg_Compl_Endereco.Text,
                        E_Dg_Bairro.Text,
                        E_Dg_Cep.Text,
                        E_Dg_Contato.Text,
                        E_Dg_Fone.Text,
                        E_Dg_Fax.Text,
                        E_Dg_Celular.Text,
                        E_Dg_Fone_Comercial.Text,
                        E_Dg_Fone_Portaria.Text,
                        E_Dg_Regiao.Text,
                        E_Dg_Nr_Endereco.Text,
                        Dblcb_Dg_Pais.KeyValue,
                        DBLCB_Dg_Cidade.KeyValue,
                        DBLCB_Dg_Estado.KeyValue,
                        Lc_Tipo_Endereco,
                        False);
      end;
    //Grava os dados da pessoa fisica do conjuge
    if Rg_Dg_Sexo.ItemIndex = 0 then Lc_Sexo := '1' else Lc_Sexo := '0';
    Pc_GravaDadosPessoafisica(It_Cd_Conjuge,
                              E_Cg_Nacionalidade.Text,
                              E_Cg_Nacionalidade.Text,
                              E_Cg_Org_Emissao.Text,
                              E_Cg_Dt_Rg_Emissao.Date,
                              '1',
                              Lc_Sexo,
                              '',
                              '0',
                              '',
                              '',
                              '',
                              '',
                              E_Cg_Correspondencia.Text);
    //Grava os dados da profissionais do conjuge                              
    Pc_GravaDadosFichaProfissional(It_Cd_Conjuge,
                                   0,
                                   '',
                                   '',
                                   E_Cg_Profissao.Text,
                                   StrToFloatDef(E_Cg_VL_Renda.Text,0),
                                   0,
                                   0,
                                   Date,
                                   '',
                                   It_Cd_Empregador_Cg,
                                   '',
                                   0,
                                   0,
                                   '/  /',
                                   '',
                                   '',
                                   '',
                                   '');
    end;
end;

procedure TFr_Ficha_Cadastral.Pc_GravaDadosEmpregadorConjuge;
Var
  Lc_St_Credito : string;
  Lc_Cd_Empresa : Integer;
  Lc_Cd_Endereco : Integer;
  Lc_Ds_Endereco : char;
  Lc_Tipo_Endereco : String;
  Empresa : TcontrollerEmpresa;
Begin
  if (trim(E_Cg_Empregador.Text) <> '') then
  begin
    //Verifica se o Empregador do Conjuge esta com o codigo Zero e Grava os dados da empresa
    //Verifica se o CNPJ Existe;
    Lc_Cd_Empresa := Fc_VerificaCNPJ_CPF(It_Cd_Empregador_Cg,E_Cg_Cnpj_Empregador.Text);
    if Lc_Cd_Empresa > 0 then It_Cd_Empregador_Cg := Lc_Cd_Empresa;
    Lc_St_Credito := 'B';
    Empresa := TcontrollerEmpresa.Create(Self);
    with Empresa.Registro do
    Begin
      Codigo := It_Cd_Empregador_Cg;
      Tipo := 1;
      NomeRazaoSocial := E_Cg_Empregador.Text;
      ApelidoFantasia := E_Cg_Empregador.Text;
      CpfCNPJ := E_Cg_Cnpj_Empregador.Text;
      InscricaoEstadual := E_Cg_Insc_Est_Empregador.Text;
      SituacaoCredito := Lc_St_Credito;
      TipoPessoa := 'J';
      CodigoVendedor := DBLCB_fp_Vendedor.KeyValue;
      UtilizarMalaDireta := SIM;
      Email := E_Cg_Email.Text;
      DataFundacao := E_Cg_Dt_Nascimento.Date;
      Ativa := 'S';
    End;
    Empresa.Salva;


    //Verifica se o Endereco com a empresa já existe
    Lc_Cd_Endereco := Fc_VerificaCepEmpresa(E_Cg_Cep.Text,E_Cg_Cnpj_Empregador.Text);
    if Lc_Cd_Endereco > 0 then Lc_Ds_Endereco := 'U' else Lc_Ds_Endereco := 'I';
    IF Chb_Dg_Principal.Checked then Lc_Tipo_Endereco := 'S' else Lc_Tipo_Endereco := 'N';
    if Fc_ValidaGravacaoEndereco(Tbs_Conjuge,
                                 E_Cg_Cep,
                                 Dblcb_Cg_Pais,
                                 DBLCB_Cg_Estado,
                                 DBLCB_Cg_Cidade,
                                 E_Cg_Endereco,
                                 E_Cg_Bairro,
                                 E_Cg_Nr_Endereco) then
    Begin
      Fc_GravaEndereco( Lc_Cd_Endereco,
                        It_Cd_Empregador_Cg,
                        E_Cg_Cnpj_Empregador.Text,
                        Cb_Cg_Tipo_Endereco.Text,
                        E_Cg_Endereco.Text,
                        E_Cg_Compl_Endereco.Text,
                        E_Cg_Bairro.Text,
                        E_Cg_Cep.Text,
                        E_Cg_Contato.Text,
                        E_Cg_Fone.Text,
                        E_Cg_Fax.Text,
                        E_Cg_Celular.Text,
                        E_Cg_Fone_Comercial.Text,
                        E_Cg_Fone_Portaria.Text,
                        E_Cg_Regiao.Text,
                        E_Cg_Nr_Endereco.Text,
                        Dblcb_Cg_Pais.KeyValue,
                        DBLCB_Cg_Cidade.KeyValue,
                        DBLCB_Cg_Estado.KeyValue,
                        Lc_Tipo_Endereco,
                        false);
    end;
  end;
end;

//Aba Dependentes
procedure TFr_Ficha_Cadastral.Pc_LimpaCamposDependentes;
Begin
  E_Dpt_Nome.Clear;
  E_Dpt_Parentesco.Clear;
  It_Cd_Dependente := 0;
end;

procedure TFr_Ficha_Cadastral.Pc_StateChangeDependentes(Pc_Estado:String);
Begin
  E_Dpt_Nome.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  E_Dpt_Parentesco.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  Sb_Ins_Dependente.Enabled := not ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  Sb_Alt_Dependente.Enabled := not ((Pc_Estado = 'I') or (Pc_Estado = 'U')) and (Qr_Dependentes.RecordCount > 0);
  Sb_Exc_Dependente.Enabled := not ((Pc_Estado = 'I') or (Pc_Estado = 'U'))and (Qr_Dependentes.RecordCount > 0);
  Sb_Grv_Dependente.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  Sb_Can_Dependente.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
end;

procedure TFr_Ficha_Cadastral.Pc_MostraDadosDependentes;
Begin
  with Qr_Dependentes do
    Begin
    Active := False;
    ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empresa;
    Active := true;
    end;
  Pc_StateChangeDependentes('N');
end;

function TFr_Ficha_Cadastral.Fc_ValidaDadosDependetes():boolean;
Begin
  Result := True;
  if trim(E_Dpt_Nome.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo nome do Dependente não informado. Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_Dependentes;
    E_Dpt_Nome.SetFocus;
    Result := False;
    exit;
    end;
  if trim(E_Dpt_Parentesco.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo parentesco não informado. Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_Dependentes;
    E_Dpt_Parentesco.SetFocus;
    Result := False;
    exit;
    end;
end;

procedure TFr_Ficha_Cadastral.Pc_GravaDadosDependentes;
Begin
  with Qr_Gravacao do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE OR INSERT INTO TB_DEPENDENTE( '+
            '  DPT_CODIGO '+
            ', DPT_CODEMP '+
            ', DPT_NOME '+
            ', DPT_PARENTESCO )'+
            'values( '+
            '  :DPT_CODIGO '+
            ', :DPT_CODEMP '+
            ', :DPT_NOME '+
            ', :DPT_PARENTESCO )'+
            'MATCHING (DPT_CODIGO)');

    //Passagem de Parametro
    if It_Cd_Dependente = 0 then It_Cd_Dependente := Fc_Generator('GN_DEPENDENTE','TB_DEPENDENTE','DPT_CODIGO');
    ParamByName('DPT_CODIGO').AsInteger := It_Cd_Dependente;
    ParamByName('DPT_CODEMP').AsInteger := It_Cd_Empresa;
    ParamByName('DPT_NOME').AsString := E_Dpt_Nome.Text;
    ParamByName('DPT_PARENTESCO').AsString := E_Dpt_Parentesco.Text;
    ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    end;
end;

procedure TFr_Ficha_Cadastral.Pc_AlteraDadosDependentes;
Begin
  Pc_StateChangeDependentes('U');
  E_Dpt_Nome.Text := Qr_Dependentes.FieldByname('DPT_NOME').AsString;
  E_Dpt_Parentesco.Text := Qr_Dependentes.FieldByname('DPT_PARENTESCO').AsString;
  E_Dpt_Nome.SetFocus;
  It_Cd_Dependente := Qr_Dependentes.FieldByname('DPT_CODIGO').AsInteger;
end;

procedure TFr_Ficha_Cadastral.Pc_ExcluiDadosDependentes;
Begin
  with Qr_Gravacao do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('DELETE FROM TB_DEPENDENTE '+
            'WHERE DPT_CODIGO=:DPT_CODIGO ');
    //Passagem de Parametro
    ParamByName('DPT_CODIGO').AsInteger := It_Cd_Dependente;
    ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    end;
end;

//Aba Dados Avalista
procedure TFr_Ficha_Cadastral.Pc_BuscaDadosAvalista;
Begin
  With Qr_DadosAvalista do
    Begin
    Active := false;
    SQL.Clear;
    SQL.Add('select AVA.EMP_CNPJ, AVA.EMP_INSC_EST, AVA.emp_dt_funda, AVA.EMP_NOME, AVA.EMP_EMAIL,PFS_RG_ORG_EMISSAO, PFS_RG_DT_EMISSAO,'+
            'PFS_NACIONALIDADE,  PFS_NATURALIDADE,  FCP.fcp_profissao, FCP.fcp_vl_renda, PFS_CORRESPONDENCIA, FCP_CODEPG, '+
            'EPR.emp_nome EPR_NOME,EPR.emp_cnpj EPR_CNPJ,EPR.emp_insc_est EPR_INSC_EST '+
            'FROM tb_empresa AVA '+
            ' LEFT OUTER join  tb_pessoa_fisica PSF '+
            ' ON (PSF.pfs_codemp = AVA.emp_codigo) '+
            ' LEFT OUTER join  tb_ficha_profissional FCP '+
            ' ON (FCP.fcp_codemp = AVA.emp_codigo) '+
            ' LEFT OUTER JOIN tb_empresa EPR '+
            ' ON (EPR.emp_codigo = FCP.fcp_codepg) '+
            'WHERE (AVA.emp_codigo=:EMP_CODIGO)');
    ParamByName('EMP_CODIGO').AsInteger := It_Cd_Avalista;
    Active := True;
    FetchAll;
    First;
    end;
end;

procedure TFr_Ficha_Cadastral.Pc_MostraDadosAvalista;
Begin
  E_Da_CPF.Text :=  Qr_DadosAvalista.FieldByName('EMP_CNPJ').AsString;
  E_Da_Rg.Text := Qr_DadosAvalista.FieldByName('EMP_INSC_EST').AsString;
  E_Da_Org_Emissao.Text := Qr_DadosAvalista.FieldByName('PFS_RG_ORG_EMISSAO').AsString;
  if trim(Qr_DadosAvalista.FieldByName('PFS_RG_DT_EMISSAO').AsString) <> '' then
    E_Cg_Dt_Rg_Emissao.Date := Qr_DadosAvalista.FieldByName('PFS_RG_DT_EMISSAO').AsDateTime
  else
    E_Da_Dt_Rg_Emissao.Date := Date;
  if Trim(Qr_DadosAvalista.FieldByName('EMP_DT_FUNDA').AsString)<> '' then
    E_Da_Dt_Nascimento.Date := Qr_DadosAvalista.FieldByName('EMP_DT_FUNDA').AsDateTime
  else
    E_Da_Dt_Nascimento.Date := Date;
  E_Da_Nome.Text := Qr_DadosAvalista.FieldByName('EMP_NOME').AsString;
  E_Da_Nacionalidade.Text := Qr_DadosAvalista.FieldByName('PFS_NACIONALIDADE').AsString;
  E_Da_Naturalidade.Text := Qr_DadosAvalista.FieldByName('PFS_NATURALIDADE').AsString;
  E_Da_Correspondencia.Text := Qr_DadosAvalista.FieldByName('PFS_CORRESPONDENCIA').AsString;
  E_Da_Email.Text := Qr_DadosAvalista.FieldByName('EMP_EMAIL').AsString;
  E_Da_Profissao.Text := Qr_DadosAvalista.FieldByName('FCP_PROFISSAO').AsString;
  //Dados do empregador
  It_Cd_Empregador_Da := Qr_DadosAvalista.FieldByName('FCP_CODEPG').AsInteger;
  E_Da_Empregador.Text := Qr_DadosAvalista.FieldByName('EPR_NOME').AsString;
  E_Da_Cnpj_Empregador.Text := Qr_DadosAvalista.FieldByName('EPR_CNPJ').AsString;
  E_Da_Insc_Est_Empregador.Text := Qr_DadosAvalista.FieldByName('EPR_INSC_EST').AsString;
  E_Da_Vl_Renda.Text := FloatToStrF(Qr_DadosAvalista.FieldByName('FCP_VL_RENDA').AsCurrency,ffFixed,10,2);
  //dados do Endereco
  Qr_Endereco.Active := False;
  Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empregador_Da;
  Qr_Endereco.Active := True;
  E_Da_Cnpj_Entrega.Text := Qr_Endereco.FieldByName('END_CNPJ').AsString;
  E_Da_Cep.Text := Qr_Endereco.FieldByName('END_CEP').AsString;
  Dblcb_Da_Pais.KeyValue := Qr_Endereco.FieldByName('END_PAIS').AsInteger;
  DBLCB_Da_Estado.KeyValue := Qr_Endereco.FieldByName('END_CODUFE').AsInteger;
  DBLCB_Da_Cidade.KeyValue := Qr_Endereco.FieldByName('END_CODCDD').AsInteger;
  E_Da_Endereco.Text := Qr_Endereco.FieldByName('END_ENDER').AsString;
  E_Da_Nr_Endereco.Text := Qr_Endereco.FieldByName('END_NUMERO').AsString;
  Cb_Da_Tipo_Endereco.ItemIndex:= StrToIntDef(Qr_Endereco.FieldByName('END_TIPO').AsString,0);
  E_Da_Compl_Endereco.Text := Qr_Endereco.FieldByName('END_COMPLEM').AsString;
  E_Da_Bairro.Text := COPY(Qr_Endereco.FieldByName('END_BAIRRO').AsString,1,100);
  E_Da_Regiao.Text := Qr_Endereco.FieldByName('END_REGIAO').AsString;
  E_Da_Contato.Text := Qr_Endereco.FieldByName('END_CONTATO').AsString;
  E_Da_Fone.Text := Qr_Endereco.FieldByName('END_FONE').AsString;
  E_Da_Fax.Text := Qr_Endereco.FieldByName('END_FAX').AsString;
  E_Da_Celular.Text := Qr_Endereco.FieldByName('END_CELULAR').AsString;
  E_Da_Fone_Comercial.Text := Qr_Endereco.FieldByName('END_COMERCIAL').AsString;
  E_Da_Fone_Portaria.Text := Qr_Endereco.FieldByName('END_PORTARIA').AsString;
  Chb_Da_Principal.Checked := (Qr_Endereco.FieldByName('END_PRINCIPAL').AsString = 'S');
end;

function TFr_Ficha_Cadastral.Fc_ValidaDadosAvalista():boolean;
Var
  Lc_DocFiscal : String;
Begin
  Result := TRUE;
  if (trim(E_Da_cpf.Text) <> '') OR (trim(E_Da_Nome.Text) <> '')  then
  begin
    Result := True;
    Lc_DocFiscal := ValidDocFiscal(E_Da_cpf.Text);
    if not ( Lc_DocFiscal = OK ) then
    begin
      MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                     ' Número de C.P.F. Inválido.' + EOLN +
                     ' Verifique o C.P.F.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
       Result := False;
       Screen.Cursor := crDefault;
       E_Dg_cpf.SetFocus;
       exit;
    end;

    if trim(E_Da_Nome.Text) = '' then
    begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Campo nome do avalista não informado. Verifique.'+EOLN+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Pg_Geral.ActivePage := Tbs_Avalista;
      E_Da_Nome.SetFocus;
      Result := False;
      exit;
    end;
  end;

  if (trim(E_Da_Empregador.Text) <> '') then
  begin
    Lc_DocFiscal := ValidDocFiscal(E_Dp_CNPJ_Empregador.Text);
    if not ( Lc_DocFiscal = OK ) then
    begin
       Result := False;
       Pg_Geral.ActivePage := Tbs_Avalista;
       E_DA_Cnpj_Empregador.SetFocus;
       exit;
    end;

    if StrToFloatDef(E_Da_Vl_Renda.Text,0) = 0 then
    begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Campo Valor da Renda não informado Verifique.'+EOLN+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Pg_Geral.ActivePage := Tbs_Avalista;
      E_Da_Vl_Renda.SetFocus;
      Result := False;
      exit;
    end;
  end;
end;

procedure TFr_Ficha_Cadastral.Pc_GravaDadosAvalista;
Var
  Lc_St_Credito : string;
  Lc_Cd_Empresa : Integer;
  Lc_Cd_Endereco : Integer;
  Lc_Ds_Endereco : char;
  Lc_Tipo_Endereco : String;
  Lc_Sexo : String;
  Empresa : TcontrollerEmpresa;
Begin
  if (trim(E_Da_cpf.Text) <> '') OR (trim(E_Da_Nome.Text) <> '')  then
  Begin
    //Verifica se o Conjuge esta com o codigo Zero e Grava os dados da empresa
    //Verifica se o CNPJ Existe;
    Lc_Cd_Empresa := Fc_VerificaCNPJ_CPF(It_Cd_Avalista,E_Da_cpf.Text);
    if Lc_Cd_Empresa > 0 then It_Cd_Avalista := Lc_Cd_Empresa;
    if Rg_FP_SituacaoFicha.ItemIndex = 0 then Lc_St_Credito := 'L' else Lc_St_Credito := 'B';
    Empresa := TcontrollerEmpresa.Create(Self);
    with Empresa.Registro do
    Begin
      Codigo := It_Cd_Avalista;
      Tipo := 1;
      NomeRazaoSocial := E_Da_Nome.Text;
      ApelidoFantasia := E_Da_Nome.Text;
      CpfCNPJ := E_Da_cpf.Text;
      InscricaoEstadual := E_Da_Rg.Text;
      SituacaoCredito := Lc_St_Credito;
      TipoPessoa := 'F';
      CodigoVendedor := DBLCB_Fp_Vendedor.KeyValue;
      UtilizarMalaDireta := SIM;
      Email := E_Da_Email.Text;
      DataFundacao := E_Da_Dt_Nascimento.date;
      Ativa := 'S';
    End;
    Empresa.Salva;

    //Verifica se o Endereco com a empresa já existe
    Lc_Cd_Endereco := Fc_VerificaCepEmpresa(E_Da_Cep.Text,E_Da_cpf.Text);
    if Lc_Cd_Endereco > 0 then Lc_Ds_Endereco := 'U' else Lc_Ds_Endereco := 'I';
    IF Chb_Dg_Principal.Checked then Lc_Tipo_Endereco := 'S' else Lc_Tipo_Endereco := 'N';
    if Fc_ValidaGravacaoEndereco(Tbs_Avalista,
                                 E_Da_Cep,
                                 Dblcb_Da_Pais,
                                 DBLCB_Da_Estado,
                                 DBLCB_Da_Cidade,
                                 E_Da_Endereco,
                                 E_Da_Bairro,
                                 E_Da_Nr_Endereco) then
      Begin
      Fc_GravaEndereco( Lc_Cd_Endereco,
                        It_Cd_Avalista,
                        E_Da_CPF.Text,
                        Cb_Dg_Tipo_Endereco.Text,
                        E_Da_Endereco.Text,
                        E_Da_Compl_Endereco.Text,
                        E_Da_Bairro.Text,
                        E_Da_Cep.Text,
                        E_Da_Contato.Text,
                        E_Da_Fone.Text,
                        E_Da_Fax.Text,
                        E_Da_Celular.Text,
                        E_Da_Fone_Comercial.Text,
                        E_Da_Fone_Portaria.Text,
                        E_Da_Regiao.Text,
                        E_Da_Nr_Endereco.Text,
                        Dblcb_Da_Pais.KeyValue,
                        DBLCB_Da_Cidade.KeyValue,
                        DBLCB_Da_Estado.KeyValue,
                        Lc_Tipo_Endereco,
                        False);
      end;
    //Grava os dados da pessoa fisica do conjuge
    if Rg_Dg_Sexo.ItemIndex = 0 then Lc_Sexo := '1' else Lc_Sexo := '0';
    Pc_GravaDadosPessoafisica(It_Cd_Avalista,
                              E_Da_Nacionalidade.Text,
                              E_Da_Nacionalidade.Text,
                              E_Da_Org_Emissao.Text,
                              E_Da_Dt_Rg_Emissao.Date,
                              '1',
                              Lc_Sexo,
                              '',
                              '0',
                              '',
                              '',
                              '',
                              '',
                              E_Da_Correspondencia.Text);
    //Grava os dados da profissionais do conjuge
    Pc_GravaDadosFichaProfissional(It_Cd_Avalista,
                                   0,
                                   '',
                                   '',
                                   E_Da_Profissao.Text,
                                   StrToFloatDef(E_Da_VL_Renda.Text,0),
                                   0,
                                   0,
                                   Date,
                                   '',
                                   It_Cd_Empregador_Da,
                                   '',
                                   0,
                                   0,
                                   '/  /',
                                   '',
                                   '',
                                   '',
                                   '');
    end;
end;

procedure TFr_Ficha_Cadastral.Pc_GravaDadosEmpregadorAvalista;
Var
  Lc_St_Credito : string;
  Lc_Cd_Empresa : Integer;
  Lc_Cd_Endereco : Integer;
  Lc_Ds_Endereco : char;
  Lc_Tipo_Endereco : String;
  Empresa : TcontrollerEmpresa;
Begin
  if (trim(E_Da_Empregador.Text) <> '') then
  begin
    //Verifica se o Empregador do Conjuge esta com o codigo Zero e Grava os dados da empresa
    //Verifica se o CNPJ Existe;
    Lc_Cd_Empresa := Fc_VerificaCNPJ_CPF(It_Cd_Empregador_Da,E_Da_Cnpj_Empregador.Text);
    if Lc_Cd_Empresa > 0 then It_Cd_Empregador_Da := Lc_Cd_Empresa;
    Lc_St_Credito := 'B';
    Empresa := TcontrollerEmpresa.Create(Self);
    with Empresa.Registro do
    Begin
      Codigo := It_Cd_Empregador_Da;
      Tipo := 1;
      NomeRazaoSocial := E_Da_Empregador.Text;
      ApelidoFantasia := E_Da_Empregador.Text;
      CpfCNPJ := E_Da_Cnpj_Empregador.Text;
      InscricaoEstadual := E_Da_Insc_Est_Empregador.Text;
      SituacaoCredito := Lc_St_Credito;
      TipoPessoa := 'J';
      CodigoVendedor := DBLCB_Fp_Vendedor.KeyValue;
      UtilizarMalaDireta := SIM;
      Email := E_Da_Email.Text;
      DataFundacao := E_Da_Dt_Nascimento.date;
      Ativa := 'S';
    End;
    Empresa.Salva;

    //Verifica se o Endereco com a empresa já existe
    Lc_Cd_Endereco := Fc_VerificaCepEmpresa(E_Da_Cep.Text,E_Da_Cnpj_Empregador.Text);
    if Lc_Cd_Endereco > 0 then Lc_Ds_Endereco := 'U' else Lc_Ds_Endereco := 'I';
    IF Chb_Dg_Principal.Checked then Lc_Tipo_Endereco := 'S' else Lc_Tipo_Endereco := 'N';
    if Fc_ValidaGravacaoEndereco(Tbs_Avalista,
                                 E_Da_Cep,
                                 Dblcb_Da_Pais,
                                 DBLCB_Da_Estado,
                                 DBLCB_Da_Cidade,
                                 E_Da_Endereco,
                                 E_Da_Bairro,
                                 E_Da_Nr_Endereco) then
      Begin
      Fc_GravaEndereco( Lc_Cd_Endereco,
                        It_Cd_Empregador_Da,
                        E_Da_Cnpj_Empregador.Text,
                        Cb_Da_Tipo_Endereco.Text,
                        E_Da_Endereco.Text,
                        E_Da_Compl_Endereco.Text,
                        E_Da_Bairro.Text,
                        E_Da_Cep.Text,
                        E_Da_Contato.Text,
                        E_Da_Fone.Text,
                        E_Da_Fax.Text,
                        E_Da_Celular.Text,
                        E_Da_Fone_Comercial.Text,
                        E_Da_Fone_Portaria.Text,
                        E_Da_Regiao.Text,
                        E_Da_Nr_Endereco.Text,
                        Dblcb_Da_Pais.KeyValue,
                        DBLCB_Da_Cidade.KeyValue,
                        DBLCB_Da_Estado.KeyValue,
                        Lc_Tipo_Endereco,
                        false);
      end;
    end;
end;


//Aba Referencia Bancaria
procedure TFr_Ficha_Cadastral.Pc_LimpaCamposReferenciaBancaria;
Begin
  Rg_Rb_Tipo_Conta.ItemIndex := 0;
  E_Rb_Banco.Clear;
  E_Rb_Agencia.Clear;
  E_Rb_Conta.Clear;
  E_Rb_Dt_Abertura.date := date;
  E_Rb_Nr_Cheques.Clear;
  It_Cd_Ref_Bancaria := 0;
end;

procedure TFr_Ficha_Cadastral.Pc_StateChangeReferenciaBancaria(Pc_Estado:String);
Begin
  Rg_Rb_Tipo_Conta.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  E_Rb_Banco.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  E_Rb_Agencia.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  E_Rb_Conta.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  E_Rb_Dt_Abertura.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  E_Rb_Nr_Cheques.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));

  Sb_Ins_Ref_Bancaria.Enabled := not ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  Sb_Alt_Ref_Bancaria.Enabled := not ((Pc_Estado = 'I') or (Pc_Estado = 'U')) and (Qr_Ref_Bancaria.RecordCount > 0);
  Sb_Exc_Ref_Bancaria.Enabled := not ((Pc_Estado = 'I') or (Pc_Estado = 'U'))and (Qr_Ref_Bancaria.RecordCount > 0);
  Sb_Grv_Ref_Bancaria.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  Sb_Can_Ref_Bancaria.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
end;

procedure TFr_Ficha_Cadastral.Pc_MostraDadosReferenciaBancaria;
Begin
  with Qr_Ref_Bancaria do
    Begin
    Active := False;
    ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empresa;
    Active := true;
    end;
  Pc_StateChangeReferenciaBancaria('N');
end;

function TFr_Ficha_Cadastral.Fc_ValidaDadosReferenciaBancaria():boolean;
Begin
  Result := True;
  if trim(E_Rb_Banco.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Banco não informado. Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_RefBancaria;
    E_Rb_Banco.SetFocus;
    Result := False;
    exit;
    end;
  if trim(E_Rb_Agencia.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo agência não informado. Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_RefBancaria;
    E_Rb_Agencia.SetFocus;
    Result := False;
    exit;
    end;
  if trim(E_Rb_Conta.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo conta corrente não informado. Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_RefBancaria;
    E_Rb_Conta.SetFocus;
    Result := False;
    exit;
    end;
  if trim(E_Rb_Nr_Cheques.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo número do cheque não informado. Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_RefBancaria;
    E_Rb_Nr_Cheques.SetFocus;
    Result := False;
    exit;
    end;

end;

procedure TFr_Ficha_Cadastral.Pc_GravaDadosReferenciaBancaria;
Begin
  with Qr_Gravacao do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE OR INSERT INTO TB_REFER_BANCARIA( '+
            '  RFB_CODIGO '+
            ', RFB_CODEMP '+
            ', RFB_BANCO '+
            ', RFB_AGENCIA '+
            ', RFB_CONTA '+
            ', RFB_DT_ABERTURA '+
            ', RFB_NR_CHEQUE '+
            ', RFB_TP_CONTA ) '+
            'values( '+
            '  :RFB_CODIGO '+
            ', :RFB_CODEMP '+
            ', :RFB_BANCO '+
            ', :RFB_AGENCIA '+
            ', :RFB_CONTA '+
            ', :RFB_DT_ABERTURA '+
            ', :RFB_NR_CHEQUE '+
            ', :RFB_TP_CONTA ) '+
            'MATCHING (RFB_CODIGO)');

    //Passagem de Parametro
    if It_Cd_Ref_Bancaria = 0 then It_Cd_Ref_Bancaria := Fc_Generator('GN_REFER_BANCARIA','TB_REFER_BANCARIA','RFB_CODIGO');
    ParamByName('RFB_CODIGO').AsInteger := It_Cd_Ref_Bancaria;
    ParamByName('RFB_CODEMP').AsInteger := It_Cd_Empresa;
    ParamByName('RFB_BANCO').AsString := E_Rb_Banco.Text;
    ParamByName('RFB_AGENCIA').AsString := E_Rb_Agencia.Text;
    ParamByName('RFB_CONTA').AsString := E_Rb_Conta.Text;
    ParamByName('RFB_DT_ABERTURA').AsDate := E_Rb_Dt_Abertura.Date;
    ParamByName('RFB_NR_CHEQUE').AsString := E_Rb_Nr_Cheques.Text;
    ParamByName('RFB_TP_CONTA').AsInteger := Rg_Rb_Tipo_Conta.ItemIndex;
    ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    end;
end;

procedure TFr_Ficha_Cadastral.Pc_AlteraDadosReferenciaBancaria;
Begin
  Pc_StateChangeReferenciaBancaria('U');
  Rg_Rb_Tipo_Conta.ItemIndex := StrToIntDef(Qr_Ref_Bancaria.FieldByname('RFB_TP_CONTA').AsString,0);
  E_Rb_Banco.Text := Qr_Ref_Bancaria.FieldByname('RFB_BANCO').AsString;
  E_Rb_Agencia.Text := Qr_Ref_Bancaria.FieldByname('RFB_AGENCIA').AsString;
  E_Rb_Conta.Text := Qr_Ref_Bancaria.FieldByname('RFB_CONTA').AsString;
  E_Rb_Dt_Abertura.Date := Qr_Ref_Bancaria.FieldByname('RFB_DT_ABERTURA').AsDateTime;
  E_Rb_Nr_Cheques.Text := Qr_Ref_Bancaria.FieldByname('RFB_NR_CHEQUE').AsString;
  E_Rb_Banco.SetFocus;
  It_Cd_Ref_Bancaria := Qr_Ref_Bancaria.FieldByname('RFB_CODIGO').AsInteger;
end;

procedure TFr_Ficha_Cadastral.Pc_ExcluiDadosReferenciaBancaria;
Begin
  with Qr_Gravacao do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('DELETE FROM TB_REFER_BANCARIA '+
            'WHERE RFB_CODIGO=:RFB_CODIGO ');
    //Passagem de Parametro
    ParamByName('RFB_CODIGO').AsInteger := It_Cd_Ref_Bancaria;
    ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    end;
end;

//Aba Referencia Pessoal
procedure TFr_Ficha_Cadastral.Pc_LimpaCamposReferenciaPessoal;
Begin
  E_Rp_Nome.Clear;
  E_Rp_Afinidade.Clear;
  E_Rp_Fone.Clear;
  DBLCB_Rp_Estado.KeyValue := null;
  DBLCB_Rp_Cidade.KeyValue := null;
  It_Cd_Ref_Pessoal := 0;
end;

procedure TFr_Ficha_Cadastral.Pc_StateChangeReferenciaPessoal(Pc_Estado:String);
Begin
  E_Rp_Nome.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  E_Rp_Afinidade.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  E_Rp_Fone.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  DBLCB_Rp_Estado.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  DBLCB_Rp_Cidade.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  Sb_Ins_Ref_Pessoal.Enabled := not ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  Sb_Alt_Ref_Pessoal.Enabled := not ((Pc_Estado = 'I') or (Pc_Estado = 'U')) and (Qr_Ref_Pessoal.RecordCount > 0);
  Sb_Exc_Ref_Pessoal.Enabled := not ((Pc_Estado = 'I') or (Pc_Estado = 'U'))and (Qr_Ref_Pessoal.RecordCount > 0);
  Sb_Grv_Ref_Pessoal.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  Sb_Can_Ref_Pessoal.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
end;

procedure TFr_Ficha_Cadastral.Pc_MostraDadosReferenciaPessoal;
Begin
  with Qr_Ref_Pessoal do
    Begin
    Active := False;
    ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empresa;
    Active := true;
    end;
  Pc_StateChangeReferenciaPessoal('N');
end;

function TFr_Ficha_Cadastral.Fc_ValidaDadosReferenciaPessoal():boolean;
Begin
  Result := True;
  if trim(E_Rp_Nome.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Nome não informado. Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_RefPessoal;
    E_Rp_Nome.SetFocus;
    Result := False;
    exit;
    end;
  if trim(E_Rp_Afinidade.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo afinidade não informado. Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_RefPessoal;
    E_Rp_Afinidade.SetFocus;
    Result := False;
    exit;
    end;
  if trim(E_Rp_Fone.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo fone não informado. Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_RefPessoal;
    E_Rp_Fone.SetFocus;
    Result := False;
    exit;
    end;
  if trim(DBLCB_Rp_Estado.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo estado não informado. Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_RefPessoal;
    DBLCB_Rp_Estado.SetFocus;
    Result := False;
    exit;
    end;
  if trim(DBLCB_Rp_Cidade.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo cidade não informado. Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_RefPessoal;
    DBLCB_Rp_Cidade.SetFocus;
    Result := False;
    exit;
    end;
end;

procedure TFr_Ficha_Cadastral.Pc_GravaDadosReferenciaPessoal;
Begin
  with Qr_Gravacao do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE OR INSERT INTO TB_REFER_PESSOAL( '+
            ' RFP_CODIGO '+
            ',RFP_CODEMP '+
            ',RFP_NOME '+
            ',RFP_AFINIDADE '+
            ',RFP_FONE '+
            ',RFP_CODUFE '+
            ',RFP_CODCDD )'+
            'values( '+
            ' :RFP_CODIGO '+
            ',:RFP_CODEMP '+
            ',:RFP_NOME '+
            ',:RFP_AFINIDADE '+
            ',:RFP_FONE '+
            ',:RFP_CODUFE '+
            ',:RFP_CODCDD )'+
            'MATCHING (RFP_CODIGO)');

    //Passagem de Parametro
    if It_Cd_Ref_Pessoal = 0 then It_Cd_Ref_Pessoal := Fc_Generator('GN_REFER_PESSOAL','TB_REFER_PESSOAL','RFP_CODIGO');
    ParamByName('RFP_CODIGO').AsInteger := It_Cd_Ref_Pessoal;
    ParamByName('RFP_CODEMP').AsInteger := It_Cd_Empresa;
    ParamByName('RFP_NOME').AsString := E_Rp_Nome.Text;
    ParamByName('RFP_AFINIDADE').AsString := E_Rp_Afinidade.Text;
    ParamByName('RFP_FONE').AsString := E_Rp_Fone.Text;
    ParamByName('RFP_CODUFE').AsInteger := DBLCB_Rp_Estado.KeyValue;
    ParamByName('RFP_CODCDD').AsInteger := DBLCB_Rp_Cidade.KeyValue;
    ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    end;
end;

procedure TFr_Ficha_Cadastral.Pc_AlteraDadosReferenciaPessoal;
Begin
  Pc_StateChangeReferenciaPessoal('U');
  E_Rp_Nome.Text := Qr_Ref_Pessoal.FieldByname('RFP_NOME').AsString;
  E_Rp_Afinidade.Text := Qr_Ref_Pessoal.FieldByname('RFP_AFINIDADE').AsString;
  E_Rp_Fone.Text := Qr_Ref_Pessoal.FieldByname('RFP_FONE').AsString;
  DBLCB_Rp_Estado.KeyValue := Qr_Ref_Pessoal.FieldByname('RFP_CODUFE').AsInteger;
  DBLCB_Rp_Cidade.KeyValue := Qr_Ref_Pessoal.FieldByname('RFP_CODCDD').AsInteger;
  E_Rp_Nome.SetFocus;
  It_Cd_Ref_Pessoal := Qr_Ref_Pessoal.FieldByname('RFP_CODIGO').AsInteger;
end;

procedure TFr_Ficha_Cadastral.Pc_ExcluiDadosReferenciaPessoal;
Begin
  with Qr_Gravacao do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('DELETE FROM TB_REFER_PESSOAL '+
            'WHERE RFP_CODIGO=:RFP_CODIGO ');
    //Passagem de Parametro
    ParamByName('RFP_CODIGO').AsInteger := It_Cd_Ref_Pessoal;
    ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    end;
end;

//Aba Referencia comecial
procedure TFr_Ficha_Cadastral.Pc_LimpaCamposReferenciaComercial;
Begin
  E_Rc_Nome.Clear;
  E_Rc_Fone.Clear;
  E_Rc_Fax.Clear;
  E_Rc_Celular.Clear;
  E_Rc_Dt_Desde.Date := DATE;
  It_Cd_Ref_Comercial := 0;
end;

procedure TFr_Ficha_Cadastral.Pc_StateChangeReferenciaComercial(Pc_Estado:String);
Begin
  E_Rc_Nome.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  E_Rc_Fone.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  E_Rc_Fax.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  E_Rc_Celular.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  E_Rc_Dt_Desde.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));

  Sb_Ins_Ref_Comercial.Enabled := not ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  Sb_Alt_Ref_Comercial.Enabled := not ((Pc_Estado = 'I') or (Pc_Estado = 'U')) and (Qr_Ref_Comercial.RecordCount > 0);
  Sb_Exc_Ref_Comercial.Enabled := not ((Pc_Estado = 'I') or (Pc_Estado = 'U'))and (Qr_Ref_Comercial.RecordCount > 0);
  Sb_Grv_Ref_Comercial.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  Sb_Can_Ref_Comercial.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
end;

procedure TFr_Ficha_Cadastral.Pc_MostraDadosReferenciaComercial;
Begin
  with Qr_Ref_Comercial do
    Begin
    Active := False;
    ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empresa;
    Active := true;
    end;
  Pc_StateChangeReferenciaComercial('N');
end;

function TFr_Ficha_Cadastral.Fc_ValidaDadosReferenciaComercial():boolean;
Begin
  Result := True;
  if trim(E_Rc_Nome.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo nome não informado. Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_RefComercial;
    E_Rc_Nome.SetFocus;
    Result := False;
    exit;
    end;
  if trim(E_Rc_Fone.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo fone não informado. Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_RefComercial;
    E_Rc_Fone.SetFocus;
    Result := False;
    exit;
    end;
end;

procedure TFr_Ficha_Cadastral.Pc_GravaDadosReferenciaComercial;
Begin
  with Qr_Gravacao do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE OR INSERT INTO TB_REFER_COMERCIAL( '+
            '  "RFC_CODIGO" '+
            ', "RFC_CODEMP" '+
            ', "RFC_NOME" '+
            ', "RFC_FONE" '+
            ', "RFC_FAX" '+
            ', "RFC_CELULAR" '+
            ', "RFC_DT_DESDE") '+
            'values( '+
            '  :"RFC_CODIGO" '+
            ', :"RFC_CODEMP" '+
            ', :"RFC_NOME" '+
            ', :"RFC_FONE" '+
            ', :"RFC_FAX" '+
            ', :"RFC_CELULAR" '+
            ', :"RFC_DT_DESDE") '+
            'MATCHING (RFC_CODIGO)');

    //Passagem de Parametro
    if It_Cd_Ref_Comercial = 0 then It_Cd_Ref_Comercial := Fc_Generator('GN_REFER_COMERCIAL','TB_REFER_COMERCIAL','RFC_CODIGO');
    ParamByName('RFC_CODIGO').AsInteger := It_Cd_Ref_Comercial;
    ParamByName('RFC_CODEMP').AsInteger := It_Cd_Empresa;
    ParamByName('RFC_NOME').AsString := E_Rc_Nome.Text;
    ParamByName('RFC_FONE').AsString := E_Rc_Fone.Text;
    ParamByName('RFC_FAX').AsString := E_Rc_Fax.Text;
    ParamByName('RFC_CELULAR').AsString := E_Rc_Celular.Text;
    ParamByName('RFC_DT_DESDE').AsDate := E_Rc_Dt_Desde.Date;
    ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    end;
end;

procedure TFr_Ficha_Cadastral.Pc_AlteraDadosReferenciaComercial;
Begin
  Pc_StateChangeReferenciaComercial('U');
  E_Rc_Nome.Text := Qr_Ref_Comercial.FieldByname('RFC_NOME').AsString;
  E_Rc_Fone.Text := Qr_Ref_Comercial.FieldByname('RFC_FONE').AsString;
  E_Rc_Fax.Text := Qr_Ref_Comercial.FieldByname('FC_FAX').AsString;
  E_Rc_Celular.Text := Qr_Ref_Comercial.FieldByname('RFC_CELULAR').AsString;
  E_Rc_Nome.SetFocus;
  It_Cd_Ref_Comercial := Qr_Ref_Comercial.FieldByname('RFC_CODIGO').AsInteger;
end;

procedure TFr_Ficha_Cadastral.Pc_ExcluiDadosReferenciaComercial;
Begin
  with Qr_Gravacao do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('DELETE FROM TB_REFER_COMERCIAL '+
            'WHERE RFC_CODIGO=:RFC_CODIGO ');
    //Passagem de Parametro
    ParamByName('RFC_CODIGO').AsInteger := It_Cd_Ref_Comercial;
    ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    end;
end;

//Aba Bem em Garantia
procedure TFr_Ficha_Cadastral.Pc_LimpaCamposBemGarantia;
Begin
  E_Bg_Descricao.Clear;
  E_Bg_Valor.Clear;
  E_Bg_Documento.Clear;
  E_Bg_Referencia.Clear;
  It_Cd_Bem_Garantia := 0;
end;

procedure TFr_Ficha_Cadastral.Pc_StateChangeBemGarantia(Pc_Estado:String);
Begin
  E_Bg_Descricao.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  E_Bg_Valor.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  E_Bg_Documento.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  E_Bg_Referencia.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  Sb_Ins_Bem_Garantia.Enabled := not ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  Sb_Alt_Bem_Garantia.Enabled := not ((Pc_Estado = 'I') or (Pc_Estado = 'U')) and (Qr_BemGarantia.RecordCount > 0);
  Sb_Exc_Bem_Garantia.Enabled := not ((Pc_Estado = 'I') or (Pc_Estado = 'U'))and (Qr_BemGarantia.RecordCount > 0);
  Sb_Grv_Bem_Garantia.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
  Sb_Can_Bem_Garantia.Enabled := ((Pc_Estado = 'I') or (Pc_Estado = 'U'));
end;

procedure TFr_Ficha_Cadastral.Pc_MostraDadosBemGarantia;
Begin
  with Qr_BemGarantia do
    Begin
    Active := False;
    ParamByName('FCT_CODIGO').AsInteger := It_cd_ficha;
    Active := true;
    end;
  Pc_StateChangeBemGarantia('N');
end;

function TFr_Ficha_Cadastral.Fc_ValidaDadosBemGarantia():boolean;
Begin
  Result := True;
  if trim(E_Bg_Descricao.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Descrição não informado. Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_BemGarantia;
    E_Bg_Descricao.SetFocus;
    Result := False;
    exit;
    end;
  if trim(E_Bg_Valor.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Valor não informado. Verifique.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_Geral.ActivePage := Tbs_BemGarantia;
    E_Bg_Valor.SetFocus;
    Result := False;
    exit;
    end;
end;

procedure TFr_Ficha_Cadastral.Pc_GravaDadosBemGarantia;
Begin
  with Qr_Gravacao do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE OR INSERT INTO TB_FICHA_BEM_GARANTIA( '+
            '  "FBG_CODIGO" '+
            ', "FBG_CODFCT" '+
            ', "FBG_DESCRICAO" '+
            ', "FBG_VALOR" '+
            ', "FBG_TP_DOC" '+
            ', "FBG_REFERENCIA") '+
            'values( '+
            '  :"FBG_CODIGO" '+
            ', :"FBG_CODFCT" '+
            ', :"FBG_DESCRICAO" '+
            ', :"FBG_VALOR" '+
            ', :"FBG_TP_DOC" '+
            ', :"FBG_REFERENCIA") '+
            'MATCHING (FBG_CODIGO)');

    //Passagem de Parametro
    if It_Cd_Bem_Garantia = 0 then It_Cd_Bem_Garantia := Fc_Generator('GN_FICHA_BEM_GARANTIA','TB_FICHA_BEM_GARANTIA','FBG_CODIGO');
    ParamByName('FBG_CODIGO').AsInteger := It_Cd_Bem_Garantia;
    ParamByName('FBG_CODFCT').AsInteger := It_cd_ficha;
    ParamByName('FBG_DESCRICAO').AsString := E_Bg_Descricao.Text;
    ParamByName('FBG_VALOR').AsCurrency := StrToFloatDef(E_Bg_Valor.Text,0);
    ParamByName('FBG_TP_DOC').AsString := E_Bg_Documento.Text;
    ParamByName('FBG_REFERENCIA').AsString := E_Bg_Referencia.Text;
    ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    end;
end;

procedure TFr_Ficha_Cadastral.Pc_AlteraDadosBemGarantia;
Begin
  Pc_StateChangeBemGarantia('U');
  E_Bg_Descricao.Text := Qr_BemGarantia.FieldByname('FBG_DESCRICAO').AsString;
  E_Bg_Valor.Text := FloatToStrF(Qr_BemGarantia.FieldByname('FBG_VALOR').AsCurrency,ffFixed,10,2);
  E_Bg_Documento.Text := Qr_BemGarantia.FieldByname('FBG_TP_DOC').AsString;
  E_Bg_Referencia.Text := Qr_BemGarantia.FieldByname('FBG_REFERENCIA').AsString;
  E_Bg_Descricao.SetFocus;
  It_Cd_Bem_Garantia := Qr_BemGarantia.FieldByname('FBG_CODIGO').AsInteger;
end;

procedure TFr_Ficha_Cadastral.Pc_ExcluiDadosBemGarantia;
Begin
  with Qr_Gravacao do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('DELETE FROM TB_FICHA_BEM_GARANTIA '+
            'WHERE FBG_CODIGO=:FBG_CODIGO ');
    //Passagem de Parametro
    ParamByName('FBG_CODIGO').AsInteger := It_Cd_Bem_Garantia;
    ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    end;
end;

//Aba Formas de pagamentos
procedure TFr_Ficha_Cadastral.Pc_MostraFormasPagamento;
Begin
  //A busca destes dados efeutada junto com os dados Gerais
  //Mantive o preenchimento por aba por uma questão de organização
  E_Fp_Vl_Compra.Text := FloatToStrF(Qr_DadosGerais.FieldByName('FCT_VL_COMPRA').AsCurrency,ffFixed,10,2);
  E_Fp_Parcelamento.Text := Qr_DadosGerais.FieldByName('FCT_PARCELAS').AsString;
  E_Fp_VL_Taxa.Text := FloatToStrF(Qr_DadosGerais.FieldByName('FCT_VL_TAXA').AsCurrency,ffFixed,10,2);
  DBLCB_Fp_Vendedor.KeyValue := Qr_DadosGerais.FieldByName('FCT_CODVDO').AsInteger;
  E_Fp_Pedido.Text := Qr_DadosGerais.FieldByName('FCT_NR_PEDIDO').AsString;
  E_Fp_Nota_Fiscal.Text := Qr_DadosGerais.FieldByName('FCT_NR_NOTA').AsString;
  E_Fp_Dt_Entrega.Text := Qr_DadosGerais.FieldByName('FCT_DT_ENTREGA').AsString;
  Rg_FP_SituacaoFicha.ItemIndex := StrToIntDef(Qr_DadosGerais.FieldByName('FCT_SIT_FICHA').AsString,0);
  Rg_Fp_TipoFicha.ItemIndex := StrToIntDef(Qr_DadosGerais.FieldByName('FCT_TP_FICHA').AsString,0);
  E_Fp_Obs.Text := Qr_DadosGerais.FieldByName('FCT_OBS').AsString;
end;

// Procedures Internas

procedure TFr_Ficha_Cadastral.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  IF DM.IB_Transacao.InTransaction THEN
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
end;

procedure TFr_Ficha_Cadastral.SB_GravarClick(Sender: TObject);
begin
  if Fc_validaGravacao then
    begin
    try
      Screen.Cursor := crHourGlass;
      Pc_GravaDadosGerais;
      Pc_GravaDadosProfissionais;
      Pc_GravaDadosEmpregadorConjuge;
      Pc_GravaDadosConjuge;
      Pc_GravaDadosEmpregadorAvalista;
      Pc_GravaDadosAvalista;
      Pc_GravaDadosFichaCadastral;
      Close;
      Screen.Cursor := crDefault;
    except
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Um erro impossibilitou a gravação dos dados.' + EOLN +
                     'Entre em contato com o suporte técnico.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

procedure TFr_Ficha_Cadastral.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case Pg_Ficha_Cadastral.ActivePageIndex of
  0:begin
    if shift = [] then
      begin
        case Key of
        VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
        VK_F6  : if SB_Cancelar.Enabled then SB_CancelarClick(Sender);
        VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
        end;
      end;
    end;
  else
    begin

    end;
  end;

end;

procedure TFr_Ficha_Cadastral.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Ficha_Cadastral.Sb_Sair_0Click(Sender: TObject);
begin
  close;
end;


procedure TFr_Ficha_Cadastral.FormShow(Sender: TObject);
begin
  Pc_formataTela;
  Pc_IniciaVariaveis;
  //Abre a consulta dos dados Gerais;
  Pc_BuscaDadosGerais;
  //Preenche aba dados gerais
  Pc_MostraDadosGerais;
  //Preenche aba Forma de pagamento
  Pc_MostraFormasPagamento;
  //Preenche aba Dados Profissionais
  Pc_BuscaDadosProfissionais;  
  Pc_MostraDadosProfissionais;
  //Preenche aba Dados do conjuge
  Pc_BuscaDadosConjuge;
  Pc_MostraDadosConjuge;
  //Preenche aba Dados do conjuge
  Pc_BuscaDadosAvalista;
  Pc_MostraDadosAvalista;  
end;

procedure TFr_Ficha_Cadastral.Sb_Dg_CepClick(Sender: TObject);
begin
  if (E_Dg_Cep.Text = '') then
    begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Informe o Número do Cep.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    if E_dg_cep.CanFocus then E_dg_cep.SetFocus;
    end
  else
    Pc_BuscaCep(E_Dg_Cep.Text,
                Dblcb_Dg_Pais,
                DBLCB_Dg_Estado,
                DBLCB_Dg_Cidade,
                E_Dg_Endereco,
                E_Dg_Bairro,
                E_Dg_Nr_Endereco);
end;

procedure TFr_Ficha_Cadastral.E_Dg_cepExit(Sender: TObject);
begin
  if (It_cd_ficha = 0) and (E_Dg_cep.Text <> '') then
    Sb_Dg_CepClick(Sender);
end;

procedure TFr_Ficha_Cadastral.Sb_Dg_EnderecoClick(Sender: TObject);
begin
  Pc_BuscaEndereco(E_Dg_Cep,
                   Dblcb_Dg_Pais,
                   DBLCB_Dg_Estado,
                   DBLCB_Dg_Cidade,
                   E_Dg_Endereco,
                   E_Dg_Bairro,
                   E_Dg_Nr_Endereco);
end;

procedure TFr_Ficha_Cadastral.Sb_Dp_CepClick(Sender: TObject);
begin
  if (E_Dp_Cep.Text = '') then
    begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Informe o Número do Cep.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    if E_dp_cep.CanFocus then E_dg_cep.SetFocus;
    end
  else
    Pc_BuscaCep(E_Dp_Cep.Text,
                Dblcb_Dp_Pais,
                DBLCB_Dp_Estado,
                DBLCB_Dp_Cidade,
                E_Dp_Endereco,
                E_Dp_Bairro,
                E_Dp_Nr_Endereco);
end;

procedure TFr_Ficha_Cadastral.Sb_Dp_EnderecoClick(Sender: TObject);
begin
  Pc_BuscaEndereco(E_Dp_Cep,
                   Dblcb_Dp_Pais,
                   DBLCB_Dp_Estado,
                   DBLCB_Dp_Cidade,
                   E_Dp_Endereco,
                   E_Dp_Bairro,
                   E_Dp_Nr_Endereco);
end;

procedure TFr_Ficha_Cadastral.SB_CancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Ficha_Cadastral.E_Dp_VL_RendaExit(Sender: TObject);
Var
  Lc_Valor : real;
begin
  Lc_Valor := StrToFloatDef(E_Dp_VL_Renda.Text,0);
  E_Dp_VL_Renda.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
end;

procedure TFr_Ficha_Cadastral.E_Dp_VL_OutrosExit(Sender: TObject);
Var
  Lc_Valor : real;
begin
  Lc_Valor := StrToFloatDef(E_Dp_VL_Outros.Text,0);
  E_Dp_VL_Outros.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);

end;

procedure TFr_Ficha_Cadastral.E_Dp_ValorExit(Sender: TObject);
Var
  Lc_Valor : real;
begin
  Lc_Valor := StrToFloatDef(E_Dp_Valor.Text,0);
  E_Dp_Valor.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
end;

procedure TFr_Ficha_Cadastral.E_Dp_FaturamentoExit(Sender: TObject);
Var
  Lc_Valor : real;
begin
  Lc_Valor := StrToFloatDef(E_Dp_Faturamento.Text,0);
  E_Dp_Faturamento.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
end;

procedure TFr_Ficha_Cadastral.E_Cg_Vl_RendaExit(Sender: TObject);
Var
  Lc_Valor : real;
begin
  Lc_Valor := StrToFloatDef(E_Cg_VL_Renda.Text,0);
  E_Cg_VL_Renda.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
end;

procedure TFr_Ficha_Cadastral.E_Da_Vl_RendaExit(Sender: TObject);
Var
  Lc_Valor : real;
begin
  Lc_Valor := StrToFloatDef(E_Da_VL_Renda.Text,0);
  E_Da_VL_Renda.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);

end;

procedure TFr_Ficha_Cadastral.E_Bg_ValorExit(Sender: TObject);
Var
  Lc_Valor : real;
begin
  Lc_Valor := StrToFloatDef(E_Bg_Valor.Text,0);
  E_Bg_Valor.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
end;

procedure TFr_Ficha_Cadastral.E_Fp_Vl_CompraExit(Sender: TObject);
Var
  Lc_Valor : real;
begin
  Lc_Valor := StrToFloatDef(E_Fp_Vl_Compra.Text,0);
  E_Fp_Vl_Compra.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
end;

procedure TFr_Ficha_Cadastral.E_Fp_VL_TaxaExit(Sender: TObject);
Var
  Lc_Valor : real;
begin
  Lc_Valor := StrToFloatDef(E_Fp_VL_Taxa.Text,0);
  E_Fp_VL_Taxa.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
end;

procedure TFr_Ficha_Cadastral.Sb_Ins_DependenteClick(Sender: TObject);
begin
  Pc_StateChangeDependentes('I');
  Pc_LimpaCamposDependentes;

end;

procedure TFr_Ficha_Cadastral.Sb_Alt_DependenteClick(Sender: TObject);
begin
  Pc_AlteraDadosDependentes;
end;

procedure TFr_Ficha_Cadastral.Sb_Grv_DependenteClick(Sender: TObject);
begin
  if Fc_ValidaDadosDependetes then
    Begin
    Pc_GravaDadosDependentes;
    Pc_StateChangeDependentes('N');
    Pc_MostraDadosDependentes;
    end;
end;

procedure TFr_Ficha_Cadastral.Sb_Can_DependenteClick(Sender: TObject);
begin
  Pc_LimpaCamposDependentes;
  Pc_StateChangeDependentes('N');
end;

procedure TFr_Ficha_Cadastral.Tbs_DependentesShow(Sender: TObject);
begin
  Pc_MostraDadosDependentes;
end;

procedure TFr_Ficha_Cadastral.Sb_Exc_DependenteClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir ' + Qr_Dependentes.FieldByname('DPT_NOME').AsString + ' de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
    It_Cd_Dependente := Qr_Dependentes.FieldByname('DPT_CODIGO').AsInteger;
    Pc_ExcluiDadosDependentes;
    Pc_MostraDadosDependentes;
    Pc_LimpaCamposDependentes;
   end;
end;

procedure TFr_Ficha_Cadastral.Sb_Ins_Ref_BancariaClick(Sender: TObject);
begin
  Pc_StateChangeReferenciaBancaria('I');
  Pc_LimpaCamposReferenciaBancaria;
end;

procedure TFr_Ficha_Cadastral.Sb_Alt_Ref_BancariaClick(Sender: TObject);
begin
  Pc_AlteraDadosReferenciaBancaria;
end;

procedure TFr_Ficha_Cadastral.Sb_Exc_Ref_BancariaClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir ' + Qr_Ref_Bancaria.FieldByname('RFB_BANCO').AsString   + ' / ' +
                                  Qr_Ref_Bancaria.FieldByname('RFB_AGENCIA').AsString + ' / ' +
                                  Qr_Ref_Bancaria.FieldByname('RFB_CONTA').AsString + ' de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
    It_Cd_Ref_Bancaria := Qr_Ref_Bancaria.FieldByname('RFB_CODIGO').AsInteger;
    Pc_ExcluiDadosReferenciaBancaria;
    Pc_MostraDadosReferenciaBancaria;
    Pc_LimpaCamposReferenciaBancaria;
   end;
end;

procedure TFr_Ficha_Cadastral.Sb_Grv_Ref_BancariaClick(Sender: TObject);
begin
  if Fc_ValidaDadosReferenciaBancaria then
    Begin
    Pc_GravaDadosReferenciaBancaria;
    Pc_StateChangeReferenciaBancaria('N');
    Pc_MostraDadosReferenciaBancaria;
    end;
end;

procedure TFr_Ficha_Cadastral.Sb_Can_Ref_BancariaClick(Sender: TObject);
begin
  Pc_LimpaCamposReferenciaBancaria;
  Pc_StateChangeReferenciaBancaria('N');
end;

procedure TFr_Ficha_Cadastral.Tbs_RefBancariaShow(Sender: TObject);
begin
  Pc_MostraDadosReferenciaBancaria;
end;

procedure TFr_Ficha_Cadastral.Sb_Ins_Ref_PessoalClick(Sender: TObject);
begin
  Pc_StateChangeReferenciaPessoal('I');
  Pc_LimpaCamposReferenciaPessoal;
end;

procedure TFr_Ficha_Cadastral.Sb_Alt_Ref_PessoalClick(Sender: TObject);
begin
  Pc_AlteraDadosReferenciaPessoal;
end;

procedure TFr_Ficha_Cadastral.Sb_Exc_Ref_PessoalClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir ' + Qr_Ref_Pessoal.FieldByname('RFP_NOME').AsString + ' de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
    It_Cd_Ref_Pessoal := Qr_Ref_Pessoal.FieldByname('RFP_CODIGO').AsInteger;
    Pc_ExcluiDadosReferenciaPessoal;
    Pc_MostraDadosReferenciaPessoal;
    Pc_LimpaCamposReferenciaPessoal;
   end;
end;

procedure TFr_Ficha_Cadastral.Sb_Grv_Ref_PessoalClick(Sender: TObject);
begin
  if Fc_ValidaDadosReferenciaPessoal then
    Begin
    Pc_GravaDadosReferenciaPessoal;
    Pc_StateChangeReferenciaPessoal('N');
    Pc_MostraDadosReferenciaPessoal;
    end;
end;

procedure TFr_Ficha_Cadastral.Sb_Can_Ref_PessoalClick(Sender: TObject);
begin
  Pc_LimpaCamposReferenciaPessoal;
  Pc_StateChangeReferenciaPessoal('N');
end;

procedure TFr_Ficha_Cadastral.Tbs_RefPessoalShow(Sender: TObject);
begin
  Pc_MostraDadosReferenciaPessoal;
end;

procedure TFr_Ficha_Cadastral.Sb_Ins_Ref_ComercialClick(Sender: TObject);
begin
  Pc_StateChangeReferenciaComercial('I');
  Pc_LimpaCamposReferenciaComercial;
end;

procedure TFr_Ficha_Cadastral.Sb_Alt_Ref_ComercialClick(Sender: TObject);
begin
  Pc_AlteraDadosReferenciaComercial;
end;

procedure TFr_Ficha_Cadastral.Sb_Exc_Ref_ComercialClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir ' + Qr_Ref_Comercial.FieldByname('RFC_NOME').AsString + ' de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
    It_Cd_Ref_Comercial := Qr_Ref_Comercial.FieldByname('RFC_CODIGO').AsInteger;
    Pc_ExcluiDadosReferenciaComercial;
    Pc_MostraDadosReferenciaComercial;
    Pc_LimpaCamposReferenciaComercial;
   end;
end;

procedure TFr_Ficha_Cadastral.Sb_Grv_Ref_ComercialClick(Sender: TObject);
begin
  if Fc_ValidaDadosReferenciaComercial then
    Begin
    Pc_GravaDadosReferenciaComercial;
    Pc_StateChangeReferenciaComercial('N');
    Pc_MostraDadosReferenciaComercial;
    end;
end;

procedure TFr_Ficha_Cadastral.Sb_Can_Ref_ComercialClick(Sender: TObject);
begin
  Pc_LimpaCamposReferenciaComercial;
  Pc_StateChangeReferenciaComercial('N');
end;

procedure TFr_Ficha_Cadastral.Tbs_RefComercialShow(Sender: TObject);
begin
  Pc_MostraDadosReferenciaComercial;
end;

procedure TFr_Ficha_Cadastral.Sb_Ins_Bem_GarantiaClick(Sender: TObject);
begin
  Pc_StateChangeBemGarantia('I');
  Pc_LimpaCamposBemGarantia;
end;

procedure TFr_Ficha_Cadastral.Sb_Alt_Bem_GarantiaClick(Sender: TObject);
begin
  Pc_AlteraDadosBemGarantia;
end;

procedure TFr_Ficha_Cadastral.Sb_Exc_Bem_GarantiaClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir ' + Qr_BemGarantia.FieldByname('FBG_DESCRICAO').AsString + ' de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
    It_Cd_Bem_Garantia := Qr_BemGarantia.FieldByname('FBG_CODIGO').AsInteger;
    Pc_ExcluiDadosBemGarantia;
    Pc_MostraDadosBemGarantia;
    Pc_LimpaCamposBemGarantia;
   end;
end;

procedure TFr_Ficha_Cadastral.Sb_Grv_Bem_GarantiaClick(Sender: TObject);
begin
  if Fc_ValidaDadosBemGarantia then
    Begin
    Pc_GravaDadosBemGarantia;
    Pc_StateChangeBemGarantia('N');
    Pc_MostraDadosBemGarantia;
    end;
end;

procedure TFr_Ficha_Cadastral.Sb_Can_Bem_GarantiaClick(Sender: TObject);
begin
  Pc_LimpaCamposBemGarantia;
  Pc_StateChangeBemGarantia('N');
end;

procedure TFr_Ficha_Cadastral.Tbs_BemGarantiaShow(Sender: TObject);
begin
  Pc_MostraDadosBemGarantia;
end;

procedure TFr_Ficha_Cadastral.Sb_Cg_CepClick(Sender: TObject);
begin
  if (E_Cg_Cep.Text = '') then
    begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Informe o Número do Cep.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    if E_Cg_cep.CanFocus then E_cg_cep.SetFocus;
    end
  else
    Pc_BuscaCep(E_Cg_Cep.Text,
                Dblcb_Cg_Pais,
                DBLCB_Cg_Estado,
                DBLCB_Cg_Cidade,
                E_Cg_Endereco,
                E_Cg_Bairro,
                E_Cg_Nr_Endereco);
end;

procedure TFr_Ficha_Cadastral.Sb_Da_CepClick(Sender: TObject);
begin
  if (E_Da_Cep.Text = '') then
    begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Informe o Número do Cep.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    if E_Da_cep.CanFocus then E_Da_cep.SetFocus;
    end
  else
    Pc_BuscaCep(E_Da_Cep.Text,
                Dblcb_Da_Pais,
                DBLCB_Da_Estado,
                DBLCB_Da_Cidade,
                E_Da_Endereco,
                E_Da_Bairro,
                E_Da_Nr_Endereco);
end;

procedure TFr_Ficha_Cadastral.Sb_Cg_EnderecoClick(Sender: TObject);
begin
  Pc_BuscaEndereco(E_Cg_Cep,
                   Dblcb_Cg_Pais,
                   DBLCB_Cg_Estado,
                   DBLCB_Cg_Cidade,
                   E_Cg_Endereco,
                   E_Cg_Bairro,
                   E_Cg_Nr_Endereco);
end;

procedure TFr_Ficha_Cadastral.Sb_Da_EnderecoClick(Sender: TObject);
begin
  Pc_BuscaEndereco(E_Da_Cep,
                   Dblcb_Da_Pais,
                   DBLCB_Da_Estado,
                   DBLCB_Da_Cidade,
                   E_Da_Endereco,
                   E_Da_Bairro,
                   E_Da_Nr_Endereco);
end;

end.


             