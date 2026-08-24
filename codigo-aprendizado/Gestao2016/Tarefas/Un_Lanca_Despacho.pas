unit Un_Lanca_Despacho;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, ExtCtrls, DB, STQuery, StdCtrls, ComCtrls, Mask, QEdit_Setes, ControllerDespacho;

type
  TFr_Lanca_Despacho = class(TForm)
    Pnl_Fundo: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Fechar: TSpeedButton;
    Pnl_Botoes: TPanel;
    E_Descricao: TEdit;
    Label1: TLabel;
    E_Cd_Produto: TEdit;
    Label2: TLabel;
    E_Quantidade: TEdit_Setes;
    Label3: TLabel;
    E_Data_Realizada: TDateTimePicker;
    Label4: TLabel;
    E_Qtd_Baixar: TEdit_Setes;
    Label6: TLabel;
    GroupBox1: TGroupBox;
    Qr_Despacho: TSTQuery;
    E_Data_Prevista: TDateTimePicker;
    Label5: TLabel;
    Qr_Acao: TSTQuery;
    procedure SB_FecharClick(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure E_Qtd_BaixarExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure E_Qtd_BaixarChange(Sender: TObject);
    procedure E_Qtd_BaixarEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FDespacho : TControllerDespacho;
    procedure AtualizarDespacho;
  public
    { Public declarations }

    It_Cd_Despacho : Integer;
    It_Cd_Pedido : Integer;
    It_Cd_Item : Integer;
    It_cd_Produto : Integer;
    It_Qt_Item : real;
    it_dt_realizada, it_dt_prevista:TDate;
    function Fc_ValidaDespacho: Boolean;
    procedure Pc_ConsultaDespacho;
    procedure Pc_Formatatela;
  end;

var
  Fr_Lanca_Despacho: TFr_Lanca_Despacho;

implementation

uses     Un_Despacho, Un_DM, un_Padrao, UN_Sistema, Un_Fc_Sored_Procedures, Un_Regra_Negocio, UN_MSG, env;
{$R *.dfm}

procedure TFr_Lanca_Despacho.Pc_Formatatela;
Begin

end;

function TFr_Lanca_Despacho.Fc_ValidaDespacho: Boolean;
var
  Lc_Dt_Prevista: TDate;
begin
  Result := True;
  Lc_Dt_Prevista := E_Data_Prevista.Date;

  if  (StrToFloatDef(E_Qtd_Baixar.Text,0) > IT_QT_ITEM ) then
   begin
   MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                  'A quantidade a baixar não pode ser maior do que ' + EOLN+
                  'do que o campo quantidade' + EOLN+
                  'Verifique e tente novamente.' + EOLN,
                  ['OK'], [bEscape], mpAlerta);
   Result := False;
   E_Qtd_Baixar.SetFocus;
   exit;
   end;

  if  (StrToFloatDef(E_Qtd_Baixar.Text,0) =0) then
   begin
   MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                  'A quantidade a baixar não pode ser zero. ' + EOLN+
                  'Verifique e tente novamente.' + EOLN,
                  ['OK'], [bEscape], mpAlerta);
   Result := False;
   E_Qtd_Baixar.SetFocus;
   exit;
   end;

  if (E_Data_Realizada.Date < it_dt_prevista) OR (E_Data_Realizada.Date < it_dt_realizada) then
    begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Data Realizada inferior a Data Prevista do Pedido. ' + EOLN+
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    E_Data_Realizada.SetFocus;
    exit;
    end;

  if ( Lc_Dt_Prevista <  it_dt_prevista)then
    begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Data Prevista para próximo Despacho inferior a Data Prevista do Pedido.' + EOLN+
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    if E_Data_Prevista.Visible then
      E_Data_Prevista.SetFocus;
    exit;
    end;
end;

procedure TFr_Lanca_Despacho.Pc_ConsultaDespacho;
begin
  With Qr_Acao do
    begin
    Active := False;
    SQL.Clear;
    SQL.Add(' select dsp_dt_prevista from tb_despacho  where dsp_coditf =:dsp_coditf'+
            ' and dsp_dt_REALIZADA in (select max(DSP_DT_REALIZADA) from tb_despacho  where dsp_coditf =:dsp_coditf) ');
    ParamByName('dsp_coditf').AsInteger:= It_Cd_Item;
    Active:=true;
    if RecordCount > 0 then
      begin
      E_Data_Prevista.Date:= fieldbyname('dsp_dt_prevista').AsDateTime;
      it_dt_prevista:=  E_Data_Prevista.Date;
      end
    else
      begin
      Active := False;
      SQL.Clear;
      SQL.Add('select dsp_dt_prevista from tb_despacho  where dsp_coditf =:dsp_coditf ');
      ParamByName('dsp_coditf').AsInteger:= It_Cd_Item;
      Active:=true;
      E_Data_Prevista.Date:= fieldbyname('dsp_dt_prevista').AsDateTime;
      it_dt_prevista:=  E_Data_Prevista.Date;
      end;

    Active := False;
    SQL.Clear;
    SQL.Add(' select MAX(dsp_dt_REALIZADA) from tb_despacho  where dsp_coditf =:dsp_coditf ');
    ParamByName('dsp_coditf').AsInteger:= It_Cd_Item;
    Active:=true;
    it_dt_realizada:= fieldbyname('MAX').AsDateTime;

    if it_dt_realizada = 0 then
      it_dt_realizada:=It_dt_prevista;

    E_Data_Realizada.Date:= it_dt_realizada;
    end;  
end;


procedure TFr_Lanca_Despacho.SB_FecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Lanca_Despacho.SB_ConfirmarClick(Sender: TObject);
begin
  if Fc_ValidaDespacho then
  begin
    try
      Pc_ProcesoAguarde(Self,'I');
      Application.ProcessMessages;
      Self.Enabled := False;
      AtualizarDespacho;


      Application.ProcessMessages;
    finally
      Close;
      Pc_ProcesoAguarde(Self,'F');
      Self.Enabled := True;
    end;
  end;
end;

procedure TFr_Lanca_Despacho.E_Qtd_BaixarExit(Sender: TObject);
var
  Lc_Valor: Real;
begin
  Lc_Valor := StrToFloatDef(E_Qtd_Baixar.Text,0);
  E_Qtd_Baixar.Text := FloatToStrF(Lc_Valor,ffFixed,10,3);
  IF StrToFloatDef(E_Quantidade.Text,0) = StrToFloatDef(E_Qtd_Baixar.Text,0) THEN
    E_Data_Prevista.Visible:=FALSE
  ELSE
    BEGIN
    E_Data_Prevista.Visible:=True;
    E_Data_Prevista.SetFocus;    
    END;
end;

procedure TFr_Lanca_Despacho.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil( FDespacho );
end;

procedure TFr_Lanca_Despacho.FormCreate(Sender: TObject);
begin
  FDespacho := TControllerDespacho.Create(nil);
end;

procedure TFr_Lanca_Despacho.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
      case Key of
        VK_F10: SB_ConfirmarClick(Sender);
        VK_Escape : SB_FecharClick(Sender);
      end;
    end;
end;

procedure TFr_Lanca_Despacho.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) and (not (ActiveControl is TMemo)) then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;


procedure TFr_Lanca_Despacho.FormShow(Sender: TObject);
begin
  Pc_Formatatela;
  E_Data_Prevista.Visible:=FALSE;
  E_Qtd_Baixar.SetFocus;
  E_Qtd_Baixar.Text:=  E_Quantidade.Text;
end;

procedure TFr_Lanca_Despacho.AtualizarDespacho;
begin
  FDespacho.Registro.Codigo := It_Cd_Despacho;
  FDespacho.getById;
  if FDespacho.exist then
  Begin
    FDespacho.Registro.Qtde := StrToFloatDef(E_Qtd_Baixar.Text,1);
    FDespacho.Registro.DataRealizada := E_Data_Realizada.DateTime;
    FDespacho.AtualizaDespacho;
  End;

  if StrToFloatDef(E_Qtd_Baixar.Text,0) <> StrToFloatDEF(E_Quantidade.Text,0) then// so lanca se quantidade for diferente
  Begin
    FDespacho.Clear;
    FDespacho.Registro.Codigo       := 0;
    FDespacho.Registro.ItemPedido   := It_Cd_Item;
    FDespacho.Registro.DataPrevista := E_Data_Prevista.Date;
    FDespacho.Registro.Qtde         := StrToFloatDEF(E_Quantidade.Text,0) - StrToFloatDef(E_Qtd_Baixar.Text,0);
    FDespacho.Registro.Pedido       := It_Cd_Pedido;
    FDespacho.Registro.Produto      := It_cd_Produto;
    FDespacho.Registro.Situacao     := 'P';
    FDespacho.Registro.Impresso     := 'N';
    FDespacho.Registro.Conferido    := 0;
    FDespacho.Insert;
  End;
end;

procedure TFr_Lanca_Despacho.E_Qtd_BaixarChange(Sender: TObject);
begin
  IF StrToFloatDef(E_Quantidade.Text,0) = StrToFloatDef(E_Qtd_Baixar.Text,0) THEN
    E_Data_Prevista.Enabled:=FALSE
  ELSE
   E_Data_Prevista.Enabled:=True;
end;


procedure TFr_Lanca_Despacho.E_Qtd_BaixarEnter(Sender: TObject);
begin
  E_Qtd_Baixar.SelectAll;
end;

end.
