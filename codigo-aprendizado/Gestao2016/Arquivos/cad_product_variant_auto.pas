unit cad_product_variant_auto;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, base_registry, Vcl.StdCtrls, Un_Base, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids;

type
  TCadProductVariantAuto = class(TFr_Base)
    pnl_Tamanho: TPanel;
    E_Tamanho: TLabeledEdit;
    Cds_Tamanho: TClientDataSet;
    Ds_Tamanho: TDataSource;
    Cds_TamanhoID: TIntegerField;
    Cds_TamanhoTB_PRODUCT_ID: TIntegerField;
    Cds_TamanhoTB_PRODUCT_VARIANT_ID: TIntegerField;
    Cds_TamanhoQUANTITY: TFloatField;
    Cds_TamanhoPRICE_TAG: TFloatField;
    SbGerarVariacoes: TSpeedButton;
    Cds_TamanhoKIND: TStringField;
    E_Cores: TLabeledEdit;
    Pnl_Bottom: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    procedure SB_Sair_0Click(Sender: TObject);
  private
  protected
    EditionState : String;
    Pf_Visualizar : Boolean;
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
  public
    { Public declarations }
  end;

var
  CadProductVariantAuto: TCadProductVariantAuto;

implementation

{$R *.dfm}

uses     UN_Principal, env;

{ TCadProductVariantAuto }

procedure TCadProductVariantAuto.CriarVariaveis;
begin
  inherited;

end;

procedure TCadProductVariantAuto.ImagemBotao;
begin
  CarregaImagemBotao(Sb_Sair_0,'SAIR');
  CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
end;

procedure TCadProductVariantAuto.IniciaVariaveis;
begin
  inherited;

end;

procedure TCadProductVariantAuto.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

end.
