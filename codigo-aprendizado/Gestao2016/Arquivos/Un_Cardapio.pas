unit Un_Cardapio;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBGrids, ExtCtrls, Grids, StdCtrls, Mask, QEdit_Setes, DBCtrls, Buttons, ComCtrls, DB, STQuery;

type
  TFr_Cardapio = class(TForm)
    Pg_Cardapio: TPageControl;
    tbs_Cadastro: TTabSheet;
    pnl_botoes: TPanel;
    Sb_Pesquisar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    tbs_Pesquisa: TTabSheet;
    Label22: TLabel;
    SB_Buscar: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    Sb_Sair_1: TSpeedButton;
    GroupBox2: TGroupBox;
    Label28: TLabel;
    E_BuscaDescricao: TEdit;
    DBG_Pesquisa: TDBGrid;
    Pg_Tipo: TPageControl;
    Qr_Grupos: TSTQuery;
    Qr_GruposGRP_CODIGO: TIntegerField;
    Qr_GruposGRP_DESCRICAO: TStringField;
    Qr_GruposSBG_CODIGO: TIntegerField;
    Qr_GruposSBG_DESCRICAO: TStringField;
    Qr_AtualizaPreco: TSTQuery;
    Qr_Pesquisa: TSTQuery;
    Ds_Pesquisa: TDataSource;
    Qr_PesquisaPRO_DESCRICAO: TStringField;
    Qr_PesquisaSBG_DESCRICAO: TStringField;
    Qr_PesquisaSBG_CODIGO: TIntegerField;
    SB_Inserir: TSpeedButton;
    Qr_GruposGRP_COMPOSICAO: TStringField;
    Qr_GruposGRP_INTERFACE: TStringField;
    Qr_GruposGRP_TAMANHOS: TStringField;
    Qr_Botao: TSTQuery;
    Qr_GruposGRP_PROG_TAM: TStringField;
    procedure FormShow(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure Sb_Sair_1Click(Sender: TObject);
    procedure Sb_PesquisarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_InserirClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    Grupo : Integer;
    Procedure Pc_DestroyAbasTipo;
     Function Fc_ValidaAbertura():Boolean;
    //Manipulação na interface
    procedure Pc_ImagemBotao;
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_Buscar;
    procedure Pc_Visualizar;


    //Novo Metodo utilizando FRame
    procedure Pc_CriaAbasTipo(Pc_Sequencia:Integer);
    procedure CriaAbaCardapioMTP(TabTipo: TTabSheet);
    procedure CriaAbaCardapioMTS(TabTipo: TTabSheet);
    procedure CriaAbaCardapioUT(TabTipo: TTabSheet);


  end;

var
  Fr_Cardapio: TFr_Cardapio;

implementation

uses     Un_DM, sea_measure, UN_Sistema, Un_Regra_Negocio, UN_MSG, Un_CardapioTamanho, Un_Pizzaria, UN_Principal, env, Un_CardapioProduto, RN_Estoque, RN_Produto, Un_Crp_Itens, Un_Fm_CardapioMTP, Un_Fm_CardapioMTS, Un_Fm_CardapioUT, sea_group_menu, reg_group_menu;
{$R *.dfm}

Procedure TFr_Cardapio.Pc_DestroyAbasTipo;
Var
  Lc_I:Integer;
Begin
  For Lc_I := (Pg_Tipo.PageCount-1) downto 0  do
  Begin
    Pg_Tipo.Pages[Lc_I].Free;
  end;

end;

Function TFr_Cardapio.Fc_ValidaAbertura():Boolean;
var
  Lc_Qry_Acao: TSTQuery;
  Lc_Form : TSeaGRoupMenu;
begin
  Try
    Result := true;
    Lc_Qry_Acao := TSTQuery.Create(Fr_Cardapio);
    with Lc_Qry_Acao do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      Forcedrefresh := True;
      //Valida a Existencia de registro de Tamanhos
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT GRP_CODIGO '+
              'from TB_GRUPOS tb_grupos '+
              '  INNER JOIN TB_SUBGRUPOS tb_subgrupos '+
              '  ON (tb_grupos.GRP_CODIGO = tb_subgrupos.SBG_CODGRP) '+
              'where GRP_CODIGO =:GRP_CODIGO');
      ParamByName('GRP_CODIGO').AsInteger := Grupo;
      Active := True;
      FetchAll;
      if (recordCount = 0) then
      Begin
        Lc_Form := TSeaGRoupMenu.Create(Self);
        Try
          Lc_Form.ShowModal;
          Grupo := Lc_Form.cds_searchcodigo.AsInteger;
          if (Grupo > 0) then
          Begin
            Result := Fc_ValidaAbertura;
          End
          else
          Begin
            Result := false;
            FreeANdNil(Lc_Form);
            Close;
            exit;
          End;
        Finally
          FreeANdNil(Lc_Form);
        End;
      end;
    end;
  Finally
    Lc_Qry_Acao.Close;
    FreeAndNil(Lc_Qry_Acao);
  End;
end;


procedure TFr_Cardapio.Pc_CriaAbasTipo(Pc_Sequencia:Integer);
var
  Lc_Panel : TPanel;
  Lc_TabTipo: TTabSheet;
begin
  //Cria a Pagina do Page Control Tipos do Cardapio
  Lc_TabTipo := TTabSheet.Create(Pg_Tipo);
  Lc_TabTipo.PageControl := Pg_Tipo;
  Lc_TabTipo.Name := 'tbs_ref_' + InttoStr(Pc_Sequencia);
  Lc_TabTipo.Caption := Qr_GruposSBG_DESCRICAO.AsString;
  Lc_TabTipo.Tag := Qr_GruposSBG_CODIGO.AsInteger;
  //Verifica se vai ter multiplos tamanhos
  if (Qr_GruposGRP_TAMANHOS.AsString = 'S') then
  Begin
    if (Qr_GruposGRP_PROG_TAM.AsString = 'S') then
      CriaAbaCardapioMTP( Lc_TabTipo )
    else
      CriaAbaCardapioMTS( Lc_TabTipo );
  end
  else
  Begin
    CriaAbaCardapioUT( Lc_TabTipo);
  end;
end;

procedure TFr_Cardapio.CriaAbaCardapioMTP(TabTipo: TTabSheet);
Var
  FM_MTP : TFm_CardapioMTP;
Begin
  FM_MTP := TFm_CardapioMTP.Create(Self);
  with FM_MTP do
  Begin
    Parent := TabTipo;
    Name := 'MTP_' + Qr_GruposSBG_CODIGO.AsString;
    with Fm_CardapioMT do
    Begin
      Pg_Geral.ActivePageIndex := 0;
      Grupo   := Qr_GruposGRP_CODIGO.AsInteger;
      SubGrupo := Qr_GruposSBG_CODIGO.AsInteger;
      MedidaEspecial := Qr_GruposGRP_DESCRICAO.AsString;
    End;
    Align := alClient;
    IniciaVariaveis;
  End;
end;

procedure TFr_Cardapio.CriaAbaCardapioMTS(TabTipo: TTabSheet);
Var
  FM_MTS : TFm_CardapioMTS;
Begin
  FM_MTS := TFm_CardapioMTS.Create(Self);
  with FM_MTS do
  Begin
    Parent := TabTipo;
    Name := 'MTS_' + Qr_GruposSBG_CODIGO.AsString;
    with Fm_CardapioMT do
    Begin
      Pg_Geral.ActivePageIndex := 0;
      Grupo   := Qr_GruposGRP_CODIGO.AsInteger;
      SubGrupo := Qr_GruposSBG_CODIGO.AsInteger;
      MedidaEspecial := Qr_GruposGRP_DESCRICAO.AsString;
    End;
    Align := alClient;
    IniciaVariaveis;
  End;
end;

procedure TFr_Cardapio.CriaAbaCardapioUT(TabTipo: TTabSheet);
Var
  FM_UT : TFm_CardapioUT;
Begin
  FM_UT := TFm_CardapioUT.Create(Self);
  with FM_UT do
  Begin
    Parent := TabTipo;
    Name := 'UT_' + Qr_GruposSBG_CODIGO.AsString;
    Grupo   := Qr_GruposGRP_CODIGO.AsInteger;
    SubGrupo := Qr_GruposSBG_CODIGO.AsInteger;
    MedidaEspecial := Qr_GruposGRP_DESCRICAO.AsString;
    Align := alClient;
    IniciaVariaveis;
  End;
end;




procedure TFr_Cardapio.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Geral;
    SB_Inserir.Glyph.Assign(Fc_CarregaImagemBotao('INSERIR'));
    SB_Pesquisar.Glyph.Assign(Fc_CarregaImagemBotao('PESQUISAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    SB_Buscar.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    SB_Visualizar.Glyph.Assign(Fc_CarregaImagemBotao('VISUALIZAR'));
    Sb_Sair_1.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

procedure TFr_Cardapio.Pc_FormataTela;
Var
 Lc_X : Integer;
begin
  For Lc_X:=1 to Pg_Cardapio.PageCount do Pg_Cardapio.Pages[Lc_X-1].TabVisible:=False;
  Pc_ImagemBotao;
  if Fc_ValidaAbertura then
  Begin
    Pg_Cardapio.ActivePage := tbs_Cadastro;
  end
  else
  Begin
    Pg_Cardapio.ActivePage := tbs_Pesquisa;
  end;
end;

procedure TFr_Cardapio.Pc_IniciaVariaveis;
Var
  I : Integer;
Begin
  Pc_DestroyAbasTipo;
  //Cria as abas do Cardapio conforme Grupo
  with Qr_Grupos do
  Begin
    Active:=False;
    ParamByName('GRP_CODIGO').AsInteger := Self.Grupo;
    Active:=true;
    FetchAll;
    First;
    I := 0;
    Self.Caption := 'Cardápio de ' + FieldByName('GRP_DESCRICAO').asString;
    while not eof do
    Begin
      Pc_CriaAbasTipo(I);
      Next;
      Inc(I);
    end;
  end;

end;

procedure TFr_Cardapio.Pc_Buscar;
var
  Sqltxt:string;
  Lc_Descricao: boolean;
begin
  sqltxt := '';
  Screen.Cursor:=crHourGlass;
  Qr_Pesquisa.Close;
  Qr_Pesquisa.Sql.Clear;
  Sqltxt := 'SELECT DISTINCT PRO_DESCRICAO, SBG_DESCRICAO,SBG_CODIGO '+
            'FROM TB_PRODUTO tb_produto '+
            '  INNER JOIN TB_GRUPOS '+
            '  ON (GRP_CODIGO = PRO_CODGRP) '+
            '  INNER JOIN TB_SUBGRUPOS '+
            '  ON (SBG_CODIGO = PRO_CODSBG) '+
            'WHERE (PRO_CODIGO IS NOT NULL) AND (GRP_CODIGO=:GRP_CODIGO) ';

  if E_BuscaDescricao.Text ='' then Lc_Descricao:=False Else Lc_Descricao:=True;

  if Lc_Descricao then Sqltxt:=Sqltxt+'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

  Qr_Pesquisa.SQL.Add(sqltxt + ' ORDER BY PRO_DESCRICAO');

  Qr_Pesquisa.ParamByName('GRP_CODIGO').AsInteger := Self.Grupo;
  if Lc_Descricao then Qr_Pesquisa.ParamByName('PRO_DESCRICAO').AsString :='%'+ E_BuscaDescricao.Text+'%';

  Qr_Pesquisa.Open;
  Screen.Cursor:=crDefault;

end;

procedure TFr_Cardapio.Pc_Visualizar;
Var
  Lc_I : Integer;
Begin
  Pg_Cardapio.ActivePage := tbs_Cadastro;
  Pg_Tipo.ActivePageIndex := 0;
  if Qr_Pesquisa.RecordCount > 0 then
  begin
    For Lc_I := 0 to (Pg_Tipo.PageCount - 1) do
    Begin
      if (Pg_Tipo.Pages[Lc_I].Tag = Qr_PesquisaSBG_CODIGO.AsInteger) then
      Begin
        Pg_Tipo.ActivePageIndex := Lc_I;
      end;
    End;
  end;
end;

procedure TFr_Cardapio.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_IniciaVariaveis;
end;

procedure TFr_Cardapio.SB_BuscarClick(Sender: TObject);
begin
  Pc_Buscar;
end;

procedure TFr_Cardapio.SB_VisualizarClick(Sender: TObject);
begin
  if Fc_ValidaAbertura then
  Begin
    Pc_IniciaVariaveis;
    Pc_Visualizar;
  end;
end;

procedure TFr_Cardapio.Sb_Sair_1Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Cardapio.Sb_PesquisarClick(Sender: TObject);
begin
  Pg_Cardapio.ActivePage := tbs_Pesquisa;
end;



procedure TFr_Cardapio.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Cardapio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = []) then
    begin
    case Pg_Cardapio.ActivePageIndex of
      0:Begin
        case Key of
        VK_F7  : SB_PesquisarClick(Sender);
        VK_Escape : Sb_Sair_0Click(Sender);
        end;
        end;
      1:Begin
        case Key of
        VK_F7  : SB_BuscarClick(Sender);
        VK_F8  : SB_VisualizarClick(Sender);
        VK_Escape : Sb_Sair_1Click(Sender);
        end;
        end;
      end;
    end
end;

procedure TFr_Cardapio.SB_InserirClick(Sender: TObject);
Var
  Lc_Form : TRegGRoupMenu;
begin
  Lc_Form := TRegGRoupMenu.Create(nil);
  Try
    Lc_Form.CodigoRegistro := Qr_GruposGRP_CODIGO.AsInteger;
    Lc_Form.ShowModal;
    Self.Grupo := Lc_Form.grupos.Registro.Codigo;
  Finally
    FreeAndNil(Lc_Form);
    if Fc_ValidaAbertura then
    Begin
      Pc_IniciaVariaveis;
    end;
  End;
end;


end.
