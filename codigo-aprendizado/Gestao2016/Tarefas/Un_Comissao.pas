Unit Un_Comissao;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, Buttons, StdCtrls, DBCtrls, Mask, System.Math, Grids, DBGrids, ExtCtrls, ComCtrls, QEdit_Setes, Un_Fm_ListaColaboradores, STDataSet, ControllerComissao, Vcl.Menus;
                                                                           
type
   TFr_Comissao = class(TForm)
      PG_Comissao: TPageControl;
      TabSheet1: TTabSheet;
      Panel1: TPanel;
      Label4: TLabel;
    DBG_Comissao: TDBGrid;
      CB_Status: TComboBox;
      Panel4: TPanel;
      SB_Pagar: TSpeedButton;
      SB_Filtro: TSpeedButton;
      Sb_Sair_0: TSpeedButton;
      Qr_Comissao: TSTQuery;
      Qr_Pagar: TSTQuery;
      Ds_Qr_Comissao: TDataSource;
      Sb_Alterar: TSpeedButton;
      E_Data_Ini: TDateTimePicker;
      E_Data_Fim: TDateTimePicker;
      ChBx_Periodo: TCheckBox;
    TabSheet2: TTabSheet;
    Panel3: TPanel;
    Sb_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Label19: TLabel;
    Label25: TLabel;
    Label21: TLabel;
    Label3: TLabel;
    E_VL_Venda: TDBEdit;
    E_VL_Comissao: TEdit_Setes;
    E_AQ_COM: TEdit_Setes;
    E_Dt_Pagto: TDateTimePicker;
    Chbx_DataPagto: TCheckBox;
    TabSheet3: TTabSheet;
    Panel5: TPanel;
    Label2: TLabel;
    Label6: TLabel;
    E_Pedido: TDBEdit;
    Label10: TLabel;
    E_Cliente: TDBEdit;
    SB_Confirmar: TSpeedButton;
    SB_Sair: TSpeedButton;
    Label1: TLabel;
    E_PagaColaborador: TDBEdit;
    Panel6: TPanel;
    Label5: TLabel;
    Label15: TLabel;
    E_Vl_Vendas: TLabel;
    E_Vl_Com_Pagar: TLabel;
    E_Dt_Baixa: TDateTimePicker;
    Label8: TLabel;
    Label13: TLabel;
    CB_Mes: TComboBox;
    Chbx_Recibo: TCheckBox;
    Label16: TLabel;
    E_Nr_Vias: TEdit_Setes;
    E_Busca_Pedido: TEdit;
    Label17: TLabel;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    Panel2: TPanel;
    Grb_Faturamento: TGroupBox;
    Lb_Faturamento: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    E_Vl_Recebido: TEdit_Setes;
    E_Vl_Devolvido: TEdit_Setes;
    E_Sd_P_Comissao: TEdit_Setes;
    Grb_Comissao: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    E_Vl_Pago: TEdit_Setes;
    E_VL_Pagar: TEdit_Setes;
    E_Sd_Comissao: TEdit_Setes;
    E_Dt_Venda: TDateTimePicker;
    Fm_ListaEditColaborador: TFm_ListaColaboradores;
    Fm_ListaColaborador: TFm_ListaColaboradores;
    PopupMenu1: TPopupMenu;
    Corrigirduplicados1: TMenuItem;
      procedure SB_FiltroClick(Sender: TObject);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure FormCreate(Sender: TObject);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure E_VL_ComissaoExit(Sender: TObject);
      procedure E_Aq_ComExit(Sender: TObject);
      procedure E_Aq_ComChange(Sender: TObject);
      procedure ChBx_PeriodoClick(Sender: TObject);
      procedure Sb_GravarClick(Sender: TObject);
      procedure SB_CancelarClick(Sender: TObject);
      procedure Sb_AlterarClick(Sender: TObject);
    procedure DBG_ComissaoDblClick(Sender: TObject);
    procedure SB_SairClick(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure Chbx_ReciboClick(Sender: TObject);
    procedure CB_StatusChange(Sender: TObject);
    procedure Chbx_DataPagtoClick(Sender: TObject);
    procedure DBG_ComissaoTitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure chbx_EmpresasClick(Sender: TObject);
    procedure SB_PagarClick(Sender: TObject);
    procedure Corrigirduplicados1Click(Sender: TObject);
   private
    Comissao : TControllerComissao;
    pfMenu : String;

      It_VL_Vendas: Currency;
      It_VL_Pago: Currency;
      It_VL_Pagar: Currency;
      It_VL_Comissao: Currency;
      it_Up_Comissao: Boolean;
      It_Inserir: Boolean;
      It_Alterar: Boolean;
      It_Visualizar: Boolean;
      It_Pagar: Boolean;
      procedure CriarVariaveis;
      procedure IniciaVariaveis;
      procedure setPerfil;
      procedure AtivaTabelas;
      procedure FormataTela;
      procedure ImagemBotao;
      function ValidaCorrigeComissaoDuplicada :boolean;
      procedure CorrigeComissaoDuplicada;

   public
    { Public declarations }
      It_CodMvf: Integer;
      It_PLC_COMISSAO: Integer;
      It_Busca: Integer;
      MouseDownSpot: TPoint;
      Capturing: bool;

      procedure Pc_LimpaCampos;
      procedure Pc_Buscar;
      procedure Pc_PagarComissao;
      procedure Pc_LancaFolha;
      function Fc_ValidaDados(): Boolean;
      procedure Pc_totalizar_Comissao;
      procedure Pc_totalizar_Faturamento;
      procedure Pc_totalizar_Recebimento;

   end;

var
   Fr_Comissao: TFr_Comissao;

implementation

uses     Un_Lanca_Folha, Un_DM, UN_MSG, UN_Sistema, un_Padrao, reg_receipt, Un_Funcoes, Un_Regra_Negocio, UN_Principal, env, ControllerBase, UN_TabelasEmListas;
{$R *.dfm}




procedure TFr_Comissao.Pc_LimpaCampos;
begin
  E_Vl_Recebido.Text := '0,00';
  E_Vl_Devolvido.Text := '0,00';
  E_Sd_P_Comissao.Text := '0,00';
  E_Vl_Pago.Text := '0,00';
  E_VL_Pagar.Text := '0,00';
  E_VL_Comissao.Text := '0,00';
end;

function TFr_Comissao.Fc_ValidaDados(): Boolean;
Begin
  Result := True;
  if (Fm_ListaColaborador.DBLCB_Vendedor.Text = '')  then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Favor Informe o Nome do Vendedor.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;

  if not ChBx_Periodo.Checked then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por favor informe um intervalo de datas.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;

  if (Qr_Comissao.RecordCount =0)  then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Não há valores de Comissões é pagar.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;
end;

procedure TFr_Comissao.Pc_totalizar_Comissao;
Var
  Lc_SqlTxt : String;
  Lc_Vendedor: boolean;
  Lc_Pedido: boolean;
  Lc_Vl_Pago  : Real;
  Lc_Vl_Pagar : Real;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT COM_VL_COM, COM_DT_PAGTO,COM_TIPO ' +
                    'FROM TB_COMISSAO Tb_comissao ' +
                    '    INNER JOIN TB_PEDIDO Tb_pedido ' +
                    '    ON  (Tb_pedido.PED_CODIGO = Tb_comissao.COM_CODPED) ' +
                    '    INNER JOIN TB_COLABORADOR Tb_Colaborador ' +
                    '    ON  (Tb_Colaborador.CLB_CODIGO = Tb_comissao.COM_CODVDO) ' +
                    'WHERE (COM_CODMHA =:COM_CODMHA) ';

      if trim(Fm_ListaColaborador.DBLCB_Vendedor.Text) = '' then Lc_Vendedor := False else Lc_Vendedor := True;
      if E_Busca_Pedido.Text = '' then Lc_Pedido := False else Lc_Pedido := True;

      if ChBx_Periodo.Checked then
        Lc_SqlTxt := Lc_SqlTxt + 'AND COM_DT_VENDA BETWEEN :DATAINICIO AND :DATAFIM ';

      if Lc_Vendedor then
        Lc_SqlTxt := Lc_SqlTxt + 'AND (COM_CODVDO =:COM_CODVDO) ';
      if Lc_Pedido then
        Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_NUMERO =:PED_NUMERO) ';

      if CB_Status.ItemIndex = 0 then
        Lc_SqlTxt := Lc_SqlTxt + 'AND (COM_DT_PAGTO IS NOT NULL) ';

      if CB_Status.ItemIndex = 1 then
        Lc_SqlTxt := Lc_SqlTxt + 'AND (COM_DT_PAGTO IS NULL) ';

      SQL.Add(Lc_SqlTxt);
      if ChBx_Periodo.Checked then
      begin
        ParamByName('DATAINICIO').AsDate := E_Data_Ini.date;
        ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
      end;
      if Lc_Vendedor then
        ParamByName('COM_CODVDO').AsInteger := Fm_ListaColaborador.DBLCB_Vendedor.KeyValue;

      if Lc_Pedido then
        ParamByName('PED_NUMERO').AsString := E_Busca_Pedido.Text;

      ParamByName('COM_CODMHA').AsInteger := Gb_CodMha;
      Active := True;
      FetchAll;
      First;
      Lc_Vl_Pago := 0;
      Lc_Vl_Pagar := 0;
      while not Eof do
        Begin
        if (FieldByName('COM_DT_PAGTO').AsString) = '' then
          Lc_Vl_Pagar := Lc_Vl_Pagar + FieldByName('COM_VL_COM').AsCurrency
        else
          Lc_Vl_Pago := Lc_Vl_Pago + FieldByName('COM_VL_COM').AsCurrency;
        Next;
        end;
      E_Vl_Pago.Text := FloatToStrF(Lc_Vl_Pago,ffNumber,10,2);
      E_VL_Pagar.Text := FloatToStrF(Lc_Vl_Pagar,ffNumber,10,2);
      E_Sd_Comissao.Text := FloatToStrF(Lc_Vl_Pagar - Lc_Vl_Pago,ffNumber,10,2);
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Comissao.Pc_totalizar_Faturamento;
Var
  Lc_SqlTxt : String;
  Lc_Vendedor: boolean;
  Lc_Pedido: boolean;
  Lc_Compara_Esq : String;
  Lc_Compara_Dir : String;
  Lc_Vl_Devolvido : Real;
  Lc_Vl_Faturado : Real;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT COM_CODPED, COM_VL_DOC, COM_DT_PAGTO,COM_TIPO ' +
                    'FROM TB_COMISSAO Tb_comissao ' +
                    '    INNER JOIN TB_EMPRESA Tb_empresa ' +
                    '    ON  (Tb_empresa.EMP_CODIGO = Tb_comissao.COM_CODEMP) ' +
                    '    INNER JOIN TB_COLABORADOR Tb_Colaborador ' +
                    '    ON  (Tb_Colaborador.CLB_CODIGO = Tb_comissao.COM_CODVDO) ' +
                    '    INNER JOIN TB_PEDIDO Tb_pedido ' +
                    '    ON  (Tb_pedido.PED_CODIGO = Tb_comissao.COM_CODPED) ' +
                    'WHERE (COM_CODMHA =:COM_CODMHA) ';

      if trim(Fm_ListaColaborador.DBLCB_Vendedor.Text) = '' then Lc_Vendedor := False else Lc_Vendedor := True;
      if E_Busca_Pedido.Text = '' then Lc_Pedido := False else Lc_Pedido := True;

      if ChBx_Periodo.Checked then
        Lc_SqlTxt := Lc_SqlTxt + 'AND COM_DT_VENDA BETWEEN :DATAINICIO AND :DATAFIM ';

      if Lc_Vendedor then
        Lc_SqlTxt := Lc_SqlTxt + 'AND (COM_CODVDO =:COM_CODVDO) ';

      if Lc_Pedido then
        Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_NUMERO =:PED_NUMERO) ';

      if CB_Status.ItemIndex = 0 then
        Lc_SqlTxt := Lc_SqlTxt + 'AND (COM_DT_PAGTO IS NOT NULL) ';
      if CB_Status.ItemIndex = 1 then
        Lc_SqlTxt := Lc_SqlTxt + 'AND (COM_DT_PAGTO IS NULL) ';

      SQL.Add(Lc_SqlTxt);
      if ChBx_Periodo.Checked then
      begin
        ParamByName('DATAINICIO').AsDate := E_Data_Ini.date;
        ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
      end;
      if Lc_Vendedor then
        ParamByName('COM_CODVDO').AsInteger := Fm_ListaColaborador.DBLCB_Vendedor.KeyValue;

      if Lc_Pedido then
        ParamByName('PED_NUMERO').AsString := E_Busca_Pedido.Text;

      ParamByName('COM_CODMHA').AsInteger := Gb_CodMha;
      Active := True;
      FetchAll;
      First;
      Lc_Compara_Esq := '';
      Lc_Compara_Dir := '';

      Lc_Vl_Faturado := 0;
      Lc_Vl_Devolvido := 0;
      while not Eof do
      Begin
        Lc_Compara_Dir := IntToStr(FieldByName('COM_CODPED').AsInteger) +
                                   FloatToStr(FieldByName('COM_VL_DOC').AsCurrency) +
                                   FieldByName('COM_TIPO').AsString;
        if (Lc_Compara_Esq <> Lc_Compara_Dir)  then
          Begin
          if (FieldByName('COM_VL_DOC').AsCurrency > 0) then
            Lc_Vl_Faturado := Lc_Vl_Faturado + FieldByName('COM_VL_DOC').AsCurrency
          else
            Lc_Vl_Devolvido := Lc_Vl_Devolvido + FieldByName('COM_VL_DOC').AsCurrency;
          end;
        Lc_Compara_Esq := IntToStr(FieldByName('COM_CODPED').AsInteger) +
                          FloatToStr(FieldByName('COM_VL_DOC').AsCurrency) +
                                    FieldByName('COM_TIPO').AsString;
        Next;
      end;
      E_Vl_Recebido.Text := FloatToStrF(Lc_Vl_Faturado,ffNumber,10,2);
      Lc_Vl_Devolvido := Lc_Vl_Devolvido * -1;
      E_Vl_Devolvido.Text := FloatToStrF(Lc_Vl_Devolvido,ffNumber,10,2);
      E_Sd_P_Comissao.Text := FloatToStrF(Lc_Vl_Faturado - Lc_Vl_Devolvido,ffNumber,10,2);
      Screen.Cursor := crDefault;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Comissao.Pc_totalizar_Recebimento;
Var
  Lc_SqlTxt : String;
  Lc_Vendedor: boolean;
  Lc_Pedido : boolean;
  Lc_Cd_Financeiro : String;
  Lc_Vl_Recebido : Real;
  Lc_Vl_Devolvido : Real;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT COM_CODFIN, COM_VL_DOC, COM_TIPO ' +
                    'FROM TB_COMISSAO Tb_comissao ' +
                    '    INNER JOIN TB_FINANCEIRO Tb_financeiro ' +
                    '    ON  (Tb_financeiro.FIN_CODIGO = Tb_comissao.COM_CODFIN) ' +
                    '    INNER JOIN TB_PEDIDO Tb_pedido ' +
                    '    ON  (Tb_pedido.PED_CODIGO = Tb_financeiro.FIN_CODPED) ' +
                    '    INNER JOIN TB_EMPRESA Tb_empresa ' +
                    '    ON  (Tb_empresa.EMP_CODIGO = Tb_comissao.COM_CODEMP) ' +
                    '    INNER JOIN TB_COLABORADOR Tb_Colaborador ' +
                    '    ON  (Tb_Colaborador.CLB_CODIGO = Tb_comissao.COM_CODVDO) ' +
                    'WHERE (COM_CODMHA =:COM_CODMHA) ';

      if trim(Fm_ListaColaborador.DBLCB_Vendedor.Text) = '' then Lc_Vendedor := False else Lc_Vendedor := True;
      if E_Busca_Pedido.Text = '' then Lc_Pedido := False else Lc_Pedido := True;

      if ChBx_Periodo.Checked then
        Lc_SqlTxt := Lc_SqlTxt + 'AND COM_DT_VENDA BETWEEN :DATAINICIO AND :DATAFIM ';

      if Lc_Vendedor then Lc_SqlTxt := Lc_SqlTxt + 'AND (COM_CODVDO =:COM_CODVDO) ';
      if Lc_Pedido then Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_NUMERO =:PED_NUMERO) ';

      if CB_Status.ItemIndex = 0 then Lc_SqlTxt := Lc_SqlTxt + 'AND (COM_DT_PAGTO IS NOT NULL) ';
      if CB_Status.ItemIndex = 1 then Lc_SqlTxt := Lc_SqlTxt + 'AND (COM_DT_PAGTO IS NULL) ';

      SQL.Add(Lc_SqlTxt + 'ORDER BY COM_CODFIN ');

      if ChBx_Periodo.Checked then
      begin
        ParamByName('DATAINICIO').AsDate := E_Data_Ini.date;
        ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
      end;
      if Lc_Vendedor then
        ParamByName('COM_CODVDO').AsInteger := Fm_ListaColaborador.DBLCB_Vendedor.KeyValue;

      if Lc_Pedido then
        ParamByName('PED_NUMERO').AsString := E_Busca_Pedido.Text;

      ParamByName('COM_CODMHA').AsInteger := Gb_CodMha;
      Active := True;
      FetchAll;
      First;
      Lc_Cd_Financeiro := '';
      Lc_Vl_Recebido := 0;
      Lc_Vl_Devolvido := 0;
      while not Eof do
        Begin
        if (Lc_Cd_Financeiro <> (FieldByName('COM_CODFIN').AsString + FieldByName('COM_TIPO').AsString)) then
          Begin
          if (FieldByName('COM_VL_DOC').AsCurrency > 0) then
            Lc_Vl_Recebido := Lc_Vl_Recebido + FieldByName('COM_VL_DOC').AsCurrency
          else
            Lc_Vl_Devolvido := Lc_Vl_Devolvido + FieldByName('COM_VL_DOC').AsCurrency;
          end;
        Lc_Cd_Financeiro := (FieldByName('COM_CODFIN').AsString + FieldByName('COM_TIPO').AsString);
        Next;
        end;
      E_Vl_Recebido.Text := FloatToStrF(Lc_Vl_Recebido,ffNumber,10,2);
      Lc_Vl_Devolvido := Lc_Vl_Devolvido * -1;
      E_Vl_Devolvido.Text := FloatToStrF(Lc_Vl_Devolvido,ffNumber,10,2);
      E_Sd_P_Comissao.Text := FloatToStrF(Lc_Vl_Recebido - Lc_Vl_Devolvido,ffNumber,10,2);
      Screen.Cursor := crDefault;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Comissao.Pc_LancaFolha;
Var
  Lc_I : Integer;
  Lc_Data_Ini,Lc_Data_fim: String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_Form : TREgReceipt;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('INSERT INTO TB_FOLHAPAGTO ( '+
                  'FPT_CODIGO, '+
                  'FPT_CODCLB, '+
                  'FPT_DATA, '+
                  'FPT_MES, '+
                  'FPT_ANO, '+
                  'FPT_HISTORICO, '+
                  'FPT_VL_CREDITO, '+
                  'FPT_VL_DEBITO) '+
                  'VALUES ( '+
                  ':FPT_CODIGO, '+
                  ':FPT_CODCLB, '+
                  ':FPT_DATA, '+
                  ':FPT_MES, '+
                  ':FPT_ANO, '+
                  ':FPT_HISTORICO, '+
                  ':FPT_VL_CREDITO, '+
                  ':FPT_VL_DEBITO) ');


      ParamByName('FPT_CODIGO').AsInteger := Fc_Generator('GN_FLHPAGTO','TB_FOLHAPAGTO','FPT_CODIGO');
      ParamByName('FPT_CODCLB').AsInteger := Fm_ListaColaborador.DBLCB_Vendedor.KeyValue;
      ParamByName('FPT_DATA').AsDate := E_Dt_Baixa.Date;
      ParamByName('FPT_MES').AsInteger := CB_Mes.ItemIndex;
      ParamByName('FPT_ANO').AsString := Copy(DateToStr(E_Dt_Baixa.Date),7,4);
      Lc_Data_Ini := DateToStr(E_Data_Ini.date);
      Lc_Data_fim := DateToStr(E_Data_Fim.date);
      ParamByName('FPT_HISTORICO').AsString := 'Pagto Comissões : ' + Lc_Data_Ini + ' - ' + Lc_Data_fim;
      ParamByName('FPT_VL_CREDITO').AsCurrency := StrToFloatDef(Fc_RemoveCaracterInformado(E_Vl_Com_Pagar.Caption,['.']),0);
      ParamByName('FPT_VL_DEBITO').AsCurrency := 0;
      ExecSQL;
      if Chbx_Recibo.Checked then
      Begin
        TRy
          Pc_AtivaEstabelecimento;
          Lc_Form := TRegReceipt.create(nil);

          Lc_Form.Recibo.Registro.Valor  := StrToFloatDef(RemoveCaracterInformado(E_VL_Pagar.Text,['.']),0);
          Lc_Form.Recibo.Registro.Emitente := E_PagaColaborador.Text;
          Lc_Form.Recibo.Registro.Sacado     := DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString;
          Lc_Form.Recibo.Registro.Referencia := 'Pagto Comissões: ' + Lc_Data_Ini + ' - ' + Lc_Data_fim;
          Lc_Form.Recibo.Registro.Data       := Date;
          Lc_Form.autofill      := True;
          Lc_Form.ShowModal;
        Finally
          FreeAndNil(Lc_Form)
        End;
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Comissao.Pc_Buscar;
var
  Lc_sqltxt: string;
  Lc_Vendedor: boolean;
  Lc_Pedido : boolean;
begin
  Lc_sqltxt := '';
  Screen.Cursor := crHourGlass;
  if Qr_Comissao.Transaction.InTransaction then Qr_Comissao.Transaction.Commit;
  if not Qr_Comissao.Transaction.InTransaction then Qr_Comissao.Transaction.StartTransaction;

  Qr_Comissao.Active := False;
  Qr_Comissao.SQL.Clear;
  Lc_sqltxt := 'SELECT COM_CODIGO, COM_DT_VENDA, COM_CODPED, PED_NUMERO, COM_CODEMP, EMP_NOME, COM_CODVDO, ' +
               'CLB_NOME, COM_VL_DOC, COM_AQ_COM, COM_VL_COM, COM_DT_PAGTO ' +
               'FROM TB_COMISSAO Tb_comissao ' +
               '    INNER JOIN TB_EMPRESA Tb_empresa ' +
               '    ON  (Tb_empresa.EMP_CODIGO = Tb_comissao.COM_CODEMP) ' +
               '    INNER JOIN TB_COLABORADOR Tb_Colaborador ' +
               '    ON  (Tb_Colaborador.CLB_CODIGO = Tb_comissao.COM_CODVDO) ' +
               '    INNER JOIN TB_PEDIDO Tb_pedido ' +
               '    ON  (Tb_pedido.PED_CODIGO = Tb_comissao.COM_CODPED) ' +
               'WHERE (COM_CODMHA =:COM_CODMHA) ';

  if trim( Fm_ListaColaborador.DBLCB_Vendedor.Text) = '' then Lc_Vendedor := False else Lc_Vendedor := True;
  if E_Busca_Pedido.Text = '' then Lc_Pedido := False else Lc_Pedido := True;

  if ChBx_Periodo.Checked then
    Lc_sqltxt := Lc_sqltxt + 'AND COM_DT_VENDA BETWEEN :DATAINICIO AND :DATAFIM ';

  if Lc_Vendedor then
    Lc_sqltxt := Lc_sqltxt + 'AND (COM_CODVDO =:COM_CODVDO) ';

  if Lc_Pedido then
    Lc_sqltxt := Lc_sqltxt + 'AND (PED_NUMERO =:PED_NUMERO) ';

  if CB_Status.ItemIndex = 0 then
    Lc_sqltxt := Lc_sqltxt + 'AND (COM_DT_PAGTO IS NOT NULL) ';
  if CB_Status.ItemIndex = 1 then
    Lc_sqltxt := Lc_sqltxt + 'AND (COM_DT_PAGTO IS NULL) ';

  Qr_Comissao.SQL.Add(Lc_sqltxt + ' ORDER BY COM_DT_VENDA, PED_NUMERO ');
  if ChBx_Periodo.Checked then
    begin
    Qr_Comissao.ParamByName('DATAINICIO').AsDate := E_Data_Ini.date;
    Qr_Comissao.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    end;
  if Lc_Vendedor then
    Qr_Comissao.ParamByName('COM_CODVDO').AsInteger := Fm_ListaColaborador.DBLCB_Vendedor.KeyValue;
  if Lc_Pedido then
    Qr_Comissao.ParamByName('PED_NUMERO').AsString := E_Busca_Pedido.Text;

  Qr_Comissao.ParamByName('COM_CODMHA').AsInteger := Gb_CodMha;
  Qr_Comissao.Active := True;
  Screen.Cursor := crDefault;
end;

procedure TFr_Comissao.Pc_PagarComissao;
begin
  comissao.Parametros.FieldName.Vendedor := Fm_ListaColaborador.DBLCB_Vendedor.KeyValue;
  comissao.Parametros.DataInicial := E_Data_Ini.date;
  comissao.Parametros.DataFinal := E_Data_Fim.date;
  comissao.pagar;
end;

procedure TFr_Comissao.SB_FiltroClick(Sender: TObject);
begin
  //Verifica em que momento é feito o calculo da Comissao
  if (Fc_Tb_Geral('L','TP_COMISSAO','')='R') then //Pelo contas a receber
  Begin
    Grb_Faturamento.Caption := 'Totalizador de Recebimento';
    Lb_Faturamento.Caption := 'Baixas';
    Pc_LimpaCampos;
    Pc_totalizar_Recebimento;
    Pc_totalizar_Comissao;
    Pc_Buscar;
    Sb_Alterar.Enabled:= It_Alterar and (Qr_Comissao.RecordCount >0 );
    SB_Pagar.Enabled := (CB_Status.ItemIndex = 1) and (It_Pagar);
  end
  else
  Begin
    Grb_Faturamento.Caption := 'Totalizador de Vendas';
    Lb_Faturamento.Caption := 'Vendas';
    Pc_LimpaCampos;
    Pc_totalizar_Faturamento;
    Pc_totalizar_Comissao;
    Pc_Buscar;
    Sb_Alterar.Enabled:= It_Alterar and (Qr_Comissao.RecordCount >0 );
    SB_Pagar.Enabled := (CB_Status.ItemIndex = 1) and (It_Pagar);
  end;
  //Registra a ultima data da Consulta
  Fc_Aq_Geral('G','COMISSAO','DATAINI',DateToStr(E_Data_Ini.Date));
  Fc_Aq_Geral('G','COMISSAO','DATAFIM',DateToStr(E_Data_Fim.Date));  
end;

procedure TFr_Comissao.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Comissao.setPerfil;
begin
  pfMenu := 'Manutenção Comissões';
  if Gb_Nivel = 1 then
  begin
    It_Alterar := True;
    It_Visualizar := True;
    It_Pagar  := True;
  end
  else
  begin
    It_Alterar    := Fc_HabilitaPermissao(pfMenu,'ALTERAR','S');
    It_Visualizar := Fc_HabilitaPermissao(pfMenu,'VISUALIZAR','S');
    It_Pagar := Fc_HabilitaPermissao(pfMenu,'PAGAR','S');
  end;
  Sb_Alterar.Enabled:= It_Alterar and (Qr_Comissao.RecordCount >0 );
  SB_Pagar.Enabled:= It_Pagar and (CB_Status.ItemIndex = 1);

end;

procedure TFr_Comissao.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
  case PG_Comissao.ActivePageIndex of
    0:begin
      if shift = [] then
        begin
        case Key of
          VK_F3: if Sb_Alterar.Enabled then
                Sb_AlterarClick(Sender);
          VK_F7: if SB_Filtro.Enabled then
                SB_FiltroClick(Sender);
          VK_F8: if SB_Pagar.Enabled then
                SB_PagarClick(Sender);
          VK_ESCAPE: if Sb_Sair_0.Enabled then
                Sb_Sair_0Click(Sender);
          end;
        end;
      end;
    1:begin
      if shift = [] then
        begin
        case Key of
          VK_F5: if Sb_Gravar.Enabled then
                Sb_GravarClick(Sender);
          VK_F6: if SB_Cancelar.Enabled then
                SB_CancelarClick(Sender);
          end;
        end;
      end;
   end;
end;

procedure TFr_Comissao.FormataTela;
Var
  Lc_X:Integer;
Begin
  for Lc_X := 1 to PG_Comissao.PageCount do
    PG_Comissao.Pages[Lc_X - 1].TabVisible := False;
  PG_Comissao.ActivePageIndex := 0;
  Grb_Faturamento.Enabled := False;
  Grb_Comissao.Enabled := False;
end;

procedure TFr_Comissao.FormCreate(Sender: TObject);
begin
  CriarVariaveis;
end;

procedure TFr_Comissao.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) and not (ActiveControl is TDBMemo) then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

procedure TFr_Comissao.E_VL_ComissaoExit(Sender: TObject);
var
   Lc_Vl_Venda: Real;
   Lc_VL_Comissao: Real;
   Lc_Aq_Com: Real;
begin
   if E_VL_Comissao.Text = '' then
      exit;
   Lc_Vl_Venda := StrToFloatDef(E_VL_Venda.Text, 1);
   Lc_VL_Comissao := StrToFloatDef(E_VL_Comissao.Text,0);
   Lc_Aq_Com := (Lc_VL_Comissao / Lc_Vl_Venda) * 100;
   E_VL_Comissao.Text := FloatToStrF(Lc_VL_Comissao, ffFixed, 10, 2);
   E_Aq_Com.Text := FloatToStrF(Lc_Aq_Com, ffFixed, 10, 2);
end;

procedure TFr_Comissao.E_Aq_ComChange(Sender: TObject);
begin
   it_Up_Comissao := True;
end;

procedure TFr_Comissao.E_Aq_ComExit(Sender: TObject);
var
   Lc_Vl_Venda: Real;
   Lc_VL_Comissao: Real;
   Lc_Aq_Com: Real;
begin
   if E_Aq_Com.Text = '' then
      exit;
   if it_Up_Comissao then
   begin
      Lc_Vl_Venda := StrToFloatDef(E_VL_Venda.Text, 1);
      Lc_Aq_Com := StrToFloatDef(E_Aq_Com.Text,0);
      Lc_VL_Comissao := Lc_Vl_Venda * (Lc_Aq_Com / 100);
      E_VL_Comissao.Text := FloatToStrF(Lc_VL_Comissao, ffFixed, 10, 2);
      E_Aq_Com.Text := FloatToStrF(Lc_Aq_Com, ffFixed, 10, 2);
   end;
end;

procedure TFr_Comissao.ChBx_PeriodoClick(Sender: TObject);
begin
   E_Data_Ini.Enabled := ChBx_Periodo.Checked;
   E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Comissao.Sb_GravarClick(Sender: TObject);
begin
  if E_AQ_COM.CanFocus then E_Aq_ComExit(Self);
  Comissao.Registro.Codigo := Qr_Comissao.FieldByName('COM_CODIGO').AsInteger;
  Comissao.getById;
  with Comissao do
  Begin
    Registro.DataVenda        := E_Dt_Venda.Date;
    Registro.Vendedor         := Fm_ListaEditColaborador.Dblcb_Vendedor.KeyValue;
    Registro.valorComissao    := StrToFloatDef(E_VL_Comissao.Text, 0);
    Registro.Aliquota         := StrToFloatdef(E_Aq_Com.Text, 0);
    If Chbx_DataPagto.Checked then
      Registro.DataPagto      :=  E_Dt_Pagto.Date
    else
      Registro.DataPagto      :=  0;
  end;
  Comissao.save;
  Comissao.atualizaVendedorPedido;
  E_AQ_COM.Clear;
  E_VL_Comissao.Clear;
  It_Busca := Qr_Comissao.FieldByName('PED_NUMERO').AsInteger;
  Pc_Buscar;
  MensagemPadrao(TITULO_ERRO, 'S U C E S S O!.' + EOLN + EOLN +
                              'Atualização Executada com Sucesso.' + EOLN,
                              ['OK'], [bEscape], mpConfirmacao);
   Qr_Comissao.Locate('PED_NUMERO', It_Busca, [loCaseInsensitive]);
  PG_Comissao.ActivePageIndex := 0;
end;

procedure TFr_Comissao.SB_CancelarClick(Sender: TObject);
begin

  PG_Comissao.ActivePageIndex := 0;
end;

procedure TFr_Comissao.Sb_AlterarClick(Sender: TObject);
begin
  PG_Comissao.ActivePageIndex := 1;
  with Qr_Comissao do
  Begin
    E_VL_Comissao.Text := FloatToStrF(FieldByName('COM_VL_COM').AsCurrency,ffFixed,10,2);
    E_AQ_COM.Text := FloatToStrF(FieldByName('COM_AQ_COM').AsFloat,ffFixed,10,2);
    E_Dt_Venda.Date := FieldByName('COM_DT_VENDA').AsDateTime;
    Fm_ListaEditColaborador.Dblcb_Vendedor.KeyValue := FieldByName('COM_CODVDO').AsInteger;
    if (Length(FieldByName('COM_DT_PAGTO').AsString) > 0) then
    Begin
      E_Dt_Pagto.Date := FieldByName('COM_DT_PAGTO').AsDateTime;
      Chbx_DataPagto.Checked := True;
    end
    else
    Begin
      E_Dt_Pagto.Date := Date;
      Chbx_DataPagto.Checked := False;
    end;
  End;
  E_VL_Comissao.SetFocus;
end;

procedure TFr_Comissao.DBG_ComissaoDblClick(Sender: TObject);
begin
  Sb_AlterarClick(Sender);
end;

procedure TFr_Comissao.SB_SairClick(Sender: TObject);
begin
  PG_Comissao.ActivePageIndex := 0;
end;

procedure TFr_Comissao.SB_ConfirmarClick(Sender: TObject);
var
   Lc_Escolha: Integer;
begin
   Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                  'Baixar as Comissões Selecionadas.' + EOLN + EOLN +
                                  'Confirmar a Baixa ?',
                                  [SIM, 'Cancelar'], [bEscape, bNormal], mpConfirmacao, clBtnFace));
   try
      if lc_Escolha = 0 then
      begin
         Pc_LancaFolha;
         Pc_PagarComissao;
         PG_Comissao.ActivePageIndex := 0;
         Pc_Buscar;
      end;
   except
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Um erro impossibilitou a Baixa das Comissões.' + EOLN +
                     'Entre em contato com o suporte técnico.' + EOLN,
                     ['OK'], [bEscape], mpErro);
   end;
end;

procedure TFr_Comissao.Chbx_ReciboClick(Sender: TObject);
begin
  if Chbx_Recibo.Checked then
  Begin
    E_Nr_Vias.Enabled := True;
    E_Nr_Vias.Text := '2';
  end
  else
  Begin
    E_Nr_Vias.Enabled := False;
    E_Nr_Vias.Text := '0';
  end;
end;

procedure TFr_Comissao.CorrigeComissaoDuplicada;
begin
  Comissao.Parametros.Estabelecimento := Gb_CodMha;
  Comissao.Parametros.Periodo         := ChBx_Periodo.Checked;
  Comissao.Parametros.DataInicial     := E_Data_Ini.Date;
  Comissao.Parametros.DataFinal       := E_Data_Fim.Date;
  Comissao.Parametros.FieldName.Vendedor := Fm_ListaColaborador.Dblcb_Vendedor.KeyValue;

  Comissao.CorrigeDuplicados;

  MensagemPadrao(TITULO_INFORMACAO, TITULO_INFORMACAO + EOLN + EOLN +
                'Operacao executada com sucesso.' + EOLN ,
                ['OK'], [bEscape], mpInformacao);
end;

procedure TFr_Comissao.Corrigirduplicados1Click(Sender: TObject);
begin
  if ValidaCorrigeComissaoDuplicada then
  Begin
    SB_FiltroClick(Self);
    CorrigeComissaoDuplicada;
    SB_FiltroClick(Self);
  End;

end;

procedure TFr_Comissao.CriarVariaveis;
begin
  Comissao := TControllerComissao.create(self);
end;

procedure TFr_Comissao.AtivaTabelas;
begin
  DM_ListaConsultas.Pc_ListaVendedor;
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  Fm_ListaColaborador.ListaColaborador;
  Fm_ListaEditColaborador.ListaColaborador;
end;

procedure TFr_Comissao.CB_StatusChange(Sender: TObject);
begin
  SB_Pagar.Enabled := (CB_Status.ItemIndex = 1) and (It_Pagar);
end;

procedure TFr_Comissao.Chbx_DataPagtoClick(Sender: TObject);
begin
  E_Dt_Pagto.Enabled := Chbx_DataPagto.Checked;
end;

procedure TFr_Comissao.DBG_ComissaoTitleClick(Column: TColumn);
begin
 Pc_Pintar_Grid_Ordenar(DBG_Comissao, Column);
end;


procedure TFr_Comissao.FormShow(Sender: TObject);
begin
  setPerfil;
  IniciaVariaveis;
  AtivaTabelas;
  FormataTela;
  ImagemBotao;


end;

procedure TFr_Comissao.ImagemBotao;
begin
  with fr_principal do
  Begin
    //Geral;
    Sb_Alterar.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

procedure TFr_Comissao.IniciaVariaveis;
begin
  E_Data_Ini.Date := StrToDateDef(Fc_Aq_Geral('L','COMISSAO','DATAINI',DateToStr(E_Data_Ini.Date)),Date);
  E_Data_Fim.Date := StrToDateDef(Fc_Aq_Geral('L','COMISSAO','DATAFIM',DateToStr(E_Data_Fim.Date)),Date);
  E_Dt_Baixa.Date := DATE;
end;


procedure TFr_Comissao.TabSheet3Show(Sender: TObject);
begin
  Height := 269 - 15;
  Width := 604;
end;

function TFr_Comissao.ValidaCorrigeComissaoDuplicada: boolean;
begin
  Result := True;
  if( not Qr_Comissao.Active) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por favor efetue uma consulta antes.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;

  if (Qr_Comissao.RecordCount = 0)  then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Não foi encontrado nenhum registro.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  End;

  if not ChBx_Periodo.Checked then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por favor defina uma intervalo de datas.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  End;

  if CB_Status.ItemIndex <> 1  then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Para a correção só é permitido para situação pendente.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  End;

  if ( Fm_ListaColaborador.Dblcb_Vendedor.Text = '' ) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'por favor informe o nome do Vendedor.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  End;

end;

procedure TFr_Comissao.TabSheet2Show(Sender: TObject);
begin
  Height := 294 - 15;
  Width := 604;
end;

procedure TFr_Comissao.TabSheet1Show(Sender: TObject);
begin
  Height := 509 - 15;
  Width := 700;
  if ActiveControl= CB_Status then CB_Status.SetFocus;
end;

procedure TFr_Comissao.chbx_EmpresasClick(Sender: TObject);
begin
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);  
end;

procedure TFr_Comissao.SB_PagarClick(Sender: TObject);
Var
  Lc_Mes : String;
begin
  if Fc_ValidaDados then
  Begin
    //Define o Mes que será feito o Lancamento;
    Lc_Mes := Copy(DateToStr(E_Data_Ini.Date),4,2);
    //Se a apuração e de um mes o lancamento é feito no proximo mes
    CB_Mes.ItemIndex := StrToIntDef(Lc_Mes,1) + 1;
    E_Vl_Vendas.Caption := E_Sd_P_Comissao.Text;
    E_Vl_Com_Pagar.Caption := E_Sd_Comissao.Text;
    PG_Comissao.ActivePageIndex := 2;
  End;

end;

end.

