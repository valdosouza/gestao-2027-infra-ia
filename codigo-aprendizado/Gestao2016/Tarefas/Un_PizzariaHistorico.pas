unit Un_PizzariaHistorico;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.Grids, Vcl.ExtCtrls, Data.DB, STQuery, Vcl.DBGrids, Vcl.StdCtrls, Un_DM, ControllerRestaurante, Vcl.DBCtrls, ControllerBase;

type
  TFr_PizzariaHistorico = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    SB_Sair_0: TSpeedButton;
    Qr_Historico: TSTQuery;
    Ds_Historico: TDataSource;
    M_Pedido: TMemo;
    navegador: TDBNavigator;
    Qr_HistoricoPED_CODIGO: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure Qr_HistoricoAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    function  GetLastOrder:Integer;
    Procedure MostraPedido;
    Procedure OpenHistorico;
  protected
    procedure FormataTela;
    Procedure IniciaVariveis;

  public
    { Public declarations }
    ClienteID : Integer;
    ConsumidorID : Integer;

  end;

var
  Fr_PizzariaHistorico: TFr_PizzariaHistorico;

implementation

{$R *.dfm}

uses     UN_Principal, env, Un_Regra_Negocio, UN_Sistema, PrintPizzaria, PagamentoEscolhido;
procedure TFr_PizzariaHistorico.FormataTela;
begin
  with fr_principal do
  Begin
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  End;
end;

procedure TFr_PizzariaHistorico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_PizzariaHistorico.FormShow(Sender: TObject);
begin
  FormataTela;
  IniciaVariveis

end;

function TFr_PizzariaHistorico.GetLastOrder:Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select first 3 PED_CODIGO ',
                'FROM tb_pedido ',
                '  INNER JOIN TB_NOTA_FISCAL NF ',
                '  ON (NFL_CODPED = PED_CODIGO) ',
                'WHERE PED_CODEMP=:EMP_CODIGO',
                ' and PED_TIPO = 1 ',
                'order by ped_codigo desc '
      ));
      ParamByName('EMP_CODIGO').AsInteger := ClienteID;
      Active := True;
      FetchAll;

      if RecordCount > 0 then
        REsult := FieldByName('CODIGO').AsInteger
      else
        REsult := 0;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;

end;

procedure TFr_PizzariaHistorico.IniciaVariveis;
begin
  Pc_AtivaEstabelecimento;
  OpenHistorico;
  MostraPedido;
end;

procedure TFr_PizzariaHistorico.MostraPedido;
Var
  Lc_Imp : TPrintPizzaria;
  //Novos

  Lc_Valor :real;
  I : Integer;
  LcPagEscolhido : TPagamentoEscolhido;
  Lc_Restaurante : TControllerRestaurante;
  Lc_cd_Pedido : Integer;
begin
  Lc_cd_Pedido := Qr_HistoricoPED_CODIGO.AsInteger;
  if Lc_cd_Pedido > 0 then
  Begin
    Try
      Lc_Restaurante := TControllerRestaurante.Create(nil);
      Lc_Restaurante.Registro.CodigoPedido := Lc_cd_Pedido;
      Lc_Restaurante.getbyId;

      Lc_Imp := TPrintPizzaria.Create(nil);
      Lc_Imp.FormaPagto.Clear;

      with Lc_Imp do
      Begin
        CodigoConsumidor := ConsumidorID;
        Estabelecimento := Gb_CodMha;
        CodigoPedido := Lc_cd_Pedido;
        NomeEstabelecimento := DM.Qr_Estabelecimento.FieldByNAme('EMP_FANTASIA').AsString;
        FoneEstabelecimento := DM.Qr_Estabelecimento.FieldByNAme('END_FONE').AsString;
        NomeUsuario := GB_Nm_Usuario;
        ModeloMatricial := 1;
        Sache := False;
        Fatiado := False;
        Palito := False;
        ValorRecebido := FloatToStrF(Lc_Restaurante.Registro.ValorRecebido,ffFixed,10,2);
        ValorTroco := FloatToStrF(Lc_Restaurante.Registro.ValorTroco,ffFixed,10,2);

        Application.ProcessMessages;
        GetLastOrder;
        M_Pedido.Lines.LoadFromFile(concat(ExtractFilePath(Application.ExeName),'temp\cupompizza.txt'));
      end;
    Finally
      FreeAndNil(Lc_Restaurante);
      FreeAndNil(Lc_Imp);
    End;
  End
  Else
  BEgin
    M_pedido.Lines.Clear;
    M_pedido.Lines.Add('Nenhum pedido encontrado') ;
  End;

end;

procedure TFr_PizzariaHistorico.OpenHistorico;
begin
  with Qr_Historico do
  Begin
    Active := False;
    ParamByName('EMP_CODIGO').AsInteger := ClienteID;
    Active := True;
    FetchAll;
  End;
end;

procedure TFr_PizzariaHistorico.Qr_HistoricoAfterScroll(DataSet: TDataSet);
begin
  MostraPedido;
end;

procedure TFr_PizzariaHistorico.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

end.
