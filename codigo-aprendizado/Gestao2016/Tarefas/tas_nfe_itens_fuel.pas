unit tas_nfe_itens_fuel;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.ExtCtrls, Vcl.Menus, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons, ControllerNfeItemsFuel;

type
  TTasNfeItensFuel = class(TFr_Base)
    Pnl_Fundo: TPanel;
    E_CodANP: TEdit;
    Label1: TLabel;
    E_Description: TEdit;
    Label2: TLabel;
    DBLCB_UF: TDBLookupComboBox;
    Label3: TLabel;
    pnl_botao: TPanel;
    SB_Cancelar: TSpeedButton;
    SB_Gravar: TSpeedButton;
    E_Qtde: TEdit;
    Label4: TLabel;
    SB_Excluir: TSpeedButton;
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
  private
    function ValidateSave:Boolean;
    procedure Save;
  protected
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
    procedure AtivaTabelas;Override;
  public
    { Public declarations }
    NfeFuel : TControllerNfeItemsFuel;
  end;

var
  TasNfeItensFuel: TTasNfeItensFuel;

implementation

{$R *.dfm}

uses     Un_DM, Un_Msg, UN_Principal, env;

{ TFr_Base1 }

procedure TTasNfeItensFuel.AtivaTabelas;
begin
  inherited;
  DM.Qr_UF.Active := True;
end;

procedure TTasNfeItensFuel.CriarVariaveis;
begin
  inherited;
  NfeFuel := TControllerNfeItemsFuel.Create(self);
end;

procedure TTasNfeItensFuel.FormataTela;
begin
  inherited;

end;

procedure TTasNfeItensFuel.ImagemBotao;
begin
  CarregaImagemBotao(SB_Excluir,'EXCLUIR');
  CarregaImagemBotao(SB_Gravar,'GRAVAR');
  CarregaImagemBotao(SB_Cancelar,'CANCELAR');
end;

procedure TTasNfeItensFuel.IniciaVariaveis;
begin
  inherited;
  NfeFuel.Registro.ItemNota := CodigoRegistro;
  NfeFuel.getByKey;
  if NfeFuel.exist then
  Begin
    E_CodANP.Text := NfeFuel.Registro.Codif;
    E_Description.Text := NfeFuel.Registro.Descricao;
    E_Qtde.Text := FloatToStrF( NfeFuel.Registro.QuantTemp,ffFixed,10,2);
    DBLCB_UF.KeyValue := NfeFuel.Registro.UFCONS;

  End
  else
  Begin
    E_CodANP.clear;
    E_Description.clear;
    E_Qtde.Clear;
    DBLCB_UF.KeyValue := null;
  End;
end;

procedure TTasNfeItensFuel.Save;
begin
  NfeFuel.Registro.Codif := E_CodANP.Text;
  NfeFuel.Registro.Descricao := E_Description.Text ;
  NfeFuel.Registro.QuantTemp := StrToFloatDef(E_Qtde.Text,0);
  NfeFuel.Registro.UFCONS := DBLCB_UF.Text;
  NfeFuel.save;
end;

procedure TTasNfeItensFuel.SB_CancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TTasNfeItensFuel.SB_ExcluirClick(Sender: TObject);
Begin
  If (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja realmente excluir este item.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                     [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    NfeFuel.delete;
    Close;
  End;
end;

procedure TTasNfeItensFuel.SB_GravarClick(Sender: TObject);
begin
  if ValidateSave then
  Begin
    Save;
    Close;
  End;
end;

function TTasNfeItensFuel.ValidateSave: Boolean;
begin
  Result := True;
  If E_CodANP.Text = '' then
  begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Por favor informe o campo ANP' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;

  If E_Description.Text = '' then
  begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Por favor informe a descrição do combustível' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;

  If ( StrToFloatDef(E_Qtde.text,0) = 0 )  then
  begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Por favor informe a quantidade do combustível' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;

  If ( DBLCB_UF.Text = '' )  then
  begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Por favor informe a U.F. consumidora' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;
end;

end.
