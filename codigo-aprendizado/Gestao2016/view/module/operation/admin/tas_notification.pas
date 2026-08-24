unit tas_notification;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerNotification, Vcl.CategoryButtons, Vcl.Buttons, CustomCaptionPanel, tas_notification_item;

type
  TTasNotification = class(TForm)
    Rg_Status: TRadioGroup;
    Scx_Lista: TScrollBox;
    Tm_Search: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Rg_StatusClick(Sender: TObject);
    procedure Tm_SearchTimer(Sender: TObject);
  private
    FNotificacao : TControllerNotification;
    FLastDateTime : TDateTime;

    procedure CriarVariaveis;
    procedure IniciaVariaveis;
    procedure FinalizaVariaveis;
    procedure Search;
    procedure SearchTimer;
    procedure MontaLista;
    procedure LimpaLista;
    procedure ChangeStatusLida(Sender: TObject);
    procedure ChangeStatusNaoLida(Sender: TObject);
    procedure CriarNotificationItem;
  public
    { Public declarations }

  end;

var
  TasNotification: TTasNotification;
  TasNotificationItem: TTasNotificationItem;

implementation

{$R *.dfm}

uses     env;

{ TTasNotification }

procedure TTasNotification.ChangeStatusLida(Sender: TObject);
begin
  FNotificacao.Registro.Estabelecimento := Gb_CodMha;
  FNotificacao.Registro.Codigo := TSpeedButton(Sender).Tag;
  FNotificacao.Registro.Ativo := 'N';
  FNotificacao.changeStatus;
  //Efetua a Busca
  Search;
end;

procedure TTasNotification.ChangeStatusNaoLida(Sender: TObject);
begin
  FNotificacao.Registro.Estabelecimento := Gb_CodMha;
  FNotificacao.Registro.Codigo := TSpeedButton(Sender).Tag;
  FNotificacao.Registro.Ativo := 'S';
  FNotificacao.changeStatus;
  //Efetua a Busca
  Search;
end;

procedure TTasNotification.CriarNotificationItem;
begin
  TasNotificationItem := TTasNotificationItem.Create(Self);
  TasNotificationItem.Name := 'TasItem' + FNotificacao.Registro.Codigo.ToString;
  TasNotificationItem.Parent := Scx_Lista;
  TasNotificationItem.Align := alBottom;
  TasNotificationItem.Lb_Tittle.Caption := FNotificacao.Registro.Categoria;
  TasNotificationItem.Lb_Message.Caption := FNotificacao.Registro.Observacao;
  TasNotificationItem.Sb_ChangeStatus.Tag := FNotificacao.Registro.Codigo;

  if (FNotificacao.Registro.Ativo = 'S' ) then
  Begin
    TasNotificationItem.Sb_ChangeStatus.OnClick := ChangeStatusLida;
    TasNotificationItem.Sb_ChangeStatus.Caption := 'Marcar como Lida'
  End
  else
  Begin
    TasNotificationItem.Sb_ChangeStatus.OnClick := ChangeStatusNaoLida;
    TasNotificationItem.Sb_ChangeStatus.Caption := 'Marcar como NÂO Lida'
  End;

  TasNotificationItem.Align := alTop;
end;

procedure TTasNotification.CriarVariaveis;
begin
  FNotificacao := TControllerNotification.create(self);
end;

procedure TTasNotification.FinalizaVariaveis;
begin
  FreeAndNil(FNotificacao);
end;

procedure TTasNotification.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FinalizaVariaveis;
end;

procedure TTasNotification.FormCreate(Sender: TObject);
begin
  CriarVariaveis;
end;

procedure TTasNotification.FormShow(Sender: TObject);
begin
  IniciaVariaveis;
end;

procedure TTasNotification.IniciaVariaveis;
begin
  LimpaLista;
  FNotificacao.Parametros.FieldName.Ativo := 'S';
  FNotificacao.Parametros.FieldName.createdAt := 0;
  FNotificacao.Parametros.Estabelecimento := Gb_CodMha;
  FNotificacao.Parametros.FieldName.createdAt := Now - 15;
  FNotificacao.Search;
  MontaLista;
  Tm_Search.Enabled := True;
end;

procedure TTasNotification.LimpaLista;
var
  I: Integer;
  variavel: TComponent;
begin
  for I := (Self.ComponentCount-1) downto 0 do
  begin
    if ( Components[I].ClassName = 'TTasNotificationItem') then
    Begin
      variavel := Components[I] ;
      FreeAndNil( variavel );
    End;
  end;
end;

procedure TTasNotification.MontaLista;
Var
  I : Integer;
begin
  Scx_Lista.Visible := False;
  Try
    for I := 0 to FNotificacao.Lista.Count -1 do
    Begin
      FNotificacao.ClonarObj(FNotificacao.Lista[I],FNotificacao.Registro);
      CriarNotificationItem;
    End;
  Finally
    Scx_Lista.Visible := True;
  End;
end;

procedure TTasNotification.Rg_StatusClick(Sender: TObject);
begin
  Search;
end;

procedure TTasNotification.Search;
begin
  LimpaLista;
  FNotificacao.Parametros.Clear;
  case Rg_Status.ItemIndex of
    0:FNotificacao.Parametros.FieldName.Ativo := 'N';
    1:FNotificacao.Parametros.FieldName.Ativo := 'S';
  end;
  FNotificacao.Parametros.Estabelecimento := Gb_CodMha;
  FNotificacao.Parametros.FieldName.createdAt := Now - 15;
  FNotificacao.Search;
  MontaLista;
end;

procedure TTasNotification.SearchTimer;
begin
  Tm_Search.Enabled := False;
  Rg_Status.ItemIndex := 1;
  Search;
  Tm_Search.Enabled := True;
end;

procedure TTasNotification.Tm_SearchTimer(Sender: TObject);
begin
  SearchTimer
end;

end.
