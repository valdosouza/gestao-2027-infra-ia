Unit Un_Veiculo;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls, Buttons, DBCtrls, Mask, ExtCtrls, Grids, DBGrids, DB, STQuery, QEdit_Setes, Un_Fm_ListaClientes, ControllerVehicle, Un_Fm_ListaEmpresas, Un_Fm_ListaEstados, base_frame_list;

type
  TFr_Veiculo = class(TForm)
    tbs_cadastro: TTabSheet;
    tbs_Pesquisa: TTabSheet;
    GroupBox3: TGroupBox;
    Dbg_Pesquisa: TDBGrid;
    SB_Buscar: TSpeedButton;
    Sb_Sair_1: TSpeedButton;
    Label12: TLabel;
    ME_BuscaFrota: TMaskEdit;
    Label13: TLabel;
    Label14: TLabel;
    Qr_Pesquisa: TSTQuery;
    ME_BuscaRazao: TMaskEdit;
    DS_Pesquisa: TDataSource;
    Ds_Cliente: TDataSource;
    Label11: TLabel;
    ME_Placa: TMaskEdit;
    Sb_Cadastrar: TSpeedButton;
    Sb_Visualizar: TSpeedButton;
    E_BuscaMarca: TMaskEdit;
    E_BuscaModelo: TMaskEdit;
    Ds_Tp_Veiculo: TDataSource;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    PNL_FUNDO: TPanel;
    Label23: TLabel;
    Label24: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    SB_MarcaModelo: TSpeedButton;
    Sb_Tp_veiculo: TSpeedButton;
    E_Placa: TMaskEdit;
    E_Frota: TEdit;
    E_Km: TEdit_Setes;
    E_Ano: TEdit_Setes;
    DBLCB_Marca: TDBLookupComboBox;
    DBLCB_Modelos: TDBLookupComboBox;
    DBLCB_Tp_Veiculo: TDBLookupComboBox;
    Panel1: TPanel;
    SB_Inserir: TSpeedButton;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Sb_Pesquisar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Dblcb_CorVeiculo: TDBLookupComboBox;
    Label7: TLabel;
    Label2: TLabel;
    E_Cilindrada: TEdit_Setes;
    Label6: TLabel;
    E_Chassi: TEdit;
    Fm_ListaClientes: TFm_ListaClientes;
    Fm_ListaEstados: TFm_ListaEstados;
    Qr_UF: TSTQuery;
    Ds_UF: TDataSource;
    Carroceria: TLabel;
    TaraKg: TLabel;
    E_Tara: TEdit_Setes;
    Renavan: TLabel;
    Label17: TLabel;
    E_Renavan: TEdit_Setes;
    CapacidadeM3: TLabel;
    E_CapacidadeM3: TEdit_Setes;
    CapacidadeKg: TLabel;
    E_CapacidadeKg: TEdit_Setes;
    Pg_Cadastro: TPageControl;
    Cb_TipoRodado: TComboBox;
    Cb_Carroceria: TComboBox;
    Label8: TLabel;
    E_BuscaCor: TMaskEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SB_InserirClick(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure Sb_PesquisarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_MarcaModeloClick(Sender: TObject);
    procedure E_UltimaCalibExit(Sender: TObject);
    procedure Sb_CadastrarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure Sb_VisualizarClick(Sender: TObject);
    procedure Sb_Sair_1Click(Sender: TObject);
    procedure Dbg_PesquisaTitleClick(Column: TColumn);
    procedure Sb_Tp_veiculoClick(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    It_Sqltxt:string;   //Sql a ser executado;
    It_Ordem : String ; //Ordem da pesquisa (Crescente/Decrescente)
    It_Indice: Integer; //Coluna clicada
    It_Codvei:Integer;
    It_Inserir,It_Alterar,It_Excluir,It_Visualizar:Boolean;
  public
    { Public declarations }
      It_Cd_Cadastro : Integer;
      It_Edicao : String;
      vehicle : TControllerVehicle;
      procedure Pc_FormataTela;
      procedure Pc_IniciaVariaveis;
      procedure Pc_Buscar(Pc_Coluna : Integer);
      procedure Pc_AtivarTabelas;
      PROCEDURE Pc_Limpa_Campo_Busca;
      PROCEDURE Pc_Limpa_Campo;
      FUNCTIon Fc_validaGravacao:Boolean;
      procedure Grava;
      procedure Pc_PermissaoBotao(Pc_Menu: string);
      procedure Pc_ImagemBotao;
      procedure Pc_ControleEdicao;
      procedure PreencharComDados;
      procedure PreencharSemDados;
  end;

var
  Fr_Veiculo: TFr_Veiculo;

implementation

uses     Un_DM, Un_Msg, sea_vehicle_brand, sea_vehicle_kind, UN_Sistema, Un_WebService, UN_Principal, env, RN_Veiculo, UN_TabelasEmListas, Un_Regra_Negocio;
{$R *.dfm}


procedure TFr_Veiculo.Pc_FormataTela;
Var
 Lc_X : Integer;
begin
  For Lc_X:=1 to Pg_Cadastro.PageCount do Pg_Cadastro.Pages[Lc_X-1].TabVisible:=False;
  Pg_Cadastro.ActivePagE := tbs_Pesquisa;
  Pc_ImagemBotao;
end;

procedure TFr_Veiculo.Pc_IniciaVariaveis;
Begin
  vehicle.getbyId;
  Fm_ListaEstados.Pc_Listar;
  Pc_AtivarTabelas;
  if ( vehicle.exist) then
  Begin
    It_Edicao := 'B';
    Pc_ControleEdicao;
    PreencharComDados;
    Pg_Cadastro.ActivePageIndex := 0;
  End
  else
    Begin
    PreencharSemDados;
    Pg_Cadastro.ActivePageIndex := 1;
  end;
end;

procedure TFr_Veiculo.Pc_Buscar(pc_Coluna : Integer);
 var
  Lc_Razao,Lc_Placa,Lc_Frota,Lc_Marca,Lc_Modelo,Lc_Cor: boolean;
begin
  It_sqltxt := '';
  Screen.Cursor:=crHourGlass;
  with Qr_Pesquisa do
  Begin
    Close;
    Sql.Clear;
    It_Sqltxt:=' SELECT VEI_CODIGO, VEI_PLACA, VEI_FROTA, EMP_NOME, EMP_FANTASIA,   '+
               ' MRC_DESCRICAO, MOD_DESCRICAO, VEI_ANO                              '+
               ' FROM Tb_Veiculo                                                    '+
               '   LEFT OUTER JOIN TB_EMPRESA Tb_cliente                            '+
               '   ON  (Tb_cliente.EMP_CODIGO = Tb_Veiculo.VEI_CODEMP)              '+
               '   LEFT OUTER JOIN TB_MARCA_VEICULO TB_MARCA_VEICULO                '+
               '   ON  (TB_MARCA_VEICULO.MRC_CODIGO = Tb_Veiculo.VEI_CODMRC)        '+
               '   LEFT OUTER JOIN TB_MODELO tb_modelo                              '+
               '   ON  (tb_modelo.MOD_CODIGO = Tb_Veiculo.VEI_CODMOD)               '+
               '   LEFT OUTER JOIN tb_color CL                                      '+
               '   ON (CL.id = tb_veiculo.vei_codcor)                               '+
               ' WHERE (VEI_CODIGO IS NOT NULL)                                     ';

    if ME_BuscaRazao.Text ='' then Lc_Razao := False else Lc_Razao := True;
    if ME_Placa.Text ='' then Lc_Placa := False else Lc_Placa := True;
    if ME_BuscaFrota.Text ='' then Lc_Frota := False else Lc_Frota := True;
    if E_BuscaMarca.Text = '' then Lc_Marca := False else Lc_Marca := True;
    if E_BuscaModelo.Text = '' then Lc_Modelo := False else Lc_Modelo := True;
    if E_BuscaCor.Text = '' then Lc_Cor := False else Lc_Cor := True;

    if Lc_Razao   then It_sqltxt := It_sqltxt +'AND ((EMP_FANTASIA LIKE :EMP_FANTASIA) or (EMP_NOME LIKE :EMP_FANTASIA) ) ';
    if Lc_Placa   then It_sqltxt := It_sqltxt +'AND VEI_PLACA =:VEI_PLACA ';
    if Lc_Frota   then It_sqltxt := It_sqltxt +'AND VEI_FROTA =:VEI_FROTA ';
    if Lc_Marca   then It_sqltxt := It_sqltxt +'AND MRC_DESCRICAO  LIKE :MRC_DESCRICAO ';
    if Lc_Modelo  then It_sqltxt := It_sqltxt +'AND MOD_DESCRICAO LIKE :MOD_DESCRICAO ';
    if Lc_Cor     then It_sqltxt := It_sqltxt +'AND CL.description LIKE :Cor ';

    //Define a Ordenação
    if it_Indice <> pc_Coluna then
       It_Ordem := ''
    else
      if Length(It_Ordem) > 0 then
         It_Ordem := ''
      else
         It_Ordem := 'DESC';

    SQL.Add(it_SqlTxt + ' ORDER BY ' + Dbg_Pesquisa.Columns.Items[pc_coluna].FieldName + ' ' + It_Ordem);
    It_Indice := Pc_Coluna;
    if Lc_Razao then  ParamByName('EMP_FANTASIA').AsString:='%'+ ME_BuscaRazao.Text+'%';
    if Lc_Placa then  ParamByName('VEI_PLACA').AsString:=ME_Placa.Text;

    if Lc_Frota then  ParamByName('VEI_FROTA').AsString:=ME_BuscaFrota.Text;
    if Lc_Marca then  ParamByName('MRC_DESCRICAO').AsString:= '%'+ E_BuscaMarca.Text+'%';
    if Lc_Modelo then ParamByName('MOD_DESCRICAO').AsString:= '%'+ E_BuscaModelo.Text+'%';
    if Lc_Cor then ParamByName('COR').AsString:= '%'+ E_BuscaCor.Text+'%';
    Open;
  End;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Veiculo.Pc_ControleEdicao;
Begin
  SB_Inserir.Enabled := (It_Edicao = 'B') and It_Inserir;
  SB_Excluir.Enabled := (It_Edicao = 'B') and
    (vehicle.Registro.Codigo > 0) and It_Excluir;
  SB_Alterar.Enabled := (It_Edicao = 'B') and
    (vehicle.Registro.Codigo > 0) and It_Alterar;
  SB_Gravar.Enabled := (It_Edicao = 'E')OR (It_Edicao = 'I');
  SB_Cancelar.Enabled := (It_Edicao = 'E')OR (It_Edicao = 'I');
  Sb_Sair_0.Enabled := (It_Edicao = 'B');
  SB_Pesquisar.Enabled := (It_Edicao = 'B');
  PNL_FUNDO.Enabled :=  (It_Edicao = 'E') OR (It_Edicao = 'I');
end;

procedure TFr_Veiculo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  case Pg_Cadastro.ActivePageIndex of
    0:Begin
        //NÃO PRECISA POR O PROPRIO OBJETO JÁ ESTÉ POPULADO
        //vehicle.Registro.Codigo := Tb_marca_modeo.FieldByName('VEI_CODIGO').AsInteger;
      End;
    1:Begin
        if Qr_Pesquisa.active then
        Begin
          vehicle.Registro.Codigo := Qr_Pesquisa.FieldByName('VEI_CODIGO').AsInteger;
          vehicle.Registro.Placa := Qr_Pesquisa.FieldByName('VEI_PLACA').AsString;
        End;
      End;
  end;
end;

procedure TFr_Veiculo.FormCreate(Sender: TObject);
begin
  vehicle := TControllerVehicle.Create(Self);
end;

procedure TFr_Veiculo.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Veiculo.SB_InserirClick(Sender: TObject);
begin
  Pc_Limpa_Campo;
  It_Edicao := 'I';
  Pc_ControleEdicao;
  Pc_AtivarTabelas;
  Fm_ListaClientes.DBLCB_Empresa.SetFocus;
  Cb_Carroceria.ItemIndex := 0;
  Cb_TipoRodado.ItemIndex := 5;
  Pc_AtivaEstabelecimento;
  Fm_ListaEstados.Dblcb_Lista.KeyValue := DM.Qr_Estabelecimento.FieldByName('UFE_CODIGO').AsInteger;
end;



procedure TFr_Veiculo.SB_GravarClick(Sender: TObject);
begin
  if Fc_validaGravacao then
  begin
    Try
      Screen.Cursor := crHourGlass;
      Enabled := False;
      Pc_ProcesoAguarde(Self,'I');
      Grava;
      It_Edicao := 'B';
      Pc_ControleEdicao;
    Finally
      Pc_ProcesoAguarde(Self,'F');
      Enabled := True;
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TFr_Veiculo.SB_CancelarClick(Sender: TObject);
begin
  if (It_Edicao = 'I') then
    BEGIN
    Pg_Cadastro.ActivePage := tbs_Pesquisa;
    PC_Buscar(0)
    END;
  It_Edicao := 'B';
  Pc_ControleEdicao();
end;

procedure TFr_Veiculo.SB_AlterarClick(Sender: TObject);
begin
  It_Edicao := 'E';
  Pc_ControleEdicao;
  DBLCB_Marca.SetFocus;
end;

procedure TFr_Veiculo.SB_ExcluirClick(Sender: TObject);
Var
  Lc_codigo : string;
begin
   if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Excluir este Registro'+'.'+EOLN+EOLN+
                       'Confirmar a exclusão ?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
      exit;
    try
      vehicle.delete;
      vehicle.Clear;
      IF DM.IB_Transacao.InTransaction THEN DM.ib_Transacao.CommitRetaining;
      Pc_Limpa_Campo_Busca;
      Pc_Buscar(0);
      Pg_Cadastro.ActivePage := tbs_Pesquisa;
      if (Fc_Tb_Geral('L','GRL_G_COM_ELETRONICO','') = 'S') then
      Begin
        Case Gb_Cd_Wsr of
          2:Begin
              Pc_Ws_Veiculo('D',Lc_codigo);
          End;
        End;
      End;

    except
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                     'Entre em contato com o suporte técnico.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    end;

end;

procedure TFr_Veiculo.Pc_AtivarTabelas;
Begin
  DM.Qr_MarcaVeiculo.Active := True;
  DM.Qr_Color.Active := True;
  DM.Qr_MarcaVeiculo.Active := True;
  DM.QR_Modelo.Active := True;
  DM.Qr_Tp_Veiculo.Active := True;
  Fm_ListaClientes.ListaClientes('EMP_NOME');
end;

procedure TFr_Veiculo.SB_BuscarClick(Sender: TObject);
begin
   PC_Buscar(0);
end;

procedure TFr_Veiculo.Sb_PesquisarClick(Sender: TObject);
begin
  Pg_Cadastro.ActivePagE := tbs_Pesquisa;
  Pc_Buscar(0);
end;

procedure TFr_Veiculo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Pg_Cadastro.ActivePageIndex of
  0:begin
    if shift = [] then
      begin
        case Key of
        VK_F2  : if SB_Inserir.Enabled then SB_InserirClick(Sender);
        VK_F3  : if SB_Alterar.Enabled then SB_AlterarClick(Sender);
        VK_F4  : if SB_Excluir.Enabled then SB_ExcluirClick(Sender);
        VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
        VK_F6  : if SB_Cancelar.Enabled then SB_CancelarClick(Sender);
        VK_F7  : if Sb_Pesquisar.Enabled then SB_PesquisarClick(Sender);
        VK_Escape : if Sb_Sair_1.Enabled then Sb_Sair_1Click(Sender);
        end;
      end;
    end;
  else
    begin
    if shift = [] then
      begin
      case Key of
      VK_F2  : if SB_Cadastrar.Enabled then SB_CadastrarClick(Sender);
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_F8 : if Sb_Visualizar.Enabled then SB_VisualizarClick(Sender);
      VK_Escape : if Sb_Sair_1.Enabled then Sb_Sair_1Click(Sender);
      end;
      end;
    end;
  end;


end;

procedure TFr_Veiculo.SB_MarcaModeloClick(Sender: TObject);
Var
  Lc_Form : TSeaVehicleBrand;
begin
  Try
    Lc_Form := TSeaVehicleBrand.Create(nil);
    Lc_Form.ShowModal;
  Finally
    DM.Qr_MarcaVeiculo.Active := False;
    DM.Qr_Modelo.Active := False;
    DM.Qr_MarcaVeiculo.Active := True;
    DM.Qr_Modelo.Active := True;
    DBLCB_Marca.KeyValue    := Lc_Form.cds_searchcodigo.AsInteger;
    DBLCB_Modelos.KeyValue  := Lc_Form.cds_searchCodigoModelo.AsInteger;
    DBLCB_Marca.SetFocus;
    FreeAndNil( Lc_Form );
  End;
end;

procedure TFr_Veiculo.E_UltimaCalibExit(Sender: TObject);
var
  Data : TDateTime;
begin
end;

procedure TFr_Veiculo.Sb_CadastrarClick(Sender: TObject);
begin
  Pg_Cadastro.ActivePagE := tbs_cadastro;
  SB_InserirClick(Sender);
end;

procedure TFr_Veiculo.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Veiculo.Sb_VisualizarClick(Sender: TObject);
begin
  if Qr_Pesquisa.RecordCount > 0 then
  begin
    vehicle.Registro.Placa := Qr_Pesquisa.FieldByName('VEI_PLACA').AsString;
    vehicle.getbyId;
    if ( vehicle.exist) then
      PreencharComDados
    else
      PreencharSemDados;
    Pc_AtivarTabelas;
    It_Edicao := 'B';
    Pc_ControleEdicao;
    Pg_Cadastro.ActivePagE := tbs_cadastro;
  end;
end;

procedure TFr_Veiculo.Sb_Sair_1Click(Sender: TObject);
begin
  close;
end;

procedure TFr_Veiculo.Dbg_PesquisaTitleClick(Column: TColumn);
begin
 Pc_Pintar_Grid_Ordenar(Dbg_Pesquisa, Column);
end;

procedure TFr_Veiculo.Sb_Tp_veiculoClick(Sender: TObject);
Var
  Lc_Form : TSeaVehicleKind;
begin
  Lc_Form := TSeaVehicleKind.Create(nil);
  Try
    Lc_Form.ShowModal;
  Finally
    DM.Qr_Tp_Veiculo.Active := False;
    DM.Qr_Tp_Veiculo.Active := True;
    DBLCB_Tp_Veiculo.KeyValue := Lc_Form.cds_searchcodigo.AsInteger;
    DBLCB_Tp_Veiculo.SetFocus;
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Veiculo.ChBx_NomeClick(Sender: TObject);
begin
  IF ChBx_Nome.Checked THEN
    Begin
    ChBx_Fantasia.Checked := False;
    DBG_Pesquisa.Columns.Items[2].Title.Caption := 'Nome/Razão Social';
    DBG_Pesquisa.Columns.Items[2].FieldName := 'EMP_NOME'   ;
    end;
end;

procedure TFr_Veiculo.ChBx_FantasiaClick(Sender: TObject);
begin
  IF ChBx_Fantasia.Checked THEN
    Begin
    ChBx_Nome.Checked := False;
    DBG_Pesquisa.Columns.Items[2].Title.Caption := 'Nome Fantasia/Apelido/Codnome';
    DBG_Pesquisa.Columns.Items[2].FieldName := 'EMP_FANTASIA'
    end;
end;

procedure TFr_Veiculo.Pc_Limpa_Campo_Busca;
begin
  ME_BuscaFrota.Text:='';
  ME_BuscaRazao.Text:='';
  ME_Placa.Text:='';
  E_BuscaMarca.Text:='';
  E_BuscaModelo.Text:='';
end;

PROCEDURE TFr_Veiculo.Pc_Limpa_Campo;
Begin
  It_Cd_Cadastro := 0;
  Fm_ListaClientes.E_Cd_Empresa.Clear;
  Fm_ListaClientes.DBLCB_Empresa.KeyValue := Null;
  DBLCB_Marca.KeyValue := Null;
  DBLCB_Modelos.KeyValue := Null;
  DBLCB_Tp_Veiculo.KeyValue := Null;
  E_Placa.Clear;
  E_Frota.Clear;
  E_Km.Clear;
  Dblcb_CorVeiculo.KeyValue := Null;
  E_Ano.Clear;
  E_Cilindrada.Clear;
  E_Chassi.Clear;
end;

function TFr_Veiculo.Fc_validaGravacao: Boolean;
begin
  Result:=true;
  if TRIM(Fm_ListaClientes.DBLCB_Empresa.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Nome do Cliente deve ser informado.'+EOLN+
                   'Preencha o campo antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    Fm_ListaClientes.DBLCB_Empresa.SetFocus;
    exit;
  end;

  if TRIM(E_Placa.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Placa não informado.'+EOLN+
                   'Preencha o campo antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    E_Placa.SetFocus;
    exit;
  end;

  if TRIM(DBLCB_Marca.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Marca não informada.'+EOLN+
                   'Preencha a Marca para este veículo.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    DBLCB_Marca.SetFocus;
    exit;
  end;

  if TRIM(DBLCB_Modelos.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Modelo não informado.'+EOLN+
                   'Preencha o campo antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    DBLCB_Modelos.SetFocus;
    exit;
  end;

  if TRIM(DBLCB_Tp_Veiculo.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Tipo de Veículo não informado.'+EOLN+
                   'Preencha o campo antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    DBLCB_Tp_Veiculo.SetFocus;
    exit;
  end;

  if TRIM(Dblcb_CorVeiculo.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Cor do veículo não informado.'+EOLN+
                   'Preencha o campo antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    Dblcb_CorVeiculo.SetFocus;
    exit;
  end;

  if TRIM(Cb_Carroceria.Text) = '' then
  begin
    Cb_Carroceria.ItemIndex := 0;
  end;

  if TRIM(Cb_TipoRodado.Text) = '' then
  begin
    Cb_TipoRodado.ItemIndex := 5;
  end;

  if TRIM(Fm_ListaEstados.Dblcb_Lista.Text) = '' then
  begin
    Pc_AtivaEstabelecimento;
    Fm_ListaEstados.Dblcb_Lista.KeyValue := DM.Qr_Estabelecimento.FieldByName('UFE_CODIGO').AsInteger;
  end;



end;

procedure TFr_Veiculo.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Inserir := True;
    It_Alterar := True;
    It_Excluir := True;
    It_Visualizar := True;
    end
  else
    begin
    It_Inserir    := Fc_HabilitaPermissao(Pc_Menu,'INSERIR','S');
    It_Alterar    := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
    It_Excluir    := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    end;
    Sb_Cadastrar.Enabled :=  It_Inserir;
end;

procedure TFr_Veiculo.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Inserir.Glyph.Assign(Fc_CarregaImagemBotao('INSERIR'));
    SB_Alterar.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    SB_Excluir.Glyph.Assign(Fc_CarregaImagemBotao('EXCLUIR'));
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    SB_Pesquisar.Glyph.Assign(Fc_CarregaImagemBotao('PESQUISAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    SB_Cadastrar.Glyph.Assign(Fc_CarregaImagemBotao('CADASTRAR'));
    SB_Buscar.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    SB_Visualizar.Glyph.Assign(Fc_CarregaImagemBotao('VISUALIZAR'));
    Sb_Sair_1.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Veiculo.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_PermissaoBotao('Veículos');
  Pc_IniciaVariaveis;


end;

procedure TFr_Veiculo.Grava;
begin
  with Vehicle.Registro do
  Begin
    CodigoEmpresa := Fm_ListaClientes.DBLCB_Empresa.KeyValue;
    Placa         := E_Placa.Text;
    Frota         := e_Frota.Text;
    Tipo          := DBLCB_Tp_Veiculo.KeyValue;
    CodigoMarca   := DBLCB_Marca.KeyValue;
    CodigoModelo  := DBLCB_Modelos.KeyValue;
    Ano           := E_Ano.Text;
    KM            := E_Km.Text;
    Chassi        := E_Chassi.Text;
    Cilindrada    := StrToIntDef(E_Cilindrada.Text,0);
    CodigoCor     := DBLCB_CorVeiculo.KeyValue;
    Carroceria    := Cb_carroceria.text;
    Tara          := strtofloatdef(E_tara.Text,0);
    Renavan       := E_Renavan.Text;
    Estado        := Fm_Listaestados.Dblcb_Lista.KeyValue;
    TipoRodado    := Cb_Tiporodado.text;
    CapacidadeKg  := strtofloatdef(E_capacidadekg.text,0);
    CapacidadeM3  := strtofloatdef(E_CapacidadeM3.text,0);

  End;
  Vehicle.salva;
  IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
end;

procedure TFr_Veiculo.PreencharComDados;
Begin
  with vehicle.Registro do
  Begin
    Fm_ListaClientes.E_Cd_Empresa.Text := IntToStr(CodigoEmpresa);
    Fm_ListaClientes.DBLCB_Empresa.KeyValue := CodigoEmpresa;
    E_Placa.Text              := Placa;
    E_Frota.Text              := Frota;
    DBLCB_Tp_Veiculo.KeyValue := Tipo;
    DBLCB_Marca.KeyValue      := CodigoMarca;
    DBLCB_Modelos.KeyValue    := CodigoModelo;
    E_Ano.Text                := Ano;
    Dblcb_CorVeiculo.KeyValue := CodigoCor;
    E_Cilindrada.Text         := IntToStr(Cilindrada);
    E_Km.Text                 := KM;
    Cb_carroceria.text        := Carroceria;
    E_tara.Text               := FloattoStr(Tara);
    E_Renavan.Text            := Renavan;
    Fm_Listaestados.Dblcb_Lista.KeyValue := Estado;
    Cb_Tiporodado.text        := TipoRodado;
    E_capacidadekg.text       := FloatToStr(CapacidadeKg);
    E_CapacidadeM3.text       := FloatToStr(CapacidadeM3);
    E_Chassi.Text             := Chassi;


  end;
End;

procedure TFr_Veiculo.PreencharSemDados;
BEgin
  Fm_ListaClientes.DBLCB_Empresa.KeyValue := Null;
  E_Placa.Clear;
  E_Frota.Clear;
  DBLCB_Tp_Veiculo.KeyValue := Null;
  DBLCB_Marca.KeyValue      := Null;
  DBLCB_Modelos.KeyValue    := Null;
  E_Ano.Clear;
  Dblcb_CorVeiculo.KeyValue := Null;
  E_Cilindrada.Clear;
  E_Km.Clear;
  Cb_carroceria.ItemIndex   := 0;
  E_tara.Clear;
  E_Renavan.Clear;
  Fm_Listaestados.Dblcb_Lista.KeyValue := Null;
  Cb_Tiporodado.ItemIndex := 0;
  E_capacidadekg.Clear;
  E_CapacidadeM3.Clear;
  E_Chassi.Clear;

End;

end.
