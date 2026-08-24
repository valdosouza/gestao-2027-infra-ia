unit Un_GF_VendasOrigemVenda;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, ExtCtrls, Buttons, StdCtrls, jpeg, pngimage, Un_JPEGImageExt;

type
  TGF_VendasOrigemVenda = class(TForm)
    Qr_Venda: TSTQuery;
    Panel1: TPanel;
    Sb_Sair_0: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_ExportarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    it_Ch_Periodo : Boolean;
    It_Dt_Ini : String;
    It_Dt_Fim : String;
    It_Cd_Vendedor : String;
    It_VL_Total: Currency;
    procedure Pc_Buscar;
    procedure Pc_SomaVendas;
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_ExportarGrafico;
    procedure BMP_To_JPEG(BMPFName,JPEGFName : string); 
  end;

var
  GF_VendasOrigemVenda: TGF_VendasOrigemVenda;

implementation

uses     Un_DM, UN_Sistema, env;
{$R *.dfm}

procedure TGF_VendasOrigemVenda.BMP_To_JPEG(BMPFName,JPEGFName : string);
var
  MyJPEG : TJPEGImage;
  MyBitmap : TBitmap;
begin
  try
    MyJPEG := TJPEGImage.Create;
    MyBitmap := TBitmap.Create;
    MyBitmap.LoadFromFile(BMPFName);
    MyJPEG.Assign(MyBitmap);
    MyJPEG.SaveToFile(JPEGFName);
  finally
    FreeAndNil(MyBitmap);
    FreeAndNil(MyJPEG);
  end;
end;

procedure TGF_VendasOrigemVenda.Pc_Buscar;
Var
  Lc_SqlTxt : String;
Begin
  with Qr_Venda do
    Begin
    Active := false;
    sql.Clear;
    Lc_SqlTxt := 'select clb_nome, DESCRIPTION,SUM(tb_nota_fiscal.nfl_vl_tl_nota) '+
                 'from tb_nota_fiscal '+
                 '  inner join tb_pedido '+
                 '  on (ped_codigo = nfl_codped) '+
                 '  inner join tb_colaborador '+
                 '  on (clb_codigo = ped_codvdo) '+
                 '  INNER JOIN tb_sale_origen '+
                 '  ON (ID = PED_TP_CONTATO) '+
                 'where (description is not null) ';
    if (it_Ch_Periodo) then
      Lc_SqlTxt := Lc_SqlTxt + 'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ';

    if (Trim(It_Cd_Vendedor) <> '') then
      Lc_SqlTxt := Lc_SqlTxt + 'AND (PED_CODVDO =:PED_CODVDO) ';

    Lc_SqlTxt := Lc_SqlTxt +' GROUP BY 1,2';

    sql.Add(Lc_SqlTxt);

    if (it_Ch_Periodo) then
      Begin
      ParamByName('DATAINI').AsString := It_Dt_Ini;
      ParamByName('DATAFIM').AsString := It_Dt_Fim;
      end;

    if (Trim(It_Cd_Vendedor) <> '') then
      ParamByName('PED_CODVDO').AsString := It_Cd_Vendedor;

    Active := True;
    end;
end;

procedure TGF_VendasOrigemVenda.Pc_SomaVendas;
Begin
  with Qr_Venda do
    Begin
    It_VL_Total := 0;
    while not eof do
      Begin
      It_VL_Total := It_VL_Total + FieldByName('SUM').AsFloat;
      next;
      end;
    end;
end;

procedure TGF_VendasOrigemVenda.Pc_FormataTela;
Begin



end;

procedure TGF_VendasOrigemVenda.Pc_IniciaVariaveis;
Begin
  Pc_Buscar;
  Pc_SomaVendas;
  {
  Gr_Venda.Title.Text.Clear;
  if Trim(It_Cd_Vendedor) <> '' then
    Gr_Venda.Title.Text.Add(Qr_Venda.fieldByName('CLB_NOME').AsString + ' - ' + FloatToStrF(It_VL_Total,ffFixed,10,2))
  else
    Gr_Venda.Title.Text.Add('Vendas totais - ' + FloatToStrF(It_VL_Total,ffFixed,10,2));
  }
end;

procedure TGF_VendasOrigemVenda.Pc_ExportarGrafico;
Begin
  //grava o Arquivo
  //Gr_Venda.SaveToBitmapFile(GbPathExe + 'Temp\Grafico.bmp');
  BMP_To_JPEG(GbPathExe + 'Temp\Grafico.bmp',GbPathExe + 'Temp\Grafico.jpg');
  DeleteFile(GbPathExe + 'Temp\Grafico.bmp');
  Pc_Executar_Arquivo(GbPathExe + 'Temp\Grafico.jpg');
end;

procedure TGF_VendasOrigemVenda.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TGF_VendasOrigemVenda.FormShow(Sender: TObject);
begin
  Pc_IniciaVariaveis;
  Pc_FormataTela;
end;



procedure TGF_VendasOrigemVenda.Sb_ExportarClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Pc_ExportarGrafico;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;    
end;

procedure TGF_VendasOrigemVenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F8     : if Sb_Exportar.Enabled then Sb_ExportarClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
    end;
  end;
end;

end.
