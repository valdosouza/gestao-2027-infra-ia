unit un_receber_baixa_lote;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls, DBCtrls, Mask, QEdit_Setes, Buttons, DB, Grids, DBGrids, STQuery, DBClient, Provider, FavoritoButtons, ACBrBoleto, ACBrBoletoFCFortesFr, ACBrBase, Un_Fm_FormaPagto;

type
  TFR_RECEBER_BAIXA_LOTE = class(TForm)
    pn_geral: TPanel;
    qr_busca: TSTQuery;
    dts_busca: TDataSource;
    pnl_botoes: TPanel;
    SB_BAIXA: TSpeedButton;
    sb_sair: TSpeedButton;
    SB_Buscar: TSpeedButton;
    GroupBox3: TGroupBox;
    Label12: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    L_CodigoCliente: TLabel;
    Sb_Empresa: TSpeedButton;
    E_BuscaPedido: TEdit_Setes;
    E_BuscaCliente: TEdit;
    E_BuscaNota: TEdit_Setes;
    E_BuscaFinanceiro: TEdit;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    E_cd_Cliente: TEdit;
    StrGrd_Parcela: TStringGrid;
    Rg_Data: TRadioGroup;
    Rg_Situacao: TRadioGroup;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Lb_Vl_Prazo: TLabel;
    Lb_Vl_Credito: TLabel;
    Lb_Vl_Vencer: TLabel;
    Lb_Vl_Vencida: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    SB_Add_Tudo: TSpeedButton;
    SB_Retirar_Tudo: TSpeedButton;
    Fm_FormaPagto: TFm_FormaPagto;
    procedure sb_sairClick(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure SB_BAIXAClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure E_cd_ClienteExit(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure Rg_SituacaoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StrGrd_ParcelaClick(Sender: TObject);
    procedure StrGrd_ParcelaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SB_Add_TudoClick(Sender: TObject);
    procedure SB_Retirar_TudoClick(Sender: TObject);
    procedure Sb_EmpresaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    it_cod_ContBanc,it_PlanoC, it_planoD, It_Qt_Rec, it_Cd_Qtc:Integer;
    it_baixa:Boolean;
    it_dt_pag:TDate;
    procedure Pc_BuscaParcela;
    procedure Pc_ativaTabelas;
    Procedure Pc_LancaCaixa;
    procedure Pc_LancaBanco;
    procedure Pc_Baixar_Comissao;
    Procedure Pc_FormataTela;
    procedure Pc_Preencher_Parcelas;

  end;

const   Checked: array[1..4] of boolean = (false, true, false, true);

var
  FR_RECEBER_BAIXA_LOTE: TFR_RECEBER_BAIXA_LOTE;

implementation

uses     Un_DM, UN_Sistema, un_MSG, Un_Lanca_PlanoContas, un_info_baixa_lote, Un_Fc_Sored_Procedures, Un_Fc_Comissao, Un_Regra_Negocio, StdConvs, RN_FormaPagto, RN_Empresa, Un_Principal, env;
{$R *.dfm}

Procedure TFR_RECEBER_BAIXA_LOTE.Pc_FormataTela;
Begin
  StrGrd_Parcela.ColWidths[0]:=17;
  StrGrd_Parcela.ColWidths[1]:=-1;
  StrGrd_Parcela.ColWidths[2]:=54;
  StrGrd_Parcela.ColWidths[3]:=73;
  StrGrd_Parcela.ColWidths[4]:=87;
  StrGrd_Parcela.ColWidths[5]:=90;
  StrGrd_Parcela.ColWidths[6]:=90;
  StrGrd_Parcela.ColWidths[7]:=368;
  StrGrd_Parcela.ColWidths[8]:=77;
  StrGrd_Parcela.ColWidths[9]:=-1;
  StrGrd_Parcela.ColWidths[10]:=-1;

  StrGrd_Parcela.Cols[2].Add('Selecionar');
  StrGrd_Parcela.Cols[3].Add('Pedido');
  StrGrd_Parcela.Cols[4].Add('Nota Fiscal');
  StrGrd_Parcela.Cols[5].Add('Duplicata');
  StrGrd_Parcela.Cols[6].Add('Vencimento');
  StrGrd_Parcela.Cols[7].Add('Nome/Razão');
  StrGrd_Parcela.Cols[8].Add('Valor Parc.');
  StrGrd_Parcela.Cols[9].Add('escolhio');
  StrGrd_Parcela.Cols[10].Add('fin_codped');

end;

procedure TFR_RECEBER_BAIXA_LOTE.Pc_Preencher_Parcelas;
Var
  Lc_I,Lc_J : Integer;
  Lc_registro : Integer;

Begin
  Screen.Cursor:=crHourGlass;
  qr_busca.First;
  // Limpa a Grid de Pesquisa Parcelas

  For Lc_I :=1 to StrGrd_Parcela.RowCount - 1 do
    For Lc_J := 1 to StrGrd_Parcela.ColCount - 1 do
      StrGrd_Parcela.Cells[Lc_J, Lc_I] := '';
  StrGrd_Parcela.RowCount := 2;
 Lc_registro := 0;
  while not qr_busca.Eof do
    Begin
    Lc_registro := Lc_registro + 1;
    StrGrd_Parcela.RowCount := Lc_registro + 1;
    StrGrd_Parcela.Cells[1,Lc_registro] := qr_busca.FieldByName('FIN_CODIGO').AsString;
    StrGrd_Parcela.Cells[3,Lc_registro] := qr_busca.FieldByName('PED_NUMERO').AsString;
    StrGrd_Parcela.Cells[4,Lc_registro] := qr_busca.FieldByName('NFL_NUMERO').AsString;
    StrGrd_Parcela.Cells[5,Lc_registro] := qr_busca.FieldByName('FIN_NUMERO').AsString;
    StrGrd_Parcela.Cells[6,Lc_registro]   := qr_busca.FieldByName('FIN_DT_VENCIMENTO').AsString;
    if ChBx_Nome.Checked then
      StrGrd_Parcela.Cells[7,Lc_registro]   := qr_busca.FieldByName('EMP_NOME').AsString
    else
      StrGrd_Parcela.Cells[7,Lc_registro]   := qr_busca.FieldByName('EMP_FANTASIA').AsString;
    StrGrd_Parcela.Cells[8,Lc_registro]  := FloatToStrF(qr_busca.FieldByName('FIN_VL_PARCELA').AsCurrency,ffNumber,10,2);
    StrGrd_Parcela.Cells[9,Lc_registro]  := '';
    StrGrd_Parcela.Cells[10,Lc_registro]  := qr_busca.FieldByName('FIN_CODPED').AsString;
    qr_busca.Next;
    end;
  StrGrd_Parcela.Repaint;
  Screen.Cursor:=crDefault;
end;

procedure TFR_RECEBER_BAIXA_LOTE.sb_sairClick(Sender: TObject);
begin
  close;
end;

procedure TFR_RECEBER_BAIXA_LOTE.SB_BuscarClick(Sender: TObject);
begin
  Pc_BuscaParcela;
  Pc_Preencher_Parcelas;
end;

procedure TFR_RECEBER_BAIXA_LOTE.Pc_BuscaParcela;
var
  SqlTxt : string;
  Lc_Pedido, Lc_NotaFiscal,Lc_Finaceiro, Lc_Cd_Cliente, Lc_Cliente,  Lc_FormaPagto : boolean;
begin
  SqlTxt := '';
  Screen.Cursor:=crHourGlass;
  qr_busca.Close;
  qr_busca.Sql.Clear;

  Sqltxt :=' SELECT DISTINCt FIN_CODIGO,NFL_NUMERO,PED_NUMERO,FIN_NUMERO,           '+
           ' FIN_DT_VENCIMENTO,FIN_CODEMP,EMP_FANTASIA,EMP_NOME,FIN_VL_PARCELA,     '+
           ' FIN_BAIXA,FIN_SITUACAO,FIN_CODQTC,FIN_CODFPG,PED_CODIGO,NFL_CODIGO,    '+
           ' FIN_TIPO, FIN_DT_PAGTO,FIN_OPERACAO,FIN_ETAPA,FIN_CODMHA,             '+
           ' FIN_CODCHQ,  FIN_NR_PARCELA,FIN_DATA, FIN_CODPED                       '+
           ' FROM                                                                   '+
           '   TB_FINANCEIRO tb_financeiro                                          '+
           ' INNER JOIN TB_NOTA_FISCAL tb_nota_Fiscal                               '+
           '   ON (tb_nota_Fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL)            '+
           ' LEFT OUTER JOIN TB_PEDIDO tb_pedido                                    '+
           '   ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED)                 '+
           ' INNER JOIN TB_EMPRESA tb_empresa                                       '+
           '   ON (tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP)                '+
           ' WHERE                                                                  '+
           '  ((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM''))                          '+
           '   AND (FIN_BAIXA =''N'') AND (FIN_CODMHA=:FIN_CODMHA)                  ';

  if E_BuscaPedido.Text = ''         then Lc_Pedido      := False else Lc_Pedido      := True;
  if E_BuscaNota.Text = ''           then Lc_NotaFiscal  := False else Lc_NotaFiscal  := True;
  if E_BuscaFinanceiro.Text = ''     then Lc_Finaceiro   := False else Lc_Finaceiro   := True;
  if E_BuscaCliente.Text = ''        then Lc_Cliente     := False else Lc_Cliente     := True;
  if Fm_FormaPagto.DBLCB_FormaPagto.Text = '' then Lc_FormaPagto  := False else Lc_FormaPagto  := True;
  if E_cd_Cliente.Text = ''       then  Lc_Cd_Cliente  := False else Lc_Cd_Cliente  := True;

  if Lc_Pedido     then sqltxt := sqltxt + 'AND (PED_NUMERO = :PED_NUMERO) ';
  if Lc_NotaFiscal then sqltxt := sqltxt + 'AND (NFL_NUMERO = :NFL_NUMERO) ';
  if Lc_Finaceiro  then sqltxt := sqltxt + 'AND (FIN_NUMERO LIKE :FIN_NUMERO) ';
  if Lc_Cd_Cliente then sqltxt := sqltxt + 'AND (FIN_CODEMP =:FIN_CODEMP) ';
  if Lc_Cliente    then sqltxt := sqltxt + 'AND ((EMP_FANTASIA LIKE :EMP_FANTASIA) OR (EMP_NOME LIKE :EMP_FANTASIA)) ';
  if Lc_FormaPagto then sqltxt := sqltxt + 'AND (FIN_CODFPG =:FIN_CODFPG) ';
  if ChBx_Periodo.Checked then
    sqltxt := sqltxt + 'AND (FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM) ';

  qr_busca.SQL.Add(SqlTxt+ 'ORDER BY FIN_DT_VENCIMENTO, EMP_NOME, PED_NUMERO, FIN_NUMERO ');

  if ChBx_Periodo.Checked then
  Begin
      qr_busca.ParamByName('DATAINI').AsDate      := E_Data_Ini.date;
      qr_busca.ParamByName('DATAFIM').Asdate      := E_Data_Fim.Date;
    end;

  if Lc_Pedido     then qr_busca.ParamByName('PED_NUMERO').AsString   := E_BuscaPedido.Text;
  if Lc_NotaFiscal then qr_busca.ParamByName('NFL_NUMERO').AsString   := E_BuscaNota.Text;
  if Lc_Finaceiro  then qr_busca.ParamByName('FIN_NUMERO').AsString   := '%'+ E_BuscaFinanceiro.Text+'%';
  if Lc_Cliente    then qr_busca.ParamByName('EMP_FANTASIA').AsString := '%'+ E_BuscaCliente.Text +'%';
  if Lc_Cd_Cliente then qr_busca.ParamByName('FIN_CODEMP').AsString  := E_cd_Cliente.Text;
  if Lc_FormaPagto then qr_busca.ParamByName('FIN_CODFPG').AsInteger  := Fm_FormaPagto.DBLCB_FormaPagto.KeyValue;

  qr_busca.ParamByName('FIN_CODMHA').AsInteger := Gb_CodMha;
  qr_busca.Open;
  qr_busca.FetchAll;
  IF qr_busca.RecordCount > 0 THEN
    Begin
    SB_BAIXA.Enabled:=TRUE;
    SB_Add_Tudo.Enabled:= True;
    SB_Retirar_Tudo.Enabled:= True;
    end
  ELSE
    Begin
    SB_BAIXA.Enabled := False;
    SB_Add_Tudo.Enabled:= False;
    SB_Retirar_Tudo.Enabled:= False;    
    end;
  Screen.Cursor:=crDefault;
end;

procedure TFR_RECEBER_BAIXA_LOTE.SB_BAIXAClick(Sender: TObject);
var
 Lc_Escolha: Integer;
begin
  if not Assigned(Fr_Lanca_PlanoContas) then
    Application.CreateForm(TFr_Lanca_PlanoContas, Fr_Lanca_PlanoContas);
  Fr_Lanca_PlanoContas.ShowModal;

  if it_baixa then
    begin
    if not Assigned (fr_info_baixa_lote) then
      Application.CreateForm(Tfr_info_baixa_lote,fr_info_baixa_lote);

    Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                    'Baixar as Duplicatas Selecionadas.'+EOLN+EOLN+
                                    'Confirmar a Baixa ?',
                                    ['Caixa','Banco','Cancelar'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));

    case Lc_Escolha of
      0:begin
        fr_info_baixa_lote.IT_TIPO:= 'caixa';
        fr_info_baixa_lote.ShowModal;
        if it_baixa then
          Begin
          Pc_LancaCaixa;
          Pc_Baixar_Comissao;
          end;
        end;
      1:begin
        fr_info_baixa_lote.IT_TIPO:= 'banco';
        fr_info_baixa_lote.ShowModal;
        if it_baixa then
          Begin
          Pc_LancaBanco;
          Pc_Baixar_Comissao;
          end;
        end;
      end;
    end;
  Pc_BuscaParcela;
  Pc_Preencher_Parcelas;
end;

procedure TFR_RECEBER_BAIXA_LOTE.Pc_Baixar_Comissao;
Var
  Lc_I : Integer;
  Lc_cd_Financeiro : Integer;
  Lc_cd_Pedido : Integer;
Begin
  if (Fc_Tb_Geral('L','TP_COMISSAO','')='R') then
    Begin
    Pc_Construtor_Comissao(DM.IB_Transacao);
    for Lc_I := 1 to StrGrd_Parcela.RowCount - 1 do
      begin
      if (StrGrd_Parcela.Cells[9,Lc_I] = 'X') then
        Begin
        Lc_cd_Financeiro := StrToIntDef(StrGrd_Parcela.Cells[1,Lc_I],0);
        Lc_Cd_Pedido     := StrToIntDef(StrGrd_Parcela.Cells[10,Lc_I],0);
        Pc_Registra_Vdo_Pedido(DM.IB_Transacao, Lc_cd_Pedido);
        Pc_Gerar_Comissao_Vda_Rec(DM.IB_Transacao, Lc_cd_Financeiro);
        Pc_Gerar_Comissao_Srv_Rec(DM.IB_Transacao, Lc_cd_Financeiro);
        Pc_Gerar_Comissao_Srv_Vdo_Rec(DM.IB_Transacao, Lc_cd_Financeiro);
        end;
      end;
    Pc_Destrutor_Comissao;
    end;
end;

procedure TFR_RECEBER_BAIXA_LOTE.Pc_ativaTabelas;
begin
  Fm_FormaPagto.Pc_Listar(3,False,0);
end;

procedure TFR_RECEBER_BAIXA_LOTE.FormCreate(Sender: TObject);
begin
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
  Pc_AtivaTabelas;
end;

procedure TFR_RECEBER_BAIXA_LOTE.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  FR_RECEBER_BAIXA_LOTE:=NIL;
end;

procedure TFR_RECEBER_BAIXA_LOTE.E_cd_ClienteExit(Sender: TObject);
var
  Lc_Qry  : TSTQuery;
begin
  if E_cd_Cliente.Text <> NullAsStringValue then
  begin
    try
      // Cria a query
      Lc_Qry := TSTQuery.Create(Self);
      // Inicia a Transação
      Lc_Qry.Transaction := DM.IB_Transacao;
      // Fecha a query
      Lc_Qry.Close;
      // Gera o select
      Lc_Qry.SQL.Text := ' SELECT                '+
                         '   EMP_FANTASIA,       '+
                         '   EMP_NOME            '+
                         ' FROM                  '+
                         '   TB_EMPRESA          '+
                         ' WHERE                 '+
                         '   EMP_CODIGO =:CODIGO ';
      Lc_Qry.ParamByName('codigo').AsString := E_cd_Cliente.Text;
      // Abre a query
      Lc_Qry.Open;
      Lc_Qry.FetchAll;
    finally
      if Lc_Qry.RecordCount <> 0 then
      begin
        if ChBx_Nome.Checked then
        begin
          E_BuscaCliente.Text := Lc_Qry.FieldByName('EMP_NOME').AsString
        end else
        begin
          if Lc_Qry.FieldByName('EMP_FANTASIA').AsString <> NullAsStringValue then
          begin
            E_BuscaCliente.Text := Lc_Qry.FieldByName('EMP_FANTASIA').AsString;
          end else
          begin
            E_BuscaCliente.Text := '';
          end; { if Emp_fantasia }
        end;{ if Chx_nome }
      end else
      begin
        E_BuscaCliente.Text := '' ;
      end;  { if RecordCount }
      FreeAndNil(Lc_Qry);
    end; { try , finally }
  end
  ELSE
   E_BuscaCliente.Text:='';  

end;

procedure TFR_RECEBER_BAIXA_LOTE.ChBx_FantasiaClick(Sender: TObject);
begin
  if ChBx_Fantasia.Checked then
    Begin
    ChBx_Nome.Checked := False;
    StrGrd_Parcela.Cols[7].Insert(0,'Apelido/Fantasia');
    Pc_BuscaParcela;
    end;
end;

procedure TFR_RECEBER_BAIXA_LOTE.ChBx_NomeClick(Sender: TObject);
begin
  if ChBx_Nome.Checked then
  Begin
    ChBx_Fantasia.Checked := False;
    StrGrd_Parcela.Cols[7].Insert(0,'Nome /Razão Social');
    Pc_BuscaParcela;
  end;
end;

procedure TFR_RECEBER_BAIXA_LOTE.Rg_SituacaoClick(Sender: TObject);
begin
  Pc_BuscaParcela;
end;

procedure TFR_RECEBER_BAIXA_LOTE.Pc_LancaBanco;
Var
  Lc_I : Integer;
begin
  qr_busca.First;
  For Lc_I := 1 to StrGrd_Parcela.RowCount - 1 do
    begin
    if StrGrd_Parcela.Cells[9,Lc_I] = 'X' then
      Begin
      It_Qt_Rec := Fc_GeraCod_BAixa;
      qr_busca.Locate('FIN_CODIGO',StrGrd_Parcela.Cells[1,Lc_I],[] );
      It_Qt_Rec := Fc_GeraCod_BAixa;
      Pc_Movim_Financeiro(dm.IB_Transacao,
                          'I',
                          0,
                          it_cod_ContBanc,
                          Now,
                          1,
                          it_PlanoC,
                          it_planoD,
                          qr_busca.FieldByName('FIN_vl_parcela').AsCurrency,//valor CREDITO
                          0, //valor debito
                          'Baixa Lote Pedido Nº' + qr_busca.FieldByName('PED_NUMERO').AsString,
                          'C',
                          It_Qt_Rec,
                          Gb_Cd_Usuario,
                          0,
                          qr_busca.FieldByName('FIN_DATA').AsDateTime,
                          qr_busca.FieldByName('FIN_NUMERO').AsString,
                          'S',
                          'N',
                          Gb_CodMha,
                          qr_busca.FieldByName('FIN_CODFPG').AsInteger  );
      Pc_Financeiro(dm.IB_Transacao, 'B', qr_busca.FieldByName('FIN_CODIGO').AsInteger, qr_busca.FieldByName('FIN_CODEMP').AsInteger, qr_busca.FieldByName('FIN_DT_VENCIMENTO').AsDateTime, qr_busca.FieldByName('PED_CODIGO').AsInteger, qr_busca.FieldByName('NFL_CODIGO').AsInteger,
                    qr_busca.FieldByName('FIN_CODFPG').AsInteger, '000 - é vista', qr_busca.FieldByName('FIN_DT_VENCIMENTO').AsDateTime, qr_busca.FieldByName('FIN_NUMERO').AsString, qr_busca.FieldByName('FIN_VL_PARCELA').AsCurrency,0,0,0,qr_busca.FieldByName('FIN_VL_PARCELA').AsCurrency,
                    it_dt_pag, Now,'S', qr_busca.FieldByName('FIN_NR_PARCELA').asinteger,qr_busca.FieldByName('FIN_TIPO').AsString,qr_busca.FieldByName('FIN_SITUACAO').AsString, It_Qt_Rec,'C','N',0);
      end;
    end;
end;


procedure TFR_RECEBER_BAIXA_LOTE.Pc_LancaCaixa;
var
  Lc_I:Integer;
begin
  qr_busca.First;
  For Lc_I := 1 to StrGrd_Parcela.RowCount - 1 do
    begin
    if StrGrd_Parcela.Cells[9,Lc_I] = 'X' then
      Begin
      It_Qt_Rec := Fc_GeraCod_BAixa;
      qr_busca.Locate('FIN_CODIGO',StrGrd_Parcela.Cells[1,Lc_I],[] );
      Pc_Movim_Financeiro(dm.IB_Transacao,
                          'I',
                          0,
                          it_cod_ContBanc,
                          Now,
                          1,
                          it_PlanoC,
                          it_planoD,
                          qr_busca.FieldByName('FIN_VL_PARCELA').AsCurrency,
                          0, //valor debito
                          'Baixa Lote Pedido Nº' + qr_busca.FieldByName('PED_NUMERO').AsString,
                          'C',
                          It_Qt_Rec,
                          Gb_Cd_Usuario,
                          0,
                          qr_busca.FieldByName('FIN_DATA').AsDateTime,
                          qr_busca.FieldByName('FIN_NUMERO').AsString,
                          'S',
                          'N',
                          Gb_CodMha,
                          qr_busca.FieldByName('FIN_CODFPG').AsInteger);

      Pc_Financeiro(dm.IB_Transacao,'B',qr_busca.FieldByName('FIN_CODIGO').AsInteger, qr_busca.FieldByName('FIN_CODEMP').AsInteger, qr_busca.FieldByName('FIN_DT_VENCIMENTO').AsDateTime, qr_busca.FieldByName('PED_CODIGO').AsInteger, qr_busca.FieldByName('NFL_CODIGO').AsInteger,
                    qr_busca.FieldByName('FIN_CODFPG').AsInteger, '000 - é vista', qr_busca.FieldByName('FIN_DT_VENCIMENTO').AsDateTime, qr_busca.FieldByName('FIN_NUMERO').AsString, qr_busca.FieldByName('FIN_VL_PARCELA').AsCurrency,0,0,0,qr_busca.FieldByName('FIN_VL_PARCELA').AsCurrency,
                    it_dt_pag, Now,'S', qr_busca.FieldByName('FIN_NR_PARCELA').asinteger,qr_busca.FieldByName('FIN_TIPO').AsString,qr_busca.FieldByName('FIN_SITUACAO').AsString, It_Qt_Rec,'C','N',0);
      end;
  end;
end;



procedure TFR_RECEBER_BAIXA_LOTE.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_F9  : If SB_BAIXA.Enabled then SB_BAIXAClick(Sender);
      VK_Escape: if Sb_Sair.Enabled then   sb_sairClick(Sender);
    end;
  end;
end;

procedure TFR_RECEBER_BAIXA_LOTE.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  SB_BAIXA.Enabled:= FALSE;
end;

procedure TFR_RECEBER_BAIXA_LOTE.StrGrd_ParcelaClick(Sender: TObject);
begin
  IF StrGrd_Parcela.Cells[9,StrGrd_Parcela.Row]= 'X' then
    StrGrd_Parcela.Cells[9,StrGrd_Parcela.Row] := ''
  else
    StrGrd_Parcela.Cells[9,StrGrd_Parcela.Row] := 'X';
  StrGrd_Parcela.Repaint;
end;



procedure TFR_RECEBER_BAIXA_LOTE.StrGrd_ParcelaDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  if (ACol = 2)and(ARow>0) Then
    begin
    if (StrGrd_Parcela.Cells[1,ARow] <> '') then
      Begin
      if (StrGrd_Parcela.Cells[9,ARow] = 'X') then
        DrawFrameControl(StrGrd_Parcela.Canvas.Handle, Rect,DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED) // Desenha o CheckBox desmarcado
      else
        DrawFrameControl(StrGrd_Parcela.Canvas.Handle, Rect,   DFC_BUTTON, DFCS_BUTTONCHECK); // Desenha o CheckBox marcado
      end;
    end
  else
    Begin
    If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
      Begin
      if (StrGrd_Parcela.Cells[9,ARow] = '') then
        Begin
        StrGrd_Parcela.Canvas.Font.Color:= clBlack;
        StrGrd_Parcela.Canvas.Brush.Color:= clCream;
        end
      else
        Begin
        StrGrd_Parcela.Canvas.Font.Color:= clBlack;
        StrGrd_Parcela.Canvas.Brush.Color:= clMoneyGreen;
        end;
      StrGrd_Parcela.Canvas.FillRect(Rect); // redesenha a celula
      StrGrd_Parcela.Canvas.TextOut(Rect.Left+2,Rect.Top,StrGrd_Parcela.Cells[acol,arow]); // reimprime o texto.
      // Pega o texto da célula
      Texto := StrGrd_Parcela.Cells[acol, ARow];

      //{ Calcura largura e altura (em pontos) do texto
      LarguraTexto := StrGrd_Parcela.Canvas.TextWidth(Texto);
      AlturaTexto := StrGrd_Parcela.Canvas.TextHeight(Texto);

      // Calcula a posição horizontal do início do texto
      if  (ACol = 3) or (ACol = 4) or (ACol = 5) or (ACol = 7)then // esquerda
        X := Rect.Left + 2
      else
      if  (ACol = 2)  or (ACol = 6) then // Centro
        X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
      else // Direita
        X := Rect.Right - LarguraTexto - 2;

      // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
      Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
      StrGrd_Parcela.Canvas.TextRect(Rect, X, Y, Texto);
      end;
    end;
end;

procedure TFR_RECEBER_BAIXA_LOTE.SB_Add_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For LC_I := 1 to StrGrd_Parcela.RowCount -1 do
    Begin
    StrGrd_Parcela.Cells[9,Lc_I] := 'X';
    end;
  StrGrd_Parcela.Repaint;
end;

procedure TFR_RECEBER_BAIXA_LOTE.SB_Retirar_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For LC_I := 1 to StrGrd_Parcela.RowCount -1 do
    Begin
    StrGrd_Parcela.Cells[9,Lc_I] := '';
    end;
  StrGrd_Parcela.Repaint;
end;

procedure TFR_RECEBER_BAIXA_LOTE.Sb_EmpresaClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(1,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_cd_Cliente.Text := Lc_Retorno.It_Dados[1,0];
    E_cd_ClienteExit(Sender);
  end;
end;

end.
