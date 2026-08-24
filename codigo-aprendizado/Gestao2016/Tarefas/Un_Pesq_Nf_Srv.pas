unit Un_Pesq_Nf_Srv;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Un_Pesq_NotaFiscal, STDatabase, DB, STQuery, Grids, DBGrids, Buttons, ExtCtrls, StdCtrls, DBCtrls, QEdit_Setes, ComCtrls, Mask, Un_Fm_ListaMultiEmpresa, base_frame_list, un_fm_lista_cfop;

type
  TFr_Pesq_NF_Srv = class(TFr_Pesq_NotaFiscal)
    E_BuscaRPS: TMaskEdit;
    Label3: TLabel;
    procedure SB_VisualizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);

    procedure Pc_Visualizar;Override;
    procedure SB_BuscarClick(Sender: TObject);
  private
    { Private declarations }
    It_RPS : Boolean;
    procedure Pc_FormataTela;
    procedure Buscar;Override;
    procedure VerificaParametros;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure PassarParametros(Qry: TSTQuery);Override;

  public
    { Public declarations }
  end;

var
  Fr_Pesq_NF_Srv: TFr_Pesq_NF_Srv;

implementation

uses     Un_Funcoes, RN_NotaFiscalServico, UN_Sistema, UN_Principal, env, Un_DM;
{$R *.dfm}

procedure TFr_Pesq_NF_Srv.Buscar;
begin
  inherited;
  (Qr_Pesquisa.FieldByName('NFL_VL_TL_SRV') as TNumericField).DisplayFormat  := '0.00##';
  SomaNotas('NFL_VL_TL_SRV');
end;

procedure TFr_Pesq_NF_Srv.Pc_FormataTela;
Begin

  //Situação Da NFS-e
  Rg_Sit_Nfe.Items.Clear;
  Rg_Sit_Nfe.Items.Add('Pendentes');
  Rg_Sit_Nfe.Items.Add('R.P.S - Gerada');
  Rg_Sit_Nfe.Items.Add('R.P.S - Enviada');
  Rg_Sit_Nfe.Items.Add('R.P.S - Erros');
  Rg_Sit_Nfe.Items.Add('N.F. - Autorizadas');
  Rg_Sit_Nfe.Items.Add('N.F. - Canceladas');
  Rg_Sit_Nfe.Items.Add('Todas');
  Rg_Sit_Nfe.Columns := 7;
  Rg_Sit_Nfe.Width := 800;
  Rg_Sit_Nfe.ItemIndex := 6;
  //Tipo de Notas
  Rg_Tipo_Nota.Visible := false;
  //Tipo Operação
  RG_Tipo_Operacao.Visible := false;
  //Grade de Pesquisa
  DBG_Pesquisa.Columns.Clear;
  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'NFL_DT_EMISSAO';
    width := 70;
    Title.Caption := 'Data RPS';
    Alignment := taCenter;
  end;
  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'RPS_NUMERO';
    width := 75;
    Title.Caption := 'Numero RPS';
    Alignment := taCenter;
  end;

  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'NFS_DATETIME';
    width := 110;
    Title.Caption := 'Data N.F.';
    Alignment := taLeftJustify;
  end;

  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'NFS_NUMERO';
    width := 75;
    Title.Caption := 'Número N.F.';
    Alignment := taCenter;
  end;

  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'EMP_FANTASIA';
    width := 330;
    Title.Caption := 'Nome/Fantasia';
  end;
  IndGrid := 4;
  with DBG_Pesquisa.Columns.Add do
  Begin
    FieldName := 'NFL_VL_TL_SRV';
    width := 90;
    Title.Caption := 'Valor Nota';
    Alignment := taRightJustify;
  end;

end;

Procedure TFr_Pesq_NF_Srv.VerificaParametros;
Begin
  inherited;
  if Trim(E_BuscaRPS.Text)     = '' then It_RPS       := False else It_RPS       := True;
end;

procedure TFr_Pesq_NF_Srv.Pc_Visualizar;
Begin
  with Qr_Pesquisa do
  BEgin
    Pc_AbreTelaNF_Srv(FieldByName('NFL_CODIGO').AsInteger);
  end;
end;

procedure TFr_Pesq_NF_Srv.SB_VisualizarClick(Sender: TObject);
begin
  if fc_Valida_Visualizacao then
  Begin
    Pc_Visualizar;
  end;
end;

procedure TFr_Pesq_NF_Srv.SelectSql;
begin
  SelectTxt :=  'SELECT NFL_CODIGO, NFL_DT_EMISSAO, RPS.NUMERO RPS_NUMERO, '+
                ' NFS_DATETIME,NFS_NUMERO,EMP_NOME, EMP_FANTASIA,NFL_VL_TL_SRV, '+
                ' PED_CODVDO  '+
                'FROM TB_NOTA_FISCAL Tb_nota_fiscal '+
                '  INNER JOIN TB_EMPRESA tb_empresa '+
                '  ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
                '  INNER JOIN TB_PEDIDO tb_pedido '+
                '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) ';
end;

procedure TFr_Pesq_NF_Srv.InnerJoinSql;
begin
  inherited;
  case Rg_Sit_Nfe.ItemIndex of
    0:Begin
        InnerJoinTxt :=  InnerJoinTxt +
                      '  LEFT OUTER JOIN TB_RETORNO_NFS '+
                      '  ON (NFS_CODNFL = NFL_CODIGO) '+
                      '  LEFT OUTER JOIN TB_RPS_NFSE RPS '+
                      '  ON (RPS.TB_NOTAFISCAL_ID = NFL_CODIGO) ';
      end;
    1..3:Begin
            InnerJoinTxt :=  InnerJoinTxt +
                          '  LEFT OUTER JOIN TB_RETORNO_NFS '+
                          '  ON (NFS_CODNFL = NFL_CODIGO) '+
                          '  INNER JOIN TB_RPS_NFSE RPS '+
                          '  ON (RPS.TB_NOTAFISCAL_ID = NFL_CODIGO) ';
         end;
    4..5:Begin
            InnerJoinTxt :=  InnerJoinTxt +
                          '  INNER JOIN TB_RETORNO_NFS '+
                          '  ON (NFS_CODNFL = NFL_CODIGO) '+
                          '  INNER JOIN TB_RPS_NFSE RPS '+
                          '  ON (RPS.TB_NOTAFISCAL_ID = NFL_CODIGO) ';
         end;
    6:Begin
        InnerJoinTxt :=  InnerJoinTxt +
                      '  LEFT OUTER JOIN TB_RETORNO_NFS '+
                      '  ON (NFS_CODNFL = NFL_CODIGO) '+
                      '  LEFT OUTER JOIN TB_RPS_NFSE RPS '+
                      '  ON (RPS.TB_NOTAFISCAL_ID = NFL_CODIGO) ';
      end;
  end;


end;

procedure TFr_Pesq_NF_Srv.WhereSql;
begin
  inherited;
  WhereTxt := WhereTxt + ' AND (NFL_VL_TL_SRV > 0)';

  WhereTxt := WhereTxt + ' AND (NFL_CODMHA =:NFL_CODMHA) ' ;

  if It_Nota then
    WhereTxt := WhereTxt + 'AND NFS_NUMERO =:NFS_NUMERO ';
  if It_RPS and ( (Rg_Sit_Nfe.ItemIndex >= 0) and (Rg_Sit_Nfe.ItemIndex <= 6) ) then
    WhereTxt := WhereTxt + 'AND RPS.RPS_NUMERO =:RPS_NUMERO ';
  if It_Pedido then
    WhereTxt := WhereTxt + 'AND PED_NUMERO =:PED_NUMERO ';
  if It_Cd_Empresa then
    WhereTxt := WhereTxt + 'AND NFL_CODEMP =:EMP_CODIGO ';
  if It_Razao then
    WhereTxt := WhereTxt + 'AND ( (EMP_NOME LIKE :EMP_NOME) or (EMP_FANTASIA LIKE :EMP_NOME) )  ';
  if It_Bairro then
    WhereTxt := WhereTxt + 'AND END_BAIRRO LIKE :END_BAIRRO ';
  if It_Regiao then
    WhereTxt := WhereTxt + 'AND END_REGIAO LIKE :END_REGIAO ';
  if It_Estado then
    WhereTxt := WhereTxt + 'AND UFE_SIGLA =:UFE_SIGLA ';
  if It_Cidade then
    WhereTxt := WhereTxt + 'AND CDD_DESCRICAO LIKE :CDD_DESCRICAO ';
  if It_Fone then
    WhereTxt := WhereTxt + 'AND ((END_FONE LIKE :END_FONE) OR (END_FAX LIKE :END_FONE) OR (END_CELULAR LIKE :END_FONE)) ';
  if It_Vendedor then
    WhereTxt := WhereTxt + 'AND PED_CODVDO =:PED_CODVDO ';
  if It_CFOP then
    WhereTxt := WhereTxt + 'AND (NFL_CODNAT =:NAT_CODIGO) ';
  if It_Obs then
    WhereTxt := WhereTxt + 'AND (OBN_DETALHE LIKE :OBN_DETALHE) ';

  WhereTxt := WhereTxt + ' AND (PED_TIPO = ''1'') ';

  if ChBx_Periodo.Checked then
    WhereTxt := WhereTxt + ' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ';

  case Rg_Sit_Nfe.ItemIndex of
    0:WhereTxt := WhereTxt + ' and (RPS.NUMERO IS NULL)';
    1:WhereTxt := WhereTxt + ' and (RPS.NUMERO IS NOT NULL) AND (NFS_NUMERO IS NULL) and (RPS.OBS IS NULL)';
    2:WhereTxt := WhereTxt + ' and (RPS.NUMERO IS NOT NULL) AND (RPS.PROTOCOLO IS NOT NULL) AND (RPS.PROTOCOLO <> '''') AND (NFS_NUMERO IS NULL) and (RPS.OBS IS NULL) ';
    3:WhereTxt := WhereTxt + ' and (RPS.OBS IS NOT NULL) ';
    4:WhereTxt := WhereTxt + ' and (NFS_CODSIT = ''4'') ';
    5:WhereTxt := WhereTxt + ' and (NFS_CODSIT = ''5'') ';
  end;

end;


procedure TFr_Pesq_NF_Srv.PassarParametros(Qry: TSTQuery);
begin
  with Qr_Pesquisa do
  Begin
    if ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    end;

    ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    if It_Nota then
      ParamByName('NFS_NUMERO').AsString := E_BuscaNota.Text;
    if It_RPS and ( (Rg_Sit_Nfe.ItemIndex >= 0) and (Rg_Sit_Nfe.ItemIndex <= 6) ) then
      ParamByName('RPS_NUMERO').AsString := E_BuscaRPS.Text;
    if It_Pedido then
      qr_Pesquisa.ParamByName('PED_NUMERO').AsInteger:=StrToIntDef(E_BuscaPedido.Text,0);
    if It_Cd_Empresa then
      ParamByName('EMP_CODIGO').AsInteger := StrToIntDef( E_BuscaEmpresa.Text,0 );
    if It_Razao then
      ParamByName('EMP_NOME').AsString := '%' + Copy(E_BuscaRazao.Text,1,98) + '%';
    if It_Bairro then
      ParamByName('END_BAIRRO').AsString := '%' + E_BuscaBairro.Text + '%';
    if It_Regiao then
      ParamByName('END_REGIAO').AsString := '%' + E_BuscaRegiao.Text + '%';
    if It_Estado then
      ParamByName('UFE_SIGLA').AsString := E_BuscaEstado.Text;
    if It_Cidade then
      ParamByName('CDD_DESCRICAO').AsString := '%' + E_BuscaCidade.Text + '%';
    if It_Fone then
      ParamByName('END_FONE').AsString := '%' + Fc_RemoveCaracterInformado(E_BuscaFone.Text, ['(',')',' ','-','-']);
    if It_Vendedor then
      ParamByName('PED_CODVDO').AsInteger := Dblcb_BuscaVendedor.KeyValue;
    if It_Obs then
      ParamByName('OBN_DETALHE').AsString := '%' + E_BuscaObs.Text + '%';
    if It_CFOP then
      ParamByName('NAT_CODIGO').AsInteger := Fm_lista_cfop.Dblcb_Lista.KeyValue;
  end;
end;

procedure TFr_Pesq_NF_Srv.FormShow(Sender: TObject);
begin
  inherited;
  Pc_FormataTela;
end;


procedure TFr_Pesq_NF_Srv.ChBx_FantasiaClick(Sender: TObject);
begin
  IF ChBx_Fantasia.Checked THEN
  Begin
    ChBx_Nome.Checked := False;
    DBG_Pesquisa.Columns.Items[4].Title.Caption := 'Nome Fantasia/Apelido/Codnome';
    DBG_Pesquisa.Columns.Items[4].FieldName := 'EMP_FANTASIA'
  end;
end;

procedure TFr_Pesq_NF_Srv.ChBx_NomeClick(Sender: TObject);
begin
  IF ChBx_Nome.Checked THEN
  Begin
    ChBx_Fantasia.Checked := False;
    DBG_Pesquisa.Columns.Items[4].Title.Caption := 'Nome/Razão Social';
    DBG_Pesquisa.Columns.Items[4].FieldName := 'EMP_NOME'   ;
  end;
end;

procedure TFr_Pesq_NF_Srv.SB_BuscarClick(Sender: TObject);
begin
  inherited;
  //Herda
end;

end.
