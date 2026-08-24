unit Un_Pesq_Servico;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Grids, DBGrids, Buttons, ExtCtrls, ComCtrls, DB, STQuery, Mask, Menus, DBCtrls, CheckLst, System.Math, FavoritoButtons, STStoredProc, QEdit_Setes;

type
   TFr_Pesq_Servico = class(TForm)
     Qr_Pesquisa: TSTQuery;
     Ds_Pesquisa: TDataSource;
     Qr_Preco_Qtde: TSTQuery;
    Qr_Movimento: TSTQuery;
    Pn_Pesquisa: TPanel;
    Grd_Pesquisa: TDBGrid;
    GrBx_Pesquisa: TGroupBox;
    Lb_Codigo: TLabel;
    Lb_Descricao: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    E_BuscaCodigo: TEdit_Setes;
    E_BuscaDescricao: TMaskEdit;
    E_BuscaSubgrupo: TMaskEdit;
    E_BuscaGrupo: TMaskEdit;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    Panel1: TPanel;
    SB_Buscar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    Chbx_Promocao: TCheckBox;
    Chb_Digitacao: TCheckBox;
    Sb_Servicos: TSpeedButton;
    SpeedButton1: TSpeedButton;
     procedure SB_BuscarClick(Sender: TObject);
     procedure SB_VisualizarClick(Sender: TObject);
     procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
     procedure FormKeyPress(Sender: TObject; var Key: Char);
     procedure Sb_Sair_0Click(Sender: TObject);
     procedure FormClose(Sender: TObject; var Action: TCloseAction);
     procedure FormShow(Sender: TObject);
     procedure Qr_PesquisaAfterOpen(DataSet: TDataSet);
     procedure Grd_PesquisaTitleClick(Column: TColumn);
    procedure FormActivate(Sender: TObject);
    procedure Chb_DigitacaoClick(Sender: TObject);
    procedure Grd_PesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure Grd_PesquisaDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure Qr_PesquisaCalcFields(DataSet: TDataSet);
    procedure Grd_PesquisaDblClick(Sender: TObject);
    procedure Sb_ServicosClick(Sender: TObject);
    procedure E_BuscaDescricaoChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
   private
    { Private declarations }
   public
    { Public declarations }
     It_Cd_Empresa : Integer;
     It_Col_VL_Normal : Integer;
     It_Col_VL_Promocao : Integer;
     It_MultiplicadorPreco: Currency;
     It_Visualizar : boolean;
     procedure PC_Buscar;
     procedure Pc_DefineEstiloServico;
     procedure Pc_FormataCasas;
     procedure Pc_Busca_Preco(Pc_Cd_Tabela :Integer; Pc_Cd_Servico :Integer);
   end;

var
   Fr_Pesq_Servico: TFr_Pesq_Servico;

implementation

uses     Un_DM, Un_Funcoes, UN_Pedido_Vda, UN_Sistema, Un_Cotacao, Un_Liberacao, Un_Regra_Negocio, RN_Permissao, reg_service, Un_Pesq_Produto, UN_Principal, env;
{$R *.dfm}


procedure TFr_Pesq_Servico.Pc_Busca_Preco(Pc_Cd_Tabela :Integer; Pc_Cd_Servico :Integer);
BEgin
  Qr_Preco_Qtde.Active := False;
  Qr_Preco_Qtde.ParamByName('PRC_CODPRO').AsInteger := Pc_Cd_Servico;
  Qr_Preco_Qtde.ParamByName('PRC_CODTPR').AsInteger := Pc_Cd_Tabela;
  Qr_Preco_Qtde.Active := True;
  Qr_Preco_Qtde.FetchAll;
  Qr_Preco_Qtde.First;
end;

procedure TFr_Pesq_Servico.Pc_DefineEstiloServico;
begin
  Caption := 'Pesquisa de Serviços';

end;


procedure TFr_Pesq_Servico.PC_Buscar;
var
   Sqltxt: string;
   Lc_Codigo: boolean;
   Lc_Descricao: boolean;
   Lc_Grupo: boolean;
   Lc_SubGrupoo: boolean;
   Lc_Marca: boolean;
   Lc_Aplicacao: boolean;
   Lc_CodigoInteiro: Integer;
   Lc_Barras: Boolean;
begin
   sqltxt := '';
   Screen.Cursor := crHourGlass;
  if Trim(E_BuscaCodigo.Text)    = '' then Lc_Codigo    := False else Lc_Codigo    := True;
  if Trim(E_BuscaDescricao.Text) = '' then Lc_Descricao := False else Lc_Descricao := True;
  if Trim(E_BuscaGrupo.Text)     = '' then Lc_Grupo     := False else Lc_Grupo     := True;
  if Trim(E_BuscaSubgrupo.Text)  = '' then Lc_SubGrupoo := False else Lc_SubGrupoo := True;
  Qr_Pesquisa.Close;
  Qr_Pesquisa.Sql.Clear;
  Sqltxt := ' SELECT DISTINCT '+
             '  PRO_CODIGO '+
             ' ,PRO_CODIGOFAB '+
             ' ,PRO_DESCRICAO '+
             ' ,PRO_CAMPANHA '+
             ' ,MED_ABREVIATURA '+
             ' ,GRP_DESCRICAO '+
             ' ,SBG_DESCRICAO '+
             ' ,tb_normal.prc_vl_vda PRC_VL_NORMAL '+
             ' ,tb_promocao.prc_vl_vda PRC_VL_PROMOCAO '+
             'FROM TB_PRODUTO tb_produto '+
             '  INNER JOIN tb_preco tb_normal '+
             '  ON ((tb_normal.prc_codpro = tb_produto.pro_codigo) and (tb_normal.PRC_CODTPR = 1)) '+
             '  LEFT OUTER JOIN tb_preco tb_promocao '+
             '  ON ((tb_promocao.prc_codpro = tb_produto.pro_codigo) and (tb_promocao.prc_codtpr = 2)) '+
             '  INNER JOIN TB_MEDIDA tb_medida                      '+
             '  ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)  '+
             '  INNER JOIN TB_GRUPOS tb_grupos                      '+
             '  ON (tb_produto.PRO_CODGRP = tb_grupos.GRP_CODIGO)   '+
             '  INNER JOIN TB_SUBGRUPOS tb_subgrupo                 '+
             '  ON (tb_produto.PRO_CODSBG = tb_subgrupo.SBG_CODIGO) '+
             'WHERE  (PRO_ATIVO = ''S'') and (PRO_TIPO = ''S'') ';


  IF Lc_Codigo then
    Sqltxt := Sqltxt + ' AND ( PRO_CODIGO =:PRO_CODIGO ) ';
  if Lc_Descricao then
    Sqltxt := Sqltxt + ' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';
  if Lc_Grupo then
    Sqltxt := Sqltxt + ' AND (GRP_DESCRICAO LIKE :GRP_DESCRICAO) ';
  if Lc_SubGrupoo then
    Sqltxt := Sqltxt + ' AND (SBG_DESCRICAO LIKE :SBG_DESCRICAO) ';
  if Chbx_Promocao.Checked then
    Sqltxt := Sqltxt + ' AND (PRO_CAMPANHA = ''S'') ';
  if not GB_ProdCompartilha then
    Sqltxt:=Sqltxt+ ' AND PRO_CODMHA = :PRO_CODMHA ';

  Qr_Pesquisa.SQL.Add(sqltxt + ' ORDER BY PRO_DESCRICAO');

  if not GB_ProdCompartilha then
    Qr_Pesquisa.ParamByName('PRO_CODMHA').AsInteger:=Gb_CodMha;
  if Lc_Codigo then
    Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := E_BuscaCodigo.Text;
  if Lc_Descricao then
    Qr_Pesquisa.ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(E_BuscaDescricao.Text,1,98) + '%';
  if Lc_Grupo then
    Qr_Pesquisa.ParamByName('GRP_DESCRICAO').AsString := '%' + E_BuscaGrupo.Text + '%';
  if Lc_SubGrupoo then
    Qr_Pesquisa.ParamByName('SBG_DESCRICAO').AsString := '%' + E_BuscaSubgrupo.Text + '%';

  if DM.IBT_Estoque.InTransaction then DM.IBT_Estoque.Commit;
  Qr_Pesquisa.Open;
  Screen.Cursor := crDefault;
end;

procedure TFr_Pesq_Servico.SB_BuscarClick(Sender: TObject);
begin
  PC_Buscar;
end;

procedure TFr_Pesq_Servico.SB_VisualizarClick(Sender: TObject);
begin
  It_Visualizar := True;
  close;
end;

procedure TFr_Pesq_Servico.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_RETURN :Begin
                 if Grd_Pesquisa.Focused then
                 if SB_Visualizar.Enabled then SB_VisualizarClick(sender);
                 end;
      VK_F7: if SB_Buscar.Enabled     then SB_BuscarClick(Sender);
      VK_F8: if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
      VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
    end;
end;

procedure TFr_Pesq_Servico.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13)  and not (ActiveControl is TDBGrid) then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

procedure TFr_Pesq_Servico.Sb_Sair_0Click(Sender: TObject);
begin
  It_Visualizar := False;
  close;
end;

procedure TFr_Pesq_Servico.FormClose(Sender: TObject;
   var Action: TCloseAction);
begin
  if (Gb_Nivel = 1) then Gb_Liberado := True else Gb_Liberado := False;
end;

procedure TFr_Pesq_Servico.FormShow(Sender: TObject);
begin
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  Chb_Digitacao.Checked := (Fc_Aq_Geral('L','PESQUISA','DIGITACAO','') = 'S');
  //Se os campos de pesquisa foram preenchidos executar pesquisa;
  if (Trim(E_BuscaCodigo.Text)<> '') or (Trim(E_BuscaDescricao.Text)<> '') then
    PC_Buscar; 
  E_BuscaCodigo.SetFocus;
end;

procedure TFr_Pesq_Servico.Qr_PesquisaAfterOpen(DataSet: TDataSet);
begin
  Pc_FormataCasas;
end;

procedure TFr_Pesq_Servico.Pc_FormataCasas;
begin
  if (Qr_Pesquisa.Active = True) then
    begin
    (Qr_Pesquisa.FieldByName('PRC_VL_NORMAL') as TNumericField).DisplayFormat     := Gb_Casa_Dec_Venda;
    (Qr_Pesquisa.FieldByName('PRC_VL_PROMOCAO') as TNumericField).DisplayFormat := Gb_Casa_Dec_Venda;
    end;
end;


procedure TFr_Pesq_Servico.Grd_PesquisaTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(Grd_Pesquisa, Column);
end;

procedure TFr_Pesq_Servico.FormActivate(Sender: TObject);
begin
  if Assigned(Fr_Liberacao) then
    Fr_Liberacao.BringToFront;
end;





procedure TFr_Pesq_Servico.Chb_DigitacaoClick(Sender: TObject);
begin
  if Chb_Digitacao.Checked then Fc_Aq_Geral('G','PESQUISA','DIGITACAO','S') else Fc_Aq_Geral('G','PESQUISA','DIGITACAO','N');
end;

procedure TFr_Pesq_Servico.Grd_PesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13)   then
    begin
    Key := #0;
    if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
    end;
end;

procedure TFr_Pesq_Servico.Grd_PesquisaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  Grd_Pesquisa.Canvas.Font.Color := clBlack;
  Grd_Pesquisa.Canvas.Font.Style := [];
  if Ds_Pesquisa.DataSet.FieldByName('PRO_CAMPANHA').AsString = 'S' then
    Begin
    IF (DataCol = It_Col_VL_Normal) then
      Grd_Pesquisa.Canvas.Font.Style := [fsStrikeOut];
    if (not(State = [gdSelected]))  then
      Grd_Pesquisa.Canvas.Font.Color := clNavy
    else
      Grd_Pesquisa.Canvas.Font.Color := clBlack;
    end
end;

procedure TFr_Pesq_Servico.Qr_PesquisaCalcFields(DataSet: TDataSet);
begin
  if Qr_Pesquisa.FieldByName('PRO_CAMPANHA').AsString = 'N' then  Qr_Pesquisa.FieldByName('PRC_VL_PROMOCAO').AsCurrency := 0;
end;



procedure TFr_Pesq_Servico.Grd_PesquisaDblClick(Sender: TObject);
begin
  if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
end;

procedure TFr_Pesq_Servico.Sb_ServicosClick(Sender: TObject);
Var
  Lc_Form : TRegService;
begin
  if Fc_VerificaPermissao('Fr_Servico','Cadastro de Serviços','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Lc_Form := TRegService.Create(nil);
    if Qr_Pesquisa.Active  then
      Lc_Form.CodigoRegistro := Qr_Pesquisa.FieldByname('PRO_CODIGO').AsInteger
    else
      Lc_Form.CodigoRegistro := 0;
    Try
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
    End;
  end;
end;

procedure TFr_Pesq_Servico.E_BuscaDescricaoChange(Sender: TObject);
begin
  if Chb_Digitacao.Checked then
    Begin
    PC_Buscar;
    end;
end;

procedure TFr_Pesq_Servico.SpeedButton1Click(Sender: TObject);
begin
  If not Assigned(Fr_Pesq_Produto)then (Application.CreateForm(TFr_Pesq_Produto, Fr_Pesq_Produto));
  Fr_Pesq_Produto.Show;
  Fr_Pesq_Produto.BringToFront;
  Close;
end;

end.
