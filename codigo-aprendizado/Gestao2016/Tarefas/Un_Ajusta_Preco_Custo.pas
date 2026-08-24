unit Un_Ajusta_Preco_Custo;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, DBCtrls, Mask, Gauges, STQuery, System.Math, DB, ActnList, QEdit_Setes, Vcl.ComCtrls, ACBrUtil;

type
   TFr_AjustaPrecoCusto = class(TForm)
    Panel2: TPanel;
    Gg_Progresso: TGauge;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    Qr_Fornecedor: TSTQuery;
    Ds_Fornecedor: TDataSource;
    Pg_Geral: TPageControl;
    tbs_Multiplos: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBLCB_Grupo: TDBLookupComboBox;
    DBLCB_SubGrupo: TDBLookupComboBox;
    DBLCB_Marca: TDBLookupComboBox;
    chbx_ValidaGrupoSubgrupo: TCheckBox;
    ListBox: TListBox;
    Panel4: TPanel;
    Label4: TLabel;
    E_VL_Preco: TEdit_Setes;
      procedure Btn_CancelaClick(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure FormCreate(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure ACT_CONFIRMARExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLCB_GrupoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLCB_SubGrupoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLCB_MarcaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SB_ConfirmarClick(Sender: TObject);
   private
    { Private declarations }
    TipoFoco : String;
    CasaDecimal : Integer;
    procedure AlteraMultiplo;

   public
    { Public declarations }
      It_Confirmar: Boolean;
      It_Visualizar: Boolean;
      procedure Pc_AtivaTabela(Lc_Ativa: Boolean);
      procedure Pc_SelItens(Pc_Grupo, Pc_SubGrupo, Pc_Marca: Integer);
      function FC_Validacao:boolean;
      procedure Pc_PermissaoBotao(Pc_Menu: string);
      procedure Pc_ImagemBotao;

   end;

var
   Fr_AjustaPrecoCusto: TFr_AjustaPrecoCusto;

implementation

uses     Un_Msg, Un_DM, UN_Sistema, UN_Principal, env, Un_Funcoes, Un_Pesq_Produto, RN_Produto, ControllerPreco, ControllerProduto, ControllerBase;
{$R *.dfm}



procedure TFr_AjustaPrecoCusto.Pc_AtivaTabela(Lc_Ativa: Boolean);
begin
  DM.Qr_Grupo.Active := Lc_Ativa;
  DM.Qr_SubGrupo.Active := Lc_Ativa;
  DM.Qr_MarcaProduto.Active := Lc_Ativa;
  DM.Qr_Tabelas.Active:=Lc_Ativa;
  Qr_Fornecedor.Active:=Lc_Ativa;
end;

procedure TFr_AjustaPrecoCusto.Pc_SelItens(Pc_Grupo, Pc_SubGrupo, Pc_Marca: Integer);
var
  Lc_Qry_Tabela: TSTQuery;
  Lc_Qry_Atualiza: TSTQuery;
  Lc_SqlTxt: string;
  Lc_Valor: Real;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry_Tabela := LcBase.GeraQuery;
    Lc_Qry_Atualiza := LcBase.GeraQuery;
    Lc_SqlTxt := concat(
                    'SELECT PRO_CODIGO, PRO_DESCRICAO, PRO_VL_CUSTO ',
                    'from TB_PRODUTO  ',
                    ' WHERE  PRO_CODIGO IS NOT NULL '
                );

    If Pc_Grupo > 0 then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_CODGRP=:PRO_CODGRP) ';

    If Pc_SubGrupo > 0 then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_CODSBG=:PRO_CODSBG) ';

    If Pc_Marca > 0 then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_CODMRC=:PRO_CODMRC)  ';

    Lc_Qry_Tabela.SQL.Add(Lc_SqlTxt);

    //Passagem de Parametros
    If Pc_Grupo > 0 then
      Lc_Qry_Tabela.ParamByName('PRO_CODGRP').AsInteger := PC_Grupo;

    If Pc_SubGrupo > 0 then
      Lc_Qry_Tabela.ParamByName('PRO_CODSBG').AsInteger := Pc_SubGrupo;

    If Pc_Marca > 0 then
      Lc_Qry_Tabela.ParamByName('PRO_CODMRC').AsInteger := Pc_Marca;


    Lc_Qry_Tabela.Active := True;
    Lc_Qry_Tabela.FetchAll;

    Gg_Progresso.Progress := 0;
    Gg_Progresso.MinValue := 0;
    Gg_Progresso.MaxValue := Lc_Qry_Tabela.RecordCount;

    Sleep(3000);
    if Lc_Qry_Tabela.RecordCount > 0 then
    begin
      Lc_SqlTxt := '';
      Lc_SqlTxt := ' UPDATE tb_produto SET           '+
                   ' PRO_VL_BASE_TROCA =:PRO_VL_BASE_TROCA '+
                   ' WHERE PRO_CODIGO = :PRO_CODIGO  ';

      Lc_Qry_Atualiza.SQL.Add(Lc_SqlTxt);

      Lc_Qry_Tabela.First;
      while not Lc_Qry_Tabela.Eof do
      begin
        Lc_Qry_Atualiza.Close;
        Lc_Qry_Atualiza.ParamByName('PRO_VL_BASE_TROCA').AsCurrency := StrToFloatDEf(E_VL_Preco.text,0);
        Lc_Qry_Atualiza.ParamByName('PRO_CODIGO').AsInteger := Lc_Qry_Tabela.FieldByName('PRO_CODIGO').AsInteger;
        Lc_Qry_Atualiza.ExecSQL;
        Lc_Qry_Tabela.Next;
        Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
        Gg_Progresso.Update;
      end;
    end
    else
    begin
      ShowMessage('Não há Produtos com estas Informações!!');
    end;
  Finally
    Gg_Progresso.Update;
    LcBase.FinalizaQuery(Lc_Qry_Tabela);
    LcBase.FinalizaQuery(Lc_Qry_Atualiza);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_AjustaPrecoCusto.Btn_CancelaClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_AjustaPrecoCusto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Pc_AtivaTabela(False);
end;

procedure TFr_AjustaPrecoCusto.FormCreate(Sender: TObject);
begin
  Pc_AtivaTabela(True);
  Pc_PermissaoBotao('Ajusta Preço');
end;

function TFr_AjustaPrecoCusto.FC_Validacao: boolean;
begin
  result:=true;
  if not chbx_ValidaGrupoSubgrupo.Checked then
  Begin
    If DBLCB_Grupo.Text = '' then
    begin
      Result:=False;
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Por favor escolha um Grupo.' + EOLN ,
          ['Ok'], [bEscape], mpErro);
      DBLCB_Grupo.SetFocus;
      exit;
    end;
    If DBLCB_SubGrupo.Text = '' then
    begin
      Result:=False;
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Por favor escolha um SubGrupo.' + EOLN ,
                     ['Ok'], [bEscape], mpErro);
      DBLCB_SubGrupo.SetFocus;
      exit;
    end;
  end;

  If DBLCB_Marca.Text = '' then
  begin
    Result:=False;
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por favor escolha uma Marca.' + EOLN ,
                   ['Ok'], [bEscape], mpErro);
    DBLCB_Marca.SetFocus;
    exit;
  end;

  if StrToFloatDEf(E_VL_Preco.Text,0) = 0 then
  begin
    Result:=false;
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por favor informe o preço.' + EOLN ,
                   ['Ok'], [bEscape], mpErro);
    E_VL_Preco.SetFocus;
    exit;
  end;

end;

procedure TFr_AjustaPrecoCusto.SB_ConfirmarClick(Sender: TObject);
begin
  case Pg_Geral.ActivePageIndex of
    0:AlteraMultiplo;
  end;
end;

procedure TFr_AjustaPrecoCusto.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_AjustaPrecoCusto.AlteraMultiplo;
Var
  Lc_Cd_Grupo: Integer;
  Lc_Cd_Subgrupo: Integer;
  Lc_Cd_Marca: Integer;
  Lc_cd_Tabela: Integer;
  Lc_Cd_Fornece: Integer;
begin
  if FC_Validacao then
  begin
    try
      if Trim(DBLCB_Grupo.Text) <> '' then
        Lc_Cd_Grupo := DBLCB_Grupo.KeyValue
      else
        Lc_Cd_Grupo := 0;

      if Trim(DBLCB_SubGrupo.Text) <> '' then
        Lc_Cd_Subgrupo := DBLCB_SubGrupo.KeyValue
      else
        Lc_Cd_Subgrupo := 0;

      if Trim(DBLCB_Marca.Text) <> '' then
        Lc_Cd_Marca := DBLCB_Marca.KeyValue
      else
        Lc_Cd_Marca := 0;

      Pc_SelItens(Lc_Cd_Grupo,
                  Lc_Cd_Subgrupo,
                  Lc_Cd_Marca);
      IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
      MessageBox(Handle, 'Operação realizada com sucesso..!!!',
                         'Atenção', MB_OK + MB_ICONWARNING);
    except
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Erro ao gerar O Ajuste dos Preços.' + EOLN +
                     'Verifique os dados do Produto.' + EOLN,
                    ['OK'], [bEscape], mpErro);
      DM.IB_Transacao.RollbackRetaining;
    end;
  end;
end;

procedure TFr_AjustaPrecoCusto.ACT_CONFIRMARExecute(Sender: TObject);
begin
  SB_ConfirmarClick(Sender);
end;

procedure TFr_AjustaPrecoCusto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F10  : if SB_Confirmar.Enabled then SB_ConfirmarClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_AjustaPrecoCusto.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Confirmar  := True;
    It_Visualizar := True;
    end
  else
    begin
    It_Confirmar  := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    end;
  SB_Confirmar.Enabled:= It_Confirmar;
end;

procedure TFr_AjustaPrecoCusto.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    SB_Confirmar.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    SB_Sair_0 .Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

procedure TFr_AjustaPrecoCusto.DBLCB_GrupoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Grupo.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_AjustaPrecoCusto.DBLCB_SubGrupoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_SubGrupo.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_AjustaPrecoCusto.DBLCB_MarcaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Marca.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_AjustaPrecoCusto.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao
end;

procedure TFr_AjustaPrecoCusto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

end.

