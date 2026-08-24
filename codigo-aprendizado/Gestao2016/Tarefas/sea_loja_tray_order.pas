unit sea_loja_tray_order;


interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Spin, ComCtrls, ExtCtrls, ControllerEmpresa, ControllerEndereco, ControllerColaborador, ControllerProduto, ObjMerchandise, objSalesMan, ControllerCliente, objCustomer, IPPeerClient, ControllerPedidoVda, TrayOrder, trayCustomer, TrayCustomerAddress, TrayProductsSold, TrayPayment, Data.DB, STQuery, Vcl.Menus, Vcl.Grids, Vcl.Buttons, Un_base_Pesq;

type
  TSeaLojaTrayOrder = class(TFr_Base_Pesq)
    ChBx_Periodo: TCheckBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Qr_PesquisaID: TIntegerField;
    Qr_PesquisaSTATUS: TStringField;
    Qr_PesquisaDT_RECORD: TDateField;
    Qr_PesquisaCUSTOMER_ID: TIntegerField;
    Qr_PesquisaPARTIAL_TOTAL: TBCDField;
    Qr_PesquisaTAXES: TBCDField;
    Qr_PesquisaDISCOUNT: TBCDField;
    Qr_PesquisaSHIPMENT: TStringField;
    Qr_PesquisaSHIPMENT_VALUE: TBCDField;
    Qr_PesquisaDT_SHIPMENT: TDateField;
    Qr_PesquisaPAYMENT_FORM: TStringField;
    Qr_PesquisaTOTAL_VALUE: TBCDField;
    Qr_PesquisaDT_PAYMENT: TDateField;
    Qr_PesquisaMODIFIED: TSQLTimeStampField;
    DataSource1: TDataSource;
    lb_Filter_Value: TLabel;
    E_Codigo_Web: TEdit;
    procedure ChBx_PeriodoClick(Sender: TObject);
  private
    Pedido : TControllerPedidoVda;
    function BaixaPedidoCompleto:Boolean;
    procedure AbreTelaPedido;
    procedure AbreTelaNotaFiscal;


    { Private declarations }
  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure PassagemParametros;Override;
    function ValidaVisualiza:Boolean;Override;
    procedure Visualiza;Override;
  public
    { Public declarations }
  end;

var
  SeaLojaTrayOrder: TSeaLojaTrayOrder;

implementation

{$R *.dfm}

uses     UN_Principal, env, Un_Funcoes, UN_Pedido_Vda, UN_Sistema, un_tray_to_gestao, Un_Msg, RN_NotaFiscal;


function TSeaLojaTrayOrder.BaixaPedidoCompleto:Boolean;
Var
  TrayToGestao : TTrayToGestao;
begin
  Try
    Try
      TrayToGestao := TTrayToGestao.Create(nil);
      TrayToGestao.CodigoWeb := Pedido.Registro.CodigoWeb;
      TrayToGestao.ReceiveOrderComplete;
      Result := True;
    Except
      Result := False;
    End;
  Finally
    FreeAndNil(TrayToGestao);
  End;
end;

procedure TSeaLojaTrayOrder.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TSeaLojaTrayOrder.CriarVariaveis;
begin
  inherited;
  Pedido := TControllerPedidoVda.create(Self);
end;


procedure TSeaLojaTrayOrder.IniciaVariaveis;
begin
  inherited;
  MultiSelect := False;
  ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
  E_Data_Ini.DateTime := Date;
  E_Data_Fim.DateTime := Date;
end;

procedure TSeaLojaTrayOrder.OrderBy;
begin
  SqlTxt := concat(
              SqlTxt,
              'ORDER BY ID '
            );

end;

procedure TSeaLojaTrayOrder.PassagemParametros;
begin
  if ChBx_Periodo.Checked then
  BEgin
    Qr_Pesquisa.ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
    Qr_Pesquisa.ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
  End;
  if StrToIntDef(E_Codigo_Web.text,0) > 0 then
    Qr_Pesquisa.ParamByName('ID').AsInteger := StrToIntDef(E_Codigo_Web.text,0);

end;

procedure TSeaLojaTrayOrder.AbreTelaNotaFiscal;
begin
  Pc_AbreTelaNotaFiscal(Pedido.getIdNota,Self);
end;

procedure TSeaLojaTrayOrder.AbreTelaPedido;
Var
  LcForm : TFr_Pedido_Vda;
begin
  try
    LcForm := TFr_Pedido_Vda.create(nil);
    LcForm.Pedido.Registro.Codigo := Pedido.Registro.Codigo;
    LcForm.Pedido.Registro.CodigoEstabelecimento := Gb_CodMha;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TSeaLojaTrayOrder.SelectSql;
begin
  SqlTxt := concat(
              'SELECT * ',
              'FROM TB_LOJA_TRAY_ORDER  '
            );
end;

function TSeaLojaTrayOrder.ValidaVisualiza: Boolean;
begin
  REsult := True;
  if Trim( Grd_Pesquisa.Cells[3,Grd_Pesquisa.Row]) = '' then
  Begin
    MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                  ' Não há registros para visualizar.' + EOLN +
                  ' Favor verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  End;

  if Upper( Grd_Pesquisa.Cells[4,Grd_Pesquisa.Row]) = 'CANCELADO' then
  Begin
    MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                  ' Pedido com o Status de Cancelado.' + EOLN +
                  ' Não é possoível visualizar.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  End;
end;

procedure TSeaLojaTrayOrder.Visualiza;
Label
  AbrePedido;
begin
  TRY
    Self.Enabled := False;
    Pc_ProcesoAguarde(Self,'I');
    Pedido.Registro.CodigoWeb := StrToIntDef(Grd_Pesquisa.Cells[3,Grd_Pesquisa.Row],0);
    Pedido.Registro.CodigoEstabelecimento := Gb_CodMha;
    Pedido.Registro.Vendedor := pedido.Vendedor.getVendedorTray;
    AbrePedido:
    Pedido.getByCodigoWeb;
    if Pedido.exist then
    Begin
      if Pedido.Registro.Faturado = 'S' then
        AbreTelaNotaFiscal
      else
        AbreTelaPedido;
    End
    else
    BEgin
      if BaixaPedidoCompleto then
        Goto AbrePedido;
    End;
  Finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
    ChBx_Periodo.SetFocus;
  end;
end;

procedure TSeaLojaTrayOrder.WhereSql;
begin
    SqlTxt := concat(
                SqlTxt,
                'WHERE ( ID > 0) '
                );

  if ChBx_Periodo.Checked then
    SqlTxt := concat(
                SqlTxt,
                ' and (DT_RECORD BETWEEN :DATAINI AND :DATAFIM) '
                );

  if StrToIntDef(E_Codigo_Web.text,0) > 0 then
    SqlTxt := concat(
                SqlTxt,
                ' AND  (ID =:ID) '
                );

end;

end.


