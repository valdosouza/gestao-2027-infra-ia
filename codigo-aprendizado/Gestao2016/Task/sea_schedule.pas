unit sea_schedule;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_base, Data.DB, Datasnap.Provider, Datasnap.DBClient, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls, Un_Fm_ListaColaboradores, Vcl.Mask, QEdit_Setes;

type
  TSeaSchedule = class(TFr_Base)
    Fm_ListaAtendente: TFm_ListaColaboradores;
    DSP: TDataSetProvider;
    cds_search: TClientDataSet;
    ds_search: TDataSource;
    Mcd_Principal: TMonthCalendar;
    DBG_Pesquisa: TDBGrid;
    pg_main: TPageControl;
    tbs_diaria: TTabSheet;
    TabSheet2: TTabSheet;
    Pnl_Fundos: TPanel;
    Panel1: TPanel;
    ChBx_Periodo: TCheckBox;
    E_Data_Fim: TDateTimePicker;
    E_Data_Ini: TDateTimePicker;
    Sb_Sair_0: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    SB_Buscar: TSpeedButton;
    SB_Cadastrar: TSpeedButton;
    cds_agenda: TClientDataSet;
    ds_agenda: TDataSource;
    dbg_agenda: TDBGrid;
    Label42: TLabel;
    Label1: TLabel;
    E_BuscaFone: TEdit_Setes;
    E_Busca_Cliente: TEdit;
    cds_agendaID: TIntegerField;
    cds_agendaTM_RECORD: TWideStringField;
    cds_agendaDURATION: TWideStringField;
    cds_agendaPHONE: TWideStringField;
    cds_agendaSERVED: TWideStringField;
    cds_agendaSIT_DESCRICAO: TWideStringField;
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure SB_CadastrarClick(Sender: TObject);
    procedure Mcd_PrincipalClick(Sender: TObject);
  private
    SelectTxt : String;
    InnerJoinTxt : String;
    WhereTxt : String;

    UnionSelectTxt : String;
    UnionInnerJoinTxt : String;
    UnionWhereTxt : String;

    OrderByTxt : String;
    GroupByTxt : String;
    ClockTime : Array[0..12] of String;

  protected
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
    procedure SelectSql;Virtual;
    procedure InnerJoinSql;Virtual;
    procedure WhereSql;Virtual;
    procedure OrderBySQl;Virtual;
    procedure SetParameters ;Virtual;
    procedure SetRegister;Virtual;
    procedure GetView;Virtual;
    function validateSearch:Boolean;
    procedure Search;Virtual;
    procedure SearchDaily;Virtual;
    procedure ImagemBotao;Override;
    function validateGetView:Boolean;Virtual;
    procedure returnRegister;Virtual;
    procedure execShorCutKeyF2;Override;
    procedure execShorCutKeyF7;Override;
    procedure execShorCutKeyF8;Override;
    procedure execShorCutEsc;Override;
  public
    { Public declarations }
  end;

var
  SeaSchedule: TSeaSchedule;

implementation

{$R *.dfm}

uses     Un_DM, UN_Principal, env, Un_Funcoes, cad_schedule, Un_Msg;

{ TSeaSchedule }

procedure TSeaSchedule.execShorCutEsc;
begin
  Close;
end;

procedure TSeaSchedule.execShorCutKeyF2;
begin
  if SB_Cadastrar.Enabled then SB_CadastrarClick(Self);
end;

procedure TSeaSchedule.execShorCutKeyF7;
begin
  if SB_Buscar.Enabled then SB_BuscarClick(Self);
end;

procedure TSeaSchedule.execShorCutKeyF8;
begin
  if SB_visualizar.Enabled then SB_visualizarClick(Self);
end;

procedure TSeaSchedule.FormataTela;
begin
  inherited;

end;

procedure TSeaSchedule.GetView;
Var
  Form : TCadSchedule;
begin
  Try
    Form := TCadSchedule.create(nil);
    case pg_main.ActivePageIndex of
      0: Form.CodigoRegistro := cds_agenda.FieldByName('id').AsInteger;
      1: Form.CodigoRegistro := cds_search.FieldByName('id').AsInteger;
    end;
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;


end;

procedure TSeaSchedule.ImagemBotao;
begin
  CarregaImagemBotao(SB_Cadastrar,'CADASTRAR');
  CarregaImagemBotao(SB_Buscar,'BUSCAR');
  CarregaImagemBotao(SB_Visualizar,'VISUALIZAR');
  CarregaImagemBotao(Sb_Sair_0,'SAIR');
end;

procedure TSeaSchedule.IniciaVariaveis;
begin
  inherited;
  Fm_ListaAtendente.ListaColaborador;
  E_Data_Ini.DateTime := Date;
  E_Data_Fim.DateTime := Date;
  Mcd_Principal.Date := Date;

  ClockTime[0] := '08:00';
  ClockTime[1] := '09:00';
  ClockTime[2] := '10:00';
  ClockTime[3] := '11:00';
  ClockTime[4] := '12:00';
  ClockTime[5] := '13:00';
  ClockTime[6] := '14:00';
  ClockTime[7] := '15:00';
  ClockTime[8] := '16:00';
  ClockTime[9] := '17:00';
  ClockTime[10] := '18:00';
  ClockTime[11] := '19:00';
  ClockTime[12] := '20:00';


end;

procedure TSeaSchedule.InnerJoinSql;
begin
  inherited;
  InnerJoinTxt := concat(
              '  inner join tb_colaborador att ',
              '  on (att.clb_codigo = sc.clerk_id) ',
              '  left outer join tb_situacao sit ',
              '  on (sit.sit_codigo = sc.tb_situation_id) '
            );

end;



procedure TSeaSchedule.Mcd_PrincipalClick(Sender: TObject);
begin
  inherited;
  SearchDaily;
end;

procedure TSeaSchedule.OrderBySQl;
begin
  inherited;
  OrderByTxt := '  order by sc.dt_record,sc.tm_record ';

end;

procedure TSeaSchedule.returnRegister;
begin

end;

procedure TSeaSchedule.SetParameters;
begin
  with DM.Qr_Crud do
  Begin
    ParamByName('TB_INSTITUTION_ID').AsInteger := Gb_CodMha;

    if ( Fm_ListaAtendente.Dblcb_Vendedor.Text <> '' ) then
    Begin
      ParamByName('clb_codigo').AsInteger := Fm_ListaAtendente.Dblcb_Vendedor.KeyValue;
    End;

    case pg_main.ActivePageIndex of
      0:Begin
          ParamByName('DT_RECORD').AsDateTime := Mcd_Principal.Date;
      End;
      1:Begin
        if ChBx_Periodo.Checked then
        Begin
          ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
          ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
        End;

        if Trim(E_BuscaFone.Text) <> '' then
        Begin
         ParamByName('phone').AsString := concat('%',Fc_RemoveCaracterInformado(E_BuscaFone.Text, ['(',')','-','-',' ']));
        End;

        if Trim(E_Busca_Cliente.Text) <> '' then
        Begin
          ParamByName('served').AsString :='%'+ E_Busca_Cliente.Text+'%';
        End;



      End;
    end;
  End;
end;

procedure TSeaSchedule.SB_BuscarClick(Sender: TObject);
begin
  if validateSearch then
  Begin
    case pg_main.ActivePageIndex of
      0:SearchDaily;
      1:Search;
    end;
  End;
end;

procedure TSeaSchedule.SB_CadastrarClick(Sender: TObject);
begin
  SetRegister;
end;

procedure TSeaSchedule.Sb_Sair_0Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TSeaSchedule.SB_VisualizarClick(Sender: TObject);
begin
  if validateGetView then
    GetView;
end;

procedure TSeaSchedule.Search;
begin
  cds_search.Active := False;
  with DM.Qr_Crud do
  Begin
    Active := False;
    sql.Clear;
    SelectTxt := '';
    InnerJoinTxt := '';
    WhereTxt := '';
    UnionSelectTxt := '';
    UnionInnerJoinTxt := '';
    UnionWhereTxt := '';
    OrderByTxt := '';
    SelectSql;
    InnerJoinSql;
    WhereSql;
    OrderBySql;
    SQL.Add(SelectTxt);
    SQL.Add(InnerJoinTxt);
    SQL.Add(WhereTxt);
    if Trim(UnionSelectTxt) <> '' then
    Begin
      SQL.Add(' Union ');
      SQL.Add(UnionSelectTxt);
    End;
    if Trim(UnionInnerJoinTxt) <> '' then
      SQL.Add(UnionInnerJoinTxt);
    if Trim(UnionWhereTxt) <> ''     then
      SQL.Add(UnionWhereTxt);
    SQL.Add(GroupByTxt);
    SQL.Add(OrderByTxt);
    SetParameters;
    Prepare;
    Active := True;
    FetchAll;
  End;
  cds_search.Active := True;

end;

procedure TSeaSchedule.SearchDaily;
Var
  I : Integer;
begin
  with DM.Qr_Crud do
  Begin
    Active := False;
    sql.Clear;
    SelectTxt := '';
    InnerJoinTxt := '';
    WhereTxt := '';
    UnionSelectTxt := '';
    UnionInnerJoinTxt := '';
    UnionWhereTxt := '';
    OrderByTxt := '';
    SelectSql;
    InnerJoinSql;
    WhereSql;
    OrderBySql;
    SQL.Add(SelectTxt);
    SQL.Add(InnerJoinTxt);
    SQL.Add(WhereTxt);
    if Trim(UnionSelectTxt) <> '' then
    Begin
      SQL.Add(' Union ');
      SQL.Add(UnionSelectTxt);
    End;
    if Trim(UnionInnerJoinTxt) <> '' then
      SQL.Add(UnionInnerJoinTxt);
    if Trim(UnionWhereTxt) <> ''     then
      SQL.Add(UnionWhereTxt);
    SQL.Add(GroupByTxt);
    SQL.Add(OrderByTxt);
    SetParameters;
    Prepare;
    Active := True;
    FetchAll;
  End;
  if not cds_agenda.Active then cds_agenda.CreateDataSet;
  cds_agenda.EmptyDataSet;
  for I:= Low(ClockTime ) to High( ClockTime ) do
  Begin
    cds_agenda.Append;
    cds_agendaTM_RECORD.AsString := ClockTime[I];
    DM.Qr_Crud.First;
    if DM.Qr_Crud.Locate('TM_RECORD',ClockTime[I],[]) then
    Begin
      cds_agendaid.AsInteger    := DM.Qr_Crud.FieldByName('id').AsInteger;
      cds_agendaserved.AsString := DM.Qr_Crud.FieldByName('served').AsString;
      cds_agendaphone.AsString  := DM.Qr_Crud.FieldByName('phone').AsString;
      cds_agendaSIT_DESCRICAO.AsString := DM.Qr_Crud.FieldByName('SIT_DESCRICAO').AsString;
    End
    else
    Begin
      cds_agendaid.AsInteger    := 0;
      cds_agendaserved.AsString := '';
      cds_agendaphone.AsString  := '';
    End;
    cds_agenda.Post;
  End;


end;

procedure TSeaSchedule.SetRegister;
Var
  Form : TCadSchedule;
begin
  Try
    Form := TCadSchedule.create(nil);
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

function TSeaSchedule.validateGetView: Boolean;
begin
  Result := True;
  case pg_main.ActivePageIndex of
    0:Begin
        if not cds_agenda.Active then
        Begin
          MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                         'Nenhuma busca foi efetuada.'+EOLN+
                         'Verifique e tente novamente'+EOLN,
                         ['OK'],[bEscape],mpAlerta);
          Result := False;
          exit;
        end;

        if cds_agenda.RecordCount = 0 then
        Begin
          MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                         'Não há registros para visualizar.'+EOLN+
                         'Verifique e tente novamente'+EOLN,
                         ['OK'],[bEscape],mpAlerta);
          Result := False;
          exit;
        end;

    End;
    1:Begin
        if not cds_search.Active then
        Begin
          MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                         'Nenhuma busca foi efetuada.'+EOLN+
                         'Verifique e tente novamente'+EOLN,
                         ['OK'],[bEscape],mpAlerta);
          Result := False;
          exit;
        end;

        if cds_search.RecordCount = 0 then
        Begin
          MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                         'Não há registros para visualizar.'+EOLN+
                         'Verifique e tente novamente'+EOLN,
                         ['OK'],[bEscape],mpAlerta);
          Result := False;
          exit;
        end;

    End;

  end;

end;

function TSeaSchedule.validateSearch: Boolean;
begin
  result := True;
  case pg_main.ActivePageIndex of
    0:Begin
        if Fm_ListaAtendente.Dblcb_Vendedor.Text = '' then
        Begin
          MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                         'Para Agenda Individual um atendente deve ser informado.'+EOLN+
                         'Preeche para continuar'+EOLN,
                         ['OK'],[bEscape],mpAlerta);
          Result := False;
          exit;
        End;
    End;
    1:Begin

    End;
  end;

end;

procedure TSeaSchedule.SelectSql;
begin
  SelectTxt := concat(
                'Select sc.ID, sc.DT_RECORD, sc.TM_RECORD, sc.DURATION, sc.PHONE,SERVED, ',
                'att.clb_nome, ',
                'sit.sit_descricao ',
                'from tb_schedule sc '
            );
end;



procedure TSeaSchedule.WhereSql;
begin
  inherited;
  WhereTxt := concat(
              'WHERE (sc.TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) '
  );

  if ( Fm_ListaAtendente.Dblcb_Vendedor.Text <> '' ) then
  Begin
    WhereTxt := concat(
                WhereTxt,
                ' and (att.clb_codigo =:clb_codigo) '
    );
  End;

  case pg_main.ActivePageIndex of
    0:Begin
        WhereTxt := concat(
                    WhereTxt,
                    ' AND ( sc.DT_RECORD =:DT_RECORD ) '
        );

    End;
    1:Begin
        if ChBx_Periodo.Checked then
        Begin
          WhereTxt := concat(
                      WhereTxt,
                      ' AND ( sc.DT_RECORD BETWEEN :DATAINI AND :DATAFIM ) '
          );
        End;

        if Trim(E_BuscaFone.Text) <> '' then
        Begin
          WhereTxt := concat(
                      WhereTxt,
                      ' AND (sc.phone like :phone)   '
          );
        End;

        if Trim(E_Busca_Cliente.Text) <> '' then
        Begin
          WhereTxt := concat(
                      WhereTxt,
                      ' AND ( sc.SERVED LIKE :SERVED)   '
          );
        End;

    End;
  end;



end;

end.
