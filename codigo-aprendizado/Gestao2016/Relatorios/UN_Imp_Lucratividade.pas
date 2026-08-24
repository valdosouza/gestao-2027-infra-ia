unit UN_Imp_Lucratividade;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, StdCtrls, ExtCtrls, DBCtrls, Mask, DB, STQuery, ComCtrls, prmLucratividade;

type
   TFr_Imp_Lucratividade = class(TForm)
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Pnl_Parametro: TPanel;
    Label2: TLabel;
    Lb_Numero: TLabel;
    DBLCB_Empresa: TDBLookupComboBox;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    E_BuscaCodigo: TMaskEdit;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Gb_Tipodoc: TGroupBox;
    Chbx_Orcamento: TCheckBox;
    Chbx_PedidoFechado: TCheckBox;
    Chbx_NotaFiscal: TCheckBox;
    Chbx_PedidoAberto: TCheckBox;
    E_Numero: TEdit;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    Sb_Impostos: TSpeedButton;
    Pnl_botao: TPanel;
      procedure SB_ImprimirClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure Sb_ExportarClick(Sender: TObject);

      procedure ChBx_NomeClick(Sender: TObject);
      procedure ChBx_FantasiaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure chbx_EmpresasClick(Sender: TObject);
    procedure E_BuscaCodigoExit(Sender: TObject);
    procedure DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Chbx_OrcamentoClick(Sender: TObject);
    procedure Chbx_PedidoAbertoClick(Sender: TObject);
    procedure Chbx_PedidoFechadoClick(Sender: TObject);
    procedure Chbx_NotaFiscalClick(Sender: TObject);
    procedure Sb_ImpostosClick(Sender: TObject);
   private
    { Private declarations }
    function getParametros: TParamLucratividade;
    procedure LucratividadeGeral(Pc_Operacao,Pc_Caminho:String);
    procedure LucratividadePedidoAberto(Pc_Operacao,Pc_Caminho:String);
    procedure LucratividadePedidoFechado(Pc_Operacao,Pc_Caminho:String);
    procedure LucratividadeNotaFiscal(Pc_Operacao,Pc_Caminho:String);
    procedure LucratividadeOrcamento(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_ImagemBotao;
    procedure IniciaVariaveis;
    procedure AtivaTabelas;
   public
    { Public declarations }
    It_Visualizar :Boolean;
    It_Imprimir :Boolean;
    It_Exportar :Boolean;
     procedure Pc_PermissaoBotao(Pc_Menu: string);

     Function Fc_ValidaImpressao():boolean;
   end;

var
   Fr_Imp_Lucratividade: TFr_Imp_Lucratividade;

implementation

uses     Un_DM, Un_Excel, UN_Sistema, UN_Principal, env, Un_Regra_Negocio, reg_general_taxes, UN_MSG, RN_Cliente, UN_TabelasEmListas, un_RL_ReportLucratividade, un_RL_ReportLucratividadePedidoAberto, un_RL_ReportLucratividadePedidoFechado, un_RL_ReportLucratividadeNotaFiscal, un_RL_ReportLucratividadeOrcamento;

{$R *.dfm}


Function TFr_Imp_Lucratividade.Fc_ValidaImpressao():boolean;
Begin
  Result := Chbx_Orcamento.Checked or Chbx_PedidoAberto.Checked or Chbx_PedidoFechado.Checked or Chbx_NotaFiscal.Checked;
  if not Result then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Escolha o tipo do Documento.'+EOLN+EOLN+
                   'Verifique e tente novamente.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  End;
  if (Trim(E_Numero.Text)<>'') and (not Result) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Ao escolher o número, informe o tipo do Documento.'+EOLN+EOLN+
                   'Verifique e tente novamente.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;
end;

procedure TFr_Imp_Lucratividade.SB_ImprimirClick(Sender: TObject);
begin
  if Fc_ValidaImpressao then
  Begin
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    try
      Pc_LimpaQrPreviweMemoria;
      if Chbx_PedidoFechado.Checked and Chbx_NotaFiscal.Checked then
      Begin
        LucratividadeGeral('I','');
      End
      else
      if Chbx_PedidoAberto.Checked  then
      Begin
        LucratividadePedidoAberto('I','');
      End
      else
      if Chbx_PedidoFechado.Checked  then
      Begin
        LucratividadePedidoFechado('I','');
      End
      else
      if Chbx_NotaFiscal.Checked  then
      Begin
        LucratividadeNotaFiscal('I','');
      End
      else
      Begin
        if Chbx_Orcamento.Checked   then
          LucratividadeOrcamento('I','');
      End;
    finally
      Pc_ProcesoAguarde(Self,'F');
      Self.Enabled := True;
    end;
  end;
end;

procedure TFr_Imp_Lucratividade.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   if shift = [] then
   begin
      case Key of
         VK_F2: if Sb_Exportar.Enabled then Sb_ExportarClick(Sender);
         VK_F3: if SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
         VK_Escape: if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
      end;
   end;
end;

procedure TFr_Imp_Lucratividade.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_Lucratividade.Sb_ExportarClick(Sender: TObject);
Var
  Lc_CAminho : String;
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    IF (Fr_Principal.SaveDialogo.Execute) then
    Begin
     if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
     Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
      Lc_CAminho := Fr_Principal.SaveDialogo.FileName;

      if Chbx_PedidoFechado.Checked and Chbx_NotaFiscal.Checked then
      Begin
        LucratividadeGeral('E',Lc_CAminho);
      End
      else
      if Chbx_PedidoAberto.Checked  then
      Begin
        LucratividadePedidoAberto('E',Lc_CAminho);
      End
      else
      if Chbx_PedidoFechado.Checked  then
      Begin
        LucratividadePedidoFechado('E',Lc_CAminho);
      End
      else
      if Chbx_NotaFiscal.Checked  then
      Begin
        LucratividadeNotaFiscal('E',Lc_CAminho);
      End
      else
      Begin
        if Chbx_Orcamento.Checked   then
          LucratividadeOrcamento('E',Lc_CAminho);
      End;
    end;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;



procedure TFr_Imp_Lucratividade.ChBx_NomeClick(Sender: TObject);
begin
  Pc_ListaClienteDbLookUpComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa)
end;

procedure TFr_Imp_Lucratividade.ChBx_FantasiaClick(Sender: TObject);
begin
  Pc_ListaClienteDbLookUpComboBox('EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
end;


procedure TFr_Imp_Lucratividade.Pc_PermissaoBotao(Pc_Menu: string);
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

procedure TFr_Imp_Lucratividade.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  IniciaVariaveis;
  Pc_PermissaoBotao('Lucratividade');
  AtivaTabelas;
end;

function TFr_Imp_Lucratividade.getParametros: TParamLucratividade;
begin
  Result := TParamLucratividade.Create;
  with Result do
  Begin
    Periodo := ChBx_Periodo.Checked;
    DataInicial := E_Data_Ini.DateTime;
    DataFinal := E_Data_Fim.DateTime;
    if Trim(DBLCB_Empresa.Text) <> '' then
      CodigoCliente := DBLCB_Empresa.KeyValue;

    NomeCliente := '';
    CodigoTransportadora := 0;
    if Dblcb_Mha_Empresa.Text = '' then
      CodigoEstabelecimento := 0
    else
      CodigoEstabelecimento := Dblcb_Mha_Empresa.KeyValue;

    VendedorCliente     := 0;
    VendedorPedido      := 0;
    NegociosEspecificos := '';
    NumeroDocumento     := E_Numero.Text;
    //Parametros para Produtos
    CodigoGrupo         := 0;
    CodigoSubGrupo      := 0;
    CodigoMarca         := 0;
    CodigoProduto       := 0;
    DescricaoProduto    := '';
  end;
end;

procedure TFr_Imp_Lucratividade.IniciaVariaveis;
begin
  E_Data_INI.Date := Date;
  E_Data_FIM.Date := Date;
  ChBx_Periodo.Checked:= Fc_Marca_data_pesquisa;
end;

procedure TFr_Imp_Lucratividade.LucratividadeGeral(Pc_Operacao,
  Pc_Caminho: String);
Var
  Lc_Form : TRL_ReportLucratividade;
begin
  Try
    Lc_Form := TRL_ReportLucratividade.create(nil);
    Lc_Form.Parametros := getParametros;
    Lc_Form.Qrpt.ReportTitle := 'LUCRATIVIDADE GERAL';
    Lc_Form.Qrpt.Preview;
  Finally
    FreeAndNil(Lc_Form);
  End;

end;

procedure TFr_Imp_Lucratividade.LucratividadeNotaFiscal(Pc_Operacao,
  Pc_Caminho: String);
Var
  Lc_Form : TRL_ReportLucratividadeNotaFiscal;
begin
  Try
    Lc_Form := TRL_ReportLucratividadeNotaFiscal.create(nil);
    Lc_Form.Parametros := getParametros;
    Lc_Form.Qrpt.ReportTitle := 'LUCRATIVIDADE - NOTA FISCAL';
    Lc_Form.Qrpt.Preview;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Imp_Lucratividade.LucratividadeOrcamento(Pc_Operacao,
  Pc_Caminho: String);
Var
  Lc_Form : TRL_ReportLucratividadeOrcamento;
begin
  Try
    Lc_Form := TRL_ReportLucratividadeOrcamento.create(nil);
    Lc_Form.Parametros := getParametros;
    Lc_Form.Qrpt.ReportTitle := 'LUCRATIVIDADE - ORÇAMENTO';
    Lc_Form.Qrpt.Preview;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Imp_Lucratividade.LucratividadePedidoAberto(Pc_Operacao,
  Pc_Caminho: String);
Var
  Lc_Form : TRL_ReportLucratividadePedidoAberto;
begin
  Try
    Lc_Form := TRL_ReportLucratividadePedidoAberto.create(nil);
    Lc_Form.Parametros := getParametros;
    Lc_Form.Qrpt.ReportTitle := 'LUCRATIVIDADE - PEDIDO EM ABERTO';
    Lc_Form.Qrpt.Preview;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Imp_Lucratividade.LucratividadePedidoFechado(Pc_Operacao,
  Pc_Caminho: String);
Var
  Lc_Form : TRL_ReportLucratividadePedidoFEchado;
begin
  Try
    Lc_Form := TRL_ReportLucratividadePedidoFEchado.create(nil);
    Lc_Form.Parametros := getParametros;
    Lc_Form.Qrpt.ReportTitle := 'LUCRATIVIDADE - PEDIDO FECHADO';
    Lc_Form.Qrpt.Preview;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Imp_Lucratividade.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Imp_Lucratividade.AtivaTabelas;
begin
  if DM.Qr_Impostos.Transaction.InTransaction then DM.Qr_Impostos.Transaction.Commit;
  if not DM.Qr_Impostos.Transaction.InTransaction then DM.Qr_Impostos.Transaction.StartTransaction;
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  Pc_AbreListaCliente('EMP_NOME');
  DM.Qr_Impostos.Active := False;
  DM.Qr_Impostos.Active := True;

end;

procedure TFr_Imp_Lucratividade.chbx_EmpresasClick(Sender: TObject);
begin
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);  
end;

procedure TFr_Imp_Lucratividade.E_BuscaCodigoExit(Sender: TObject);
begin
  DBLCB_Empresa.KeyValue := StrToIntDef(E_BuscaCodigo.Text,0);
end;

procedure TFr_Imp_Lucratividade.DBLCB_EmpresaKeyDown(Sender: TObject;
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

procedure TFr_Imp_Lucratividade.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Imp_Lucratividade.Chbx_OrcamentoClick(Sender: TObject);
begin
  if (Chbx_Orcamento.Checked) then
    Begin
    Chbx_PedidoAberto.Checked := False;
    Chbx_PedidoFechado.Checked := False;
    Chbx_NotaFiscal.Checked := False;
    end;
end;

procedure TFr_Imp_Lucratividade.Chbx_PedidoAbertoClick(Sender: TObject);
begin
  if Chbx_PedidoAberto.Checked then
    Begin
    Chbx_Orcamento.Checked := False;
    Chbx_PedidoFechado.Checked := False;
    Chbx_NotaFiscal.Checked := False;
    end;
end;

procedure TFr_Imp_Lucratividade.Chbx_PedidoFechadoClick(Sender: TObject);
begin
  if Chbx_PedidoFechado.Checked then
    Begin
    Chbx_PedidoAberto.Checked := False;
    Chbx_Orcamento.Checked := False;
    end;
end;

procedure TFr_Imp_Lucratividade.Chbx_NotaFiscalClick(Sender: TObject);
begin
  if Chbx_NotaFiscal.Checked then
    Begin
    Chbx_PedidoAberto.Checked := False;
    Chbx_Orcamento.Checked := False;
    end;
end;

procedure TFr_Imp_Lucratividade.Sb_ImpostosClick(Sender: TObject);
Var
  Lc_Form : TRegGeneralTaxes;
begin
  Lc_Form := TRegGeneralTaxes.Create(nil);
  Try
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
    AtivaTabelas;
  End;
end;

procedure TFr_Imp_Lucratividade.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Geral;
    Sb_Exportar.Glyph := (Fc_CarregaImagemBotao('EXPORTAR'));
    SB_Imprimir.Glyph := (Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
  END;
end;
end.

