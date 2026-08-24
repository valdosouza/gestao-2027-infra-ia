unit UN_Aniversariante;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls;


type
  TFr_Aniversariantes = class(TForm)
    Qr_Pesquisa: TSTQuery;
    Ds_Pesquisa: TDataSource;
    Panel1: TPanel;
    Label22: TLabel;
    SB_Buscar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    GroupBox1: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    E_BuscaAniver: TEdit;
    E_BuscaDataIni: TMaskEdit;
    E_BuscaDataFim: TMaskEdit;
    ChBx_Dia: TCheckBox;
    DBGrid1: TDBGrid;
    ChBx_Fisica: TCheckBox;
    ChBx_Juridica: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
  private
    { Private declarations }
    It_Pesquisa : String;

  public
    { Public declarations }
    procedure Pc_ImagemBotao;
    procedure Pc_DefineData;
    procedure Pc_Buscar;
  end;

var
  Fr_Aniversariantes: TFr_Aniversariantes;

implementation

uses      UN_Sistema, Un_Funcoes, UN_Principal, env, DateUtils;
{$R *.dfm}

procedure TFr_Aniversariantes.Pc_DefineData;
Var
  Lc_Dia : Integer;
begin
  if (Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_INI','0') = '/') OR (Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_FIM','0') = '/') then
  Begin
    IF Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_DIA','0') = 'S' then
    Begin
      E_BuscaDataIni.Text:=Copy(DateToStr(Date),1,5);
      E_BuscaDataFim.Text:=Copy(DateToStr(Date),1,5);
    End
    else IF Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_SEMANA','0') = 'S' then
    Begin
      E_BuscaDataIni.Text := Copy(DateToStr(StartOfTheWeek(Date)),1,5);
      E_BuscaDataFim.Text := Copy(DateToStr(EndOfTheWeek(Date)),1,5);
    End
    else IF Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_MES','0') = 'S' then
    Begin
      E_BuscaDataIni.Text := Copy(DateToStr(StartOfTheMonth(Date)),1,5);
      E_BuscaDataFim.Text := Copy(DateToStr(EndOfTheMonth(Date)),1,5);
    End;
  end
  else
  Begin
    E_BuscaDataIni.Text := Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_INI','0');
    E_BuscaDataFim.Text := Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_FIM','0');
  end;
end;



procedure TFr_Aniversariantes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Fc_Aq_Geral('G','ANIVER','HOJE',DateToStr(Date));
  if ChBx_Dia.Checked then
    Fc_Aq_Geral('G','ANIVER','TELAHOJE','N')
  else
    Fc_Aq_Geral('G','ANIVER','TELAHOJE','S'); 
end;

procedure TFr_Aniversariantes.Pc_Buscar;
var
  Sqltxt:string;
  Lc_Aniver, Lc_Data: boolean;
  Lc_Dt_Ini,Lc_Dt_Fim:TDate;
  Lc_Mes :Integer;
  LcCampoAniverEmp : String;
  LcCampoAniverCto : String;
begin
  sqltxt := '';
  Screen.Cursor:=crHourGlass;
  with Qr_Pesquisa do
  Begin
    Close;
    Sql.Clear;
    if (E_BuscaDataIni.Text = '  /  ') or  (E_BuscaDataFim.Text = '  /  ')  then Lc_Data := False else Lc_Data := True;
    if E_BuscaAniver.Text = '' then Lc_Aniver := False else Lc_Aniver := True;
    LcCampoAniverEmp := ' CAST (EXTRACT( MONTH FROM tb_empresa.EMP_DT_FUNDA)||''/''||  EXTRACT( DAY FROM tb_empresa.EMP_DT_FUNDA  )||''/1904'' AS DATE)';
    Sqltxt :=  concat(
                  'SELECT ',
                  '    EMP_FANTASIA FANTASIA, ',
                  '    EMP_NOME RAZAO, ',
                  LcCampoAniverEmp, ' EMP_ANIVER, ',
                  '    EMP_DT_CADASTRO CADASTRO ',
                  'FROM TB_EMPRESA ',
                  'WHERE (EMP_CODIGO IS NOT NULL) '
    );
    if (Lc_Data)              then Sqltxt := concat(sqltxt, ' AND (',LcCampoAniverEmp,' BETWEEN  :DATAINI AND :DATAFIM) ');
    if Lc_Aniver              then sqltxt := concat(sqltxt, ' AND ((EMP_NOME LIKE :NOME) OR (EMP_FANTASIA LIKE :NOME)) ');
    if (ChBx_Fisica.Checked and ChBx_Juridica.Checked) then
    Begin
      Sqltxt := concat(Sqltxt, ' AND ((EMP_PESSOA =''F'') or (EMP_PESSOA =''J'') ) ');
    end
    else
    Begin
      if ChBx_Fisica.Checked    then
        Sqltxt := concat(Sqltxt, ' AND (EMP_PESSOA =''F'') ')
      else
        Sqltxt := concat(Sqltxt, ' AND (EMP_PESSOA <>''F'') ');
      if ChBx_Juridica.Checked  then
        Sqltxt := concat(sqltxt, ' AND (EMP_PESSOA =''J'') ')
      else
        Sqltxt := concat(sqltxt, ' AND (EMP_PESSOA <>''J'') ');
    end;

    LcCampoAniverCto := ' CAST (EXTRACT( MONTH FROM CTO_ANIVER)||''/''||  EXTRACT( DAY FROM CTO_ANIVER  )||''/1904'' AS DATE)';
    Sqltxt :=  concat(Sqltxt,
                  'UNION ',
                  'SELECT ',
                  '    CTO_NOME FANTASIA, ',
                  '    CTO_NOME RAZAO, ',
                  LcCampoAniverCto,' ANIVER, ',
                  '    CTO_CADASTRO CADASTRO ',
                  'FROM TB_CONTATO ',
                  'WHERE (CTO_CODIGO IS NOT NULL) '
    );
    if (Lc_Data)  then Sqltxt := concat(sqltxt, ' AND (',LcCampoAniverCto,' BETWEEN  :DATAINI AND :DATAFIM) ');
    if Lc_Aniver  then sqltxt := concat(sqltxt, ' AND ( CTO_NOME LIKE :NOME)  ');


    SQL.Add(Sqltxt + ' ORDER BY 3,1 ');
    //TRatamento de Datas - 00/00/0000
    Lc_Dt_Ini := StrToDateDef(E_BuscaDataIni.Text + '/1904',Date);
    Lc_Dt_Fim := StrToDateDef(E_BuscaDataFim.Text + '/1904',Date);
    Lc_Mes := StrToIntDef(Copy(DateToStr(Lc_Dt_Ini),4,2),1);

    if (Lc_Dt_Ini > Lc_Dt_Fim) and (Lc_Mes = 12) then
    Begin
      Lc_Dt_Ini := StrToDateDef(E_BuscaDataIni.Text + '/1903',Date);
      Lc_Dt_Fim := StrToDateDef(E_BuscaDataFim.Text + '/1904',Date);
    end;

    if Lc_Data then
    Begin
      ParamByName('DATAINI').AsDate:= Lc_Dt_Ini;
      ParamByName('DATAFIM').AsDate:= Lc_Dt_Fim;
    End;
    if Lc_Aniver then ParamByName('NOME').AsString:='%'+E_BuscaAniver.Text+'%';
    active := True;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Aniversariantes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
    end;
end;

procedure TFr_Aniversariantes.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13)  then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;


procedure TFr_Aniversariantes.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Aniversariantes.DBGrid1TitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(DBGrid1, Column);
end;

procedure TFr_Aniversariantes.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    CarregaImagemBotao(SB_Buscar,'BUSCAR');
    CarregaImagemBotao(Sb_Sair_0,'SAIR');
  END;
end;

procedure TFr_Aniversariantes.FormShow(Sender: TObject);
begin
  Pc_Define_FormatoRegional;
  Pc_DefineData;
  Pc_ImagemBotao;
  Pc_Buscar;
end;

procedure TFr_Aniversariantes.SB_BuscarClick(Sender: TObject);
begin
  Pc_Buscar;
end;

end.
