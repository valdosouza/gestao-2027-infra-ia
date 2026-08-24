unit tas_order_print_shop;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Un_Fm_ListaSituacao, Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Datasnap.Provider, Datasnap.DBClient, Un_Fm_ListaColaboradores, ControllerPrintShopOS;

type
  TTasOrderPrintShop = class(TBaseRegistry)
    CB_Material: TComboBox;
    Label1: TLabel;
    CB_Fabricante: TComboBox;
    Label2: TLabel;
    CB_Faca: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    E_Material_supplyed: TEdit;
    Label5: TLabel;
    E_Material_used: TEdit;
    Label32: TLabel;
    Label33: TLabel;
    Label6: TLabel;
    MM_Servico: TMemo;
    MM_OutSourced: TMemo;
    Label7: TLabel;
    MM_Finishings: TMemo;
    MM_Note: TMemo;
    Label8: TLabel;
    Label45: TLabel;
    E_Dt_Final: TMaskEdit;
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
    E_Equipamentos: TEdit;
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
    E_Hr_Final: TMaskEdit;
    Label14: TLabel;
    Label15: TLabel;
    E_Hr_Prevista: TMaskEdit;
    procedure Sb_Ins_AnotacaoClick(Sender: TObject);
    procedure Sb_Alt_AnotacaoClick(Sender: TObject);
    procedure Dbg_ListAnnotationDblClick(Sender: TObject);
    procedure Sb_Exc_AnotacaoClick(Sender: TObject);
    procedure Sb_Grv_AnotacaoClick(Sender: TObject);
    procedure Sb_Can_AnotacaoClick(Sender: TObject);
    procedure Fm_ListaSituacaoDBLCB_SituacaoExit(Sender: TObject);
    procedure Sb_ImprimirClick(Sender: TObject);
    procedure Fm_ListaSituacaoSb_CadastroClick(Sender: TObject);
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
    function ValidaImprimirOrdemComValores:Boolean;
    function ValidaImprimirOrdemSemValores:Boolean;
    procedure ImprimirOrdemComValores;
    procedure ImprimirOrdemSemValores;

    procedure GeraNumeroPedido;
    procedure Imprimir;
  protected
    procedure CriarVariaveis;Override;
    procedure ImagemBotao;Override;

    procedure setPerfil;Override;

    procedure ShowData;Override;
    procedure ShowDataPrintShop;
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
    PrintShop : TControllerPrintShopOS;
  end;

var
  TasOrderPrintShop: TTasOrderPrintShop;

implementation

{$R *.dfm}

uses     Un_Msg, sea_elect_equip, Un_DM, Un_Imp_Mod_Impressao, UN_Principal, env, UN_Sistema;
{ TTasOrderElectEquip }

procedure TTasOrderPrintShop.Cancel;
begin
  inherited;

end;

procedure TTasOrderPrintShop.CancelAnnotation;
begin

end;

procedure TTasOrderPrintShop.Change;
begin
  inherited;
  CB_Material.SetFocus;
  EditionStateAnnotation := 'B';
  EditionControlAnnotation;
end;

procedure TTasOrderPrintShop.CriarVariaveis;
begin
  inherited;
  ImagemBotaoAnnotation;
  PrintShop := TControllerPrintShopOS.Create(Self);
  Fm_ListaSituacao.Modulo := 10;
  Fm_ListaSituacao.Listar;
  Fm_ListaTecnico.ListaColaborador;
  PrintShop.ComboMaterial(CB_Material);
  PrintShop.ComboFabricante(CB_Fabricante);
  PrintShop.ComboFaca(CB_Faca);
end;

procedure TTasOrderPrintShop.Dbg_ListAnnotationDblClick(Sender: TObject);
begin
  ShowDataAnotacao;
end;

procedure TTasOrderPrintShop.Delete;
begin
  inherited;
  PrintShop.delete;
  Close;
end;

procedure TTasOrderPrintShop.DeleteAnnotation;
begin
  PrintShop.Anotacao.delete;
  Cds_Anotacao.Delete;
  LimpaCampoAnotacao;
end;

procedure TTasOrderPrintShop.EditionControl;
begin
  inherited;
  Sb_Imprimir.Enabled := (( EditionState = 'B' ) and ( PrintShop.Registro.Codigo > 0 )) and Pf_Imprimir;
  pnl_fundo.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
end;

procedure TTasOrderPrintShop.EditionControlAnnotation;
begin
  Sb_Ins_Anotacao.Enabled := ( EditionStateAnnotation = 'B' ) ;
  Sb_Alt_Anotacao.Enabled := ( EditionStateAnnotation = 'B' ) and ( Cds_AnotacaoID.AsInteger > 0 );
  Sb_Exc_Anotacao.Enabled := ( EditionStateAnnotation = 'B' ) and ( Cds_AnotacaoID.AsInteger > 0 );
  Sb_Grv_Anotacao.Enabled := ( EditionStateAnnotation = 'I' ) or ( EditionStateAnnotation = 'E' );
  Sb_Can_Anotacao.Enabled := ( EditionStateAnnotation = 'I' ) or ( EditionStateAnnotation = 'E' );
  E_Ann_Reference.Enabled :=  ( EditionStateAnnotation = 'I' ) or ( EditionStateAnnotation = 'E' );
  E_Ann_Obs.Enabled       :=  ( EditionStateAnnotation = 'I' ) or ( EditionStateAnnotation = 'E' );
end;

procedure TTasOrderPrintShop.Fm_ListaSituacaoDBLCB_SituacaoExit(
  Sender: TObject);
begin
  IF Pos('PRONTO',Fm_ListaSituacao.DBLCB_Situacao.Text)>0 then
    E_Dt_Final.Text := DateToSTr(Date)
  else
    E_Dt_Final.Clear;
end;

procedure TTasOrderPrintShop.Fm_ListaSituacaoSb_CadastroClick(Sender: TObject);
begin
  inherited;
  Fm_ListaSituacao.Sb_CadastroClick(Sender);

end;

procedure TTasOrderPrintShop.GeraNumeroPedido;
begin
  PrintShop.NotaFiscal.Pedido.Registro.CodigoEstabelecimento := Gb_CodMha;
  PrintShop.NotaFiscal.Pedido.Registro.Codigo := PrintShop.Registro.Ordem;
  PrintShop.NotaFiscal.Pedido.nextNumber('T');
end;

procedure TTasOrderPrintShop.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(Sb_Imprimir,'IMPRIMIR');
end;

procedure TTasOrderPrintShop.ImagemBotaoAnnotation;
begin
  CarregaImagemBotao(Sb_Ins_Anotacao,'INSERIR');
  CarregaImagemBotao(Sb_Alt_Anotacao,'ALTERAR');
  CarregaImagemBotao(Sb_Exc_Anotacao,'EXCLUIR');
  CarregaImagemBotao(Sb_Grv_Anotacao,'GRAVAR');
  CarregaImagemBotao(Sb_Can_Anotacao,'CANCELAR');
end;

procedure TTasOrderPrintShop.Imprimir;
Var
  Lc_Imp : TimpModImpressao;
  Lc_Escolha : Integer;
begin
  Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                'Qual o modelo de impressão?.' + EOLN + EOLN + EOLN ,
                                [' Com Valores ', ' Sem Valores '],
                                [bNormal,bNormal,bEscape], mpConfirmacao, clBtnFace));
  case Lc_Escolha of
    0:Begin
        if ValidaImprimirOrdemComValores then
        Begin
          ImprimirOrdemComValores;
        end;
    End;
    1:Begin
         if ValidaImprimirOrdemSemValores then
        Begin
          ImprimirOrdemSemValores;
        end;
    End;
  end;
end;

procedure TTasOrderPrintShop.ImprimirOrdemComValores;
Var
  Lc_Imp : TimpModImpressao;
Begin
  try
    Lc_Imp := TimpModImpressao.create(nil);
    Self.Enabled := False;
    GeraNumeroPedido;
    Lc_Imp.CodigoPedido := PrintShop.Registro.Ordem;
    Lc_Imp.Pc_Imp_Vda_JatoLaser_Vda_11;
  finally
    FreeAndNil(Lc_Imp);
    Self.Enabled := True;
  end;
end;

procedure TTasOrderPrintShop.ImprimirOrdemSemValores;
Var
  Lc_Imp : TimpModImpressao;
Begin
  try
    Lc_Imp := TimpModImpressao.create(nil);
    Self.Enabled := False;
    GeraNumeroPedido;
    Lc_Imp.CodigoPedido := PrintShop.Registro.Ordem;
    Lc_Imp.Pc_Imp_Vda_JatoLaser_Vda_13;
  finally
    FreeAndNil(Lc_Imp);
    Self.Enabled := True;
  end;
end;

procedure TTasOrderPrintShop.IniciaVariaveis;
begin
  if CodigoRegistro > 0 then
  Begin
    PrintShop.Registro.Codigo := Self.CodigoRegistro;
    PrintShop.Registro.Estabelecimento := Gb_CodMha;
    PrintShop.getByKey;
  End;
  inherited;

end;

procedure TTasOrderPrintShop.Insert;
begin
  LimpaCampos;
  CB_Material.SetFocus;
  EditionStateAnnotation := 'B';
  EditionControlAnnotation;
end;

procedure TTasOrderPrintShop.LimpaCampoAnotacao;
begin
  PrintShop.Anotacao.clear;
  E_Ann_Reference.Clear;
  E_Ann_Obs.Clear;
end;

procedure TTasOrderPrintShop.LimpaCampos;
begin

end;

procedure TTasOrderPrintShop.Save;
begin
  SaveOrder;
end;

procedure TTasOrderPrintShop.SaveAnnotation;
begin
  //salva dados no Banco
  PrintShop.Anotacao.Registro.Identificar  := 'TB_ELECT_EQUIP';
  PrintShop.Anotacao.Registro.Link1        := PrintShop.Registro.Codigo;
  PrintShop.Anotacao.Registro.Link2        := 0;
  PrintShop.Anotacao.Registro.Referencia   := E_Ann_Reference.Text;
  PrintShop.Anotacao.Registro.Observacao   := E_Ann_Obs.Text;
  PrintShop.Anotacao.Registro.Data         := Date;
  if (PrintShop.Anotacao.Registro.Codigo > 0) then
  Begin
    PrintShop.Anotacao.update;
    Cds_Anotacao.Edit;
  End
  else
  Begin
    PrintShop.Anotacao.Registro.Codigo := 0;
    PrintShop.Anotacao.insert;
    Cds_Anotacao.Append;
  End;
  Cds_AnotacaoID.AsInteger          := PrintShop.Anotacao.Registro.Codigo;
  Cds_AnotacaoIDENTIFY.AsString     := PrintShop.Anotacao.Registro.Identificar;
  Cds_AnotacaoLINK_ID1.AsInteger    := PrintShop.Anotacao.Registro.Link1;
  Cds_AnotacaoLINK_ID2.AsInteger    := PrintShop.Anotacao.Registro.Link2;
  Cds_AnotacaoREFERENCE.AsString    := PrintShop.Anotacao.Registro.Referencia;
  Cds_AnotacaoOBSERVATION.AsString  := PrintShop.Anotacao.Registro.Observacao;
  Cds_AnotacaoDT_RECORD.AsDateTime  := PrintShop.Anotacao.Registro.Data;
  Cds_Anotacao.Post;
end;


procedure TTasOrderPrintShop.SaveOrder;
begin
  with PrintShop do
  Begin
    Registro.Material           := CB_Material.Text;
    Registro.Fabricante         := CB_Fabricante.Text;
    Registro.Faca               := CB_Faca.Text;
    Registro.MaterialFornecido  := E_Material_supplyed.Text;
    Registro.MaterialUtilizado  := E_Material_used.Text;
    Registro.Equipamento        := E_Equipamentos.Text;
    Registro.Servico            := MM_Servico.Text;
    Registro.ServicoTercerizado := MM_OutSourced.Text;
    Registro.Acabamentos        := MM_Finishings.Text;
    Registro.Observacao   := MM_Note.Text;
    Registro.situacao     := Fm_ListaSituacao.DBLCB_Situacao.KeyValue;
    if ( Fm_ListaTecnico.Dblcb_Vendedor.Text <> '') then
      Registro.Responsavel     := Fm_ListaTecnico.Dblcb_Vendedor.KeyValue
    else
      Registro.Responsavel     := 0;

    if E_Dt_Prevista.Text = '  /  /    ' then
      registro.DataPrevista := 0
    else
      registro.DataPrevista := StrToDateDef(E_Dt_Prevista.Text,0);

    if E_Hr_Prevista.Text = '  :  ' then
      registro.HoraPrevista := 0
    else
      registro.HOraPrevista := StrToTimeDef(E_Hr_Prevista.Text,0);

    if E_Dt_Final.Text = '  /  /    ' then
      registro.DataFinal := 0
    else
      registro.DataFinal := StrToDateDef(E_Dt_Final.Text,0);

    if E_Hr_Final.Text = '  :  ' then
      registro.HoraFinal := 0
    else
      registro.HoraFinal := StrToTimeDef(E_Hr_Final.Text,0);


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
  CodigoRegistro := PrintShop.Registro.Codigo;
end;

procedure TTasOrderPrintShop.Sb_Alt_AnotacaoClick(Sender: TObject);
begin
  if validaEditAnnotation then
  Begin
    EditionStateAnnotation := 'E';
    EditionControlAnnotation;
    E_Ann_Reference.SetFocus;
  End;
end;

procedure TTasOrderPrintShop.Sb_Can_AnotacaoClick(Sender: TObject);
begin
  if validaCancelAnnotation then
  Begin
     CancelAnnotation;
     EditionStateAnnotation := 'B';
     EditionControlAnnotation;
  End;
end;

procedure TTasOrderPrintShop.Sb_Exc_AnotacaoClick(Sender: TObject);
begin
  inherited;
  if validaDeleteAnnotation then
  Begin
     DeleteAnnotation;
     EditionStateAnnotation := 'B';
     EditionControlAnnotation;

  End;
end;

procedure TTasOrderPrintShop.Sb_Grv_AnotacaoClick(Sender: TObject);
begin
  if validaSaveAnnotation then
  Begin
    SaveAnnotation;
    EditionStateAnnotation := 'B';
    EditionControlAnnotation;

  End;

end;

procedure TTasOrderPrintShop.Sb_ImprimirClick(Sender: TObject);
begin
  Imprimir;
end;

procedure TTasOrderPrintShop.Sb_Ins_AnotacaoClick(Sender: TObject);
begin
  if validaInsertAnnotation then
  Begin
    EditionStateAnnotation := 'I';
    EditionControlAnnotation;
    LimpaCampoAnotacao;
    E_Ann_Reference.SetFocus;
  End;
end;

procedure TTasOrderPrintShop.setPerfil;
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

procedure TTasOrderPrintShop.ShowData;
begin
  ShowDataPrintShop;
  ShowListDataAnotacao;
end;

procedure TTasOrderPrintShop.ShowDataAnotacao;
begin
  if Cds_Anotacao.Active then
  Begin
    if Cds_AnotacaoID.AsInteger > 0 then
    Begin
      PrintShop.Anotacao.Registro.Codigo := Cds_AnotacaoID.AsInteger;
      PrintShop.Anotacao.Registro.Identificar := Cds_AnotacaoIDENTIFY.AsString;
      PrintShop.Anotacao.getByKey;
      E_Ann_Reference.Text  := PrintShop.Anotacao.Registro.Referencia;
      E_Ann_Obs.Text        := PrintShop.Anotacao.Registro.Observacao;
    End;
  End;
end;

procedure TTasOrderPrintShop.ShowListDataAnotacao;
Var
  I : Integer;
begin
  PrintShop.Anotacao.Registro.Identificar := 'TB_PRINT_SHOP_OS';
  PrintShop.Anotacao.Registro.Link1 := PrintShop.Registro.Codigo;
  PrintShop.Anotacao.getList;
  if not Cds_Anotacao.Active then Cds_Anotacao.CreateDataSet;
  Cds_Anotacao.EmptyDataSet;
  for I := 0 to PrintShop.Anotacao.Lista.Count-1 do
  Begin
    Cds_Anotacao.Append;
    Cds_AnotacaoID.AsInteger          := PrintShop.Anotacao.Lista[I].Codigo;
    Cds_AnotacaoIDENTIFY.AsString     := PrintShop.Anotacao.Lista[I].Identificar;
    Cds_AnotacaoLINK_ID1.AsInteger    := PrintShop.Anotacao.Lista[I].Link1;
    Cds_AnotacaoLINK_ID2.AsInteger    := PrintShop.Anotacao.Lista[I].Link2;
    Cds_AnotacaoREFERENCE.AsString    := PrintShop.Anotacao.Lista[I].Referencia;
    Cds_AnotacaoOBSERVATION.AsString  := PrintShop.Anotacao.Lista[I].Observacao;
    Cds_AnotacaoDT_RECORD.AsDateTime  := PrintShop.Anotacao.Lista[I].Data;
    Cds_Anotacao.Post;
  End;
  Cds_Anotacao.First;
  ShowDataAnotacao;
  EditionStateAnnotation := 'B';
  EditionControlAnnotation;
end;

procedure TTasOrderPrintShop.ShowDataPrintShop;
begin
  with PrintShop do
  Begin
    CB_Material.Text          := Registro.Material;
    CB_Fabricante.Text        := Registro.Fabricante;
    CB_Faca.Text              := Registro.Faca;
    E_Material_supplyed.Text  := Registro.MaterialFornecido;
    E_Material_used.Text      := Registro.MaterialUtilizado;
    E_Equipamentos.Text       := Registro.Equipamento;
    MM_Servico.Text           := Registro.Servico;
    MM_OutSourced.Text        := Registro.ServicoTercerizado;
    MM_Finishings.Text        := Registro.Acabamentos;
    MM_Note.Text              := Registro.Observacao;
    Fm_ListaSituacao.DBLCB_Situacao.KeyValue := Registro.situacao;
    Fm_ListaTecnico.Dblcb_Vendedor.KeyValue := Registro.Responsavel;

    if registro.DataPrevista >0 then
      E_Dt_Prevista.Text := DateToStr(registro.DataPrevista)
    else
      E_Dt_Prevista.Clear;

    if registro.HoraPrevista >0 then
      E_Hr_Prevista.Text := Copy( TimeToStr(registro.HoraPrevista),1,5)
    else
      E_Hr_Prevista.Clear;

    if registro.DataFinal >0 then
      E_Dt_Final.Text := DateToStr(registro.DataFinal)
    else
      E_Dt_Final.Clear;

    if registro.HoraFinal >0 then
      E_Hr_Final.Text := Copy( TimeToStr(registro.HoraFinal),1,5)
    else
      E_Hr_Final.Clear;

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

function TTasOrderPrintShop.validaDeleteAnnotation: Boolean;
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

function TTasOrderPrintShop.validaEditAnnotation: Boolean;
begin
  Result := True;
  if not validaAnnotationHasItem then
  Begin
    Result := True;
    Exit;
  End;
end;

function TTasOrderPrintShop.ValidaImprimir: Boolean;
begin
  REsult := True;
end;

function TTasOrderPrintShop.ValidaImprimirOrdemComValores: Boolean;
begin
  REsult := True;
end;

function TTasOrderPrintShop.ValidaImprimirOrdemSemValores: Boolean;
begin
  REsult := True;
  if Fm_ListaTecnico.Dblcb_Vendedor.Text = '' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não foi informado o Responsável.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

  if (E_Dt_Final.Text = '  /  /    ') then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não foi informado a Data Final.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

end;

function TTasOrderPrintShop.validaAnnotationHasItem: Boolean;
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

function TTasOrderPrintShop.validaCancelAnnotation: Boolean;
begin
  Result := True;
end;

function TTasOrderPrintShop.validaInsertAnnotation: Boolean;
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

function TTasOrderPrintShop.validaSaveAnnotation: Boolean;
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

function TTasOrderPrintShop.ValidateCancel: Boolean;
begin
  REsult := True;
end;

function TTasOrderPrintShop.ValidateChange: Boolean;
begin
  Result := True;
end;

function TTasOrderPrintShop.ValidateDelete: boolean;
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



function TTasOrderPrintShop.ValidateSave: Boolean;
Var
  Lc_Escolha : Integer;
begin
  REsult := True;
  if Trim(CB_Material.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Material não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if CB_Material.CanFocus then CB_Material.SetFocus;
    Exit;
  end;

  if Trim(CB_Fabricante.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Fabricante não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if CB_Fabricante.CanFocus then CB_Fabricante.SetFocus;
   Exit;
  end;

  if Trim(CB_Faca.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Faca não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if CB_Faca.CanFocus then CB_Faca.SetFocus;
   Exit;
  end;

  if Trim(E_Material_supplyed.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Material Utilizado não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if E_Material_supplyed.CanFocus then E_Material_supplyed.SetFocus;
   Exit;
  end;

  if Trim(E_Equipamentos.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Equipamento não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if E_Equipamentos.CanFocus then E_Equipamentos.SetFocus;
   Exit;
  end;

  if Trim(MM_Servico.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Campo serviço não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if MM_Servico.CanFocus then MM_Servico.SetFocus;
   Exit;
  end;

  if Trim(Fm_ListaSituacao.DBLCB_Situacao.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Campo Situação não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   Fm_ListaSituacao.DBLCB_Situacao.SetFocus;
   Exit;
  end;


  if (E_Dt_Final.Text <> '  /  /    ') or (E_Hr_Final.Text <> '  :  ')  then
  Begin
    if (E_Dt_Final.Text = '  /  /    ') then
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Como o campo hora final preenchido é obrigatório preencher a data também.'+EOLN+
                     'Preencha para continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      E_Dt_final.SetFocus;
      result:=False;
      Exit;
    End;

    if (E_Hr_Final.Text = '  :  ')  then
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Como o campo data final preenchido é obrigatório preencher a hora..'+EOLN+
                     'Preencha para continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      E_Hr_Final.SetFocus;
      result:=False;
      Exit;
    End;

    if Fm_ListaTecnico.Dblcb_Vendedor.Text = '' then
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Como o campo data final preenchido é obrigatório preencher o nome do responsável.'+EOLN+
                     'Preencha para continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      Fm_ListaTecnico.Dblcb_Vendedor.SetFocus;
      result:=False;
      Exit;

    End;

  End;



end;

end.
