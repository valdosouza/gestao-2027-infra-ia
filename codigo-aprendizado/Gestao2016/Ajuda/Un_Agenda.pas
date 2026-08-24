unit Un_Agenda;

interface

uses
      STQuery, Data.DB, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Controls, Classes, Vcl.ExtCtrls, Vcl.Forms, SysUtils, Vcl.Graphics, Winapi.Messages, Winapi.Windows, Vcl.Mask, Vcl.Grids;

type
  TFr_Agenda = class(TForm)
    Mcd_Principal: TMonthCalendar;
    Pg_Agenda: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    SB_Inserir: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    TabSheet3: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Lb_Hoje: TLabel;
    Lb_Compr_hoje: TLabel;
    Lb_Compr_Amanha: TLabel;
    Lb_amanha: TLabel;
    Label6: TLabel;
    StrGrd_hoje: TStringGrid;
    StrGrd_Amanha: TStringGrid;
    Panel4: TPanel;
    Label7: TLabel;
    Lb_SG: TLabel;
    StrGrd_SG: TStringGrid;
    Panel5: TPanel;
    Label9: TLabel;
    Lb_SX: TLabel;
    StrGrd_SX: TStringGrid;
    Panel6: TPanel;
    Label11: TLabel;
    Lb_QR: TLabel;
    StrGrd_QR: TStringGrid;
    Panel7: TPanel;
    Label13: TLabel;
    Lb_SB: TLabel;
    StrGrd_SB: TStringGrid;
    Panel8: TPanel;
    Label15: TLabel;
    Lb_TC: TLabel;
    StrGrd_TC: TStringGrid;
    Panel9: TPanel;
    Label17: TLabel;
    Lb_QT: TLabel;
    StrGrd_QT: TStringGrid;
    Panel10: TPanel;
    Label19: TLabel;
    Lb_DM: TLabel;
    StrGrd_DM: TStringGrid;
    GroupBox1: TGroupBox;
    SB_Buscar: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    Label22: TLabel;
    StrGrd_Pesquisa: TStringGrid;
    E_Compromisso: TMaskEdit;
    Label5: TLabel;
    E_Usuario: TMaskEdit;
    Label8: TLabel;
    Qr_Agenda: TSTQuery;
    Qr_Pesquisa: TSTQuery;
    Label2: TLabel;
    E_Data_Fim: TDateTimePicker;
    E_Data_Ini: TDateTimePicker;
    Label3: TLabel;
    Pnl_Calendar: TPanel;
    pnl_calendar_Bottom: TPanel;
    pnl_Pesquisa_Bottom: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure Mcd_PrincipalClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SB_InserirClick(Sender: TObject);
    procedure StrGrd_SGDblClick(Sender: TObject);
    procedure StrGrd_TCDblClick(Sender: TObject);
    procedure StrGrd_QRClick(Sender: TObject);
    procedure StrGrd_QTClick(Sender: TObject);
    procedure StrGrd_SXClick(Sender: TObject);
    procedure StrGrd_SBClick(Sender: TObject);
    procedure StrGrd_DMClick(Sender: TObject);
    procedure StrGrd_hojeDblClick(Sender: TObject);
    procedure StrGrd_AmanhaDblClick(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure StrGrd_PesquisaDblClick(Sender: TObject);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    FDataSelecionada : Tdate;
    procedure Pc_GradeDiaria(Pc_Grade : TStringGrid);
    procedure Pc_GradeSemanal(Pc_Grade : TStringGrid);
    procedure Pc_DataExtenso;
    procedure Pc_Busca(FDataSelecionada : TDate);
    procedure Pc_PreencheGrade(Pc_Grade : TStringGrid);
    procedure Pc_MostraAgenda;
    procedure Pc_EditaAgenda(Fc_codigo: String);
    procedure Pc_Pesquisar;
    procedure Pc_ImagemBotao;
  public
    { Public declarations }


  end;

var
  Fr_Agenda: TFr_Agenda;

implementation

uses     DateUtils, reg_commitment, Un_DM, UN_MSG, UN_Principal, env, Un_Regra_Negocio;
{$R *.dfm}

procedure TFr_Agenda.Pc_EditaAgenda(Fc_codigo: String);
Var
  Lc_form : TRegCommitment;
Begin
  if StrToIntDef(Fc_codigo,0) > 0 then
  Begin
    Lc_form := TRegCommitment.create(Self);
    Try
      Lc_form.CodigoRegistro := Strtointdef(Fc_codigo,0);
      Lc_form.ShowModal;
    Finally
      FreeAndNil(Lc_form);
      Pc_MostraAgenda;
    End;
  End;
end;

procedure TFr_Agenda.Pc_Busca(FDataSelecionada : TDate);
Begin
  Screen.Cursor:=crHourGlass;
  Qr_Agenda.Active := False;
  Qr_Agenda.ParamByName('AGD_DIA').AsString := DateToStr(FDataSelecionada);
  Qr_Agenda.Active := True;
  Qr_Agenda.FetchAll;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Agenda.Pc_Pesquisar;
Var
  Lc_SqlTxt: String;
  Lc_Compromisso, lc_Usuario : Boolean;
  Lc_registro : Integer;
  Lc_Linha : TMemo;
Begin
  Screen.Cursor:=crHourGlass;
  Lc_Linha := TMemo.Create(Self);
  Lc_Linha.Parent := Self;
  Qr_Pesquisa.Active := False;
  Qr_Pesquisa.SQL.Clear;
  Lc_SqlTxt := 'SELECT * FROM TB_AGENDA tb_agenda '+
               '   INNER JOIN TB_USUARIO tb_usuario '+
               '   ON (tb_usuario.USU_CODIGO = tb_agenda.AGD_PARACODUSU) '+ 
               'WHERE (AGD_CODIGO IS NOT NULL) ';

  if E_Compromisso.Text ='' then Lc_Compromisso := False else Lc_Compromisso := True;
  if E_Usuario.Text ='' then lc_Usuario := False else lc_Usuario := True;

  Lc_SqlTxt := Lc_SqlTxt +'AND ((AGD_DIA >= :DATAINI) AND (AGD_DIA <= :DATAFIM))  ';
  if Lc_Compromisso then Lc_SqlTxt := Lc_SqlTxt +'AND (AGD_COMPROMISSO LIKE :AGD_COMPROMISSO) ';
  if lc_Usuario then Lc_SqlTxt := Lc_SqlTxt +'AND (USU_NOME LIKE :USU_NOME) ';

  Qr_Pesquisa.SQL.Add(Lc_SqlTxt + ' ORDER BY AGD_DIA, AGD_HORA ');

  Qr_Pesquisa.ParamByName('DATAINI').AsString := DateToStr(E_Data_Ini.Date);
  Qr_Pesquisa.ParamByName('DATAFIM').AsString := DateToStr(E_Data_Fim.Date);
  if Lc_Compromisso then Qr_Pesquisa.ParamByName('AGD_COMPROMISSO').AsString := '%' + E_Compromisso.Text + '%';
  if lc_Usuario then Qr_Pesquisa.ParamByName('USU_NOME').AsString := '%' + E_Usuario.Text + '%';

  Qr_Pesquisa.Active := True;
  Lc_registro := 0;
  Qr_Pesquisa.First;
  Pc_LimpaStringGrid(StrGrd_Pesquisa);
  while not Qr_Pesquisa.Eof do
    Begin
    Lc_registro := Lc_registro + 1;
    StrGrd_Pesquisa.RowCount := Lc_registro + 1;
    StrGrd_Pesquisa.ColWidths[0]:=17;
    StrGrd_Pesquisa.Cells[1,Lc_registro]:= Qr_Pesquisa.FieldByName('AGD_CODIGO').AsString;
    StrGrd_Pesquisa.Cells[2,Lc_registro]:= Qr_Pesquisa.FieldByName('AGD_DATA').AsString;
    StrGrd_Pesquisa.Cells[3,Lc_registro]:= Qr_Pesquisa.FieldByName('AGD_DIA').AsString;
    StrGrd_Pesquisa.Cells[4,Lc_registro]:= Qr_Pesquisa.FieldByName('AGD_HORA').AsString;
    Lc_Linha.Lines.Clear;
    Lc_Linha.Text := Qr_Pesquisa.FieldByName('AGD_COMPROMISSO').AsString;
    StrGrd_Pesquisa.Cells[5,Lc_registro]:= Lc_Linha.Lines[0];
    StrGrd_Pesquisa.Cells[6,Lc_registro]:= Qr_Pesquisa.FieldByName('AGD_AVISAR').AsString;
    StrGrd_Pesquisa.Cells[7,Lc_registro]:= Qr_Pesquisa.FieldByName('AGD_DECODUSU').AsString;
    StrGrd_Pesquisa.Cells[8,Lc_registro]:= Qr_Pesquisa.FieldByName('AGD_PARACODUSU').AsString;
    Qr_Pesquisa.Next;
    end;
  Lc_Linha.Destroy;
  Lc_Linha := Nil;
  Screen.Cursor:=crDefault;
end;


procedure TFr_Agenda.Pc_PreencheGrade(Pc_Grade : TStringGrid);
Var
  Lc_registro : Integer;
  Lc_Linha : TMemo;
Begin
  Screen.Cursor:=crHourGlass;
  Lc_Linha := TMemo.Create(Self);
  Lc_Linha.Parent := Self;
  Lc_registro := 0;
  Qr_Agenda.First;
  while not Qr_Agenda.Eof do
    Begin
    Lc_registro := Lc_registro + 1;
    Pc_Grade.RowCount := Lc_registro + 1;
    Pc_Grade.ColWidths[0]:=17;
    Pc_Grade.Cells[1,Lc_registro]:= Qr_Agenda.FieldByName('AGD_CODIGO').AsString;
    Pc_Grade.Cells[2,Lc_registro]:= Qr_Agenda.FieldByName('AGD_DATA').AsString;
    Pc_Grade.Cells[3,Lc_registro]:= Qr_Agenda.FieldByName('AGD_DIA').AsString;
    Pc_Grade.Cells[4,Lc_registro]:= Qr_Agenda.FieldByName('AGD_HORA').AsString;
    Lc_Linha.Lines.Clear;
    Lc_Linha.Text := Qr_Agenda.FieldByName('AGD_COMPROMISSO').AsString;
    Pc_Grade.Cells[5,Lc_registro]:= Lc_Linha.Lines[0];
    Pc_Grade.Cells[6,Lc_registro]:= Qr_Agenda.FieldByName('AGD_AVISAR').AsString;
    Pc_Grade.Cells[7,Lc_registro]:= Qr_Agenda.FieldByName('AGD_DECODUSU').AsString;
    Pc_Grade.Cells[8,Lc_registro]:= Qr_Agenda.FieldByName('AGD_PARACODUSU').AsString;
    Qr_Agenda.Next;
    end;
  Lc_Linha.Destroy;
  Lc_Linha := Nil;
  Screen.Cursor:=crDefault;  
end;


procedure TFr_Agenda.Pc_DataExtenso();
Var
  Lc_Dia : TDate;
  Lc_Data : TDate;
  Lc_Str_data : String;
Begin
  lc_Dia := DayOfWeek(FDataSelecionada);
  lc_data := FDataSelecionada-(lc_Dia-2);
  Lb_Hoje.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', FDataSelecionada );
  Lb_amanha.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', FDataSelecionada+1 );
  if FormatDateTime('dddd', FDataSelecionada ) = 'domingo' then
    Begin
    Lb_SG.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', Lc_Data -7);
    Lb_TC.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', Lc_Data - 6);
    Lb_QR.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', Lc_Data - 5);
    Lb_QT.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', Lc_Data - 4);
    Lb_SX.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', Lc_Data - 3);
    Lb_SB.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', Lc_Data - 2);
    Lb_DM.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', Lc_Data -1);
    end
  else
    Begin
    Lb_SG.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', Lc_Data );
    Lb_TC.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', Lc_Data + 1);
    Lb_QR.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', Lc_Data + 2);
    Lb_QT.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', Lc_Data + 3);
    Lb_SX.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', Lc_Data + 4);
    Lb_SB.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', Lc_Data + 5);
    Lb_DM.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', Lc_Data + 6);
    end;
end;

procedure TFr_Agenda.Pc_MostraAgenda;
Var
  Lc_Dia : TDate;
  Lc_Data : TDate;
  Lc_Str_data : String;
  Lc_I : Integer;
Begin
  Pc_LimpaStringGrid(StrGrd_hoje);
  Pc_LimpaStringGrid(StrGrd_Amanha);
  Pc_LimpaStringGrid(StrGrd_SG);
  Pc_LimpaStringGrid(StrGrd_TC);
  Pc_LimpaStringGrid(StrGrd_QR);
  Pc_LimpaStringGrid(StrGrd_QT);
  Pc_LimpaStringGrid(StrGrd_SX);
  Pc_LimpaStringGrid(StrGrd_SB);
  Pc_LimpaStringGrid(StrGrd_DM);

  lc_Dia := DayOfWeek(FDataSelecionada);
  lc_data := FDataSelecionada-(lc_Dia-2);
  Pc_Busca(FDataSelecionada);
  Lb_Compr_hoje.Caption := '('+IntToStr(Qr_Agenda.RecordCount) + ') Compromisso(s) ';
  Pc_PreencheGrade(StrGrd_hoje);
  Pc_Busca(FDataSelecionada + 1);
  Lb_Compr_Amanha.Caption := '('+IntToStr(Qr_Agenda.RecordCount) + ') Compromisso(s) ';
  Pc_PreencheGrade(StrGrd_Amanha);
  if FormatDateTime('dddd', FDataSelecionada ) = 'domingo' then
  Begin
    Pc_Busca(Lc_Data - 7);
    Pc_PreencheGrade(StrGrd_SG);

    Pc_Busca(Lc_Data - 6);
    Pc_PreencheGrade(StrGrd_TC);

    Pc_Busca(Lc_Data - 5);
    Pc_PreencheGrade(StrGrd_QR);

    Pc_Busca(Lc_Data - 4);
    Pc_PreencheGrade(StrGrd_QT);

    Pc_Busca(Lc_Data - 3);
    Pc_PreencheGrade(StrGrd_SX);

    Pc_Busca(Lc_Data - 2);
    Pc_PreencheGrade(StrGrd_SB);

    Pc_Busca(Lc_Data - 1);
    Pc_PreencheGrade(StrGrd_DM);
  end
  else
  Begin
    Pc_Busca(Lc_Data);
    Pc_PreencheGrade(StrGrd_SG);

    Pc_Busca(Lc_Data + 1);
    Pc_PreencheGrade(StrGrd_TC);

    Pc_Busca(Lc_Data + 2);
    Pc_PreencheGrade(StrGrd_QR);

    Pc_Busca(Lc_Data + 3);
    Pc_PreencheGrade(StrGrd_QT);

    Pc_Busca(Lc_Data + 4);
    Pc_PreencheGrade(StrGrd_SX);

    Pc_Busca(Lc_Data + 5);
    Pc_PreencheGrade(StrGrd_SB);

    Pc_Busca(Lc_Data + 6);
    Pc_PreencheGrade(StrGrd_DM);
  end;
end;

procedure TFr_Agenda.Pc_GradeDiaria(Pc_Grade : TStringGrid);
begin
  //Definir tamanho Da grade de compromissos diarios

  Pc_Grade.ColWidths[0]:=17;
  Pc_Grade.ColWidths[1]:=-1;
  Pc_Grade.ColWidths[2]:=-1;
  Pc_Grade.ColWidths[3]:=-1;
  Pc_Grade.ColWidths[4]:=60;
  Pc_Grade.ColWidths[5]:=440;
  Pc_Grade.ColWidths[6]:=60;
  Pc_Grade.ColWidths[7]:=-1;
  Pc_Grade.ColWidths[8]:=-1;
  Pc_Grade.Cols[4].Add('Horário');
  Pc_Grade.Cols[5].Add('Compromisso');
  Pc_Grade.Cols[6].Add('Avisar?');

end;

procedure TFr_Agenda.Pc_GradeSemanal(Pc_Grade : TStringGrid);
begin
  //Definir tamanho Da grade de compromissos diarios

  Pc_Grade.ColWidths[0]:=17;
  Pc_Grade.ColWidths[1]:=-1;
  Pc_Grade.ColWidths[2]:=-1;
  Pc_Grade.ColWidths[3]:=-1;
  Pc_Grade.ColWidths[4]:=40;
  Pc_Grade.ColWidths[5]:=190;
  Pc_Grade.ColWidths[6]:=40;
  Pc_Grade.ColWidths[7]:=-1;
  Pc_Grade.ColWidths[8]:=-1;
  Pc_Grade.Cols[4].Add('Horário');
  Pc_Grade.Cols[5].Add('Compromisso');
  Pc_Grade.Cols[6].Add('Avisar?');

end;

procedure TFr_Agenda.FormCreate(Sender: TObject);
begin
  Pc_ImagemBotao;
  FDataSelecionada := Date;
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
  Mcd_Principal.Date := FDataSelecionada;
  Pg_Agenda.ActivePageIndex := 0;
  Pc_GradeDiaria(StrGrd_hoje);
  Pc_GradeDiaria(StrGrd_Amanha);
  Pc_GradeDiaria(StrGrd_Pesquisa);
  Pc_GradeSemanal(StrGrd_SG);
  Pc_GradeSemanal(StrGrd_TC);
  Pc_GradeSemanal(StrGrd_QR);
  Pc_GradeSemanal(StrGrd_QT);
  Pc_GradeSemanal(StrGrd_SX);
  Pc_GradeSemanal(StrGrd_SB);
  Pc_GradeSemanal(StrGrd_DM);
end;

procedure TFr_Agenda.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Agenda.Mcd_PrincipalClick(Sender: TObject);
begin
  FDataSelecionada := Mcd_Principal.Date;
  Pc_DataExtenso;
  Pc_MostraAgenda;
end;

procedure TFr_Agenda.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    SB_Inserir.Glyph := (Fc_CarregaImagemBotao('CADASTRAR'));
    SB_Buscar.Glyph := (Fc_CarregaImagemBotao('BUSCAR'));
    SB_Visualizar.Glyph := (Fc_CarregaImagemBotao('VISUALIZAR'));
    Sb_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
  END;
end;

procedure TFr_Agenda.FormShow(Sender: TObject);
begin
  Pc_DataExtenso;
  Pc_MostraAgenda;
end;

procedure TFr_Agenda.SB_InserirClick(Sender: TObject);
Var
  Lc_Form : TRegCommitment;
begin
  Lc_Form := TRegCommitment.create(Self);
  try
    Lc_Form.CodigoRegistro := 0;
    Lc_Form.Showmodal;
  finally
    FreeAndNil(Lc_Form);
    Pc_MostraAgenda
  end;
end;

procedure TFr_Agenda.StrGrd_SGDblClick(Sender: TObject);
begin
  Pc_EditaAgenda(StrGrd_SG.Cells[1,StrGrd_SG.Row]);
end;

procedure TFr_Agenda.StrGrd_TCDblClick(Sender: TObject);
begin
Pc_EditaAgenda(StrGrd_TC.Cells[1,StrGrd_TC.Row]);
end;

procedure TFr_Agenda.StrGrd_QRClick(Sender: TObject);
begin
  Pc_EditaAgenda(StrGrd_QR.Cells[1,StrGrd_QR.Row]);
end;

procedure TFr_Agenda.StrGrd_QTClick(Sender: TObject);
begin
  Pc_EditaAgenda(StrGrd_QT.Cells[1,StrGrd_QT.Row]);
end;

procedure TFr_Agenda.StrGrd_SXClick(Sender: TObject);
begin
  Pc_EditaAgenda(StrGrd_SX.Cells[1,StrGrd_SX.Row]);
end;

procedure TFr_Agenda.StrGrd_SBClick(Sender: TObject);
begin
  Pc_EditaAgenda(StrGrd_SB.Cells[1,StrGrd_SB.Row]);
end;

procedure TFr_Agenda.StrGrd_DMClick(Sender: TObject);
begin
  Pc_EditaAgenda(StrGrd_DM.Cells[1,StrGrd_DM.Row]);
end;

procedure TFr_Agenda.StrGrd_hojeDblClick(Sender: TObject);
begin
  Pc_EditaAgenda(StrGrd_hoje.Cells[1,StrGrd_hoje.Row]);
end;

procedure TFr_Agenda.StrGrd_AmanhaDblClick(Sender: TObject);
begin
  Pc_EditaAgenda(StrGrd_Amanha.Cells[1,StrGrd_Amanha.Row]);
end;

procedure TFr_Agenda.SB_BuscarClick(Sender: TObject);
begin
  Pc_Pesquisar;
end;

procedure TFr_Agenda.StrGrd_PesquisaDblClick(Sender: TObject);
begin
  Pc_EditaAgenda(StrGrd_Pesquisa.Cells[1,StrGrd_Pesquisa.Row]);
end;

procedure TFr_Agenda.SB_VisualizarClick(Sender: TObject);
begin
  Pc_EditaAgenda(StrGrd_Pesquisa.Cells[1,StrGrd_Pesquisa.Row]);
end;

procedure TFr_Agenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Pg_Agenda.ActivePageIndex = 2 then
    Begin
    if shift = [] then
      begin
        case Key of
        VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
        VK_F8  : if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
        end;
      end;
    end;

  if shift = [] then
    begin
    case Key of
      VK_F2  : if SB_Inserir.Enabled then SB_InserirClick(Sender);
      VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
    end;
end;

procedure TFr_Agenda.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13)  then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;

end;

end.
