unit Un_MostraRegraTributacao;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Grids, DBGrids, ExtCtrls, DB, STQuery, StdCtrls;

type
  TFr_MostraRegraTributacao = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Qr_Tributacao: TSTQuery;
    Ds_Tributacao: TDataSource;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    It_sql_Criterio : String;
  end;

var
  Fr_MostraRegraTributacao: TFr_MostraRegraTributacao;

implementation

{$R *.dfm}

procedure TFr_MostraRegraTributacao.FormShow(Sender: TObject);
begin
  with Qr_Tributacao do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('select  TRB_CODIGO, NAT_CFOP, NAT_DESCRICAO, UFE_SIGLA '+
            'from "TB_TRIBUTACAO" '+
            '  INNER JOIN TB_NATUREZA tb_natureza '+
            '  ON (tb_natureza.NAT_CODIGO = TRB_CODNAT) '+
            '  LEFT OUTER JOIN TB_UF '+
            '  on (UFE_CODIGO = TRB_ESTADO) '+
            'WHERE TRB_CODIGO IN ' + It_sql_Criterio);
    Active := True;
    end;
end;

procedure TFr_MostraRegraTributacao.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
