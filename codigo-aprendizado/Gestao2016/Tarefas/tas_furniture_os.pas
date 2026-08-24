unit tas_furniture_os;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Un_Fm_ListaSituacao, Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Datasnap.Provider, ControllerfurnitureOS, Datasnap.DBClient, Un_Fm_ListaColaboradores;

type
  TTasFurnitureOS = class(TBaseRegistry)
    CB_Equipment: TComboBox;
    Label1: TLabel;
    CB_Brand: TComboBox;
    Label2: TLabel;
    CB_Model: TComboBox;
    Label3: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    MM_Relatado: TMemo;
    MM_Constatado: TMemo;
    Label7: TLabel;
    MM_Executado: TMemo;
    MM_Note: TMemo;
    Label8: TLabel;
    Fm_ListaSituacao: TFm_ListaSituacao;
    Label9: TLabel;
    E_Dt_Attendance: TMaskEdit;
    Pg_Principal: TPageControl;
    tbs_anotacao: TTabSheet;
    Dbg_ListAnnotation: TDBGrid;
    Panel1: TPanel;
    Pnl_Botao_Annotation: TPanel;
    Sb_Alt_Anotacao: TSpeedButton;
    Sb_Exc_Anotacao: TSpeedButton;
    Sb_Ins_Anotacao: TSpeedButton;
    Sb_Grv_Anotacao: TSpeedButton;
    Sb_Can_Anotacao: TSpeedButton;
    Pnl_Annotation: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    E_Ann_Reference: TEdit;
    E_Ann_Obs: TMemo;
    Cds_Anotacao: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    Ds_Anotacao: TDataSource;
    Cds_AnotacaoID: TIntegerField;
    Cds_AnotacaoIDENTIFY: TWideStringField;
    Cds_AnotacaoLINK_ID1: TIntegerField;
    Cds_AnotacaoLINK_ID2: TIntegerField;
    Cds_AnotacaoREFERENCE: TWideStringField;
    Cds_AnotacaoOBSERVATION: TBlobField;
    Cds_AnotacaoDT_RECORD: TDateField;
    Sb_Imprimir: TSpeedButton;
    Fm_ListaTecnico: TFm_ListaColaboradores;
    Label13: TLabel;
    E_Hr_Attendance: TMaskEdit;
    Label4: TLabel;
    Cb_Environment: TComboBox;
    procedure Sb_Ins_AnotacaoClick(Sender: TObject);
    procedure Sb_Alt_AnotacaoClick(Sender: TObject);
    procedure Dbg_ListAnnotationDblClick(Sender: TObject);
    procedure Sb_Exc_AnotacaoClick(Sender: TObject);
    procedure Sb_Grv_AnotacaoClick(Sender: TObject);
    procedure Sb_Can_AnotacaoClick(Sender: TObject);
    procedure Fm_ListaSituacaoDBLCB_SituacaoExit(Sender: TObject);
    procedure Sb_ImprimirClick(Sender: TObject);
  private
    EditionStateAnnotation : String;
    Pf_Imprimir : Boolean;
    procedure EditionControlAnnotation;
    procedure ImagemBotaoAnnotation;
    procedure LimpaCampos;

    //Anotaçções
    procedure LimpaCampoAnotacao;
    procedure ShowDataAnotacao;
    function validaInsertAnnotation:Boolean;
    function validaEditAnnotation:Boolean;
    function validaAnnotationHasItem:Boolean;
    function validaDeleteAnnotation:Boolean;
    procedure DeleteAnnotation;
    function validaSaveAnnotation:Boolean;
    procedure SaveAnnotation;


    procedure SaveOrder;

    function validaCancelAnnotation:Boolean;
    procedure CancelAnnotation;

    function ValidaImprimir:Boolean;
    procedure Imprimir;
    function ValidaImprimirOrdemServico:Boolean;
    procedure ImprimirOrdemServico;

    procedure GeraNumeroPedido;

  protected
    procedure CriarVariaveis;Override;
    procedure ImagemBotao;Override;

    procedure setPerfil;Override;

    procedure ShowData;Override;
    procedure ShowDataFurnitureOS;
    procedure ShowListDataAnotacao;
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

    procedure EditionControl;Override;
  public
    { Public declarations }
    FurnitureOS : TControllerfurnitureOS;
  end;

var
  TasFurnitureOS: TTasFurnitureOS;

implementation

{$R *.dfm}

uses     Un_Msg, Un_DM, Un_Imp_Mod_Impressao, UN_Principal, env, UN_Sistema;

{ TTasFurnitureOS }

procedure TTasFurnitureOS.Cancel;
begin
  inherited;

end;

procedure TTasFurnitureOS.CancelAnnotation;
begin

end;

procedure TTasFurnitureOS.Change;
begin
  inherited;
  CB_Equipment.SetFocus;
  EditionStateAnnotation := 'B';
  EditionControlAnnotation;

end;

procedure TTasFurnitureOS.CriarVariaveis;
begin
  inherited;
  ImagemBotaoAnnotation;
  FurnitureOS := TControllerFurnitureOS.Create(Self);
  Fm_ListaSituacao.modulo := 9;
  Fm_ListaSituacao.Listar;
  Fm_ListaTecnico.ListaColaborador;
  FurnitureOs.ComboEquipment(CB_Equipment);
  FurnitureOs.ComboEnvironment(Cb_Environment);
  FurnitureOs.ComboBrand(CB_Brand);
  FurnitureOs.ComboModel(CB_Model);
end;

procedure TTasFurnitureOS.Dbg_ListAnnotationDblClick(Sender: TObject);
begin
  ShowDataAnotacao;
end;

procedure TTasFurnitureOS.Delete;
begin
  inherited;
  FurnitureOs.delete;
  Close;
end;

procedure TTasFurnitureOS.DeleteAnnotation;
begin
  FurnitureOs.Anotacao.delete;
  Cds_Anotacao.Delete;
  LimpaCampoAnotacao;
end;

procedure TTasFurnitureOS.EditionControl;
begin
  EditionControler(Self);
  pnl_fundo.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  SB_Inserir.Enabled := ( EditionState = 'B' ) and Pf_Inserir ;
  SB_Alterar.Enabled := ( EditionState = 'B' ) and ( Length(trim(FurnitureOs.Registro.Equipamento)) > 0 ) and Pf_Alterar;
  SB_Excluir.Enabled := ( EditionState = 'B' ) and ( Length(trim(FurnitureOs.Registro.Equipamento)) > 0 ) and Pf_Excluir;
  SB_gravar.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  SB_Cancelar.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Sb_Sair_0.Enabled := ( EditionState = 'B' );
  Sb_Imprimir.Enabled := (( EditionState = 'B' ) and ( Length(trim(FurnitureOs.Registro.Equipamento)) > 0 )) and Pf_Imprimir;
  pnl_fundo.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
end;

procedure TTasFurnitureOS.EditionControlAnnotation;
begin
  Sb_Ins_Anotacao.Enabled := ( EditionStateAnnotation = 'B' ) ;
  Sb_Alt_Anotacao.Enabled := ( EditionStateAnnotation = 'B' ) and ( Cds_AnotacaoID.AsInteger > 0 );
  Sb_Exc_Anotacao.Enabled := ( EditionStateAnnotation = 'B' ) and ( Cds_AnotacaoID.AsInteger > 0 );
  Sb_Grv_Anotacao.Enabled := ( EditionStateAnnotation = 'I' ) or ( EditionStateAnnotation = 'E' );
  Sb_Can_Anotacao.Enabled := ( EditionStateAnnotation = 'I' ) or ( EditionStateAnnotation = 'E' );
  E_Ann_Reference.Enabled :=  ( EditionStateAnnotation = 'I' ) or ( EditionStateAnnotation = 'E' );
  E_Ann_Obs.Enabled       :=  ( EditionStateAnnotation = 'I' ) or ( EditionStateAnnotation = 'E' );
end;

procedure TTasFurnitureOS.Fm_ListaSituacaoDBLCB_SituacaoExit(
  Sender: TObject);
begin
  IF Pos('PRONTO',Fm_ListaSituacao.DBLCB_Situacao.Text)>0 then
    E_Dt_Attendance.Text := DateToSTr(Date)
  else
    E_Dt_Attendance.Clear;
end;

procedure TTasFurnitureOS.GeraNumeroPedido;
begin
  FurnitureOs.NotaFiscal.Pedido.Registro.CodigoEstabelecimento := Gb_CodMha;
  FurnitureOs.NotaFiscal.Pedido.Registro.Codigo := FurnitureOs.Registro.Pedido;
  FurnitureOs.NotaFiscal.Pedido.nextNumber('T');
end;

procedure TTasFurnitureOS.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(Sb_Imprimir,'IMPRIMIR');
end;

procedure TTasFurnitureOS.ImagemBotaoAnnotation;
begin
  CarregaImagemBotao(Sb_Ins_Anotacao,'INSERIR');
  CarregaImagemBotao(Sb_Alt_Anotacao,'ALTERAR');
  CarregaImagemBotao(Sb_Exc_Anotacao,'EXCLUIR');
  CarregaImagemBotao(Sb_Grv_Anotacao,'GRAVAR');
  CarregaImagemBotao(Sb_Can_Anotacao,'CANCELAR');
end;

procedure TTasFurnitureOS.Imprimir;
begin
  if ValidaImprimirOrdemServico then
  Begin
    ImprimirOrdemServico;
  end;
end;

procedure TTasFurnitureOS.ImprimirOrdemServico;
Var
  Lc_Imp : TimpModImpressao;
Begin
  try
    Lc_Imp := TimpModImpressao.create(nil);
    Self.Enabled := False;
    GeraNumeroPedido;
    Lc_Imp.ImpModuloOrdemFurniture(FurnitureOs.Registro.Pedido);
  finally
    FreeAndNil(Lc_Imp);
    Self.Enabled := True;
  end;
end;

procedure TTasFurnitureOS.IniciaVariaveis;
begin
  if CodigoRegistro > 0 then
  Begin
    FurnitureOs.Registro.Pedido := Self.CodigoRegistro;
    FurnitureOs.getbyId;
  End;
  inherited;

end;

procedure TTasFurnitureOS.Insert;
begin
  LimpaCampos;
  CB_Equipment.SetFocus;
  EditionStateAnnotation := 'B';
  EditionControlAnnotation;
end;

procedure TTasFurnitureOS.LimpaCampoAnotacao;
begin
  FurnitureOs.Anotacao.clear;
  E_Ann_Reference.Clear;
  E_Ann_Obs.Clear;
end;

procedure TTasFurnitureOS.LimpaCampos;
begin

end;

procedure TTasFurnitureOS.Save;
begin
  SaveOrder;
end;

procedure TTasFurnitureOS.SaveAnnotation;
begin
  //salva dados no Banco
  FurnitureOs.Anotacao.Registro.Identificar  := 'TB_FURNITURE_OS';
  FurnitureOs.Anotacao.Registro.Link1        := FurnitureOs.Registro.Pedido;
  FurnitureOs.Anotacao.Registro.Link2        := 0;
  FurnitureOs.Anotacao.Registro.Referencia   := E_Ann_Reference.Text;
  FurnitureOs.Anotacao.Registro.Observacao   := E_Ann_Obs.Text;
  FurnitureOs.Anotacao.Registro.Data         := Date;
  if (FurnitureOs.Anotacao.Registro.Codigo > 0) then
  Begin
    FurnitureOs.Anotacao.update;
    Cds_Anotacao.Edit;
  End
  else
  Begin
    FurnitureOs.Anotacao.Registro.Codigo := 0;
    FurnitureOs.Anotacao.insert;
    Cds_Anotacao.Append;
  End;
  Cds_AnotacaoID.AsInteger          := FurnitureOs.Anotacao.Registro.Codigo;
  Cds_AnotacaoIDENTIFY.AsString     := FurnitureOs.Anotacao.Registro.Identificar;
  Cds_AnotacaoLINK_ID1.AsInteger    := FurnitureOs.Anotacao.Registro.Link1;
  Cds_AnotacaoLINK_ID2.AsInteger    := FurnitureOs.Anotacao.Registro.Link2;
  Cds_AnotacaoREFERENCE.AsString    := FurnitureOs.Anotacao.Registro.Referencia;
  Cds_AnotacaoOBSERVATION.AsString  := FurnitureOs.Anotacao.Registro.Observacao;
  Cds_AnotacaoDT_RECORD.AsDateTime  := FurnitureOs.Anotacao.Registro.Data;
  Cds_Anotacao.Post;


end;


procedure TTasFurnitureOS.SaveOrder;
begin
  with FurnitureOS do
  Begin
    Registro.Equipamento  := CB_Equipment.Text;
    Registro.Ambiente     := Cb_Environment.Text;
    Registro.Marca        := CB_Brand.Text;
    Registro.Modelo       := CB_Model.Text;
    Registro.relatado     := MM_Relatado.Text;
    Registro.Constatado   := MM_Constatado.Text;
    Registro.Executado    := MM_Executado.Text;
    Registro.Observacao   := MM_Note.Text;
    Registro.situacao     := Fm_ListaSituacao.DBLCB_Situacao.KeyValue;
    if ( Fm_ListaTecnico.Dblcb_Vendedor.Text <> '') then
      Registro.Tecnico     := Fm_ListaTecnico.Dblcb_Vendedor.KeyValue
    else
      Registro.Tecnico     := 0;

    if E_Dt_Attendance.Text = '  /  /    ' then
      registro.DataAtendimento := 0
    else
      registro.DataAtendimento := StrToDateDef(E_Dt_Attendance.Text,0);

    if E_Hr_Attendance.Text = '  :  ' then
      registro.HoraAtendimento := 0
    else
      registro.HoraAtendimento := StrToTimeDef(E_Hr_Attendance.Text,0);
    FurnitureOS.salva;
  End;
end;

procedure TTasFurnitureOS.Sb_Alt_AnotacaoClick(Sender: TObject);
begin
  if validaEditAnnotation then
  Begin
    EditionStateAnnotation := 'E';
    EditionControlAnnotation;
    E_Ann_Reference.SetFocus;
  End;
end;

procedure TTasFurnitureOS.Sb_Can_AnotacaoClick(Sender: TObject);
begin
  if validaCancelAnnotation then
  Begin
     CancelAnnotation;
     EditionStateAnnotation := 'B';
     EditionControlAnnotation;
  End;
end;

procedure TTasFurnitureOS.Sb_Exc_AnotacaoClick(Sender: TObject);
begin
  inherited;
  if validaDeleteAnnotation then
  Begin
     DeleteAnnotation;
     EditionStateAnnotation := 'B';
     EditionControlAnnotation;

  End;
end;

procedure TTasFurnitureOS.Sb_Grv_AnotacaoClick(Sender: TObject);
begin
  if validaSaveAnnotation then
  Begin
    SaveAnnotation;
    EditionStateAnnotation := 'B';
    EditionControlAnnotation;

  End;

end;

procedure TTasFurnitureOS.Sb_ImprimirClick(Sender: TObject);
begin
  Imprimir;
end;

procedure TTasFurnitureOS.Sb_Ins_AnotacaoClick(Sender: TObject);
begin
  if validaInsertAnnotation then
  Begin
    EditionStateAnnotation := 'I';
    EditionControlAnnotation;
    LimpaCampoAnotacao;
    E_Ann_Reference.SetFocus;
  End;
end;

procedure TTasFurnitureOS.setPerfil;
Var
  Lc_Menu : String;
begin
  Lc_Menu := 'SeaFurnitureOS';
  if Gb_Nivel = 1 then
  begin
    Pf_Inserir    := True;
    Pf_Alterar    := True;
    Pf_Excluir    := True;
    Pf_Visualizar := True;
    Pf_Imprimir   := True;
  end
  else
  begin
    Pf_Inserir    := Fc_HabilitaPermissao(Lc_Menu,'INSERIR','S');
    Pf_Alterar    := Fc_HabilitaPermissao(Lc_Menu,'ALTERAR','S');
    Pf_Excluir    := Fc_HabilitaPermissao(Lc_Menu,'EXCLUIR','S');
    Pf_Visualizar := Fc_HabilitaPermissao(Lc_Menu,'VISUALIZAR','S');
    Pf_Imprimir   := Fc_HabilitaPermissao(Lc_Menu,'IMPRIMIR','S');
  end;

end;

procedure TTasFurnitureOS.ShowData;
begin
  ShowDataFurnitureOS;
  ShowListDataAnotacao;
end;

procedure TTasFurnitureOS.ShowDataAnotacao;
begin
  if (Cds_Anotacao.Active) then
  Begin
    if Cds_AnotacaoID.AsInteger > 0 then
    Begin
      FurnitureOs.Anotacao.Registro.Codigo := Cds_AnotacaoID.AsInteger;
      FurnitureOs.Anotacao.Registro.Identificar := Cds_AnotacaoIDENTIFY.AsString;
      FurnitureOs.Anotacao.getByKey;
      E_Ann_Reference.Text  := FurnitureOs.Anotacao.Registro.Referencia;
      E_Ann_Obs.Text        := FurnitureOs.Anotacao.Registro.Observacao;
    End;
  End;
end;

procedure TTasFurnitureOS.ShowListDataAnotacao;
Var
  I : Integer;
begin
  FurnitureOs.Anotacao.Registro.Identificar := 'TB_FURNITURE_OS';
  FurnitureOs.Anotacao.Registro.Link1 := FurnitureOs.Registro.Pedido;
  FurnitureOs.Anotacao.getList;
  if not Cds_Anotacao.Active then Cds_Anotacao.CreateDataSet;
  Cds_Anotacao.EmptyDataSet;
  for I := 0 to FurnitureOs.Anotacao.Lista.Count-1 do
  Begin
    Cds_Anotacao.Append;
    Cds_AnotacaoID.AsInteger          := FurnitureOs.Anotacao.Lista[I].Codigo;
    Cds_AnotacaoIDENTIFY.AsString     := FurnitureOs.Anotacao.Lista[I].Identificar;
    Cds_AnotacaoLINK_ID1.AsInteger    := FurnitureOs.Anotacao.Lista[I].Link1;
    Cds_AnotacaoLINK_ID2.AsInteger    := FurnitureOs.Anotacao.Lista[I].Link2;
    Cds_AnotacaoREFERENCE.AsString    := FurnitureOs.Anotacao.Lista[I].Referencia;
    Cds_AnotacaoOBSERVATION.AsString  := FurnitureOs.Anotacao.Lista[I].Observacao;
    Cds_AnotacaoDT_RECORD.AsDateTime  := FurnitureOs.Anotacao.Lista[I].Data;
    Cds_Anotacao.Post;
  End;
  Cds_Anotacao.First;
  ShowDataAnotacao;
  EditionStateAnnotation := 'B';
  EditionControlAnnotation;
end;

procedure TTasFurnitureOS.ShowDataFurnitureOS;
begin
  with FurnitureOs do
  Begin
    CB_Equipment.Text   := Registro.Equipamento;
    CB_Environment.Text := Registro.Ambiente;
    CB_Brand.Text       := Registro.Marca;
    CB_Model.Text       := Registro.Modelo;
    MM_Relatado.Text    := Registro.Relatado;
    MM_Constatado.Text  := Registro.Constatado;
    MM_Executado.Text   := Registro.Executado;
    MM_Note.Text        := Registro.Observacao;
    Fm_ListaSituacao.DBLCB_Situacao.KeyValue := Registro.situacao;
    Fm_ListaTecnico.Dblcb_Vendedor.KeyValue := Registro.Tecnico;

    if registro.DataAtendimento >0 then
      E_Dt_Attendance.Text := DateToStr(registro.DataAtendimento)
    else
      E_Dt_Attendance.Clear;

    if registro.HoraAtendimento >0 then
      E_Hr_Attendance.Text := Copy( TimeToStr(registro.HoraAtendimento),1,5)
    else
      E_Hr_Attendance.Clear;
  End;
end;


function TTasFurnitureOS.validaDeleteAnnotation: Boolean;
begin
  Result := True;
  if not validaAnnotationHasItem then
  Begin
    Result := True;
    Exit;
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

function TTasFurnitureOS.validaEditAnnotation: Boolean;
begin
  Result := True;
  if not validaAnnotationHasItem then
  Begin
    Result := True;
    Exit;
  End;
end;

function TTasFurnitureOS.ValidaImprimir: Boolean;
begin
  REsult := True;
end;

function TTasFurnitureOS.ValidaImprimirOrdemServico: Boolean;
begin
  REsult := True;
end;

function TTasFurnitureOS.validaAnnotationHasItem: Boolean;
begin
  Result := True;
  if not Cds_Anotacao.Active then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Nenhuma anotação foi encontrada.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

  if Cds_Anotacao.RecordCount = 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não há registros para esta operação.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

end;

function TTasFurnitureOS.validaCancelAnnotation: Boolean;
begin
  Result := True;
end;

function TTasFurnitureOS.validaInsertAnnotation: Boolean;
begin
  Result := True;
  if ValidateSave then
  Begin
    Save;
  End
  else
  Begin
    Result := False;
    exit;
  End;
end;

function TTasFurnitureOS.validaSaveAnnotation: Boolean;
begin
  REsult := True;

  if Trim(E_Ann_Reference.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Campo referência não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if E_Ann_Reference.CanFocus then E_Ann_Reference.SetFocus;
   Exit;
  end;

  if Trim(E_Ann_Obs.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Campo Anotação não não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if E_Ann_Obs.CanFocus then E_Ann_Obs.SetFocus;
   Exit;
  end;

end;

function TTasFurnitureOS.ValidateCancel: Boolean;
begin
  REsult := True;
end;

function TTasFurnitureOS.ValidateChange: Boolean;
begin
  Result := True;
end;

function TTasFurnitureOS.ValidateDelete: boolean;
begin
  Result := True;
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



function TTasFurnitureOS.ValidateSave: Boolean;
begin
  REsult := True;

  if Trim(CB_Equipment.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Dispositivo não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if CB_Equipment.CanFocus then CB_Equipment.SetFocus;
   Exit;
  end;

  if Trim(Cb_Environment.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Ambiente não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if Cb_Environment.CanFocus then Cb_Environment.SetFocus;
   Exit;
  end;

  if Trim(CB_Brand.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Marca não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if CB_Brand.CanFocus then CB_Brand.SetFocus;
   Exit;
  end;

  if Trim(CB_Model.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Modelo não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if CB_Model.CanFocus then CB_Model.SetFocus;
   Exit;
  end;

  if Trim(MM_Relatado.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Campo defeito relatado não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if MM_Relatado.CanFocus then MM_Relatado.SetFocus;
   Exit;
  end;

  if Trim(Fm_ListaSituacao.DBLCB_Situacao.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Campo Situação do conserto não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   Fm_ListaSituacao.DBLCB_Situacao.SetFocus;
   Exit;
  end;


  if (E_Dt_Attendance.Text <> '  /  /    ') or (E_Hr_Attendance.Text <> '  :  ')  then
  Begin
    if (E_Dt_Attendance.Text = '  /  /    ') then
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Como o campo hora do atendimento preenchido é obrigatório preencher a data também.'+EOLN+
                     'Preencha para continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      E_Dt_Attendance.SetFocus;
      result:=False;
      Exit;
    End;

    if (E_Hr_Attendance.Text = '  :  ')  then
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Como o campo data do Atendimento preenchido é obrigatório preencher a hora..'+EOLN+
                     'Preencha para continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      E_Hr_Attendance.SetFocus;
      result:=False;
      Exit;
    End;

    if Fm_ListaTecnico.Dblcb_Vendedor.Text = '' then
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Como o campo data do Atendimento preenchido é obrigatório preencher o nome do técnico.'+EOLN+
                     'Preencha para continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      Fm_ListaTecnico.Dblcb_Vendedor.SetFocus;
      result:=False;
      Exit;
    End;
  End;
end;

end.
