unit un_imp_fechamento;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, prmVendas, Vcl.DBCtrls, un_Fm_ListaColaboradores, Un_Fm_ListaUsuarios, prmMovimFinanceiro;

type
  TFr_Imp_Fechamento = class(TFr_Base)
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Pnl_Parametro: TPanel;
    Panel1: TPanel;
    Label4: TLabel;
    LBx_TipoRelatorio: TListBox;
    Fm_Usuario: TFm_ListaUsuarios;
    Pnl_Data: TPanel;
    ChBx_Periodo: TCheckBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Fm_Vendedor: TFm_ListaColaboradores;
    procedure SB_ImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure LBx_TipoRelatorioClick(Sender: TObject);
  private
    { Private declarations }
    procedure IniciaVariaveis;Override;
    procedure VendaPorFormaPagamento(Pc_Operacao,Pc_Caminho:String);
    procedure MovimentoPorFormaPagamento(Pc_Operacao,Pc_Caminho:String);
    procedure VendasBandeiraTEF(Pc_Operacao,Pc_Caminho:String);
    Procedure FormatParameter;
  protected
    procedure ImagemBotao;Override;
  public
    { Public declarations }
    function getParametros:TParamVendas;

  end;

var
  Fr_Imp_Fechamento: TFr_Imp_Fechamento;

implementation

{$R *.dfm}

uses       UN_Sistema, Un_Regra_Negocio, Un_DM, un_frx_movim_financeiro, un_frx_ReportVendasBandeirasTEF, un_frx_ReportVendasFormaPagto, UN_TabelasEmListas, UN_Principal, env;

procedure TFr_Imp_Fechamento.FormatParameter;
begin
  FM_Vendedor.Visible := False;
  FM_Usuario.Visible := False;
  case LBx_TipoRelatorio.ItemIndex of
    0:Begin
        FM_Vendedor.Visible := True;
    End;
    1:Begin
        FM_Usuario.Visible := True;
    End;
  end;
end;

procedure TFr_Imp_Fechamento.FormShow(Sender: TObject);
begin
  inherited;
  //Pc_PermissaoBotao('Lançamentos Caixa');
  DM_ListaConsultas.Pc_ListaVendedor;
  E_Data_INI.Date := Date;
  E_Data_FIM.Date := Date;
  LBx_TipoRelatorio.ItemIndex := 0;
  ChBx_Periodo.Checked:= Fc_Marca_data_pesquisa;
end;

function TFr_Imp_Fechamento.getParametros: TParamVendas;
begin
  Result := TParamVendas.Create;
  with Result do
  Begin
    Periodo := ChBx_Periodo.Checked;
    DataInicial := E_Data_Ini.DateTime;
    DataFinal := E_Data_Fim.DateTime;
    CodigoVendedorPedido := 0;
    if ( Trim(Fm_Vendedor.Dblcb_Vendedor.Text) <> '') then
      CodigoVendedorPedido := Fm_Vendedor.Dblcb_Vendedor.KeyValue;
    CodigoEstabelecimento := Gb_CodMha;
  End;
end;

procedure TFr_Imp_Fechamento.IniciaVariaveis;
begin
  inherited;
  LBx_TipoRelatorio.ItemIndex := 0;
  Fm_Vendedor.ListaVendedor;
  Fm_Usuario.Pc_listar;
end;

procedure TFr_Imp_Fechamento.LBx_TipoRelatorioClick(Sender: TObject);
begin
  FormatParameter;
end;

procedure TFr_Imp_Fechamento.MovimentoPorFormaPagamento(Pc_Operacao,
  Pc_Caminho: String);
Var
  Form : Tfrx_MovimFinanceiro;
Begin
  Try
    Form := Tfrx_MovimFinanceiro.create(nil);
    Form.Parametros.Periodo := ChBx_Periodo.Checked;
    Form.Parametros.DataInicial := E_Data_Ini.DateTime;
    Form.Parametros.DataFinal := E_Data_Fim.DateTime;
    Form.Parametros.CodigoEstabelecimento := Gb_CodMha;
    Form.Parametros.usuario := 0;
    if ( Trim(Fm_Usuario.DBLCB_Lista.Text) <> '') then
      Form.Parametros.Usuario := Fm_Usuario.DBLCB_Lista.KeyValue;
    Form.Parametros.CodigoEstabelecimento := Gb_CodMha;



    //Form.Parametros.Ordenacao := ' FIN_DT_VENCIMENTO,EMP_NOME ';
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Form.Caption := 'MOVIMENTO FINANCEIRO POR FORMA DE PAGAMENTO';
      //Envia conexãao do Banco
      Form.buscar;
      Form.frxBase.ShowReport;
    end
    else
    Begin
      Form.frxBase.ShowReport;
    End;

  Finally
    Form.Close;
    FreeAndNil(Form);
  End;
end;

procedure TFr_Imp_Fechamento.ImagemBotao;
begin
  CarregaImagemBotao(Sb_Exportar,'EXPORTAR');
  CarregaImagemBotao(SB_Imprimir,'IMPRIMIR');
  CarregaImagemBotao(Sb_Sair_0,'SAIR');

end;

procedure TFr_Imp_Fechamento.SB_ImprimirClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Self.KeyPreview := False;
    Pc_AtivaEstabelecimento;
    case LBx_TipoRelatorio.ItemIndex of
      0:VendaPorFormaPagamento('I','');
      1:MovimentoPorFormaPagamento('I','');
      2:VendasBandeiraTEF('I','');
    end;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
    Self.KeyPreview := True;
    ChBx_Periodo.SetFocus;
  end;
end;

procedure TFr_Imp_Fechamento.Sb_Sair_0Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFr_Imp_Fechamento.VendaPorFormaPagamento(Pc_Operacao,Pc_Caminho:String);
Var
  Form : Tfrx_ReportVendasFormaPagto;
Begin
  Try
    Form := Tfrx_ReportVendasFormaPagto.create(nil);
    Form.Parametros := getParametros;
    //Form.Parametros.Ordenacao := ' FIN_DT_VENCIMENTO,EMP_NOME ';
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Form.Caption := 'VENDAS POR FORMA DE PAGAMENTO';
      //Envia conexãao do Banco
      Form.frxBase.variables['StrConnetion'] := DM.IBD_Gestao.DatabaseName;
      Form.buscar;
      Form.frxBase.ShowReport;
    end
    else
    Begin
      Form.frxBase.ShowReport;
    End;

  Finally
    Form.Close;
    FreeAndNil(Form);
  End;

end;

procedure TFr_Imp_Fechamento.VendasBandeiraTEF(Pc_Operacao, Pc_Caminho: String);
Var
  Form : Tfrx_ReportVendasBandeirasTEF;
Begin
  Try
    Form := Tfrx_ReportVendasBandeirasTEF.create(nil);
    Form.Parametros := getParametros;
    //Form.Parametros.Ordenacao := ' FIN_DT_VENCIMENTO,EMP_NOME ';
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Form.Caption := 'VENDAS POR BANDEIRAS  - TEF';
      //Envia conexãao do Banco
      Form.frxBase.variables['StrConnetion'] := DM.IBD_Gestao.DatabaseName;
      Form.buscar;
      Form.frxBase.ShowReport;
    end
    else
    Begin
      Form.frxBase.ShowReport;
    End;

  Finally
    Form.Close;
    FreeAndNil(Form);
  End;


end;

end.
