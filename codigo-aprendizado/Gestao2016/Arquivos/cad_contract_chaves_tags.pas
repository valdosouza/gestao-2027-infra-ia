unit cad_contract_chaves_tags;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, Un_Fm_ListaProdutos, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, ControllerContractChaves;

type
  TCadContractChavesTags = class(TFr_Base)
    Panel1: TPanel;
    Panel2: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    E_Chave: TEdit;
    ChBx_Ativa: TCheckBox;
    pnl_row_2: TPanel;
    Label1: TLabel;
    E_Field: TEdit;
    Sb_Inserir: TBitBtn;
    Sb_Excluir: TBitBtn;
    cds_Items: TClientDataSet;
    Ds_Items: TDataSource;
    DBG_Produtos: TDBGrid;
    cds_ItemsID: TIntegerField;
    cds_ItemsTB_CONTRACT_ID: TIntegerField;
    cds_ItemsCHAVE: TStringField;
    cds_ItemsFIELD: TStringField;
    procedure Sb_InserirClick(Sender: TObject);
    procedure Sb_ExcluirClick(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
  private
    FCodigoContrato: Integer;
    ContractChaves : TControllerContractChaves;

    procedure PreecherlisttItems;

    function ValidateInsertItem:Boolean;
    procedure InsertItem;
    procedure setFCodigoContrato(const Value: Integer);

    procedure DeleteItems(cds_Items : TClientDataSet);
    function ValidateDeleteItems:Boolean;
    procedure DeleteItem;

    function ValidateSave:Boolean;
    procedure Save;
    procedure SaveItems(cds_items : TClientDataSet);


  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure ImagemBotao;Override;

    procedure execShorCutKeyF2;Override;
    procedure execShorCutKeyF3;Override;

  public
    { Public declarations }
    property CodigoContrato : Integer read FCodigoContrato write setFCodigoContrato;
  end;

var
  CadContractChavesTags: TCadContractChavesTags;

implementation

{$R *.dfm}

uses     Un_Msg, env;

procedure TCadContractChavesTags.CriarVariaveis;
begin
  inherited;
  ContractChaves := TControllerContractChaves.create(self);
end;

procedure TCadContractChavesTags.DeleteItem;
Begin
  cds_Items.Delete;
end;

procedure TCadContractChavesTags.DeleteItems(cds_Items: TClientDataSet);
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
          ContractChaves.Registro.Codigo    := cds_Temp.FieldByName('ID').AsInteger;
          ContractChaves.Registro.Contrato  := cds_Temp.FieldByName('TB_CONTRACT_ID').AsInteger;
          ContractChaves.Registro.Chave     := cds_Temp.FieldByName('CHAVE').AsString;
          ContractChaves.Registro.Campo     := cds_Temp.FieldByName('FIELD').AsString;
          ContractChaves.delete;
        End;
        cds_temp.Next;
      end;
    Finally
      cds_temp.Close;
      FreeAndNil(cds_temp);
    End;
  End;

end;

procedure TCadContractChavesTags.execShorCutKeyF2;
begin
  if Sb_Inserir.Enabled then Sb_InserirClick(Self);
end;

procedure TCadContractChavesTags.execShorCutKeyF3;
begin
  if Sb_Excluir.Enabled then Sb_ExcluirClick(Self);

end;

procedure TCadContractChavesTags.FinalizaVariaveis;
begin
  inherited;

end;

procedure TCadContractChavesTags.ImagemBotao;
begin
  CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
  CarregaImagemBotao(SB_Sair_0,'SAIR');
end;

procedure TCadContractChavesTags.IniciaVariaveis;
begin
  inherited;
  PreecherlisttItems;
end;

procedure TCadContractChavesTags.InsertItem;
begin
 with self.cds_Items do
  Begin
    if not Active then createDataset;
    Append;
    FieldByName('ID').AsInteger  := 0;
    FieldByName('TB_CONTRACT_ID').AsInteger := FCodigoContrato;
    FieldByName('CHAVE').AsString           := E_Chave.text;
    FieldByName('FIELD').AsString           := E_Field.text;
    Post;
    Active := False;
    Active := True;
  End;

end;

procedure TCadContractChavesTags.PreecherlisttItems;
Var
  I : Integer;
begin
  ContractChaves.Registro.Contrato := FCodigoContrato;
  ContractChaves.getList;

  with cds_items  do
  Begin
    if not Active then CreateDataSet;
    cds_items.LogChanges := False;
    cds_items.EmptyDataSet;
    for I := 0 to ContractChaves.Lista.Count - 1 do
    Begin
      Append;
      FieldByName('ID').AsInteger := ContractChaves.Lista[I].Codigo;
      FieldByName('TB_CONTRACT_ID').AsInteger := ContractChaves.Lista[I].Contrato;
      FieldByName('CHAVE').AsString := ContractChaves.Lista[I].Chave;
      FieldByName('FIELD').AsString := ContractChaves.Lista[I].Campo;
      Post;
    End;
  End;
  cds_items.LogChanges := True;
end;

procedure TCadContractChavesTags.Save;
begin
  inherited;
  SAveItems(cds_Items);
end;

procedure TCadContractChavesTags.SaveItems(cds_items: TClientDataSet);
Var
  LcOperacao : String;
begin
  DeleteItems(cds_items);

  if cds_items.ChangeCount > 0 then
  Begin
    cds_items.First;
    //Trata somente os dados Inseridos ou Alterados
    while not cds_items.eof do
    Begin
      with ContractChaves do
      Begin
        Registro.Codigo    := cds_items.FieldByName('ID').AsInteger;
        Registro.Contrato  := cds_items.FieldByName('TB_CONTRACT_ID').AsInteger;
        Registro.Chave     := cds_items.FieldByName('CHAVE').AsString;
        Registro.Campo     := cds_items.FieldByName('FIELD').AsString;
        case cds_items.UpdateStatus of
          usModified: ContractChaves.update;
          usInserted: ContractChaves.insert;
        end;
      End;
      cds_items.next;
    End;
    cds_items.MergeChangeLog;
  End;
end;

procedure TCadContractChavesTags.SB_ConfirmarClick(Sender: TObject);
begin
  if ValidateSave then
  Begin
    Save;
    Close;
  End;
end;

procedure TCadContractChavesTags.Sb_ExcluirClick(Sender: TObject);
begin
  if ValidateDeleteItems then
    DeleteItem;
end;

procedure TCadContractChavesTags.Sb_InserirClick(Sender: TObject);
begin
  if ValidateInsertItem then
  Begin
    InsertItem;
    E_Chave.Clear;
    E_Chave.SetFocus;
    E_Field.Clear;
  End;
end;

procedure TCadContractChavesTags.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TCadContractChavesTags.setFCodigoContrato(const Value: Integer);
begin
  FCodigoContrato := Value;
end;

function TCadContractChavesTags.ValidateDeleteItems: Boolean;
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
                      [NAO, SIM],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;

end;

function TCadContractChavesTags.ValidateInsertItem: Boolean;
begin
  Result:=true;
  if not cds_Items.Active then cds_Items.CreateDataSet;
  if Trim( E_Chave.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Campo Chave/Tag não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if E_Chave.CanFocus then E_Chave.SetFocus;
   Exit;
  end;

  if Trim( E_Field.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Campo Nome do Campo Origem não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if E_Field.CanFocus then E_Field.SetFocus;
   Exit;
  end;

end;

function TCadContractChavesTags.ValidateSave: Boolean;
begin
  Result := True;
  if not cds_Items.Active then cds_Items.CreateDataSet;

  if cds_Items.RecordCount = 0 then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Nenhum Chave e/ ou Campo associado neste contrato.'+EOLN+
                   'Verifique para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   Exit;
  End;
end;

end.
