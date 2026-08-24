unit Tas_Mdfe_cad;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Un_Fm_ListaEstados, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, base_frame_list;

type
  TTasMdfeCad = class(TBaseRegistry)
    pg_mdfe: TPageControl;
    tbs_mdfe: TTabSheet;
    pnl_mdfe: TPanel;
    modelo: TLabel;
    serie: TLabel;
    numero: TLabel;
    dt_emissao: TLabel;
    dt_viagem: TLabel;
    tipo_emitente: TLabel;
    tipo_transp: TLabel;
    modalidade: TLabel;
    forma_emissao: TLabel;
    E_modelo: TEdit;
    E_serie: TEdit;
    E_numero: TEdit;
    E_data_hora_emissao: TEdit;
    E_data_hora_viagem: TEdit;
    Cb_tipo_de_emitente: TComboBox;
    Cb_tipo_de_transportador: TComboBox;
    Cb_modalidade: TComboBox;
    Cb_forma_de_emissao: TComboBox;
    Grp_local_load: TGroupBox;
    tirar: TLabel;
    Grp_city_load: TGroupBox;
    Dbg_city_load: TDBGrid;
    Bt_ins_localload: TButton;
    Bt_exc_localload: TButton;
    Grp_route: TGroupBox;
    Grp_uf_route: TGroupBox;
    Dbg_uf_route: TDBGrid;
    Bt_ins_uf_route: TButton;
    Bt_exc_uf_route: TButton;
    Grp_unload: TGroupBox;
    Fm_Listauf_unload: TFm_ListaEstados;
    Fm_Listauf_mdfe: TFm_ListaEstados;
    Fm_Listauf_route: TFm_ListaEstados;
    Fm_Listauf_local_load: TFm_ListaEstados;
    tbs_mdfe_road: TTabSheet;
    pnl_mdfe_road: TPanel;
    TabSheet3: TTabSheet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TasMdfeCad: TTasMdfeCad;

implementation

{$R *.dfm}

end.
