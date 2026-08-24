unit sea_whats_app_cfg;

interface


uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerWhatsAppCFG, cad_whats_app_cfg;

type
  TSeaWhatsAppCfg = class(TBaseSearch)
    cds_searchID: TIntegerField;
    cds_searchTB_INSTITUTION_ID: TIntegerField;
    cds_searchDESCRIPTION: TWideStringField;
    cds_searchURL_SEND: TWideStringField;
    cds_searchTOKEN: TWideStringField;
    cds_searchTOKEN_AUTH: TWideStringField;
    BaixaroSendWhatsApp1: TMenuItem;
    CorrigirEnvioduplicado1: TMenuItem;
    procedure BaixaroSendWhatsApp1Click(Sender: TObject);
    procedure CorrigirEnvioduplicado1Click(Sender: TObject);
  private
    FWhatsAppCFG : TControllerWhatsAppCFG;
    procedure WhereSql;
  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure GetView;Override;
    procedure Search;Override;
    procedure SetRegister;Override;
    procedure returnRegister;Override;

  public
    { Public declarations }
  end;

var
  SeaWhatsAppCfg: TSeaWhatsAppCfg;

implementation

{$R *.dfm}

uses     base_download;

{ TSeaWhatsAppCfg }

procedure TSeaWhatsAppCfg.BaixaroSendWhatsApp1Click(Sender: TObject);
Var
  lc_Form : TBaseDonwload;
begin
  try
    lc_Form := TBaseDonwload.Create(Self);
    lc_Form.Caption := 'Baixar o WhatsAppSend';
    lc_Form.FileNameZip := 'SendWhatsApp.zip';
    lc_Form.URL := 'https://www.setes.com.br/Gestao2016/';
    lc_Form.ShowModal;
  finally
    FreeAndNil(lc_Form);
  end;
end;

procedure TSeaWhatsAppCfg.CorrigirEnvioduplicado1Click(Sender: TObject);
begin
  inherited;
  FWhatsAppCFG.CorrigeDuplicados;
end;

procedure TSeaWhatsAppCfg.CriarVariaveis;
begin
  inherited;
  FWhatsAppCFG := TControllerWhatsAppCFG.create(Self);
end;

procedure TSeaWhatsAppCfg.GetView;
Var
  LcForm : TCadWhatsAppCfg;
begin
  try
    LcForm := TCadWhatsAppCfg.Create(nil);
    LcForm.CodigoRegistro := cds_searchID.AsInteger;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;

end;

procedure TSeaWhatsAppCfg.IniciaVariaveis;
begin
  inherited;

end;

procedure TSeaWhatsAppCfg.returnRegister;
begin
  inherited;

end;

procedure TSeaWhatsAppCfg.Search;
Var
  I :Integer;
begin
  FWhatsAppCFG.getList;
  cds_search.Close;
  if not cds_search.Active then cds_search.CreateDataSet;
  for I := 0 to FWhatsAppCFG.Lista.Count -1 do
  Begin
    cds_search.Append;
    cds_searchID.AsInteger                := FWhatsAppCFG.Lista[I].Codigo;
    cds_searchTB_INSTITUTION_ID.AsInteger := FWhatsAppCFG.Lista[I].Estabelecimento;
    cds_searchDESCRIPTION.AsString        := FWhatsAppCFG.Lista[I].Descricao;
    cds_searchURL_SEND.AsString           := FWhatsAppCFG.Lista[I].urlSend;
    cds_searchTOKEN.AsString              := FWhatsAppCFG.Lista[I].Token;
    cds_searchTOKEN_AUTH.AsString         := FWhatsAppCFG.Lista[I].TokenAuth;
    cds_search.Post;
  End;
end;


procedure TSeaWhatsAppCfg.SetRegister;
Var
  LcForm : TCadWhatsAppCfg;
begin
  try
    LcForm := TCadWhatsAppCfg.Create(nil);
    LcForm.CodigoRegistro := 0;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TSeaWhatsAppCfg.WhereSql;
begin
  inherited;

end;

end.
