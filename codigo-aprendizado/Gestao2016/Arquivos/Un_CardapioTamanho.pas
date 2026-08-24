unit Un_CardapioTamanho;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, Grids, DBGrids, StdCtrls, Buttons, Mask, DBCtrls, ExtCtrls, ComCtrls, ControllerCardapio, QEdit_Setes, ControllerMedida;

type
  TFr_CardapioTamanho = class(TForm)
    pnl_fundo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Lb_Proporcao: TLabel;
    E_Sequencia: TEdit_Setes;
    E_Descricao: TEdit;
    E_Abreviatura: TEdit;
    E_Proporcao: TEdit_Setes;
    Panel2: TPanel;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Chbx_Ativo: TCheckBox;
    procedure SB_CancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtivarDesativarProdutos;
  public
    { Public declarations }
  public
    { Public declarations }
    Cardapio : TControllerCardapio;
    TipoOperacao : String;
    procedure Pc_ImagemBotao;
    procedure Pc_IniciaVariveis;
    function validaGravacao:Boolean;
    procedure Grava;
  end;

var
  Fr_CardapioTamanho: TFr_CardapioTamanho;

implementation

uses     Un_DM, Un_Msg, Un_Principal, env, UN_Sistema, Un_Produtos, UN_TabelasEmListas;
  
{$R *.dfm}

procedure TFr_CardapioTamanho.Pc_ImagemBotao;
BEgin
  with fr_principal do
  Begin
    //Geral;
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
  end;
end;

procedure TFr_CardapioTamanho.Pc_IniciaVariveis;
Begin
  //Carrega os dados do Grupo
  Cardapio.Grupos.Registro.codigo := Cardapio.Registro.codigoGrupo;
  Cardapio.Grupos.getbyId;
  //Carrega os dados da Medida/Unidade
  with Cardapio.Medida do
  Begin
    Registro.Codigo := Cardapio.Registro.MedidaComercial;
    getbyId;
    if exist then
    Begin
      E_Sequencia.Text := IntToStr( Registro.Sequencia );
      E_Descricao.Text := Registro.Descricao;
      E_Abreviatura.Text := Registro.Abreviatura;
      E_Proporcao.Text := FloatToStrF(Registro.Proporcao,ffFixed,10,2);
    end;
  end;
end;

function TFr_CardapioTamanho.validaGravacao:Boolean;
Begin
  REsult := TRue;
  if TRIM(E_Descricao.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Descrição não informado.'+EOLN+
                   'Preencha a descrição para continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    E_Descricao.SetFocus;
    exit;
  end;

  if TRIM(E_Abreviatura.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Abreviatura não informado.'+EOLN+
                   'Preencha a Abreviatura para continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    E_Abreviatura.SetFocus;
    exit;
  end;

  if StrtoIntdeF(E_Proporcao.Text,0) = 0 then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo proporção não informado.'+EOLN+
                   'Preencha a proporção para continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    E_Proporcao.SetFocus;
    exit;
  end;
  //Verifica se  descrição da medida existe dentro do grupo
  Cardapio.Medida.Registro.Descricao := E_Descricao.Text;
  Cardapio.Medida.Registro.MedidaCardapio := Cardapio.Grupos.Registro.Descricao;
  Cardapio.Medida.getbyDescricaoMedidaCardapio;
End;

procedure TFr_CardapioTamanho.Grava;
Begin
  with Cardapio.Medida.Registro do
  Begin
    Sequencia := StrToIntDef(E_Sequencia.Text,0);
    Descricao := E_Descricao.Text;
    Abreviatura := E_Abreviatura.Text;
    Proporcao := StrToFloatDef( E_Proporcao.Text,0);
    Escala := 0;
    //A medida Especial é o nome do Grupo do Cardapio
    MedidaCardapio := Cardapio.Grupos.Registro.Descricao;
    if Chbx_Ativo.Checked then
      Ativo := 'S'
    else
      Ativo := 'N';
  End;
  Cardapio.Medida.salva;
  //Verifica os passos para gravar os produtos relacionados
  if ( Cardapio.Grupos.Registro.Tamanhos = 'S') then
  Begin
    if ( Cardapio.Grupos.Registro.PropagaTamanho = 'S') then
      Cardapio.SalvaTamanhoPropagaSabor
  End;
  AtivarDesativarProdutos;
End;

procedure TFr_CardapioTamanho.SB_CancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_CardapioTamanho.SB_GravarClick(Sender: TObject);
begin
  if validaGravacao then
  Begin
    Grava;
    Close;
  End;
end;

procedure TFr_CardapioTamanho.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_IniciaVariveis;
end;

procedure TFr_CardapioTamanho.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_CardapioTamanho.AtivarDesativarProdutos;
Var
  LcMedida : TControllerMedida;
begin
  try
    LcMedida := TControllerMedida.create(Nil);
    LcMedida.AtivarDesativarProdutos( Cardapio.Medida.Registro.Codigo,(Cardapio.Medida.Registro.Ativo = 'S'));
  finally
    FreeAndNil(LcMedida);
  end;
end;

procedure TFr_CardapioTamanho.FormCreate(Sender: TObject);
begin
  Cardapio := TControllerCardapio.Create(Self);
end;

procedure TFr_CardapioTamanho.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = [])  then
    begin
    case Key of
      VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
      VK_F6  : if SB_Cancelar.Enabled then SB_CancelarClick(Sender);
    end;
  end;
end;

end.



