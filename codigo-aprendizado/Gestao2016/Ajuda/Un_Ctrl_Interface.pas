unit Un_Ctrl_Interface;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, DBCtrls, StdCtrls, Grids, DBGrids, Mask, Buttons, ComCtrls, DB, STQuery, IBUpdateSQL, CheckLst, ControllerGeral, QEdit_Setes;

type


  TFr_Ctrl_Interface = class(TForm)
    Qr_Modulo: TSTQuery;
    Ds_Modulo: TDataSource;
    Qr_Menus: TSTQuery;
    Ds_Menus: TDataSource;
    Qr_Interface: TSTQuery;
    Ds_ItemMenu: TDataSource;
    Qr_Atualiza: TSTQuery;
    Pnl_botao: TPanel;
    SB_Aplicar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Panel1: TPanel;
    PG_Informacoes: TPageControl;
    Pn_Modulos: TPanel;
    Panel2: TPanel;
    Dbg_modulo: TDBGrid;
    Panel3: TPanel;
    Panel4: TPanel;
    Dbg_Menus: TDBGrid;
    Panel5: TPanel;
    Panel6: TPanel;
    Chlb_Interface: TCheckListBox;
    SB_Add_Tudo: TSpeedButton;
    SB_Retirar_Tudo: TSpeedButton;
    lb_qtd_itens: TLabel;
    E_Cd_Cliente_setes: TEdit_Setes;
    Sb_Cd_Cliente: TSpeedButton;
    Label1: TLabel;
    E_Cd_Projeto_setes: TEdit_Setes;
    SpeedButton1: TSpeedButton;
    Qr_acao: TSTQuery;
    procedure Dbg_MenusCellClick(Column: TColumn);
    procedure SB_AplicarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_Add_TudoClick(Sender: TObject);
    procedure SB_Retirar_TudoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Dbg_moduloCellClick(Column: TColumn);
    procedure E_Cd_Cliente_setesChange(Sender: TObject);
    procedure Sb_Cd_ClienteClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Lista :Array of Array of Integer;
    procedure Pc_Formatatela;
    procedure Pc_AtivarTabelas;
    procedure Pc_Abre_Menu(Pc_Cd_Modulo:Integer);
    procedure Pc_Abre_Interface(Pc_Cd_Menu:Integer);
    procedure Pc_AtualizaInterface;
    procedure Pc_AtualizaNoClique;
    Function  fc_validaGravacao:boolean;
    procedure Pc_MudaSqlAtualiza(Pc_tipo:String);
    procedure Pc_InsereInterface;
    procedure Pc_ImagemBotao;
  end;

var
  Fr_Ctrl_Interface: TFr_Ctrl_Interface;
  ControllerGeral : TControllerGeral;
implementation

uses     Un_DM, UN_MSG, UN_Sistema, UN_Principal, env;
{$R *.dfm}

procedure TFr_Ctrl_Interface.Pc_Formatatela;
Begin

end;

procedure TFr_Ctrl_Interface.Pc_AtivarTabelas;
Begin
  Qr_Modulo.Active := True;
end;

procedure TFr_Ctrl_Interface.Pc_MudaSqlAtualiza(Pc_tipo:String);
Var
  Lc_SqlTxt : String;
Begin
  Qr_Atualiza.Active := false;
  Qr_Atualiza.SQL.Clear;
  if (Pc_tipo = 'I') then
    Begin
    Lc_SqlTxt := 'INSERT INTO TB_INTERFACE (IFC_CODIGO, IFC_DESCRICAO, IFC_FR_NAME, IFC_CODMNU, IFC_SISTEMA) '+
                 '                  VALUES (:IFC_CODIGO, :IFC_DESCRICAO, :IFC_FR_NAME, :IFC_CODMNU, :IFC_SISTEMA) ';
    end
  else
    Begin
    Lc_SqlTxt := 'UPDATE TB_INTERFACE SET   '+
                 ' IFC_SISTEMA =:IFC_SISTEMA    '+
                 'WHERE                     '+
                 ' IFC_CODIGO =:IFC_CODIGO  ';
    end;
  Qr_Atualiza.SQL.Add(Lc_SqlTxt);

end;

procedure TFr_Ctrl_Interface.Pc_AtualizaInterface;
Var
  lc_I:Integer;
begin
  for Lc_I:=0 to Chlb_Interface.Items.Count -1 do
    Begin
    if (It_lista[0,Lc_I] > 0) then
      Pc_MudaSqlAtualiza('U')
    else
      Pc_MudaSqlAtualiza('I');
    Qr_Atualiza.Active := False;
    Qr_Atualiza.ParamByName('IFC_CODIGO').AsInteger :=  It_lista[0,Lc_I];
    if Chlb_Interface.Checked[LC_I] then
      Qr_Atualiza.ParamByName('IFC_SISTEMA').AsString := 'S'
    else
      Qr_Atualiza.ParamByName('IFC_SISTEMA').AsString := 'N';
    Qr_Atualiza.ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN Dm.IB_Transacao.CommitRetaining;
    end;
end;

procedure TFr_Ctrl_Interface.Pc_AtualizaNoClique;
Var
  Lc_Ativo : String;
Begin
  if not fc_validaGravacao then exit;
  if Chlb_Interface.Checked[Chlb_Interface.ItemIndex] then
    Lc_Ativo := 'S'
  else
    Lc_Ativo := 'N';
  //Atualiza Local

  if (It_lista[0,Chlb_Interface.ItemIndex] > 0) then
    Pc_MudaSqlAtualiza('U')
  else
    Pc_MudaSqlAtualiza('I');
  Qr_Atualiza.Active := False;
  Qr_Atualiza.ParamByName('IFC_CODIGO').AsInteger := It_lista[0,Chlb_Interface.ItemIndex];
  Qr_Atualiza.ParamByName('IFC_SISTEMA').AsString := Lc_Ativo;
  Qr_Atualiza.ExecSQL;
  Dm.IB_Transacao.CommitRetaining;

end;

procedure TFr_Ctrl_Interface.Pc_InsereInterface;
Begin
  if not fc_validaGravacao then exit;
  Pc_MudaSqlAtualiza('I');

    Qr_Acao.Active := False;
    Qr_Acao.SQL.Clear;
    Qr_Acao.SQL.Add('SELECT IFC_CODIGO               '+
                    'FROM TB_INTERFACE tb_interface  ');
    Qr_Acao.Active := True;
    Qr_Acao.FetchAll;
    Qr_Acao.First;
    while not Qr_Acao.Eof do
      Begin
      Qr_Atualiza.Active := False;
      Qr_Atualiza.ParamByName('IFC_CODIGO').AsInteger :=  Qr_Acao.FieldByname('IFC_CODIGO').AsInteger;
      Qr_Atualiza.ParamByName('IFC_SISTEMA').AsString := 'N';
      Qr_Atualiza.ExecSQL;
      IF DM.IB_Transacao.InTransaction THEN Dm.IB_Transacao.CommitRetaining;
      Qr_Acao.Next;
      end;

end;

procedure TFr_Ctrl_Interface.Pc_Abre_Menu(Pc_Cd_Modulo:Integer);
Begin
  With qr_Menus do
  Begin
    Active := False;
    ParamByName('MOD_CODIGO').AsInteger := Pc_Cd_Modulo;
    Active := True;
  End;
End;

procedure TFr_Ctrl_Interface.Pc_Abre_Interface(Pc_Cd_Menu:Integer);
var
  Lc_I : Integer;
Begin
  Qr_Interface.Active := False;
  Qr_Interface.ParamByName('MNU_CODIGO').AsInteger := Pc_Cd_Menu;
  Qr_Interface.Active := True;
  Qr_Interface.FetchAll;
  if Qr_Interface.RecordCount = 0 then exit;
  Qr_Interface.First;
  Chlb_Interface.Clear;
  if (Qr_Interface.RecordCount = 0) then
    Begin
    Pc_InsereInterface;
    Qr_Interface.Active := False;
    Qr_Interface.ParamByName('MNU_CODIGO').AsInteger := Pc_Cd_Menu;
    Qr_Interface.Active := True;
    Qr_Interface.FetchAll;
    Qr_Interface.First;
    if Qr_Interface.RecordCount = 0 then Exit;
    Pc_Abre_Interface(Pc_Cd_Menu);
    end;
  SetLength(It_Lista,1,Qr_Interface.RecordCount);
  Lc_I := 0;
  while not Qr_Interface.Eof do
    Begin
    Chlb_Interface.Items.Add(Qr_Interface.FieldByName('IFC_DESCRICAO').AsString);
    Chlb_Interface.ItemIndex := Lc_I;
    Chlb_Interface.Checked[Lc_I] := (Qr_Interface.FieldByName('IFC_SISTEMA').AsString = 'S');
    It_Lista[0,Lc_I] := Qr_Interface.FieldByName('IFC_CODIGO').AsInteger;
    Inc(Lc_I);
    Qr_Interface.Next;
    end;
  SB_Add_Tudo.Enabled := true;
  SB_Retirar_Tudo.Enabled := true;
  Chlb_Interface.Selected[0] := true;
end;

procedure TFr_Ctrl_Interface.Dbg_MenusCellClick(Column: TColumn);
begin
  Pc_Abre_Interface(Qr_Menus.FieldByName('MNU_CODIGO').AsInteger);
end;

Function  TFr_Ctrl_Interface.fc_validaGravacao:boolean;
Begin
  Result := true;
end;

procedure TFr_Ctrl_Interface.SB_AplicarClick(Sender: TObject);
begin
  If not fc_validaGravacao then exit;
  Pc_AtualizaInterface;
  Pc_Abre_Interface(Qr_Menus.FieldByName('MNU_CODIGO').AsInteger);

  SB_Aplicar.Enabled := false;
end;

procedure TFr_Ctrl_Interface.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Ctrl_Interface.FormCreate(Sender: TObject);
begin
  ControllerGeral := tControllerGeral.Create(Self);
end;

procedure TFr_Ctrl_Interface.SB_Add_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For LC_I := 0 to Chlb_Interface.Items.Count -1 do
    Begin
    Chlb_Interface.Checked[Lc_I] := True;
    end;
  SB_Aplicar.Enabled := true;
end;

procedure TFr_Ctrl_Interface.SB_Retirar_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For LC_I := 0 to Chlb_Interface.Items.Count - 1  do
    Begin
    Chlb_Interface.Checked[Lc_I] := False;
    end;
  SB_Aplicar.Enabled := true;
end;

procedure TFr_Ctrl_Interface.FormShow(Sender: TObject);
begin
  Pc_AtivarTabelas;
  Pc_Formatatela;
  Pc_ImagemBotao;
  ControllerGeral.Registro.Campo := 'CD_CLIENTE_SETES';
  ControllerGeral.getById;
  E_Cd_Cliente_setes.Text := ControllerGeral.Registro.Conteudo;
  ControllerGeral.Registro.Campo :='CD_PROJETO_SETES';
  ControllerGeral.getById;
  E_Cd_Projeto_setes.Text := ControllerGeral.Registro.Conteudo;

end;


procedure TFr_Ctrl_Interface.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Aplicar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Ctrl_Interface.Dbg_moduloCellClick(Column: TColumn);
begin
  Pc_Abre_Menu(Qr_Modulo.FieldByName('Mod_CODIGO').AsInteger);
end;

procedure TFr_Ctrl_Interface.E_Cd_Cliente_setesChange(Sender: TObject);
begin
  SB_Aplicar.Enabled := True;
end;

procedure TFr_Ctrl_Interface.Sb_Cd_ClienteClick(Sender: TObject);
begin
  if Trim(E_Cd_Cliente_setes.Text)<> '' then
  Begin
    with ControllerGeral.Registro do
    Begin
      Campo := 'CD_CLIENTE_SETES';
      Conteudo := E_Cd_Cliente_setes.Text;
      CodigoEstabelecimento := 0;
    End;
    ControllerGeral.salva;
    MensagemPadrao(' Mensagem', 'S U C E S S O!.' + EOLN+EOLN+
                   ' Código atualizado com Sucesso.'+EOLN+EOLN,
                   [' OK'],[bEscape],mpInformacao);
  end;
end;

procedure TFr_Ctrl_Interface.SpeedButton1Click(Sender: TObject);
begin
  if Trim(E_Cd_Projeto_setes.Text)<> '' then
  Begin
    with ControllerGeral.Registro do
    Begin
      Campo := 'CD_PROJETO_SETES';
      Conteudo := E_Cd_Projeto_setes.Text;
      CodigoEstabelecimento := 0;
    End;
    ControllerGeral.salva;
    MensagemPadrao(' Mensagem', 'S U C E S S O!.' + EOLN+EOLN+
                   ' Código atualizado com Sucesso.'+EOLN+EOLN,
                   [' OK'],[bEscape],mpInformacao);
    end;
end;

end.
