unit Un_Fich_Fin_Cli;

interface

uses
      Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Grids, DBGrids, StdCtrls, Mask, DBCtrls, ExtCtrls, Db, Buttons, STQuery, Menus, ComCtrls, Un_Fm_ListaMultiEmpresa, Un_Fm_ListaEmpresas, Un_Fm_ListaClientes, base_frame_list;


type
  TFr_Fich_Fin_Cli = class(TForm)
    Qr_Ficha: TSTQuery;
    PopupMenu1: TPopupMenu;
    DetalhesdoPediso1: TMenuItem;
    Qr_Mostra: TSTQuery;
    Ds_Mostra: TDataSource;
    Qr_Conserto: TSTQuery;
    StrGrd_Ficha: TStringGrid;
    GroupBox1: TGroupBox;
    Sb_Sair_0: TSpeedButton;
    SB_Buscar: TSpeedButton;
    Sb_Recibo: TSpeedButton;
    RG_Situacao: TRadioGroup;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Rg_Data: TRadioGroup;
    Fm_LME: TFm_ListaMultiEmpresa;
    Fm_ListaClientes: TFm_ListaClientes;
    Panel1: TPanel;
    pnl_Totais: TPanel;
    Pnl_total_Especifico: TPanel;
    Lb_Vl_Ult_Cpa: TLabel;
    Lb_Vl_Maior_Cpa: TLabel;
    Lb_Med_Atraso: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label26: TLabel;
    Lb_Dt_Ult_Cpa: TLabel;
    Lb_Dt_Maior_Cpa: TLabel;
    Label1: TLabel;
    Lb_Dt_Cadastro: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Lb_Vl_Prazo: TLabel;
    Lb_Vl_Credito: TLabel;
    Lb_Vl_Vencer: TLabel;
    Lb_Vl_Vencida: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Lb_Vl_Pago: TLabel;
    Lb_Vl_Devedor: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Lb_Vl_Chq_pre: TLabel;
    Lb_Vl_Chq_Dev: TLabel;
    Label2: TLabel;
    Lb_Vl_Credor: TLabel;
    Label10: TLabel;
    Lb_Vl_Total: TLabel;
    procedure BtnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_ReciboClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RG_SituacaoClick(Sender: TObject);
    procedure Rg_DataClick(Sender: TObject);
    procedure StrGrd_FichaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StrGrd_FichaDblClick(Sender: TObject);
  private
  { Private declarations } 
    It_VL_Vencer: Currency;
    It_VL_Vencida: Currency;
    It_VL_Credito: Currency;
    It_VL_Pagas: Currency;
    It_Vl_Chq_Pre: Currency;
    It_Vl_Chq_DEv: Currency;
    It_VL_Todas: Currency;
    It_VL_CPA_PRZ: Currency;
    It_Dt_Ultim_CPA : TDate;
    It_Dt_Maior_CPA : TDate;
    It_VL_Ultim_CPA: Currency;
    It_VL_Maior_CPA: Currency;
    It_vl_Saldo: Currency;
    It_Dias_Atraso : Real;
    It_Recibo:Boolean;
    It_Visualizar:Boolean;
    //Dados para o Recibo
    ValorDoRecibo : Real;
    DescricaoRecibo : String;
    procedure getFinanceiroSelecionado;
    public
    { Public declarations }
    IT_qt_recibo:Integer;
    It_Cd_Cliente : Integer;
    It_Nm_Cliente : string;
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariveis;
    procedure PC_Buscar;
    procedure Pc_Analise;
    procedure Pc_PreencheDados;
    function Fc_Verifica_selecionado:Boolean;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;
  end;

var
  Fr_Fich_Fin_Cli: TFr_Fich_Fin_Cli;

implementation

uses     Un_DM, UN_MSG, UN_Sistema, reg_receipt, Un_Nota_Fiscal, UN_Pedido_Vda, Un_Regra_Negocio, UN_Principal, env, RN_Financeiro, RN_Cliente, RN_Empresa, UN_TabelasEmListas;
{$R *.DFM}

procedure TFr_Fich_Fin_Cli.Pc_FormataTela;
Begin
  Pc_PermissaoBotao('Ficha Financeira Cliente');
  //Monta Grid de Valores
  StrGrd_Ficha.ColWidths[0]:=17;
  StrGrd_Ficha.ColWidths[1]:=-1;
  StrGrd_Ficha.ColWidths[2]:=-1;
  StrGrd_Ficha.ColWidths[3]:=-1;
  StrGrd_Ficha.ColWidths[4]:=80;
  StrGrd_Ficha.ColWidths[5]:=180;
  StrGrd_Ficha.ColWidths[6]:=72;
  StrGrd_Ficha.ColWidths[7]:=77;
  StrGrd_Ficha.ColWidths[8]:=100;
  StrGrd_Ficha.ColWidths[9]:=100;
  StrGrd_Ficha.ColWidths[10]:=100;
  StrGrd_Ficha.ColWidths[11]:=-1;   //forma de pagamento
  StrGrd_Ficha.ColWidths[12]:=-1;  //FIN_caixa
  StrGrd_Ficha.ColWidths[13]:=-1;  //operacao
  StrGrd_Ficha.ColWidths[14]:=-1;  // selecionado
  StrGrd_Ficha.ColWidths[15]:=-1;  // FIN_CoDIGO
  StrGrd_Ficha.ColWidths[16]:=-1;  // FIN_CODQTC

  StrGrd_Ficha.Cols[4].Add('Data Emissão');
  StrGrd_Ficha.Cols[5].Add('Parcela');
  StrGrd_Ficha.Cols[6].Add('Vencimento');
  StrGrd_Ficha.Cols[7].Add('Data Pagto');
  StrGrd_Ficha.Cols[8].Add('Débito/Parcela');
  StrGrd_Ficha.Cols[9].Add('Crédito/Pago');
  StrGrd_Ficha.Cols[10].Add('Saldo');


end;

procedure TFr_Fich_Fin_Cli.Pc_IniciaVariveis;
Begin
  Fm_LME.Listar('EMP_NOME');
  Fm_LME.HabilitarMultiEmpresa;
  Qr_Ficha.Close;
  Qr_Mostra.Close;
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
  ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
  fm_ListaClientes.ListaClientes('EMP_NOME');
  fm_ListaClientes.E_Cd_Empresa.Text := InttoStr(It_Cd_Cliente);
  if (fm_ListaClientes.E_Cd_Empresa.Text <> '') then
  Begin
    PC_Buscar;
    Pc_Analise;
    Pc_PreencheDados;
  End;
end;

procedure TFr_Fich_Fin_Cli.BtnSairClick(Sender: TObject);
begin
close;
end;

procedure TFr_Fich_Fin_Cli.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  Fr_Fich_Fin_Cli:=Nil;
end;

procedure TFr_Fich_Fin_Cli.PC_Buscar;
Var
  SqlTxt : String;
  Lc_Cliente : Boolean;
begin
  Screen.Cursor:=crHourGlass;
  sqltxt:= '';
  Qr_Ficha.Active := False;
  Qr_Ficha.SQL.Clear;
  Qr_Mostra.Active := False;
  Qr_Mostra.SQL.Clear;

  SqlTxt := ' SELECT FIN_CODQTC, FIN_DT_VENCIMENTO, FIN_DT_PAGTO, FIN_CODEMP, EMP_NOME,EMP_VL_CRED,EMP_DT_CADASTRO,'+
            ' EMP_FANTASIA,FIN_CODIGO, '+
            ' END_FONE, END_REGIAO, FIN_NUMERO, EMP_NOME as NOMEEMITENTE,FIN_VL_PARCELA, FIN_VL_PAGO,FIN_DATA,   '+
            ' FIN_CODFPG,FIN_BAIXA,FIN_OPERACAO, FIN_CODMHA,FIN_CODPED,NFL_VL_TL_NOTA,FIN_CODNFL,PED_NUMERO      '+
            ' FROM '+
            '   TB_FINANCEIRO Tb_financeiro '+
            '   INNER JOIN TB_EMPRESA Tb_empresa '+
            '   ON  (Tb_empresa.EMP_CODIGO = Tb_financeiro.FIN_CODEMP) '+
            '   INNER JOIN tb_nota_fiscal tb_nota_fiscal '+
            '   ON (tb_nota_fiscal.nfl_codigo = tb_financeiro.fin_codnfl) '+
            '   left outer JOIN tb_pedido tb_pedido '+
            '   ON (tb_pedido.ped_codigo = tb_nota_fiscal.nfl_codped) '+
            '   LEFT OUTER JOIN TB_ENDERECO tb_endereco '+
            '   ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND) '+
            'WHERE ((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'')) ';

  if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
    SqlTxt := SqlTxt + ' AND (FIN_CODMHA =:FIN_CODMHA) ' ;


  if (Fm_ListaClientes.e_cd_Empresa.Text = '') then Lc_Cliente := False else Lc_Cliente := True;
  if ChBx_Periodo.Checked then
    Begin
    IF Rg_Data.ItemIndex = 0 then
      SqlTxt := SqlTxt + 'AND (FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM)'
    else
      SqlTxt := SqlTxt + 'AND (FIN_DT_PAGTO BETWEEN :DATAINI AND :DATAFIM)';
    end;

  IF Lc_Cliente then SqlTxt := SqlTxt + 'AND  (FIN_CODEMP =:FIN_CODEMP) ';
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

  if Lc_Cliente then Qr_Ficha.ParamByName('FIN_CODEMP').AsString := Fm_ListaClientes.e_cd_Empresa.Text;
  if Lc_Cliente then Qr_Mostra.ParamByName('FIN_CODEMP').AsString := Fm_ListaClientes.e_cd_Empresa.Text;

  IF RG_Situacao.ItemIndex < 2 then Qr_Ficha.ParamByName('FIN_DT_VENCIMENTO').AsDateTime := Date;
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

procedure TFr_Fich_Fin_Cli.PC_Analise;
Var
  Lc_Contador :Integer;
  Lc_I, Lc_J : Integer;
Begin
  // Zerando as Variaveis
  It_VL_Vencer := 0;
  It_VL_Vencida := 0;
  It_VL_Pagas := 0;
  It_VL_Todas := 0;
  It_VL_CPA_PRZ := 0;
  It_Dt_Ultim_CPA := Date;
  It_Dt_Maior_CPA := Date;
  It_VL_Ultim_CPA := 0;
  It_VL_Maior_CPA := 0;
  It_Dias_Atraso := 0;
  It_vl_Saldo := 0;
  Pc_LimpaStringGrid(StrGrd_Ficha);

  with Qr_Ficha,StrGrd_Ficha do
  Begin
    //Primeiros Valores
    if RecordCount > 0 then
    Begin
      It_Dt_Ultim_CPA := StrToDateDef(FieldByName('FIN_DATA').AsString,Date);
      It_Dt_Maior_CPA := StrToDateDef(FieldByName('FIN_DATA').AsString,Date);
      It_VL_Ultim_CPA := FieldByName('NFL_VL_TL_NOTA').AsCurrency;
      It_VL_Maior_CPA := FieldByName('NFL_VL_TL_NOTA').AsCurrency;
      Lc_Contador := 1;
    end;

    while not eof do
    begin
      //Preenche a Grade
      RowCount := Lc_Contador + 1;
      Cells[1,Lc_Contador] := FieldByName('FIN_CODPED').AsString;
      Cells[2,Lc_Contador] := FieldByName('FIN_CODNFL').AsString;
      Cells[3,Lc_Contador] := FieldByName('PED_NUMERO').AsString;
      Cells[4,Lc_Contador] := FieldByName('FIN_DATA').AsString;
      Cells[5,Lc_Contador] := FieldByName('FIN_NUMERO').AsString;
      Cells[6,Lc_Contador] := FieldByName('FIN_DT_VENCIMENTO').AsString;
      Cells[7,Lc_Contador] := FieldByName('FIN_DT_PAGTO').AsString;
      IF FieldByName('FIN_OPERACAO').AsString = 'C' then
      Begin
        Cells[8,Lc_Contador] := FloatToStrF(FieldByName('FIN_VL_PARCELA').AsCurrency,ffNumber,10,2);
        Cells[9,Lc_Contador] := FloatToStrF(FieldByName('FIN_VL_PAGO').AsCurrency,ffNumber,10,2);
        It_vl_Saldo := It_vl_Saldo + ( FieldByName('FIN_VL_PARCELA').AsCurrency - FieldByName('FIN_VL_PAGO').AsCurrency);
        if It_vl_Saldo < 0 then
          Cells[10,Lc_Contador] := FloatToStrF(It_vl_Saldo * -1 ,ffFixed,10,2)
        else
          Cells[10,Lc_Contador] := FloatToStrF(It_vl_Saldo,ffFixed,10,2)
      end
      else
      Begin
        Cells[8,Lc_Contador] := '0,00';
        Cells[9,Lc_Contador] := FloatToStrF(FieldByName('FIN_VL_PARCELA').AsCurrency,ffNumber,10,2);
        It_vl_Saldo := It_vl_Saldo - ( FieldByName('FIN_VL_PARCELA').AsCurrency - FieldByName('FIN_VL_PAGO').AsCurrency);
        if It_vl_Saldo < 0 then
          Cells[10,Lc_Contador] := FloatToStrF(It_vl_Saldo * -1,ffFixed,10,2)
        else
          Cells[10,Lc_Contador] := FloatToStrF(It_vl_Saldo,ffFixed,10,2);
      end;
      Cells[11,Lc_Contador] := FieldByName('FIN_CODFPG').AsString;
      Cells[12,Lc_Contador] := FieldByName('FIN_BAIXA').AsString;
      Cells[13,Lc_Contador] := FieldByName('FIN_OPERACAO').AsString;
      Cells[14,Lc_Contador] := '0';
      Cells[15,Lc_Contador] := IntToStr( FieldByName('FIN_CODIGO').AsInteger);
      Cells[16,Lc_Contador] := IntToStr( FieldByName('FIN_CODQTC').AsInteger);
      //Media Atraso
      if Length(FieldByName('FIN_DT_PAGTO').AsString) > 0 then
      Begin
        It_Dias_Atraso := It_Dias_Atraso + (FieldByName('FIN_DT_PAGTO').value - FieldByName('FIN_DT_VENCIMENTO').value )
      end
      else
      begin
        if FieldByName('FIN_DT_VENCIMENTO').AsDateTime < date then
          It_Dias_Atraso := It_Dias_Atraso + (Date - FieldByName('FIN_DT_VENCIMENTO').value);
      end;

      if ( FieldByName('FIN_CODFPG').AsInteger > 0) then
      Begin
        //Maior Vendas
        if (It_VL_Maior_CPA < FieldByName('NFL_VL_TL_NOTA').AsCurrency) then
        begin
          It_VL_Maior_CPA := FieldByName('NFL_VL_TL_NOTA').AsCurrency;
          It_Dt_Maior_CPA := FieldByName('FIN_DATA').asDateTime;
        end;

          //Ultima Vendas
        if (It_Dt_Ultim_CPA < FieldByName('FIN_DATA').asDateTime) then
        begin
          It_VL_Ultim_CPA := FieldByName('NFL_VL_TL_NOTA').AsCurrency;
          It_Dt_Ultim_CPA := FieldByName('FIN_DATA').asDateTime;
        end;

        //Duplicatas a Prazo
        if (FieldByName('FIN_DATA').AsString <> FieldByName('FIN_DT_VENCIMENTO').AsString)then
        Begin
          It_VL_CPA_PRZ := It_VL_CPA_PRZ + FieldByName('FIN_VL_PARCELA').AsCurrency;
        end;
      end;

      //Duplicatas Quitadas
      if ( FieldByName('FIN_BAIXA').AsString='S') THEN
      Begin
        It_VL_Pagas := It_VL_Pagas + FieldByName('FIN_VL_PAGO').AsCurrency;
      end;

      //Duplicatas a Vencer
      if (FieldByName('FIN_DT_VENCIMENTO').AsDateTime >= Date) and ( FieldByName('FIN_BAIXA').AsString = 'N')  and  ( FieldByName('FIN_OPERACAO').AsString ='C') then
      Begin
        It_VL_Vencer := It_VL_Vencer + FieldByName('FIN_VL_PARCELA').AsCurrency - FieldByName('FIN_VL_PAGO').AsCurrency;
      end;

      //Duplicatas a Vencidas
      if (Qr_Ficha.FieldByName('FIN_DT_VENCIMENTO').asDateTime < Date) and (Qr_Ficha.FieldByName('FIN_BAIXA').AsString='N')   and  (Qr_Ficha.FieldByName('FIN_OPERACAO').AsString ='C')then
      Begin
        It_VL_Vencida := It_VL_Vencida + FieldByName('FIN_VL_PARCELA').AsCurrency - FieldByName('FIN_VL_PAGO').AsCurrency;
      end;

      Next;
      Inc(Lc_Contador);
    end;
    IF Lc_Contador > 2 then
      Lb_Med_Atraso.Caption   := FloatToStrF((It_Dias_Atraso /(Lc_Contador - 1 )),ffNumber,18,0);
    Screen.Cursor:=crDefault;
  End;
end;

procedure TFr_Fich_Fin_Cli.Pc_PreencheDados;
Begin
  Lb_Vl_Credito.caption   := FloatToStrF(fm_ListaClientes.Qr_ListaEmpresa.FieldByName('EMP_VL_CRED').AsCurrency,ffNumber,18,2);
  Lb_Dt_Cadastro.Caption  := fm_ListaClientes.Qr_ListaEmpresa.FieldByName('EMP_DT_CADASTRO').AsString;
  Lb_Vl_Prazo.Caption     := FloatToStrF(It_VL_CPA_PRZ,ffNumber,18,2);
  Lb_Vl_Pago.Caption      := FloatToStrF(It_VL_Pagas,ffNumber,18,2);

  //Cheque Pre-Datado
  It_Vl_Chq_Pre := Fc_SaldoChequePreDatado(StrToIntDef(fm_ListaClientes.E_Cd_Empresa.Text,0));
  if It_Vl_Chq_Pre > 0 then
    Lb_Vl_Chq_pre.Caption := FloatToStrF(It_Vl_Chq_Pre,ffFixed, 10, 2)
  else
    Lb_Vl_Chq_pre.Caption := '0,00';

  Lb_Vl_Vencer.Caption    := FloatToStrF(It_VL_Vencer,ffNumber,18,2);
  Lb_Vl_Vencida.Caption   := FloatToStrF(It_VL_Vencida,ffNumber,18,2);
  Lb_Vl_Devedor.Caption   := FloatToStrF(It_VL_Vencer + It_VL_Vencida,ffNumber,18,2);

  //Saldo Credor
  It_vl_Credito := Fc_SaldoCredorCliente(StrToIntDef(fm_ListaClientes.E_Cd_Empresa.Text,0));
  Lb_Vl_Credor.Caption   := FloatToStrF(It_VL_Credito,ffNumber,18,2);

  Lb_Vl_Total.Caption   := FloatToStrF((It_VL_Vencer + It_VL_Vencida) - It_VL_Credito,ffNumber,18,2);

  //Cheque Devolvido
  It_Vl_Chq_DEv := Fc_SaldoChequeDevolvido(StrToIntDef(fm_ListaClientes.E_Cd_Empresa.Text,0));
  if It_Vl_Chq_DEv > 0 then
    Lb_Vl_Chq_Dev.Caption := FloatToStrF(It_Vl_Chq_DEv,ffFixed, 10, 2)
  else
    Lb_Vl_Chq_Dev.Caption := '0,00';

  Lb_Dt_Ult_Cpa.Caption   := DateToStr(It_Dt_Ultim_CPA);
  Lb_Vl_Ult_Cpa.Caption   := FloatToStrF(It_VL_Ultim_CPA,ffNumber,18,2);
  Lb_Dt_Maior_Cpa.Caption := DateToStr(It_Dt_Maior_CPA);
  Lb_Vl_Maior_Cpa.Caption := FloatToStrF(It_VL_Maior_CPA,ffNumber,18,2);
end;


procedure TFr_Fich_Fin_Cli.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFr_Fich_Fin_Cli.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Fich_Fin_Cli.SB_BuscarClick(Sender: TObject);
begin
  Pnl_total_Especifico.Visible := (trim(Fm_ListaClientes.E_Cd_Empresa.Text) <> '');
  Fm_ListaClientes.E_Cd_EmpresaExit(Self);
  PC_Buscar;
  Pc_Analise;
  Pc_PreencheDados;
end;

procedure TFr_Fich_Fin_Cli.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;

end;

procedure TFr_Fich_Fin_Cli.Sb_ReciboClick(Sender: TObject);
Var
  Lc_Form : TRegReceipt;
begin
  if Fc_Verifica_selecionado then
  Begin
    TRy
      Pc_AtivaEstabelecimento;
      getFinanceiroSelecionado;
      Lc_Form := TRegReceipt.create(nil);
      Lc_Form.Recibo.Registro.Valor  := ValorDoRecibo;
      Lc_Form.Recibo.Registro.Emitente := DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString;
      Lc_Form.Recibo.Registro.sacado     := fm_ListaClientes.DBLCB_Empresa.Text;
      Lc_Form.Recibo.Registro.Referencia := 'Pagamento do(s) pedido(s) ' + DescricaoRecibo;
      Lc_Form.Recibo.Registro.Data       := Date;
      Lc_Form.autofill      := True;
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
      SB_BuscarClick(SELF);
    End;
  End;
end;

procedure TFr_Fich_Fin_Cli.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;


procedure TFr_Fich_Fin_Cli.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_ImagemBotao;
  Pc_IniciaVariveis;
end;

procedure TFr_Fich_Fin_Cli.getFinanceiroSelecionado;
var
  lc_registro:Integer;
begin
  ValorDoRecibo := 0;
  DescricaoRecibo := '';
  for lc_registro := 1 to StrGrd_Ficha.rowCount DO
  begin
    if StrGrd_Ficha.Cells[14,lc_registro] = 'X' then
    BEGIN
      IF StrGrd_Ficha.Cells[13,lc_registro] = 'C' then
        ValorDoRecibo := ValorDoRecibo + StrToFloatDef(StrGrd_Ficha.Cells[8,lc_registro],0)
      ELSE
        ValorDoRecibo := ValorDoRecibo - StrToFloatDef(StrGrd_Ficha.Cells[9,lc_registro],0);
      if lc_registro = 1 then
        DescricaoRecibo:= StrGrd_Ficha.Cells[5,lc_registro]
      else
        DescricaoRecibo:= concat(DescricaoRecibo,' \ ',StrGrd_Ficha.Cells[5,lc_registro]);
    END;
  END;
end;

procedure TFr_Fich_Fin_Cli.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    Sb_Recibo.Glyph.Assign(Fc_CarregaImagemBotao('FATURAR'));
    SB_Buscar.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Fich_Fin_Cli.RG_SituacaoClick(Sender: TObject);
begin
  case RG_Situacao.ItemIndex of
    0:Rg_Data.ItemIndex := 0;
    1:Rg_Data.ItemIndex := 0;
    2:Rg_Data.ItemIndex := 1;
  end;
end;

procedure TFr_Fich_Fin_Cli.Rg_DataClick(Sender: TObject);
begin
  if Rg_Data.ItemIndex = 1 then
    RG_Situacao.ItemIndex := 2
  else
    RG_Situacao.ItemIndex := 0;
end;

procedure TFr_Fich_Fin_Cli.StrGrd_FichaDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
    Begin
    if (StrGrd_Ficha.Cells[12,arow]='N') AND (StrGrd_Ficha.Cells[13,arow]='C') then
      begin // verifica se a linha impar
      StrGrd_Ficha.Canvas.Font.Color:= clRed;
      end
    else
      begin
      if (StrGrd_Ficha.Cells[13,arow]='D') then
        begin // verifica se a linha impar
        StrGrd_Ficha.Canvas.Font.Color:= clGreen;
         end
      else
        Begin
        StrGrd_Ficha.Canvas.Font.Color:= clNavy;
         end;
      end;

   if (StrGrd_Ficha.Cells[14,arow]='X') then
     StrGrd_Ficha.Canvas.Brush.Color:= clBtnFace
   ELSE
     StrGrd_Ficha.Canvas.Brush.Color:= clCream;


  StrGrd_Ficha.Canvas.FillRect(Rect); // redesenha a celula
  StrGrd_Ficha.Canvas.TextOut(Rect.Left+2,Rect.Top,StrGrd_Ficha.Cells[acol,arow]); // reimprime o texto.


  { Pega o texto da célula }
  Texto := StrGrd_Ficha.Cells[acol, ARow];

  { Calcura largura e altura (em pontos) do texto }
  LarguraTexto := StrGrd_Ficha.Canvas.TextWidth(Texto);
  AlturaTexto := StrGrd_Ficha.Canvas.TextHeight(Texto);


  { Calcula a posição horizontal do início do texto }
  if  (ACol = 4) or (ACol = 5) then { esquerda }
    X := Rect.Left + 2
  else if  (ACol = 6) or (ACol = 7) then { Centro }
    X := Rect.Left + (Rect.Right - Rect.Left) div 2 -
      LarguraTexto div 2
  else { Direita }
    X := Rect.Right - LarguraTexto - 2;


  { Calcula a posição vertical do início do texto para
    que seja impresso no centro (verticalmente) da célula }
  Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -
    AlturaTexto div 2;

  { Pinta o texto }
  StrGrd_Ficha.Canvas.TextRect(Rect, X, Y, Texto);
    END;
end;

procedure TFr_Fich_Fin_Cli.StrGrd_FichaDblClick(Sender: TObject);
begin

  if (StrGrd_Ficha.Cells[16,StrGrd_Ficha.Row] > '0') then
  Begin
   MensagemPadrao( TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Financeiro já Destinado.'+EOLN+
                   'Selecione algum e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpErro);
   exit;
  end;
  if (StrGrd_Ficha.Cells[14,StrGrd_Ficha.Row] = '0') AND (StrGrd_Ficha.Cells[16,StrGrd_Ficha.Row] = '0') then
    StrGrd_Ficha.Cells[14,StrGrd_Ficha.Row] :=  'X'
  else
   BEGIN
   StrGrd_Ficha.Cells[14,StrGrd_Ficha.Row] := '0';
   end;
  StrGrd_Ficha.Repaint;
end;

function TFr_Fich_Fin_Cli.Fc_Verifica_selecionado: Boolean;
var
  Lc_I : Integer;
  Lc_Selecionado : Integer;
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

  if ( Fm_ListaClientes.DBLCB_Empresa.Text = '' ) then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Para garantir a emissãoo do recibo por favor seleciona um cliente.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpErro);
    Result:= False;
    exit;
  End;
  Lc_Selecionado := 0;
  for Lc_I := 1 to Qr_Ficha.RecordCount DO
  begin
    if StrGrd_Ficha.Cells[14,lc_I] = 'X' then
    begin
      Lc_Selecionado := Lc_Selecionado  + 1;
    end;
  end;
  if ( Lc_Selecionado = 0) then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Nenhum Financeiro foi escolhido.'+EOLN+
                   'Selecione algum e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpErro);
    Result:= False;
    exit;
  End;




end;

procedure TFr_Fich_Fin_Cli.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Recibo:= True;
    It_Visualizar:=true;
    end
  else
    begin
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    if not It_Visualizar then exit;
    It_Recibo     := Fc_HabilitaPermissao(Pc_Menu,'RECIBO','S');    
    end;
    Sb_Recibo.Enabled:=It_Recibo;
end;


end.



