unit UN_FormaPagto;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, ExtCtrls, Buttons, DB, StdCtrls, Mask, STStoredProc, ComCtrls, Grids, DBGrids, STQuery, QEdit_Setes, Un_Fm_CentroCusto, Un_Fm_CentroResultado, ControllerFormaPagamento;

type
  TFr_FormaPagto = class(TForm)
    Pg_FormaPagto: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Pnl_Fundo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    GroupBox2: TGroupBox;
    Label28: TLabel;
    E_BuscaDescricao: TEdit;
    Label22: TLabel;
    DBGrid2: TDBGrid;
    Qr_Pesquisa: TSTQuery;
    Ds_Pesquisa: TDataSource;
    SB_Buscar: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    SB_Cadastrar: TSpeedButton;
    Sb_Sair_1: TSpeedButton;
    pnl_botoes: TPanel;
    SB_Inserir: TSpeedButton;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Sb_Pesquisar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Label4: TLabel;
    E_Parcelamento: TEdit;
    ChBx_BuscaInativo: TCheckBox;
    Pg_Geral: TPageControl;
    tbs_Detail: TTabSheet;
    tbs_intermediator: TTabSheet;
    Label3: TLabel;
    Chbx_Bloquear: TCheckBox;
    Rg_finalidade: TRadioGroup;
    Chbx_Libera_sem_credito: TCheckBox;
    CB_Tipo_NFCe: TComboBox;
    Fm_CentroCusto: TFm_CentroCusto;
    Fm_CentroResultado: TFm_CentroResultado;
    Chbx_Ativo: TCheckBox;
    Chbx_Show_Delivery: TCheckBox;
    Chbx_TEF: TCheckBox;
    Panel1: TPanel;
    Label5: TLabel;
    E_Interm_Usuario: TEdit;
    Label6: TLabel;
    E_Interm_CNPJ: TMaskEdit;
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_InserirClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure Sb_PesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure Sb_Sair_1Click(Sender: TObject);
    procedure SB_CadastrarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure DBGrid2TitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    It_Inserir : Boolean;
    It_Alterar : Boolean;
    It_Excluir : Boolean;
    It_Visualizar : Boolean;
    EditionState : String;
    OperacaoIntermediator : String;
  private
    procedure LimpaCampos;
    procedure setPerfil(Pc_Menu: string);
    function Fc_Tipo_NFCe(Fc_Tipo:String):String;
    procedure ImagemBotao;
  protected
    procedure CriarVariaveis;
    procedure ShowData;
    procedure ShowNoData;
    procedure ShowPaymentType;
    Procedure ShowIntermediator;

    procedure EditionControl;

    procedure IniciaVariaveis;
    function  ValidaInsert:Boolean;
    procedure Insert;

    function ValidateDeleteItems:Boolean;
    procedure DeleteItem;


    function ValidateChange:Boolean;
    procedure Change;

    function ValidateDelete():boolean;
    procedure Delete;

    function ValidateSave:Boolean;
    function ValidateIntermCNPJ:Boolean;
    function ValidateIntermCNPJCalculate:Boolean;
    function ValidateIntermUsuario:Boolean;

    procedure Save;
    procedure SavePaymentType;
    procedure SaveIntermediator;

    function ValidateCancel:Boolean;
    procedure Cancel;

  public
    { Public declarations }
    FormaPagto : TControllerFormaPagamento;
    It_Cd_FormaPAgto : Integer;
    procedure Pc_AtivarTabelas;
    procedure PC_Buscar;
    procedure Pc_Visualizar;

  end;

var
  Fr_FormaPagto: TFr_FormaPagto;

implementation

uses     Un_DM, Un_Msg, Un_Principal, env, UN_Sistema, UN_Pedido_Vda, UN_Pedido_Cpa, UN_Lanca_Pagto, Un_Funcoes;
{$R *.dfm}

procedure TFr_FormaPagto.Pc_AtivarTabelas;
begin
  Fm_CentroCusto.Pc_ListaParaUsar;
  Fm_CentroResultado.Pc_ListaParaUsar;
end;

procedure TFr_FormaPagto.PC_Buscar;
var
  Sqltxt:string;
  Lc_Descricao: boolean;
begin
  sqltxt := '';
  Screen.Cursor:=crHourGlass;
  Qr_Pesquisa.Close;
  Qr_Pesquisa.Sql.Clear;
  Sqltxt := 'SELECT * FROM TB_FormaPagto WHERE (FPT_CODIGO IS NOT NULL) ';
  if ChBx_BuscaInativo.Checked then
    Sqltxt := Sqltxt + ' and (FPT_ATIVO = ''N'') '
  else
    Sqltxt := Sqltxt + ' and (FPT_ATIVO = ''S'') ';
  if E_BuscaDescricao.Text ='' then Lc_Descricao:=False Else Lc_Descricao:=True;

  if Lc_Descricao then Sqltxt:=Sqltxt+'AND (FPT_DESCRICAO LIKE :FPT_DESCRICAO) ';
  Qr_Pesquisa.SQL.Add(sqltxt + ' ORDER BY FPT_DESCRICAO');
  if Lc_Descricao then Qr_Pesquisa.ParamByName('FPT_DESCRICAO').AsString :='%'+ E_BuscaDescricao.Text+'%';
  Qr_Pesquisa.Open;
  Screen.Cursor:=crDefault;
end;



procedure TFr_FormaPagto.Pc_Visualizar;
begin
  if Qr_Pesquisa.RecordCount > 0 then
  begin
    FormaPagto.Registro.Codigo :=  Qr_Pesquisa.FieldByName('FPT_CODIGO').AsInteger;
    FormaPagto.getById;
    Pc_AtivarTabelas;
    ShowData;
    EditionState := 'B';
    EditionControl;
    Pg_FormaPagto.ActivePageIndex := 0;
  end;
end;

// Procedures Internas

procedure TFr_FormaPagto.SB_ExcluirClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir '+ FormaPagto.Registro.Descricao +' de seus arquivos.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  begin
    try
      FormaPagto.Delete;
      PC_Buscar;
      Pg_FormaPagto.ActivePageIndex:=1;
    except
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                     'Entre em contato com o suporte técnico.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    end;
  end;
end;

procedure TFr_FormaPagto.SB_InserirClick(Sender: TObject);
begin
  if ValidaInsert then
  Begin
    Pc_AtivarTabelas;
    EditionState := 'I';
    EditionControl;
    Insert;
  End;



end;

procedure TFr_FormaPagto.Save;
begin
  SavePaymentType;
  SaveIntermediator;
end;

procedure TFr_FormaPagto.SaveIntermediator;
begin
  FormaPagto.Intermediador.Registro.FormaPagamento := FormaPagto.Registro.Codigo;
  if ( OperacaoIntermediator = 'G' ) then
  Begin
    FormaPagto.Intermediador.Registro.DocFiscal           := E_Interm_CNPJ.Text;
    FormaPagto.Intermediador.Registro.UsuarioNaPlataforma := E_Interm_Usuario.Text;
    FormaPagto.Intermediador.salva;
  End
  else
  Begin
    FormaPagto.Intermediador.delete;
  End;
end;

procedure TFr_FormaPagto.SavePaymentType;
begin
  with FormaPagto do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.ParcelamentoMaximo := StrtoIntDef(E_Parcelamento.Text,1);
    Registro.Finalidade := InttoStr( Rg_finalidade.ItemIndex);
    Registro.FormaPagamentoNFCE  := Fc_Tipo_NFCe('Grava');

    if Fm_CentroCusto.DBLCB_Plano.Text <> '' then
      Registro.CentroCusto := Fm_CentroCusto.DBLCB_Plano.KeyValue
    else
      Registro.CentroCusto := 0;

    if Fm_CentroResultado.DBLCB_Plano.Text <> '' then
      Registro.ContaResultado := Fm_CentroResultado.DBLCB_Plano.KeyValue
    else
      Registro.ContaResultado :=  0;

    if Chbx_Libera_sem_credito.Checked  then Registro.Limite              := 'S' else Registro.Limite             := 'N';
    if Chbx_Bloquear.Checked            then Registro.Bloqueia            := 'S' else Registro.Bloqueia           := 'N';
    if Chbx_Ativo.Checked               then Registro.Ativo               := 'S' else Registro.Ativo              := 'N';
    if Chbx_Show_Delivery.Checked       then Registro.DisponivelDElivery  := 'S' else Registro.DisponivelDElivery := 'N';
    if Chbx_TEF.Checked                 then Registro.HabilitaTEF         := 'S' else Registro.HabilitaTEF        := 'N';
  End;
  FormaPagto.save;
end;

procedure TFr_FormaPagto.SB_AlterarClick(Sender: TObject);
begin
  if ValidateChange then
  Begin
    EditionState := 'E';
    EditionControl;
    Change;
  End;

end;

function TFr_FormaPagto.Fc_Tipo_NFCe(Fc_Tipo:String):String;
Var
  LcForma, LcCompara:String;
  I : Integer;
BEgin
  if Fc_Tipo = 'Grava' then
  Begin
    result := Copy(CB_Tipo_NFCe.Text,1,2);
  end
  else
  Begin
    LcForma := FormaPagto.Registro.FormaPagamentoNFCE;
    for I := 0 to CB_Tipo_NFCe.Items.Count -1 do
    Begin
      LcCompara := Copy(CB_Tipo_NFCe.Items[I],1,2);
      if LcForma = LcCompara then
      Begin
        break
      End;
    End;
      CB_Tipo_NFCe.ItemIndex := I;
  end;
end;

procedure TFr_FormaPagto.SB_GravarClick(Sender: TObject);
begin
  if ValidateSave then
  Begin
    Save;
    EditionState := 'B';
    EditionControl;
  End;
end;

procedure TFr_FormaPagto.SB_CancelarClick(Sender: TObject);
begin
  if ValidateCancel then
  Begin
    Cancel;
    EditionState := 'B';
    EditionControl;
  End;
end;

procedure TFr_FormaPagto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case Pg_FormaPagto.ActivePageIndex of
  0:begin
    if shift = [] then
      begin
        case Key of
        VK_F2  : if SB_Inserir.Enabled then SB_InserirClick(Sender);
        VK_F3  : if SB_Alterar.Enabled then SB_AlterarClick(Sender);
        VK_F4  : if SB_Excluir.Enabled then SB_ExcluirClick(Sender);
        VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
        VK_F6  : if SB_Cancelar.Enabled then SB_CancelarClick(Sender);
        VK_F7  : if SB_Pesquisar.Enabled then SB_PesquisarClick(Sender);
        VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
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
      VK_F8 : if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
      VK_Escape : if Sb_Sair_1.Enabled then Sb_Sair_1Click(Sender);
      end;
      end;
    end;
  end;

end;

procedure TFr_FormaPagto.Delete;
begin

end;

procedure TFr_FormaPagto.DeleteItem;
begin

end;

procedure TFr_FormaPagto.EditionControl;
Var
  I,J:Integer;
begin
  Pnl_Fundo.Enabled :=  ( EditionState = 'I' ) or ( EditionState = 'E' );
  SB_Inserir.Enabled := ( EditionState = 'B' ) and It_Inserir ;
  SB_Alterar.Enabled := ( EditionState = 'B' ) and ( FormaPagto.Registro.Codigo > 0 ) and It_Alterar;
  SB_Excluir.Enabled := ( EditionState = 'B' ) and ( FormaPagto.Registro.Codigo > 0 ) and It_Excluir;
  SB_gravar.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  SB_Cancelar.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Sb_Pesquisar.Enabled := ( EditionState = 'B' );
  Sb_Sair_0.Enabled := ( EditionState = 'B' );
end;

procedure TFr_FormaPagto.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_FormaPagto.SB_VisualizarClick(Sender: TObject);
begin
  Pc_Visualizar;
end;

procedure TFr_FormaPagto.setPerfil(Pc_Menu: string);
begin
  It_Inserir    := Fc_HabilitaPermissao(Pc_Menu,'INSERIR','S');
  It_Alterar    := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
  It_Excluir    := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
  It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
  SB_Cadastrar.Enabled := It_Inserir;
end;

procedure TFr_FormaPagto.ShowData;
begin
  ShowPaymentType;
  ShowIntermediator;
end;

procedure TFr_FormaPagto.ShowIntermediator;
begin

end;

procedure TFr_FormaPagto.ShowNoData;
begin
  FormaPagto.Clear;
  FormaPagto.Intermediador.clear;
  E_Codigo.Clear;
  E_Descricao.Clear;
  E_Parcelamento.Clear;
  Rg_finalidade.ItemIndex := 3;
  CB_Tipo_NFCe.ItemIndex := 0;
  Fm_CentroCusto.E_Codigo_Plano.Clear;
  Fm_CentroCusto.DBLCB_Plano.KeyValue := null;
  Fm_CentroResultado.E_Codigo_Plano.Clear;
  Fm_CentroResultado.DBLCB_Plano.KeyValue := null;
  Chbx_Ativo.Checked              := true;
  Chbx_Bloquear.Checked           := False;
  Chbx_Libera_sem_credito.Checked := False;
  Chbx_Show_Delivery.Checked      := False;
  Chbx_TEF.Checked                := False;
  //Aba Intermediador
  E_Interm_Usuario.Clear;
  E_Interm_CNPJ.Clear;
end;

procedure TFr_FormaPagto.ShowPaymentType;
begin
  with FormaPagto do
  Begin
    E_Codigo.Text           := Registro.Codigo.ToString();
    E_Descricao.Text        := Registro.Descricao;
    E_Parcelamento.Text     := Registro.ParcelamentoMaximo.ToString();
    Rg_finalidade.ItemIndex := StrToIntDef(Registro.Finalidade,3);
    Fc_Tipo_NFCe('');

    Fm_CentroCusto.E_Codigo_Plano.Text  := Registro.CentroCusto.ToString();
    Fm_CentroCusto.DBLCB_Plano.KeyValue := Registro.CentroCusto;

    Fm_CentroResultado.E_Codigo_Plano.Text  := Registro.ContaResultado.ToString();
    Fm_CentroResultado.DBLCB_Plano.KeyValue := Registro.ContaResultado;

    Chbx_Bloquear.Checked           := ( Registro.Bloqueia = 'S' );
    Chbx_Libera_sem_credito.Checked := ( Registro.Limite = 'S' );
    Chbx_Ativo.Checked              := ( Registro.Ativo = 'S' );
    Chbx_Show_Delivery.Checked      := ( Registro.DisponivelDElivery = 'S' );
    Chbx_TEF.Checked                := ( Registro.HabilitaTEF = 'S' );
  End;
end;

procedure TFr_FormaPagto.Sb_PesquisarClick(Sender: TObject);
begin
  ShowNoData;
  Pg_FormaPagto.ActivePageIndex:=1;
  PC_Buscar;
end;

procedure TFr_FormaPagto.FormCreate(Sender: TObject);
Begin
  CriarVariaveis;
end;

procedure TFr_FormaPagto.SB_BuscarClick(Sender: TObject);
begin
  PC_Buscar;
end;

procedure TFr_FormaPagto.Sb_Sair_1Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_FormaPagto.SB_CadastrarClick(Sender: TObject);
begin
  Pg_FormaPagto.ActivePageIndex := 0;
  SB_InserirClick(Sender);
end;

procedure TFr_FormaPagto.Sb_Sair_0Click(Sender: TObject);
begin
  close;
end;



procedure TFr_FormaPagto.Cancel;
begin

end;

procedure TFr_FormaPagto.Change;
begin
  E_Descricao.SetFocus;
end;

procedure TFr_FormaPagto.CriarVariaveis;
begin
  FormaPagto := TControllerFormaPagamento.create(Self);
end;

procedure TFr_FormaPagto.DBGrid2TitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(DBGrid2, Column);
end;


function TFr_FormaPagto.ValidaInsert:Boolean;
begin
  Result := True;
end;

function TFr_FormaPagto.ValidateCancel: Boolean;
begin
  Result := True;
end;

function TFr_FormaPagto.ValidateChange: Boolean;
begin
  Result := True;
end;

function TFr_FormaPagto.ValidateDelete: boolean;
begin
  Result := True;
end;

function TFr_FormaPagto.ValidateDeleteItems: Boolean;
begin
  Result := True;
end;

function TFr_FormaPagto.ValidateIntermCNPJ: Boolean;
begin
  Result := True;
  if (TRIM(E_Interm_CNPJ.Text)= '') then
  begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' Número de C.N.P.J. do intermediário não informado.' + EOLN +
                   ' Verifique!!' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Pg_Geral.ActivePageIndex := 1;
    if E_Interm_CNPJ.CanFocus then E_Interm_CNPJ.SetFocus;
    exit;
  end;
end;

function TFr_FormaPagto.ValidateIntermCNPJCalculate: Boolean;
Var
  Lc_DocFiscal :String;
begin
  Result := True;
  Lc_DocFiscal := ValidDocFiscal(E_Interm_CNPJ.Text);
  if not ( Lc_DocFiscal = OK ) then
  begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' Número de C.N.P.J. do intermediário Inválido.' + EOLN +
                   ' Verifique!!' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Pg_Geral.ActivePageIndex := 1;
    if E_Interm_CNPJ.CanFocus then E_Interm_CNPJ.SetFocus;
    exit;
  end;
end;

function TFr_FormaPagto.ValidateIntermUsuario: Boolean;
begin
  Result := True;
  if (TRIM(E_Interm_Usuario.Text) ='') then
  begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' Informe Nome do usuário ou identificação do perfil do vendedor no ' + EOLN +
                   ' site do intermediador (agenciador, plataforma de ' + EOLN +
                   ' delivery, marketplace e similar) de serviços e de negócios ' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Pg_Geral.ActivePageIndex := 1;
    if E_Interm_Usuario.CanFocus then E_Interm_Usuario.SetFocus;
    exit;
  end;
end;

function TFr_FormaPagto.ValidateSave: Boolean;
begin
  Result:=true;
  if (trim(E_Descricao.Text) = '') then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Descrição da Forma de Pagamento não informado.'+EOLN+
                   'Preencha a Descrição para continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    Result:=false;
    E_Descricao.SetFocus;
    Exit;
  end;
  OperacaoIntermediator := 'D';
  if (Trim(E_Interm_CNPJ.Text) <> '') then
  Begin
    if not ValidateIntermCNPJCalculate then
    Begin
      Result := False;
      exit;
    End;
    if not ValidateIntermUsuario then
    Begin
      Result := False;
      exit;
    End;
  End;

  if (Trim(E_Interm_Usuario.Text) <> '') then
  Begin
    if not ValidateIntermCNPJ then
    Begin
      Result := False;
      exit;
    End;

    if not ValidateIntermCNPJCalculate then
    Begin
      Result := False;
      exit;
    End;

  End;
  if (Trim(E_Interm_CNPJ.Text) <> '') and (Trim(E_Interm_Usuario.Text) <> '') then
    OperacaoIntermediator := 'G';
end;



procedure TFr_FormaPagto.FormShow(Sender: TObject);
begin
  IniciaVariaveis;
end;

procedure TFr_FormaPagto.ImagemBotao;
begin
  with fr_principal do
  Begin
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

procedure TFr_FormaPagto.IniciaVariaveis;
Var
  Lc_X : Integer;
begin
  For Lc_X:=1 to Pg_FormaPagto.PageCount do Pg_FormaPagto.Pages[Lc_X-1].TabVisible:=False;
  Pg_FormaPagto.ActivePageIndex:=1;
  setPerfil('Formas de Pagto');
  Pg_Geral.ActivePageIndex := 0;
  ImagemBotao;
end;

procedure TFr_FormaPagto.Insert;
begin
  ShowNoData;
  E_Descricao.SetFocus;
end;

procedure TFr_FormaPagto.LimpaCampos;
begin

end;

procedure TFr_FormaPagto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  case Pg_FormaPagto.ActivePageIndex of
    0:Begin
        if (FormaPagto.Registro.Codigo > 0 ) then
          It_Cd_FormaPAgto := FormaPagto.Registro.Codigo;
      End;
    1:Begin
        if Qr_Pesquisa.RecordCount > 0 then
          It_Cd_FormaPAgto := Qr_Pesquisa.FieldByName('FPT_CODIGO').AsInteger;
    End;
  end;
end;

end.



