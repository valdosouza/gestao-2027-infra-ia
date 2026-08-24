unit Un_PizzariaEntrega;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, ControllerComissao, Vcl.Menus, STDatabase, QEdit_Setes, Vcl.DBCtrls, ControllerBase, STTransaction,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type

  TFr_PizzariaEntrega = class(TForm)
    Ds_Pesquisa: TDataSource;
    Qr_Pesquisa: TSTQuery;
    StrGrd_Entrega: TStringGrid;
    IBT_Entrega: TSTTransaction;
    Qr_PesquisaPED_CODIGO: TIntegerField;
    Qr_PesquisaPED_NUMERO: TIntegerField;
    Qr_PesquisaEMP_CODIGO: TIntegerField;
    Qr_PesquisaEMP_NOME: TStringField;
    Qr_PesquisaPEG_CODMOT: TIntegerField;
    Qr_PesquisaCLB_NOME: TStringField;
    Qr_PesquisaPED_VL_PEDIDO: TBCDField;
    Qr_PesquisaPEG_TM_PEDIDO: TStringField;
    Qr_PesquisaPEG_TM_SAIDA: TStringField;
    Qr_PesquisaPEG_DURACAO: TStringField;
    Qr_PesquisaPED_DATA: TDateField;
    Qr_PesquisaPED_VL_FRETE: TBCDField;
    Qr_PesquisaVALUE_CHANGE: TBCDField;
    Qr_PesquisaVALUE_RECIVED: TBCDField;
    Pnl_Entrega: TPanel;
    Label53: TLabel;
    Label5: TLabel;
    dblcb_MudaMotoboy: TDBLookupComboBox;
    Sb_confirma: TButton;
    Sb_cancela: TButton;
    PopupMenu1: TPopupMenu;
    AlterarMotoboy1: TMenuItem;
    Qr_PesquisaPEG_TM_FINAL: TStringField;
    Qr_PesquisaEND_FONE: TStringField;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    E_BuscaFone: TEdit;
    E_BuscaCliente: TEdit;
    DBLCB_Busca_Motoboy: TDBLookupComboBox;
    Chbx_Faturado: TCheckBox;
    Rg_Situacao: TRadioGroup;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    E_Vl_Selecionado: TEdit_Setes;
    E_VL_Troco: TEdit_Setes;
    E_VL_Receber: TEdit_Setes;
    DBLCB_Motoboy: TDBLookupComboBox;
    Sb_liberar: TSpeedButton;
    Sb_Retorno: TSpeedButton;
    Sb_Buscar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StrGrd_EntregaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Sb_liberarClick(Sender: TObject);
    procedure Sb_RetornoClick(Sender: TObject);
    procedure Rg_SituacaoClick(Sender: TObject);
    procedure Sb_BuscarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure DBLCB_Busca_MotoboyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StrGrd_EntregaClick(Sender: TObject);
    procedure Qr_PesquisaCalcFields(DataSet: TDataSet);
    procedure DBLCB_MotoboyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AlterarMotoboy1Click(Sender: TObject);
    procedure Sb_cancelaClick(Sender: TObject);
    procedure Sb_confirmaClick(Sender: TObject);
  private
    { Private declarations }
    Procedure Pc_FormataTela;
    procedure Pc_AtivarTabelas;
    procedure Pc_IniciaVAriaveis;
    procedure Pc_ImagemBotao;
    function Fc_VerificaMarcado(Fc_grid:TStringGrid):Boolean;
    function Fc_VerificaQtdeMarcado(Fc_grid:TStringGrid):Boolean;
    Function  Fc_ValidaEntrega():Boolean;
    Function  Fc_ValidaRetorno():Boolean;
    Function  Fc_ValidaTrocaMotoboy():Boolean;
    procedure Pc_LiberarEntrega;
    procedure EnviaWhatsApp(Fone:String);
    procedure Pc_AvisarViaWhatsApp;
    procedure Pc_AlteraMotoboy;
  public
    { Public declarations }
    procedure Pc_Buscar;
    procedure Pc_Preencher;
    Procedure Pc_totalizador;

    procedure Pc_Baixa_Retorno(Indice:Integer);
    procedure Pc_GeraDiaria(Indice:Integer);
    procedure Pc_GeraComissao(Indice:Integer);

   procedure Pc_Cancela_Entrega(Pc_Codigo:String);
  end;

var
  Fr_PizzariaEntrega: TFr_PizzariaEntrega;

implementation

uses     Un_DM, UN_Sistema, UN_MSG, Un_Regra_Negocio, UN_Principal, env, UN_TabelasEmListas, Un_Fc_Sored_Procedures, RI_MovimentoFinanceiro, WhatsApp;
{$R *.DFM}

Procedure TFr_PizzariaEntrega.Pc_FormataTela;
Var
  Lc_I:Integer;
Begin
  //Colunas Fixas
  with StrGrd_Entrega,Qr_Pesquisa do
  Begin
    ColCount := FieldCount + 3;
    ColWidths[0]:=17;
    ColWidths[1]:=54;
    ColWidths[2]:=-1;
    Cols[1].Add('Selecionar');
    For Lc_I:= 0 to FieldCount -1 do
    Begin
      ColWidths[Lc_I + 3]:= Fields[Lc_I].Tag;
      Cols[Lc_I + 3].Add(Fields[Lc_I].DisplayLabel);
    end;
  end;
end;

procedure TFr_PizzariaEntrega.Pc_AtivarTabelas;
Begin
  DM_ListaConsultas.Pc_ListaMotoboy;
end;

procedure TFr_PizzariaEntrega.Pc_AvisarViaWhatsApp;
var
  LcThread : TThread;
begin
  if ( Fc_Tb_Geral('L','WTA_LC_ATIVO','N') = 'S') then
  Begin
    LcThread := TThread.CreateAnonymousThread(
      procedure
      Var
        LcW : TWhatsApp;
      begin
        try
          LcW := TWhatsApp.create(nil);
           LcW.ReceiverNumber := '554199112072';
          //LcW.CodigoPedido := Self.It_Cd_Pedido;
          //LcW.SendOrder;
        finally
          LcW.disposeOf;
          LcThread.terminate;
        end;
      end
    );
    LcThread.FreeOnTerminate := True;
    LcThread.start();
  End;
end;

procedure TFr_PizzariaEntrega.Pc_IniciaVariaveis;
Begin
  Rg_SituacaoClick(Self);
end;

procedure TFr_PizzariaEntrega.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    Sb_Buscar.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

procedure TFr_PizzariaEntrega.Pc_Cancela_Entrega(Pc_Codigo:String);
vAR
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'UPDATE TB_PIZ_ENTREGA SET '+
                   ' PEG_TM_SAIDA = NULL '+
                   'WHERE (PEG_CODPED =:PED_CODIGO) ';
      Active := False;
      SQL.Add(Lc_SqlTxt);
      ParamByName('PED_CODIGO').AsString := Pc_Codigo;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;


procedure TFr_PizzariaEntrega.Pc_GeraDiaria(Indice:Integer);
Var
  Lc_I : Integer;
  lc_Sqltxt : String;
  Lc_Qry : TSTQuery;
  Lc_ValorDiaria : Real;
  LcComissao : TControllerComissao;
Begin
  Lc_ValorDiaria := StrToFloatDef(Fc_Tb_Geral('L','PIZ_DIAR_MOTOBOY','0,00'),0);
  if Lc_ValorDiaria > 0 then
  begin
    Lc_Qry := TSTQuery.Create(self);
    with Lc_Qry  do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := IBT_Entrega;
      ForcedRefresh := True;
      if Transaction.InTransaction then Transaction.Commit else Transaction.StartTransaction;
      Active := False;
      SQL.Clear;
      lc_Sqltxt := 'select 1 '+
                   'FROM TB_COMISSAO  '+
                   'WHERE (COM_CODVDO =:COM_CODVDO) '+
                   ' AND (COM_VL_COM =:COM_VL_COM) '+
                   ' AND (COM_TIPO =:COM_TIPO ) '+
                   ' AND (COM_DT_VENDA=:COM_DT_VENDA) ';
      SQL.Add(lc_Sqltxt);
      ParamByName('COM_CODVDO').AsInteger := StrToIntDef(StrGrd_Entrega.Cells[7,indice],0);
      ParamByName('COM_VL_COM').AsCurrency := Lc_ValorDiaria;
      ParamByName('COM_TIPO').AsString := 'S';
      ParamByName('COM_DT_VENDA').AsDateTime := StrToDateDef(StrGrd_Entrega.Cells[15,indice],Gb_DataCaixa);
      Active := True;
      FetchAll;
      if RecordCount = 0 then
      Begin
        TRy
          LcComissao := TControllerComissao.create(nil);
          with LcComissao.registro do
          BEgin
            Codigo          := 0;
            DataVenda       := Gb_DataCaixa;
            Pedido          := StrToIntDef(StrGrd_Entrega.Cells[3,Indice],0);
            Cliente         := StrToIntDef(StrGrd_Entrega.Cells[5,Indice],0);
            Vendedor        := StrToIntDef(StrGrd_Entrega.Cells[7,Indice],0);
            valorDocumento  := StrtoFloatDef(StrGrd_Entrega.Cells[9,Indice],0);
            valorComissao   := Lc_ValorDiaria;
            if (valorDocumento <> 0) then
              Aliquota := (valorComissao / valorDocumento) * 100
            else
              Aliquota := (valorDocumento / 1) * 100;

            Estabelecimento := Gb_CodMha;
            DataPagto       := 0;
            Financeiro      := 0;
            Tipo            := 'S';
          End;
          LcComissao.Insert;
        Finally
          FreeAndNil( LcComissao );
        End;

      end;
    end;
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
  end;
end;

procedure TFr_PizzariaEntrega.Pc_GeraComissao(Indice:Integer);
Var
  LcComissao : TControllerComissao;
begin
  TRy
    LcComissao := TControllerComissao.create(nil);
    with LcComissao.registro do
    BEgin
      Codigo          := 0;
      DataVenda       := Gb_DataCaixa;
      Pedido          := StrToIntDef(StrGrd_Entrega.Cells[3,Indice],0);
      Cliente         := StrToIntDef(StrGrd_Entrega.Cells[5,Indice],0);
      Vendedor        := StrToIntDef(StrGrd_Entrega.Cells[7,Indice],0);
      valorDocumento  := StrtoFloatDef(StrGrd_Entrega.Cells[9,Indice],0);
      valorComissao   := StrtoFloatDef(StrGrd_Entrega.Cells[16,Indice],0);
      if (valorDocumento <> 0) then
        Aliquota := (valorComissao / valorDocumento) * 100
      else
        Aliquota := (valorDocumento / 1) * 100;

      Estabelecimento := Gb_CodMha;
      DataPagto       := 0;
      Financeiro      := 0;
      Tipo            := 'P';
    End;
    LcComissao.Insert;
  Finally
    FreeAndNil( LcComissao );
  End;
end;

procedure TFr_PizzariaEntrega.Pc_Baixa_Retorno(Indice:Integer);
Var
  lc_Sqltxt : String;
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(self);
  with Lc_Qry, StrGrd_Entrega do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := IBT_Entrega;
    if Transaction.InTransaction then Transaction.Commit else Transaction.StartTransaction;
    ForcedRefresh := True;
    Active := False;
    SQL.Clear;
    lc_Sqltxt := 'UPDATE TB_PIZ_ENTREGA  SET '+
                 '  PEG_TM_FINAL =:PEG_TM_FINAL '+
                 'WHERE (PEG_CODPED =:PED_CODIGO) ';
    SQL.Add(lc_Sqltxt);
    Active := False;
    ParamByName('PEG_TM_FINAL').AsString := Copy(TimetoStr(Now),1,5);
    ParamByName('PED_CODIGO').AsString := StrGrd_Entrega.Cells[3,indice];
    ExecSQL;
    Transaction.Commit;
  end;
end;

Procedure TFr_PizzariaEntrega.Pc_totalizador;
Var
  Lc_I : Integer;
  Lc_Vl_Selecionado,Lc_VL_Troco,Lc_VL_Receber : Real;
Begin
  Lc_Vl_Selecionado := 0;
  Lc_VL_Troco := 0;
  Lc_VL_Receber := 0;
  with StrGrd_Entrega do
  Begin
    For Lc_I := 1 to RowCount -1 do
    Begin
      if (Cells[2,Lc_I] = 'X') then
      Begin
        Lc_Vl_Selecionado := Lc_Vl_Selecionado + StrToFloatDef(Cells[9,Lc_I],0);
        Lc_VL_Receber     := Lc_VL_Receber + StrToFloatDef(Cells[10,Lc_I],0);
        Lc_VL_Troco       := Lc_VL_Troco + StrToFloatDef(Cells[11,Lc_I],0);
      end;
    end;
  end;
  E_Vl_Selecionado.Text := FloatToStrF(Lc_VL_Selecionado,ffFixed,10,2);
  E_VL_Troco.Text       := FloatToStrF(Lc_VL_Troco,ffFixed,10,2);
  E_VL_Receber.Text     := FloatToStrF(Lc_VL_Receber,ffFixed,10,2);
end;

procedure TFr_PizzariaEntrega.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F2  : if Sb_liberar.Enabled then Sb_liberarClick(Sender);
      VK_F3  : if Sb_Retorno.Enabled then Sb_RetornoClick(Sender);
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_PizzariaEntrega.Pc_Buscar;
Var
  Lc_SqlTxt : string;
  Lc_Fone, Lc_Cliente,Lc_Motoboy: boolean;
begin
  with Qr_Pesquisa do
  Begin
    Active := False;
    Sql.Clear;
    Lc_Sqltxt := 'SELECT DISTINCT PED_CODIGO, PEd_DATA, PED_NUMERO, EMP_CODIGO, '+
                 ' EMP_NOME, PEG_CODMOT, CLB_NOME, PED_VL_PEDIDO,  '+
                 ' PEG_TM_PEDIDO, PEG_TM_SAIDA, PEG_TM_FINAL, PED_VL_FRETE, '+
                 ' VALUE_CHANGE, VALUE_RECIVED, END_FONE '+
                 'FROM TB_PIZ_ENTREGA '+
                 '  INNER JOIN TB_PEDIDO '+
                 '  ON (PED_CODIGO = PEG_CODPED) '+
                 '  INNER JOIN TB_EMPRESA '+
                 '  ON (EMP_CODIGO = PED_CODEMP) '+
                 '  INNER JOIN TB_ENDERECO '+
                 '  ON (END_CODIGO = PED_CODEND) '+
                 '  LEFT OUTER JOIN TB_COLABORADOR tb_colaborador '+
                 '  ON (CLB_CODIGO = PEG_CODMOT) '+
                 '  INNER JOIN TB_RESTAURANTE '+
                 '  ON (TB_PEDIDO_ID = PED_CODIGO)'+
                 'WHERE (PED_FATURADO <> ''A'') '+
                 ' AND (PED_TIPO = 1) '+
                 ' AND (PED_TP_CONTATO = 0) '+
                 ' AND (PED_DATA =:PED_DATA) '+
                 ' AND (END_PRINCIPAL = ''S'') ' ;

    if Chbx_Faturado.Checked then
      Lc_Sqltxt := Lc_Sqltxt + ' AND (PED_FATURADO =''S'') ';

    if (E_BuscaFone.Text = '')    then Lc_Fone    := False else Lc_Fone     := True;
    if (E_BuscaCliente.Text = '') then Lc_Cliente := False else Lc_Cliente  := True;
    if (DBLCB_Busca_Motoboy.Text = '')  then Lc_Motoboy := False else Lc_Motoboy  := True;

    if Lc_Fone    then Lc_SqlTxt := Lc_SqlTxt + 'AND (END_FONE LIKE :END_FONE) ';
    if Lc_Cliente then Lc_SqlTxt := Lc_SqlTxt + 'AND (EMP_NOME like :EMP_NOME) ';
    if Lc_Motoboy then Lc_SqlTxt := Lc_SqlTxt + 'AND (PEG_CODMOT =:CLB_CODIGO) ';
    IF Rg_Situacao.ItemIndex = 0 then Lc_SqlTxt := Lc_SqlTxt + 'AND (PEG_TM_SAIDA IS NULL) ';
    IF Rg_Situacao.ItemIndex = 1 then Lc_SqlTxt := Lc_SqlTxt + 'AND ((PEG_TM_SAIDA IS NOT NULL) AND (PEG_TM_FINAL IS NULL)) ';

    SQL.Add(Lc_SqlTxt + 'ORDER BY PED_NUMERO ');

    //Passsagem de Parametros
    ParamByName('PED_DATA').AsDateTime:= Gb_Datacaixa;

    if Lc_Fone    then ParamByName('END_FONE').AsString   := '%'+E_BuscaFone.Text+'%';
    if Lc_Cliente then ParamByName('EMP_NOME').AsString   := '%'+E_BuscaCliente.Text+'%';
    if Lc_Motoboy then ParamByName('CLB_CODIGO').AsInteger   := DBLCB_Busca_Motoboy.KeyValue;
    IF IBT_Entrega.InTransaction THEN IBT_Entrega.Commit;
    Active := True;
  end;
end;

procedure TFr_PizzariaEntrega.Pc_Preencher;
Var
  Lc_I,Lc_J : Integer;
  Lc_registro : Integer;
Begin
  with Qr_Pesquisa,StrGrd_Entrega do
  Begin
    First;
    Lc_registro := 0;
    while not Eof do
    Begin
      Lc_registro := Lc_registro + 1;
      RowCount := Lc_registro + 1;
      For Lc_I:= 0 to FieldCount -1 do
        if (Fields.Fields[Lc_I].DataType = ftFloat) OR (Fields.Fields[Lc_I].DataType = ftBCD) then
          Cells[Lc_I + 3,Lc_registro] := FloatToStrF(Fields[Lc_I].AsFloat,ffFixed,10,2)
        else
          Cells[Lc_I + 3,Lc_registro] := Fields[Lc_I].AsString;
      Next;
    end;
    Repaint;
  end;
end;

procedure TFr_PizzariaEntrega.StrGrd_EntregaDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  with Qr_Pesquisa, StrGrd_Entrega do
  Begin
    if (ACol = 1)and(ARow>0) Then
    begin
      if (Cells[3,ARow] <> '') then
      Begin
        if (Cells[2,ARow] = 'X') then
          DrawFrameControl(Canvas.Handle, Rect,DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED) // Desenha o CheckBox desmarcado
        else
          DrawFrameControl(Canvas.Handle, Rect,   DFC_BUTTON, DFCS_BUTTONCHECK); // Desenha o CheckBox marcado
      end;
    end
    else
    Begin
      If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
      Begin
        if (Cells[2,ARow] = '') then
        Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clCream;
        end
        else
        Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clMoneyGreen;
        end;
        Canvas.FillRect(Rect); // redesenha a celula
        Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.
        // Pega o texto da célula
        Texto := Cells[acol, ARow];
        //{ Calcura largura e altura (em pontos) do texto
        LarguraTexto := Canvas.TextWidth(Texto);
        AlturaTexto := Canvas.TextHeight(Texto);
        // Calcula a posição horizontal do início do texto
        if (Acol > 2) then
        Begin
          if (Fields[ACol-3].Alignment = taLeftJustify) then   // esquerda
            X := Rect.Left + 2
          else
          if (Fields[ACol-3].Alignment = taCenter) then // Centro
            X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
          else // Direita
            X := Rect.Right - LarguraTexto - 2;
        end;
        // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
        Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
        Canvas.TextRect(Rect, X, Y, Texto);
      end;
    end;
  end;
end;

function TFr_PizzariaEntrega.Fc_VerificaMarcado(Fc_grid:TStringGrid):Boolean;
Var
  Lc_I : Integer;
Begin
  with Fc_grid do
  Begin
    Result := False;
    For Lc_I := 1 to RowCount - 1 do
    Begin
      if Cells[2,Lc_I] = 'X' then
      Begin
        Result := true;
        break;
      end;
    end;
 end;
  if not Result then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Nenhum registro foi selecionado.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
end;

function TFr_PizzariaEntrega.Fc_VerificaQtdeMarcado(Fc_grid:TStringGrid):Boolean;
Var
  Lc_I : Integer;
  Lc_Contador : Integer;
Begin
  with Fc_grid do
  Begin
    Result := False;
    Lc_Contador := 0;
    For Lc_I := 1 to RowCount - 1 do
    Begin
      if Cells[2,Lc_I] = 'X' then
      Begin
      Lc_Contador := Lc_Contador  + 1;
      end;
    end;
    if (Lc_Contador > 4 ) then
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Foram marcados mais de 4 registros.'+EOLN+
                     'Por favor tenha certeza de que é possivel esta operação.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    end;
  end;
end;

Function  TFr_PizzariaEntrega.Fc_ValidaEntrega():Boolean;
Begin
  Result := true;
  If (Trim(DBLCB_Motoboy.Text) = '') then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Nome do motoboy não informado.'+EOLN+
                   ' Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    DBLCB_Motoboy.SetFocus;
    Result := False;
    exit;
  end;

  if not Fc_VerificaMarcado(StrGrd_Entrega) then
  Begin
    Result := False;
    exit;
  end;

  Fc_VerificaQtdeMarcado(StrGrd_Entrega);  
end;

Function  TFr_PizzariaEntrega.Fc_ValidaRetorno():Boolean;
Begin
  Result := true;
  if Rg_Situacao.ItemIndex <> 1 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Para esta opção deve estar marcada a situação retorno.'+EOLN+
                   ' Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Rg_Situacao.SetFocus;
    Result := False;
    exit;
  End;
  If (Trim(DBLCB_Busca_Motoboy.Text) = '') then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Informe na opção de busca o nome do motoboy.'+EOLN+
                   ' Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    DBLCB_Busca_Motoboy.SetFocus;
    Result := False;
    exit;
  end;

  if not Fc_VerificaMarcado(StrGrd_Entrega) then
  Begin
    Result := False;
    exit;
  end;

end;

Function  TFr_PizzariaEntrega.Fc_ValidaTrocaMotoboy():Boolean;
Begin
  Result := true;
  if Rg_Situacao.ItemIndex <> 1 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Para esta opção deve estar marcada a situação retorno.'+EOLN+
                   ' Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Rg_Situacao.SetFocus;
    Result := False;
    exit;
  End;
  if not Fc_VerificaMarcado(StrGrd_Entrega) then
  Begin
    Result := False;
    exit;
  end;

end;

procedure TFr_PizzariaEntrega.Pc_AlteraMotoboy;
Var
  Lc_I : Integer;
  lc_Sqltxt : String;
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(self);
  with Lc_Qry, StrGrd_Entrega do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := IBT_Entrega;
    ForcedRefresh := True;
    Active := False;
    SQL.Clear;
    lc_Sqltxt := 'UPDATE TB_PIZ_ENTREGA  SET '+
                 '  PEG_CODMOT =:PEG_CODMOT '+
                 'WHERE (PEG_CODPED =:PED_CODIGO) ';
    SQL.Add(lc_Sqltxt);
    For Lc_I:= 1 to RowCount - 1 do
    Begin
      if (Cells[2,lc_I] = 'X')  then
      Begin
        IF not IBT_Entrega.InTransaction THEN IBT_Entrega.StartTransaction;
        Active := False;
        ParamByName('PEG_CODMOT').AsInteger := dblcb_MudaMotoboy.KeyVAlue;
        ParamByName('PED_CODIGO').AsString := StrGrd_Entrega.Cells[3,Lc_I];
        ExecSQL;
        IF IBT_Entrega.InTransaction THEN IBT_Entrega.Commit;
      end;
    end;
  end;
  FReeAndNil(Lc_Qry);
  Pnl_Entrega.Visible := False;
end;

procedure TFr_PizzariaEntrega.Pc_LiberarEntrega;
Var
  Lc_I : Integer;
  lc_Sqltxt : String;
  Lc_Qry : TSTQuery;
  Lc_whats : TWhatsApp;
Begin
  Try
    Lc_Qry := TSTQuery.Create(nil);
    with Lc_Qry, StrGrd_Entrega do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := IBT_Entrega;
      ForcedRefresh := True;
      Active := False;
      SQL.Clear;
      lc_Sqltxt := 'UPDATE TB_PIZ_ENTREGA  SET '+
                   '  PEG_TM_SAIDA =:PEG_TM_SAIDA '+
                   ' ,PEG_CODMOT =:PEG_CODMOT '+
                   'WHERE (PEG_CODPED =:PED_CODIGO) ';
      SQL.Add(lc_Sqltxt);
      IF not IBT_Entrega.InTransaction THEN IBT_Entrega.StartTransaction;
      For Lc_I:= 1 to RowCount - 1 do
      Begin
        if (Cells[2,lc_I] = 'X')  then
        Begin
          Active := False;
          ParamByName('PEG_TM_SAIDA').AsString := Copy(TimetoStr(Now),1,5);
          ParamByName('PEG_CODMOT').AsInteger := DBLCB_Motoboy.KeyVAlue;
          ParamByName('PED_CODIGO').AsString := StrGrd_Entrega.Cells[3,Lc_I];
          ExecSQL;
          //Envia Mensagem WhatsApp
          //EnviaWhatsApp(StrGrd_Entrega.Cells[18,Lc_I]);
         end;
      end;
      IF IBT_Entrega.InTransaction THEN IBT_Entrega.Commit;
    end;
  Finally
    Lc_Qry.Close;
    Lc_Qry.disposeOf;
  End;
end;

procedure TFr_PizzariaEntrega.Sb_liberarClick(Sender: TObject);
begin
  If Fc_ValidaEntrega then
  Begin
    Pc_LiberarEntrega;
    MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                   'Liberação efetuada com sucesso.'+EOLN+
                   '  Clique em OK para continuar.'+EOLN,
                  ['OK'],[bEscape],mpInformacao);
    Pc_Buscar;
    Pc_LimpaStringGrid(StrGrd_Entrega);
    Pc_Preencher;
  end;
end;

procedure TFr_PizzariaEntrega.Sb_RetornoClick(Sender: TObject);
Var
  I:Integer;
begin
  If Fc_ValidaRetorno then
  Begin
    IF not IBT_Entrega.InTransaction THEN IBT_Entrega.StartTransaction;
    for I := 1 to (StrGrd_Entrega.RowCount - 1) do
    Begin
      if (  StrGrd_Entrega.Cells[2,I] = 'X' ) then
      Begin
        Pc_Baixa_Retorno(I);
        Pc_GeraDiaria(I);
        Pc_GeraComissao(I);
      End;
    End;
    Pc_Buscar;
    Pc_LimpaStringGrid(StrGrd_Entrega);
    Pc_Preencher;
    IF IBT_Entrega.InTransaction THEN IBT_Entrega.Commit;
    MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                   'Retorno registrado com sucesso.'+EOLN+
                   '  Clique em OK para continuar.'+EOLN,
                  ['OK'],[bEscape],mpInformacao);
  end;
end;

procedure TFr_PizzariaEntrega.Rg_SituacaoClick(Sender: TObject);
begin
  IF Rg_Situacao.ItemIndex = 0 THEN
  Begin
    Sb_liberar.Enabled := True;
    Sb_Retorno.Enabled := False;
    DBLCB_Motoboy.Enabled := True;
  end
  else
  Begin
    Sb_liberar.Enabled := False;
    Sb_Retorno.Enabled := True;
    DBLCB_Motoboy.KeyValue := Null;
    DBLCB_Motoboy.Enabled := False;
  end;
  Pc_Buscar;
  Pc_LimpaStringGrid(StrGrd_Entrega);
  Pc_Preencher;  
end;

procedure TFr_PizzariaEntrega.Sb_BuscarClick(Sender: TObject);
begin
  Pc_Buscar;
  Pc_LimpaStringGrid(StrGrd_Entrega);
  Pc_Preencher;
end;

procedure TFr_PizzariaEntrega.Sb_cancelaClick(Sender: TObject);
begin
  Pnl_Entrega.Visible := False;
end;

procedure TFr_PizzariaEntrega.Sb_confirmaClick(Sender: TObject);
begin
  If (Trim(dblcb_MudaMotoboy.Text) = '') then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Nome do motoboy não informado.'+EOLN+
                   ' Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    dblcb_MudaMotoboy.SetFocus;
    exit;
  end;
  Pc_AlteraMotoboy;
  Sb_BuscarClick(Self);
end;

procedure TFr_PizzariaEntrega.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_PizzariaEntrega.AlterarMotoboy1Click(Sender: TObject);
Var
  Lc_Top : Integer;
  Lc_Left : Integer;
begin
  if Fc_ValidaTrocaMotoboy then
  Begin
    //Posiciona o Panel de Valor Avulso
    Lc_top := trunc((Self.Height - Pnl_Entrega.Height)/2);
    lc_left := trunc((Self.Width - Pnl_Entrega.Width)/2);
    Pnl_Entrega.Top := Lc_top;
    Pnl_Entrega.Left :=lc_left;
    Pnl_Entrega.Visible := True;
  End;
end;

procedure TFr_PizzariaEntrega.DBLCB_Busca_MotoboyKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Busca_Motoboy.KeyValue := Null;
    end;
  end;
end;

procedure TFr_PizzariaEntrega.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_AtivarTabelas;
  Pc_IniciaVariaveis;
  Pc_ImagemBotao;
end;

procedure TFr_PizzariaEntrega.StrGrd_EntregaClick(Sender: TObject);
begin
  with StrGrd_Entrega do
  Begin
    IF Cells[2,Row]= 'X' then
      Cells[2,Row] := ''
    else
      Cells[2,Row] := 'X';
    Repaint;
  end;
  Pc_totalizador;
end;

procedure TFr_PizzariaEntrega.Qr_PesquisaCalcFields(DataSet: TDataSet);
Var
  Lc_Inicio,Lc_Final,Lc_Duracao: TTime;
begin
  if Trim(Qr_PesquisaPEG_TM_SAIDA.AsString) <> '' then
  Begin
    Lc_Inicio := StrToTime(Qr_PesquisaPEG_TM_SAIDA.AsString);
    Lc_Duracao := Now - Lc_Inicio;
  end
  else
  Begin
    Lc_Inicio := StrToTime(Qr_PesquisaPEG_TM_PEDIDO.AsString);
    Lc_Duracao := Now - Lc_Inicio;
  end;
  Qr_PesquisaPEG_DURACAO.AsString := Copy(TimeToStr(Lc_Duracao) ,1,5);
end;

procedure TFr_PizzariaEntrega.DBLCB_MotoboyKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Motoboy.KeyValue := Null;
    end;
  end;
end;

procedure TFr_PizzariaEntrega.EnviaWhatsApp(Fone: String);
begin

end;

end.
