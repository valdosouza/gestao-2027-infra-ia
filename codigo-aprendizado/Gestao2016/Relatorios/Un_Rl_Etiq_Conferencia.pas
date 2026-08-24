unit Un_Rl_Etiq_Conferencia;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, DB, STQuery, StdCtrls, QRPrntr;

type
  TRl_Etiq_Conferencia = class(TForm)
    Qrpt: TQuickRep;
    Qr_DestinatarioPedido: TSTQuery;
    Qr_DestinatarioPedidoPED_DATA: TDateField;
    Qr_DestinatarioPedidoPED_CODEMP: TIntegerField;
    Qr_DestinatarioPedidoPED_CODVDO: TIntegerField;
    Qr_DestinatarioPedidoCDD_DESCRICAO: TStringField;
    Qr_DestinatarioPedidoUFE_SIGLA: TStringField;
    Qr_DestinatarioPedidoEND_CEP: TStringField;
    Qr_DestinatarioPedidoEMP_NOME: TStringField;
    Qr_DestinatarioPedidoNFL_NUMERO: TStringField;
    Qr_Etiqueta: TSTQuery;
    Qr_EtiquetaCGE_CODIGO: TIntegerField;
    Qr_EtiquetaCGE_DESCRICAO: TStringField;
    Qr_EtiquetaCGE_PG_ALTURA: TBCDField;
    Qr_EtiquetaCGE_PG_LARGURA: TBCDField;
    Qr_EtiquetaCGE_SUPERIOR: TBCDField;
    Qr_EtiquetaCGE_INFERIOR: TBCDField;
    Qr_EtiquetaCGE_DIREITA: TBCDField;
    Qr_EtiquetaCGE_ESQUERA: TBCDField;
    Qr_EtiquetaCGE_ET_ALTURA: TBCDField;
    Qr_EtiquetaCGE_ET_LARGURA: TBCDField;
    Qr_EtiquetaCGE_DIS_COLUNA: TBCDField;
    Qr_EtiquetaCGE_TYPEFONTE: TStringField;
    Qr_EtiquetaCGE_SIZEFONTE: TIntegerField;
    Qr_EtiquetaCGE_PAGESIZE: TStringField;
    Qr_EtiquetaCGE_NR_COLUNA: TBCDField;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QrptNeedData(Sender: TObject; var MoreData: Boolean);
  private
    { Private declarations }
    iT_Etiqueta : TQRBand;
    It_Linha_1 : TQRLabel;
    It_Linha_2 : TQRLabel;
    It_Linha_3 : TQRLabel;
    It_Linha_4 : TQRLabel;
    It_Linha_5 : TQRLabel;
    It_Linha_6 : TQRLabel;
    It_Linha_7 : TQRLabel;
  public
    { Public declarations }
    //Numero de Etiquetas e repetições
    It_Repeticao : Integer;
    It_cd_Etiqueta : Integer;
    It_Cd_Pedido : Integer;
    It_Nr_Etiquetas : integer;
    It_Nr_Envios : integer;


    procedure Pc_configuraEtiqueta;
    procedure Pc_Buscar;
  end;

var
  Rl_Etiq_Conferencia: TRl_Etiq_Conferencia;

implementation

uses      UN_Sistema, CheckLst, Un_DM, Un_Regra_Negocio;
{$R *.dfm}


procedure TRl_Etiq_Conferencia.Pc_Buscar;
  var
  SqlTxt : string;
  Lc_Empresa : boolean;
  Lc_registro : Integer;
  Lc_I, Lc_J : Integer;
  Lc_Str_Excecao : String;
  Lc_Bln_Excecao : Boolean;
begin
  SqlTxt := '';
  Screen.Cursor:=crHourGlass;
  Qr_DestinatarioPedido.Close;
  Qr_DestinatarioPedido.Sql.Clear;

  Sqltxt :='SELECT '+
           ' PED_DATA, '+
           ' PED_CODEMP, '+
           ' PED_CODVDO,' +
           ' CDD_DESCRICAO , '+
           ' UFE_SIGLA, '+
           ' END_CEP, '+
           ' EMP_NOME, '+
           ' NFL_NUMERO '+
           ' FROM TB_NOTA_FISCAL tb_nota_fiscal '+
           '   INNER JOIN TB_PEDIDO tb_pedido '+
           '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
           '   INNER  JOIN TB_ENDERECO tb_endereco '+
           '   ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND) '+
           '   INNER JOIN TB_CIDADE tb_cidade '+
           '   ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD) '+
           '   INNER JOIN TB_UF tb_uf '+
           '   ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE) '+
           '   INNER JOIN TB_EMPRESA tb_empresa '+
           '   ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)  '+
           'WHERE PED_CODIGO=:PED_CODIGO ';

  Qr_DestinatarioPedido.SQL.Add (SqlTxt);
  Qr_DestinatarioPedido.ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
  Qr_DestinatarioPedido.Active := True;
  Qr_DestinatarioPedido.FetchAll;
  Qr_DestinatarioPedido.First;
  Screen.Cursor:=crDefault;
end;


procedure TRl_Etiq_Conferencia.Pc_configuraEtiqueta;
Var
  Lc_I:Integer;
Begin
  Qr_Etiqueta.Active := False;
  Qr_Etiqueta.ParamByName('CGE_CODIGO').AsInteger := It_cd_Etiqueta;
  Qr_Etiqueta.Active := True;
  iT_Etiqueta := TQRBand.Create(Qrpt);
  iT_Etiqueta.BandType := rbDetail;
  iT_Etiqueta.Parent := Qrpt;
  iT_Etiqueta.ForceNewPage:=tRUE;
  //PAgina
  Qrpt.Page.PaperSize := Custom;
  Qrpt.Prepare;
  Qrpt.Page.Length := Qr_EtiquetaCGE_PG_ALTURA.AsFloat;
  Qrpt.Page.Width  := Qr_EtiquetaCGE_PG_LARGURA.AsFloat;

  Qrpt.Page.TopMargin := Qr_EtiquetaCGE_SUPERIOR.AsFloat;
  Qrpt.Page.BottomMargin := Qr_EtiquetaCGE_INFERIOR.AsFloat;

  Qrpt.Page.ColumnSpace := Qr_EtiquetaCGE_DIS_COLUNA.AsFloat;
  Qrpt.Page.Columns := Qr_EtiquetaCGE_NR_COLUNA.AsInteger;

  Qrpt.Page.LeftMargin := Qr_EtiquetaCGE_ESQUERA.AsFloat;
  Qrpt.Page.RightMargin := Qr_EtiquetaCGE_DIREITA.AsFloat;
  //Etiqueta
  It_Etiqueta.Size.Height := Qr_EtiquetaCGE_ET_ALTURA.AsFloat;
  It_Etiqueta.Size.Width := Qr_EtiquetaCGE_ET_LARGURA.AsFloat;

  It_Linha_1 := TQRLabel.Create(iT_Etiqueta);
  It_Linha_1.Parent := It_Etiqueta;
  It_Linha_1.AutoSize := False;
  It_Linha_1.AutoStretch := False;
  It_Linha_1.Size.Width := Qr_EtiquetaCGE_ET_LARGURA.AsFloat;
  It_Linha_1.Refresh;
  It_Linha_1.Repaint;

  It_Linha_2 := TQRLabel.Create(iT_Etiqueta);
  It_Linha_2.Parent := It_Etiqueta;
  It_Linha_2.AutoSize := False;
  It_Linha_2.AutoStretch := False;
  It_Linha_2.Size.Width := Qr_EtiquetaCGE_ET_LARGURA.AsFloat;
  It_Linha_2.Refresh;
  It_Linha_2.Repaint;

  It_Linha_3 := TQRLabel.Create(iT_Etiqueta);
  It_Linha_3.Parent := It_Etiqueta;
  It_Linha_3.AutoSize := False;
  It_Linha_3.AutoStretch := False;
  It_Linha_3.Size.Width := Qr_EtiquetaCGE_ET_LARGURA.AsFloat;
  It_Linha_3.Refresh;
  It_Linha_3.Repaint;

  It_Linha_4 := TQRLabel.Create(iT_Etiqueta);
  It_Linha_4.Parent := It_Etiqueta;
  It_Linha_4.AutoSize := False;
  It_Linha_4.AutoStretch := False;
  It_Linha_4.Size.Width := Qr_EtiquetaCGE_ET_LARGURA.AsFloat;
  It_Linha_4.Refresh;
  It_Linha_4.Repaint;

  It_Linha_5 := TQRLabel.Create(iT_Etiqueta);
  It_Linha_5.Parent := It_Etiqueta;
  It_Linha_5.AutoSize := False;
  It_Linha_5.AutoStretch := False;
  It_Linha_5.Size.Width := Qr_EtiquetaCGE_ET_LARGURA.AsFloat;
  It_Linha_5.Refresh;
  It_Linha_5.Repaint;

  It_Linha_6 := TQRLabel.Create(iT_Etiqueta);
  It_Linha_6.Parent := It_Etiqueta;
  It_Linha_6.AutoSize := False;
  It_Linha_6.AutoStretch := False;
  It_Linha_6.Size.Width := Qr_EtiquetaCGE_ET_LARGURA.AsFloat;
  It_Linha_6.Refresh;
  It_Linha_6.Repaint;

  It_Linha_7 := TQRLabel.Create(iT_Etiqueta);
  It_Linha_7.Parent := It_Etiqueta;
  It_Linha_7.AutoSize := False;
  It_Linha_7.AutoStretch := False;
  It_Linha_7.Size.Width := Qr_EtiquetaCGE_ET_LARGURA.AsFloat;
  It_Linha_7.Refresh;
  It_Linha_7.Repaint;

  It_Linha_1.Font.Size := Qr_EtiquetaCGE_SIZEFONTE.AsInteger + 2;
  It_Linha_2.Font.Size := Qr_EtiquetaCGE_SIZEFONTE.AsInteger;
  It_Linha_3.Font.Size := Qr_EtiquetaCGE_SIZEFONTE.AsInteger;
  It_Linha_4.Font.Size := Qr_EtiquetaCGE_SIZEFONTE.AsInteger;
  It_Linha_5.Font.Size := Qr_EtiquetaCGE_SIZEFONTE.AsInteger;
  It_Linha_6.Font.Size := Qr_EtiquetaCGE_SIZEFONTE.AsInteger;
  It_Linha_7.Font.Size := Qr_EtiquetaCGE_SIZEFONTE.AsInteger;


  It_Linha_1.Font.Name := Qr_EtiquetaCGE_TYPEFONTE.AsVariant;
  It_Linha_1.Top := 2;
  It_Linha_1.Alignment := taLeftJustify;
  It_Linha_1.AlignToBand := True;
  It_Linha_1.Caption := 'A';
  It_Linha_1.Refresh;

  It_Linha_2.Font.Name := Qr_EtiquetaCGE_TYPEFONTE.AsVariant;
  It_Linha_2.Alignment := taLeftJustify;
  It_Linha_2.AlignToBand := True;
  It_Linha_2.Caption := 'A';
  It_Linha_2.Top := It_Linha_1.Top + It_Linha_1.Height + 1;
  It_Linha_2.Refresh;


  It_Linha_3.Font.Name := Qr_EtiquetaCGE_TYPEFONTE.AsVariant;
  It_Linha_3.Alignment := taLeftJustify;
  It_Linha_3.AlignToBand := True;
  It_Linha_3.Caption := 'A';
  It_Linha_3.Top := It_Linha_2.Top + It_Linha_2.Height + 1;
  It_Linha_3.Refresh;

  It_Linha_4.Font.Name := Qr_EtiquetaCGE_TYPEFONTE.AsVariant;
  It_Linha_4.Alignment := taLeftJustify;
  It_Linha_4.AlignToBand := True;
  It_Linha_4.Caption := 'A';
  It_Linha_4.Top := It_Linha_3.Top + It_Linha_3.Height + 1;
  It_Linha_4.Refresh;

  It_Linha_5.Font.Name := Qr_EtiquetaCGE_TYPEFONTE.AsVariant;
  It_Linha_5.Alignment := taLeftJustify;
  It_Linha_5.AlignToBand := True;
  It_Linha_5.Caption := 'A';
  It_Linha_5.Top := It_Linha_4.Top + It_Linha_4.Height + 1;
  It_Linha_5.Refresh;

  It_Linha_6.Font.Name := Qr_EtiquetaCGE_TYPEFONTE.AsVariant;
  It_Linha_6.Alignment := taLeftJustify;
  It_Linha_6.AlignToBand := True;
  It_Linha_6.Caption := 'A';
  It_Linha_6.Top := It_Linha_5.Top + It_Linha_5.Height + 1;
  It_Linha_6.Refresh;

  It_Linha_7.Font.Name := Qr_EtiquetaCGE_TYPEFONTE.AsVariant;
  It_Linha_7.Alignment := taLeftJustify;
  It_Linha_7.AlignToBand := True;
  It_Linha_7.Caption := 'A';
  It_Linha_7.Top := It_Linha_6.Top + It_Linha_6.Height + 1;
  It_Linha_7.Refresh;

end;

procedure TRl_Etiq_Conferencia.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_configuraEtiqueta;
  Pc_Buscar;
end;

procedure TRl_Etiq_Conferencia.QrptNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  Pc_AtivaEstabelecimento;
  It_Linha_1.Caption := DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString ;
  It_Linha_2.Caption := 'Volume  : ' + IntToStr(It_Repeticao) +'/'+ IntToStr(It_Nr_Etiquetas) ;
  It_Linha_3.Caption := 'Cliente : ' + Qr_DestinatarioPedidoPED_CODEMP.AsString + ' NF: '+ Qr_DestinatarioPedidoNFL_NUMERO.AsString;
  It_Linha_4.Caption := 'Represe : ' + Qr_DestinatarioPedidoPED_CODVDO.AsString;
  It_Linha_5.Caption := 'Cidade  : ' + Qr_DestinatarioPedidoCDD_DESCRICAO.AsString + '-' + Qr_DestinatarioPedidoUFE_SIGLA.AsString;
  It_Linha_6.Caption := 'Cep     : ' + Fc_MascaraCep(Qr_DestinatarioPedidoEND_CEP.AsString);
  It_Linha_7.Caption := Qr_DestinatarioPedidoEMP_NOME.AsString;
  MoreData := It_Repeticao <= It_Nr_Etiquetas ;
  inc(It_Repeticao);
  if MoreData then Next;

end;

end.
