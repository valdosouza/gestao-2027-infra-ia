unit Un_RL_ReportBudget_12;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportBudget, Data.DB, STQuery, QuickRpt, QRCtrls, Vcl.ExtCtrls, Un_DM, UN_Sistema, Vcl.Imaging.pngimage, ControllerItensObs;

type
  TRL_ReportBudget_12 = class(TRL_ReportBudget)
    QRShape1: TQRShape;
    Lb_Item: TQRLabel;
    StrB_Produto_DEtalhe: TQRSubDetail;
    E_Detalhe: TQRMemo;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape6: TQRShape;
    QRShape8: TQRShape;
    QRLabel2: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel19: TQRLabel;
    QRShape12: TQRShape;
    QRLabel20: TQRLabel;
    Lb_Detalhe: TQRLabel;
    Shp_Detalhe: TQRShape;
    procedure cabecalho;Override;
    procedure Buscar; Override;
    Procedure PreencheProdutos;Override;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ItemNR : Integer;
    ItemObs : TControllerItensObs;

  protected
    procedure IniciaVariaveis;Override;
    procedure PreecheDetalhe;Override;
    Procedure ValidaProdutos(Pc_Print : Boolean);Override;
  public
    { Public declarations }
  end;

var
  RL_ReportBudget_12: TRL_ReportBudget_12;

implementation

{$R *.dfm}

procedure TRL_ReportBudget_12.Buscar;
begin
  //A Consulta é fixa no componente
end;

procedure TRL_ReportBudget_12.cabecalho;
Var
  Lc_Aux : String;
begin
  inherited;
  WITH DM.Qr_Estabelecimento DO
  Begin
    Lc_Aux := '';
    if (trim(FieldByName('END_FONE').AsString) <> '') then
      Lc_Aux := fc_MascaraFone(FieldByName('END_FONE').AsString);

    if (Trim(Lc_Aux) <> '') and (trim(FieldByName('END_CELULAR').AsString) <> '') then
      Lc_Aux := Lc_Aux + ' / ' + fc_MascaraFone(FieldByName('END_CELULAR').AsString)
    else
      if (trim(FieldByName('END_CELULAR').AsString) <> '') then
        Lc_Aux := fc_MascaraFone(FieldByName('END_CELULAR').AsString);

    if (Trim(Lc_Aux) <> '') and (trim(FieldByName('END_COMERCIAL').AsString) <> '') then
      Lc_Aux := Lc_Aux + ' / ' + fc_MascaraFone(FieldByName('END_COMERCIAL').AsString)
    else
      if (trim(FieldByName('END_COMERCIAL').AsString) <> '') then
        Lc_Aux := fc_MascaraFone(FieldByName('END_COMERCIAL').AsString);
    Lb_Emp_Fones.Caption :=  'Fones: ' + Lc_Aux;
  End;

end;


procedure TRL_ReportBudget_12.FormCreate(Sender: TObject);
begin
  inherited;
  ItemObs := TControllerItensObs.create(Self);
end;

procedure TRL_ReportBudget_12.IniciaVariaveis;
begin
  inherited;
  CabProduto := False;
  //Retira uma linha por que o cabecalho foi alterado
  StrB_Produto.Items.Delete(StrB_Produto.Items.Count-1);
end;

procedure TRL_ReportBudget_12.PreecheDetalhe;
begin
  inherited;
  ItemObs.clear;
  ItemObs.Registro.ItemOrcamento := Qr_ItensPro.FieldByName('CODIGO').AsInteger;
  ItemObs.getbyId;
  if ItemObs.exist then
  Begin
    E_Detalhe.Lines.Text := ItemObs.Registro.Detalhe;
    StrB_Produto_DEtalhe.Height := E_Detalhe.Height + 3;

  End
  else
  Begin
    StrB_Produto_DEtalhe.Height := 0;
  End;
  StrB_Produto_DEtalhe.Repaint;
  StrB_Produto_DEtalhe.Refresh;

end;

procedure TRL_ReportBudget_12.PreencheProdutos;
begin
  inherited;
  with Qr_ItensPro do
  Begin
    inc(ItemNR);
    Lb_Item.Caption := IntToStr( ItemNR  );
  End;

end;

procedure TRL_ReportBudget_12.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  DefineImpressora;
  IniciaVariaveis;
  Buscar;
  cabecalho;
  CustomerGroup;

end;

procedure TRL_ReportBudget_12.ValidaProdutos(Pc_Print: Boolean);
begin
  inherited;
  if Pc_Print then
  BEgin
    Lb_Detalhe.Font.Style := [];
    Lb_Detalhe.Alignment := taLeftJustify;
    Lb_Detalhe.Font.Color := clBlack;

    E_Detalhe.Font.Style := [];
    E_Detalhe.Alignment := taLeftJustify;
    E_Detalhe.Font.Color := clBlack;
  end
  else
  BEgin
    E_Detalhe.Font.Color := clWhite;
    E_Detalhe.Font.Color := clWhite;
    E_Detalhe.Font.Color := clWhite;

    E_Detalhe.Font.Color := clWhite;
    E_Detalhe.Font.Color := clWhite;
    E_Detalhe.Font.Color := clWhite;

  end;
end;

end.
