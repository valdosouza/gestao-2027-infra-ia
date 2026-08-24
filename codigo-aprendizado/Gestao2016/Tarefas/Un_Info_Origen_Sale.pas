unit Un_Info_Origen_Sale;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, ExtCtrls, StdCtrls, DB, STQuery;

type
  TFr_Info_Origen_Sale = class(TForm)
    Rg_Origens_Sale: TRadioGroup;
    Panel1: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    Qr_Origen_Sale: TSTQuery;
    procedure FormShow(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    It_cd_Sale_Origens : Integer;
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_ImagemBotao;
    procedure Pc_DefineCodigoOrigem;
  end;

var
  Fr_Info_Origen_Sale: TFr_Info_Origen_Sale;

implementation

uses     Un_DM, UN_Principal, env, UN_MSG;
{$R *.dfm}

procedure TFr_Info_Origen_Sale.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    SB_Confirmar.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Info_Origen_Sale.Pc_FormataTela;
Begin
  Pc_ImagemBotao;
  Height := 86 + (Rg_Origens_Sale.Items.Count * 30);
end;

procedure TFr_Info_Origen_Sale.Pc_IniciaVariaveis;
Begin
  with Qr_Origen_Sale do
  Begin
    Active := True;
    First;
    Rg_Origens_Sale.Items.Clear;
    while not eof do
    Begin
      Rg_Origens_Sale.Items.Add(' ' + fieldByName('description').AsString);
      next;
    end;
  end;

end;

procedure TFr_Info_Origen_Sale.Pc_DefineCodigoOrigem;
Var
  Lc_Description : String;
Begin
  It_cd_Sale_Origens := 0;
  Lc_Description := Trim(Rg_Origens_Sale.Items[Rg_Origens_Sale.ItemIndex]);
  Qr_Origen_Sale.Active := true;
  Qr_Origen_Sale.First;
  if (Qr_Origen_Sale.Locate('description',Lc_Description,[])) then
    It_cd_Sale_Origens := Qr_Origen_Sale.FieldByName('id').AsInteger;

end;

procedure TFr_Info_Origen_Sale.FormShow(Sender: TObject);
begin
  Pc_IniciaVariaveis;
  Pc_FormataTela;
end;

procedure TFr_Info_Origen_Sale.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Info_Origen_Sale.SB_ConfirmarClick(Sender: TObject);
begin
  Pc_DefineCodigoOrigem;
  if (It_cd_Sale_Origens = 0) or (Rg_Origens_Sale.ItemIndex = -1 ) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Origem da venda não informada.'+EOLN+EOLN+
                   'Por favor escolha uma opção para continuar'+EOLN+EOLN,
                    ['OK'],[bEscape],mpAlerta);

  end
  else
    Close;
end;

end.
