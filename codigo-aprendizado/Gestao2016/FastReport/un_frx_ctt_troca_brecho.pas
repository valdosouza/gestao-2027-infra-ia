unit un_frx_ctt_troca_brecho;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxExportXLS, frxClass, frxExportPDF, Data.DB, STQuery, frxDBSet, frxRich, frxDCtrl;

type
  TFrxCttTrocaBrecho = class(TForm)
    frxBase: TfrxReport;
    frxDBaseReport: TfrxDBDataset;
    Qr_Consulta: TSTQuery;
    frxPDFExport1: TfrxPDFExport;
    frxXLSExport1: TfrxXLSExport;
    frxRichObject1: TfrxRichObject;
    frxDialog: TfrxDialogControls;
  private
    FCodigoCliente: Integer;

    { Private declarations }
    procedure DadosContrato;
    procedure setFCodigoCliente(const Value: Integer);
  public
    { Public declarations }
    property CodigoCliente:Integer read FCodigoCliente write setFCodigoCliente;
  end;

var
  FrxCttTrocaBrecho: TFrxCttTrocaBrecho;

implementation

{$R *.dfm}

uses     Un_Regra_Negocio, Un_DM, UN_Sistema;
procedure TFrxCttTrocaBrecho.DadosContrato;
Var
  Lc_Aux : String;
  Lc_Empresa : String;
  Lc_Cliente : String;
Begin
  Pc_AtivaEstabelecimento;

  WITH DM.Qr_Estabelecimento DO
  bEGIN

    Lc_Empresa := concat('Entre ',FieldByName('EMP_FANTASIA').AsString,
                      ', inscrita no cnpj ',fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString),
                      '. Inscrição estadual ',FieldByName('EMP_INSC_EST').AsString,
                      'com sede � rua ',FieldByName('END_ENDER').AsString,', ',FieldByName('END_NUMERO').AsString,
                      ' � Bairro ',FieldByName('END_BAIRRO').AsString,
                      ' � Cidade ',FieldByName('CDD_DESCRICAO').AsString,
                      '  - UF ',FieldByName('UFE_SIGLA').AsString);

    frxBase.variables['Empresa']         := QuotedStr( Lc_Empresa);
   END;

  With Qr_Consulta do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    if not Transaction.InTransaction then Transaction.StartTransaction;

    Active := false;
    ParamByName('EMP_CODIGO').AsInteger := FCodigoCliente;
    Active := True;
    FetchAll;
    Lc_Cliente := concat('E ',FieldByName('EMP_FANTASIA').AsString,
                      ', inscrita no cpf ',fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString),
                      '. RG ',FieldByName('EMP_INSC_EST').AsString,
                      ' domiciliado � rua ',FieldByName('END_ENDER').AsString,', ',FieldByName('END_NUMERO').AsString,
                      ' � Bairro ',FieldByName('END_BAIRRO').AsString,
                      ' � Cidade ',FieldByName('CDD_DESCRICAO').AsString,
                      '  - UF ',FieldByName('UFE_SIGLA').AsString);

    frxBase.variables['Cliente']         := QuotedStr( Lc_Cliente);
  End;

end;

procedure TFrxCttTrocaBrecho.setFCodigoCliente(const Value: Integer);
begin
  FCodigoCliente := Value;
  DadosContrato;
end;

end.
