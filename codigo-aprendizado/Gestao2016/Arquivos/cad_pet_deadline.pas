unit cad_pet_deadline;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Datasnap.Provider, ControllerPetDeadLine;

type
  TCadPetDeadline = class(TBaseRegistry)
    Label1: TLabel;
    E_Description: TEdit;
    Label5: TLabel;
    E_Dt_Inicial: TDateTimePicker;
    Label2: TLabel;
    E_Dt_final: TDateTimePicker;
    Cds_procedures: TClientDataSet;
    Ds_procedures: TDataSource;
    Cds_proceduresID: TIntegerField;
    Cds_proceduresTB_PET_ID: TIntegerField;
    Cds_proceduresDESCRIPTION: TWideStringField;
    Cds_proceduresINITIAL_DATE: TDateField;
    Cds_proceduresFINAL_DATE: TDateField;
    Dbg_ListAnnotation: TDBGrid;
    procedure Dbg_ListAnnotationDblClick(Sender: TObject);
  private
    procedure LimpaCampos;
    procedure ShowDataAlera;
  protected
    procedure CriarVariaveis;Override;
    procedure ShowData;Override;
    procedure IniciaVariaveis;Override;

    procedure Insert;Override;

    function ValidateChange:Boolean;Override;
    procedure Change;Override;

    function ValidateDelete():boolean;Override;
    procedure Delete;Override;

    function ValidateSave:Boolean;Override;
    procedure Save;Override;

    function ValidateCancel:Boolean;Override;
    procedure Cancel;Override;

  public
    { Public declarations }
    DeadLine : TControllerPetDeadLine;
  end;

var
  CadPetDeadline: TCadPetDeadline;

implementation

{$R *.dfm}

uses     Un_Msg, env;

{ TCadPetDeadline }

procedure TCadPetDeadline.Cancel;
begin
  inherited;
  LimpaCampos;
end;

procedure TCadPetDeadline.Change;
begin
  inherited;
  E_Description.SetFocus;
end;

procedure TCadPetDeadline.CriarVariaveis;
begin
  inherited;
  DeadLine := TControllerPetDeadLine.Create(Self);
end;

procedure TCadPetDeadline.Dbg_ListAnnotationDblClick(Sender: TObject);
begin
  ShowDataAlera;
end;

procedure TCadPetDeadline.Delete;
begin
  inherited;
  DeadLine.Registro.Codigo := Cds_proceduresID.AsInteger;
  DeadLine.delete;
  Cds_procedures.Delete;
end;

procedure TCadPetDeadline.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    DeadLine.Registro.pet := CodigoRegistro;
    DeadLine.getList;
  End;
  inherited;
end;

procedure TCadPetDeadline.Insert;
begin
  inherited;
  LimpaCampos;
  E_Description.SetFocus;
end;

procedure TCadPetDeadline.LimpaCampos;
begin
  DeadLine.clear;
  E_Description.Clear;
  E_Dt_Inicial.Date := Date;
  E_Dt_final.Date := Date + 360;
end;

procedure TCadPetDeadline.Save;
begin
  //salva dados no Banco
  DeadLine.Registro.Pet         := CodigoRegistro;
  DeadLine.Registro.Descricao   := E_Description.Text;
  DeadLine.Registro.DataInicial := E_Dt_Inicial.DateTime;
  DeadLine.Registro.DataFinal   := E_Dt_Inicial.DateTime;
  if (DeadLine.Registro.Codigo > 0) then
  Begin
    DeadLine.update;
    Cds_procedures.Edit;
  End
  else
  Begin
    DeadLine.Registro.Codigo := 0;
    DeadLine.insert;
    Cds_procedures.Append;
  End;
  Cds_proceduresID.AsInteger            := DeadLine.Registro.Codigo;
  Cds_proceduresTB_PET_ID.AsInteger     := DeadLine.Registro.Pet;
  Cds_proceduresDESCRIPTION.AsString    := DeadLine.Registro.Descricao;
  Cds_proceduresINITIAL_DATE.AsDateTime := DeadLine.Registro.DataInicial;
  Cds_proceduresFINAL_DATE.AsDateTime   := DeadLine.Registro.DataFinal;
  Cds_procedures.Post;

end;

procedure TCadPetDeadline.ShowData;
Var
  I : Integer;
begin
  if not Cds_procedures.Active then Cds_procedures.CreateDataSet;
  Cds_procedures.EmptyDataSet;
  for I := 0 to DeadLine.Lista.Count-1 do
  Begin
    Cds_procedures.Append;
    Cds_proceduresID.AsInteger            := DeadLine.Lista[I].Codigo;
    Cds_proceduresTB_PET_ID.AsInteger     := DeadLine.Lista[I].Pet;
    Cds_proceduresDESCRIPTION.AsString    := DeadLine.Lista[I].Descricao;
    Cds_proceduresINITIAL_DATE.AsDateTime := DeadLine.Lista[I].DataInicial;
    Cds_proceduresFINAL_DATE.AsDateTime   := DeadLine.Lista[I].DataFinal;
    Cds_procedures.Post;
  End;
end;

procedure TCadPetDeadline.ShowDataAlera;
begin
  if Cds_procedures.Active then
  Begin
    if Cds_proceduresID.AsInteger > 0 then
    Begin
      DeadLine.Registro.Codigo := Cds_proceduresID.AsInteger;
      DeadLine.getbyId;
      E_Description.Text := DeadLine.Registro.Descricao;
      E_Dt_Inicial.DateTime := DeadLine.Registro.DataInicial;
      E_Dt_final.DateTime := DeadLine.Registro.DataInicial
    End;
  End;
end;

function TCadPetDeadline.ValidateCancel: Boolean;
begin
  Result := TRue;
end;

function TCadPetDeadline.ValidateChange: Boolean;
begin
  Result := True;
end;

function TCadPetDeadline.ValidateDelete: boolean;
begin
  Result := True;
  //quando a pergunta esta dentro da validação verifica-se o botão da negativa
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja delete este item?'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                      [NAO, SIM],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;

end;

function TCadPetDeadline.ValidateSave: Boolean;
begin
  REsult := True;
  if Trim( E_Description.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Descrição do procedimento  não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if E_Description.CanFocus then E_Description.SetFocus;
    Exit;
  end;

end;

end.
