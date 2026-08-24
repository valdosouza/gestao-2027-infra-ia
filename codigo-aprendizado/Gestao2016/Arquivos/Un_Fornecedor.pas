unit Un_Fornecedor;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Empresa, Data.DB, STQuery, Vcl.Menus, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.StdCtrls, QEdit_Setes, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, Un_Fm_ListaColaboradores, Un_Msg, ControllerFornecedor;

type
  TFr_Fornecedor = class(TFr_Empresa)
    TabSheet2: TTabSheet;
    Pnl_Parametro: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    DBComboBox2: TDBComboBox;
    DBLCB_Transportes: TDBLookupComboBox;
    FichaFinanceira1: TMenuItem;
    MovimentaoCompras1: TMenuItem;
    ChBx_FornecedorAtivo: TCheckBox;
    Qr_Fornecedor: TSTQuery;
    procedure FichaFinanceira1Click(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    Fornecedor : TControllerFornecedor;
  protected
    procedure InitVariable;override;
    procedure Pc_PreencheSemDados; Override;
    procedure Pc_PreencheComDados;Override;
    function Fc_VerificaRegistroDuplicado():Boolean; Override;
    procedure Pc_Gravar; Override;
    procedure Pc_GravarFornecedor;
    procedure Pc_Deletar;Override;
  public
    { Public declarations }

  end;

var
  Fr_Fornecedor: TFr_Fornecedor;

implementation

{$R *.dfm}

uses     RN_Fornecedor, UN_Sistema, Un_Fich_Fin_For, Un_Regra_Negocio, RN_Permissao, UN_Principal, env, RN_Crud;
function TFr_Fornecedor.Fc_VerificaRegistroDuplicado: Boolean;
Var
  Lc_Codigo : Integer;
begin
  Result := False;
  Lc_Codigo :=  Fornecedor.VerificaSeExste(E_Codigo.Text,E_CpfCnpj.Text,True);
  if (Lc_Codigo > 0) then
  Begin
    REsult := True;
  End;
end;

procedure TFr_Fornecedor.FichaFinanceira1Click(Sender: TObject);
Var
  Lc_Form : TFr_Fich_Fin_For;
begin
  if Fc_VerificaPermissao('Fr_Fich_Fin_For','Ficha Financeira Fornecedor','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    if (Empresa.Registro.Codigo > 0) then
    Begin
      tRY
        Lc_Form := TFr_Fich_Fin_For.Create(nil);
        Lc_Form.It_Cd_Fornece := Empresa.Registro.Codigo;
        Lc_Form.It_Nm_Fornece := Empresa.Registro.NomeRazaoSocial;
        Lc_Form.ShowModal;
      finally
        FreeAndNil(Lc_Form);
      end;
    end;
  end;

end;

procedure TFr_Fornecedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Fornecedor);
  inherited;
end;

procedure TFr_Fornecedor.InitVariable;
begin
  inherited;
  Fornecedor := TControllerFornecedor.create(Self);
end;

procedure TFr_Fornecedor.Pc_Deletar;
begin
  Fornecedor.Registro.Ativo := 'N';
  Fornecedor.salva;
end;

procedure TFr_Fornecedor.Pc_Gravar;
begin
  inherited;
  Pc_GravarFornecedor;
end;

procedure TFr_Fornecedor.Pc_GravarFornecedor;
begin
  Fornecedor.Registro.Codigo := Empresa.Registro.Codigo;
  if ChBx_FornecedorAtivo.Checked then
    Fornecedor.Registro.Ativo := 'S'
  else
    Fornecedor.Registro.Ativo := 'N';
  Fornecedor.salva;
end;

procedure TFr_Fornecedor.Pc_PreencheComDados;
begin
  inherited;
  Fornecedor.Registro.Codigo := Empresa.Registro.Codigo;
  Fornecedor.getById;
  ChBx_FornecedorAtivo.Checked := ( Fornecedor.Registro.Ativo= 'S' );
end;

procedure TFr_Fornecedor.Pc_PreencheSemDados;
begin
  inherited;
  ChBx_FornecedorAtivo.Checked := True;
end;

procedure TFr_Fornecedor.SB_ExcluirClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir ' + Empresa.Registro.NomeRazaoSocial + ' de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
  begin
    Pc_Deletar;
    Close;
  end;
end;

end.
