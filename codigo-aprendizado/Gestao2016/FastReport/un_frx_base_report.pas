unit un_frx_base_report;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, Un_DM, frxDBSet, frxExportCSV, frxExportPDF, Data.DB, STQuery, Vcl.ExtCtrls, frxExportXLS;

type
  TFrxBaseReport = class(TForm)
    frxBase: TfrxReport;
    frxDBaseReport: TfrxDBDataset;
    Qr_Consulta: TSTQuery;
    frxPDFExport1: TfrxPDFExport;
    frxXLSExport1: TfrxXLSExport;
    procedure InitVariable;
    procedure frxBaseBeforePrint(Sender: TfrxReportComponent);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    SelectTxt : String;
    InnerJoinTxt : String;
    WhereTxt : String;
    UnionSelectTxt : String;
    UnionInnerJoinTxt : String;
    UnionWhereTxt : String;
    OrderByTxt : String;
    GroupByTxt : String;
    HavingTxt : String;
    CodigoEstabelecimento : Integer;

    //Function  GeraQuery():TSTQuery;
    procedure DefineImpressora;Virtual;
    procedure IniciaVariaveis;Virtual;
    procedure Cabecalho; Virtual;
    procedure SelectSql;Virtual;
    procedure IncrementarSQl; Virtual;
    procedure InnerJoinSql;Virtual;
    procedure WhereSql;Virtual;
    procedure OrderBy;Virtual;
    procedure GroupBy;Virtual;
    procedure Having;Virtual;
    procedure PassarParametros; Virtual;
    procedure Rodape;Virtual;
    procedure PreencherDetalhe;Virtual;
  public
    { Public declarations }
    procedure Buscar; Virtual;
  end;

var
  FrxBaseReport: TFrxBaseReport;

implementation

uses     UN_Principal, env, UN_Sistema, Un_Regra_Negocio;
{$R *.dfm}

{ TFrBaseReport }

procedure TFrxBaseReport.Buscar;
begin
  with Qr_Consulta do
  Begin
    IF Transaction.InTransaction then Transaction.Commit  else Transaction.StartTransaction;
    Active := False;
    sql.Clear;
    SelectTxt := '';
    InnerJoinTxt := '';
    WhereTxt := '';
    UnionSelectTxt := '';
    UnionInnerJoinTxt := '';
    UnionWhereTxt := '';
    OrderByTxt := '';
    HavingTxt := '';
    SelectSql;
    InnerJoinSql;
    WhereSql;
    GroupBy;
    Having;
    OrderBy;
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
    SQL.Add(HavingTxt);
    SQL.Add(OrderByTxt);
    PassarParametros;
    Active := True;
    FetchAll;
    First;
  End;
end;

procedure TFrxBaseReport.Cabecalho;
Var
  Lc_Aux : String;
  Lc_Img : TImage;
begin
  Pc_AtivaEstabelecimento;
  WITH DM.Qr_Estabelecimento DO
  bEGIN
    Lc_Img := TImage.Create(Self);
    Fc_BuscaImagemEmpresa(Lc_Img.Picture,'LOGO');
    TfrxPictureView(frxBase.FindObject('Logo')).Picture.Graphic := Lc_Img.Picture.Graphic;
    frxBase.variables['NomeFantasia'] := QuotedStr( FieldByName('EMP_FANTASIA').AsString);
    frxBase.Variables['DocFiscal']    := QuotedStr( 'C.N.P.J: '+ fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString) + ' -  I.E.: '+ FieldByName('EMP_INSC_EST').AsString );
    IF (trim(FieldByName('END_COMPLEM').asString) = '') then
    Begin
      Lc_Aux := FieldByName('END_ENDER').AsString + ', '+
                FieldByName('END_NUMERO').asString + ' - ' +
                FieldByName('END_BAIRRO').AsString + ' - ' +
                Fc_MascaraCep(FieldByName('END_CEP').AsString) + ' - ' +
                FieldByName('CDD_DESCRICAO').AsString + ' - ' +
                FieldByName('UFE_SIGLA').AsString ;
    end
    else
    Begin
      Lc_Aux := FieldByName('END_ENDER').AsString + ', '+
                FieldByName('END_NUMERO').asString + ' - ' +
                FieldByName('END_COMPLEM').asString + ' - ' +
                FieldByName('END_BAIRRO').AsString + ' - ' +
                Fc_MascaraCep(FieldByName('END_CEP').AsString) + ' - ' +
                FieldByName('CDD_DESCRICAO').AsString + ' - ' +
                FieldByName('UFE_SIGLA').AsString ;
    end;
    frxBase.Variables['Endereco'] := QuotedStr( Lc_Aux );
    Lc_Aux :='';
    if (trim(FieldByName('END_FONE').AsString) <> '') then
      Lc_Aux := fc_MascaraFone(FieldByName('END_FONE').AsString);
    if (Trim(Lc_Aux) <> '') and (trim(FieldByName('END_CELULAR').AsString) <> '') then
      Lc_Aux := Lc_Aux + ' / ' + fc_MascaraFone(FieldByName('END_CELULAR').AsString)
    else
    if (trim(FieldByName('END_CELULAR').AsString) <> '') then
      Lc_Aux := fc_MascaraFone(FieldByName('END_CELULAR').AsString);

    frxBase.Variables['Fones']     := QuotedStr( 'Fones: ' +  Lc_Aux );
    frxBase.Variables['website']  := QuotedStr( 'Site: ' + FieldByName('EMP_SITE').AsString );
    frxBase.Variables['Email']    := QuotedStr( 'e-mail: ' + FieldByName('EMP_EMAIL').AsString );
  END;
  frxBase.Variables['Titulo'] := QuotedStr(Self.Caption );
end;

procedure TFrxBaseReport.DefineImpressora;
begin

end;

procedure TFrxBaseReport.FormCreate(Sender: TObject);
begin
  IniciaVariaveis;
end;

procedure TFrxBaseReport.frxBaseBeforePrint(Sender: TfrxReportComponent);
begin
  Cabecalho;

end;

//function TFrxBaseReport.GeraQuery: TSTQuery;
//begin
//  Result := TSTQuery.Create(Self);
//  With Result,DM do
//  Begin
//    Database := IBD_Gestao;
//    Transaction := IBT_Consulta;
//    ForcedRefresh := True;
//    Active := False;
//    sql.Clear;
//  End;
//end;

procedure TFrxBaseReport.GroupBy;
begin

end;

procedure TFrxBaseReport.Having;
begin

end;

procedure TFrxBaseReport.IncrementarSQl;
begin

end;

procedure TFrxBaseReport.IniciaVariaveis;
begin
  with frxBase do
  Begin
    EngineOptions.UseFileCache := True;
  end;
end;

procedure TFrxBaseReport.InitVariable;
begin
  frxBase.DataSetName := DM.IBD_Gestao.DatabaseName;
end;

procedure TFrxBaseReport.InnerJoinSql;
begin

end;

procedure TFrxBaseReport.OrderBy;
begin

end;

procedure TFrxBaseReport.PassarParametros;
begin

end;

procedure TFrxBaseReport.PreencherDetalhe;
begin

end;

procedure TFrxBaseReport.Rodape;
begin

end;

procedure TFrxBaseReport.SelectSql;
begin

end;

procedure TFrxBaseReport.WhereSql;
begin

end;

end.
