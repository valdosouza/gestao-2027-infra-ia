unit Un_fm_ListaTributacao;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.StdCtrls, Vcl.DBCtrls, Un_DM;

type
  Tfm_ListaTributacao = class(TFrame)
    Dblcb_Lista: TDBLookupComboBox;
    Label1: TLabel;
    Qr_Lista: TSTQuery;
    Ds_Lista: TDataSource;
    Qr_ListaTRB_CODIGO: TIntegerField;
    Qr_ListaTRB_CODPRO: TIntegerField;
    Qr_ListaPRO_DESCRICAO: TStringField;
    Qr_ListaCST_CSOSN: TStringField;
    Qr_ListaCFOP_COMPLETE: TStringField;
    Qr_ListaNAT_CFOP: TStringField;
    procedure Dblcb_ListaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FSituacaoTributaria : Integer;
  public
    { Public declarations }
    Estado : Integer;
    Sentido : String;
    Produto : Integer;
    procedure Listar;
  end;

implementation

{$R *.dfm}

{ Tfm_ListaTributacao }

procedure Tfm_ListaTributacao.Dblcb_ListaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
      begin
        Dblcb_Lista.KeyValue := Null;
      end;
    end;
end;

procedure Tfm_ListaTributacao.Listar;
begin
  if not DM.Qr_Estabelecimento.Active then DM.Qr_Estabelecimento.Active := True;
  FSituacaoTributaria := StrToIntDef(DM.Qr_Estabelecimento.FieldByname('EMP_CRT').AsString,3);
  with Qr_Lista do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    Active := False;
    sql.Clear;
    sql.Add(concat(
              'SELECT ',
              '  tb.trb_codigo, ',
              '  tb.trb_codpro, '));


    if (FSituacaoTributaria = 3) then
    Begin
      sql.Add('(select TBI_GRUPO || '' - '' || TBI_DESCRICAO DESCRICAO from TB_TRIB_ICMS_NR where TBI_CODIGO = TB.trb_codtbi_icms_nr ) CST_CSOSN,');
    end
    else
    Begin
      sql.Add('( SELECT TBI_GRUPO || '' - '' || TBI_DESCRICAO DESCRICAO from TB_TRIB_ICMS_SN WHERE TBI_CODIGO = TB.trb_codtbi_icms_sn) CST_CSOSN,');
    end;
      sql.Add(concat(
              '  CASE ',
              '    WHEN tb.trb_codpro > 0 THEN nt.nat_cfop || '' - '' || nt.nat_descricao || '' | '' || CAST(tb.trb_codpro AS VARCHAR(20)) || '' - '' || pd.pro_descricao ',
              '    ELSE nt.nat_cfop || '' - '' || nt.nat_descricao ',
              '  END AS CFOP_COMPLETE, ',

              'case ',
              'WHEN tb.trb_codpro > 0 THEN ',
              '    pd.pro_descricao ',
              '    ELSE ',
              '    '''' ',
              'END AS pro_descricao, ',

              '  nt.nat_cfop ',
              'FROM tb_tributacao tb ',
              '  inner join tb_natureza nt ',
              '  on (nt.nat_codigo = tb.trb_codnat) ',
              '  LEFT OUTER JOIN TB_PRODUTO pd ',
              '  ON (pd.PRO_CODIGO = tb.TRB_CODPRO) ',
              'where tb.trb_codigo is not null ',
              '  and tb.trb_estado=:trb_estado ',
              '  and tb.trb_sentido=:trb_sentido '
    ));
    if Produto > 0 then
    Begin
      sql.Add(' and ( (TRB_CODPRO = 0) or (TRB_CODPRO=:TRB_CODPRO)  )');
      ParamByName('TRB_CODPRO').AsInteger := Produto;
    End;

    sql.Add(' order by nt.nat_cfop ');

    ParamByName('trb_estado').AsInteger := Estado;
    ParamByName('trb_sentido').AsString := Sentido;
    Active := True;
    FetchAll;
  End;
end;


end.
