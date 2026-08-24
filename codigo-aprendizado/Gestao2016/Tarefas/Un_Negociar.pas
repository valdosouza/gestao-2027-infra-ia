unit Un_Negociar;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, DB, StdCtrls, DBCtrls, Mask, ExtCtrls, STQuery, Printers, UN_NF, ComCtrls, Grids, QEdit_Setes, Datasnap.DBClient, ControllerFinanceiro;

type
  TFr_Negociar = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Fechar: TSpeedButton;
    Panel3: TPanel;
    StGrd_Prazo: TStringGrid;
    Tpk_Prazo: TDateTimePicker;
    GroupBox6: TGroupBox;
    E_VL_Doc: TEdit_Setes;
    Sb_Calcular: TSpeedButton;
    E_Nr_PArcelas: TEdit_Setes;
    Label8: TLabel;
    Lb_VL_Total: TLabel;
    cds_Financeiro: TClientDataSet;
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure SB_FecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure StGrd_PrazoClick(Sender: TObject);
    procedure Tpk_PrazoChange(Sender: TObject);
    procedure Sb_CalcularClick(Sender: TObject);
    procedure StGrd_PrazoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StGrd_PrazoSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);

  private
    { Private declarations }
  public
    { Public declarations }
    It_Ctrl_Tela : String;
    It_StrGridDuplicata : TStringGrid;
    It_Qt_Parcelas : Integer;
    It_VL_Duplicatas: Currency;
    It_Cd_Empresa : Integer;
    It_Dt_Emissao : TDate;
    It_Fin_Operacao : String;
    It_FormaPagto : Integer;
    Financeiro:TControllerFinanceiro;
    procedure Pc_Faturar;
    Procedure Pc_MontaPrazo(Pc_Qt_Parcela : Integer ; Pc_Valor :Real);
    procedure Pc_Parcela_Receber;
    procedure Pc_Parcela_Pagar;
    procedure Pc_Parcela_ContasReceberBoleto;
    Function fc_ValidaFaturamento():Boolean;
    Function Fc_prazo:string;
  end;

var
  Fr_Negociar: TFr_Negociar;

implementation


uses     Un_DM, Un_Msg, Un_Funcoes, UN_FormaPagto, UN_Sistema, Un_Fc_Sored_Procedures, RN_FormaPagto, UN_Principal, env;
{$R *.dfm}

procedure TFr_Negociar.Pc_Parcela_Receber;
Var
  Lc_I : Integer;
  Lc_Nr_Divida : Integer;
  Lc_Obs_Neg : string;
  Lc_Nfl_Codigo : Integer;
  Lc_Ped_Numero : String;
  Lc_Ped_Codigo : Integer;
  Lc_cd_Resultado : Integer;
  Lc_cd_CentroCusto : Integer;
  Lc_Nr_Parcelas : Integer;
  Lc_Prazo : String;
  Lc_Data : TDate;
  Lc_dia : Real;
  Lc_Qr_Nota : TSTQuery;
BEgin
  if not cds_Financeiro.Active then cds_Financeiro.Active := True;
  cds_Financeiro.First;
  while not cds_Financeiro.Eof do
  Begin
    //Variaveis do Prazo
     Lc_Data := StrToDateDef(StGrd_Prazo.Cells[1,Lc_I],date);
    Lc_Dia := Lc_Data - NOW;
    IF Lc_Dia < 0 then Lc_Dia := 0;
    //Define o Numero do Financeiro
    if  cds_Financeiro.Bof then
    Begin
      Lc_Obs_Neg := 'Renegociados os Pedidos: ' +  cds_Financeiro.FieldByName('PED_NUMERO').AsString;
    end
    else
    Begin
      Lc_Obs_Neg := Lc_Obs_Neg + '\' + cds_Financeiro.FieldByName('PED_NUMERO').AsString;
    end;
    cds_Financeiro.next;
  end;
  //Define os indices da ultima parcela da negociação para edição dos registros
  Lc_Ped_Codigo     := cds_Financeiro.FieldByName('PED_CODIGO').AsInteger;
  Lc_Ped_Numero     := cds_Financeiro.FieldByName('PED_NUMERO').AsString;
  Lc_Nfl_Codigo     := cds_Financeiro.FieldByName('NFL_CODIGO').AsInteger;
  Lc_cd_Resultado   := cds_Financeiro.FieldByName('PLC_CODIGO').AsInteger;
  Lc_cd_CentroCusto := cds_Financeiro.FieldByName('PLC_CODIGO').AsInteger;
  //Atualiza a nota Fiscal Vinculada
  Pc_Observacao(DM.IB_Transacao,
                  'I',
                  0,
                  0,
                  Lc_Nfl_Codigo,
                  'M',
                  Lc_Obs_Neg);


  Lc_Nr_Parcelas := StGrd_Prazo.RowCount-1;
  Lc_Prazo:= Fc_prazo;
  For Lc_I := 1 to Lc_Nr_Parcelas do
  Begin
    //Lanca o Financeiro
    Financeiro.Clear;
    Financeiro.Registro.Codigo              :=  0;
    Financeiro.Registro.CodigoEmpresa       :=  It_Cd_Empresa;
    Financeiro.Registro.DataFinanceiro      :=  Date;
    Financeiro.Registro.CodigoPedido        :=  Lc_Ped_Codigo;
    Financeiro.Registro.CodigoNota          :=  Lc_Nfl_Codigo;
    Financeiro.Registro.FormaPagamento      :=  It_FormaPagto;
    Financeiro.Registro.PrazoPagamento      :=  Lc_Prazo;
    Financeiro.Registro.DataVencimento      := StrToDate(StGrd_Prazo.cells[1,Lc_I]);
    Financeiro.Registro.NumeroDuplicata     := Lc_Ped_Numero + '/' + IntToStr(Lc_I) + '-' + IntToStr(Lc_Nr_Parcelas);
    Financeiro.Registro.ValorParcela        := StrToFloatDef(StGrd_Prazo.cells[2,Lc_I],0);
    Financeiro.Registro.NumeroParcela       := Lc_I;
    Financeiro.Registro.DocumentoBaixado    := 'N';
    Financeiro.Registro.ContaResultado      := Lc_cd_Resultado;
    Financeiro.Registro.CentroCusto         := Lc_cd_CentroCusto;
    Financeiro.Registro.TipoFinanceiro      := 'RA';
    Financeiro.Registro.SituacaoFinanceiro  := 'N';
    Financeiro.Registro.CodigoQuitacao      := 0;
    Financeiro.Registro.OperacaoFinanceiro  := 'C';
    Financeiro.Registro.EtapaFinaceiro      := 'N';
    Financeiro.Registro.Estabelecimento     := Gb_CodMha;
    Financeiro.insere;
  end;

  //Apaga as parcelas que seráo negociadas
  cds_Financeiro.First;
  while not cds_Financeiro.Eof do
  Begin
    Financeiro.Registro.Codigo := cds_Financeiro.FieldByName('FIN_CODIGO').AsInteger;
    Financeiro.delete;
    cds_Financeiro.next;
  end;
end;

procedure TFr_Negociar.Pc_Parcela_Pagar;
Var
  Lc_I : Integer;
  Lc_Nr_Divida : Integer;
  Lc_Obs_Neg : string;
  Lc_Nfl_Codigo : Integer;
  Lc_Ped_Numero : String;
  Lc_Ped_Codigo : Integer;
  Lc_cd_Resultado : Integer;
  Lc_cd_CentroCusto : Integer;
  Lc_Nr_Parcelas : Integer;
  Lc_Prazo : String;
  Lc_Data : TDate;
  Lc_dia : Real;
  Lc_Qr_Nota : TSTQuery;
BEgin
  if not cds_Financeiro.Active then cds_Financeiro.Active := True;
  cds_Financeiro.First;
  while not cds_Financeiro.Eof do
  Begin
    //Variaveis do Prazo
    Lc_Data := StrToDateDef(StGrd_Prazo.Cells[1,Lc_I],date);
    Lc_Dia := Lc_Data - Date;
    IF Lc_Dia < 0 then Lc_Dia := 0;
    //Define o Numero do Financeiro
    if  cds_Financeiro.Bof then
    Begin
      Lc_Obs_Neg := 'Renegociados os Pedidos: ' + cds_Financeiro.FieldByName('PED_NUMERO').AsString;
    end
    else
    Begin
      Lc_Obs_Neg := Lc_Obs_Neg + '\' + cds_Financeiro.FieldByName('PED_NUMERO').AsString;
    end;
    cds_Financeiro.next;
  end;

  //Define os indices da ultima parcela da negociação para edição dos registros
  Lc_Ped_Codigo     := cds_Financeiro.FieldByName('PED_CODIGO').AsInteger;
  Lc_Ped_Numero     := cds_Financeiro.FieldByName('PED_NUMERO').AsString;
  Lc_Nfl_Codigo     := cds_Financeiro.FieldByName('NFL_CODIGO').AsInteger;
  Lc_cd_Resultado   := cds_Financeiro.FieldByName('PLC_CODIGO').AsInteger;
  Lc_cd_CentroCusto := cds_Financeiro.FieldByName('PLC_CODIGO').AsInteger;
  //Atualiza a nota Fiscal Vinculada
  Pc_Observacao(DM.IB_Transacao,
                'I',
                0,
                0,
                Lc_Nfl_Codigo,
                'M',
                Lc_Obs_Neg);

  Lc_Nr_Parcelas := StGrd_Prazo.RowCount-1;
  Lc_Prazo:= Fc_prazo;
  For Lc_I := 1 to Lc_Nr_Parcelas do
  Begin
    //Lanca o Financeiro
    Financeiro.Clear;
    Financeiro.Registro.Codigo              :=  0;
    Financeiro.Registro.CodigoEmpresa       :=  It_Cd_Empresa;
    Financeiro.Registro.DataFinanceiro      :=  Date;
    Financeiro.Registro.CodigoPedido        :=  Lc_Ped_Codigo;
    Financeiro.Registro.CodigoNota          :=  Lc_Nfl_Codigo;
    Financeiro.Registro.FormaPagamento      :=  It_FormaPagto;
    Financeiro.Registro.PrazoPagamento      :=  Lc_Prazo;
    Financeiro.Registro.DataVencimento      := StrToDate(StGrd_Prazo.cells[1,Lc_I]);
    Financeiro.Registro.NumeroDuplicata     := Lc_Ped_Numero + '/' + IntToStr(Lc_I) + '-' + IntToStr(Lc_Nr_Parcelas);
    Financeiro.Registro.ValorParcela        := StrToFloatDef(StGrd_Prazo.cells[2,Lc_I],0);
    Financeiro.Registro.NumeroParcela       := Lc_I;
    Financeiro.Registro.DocumentoBaixado    := 'N';
    Financeiro.Registro.ContaResultado      := Lc_cd_Resultado;
    Financeiro.Registro.CentroCusto         := Lc_cd_CentroCusto;
    Financeiro.Registro.TipoFinanceiro      := 'PA';
    Financeiro.Registro.SituacaoFinanceiro  := 'N';
    Financeiro.Registro.CodigoQuitacao      := 0;
    Financeiro.Registro.OperacaoFinanceiro  := 'D';
    Financeiro.Registro.EtapaFinaceiro      := 'N';
    Financeiro.Registro.Estabelecimento     := Gb_CodMha;
    Financeiro.insere;
  end;

  cds_Financeiro.First;
  while not cds_Financeiro.Eof do
  Begin
    //Apaga as parcelas que seráo negociadas
    Financeiro.Registro.Codigo := cds_Financeiro.FieldByName('FIN_CODIGO').AsInteger;
    Financeiro.delete;

    cds_Financeiro.next;
  end;

end;

procedure TFr_Negociar.Pc_Parcela_ContasReceberBoleto;
Var
  Lc_I : Integer;
  Lc_Nr_Divida : Integer;
  Lc_Obs_Neg : string;
  Lc_Nfl_Codigo : Integer;
  Lc_Ped_Numero : String;
  Lc_Ped_Codigo : Integer;
  Lc_cd_Resultado : Integer;
  Lc_cd_CentroCusto : Integer;
  Lc_Nr_Parcelas : Integer;
  Lc_Prazo : String;
  Lc_Data : TDate;
  Lc_dia : Real;
  Lc_Qr_Nota : TSTQuery;
BEgin
  with It_StrGridDuplicata do
  Begin
    Lc_Nr_Parcelas := RowCount-1;
    Lc_Nr_Divida  := RowCount - 1;
    For Lc_I := 1 to Lc_Nr_Divida do
    Begin
      //Variaveis do Prazo
      Lc_Data := StrToDateDef(StGrd_Prazo.Cells[1,Lc_I],date);
      Lc_Dia := Lc_Data - NOW;
      IF Lc_Dia < 0 then Lc_Dia := 0;
      //Define o Numero do Financeiro
      if (Lc_I = 1) then
      Begin
        Lc_Obs_Neg := 'Renegociados os Pedidos: ' + Cells[4,Lc_I];
      end
      else
      Begin
        Lc_Obs_Neg := Lc_Obs_Neg + '\' + Cells[4,Lc_I];
      end;
      //Define os indices da ultima parcela da negociação para edição dos registros
      if  Lc_I = Lc_Nr_Divida then
      Begin
        Lc_Ped_Codigo := StrToIntDef(cells[16,lc_I],0);
        Lc_Ped_Numero := cells[4,lc_I];
        Lc_Nfl_Codigo := StrToInt(cells[17,lc_I]);
      end;
    end;
    //Atualiza a nota Fiscal Vinculada
    Pc_Observacao(DM.IB_Transacao,
                  'I',
                  0,
                  0,
                  Lc_Nfl_Codigo,
                  'M',
                  Lc_Obs_Neg);
    Lc_Nr_Parcelas := StGrd_Prazo.RowCount-1;
    Lc_Prazo:= Fc_prazo;
    For Lc_I := 1 to Lc_Nr_Parcelas do
    Begin
      //Lanca o Financeiro
      Financeiro.Clear;
      Financeiro.Registro.Codigo              :=  0;
      Financeiro.Registro.CodigoEmpresa       :=  It_Cd_Empresa;
      Financeiro.Registro.DataFinanceiro      :=  Date;
      Financeiro.Registro.CodigoPedido        :=  Lc_Ped_Codigo;
      Financeiro.Registro.CodigoNota          :=  Lc_Nfl_Codigo;
      Financeiro.Registro.FormaPagamento      :=  Fc_PegaFormaPgto('BOLETO');
      Financeiro.Registro.PrazoPagamento      :=  Lc_Prazo;
      Financeiro.Registro.DataVencimento      := StrToDate(StGrd_Prazo.cells[1,Lc_I]);
      Financeiro.Registro.NumeroDuplicata     := Lc_Ped_Numero + '/' + IntToStr(Lc_I) + '-' + IntToStr(Lc_Nr_Parcelas);
      Financeiro.Registro.ValorParcela        := StrToFloatDef(StGrd_Prazo.cells[2,Lc_I],0);
      Financeiro.Registro.NumeroParcela       := Lc_I;
      Financeiro.Registro.DocumentoBaixado    := 'N';
      Financeiro.Registro.ContaResultado      := Lc_cd_Resultado;
      Financeiro.Registro.CentroCusto         := Lc_cd_CentroCusto;
      Financeiro.Registro.TipoFinanceiro      := 'RA';
      Financeiro.Registro.SituacaoFinanceiro  := 'N';
      Financeiro.Registro.CodigoQuitacao      := 0;
      Financeiro.Registro.OperacaoFinanceiro  := 'C';
      Financeiro.Registro.EtapaFinaceiro      := 'N';
      Financeiro.Registro.Estabelecimento     := Gb_CodMha;
      Financeiro.insere;
    end;
  end;

  //Apaga as parcelas que seráo negociadas
  For Lc_I := 1 to Lc_Nr_Divida do
  Begin
    Financeiro.Clear;
    Financeiro.Registro.Codigo := StrToIntDef(It_StrGridDuplicata.Cells[3,Lc_I],0);
    Financeiro.delete;
  end;
end;


Function TFr_Negociar.fc_ValidaFaturamento():Boolean;
Var
  Lc_I : Integer;
  Lc_vl_total : Real;
Begin
  Lc_vl_total := 0;
  For Lc_I := 1 to StGrd_Prazo.RowCount - 1 do
    Begin
    Lc_vl_total := Lc_vl_total + StrToFloatDef(StGrd_Prazo.Cells[2,Lc_I],0);
    end;
  Lb_VL_Total.Caption := FloatToStrF(Lc_vl_total,ffFixed,10,2);

  if (E_VL_Doc.Text = Lb_VL_Total.Caption) then
    Begin
    Result := true;
    end
  else
    Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Valor Total e Valores parcelados não coincidem.'+EOLN+
                   'Verifique os valores do parcelamento.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
    end;
end;


procedure TFr_Negociar.Pc_Faturar;
Begin
  //Inicia o Faturamento
  Try
    if ( It_Ctrl_Tela = 'Fr_Receber_Multipla') then Pc_Parcela_Receber;
    if ( It_Ctrl_Tela = 'Fr_Pagar_Multipla' ) then Pc_Parcela_Pagar;
    if ( It_Ctrl_Tela = 'Fr_ContasReceberBoleto') then Pc_Parcela_ContasReceberBoleto;
  
    MensagemPadrao(MENSAGEM,TITULO_CONFIRMACAO+EOLN+EOLN+
                   'Lançamento realizado com Sucesso.'+EOLN,
                   ['OK'],[bEscape],mpConfirmacao);
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    Close;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Erro ao gerar Lançamento.'+EOLN+
                   'Verifique os dados do Lançamento.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    DM.IB_Transacao.RollbackRetaining;
  end;
end;





procedure TFr_Negociar.SB_ConfirmarClick(Sender: TObject);
begin
  IF fc_ValidaFaturamento then
    Pc_Faturar;
end;


procedure TFr_Negociar.SB_FecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Negociar.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;

end;

procedure TFr_Negociar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F2  : if Sb_Calcular.Enabled then Sb_CalcularClick(Sender);
      VK_F10  : if SB_Confirmar.Enabled then SB_ConfirmarClick(Sender);
      VK_ESCAPE : If SB_Fechar.Enabled then SB_FecharClick(Sender);
    end;
    end;
end;

procedure TFr_Negociar.FormCreate(Sender: TObject);
begin
  //Controladores
  Financeiro := TControllerFinanceiro.create(Self);
  Pc_Define_FormatoRegional;
  Tpk_Prazo.Date := Date;
  Pc_MontaPrazo(1,0);

end;

Procedure TFr_Negociar.Pc_MontaPrazo(Pc_Qt_Parcela : Integer; Pc_Valor :Real);
Var
  Lc_St_Parcela : String;
  Lc_Vl_Parcela : Real;
  Lc_I : Integer;
  Lc_Prazo : TDate;
  Lc_Tamanho:Integer;
Begin
  StGrd_Prazo.RowCount := 2;
  StGrd_Prazo.FixedRows := 1;
  StGrd_Prazo.Cells[1,0]:='Vencimento';
  StGrd_Prazo.Cells[2,0]:='Valor';

  Tpk_Prazo.Top:= StGrd_Prazo.Top+21;
  Tpk_Prazo.DateTime:=Now;
  Tpk_Prazo.Visible:=tRUE;
  Lc_Tamanho:=0;
  StGrd_Prazo.Height:=20;
  Tpk_Prazo.Left:=StGrd_Prazo.Left+21;
  StGrd_Prazo.ColWidths[0]:=20;
  StGrd_Prazo.ColWidths[1]:=86;
  StGrd_Prazo.ColWidths[2]:=86;
  StGrd_Prazo.RowCount := 2;

  It_Qt_Parcelas := Pc_Qt_Parcela;
  It_VL_Duplicatas := Pc_Valor;

  IF StrToIntDef(E_Nr_PArcelas.Text,0) = 0 then
    Begin
    StGrd_Prazo.Cells[2,1]:= FloatToStrF(It_VL_Duplicatas,ffFixed,10,2);
    StGrd_Prazo.Cells[1,1]:=  DateToStr(It_Dt_Emissao);
    end
  else
    Begin
    For Lc_I := 0 to (It_Qt_Parcelas-1) do
      Begin
      StGrd_Prazo.Cells[0,Lc_I+1]:=IntToStr(Lc_I+1);
      Lc_Tamanho:=StrToInt((FloatToStrF((21)+(21*((20-Lc_I)/100)),ffFixed,3,0)));
      StGrd_Prazo.Height:=StGrd_Prazo.Height + Lc_Tamanho;
      end;
    StGrd_Prazo.RowCount:= It_Qt_Parcelas + 1;
    StGrd_Prazo.Width:=213;
    Tpk_Prazo.DateTime:=It_Dt_Emissao;

    //Resolvemos o problema da Divisão e dizima periodica
    Lc_St_Parcela := FloatToStrF((It_VL_Duplicatas / It_Qt_Parcelas),ffFixed,10,2);
    Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);
    Lc_Prazo := It_Dt_Emissao;
    For Lc_I := 0 to (It_Qt_Parcelas-1) do
      begin
      if not (Lc_I = (It_Qt_Parcelas-1)) then
        StGrd_Prazo.Cells[2,Lc_I+1]:=(Lc_St_Parcela)
      else
        StGrd_Prazo.Cells[2,Lc_I+1]:= FloatToStrF((It_VL_Duplicatas -(Lc_Vl_Parcela * (It_Qt_Parcelas-1))),ffFixed,10,2);
      StGrd_Prazo.Cells[1,Lc_I+1]:=  DateToStr(Lc_Prazo);
      Lc_Prazo := Lc_Prazo + 30;
      end;
  end;
end;




procedure TFr_Negociar.StGrd_PrazoClick(Sender: TObject);
begin
  Tpk_Prazo.Top:= StGrd_Prazo.Top+21+(21* (StGrd_Prazo.Row-1));
  Tpk_Prazo.DateTime:=StrToDateDef(StGrd_Prazo.Cells[1,(StGrd_Prazo.Row)],Date);
  Tpk_Prazo.Visible:=tRUE;

end;

procedure TFr_Negociar.Tpk_PrazoChange(Sender: TObject);
begin
  StGrd_Prazo.Cells[1,(StGrd_Prazo.Row)]:=DateToStr(Tpk_Prazo.DateTime);
  Tpk_Prazo.Visible:=False;
end;

procedure TFr_Negociar.Sb_CalcularClick(Sender: TObject);
begin
  If (StrToFloatDef(E_Nr_PArcelas.Text,0)>0) and (StrToFloatDef(E_VL_Doc.Text,0)>0) then
    Pc_MontaPrazo(StrToIntDef(E_Nr_PArcelas.Text,1),StrToFloatDef(E_VL_Doc.Text,0));
  Lb_VL_Total.Caption := E_VL_Doc.Text;
end;

procedure TFr_Negociar.StGrd_PrazoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  WITH StGrd_Prazo DO
  Begin
    If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
    if (Cells[14,arow]='X') then
    begin // verifica se a linha impar
      Canvas.Font.Color:= clBlack;
      Canvas.Brush.Color:= clBtnFace;
    end
    else
    begin
      Canvas.Font.Color:= clBlack;
      Canvas.Brush.Color:= clMoneyGreen
    end;
    Canvas.FillRect(Rect); // redesenha a celula
    Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.

    { Pega o texto da célula }
    Texto := Cells[acol, ARow];
    if ACol = 2 then Texto := FloatToStrF(StrToFloatDef(Texto,0),ffFixed,10,2);

    { Calcura largura e altura (em pontos) do texto }
    LarguraTexto := Canvas.TextWidth(Texto);
    AlturaTexto := Canvas.TextHeight(Texto);
    { Calcula a posição horizontal do início do texto }
    if  (ACol = 0) then { esquerda }
      X := Rect.Left + 2
    else if  (ACol = 13) then { Centro }
      X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
    else { Direita }
    X := Rect.Right - LarguraTexto - 2;
    { Calcula a posição vertical do início do texto para
      que seja impresso no centro (verticalmente) da célula }
    Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -  AlturaTexto div 2;

    { Pinta o texto }
    StGrd_Prazo.Canvas.TextRect(Rect, X, Y, Texto);
  End;
end;

procedure TFr_Negociar.StGrd_PrazoSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
Var
  lc_TL : Real;
  LC_I : Integer;
begin
  if ACol = 2 then
    Begin
    lc_TL:=0;
    for LC_I := 1 to StGrd_Prazo.RowCount - 1 do
      lc_TL := lc_TL + StrToFloatDef(StGrd_Prazo.Cells[2,LC_I],0);
    Lb_VL_Total.Caption := FloatToStrF(lc_TL,ffFixed,10,2);
    end;

end;

function TFr_Negociar.Fc_prazo: string;
Var
  Lc_I : Integer;
  Lc_Nfl_Codigo : Integer;
  Lc_Ped_Numero : String;
  Lc_Ped_Codigo : Integer;

  Lc_Nr_Parcelas : Integer;
  Lc_Prazo : String;
  Lc_Data : TDate;
  Lc_dia : Real;
begin
  Lc_Nr_Parcelas := StGrd_Prazo.RowCount-1;
  For Lc_I := 1 to Lc_Nr_Parcelas do
    Begin
    //Variaveis do Prazo
     Lc_Data := StrToDateDef(StGrd_Prazo.Cells[1,Lc_I],date);
    Lc_Dia := Lc_Data - NOW;
    IF Lc_Dia < 0 then Lc_Dia := 0;
    //Define o Numero do Financeiro
    if  Lc_I = 1 then
      Begin
      Lc_Prazo :=   StrZero(StrToFloatDef(E_Nr_PArcelas.Text,0),3,0) + ' - '  +  StrZero(Lc_Dia,3,0);
      end
    else
      Begin
      Lc_Prazo := Lc_Prazo + '\' + StrZero(Lc_Dia,3,0);
      end;
  end;
  Result:= COPY(Lc_Prazo,1,200);
end;
end.


