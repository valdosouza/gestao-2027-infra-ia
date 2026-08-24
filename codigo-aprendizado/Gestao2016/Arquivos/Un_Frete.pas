unit Un_Frete;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, DB, StdCtrls, Mask, DBCtrls, ComCtrls, Buttons, Grids, DBGrids, STQuery, QEdit_Setes, Menus, STDataSet, ControllerFrete;

type
  TFr_Frete = class(TForm)
    Pnl_Fundos: TPanel;
    Label1: TLabel;
    E_Codigo: TEdit;
    Label3: TLabel;
    E_Descricao: TEdit;
    pnl_botoes: TPanel;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Ds_Empresas: TDataSource;
    Qr_Adicao: TSTQuery;
    Ds_Adicao: TDataSource;
    Label2: TLabel;
    E_Vl_Despacho: TEdit;
    Label6: TLabel;
    E_Vl_Tas: TEdit;
    Label8: TLabel;
    E_Vl_Gris_min: TEdit;
    Label9: TLabel;
    E_Aq_Gris: TEdit;
    Label10: TLabel;
    E_Vl_Pedagio: TEdit;
    Sb_Ins_Coluna: TSpeedButton;
    StrGrd_Frete: TStringGrid;
    Sb_Ins_Destino: TSpeedButton;
    Pnl_Escala: TPanel;
    Lb_Caption_Escala: TLabel;
    Label15: TLabel;
    Sb_Grv_Coluna: TSpeedButton;
    Sb_Can_Coluna: TSpeedButton;
    E_VL_Escala: TEdit_Setes;
    Pnl_Destinos: TPanel;
    Lb_Caption_Destino: TLabel;
    Lb_Local: TLabel;
    Label23: TLabel;
    Label7: TLabel;
    Sb_Grv_Destino: TSpeedButton;
    Sb_Can_Destino: TSpeedButton;
    RG_TipoLocal: TRadioGroup;
    DBLCB_Cidade: TDBLookupComboBox;
    DBLCB_UF: TDBLookupComboBox;
    E_VL_ADV: TEdit_Setes;
    E_Localidade: TEdit;
    PpM_Grid: TPopupMenu;
    ExcluirColuna: TMenuItem;
    ExcluirLinha: TMenuItem;
    Qr_AtualizaDestino: TSTQuery;
    Qr_AtualizaPeso: TSTQuery;
    Qr_AtualizaDestinoPeso: TSTQuery;
    Qr_FreteDestino: TSTQuery;
    Qr_FretePeso: TSTQuery;
    Qr_DestinoPeso: TSTQuery;
    Qr_Acao: TSTQuery;
    SB_Envia_web: TSpeedButton;
    procedure SB_AlterarClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_Ins_ColunaClick(Sender: TObject);
    procedure Sb_Grv_ColunaClick(Sender: TObject);
    procedure Sb_Can_ColunaClick(Sender: TObject);
    procedure Sb_Grv_DestinoClick(Sender: TObject);
    procedure Sb_Can_DestinoClick(Sender: TObject);
    procedure Sb_Ins_DestinoClick(Sender: TObject);
    procedure RG_TipoLocalClick(Sender: TObject);
    procedure ExcluirColunaClick(Sender: TObject);
    procedure E_VL_ADVExit(Sender: TObject);
    procedure E_VL_EscalaExit(Sender: TObject);
    procedure StrGrd_FreteDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StrGrd_FreteSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ExcluirLinhaClick(Sender: TObject);
    procedure SB_Envia_webClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    FFrete : TControllerFrete;
    EditionState : String;
    procedure EditionControl;
  public
    { Public declarations }
    CodigoRegistro : Integer;
    It_Cd_Destino : Integer;
    It_Cd_Peso :  Integer;
    It_Cd_Transportadora : Integer;
    It_Nr_Coluna : Integer;
    Procedure Pc_AtivarTabelas;
    Procedure Pc_FormataTela;
    Procedure Pc_IniciaVariavel;
    Procedure Pc_ImagemBotao;
    Function ValidaGravacao():Boolean;
    procedure Grava;
    procedure GravaTabelaFrete;
    procedure PreencheTabelaFrete;
    function Fc_VerificaGravacaoComplementar():Boolean;
    procedure Pc_MontaGridFrete;
    procedure Pc_LimpaGridFrete;
    function Fc_ValidaGravaDestino:boolean;
    procedure Pc_InsereColuna;
    procedure Pc_InsereLinha;

    procedure Pc_GravarDestinos(Pc_Linha:Integer);
    procedure Pc_GravarPesos(Pc_Coluna:Integer);
    procedure Pc_GravarValoresDestinosPesos(Pc_Coluna,Pc_Linha:Integer);
    procedure Pc_PreencheValoresDestinosPesos(Pc_Coluna,Pc_Linha:Integer);
    procedure Pc_ExcluirColuna(Pc_Cd_Peso:Integer);
    procedure Pc_ExcluirLinha(Pc_Cd_Destino:Integer);
  end;

var
  Fr_Frete: TFr_Frete;

implementation

uses     Un_DM, UN_Sistema, Un_Regra_Negocio, UN_MSG, un_Padrao, UN_Principal, env, Un_Adic_Imp, StdConvs;
{$R *.dfm}

procedure TFr_Frete.Pc_ExcluirColuna(Pc_Cd_Peso:Integer);
Begin
  If Pc_Cd_Peso >0 then
    Begin
    //Exclui a tabela de valores de Destino e Peso
    Qr_Acao.Active := False;
    Qr_Acao.Transaction := DM.IB_Transacao;
    Qr_Acao.SQL.Clear;
    Qr_Acao.SQL.Add('DELETE FROM TB_FRETE_DESTINO_PESO WHERE FDP_CODFPS =:FPS_CODIGO ');
    Qr_Acao.ParamByName('FPS_CODIGO').AsInteger := Pc_Cd_Peso;
    Qr_Acao.ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;

    //Exclui a tabela de valores de Destino e peso
    Qr_Acao.Active := False;
    Qr_Acao.Transaction := DM.IB_Transacao;
    Qr_Acao.SQL.Clear;
    Qr_Acao.SQL.Add('DELETE FROM TB_FRETE_PESO WHERE FPS_CODIGO =:FPS_CODIGO ');
    Qr_Acao.ParamByName('FPS_CODIGO').AsInteger := Pc_Cd_Peso;
    Qr_Acao.ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;

    IF (StrGrd_Frete.ColCount = 6) then
      StrGrd_Frete.ColCount := 5
    end;

  Pc_Deleta_Coluna_Grid(StrGrd_Frete,StrGrd_Frete.Col);
end;

procedure TFr_Frete.Pc_ExcluirLinha(Pc_Cd_Destino:Integer);
Var
  Lc_J : Integer;
  Lc_Codigo : Integer;
Begin
  IF Pc_Cd_Destino > 0 then
    Begin
    //Exclui a tabela de valores de Destino e Peso
    Qr_Acao.Active := False;
    Qr_Acao.Transaction := DM.IB_Transacao;
    Qr_Acao.SQL.Clear;
    Qr_Acao.SQL.Add('DELETE FROM TB_FRETE_DESTINO_PESO WHERE FDP_CODFDT =:FDT_CODIGO ');
    Qr_Acao.ParamByName('FDT_CODIGO').AsInteger := Pc_Cd_Destino;
    Qr_Acao.ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;

    //Exclui a tabela de valores de Destino e peso
    Qr_Acao.Active := False;
    Qr_Acao.Transaction := DM.IB_Transacao;
    Qr_Acao.SQL.Clear;
    Qr_Acao.SQL.Add('DELETE FROM TB_FRETE_DESTINO WHERE FDT_CODIGO =:FDT_CODIGO ');
    Qr_Acao.ParamByName('FDT_CODIGO').AsInteger := Pc_Cd_Destino;
    Qr_Acao.ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;

    IF (StrGrd_Frete.rowCount = 3) then
      Begin
      For Lc_J := 5 to StrGrd_Frete.ColCount do
        Begin
        Lc_Codigo := StrToIntDef(StrGrd_Frete.Cells[Lc_J,1],0);
        Pc_ExcluirColuna(Lc_Codigo);
        end;
      Pc_LimpaGridFrete;
      end;
    end;
  Pc_Deleta_Linha_Grid(StrGrd_Frete,StrGrd_Frete.Row);
end;

procedure TFr_Frete.Pc_MontaGridFrete;
Begin
  //Inedito ocultar linhas
  StrGrd_Frete.FixedRows := 2;
  StrGrd_Frete.RowHeights[1] := -2;

  StrGrd_Frete.ColWidths[0] := -1;
  StrGrd_Frete.ColWidths[1] := -1;
  StrGrd_Frete.ColWidths[2] := 25;
  StrGrd_Frete.ColWidths[3] := 200;
  StrGrd_Frete.ColWidths[4] := 70;

  StrGrd_Frete.Cells[0,0] := 'CD DESTINO';
  StrGrd_Frete.Cells[1,0] := 'CD cidade';
  StrGrd_Frete.Cells[2,0] := 'UF';
  StrGrd_Frete.Cells[3,0] := 'DESTINO';
  StrGrd_Frete.Cells[4,0] := 'Valor ADV';
end;

procedure TFr_Frete.Pc_LimpaGridFrete;
Var
  Lc_I,Lc_J : Integer;
Begin
  For Lc_I:= 1 to StrGrd_Frete.RowCount -1 do
    For Lc_J:= 0 to StrGrd_Frete.ColCount -1 do
      StrGrd_Frete.Cells[Lc_J,Lc_I] := '';
  StrGrd_Frete.RowCount := 3;
  StrGrd_Frete.ColCount := 5;
end;

procedure TFr_Frete.Pc_GravarDestinos(Pc_Linha:Integer);
Begin
  if Trim(StrGrd_Frete.Cells[3,Pc_linha])<>'' then
    Begin
    Qr_AtualizaDestino.Active := false;
    It_Cd_Destino :=  StrToIntDef(StrGrd_Frete.Cells[0,Pc_Linha],0);
    if It_Cd_Destino = 0 then
      Begin
      It_Cd_Destino := Fc_Generator('GN_FRETE_DESTINO','TB_FRETE_DESTINO','FDT_CODIGO');
      StrGrd_Frete.Cells[0,Pc_Linha] := IntToStr(It_Cd_Destino);
      end;
    if It_Cd_Destino > 0 then
      Begin
      Qr_AtualizaDestino.ParamByName('FDT_CODIGO').AsInteger := It_Cd_Destino;
      Qr_AtualizaDestino.ParamByName('FDT_CODFRT').AsInteger := CodigoRegistro;
      Qr_AtualizaDestino.ParamByName('FDT_CODCDD').AsInteger := StrToIntDef(StrGrd_Frete.Cells[1,Pc_Linha],0);
      Qr_AtualizaDestino.ParamByName('FDT_ADV').AsCurrency := StrToFloatDef(StrGrd_Frete.Cells[4,Pc_Linha],0);
      Qr_AtualizaDestino.ParamByName('FDT_LOCAL').AsString := StrGrd_Frete.Cells[2,Pc_Linha] + StrGrd_Frete.Cells[3,Pc_Linha];
      Qr_AtualizaDestino.ExecSQL;
      IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
      end;
    end;
end;

procedure TFr_Frete.Pc_GravarPesos(Pc_Coluna:Integer);
Var
  Lc_Valor :String;
Begin
  Qr_AtualizaPeso.Active := False;
  It_Cd_Peso := StrToIntDef(StrGrd_Frete.Cells[Pc_Coluna,1],0);
  if It_Cd_Peso = 0 then
    Begin
    It_Cd_Peso := Fc_Generator('GN_FRETE_PESO','TB_FRETE_PESO','FPS_CODIGO');
    StrGrd_Frete.Cells[Pc_Coluna,1] := InttoStr(It_Cd_Peso);
    end;
  if It_Cd_Peso > 0 then
    Begin
    Qr_AtualizaPeso.ParamByName('FPS_CODIGO').AsInteger := It_Cd_Peso;
    Qr_AtualizaPeso.ParamByName('FPS_CODFRT').AsInteger := CodigoRegistro;
    Lc_Valor := Copy(StrGrd_Frete.Cells[Pc_Coluna,0],5,(Length(StrGrd_Frete.Cells[Pc_Coluna,0]) - 4));
    Qr_AtualizaPeso.ParamByName('FPS_VALOR').AsCurrency := StrToFloatDef(Lc_Valor,0);
    //Guarda a posição do campo
    Qr_AtualizaPeso.ParamByName('FPS_POSICAO').AsInteger := Pc_Coluna;
    //Guarda a tamanho do campo
    Qr_AtualizaPeso.ParamByName('FPS_LARGURA').AsInteger := StrGrd_Frete.ColWidths[Pc_Coluna];
    Qr_AtualizaPeso.ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    end;
end;

procedure TFr_Frete.Pc_GravarValoresDestinosPesos(Pc_Coluna,Pc_Linha:Integer);
Begin
  if (CodigoRegistro > 0) and (It_Cd_Destino > 0) and (It_Cd_Peso > 0) then
    Begin
    Qr_AtualizaDestinoPeso.Active := False;
    Qr_AtualizaDestinoPeso.ParamByName('FDP_CODFRT').AsInteger := CodigoRegistro;
    Qr_AtualizaDestinoPeso.ParamByName('FDP_CODFDT').AsInteger := It_Cd_Destino;
    It_Cd_Peso := StrToIntDef(StrGrd_Frete.Cells[Pc_Coluna,1],0);
    Qr_AtualizaDestinoPeso.ParamByName('FDP_CODFPS').AsInteger := It_Cd_Peso;
    Qr_AtualizaDestinoPeso.ParamByName('FDP_VALOR').AsCurrency := StrToFloatDef(StrGrd_Frete.Cells[Pc_Coluna,Pc_Linha],0);
    Qr_AtualizaDestinoPeso.ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    end;
end;

procedure TFr_Frete.Pc_PreencheValoresDestinosPesos(Pc_Coluna,Pc_Linha:Integer);
Begin
  Qr_DestinoPeso.Active := False;
  Qr_DestinoPeso.ParamByName('FRT_CODIGO').AsInteger := CodigoRegistro;
  Qr_DestinoPeso.ParamByName('FDT_CODIGO').AsInteger := It_Cd_Destino;
  Qr_DestinoPeso.ParamByName('FPS_CODIGO').AsInteger := StrToIntDef(StrGrd_Frete.Cells[Pc_Coluna,1],0);
  Qr_DestinoPeso.Active := True;
  StrGrd_Frete.Cells[Pc_Coluna,Pc_Linha] := FloatToStrF(Qr_DestinoPeso.FieldByName('FDP_VALOR').AsCurrency,ffFixed,10,2);
end;

procedure TFr_Frete.GravaTabelaFrete;
Var
  Lc_I,Lc_J : Integer;
Begin
  With FFrete do
  Begin
    Registro.Empresa       := It_Cd_Transportadora;
    Registro.Descricao     := E_Descricao.Text;
    Registro.ValorDespacho := StrToFloatDef(E_Vl_Despacho.Text,0);
    Registro.ValorTas      := StrToFloatDef( E_Vl_Tas.Text ,0);
    Registro.GrisMin       := StrToFloatDef(E_Vl_Gris_min.Text,0);
    Registro.TaxaGris      := StrToFloatDef( E_Aq_Gris.Text,0);
    Registro.ValorPedagio  := StrToFloatDef(E_Vl_Pedagio.Text,0);
  End;
  FFrete.save;
  //Gravar o Peso
  For Lc_J:= 5 to StrGrd_Frete.ColCount -1 do
    Pc_GravarPesos(Lc_J);

  For Lc_I:= 2 to StrGrd_Frete.RowCount -1 do
    Begin
    //Gravar o Destino
    Pc_GravarDestinos(Lc_I);
    For Lc_J:= 5 to StrGrd_Frete.ColCount -1 do
      Pc_GravarValoresDestinosPesos(Lc_J,Lc_I);
    end;
end;

procedure TFr_Frete.PreencheTabelaFrete;
Var
  Lc_I,Lc_J : Integer;
Begin
  Pc_LimpaGridFrete;
  //Consulta o Peso Relacionado 
  Qr_FretePeso.Active := False;
  Qr_FretePeso.ParamByName('FRT_CODIGO').AsInteger := CodigoRegistro;
  Qr_FretePeso.Active := True;
  Qr_FretePeso.FetchAll;
  Qr_FretePeso.First;
  Lc_J := 5;
  while not Qr_FretePeso.Eof do
    Begin
    Lc_J := Lc_J + 1;
    StrGrd_Frete.ColCount := Lc_J;
    StrGrd_Frete.ColWidths[Lc_J -1] := Qr_FretePeso.FieldByName('FPS_LARGURA').AsInteger;
    //Preeche os dados do Destino
    StrGrd_Frete.Cells[Lc_J-1,0] := 'Até ' +  FloatToStrF(Qr_FretePeso.FieldByName('FPS_VALOR').AsCurrency,ffFixed,10,2);
    StrGrd_Frete.Cells[Lc_J-1,1] := Qr_FretePeso.FieldByName('FPS_CODIGO').AsString;
    Qr_FretePeso.Next;
    end;

  //Consulta o Frete
  Qr_FreteDestino.Active := False;
  Qr_FreteDestino.ParamByName('FRT_CODIGO').AsInteger := CodigoRegistro;
  Qr_FreteDestino.Active := True;
  Qr_FreteDestino.FetchAll;
  Qr_FreteDestino.First;
  Lc_I := 2;
  while not Qr_FreteDestino.Eof do
    Begin
    StrGrd_Frete.RowCount := Lc_I + 1;
    It_Cd_Destino := Qr_FreteDestino.FieldByName('FDT_CODIGO').AsInteger;
    //Preeche os dados do Destino
    StrGrd_Frete.Cells[0,Lc_I] := Qr_FreteDestino.FieldByName('FDT_CODIGO').AsString;
    StrGrd_Frete.Cells[1,Lc_I] := Qr_FreteDestino.FieldByName('FDT_CODCDD').AsString;
    StrGrd_Frete.Cells[2,Lc_I] := copy(Qr_FreteDestino.FieldByName('FDT_LOCAL').AsString,1,2);
    StrGrd_Frete.Cells[3,Lc_I] := copy(Qr_FreteDestino.FieldByName('FDT_LOCAL').AsString,3,(Length(Qr_FreteDestino.FieldByName('FDT_LOCAL').AsString) - 2));
    StrGrd_Frete.Cells[4,Lc_I] := Qr_FreteDestino.FieldByName('FDT_ADV').AsString;
    For Lc_J := 5 to StrGrd_Frete.ColCount  do
      Pc_PreencheValoresDestinosPesos(Lc_J,Lc_I);
    Lc_I := Lc_I + 1;
    Qr_FreteDestino.Next;
    end;
end;

Procedure TFr_Frete.Pc_AtivarTabelas;
Begin

  DM.Qr_UF.Active := True;
  DM.Qr_Cidades.Active := true;  
end;

Procedure TFr_Frete.Pc_FormataTela;
Var
  Lc_top,lc_left : Integer;
Begin
  Pc_MontaGridFrete;
  //Posiciona o Panel Coluna
  Lb_Caption_Escala.ParentFont := False;
  Lb_Caption_Escala.ParentColor := False;
  Lb_Caption_Escala.Transparent := False;
  Lb_Caption_Escala.Color := clNavy;
  Lb_Caption_Escala.Font.Color := clWhite;
  Pnl_Escala.Visible := False;
  Lc_top := trunc((Fr_Frete.Height - Pnl_Escala.Height)/2);
  lc_left := trunc((Fr_Frete.Width - Pnl_Escala.Width)/2);
  Pnl_Escala.Top := Lc_top;
  Pnl_Escala.Left := lc_left;

  //Posiciona o Panel Destino
  Lb_Caption_Destino.ParentFont := False;
  Lb_Caption_Destino.ParentColor := False;
  Lb_Caption_Destino.Transparent := False;
  Lb_Caption_Destino.Color := clNavy;
  Lb_Caption_Destino.Font.Color := clWhite;
  Pnl_Escala.Visible := False;
  Pnl_Destinos.Visible := False;
  Lc_top := trunc((Fr_Frete.Height - Pnl_Destinos.Height)/2);
  lc_left := trunc((Fr_Frete.Width - Pnl_Destinos.Width)/2);
  Pnl_Destinos.Top := Lc_top;
  Pnl_Destinos.Left := lc_left;
  E_Localidade.Left := DBLCB_Cidade.Left;
  E_Localidade.Visible := False;
  
end;

Procedure TFr_Frete.Pc_IniciaVariavel;
Begin
  FFrete.Registro.Codigo := CodigoRegistro;
  FFrete.getbyId;
  if (FFrete.exist )  then
    EditionState := 'E'
  else
    EditionState := 'I';
  E_Descricao.SetFocus;
  EditionControl
end;

Function TFr_Frete.ValidaGravacao():Boolean;
Begin
  Result := true;
  if trim(E_Descricao.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O preenchimento do campo descrição é obrigatório.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_Descricao.SetFocus;
    Result := False;
    exit;
  end;
  //Tirar o foco da Grid
  E_Descricao.SetFocus;
end;


Procedure TFr_Frete.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    SB_Alterar.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    SB_Excluir.Glyph.Assign(Fc_CarregaImagemBotao('EXCLUIR'));
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    //Botões do colunas/Escalas
    Sb_Ins_Coluna.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    Sb_Grv_Coluna.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Can_Coluna.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    //Botões do Destino
    Sb_Ins_Destino.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    Sb_Grv_Destino.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Can_Destino.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    END;
end;


procedure TFr_Frete.SB_AlterarClick(Sender: TObject);
begin
  EditionState := 'E';
  EditionControl;
  E_Descricao.SetFocus;
end;


procedure TFr_Frete.SB_Envia_webClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Self.KeyPreview := False;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
    Self.KeyPreview := True;
  end;
end;

procedure TFr_Frete.SB_ExcluirClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir ' + FFrete.Registro.Descricao + ' de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
  begin
    FFrete.Delete;
    Close;
  end;
end;

procedure TFr_Frete.SB_GravarClick(Sender: TObject);
begin
  if ValidaGravacao then
  begin
    Grava;
  end;
end;

procedure TFr_Frete.SB_CancelarClick(Sender: TObject);
begin
  EditionState := 'B';
  EditionControl;
end;

procedure TFr_Frete.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Frete.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_AtivarTabelas;
  Pc_IniciaVariavel;
  Pc_ImagemBotao;
end;

procedure TFr_Frete.Grava;
begin
  GravaTabelaFrete;
  PreencheTabelaFrete;
end;

procedure TFr_Frete.FormCreate(Sender: TObject);
begin
  FFrete := TControllerFrete.Create(Self);
end;

procedure TFr_Frete.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = []) then
    begin
    if Pnl_Escala.Visible then
      Begin
      case Key of
        VK_F5  : if Sb_Grv_Coluna.Enabled then Sb_Grv_ColunaClick(Sender);
        VK_F6  : if Sb_Can_Coluna.Enabled then Sb_Can_ColunaClick(Sender);
        end;
      end
    else
    if Pnl_Destinos.Visible then
      Begin
      case Key of
        VK_F5  : if Sb_Grv_Destino.Enabled then Sb_Grv_DestinoClick(Sender);
        VK_F6  : if Sb_Can_Destino.Enabled then Sb_Can_DestinoClick(Sender);
        end;
      end
    else
      Begin
      case Key of
        VK_F3  : if SB_Alterar.Enabled then SB_AlterarClick(Sender);
        VK_F4  : if SB_Excluir.Enabled then SB_ExcluirClick(Sender);
        VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
        VK_F6  : if SB_Cancelar.Enabled then SB_CancelarClick(Sender);
        VK_F8  : if Sb_Ins_Coluna.Enabled then Sb_Ins_ColunaClick(Sender);
        VK_F9  : if Sb_Ins_Destino.Enabled then Sb_Ins_DestinoClick(Sender);
        VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
        end;
      end;
    end;
end;

procedure TFr_Frete.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

function TFr_Frete.Fc_VerificaGravacaoComplementar():Boolean;
Begin
  Result := True;
  if ( EditionState = 'I' )  then
  Begin
    if not ValidaGravacao then
    Begin
      Result := False;
      exit;
    end;
    Grava;
  end;
end;

procedure TFr_Frete.Sb_Ins_ColunaClick(Sender: TObject);
begin
  if not Fc_VerificaGravacaoComplementar then exit;
  //Desativa controles debaixo
  Pnl_Fundos.Enabled := False;
  StrGrd_Frete.Enabled := False;
  pnl_botoes.Enabled := False;
  //Ativa Panel escala
  Pnl_Escala.Visible := true;

end;

procedure TFr_Frete.Pc_InsereColuna;
Begin
  StrGrd_Frete.ColCount := StrGrd_Frete.ColCount + 1; 
  StrGrd_Frete.Cols[StrGrd_Frete.ColCount - 1].Assign(StrGrd_Frete.Cols[StrGrd_Frete.ColCount - 1]);
  StrGrd_Frete.ColWidths[StrGrd_Frete.ColCount - 1] := 70;
  E_VL_EscalaExit(Self);
  StrGrd_Frete.Cells[StrGrd_Frete.ColCount - 1,0] := 'Até ' + e_vl_Escala.text;
  E_VL_Escala.Text := '0,00';
end;

procedure TFr_Frete.Sb_Grv_ColunaClick(Sender: TObject);
begin
  if (StrToFloatDef(E_VL_Escala.Text,0) > 0) then
  begin
    Screen.Cursor := crDefault;
    Pc_InsereColuna;
    //Ativas controles debaixo
    Pnl_Fundos.Enabled := true;
    StrGrd_Frete.Enabled := true;
    pnl_botoes.Enabled := true;
    Pnl_Escala.Visible := False;
    Screen.Cursor := crDefault;
  end
  else
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O preenchimento do campo valor da escala é obrigatório.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_VL_Escala.SetFocus;
  end;
end;

procedure TFr_Frete.Sb_Can_ColunaClick(Sender: TObject);
begin
  Screen.Cursor := crDefault;
  //Ativas controles debaixo
  Pnl_Fundos.Enabled := true;
  StrGrd_Frete.Enabled := true;
  pnl_botoes.Enabled := true;
  Pnl_Escala.Visible := False;
  Screen.Cursor := crDefault;
end;

function TFr_Frete.Fc_ValidaGravaDestino:boolean;
Begin
  Result := True;
  if (StrToFloatDef(E_VL_ADV.Text,0) = 0) then
    Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O preenchimento do campo valor ADV é obrigatório.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    E_VL_ADV.SetFocus;
    exit;
    end;

  if Trim(DBLCB_UF.Text) = '' then
    Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O preenchimento do campo Estado é obrigatório.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    DBLCB_UF.SetFocus;
    exit;
    end;

  case RG_TipoLocal.ItemIndex of
    0:Begin
      if Trim(DBLCB_Cidade.Text) = '' then
        Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'O preenchimento do campo Cidade é obrigatório.'+EOLN+
                       'Verifique e tente novamente.'+EOLN,
                      ['OK'],[bEscape],mpAlerta);
        Result:=false;
        DBLCB_Cidade.SetFocus;
        exit;
        end;
      end;
    1:Begin
      if Trim(E_Localidade.Text) = '' then
        Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'O preenchimento do campo localidade é obrigatório.'+EOLN+
                       'Verifique e tente novamente.'+EOLN,
                      ['OK'],[bEscape],mpAlerta);
        Result:=false;
        E_Localidade.SetFocus;
        exit;
        end;
      end;
  end;

end;

procedure TFr_Frete.Pc_InsereLinha;
Begin
  if (StrGrd_Frete.RowCount = 3) then
    Begin
    if (Trim(StrGrd_Frete.Cells[1,2]) <> '') then
      StrGrd_Frete.RowCount := StrGrd_Frete.RowCount + 1;
    end
  else
    Begin
    StrGrd_Frete.RowCount := StrGrd_Frete.RowCount + 1;
    end;

  StrGrd_Frete.Rows[StrGrd_Frete.RowCount - 1].Assign(StrGrd_Frete.Rows[StrGrd_Frete.rowCount - 1]);
  StrGrd_Frete.Cells[0,StrGrd_Frete.RowCount - 1] := '0';
  if RG_TipoLocal.ItemIndex = 0 then
    Begin
    StrGrd_Frete.Cells[1,StrGrd_Frete.RowCount - 1] := IntToStr(DBLCB_Cidade.KeyValue);
    StrGrd_Frete.Cells[2,StrGrd_Frete.RowCount - 1] := DBLCB_UF.Text;
    StrGrd_Frete.Cells[3,StrGrd_Frete.RowCount - 1] := DBLCB_Cidade.Text
    end
  else
    Begin
    StrGrd_Frete.Cells[1,StrGrd_Frete.RowCount - 1] := '0';
    StrGrd_Frete.Cells[2,StrGrd_Frete.RowCount - 1] := DBLCB_UF.Text;
    StrGrd_Frete.Cells[3,StrGrd_Frete.RowCount - 1] := E_Localidade.Text;
    end;
  E_VL_ADVExit(Self);
  StrGrd_Frete.Cells[4,StrGrd_Frete.RowCount - 1] := E_VL_ADV.Text;
  //Apaga os dados
  RG_TipoLocal.ItemIndex := 0;
  E_VL_ADV.Text := '0,00';
  DBLCB_UF.KeyValue := null;
  DBLCB_Cidade.KeyValue := null;
  E_Localidade.Clear;
end;

procedure TFr_Frete.Sb_Grv_DestinoClick(Sender: TObject);
begin
  if Fc_ValidaGravaDestino then
  begin
    Screen.Cursor := crDefault;
    Pc_InsereLinha;
    //Ativas controles debaixo
    Pnl_Fundos.Enabled := true;
    StrGrd_Frete.Enabled := true;
    pnl_botoes.Enabled := true;
    Pnl_Destinos.Visible := False;
    Screen.Cursor := crDefault;
  end;
end;

procedure TFr_Frete.Sb_Can_DestinoClick(Sender: TObject);
begin
  Screen.Cursor := crDefault;
  //Ativas controles debaixo
  Pnl_Fundos.Enabled := true;
  StrGrd_Frete.Enabled := true;
  pnl_botoes.Enabled := true;
  Pnl_Destinos.Visible := False;
end;

procedure TFr_Frete.Sb_Ins_DestinoClick(Sender: TObject);
begin
  if not Fc_VerificaGravacaoComplementar then exit;
  //Desativa controles debaixo
  Pnl_Fundos.Enabled := False;
  StrGrd_Frete.Enabled := False;
  pnl_botoes.Enabled := False;
  //Ativa Panel Destino
  Pnl_Destinos.Visible := True;
end;

procedure TFr_Frete.RG_TipoLocalClick(Sender: TObject);
begin
  case RG_TipoLocal.ItemIndex of
    0:Begin
      DBLCB_Cidade.Visible := True;
      DBLCB_Cidade.TabStop := True;      
      E_Localidade.Visible := False;
      E_Localidade.TabStop := False;
      Lb_Local.Caption := 'Cidade';
      end;
    1:Begin
      DBLCB_Cidade.Visible := False;
      DBLCB_Cidade.TabStop := False;
      E_Localidade.Visible := True;
      E_Localidade.TabStop := True;
      Lb_Local.Caption := 'Localidade';
      end;
  end;
end;

procedure TFr_Frete.EditionControl;
begin
  SB_Alterar.Enabled := ( EditionState = 'B' ) and ( CodigoRegistro > 0 ) ;
  SB_Excluir.Enabled := ( EditionState = 'B' ) and ( CodigoRegistro > 0 );
  SB_gravar.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  SB_Cancelar.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Sb_Sair_0.Enabled := ( EditionState = 'B' ) and ( CodigoRegistro > 0 );
  if ( ( EditionState = 'I' ) or ( EditionState = 'E' ) ) then
    StrGrd_Frete.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goColSizing,goColMoving,goEditing,goTabs]
  else
    StrGrd_Frete.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRowSelect];

  ExcluirColuna.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  ExcluirLinha.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  SB_Envia_web.Enabled := ( EditionState = 'B' ) and
                          (Trim(StrGrd_Frete.Cells[3,StrGrd_Frete.row])<>'') AND (Trim(StrGrd_Frete.Cells[5,0])<>'');
  Sb_Ins_Coluna.Enabled := ( ( EditionState = 'I' ) or ( EditionState = 'E' ) ) and (Trim(StrGrd_Frete.Cells[3,StrGrd_Frete.row])<>'');
  Sb_Ins_Destino.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  pnl_fundos.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
end;

procedure TFr_Frete.ExcluirColunaClick(Sender: TObject);
Var
  Lc_Codigo : Integer;
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir a coluna ' + IntToStr(It_Nr_Coluna) + ' da tabela.' + EOLN + EOLN +
                     'Confirmar a exclusão ?'+EOLN +
                     'Esta operação é definitiva.',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
  begin
    if (It_Nr_Coluna > 4) then
    Begin
      Lc_Codigo := StrToIntDef(StrGrd_Frete.Cells[It_Nr_Coluna,1],0);
      Pc_ExcluirColuna(Lc_Codigo);
      Pc_MontaGridFrete;
      EditionState := 'B';
      EditionControl;
    end
    else
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Esta coluna é fixa no sistema não pode ser excluída.'+EOLN+
                     'Verifique e tente novamente.'+EOLN,
                     ['OK'],[bEscape],mpAlerta);
    end;
  end;
end;

procedure TFr_Frete.E_VL_ADVExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(E_VL_ADV.Text,0);
  E_VL_ADV.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
end;

procedure TFr_Frete.E_VL_EscalaExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(E_VL_Escala.Text,0);
  E_VL_Escala.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);

end;

procedure TFr_Frete.StrGrd_FreteDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
  Lc_valor : real;
begin
  If (arow = 0) then
    Begin
    // Pega o texto da célula
    Texto := StrGrd_Frete.Cells[acol, ARow];

    //{ Calcura largura e altura (em pontos) do texto
    LarguraTexto := StrGrd_Frete.Canvas.TextWidth(Texto);
    AlturaTexto := StrGrd_Frete.Canvas.TextHeight(Texto);

    // Calcula a posição horizontal do início do texto
    if  (ACol <= 3) then // esquerda
      X := Rect.Left + 2
    else
    if  (ACol > 3)  then // Centro
      X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
    else // Direita
      X := Rect.Right - LarguraTexto - 2;

    // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
    Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
    StrGrd_Frete.Canvas.TextRect(Rect, X, Y, Texto);
    end
  else
    Begin
    If (arow > 1) then
      Begin
      StrGrd_Frete.Canvas.Font.Color:= clBlack;
      StrGrd_Frete.Canvas.Brush.Color:= clCream;

      StrGrd_Frete.Canvas.FillRect(Rect); // redesenha a celula
      StrGrd_Frete.Canvas.TextOut(Rect.Left+2,Rect.Top,StrGrd_Frete.Cells[acol,arow]); // reimprime o texto.
      // Pega o texto da célula
      if (ACol > 3) then
        Begin
        Lc_valor := StrToFloatDef(StrGrd_Frete.Cells[acol, ARow],0);
        Texto := FloatToStrF(Lc_valor,ffFixed,10,2);
        end
      else
        Begin
        Texto := StrGrd_Frete.Cells[acol, ARow];
        end;

      //{ Calcura largura e altura (em pontos) do texto
      LarguraTexto := StrGrd_Frete.Canvas.TextWidth(Texto);
      AlturaTexto := StrGrd_Frete.Canvas.TextHeight(Texto);

      // Calcula a posição horizontal do início do texto
      if  (ACol <= 3) then // esquerda
        X := Rect.Left + 2
      else
      if  (ACol = 0)  then // Centro
        X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
      else // Direita
        X := Rect.Right - LarguraTexto - 2;

      // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
      Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
      StrGrd_Frete.Canvas.TextRect(Rect, X, Y, Texto);
      end;
    end;
end;

procedure TFr_Frete.StrGrd_FreteSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  It_Nr_Coluna := Acol;
  CanSelect := (ACol>3);
end;

procedure TFr_Frete.ExcluirLinhaClick(Sender: TObject);
Var
  Lc_Codigo : Integer;
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o destino ' + StrGrd_Frete.Cells[3,StrGrd_Frete.Row] + ' da tabela.' + EOLN + EOLN +
                     'Confirmar a exclusão ?'+EOLN +
                     'Esta operação é definitiva.',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
  begin
    if (It_Nr_Coluna > 1) then
    Begin
      Lc_Codigo := StrToIntDef(StrGrd_Frete.Cells[0,StrGrd_Frete.Row],0);
      Pc_ExcluirLinha(Lc_Codigo);
      EditionState := 'B';
      EditionControl;
    end
    else
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Esta coluna é fixa no sistema não pode ser excluída.'+EOLN+
                     'Verifique e tente novamente.'+EOLN,
                     ['OK'],[bEscape],mpAlerta);
    end;
  end;
end;

end.
