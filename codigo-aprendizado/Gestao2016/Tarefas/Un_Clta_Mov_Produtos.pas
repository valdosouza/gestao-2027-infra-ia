unit Un_Clta_Mov_Produtos;

interface

uses
      Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, ComCtrls, Buttons, Grids, DBGrids, jpeg, STQuery, Variants, Menus, QEdit_Setes, Un_Fm_ListaProdutos, Un_Fm_ListaEmpresas, Un_Fm_ListaMultiEmpresa, base_frame_list;


type
  TFr_Clta_Mov_Produtos = class(TForm)
    GroupBox1: TGroupBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Rg_SentidoMovimento: TRadioGroup;
    Rg_TipoEmpresa: TRadioGroup;
    GroupBox2: TPanel;
    Qr_Notas: TSTQuery;
    Ds_Notas: TDataSource;
    SB_Sair_0: TSpeedButton;
    SB_Buscar: TSpeedButton;
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
    Label14: TLabel;
    DBLCB_Marca: TDBLookupComboBox;
    Fm_ListaProdutos: TFm_ListaProdutos;
    SB_Visualizar: TSpeedButton;
    Qr_NotasNFL_CODIGO: TIntegerField;
    Qr_NotasNFL_MODELO: TStringField;
    Qr_NotasPED_TIPO: TIntegerField;
    Qr_NotasNFL_DT_EMISSAO: TDateField;
    Qr_NotasNFL_STATUS: TStringField;
    Qr_NotasNFL_TIPO: TStringField;
    Qr_NotasPRO_CODIGOFAB: TStringField;
    Qr_NotasPRO_DESCRICAO: TStringField;
    Qr_NotasITF_QTDE: TBCDField;
    Qr_NotasITF_VL_UNIT: TFMTBCDField;
    Qr_NotasITV_SUBTOTAL: TFloatField;
    Qr_NotasNFL_OPERACAO: TStringField;
    Fm_ListaEmpresas: TFm_ListaEmpresas;
    Qr_NotasPED_NUMERO: TIntegerField;
    Qr_NotasEMP_NOME: TStringField;
    Qr_NotasEMP_FANTASIA: TStringField;
    Qr_NotasNFL_NUMERO: TStringField;
    ChBx_Canceladas: TCheckBox;
    Fm_LME: TFm_ListaMultiEmpresa;
    Pg_Resultado: TPageControl;
    tbs_Nota: TTabSheet;
    tbs_PEdido: TTabSheet;
    Qr_Pedidos: TSTQuery;
    Ds_Pedidos: TDataSource;
    Dbg_Pedidos: TDBGrid;
    DBG_Notas: TDBGrid;
    ChBx_PedidoPendente: TCheckBox;
    Rg_Tipo_Nota: TGroupBox;
    ChBx_Vendas: TCheckBox;
    ChBx_Compras: TCheckBox;
    ChBx_Ajustes: TCheckBox;
    Sb_Exportar: TSpeedButton;
    Qr_NotasEMP_CODIGO: TIntegerField;
    Qr_NotasEND_FONE: TStringField;
    Qr_NotasEND_FAX: TStringField;
    Qr_NotasEND_CELULAR: TStringField;
    Qr_NotasEND_COMERCIAL: TStringField;
    Qr_PedidosPED_DATA: TDateField;
    Qr_PedidosEMP_CODIGO: TIntegerField;
    Qr_PedidosEMP_FANTASIA: TStringField;
    Qr_PedidosPED_TIPO: TIntegerField;
    Qr_PedidosPRO_CODIGOFAB: TStringField;
    Qr_PedidosPRO_DESCRICAO: TStringField;
    Qr_PedidosITF_QTDE: TBCDField;
    Qr_PedidosITF_VL_UNIT: TFMTBCDField;
    Qr_PedidosITV_SUBTOTAL: TFloatField;
    Qr_PedidosPED_NUMERO: TIntegerField;
    Qr_PedidosEMP_NOME: TStringField;
    Qr_PedidosPED_CODIGO: TIntegerField;
    Qr_PedidosEND_FONE: TStringField;
    Qr_PedidosEND_FAX: TStringField;
    Qr_PedidosEND_CELULAR: TStringField;
    Qr_PedidosEND_COMERCIAL: TStringField;
    Qr_NotasITF_ESTOQUE: TStringField;
    Qr_PedidosITF_ESTOQUE: TStringField;
    Qr_NotasIAV_DESCRICAO: TStringField;
    Qr_PedidosIAV_DESCRICAO: TStringField;
    Qr_PedidosITEM_DESCRICAO: TStringField;
    Qr_NotasITEM_DESCRICAO: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_BuscarClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure DBG_NotasTitleClick(Column: TColumn);
    procedure Rg_Filtro_SituacaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Qr_NotasCalcFields(DataSet: TDataSet);
    procedure DBLCB_MarcaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure DBG_NotasDblClick(Sender: TObject);
    procedure ChBx_PedidoPendenteClick(Sender: TObject);
    procedure Dbg_PedidosTitleClick(Column: TColumn);
    procedure Dbg_PedidosDblClick(Sender: TObject);
    procedure Fm_ListaEmpresasChBx_FantasiaClick(Sender: TObject);
    procedure Fm_ListaEmpresasChBx_NomeClick(Sender: TObject);
    procedure Rg_TipoEmpresaClick(Sender: TObject);
    procedure Sb_ExportarClick(Sender: TObject);
    procedure Qr_PedidosCalcFields(DataSet: TDataSet);


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
    procedure Pc_Formatatela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_Ativartabelas;
    procedure Pc_BuscarNotas;
    procedure Pc_BuscarPedido;
    procedure Pc_CalculaNotas;
    procedure Pc_CalculaPedidos;
    procedure Pc_TotalizaNotas;
    procedure Pc_TotalizaPedidos;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;
    procedure AbreTelaPedidos;
    function ValidaExporta:Boolean;
    procedure Exportar;

  end;

var
  Fr_Clta_Mov_Produtos: TFr_Clta_Mov_Produtos;

implementation

uses     Un_DM, Un_Produtos, UN_Sistema, Un_Fich_Fin_Cli, Un_Nota_Fiscal, Un_Excel, Un_Msg, Un_Imp_Mod_Impressao, Un_Regra_Negocio, UN_Principal, env, RN_Estoque, RN_Empresa, RN_Fornecedor, RN_Cliente, RN_NotaFiscal, RN_NotaFiscalConsumidor, UN_Pedido_Ajt, UN_Pedido_Cpa, UN_Pedido_Vda, RN_Permissao;
{$R *.DFM}

procedure TFr_Clta_Mov_Produtos.Pc_Ativartabelas;
Begin
  Fm_ListaEmpresas.Pc_AtivaEmpresa(-1);
  DM.Qr_MarcaProduto.Active := True;
end;

procedure TFr_Clta_Mov_Produtos.Pc_IniciaVariaveis;
var
   Lc_X: Integer;
Begin
  for Lc_X := 0 to Pg_Resultado.PageCount -1 do
    Pg_Resultado.Pages[Lc_X].TabVisible := False;
  Pg_Resultado.ActivePage := tbs_Nota;
  Fm_LME.Listar('EMP_NOME');
  Fm_LME.HabilitarMultiEmpresa;
  Rg_SentidoMovimento.ItemIndex := 2;
  Rg_TipoEmpresa.ItemIndex := 2;
  E_Data_Ini.Date:=date;
  E_Data_Fim.Date:=date;
  Fm_ListaEmpresas.E_Cd_Empresa.Clear;
  Fm_ListaProdutos.E_Cd_Produto.Clear;
  Fm_ListaProdutos.E_Busca_Produto.Clear;
end;

procedure TFr_Clta_Mov_Produtos.Pc_Formatatela;
Begin


end;


procedure TFr_Clta_Mov_Produtos.Fm_ListaEmpresasChBx_FantasiaClick(
  Sender: TObject);
begin
  Fm_ListaEmpresas.ChBx_FantasiaClick(Sender);
end;

procedure TFr_Clta_Mov_Produtos.Fm_ListaEmpresasChBx_NomeClick(Sender: TObject);
begin
  Fm_ListaEmpresas.ChBx_NomeClick(Sender);

end;

procedure TFr_Clta_Mov_Produtos.FormClose(Sender: TObject;
var
    Action: TCloseAction);
begin
  Action:=caFree;
  Fr_Clta_Mov_Produtos := Nil;
end;

procedure TFr_Clta_Mov_Produtos.Pc_BuscarNotas;
VaR
  Lc_SqlTxt : String;
begin
  Screen.Cursor:=crHourGlass;
  with Qr_Notas do
  Begin
    IF Transaction.InTransaction then Transaction.Commit; Transaction.StartTransaction;
    Close;
    SQL.Clear;
    Lc_SqlTxt :=  concat(
                     'SELECT PED_TIPO, NFL_DT_EMISSAO, NFL_STATUS, NFL_TIPO,PRO_CODIGOFAB,PRO_DESCRICAO,  ',
                     'ITF_QTDE,ITF_VL_UNIT,CAST(((ITF_QTDE * ITF_VL_UNIT) - itf_vl_desc) AS DOUBLE PRECISION) as ITV_SUBTOTAL,     ',
                     'NFL_CODIGO, NFL_MODELO, PED_NUMERO, EMP_CODIGO,EMP_NOME, EMP_FANTASIA,NFL_NUMERO,   ',
                     'END_FONE,END_FAX,END_CELULAR,END_COMERCIAL, ITF_ESTOQUE,IAV_DESCRICAO               ',
                     'FROM TB_NOTA_FISCAL nf                                                              ',
                     '    INNER JOIN TB_EMPRESA cl ',
                     '    ON (cl.EMP_CODIGO = nf.NFL_CODEMP) ',
                     '    INNER JOIN TB_PEDIDO pd ',
                     '    ON (pd.PED_CODIGO = nf.NFL_CODPED) ',
                     '    INNER JOIN TB_ENDERECO en ',
                     '    ON (en.END_CODIGO = pd.PED_CODEND) ',
                     '    INNER JOIN TB_ITENS_NFL it ',
                     '    ON (it.ITF_CODPED = pd.ped_CODIGO) ',
                     '    INNER JOIN TB_PRODUTO pr ',
                     '    ON (pr.PRO_CODIGO = it.ITF_CODPRO) ',
                     '     LEFT OUTER  JOIN TB_ITENS_AVL ',
                     '     ON (IAV_CODITF = ITF_CODIGO) ',
                     'WHERE (NFL_CODIGO IS NOT NULL) '
                  );

    if not ChBx_Canceladas.Checked then
      Lc_SqlTxt := Lc_SqlTxt + ' AND ( NFL_STATUS = ''F'') ';

    Lc_SqlTxt := Lc_SqlTxt  + ' AND  ( (PED_TIPO = 0 ) ';
    if ChBx_Vendas.Checked  then Lc_SqlTxt := Lc_SqlTxt  + ' OR (PED_TIPO = 1) OR (PED_TIPO = 4) ';
    if ChBx_Compras.Checked then Lc_SqlTxt := Lc_SqlTxt  + ' OR (PED_TIPO = 2) ';
    if ChBx_Ajustes.Checked then Lc_SqlTxt := Lc_SqlTxt  + ' OR (PED_TIPO = 3) ';
    Lc_SqlTxt := Lc_SqlTxt  + ' ) ';

    case Rg_SentidoMovimento.ItemIndex of
      0: Lc_SqlTxt := Lc_SqlTxt + ' AND ( (NFL_TIPO = ''EI'') or (NFL_TIPO = ''EE'') ) ';
      1: Lc_SqlTxt := Lc_SqlTxt + ' AND ( (NFL_TIPO = ''SI'') or (NFL_TIPO = ''SE'') ) ';
    end;

    Lc_SqlTxt := Lc_SqlTxt  + ' AND  ( (ITF_OPER <> '''' ) ';
    if ChBx_Vendas.Checked  then Lc_SqlTxt := Lc_SqlTxt  + ' OR (ITF_OPER = ''V'') ';
    if ChBx_Compras.Checked then Lc_SqlTxt := Lc_SqlTxt  + ' OR (ITF_OPER = ''C'') ';
    if ChBx_Ajustes.Checked then Lc_SqlTxt := Lc_SqlTxt  + ' OR (ITF_OPER = ''A'') ';
    Lc_SqlTxt := Lc_SqlTxt  + ' ) ';

    IF ChBx_Periodo.Checked then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ';

    IF Trim(Fm_ListaEmpresas.E_Cd_Empresa.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_CODEMP =:EMP_CODIGO) ';

    IF Trim(Fm_ListaEmpresas.DBLCb_Empresa.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ( (EMP_NOME LIKE :EMP_NOME) OR (EMP_FANTASIA LIKE :EMP_NOME) )';

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
      Lc_SqlTxt := Lc_SqlTxt + ' AND ( (PRO_DESCRICAO LIKE :PRO_DESCRICAO) or (IAV_DESCRICAO LIKE :PRO_DESCRICAO ) )';

    if Trim(DBLCB_Marca.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_CODMRC =:PRO_CODMRC) ';

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (NFL_CODMHA =:NFL_CODMHA) ' ;

    SQL.Add(Lc_SqlTxt + ' ORDER BY  NFL_DT_EMISSAO, PRO_DESCRICAO ');


    IF ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    end;

    IF Trim(Fm_ListaEmpresas.E_Cd_Empresa.Text) <> '' then
      ParamByName('EMP_CODIGO').AsString := Fm_ListaEmpresas.E_Cd_Empresa.Text;

    IF Trim(Fm_ListaEmpresas.DBLCb_Empresa.Text) <> '' then
      ParamByName('EMP_NOME').AsString := '%' + Copy(Fm_ListaEmpresas.DBLCb_Empresa.Text,1,98) + '%';

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

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      ParamByName('NFL_CODMHA').AsInteger := Fm_LME.Dblcb_Lista.KeyValue;

    Open;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFr_Clta_Mov_Produtos.Pc_BuscarPedido;
VaR
  Lc_SqlTxt : String;
begin
  Screen.Cursor:=crHourGlass;
  with Qr_Pedidos do
  Begin
    IF Transaction.InTransaction then Transaction.Commit; Transaction.StartTransaction;
    Close;
    SQL.Clear;
    Lc_SqlTxt := concat(
                  'SELECT PED_DATA,EMP_CODIGO, EMP_FANTASIA, PED_TIPO, PRO_CODIGOFAB,PRO_DESCRICAO,',
                  'ITF_QTDE,ITF_VL_UNIT,CAST(((ITF_QTDE * ITF_VL_UNIT) - itf_vl_desc) AS DOUBLE PRECISION) as ITV_SUBTOTAL, ',
                  'PED_NUMERO, EMP_NOME, PED_CODIGO, END_FONE,END_FAX,END_CELULAR,END_COMERCIAL, ',
                  'ITF_ESTOQUE,  IAV_DESCRICAO ' ,
                  'FROM TB_PEDIDO ped ',
                  '   INNER JOIN TB_EMPRESA cli ',
                  '   ON (cli.EMP_CODIGO = ped.PED_CODEMP) ',
                  '   INNER JOIN TB_ENDERECO en ',
                  '   ON (en.END_CODIGO = ped.PED_CODEND) ',
                  '   INNER JOIN TB_ITENS_NFL it ',
                  '   ON (it.ITF_CODPED = ped.ped_CODIGO) ',
                  '   INNER JOIN TB_PRODUTO pr ',
                  '   ON (pr.PRO_CODIGO = it.ITF_CODPRO) ',
                  '     LEFT OUTER  JOIN TB_ITENS_AVL ',
                  '     ON (IAV_CODITF = ITF_CODIGO) ',
                  'WHERE (PED_CODIGO IS NOT NULL) and (PED_FATURADO = ''N'')  '
                  );

      IF ChBx_Periodo.Checked then
        Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_DATA BETWEEN :DATAINI AND :DATAFIM) ';

      IF Trim(Fm_ListaEmpresas.E_Cd_Empresa.Text) <> '' then
        Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_CODEMP =:EMP_CODIGO) ';

      if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
        Lc_SqlTxt := Lc_SqlTxt + ' AND (PED_CODMHA =:PED_CODMHA) ' ;

    Lc_SqlTxt := Lc_SqlTxt  + ' AND  ( (PED_TIPO = 0 ) ';
    if ChBx_Vendas.Checked  then Lc_SqlTxt := Lc_SqlTxt  + ' OR (PED_TIPO = 1) OR (PED_TIPO = 4)';
    if ChBx_Compras.Checked then Lc_SqlTxt := Lc_SqlTxt  + ' OR (PED_TIPO = 2) ';
    if ChBx_Ajustes.Checked then Lc_SqlTxt := Lc_SqlTxt  + ' OR (PED_TIPO = 3) ';
    Lc_SqlTxt := Lc_SqlTxt  + ' ) ';


    IF Trim(Fm_ListaEmpresas.DBLCb_Empresa.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ( (EMP_NOME LIKE :EMP_NOME) OR (EMP_FANTASIA LIKE :EMP_NOME) )';

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
      Lc_SqlTxt := Lc_SqlTxt + ' AND ( (PRO_DESCRICAO LIKE :PRO_DESCRICAO) or (IAV_DESCRICAO LIKE :PRO_DESCRICAO ) )';

    if Trim(DBLCB_Marca.Text) <> '' then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_CODMRC =:PRO_CODMRC) ';


    SQL.Add(Lc_SqlTxt + ' ORDER BY  1, 2 ');


    IF ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    end;

    IF Trim(Fm_ListaEmpresas.E_Cd_Empresa.Text) <> '' then
      ParamByName('EMP_CODIGO').AsString := Fm_ListaEmpresas.E_Cd_Empresa.Text;

    IF Trim(Fm_ListaEmpresas.DBLCb_Empresa.Text) <> '' then
      ParamByName('EMP_NOME').AsString := '%' + Copy(Fm_ListaEmpresas.DBLCb_Empresa.Text,1,98) + '%';

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

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      ParamByName('PED_CODMHA').AsInteger := Fm_LME.Dblcb_Lista.KeyValue;

    Open;
    Screen.Cursor:=crDefault;
  end;
end;


procedure TFr_Clta_Mov_Produtos.Pc_CalculaNotas;
begin
  DBG_Notas.Visible := False;
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

  with Qr_Notas do
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
  DBG_Notas.Visible := true;
end;


procedure TFr_Clta_Mov_Produtos.Pc_CalculaPedidos;
begin
  Dbg_Pedidos.Visible := False;
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

  with Qr_Pedidos do
  Begin
    First;
    while not Eof do
    Begin
      case FieldByName('PED_TIPO').AsInteger of
        1:Begin
            It_Nr_Vendas := It_Nr_Vendas + 1;
            It_VL_Vendas := It_VL_Vendas + FieldByName('ITV_SUBTOTAL').AsCurrency;
            It_Qt_Vendas := It_Qt_Vendas + FieldByName('ITF_QTDE').AsFloat;
          end;
        2:Begin
            It_Nr_Compras := It_Nr_Compras + 1;
            It_VL_Compras := It_VL_Compras + FieldByName('ITV_SUBTOTAL').AsCurrency;
            It_Qt_Compras := It_Qt_Compras + FieldByName('ITF_QTDE').AsFloat;
          end;
        3:Begin
            It_Nr_Ajustes := It_Nr_Ajustes + 1;
            It_VL_Ajustes := It_VL_Ajustes + FieldByName('ITV_SUBTOTAL').AsCurrency;
            It_Qt_Saida := It_Qt_Saida + FieldByName('ITF_QTDE').AsFloat;
          end;
      end;
      Next;
    end;
    First;
  end;
  Dbg_Pedidos.Visible := true;
end;

procedure TFr_Clta_Mov_Produtos.Pc_Totalizanotas;
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
  Lc_Nr_Meses := trunc((E_Data_Fim.Date - E_Data_Ini.Date));
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

procedure TFr_Clta_Mov_Produtos.Pc_TotalizaPedidos;
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
  Lc_Nr_Meses := trunc((E_Data_Fim.Date - E_Data_Ini.Date));
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

procedure TFr_Clta_Mov_Produtos.SB_Sair_0Click(Sender: TObject);
begin
    Close;
end;

procedure TFr_Clta_Mov_Produtos.SB_VisualizarClick(Sender: TObject);
begin
  with Qr_Notas do
  Begin
    if RecordCount > 0 then
    Begin
      if FieldByName('NFL_CODIGO').asstring = '65' then
        Pc_AbreTelaNotaFiscal65('N',FieldByName('NFL_CODIGO').AsInteger)
      else
        Pc_AbreTelaNotaFiscal(FieldByName('NFL_CODIGO').AsInteger,self);
    End;
  End;
end;

procedure TFr_Clta_Mov_Produtos.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;

end;

procedure TFr_Clta_Mov_Produtos.FormKeyDown(Sender: TObject; var Key: Word;
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
procedure TFr_Clta_Mov_Produtos.SB_BuscarClick(Sender: TObject);
begin
  TRY
    Pc_ProcesoAguarde(Self,'I');
    if Pg_Resultado.ActivePageIndex = 0 then
    Begin
      Pc_BuscarPedido;
      Pc_CalculaPedidos;
      Pc_TotalizaPedidos;
    End
    else
    Begin
      Pc_BuscarNotas;
      Pc_CalculaNotas;
      Pc_TotalizaNotas;
    End;
  Finally
    Pc_ProcesoAguarde(Self,'F');
  end;

end;

function TFr_Clta_Mov_Produtos.ValidaExporta:Boolean;
Var
  lcSemRegistro : Boolean;
Begin
  Result := true;
  if ChBx_PedidoPendente.Checked then
    lcSemRegistro := ( Qr_Pedidos.RecordCount = 0 )
  else
    lcSemRegistro := ( Qr_Notas.RecordCount = 0 );

  if lcSemRegistro then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Não há registros para exportar.'+EOLN+
                   'Efetue a busca e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    exit;
  End;

end;

procedure TFr_Clta_Mov_Produtos.Sb_ExportarClick(Sender: TObject);
begin
  if ValidaExporta then
    Exportar;
end;

procedure TFr_Clta_Mov_Produtos.AbreTelaPedidos;
Var
  LcFrAjt : TFr_Pedido_Ajt;
  LcFrVda : TFr_Pedido_Vda;
  LcFrCPa : TFr_Pedido_Cpa;
begin
  with Qr_Pedidos do
  Begin
    case FieldByName('PEd_TIPO').AsInteger of
      1:Begin
          try
            LcFrVda := TFr_Pedido_Vda.create(nil);
            LcFrVda.Pedido.Registro.Codigo := FieldByName('PED_CODIGO').AsInteger;
            LcFrVda.ShowModal;
          finally
            FreeAndNil(LcFrVda);
          end;
        end;
      2:Begin
          try
            LcFrCPa := TFr_Pedido_Cpa.create(nil);
            LcFrCPa.Pedido.Registro.Codigo := FieldByName('PED_CODIGO').AsInteger;
            LcFrCPa.ShowModal;
          finally
            FreeAndNil(LcFrCPa);
          end;
        end;
      3:Begin
          Try
            LcFrAjt := TFr_Pedido_Ajt.create(nil);
            LcFrAjt.Pedido.Registro.Codigo := FieldByName('PED_CODIGO').AsInteger;
            LcFrAjt.ShowModal;
          Finally
            FreeAndNil(LcFrAjt);
          end;
        end;
    end;
  end;
end;

procedure TFr_Clta_Mov_Produtos.ChBx_PedidoPendenteClick(Sender: TObject);
begin
  if ChBx_PedidoPendente.Checked then
    Pg_Resultado.ActivePageIndex := 0
  else
    Pg_Resultado.ActivePageIndex := 1;
end;

procedure TFr_Clta_Mov_Produtos.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Clta_Mov_Produtos.DBG_NotasDblClick(Sender: TObject);
begin
  SB_VisualizarClick(Self);
end;

procedure TFr_Clta_Mov_Produtos.DBG_NotasTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(DBG_Notas, Column);
end;

procedure TFr_Clta_Mov_Produtos.Dbg_PedidosDblClick(Sender: TObject);
begin
  AbreTelaPedidos;
end;

procedure TFr_Clta_Mov_Produtos.Dbg_PedidosTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(Dbg_Pedidos, Column);
end;

procedure TFr_Clta_Mov_Produtos.Rg_Filtro_SituacaoClick(Sender: TObject);
begin
  SB_BuscarClick(self);
end;

procedure TFr_Clta_Mov_Produtos.Rg_TipoEmpresaClick(Sender: TObject);
begin
  case Rg_TipoEmpresa.ItemIndex of
    0:Fm_ListaEmpresas.Pc_AtivaEmpresa(2);
    1:Fm_ListaEmpresas.Pc_AtivaEmpresa(1);
    else
      Fm_ListaEmpresas.Pc_AtivaEmpresa(-1);
  end;
end;

procedure TFr_Clta_Mov_Produtos.Pc_PermissaoBotao(Pc_Menu: string);
begin
  ChBx_Vendas.Checked := False;
  ChBx_Vendas.Enabled := False;
  ChBx_Compras.Checked := False;
  ChBx_Compras.Enabled := False;
  ChBx_Ajustes.Checked := False;
  ChBx_Ajustes.Enabled := False;
  if Fc_VerificaPermissao('Fr_Clta_Mov_Produtos','Análise movimentação produtos','CONSULTA VENDAS',GB_Cd_Usuario,'N') then ChBx_Vendas.Enabled := True;
  if Fc_VerificaPermissao('Fr_Clta_Mov_Produtos','Análise movimentação produtos','CONSULTA COMPRAS',GB_Cd_Usuario,'N') then ChBx_Compras.Enabled := True;
  if Fc_VerificaPermissao('Fr_Clta_Mov_Produtos','Análise movimentação produtos','CONSULTA AJUSTES',GB_Cd_Usuario,'N') then ChBx_Ajustes.Enabled := True;

  if ChBx_Vendas.Enabled then
    ChBx_Vendas.Checked := True
  else
  if ChBx_Compras.Enabled then
    ChBx_Compras.Checked := True
  else
  if ChBx_Ajustes.Enabled then
    ChBx_Ajustes.Checked := True;
end;

procedure TFr_Clta_Mov_Produtos.FormShow(Sender: TObject);
begin
  Pc_Ativartabelas;
  Pc_IniciaVariaveis;
  Pc_Formatatela;
  Pc_ImagemBotao;
  Pc_PermissaoBotao('Consulta Vendas');
  ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','') = 'S'); 
end;

procedure TFr_Clta_Mov_Produtos.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Geral;
    Sb_Exportar.Glyph.Assign(Fc_CarregaImagemBotao('EXPORTAR'));
    SB_Buscar.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    SB_Visualizar.Glyph.Assign(Fc_CarregaImagemBotao('VISUALIZAR'));
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

procedure TFr_Clta_Mov_Produtos.Qr_NotasCalcFields(DataSet: TDataSet);
Var
  Lc_Tipo :String;
begin
  with Qr_Notas do
  Begin
    if (FieldByName('NFL_TIPO').AsString = 'SI') OR (FieldByName('NFL_TIPO').AsString = 'SE') THEN
      begin
      case FieldByName('PED_TIPO').AsInteger of
        1:Lc_Tipo := 'V - Saída ';
        3:Lc_Tipo := 'A - Saída ';
        end;
      end;
    if (FieldByName('NFL_TIPO').AsString = 'EI') OR (FieldByName('NFL_TIPO').AsString = 'EE') THEN
      begin
      case FieldByName('PED_TIPO').AsInteger of
        2:Lc_Tipo := 'C - Entrada';
        3:Lc_Tipo := 'A - Entrada';
        end;
      end;
    FieldByName('NFL_OPERACAO').AsString := Lc_Tipo;

    if ( FieldByName('IAV_DESCRICAO').AsString <> '') then
      FieldByName('ITEM_DESCRICAO').AsString := FieldByName('IAV_DESCRICAO').AsString
    ELSE
      FieldByName('ITEM_DESCRICAO').AsString := FieldByName('PRO_DESCRICAO').AsString
  End;

end;

procedure TFr_Clta_Mov_Produtos.Qr_PedidosCalcFields(DataSet: TDataSet);
begin
  with Qr_Pedidos do
  Begin
  if ( FieldByName('IAV_DESCRICAO').AsString <> '') then
    FieldByName('ITEM_DESCRICAO').AsString := FieldByName('IAV_DESCRICAO').AsString
  ELSE
    FieldByName('ITEM_DESCRICAO').AsString := FieldByName('PRO_DESCRICAO').AsString
  End;
end;

procedure TFr_Clta_Mov_Produtos.DBLCB_MarcaKeyDown(Sender: TObject;
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

procedure TFr_Clta_Mov_Produtos.Exportar;
Var
  Lc_CAminho : String;
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    IF (Fr_Principal.SaveDialogo.Execute) then
    Begin
      if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
      Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
      Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
      if ChBx_PedidoPendente.Checked then
        Fr_Excel.Pc_Excel(Qr_Notas,Lc_Caminho)
      else
        Fr_Excel.Pc_Excel(Qr_Notas,Lc_Caminho)
    End;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;

end;

end.
