unit Un_Ret_Producao;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, DBCtrls, Buttons, ExtCtrls, DB, STQuery;

type
  TEdit = class(StdCtrls.TEdit)
  private
    { Private declarations }
    FAlignment: TAlignment;
    procedure SetAlignment(Value: TAlignment);

  protected
    { Protected declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property Alignment: TAlignment read FAlignment write SetAlignment
    default taLeftJustify;
  end;
  
  TFr_Ret_Producao = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label19: TLabel;
    Label1: TLabel;
    Label14: TLabel;
    Label5: TLabel;
    SB_Gravar: TBitBtn;
    SB_Cancelar: TBitBtn;
    E_Data_Entrega: TDateTimePicker;
    E_Servico: TEdit;
    E_Qt_Entregue: TEdit;
    E_Romaneio: TEdit;
    E_Fornecedor: TEdit;
    Label3: TLabel;
    E_Qt_Produto: TEdit;
    Qr_Pesquisa: TSTQuery;
    Qr_PesquisaPRD_CODIGO: TIntegerField;
    Qr_PesquisaPRD_ROMANEIO: TStringField;
    Qr_PesquisaEMP_NOME: TStringField;
    Qr_PesquisaPRO_DESCRICAO: TStringField;
    Qr_PesquisaPRD_QTDE: TBCDField;
    Qr_PesquisaPRD_PRZ_ENTREGA: TDateField;
    Qr_PesquisaRPD_QTDE: TBCDField;
    Qr_PesquisaPRD_CODPED: TIntegerField;
    Qr_PesquisaRPD_CODIGO: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure E_RomaneioExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Qr_PesquisaAfterOpen(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    It_StateChange : String;
    It_Cd_Producao : Integer;
    It_cd_Pedido : Integer;
    It_Cd_Item : Integer;
    It_Inserir : boolean;
    procedure Pc_LimpaCampos;
    procedure Pc_MostraBusca(Pc_romaneio : String);
  end;

var
  Fr_Ret_Producao: TFr_Ret_Producao;

implementation

uses     UN_Sistema, UN_MSG;
constructor TEdit.Create(AOwner: TComponent);
begin
  FAlignment := taLeftJustify;
  inherited Create(AOwner);
end;

procedure TEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array [TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'EDIT');
  Params.Style := Params.Style and
    not (ES_AUTOVSCROLL or ES_AUTOHSCROLL) or ES_MULTILINE or
      Alignments[FAlignment];
end;
{$R *.dfm}

procedure TFr_Ret_Producao.Pc_LimpaCampos;
begin
  E_Romaneio.Clear;
  E_Data_Entrega.Date := Date;
  E_Qt_Entregue.Text := '0';
  E_Fornecedor.Clear;
  E_Servico.Clear;
  E_Qt_Produto.Clear;
end;

procedure TFr_Ret_Producao.Pc_MostraBusca;
begin
  if Length(Pc_romaneio) = 0 then exit;
  Qr_Pesquisa.Close;
  Qr_Pesquisa.ParamByName('PRD_ROMANEIO').AsString := Pc_romaneio;
  Qr_Pesquisa.Active := True;
  Qr_Pesquisa.FetchAll;
  if not Qr_Pesquisa.IsEmpty then
    Begin
    It_Cd_Producao := Qr_PesquisaPRD_CODIGO.AsInteger;
    It_Cd_Item := Qr_PesquisaRPD_CODIGO.AsInteger;
    E_Data_Entrega.Date := Qr_PesquisaPRD_PRZ_ENTREGA.AsDateTime;
    E_Qt_Entregue.Text := Qr_PesquisaRPD_QTDE.AsString;
    E_Fornecedor.Text := Qr_PesquisaEMP_NOME.AsString;
    E_Servico.Text := Qr_PesquisaPRO_DESCRICAO.AsString;
    E_Qt_Produto.Text := Qr_PesquisaPRD_QTDE.AsString;
    end
  else
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Nenhum registro encontrado com este número de Romaneio.'+EOLN+
                   '             Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpErro);
    end;


end;

procedure TFr_Ret_Producao.FormShow(Sender: TObject);
begin
  E_Romaneio.SetFocus;
end;

procedure TFr_Ret_Producao.SB_GravarClick(Sender: TObject);
Var
  Lc_Enviado : real;
  Lc_Recebido : real;
begin
  Screen.Cursor := crHourGlass;
  Lc_Enviado := StrToFloatDef(E_Qt_Produto.Text,0);
  IF It_StateChange = 'I' then
    Begin
    Lc_Recebido := StrToFloatDef(E_Qt_Entregue.Text,0) + Fc_Qt_Recebida(It_cd_Pedido,It_Cd_Producao);
    end
  else
    Begin

    end;

  if Lc_Recebido <= Lc_Enviado then
    Begin
    Pc_Retorno_Producao(It_StateChange,
                        It_Cd_Item,
                        It_Cd_Producao,
                        E_Data_Entrega.Date,
                        StrToFloatDef(E_Qt_Entregue.Text,1));
    Close;
    end
  else
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'O numero de itens recebidos não pode ser superior ao Enviado.'+EOLN+
                   '             Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpErro);
    end;
  Screen.Cursor := crDefault;
end;

procedure TFr_Ret_Producao.SB_CancelarClick(Sender: TObject);
begin
  close;
end;

procedure TFr_Ret_Producao.E_RomaneioExit(Sender: TObject);
begin
  Pc_MostraBusca(E_Romaneio.Text);
end;

procedure TFr_Ret_Producao.FormCreate(Sender: TObject);
begin
  E_Qt_Entregue.Alignment := TAlignment(1);
  E_Qt_Produto.Alignment  := TAlignment(1);
end;

procedure TFr_Ret_Producao.Qr_PesquisaAfterOpen(DataSet: TDataSet);
begin
  It_cd_Pedido := Qr_PesquisaPRD_CODPED.AsInteger;
end;

procedure TFr_Ret_Producao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
      case Key of
      VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
      VK_F6  : if SB_Cancelar.Enabled then SB_CancelarClick(Sender);
      end;
    end;
end;


procedure TFr_Ret_Producao.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
END;
end.
