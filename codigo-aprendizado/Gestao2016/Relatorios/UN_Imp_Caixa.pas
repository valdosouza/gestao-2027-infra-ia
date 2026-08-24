unit UN_Imp_Caixa;

interface

uses
      STQuery, Data.DB, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Controls, Classes, Vcl.ExtCtrls, Vcl.Forms, SysUtils, Vcl.Graphics, Winapi.Messages, Winapi.Windows, QuickRpt, prmCaixa, Variants;


type
   TFr_Imp_Caixa = class(TForm)
    Panel1: TPanel;
    SB_Imprimir: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    E_Historico: TEdit;
    RG_Tipo: TRadioGroup;
    DBLCB_Usuario: TDBLookupComboBox;
    Ds_Usuario: TDataSource;
    Composicao: TQRCompositeReport;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Panel3: TPanel;
    Label1: TLabel;
    LBx_TipoRelatorio: TListBox;
      procedure SB_ImprimirClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure Sb_ExportarClick(Sender: TObject);
      procedure DBLCB_UsuarioKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ComposicaoAddReports(Sender: TObject);
   private
    { Private declarations }
   public
    { Public declarations }
    It_Imprimir:Boolean;
    It_Exportar:Boolean;
    It_Visualizar:Boolean;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;
    procedure DetalhadoTipoA4;
    procedure ResumidoTipoA4;
    procedure DetalhadoTipoCupom(Pc_Operacao,Pc_Caminho:String);
    procedure ResumidoTipoCupom(Pc_Operacao,Pc_Caminho:String);
    function getParametros: TParamCaixa;
   end;

var
   Fr_Imp_Caixa: TFr_Imp_Caixa;

implementation

uses     UN_RL_Lanca_Caixa, Un_Excel, UN_Sistema, Un_DM, UN_RL_Resumo_Caixa, UN_Principal, env, un_frx_report_caixa_detalhado, Un_Imp_Mod_Impressao, un_frx_report_caixa_resumido;

{$R *.dfm}

function TFr_Imp_Caixa.getParametros: TParamCaixa;
begin
  Result := TParamCaixa.Create;
  with Result do
  Begin
    case RG_Tipo.ItemIndex of
      0:TipoDocumento := 'CREDITO';
      1:TipoDocumento := 'DEBITO';
    end;
    Periodo := ChBx_Periodo.Checked;
    DataInicial := E_Data_Ini.DateTime;
    DataFinal := E_Data_Fim.DateTime;
    Historico := E_Historico.Text;
    if Trim(DBLCB_Usuario.Text) <> '' then
      Usuario := DBLCB_Usuario.KeyValue;
    CodigoEstabelecimento := Gb_Codmha;
  end;
end;


procedure TFr_Imp_Caixa.DetalhadoTipoA4;
begin
  try
    if not Assigned(Rl_Lanca_Caixa) then
      Application.CreateForm(TRl_Lanca_Caixa, Rl_Lanca_Caixa);
    if not Assigned(RL_Resumo_Caixa) then
      Application.CreateForm(TRL_Resumo_Caixa, RL_Resumo_Caixa);
    Composicao.ReportTitle := 'Relatório Detalhado do Caixa';
    Composicao.Prepare;
    Composicao.Preview;
  finally
    Rl_Lanca_Caixa.Close;
    RL_Resumo_Caixa.Close;
  end;
end;

procedure TFr_Imp_Caixa.DetalhadoTipoCupom(Pc_Operacao,Pc_Caminho:String);
Var
  Form: TFrx_report_caixa_detalhado;
Begin
  Try
    Form := TFrx_report_caixa_detalhado.create(Self);
    Form.Parametros := getParametros;
    //Form.Parametros.Ordenacao := ' FIN_DT_VENCIMENTO,EMP_NOME ';
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Form.Caption := 'LANÇAMENTOS DO CAIXA - DETALHADO';
      //Envia conexãao do Banco
      Form.frxBase.variables['StrConnetion'] := DM.IBD_Gestao.DatabaseName;
      Form.buscar;
      Form.frxBase.ShowReport;
    end
    else
    Begin
      Form.frxBase.ShowReport;
    End;

  Finally
    FreeAndNil(Form);
  End;

End;

procedure TFr_Imp_Caixa.ResumidoTipoA4;
begin
  try
    if not Assigned(Rl_Resumo_Caixa) then Application.CreateForm(TRl_Resumo_Caixa, Rl_Resumo_Caixa);
    Rl_Resumo_Caixa.Qrpt.Preview;
  finally
    Rl_Resumo_Caixa.Close;
  end;
end;

procedure TFr_Imp_Caixa.ResumidoTipoCupom(Pc_Operacao,Pc_Caminho:String);
Var
  Form: TFrx_report_caixa_resumido;
Begin
  Try
    Form := TFrx_report_caixa_resumido.create(Self);
    Form.Parametros := getParametros;
    //Form.Parametros.Ordenacao := ' FIN_DT_VENCIMENTO,EMP_NOME ';
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Form.Caption := 'LANÇAMENTOS DO CAIXA - RESUMO';
      //Envia conexãao do Banco
      Form.frxBase.variables['StrConnetion'] := DM.IBD_Gestao.DatabaseName;
      Form.buscar;
      Form.frxBase.ShowReport;
    end
    else
    Begin
      Form.frxBase.ShowReport;
    End;

  Finally
    FreeAndNil(Form);
  End;
End;

procedure TFr_Imp_Caixa.SB_ImprimirClick(Sender: TObject);
begin
  try
    self.Enabled := False;
    Pc_LimpaQrPreviweMemoria;
    case LBx_TipoRelatorio.ItemIndex of
      0:begin
         ResumidoTipoA4
        end;
      1:begin
          DetalhadoTipoA4
        end;
      2:Begin
          ResumidoTipoCupom('I','');
        End;
      3:Begin
          DetalhadoTipoCupom('I','');
        End;
    end;
  finally
    self.Enabled := True;
  end;
end;

procedure TFr_Imp_Caixa.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   if shift = [] then
   begin
      case Key of
         VK_F2: if Sb_Exportar.Enabled then  Sb_ExportarClick(Sender);
         VK_F3: if SB_Imprimir.Enabled then  SB_ImprimirClick(Sender);
         VK_Escape: if SB_Sair_0.Enabled then  SB_Sair_0Click(Sender);
      end;
   end;
end;

procedure TFr_Imp_Caixa.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_Caixa.Sb_ExportarClick(Sender: TObject);
var
   Lc_CAminho: string;
begin
  if Fr_Principal.SaveDialogo.Execute then
    begin
    if not Assigned(Fr_Excel) then Application.CreateForm(TFr_Excel, Fr_Excel);
    Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
    Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
    case LBx_TipoRelatorio.ItemIndex of
      0:begin
          try
            if not Assigned(Rl_Resumo_Caixa) then Application.CreateForm(TRl_Resumo_Caixa, Rl_Resumo_Caixa);
            Rl_Resumo_Caixa.Pc_Busca;
            Fr_Excel.Pc_Excel(RL_Resumo_Caixa.Qr_Movimentacao, Lc_CAminho);
          finally
            Rl_Resumo_Caixa.Close;
          end;
        end;
      1:begin
          try
            if not Assigned(Rl_Lanca_Caixa) then Application.CreateForm(TRl_Lanca_Caixa, Rl_Lanca_Caixa);
            RL_Lanca_Caixa.Pc_Busca;
            Fr_Excel.Pc_Excel(RL_Lanca_Caixa.Qr_Movimentacao, Lc_CAminho);
          finally
            Rl_Lanca_Caixa.Close;
          end;
        end;
     end;
  end;
end;

procedure TFr_Imp_Caixa.ComposicaoAddReports(Sender: TObject);
begin
  Composicao.reports.Add(RL_Resumo_Caixa.Qrpt);
  Composicao.reports.Add(RL_Lanca_Caixa.Qrpt);
end;

procedure TFr_Imp_Caixa.DBLCB_UsuarioKeyDown(Sender: TObject;
   var Key: Word; Shift: TShiftState);
begin
   if Shift = [] then
      case Key of
         VK_delete:
            begin
               DBLCB_Usuario.KeyValue := Null;
            end;
      end;
end;

procedure TFr_Imp_Caixa.Pc_PermissaoBotao(Pc_Menu: string);
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

procedure TFr_Imp_Caixa.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_PermissaoBotao('Lançamentos Caixa');
  DM.Qr_ListaUsuario.Active := True;
  RG_Tipo.ItemIndex := 0;
  E_Data_INI.Date := Date;
  E_Data_FIM.Date := Date;
  LBx_TipoRelatorio.ItemIndex := 0;
  ChBx_Periodo.Checked:= Fc_Marca_data_pesquisa;
end;

procedure TFr_Imp_Caixa.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Imp_Caixa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Imp_Caixa.Pc_ImagemBotao;
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

