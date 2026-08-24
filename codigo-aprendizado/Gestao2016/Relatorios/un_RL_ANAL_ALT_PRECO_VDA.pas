unit un_RL_ANAL_ALT_PRECO_VDA;

interface

uses
      Windows, SysUtils, Messages, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, QuickRpt, QRCtrls, DB, STQuery;

type
  TRL_ANAL_ALT_PRECO_VDA = class(TForm)
    Qrpt: TQuickRep;
    QRGroup1: TQRGroup;
    QRDBText1: TQRDBText;
    QRGroup2: TQRGroup;
    QRDBText2: TQRDBText;
    QRGroup3: TQRGroup;
    QRDBText3: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel27: TQRLabel;
    QRBand1: TQRBand;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    E_CODPRODUTO: TQRDBText;
    QRDBText7: TQRDBText;
    QRBand2: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    QRSysData3: TQRSysData;
    QRBand3: TQRBand;
    QRLabel12: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel20: TQRLabel;
    Lb_Estoque: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Lb_Tab_Preco: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Ordenacao: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    Lb_Grupo: TQRLabel;
    QRLabel11: TQRLabel;
    Lb_Subgrupo: TQRLabel;
    QRLabel19: TQRLabel;
    Lb_Marca: TQRLabel;
    Qr_Produtos: TSTQuery;
    QRLabel28: TQRLabel;
    QRDBText8: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel29: TQRLabel;
    QRLabel6: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  procedure Pc_Busca;
  procedure Pc_Parametros;
  function Fc_CodigoUltimaAlteracao():String;
  end;

var
  RL_ANAL_ALT_PRECO_VDA: TRL_ANAL_ALT_PRECO_VDA;

implementation

uses     UN_Imp_Produtos, Un_DM, UN_Sistema;
{$R *.dfm}

{ TRL_ANAL_ALT_PRECO_VDA }


function TRL_ANAL_ALT_PRECO_VDA.Fc_CodigoUltimaAlteracao():String;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := '';
  Lc_Qry := TSTQuery.Create(RL_ANAL_ALT_PRECO_VDA);
  with Lc_Qry do
    Begin
    Database:= DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;

    SQL.Clear;
    SQL.Add(' select MAX(apr_codigo) apr_codigo '+
            ' from tb_altera_preco '+
            ' WHERE APR_CODIGO IS NOT NULL ');
    if Fr_Imp_Produtos.ChBx_Periodo.Checked then
      SQL.Add(' AND (APR_DATATIME BETWEEN :DATAINI AND :DATAFIM) ');
    SQL.Add(' GROUP BY (APR_CODPRO) ');

    if Fr_Imp_Produtos.ChBx_Periodo.Checked then
      begin
      ParamByName('DATAINI').AsDateTime := Fr_Imp_Produtos.E_Data_Ini.DateTime;
      ParamByName('DATAFIM').AsDateTime := Fr_Imp_Produtos.E_Data_Fim.DateTime;
      end;
    Active := True;
    First;

    while not eof do
      Begin
      if bof then
        Result := '(' + FieldByName('APR_CODIGO').AsString
      else
        Result := Result + ',' + FieldByName('APR_CODIGO').AsString;
      next;
      end;
    end;
  Result := Result + ')';
end;

procedure TRL_ANAL_ALT_PRECO_VDA.Pc_Busca;
VaR
  SqlTxt:String;
  Lc_produto, Lc_Grupo, Lc_SubGrupo,Lc_Marca, Lc_Fornece:Boolean;
begin
  with Fr_Imp_Produtos do
    Begin
    with Qr_Produtos do
      Begin
      Close;
      SQL.Clear;
      SQLtxt :=' select grp_descricao, sbg_descricao, pro_codigo, pro_descricao, APR_VL_ANTERIOR, APR_VL_ATUAL, '+
               ' APR_DATATIME, USU_LOGIN '+
               ' from tb_altera_preco tb_altera_preco '+
               ' inner join tb_produto tb_produto '+
               ' on tb_produto.pro_codigo = tb_altera_preco.apr_codpro '+
               ' inner join tb_grupos tb_grupos '+
               ' on tb_grupos.grp_codigo = tb_produto.pro_codgrp '+
               ' inner join tb_subgrupos tb_subgrupos '+
               ' on tb_subgrupos.sbg_codigo = tb_produto.pro_codsbg '+
               ' inner join tb_usuario tb_usuario '+
               ' on tb_usuario.usu_codigo = tb_altera_preco.apr_codusu '+
               ' where (APR_CODTPR=:APR_CODTPR) ';

      if ChBx_UltimaAlteracaoVenda.Checked then
        Begin
        SqlTxt := SqlTxt + ' AND (APR_CODIGO IN '+ Fc_CodigoUltimaAlteracao + ')';
        end;


      if DBLCB_Grupos.Text ='' then Lc_Grupo := False else Lc_Grupo := True;
      if DBLCB_SubGrupos.Text ='' then Lc_SubGrupo := False else Lc_SubGrupo := True;
      if DBLCB_Marca.Text ='' then Lc_Marca := False else Lc_Marca := True;
      if E_BuscaDescricaoProduto.Text ='' then Lc_produto := False else Lc_produto := True;

      if Lc_Grupo then SqlTxt := SqlTxt +'AND (PRO_CODGRP =:PRO_CODGRP) ';
      if Lc_SubGrupo then SqlTxt := SqlTxt +'AND (PRO_CODSBG =:PRO_CODSBG) ';
      if Lc_Marca then SqlTxt := SqlTxt +'AND (PRO_CODMRC =:PRO_CODMRC) ';
      if Lc_Produto then SqlTxt := SqlTxt +'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';
      if ChBx_Periodo.Checked then
        SqlTxt := SqlTxt +' AND (APR_DATATIME BETWEEN :DATAINI AND :DATAFIM) ';

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
        SqlTxt := SqlTxt +'AND (PRO_CODMHA =:PRO_CODMHA) ';

      case CB_Ordena.ItemIndex of
        0:SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_DESCRICAO ASC ');
        1:SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGOFAB ASC ');
        2:SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGO ASC ');
      end;

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      Qr_Produtos.ParamByName('PRO_CODMHA').AsInteger:= Fm_LME.Dblcb_Lista.KeyValue;


      if ChBx_Periodo.Checked then
        begin
        ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
        ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
        end;
      ParamByName('APR_CODTPR').AsInteger:= DBLCB_Tabela_Preco.KeyValue;

      if Lc_Grupo then ParamByName('PRO_CODGRP').AsInteger:=DBLCB_Grupos.KeyValue;
      if Lc_SubGrupo then ParamByName('PRO_CODSBG').AsInteger:=DBLCB_SubGrupos.KeyValue;
      if Lc_Marca then ParamByName('PRO_CODMRC').AsInteger:=DBLCB_Marca.KeyValue;
      if Lc_Produto then ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(E_BuscaDescricaoProduto.Text,1,98) + '%';
      Open;
      FetchAll;
      First;
      RecordCount;
      Screen.Cursor:=crDefault;
      end;
    end;
end;

procedure TRL_ANAL_ALT_PRECO_VDA.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(QRPT);
  Action:=caFree;
  RL_ANAL_ALT_PRECO_VDA :=nil;
end;

procedure TRL_ANAL_ALT_PRECO_VDA.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
end;

procedure TRL_ANAL_ALT_PRECO_VDA.Pc_Parametros;
begin
  with Fr_Imp_Produtos do
    Begin 
    Lb_Tab_Preco.Caption:= DBLCB_Tabela_Preco.Text;
    IF ChBx_Periodo.Checked THEN
      BEGIN
      Lb_Data_Ini.Caption:= DateToStr(E_Data_Ini.Date);
      Lb_Data_Fim.Caption:= DateToStr(E_Data_Fim.Date);
      END
    ELSE
      BEGIN
      Lb_Data_Ini.Caption:= 'Todos' ;
      Lb_Data_Fim.Caption:= 'Todos';
      END;

    IF trim(DBLCB_Grupos.Text)='' THEN
      Lb_Grupo.Caption:='Todos'
    else
      Lb_Grupo.Caption:=DBLCB_Grupos.Text;

    IF trim(DBLCB_SubGrupos.Text)='' THEN
      Lb_Subgrupo.Caption:='Todos'
    else
      Lb_Subgrupo.Caption:=DBLCB_SubGrupos.Text;

    IF trim(DBLCB_Marca.Text)='' THEN
      Lb_Marca.Caption:='Todos'
    else
      Lb_Marca.Caption:= DBLCB_Marca.Text;
    end;
end;

procedure TRL_ANAL_ALT_PRECO_VDA.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_Parametros
end;

end.
