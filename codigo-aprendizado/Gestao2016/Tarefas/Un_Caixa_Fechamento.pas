unit Un_Caixa_Fechamento;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.Grids, Data.DB, STQuery, Vcl.DBGrids, Vcl.Buttons, Vcl.DBCtrls, tblCashier, ControllerUsuario, Vcl.ComCtrls, ControllerREtornoNFCE, ControllerPayBAck;

type
  TFr_Caixa_Fechamento = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    E_Dt_Caixa: TMaskEdit;
    Label2: TLabel;
    E_Nome_Usuario: TMaskEdit;
    Panel2: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    Label3: TLabel;
    Dbg_Vendas: TDBGrid;
    Qr_Vendas: TSTQuery;
    Ds_Venda: TDataSource;
    Qr_VendasPED_CODVDO: TIntegerField;
    Qr_VendasFPT_DESCRICAO: TStringField;
    Label4: TLabel;
    Dbg_Creditos: TDBGrid;
    Label5: TLabel;
    Dbg_Debitos: TDBGrid;
    Qr_Creditos: TSTQuery;
    Ds_Credito: TDataSource;
    Qr_CreditosMVF_CODUSU: TIntegerField;
    Qr_CreditosFPT_DESCRICAO: TStringField;
    Qr_CreditosTOTAL: TBCDField;
    Qr_Debitos: TSTQuery;
    IntegerField1: TIntegerField;
    IBStringField1: TStringField;
    IBBCDField1: TBCDField;
    Ds_Debito: TDataSource;
    Label6: TLabel;
    Grp_Transferencia: TGroupBox;
    Label7: TLabel;
    DBLCB_Usuario: TDBLookupComboBox;
    Qr_Acao: TSTQuery;
    E_TL_VL_Credito: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    E_TL_VL_Vendas: TEdit;
    Label10: TLabel;
    E_TL_VL_Debito: TEdit;
    Label11: TLabel;
    E_TL_VL_Registrado: TEdit;
    Qr_ValoresCaixa: TSTQuery;
    Ds_ValoresCaixa: TDataSource;
    Qr_ValoresCaixaMVF_CODFPT: TIntegerField;
    Qr_ValoresCaixaFPT_DESCRICAO: TStringField;
    Qr_ValoresCaixaMVF_VALOR: TBCDField;
    Label12: TLabel;
    E_TL_VL_Digitado: TEdit;
    Qr_ValoresCaixaMVL_DIGITADO: TStringField;
    StrGrd_Valores: TStringGrid;
    Qr_VendasTotal: TFloatField;
    Qr_VendasTOTALPAGO: TBCDField;
    Qr_VendasTOTALPAGAR: TBCDField;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Label13: TLabel;
    bt_AtualizaResumoVendas: TButton;
    procedure SB_ConfirmarClick(Sender: TObject);
    Procedure Pc_FormaTela;
    procedure Pc_Totaliza_Formas_Pagto;
    procedure SetGridFocus(SGrid: TStringGrid; Linha, Coluna: integer);
    procedure Pc_PreencherValoresCaixa;
    procedure Pc_IniciaVariaveis;
    procedure Pc_AtivarTabelas;
    procedure FormShow(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure StrGrd_ValoresDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StrGrd_ValoresSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure StrGrd_ValoresSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Qr_VendasCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure bt_AtualizaResumoVendasClick(Sender: TObject);
  private
    { Private declarations }
    procedure RegistraCreditosExpirados;
    procedure Pc_AbreDadosVendas;
    procedure Pc_TotalizaVendas;
    procedure Pc_AbreTotalCredito;
    procedure Pc_TotalizaCreditos;
    procedure Pc_AbreTotalDebitos;
    procedure Pc_TotalizaDEbito;

    function Fc_Valida():Boolean;
    procedure Pc_FechaCaixaNormal;

    procedure Pc_FechaCaixaTransferencia;

    procedure Pc_InsereValorCaixaTranferencia(Pc_Indice:Integer);
    procedure Pc_RetiraValorCaixa(pc_Tipo:String;Pc_Indice:Integer);
    procedure Pc_EncerraCaixa;


    procedure Pc_ImagemBotao;
  public
    { Public declarations }
    Usuario : TControllerUsuario;
  end;

var
  Fr_Caixa_Fechamento: TFr_Caixa_Fechamento;

implementation

{$R *.dfm}

uses     Un_DM, Un_Regra_Negocio, UN_Sistema, Un_Msg, RN_Financeiro, Un_Funcoes, UN_Principal, env, Un_Fc_Sored_Procedures, tblCashierItems, ControllerDskCashier, RI_MovimentoFinanceiro;
procedure TFr_Caixa_Fechamento.Pc_FechaCaixaTransferencia;
Var
  I :Integer;
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja executar esta operação de Transferência no Caixa.' + EOLN + EOLN +
                     'Confirmar a Transferência ?',
                     [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clRed) = mrBotao1) then
  Begin
    with StrGrd_Valores do
    Begin
      for I := 1 to RowCount - 1 do
      Begin
        Pc_RetiraValorCaixa('TRANSFERÊNCIA',I);
        Pc_InsereValorCaixaTranferencia(I);
      End;
    End;
    RegistraCreditosExpirados;
    Pc_EncerraCaixa;
  End;
end;

procedure TFr_Caixa_Fechamento.Pc_FormaTela;
Var
  Lc_I : Integer;
begin
  with StrGrd_Valores,Qr_ValoresCaixa do
  Begin
    ColCount := FieldCount + 1;
    ColWidths[0]:=17;
    ColWidths[1]:=-1;
    For Lc_I:= 0 to FieldCount -1 do
    Begin
      ColWidths[Lc_I + 1]:= Fields[Lc_I].Tag;
      Cols[Lc_I + 1].Add(Fields[Lc_I].DisplayLabel);
    end;
  end;
  Pc_ImagemBotao;
end;


procedure TFr_Caixa_Fechamento.Pc_Totaliza_Formas_Pagto;
Var
  Lc_Data : TDateTime;
begin
  with Qr_ValoresCaixa do
  Begin
    Active := False;
    ParamByName('MVF_CODUSU').AsInteger := GB_Cd_Usuario;
    ParamByName('MVF_CODMHA').AsInteger := Gb_CodMha;
    Active := True;
    FetchAll;
  End;
end;

procedure TFr_Caixa_Fechamento.Qr_VendasCalcFields(DataSet: TDataSet);
begin
  if Qr_VendasTOTALPAGO.AsCurrency > 0 then
    Qr_VendasTOTAL.AsCurrency := Qr_VendasTOTALPAGO.AsCurrency
  else
    Qr_VendasTOTAL.AsCurrency := Qr_VendasTOTALPAGAR.AsCurrency;
end;

procedure TFr_Caixa_Fechamento.RegistraCreditosExpirados;
Var
  Lc_Dias : Integer;
  Lc_PayBack : TControllerPayBAck;
begin
  TRY
    //PEga dados de configuração
    Lc_PayBack := TControllerPayBAck.Create(nil);
    Lc_PayBack.Parametros.Dias := StrToIntDef(Fc_Tb_Geral('L','PAYBACK_DT_EXPIRED','365'),365);
    Lc_PayBack.Parametros.ValorMinimo := StrToFloatDEf(Fc_Tb_Geral('L','PAYBACK_VL_MINIMO','0'),0.0);
    Lc_PayBack.Parametros.Estabelecimento := Gb_CodMha;
    Lc_PayBack.Parametros.Terminal := Gb_Terminal;

    Lc_PayBack.Parametros.PayBack.Historico := 'Expirado';
    Lc_PayBack.Parametros.PayBack.Data := Date - Lc_PayBack.Parametros.Dias;
    Lc_PayBack.RegistraCreditoExpirado;

  Finally
    FreeAndNil(Lc_PayBack);
  end;
end;

procedure TFr_Caixa_Fechamento.SetGridFocus(SGrid: TStringGrid; Linha, Coluna: integer);
var
  SRect: TGridRect;
begin
  with SGrid do
  begin
    SetFocus;
    Row := Linha;
    Col := Coluna;
    SRect.Top := Linha;
    SRect.Left := Coluna;
    SRect.Bottom := Linha;
    SRect.Right := Coluna;
    Selection := SRect;
  end;
end;

procedure TFr_Caixa_Fechamento.Pc_PreencherValoresCaixa;
Var
  Lc_I,Lc_J : Integer;
  Lc_registro : Integer;
  Lc_Valor : Double;
Begin
  with Qr_ValoresCaixa,StrGrd_Valores do
  Begin

    First;
    Lc_registro := 0;
    Lc_Valor := 0;
    while not Eof do
    Begin
      Lc_registro := Lc_registro + 1;
      RowCount := Lc_registro + 1;
      For Lc_I:= 0 to FieldCount -1 do
      Begin
        if (Fields.Fields[Lc_I].DataType = ftFloat) OR (Fields.Fields[Lc_I].DataType = ftBCD) then
          Cells[Lc_I + 1,Lc_registro] := FloatToStrF(Fields[Lc_I].AsFloat,ffNumber,15,2)
        else
          Cells[Lc_I + 1,Lc_registro] := Fields[Lc_I].AsString;
      End;
      Lc_Valor := Lc_Valor  + FieldByName('MVF_VALOR').VAlue;
      Next;
    end;
    E_TL_VL_Registrado.Text := FloatToStrF(Lc_Valor,ffNumber,15,2);
    SetGridFocus(StrGrd_Valores,1,4);
    Repaint;
  end;
end;

procedure TFr_Caixa_Fechamento.bt_AtualizaResumoVendasClick(Sender: TObject);
begin
  Pc_AbreDadosVendas;
  Pc_TotalizaVendas;
end;

function TFr_Caixa_Fechamento.Fc_Valida: Boolean;
Var
  Lc_Nfce : TControllerREtornoNFCE;
  I : Integer;
  Lc_Result : Boolean;
begin
  Result := True;
  if ( Fc_Tb_Geral('L','NFE_BLOQUEIA_FECHA_CAIXA','S') = 'S' ) then
  Begin
    try
      Lc_Result := False;
      Lc_Nfce := TControllerREtornoNFCE.create(Nil);
      Lc_Nfce.Estabel := Gb_CodMha;
      Lc_Nfce.DataInicial := Gb_DataCaixa;
      Lc_Nfce.DataFinal := Gb_DataCaixa;
      Lc_Result := Lc_Nfce.VerificaPendentesNumeradas;
    finally
      FreeAndNil(Lc_Nfce);
    end;

    if Lc_Result then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Foram encontradas Notas Numeradas Pendentes de Autorização.' + EOLN +
                     'Por favor Autorize as Notas para continuar.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      exit;
    End;
  End;

  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja efetuar o fechamento do caixa.'+EOLN+
                     'Data    : ' + E_Dt_Caixa.Text + '.'+EOLN+
                     'Usuário : ' + GB_Nm_Usuario + '.'+EOLN+
                     'Confirmar o Fechamento ?',
                     [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao2) then
  Begin
    Result := False;
    exit;
  End;
end;

procedure TFr_Caixa_Fechamento.FormCreate(Sender: TObject);
begin
  Usuario := TControllerUsuario.Create(self);
end;

procedure TFr_Caixa_Fechamento.FormShow(Sender: TObject);
begin
  Pc_FormaTela;
  Pc_IniciaVariaveis;
  Pc_AtivarTabelas;
end;

procedure TFr_Caixa_Fechamento.Pc_AbreDadosVendas;
Var
  Lc_cd_VEndedor : Integer;
begin
  Usuario.Registro.Codigo := GB_Cd_Usuario;
  Lc_cd_VEndedor := Usuario.getVendedorID;
  with Qr_Vendas do
  Begin
    active := False;
    SQL.Clear;
    SQL.Add('select ped_codvdo, fp.fpt_descricao, CAST(Sum(coalesce(fnc.fin_vl_pago,0)) AS NUMERIC(18, 2)) TotalPago, CAST(Sum(coalesce(fnc.fin_vl_parcela,0)) AS NUMERIC(18, 2)) TotalPagar '+
            'from tb_nota_fiscal nf '+
            '  inner join tb_pedido '+
            '  on (ped_codigo = nfl_codped) '+
            '  inner join tb_financeiro fnc '+
            '  on (fnc.fin_codnfl = nfl_codigo) '+
            '  inner join tb_formapagto fp '+
            '  on (fp.fpt_codigo = fnc.fin_codfpg) '+
            'where ( nf.nfl_dt_emissao between :DATAINI AND :DATAFIM ) and fnc.fin_tipo = ''RA'' ');
    if Lc_cd_VEndedor > 0 then
      SQL.Add('and ( ped_codvdo =:ped_codvdo )');
    SQL.Add('group by 1,2'+
            'order by 2 ');
    parambyname('DATAINI').asDate := E_Data_Ini.DateTime;
    parambyname('DATAFIM').asDate := E_Data_Fim.DateTime;
    if Lc_cd_VEndedor > 0 then
      parambyname('PED_CODVDO').asInteger := Lc_cd_VEndedor;
    active := True;
  End;
end;

procedure TFr_Caixa_Fechamento.Pc_TotalizaVendas;
Var
  Lc_Valor : Real;
begin
  with Qr_Vendas do
  Begin
    First;
    Lc_Valor :=0;
    while not eof do
    Begin
      Lc_Valor := Lc_Valor + FieldByName('TOTAL').AsCurrency;
      next;
    End;
    E_TL_VL_Vendas.Text := FloatToStrF(Lc_Valor,ffNumber,15,2);
  End;


end;
procedure TFr_Caixa_Fechamento.Pc_AbreTotalCredito;
begin
  with Qr_Creditos do
  Begin
    active := False;
    SQL.Clear;
    SQL.Add('select cx.mvf_codusu, fp.fpt_descricao, CAST(sum(cx.mvf_vl_credito) AS NUMERIC(18, 2)) total '+
            'from tb_movim_financeiro cx '+
            '  inner join tb_formapagto fp '+
            '  on (fp.fpt_codigo = cx.mvf_codfpt) '+
            'where cx.mvf_codctb = 0 '+
            'and ( cx.mvf_data =:mvf_data ) '+
            'and ( cx.mvf_vl_credito > 0 ) '+
            'and ( cx.mvf_codmha =:mvf_codmha ) ');
    if GB_Cd_Usuario > 0 then
      SQL.Add('and ( cx.mvf_codusu =:mvf_codusu ) ');

    SQL.Add('group by 1,2 '+
            'order by 2 ');
    parambyname('mvf_data').asDate := Gb_DataCaixa;
    if GB_Cd_Usuario > 0 then
      parambyname('mvf_codusu').asInteger := GB_Cd_Usuario;
    parambyname('mvf_codmha').asInteger := Gb_Codmha;
    active := True;
  End;
end;

procedure TFr_Caixa_Fechamento.Pc_TotalizaCreditos;
Var
  Lc_Valor : Real;
begin
  with Qr_Creditos do
  Begin
    First;
    Lc_Valor :=0;
    while not eof do
    Begin
      Lc_Valor := Lc_Valor + FieldByName('TOTAL').AsCurrency;
      next;
    End;
    E_TL_VL_Credito.Text := FloatToStrF(Lc_Valor,ffNumber,15,2);
  End;


end;

procedure TFr_Caixa_Fechamento.Pc_AbreTotalDebitos;
begin
  with Qr_Debitos do
  Begin
    active := False;
    parambyname('mvf_data').asDate := Gb_DataCaixa;
    parambyname('mvf_codusu').asInteger := GB_Cd_Usuario;
    parambyname('mvf_codmha').asInteger := Gb_Codmha;
    active := True;
  End;
end;


procedure TFr_Caixa_Fechamento.Pc_TotalizaDEbito;
Var
  Lc_Valor : Real;
begin
  with Qr_Debitos do
  Begin
    First;
    Lc_Valor :=0;
    while not eof do
    Begin
      Lc_Valor := Lc_Valor + FieldByName('TOTAL').AsCurrency;
      next;
    End;
    E_TL_VL_Debito.Text := FloatToStrF(Lc_Valor,ffNumber,15,2);
  End;
end;


procedure TFr_Caixa_Fechamento.Pc_AtivarTabelas;
begin
  DM.Qr_ListaUsuario.active := True;
end;

procedure TFr_Caixa_Fechamento.Pc_EncerraCaixa;
Var
  Lc_Cashier : TControllerDskCashier;
begin
  Lc_Cashier := TControllerDskCashier.Create(Self);
  Lc_Cashier.Registro.Codigo := Gb_CodigoCaixa;
  Lc_Cashier.Registro.Data := Gb_DataCaixa;
  Lc_Cashier.Registro.Usuario := GB_Cd_Usuario;
  //Para o Caso de Pizzaria quando se quer zerar os numeros dos pedidos
  if (Lc_Cashier.FecharCaixa(StrGrd_Valores)) then
  Begin
    if (Fc_Tb_Geral('L','PIZ_ZERA_PEDIDO_CXA','S') = 'S') then
    Begin
      Lc_Cashier.setGenerator('GN_PEDIDO_VDA','0');
    End;
    MensagemPadrao(MENSAGEM,'S U C E S S O O!.'+EOLN+EOLN+
                   'O Caixa foi finalizado com sucesso.'+EOLN+EOLN,
                   ['OK'],[bEscape],mpInformacao);
    Close;
  End;
end;


procedure TFr_Caixa_Fechamento.Pc_FechaCaixaNormal;
Var
  I :Integer;
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja executar o Fechamento do Caixa.' + EOLN + EOLN +
                     'Confirmar a operação ?',
                     [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clRed) = mrBotao1) then
  Begin
    with StrGrd_Valores do
    Begin
      for I := 1 to RowCount - 1 do
      Begin
        Pc_RetiraValorCaixa('RETIRADA',I);
      End;
    End;
    RegistraCreditosExpirados;
    Pc_EncerraCaixa;
  End;
end;

procedure TFr_Caixa_Fechamento.Pc_ImagemBotao;
begin
  with fr_principal do
  Begin
    SB_Confirmar.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

procedure TFr_Caixa_Fechamento.Pc_IniciaVariaveis;
begin
  E_Dt_Caixa.Text := DateTostr(Gb_DataCaixa);
  E_Data_Ini.DateTime := Gb_DataCaixa;
  E_Data_Fim.DateTime := Gb_DataCaixa;
  E_Nome_Usuario.Text := GB_Nm_Usuario;
  Pc_AbreDadosVendas;
  Pc_TotalizaVendas;
  Pc_AbreTotalCredito;
  Pc_TotalizaCreditos;
  Pc_AbreTotalDebitos;
  Pc_TotalizaDEbito;
  Pc_Totaliza_Formas_Pagto;
  Pc_PreencherValoresCaixa;
end;

procedure TFr_Caixa_Fechamento.Pc_InsereValorCaixaTranferencia(Pc_Indice:Integer);
Var
  Lc_I:Integer;
begin
  with StrGrd_Valores do
  Begin
    Pc_Movim_Financeiro( DM.IBT_Financeiro,
                        'I',
                         0,
                         0,
                         StrToDateDef(E_Dt_Caixa.Text,Date),
                         0,
                         0,//StrToIntDef(E_CodPLc_C.Text, 0),
                         0,//StrToIntDef(E_CodPLc_D.Text, 0),
                         StrToFloatDEf(Cells[4,Pc_Indice],0),
                         0,
                         'FECH CAIXA - TRANSFÊRENCIA DO USUÁRIO ' + GB_Nm_Usuario + ' - ' + Cells[2,Pc_Indice],
                         'C',
                         0,
                         DBLCB_Usuario.KeyValue,
                         0,
                         DaTE,
                         '',
                         'N',
                         'S',
                         Gb_CodMha,
                         StrToIntDef(Cells[1,Pc_Indice],1));
  End;


end;


procedure TFr_Caixa_Fechamento.Pc_RetiraValorCaixa(pc_Tipo:String;Pc_Indice:Integer);
Var
  Lc_Valor : String;
begin
  with StrGrd_Valores do
  Begin
    if (pc_Tipo = 'TRANSFERÊNCIA') then
      pc_Tipo :=  'TRANSFERÊNCIA PARA O USUÁRIO ' + DBLCB_Usuario.Text;
    if StrtoIntDef(Cells[1,Pc_Indice],0) > 0 then
    Begin
      Lc_Valor := stringreplace(Cells[4,Pc_Indice], '.', '',[rfReplaceAll, rfIgnoreCase]);
      Pc_Movim_Financeiro( DM.IBT_Financeiro,
                          'I',
                           0,
                           0,
                          StrToDateDef(E_Dt_Caixa.Text,Date),
                          0,
                          0,//StrToIntDef(E_CodPLc_C.Text, 0),
                          0,//StrToIntDef(E_CodPLc_D.Text, 0),
                          0,
                          StrToFloatDEf(Lc_Valor,0),
                          'FECH CAIXA - ' + Pc_tipo + ' - ' + Cells[2,Pc_Indice],
                          'D',
                          0,
                          Gb_Cd_Usuario,
                          0,
                          DaTE,
                          '',
                          'N',
                          'S',
                          Gb_CodMha,
                          StrToIntDef(Cells[1,Pc_Indice],1));
    End;
  End;
end;



procedure TFr_Caixa_Fechamento.SB_ConfirmarClick(Sender: TObject);
begin
  if Fc_Valida then
  Begin
    TRY
      Pc_ProcesoAguarde(Self,'I');
      if (DBLCB_Usuario.Text = '') then
      Begin
        Pc_FechaCaixaNormal;
      End
      else
      Begin
        Pc_FechaCaixaTransferencia;
      End;
    Finally
      Pc_ProcesoAguarde(Self,'F');
    end;
  End;
end;

procedure TFr_Caixa_Fechamento.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Caixa_Fechamento.StrGrd_ValoresDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  If (arow > 0) and (acol >0) then  // testa se não é a primeira linha (fixa)
  Begin
    with StrGrd_Valores do
    Begin
      Canvas.Font.Color:= clBlack;
      Canvas.Brush.Color:= clMoneyGreen;
      Canvas.FillRect(Rect); // redesenha a celula
      Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.

      { Pega o texto da célula }
      Texto := Cells[acol, ARow];
      if (ACol = 4) and (arow> 0) then
        Texto := FloatToStrF(StrToFloatDef(Texto,0),ffNumber,15,2);
      { Calcura largura e altura (em pontos) do texto }
      LarguraTexto := Canvas.TextWidth(Texto);
      AlturaTexto := Canvas.TextHeight(Texto);

      { Calcula a posição horizontal do início do texto }
      if  (ACol = 2) then { esquerda }
        X := Rect.Left + 2
      else if  (ACol = 1) then { Centro }
        X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
      else { Direita }
        X := Rect.Right - LarguraTexto - 2;

      { Calcula a posição vertical do início do texto para
        que seja impresso no centro (verticalmente) da célula }
      Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -  AlturaTexto div 2;

      { Pinta o texto }
      Canvas.TextRect(Rect, X, Y, Texto);
    end;
  end;
end;

procedure TFr_Caixa_Fechamento.StrGrd_ValoresSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := ( (ACol = 4)  and (ARow >0) );
end;

procedure TFr_Caixa_Fechamento.StrGrd_ValoresSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
Var
  lc_TL : Real;
  Lc_Valor : String;
  LC_I : Integer;
begin
  with StrGrd_Valores do
  Begin
    if ACol = 4 then
    Begin
      lc_TL:=0;
      for LC_I := 1 to RowCount - 1 do
      Begin
        Lc_Valor := stringreplace(Cells[4,LC_I], '.', '',[rfReplaceAll, rfIgnoreCase]);
        lc_TL := lc_TL + StrToFloatDef(Lc_Valor,0);
      End;
      E_TL_VL_Digitado.Text := FloatToStrF(lc_TL,ffNumber,15,2);
    end;
  end;
end;

end.
