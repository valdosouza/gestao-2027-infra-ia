unit reg_custo_pedido;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, STQuery, ControllerCustoPedido;

type
  TRegCustoPedido = class(TBaseRegistry)
    Lb_Vl_Unit_Orig: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    E_Vl_Unit_Orig: TEdit;
    E_Descricao: TEdit;
    E_Vl_Unit_Real: TEdit;
    E_bs_Calculo: TEdit;
    E_Vl_Cotacao: TEdit;
    DBG_Custos: TDBGrid;
    Ds_Lista: TDataSource;
    Qr_Lista: TSTQuery;
    procedure DBG_CustosDblClick(Sender: TObject);
    procedure E_Vl_Unit_OrigExit(Sender: TObject);
    procedure E_bs_CalculoExit(Sender: TObject);
    procedure E_Vl_CotacaoExit(Sender: TObject);
    procedure Qr_ListaAfterOpen(DataSet: TDataSet);
    procedure SB_ExcluirClick(Sender: TObject);
  private
    CustoPedido : TControllerCustoPedido;
    FCodigoPedido: Integer;
    procedure setFCodigoPedido(const Value: Integer);
    procedure OpenList;
    function existeRegistro:boolean;
    procedure CalculaCotacao;
  protected
    //Variaveis
    procedure setPerfil;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FinalizaVariaveis;Override;

    procedure ShowData;Override;
    procedure ShowNoData;Override;
    procedure ClearAllFields;Override;
    //inserir
    procedure Insert;Override;
    //Editar
    function ValidateChange():boolean;Override;
    procedure Change;Override;
    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;

    procedure EditionControl;Override;
  public
    property CodigoPedido : Integer read FCodigoPedido write setFCodigoPedido;
  end;

var
  RegCustoPedido: TRegCustoPedido;

implementation

{$R *.dfm}

uses     env, un_msg;
procedure TRegCustoPedido.CalculaCotacao;
Var
  Lc_valor_base : Real;
  Lc_valor_original : Real;
  Lc_cotacao : Real;
  Lc_valor_real : Real;
begin
  Lc_valor_base := StrToFloatDef(E_bs_Calculo.Text,0);
  E_bs_Calculo.Text := FloatToStrF(Lc_valor_base,ffFixed,10,2);

  Lc_valor_original := StrToFloatDef(E_Vl_Unit_Orig.Text,0);
  E_Vl_Unit_Orig.Text := FloatToStrF(Lc_valor_original,ffFixed,10,2);

  Lc_cotacao := StrToFloatDef(E_Vl_Cotacao.Text,1);
  E_Vl_Cotacao.Text := FloatToStrF(Lc_cotacao,ffFixed,10,2);

  Lc_valor_real := Lc_valor_original * Lc_Cotacao;
  E_Vl_Unit_Real.Text := FloatToStrF(Lc_valor_real,ffFixed,10,2);
end;

procedure TRegCustoPedido.Change;
begin
  CodigoRegistro := Qr_Lista.FieldByName('CTP_CODIGO').AsInteger;
  if ( CodigoRegistro > 0 ) then
  Begin
    CustoPedido.Registro.Codigo       := Codigoregistro;
    CustoPedido.Registro.CodigoPedido := FCodigoPedido;
    CustoPedido.getById;
    ShowData;
  End
  else
    ShowNoData;
  EditionState := 'E';
  EditionControl;
end;

procedure TRegCustoPedido.ClearAllFields;
begin
  inherited;

end;

procedure TRegCustoPedido.CriarVariaveis;
begin
  inherited;
  CustoPedido := TControllerCustoPedido.create(self);
end;

procedure TRegCustoPedido.DBG_CustosDblClick(Sender: TObject);
begin
  if ValidateChange then
    Change;
end;

procedure TRegCustoPedido.Delete;
begin
  custoPedido.Registro.Codigo := Qr_Lista.FieldByname('CTP_CODIGO').AsInteger;
  custoPedido.Registro.CodigoPedido := Qr_Lista.FieldByname('CTP_CODPED').AsInteger;
  custoPedido.delete;
end;

procedure TRegCustoPedido.EditionControl;
begin
  EditionControler(Self);
  pnl_fundo.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  SB_Inserir.Enabled := ( EditionState = 'B' ) and Pf_Inserir ;
  SB_Alterar.Enabled := ( EditionState = 'B' ) and ( Qr_Lista.RecordCount > 0 ) and Pf_Alterar;
  SB_Excluir.Enabled := ( EditionState = 'B' ) and ( Qr_Lista.RecordCount > 0 ) and Pf_Excluir;
  SB_gravar.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  SB_Cancelar.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Sb_Sair_0.Enabled := ( EditionState = 'B' ) ;
end;

function TRegCustoPedido.existeRegistro: boolean;
begin
  Result := True;
  if Qr_Lista.RecordCount = 0 then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Nenhum registro encontrado.'+EOLN+
                   'Verifique para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
  End;
end;

procedure TRegCustoPedido.E_bs_CalculoExit(Sender: TObject);
begin
  CalculaCotacao;
end;

procedure TRegCustoPedido.E_Vl_CotacaoExit(Sender: TObject);
begin
  CalculaCotacao;
end;

procedure TRegCustoPedido.E_Vl_Unit_OrigExit(Sender: TObject);
begin
  CalculaCotacao;
end;

procedure TRegCustoPedido.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil( CustoPedido );
end;

procedure TRegCustoPedido.IniciaVariaveis;
begin
  OpenList;
  EditionState := 'B';
  EditionControl;
end;

procedure TRegCustoPedido.Insert;
begin
  inherited;
  E_Descricao.Text := 'CUSTO GERAL';
  E_Descricao.SetFocus;
end;

procedure TRegCustoPedido.OpenList;
begin
  Qr_Lista.active := False;
  Qr_Lista.ParamByName('CTP_CODPED').AsInteger := FCodigoPedido;
  Qr_Lista.active := True;
  Qr_Lista.FetchAll
end;

procedure TRegCustoPedido.Qr_ListaAfterOpen(DataSet: TDataSet);
begin
  (Qr_Lista.FieldByName('CTP_BS_CALCULO') as TNumericField).DisplayFormat  := '0.00';
  (Qr_Lista.FieldByName('CTP_VL_ORIG') as TNumericField).DisplayFormat     := '0.00';
  (Qr_Lista.FieldByName('CTP_COTACAO') as TNumericField).DisplayFormat     := '0.00';
  (Qr_Lista.FieldByName('CTP_VL_REAL') as TNumericField).DisplayFormat     := '0.00';
end;

procedure TRegCustoPedido.Save;
begin
  with custoPedido do
  Begin
    Registro.CodigoPedido   := FCodigoPedido;
    Registro.Descricao      := E_Descricao.Text;
    Registro.BaseCalculo    := StrToFloatDef( E_bs_Calculo.Text,0);
    Registro.ValorOriginal  := StrToFloatDef( E_Vl_Unit_Orig.Text,0);
    Registro.Cotacao        := StrToFloatDef( E_Vl_Cotacao.Text,0);
    Registro.ValorReal      := StrToFloatDef( E_Vl_Unit_Real.Text,0);
  End;
  if EditionState = 'I' then
    custoPedido.insere
  else
    CustoPedido.update;
  OpenList;
end;

procedure TRegCustoPedido.SB_ExcluirClick(Sender: TObject);
begin
  if ValidateDelete then
  Begin
    Delete;
    OpenList;
  End;
end;

procedure TRegCustoPedido.setFCodigoPedido(const Value: Integer);
begin
  FCodigoPedido := Value;
end;

procedure TRegCustoPedido.setPerfil;
begin
  pfMenu := 'Custos do Pedido de Compra';
  inherited;

end;

procedure TRegCustoPedido.ShowData;
begin
  with custoPedido do
  Begin
    E_Descricao.Text    := Registro.Descricao;
    E_bs_Calculo.Text   := FloatToStrF(Registro.BaseCalculo,ffFixed,10,2);
    E_Vl_Unit_Orig.Text := FloatToStrF(Registro.ValorOriginal,ffFixed,10,2);
    E_Vl_Cotacao.Text   := FloatToStrF(Registro.Cotacao,ffFixed,10,2);
    E_Vl_Unit_Real.Text := FloatToStrF(Registro.ValorReal,ffFixed,10,2);
  End;
end;

procedure TRegCustoPedido.ShowNoData;
begin
  E_Descricao.clear;
  E_bs_Calculo.Text   := FloatToStrF(0,ffFixed,10,2);
  E_Vl_Unit_Orig.Text := FloatToStrF(0,ffFixed,10,2);
  E_Vl_Cotacao.Text   := FloatToStrF(0,ffFixed,10,2);
  E_Vl_Unit_Real.Text := FloatToStrF(0,ffFixed,10,2);
end;

function TRegCustoPedido.ValidateChange: boolean;
begin
  Result := TRue;
  if not existeRegistro then
  Begin
    Result := False;
    exit;
  End;
end;

function TRegCustoPedido.ValidateDelete: boolean;
begin
  Result := TRue;
  if (not TMsgSetes.Excluir) then
  Begin
    Result := False;
    exit;
  End;

  if not existeRegistro then
  Begin
    Result := False;
    exit;
  End;
end;

function TRegCustoPedido.ValidateSave: boolean;
begin
  Result := True;
  if Trim(E_Descricao.Text) = '' then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Por favor Preencha o campo descrição.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
  End;

  if StrtoFloatDef(E_Vl_Unit_Orig.Text,0) = 0 then
  Begin
    MensagemPadrao( TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   Lb_Vl_Unit_Orig.caption  +EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    E_Vl_Unit_Orig.SetFocus;
    Result := False;
    exit;
  End;

end;

end.
