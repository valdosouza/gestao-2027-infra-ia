unit Un_Excel;

interface

uses
      Forms, Controls, SysUtils, STQuery, STStoredProc, STDatabase, ExtCtrls, Gauges, StdCtrls, classes, db, Mask, Grids, QRExport, Excel2000, QEdit_Setes, jpeg, ComObj, Windows, Messages, Variants, Graphics, Dialogs, ComCtrls, Buttons, StrUtils, DBCtrls;

type
  TFr_Excel = class(TForm)
    E_NomeArquivo: TEdit;
    Label1: TLabel;
    Gg_Progresso: TGauge;
    Lb_Processo: TLabel;
    SB_Sair_0: TSpeedButton;
    Sb_Abrir: TSpeedButton;
    procedure SB_Sair_0Click(Sender: TObject);
    procedure Sb_AbrirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pc_Excel(Pc_Query : TSTQuery; Pc_Arquivo : String);
    procedure Pc_StringGridToExcel(Grid : TStringGrid; Pc_Arquivo : String);
    procedure Pc_ImagemBotao;
  end;

var
  Fr_Excel: TFr_Excel;

implementation

uses     UN_Sistema, UN_Principal, env, CnXlsWriter;
{$R *.dfm}




procedure TFr_Excel.Pc_Excel(Pc_Query : TSTQuery; Pc_Arquivo : String);
var
  Lc_StrCell: string;
  Lc_Linha : Integer;
  Lc_Coluna : Integer;
  // Criado Vaviaveis by Gustavo
  AdtoMru, CreateBck, ROREcommended : OleVariant;
  Lc_ID : Integer;
  Excel : TCnXlsWriter;
begin
  Try
    Fr_Excel.Show;
    self.Enabled := False;
    Pc_Query.FetchAll;
    Gg_Progresso.Progress := 0;
    Gg_Progresso.MaxValue := Pc_Query.RecordCount;
    Application.ProcessMessages;
    //cria a aplicação
    Excel := TCnXlsWriter.Create(Pc_Arquivo);
    Lc_Linha := 0;
    (* Aqui pega o nome dos CAMPOS do Dataset *)
    with Pc_Query do
    begin
      for Lc_Coluna := 0 to Fields.Count - 1 do
      begin
        if Fields[Lc_Coluna].DisplayLabel <> '' then
          Excel.XlsWriteCellLabel(Lc_coluna,Lc_Linha,Fields[Lc_Coluna].DisplayLabel)
        else
          Excel.XlsWriteCellLabel(Lc_coluna,Lc_Linha, Fields[Lc_Coluna].FieldName);
      end;
    end;
    Lc_Linha := 1;
    with Pc_Query do
    begin
      Pc_Query.active := True;
      First;
      while not Eof do
      begin
        Lb_Processo.Caption := 'Processandro..' + IntToStr(Gg_Progresso.Progress) + ' de ' + IntToStr(Gg_Progresso.MaxValue) ;
        Application.ProcessMessages;
        for Lc_Coluna := 0 to Fields.Count - 1 do
        begin
          if (not Fields.Fields[Lc_Coluna].IsNull) then
          Begin
            if (Fields.Fields[Lc_Coluna].DataType = ftDate) or
               (Fields.Fields[Lc_Coluna].DataType = ftDateTime) then
            Begin
              Excel.XlsWriteCellLabel(Lc_Coluna, Lc_Linha, AnsiString(DateTimeToStr(Fields.Fields[Lc_Coluna].AsDateTime)));
            End
            else
            Begin
              if  (Fields.Fields[Lc_Coluna].DataType = ftFloat) or
                  (Fields.Fields[Lc_Coluna].DataType = ftBCD) or
                  (Fields.Fields[Lc_Coluna].DataType = ftCurrency) or
                  (Fields.Fields[Lc_Coluna].DataType = ftFloat) or
                  (Fields.Fields[Lc_Coluna].DataType = ftFMTBcd) then
              begin
                Excel.XlsWriteCellNumber(Lc_Coluna, Lc_Linha, Fields.Fields[Lc_Coluna].Value);
              end
              else
              Begin
                if (Fields.Fields[Lc_Coluna].DataType = ftInteger) or
                  (Fields.Fields[Lc_Coluna].DataType = ftSmallint) then
                  Excel.XlsWriteCellRk(Lc_Coluna, Lc_Linha, Fields.Fields[Lc_Coluna].AsInteger)
                else
                Excel.XlsWriteCellLabel(Lc_Coluna, Lc_Linha, Fields.Fields[Lc_Coluna].AsString);
              End;
            End;
          End
          else
          BEgin
            Excel.XlsWriteCellBlank(Lc_Coluna, Lc_Linha);
          End;
          Application.ProcessMessages;
        end;
        Next;
        Inc(Lc_Linha);
        Gg_Progresso.Progress := Lc_Linha;
        Application.ProcessMessages;
      end;
    end;
    excel.XlsEndStream;
  finally
    self.Enabled := True;
    Lb_Processo.Caption := 'Exportação concluída com Sucesso!';
    Application.ProcessMessages;
    excel.Destroy;
  END;
end;



procedure TFr_Excel.Pc_StringGridToExcel(Grid : TStringGrid; Pc_Arquivo : String);
var
  Lc_StrCell: string;
  Lc_Linha : Integer;
  Lc_Coluna : Integer;
  // Criado Vaviaveis by Gustavo
  AdtoMru, CreateBck, ROREcommended : OleVariant;
  Lc_ID : Integer;
  Excel : TCnXlsWriter;
begin
  Try
    Fr_Excel.Show;
    self.Enabled := False;
    Gg_Progresso.MinValue := 0;
    Gg_Progresso.Progress := 0;
    Gg_Progresso.MaxValue := Grid.RowCount;
    Application.ProcessMessages;
    //cria a aplicação
    Excel := TCnXlsWriter.Create(Pc_Arquivo);
    Lc_Linha := 0;
    with grid do
    begin
      for Lc_Linha := 0 to RowCount - 1 do
      begin
        Lb_Processo.Caption := 'Processandro..' + IntToStr(Gg_Progresso.Progress) + ' de ' + IntToStr(Gg_Progresso.MaxValue) ;
        Application.ProcessMessages;
        for Lc_Coluna := 0 to ColCount do
        begin
          if (Lc_Coluna = 3 ) or (Lc_Coluna = 4 ) or (Lc_Coluna = 5 ) then
            Excel.XlsWriteCellNumber(Lc_Coluna, Lc_Linha, StrToFloatDef(Cells[Lc_Coluna, Lc_Linha],0))
          else
            Excel.XlsWriteCellLabel(Lc_Coluna, Lc_Linha, Cells[Lc_Coluna, Lc_Linha]);
        end;
        Application.ProcessMessages;
        Gg_Progresso.Progress := Lc_Linha;
        Application.ProcessMessages;
      end;
    end;
    excel.XlsEndStream;
  finally
    self.Enabled := True;
    Lb_Processo.Caption := 'Exportação concluída com Sucesso!';
    Gg_Progresso.Progress := Grid.RowCount;
    Application.ProcessMessages;
    excel.Destroy;
  END;
end;

procedure TFr_Excel.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Excel.Sb_AbrirClick(Sender: TObject);
begin
  Pc_Executar_Arquivo(E_NomeArquivo.text);
end;

procedure TFr_Excel.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F2: if Sb_Abrir.Enabled then Sb_AbrirClick(Sender);
      VK_Escape: if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
      end;
    end;
end;

procedure TFr_Excel.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
end;

procedure TFr_Excel.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    Sb_Abrir.Glyph.Assign(Fc_CarregaImagemBotao('ABRIR'));
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

end.
