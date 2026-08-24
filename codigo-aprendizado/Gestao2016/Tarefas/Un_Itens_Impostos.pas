unit Un_Itens_Impostos;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, QEdit_Setes;

type
  TFr_Itens_Impostos = class(TBaseRegistry)
    Label5: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label16: TLabel;
    Label4: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Sb_Sit_Trib_ICMS: TSpeedButton;
    Sb_Sit_Trib_CSOSN: TSpeedButton;
    Sb_Modal_ICMS: TSpeedButton;
    Sb_Desoneracao: TSpeedButton;
    Sb_Modal_ICMS_St: TSpeedButton;
    Label28: TLabel;
    Label9: TLabel;
    SB_Natureza: TSpeedButton;
    E_Aq_ICMS: TEdit_Setes;
    E_Red_Base: TEdit_Setes;
    E_Red_Aliq: TEdit_Setes;
    Dblcb_Situacao_tributaria: TDBLookupComboBox;
    Dblcb_Modal_ICMS_ST: TDBLookupComboBox;
    Dblcb_Modal_ICMS: TDBLookupComboBox;
    Dblcb_Desoneracao: TDBLookupComboBox;
    Dblcb_Simples_Nacional: TDBLookupComboBox;
    Cb_Origem: TComboBox;
    PageControl1: TPageControl;
    tbs_ipi: TTabSheet;
    Panel2: TPanel;
    Label8: TLabel;
    Label20: TLabel;
    Sb_Sit_Trib_IPI: TSpeedButton;
    E_Aq_IPI: TEdit_Setes;
    Dblcb_Situacao_tributaria_IPI: TDBLookupComboBox;
    tbs_pis: TTabSheet;
    Panel3: TPanel;
    Label10: TLabel;
    Label21: TLabel;
    Sb_Sit_Trib_PIS: TSpeedButton;
    E_Aq_Pis: TEdit_Setes;
    Dblcb_Situacao_tributaria_PIS: TDBLookupComboBox;
    tbs_cofins: TTabSheet;
    Panel4: TPanel;
    Label13: TLabel;
    Label23: TLabel;
    Sb_Sit_Trib_CFS: TSpeedButton;
    E_Aq_Cofins: TEdit_Setes;
    Dblcb_Situacao_tributaria_CFS: TDBLookupComboBox;
    tbs_outros: TTabSheet;
    Panel5: TPanel;
    Label12: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    Label14: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    E_Aq_IRPJ: TEdit_Setes;
    E_Aq_CSLL: TEdit_Setes;
    E_Aq_Siscomex: TEdit_Setes;
    E_Aq_Tec: TEdit_Setes;
    E_Aq_ISS: TEdit_Setes;
    E_AQ_AFRMM: TEdit_Setes;
    DBLCB_Natureza: TDBLookupComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_Itens_Impostos: TFr_Itens_Impostos;

implementation

{$R *.dfm}

end.
