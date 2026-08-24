unit reg_plano_contas;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.DBCtrls, Data.DB, STQuery, ControllerPlanoContas, System.StrUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TRegPlanoContas = class(TBaseRegistry)
    Trw_PlanoContas: TTreeView;
    Grp_busca: TGroupBox;
    Label8: TLabel;
    Sb_Buscar: TSpeedButton;
    Sb_Filtrar: TSpeedButton;
    E_BuscaDescricao: TMaskEdit;
    Qr_Pesquisa: TSTQuery;
    Qr_PesquisaPLC_CODPLANO: TStringField;
    Qr_PesquisaPLC_DESCRICAO: TStringField;
    Qr_PesquisaPLC_NATUREZA: TStringField;
    Qr_PesquisaPLC_NIVEL: TStringField;
    Qr_PesquisaPLC_CODIGO: TIntegerField;
    Qr_ProxCodigo: TSTQuery;
    Qr_ProxNivel: TSTQuery;
    E_Codplc: TEdit;
    E_Descricao: TEdit;
    Label3: TLabel;
    Label7: TLabel;
    Rg_Natureza: TRadioGroup;
    Rg_Nivel: TRadioGroup;
    Rg_Tipo: TRadioGroup;
    procedure Trw_PlanoContasClick(Sender: TObject);
    procedure Sb_BuscarClick(Sender: TObject);
    procedure Sb_FiltrarClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_gravarClick(Sender: TObject);
  private
    { Private declarations }
    planoContas : TControllerPlanoContas;
    It_Pos_Conta : Integer;
    It_CtaSelecionada : String;
    It_Qtde_Items : Integer;
    function existeRegistro:Boolean;
    procedure Pc_Filtrar;
    procedure PC_Buscar;
    procedure Pc_PreencherTreeView(Pc_Query : TDataset; Pc_tv : TTreeView; Pc_Pai : TTreeNode );
    Function Fc_NoPorNome (Fc_Tipo : byte;Fc_Tree : TTreeView; Fc_Value:String; Fc_Visible: Boolean): TTreeNode;
    function Fc_NivelHierarquico( const fc_s : String ) : integer;

  protected
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure ImagemBotao;Override;
    procedure FormataTela;Override;
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
    procedure Cancel;Override;
    procedure EditionControl;Override;

  end;

var
  RegPlanoContas: TRegPlanoContas;

implementation

{$R *.dfm}

uses     env, un_msg;

{ TRegPlanoContas }


procedure TRegPlanoContas.Cancel;
begin
  if (planoContas.Registro.Codigo > 0 ) then
  Begin
    ShowData;
  End;
  EditionState := 'B';
  EditionControl;
end;

procedure TRegPlanoContas.Change;
begin
  inherited;
  E_Codplc.SetFocus;
end;


procedure TRegPlanoContas.CriarVariaveis;
begin
  inherited;
  planoContas := TControllerPlanoContas.create(self);
end;

procedure TRegPlanoContas.Delete;
begin
  planoContas.deleteCascate;
  planoContas.clear;
  ShowNoData;
  E_BuscaDescricao.SetFocus;
  Pc_Filtrar;
end;

procedure TRegPlanoContas.EditionControl;
begin
  inherited;
  Trw_PlanoContas.ReadOnly  := ( EditionState = 'B' );
  Sb_Buscar.Enabled         := ( EditionState = 'B' );
  Sb_Filtrar.Enabled        := ( EditionState = 'B' );
  E_BuscaDescricao.ReadOnly := ( EditionState <> 'B' );
  Grp_busca.Enabled         := ( EditionState = 'B' );
end;

function TRegPlanoContas.existeRegistro: Boolean;
begin
  Result := True;
  if not planoContas.exist then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                   ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
  End;
end;

function TRegPlanoContas.Fc_NivelHierarquico(const fc_s: String): integer;
Var
  Lc_Teste : integer;
begin
  Lc_Teste :=Length( StringReplace( fc_s, '.', '', [rfReplaceAll]));
  // Descobre o nivel hierarquico atrav�s do número de pontos do igo
  Result := Length( fc_s )- Lc_Teste ;
end;

function TRegPlanoContas.Fc_NoPorNome(Fc_Tipo: byte; Fc_Tree: TTreeView;
  Fc_Value: String; Fc_Visible: Boolean): TTreeNode;
var
  Node: TTreeNode;
begin
  Result := nil;
  if Fc_Tree.Items.Count = 0 then Exit;
  Node := Fc_Tree.Items[0];
  while Node <> nil do
    begin
   if  Pos(UpperCase(Fc_Value), UpperCase(Node.Text)) > 0  then
      begin
      Result := Node;
      if Visible then Result.MakeVisible;
      if Fc_Tipo > 0 then  Break; //Para parar no primeiro que acha;
      end;
    Node := Node.GetNext;
    end;
end;

procedure TRegPlanoContas.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil( planoContas );
end;

procedure TRegPlanoContas.FormataTela;
begin
  inherited;

end;

procedure TRegPlanoContas.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(Sb_Buscar,'BUSCAR');
end;

procedure TRegPlanoContas.IniciaVariaveis;
begin
  inherited;
  Pc_Filtrar;
  EditionState := 'B';
  EditionControl;
end;

procedure TRegPlanoContas.Insert;
begin
  EditionState := 'I';
  EditionControl;
  ShowNoData;
  planoContas.clear;
  planoContas.Registro.PlanoContas := It_CtaSelecionada;
  E_Codplc.Text := It_CtaSelecionada;
  E_Codplc.SetFocus;
end;

procedure TRegPlanoContas.PC_Buscar;
var
  Sqltxt:string;
  LC_Classificacao,LC_Descricao: boolean;
begin
  sqltxt := '';
  with Qr_Pesquisa do
  Begin
    active := False;
    Sql.Clear;
    Sqltxt :=concat(
              'SELECT * ',
              'FROM TB_PLANOCONTAS ',
              'WHERE (PLC_CODIGO IS NOT NULL) ',
              ' AND (PLC_CODMHA =:PLC_CODMHA)'
              );

    if E_BuscaDescricao.Text='' then Lc_Descricao:=False else Lc_Descricao:=True;

    if LC_Classificacao then Sqltxt:=Sqltxt+' AND (PLC_CODPLANO =:PLC_CODPLANO) ';
    if LC_Descricao then Sqltxt:=Sqltxt+' AND (PLC_DESCRICAO LIKE :PLC_DESCRICAO) ';

    SQL.Add(sqltxt + ' ORDER BY PLC_CODPLANO ');

    if LC_Descricao then ParamByName('PLC_DESCRICAO').AsString := '%'+E_BuscaDescricao.Text+'%';
    ParamByName('PLC_CODMHA').AsInteger := Gb_Codmha;
    active := True;
  End;
end;

procedure TRegPlanoContas.Pc_Filtrar;
Var
  Lc_I: Integer;
begin
  with Qr_Pesquisa,Trw_PlanoContas do
  Begin
    Items.Count;
    Active := False;
    Active := True;
    FetchAll;
    if (recordCount > 0) then
    Begin
      For lc_I:= Items.Count-1 downto 0 do
        Items.Item[Lc_I].Delete;
      Pc_PreencherTreeView(Qr_Pesquisa,Trw_PlanoContas,nil);
      EditionControl;
    End;
  End;
end;

procedure TRegPlanoContas.Pc_PreencherTreeView(Pc_Query: TDataset;
  Pc_tv: TTreeView; Pc_Pai: TTreeNode);
var
  Lc_NivelAtual, Lc_NovoNivel, Lc_I : Byte;
  Lc_Descricao : ShortString;
  Lc_NovoNo : TTreeNode;
begin

  Lc_NivelAtual := Fc_NivelHierarquico( Pc_Query.Fields[0].AsString );

  repeat
  Lc_Descricao :=  Pc_Query.Fields[0].AsString + ' - ' + Pc_Query.Fields[4].AsString + ' - ' +Pc_Query.Fields[1].AsString;
  Lc_NovoNivel := Fc_NivelHierarquico( Pc_Query.Fields[0].AsString );

  if Lc_NovoNivel = Lc_NivelAtual then
    begin
    Lc_NovoNo := Pc_tv.Items.AddChild( Pc_Pai, lc_Descricao );
    Lc_NovoNo.ImageIndex := Lc_NivelAtual * 2;
    Lc_NovoNo.SelectedIndex := Lc_NivelAtual * 2;
    Lc_NovoNo.ImageIndex := Pc_Query.Fields[4].AsInteger;
    end
  else
    begin
    if ( Lc_NovoNivel < Lc_NivelAtual ) then
      begin
      for Lc_I := 1 to Lc_NivelAtual - Lc_NovoNivel do
      Pc_Pai := Pc_Pai.Parent
      end
    else
      begin
      Pc_Pai := Lc_NovoNo;
      end;
    Pc_PreencherTreeView( Pc_Query, Pc_tv, Pc_Pai );
    end;
  Pc_Query.Next;
  Application.ProcessMessages;
  until Pc_Query.EOF;
  It_Qtde_Items := Trw_PlanoContas.Items.Count
end;

procedure TRegPlanoContas.Save;

begin
  with planoContas do
  BEgin
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PLANOCONTAS');
    Registro.PlanoContas  := E_Codplc.Text;
    Registro.Descricao    := E_Descricao.Text;

    Registro.Estabelecimento := Gb_CodMha;
    if Rg_Nivel.ItemIndex = 0 then
      Registro.Nivel         := 'S'
    else
      Registro.Nivel         := 'A';

    if Rg_Natureza.ItemIndex = 0 then
      Registro.Natureza      := 'C'
    else
      Registro.Natureza     := 'D';

    if Rg_Tipo.ItemIndex = 0 then
      Registro.Tipo          := 'C'
    else
      Registro.Tipo          := 'R';
  End;
  planoContas.save;

end;

procedure TRegPlanoContas.Sb_BuscarClick(Sender: TObject);
begin
  Fc_NoPorNome(0,Trw_PlanoContas,E_BuscaDescricao.Text, TRUE)
end;

procedure TRegPlanoContas.SB_ExcluirClick(Sender: TObject);
begin
  if ValidateDelete then
  Begin
    Delete;
  End;
end;

procedure TRegPlanoContas.Sb_FiltrarClick(Sender: TObject);
begin
  Pc_Filtrar;
end;

procedure TRegPlanoContas.SB_gravarClick(Sender: TObject);
Var
  Lc_Descricao : String;
begin
  if ValidateSave then
  Begin
    Lc_Descricao  := E_Descricao.Text;
    Save;
    EditionState := 'B';
    EditionControl;
    Sb_FiltrarClick(Self);
    E_BuscaDescricao.SetFocus;
    Fc_NoPorNome(1,Trw_PlanoContas,Lc_Descricao, TRUE);
  End;

end;

procedure TRegPlanoContas.ShowData;
begin
  with planoContas do
  BEgin
    E_Codplc.Text := Registro.PlanoContas;
    E_Descricao.Text := Registro.Descricao;
    Rg_Nivel.ItemIndex := AnsiIndexStr(UpperCase(Registro.Nivel), ['S', 'A']);
    Rg_Natureza.ItemIndex := AnsiIndexStr(UpperCase(Registro.Natureza), ['C', 'D']);
    Rg_Tipo.ItemIndex := AnsiIndexStr(UpperCase(Registro.Nivel), ['C', 'R']);
  End;
end;

procedure TRegPlanoContas.ShowNoData;
begin
  E_Codplc.clear;
  E_Descricao.clear;
  Rg_Nivel.ItemIndex := 0;
  Rg_Natureza.ItemIndex := 0;
  Rg_Tipo.ItemIndex := 0;
end;

procedure TRegPlanoContas.Trw_PlanoContasClick(Sender: TObject);
begin
  It_CtaSelecionada := '';
  IF Trw_PlanoContas.Selected <> NIL then
  Begin
    planoContas.clear;
    planoContas.Registro.Codigo := Trw_PlanoContas.Selected.ImageIndex;
    if planoContas.Registro.Codigo >0 then
      planoContas.getById;
    if planoContas.exist then
    Begin
      It_CtaSelecionada := planoContas.Registro.PlanoContas;
      CodigoRegistro := planoContas.Registro.Codigo;
      ShowData;
    end
    else
    Begin
      ShowNoData;
    end;
    EditionState := 'B';
    EditionControl;
  END;
end;

function TRegPlanoContas.ValidaInsert: boolean;
begin
  Result := True;
end;


function TRegPlanoContas.ValidateChange: boolean;
begin
  REsult := True;
  if not existeRegistro then
  Begin
    Result := False;
    exit;
  End;
end;

function TRegPlanoContas.ValidateDelete: boolean;
begin
  REsult := True;
  if not existeRegistro then
  Begin
    Result := False;
    exit;
  End;

  if (not TMsgSetes.Excluir) then
  Begin
    Result := False;
    exit;
  End;

end;

function TRegPlanoContas.ValidateSave: boolean;
begin
  Result := True;
  if Length(Trim(E_Descricao.Text)) <=2 then
  begin
    MensagemPadrao('Plano de Contas',ATENCAO+EOLN+EOLN+
                   'A descrição deve ter no mínimo 3 caracteres.'+EOLN+
                   'Não foi possível gravar os dados .'+EOLN,
                  ['OK'],[bEscape],mpErro);
    E_Descricao.SetFocus;
    Result := False;
    exit;
  end;
  if (EditionState = 'I') then
  Begin
    planoContas.Registro.Estabelecimento := Gb_CodMha;
    planoContas.Registro.PlanoContas := E_Codplc.Text;
    planoContas.getByPlano;
    if (planoContas.exist) then
    begin
      MensagemPadrao('Plano de Contas',ATENCAO+EOLN+EOLN+
                     'Este Plano de Contas já foi registrado.'+EOLN+
                     'Verifique antes de continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      E_Codplc.SetFocus;
      Result := False;
      exit;
    end;
  End;

end;

end.
