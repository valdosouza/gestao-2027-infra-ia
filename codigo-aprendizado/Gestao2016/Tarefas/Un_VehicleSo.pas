unit Un_VehicleSo;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, DB, StdCtrls, DBCtrls, Printers, ExtCtrls, Mask, STQuery, STStoredProc, Grids, ControllerVehicleOs, DBGrids, QEdit_Setes, Vcl.ComCtrls;

type
  TFr_VehicleSo = class(TForm)
    Qr_Veiculo: TSTQuery;
    PG_Principal: TPageControl;
    Tbs_Ordem: TTabSheet;
    Pnl_Controle: TPanel;
    Label4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label1: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Sb_MarcaModelo: TSpeedButton;
    Sb_Tpv_Veiculo: TSpeedButton;
    Label13: TLabel;
    Label14: TLabel;
    Label7: TLabel;
    SpeedButton2: TSpeedButton;
    Label11: TLabel;
    Label15: TLabel;
    E_Obs: TMemo;
    DBLCB_Marca: TDBLookupComboBox;
    DBLCB_Modelo: TDBLookupComboBox;
    DBLCB_Tp_Veiculo: TDBLookupComboBox;
    E_Dt_Saida: TEdit;
    E_Placa: TMaskEdit;
    E_Frota: TMaskEdit;
    E_Ano: TEdit_Setes;
    E_Hr_Saida: TEdit;
    E_Km: TEdit;
    Dblcb_CorVeiculo: TDBLookupComboBox;
    E_Cilindrada: TEdit_Setes;
    Panel1: TPanel;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    tbs_Veiculo: TTabSheet;
    Panel2: TPanel;
    Dbg_Pesquisa: TDBGrid;
    Panel3: TPanel;
    Sb_Cancelar_2: TSpeedButton;
    Sb_Veiculo: TSpeedButton;
    Sb_CheckList: TSpeedButton;
    Sb_Utilizar: TSpeedButton;
    Ds_Veiculo: TDataSource;
    Label2: TLabel;
    E_Chassi: TEdit;
    procedure SB_AlterarClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Sb_Tpv_VeiculoClick(Sender: TObject);
    procedure Sb_MarcaModeloClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Sb_VeiculoClick(Sender: TObject);
    procedure Sb_CheckListClick(Sender: TObject);
    procedure E_PlacaExit(Sender: TObject);
    procedure Sb_Cancelar_2Click(Sender: TObject);
  private
    { Private declarations }
    It_Inserir,It_Alterar,It_Excluir,It_Visualizar:Boolean;
  public
    { Public declarations }
    It_Edicao : String;
    OrdemServico : TControllerVehicleOs;
    procedure Pc_EstadoEdicaoOrdem;
    procedure Pc_ListaVeiculo;

    procedure Inserir;
    procedure Alterar;
    function  ValidaGravacao:boolean;
    procedure Gravar;
    Procedure Excluir;
    procedure Cancelar;
    procedure PreencheVehicle;
    procedure LimpaCamposVehicle;
    procedure PreencheOS;
    procedure LimpaCamposOS;


    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;
    procedure FormataTela;
    procedure IniciaVariaveis;
    procedure AtivarTabela;
    Procedure AbrirCadastroVeiculo(Fc_PLaca:String);
  end;

var
  Fr_VehicleSo: TFr_VehicleSo;

implementation

uses     Un_Msg, Un_DM, UN_Sistema, Un_Funcoes, UN_Pedido_Vda, UN_NF, UN_Principal, env, Un_Veiculo, RN_Veiculo, RN_Crud, Un_VehicleCheckList, sea_vehicle_kind, sea_vehicle_brand, ControllerVehicle, Un_Regra_Negocio;
{$R *.dfm}

procedure TFr_VehicleSo.Inserir;
Begin


End;

procedure TFr_VehicleSo.Alterar;
Begin
  if E_Placa.CanFocus  then E_Placa.SetFocus;
End;

procedure TFr_VehicleSo.AtivarTabela;
begin
  DM.Qr_MarcaVeiculo.Active := True;
  DM.Qr_Color.Active := True;
  DM.Qr_Modelo.Active := True;
  DM.Qr_Tp_Veiculo.Active := True;
end;

function TFr_VehicleSo.ValidaGravacao:boolean;
Begin
  Result := true;
  if (Trim(E_Placa.Text) = '') then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por Favor informe a Placa do Veículo.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    if E_Placa.CanFocus  then E_Placa.SetFocus;
    Result := False;
    exit;
  end;

  if (Trim(DBLCB_Marca.Text) = '') then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por Favor informe a marca do Veículo.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    if DBLCB_Marca.CanFocus  then DBLCB_Marca.SetFocus;
    Result := False;
    exit;
  end;

  if (Trim(DBLCB_Modelo.Text) = '') then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por Favor informe o modelo do Veículo.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    if DBLCB_Modelo.CanFocus then DBLCB_Modelo.SetFocus;
    Result := False;
    exit;
  end;

  if (Trim(DBLCB_TP_Veiculo.Text) = '') then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por Favor informe o tipo do Veículo.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    if DBLCB_TP_Veiculo.CanFocus then DBLCB_TP_Veiculo.SetFocus;
    Result := False;
    exit;
  end;

  if (Trim(Dblcb_CorVeiculo.Text) = '') then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por Favor informe a cor do Veículo.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    if Dblcb_CorVeiculo.CanFocus then Dblcb_CorVeiculo.SetFocus;
    Result := False;
    exit;
  end;
end;

procedure TFr_VehicleSo.Gravar;
Begin
  with OrdemServico do
  Begin
    //Ordem de Servico
    with Registro do
    Begin
      Placa := E_Placa.Text;
      Observacao := E_Obs.Text;
      DataSaida := E_Dt_Saida.Text;
      HoraSaida := E_Hr_Saida.Text;
    End;
    //Veiculo
    with Vehicle.Registro do
    Begin
      Placa := E_Placa.Text;
      Frota := e_Frota.Text;
      Tipo := DBLCB_Tp_Veiculo.KeyValue;
      CodigoMarca := DBLCB_Marca.KeyValue;
      CodigoModelo := DBLCB_Modelo.KeyValue;
      Ano := E_Ano.Text;
      KM := E_Km.Text;
      Chassi := E_Chassi.Text;
      Cilindrada := StrToIntDef(E_Cilindrada.Text,0);
      CodigoCor := DBLCB_CorVeiculo.KeyValue;
    End;
    Vehicle.salva;
    OrdemServico.salva;
  End;
End;

Procedure TFr_VehicleSo.Excluir;
Begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir a ordem de Serviço do veículo ' + E_placa.Text +EOLN+EOLN+
                     'Confirmar a exclusão ?',
                     [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    OrdemServico.Delete;
    Close;
  end;
End;

procedure TFr_VehicleSo.E_PlacaExit(Sender: TObject);
begin
  if Trim(E_Placa.Text) <> '' then
  Begin
    with OrdemServico.Vehicle do
    Begin
      Registro.Placa := E_Placa.Text;
      getById;
      if Exist then
        PreencheVehicle
      else
        LimpaCamposVehicle;
    End;
  End;
end;

procedure TFr_VehicleSo.Cancelar;
Begin
  if (It_Edicao = 'I') then
  Begin
    LimpaCamposOS;
    LimpaCamposVehicle;
  End;
End;

procedure TFr_VehicleSo.LimpaCamposVehicle;
Begin
  e_Frota.Clear;
  DBLCB_Tp_Veiculo.KeyValue := Null;
  DBLCB_Marca.KeyValue := Null;
  DBLCB_Modelo.KeyValue := Null;
  E_Ano.Clear;
  E_Km.Clear;
  E_Cilindrada.Clear;
  E_Chassi.Clear;
  DBLCB_CorVeiculo.KeyValue := Null;
End;

procedure TFr_VehicleSo.LimpaCamposOS;
Begin
  E_Obs.clear;
  E_Dt_Saida.clear;
  E_Hr_Saida.clear;
End;

procedure TFr_VehicleSo.PreencheVehicle;
Begin
  with OrdemServico.Vehicle.Registro do
  Begin
    E_Placa.Text := Placa;
    e_Frota.Text := Frota;
    DBLCB_Tp_Veiculo.KeyValue := Tipo;
    DBLCB_Marca.KeyValue := CodigoMarca;
    DBLCB_Modelo.KeyValue := CodigoModelo;
    E_Ano.Text := Ano;
    E_Km.Text := KM;
    E_Cilindrada.Text := IntToStr(Cilindrada);
    DBLCB_CorVeiculo.KeyValue := CodigoCor ;
    E_Chassi.Text := Chassi;
  End;
End;

procedure TFr_VehicleSo.PreencheOS;
Begin
  with OrdemServico.Registro do
  Begin
    E_Obs.Text := Observacao;
    E_Dt_Saida.Text := DataSaida;
    E_Hr_Saida.Text := HoraSaida;
  End;
End;


procedure TFr_VehicleSo.SB_AlterarClick(Sender: TObject);
begin
  It_Edicao := 'E';
  Pc_EstadoEdicaoOrdem;
  Alterar;
end;

procedure TFr_VehicleSo.SB_ExcluirClick(Sender: TObject);
begin
  Excluir;
end;

procedure TFr_VehicleSo.SB_GravarClick(Sender: TObject);
begin
  if ValidaGravacao then
  Begin
    Gravar;
    It_Edicao := 'B';
    Pc_EstadoEdicaoOrdem
  end;
end;

procedure TFr_VehicleSo.SB_CancelarClick(Sender: TObject);
begin
  It_Edicao := 'B';
  Pc_EstadoEdicaoOrdem;
  Cancelar;
end;

procedure TFr_VehicleSo.Sb_Cancelar_2Click(Sender: TObject);
begin
  PG_Principal.ActivePage := Tbs_Ordem;
  if Qr_Veiculo.RecordCount > 0 then
  Begin
    with OrdemServico.Vehicle do
    Begin
      Registro.Placa := Qr_Veiculo.FieldByName('VEI_PLACA').AsString;
      getById;
      if Exist then PreencheVehicle;
    End;
  End;
end;

procedure TFr_VehicleSo.Sb_CheckListClick(Sender: TObject);
Var
  Lc_Form : TFr_VehicleCheckList;
begin
  Lc_Form := TFr_VehicleCheckList.Create(nil);
  Try
    with Lc_Form do
    Begin
      It_Budget_id := OrdemServico.Registro.codigoCotacao;
      It_Order_id := OrdemServico.Registro.CodigoPedido;
      ShowModal;
    End;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_VehicleSo.Sb_MarcaModeloClick(Sender: TObject);
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
    DBLCB_Marca.KeyValue := Lc_Form.cds_searchcodigo.AsInteger;
    DBLCB_Modelo.KeyValue := Lc_Form.cds_searchCodigoModelo.AsInteger;
    if DBLCB_Marca.CanFocus then DBLCB_Marca.SetFocus;
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_VehicleSo.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_VehicleSo.Sb_Tpv_VeiculoClick(Sender: TObject);
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
    if DBLCB_Tp_Veiculo.CanFocus then DBLCB_Tp_Veiculo.SetFocus;
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_VehicleSo.Sb_VeiculoClick(Sender: TObject);
begin
  AbrirCadastroVeiculo('');
end;

procedure TFr_VehicleSo.Pc_ListaVeiculo;
Var
  Lc_SqlTxt : String;
Begin
  with Qr_Veiculo do
  Begin
    Active := False;
    ParamByName('VEI_CODEMP').AsInteger :=  OrdemServico.Vehicle.Registro.CodigoEmpresa;
    Active := True;
  end;
end;

procedure TFr_VehicleSo.SpeedButton2Click(Sender: TObject);
begin
  PG_Principal.ActivePage := tbs_Veiculo;
  Pc_ListaVeiculo;
end;

procedure TFr_VehicleSo.Pc_EstadoEdicaoOrdem;
begin
  SB_Excluir.Enabled := (It_Edicao = 'B') AND It_Excluir and (OrdemServico.Registro.codigoestabelecimento > 0);
  SB_Alterar.Enabled := (It_Edicao = 'B') AND It_Alterar and (OrdemServico.Registro.codigoestabelecimento > 0);
  SB_Gravar.Enabled := (It_Edicao = 'I') OR (It_Edicao = 'E');
  SB_Cancelar.Enabled := (It_Edicao = 'I') OR (It_Edicao = 'E');
  Sb_CheckList.Enabled := (It_Edicao = 'B') ;
  SB_Sair_0.Enabled := (It_Edicao = 'B') ;
  Pnl_Controle.Enabled:= (It_Edicao = 'I') OR (It_Edicao = 'E');
end;

procedure TFr_VehicleSo.FormCreate(Sender: TObject);
begin
  OrdemServico := TControllerVehicleOs.create(Self);
end;

procedure TFr_VehicleSo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F3: SB_AlterarClick(sender);
      VK_F4 : SB_ExcluirClick(Sender);
      VK_F5 : SB_GravarClick(Sender);
      VK_F6 : SB_CancelarClick(Sender);      
      VK_Escape : SB_Sair_0Click(Self);
    end;
  end;
end;

procedure TFr_VehicleSo.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;


procedure TFr_VehicleSo.AbrirCadastroVeiculo(Fc_PLaca: String);
Var
  Lc_Form : TFr_Veiculo;
begin
  Lc_Form := TFr_Veiculo.Create(Self);
  Try
    Lc_Form.VEhicle.Registro.Placa := Fc_PLaca;
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_VehicleSo.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
  begin
    It_Alterar := True;
    It_Excluir := True;
    It_Visualizar := True;
  end
  else
  begin
    It_Alterar    := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
    It_Excluir    := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
  end;
end;

procedure TFr_VehicleSo.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Geral;
    SB_Alterar.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    SB_Excluir.Glyph.Assign(Fc_CarregaImagemBotao('EXCLUIR'));
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    Sb_Utilizar.Glyph.Assign(Fc_CarregaImagemBotao('INSERIR'));
    SB_Cancelar_2.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
  END;
end;

procedure TFr_VehicleSo.FormataTela;
var
   Lc_X: Integer;
Begin
  for Lc_X := 1 to PG_Principal.PageCount do
    PG_Principal.Pages[Lc_X - 1].TabVisible := False;
  PG_Principal.ActivePage := Tbs_Ordem;
END;

procedure TFr_VehicleSo.IniciaVariaveis;
Begin
  with OrdemServico do
  Begin
    if (Registro.CodigoCotacao > 0 ) then
      getByCotacao
    else
      getByPedido;
    It_Edicao := 'I';
    if exist then
    Begin
      It_Edicao := 'E';
      PreencheOS;
      Vehicle.Registro.Placa := Registro.Placa;
      Vehicle.getbyId;
      PreencheVehicle;
    End;
  End;
  Pc_EstadoEdicaoOrdem;
end;
procedure TFr_VehicleSo.FormShow(Sender: TObject);
begin
  FormataTela;
  Pc_PermissaoBotao('Ordem de Serviço');
  Pc_ImagemBotao;
  AtivarTabela;
  IniciaVariaveis;
end;



end.







