unit Un_Clta_Csto;
                                                                                                       
interface

uses
      Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, ComCtrls, Buttons, Grids, DBGrids, jpeg, STQuery, Variants, Menus, Un_Fm_ListaSituacao, Un_Fm_ListaMultiEmpresa, base_frame_list;


type
  TFr_Clta_Csto = class(TForm)
    Ds_Vendas: TDataSource;
    Qr_Conserto: TSTQuery;
    Qr_Clientes: TSTQuery;
    PopMenu: TPopupMenu;
    NovoConserto1: TMenuItem;
    Cb_Situacao: TComboBox;
    StrGrd_Conserto: TStringGrid;
    Panel1: TPanel;
    SB_Visualizar: TSpeedButton;
    Sb_Inserir: TSpeedButton;
    SB_Buscar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label15: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    E_Orcamento: TMaskEdit;
    E_ApMarMod: TMaskEdit;
    E_Serie: TMaskEdit;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    E_Busca_Cd_Empresa: TMaskEdit;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    Cb_Busca_Empresa: TComboBox;
    Sb_Pesq_Cliente: TSpeedButton;
    Fm_ListaSituacao: TFm_ListaSituacao;
    MainMenu: TMainMenu;
    arefas1: TMenuItem;
    Configuraes1: TMenuItem;
    Fm_LME: TFm_ListaMultiEmpresa;
    Sair1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_ClienteClick(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure E_OrcamentoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Qr_ConsertoAfterOpen(DataSet: TDataSet);
    procedure Cb_SituacaoChange(Sender: TObject);
    procedure Cb_SituacaoExit(Sender: TObject);
    procedure StrGrd_ConsertoDblClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure E_Busca_Cd_EmpresaExit(Sender: TObject);
    procedure Sb_Pesq_ClienteClick(Sender: TObject);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure Fm_ListaSituacaoDBLCB_SituacaoKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure Sb_InserirClick(Sender: TObject);
    procedure Configuraes1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
    It_Inserir: Boolean;
    It_Alterar: Boolean;
    It_Excluir: Boolean;
    It_Encerrar: Boolean;
    It_Imprimir: Boolean;
    It_Visualizar: Boolean;


    procedure Pc_PreencheGradeOrcamento;
    procedure Pc_BuscarOrcamento;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;
    procedure AbreTelaConserto(Codigo:Integer);
    procedure MontaGrade;
  end;

var
  Fr_Clta_Csto: TFr_Clta_Csto;

implementation

uses     Un_DM, Un_Produtos, UN_Sistema, tas_conserto, tas_config_conserto, UN_Pedido_Vda, Un_Nota_Fiscal, UN_MSG, Un_Funcoes, Un_Imp_Mod_Impressao, Types, Un_Regra_Negocio, UN_Principal, env, RN_Cliente, RN_Empresa, RN_NotaFiscal;
{$R *.DFM}

procedure TFr_Clta_Csto.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    CarregaImagemBotao(SB_Inserir,'INSERIR');
    CarregaImagemBotao(SB_Buscar,'BUSCAR');
    CarregaImagemBotao(SB_Visualizar,'VISUALIZAR');
    CarregaImagemBotao(Sb_Sair_0,'SAIR');
    END;
end;

procedure TFr_Clta_Csto.Pc_PreencheGradeOrcamento;
Var
  Lc_I, Lc_J : Integer;
  Lc_Registro : Integer;
Begin
  with StrGrd_Conserto, Qr_Conserto do
  Begin
    For Lc_I :=1 to RowCount - 1 do
      For Lc_J := 1 to ColCount do
        Cells[Lc_J, Lc_I] := '';
    Lc_Registro := 0;
    RowCount := 2;
    First;
    while not Eof do
    Begin
      Lc_registro := Lc_registro + 1;
      RowCount := Lc_registro + 1;
      Cells[1,Lc_registro]  := Fieldbyname('CTC_CODIGO').AsString;
      Cells[2,Lc_registro]  := Fieldbyname('CTC_CODPED').AsString;
      Cells[3,Lc_registro]  := Fieldbyname('CTC_NUMERO').AsString;
      Cells[4,Lc_registro]  := Fieldbyname('CTC_DATA').AsString;
      Cells[5,Lc_registro]  := Fieldbyname('CTC_FANTASIA').AsString;
      Cells[6,Lc_registro]  := fc_MascaraFone(Fieldbyname('END_FONE').AsString);
      Cells[7,Lc_registro] := fc_MascaraFone(Fieldbyname('END_CELULAR').AsString);
      Cells[8,Lc_registro] := Fieldbyname('SIT_DESCRICAO').AsString;
      Cells[9,Lc_registro] := FloatToStrF(Fieldbyname('CTC_VL_COTACAO').AsCurrency, ffFixed,10,2);
      Cells[10,Lc_registro] := Fieldbyname('CST_APARELHO').AsString;
      Next;
    end;
  End;
end;


procedure TFr_Clta_Csto.FormCreate(Sender: TObject);
begin
  if DM.IB_Transacao.InTransaction then DM.IB_Transacao.Commit;
  Fm_ListaSituacao.Etapa := 1;
  Fm_ListaSituacao.Listar;
  E_Data_Ini.Date:=date-30;
  E_Data_Fim.Date:=date;
  MontaGrade;
  Pc_PermissaoBotao('Consulta Conserto');
end;

procedure TFr_Clta_Csto.MontaGrade;
Begin
  with StrGrd_Conserto do
  Begin
    { Ajusta a altura do ComboBox com a altura da linha do StringGrid}
    DefaultRowHeight := Cb_Situacao.Height;
    {Esconde o ComboBox}
    Cb_Situacao.Visible := False;
    //Definir tamanho Da grade de Consertos
    ColWidths[0]:=17;
    ColWidths[1]:=-1;
    ColWidths[2]:=-1;
    ColWidths[3]:=120;
    ColWidths[4]:=70;
    ColWidths[5]:=180;
    ColWidths[6]:=80;
    ColWidths[7]:=80;
    ColWidths[8]:=250;
    ColWidths[9]:=60;
    ColWidths[10]:=160;
    Cols[1].Add('Cod_Cotacao');
    Cols[2].Add('Cod_Pedido');
    Cols[3].Add('Orçamento');
    Cols[4].Add('Data');
    Cols[5].Add('Nome');
    Cols[6].Add('Telefone');
    Cols[7].Add('Celular');
    Cols[8].Add('Situação');
    Cols[9].Add('Valor');
    Cols[10].Add('Aparelho');
  End;
end;

procedure TFr_Clta_Csto.Fm_ListaSituacaoDBLCB_SituacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
      Fm_ListaSituacao.DBLCB_Situacao.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_Clta_Csto.FormClose(Sender: TObject;
var
    Action: TCloseAction);
begin
  Action:=caFree;
  Fr_Clta_Csto:=Nil;
end;


procedure TFr_Clta_Csto.Pc_BuscarOrcamento;
var
  Lc_sqltxt : string;
  Lc_Orcamento, Lc_Cliente, Lc_ApMarMod, Lc_Serie, Lc_Situacao :boolean;
begin
  Screen.Cursor:=crHourGlass;
  Lc_sqltxt:='';
  if Cb_Busca_Empresa.Text='' Then Lc_Cliente:=False else Lc_Cliente:=True;
  if Fm_ListaSituacao.DBLCB_Situacao.Text='' Then Lc_Situacao:=False else Lc_Situacao:=True;
  if E_Orcamento.Text='' Then Lc_Orcamento:=False else Lc_Orcamento:=True;
  if E_ApMarMod.Text='' Then Lc_ApMarMod:=False else Lc_ApMarMod:=True;
  if E_Serie.Text='' Then Lc_Serie:=False else Lc_Serie:=True;

  with Qr_Conserto do
  Begin
    Active := False;
    sql.Clear;
    Lc_sqltxt:='SELECT DISTINCT CTC_CODIGO,CTC_CODPED, CTC_NUMERO,CTC_DATA,CTC_FANTASIA,END_FONE, '+
                'END_CELULAR,SIT_DESCRICAO,CTC_VL_COTACAO,CST_APARELHO,CST_CODSIT, CTC_CODEMP '+
               'FROM TB_CONSERTO tb_conserto '+
               '   INNER JOIN TB_COTACAO tb_cotacao  '+
               '   ON (tb_cotacao.CTC_CODPED =  tb_conserto.CST_CODPED) '+
               '   INNER JOIN TB_EMPRESA Tb_empresa '+
               '   ON  (Tb_empresa.EMP_CODIGO = Tb_cotacao.CTC_CODEMP)'+
               '   INNER JOIN TB_ENDERECO tb_endereco '+
               '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO) '+
               '   LEFT OUTER JOIN TB_PEDIDO Tb_pedido '+
               '   ON  (Tb_pedido.PED_CODIGO = Tb_cotacao.CTC_CODPED)'+
               '   LEFT OUTER JOIN TB_SITUACAO tb_situacao '+
               '   ON (tb_situacao.SIT_CODIGO = tb_conserto.CST_CODSIT) '+
            'WHERE (CST_CODIGO IS NOT NULL)  AND (END_PRINCIPAL = ''S'') ';

    if not Fm_LME.chbx_Empresas.Checked then
      Lc_sqltxt := concat(
                        Lc_sqltxt,
                        ' AND ( CTC_CODMHA =:CTC_CODMHA )'
      );


    if not Lc_Orcamento then
    Begin
      if ChBx_Periodo.Checked then
        Lc_SqlTxt := Lc_SqlTxt +'AND (CTC_DATA BETWEEN :DATAINI AND :DATAFIM )';
      if Lc_Cliente then Lc_SqlTxt := Lc_SqlTxt +'AND ((EMP_NOME LIKE :EMP_NOME) OR (EMP_FANTASIA LIKE :EMP_FANTASIA) )';
      if Lc_ApMarMod then Lc_SqlTxt := Lc_SqlTxt +'AND ((CST_APARELHO LIKE :CST_ESPEF) OR(CST_MARCA LIKE :CST_ESPEF)OR (CST_MODELO LIKE :CST_ESPEF) ) ';
      if Lc_Serie then Lc_SqlTxt := Lc_SqlTxt +'AND (CST_NUMERO LIKE :CST_NUMERO) ';
      if Lc_Situacao then Lc_SqlTxt := Lc_SqlTxt +'AND (SIT_CODIGO =:SIT_CODIGO) ';
    end
    else
    Begin
      Lc_SqlTxt := Lc_SqlTxt +' AND (CTC_NUMERO LIKE :CTC_NUMERO) ';
    end;

    SQL.Add(Lc_sqltxt+' ORDER BY CTC_FANTASIA ');

    if not Fm_LME.chbx_Empresas.Checked then
      ParamByName('CTC_CODMHA').AsInteger := Fm_LME.Dblcb_Lista.KeyValue;

    if not Lc_Orcamento then
    Begin
      if ChBx_Periodo.Checked then
      Begin
        ParamByName('DATAINI').Asdate:=E_Data_Ini.Date;
        ParamByName('DATAFIM').Asdate:=E_Data_Fim.Date;
      end;
      if Lc_Cliente then ParamByName('EMP_NOME').AsString:='%'+ Cb_Busca_Empresa.Text + '%';
      if Lc_ApMarMod then ParamByName('CST_ESPEF').AsString:='%'+E_ApMarMod.Text + '%';
      if Lc_Serie then ParamByName('CST_NUMERO').AsString:='%'+E_Serie.Text + '%';
      if Lc_Situacao then ParamByName('SIT_CODIGO').Asinteger:= Fm_ListaSituacao.DBLCB_Situacao.KeyValue;
    end
    else
    Begin
      ParamByName('CTC_NUMERO').AsString:='%'+E_Orcamento.Text+'%';
    end;

    Active:=true;
  End;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Clta_Csto.Sb_Sair_0Click(Sender: TObject);
begin
    Close;
end;

procedure TFr_Clta_Csto.SB_VisualizarClick(Sender: TObject);
begin
  with StrGrd_Conserto do
  Begin
    IF Length(Cells[1,Row])>0 then
    Begin
      AbreTelaConserto(StrToInt(Cells[1,Row]));
      Fm_ListaSituacao.Etapa := 1;
      Fm_ListaSituacao.Listar;
    end;
  End;
end;

procedure TFr_Clta_Csto.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;

end;

procedure TFr_Clta_Csto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
      case Key of
      VK_F2  : if Sb_Inserir.Enabled then Sb_InserirClick(Sender);
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_F8  : if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
      VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
    end;
end;
procedure TFr_Clta_Csto.Sb_ClienteClick(Sender: TObject);
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

procedure TFr_Clta_Csto.Sb_InserirClick(Sender: TObject);
begin
  AbreTelaConserto(0);
end;

procedure TFr_Clta_Csto.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Clta_Csto.SB_BuscarClick(Sender: TObject);
begin
  Pc_BuscarOrcamento;
  Pc_PreencheGradeOrcamento;
end;

procedure TFr_Clta_Csto.E_OrcamentoExit(Sender: TObject);
begin
  if StrToFloatDef(E_Orcamento.Text,0) > 0 then SB_BuscarClick(Sender) else  E_Orcamento.Clear;
end;


procedure TFr_Clta_Csto.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Fm_LME.Listar('EMP_NOME');
  Fm_LME.HabilitarMultiEmpresa;
  Pc_ListaClienteComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,Cb_Busca_Empresa);
  E_Orcamento.SetFocus;
  if Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','') = 'S' then
    ChBx_Periodo.Checked:=true
  else
    ChBx_Periodo.Checked:=false;
end;

procedure TFr_Clta_Csto.AbreTelaConserto(Codigo:Integer);
Var
  Lc_Form : TTasConserto;
begin
  Lc_Form := TTasConserto.Create(Self);
  Try
    Lc_Form.CodigoRegistro := Codigo;
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Clta_Csto.Qr_ConsertoAfterOpen(DataSet: TDataSet);
begin
  Qr_Conserto.FetchAll;
  SB_Visualizar.Enabled := Qr_Conserto.RecordCount > 0;
end;

procedure TFr_Clta_Csto.Cb_SituacaoChange(Sender: TObject);
begin
  StrGrd_Conserto.Cells[StrGrd_Conserto.Col,StrGrd_Conserto.Row] := Cb_Situacao.Items[Cb_Situacao.ItemIndex];
  Cb_Situacao.Visible := False;
  StrGrd_Conserto.SetFocus
end;

procedure TFr_Clta_Csto.Cb_SituacaoExit(Sender: TObject);
begin
  StrGrd_Conserto.Cells[StrGrd_Conserto.Col,StrGrd_Conserto.Row]:= Cb_Situacao.Items[Cb_Situacao.ItemIndex];
  Cb_Situacao.Visible := False;
  StrGrd_Conserto.SetFocus;

end;

procedure TFr_Clta_Csto.StrGrd_ConsertoDblClick(Sender: TObject);
begin
  if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
end;

procedure TFr_Clta_Csto.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Clta_Csto.Configuraes1Click(Sender: TObject);
Var
  Form : TTasConfigConserto;
begin
  try
    Form := TTasConfigConserto.Create(nil);
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_Clta_Csto.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Inserir := True;
    It_Alterar := True;
    It_Excluir := True;
    It_Encerrar := True;
    It_Imprimir := True;
    It_Visualizar := True;
    end
  else
    begin
    It_Inserir    := Fc_HabilitaPermissao(Pc_Menu,'INSERIR','S');
    It_Alterar    := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
    It_Excluir    := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
    It_Encerrar    := Fc_HabilitaPermissao(Pc_Menu,'ENCERRAR','S');
    It_Imprimir    := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    end;
    Sb_Inserir.Enabled:= It_Inserir;
end;


procedure TFr_Clta_Csto.ChBx_NomeClick(Sender: TObject);
begin
  Pc_ListaClienteComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,Cb_Busca_Empresa);
end;

procedure TFr_Clta_Csto.ChBx_FantasiaClick(Sender: TObject);
begin
  Pc_ListaClienteComboBox('EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,Cb_Busca_Empresa);
end;

procedure TFr_Clta_Csto.E_Busca_Cd_EmpresaExit(Sender: TObject);
begin
  if Chbx_Nome.Checked then
    CB_Busca_Empresa.Text := Fc_BuscaNomeCliente('EMP_NOME',E_Busca_Cd_Empresa.Text)
  else
    CB_Busca_Empresa.Text := Fc_BuscaNomeCliente('EMP_FANTASIA',E_Busca_Cd_Empresa.Text);
end;

procedure TFr_Clta_Csto.Sb_Pesq_ClienteClick(Sender: TObject);
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

end.
