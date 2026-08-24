unit un_inventario_manual;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.StdCtrls, Vcl.Mask, QEdit_Setes, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls, Data.DB, STQuery, Vcl.DBCtrls, Un_Fm_ListaEstoques, controllerproduto, ControllerBase, ControllerInventario;

type
  TFr_inventario_manual = class(TFr_Base)
    Panel3: TPanel;
    Label5: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    SB_Cad_produto: TSpeedButton;
    Label11: TLabel;
    Label12: TLabel;
    E_Codigo: TEdit;
    E_Codigo_Barras: TEdit;
    E_Cont_Atual: TEdit;
    E_VL_Custo: TEdit;
    E_Produto: TEdit;
    SB_Gravar: TBitBtn;
    Sb_Sair_0: TBitBtn;
    E_Data: TDateTimePicker;
    Label1: TLabel;
    Fm_ListaEstoques: TFm_ListaEstoques;
    Label2: TLabel;
    E_Cont_Anterior: TEdit;
    E_Custo_Anterior: TEdit;
    Label3: TLabel;
    InativartodososProdutos1: TMenuItem;
    Panel1: TPanel;
    procedure SB_Cad_produtoClick(Sender: TObject);
    procedure E_CodigoExit(Sender: TObject);
    procedure E_Codigo_BarrasExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SB_GravarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure E_Cont_AtualEnter(Sender: TObject);
    procedure E_VL_CustoEnter(Sender: TObject);
    procedure InativartodososProdutos1Click(Sender: TObject);
    procedure E_Cont_AtualExit(Sender: TObject);
  private
    { Private declarations }
    barraSetFocus : Boolean;
    function ValidaDataInventario:Boolean;
    function ValidaGravacao:Boolean;
    procedure PegaProdutoByBarra(Fc_Codigo: String);
    procedure Dados_Inventario;

    procedure GeraInventario;
    procedure AtualizaDados;
    procedure LimpaCampos;

  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
  public
    { Public declarations }
    Inventario : TcontrollerInventario;
  end;

var
  Fr_inventario_manual: TFr_inventario_manual;

implementation

{$R *.dfm}

uses     Un_Pesq_Produto, RN_Produto, Un_Msg, Un_DM, UN_Principal, env, RN_Inventario, Un_Fc_Sored_Procedures;
procedure TFr_inventario_manual.PegaProdutoByBarra(Fc_Codigo: String);
var
  Lc_SQL: String;
  Lc_Tp_Descricao : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SQL := 'SELECT PRO_CODIGO, PRO_DESCRICAO FROM TB_PRODUTO '+
                'WHERE PRO_CODIGOBAR =:PRO_CODIGOBAR' ;
      SQL.Add(Lc_SQL);
      ParamByName('PRO_CODIGOBAR').AsString := Fc_Codigo;
      Active := True;
      FetchAll;

      if RecordCount > 0 then
      begin
        E_Codigo.Text := FieldByName('PRO_CODIGO').AsString;
        E_Produto.Text := FieldByName('PRO_DESCRICAO').AsString;
        E_Cont_Atual.SetFocus;
        E_Cont_Atual.SelectAll;
      end
      else
      begin
        E_Codigo_Barras.SetFocus;
        E_Codigo_Barras.clear;
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Produto não encontrado.'+EOLN,
                       ['OK'],[bEscape],mpAlerta);
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_inventario_manual.CriarVariaveis;
begin
  inherited;
  Inventario := TControllerInventario.create(Self);
end;

procedure TFr_inventario_manual.Dados_Inventario;
Var
  Lc_sqlTxt : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      //Cria componente para selecionar os produtos para inventario
      Close;
      SQL.Clear;
      Lc_SqlTxt := concat( 'SELECT IVT_QT_ATUAL,IVT_VL_CUSTO ',
                           'FROM TB_INVENTARIO ',
                           'WHERE (IVT_DATA =:IVT_DATA) ',
                           ' AND (IVT_CODMHA=:IVT_CODMHA) ',
                           ' AND (IVT_CODPRO=:IVT_CODPRO) '
                          );
      SQL.Add(Lc_SqlTxt);
      ParamByName('IVT_DATA').AsDate := E_Data.DateTime;
      ParamByName('IVT_CODMHA').AsInteger := Gb_CodMha;
      ParamByName('IVT_CODPRO').AsInteger := StrToIntDef(E_Codigo.Text,0);
      Active := True;
      FetchAll;
      First;
      IF RecordCount > 0 then
      Begin
        E_Cont_Anterior.Text := FloatToStrF(FieldByName('IVT_QT_ATUAL').AsFloat,ffFixed,10,2);
        E_Custo_Anterior.Text := FloatToStrF(FieldByName('IVT_VL_CUSTO').AsCurrency,ffFixed,10,2);
      End
      else
      Begin
        E_Cont_Anterior.Text := '0,00';
        E_Custo_Anterior.Text := '0,00';
      End
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_inventario_manual.AtualizaDados;
begin
  with Inventario do
  Begin
    Produto.registro.codigo := StrToIntDef(E_Codigo.Text,0);
    Produto.registro.Ativo := 'S';
    Produto.Ativa;
    //Atualiza o Estoque
    Produto.Estoque.SaldoEstoque.Registro.CodigoEstoque := Fm_ListaEstoques.Dblcb_Estoque.KeyValue;
    Produto.Estoque.SaldoEstoque.Registro.CodigoProduto := StrToIntDef(E_Codigo.Text,0);
    Produto.Estoque.SaldoEstoque.Registro.QtdeDisp      := StrToFloatDef(E_Cont_Atual.Text,0);
    Produto.Estoque.SaldoEstoque.update;
  End;
end;


function TFr_inventario_manual.ValidaDataInventario: Boolean;
Var
  Lc_Qry: TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
begin
  Try
    Result := True;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin;
      Lc_SqlTxt := concat( 'SELECT IVT_DATA ',
                           'FROM TB_INVENTARIO ',
                           'WHERE (IVT_DATA >:IVT_DATA) ',
                           ' AND (IVT_CODMHA=:IVT_CODMHA) ',
                           ' AND (IVT_CODPRO=:IVT_CODPRO) ',
                           ' order by IVT_DATA ASC '
                          );
      SQL.Add(Lc_SqlTxt);
      ParamByName('IVT_DATA').AsDate := E_Data.DateTime;
      ParamByName('IVT_CODMHA').AsInteger := Gb_CodMha;
      ParamByName('IVT_CODPRO').AsInteger := StrToIntDef(E_Codigo.Text,0);
      Active := True;
      FetchAll;
      if RecordCount > 0 then
      Begin
        MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                       'Inventário com a data de ' + DateToStr(FieldByName('IVT_DATA').AsDateTime) + ' foi encontrado.'+ EOLN +
                       'Não é permitido criar invetários retroativos.' + EOLN ,
                       ['Ok'], [bEscape], mpAlerta);
        Result := False;
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

function TFr_inventario_manual.ValidaGravacao:Boolean;
Begin
  Result := True;
  If StrToIntDef(E_Codigo.Text,0) = 0 then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Código produto deve ser informado.' + EOLN ,
                   ['Ok'], [bEscape], mpAlerta);
    E_Codigo.SetFocus;
    Result:=False;
    exit;
  end;

  If (E_Produto.Text = '') then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Produto não informado.' + EOLN ,
                   ['Ok'], [bEscape], mpAlerta);
    E_Codigo.SetFocus;
    Result:=False;
    exit;
  end;

  If (StrToFloatDef(E_Cont_Atual.Text,0) = 0 ) and (StrToFloatDef(E_Cont_Anterior.Text,0) = 0 ) then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Contagem atual deve ser maior do que zero.' + EOLN ,
                   ['Ok'], [bEscape], mpAlerta);
    E_Cont_Atual.SetFocus;
    Result:=False;
    exit;
  end;

  If StrToFloatDef(E_VL_Custo.Text,0) = 0 then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Valor Custo deve ser informado.' + EOLN ,
                   ['Ok'], [bEscape], mpAlerta);
    E_VL_Custo.SetFocus;
    Result:=False;
    exit;
  end;

  if not ValidaDataInventario then
  Begin
    Result:=False;
    exit;
  End;
  E_Cont_AtualExit(Self);
End;

procedure TFr_inventario_manual.E_CodigoExit(Sender: TObject);
Begin
  If E_Codigo.Text <> '' then
  Begin
    E_Produto.Text := Fc_PegaProduto(E_Codigo.Text,'');
    Dados_Inventario;
    barraSetFocus := False;
    E_Cont_Atual.SetFocus;
  End;
end;

procedure TFr_inventario_manual.E_Codigo_BarrasExit(Sender: TObject);
begin
  If E_Codigo_Barras.Text <> '' then
  Begin
    PegaProdutoByBarra(E_Codigo_Barras.Text);
    Dados_Inventario;
    barraSetFocus := True;
    E_Cont_Atual.SetFocus;
  End;
end;

procedure TFr_inventario_manual.E_Cont_AtualEnter(Sender: TObject);
begin
  TEdit(Sender).SelectAll;

end;

procedure TFr_inventario_manual.E_Cont_AtualExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := 0;
  Lc_Valor := StrToFloatDef(E_Cont_Atual.Text, 0);
  if Lc_Valor >= 10000 then Lc_Valor := 1;
  E_Cont_Atual.Text := FloatToStr(Lc_Valor);
end;

procedure TFr_inventario_manual.E_VL_CustoEnter(Sender: TObject);
begin
  TEdit(Sender).SelectAll;
end;

procedure TFr_inventario_manual.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  Begin
    case Key of
      VK_F5: if SB_Gravar.Enabled then  SB_GravarClick(Sender);
      VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_inventario_manual.InativartodososProdutos1Click(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Atenção esta operação vai inativar todos os produtos.' + EOLN + EOLN +
                      'Confirmar a Operação ?',
                      [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBlue) = mrBotao1) then
  Begin
    Pc_Log_Sistema( Gb_CodMha,
                    GB_Cd_Usuario,
                    (Now),
                    'Inventario Manual',
                    GB_Cd_Usuario,
                    'Desativar produtos',concat('Usuário confirmou a primeira etapa que vai desativar todos os produtos', DateTimeToStr(Now)));
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                        'Precisamos de uma segunda confirmação.' + EOLN +
                        'Esta operação não poderé ser cancelada, e só poderá ser defeita com intervenção tõcnica.' + EOLN +
                        'Confirmar novamente a Operação ?',
                        [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    Begin
      Pc_Log_Sistema( Gb_CodMha,
                      GB_Cd_Usuario,
                      (Now),
                      'Inventario Manual',
                      GB_Cd_Usuario,
                      'Desativar produtos',concat('Usuário confirmou a Segunda etapa que vai desativar todos os produtos', DateTimeToStr(Now)));
      Inventario.Produto.DesativarTodos( Gb_CodMha );
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Produtos desativados com Sucesso.' + EOLN +
                     'Conforme a contagem dos produtos informados nesta tela.' + EOLN+
                     'O processo do inventário vai ativar o produto novamente.'+EOLN,
                     ['OK'], [bEscape], mpErro);
    End;
  End;

end;

procedure TFr_inventario_manual.IniciaVariaveis;
begin
  inherited;

  E_Data.DateTime := Now;
  Fm_ListaEstoques.AtivaLista(Gb_CodMha);
end;

procedure TFr_inventario_manual.GeraInventario;
Var
  LcId : Integer;
begin
  with Inventario do
  Begin
    Registro.Codigo           := 0;
    Registro.Data             :=  E_Data.DateTime;
    Registro.Estoque          :=  Fm_ListaEstoques.Dblcb_Estoque.KeyValue;
    Registro.Produto          :=  StrToIntDef(E_Codigo.Text,0);
    Registro.QtdeAtual        :=  StrToFloatDef(E_Cont_Atual.Text,0);
    Registro.ValorCusto       :=  StrToFloatDef(E_VL_Custo.Text,0);
    Registro.Estabelecimento  :=  Gb_CodMha;
    salva;
  End;
end;

procedure TFr_inventario_manual.LimpaCampos;
begin
  E_Codigo.Clear;
  E_Codigo_Barras.Clear;
  E_Produto.Clear;
  E_Cont_Anterior.Text  := '0,00';
  E_Custo_Anterior.Text  := '0,00';
  E_Cont_Atual.Text     := '0,00';
  E_VL_Custo.Text       := '0,00';
  Fm_ListaEstoques.AtivaLista(Gb_CodMha);
end;

procedure TFr_inventario_manual.SB_Cad_produtoClick(Sender: TObject);
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  Lc_Form := TFr_Pesq_Produto.Create(Self);
  Lc_Form.Pc_Tabelas_Disponiveis;
  Lc_Form.it_Modalidade_preco := 'A';
  Lc_Form.ShowModal;
  //Depois que Fecha o Relatorio
  if Lc_Form.It_Visualizar then
  Begin
    E_Codigo.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
    E_Codigo_Barras.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGOBAR').AsString;
    E_Produto.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString;
    Dados_Inventario;
    E_Cont_Atual.SetFocus;
  end;
  FreeAndNil(Lc_Form) ;
end;

procedure TFr_inventario_manual.SB_GravarClick(Sender: TObject);
begin
  if ValidaGravacao then
  Begin
    Gerainventario;
    AtualizaDados;
    LimpaCampos;
    if barraSetFocus then
      E_Codigo_Barras.SetFocus
    else
      E_Codigo.SetFocus;
  End;
end;

procedure TFr_inventario_manual.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

end.

