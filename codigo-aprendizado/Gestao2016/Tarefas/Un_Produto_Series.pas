unit Un_Produto_Series;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.ComCtrls, STDataSet, ControllerSerieProduto, ControllerSerieVeiculo;

type
  TFr_Produto_Serie = class(TForm)
    Pg_series: TPageControl;
    Tbs_Pesquisa: TTabSheet;
    Tbs_Serie_Produto: TTabSheet;
    Pn_Geral: TPanel;
    Pn_Serie: TPanel;
    Pn_Botoes_L: TPanel;
    Tbs_Serie_Veiculo: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    SB_Grv_Veiculo: TSpeedButton;
    SB_Can_Veiculo: TSpeedButton;
    Label1: TLabel;
    Cbx_Tipo: TComboBox;
    E_Chassi: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    E_PesoLiq: TEdit;
    Panel4: TPanel;
    SB_Grv_Series: TSpeedButton;
    Sb_Can_Series: TSpeedButton;
    Sb_Sair_1: TSpeedButton;
    Label5: TLabel;
    E_PesoBruto: TEdit;
    Label6: TLabel;
    E_NMotor: TEdit;
    Label7: TLabel;
    E_Cmkg: TEdit;
    Label8: TLabel;
    E_Potencia: TEdit;
    Label9: TLabel;
    E_Cm3: TEdit;
    Label10: TLabel;
    E_Eixos: TEdit;
    Cbx_Combustivel: TComboBox;
    Label11: TLabel;
    E_Renavam: TEdit;
    Label12: TLabel;
    E_CodMc_Md: TEdit;
    Label13: TLabel;
    E_AnoModFab: TEdit;
    Label14: TLabel;
    E_AnoFabricacao: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    Cb_Especie: TComboBox;
    Label17: TLabel;
    Label18: TLabel;
    E_Pintura: TEdit;
    E_Cor: TEdit;
    Label19: TLabel;
    E_DescCor: TEdit;
    Label20: TLabel;
    E_CondVIN: TEdit;
    Label21: TLabel;
    E_Serie: TEdit;
    E_Detalhes: TMemo;
    Label23: TLabel;
    Label24: TLabel;
    Qr_Pesquisa: TSTQuery;
    E_SerieV: TEdit;
    Ds_TPVeiculo: TDataSource;
    Ds_Pesquisa: TDataSource;
    SB_Veiculo: TSpeedButton;
    Cb_TipoVeiculo: TComboBox;
    Cbx_CondVeiculo: TRadioGroup;
    SB_Cadastrar: TSpeedButton;
    SB_Desmarcar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    SB_Alterar: TSpeedButton;
    SB_Marcar: TSpeedButton;
    DBGrid1: TDBGrid;
    SB_EXCLUIR: TSpeedButton;
    Qr_Acao: TSTQuery;
    procedure SB_MarcarClick(Sender: TObject);
    procedure SB_Grv_VeiculoClick(Sender: TObject);
    procedure SB_Can_VeiculoClick(Sender: TObject);
    procedure SB_Grv_SeriesClick(Sender: TObject);
    procedure Sb_Can_SeriesClick(Sender: TObject);
    procedure Sb_Sair_1Click(Sender: TObject);
    procedure SB_CadastrarClick(Sender: TObject);
    procedure SB_VeiculoClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_DesmarcarClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure SB_EXCLUIRClick(Sender: TObject);
    procedure Tbs_PesquisaShow(Sender: TObject);
    procedure Tbs_Serie_ProdutoShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    SerieProduto: TControllerSerieProduto;
    SerieVeiculo: TControllerSerieVeiculo;
    EditionState : String;
    procedure EditionControl;

    procedure Pc_FormataTela;
    procedure Pc_Buscar(Pc_Qry:TSTQuery);
    function Fc_QtdeSeries(Pc_Tipo:String):Integer;
    Function Fc_ValidaSerieProduto:Boolean;
    procedure GravaSerieProduto;

    Function Fc_ValidaSerieVeiculo:Boolean;
    procedure GravaSerieVeiculo;

    function Fc_ValidaMarcacao():Boolean;
    function Fc_ValidaDesmarcacao():Boolean;
    function Fc_ValidaCadastro():Boolean;
    function Fc_ValidaAlteracao():Boolean;
    function Fc_ValidaExclusao():Boolean;
    procedure Pc_MarcaDesmarca(Pc_Cd_Serie, Pc_Cd_Item: Integer);

  public
    { Public declarations }
    It_cd_Serie: Integer;
    It_cd_Item: Integer;
    It_cd_Produto: Integer;
    It_Qt_Produto: Real;
    Faturado : Boolean;
  end;

var
  Fr_Produto_Serie: TFr_Produto_Serie;

implementation

uses     Un_DM, StrUtils, UN_Sistema, UN_MSG, env;
{$R *.dfm}

procedure TFr_Produto_Serie.Pc_MarcaDesmarca(Pc_Cd_Serie, Pc_Cd_Item: Integer);
begin
  SerieProduto.Registro.Codigo := Pc_Cd_Serie;
  SerieProduto.Registro.Saida := Pc_Cd_Item;
  SerieProduto.update;
end;

function TFr_Produto_Serie.Fc_QtdeSeries(Pc_Tipo:String):Integer;
Begin
  Result := 0;
  Pc_Buscar(Qr_Acao);
  Qr_Acao.First;
  while not Qr_Acao.Eof do
    Begin
    if Pc_Tipo = 'Registrada' then
      Result := Result + 1;
    if Pc_Tipo = 'Marcadas' then
      if Qr_Acao.FieldByName('SRP_CODSAI').AsInteger > 0 then
        Result := Result + 1;
    Qr_Acao.Next;
    end;
end;


function TFr_Produto_Serie.Fc_ValidaCadastro():Boolean;
Begin
  Result := true;
  If (Fr_Produto_Serie.Tag = 2) then
    begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Esta não é uma operação de entrada.' + EOLN+
                   'Não é possível incluir séries.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
    end;
      
  if Fc_QtdeSeries('Registrada') >= It_Qt_Produto then
    begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'A quantidade de séries não pode ser maior do que a quantidade de produtos.' + EOLN +
                   'Verifique antes de continuar.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    end
end;

function TFr_Produto_Serie.Fc_ValidaAlteracao():Boolean;
Begin
  Result := true;
  If (Fr_Produto_Serie.Tag = 2) then
    begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Esta não é uma operação de entrada.' + EOLN+
                   'Não é possível alterar a série.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
    end;
    
  If Qr_Pesquisa.RecordCount <= 0 then
    begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Não há registros para serem alterados.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
    end;
end;

function TFr_Produto_Serie.Fc_ValidaExclusao():Boolean;
Begin
  Result := true;
  If (Fr_Produto_Serie.Tag = 2) then
    begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Esta não é uma operação de entrada.' + EOLN+
                   'Não é possível excluir a série.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
    end;
    
  If Qr_Pesquisa.RecordCount <= 0 then
    begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Não há registros para serem excluÍdos.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
    end;
end;

function TFr_Produto_Serie.Fc_ValidaMarcacao():Boolean;
Begin
  Result := true;
  If (FAturado) then
  begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Documento Faturado.' + EOLN+
                   'Não é possível marcar a série.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;

  If (Fr_Produto_Serie.Tag = 1) then
  begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Esta não é uma operação de Saida.' + EOLN+
                   'Não é possível marcar a série.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;


  If Qr_Pesquisa.RecordCount <= 0 then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Não há registros para serem marcados.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;

  if (Fc_QtdeSeries('Marcadas') >= It_Qt_Produto) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'A quantidade de séries não pode ser maior do que a quantiade de produtos.' + EOLN +
                   'Não é possível marcar mais séries.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
  end;
end;

function TFr_Produto_Serie.Fc_ValidaDesmarcacao():Boolean;
Begin
  Result := true;
  If (FAturado) then
  begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Documento Faturado.' + EOLN+
                   'Não é possível Desmarcar a série.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;


  If Qr_Pesquisa.RecordCount <= 0 then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Não há registros para serem desmarcados.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;
    
  If (Fr_Produto_Serie.Tag = 1) then
  begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Esta não é uma operação de Saida.' + EOLN+
                   'Não é possível desmarcar a série.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;

  if (Qr_Pesquisa.FieldByName('SRP_CODSAI').AsInteger = 0) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'O item não está marcado.' + EOLN +
                   'Não é possível demarcar.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
  end;
end;

procedure TFr_Produto_Serie.SB_MarcarClick(Sender: TObject);
begin
  if Fc_ValidaMarcacao then
  Begin
    It_cd_Serie := Qr_Pesquisa.FieldByName('SRP_CODIGO').AsInteger;
    Pc_MarcaDesmarca(It_cd_Serie, It_cd_Item);
    Pc_Buscar(Qr_Pesquisa);
  End;
end;

procedure TFr_Produto_Serie.SB_Grv_VeiculoClick(Sender: TObject);
begin
  if Fc_ValidaSerieVeiculo then
  Begin
    GravaSerieVeiculo;
    ShowMessage('Registro salvo com sucesso !!..');
    Close;
  end;
end;

procedure TFr_Produto_Serie.SB_Can_VeiculoClick(Sender: TObject);
begin
  EditionState := 'B';
  EditionControl;
  Pg_series.ActivePageIndex := 1;
end;

procedure TFr_Produto_Serie.SB_Grv_SeriesClick(Sender: TObject);
begin
  if Fc_ValidaSerieProduto then
  Begin
    GravaSerieProduto;
  End;
end;

procedure TFr_Produto_Serie.Sb_Can_SeriesClick(Sender: TObject);
begin
  If ( (EditionState = 'I') OR (EditionState = 'E') ) then
  begin
    EditionState := 'B';
    if (Fr_Produto_Serie.Tag < 3) then
      Pg_series.ActivePageIndex := 0
    else
      Close;
  end;
end;

procedure TFr_Produto_Serie.Sb_Sair_1Click(Sender: TObject);
begin
  if (Fr_Produto_Serie.Tag < 3) then
    Pg_series.ActivePageIndex := 0
  else
    Close;
end;

procedure TFr_Produto_Serie.Pc_Buscar(Pc_Qry:TSTQuery);
var
  Lc_SQLTxt: String;
begin
  Pc_Qry.Active := False;
  Pc_Qry.SQL.Clear;
  case Fr_Produto_Serie.Tag of
    1:Begin
      Lc_SQLTxt := 'SELECT SRP_CODIGO, SRP_NUMERO, SRP_CODSAI  FROM TB_SERIE_PRODUTO  '+
                   'WHERE (SRP_CODENT =:SRP_CODENT)                       '+
                   '  AND (SRP_CODPRO=:SRP_CODPRO)                        '+
                   '  AND ( (SRP_CODSAI IS NULL) or (SRP_CODSAI = 0) )    '+
                   'ORDER BY SRP_NUMERO ';
      Pc_Qry.SQL.Add(Lc_SQLTxt);
      Pc_Qry.ParamByName('SRP_CODENT').AsInteger := It_cd_Item;
      Pc_Qry.ParamByName('SRP_CODPRO').AsInteger := It_cd_Produto;
      end;
    2:
      begin
      Lc_SQLTxt := 'SELECT SRP_CODIGO, SRP_NUMERO, SRP_CODSAI  FROM TB_SERIE_PRODUTO             '+
                   'WHERE ( (SRP_CODSAI=:SRP_CODSAI) OR (SRP_CODSAI IS NULL) OR (SRP_CODSAI =0) ) '+
                   '  AND (SRP_CODPRO=:SRP_CODPRO)                                                ';
      if not Faturado then
        Lc_SQLTxt := Lc_SQLTxt +'  AND (SRP_DISPON= ''S'') '
      else
        Lc_SQLTxt := Lc_SQLTxt +'  AND (SRP_DISPON= ''N'') ';
      Lc_SQLTxt := Lc_SQLTxt +' ORDER BY SRP_NUMERO ';
      Pc_Qry.SQL.Add(Lc_SQLTxt);
      Pc_Qry.ParamByName('SRP_CODSAI').AsInteger := It_cd_Item;
      Pc_Qry.ParamByName('SRP_CODPRO').AsInteger := It_Cd_Produto;
      end;
    end;
  Pc_Qry.Active := True;
  Pc_Qry.FetchAll;
end;

procedure TFr_Produto_Serie.SB_CadastrarClick(Sender: TObject);
begin
  if Fc_ValidaCadastro then
  Begin
    Pg_series.ActivePageIndex := 1;
    SerieProduto.clear;
    It_cd_Serie := 0;
    E_Serie.SetFocus;
  End;
end;


procedure TFr_Produto_Serie.SB_VeiculoClick(Sender: TObject);
begin
  MensagemPadrao(TITULO_INFORMACAO,ATENCAO+EOLN+EOLN+
                 'Em desenvolvimento.'+EOLN+
                 'Verifique a necessidade com o desenvolvedor.'+EOLN,
                ['OK'],[bEscape],mpAlerta);
  {
  SerieVeiculo.Clear;
  SerieVeiculo.Registro.Codigo := SerieProduto.Registro.Codigo;
  SerieVeiculo.getbyId;
  if (SerieVeiculo.exist) then
    EditionState := 'E'
  else
    EditionState := 'I';
  Pg_series.ActivePage := Tbs_Serie_Veiculo;
  Cbx_Tipo.SetFocus;
  }
end;

procedure TFr_Produto_Serie.EditionControl;
begin
  {
  Cbx_Tipo.Enabled        := ( (EditionState = 'I') or (EditionState = 'B') );
  E_Chassi.Enabled        := ( (EditionState = 'I') or (EditionState = 'B') );
  E_NMotor.Enabled        := ( (EditionState = 'I') or (EditionState = 'B') );
  E_Cmkg.Enabled          := ( (EditionState = 'I') or (EditionState = 'B') );
  E_Potencia.Enabled      := ( (EditionState = 'I') or (EditionState = 'B') );
  E_Cm3.Enabled           := ( (EditionState = 'I') or (EditionState = 'B') );
  E_PesoLiq.Enabled       := ( (EditionState = 'I') or (EditionState = 'B') );
  E_PesoBruto.Enabled     := ( (EditionState = 'I') or (EditionState = 'B') );
  Cbx_Combustivel.Enabled := ( (EditionState = 'I') or (EditionState = 'B') );
  E_Eixos.Enabled         := ( (EditionState = 'I') or (EditionState = 'B') );
  E_Renavam.Enabled       := ( (EditionState = 'I') or (EditionState = 'B') );
  E_CodMc_Md.Enabled      := ( (EditionState = 'I') or (EditionState = 'B') );
  E_AnoModFab.Enabled     := ( (EditionState = 'I') or (EditionState = 'B') );
  E_AnoFabricacao.Enabled := ( (EditionState = 'I') or (EditionState = 'B') );
  CmboBox1.Enabled     := ( (EditionState = 'I') or (EditionState = 'B') );
  Cbx_Especie.Enabled     := ( (EditionState = 'I') or (EditionState = 'B') );
  E_Pintura.Enabled       := ( (EditionState = 'I') or (EditionState = 'B') );
  E_Cor.Enabled           := ( (EditionState = 'I') or (EditionState = 'B') );
  E_DescCor.Enabled       := ( (EditionState = 'I') or (EditionState = 'B') );
  E_CondVIN.Enabled       := ( (EditionState = 'I') or (EditionState = 'B') );
  Cbx_CondVeiculo.Enabled := ( (EditionState = 'I') or (EditionState = 'B') );
  }
end;

procedure TFr_Produto_Serie.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;


procedure TFr_Produto_Serie.SB_DesmarcarClick(Sender: TObject);
begin
  if Fc_ValidaDesmarcacao then
  Begin
    Pc_MarcaDesmarca(Qr_Pesquisa.FieldByName('SRP_CODIGO').AsInteger, 0);
    Pc_Buscar(Qr_Pesquisa);
  End;
end;

procedure TFr_Produto_Serie.SB_AlterarClick(Sender: TObject);
begin
  if not Fc_ValidaAlteracao then exit; 
  Pg_series.ActivePageIndex := 1;
  It_cd_Serie := Qr_Pesquisa.FieldByName('SRP_CODIGO').AsInteger;
  SerieProduto.Registro.Codigo := It_cd_Serie;
  SerieProduto.getbyId;
  EditionState := 'E';
end;

procedure TFr_Produto_Serie.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  Lc_Tipo: String;
begin
  if (Fr_Produto_Serie.Tag = 2) then
  Begin
    if (Qr_Pesquisa.FieldByName('SRP_CODSAI').AsInteger > 0) then
      begin
      Dbgrid1.Canvas.Brush.Color:= clRed;
      DBGrid1.Canvas.FillRect(Rect);
      end;
  end;
  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFr_Produto_Serie.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil( SerieProduto );
  FreeAndNil( SerieVeiculo );
end;

procedure TFr_Produto_Serie.FormCreate(Sender: TObject);
begin
  SerieProduto := TControllerSerieProduto.create(Self);
  SerieVeiculo := TControllerSerieVeiculo.create(Self);
end;

procedure TFr_Produto_Serie.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = []) then
    begin
    case Pg_series.ActivePageIndex of
      0:Begin
        case Key of
          VK_F2     : if SB_Cadastrar.Enabled then Sb_Can_SeriesClick(Sender);
          VK_F3     : if SB_Alterar.Enabled   then SB_AlterarClick(Sender);
          VK_F4     : if SB_EXCLUIR.Enabled   then SB_ExcluirClick(Sender);
          VK_F5     : if SB_Marcar.Enabled    then SB_MarcarClick(Sender);
          VK_F6     : if SB_Desmarcar.Enabled then SB_DesmarcarClick(Sender);
          VK_Escape : if Sb_Sair_0.Enabled    then Sb_Sair_0Click(Sender);
          end;
        end;
      1:Begin
        case Key of
          VK_F4     : if SB_Veiculo.Enabled   then SB_VeiculoClick(Sender);
          VK_F5     : if SB_Grv_Series.Enabled    then SB_Grv_SeriesClick(Sender);
          VK_F6     : if Sb_Can_Series.Enabled then Sb_Can_SeriesClick(Sender);
          VK_Escape : if Sb_Sair_1.Enabled    then Sb_Sair_1Click(Sender);
          end;
        end;
      2:Begin
        case Key of
          VK_F5     : if SB_Grv_Veiculo.Enabled    then SB_Grv_VeiculoClick(Sender);
          VK_F6     : if SB_Can_Veiculo.Enabled then SB_Can_VeiculoClick(Sender);
          end;
        end;
      end;
    end;
end;

function TFr_Produto_Serie.Fc_ValidaSerieProduto: Boolean;
Var
  Sql_Txt : String;
  Lc_Serie : TControllerSerieProduto;
  lc_existe : Boolean;
begin
  Result:=true;
  if trim(E_Serie.Text) ='' then
    begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Número de Série Produto não preenchido.'+EOLN+
                   'Preencha  o Número de Série do Produto.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    E_Serie.SetFocus;
    exit;
    end;
  Lc_Serie := TControllerSerieProduto.create(self);
  Try
    Lc_Serie.Parametros.FieldName.Codigo := SerieProduto.Registro.Codigo;
    Lc_Serie.Parametros.FieldName.Numero := E_Serie.Text;
    lc_existe := Lc_Serie.existeNumero;
  Finally
    FreeAndNil(Lc_Serie);
  End;
  if lc_existe then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Número de Série Produto já existe e está disponivel.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    E_Serie.SetFocus;
    exit;
  end;
end;

function TFr_Produto_Serie.Fc_ValidaSerieVeiculo: Boolean;
begin
  Result := True;
end;

procedure TFr_Produto_Serie.Pc_FormataTela;
var
  Lc_I: Integer;
begin
  for LC_I := 1 to Pg_Series.PageCount do
    Pg_Series.Pages[LC_I - 1].TabVisible := False;
  Pg_Series.ActivePageIndex := 0;
  Case Fr_Produto_Serie.tag of
    1:Begin
        Caption := 'Série de Produtos - Entrada';
      end;
    2:Begin
        Caption := 'Série de Produtos - Saída';
      end;
    3:Begin
        Caption := 'Edição das séries pelo cadastro dos produtos';
        Pg_series.ActivePageIndex := 1;
        SerieProduto.Registro.Codigo := It_cd_Serie;
        SerieProduto.getbyId;
        EditionState := 'E';
      end;
  end;
end;

procedure TFr_Produto_Serie.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
end;

procedure TFr_Produto_Serie.GravaSerieProduto;
begin
  if Faturado then
    SerieProduto.Registro.Disponivel := 'S';

  case Fr_Produto_Serie.Tag of
    1:Begin
        SerieProduto.Registro.Entrada := It_cd_Item; // COMPRA
        SerieProduto.Registro.Produto := It_cd_Produto;
        SerieProduto.salva;
        Pg_series.ActivePageIndex := 0;
        Pc_Buscar(Qr_Pesquisa);
      end;
    2:Begin
        SerieProduto.Registro.Saida := It_cd_Item; // VENDA
        SerieProduto.Registro.Produto := It_cd_Produto;
        SerieProduto.salva;
        Pg_series.ActivePageIndex := 0;
        Pc_Buscar(Qr_Pesquisa);
      end;
    3:Begin
        SerieProduto.Registro.Disponivel := 'S';         // PRODUTO
        SerieProduto.Registro.Produto := It_cd_Produto;
        SerieProduto.salva;
        Close;
      end;
  end;
end;

procedure TFr_Produto_Serie.GravaSerieVeiculo;
begin
  with SerieVeiculo do
  Begin
    {
    Registro.Item             := It_cd_Serie;
    Registro.TipoOperacao     := Cbx_Tipo.Text;
    Registro.Chassi           := E_Chassi.Text;
    Registro.CodiCor          := E_NMotor.Text;
    Registro.DescricaoCor     := E_DescCor.Text;
    Registro.PotenciaMotor    := E_Potencia.Text;
    //Registro.Cilindrada       := e_c
    Registro.PesoLiquido      := E_PesoLiq.Text;
    Registro.PesoBruto        := E_PesoBruto.Text;
    Registro.Serie            := E_Serie.Text;
    Registro.TipoCombutivel   := Cb_TipoVeiculo.Text;
    Registro.NumeroMotor      :=
    Registro.CMT              :=
    Registro.DistanciaEixo    :=  e_di
    Registro.AnoModelo        :=
    Registro.AnoFabricacao    :=
    Registro.TipoPintura      :=
    Registro.TipoVeiculo      :=
    Registro.CodigoEPV        :=
    Registro.CodigoVin        :=
    Registro.CondicaoVeiculo  :=
    Registro.CodigoModelo     :=
    Registro.CodCor           :=
    Registro.Lota             :=
    Registro.CodRTV           :=
    }
  end;

end;

procedure TFr_Produto_Serie.SB_EXCLUIRClick(Sender: TObject);
var
qr_aux:TSTQuery;
begin
  if not Fc_ValidaExclusao then exit;  
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja realmente excluir a Série.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  begin
    It_cd_Serie := Qr_Pesquisa.FieldByName('SRP_CODIGO').AsInteger;
    Pg_series.ActivePageIndex := 1;
    SerieProduto.Registro.Codigo := It_cd_Serie;
    SerieProduto.delete;
    Pc_Buscar(Qr_Pesquisa);
  end;
end;

procedure TFr_Produto_Serie.Tbs_PesquisaShow(Sender: TObject);
begin
  if (Fr_Produto_Serie.Tag < 3) then
  Pc_Buscar(Qr_Pesquisa);
end;


procedure TFr_Produto_Serie.Tbs_Serie_ProdutoShow(Sender: TObject);
begin
  if E_Serie.CanFocus then E_Serie.Setfocus
end;

end.

