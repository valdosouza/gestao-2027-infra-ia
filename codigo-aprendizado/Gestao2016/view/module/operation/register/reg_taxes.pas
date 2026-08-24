unit reg_taxes;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, ControllerTaxes, env, Vcl.StdCtrls, base_frame_list, Vcl.ComCtrls, un_fm_lista_tax_incidency, un_fm_lista_cst_cbs_ibs, un_fm_lista_class_trib_cbs_ibs, ControllerTributacao;

type
  TRegTaxes = class(TBaseRegistry)
    pg_main: TPageControl;
    tbs_ibs: TTabSheet;
    tbs_CBS: TTabSheet;
    pnl_cbs: TPanel;
    Pnl_Ibs: TPanel;
    Pg_IBS_UF_MUN: TPageControl;
    tbs_ibs_uf: TTabSheet;
    tbs_Ibs_Mun: TTabSheet;
    Pnl_Ibs_Uf: TPanel;
    Pnl_ibs_Mun: TPanel;
    Lb_IBS_UF_Aliquota: TLabel;
    E_IBS_UF_Aliquota: TEdit;
    E_IBS_UF_ALIQ_RED: TEdit;
    Lb_IBS_UF_Aliq_Red: TLabel;
    Lb_IBS_UF_Aliq_efet: TLabel;
    E_IBS_UF_ALIQ_EFET: TEdit;
    E_IBS_UF_ALIQ_DIF: TEdit;
    Lb_IBS_UF_Aliq_Dif: TLabel;
    Lb_IBS_Mun_Aliquota: TLabel;
    E_IBS_MUN_ALIQUOTA: TEdit;
    E_IBS_MUN_ALIQ_RED: TEdit;
    Lb_IBS_Mun_Aliq_Red: TLabel;
    Lb_IBS_Mun_Aliq_efet: TLabel;
    E_IBS_MUN_ALIQ_EFET: TEdit;
    E_IBS_MUN_ALIQ_DIF: TEdit;
    Lb_IBS_Mun_Aliq_Dif: TLabel;
    Lb_CBS_UF_Aliquota: TLabel;
    E_CBS_ALIQUOTA: TEdit;
    E_CBS_ALIQ_RED: TEdit;
    Lb_CBS_UF_Red_Aliq: TLabel;
    Lb_CBS_UF_Aliq_Efet: TLabel;
    E_CBS_ALIQ_EFET: TEdit;
    E_CBS_ALIQ_DIF: TEdit;
    Lb_CBS_UF_Aliq_Dif: TLabel;
    FmListaTaxIncidency: TFmListaTaxIncidency;
    pnl_line_01: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    FmListaCstCbsIbs: TFmListaCstCbsIbs;
    FmListaClassTribIbsCbs: TFmListaClassTribIbsCbs;
    AplicarnaRegradetributao1: TMenuItem;

    procedure FmListaCstIbsDblcb_ListaClick(Sender: TObject);
    procedure E_IBS_MUN_ALIQUOTAExit(Sender: TObject);
    procedure E_IBS_MUN_ALIQ_REDExit(Sender: TObject);
    procedure E_IBS_MUN_ALIQ_EFETExit(Sender: TObject);
    procedure E_IBS_MUN_ALIQ_DIFExit(Sender: TObject);
    procedure E_IBS_UF_AliquotaExit(Sender: TObject);
    procedure E_IBS_UF_ALIQ_REDExit(Sender: TObject);
    procedure E_IBS_UF_ALIQ_EFETExit(Sender: TObject);
    procedure E_IBS_UF_ALIQ_DIFExit(Sender: TObject);
    procedure E_CBS_ALIQUOTAExit(Sender: TObject);
    procedure E_CBS_ALIQ_REDExit(Sender: TObject);
    procedure E_CBS_ALIQ_EFETExit(Sender: TObject);
    procedure E_CBS_ALIQ_DIFExit(Sender: TObject);
    procedure FmListaCstCbsIbsDblcb_ListaClick(Sender: TObject);
    procedure Aplicarnaregradetributao1Click(Sender: TObject);
  private
    taxation : TControllerTributacao;
    procedure LoadIncidency;
    procedure LoadCST;
    procedure LoadClasse;
    procedure Calcula_Aliq_Efetiva_IBS_UF;
    procedure Calcula_Aliq_Efetiva_IBS_MUN;
    procedure Calcula_Aliq_Efetiva_CBS;
    function ValidaAplicaRegraTributacao:Boolean;
    procedure AplicaRegraTributacao;
  protected
    procedure setPerfil;Override;
    procedure formataTela;override;
    procedure ClearAllFields; Override;
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure ShowData; Override;
    procedure ShowDataTaxes;
    procedure ShowDataTaxesCBS;
    procedure ShowDataTaxesIBS;
    procedure ShowNoData; Override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;
    procedure EditionControl;Override;
  public
    Taxes : TControllerTaxes;
  end;

var
  RegTaxes: TRegTaxes;

implementation

{$R *.dfm}

uses     UN_MSG;

{ TBaseRegistry1 }

procedure TRegTaxes.AplicaRegraTributacao;
Var
  Lc_Escolha : Integer;
  cMessage : String;
Begin
  cMessage := Concat(
                'Escolha o Tipo de Operção',EOLN,
                '  TOTAL   - Aplica esse registro para todas as regras de tributção.',EOLN,
                '  PARCIAL - Aplica esse registro somente para as regras de tributçãoca sem vinculo.',EOLN
  );

  Lc_Escolha:=(MensagemPadrao(TITULO_INFORMACAO,
                              cMessage,
                              ['TOTAL','PARCIAL','CANCELAR'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
  case Lc_Escolha of
    0:taxation.AplicaReformaTributaria(0,Taxes.Registro.ID,'TOTAL');
    1:taxation.AplicaReformaTributaria(0,Taxes.Registro.ID,'PARCIAL');
  end;
end;

procedure TRegTaxes.Aplicarnaregradetributao1Click(Sender: TObject);
begin
  if ValidaAplicaRegraTributacao then
    AplicaRegraTributacao;

end;

procedure TRegTaxes.Calcula_Aliq_Efetiva_CBS;
var
  Lc_Aliquota : Real;
  Lc_Aliq_Red : Real;
  Lc_Aqli_Efe : Real;
begin
  Lc_Aliquota := StrtoFloatDef(E_CBS_ALIQUOTA.Text,0);
  Lc_Aliq_Red := StrtoFloatDef(E_CBS_ALIQ_RED.Text,0);
  Lc_Aqli_Efe := Lc_Aliquota - Lc_Aliq_Red;
  E_CBS_ALIQ_EFET.Text := FloatToStrF(Lc_Aqli_Efe, ffFixed,10,4);
end;

procedure TRegTaxes.Calcula_Aliq_Efetiva_IBS_MUN;
var
  Lc_Aliquota : Real;
  Lc_Aliq_Red : Real;
  Lc_Aqli_Efe : Real;
begin
  Lc_Aliquota := StrtoFloatDef(E_IBS_MUN_Aliquota.Text,0);
  Lc_Aliq_Red := StrtoFloatDef(E_IBS_MUN_ALIQ_RED.Text,0);
  Lc_Aqli_Efe := Lc_Aliquota - Lc_Aliq_Red;
  E_IBS_MUN_ALIQ_EFET.Text := FloatToStrF(Lc_Aqli_Efe, ffFixed,10,4);
end;

procedure TRegTaxes.Calcula_Aliq_Efetiva_IBS_UF;
var
  Lc_Aliquota : Real;
  Lc_Aliq_Red : Real;
  Lc_Aqli_Efe : Real;
begin
  Lc_Aliquota := StrtoFloatDef(E_IBS_UF_Aliquota.Text,0);
  Lc_Aliq_Red := StrtoFloatDef(E_IBS_UF_ALIQ_RED.Text,0);
  Lc_Aqli_Efe := Lc_Aliquota - Lc_Aliq_Red;
  E_IBS_UF_ALIQ_EFET.Text := FloatToStrF(Lc_Aqli_Efe, ffFixed,10,4);
end;

procedure TRegTaxes.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegTaxes.ClearAllFields;
begin
  inherited;
  Taxes.Clear;
end;

procedure TRegTaxes.CriarVariaveis;
begin
  inherited;
  Taxes     := TControllerTaxes.Create(Self);
  taxation  := TControllerTributacao.Create(Self);
end;

procedure TRegTaxes.Delete;
begin
  inherited;
  Taxes.delete;
end;

procedure TRegTaxes.EditionControl;
begin
  inherited;
  E_IBS_UF_ALIQ_EFET.ReadOnly   := True;
  E_IBS_MUN_ALIQ_EFET.ReadOnly  := True;
  E_CBS_ALIQ_EFET.ReadOnly      := True;
end;

procedure TRegTaxes.E_CBS_ALIQUOTAExit(Sender: TObject);
begin
  TEdit(Sender).Text := FloatToStrF( StrToFloatDef(TEdit(Sender).Text, 0),ffFixed,10,4);
  Calcula_Aliq_Efetiva_CBS;
end;

procedure TRegTaxes.E_CBS_ALIQ_DIFExit(Sender: TObject);
begin
  TEdit(Sender).Text := FloatToStrF( StrToFloatDef(TEdit(Sender).Text, 0),ffFixed,10,4);
end;

procedure TRegTaxes.E_CBS_ALIQ_EFETExit(Sender: TObject);
begin
  TEdit(Sender).Text := FloatToStrF( StrToFloatDef(TEdit(Sender).Text, 0),ffFixed,10,4);
end;

procedure TRegTaxes.E_CBS_ALIQ_REDExit(Sender: TObject);
begin
  TEdit(Sender).Text := FloatToStrF( StrToFloatDef(TEdit(Sender).Text, 0),ffFixed,10,4);
  Calcula_Aliq_Efetiva_CBS;
end;

procedure TRegTaxes.E_IBS_MUN_ALIQUOTAExit(Sender: TObject);
begin
  TEdit(Sender).Text := FloatToStrF( StrToFloatDef(TEdit(Sender).Text, 0),ffFixed,10,4);
  Calcula_Aliq_Efetiva_IBS_MUN;
end;

procedure TRegTaxes.E_IBS_MUN_ALIQ_DIFExit(Sender: TObject);
begin
  TEdit(Sender).Text := FloatToStrF( StrToFloatDef(TEdit(Sender).Text, 0),ffFixed,10,4);
end;

procedure TRegTaxes.E_IBS_MUN_ALIQ_EFETExit(Sender: TObject);
begin
  TEdit(Sender).Text := FloatToStrF( StrToFloatDef(TEdit(Sender).Text, 0),ffFixed,10,4);
end;

procedure TRegTaxes.E_IBS_MUN_ALIQ_REDExit(Sender: TObject);
begin
  TEdit(Sender).Text := FloatToStrF( StrToFloatDef(TEdit(Sender).Text, 0),ffFixed,10,4);
  Calcula_Aliq_Efetiva_IBS_MUN;
end;

procedure TRegTaxes.E_IBS_UF_AliquotaExit(Sender: TObject);
begin
  TEdit(Sender).Text := FloatToStrF( StrToFloatDef(TEdit(Sender).Text, 0),ffFixed,10,4);
  Calcula_Aliq_Efetiva_IBS_UF;
end;

procedure TRegTaxes.E_IBS_UF_ALIQ_DIFExit(Sender: TObject);
begin
  TEdit(Sender).Text := FloatToStrF( StrToFloatDef(TEdit(Sender).Text, 0),ffFixed,10,4);
end;

procedure TRegTaxes.E_IBS_UF_ALIQ_EFETExit(Sender: TObject);
begin
  TEdit(Sender).Text := FloatToStrF( StrToFloatDef(TEdit(Sender).Text, 0),ffFixed,10,4);
end;

procedure TRegTaxes.E_IBS_UF_ALIQ_REDExit(Sender: TObject);
begin
  TEdit(Sender).Text := FloatToStrF( StrToFloatDef(TEdit(Sender).Text, 0),ffFixed,10,4);
  Calcula_Aliq_Efetiva_IBS_UF;
end;

procedure TRegTaxes.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil( Taxes);
  FreeAndNil(taxation);
end;

procedure TRegTaxes.FmListaCstCbsIbsDblcb_ListaClick(Sender: TObject);
begin
  inherited;
  LoadClasse;
end;

procedure TRegTaxes.FmListaCstIbsDblcb_ListaClick(Sender: TObject);
begin
  inherited;
  LoadClasse;
end;

procedure TRegTaxes.formataTela;
begin
  inherited;

end;

procedure TRegTaxes.IniciaVariaveis;
begin
  LoadIncidency;
  LoadCST;

  if Self.CodigoRegistro > 0 then
  Begin
    Taxes.Registro.ID := Self.CodigoRegistro;
    Taxes.Registro.Institution := Gb_CodMha;
    Taxes.getByKey;
  End;
  inherited;
end;

procedure TRegTaxes.Insert;
begin
  inherited;

end;

procedure TRegTaxes.LoadClasse;
begin
  if FmListaCstCbsIbs.Dblcb_Lista.Text <> EmptyStr then
    FmListaClassTribIbsCbs.CST := FmListaCstCbsIbs.Qr_Lista.FieldByName('CST').AsString;
end;

procedure TRegTaxes.LoadCST;
begin
  FmListaCstCbsIbs.Listar;
end;

procedure TRegTaxes.LoadIncidency;
begin
  FmListaTaxIncidency.Listar;
end;

procedure TRegTaxes.Save;
begin
  inherited;
  Taxes.Registro.Institution      := Gb_CodMha;
  Taxes.Registro.Description      := E_Descricao.Text;
  Taxes.Registro.TaxesIncidencyId := FmListaTaxIncidency.Dblcb_Lista.KeyValue;
  Taxes.Registro.CST              := FmListaCstCbsIbs.Dblcb_Lista.KeyValue;
  Taxes.Registro.Classtrib        := FmListaClassTribIbsCbs.Dblcb_Lista.KeyValue;
  Taxes.save;
  //IBS - UF
  Taxes.IBS_UF.Registro.tb_taxes_id := Taxes.Registro.ID;
  Taxes.IBS_UF.Registro.aliquota        := StrToFloatDef(E_IBS_UF_Aliquota.Text,0);
  Taxes.IBS_UF.Registro.aliq_red        := StrToFloatDef(E_IBS_UF_ALIQ_RED.Text,0);
  Taxes.IBS_UF.Registro.aliq_efe        := StrToFloatDef(E_IBS_UF_ALIQ_EFET.Text,0);
  Taxes.IBS_UF.Registro.aliq_dif        := StrToFloatDef(E_IBS_UF_ALIQ_DIF.Text,0);
  Taxes.IBS_UF.save;
  //IBS - MUN
  Taxes.IBS_Mun.Registro.tb_taxes_id := Taxes.Registro.ID;
  Taxes.IBS_Mun.Registro.aliquota        := StrToFloatDef(E_IBS_MUN_Aliquota.Text,0);
  Taxes.IBS_Mun.Registro.aliq_red        := StrToFloatDef(E_IBS_MUN_ALIQ_RED.Text,0);
  Taxes.IBS_Mun.Registro.aliq_efe        := StrToFloatDef(E_IBS_MUN_ALIQ_EFET.Text,0);
  Taxes.IBS_Mun.Registro.aliq_dif        := StrToFloatDef(E_IBS_MUN_ALIQ_DIF.Text,0);
  Taxes.IBS_Mun.save;
  //CBS
  Taxes.CBS.Registro.tb_taxes_id := Taxes.Registro.ID;
  Taxes.CBS.Registro.aliquota    := StrToFloatDef(E_CBS_ALIQUOTA.Text,0);
  Taxes.CBS.Registro.aliq_red    := StrToFloatDef(E_CBS_ALIQ_RED.Text,0);
  Taxes.CBS.Registro.aliq_efe    := StrToFloatDef(E_CBS_ALIQ_EFET.Text,0);
  Taxes.CBS.Registro.aliq_dif    := StrToFloatDef(E_CBS_ALIQ_DIF.Text,0);
  Taxes.CBS.save;

  CodigoRegistro := Taxes.Registro.ID;
  inherited;
end;

procedure TRegTaxes.setPerfil;
begin
  inherited;

end;

procedure TRegTaxes.ShowData;
begin
  ShowDataTaxes;
  ShowDataTaxesCBS;
  ShowDataTaxesIBS;
end;

procedure TRegTaxes.ShowDataTaxes;
begin
  E_Codigo.Text := Taxes.Registro.ID.ToString();
  E_Descricao.Text := Taxes.Registro.Description;
  FmListaTaxIncidency.Dblcb_Lista.KeyValue := Taxes.Registro.TaxesIncidencyId;

  FmListaCstCbsIbs.Dblcb_Lista.KeyValue := Taxes.Registro.cst;
  LoadClasse;
  FmListaClassTribIbsCbs.Dblcb_Lista.KeyValue := Taxes.Registro.classtrib;

end;

procedure TRegTaxes.ShowDataTaxesCBS;
begin
  E_CBS_ALIQUOTA.Text    := FloatToStrF(Taxes.CBS.Registro.aliquota,ffFixed,10,4);
  E_CBS_ALIQ_RED.Text    := FloatToStrF(Taxes.CBS.Registro.aliq_red,ffFixed,10,4);
  E_CBS_ALIQ_EFET.Text   := FloatToStrF(Taxes.CBS.Registro.aliq_efe,ffFixed,10,4);
  E_CBS_ALIQ_DIF.Text    := FloatToStrF(Taxes.CBS.Registro.aliq_dif,ffFixed,10,4);

end;

procedure TRegTaxes.ShowDataTaxesIBS;
begin
  E_IBS_UF_Aliquota.Text    := FloatToStrF(Taxes.IBS_UF.Registro.aliquota,ffFixed,10,4);
  E_IBS_UF_ALIQ_RED.Text    := FloatToStrF(Taxes.IBS_UF.Registro.aliq_red,ffFixed,10,4);
  E_IBS_UF_ALIQ_EFET.Text   := FloatToStrF(Taxes.IBS_UF.Registro.aliq_efe,ffFixed,10,4);
  E_IBS_UF_ALIQ_DIF.Text    := FloatToStrF(Taxes.IBS_UF.Registro.aliq_dif,ffFixed,10,4);

  E_IBS_MUN_ALIQUOTA.Text   := FloatToStrF(Taxes.IBS_Mun.Registro.aliquota,ffFixed,10,4);
  E_IBS_MUN_ALIQ_RED.Text   := FloatToStrF(Taxes.IBS_Mun.Registro.aliq_red,ffFixed,10,4);
  E_IBS_MUN_ALIQ_EFET.Text  := FloatToStrF(Taxes.IBS_Mun.Registro.aliq_efe,ffFixed,10,4);
  E_IBS_MUN_ALIQ_DIF.Text   := FloatToStrF(Taxes.IBS_Mun.Registro.aliq_dif,ffFixed,10,4);

end;

procedure TRegTaxes.ShowNoData;
begin
  inherited;
  Taxes.Clear;
end;

function TRegTaxes.ValidaAplicaRegraTributacao: Boolean;
begin
  Result := True;
  if Taxes.Registro.ID = 0 then
  begin
    TMsgSetes.PararExecucao('Nao foi encontrado Registro da Reforma Tributãria');
    Result := False;
    Exit;
  end;

end;

function TRegTaxes.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegTaxes.ValidateSave: boolean;
begin
  Result := True;
  if TRIM(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    E_Descricao.SetFocus;
    Result := False;
    Exit;
  end;

  if TRIM(FmListaTaxIncidency.Dblcb_Lista.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(FmListaTaxIncidency.L_name_list.Caption);
    FmListaTaxIncidency.Dblcb_Lista.SetFocus;
    Result := False;
    Exit;
  end;

  //IBS
  if TRIM(FmListaCstCbsIbs.Dblcb_Lista.Text) = EmptyStr then
  begin
    pg_main.ActivePage := tbs_ibs;
    TMsgSetes.ValidaPreenchimentoCampo(FmListaCstCbsIbs.L_name_list.Caption);
    FmListaCstCbsIbs.Dblcb_Lista.SetFocus;
    Result := False;
    Exit;
  end;

  if TRIM(FmListaClassTribIbsCbs.Dblcb_Lista.Text) = EmptyStr then
  begin
    pg_main.ActivePage := tbs_ibs;
    TMsgSetes.ValidaPreenchimentoCampo(FmListaClassTribIbsCbs.L_name_list.Caption);
    FmListaClassTribIbsCbs.Dblcb_Lista.SetFocus;
    Result := False;
    Exit;
  end;
  //IBS - UF
  {if ( StrToFloatDeF(E_IBS_UF_Aliquota.Text,0) = 0 ) then
  begin
    pg_main.ActivePage := tbs_ibs;
    Pg_IBS_UF_MUN.ActivePage := tbs_ibs_uf;
    TMsgSetes.ValidaPreenchimentoCampo(Lb_IBS_UF_Aliquota.Caption);
    E_IBS_UF_Aliquota.SetFocus;
    Result := False;
    Exit;
  end;}

  //IBS - MUNICIPIO
  {if ( StrToFloatDeF(E_IBS_MUN_ALIQUOTA.Text,0) = 0 ) then
  begin
    pg_main.ActivePage := tbs_ibs;
    Pg_IBS_UF_MUN.ActivePage := tbs_ibs_mun;
    TMsgSetes.ValidaPreenchimentoCampo(Lb_IBS_MUN_Aliquota.Caption);
    E_IBS_MUN_Aliquota.SetFocus;
    Result := False;
    Exit;
  end;     }

  //CSB
  if TRIM(FmListaCstCbsIbs.Dblcb_Lista.Text) = EmptyStr then
  begin
    pg_main.ActivePage := tbs_CBS;
    TMsgSetes.ValidaPreenchimentoCampo(FmListaCstCbsIbs.L_name_list.Caption);
    FmListaCstCbsIbs.Dblcb_Lista.SetFocus;
    Result := False;
    Exit;
  end;

  if TRIM(FmListaClassTribIbsCbs.Dblcb_Lista.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(FmListaClassTribIbsCbs.L_name_list.Caption);
    FmListaClassTribIbsCbs.Dblcb_Lista.SetFocus;
    Result := False;
    Exit;
  end;

  {
  if ( StrToFloatDeF(E_CBS_Aliquota.Text,0) = 0 ) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(Lb_CBS_UF_Aliquota.Caption);
    E_CBS_Aliquota.SetFocus;
    Result := False;
    Exit;
  end;}

end;

end.
