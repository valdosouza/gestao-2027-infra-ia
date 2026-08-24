unit Un_Img_Site_Produto;

interface

uses
      Windows, Messages, SysUtils, Variants, System.Classes, Graphics, Controls, Forms, Dialogs, Buttons, ExtCtrls, ComCtrls, StdCtrls, Mask, DB, JPEG, Un_JPEGImageExt, STQuery, Grids, DBGrids, QEdit_Setes, DBCtrls, ControllerImage, EncdDecd, synacode, System.ZLib, ControllerInternet, REST.Json;

type
  TFr_Img_Site_Produto = class(TForm)
    OpenDialogo: TOpenDialog;
    Qr_Cadastro: TSTQuery;
    Panel1: TPanel;
    img_amostra: TImage;
    Pnl_Navegacao: TPanel;
    pnl_botoes: TPanel;
    SB_Inserir: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Gravar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    pnl_fundos: TPanel;
    Sb_Carr_Imagem: TSpeedButton;
    Label34: TLabel;
    Label3: TLabel;
    E_PathIMG: TEdit;
    E_link: TEdit;
    Rg_ImageTarget: TRadioGroup;
    SB_Alterar: TSpeedButton;
    DBNavigator1: TDBNavigator;
    Ds_Cadastro: TDataSource;
    ChBx_Redimensionar: TCheckBox;
    SB_Cancelar: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_InserirClick(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure Sb_Carr_ImagemClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure Qr_CadastroAfterOpen(DataSet: TDataSet);
    procedure SB_CancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    It_Inserir : Boolean;
    It_Alterar : Boolean;
    It_Excluir : Boolean;
    Internet : TControllerInternet;
    procedure Pc_AtualizaInfoInternet;
    procedure EnviaImagemTrayCommerce;
  public
    { Public declarations }
    It_Cd_Table : Integer;
    It_Cd_Cadastro : Integer;
    It_Edicao : String;
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_AtivarTabelas;
    procedure Pc_PermissaoBotao(Pc_Inserir,Pc_Alterar,Pc_Excluir:Boolean);
    Function Fc_ValidaGravacao:Boolean;
    procedure Pc_ImagemBotao;
    function Fc_ValidaCarregamentoImagem():Boolean;
    procedure Pc_EstadoEdicao;
    procedure Pc_GravarImagemLocal;
    procedure Pc_GravarImagemWeb;
    procedure Pc_MostraRegistro;
    Function Fc_GetFileExtension(Fc_File:String):String;
  end;

var
  Fr_Img_Site_Produto: TFr_Img_Site_Produto;

implementation

uses     RN_Images, UN_MSG, Un_Pesq_Produto, UN_Sistema, UN_Principal, env, Un_DM, RN_Crud, api_route_image, UnFunctions;
{$R *.dfm}

procedure TFr_Img_Site_Produto.Pc_FormataTela;

begin

end;

procedure TFr_Img_Site_Produto.Pc_IniciaVariaveis;
Begin
  Internet.getFirst;
  with qr_cadastro do
  Begin
    active := false;
    ParamByName('table_id').AsInteger := It_Cd_Table;
    Active := True;
    if (recordcount > 0) then
      It_Cd_Cadastro := FieldByName('id').AsInteger
    else
      It_Cd_Cadastro := 0;
  end;
  Pc_MostraRegistro;
end;

procedure TFr_Img_Site_Produto.Pc_AtivarTabelas;
begin

end;

procedure TFr_Img_Site_Produto.Pc_AtualizaInfoInternet;
begin
  if (Fc_Tb_Geral('L','GRL_G_COM_ELETRONICO','') = 'S') then
  Begin
    Case Gb_Cd_Wsr of
      3:EnviaImagemTrayCommerce;
    end;
  end;
end;

function TFr_Img_Site_Produto.Fc_ValidaCarregamentoImagem():Boolean;
BEgin
  Result := True;
  if not FileExists(E_PathIMG.Text) then
    Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Imagem não encontrado no caminho especificado.' + EOLN +
                   'Verifique o caminho e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
      Result := False;
    exit;
    end;
end;

procedure TFr_Img_Site_Produto.Pc_EstadoEdicao;
Begin
  pnl_fundos.Enabled      := (It_Edicao = 'I') OR (It_Edicao = 'E');
  Pnl_Navegacao.Enabled      := (It_Edicao = 'B');
  //botões da Ordem de Serviço
  SB_Inserir.Enabled  := (It_Edicao = 'B')  and It_Inserir;
  SB_Alterar.Enabled  := (It_Edicao = 'B')  and (It_Cd_Cadastro > 0) and  It_Alterar;
  SB_Excluir.Enabled  := (It_Edicao = 'B')  and (It_Cd_Cadastro > 0) and  It_Excluir;
  SB_Gravar.Enabled   := ((It_Edicao = 'I') OR (It_Edicao = 'E'));
  SB_Cancelar.Enabled   := ((It_Edicao = 'I') OR (It_Edicao = 'E'));
  Sb_Sair_0.Enabled  := (It_Edicao = 'B')  ;
end;

procedure TFr_Img_Site_Produto.Pc_MostraRegistro;
var
  St_Image:TStream;
  Jp_IMage: TJpegImage; // sem a unit 'jpeg' essa classe não existiria
begin
  Jp_IMage := nil;
  with Qr_Cadastro do
    Begin
    It_Cd_Cadastro := FieldByName('id').AsInteger;
    //E_cd_product.Text := FieldByName('id').AsString;
    //E_Description.Text := FieldByName('file_name').AsString;
    if FieldByName('target').AsString = 'normal' then
      Rg_ImageTarget.ItemIndex := 0
    else
    if FieldByName('target').AsString = 'cover' then
      Rg_ImageTarget.ItemIndex := 1
    else
    if FieldByName('target').AsString = 'banner' then
      Rg_ImageTarget.ItemIndex := 2;
    E_link.Text := FieldByName('link').AsString;

    St_Image := CreateBlobStream(FieldByName('content'),bmRead);
    if St_Image.Size > 0 then
      begin
      try
        if (FieldByName('extension').AsString = 'jpg') then
        Begin
          Try
            Jp_IMage := TJpegImage.Create;
            Jp_IMage.LoadFromStream(St_Image);
            img_amostra.Picture.Assign(Jp_IMage);
            img_amostra.Visible := true;
          Finally
            FreeAndNil(Jp_IMage);
          End;
        end
        else
        if (FieldByName('extension').AsString = 'png') then
          Begin
          TBlobField(FieldByName('content')).SaveToFile(GbPathExe + FieldByName('file_name').AsString);
          img_amostra.Picture.LoadFromFile(GbPathExe + FieldByName('file_name').AsString);
          end;
      except
        img_amostra.Picture.LoadFromFile('');
        img_amostra.Visible := false;
      end;
      end
    else
      begin
      img_amostra.Picture.LoadFromFile('');
      img_amostra.Visible := False;
      end;
    Jp_IMage.Free;
    St_Image.Destroy;
    end;
    It_Edicao := 'B';
    Pc_EstadoEdicao;
end;


procedure TFr_Img_Site_Produto.Pc_PermissaoBotao(Pc_Inserir,Pc_Alterar,Pc_Excluir:Boolean);
begin
  if Gb_Nivel = 1 then
    begin
    It_Inserir := True;
    It_Alterar := True;
    It_Excluir := True;
    end
  else
    begin
    It_Inserir    := Pc_Inserir;
    It_Alterar    := Pc_Alterar;
    It_Excluir    := Pc_Excluir;
    end;
end;

Function TFr_Img_Site_Produto.Fc_ValidaGravacao:Boolean;
begin
  Result:=true;
end;

procedure TFr_Img_Site_Produto.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Inserir.Glyph.Assign(Fc_CarregaImagemBotao('INSERIR'));
    SB_Alterar.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    SB_Excluir.Glyph.Assign(Fc_CarregaImagemBotao('EXCLUIR'));
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Img_Site_Produto.FormCreate(Sender: TObject);
begin
  Internet := TControllerInternet.create(Self);
end;

procedure TFr_Img_Site_Produto.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_IniciaVariaveis;
  Pc_ImagemBotao;

end;

procedure TFr_Img_Site_Produto.Sb_Sair_0Click(Sender: TObject);
begin
  close;
end;

procedure TFr_Img_Site_Produto.SB_InserirClick(Sender: TObject);
begin
  It_Cd_Cadastro := 0;
  E_PathIMG.Clear;
  Rg_ImageTarget.ItemIndex := 0;
  E_link.Clear;
  img_amostra.Picture.LoadFromFile('');
  img_amostra.Visible := False;
  Pc_AtivarTabelas;
  It_Edicao := 'I';
  Pc_EstadoEdicao;
end;
procedure TFr_Img_Site_Produto.Pc_GravarImagemLocal;
Begin


end;

procedure TFr_Img_Site_Produto.Pc_GravarImagemWeb;
Begin


end;
procedure TFr_Img_Site_Produto.EnviaImagemTrayCommerce;
Var
  Lc_route_image : TApiRouteImage;
  Lc_image : TControllerImage;
  lc_base64 : String;

begin
  Lc_route_image  := TApiRouteImage.create(Self);
  Lc_image        := TControllerImage.create(Self);
  Try

    Lc_image.Registro.Codigo := It_Cd_Cadastro;
    Lc_image.getByKey;
    if Lc_image.exist then
    Begin
      Lc_route_image.ObjImage.Codigo          := Lc_image.Registro.Codigo;
      Lc_route_image.ObjImage.Estabelecimento := Lc_image.Registro.Estabelecimento;
      Lc_route_image.ObjImage.Tipo            := Lc_image.Registro.Tipo;
      Lc_route_image.ObjImage.Alvo            := Lc_image.Registro.Alvo;
      Lc_route_image.ObjImage.IdTabela        := Lc_image.Registro.IdTabela;
      Lc_route_image.ObjImage.NomeArquivo     := Lc_image.Registro.NomeArquivo;
      Lc_route_image.ObjImage.Extensao        := Lc_image.Registro.Extensao;

      lc_base64 := encodebase64(Lc_image.Registro.Conteudo);
      Lc_route_image.ObjImage.Conteudo        := lc_base64;
      Lc_route_image.ObjImage.link            := Lc_image.Registro.link;
      Lc_route_image.ObjImage.CaminhoServer   := Internet.Registro.DiretorioImagem;
      try
        if not Lc_route_image.post then
          raise Exception.Create('Falha ao enviar imagem para a API');
      except
        MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                       'Verifique se o sistema está configurado para enviar a imagem para o disco virtual.' + EOLN +
                       'Loja virtual precisa estar ativa no sistema.' + EOLN,
                       ['OK'], [bEscape], mpErro);
      end;
    End;
  Finally
    FreeAndNil(Lc_route_image);
    FreeAndNil(Lc_image);
  End;
end;

Function TFr_Img_Site_Produto.Fc_GetFileExtension(Fc_File:String):String;
Var
  Lc_I : Integer;
Begin
  result := '';
  for Lc_i:=Length(Fc_File) downto 1 do
    begin
    if (Fc_File[Lc_I]<>'.') then
      Result:= Fc_File[Lc_I]+Result
    else
      break;
    end;
  result := LowerCase(result);
end;

procedure TFr_Img_Site_Produto.SB_GravarClick(Sender: TObject);
Var
  Lc_Target : String;
  Lc_Path : String;
begin
  Screen.Cursor := crHourGlass;
  if Fc_ValidaGravacao then
    begin
      TRY
        Pc_ProcesoAguarde(Self,'I');
        pnl_botoes.Enabled  := False;
        case Rg_ImageTarget.ItemIndex of
          0:Lc_Target := 'normal';
          1:Lc_Target := 'cover';
          2:Lc_Target := 'banner';
        end;
        //Remove o target cover caso este registro seja cover
        if (Lc_Target = 'cover') then
          Fc_RetiraCapaImages(IntToStr(It_Cd_Table));
        //Grava imagem local
        if ChBx_Redimensionar.Checked then
          Lc_Path := GbPathExe +'temp\'
        else
          Lc_Path := StringReplace(E_PathIMG.Text, ExtractFileName(OpenDialogo.FileName), '',[rfReplaceAll, rfIgnoreCase]);
        It_Cd_Cadastro := Fc_AtualizaImages(IntToStr(It_Cd_Cadastro),
                                            IntToStr(Gb_CodMha),
                                            'product',
                                            Lc_Target,
                                            IntToStr(It_Cd_Table),
                                            ExtractFileName(OpenDialogo.FileName),
                                            Fc_GetFileExtension(E_PathIMG.Text),
                                            Lc_Path,
                                            E_link.text,
                                            ChBx_Redimensionar.Checked);
        //Envia a imagem para a Internet
        Pc_AtualizaInfoInternet;
        Qr_Cadastro.Close;
        Qr_Cadastro.Active := True;
        Pc_MostraRegistro;
      Finally
        Pc_ProcesoAguarde(Self,'F');
        pnl_botoes.Enabled  := True;
      end;
    end;
  It_Edicao := 'B';
  Pc_EstadoEdicao;
  Screen.Cursor := crDefault;
end;

procedure TFr_Img_Site_Produto.Sb_Carr_ImagemClick(Sender: TObject);
Var
  Lc_Path,Lc_File:String;
  imgProduto: TJPEGImageExt;
  Jp_IMage: TJpegImage;
begin
  if OpenDialogo.Execute then
  Begin
    E_PathIMG.Text := OpenDialogo.FileName;
    if Fc_ValidaCarregamentoImagem then
    Begin
      Lc_Path := StringReplace(E_PathIMG.Text, ExtractFileName(OpenDialogo.FileName), '',[rfReplaceAll, rfIgnoreCase]);
      Lc_File := ExtractFileName(OpenDialogo.FileName);
      if ChBx_Redimensionar.Checked then
      Begin
        TRy
          Jp_IMage := TJpegImage.Create;
          Jp_IMage.LoadFromFile(Lc_Path + '\' + Lc_File);
          imgProduto := TJPEGImageExt.create(Jp_IMage);
          imgProduto.imageResize(GbPathExe + '\temp\' ,Lc_File, 360, 360, 100, true); // NORMAL SEMPRE DIMENSIONA PRA 360X360
          img_amostra.Picture.LoadFromFile(GbPathExe + '\temp\' + Lc_File);
          img_amostra.Visible := True;
        Finally
          FreeAndNil(Jp_IMage)
        End;
      end
      else
      Begin
        img_amostra.Picture.LoadFromFile(E_PathIMG.Text);
        img_amostra.Visible := True;
      end;
    end;
  end;
end;

procedure TFr_Img_Site_Produto.SB_ExcluirClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir está imagem de seus arquivos.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  begin
    try
      TRY
        Pc_ProcesoAguarde(Self,'I');
        pnl_botoes.Enabled  := False;
        //Exclui a imagem da Internet
        if (Fc_Tb_Geral('L','GRL_G_COM_ELETRONICO','') = 'S') then
        Begin

        end;
        //Exclui do Banco local
        Fc_ApagarRegistro('TB_IMAGES',['ID'],[IntToStr(It_Cd_Cadastro)]);

        Qr_Cadastro.Close;
        Qr_Cadastro.Active := True;
        Pc_MostraRegistro;          
      Finally
        Pc_ProcesoAguarde(Self,'F');
        pnl_botoes.Enabled  := True;
      end;
    except
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                     'Entre em contato com o suporte técnico.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      DM.IB_Transacao.RollbackRetaining;
    end;
  end;
end;

procedure TFr_Img_Site_Produto.SB_AlterarClick(Sender: TObject);
begin
  It_Edicao := 'E';
  Pc_EstadoEdicao;
end;

procedure TFr_Img_Site_Produto.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
Pc_MostraRegistro;
end;

procedure TFr_Img_Site_Produto.Qr_CadastroAfterOpen(DataSet: TDataSet);
begin
  Pc_MostraRegistro;
end;

procedure TFr_Img_Site_Produto.SB_CancelarClick(Sender: TObject);
begin
  IF (It_Edicao = 'I') then
  Begin
    E_PathIMG.Clear;
    Rg_ImageTarget.ItemIndex := 0;
    E_link.Clear;
    img_amostra.Picture := nil;
  end;
  It_Edicao := 'B';
  Pc_EstadoEdicao;
end;

end.
