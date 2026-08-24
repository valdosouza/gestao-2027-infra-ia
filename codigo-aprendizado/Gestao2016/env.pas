unit env;

interface

uses
      Winapi.Windows, System.UITypes;
Type
  TEstadoEcfSimulado = (tpsLivre, tpsVenda, tpsSubTotal, tpsTotalPagar, tpsPagamento, tpsRelatorio);

var
  MSWord: Variant;
  //-------------------------Usuarios do Sistema  ---------------------------------------------
  GB_Nm_Usuario: string;
  GB_Cd_Usuario: Integer;
  GB_Senha: string;
  GB_Cd_Vendedor: Integer;
  GB_Liberado: Boolean;
  // Permissís
   Gb_Nivel: Integer;
  //Dados da Empresa
  Gb_CodMha: Integer;
  //Ativa PAF-ECF
  Gb_PAF_NFE_E : Boolean;

  //Verifica se continua a executar o sistema
  Gb_exec_Aplication : boolean;

  //Data de Criação
  Gb_data_Criacao : String;

  Gb_Cd_Crt: Integer;
  Gb_Cd_Pesquisa : integer;
  GB_NM_Empresa: string;
  Gb_Estados: array[1..27] of string;
  Gb_Ult_codigo: Integer;
  //Código de cliente no Cadastro da Setes
  Gb_Cd_Cliente_Setes : Integer;
  //Codigo do Projeto utilizado na Setes
  Gb_Cd_Projeto_setes : Integer;
  Gb_Handle : hwnd;
  //codigo do Estoque Atual
  Gb_Estoque: Integer;
  GB_ProdCompartilha: Boolean;
  gb_site : string;
  Gb_Cd_Wsr : Integer;
  gb_webservice : string;
  gb_Web_Path_img : String;
  gb_CNPJ : string;
  //Variaveis do Proxy
  Gb_Pxy_Path  : String;
  Gb_Pxy_Porta : Integer;
  Gb_Pxy_User   : String;
  Gb_pxy_Pws   : String;
  //Formato Casas Desimais
  Gb_Casa_Dec_Venda : String;
  Gb_Casa_Dec_Compra : String;
  // Inventario
  Gb_Inventario: Integer;
  //Abre Tela de Aniversário
  Gb_Aniver: Boolean;
  //Licença
  Gb_Serial_HD : String;
  //Conexão
  GbPathExe: string;
  Gb_PathBD: string;
  Gb_db: string;
  //Cores no Foco
  Gb_CorEntra: TColor;
  Gb_CorSai: TColor;
  //Vareiveis para a internet
  Gb_Inet : word;
  Gb_ftp_User: string;
  Gb_ftp_Pws: string;
  Gb_ftp_Path: string;
  Gb_Dir_Img: string;
  GB_buscaProduto: String;
  //controle de Venda e financeiro
  Gb_SaldoVencido : Boolean;
  Gb_Terminal : Integer;

  Gb_CodigoCaixa : Integer;
  Gb_DataCaixa : TDate;

  Gb_Reforma_Tributaria : Boolean;
resourcestring
  MSG_DATA_INVALIDA = 'Verifique se o dia, mês e ano estão corretos. Use o formato DD/MM/AAAA.';

const
  SIM = 'Sim';
  NAO = 'Não';
  OK  = 'OK';
  SIGLA_S = 'S';
  SIGLA_N = 'N';
  ATENCAO = 'A T E N Ç Ã O !';
  MENSAGEM = 'Mensagem';
  TITULO_ERRO = 'Mensagem de erro';
  TITULO_CONFIRMACAO = 'Mensagem de Confirmação';
  TITULO_INFORMACAO = 'Mensagem de Informação';


implementation

end.
