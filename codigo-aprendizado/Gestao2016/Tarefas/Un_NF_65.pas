unit Un_NF_65;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, ControllerRestaurante, Vcl.Menus, Vcl.DBCtrls, Vcl.ComCtrls, Un_Fm_Itens_Pedido;


type
  TFr_NF_65 = class(TForm)
    Qr_Nota: TSTQuery;
    DS_Nota: TDataSource;
    Mnu_Operacao: TMainMenu;
    Mnu_Operacao_Tarefas: TMenuItem;
    Itm_Autorizar: TMenuItem;
    Itm_CadastroDestinatrio: TMenuItem;
    N3: TMenuItem;
    Panel2: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label5: TLabel;
    E_Nota: TDBEdit;
    E_Natureza: TDBEdit;
    E_Cfop: TDBEdit;
    E_Dt_Emissao: TDBEdit;
    E_RazaoSocial: TDBEdit;
    E_Cnpj_CPf: TDBEdit;
    E_CodCli: TDBEdit;
    Panel3: TPanel;
    Label17: TLabel;
    E_VL_Nota: TDBEdit;
    Panel1: TPanel;
    Sb_Sair_0: TSpeedButton;
    Sair1: TMenuItem;
    ImprimirPedido1: TMenuItem;
    N1: TMenuItem;
    Pg_Itens: TPageControl;
    tbs_itens: TTabSheet;
    tbs_outras: TTabSheet;
    Fm_Itens_Pedido: TFm_Itens_Pedido;
    Label40: TLabel;
    Label2: TLabel;
    Label43: TLabel;
    sb_obs_nfe: TSpeedButton;
    E_Ped_Obs: TDBMemo;
    E_Vendedor: TDBEdit;
    E_Prazo: TDBEdit;
    Sb_Servico: TSpeedButton;
    RecalcularaComisso1: TMenuItem;
    N2: TMenuItem;
    Sb_Financeiro: TSpeedButton;
    Qr_NotaPED_CODIGO: TIntegerField;
    Qr_NotaPED_NUMERO: TIntegerField;
    Qr_NotaNFL_CODIGO: TIntegerField;
    Qr_NotaPED_CODFPG: TIntegerField;
    Qr_NotaPED_TIPO: TIntegerField;
    Qr_NotaNAT_DESCRICAO: TStringField;
    Qr_NotaNAT_CFOP: TStringField;
    Qr_NotaEMP_CODIGO: TIntegerField;
    Qr_NotaEMP_NOME: TStringField;
    Qr_NotaEMP_CNPJ: TStringField;
    Qr_NotaNFL_DT_EMISSAO: TDateField;
    Qr_NotaNFL_BS_ICMS: TBCDField;
    Qr_NotaNFL_VL_ICMS: TBCDField;
    Qr_NotaNFL_BS_ICMS_SUBST: TBCDField;
    Qr_NotaNFL_VL_ICMS_SUBST: TBCDField;
    Qr_NotaNFL_VL_TL_NOTA: TBCDField;
    Qr_NotaNFC_CODIGO: TIntegerField;
    Qr_NotaPED_OBS: TBlobField;
    Qr_NotaCLB_NOME: TStringField;
    Qr_NotaPED_PRAZO: TStringField;
    RegistraNmerodeSrie1: TMenuItem;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Itm_CadastroDestinatrioClick(Sender: TObject);
    procedure Qr_NotaAfterOpen(DataSet: TDataSet);
    procedure Itm_AutorizarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure ImprimirPedido1Click(Sender: TObject);
    procedure sb_obs_nfeClick(Sender: TObject);
    procedure Sb_ServicoClick(Sender: TObject);
    procedure RecalcularaComisso1Click(Sender: TObject);
    procedure Sb_FinanceiroClick(Sender: TObject);
    procedure Fm_Itens_PedidoRegistraNmerodolote1Click(Sender: TObject);
    procedure RegistraNmerodeSrie1Click(Sender: TObject);
  private
    { Private declarations }
     It_Supervisor : Boolean;
  public
    It_Tipo_Nota : String;
    It_Oper_Reg : String;
    It_Cd_Nota : Integer;
    It_Nr_Nota : String;
    It_cd_Pedido : Integer;
    It_Nfe_Cancelada : Boolean;
    IT_Cd_Empresa : Integer;
    //controle de menu;
    procedure Pc_AtivarTabelas;
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;
  end;

var
  Fr_NF_65: TFr_NF_65;

implementation

uses
Un_DM, UN_MSG, UN_Sistema, un_VehicleSo, Un_Clta_Csto, Un_Fich_Fin_Cli, Un_Tecnicos, Un_Fc_Sored_Procedures, un_Obs_nfe, Un_Nfe_Complementar, Un_Funcoes, Un_Imp_Mod_Impressao, Un_Fc_Comissao, Un_Regra_Negocio, Un_Produtos, RN_Permissao, UN_Principal, env, RN_Inventario, RN_Estoque, Un_Ctrl_Lote_Entrada, Un_Ctrl_Lote_Saida, Un_CopiaPedidoNota, Un_Parcelamento, RN_NotaFiscalEletronica3X, RN_Cliente, RN_Empresa, RN_NotaFiscal, Un_Produto_Series, UN_Receber_Multipla, tas_gera_nfce_autorizacao;

{$R *.dfm}

procedure TFr_NF_65.Pc_FormataTela;
Begin
  Pg_Itens.ActivePage := tbs_itens;
end;

procedure TFr_NF_65.Fm_Itens_PedidoRegistraNmerodolote1Click(Sender: TObject);
var
  Lc_Escolha: Integer;
  Lc_Form:TForm;
begin
  try
    Lc_Form := TForm.Create(Fr_Ctrl_Lote_Saida);
    Application.CreateForm(TFr_Ctrl_Lote_Saida, Lc_Form);
    TFr_Ctrl_Lote_Saida(Lc_Form).It_Cd_Item := Fm_Itens_Pedido.Qr_ItensNota.FieldByname('ITF_CODIGO').AsInteger;
    TFr_Ctrl_Lote_Saida(Lc_Form).It_Tipo := '1';
    TFr_Ctrl_Lote_Saida(Lc_Form).it_Cd_produto := Fm_Itens_Pedido.Qr_ItensNota.FieldByname('ITF_CODPRO').AsInteger;
    TFr_Ctrl_Lote_Saida(Lc_Form).It_Cd_Empresa := Qr_Nota.FieldByName('EMP_CODIGO').AsInteger;
    TFr_Ctrl_Lote_Saida(Lc_Form).It_Qtde_Lote := Fm_Itens_Pedido.Qr_ItensNota.FieldByname('ITF_QTDE').AsFloat;
    TFr_Ctrl_Lote_Saida(Lc_Form).ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_NF_65.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_Escape : if  Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_NF_65.Pc_AtivarTabelas;
begin

end;


procedure TFr_NF_65.Pc_IniciaVariaveis;
Begin
  if It_Cd_Nota > 0 then
  Begin
    if not Qr_Nota.Active then
    Begin
      Qr_Nota.Active := False;
      Qr_Nota.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
      Qr_Nota.Active := True;
    end;
  end;
end;

procedure TFr_NF_65.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_ImagemBotao;
  Pc_IniciaVariaveis;
end;

procedure TFr_NF_65.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;



procedure TFr_NF_65.Itm_CadastroDestinatrioClick(Sender: TObject);
begin
  Fc_AbreTelaEmpresa(Qr_Nota.FieldByName('EMP_CODIGO').AsInteger );
end;

procedure TFr_NF_65.Pc_PermissaoBotao(Pc_Menu: string);
begin

end;

procedure TFr_NF_65.Qr_NotaAfterOpen(DataSet: TDataSet);
begin
  Fm_Itens_Pedido.It_cd_Pedido := Qr_Nota.FieldByName('PED_CODIGO').AsInteger;
  Fm_Itens_Pedido.It_Tp_Operacao := 'V';
  Fm_Itens_Pedido.Pc_FormataTela;
  Fm_Itens_Pedido.Pc_AtivaTabela;
  Fm_Itens_Pedido.Pc_PreencheGrade;
end;

procedure TFr_NF_65.RecalcularaComisso1Click(Sender: TObject);
Var
  Lc_Cd_Pedido : Integer;
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Recalcular Comissão','RECALCULAR COMISSÃO',GB_Cd_Usuario,'S') then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja recalcular a comissão do Pedido Nº '+ Qr_Nota.FieldByName('PED_NUMERO').AsString +'.'+EOLN+EOLN+
                       'Confirmar o recálculo ?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
    begin
      //Geração de Comissão no faturamento
      Lc_Cd_Pedido := Qr_Nota.FieldByName('PED_CODIGO').AsInteger;
      Pc_Construtor_Comissao(DM.IBT_Consulta);
      Pc_DeletaComissao(DM.IBT_Consulta, Lc_Cd_Pedido,0);
      Pc_Deleta_Vdo_Pedido(DM.IBT_Consulta, Lc_Cd_Pedido,0,'');
      Pc_Registra_Vdo_Pedido(DM.IBT_Consulta, Lc_Cd_Pedido);
      if Fc_Tb_Geral('L','TP_COMISSAO','') ='F' then
      Begin
        Pc_Gerar_Comissao_Vda_Fat(DM.IBT_Consulta, Lc_Cd_Pedido);
        Pc_Gerar_Comissao_Srv_Fat(DM.IBT_Consulta, Lc_Cd_Pedido);
        Pc_Gerar_Comissao_Srv_Vdo_Fat(DM.IBT_Consulta, Lc_Cd_Pedido);
      end;
      Pc_Destrutor_Comissao;
      MensagemPadrao(MENSAGEM,'S U C E S S O !.'+EOLN+EOLN+
                     'A comissão foi recalculada com sucesso.'+EOLN,
                    ['OK'],[bEscape],mpInformacao);
    end;
  end;
end;

procedure TFr_NF_65.RegistraNmerodeSrie1Click(Sender: TObject);
begin
  with Fm_Itens_Pedido do
  BEgin
    if Qr_ItensNota.RecordCount > 0 then
    Begin
      if not Assigned(Fr_Produto_Serie) then
        Application.CreateForm(TFr_Produto_Serie, Fr_Produto_Serie);
      Fr_Produto_Serie.Faturado := True;
      Fr_Produto_Serie.Tag := 2;
      Fr_Produto_Serie.It_cd_Item := Qr_ItensNota.fieldByname('ITF_CODIGO').AsInteger;
      Fr_Produto_Serie.It_cd_Produto := Qr_ItensNota.fieldByname('ITF_CODPRO').AsInteger;
      Fr_Produto_Serie.It_Qt_Produto := Qr_ItensNota.fieldByname('ITF_QTDE').AsFloat;
      Fr_Produto_Serie.ShowModal;
     End;
  End;
end;

procedure TFr_NF_65.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_NF_65.Sb_FinanceiroClick(Sender: TObject);
Var
  Lc_form : TFr_Receber_multipla;
begin
  if Fc_VerificaPermissao('Fr_Receber_Multipla','Contas a Receber','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    try
      Lc_form := TFr_Receber_multipla.create(self);
      Lc_form.E_BuscaPedido.Text := Qr_Nota.FieldByName('PED_NUMERO').AsString;
      Lc_form.ChBx_Periodo.Checked := fALSE;
      Lc_form.Cb_Situacao.ItemIndex := 4;
      Lc_form.showModal;
    finally
      FreeAndNil(Lc_form);
    end;
  End;
end;

procedure TFr_NF_65.sb_obs_nfeClick(Sender: TObject);
begin
  if not Assigned(fr_obs_nfe) then Application.CreateForm(tfr_obs_nfe,fr_obs_nfe);
  fr_obs_nfe.it_cd_nfl:=Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
  fr_obs_nfe.showmodal
end;

procedure TFr_NF_65.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_NF_65.Sb_ServicoClick(Sender: TObject);
Var
  Lc_Form : TFr_VehicleSo;
begin
  Lc_Form := TFr_VehicleSo.Create(nil);
  TRy
    with Lc_Form do
    begin
      with OrdemServico do
      Begin
        Registro.CodigoEstabelecimento := Gb_Codmha;
        Registro.CodigoCotacao := 0;
        Registro.CodigoPedido := Qr_Nota.FieldByname('PED_CODIGO').AsInteger;
        with Vehicle do
        Begin
          Registro.CodigoEmpresa := Qr_Nota.FieldByname('EMP_CODIGO').AsInteger;
        End;
      End;
      ShowModal;
    End;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_NF_65.ImprimirPedido1Click(Sender: TObject);
Var
  Lc_Imp: TimpModImpressao;
begin
  Try
    Lc_Imp := TimpModImpressao.create(nil);
    Self.Enabled := False;
    if Fc_VerificaPermissao('Fr_Nota_Fiscal','Imprimir Nora Fiscal','IMPRIMIR',GB_Cd_Usuario,'S') then
    Begin
      Lc_Imp.Pc_Imp_Tipo(Qr_Nota.FieldByName('PED_TIPO').AsInteger,Qr_Nota.FieldByName('PED_CODIGO').AsInteger,Qr_Nota.FieldByName('NFL_CODIGO').AsInteger);
    end;
  Finally
    FreeandNil(Lc_Imp);
    Self.Enabled := True;
  end;
end;

procedure TFr_NF_65.Itm_AutorizarClick(Sender: TObject);
Var
  Lc_Restaurante : TControllerRestaurante;
  Lc_Form : TTasGeraNfceautorizacao;
Begin
  Lc_Restaurante := TControllerRestaurante.Create(Self);
  Lc_Form := TTasGeraNfceautorizacao.Create(Self);
  Try
    with Lc_Restaurante.Registro do
    Begin
      CodigoPedido := Qr_Nota.FieldByName('PED_CODIGO').AsInteger;
      CodigoEstabelecimento := Gb_CodMha;
      Lc_Restaurante.getbyId;
      TRy
        Lc_Form.It_Cd_Pedido      := Qr_Nota.FieldByName('PED_CODIGO').AsInteger;
        Lc_Form.It_cd_Cliente     := Qr_Nota.FieldByName('EMP_CODIGO').AsInteger;
        Lc_Form.It_cd_Consumidor  := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
        Lc_Form.It_Cd_Nota        := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
        Lc_Form.It_Nr_Nota        := Qr_Nota.FieldByName('NFC_CODIGO').AsInteger;
        Lc_Form.It_Nf_Terceiro    := FAlse;
        Lc_Form.ValorRecebido     := ValorRecebido;
        Lc_Form.ValorTroco        := ValorTroco;

        //Operação Normal
        Pc_CarregaDadosEmitente(true);
        Lc_Form.TipoOperacao := 'NFC-e';
        Lc_Form.ShowModal;
      except
        on e:Exception do
          MensagemPadrao('NMensagem de erro', ATENCAO + EOLN + EOLN +
                         e.Message + EOLN +
                         'Informe ao Desenvolvedor do Sistema.' + EOLN,
                         ['OK'], [bEscape], mpErro);
      End;
      Pc_IniciaVariaveis;
    End;
  Finally
    FreeAndNil(Lc_Restaurante);
    FreeAndNil(Lc_Form);
    SetWindowPos(Gb_Handle,Hwnd_TopMost,0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or  SWP_SHOWWINDOW);

  End;
end;

end.



