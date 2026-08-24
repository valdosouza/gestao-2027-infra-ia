unit UN_Imp_Comissao;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Un_Fm_ListaColaboradores, Vcl.ComCtrls, Vcl.DBCtrls, prmComissao;

type
   TFr_Imp_Comissao = class(TForm)
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    Panel1: TPanel;
    Label4: TLabel;
    RG_Tipo: TRadioGroup;
    CB_Tipo: TComboBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Fm_ListaColaborador: TFm_ListaColaboradores;
    procedure SB_ImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure Sb_ExportarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure chbx_EmpresasClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
   private
    { Private declarations }
   public
    { Public declarations }
    It_Visualizar :Boolean;
    It_Imprimir :Boolean;
    It_Exportar :Boolean;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;

    procedure Pc_RESUMIDA(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_DETALHADA(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_PREVISAO(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_BAIXA_NO_FINANCEIRO(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_VENDEDOR_CIDADE(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_COMISSAO_CUPOM;
    function getParametros: TParamComissao;
   end;

var
   Fr_Imp_Comissao: TFr_Imp_Comissao;

implementation

uses     UN_RL_Comi_Detal, Un_DM, Un_Excel, UN_Sistema, UN_RL_Comi_Resum, Un_RL_Comi_Previsao, UN_Principal, env, UN_MSG, Un_RL_Financeiro_Comissao, Un_Regra_Negocio, Un_RL_Comi_Detal_Vend_Cidade, Un_Imp_Mod_Impressao;

{$R *.dfm}

function TFr_Imp_Comissao.getParametros: TParamComissao;
begin
  Result := TParamComissao.Create;
  with Result do
  Begin
    SituacaoComissao := '';
    case RG_Tipo.ItemIndex of
      0:SituacaoComissao := 'Paga';
      1:SituacaoComissao := 'Não Paga';
      2:SituacaoComissao := 'Todas';
    end;
    Periodo := ChBx_Periodo.Checked;
    DataInicial := E_Data_Ini.DateTime;
    DataFinal := E_Data_Fim.DateTime;

    if Trim(Fm_ListaColaborador.Dblcb_Vendedor.Text) <> '' then
    Begin
      CodigoVendedor := Fm_ListaColaborador.Dblcb_Vendedor.KeyValue;
      NomeVendedor :=   Fm_ListaColaborador.Dblcb_Vendedor.Text;
    End;
    CodigoEstabelecimento := Gb_CodMha;
    Ordenacao := ' ORDER BY CLB_NOME,COM_DT_VENDA';
  end;
end;

procedure TFr_Imp_Comissao.Pc_RESUMIDA(Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Form : TRl_Comi_Resum;
Begin
  try
    Lc_Form := TRl_Comi_Resum.create(Nil);
    Lc_Form.Parametros := getParametros;
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Lc_Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      Lc_Form.Pc_Busca;
      Fr_Excel.Pc_Excel(Lc_Form.Qr_Comissao, Pc_CAminho);
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Imp_Comissao.Pc_DETALHADA(Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Form : TRl_Comi_Detal;
Begin
  try
    Lc_Form := TRl_Comi_Detal.create(nil);
    Lc_Form.Parametros := getParametros;
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Lc_Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      Lc_Form.Pc_Busca;
      Fr_Excel.Pc_Excel(Lc_Form.Qr_Comissao, Pc_CAminho);
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Imp_Comissao.Pc_PREVISAO(Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Form : TRL_Comi_Previsao;
Begin
  try
    Lc_Form := TRL_Comi_Previsao.create(nil);
    Lc_Form.Parametros := getParametros;
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Lc_Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      Lc_Form.Pc_Busca;
      Fr_Excel.Pc_Excel(Lc_Form.Qr_Comissao, Pc_CAminho);
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;

end;

procedure TFr_Imp_Comissao.Pc_BAIXA_NO_FINANCEIRO(Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Form : TRL_Financeiro_Comissao;
Begin
  try
    Lc_Form := TRL_Financeiro_Comissao.create(nil);
    Lc_Form.Parametros := getParametros;
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Lc_Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      Lc_Form.Pc_Busca;
      Fr_Excel.Pc_Excel(Lc_Form.Qr_Duplicatas, Pc_CAminho);
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Imp_Comissao.Pc_VENDEDOR_CIDADE(Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Form : TRL_Comi_Detal_Vend_Cidade;
Begin
  try
    Lc_Form := TRL_Comi_Detal_Vend_Cidade.create(nil);
    Lc_Form.Parametros := getParametros;
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Lc_Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      Lc_Form.Pc_Busca;
      Fr_Excel.Pc_Excel(Lc_Form.Qr_Comissao, Pc_CAminho);
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;

end;

procedure TFr_Imp_Comissao.Pc_COMISSAO_CUPOM;
Var
  Lc_Imp: TimpModImpressao;
begin
  if Fm_ListaColaborador.Dblcb_Vendedor.Text = '' then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Para este relatório é obrigatório informar o colaborador.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    exit;
  End;

  Try
    Lc_Imp := TimpModImpressao.create(nil);
    Self.Enabled := False;
    Lc_Imp.PrintComissaoMotoboy(getParametros);
  Finally
    FreeandNil(Lc_Imp);
    Self.Enabled := True;
  end;

end;


procedure TFr_Imp_Comissao.SB_ImprimirClick(Sender: TObject);
begin
  Pc_LimpaQrPreviweMemoria;
  Fc_Aq_Geral('G','COMISSAO','DATAINI',DateToStr(E_Data_Ini.Date));
  Fc_Aq_Geral('G','COMISSAO','DATAFIM',DateToStr(E_Data_Fim.Date));
  case CB_Tipo.ItemIndex of
    0:Begin
        Pc_RESUMIDA('I','');
      end;
    1:Begin
        Pc_DETALHADA('I','');
      end;
    2:Begin
        Pc_PREVISAO('I','');
      end;
    3:Begin
        Pc_BAIXA_NO_FINANCEIRO('I','');
      end;
    4:Begin
        Pc_VENDEDOR_CIDADE('I','');
      end;
    5:Begin
        Pc_COMISSAO_CUPOM;
      end;
    end;
end;

procedure TFr_Imp_Comissao.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFr_Imp_Comissao.FormCreate(Sender: TObject);
begin
  Fm_ListaColaborador.ListaColaborador;
  RG_Tipo.ItemIndex := 0;
  E_Data_Ini.Date := StrToDateDef(Fc_Aq_Geral('L','COMISSAO','DATAINI',DateToStr(E_Data_Ini.Date)),Date);
  E_Data_Fim.Date := StrToDateDef(Fc_Aq_Geral('L','COMISSAO','DATAINI',DateToStr(E_Data_Fim.Date)),Date);
  ChBx_Periodo.Checked:= Fc_Marca_data_pesquisa;   
end;

procedure TFr_Imp_Comissao.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_Comissao.Sb_ExportarClick(Sender: TObject);
var
  Lc_CAminho: string;
  Lc_Form : TRl_Comi_Detal;
begin
  if Fr_Principal.SaveDialogo.Execute then
  Begin
    if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
    Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
    Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
    case CB_Tipo.ItemIndex of
    0:Begin
        Pc_RESUMIDA('E',Lc_CAminho);
      end;
    1:Begin
        Pc_DETALHADA('E',Lc_CAminho);
      end;
    2:Begin
        Pc_PREVISAO('E',Lc_CAminho);
      end;
    3:Begin
        Pc_BAIXA_NO_FINANCEIRO('E',Lc_CAminho);
      end;
    4:Begin
        Pc_VENDEDOR_CIDADE('E',Lc_CAminho);
      end;
    5:Begin
          MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                         'Não tem opção de exportar neste relatório.' + EOLN +
                         'Clique em Ok para Continuar.' + EOLN,
                         ['OK'], [bEscape], mpInformacao);

      end;
    end;
  end;
end;

procedure TFr_Imp_Comissao.Pc_PermissaoBotao(Pc_Menu: string);
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

procedure TFr_Imp_Comissao.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  Pc_PermissaoBotao('Comissões');
  CB_Tipo.ItemIndex := 0;
end;

procedure TFr_Imp_Comissao.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Imp_Comissao.chbx_EmpresasClick(Sender: TObject);
begin
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);  
end;

procedure TFr_Imp_Comissao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Imp_Comissao.Pc_ImagemBotao;
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

