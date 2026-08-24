unit Un_NF_SRV;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, DBCtrls, DB, Mask, STQuery, Grids, DBGrids, ExtCtrls, Buttons, ComCtrls, dbcgrids, STStoredProc, Menus, pcnLeitor, DBClient;

type
  TFr_NF_SRV = class(TForm)
    Qr_ItensNota: TSTQuery;
    Ds_ItensNota: TDataSource;
    Qr_Nota: TSTQuery;
    DS_Nota: TDataSource;
    Mnu_Operacao: TMainMenu;
    Mnu_Operacao_Tarefas: TMenuItem;
    Itm_Autorizar: TMenuItem;
    Itm_CadastroDestinatrio: TMenuItem;
    N3: TMenuItem;
    Pop_Produto: TPopupMenu;
    CadastrodoProduto: TMenuItem;
    Panel2: TPanel;
    Label1: TLabel;
    Label6: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label5: TLabel;
    E_Nota: TDBEdit;
    E_Dt_Emissao: TDBEdit;
    E_RazaoSocial: TDBEdit;
    E_Cnpj_CPf: TDBEdit;
    E_CodCli: TDBEdit;
    DBG_Produtos: TDBGrid;
    Panel3: TPanel;
    Label17: TLabel;
    Panel1: TPanel;
    Sb_Sair_0: TSpeedButton;
    Sair1: TMenuItem;
    Label2: TLabel;
    E_RPS: TDBEdit;
    Label3: TLabel;
    E_PROTOCOLO: TDBEdit;
    Label4: TLabel;
    E_COD_VERIF: TDBEdit;
    Qr_ItensNotaITF_CODIGO: TIntegerField;
    Qr_ItensNotaITF_CODPRO: TIntegerField;
    Qr_ItensNotaMED_ABREVIATURA: TStringField;
    Qr_ItensNotaPRO_CODIGOFAB: TStringField;
    Qr_ItensNotaPRO_CODIGONCM: TStringField;
    Qr_ItensNotaPRO_ORIGEM: TStringField;
    Qr_ItensNotaPRO_TIPO: TStringField;
    Qr_ItensNotaPRO_DESCRICAO: TStringField;
    Qr_ItensNotaPRO_SERIE: TStringField;
    Qr_ItensNotaITF_QTDE: TBCDField;
    Qr_ItensNotaITF_VL_UNIT: TFMTBCDField;
    Qr_ItensNotaITF_ESTOQUE: TStringField;
    Qr_ItensNotaITF_OPER: TStringField;
    Qr_ItensNotaITF_CODEST: TIntegerField;
    Qr_ItensNotaITF_SUBTOTAL: TFMTBCDField;
    Qr_ItensNotaITF_VL_TOTAL: TFMTBCDField;
    Qr_ItensNotaITF_AQ_COM: TBCDField;
    Qr_ItensNotaITF_VL_COM: TFloatField;
    Qr_ItensNotaITF_VL_DESC: TBCDField;
    Qr_ItensNotaPRO_VL_CUSTOMED: TFMTBCDField;
    Qr_ItensNotaITF_AQ_DESC: TBCDField;
    Qr_ItensNotaITF_AQ_IPI: TBCDField;
    Qr_ItensNotaITF_AQ_ICMS: TBCDField;
    Qr_ItensNotaITF_CODTPR: TIntegerField;
    Qr_ItensNotaITF_VL_CUSTO: TFMTBCDField;
    Qr_ItensNotaITF_IMP_APROX: TBCDField;
    E_VL_Total: TEdit;
    AnexarXML1: TMenuItem;
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Itm_CadastroDestinatrioClick(Sender: TObject);
    procedure CadastrodoProdutoClick(Sender: TObject);
    procedure Itm_AutorizarClick(Sender: TObject);
    procedure AnexarXML1Click(Sender: TObject);
  private
    { Private declarations }
     It_Supervisor : Boolean;
  public
    It_Tipo_Nota : String;
    It_Oper_Reg : String;
    It_Cd_Nota : Integer;
    It_Nr_Nota : String;
    It_cd_Pedido : Integer;
    It_Nfe_Cancelada : Boolean;
    IT_Cd_Empresa : Integer;
    //controle de menu;
    procedure Pc_AtivarTabelas;
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;
    procedure Pc_SomaItens;
  end;

var
  Fr_NF_SRV: TFr_NF_SRV;

implementation

uses
Un_DM, UN_MSG, UN_Sistema, Un_Fc_Sored_Procedures, un_Obs_nfe, Un_Funcoes, Un_Imp_Mod_Impressao, Un_Regra_Negocio, RN_Permissao, UN_Principal, env, RN_Cliente, RN_Empresa, reg_service, RN_NotaFiscalServico, RN_NotaFiscalEletronica3X;

{$R *.dfm}



procedure TFr_NF_SRV.Pc_FormataTela;
Begin

end;

procedure TFr_NF_SRV.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;


procedure TFr_NF_SRV.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_Escape : if  Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_NF_SRV.Pc_AtivarTabelas;
begin

end;


procedure TFr_NF_SRV.Pc_IniciaVariaveis;
Begin
  if It_Cd_Nota > 0 then
  Begin
    Qr_Nota.Active := False;
    Qr_Nota.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
    Qr_Nota.Active := True;

    Qr_ItensNota.Active := False;
    Qr_ItensNota.ParamByName('NFL_CODIGO').AsInteger := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
    Qr_ItensNota.Active := True;
    Pc_SomaItens;
  end;
end;

procedure TFr_NF_SRV.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_ImagemBotao;
  Pc_IniciaVariaveis;
end;

procedure TFr_NF_SRV.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;



procedure TFr_NF_SRV.Itm_CadastroDestinatrioClick(Sender: TObject);
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Cadastro do Destinatário','CADASTRO DESTINATARIO',GB_Cd_Usuario,'S') then
  Begin
    Fc_AbreTelaEmpresa(Qr_Nota.FieldByName('EMP_CODIGO').AsInteger );
  end;
end;

procedure TFr_NF_SRV.Pc_PermissaoBotao(Pc_Menu: string);
begin

end;

procedure TFr_NF_SRV.Pc_SomaItens;
Var
  Lc_Valor : Real;
begin
  with Qr_ItensNota do
  Begin
    First;
    Lc_Valor := 0;
    while not eof do
    Begin
      Lc_Valor := Lc_Valor + FieldByName('ITF_VL_TOTAL').AsCurrency;
      Next;
    End;
    E_VL_Total.Text := FloatToStrF(Lc_Valor,ffNumber,10,2);
  end;
end;

procedure TFr_NF_SRV.AnexarXML1Click(Sender: TObject);
Var
  Lc_Tipo : Integer;
  Lc_Dialogo : TOpenDialog;
  Lc_Path : String;
  Lc_File : String;
  Lc_I: Integer;
  Lc_Result : Boolean;
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja anexar um XML a este registro? ' + EOLN +
                     '     Confirmar a atualização ?'+EOLN ,
                     [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
  begin
    Lc_Dialogo := TOpenDialog.Create(self);
    // Allow only .dpr and .pas files to be selected
    Lc_Dialogo.Filter := 'Arquivos XML - NF-|*.xml';
    Lc_Dialogo.FilterIndex := 1;
    if Lc_Dialogo.execute then
    Begin
      Lc_File := Lc_Dialogo.FileName;
      Lc_Path := '';
      for Lc_I := Length(Lc_File) downto 1 do
      Begin
        if (Lc_File[Lc_I] = '\') and (Lc_Path = '') then Lc_Path := IntToStr(Lc_I);
      end;
      Lc_PAth := copy(Lc_File,1,StrToIntDef(Lc_Path,0));
      Lc_File := Copy(Lc_File,Length(Lc_Path)+1,( ( Length(Lc_File) - Length(Lc_Path) )));
      with Qr_Nota do
      Begin
        Lc_Result := Fc_AnexarXmlNFe(Lc_Tipo,FieldByname('NFL_CODIGO').AsInteger,Lc_Path,Lc_File);
        if Lc_Result then
        Begin
          MensagemPadrao(MENSAGEM,'S U C E S S O !.'+EOLN+EOLN+
                         'Arquivo Anexado com sucesso.'+EOLN,
                          ['OK'],[bEscape],mpInformacao);
        End
        else
        Begin
          MensagemPadrao(MENSAGEM,'S U C E S S O !.'+EOLN+EOLN+
                         ' O arquivo não foi anexado.'+EOLN+
                         'Verifique e tente novamente.'+ EOLN,
                         ['OK'],[bEscape],mpInformacao);
        End;
      End;
    End;
    FreeAndNil(Lc_Dialogo);
  end;

end;

procedure TFr_NF_SRV.CadastrodoProdutoClick(Sender: TObject);
Var
  Lc_Form : TRegService;
begin
  if Fc_VerificaPermissao('Fr_Produtos','Cadastro de Produtos','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Lc_Form := TREgService.Create(Self);
    Try
      Lc_Form.codigoRegistro := Qr_ItensNota.FieldByName('ITF_CODPRO').AsInteger;
      Lc_Form.ShowModal;
    Finally
      Qr_ItensNota.Active := False;
      Qr_ItensNota.Active := true;
      FreeAndNil(Lc_Form) ;
    End;
  end;
end;

procedure TFr_NF_SRV.Itm_AutorizarClick(Sender: TObject);
begin
  Fc_ChamarGeraNFSE('NFS-e',
                     Qr_Nota.FieldByName('NFL_CODIGO').AsInteger);
  Pc_IniciaVariaveis;                  
end;

end.
