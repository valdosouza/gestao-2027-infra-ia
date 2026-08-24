unit Un_RL_ReportProductCadastro;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportProduct, Data.DB, AnsiStrings, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportProductCadastro = class(TRL_ReportProduct)
    QRBand1: TQRBand;
    E_DescricaoProduto: TQRLabel;
    E_VL_Preco: TQRLabel;
    E_VL_Custo: TQRLabel;
    E_codigoProduto: TQRLabel;
    E_Margem: TQRLabel;
    Ft_SubGrupo: TQRBand;
    QRLabel6: TQRLabel;
    QRExpr1: TQRExpr;
    QRBand3: TQRBand;
    GroupSubGrupo: TQRGroup;
    E_Subgrupo: TQRLabel;
    Lb_Codigo: TQRLabel;
    Lb_Descricao: TQRLabel;
    Lb_ValorCusto: TQRLabel;
    Lb_ValorVenda: TQRLabel;
    Lb_Margem: TQRLabel;
    QRLabel1: TQRLabel;
    QRExpr2: TQRExpr;
    E_Grupo: TQRLabel;
    procedure OrderBy;Override;
    procedure PreencherSubgrupo;
    procedure PreencherDetalhe;Override;
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure GroupGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure GroupSubGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RL_ReportProductCadastro: TRL_ReportProductCadastro;

implementation

{$R *.dfm}

{ TRL_ReportProductCadastro }

procedure TRL_ReportProductCadastro.OrderBy;
begin
  case AnsiIndexStr(UpperCase(Parametros.Ordenacao), ['PRO_DESCRICAO', 'PRO_CODIGOFAB','PRO_CODIGO']) of
    0:OrderByTxt := ' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_DESCRICAO ASC ';
    1:OrderByTxt := ' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGOFAB ASC ';
    2:OrderByTxt := ' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGO ASC ';
  end;
end;

procedure TRL_ReportProductCadastro.PreencherDetalhe;
begin
  with Qr_Consulta do
  Begin
    E_codigoProduto.Caption := FieldByName('PRO_CODIGOFAB').AsString;
    E_DescricaoProduto.Caption := FieldByName('PRO_DESCRICAO').AsString;
    E_Margem.Caption := concat(FloatToStrF(FieldByName('PRC_MAR_LRC').AsFloat,ffFixed,3,2),'%');
    {
    //o campo que existia Lb_Margem foi retirado por falta de uso
    if FieldByName('PRC_MAR_LRC').AsFloat > 0 then
    Begin
      Lb_Margem.Caption := FloatToStrF(FieldByName('PRC_MAR_LRC').AsFloat,ffFixed,3,2);
    End
    else
    Begin
      if FieldByName('PRC_VL_VDA').AsCurrency > 0 then
      Begin
        Lb_Margem.Caption := Fc_Calc_Mrg_Valor + ' %';
      end
      else
        Lb_Margem.Caption := '0,00%';
    End;
    }
    E_VL_Custo.Caption := FloatToStrF(FieldByName('PRO_VL_CUSTO').AsCurrency,ffNumber,10,2);
    E_VL_Preco.Caption := FloatToStrF(FieldByName('PRC_VL_VDA').AsCurrency,ffNumber,10,2);
  End;
end;

procedure TRL_ReportProductCadastro.PreencherSubgrupo;
begin
  E_Grupo.Caption := concat('Grupo: ',Qr_Consulta.FieldByName('GRP_DESCRICAO').asString);
  E_Subgrupo.Caption := concat('   Subgrupo: ',Qr_Consulta.FieldByName('SBG_DESCRICAO').asString);
  Lb_Codigo.Caption     := 'Código';
  Lb_Descricao.Caption  := 'Descrição do produto';
  Lb_Margem.Caption     := 'Margem';
  Lb_ValorCusto.Caption := 'Valor Custo';
  Lb_ValorVenda.Caption := 'Valor Venda';
end;

procedure TRL_ReportProductCadastro.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  PreencherDetalhe;
end;

procedure TRL_ReportProductCadastro.GroupGrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  GroupSubGrupo.Height := 47;
  PreencherGrupo;
end;

procedure TRL_ReportProductCadastro.GroupSubGrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  PreencherSubGrupo;
end;

end.
