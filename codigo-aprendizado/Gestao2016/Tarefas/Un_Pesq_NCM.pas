unit Un_Pesq_NCM;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, ACBrBase, ACBrSocket, ACBrIBPTax, ControllerNcm, Vcl.Samples.Gauges;

type
  TFr_Pesq_NCM = class(TForm)
    Qr_Pesquisa: TSTQuery;
    Ds_Pesquisa: TDataSource;
    Panel2: TPanel;
    Grd_Pesquisa: TDBGrid;
    Panel1: TPanel;
    SB_Buscar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Chb_Digitacao: TCheckBox;
    GrBx_Pesquisa: TGroupBox;
    Lb_Descricao: TLabel;
    Label2: TLabel;
    E_BuscaDescricao: TMaskEdit;
    E_BuscaNCM: TMaskEdit;
    SB_Visualizar: TSpeedButton;
    Sb_Atualizacao: TSpeedButton;
    IBPTax: TACBrIBPTax;
    SB_Alterar: TSpeedButton;
    Pnl_Progresso: TPanel;
    Gg_Progresso: TGauge;
    Lb_Processamento: TLabel;
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure E_BuscaCodigoChange(Sender: TObject);
    procedure E_BuscaNCMChange(Sender: TObject);
    procedure E_BuscaDescricaoChange(Sender: TObject);
    procedure Chb_DigitacaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Grd_PesquisaDblClick(Sender: TObject);
    procedure Sb_AtualizacaoClick(Sender: TObject);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Visualizar : Boolean;
    ncm : TControllerNcm;
    procedure Pc_Buscar;
    procedure Pc_CofiguraComponente;
    procedure Pc_AtualizarListaNCM;
  end;

var
  Fr_Pesq_NCM: TFr_Pesq_NCM;

implementation

uses     Un_DM, UN_Sistema, Un_Produtos, UN_MSG, UN_NCM, Un_Regra_Negocio, env;
{$R *.dfm}

procedure TFr_Pesq_NCM.Pc_Buscar;
var
  Lc_Codigo, Lc_NCM, Lc_Descricao: Boolean;
  Lc_SQL: String;
begin
  Lc_SQL := '';
  Screen.Cursor := crHourGlass;

  if E_BuscaNCM.Text = '' then Lc_NCM := False else Lc_NCM := True;
  if E_BuscaDescricao.Text = '' then Lc_Descricao := False else Lc_Descricao := True;

  Qr_Pesquisa.Active := False;
  Qr_Pesquisa.SQL.Clear;

  Lc_Sql := 'SELECT * FROM TB_NCM           '+
            'WHERE (NOT NCM_N_NCM IS NULL) ';

  if Lc_NCM then Lc_SQL := Lc_SQL + '  AND NCM_N_NCM LIKE:NCM_N_NCM ';
  if Lc_Descricao then Lc_SQL := Lc_SQL + '  AND NCM_DESCRICAO LIKE :NCM_DESCRICAO ';

  Lc_SQL := Lc_SQL + 'ORDER BY NCM_N_NCM ';
  Qr_Pesquisa.SQL.Add(Lc_SQL);
  if Lc_NCM then Qr_Pesquisa.ParamByName('NCM_N_NCM').AsString := '%'+ E_BuscaNCM.Text +'%';
  if Lc_Descricao then Qr_Pesquisa.ParamByName('NCM_DESCRICAO').AsString := '%'+ E_BuscaDescricao.Text +'%';
  Qr_Pesquisa.Active := True;
  Qr_Pesquisa.FetchAll;
  Screen.Cursor := crDefault;
end;

procedure TFr_Pesq_NCM.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Pesq_NCM.SB_BuscarClick(Sender: TObject);
begin
  Pc_Buscar;
end;

procedure TFr_Pesq_NCM.E_BuscaCodigoChange(Sender: TObject);
begin
  if Chb_Digitacao.Checked then
    PC_Buscar;
end;

procedure TFr_Pesq_NCM.E_BuscaNCMChange(Sender: TObject);
begin
  if Chb_Digitacao.Checked then
    PC_Buscar;
end;

procedure TFr_Pesq_NCM.E_BuscaDescricaoChange(Sender: TObject);
begin
  if Chb_Digitacao.Checked then
    PC_Buscar;
end;

procedure TFr_Pesq_NCM.Chb_DigitacaoClick(Sender: TObject);
begin
  if Chb_Digitacao.Checked then Fc_Aq_Geral('G','PESQ_NCM','DIGITACAO','S') else Fc_Aq_Geral('G','PESQ_NCM','DIGITACAO','N');
end;

procedure TFr_Pesq_NCM.FormShow(Sender: TObject);
begin
  Chb_Digitacao.Checked := (Fc_Aq_Geral('L','PESQ_NCM','DIGITACAO','') = 'S');
end;

procedure TFr_Pesq_NCM.Pc_CofiguraComponente;
Begin
  if Fc_VerificaProxy then
  Begin
    IBPTax.ProxyHost  := Gb_Pxy_Path + ':' + IntToStr(Gb_Pxy_Porta) ;
    IBPTax.ProxyUser  := Gb_Pxy_User;
    IBPTax.ProxyPass  := Gb_pxy_Pws;
    IBPTax.ProxyPort  := IntToStr(Gb_Pxy_Porta);
  end;
  IBPTax.Token := 'C6LLldMRMGQlow2P97nUeUbryOrhriLXPqSfLGvtDP-cyXJWGI9YgaGRsdyyJ5BH';
  IBPTax.CNPJEmpresa := '07742094000113';
  IBPTax.URLDownload := 'https://www.setes.com.br/ncm/TabelaIBPTaxPR14.csv';
end;

procedure TFr_Pesq_NCM.Pc_AtualizarListaNCM;
Var
  Lc_I :Integer;
  Lista : TStringList;
Begin
  TRY
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Lista := TStringList.create;
    IF (IBPTax.DownloadTabela) then
    bEGIN
      if (IBPTax.Itens.Count > 0) then
      Begin
        Ncm.DeleteAll;
        Pnl_Progresso.Visible := True;
        Gg_Progresso.MinValue := 0;
        Gg_Progresso.MaxValue := IBPTax.Itens.Count;
        Gg_Progresso.Progress := 0;
        Application.ProcessMessages;
        lista.clear;
        for Lc_I := 0 to IBPTax.Itens.Count - 1 do
        begin
          if ( Length(trim(IBPTax.Itens[Lc_I].NCM)) =8 ) then
          Begin
            ncm.Registro.NCM            := IBPTax.Itens[Lc_I].NCM;
            ncm.Registro.Descricao      := UpperCase(Copy(IBPTax.Itens[Lc_I].Descricao,1,150));
            ncm.Registro.Excecao        := IBPTax.Itens[Lc_I].Excecao;
            ncm.Registro.AliqNacional   := IBPTax.Itens[Lc_I].FederalNacional;
            ncm.Registro.AliqImport     := IBPTax.Itens[Lc_I].FederalImportado;
            ncm.Registro.AliqEstadual   := IBPTax.Itens[Lc_I].Estadual;
            ncm.Registro.AliqMunicipal  := IBPTax.Itens[Lc_I].Municipal;
            //ncm.replace;
            lista.Add(ncm.getSqlCommandReplace);
            if lista.Count = 500 then
            Begin
              ncm.ComandoIBScript(Lista);
              lista.clear;
            End;
            Application.ProcessMessages;
          end;
          Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
          Lb_Processamento.Caption := Concat('Processamento: ',IntToStr(Gg_Progresso.Progress),' de ', IntToStr(Gg_Progresso.MaxValue) );
          Application.ProcessMessages;
        end;
        //executa os script que sobraram que não chegaram a 500 antes do final do loop
        if lista.Count > 0 then
        Begin
          ncm.ComandoIBScript(Lista);
          lista.clear;
        End;

        Ncm.Controle.Registro.Chave   := IBPTax.ChaveArquivo;
        Ncm.Controle.Registro.Versao  := IBPTax.VersaoArquivo;
        Ncm.Controle.Registro.DataInicio := IBPTax.VigenciaInicio;
        Ncm.Controle.Registro.dataFinal := IBPTax.VigenciaFim;
        Ncm.Controle.replace;

        MensagemPadrao(MENSAGEM, 'S U C E S S O!.' + EOLN + EOLN +
                       'Atualização concluída com sucesso.' + EOLN,
                       ['OK'], [bEscape], mpInformacao);
      End;
    end
  Finally
    FreeAndNil(Lista);
    Pnl_Progresso.Visible := False;
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := true;
    Application.ProcessMessages;
  end;
end;



procedure TFr_Pesq_NCM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(ncm);
end;

procedure TFr_Pesq_NCM.FormCreate(Sender: TObject);
begin
  ncm := TControllerNcm.create(self);
end;

procedure TFr_Pesq_NCM.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = [])  then
  begin
    case Key of
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_F8  : if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
      VK_F9  : if Sb_Atualizacao.Enabled then Sb_AtualizacaoClick(Sender);
      VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
    end;
  end
end;

procedure TFr_Pesq_NCM.Grd_PesquisaDblClick(Sender: TObject);
begin
  SB_VisualizarClick(Sender);
end;

procedure TFr_Pesq_NCM.Sb_AtualizacaoClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja atualizar a Tabela de NCM com os índices da IBPT?' + EOLN + EOLN +
                     'Isso pode levar vários minutos.',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao1) then
  Begin
    Try
      Pc_ProcesoAguarde(Self,'I');
      Self.Enabled := False;
      Pc_CofiguraComponente;
      Pc_AtualizarListaNCM;
    Finally
      Pc_ProcesoAguarde(Self,'F');
      Self.Enabled := true;
    end;
  end;
end;

procedure TFr_Pesq_NCM.SB_VisualizarClick(Sender: TObject);
begin
  if Qr_Pesquisa.RecordCount > 0 then
    begin
    It_Visualizar := true;
    end;
    Close;
end;

procedure TFr_Pesq_NCM.SB_AlterarClick(Sender: TObject);
Var
  Lc_Form : TFr_ncm;
begin
  try
    Lc_Form := TFr_ncm.Create(nil);
    if Qr_Pesquisa.active then
      Lc_Form.It_Cd_Ncm := Qr_Pesquisa.FieldByName('NCM_N_NCM').AsString;
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;

end;


end.
