unit tas_order_elect_equip;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Un_Fm_ListaSituacao, Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, ControllerConserto, Datasnap.Provider, Datasnap.DBClient, Un_Fm_ListaColaboradores;

type
  TTasOrderElectEquip = class(TBaseRegistry)
    CB_Device: TComboBox;
    Label1: TLabel;
    CB_Brand: TComboBox;
    Label2: TLabel;
    CB_Model: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    E_Serie: TEdit;
    Label5: TLabel;
    E_IMei: TEdit;
    Label32: TLabel;
    Label33: TLabel;
    Label6: TLabel;
    MM_Relatado: TMemo;
    MM_Constatado: TMemo;
    Label7: TLabel;
    MM_Executado: TMemo;
    MM_Note: TMemo;
    Label8: TLabel;
    Label45: TLabel;
    E_Dt_Conserto: TMaskEdit;
    Fm_ListaSituacao: TFm_ListaSituacao;
    Label9: TLabel;
    E_Dt_Entrega: TMaskEdit;
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
    E_Accessories: TEdit;
    Sb_Pesq_Device: TSpeedButton;
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
    Label12: TLabel;
    E_Dt_Prevista: TMaskEdit;
    Sb_Imprimir: TSpeedButton;
    Fm_ListaTecnico: TFm_ListaColaboradores;
    Label13: TLabel;
    E_Hr_Entrega: TMaskEdit;
    E_Hr_Conserto: TMaskEdit;
    Label14: TLabel;
    Label15: TLabel;
    E_Hr_Prevista: TMaskEdit;
    procedure Sb_Pesq_DeviceClick(Sender: TObject);
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
    procedure ShowDataEquipamento;
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

    procedure SaveEquipment;

    procedure SaveOrder;

    function validaCancelAnnotation:Boolean;
    procedure CancelAnnotation;

    function ValidaImprimir:Boolean;
    function ValidaImprimirOrdemServico:Boolean;
    function ValidaImprimirTermoGarantia:Boolean;
    procedure ImprimirOrdemServico;
    procedure ImprimirTermoGarantia;

    procedure GeraNumeroPedido;
    procedure Imprimir;
  protected
    procedure CriarVariaveis;Override;
    procedure ImagemBotao;Override;

    procedure setPerfil;Override;

    procedure ShowData;Override;
    procedure ShowDataConserto;
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
    Conserto : TControllerConserto;
  end;

var
  TasOrderElectEquip: TTasOrderElectEquip;

implementation

{$R *.dfm}

uses     Un_Msg, sea_elect_equip, Un_DM, Un_Imp_Mod_Impressao, UN_Principal, env, UN_Sistema;
{ TTasOrderElectEquip }

procedure TTasOrderElectEquip.Cancel;
begin
  inherited;

end;

procedure TTasOrderElectEquip.CancelAnnotation;
begin

end;

procedure TTasOrderElectEquip.Change;
begin
  inherited;
  CB_Device.SetFocus;
  EditionStateAnnotation := 'B';
  EditionControlAnnotation;
end;

procedure TTasOrderElectEquip.CriarVariaveis;
begin
  inherited;
  ImagemBotaoAnnotation;
  Conserto := TControllerConserto.Create(Self);
  Fm_ListaSituacao.Modulo := 7;
  Fm_ListaSituacao.Listar;
  Fm_ListaTecnico.ListaColaborador;
  Conserto.Equipamento.ComboDevice(CB_Device);
  Conserto.Equipamento.ComboBrand(CB_Brand);
  Conserto.Equipamento.ComboModel(CB_Model);
end;

procedure TTasOrderElectEquip.Dbg_ListAnnotationDblClick(Sender: TObject);
begin
  ShowDataAnotacao;
end;

procedure TTasOrderElectEquip.Delete;
begin
  inherited;
  Conserto.delete;
  Close;
end;

procedure TTasOrderElectEquip.DeleteAnnotation;
begin
  conserto.Anotacao.delete;
  Cds_Anotacao.Delete;
  LimpaCampoAnotacao;
end;

procedure TTasOrderElectEquip.EditionControl;
begin
  inherited;
  Sb_Imprimir.Enabled := (( EditionState = 'B' ) and ( conserto.Registro.Codigo > 0 )) and Pf_Imprimir;
  pnl_fundo.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
end;

procedure TTasOrderElectEquip.EditionControlAnnotation;
begin
  Sb_Ins_Anotacao.Enabled := ( EditionStateAnnotation = 'B' ) ;
  Sb_Alt_Anotacao.Enabled := ( EditionStateAnnotation = 'B' ) and ( Cds_AnotacaoID.AsInteger > 0 );
  Sb_Exc_Anotacao.Enabled := ( EditionStateAnnotation = 'B' ) and ( Cds_AnotacaoID.AsInteger > 0 );
  Sb_Grv_Anotacao.Enabled := ( EditionStateAnnotation = 'I' ) or ( EditionStateAnnotation = 'E' );
  Sb_Can_Anotacao.Enabled := ( EditionStateAnnotation = 'I' ) or ( EditionStateAnnotation = 'E' );
  E_Ann_Reference.Enabled :=  ( EditionStateAnnotation = 'I' ) or ( EditionStateAnnotation = 'E' );
  E_Ann_Obs.Enabled       :=  ( EditionStateAnnotation = 'I' ) or ( EditionStateAnnotation = 'E' );
end;

procedure TTasOrderElectEquip.Fm_ListaSituacaoDBLCB_SituacaoExit(
  Sender: TObject);
begin
  IF Pos('PRONTO',Fm_ListaSituacao.DBLCB_Situacao.Text)>0 then
    E_Dt_Conserto.Text := DateToSTr(Date)
  else
    E_Dt_Conserto.Clear;
end;

procedure TTasOrderElectEquip.GeraNumeroPedido;
begin
  Conserto.NotaFiscal.Pedido.Registro.CodigoEstabelecimento := Gb_CodMha;
  Conserto.NotaFiscal.Pedido.Registro.Codigo := Conserto.Registro.Codped;
  Conserto.NotaFiscal.Pedido.nextNumber('T');
end;

procedure TTasOrderElectEquip.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(Sb_Imprimir,'IMPRIMIR');
end;

procedure TTasOrderElectEquip.ImagemBotaoAnnotation;
begin
  CarregaImagemBotao(Sb_Ins_Anotacao,'INSERIR');
  CarregaImagemBotao(Sb_Alt_Anotacao,'ALTERAR');
  CarregaImagemBotao(Sb_Exc_Anotacao,'EXCLUIR');
  CarregaImagemBotao(Sb_Grv_Anotacao,'GRAVAR');
  CarregaImagemBotao(Sb_Can_Anotacao,'CANCELAR');
end;

procedure TTasOrderElectEquip.Imprimir;
Var
  Lc_Imp : TimpModImpressao;
  Lc_Escolha : Integer;
begin
  Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                'Qual o tipo de impressão?.' + EOLN + EOLN + EOLN ,
                                ['Ordem de Serviço', 'Termo de Garantia','Cancelar'],
                                [bNormal,bNormal,bEscape], mpConfirmacao, clBtnFace));
  case Lc_Escolha of
    0:Begin
        if ValidaImprimirOrdemServico then
        Begin
          ImprimirOrdemServico;
        end;
    End;
    1:Begin
         if ValidaImprimirTermoGarantia then
        Begin
          ImprimirTermoGarantia;
        end;
    End;
  end;
end;

procedure TTasOrderElectEquip.ImprimirOrdemServico;
Var
  Lc_Imp : TimpModImpressao;
Begin
  try
    Lc_Imp := TimpModImpressao.create(nil);
    Self.Enabled := False;
    GeraNumeroPedido;
    Lc_Imp.ImpModuloOrdemEletronicos(Conserto.Registro.Codped);
  finally
    FreeAndNil(Lc_Imp);
    Self.Enabled := True;
  end;
end;

procedure TTasOrderElectEquip.ImprimirTermoGarantia;
Var
  Lc_Imp : TimpModImpressao;
Begin
  try
    Lc_Imp := TimpModImpressao.create(nil);
    Self.Enabled := False;
    GeraNumeroPedido;
    Lc_Imp.ImpModuloGarantiaEletronicos(Conserto.Registro.Codped);
  finally
    FreeAndNil(Lc_Imp);
    Self.Enabled := True;
  end;
end;

procedure TTasOrderElectEquip.IniciaVariaveis;
begin
  if CodigoRegistro > 0 then
  Begin
    Conserto.Registro.Codigo := Self.CodigoRegistro;
    Conserto.getByKey;
  End;
  inherited;

end;

procedure TTasOrderElectEquip.Insert;
begin
  LimpaCampos;
  CB_Device.SetFocus;
  EditionStateAnnotation := 'B';
  EditionControlAnnotation;
end;

procedure TTasOrderElectEquip.LimpaCampoAnotacao;
begin
  Conserto.Anotacao.clear;
  E_Ann_Reference.Clear;
  E_Ann_Obs.Clear;
end;

procedure TTasOrderElectEquip.LimpaCampos;
begin

end;

procedure TTasOrderElectEquip.Save;
begin
  SaveEquipment;
  SaveOrder;
end;

procedure TTasOrderElectEquip.SaveAnnotation;
begin
  //salva dados no Banco
  Conserto.Anotacao.Registro.Identificar  := 'TB_ELECT_EQUIP';
  Conserto.Anotacao.Registro.Link1        := Conserto.Registro.Codigo;
  Conserto.Anotacao.Registro.Link2        := 0;
  Conserto.Anotacao.Registro.Referencia   := E_Ann_Reference.Text;
  Conserto.Anotacao.Registro.Observacao   := E_Ann_Obs.Text;
  Conserto.Anotacao.Registro.Data         := Date;
  if (Conserto.Anotacao.Registro.Codigo > 0) then
  Begin
    Conserto.Anotacao.update;
    Cds_Anotacao.Edit;
  End
  else
  Begin
    Conserto.Anotacao.Registro.Codigo := 0;
    Conserto.Anotacao.insert;
    Cds_Anotacao.Append;
  End;
  Cds_AnotacaoID.AsInteger          := Conserto.Anotacao.Registro.Codigo;
  Cds_AnotacaoIDENTIFY.AsString     := Conserto.Anotacao.Registro.Identificar;
  Cds_AnotacaoLINK_ID1.AsInteger    := Conserto.Anotacao.Registro.Link1;
  Cds_AnotacaoLINK_ID2.AsInteger    := Conserto.Anotacao.Registro.Link2;
  Cds_AnotacaoREFERENCE.AsString    := Conserto.Anotacao.Registro.Referencia;
  Cds_AnotacaoOBSERVATION.AsString  := Conserto.Anotacao.Registro.Observacao;
  Cds_AnotacaoDT_RECORD.AsDateTime  := Conserto.Anotacao.Registro.Data;
  Cds_Anotacao.Post;


end;

procedure TTasOrderElectEquip.SaveEquipment;
Var
  LcCdCustomer : Integer;
begin
  Conserto.NotaFiscal.Pedido.Registro.Codigo := Conserto.Registro.Codped;
  LcCdCustomer := Conserto.NotaFiscal.Pedido.getIdEmpresa;
  with Conserto.Equipamento do
  Begin
    Registro.Customer     := LcCdCustomer;
    Registro.Dispositivo  := CB_Device.Text;
    Registro.Marca        := CB_Brand.Text;
    Registro.Modelo       := CB_Model.Text;
    Registro.Serie        := E_Serie.Text;
    Registro.Imei         := E_IMei.Text;
    Registro.Acessorios   := E_Accessories.Text;
  End;
  Conserto.Equipamento.getbySearch;
  if not Conserto.Equipamento.exist then
    Conserto.Equipamento.insert;
end;

procedure TTasOrderElectEquip.SaveOrder;
begin
  with Conserto do
  Begin
    Registro.Aparelho     := CB_Device.Text;
    Registro.Marca        := CB_Brand.Text;
    Registro.Modelo       := CB_Model.Text;
    Registro.Serie        := E_Serie.Text;
    Registro.IMei         := E_IMei.Text;
    Registro.Acessorio    := E_Accessories.Text;
    Registro.Relatado     := MM_Relatado.Text;
    Registro.Constatado   := MM_Constatado.Text;
    Registro.Executado    := MM_Executado.Text;
    Registro.Observacao   := MM_Note.Text;
    Registro.situacao     := Fm_ListaSituacao.DBLCB_Situacao.KeyValue;
    if ( Fm_ListaTecnico.Dblcb_Vendedor.Text <> '') then
      Registro.Tecnico     := Fm_ListaTecnico.Dblcb_Vendedor.KeyValue
    else
      Registro.Tecnico     := 0;

    if E_Dt_Prevista.Text = '  /  /    ' then
      registro.DataPrevista := 0
    else
      registro.DataPrevista := StrToDateDef(E_Dt_Prevista.Text,0);

    if E_Hr_Prevista.Text = '  :  ' then
      registro.HoraPrevista := 0
    else
      registro.HOraPrevista := StrToTimeDef(E_Hr_Prevista.Text,0);

    if E_Dt_Conserto.Text = '  /  /    ' then
      registro.DataConserto := 0
    else
      registro.DataConserto := StrToDateDef(E_Dt_Conserto.Text,0);

    if E_Hr_Conserto.Text = '  :  ' then
      registro.HoraConserto := 0
    else
      registro.HoraConserto := StrToTimeDef(E_Hr_Conserto.Text,0);


    if E_Dt_Entrega.Text = '  /  /    ' then
      registro.DataEntrega  := 0
    else
      registro.DataEntrega  := StrToDateDef(E_Dt_Entrega.Text,0);

    if E_Hr_Entrega.Text = '  :  ' then
      registro.HoraEntrega := 0
    else
      registro.HoraEntrega := StrToTimeDef(E_Hr_Entrega.Text,0);


    save;
  End;
  CodigoRegistro := Conserto.Registro.Codigo;
end;

procedure TTasOrderElectEquip.Sb_Alt_AnotacaoClick(Sender: TObject);
begin
  if validaEditAnnotation then
  Begin
    EditionStateAnnotation := 'E';
    EditionControlAnnotation;
    E_Ann_Reference.SetFocus;
  End;
end;

procedure TTasOrderElectEquip.Sb_Can_AnotacaoClick(Sender: TObject);
begin
  if validaCancelAnnotation then
  Begin
     CancelAnnotation;
     EditionStateAnnotation := 'B';
     EditionControlAnnotation;
  End;
end;

procedure TTasOrderElectEquip.Sb_Exc_AnotacaoClick(Sender: TObject);
begin
  inherited;
  if validaDeleteAnnotation then
  Begin
     DeleteAnnotation;
     EditionStateAnnotation := 'B';
     EditionControlAnnotation;

  End;
end;

procedure TTasOrderElectEquip.Sb_Grv_AnotacaoClick(Sender: TObject);
begin
  if validaSaveAnnotation then
  Begin
    SaveAnnotation;
    EditionStateAnnotation := 'B';
    EditionControlAnnotation;

  End;

end;

procedure TTasOrderElectEquip.Sb_ImprimirClick(Sender: TObject);
begin
  Imprimir;
end;

procedure TTasOrderElectEquip.Sb_Ins_AnotacaoClick(Sender: TObject);
begin
  if validaInsertAnnotation then
  Begin
    EditionStateAnnotation := 'I';
    EditionControlAnnotation;
    LimpaCampoAnotacao;
    E_Ann_Reference.SetFocus;
  End;
end;

procedure TTasOrderElectEquip.Sb_Pesq_DeviceClick(Sender: TObject);
Var
  LcForm : TSeaElectEquip;
begin
  Try
    LcForm := TSeaElectEquip.Create(nil);
    LcForm.Selecionar := True;
    LcForm.ShowModal;
    if LcForm.Selecionado then
    Begin
      Conserto.Equipamento.Registro.Codigo := LcForm.cds_searchID.AsInteger;
      Conserto.Equipamento.getbyId;
      if Conserto.Equipamento.exist then
      Begin
        ShowDataEquipamento;
      End;
    End;
  Finally
    FreeAndNil(LcForm);
  End;
end;

procedure TTasOrderElectEquip.setPerfil;
Var
  Lc_Menu : String;
begin
  Lc_Menu := 'SeaOrderElectEquip';
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

procedure TTasOrderElectEquip.ShowData;
begin
  ShowDataConserto;
  ShowListDataAnotacao;
end;

procedure TTasOrderElectEquip.ShowDataAnotacao;
begin
  if Cds_Anotacao.Active then
  Begin
    if Cds_AnotacaoID.AsInteger > 0 then
    Begin
      conserto.Anotacao.Registro.Codigo := Cds_AnotacaoID.AsInteger;
      conserto.Anotacao.Registro.Identificar := Cds_AnotacaoIDENTIFY.AsString;
      conserto.Anotacao.getByKey;
      E_Ann_Reference.Text  := conserto.Anotacao.Registro.Referencia;
      E_Ann_Obs.Text        := conserto.Anotacao.Registro.Observacao;
    End;
  End;
end;

procedure TTasOrderElectEquip.ShowListDataAnotacao;
Var
  I : Integer;
begin
  Conserto.Anotacao.Registro.Identificar := 'TB_ELECT_EQUIP';
  Conserto.Anotacao.Registro.Link1 := Conserto.Registro.Codigo;
  Conserto.Anotacao.getList;
  if not Cds_Anotacao.Active then Cds_Anotacao.CreateDataSet;
  Cds_Anotacao.EmptyDataSet;
  for I := 0 to Conserto.Anotacao.Lista.Count-1 do
  Begin
    Cds_Anotacao.Append;
    Cds_AnotacaoID.AsInteger          := Conserto.Anotacao.Lista[I].Codigo;
    Cds_AnotacaoIDENTIFY.AsString     := Conserto.Anotacao.Lista[I].Identificar;
    Cds_AnotacaoLINK_ID1.AsInteger    := Conserto.Anotacao.Lista[I].Link1;
    Cds_AnotacaoLINK_ID2.AsInteger    := Conserto.Anotacao.Lista[I].Link2;
    Cds_AnotacaoREFERENCE.AsString    := Conserto.Anotacao.Lista[I].Referencia;
    Cds_AnotacaoOBSERVATION.AsString  := Conserto.Anotacao.Lista[I].Observacao;
    Cds_AnotacaoDT_RECORD.AsDateTime  := Conserto.Anotacao.Lista[I].Data;
    Cds_Anotacao.Post;
  End;
  Cds_Anotacao.First;
  ShowDataAnotacao;
  EditionStateAnnotation := 'B';
  EditionControlAnnotation;
end;

procedure TTasOrderElectEquip.ShowDataConserto;
begin
  with Conserto do
  Begin
    CB_Device.Text      := Registro.Aparelho;
    CB_Brand.Text       := Registro.Marca;
    CB_Model.Text       := Registro.Modelo;
    E_Serie.Text        := Registro.Serie;
    E_IMei.Text         := Registro.IMei;
    E_Accessories.Text   := Registro.Acessorio;
    MM_Relatado.Text    := Registro.Relatado;
    MM_Constatado.Text  := Registro.Constatado;
    MM_Executado.Text   := Registro.Executado;
    MM_Note.Text        := Registro.Observacao;
    Fm_ListaSituacao.DBLCB_Situacao.KeyValue := Registro.situacao;
    Fm_ListaTecnico.Dblcb_Vendedor.KeyValue := Registro.Tecnico;

    if registro.DataPrevista >0 then
      E_Dt_Prevista.Text := DateToStr(registro.DataPrevista)
    else
      E_Dt_Prevista.Clear;

    if registro.HoraPrevista >0 then
      E_Hr_Prevista.Text := Copy( TimeToStr(registro.HoraPrevista),1,5)
    else
      E_Hr_Prevista.Clear;

    if registro.DataConserto >0 then
      E_Dt_Conserto.Text := DateToStr(registro.DataConserto)
    else
      E_Dt_Conserto.Clear;

    if registro.HoraConserto >0 then
      E_Hr_Conserto.Text := Copy( TimeToStr(registro.HoraConserto),1,5)
    else
      E_Hr_Conserto.Clear;

    if registro.DataEntrega >0 then
      E_Dt_Entrega.Text := DateToStr(registro.DataEntrega)
    else
      E_Dt_Entrega.Clear;

    if registro.HoraEntrega >0 then
      E_Hr_Entrega.Text := Copy( TimeToStr(registro.HoraEntrega),1,5)
    else
      E_Hr_Entrega.Clear;

  End;
end;

procedure TTasOrderElectEquip.ShowDataEquipamento;
begin
  with Conserto.Equipamento do
  Begin
    CB_Device.Text      := Registro.Dispositivo;
    CB_Brand.Text       := Registro.Marca;
    CB_Model.Text       := Registro.Modelo;
    E_Serie.Text        := Registro.Serie;
    E_IMei.Text         := Registro.IMei;
    E_Accessories.Text   := Registro.Acessorios;
  End;
end;

function TTasOrderElectEquip.validaDeleteAnnotation: Boolean;
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

function TTasOrderElectEquip.validaEditAnnotation: Boolean;
begin
  Result := True;
  if not validaAnnotationHasItem then
  Begin
    Result := True;
    Exit;
  End;
end;

function TTasOrderElectEquip.ValidaImprimir: Boolean;
begin
  REsult := True;
end;

function TTasOrderElectEquip.ValidaImprimirOrdemServico: Boolean;
begin
  REsult := True;
end;

function TTasOrderElectEquip.ValidaImprimirTermoGarantia: Boolean;
begin
  REsult := True;
  if Fm_ListaTecnico.Dblcb_Vendedor.Text = '' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não foi informado o Técnico.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

  if (E_Dt_Entrega.Text = '  /  /    ') then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não foi informado a Data de Entrega.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

end;

function TTasOrderElectEquip.validaAnnotationHasItem: Boolean;
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

function TTasOrderElectEquip.validaCancelAnnotation: Boolean;
begin
  Result := True;
end;

function TTasOrderElectEquip.validaInsertAnnotation: Boolean;
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

function TTasOrderElectEquip.validaSaveAnnotation: Boolean;
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

function TTasOrderElectEquip.ValidateCancel: Boolean;
begin
  REsult := True;
end;

function TTasOrderElectEquip.ValidateChange: Boolean;
begin
  Result := True;
end;

function TTasOrderElectEquip.ValidateDelete: boolean;
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



function TTasOrderElectEquip.ValidateSave: Boolean;
Var
  Lc_Escolha : Integer;
begin
  REsult := True;
  if Trim(CB_Device.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Dispositivo não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if CB_Device.CanFocus then CB_Device.SetFocus;
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

  if Trim(E_Serie.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Série não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if E_Serie.CanFocus then E_Serie.SetFocus;
   Exit;
  end;
  //Sem Acessórios
  if Trim(E_Accessories.Text)='' then
  begin
    Lc_Escolha:=(MensagemPadrao(TITULO_INFORMACAO,
                                'Campo acessários não informado'+EOLN+
                                'Caso não tenha acessários confirma abaixo.',
                              ['VOU PREENCHER','SEM ACESSÓRIOS'],[bNormal,bNormal],mpConfirmacao,clBtnFace));
    case Lc_Escolha of
      0:Begin
         result:=False;
         if MM_Relatado.CanFocus then MM_Relatado.SetFocus;
         exit;
      End;
      1:BEgin
        E_Accessories.Text := 'SEM ACESSÓRIOS';
        Result := True;
      End;
    end;
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


  if (E_Dt_Conserto.Text <> '  /  /    ') or (E_Hr_Conserto.Text <> '  :  ')  then
  Begin
    if (E_Dt_Conserto.Text = '  /  /    ') then
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Como o campo hora do conserto preenchido é obrigatório preencher a data também.'+EOLN+
                     'Preencha para continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      E_Dt_Conserto.SetFocus;
      result:=False;
      Exit;
    End;

    if (E_Hr_Conserto.Text = '  :  ')  then
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Como o campo data do conserto preenchido é obrigatório preencher a hora..'+EOLN+
                     'Preencha para continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      E_Hr_Conserto.SetFocus;
      result:=False;
      Exit;
    End;

    if Fm_ListaTecnico.Dblcb_Vendedor.Text = '' then
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Como o campo data do conserto preenchido é obrigatório preencher o nome do técnico.'+EOLN+
                     'Preencha para continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      Fm_ListaTecnico.Dblcb_Vendedor.SetFocus;
      result:=False;
      Exit;

    End;

  End;



end;

end.
