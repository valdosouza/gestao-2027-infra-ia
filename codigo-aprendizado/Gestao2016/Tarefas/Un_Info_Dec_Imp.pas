unit Un_Info_Dec_Imp;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.DBCtrls, STDataSet, ControllerDocumentoImportacao, Un_Fm_ListaEmpresas, Un_Fm_ListaFornecedores, STTransaction;

type
  TFr_Info_Dec_Imp = class(TForm)
    Pnl_Fundos: TPanel;
    Label1: TLabel;
    E_Codigo: TEdit;
    Label3: TLabel;
    Label5: TLabel;
    E_Local: TEdit;
    DBLCB_UF: TDBLookupComboBox;
    Label23: TLabel;
    Label2: TLabel;
    E_Data: TDateTimePicker;
    pnl_botoes: TPanel;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Label4: TLabel;
    E_Dt_Desemb: TDateTimePicker;
    DBG_Produtos: TDBGrid;
    Sb_Ins_Adicao: TSpeedButton;
    Sb_Alt_Adicao: TSpeedButton;
    Sb_Exc_Adicao: TSpeedButton;
    Qr_Adicao: TSTQuery;
    Ds_Adicao: TDataSource;
    E_Numero: TEdit;
    chbx_Todos: TCheckBox;
    SB_Sair: TSpeedButton;
    Fm_ListaFornecedores: TFm_ListaFornecedores;
    IBT_Atualiza: TSTTransaction;
    E_Div: TEdit;
    Label6: TLabel;
    procedure SB_AlterarClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_Exc_AdicaoClick(Sender: TObject);
    procedure Sb_Ins_AdicaoClick(Sender: TObject);
    procedure Sb_Alt_AdicaoClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SB_SairClick(Sender: TObject);
  private
    { Private declarations }
    Documento : TControllerDocumentoImportacao;
    EditionState : String;
    procedure EditionControler(T: TComponent);
    procedure EditionControl;Virtual;
    procedure ShowData;
    procedure ShowNoData;
    procedure OpenAdicao;
    Procedure AtivarTabelas;
    Procedure FormataTela;
    Procedure IniciaVariavel;
    Procedure ImagemBotao;
    Function Fc_ValidaGravacao():Boolean;
    procedure Gravar;
    function Fc_VerificaGravacaoComplementar():Boolean;
    procedure Pc_DeletaAdicao;
    function Fc_ValidaGeraDigito(Fc_numero:String):Boolean;
    function Fc_GeraDigito(Fc_numero:String):String;

  public
    { Public declarations }
    It_Cd_Item : Integer;
    It_Codigo : Integer;
  end;

var
  Fr_Info_Dec_Imp: TFr_Info_Dec_Imp;

implementation

uses     Un_DM, UN_Sistema, Un_Regra_Negocio, UN_MSG, un_Padrao, UN_Principal, env, Un_Adic_Imp, Un_Fornecedor, UN_TabelasEmListas, ControllerBase;
{$R *.dfm}

procedure TFr_Info_Dec_Imp.Gravar;
Begin
  with Documento do
  Begin
    Registro.Numero := E_Numero.Text;
    Registro.DigitoDocumento := E_Div.Text;
    Registro.Data := E_Data.Date;
    Registro.LocalDesembarque := E_Local.Text;
    Registro.DataDesembarque := E_Dt_Desemb.Date;
    Registro.CodigoEstado := DBLCB_UF.KeyValue;
    Registro.CodigoExportador := IntToStr(Fm_ListaFornecedores.DBLCB_Empresa.KeyValue);
  End;
  Documento.salva;
End;


procedure TFr_Info_Dec_Imp.OpenAdicao;
begin
  if IBT_Atualiza.InTransaction then IBT_Atualiza.Commit;
  if not IBT_Atualiza.InTransaction then IBT_Atualiza.StartTransaction;
  Qr_Adicao.Active := False;
  Qr_Adicao.ParamByName('ADC_CODDIM').AsInteger := Documento.Registro.Codigo;
  Qr_Adicao.Active := True;
end;

procedure TFr_Info_Dec_Imp.ShowData;
Begin
  with Documento do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Numero.Text     := Registro.Numero;
    E_Div.Text        := Registro.DigitoDocumento;
    E_Data.Date       := Registro.Data;
    E_Local.Text      := Registro.LocalDesembarque;
    E_Dt_Desemb.Date  := Registro.DataDesembarque;
    DBLCB_UF.KeyValue := Registro.CodigoEstado;
    Fm_ListaFornecedores.E_Cd_Empresa.Text := Registro.CodigoExportador;
    Fm_ListaFornecedores.DBLCB_Empresa.KeyValue  := StrToIntDef(Registro.CodigoExportador,0);
  End;
  OpenAdicao;
End;

procedure TFr_Info_Dec_Imp.ShowNoData;
begin
  E_Codigo.Clear;
  E_Numero.Clear;
  E_Div.Clear;
  E_Data.Date       := Date;
  E_Local.Clear;
  E_Dt_Desemb.Date  := Date;
  DBLCB_UF.KeyValue := 0;
  Fm_ListaFornecedores.DBLCB_Empresa.KeyValue  := Null;
end;

procedure TFr_Info_Dec_Imp.Pc_DeletaAdicao;
begin
  Documento.Adicao.Registro.Codigo := Qr_Adicao.FieldByName('ADC_CODIGO').AsInteger;
  Documento.Adicao.delete;
end;

Procedure TFr_Info_Dec_Imp.AtivarTabelas;
Begin
  DM.Qr_UF.Active := True;
  Fm_ListaFornecedores.ListaFornecedores('EMP_NOME');
end;

Procedure TFr_Info_Dec_Imp.FormataTela;
Begin

end;

Procedure TFr_Info_Dec_Imp.IniciaVariavel;
Begin
  Documento.Registro.CodigoItem := It_Cd_Item;
  Documento.getByITF;
  if not Documento.exist then
  Begin
    ShowNoData;
    EditionState := 'I';
    EditionControl;
  end
  else
  begin
    ShowData;
    EditionState := 'E';
    EditionControl;
  end;
  E_Numero.SetFocus;
end;

Function TFr_Info_Dec_Imp.Fc_ValidaGravacao():Boolean;
Begin
  Result := true;
  if trim(E_Numero.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O preenchimento do campo número é obrigatório.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_Numero.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_Local.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O preenchimento do campo Local do desembaraço é obrigatório.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_Local.SetFocus;
    Result := False;
    exit;
  end;

  if trim(DBLCB_UF.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O preenchimento do campo Estado onde ocorreu o desembaraço é obrigatório.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    DBLCB_UF.SetFocus;
    Result := False;
    exit;
  end;

  if trim(Fm_ListaFornecedores.DBLCB_Empresa.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O preenchimento do campo código do exportador é obrigatório.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Fm_ListaFornecedores.DBLCB_Empresa.SetFocus;
    Result := False;
    exit;
  end;
end;

Procedure TFr_Info_Dec_Imp.ImagemBotao;
Begin
  with fr_principal do
  Begin
    SB_Alterar.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    SB_Excluir.Glyph.Assign(Fc_CarregaImagemBotao('EXCLUIR'));
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    Sb_Sair.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    //Itens Adição
    Sb_Ins_Adicao.Glyph.Assign(Fc_CarregaImagemBotao('INSERIR'));
    Sb_Alt_Adicao.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    Sb_Exc_Adicao.Glyph.Assign(Fc_CarregaImagemBotao('EXCLUIR'));
  END;
end;


procedure TFr_Info_Dec_Imp.SB_AlterarClick(Sender: TObject);
begin
  EditionState := 'E';
  EditionControl;
  E_Numero.SetFocus;
end;

procedure TFr_Info_Dec_Imp.SB_ExcluirClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o ' + Documento.Registro.Numero + ' de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
  begin
    Documento.Adicao.deleteAll;
    Documento.Delete;
    Close;
  end;
end;

procedure TFr_Info_Dec_Imp.SB_GravarClick(Sender: TObject);
begin
  if Fc_ValidaGravacao then
  begin
    Gravar;
    It_Codigo :=   Documento.Registro.codigo;
    EditionState := 'B';
    EditionControl;
  end;
end;

procedure TFr_Info_Dec_Imp.SB_CancelarClick(Sender: TObject);
begin
  if ( EditionState = 'I' ) then
  Begin
    EditionState := 'B';
    Close;
  end
  else
  Begin
    EditionState := 'B';
    EditionControl;
  end;
end;

procedure TFr_Info_Dec_Imp.FormShow(Sender: TObject);
begin
  FormataTela;
  AtivarTabelas;
  IniciaVariavel;
  ImagemBotao;
end;

procedure TFr_Info_Dec_Imp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = []) then
  begin
    if ( EditionState = 'I' ) or ( EditionState = 'E' ) then
    Begin
      case Key of
        VK_F2  : if Sb_Ins_Adicao.Enabled then Sb_Ins_AdicaoClick(Sender);
        VK_F3  : if Sb_Alt_Adicao.Enabled then Sb_Alt_AdicaoClick(Sender);
        VK_F4  : if Sb_Exc_Adicao.Enabled then Sb_Exc_AdicaoClick(Sender);
        VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
        VK_F6  : if SB_Cancelar.Enabled then SB_CancelarClick(Sender);
      end;
    end
    else
    Begin
      case Key of
        VK_F3  : if SB_Alterar.Enabled then SB_AlterarClick(Sender);
        VK_F4  : if SB_Excluir.Enabled then SB_ExcluirClick(Sender);
        VK_Escape : if Sb_Sair.Enabled then Sb_SairClick(Sender);
      end;
    end;
  end;
end;

procedure TFr_Info_Dec_Imp.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Info_Dec_Imp.Sb_Exc_AdicaoClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir ' + Qr_Adicao.FieldByName('ADC_NUMERO').AsString + ' de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
  begin
    Pc_DeletaAdicao;
    OpenAdicao;
    EditionControl;
  end;
end;

function TFr_Info_Dec_Imp.Fc_VerificaGravacaoComplementar():Boolean;
Begin
  Result := True;
  if ( EditionState = 'I' )  then
  Begin
    if Fc_ValidaGravacao then
    Begin
      Gravar;
    End;
  end;
end;

procedure TFr_Info_Dec_Imp.Sb_Ins_AdicaoClick(Sender: TObject);
Var
  Lc_form : TFr_Adic_Imp;
begin
  if Fc_VerificaGravacaoComplementar then
  Begin
    Lc_form := TFr_Adic_Imp.Create(Self);
    Try
      Lc_form.It_Cd_Adicao := 0;
      Lc_form.It_Cd_DIM := Documento.Registro.Codigo;
      Lc_form.ShowModal;
    Finally
      OpenAdicao;
    End;
  End;
  EditionControl;
end;

procedure TFr_Info_Dec_Imp.SB_SairClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Info_Dec_Imp.Sb_Alt_AdicaoClick(Sender: TObject);
Var
  Lc_form : TFr_Adic_Imp;
begin
  if Fc_VerificaGravacaoComplementar then
  Begin
    Lc_form := TFr_Adic_Imp.Create(Self);
    Try
      Lc_form.It_Cd_Adicao := Qr_Adicao.FieldByName('ADC_CODIGO').AsInteger;
      Lc_form.It_Cd_DIM := Documento.Registro.Codigo;
      Lc_form.ShowModal;
    Finally
      OpenAdicao;
      EditionControl;

    End;
  End;
end;

procedure TFr_Info_Dec_Imp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil( Documento );
end;

procedure TFr_Info_Dec_Imp.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ( ( EditionState = 'I' ) or ( EditionState = 'E' ) ) then
  Begin
    canClose := False;
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O registro da D.I está sendo editado.'+EOLN+
                   'Grave ou cancele a edição antes de sair da tela.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
  end;
end;

procedure TFr_Info_Dec_Imp.FormCreate(Sender: TObject);
begin
  Documento := TControllerDocumentoImportacao.Create(Self);
end;

function TFr_Info_Dec_Imp.Fc_ValidaGeraDigito(Fc_numero:String):Boolean;
Var
  Lc_Valida:String;
  Lc_Ano_Atual:Integer;
Begin
  Result := True;
  if (Length(trim(Fc_numero)) <> 10) then
  Begin
    MensagemPadrao('Mensagems',ATENCAO+EOLN+EOLN+
                   'Deve ser informado exatamente 10 digitos, conforme instrução.'+EOLN+
                   'Não é possivel continuar.'+EOLN,
                   ['OK'],[bEscape],mpInformacao);
    Result := False;
    exit;
  end;


  Lc_Valida := Copy(Fc_numero,1,1);
  if (Lc_Valida <> '2') and (Lc_Valida <> '4') then
  Begin
    MensagemPadrao('Mensagems',ATENCAO+EOLN+EOLN+
                   'O primeiro digito é diferente de (2=DI, 4=DSI).'+EOLN+
                   'Não é possivel continuar.'+EOLN,
                   ['OK'],[bEscape],mpInformacao);
    Result := False;
    exit;
  end;

  Lc_Valida := Copy(Fc_numero,2,2);
  Lc_Ano_Atual := StrToIntDef(Copy(DateToStr(Date),9,2),16);                // - 01/01/2015
  if (StrToIntDef(Lc_Valida,16) < (Lc_Ano_Atual - 1) ) or (StrToIntDef(Lc_Valida,16) > (Lc_Ano_Atual + 1) ) then
  Begin
    MensagemPadrao('Mensagems',ATENCAO+EOLN+EOLN+
                   'São permitidos apenas o ano anterior e o ano atual .'+EOLN+
                   'Não é possivel continuar.'+EOLN,
                   ['OK'],[bEscape],mpInformacao);
    Result := False;
    exit;
  end;

end;

procedure TFr_Info_Dec_Imp.EditionControl;
begin
  EditionControler(Self);
  pnl_fundos.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  //SB_Inserir.Enabled := ( EditionState = 'B' ) and Pf_Inserir ;
  SB_Alterar.Enabled := ( EditionState = 'B' ) and ( Documento.Registro.Codigo > 0 );
  SB_Excluir.Enabled := ( EditionState = 'B' ) and ( Documento.Registro.Codigo > 0 );
  SB_gravar.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  SB_Cancelar.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Sb_Sair.Enabled := ( EditionState = 'B' );
  //Itens Adicao
  Sb_Ins_Adicao.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Sb_Alt_Adicao.Enabled := (( EditionState = 'I' ) or ( EditionState = 'E' )) and (Qr_Adicao.RecordCount >0);
  Sb_Exc_Adicao.Enabled := (( EditionState = 'I' ) or ( EditionState = 'E' )) and (Qr_Adicao.RecordCount >0);

end;

procedure TFr_Info_Dec_Imp.EditionControler(T: TComponent);
Var
  I:Integer;
begin
  with T do
  Begin
    for I := 0 to ((ComponentCount)-1) do
    begin
      if (Components[I].ClassName = 'TEdit') then
      Begin
        if TEdit (Components[I]).Name = 'E_ID' then
          TEdit (Components[I]).ReadOnly := True
        else
          TEdit (Components[I]).ReadOnly := ( EditionState = 'B' );
      End;

      if (Components[I].ClassName = 'TDBLookupComboBox') then
        TDBLookupComboBox (Components[I]).ReadOnly := ( EditionState = 'B' );

      if (Components[I].ClassName = 'TMemo') then
        TMemo (Components[I]).ReadOnly := ( EditionState = 'B' );

      if (Components[I].ClassName = 'TTreeView') then
        TTreeView (Components[I]).Enabled := ( EditionState = 'B' );

      if (Components[I].ClassName = 'TDBGrid') then
        TDBGrid (Components[I]).ReadOnly := ( EditionState = 'B' );

      if (Components[I].ClassName = 'TSpeedButton') then
        TSpeedButton (Components[I]).Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
    end;
  End;
end;

function TFr_Info_Dec_Imp.Fc_GeraDigito(Fc_numero:String):String;
var
  Lc_Pos : Integer;
  Lc_Nrm : Integer;
  Lc_Mtp : Integer;
  Lc_Soma : Integer;
  Lc_Resto : Integer;
  Lc_Digito : Integer;

begin
  Lc_Mtp := 2;
  Lc_Soma := 0;
  for Lc_Pos := Length(Fc_numero) downto 1 do
  begin
    Lc_Nrm := StrToInt(Copy(Fc_numero, Lc_Pos, 1));
    Lc_Soma := Lc_Soma + (Lc_Nrm * Lc_Mtp);
    inc(Lc_Mtp);
    if (Lc_Mtp = 10) then Lc_Mtp := 2
  end;
  Lc_Resto := (Lc_Soma mod 11);
  if (Lc_Resto = 0) or (Lc_Resto = 1) then
    Lc_digito := 0
  else
    Lc_digito := 11 - Lc_Resto;
  Result := IntToStr(Lc_Digito);

end;

end.

