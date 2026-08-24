unit Un_Virtual_Shop;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, DBCtrls, ExtCtrls, ComCtrls, Buttons, DB, ControllerInternet, STQuery, Un_Fm_ListaEstoques, STDataSet, System.StrUtils;

type
  TFr_Virtual_Shop = class(TForm)
    Pnl_Edicao: TPanel;
    Label54: TLabel;
    Label55: TLabel;
    Label40: TLabel;
    Label37: TLabel;
    Cb_TipoWebservice: TComboBox;
    E_Path_WebService: TEdit;
    DblCb_Tabela: TDBLookupComboBox;
    E_Dir_Images: TEdit;
    Chbx_Internet: TCheckBox;
    chbx_Vitrine: TCheckBox;
    chbx_Dealer: TCheckBox;
    Pnl_botao: TPanel;
    Label2: TLabel;
    E_Id_Google_analytics: TEdit;
    Label3: TLabel;
    E_Titulo_Site: TEdit;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Qr_Virtual_Shop: TSTQuery;
    gbProxy: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Label19: TLabel;
    E_Proxy_Path: TEdit;
    E_Proxy_Porta: TEdit;
    E_Proxy_User: TEdit;
    E_Proxy_Pws: TEdit;
    Label4: TLabel;
    E_Site: TEdit;
    SB_Alterar: TSpeedButton;
    Label5: TLabel;
    e_mail: TEdit;
    Fm_ListaEstoques: TFm_ListaEstoques;
    procedure FormShow(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    it_Edicao : String;
    Internet : TControllerInternet;
    procedure LimpaCampos;
    procedure preencheCampos;
    procedure formataTela;
    procedure AtivarTabelas;
    procedure inicia_variaveis;
    procedure imagemBotao;
    function validagravacao:Boolean;
    procedure grava;
    procedure controleedicao;



  public
    { Public declarations }
  end;

var
  Fr_Virtual_Shop: TFr_Virtual_Shop;

implementation

uses     UN_Principal, env, Un_DM, UN_Sistema, UN_MSG, Un_Regra_Negocio, RN_Estoque;
{$R *.dfm}

procedure TFr_Virtual_Shop.LimpaCampos;
Begin
  Cb_TipoWebservice.ItemIndex := -1;
  E_Site.Clear;
  E_Path_WebService.Clear;
  E_Titulo_Site.Clear;
  E_Dir_Images.Clear;
  DblCb_Tabela.KeyValue := 0;
  Fm_ListaEstoques.Dblcb_Estoque.KeyValue := 0;
  E_Id_Google_analytics.Clear;
  Chbx_Internet.Checked  := False;
  chbx_Vitrine.checked := False;
  chbx_Dealer.checked  := False;
  E_Proxy_Path.Clear;
  E_Proxy_Porta.Clear;
  E_Proxy_User.Clear;
  E_Proxy_Pws.Clear;

end;

procedure TFr_Virtual_Shop.preencheCampos;
Begin
  Cb_TipoWebservice.ItemIndex := Internet.Registro.CodigoWebServer;
  E_Site.Text                 := Internet.Registro.www;
  E_Path_WebService.Text      := Internet.Registro.Url_Webservice;
  E_Titulo_Site.Text          := Internet.Registro.TituloSite;
  E_Dir_Images.Text           := Internet.Registro.DiretorioImagem;
  DblCb_Tabela.KeyValue       := Internet.Registro.TabelaPreco;
  Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Internet.Registro.CodigoEstoque;
  E_Id_Google_analytics.Text  := Internet.Registro.GoogleAnalytic;
  Chbx_Internet.Checked       := (Fc_Tb_Geral('L','GRL_G_COM_ELETRONICO','') = 'S');
  chbx_Vitrine.checked        := (Internet.Registro.vitrine = 'Y');
  chbx_Dealer.checked         := (Internet.Registro.Revendedor = 'Y');
  E_Proxy_Path.Text           := Internet.Registro.proxy_path;
  E_Proxy_Porta.Text          := Internet.Registro.proxy_porta;
  E_Proxy_User.Text           := Internet.Registro.proxy_user;
  E_Proxy_Pws.Text            := Internet.Registro.proxy_pws;
  e_mail.Text                 := Internet.Registro.emailFinanceiro;
end;

procedure TFr_Virtual_Shop.ImagemBotao;
Begin
  with fr_principal do
  Begin
    SB_Alterar.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

function TFr_Virtual_Shop.validagravacao:Boolean;
Begin
  Result := True;
  if Trim(E_Site.Text) = '' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Favor Prencher o endereço do Site.'+EOLN+
                   'Verifique e tente novamente.' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    E_Site.SetFocus;
    Result := False;
    Exit;
  end;
  if Trim(E_Path_WebService.Text) = '' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Favor Prencher o Caminho do WebService.'+EOLN+
                   'Verifique e tente novamente.' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    E_Path_WebService.SetFocus;
    Result := False;
    Exit;
  end;
  if Trim(E_Titulo_Site.Text) = '' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Favor Prencher o Título do Site.'+EOLN+
                   'Verifique e tente novamente.' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    E_Titulo_Site.SetFocus;
    Result := False;
    Exit;
  end;
  if Trim(E_Path_WebService.Text) = '' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Favor Prencher o diretorio de Imagens.'+EOLN+
                   'Verifique e tente novamente.' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    E_Dir_Images.SetFocus;
    Result := False;
    Exit;
  end;
  if Trim(DblCb_Tabela.Text) = '' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Favor definir uma tabela de preço a praticar.'+EOLN+
                   'Verifique e tente novamente.' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    DblCb_Tabela.SetFocus;
    Result := False;
    Exit;
  end;
  if Trim(Fm_ListaEstoques.Dblcb_Estoque.Text) = '' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Favor definir um estoque para controlar.'+EOLN+
                   'Verifique e tente novamente.' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    E_Path_WebService.SetFocus;
    Result := False;
    Exit;
  end;
  if Trim(e_mail.Text) = '' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Favor preencher com o email que será responsável .'+EOLN+
                   'pelas transações financeiras com o Bchas.' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    e_mail.SetFocus;
    Result := False;
    Exit;
  end;
end;

procedure TFr_Virtual_Shop.grava;
Begin
  Internet.Registro.Estabelecimento := Gb_CodMha;
  Internet.Registro.CodigoWebServer := Cb_TipoWebservice.ItemIndex;
  Internet.Registro.www             := E_Site.Text;
  Internet.Registro.Url_Webservice  := E_Path_WebService.Text;
  Internet.Registro.TituloSite      := E_Titulo_Site.Text;
  Internet.Registro.DiretorioImagem := E_Dir_Images.Text;
  Internet.Registro.TabelaPreco     := DblCb_Tabela.KeyValue;
  Internet.Registro.CodigoEstoque   :=Fm_ListaEstoques.Dblcb_Estoque.KeyValue;
  Internet.Registro.GoogleAnalytic  := E_Id_Google_analytics.Text;
  IF Chbx_Internet.Checked  then
    Fc_Tb_Geral('G','GRL_G_COM_ELETRONICO','S')
  else
    Fc_Tb_Geral('G','GRL_G_COM_ELETRONICO','N');
  Internet.Registro.vitrine         := IfThen(chbx_Vitrine.checked,'Y','N');
  Internet.Registro.Revendedor      := IFThen(chbx_Dealer.checked,'Y','N');
  Internet.Registro.proxy_path      := E_Proxy_Path.Text;
  Internet.Registro.proxy_porta     := E_Proxy_Porta.Text;
  Internet.Registro.proxy_user      := E_Proxy_User.Text;
  Internet.Registro.proxy_pws       := E_Proxy_Pws.Text;
  Internet.Registro.emailFinanceiro := e_mail.Text;
  Internet.save;
  it_Edicao := 'B';
end;

procedure TFr_Virtual_Shop.controleedicao;
Begin
  Pnl_Edicao.Enabled := (it_Edicao ='I') or (it_Edicao ='E');
  Sb_Sair_0.Enabled := (it_Edicao ='N');
  SB_ALTERAR.Enabled := (it_Edicao ='B'); 
  SB_Gravar.Enabled := (it_Edicao ='I') or (it_Edicao ='E');
  SB_Cancelar.Enabled := (it_Edicao ='I') or (it_Edicao ='E');
  Sb_Sair_0.Enabled := (it_Edicao ='B');
end;



procedure TFr_Virtual_Shop.AtivarTabelas;
Begin
  Fm_ListaEstoques.AtivaLista(Gb_CodMha);
  DM.Qr_Tabelas.Active := True;
  DM.Qr_Estoques.Active := True;
end;

procedure TFr_Virtual_Shop.FormataTela;
Begin
  ImagemBotao;

end;

procedure TFr_Virtual_Shop.Inicia_variaveis;
Begin
  AtivarTabelas;
  Internet.Registro.Estabelecimento := Gb_CodMha;
  Internet.getFirst;
  If Internet.exist then
    it_Edicao := 'E'
  else
    it_Edicao := 'I';
  preencheCampos;
  controleedicao;
end;

procedure TFr_Virtual_Shop.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Internet);
end;

procedure TFr_Virtual_Shop.FormCreate(Sender: TObject);
begin
  Internet := TControllerInternet.create(self);
end;

procedure TFr_Virtual_Shop.FormShow(Sender: TObject);
begin
  FormataTela;
  Inicia_variaveis;
end;

procedure TFr_Virtual_Shop.SB_GravarClick(Sender: TObject);
begin
  try
    Enabled := False;
    Pc_ProcesoAguarde(Self,'I');
    if validagravacao then
    Begin
      grava;
      controleedicao;
    end;
  Finally
    Pc_ProcesoAguarde(Self,'F');
    Enabled := True;
  end;
end;

procedure TFr_Virtual_Shop.SB_CancelarClick(Sender: TObject);
begin
  if it_Edicao = 'I' then
    LimpaCampos;
  it_Edicao := 'B';
  controleedicao;
end;

procedure TFr_Virtual_Shop.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Virtual_Shop.SB_AlterarClick(Sender: TObject);
begin
  it_Edicao := 'E';
  controleedicao;
end;

end.
