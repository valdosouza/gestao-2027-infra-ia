unit Un_PesqPedPizza;

interface

uses
      Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, Mask, Grids, DBGrids, Db, STQuery, ExtCtrls, STDatabase, STTransaction;

type
   TFr_PesqPedPizza = class(TForm)
    Ds_Pesquisa: TDataSource;
    Qr_Pesquisa: TSTQuery;
    Dbg_Pesquisa: TDBGrid;
    Panel1: TPanel;
    Sb_Confirma: TSpeedButton;
    Sb_Buscar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Qr_PesquisaPED_NUMERO: TIntegerField;
    Qr_PesquisaPED_CODIGO: TIntegerField;
    Qr_PesquisaPED_CODEMP: TIntegerField;
    Qr_PesquisaPED_DATA: TDateField;
    Qr_PesquisaEMP_NOME: TStringField;
    Qr_PesquisaPED_VL_PEDIDO: TBCDField;
    Qr_PesquisaTM_INICIO: TStringField;
    Panel2: TPanel;
    Rg_Situacao: TRadioGroup;
    GroupBox1: TGroupBox;
    E_BuscaDescricao: TMaskEdit;
    Qr_PesquisaPED_CODWEB: TIntegerField;
    IBT_Transacao: TSTTransaction;
    Label1: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Rg_SituacaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure Sb_BuscarClick(Sender: TObject);
    procedure Sb_ConfirmaClick(Sender: TObject);
    procedure Dbg_PesquisaTitleClick(Column: TColumn);
    procedure Dbg_PesquisaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    Function  Fc_ValidaConfirma():Boolean;
    procedure Pc_ImagemBotao;
  public
    { Public declarations }
    It_cd_Pedido : Integer;
    procedure Pc_Busca;
  end;

var
  Fr_PesqPedPizza: TFr_PesqPedPizza;

implementation

uses     UN_Sistema, Un_DM, UN_MSG, UN_Principal, env, RI_MovimentoFinanceiro;
{$R *.DFM}

procedure TFr_PesqPedPizza.Pc_ImagemBotao;
BEgin
  with fr_principal do
  Begin
    Sb_Buscar.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    Sb_Confirma.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

procedure TFr_PesqPedPizza.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F7  : if Sb_Buscar.Enabled then Sb_BuscarClick(Sender);
      VK_F10 : if Sb_Confirma.Enabled then Sb_ConfirmaClick(Sender);
      VK_ESCAPE  : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_PesqPedPizza.Rg_SituacaoClick(Sender: TObject);
begin
  Sb_BuscarClick(sender);  
end;

procedure TFr_PesqPedPizza.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  E_BuscaDescricao.SetFocus;
  E_BuscaDescricao.SelectAll;
end;

procedure TFr_PesqPedPizza.Pc_Busca;
var
  Lc_SqlTxt : String;
  Lc_Data,Lc_Cliente:Boolean;
begin
  with Qr_Pesquisa do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    Active:=False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT r.tm_inicio, p.PED_NUMERO, p.PED_CODIGO, p.PED_CODEMP,'+
                 'p.PED_DATA , DESCRICAO EMP_NOME, p.PED_VL_PEDIDO, p.PED_CODWEB '+
                 ' FROM TB_PEDIDO p '+
                 '   INNER JOIN TB_EMPRESA e '+
                 '   ON (e.emp_codigo = p.ped_codemp) '+
                 '   INNER JOIN TB_RESTAURANTE r '+
                 '   ON (r.TB_PEDIDO_ID = p.PED_CODIGO )'+
                  'WHERE (PED_FATURADO=:PED_FATURADO) ';

    Lc_Data := True;
    if Trim(E_BuscaDescricao.Text) <> '' then Lc_Cliente := true else Lc_Cliente := False;

    if Lc_Data then Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_DATA=:PED_DATA) ';
    IF Lc_Cliente then  Lc_SqlTxt := Lc_SqlTxt + 'AND (EMP_NOME LIKE :EMP_NOME) ';
    
    Lc_SqlTxt := Lc_SqlTxt + 'ORDER BY PED_NUMERO ';

    sql.Add(Lc_SqlTxt);
    
    if Lc_Data then ParamByName('PED_DATA').AsDate := Gb_Datacaixa;
    IF Lc_Cliente then  ParamByName('EMP_NOME').AsString:='%'+ E_BuscaDescricao.Text+'%';
    case Rg_Situacao.ItemIndex of
      0 : ParamByName('PED_FATURADO').AsString := 'N';
      1 : ParamByName('PED_FATURADO').AsString := 'S';
      2 : ParamByName('PED_FATURADO').AsString := 'A'; //apagado
    end;    
    Active:=True;
  end;
end;

procedure TFr_PesqPedPizza.Sb_Sair_0Click(Sender: TObject);
begin
  It_cd_Pedido := 0;
  Close;
end;

procedure TFr_PesqPedPizza.Sb_BuscarClick(Sender: TObject);
begin
  Pc_Busca;
end;

procedure TFr_PesqPedPizza.Dbg_PesquisaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Ds_Pesquisa.DataSet.FieldByName('PED_CODWEB').AsInteger > 0 then
  Begin
    Dbg_Pesquisa.Canvas.Font.Color := clBlue;
    Canvas.Brush.Color := clWhite;
  End;
  Dbg_Pesquisa.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TFr_PesqPedPizza.Dbg_PesquisaTitleClick(Column: TColumn);
begin
 Pc_Pintar_Grid_Ordenar(DBG_Pesquisa, Column);
end;

Function  TFr_PesqPedPizza.Fc_ValidaConfirma():Boolean;
Begin
  Result := True;
  if Qr_Pesquisa.RecordCount = 0 then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Nenhum registro foi selecionado.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    REsult := False;
    Exit;
  end;

end;

procedure TFr_PesqPedPizza.Sb_ConfirmaClick(Sender: TObject);
begin
  if Fc_ValidaConfirma then
  Begin
    It_Cd_Pedido := Qr_Pesquisa.FieldByName('PED_CODIGO').AsInteger;
    if DM.IBT_Crud.InTransaction then DM.IBT_Crud.Commit;
    Close;
  end;
end;

end.
