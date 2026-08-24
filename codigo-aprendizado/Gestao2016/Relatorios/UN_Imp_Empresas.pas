unit UN_Imp_Empresas;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, StdCtrls, ExtCtrls, Mask, Buttons, DB, STQuery, ComCtrls, Gauges, System.Math;

type
   TFr_Imp_Empresa = class(TForm)
    Panel1: TPanel;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Panel2: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    DBLCB_Vendedor: TDBLookupComboBox;
    DBLCB_Bairro: TDBLookupComboBox;
    DBLCB_CIDADE: TDBLookupComboBox;
    Cb_Empresa: TComboBox;
    Rg_Localidade: TRadioGroup;
    Cb_Tipo: TComboBox;
    Qr_Bairro: TSTQuery;
    Ds_Bairro: TDataSource;
    Qr_Cidade: TSTQuery;
    Ds_Cidade: TDataSource;
    Label3: TLabel;
    DBLCB_Empresa: TDBLookupComboBox;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    E_BuscaCodigo: TMaskEdit;
    Label9: TLabel;
    Dblcb_RamoAtividade: TDBLookupComboBox;
    Chbx_UltimaCompra: TCheckBox;
    ChBx_email: TCheckBox;
    Pnl_Progresso: TPanel;
    Gg_Progresso: TGauge;
    Lb_Processamento: TLabel;
    rg_Movimentacao: TRadioGroup;
    E_Data_Fim: TDateTimePicker;
    E_Data_Ini: TDateTimePicker;
    Label4: TLabel;
    Label2: TLabel;
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure SB_ImprimirClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure FormCreate(Sender: TObject);
      procedure DBLCB_VendedorKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure Cb_EmpresaExit(Sender: TObject);
      procedure DBLCB_BairroKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure DBLCB_CIDADEKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure Sb_ExportarClick(Sender: TObject);
      procedure Qr_CidadeAfterOpen(DataSet: TDataSet);
      procedure Qr_BairroAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure Cb_TipoChange(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure E_BuscaCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure rg_MovimentacaoClick(Sender: TObject);
    procedure Chbx_UltimaCompraClick(Sender: TObject);
   private
    { Private declarations }
   public
    { Public declarations }
      It_Imprimir: Boolean;
      It_Exportar: Boolean;
      It_Visualizar: Boolean;
      procedure Pc_AtivarTabelas;
      Procedure MontaListaCidades;
      Procedure MontaListaBairros;
      procedure Pc_PermissaoBotao(Pc_Menu: string);
      procedure Pc_MontaTipoRelatorio;
      procedure Pc_HabilitarBot(Habilitar:Boolean);
      procedure Pc_ImagemBotao;
   end;

var
   Fr_Imp_Empresa: TFr_Imp_Empresa;

implementation

uses     Un_DM, UN_RL_Cadastro_Empresa, Un_Excel, UN_Sistema, UN_RL_Listagem_Empresa, UN_Principal, env, un_Rl_promocao_cupom, UN_MSG, Un_Regra_Negocio, RN_Empresa, UN_TabelasEmListas;
{$R *.dfm}

procedure TFr_Imp_Empresa.Pc_AtivarTabelas;
Var
  Lc_Order:String;

begin
  if ChBx_Nome.Checked then Lc_Order := 'EMP_NOME' ELSE Lc_Order := 'EMP_FANTASIA';

  case Cb_Empresa.ItemIndex of
    0:Begin
        DBLCB_Empresa.ListSource := DM_ListaConsultas.Ds_ListaEstabelecimento;
        DM_ListaConsultas.Pc_ListaEstabelecimentos(Lc_Order);
      End;
    1:begin
        DBLCB_Empresa.ListSource := DM_ListaConsultas.Ds_ListaCliente;
        DM_ListaConsultas.Pc_ListaClientes(Lc_Order);
      end;
    2:Begin
        DBLCB_Empresa.ListSource := DM_ListaConsultas.Ds_ListaFornecedor;
        DM_ListaConsultas.Pc_ListaFornecedores(Lc_Order);
      End;
    3:Begin
        DBLCB_Empresa.ListSource := DM_ListaConsultas.Ds_ListaTransportadora;
        DM_ListaConsultas.Pc_ListaTranportadoras(Lc_Order);
      End;
  end;

  MontaListaCidades;

  MontaListaBairros;

  DM_ListaConsultas.Pc_ListaVendedor;
  DM_ListaConsultas.Pc_ListaRamoAtividade;
end;

procedure TFr_Imp_Empresa.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;


procedure TFr_Imp_Empresa.SB_ImprimirClick(Sender: TObject);
Var
   LcListEmp : TRL_Listagem_Empresa;
   LcCadEmp : TRL_Cadatro_Empresa;
   LCProCup :  TRL_Promo_Cupom;
   UsaPeriodo : Boolean;
begin
  Try
    UsaPeriodo := (rg_Movimentacao.ItemIndex < 2) ;
    Pnl_Progresso.Visible := True;
    if (Chbx_UltimaCompra.Checked) or ( rg_Movimentacao.ItemIndex = 1)  then
      Pc_AtualizaUltimaMovimentacao(UsaPeriodo,E_Data_Ini.Date,E_Data_Fim.Date, Gg_Progresso);
    Pnl_Progresso.Visible := False;

    Self.Enabled := False;
    Cb_Empresa.setFocus;
    Pc_LimpaQrPreviweMemoria;
    case Cb_Tipo.ItemIndex of
      0:begin
        try
          LcListEmp := TRL_Listagem_Empresa.create(nil);
          LcListEmp.It_Dt_Ultima_Compra := Chbx_UltimaCompra.Checked;
          LcListEmp.Qrpt.Preview;
        finally
          LcListEmp.Close;
          FreeAndNil(LcListEmp);
        end;
        end;
      1:begin
        try
          LcCadEmp := TRL_Cadatro_Empresa.create(nil);
          LcCadEmp.It_Dt_Ultima_Compra := Chbx_UltimaCompra.Checked;
          LcCadEmp.Qrpt.Preview;
        finally
          LcCadEmp.Close;
          FreeAndNil(LcCadEmp);
        end;
        end;
      2:begin
          if (Trim(DBLCB_Empresa.Text) <> '') then
          Begin
            Try
              LCProCup :=  TRL_Promo_Cupom.create(nil);
              LCProCup.Qrpt.Preview;
            finally
              LCProCup.Close;
              FreeAndNil(LCProCup);
            end;
          end
          else
          Begin
            MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                           'por favor escolha uma empresa.' + EOLN ,
                           ['OK'], [bEscape], mpAlerta);
          end;
        end;
     end;
  finally
    Self.enabled := True;
    BringToFront;
  end;
end;

procedure TFr_Imp_Empresa.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   if shift = [] then
   begin
      case Key of
         VK_F2: if Sb_Exportar.Enabled then  Sb_ExportarClick(Sender);
         VK_F3: if SB_Imprimir.Enabled then  SB_ImprimirClick(Sender);
         VK_Escape: if SB_Sair_0.Enabled then  SB_Sair_0Click(Sender);
      end;
   end;
end;

procedure TFr_Imp_Empresa.FormCreate(Sender: TObject);
begin
   E_Data_INI.Date := Date;
   E_Data_FIM.Date := Date;
   Cb_Empresa.ItemIndex := 1;
   Pc_AtivarTabelas;
end;

procedure TFr_Imp_Empresa.DBLCB_VendedorKeyDown(Sender: TObject;
   var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete:
    begin
      DBLCB_Vendedor.KeyValue := Null;
    end;
  end;
end;

procedure TFr_Imp_Empresa.Cb_EmpresaExit(Sender: TObject);
begin
  Pc_MontaTipoRelatorio;
  Pc_AtivarTabelas;
end;

procedure TFr_Imp_Empresa.DBLCB_BairroKeyDown(Sender: TObject;
   var Key: Word; Shift: TShiftState);
begin
   if Shift = [] then
      case Key of
         VK_delete:
            begin
               DBLCB_Bairro.KeyValue := Null;
            end;
      end;
end;

procedure TFr_Imp_Empresa.DBLCB_CIDADEKeyDown(Sender: TObject;
   var Key: Word; Shift: TShiftState);
begin
   if Shift = [] then
      case Key of
         VK_delete:
            begin
               DBLCB_CIDADE.KeyValue := Null;
            end;
      end;
end;

procedure TFr_Imp_Empresa.DBLCB_EmpresaKeyDown(Sender: TObject;
   var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
      begin
        DBLCB_Empresa.KeyValue := Null;
        E_BuscaCodigo.Clear;
      end;
    end;
end;

procedure TFr_Imp_Empresa.Sb_ExportarClick(Sender: TObject);
var
   Lc_CAminho: string;
   LcListEmp : TRL_Listagem_Empresa;
   LcCadEmp : TRL_Cadatro_Empresa;
   UsaPeriodo : Boolean;
begin
  if Fr_Principal.SaveDialogo.Execute then
  Begin
    UsaPeriodo := (rg_Movimentacao.ItemIndex < 2);
    Pnl_Progresso.Visible := True;
    Pc_AtualizaUltimaMovimentacao(UsaPeriodo, E_Data_Ini.Date,E_Data_Fim.Date, Gg_Progresso);
    Pnl_Progresso.Visible := False;

    if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
    Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
    Lc_CAminho := Fr_Principal.SaveDialogo.FileName;

    case Cb_Tipo.ItemIndex of
      0:Begin
          Try
            LcListEmp := TRL_Listagem_Empresa.Create(nil);
            LcListEmp.It_Dt_Ultima_Compra := Chbx_UltimaCompra.Checked;
            LcListEmp.Pc_Busca;
            Fr_Excel.Pc_Excel(LcListEmp.Qr_listagem, Lc_CAminho);
          finally
            FreeAndNil(LcListEmp);
          end;
        end;
      1:Begin
          try
            LcCadEmp := TRL_Cadatro_Empresa.Create(nil);
            LcCadEmp.It_Dt_Ultima_Compra := Chbx_UltimaCompra.Checked;
            LcCadEmp.Pc_Busca;
            Fr_Excel.Pc_Excel(LcCadEmp.Qr_Listagem, Lc_CAminho);
          finally
            FreeAndNil(LcCadEmp);
          end;
        end;
    end;
  end;
end;

procedure TFr_Imp_Empresa.Qr_CidadeAfterOpen(DataSet: TDataSet);
begin
   Qr_Cidade.FetchAll;
end;

procedure TFr_Imp_Empresa.rg_MovimentacaoClick(Sender: TObject);
begin
  Chbx_UltimaCompra.Checked := TRadioGroup(Sender).ItemIndex = 0
end;

procedure TFr_Imp_Empresa.Qr_BairroAfterOpen(DataSet: TDataSet);
begin
   Qr_Bairro.FetchAll;
end;

procedure TFr_Imp_Empresa.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Imprimir := True;
    It_Exportar:= True;    
    end
  else
    begin
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    if not It_Visualizar then exit;
    It_Imprimir := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    It_Exportar := Fc_HabilitaPermissao(Pc_Menu,'EXPORTAR','S');    
    end;
   SB_Imprimir.Enabled:= It_Imprimir;
   Sb_Exportar.Enabled:= It_Exportar;
end;

procedure TFr_Imp_Empresa.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_PermissaoBotao('Empresas');
  Pc_MontaTipoRelatorio;
  Pc_ImagemBotao;
end;

procedure TFr_Imp_Empresa.MontaListaBairros;
begin
  with Qr_Bairro do
  Begin
    Active := False;
    sql.Clear;
    sql.Add(concat(
              'SELECT DISTINCT END_BAIRRO ',
              'FROM TB_EMPRESA ',
              '   INNER JOIN TB_ENDERECO ',
              '   ON (TB_ENDERECO.END_CODEMP = TB_EMPRESA.EMP_CODIGO) '
    ));
    case Cb_Empresa.ItemIndex of
      0:Begin
          sql.Add('WHERE ( EMP_TIPO=0 ) ');
        End;
      1:begin
          sql.Add(concat(
                  'INNER JOIN TB_CLIENTE ',
                  ' ON (CLI_CODEMP = EMP_CODIGO)',
                  'WHERE CLI_ATIVO = ''S''   '
          ));
        end;
      2:Begin
          sql.Add(concat(
                  'INNER JOIN TB_FORNECEDOR ',
                  ' ON (FOR_CODEMP = EMP_CODIGO)',
                  'WHERE FOR_ATIVO = ''S''   '
          ));
        End;
      3:Begin
          sql.Add(concat(
                  'INNER JOIN TB_TRANSPORTADORA ',
                  ' ON (TRP_CODEMP = EMP_CODIGO)',
                  'WHERE TRP_ATIVO = ''S''   '
          ));
        End;
    end;
    sql.Add('ORDER BY END_BAIRRO ');
    Active := True;
    FetchAll;
  End;
end;

procedure TFr_Imp_Empresa.MontaListaCidades;
begin
  with Qr_Cidade do
  Begin
    Active := False;
    sql.Clear;
    sql.Add(concat(
              'SELECT DISTINCT CDD_DESCRICAO ',
              'FROM TB_EMPRESA ',
              '   INNER JOIN TB_ENDERECO ',
              '   ON (TB_ENDERECO.END_CODEMP = TB_EMPRESA.EMP_CODIGO) ',
              '   INNER JOIN TB_CIDADE ',
              '   ON (TB_CIDADE.CDD_CODIGO = TB_ENDERECO.END_CODCDD) '
    ));
    case Cb_Empresa.ItemIndex of
      0:Begin
          sql.Add('WHERE (EMP_TIPO=0) ');
        End;
      1:begin
          sql.Add(concat(
                  'INNER JOIN TB_CLIENTE ',
                  ' ON (CLI_CODEMP = EMP_CODIGO)',
                  'WHERE CLI_ATIVO = ''S''   '
          ));
        end;
      2:Begin
          sql.Add(concat(
                  'INNER JOIN TB_FORNECEDOR ',
                  ' ON (FOR_CODEMP = EMP_CODIGO)',
                  'WHERE FOR_ATIVO = ''S''   '
          ));
        End;
      3:Begin
          sql.Add(concat(
                  'INNER JOIN TB_TRANSPORTADORA ',
                  ' ON (TRP_CODEMP = EMP_CODIGO)',
                  'WHERE TRP_ATIVO = ''S''   '
          ));
        End;
    end;
    sql.Add('ORDER BY CDD_DESCRICAO');
    Active := True;
    FetchAll;
  End;
end;

procedure TFr_Imp_Empresa.Pc_MontaTipoRelatorio;
var
lc_opcao:Integer;
begin
  Cb_Tipo.Clear;
  lc_opcao:=2;
  if Cb_Empresa.Text = 'Fornecedores' then lc_opcao:=3;
    Cb_Tipo.Items.Add('Listagem');
    Cb_Tipo.Items.Add('Cadastro');
    if lc_opcao = 3 then
    Cb_Tipo.Items.Add('Promoção');
  Cb_Tipo.ItemIndex:=0;
end;

procedure TFr_Imp_Empresa.Pc_HabilitarBot(Habilitar: Boolean);
begin
  DBLCB_CIDADE.Enabled:= Habilitar;
  DBLCB_Bairro.Enabled:= Habilitar;
  DBLCB_Vendedor.Enabled:= Habilitar;
  Rg_Localidade.Enabled:= Habilitar;

end;

procedure TFr_Imp_Empresa.Cb_TipoChange(Sender: TObject);
begin
  IF  Cb_Tipo.Text = 'Promoção' THEN
   Pc_HabilitarBot(false)
  else
   Pc_HabilitarBot(true);  
end;

procedure TFr_Imp_Empresa.ChBx_NomeClick(Sender: TObject);
begin
  Pc_ListaEmpresaDbLookUpComboBox(-1,'EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa)
end;

procedure TFr_Imp_Empresa.Chbx_UltimaCompraClick(Sender: TObject);
begin
  if ( TCheckBox(sender).Checked ) then
  Begin
    if rg_Movimentacao.ItemIndex = 1 then
      TCheckBox(sender).Checked := False;
  End
  else
  Begin
    if rg_Movimentacao.ItemIndex = 0 then
      TCheckBox(sender).Checked := true;
  End;
end;

procedure TFr_Imp_Empresa.ChBx_FantasiaClick(Sender: TObject);
begin
  Pc_ListaEmpresaDbLookUpComboBox(-1,'EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
end;

procedure TFr_Imp_Empresa.E_BuscaCodigoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  DBLCB_Empresa.KeyValue := StrToIntDef(E_BuscaCodigo.Text,0);
end;

procedure TFr_Imp_Empresa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Imp_Empresa.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    Sb_Exportar.Glyph := (Fc_CarregaImagemBotao('EXPORTAR'));
    SB_Imprimir.Glyph := (Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
    END;
end;
end.

