unit Un_RL_Ficha_Cadastro;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, pngimage, DB, STQuery, jpeg;

type
  TRL_Ficha_Cadastro = class(TForm)
    Qrpt: TQuickRep;
    Titulo: TQRBand;
    Img_Logo: TQRImage;
    Lb_Emp_Nome: TQRLabel;
    Lb_Emp_Doc: TQRLabel;
    Lb_Emp_End: TQRLabel;
    Lb_Emp_Fones: TQRLabel;
    Lb_Emp_www: TQRLabel;
    Lb_Emp_email: TQRLabel;
    DadosGerais: TQRLoopBand;
    QRLabel10: TQRLabel;
    E_Dg_NomeMae: TQRLabel;
    QRLabel68: TQRLabel;
    E_Dg_NomePai: TQRLabel;
    QRLabel66: TQRLabel;
    E_Dg_celular: TQRLabel;
    QRLabel64: TQRLabel;
    E_Dg_Fone: TQRLabel;
    QRLabel62: TQRLabel;
    E_Dg_Escolaridade: TQRLabel;
    QRLabel58: TQRLabel;
    E_Dg_Reside_Desde: TQRLabel;
    QRLabel56: TQRLabel;
    E_Dg_Naturalidade: TQRLabel;
    QRLabel54: TQRLabel;
    E_Dg_Nacionalidade: TQRLabel;
    QRLabel52: TQRLabel;
    E_Dg_Cidade: TQRLabel;
    QRLabel50: TQRLabel;
    E_Dg_Sit_Imovel: TQRLabel;
    QRLabel48: TQRLabel;
    E_Dg_Residencia: TQRLabel;
    QRLabel46: TQRLabel;
    E_Dg_Cep: TQRLabel;
    QRLabel44: TQRLabel;
    E_Dg_Estado: TQRLabel;
    QRLabel42: TQRLabel;
    E_Dg_Bairro: TQRLabel;
    QRLabel40: TQRLabel;
    E_Dg_Endereco: TQRLabel;
    QRLabel36: TQRLabel;
    E_Dg_Dt_Rg_Emissao: TQRLabel;
    QRLabel34: TQRLabel;
    E_Dg_Org_Emissor: TQRLabel;
    QRLabel32: TQRLabel;
    E_Dg_Dt_Nascimento: TQRLabel;
    QRLabel30: TQRLabel;
    E_Dg_Sexo: TQRLabel;
    QRLabel28: TQRLabel;
    E_Dg_Est_Civil: TQRLabel;
    QRLabel26: TQRLabel;
    E_Dg_Nome: TQRLabel;
    QRLabel15: TQRLabel;
    E_Dg_cpf: TQRLabel;
    QRLabel13: TQRLabel;
    E_Dg_Rg: TQRLabel;
    QRLabel11: TQRLabel;
    E_Dg_Data: TQRLabel;
    QRLabel2: TQRLabel;
    Qr_DadosGerais: TSTQuery;
    Cab_Dependentes: TQRLoopBand;
    Lb_Tit_Dependentes: TQRLabel;
    Qr_Dependentes: TSTQuery;
    Lb_Dpt_nome: TQRLabel;
    Lb_Dpt_Parentesco: TQRLabel;
    Dependentes: TQRLoopBand;
    E_Dpt_Nome: TQRLabel;
    E_Dpt_Parentesco: TQRLabel;
    QRLabel99: TQRLabel;
    E_Dp_Cidade: TQRLabel;
    QRLabel97: TQRLabel;
    E_Dp_bairro: TQRLabel;
    QRLabel95: TQRLabel;
    E_Dp_Nr_Endereco: TQRLabel;
    QRLabel93: TQRLabel;
    E_Dp_Endereco: TQRLabel;
    QRLabel91: TQRLabel;
    E_Dp_Nr_Beneficio: TQRLabel;
    E_Dp_Dt_Admissao: TQRLabel;
    QRLabel87: TQRLabel;
    E_Dp_Vl_renda: TQRLabel;
    QRLabel85: TQRLabel;
    E_Dp_Empregador: TQRLabel;
    QRLabel83: TQRLabel;
    E_Dp_Profissao: TQRLabel;
    QRLabel81: TQRLabel;
    E_Dp_Atividade: TQRLabel;
    QRLabel79: TQRLabel;
    E_Dp_Classe: TQRLabel;
    QRLabel77: TQRLabel;
    E_Dp_TipoEmpresa: TQRLabel;
    QRLabel75: TQRLabel;
    QRLabel74: TQRLabel;
    E_Dp_Natur_Jur: TQRLabel;
    QRLabel123: TQRLabel;
    E_Dp_SocioDesde: TQRLabel;
    QRLabel121: TQRLabel;
    E_Dp_Vl_Capital: TQRLabel;
    QRLabel119: TQRLabel;
    E_Dp_Dt_fundacao: TQRLabel;
    QRLabel117: TQRLabel;
    E_Dp_Cnpj_Empregador: TQRLabel;
    QRLabel115: TQRLabel;
    E_Dp_Insc_Est_Empregador: TQRLabel;
    QRLabel113: TQRLabel;
    E_Dp_Fax: TQRLabel;
    QRLabel111: TQRLabel;
    E_Dp_Fone: TQRLabel;
    QRLabel109: TQRLabel;
    E_Dp_Estado: TQRLabel;
    QRLabel107: TQRLabel;
    E_Dp_Valor: TQRLabel;
    QRLabel105: TQRLabel;
    E_Dp_Vl_Outros: TQRLabel;
    QRLabel103: TQRLabel;
    E_Dp_Cep: TQRLabel;
    QRLabel101: TQRLabel;
    E_Dp_Vl_Faturamento: TQRLabel;
    QRLabel89: TQRLabel;
    DadosProfissionais: TQRLoopBand;
    DadosContador: TQRLoopBand;
    QRLabel37: TQRLabel;
    DadosConjuge: TQRLoopBand;
    QRLabel3: TQRLabel;
    E_Dp_Ctdr_Fone: TQRLabel;
    QRLabel128: TQRLabel;
    E_Dp_Ctdr_Nome: TQRLabel;
    QRLabel126: TQRLabel;
    E_Dp_Ctdr_Fax: TQRLabel;
    QRLabel5: TQRLabel;
    E_Dp_Ctdr_Celular: TQRLabel;
    QRLabel7: TQRLabel;
    E_Cg_Email: TQRLabel;
    QRLabel161: TQRLabel;
    E_Cg_Celular: TQRLabel;
    QRLabel159: TQRLabel;
    E_Cg_Fone: TQRLabel;
    QRLabel157: TQRLabel;
    E_Cg_Correspondencia: TQRLabel;
    QRLabel155: TQRLabel;
    E_Cg_Cidade: TQRLabel;
    QRLabel153: TQRLabel;
    E_Cg_Cep: TQRLabel;
    QRLabel151: TQRLabel;
    E_Cg_Bairro: TQRLabel;
    QRLabel149: TQRLabel;
    E_Cg_Endereco: TQRLabel;
    QRLabel147: TQRLabel;
    E_Cg_Empregador: TQRLabel;
    QRLabel145: TQRLabel;
    E_Cg_VL_renda: TQRLabel;
    QRLabel143: TQRLabel;
    E_Cg_Profissao: TQRLabel;
    QRLabel141: TQRLabel;
    E_Cg_Org_Emissao: TQRLabel;
    QRLabel139: TQRLabel;
    E_Cg_Dt_Nascimento: TQRLabel;
    QRLabel137: TQRLabel;
    E_Cg_RG: TQRLabel;
    QRLabel135: TQRLabel;
    E_Cg_CPF: TQRLabel;
    QRLabel133: TQRLabel;
    E_Cg_Nome: TQRLabel;
    QRLabel131: TQRLabel;
    QRLabel264: TQRLabel;
    E_Cg_Nr_Endereco: TQRLabel;
    DadosAvalista: TQRLoopBand;
    QRLabel8: TQRLabel;
    E_Da_VL_Renda: TQRLabel;
    QRLabel274: TQRLabel;
    E_Da_Profissao: TQRLabel;
    QRLabel276: TQRLabel;
    QRLabel277: TQRLabel;
    E_Da_Dt_Nascimento: TQRLabel;
    QRLabel279: TQRLabel;
    E_Da_Rg: TQRLabel;
    QRLabel281: TQRLabel;
    E_Da_CPF: TQRLabel;
    QRLabel283: TQRLabel;
    E_Da_Nome: TQRLabel;
    QRLabel285: TQRLabel;
    E_Da_Org_Emissao: TQRLabel;
    E_Da_Email: TQRLabel;
    QRLabel14: TQRLabel;
    E_Da_Celular: TQRLabel;
    QRLabel17: TQRLabel;
    E_Da_Fone: TQRLabel;
    QRLabel19: TQRLabel;
    E_Da_Correspondencia: TQRLabel;
    QRLabel21: TQRLabel;
    E_Da_Cidade: TQRLabel;
    QRLabel23: TQRLabel;
    E_Da_Cep: TQRLabel;
    QRLabel25: TQRLabel;
    E_Da_Bairro: TQRLabel;
    QRLabel29: TQRLabel;
    E_Da_Endereco: TQRLabel;
    QRLabel33: TQRLabel;
    E_Da_Empregador: TQRLabel;
    QRLabel38: TQRLabel;
    QRLabel39: TQRLabel;
    E_Da_Nr_Endereco: TQRLabel;
    Cab_ReferenciaBancaria: TQRLoopBand;
    QRLabel9: TQRLabel;
    ReferenciaBancaria: TQRLoopBand;
    E_Rb_Cheque: TQRLabel;
    QRLabel174: TQRLabel;
    E_Rb_Tp_conta: TQRLabel;
    QRLabel172: TQRLabel;
    E_Rb_Dt_Abertura: TQRLabel;
    QRLabel170: TQRLabel;
    E_Rb_Conta: TQRLabel;
    QRLabel168: TQRLabel;
    E_Rb_Agencia: TQRLabel;
    QRLabel166: TQRLabel;
    E_Rb_Banco: TQRLabel;
    QRLabel164: TQRLabel;
    Cab_ReferenciaPessoal: TQRLoopBand;
    QRLabel12: TQRLabel;
    ReferenciaPessoal: TQRLoopBand;
    E_Rp_Cidade: TQRLabel;
    E_Rp_Fone: TQRLabel;
    E_Rp_Afinidade: TQRLabel;
    E_Rp_Nome: TQRLabel;
    QRLabel177: TQRLabel;
    QRLabel179: TQRLabel;
    QRLabel181: TQRLabel;
    QRLabel183: TQRLabel;
    Cab_ReferenciaComercial: TQRLoopBand;
    QRLabel16: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel24: TQRLabel;
    ReferenciaComercial: TQRLoopBand;
    E_Rc_ClienteDesde: TQRLabel;
    E_Rc_Celular: TQRLabel;
    E_Rc_Fone: TQRLabel;
    E_Rc_Nome: TQRLabel;
    E_Rc_Fax: TQRLabel;
    QRLabel45: TQRLabel;
    Cab_BemGarantia: TQRLoopBand;
    QRLabel27: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel47: TQRLabel;
    BemGarantia: TQRLoopBand;
    E_Bg_Referencia: TQRLabel;
    E_Bg_Valor: TQRLabel;
    E_Bg_Descricao: TQRLabel;
    E_Bg_Documento: TQRLabel;
    Qr_Endereco: TSTQuery;
    Qr_DadosProfissionais: TSTQuery;
    Qr_DadosConjuge: TSTQuery;
    Qr_DadosAvalista: TSTQuery;
    Qr_Ref_Bancaria: TSTQuery;
    Qr_Ref_Pessoal: TSTQuery;
    Qr_Ref_Comercial: TSTQuery;
    Qr_BemGarantia: TSTQuery;
    QRLoopBand1: TQRLoopBand;
    QRLabel1: TQRLabel;
    E_Fp_Obs: TQRMemo;
    procedure QrptNeedData(Sender: TObject; var MoreData: Boolean);
    procedure DependentesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ReferenciaBancariaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ReferenciaPessoalBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ReferenciaComercialBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BemGarantiaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_cd_ficha : Integer;
    It_Cd_Empresa : Integer;
    It_Cd_Empregador : Integer;
    It_Cd_Conjuge : Integer;
    It_Cd_Empregador_Cg : Integer;
    It_Cd_Avalista : Integer;
    It_Cd_Empregador_Da : Integer;
    procedure Pc_Cabecalho;
    //Aba dados Gerais
    procedure Pc_MostraDadosGerais;
    //Aba dados Profissionais
    procedure Pc_MostraDadosProfissionais;
    //Aba Conjuge
    procedure Pc_MostraDadosConjuge;
    //Aba Dependentes
    procedure Pc_MostraDadosDependentes;
    //Aba Dados Avalista
    procedure Pc_MostraDadosAvalista;
    //Aba Referencia Bancaria
    procedure Pc_MostraDadosReferenciaBancaria;
    //Aba Referencia Pessoal
    procedure Pc_MostraDadosReferenciaPessoal;
    //Aba Referencia comecial
    procedure Pc_MostraDadosReferenciaComercial;
    //Aba Bem em Garantia
    procedure Pc_MostraDadosBemGarantia;
    //Aba Formas de pagamentos
    procedure Pc_MostraFormasPagamento;

  end;

var
  RL_Ficha_Cadastro: TRL_Ficha_Cadastro;

implementation

uses     UN_Sistema, Un_DM, Un_Regra_Negocio;
{$R *.dfm}

procedure TRL_Ficha_Cadastro.Pc_Cabecalho;
begin
  WITH DM DO
    bEGIN
    Pc_AtivaEstabelecimento;
    Fc_BuscaImagemEmpresa(img_logo.Picture, 'LOGO');

    Lb_Emp_Nome.Caption := Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString;
    Lb_Emp_Doc.Caption := 'C.N.P.J: '+fc_MascaraCNPJ(Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsString) + ' -  I.E.: '+ Qr_Estabelecimento.FieldByname('EMP_INSC_EST').AsString;
    Lb_Emp_End.Caption := Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ' - ' +Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString + ' - ' + Fc_MascaraCep(Qr_Estabelecimento.FieldByname('END_CEP').AsString) + ' - ' +Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' +Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString + ' - Fone: ' +fc_MascaraFone(Qr_Estabelecimento.FieldByname('END_FONE').AsString);
    Lb_Emp_www.Caption := Qr_Estabelecimento.FieldByname('EMP_SITE').AsString;
    Lb_Emp_email.Caption := Qr_Estabelecimento.FieldByName('EMP_EMAIL').AsString;
    END;
end;

//Aba dados Gerais
procedure TRL_Ficha_Cadastro.Pc_MostraDadosGerais;
Begin
  Qr_DadosGerais.Active := False;
  Qr_DadosGerais.ParamByName('FCT_CODIGO').AsInteger := It_cd_ficha;
  Qr_DadosGerais.Active := True;
  It_Cd_Empresa := Qr_DadosGerais.FieldByName('FCT_CODEMP').AsInteger;
  It_Cd_Conjuge := Qr_DadosGerais.FieldByName('FCT_CONJUGE').AsInteger;
  It_Cd_Avalista := Qr_DadosGerais.FieldByName('FCT_AVALISTA').AsInteger;
  E_Dg_Nome.Caption := Qr_DadosGerais.FieldByName('EMP_NOME').AsString;
  if trim(Qr_DadosGerais.FieldByName('FCT_DATA').AsString) <> '' then
    E_Dg_Data.Caption := Qr_DadosGerais.FieldByName('FCT_DATA').AsString
  else
    E_Dg_Data.Caption := DateToStr(Date);
  E_Dg_cpf.Caption :=  fc_MascaraCPF(Qr_DadosGerais.FieldByName('EMP_CNPJ').AsString);
  E_Dg_Rg.Caption := Qr_DadosGerais.FieldByName('EMP_INSC_EST').AsString;
  E_Dg_Org_Emissor.Caption := Qr_DadosGerais.FieldByName('PFS_RG_ORG_EMISSAO').AsString;
  if trim(Qr_DadosGerais.FieldByName('PFS_RG_DT_EMISSAO').AsString) <> '' then
    E_Dg_Dt_Rg_Emissao.Caption := Qr_DadosGerais.FieldByName('PFS_RG_DT_EMISSAO').AsString
  else
    E_Dg_Dt_Rg_Emissao.Caption := Qr_DadosGerais.FieldByName('FCT_DATA').AsString;
  if Trim(Qr_DadosGerais.FieldByName('EMP_DT_FUNDA').AsString)<> '' then
    E_Dg_Dt_Nascimento.Caption := Qr_DadosGerais.FieldByName('EMP_DT_FUNDA').AsString
  else
    E_Dg_Dt_Nascimento.Caption := Qr_DadosGerais.FieldByName('FCT_DATA').AsString;
  E_Dg_Nome.Caption := Qr_DadosGerais.FieldByName('EMP_NOME').AsString;

  case StrToIntdEF(Qr_DadosGerais.FieldByName('PFS_EST_CIVIL').AsString,0) of
    0:E_Dg_Est_Civil.Caption := 'Solteiro';
    1:E_Dg_Est_Civil.Caption := 'Casado';
    2:E_Dg_Est_Civil.Caption := 'Divorciado';
    3:E_Dg_Est_Civil.Caption := 'Vi�vo';
  end;
  case StrToIntdEF(Qr_DadosGerais.FieldByName('PFS_SEXO').AsString,0) of
    0:E_Dg_Sexo.Caption := 'Feminino';
    1:E_Dg_Sexo.Caption := 'Masculino';
  end;
  //dados do Endereco
  Qr_Endereco.Active := False;
  Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empresa;
  Qr_Endereco.Active := True;

  E_Dg_Endereco.Caption := Qr_Endereco.FieldByName('END_ENDER').AsString + ', ' + Qr_Endereco.FieldByName('END_NUMERO').AsString;
  E_Dg_Bairro.Caption := COPY(Qr_Endereco.FieldByName('END_BAIRRO').AsString,1,25);
  E_Dg_Cep.Caption := Qr_Endereco.FieldByName('END_CEP').AsString;
  E_Dg_Cidade.Caption := Qr_Endereco.FieldByName('CDD_DESCRICAO').AsString;
  E_Dg_Estado.Caption := Qr_Endereco.FieldByName('UFE_SIGLA').AsString;
  E_Dg_Residencia.Caption := Qr_DadosGerais.FieldByName('PFS_RESIDENCIA').AsString;
  case StrToIntdEF(Qr_DadosGerais.FieldByName('PFS_SIT_RESIDENCIA').AsString,0) of
    0:E_Dg_Sit_Imovel.Caption := 'Quitado';
    1:E_Dg_Sit_Imovel.Caption := 'Financiado';
    2:E_Dg_Sit_Imovel.Caption := 'Alugado';
  end;
  E_Dg_Nacionalidade.Caption := Qr_DadosGerais.FieldByName('PFS_NACIONALIDADE').AsString;
  E_Dg_Naturalidade.Caption := Qr_DadosGerais.FieldByName('PFS_NATURALIDADE').AsString;
  E_Dg_Reside_Desde.Caption := Qr_DadosGerais.FieldByName('PFS_TEMPO_RESIDENCIA').AsString;
  E_Dg_Escolaridade.Caption := Qr_DadosGerais.FieldByName('PFS_ESCOLARIDADE').AsString;
  E_Dg_Fone.Caption := fc_MascaraFone(Qr_Endereco.FieldByName('END_FONE').AsString);
  E_Dg_Celular.Caption := fc_MascaraFone(Qr_Endereco.FieldByName('END_CELULAR').AsString);
  E_Dg_NomePai.Caption := Qr_DadosGerais.FieldByName('PFS_NOME_PAI').AsString;
  E_Dg_NomeMae.Caption := Qr_DadosGerais.FieldByName('PFS_NOME_MAE').AsString;
end;

//Aba dados Profissionais
procedure TRL_Ficha_Cadastro.Pc_MostraDadosProfissionais;
Begin
  Qr_DadosProfissionais.Active := False;
  Qr_DadosProfissionais.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empresa;
  Qr_DadosProfissionais.Active := true;
  Qr_DadosProfissionais.FetchAll;
  Qr_DadosProfissionais.First;
  if Qr_DadosProfissionais.RecordCount >0 then
    Begin
    DadosProfissionais.PrintCount := 1;
    case StrToIntDef(Qr_DadosProfissionais.FieldByName('FCP_TP_TRABALHO').AsString,0) of
      0: E_Dp_TipoEmpresa.Caption := 'Formal';
      1: E_Dp_TipoEmpresa.Caption := 'Informal';
    end;
    E_Dp_Classe.Caption := Qr_DadosProfissionais.FieldByName('FCP_CLASSE').AsString;
    E_Dp_Atividade.Caption := Qr_DadosProfissionais.FieldByName('FCP_ATIVIDADE').AsString;
    E_Dp_Profissao.Caption := Qr_DadosProfissionais.FieldByName('FCP_PROFISSAO').AsString;
    E_Dp_Empregador.Caption := Qr_DadosProfissionais.FieldByName('EMP_NOME').AsString;
    E_Dp_VL_Renda.Caption := FloatToStrF(Qr_DadosProfissionais.FieldByName('FCP_VL_RENDA').AsCurrency,ffFixed,10,2);
    E_Dp_Dt_Admissao.Caption := Qr_DadosProfissionais.FieldByName('FCP_DT_ADMISSAO').AsString;
    E_Dp_Nr_Beneficio.Caption := Qr_DadosProfissionais.FieldByName('FCP_NR_BENEFICIO').AsString;
    //Dados do Endereco
    It_Cd_Empregador := Qr_DadosProfissionais.FieldByName('FCP_CODEPG').AsInteger;
    Qr_Endereco.Active := False;
    Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empregador;
    Qr_Endereco.Active := True;
    E_Dp_Endereco.Caption := Qr_Endereco.FieldByName('END_ENDER').AsString;
    E_Dp_Nr_Endereco.Caption := Qr_Endereco.FieldByName('END_NUMERO').AsString;
    E_Dp_Bairro.Caption := COPY(Qr_Endereco.FieldByName('END_BAIRRO').AsString,1,25);
    E_Dp_Cidade.Caption := Qr_Endereco.FieldByName('CDD_DESCRICAO').AsString;
    E_Dp_Estado.Caption := Qr_Endereco.FieldByName('UFE_SIGLA').AsString;
    E_Dp_Fone.Caption := fc_MascaraFone( Qr_Endereco.FieldByName('END_FONE').AsString );
    E_Dp_Fax.Caption := fc_MascaraFone( Qr_Endereco.FieldByName('END_FAX').AsString );
    E_Dp_Cep.Caption := Qr_Endereco.FieldByName('END_CEP').AsString;
    E_Dp_Insc_Est_Empregador.Caption := Qr_DadosProfissionais.FieldByName('EMP_INSC_EST').AsString;
    E_Dp_CNPJ_Empregador.Caption := fc_MascaraCNPJ( Qr_DadosProfissionais.FieldByName('EMP_CNPJ').AsString);
    E_Dp_Dt_fundacao.Caption := Qr_DadosProfissionais.FieldByName('EMP_DT_FUNDA').AsString;
    E_Dp_Vl_Capital.Caption := FloatToStrF(Qr_DadosProfissionais.FieldByName('FCP_EPG_CAPITAL').AsFloat,ffFixed,10,2);
    E_Dp_SocioDesde.Caption := Qr_DadosProfissionais.FieldByName('FCP_EPG_DT_SOCIO').AsString;
    E_Dp_Natur_Jur.Caption := Qr_DadosProfissionais.FieldByName('FCP_EPG_NAT_JUR').AsString;
    E_Dp_Vl_Faturamento.Caption := FloatToStrF(Qr_DadosProfissionais.FieldByName('FCP_EPG_FATURAMENTO').AsFloat,ffFixed,10,2);
    E_Dp_VL_Outros.Caption := FloatToStrF(Qr_DadosProfissionais.FieldByName('FCP_VL_OUTROS').AsCurrency,ffFixed,10,2);
    E_Dp_Valor.Caption := FloatToStrF(Qr_DadosProfissionais.FieldByName('FCP_VALOR').AsCurrency,ffFixed,10,2);
    end
  else
    Begin
    DadosProfissionais.Size.Height := 0;
    end;

  //Dados do Contador
  IF (Trim(Qr_DadosProfissionais.FieldByName('FCP_CTDR_NOME').AsString)<> '') THEN
    Begin
    E_Dp_Ctdr_Nome.Caption := Qr_DadosProfissionais.FieldByName('FCP_CTDR_NOME').AsString;
    E_Dp_Ctdr_Fone.Caption := fc_MascaraFone(Qr_DadosProfissionais.FieldByName('FCP_CTDR_FONE').AsString);
    E_Dp_Ctdr_Fax.Caption := fc_MascaraFone(Qr_DadosProfissionais.FieldByName('FCP_CTDR_FAX').AsString);
    E_Dp_Ctdr_Celular.Caption := fc_MascaraFone(Qr_DadosProfissionais.FieldByName('FCP_CTDR_CELULAR').AsString);
    end
  else
    Begin
    DadosContador.Size.Height := 0;
    end;
end;

//Aba Conjuge
procedure TRL_Ficha_Cadastro.Pc_MostraDadosConjuge;
Begin
  Qr_DadosConjuge.Active := False;
  Qr_DadosConjuge.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Conjuge;
  Qr_DadosConjuge.Active := true;
  Qr_DadosConjuge.FetchAll;
  Qr_DadosConjuge.First;
  if Qr_DadosConjuge.RecordCount >0 then
    Begin
    DadosConjuge.PrintCount := Qr_DadosConjuge.RecordCount;
    E_Cg_Nome.Caption := Qr_DadosConjuge.FieldByName('EMP_NOME').AsString;
    E_Cg_CPF.Caption :=  fc_MascaraCPF(Qr_DadosConjuge.FieldByName('EMP_CNPJ').AsString);
    E_Cg_Rg.Caption := Qr_DadosConjuge.FieldByName('EMP_INSC_EST').AsString;
    if Trim(Qr_DadosConjuge.FieldByName('EMP_DT_FUNDA').AsString)<> '' then
      E_Cg_Dt_Nascimento.Caption := Qr_DadosConjuge.FieldByName('EMP_DT_FUNDA').AsString
    else
      E_Cg_Dt_Nascimento.Caption := DateTostr(Date);
    E_Cg_Profissao.Caption := Qr_DadosConjuge.FieldByName('FCP_PROFISSAO').AsString;
    E_Cg_Vl_Renda.Caption := FloatToStrF(Qr_DadosConjuge.FieldByName('FCP_VL_RENDA').AsCurrency,ffFixed,10,2);
    E_Cg_Org_Emissao.Caption := Qr_DadosConjuge.FieldByName('PFS_RG_ORG_EMISSAO').AsString;
    //Dados do empregador
    It_Cd_Empregador_Cg := Qr_DadosConjuge.FieldByName('FCP_CODEPG').AsInteger;
    E_Cg_Empregador.Caption := Qr_DadosConjuge.FieldByName('EPR_NOME').AsString;
    //dados do Endereco
    Qr_Endereco.Active := False;
    Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empregador_Cg;
    Qr_Endereco.Active := True;
    E_Cg_Endereco.Caption := Qr_Endereco.FieldByName('END_ENDER').AsString;
    E_Cg_Nr_Endereco.Caption := Qr_Endereco.FieldByName('END_NUMERO').AsString;
    E_Cg_Bairro.Caption := COPY(Qr_Endereco.FieldByName('END_BAIRRO').AsString,1,25);
    E_Cg_Cep.Caption := Qr_Endereco.FieldByName('END_CEP').AsString;
    E_Cg_Cidade.Caption := Qr_Endereco.FieldByName('CDD_DESCRICAO').AsString;
    E_Cg_Correspondencia.Caption := Qr_DadosConjuge.FieldByName('PFS_CORRESPONDENCIA').AsString;
    E_Cg_Fone.Caption := fc_MascaraFone(Qr_Endereco.FieldByName('END_FONE').AsString);
    E_Cg_Celular.Caption := fc_MascaraFone(Qr_Endereco.FieldByName('END_CELULAR').AsString);
    E_cg_Email.Caption := Qr_DadosConjuge.FieldByName('EMP_EMAIL').AsString;
    end
  else
    Begin
    DadosConjuge.Size.Height := 0;
    end;
end;

//Aba Dependentes
procedure TRL_Ficha_Cadastro.Pc_MostraDadosDependentes;
Begin
  //Dados dos dependentes
  Qr_Dependentes.Active := False;
  Qr_Dependentes.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empresa;
  Qr_Dependentes.Active := true;
  Qr_Dependentes.FetchAll;
  Qr_Dependentes.First;
  if Qr_Dependentes.RecordCount >0 then
    Begin
    Dependentes.PrintCount := Qr_Dependentes.RecordCount;
    end
  else
    Begin
    Cab_Dependentes.Size.Height := 0;
    Dependentes.Size.Height := 0;
    end;
end;

//Aba Dados Avalista
procedure TRL_Ficha_Cadastro.Pc_MostraDadosAvalista;
Begin
  Qr_DadosAvalista.Active := False;
  Qr_DadosAvalista.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Avalista;
  Qr_DadosAvalista.Active := true;
  Qr_DadosAvalista.FetchAll;
  Qr_DadosAvalista.First;
  if Qr_DadosAvalista.RecordCount >0 then
    Begin
    DadosAvalista.PrintCount := Qr_DadosAvalista.RecordCount;
    E_Da_Nome.Caption := Qr_DadosAvalista.FieldByName('EMP_NOME').AsString;
    E_Da_CPF.Caption :=  fc_MascaraCPF(Qr_DadosAvalista.FieldByName('EMP_CNPJ').AsString);
    E_Da_Rg.Caption := Qr_DadosAvalista.FieldByName('EMP_INSC_EST').AsString;
    if Trim(Qr_DadosAvalista.FieldByName('EMP_DT_FUNDA').AsString)<> '' then
      E_Da_Dt_Nascimento.Caption := Qr_DadosAvalista.FieldByName('EMP_DT_FUNDA').AsString
    else
      E_Da_Dt_Nascimento.Caption := DateToStr(Date);
    E_Da_Profissao.Caption := Qr_DadosAvalista.FieldByName('FCP_PROFISSAO').AsString;
    E_Da_Vl_Renda.Caption := FloatToStrF(Qr_DadosAvalista.FieldByName('FCP_VL_RENDA').AsCurrency,ffFixed,10,2);
    E_Da_Org_Emissao.Caption := Qr_DadosAvalista.FieldByName('PFS_RG_ORG_EMISSAO').AsString;
    It_Cd_Empregador_Da := Qr_DadosAvalista.FieldByName('FCP_CODEPG').AsInteger;
    E_Da_Empregador.Caption := Qr_DadosAvalista.FieldByName('EPR_NOME').AsString;
    //dados do Endereco
    Qr_Endereco.Active := False;
    Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empregador_Da;
    Qr_Endereco.Active := True;
    E_Da_Endereco.Caption := Qr_Endereco.FieldByName('END_ENDER').AsString;
    E_Da_Nr_Endereco.Caption := Qr_Endereco.FieldByName('END_NUMERO').AsString;
    E_Da_Bairro.Caption := COPY(Qr_Endereco.FieldByName('END_BAIRRO').AsString,1,25);
    E_Da_Cep.Caption := Qr_Endereco.FieldByName('END_CEP').AsString;
    E_Da_Cidade.Caption := Qr_Endereco.FieldByName('CDD_DESCRICAO').AsString;
    E_Da_Correspondencia.Caption := Qr_DadosAvalista.FieldByName('PFS_CORRESPONDENCIA').AsString;
    E_Da_Fone.Caption := fc_MascaraFone(Qr_Endereco.FieldByName('END_FONE').AsString);
    E_Da_Celular.Caption := fc_MascaraFone(Qr_Endereco.FieldByName('END_CELULAR').AsString);
    E_Da_Email.Caption := Qr_DadosAvalista.FieldByName('EMP_EMAIL').AsString;
    end
  else
    Begin
    DadosAvalista.Size.Height := 0;
    end;
end;

//Aba Referencia Bancaria
procedure TRL_Ficha_Cadastro.Pc_MostraDadosReferenciaBancaria;
Begin
  Qr_Ref_Bancaria.Active := False;
  Qr_Ref_Bancaria.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empresa;
  Qr_Ref_Bancaria.Active := true;
  Qr_Ref_Bancaria.FetchAll;
  Qr_Ref_Bancaria.First;
  if Qr_Ref_Bancaria.RecordCount >0 then
    Begin
    ReferenciaBancaria.PrintCount := Qr_Ref_Bancaria.RecordCount;
    end
  else
    Begin
    Cab_ReferenciaBancaria.Size.Height := 0;
    ReferenciaBancaria.Size.Height := 0;
    end;
end;

//Aba Referencia Pessoal
procedure TRL_Ficha_Cadastro.Pc_MostraDadosReferenciaPessoal;
Begin
  Qr_Ref_Pessoal.Active := False;
  Qr_Ref_Pessoal.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empresa;
  Qr_Ref_Pessoal.Active := true;
  Qr_Ref_Pessoal.FetchAll;
  Qr_Ref_Pessoal.First;
  if Qr_Ref_Pessoal.RecordCount >0 then
    Begin
    ReferenciaPessoal.PrintCount := Qr_Ref_Pessoal.RecordCount;
    end
  else
    Begin
    Cab_ReferenciaPessoal.Size.Height := 0;
    ReferenciaPessoal.Size.Height := 0;
    end;
end;

//Aba Referencia comecial
procedure TRL_Ficha_Cadastro.Pc_MostraDadosReferenciaComercial;
Begin
  Qr_Ref_Comercial.Active := False;
  Qr_Ref_Comercial.ParamByName('EMP_CODIGO').AsInteger := It_Cd_Empresa;
  Qr_Ref_Comercial.Active := true;
  Qr_Ref_Comercial.FetchAll;
  Qr_Ref_Comercial.First;
  if Qr_Ref_Comercial.RecordCount >0 then
    Begin
    ReferenciaComercial.PrintCount := Qr_Ref_Comercial.RecordCount;
    end
  else
    Begin
    Cab_ReferenciaComercial.Size.Height := 0;
    ReferenciaComercial.Size.Height := 0;
    end;
end;

//Aba Bem em Garantia
procedure TRL_Ficha_Cadastro.Pc_MostraDadosBemGarantia;
Begin
  Qr_BemGarantia.Active := False;
  Qr_BemGarantia.ParamByName('FCT_CODIGO').AsInteger := It_cd_ficha;
  Qr_BemGarantia.Active := true;
  Qr_BemGarantia.FetchAll;
  Qr_BemGarantia.First;
  if Qr_BemGarantia.RecordCount >0 then
    Begin
    BemGarantia.PrintCount := Qr_BemGarantia.RecordCount;
    end
  else
    Begin
    Cab_BemGarantia.Size.Height := 0;
    BemGarantia.Size.Height := 0;
    end;
end;

//Aba Formas de pagamentos
procedure TRL_Ficha_Cadastro.Pc_MostraFormasPagamento;
Var
  Lc_Stream : TStream;
Begin
  Lc_Stream := Qr_DadosGerais.CreateBlobStream(Qr_DadosGerais.FieldByName('FCT_OBS'),bmRead);
  E_Fp_Obs.Lines.LoadFromStream(Lc_Stream);
  FreeAndNil(Lc_Stream);
end;

procedure TRL_Ficha_Cadastro.QrptNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  Pc_Cabecalho;
  Pc_MostraDadosGerais;
  //Aba dados Profissionais
  Pc_MostraDadosProfissionais;
  //Aba Conjuge
  Pc_MostraDadosConjuge;
  //Aba Dependentes
  Pc_MostraDadosDependentes;
  //Aba Dados Avalista
  Pc_MostraDadosAvalista;
  //Aba Referencia Bancaria
  Pc_MostraDadosReferenciaBancaria;
  //Aba Referencia Pessoal
  Pc_MostraDadosReferenciaPessoal;
  //Aba Referencia comecial
  Pc_MostraDadosReferenciaComercial;
  //Aba Bem em Garantia
  Pc_MostraDadosBemGarantia;
  //Aba Formas de pagamentos
  Pc_MostraFormasPagamento;
end;

procedure TRL_Ficha_Cadastro.DependentesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_Dpt_Nome.Caption := Qr_Dependentes.FieldByName('DPT_NOME').AsString;
  E_Dpt_Parentesco.Caption := Qr_Dependentes.FieldByName('DPT_PARENTESCO').AsString;
  Qr_Dependentes.Next;
end;

procedure TRL_Ficha_Cadastro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action := CaFree;
  RL_Ficha_Cadastro := nil;
end;

procedure TRL_Ficha_Cadastro.ReferenciaBancariaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  E_Rb_Banco.Caption := Qr_Ref_Bancaria.FieldByName('RFB_BANCO').AsString;
  E_Rb_Agencia.Caption := Qr_Ref_Bancaria.FieldByName('RFB_AGENCIA').AsString;
  E_Rb_Conta.Caption := Qr_Ref_Bancaria.FieldByName('RFB_CONTA').AsString;
  E_Rb_Dt_Abertura.Caption := Qr_Ref_Bancaria.FieldByName('RFB_DT_ABERTURA').AsString;

  case StrToIntDef(Qr_Ref_Bancaria.FieldByName('RFB_DT_ABERTURA').AsString,0) of
    0:E_Rb_Tp_conta.Caption := 'Comum';
    1:E_Rb_Tp_conta.Caption := 'Especial';
  end;
  E_Rb_Cheque.Caption := Qr_Ref_Bancaria.FieldByName('RFB_NR_CHEQUE').AsString;
  Qr_Ref_Bancaria.Next;
end;

procedure TRL_Ficha_Cadastro.ReferenciaPessoalBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  E_Rp_Nome.Caption := Qr_Ref_Pessoal.FieldByName('RFP_NOME').AsString;
  E_Rp_Afinidade.Caption := Qr_Ref_Pessoal.FieldByName('RFP_AFINIDADE').AsString;
  E_Rp_Fone.Caption := fc_MascaraFone( Qr_Ref_Pessoal.FieldByName('RFP_FONE').AsString );
  E_Rp_Cidade.Caption := Qr_Ref_Pessoal.FieldByName('CDD_DESCRICAO').AsString;
  Qr_Ref_Pessoal.Next;
end;

procedure TRL_Ficha_Cadastro.ReferenciaComercialBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  E_Rc_Nome.Caption := Qr_Ref_Comercial.FieldByName('RFC_NOME').AsString;
  E_Rc_Fone.Caption := fc_MascaraFone( Qr_Ref_Comercial.FieldByName('RFC_FONE').AsString );
  E_Rc_Fax.Caption := fc_MascaraFone( Qr_Ref_Comercial.FieldByName('RFC_FAX').AsString );
  E_Rc_Celular.Caption := fc_MascaraFone( Qr_Ref_Comercial.FieldByName('RFC_CELULAR').AsString );
  E_Rc_ClienteDesde.Caption := Qr_Ref_Comercial.FieldByName('RFC_DT_DESDE').AsString;
  Qr_Ref_Comercial.Next;
end;

procedure TRL_Ficha_Cadastro.BemGarantiaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_Bg_Descricao.Caption := Qr_BemGarantia.FieldByName('FBG_DESCRICAO').AsString;
  E_Bg_Valor.Caption := FloatToStrF(Qr_BemGarantia.FieldByName('FBG_VALOR').AsCurrency,ffFixed,10,2);
  E_Bg_Documento.Caption := Qr_BemGarantia.FieldByName('FBG_TP_DOC').AsString;
  E_Bg_Referencia.Caption := Qr_BemGarantia.FieldByName('FBG_REFERENCIA').AsString;
  Qr_BemGarantia.Next;
end;

procedure TRL_Ficha_Cadastro.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
end;

end.
