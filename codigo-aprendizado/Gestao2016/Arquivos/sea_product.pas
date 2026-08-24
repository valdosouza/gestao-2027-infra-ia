unit sea_product;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, QEdit_Setes, Un_Fc_Sored_Procedures, STQuery;

type
  TSeaProduct = class(TBaseSearch)
    Label28: TLabel;
    Label33: TLabel;
    Label35: TLabel;
    Label26: TLabel;
    Label29: TLabel;
    Lb_Aplicacao: TLabel;
    Label36: TLabel;
    lb_bsc_codigoFab: TLabel;
    lbl_busc_cod: TLabel;
    Label34: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit_Setes;
    E_BuscaGRupo: TEdit;
    E_BuscaLocal: TEdit;
    E_BuscaCodBarras: TEdit_Setes;
    E_BuscaCodigoFabrica: TEdit;
    E_BuscaSubgrupo: TMaskEdit;
    E_BuscaAplicacao: TMaskEdit;
    E_BuscaMarca: TMaskEdit;
    Rg_Publicacao: TRadioGroup;
    Rg_Imagem: TRadioGroup;
    Cb_BuscaTipo: TComboBox;
    ChBx_Inativos: TCheckBox;
    ChBx_BuscaForaLinha: TCheckBox;
    chbx_comissao: TCheckBox;
    Rg_Est_Neg: TRadioGroup;
    Rg_busca_fixed_rate: TRadioGroup;
    Chbx_ncm_invalido: TCheckBox;
  private
    procedure RegistroLogVisualizacao;
  protected
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBySql;Override;
    procedure GroupBySql;Override;
    procedure SetParameters(Param: TSTQuery);Override;
    procedure GetView;Override;
    procedure SetRegister;Override;
    procedure setPerfil;Override;
  public
    { Public declarations }
  end;

var
  SeaProduct: TSeaProduct;

implementation

{$R *.dfm}

uses     UN_Sistema, UN_Principal, env, Un_Produtos, Un_DM;
procedure TSeaProduct.FormataTela;
begin
  //Verifica se o produto será tratado como um Carro
  if (Fc_Tb_Geral('L','PRO_G_LABEL_PRO','') = 'S') then
  begin
    lb_bsc_codigoFab.Caption:='Códgos (Chassi/ Renavan)';
    Dbg_Pesquisa.Columns[1].Title.Caption:='Chassi';
  end
  else
  begin
    lb_bsc_codigoFab.Caption:='Cód. Fabrica/ Cód. Fornecedor';
    Dbg_Pesquisa.Columns[1].Title.Caption:='Fábrica';
  end
end;

procedure TSeaProduct.GetView;
Var
  Form  : TFr_Produtos;
begin
  RegistroLogVisualizacao;
  Form := TFr_Produtos.create(nil);
  Try
    Form.Produto.Registro.Codigo := cds_search.FieldByName('PRO_CODIGO').AsInteger;
    Form.ShowModal;
  Finally
    FreeAndNil( Form );
  End;
end;

procedure TSeaProduct.GroupBySql;
begin
  inherited;

end;

procedure TSeaProduct.IniciaVariaveis;
begin
  inherited;

end;

procedure TSeaProduct.InnerJoinSql;
begin
  inherited;
  InnerJoinTxt := concat(
             '   INNER JOIN TB_GRUPOS tb_grupos ',
             '   ON (tb_grupos.GRP_CODIGO = tb_produto.PRO_CODGRP) ',
             '   INNER JOIN TB_SUBGRUPOS tb_subgrupos  ',
             '   ON (tb_subgrupos.SBG_CODIGO = tb_produto.PRO_CODSBG)  ',
             '   INNER JOIN TB_MARCA_PRODUTO tb_marca ',
             '   ON (tb_marca.MRC_CODIGO = tb_produto.PRO_CODMRC)  '
  );

  IF chbx_comissao.Checked THEN
  Begin
    InnerJoinTxt := concat(
             InnerJoinTxt,
             ' INNER JOIN tb_preco tb_preco ',
             ' ON (tb_preco.prc_codpro = tb_produto.pro_codigo) '
    );
  end;

  case Rg_Imagem.ItemIndex of
    0:begin
        InnerJoinTxt := concat(
                         InnerJoinTxt,
                         ' INNER JOIN tb_IMAGES tb_imagem              ',
                         ' ON (tb_imagem.table_id = tb_produto.pro_codigo) '
        );
      end;
    1:begin
        InnerJoinTxt := concat(
                           InnerJoinTxt,
                           ' LEFT OUTER JOIN tb_IMAGES tb_imagem              ',
                           ' ON (tb_imagem.table_id = tb_produto.pro_codigo) '
        );
      end;
  end;

  if Chbx_ncm_invalido.Checked then
  Begin
    InnerJoinTxt := concat(
                      InnerJoinTxt,
                      '  left outer join  tb_ncm n ',
                      '  on (n.ncm_n_ncm = pro_codigoncm) '
    );
  End;


end;

procedure TSeaProduct.OrderBySql;
begin
  inherited;
  OrderByTxt := ' ORDER BY PRO_DESCRICAO';
end;

procedure TSeaProduct.RegistroLogVisualizacao;
begin
  Pc_Log_Sistema( Gb_CodMha,
                  GB_Cd_Usuario,
                  (Now),
                  'Cadastro de Produtos',
                  cds_search.Fieldbyname('PRO_CODIGO').AsInteger,
                  'Produto Visualizado', cds_search.Fieldbyname('PRO_DESCRICAO').AsString );
end;

procedure TSeaProduct.SelectSql;
begin
  inherited;
  SelectTxt := concat(
             ' SELECT DISTINCT PRO_CODIGO, PRO_CODIGOFAB, PRO_CODIGOFOR, PRO_CODIGOBAR, ',
             ' PRO_DESCRICAO, GRP_DESCRICAO,SBG_DESCRICAO, MRC_DESCRICAO, PRO_LOCAL,   ',
             ' PRO_CODIGONCM, PRO_CEST '+
             ' FROM TB_PRODUTO Tb_Produto '
            );

end;

procedure TSeaProduct.SetParameters(Param: TSTQuery);
begin
  with Param do
  Begin
    if E_BuscaCodigo.Text <> '' then
    Begin
      ParamByName('PRO_CODIGO').AsString := E_BuscaCodigo.Text;
    End;

    if E_BuscaCodigoFabrica.Text <> '' then
    Begin
      ParamByName('PRO_CODIGOFAB').AsString := '%' + E_BuscaCodigoFabrica.Text + '%';
    End;

    if E_BuscaCodBarras.Text <> '' then
    Begin
      ParamByName('PRO_CODIGOBAR').AsString := E_BuscaCodBarras.Text;
    End;

    if E_BuscaDescricao.Text <> '' then
    Begin
      ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(E_BuscaDescricao.Text,1,98) + '%';
    End;

    if E_BuscaGrupo.Text <> '' then
    Begin
      ParamByName('GRP_DESCRICAO').AsString := '%' + E_BuscaGRupo.Text + '%';
    End;

    if E_BuscaSubgrupo.Text <> '' then
    Begin
      ParamByName('SBG_DESCRICAO').AsString := '%' + E_BuscaSubgrupo.Text + '%';
    End;

    if E_BuscaMarca.Text <> '' then
    Begin
      ParamByName('MRC_DESCRICAO').AsString := '%' + E_BuscaMarca.Text + '%';
    End;

    if E_BuscaLocal.Text <> '' then
    Begin
      ParamByName('PRO_LOCAL').AsString := '%' + E_BuscaLocal.Text + '%';
    End;

    if E_BuscaAplicacao.Text <> '' then
    Begin
      ParamByName('PRO_APLICACAO').AsString := '%' + E_BuscaAplicacao.Text + '%';
    End;

    if not GB_ProdCompartilha then ParamByName('PRO_CODMHA').AsInteger := Gb_CodMha;
  End;

end;

procedure TSeaProduct.setPerfil;
begin
  pfMenu := 'Marcas/Modelos';
  inherited;
end;

procedure TSeaProduct.SetRegister;
Var
  Form  : TFr_Produtos;
begin
  Form := TFr_Produtos.create(nil);
  Try
    Form.ShowModal;
  Finally
    FreeAndNil( Form );
  End;
end;

procedure TSeaProduct.WhereSql;
begin
  inherited;
  WhereTxt := concat(
                ' WHERE PRO_CODIGO IS NOT NULL  '
  );

  if  Rg_Imagem.ItemIndex = 1 then
    WhereTxt := concat(
                    WhereTxt,
                   ' AND (table_id is null) '
    );

  if E_BuscaCodigo.Text <> '' then
  Begin
    WhereTxt := concat(
                    WhereTxt,
                    ' AND (PRO_CODIGO =:PRO_CODIGO) '
    );
  End;

  if E_BuscaCodigoFabrica.Text <> '' then
  Begin
    WhereTxt := concat(
                    WhereTxt,
                    'AND ((PRO_CODIGOFAB LIKE :PRO_CODIGOFAB) or (PRO_CODIGOFOR LIKE :PRO_CODIGOFAB))'
    );
  End;

  if E_BuscaCodBarras.Text <> '' then
  Begin
    WhereTxt := concat(
                    WhereTxt,
                    'AND (PRO_CODIGOBAR =:PRO_CODIGOBAR) '
    );
  End;

  if E_BuscaDescricao.Text <> '' then
  Begin
    WhereTxt := concat(
                    WhereTxt,
                    'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) '
    );
  End;

  if E_BuscaGrupo.Text <> '' then
  Begin
    WhereTxt := concat(
                    WhereTxt,
                    ' AND (GRP_DESCRICAO LIKE :GRP_DESCRICAO) '
    );
  End;

  if E_BuscaSubgrupo.Text <> '' then
  Begin
    WhereTxt := concat(
                    WhereTxt,
                    'AND (SBG_DESCRICAO LIKE :SBG_DESCRICAO) '
    );
  End;

  if E_BuscaMarca.Text <> '' then
  Begin
    WhereTxt := concat(
                    WhereTxt,
                    ' AND (MRC_DESCRICAO LIKE :MRC_DESCRICAO) '
    );
  End;

  if E_BuscaLocal.Text <> '' then
  Begin
    WhereTxt := concat(
                    WhereTxt,
                    ' AND (PRO_LOCAL LIKE :PRO_LOCAL) '
    );
  End;

  if E_BuscaAplicacao.Text <> '' then
  Begin
    WhereTxt := concat(
                    WhereTxt,
                    'AND (PRO_APLICACAO LIKE :PRO_APLICACAO) '
    );
  End;

  if ChBx_Inativos.Checked then
    WhereTxt := concat(WhereTxt,'AND (PRO_ATIVO = ''N'') ')
  else
    WhereTxt := concat(WhereTxt,'AND (PRO_ATIVO = ''S'') ');

  if ChBx_BuscaForaLinha.Checked then
    WhereTxt := concat(WhereTxt,'AND (PRO_FORA_LINHA = ''S'') ')
  else
    WhereTxt := concat(WhereTxt,'AND (PRO_FORA_LINHA = ''N'') ');

  if chbx_comissao.Checked then
    WhereTxt := concat(WhereTxt,'AND ( (PRC_AQ_COM = 0) OR (PRC_AQ_COM IS NULL) )');
  case Rg_Publicacao.ItemIndex of
    0:WhereTxt := concat(WhereTxt,' AND (PRO_INTERNET = ''S'') ');
    1:WhereTxt := concat(WhereTxt,' AND (PRO_INTERNET= ''N'') ');
  END;

  case Cb_BuscaTipo.ItemIndex of
    1:WhereTxt := concat(WhereTxt,' AND (PRO_TIPO = ''P'') ');
    2:WhereTxt := concat(WhereTxt,' AND (PRO_TIPO = ''M'') ');
    3:WhereTxt := concat(WhereTxt,' AND (PRO_TIPO = ''C'') ');
  else
    WhereTxt := concat(WhereTxt,' AND (PRO_TIPO <> ''S'') ');
  END;
  //nunca Trazer os produtos Automaticos do Cardapio ou qualquer outro automatico
  WhereTxt := concat(WhereTxt,' AND (PRO_TIPO <> ''A'') ');
  case Rg_Est_Neg.ItemIndex of
    0:WhereTxt := concat(WhereTxt,' AND ( PRO_EST_NEG = ''S'') ');
    1:WhereTxt := concat(WhereTxt,' AND ( PRO_EST_NEG= ''N'') ');
  END;

  case Rg_busca_fixed_rate.ItemIndex of
    0:WhereTxt := concat(WhereTxt,' AND ( FIXED_RATE = ''S'') ');
    1:WhereTxt := concat(WhereTxt,' AND ( FIXED_RATE = ''N'') ');
  end;


  if not GB_ProdCompartilha then
    WhereTxt := concat(WhereTxt,' AND PRO_CODMHA = :PRO_CODMHA');

  if Chbx_ncm_invalido.Checked then
    WhereTxt := concat(WhereTxt,' AND n.ncm_n_ncm is null ');

end;

end.
