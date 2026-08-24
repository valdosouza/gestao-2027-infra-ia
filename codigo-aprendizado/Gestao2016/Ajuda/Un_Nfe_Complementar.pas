unit Un_Nfe_Complementar;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, StdCtrls, ComCtrls, Mask, QEdit_Setes, ExtCtrls, STQuery, ACBrNFe, ACBrNFeDANFEClass, ACBrNFeDANFeRLClass, DB, ControllerNotaFiscal, Vcl.Menus, Vcl.DBCtrls, Vcl.Grids, ControllerRetornoNFe;


type
  TFr_Complementar = class(TForm)
    Pnl_totais: TPanel;
    Label22: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label1: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label38: TLabel;
    Label37: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    E_Vl_Bs_Icms_St: TEdit_Setes;
    E_Vl_Icms_St: TEdit_Setes;
    E_Vl_Seguro: TEdit_Setes;
    E_Vl_Outras: TEdit_Setes;
    E_VL_TL_Produto: TPanel;
    E_VL_ICMS: TEdit_Setes;
    E_VL_Bs_ICMS: TEdit_Setes;
    E_VL_IPI: TEdit_Setes;
    E_VL_Frete: TEdit_Setes;
    E_VL_Servico: TPanel;
    E_VL_Nota: TPanel;
    E_Qt_Produto: TEdit_Setes;
    E_Especie: TEdit;
    E_PesoLiq: TEdit_Setes;
    E_PesoBruto: TEdit_Setes;
    E_PlacaVeiculo: TMaskEdit;
    E_Uf_Veiculo: TEdit;
    E_RNTC: TEdit;
    E_Marca: TEdit;
    E_vol_Numero: TEdit;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    E_Dt_Saida: TDateTimePicker;
    E_Dt_Emissao: TDateTimePicker;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    sb_enviar: TSpeedButton;
    E_Obs: TMemo;
    chbx_data_saida: TCheckBox;
    Qr_Nota: TSTQuery;
    Qr_ItensNota: TSTQuery;
    StrGrd_Itens: TStringGrid;
    Pnl_Edicao_Item: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    E_Item_Bs_ICMS_ST: TEdit_Setes;
    E_Item_vl_ICMS_ST: TEdit_Setes;
    E_Item_Vl_Seguro: TEdit_Setes;
    E_Item_Vl_Despesas: TEdit_Setes;
    E_Item_VL_ICMS: TEdit_Setes;
    E_Item_Bs_ICMS: TEdit_Setes;
    E_Item_VL_Frete: TEdit_Setes;
    Label15: TLabel;
    E_Item_Aliq_ICMS: TEdit_Setes;
    Label14: TLabel;
    Label16: TLabel;
    E_Item_VL_IPI: TEdit_Setes;
    E_Item_Bs_IPI: TEdit_Setes;
    Label17: TLabel;
    E_Item_Aliq_IPI: TEdit_Setes;
    Lb_DescricaoProduto: TLabel;
    Sb_Sair_1: TBitBtn;
    SB_Gravar: TBitBtn;
    Lb_Nr_Registro: TLabel;
    Chbx_Frete: TCheckBox;
    Chbx_Seguro: TCheckBox;
    Chbx_Outras: TCheckBox;
    PopupMenu1: TPopupMenu;
    Editar1: TMenuItem;
    Label18: TLabel;
    Label19: TLabel;
    Dblcb_Situacao_tributaria: TDBLookupComboBox;
    Dblcb_Simples_Nacional: TDBLookupComboBox;
    QR_TRIB_NR: TSTQuery;
    ds_trib_nr: TDataSource;
    QR_TRIB_SN: TSTQuery;
    DS_TRIB_SN: TDataSource;
    Label20: TLabel;
    DBLCB_Natureza: TDBLookupComboBox;
    Ds_Natureza: TDataSource;
    Label21: TLabel;
    Label23: TLabel;
    Dblcb_Modal_ICMS_ST: TDBLookupComboBox;
    Dblcb_Modal_ICMS: TDBLookupComboBox;
    qr_bs_icms: TSTQuery;
    ds_bs_icms: TDataSource;
    qr_bs_icms_st: TSTQuery;
    ds_bs_icms_st: TDataSource;
    Label24: TLabel;
    E_VL_Produto: TEdit_Setes;
    Label39: TLabel;
    E_Qtde: TEdit_Setes;
    pnl_button: TPanel;
    pnl_button_left: TPanel;
    Panel1: TPanel;
    pnl_top: TPanel;
    Label40: TLabel;
    E_P_MVA: TEdit_Setes;
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure sb_enviarClick(Sender: TObject);
    procedure E_VL_FreteExit(Sender: TObject);
    procedure E_Vl_SeguroExit(Sender: TObject);
    procedure E_Vl_OutrasExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StrGrd_ItensDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure SB_GravarClick(Sender: TObject);
    procedure Sb_Sair_1Click(Sender: TObject);
    procedure E_Item_Bs_ICMSExit(Sender: TObject);
    procedure E_Item_Aliq_ICMSExit(Sender: TObject);
    procedure E_Item_Bs_ICMS_STExit(Sender: TObject);
    procedure E_Item_vl_ICMS_STExit(Sender: TObject);
    procedure E_Item_VL_FreteExit(Sender: TObject);
    procedure E_Item_Vl_SeguroExit(Sender: TObject);
    procedure E_Item_Vl_DespesasExit(Sender: TObject);
    procedure E_Item_Bs_IPIExit(Sender: TObject);
    procedure E_Item_Aliq_IPIExit(Sender: TObject);
    procedure Editar1Click(Sender: TObject);
    procedure StrGrd_ItensDblClick(Sender: TObject);
    procedure qr_bs_icmsAfterOpen(DataSet: TDataSet);
    procedure qr_bs_icms_stAfterOpen(DataSet: TDataSet);
    procedure QR_TRIB_SNAfterOpen(DataSet: TDataSet);
    procedure QR_TRIB_NRAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    RetornoNFE : TControllerRetornoNFe;
    procedure Pc_ItensProdutos;
    { Private declarations }
  public
    { Public declarations }
     NotaFiscal : TControllerNotaFiscal;
     It_Aq_Rd_BC_ICMS:double;
     It_Vl_Bc_ICMS:double;
     It_Aq_Nr_ICMS:double;
     It_Aq_Rd_Nr_ICMS:double;
     It_VL_Nr_ICMS:double;
     It_Aq_Rd_Bc_St_ICMS:double;
     It_VL_Bc_St_ICMS:double;
     It_Aq_Rd_St_ICMS:double;
     It_Vl_St_ICMS:double;
     It_CodDsi_ICMS:Integer;
     It_VL_Bc_St_Ret_ICMS:double;
     It_CODORIGEM:String;

     It_VL_St_Ret_ICMS:double;
     It_Partilha:String;
     It_Repasse_ICMS:String;
     It_Vl_Bc_Ret_ICMS:double;
     It_Vl_Ret_ICMS:double;
     It_Aq_Calc_Cred_ICMS:double;
     It_VL_Cred_Apro_ICms:double;
     It_VL_frete_Produto:double;
     It_Vl_Seguro_Produto:double;
     It_Vl_Outras_Produto:double;
     It_Dest_ICMS:String;
     It_Cd_Observacao:Integer;

    It_CodTbI_IPI:Integer;
    It_Cl_Enqd_IPI:String;
    It_CNPJ_PROD_IPI:String;
    It_CD_SELO_IPI:String;
    It_QT_SELO_IPI:Double;
    It_CD_ENQD_IPI:String;
    It_VL_BC_IPI:Double;
    It_AQ_NR_IPI:Double;
    It_QT_UNID_IPI:Double;
    It_VL_UNID_IPI:Double;

     it_Cd_Crt : Integer;

     It_Cd_Nota_Ant: Integer;

     It_cd_itf:Integer;


     It_vl_frete:Double;
     It_vl_seguro:Double;
     It_vl_outros:Double;
     It_vl_ipi:Double;
     It_Vl_PProduto : Double;
     It_Oper_Item : String;
    procedure Pc_MontaGradeItens;
    procedure Pc_MostrarItensGrade;
    procedure Pc_ControlaInterface(Pc_Tipo : Boolean);
    procedure Pc_MostrarItensEdicao(Pc_Linha:Integer);
    procedure Pc_SalvaItensEdicao(Pc_Linha:Integer);
    PROCEDURE Pc_NovaNota;
    procedure Pc_LimpaCampos;
    procedure Pc_DistribuiValores;
    procedure Pc_CalculaItemICMS;
    procedure Pc_CalculaItemIPI;
    procedure Pc_SomaItensGrande;
    procedure Pc_TotalNota;

    procedure Pc_GravaItens;
    procedure Pc_GravaItensProdutos(Pc_I:Integer);
    procedure Pc_GravaItensICMS(Pc_I:Integer);
    procedure Pc_GravaItensIPI(Pc_I:Integer);

    procedure PC_InsereDocReceber;


    procedure Pc_ImagemBotao;
    Function Fc_ValidaGeracao():Boolean;
  end;

var
  Fr_Complementar: TFr_Complementar;

implementation

uses
Un_DM, un_sistema, UN_MSG, un_padrao, Un_Fc_Sored_Procedures, Un_Regra_Negocio, RN_NotaFiscalEletronica3X, Un_Funcoes, RN_Permissao, ControllerFinanceiro, UN_Principal, env, tas_gera_nfe_autorizacao;

{$R *.dfm}

procedure TFr_Complementar.SB_Sair_0Click(Sender: TObject);
begin
  CLOSE;
end;

procedure TFr_Complementar.Pc_MontaGradeItens;
Begin
  //Grade dos Despachados
  with StrGrd_Itens do
    Begin
    ColWidths[0]  := 17;
    ColWidths[1]  := -1;
    Cols[2].Add('Selecionar');
    ColWidths[2]  := 54;
    ColWidths[3]  := -1;
    Cols[4].Add('Cód. Produto');
    ColWidths[4]  := 120;
    Cols[5].Add('Descrição do produto');
    ColWidths[5]  := 370;
    Cols[6].Add('Número NCM');
    ColWidths[6]  := 80;
    //ICMS
    Cols[7].Add('Base ICMS');
    ColWidths[7]  := -1;
    Cols[8].Add('Aliq ICMS');
    ColWidths[8]  := -1;
    Cols[9].Add('Valor ICMS');
    ColWidths[9]  := -1;
    //ICMS ST
    Cols[10].Add('Base ICMS ST');
    ColWidths[10]  := -1;
    Cols[11].Add('Valor ICMS ST');
    ColWidths[11]  := -1;
    //Frete
    Cols[12].Add('Valor Frete');
    ColWidths[12]  := -1;
    //Seguro
    Cols[13].Add('Valor Seguro');
    ColWidths[13]  := -1;
    //Outras
    Cols[14].Add('Outras Despesao');
    ColWidths[14]  := -1;
    //IPI
    Cols[15].Add('Base IPI');
    ColWidths[15]  := -1;
    Cols[16].Add('Aliq IPI');
    ColWidths[16]  := -1;
    Cols[17].Add('Valor IPI');
    ColWidths[17]  := -1;
    //CFOP
    Cols[18].Add('cfop');
    ColWidths[18]  := -1;
    //ITF_codigo Anterior
    Cols[19].Add('itf_anterior');
    ColWidths[19]  := -1;
    end;
end;

procedure TFr_Complementar.Pc_MostrarItensGrade;
Var
  Lc_registro : Integer;
  Lc_I,Lc_J : Integer;
Begin
  //Buscar itens do Pedido
  Screen.Cursor := crHourGlass;
  Lc_registro := 0;
  For Lc_I:= 1 to (StrGrd_Itens.RowCount - 1) do
    For Lc_J:= 0 to StrGrd_Itens.ColCount do
      StrGrd_Itens.Cells[Lc_J,Lc_I] := '';
  StrGrd_Itens.RowCount := 2;

  while not Qr_ItensNota.Eof do
  Begin
    Lc_registro := Lc_registro + 1;
    StrGrd_Itens.RowCount := Lc_registro + 1;
    StrGrd_Itens.Cells[1,Lc_registro] := Qr_ItensNota.FieldByName('ITF_CODPRO').AsString;
    StrGrd_Itens.Cells[4,Lc_registro] := Qr_ItensNota.FieldByName('PRO_CODIGOFAB').AsString;
    StrGrd_Itens.Cells[5,Lc_registro] := Qr_ItensNota.FieldByName('PRO_DESCRICAO').AsString;
    StrGrd_Itens.Cells[6,Lc_registro] := Qr_ItensNota.FieldByName('PRO_CODIGONCM').AsString;
    StrGrd_Itens.Cells[18,Lc_registro] := Qr_ItensNota.FieldByName('NAT_CODIGO').AsString;
    StrGrd_Itens.Cells[19,Lc_registro] := Qr_ItensNota.FieldByName('ITF_CODIGO').AsString;

    StrGrd_Itens.Cells[21,Lc_registro] := Qr_ItensNota.FieldByName('ICM_CODTBI_NR').AsString;
    StrGrd_Itens.Cells[22,Lc_registro] := Qr_ItensNota.FieldByName('ICM_CODTBI_SN').AsString;
    StrGrd_Itens.Cells[23,Lc_registro] := Qr_ItensNota.FieldByName('ICM_CODNAT').AsString;
    StrGrd_Itens.Cells[24,Lc_registro] := Qr_ItensNota.FieldByName('ICM_MD_BC_NR').AsString;
    StrGrd_Itens.Cells[25,Lc_registro] := Qr_ItensNota.FieldByName('ICM_MD_BC_ST').AsString;
    StrGrd_Itens.Cells[26,Lc_registro] := '0';
    StrGrd_Itens.Cells[27,Lc_registro] := '0,00';
    StrGrd_Itens.Cells[28,Lc_registro] := '0';
    StrGrd_Itens.Cells[29,Lc_registro] := Qr_ItensNota.FieldByName('PRO_ORIGEM').AsString;
    StrGrd_Itens.Cells[30,Lc_registro] := Qr_ItensNota.FieldByName('ITF_OPER').AsString;
    StrGrd_Itens.Cells[31,Lc_registro] := Qr_ItensNota.FieldByName('ICM_MG_VA_ST').AsString;
    Qr_ItensNota.Next;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Complementar.Pc_MostrarItensEdicao(Pc_Linha:Integer);
Var
  Lc_Valor : Real;
Begin
  //Grade dos Despachados
  with StrGrd_Itens do
  Begin
    Lb_Nr_Registro.Caption := IntToStr(Pc_Linha);
    Lb_DescricaoProduto.Caption := Cells[5,Pc_linha];
    //ICMS
    Lc_Valor := StrToFloatDef(Cells[7,Pc_linha],0);
    E_Item_Bs_ICMS.Text := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    Lc_Valor := StrToFloatDef(Cells[8,Pc_linha],0);
    E_Item_Aliq_ICMS.Text :=  FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    Lc_Valor := StrToFloatDef(Cells[9,Pc_linha],0);
    E_Item_VL_ICMS.Text := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    //ICMS ST
    Lc_Valor := StrToFloatDef(Cells[10,Pc_linha],0);
    E_Item_Bs_ICMS_ST.Text := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    Lc_Valor := StrToFloatDef(Cells[11,Pc_linha],0);
    E_Item_vl_ICMS_ST.Text := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    //Frete
    Lc_Valor := StrToFloatDef(Cells[12,Pc_linha],0);
    E_Item_VL_Frete.Text := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    //Seguro
    Lc_Valor := StrToFloatDef(Cells[13,Pc_linha],0);
    E_Item_Vl_Seguro.Text := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    //Outras
    Lc_Valor := StrToFloatDef(Cells[14,Pc_linha],0);
    E_Item_Vl_Despesas.Text := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    //IPI
    Lc_Valor := StrToFloatDef(Cells[15,Pc_linha],0);
    E_Item_Bs_IPI.Text := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    Lc_Valor := StrToFloatDef(Cells[16,Pc_linha],0);
    E_Item_Aliq_IPI.Text := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    Lc_Valor := StrToFloatDef(Cells[17,Pc_linha],0);
    E_Item_VL_IPI.Text :=  FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    //CST
    if Dblcb_Situacao_tributaria.Enabled then
      Dblcb_Situacao_tributaria.KeyValue := StrToIntDef(Cells[21,Pc_linha],0);
    //CSOSN
    if Dblcb_Simples_Nacional.Enabled then
      Dblcb_Simples_Nacional.KeyValue := StrToIntDef(Cells[22,Pc_linha],0);
    //CFOP
    DBLCB_Natureza.KeyValue := StrToIntDef(Cells[23,Pc_linha],0);
    //Modalidade bc ICMS
    Dblcb_Modal_ICMS.KeyValue := StrToIntDef(Cells[24,Pc_linha],0);
    //Modalidade bc ICMS ST
    Dblcb_Modal_ICMS_ST.KeyValue := StrToIntDef(Cells[25,Pc_linha],0);
    //Quantidade Produto
    Lc_Valor := StrToFloatDef(Cells[26,Pc_linha],0);
    E_Qtde.Text := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    //Valor Produto
    Lc_Valor := StrToFloatDef(Cells[27,Pc_linha],0);
    E_VL_Produto.Text := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    //MVA
    Lc_Valor := StrToFloatDef(Cells[31,Pc_linha],0);
    E_P_MVA.Text := FloatToStrF(Lc_Valor,ffFixed,10,2) ;

    end;
  Pnl_Edicao_Item.Visible := True;
  StrGrd_Itens.Enabled := False;
  Pnl_totais.Enabled := False;
  E_Obs.Enabled := False;
end;

procedure TFr_Complementar.Pc_SalvaItensEdicao(Pc_Linha:Integer);
Var
  Lc_valor : Real;
Begin
  //Grade dos Despachados
  with StrGrd_Itens do
  Begin
    Lb_Nr_Registro.Caption := '00';
    //ICMS
    Lc_valor := StrToFloatDef(E_Item_Bs_ICMS.Text,0);
    Cells[7,Pc_linha] := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    Lc_valor := StrToFloatDef( E_Item_Aliq_ICMS.Text,0);
    Cells[8,Pc_linha] := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    Lc_valor := StrToFloatDef(E_Item_VL_ICMS.Text,0);
    Cells[9,Pc_linha] := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    //ICMS ST
    Lc_valor := StrToFloatDef(E_Item_Bs_ICMS_ST.Text,0);
    Cells[10,Pc_linha] := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    Lc_valor := StrToFloatDef(E_Item_vl_ICMS_ST.Text,0);
    Cells[11,Pc_linha] := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    //Frete
    Lc_valor := StrToFloatDef(E_Item_VL_Frete.Text,0);
    Cells[12,Pc_linha] := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    //Seguro
    Lc_valor := StrToFloatDef(E_Item_Vl_Seguro.Text,0);
    Cells[13,Pc_linha] := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    //Outras
    Lc_valor := StrToFloatDef(E_Item_Vl_Despesas.Text,0);
    Cells[14,Pc_linha] := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    //IPI
    Lc_valor := StrToFloatDef(E_Item_Bs_IPI.Text,0);
    Cells[15,Pc_linha] := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    Lc_valor := StrToFloatDef(E_Item_Aliq_IPI.Text,0);
    Cells[16,Pc_linha] := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    Lc_valor := StrToFloatDef(E_Item_VL_IPI.Text,0);
    Cells[17,Pc_linha] := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    //CST
    if Dblcb_Situacao_tributaria.Enabled then
      Cells[21,Pc_linha] := IntToStr(Dblcb_Situacao_tributaria.KeyValue);
    //CSOSN
    if Dblcb_Simples_Nacional.Enabled then
      Cells[22,Pc_linha] := IntToStr(Dblcb_Simples_Nacional.KeyValue);
    //CFOP
    Cells[23,Pc_linha] := IntToStr(DBLCB_Natureza.KeyValue);
    //Modalidade bc ICMS
    Cells[24,Pc_linha] := IntToStr(Dblcb_Modal_ICMS.KeyValue);
    //Modalidade bc ICMS ST
    Cells[25,Pc_linha] := IntToStr(Dblcb_Modal_ICMS_ST.KeyValue);
    //Quantidade
    Lc_valor := StrToFloatDef(E_Qtde.Text,0);
    Cells[26,Pc_linha] := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    //Produto
    Lc_valor := StrToFloatDef(E_VL_Produto.Text,0);
    Cells[27,Pc_linha] := FloatToStrF(Lc_Valor,ffFixed,10,2) ;
    //MVA
    Lc_valor := StrToFloatDef(E_P_MVA.Text,0);
    Cells[31,Pc_linha] := FloatToStrF(Lc_Valor,ffFixed,10,2) ;

  end;
end;

procedure TFr_Complementar.Pc_NovaNota;
var
  lc_tipo:String;
  Lc_Data : String;
  Lc_Cd_CFOP : Integer;
  Lc_I:Integer;
begin
  For Lc_I:= 1 to StrGrd_Itens.RowCount - 1 do
  Begin
    if StrGrd_Itens.Cells[3,lc_I] = 'X' then
    Begin
      Lc_Cd_CFOP := StrToIntDef(StrGrd_Itens.Cells[18,Lc_I],0);
      break;
    end;
  end;
  lc_tipo:='';
  if Qr_Nota.fieldbyname('NFL_TIPO').AsString = 'SI' THEN
    lc_tipo := 'SC'  //saida complementar
  else
  if Qr_Nota.fieldbyname('NFL_TIPO').AsString = 'EI' THEN
    lc_tipo := 'EC'  //entrada complementar
  else
  BEGIN
    ShowMessage('Essa nota não pode ter uma complementar');
    EXIT;
  END;

  with NotaFiscal do
  BEgin
    Registro.Codigo                 := 0;
    Registro.CodigoEstabelecimento  := Gb_CodMha;
    Registro.Tipo                   := lc_tipo;
    Registro.Finalidade             := '2';
    Registro.Serie                  := Fc_Tb_Geral('L','NFE_SERIE','1');
    Registro.CodigoCFOP             := Lc_Cd_CFOP;
    Registro.Numero                 := StrZero(Fc_GeraNumeroNota,6,0);
    Registro.CodigoPedido           := Qr_Nota.fieldbyname('NFL_CODPED').AsInteger;
    Registro.CodigoEmpresa          := Qr_Nota.fieldbyname('EMP_CODIGO').AsInteger;
    Registro.DataEmissao            := E_Dt_Emissao.Date;
    if chbx_data_saida.Checked then
      Registro.DataSaida            := E_Dt_Saida.Date;
    Registro.HoraSaida              := Now;
    Registro.ValorBaseICMS          := StrToFloatDef(E_VL_Bs_ICMS.Text,0);
    Registro.ValorICMS              := StrToFloatDef(E_Vl_Icms.Text,0);
    Registro.ValorBaseICMSST        := StrToFloatDef(E_Vl_Bs_Icms_St.Text,0);
    Registro.ValorICMSST            := StrToFloatDef(E_Vl_Icms_St.Text,0);
    Registro.ValorProdutos          := StrToFloatDef(E_VL_TL_Produto.Caption,0);
    Registro.ValorFrete             := StrToFloatDef(E_VL_Frete.Text,0);
    Registro.ValorSeguro            := StrToFloatDef(E_Vl_Seguro.Text,0);
    Registro.ValorOutrasDespesas    := StrToFloatDef(E_Vl_Outras.Text,0);
    Registro.ValorIPI               := StrToFloatDef(E_VL_IPI.Text,0);
    Registro.ValorNota              := StrToFloatDef(E_VL_Nota.Caption,0);
    Registro.CodigoTransportadora   := Qr_Nota.fieldbyname('PED_CODTRP').AsInteger;
    Registro.ContaFrete             := 3;
    Registro.QtdeProdutos           := StrToFloatDef(E_Qt_Produto.Text,0);
    Registro.Especie                := E_Especie.Text;
    Registro.Marca                  := E_Marca.Text;
    Registro.PesoBruto              := E_PesoBruto.Text;
    Registro.PesoLiquido            := E_PesoLiq.Text;
    Registro.ControlaRetorno        := 'N';
    Registro.NotaVinculada          := Qr_Nota.fieldbyname('nfl_numero').value;
    Registro.Situacao               := 'F';
    Registro.CodigoPedidoAnterior   := '0';
    Registro.ValorServico           := StrToFloatDef(E_VL_Servico.Caption,0);
    Registro.ValorISS               := 0;
    Registro.NumeroVolume           := E_vol_Numero.Text;
    Registro.PlacaVeiculo           := E_PlacaVeiculo.Text;
    Registro.EstadoVeiculo          := E_Uf_Veiculo.Text;
    Registro.RNTC                   := Copy(E_RNTC.Text,1,20);
    Registro.CFOP                   := Copy(DBLCB_Natureza.Text,1,4);
    Registro.ValorISSRetido         := 0;
    Registro.Modelo                 := '55';
  End;
  NotaFiscal.insere;

  if Length(E_Obs.Text) > 0 then
  Begin
    with NotaFiscal.Observacoes do
    Begin
      Registro.Codigo   := 0;
      Registro.ItemNota := 0;
      Registro.Nota     := NotaFiscal.Registro.Codigo;
      Registro.Tipo     := 'M';
      Registro.Conteudo := E_Obs.Text
    End;
    NotaFiscal.Observacoes.insert;
  end;
end;

procedure TFr_Complementar.FormShow(Sender: TObject);
begin
  QR_TRIB_NR.Active:=True;
  QR_TRIB_SN.Active:=True;
  qr_bs_icms.Active:=True;
  Dblcb_Modal_ICMS.KeyValue := 4;
  qr_bs_icms_st.Active:=True;
  Dblcb_Modal_ICMS_ST.KeyValue := 4;
  Pc_AtivaEstabelecimento;
  It_Cd_CRT := StrToIntDef(DM.Qr_Estabelecimento.FieldByname('EMP_CRT').AsString,3);
  if (It_Cd_CRT < 2) then
  Begin
    Dblcb_Situacao_tributaria.KeyValue := 0;
    Dblcb_Situacao_tributaria.Enabled := False;
    Dblcb_Simples_Nacional.Enabled := True;
  end
  else
  Begin
    Dblcb_Simples_Nacional.KeyValue := 0;
    Dblcb_Simples_Nacional.Enabled := False;
    Dblcb_Situacao_tributaria.Enabled := True;
  end;
   E_Dt_Saida.Date:=Now;
  E_Dt_Emissao.Date:=Now;
  E_VL_Servico.Caption:=  FormatFloat('0.00',0);
  E_VL_TL_Produto.Caption:=  FormatFloat('0.00',0);
  E_VL_Nota.Caption:=   FormatFloat('0.00',0);

  Pc_MontaGradeItens;

  sb_enviar.Enabled:=false;
  SB_Confirmar.Enabled:=True;
  Pc_LimpaCampos;
  Pc_ImagemBotao;
  Qr_Nota.Active := False;
  Qr_Nota.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota_Ant;
  Qr_Nota.Active := True;
  if (Copy(Qr_Nota.FieldByName('NFL_TIPO').AsString,1,1) = 'E') then
    Pc_Filtra_CFOP('E',Fc_AchaEndereco(Qr_Nota.FieldByName('PED_CODIGO').AsInteger))
  else
    Pc_Filtra_CFOP('S',Fc_AchaEndereco(Qr_Nota.FieldByName('PED_CODIGO').AsInteger));

  Qr_ItensNota.Active := False;
  Qr_ItensNota.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota_Ant;
  Qr_ItensNota.Active := True;
  Pc_MostrarItensGrade;
end;

procedure TFr_Complementar.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    sb_enviar.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    SB_Confirmar.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

Function TFr_Complementar.Fc_ValidaGeracao():Boolean;
Begin
  Result := true;
end;

procedure TFr_Complementar.SB_ConfirmarClick(Sender: TObject);
begin
  E_VL_Nota.SetFocus;
  Pc_DistribuiValores;
  Pc_SomaItensGrande;
  if Fc_ValidaGeracao then
  Begin
    Pc_CarregaDadosEmitente(true);
    Pc_NovaNota;
    Pc_GravaItens;

    if (Qr_Nota.FieldByName('PED_TIPO').AsInteger = 1) and  (StrToFloatDef(E_VL_Nota.Caption,0) >0) then
      PC_InsereDocReceber;
    with RetornoNFE do
    Begin
      Registro.NotaFiscal :=NotaFiscal.Registro.Codigo;
      getByNotaFiscal;
      Registro.NotaFiscal      := NotaFiscal.Registro.Codigo;
      Registro.Serie           := StrToIntDef(NotaFiscal.Registro.Serie,1);
      Registro.Situacao        := 0;
      Registro.NomeArquivo     := '';
      Registro.NumeroInicial   := NotaFiscal.Registro.Numero;
      Registro.NumeroFinal     := NotaFiscal.Registro.Numero;
      Registro.Estabelecimento := NotaFiscal.Registro.CodigoEstabelecimento;
      salva;
    End;

      MensagemPadrao(MENSAGEM,'S U C E S S O !.'+EOLN+EOLN+
                   'Nota Fiscal Gravada com Sucesso.'+EOLN+
                   '  Clique em OK para continuar.'+EOLN,
                   ['OK'],[bEscape],mpInformacao);
    SB_Confirmar.Enabled:=false;
    sb_enviar.Enabled:=true;
  end;
end;

procedure TFr_Complementar.sb_enviarClick(Sender: TObject);
var
  Lc_Form : TTasGeraNfeAutorizacao;
begin
  Lc_Form := TTasGeraNfeAutorizacao.Create(Self);
  try
    TRy
      Lc_Form.It_Cd_Pedido      := 0;
      Lc_Form.It_cd_Cliente     := Qr_Nota.FieldByname('EMP_CODIGO').AsInteger;
      Lc_Form.It_cd_Consumidor  := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
      Lc_Form.It_Cd_Nota        := NotaFiscal.Registro.Codigo;
      Lc_Form.It_Nr_Nota        := StrtoIntDef(NotaFiscal.Registro.Numero,0);
      Lc_Form.It_Nf_Terceiro    := FAlse;
      Lc_Form.ValorRecebido     := 0;
      Lc_Form.ValorTroco        := 0;
      //Operação Normal
      Pc_CarregaDadosEmitente(true);
      Lc_Form.TipoOperacao := 'NF-e';
      Lc_Form.ShowModal;
    except
      on e:Exception do
        MensagemPadrao('NMensagem de erro', ATENCAO + EOLN + EOLN +
                       e.Message + EOLN +
                       'Informe ao Desenvolvedor do Sistema.' + EOLN,
                       ['OK'], [bEscape], mpErro);
    End;
  finally
    FreeAndNil(Lc_Form);
    SetWindowPos(Gb_Handle,Hwnd_TopMost,0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or  SWP_SHOWWINDOW);
  end;
end;

procedure TFr_Complementar.Pc_ItensProdutos;
begin

end;

procedure TFr_Complementar.Pc_LimpaCampos;
begin
  E_Vl_Bs_Icms_St.Text:='0,00';
  E_Vl_Icms_St.Text:='0,00';
  E_Vl_Seguro.Text:='0,00';
  E_Vl_Outras.Text:='0,00';
  E_VL_ICMS.Text:='0,00';
  E_VL_Bs_ICMS.Text:='0,00';
  E_VL_IPI.Text:='0,00';
  E_Qt_Produto.Text:='0,00';
  E_PesoLiq.Text:='0,00';
  E_PesoBruto.Text:='0,00';

  It_VL_Bc_St_ICMS  :=  StrToFloatDef(E_Vl_Bs_Icms_St.Text,0);
  It_Vl_St_ICMS     :=  StrToFloatDef(E_Vl_Icms_St.Text,0);
  It_Vl_Bc_ICMS     :=  StrToFloatDef(E_VL_Bs_ICMS.Text,0);
  It_VL_Nr_ICMS     :=  StrToFloatDef(E_VL_ICMS.Text,0);
  It_vl_frete       :=  StrToFloatDef(E_VL_Frete.Text,0);
  It_vl_seguro      :=  StrToFloatDef(E_Vl_Seguro.Text,0);
  It_vl_outros      :=  StrToFloatDef(E_Vl_Outras.Text,0);
  It_vl_ipi         :=  StrToFloatDef(E_VL_IPI.Text,0);
end;

procedure TFr_Complementar.E_VL_FreteExit(Sender: TObject);
begin
  It_vl_frete:= StrToFloatDef(E_VL_Frete.Text,0);
  E_VL_Frete.Text:= FloatToStrF(It_vl_frete, ffFixed, 10, 2);
  Pc_TotalNota;
end;

procedure TFr_Complementar.E_Vl_SeguroExit(Sender: TObject);
begin
  It_vl_seguro:= StrToFloatDef(E_Vl_Seguro.Text,0);
  E_Vl_Seguro.Text:= FloatToStrF(It_vl_seguro, ffFixed, 10, 2);
  Pc_TotalNota;
end;

procedure TFr_Complementar.E_Vl_OutrasExit(Sender: TObject);
begin
  It_vl_outros:= StrToFloatDef(E_Vl_Outras.Text,0);
  E_Vl_Outras.Text:= FloatToStrF(It_vl_outros, ffFixed, 10, 2);
  Pc_TotalNota;
end;

procedure TFr_Complementar.Pc_CalculaItemICMS;
Var
  Lc_Valor : REal;
Begin
  Lc_valor := StrToFloatDef(E_Item_Bs_ICMS.Text,0);
  Lc_valor := (Lc_valor * StrToFloatDef(E_Item_Aliq_ICMS.Text,0)) / 100;
  E_Item_VL_ICMS.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
end;

procedure TFr_Complementar.Pc_CalculaItemIPI;
Var
  Lc_Valor : REal;
Begin
  Lc_valor := StrToFloatDef(E_Item_Bs_IPI.Text,0);
  Lc_valor := (Lc_valor * StrToFloatDef(E_Item_Aliq_IPI.Text,0)) / 100;
  E_Item_VL_IPI.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
end;

procedure TFr_Complementar.Pc_SomaItensGrande;
Var
  Lc_I : Integer;
  Lc_Valor : Real;
Begin
  It_Vl_Bc_ICMS := 0;
  It_VL_Nr_ICMS := 0;
  It_VL_Bc_St_ICMS := 0;
  It_Vl_St_ICMS := 0;
  It_vl_ipi := 0;
  It_vl_frete := 0;
  It_vl_seguro := 0;
  It_vl_outros := 0;
  It_Vl_PProduto := 0;

  For Lc_I:= 1 to (StrGrd_Itens.RowCount -1) do
  Begin
    if (StrGrd_Itens.Cells[3,Lc_I] = 'X') then
    Begin
      It_Vl_Bc_ICMS     := It_Vl_Bc_ICMS    + StrToFloatDef(StrGrd_Itens.Cells[7,Lc_I],0);
      It_VL_Nr_ICMS     := It_VL_Nr_ICMS    + StrToFloatDef(StrGrd_Itens.Cells[9,Lc_I],0);
      It_VL_Bc_St_ICMS  := It_VL_Bc_St_ICMS + StrToFloatDef(StrGrd_Itens.Cells[10,Lc_I],0);
      It_Vl_St_ICMS     := It_Vl_St_ICMS    + StrToFloatDef(StrGrd_Itens.Cells[11,Lc_I],0);
      It_vl_frete       := It_vl_frete      + StrToFloatDef(StrGrd_Itens.Cells[12,Lc_I],0);
      It_vl_seguro      := It_vl_seguro     + StrToFloatDef(StrGrd_Itens.Cells[13,Lc_I],0);
      It_vl_outros      := It_vl_outros     + StrToFloatDef(StrGrd_Itens.Cells[14,Lc_I],0);
      It_vl_ipi         := It_vl_ipi        + StrToFloatDef(StrGrd_Itens.Cells[17,Lc_I],0);
      It_Vl_PProduto    := It_Vl_PProduto   + ( StrToFloatDef(StrGrd_Itens.Cells[26,Lc_I],0) * StrToFloatDef(StrGrd_Itens.Cells[27,Lc_I],0) );
    end;
  end;
  E_VL_TL_Produto.Caption := FloatToStrF(It_Vl_PProduto,ffFixed,10,2);
  E_VL_Bs_ICMS.Text       := FloatToStrF(It_Vl_Bc_ICMS,ffFixed,10,2);
  E_VL_ICMS.Text          := FloatToStrF(It_VL_Nr_ICMS,ffFixed,10,2);
  E_Vl_Bs_Icms_St.Text    := FloatToStrF(It_VL_Bc_St_ICMS,ffFixed,10,2);
  E_Vl_Icms_St.Text       := FloatToStrF(It_Vl_St_ICMS,ffFixed,10,2);
  E_VL_Frete.Text         := FloatToStrF(It_vl_frete,ffFixed,10,2);
  E_Vl_Seguro.Text        := FloatToStrF(It_vl_seguro,ffFixed,10,2);
  E_Vl_Outras.Text        := FloatToStrF(It_vl_outros,ffFixed,10,2);
  E_VL_IPI.Text           := FloatToStrF(It_vl_ipi,ffFixed,10,2);
  Lc_Valor := It_Vl_PProduto + It_Vl_St_ICMS + It_vl_frete + It_vl_seguro + It_vl_outros + It_vl_ipi;
  E_VL_Nota.Caption := FloatToStrF(Lc_Valor,ffFixed,10,2);
end;

procedure TFr_Complementar.Pc_DistribuiValores;
Var
  Lc_I : Integer;
  Lc_Nr_Itens : Integer;
  Lc_Vl_Frete, Lc_Vl_Tl_Frete : Real;
  Lc_Vl_Seguro, Lc_Vl_Tl_Seguro : Real;
  Lc_Vl_Outras, Lc_Vl_Tl_Outras : Real;
  Lc_Contatdor : Integer;
Begin
  Lc_Nr_Itens := 0;
  For Lc_I:= 1 to (StrGrd_Itens.RowCount -1) do
    Begin
    if (StrGrd_Itens.Cells[3,Lc_I] = 'X') then
      Lc_Nr_Itens := Lc_Nr_Itens + 1;
    end;
  if (Lc_Nr_Itens > 0) then
    Begin
    if Chbx_Frete.Checked then
      Begin
      Lc_Contatdor := 0;
      Lc_Vl_Tl_Frete := StrToFloatDef(E_VL_Frete.Text,0);
      Lc_Vl_Frete := Lc_Vl_Tl_Frete / Lc_Nr_Itens;
      Lc_Vl_Frete :=  StrToFloatDef(FloatToStrF(Lc_Vl_Frete,ffFixed,10,2),0);
      For Lc_I:= 1 to (StrGrd_Itens.RowCount -1) do
        Begin
        if (StrGrd_Itens.Cells[3,Lc_I] = 'X') then
          Begin
          Lc_Contatdor := Lc_Contatdor + 1;
          if Lc_Contatdor = Lc_Nr_Itens then
            StrGrd_Itens.Cells[12,Lc_I] := FloatToStr(Lc_Vl_Tl_Frete - (Lc_Vl_Frete * (Lc_Nr_Itens - 1)))
          else
            StrGrd_Itens.Cells[12,Lc_I] := FloatToStr(Lc_Vl_Frete);
          end;
        end;
      end;

    if Chbx_Seguro.Checked then
      Begin
      Lc_Contatdor := 0;
      Lc_Vl_Tl_Seguro := StrToFloatDef(E_Vl_Seguro.Text,0);
      Lc_Vl_Seguro := Lc_Vl_Tl_Seguro / Lc_Nr_Itens;
      Lc_Vl_Seguro :=  StrToFloatDef(FloatToStrF(Lc_Vl_Seguro,ffFixed,10,2),0);
      For Lc_I:= 1 to (StrGrd_Itens.RowCount -1) do
        Begin
        if (StrGrd_Itens.Cells[3,Lc_I] = 'X') then
          Begin
          Lc_Contatdor := Lc_Contatdor + 1;
          if Lc_Contatdor = Lc_Nr_Itens then
            StrGrd_Itens.Cells[13,Lc_I] := FloatToStr(Lc_Vl_Tl_Seguro - (Lc_Vl_Seguro * (Lc_Nr_Itens - 1)))
          else
            StrGrd_Itens.Cells[13,Lc_I] := FloatToStr(Lc_Vl_Seguro);
          end;
        end;
      end;

    if Chbx_Outras.Checked then
      Begin
      Lc_Contatdor := 0;
      Lc_Vl_Tl_Outras := StrToFloatDef(E_Vl_Outras.Text,0);
      Lc_Vl_Outras := Lc_Vl_Tl_Outras / Lc_Nr_Itens;
      Lc_Vl_Outras :=  StrToFloatDef(FloatToStrF(Lc_Vl_Seguro,ffFixed,10,2),0);
      For Lc_I:= 1 to (StrGrd_Itens.RowCount -1) do
        Begin
        if (StrGrd_Itens.Cells[3,Lc_I] = 'X') then
          Begin
          Lc_Contatdor := Lc_Contatdor + 1;
          if Lc_Contatdor = Lc_Nr_Itens then
            StrGrd_Itens.Cells[14,Lc_I] := FloatToStr(Lc_Vl_Tl_Outras - (Lc_Vl_Outras * (Lc_Nr_Itens - 1)))
          else
            StrGrd_Itens.Cells[14,Lc_I] := FloatToStr(Lc_Vl_Outras);
          end;
        end;
      end;
    end;

end;

procedure TFr_Complementar.Pc_TotalNota;
begin
  E_VL_Nota.Caption:= FloatToStrF(It_Vl_St_ICMS + It_vl_frete + It_vl_seguro + It_vl_outros + It_vl_ipi,ffFixed,10,2)
end;

procedure TFr_Complementar.Pc_GravaItens;
Var
  Lc_I:Integer;
begin
  //Inserindo o produto complementar * Desativado em 24/03
  //lc_cd_Pro_compl := Fc_CodProdComplementar;
  For Lc_I := 1 to (StrGrd_Itens.RowCount - 1) do
  Begin
    if (StrGrd_Itens.Cells[3,lc_I] = 'X') then
    Begin
      Pc_GravaItensProdutos(lc_I);
      Pc_GravaItensICMS(lc_I);
      Pc_GravaItensIPI(lc_I);
    end;
  End;
end;

procedure TFr_Complementar.Pc_GravaItensICMS(Pc_I: Integer);
begin
  with NotaFiscal.Pedido.Itens do
  Begin
    ItensIcms.Registro.codigo             := 0;
    ItensIcms.Registro.Nota               := NotaFiscal.Registro.Codigo;
    ItensIcms.Registro.ItemNota           := StrToIntDef(StrGrd_Itens.Cells[28,Pc_I],0);
    ItensIcms.Registro.CST                := StrToIntDef(StrGrd_Itens.Cells[21,Pc_I],0);
    ItensIcms.Registro.CSOSN              := StrToIntDef(StrGrd_Itens.Cells[22,Pc_I],0);
    ItensIcms.Registro.Origem             := StrGrd_Itens.Cells[29,Pc_I];
    ItensIcms.Registro.Determinacao       := StrGrd_Itens.Cells[24,Pc_I];
    ItensIcms.Registro.AliqRedBase        := 0;
    ItensIcms.Registro.ValorBase          := StrToFloatDef(StrGrd_Itens.Cells[7,Pc_I],0);
    ItensIcms.Registro.Aliquota           := StrToFloatDef(StrGrd_Itens.Cells[8,Pc_I],0);
    ItensIcms.Registro.AliquotaReduzida   := 0;
    ItensIcms.Registro.Valor              := StrToFloatDef(StrGrd_Itens.Cells[9,Pc_I],0);
    ItensIcms.Registro.DeterminacaoBaseST := StrGrd_Itens.Cells[25,Pc_I];
    ItensIcms.Registro.AliqRedBaseST      := 0;
    ItensIcms.Registro.MVA                := StrToFloatDef(StrGrd_Itens.Cells[31,Pc_I],0);
    ItensIcms.Registro.ValorBaseST        := StrToFloatDef(StrGrd_Itens.Cells[10,Pc_I],0);
    ItensIcms.Registro.AliquotaST         := 0;
    ItensIcms.Registro.AliqRedST          := 0;
    ItensIcms.Registro.ValorST            := StrToFloatDef(StrGrd_Itens.Cells[11,Pc_I],0);
    ItensIcms.Registro.Desoneracao        := 0;
    ItensIcms.Registro.VAlorBaseSTRetido  := 0;
    ItensIcms.Registro.ValorSTRetido      := 0;
    ItensIcms.Registro.Partilha           := '';
    ItensIcms.Registro.Repasse            := '';
    ItensIcms.Registro.BaseICMSRetido     := 0;
    ItensIcms.Registro.ValorICMSRetido    := 0;
    ItensIcms.Registro.AliqCalcCred       := 0;
    ItensIcms.Registro.CreditoAprox       := 0;
    ItensIcms.Registro.ValorFrete         := StrToFloatDef(StrGrd_Itens.Cells[12,Pc_I],0);
    ItensIcms.Registro.Seguro             := StrToFloatDef(StrGrd_Itens.Cells[13,Pc_I],0);
    ItensIcms.Registro.OutrasDespesas     := StrToFloatDef(StrGrd_Itens.Cells[14,Pc_I],0);
    ItensIcms.Registro.CFOP               := StrToIntDef(StrGrd_Itens.Cells[23,Pc_I],0);
    ItensIcms.Registro.Destacar           := 'S';
    ItensIcms.Registro.Observacao         := 0;
    ItensIcms.insere;
  End;
end;

procedure TFr_Complementar.Pc_GravaItensIPI(Pc_I: Integer);
begin
  IF StrToFloatDef(E_VL_IPI.Text,0)>0 THEN
  Begin
    if (It_CodTbI_IPI = 0) then It_CodTbI_IPI := 14;
    if (It_Cl_Enqd_IPI = '') then It_Cl_Enqd_IPI := '999';
    with NotaFiscal.Pedido.Itens do
    Begin
      ItensIpi.Registro.Codigo       := 0;
      ItensIpi.Registro.Nota         := NotaFiscal.Registro.Codigo;
      ItensIpi.Registro.ItemNota     := StrToIntDef(StrGrd_Itens.Cells[28,Pc_I],0);
      ItensIpi.Registro.CST          := It_CodTbI_IPI;
      ItensIpi.Registro.ClassEnqu    := It_Cl_Enqd_IPI;
      ItensIpi.Registro.CNPJProdutor := '';
      ItensIpi.Registro.CodigoSelo   := '';
      ItensIpi.Registro.QtdeSelo     := 0;
      ItensIpi.Registro.CodigoEnqu   := '';
      ItensIpi.Registro.ValorBase    := StrToFloatDef(StrGrd_Itens.Cells[15,Pc_I],0);
      ItensIpi.Registro.Aliquota     := StrToFloatDef(StrGrd_Itens.Cells[16,Pc_I],0);
      ItensIpi.Registro.QtdeUnid     := 0;
      ItensIpi.Registro.ValorUnid    := StrToFloatDef(StrGrd_Itens.Cells[17,Pc_I],0);
      ItensIpi.insere;
    end;
  End;
end;

procedure TFr_Complementar.Pc_GravaItensProdutos(Pc_I: Integer);
begin
  with NotaFiscal.Pedido.Itens.Registro do
  Begin
    Codigo        := 0;
    CodigoPedido  := Qr_Nota.FieldByName('PED_CODIGO').AsInteger;
    CodigoNota    := NotaFiscal.Registro.Codigo;
    CodigoProduto := StrToIntDef(StrGrd_Itens.Cells[1,Pc_I],0);
    Quantidade    := StrToFloatDef(StrGrd_Itens.Cells[26,Pc_I],0);
    ValorCusto    := 0;
    ValorUnitario := StrToFloatDef(StrGrd_Itens.Cells[27,Pc_I],0);
    AliqDesconto  := 0;
    ValorDesconto := 0;
    AliqComissao  := 0;
    Operacao      := StrGrd_Itens.Cells[30,Pc_I];
    Estoque       := 'N';
    Despachar     := 'N';
    AliqIPI       := 0;
    AliqICMS      := 0;
    CodigoEstoque := Gb_Estoque;
    CodigoTabela  := 1;
    Largura       := 0;
    Altura        := 0;
    NumeroPecas   := 0;
  End;
  NotaFiscal.Pedido.Itens.Insere;
  StrGrd_Itens.Cells[28,Pc_I] := NotaFiscal.Pedido.Itens.Registro.Codigo.ToString;
end;


procedure TFr_Complementar.PC_InsereDocReceber;
Var
  Lc_Financeiro : TControllerFinanceiro;
begin
  Try
    Lc_Financeiro := TControllerFinanceiro.Create(nil);
    with Lc_Financeiro.Registro do
    Begin
      Codigo := 0;
      CodigoEmpresa       := Qr_Nota.FieldByName('EMP_CODIGO').asinteger;
      DataFinanceiro      := E_Dt_Emissao.Date;
      CodigoPedido        :=  Qr_Nota.FieldByName('NFL_CODPED').AsInteger;
      CodigoNota          := NotaFiscal.Registro.Codigo;
      FormaPagamento      := Qr_Nota.FieldByName('PED_CODFPG').AsInteger;
      PrazoPagamento      := Qr_Nota.FieldByName('PED_PRAZO').AsString;
      DataVencimento      := E_Dt_Emissao.Date;
      NumeroDuplicata     := IntToStr(NotaFiscal.Registro.Codigo) + '/1-1';
      ValorParcela        := strtofloatDef(E_VL_Nota.Caption,0);
      NumeroParcela       := 1;
      DocumentoBaixado    := 'N';
      CentroCusto         := 0;
      TipoFinanceiro      := 'RA';
      SituacaoFinanceiro  := 'N';
      OperacaoFinanceiro  := 'C';
      EtapaFinaceiro      := 'N';
      Estabelecimento     := Gb_CodMha;
      Lc_Financeiro.salva;
    end;
  Finally
    FreeAndNil(Lc_Financeiro);
  End;
end;

procedure TFr_Complementar.FormCreate(Sender: TObject);
begin
  NotaFiscal := TControllerNotaFiscal.create(Self);
  RetornoNFE := TControllerRetornoNFe.create(Self);
end;

procedure TFr_Complementar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F10:if sb_enviar.Enabled then sb_enviarClick(Sender);
      VK_F9:if SB_Confirmar.Enabled then  SB_ConfirmarClick(Sender);
      VK_Escape:if SB_Sair_0.Enabled then  SB_Sair_0Click(Sender);
    end;
   end;
end;



procedure TFr_Complementar.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and  (not (ActiveControl is TMemo))  then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;

end;

procedure TFr_Complementar.StrGrd_ItensDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  with StrGrd_Itens do
    Begin
    if (ACol = 2)and(ARow>0) Then
      begin
      if (Cells[1,ARow] <> '') then
        Begin
        if (Cells[3,ARow] = 'X') then
          DrawFrameControl(Canvas.Handle, Rect,DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED) // Desenha o CheckBox desmarcado
        else
          DrawFrameControl(Canvas.Handle, Rect,   DFC_BUTTON, DFCS_BUTTONCHECK); // Desenha o CheckBox marcado
        end;
      end
    else
      Begin
      If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
        Begin
        if (Cells[3,ARow] = '') then
          Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clCream;
          end
        else
          Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clMoneyGreen;
          end;
        Canvas.FillRect(Rect); // redesenha a celula
        Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.
        // Pega o texto da célula
        Texto := Cells[acol, ARow];

        //{ Calcura largura e altura (em pontos) do texto
        LarguraTexto := Canvas.TextWidth(Texto);
        AlturaTexto := Canvas.TextHeight(Texto);

        // Calcula a posição horizontal do início do texto
        if  (ACol = 4) or (ACol = 5) then // esquerda
          X := Rect.Left + 2
        else
        if  (ACol = 6)   then // Centro
          X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
        else // Direita
          X := Rect.Right - LarguraTexto - 2;

        // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
        Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
        Canvas.TextRect(Rect, X, Y, Texto);
        end;
      end;
    end;
end;

procedure TFr_Complementar.SB_GravarClick(Sender: TObject);
begin
  Pc_SalvaItensEdicao(StrToInt(Lb_Nr_Registro.Caption));
  Pc_ControlaInterface(True);
end;

procedure TFr_Complementar.Pc_ControlaInterface(Pc_Tipo:Boolean);
Begin
  Pnl_Edicao_Item.Visible := Not Pc_Tipo;
  StrGrd_Itens.Enabled := Pc_Tipo;
  Pnl_totais.Enabled := Pc_Tipo;
  E_Obs.Enabled := Pc_Tipo;

end;

procedure TFr_Complementar.Sb_Sair_1Click(Sender: TObject);
begin
  Pc_ControlaInterface(True);
end;

procedure TFr_Complementar.E_Item_Bs_ICMSExit(Sender: TObject);
Var
 Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(TEdit_Setes(Sender).Text,0);
  TEdit_Setes(Sender).Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
  Pc_CalculaItemICMS;
end;

procedure TFr_Complementar.E_Item_Aliq_ICMSExit(Sender: TObject);
Var
 Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(TEdit_Setes(Sender).Text,0);
  TEdit_Setes(Sender).Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
  Pc_CalculaItemICMS;
end;

procedure TFr_Complementar.E_Item_Bs_ICMS_STExit(Sender: TObject);
Var
 Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(TEdit_Setes(Sender).Text,0);
  TEdit_Setes(Sender).Text := FloatToStrF(Lc_Valor,ffFixed,10,2);

end;

procedure TFr_Complementar.E_Item_vl_ICMS_STExit(Sender: TObject);
Var
 Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(TEdit_Setes(Sender).Text,0);
  TEdit_Setes(Sender).Text := FloatToStrF(Lc_Valor,ffFixed,10,2);

end;

procedure TFr_Complementar.E_Item_VL_FreteExit(Sender: TObject);
Var
 Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(TEdit_Setes(Sender).Text,0);
  TEdit_Setes(Sender).Text := FloatToStrF(Lc_Valor,ffFixed,10,2);

end;

procedure TFr_Complementar.E_Item_Vl_SeguroExit(Sender: TObject);
Var
 Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(TEdit_Setes(Sender).Text,0);
  TEdit_Setes(Sender).Text := FloatToStrF(Lc_Valor,ffFixed,10,2);

end;

procedure TFr_Complementar.E_Item_Vl_DespesasExit(Sender: TObject);
Var
 Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(TEdit_Setes(Sender).Text,0);
  TEdit_Setes(Sender).Text := FloatToStrF(Lc_Valor,ffFixed,10,2);

end;

procedure TFr_Complementar.E_Item_Bs_IPIExit(Sender: TObject);
Var
 Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(TEdit_Setes(Sender).Text,0);
  TEdit_Setes(Sender).Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
  Pc_CalculaItemIPI;
end;

procedure TFr_Complementar.E_Item_Aliq_IPIExit(Sender: TObject);
Var
 Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(TEdit_Setes(Sender).Text,0);
  TEdit_Setes(Sender).Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
  Pc_CalculaItemIPI;
end;

procedure TFr_Complementar.Editar1Click(Sender: TObject);
begin
  Pc_MostrarItensEdicao(StrGrd_Itens.Row);
end;

procedure TFr_Complementar.StrGrd_ItensDblClick(Sender: TObject);
begin
  with StrGrd_Itens do
    Begin
    IF Cells[3,Row]= 'X' then
      Cells[3,Row] := ''
    else
      Cells[3,Row] := 'X';
    Repaint;
    end;
end;

procedure TFr_Complementar.qr_bs_icmsAfterOpen(DataSet: TDataSet);
begin
  qr_bs_icms.FetchAll
end;

procedure TFr_Complementar.qr_bs_icms_stAfterOpen(DataSet: TDataSet);
begin
  qr_bs_icms_st.FetchAll
end;

procedure TFr_Complementar.QR_TRIB_SNAfterOpen(DataSet: TDataSet);
begin
  QR_TRIB_SN.FetchAll;
end;

procedure TFr_Complementar.QR_TRIB_NRAfterOpen(DataSet: TDataSet);
begin
  QR_TRIB_NR.FetchAll;
end;

end.






