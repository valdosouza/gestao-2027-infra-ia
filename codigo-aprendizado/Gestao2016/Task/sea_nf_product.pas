unit sea_nf_product;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.Provider, Un_base_Pesq, Datasnap.DBClient, Vcl.Menus, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, Un_Fm_ListaColaboradores, Vcl.ComCtrls, base_search, STQuery;

type
  TSeaNfProduct = class(TFr_Base_Pesq)
    ChBx_Periodo: TCheckBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Label36: TLabel;
    E_BuscaNota: TMaskEdit;
    Fm_VendedorPedido: TFm_ListaColaboradores;
    Rg_Modelo: TRadioGroup;
    Qr_PesquisaNFL_CODIGO: TIntegerField;
    Qr_PesquisaPED_NUMERO: TIntegerField;
    Qr_PesquisaNFL_DT_EMISSAO: TDateField;
    Qr_PesquisaEMP_FANTASIA: TStringField;
    Qr_PesquisaEMP_NOME: TStringField;
    Qr_PesquisaNFL_VL_TL_NOTA: TBCDField;
    Qr_PesquisaNFL_MODELO: TStringField;
    Qr_PesquisaNFL_SERIE: TStringField;
    Qr_PesquisaNFL_NUMERO: TStringField;
    SB_Bl_Add_Tudo: TSpeedButton;
    SB_Bl_Retirar_Tudo: TSpeedButton;
    procedure SB_Bl_Add_TudoClick(Sender: TObject);
    procedure SB_Bl_Retirar_TudoClick(Sender: TObject);
  private
    { Private declarations }
    function Fc_VerificaMarcado(Fc_grid:TStringGrid):Boolean;
    Procedure GetEscolhidos;
  protected
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure PassagemParametros;Override;
    procedure Visualiza;Override;
    procedure Buscar;Override;
  public
    Escolhidos : String;
    { Public declarations }
  end;

var
  SeaNfProduct: TSeaNfProduct;

implementation

{$R *.dfm}

uses     Un_Msg, env;

{ TSeaNfProduct }

{ TSeaNfProduct }

procedure TSeaNfProduct.Buscar;
begin
  inherited;
  SB_Bl_Add_Tudo.Enabled:= (Qr_Pesquisa.RecordCount > 0);
  SB_Bl_Retirar_Tudo.Enabled:= (Qr_Pesquisa.RecordCount > 0);

end;

function TSeaNfProduct.Fc_VerificaMarcado(Fc_grid: TStringGrid): Boolean;
Var
  Lc_I : Integer;
Begin
  with Fc_grid do
  Begin
    Result := False;
    For Lc_I := 1 to RowCount - 1 do
    Begin
      if Cells[2,Lc_I] = 'X' then
      Begin
        Result := true;
        break;
      end;
    end;
  end;
  if not Result then
  Begin
    MensagemPadrao(ATENCAO,
                   'Nenhum registro foi selecionado.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
  end;
end;

procedure TSeaNfProduct.FormataTela;
begin
  inherited;

end;

procedure TSeaNfProduct.GetEscolhidos;
Var
  Lc_I : Integer;
Begin
  with Grd_Pesquisa do
  Begin
    Escolhidos := '';
    For Lc_I := 1 to RowCount - 1 do
    Begin
      if Cells[2,Lc_I] = 'X' then
      Begin
        if (Escolhidos = '') then
          Escolhidos := Cells[3,Lc_I]
        else
          Escolhidos := concat(Escolhidos, ',',Cells[3,Lc_I])
      end;
    end;
    if (Escolhidos <> '') then
      Escolhidos := concat( '( ', Escolhidos, ' )' );
  end;
end;

procedure TSeaNfProduct.IniciaVariaveis;
begin
  inherited;
  Visualizar := False;
  MultiSelect := True;
  E_Data_Ini.DateTime := date  -7;
  E_Data_Fim.DateTime := date ;
  Fm_VendedorPedido.ListaVendedor;
end;

procedure TSeaNfProduct.InnerJoinSql;
begin
  if Rg_Modelo.ItemIndex = 1 then
  Begin
    sQLtXT :=  sQLtXT +
                     '  INNER JOIN TB_RETORNO_NFC '+
                     '  ON (NFC_CODNFL = NFL_CODIGO) ';
  End
  else
  Begin
    sQLtXT :=  sQLtXT +
                    '  INNER JOIN TB_RETORNO_NFE '+
                    '  ON (NFE_CODNFL = NFL_CODIGO) ';
  End;
end;


procedure TSeaNfProduct.OrderBy;
begin
  inherited;

end;

procedure TSeaNfProduct.PassagemParametros;
begin
  inherited;
  with Qr_Pesquisa do
  Begin
    if ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    end;
    if Trim(E_BuscaNota.Text) <> '' then
      ParamByName('NFL_NUMERO').AsString := '%' + E_BuscaNota.Text;
    if Fm_VendedorPedido.Dblcb_Vendedor.Text <> '' then
      ParamByName('PED_CODVDO').AsInteger := Fm_VendedorPedido.Dblcb_Vendedor.KeyValue;
  End;
end;

procedure TSeaNfProduct.SB_Bl_Add_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  with Grd_Pesquisa do
  Begin
    For LC_I := 1 to RowCount -1 do
      Begin
      Cells[2,Lc_I] := 'X';
      end;
    Repaint;
  end;
end;

procedure TSeaNfProduct.SB_Bl_Retirar_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  with Grd_Pesquisa do
  Begin
    For LC_I := 1 to RowCount -1 do
      Begin
      Cells[2,Lc_I] := '';
      end;
    Repaint
  End;
end;

procedure TSeaNfProduct.SelectSql;
begin
  sQLtXT := 'SELECT NFL_CODIGO,  PED_NUMERO, NFL_NUMERO,  '+
               'NFL_DT_EMISSAO, NFL_TIPO,EMP_FANTASIA, EMP_NOME,NFL_VL_TL_NOTA, '+
               'NFL_MODELO, NFL_SERIE  '+
               'FROM TB_NOTA_FISCAL Tb_nota_fiscal '+
               '  INNER JOIN TB_EMPRESA tb_empresa '+
               '  ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
               '  INNER JOIN TB_PEDIDO tb_pedido '+
               '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) ';

end;

procedure TSeaNfProduct.Visualiza;
begin
  inherited;
  Visualizar := False;
  if Fc_VerificaMarcado(Grd_Pesquisa) then
  Begin
    Visualizar := True;
    GetEscolhidos;
    Close;
  end;
end;

procedure TSeaNfProduct.WhereSql;
begin
  inherited;
  if ChBx_Periodo.Checked then
    sQLtXT := sQLtXT + ' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ';

  case Rg_Modelo.ItemIndex of
    0:SqlTxt := sQLtXT  + ' AND (NFL_MODELO <> ''65'') ';
    1:sQLtXT := sQLtXT  + ' AND (NFL_MODELO = ''65'') ';
  end;
  if Trim(E_BuscaNota.Text) <> '' then
    sQLtXT := sQLtXT + 'AND NFL_NUMERO LIKE :NFL_NUMERO ';

  sQLtXT := sQLtXT  + ' AND  ( (PED_TIPO = 0 ) ';
  sQLtXT := sQLtXT  + ' OR (PED_TIPO = 1) OR (PED_TIPO = 4 ) ';
  sQLtXT := sQLtXT  + ' ) ';
  if Fm_VendedorPedido.Dblcb_Vendedor.Text <> '' then
    sQLtXT := sQLtXT + 'AND PED_CODVDO =:PED_CODVDO ';

end;

end.
