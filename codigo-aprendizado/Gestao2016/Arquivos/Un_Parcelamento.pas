unit Un_Parcelamento;

interface


uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, DB, STStoredProc, StdCtrls, DBCtrls, Mask, ExtCtrls, STQuery, Printers, UN_NF, ComCtrls, Grids, ControllerBase, QEdit_Setes, Un_Fm_MetodoPagamentoParcelado, Un_Fm_MetodoPagamento, Datasnap.DBClient, Vcl.DBGrids, Datasnap.Provider, ControllerPedido;

type

  TFr_Parcelamento = class(TForm)
    Pnl_botao: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Pnl_Total: TPanel;
    Label8: TLabel;
    Lb_VL_Total: TLabel;
    Grp_Parcela: TGroupBox;
    Sb_Parcelar: TSpeedButton;
    Sb_Vista: TSpeedButton;
    E_Nr_PArcelas: TEdit_Setes;
    Chbx_Entrada: TCheckBox;
    Scx_Parcela: TScrollBox;
    Label1: TLabel;
    E_VL_Total: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    cds_Preco_forma: TClientDataSet;
    ds_Preco_forma: TDataSource;
    cds_Preco_formaTPR_CODIGO: TIntegerField;
    cds_Preco_formaTPR_NOME: TWideStringField;
    cds_Preco_formaTOTAL: TFMTBCDField;
    cds_Preco_formaFPT_FORMAS: TWideStringField;
    Qr_FormasXTabela: TSTQuery;
    pnl_vl_Total: TPanel;
    pnl_ctrl_Parcela: TPanel;
    pnl_ctrl_Parcela_execute: TPanel;
    procedure SB_CancelarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_ParcelarClick(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_VistaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Procedure PreencheTabelaXFormaCotacao;
    function FormasPorTAbela(Tabela:Integer):String;

  public
    { Public declarations }
    Pedido : TControllerPedido;
    It_CodigoFPagto : TStringList;
    Confirma : Boolean;
    It_Cd_Cotacao : Integer;

    It_cd_FormaPagto : Integer;
    It_Desc_FormaPagto : String;
    It_Qt_Parcelas : Integer;
    It_VL_Credito: Currency;
    It_Fin_Operacao : String;
    It_StrinPrazo : String;
    It_Bloqueio : Boolean;
    ValorDuplicatas : REal;
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;

    procedure Pc_GravaParcelamento;
    function Fc_validaParcelamento():boolean;
    Function Fc_StringPrazo:String;
    procedure Pc_CriarFrame(Pc_Metodo:String; Pc_Valor:Real;Pc_Dt_Vencimento:Tdate);
    procedure Pc_Totalizar(Sender: TObject);
    Procedure Pc_MontaParcelamento;
    Procedure Pc_MontaParcelamentoString;
    procedure Pc_AlinhaVerticalParcelamento;
    procedure Pc_TotalizarParcelamento;
    Function   Fc_ValorInformado:Real;
    procedure Pc_LimpaParcelamento;
    procedure Pc_CriaNovoParcelamento(Pc_Nr_Parcela:String);
  end;

var
  Fr_Parcelamento: TFr_Parcelamento;
  Frame :TFm_MetodoPagamentoParcelado;
implementation


uses     Un_DM, Un_Msg, Un_Funcoes, UN_Sistema, UN_Receber_Multipla, Un_Pagar_Multipla, RN_Financeiro, RN_FormaPagto, Un_Regra_Negocio, Un_Fm_FormaPagto, env;
{$R *.dfm}

procedure TFr_Parcelamento.Pc_CriarFrame(Pc_Metodo:String; Pc_Valor:Real;Pc_Dt_Vencimento:Tdate);
Var
  Lc_Indice : Integer;
  Lc_Height : Integer;
begin
  Lc_Indice := It_CodigoFPagto.Count - 1;
  Lc_Height := 60;
  Frame := TFm_MetodoPagamentoParcelado.Create(Self);
  with Frame do
  begin
    Fm_FormaPagto.SB_FormaPag.Visible := False;
    Parent := Scx_Parcela;
    Name := 'Fm_' + It_CodigoFPagto[Lc_Indice];
    Fm_FormaPagto.Lb_FormaPagamento.Caption := It_CodigoFPagto[Lc_Indice] + 'é - Forma de Pagamento';
    //Align := alClient;
    Top := 4 + (Lc_Height * (It_CodigoFPagto.Count - 1));
    Left := 3;
    Height := Lc_Height;
    Width := 510;
    E_Data.DateTime := Pc_Dt_Vencimento;
    //Fm_FormaPagto.Name := 'Fm_FPT_' + It_CodigoFPagto[Lc_Indice];
    Fm_FormaPagto.Pc_Listar(3,It_Bloqueio, Pedido.Registro.Empresa);


    if Trim(Pc_Metodo) <> '' then
    Begin
      Fm_FormaPagto.DBLCB_FormaPagto.KeyValue := Fc_PegaParteFormaPgto(Pc_Metodo);
      Pc_MontaListaParcelas;
    End;
    E_valor.OnExit := Pc_Totalizar;
    e_valor.Text := FloatToStrF(Pc_Valor,ffFixed,10,2);
    //rEPOSICIONA OS CAMPOS DBEDIT E EDIT+SETES
  end;
  if ( It_CodigoFPagto.Count <=6 ) then
  Begin
    Height := (Lc_Height * (It_CodigoFPagto.Count )) + Grp_Parcela.Height + Pnl_Total.Height + pnl_botao.Height + Lc_Height + 193;
    if top > Lc_Height then
      top := top - Lc_Height;
  End;

end;

Function   TFr_Parcelamento.Fc_ValorInformado:Real;
var
  I : Integer;
  Lc_Edit: TEdit;
  variavel : TComponent;
  Lc_Valor : Real;
Begin
  Result := 0;
  for I := 0 to It_CodigoFPagto.Count - 1 do
  begin
    //Encontrar os campos para pegar os valores
    variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
    //Encontra o valor a receber
    Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
    Lc_Valor := (StrToFloatDef(Lc_Edit.Text,0));
    Lc_Edit.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
    Result := Result + Lc_Valor;
  end;
End;

procedure TFr_Parcelamento.Pc_Totalizar(Sender: TObject);
Var
  Lc_Vl_Informado :Real;
Begin
  Lc_Vl_Informado := Fc_ValorInformado;
  Lb_VL_Total.Caption := FloatToStrF( Lc_Vl_Informado,ffFixed,10,2);
end;

procedure TFr_Parcelamento.Pc_LimpaParcelamento;
var
  I : Integer;
  variavel : TComponent;
begin
  for I := 0 to It_CodigoFPagto.Count - 1 do
  begin
    //Encontrar o frame
    variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
    //Limpa o Frame
    FreeAndNil(variavel);
  end;
  //Limpa o controlador de quantidade de parcelas
  It_CodigoFPagto.Clear;
end;

Procedure TFr_Parcelamento.Pc_MontaParcelamento;
Var
  Lc_Qry : TSTQuery;
  Lc_I : integer;
  Lc_Valor : real;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT * '+
              'FROM TB_PARCELAMENTO '+
              '  INNER JOIN TB_FORMAPAGTO '+
              '  ON (FPT_CODIGO = PAR_CODFPT)'+
              'WHERE PAR_CODPED=:PED_CODIGO ');
      ParamByName('PED_CODIGO').AsInteger := Pedido.Registro.Codigo;
      Active := True;
      FetchAll;
      Scx_Parcela.Visible := False;
      if (RecordCount > 0) then
      Begin
        while not eof do
        Begin
          It_CodigoFPagto.Add( IntToStr( It_CodigoFPagto.Count + 1 ) );
          Pc_CriarFrame(FieldByName('FPT_DESCRICAO').AsString,
                        FieldByName('PAR_VALOR').AsCurrency,
                        FieldByName('PAR_DATA').AsDatetime);
          Next;
        End;
      end
      else
      Begin
        Pc_MontaParcelamentoString;
      end;
    End;
  Finally
    Scx_Parcela.Visible := True;
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;


Procedure TFr_Parcelamento.Pc_MontaParcelamentoString;
Var
  Lc_Nr_Parcelas : Integer;
  Lc_Vl_total : Real;
  Lc_VL_Parcela : Real;
  Lc_St_Parcela : String;
  Lc_Dias : Integer;
  I : Integer;
  Lc_Dt_Vencimento : TDate;
Begin
  Pc_Define_FormatoRegional;
  //Numero de Parcelas
  Lc_Nr_Parcelas := StrToIntDef( E_Nr_PArcelas.Text, 1);
  if ( Lc_Nr_Parcelas =  0 ) then Lc_Nr_Parcelas := 1;
  //Resolvemos o problema da Divisão e dizima periodica
  //Lc_Vl_total := FieldByName('PED_VL_PEDIDO').AsFloat;
  Lc_Vl_total := ValorDuplicatas;

  Lc_Vl_Parcela := Lc_Vl_total / Lc_Nr_Parcelas;
  Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela, ffFixed, 10, 2);
  Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);
  Scx_Parcela.Visible := False;
  Lc_Dias := 0;
  for I := 1 to Lc_Nr_Parcelas do
  Begin
    IF ( I = Lc_Nr_Parcelas ) THEN
    Begin
      Lc_Vl_Parcela := Lc_Vl_total -  (Lc_Vl_Parcela * (Lc_Nr_Parcelas - 1));
      Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela,ffFixed,10,2);
    end
    else
    Begin
      Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela,ffFixed,10,2);
    end;
    if (I = 1) and Chbx_Entrada.Checked then
    Begin
      Lc_Dt_Vencimento := Date;
    End
    else
    BEgin        //003 - 030/060/090
      if ( Lc_Nr_Parcelas > 0) then
        Lc_Dias := StrToIntDef( Copy(It_StrinPrazo, (((I-1) * 4) + 1), 3) , 0 )
      else
        Lc_Dias := 0;
      Lc_Dt_Vencimento := Pedido.Registro.Data+ Lc_Dias;
    End;
    It_CodigoFPagto.Add( IntToStr( It_CodigoFPagto.Count + 1 ) );
    Pc_CriarFrame(It_Desc_FormaPagto,
                  StrToFloatDef(Lc_St_Parcela,0),
                  Lc_Dt_Vencimento);
  End;
  Scx_Parcela.Visible := True;
End;

procedure TFr_Parcelamento.Pc_AlinhaVerticalParcelamento;
var
  I : Integer;
  variavel : TComponent;
begin
  for I := 0 to It_CodigoFPagto.Count - 1 do
  begin
    //Encontrar o frame
    variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
    TFm_MetodoPagamentoParcelado(variavel).Align :=alTop;
    if ( I = 0 ) then
    Begin
      if TFm_MetodoPagamentoParcelado(variavel).E_Data.CanFocus then
        TFm_MetodoPagamentoParcelado(variavel).E_Data.setFocus;
    End;
  end;
  Scx_Parcela.VertScrollBar.Position :=0;

end;


procedure TFr_Parcelamento.Pc_TotalizarParcelamento;
var
  I : Integer;
  variavel : TComponent;
  Lc_Edit : TEdit;
begin
  //Encontrar os campos para pegar os valores
  variavel := findcomponent('Fm_1');
  //Encontra o valor a receber
  Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
  Lc_Edit.OnExit(Self);
end;

procedure TFr_Parcelamento.PreencheTabelaXFormaCotacao;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
            'select tp.tpr_codigo, tp.tpr_nome,  CAST(SUM( (I.ict_qtde * I.ict_vl_unit) - I.ict_vl_desc) AS NUMERIC(18, 9)) TOTAL ',
            'from tb_itens_ctc i ',
            '  inner join tb_tabela_preco tp ',
            '  on (tp.tpr_codigo = i.ict_codtpr) ',
            'where i.ict_codctc =:CTC_codigo ',
            'GROUP BY 1,2 '
      ));
      ParamByName('CTC_CODIGO').AsInteger := It_Cd_Cotacao;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
      Begin
        if not cds_Preco_forma.Active then cds_Preco_forma.CreateDataSet;
        first;
        while not eof do
        Begin
          cds_Preco_forma.Append;
          cds_Preco_formaTPR_CODIGO.AsInteger := FieldByName('TPR_CODIGO').AsInteger;
          cds_Preco_formaTPR_NOME.AsString := FieldByName('TPR_NOME').AsString;
          cds_Preco_formaTOTAL.AsCurrency := FieldByName('TOTAL').AsCurrency;
          cds_Preco_formaFPT_FORMAS.AsString := FormasPorTAbela(FieldByName('TPR_CODIGO').AsInteger);
          cds_Preco_forma.Post;
          next;
        End;
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Parcelamento.Pc_CriaNovoParcelamento(Pc_Nr_Parcela:String);
Var
  I : Integer;
  Lc_Nr_Parcelas : Integer;
  Lc_Vl_total : Real;
  Lc_Vl_Parcela : Real;
  Lc_St_Parcela : String;
  Lc_Dt_Vencimento : Real;
  Lc_Dias : Integer;
begin
  Pc_Define_FormatoRegional;
  //Numero de Parcelas
  Lc_Nr_Parcelas := StrToIntDef(Pc_Nr_Parcela,1);
  //Resolvemos o problema da Divisão e dizima periodica
  Lc_Vl_total := StrToFloatDef(E_VL_Total.Caption,0);

  Lc_Vl_Parcela := Lc_Vl_total / Lc_Nr_Parcelas;
  Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela, ffFixed, 10, 2);
  Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);
  Scx_Parcela.Visible := False;
  Lc_Dias := 0;
  for I := 1 to Lc_Nr_Parcelas do
  Begin
    IF ( I = Lc_Nr_Parcelas ) THEN
    Begin
      Lc_Vl_Parcela := Lc_Vl_total -  (Lc_Vl_Parcela * (Lc_Nr_Parcelas - 1));
      Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela,ffFixed,10,2);
    end
    else
    Begin
      Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela,ffFixed,10,2);
    end;
    if (I = 1) and Chbx_Entrada.Checked then
    Begin
      Lc_Dt_Vencimento := Date;
    End
    else
    BEgin
      Lc_Dias := Lc_Dias + 30;
      Lc_Dt_Vencimento := Pedido.Registro.Data + Lc_Dias;
    End;
    It_CodigoFPagto.Add( IntToStr( It_CodigoFPagto.Count + 1 ) );
    Pc_CriarFrame('CARTEIRA',
                  StrToFloatDef(Lc_St_Parcela,0),
                  Lc_Dt_Vencimento);
  End;
  Scx_Parcela.Visible := True;
end;


function TFr_Parcelamento.Fc_StringPrazo: String;
var
  Lc_Prazo: string;
  Lc_Data: TDate;
  Lc_Dia: Real;
  I : Integer;
  variavel : TComponent;
  Lc_Dt_Vencimento : TDateTimePicker;
begin
  for I := 0 to It_CodigoFPagto.Count - 1 do
  begin
    //Encontrar os campos para pegar os valores
    variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
    //Data de Vencimento
    Lc_Dt_Vencimento := TDateTimePicker(Fc_LocalizaComponente(variavel,TDateTimePicker));
    Lc_Data := Lc_Dt_Vencimento.Date;
    Lc_Dia := Lc_Data - pedido.Registro.Data;
    if Lc_Dia < 0 then
      Lc_Dia := 0;
    if I = 0 then
    begin
      Lc_Prazo := StrZero(Lc_Dia, 3, 0);
    end
    else
    begin
      Lc_Prazo := Lc_Prazo + StrZero(Lc_Dia, 3, 0);
    end;
  end;
  Result := Lc_Prazo;
end;

function TFr_Parcelamento.Fc_validaParcelamento():boolean;
Var
  Lc_Vl_Total, Lc_Vl_Informado : Real;
  I : Integer;
  variavel : TComponent;
  MetodoPagamento : TFm_FormaPagto;
  Lc_Dblookup : TDBLookupComboBox;
Begin
  Result := True;
  Lc_Vl_Total     := StrToFloatDef(E_VL_Total.Caption,0);
  Lc_Vl_Informado := StrToFloatDef(Lb_VL_Total.CAption,0);
  if (Lc_Vl_Total <> Lc_Vl_Informado) then
  begin
    MensagemPadrao(ATENCAO,
                   'O Valor Total e valor do Parcelamento devem ser iguais.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;

  for I := 0 to It_CodigoFPagto.Count - 1 do
  begin
    //Encontrar os campos para pegar os valores
    variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);

    //Encontra a forma de pagamento
    MetodoPagamento := TFm_FormaPagto(Fc_LocalizaComponente(variavel,TFm_FormaPagto));
    Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(MetodoPagamento,TDBLookupComboBox));

    if (Lc_Dblookup.Text = '') then
    begin
      MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                     'Informe a forma de pagamento.' + EOLN +
                     'Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      Result := False;
      exit;
    end;
  end;
end;

procedure TFr_Parcelamento.Pc_GravaParcelamento;
Var
  I : Integer;
  variavel : TComponent;
  MetodoPagamento : TFm_FormaPagto;
  Lc_Edit: TEdit;
  Lc_Dblookup : TDBLookupComboBox;
  Lc_Dt_Vencimento : TDateTimePicker;
begin
  for I := 0 to It_CodigoFPagto.Count - 1 do
  begin
    //Encontrar os campos para pegar os valores
    variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
    //Encontra o valor a receber
    Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
    //Data de Vencimento
    Lc_Dt_Vencimento := TDateTimePicker(Fc_LocalizaComponente(variavel,TDateTimePicker));

    //Encontra a forma de pagamento
    MetodoPagamento := TFm_FormaPagto(Fc_LocalizaComponente(variavel,TFm_FormaPagto));
    Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(MetodoPagamento,TDBLookupComboBox));

    Pedido.Parcelamento.Clear;
    Pedido.Parcelamento.Registro.CodigoPedido         := Pedido.Registro.Codigo;
    Pedido.Parcelamento.Registro.NumeroParcela        := I + 1;
    Pedido.Parcelamento.Registro.Vencimento           := Lc_Dt_Vencimento.DateTime;
    Pedido.Parcelamento.Registro.Valor                := StrToFloatDef(Lc_Edit.Text,0);
    Pedido.Parcelamento.Registro.CodigoFormaPagamento := Lc_Dblookup.KeyValue;
    Pedido.Parcelamento.salva;
  end;
end;

procedure TFr_Parcelamento.SB_CancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Parcelamento.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;

end;

function TFr_Parcelamento.FormasPorTAbela(Tabela: Integer): String;
begin
  Result := '';
  with Qr_FormasXTabela do
  Begin
    Active := False;
    ParamByName('TPR_CODIGO').AsInteger := Tabela;
    Active := True;
    FetchAll;
    first;
    while not eof do
    Begin
      if bof then
        REsult := FieldByname('fpt_descricao').AsString
      else
        REsult := concat(REsult,'\',FieldByname('fpt_descricao').AsString);
      next;
    End;
  End;
end;

procedure TFr_Parcelamento.FormCreate(Sender: TObject);
begin
  ValorDuplicatas := 0;
  Pedido := TControllerPedido.create(Self);
  It_CodigoFPagto := TStringList.Create;
  Confirma := False;
end;

procedure TFr_Parcelamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F2  : if Sb_Parcelar.Enabled then Sb_ParcelarClick(Sender);
      VK_F3  : if Sb_Vista.Enabled then Sb_VistaClick(Sender);
      VK_F10  : if SB_Confirmar.Enabled then SB_ConfirmarClick(Sender);
      VK_ESCAPE : If SB_Cancelar.Enabled then SB_CancelarClick(Sender);
    end;
  end;
end;

procedure TFr_Parcelamento.Pc_FormataTela;
Begin
end;

procedure TFr_Parcelamento.Pc_IniciaVariaveis;
Begin
  Pedido.getbyId;
  if ValorDuplicatas = 0 then
  Begin
    ValorDuplicatas := pedido.valorFinanceiro;
  End;
  E_VL_Total.Caption := FloatToStrF(ValorDuplicatas, ffFixed, 10,2);
end;


procedure TFr_Parcelamento.Sb_ParcelarClick(Sender: TObject);
begin
  Pc_LimpaParcelamento;
  Pc_CriaNovoParcelamento(E_Nr_PArcelas.Text);
  Pc_AlinhaVerticalParcelamento;
  Pc_TotalizarParcelamento;
end;


procedure TFr_Parcelamento.SB_ConfirmarClick(Sender: TObject);
Var
  Lc_Str_Data : String;
begin
  if Fc_validaParcelamento then
  Begin
    //Apaga o Parcelamento atual
    Pedido.Parcelamento.Registro.CodigoPedido := Pedido.Registro.Codigo;
    Pedido.Parcelamento.deletebyPedido;
    //Grava os prazos na tela do pedido
    Pc_GravaParcelamento;
    It_Qt_Parcelas := It_CodigoFPagto.Count;
    It_StrinPrazo := Fc_StringPrazo;
    Confirma := True;
    close;
  end;
end;

procedure TFr_Parcelamento.FormShow(Sender: TObject);
Var
  Lc_Bloqueio : Boolean;
begin
  Pc_FormataTela;
  Pc_IniciaVariaveis;
  if It_Cd_Cotacao > 0 then
    PreencheTabelaXFormaCotacao;
  Pc_MontaParcelamento;
  Pc_AlinhaVerticalParcelamento;
  Pc_TotalizarParcelamento;
  Lc_Bloqueio := Fc_VerIficaBloqueioCliente( Pedido.Registro.Codigo);
end;

procedure TFr_Parcelamento.Sb_VistaClick(Sender: TObject);
begin
  Pc_LimpaParcelamento;
  pedido.Parcelamento.Registro.CodigoPedido := pedido.Registro.Codigo;
  pedido.Parcelamento.deletebyPedido;
  It_Qt_Parcelas := 0;
  Confirma := True;
  close;
end;


end.
