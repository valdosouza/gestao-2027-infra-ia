Unit Un_CardapioProduto;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Mask, QEdit_Setes, Buttons, ExtCtrls, DBCtrls, DB, STQuery, ControllerCardapio, Un_Fm_ListaUnidades, StrUtils;

type
  TFr_CardapioProduto = class(TForm)
    Panel2: TPanel;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    pnl_fundo: TPanel;
    Label2: TLabel;
    E_Descricao: TEdit;
    Label39: TLabel;
    E_CodClasfiscal: TEdit_Setes;
    Sb_Classificacao: TSpeedButton;
    Label43: TLabel;
    SpeedButton1: TSpeedButton;
    E_CESt: TEdit_Setes;
    Label1: TLabel;
    Cb_Finalid_Tributa: TComboBox;
    RG_SUBTRIB: TRadioGroup;
    Fm_ListaUnidades: TFm_ListaUnidades;
    ChBx_ativo: TCheckBox;
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure Sb_ClassificacaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Fm_ListaUnidadesSb_MedidaClick(Sender: TObject);
  private
    { Private declarations }
    procedure Pc_IniciaVariaveis;
  public
    { Public declarations }
    TipoOperacao : String;

    Old_Produto : String;
    Cardapio : TControllerCardapio;

    Propaga : Boolean;
    Function Fc_validaGravacao():Boolean;
    procedure Pc_ImagemBotao;
    procedure PreencheRegistro;

  end;

var
  Fr_CardapioProduto: TFr_CardapioProduto;

implementation

uses     UN_MSG, Un_Pesq_NCM, RN_Permissao, UN_Sistema, Un_Regra_Negocio, Un_Funcoes, Un_DM, DateUtils, UN_Principal, env, RN_Produto, RN_Estoque, Un_Pesq_CEST, UN_TabelasEmListas, Un_CardapioTamanho;

{$R *.dfm}

procedure TFr_CardapioProduto.Pc_ImagemBotao;
BEgin
  with fr_principal do
  Begin
    //Geral;
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
  end;
end;

//Manipula Produtos

Function TFr_CardapioProduto.Fc_validaGravacao():Boolean;
Var
  Lc_Aux : String;
Begin
  Result := True;
  if Trim(E_Descricao.Text)='' then
  Begin
    MensagemPadrao(' Mensagem ', ATENCAO + EOLN + EOLN +
                   ' Descrição do Produto é campo obrigatório.' + EOLN +
                   ' Verifique e tente novamente.' + EOLN,
                    ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;

  if Fc_VerificaPermissao('Fr_Nota_Fiscal_3_X','Nota Fiscal Eletrônica 3.x','VISUALIZAR',GB_Cd_Usuario,'S') or
    Fc_VerificaFormularioDisponivel('Fr_GeraNFe') then
  begin
    if trim(E_CodClasfiscal.Text) =  '' THEN
    Begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Campo Class. Fiscal(NCM) o não informado.'+EOLN+
                     'Preencha o NCM deste Produto.'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      E_CodClasfiscal.SetFocus;
      exit;
    end;
    Lc_Aux := trim(E_CodClasfiscal.Text);
    Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux, ['.',',','/','-']);
    if Length( trim(E_CodClasfiscal.Text) ) <> 8 THEN
    Begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'O Número de Class. Fiscal(NCM) deve ter 8 dígitos.'+EOLN+
                     'Preencha corretamente para cotinuar.'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      E_CodClasfiscal.SetFocus;
      exit;
    end;
  end;
  if Trim(Fm_ListaUnidades.DBLCB_Medida.Text)='' then
  Begin
    MensagemPadrao(' Mensagem ', ATENCAO + EOLN + EOLN +
                   ' Medida do item Cardápio é campo obrigatório.' + EOLN +
                   ' Verifique e tente novamente.' + EOLN,
                    ['OK'], [bEscape], mpAlerta);
    Fm_ListaUnidades.DBLCB_Medida.SetFocus;
    Result := False;
    exit;
  end;


  if Copy(TipoOperacao,1,1) = 'I' then
  Begin
    if Cardapio.Registro.Codigo = 0 then
    Begin
      Cardapio.Registro.Descricao := E_Descricao.Text;
      Cardapio.Registro.MedidaComercial := Fm_ListaUnidades.DBLCB_Medida.KeyValue;
      Cardapio.getByDMG;
      if Cardapio.exist then
      Begin
        MensagemPadrao(' Mensagem ', ATENCAO + EOLN + EOLN +
                       ' Este produto com a medida informada já existem.' + EOLN +
                       ' O sistema vai ativa-los para aparecer no cardápio.' + EOLN,
                        ['OK'], [bEscape], mpAlerta);
      //Salva a Tabela de Preco
      Cardapio.SalvaTabelaPreco;
      //Salva a Tabela de estoque
      Cardapio.SalvaTabelaEstoque;
      Cardapio.Registro.Ativo := 'S';
      PreencheRegistro;
      Cardapio.salva;
      Result := False;
      Close;
      exit;
      End;
    End;
  End;
end;

procedure TFr_CardapioProduto.Fm_ListaUnidadesSb_MedidaClick(Sender: TObject);
Var
  Form : TFr_CardapioTamanho;
begin
  try
    Form  := TFr_CardapioTamanho.Create(self);
    Form.Cardapio.Registro.Codigo := 0;
    Form.Cardapio.Registro.Descricao := '';
    Form.Cardapio.Registro.CodigoGrupo := self.Cardapio.Registro.CodigoGrupo;
    Form.Cardapio.Registro.CodigoSubGrupo := self.Cardapio.Registro.codigoSubGrupo;
    Form.Cardapio.Registro.MedidaComercial := 0;
    Form.ShowModal;
    DM_ListaConsultas.Pc_ListaMedida(SIM,self.Cardapio.Grupos.Registro.Descricao);
    Fm_ListaUnidades.DBLCB_Medida.KeyValue := Form.Cardapio.Medida.Registro.Codigo;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_CardapioProduto.PreencheRegistro;
begin
  With Cardapio.Registro do
  Begin
    CodigoEstabelecimento := Gb_CodMha;
    Descricao := E_Descricao.Text;
    if ChBx_ativo.checked then
      Ativo := 'S'
    else
      Ativo := 'N';
    Campanha := 'N';
    Destaque := 'N';
    codigoNCM := E_CodClasfiscal.Text;
    CEST := E_CESt.Text;
    if (CodigoMarca = 0 )then
      CodigoMarca := Fc_ProcuraRegistraMarca('PRÓPRIA');
    Tipo := 'A';
    Imprime := 'S';
    UtilizaSerie := 'N';
    Exclusivo := 'N';
    if ( Codigoembalagem = 0 ) then
      Codigoembalagem := Fc_ProcuraRegistraEmbalagem('CAIXA','CXA');
    MedidaComercial := Fm_ListaUnidades.DBLCB_Medida.KeyValue;
    Divisor := 1;
    Origem := '0';
    if RG_SUBTRIB.ItemIndex = 0 then
      SubsTrib := 'S'
    else
      SubsTrib := 'N';
    EstoqueNegativo := 'S'; //Permite o estoque negativo
    Internet := 'N';
    Composicao := '1';
    FinalidadeTributacao := IntToStr(Cb_Finalid_Tributa.ItemIndex + 1);
    ForaLinha := 'N';
  End;
end;

procedure TFr_CardapioProduto.SB_GravarClick(Sender: TObject);
begin
  if Fc_validaGravacao then
  Begin
    PreencheRegistro;
    if ( Cardapio.Grupos.Registro.Tamanhos = 'S') then
    Begin
      if ( Cardapio.Grupos.Registro.PropagaTamanho = 'S') then
      Begin
        //Inclui produtos - Propagando tamanho
        //[I]nsere [M]ultiplo [T]amanho - [S]abor
        //[U]pdate [M]ultiplo [T]amanho - [S]abor
        case AnsiIndexStr(UpperCase(TipoOperacao), ['IMTP','UMTP']) of
          0 : Cardapio.SalvaSaborPropagaTamanho;
          1 : Cardapio.SalvaSaborByD;
        end;
      End
      else
      Begin
        //Inclui produtos - Propagando não propagando tamanho
        //[I]nsere [M]ultiplo [T]amanho [S]imples - [S]abor
        //[U]pdate [M]ultiplo [T]amanho [S]imples - [S]abor
        //[I]nsere [M]ultiplo [T]amanho [S]imples - [T]amanho
        //[I]nsere [M]ultiplo [T]amanho [S]imples - [T]amanho
        case AnsiIndexStr(UpperCase(TipoOperacao), ['IMTS-S','UMTS-S','IMTS-T','UMTS-T']) of
          0 : Begin
                Cardapio.salva;
                //Salva a Tabela de Preco
                Cardapio.SalvaTabelaPreco;
                //Salva a Tabela de estoque
                Cardapio.SalvaTabelaEstoque;
                //Insere botão
                Cardapio.InsereBotao(Cardapio.Registro.Codigo,Cardapio.hasBotao,0);
              End;
          1 : Cardapio.SalvaSaborByD;
          2 : Begin
                Cardapio.salva;
                //Salva a Tabela de Preco
                Cardapio.SalvaTabelaPreco;
                //Salva a Tabela de estoque
                Cardapio.SalvaTabelaEstoque;
                //Insere botão
                Cardapio.InsereBotao(Cardapio.Registro.Codigo,Cardapio.hasBotao,0);
              End;
          3 : Cardapio.salva;
        End;
      End;
    End
    else
    Begin
      //Inclui produto unico no padrão
      Cardapio.salva;
    End;
    Close;
  end;
end;

procedure TFr_CardapioProduto.SpeedButton1Click(Sender: TObject);
Var
  Lc_Form : TFr_Pesq_CEST;
begin
  Try
    Lc_Form := TFr_Pesq_CEST.Create(Self);
    Lc_Form.It_Visualizar := False;
    Lc_Form.ShowModal;
    if Lc_Form.It_Visualizar then
      E_CESt.Text := Lc_Form.Qr_Pesquisa.FieldByName('CEST').AsString;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_CardapioProduto.SB_CancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_CardapioProduto.Sb_ClassificacaoClick(Sender: TObject);
Var
  Lc_Form : TFr_Pesq_NCM;
begin
  Try
    Lc_Form := TFr_Pesq_NCM.Create(Self);
    Lc_Form.It_Visualizar := False;
    Lc_Form.ShowModal;
    if Lc_Form.It_Visualizar then
      E_CodClasfiscal.Text := Lc_Form.Qr_Pesquisa.FieldByName('NCM_N_NCM').AsString;
  Finally
    FreeAndNil(Lc_Form);
  End;

end;

procedure TFr_CardapioProduto.Pc_IniciaVariaveis;
Begin
  //Carrega os dados do Grupo
  Cardapio.Grupos.Registro.codigo := Cardapio.Registro.codigoGrupo;
  Cardapio.Grupos.getbyId;
  //Carrega os dados da Medida/Unidade
  if (Cardapio.Registro.MedidaComercial = 0 ) then
  Begin
    Cardapio.Medida.Registro.MedidaCardapio := Cardapio.Grupos.Registro.Descricao;
    Cardapio.Medida.getbyMedidaEspecial;
  End;
  DM_ListaConsultas.Pc_ListaMedida(SIM,Cardapio.Grupos.Registro.Descricao);
  if Cardapio.Exist then
  Begin
    E_CodClasfiscal.Text := Cardapio.Registro.codigoNCM;
    E_Descricao.Text := Cardapio.Registro.Descricao;
    E_CESt.Text := Cardapio.Registro.CEST;
    if Cardapio.Registro.SubsTrib = 'S' then
      RG_SUBTRIB.ItemIndex := 0
    else
      RG_SUBTRIB.ItemIndex := 1;
    Cb_Finalid_Tributa.ItemIndex := StrToIntDef(Cardapio.Registro.FinalidadeTributacao ,1)-1;
    Fm_ListaUnidades.DBLCB_Medida.KeyValue := Cardapio.Registro.MedidaComercial;
  end;
end;

procedure TFr_CardapioProduto.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_IniciaVariaveis;
end;

procedure TFr_CardapioProduto.FormCreate(Sender: TObject);
begin
  Cardapio := TControllerCardapio.Create(Self);
end;

procedure TFr_CardapioProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
      VK_F6  : if SB_Cancelar.Enabled then SB_CancelarClick(Sender);
    end;
  end;
end;

procedure TFr_CardapioProduto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

end.

