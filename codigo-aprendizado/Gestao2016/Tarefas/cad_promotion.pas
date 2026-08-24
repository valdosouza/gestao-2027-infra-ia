unit cad_promotion;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids, Un_Fm_ListaProdutos, Datasnap.Provider, Datasnap.DBClient, ControllerDskPromotion;

type
  TCadPromotion = class(TBaseRegistry)
    GroupBox1: TGroupBox;
    pnl_row_1: TPanel;
    Label28: TLabel;
    E_promocao: TMaskEdit;
    E_Valor: TMaskEdit;
    e_Quantidade: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBG_Produtos: TDBGrid;
    Sb_Exc_Produto: TBitBtn;
    Label5: TLabel;
    E_Cd_Barras: TEdit;
    Fm_ListaProdutos: TFm_ListaProdutos;
    cds_Items: TClientDataSet;
    Ds_Items: TDataSource;
    Sb_Ins_Produto: TBitBtn;
    cds_ItemsTB_INSTITUTION_ID: TIntegerField;
    cds_ItemsTB_PROMOTION_ID: TIntegerField;
    cds_ItemsTB_PRODUCT_ID: TIntegerField;
    cds_ItemsPRO_DESCRICAO: TWideStringField;
    Label3: TLabel;
    pnl_row_2: TPanel;
    Label4: TLabel;
    E_ValorTotal: TMaskEdit;
    pnl_row_3: TPanel;
    ChBx_Ativa: TCheckBox;
    Label6: TLabel;
    E_Dt_Expiration: TMaskEdit;
    procedure Sb_Exc_ProdutoClick(Sender: TObject);
    procedure Sb_Ins_ProdutoClick(Sender: TObject);
    procedure E_Cd_BarrasExit(Sender: TObject);
    procedure Fm_ListaProdutosSb_ProdutoClick(Sender: TObject);
    procedure Fm_ListaProdutosE_Cd_ProdutoExit(Sender: TObject);
    procedure e_QuantidadeExit(Sender: TObject);
    procedure E_ValorTotalExit(Sender: TObject);
    procedure E_Dt_ExpirationKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    It_Casa_Decimal : Integer;
    procedure Pc_DefineCasaDecimal;
    function montadescription:String;
    procedure GeraLogSistema(Oper,Descricao:String);
  protected
    procedure ImagemBotao;Override;
    procedure setPerfil;Override;
    procedure LimpaCampos;Virtual;
    procedure CriarVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure ShowData;Override;
    procedure PreecherlisttItems( cds_Items : TClientDataSet; CodigoID:Integer);
    procedure IniciaVariaveis;Override;
    procedure Insert;Override;

    procedure execShorCutKeyF7;Override;
    procedure execShorCutKeyF8;Override;

    procedure DeleteItems(cds_Items : TClientDataSet; order_id:Integer);
    function ValidateDeleteItems:Boolean;
    procedure DeleteItem;

    function ValidateInsertItem:Boolean;
    procedure InsertItem;

    function ValidateChange:Boolean;Override;
    procedure Change;Override;

    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;


    function ValidateSave:Boolean;Override;
    procedure Save;Override;
    procedure SaveItems(cds_items : TClientDataSet; PromotionID:Integer);

    function ValidateCancel:Boolean;Override;
    procedure Cancel;Override;
    procedure EditionControl;override;
    public
    { Public declarations }
    Promotion : TControllerDskPromotion;
    CodigoDetalhe : Integer;
  end;

var
  CadPromotion: TCadPromotion;

implementation

{$R *.dfm}

uses     Un_DM, UN_Principal, env, Un_Msg, tblDskPromotionItems, ControllerDskPromotionItems, UN_Sistema, Un_Fc_Sored_Procedures;

{ TCadPromotion }

procedure TCadPromotion.Change;
begin
  inherited;
  E_promocao.SetFocus;
  if CodigoDEtalhe > 0 then
  Begin
    DBG_Produtos.setfocus;
    cds_items.Locate('tb_product_id',CodigoDEtalhe,[]);
  End;

end;

procedure TCadPromotion.Cancel;
begin
  if (EditionState = 'I') then
  Begin
    ClearFields(self);
    Self.Close;
  End
  else
  Begin
    ShowData;
    EditionState := 'B';
    EditionControl;
  End;
end;

procedure TCadPromotion.CriarVariaveis;
begin
  inherited;
  Promotion := TControllerDskPromotion.Create(Self);
  CodigoDEtalhe := 0;
  Pc_DefineCasaDecimal;
end;

procedure TCadPromotion.DeleteItem;
begin
  cds_Items.Delete;
end;

procedure TCadPromotion.Delete;
begin
  Promotion.Registro.Ativo := 'N';
  Promotion.update;
  Close;
end;

procedure TCadPromotion.DeleteItems(cds_Items: TClientDataSet;order_id: Integer);
Var
  LcOperacao : String;
  cds_temp : TClientDataSet;
begin
  if cds_items.ChangeCount > 0 then
  Begin
    Try
      cds_temp := TClientDataSet.Create(Self);
      cds_temp.Data := cds_items.Delta;
      cds_temp.First;
      cds_items.First;
      //Trata somente os dados deletados
      while not cds_temp.eof do
      Begin
        if cds_temp.UpdateStatus = usDeleted then
        Begin
          //Detalhe
          Promotion.Items.Registro.Promocao         := cds_Temp.FieldByName('tb_promotion_id').AsInteger;
          Promotion.Items.Registro.Estabelecimento  := cds_Temp.FieldByName('tb_institution_id').AsInteger;
          Promotion.Items.Registro.Produto          := cds_Temp.FieldByName('tb_product_id').AsInteger;
          Promotion.Items.delete;
          GeraLogSistema('Item Excluido: Ação direta',cds_Temp.FieldByName('pro_descricao').AsString);
        End;
        cds_temp.Next;
      end;
    Finally
      cds_temp.Close;
      FreeAndNil(cds_temp);
    End;
  End;
end;

procedure TCadPromotion.EditionControl;
begin
  inherited;
  pnl_fundo.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
end;

procedure TCadPromotion.execShorCutKeyF7;
begin
  if Pnl_fundo.Enabled then
  Begin
    if Sb_Ins_Produto.Enabled then Sb_Ins_ProdutoClick(Self);
  End;
end;

procedure TCadPromotion.execShorCutKeyF8;
begin
  if pnl_fundo.Enabled then
  Begin
    if Sb_Exc_Produto.Enabled then Sb_Exc_ProdutoClick(Self);
  End;
end;

procedure TCadPromotion.E_Cd_BarrasExit(Sender: TObject);
begin
  inherited;
  if Length(E_Cd_Barras.Text) >=8 then
  Begin
    with Promotion.Items.Produto do
    BEgin
      Registro.CodigoBarras := E_Cd_Barras.Text;
      getbyBarCode;
      IF exist THEN
      Begin
        Fm_ListaProdutos.E_Cd_Produto.Text := Registro.Codigo.ToString;
        Fm_ListaProdutos.E_Busca_Produto.Text := Registro.Descricao;
        Sb_Ins_ProdutoClick(sender);
      End;
    End;
  End;
end;

procedure TCadPromotion.E_Dt_ExpirationKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
      Promotion.Registro.DataValidade := 0;
      E_Dt_Expiration.Clear;
    end;
  end;
end;

procedure TCadPromotion.e_QuantidadeExit(Sender: TObject);
begin
  montadescription;
end;

procedure TCadPromotion.E_ValorTotalExit(Sender: TObject);
begin
  montadescription;
end;

procedure TCadPromotion.FinalizaVariaveis;
begin
  FreeAndNil(Promotion);
  inherited;
end;

procedure TCadPromotion.Fm_ListaProdutosE_Cd_ProdutoExit(Sender: TObject);
begin
  inherited;
  Fm_ListaProdutos.E_Cd_ProdutoExit(Sender);

end;

procedure TCadPromotion.Fm_ListaProdutosSb_ProdutoClick(Sender: TObject);
begin
  inherited;
  Fm_ListaProdutos.Sb_ProdutoClick(Sender);

end;

procedure TCadPromotion.GeraLogSistema(Oper,Descricao: String);
begin
  Pc_Log_Sistema( Gb_CodMha,
                  GB_Cd_Usuario,
                  (Now),
                  'Cadastro de Promoção',
                  Promotion.Registro.Codigo,
                  Oper,
                  Descricao);
end;

procedure TCadPromotion.save;
Var
  Lc_temp_date : TDateTime;
begin
  with Promotion.Registro do
  Begin
    Estabelecimento := Gb_CodMha;
    Descricao := E_promocao.Text;
    Preco := StrtoFloatDef(E_Valor.Text,0);
    Quantidade := StrtoFloatDef(e_Quantidade.Text,0);
//    if E_Dt_Expiration.Text = '  /  /    ' then    '  /  /    '
    Lc_temp_date := 0;
    if TryStrToDate(E_Dt_Expiration.Text,Lc_temp_date) then
      DataValidade := StrToDate(E_Dt_Expiration.Text)
    else
      DataValidade := 0;

    if ChBx_Ativa.Checked then
      Ativo := 'S'
    else
      Ativo := 'N';
  End;
  Promotion.salva;
  GeraLogSistema('Gravou: Ação direta',Promotion.Registro.Descricao);
  SAveItems(cds_Items,Promotion.Registro.Codigo);
  CodigoRegistro := Promotion.Registro.Codigo;
  EditionState := 'B';
  EditionControl;
end;

procedure TCadPromotion.SaveItems(cds_items: TClientDataSet;
  PromotionID: Integer);
Var
  LcOperacao : String;
begin
  DeleteItems(cds_items, PromotionID);

  if cds_items.ChangeCount > 0 then
  Begin
    cds_items.First;
    //Trata somente os dados Inseridos ou Alterados
    while not cds_items.eof do
    Begin
      with Promotion.Items do
      Begin
        Registro.Promocao         := Promotion.Registro.Codigo;
        Registro.Estabelecimento  := Gb_CodMha;
        Registro.Produto          := cds_items.FieldByName('tb_product_id').AsInteger;
        case cds_items.UpdateStatus of
          usModified: update;
          usInserted:
          Begin
             insert;
             GeraLogSistema('Item Inserido: Ação direta',cds_Items.FieldByName('pro_descricao').AsString);
          End;
        end;

      End;
      cds_items.next;
    End;
    cds_items.MergeChangeLog;
  End;
end;

procedure TCadPromotion.ImagemBotao;
begin
  inherited;
end;

procedure TCadPromotion.IniciaVariaveis;
begin
  if CodigoRegistro > 0 then
  Begin
    Promotion.Registro.Codigo := Self.CodigoRegistro;
    Promotion.Registro.Estabelecimento := Gb_CodMha;
    Promotion.getbyId;
  End;
  inherited;
end;

procedure TCadPromotion.InsertItem;
Begin
 with self.cds_Items do
  Begin
    if not Active then createDataset;
    Append;
    FieldByName('tb_institution_id').AsInteger  := Gb_CodMha;
    FieldByName('tb_promotion_id').AsInteger    := Promotion.Registro.Codigo;
    FieldByName('tb_product_id').AsInteger      := StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0);
    FieldByName('PRO_DESCRICAO').AsString       := Fm_ListaProdutos.E_Busca_Produto.Text;
    Post;
    Active := False;
    Active := True;
  End;
end;

procedure TCadPromotion.Insert;
begin
  inherited;
  LimpaCampos;
  ChBx_Ativa.Checked := True;
  E_promocao.SetFocus;
end;

procedure TCadPromotion.LimpaCampos;
begin
  ClearFields(self);
  CodigoDEtalhe := 0;
end;

function TCadPromotion.montadescription: String;
Var
  LcQtde:REal;
  LcValor:REal;
begin
  Result := '';

  LcQtde := StrToFloatDef(e_Quantidade.Text,0);
  Result := concat(FloatToStrF(LcQtde,ffFixed,10,0),' X ');

  LcValor := StrToFloatDef(E_ValorTotal.Text,0);

  Result := concat(Result, FloatToStrF(LcValor,ffFixed,10,2));

  E_Valor.Text := FloatToStrF(LcValor / LcQtde  ,ffFixed,10,It_Casa_Decimal);
  E_promocao.Text := Result;
end;

procedure TCadPromotion.Pc_DefineCasaDecimal;
begin
  //Define casas decimais para as vendas
  case StrToIntDef(Fc_Tb_Geral('L','PRO_CASA_DEC_VENDA','0'),0) of
    0:It_Casa_Decimal := 2;
    1:It_Casa_Decimal := 3;
    2:It_Casa_Decimal := 4;
    3:It_Casa_Decimal := 5;
    4:It_Casa_Decimal := 6;
  end;
end;

procedure TCadPromotion.PreecherlisttItems(cds_Items: TClientDataSet;
  CodigoID: Integer);
Var
  I : Integer;
  Registro : TDSkPromotionItems;
begin
  Promotion.Items.Registro.Estabelecimento := Gb_CodMha;
  Promotion.Items.Registro.Promocao := CodigoID;
  Promotion.Items.getList;

  with cds_items  do
  Begin
    if not Active then CreateDataSet;
    cds_items.LogChanges := False;
    cds_items.EmptyDataSet;
    for I := 0 to Promotion.Items.Lista.Count - 1 do
    Begin
      Registro := Promotion.Items.Lista[I];
      Append;
      FieldByName('tb_institution_id').AsInteger  := Registro.Estabelecimento;
      FieldByName('tb_promotion_id').AsInteger    := Registro.Promocao;
      FieldByName('tb_product_id').AsInteger      := Registro.Produto;
      //dados dos Produtos
      Promotion.Items.Produto.Registro.Codigo := Registro.Produto;
      Promotion.Items.Produto.getbyId;
      FieldByName('PRO_DESCRICAO').AsString := Promotion.Items.Produto.Registro.Descricao;
      Post;
    End;
  End;
  cds_items.LogChanges := True;

end;

procedure TCadPromotion.ShowData;
begin
  with Promotion.Registro do
  Begin
    E_promocao.Text := Descricao;
    e_Quantidade.Text := FloattoStrF(Quantidade,ffFixed,10,2);
    E_ValorTotal.Text   := FloattoStrF(Preco * quantidade,ffFixed,10,2);
    E_Valor.Text := FloattoStrF(Preco,ffFixed,10,It_Casa_Decimal);
    if DataValidade > 0 then
      E_Dt_Expiration.Text := DateToStr(DataValidade)
    else
      E_Dt_Expiration.Clear;
    ChBx_Ativa.Checked := (Ativo = 'S');
  End;
  PreecherlisttItems(cds_Items,CodigoRegistro);
end;

procedure TCadPromotion.Sb_Exc_ProdutoClick(Sender: TObject);
begin
  inherited;
  if ValidateDeleteItems then
    DeleteItem;
end;

procedure TCadPromotion.Sb_Ins_ProdutoClick(Sender: TObject);
begin
  if ValidateInsertItem then
  Begin
    InsertItem;
    E_Cd_Barras.Clear;
    Fm_ListaProdutos.E_Cd_Produto.Clear;
    Fm_ListaProdutos.E_Busca_Produto.Clear;
    E_Cd_Barras.SetFocus;
  End;
end;

procedure TCadPromotion.setPerfil;
begin
  pfMenu := 'seaPromotion';//esse cadastro e o de pesquisa estão atrelados
  inherited;

end;

function TCadPromotion.ValidateChange: Boolean;
begin
  Result := True;
end;

function TCadPromotion.ValidateCancel: Boolean;
begin
  Result := True;
end;


function TCadPromotion.ValidateDelete: boolean;
begin
  Result := True;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Deseja relamente excluir esta promoção?.' + EOLN +
                      'Esta promoção será desativada'+EOLN + EOLN +
                      'Confirmar a exclusão ?',
                      [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
  Begin
    Result := False;
    Exit;
  End;
end;

function TCadPromotion.ValidateDeleteItems: Boolean;
begin
  Result := True;
  if not cds_items.Active then cds_items.CreateDataSet;

  if cds_items.RecordCount = 0 then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Não há itens para Delete.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
  End;
  //quando a pergunta esta dentro da validação verifica-se o botão da negativa
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja Delete este item?'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                      [NAO,SIM],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;

end;

function TCadPromotion.ValidateSave: Boolean;
begin
  Result:=true;
  if Trim(E_promocao.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Descrição da promoção não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if E_promocao.CanFocus then E_promocao.SetFocus;
   Exit;
  end;

  if StrToFloatDef(E_Valor.Text,0) = 0 then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Valor da promoção não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if E_Valor.CanFocus then E_Valor.SetFocus;
   Exit;
  end;

  if StrToFloatDef(e_Quantidade.Text,0)= 0 then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Quantidade da promoção não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if e_Quantidade.CanFocus then e_Quantidade.SetFocus;
   Exit;
  end;

  if not cds_Items.Active then cds_Items.CreateDataSet;

  if cds_Items.RecordCount = 0 then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Nenhum produto associado a esta promoção.'+EOLN+
                   'Verifique para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   Exit;
  End;

end;

function TCadPromotion.ValidateInsertItem: Boolean;
Var
  LcPromo :TControllerDskPromotion;
begin
  Result:=true;
  if not cds_Items.Active then cds_Items.CreateDataSet;
  if Trim( Fm_ListaProdutos.E_Cd_Produto.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Códcódcódcódigo do produto não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if Fm_ListaProdutos.E_Cd_Produto.CanFocus then Fm_ListaProdutos.E_Cd_Produto.SetFocus;
   Exit;
  end;

  if Trim( Fm_ListaProdutos.E_Busca_Produto.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Produto não encontrado.'+EOLN+
                   'Verifique o códcódcódigo do produto.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if Fm_ListaProdutos.E_Busca_Produto.CanFocus then Fm_ListaProdutos.E_Busca_Produto.SetFocus;
   Exit;
  end;

  if cds_Items.Locate('TB_PRODUCT_ID',Fm_ListaProdutos.E_Cd_Produto.Text,[]) then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Este Produto já está na lista desta promoção.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   Exit;
  end;

  try
    LcPromo := TControllerDskPromotion.Create(Self);
    LcPromo.Items.Registro.Estabelecimento := Gb_CodMha;
    LcPromo.Items.Registro.Produto := StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0);
    LcPromo.Items.Registro.Promocao := Promotion.Registro.Codigo;
    LcPromo.Items.getProductDuplicated;
    if LcPromo.Items.exist then
    Begin
      if (MensagemPadrao(MENSAGEM,
                         'Este produto já está cadastrado em outra promoção.'+EOLN+
                         'Para incluir nesta é necessário excluir da anterior.'+EOLN+
                         'Deseja excluir este produto da promoção anterior?'+EOLN+EOLN+
                         'Confirmar a exclusão ?',
                          [NAO,SIM],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
      Begin
        //Delata  item da promoção antiga
        LcPromo.Items.delete;

        GeraLogSistema('Item excluido por substituição: ',
                       concat('Promocao: ',LcPromo.Items.Registro.Promocao.ToString(),
                              'Produto: ',Fm_ListaProdutos.E_Busca_Produto.Text
                       ));
        //Altera a promoção para que seja enviada para a internet
        LcPromo.Registro.Estabelecimento := Gb_CodMha;
        LcPromo.Registro.Codigo := LcPromo.Items.Registro.Promocao;
        LcPromo.getbyId;
        LcPromo.update;
        Result := True;

      End
      else
      Begin
        Result := False;
      End;
    End;
  finally
    FreeAndNil(LcPromo);
  end;

end;


end.
