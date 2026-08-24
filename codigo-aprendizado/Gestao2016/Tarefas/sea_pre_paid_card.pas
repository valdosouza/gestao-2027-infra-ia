unit sea_pre_paid_card;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask, Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, STQuery, ControllerRetaguardaSync;



type
  TSeaPrePaidCard = class(TBaseSearch)
    E_Numero: TMaskEdit;
    ChBx_Periodo: TCheckBox;
    E_Data_Fim: TDateTimePicker;
    E_Data_Ini: TDateTimePicker;
    Label36: TLabel;
    cds_searchID: TIntegerField;

    cds_searchTB_INSTITUTION_ID: TIntegerField;
    cds_searchTERMINAL: TIntegerField;
    cds_searchDT_RECORD: TDateField;
    cds_searchCREDIT_VALUE: TBCDField;
    cds_searchDEBIT_VALUE: TBCDField;
    cds_searchHISTORY: TWideStringField;
    cds_searchTB_ORDER_ID: TIntegerField;
    cds_searchCREATED_AT: TSQLTimeStampField;
    cds_searchUPDATED_AT: TSQLTimeStampField;
    Lb_TotalCredito: TLabel;
    E_TotalCredito: TLabel;
    Lb_TotalDebito: TLabel;
    E_TotalDebito: TLabel;
    Lb_Saldo: TLabel;
    E_Saldo: TLabel;
    PopupMenu: TPopupMenu;
    VisualizarPedido1: TMenuItem;
    Rg_Tipo_Valor: TRadioGroup;
    E_Historico: TEdit;
    Label1: TLabel;
    cds_searchNUMBER: TWideStringField;
    Cliente1: TMenuItem;
    procedure VisualizarPedido1Click(Sender: TObject);
    procedure Cliente1Click(Sender: TObject);
  private
    { Private declarations }
    procedure Totalizer;

  protected
    procedure IniciaVariaveis;Override;
    procedure ImagemBotao;Override;
    procedure FormataTela;Override;
    procedure SelectSql;Override;
    procedure WhereSql;Override;
    procedure OrderBySQl;Override;
    procedure SetParameters(Param: TSTQuery);Override;
    procedure SetRegister;Override;
    procedure Search;Override;
    procedure setPerfil;Override;
  public
    { Public declarations }
  end;

var
  SeaPrePaidCard: TSeaPrePaidCard;

implementation

{$R *.dfm}

uses     UN_Principal, env, UN_Sistema, ControllerPrePaidCard, RN_FormaPagto, RN_NotaFiscalConsumidor, Un_DM, tas_pre_paid_card, Un_Msg, Un_CliResumo, Un_Pesq_Empresa;
procedure TSeaPrePaidCard.Cliente1Click(Sender: TObject);
Var
  Lc_Form_res : TFr_CliResumo;
  Lc_Form : TFr_Pesq_Empresa;
begin
  if not Fc_VerificaFormularioDisponivel('Fr_CliResumo') then
  Begin
    Lc_Form := TFr_Pesq_Empresa.Create( nil );
    Try
      Lc_Form.TipoEmpresa := 1;
      Lc_Form.ShowModal;
    finally
      FreeAndNil(Lc_Form);
    end;
  end
  else
  Begin
    Try
      Lc_Form_res := TFr_CliResumo.Create(Self);
      Lc_Form_res.ShowModal;
    Finally
      FreeAndNil(Lc_Form_res);
    end;
  end;
end;

procedure TSeaPrePaidCard.FormataTela;
begin
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
end;

procedure TSeaPrePaidCard.ImagemBotao;
begin
  inherited;

end;

procedure TSeaPrePaidCard.IniciaVariaveis;
begin
  inherited;
  //comando para criar automaticamente o forma de pagamento
  //                     CARTÃO PRÉ-PAGO
  getIdFormaPgto('CARTÃO PRÉ-PAGO','P');
end;


procedure TSeaPrePaidCard.SetRegister;
Var
  Form : TTasPrePaidCard;
begin
  Try
    Form := TTasPrePaidCard.create(nil);
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
    Search;
  End;
end;

procedure TSeaPrePaidCard.Totalizer;
Var
  LcPrePaid : TControllerPrePaidCard;
begin
  Try
    LcPrePaid := TControllerPrePaidCard.create(nil);
    LcPrePaid.Parametros.PrePago.Estabelecimento := Gb_CodMha;
    LcPrePaid.Parametros.PrePago.Numero := E_Numero.Text;
    LcPrePaid.Parametros.Periodo        := ChBx_Periodo.Checked;
    LcPrePaid.Parametros.DataInicial    := E_Data_Ini.DateTime;
    LcPrePaid.Parametros.DataFinal      := E_Data_Fim.DateTime;
    E_TotalCredito.Caption  := FloatToStrF(LcPrePaid.getCredito ,ffNumber,10,2);
    E_TotalDebito.Caption   := FloatToStrF(LcPrePaid.getDebito,ffNumber,10,2);
    E_Saldo.Caption         := FloatToStrF(LcPrePaid.getSaldo,ffNumber,10,2);
  Finally
    FreeAndNil(LcPrePaid);
  End;
end;

procedure TSeaPrePaidCard.VisualizarPedido1Click(Sender: TObject);

begin
  if cds_searchTB_ORDER_ID.AsInteger = 0 then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Este é um lançamento Avulso e não está vinculado a Pedidos.' + EOLN +
                   'Clique OK para continuar.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    exit;
  End;
  Pc_AbreTelaNotaFiscal65('P', cds_searchTB_ORDER_ID.AsInteger )
end;

procedure TSeaPrePaidCard.OrderBySql;
begin
  inherited;
  OrderByTxt := 'ORDER BY NUMBER, DT_RECORD ';
end;

procedure TSeaPrePaidCard.SetParameters(Param: TSTQuery);
begin
  with Param do
  Begin
    ParamByName('TB_INSTITUTION_ID').AsInteger := Gb_CodMha;

    if ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
      ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
    End;

    if ( E_Numero.Text <> '' ) then
    Begin
      ParamByName('NUMBER').AsString := E_Numero.Text ;
    End;

    if ( E_Historico.Text <> '' ) then
    Begin
      ParamByName('HISTORY').AsString := concat('%',E_Historico.Text,'%');
    End;

  End;
end;

procedure TSeaPrePaidCard.setPerfil;
begin
  //Implementar
  pfMenu := 'Movimento Cartão Pré-Pago';
  inherited;
end;

procedure TSeaPrePaidCard.Search;
begin
  inherited;
  Totalizer;
end;

procedure TSeaPrePaidCard.SelectSql;
begin
  SelectTxt := concat(
              'SELECT * ',
              'FROM TB_PRE_PAID_CARD '
            );
end;


procedure TSeaPrePaidCard.WhereSql;
begin
  inherited;
  WhereTxt := concat(
              'WHERE (TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) '
  );

  if ChBx_Periodo.Checked then
  Begin
    WhereTxt := concat(
                WhereTxt,
                ' AND ( DT_RECORD BETWEEN :DATAINI AND :DATAFIM ) '
    );
  End;

  if (E_Numero.Text <> '') then
  Begin
    WhereTxt := concat(
                WhereTxt,
                ' AND ( NUMBER =:NUMBER ) '
    );
  End;

  case Rg_Tipo_Valor.ItemIndex of
    0: WhereTxt := concat( WhereTxt,' AND ( CREDIT_VALUE > 0 ) ');
    1: WhereTxt := concat( WhereTxt,' AND ( DEBIT_VALUE > 0 ) ');
  end;

  if ( E_Historico.Text <> '' ) then
  Begin
    WhereTxt := concat(
                WhereTxt,
                ' AND ( HISTORY LIKE :HISTORY ) '
    );
  End;

end;

end.
