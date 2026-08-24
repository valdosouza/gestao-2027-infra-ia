unit cad_product_variant;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, base_registry, Vcl.StdCtrls, Un_Base, Data.DB, ControllerLojaTray, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, ControllerProductVariant, Un_DM, Datasnap.Provider;

type
  TCadProductVariant = class(TBaseRegistry)
    Cds_Variante: TClientDataSet;
    Ds_Variante: TDataSource;
    GerarAtutomaticamente1: TMenuItem;
    Cb_Tamanho: TComboBox;
    Label2: TLabel;
    Cb_Cor: TComboBox;
    Label3: TLabel;
    E_Valor: TEdit;
    Label4: TLabel;
    E_Quantidade: TEdit;
    Label5: TLabel;
    Cds_VarianteID: TIntegerField;
    Cds_VarianteTB_PRODUCT_ID: TIntegerField;
    Cds_VarianteSKU_ID: TIntegerField;
    Cds_VarianteTAMANHO: TWideStringField;
    Cds_VarianteCOR: TWideStringField;
    Cds_VarianteQUANTITY: TFMTBCDField;
    Cds_VariantePRICE_TAG: TFMTBCDField;
    DbgVariantes: TDBGrid;
    Cds_VarianteWEB_ID: TIntegerField;
    popmenu: TPopupMenu;
    RetiraroVinculocomaWEb1: TMenuItem;
    procedure GerarAtutomaticamente1Click(Sender: TObject);
    procedure DbgVariantesDblClick(Sender: TObject);
    procedure E_QuantidadeExit(Sender: TObject);
    procedure E_ValorExit(Sender: TObject);
    procedure RetiraroVinculocomaWEb1Click(Sender: TObject);
  private
    CodigoSKU : Integer;
  protected
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
    procedure setPerfil;Override;
    procedure ClearAllFields;Override;
    procedure EditionControl;Override;
    procedure ShowData;Override;
    procedure ShowNoData;Override;
    //inserir
    function ValidaInsert():boolean;Override;
    procedure Insert;Override;
    //Editar
    function ValidateChange():boolean;Override;
    procedure Change;Override;
    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;
    //Cancelar
    function ValidateCancel():boolean;Override;
    procedure Cancel;Override;


  public
    { Public declarations }
    Variante : TControllerProductVariant;
  end;

var
  CadProductVariant: TCadProductVariant;

implementation

{$R *.dfm}

uses     cad_product_variant_auto, Un_Msg, env;

procedure TCadProductVariant.Cancel;
begin
  inherited;

end;

procedure TCadProductVariant.Change;
begin
  inherited;
  CodigoSKU := Cds_VarianteSKU_ID.AsInteger;
  Variante.SKU.Registro.Codigo := Cds_VarianteSKU_ID.AsInteger;
  Variante.SKU.Registro.VarianteID := Cds_VarianteID.AsInteger;
  //Interface
  Cb_Tamanho.Text   := Cds_VarianteTAMANHO.AsString;
  Cb_Cor.Text       := Cds_VarianteCOR.AsString;
  E_Quantidade.Text := FloatToStrF(Cds_VarianteQUANTITY.AsFloat,ffFixed,10,2);
  E_Valor.Text      := FloatToStrF(Cds_VariantePRICE_TAG.AsFloat,ffFixed,10,2);

end;

procedure TCadProductVariant.ClearAllFields;
begin
  inherited;
  CodigoSKU := 0;
  Cb_Tamanho.Text := '';
  Cb_Cor.Text := '';
  E_Valor.Text := '0,00';
  E_Quantidade.Text := '0,00';
end;

procedure TCadProductVariant.CriarVariaveis;
begin
  inherited;
  Variante := TControllerProductVariant.Create(self);
  Variante.ListarTamanho(Cb_Tamanho);
  Variante.ListarCor(Cb_Cor);
end;

procedure TCadProductVariant.DbgVariantesDblClick(Sender: TObject);
begin
  if SB_Alterar.Enabled then
    SB_alterarClick(Sender);

end;

procedure TCadProductVariant.Delete;
begin
  //Grava os dados para verificação apos a exclusão
  Variante.Registro.Codigo := Cds_VarianteID.AsInteger;
  Variante.Registro.ProdutoVariante := Cds_VarianteTB_PRODUCT_ID.AsInteger;
  //executa a exclusão do item selecinoad
  Variante.SKU.Registro.Codigo := Cds_VarianteSKU_ID.AsInteger;
  Variante.SKU.Registro.VarianteID := Cds_VarianteID.AsInteger;
  Variante.SKU.delete;
  //Executa a exclusão no dataset
  Cds_Variante.Delete;
  //Verifica se tem outros vinculados
  Variante.SKU.getList;
  if Variante.SKU.Lista.Count = 0 then
  Begin
    Variante.delete;
    Self.Close;
  End;
end;

procedure TCadProductVariant.EditionControl;
begin
  Pf_Inserir := True;
  Pf_Alterar := True;
  Pf_Excluir := True;
  inherited;
  pnl_fundo.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );

end;

procedure TCadProductVariant.E_QuantidadeExit(Sender: TObject);
begin
  TEdit(Sender).Text := FloatToSTrF(StrtoFloatDef(TEdit(Sender).Text,0),ffFixed,10,2)
end;

procedure TCadProductVariant.E_ValorExit(Sender: TObject);
begin
  TEdit(Sender).Text := FloatToSTrF(StrtoFloatDef(TEdit(Sender).Text,0),ffFixed,10,2);
end;

procedure TCadProductVariant.FormataTela;
begin
  inherited;

end;

procedure TCadProductVariant.GerarAtutomaticamente1Click(Sender: TObject);
Var
  Lc_Form : TCadProductVariantAuto;
begin
  Try
    Lc_Form := TCadProductVariantAuto.Create(nil);
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
  End;

end;

procedure TCadProductVariant.IniciaVariaveis;
begin
  if CodigoRegistro > 0 then
  Begin
    Variante.Registro.ProdutoVariante := CodigoRegistro;
    Variante.getList(Cds_Variante);
  End;
  inherited;

end;

procedure TCadProductVariant.Insert;
begin
  inherited;
  ClearAllFields;
end;

procedure TCadProductVariant.RetiraroVinculocomaWEb1Click(Sender: TObject);
Var
  Lc_Loja : TControllerLojaTray;
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Retirar o vinculo deste produto com o produto da WEb ' + Cds_VarianteWEB_ID.AsString + '.' + EOLN +
                      'Atenção esta operação não pode ser desfeita.'+ EOLN + EOLN +
                      'Confirmar a operação ?',
                      [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
  Begin
    try
      Lc_Loja := TControllerLojaTray.Create(nil);
      Lc_Loja.Registro.Tabela := 'TB_PRODUCT_VARIANT_SKU';
      Lc_Loja.Registro.Codigo := Cds_VarianteSKU_ID.AsInteger;
      Lc_Loja.delete;
      Cds_Variante.Edit;
      Cds_VarianteWEB_ID.Value := 0;
      Cds_Variante.Post;
    finally
      FreeAndNil(Lc_Loja);
    end;

  End;
end;

procedure TCadProductVariant.Save;
begin
  Variante.Registro.ProdutoVariante := CodigoRegistro;
  Variante.getbyProduct;
  if not Variante.exist then
  Begin
    Variante.Registro.Codigo := 0;
    Variante.Registro.ProdutoVariante := CodigoRegistro;
    Variante.Registro.Disponibilidade := 'S';
    Variante.Registro.Quantidade := 0;
    Variante.insert;
  End
  else
  Begin
    Variante.update;
  End;
  Variante.SKU.Registro.Codigo          := CodigoSKU;
  Variante.SKU.Registro.VarianteID      := Variante.Registro.Codigo;
  Variante.SKU.Registro.Tamanho         := Cb_Tamanho.Text;
  Variante.SKU.Registro.Cor             :=  Cb_Cor.Text;
  Variante.SKU.Registro.Valor           := StrTofloatDEf(E_Valor.Text,0);
  Variante.SKU.Registro.Quantidade      := StrTofloatDEf(E_Quantidade.Text,0);
  Variante.SKU.salva;
  if CodigoSKU >0 then
    Cds_Variante.Edit
  else
    Cds_Variante.Append;

  Cds_VarianteID.AsInteger            := Variante.Registro.Codigo;
  Cds_VarianteTB_PRODUCT_ID.AsInteger := CodigoRegistro;
  Cds_VarianteSKU_ID.AsInteger        := Variante.SKU.Registro.Codigo;
  Cds_VarianteTAMANHO.AsString        := Variante.SKU.Registro.Tamanho;
  Cds_VarianteCOR.AsString            := Variante.SKU.Registro.Cor;
  Cds_VarianteQUANTITY.AsFloat        := Variante.SKU.Registro.Quantidade;
  Cds_VariantePRICE_TAG.AsFloat       := Variante.SKU.Registro.Valor;
  Cds_Variante.Post;

  Variante.ListarTamanho(Cb_Tamanho);
  Variante.ListarCor(Cb_Cor);

end;

procedure TCadProductVariant.setPerfil;
begin
  inherited;

end;

procedure TCadProductVariant.ShowData;
begin
  inherited;

end;

procedure TCadProductVariant.ShowNoData;
begin
  inherited;

end;

function TCadProductVariant.ValidaInsert: boolean;
begin
  Result := True;

end;

function TCadProductVariant.ValidateCancel: boolean;
begin
  Result := True;
end;

function TCadProductVariant.ValidateChange: boolean;
begin
  Result := True;
end;

function TCadProductVariant.ValidateDelete: boolean;
begin
  Result := True;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir este lançamento de seus arquivos.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
  begin
    REsult := False;
  end;

end;

function TCadProductVariant.ValidateSave: boolean;
begin
  Result := True;
 if (Trim(Cb_Tamanho.Text) = '') and (Trim(Cb_Cor.Text) = '') then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Campo Tamanho ou Cor devem ser preenchidos.' + EOLN +
                   'Preencha um deles para continuar.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
  end;

end;

end.
