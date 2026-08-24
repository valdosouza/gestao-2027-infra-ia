unit un_frx_order_service_eletc_equip;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_base_report, frxClass, frxExportPDF, Data.DB, STQuery, frxDBSet, Un_DM, frxExportXLS;

type
  TFrxOrderServiceEletcEquip = class(TFrxBaseReport)
    Qr_Itens: TSTQuery;
    frxDBaseReportItens: TfrxDBDataset;
  private
    procedure OpenItemsOrder;
  protected
    { Private declarations }
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure PassarParametros; Override;
  public
    { Public declarations }
    CodigoPedido : Integer;
    procedure Buscar; Override;
  end;

var
  FrxOrderServiceEletcEquip: TFrxOrderServiceEletcEquip;

implementation

{$R *.dfm}

{ TFrxOrderServiceEletcEquip }

procedure TFrxOrderServiceEletcEquip.Buscar;
begin
  inherited;
  OpenItemsOrder;
end;

procedure TFrxOrderServiceEletcEquip.IniciaVariaveis;
begin
  inherited;

end;

procedure TFrxOrderServiceEletcEquip.InnerJoinSql;
begin
  inherited;
  InnerJoinTxt := concat(
                    'inner join tb_pedido pe ',
                    'on (pe.ped_codigo = co.cst_codped) ',
                    'inner join tb_empresa em ',
                    'on (em.emp_codigo = pe.ped_codemp) ',
                    'inner join tb_endereco en ',
                    'on (en.end_codigo = pe.ped_codend) ',
                    'inner join tb_cidade ci ',
                    'on (ci.cdd_codigo = en.end_codcdd) ',
                    'inner join tb_uf uf ',
                    'on (uf.ufe_codigo = en.end_codufe) ',
                    'inner join tb_colaborador ate ',
                    'on (ate.clb_codigo = pe.ped_codvdo) ',
                    'inner join tb_situacao si ',
                    'on (si.sit_codigo = co.cst_codsit) ',
                    'inner join tb_formapagto fo ',
                    'on (fo.fpt_codigo = pe.ped_codfpg) '
  );
end;

procedure TFrxOrderServiceEletcEquip.OpenItemsOrder;
begin
  with Qr_Itens do
  Begin
    Active:=False;
    paramByName('PED_CODIGO').AsInteger := codigoPedido;
    Active:=True;
    Fetchall;
  End;
end;

procedure TFrxOrderServiceEletcEquip.OrderBy;
begin
  inherited;

end;

procedure TFrxOrderServiceEletcEquip.PassarParametros;
begin
  inherited;
  with Qr_Consulta do
  Begin
    ParamByName('PED_CODIGO').AsInteger := CodigoPedido;
  End;
end;

procedure TFrxOrderServiceEletcEquip.SelectSql;
begin
  inherited;
  SelectTxt := concat(
                  'select pe.ped_numero, pe.ped_data,pe.ped_hora, em.emp_fantasia, en.end_ender, en.end_numero, en.end_cep,end_bairro, ',
                  'en.end_fone, en.end_celular, em.emp_cnpj, en.end_complem, ci.cdd_descricao, uf.ufe_sigla, ',
                  'co.cst_aparelho,co.cst_marca,co.cst_modelo, co.serie, co.imei, co.cst_acessorio, ',
                  'co.cst_relatado, co.cst_constatado, co.executado, co.note,  co.dt_forecast, ',
                  'ate.clb_nome responsavel, si.sit_descricao, co.cst_dt_entrega, pe.ped_prazo, fo.fpt_descricao, ',
                  'pe.ped_vl_produto, pe.ped_vl_servico, pe.ped_vl_frete, pe.ped_vl_desconto, pe.ped_vl_pedido, ',
                  ' co.HR_CONSERTO, co.HR_ENTREGA,co.HR_FORECAST ',
                  'from tb_conserto co '
               );


end;

procedure TFrxOrderServiceEletcEquip.WhereSql;
begin
  inherited;
    WhereTxt := 'where pe.ped_codigo = :ped_codigo ';
end;

end.
