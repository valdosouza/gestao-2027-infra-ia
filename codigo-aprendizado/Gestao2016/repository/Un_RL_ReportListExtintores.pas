unit Un_RL_ReportListExtintores;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportList, Data.DB, UN_DM, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls, prmExtintores;

type
  TRL_ReportListExtintores = class(TRL_ReportList)
    QRMemo10: TQRMemo;
    QRMemo9: TQRMemo;
    QRMemo8: TQRMemo;
    QRMemo7: TQRMemo;
    QRMemo6: TQRMemo;
    QRMemo5: TQRMemo;
    QRMemo4: TQRMemo;
    QRMemo2: TQRMemo;
    QRMemo1: TQRMemo;
    QRMemo11: TQRMemo;
    QRMemo3: TQRMemo;
    QRBand1: TQRBand;
    E_Ext_Cliente: TQRMemo;
    E_Ext_Carga: TQRMemo;
    E_Ext_Tipo: TQRMemo;
    E_Ext_Serie: TQRMemo;
    E_Ext_Marca: TQRMemo;
    E_Mnt_Selo: TQRMemo;
    E_Mnt_Dt_Carga: TQRMemo;
    E_Mnt_Ensaio: TQRMemo;
    E_Ext_Numero: TQRMemo;
    E_Ext_Ano: TQRMemo;
    E_Ext_Localizacao: TQRMemo;
    Qr_Ordem: TSTQuery;
    Qr_Lotes: TSTQuery;
    Qr_LotesORS_DT_ENCERRAMENTO: TDateField;
    Qr_LotesCLT_NUMERO: TStringField;
    QRBand3: TQRBand;
    E_Qtde_Extintores: TQRLabel;
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure PassarParametros; Override;
    procedure PreencheDetalhe;Virtual;
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Parametros :TParamExtintor;
    FormatoDataEnsaio : String;
    FormatoDataCarga : String;
    procedure LastOrder;
    procedure ConsultaLote(Fc_Cd_Extintor:Integer);
  end;

var
  RL_ReportListExtintores: TRL_ReportListExtintores;

implementation

{$R *.dfm}

uses     RN_Extintores;
procedure TRL_ReportListExtintores.SelectSql;
begin
  if Parametros.TipoData = 0 then
  Begin
    SelectTxt := 'Select DISTINCT '+
              ' EXT_CODIGO, '+
              ' EXT_NUMERO, '+
              ' EMP_NOME, '+
              ' MRC_DESCRICAO, '+
              ' EXT_PROJETO, '+
              ' EXT_SERIE, '+
              ' EXT_ANO, '+
              ' ETP_DESCRICAO, '+
              ' ETP_CLASSE, '+
              ' ETP_CAPACIDADE, '+
              ' MED_ABREVIATURA, '+
              ' ELZ_DESCRICAO '+
              ' from tb_extintor ';
  End
  else
  Begin
    SelectTxt := 'Select '+
               'tb_extintor.EXT_CODIGO, '+
               'ORS_NUMERO, '+
               'MNT_CODORS, '+
               'EXT_NUMERO, '+
               'EMP_NOME, '+
               'MRC_DESCRICAO, '+
               'EXT_PROJETO, '+
               'EXT_SERIE, '+
               'EXT_ANO, '+
               'ETP_DESCRICAO, '+
               'ETP_CLASSE, '+
               'ETP_CAPACIDADE, '+
               'MED_ABREVIATURA, '+
               'tb_ext_vencimento.MNT_DT_ULT_ENSAIO, '+
               'tb_ext_vencimento.MNT_DT_CARGA, '+
               'ORS_DT_ENCERRAMENTO, '+
               'MNT_SELO, '+
               'ELZ_DESCRICAO '+
               'from TB_EXT_ORDEM_SERVICO tb_ext_os ';
  End;
end;

procedure TRL_ReportListExtintores.IniciaVariaveis;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  with Lc_Qry do
  Begin
    sql.add('select EMP_FORMDATA_E, EMP_FORMDATA_C '+
            'from tb_empresa ' +
            'where EMP_CODIGO=:EMP_CODIGO ');

    ParamByName('EMP_CODIGO').AsInteger := Parametros.Empresa;
    Active := True;
    //Define formato DAta
    FormatoDataEnsaio := FieldByName('EMP_FORMDATA_E').AsString;
    FormatoDataCarga := FieldByName('EMP_FORMDATA_C').AsString;
    Close;
  End;
  FreeAndNil(Lc_Qry);
  //Ordem de Serviço
  with Qr_Ordem do
  Begin
    Active := False;
    SQL.Clear;
    sql.Add('SELECT first 1 '+
            '  em.MNT_DT_ULT_ENSAIO, '+
            '  em.MNT_DT_CARGA, '+
            '  em.MNT_SELO '+
            '  FROM tb_ext_manutencao em '+
            '    INNER JOIN tb_ext_ordem_servico os '+
            '    on (os.ors_codigo = em.mnt_codors) '+
            '  where em.mnt_codext =:EXT_CODIGO '+
            '  and os.ors_dt_encerramento is not null ');

    if Parametros.Periodo then
    Begin
      case Parametros.TipoData of
        1:sql.Add(' AND (tb_ext_vencimento.MNT_DT_ULT_ENSAIO BETWEEN :DATAINI AND :DATAFIM) ');
        2:sql.Add(' AND (tb_ext_vencimento.MNT_DT_CARGA BETWEEN :DATAINI AND :DATAFIM) ');
        3:sql.Add(' AND (ORS_DT_ENCERRAMENTO BETWEEN :DATAINI AND :DATAFIM) ');
      end;
    end;
    sql.Add('order by os.ors_data desc');
  End;

end;

procedure TRL_ReportListExtintores.InnerJoinSql;
begin
  if ( Parametros.TipoData = 0 ) then
  Begin
    SelectTxt := SelectTxt +
    '     INNER JOIN TB_EMPRESA '+
    '     ON (EMP_CODIGO = EXT_CODEMP) '+
    '     INNER JOIN TB_EXT_TIPO tb_ext_tipo '+
    '     ON (tb_ext_tipo.ETP_CODIGO = tb_extintor.EXT_CODETP) '+
    '     INNER JOIN tb_marca_produto '+
    '     ON (MRC_CODIGO = EXT_CODMRC) '+
    '     INNER JOIN tb_medida '+
    '     ON (MED_CODIGO = ETP_CODMED) '+
    '     INNER JOIN tb_ext_localizacao '+
    '     ON (tb_ext_localizacao.ELZ_CODIGO = tb_extintor.EXT_CODELZ) ';
  End
  else
  Begin
    SelectTxt := SelectTxt +
    '    INNER JOIN tb_ext_manutencao '+
    '    ON (MNT_CODORS = ORS_CODIGO) '+
    '    INNER JOIN tb_ext_resultado '+
    '    ON (ERS_CODORS = ORS_CODIGO) '+
    '    INNER JOIN tb_extintor '+
    '    ON (tb_extintor.EXT_CODIGO = MNT_CODEXT) AND (tb_extintor.EXT_CODIGO = ERS_CODEXT) '+
    '    INNER JOIN tb_ext_vencimento '+
    '    ON (tb_ext_vencimento.ext_codigo = tb_extintor.ext_codigo) '+
    '    INNER JOIN TB_EMPRESA '+
    '    ON (EMP_CODIGO = EXT_CODEMP) '+
    '    INNER JOIN TB_EXT_TIPO tb_ext_tipo '+
    '    ON (tb_ext_tipo.ETP_CODIGO = tb_extintor.EXT_CODETP) '+
    '    INNER JOIN tb_marca_produto '+
    '    ON (MRC_CODIGO = EXT_CODMRC) '+
    '    INNER JOIN tb_medida '+
    '    ON (MED_CODIGO = ETP_CODMED) '+
    '    INNER JOIN tb_ext_localizacao '+
    '    ON (tb_ext_localizacao.ELZ_CODIGO = tb_extintor.EXT_CODELZ) ';
  End;
end;

procedure TRL_ReportListExtintores.WhereSql;
begin
  with Parametros do
  Begin
    WhereTxt := WhereTxt + ' where (tb_extintor.EXT_CODIGO IS NOT NULL)';

    if (Empresa > 0) then
      WhereTxt := WhereTxt + ' AND (EXT_CODEMP = :EMP_CODIGO) ';

    if (Endereco > 0) then
      WhereTxt := WhereTxt + ' AND (EXT_CODEND = :END_CODIGO) ';

    if (Marca > 0) then
      WhereTxt := WhereTxt + ' AND (EXT_CODMRC = :MRC_CODIGO) ';

    if trim(Tipo)<> '' then
    begin
      WhereTxt := WhereTxt + ' AND (ETP_DESCRICAO =:ETP_DESCRICAO) ';
      WhereTxt := WhereTxt + ' AND (ETP_CLASSE =:ETP_CLASSE) ';
    end;

    if trim(Capacidade)<> '' then
    begin
      WhereTxt := WhereTxt + ' AND (ETP_CAPACIDADE =:ETP_CAPACIDADE) ';
      WhereTxt := WhereTxt + ' AND (MED_ABREVIATURA =:MED_ABREVIATURA) ';
    end;

    if Periodo then
    Begin
      case TipoData of
        1:WhereTxt := WhereTxt + ' AND (tb_ext_vencimento.MNT_DT_ULT_ENSAIO BETWEEN :DATAINI AND :DATAFIM) ';
        2:WhereTxt := WhereTxt + ' AND (tb_ext_vencimento.MNT_DT_CARGA BETWEEN :DATAINI AND :DATAFIM) ';
        3:WhereTxt := WhereTxt + ' AND (ORS_DT_ENCERRAMENTO BETWEEN :DATAINI AND :DATAFIM) ';
      end;
    end;
  End;
end;

procedure TRL_ReportListExtintores.OrderBy;
begin
  if (Parametros.Tipodata = 0) then
    OrderByTxt := OrderByTxt + ' ORDER BY 3,2,6 '
  else
    OrderByTxt := OrderByTxt + ' ORDER BY 8,4 ';
end;

procedure TRL_ReportListExtintores.PassarParametros;
begin
  with Parametros, Qr_Consulta do
  Begin
    //Passagem de Parametros
    if (Empresa > 0) then
      ParamByName('EMP_CODIGO').AsInteger := Empresa;

    if (Endereco > 0) then
      ParamByName('END_CODIGO').AsInteger := Endereco;

    if (Marca > 0) then
      ParamByName('MRC_CODIGO').AsInteger := Marca;

    if trim(Tipo)<> '' then
    begin
      ParamByName('ETP_DESCRICAO').AsString := Tipo;
      ParamByName('ETP_CLASSE').AsString := Classe;
    end;

    if trim(Capacidade)<> '' then
    begin
      ParamByName('ETP_CAPACIDADE').AsString := Capacidade;
      ParamByName('MED_ABREVIATURA').AsString := Medida;
    end;

    if Periodo and ( TipoData > 0 ) then
    Begin
      ParamByName('DATAINI').AsDate := DataInicial;
      ParamByName('DATAFIM').AsDate := DataFinal;
    end;
  End;

end;

procedure TRL_ReportListExtintores.LastOrder;
BEGIN
  with Qr_Ordem, Parametros do
  Begin
    ParamByName('EXT_CODIGO').AsInteger := Qr_Consulta.fIELDbYnAME('EXT_CODIGO').AsInteger;
    if Periodo then
    Begin
      ParamByName('DATAINI').AsDateTime := DataInicial;
      ParamByName('DATAFIM').AsDateTime := DataFinal;
    end;
    Active := True;
    FetchAll;
    First;
  End;
END;

procedure TRL_ReportListExtintores.ConsultaLote(Fc_Cd_Extintor:Integer);
Begin
  with Qr_Lotes do
  Begin
    Active := False;
    ParamByName('EXT_CODIGO').AsInteger := Fc_Cd_Extintor;
    Active := True;
    FetchAll;
  end;
end;

procedure TRL_ReportListExtintores.PreencheDetalhe;
Var
  Lc_Dt_Fechamento : Tdate;
  Lc_Dt_Inicial : Tdate;
  Lc_Dt_Final : Tdate;
Begin
  with Qr_Consulta do
  Begin
    //Limpa campos
    E_Ext_Numero.Lines.Clear;
    E_Ext_Cliente.Lines.Clear;
    E_Ext_Marca.Lines.Clear;
    E_Ext_Serie.Lines.Clear;
    E_Ext_Ano.Lines.Clear;
    E_Ext_Tipo.Lines.Clear;
    E_Ext_Carga.Lines.Clear;
    E_Mnt_Ensaio.Lines.Clear;
    E_Mnt_Dt_Carga.Lines.Clear;
    E_Mnt_Selo.Lines.Clear;
    E_Ext_Localizacao.Lines.Clear;
    //Preenche campos
    E_Ext_Numero.Lines.Add(FieldByname('EXT_NUMERO').AsString);
    E_Ext_Cliente.Lines.Add(' ' + FieldByname('EMP_NOME').AsString);
    E_Ext_Marca.Lines.Add(' ' + FieldByname('MRC_DESCRICAO').AsString);
    E_Ext_Serie.Lines.Add(' ' + FieldByname('EXT_SERIE').AsString);
    E_Ext_Ano.Lines.Add(FieldByname('EXT_ANO').AsString);
    E_Ext_Tipo.Lines.Add(' ' + FieldByName('ETP_DESCRICAO').AsString + '/' + FieldByName('ETP_CLASSE').AsString);
    E_Ext_Carga.Lines.Add(' ' + FieldByName('ETP_CAPACIDADE').AsString + ' ' + FieldByName('MED_ABREVIATURA').AsString);

    if Parametros.TipoData = 0 then
    Begin
      LastOrder;
      E_Mnt_Ensaio.Lines.Add(Fc_FormataDataExintor(FormatoDataEnsaio,Qr_Ordem.FieldByname('MNT_DT_ULT_ENSAIO').AsString));
      E_Mnt_Dt_Carga.Lines.Add(Fc_FormataDataExintor(FormatoDataCarga, Qr_Ordem.FieldByname('MNT_DT_CARGA').AsString));
      E_Mnt_Selo.Lines.Add(Qr_Ordem.FieldByname('MNT_SELO').AsString);
    End
    else
    Begin
      E_Mnt_Ensaio.Lines.Add(Fc_FormataDataExintor(FormatoDataEnsaio,FieldByname('MNT_DT_ULT_ENSAIO').AsString));
      E_Mnt_Dt_Carga.Lines.Add(Fc_FormataDataExintor(FormatoDataCarga, FieldByname('MNT_DT_CARGA').AsString));
      E_Mnt_Selo.Lines.Add(FieldByname('MNT_SELO').AsString);
    End;

    ConsultaLote(FieldByName('EXT_CODIGO').AsInteger);
    if Qr_Lotes.RecordCount > 0 then
    Begin
      Lc_Dt_Fechamento := Qr_Lotes.FieldByName('ORS_DT_ENCERRAMENTO').AsDateTime;
      if ( Lc_Dt_Fechamento >= parametros.DataInicial ) and  ( Lc_Dt_Fechamento <= parametros.DataFinal ) then
      Begin
        E_Ext_Localizacao.Lines.Add(' ' + 'Ra-Novo. - ' + Qr_Lotes.FieldByname('CLT_NUMERO').AsString);
      end
      else
      Begin
        E_Ext_Localizacao.Lines.Add(' ' + 'Ra-Reut. - ' + Qr_Lotes.FieldByname('CLT_NUMERO').AsString);
      end;
    end
    else
    Begin
      E_Ext_Localizacao.Lines.Add(' ' + 'Reut-Sem-Rastr.');
    end;
  end;

end;



procedure TRL_ReportListExtintores.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Not Qr_Consulta.Eof then
  Begin
    PreencheDetalhe;
    Qrpt.Prepare;
  end;
end;

procedure TRL_ReportListExtintores.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_Qtde_Extintores.caption := 'Quantidade total de Extintores : '+ IntToStr(Qr_Consulta.RecordCount);
end;

end.
