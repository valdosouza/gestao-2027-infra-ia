unit Un_Pesq_Empresa;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Un_Fm_ListaColaboradores, Vcl.ComCtrls, QEdit_Setes, STDatabase, STTransaction;

type
  TFr_Pesq_Empresa = class(TForm)
    GroupBox1: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label33: TLabel;
    Label42: TLabel;
    E_BuscaRazao: TMaskEdit;
    E_BuscaFantasia: TMaskEdit;
    E_BuscaObs: TMaskEdit;
    ChBx_Fisica: TCheckBox;
    ChBx_Juridica: TCheckBox;
    Chbx_MalaDireta: TCheckBox;
    ChBx_Inativos: TCheckBox;
    Rg_Busca_Lojista: TRadioGroup;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Panel4: TPanel;
    Lb_ResultadoPesquisa: TLabel;
    SB_Cadastrar: TSpeedButton;
    SB_Buscar: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    Sb_Sair_1: TSpeedButton;
    DBG_Pesquisa: TDBGrid;
    Label55: TLabel;
    E_BuscaCodigo: TEdit_Setes;
    Label21: TLabel;
    Label49: TLabel;
    E_BuscaBairro: TMaskEdit;
    E_BuscaRegiao: TMaskEdit;
    E_BuscaEstado: TMaskEdit;
    E_BuscaCidade: TMaskEdit;
    Label23: TLabel;
    Label47: TLabel;
    E_BuscaFone: TEdit_Setes;
    Label1: TLabel;
    E_BuscaEmail: TMaskEdit;
    Ds_Pesquisa: TDataSource;
    Qr_Pesquisa: TSTQuery;
    IBT_Principal: TSTTransaction;
    Label3: TLabel;
    E_BuscaRAmoAtividade: TMaskEdit;
    Fm_ListaVendedores: TFm_ListaColaboradores;
    chbx_Bloqueado: TCheckBox;
    Panel1: TPanel;
    Label2: TLabel;
    E_BuscaLogradouro: TMaskEdit;
    E_BuscaCNPJ: TMaskEdit;
    procedure SB_BuscarClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure DBG_PesquisaTitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure Sb_Sair_1Click(Sender: TObject);
    procedure SB_CadastrarClick(Sender: TObject);
    procedure DBG_PesquisaDblClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
    It_Cd_Empresa,It_Cnpj,It_Razao,
    It_Fantasia,It_Logradouro,It_Bairro,It_Regiao,
    It_Estado,It_Cidade,It_email,
    It_Vendedor,It_Fone, It_Obs,
    It_RamoAtividade:Boolean;
    FTipoEmpresa: Integer;
    procedure Pc_PermissaoBotao;

    procedure Pc_AbreTelaEstabelecimento(Pc_Cd_Empresa:Integer);
    procedure Pc_AbreTelaEmpresa(Pc_Cd_Empresa:Integer);
    procedure Pc_AbreTelaBanco(Pc_Cd_Empresa:Integer);
    procedure Pc_AbreTelaProspeccaoCliente(Pc_Cd_Empresa:Integer);
    procedure Pc_AbreTelaContabilidade(Pc_Cd_Empresa:Integer);

    procedure Pc_IniciaVariaveis;
    procedure Pc_FormataTela;
    procedure Pc_AtivarTabelas;
    procedure Pc_ImagemBotao;
    procedure Pc_VerificaParametros;
    function Fc_IncrementarSql:String;
    procedure Pc_PassagemParametros;
    procedure Pc_FeaturesPesquisa;
    procedure Pc_Buscar;
    procedure Pc_Visualizar;
    procedure setFTipoEmpresa(const Value: Integer);

  public
    property TipoEmpresa : Integer read FTipoEmpresa write setFTipoEmpresa;
  end;

var
  Fr_Pesq_Empresa: TFr_Pesq_Empresa;

implementation

uses     UN_Sistema, Un_DM, Un_Cliente, UN_Principal, env, Un_Transportadora, Un_Fornecedor, Un_Funcoes, reg_customer_prospection, Un_Bancos, UN_MSG, Un_MinhaEmpresa, Un_Empresa, Un_Contabilidade, UN_TabelasEmListas, RN_Fornecedor, RN_Cliente, RN_Transportadora, Un_Regra_Negocio;
{$R *.dfm}
procedure TFr_Pesq_Empresa.Pc_IniciaVariaveis;
Begin
  E_Data_Ini.DateTime := Date;
  E_Data_Fim.DateTime := Date;

  Fm_ListaVendedores.Dblcb_Vendedor.KeyValue := Null;
  Fm_ListaVendedores.Dblcb_Vendedor.Enabled := True;
  if (Fc_Tb_Geral('L','GRL_G_VEND_LIST_CLIENTE','S') = 'S') then
  Begin
    if (GB_Cd_Vendedor > 0) and (Gb_Nivel = 0)  then
    Begin
      Fm_ListaVendedores.Dblcb_Vendedor.KeyValue := GB_Cd_Vendedor;
      Fm_ListaVendedores.Dblcb_Vendedor.Enabled := False;
    End;
  End;
end;

procedure TFr_Pesq_Empresa.Pc_FormataTela;
Begin
  Rg_Busca_Lojista.Visible := False;
  case FTipoEmpresa of
    -1:Begin
        Caption := 'Pesquisar Empresas';
      end;
    0:Begin
        Caption := 'Pesquisar Estabelecimento / Minha Empresa';
      end;
    1:Begin
        Caption := 'Pesquisar Clientes';
        Rg_Busca_Lojista.Visible := True;
      end;
    2:Begin
        Caption := 'Pesquisar Fornecedores';
      end;
    3:Begin
        Caption := 'Pesquisar Transportadoras';
      end;
    4:Begin
        Caption := 'Pesquisar Bancos';
      end;
    8:Begin
        Caption := 'Pesquisar Clientes em Prospecção';
        Rg_Busca_Lojista.Visible := FAlse;
      end;
    9:Begin
        Caption := 'Pesquisa Contabilidades';
        Rg_Busca_Lojista.Visible := FAlse;
      end;
  end;
end;

procedure TFr_Pesq_Empresa.Pc_AtivarTabelas;
Begin
  Fm_ListaVendedores.ListaVendedor;
end;

procedure TFr_Pesq_Empresa.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    CarregaImagemBotao(SB_Cadastrar,'CADASTRAR');
    CarregaImagemBotao(SB_Buscar, 'BUSCAR');
    CarregaImagemBotao(SB_Visualizar,'VISUALIZAR');
    CarregaImagemBotao(Sb_Sair_1,'SAIR');
  END;
end;

Procedure TFr_Pesq_Empresa.Pc_VerificaParametros;
Begin
  if Trim(E_BuscaCodigo.Text)   = '' then It_Cd_Empresa := False else It_Cd_Empresa := True;
  if Trim(E_BuscaCNPJ.Text)     = '' then It_Cnpj       := False else It_Cnpj       := True;
  if Trim(E_BuscaRazao.Text)    = '' then It_Razao      := False else It_Razao      := True;
  if Trim(E_BuscaFantasia.Text) = '' then It_Fantasia   := False else It_Fantasia   := True;
  if Trim(E_BuscaLogradouro.Text)   = '' then It_Logradouro  := False else It_Logradouro := True;
  if Trim(E_BuscaBairro.Text)   = '' then It_Bairro     := False else It_Bairro     := True;
  if Trim(E_BuscaRegiao.Text)   = '' then It_Regiao     := False else It_Regiao     := True;
  if Trim(E_BuscaEstado.Text)   = '' then It_Estado     := False else It_Estado     := True;
  if Trim(E_BuscaCidade.Text)   = '' then It_Cidade     := False else It_Cidade     := True;
  if Trim(E_BuscaEmail.Text)    = '' then It_email      := False else It_email      := True;
  if Trim(Fm_ListaVendedores.Dblcb_Vendedor.Text) = '' then It_Vendedor := False else It_Vendedor := True;
  IF Trim(E_BuscaFone.Text)     = '' then It_Fone       := False else It_Fone       := True;
  IF Trim(E_BuscaObs.Text)      = '' then It_Obs        := False else It_Obs        := True;
  IF Trim(E_BuscaRAmoAtividade.Text) = '' then It_RamoAtividade := False else It_RamoAtividade := True;
end;

function TFr_Pesq_Empresa.Fc_IncrementarSql:String;
Begin
  Result := '';
  case FTipoEmpresa of
    0:Result := Result + ' AND EMP_TIPO =0 ';
    4:Result := Result + ' AND EMP_TIPO =4 ';
    8:Result := Result + ' AND EMP_TIPO =-1 ';
  end;


  if It_Cd_Empresa then
    Result := Result + ' AND EMP_CODIGO =:EMP_CODIGO ';
  if It_CNPJ then
  Begin
    if (Length(E_BuscaCNPJ.Text) >= 14) then
      Result := Result + ' AND EMP_CNPJ =:EMP_CNPJ '
    else
      Result := Result + ' AND EMP_CNPJ LIKE :EMP_CNPJ ';
  end;
  if It_Razao then
    Result := Result + ' AND EMP_NOME LIKE :EMP_NOME ';
  if It_Fantasia then
    Result := Result + ' AND EMP_FANTASIA LIKE :EMP_FANTASIA ';
  if It_Logradouro then
    Result := Result + ' AND END_ENDER LIKE :END_ENDER ';

  if It_Bairro then
    Result := Result + ' AND END_BAIRRO LIKE :END_BAIRRO ';
  if It_Regiao then
    Result := Result + ' AND END_REGIAO LIKE :END_REGIAO ';
  if It_Estado then
    Result := Result + ' AND UFE_SIGLA =:UFE_SIGLA ';
  if It_Cidade then
    Result := Result + ' AND CDD_DESCRICAO LIKE :CDD_DESCRICAO ';
  if It_email then
    Result := Result + ' AND EMP_EMAIL LIKE :EMP_EMAIL ';
  if It_Vendedor then
    Result := Result + ' AND EMP_CODVDOR =:EMP_CODVDOR ';
  if It_Fone then
  Begin
    Result := concat(
                  Result ,
                  ' AND ( ',
                  '  (END_FONE LIKE :END_FONE) OR ',
                  '  (END_FAX LIKE :END_FONE) OR ',
                  '  (END_CELULAR LIKE :END_FONE) OR ',
                  '  (END_COMERCIAL LIKE :END_FONE) OR ',
                  '  (END_PORTARIA LIKE :END_FONE) ',
                  ') '
              );

  End;
  if It_Obs then
    Result := Result + ' AND (EMP_OBSERV LIKE :EMP_OBSERV) ';
  if ChBx_Fisica.Checked     then Result := Result + ' AND (EMP_PESSOA = ''F'') ';
  if ChBx_Juridica.Checked   then Result := Result + ' AND (EMP_PESSOA = ''J'') ';
  if Chbx_MalaDireta.Checked then Result := Result + ' AND (EMP_ML_DRT = '''+NAO+''') ';
  if chbx_Bloqueado.Checked  then Result := Result + ' and (EMP_STCRED <> ''L'' ) ';

    case FTipoEmpresa of
      1:Begin
          if ChBx_Inativos.Checked   then
            Result := Result + ' AND (CLI_ATIVO =''N'') '
          else
            Result := Result + ' AND (CLI_ATIVO =''S'') ';
        end;
      2:Begin
          if ChBx_Inativos.Checked   then
            Result := Result + ' AND (FOR_ATIVO =''N'') '
          else
            Result := Result + ' AND (FOR_ATIVO =''S'') ';
        end;
      3:Begin
          if ChBx_Inativos.Checked   then
            Result := Result + ' AND (TRP_ATIVO =''N'') '
          else
            Result := Result + ' AND (TRP_ATIVO =''S'') ';
        end;
      9:Begin
          if ChBx_Inativos.Checked   then
            Result := Result + ' AND (CON_ATIVO =''N'') '
          else
            Result := Result + ' AND (CON_ATIVO =''S'') ';
        end;
      else
      Begin
        if ChBx_Inativos.Checked   then
          Result := Result + ' AND (EMP_ATIVA =''N'') '
        else
          Result := Result + ' AND (EMP_ATIVA =''S'') ';
      End;
    end;



  if ChBx_Periodo.Checked then
    Result := Result + ' AND (EMP_DT_CADASTRO BETWEEN :DATAINI AND :DATAFIM) ';

  case Rg_Busca_Lojista.ItemIndex of
    0:Result := Result + ' AND (EMP_LOJISTA =''S'') ';
    1:Result := Result + ' AND (EMP_LOJISTA =''N'') ';
    2:Result := Result + ' AND (EMP_LOJISTA =''A'') ';
  end;

  if It_RamoAtividade then
    Result := Result + 'AND (tb_ramo_atividade.description like :ramoatividade) ';
end;

procedure TFr_Pesq_Empresa.Pc_PassagemParametros;
Begin
  with Qr_Pesquisa do
  Begin
    if ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    end;
    if It_Cd_Empresa then
      ParamByName('EMP_CODIGO').AsInteger := StrToIntDef( E_BuscaCodigo.Text,0 );
    if It_CNPJ then
    Begin
      if (Length(E_BuscaCNPJ.Text)>=14) then
        ParamByName('EMP_CNPJ').AsString := E_BuscaCNPJ.Text
      else
        ParamByName('EMP_CNPJ').AsString := E_BuscaCNPJ.Text + '%';
    end;
    if It_Razao then
      ParamByName('EMP_NOME').AsString := '%' + Copy(E_BuscaRazao.Text,1,98) + '%';
    if It_Fantasia then
      ParamByName('EMP_FANTASIA').AsString := '%' + Copy(E_BuscaFantasia.Text,1,98) + '%';
    if It_Logradouro then
      ParamByName('END_ENDER').AsString := '%' + E_BuscaLogradouro.Text + '%';

    if It_Bairro then
      ParamByName('END_BAIRRO').AsString := '%' + E_BuscaBairro.Text + '%';

    if It_Regiao then
      ParamByName('END_REGIAO').AsString := '%' + E_BuscaRegiao.Text + '%';
    if It_Estado then
      ParamByName('UFE_SIGLA').AsString := E_BuscaEstado.Text;
    if It_Cidade then
      ParamByName('CDD_DESCRICAO').AsString := '%' + E_BuscaCidade.Text + '%';
    if It_email then
      ParamByName('EMP_EMAIL').AsString := '%' + E_BuscaEmail.Text + '%';
    if It_Vendedor then
      ParamByName('EMP_CODVDOR').AsInteger := Fm_ListaVendedores.Dblcb_Vendedor.KeyValue;
    if It_Fone then
      ParamByName('END_FONE').AsString := '%' + Fc_RemoveCaracterInformado(E_BuscaFone.Text, ['(',')',' ','-','-']);
    if It_Obs then
      ParamByName('EMP_OBSERV').AsString := '%' + E_BuscaObs.Text + '%';
  if It_RamoAtividade then
    ParamByName('ramoatividade').AsString := '%' + E_BuscaRAmoAtividade.Text + '%';
  end;
end;

procedure TFr_Pesq_Empresa.Pc_PermissaoBotao;
begin
  case FTipoEmpresa of
    -1:SB_Cadastrar.Enabled := Fc_HabilitaPermissao('Empresa','INSERIR','S');
    0:SB_Cadastrar.Enabled := Fc_HabilitaPermissao('Minha Empresa','INSERIR','S');
    1:SB_Cadastrar.Enabled := Fc_HabilitaPermissao('Clientes','INSERIR','S');
    2:SB_Cadastrar.Enabled := Fc_HabilitaPermissao('Fornecedores','INSERIR','S');
    3:SB_Cadastrar.Enabled := Fc_HabilitaPermissao('Transportadora','INSERIR','S');
    4:SB_Cadastrar.Enabled := Fc_HabilitaPermissao('Bancos','INSERIR','S');
    8:SB_Cadastrar.Enabled := Fc_HabilitaPermissao('Clientes','INSERIR','S');
    9:SB_Cadastrar.Enabled := Fc_HabilitaPermissao('Contabilidade','INSERIR','S');
  end;
end;

procedure TFr_Pesq_Empresa.Pc_FeaturesPesquisa;
Begin
  if It_Fantasia then
  begin
    DBG_Pesquisa.Columns.Items[1].Title.Caption := 'Nome Fantasia/Apelido/Codnome';
    DBG_Pesquisa.Columns.Items[1].FieldName := 'EMP_FANTASIA'
  end
  else
  begin
    DBG_Pesquisa.Columns.Items[1].Title.Caption := 'Nome/Razão Social';
    DBG_Pesquisa.Columns.Items[1].FieldName := 'EMP_NOME';
  end;
end;

procedure TFr_Pesq_Empresa.PC_Buscar;
var
   Lc_Sqltxt: string;
begin
  with Qr_Pesquisa do
  Begin
    Screen.Cursor := crHourGlass;
    Pc_VerificaParametros;
    Lc_Sqltxt := '';
    Close;
    Sql.Clear;
    Lc_Sqltxt :=  'SELECT DISTINCT EMP_CODIGO, EMP_NOME, EMP_FANTASIA, EMP_CNPJ, EMP_EMAIL,EMP_TIPO ';

    if It_Vendedor then
      Lc_Sqltxt :=  Lc_Sqltxt + ', CLB_NOME ';

    Lc_Sqltxt :=  Lc_Sqltxt +
                  'FROM TB_EMPRESA ';

    case FTipoEmpresa of
      -10:Begin
            //Todas as empresas
          end;
      0:Begin
           //Estabelecimeto minha empresa
        end;
      1:Begin
          Lc_Sqltxt :=  Lc_Sqltxt + '  INNER JOIN TB_CLIENTE '+
                                    '  ON (CLI_CODEMP = EMP_CODIGO) ';

        end;
      2:Begin
          Lc_Sqltxt :=  Lc_Sqltxt + '  INNER JOIN TB_FORNECEDOR '+
                                    '  ON (FOR_CODEMP = EMP_CODIGO) ';
        end;
      3:Begin
          Lc_Sqltxt :=  Lc_Sqltxt + '  INNER JOIN TB_TRANSPORTADORA '+
                                    '  ON (TRP_CODEMP = EMP_CODIGO) ';
        end;
      4:Begin
        //Banco por enquanton não precisa Inner
        end;
      5:Begin
        //Não definido
        end;
      6:Begin
        //Não definido
        end;
      7:Begin
        //Não definido
        end;
      8:Begin
        //Cliente em prospeção não precisa inner
        end;
      9:Begin
          Lc_Sqltxt :=  Lc_Sqltxt + '  INNER JOIN TB_CONTADOR '+
                                    '  ON (CON_CODEMP = EMP_CODIGO) ';
        end;
    end;

    if (It_Logradouro or It_Bairro or It_Regiao or It_Fone) and (not (It_Estado or It_Cidade) )   then
    Begin
      Lc_Sqltxt :=  Lc_Sqltxt +
                   '  INNER JOIN TB_ENDERECO '+
                   '  ON (END_CODEMP = EMP_CODIGO) ';
    end
    else
    Begin
      if (It_Estado or It_Cidade) then
        Lc_Sqltxt :=  Lc_Sqltxt +
                     '  INNER JOIN TB_ENDERECO '+
                     '  ON (END_CODEMP = EMP_CODIGO) '+
                     '  INNER JOIN TB_UF '+
                     '  ON (UFE_CODIGO = END_CODUFE) '+
                     '  INNER JOIN TB_CIDADE '+
                     '  ON (CDD_CODIGO = END_CODCDD)';
    end;

    if It_Vendedor then
      Lc_Sqltxt :=  Lc_Sqltxt +
                  '  INNER JOIN TB_COLABORADOR '+
                  '  ON (CLB_CODIGO = EMP_CODVDOR) ';

    if It_RamoAtividade then
          Lc_Sqltxt :=  Lc_Sqltxt +
                  '  INNER JOIN TB_RAMO_ATIVIDADE '+
                  '  ON (TB_RAMO_ATIVIDADE.ID = TB_EMPRESA.TB_RAMO_ATIVIDADE_ID) ';

    Lc_Sqltxt :=  Lc_Sqltxt  + ' WHERE (EMP_CODIGO IS NOT NULL) ';

    Lc_Sqltxt := Lc_Sqltxt + Fc_IncrementarSql;
    SQL.Add(Lc_Sqltxt + ' ORDER BY EMP_NOME');
    Pc_PassagemParametros;
    Pc_FeaturesPesquisa;
    Active := True;
    FetchAll;
    Lb_ResultadoPesquisa.Caption := 'Resultado da pesquisa : ' + IntTostr(recordCount) + ' registro(s)';
    Screen.Cursor := crDefault;
  end;
end;

procedure TFr_Pesq_Empresa.Pc_Visualizar;
begin
  with Qr_Pesquisa do
  BEgin
    if RecordCount > 0 then
    BEgin
      case FTipoEmpresa of
        -1:Pc_AbreTelaEmpresa(FieldByName('EMP_CODIGO').AsInteger);
        0:Pc_AbreTelaEstabelecimento(FieldByName('EMP_CODIGO').AsInteger);
        1:Fc_AbreTelaCliente(FieldByName('EMP_CODIGO').AsInteger);
        2:Fc_AbreTelaFornecedor(FieldByName('EMP_CODIGO').AsInteger);
        3:Fc_AbreTelaTransportadora(FieldByName('EMP_CODIGO').AsInteger);
        4:Pc_AbreTelaBanco(FieldByName('EMP_CODIGO').AsInteger);
        8:Pc_AbreTelaProspeccaoCliente(FieldByName('EMP_CODIGO').AsInteger);
        9:Pc_AbreTelaContabilidade(FieldByName('EMP_CODIGO').AsInteger);
      end;
    end;
  end;
end;

procedure TFr_Pesq_Empresa.SB_BuscarClick(Sender: TObject);
begin
  TRY
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    PC_Buscar;
  Finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := true;
  end;
end;

procedure TFr_Pesq_Empresa.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Pesq_Empresa.DBG_PesquisaTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(DBG_Pesquisa, Column);
end;

procedure TFr_Pesq_Empresa.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_PermissaoBotao;
  Pc_IniciaVariaveis;
  Pc_AtivarTabelas;
  Pc_ImagemBotao;
end;

procedure TFr_Pesq_Empresa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFr_Pesq_Empresa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F2: if SB_Cadastrar.Enabled  then SB_CadastrarClick(Sender);
      VK_F7: if SB_Buscar.Enabled     then SB_BuscarClick(Sender);
      VK_F8: if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
      VK_Escape: if Sb_Sair_1.Enabled then Sb_Sair_1Click(Sender);
    end;
  end;
end;

procedure TFr_Pesq_Empresa.SB_VisualizarClick(Sender: TObject);
beGIN
  Pc_Visualizar;
  Pc_AtivarTabelas;
end;

procedure TFr_Pesq_Empresa.setFTipoEmpresa(const Value: Integer);
begin
  FTipoEmpresa := Value;
end;

procedure TFr_Pesq_Empresa.Sb_Sair_1Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Pesq_Empresa.Pc_AbreTelaEmpresa(Pc_Cd_Empresa:Integer);
Var
  Lc_Form : TFr_Empresa;
begin
  Lc_Form := TFr_Empresa.Create(Self);
  Lc_Form.Empresa.Registro.Codigo := Pc_Cd_Empresa;
  Lc_Form.ShowModal;
  FreeAndNil(Lc_Form);
end;

procedure TFr_Pesq_Empresa.Pc_AbreTelaEstabelecimento(Pc_Cd_Empresa:Integer);
Var
  Lc_Form : TFr_MinhaEmpresa;
begin
  Lc_Form := TFr_MinhaEmpresa.Create(Self);
  Lc_Form.Empresa.Registro.Codigo := Pc_Cd_Empresa;
  Lc_Form.It_Menu := 'Minha Empresa';
  Lc_Form.ShowModal;
  FreeAndNil(Lc_Form);
end;


procedure TFr_Pesq_Empresa.Pc_AbreTelaBanco(Pc_Cd_Empresa:Integer);
Var
  Lc_Form : TFr_Bancos;
begin
  Lc_Form := TFr_Bancos.Create(Self);
  Lc_Form.It_Menu := 'Bancos';
  Lc_Form.Empresa.Registro.Codigo := Pc_Cd_Empresa;
  Lc_Form.ShowModal;
  FreeAndNil(Lc_Form);
end;

procedure TFr_Pesq_Empresa.Pc_AbreTelaProspeccaoCliente(Pc_Cd_Empresa:Integer);
Var
  Lc_Form : TRegCustomerProspection;
begin
  Lc_Form := TRegCustomerProspection.Create(Self);
  try
    Lc_Form.Empresa.Registro.Codigo := Pc_Cd_Empresa;
    Lc_Form.CodigoEmpresa :=
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Pesq_Empresa.Pc_AbreTelaContabilidade(Pc_Cd_Empresa:Integer);
Var
  Lc_Form : TFr_Contabilidade;
begin
  Try
    Lc_Form := TFr_Contabilidade.Create(Self);
    Lc_Form.Empresa.Registro.Codigo := Pc_Cd_Empresa;
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
  End;

end;

procedure TFr_Pesq_Empresa.SB_CadastrarClick(Sender: TObject);
Var
  Lc_Escolha:Integer;
begin
  case FTipoEmpresa of
    -1:Pc_AbreTelaEmpresa(0);
    0:Pc_AbreTelaEstabelecimento(0);
    1:Fc_AbreTelaCliente(0);
    2:Fc_AbreTelaFornecedor(0);
    3:Fc_AbreTelaTransportadora(0);
    4:Pc_AbreTelaBAnco(0);
    8:Pc_AbreTelaProspeccaoCliente(0);
    9:Pc_AbreTelaContabilidade(0);
    else
    Begin
      Lc_Escolha := MensagemPadrao(TITULO_CONFIRMACAO,
                                    'Qual o tipo cadastro deseja efetuar ?' + EOLN + EOLN +
                                    'Escolha uma das opções abaixo?',
                                     ['Cliente', 'Fornecedor','Cancelar'], [bNormal,bEscape], mpConfirmacao, clRed);
      case Lc_Escolha of
        1:Fc_AbreTelaCliente(0);
        2:fc_AbreTelaFornecedor(0);
      end;
    end;
  end;
end;

procedure TFr_Pesq_Empresa.DBGrid1TitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(DBG_Pesquisa, Column);
end;

procedure TFr_Pesq_Empresa.DBG_PesquisaDblClick(Sender: TObject);
begin
  pc_Visualizar;
end;

end.
