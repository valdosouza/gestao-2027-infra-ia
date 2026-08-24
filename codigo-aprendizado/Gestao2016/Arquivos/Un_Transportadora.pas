unit Un_Transportadora;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Empresa, Data.DB, STQuery, Vcl.Menus, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.StdCtrls, QEdit_Setes, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, Un_Fm_ListaColaboradores, ControllerTransportadora;

type
  TFr_Transportadora = class(TFr_Empresa)
    TabSheet2: TTabSheet;
    Pnl_Frete: TPanel;
    Sb_Exc_Frete: TSpeedButton;
    Sb_Alt_Frete: TSpeedButton;
    Sb_Ins_Frete: TSpeedButton;
    DBGrid1: TDBGrid;
    Qr_Frete: TSTQuery;
    Ds_Frete: TDataSource;
    FichaFinanceira1: TMenuItem;
    ChBx_TransportadoraAtiva: TCheckBox;
    Qr_Transportadora: TSTQuery;
    procedure Sb_Ins_FreteClick(Sender: TObject);
    procedure Sb_Alt_FreteClick(Sender: TObject);
    procedure Sb_Exc_FreteClick(Sender: TObject);
    procedure FichaFinanceira1Click(Sender: TObject);

    procedure Ds_EmpresaStateChange(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Transportadora : TControllerTransportadora;
    procedure OpenFrete(Frete,Transportadora:Integer);
  protected
    function Fc_VerificaRegistroDuplicado: Boolean; Override;
    procedure InitVariable;override;
    procedure Pc_PreencheSemDados; Override;
    procedure Pc_PreencheComDados;Override;

    procedure Pc_GravarTransportadora;
    procedure Pc_Gravar;Override;
    procedure Pc_ImagemBotao;Override;
    procedure Pc_AbreDadosFrete;

  public
    { Public declarations }
  end;

var
  Fr_Transportadora: TFr_Transportadora;

implementation

{$R *.dfm}

uses     Un_Frete, UN_Sistema, RN_Transportadora, Un_Msg, UN_Principal, env, RN_Permissao, Un_Fich_Fin_For, Un_Regra_Negocio;
procedure TFr_Transportadora.Ds_EmpresaStateChange(Sender: TObject);
begin
  inherited;
  //BOTOES FRETE
  Sb_Ins_Frete.Enabled := ((EditionState = 'I' ) or ( EditionState = 'E' )) ;
  Sb_Alt_Frete.Enabled := ( ((EditionState = 'I' ) or ( EditionState = 'E' )) and ( Empresa.Registro.Codigo >0 ) and (Qr_Frete.RecordCount>0));
  Sb_Exc_Frete.Enabled := ( ((EditionState = 'I' ) or ( EditionState = 'E' )) and ( Empresa.Registro.Codigo >0 ) and (Qr_Frete.RecordCount>0));

end;

function TFr_Transportadora.Fc_VerificaRegistroDuplicado: Boolean;
Var
  Lc_Codigo : Integer;
begin
  Result := False;
  Lc_Codigo := Fc_TransportadoraExiste(E_Codigo.Text,E_CpfCnpj.Text,True);
  if (Lc_Codigo > 0) then
  Begin
    REsult := True;
  End;
end;

procedure TFr_Transportadora.Pc_ImagemBotao;
begin
  inherited;
  with fr_principal do
  Begin
    //BOTOES FRETES
    Sb_Ins_Frete.Glyph.Assign(Fc_CarregaImagemBotao('INSERIR'));
    Sb_Alt_Frete.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    Sb_Exc_Frete.Glyph.Assign(Fc_CarregaImagemBotao('EXCLUIR'));
  END;
end;

procedure TFr_Transportadora.Pc_PreencheComDados;
begin
  inherited;
  Transportadora.Registro.Codigo := Empresa.Registro.Codigo;
  Transportadora.getById;
  ChBx_TransportadoraAtiva.Checked := ( Transportadora.Registro.Ativo = 'S' );
end;

procedure TFr_Transportadora.Pc_PreencheSemDados;
begin
  inherited;
  ChBx_TransportadoraAtiva.Checked := True;
end;

procedure TFr_Transportadora.FichaFinanceira1Click(Sender: TObject);
Var
  Lc_Form : TFr_Fich_Fin_For;
begin
  if Fc_VerificaPermissao('Fr_Fich_Fin_For','Ficha Financeira Fornecedor','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    if Empresa.Registro.Codigo > 0 then
    Begin
      Try
        Lc_Form := TFr_Fich_Fin_For.Create(nil);
        Lc_Form.It_Cd_Fornece := Empresa.Registro.Codigo;
        Lc_Form.It_Nm_Fornece := Empresa.Registro.NomeRazaoSocial;
        Lc_Form.ShowModal;
      Finally
        FreeAndNil(Lc_Form);
      End;

    end;
  end;

end;

procedure TFr_Transportadora.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Transportadora);
  inherited;
end;

procedure TFr_Transportadora.InitVariable;
begin
  inherited;
  Transportadora := TControllerTransportadora.create(Self);
end;

procedure TFr_Transportadora.OpenFrete(Frete, Transportadora: Integer);
Var
  Lc_Form : TFr_Frete;
begin
  if (Empresa.Registro.Codigo = 0) then
  begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Para registrar um Frete,' + EOLN +
                   '   Registre uma Transportadora.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    exit;
  end;
  Lc_Form := TFr_Frete.create(self);
  Lc_Form.CodigoRegistro := Frete;
  Lc_Form.It_Cd_Transportadora := Transportadora;
  Try
    Fr_Frete.ShowModal;
  Finally
    Pc_AbreDadosFrete;
    FreeandNil(Lc_form);
    Ds_EmpresaStateChange(Self);
  End;
end;

procedure TFr_Transportadora.Pc_AbreDadosFrete;
begin
  with Qr_Frete do
  Begin
    Active:=false;
    ParamByName('EMP_CODIGO').AsInteger := Empresa.Registro.Codigo;
    Active:=True;
  End;
end;

procedure TFr_Transportadora.Pc_Gravar;
Var
  Lc_Ativo : String;
begin
  inherited;
  Pc_GravarTransportadora;
end;

procedure TFr_Transportadora.Pc_GravarTransportadora;
begin
  Transportadora.Registro.codigo := Empresa.Registro.Codigo;
  if ChBx_TransportadoraAtiva.Checked then
    Transportadora.Registro.Ativo := 'S'
  else
    Transportadora.Registro.Ativo := 'N';
  Transportadora.salva;

end;

procedure TFr_Transportadora.Sb_Alt_FreteClick(Sender: TObject);
begin
  OpenFrete(Qr_Frete.FieldByName('FRT_CODIGO').AsInteger,Empresa.Registro.Codigo);
end;

procedure TFr_Transportadora.Sb_Exc_FreteClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir ' + Qr_Frete.FieldByName('FRT_DESCRICAO').AsString + ' de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clRed) = mrBotao1) then
  begin
    try
      Pc_ApagaFrete(Qr_Frete.FieldByName('FRT_CODIGO').AsInteger);
      Pc_AbreDadosFrete;
      Ds_EmpresaStateChange(Self);
    except
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Um erro impossibilitou a exclusão dos dados.' + EOLN +
                     'Entre em contato com o suporte técnico.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
  end;
end;

procedure TFr_Transportadora.Sb_Ins_FreteClick(Sender: TObject);
Begin
  OpenFrete(Qr_Frete.FieldByName('FRT_CODIGO').AsInteger,Empresa.Registro.Codigo);
end;

procedure TFr_Transportadora.TabSheet2Show(Sender: TObject);
begin
  With qr_Frete do
  BEgin
    active := False;
    ParamByName('EMP_CODIGO').AsInteger := Empresa.Registro.Codigo;
    active := True;
  End;
  Ds_EmpresaStateChange(Sender);
end;

end.
