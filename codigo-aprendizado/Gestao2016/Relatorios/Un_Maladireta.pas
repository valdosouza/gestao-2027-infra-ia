unit Un_Maladireta;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, DB, STStoredProc, STQuery, Grids, DBGrids, Buttons, StdCtrls, DBCtrls, Mask, CheckLst, ComCtrls;

type
  TFr_Maladireta = class(TForm)
    Qr_Origem: TSTQuery;
    Ds_Origem: TDataSource;
    Panel1: TPanel;
    SB_Add_Tudo: TSpeedButton;
    SB_Retirar_Tudo: TSpeedButton;
    RG_Data: TRadioGroup;
    Qr_Etiqueta: TSTQuery;
    Ds_Etiqueta: TDataSource;
    Label2: TLabel;
    Cb_Empresa: TComboBox;
    ChLBx_Nomes: TCheckListBox;
    Label3: TLabel;
    Cb_Estado: TComboBox;
    Label4: TLabel;
    Cb_Cidade: TComboBox;
    Label5: TLabel;
    Cb_Grupo: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    Panel2: TPanel;
    Label1: TLabel;
    SB_Imprimir: TSpeedButton;
    SB_Etiqueta: TSpeedButton;
    SB_Busca: TSpeedButton;
    Sb_Sair: TSpeedButton;
    DBLCB_Etiqueta: TDBLookupComboBox;
    Qr_Acao: TSTQuery;
    Lb_Registros: TLabel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Label6: TLabel;
    Label7: TLabel;
    Chbx_Impresso: TCheckBox;
    procedure RG_DestinoClick(Sender: TObject);
    procedure E_BuscaEmpresaChange(Sender: TObject);
    procedure SB_EtiquetaClick(Sender: TObject);
    procedure SB_ImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RG_DataClick(Sender: TObject);
    procedure Sb_SairClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Cb_EstadoChange(Sender: TObject);
    procedure Cb_EmpresaChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SB_Add_TudoClick(Sender: TObject);
    procedure SB_Retirar_TudoClick(Sender: TObject);
    procedure ChLBx_NomesClickCheck(Sender: TObject);
    procedure Qr_EtiquetaAfterOpen(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_BuscaClick(Sender: TObject);
  private
    { Private declarations }
    It_Qt_Etiqueta : String;
  public
    { Public declarations }
  It_codigos: Array of array of integer;
  It_Visualizar       :Boolean;
  It_Imprimir:Boolean;
  procedure Pc_Estado;
  procedure Pc_Cidade;
  procedure Pc_BuscarRemetente;
  procedure Pc_BuscarDestinatario;
  procedure Pc_PermissaoBotao(Pc_Menu: string);
  end;

var
  Fr_Maladireta: TFr_Maladireta;

implementation

uses     Un_DM, UN_RL_Etiq_MalaDireta, UN_Sistema, UN_MSG, Un_Funcoes, Un_Regra_Negocio, env, UN_Principal, reg_config_tag;
{$R *.dfm}

procedure TFr_Maladireta.Pc_Estado;
Var
  Lc_Sqltxt : String;
Begin
  Qr_Acao.SQL.Clear;
  LC_Sqltxt :='SELECT DISTINCT  UFE_SIGLA                                            '+
              'FROM TB_EMPRESA tb_empresa                                            '+
              '  INNER JOIN TB_ENDERECO tb_endereco                                  '+
              '  ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)                 '+
              ' INNER JOIN tb_uf TB_uf on TB_UF.ufe_codigo = tb_endereco.end_codufe  '+
              ' WHERE  (EMP_CODIGO IS NOT NULL) AND (END_PRINCIPAL = ''S'')       ';

  if Cb_Empresa.ItemIndex < 5 then lc_sqltxt := lc_sqltxt + 'AND (EMP_TIPO =:EMP_TIPO) ';
  Qr_Acao.SQL.Add(Lc_Sqltxt + 'Order by UFE_SIGLA');
  if Cb_Empresa.ItemIndex < 5 then Qr_Acao.ParamByName('EMP_TIPO').AsInteger := Cb_Empresa.ItemIndex;
  Qr_Acao.Active := True;

  Cb_Estado.Clear;
  Cb_Estado.Items.Add('Todos');
  while not Qr_Acao.Eof do
    Begin
    Cb_Estado.Items.Add(Qr_Acao.fieldbyname('UFE_SIGLA').AsString);
    Qr_Acao.Next;
    end;
  Cb_Estado.ItemIndex := 0;
  Cb_Cidade.ItemIndex := 0;
end;

procedure TFr_Maladireta.Pc_Cidade;
Var
  Lc_Sqltxt : String;
Begin
  Qr_Acao.SQL.Clear;
  LC_Sqltxt :='SELECT DISTINCT cdd_descricao,ufe_sigla                               '+
              'FROM TB_EMPRESA tb_empresa                                            '+
              '  INNER JOIN TB_ENDERECO tb_endereco                                  '+
              '  ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)                 '+
              '  INNER JOIN TB_CIDADE TB_CIDADE                                      '+
              ' ON TB_CIDADE.CDD_CODIGO = TB_ENDERECO.END_CODCDD                     '+
              ' INNER JOIN tb_uf TB_uf  ON tb_uf.ufe_codigo = TB_ENDERECO.end_codufe '+
              'WHERE  (EMP_CODIGO IS NOT NULL) AND (END_PRINCIPAL = ''S'')        ';

  if Cb_Empresa.ItemIndex < 5 then lc_sqltxt := lc_sqltxt + 'AND (EMP_TIPO =:EMP_TIPO) ';
  if Cb_Estado.ItemIndex <> 0 then  lc_sqltxt := lc_sqltxt + 'AND (ufe_sigla =:ufe_sigla) ';
  Qr_Acao.SQL.Add(Lc_Sqltxt + 'Order by cdd_descricao');

  if Cb_Empresa.ItemIndex < 5 then Qr_Acao.ParamByName('EMP_TIPO').AsInteger := Cb_Empresa.ItemIndex;
  if Cb_Estado.ItemIndex <> 0 then  Qr_Acao.ParamByName('ufe_sigla').AsString := Cb_Estado.Text;
  Qr_Acao.Active := True;

  Cb_Cidade.Clear;
  Cb_Cidade.Items.Add('Todas');
  while not Qr_Acao.Eof do
    Begin
    Cb_Cidade.Items.Add(Qr_Acao.fieldbyname('cdd_descricao').AsString);
    Qr_Acao.Next;
    end;
  Cb_Cidade.ItemIndex := 0;
end;


procedure TFr_Maladireta.Pc_BuscarRemetente;
  var
  SqlTxt : string;
  Lc_I : Integer;
begin
  SqlTxt := '';
  Lc_I := 0;
  Screen.Cursor:=crHourGlass;
  if not(InputQuery('Impressão de Etiquetas do Remetente ', 'Informe o número de etiquetas',    It_Qt_Etiqueta)) then
    Begin
    Cb_Empresa.ItemIndex := 1;
    Screen.Cursor:=crDefault;
    exit;
    end;
    
  If (StrtoIntDef(It_Qt_Etiqueta,0) > 0) and (StrtoIntDef(It_Qt_Etiqueta,0) < 1500) then
  Begin
    Pc_AtivaEstabelecimento;
    Lb_Registros.Caption := 'Registro(s): '+IT_Qt_Etiqueta;
    SetLength(It_codigos,2,StrtoIntDef(It_Qt_Etiqueta,0));
    ChLBx_Nomes.Clear;
    ChLBx_Nomes.Items.Add(DM.Qr_Estabelecimento.FieldByname('EMP_NOME').AsString);
    ChLBx_Nomes.Checked[Lc_I] := True;
    It_codigos[0,Lc_I] := 1;
    It_codigos[1,Lc_I] := DM.Qr_Estabelecimento.FieldByname('EMP_CODIGO').AsInteger;
    ChLBx_Nomes.Enabled := False;
    end
  else
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'O sistema não imprime zero ou mais que 1500 etiquetas '+EOLN+
                   'por relatório. Faça um Filtro de dados mais acurado.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    end;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Maladireta.Pc_BuscarDestinatario;
  var
  SqlTxt : string;
  Lc_I : Integer;
begin
  SqlTxt := '';
  Screen.Cursor:=crHourGlass;
    Begin
    with Qr_Origem do
      Begin
      Close;
      Sql.Clear;
      Sqltxt :='SELECT MLD_CODEMP, MLD_TIPO, MLD_FANTASIA, MLD_NOME,  MLD_DT_FUNDA,  MLD_DT_CADASTRO, '+
               'MLD_CLASSE, MLD_CIDADE, MLD_ESTADO, MLD_PESSOA  '+
               'FROM VW_MALADIRETA '+
               'WHERE ((MLD_CEP IS NOT NULL) OR (MLD_CEP <> '''')) AND (MLD_CLASSE IS NOT NULL)';

      if Cb_Empresa.ItemIndex < 5 then sqltxt := sqltxt + ' AND (MLD_TIPO =:MLD_TIPO) ';
      if Cb_Estado.ItemIndex <> 0 then  sqltxt := sqltxt + 'AND (MLD_ESTADO =:MLD_ESTADO) ';
      if Cb_Cidade.ItemIndex <> 0 then sqltxt := sqltxt + 'AND (MLD_CIDADE =:MLD_CIDADE) ';

      case Cb_Grupo.ItemIndex of
        2:Begin
          sqltxt := sqltxt + 'AND (MLD_CLASSE <>''1 estrela'') ';
          end;
        3:Begin
          sqltxt := sqltxt + 'AND (MLD_CLASSE NOT IN (''1 estrela'',''2 estrelas'')) ';
          end;
        4:Begin
          sqltxt := sqltxt + 'AND (MLD_CLASSE NOT IN (''1 estrela'',''2 estrelas'',''3 estrelas''))';
          end;
        5:Begin
          sqltxt := sqltxt + 'AND (MLD_CLASSE =''5 estrelas'') ';
          end;
      end;

      IF RG_Data.ItemIndex = 0 theN
        Begin
        sqltxt := sqltxt + 'AND (MLD_DT_CADASTRO BETWEEN :DATAINI AND :DATAFIM) ';
        end
      else
        Begin
        sqltxt := sqltxt + 'AND (MLD_DT_FUNDA BETWEEN  :DATAINI AND :DATAFIM) AND (MLD_PESSOA = ''F'') ';
        end;

      SQL.Add (SqlTxt+ ' ORDER BY MLD_NOME ');

      if Cb_Empresa.ItemIndex < 5 then ParamByName('MLD_TIPO').AsInteger := Cb_Empresa.ItemIndex;
      if Cb_Estado.ItemIndex <> 0 then ParamByName('MLD_ESTADO').AsString := Cb_Estado.Text;
      if Cb_Cidade.ItemIndex <> 0 then ParamByName('MLD_CIDADE').AsString := Cb_Cidade.Text;
      IF RG_Data.ItemIndex = 0 theN
        Begin
        ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
        ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
        end
      else
        Begin
        ParamByName('DATAINI').AsString := Copy(DateToStr(E_Data_Ini.Date),1,6) + '1904';
        ParamByName('DATAFIM').AsString := Copy(DateToStr(E_Data_Fim.Date),1,6) + '1904';
        end;
      Open;
      First;
      FetchAll;

      Lb_Registros.Caption := 'Registro(s): '+IntToStr(RecordCount);
      if RecordCount <= 1500 then
        Begin
        SetLength(It_codigos,2,Qr_Origem.RecordCount);
        ChLBx_Nomes.Clear;
        For Lc_I := 0 to Qr_Origem.RecordCount - 1  do
          Begin
          ChLBx_Nomes.Items.Add(Qr_Origem.FieldByName('MLD_NOME').AsString);
          ChLBx_Nomes.Checked[Lc_I] := True;
          It_codigos[0,Lc_I] := 1;
          It_codigos[1,Lc_I] := Qr_Origem.FieldByName('MLD_CODEMP').AsInteger;
          Qr_Origem.Next;
          end;
        end
      else
        Begin
          MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                         'O sistema não imprime mais que 1500 etiquetas '+EOLN+
                         'por relatório. Faça um Filtro de dados mais acurado.'+EOLN,
                        ['OK'],[bEscape],mpErro);
        end;


      end;
    end;
  Screen.Cursor:=crDefault;

end;



procedure TFr_Maladireta.RG_DestinoClick(Sender: TObject);
begin
  SB_BuscaClick(Self);

end;

procedure TFr_Maladireta.E_BuscaEmpresaChange(Sender: TObject);
begin
  SB_BuscaClick(Self);
end;

procedure TFr_Maladireta.SB_EtiquetaClick(Sender: TObject);
Var
  Lc_form : TRegConfigTag;
begin
  Lc_form := TRegConfigTag.create(self);
  try
    Lc_form.ShowModal;
  finally
    FreeAndNil(Lc_form);
  end;
end;

procedure TFr_Maladireta.SB_ImprimirClick(Sender: TObject);
Var
  Lc_I, Lc_J : Integer;
  Lc_Imp : Boolean;
begin
  Lc_Imp := False;
  IF DBLCB_Etiqueta.Text <> '' then
    Begin
    Lc_J := 0;
    For LC_I:= 0 to ChLBx_Nomes.Items.Count - 1 do
      Begin
      if not Lc_Imp then
        if It_codigos[0,LC_I] = 1 then Lc_Imp := True;
      if It_codigos[0,LC_I] = 1 then Inc(Lc_J);
      end;


    if Lc_Imp then
      Begin
      try
        if not assigned(RL_Etiq_MalaDireta) then Application.CreateForm(TRL_Etiq_MalaDireta,RL_Etiq_MalaDireta);
        if Lc_I = Lc_J then RL_Etiq_MalaDireta.It_Excecao := false else RL_Etiq_MalaDireta.It_Excecao := true;
        if Cb_Empresa.ItemIndex = 0 then
          Begin
          RL_Etiq_MalaDireta.It_TipoEtiqueta := 'Remetente';
          RL_Etiq_MalaDireta.It_Qt_Etiqueta := It_Qt_Etiqueta;
          end;
        RL_Etiq_MalaDireta.It_Impresso := Chbx_Impresso.Checked;
        RL_Etiq_MalaDireta.Qrpt.Preview;
      finally
        RL_Etiq_MalaDireta.Close;
      end;
      end
    else
      Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Nenhum item foi selecionado.'+EOLN+
                     'Impossivel gerar etiquetas.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      end;
    end
  else
    Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Por favor Selecione uma etiqueta.'+EOLN+
                     'Impossivel gerar etiquetas.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    end;
end;

procedure TFr_Maladireta.FormCreate(Sender: TObject);
begin
  Qr_Etiqueta.Active := True;
  Cb_Empresa.ItemIndex := 1;
  DBLCB_Etiqueta.KeyValue := Qr_Etiqueta.FieldByName('CGE_CODIGO').AsInteger;
end;

procedure TFr_Maladireta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  Fr_Maladireta:=nil;
end;

procedure TFr_Maladireta.RG_DataClick(Sender: TObject);
Var
  lc_Ultdia : String;
  Lc_Data : String;
begin
  Lc_Data := DateToStr(Date);
  lc_Ultdia := IntToStr(UltDiaDoMes(date));
  E_Data_Ini.Date := StrToDate('01' + Copy(Lc_Data,3,8));
  E_Data_Fim.Date := StrToDate(lc_Ultdia + Copy(Lc_Data,3,8));
  E_Data_Ini.SetFocus;
end;

procedure TFr_Maladireta.Sb_SairClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Maladireta.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;

end;

procedure TFr_Maladireta.Cb_EstadoChange(Sender: TObject);
begin
  Pc_Cidade;
end;

procedure TFr_Maladireta.Cb_EmpresaChange(Sender: TObject);
begin
  Pc_Estado;
  if Cb_Empresa.ItemIndex = 0 then
    Pc_BuscarRemetente
  else
    Begin
    ChLBx_Nomes.Enabled := True;
    ChLBx_Nomes.Clear;
    Lb_Registros.Caption := 'Registro(s): 0';
    end;


end;

procedure TFr_Maladireta.FormShow(Sender: TObject);
begin
  Cb_Empresa.ItemIndex := 1;
  Cb_Estado.ItemIndex := 0;
  Cb_Cidade.ItemIndex := 0;
  Cb_Grupo.ItemIndex := 0;
  RG_Data.ItemIndex := 1;
  Cb_EmpresaChange(Self);
  Pc_PermissaoBotao('Etiquetas Mala Direta');  
end;

procedure TFr_Maladireta.SB_Add_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For LC_I := 0 to ChLBx_Nomes.Items.Count -1 do
    Begin
    ChLBx_Nomes.Checked[Lc_I] := True;
    It_codigos[0,Lc_I] := 1;
    end;
end;

procedure TFr_Maladireta.SB_Retirar_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For LC_I := 0 to ChLBx_Nomes.Items.Count - 1  do
    Begin
    ChLBx_Nomes.Checked[Lc_I] := False;
    It_codigos[0,Lc_I] := 0;
    end;

end;

procedure TFr_Maladireta.ChLBx_NomesClickCheck(Sender: TObject);
begin
  if ChLBx_Nomes.Checked[ChLBx_Nomes.itemindex] then
    It_codigos[0,ChLBx_Nomes.itemindex] := 1
  else
    It_codigos[0,ChLBx_Nomes.itemindex] := 0;
end;

procedure TFr_Maladireta.Qr_EtiquetaAfterOpen(DataSet: TDataSet);
begin
  Qr_Etiqueta.FetchAll;
end;

procedure TFr_Maladireta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F2  : if SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
      VK_F7  : if SB_Busca.Enabled then SB_BuscaClick(Sender);
      VK_Escape : if SB_Sair.Enabled then SB_SairClick(Sender);
    end;
  end;
end;

procedure TFr_Maladireta.SB_BuscaClick(Sender: TObject);
begin
  if Cb_Empresa.ItemIndex = 0 then
    Pc_BuscarRemetente
  else
    Pc_BuscarDestinatario;
end;

procedure TFr_Maladireta.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Imprimir := True;
    end
  else
    begin
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    if not It_Visualizar then exit;
    It_Imprimir := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    end;
   SB_Imprimir.Enabled:= It_Imprimir;
end;

end.
