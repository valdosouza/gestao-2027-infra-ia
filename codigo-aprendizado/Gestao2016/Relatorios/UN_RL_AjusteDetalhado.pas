unit UN_RL_AjusteDetalhado;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, ExtCtrls, DB, STQuery, QRExport, StdCtrls, QRCtrls;

type
  TRL_AjusteDetalhado = class(TForm)
    Qr_Ajuste: TSTQuery;
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    QRLabel8: TQRLabel;
    QRGroup2: TQRGroup;
    E_DATA: TQRDBText;
    E_CODCOMPRA: TQRDBText;
    QRDBText3: TQRDBText;
    E_FORNECEDOR: TQRDBText;
    QRLabel11: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand5: TQRBand;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    Ft_Vendas: TQRBand;
    QRLabel6: TQRLabel;
    Lb_Tl_Dia: TQRLabel;
    QRBand6: TQRBand;
    QRLabel15: TQRLabel;
    Lb_VL_Desconto: TQRLabel;
    QRLabel19: TQRLabel;
    Lb_Tl_Total: TQRLabel;
    QRLabel10: TQRLabel;
    Lb_Sbt_Vendas: TQRLabel;
    QRBand7: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel1: TQRLabel;
    E_Retorno: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Tipo_Oper: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Lb_Empresa: TQRLabel;
    QRLabel24: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    QRLabel25: TQRLabel;
    Lb_Pendente: TQRLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand6BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Ft_VendasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_VL_Desconto, IT_Vl_Venda, It_Vl_Total : Real;

    procedure Pc_Busca;
    procedure Pc_Parametros;
  end;

var
  RL_AjusteDetalhado: TRL_AjusteDetalhado;

implementation

uses      UN_DM, DBCtrls, UN_Sistema, UN_Imp_Ajuste, ComCtrls, Un_Principal, env;
{$R *.dfm}



procedure TRL_AjusteDetalhado.Pc_Busca;
VaR
  Lc_SqlTxt:String;
  Lc_Cliente:Boolean;
begin
  with Fr_Imp_Ajuste do
    Begin
    Screen.Cursor:=crHourGlass;
    It_VL_Desconto := 0;
    IT_Vl_Venda := 0;
    It_Vl_Total := 0;
    Qr_Ajuste.Close;
    Qr_Ajuste.SQL.Clear;
    Lc_SqlTxt := 'SELECT DISTINCT NFL_CODIGO,EMP_NOMe,EMP_FANTASIA,                            '+
              'NFL_DT_EMISSAO,PED_NUMERO,PED_VL_DESCONTO, NFL_NUMERO, NFL_VL_TL_NOTA,       '+
              'PRO_CODIGOFAB, PRO_DESCRICAO,ITF_CODIGO,ITF_CODNFL, ITF_CODPRO,              '+
              'MED_ABREVIATURA,ITF_QTDE,ITF_VL_UNIT,ITF_AQ_COM, NFL_CTRL_RETORNO,           '+
              '(tb_itens_nfl.ITF_QTDE)*(tb_itens_nfl.ITF_VL_UNIT) as ITF_Subtotal           '+
              'FROM TB_NOTA_FISCAL tb_nota_fiscal                                           '+
              '    INNER JOIN TB_EMPRESA tb_empresa                                         '+
              '    ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)                   '+
              '    INNER JOIN  TB_PEDIDO tb_pedido                                      '+
              '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)                    '+
              '    INNER JOIN TB_ITENS_NFL tb_itens_nfl                                     '+
              '    ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO)                 '+
              '    INNER JOIN TB_PRODUTO tb_produto                                         '+
              '    ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO)                     '+
              '    INNER JOIN TB_MEDIDA tb_medida                                           '+
              '    ON (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)                        '+
              'WHERE (PED_TIPO = 3) AND (NFL_STATUS = ''F'') ';

  if (not Grb_MnhaEmpresa.Visible) or (not chbx_Empresas.Checked) then
    Begin
    Lc_SqlTxt := Lc_SqlTxt + ' AND (NFL_CODMHA =:NFL_CODMHA) ';
    end;
                  
    if ChBx_Periodo.Checked then
    Lc_SqlTxt := Lc_SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';

    if DBLCB_Empresa.Text ='' then Lc_Cliente := False else Lc_Cliente := True;

    if Lc_Cliente then Lc_SqlTxt := Lc_SqlTxt +'AND (NFL_CODEMP =:NFL_CODEMP) ';
    if Rg_Operacao.ItemIndex = 0 then Lc_SqlTxt := Lc_SqlTxt +'AND (NFL_TIPO LIKE ''E%'') ';
    if Rg_Operacao.ItemIndex = 1 then Lc_SqlTxt := Lc_SqlTxt +'AND (NFL_TIPO LIKE ''S%'') ';
    if RG_Tipo.ItemIndex =0 then Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_NUMERO IS NULL) ';
    if RG_Tipo.ItemIndex =1 then Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_NUMERO IS NOT NULL) ';
    if ChBx_Pendente.Checked then Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_CTRL_RETORNO <> ''N'') ';

     IF ChBx_Nome.Checked then
      Qr_Ajuste.SQL.Add(Lc_SqlTxt+'ORDER BY  NFL_DT_EMISSAO,NFL_NUMERO, EMP_NOME ')
    ELSE
      Qr_Ajuste.SQL.Add(Lc_SqlTxt+'ORDER BY  NFL_DT_EMISSAO,NFL_NUMERO, EMP_FANTASIA ');


    if not Grb_MnhaEmpresa.Visible then
      Begin
      Qr_Ajuste.ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
      end
    else
      Begin
      if not chbx_Empresas.Checked then
        Qr_Ajuste.ParamByName('NFL_CODMHA').AsInteger := Dblcb_Mha_Empresa.KeyValue;
      end;

    if Lc_Cliente then Qr_Ajuste.ParamByName('NFL_CODEMP').AsInteger:=DBLCB_Empresa.KeyValue;
          
    if ChBx_Periodo.Checked then
      BEGIN
      Qr_Ajuste.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      Qr_Ajuste.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
      END;
    Qr_Ajuste.Open;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TRL_AjusteDetalhado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_AjusteDetalhado:=nil;
end;

procedure TRL_AjusteDetalhado.FormCreate(Sender: TObject);
begin
  with Fr_Imp_Ajuste do
  Begin
    IF ChBx_Nome.Checked then E_FORNECEDOR.DataField := ('EMP_NOME');
    if ChBx_Fantasia.Checked then E_FORNECEDOR.DataField := ('EMP_FANTASIA');
  end;
end;

procedure TRL_AjusteDetalhado.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    IT_Vl_Venda := IT_Vl_Venda + Qr_Ajuste.FieldByName('NFL_VL_TL_NOTA').AsCurrency;
    It_VL_Desconto := It_VL_Desconto + Qr_Ajuste.FieldByName('PED_VL_DESCONTO').AsCurrency;
  if Qr_Ajuste.FieldByName('NFL_CTRL_RETORNO').AsString = 'N' then
    Begin
    E_Retorno.Caption := NAO;
    end
  else
    begin
    if Qr_Ajuste.FieldByName('NFL_CTRL_RETORNO').AsString = 'P' then
      E_Retorno.Caption := 'Pedido'
    else
      E_Retorno.Caption := 'Nota';
    end;    

  Lb_Sbt_Vendas.Caption:=FloatToStrF(It_Vl_Total,ffNumber,18,2);
  Lb_VL_Desconto.Caption:=FloatToStrF(It_VL_Desconto,ffNumber,18,2);
  Lb_Tl_Total.Caption:=FloatToStrF(It_Vl_Total,ffNumber,18,2);

end;

procedure TRL_AjusteDetalhado.QRBand6BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  // Lb_Sbt_Vendas.Caption:=FloatToStrF(It_Vl_Total,ffNumber,18,2);
  //Lb_VL_Desconto.Caption:=FloatToStrF(It_VL_Desconto,ffNumber,18,2);
  //Lb_Tl_Total.Caption:=FloatToStrF(It_Vl_Total - It_VL_Desconto,ffNumber,18,2);
end;

procedure TRL_AjusteDetalhado.Ft_VendasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Tl_Dia.Caption := FloatToStrF(IT_Vl_Venda,ffNumber,18,2);
  It_Vl_Total := It_Vl_Total + IT_Vl_Venda;
  IT_Vl_Venda := 0;

end;

procedure TRL_AjusteDetalhado.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_AjusteDetalhado.Pc_Parametros;
begin
  with Fr_Imp_Ajuste do
    begin
    // Verifica tipos de documento
    case RG_Tipo.ItemIndex of
      0 : Lb_Tipo_Doc.Caption := 'Pedido';
      1 : Lb_Tipo_Doc.Caption := 'Notas';
      2 : Lb_Tipo_Doc.Caption := 'Todos';
    end;
    // Verifica qual é a operação
    if Rg_Operacao.ItemIndex = 0 then
      Lb_Tipo_Oper.Caption := 'Entrada'
    else
      Lb_Tipo_Oper.Caption := 'Saída';
    // Verifica data solicitada
    if ChBx_Periodo.Checked then
      Begin
      Lb_Data_Ini.Caption := DateToStr( E_Data_Ini.Date);
      Lb_Data_Fim.Caption := DateToStr( E_Data_Fim.Date);
      end
    else
      Begin
      Lb_Data_Ini.Caption := '';
      Lb_Data_Fim.Caption := '';
      end;      
    // Verifica se o campo cliente foi preenchido
    if trim(DBLCB_Empresa.Text) = '' then
      Lb_Empresa.Caption := 'Todos'
    else
      Lb_Empresa.Caption := DBLCB_Empresa.Text;
    // Verifica se o tipo do relatorio
    case Cb_Tipo.ItemIndex of
      0 : Lb_Tipo_Rl.Caption := 'NORMAL';
      1 : Lb_Tipo_Rl.caption := 'DETALHADO';
     end;
    // Verifica opção Pendente
    if ChBx_Pendente.Checked = true then
      begin
      Lb_Pendente.Caption := SIM
      end
    else
      begin
      Lb_Pendente.Caption := NAO;
      end;
    end;
  end;

end.
