unit Un_Imp_Orcamento;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, StdCtrls, ExtCtrls, DBCtrls, IniFiles, Mask, DB, STQuery, ComCtrls, QuickRpt, QRCtrls, Un_Fm_ListaMultiEmpresa, Un_Fm_ListaColaboradores, base_frame_list;

type
  TFr_Imp_Orcamento = class(TForm)
    Ds_Cliente: TDataSource;
    Qr_Exporta: TSTQuery;
    Qr_Cliente: TSTQuery;
    Label6: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Label5: TLabel;
    Label23: TLabel;
    RG_Tipo: TRadioGroup;
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
    DBLCB_CIDADE: TDBLookupComboBox;
    DBLCB_UF: TDBLookupComboBox;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Panel2: TPanel;
    Label1: TLabel;
    LBx_TipoRelatorio: TListBox;

    Fm_LME: TFm_ListaMultiEmpresa;
    Fm_ListaAuxiliarVenda: TFm_ListaColaboradores;
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_ImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sb_ExportarClick(Sender: TObject);
    procedure DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure DBLCB_VendedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure E_BuscaCodigoExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    
  private
    { Private declarations }
  public
    { Public declarations }
    It_Visualizar :Boolean;
    It_Imprimir :Boolean;
    It_Exportar :Boolean;    
    procedure Pc_ExportaNF;
    procedure Pc_ativa_tabela;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_IniciaVariaveis;
    procedure Pc_ImagemBotao;    
  end;

var
  Fr_Imp_Orcamento: TFr_Imp_Orcamento;

implementation

uses     UN_MSG, Un_Funcoes, Un_Excel, UN_DM, UN_Sistema, UN_Principal, env, un_rl_orcamentos, Un_RL_ORCAMENTODETALHADO, Un_Regra_Negocio, RN_Cliente, UN_TabelasEmListas;
{$R *.dfm}

procedure TFr_Imp_Orcamento.Pc_ExportaNF;
var
  ArquivoIni:TIniFile;
  Seq,I:Integer;
  Linha:String;
begin
  Try
    Seq:=1;
    DeleteFile(GbPathexe+'NOTAFISCAL.TXT');
    // Abre arquivo de configuracao
    ArquivoIni:=TIniFile.Create(GbPathexe+'NOTAFISCAL.TXT');
    try
      Qr_Exporta.Close;
      Qr_Exporta.ParamByName('DATAINI').AsDate:=E_Data_INI.Date;
      Qr_Exporta.ParamByName('DATAFIM').AsDate:=E_Data_FIM.Date;
      Qr_Exporta.Open;
      Qr_Exporta.First;
      for I:=0 to 11 do
      begin
        Linha:=Linha+';'+Qr_Exporta.FieldDefList[I].Name;
      end;
      Linha:=Linha+';'+'ALIQ_ICMS';
      ArquivoIni.WriteString('NOTA',IntToStr(0),Linha);
      While not Qr_Exporta.Eof DO
      Begin
        Linha:='';
        for I:=0 to 11 do
        begin
          Linha:=Linha+';'+Qr_Exporta.Fields[I].AsString;
        end;
        if Qr_Exporta.FieldByName('UFE_SIGLA').AsString='PR' then
        begin
          Linha:=Linha+';'+'18';
        end
        else
        begin
          Linha:=Linha+';'+'12';
        end;
        ArquivoIni.WriteString('NOTA',IntToStr(Seq),Linha);
        seq:=Seq+1;
        Qr_Exporta.Next;
      end;
      MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                     'O arquivo foi exportado com Sucesso.'+EOLN+EOLN+
                      GbPathexe+'NOTAFISCAL.TXT'+EOLN,
                  ['OK'],[bEscape],mpInformacao);
    except
      ShowMessage('Problemas no Registro Nº: '+IntToStr(Qr_Exporta.RecNo));
    end;
  Finally
    FreeAndNil(ArquivoIni);
  End;
end;

procedure TFr_Imp_Orcamento.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Imp_Orcamento.SB_ImprimirClick(Sender: TObject);
begin
  Pc_LimpaQrPreviweMemoria;
  case LBx_TipoRelatorio.ItemIndex of
    0:Begin
       try
          If not Assigned(RL_Orcamentos) then (Application.CreateForm(TRL_Orcamentos, RL_Orcamentos));
          RL_Orcamentos.Qrpt.Preview;
       finally
         RL_Orcamentos.Close;
       end;
      end;
    1:Begin
        try
          If not Assigned(RL_OrcamentoDetalhada) then (Application.CreateForm(TRL_OrcamentoDetalhada, RL_OrcamentoDetalhada));
          RL_OrcamentoDetalhada.Qrpt.Preview;
        finally
          RL_OrcamentoDetalhada.Close;
      end;
     end;
   end;     
end;

procedure TFr_Imp_Orcamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F2  : if Sb_Exportar.Enabled then Sb_ExportarClick(Sender);
      VK_F3  : if SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_Imp_Orcamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  Fr_imp_orcamento:=nil;
end;
   
procedure TFr_imp_orcamento.Sb_ExportarClick(Sender: TObject);
Var
  Lc_CAminho : String;
begin
  IF LBx_TipoRelatorio.ItemIndex = 2  THEN
  Begin
    Pc_ExportaNF;
    exit;
  End;

  if Fr_Principal.SaveDialogo.Execute then
  Begin
    if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
    Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
    Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
    case LBx_TipoRelatorio.ItemIndex of
      0:Begin
          try
          If not Assigned(RL_Orcamentos) then (Application.CreateForm(TRL_Orcamentos, RL_Orcamentos));
          RL_Orcamentos.Pc_Busca;
          Fr_Excel.Pc_Excel(RL_Orcamentos.Qr_Orcamento,Lc_CAminho);
          finally
          RL_Orcamentos.close;
          end;
        End;
      1:Begin
          try
            If not Assigned(RL_OrcamentoDetalhada) then (Application.CreateForm(TRL_OrcamentoDetalhada, RL_OrcamentoDetalhada));
            RL_OrcamentoDetalhada.Pc_Busca;
            Fr_Excel.Pc_Excel(RL_OrcamentoDetalhada.qr_orcamento,Lc_CAminho);
          finally
            RL_OrcamentoDetalhada.Close;
          end;
        End;
    end;
  end;
end;

procedure TFr_imp_orcamento.DBLCB_EmpresaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Empresa.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_imp_orcamento.ChBx_FantasiaClick(Sender: TObject);
begin
  Pc_ListaClienteDbLookUpComboBox('EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
end;

procedure TFr_imp_orcamento.ChBx_NomeClick(Sender: TObject);
begin
   Pc_ListaClienteDbLookUpComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa)
end;

procedure TFr_imp_orcamento.DBLCB_VendedorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Vendedor.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_Imp_Orcamento.Pc_IniciaVariaveis;
Begin

  Fm_LME.Listar('EMP_NOME');
  Fm_LME.HabilitarMultiEmpresa;
  RG_Tipo.ItemIndex:=0;
  ChBx_Periodo.Checked:= Fc_Marca_data_pesquisa;
  Fm_ListaAuxiliarVenda.ListaColaborador;
  E_Data_Ini.Date:= Now-30;
  E_Data_Fim.Date:= Now;

end;

procedure TFr_Imp_Orcamento.Pc_ativa_tabela;
begin
  DM.Qr_UF.Active:=True;
  dm.Qr_UF.FetchAll;
  DM.Qr_Cidades.Active:=True;
  Pc_AbreListaCliente('EMP_NOME');
  DM_ListaConsultas.Pc_ListaVendedor;

end;

procedure TFr_Imp_Orcamento.DBLookupComboBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Vendedor.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_Imp_Orcamento.Pc_PermissaoBotao(Pc_Menu: string);
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

procedure TFr_Imp_Orcamento.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;

  Pc_IniciaVariaveis;
  Pc_ativa_tabela;
  Pc_PermissaoBotao('Orçamento');
End;

procedure TFr_Imp_Orcamento.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Imp_Orcamento.E_BuscaCodigoExit(Sender: TObject);
begin
  DBLCB_Empresa.KeyValue := StrToIntDef(E_BuscaCodigo.Text,0);
end;

procedure TFr_Imp_Orcamento.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Imp_Orcamento.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    Sb_Exportar.Glyph.Assign(Fc_CarregaImagemBotao('EXPORTAR'));
    SB_Imprimir.Glyph.Assign(Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;
end.
