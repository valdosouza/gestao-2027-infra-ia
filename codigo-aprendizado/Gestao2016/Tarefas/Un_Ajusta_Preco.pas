unit Un_Ajusta_Preco;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, DBCtrls, Mask, Gauges, STQuery, System.Math, DB, ActnList, QEdit_Setes, Vcl.ComCtrls, ACBrUtil;

type
   TFr_AjustaPreco = class(TForm)
    Panel2: TPanel;
    Gg_Progresso: TGauge;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    Qr_Fornecedor: TSTQuery;
    Ds_Fornecedor: TDataSource;
    Pg_Geral: TPageControl;
    tbs_Multiplos: TTabSheet;
    tbs_Individual: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    DBLCB_Grupo: TDBLookupComboBox;
    DBLCB_SubGrupo: TDBLookupComboBox;
    DBLCB_Marca: TDBLookupComboBox;
    DBLCB_TabelaPreco: TDBLookupComboBox;
    GroupBox1: TGroupBox;
    lc_fornecedor: TLabel;
    Label8: TLabel;
    E_Nr_Nota: TEdit_Setes;
    DBLCB_Fornecedor: TDBLookupComboBox;
    E_CodFor: TEdit_Setes;
    chbx_ValidaGrupoSubgrupo: TCheckBox;
    ListBox: TListBox;
    Panel3: TPanel;
    E_Codigo: TEdit_Setes;
    Label5: TLabel;
    Label9: TLabel;
    E_Codigo_Barras: TEdit_Setes;
    Label10: TLabel;
    SB_Cad_produto: TSpeedButton;
    E_VL_Normal: TEdit_Setes;
    Label11: TLabel;
    Label12: TLabel;
    E_VL_Promocao: TEdit_Setes;
    Chbx_Promocao: TCheckBox;
    E_Produto: TEdit;
    Panel4: TPanel;
    Label4: TLabel;
    Rg_Tipo: TRadioGroup;
    Rg_Casas: TRadioGroup;
    E_Margem: TEdit_Setes;
      procedure Btn_CancelaClick(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure FormCreate(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure ACT_CONFIRMARExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLCB_FornecedorExit(Sender: TObject);
    procedure DBLCB_GrupoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLCB_SubGrupoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLCB_MarcaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLCB_FornecedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure E_CodForExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure SB_Cad_produtoClick(Sender: TObject);
    procedure E_CodigoExit(Sender: TObject);
    procedure E_VL_NormalEnter(Sender: TObject);
    procedure E_VL_PromocaoEnter(Sender: TObject);
    procedure E_Codigo_BarrasExit(Sender: TObject);
    procedure E_VL_PromocaoExit(Sender: TObject);
   private
    { Private declarations }
    TipoFoco : String;
    CasaDecimal : Integer;
    procedure AlteraMultiplo;
    procedure AlteraIndividual;
    function ValidaAlteraIndividual:Boolean;
   public
    { Public declarations }
      It_Confirmar: Boolean;
      It_Visualizar: Boolean;
      procedure Pc_AtivaTabela(Lc_Ativa: Boolean);
      procedure Pc_SelItens(Pc_Grupo, Pc_SubGrupo, Pc_Marca: Integer;Pc_CodTabelaPreco,Pc_Cd_Fornecedor:Integer;Pc_Nr_Nota:String);
      function FC_Validacao:boolean;
      procedure Fc_CasasDecimais;
      procedure Pc_PermissaoBotao(Pc_Menu: string);
      procedure Pc_ImagemBotao;
      procedure PegaProdutoByBarra(Fc_Codigo: String);
   end;

var
   Fr_AjustaPreco: TFr_AjustaPreco;

implementation

uses     Un_Msg, Un_DM, UN_Sistema, UN_Principal, env, Un_Funcoes, Un_Pesq_Produto, RN_Produto, ControllerPreco, ControllerProduto, ControllerBase;
{$R *.dfm}

procedure TFr_AjustaPreco.PegaProdutoByBarra(Fc_Codigo: String);
var
  Lc_SQL: String;
  Lc_Tp_Descricao : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SQL := 'SELECT PRO_CODIGO, PRO_DESCRICAO FROM TB_PRODUTO '+
                'WHERE PRO_CODIGOBAR =:PRO_CODIGOBAR' ;
      SQL.Add(Lc_SQL);
      ParamByName('PRO_CODIGOBAR').AsString := Fc_Codigo;
      Active := True;
      FetchAll;

      if RecordCount > 0 then
      begin
        E_Codigo.Text := FieldByName('PRO_CODIGO').AsString;
        E_Produto.Text := FieldByName('PRO_DESCRICAO').AsString;
        E_VL_Normal.SetFocus;
        E_VL_Normal.SelectAll;
      end
      else
      begin
        E_Codigo_Barras.SetFocus;
        E_Codigo_Barras.clear;
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Produto não encontrado.'+EOLN,
                       ['OK'],[bEscape],mpAlerta);
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;


procedure TFr_AjustaPreco.Pc_AtivaTabela(Lc_Ativa: Boolean);
begin
  DM.Qr_Grupo.Active := Lc_Ativa;
  DM.Qr_SubGrupo.Active := Lc_Ativa;
  DM.Qr_MarcaProduto.Active := Lc_Ativa;
  DM.Qr_Tabelas.Active:=Lc_Ativa;
  Qr_Fornecedor.Active:=Lc_Ativa;
end;

Procedure TFr_AjustaPreco.Fc_CasasDecimais;
begin
  case Rg_Casas.ItemIndex of
    0: CasaDecimal:= 0;
    1: CasaDecimal := 2;
    2: CasaDecimal := 3;
    3: CasaDecimal := 4;
    4: CasaDecimal := 5;
    5: CasaDecimal := 6;
  end;
end;

procedure TFr_AjustaPreco.Pc_SelItens(Pc_Grupo, Pc_SubGrupo, Pc_Marca: Integer;Pc_CodTabelaPreco,Pc_Cd_Fornecedor:Integer;Pc_Nr_Nota:String);
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
    if (Pc_Cd_Fornecedor > 0) and (StrToIntDef(Pc_Nr_Nota,0)>0) then
    Begin
      Lc_SqlTxt := 'SELECT distinct PRO_CODIGO, PRO_DESCRICAO, PRO_VL_CUSTO, PRC_VL_VDA '+
                   'from tb_nota_fiscal '+
                   ' inner join tb_itens_nfl on (itf_codnfl = nfl_codigo) '+
                   ' inner join tb_produto   on (pro_codigo = ITF_CODPRO) '+
                   ' INNER JOIN TB_PRECO     ON (PRC_CODPRO = PRO_CODIGO) '+
                   ' WHERE  tb_preco.PRC_CODTPR = :PRC_CODTPR '+
                   ' AND (NFL_CODEMP =:EMP_CODIGO) AND (NFL_NUMERO =:NFL_NUMERO)';
    end
    else
    Begin
      Lc_SqlTxt := ' SELECT PRO_CODIGO, PRO_DESCRICAO, PRO_VL_CUSTO, PRC_VL_VDA from TB_PRODUTO  '+
                   ' INNER JOIN TB_PRECO TB_PRECO ON TB_PRECO.PRC_CODPRO = TB_PRODUTO.PRO_CODIGO '+
                   ' WHERE  tb_preco.PRC_CODTPR = :PRC_CODTPR ';
    end;

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

    Lc_Qry_Tabela.ParamByName('PRC_CODTPR').AsInteger := Pc_CodTabelaPreco;
    if (Pc_Cd_Fornecedor > 0) and (StrToIntDef(Pc_Nr_Nota,0)>0) then
    Begin
      Lc_Qry_Tabela.ParamByName('EMP_CODIGO').AsInteger := Pc_Cd_Fornecedor;
      Lc_Qry_Tabela.ParamByName('NFL_NUMERO').AsString := StrZero(StrToIntDef(Pc_Nr_Nota,0),6,0);
    end;
    Lc_Qry_Tabela.Active := True;
    Lc_Qry_Tabela.FetchAll;

    Gg_Progresso.Progress := 0;
    Gg_Progresso.MinValue := 0;
    Gg_Progresso.MaxValue := Lc_Qry_Tabela.RecordCount;

    Sleep(3000);
    if Lc_Qry_Tabela.RecordCount > 0 then
    begin
      Lc_SqlTxt := '';
      Lc_SqlTxt := ' UPDATE tb_preco SET           '+
                   ' PRC_VL_VDA =:PRC_VL_VDA       '+
                   ' WHERE                         '+
                   '     PRC_CODPRO = :PRC_CODPRO  '+
                   ' and PRC_CODTPR = :PRC_CODTPR  ';

      Lc_Qry_Atualiza.SQL.Add(Lc_SqlTxt);

      Lc_Qry_Tabela.First;
      while not Lc_Qry_Tabela.Eof do
      begin
        if Rg_Tipo.ItemIndex = 0 then
        begin
          Lc_Valor := 0;
          Lc_Valor := Lc_Qry_Tabela.FieldByName('PRC_VL_VDA').AsCurrency + (Lc_Qry_Tabela.FieldByName('PRC_VL_VDA').AsCurrency * (StrToFloatDef(E_Margem.Text, 0) / 100));
        end
        else
        begin
          Lc_Valor := 0;
          Lc_Valor := Lc_Qry_Tabela.FieldByName('PRC_VL_VDA').AsCurrency - (Lc_Qry_Tabela.FieldByName('PRC_VL_VDA').AsCurrency * (StrToFloatDef(E_Margem.Text, 0) / 100));
        end;
        Lc_Qry_Atualiza.Close;
        Lc_Qry_Atualiza.ParamByName('PRC_CODPRO').AsInteger := Lc_Qry_Tabela.FieldByName('PRO_CODIGO').AsInteger;
        Lc_Qry_Atualiza.ParamByName('PRC_CODTPR').AsInteger := Pc_CodTabelaPreco;
        Lc_Qry_Atualiza.ParamByName('PRC_VL_VDA').AsCurrency := RoundABNT(Lc_Valor,CasaDecimal);
        Lc_Qry_Atualiza.ExecSQL;
        Lc_Qry_Tabela.Next;
        Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
        Application.ProcessMessages
      end;
    end
    else
    begin
      ShowMessage('Não há Produtos com estas Informações!!');
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry_Tabela);
    LcBase.FinalizaQuery(Lc_Qry_Atualiza);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_AjustaPreco.Btn_CancelaClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_AjustaPreco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Pc_AtivaTabela(False);
end;

procedure TFr_AjustaPreco.FormCreate(Sender: TObject);
begin
  Pc_AtivaTabela(True);
  Pc_PermissaoBotao('Ajusta Preço');
end;

function TFr_AjustaPreco.FC_Validacao: boolean;
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
    If DBLCB_Marca.Text = '' then
    begin
      Result:=False;
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Por favor escolha uma Marca.' + EOLN ,
                     ['Ok'], [bEscape], mpErro);
      DBLCB_Marca.SetFocus;
      exit;
    end;
  end;


  If DBLCB_TabelaPreco.Text = '' then
  begin
    Result:=False;
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por favor escolha uma Tabela de Preço.' + EOLN ,
                   ['Ok'], [bEscape], mpErro);
    DBLCB_TabelaPreco.SetFocus;
    exit;
  end;
  if E_Margem.Text = '' then
  begin
    Result:=false;
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por favor digite a margem.' + EOLN ,
                   ['Ok'], [bEscape], mpErro);
    E_Margem.SetFocus;
    exit;
  end;
  if DBLCB_Fornecedor.Text <> '' then
  begin
    if StrToIntDef(E_Nr_Nota.Text,0) = 0 then
    begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Se o campo fornecedor for preenchido o campo '+EOLN+
                     ' Número da Nota Fiscal é obrigatorio.' + EOLN ,
                     ['Ok'], [bEscape], mpAlerta);
      Result:=false;
      E_Nr_Nota.SetFocus;
      exit;
    END;
  end;
  if StrToIntDef(E_Nr_Nota.Text,0) > 0  then
  begin
    if DBLCB_Fornecedor.Text = '' then
    begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Se o campo Número da Nota Fiscal for preenchido o campo '+EOLN+
                     ' Fornecedor é obrigatorio.' + EOLN ,
                     ['Ok'], [bEscape], mpAlerta);
      Result:=false;
      DBLCB_Fornecedor.SetFocus;
      exit;
    END;
  end;

end;

procedure TFr_AjustaPreco.SB_Cad_produtoClick(Sender: TObject);
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  Lc_Form := TFr_Pesq_Produto.Create(Self);
  Lc_Form.Pc_Tabelas_Disponiveis;
  Lc_Form.it_Modalidade_preco := 'A';
  Lc_Form.ShowModal;
  //Depois que Fecha o Relatorio
  if Lc_Form.It_Visualizar then
  Begin
    E_Codigo.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
    E_Codigo_Barras.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGOBAR').AsString;
    E_Produto.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString;
    E_VL_Normal.SetFocus;
  end;
  FreeAndNil(Lc_Form) ;
end;

procedure TFr_AjustaPreco.SB_ConfirmarClick(Sender: TObject);
begin
  Fc_CasasDecimais;
  case Pg_Geral.ActivePageIndex of
    0:AlteraMultiplo;
    1:BEgin
        AlteraIndividual;
        if TipoFoco = 'C' then
          E_Codigo.SetFocus
        else
          E_Codigo_Barras.SetFocus;

      End;
  end;
end;

procedure TFr_AjustaPreco.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

function TFr_AjustaPreco.ValidaAlteraIndividual:Boolean;
Begin
  Result := True;
  If StrToIntDef(E_Codigo.Text,0) = 0 then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Código produto deve ser informado.' + EOLN ,
                   ['Ok'], [bEscape], mpAlerta);
    E_Codigo.SetFocus;
    Result:=False;
    exit;
  end;

  If (E_Produto.Text = '') then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Produto não informado.' + EOLN ,
                   ['Ok'], [bEscape], mpAlerta);
    E_Codigo.SetFocus;
    Result:=False;
    exit;
  end;

  If StrToFloatDef(E_VL_Normal.Text,0) = 0 then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Valor normal deve ser informado.' + EOLN ,
                   ['Ok'], [bEscape], mpAlerta);
    E_VL_Normal.SetFocus;
    Result:=False;
    exit;
  end;

End;

procedure TFr_AjustaPreco.AlteraIndividual;
Var
  Preco : TControllerPreco;
  Produto : TControllerProduto;
Begin
  if ValidaAlteraIndividual then
  Begin
    Preco := TControllerPreco.Create(Self);
    with Preco do
    Begin
      //Atualiza Tabela normal
      Clear;
      Registro.CodigoTabela := 1;
      Registro.CodigoProduto := StrToIntDef(E_Codigo.Text,0);
      Registro.Valor := StrToFloatDef(E_VL_Normal.Text,0);
      salva;
      //Atualiza Tabela normal
      If StrToFloatDef(E_VL_Promocao.Text,0) > 0 then
      Begin
        Clear;
        Registro.CodigoTabela := 2;
        Registro.CodigoProduto := StrToIntDef(E_Codigo.Text,0);
        Registro.Valor := StrToFloatDef(E_VL_Promocao.Text,0);
        salva;
      End;
    End;
    //Atualiza o campo promoção
    Produto := TControllerProduto.Create(Self);
    Produto.Registro.Codigo := StrToIntDef(E_Codigo.Text,0);
    Produto.getbyId;
    if Produto.exist then
    Begin
      if Chbx_Promocao.Checked then
        Produto.Registro.Campanha := 'S'
      else
        Produto.Registro.Campanha := 'N';
      if (Trim(E_Produto.Text) <> '') then
        Produto.Registro.Descricao := E_Produto.Text;
      Produto.Registro.Ativo := 'S';
      Produto.save;
    End;
    FreeAndNil(Produto);
    FreeAndNil(Preco);
    E_Codigo.Clear;
    E_Codigo_Barras.Clear;
    E_Produto.Clear;
    E_VL_Normal.Text := '0,00';
    E_VL_Promocao.Text := '0,00';
    E_VL_PromocaoExit(Self);
    E_Codigo.SetFocus;
  End;
End;


procedure TFr_AjustaPreco.AlteraMultiplo;
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
    if MessageBox(Handle,
      'Esta operação só podera ser desfeita 1 únicoa vez..' + #13#10 +
      #13#10 + 'Deseja Prosseguir?', 'Warning', MB_YESNO + MB_ICONQUESTION) = IDYES then
      begin
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
      if Trim(DBLCB_TabelaPreco.Text) <> '' then
        Lc_cd_Tabela := DBLCB_TabelaPreco.KeyValue
      else
        Lc_cd_Tabela := 0;

      if Trim(DBLCB_Fornecedor.Text) <> '' then
        Lc_Cd_Fornece := DBLCB_Fornecedor.KeyValue
      else
        Lc_Cd_Fornece := 0;

      Pc_SelItens(Lc_Cd_Grupo,
                  Lc_Cd_Subgrupo,
                  Lc_Cd_Marca,
                  Lc_cd_Tabela,
                  Lc_Cd_Fornece,
                  E_Nr_Nota.text);
                  IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
      MessageBox(Handle, 'Operação realizada com sucesso..!!!',
                         'Atenção', MB_OK + MB_ICONWARNING);
      end;
    except
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Erro ao gerar O Ajuste dos Preços.' + EOLN +
                     'Verifique os dados do Produto.' + EOLN,
                    ['OK'], [bEscape], mpErro);
      DM.IB_Transacao.RollbackRetaining;
    end;
  end;
end;

procedure TFr_AjustaPreco.ACT_CONFIRMARExecute(Sender: TObject);
begin
  SB_ConfirmarClick(Sender);
end;

procedure TFr_AjustaPreco.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFr_AjustaPreco.Pc_PermissaoBotao(Pc_Menu: string);
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

procedure TFr_AjustaPreco.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    SB_Confirmar.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    SB_Sair_0 .Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

procedure TFr_AjustaPreco.DBLCB_FornecedorExit(Sender: TObject);
begin
  if Trim(DBLCB_Fornecedor.Text) <> '' then
  Begin
    E_CodFor.Text := IntToStr(DBLCB_Fornecedor.KeyValue);
  end;
end;

procedure TFr_AjustaPreco.DBLCB_GrupoKeyDown(Sender: TObject;
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

procedure TFr_AjustaPreco.DBLCB_SubGrupoKeyDown(Sender: TObject;
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

procedure TFr_AjustaPreco.DBLCB_MarcaKeyDown(Sender: TObject;
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

procedure TFr_AjustaPreco.DBLCB_FornecedorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Fornecedor.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_AjustaPreco.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao
end;

procedure TFr_AjustaPreco.E_CodForExit(Sender: TObject);
begin
  DBLCB_Fornecedor.KeyValue := StrToIntDef(E_CodFor.Text,0);
    If DBLCB_Fornecedor.CanFocus then DBLCB_Fornecedor.SetFocus;

end;

procedure TFr_AjustaPreco.E_CodigoExit(Sender: TObject);
begin
  If E_Codigo.Text <> '' then
  Begin
    E_Produto.Text := Fc_PegaProduto(E_Codigo.Text,'');
    TipoFoco := 'C';
    if E_Produto.Text = '' then
    BEgin
      E_Codigo.clear;
      E_Codigo.SetFocus
    End
    else
      E_VL_Normal.SetFocus;
  End;
end;


procedure TFr_AjustaPreco.E_Codigo_BarrasExit(Sender: TObject);
begin
  If E_Codigo_Barras.Text <> '' then
  BEgin
    PegaProdutoByBarra(E_Codigo_Barras.Text);
    TipoFoco := 'B';
    if E_Produto.Text = '' then
      E_Codigo_Barras.SetFocus
    else
      E_VL_Normal.SetFocus;
  End;
end;

procedure TFr_AjustaPreco.E_VL_NormalEnter(Sender: TObject);
begin
  E_VL_Normal.SelectAll;
end;

procedure TFr_AjustaPreco.E_VL_PromocaoEnter(Sender: TObject);
begin
  E_VL_Promocao.SelectAll;
end;

procedure TFr_AjustaPreco.E_VL_PromocaoExit(Sender: TObject);
begin
  if StrToFloatDef(E_VL_Promocao.Text,0) > 0 then
  Begin
    Chbx_Promocao.Enabled := True;
    Chbx_Promocao.Checked := True;
  End
  else
  Begin
    Chbx_Promocao.Checked := False;
    Chbx_Promocao.Enabled := False;
  End;
end;

procedure TFr_AjustaPreco.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

end.

