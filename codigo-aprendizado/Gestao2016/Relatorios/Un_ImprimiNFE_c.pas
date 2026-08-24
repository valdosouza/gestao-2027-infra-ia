unit Un_ImprimiNFE_c;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Printers, UN_NF, DB, STQuery, StdCtrls, Buttons;

type
  TFc_ImprimeNFE_c = class(TForm)
    Qr_Pedido: TSTQuery;
    Qr_PedidoPED_CODEMP: TIntegerField;
    Qr_PedidoPED_CODVDO: TIntegerField;
    Qr_PedidoEMP_CONSUMIDOR: TStringField;
    Qr_PedidoEMP_MICRO: TStringField;
    Qr_PedidoUFE_CODIGO: TIntegerField;
    Qr_PedidoUFE_SIGLA: TStringField;
    Qr_PedidoEMP_FABRICA: TStringField;
    Qr_PedidoEMP_SUB_TRIB: TStringField;
    Qr_PedidoPED_CODIGO: TIntegerField;
    Qr_PedidoEMP_CNPJ: TStringField;
    Qr_PedidoCDD_DESCRICAO: TStringField;
    Qr_PedidoEND_NUMERO: TStringField;
    Qr_PedidoEND_PAIS: TIntegerField;
    Qr_PedidoEND_BAIRRO: TStringField;
    Qr_PedidoEMP_INSC_EST: TStringField;
    Qr_PedidoEND_ENDER: TStringField;
    Qr_PedidoEND_CEP: TStringField;
    Qr_PedidoPED_CODEND: TIntegerField;
    Qr_PedidoPED_VL_PEDIDO: TBCDField;
    Qr_PedidoPED_PRAZO: TStringField;
    Qr_PedidoPED_DATA: TDateField;
    Qr_PedidoPED_VL_SERVICO: TBCDField;
    Qr_PedidoPED_VL_PRODUTO: TBCDField;
    Qr_PedidoPED_VL_ODESPESA: TBCDField;
    Qr_PedidoPED_VL_IPI: TBCDField;
    Qr_PedidoPED_VL_FRETE: TBCDField;
    Qr_PedidoPED_VL_DESCONTO: TBCDField;
    Qr_PedidoPED_NUMERO: TIntegerField;
    Qr_PedidoPED_CODFPG: TIntegerField;
    Qr_PedidoFPT_DESCRICAO: TStringField;
    Qr_PedidoEMP_NOME: TStringField;
    Qr_Itens: TSTQuery;
    Qr_Acao: TSTQuery;
    Qr_Pgto: TSTQuery;
    Qr_PgtoFPT_CODIGO: TIntegerField;
    Qr_PgtoFPT_DESCRICAO: TStringField;
    Qr_Tributacao: TSTQuery;
    Qr_TributacaoTRB_CODIGO: TIntegerField;
    Qr_TributacaoTRB_CODPRO: TIntegerField;
    Qr_TributacaoTRB_ORIGEM: TStringField;
    Qr_TributacaoTRB_CODTBI_ICMS_NR: TIntegerField;
    Qr_TributacaoTRB_CODTBI_ICMS_SN: TIntegerField;
    Qr_TributacaoTRB_CODMDB_ICMS_NR: TIntegerField;
    Qr_TributacaoTRB_CODMDB_ICMS_ST: TIntegerField;
    Qr_TributacaoTRB_CODDSI_ICMS: TIntegerField;
    Qr_TributacaoTRB_AQ_ICMS: TBCDField;
    Qr_TributacaoTRB_RD_AQ_ICMS: TBCDField;
    Qr_TributacaoTRB_RD_BS_ICMS: TBCDField;
    Qr_TributacaoTRB_CODTBI_IPI: TIntegerField;
    Qr_TributacaoTRB_AQ_IPI: TBCDField;
    Qr_TributacaoTRB_CODTBI_PIS: TIntegerField;
    Qr_TributacaoTRB_AQ_PIS: TBCDField;
    Qr_TributacaoTRB_CODTBI_CFS: TIntegerField;
    Qr_TributacaoTRB_AQ_COFINS: TBCDField;
    Qr_TributacaoTRB_AQ_IRPJ: TBCDField;
    Qr_TributacaoTRB_AQ_CSLL: TBCDField;
    Qr_TributacaoTRB_AQ_II: TBCDField;
    Qr_TributacaoTRB_ST_ICMS: TStringField;
    Qr_TributacaoTRB_CONSUMIDOR: TStringField;
    Qr_TributacaoTRB_MICRO: TStringField;
    Qr_TributacaoTRB_DIFERIDO: TStringField;
    Qr_TributacaoTRB_DESTAQUE: TStringField;
    Qr_TributacaoTRB_CODOBS: TIntegerField;
    Qr_TributacaoTRB_CODNAT: TIntegerField;
    Qr_TributacaoTRB_ESTADO: TIntegerField;
    Qr_TributacaoTRB_CODMHA: TIntegerField;
    Qr_TributacaoTRB_SUB_TRI: TStringField;
    Qr_TributacaoNAT_CODIGO: TIntegerField;
    Qr_TributacaoTRB_AQ_ISS: TBCDField;
    Qr_TributacaoTRB_AQ_SISCOMEX: TFloatField;
    PrintDialog1: TPrintDialog;
    SB_Imprimir: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Qr_Empresa: TSTQuery;
    Qr_EmpresaEMP_CODIGO: TIntegerField;
    Qr_EmpresaEMP_TIPO: TIntegerField;
    Qr_EmpresaEMP_NOME: TStringField;
    Qr_EmpresaEMP_FANTASIA: TStringField;
    Qr_EmpresaEMP_CNPJ: TStringField;
    Qr_EmpresaEMP_INSC_EST: TStringField;
    Qr_EmpresaEMP_STCRED: TStringField;
    Qr_EmpresaEMP_OBSERV: TStringField;
    Qr_EmpresaEMP_DT_CADASTRO: TDateField;
    Qr_EmpresaEMP_PESSOA: TStringField;
    Qr_EmpresaEMP_CONSUMIDOR: TStringField;
    Qr_EmpresaEMP_MICRO: TStringField;
    Qr_EmpresaEMP_VL_CRED: TFloatField;
    Qr_EmpresaEMP_CODVDOR: TIntegerField;
    Qr_EmpresaEMP_ML_DRT: TStringField;
    Qr_EmpresaEMP_CODBCO: TStringField;
    Qr_EmpresaEMP_AGENCIA: TStringField;
    Qr_EmpresaEMP_CONTABCO: TStringField;
    Qr_EmpresaEMP_EMAIL: TStringField;
    Qr_EmpresaEMP_SITE: TStringField;
    Qr_EmpresaEMP_RAM_ATIV: TStringField;
    Qr_EmpresaEMP_DT_FUNDA: TDateField;
    Qr_EmpresaEMP_CODTRANSP: TIntegerField;
    Qr_EmpresaEMP_MULTIPLICADOR: TBCDField;
    Qr_EmpresaEMP_RED_CONTRATO: TBCDField;
    Qr_EmpresaEMP_FORMDATA: TStringField;
    Qr_EmpresaEMP_RESP_TEC: TStringField;
    Qr_Endereco: TSTQuery;
    Qr_EnderecoEND_CODIGO: TIntegerField;
    Qr_EnderecoEND_CODEMP: TIntegerField;
    Qr_EnderecoEND_CNPJ: TStringField;
    Qr_EnderecoEND_TIPO: TStringField;
    Qr_EnderecoEND_ENDER: TStringField;
    Qr_EnderecoEND_NUMERO: TStringField;
    Qr_EnderecoEND_COMPLEM: TStringField;
    Qr_EnderecoEND_BAIRRO: TStringField;
    Qr_EnderecoEND_CEP: TStringField;
    Qr_EnderecoEND_CODCDD: TIntegerField;
    Qr_EnderecoCDD_DESCRICAO: TStringField;
    Qr_EnderecoEND_REGIAO: TStringField;
    Qr_EnderecoEND_CODUFE: TIntegerField;
    Qr_EnderecoUFE_SIGLA: TStringField;
    Qr_EnderecoEND_CONTATO: TStringField;
    Qr_EnderecoEND_FONE: TStringField;
    Qr_EnderecoEND_FAX: TStringField;
    Qr_EnderecoEND_CELULAR: TStringField;
    Qr_EnderecoEND_PAIS: TIntegerField;
    Qr_EnderecoEND_COMERCIAL: TStringField;
    Qr_EnderecoEND_PORTARIA: TStringField;
    Qr_EnderecoEND_PRINCIPAL: TStringField;
    Qr_nota: TSTQuery;
    Qr_notaPED_CODIGO: TIntegerField;
    Qr_notaNFL_CODIGO: TIntegerField;
    Qr_notaNAT_DESCRICAO: TStringField;
    Qr_notaNFL_SERIE: TStringField;
    Qr_notaNAT_CFOP: TStringField;
    Qr_notaPED_NUMERO: TIntegerField;
    Qr_notaNFL_NUMERO: TStringField;
    Qr_notaNFL_VL_TL_NOTA: TBCDField;
    Qr_notaEMP_CODIGO: TIntegerField;
    Qr_notaEMP_NOME: TStringField;
    Qr_notaEMP_FANTASIA: TStringField;
    Qr_notaEMP_CNPJ: TStringField;
    Qr_notaEMP_EMAIL: TStringField;
    Qr_notaEND_ENDER: TStringField;
    Qr_notaEND_BAIRRO: TStringField;
    Qr_notaEND_CEP: TStringField;
    Qr_notaCDD_IBGE: TIntegerField;
    Qr_notaCDD_DESCRICAO: TStringField;
    Qr_notaEND_FONE: TStringField;
    Qr_notaUFE_SIGLA: TStringField;
    Qr_notaEND_PAIS: TIntegerField;
    Qr_notaEMP_INSC_EST: TStringField;
    Qr_notaNFL_DT_EMISSAO: TDateField;
    Qr_notaNFL_DT_SAIDA: TDateField;
    Qr_notaNFL_BS_ICMS: TBCDField;
    Qr_notaNFL_VL_ICMS: TBCDField;
    Qr_notaNFL_BS_ICMS_SUBST: TBCDField;
    Qr_notaNFL_VL_ICMS_SUBST: TBCDField;
    Qr_notaNFL_VL_TL_PROD: TBCDField;
    Qr_notaNFL_VL_FRETE: TBCDField;
    Qr_notaNFL_VL_SEGURO: TBCDField;
    Qr_notaNFL_VL_DESP_ACESS: TBCDField;
    Qr_notaNFL_VL_IPI: TBCDField;
    Qr_notaNFL_QT_PRODUTO: TBCDField;
    Qr_notaNFL_ESPECIE: TStringField;
    Qr_notaNFL_MARCA: TStringField;
    Qr_notaNFL_PESO_BRUTO: TStringField;
    Qr_notaNFL_PESO_LIQ: TStringField;
    Qr_notaCLB_NOME: TStringField;
    Qr_notaNFL_STATUS: TStringField;
    Qr_notaNFL_TIPO: TStringField;
    Qr_notaPED_OBS: TBlobField;
    Qr_notaNFL_VL_TL_SRV: TBCDField;
    Qr_notaPED_VL_DESCONTO: TBCDField;
    Qr_notaPED_DT_ALTERA: TSQLTimeStampField;
    Qr_notaPED_CODTRP: TIntegerField;
    Qr_notaEND_NUMERO: TStringField;
    Qr_notaNFL_CODTRP: TIntegerField;
    Qr_notaNFL_VOL_NUMERO: TStringField;
    Qr_notaMDF_GRUPO: TStringField;
    Qr_notaNFL_PLC_VEICULO: TStringField;
    Qr_notaNFL_PLC_UF: TStringField;
    Qr_notaNFL_PLC_RNTC: TStringField;
    Qr_notaPAI_DESCRICAO: TStringField;
    Qr_notaPED_PRAZO: TStringField;
    Qr_notaPED_CODEND: TIntegerField;
    Qr_notaFPT_DESCRICAO: TStringField;
    Qr_Print_Texto: TSTQuery;
    Qr_Print_TextoCFN_CODIGO: TIntegerField;
    Qr_Print_TextoCFN_NOME: TStringField;
    Qr_Print_TextoCFN_DESCRICAO: TStringField;
    Qr_Print_TextoCFN_TAMANHO: TIntegerField;
    Qr_Print_TextoCFN_LINHA: TIntegerField;
    Qr_Print_TextoCFN_COLUNA: TIntegerField;
    Qr_Print_TextoCFN_TP_PRINT: TIntegerField;
    Qr_Print_TextoCFN_TP_ALINHA: TIntegerField;
    Qr_Print_TextoCFN_CARACTER: TStringField;
    Qr_Print_TextoCFN_PRINT: TStringField;
    Qr_ItensITF_CODPRO: TIntegerField;
    Qr_ItensPRO_CODIGOFAB: TStringField;
    Qr_ItensPRO_DESCRICAO: TStringField;
    Qr_ItensMED_ABREVIATURA: TStringField;
    Qr_ItensEMB_ABREVIATURA: TStringField;
    Qr_ItensPRO_CODIGONCM: TStringField;
    Qr_ItensPRO_ORIGEM: TStringField;
    Qr_ItensITF_QTDE: TBCDField;
    Qr_ItensITF_VL_UNIT: TFloatField;
    Qr_ItensITF_SUBTOTAL: TFloatField;
    Qr_ItensITF_AQ_IPI: TBCDField;
    Qr_ItensITF_ESTOQUE: TStringField;
    Qr_ItensITF_AQ_ICMS: TBCDField;
    Qr_ItensPRO_TRIBUTACAO: TStringField;
    Qr_ItensVda: TSTQuery;
    Qr_ItensVdaITF_CODIGO: TIntegerField;
    Qr_ItensVdaPRO_CODIGOFAB: TStringField;
    Qr_ItensVdaPRO_CODIGOBAR: TStringField;
    Qr_ItensVdaPRO_CODIGONCM: TStringField;
    Qr_ItensVdaPRO_DESCRICAO: TStringField;
    Qr_ItensVdaMED_ABREVIATURA: TStringField;
    Qr_ItensVdaITF_QTDE: TBCDField;
    Qr_ItensVdaITF_VL_UNIT: TFloatField;
    Qr_ItensVdaITF_VL_CUSTO: TFloatField;
    Qr_ItensVdaITF_CODPRO: TIntegerField;
    Qr_ItensVdaITF_VL_SB_TOTAL: TFloatField;
    Qr_ItensVdaPRO_CODIGOFOR: TStringField;
    Qr_ItensVdaITF_VL_DESC: TBCDField;
    Qr_ItensVdaITF_AQ_DESC: TBCDField;
    Qr_ItensVdaITF_AQ_COM: TBCDField;
    Qr_ItensVdaITF_ESTOQUE: TStringField;
    Qr_ItensVdaITF_AQ_IPI: TBCDField;
    Qr_ItensVdaITF_AQ_ICMS: TBCDField;
    Qr_ItensVdaITF_CODEST: TIntegerField;
    Qr_ItensVdaITF_CODTPR: TIntegerField;
    Qr_ItensVdaPRO_DETALHES: TMemoField;
    Qr_ItensVdaSRP_CODIGO: TIntegerField;
    Qr_ItensVdaSRP_CODPRO: TIntegerField;
    Qr_ItensVdaSRP_CODENT: TIntegerField;
    Qr_ItensVdaSRP_CODSAI: TIntegerField;
    Qr_ItensVdaSRP_NUMERO: TStringField;
    Qr_ItensVdaSRP_OPERACAO: TStringField;
    Qr_ItensVdaSRP_DISPON: TStringField;
    Qr_ItensVdaSRP_DESCRICAO: TMemoField;
    procedure SB_SairClick(Sender: TObject);
    procedure Pc_ImagemBotao;
    procedure FormShow(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure Qr_notaAfterOpen(DataSet: TDataSet);
    procedure Qr_Print_TextoAfterOpen(DataSet: TDataSet);
    procedure SB_ImprimirClick(Sender: TObject);
  private
    { Private declarations }
    //chama impressora
    It_Prin: TPrin;
    It_Entrada: Integer;
    It_Device: Pchar;
    It_Driver:  Pchar;
    It_Porta: String;
    It_HDeviceMode: Thandle;
    It_IMpAtual: integer;

    //impressão
    It_taxa: Boolean;
    It_Ntaxa:Real;
    It_Tipo: integer;
    It_Itens: integer;

    //impostos
    It_subTrib: Boolean;
    It_Mostra_Icms: Boolean;

  public
    { Public declarations }
   It_cd_Nota: integer;
   function Fc_dadosnota(Pc_Tipo:String;Pc_Valor:integer):boolean;
   function Fc_Impressora():boolean;
   procedure Pc_NotaImpressa;
   procedure Pc_Impri_Texto(Pc_Acrescimo_L: Integer; Pc_Acrescimo_C: Integer; Pc_Chave: string; Pc_Texto: string);
   function Fc_Entrega(Lc_Codigo: Integer): Boolean;
  end;

var
  Fc_ImprimeNFE_c: TFc_ImprimeNFE_c;

implementation

  uses     Un_DM, UN_Sistema, UN_Padrao, UN_Msg, UN_Funcoes, UN_Principal, env, Un_Cupom_Fiscal_NFE_c;
{$R *.dfm}

function TFc_ImprimeNFE_c.Fc_Entrega(Lc_Codigo: Integer): Boolean;
var
  Lc_SqlTXT:String;
  Lc_Cd_Endereco, Lc_cd_Entrega: Integer;
  Lc_Qt_Endereco: Integer;
begin
  Result := False;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := dm.Ib_Transacao;
  Qr_Acao.Sql.Clear;

  Lc_SqlTXT := 'select end_codigo, end_principal from tb_endereco  add where end_codemp =:end_codemp';
  Qr_Acao.sql.add(Lc_SqlTXT);
  Qr_Acao.parambyname('end_codemp').AsInteger := LC_Codigo;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  Lc_qt_endereco := Qr_Acao.RecordCount;
  if Lc_qt_Endereco > 1 then
    Qr_Acao.Locate('END_Principal' , 'S', []);
  Lc_Cd_Endereco := Qr_Acao.FieldByName('End_Codigo').AsInteger;
  Lc_Codigo:= It_Cd_Nota;

  Qr_Acao.Active := False;
  Qr_Acao.Transaction := dm.Ib_Transacao;
  Qr_Acao.sql.clear;
  Lc_SqlTXT := 'S';
  Lc_SqlTxt := 'select End_Codigo, End_CNPJ, End_Ender, End_Complem, End_Bairro,'+
               'End_Cep, Cdd.Cdd_Descricao, Cdd.Cdd_IBGE, Ufe.Ufe_Sigla, EndNumero'+
               'Ped_Codend from Tb_Endereco edd inner join Tb_Cidade Cdd on'+
               '(Cdd.Cdd_Codigo =  Edd.End_codCdd) inner join tb_Uf UFE on'+
               '(Ufe.Ufe_Codigo = Edd.Edd_codufe) inner join Tb_Pedido Ped'+
               'on (Ped.Ped_codend = Edd.End_Codigo) inner join Tb_Nota_Fiscal NFL'+
               'on (Nfl.Nfl_Codped = Ped.Ped_codigo) whereNfl.Nfl_Codigo =: Nfl_Codigo';
   Qr_Acao.SQl.Add(Lc_sqlTxt);
   Qr_Acao.ParamByName('Nfl_Codigo').AsInteger :=Lc_Codigo;
   Qr_Acao.Active :=True;
   Qr_Acao.FetChAll;

   if (Lc_Qt_Endereco = 1) then
     begin
       Result := False;
       Exit;
     end;

   Lc_Cd_Entrega :=  Qr_Acao.fieldByName('Ped_Codend').AsInteger;

   if Lc_Cd_Endereco <> Lc_Cd_Entrega then
      Result := True
   else
     begin
       Result := False;
       Qr_Acao.Active := False;
     end;
 end;



procedure TFc_ImprimeNFE_c.SB_SairClick(Sender: TObject);
begin
  Close;
end;

procedure TFc_ImprimeNFE_c.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
end;

Procedure TFc_ImprimeNFE_c.Pc_ImagemBotao;
begin
  with fr_principal do
    Begin
    //Geral;
      SB_Imprimir.Glyph.Assign(Fc_CarregaImagemBotao('IMPRIMIR'));
      Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    end;
end;
procedure TFc_ImprimeNFE_c.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;
function TFc_ImprimeNFE_c.Fc_dadosnota(Pc_tipo:String;Pc_Valor:Integer):Boolean;
var
  Lc_SqlTxt: String;
begin
  Result := true;
  Qr_Nota.Close;
  Qr_Nota.SQL.Clear;

  Lc_SqlTxt := 'select Ped_Codigo, Ped_tipo, Nfl_Codigo, Nat_Descricao, Fpt_Descricao,'+
                        'Nfl_serie, Nat_CFOP, Ped_Numero, Nfl_Numero, Nfl_vl_Tl_Nota, Emp_Codigo, Emp_Insc_Est,'+
                        ' Emp_Email, Emp_nome, EMp_Fantasia, Emp_CNPJ, End_endereco, END_Numero, End_Bairro, '+
                        'End_Complem, End_PAis, End_Cep, End_fone, Cdd_IBGE, Cdd_Descricao, Ufe_Sigla, '+
                        'Nfl_DT_Emissao, NFL_DT_Saida, NFLBS_ICMS, NFL_Vl_ICMS, NFL_BS_ICMS_Subst,'+
                        'NFL_VL_ICMS_Subst, NFL_VL_TL_Prod, NFL_VL_Frete, NFL_VL_Seguro, NFL_VL_Desp_Acess,'+
                        'NFL_VL_IPI, NFL_QT_Produto, NFL_Especie, NFL_Marca, NFL_Peso_Bruto, CLB_Nome,'+
                        'Nfl_Status, NFL_Tipo, Ped_Obs, Nfl_Vl_TL_Serv, Ped_Vl_desconto, Ped_Dt_Altera,'+
                        'Ped_CodTRP, MDF_Grupo, NFL_Vol_Numero, NFL_PLC_Veiculo, NFL_PLC_UF, NFL_PLC_RNTC,'+
                        'Ped_Razao, Pai_Descricao, Ped_Codend from TB_NOTA_FISCAL tb_Nota_Fiscal'+
                        'inner join TB_PEDIDO tb_pedido on (Tb_pedido.Ped_codigo = tb_nota_fiscal>NFL_CODPED)'+
                        'Inner Join TB_EMPRESA tb_empresa, On (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)'+
                        'left outer join TB_NATUREZA tb_natureza on (tb_natureza.NAT_Codigo = tb_nota_fiscal.NFL_CODNAT)'+
                        'Inner Join TB_ENDERECO tb_endereco on (tb_endereco.END_CODIGO = tb_pedido-PED_CODEND)'+
                        'Inner Join TB_CIDADE tb_cidade on (tb_cidade.CDD_CIDADE tb_endereco.ENDCODCDD)'+
                        'Left outer join TB_COLABORADOR tb_colaborador on (tb_colaborador.CLBCodigo = tb_pedido.PED_CODVDO)'+
                        'Inner join TB_PAIS tb_pais on (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS)'+
                        'Inner join TB_MODAL_FRETE tb_modal_frete on (tb_modal_frete.MDF_CODIGO = tb_nota_fiscal.nfl_cta_frete)';

  if (pc_tipo = 'c') then
     Lc_SqlTxt := Lc_SqlTxt + 'WHERE 9tb_nota_fiscal.NFL_CODIGO =: NFL_CODIGO)'
  else
     Lc_SqlTxt := Lc_SqlTxt + 'WHERE (tb_nota_fiscal.NFL_Numero =: NFL_NUMERO)';

  Qr_nota.SQL.Add(Lc_SqlTxt);

  if (pc_tipo)  = 'C' then
     Qr_nota.ParamByName('NFL_CODIGO').AsInteger := It_Cd_nota
  else
     Qr_nota.ParamByName('NFL_NUMERO').AsInteger := Pc_Valor;

  Qr_Nota.DisableControls;

  try
    Qr_nota.Active := True;
    Qr_nota.FetchAll;

  if Qr_nota.RecordCount = 0 then
    Begin
      Result := False;
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
            'Não foi possivel Carregar a nota.' + EOLN +
            'verifique e tente novamente' + EOLN,
            ['OK'], [bEscape], mpErro);
    end;
  finally
    Qr_Nota.EnableControls;
  end;
end;
function TFc_ImprimeNFE_c.Fc_Impressora() :boolean;
var
  Lc_Porta : Pchar;
begin
  It_ImpAtual := Printer.PrinterIndex;
  if PrintDialog1.Execute then
    begin
      getmem(It_Device, 255);
      getmem(It_Driver, 255);
      getmem(LC_Porta, 255);
    try
      Printer.getprinter(It_device, It_Driver, Lc_Porta, It_HdeviceMode);
      it_porta:= LC_POrta;
      Result := True;
    finally
      FreeMem(It_Device);
      FReeMem(It_Driver);
      FreeMem(Lc_POrta);
    end;
    end
  else
    Result := False;
end;
procedure TFc_ImprimeNFE_c.Pc_NotaImpressa;
var
  Lc_X, LC_I, LC_Colunas:Integer;
  Lc_CPF_CNPJ:String;
  Lc_Zr_CNPF: String;
  Lc_Recebedor : String;
  Lc_Ende_Rec : String;
  Lc_Nr_Itens : Integer;
  Lc_Lnh_Obs : Integer;
  V_Str_ICMS : STring;
  Lc_Entrega : Boolean;
begin
  if not Assigned(It_Prin) then
  begin
    It_Prin := Tprin.Create(Application);
    It_Prin.Porta := It_Porta;
    It_Prin.Initialize(It_Porta);
    It_Prin.Condensa(True);
  end;

  Qr_Endereco.Active := False;
  Qr_Endereco.ParamByName('Emp_codigo').AsInteger := Qr_NotaEmp_codigo.AsInteger;
  Qr_Endereco.Active:= True;
  Qr_Endereco.First;

  Pc_Impri_Texto(0,0, 'NSAIDA', 'XX');
  Pc_Impri_Texto(0,0, 'NCFOP_D', copy(Qr_NotaNAT_DESCRICAO.AsString, 1,38));

  if Qr_EnderecoUFE_SIGLA.AsString = 'GO' then
    begin
      if It_SubTrib then
        Pc_Impri_texto(0,0, 'NCFOP', Qr_notaNAT_CFOP.AsString)
      else
        Pc_Impri_Texto(0,0, 'NCFOP', Qr_NotaNAT_CFOP.AsString);
      end;
    Pc_Impri_Texto(0,0, 'NRAZAO', Qr_EmpresaEMP_NOME.AsString);

    Lc_Recebedor := Qr_EmpresaEMP_NOME.AsString;
    Lc_Recebedor := Qr_empresaEMP_NOME.AsString;

    if Length(Qr_EmpresaEMP_CNPJ.AsString)=11 then
      Pc_Impri_Texto(0,0,'NCNPJ', Fc_MascaraCPF(Qr_empresaEMP_CNPJ.AsString))
    else
      Pc_Impri_Texto(0,0,'NCNPJ',Fc_MascaraCNPJ(Qr_EmpresaEMP_CNPJ.AsString));

    Pc_Impri_Texto(0,0,'NEMISSAO',Qr_NotaNFL_DT_EMISSAO.AsString);
    Pc_Impri_Texto(0,0,'NENDERECO',Qr_EnderecoEND_ENDER.AsString + ',' + Qr_EnderecoEND_NUMERO.AsString);
    Pc_Impri_Texto(0,0,'NBAIRRO',Qr_enderecoEND_BAIRRO.AsString);
    Pc_Impri_texto(0,0,'NCEP', Copy(Qr_EnderecoEND_CEP.AsString,1,3)+'-' + Copy(Qr_EnderecoEND_CEP.AsString,4,5));
    Pc_Impri_Texto(0,0,'NSAIDA_ENTRADA',Qr_NotaNFL_DT_SAIDA.AsString);
    Pc_Impri_Texto(0,0,'NMUNICIPIO',Qr_EnderecoCDD_DESCRICAO.AsString);
    Pc_Impri_Texto(0,0,'NMUNICIPIO',Qr_EnderecoCDD_DESCRICAO.AsString);
    Pc_Impri_Texto(0,0,'NFONEFAX',fc_MascaraFone(Qr_EnderecoEND_FONE.asstring));
    Pc_Impri_Texto(0,0,'NUF',Qr_EnderecoUFE_SIGLA.AsString);
    Pc_Impri_Texto(0,0,'NINSC_EST',Qr_EmpresaEMP_INSC_EST.asstring);

    Lc_X:=0;
    if Qr_EnderecoUFE_SIGLA.AsString='GO' then
       V_Str_ICMS:='17'
    else
       V_Str_ICMS:='18';
    Qr_ItensVda.Active := false;
    Qr_ItensVda.ParamByName('NFL_CODIGO').AsInteger:=Qr_NotaNFL_Codigo.AsInteger;
    Qr_ItensVda.Active := True;
    Qr_ItensVda.FetchAll;

    Lc_X:=2;
    //itens da nota
    Qr_Print_Texto.Active := False;
    Qr_Print_Texto.ParamByName('CHAVE').AsString := 'NITENSNOTA';
    Qr_print_Texto.Active := True;
    Lc_Nr_Itens := Qr_Print_TextoCFN_TAMANHO.AsInteger;
    Qr_Itens.First;
    while not Qr_Itens.eof do
      begin
        Pc_Impri_Texto(Lc_I,0,'CODPRODUTO',Qr_ItensPRO_CODIGOFAB.AsString);
        Pc_Impri_Texto(Lc_I,0,'DESCPRODUTO',Qr_ItensPRO_DESCRICAO.AsString);
        Pc_Impri_Texto(Lc_I,0,'QTDEPRODUTO',Qr_ItensITF_QTDE.AsString);
        Pc_Impri_Texto(Lc_I,0,'VALORUNIT',floattostrf((Qr_ItensITF_VL_UNIT.AsCurrency),ffFixed,18,2));
        pc_Impri_texto(Lc_I,0,'TOTALLINHA',floattostrf((Qr_ItensITF_SUBTOTAL.AsCurrency),ffFixed,18,2));
        Pc_Impri_texto(Lc_I,0,'ICMS',Qr_ItensITF_AQ_ICMS.AsString);
        Lc_I := LC_I+1;
        Qr_Itens.Next;

    if Qr_NotaPED_VL_DESCONTO.Value > 0 then
      Lc_Nr_Itens := Lc_Nr_Itens - 1;

    Lc_Entrega := Fc_Entrega(Qr_Nota.FieldByName('EMP_CODIGO').AsInteger);
    if Lc_Entrega then
        Lc_Nr_Itens := Lc_Nr_Itens - 1;

    end;

    Pc_Impri_Texto(0,0,'NVALORPRODUTO', floattostrf((Qr_NotaNFL_VL_TL_PROD.AsCurrency),ffFixed,18,2));
    if (Qr_NotaNFL_VL_FRETE.AsCurrency > 0) then
       Pc_Impri_Texto(0,0,'NVALORFRETE', floattostrf((Qr_NotaNFL_VL_FRETE.AsCurrency),ffFixed,18,2));
    Pc_Impri_Texto(0,0,'NVALORNOTA',floattostrf((Qr_NotaNFL_VL_TL_NOTA.AsCurrency),ffFixed,18,2));

  It_Prin.Condensa(False);
  It_Prin.Finalize;
  FreeAndNil(It_Prin);
end;
procedure TFc_ImprimeNFE_C.Pc_Impri_Texto(Pc_Acrescimo_L,
  Pc_Acrescimo_C: Integer; Pc_Chave, Pc_Texto: string);
var
  Lc_tipo, Lc_Linha, Lc_Coluna, Lc_Tamanho: integer;
  Lc_Caracter: string;
begin
   try
     Qr_print_texto.Active := False;
     Qr_Print_Texto.ParamByName('CHAVE').asString := Pc_Chave;
     Qr_Print_Texto.Active := True;
     Qr_Print_texto.Last;

   if Qr_Print_Texto.RecordCount = 0 then
   begin
      MensagemPadrao(TITULO_ERRO, ATENCAO,' + EOLN + EOLN +
                      'Chave de impressão não encontrada,' + EOLN +
                      'Verifique os campos da nota,' +  EOLN,
                      ['OK'], [bEscape], mpErro);
      Exit;
   end;

   Lc_linha := Pc_acrescimo_L + Qr_Print_TextoCFN_LINHA.AsInteger;
   Lc_Coluna := PC_Acrescimo_C + Qr_Print_TextoCFN_COLUNA.AsInteger;
   Lc_Tamanho := Qr_Print_TextoCFN_TAMANHO.AsInteger;
   Lc_Tipo := Qr_Print_TextoCFN_TP_ALINHA.AsInteger;
   LC_Caracter := Qr_Print_TextoCFN_CARACTER.AsString;

   case LC_Tipo of
     1:
       begin
         It_Prin.TextOutLC(Lc_Linha, Lc_Coluna, PC_Texto);
       end;

     2:
       begin
         It_Prin.TextOutLC(Lc_Linha, Lc_Coluna, PC_Texto);
       end;

     3:
       begin
         It_Prin.TextOutLC(Lc_Linha, Lc_coluna, Padr(Pc_texto, Lc_Tamanho));
       end;

end;
except
  MensagemPadrao(TITULO_ERRO, ATENCAO. ' + EOLN + EOLN +
                 'Erro na Chave Impore~ssão. ' + EOLN +
                 '  Procedimento Falhou.' + EOLN,
                 ['OK'], [bEscape], mpErro);
  end;
end;


procedure TFc_ImprimeNFE_c.Qr_notaAfterOpen(DataSet: TDataSet);
begin
  Qr_Empresa.Active := False;
  Qr_Empresa.ParamByName('EMP_CODIGO').AsInteger := Qr_NotaEMP_CODIGO.AsInteger;
  Qr_Empresa.Active := True;

  Qr_Endereco.Active := False;
  Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := Qr_NotaEMP_CODIGO.AsInteger;
  Qr_Endereco.Active := True;

end;

procedure TFc_ImprimeNFE_c.Qr_Print_TextoAfterOpen(DataSet: TDataSet);
begin
  Qr_Print_Texto.FetchAll;
end;

procedure TFc_ImprimeNFE_c.SB_ImprimirClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self, 'I');
    Self.Enabled := False;
    Pc_LimpaQRPreviweMemoria;

  finally
    Pc_ProcesoAguarde(Self, 'F');
    Self.Enabled := True;
  end;
     Fc_Impressora();
end;

end.
