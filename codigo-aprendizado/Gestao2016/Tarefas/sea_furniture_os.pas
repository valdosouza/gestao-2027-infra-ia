unit sea_furniture_os;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls, Un_Fm_ListaSituacao, QEdit_Setes, Vcl.Mask, Un_Fm_ListaEmpresas, Vcl.ComCtrls, base_search, Datasnap.Provider, Datasnap.DBClient, Vcl.DBGrids, ControllerFurnitureOS, Un_Fm_ListaColaboradores;

type
  TSeaFurnitureOS = class(TBaseSearch)
    Label28: TLabel;
    Label29: TLabel;
    Label1: TLabel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Fm_ListaEmpresas: TFm_ListaEmpresas;
    E_Equipment: TEdit;
    E_Modelo: TEdit;
    E_Marca: TEdit;
    Fm_ListaSituacao: TFm_ListaSituacao;
    Fm_ListaVendedores: TFm_ListaColaboradores;
    Sb_PEdido: TSpeedButton;
    Label2: TLabel;
    E_Nr_Pedido: TEdit;
    Fm_ListaTecnico: TFm_ListaColaboradores;
    chbx_sem_tecnico: TCheckBox;
    Lb_valor_produtos: TLabel;
    E_valor_produtos: TLabel;
    Lb_valor_servicos: TLabel;
    E_valor_servicos: TLabel;
    Lb_valor_total: TLabel;
    E_valor_total: TLabel;
    Label8: TLabel;
    E_Environment: TEdit;
    cds_searchPED_CODIGO: TIntegerField;
    cds_searchPED_NUMERO: TIntegerField;
    cds_searchPED_DATA: TDateField;
    cds_searchPED_HORA: TTimeField;
    cds_searchEMP_FANTASIA: TWideStringField;
    cds_searchEND_FONE: TWideStringField;
    cds_searchEND_CELULAR: TWideStringField;
    cds_searchSIT_DESCRICAO: TWideStringField;
    cds_searchPED_VL_PEDIDO: TBCDField;
    cds_searchEQUIPMENT: TWideStringField;
    cds_searchTB_SITUACAO_ID: TIntegerField;
    cds_searchPED_CODEMP: TIntegerField;
    cds_searchVENDEDOR: TWideStringField;
    cds_searchENVIRONMENT: TWideStringField;
    cds_searchBRAND: TWideStringField;
    cds_searchMODEL: TWideStringField;
    cds_searchPED_FATURADO: TWideStringField;
    cds_searchDT_ATTENDANCE: TDateField;
    cds_searchHR_ATTENDANCE: TTimeField;
    cds_searchTECNICO: TWideStringField;
    cds_searchSIT_COLOR: TWideStringField;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Sb_PEdidoClick(Sender: TObject);
    procedure chbx_sem_tecnicoClick(Sender: TObject);
    procedure DBG_PesquisaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    It_Supervisor : Boolean;
    procedure OpenOrder;
    Procedure OpenInvoice;
  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    function validateGetViewOrder:Boolean;
    procedure setPerfil;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBySql;Override;
    procedure GroupBySql;Override;
    procedure SetParameters(Param: TSTQuery);Override;
    procedure GetView;Override;
    procedure totalizer;Override;
    procedure SetRegister;Override;
    procedure returnRegister;Override;
    procedure ImagemBotao;Override;
    procedure execShorCutKeyF9;Override;
  public
    { Public declarations }
    Furniture : TControllerFurnitureOS;
  end;

var
  SeaFurnitureOS: TSeaFurnitureOS;

implementation

{$R *.dfm}

uses     Un_DM, RN_Permissao, UN_Principal, env, RN_NotaFiscal, UN_Sistema, Un_Msg, Un_Regra_Negocio, tas_furniture_os, UN_Pedido_Vda;
procedure TSeaFurnitureOS.chbx_sem_tecnicoClick(Sender: TObject);
begin
  inherited;
  if TCheckBox(sender).Checked then
  Begin
    Fm_ListaTecnico.Dblcb_Vendedor.KeyValue := Null;
    Fm_ListaTecnico.Dblcb_Vendedor.Enabled := False;
  End
  else
  Begin
    Fm_ListaTecnico.Dblcb_Vendedor.Enabled := True;
  End;

end;

procedure TSeaFurnitureOS.CriarVariaveis;
begin
  inherited;
  Furniture := TControllerFurnitureOS.Create(self);
end;

procedure TSeaFurnitureOS.DBG_PesquisaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Lc_cor : TColor;
begin
  if ds_search.DataSet.FieldByName('SIT_COLOR').AsString <> '' then
  Begin
    Lc_cor := StringToColor(ds_search.DataSet.FieldByName('SIT_COLOR').AsString);
    if Lc_cor = clBlack then
    Begin
      Dbg_Pesquisa.Canvas.Font.Color := clCream;
      Dbg_Pesquisa.Canvas.Font.Color := clBlack;
    End
    else
    Begin
      Dbg_Pesquisa.Canvas.Font.Color := clWhite;
      Dbg_Pesquisa.Canvas.Brush.Color := Lc_cor;
    End;
  End;
  Dbg_Pesquisa.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TSeaFurnitureOS.execShorCutKeyF9;
begin
  if cds_searchPED_FATURADO.AsString = 'N' then
    OpenOrder
  else
    OpenInvoice;
end;

procedure TSeaFurnitureOS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = []) then
  begin
    case Key of
      VK_F2:execShorCutKeyF2;
      VK_F7: execShorCutKeyF7;
      VK_F8: execShorCutKeyF8;
      VK_F9: execShorCutKeyF9;
      VK_Escape: execShorCutEsc;
    end;
  end;
end;

procedure TSeaFurnitureOS.GetView;
Var
  LcForm : TTasFurnitureOS;
begin
  try
    LcForm := TTasFurnitureOS.Create(nil);
    LcForm.CodigoRegistro := cds_searchPED_CODIGO.AsInteger;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TSeaFurnitureOS.GroupBySql;
begin
  inherited;

end;

procedure TSeaFurnitureOS.ImagemBotao;
begin
  CarregaImagemBotao(SB_Cadastrar,'CADASTRAR');
  CarregaImagemBotao(SB_Buscar,'BUSCAR');
  //SB_Visualizar.Glyph.Assign(Fc_CarregaImagemBotao('VISUALIZAR'));Fixo
  SB_Visualizar.Caption:= 'Visualizar - F8';
  CarregaImagemBotao(Sb_Sair_0,'SAIR');
  CarregaImagemBotao(Sb_PEdido,'PEDIDO');
end;

procedure TSeaFurnitureOS.IniciaVariaveis;
begin
  inherited;
  Fm_ListaEmpresas.Pc_AtivaEmpresa(1);
  Fm_ListaVendedores.ListaVendedor;
  Fm_ListaSituacao.Modulo := 9;
  Fm_ListaSituacao.Listar;
  Fm_ListaTecnico.ListaColaborador;
  E_Data_Ini.DateTime := Date;
  E_Data_Fim.DateTime := Date;

  It_Supervisor := Fc_VerificaPermissao('Fr_Nota_Fiscal','Notas Fiscais de Venda','SUPERVISOR',GB_Cd_Usuario,'N');
  if It_Supervisor then
  BEgin
    Lb_valor_produtos.Visible := True;
    E_valor_produtos.Visible := True;
    Lb_valor_servicos.Visible := True;
    E_valor_servicos.Visible := True;
    Lb_valor_total.Visible := True;
    E_valor_total.Visible := True;
  end
  else
  Begin
    Lb_valor_produtos.Visible := False;
    E_valor_produtos.Visible := False;
    Lb_valor_servicos.Visible := False;
    E_valor_servicos.Visible := False;
    Lb_valor_total.Visible := False;
    E_valor_total.Visible := False;
  end;

end;

procedure TSeaFurnitureOS.InnerJoinSql;
begin
  inherited;
  InnerJoinTxt := concat(
                    ' inner JOIN TB_PEDIDO pe ',
                    ' ON  (pe.PED_CODIGO = fu.tb_order_id) ',
                    ' LEFT OUTER JOIN tb_colaborador vdd ',
                    ' on (vdd.clb_codigo = pe.ped_codvdo) ',
                    ' INNER JOIN TB_EMPRESA em ',
                    ' ON  (em.EMP_CODIGO = pe.PED_CODEMP) ',
                    ' INNER JOIN TB_ENDERECO en ',
                    ' ON (en.end_codigo = pe.ped_codend) ',
                    ' INNER JOIN TB_SITUACAO si ',
                    ' ON (si.SIT_CODIGO = fu.tb_situacao_id) ',
                    '  LEFT OUTER JOIN tb_colaborador tcn ',
                    '  on (tcn.clb_codigo = fu.tb_colaborador_id) '
                );
end;

procedure TSeaFurnitureOS.OpenInvoice;
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Operações NFe','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Furniture.NotaFiscal.Registro.CodigoPedido := cds_searchPED_CODIGO.AsInteger;

    Pc_AbreTelaNotaFiscal(Furniture.NotaFiscal.getCodigoNotaByPedido,Self);
  End;

end;

procedure TSeaFurnitureOS.OpenOrder;
Var
  LcForm : TFr_Pedido_Vda;
begin
  try
    LcForm := TFr_Pedido_Vda.Create(nil);
    LcForm.Pedido.Registro.Codigo := cds_searchPED_CODIGO.AsInteger;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TSeaFurnitureOS.OrderBySql;
begin
  inherited;

end;

procedure TSeaFurnitureOS.returnRegister;
begin
end;

procedure TSeaFurnitureOS.Sb_PEdidoClick(Sender: TObject);
begin
  if validateGetViewOrder then
  Begin
    if cds_searchPED_FATURADO.AsString = 'N' then
      OpenOrder
    else
      OpenInvoice;
  End;
end;


procedure TSeaFurnitureOS.SelectSql;
begin
  inherited;
  SelectTxt := concat(
                  'SELECT DISTINCT PED_CODIGO,PED_NUMERO,PED_DATA, PED_HORA, em.emp_fantasia,END_FONE, ',
                  'END_CELULAR, SIT_DESCRICAO,SIT_COLOR, pe.ped_vl_pedido,EQUIPMENT,tb_situacao_ID, PE.PED_CODEMP, ',
                  'vdd.clb_nome Vendedor, fu.ENVIRONMENT, fu.BRAND, fu.MODEL, ped_faturado, ',
                  'fu.DT_ATTENDANCE, fu.HR_ATTENDANCE, tcn.clb_nome Tecnico ',
                  'FROM tb_furniture_os fu '
            );
end;

procedure TSeaFurnitureOS.SetParameters(Param: TSTQuery);
begin
  with Param do
  Begin
    if ChBx_Periodo.Checked then
    BEgin
      ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
      ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
    End;

    //incrementa SQL
    if E_Nr_Pedido.Text <> '' then
      ParamByName('PED_NUMERO').AsString := E_Nr_Pedido.Text;

    if E_Equipment.Text <> '' then
      ParamByName('EQUIPMENT').AsString := concat('%',E_Equipment.Text,'%');

    if E_Environment.Text <> '' then
      ParamByName('ENVIRONMENT').AsString := concat('%',E_Environment.Text,'%');

    if E_Marca.Text <> '' then
      ParamByName('BRAND').AsString := concat('%',E_Marca.Text,'%');

    if E_Modelo.Text <> '' then
      ParamByName('MODEL').AsString := concat('%',E_Modelo.Text,'%');


    if Fm_ListaEmpresas.DBLCB_Empresa.Text <> '' then
      ParamByName('PED_CODEMP').AsInteger := Fm_ListaEmpresas.DBLCB_Empresa.KeyValue;

    if Fm_ListaSituacao.DBLCB_Situacao.Text <> '' then
      ParamByName('TB_SITUACAO_ID').AsInteger := Fm_ListaSituacao.DBLCB_Situacao.KeyValue;

    if Fm_ListaVendedores.Dblcb_Vendedor.Text <> '' then
      ParamByName('PED_CODVDO').AsInteger := Fm_ListaVendedores.Dblcb_Vendedor.KeyValue;

    if Fm_ListaTecnico.Dblcb_Vendedor.Text <> '' then
      ParamByName('TB_COLABORADOR_ID').AsInteger := Fm_ListaTecnico.Dblcb_Vendedor.KeyValue;

  End;
end;

procedure TSeaFurnitureOS.setPerfil;
Var
  Lc_Menu : String;
begin
  Lc_Menu := 'SeaFurnitureOS';
  if Gb_Nivel = 1 then
  begin
    Pf_Inserir    := True;
    Pf_Alterar    := True;
    Pf_Excluir    := True;
    Pf_Visualizar := True;
  end
  else
  begin
    Pf_Inserir    := Fc_HabilitaPermissao(Lc_Menu,'INSERIR','S');
    Pf_Alterar    := Fc_HabilitaPermissao(Lc_Menu,'ALTERAR','S');
    Pf_Excluir    := Fc_HabilitaPermissao(Lc_Menu,'EXCLUIR','S');
    Pf_Visualizar := Fc_HabilitaPermissao(Lc_Menu,'VISUALIZAR','S');
  end;
  SB_Cadastrar.Enabled   :=  Pf_Inserir;
end;

procedure TSeaFurnitureOS.SetRegister;
Var
  LcForm : TFr_Pedido_Vda;
begin
  try
    LcForm := TFr_Pedido_Vda.Create(nil);
    LcForm.AbrirNovo := True;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TSeaFurnitureOS.totalizer;
Var
  Lc_Qry : TSTQuery;
  Lc_Total : Real;
begin
  Try
    Lc_Qry := Furniture.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'SELECT pr.pro_tipo, sum( (it.itf_qtde * it.itf_vl_unit) - it.itf_vl_desc) SUBTOTAL ',
                'FROM tb_furniture_os fu ',
                ' inner JOIN TB_PEDIDO pe ',
                ' ON  (pe.PED_CODIGO = fu.tb_order_id) ',
                'INNER JOIN tb_itens_nfl it ',
                'on (it.itf_codped = pe.ped_codigo) ',
                'inner join tb_produto pr ',
                'on (pr.pro_codigo = it.itf_codpro) ',
                ' LEFT OUTER JOIN tb_colaborador vdd ',
                ' on (vdd.clb_codigo = pe.ped_codvdo) ',
                ' INNER JOIN TB_EMPRESA em ',
                ' ON  (em.EMP_CODIGO = pe.PED_CODEMP) ',
                ' INNER JOIN TB_ENDERECO en ',
                ' ON (en.end_codigo = pe.ped_codend) ',
                ' INNER JOIN TB_SITUACAO si ',
                ' ON (si.SIT_CODIGO = fu.tb_situacao_id) ',
                '  LEFT OUTER JOIN tb_colaborador tcn ',
                '  on (tcn.clb_codigo = fu.tb_colaborador_id) '

      ));
      sql.Add(WhereTxt);
      sql.add('group by 1');
      SetParameters(Lc_Qry);
      Active := True;
      First;
      Lc_Total := 0;
      E_valor_produtos.Caption := '0,00';
      E_valor_servicos.Caption := '0,00';
      E_valor_total.Caption := '0,00';
      while not eof do
      Begin
        if FieldByName('PRO_TIPO').AsString = 'P' then
          E_valor_produtos.Caption := FloattoStrF(FieldByName('SUBTOTAL').AsCurrency,ffFixed,10,2);
        if FieldByName('PRO_TIPO').AsString = 'S' then
          E_valor_servicos.Caption := FloattoStrF(FieldByName('SUBTOTAL').AsCurrency,ffFixed,10,2);
        Lc_Total := Lc_Total + FieldByName('SUBTOTAL').AsCurrency;
        Next;
      End;
      E_valor_total.Caption := FloattoStrF(Lc_Total,ffFixed,10,2);

    End;
  Finally
    Furniture.FinalizaQuery(Lc_Qry);
  End;
end;

function TSeaFurnitureOS.validateGetViewOrder: Boolean;
begin
  Result := True;
  if not validateGetView then
  Begin
    Result := False;
    exit;
  end;

  if not Fc_VerificaPermissao('Fr_Pedido_Vda','Pedido de Venda','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Result := False;
    exit;
  end;
end;

procedure TSeaFurnitureOS.WhereSql;
begin
  inherited;
  WhereTxt := concat(
             'WHERE (TB_ORDER_ID IS NOT NULL)   '
              );

  if ChBx_Periodo.Checked then
    WhereTxt := concat(
                  WhereTxt,
                  ' and ( PED_DATA BETWEEN :DATAINI AND :DATAFIM ) '
                );

    //incrementa SQL
  if E_Nr_Pedido.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (PED_NUMERO =:PED_NUMERO) '
                );

    //incrementa SQL
  if E_Equipment.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (EQUIPMENT LIKE :EQUIPMENT) '
                );

  if E_Environment.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (ENVIRONMENT LIKE :ENVIRONMENT) '
                );

  if E_Marca.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  'and (BRAND  LIKE :BRAND)'
                );


  if E_Modelo.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (MODEL LIKE :MODEL)'
                );

  if Fm_ListaEmpresas.DBLCB_Empresa.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (PED_CODEMP =:PED_CODEMP) '
                );

  if Fm_ListaSituacao.DBLCB_Situacao.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (TB_SITUACAO_ID =:TB_SITUACAO_ID) '
                );

  if Fm_ListaVendedores.Dblcb_Vendedor.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (PED_CODVDO =:PED_CODVDO) '
                );
  if Fm_ListaTecnico.Dblcb_Vendedor.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (TB_COLABORADOR_ID =:TB_COLABORADOR_ID) '
                );
   if chbx_sem_tecnico.Checked then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (fu.tb_colaborador_id is null or (fu.tb_colaborador_id = 0)) '
                );

end;

end.
