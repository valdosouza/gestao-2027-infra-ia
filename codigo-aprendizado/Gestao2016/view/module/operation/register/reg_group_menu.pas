unit reg_group_menu;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Buttons, System.StrUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, reg_group, ControllerGrupos, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids;

type
  TRegGroupMenu = class(TRegGroup)
    Lb_Desconto: TLabel;
    Lb_Sequencia: TLabel;
    DBRG_Tamanhos: TRadioGroup;
    DBRG_Interface: TRadioGroup;
    DBRG_Composicao: TRadioGroup;
    Chbx_Ifood: TCheckBox;
    ChBx_Propag_Tamanho: TCheckBox;
    ChBx_Agrupar_Abas: TCheckBox;
    ChBx_show_menu: TCheckBox;
    E_Vl_Desconto: TEdit;
    E_Sequencia: TEdit;
    procedure DBRG_ComposicaoClick(Sender: TObject);
    procedure Sb_SubGruposClick(Sender: TObject);
  private
    procedure AtivarDesativarProdutos;

  protected
    procedure ClearAllFields; Override;
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure ShowData; Override;
    procedure ShowNoData; Override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;
  public
  end;

var
  RegGroupMenu: TRegGroupMenu;

implementation

uses     UN_MSG, reg_subgroup_menu, env;

{$R *.dfm}

procedure TRegGroupMenu.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegGroupMenu.ClearAllFields;
begin
  inherited;
  grupos.clear;
end;

procedure TRegGroupMenu.CriarVariaveis;
begin
  inherited;

end;

procedure TRegGroupMenu.DBRG_ComposicaoClick(Sender: TObject);
begin
  inherited;
  if DBRG_Composicao.ItemIndex = 1 then
  Begin
    DBRG_Interface.ItemIndex := 0;
    DBRG_Interface.Enabled := False;
  end
  else
  Begin
    DBRG_Interface.Enabled := True;
  end;
end;

procedure TRegGroupMenu.Delete;
begin
  grupos.delete;
  inherited;
end;

procedure TRegGroupMenu.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(grupos);
end;

procedure TRegGroupMenu.IniciaVariaveis;
begin
  MontarGrid(Self.CodigoRegistro);
  if Self.CodigoRegistro > 0 then
  Begin
    grupos.Registro.Codigo := Self.CodigoRegistro;
    grupos.getbyId;
  End;
  inherited;
end;

procedure TRegGroupMenu.Insert;
begin
  inherited;
end;

procedure TRegGroupMenu.Save;
begin
  with grupos do
  Begin
    Registro.Descricao          := E_Descricao.Text;
    Registro.ValorDesconto      := StrToFloatDef(E_Vl_Desconto.Text, 0);
    Registro.Composicao         := IntToStr(DBRG_Composicao.ItemIndex + 1);
    Registro.ControleInterface  := IntToStr(DBRG_Interface.ItemIndex + 1);
    Registro.Tamanhos           := IfThen(DBRG_Tamanhos.ItemIndex =  0, SIGLA_S, SIGLA_N);
    Registro.IfoodAtivo         := IfThen(Chbx_Ifood.Checked, SIGLA_S, SIGLA_N);
    Registro.PropagaTamanho     := IfThen(ChBx_Propag_Tamanho.Checked, SIGLA_S, SIGLA_N);
    Registro.Agrupar            := IfThen(ChBx_Agrupar_Abas.Checked, SIGLA_S, SIGLA_N);
    Registro.ShowMenu           := IfThen(ChBx_show_menu.Checked, SIGLA_S, SIGLA_N);
    Registro.Ativo              := IfThen(ChBx_Ativo.Checked, SIGLA_S, SIGLA_N);
    salva;
  End;
  AtivarDesativarProdutos;
  CodigoRegistro := grupos.Registro.Codigo;
  inherited;
end;

procedure TRegGroupMenu.Sb_SubGruposClick(Sender: TObject);
var
  Lc_form : TRegSubgroupMenu;
begin
  Lc_form := TRegSubgroupMenu.Create(self);
  Try
    Lc_form.CodigoGrupo     := Grupos.Registro.Codigo;
    Lc_form.CodigoRegistro  := cds_subgrupocodigo.AsInteger;
    Lc_form.ShowModal;
    MontarGrid(self.CodigoRegistro);
  Finally
    FreeAndNil(Lc_form);
  End;
end;


procedure TRegGroupMenu.ShowData;
begin
  with grupos do
  Begin
    E_Descricao.Text  := Registro.Descricao;
    E_Vl_Desconto.Text := FloatToStrF(Registro.ValorDesconto, ffFixed, 10, 2);

    if Registro.Composicao <> EmptyStr then
      DBRG_Composicao.ItemIndex := StrToInt(Registro.Composicao)-1;

    if Registro.ControleInterface <> EmptyStr then
      DBRG_Interface.ItemIndex := StrToInt(Registro.ControleInterface) -1;

    if Registro.Tamanhos = SIGLA_S then
      DBRG_Tamanhos.ItemIndex := 0
    else
      DBRG_Tamanhos.ItemIndex := 1;

    if Registro.IfoodAtivo = SIGLA_S then
      Chbx_Ifood.Checked := True
    else
      Chbx_Ifood.Checked := False;

    if Registro.PropagaTamanho = SIGLA_S then
      ChBx_Propag_Tamanho.Checked := True
    else
      ChBx_Propag_Tamanho.Checked := False;

    if Registro.Agrupar = SIGLA_S then
      ChBx_Agrupar_Abas.Checked := True
    else
      ChBx_Agrupar_Abas.Checked := False;

    if Registro.ShowMenu = SIGLA_S then
      ChBx_show_menu.Checked := True
    else
      ChBx_show_menu.Checked := False;

    if Registro.Ativo = SIGLA_S then
      ChBx_Ativo.Checked := True
    else
      ChBx_Ativo.Checked := False;
  End;
  inherited;
end;

procedure TRegGroupMenu.ShowNoData;
begin
  E_Descricao.clear;
end;

function TRegGroupMenu.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegGroupMenu.ValidateSave: boolean;
Var
  Lc_Cd_Grupo : Integer;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(Lb_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;

  //Verifica se um grupo com a mesma descrição existe
  Lc_Cd_Grupo := grupos.Fc_GrupoExiste(grupos.Registro.Codigo, E_Descricao.Text,true);

  if (Lc_Cd_Grupo > 0) then
  Begin
    if (MensagemPadrao('Mensagem de Confirmção',
                       'J� existe um grupo com esta descrição.' + EOLN + EOLN +
                       'Deseja visualizar este registro ?',
                       ['Sim', 'N�o'], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao1) then
    Begin
      grupos.Registro.Codigo := Lc_Cd_Grupo;
      grupos.getbyId;
      ShowData;
      Result:=false;
      exit;
    end
    else
    Begin
      MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Altere a descrição para continuar.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
      Result:=false;
      exit;
    end;
  end;
end;

procedure TRegGroupMenu.AtivarDesativarProdutos;
begin
  grupos.AtivarDesativarProdutos( grupos.Registro.Codigo, grupos.Registro.Ativo = SIGLA_S);
end;

end.
