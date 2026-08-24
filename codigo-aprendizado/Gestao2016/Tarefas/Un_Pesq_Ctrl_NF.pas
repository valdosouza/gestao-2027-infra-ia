unit Un_Pesq_Ctrl_NF;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_base_Pesq, Data.DB, STQuery, Vcl.Grids, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls;

type
  TFr_Pesq_Ctrl_NF = class(TFr_Base_Pesq)
    Qr_PesquisaCD_EMISSOR: TIntegerField;
    Qr_PesquisaEMP_NOME: TStringField;
    Qr_PesquisaNUMERO: TStringField;
    Qr_PesquisaMODELO: TStringField;
    Qr_PesquisaSERIE: TStringField;
    Qr_PesquisaDT_RECORD: TDateField;
    Qr_PesquisaTB_NOTA_FISCA_ID: TIntegerField;
    Qr_PesquisaCHAVE: TStringField;
    Qr_PesquisaCD_SITUACAO: TIntegerField;
    Qr_PesquisaOBSERVACAO: TStringField;
    Rg_Modelo: TRadioGroup;
    Qr_PesquisaTB_INSTITUTION_ID: TIntegerField;
    Rg_Situacao: TRadioGroup;
    ProcessarNFeprpria1: TMenuItem;
    ProcessarNFCe1: TMenuItem;
    ProcessarNFeTerceiro1: TMenuItem;
    ProcessarNotaBlocoA11: TMenuItem;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Qr_aux: TSTQuery;
    IntegerField1: TIntegerField;
    IBStringField1: TStringField;
    IBStringField2: TStringField;
    IBStringField3: TStringField;
    IBStringField4: TStringField;
    DateField1: TDateField;
    IntegerField2: TIntegerField;
    IBStringField5: TStringField;
    IntegerField3: TIntegerField;
    IBStringField6: TStringField;
    IntegerField4: TIntegerField;
    ApagarRegistrosparanovoProcessamento1: TMenuItem;
    Rg_MostrarChave: TRadioGroup;
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure PassagemParametros;Override;
    procedure ProcessarNFeprpria1Click(Sender: TObject);
    procedure ProcessarNFeTerceiro1Click(Sender: TObject);
    procedure ProcessarNFCe1Click(Sender: TObject);
    procedure ProcessarNotaBlocoA11Click(Sender: TObject);
    procedure ApagarRegistrosparanovoProcessamento1Click(Sender: TObject);
  private
    { Private declarations }
    procedure Pc_Seq_NFe_Proprio;
    procedure Pc_Seq_NFe_Terceiro;
    procedure Pc_Seq_NFCe;
    procedure Pc_Seq_NFBlocoA1;
    function getChave(Chave:String):String;
    function getChaveTerceiro(CodigoNota: Integer):String;
  public
    { Public declarations }
  end;

var
  Fr_Pesq_Ctrl_NF: TFr_Pesq_Ctrl_NF;

implementation

{$R *.dfm}

uses     UN_Sistema, ControllerCtrlNF, Un_Funcoes, RN_NotaFiscalEletronica3X, Un_Msg, ControllerBase, UN_Principal, env;
procedure TFr_Pesq_Ctrl_NF.IniciaVariaveis;
begin
  inherited;
  MultiSelect := False;
  E_Data_Ini.DateTime:= Now-31;
  E_Data_Fim.DateTime:= Now;

end;


procedure TFr_Pesq_Ctrl_NF.SelectSql;
begin
  SqlTxt := 'select '+
            'n.CD_EMISSOR, '+
            'e.EMP_NOME, '+
            'n.NUMERO, '+
            'n.MODELO , '+
            'n.SERIE, '+
            'n.DT_RECORD, '+
            'n.TB_NOTA_FISCAL_ID, '+
            'n.CHAVE, '+
            'n.CD_SITUACAO, '+
            'n.OBSERVACAO, '+
            'n.tb_institution_id '+
            'from TB_CTRL_NF n ';
end;

procedure TFr_Pesq_Ctrl_NF.InnerJoinSql;
begin
  SqlTxt := SqlTxt +
            '  left outer join tb_empresa e '+
            '  on (e.EMP_CODIGO = n.CD_EMISSOR)';
end;


procedure TFr_Pesq_Ctrl_NF.WhereSql;
begin
  SqlTxt := SqlTxt +
            '  Where (n.tb_institution_id =:tb_institution_id) ';

  case Rg_Modelo.ItemIndex of
    0: SqlTxt := SqlTxt + ' AND (n.modelo = ''55'') and  (n.CD_EMISSOR = :CD_EMISSOR) ';
    1: SqlTxt := SqlTxt + ' AND (n.modelo = ''55'') and  (n.CD_EMISSOR <>:CD_EMISSOR) ';
    2: SqlTxt := SqlTxt + ' AND (n.modelo = ''65'') and  (n.CD_EMISSOR = :CD_EMISSOR) ';
    3: SqlTxt := SqlTxt + ' AND (n.modelo = '''') and  (n.CD_EMISSOR <>:CD_EMISSOR) ';
  end;

  case Rg_Situacao.ItemIndex of
    0..4:SqlTxt := SqlTxt + ' AND ( n.CD_SITUACAO = :CD_SITUACAO ) ';
  end;

  SqlTxt := SqlTxt +
            ' and (n.dt_record between :DATAINI and :DATAFIM) ';

  case Rg_MostrarChave.ItemIndex of
    0:SqlTxt := SqlTxt + ' and ( (CHAVE is not null) and (CHAVE <> '''') )';
    2:SqlTxt := SqlTxt + ' and ( (CHAVE is null) or (CHAVE = '''') )';
  end;


end;

procedure TFr_Pesq_Ctrl_NF.OrderBy;
begin
  SqlTxt := SqlTxt + ' Order By 3 asc ';
end;


procedure TFr_Pesq_Ctrl_NF.PassagemParametros;
begin
  with Qr_Pesquisa do
  Begin
    ParamByName('CD_EMISSOR').AsInteger := Gb_CodMha;

    ParamByName('tb_institution_id').AsInteger := Gb_CodMha;

    case Rg_Situacao.ItemIndex of
      0:ParamByName('CD_SITUACAO').AsInteger := 0;
      1..4:ParamByName('CD_SITUACAO').AsInteger := Rg_Situacao.ItemIndex + 1;
    end;
    ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
    ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
  End;
end;

procedure TFr_Pesq_Ctrl_NF.Pc_Seq_NFBlocoA1;
begin
  MensagemPadrao(' Mensagem ', ATENCAO + EOLN + EOLN +
                 ' Em desenvolvimento..' + EOLN,
                 ['OK'], [bEscape], mpInformacao);
  Buscar;

end;

procedure TFr_Pesq_Ctrl_NF.Pc_Seq_NFCe;
Var
  Lc_Qry : TSTQuery;
  Lc_Nr_Max : Integer;
  I : Integer;
  Lc_Nr_Inicial : Integer;
  Lc_Nr_Fim : Integer;
  Lc_Nr_Atual : Integer;
  Lc_CtrlNota : TControllerCtrlNF;
  LcBase : TControllerBase;
begin
  try
    Lc_CtrlNota := TControllerCtrlNF.Create(nil);
    LcBase := TControllerBase.Create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry,Lc_CtrlNota do
    Begin
      //Pegar o numero Inicial de notas Emitiddas
      Active := False;
      sql.clear;
      sql.add(concat(
                'select min(c.nfc_codigo) numero ',
                'from tb_nota_fiscal n ',
                '  INNER JOIN tb_retorno_nfc c ',
                '  ON (c.nfc_codnfl = n.nfl_codigo) ',
                'where (n.nfl_codmha = :NFL_CODMHA) ',
                ' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) '
                ));
      ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
      ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
      ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
      Active := True;
      FetchAll;
      Lc_Nr_Inicial := StrToIntDef(FieldByname('numero').AsString,0);

      //Pegar o numero final de notas Emitiddas
      Active := False;
      sql.clear;
      sql.add(concat(
                'select max(c.nfc_codigo) numero ',
                'from tb_nota_fiscal n ',
                '  INNER JOIN tb_retorno_nfc c ',
                '  ON (c.nfc_codnfl = n.nfl_codigo) ',
                'where (n.nfl_codmha = :NFL_CODMHA) ',
                ' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) '
                ));
      ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
      ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
      ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
      Active := True;
      FetchAll;
      Lc_Nr_Fim := StrToIntDef(FieldByname('numero').AsString,0);

      //Gravar no controle as notas
      Active := False;
      sql.clear;
      sql.add('select '+
              ' n.NFL_CODMHA CD_EMISSOR, '+
              ' c.NFC_codigo NUMERO, '+
              ' n.nfl_modelo MODELO , '+
              ' n.nfl_serie SERIE, '+
              ' n.nfl_dt_emissao DT_RECORD, '+
              ' n.nfl_codigo TB_NOTA_FISCAL_ID, '+
              ' c.nfc_arquivo CHAVE, '+
              ' c.nfc_codsit CD_SITUACAO, '+
              ' c.nfc_motivo OBSERVACAO, '+
              ' n.nfl_codmha tb_institution_id '+
              'from tb_nota_fiscal n '+
              ' INNER JOIN tb_retorno_nfc c '+
              ' ON (c.nfc_codnfl = n.nfl_codigo) '+
              'where (n.nfl_codmha = :NFL_CODMHA) AND ( c.NFC_CODSIT > 1)  '+
              ' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) '+
              'order by 2 asc ');
      ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
      ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
      ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;

      Active := True;
      FetchAll;
      First;
      for I := Lc_Nr_Inicial to Lc_Nr_Fim do
      Begin
        with Registro do
        Begin
          CodigoEmissor := Gb_CodMha;
          NumeroNota := StrZero(I,6,0);
          ModeloNota := '65';
          SerieNota := '1';
          DataEmissao := E_Data_Fim.DateTime;
          CodigoNotaFiscal := 0;
          ChaveNota := '';
          CodigoSituacao := 0;
          Observacao := '';
          CodigoEstabelecimento := Gb_CodMha;
          //Verifica se a nota existe

          Lc_Nr_Atual := StrToIntDef(FieldByname('numero').AsString,0);
          if I = Lc_Nr_Atual then
          Begin
            DataEmissao := FieldByName('dt_record').AsDateTime;
            CodigoNotaFiscal := FieldByName('TB_NOTA_FISCAL_ID').AsInteger;
            ChaveNota := getChave(FieldByname('CHAVE').AsString);
            CodigoSituacao := FieldByName('CD_SITUACAO').AsInteger;
            Observacao := FieldByName('OBSERVACAO').AsString;
            Next;
          End;
        End;
        Insere;
      End;

    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
    FreeAndNil(Lc_CtrlNota);
    MensagemPadrao(' Mensagem ', ATENCAO + EOLN + EOLN +
                 ' Processamento Finalizado.' + EOLN,
                 ['OK'], [bEscape], mpInformacao);
    Buscar;
  end;

end;

procedure TFr_Pesq_Ctrl_NF.ApagarRegistrosparanovoProcessamento1Click(
  Sender: TObject);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  tRY
    LcBase := TControllerBase.Create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'delete from tb_ctrl_nf cf ',
                'where cf.dt_record BETWEEN :DATAINI AND :DATAFIM ',
                ' AND ( TB_INSTITUTION_ID=:TB_INSTITUTION_ID ) '
                ));
      ParamByName('TB_INSTITUTION_ID').AsInteger := Gb_CodMha;
      ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
      ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
      ExecSQL;
    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
    MensagemPadrao(' Mensagem ', ATENCAO + EOLN + EOLN +
                   ' Processamento Finalizado.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Buscar;
  end;
end;

function TFr_Pesq_Ctrl_NF.getChave(Chave:String):String;
Var
  Lc_Aux : String;
Begin
  Result := '';
  Lc_Aux := Copy(Chave,1,2);
  if StrToIntDef(Lc_Aux,0) > 0 then
  Begin
    Result := Copy(Chave,1,44);
  End
  else
  Begin

  End;

End;

function TFr_Pesq_Ctrl_NF.getChaveTerceiro(CodigoNota: Integer): String;
Var
  Lc_Path : String;
  Lc_FileXML : String;
begin
  //Define o caminho e o arquivo da Nota Fiscal
  Result := '';
  Lc_FileXML := 'compra'+ IntToStr(CodigoNota) + 'NFe.xml';
  Lc_Path := Fc_TrazRepositorio('NFE_REPOSITORIO');
  //Salva o Arquivo XML da NOta no diretorio
  Fc_VerificaExistenciaArquivoNFEXML(3,CodigoNota,Lc_Path,Lc_FileXMl);
  if Trim(Lc_FileXML)<>'' then
  Begin
    Pc_CarregaComponenteNFE(Lc_Path,Lc_FileXMl);
//  Result := fr_Principal.Nfe.NotasFiscais.Items[0]. NFe.infNFe.ID;

    Result := fr_Principal.Nfe.NotasFiscais.Items[0].NFe.procNFe.chNFe;
  end;
end;

procedure TFr_Pesq_Ctrl_NF.Pc_Seq_NFe_Proprio;
Var
  Lc_Qry : TSTQuery;
  Lc_Nr_Max : Integer;
  I : Integer;
  Lc_Nr_Inicial : Integer;
  Lc_Nr_Fim : Integer;
  Lc_Nr_Atual : Integer;
  Lc_CtrlNota : TControllerCtrlNF;
  LcBase : TControllerBase;
begin
  try
    Lc_CtrlNota := TControllerCtrlNF.Create(nil);
    LcBase := TControllerBase.Create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry,Lc_CtrlNota do
    Begin
      //Pegar o numero Inicial de notas Emitiddas
      Active := False;
      sql.clear;
      sql.add('select min(n.NFL_NUMERO) numero '+
              'from tb_nota_fiscal n '+
              ' INNER JOIN tb_retorno_nfe e '+
              ' ON (e.nfe_codnfl = n.nfl_codigo) '+
              'where (n.nfl_codmha = :NFL_CODMHA) '+
              ' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ');
      ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
      ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
      ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
      Active := True;
      FetchAll;
      Lc_Nr_Inicial := StrToIntDef(FieldByname('numero').AsString,0);

      //Pegar o numero final de notas Emitiddas
      Active := False;
      sql.clear;
      sql.add('select max(n.NFL_NUMERO) numero '+
              'from tb_nota_fiscal n '+
              ' INNER JOIN tb_retorno_nfe e '+
              ' ON (e.nfe_codnfl = n.nfl_codigo) '+
              'where (n.nfl_codmha = :NFL_CODMHA) '+
              ' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ');
      ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
      ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
      ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
      Active := True;
      FetchAll;
      Lc_Nr_Fim := StrToIntDef(FieldByname('numero').AsString,0);

      //Gravar no controle as notas
      Active := False;
      sql.clear;
      sql.add('select '+
              ' n.NFL_CODMHA CD_EMISSOR, '+
              ' n.NFL_NUMERO NUMERO, '+
              ' n.nfl_modelo MODELO , '+
              ' n.nfl_serie SERIE, '+
              ' n.nfl_dt_emissao DT_RECORD, '+
              ' n.nfl_codigo TB_NOTA_FISCAL_ID, '+
              ' e.nfe_arquivo CHAVE, '+
              ' e.nfe_codsit CD_SITUACAO, '+
              ' e.nfe_motivo OBSERVACAO, '+
              ' n.nfl_codmha tb_institution_id '+
              'from tb_nota_fiscal n '+
              ' INNER JOIN tb_retorno_nfe e '+
              ' ON (e.nfe_codnfl = n.nfl_codigo) '+
              'where (n.nfl_codmha = :NFL_CODMHA) AND N.nfl_numero IS NOT NULL  '+
              ' AND (NFL_NUMERO =:NFL_NUMERO) '+
              'order by 2 asc ');

  //    ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
  //    ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;

      Active := True;
      FetchAll;
      First;
      for I := Lc_Nr_Inicial to Lc_Nr_Fim do
      Begin
        Lc_Qry.Active := False;
        Lc_Qry.ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
        Lc_Qry.ParamByName('NFL_NUMERO').AsString := StrZero(I,6,0);
        Lc_Qry.Active := True;
        with Registro do
        Begin
          CodigoEmissor := Gb_CodMha;
          CodigoEstabelecimento := Gb_CodMha;
          NumeroNota := StrZero(I,6,0);
          ModeloNota := '55';
          SerieNota := '1';
          Lc_CtrlNota.getByKey;
          DataEmissao := E_Data_Fim.DateTime;
          CodigoNotaFiscal := 0;
          ChaveNota := '';
          CodigoSituacao := 0;
          //Verifica se a nota existe
          Observacao := '';
          Lc_Nr_Atual := StrToIntDef(FieldByname('numero').AsString,0);
          if I = Lc_Nr_Atual then
          Begin
            DataEmissao := FieldByName('dt_record').AsDateTime;
            CodigoNotaFiscal := FieldByName('TB_NOTA_FISCAL_ID').AsInteger;
            ChaveNota := getChave(FieldByname('CHAVE').AsString);
            CodigoSituacao := FieldByName('CD_SITUACAO').AsInteger;
            SerieNota := FieldByName('SERIE').AsString;
            if Trim(Observacao) <> '' then
              Observacao := FieldByName('OBSERVACAO').AsString;
            Next;
          End;
        End;
        salva;
        Application.ProcessMessages;
      End;

    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
    FreeAndNil(Lc_CtrlNota);
    MensagemPadrao(' Mensagem ', ATENCAO + EOLN + EOLN +
                   ' Processamento Finalizado.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Buscar;
  end;
end;

procedure TFr_Pesq_Ctrl_NF.Pc_Seq_NFe_Terceiro;
Var
  Lc_Qry : TSTQuery;
  Lc_Nr_Max : Integer;
  I : Integer;
  Lc_Nr_Atual : Integer;
  Lc_CtrlNota : TControllerCtrlNF;
  LcBase : TControllerBase;
begin
  Lc_CtrlNota := TControllerCtrlNF.Create(nil);
  LcBase := TControllerBase.Create(nil);
  Lc_Qry := LcBase.GeraQuery;
  with Lc_Qry,Lc_CtrlNota do
  Begin
    //Gravar no controle as notas
    Active := False;
    sql.clear;
    sql.add('select '+
            ' n.NFL_CODEmp CD_EMISSOR, '+
            ' n.NFL_NUMERO NUMERO, '+
            ' n.nfl_modelo MODELO , '+
            ' n.nfl_serie SERIE, '+
            ' n.nfl_dt_emissao DT_RECORD, '+
            ' n.nfl_codigo TB_NOTA_FISCAL_ID, '+
            ' n.nfl_codmha tb_institution_id '+
            'from tb_nota_fiscal n '+
            ' INNER JOIN tb_arquivos a '+
            ' ON (a.arq_codvcl = n.nfl_codigo) '+
            'where (a.arq_tipo = 3) and (n.nfl_codmha = :NFL_CODMHA) AND N.nfl_numero IS NOT NULL '+
            ' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) '+
            'order by 2 asc');
    ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
    ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;

    Active := True;
    FetchAll;
    First;
    while not eof do
    Begin
      with Registro do
      Begin
        CodigoEmissor := FieldByName('CD_EMISSOR').AsInteger;
        NumeroNota := FieldByName('NUMERO').AsString;
        ModeloNota := '55';
        SerieNota := '1';
        CodigoSituacao := 2;
        DataEmissao := FieldByName('dt_record').AsDateTime;
        CodigoNotaFiscal := FieldByName('TB_NOTA_FISCAL_ID').AsInteger;
        ChaveNota := getChaveTerceiro(FieldByname('TB_NOTA_FISCAL_ID').AsInteger);
        CodigoEstabelecimento := Gb_CodMha;
        Next;
      End;
      insere;
    End;

  End;
  LcBase.FinalizaQuery(Lc_Qry);
  FreeAndNil(LcBase);
  FreeAndNil(Lc_CtrlNota);
  MensagemPadrao(' Mensagem ', ATENCAO + EOLN + EOLN +
                 ' Processamento Finalizado.' + EOLN,
                 ['OK'], [bEscape], mpInformacao);
  Buscar;

end;

procedure TFr_Pesq_Ctrl_NF.ProcessarNFCe1Click(Sender: TObject);
begin
  Pc_Seq_NFCe;
end;

procedure TFr_Pesq_Ctrl_NF.ProcessarNFeprpria1Click(Sender: TObject);
begin
  TRY
    Self.Enabled := False;
    Pc_ProcesoAguarde(Self,'I');
    Pc_Seq_NFe_Proprio;
  Finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;

end;

procedure TFr_Pesq_Ctrl_NF.ProcessarNFeTerceiro1Click(Sender: TObject);
begin
  Pc_Seq_NFe_Terceiro;
end;

procedure TFr_Pesq_Ctrl_NF.ProcessarNotaBlocoA11Click(Sender: TObject);
begin
  Pc_Seq_NFBlocoA1;
end;



end.
