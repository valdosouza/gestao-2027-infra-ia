unit UN_Imp_Servico;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, DBCtrls, Mask, Buttons, Printers, DB, STQuery, Jpeg, ComCtrls, frxClass;

type
   TFr_Imp_Servico = class(TForm)
      PrintDialog1: TPrintDialog;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Panel1: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Lb_Placa: TLabel;
    Lb_Frota: TLabel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    DBLCB_Empresa: TDBLookupComboBox;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    E_BuscaCodigo: TMaskEdit;
    GroupBox2: TGroupBox;
    Rb_Vend_Clliente: TRadioButton;
    Rb_Vend_Pedido: TRadioButton;
    DBLCB_Vendedor: TDBLookupComboBox;
    Cb_Tipo: TComboBox;
    RG_Tipo: TRadioGroup;
    E_PlacaINI: TMaskEdit;
    E_PlacaFIM: TMaskEdit;
    E_FrotaINI: TMaskEdit;
    E_FrotaFIM: TMaskEdit;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    chbx_Without_vehicle: TCheckBox;
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure SB_ImprimirClick(Sender: TObject);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure Sb_ExportarClick(Sender: TObject);
      procedure ChBx_FantasiaClick(Sender: TObject);
      procedure ChBx_NomeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure chbx_EmpresasClick(Sender: TObject);
    procedure E_BuscaCodigoExit(Sender: TObject);
    procedure DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Cb_TipoChange(Sender: TObject);
    procedure DBLCB_VendedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
   private
    { Private declarations }
   public
    { Public declarations }
    It_Visualizar :Boolean;
    It_Imprimir :Boolean;
    It_Exportar :Boolean;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;
    procedure Pc_VeiculoNormal;
    procedure Pc_VeiculoDetalhada;
    procedure Pc_ExtintorNormal;
    procedure Pc_ControlaItensIterface;
   end;

var
   Fr_Imp_Servico: TFr_Imp_Servico;

implementation

uses     Un_Msg, UN_RL_OS_Veiculo, UN_RL_Ord_Serv_Det, Un_DM, Un_Excel, UN_Sistema, UN_Principal, env, Un_Regra_Negocio, RN_Cliente, UN_TabelasEmListas, un_frx_ord_serv_detalhado, UN_RL_OS_Extintor;


{$R *.dfm}



procedure TFr_Imp_Servico.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   if shift = [] then
   begin
      case Key of
         VK_F2: if Sb_Exportar.Enabled then   Sb_ExportarClick(Sender);
         VK_F3: if SB_Imprimir.Enabled then   SB_ImprimirClick(Sender);
         VK_Escape: if SB_Sair_0.Enabled then SB_Sair_0Click(Self);
      end;
   end;

end;

procedure TFr_Imp_Servico.Pc_VeiculoNormal;
Begin
  try
     if not Assigned(RL_OS_Veiculo) then Application.CreateForm(TRL_OS_Veiculo, RL_OS_Veiculo);
     RL_OS_Veiculo.Qrpt.Preview;
  finally
     RL_OS_Veiculo.Close
  end;
end;

procedure TFr_Imp_Servico.Pc_VeiculoDetalhada;
Var
  Form : TFrxOrdServDetalhado;
begin
  Try
    Form := TFrxOrdServDetalhado.create(Self);
    Form.buscar;
    Form.frxBase.ShowReport;
  Finally
    FreeAndNil(Form);
  End;

//  try
//    if not Assigned(Rl_Ord_Serv_Det) then Application.CreateForm(TRl_Ord_Serv_Det, Rl_Ord_Serv_Det);
//    Rl_Ord_Serv_Det.Qrpt.Preview;
//  finally
//    Rl_Ord_Serv_Det.Close
//  end;
end;

procedure TFr_Imp_Servico.Pc_ExtintorNormal;
Begin
  try
     if not Assigned(RL_OS_Extintor) then Application.CreateForm(TRL_OS_Extintor, RL_OS_Extintor);
     RL_OS_Extintor.Qrpt.Preview;
  finally
     RL_OS_Extintor.Close
  end;
end;

procedure TFr_Imp_Servico.SB_ImprimirClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Pc_LimpaQrPreviweMemoria;
    case Cb_Tipo.ItemIndex of
      0:Pc_VeiculoNormal;
      1:Pc_VeiculoDetalhada;
      2:Pc_ExtintorNormal;
    end;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;

procedure TFr_Imp_Servico.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_Servico.Sb_ExportarClick(Sender: TObject);
var
   Lc_CAminho: string;
begin
  if Fr_Principal.SaveDialogo.Execute then
    Begin
    if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
    Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
    Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
    case Cb_Tipo.ItemIndex of
      0:begin
        try
          if not Assigned(RL_OS_Veiculo) then Application.CreateForm(TRL_OS_Veiculo, RL_OS_Veiculo);
          RL_OS_Veiculo.Pc_Buscar;
          Fr_Excel.Pc_Excel(RL_OS_Veiculo.Qr_Servicos, Lc_CAminho);
        finally
          RL_OS_Veiculo.Close;
        end;
        end;
      1:begin
          //try
          //  if not Assigned(Rl_Ord_Serv_Det) then Application.CreateForm(TRl_Ord_Serv_Det, Rl_Ord_Serv_Det);
          //  Rl_Ord_Serv_Det.Pc_Buscar;
          //  Fr_Excel.Pc_Excel(Rl_Ord_Serv_Det.Qr_Servicos, Lc_CAminho);
          //finally
          //  RL_Ord_Serv_Det.Close;
          //end;
        end;
      end;
   end;
end;

procedure TFr_Imp_Servico.ChBx_FantasiaClick(Sender: TObject);
begin
  Pc_ListaClienteDbLookUpComboBox('EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
end;

procedure TFr_Imp_Servico.ChBx_NomeClick(Sender: TObject);
begin
  Pc_ListaClienteDbLookUpComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa);
end;

procedure TFr_Imp_Servico.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Imprimir     := True;
    It_Exportar     := True;
    end
  else
    begin
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    if not It_Visualizar then exit;
    It_Imprimir      := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    It_Exportar      := Fc_HabilitaPermissao(Pc_Menu,'EXPORTAR','S');
    end;
   SB_Imprimir.Enabled:= It_Imprimir;
   Sb_Exportar.Enabled:= It_Exportar;
end;

procedure TFr_Imp_Servico.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  Pc_PermissaoBotao('Ordem de Serviço');
  Pc_AbreListaCliente('EMP_NOME');
  DM_ListaConsultas.Pc_ListaVendedor;
  RG_Tipo.ItemIndex := 0;
  E_Data_INI.Date := Date;
  E_Data_FIM.Date := Date;
  ChBx_Periodo.Checked:=Fc_Marca_data_pesquisa;
end;

procedure TFr_Imp_Servico.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Imp_Servico.chbx_EmpresasClick(Sender: TObject);
begin
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
end;

procedure TFr_Imp_Servico.E_BuscaCodigoExit(Sender: TObject);
begin
  DBLCB_Empresa.KeyValue := StrToIntDef(E_BuscaCodigo.Text,0);
end;

procedure TFr_Imp_Servico.DBLCB_EmpresaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
        begin
        DBLCB_Empresa.KeyValue := Null;
        E_BuscaCodigo.Clear;
        end;
      end;
end;

procedure TFr_Imp_Servico.DBLCB_VendedorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
        begin
        DBLCB_Vendedor.KeyValue := Null;
        end;
      end;
end;

procedure TFr_Imp_Servico.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Imp_Servico.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    Sb_Exportar.Glyph := (Fc_CarregaImagemBotao('EXPORTAR'));
    SB_Imprimir.Glyph := (Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Imp_Servico.Pc_ControlaItensIterface;
Begin
  E_PlacaINI.Enabled := False;
  E_PlacaFIM.Enabled := False;
  E_PlacaINI.Clear;
  E_PlacaFIM.Clear;
  E_FrotaINI.Enabled := False;
  E_FrotaFIM.Enabled := False;
  E_FrotaINI.Clear;
  E_FrotaFIM.Clear;
end;

procedure TFr_Imp_Servico.Cb_TipoChange(Sender: TObject);
begin
  //Desativatodos os componentes
  Pc_ControlaItensIterface;
  //Ativa conforme a entrada no Case
  case Cb_Tipo.ItemIndex of
    0:begin
        E_PlacaINI.Enabled := True;
        E_PlacaFim.Enabled := True;
        E_FrotaINI.Enabled := True;
        E_FrotaFIM.Enabled := True;
      end;
    1:begin
        E_PlacaINI.Enabled := True;
        E_PlacaFim.Enabled := True;
        E_FrotaINI.Enabled := True;
        E_FrotaFIM.Enabled := True;
      end;
    end;
    
end;

end.

