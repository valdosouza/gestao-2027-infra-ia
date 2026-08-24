unit tas_gera_nfe_inutiliza;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_geranfe3X, STDataSet, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.Menus, Data.DB, STQuery, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls;

type
  TTasGeraNfeInutiliza = class(TFr_GeraNfe3x)
    tbs_inutiliza: TTabSheet;
    pnl_Inutil_nfe: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    E_Inut_Ano: TEdit;
    E_Inut_Numero_Ini: TEdit;
    E_Inut_Numero_Fim: TEdit;
    E_Inut_Justificativa: TEdit;
    MM_Inut_Reposta: TMemo;
    Rg_Inut_TipoNfe: TRadioGroup;
    Panel5: TPanel;
    Sb_Inut_nfe_Confirmar: TSpeedButton;
    Sb_Inut_nfe_Volta: TSpeedButton;
    procedure Sb_Inut_nfe_ConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Sb_Inut_nfe_VoltaClick(Sender: TObject);
  private
    procedure Clear;

    function ValidaInutilizacao(): Boolean;
    procedure InutilizarNFE;
    procedure LiberaNumeroNota;
  protected
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;

  public
    { Public declarations }
  end;

var
  TasGeraNfeInutiliza: TTasGeraNfeInutiliza;

implementation

uses     ControllerCtrlNF, UN_Principal, Un_DM, env, Un_Funcoes, ControllerBase, un_sistema, un_msg;
{$R *.dfm}


procedure TTasGeraNfeInutiliza.Clear;
begin
  E_Inut_Ano.Clear;
  E_Inut_Numero_Ini.Clear;
  E_Inut_Numero_Fim.Clear;
  E_Inut_Justificativa.Clear;
  MM_Inut_Reposta.Clear;
end;

procedure TTasGeraNfeInutiliza.CriarVariaveis;
begin

end;

procedure TTasGeraNfeInutiliza.FormataTela;
begin
  inherited;
  pg_Principal.ActivePage := tbs_inutiliza;
end;

procedure TTasGeraNfeInutiliza.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F10:
      if Sb_Inut_nfe_Confirmar.Enabled then
        Sb_Inut_nfe_ConfirmarClick(self);
    VK_Escape:
      if Sb_Inut_nfe_Volta.Enabled then
        Sb_Inut_nfe_VoltaClick(self);
  end;

end;

procedure TTasGeraNfeInutiliza.ImagemBotao;
begin
  with Fr_Principal do
  Begin
    CarregaImagemBotao(Sb_Inut_nfe_Confirmar,'CONFIRMAR');
    CarregaImagemBotao(Sb_Inut_nfe_Volta,'SAIR');
  End;
end;

procedure TTasGeraNfeInutiliza.IniciaVariaveis;
begin
  Clear;
end;

procedure TTasGeraNfeInutiliza.InutilizarNFE;
var
  Lc_FileXML, Lc_Modelo, Lc_Serie: String;
  Lc_CtrlNota: TControllerCtrlNF;
  Lc_NF_Inicio, Lc_NF_Fim: Integer;
  I: Integer;
begin
  MM_Inut_Reposta.Lines.Clear;
  if Rg_Inut_TipoNfe.ItemIndex = 1 then
    Lc_Modelo := '65'
  else
    Lc_Modelo := '55';
  Lc_NF_Inicio := StrToIntDEf(E_Inut_Numero_Ini.Text,1);
  Lc_NF_Fim := StrToIntDef(E_Inut_Numero_Fim.Text,1);

  Lc_Serie := '1';

  with Fr_Principal.Nfe.WebServices do
  Begin
    Inutiliza(DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString,
      E_Inut_Justificativa.Text, StrToIntDef(E_Inut_Ano.Text,2018), StrToIntDef(Lc_Modelo,55),
      StrToIntDef(Lc_Serie,1), Lc_NF_Inicio, Lc_NF_Fim);

    if Trim(Inutilizacao.Protocolo) <> '' then
    Begin
      // MM_Inut_Reposta.Lines.Add(Inutilizacao.RetornoWS);
      // Pega os dados dentro do Componenente conforme a Tag
      MM_Inut_Reposta.Lines.Add('Retorno Mensagem : ' + Inutilizacao.Msg);
      MM_Inut_Reposta.Lines.Add('Número Inicial   : ' + E_Inut_Numero_Ini.Text);
      MM_Inut_Reposta.Lines.Add('Número Final     : ' + E_Inut_Numero_Fim.Text);
      MM_Inut_Reposta.Lines.Add('Data Operção    : ' +
        DateToStr(Inutilizacao.dhRecbto));
      MM_Inut_Reposta.Lines.Add('Protocolo        : ' + Inutilizacao.Protocolo);

      Lc_CtrlNota := TControllerCtrlNF.Create(self);
      with Lc_CtrlNota do
      Begin
        for I := Lc_NF_Inicio to Lc_NF_Fim do
        Begin
          with Registro do
          Begin
            CodigoEmissor := Gb_CodMha;
            NumeroNota := StrZero(I, 6, 0);
            ModeloNota := Lc_Modelo;
            SerieNota := Lc_Serie;
            CodigoSituacao := 4;
            DataEmissao := Inutilizacao.dhRecbto;
            CodigoNotaFiscal := 0;
            ChaveNota := '';
            Observacao := 'Protocolo Inutilizção: ' + Inutilizacao.Protocolo;
            CodigoEstabelecimento := Gb_CodMha;
          End;
          salva;
        end;
      End;
    end
    else
    Begin
      MM_Inut_Reposta.Lines.Add('Retorno Mensagem : ' + Inutilizacao.Msg);
    End;
  end;
end;

procedure TTasGeraNfeInutiliza.LiberaNumeroNota;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_I : Integer;
begin
  exit;
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      if ( Rg_Inut_TipoNfe.ItemIndex = 0 ) then
      Begin
        sql.Add('UPDATE TB_NOTA_FISCAL SET '+
                'NFL_NUMERO = Null ' +
                'WHERE NFL_NUMERO =:NFL_NUMERO AND (NFL_TIPO = ''SI'') ');
        for Lc_I := StrToIntDef(E_Inut_Numero_Ini.Text,0) to StrToIntDef(E_Inut_Numero_Fim.Text,0) do
        Begin
          Active := False;
          ParamByName('NFL_NUMERO').AsString := E_Inut_Numero_Ini.Text;
          Active := True;
        End;
      End
      else
      Begin


      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TTasGeraNfeInutiliza.Sb_Inut_nfe_ConfirmarClick(Sender: TObject);
begin
  TRY
    Pc_ProcesoAguarde(self, 'I');
    self.Enabled := False;
    if ValidaInutilizacao then
    Begin
      InutilizarNFE;
      LiberaNumeroNota;
    end;
  Finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Update;
  end;
end;

procedure TTasGeraNfeInutiliza.Sb_Inut_nfe_VoltaClick(Sender: TObject);
begin
  Close;
end;

function TTasGeraNfeInutiliza.ValidaInutilizacao: Boolean;
Var
  Lc_SqlTxt: String;
Begin
  Result := True;
  If Trim(E_Inut_Ano.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'O campo Ano precisa ser informado.' + EOLN +
      '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    E_Inut_Ano.setfocus;
    Exit;
  end;

  If Trim(E_Inut_Numero_Ini.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'O campo Número Inicial precisa ser informado.' + EOLN +
      '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    E_Inut_Numero_Ini.setfocus;
    Exit;
  end;

  If Trim(E_Inut_Numero_Fim.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'O campo Número Final precisa ser informado.' + EOLN +
      '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    E_Inut_Numero_Fim.setfocus;
    Exit;
  end;

  If Trim(E_Inut_Justificativa.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'O campo Justificativa � obrigatório.' + EOLN +
      '    Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    E_Inut_Justificativa.setfocus;
    Exit;
  end;

  If Length(E_Inut_Justificativa.Text) < 15 then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'A Justificativa não deve ser ' + '  inferior a 15 caracteres.' + EOLN +
      'Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    E_Inut_Justificativa.setfocus;
    Exit;
  end;
end;

end.
