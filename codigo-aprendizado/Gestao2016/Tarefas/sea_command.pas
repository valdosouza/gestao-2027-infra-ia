unit sea_command;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_base_Pesq, Data.DB, STQuery, Vcl.Menus, Vcl.Grids, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerCommand, ControllerPedido, ControllerCheckOutItems, tblCheckOutItems;

type
  TSeaCommand = class(TFr_Base_Pesq)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    e_Numero_Comanda: TEdit;
    E_Nome_Cliente: TEdit;
    E_Numero_Telefone: TEdit;
    Qr_PesquisaDT_RECORD: TSQLTimeStampField;
    Qr_PesquisaTB_ORDER_ID: TIntegerField;
    Qr_PesquisaCONTROL_ID: TStringField;
    Qr_PesquisaCONTROL_NAME: TStringField;
    Qr_PesquisaCONTROL_PHONE: TStringField;
    Sb_Agrupar: TSpeedButton;
    chbx_Agrupada: TCheckBox;
    procedure SB_CadastrarClick(Sender: TObject);
  private
    { Private declarations }
    Pedido : TControllerPEdido;
    Commanda : TControllerCommand;
    CheckOut : TControllerCheckOutItems;
    ListaNova : TListaCheckOut;

    procedure GeraPedido;
    procedure CriarListaItem;
    procedure GeraComanda;
    procedure SalvaItensComanda;
    procedure DesativaComandaAgrupada;
  protected
    procedure IniciaVariaveis;Override;
    procedure ImagemBotao;Override;
    procedure FormataTela;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure PassagemParametros;Override;
    procedure Insere;Override;
    procedure Visualiza;Override;
    function validaagrupar:Boolean;
    procedure Agrupar;

  public
    { Public declarations }
    ComandaEscolhida : Integer;
  end;

var
  SeaCommand: TSeaCommand;

implementation

{$R *.dfm}

uses     UN_Principal, env, Un_Msg;

{ TSeaCommand }

procedure TSeaCommand.Agrupar;
begin
  GeraPedido;
  CriarListaItem;
  GeraComanda;
  SalvaItensComanda;
  ComandaEscolhida := Pedido.Registro.Codigo;
  DesativaComandaAgrupada;
  Visualizar := True;
  Self.close;
end;

procedure TSeaCommand.CriarListaItem;
Var
  LcItem  : TCheckOutItems;
  I,J : Integer;
begin
  ListaNova     := TListaCheckOut.Create;
  for I := 0 to Grd_Pesquisa.RowCount - 1 do
  BEgin
    if (Grd_Pesquisa.Cells[2,I] = 'X') then
    Begin
      CheckOut.Registro.Estabelecimento :=  Gb_CodMha;
      CheckOut.Registro.Pedido := StrToIntDeF(Grd_Pesquisa.cells[4,I],0);
      CheckOut.getList;
      for J := 0 to CheckOut.Lista.Count -1 do
      Begin
        LcItem  := TCheckOutItems.Create;
        CheckOut.ClonarObj(CheckOut.Lista[J],LcItem);
        ListaNova.Add(LcItem);
      End;
    End;
  End;
end;

procedure TSeaCommand.DesativaComandaAgrupada;
Var
  I,J : Integer;
begin
  for I := 0 to Grd_Pesquisa.RowCount - 1 do
  BEgin
    if (Grd_Pesquisa.Cells[2,I] = 'X') then
    Begin
      //Pega o pedido vinculado a primeira Commmanda
      Commanda.Registro.Estabelecimento := Gb_CodMha;
      Commanda.Registro.Pedido := StrToIntDeF(Grd_Pesquisa.cells[4,I],0);
      Commanda.getbyKey;
      Commanda.Registro.Agrupado := Pedido.Registro.Codigo;
      Commanda.update;
    End;
  End;
end;

procedure TSeaCommand.FormataTela;
begin
  inherited;

end;

procedure TSeaCommand.GeraComanda;
Var
  I,J : Integer;
  LcCtrlID : String;
begin
  for I := 0 to Grd_Pesquisa.RowCount - 1 do
  BEgin
    if (Grd_Pesquisa.Cells[2,I] = 'X') then
    Begin
      //Pega o pedido vinculado a primeira Commmanda
      Commanda.Registro.Estabelecimento := Gb_CodMha;
      Commanda.Registro.Pedido := StrToIntDeF(Grd_Pesquisa.cells[4,I],0);
      Commanda.getbyKey;
      //altera o vinculo do pedido novo para salvar
      Commanda.Registro.Pedido := Pedido.Registro.Codigo;
      //Pega o nom das comandas que seráo agrupadas
      LcCtrlID := '';
      for J := 0 to Grd_Pesquisa.RowCount - 1 do
      BEgin
        if (Grd_Pesquisa.Cells[2,J] = 'X') then
        Begin
          if LcCtrlID = '' then
            LcCtrlID := Grd_Pesquisa.cells[5,J]
          else
            LcCtrlID := concat(LcCtrlID,'/',Grd_Pesquisa.cells[5,J])
        End;
      End;
      Commanda.Registro.Numero := LcCtrlID;
      Commanda.salva;
      Break;
    End;
  End;
end;

procedure TSeaCommand.GeraPedido;
Var
  I : Integer;
begin
  for I := 0 to Grd_Pesquisa.RowCount - 1 do
  BEgin
    if (Grd_Pesquisa.Cells[2,I] = 'X') then
    Begin
      //Pega o pedido vinculado a primeira Commmanda
      Pedido.Registro.Codigo := StrToIntDeF(Grd_Pesquisa.cells[4,I],0);
      Pedido.getbyId;
      //Zera para ao salvar criar um novo
      Pedido.Registro.Codigo := 0;
      Pedido.insere;
      Break;
    End;
  End;
end;

procedure TSeaCommand.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(Sb_Agrupar,'DESTINAR');
end;

procedure TSeaCommand.IniciaVariaveis;
begin
  inherited;
  MultiSelect := True;
  Visualizar := False;
  Pedido    := TControllerPEdido.Create(Self);
  Commanda  := TControllerCommand.Create(Self);
  CheckOut  := TControllerCheckOutItems.Create(Self);
  ListaNova := TListaCheckOut.create;

end;

procedure TSeaCommand.InnerJoinSql;
begin
  SqlTxt := concat(
              SqlTxt,
              '  INNER JOIN TB_PEDIDO ',
              '  ON (PED_CODIGO = TB_ORDER_ID) '
            );
end;

procedure TSeaCommand.Insere;
begin
  inherited;
end;

procedure TSeaCommand.OrderBy;
begin
  SqlTxt := concat(
              SqlTxt,
              '  order by c.DT_RECORD desc '
            );
end;

procedure TSeaCommand.PassagemParametros;
begin
  with Qr_Pesquisa do
  Begin
    ParamByName('institution_id').AsInteger := Gb_codMha;
    if e_Numero_Comanda.Text <> '' then
      ParamByName('control_id').AsString := e_Numero_Comanda.Text;

    if E_Nome_Cliente.Text <> '' then
      ParamByName('control_name').AsString := concat('%',E_Nome_Cliente.Text,'%');

    if E_Numero_Telefone.Text <> '' then
      ParamByName('control_phone').AsString := concat('%',E_Numero_Telefone.Text,'%');
  End;
end;

procedure TSeaCommand.SalvaItensComanda;
Var
  I : Integer;
begin
  CheckOut.Registro.Estabelecimento := Gb_CodMha;
  CheckOut.Registro.Pedido          := Pedido.Registro.Codigo;
  //Apaga os itens da Comanda para reinserir
  CheckOut.deleteByOrder;
  //Insere os itens da Lista atualizada
  with CheckOut do
  Begin
    for I := 0 to ( ListaNova.Count -1 ) do
    begin
      CheckOut.Clear;
      CheckOut.ClonarObj(ListaNova[I],CheckOut.Registro);
      CheckOut.Registro.Codigo := I+1;
      CheckOut.Registro.Pedido := Pedido.Registro.Codigo;
      CheckOut.insere;
    End;
  end;
end;

procedure TSeaCommand.SB_CadastrarClick(Sender: TObject);
begin
  if validaagrupar then
  Begin
    Agrupar;
  End;

end;

procedure TSeaCommand.SelectSql;
begin
  SqlTxt := concat(
              'SELECT c.DT_RECORD, TB_ORDER_ID, CONTROL_ID,CONTROL_NAME,CONTROL_PHONE ',
              'FROM TB_COMMAND c '
            );
end;

function TSeaCommand.validaagrupar: Boolean;
begin
  REsult := True;
  if not Fc_VerificaMarcado(Grd_Pesquisa) then
  Begin
    REsult := False;
    Exit;
  End;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Confirma o agrupamento das comandas escolhidas?'+EOLN+EOLN+
                     'Confirmar a operação ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBlue) = mrBotao2) then
  begin
    Result := False;
    exit;
  end;
end;

procedure TSeaCommand.Visualiza;
begin
  ComandaEscolhida := StrToIntDef(Grd_Pesquisa.cells[4,Grd_Pesquisa.Row],0);
  Visualizar := True;
  Self.close;
end;

procedure TSeaCommand.WhereSql;
begin
  inherited;
  SqlTxt := concat(
              SqlTxt,
             'where ( tb_institution_id =:institution_id ) ',
             '  and ( ped_faturado = ''N'' ) '

              );

  if e_Numero_Comanda.Text <> '' then
    SqlTxt := concat(
                  SqlTxt,
                  ' and ( c.control_id =:control_id ) '
                );

  if E_Nome_Cliente.Text <> '' then
    SqlTxt := concat(
                  SqlTxt,
                  ' and ( c.control_name like :control_name ) '
                );

  if E_Numero_Telefone.Text <> '' then
    SqlTxt := concat(
                  SqlTxt,
                  ' and ( c.control_phone like :control_phone ) '
                );
  if chbx_Agrupada.Checked then
  Begin
    SqlTxt := concat(
                  SqlTxt,
                  ' and ( grouped > 0) '
                );
  End
  else
  Begin
    SqlTxt := concat(
                  SqlTxt,
                  ' and  ( ( grouped = 0) or ( grouped is null) )'
                );
  End


end;

end.
