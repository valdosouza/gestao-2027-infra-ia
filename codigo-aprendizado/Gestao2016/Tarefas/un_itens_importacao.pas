unit un_itens_importacao;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Mask, QEdit_Setes, ControllerItensImport, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, ControllerProduto, Data.DB, STQuery;


type
  TFr_itens_importacao = class(TFr_Base)
    Panel1: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Lb_DescricaoProduto: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Label10: TLabel;
    SB_Gravar: TBitBtn;
    Sb_Pesquisar: TBitBtn;
    Sb_Sair_0: TBitBtn;
    E_CodPro: TEdit;
    E_Qt_Produto: TEdit_Setes;
    E_Vl_Unitario: TEdit_Setes;
    E_Descricao: TEdit;
    E_Cotacao: TEdit_Setes;
    Sb_Limpar: TBitBtn;
    E_Vl_SubTotal: TPanel;
    Ds_Pesquisa: TDataSource;
    Qr_Pesquisa: TSTQuery;
    procedure SB_GravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure E_CodProExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure E_Vl_UnitarioEnter(Sender: TObject);
    procedure E_Qt_ProdutoEnter(Sender: TObject);
    procedure E_CotacaoEnter(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure Sb_LimparClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure E_DescricaoExit(Sender: TObject);
    procedure Sb_PesquisarClick(Sender: TObject);
    procedure E_Vl_UnitarioExit(Sender: TObject);
    procedure Sb_PesquisarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure E_Qt_ProdutoExit(Sender: TObject);
    procedure E_CotacaoExit(Sender: TObject);
  private
    { Private declarations }
    it_bt_pesquisa:Boolean;
    procedure IniciaVariavel;
    procedure SetVariavel;
    function ValidaCampos:boolean;
    procedure GravaItem;
    procedure LimpaCampos;
    procedure InserirNovoItem;

    Procedure Busca(Pc_cd_Prod:String; Pc_Desc_prod:String);
    Function  BuscaProduto(Pc_Tipo,Pc_Codigo: string; Pc_Descricao: string):Integer;
    procedure MostraBusca;
    procedure Totalizador;
  public
    { Public declarations }
    Itens : TControllerItensImport;
  end;

var
  Fr_itens_importacao: TFr_itens_importacao;

implementation

{$R *.dfm}

uses     Un_Msg, Un_Regra_Negocio, UN_Principal, env, UN_Sistema, Un_Pesq_Produto;
Procedure TFr_itens_importacao.Busca(Pc_cd_Prod:String; Pc_Desc_prod:String);
Var
   Lc_Nr_Itens : Integer;
   Lc_Cd_Tabela : Integer;
   Lc_Vl_Produto : Real;
   Lc_Qt_Minima : real;
   Lc_Aliq_Comissao : Real;
Begin
  if (Pc_cd_Prod = '') and (Pc_Desc_prod = '') then exit;
  Lc_Nr_Itens := BuscaProduto('P', Pc_cd_Prod,Pc_Desc_prod);
  case Lc_Nr_Itens of
    0:Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Produto não encontrado ou inativo.'+EOLN+
                       'Verfique e tente novamente.'+EOLN,
                        ['OK'],[bEscape],mpErro);
        Screen.Cursor := crDefault;
        LimpaCampos;
        if E_CodPro.CanFocus then E_CodPro.SetFocus;
        if E_Descricao.CanFocus then E_Descricao.SetFocus;
        exit;
      end;
    1:Begin
        //vERifICA SE O PRODUTO ESTA ATIVO
        if Qr_Pesquisa.FieldByName('PRO_ATIVO').AsString <> 'S' then
        Begin
          MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                         'Este produto não está inativo.'+EOLN+
                         'Verfique e tente novamente.'+EOLN,
                        ['OK'],[bEscape],mpErro);
          Screen.Cursor := crDefault;
          E_CodPro.Clear;
          exit;
        end;
        E_Descricao.Text := Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString;
      end;
    else
      MostraBusca;
    end;
   Screen.Cursor := crDefault;
end;

function TFr_itens_importacao.BuscaProduto(Pc_Tipo,Pc_Codigo,Pc_Descricao: string): Integer;
var
   Lc_SqlTxt: string;
   Lc_Codigo: boolean;
   Lc_Descricao: boolean;
   Lc_CodigoInteiro: Integer;
   Lc_Barras: Integer;

   LCProduto : TControllerProduto;
Begin
  Lc_SqlTxt := '';
  Screen.Cursor := crHourGlass;
  Qr_Pesquisa.Close;
  Qr_Pesquisa.Sql.Clear;

  Lc_SqlTxt :=  'SELECT '+
                '   PRO_CODIGO, '+
                '   PRO_CODIGOFAB, '+
                '   PRO_CODIGOFOR, '+
                '   PRO_CODIGOBAR, '+
                '   PRO_DESCRICAO, '+
                '   PRO_VL_CUSTO,  '+
                '   MED_ABREVIATURA, '+
                '   PRO_CAMPANHA, '+
                '   PRO_ATIVO, '+
                '   PRO_COMPOSICAO, '+
                '   PRO_SUB_TRIB '+
                'FROM TB_PRODUTO tb_produto  '+
                '   INNER JOIN TB_MEDIDA MED '+
                '   ON  (MED.MED_CODIGO = tb_produto.PRO_CODMED)  '+
                'WHERE (PRO_CODIGO IS NOT NULL) AND (PRO_ATIVO = ''S'')  ';


  if Pc_Tipo = 'P' then
  Begin
    if Pc_Codigo = '' then    Lc_Codigo := False else  Lc_Codigo := True;
    Lc_CodigoInteiro := StrToIntDef(Pc_Codigo, 0);
    if Lc_Codigo THEN
    Begin
     //Verifica se é um numero ou se é alfa-numerico
     IF Lc_CodigoInteiro = 0 THEN
       Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO))'
     else
       Lc_Sqltxt := Lc_Sqltxt + 'AND (PRO_CODIGO =:PRO_CODIGO) ';
    end;

    Lc_SqlTxt := Lc_SqlTxt + ' and (PRO_TIPO = ''P'') ';

    if not GB_ProdCompartilha then   Lc_SqlTxt := Lc_SqlTxt+ ' AND PRO_CODMHA = :PRO_CODMHA';
  end
  else
  Begin
    if Pc_Codigo = '' then    Lc_Codigo := False else  Lc_Codigo := True;
    if Pc_Descricao = '' then Lc_Descricao := False  else Lc_Descricao := True;

    Lc_CodigoInteiro := StrToIntDef(Pc_Codigo, 0);
    Lc_Barras := Length(Pc_Codigo);
    if Lc_Codigo THEN
    Begin
      //Verifica se a busca será pelo codigo Exato
      if (Fc_Aq_Geral('L', 'PRODUTO','PRO_P_COD_EXATO', 'S')='S') then
      Begin
        //Verifica se é um numero ou se é alfa-numerico
        IF Lc_CodigoInteiro = 0 THEN
           Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO))'
        else
           Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGO =:PRO_CODIGO) or (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO))';
      end
      else
      Begin
        //Verifica se é um numero ou se é alfa-numerico
        IF Lc_CodigoInteiro = 0 THEN
           Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE:PRO_CODIGO))'
        else
           Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGO LIKE :PRO_CODIGO) or (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO))';
      end;
    end;

    if Lc_Descricao then   Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';
    Lc_SqlTxt := Lc_SqlTxt + ' and (PRO_TIPO = ''P'') ';
    if not GB_ProdCompartilha  then   Lc_SqlTxt := Lc_SqlTxt+ ' AND PRO_CODMHA = :PRO_CODMHA';
  end;

  Qr_Pesquisa.SQL.Add(Lc_SqlTxt);

  //PASSAGEM de parametro

  if Lc_Codigo THEN
  Begin
    //Verifica se a busca será pelo codigo Exato
    if (Fc_Aq_Geral('L', 'PRODUTO','PRO_P_COD_EXATO', 'S')='S') then
    Begin
      Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := Pc_Codigo;
    end
    else
    Begin
      if Pc_Tipo = 'P' then
        Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := Pc_Codigo
      else
        Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := '%' + Pc_Codigo + '%';
    end;
  end;


  if Lc_Descricao THEN  Qr_Pesquisa.ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(Pc_Descricao,1,98) + '%';
  if not GB_ProdCompartilha  then  Qr_Pesquisa.ParamByName('PRO_CODMHA').AsInteger:=Gb_CodMha;

  Qr_Pesquisa.Active := True;
  Qr_Pesquisa.FetchAll;
  Result := Qr_Pesquisa.RecordCount;
  if Result = 1 THEN
    Itens.Registro.Produto := Qr_Pesquisa.FIELDBYNAME('PRO_CODIGO').AsInteger;
end;


procedure TFr_itens_importacao.E_CodProExit(Sender: TObject);
begin
  if not it_bt_pesquisa then  // se for falso nao foi clicando no pesquisado , nem apertado f7
  Begin
    if (E_CodPro.Text = '') THEN
    Begin
      if E_Descricao.CanFocus then E_Descricao.SetFocus;
      exit;
    end;

    if (IntToStr(Itens.Registro.Produto) <> E_CodPro.Text) then  E_Vl_Unitario.Text := '0,00';

    if (E_CodPro.Text <> '') then
      E_Descricao.Text:=''
    else
      if (IntToStr(Itens.Registro.Produto) <> E_CodPro.Text) then  E_Vl_Unitario.Text := '0,00';

    if (E_CodPro.Text <> '') then
      E_Descricao.Text:='';

    Busca(E_CodPro.text,'')
  end;
end;

procedure TFr_itens_importacao.E_CotacaoEnter(Sender: TObject);
begin
  TEdit_setes(Sender).SelectAll;
end;

procedure TFr_itens_importacao.E_CotacaoExit(Sender: TObject);
begin
  inherited;
Totalizador;
end;

procedure TFr_itens_importacao.E_DescricaoExit(Sender: TObject);
begin
  if not it_bt_pesquisa then  // se for falso nao foi clicando no pesquisado , nem apertado f7
  Begin
    if (E_Descricao.Text = '') THEN
    Begin
      if E_Vl_Unitario.CanFocus then E_Vl_Unitario.SetFocus;
      exit;
    end;
    BuscaProduto('B', '',Copy(E_Descricao.Text,1,50));
  end;
end;

procedure TFr_itens_importacao.E_Qt_ProdutoEnter(Sender: TObject);
begin
  TEdit_setes(Sender).SelectAll;
end;

procedure TFr_itens_importacao.E_Qt_ProdutoExit(Sender: TObject);
begin
  inherited;
  Totalizador;
end;

procedure TFr_itens_importacao.E_Vl_UnitarioEnter(Sender: TObject);
begin
  TEdit_setes(Sender).SelectAll;
end;

procedure TFr_itens_importacao.E_Vl_UnitarioExit(Sender: TObject);
begin
  Totalizador;
end;

procedure TFr_itens_importacao.FormCreate(Sender: TObject);
begin
  Itens := TControllerItensImport.Create(Self);
end;

procedure TFr_itens_importacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  Begin
    case Key of
      VK_F5: if SB_Gravar.Enabled then  SB_GravarClick(Sender);
      VK_F7: if SB_Pesquisar.Enabled then
                Begin
                it_bt_pesquisa:=true;
                if Sb_Pesquisar.CanFocus then Sb_Pesquisar.SetFocus;
                  MostraBusca;
                end;
      VK_F8: if Sb_Limpar.Enabled then  Sb_LimparClick(Sender);
      VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
  end;
end;

procedure TFr_itens_importacao.FormShow(Sender: TObject);
begin
  IniciaVariavel;
end;

procedure TFr_itens_importacao.GravaItem;
begin
  with Itens.Registro do
  Begin
    Produto       := StrtoIntDef(E_CodPro.Text,0);
    Quantidade    := StrToFloatDef(E_Qt_Produto.Text,0);
    ValorUnitario := StrToFloatDef(E_Vl_Unitario.Text,0);
    Cotacao       := StrToFloatDef(E_Cotacao.Text,0);
  End;
  Itens.salva;
end;

procedure TFr_itens_importacao.IniciaVariavel;
begin
  if not E_CodPro.ReadOnly then E_CodPro.SetFocus else E_Vl_Unitario.SetFocus;
  
end;

procedure TFr_itens_importacao.InserirNovoItem;
Var
  LcPedido : Integer;
begin
  LcPedido := Itens.Registro.Ordem;
  Itens.Clear;
  Itens.Registro.Ordem := LcPedido;
  E_Vl_Unitario.Text := '0,00';
  E_Qt_Produto.Text := '1,00';
  E_Cotacao.Text := '1,00';
  E_CodPro.SetFocus;
end;

procedure TFr_itens_importacao.LimpaCampos;
begin
  E_CodPro.Text := '';
  E_Descricao.Clear;
  E_Vl_Unitario.Text := '0,00';
  E_Qt_Produto.Text := '1';
  E_Vl_SubTotal.Caption := '0,00';
end;

procedure TFr_itens_importacao.MostraBusca;
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  Lc_Form := TFr_Pesq_Produto.Create(Self);
  Lc_Form.Pc_Tabelas_Disponiveis;
  Lc_Form.it_Modalidade_preco := 'A';
  Lc_Form.It_MultiplicadorPreco := 1;
  Lc_Form.E_BuscaCodigo.Text := E_CodPro.Text;
  Lc_Form.E_BuscaDescricao.Text := E_Descricao.Text;


  Lc_Form.ShowModal;
  //Depois que Fecha o Relatorio
  if Lc_Form.It_Visualizar then
  Begin
    E_CodPro.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
    E_Descricao.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString;
    E_Vl_Unitario.SetFocus;
  end;
  FreeAndNil(Lc_Form) ;
end;

procedure TFr_itens_importacao.SB_GravarClick(Sender: TObject);
begin
  if ValidaCampos then
  Begin
    GravaItem;
    LimpaCampos;
    InserirNovoItem;
  end;
end;


procedure TFr_itens_importacao.Sb_LimparClick(Sender: TObject);
begin
  LimpaCampos;
end;

procedure TFr_itens_importacao.Sb_PesquisarClick(Sender: TObject);
begin
  it_bt_pesquisa :=true;
  MostraBusca;
end;

procedure TFr_itens_importacao.Sb_PesquisarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  it_bt_pesquisa:=TRUE;
  if Sb_Pesquisar.CanFocus then Sb_Pesquisar.SetFocus;
end;

procedure TFr_itens_importacao.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_itens_importacao.SetVariavel;
begin

end;

procedure TFr_itens_importacao.Totalizador;
Var
  Lc_Vl_aux : Real;
  Lc_Vl_Total : Real;
  Lc_Qt_aux : Real;
  Lc_VL_IPI : Real;
  Lc_VL_Cotacao : Real;
begin
  Lc_Vl_Total := 0;
  //Quanatidade PRodutos
  Lc_Qt_aux := StrToFloatDef(E_Qt_Produto.Text,1);
  E_Qt_Produto.Text := FormatFloat('0.00#', Lc_Qt_aux);
  //Valor dos Produtos
  Lc_Vl_aux := StrToFloatDef(E_Vl_Unitario.Text, 0);
  E_Vl_Unitario.Text := FormatFloat('0.00#', Lc_Vl_aux);
  //Valor da Cotação
  Lc_VL_Cotacao := StrToFloatDef(E_Cotacao.Text, 1);
  E_Cotacao.Text := FormatFloat('0.00#', Lc_VL_Cotacao);
  //Valor Subtotal Do Produto
  Lc_Vl_aux := (Lc_Vl_aux * Lc_Qt_aux ) * Lc_VL_Cotacao;
  E_Vl_SubTotal.Caption := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);

end;

function TFr_itens_importacao.ValidaCampos: boolean;
begin
  Result := true;
  IF ( (Trim(E_CodPro.Text) = '') or (Trim(E_CodPro.Text) = '0') ) then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Código do Produto É Obrigatório.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_CodPro.CanFocus then E_CodPro.SetFocus;
    Result := False;
    exit;
  end;

  IF (Trim(E_Descricao.Text) = '') then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Descrição do Produto É Obrigatório.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_CodPro.CanFocus then E_CodPro.SetFocus;
    Result := False;
    exit;
  end;

  IF (Trim(E_Vl_Unitario.Text) = '') or (StrToFloatDef(E_Vl_Unitario.Text,0) <= 0) then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Valor Unitário É Obrigatório e maior do que zero.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Vl_Unitario.CanFocus then E_Vl_Unitario.SetFocus;
    Result := False;
    exit;
  end;

  IF (Trim(E_Qt_Produto.Text) = '') or (StrToFloatDef(E_Qt_Produto.Text,0) <= 0)then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Quantidade É Obrigatório e maior do que zero.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Qt_Produto.CanFocus then E_Qt_Produto.SetFocus;
    Result := False;
    exit;
  end;

  IF (Trim(E_Cotacao.Text) = '') or (StrToFloatDef(E_Cotacao.Text,0) <= 0)then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo cotação É Obrigatório e maior do que zero.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Cotacao.CanFocus then E_Cotacao.SetFocus;
    Result := False;
    exit;
  end;
end;

end.
