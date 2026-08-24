unit Un_RL_ReportNF;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportList, QRCtrls, QuickRpt, Vcl.ExtCtrls, Data.DB, STQuery, prmNotas;

type
  TRL_ReportNF = class(TRL_ReportList)
    DetalheVenda: TQRBand;
    E_Data: TQRLabel;
    E_Nr_Nota: TQRLabel;
    E_VL_Nota: TQRLabel;
    E_Cliente: TQRLabel;
    E_DescricaoCFOP: TQRLabel;
    E_Pedido: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRBand1: TQRBand;
    QRLabel19: TQRLabel;
    Lb_Tl_Normais: TQRLabel;
    QRLabel10: TQRLabel;
    Lb_Tl_Cancelada: TQRLabel;
    QRLabel12: TQRLabel;
    Lb_Tl_Geral: TQRLabel;
    procedure IniciaVariaveis;Override;

    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;


    procedure PassarParametros; Override;
    procedure PreencherDetalhe; Override;

    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  public
    { Public declarations }
    It_Vl_NF_Normal: Currency;
    It_Vl_NF_Cancelada: Currency;
    Parametros : TParamNotas;
  end;

var
  RL_ReportNF: TRL_ReportNF;

implementation

{$R *.dfm}

uses     Un_DM;

{ TRL_ReportNFe }

procedure TRL_ReportNF.SelectSql;
begin
  SelectTxt := 'SELECT DISTINCT NFL_DT_EMISSAO, NFL_NUMERO NF_NUMERO, EMP_FANTASIA, NFL_CODIGO,PED_NUMERO,PED_VL_DESCONTO,NFL_MODELO, '+
               'NFL_VL_TL_NOTA,EMP_NOME, PED_TIPO, NAT_DESCRICAO,NFL_STATUS '+
               'FROM TB_NOTA_FISCAL tb_nota_fiscal ';
end;

procedure TRL_ReportNF.InnerJoinSql;
begin
  InnerJoinTxt := '    INNER JOIN TB_EMPRESA tb_empresa '+
                  '    ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
                  '    INNER JOIN TB_PEDIDO tb_pedido '+
                  '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
                  '    INNER JOIN TB_NATUREZA tb_natureza '+
                  '    ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT) ';

end;

procedure TRL_ReportNF.WhereSql;
begin
  with parametros do
  Begin
    WhereTxt := 'WHERE ( NFL_CODIGO IS NOT NULL ) ';
    Case TipoDocumento of
      1:WhereTxt := WhereTxt + ' AND ( (PED_TIPO = 1) OR (PED_TIPO = 4) ) ';
      2:WhereTxt := WhereTxt + ' AND (PED_TIPO = 2) ';
      3:WhereTxt := WhereTxt + ' AND (PED_TIPO = 3) ';
    end;

    if Periodo then WhereTxt := WhereTxt + ' AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ';
    if CodigoEmpresa > 0 then WhereTxt := WhereTxt + ' AND (NFL_CODEMP =:NFL_CODEMP) ';
    if CodigoCFOP > 0 then WhereTxt := WhereTxt + ' AND (NFL_CODNAT =:NFL_CODNAT) ';
    if CodigoEstabelecimento > 0 then WhereTxt := WhereTxt + ' AND ( NFL_CODMHA=:NFL_CODMHA ) ';
  End;
end;

procedure TRL_ReportNF.OrderBy;
begin
  OrderByTxt := Parametros.Ordenacao;
  // ' ORDER BY  1,2,3';
end;

procedure TRL_ReportNF.IniciaVariaveis;
BEgin
  inherited;
  It_Vl_NF_Normal := 0;
  It_Vl_NF_Cancelada := 0;
End;

procedure TRL_ReportNF.PreencherDetalhe;
Var
  Lc_Cor : TColor;
begin
  with Qr_Consulta do
  Begin
    E_Data.Caption := FieldByName('NFL_DT_EMISSAO').AsString;
    E_DescricaoCFOP.Caption := Copy(FieldByName('NAT_DESCRICAO').AsString,1,12);
    E_Pedido.Caption := FieldByName('PED_NUMERO').AsString;
    E_Nr_Nota.Caption := FieldByName('NF_NUMERO').AsString;
    E_Cliente.Caption := FieldByName('EMP_FANTASIA').AsString + ' - ' + FieldByName('EMP_NOME').AsString;
    if FieldByName('NFL_STATUS').AsString = 'C' then
    Begin
      It_Vl_NF_Cancelada := It_Vl_NF_Cancelada + FieldByName('NFL_VL_TL_NOTA').AsCurrency;
      Lc_Cor := clRed;
    End
    else
    BEgin
      It_Vl_NF_Normal := It_Vl_NF_Normal + FieldByName('NFL_VL_TL_NOTA').AsCurrency;
      Lc_Cor := clBlack;
    End;
    E_VL_Nota.Caption := FloatToStrf(FieldByName('NFL_VL_TL_NOTA').AsCurrency,ffNumber,18,2);

    E_Data.Font.Color :=  Lc_Cor;
    E_DescricaoCFOP.Font.Color  :=Lc_Cor;
    E_Pedido.font.Color   :=Lc_Cor;
    E_Nr_Nota.Font.Color  :=Lc_Cor;
    E_Cliente.Font.Color  :=Lc_Cor;
    E_VL_Nota.Font.Color  :=Lc_Cor;
  End;
end;



procedure TRL_ReportNF.DetalheVendaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PreencherDetalhe;
end;




procedure TRL_ReportNF.PassarParametros;
begin
  with Qr_Consulta, Parametros do
  Begin
    if Periodo then
    Begin
      ParamByName('DATAINI').AsDate := DataInicial;
      ParamByName('DATAFIM').AsDate := DataFinal;
    End;
    if CodigoEmpresa > 0 then
      ParamByName('NFL_CODEMP').AsInteger := CodigoEmpresa;
    if CodigoCFOP > 0 then
      ParamByName('NFL_CODNAT').AsInteger := CodigoCFOP;
    if CodigoEstabelecimento > 0 then
      ParamByName('NFL_CODMHA').AsInteger := CodigoEstabelecimento;
  end;
end;

procedure TRL_ReportNF.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Tl_Normais.Caption:=FloatToStrF(It_Vl_NF_Normal,ffNumber,18,2);
  Lb_Tl_Cancelada.Caption:=FloatToStrF(It_Vl_NF_Cancelada,ffNumber,18,2);
  Lb_Tl_Geral.Caption:=FloatToStrF(It_Vl_NF_Normal + It_Vl_NF_Cancelada,ffNumber,18,2);
end;



end.
