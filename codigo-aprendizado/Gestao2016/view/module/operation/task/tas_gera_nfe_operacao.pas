unit tas_gera_nfe_operacao;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, STDataSet, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.Menus, Data.DB, STQuery, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, tas_gera_nfce_autorizacao, tas_gera_nfe_autorizacao, un_geranfe3X;

type
  TTasGeraNfeOperacao = class(TTasGeraNfeAutorizacao)
    tbs_Oper_Nfe: TTabSheet;
    Panel9: TPanel;
    Sb_Clta_NFe_Confirmar: TSpeedButton;
    Sb_Clta_Nfe_Voltar: TSpeedButton;
    Panel1: TPanel;
    Label1: TLabel;
    Lb_6_Inicio: TLabel;
    Lb_6_Fim: TLabel;
    MM_Clta_NFe_Retorno: TMemo;
    Ed_6_Inicio: TEdit;
    Ed_6_Fim: TEdit;
    RG_6_Tipo_Pesquisa: TRadioGroup;
    chbx_oper_Nfe_CAnceladas: TCheckBox;
    Chbx_NFe_Pendente: TCheckBox;
    procedure Sb_Clta_NFe_ConfirmarClick(Sender: TObject);
    procedure Sb_Clta_Nfe_VoltarClick(Sender: TObject);
    procedure RG_6_Tipo_PesquisaClick(Sender: TObject);
  private
    procedure ConsultaLoteNFE;
  protected
    procedure ImagemBotao;Override;

    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
  public
    { Public declarations }
  end;

var
  TasGeraNfeOperacao: TTasGeraNfeOperacao;

implementation

uses     ControllerBase, UN_Principal, env, RN_NotaFiscalEletronica3X, Un_Sistema;
{$R *.dfm}

procedure TTasGeraNfeOperacao.ConsultaLoteNFE;
Var
  Lc_Qry: TSTQuery;
  Lc_Tamanho: Integer;
  Lc_Chave: String;
  Lc_Path: String;
  Lc_FileXML: String;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;

  Try
    with Lc_Qry do
    Begin
      FTipoOperacao := 'NF-e';
      sql.Add('select retorno.*, nota.NFL_NUMERO, nota.NFL_CODIGO, nota.NFL_CODPED '
        + 'from TB_RETORNO_NFE retorno ' + '  INNER JOIN TB_NOTA_FISCAL nota ' +
        '  ON (NFL_CODIGO = NFE_CODNFL) ' + 'where NFE_CODMHA =:NFE_CODMHA ');
      if RG_6_Tipo_Pesquisa.ItemIndex = 0 then
      Begin
        sql.Add(' AND NFE_NOTA_INI between :INICIO and :FIM ');
      end
      else
      Begin
        sql.Add(' AND NFL_DT_EMISSAO between :INICIO and :FIM ');
      end;
      if Chbx_NFe_Pendente.Checked then
        sql.Add(' and (NFE_CODSIT < 2) ');

      if chbx_oper_Nfe_CAnceladas.Checked then
        sql.Add(' and (NFE_CODSIT = 3) ');

      sql.Add(' ORDER BY NFE_NOTA_INI ');
      ParamByName('NFE_CODMHA').AsInteger := Gb_CodMha;
      ParamByName('INICIO').AsString := Ed_6_Inicio.Text;
      ParamByName('FIM').AsString := Ed_6_Fim.Text;
      Active := True;
      FetchAll;
      MM_Clta_NFe_Retorno.Clear;
      Lc_Path := Fc_TrazRepositorio('NFE_REPOSITORIO');
      While not Eof do
      Begin
        It_Cd_Nota := FieldByName('NFL_CODIGO').AsInteger;
        It_Nr_Nota := StrToIntDef(FieldByName('NFL_NUMERO').AsString,0);
        It_Cd_Pedido := FieldByName('NFL_CODPED').AsInteger;
        Fc_AtivaDadosDaNota('C', It_Cd_Nota);
        Fc_AtivaRetornoNFe(It_Cd_Nota);
        Pc_ConsultaNFe;
        MM_Clta_NFe_Retorno.Lines.Add('Nota Fiscal : ' + FieldByName('NFE_NOTA_INI').AsString);
        MM_Clta_NFe_Retorno.Lines.Add('Situção: ' + Fr_Principal.Nfe.WebServices.Consulta.XMotivo);
        MM_Clta_NFe_Retorno.Lines.Add('--------------------------------------------------');
        Next;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;


procedure TTasGeraNfeOperacao.FormataTela;
begin
  inherited;
  pg_Principal.ActivePage := tbs_Oper_Nfe;
end;

procedure TTasGeraNfeOperacao.ImagemBotao;
begin
  with Fr_Principal do
  Begin
    // Operções NFe
    CarregaImagemBotao(Sb_Clta_NFe_Confirmar,'CONFIRMAR');
    CarregaImagemBotao(Sb_Clta_Nfe_Voltar,'SAIR');
  End;
end;

procedure TTasGeraNfeOperacao.IniciaVariaveis;
begin
  Pc_FormataModeloNFE;
end;

procedure TTasGeraNfeOperacao.RG_6_Tipo_PesquisaClick(Sender: TObject);
begin
  if RG_6_Tipo_Pesquisa.ItemIndex = 0 then
  BEgin
    Lb_6_Inicio.Caption := 'Número Inicial';
    Lb_6_Fim.Caption := 'Número Final';
  end
  else
  Begin
    Lb_6_Inicio.Caption := 'Data Inicial';
    Lb_6_Fim.Caption := 'Data Final';

  end;
end;

procedure TTasGeraNfeOperacao.Sb_Clta_NFe_ConfirmarClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(self, 'I');
    self.Enabled := False;
    ConsultaLoteNFE;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    self.BringToFront;
  end;

end;

procedure TTasGeraNfeOperacao.Sb_Clta_Nfe_VoltarClick(Sender: TObject);
begin
  Close;
end;

end.
