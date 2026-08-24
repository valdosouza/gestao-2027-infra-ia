unit Un_Fatura_Fin;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, DB, STStoredProc, StdCtrls, DBCtrls, Mask, ExtCtrls, STQuery, Printers, ComCtrls, Grids, QEdit_Setes, Un_Fm_CentroCusto, Un_Fm_MetodoPagamento, ControllerNotaFiscal, Un_Fm_MetodoPagamentoParcelado, ControllerBase, ControllerCartaoEletronico;


type

  TFr_Fatura_Fin = class(TForm)
    Pnl_Botao: TPanel;
    SB_Confirmar: TSpeedButton;
    Scx_Parcela: TScrollBox;
    Grp_Parcela: TGroupBox;
    Sb_Parcelar: TSpeedButton;
    Sb_Vista: TSpeedButton;
    E_Nr_PArcelas: TEdit_Setes;
    Chbx_Entrada: TCheckBox;
    ChBx_Duplicata: TCheckBox;
    ChBx_Vl_ST: TCheckBox;
    Grp_Pagamento: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    LB_TL_Informado: TLabel;
    Label2: TLabel;
    Sb_NovaFormaPagto: TSpeedButton;
    E_Diferenca: TEdit_Setes;
    E_VL_Troco: TEdit_Setes;
    e_vl_informado: TEdit_Setes;
    E_VL_Total: TEdit_Setes;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_VistaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Sb_NovaFormaPagtoClick(Sender: TObject);
    procedure Sb_ParcelarClick(Sender: TObject);
    procedure ChBx_Vl_STClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Bloqueio : Boolean;

  public
    { Public declarations }
    PegaContaGerencialAuto : Boolean;
    Nota : TControllerNotaFiscal;
    It_CodigoFPagto : TStringList;
    It_cd_Nota : Integer;
    It_Qt_Parcelas : Integer;
    It_StrinPrazo : String;
    It_Confirma : Boolean;
    It_Tipo_Finaceiro : String;
    It_Oper_Financeiro : String;
    It_Hist_Caixa : String;

    TelaVenda : Boolean;
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_AtivarTabelas;
    procedure Pc_CriarFrame(Pc_Metodo:String; Pc_Valor:Real;Pc_Dt_Vencimento:Tdate);
    Function  Fc_ValorInformado:Real;
    procedure Pc_Totalizar(Sender: TObject);
    procedure Pc_TotalizarParcelamento;

    procedure Pc_GravaParcelamento;

    procedure Pc_LimpaParcelamento;
    procedure Pc_AlinhaVerticalParcelamento;
    Procedure Pc_MontaParcelamento;
    Procedure Pc_MontaParcelamentoString;
    Procedure Pc_CriaNovoParcelamento(Pc_Nr_Parcela:String);
    procedure Pc_Recalcular;

    function Fc_validaParcelamento():boolean;
    procedure Pc_Gera_Financeiro;
    procedure Pc_Obs_Financeira;

  end;

var
  Fr_Fatura_Fin: TFr_Fatura_Fin;
  Frame :TFm_MetodoPagamentoParcelado;

implementation


uses     Un_DM, Un_Msg, Un_Funcoes, UN_Sistema, UN_Receber_Multipla, Un_Pagar_Multipla, RN_Financeiro, RN_FormaPagto, RN_PlanoContas, Un_Fc_Sored_Procedures, Un_Regra_Negocio, UN_RL_Duplicata, RI_MovimentoFinanceiro, UN_NF, ControllerFinanceiro, Un_Fm_FormaPagto, Un_Lanca_PlanoContas, UN_Principal, env;

{$R *.dfm}

Function   TFr_Fatura_Fin.Fc_ValorInformado:Real;
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


procedure TFr_Fatura_Fin.Pc_CriaNovoParcelamento(Pc_Nr_Parcela:String);
Var
  I : Integer;
  Lc_Nr_Parcelas : Integer;
  Lc_Vl_total : Real;
  Lc_Vl_Parcela : Real;
  Lc_St_Parcela : String;
  Lc_Vl_SubTrib : Real;
  Lc_Dt_Vencimento : Real;
  Lc_Dias : Integer;
begin
  Pc_Define_FormatoRegional;
  //Numero de Parcelas
  Lc_Nr_Parcelas := StrToIntDef(Pc_Nr_Parcela,1);
  //Resolvemos o problema da Divisão e dizima periodica
  Lc_Vl_total := StrToFloatDef(E_VL_Total.Text,0);
  //Definimos se o valor da S.T vai na primeira parcela
  Lc_Vl_SubTrib := 0;
  if ChBx_Vl_ST.Checked then
  Begin
    Lc_Vl_SubTrib := Nota.Registro.ValorICMSST;
    Lc_Vl_total := Lc_Vl_total  - Lc_Vl_SubTrib
  End;

  Lc_Vl_Parcela := Lc_Vl_total / Lc_Nr_Parcelas;
  Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela, ffFixed, 10, 2);
  Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);
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
      if I = 1 then
        Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela + Lc_Vl_SubTrib,ffFixed,10,2)
      else
        Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela,ffFixed,10,2);
    end;
    if (I = 1) and Chbx_Entrada.Checked then
    Begin
      Lc_Dt_Vencimento := Date;
    End
    else
    BEgin
      Lc_Dias := Lc_Dias + 30;
      Lc_Dt_Vencimento := Nota.Registro.DataEmissao + Lc_Dias;
    End;
    It_CodigoFPagto.Add( IntToStr( It_CodigoFPagto.Count + 1 ) );
    Pc_CriarFrame('CARTEIRA',
                  StrToFloatDef(Lc_St_Parcela,0),
                  Lc_Dt_Vencimento);
  End;
end;


procedure TFr_Fatura_Fin.Pc_Recalcular;
Var
  I : Integer;
  Lc_Nr_Parcelas : Integer;
  Lc_Vl_total : Real;
  Lc_Vl_Parcela : Real;
  Lc_St_Parcela : String;
  Lc_Vl_SubTrib : Real;

  Lc_Edit: TEdit;
  variavel : TComponent;
  Lc_Valor : Real;

begin
  Pc_Define_FormatoRegional;
  //Numero de Parcelas
  Lc_Nr_Parcelas := It_CodigoFPagto.Count;
  //Resolvemos o problema da Divisão e dizima periodica
  Lc_Vl_total := StrToFloatDef(E_VL_Total.Text,0);
  //Definimos se o valor da S.T vai na primeira parcela
  Lc_Vl_SubTrib := 0;
  if ChBx_Vl_ST.Checked then
  Begin
    Lc_Vl_SubTrib := Nota.Registro.ValorICMSST;
    Lc_Vl_total := Lc_Vl_total  - Lc_Vl_SubTrib
  End;

  Lc_Vl_Parcela := Lc_Vl_total / Lc_Nr_Parcelas;
  Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela, ffFixed, 10, 2);
  Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);
  for I := 1 to Lc_Nr_Parcelas do
  begin
    IF ( I = Lc_Nr_Parcelas ) THEN
    Begin
      Lc_Vl_Parcela := Lc_Vl_total -  (Lc_Vl_Parcela * (Lc_Nr_Parcelas - 1));
      Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela,ffFixed,10,2);
    end
    else
    Begin
      if I = 1 then
        Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela + Lc_Vl_SubTrib,ffFixed,10,2)
      else
        Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela,ffFixed,10,2);
    end;
    //Encontrar os campos para pegar os valores
    variavel := findcomponent(concat('Fm_', IntToStr(I)));
    //Encontra o valor a receber
    Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
    Lc_Edit.Text := Lc_St_Parcela;
  End;
  Lc_Vl_total := StrToFloatDef(E_VL_Total.Text,0);
  e_vl_informado.Text := FloattoStrF(Lc_Vl_total,ffFixed,10,2);
end;

procedure TFr_Fatura_Fin.Pc_CriarFrame(Pc_Metodo:String; Pc_Valor:Real;Pc_Dt_Vencimento:Tdate);
Var
  Lc_Indice : Integer;
begin
  Lc_Indice := It_CodigoFPagto.Count - 1;
  Frame := TFm_MetodoPagamentoParcelado.Create(Self);
  Frame.Visible := self.Visible;
  with Frame do
  begin
    AlignWithMargins := True;
    Parent := Scx_Parcela;
    Name := 'Fm_' + It_CodigoFPagto[Lc_Indice];

    Fm_FormaPagto.Lb_FormaPagamento.Caption := It_CodigoFPagto[Lc_Indice] + 'º -  Forma de Pagamento';
    //Align := alClient;
    Top := 4 + (54 * (It_CodigoFPagto.Count - 1));
    Left := 3;
    Height := 54;
    Width := 510;
    E_Data.DateTime := Pc_Dt_Vencimento;
    if ((It_Tipo_Finaceiro = 'RA') or (It_Tipo_Finaceiro = 'RM')) AND (It_Oper_Financeiro = 'C') then
      Fm_FormaPagto.Pc_Listar(3,Bloqueio, Nota.Registro.CodigoEmpresa)
    else
      Fm_FormaPagto.Pc_Listar(3,False, 0);
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
    Height := (54 * (It_CodigoFPagto.Count )) + Grp_Parcela.Height + Grp_Pagamento.Height + Pnl_Botao.Height + 54;
    if top > 54 then
      top := top - 54;
  End;

end;

procedure TFr_Fatura_Fin.Pc_AtivarTabelas;
Begin

end;

function TFr_Fatura_Fin.Fc_validaParcelamento():boolean;
Var
  Lc_Vl_Total, Lc_Vl_Informado : Real;
  variavel : TComponent;
  Lc_Dblookup : TDBLookupComboBox;
  I : Integer;
  MetodoPagamento : TFm_FormaPagto;
Begin
  Result := True;
  for I := 0 to It_CodigoFPagto.Count - 1 do
  begin
    //Encontrar os campos para pegar os valores
    variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
    //Encontra a forma de pagamento
    MetodoPagamento := TFm_FormaPagto(Fc_LocalizaComponente(variavel,TFm_FormaPagto));
    Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(MetodoPagamento,TDBLookupComboBox));
    if (Lc_Dblookup.Text = '')  then
    bEGIN
      MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                     'Informe a forma de pagamento.' + EOLN +
                     'Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      Result := False;
      exit;
    end;
  end;

  if ( Fc_Tb_Geral('L','FIN_FAT_BAIXA_AUTO','S') = 'S') then
  begin
    if not Fc_VErificaCaixaAberto(False) then
    Begin
      for I := 0 to It_CodigoFPagto.Count - 1 do
      begin
        //Encontrar os campos para pegar os valores
        variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
        //Encontra a forma de pagamento
        MetodoPagamento := TFm_FormaPagto(Fc_LocalizaComponente(variavel,TFm_FormaPagto));
        Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(MetodoPagamento,TDBLookupComboBox));

        if (Pos('DINHEIRO',Trim(Lc_Dblookup.Text))>0) OR (Pos('CHEQUE',Trim(Lc_Dblookup.Text))>0) then
        bEGIN
          MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                        ' Não existe um caixa aberto para este Usuário.' + EOLN +
                         'E a forma de pagamento ' + Lc_Dblookup.Text + ' não é permitida.' + EOLN+
                         'Altere e forma de pagamento para continuar.'+ EOLN,
                         ['OK'], [bEscape], mpAlerta);
          Result := False;
          exit;
        end;
      end;
    End;
  end
  else
  Begin
    Fc_VErificaCaixaAberto(False);
  End;

  Lc_Vl_Total     := StrToFloatDef(E_VL_Total.Text,0);
  Lc_Vl_Informado := StrToFloatDef(e_vl_Informado.Text,0);
  if (Lc_Vl_Total <> Lc_Vl_Informado) then
  begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'O valor informado e valor total devem ser iguais.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;
end;

Procedure TFr_Fatura_Fin.Pc_MontaParcelamentoString;
Var
  Lc_Nr_Parcelas : Integer;
  Lc_Vl_total : Real;
  Lc_Vl_SubTrib : Real;
  Lc_VL_Parcela : Real;
  Lc_St_Parcela : String;
  Lc_Dias : Integer;
  I : Integer;
  Lc_Dt_Vencimento : TDate;
Begin
  Pc_Define_FormatoRegional;
  //Numero de Parcelas
  Lc_Nr_Parcelas := StrToIntDef( Copy( Nota.Pedido.Registro.Prazo,1,3), 1);
  if ( Lc_Nr_Parcelas =  0 ) then Lc_Nr_Parcelas := 1;
  //Resolvemos o problema da Divisão e dizima periodica
  Lc_Vl_total := StrToFloatDef(E_VL_Total.Text,0);

  //Definimos se o valor da S.T vai na primeira parcela
  Lc_Vl_SubTrib := 0;
  if ChBx_Vl_ST.Checked then
  Begin
    Lc_Vl_SubTrib := Nota.Registro.ValorICMSST;
    Lc_Vl_total := Lc_Vl_total  - Lc_Vl_SubTrib
  End;

  Lc_Vl_Parcela := Lc_Vl_total / Lc_Nr_Parcelas;
  Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela, ffFixed, 10, 2);
  Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);
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
      if I = 1 then
        Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela + Lc_Vl_SubTrib,ffFixed,10,2)
      else
        Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela,ffFixed,10,2);
    end;
    if (I = 1) and Chbx_Entrada.Checked then
    Begin
      Lc_Dt_Vencimento := Date;
    End
    else
    BEgin        //003 - 030/060/090
      if ( StrToIntDef( Copy( Nota.Pedido.Registro.Prazo,1,3), 1) > 0) then
        Lc_Dias := StrToIntDef( Copy( Nota.Pedido.Registro.Prazo, (((I-1) * 4) + 7), 3) , 0 )
      else
        Lc_Dias := 0;
      Lc_Dt_Vencimento := Nota.Registro.DataEmissao + Lc_Dias;
    End;
    It_CodigoFPagto.Add( IntToStr( It_CodigoFPagto.Count + 1 ) );
    Pc_CriarFrame( Nota.pedido.FormaPagto.Registro.Descricao,
                  StrToFloatDef(Lc_St_Parcela,0),
                  Lc_Dt_Vencimento);
  End;
End;

Procedure TFr_Fatura_Fin.Pc_MontaParcelamento;
Var
  I : integer;
  Lc_Vl_Frete : real;
  Lc_Vl_Valor : real;
begin
  with Nota.Pedido do
  Begin
    Lc_Vl_Frete := 0;
    Parcelamento.Registro.CodigoPedido := Nota.Registro.CodigoPedido;
    Parcelamento.getList;
    if (nota.Registro.ValorFrete > 0) and (nota.Pedido.Registro.ValorFrete = 0) then
      Lc_Vl_Frete := nota.Registro.ValorFrete;

    if Parcelamento.Lista.Count > 0 then
    Begin
      for I := 0 to Parcelamento.Lista.Count -1 do
      Begin
        It_CodigoFPagto.Add( IntToStr( It_CodigoFPagto.Count + 1 ) );
        FormaPagto.Registro.Codigo := Parcelamento.Lista[I].CodigoFormaPagamento;
        FormaPagto.getById;
        if (I = 0 ) then
          Lc_Vl_Valor := Parcelamento.Lista[I].Valor + Lc_Vl_Frete
        else
          Lc_Vl_Valor := Parcelamento.Lista[I].Valor;

        Pc_CriarFrame(FormaPagto.Registro.Descricao ,
                      Lc_Vl_Valor,
                      Parcelamento.Lista[I].Vencimento);
        Next;
      End;
    end
    else
    Begin
      Pc_MontaParcelamentoString;
    end;
  End;
end;


procedure TFr_Fatura_Fin.Pc_GravaParcelamento;
Var
  I : Integer;
  variavel : TComponent;
  Lc_Edit: TEdit;
  MetodoPagamento : TFm_FormaPagto;
  Lc_Dblookup : TDBLookupComboBox;
  Lc_Dt_Vencimento : TDateTimePicker;
begin
  for I := 0 to It_CodigoFPagto.Count - 1 do
  begin
    //Encontrar os campos para pegar os valores
    variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
    //Encontra o valor a receber
    Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));

    //Encontra a forma de pagamento
    MetodoPagamento := TFm_FormaPagto(Fc_LocalizaComponente(variavel,TFm_FormaPagto));
    Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(MetodoPagamento,TDBLookupComboBox));


    Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(variavel,TDBLookupComboBox));
    //Data de Vencimento
    Lc_Dt_Vencimento := TDateTimePicker(Fc_LocalizaComponente(variavel,TDateTimePicker));
    //Encontra o parcelamento
    Nota.Pedido.Parcelamento.clear;
    Nota.Pedido.Parcelamento.Registro.CodigoPedido          := Nota.Registro.CodigoPedido;
    Nota.Pedido.Parcelamento.Registro.NumeroParcela         := I + 1;
    Nota.Pedido.Parcelamento.Registro.Vencimento            := Lc_Dt_Vencimento.DateTime;
    Nota.Pedido.Parcelamento.Registro.Valor                 := StrToFloatDef(Lc_Edit.Text,0);
    Nota.Pedido.Parcelamento.Registro.CodigoFormaPagamento  := Lc_Dblookup.KeyValue;
    Nota.Pedido.Parcelamento.salva;
  end;
end;


procedure TFr_Fatura_Fin.Pc_LimpaParcelamento;
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

procedure TFr_Fatura_Fin.Pc_AlinhaVerticalParcelamento;
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

procedure TFr_Fatura_Fin.Pc_Totalizar(Sender: TObject);
Var
  Lc_Valor:Real;
  Lc_Vl_Informado :Real;
Begin
  Lc_Vl_Informado := Fc_ValorInformado;
  E_vl_informado.Text := FloatToStrF( Lc_Vl_Informado,ffFixed,10,2);
  Lc_Valor := StrToFloatDef(E_VL_Total.Text,0);
  Lc_Valor := Lc_Valor - Lc_Vl_Informado;
  if Lc_Valor > 0 then
    E_Diferenca.Text := FloatToStrF( Lc_Valor,ffFixed,10,2)
  else
    E_Diferenca.Text := '0,00';
  Lc_Valor := StrToFloatDef(E_VL_Total.Text,0);
  Lc_Valor := Lc_Vl_Informado - Lc_Valor;
  if Lc_Valor > 0 then
    E_VL_Troco.Text := FloatToStrF( Lc_Valor,ffFixed,10,2)
  else
    E_VL_Troco.Text := '0,00';
end;

procedure TFr_Fatura_Fin.Pc_TotalizarParcelamento;
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

procedure TFr_Fatura_Fin.ChBx_Vl_STClick(Sender: TObject);
begin
  Scx_Parcela.Visible := False;
  Pc_Recalcular;
  Scx_Parcela.Visible := True;
end;

procedure TFr_Fatura_Fin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;

end;

procedure TFr_Fatura_Fin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F2  : if Sb_Parcelar.Enabled then Sb_ParcelarClick(Sender);
      VK_F3  : if Sb_Vista.Enabled then Sb_VistaClick(Sender);
      VK_F10  : if SB_Confirmar.Enabled then SB_ConfirmarClick(Sender);
    end;
  end;
end;

procedure TFr_Fatura_Fin.Pc_FormataTela;
  var CanSelect: Boolean;
Begin
  E_Nr_PArcelas.Alignment:= TAlignment(1);
  Grp_Parcela.Enabled :=  True;
  Scx_Parcela.Enabled :=  True;
  Grp_Pagamento.Enabled :=  True;
  if (Fc_Tb_Geral('L','VDA_G_CTRL_PARCELA','') = 'C')  and TelaVenda  then
  Begin
    Grp_Parcela.Enabled :=  False;
    Scx_Parcela.Enabled :=  False;
    Grp_Pagamento.Enabled :=  False;
  End;
end;

procedure TFr_Fatura_Fin.Pc_IniciaVariaveis;
Var
  Lc_VL_Parcelamento : Real;
  Lc_VL_Financeiro : Real;
Begin
  Nota.Registro.Codigo := It_cd_Nota;
  Nota.getbyId;

  Nota.Pedido.Registro.Codigo := Nota.Registro.CodigoPedido;
  Nota.Pedido.getbyId;

  Nota.Pedido.FormaPagto.Registro.Codigo := Nota.Pedido.Registro.FormaPagto;
  Nota.Pedido.FormaPagto.getById;

  Nota.Empresa.Registro.Codigo := Nota.Registro.CodigoEmpresa;
  Nota.Empresa.getById;

  Nota.Pedido.Parcelamento.Registro.CodigoPedido := Nota.Registro.CodigoPedido;
  Lc_VL_Parcelamento := Nota.Pedido.Parcelamento.getValor;

  Lc_VL_Financeiro := Nota.valorFinanceiro;

  if (Lc_VL_Financeiro > 0) or (Lc_VL_Parcelamento >0 ) then
  Begin
   if (Lc_VL_Parcelamento >= Lc_VL_Financeiro )  then
      E_VL_Total.Text := FloatToStrF(Lc_VL_Parcelamento,ffFixed,10,2)
   else
    E_VL_Total.Text := FloatToStrF(Lc_VL_Financeiro,ffFixed,10,2);
  End
  else
  Begin
    E_VL_Total.Text := FloatToStrF(Nota.Registro.ValorNota,ffFixed,10,2);
  End;
  ChBx_Duplicata.Checked := False;
  ChBx_Duplicata.Enabled := (It_Tipo_Finaceiro = 'RA');
  Bloqueio := Fc_VerIficaBloqueioCliente(Nota.Registro.CodigoEmpresa );
end;

procedure TFr_Fatura_Fin.SB_ConfirmarClick(Sender: TObject);
begin
  if Fc_validaParcelamento then
  Begin
    //Apaga o Parcelamento atual
    Nota.Pedido.Parcelamento.Registro.CodigoPedido := Nota.Pedido.Registro.Codigo;
    Nota.Pedido.Parcelamento.deletebyPedido;
    //Grava os prazos na tela do pedido
    Pc_GravaParcelamento;
    Pc_Gera_Financeiro;
    Pc_Obs_Financeira;
    It_Confirma := True;
    if ChBx_Duplicata.Checked then Pc_Imprime_Duplicata(It_cd_Nota);

    close;
  end;
end;

procedure TFr_Fatura_Fin.FormShow(Sender: TObject);
begin
  Pc_AtivarTabelas;
  Pc_FormataTela;
  Pc_IniciaVariaveis;
  Pc_MontaParcelamento;
  Pc_AlinhaVerticalParcelamento;
  Pc_TotalizarParcelamento;
  //Pc_Recalcular;
end;

procedure TFr_Fatura_Fin.Sb_NovaFormaPagtoClick(Sender: TObject);
begin
  if ( It_CodigoFPagto.Count < 6 ) then
  Begin
    It_CodigoFPagto.Add( IntToStr( It_CodigoFPagto.Count + 1 ) );
    Pc_CriarFrame('',
                  Nota.Registro.ValorNota,
                  Nota.Registro.DataEmissao);
  End
  else
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'O número máximo de Formas de pagamento foi atingido.' + EOLN +
                   'Não é possivel continuar.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
  End;

end;

procedure TFr_Fatura_Fin.Sb_ParcelarClick(Sender: TObject);
begin
  Scx_Parcela.Visible := False;
  Pc_LimpaParcelamento;
  Pc_CriaNovoParcelamento(E_Nr_PArcelas.Text);
  Pc_AlinhaVerticalParcelamento;
  Pc_TotalizarParcelamento;
  Scx_Parcela.Visible := True;
end;

procedure TFr_Fatura_Fin.Sb_VistaClick(Sender: TObject);
begin
  Scx_Parcela.Visible := False;
  Pc_LimpaParcelamento;
  Chbx_Entrada.Checked := False;
  ChBx_Vl_ST.Checked := False;
  Pc_CriaNovoParcelamento('1');
  Pc_AlinhaVerticalParcelamento;
  Scx_Parcela.Visible := True;
end;



procedure TFr_Fatura_Fin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(It_CodigoFPagto);
  FreeAndNil(Nota);
end;

procedure TFr_Fatura_Fin.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not It_Confirma then
  Begin
    canClose := False;
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por favor utilize o botão confirmar para continuar.',
                  ['OK'],[bEscape],mpAlerta);
  end;
end;

procedure TFr_Fatura_Fin.FormCreate(Sender: TObject);
begin
  It_CodigoFPagto := TStringList.Create;
  Nota := TControllerNotaFiscal.create(Self);
  PegaContaGerencialAuto := ( Fc_Tb_Geral('L','FIN_SET_CTA_GER_AUTO','S') = 'S');
end;

procedure TFr_Fatura_Fin.Pc_Gera_Financeiro;
var
  I : Integer;
  Lc_Baixa,Lc_Situacao,Lc_Etapa : String;
  Lc_LancaCaixa : boolean;
  //Novos
  Lc_Edit: TEdit;
  Lc_Valor, Lc_Vl_Troco :real;
  Lc_Dblookup : TDBLookupComboBox;
  Lc_cd_Forma_Pagto : Integer;
  Lc_Combo : TComboBox;
  Lc_Parcelas : Integer;
  Lc_ContaResultado : Integer;
  Lc_CentroCusto : Integer;
  Lc_Cd_Financeiro : Integer;
  Lc_Financeiro : TControllerFinanceiro;
  Lc_Cd_Quitacao : Integer;
  variavel : TComponent;
  MetodoPagamento : TFm_FormaPagto;
  Lc_Dt_Vencimento : TDateTimePicker;
  Lc_Historico : String;
  Lc_Vl_Credito,Lc_VL_Debito : Real;
  Lc_Nr_Parcelas : Integer;
  Lc_Form : TFr_Lanca_PlanoContas;
  LcBase : TControllerBase;
  CartaoEletronico : TControllerCartaoEletronico;
begin
  Lc_Vl_Troco :=StrToFloatDef(E_VL_Troco.Text,0);
  Lc_Nr_PArcelas := It_CodigoFPagto.Count;
  if not PegaContaGerencialAuto then
  BEgin
    Try
      Lc_Form := TFr_Lanca_PlanoContas.Create(nil);
      Lc_Form.Caption := 'Informe as Contas Gerenciais para o Financeiro';
      Lc_Form.Fm_CentroResultado.Visible := False;
      Lc_Form.ShowModal;
      //Centro de Custo observando a forma de pagamento
      Lc_CentroCusto := Lc_Form.CentroCusto;
      //Conta de resultado para o Financeiro não é necessario
      Lc_ContaResultado :=  Lc_Form.ContaResultado;
    Finally
      FreeAndNil(Lc_Form);
    End;
  End;

  for I := 0 to It_CodigoFPagto.Count - 1 do
  begin
    //Encontrar os campos para pegar os valores
    variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
    //Encontra o valor a receber
    Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
    Lc_Valor := (StrToFloatDef(Lc_Edit.Text,0));
    if (Lc_Valor > 0) then
    Begin
      //Encontra a forma de pagamento
      MetodoPagamento := TFm_FormaPagto(Fc_LocalizaComponente(variavel,TFm_FormaPagto));
      Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(MetodoPagamento,TDBLookupComboBox));
      Lc_cd_Forma_Pagto := Lc_Dblookup.KeyValue;
      //Data de Vencimento
      Lc_Dt_Vencimento := TDateTimePicker(Fc_LocalizaComponente(variavel,TDateTimePicker));
      //Encontra o parcelamento
      Lc_Combo := TComboBox(Fc_LocalizaComponente(variavel,TComboBox));
      Lc_Parcelas := StrToIntDef( Lc_Combo.Text , 1);
      //trata formas de pagamento que não seráo lancados em caixa.
      Lc_LancaCaixa := False;
      Lc_Baixa := 'N';
      Lc_Situacao := 'N';
      Lc_Cd_Quitacao := 0;
      Lc_Etapa := 'N';
      if ( ( Pos('DINHEIRO',Trim(Lc_Dblookup.text))>0) or
           (Pos('CHEQUE',Trim(Lc_Dblookup.text))>0) ) and
           ( Fc_Tb_Geral('L','FIN_FAT_BAIXA_AUTO','S') = 'S') then
      Begin
        Lc_LancaCaixa := True;
        Lc_Baixa := 'N';
        Lc_Situacao := 'D';
        Lc_Etapa := 'P';
        Lc_Cd_Quitacao := Fc_GeraCod_BAixa;
        if ( Pos('DINHEIRO',Trim(Lc_Dblookup.text))>0) then
        Begin
          Lc_Baixa := 'S';
          Lc_Vl_Troco := StrToFloatDef(E_VL_Troco.Text,0);
          if (Lc_Vl_Troco > 0) then
          Begin
            Lc_Valor := Lc_Valor - Lc_Vl_Troco;
          End;
        End;
        if (Pos('CHEQUE',Trim(Lc_Dblookup.text))>0) then
        Begin
          if (Fc_Tb_Geral('L','FIN_OB_INFO_CHEQUE_FATURAMENTO','N') = 'S') then
          Begin
            Pc_LancaDetalheCheque(Nota.Registro.CodigoPedido,
                                  Nota.Empresa.Registro.ApelidoFantasia,
                                  Lc_Valor,
                                  Lc_Dt_Vencimento.Date,
                                  (I + 1),
                                  Lc_Cd_Quitacao);
            Lc_Baixa := 'S';
          End;
        End;
      end
      else
      Begin
        Try
          CartaoEletronico := TControllerCartaoEletronico.Create(nil);
          CartaoEletronico.Registro.FormaPagamento := Lc_cd_Forma_Pagto;
          CartaoEletronico.getbyFormaPagto;
          if ( CartaoEletronico.exist) then
          Begin
            Lc_LancaCaixa := False;
            Lc_Cd_Quitacao := Fc_GeraCod_BAixa;
            Lc_Baixa := 'S';
            Lc_Situacao := 'D';
            Lc_Etapa := 'P';
            if (Fc_Tb_Geral('L','FIN_OB_INFO_CARTAO_FATURAMENTO','N') = 'S') then
            Begin
              CartaoEletronico.FormaPagto.Registro.Codigo := CartaoEletronico.Registro.FormaPagamento;
              CartaoEletronico.FormaPagto.getById;
              Pc_LancaDetalheCartao(CartaoEletronico.Registro.Codigo,
                                    CartaoEletronico.FormaPagto.Registro.Descricao,
                                    Lc_Parcelas,
                                    Lc_Cd_Quitacao);
            End;
            Pc_LancaValorCartao(CartaoEletronico.Registro.Codigo,
                                Lc_Valor,
                                Lc_Parcelas,
                                Lc_Cd_Quitacao,
                                Nota.Pedido.Registro.Numero.ToString());
          end;
        Finally
          FreeAndNil(CartaoEletronico);
        End;
      End;
      if PegaContaGerencialAuto Then
      BEgin
        //Centro de Custo observando a forma de pagamento
        Lc_CentroCusto := Fc_PegaCentroCustoFormaPagto( Lc_cd_Forma_Pagto );
        //Conta de resultado para o Financeiro não é necessario
        Lc_ContaResultado :=  0;
      end;

      //Lanca o valor no financeiro
      Try
        Lc_Financeiro := TControllerFinanceiro.Create(nil);
        with Lc_Financeiro.Registro do
        Begin
          Codigo := 0;
          CodigoEmpresa := Nota.Registro.CodigoEmpresa;
          DataFinanceiro := Date;
          CodigoPedido := Nota.Registro.CodigoPedido;
          CodigoNota   :=It_Cd_Nota;
          FormaPagamento := Lc_cd_Forma_Pagto;
          PrazoPagamento := Nota.Pedido.Registro.Prazo;
          DataVencimento := Lc_Dt_Vencimento.Date;
          if ( Trim( Nota.Registro.Numero ) <> '') then
            NumeroDuplicata := Nota.Pedido.Registro.Numero.ToString + '/' + Nota.Registro.Numero + '/' + IntToStr(I + 1) + '-' + IntToStr(Lc_Nr_PArcelas)
          else
            NumeroDuplicata := Nota.Pedido.Registro.Numero.ToString + '/' + Nota.Pedido.Registro.Numero.ToString + '/' + IntToStr(I + 1) + '-' + IntToStr(Lc_Nr_PArcelas);
          ValorParcela := Lc_Valor;
          NumeroParcela := I + 1;
          DocumentoBaixado := Lc_Baixa;
          if ( DocumentoBaixado = 'S' ) then
          Begin
            ValorPago := Lc_Valor;
            DataPagamento := Date;
            DataBaixa := DAte;
          End;
          ContaResultado := Lc_ContaResultado;
          CentroCusto := Lc_CentroCusto;
          TipoFinanceiro := It_Tipo_Finaceiro;
          SituacaoFinanceiro := Lc_Situacao;
          CodigoQuitacao := Lc_Cd_Quitacao;
          OperacaoFinanceiro := It_Oper_Financeiro;
          EtapaFinaceiro := Lc_Etapa;
          Estabelecimento := Gb_CodMha;
        End;
        Lc_Financeiro.salva;
      Finally
        FreeAndNil(Lc_Financeiro);
      End;


      //Lanca o valor no Caixa
      if Lc_LancaCaixa then
      Begin
        if PegaContaGerencialAuto Then
        BEgin
          //Conta de resultado para o Financeiro não é necessario
          Lc_ContaResultado :=  Fc_PegaContaResultadoFormaPagto( Lc_cd_Forma_Pagto );
        End
        else
        Begin
          try
            Lc_Form := TFr_Lanca_PlanoContas.Create(nil);
            Lc_Form.Caption := 'Informe as Contas Gerenciais para o Caixa';
            Lc_Form.Fm_CentroCusto.DBLCB_Plano.KeyValue := Lc_CentroCusto;
            Lc_Form.ShowModal;
            //Centro de Custo observando a forma de pagamento
            Lc_CentroCusto := Lc_Form.CentroCusto;
            //Conta de resultado para o Financeiro não é necessario
            Lc_ContaResultado :=  Lc_Form.ContaResultado;
          finally
            FreeAndNil(Lc_Form);
          end;
        End;
        Lc_Vl_Credito := 0;
        Lc_VL_Debito := 0;
        if It_Tipo_Finaceiro = 'RA' then
        Begin
          Lc_Historico := 'VENDA Nº ' + Nota.Pedido.Registro.Numero.ToString + ' | ' + Nota.Empresa.Registro.ApelidoFantasia;
          Lc_Vl_Credito := Lc_Valor;
        End
        else
        Begin
          Lc_Historico := 'COMPRA Nº ' + Nota.Pedido.Registro.Numero.ToString + ' | ' + Nota.Empresa.Registro.ApelidoFantasia;
          Lc_VL_Debito := Lc_Valor;
        End;

        //Lanca o valor no financeiro
        Try
          Lc_Financeiro := TControllerFinanceiro.Create(nil);
          with Lc_Financeiro.Movimento.Registro do
          Begin
            Codigo            := 0;
            ContaCorrente     := 0;
            Data              := Gb_DataCaixa;
            HistoricoBancario := 0;
            PL_Credito        := Lc_ContaResultado;
            PL_Debito         := Lc_CentroCusto;
            ValorCredito      := Lc_Vl_Credito;
            ValorDebito       := Lc_VL_Debito;
            Historico         := Lc_Historico;
            Tipo              := It_Oper_Financeiro;
            Quitacao          := Lc_Cd_Quitacao;
            Usuario           := GB_Cd_Usuario;
            Especie           := 'S';
            ValorFuturo       := 0;
            DataOriginal      := Gb_DataCaixa;
            NrDocumento       := '';
            Conferido         := 'N';
            FormaPagto        := Lc_cd_Forma_Pagto;
            Estabelecimento   := Gb_CodMha;
          End;
          Lc_Financeiro.Movimento.insere;
        Finally
          FreeAndNil(Lc_Financeiro);
        End;
      End;
    end;
  end;
End;

procedure TFr_Fatura_Fin.Pc_Obs_Financeira;
var
  I: Integer;
  Lc_Fim: Integer;
  lc_texto: string;
  Lc_Par: Boolean;
begin
{
  For I := 1 to It_CodigoFPagto.Count do
  begin
    if I = 1 then
    Begin
     lc_texto := ' | Parcela(s): ' + StGrd_Prazo.Cells[1, lc_I] + ' - ' + StGrd_Prazo.Cells[2, lc_I];
    end
    else
    Begin
      if Lc_I = Lc_Fim then
      Begin
        lc_texto := lc_texto + ' | ' + StGrd_Prazo.Cells[1, lc_I] + ' - ' + StGrd_Prazo.Cells[2, lc_I] + ' | ';
      end
      else
      BEgin
        lc_texto := lc_texto + ' | ' + StGrd_Prazo.Cells[1, lc_I] + ' - ' + StGrd_Prazo.Cells[2, lc_I];
      end;
    end;
  end;

  if Length(lc_texto) > 0 then
    Begin
    Pc_Observacao(DM.IBT_Financeiro,
                  'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'A',
                   lc_texto);

    end;
    }
end;
end.
