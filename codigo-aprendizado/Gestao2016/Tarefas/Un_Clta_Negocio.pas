unit Un_Clta_Negocio;

interface

uses
      Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, ComCtrls, Buttons, Grids, DBGrids, jpeg, STQuery, Variants, Menus, QEdit_Setes, Un_Fm_ListaProdutos, Un_Fm_ListaEstoques;

type
  TFr_Clta_Negocio = class(TForm)
    GroupBox1: TGroupBox;
    E_Data_Ini_NFL: TDateTimePicker;
    E_Data_Fim_NFL: TDateTimePicker;
    ChBx_Periodo_Geral: TCheckBox;
    Label2: TLabel;
    E_Busca_Cd_Empresa: TMaskEdit;
    Sb_Empresa: TSpeedButton;
    Rg_TipoMovimentacao: TRadioGroup;
    Rg_SentidoMovimento: TRadioGroup;
    Rg_TipoEmpresa: TRadioGroup;
    GroupBox2: TGroupBox;
    Qr_PesquisaEstoque: TSTQuery;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    Ds_PesquisaEstoque: TDataSource;
    SB_Sair_0: TSpeedButton;
    SB_Buscar: TSpeedButton;
    Cb_Busca_Empresa: TComboBox;
    Pg_Informacao: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Label14: TLabel;
    DBLCB_Marca: TDBLookupComboBox;
    Label15: TLabel;
    Dblcb_Negocio: TDBLookupComboBox;
    Sb_Negocio: TSpeedButton;
    Panel3: TPanel;
    Panel4: TPanel;
    GroupBox6: TGroupBox;
    Label16: TLabel;
    Label18: TLabel;
    E_VL_Pagar: TEdit_Setes;
    E_VL_Pago: TEdit_Setes;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    Label27: TLabel;
    E_VL_Saldo_Liquido: TEdit_Setes;
    Dbg_Financeiro: TDBGrid;
    Rg_Data: TRadioGroup;
    E_Data_Ini_FIN: TDateTimePicker;
    E_Data_Fim_FIN: TDateTimePicker;
    ChBx_Periodo_Financeiro: TCheckBox;
    Rg_Situacao: TRadioGroup;
    Label17: TLabel;
    Label20: TLabel;
    E_VL_Receber: TEdit_Setes;
    E_VL_Recebido: TEdit_Setes;
    RG_Financeiro: TRadioGroup;
    Qr_PesquisaFinanceiro: TSTQuery;
    Ds_PesquisaFinanceiro: TDataSource;
    Label19: TLabel;
    E_VL_Tl_Pagar: TEdit_Setes;
    Label21: TLabel;
    E_VL_TL_Receber: TEdit_Setes;
    Pg_Estoque: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    DBG_Movimento: TDBGrid;
    Dbg_Saldo: TDBGrid;
    Qr_PesquisaSaldo: TSTQuery;
    Ds_PesquisaSaldo: TDataSource;
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    Lb_Faturamento: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    E_Cpa_Realizada: TEdit_Setes;
    E_Cpa_Media: TEdit_Setes;
    E_Cpa_Qtde: TEdit_Setes;
    E_Cpa_Valor: TEdit_Setes;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    E_Vda_Realizada: TEdit_Setes;
    E_Vda_Media: TEdit_Setes;
    E_Vda_Qtde: TEdit_Setes;
    E_Vda_Valor: TEdit_Setes;
    GroupBox5: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    E_Ajt_Realizada: TEdit_Setes;
    E_Ajt_Media: TEdit_Setes;
    E_Ajt_Qtde: TEdit_Setes;
    E_Ajt_Valor: TEdit_Setes;
    Fm_ListaProdutos: TFm_ListaProdutos;
    Fm_ListaEstoques: TFm_ListaEstoques;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_BuscarClick(Sender: TObject);
    procedure ChBx_Periodo_GeralClick(Sender: TObject);
    procedure DBG_MovimentoTitleClick(Column: TColumn);
    procedure Rg_Filtro_SituacaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure Rg_TipoMovimentacaoClick(Sender: TObject);
    procedure Rg_TipoEmpresaClick(Sender: TObject);
    procedure Qr_PesquisaEstoqueCalcFields(DataSet: TDataSet);
    procedure E_Busca_Cd_EmpresaExit(Sender: TObject);
    procedure Sb_EmpresaClick(Sender: TObject);
    procedure DBLCB_MarcaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChBx_Periodo_FinanceiroClick(Sender: TObject);
    procedure Qr_PesquisaFinanceiroCalcFields(DataSet: TDataSet);
    procedure Sb_NegocioClick(Sender: TObject);
    procedure Dbg_SaldoTitleClick(Column: TColumn);
    procedure Dbg_FinanceiroTitleClick(Column: TColumn);


  private
    { Private declarations }
  public
    { Public declarations }
    It_VL_Compras: Currency;
    It_Qt_Compras : Real;
    It_Nr_Compras : real;

    It_VL_Vendas: Currency;
    It_Qt_Vendas : Real;
    It_Nr_Vendas : real;

    It_Qt_Entrada  : Real;
    It_Qt_Saida   : Real;
    It_Nr_Ajustes : real;
    It_VL_Ajustes: Currency;

    It_VL_Pagar: Currency;
    It_VL_Pago: Currency;

    It_VL_Receber: Currency;
    It_VL_Recebido: Currency;

    procedure Pc_Formatatela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_Ativartabelas;

    procedure Pc_BuscarMovimento;
    procedure Pc_CalculaMovimento;
    procedure Pc_TotalizaMovimento;

    procedure Pc_BuscarSaldo;
    procedure Pc_CalculaSaldo;
    procedure Pc_TotalizaSaldo;


    procedure Pc_BuscarFinanceiro;
    procedure Pc_CalculaFinanceiro;
    procedure Pc_TotalizaFinanceiro;

    procedure Pc_PermissaoBotao(Pc_Menu: string);

    procedure Pc_ImagemBotao;
    procedure Pc_AbreTelaCliente;
    procedure Pc_AbreTelaFornecedor;

  end;

var
  Fr_Clta_Negocio: TFr_Clta_Negocio;

implementation

uses     Un_DM, Un_Produtos, UN_Sistema, Un_Fich_Fin_Cli, Un_Nota_Fiscal, Un_Imp_Mod_Impressao, Un_Regra_Negocio, UN_Principal, env, RN_Estoque, RN_Fornecedor, RN_Cliente, RN_Empresa, sea_business;
{$R *.DFM}

procedure TFr_Clta_Negocio.Pc_Ativartabelas;
Begin
  Fm_ListaEstoques.AtivaLista(Gb_CodMha);
  DM.Qr_MarcaProduto.Active := True;
  DM.Qr_Negocio.Active := True;
  Dblcb_Negocio.KeyValue := DM.Qr_Negocio.FieldByname('NEG_CODIGO').AsInteger;
end;

procedure TFr_Clta_Negocio.Pc_IniciaVariaveis;
Begin
  Rg_TipoMovimentacao.ItemIndex := 3;
  Rg_SentidoMovimento.ItemIndex := 2;
  Rg_TipoEmpresa.ItemIndex := 2;
  E_Data_Ini_NFL.Date:=date;
  E_Data_Fim_NFL.Date:=date;
  E_Data_Ini_FIN.Date:=date;
  E_Data_Fim_FIN.Date:=date;

  E_Busca_Cd_Empresa.Clear;
  Fm_ListaProdutos.E_Cd_Produto.Clear;
  Fm_ListaProdutos.E_Busca_Produto.Clear;
  Pc_ListaFornecedorComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,Cb_Busca_Empresa);
  Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Fm_ListaEstoques.Qr_Estoques.FieldByname('ETS_CODIGO').AsInteger;
end;

procedure TFr_Clta_Negocio.Pc_Formatatela;
Begin


end;


procedure TFr_Clta_Negocio.FormClose(Sender: TObject;
var
    Action: TCloseAction);
begin
  Action:=caFree;
  Fr_Clta_Negocio := Nil;
end;

procedure TFr_Clta_Negocio.Pc_BuscarMovimento;
VaR
  Lc_SqlTxt : String;
begin
  Screen.Cursor:=crHourGlass;
  with Qr_PesquisaEstoque do
    Begin
    Close;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT PED_TIPO, NFL_DT_EMISSAO,NFL_STATUS, NFL_TIPO,PRO_CODIGOFAB, '+
                 'PRO_DESCRICAO, NFL_NUMERO,PED_NUMERO, '+
                 'ITF_QTDE,ITF_VL_UNIT,(ITF_QTDE* ITF_VL_UNIT) as ITV_SUBTOTAL '+
                 'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
                 '    INNER JOIN TB_EMPRESA tb_empresa '+
                 '    ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
                 '    INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
                 '    ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO) '+
                 '    INNER JOIN TB_PEDIDO tb_pedido '+
                 '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
                 '    INNER JOIN TB_PRODUTO tb_produto '+
                 '    ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) '+
                 'WHERE (NFL_CODIGO IS NOT NULL) ';

    case Rg_TipoMovimentacao.ItemIndex of
      0: Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_TIPO = 2) ';
      1: Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_TIPO = 1) ';
      2: Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_TIPO = 3) ';
    end;

    case Rg_SentidoMovimento.ItemIndex of
      0: Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_TIPO LIKE ''E%'') ';
      1: Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_TIPO LIKE ''S%'') ';
    end;

    IF ChBx_Periodo_Geral.Checked then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ';

    IF Trim(E_Busca_Cd_Empresa.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_CODEMP =:EMP_CODIGO) ';

    IF Trim(Cb_Busca_Empresa.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ( (EMP_NOME LIKE :EMP_NOME) OR (EMP_FANTASIA LIKE :EMP_NOME) )';

    IF Trim(Dblcb_Negocio.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ( PED_CODNEG =:PED_CODNEG )';
      
    if Trim(Fm_ListaProdutos.E_Cd_Produto.Text) <> '' then
      Begin
      IF (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S') then
        Begin
        If StrToIntDef(Fm_ListaProdutos.E_Busca_Produto.Text,0) >0 then
          Begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGO =:PRO_CODIGO) or (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO) ) ';
          end
        else
          begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO) ) ';
          end;
        end
      else
        Begin
        If StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0) >0 then
          Begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGO LIKE :PRO_CODIGO) or (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) ) ';
          end
        else
          begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) ) ';
          end;
        end;
      end;

    if Trim(Fm_ListaProdutos.E_Busca_Produto.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

    if Trim(DBLCB_Marca.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_CODMRC =:PRO_CODMRC) ';

    Lc_SqlTxt := Lc_SqlTxt + 'AND (ITF_CODEST =:ITF_CODEST) ';

    SQL.Add(Lc_SqlTxt + ' ORDER BY  NFL_DT_EMISSAO, PRO_DESCRICAO ');

    //Passagem de Paramentros
    IF ChBx_Periodo_Geral.Checked then
      Begin
      ParamByName('DATAINI').AsDate := E_Data_Ini_NFL.Date;
      ParamByName('DATAFIM').AsDate := E_Data_Fim_NFL.Date;
      end;

    IF Trim(E_Busca_Cd_Empresa.Text) <> '' then
      ParamByName('EMP_CODIGO').AsString := E_Busca_Cd_Empresa.Text;

    IF Trim(Cb_Busca_Empresa.Text) <> '' then
      ParamByName('EMP_NOME').AsString := '%' + Copy(Cb_Busca_Empresa.Text,1,98) + '%';

    IF Trim(Dblcb_Negocio.Text) <> '' then
      ParamByName('PED_CODNEG').AsInteger := Dblcb_Negocio.KeyValue;

    if Trim(Fm_ListaProdutos.E_Busca_Produto.Text) <> '' then
      Begin
      IF (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S') then
        Begin
        ParamByName('PRO_CODIGO').AsString := Fm_ListaProdutos.E_Cd_Produto.Text;
        end
      else
        Begin
        ParamByName('PRO_CODIGO').AsString := '%' + Fm_ListaProdutos.E_Cd_Produto.Text + '%';
        end;
      end;

    if Trim(Fm_ListaProdutos.E_Busca_Produto.Text) <> '' then
      ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(Fm_ListaProdutos.E_Busca_Produto.Text,1,98) + '%';

    if Trim(DBLCB_Marca.Text) <> '' then
      ParamByName('PRO_CODMRC').AsInteger := DBLCB_Marca.KeyValue;

    ParamByName('ITF_CODEST').AsInteger := Fm_ListaEstoques.DBLCB_Estoque.KeyValue;
    Open;
    Screen.Cursor:=crDefault;
    end;
end;

procedure TFr_Clta_Negocio.Pc_CalculaMovimento;
begin
  DBG_Movimento.Visible := False;
  It_VL_Compras := 0;
  It_Qt_Compras := 0;
  It_Nr_Compras := 0;

  It_VL_Vendas := 0;
  It_Qt_Vendas := 0;
  It_Nr_Vendas := 0;

  It_Qt_Entrada := 0;
  It_Qt_Saida := 0;
  It_Nr_Ajustes := 0;
  It_VL_Ajustes := 0;

  with Qr_PesquisaEstoque do
    Begin
    First;
    while not Eof do
      Begin
      if (FieldByName('NFL_TIPO').AsString = 'SI') OR (FieldByName('NFL_TIPO').AsString = 'SE') THEN
        begin
        //Verifica se é saida e se está faturada para não contar as canceladas
        IF FieldByName('NFL_STATUS').AsString = 'F' THEN
          Begin
          case FieldByName('PED_TIPO').AsInteger of
            1:Begin
              It_Nr_Vendas := It_Nr_Vendas + 1;
              It_VL_Vendas := It_VL_Vendas + FieldByName('ITV_SUBTOTAL').AsCurrency;
              It_Qt_Vendas := It_Qt_Vendas + FieldByName('ITF_QTDE').AsFloat;
              end;
            3:Begin
              It_Nr_Ajustes := It_Nr_Ajustes + 1;
              It_VL_Ajustes := It_VL_Ajustes + FieldByName('ITV_SUBTOTAL').AsCurrency;
              It_Qt_Saida := It_Qt_Saida + FieldByName('ITF_QTDE').AsFloat;
              end;
            end;
          end;
        end;
      //Verifica se entrada e se está faturada para não contar as canceladas
      if (FieldByName('NFL_TIPO').AsString = 'EI') OR (FieldByName('NFL_TIPO').AsString = 'EE') THEN
        begin
        IF FieldByName('NFL_STATUS').AsString = 'F' THEN
          Begin
          case FieldByName('PED_TIPO').AsInteger of
            2:Begin
              It_Nr_Compras := It_Nr_Compras + 1;
              It_VL_Compras := It_VL_Compras + FieldByName('ITV_SUBTOTAL').AsCurrency;
              It_Qt_Compras := It_Qt_Compras + FieldByName('ITF_QTDE').AsFloat;
              end;
            3:Begin
              It_Nr_Ajustes := It_Nr_Ajustes + 1;
              It_VL_Ajustes := It_VL_Ajustes + FieldByName('ITV_SUBTOTAL').AsCurrency;
              It_Qt_Entrada := It_Qt_Entrada + FieldByName('ITF_QTDE').AsFloat;
              end;
            end;
          end;
        end;
      Next;
      end;
    First;
    end;
  DBG_Movimento.Visible := true;
end;

procedure TFr_Clta_Negocio.Pc_TotalizaMovimento;
Var
  Lc_Nr_Meses : Integer;
Begin
  //Totaliza as compras
  E_Cpa_Realizada.Text := FloatToStrF(It_Nr_Compras,ffNumber,10,2);
  E_Cpa_Qtde.Text := FloatToStrF(It_Qt_Compras,ffNumber,10,2);
  if (It_Nr_Compras > 0) then
    E_Cpa_Media.Text := FloatToStrF(It_Qt_Compras/It_Nr_Compras,ffFixed,10,2)
  else
    E_Cpa_Media.Text := '0,00';
  E_Cpa_Valor.Text := FloatToStrF(It_VL_Compras,ffNumber,10,2);

  //Totaliza as Vendas
  E_Vda_Realizada.Text := FloatToStrF(It_Nr_Vendas,ffNumber,10,2);
  E_Vda_Qtde.Text := FloatToStrF(It_Qt_Vendas,ffNumber,10,2);
  //Verifica o numero de dias depois o nr de meses
  Lc_Nr_Meses := trunc((E_Data_Fim_NFL.Date - E_Data_Ini_NFL.Date));
  Lc_Nr_Meses := Trunc(Lc_Nr_Meses/30);
  if Lc_Nr_Meses <=0 then Lc_Nr_Meses := 1;
  if (It_Nr_Vendas > 0) then
    E_Vda_Media.Text := FloatToStrF(It_Qt_Vendas/Lc_Nr_Meses,ffFixed,10,2)
  else
    E_Vda_Media.Text := '0,00';
  E_Vda_Valor.Text := FloatToStrF(It_VL_Vendas,ffNumber,10,2);

  //Totaliza os Ajustes
  E_Ajt_Realizada.Text := FloatToStrF(It_Nr_Ajustes,ffNumber,10,2);
  E_Ajt_Qtde.Text := FloatToStrF((It_Qt_Entrada + It_Qt_Saida),ffNumber,10,2);
  if (It_Nr_Ajustes > 0) then
    E_Ajt_Media.Text := FloatToStrF((It_Qt_Entrada + It_Qt_Saida)/It_Nr_Ajustes,ffFixed,10,2)
  else
    E_Ajt_Media.Text := '0,00';
  E_Ajt_Valor.Text := FloatToStrF(It_VL_Ajustes,ffNumber,10,2);

end;

procedure TFr_Clta_Negocio.Pc_BuscarSaldo;
VaR
  Lc_SqlTxt : String;
begin
  Screen.Cursor:=crHourGlass;
  with Qr_PesquisaSaldo do
    Begin
    Close;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT DISTINCT PRO_CODIGO,PRO_CODIGOFAB,PRO_DESCRICAO,EST_QTDE '+
                 'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
                 '    INNER JOIN TB_EMPRESA tb_empresa '+
                 '    ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
                 '    INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
                 '    ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO) '+
                 '    INNER JOIN TB_PEDIDO tb_pedido '+
                 '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
                 '    INNER JOIN TB_PRODUTO tb_produto '+
                 '    ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) '+
                 '    INNER JOIN TB_ESTOQUE tb_estoque '+
                 '    ON (tb_estoque.EST_CODPRO = tb_produto.PRO_CODIGO) '+
                 'WHERE (NFL_CODIGO IS NOT NULL) and (EST_QTDE <> 0) ';

    case Rg_TipoMovimentacao.ItemIndex of
      0: Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_TIPO = 2) ';
      1: Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_TIPO = 1) ';
      2: Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_TIPO = 3) ';
    end;

    case Rg_SentidoMovimento.ItemIndex of
      0: Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_TIPO LIKE ''E%'') ';
      1: Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_TIPO LIKE ''S%'') ';
    end;

    IF ChBx_Periodo_Geral.Checked then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ';

    IF Trim(E_Busca_Cd_Empresa.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_CODEMP =:EMP_CODIGO) ';

    IF Trim(Cb_Busca_Empresa.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ( (EMP_NOME LIKE :EMP_NOME) OR (EMP_FANTASIA LIKE :EMP_NOME) )';

    IF Trim(Dblcb_Negocio.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ( PED_CODNEG =:PED_CODNEG )';

    IF Trim(Fm_ListaEstoques.Dblcb_Estoque.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ( EST_CODETS=:ETS_CODIGO )';


    if Trim(Fm_ListaProdutos.E_Cd_Produto.Text) <> '' then
      Begin
      IF (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S') then
        Begin
        If StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0) >0 then
          Begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGO =:PRO_CODIGO) or (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO) ) ';
          end
        else
          begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO) ) ';
          end;
        end
      else
        Begin
        If StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0) >0 then
          Begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGO LIKE :PRO_CODIGO) or (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) ) ';
          end
        else
          begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) ) ';
          end;
        end;
      end;

    if Trim(Fm_ListaProdutos.E_Busca_Produto.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

    if Trim(DBLCB_Marca.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_CODMRC =:PRO_CODMRC) ';

    SQL.Add(Lc_SqlTxt + ' ORDER BY  NFL_DT_EMISSAO, PRO_DESCRICAO ');

    //Passagem de Paramentros
    IF ChBx_Periodo_Geral.Checked then
      Begin
      ParamByName('DATAINI').AsDate := E_Data_Ini_NFL.Date;
      ParamByName('DATAFIM').AsDate := E_Data_Fim_NFL.Date;
      end;

    IF Trim(E_Busca_Cd_Empresa.Text) <> '' then
      ParamByName('EMP_CODIGO').AsString := E_Busca_Cd_Empresa.Text;

    IF Trim(Cb_Busca_Empresa.Text) <> '' then
      ParamByName('EMP_NOME').AsString := '%' + Copy(Cb_Busca_Empresa.Text,1,98) + '%';

    IF Trim(Dblcb_Negocio.Text) <> '' then
      ParamByName('PED_CODNEG').AsInteger := Dblcb_Negocio.KeyValue;

    if Trim(Fm_ListaProdutos.E_Cd_Produto.Text) <> '' then
      Begin
      IF (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S') then
        Begin
        ParamByName('PRO_CODIGO').AsString := Fm_ListaProdutos.E_Cd_Produto.Text;
        end
      else
        Begin
        ParamByName('PRO_CODIGO').AsString := '%' + Fm_ListaProdutos.E_Cd_Produto.Text + '%';
        end;
      end;

    if Trim(Fm_ListaProdutos.E_Busca_Produto.Text) <> '' then
      ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(Fm_ListaProdutos.E_Busca_Produto.Text,1,98) + '%';

    if Trim(DBLCB_Marca.Text) <> '' then
      ParamByName('PRO_CODMRC').AsInteger := DBLCB_Marca.KeyValue;

    ParamByName('ETS_CODIGO').AsInteger := Fm_ListaEstoques.DBLCB_Estoque.KeyValue;
    Open;
    end;
    Screen.Cursor:=crDefault;    
end;

procedure TFr_Clta_Negocio.Pc_CalculaSaldo;
begin
end;

procedure TFr_Clta_Negocio.Pc_TotalizaSaldo;
Begin

end;


procedure TFr_Clta_Negocio.Pc_BuscarFinanceiro;
Var
  Lc_SqlTxt : String;
Begin
  Lc_SqlTxt := '';
  Screen.Cursor:=crHourGlass;
  with Qr_PesquisaFinanceiro do
    Begin
    Close;
    Sql.Clear;
    Lc_SqlTxt :=' SELECT DISTINCT '+
                 '   FIN_CODIGO, '+
                 '   NFL_NUMERO, '+
                 '   PED_NUMERO, '+
                 '   FIN_NUMERO, '+
                 '   FIN_DT_VENCIMENTO, '+
                 '   FIN_NR_PARCELA, '+
                 '   FIN_CODEMP, '+
                 '   EMP_FANTASIA, '+
                 '   EMP_NOME, '+
                 '   FIN_VL_PARCELA, '+
                 '   FIN_BAIXA,  '+
                 '   FIN_SITUACAO, '+
                 '   FIN_VL_PAGO,  '+
                 '   FIN_CODQTC,  '+
                 '   FIN_CODFPG,  '+
                 '   PED_CODIGO,  '+
                 '   NFL_CODIGO,  '+
                 '   FIN_TIPO,  '+
                 '   FIN_DT_PAGTO, '+
                 '   FIN_OPERACAO, '+
                 '   FIN_ETAPA,    '+
                 '   FIN_CODMHA, '+
                 '   FIN_CODCHQ '+
                 ' FROM TB_FINANCEIRO tb_financeiro '+
                 '   INNER JOIN TB_NOTA_FISCAL tb_nota_Fiscal '+
                 '   ON (tb_nota_Fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL)  '+
                 '   INNER JOIN TB_PEDIDO tb_pedido '+
                 '   ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED) '+
                 '   INNER JOIN TB_EMPRESA tb_empresa '+
                 '   ON (tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP) '+
                 ' WHERE FIN_CODIGO IS NOT NULL ';

    case Rg_TipoMovimentacao.ItemIndex of
      0: Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_TIPO = 2) ';
      1: Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_TIPO = 1) ';
      2: Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_TIPO = 3) ';
    end;

    case Rg_SentidoMovimento.ItemIndex of
      0: Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_TIPO LIKE ''E%'') ';
      1: Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_TIPO LIKE ''S%'') ';
    end;

    IF ChBx_Periodo_Geral.Checked then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_DT_EMISSAO BETWEEN :NFL_DATAINI AND :NFL_DATAFIM) ';

    IF Trim(E_Busca_Cd_Empresa.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_CODEMP =:EMP_CODIGO) ';

    IF Trim(Cb_Busca_Empresa.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ( (EMP_NOME LIKE :EMP_NOME) OR (EMP_FANTASIA LIKE :EMP_NOME) )';

    IF Trim(Dblcb_Negocio.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ( PED_CODNEG =:PED_CODNEG )';

    if ChBx_Periodo_Financeiro.Checked then
      Begin
      if Rg_Data.ItemIndex = 0 then
        begin
        Lc_SqlTxt := Lc_SqlTxt + 'AND (FIN_DT_VENCIMENTO BETWEEN :FIN_DATAINI AND :FIN_DATAFIM) ';
        end
      else
        begin
        Lc_SqlTxt := Lc_SqlTxt + 'AND (FIN_DT_PAGTO BETWEEN :FIN_DATAINI AND :FIN_DATAFIM) ';
        end;
      end;

    if Rg_Situacao.ItemIndex = 0 then  Lc_SqlTxt := Lc_SqlTxt + 'AND (FIN_BAIXA =''N'') ';
    if Rg_Situacao.ItemIndex = 1 then  Lc_SqlTxt := Lc_SqlTxt + 'AND (FIN_BAIXA =''S'') ';


    case RG_Financeiro.ItemIndex of
      0: Lc_SqlTxt := Lc_SqlTxt + 'AND (FIN_TIPO = ''RA'') ';
      1: Lc_SqlTxt := Lc_SqlTxt + 'AND (FIN_TIPO = ''PA'') ';
    end;

    //Passa o SQl para o Componente
    Sql.Add(Lc_SqlTxt);

    if ChBx_Periodo_Geral.Checked then
      Begin
      ParamByName('NFL_DATAINI').AsDate := E_Data_Ini_NFL.date;
      ParamByName('NFL_DATAFIM').Asdate := E_Data_Fim_NFL.Date;
      end;

    IF Trim(E_Busca_Cd_Empresa.Text) <> '' then
      ParamByName('EMP_CODIGO').AsString := E_Busca_Cd_Empresa.Text;

    IF Trim(Cb_Busca_Empresa.Text) <> '' then
      ParamByName('EMP_NOME').AsString := '%' + Cb_Busca_Empresa.Text + '%';

    IF Trim(Dblcb_Negocio.Text) <> '' then
      ParamByName('PED_CODNEG').AsInteger := Dblcb_Negocio.KeyValue;

    if ChBx_Periodo_Financeiro.Checked then
      Begin
      ParamByName('FIN_DATAINI').AsDate := E_Data_Ini_FIN.date;
      ParamByName('FIN_DATAFIM').Asdate := E_Data_Fim_FIN.Date;
      end;      


    Open;
    FetchAll;
    end;
  Screen.Cursor:=crDefault;    
end;

procedure TFr_Clta_Negocio.Pc_CalculaFinanceiro;
Begin
  It_VL_Pagar := 0;
  It_VL_Pago := 0;
  It_VL_Receber := 0;
  It_VL_Recebido := 0;

  Qr_PesquisaFinanceiro.First;
  while not Qr_PesquisaFinanceiro.Eof do
    Begin
    if Qr_PesquisaFinanceiro.FieldByName('FIN_TIPO').AsString = 'RA' then
      Begin
      if Qr_PesquisaFinanceiro.FieldByName('FIN_BAIXA').AsString = 'N' then
        It_VL_Receber := It_VL_Receber + Qr_PesquisaFinanceiro.FieldByName('FIN_VL_PARCELA').AsCurrency
      else
        It_VL_Recebido := It_VL_Recebido + Qr_PesquisaFinanceiro.FieldByName('FIN_VL_PAGO').AsCurrency
      end
    else
      Begin
      if Qr_PesquisaFinanceiro.FieldByName('FIN_BAIXA').AsString = 'N' then
        It_VL_Pagar := It_VL_Pagar + Qr_PesquisaFinanceiro.FieldByName('FIN_VL_PARCELA').AsCurrency
      else
        It_VL_Pago := It_VL_Pago + Qr_PesquisaFinanceiro.FieldByName('FIN_VL_PAGO').AsCurrency
      end;
    Qr_PesquisaFinanceiro.Next;
    end;

end;


procedure TFr_Clta_Negocio.Pc_TotalizaFinanceiro;
Begin
  E_VL_Tl_Pagar.Text := FloatToStrF(It_VL_Pagar + It_VL_Pago,ffNumber,10,2);
  E_VL_Pagar.Text    := FloatToStrF(It_VL_Pagar,ffNumber,10,2);
  E_VL_Pago.Text     := FloatToStrF(It_VL_Pago,ffNumber,10,2);

  E_VL_TL_Receber.Text := FloatToStrF(It_VL_Receber + It_VL_Recebido,ffNumber,10,2);
  E_VL_Receber.Text    := FloatToStrF(It_VL_Receber,ffNumber,10,2);
  E_VL_Recebido.Text   := FloatToStrF(It_VL_Recebido,ffNumber,10,2);

  E_VL_Saldo_Liquido.Text := FloatToStrF(It_VL_Receber - It_VL_Pagar,ffNumber,10,2);

end;

procedure TFr_Clta_Negocio.SB_Sair_0Click(Sender: TObject);
begin
    Close;
end;

procedure TFr_Clta_Negocio.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;

end;

procedure TFr_Clta_Negocio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
      case Key of
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
      end;
    end;
end;
procedure TFr_Clta_Negocio.SB_BuscarClick(Sender: TObject);
begin
  case Pg_Informacao.ActivePageIndex of
    0:Begin
      case Pg_Estoque.ActivePageIndex of
        0:Begin
          Pc_BuscarMovimento;
          Pc_CalculaMovimento;
          Pc_TotalizaMovimento;
          end;
        1:Begin
          Pc_BuscarSaldo;
          end
        end;
      end;
    1:Begin
      Pc_BuscarFinanceiro;
      Pc_CalculaFinanceiro;
      Pc_TotalizaFinanceiro;
      end;
    end;
end;

procedure TFr_Clta_Negocio.ChBx_Periodo_GeralClick(Sender: TObject);
begin
  E_Data_Ini_NFL.Enabled := ChBx_Periodo_Geral.Checked;
  E_Data_Fim_NFL.Enabled := ChBx_Periodo_Geral.Checked;
end;

procedure TFr_Clta_Negocio.DBG_MovimentoTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(DBG_Movimento, Column);
end;

procedure TFr_Clta_Negocio.Rg_Filtro_SituacaoClick(Sender: TObject);
begin
  SB_BuscarClick(self);
end;

procedure TFr_Clta_Negocio.Pc_PermissaoBotao(Pc_Menu: string);
begin

end;

procedure TFr_Clta_Negocio.FormShow(Sender: TObject);
begin
  Pc_Ativartabelas;
  Pc_IniciaVariaveis;
  Pc_Formatatela;
  Pc_ImagemBotao;
  Pc_PermissaoBotao('Consulta Vendas');
  ChBx_Periodo_Geral.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','') = 'S');
  ChBx_Periodo_Financeiro.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','') = 'S');

end;

procedure TFr_Clta_Negocio.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Buscar.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;


procedure TFr_Clta_Negocio.ChBx_NomeClick(Sender: TObject);
begin
  if Rg_TipoEmpresa.ItemIndex = 0 then
    Pc_ListaFornecedorComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,Cb_Busca_Empresa)
  else
    Pc_ListaClienteComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,Cb_Busca_Empresa);
end;

procedure TFr_Clta_Negocio.ChBx_FantasiaClick(Sender: TObject);
begin
  if Rg_TipoEmpresa.ItemIndex = 0 then
    Pc_ListaFornecedorComboBox('EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,Cb_Busca_Empresa)
  else
    Pc_ListaClienteComboBox('EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,Cb_Busca_Empresa);
end;

procedure TFr_Clta_Negocio.Rg_TipoMovimentacaoClick(Sender: TObject);
begin
  case Rg_TipoMovimentacao.ItemIndex of
    0:Begin
      Rg_SentidoMovimento.ItemIndex := 0;
      Rg_SentidoMovimento.Enabled := False;
      Rg_TipoEmpresa.ItemIndex := 0;
      Rg_TipoEmpresa.Enabled := False;
      end;
    1:Begin
      Rg_SentidoMovimento.ItemIndex := 1;
      Rg_SentidoMovimento.Enabled := False;
      Rg_TipoEmpresa.ItemIndex := 1;
      Rg_TipoEmpresa.Enabled := False;
      end;
    2:Begin
      Rg_SentidoMovimento.ItemIndex := 0;
      Rg_SentidoMovimento.Enabled := True;
      Rg_TipoEmpresa.ItemIndex := 2;
      Rg_TipoEmpresa.Enabled := True;
      end;
    3:Begin
      Rg_SentidoMovimento.ItemIndex := 0;
      Rg_SentidoMovimento.Enabled := True;
      Rg_TipoEmpresa.ItemIndex := 2;
      Rg_TipoEmpresa.Enabled := True;
      end;
    end;
end;

procedure TFr_Clta_Negocio.Rg_TipoEmpresaClick(Sender: TObject);
begin
  if ChBx_Nome.Checked then
    ChBx_NomeClick(Self)
  else
  if ChBx_Fantasia.Checked then
    ChBx_FantasiaClick(Self)
end;



procedure TFr_Clta_Negocio.Qr_PesquisaEstoqueCalcFields(DataSet: TDataSet);
Var
  Lc_Tipo :String;
begin
  if (Qr_PesquisaEstoque.FieldByName('NFL_TIPO').AsString = 'SI') OR (Qr_PesquisaEstoque.FieldByName('NFL_TIPO').AsString = 'SE') THEN
    begin
    case Qr_PesquisaEstoque.FieldByName('PED_TIPO').AsInteger of
      1:Lc_Tipo := 'V - Saída ';
      3:Lc_Tipo := 'A - Saída ';
      end;
    end;
  if (Qr_PesquisaEstoque.FieldByName('NFL_TIPO').AsString = 'EI') OR (Qr_PesquisaEstoque.FieldByName('NFL_TIPO').AsString = 'EE') THEN
    begin
    case Qr_PesquisaEstoque.FieldByName('PED_TIPO').AsInteger of
      2:Lc_Tipo := 'C - Entrada';
      3:Lc_Tipo := 'A - Entrada';
      end;
    end;
  Qr_PesquisaEstoque.FieldByName('NFL_OPERACAO').AsString := Lc_Tipo;
end;

procedure TFr_Clta_Negocio.E_Busca_Cd_EmpresaExit(Sender: TObject);
begin
  if Chbx_Nome.Checked then
  Begin
    if Rg_SentidoMovimento.itemIndex = 0 then
      CB_Busca_Empresa.Text := Fc_BuscaNomeFornecedor('EMP_NOME',E_Busca_Cd_Empresa.Text)
    else
      CB_Busca_Empresa.Text := Fc_BuscaNomeCliente('EMP_NOME',E_Busca_Cd_Empresa.Text)
  end
  else
  Begin
    if Rg_SentidoMovimento.itemIndex = 0 then
      CB_Busca_Empresa.Text := Fc_BuscaNomeFornecedor('EMP_FANTASIA',E_Busca_Cd_Empresa.Text)
    else
      CB_Busca_Empresa.Text := Fc_BuscaNomeCliente('EMP_FANTASIA',E_Busca_Cd_Empresa.Text)
  end;
end;

procedure TFr_Clta_Negocio.Pc_AbreTelaCliente;
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(1,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_Busca_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
    Cb_Busca_Empresa.Text := Lc_Retorno.It_Dados[1,1];
  end;
end;

procedure TFr_Clta_Negocio.Pc_AbreTelaFornecedor;
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(2,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_Busca_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
    Cb_Busca_Empresa.Text := Lc_Retorno.It_Dados[1,1];
  end;
end;

procedure TFr_Clta_Negocio.Sb_EmpresaClick(Sender: TObject);
begin
  if (Rg_TipoEmpresa.itemIndex = 0) then
    Pc_AbreTelaFornecedor
  else
    Pc_AbreTelaCliente;
end;

procedure TFr_Clta_Negocio.DBLCB_MarcaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Marca.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_Clta_Negocio.ChBx_Periodo_FinanceiroClick(Sender: TObject);
begin
  E_Data_Ini_FIN.Enabled := ChBx_Periodo_Financeiro.Checked;
  E_Data_Fim_FIN.Enabled := ChBx_Periodo_Financeiro.Checked;

end;

procedure TFr_Clta_Negocio.Qr_PesquisaFinanceiroCalcFields(
  DataSet: TDataSet);
Var
  Lc_Tipo :String;
begin
  Lc_Tipo := '';
  if (Qr_PesquisaFinanceiro.FieldByName('FIN_TIPO').AsString = 'RA') THEN
    Lc_Tipo := 'Contasá Receber '
  else
  if (Qr_PesquisaFinanceiro.FieldByName('FIN_TIPO').AsString = 'PA') THEN
    Lc_Tipo := 'Contas É Pagar ';
  Qr_PesquisaFinanceiro.FieldByName('FIN_FINANCEIRO').AsString := Lc_Tipo;
end;

procedure TFr_Clta_Negocio.Sb_NegocioClick(Sender: TObject);
Var
  Lc_Form : TSeaBusiness;
begin
  Lc_Form := TSeaBusiness.create(self);
  try
    IF Trim(Dblcb_Negocio.Text) <> '' then
      Lc_Form.CodigoRegistro := Dblcb_Negocio.KeyValue;
    Lc_Form.ShowModal;

  finally
    DM.Qr_Negocio.Active := False;
    DM.Qr_Negocio.Active := True;
    Dblcb_Negocio.KeyValue := Lc_Form.CodigoRegistro;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Clta_Negocio.Dbg_SaldoTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(Dbg_Saldo, Column);
end;

procedure TFr_Clta_Negocio.Dbg_FinanceiroTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(Dbg_Financeiro, Column);
end;

end.
