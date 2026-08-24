unit Un_Info_Origen_Customer;

interface
                         
uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, ExtCtrls, StdCtrls, DB, STQuery;

type
  TFr_Info_Origen_Customer = class(TForm)
    Rg_Origens_Customer: TRadioGroup;
    Panel1: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    Qr_Origen_Customer: TSTQuery;
    procedure FormShow(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    It_cd_Customer_Origens : Integer;
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_ImagemBotao;
    procedure Pc_DefineCodigoOrigem;
  end;

var
  Fr_Info_Origen_Customer: TFr_Info_Origen_Customer;

implementation

uses     Un_DM, UN_Principal, env, UN_MSG;
{$R *.dfm}

procedure TFr_Info_Origen_Customer.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    SB_Confirmar.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

procedure TFr_Info_Origen_Customer.Pc_FormataTela;
Begin
  Pc_ImagemBotao;
  Height := 86 + (Rg_Origens_Customer.Items.Count * 30);
end;

procedure TFr_Info_Origen_Customer.Pc_IniciaVariaveis;
Begin
  with Qr_Origen_Customer do
  Begin
    Active := True;
    First;
    Rg_Origens_Customer.Items.Clear;
    while not eof do
    Begin
      Rg_Origens_Customer.Items.Add(' ' + fieldByName('description').AsString);
      next;
    end;
  end;

end;

procedure TFr_Info_Origen_Customer.Pc_DefineCodigoOrigem;
Var
  Lc_Description : String;
Begin
  with Qr_Origen_Customer do
  Begin
    It_cd_Customer_Origens := 0;
    Lc_Description := Trim(Rg_Origens_Customer.Items[Rg_Origens_Customer.ItemIndex]);
    Active := true;
    First;
    if (Locate('description',Lc_Description,[])) then
      It_cd_Customer_Origens := FieldByName('id').AsInteger;
  End;
end;

procedure TFr_Info_Origen_Customer.FormShow(Sender: TObject);
begin
  Pc_IniciaVariaveis;
  Pc_FormataTela;
end;

procedure TFr_Info_Origen_Customer.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Info_Origen_Customer.SB_ConfirmarClick(Sender: TObject);
begin
  Pc_DefineCodigoOrigem;
  if (It_cd_Customer_Origens = 0) or (Rg_Origens_Customer.ItemIndex = -1 ) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Origem do Cliente não informado.'+EOLN+EOLN+
                   'Por favor escolha uma opção para continuar'+EOLN+EOLN,
                    ['OK'],[bEscape],mpAlerta);

  end
  else
    Close;
end;

end.
