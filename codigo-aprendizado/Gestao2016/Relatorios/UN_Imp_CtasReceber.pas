unit UN_Imp_CtasReceber;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Un_Fm_FormaPagto, Vcl.ComCtrls, Vcl.DBCtrls, prmCtaReceber;

type
   TFr_Imp_CtasReceber = class(TForm)
      Ds_Cliente: TDataSource;
      Qr_Empresa: TSTQuery;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    Panel1: TPanel;
    Label2: TLabel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    DBLCB_Empresa: TDBLookupComboBox;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    E_BuscaCodigo: TMaskEdit;
    RG_Tipo: TRadioGroup;
    RG_Conta: TRadioGroup;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    GroupBox2: TGroupBox;
    Rb_Vend_Cliente: TRadioButton;
    Rb_Vend_Pedido: TRadioButton;
    DBLCB_Vendedor: TDBLookupComboBox;
    Fm_FormaPagto: TFm_FormaPagto;
    Panel2: TPanel;
    Label4: TLabel;
    LBx_TipoRelatorio: TListBox;
      procedure SB_ImprimirClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure Sb_ExportarClick(Sender: TObject);
      procedure Qr_EmpresaAfterOpen(DataSet: TDataSet);
      procedure ChBx_NomeClick(Sender: TObject);
      procedure ChBx_FantasiaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure chbx_EmpresasClick(Sender: TObject);
    procedure E_BuscaCodigoExit(Sender: TObject);
    procedure DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure LBx_TipoRelatorioClick(Sender: TObject);
   private
    { Private declarations }
   public
    { Public declarations }
    It_Imprimir:Boolean;
    It_Exportar:Boolean;
    It_Visualizar:Boolean;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;
    function getParametros:TParamCtaReceber;
    procedure Pc_CtaReceberVencimento(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_CtaReceberCliente(Pc_Operacao,Pc_Caminho:String);

   end;

var
   Fr_Imp_CtasReceber: TFr_Imp_CtasReceber;

implementation

uses      Un_Excel, UN_Sistema, Un_frx_ReportCtaReceberVencimento, Un_frx_ReportCtaReceberCliente, UN_RL_Contas_Receber_P, UN_RL_Cta_Rec_P, UN_RL_Cta_Rec_P_Res, UN_MSG, UN_RL_Cto_RecFoPgto, Un_RL_Cto_RecSaldo, un_rl_resumo_forma_pagamento, UN_Principal, env, Un_Regra_Negocio, RN_FormaPagto, RN_Cliente, UN_TabelasEmListas;
{$R *.dfm}


function TFr_Imp_CtasReceber.getParametros: TParamCtaReceber;
begin
  Result := TParamCtaReceber.Create;
  with Result do
  Begin
    case RG_Tipo.ItemIndex  of
      0:TipoData := 'VENCER';
      1:TipoData := 'VENCIDA';
      2:TipoData := 'TODOS';
    end;
    case RG_Conta.ItemIndex  of
      0:TipoConta := 'NORMAL';
      1:TipoConta := 'DESTINADA';
      2:TipoConta := 'DESCONTADA';
      3:TipoConta := 'TODOS';
    end;
    Periodo := ChBx_Periodo.Checked;
    DataInicial := E_Data_Ini.DateTime;
    DataFinal := E_Data_Fim.DateTime;
    if Trim(DBLCB_Empresa.Text) <> '' then
      CodigoCliente := DBLCB_Empresa.KeyValue;
    if Trim(Fm_FormaPagto.DBLCB_FormaPagto.Text) <> '' then
      CodigoFormaPagamento := Fm_FormaPagto.DBLCB_FormaPagto.KeyValue;
    if Rb_Vend_Cliente.Checked and (Trim(DBLCB_Vendedor.Text) <> '') then
      CodigoVendedorCliente := DBLCB_Vendedor.KeyValue;
    if Rb_Vend_Pedido.Checked and (Trim(DBLCB_Vendedor.Text) <> '') then
      CodigoVendedorPedido := DBLCB_Vendedor.KeyValue;
    IF ChBx_Nome.Checked then
    Begin
      Ordenacao := ' FIN_DT_VENCIMENTO,EMP_NOME ';
      CampoNomeCliente := 'EMP_NOME';
    End
    else
    Begin
      Ordenacao := ' FIN_DT_VENCIMENTO,EMP_FANTASIA ';
      CampoNomeCliente := 'EMP_FANTASIA';
    End;
    CodigoEstabelecimento := Gb_CodMha;
  end;
end;

procedure TFr_Imp_CtasReceber.LBx_TipoRelatorioClick(Sender: TObject);
Var
  Relatorio : String;
begin
  Relatorio := LBx_TipoRelatorio.Items[LBx_TipoRelatorio.ItemIndex];
  IF (Relatorio ='PRODUTOS') OR (Relatorio ='PRODUTOS RESUMIDO') OR (Relatorio ='PRANCHETA') THEN
  Begin
    Fm_FormaPagto.Enabled := False;
  End
  ELSE
  Begin
    Fm_FormaPagto.Enabled := True;
    Fm_FormaPagto.Pc_Listar(3,False,0);
  End;
end;

procedure TFr_Imp_CtasReceber.Pc_CtaReceberVencimento(Pc_Operacao,Pc_Caminho:String);
Var
  Form : Tfrx_ReportCtaReceberVencimento;
Begin
  Try
    Try
      Form := Tfrx_ReportCtaReceberVencimento.create(nil);
      Form.Parametros := getParametros;
      //Form.Parametros.Ordenacao := ' FIN_DT_VENCIMENTO,EMP_NOME ';
      Form.Parametros.Ordenacao := ' 2,5 ';
      if Pc_Operacao = 'I' then // IMPRIMIR
      Begin
        Form.Caption := 'RELAÇÃO DE CONTAS A RECEBER AGRUPADOS POR VENCIMENTO';
        Form.buscar;
        Form.frxBase.PrepareReport;
        Form.frxBase.ShowReport;
      end
      else
      Begin
        Form.Buscar;
        Fr_Excel.Pc_Excel(Form.Qr_Consulta,Pc_Caminho);
      End;
    Except
      on e:Exception do
        raise Exception.create('Erro ao efetuar a copia do arquivo:' + e.Message);

    End;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TFr_Imp_CtasReceber.Pc_CtaReceberCliente(Pc_Operacao,Pc_Caminho:String);
Var
  Form : Tfrx_ReportCtaReceberCliente;
Begin
  Try
    Form := Tfrx_ReportCtaReceberCliente.create(Self);
    Form.Parametros := getParametros;
    //Form.Parametros.Ordenacao := ' FIN_DT_VENCIMENTO,EMP_NOME ';
    Form.Parametros.Ordenacao := ' 5, 2 ';
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Form.Caption := 'RELAÇÃO DE CONTAS A RECEBER AGRUPADOS POR CLIENTE';
      //Envia conexãao do Banco
      Form.buscar;
      Form.frxBase.ShowReport;
    end
    else
    Begin
      Form.Buscar;
      Fr_Excel.Pc_Excel(Form.Qr_Consulta,Pc_Caminho);
    End;
  Finally
    FreeAndNil(Form);
  End;
End;


procedure TFr_Imp_CtasReceber.SB_ImprimirClick(Sender: TObject);
Var
  Lc_Cta_Rec_P : TRl_Cta_Rec_P;
  Lc_Cta_Rec_P_Res : TRL_Cta_Rec_P_Res;
  Lc_Contas_Receber_P :TRl_Contas_Receber_P;
  Lc_Cto_RecFoPgto : TRL_Cto_RecFoPgto;
  Lc_Cto_RecSaldo : TRL_Cto_RecSaldo;
  Lc_RESUMO_FORMA_Pagto : TRl_RESUMO_FORMA_Pagto;
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Pc_LimpaQrPreviweMemoria;
     case LBx_TipoRelatorio.ItemIndex of
      0:Pc_CtaReceberVencimento('I','');
      1:Pc_CtaReceberCliente('I','');
      2:begin
        if trim(DBLCB_Empresa.Text) <> '' then
        Begin
          try
            Lc_Cta_Rec_P := TRl_Cta_Rec_P.Create(Self);
            Lc_Cta_Rec_P.Qrpt.Preview;
          finally
            Lc_Cta_Rec_P.Close;
            FreeAndNil(Lc_Cta_Rec_P);
          end;
        end
        else
          Begin
          MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                         'Informe o Nome do Cliente.'+EOLN,
                        ['OK'],[bEscape],mpAlerta);
          end;
        end;
      3:begin
          try
            Lc_Cta_Rec_P_Res := TRL_Cta_Rec_P_Res.create(self);
            Lc_Cta_Rec_P_Res.Qrpt.Preview;
          finally
            Lc_Cta_Rec_P_Res.Close;
            FreeAndNil(Lc_Cta_Rec_P_Res);
          end;
        end;
      4:begin
        try
          Lc_Contas_Receber_P := TRl_Contas_Receber_P.create(self);
          Lc_Contas_Receber_P.Qrpt.Preview;
        finally
          Lc_Contas_Receber_P.Close;
          FreeAndNil(Lc_Contas_Receber_P);
        end;
        end;
      5:begin
         try
            Lc_Cto_RecFoPgto := TRL_Cto_RecFoPgto.Create(Self);
            Lc_Cto_RecFoPgto.Qrpt.Preview;
         finally
            Lc_Cto_RecFoPgto.Close;
            FreeAndNil(Lc_Cto_RecFoPgto);
         end;
        end;
      6:begin
          try
            Lc_Cto_RecSaldo := TRL_Cto_RecSaldo.create(self);
            Lc_Cto_RecSaldo.Pc_Busca;
            Lc_Cto_RecSaldo.Qrpt.Preview;
         finally
            Lc_Cto_RecSaldo.Close;
            FreeAndNil(Lc_Cto_RecSaldo);
         end;
        end;
        7:begin
            try
              Lc_RESUMO_FORMA_Pagto := TRl_RESUMO_FORMA_Pagto.Create(self);
              Lc_RESUMO_FORMA_Pagto.Pc_Busca;
              Lc_RESUMO_FORMA_Pagto.Qrpt.Preview;
            finally
              Lc_RESUMO_FORMA_Pagto.Close;
              FreeAndNil(Lc_RESUMO_FORMA_Pagto);
            end;
          end;
      end;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;

procedure TFr_Imp_CtasReceber.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFr_Imp_CtasReceber.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_CtasReceber.Sb_ExportarClick(Sender: TObject);
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
      case LBx_TipoRelatorio.ItemIndex of
        0:Pc_CtaReceberVencimento('E',Lc_CAminho);
        1:Pc_CtaReceberCliente('E',Lc_CAminho);
        else
        Begin
          MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                         'Opções para exportar não habilitada .'+EOLN+EOLN,
                        ['OK'],[bEscape],mpInformacao);
        end;
      end;
    End;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;

procedure TFr_Imp_CtasReceber.Qr_EmpresaAfterOpen(DataSet: TDataSet);
begin
   Qr_Empresa.FetchAll;
end;

procedure TFr_Imp_CtasReceber.ChBx_NomeClick(Sender: TObject);
begin
  Pc_ListaClienteDbLookUpComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa)
end;

procedure TFr_Imp_CtasReceber.ChBx_FantasiaClick(Sender: TObject);
begin
  Pc_ListaClienteDbLookUpComboBox('EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
end;

procedure TFr_Imp_CtasReceber.Pc_PermissaoBotao(Pc_Menu: string);
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

procedure TFr_Imp_CtasReceber.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_AbreListaCliente('EMP_NOME');
  RG_Tipo.ItemIndex := 0;
  LBx_TipoRelatorio.ItemIndex := 0;
  E_Data_INI.Date := Date;
  E_Data_FIM.Date := Date;
  Fm_FormaPagto.Pc_Listar(3,False,0);

  ChBx_Periodo.Checked:= Fc_Marca_data_pesquisa;  
  DM_ListaConsultas.Pc_ListaVendedor;
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  Pc_PermissaoBotao('Contas a Receber');
end;

procedure TFr_Imp_CtasReceber.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Imp_CtasReceber.chbx_EmpresasClick(Sender: TObject);
begin
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);  
end;

procedure TFr_Imp_CtasReceber.E_BuscaCodigoExit(Sender: TObject);
begin
  DBLCB_Empresa.KeyValue := StrToIntDef(E_BuscaCodigo.Text,0);
end;

procedure TFr_Imp_CtasReceber.DBLCB_EmpresaKeyDown(Sender: TObject;
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

procedure TFr_Imp_CtasReceber.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Imp_CtasReceber.Pc_ImagemBotao;
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

