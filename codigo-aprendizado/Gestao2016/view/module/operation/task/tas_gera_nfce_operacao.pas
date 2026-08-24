unit tas_gera_nfce_operacao;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, tas_gera_nfce_autorizacao, STDataSet, Data.DB, STQuery, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, un_geranfe3X;

type
  TTasGeraNfceOperacao = class(TTasGeraNfceAutorizacao)
    tbs_Operacao: TTabSheet;
    Panel6: TPanel;
    Label15: TLabel;
    Lb_3_Inicio: TLabel;
    Lb_3_Fim: TLabel;
    Label29: TLabel;
    RG_3_Tipo_Pesquisa: TRadioGroup;
    Chbx_Pendente: TCheckBox;
    Chbx_pend_Numerada: TCheckBox;
    Chbx_pend_Branco: TCheckBox;
    Chbx_Sem_Sucesso: TCheckBox;
    Ed_3_Inicio: TMaskEdit;
    Ed_3_Fim: TMaskEdit;
    Panel7: TPanel;
    Sb_Confirmar: TSpeedButton;
    Sb_operacao_sair: TSpeedButton;
    Sb_CriarChaveAcesse: TSpeedButton;
    MM_Operacao: TMemo;
    procedure Sb_ConfirmarClick(Sender: TObject);
    procedure Sb_operacao_sairClick(Sender: TObject);
    procedure RG_3_Tipo_PesquisaClick(Sender: TObject);
    procedure Chbx_Sem_SucessoClick(Sender: TObject);
    procedure Sb_CriarChaveAcesseClick(Sender: TObject);
  private
    procedure CancelamentoLoteNotas;
    procedure CancelamentoLoteNotasPendentes;
    procedure CancelamentoLote;
    procedure ConsultaChave;
    procedure ConsultaLote;
  protected
    procedure ImagemBotao;Override;
    procedure IniciaVariaveis;Override;


  public
    { Public declarations }
  end;

var
  TasGeraNfceOperacao: TTasGeraNfceOperacao;

implementation

{$R *.dfm}

uses     un_sistema, UN_Principal, RN_NotaFiscalEletronica3X, env, RN_Estoque, RN_CRud, ControllerBase, Un_Regra_Negocio;
procedure TTasGeraNfceOperacao.Chbx_Sem_SucessoClick(Sender: TObject);
begin
  if (Chbx_Sem_Sucesso.Checked) then
  Begin
    Chbx_Pendente.Checked := False;
    Chbx_Pendente.Enabled := False;
    Chbx_pend_Numerada.Checked := False;
    Chbx_pend_Numerada.Enabled := False;
    Chbx_pend_Branco.Checked := False;
    Chbx_pend_Branco.Enabled := False;
  end
  else
  Begin
    Chbx_Pendente.Enabled := True;
    Chbx_pend_Numerada.Enabled := True;
    Chbx_pend_Branco.Enabled := True;
  end;
end;



procedure TTasGeraNfceOperacao.ImagemBotao;
begin
  with Fr_Principal do
  Begin
    CarregaImagemBotao(Sb_Confirmar,'CONFIRMAR');
    CarregaImagemBotao(Sb_operacao_sair,'SAIR');
  END;
end;

procedure TTasGeraNfceOperacao.IniciaVariaveis;
begin
  inherited;
  Pc_FormataModeloNFCe;
  pg_Principal.ActivePage := tbs_Operacao;
end;

procedure TTasGeraNfceOperacao.CancelamentoLote;
begin
  with MM_Operacao do
  Begin
    Lines.Add('Apagando Movimento Financeiro...');
    MM_Operacao.Update;
    //Foi retirado por que para cancelar deve cancelar a baixa no caixa/banco e o o novo metodo de cancelamento do caixa não apaga o movimento
    Pc_ApagaMovimFinanceiro(It_Cd_Nota);
    Lines.Add('Apagando Financeiro...');
    MM_Operacao.Update;
    Financeiro.Clear;
    Financeiro.Registro.CodigoNota := It_Cd_Nota;
    Financeiro.deleteByNota;

    Lines.Add('Apagando Comissão...');
    MM_Operacao.Update;
    Pc_ApagaComissaoFaturamento( It_Cd_Pedido);

    Lines.Add('Apagando Impostos...');
    MM_Operacao.Update;
    NotaFiscal.Registro.Codigo := It_Cd_Nota;
    NotaFiscal.ApagarImpostos;


    Lines.Add('Apagando Observções...');
    MM_Operacao.Update;
    Pc_ApagaObservacao( It_Cd_Nota);
    Lines.Add('Apagando Nota Fiscal...');
    MM_Operacao.Update;
    Notafiscal.Registro.Codigo := It_Cd_Nota;
    Notafiscal.delete;
    MM_Operacao.Lines.Add('Apagando Informações Vendedor...');
    MM_Operacao.Update;
    Pc_ApagaVendedor( It_Cd_Nota);
    MM_Operacao.Lines.Add('Apagando outras informações...');

    Lines.Add('Atualizando Estoque...');
    MM_Operacao.Update;
    Pc_Delete_Estoque('P', It_Cd_Pedido, 0);

    Fc_ApagarRegistro('TB_PEDIDO', ['PED_CODIGO'], [IntToStr(It_Cd_Pedido)]);
    MM_Operacao.Lines.Add('Cancelamento efetuado com sucesso..');
    MM_Operacao.Update;
  end;

end;

procedure TTasGeraNfceOperacao.CancelamentoLoteNotas;
begin
  with MM_Operacao do
  Begin
    Lines.Add('Apagando Movimento Financeiro...');
    MM_Operacao.Update;
    //Foi retirado por que para cancelar deve cancelar a baixa no caixa/banco e o o novo metodo de cancelamento do caixa não apaga o movimento
    Pc_ApagaMovimFinanceiro(It_Cd_Nota);
    Lines.Add('Apagando Financeiro...');
    MM_Operacao.Update;
    Financeiro.Clear;
    Financeiro.Registro.CodigoNota := It_Cd_Nota;
    Financeiro.deleteByNota;

    Lines.Add('Apagando Comissão...');
    MM_Operacao.Update;
    Pc_ApagaComissaoFaturamento( It_Cd_Pedido);
    Lines.Add('Apagando Impostos...');
    MM_Operacao.Update;
    NotaFiscal.Registro.Codigo := It_Cd_Nota;
    NotaFiscal.ApagarImpostos;

    Lines.Add('Apagando Observções...');
    MM_Operacao.Update;
    Pc_ApagaObservacao( It_Cd_Nota);
    Lines.Add('Apagando Nota Fiscal...');
    MM_Operacao.Update;
    Notafiscal.Registro.Codigo := It_Cd_Nota;
    Notafiscal.delete;
    MM_Operacao.Lines.Add('Apagando Informações Vendedor...');
    MM_Operacao.Update;
    Pc_ApagaVendedor( It_Cd_Nota);
    MM_Operacao.Lines.Add('Apagando outras informações...');

    Lines.Add('Atualizando Estoque...');
    MM_Operacao.Update;
    Pc_Delete_Estoque('P', It_Cd_Pedido, 0);

    Fc_ApagarRegistro('TB_PEDIDO', ['PED_CODIGO'], [IntToStr(It_Cd_Pedido)]);
    MM_Operacao.Lines.Add('Cancelamento efetuado com sucesso..');
    MM_Operacao.Update;
  end;

end;

procedure TTasGeraNfceOperacao.CancelamentoLoteNotasPendentes;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
   with MM_Operacao, Lc_Qry do
    Begin

      sql.Add('select NFL_CODIGO, NFC_CODIGO, NFL_CODPED ' +
              'from TB_NOTA_FISCAL ' + '  LEFT OUTER JOIN TB_RETORNO_NFC ' +
              '  ON (NFL_CODIGO = NFC_CODNFL) ' +
              ' WHERE (NFC_CODIGO IS NULL) AND (NFL_MODELO = ''65'') ' +
              ' AND ( NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ) ' +
              ' ORDER BY NFC_CODIGO ');
      ParamByName('DATAINI').AsString := Ed_3_Inicio.Text;
      ParamByName('DATAFIM').AsString := Ed_3_Fim.Text;
      Active := True;
      FetchAll;
      MM_Operacao.Clear;
      MM_Operacao.Update;
      Lines.Add('INICIANDO A OPERÇÃO...');
      Lines.Add('CANCELANDO NOTAS NÃO NUMERADAS...');
      While not Eof do
      Begin
        It_Cd_Nota := FieldByName('NFL_CODIGO').AsInteger;
        It_Nr_Nota := FieldByName('NFC_CODIGO').AsInteger;
        It_Cd_Pedido := FieldByName('NFL_CODPED').AsInteger;
        Lines.Add('CANCELANDO NOTA COM O CODIGO INTERNO - ' +
          IntToStr(It_Cd_Nota));
        AtivaRetorno(It_Cd_Nota);
        CancelamentoLote;
        Lines.Add(
          '---------------------------------------------------------------');
        Next;
      end;
      Lines.Add('NOTAS NÃO NUMERADAS CANCELADAS COM SUCESSO...');
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TTasGeraNfceOperacao.ConsultaChave;
Var
  Lc_Qry: TSTQuery;
  Lc_Tamanho: Integer;
  Lc_Chave: String;
  Lc_Path: String;
  Lc_FileXML: String;
  Lc_Cd_Retorno: Integer;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    FTipoOperacao := 'NFC-e';
    Pc_AtivaConfiguracaoNFe;
    Pc_FormataModeloNFCe;
    with MM_Operacao.Lines, Lc_Qry do
    Begin
      sql.Add('select retorno.* ' + 'from TB_RETORNO_NFC retorno ' +
        'Where (NFC_CODSIT < 2)' + ' ORDER BY NFC_CODIGO ');
      Active := True;
      FetchAll;
      MM_Operacao.Clear;
      Add('INICIANDO A OPERÇÃO...');
      MM_Operacao.Update;
      While not Eof do
      Begin
        if Trim(FieldByName('nfc_arquivo').AsString) <> '' then
        Begin
          Fr_Principal.Nfe.WebServices.Consulta.NFeChave :=
            Copy(FieldByName('nfc_arquivo').AsString, 1, 44);
          Fr_Principal.Nfe.WebServices.Consulta.Executar;
          Add('Nota Fiscal Consumidor: ' + FieldByName('NFC_CODIGO')
            .AsString);
          Add('Situção: ' + Fr_Principal.Nfe.WebServices.Consulta.XMotivo);
          Add('--------------------------------------------------');
        end
        else
        Begin
          Add('Nota Fiscal Consumidor: ' + FieldByName('NFC_CODIGO')
            .AsString);
          Add('Situção: Não foi encontrado chave de acesso para está nota');
          Add('--------------------------------------------------');
        end;
        MM_Operacao.Update;
        Next;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TTasGeraNfceOperacao.ConsultaLote;
Var
  Lc_Qry: TSTQuery;
  Lc_Tamanho: Integer;
  Lc_Chave: String;
  Lc_Path: String;
  Lc_FileXML: String;
  Lc_Cd_Retorno: Integer;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with MM_Operacao.Lines, Lc_Qry do
    Begin
      FTipoOperacao := 'NFC-e';
      Pc_AtivaConfiguracaoNFe;
      Pc_FormataModeloNFCe;
      sql.Add('select retorno.*, nota.NFL_CODIGO, nota.NFL_CODPED ' +
        'from TB_RETORNO_NFC retorno ' + '  INNER JOIN TB_NOTA_FISCAL nota ' +
        '  ON (NFL_CODIGO = NFC_CODNFL) ' + 'WHERE NFL_CODMHA =:NFL_CODMHA ');
      if RG_3_Tipo_Pesquisa.ItemIndex = 0 then
        sql.Add(' AND NFC_CODIGO between :INICIO and :FIM ')
      else
        sql.Add(' AND NFL_DT_EMISSAO between :INICIO and :FIM ');

      if Chbx_Pendente.Checked then
        sql.Add(' and (NFC_CODSIT < 2) ');

      sql.Add(' ORDER BY NFC_CODIGO ');
      ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
      ParamByName('INICIO').AsString := Ed_3_Inicio.Text;
      ParamByName('FIM').AsString := Ed_3_Fim.Text;
      Active := True;
      FetchAll;
      MM_Operacao.Clear;
      Add('INICIANDO A OPERÇÃO...');
      MM_Operacao.Update;
      While not Eof do
      Begin
        It_Cd_Nota := FieldByName('NFL_CODIGO').AsInteger;
        It_Nr_Nota := FieldByName('NFC_CODIGO').AsInteger;
        It_Cd_Pedido := FieldByName('NFL_CODPED').AsInteger;
        Pc_AtivaEstabelecimento();
        Pc_AtivaConfiguracaoNFe;
        Fc_AtivaDadosDaNota('C', It_Cd_Nota);
        AtivaRetorno(It_Cd_Nota);
        Pc_ConsultaNFCe;
        MM_Operacao.Lines.Add('Nota Fiscal Consumidor: ' +
          FieldByName('NFC_CODIGO').AsString);
        MM_Operacao.Lines.Add
          ('Situção: ' + Fr_Principal.Nfe.WebServices.Consulta.XMotivo);
        if (Fr_Principal.Nfe.WebServices.Consulta.cStat <> 100) or
           (Fr_Principal.Nfe.WebServices.Consulta.cStat <> 150) or
           (Fr_Principal.Nfe.WebServices.Consulta.cStat <> 110) then
        Begin
          if Chbx_pend_Numerada.Checked then
          Begin
            AtivaRetorno(It_Cd_Nota);
            CancelamentoLoteNotas;
          end;
        end;
        MM_Operacao.Lines.Add
          ('--------------------------------------------------');
        Next;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TTasGeraNfceOperacao.RG_3_Tipo_PesquisaClick(Sender: TObject);
begin
  if RG_3_Tipo_Pesquisa.ItemIndex = 0 then
  BEgin
    Lb_3_Inicio.Caption := 'Número Inicial';
    Lb_3_Fim.Caption := 'Número Final';
  end
  else
  Begin
    Lb_3_Inicio.Caption := 'Data Inicial';
    Lb_3_Fim.Caption := 'Data Final';

  end;

end;

procedure TTasGeraNfceOperacao.Sb_ConfirmarClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(self, 'I');
    self.Enabled := False;
    if Chbx_pend_Branco.Checked then
    Begin
      CancelamentoLoteNotasPendentes;
    End
    else
    Begin
      if not Chbx_Sem_Sucesso.Checked then
      Begin
        ConsultaLote;
      end
      else
      Begin
        ConsultaChave;
      end;
    End;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    self.BringToFront;
    self.Update;
  end;


end;

procedure TTasGeraNfceOperacao.Sb_operacao_sairClick(Sender: TObject);
begin
  Close;
end;

procedure TTasGeraNfceOperacao.Sb_CriarChaveAcesseClick(Sender: TObject);
Var
  Lc_Qry: TSTQuery;
  Lc_Upt: TSTQuery;
  Lc_FileXML: String;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    Lc_Upt := LcBase.GeraQuery;
    with Lc_Upt do
    Begin
      sql.Add('UPDATE TB_RETORNO_NFC SET ' +
              'NFC_ARQUIVO =:NFC_ARQUIVO ' +
              'WHERE NFC_CODNFL =:NFL_CODIGO');
    end;

    with Lc_Qry do
    Begin
      sql.Add(  'SELECT NFC_CODNFL ' +
                'FROM TB_RETORNO_NFC ' +
                '  INNER JOIN TB_NOTA_fISCAL ' +
                '  ON (NFL_CODIGO = NFC_CODNFL) ' +
                'WHERE ( (NFC_ARQUIVO = '''') OR (NFC_ARQUIVO IS NULL) ) and ( NFL_CODMHA =:NFL_CODMHA ) ');
      if RG_3_Tipo_Pesquisa.ItemIndex = 0 then
        sql.Add(' AND NFC_CODIGO between :INICIO and :FIM ')
      else
        sql.Add(' AND NFL_DT_EMISSAO between :INICIO and :FIM ');

      ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
      ParamByName('INICIO').AsString := Ed_3_Inicio.Text;
      ParamByName('FIM').AsString := Ed_3_Fim.Text;

      Active := True;
      First;
      MM_Operacao.Lines.Clear;
      while not Eof do
      Begin
        with MM_Operacao.Lines do
        Begin
          MM_Operacao.Update;
          Add('INICIANDO A OPERÇÃO - NFC-e: ' + FieldByName('NFC_CODNFL')
            .AsString);
          MM_Operacao.Update;
          It_Cd_Nota := FieldByName('NFC_CODNFL').AsInteger;
          Pc_AtivaEstabelecimento();
          Pc_AtivaConfiguracaoNFe;
          Fc_AtivaDadosDaNota('C', It_Cd_Nota);
          Add('CARREGANDO OS DADOS DO EMITENTE...');
          MM_Operacao.Update;
          Pc_CarregaDadosEmitente(True);
          Add('CARREGANDO OS DADOS DO USUÁRIO...');
          MM_Operacao.Update;
          //Pc_AtivaDadosUsuarios;
          Add('SELECIONANDO A NOTA PARA A AUTORIZÇÃO...');
          MM_Operacao.Update;
          Add('GERANDO O DANFE COM INFORMÇÕES DA NOTA...');
          MM_Operacao.Update;
          Fr_Principal.Nfe.DANFE.Protocolo := '';
          if not Pc_PreencheDadosDanfe(False) then
          Begin
            Exit;
          End;
          Add('SALVANDO O XML REFERENTE A NOTA...');
          MM_Operacao.Update;
          // Faz a gravção do XML no Banco de dados
          Fr_Principal.Nfe.NotasFiscais.Items[0].GerarXML;
          Lc_FileXML := Copy(Fr_Principal.Nfe.NotasFiscais.Items[0].Nfe.infNFe.ID,(Length(Fr_Principal.Nfe.NotasFiscais.Items[0].Nfe.infNFe.ID) - 44) +1, 44) + '-NFe.xml';
        end;
        if not Lc_Upt.Transaction.InTransaction then Lc_Upt.Transaction.StartTransaction;
        Lc_Upt.Active := False;
        Lc_Upt.ParamByName('NFC_ARQUIVO').AsString := Lc_FileXML;
        Lc_Upt.ParamByName('NFL_CODIGO').AsInteger := FieldByName('NFC_CODNFL').AsInteger;
        Lc_Upt.ExecSQL;
        if Lc_Upt.Transaction.InTransaction then Lc_Upt.Transaction.CommitRetaining;
        Next;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.FinalizaQuery(Lc_upt);
    FreeAndNil(LcBase);
  End;

end;

end.
