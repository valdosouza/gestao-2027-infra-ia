unit Un_Itens_Produto_Ajt;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Un_Itens_Produto, Actions, Vcl.ActnList, Vcl.DBCtrls, Un_Fm_ListaEstoques, QEdit_Setes, ControllerDevolIPI, Datasnap.DBClient, Vcl.ComCtrls, Un_fm_ListaTributacao;

type
  TFr_Itens_Produto_Ajt = class(TFr_Itens_Produto)
    RG_Tipo_S_E: TRadioGroup;
    grp_devIPI: TGroupBox;
    Label5: TLabel;
    e_pIpi: TEdit_Setes;
    E_vIpi: TEdit_Setes;
    Label6: TLabel;
    procedure e_pIpiExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RG_Tipo_S_EClick(Sender: TObject);
    procedure Pg_MainChange(Sender: TObject);
  private
    { Private declarations }
    DevolIPi : TControllerDevolIPI;
    procedure ListaTributacao;
   protected
    function validaGravacao:Boolean;Override;
    function grava:Boolean;Override;
    procedure getDevolipi;
    procedure LoadItems(Items:TSTQuery);Override;
    procedure Pc_IniciaVariaveis;Override;
    procedure DefineValoresEspecificos(Pc_Cd_Tabela : Integer);Override;
  public
    { Public declarations }
    procedure Pc_Totalizador;Override;
    procedure Pc_StateChange(Pc_Tipo: integer);override;
  end;

var
  Fr_Itens_Produto_Ajt: TFr_Itens_Produto_Ajt;

implementation

{$R *.dfm}

uses     Un_DM, Un_Fc_Sored_Procedures, Un_Msg, RN_Compras, UN_Sistema, env;
procedure TFr_Itens_Produto_Ajt.DefineValoresEspecificos(Pc_Cd_Tabela : Integer);
begin
  inherited;
  //Verifica se a tela em questão é de Ajuste e mostra o o ultimo valor unitario de compra para a devolução ou garantia
  ItensNFL.Registro.CodigoProduto := Qr_Pesquisa.FieldByName('PRO_CODIGO').AsInteger;
  ItensNFL.Registro.ValorUnitario := Fc_UltimoValorUnitarioCompra(ItensNFL.Registro.CodigoProduto);
  IF ItensNFL.Registro.ValorUnitario = 0 then
    ItensNFL.Registro.ValorUnitario := Qr_Pesquisa.FieldByName('PRO_VL_CUSTO').AsCurrency;
end;

procedure TFr_Itens_Produto_Ajt.e_pIpiExit(Sender: TObject);
begin
  Pc_Totalizador;
end;

procedure TFr_Itens_Produto_Ajt.FormShow(Sender: TObject);
begin
  inherited;
  getDevolipi;
end;

procedure TFr_Itens_Produto_Ajt.getDevolipi;
begin
  Try
    DevolIPi := TControllerDevolIPI.Create(nil);
    DevolIPi.Registro.Ordem := ItensNFL.Registro.CodigoPedido;
    DevolIPi.Registro.Item  := ItensNFL.Registro.Codigo;
    DevolIPi.getbyId;
    if DevolIPi.exist then
    BEgin
      e_pIpi.Text := FloatToStrF(DevolIPi.Registro.Percentual,ffFixed,10,2);
      E_vIpi.Text := FloatToStrF(DevolIPi.Registro.Valor,ffFixed,10,2);
    End;
    Pc_Totalizador;
  Finally
    FreeAndNil(DevolIPi);
  End;

end;

function TFr_Itens_Produto_Ajt.grava:Boolean;
Var
  Lc_Estoque : String;
Begin
  if Fc_ExisteItemNoPedido('A') then
  Begin
    if Chbx_Estoque.Checked then Lc_Estoque := 'S' else Lc_Estoque := 'N';
    with ItensNFL.Registro do
    Begin
      CodigoPedido := ItensNFL.Registro.CodigoPedido;
      CodigoProduto := It_Cd_Produto;
      Quantidade := StrToFloatDef(E_Qt_Produto.Text,0);
      ValorCusto := StrToFloatDef(E_CustoUnitario.Text,0);
      ValorUnitario := StrToFloatDef(E_Vl_Unitario.Text,0);
      AliqDesconto := StrToFloatDef(E_Aq_Desconto.Text,0);
      ValorDesconto := StrToFloatDef(E_VL_Desconto.Text,0);
      AliqComissao := StrToFloatDef(E_Aq_Com.Text,0);
      Operacao := 'A';
      Estoque := Lc_Estoque;
      Despachar := 'S';
      AliqIPI := StrToFloatDef(E_Aq_IPI.Text,0);
      AliqICMS := StrToFloatDef(E_Aq_Icms.Text,0);
      CodigoEstoque := Fm_ListaEstoques.Dblcb_Estoque.Keyvalue;
      CodigoTabela := Dblcb_Tabelas.KeyValue;
      Largura := StrtoFloatDef(e_Largura.Text,0);
      Altura := StrtoFloatDef(e_Altura.Text,0);
      NumeroPecas := StrtoFloatDef(E_Nr_Peca.Text,0);
    End;
    ItensNFL.salva;

    Try
      DevolIPi := TControllerDevolIPI.Create(nil);
      DevolIPi.Registro.Ordem := ItensNFL.Registro.CodigoPedido;
      DevolIPi.Registro.Item  := ItensNFL.Registro.Codigo;
      DevolIPi.Registro.Percentual := StrToFloatDEf(e_pIpi.Text,0);
      DevolIPi.Registro.Valor      := StrToFloatDEf(E_vIpi.Text,0);
      if StrToFloatDEf(e_pIpi.Text,0) > 0 then
        DevolIPi.salva
      else
        DevolIPi.delete;
    Finally
      FreeAndNil(DevolIPi);
    End;
    Result := True;
  end
  else
  Begin
    Result := FAlse;
  End;


end;


procedure TFr_Itens_Produto_Ajt.ListaTributacao;
begin
  fm_ListaTributacao.Estado := SElf.Estado;
  If RG_Tipo_S_E.ItemIndex = 0 then
    fm_ListaTributacao.Sentido := 'S'
  else
    fm_ListaTributacao.Sentido := 'E';
  fm_ListaTributacao.Produto := It_Cd_Produto;
  fm_ListaTributacao.Listar;
end;

procedure TFr_Itens_Produto_Ajt.LoadItems(Items: TSTQuery);
begin
  inherited;
  (cds_items.FieldByName('ITF_VL_UNIT') as TNumericField).DisplayFormat     := Gb_Casa_Dec_Venda;
  (cds_items.FieldByName('ITF_VL_DESC') as TNumericField).DisplayFormat     := '0.00######';
  (cds_items.FieldByName('ITF_VL_SUBTOTAL') as TNumericField).DisplayFormat := '0.00';
  (cds_items.FieldByName('ITF_VL_TOTAL') as TNumericField).DisplayFormat := '0.00';
end;

procedure TFr_Itens_Produto_Ajt.Pc_IniciaVariaveis;
begin
  inherited;
  ListaTributacao;
end;

procedure TFr_Itens_Produto_Ajt.Pc_StateChange(Pc_Tipo: integer);
begin
  inherited;
  case Pc_Tipo of
    2:Begin //Inserindo
        pnl_botao_lista.Visible := TRue;
        DBG_Produtos.Visible := TRue;
        Height := 650;
      end;
    3:Begin //Alterando
        pnl_botao_lista.Visible := False;
        DBG_Produtos.Visible := False;
        Height := 343;
      end;
   end;

end;


procedure TFr_Itens_Produto_Ajt.Pc_Totalizador;
Var
  Lc_Vl_Prod : Real;
  Lc_Aq_Ipi : Real;
  Lc_VL_DEVOL_IPI : Real;
  Lc_Vl_Total : Real;
  Lc_Qt_aux : Real;

begin
  inherited;
  Lc_Vl_Prod := StrToFloatDef(E_VL_Produto.Caption,0);
  Lc_Vl_Prod := Lc_Vl_Prod - StrToFloatDef(E_VL_Desconto.Text,0);
  Lc_Aq_Ipi := StrToFloatDef(e_pIpi.Text,0);
  Lc_VL_DEVOL_IPI := ( Lc_Vl_Prod * Lc_Aq_Ipi) / 100;
  E_vIpi.Text := FloatToStrF(Lc_VL_DEVOL_IPI,ffFixed,10,2);

  Lc_Vl_Total := StrToFloatDef(E_Vl_SubTotal.Caption,0);
  Lc_Vl_Total := Lc_Vl_Total + Lc_VL_DEVOL_IPI;
  E_Vl_SubTotal.Caption := FloatToStrF(Lc_Vl_Total,ffFixed,10,2);


end;

procedure TFr_Itens_Produto_Ajt.Pg_MainChange(Sender: TObject);
begin
  inherited;
  ListaTributacao;
end;

procedure TFr_Itens_Produto_Ajt.RG_Tipo_S_EClick(Sender: TObject);
begin
  ListaTributacao;
end;

function TFr_Itens_Produto_Ajt.validaGravacao: Boolean;
begin
  REsult := true;
  if not ValidacaoInicial then
  Begin
    result := False;
    exit;
  End;

  if not validaPreencheEstoque then
  Begin
    REsult := False;
    exit;
  End;
  if not validaPreencheCodigo then
  Begin
    REsult := False;
    exit;
  End;

end;

end.


