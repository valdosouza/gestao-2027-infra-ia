unit Un_Pesq_CEST;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, DBCtrls, Mask, ComCtrls, ExtCtrls, Buttons, Grids, DBGrids, DB, STQuery, ACBrBase, ACBrSocket, ACBrIBPTax, QEdit_Setes;

type
  TFr_Pesq_CEST = class(TForm)
    Qr_Pesquisa: TSTQuery;
    Ds_Pesquisa: TDataSource;
    Panel2: TPanel;
    Grd_Pesquisa: TDBGrid;
    Panel1: TPanel;
    SB_Buscar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Chb_Digitacao: TCheckBox;
    GrBx_Pesquisa: TGroupBox;
    Lb_Descricao: TLabel;
    Label2: TLabel;
    E_BuscaDescricao: TMaskEdit;
    E_BuscaNCM: TMaskEdit;
    SB_Visualizar: TSpeedButton;
    Label1: TLabel;
    E_BuscaCest: TMaskEdit;
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure E_BuscaCodigoChange(Sender: TObject);
    procedure E_BuscaNCMChange(Sender: TObject);
    procedure E_BuscaDescricaoChange(Sender: TObject);
    procedure Chb_DigitacaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Grd_PesquisaDblClick(Sender: TObject);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure E_BuscaCestChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Visualizar : Boolean;
    procedure Pc_Buscar;
  end;

var
  Fr_Pesq_CEST: TFr_Pesq_CEST;

implementation

uses     Un_DM, UN_Sistema, Un_Produtos, UN_MSG, UN_NCM, Un_Regra_Negocio;
{$R *.dfm}

procedure TFr_Pesq_CEST.Pc_Buscar;
var
  Lc_Cest, Lc_NCM, Lc_Descricao: Boolean;
  Lc_SQL: String;
begin
  Lc_SQL := '';
  Screen.Cursor := crHourGlass;

  if E_BuscaCest.Text = '' then Lc_Cest := False else Lc_Cest := True;
  if E_BuscaNCM.Text = '' then Lc_NCM := False else Lc_NCM := True;
  if E_BuscaDescricao.Text = '' then Lc_Descricao := False else Lc_Descricao := True;
  with Qr_Pesquisa do
  Begin
    Active := False;
    SQL.Clear;
    Lc_Sql := 'SELECT * FROM TB_CEST           '+
              'WHERE (CEST IS NOT NULL) ';

    if Lc_Cest then
    Begin
      IF Length(E_BuscaCest.Text) = 7 then
        Lc_SQL := Lc_SQL + '  AND CEST =:CEST '
      else
        Lc_SQL := Lc_SQL + '  AND CEST LIKE:CEST '
    end;
    if Lc_NCM then
    Begin
      IF Length(E_BuscaNCM.Text) = 8 then
        Lc_SQL := Lc_SQL + '  AND NCM =:NCM '
      else
        Lc_SQL := Lc_SQL + '  AND NCM LIKE:NCM ';
    end;
    if Lc_Descricao then Lc_SQL := Lc_SQL + '  AND DESCRICAO LIKE :DESCRICAO ';

    Lc_SQL := Lc_SQL + 'ORDER BY CEST,NCM ';
    SQL.Add(Lc_SQL);
    if Lc_Cest then
    Begin
      IF Length(E_BuscaCest.Text) = 7 then
        ParamByName('CEST').AsString := E_BuscaCest.Text
      else
        ParamByName('CEST').AsString := E_BuscaCest.Text +'%';
    end;
    if Lc_NCM then
    Begin
      IF Length(E_BuscaNCM.Text) = 8 then
        ParamByName('NCM').AsString := E_BuscaNCM.Text
      else
        ParamByName('NCM').AsString := E_BuscaNCM.Text +'%';
    end;
    if Lc_Descricao then ParamByName('DESCRICAO').AsString := '%'+ E_BuscaDescricao.Text +'%';
    Active := True;
    FetchAll;
  end;
  Screen.Cursor := crDefault;
end;

procedure TFr_Pesq_CEST.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Pesq_CEST.SB_BuscarClick(Sender: TObject);
begin
  Pc_Buscar;
end;

procedure TFr_Pesq_CEST.E_BuscaCodigoChange(Sender: TObject);
begin
  if Chb_Digitacao.Checked then
    PC_Buscar;
end;

procedure TFr_Pesq_CEST.E_BuscaNCMChange(Sender: TObject);
begin
  if Chb_Digitacao.Checked then
    PC_Buscar;
end;

procedure TFr_Pesq_CEST.E_BuscaDescricaoChange(Sender: TObject);
begin
  if Chb_Digitacao.Checked then
    PC_Buscar;
end;

procedure TFr_Pesq_CEST.Chb_DigitacaoClick(Sender: TObject);
begin
  if Chb_Digitacao.Checked then Fc_Aq_Geral('G','PESQ_NCM','DIGITACAO','S') else Fc_Aq_Geral('G','PESQ_NCM','DIGITACAO','N');
end;

procedure TFr_Pesq_CEST.FormShow(Sender: TObject);
begin
  Chb_Digitacao.Checked := (Fc_Aq_Geral('L','PESQ_NCM','DIGITACAO','') = 'S');
end;

procedure TFr_Pesq_CEST.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = [])  then
  begin
    case Key of
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_F8  : if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
      VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
    end;
  end
end;

procedure TFr_Pesq_CEST.Grd_PesquisaDblClick(Sender: TObject);
begin
  SB_VisualizarClick(Sender);
end;

procedure TFr_Pesq_CEST.SB_VisualizarClick(Sender: TObject);
begin
  if Qr_Pesquisa.RecordCount > 0 then
    begin
    It_Visualizar := true;
    end;
    Close;
end;

procedure TFr_Pesq_CEST.E_BuscaCestChange(Sender: TObject);
begin
  if Chb_Digitacao.Checked then
    PC_Buscar;
end;

end.
