unit cad_schedule;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, ControllerSchedule, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, QEdit_Setes, Un_Fm_ListaColaboradores, Un_Fm_ListaSituacao;

type
  TCadSchedule = class(TBaseRegistry)
    Label2: TLabel;
    Label3: TLabel;
    E_Data: TDateTimePicker;
    E_Duration: TMaskEdit;
    Label1: TLabel;
    Label20: TLabel;
    E_Phone: TEdit_Setes;
    E_Served: TEdit;
    Label4: TLabel;
    Fm_ListaAtendente: TFm_ListaColaboradores;
    Fm_ListaSituacao: TFm_ListaSituacao;
    E_Note: TMemo;
    Label5: TLabel;
    Cb_Hora: TComboBox;
  private

  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure ShowData;Override;
    procedure ShowNoData;Override;
    procedure ClearAllFields;Override;
    procedure EditionControl;Override;
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
    Agenda : TControllerSchedule;
  end;

var
  CadSchedule: TCadSchedule;

implementation

{$R *.dfm}

uses     UN_Principal, env, Un_sistema, Un_Funcoes, Un_Msg;

{ TBaseRegistry1 }

procedure TCadSchedule.Cancel;
begin
  inherited;

end;

procedure TCadSchedule.Change;
begin
  inherited;
  E_Data.SetFocus;
end;

procedure TCadSchedule.ClearAllFields;
begin
  inherited;

end;

procedure TCadSchedule.CriarVariaveis;
begin
  inherited;
  Agenda := TControllerSchedule.Create(Self);
  Fm_ListaAtendente.ListaColaborador;
  Fm_ListaSituacao.Modulo := 6;
  Fm_ListaSituacao.Listar;
end;

procedure TCadSchedule.Delete;
begin
  Agenda.delete;
  close;
end;

procedure TCadSchedule.EditionControl;
begin
  Pf_Inserir := True;
  Pf_Alterar := True;
  Pf_Excluir := True;
  inherited;
  pnl_fundo.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );

end;

procedure TCadSchedule.IniciaVariaveis;
begin
  inherited;
  if CodigoRegistro > 0 then
  Begin
    Agenda.Registro.Codigo := CodigoRegistro;
    Agenda.Registro.Estabelecimento := Gb_codmha;
    Agenda.getbyId;
  End;
  inherited;
end;

procedure TCadSchedule.Insert;
begin
  inherited;
  ClearAllFields;
  Agenda.clear;
  ShowNoData;
  E_Data.SetFocus;
end;

procedure TCadSchedule.Save;
begin
  inherited;
  with Agenda do
  Begin
    Registro. Data             := E_Data.DateTime;
    Registro.Estabelecimento  := Gb_CodMha;
    Registro.Hora             := Cb_Hora.Text;
    Registro.Duracao          := E_Duration.Text;
    Registro.Atendido         := E_Served.Text;
    Registro.Fone             := Fc_RemoveCaracterInformado(E_Phone.Text, ['(',')','-','-',' ']);
    Registro.Atendente        := Fm_ListaAtendente.Dblcb_Vendedor.KeyValue;
    if Fm_ListaSituacao.DBLCB_Situacao.Text <> '' then
      Registro.Situacao   := Fm_ListaSituacao.DBLCB_Situacao.KeyValue
    else
      Registro.Situacao   := 0;
    registro.Obervacao  := E_Note.Text;
  End;
  Agenda.salva;
  CodigoRegistro := Agenda.Registro.Codigo;
  EditionState := 'B';
  EditionControl;
end;



procedure TCadSchedule.ShowData;
Var
  I:Integer;
begin
  inherited;
  with Agenda do
  Begin
    E_Data.DateTime := Registro.Data;
    for I := 0 to Cb_Hora.Items.Count -1 do
    Begin
      if Cb_Hora.Items[I] = registro.Hora then
        Cb_Hora.ItemIndex := I;
    End;
    E_Duration.Text := Registro.Duracao;
    E_Served.Text   := Registro.Atendido;
    E_Phone.Text    := fc_MascaraFone( Registro.Fone );
    Fm_ListaAtendente.Dblcb_Vendedor.KeyValue := Registro.Atendente;
    Fm_ListaSituacao.DBLCB_Situacao.KeyValue  := Registro.Situacao;
    E_Note.Text     := registro.Obervacao;
  End;

end;

procedure TCadSchedule.ShowNoData;
begin
  inherited;
  E_Data.DateTime   := Date;
  Cb_Hora.ItemIndex := 0;
  E_Served.Clear;
  E_Phone.Clear;
  Fm_ListaAtendente.Dblcb_Vendedor.KeyValue := 0;
  Fm_ListaSituacao.DBLCB_Situacao.KeyValue := 0;
  E_Note.Clear;
end;

function TCadSchedule.ValidaInsert: boolean;
begin
  Result := TRue;
end;

function TCadSchedule.ValidateCancel: boolean;
begin
  REsult := True;
end;

function TCadSchedule.ValidateChange: boolean;
begin
  Result := True;
end;

function TCadSchedule.ValidateDelete: boolean;
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

function TCadSchedule.ValidateSave: boolean;
begin
  Result := True;
  Agenda.Registro.Estabelecimento := Gb_CodMha;
  Agenda.Registro.Data  := E_Data.DateTime;
  Agenda.Registro.Hora  := Cb_Hora.Text;
  Agenda.Registro.Atendente := Fm_ListaAtendente.Dblcb_Vendedor.KeyValue;
  if not Agenda.ValidaInclusao then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Horário para este atendente já agendado.' + EOLN +
                   'Escolha outro horário ou outro atendente.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
  end;

  //valida se o telfone do Cliente foi Preenchido
  if (Trim(E_Served.Text) = '') then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Campo nome do cliente não informado.' + EOLN +
                   'Preencha para continuar' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
  end;

  if (Trim(E_Phone.Text) = '') then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Campo telefone não informado.' + EOLN +
                   'Preencha para continuar' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
  end;

  if (Fm_ListaAtendente.Dblcb_Vendedor.Text = '') then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Campo atendente não informado.' + EOLN +
                   'Preencha para continuar' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
  end;
end;

end.
