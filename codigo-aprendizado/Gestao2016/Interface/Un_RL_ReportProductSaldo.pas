unit Un_RL_ReportProductSaldo;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportProduct, Data.DB, AnsiStrings, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls, UN_Principal, env;

type
  TRL_ReportProductSaldo = class(TRL_ReportProduct)
    QRBand1: TQRBand;
    E_DescricaoProduto: TQRLabel;
    E_VL_total: TQRLabel;
    E_VL_Custo: TQRLabel;
    E_codigoProduto: TQRLabel;
    QRBand3: TQRBand;
    Ft_SubGrupo: TQRBand;
    QRGroup2: TQRGroup;
    E_Grupo: TQRLabel;
    QRGroup3: TQRGroup;
    E_Subgrupo: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    E_Quantidade: TQRLabel;
    QRLabel6: TQRLabel;
    E_Valor_SubTotal: TQRLabel;
    E_Qtde_SubTotal: TQRLabel;
    QRLabel1: TQRLabel;
    E_Qtde_Total: TQRLabel;
    E_Valor_Total: TQRLabel;
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure OrderBy;Override;
    procedure GroupBy;Override;
    procedure PreencherGrupo;Override;
    procedure PreencherSubgrupo;
    procedure PreencherDetalhe;Override;
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRGroup3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Ft_SubGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);

  private
    { Private declarations }
    QuantidadeSubTotal : Real;
    ValorSubTotal : Real;
    ValorTotal : Real;
    QuantidadeTotal : Real;
  public
    { Public declarations }
  end;

var
  RL_ReportProductSaldo: TRL_ReportProductSaldo;

implementation

{$R *.dfm}

uses     UN_Sistema, ControllerGeral, Un_DM;

{ TRL_ReportProductSaldo }

procedure TRL_ReportProductSaldo.IniciaVariaveis;
Var
  Geral : TControllerGeral;
begin
  inherited;
  QuantidadeSubTotal := 0;
  ValorSubTotal := 0;
  ValorTotal := 0;
  QuantidadeTotal := 0;

//  Geral := TControllerGeral.create(Self);
//  Geral.Registro.Campo := 'PRO_G_CUSTO_INVENTARIO';
//  Geral.Registro.CodigoEstabelecimento := Gb_CodMha;
//  Geral.getById;
//  if ( Geral.Registro.Conteudo = 'C' ) then
//    CampoCusto :=  'PRO_VL_CUSTO'
//  else
//    CampoCusto :=  'PRO_VL_CUSTOMED AS PRO_VL_CUSTO ';
//  FreeAndNil(Geral);
end;

procedure TRL_ReportProductSaldo.SelectSql;
begin
  SelectTxt := 'SELECT DISTINCT pro.PRO_CODIGO, pro.PRO_CODIGOFAB, pro.PRO_DESCRICAO,  '+
               ' SUM(est.EST_QTDE)EST_QTDE, pro.PRO_QTDE_MIN, pro.PRO_CODGRP,pro.PRO_CODSBG, ' +
               Parametros.CampoCusto + ',grp.GRP_DESCRICAO, sbg.SBG_DESCRICAO, mar.MRC_DESCRICAO,PRO_CODIGOBAR, '+
               ' AVAILABLE,ADD_DAYS_AVAILABLE,PRO_ATIVO  '+
              'FROM TB_PRODUTO pro ';
end;

procedure TRL_ReportProductSaldo.Ft_SubGrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_Qtde_SubTotal.Caption   := FloatToStrF(QuantidadeSubTotal,ffFixed,10,3);
  QuantidadeSubTotal := 0;
  E_Valor_SubTotal.Caption := FloatToStrF(ValorSubTotal,ffFixed,10,3);
  ValorSubTotal := 0;
end;

procedure TRL_ReportProductSaldo.GroupBy;
begin
  GroupByTxt := 'GROUP BY 1,2,3,5,6,7,8,9,10,11,12,13,14,15';
end;

procedure TRL_ReportProductSaldo.OrderBy;
Begin
  case AnsiIndexStr(UpperCase(Parametros.Ordenacao), ['PRO_DESCRICAO', 'PRO_CODIGOFAB','PRO_CODIGO']) of
    0:OrderByTxt := ' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_DESCRICAO ASC ';
    1:OrderByTxt := ' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGOFAB ASC ';
    2:OrderByTxt := ' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGO ASC ';
  end;
end;

procedure TRL_ReportProductSaldo.PreencherDetalhe;
begin
  with Qr_Consulta do
  Begin
    E_codigoProduto.Caption := FieldByName('PRO_CODIGOFAB').AsString;
    E_DescricaoProduto.Caption := FieldByName('PRO_DESCRICAO').AsString;
    E_VL_Custo.Caption := FloatToStrF(FieldByName('PRO_VL_CUSTO').AsCurrency,ffNumber,10,2);
    //Totaliza a quantidade
    QuantidadeSubTotal := QuantidadeSubTotal + FieldByName('EST_QTDE').AsFloat;
    QuantidadeTotal := QuantidadeTotal + FieldByName('EST_QTDE').AsFloat;
    E_Quantidade.Caption := FloatToStrF(FieldByName('EST_QTDE').AsFloat,ffNumber,10,2);
    //totaliza o Valor
    ValorSubTotal := ValorSubTotal + (FieldByName('PRO_VL_CUSTO').AsCurrency * FieldByName('EST_QTDE').AsFloat);
    ValorTotal := ValorTotal + (FieldByName('PRO_VL_CUSTO').AsCurrency * FieldByName('EST_QTDE').AsFloat);
    E_VL_total.Caption := FloatToStrF((FieldByName('PRO_VL_CUSTO').AsCurrency * FieldByName('EST_QTDE').AsFloat),ffNumber,10,2);
  End;
end;

procedure TRL_ReportProductSaldo.PreencherGrupo;
begin
  E_Grupo.Caption := Qr_Consulta.FieldByName('GRP_DESCRICAO').asString;
end;

procedure TRL_ReportProductSaldo.PreencherSubgrupo;
begin
  E_Subgrupo.Caption := Qr_Consulta.FieldByName('SBG_DESCRICAO').asString;
end;

procedure TRL_ReportProductSaldo.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PreencherDetalhe
end;

procedure TRL_ReportProductSaldo.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_Qtde_Total.Caption   := FloatToStrF(QuantidadeTotal,ffNumber,10,3);
  E_Valor_Total.Caption := FloatToStrF(ValorTotal,ffNumber,10,3);
end;

procedure TRL_ReportProductSaldo.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PreencherGrupo
end;

procedure TRL_ReportProductSaldo.QRGroup3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PreencherSubgrupo
end;

end.
