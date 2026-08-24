unit Un_Fich_Fin_For;

interface

uses
      Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Grids, DBGrids, StdCtrls, Mask, DBCtrls, ExtCtrls, Db, Buttons, STQuery, Menus, Variants, ComCtrls, Un_Fm_ListaEmpresas, Un_Fm_ListaFornecedores, Un_Fm_ListaMultiEmpresa, base_frame_list;

type
  TFr_Fich_Fin_For = class(TForm)
    DBG_Pesquisa: TDBGrid;
    Qr_Ficha: TSTQuery;
    PopupMenu1: TPopupMenu;
    DetalhesdoPediso1: TMenuItem;
    Qr_Mostra: TSTQuery;
    Ds_Mostra: TDataSource;
    EditaObservao1: TMenuItem;
    GroupBox1: TGroupBox;
    Sb_Sair_0: TSpeedButton;
    SB_Buscar: TSpeedButton;
    Sb_Recibo: TSpeedButton;
    RG_Situacao: TRadioGroup;
    Rg_Data: TRadioGroup;
    Panel1: TPanel;
    pnl_Totais: TPanel;
    Lb_Vl_Vencer: TLabel;
    Lb_Vl_Vencida: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Lb_Vl_Devedor: TLabel;
    Label24: TLabel;
    Label2: TLabel;
    Lb_Vl_Credor: TLabel;
    Label10: TLabel;
    Lb_Vl_Saldo: TLabel;
    Pnl_total_Especifico: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Lb_Vl_Prazo: TLabel;
    Lb_Vl_Credito: TLabel;
    Lb_Vl_Ult_Cpa: TLabel;
    Lb_Vl_Maior_Cpa: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Lb_Dt_Ult_Cpa: TLabel;
    Lb_Dt_Maior_Cpa: TLabel;
    Label1: TLabel;
    Lb_Dt_Cadastro: TLabel;
    Fm_LME: TFm_ListaMultiEmpresa;
    Label25: TLabel;
    Lb_Vl_Pago: TLabel;
    Label3: TLabel;
    Lb_Vl_Total: TLabel;
    Label26: TLabel;
    Lb_Med_Atraso: TLabel;
    pnl_bottom: TPanel;
    Panel2: TPanel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Fm_ListaFornecedores: TFm_ListaFornecedores;
    procedure BtnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_ReciboClick(Sender: TObject);
    procedure DBG_PesquisaDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure EditaObservao1Click(Sender: TObject);
    procedure DBG_PesquisaTitleClick(Column: TColumn);
    procedure Rg_DataClick(Sender: TObject);
    procedure RG_SituacaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure E_Busca_Cd_EmpresaChange(Sender: TObject);
  private
  { Private declarations }

    It_Recibo:Boolean;
    It_Visualizar:Boolean;
    It_VL_Vencer: Currency;
    It_VL_Vencida: Currency;
    It_VL_Credito: Currency;
    It_VL_Pagas: Currency;
    It_VL_Todas: Currency;
    It_VL_CPA_PRZ: Currency;
    It_Dt_Ultim_CPA : TDate;
    It_Dt_Maior_CPA : TDate;
    It_VL_Ultim_CPA: Currency;
    It_VL_Maior_CPA: Currency;
    It_Dias_Atrazo : Integer;
    function Fc_Verifica_selecionado:Boolean;

  public
    { Public declarations }
    It_Cd_Fornece : Integer;
    It_Nm_Fornece : String;

    procedure PC_Buscar;
    procedure Pc_Analise;
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariveis;
    procedure Pc_ImagemBotao;
    procedure Pc_PermissaoBotao(Pc_Menu: string);    
  end;

var
  Fr_Fich_Fin_For: TFr_Fich_Fin_For;

implementation

uses     Un_DM, UN_MSG, UN_Sistema, reg_receipt, UN_Pedido_Cpa, Un_Fin_Edita, Un_Regra_Negocio, UN_Principal, env, Un_Fornecedor, RN_Fornecedor, RN_Empresa;
{$R *.DFM}

procedure TFr_Fich_Fin_For.BtnSairClick(Sender: TObject);
begin
close;
end;

function TFr_Fich_Fin_For.Fc_Verifica_selecionado: Boolean;
begin
  Result:= True;
  if not Qr_Mostra.Active then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Não há item na lista para emitir recibo'+EOLN+
                   'Verifique'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;

  if Qr_Mostra.RecordCount = 0 then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Não há item na lista para emitir recibo'+EOLN+
                   'Verifique'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;

  if ( Fm_ListaFornecedores.DBLCB_Empresa.Text = '' ) then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Para garantir a emissãoo do recibo por favor seleciona um fornecedor.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpErro);
    Result:= False;
    exit;
  End;
end;

procedure TFr_Fich_Fin_For.PC_Buscar;
Var
  SqlTxt : String;
  Lc_Fornece : Boolean;
begin
  Screen.Cursor:=crHourGlass;
  sqltxt:= '';
  Qr_Ficha.Active := False;
  Qr_Ficha.SQL.Clear;
  Qr_Mostra.Active := False;
  Qr_Mostra.SQL.Clear;

  sqltxt:='SELECT                                                                        '+
          '  NFL_CODEMP,                                                                 '+
          '  NFL_DT_EMISSAO,                                                             '+
          '  NFL_NUMERO,                                                                 '+
          '  NFL_VL_TL_NOTA,                                                             '+
          '  PED_CODVDO,                                                                 '+
          '  FIN_CODIGO,                                                                 '+
          '  FIN_DT_VENCIMENTO,                                                          '+
          '  FIN_VL_PARCELA,                                                             '+
          '  FIN_VL_PAGO,                                                                '+
          '  FIN_DT_PAGTO,                                                               '+
          '  FIN_NR_PARCELA,                                                             '+
          '  FIN_NUMERO,                                                                 '+
          '  (FIN_DT_PAGTO - FIN_DT_VENCIMENTO)                                          '+
          '  FIN_DIAS_ATRASO,                                                            '+
          '  FIN_PRAZO,                                                                  '+
          '  FPT_DESCRICAO,                                                              '+
          '  FIN_BAIXA,                                                                  '+
          '  PED_NUMERO,                                                                 '+
          '  EMP_NOME,                                                                   '+
          '  EMP_DT_CADASTRO,                                                            '+
          '  EMP_VL_CRED,                                                                '+
          '  FIN_OPERACAO                                                                '+
          'FROM TB_FINANCEIRO Tb_financeiro                                              '+
          '   INNER JOIN TB_NOTA_FISCAL Tb_nota_fiscal                                   '+
          '   ON  (Tb_financeiro.FIN_CODNFL = Tb_nota_fiscal.NFL_CODIGO)                 '+
          '   INNER JOIN TB_EMPRESA tb_empresa                                           '+
          '   ON  (Tb_financeiro.FIN_CODEMP = Tb_empresa.EMP_CODIGO)                     '+
          '   INNER  JOIN TB_FORMAPAGTO tb_formapagto                                '+
          '   ON  (tb_formapagto.FPT_CODIGO = Tb_financeiro.FIN_CODFPG)                  '+
          '   LEFT OUTER JOIN TB_PEDIDO Tb_pedido                                        '+
          '   ON  (Tb_pedido.PED_CODIGO = Tb_nota_fiscal.NFL_CODPED)                     '+
          'WHERE ((FIN_TIPO = ''PA'')OR (FIN_TIPO = ''PM''))  ';

  if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
    SqlTxt := SqlTxt + ' AND (FIN_CODMHA =:FIN_CODMHA) ' ;


  if (Fm_ListaFornecedores.E_Cd_Empresa.Text = '') then Lc_Fornece := False else Lc_Fornece := True;
  if ChBx_Periodo.Checked then
  Begin
    IF Rg_Data.ItemIndex = 0 then
      SqlTxt := SqlTxt + 'AND (FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM)'
    else
      SqlTxt := SqlTxt + 'AND (FIN_DT_PAGTO BETWEEN :DATAINI AND :DATAFIM)';
  end;

  IF Lc_Fornece then SqlTxt := SqlTxt + 'AND  (FIN_CODEMP =:FIN_CODEMP) ';
  Case RG_Situacao.ItemIndex of
    0:Begin
      SqlTxt := SqlTxt + 'AND (FIN_DT_VENCIMENTO >= :FIN_DT_VENCIMENTO) AND (FIN_BAIXA = ''N'')';
      end;
    1:Begin
      SqlTxt := SqlTxt + 'AND (FIN_DT_VENCIMENTO < :FIN_DT_VENCIMENTO) AND (FIN_BAIXA = ''N'')';
      end;
    2:Begin
      SqlTxt := SqlTxt + 'AND (FIN_BAIXA = ''S'')';
      end;
  end;

  IF Rg_Data.ItemIndex = 0 THEN
    Begin
    Qr_Ficha.sql.add(sqltxt+ ' ORDER BY FIN_DT_VENCIMENTO ');
    Qr_Mostra.sql.add(sqltxt+ '  ORDER BY FIN_DT_VENCIMENTO ');
    end
  else
    Begin
    Qr_Ficha.sql.add(sqltxt+ ' ORDER BY FIN_DT_PAGTO ');
    Qr_Mostra.sql.add(sqltxt+ ' ORDER BY FIN_DT_PAGTO ');
    end;

  if ChBx_Periodo.Checked then
  Begin
    Qr_Ficha.ParamByName('DATAINI').AsDateTime :=E_Data_Ini.Date;
    Qr_Ficha.ParamByName('DATAFIM').AsDateTime := E_Data_Fim.Date;

    Qr_Mostra.ParamByName('DATAINI').AsDateTime := E_Data_Ini.Date;
    Qr_Mostra.ParamByName('DATAFIM').AsDateTime := E_Data_Fim.Date;
  end;

  if Lc_Fornece then Qr_Ficha.ParamByName('FIN_CODEMP').AsString := Fm_ListaFornecedores.E_Cd_Empresa.Text;
  IF RG_Situacao.ItemIndex < 2 then Qr_Ficha.ParamByName('FIN_DT_VENCIMENTO').AsDateTime := Date;
  if Lc_Fornece then Qr_Mostra.ParamByName('FIN_CODEMP').AsString := Fm_ListaFornecedores.E_Cd_Empresa.Text;
  IF RG_Situacao.ItemIndex < 2 then Qr_Mostra.ParamByName('FIN_DT_VENCIMENTO').AsDateTime := Date;
  if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
  Begin
    Qr_Mostra.ParamByName('FIN_CODMHA').AsInteger := Fm_LME.Dblcb_Lista.KeyValue;
    Qr_Ficha.ParamByName('FIN_CODMHA').AsInteger := Fm_LME.Dblcb_Lista.KeyValue;
  End;

  Qr_Ficha.Active:=True;
  Qr_Ficha.FetchAll;
  Qr_Ficha.First;
  Qr_Mostra.Active:=True;
  Qr_Mostra.First;
end;

procedure TFr_Fich_Fin_For.PC_Analise;
Var
  Lc_Contador : Integer;
Begin
  // Zerando as Variaveis
  It_VL_Vencer := 0;
  It_VL_Vencida := 0;
  It_VL_Credito := 0;
  It_VL_Pagas := 0;
  It_VL_Todas := 0;
  It_VL_CPA_PRZ := 0;
  It_Dt_Ultim_CPA := Date;
  It_Dt_Maior_CPA := Date;
  It_VL_Ultim_CPA := 0;
  It_VL_Maior_CPA := 0;
  It_Dias_Atrazo := 0;

  //Primeiros Valores
  It_Dt_Ultim_CPA := StrToDateDef(Qr_Ficha.FieldByName('NFL_DT_EMISSAO').AsString,Date);
  It_Dt_Maior_CPA := StrToDateDef(Qr_Ficha.FieldByName('NFL_DT_EMISSAO').AsString,Date);
  It_VL_Ultim_CPA := Qr_Ficha.FieldByName('NFL_VL_TL_NOTA').AsCurrency;
  It_VL_Maior_CPA := Qr_Ficha.FieldByName('NFL_VL_TL_NOTA').AsCurrency;

  while not Qr_Ficha.eof do
  begin
    //Media Atraso
    It_Dias_Atrazo := It_Dias_Atrazo + Qr_Ficha.FieldByName('FIN_DIAS_ATRASO').asinteger;
    Lc_Contador := Lc_Contador + 1;

    //Maior Vendas
    if (It_VL_Maior_CPA < Qr_Ficha.FieldByName('NFL_VL_TL_NOTA').AsCurrency) then
    begin
      It_VL_Maior_CPA := Qr_Ficha.FieldByName('NFL_VL_TL_NOTA').AsCurrency;
      It_Dt_Maior_CPA := Qr_Ficha.FieldByName('NFL_DT_EMISSAO').asDateTime;
    end;

      //Ultima Vendas
    if (It_Dt_Ultim_CPA < Qr_Ficha.FieldByName('NFL_DT_EMISSAO').asDateTime) then
    begin
      It_VL_Ultim_CPA := Qr_Ficha.FieldByName('NFL_VL_TL_NOTA').AsCurrency;
      It_Dt_Ultim_CPA := Qr_Ficha.FieldByName('NFL_DT_EMISSAO').asDateTime;
    end;

    //Duplicatas a Prazo
    if (Qr_Ficha.FieldByName('FIN_PRAZO').AsString <> '000 - VISTA') or (Qr_Ficha.FieldByName('FIN_PRAZO').AsString <> '001 - 000')  and  (Qr_Ficha.FieldByName('FIN_OPERACAO').AsString ='D') then
    Begin
      It_VL_CPA_PRZ := It_VL_CPA_PRZ + Qr_Ficha.FieldByName('FIN_VL_PARCELA').AsCurrency;
    end;

    //Duplicatas Quitadas
    if (Qr_Ficha.FieldByName('FIN_BAIXA').AsString='S')  and  (Qr_Ficha.FieldByName('FIN_OPERACAO').AsString ='D') THEN
    Begin
      It_VL_Pagas := It_VL_Pagas + Qr_Ficha.FieldByName('FIN_VL_PAGO').AsCurrency;
    end;

     //Duplicatas a Vencer
    if (Qr_Ficha.FieldByName('FIN_DT_VENCIMENTO').AsDateTime >= Date) and (Qr_Ficha.FieldByName('FIN_BAIXA').AsString = 'N') and  (Qr_Ficha.FieldByName('FIN_OPERACAO').AsString ='D') then
    Begin
      It_VL_Vencer := It_VL_Vencer + Qr_Ficha.FieldByName('FIN_VL_PARCELA').AsCurrency;
    end;

    //Duplicatas a Vencidas
    if (Qr_Ficha.FieldByName('FIN_DT_VENCIMENTO').asDateTime < Date) and (Qr_Ficha.FieldByName('FIN_BAIXA').AsString='N') and  (Qr_Ficha.FieldByName('FIN_OPERACAO').AsString ='D') then
    Begin
      It_VL_Vencida := It_VL_Vencida + Qr_Ficha.FieldByName('FIN_VL_PARCELA').AsCurrency;
    end;
    //Todas
    if (Qr_Ficha.FieldByName('FIN_OPERACAO').AsString ='D')then
    Begin
      It_VL_Todas := It_VL_Todas + Qr_Ficha.FieldByName('FIN_VL_PARCELA').AsCurrency;
    end;

    //Duplicatas a credito
    if (Qr_Ficha.FieldByName('FIN_BAIXA').AsString='N')   and  (Qr_Ficha.FieldByName('FIN_OPERACAO').AsString ='C')then
    Begin
      It_VL_Credito := It_VL_Credito + Qr_Ficha.FieldByName('FIN_VL_PARCELA').AsCurrency;
    end;

    Qr_Ficha.Next;
  end;

  //Mostra Campos
  Lb_Vl_Credito.caption   := FloatToStrF(Qr_Ficha.FieldByName('EMP_VL_CRED').AsCurrency,ffNumber,18,2);
  Lb_Vl_Prazo.Caption     := FloatToStrF(It_VL_CPA_PRZ,ffNumber,18,2);
  Lb_Vl_Pago.Caption      := FloatToStrF(It_VL_Pagas,ffNumber,18,2);
  Lb_Vl_Vencer.Caption    := FloatToStrF(It_VL_Vencer,ffNumber,18,2);
  Lb_Vl_Vencida.Caption   := FloatToStrF(It_VL_Vencida,ffNumber,18,2);
  Lb_Vl_Total.Caption      := FloatToStrF(It_VL_Todas,ffNumber,18,2);

  Lb_Vl_Devedor.Caption   := FloatToStrF((It_VL_Vencer + It_VL_Vencida),ffNumber,18,2);
  Lb_Vl_Credor.Caption   := FloatToStrF((It_VL_Credito),ffNumber,18,2);
  Lb_Vl_Saldo.Caption   := FloatToStrF((It_VL_Vencer + It_VL_Vencida - It_VL_Credito),ffNumber,18,2);

  Lb_Dt_Ult_Cpa.Caption   := DateToStr(It_Dt_Ultim_CPA);
  Lb_Vl_Ult_Cpa.Caption   := FloatToStrF(It_VL_Ultim_CPA,ffNumber,18,2);
  Lb_Dt_Maior_Cpa.Caption := DateToStr(It_Dt_Maior_CPA);
  Lb_Vl_Maior_Cpa.Caption := FloatToStrF(It_VL_Maior_CPA,ffNumber,18,2);
  if Lc_Contador>0 then
    Lb_Med_Atraso.Caption   := FloatToStrF((It_Dias_Atrazo /Lc_Contador),ffNumber,18,0)
  else
    Lb_Med_Atraso.Caption   := FloatToStrF((It_Dias_Atrazo /1),ffNumber,18,0);
  Lb_Dt_Cadastro.Caption  := Qr_Ficha.FieldByName('EMP_DT_CADASTRO').AsString;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Fich_Fin_For.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
      case Key of
      VK_F6  : if Sb_Recibo.Enabled then Sb_ReciboClick(Sender);
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
    end;

end;

procedure TFr_Fich_Fin_For.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;


procedure TFr_Fich_Fin_For.SB_BuscarClick(Sender: TObject);
begin
  Pnl_total_Especifico.Visible := (trim(Fm_ListaFornecedores.E_Cd_Empresa.Text) <> '');
  Fm_ListaFornecedores.E_Cd_EmpresaExit(Self);
  PC_Buscar;
  Pc_Analise;
end;

procedure TFr_Fich_Fin_For.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Fich_Fin_For.Sb_ReciboClick(Sender: TObject);
Var
  Lc_Form : TRegReceipt;
begin
  if Fc_Verifica_selecionado then
  Begin
    TRy
      Pc_AtivaEstabelecimento;
      Lc_Form := TRegReceipt.create(nil);
      Lc_Form.Recibo.Registro.VAlor       := Qr_Mostra.FieldByname('FIN_VL_PARCELA').AsCurrency;
      Lc_Form.Recibo.Registro.Emitente    := DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString;
      Lc_Form.Recibo.Registro.Sacado      := Fm_ListaFornecedores.DBLCB_Empresa.Text;
      Lc_Form.Recibo.Registro.Referencia  := 'Pagamento do pedido ' + Qr_Mostra.FieldByname('FIN_NUMERO').AsString;
      Lc_Form.Recibo.Registro.Data        := Date;
      Lc_Form.autofill      := True;
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
      SB_BuscarClick(SELF);
    End;
  End;
end;

procedure TFr_Fich_Fin_For.DBG_PesquisaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if Ds_Mostra.DataSet.FieldByName('FIN_OPERACAO').AsString = 'C' then
    DBG_Pesquisa.Canvas.Font.Color := clGreen
  else
  if Ds_Mostra.DataSet.FieldByName('FIN_VL_PAGO').AsCurrency = 0 then
    DBG_Pesquisa.Canvas.Font.Color := clRed;
  DBG_Pesquisa.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TFr_Fich_Fin_For.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

{-------------------------------------------------------------------------------
Nome : Felipe Correa
Data : 15/09/2010
Alte : Incluso o código para chamada da tela de edição de Dados.
-------------------------------------------------------------------------------}
procedure TFr_Fich_Fin_For.EditaObservao1Click(Sender: TObject);
var
  Lc_fin_codigo : Integer;
begin
  // Verifica se existe código na tela
  Lc_fin_codigo := Qr_Mostra.FieldByName('FIN_CODIGO').AsInteger;

  // Verifica se a variável está preenchida
  if Lc_fin_codigo = 0 then
    exit;
  if not Assigned(Fr_Fin_Edita) then
    Application.CreateForm(TFr_Fin_Edita, Fr_Fin_Edita);
  Fr_Fin_Edita.Financeiro.Registro.Codigo := Lc_fin_codigo;
  Fr_Fin_Edita.Enabled := True;
  Fr_Fin_Edita.ShowModal;
  // Fim verifica se existe código na tela
end;
procedure TFr_Fich_Fin_For.E_Busca_Cd_EmpresaChange(Sender: TObject);
begin

end;

{-------------------------------------------------------------------------------
Nome : Felipe Correa
Data : 17/09/2010
Alte : Efetua a pesquisa quando for digitado no campo Código Fornecedor.
-------------------------------------------------------------------------------}
procedure TFr_Fich_Fin_For.DBG_PesquisaTitleClick(Column: TColumn);
begin
 Pc_Pintar_Grid_Ordenar(DBG_Pesquisa, Column);
end;

{Camila - Filtrar por data de pagamento ou vencimento - 27/01/2010}
procedure TFr_Fich_Fin_For.Rg_DataClick(Sender: TObject);
begin
  if Rg_Data.ItemIndex = 1 then
    RG_Situacao.ItemIndex := 2
  else
    RG_Situacao.ItemIndex := 0;
 end;
procedure TFr_Fich_Fin_For.RG_SituacaoClick(Sender: TObject);
begin
 SB_BuscarClick(Self);
end;

procedure TFr_Fich_Fin_For.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
  begin
    It_Recibo     := True;
    It_Visualizar :=true;
  end
  else
  begin
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    if not It_Visualizar then exit;
    It_Recibo     := Fc_HabilitaPermissao(Pc_Menu,'RECIBO','S');
  end;
  Sb_Recibo.Enabled:=It_Recibo;
end;

procedure TFr_Fich_Fin_For.Pc_FormataTela;
Begin
  Pc_PermissaoBotao('Ficha Financeira Fornecedor');
end;

procedure TFr_Fich_Fin_For.Pc_IniciaVariveis;
Begin
  Fm_LME.Listar('EMP_NOME');
  Fm_LME.HabilitarMultiEmpresa;
  Qr_Ficha.Close;
  Qr_Mostra.Close;
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
  ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
  Fm_ListaFornecedores.ListaFornecedores('EMP_NOME');
end;

procedure TFr_Fich_Fin_For.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_ImagemBotao;
  Pc_IniciaVariveis;
end;

procedure TFr_Fich_Fin_For.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Geral;
    Sb_Recibo.Glyph.Assign(Fc_CarregaImagemBotao('FATURAR'));
    SB_Buscar.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

end.
