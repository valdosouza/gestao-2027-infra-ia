unit UN_Imp_Producao;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, StdCtrls, ExtCtrls, DBCtrls, Mask, DB, ComCtrls;

type
   TFr_Imp_Producao = class(TForm)
      RG_Tipo: TRadioGroup;
      Label3: TLabel;
      DBLCB_Produto: TDBLookupComboBox;
      Ds_Produto: TDataSource;
    Sb_Sair_0: TSpeedButton;
      SB_Imprimir: TSpeedButton;
      Sb_Exportar: TSpeedButton;
      E_Data_Ini: TDateTimePicker;
      E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
      procedure SB_ImprimirClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure FormCreate(Sender: TObject);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure Sb_ExportarClick(Sender: TObject);
      procedure DBLCB_ProdutoKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
    procedure FormShow(Sender: TObject);
   private
    { Private declarations }
   public
    { Public declarations }
    It_Visualizar :Boolean;
    It_Imprimir :Boolean;
    It_Exportar :Boolean;    
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;      
   end;

var
   Fr_Imp_Producao: TFr_Imp_Producao;

implementation

uses     UN_RL_Producao, Un_DM, Un_Excel, UN_Sistema, UN_Principal, env;

{$R *.dfm}



procedure TFr_Imp_Producao.SB_ImprimirClick(Sender: TObject);
begin
  try
    Pc_LimpaQrPreviweMemoria;
    if not Assigned(Rl_Producao) then
      (Application.CreateForm(TRl_Producao, Rl_Producao));
      Rl_Producao.Qrpt.Preview;
   finally
      Rl_Producao.Close
   end;
end;

procedure TFr_Imp_Producao.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   if shift = [] then
   begin
      case Key of
         VK_F2: if Sb_Exportar.Enabled then Sb_ExportarClick(Sender);
         VK_F3: if SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
         VK_Escape: if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
      end;
   end;
end;

procedure TFr_Imp_Producao.FormCreate(Sender: TObject);
begin
   RG_Tipo.ItemIndex := 0;
   E_Data_INI.Date := Date;
   E_Data_FIM.Date := Date;
   //DM.Qr_Produto.Active := true;
   ChBx_Periodo.Checked:=Fc_Marca_data_pesquisa;
end;

procedure TFr_Imp_Producao.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_Producao.Sb_ExportarClick(Sender: TObject);
var
   Lc_CAminho: string;
begin
  if Fr_Principal.SaveDialogo.Execute then
  Begin
    try
    if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
    Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
    Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
    if not Assigned(RL_Producao) then  (Application.CreateForm(TRL_Producao, RL_Producao));
    RL_Producao.Pc_Busca;
    Fr_Excel.Pc_Excel(RL_Producao.Qr_Producao, Lc_CAminho);
    finally
    RL_Producao.Close;
    end;
  end;
end;

procedure TFr_Imp_Producao.DBLCB_ProdutoKeyDown(Sender: TObject;
   var Key: Word; Shift: TShiftState);
begin
   if Shift = [] then
      case Key of
         VK_delete:
            begin
               DBLCB_Produto.KeyValue := Null;
            end;
      end;
end;

procedure TFr_Imp_Producao.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Imprimir     := True;
    It_Exportar     := True;
    end
  else
    begin
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    if not It_Visualizar then exit;
    It_Imprimir      := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    It_Exportar      := Fc_HabilitaPermissao(Pc_Menu,'EXPORTAR','S');
    end;
   SB_Imprimir.Enabled:= It_Imprimir;
   Sb_Exportar.Enabled:= It_Exportar;
end;

procedure TFr_Imp_Producao.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_PermissaoBotao('Produção');
end;

procedure TFr_Imp_Producao.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    Sb_Exportar.Glyph := (Fc_CarregaImagemBotao('EXPORTAR'));
    SB_Imprimir.Glyph := (Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
    END;
end;
end.

