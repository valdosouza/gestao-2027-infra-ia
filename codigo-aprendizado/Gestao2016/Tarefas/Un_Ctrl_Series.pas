unit Un_Ctrl_Series;

interface

uses
      Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, ComCtrls, Buttons, Grids, DBGrids, jpeg, STQuery, Variants, Un_Fm_ListaProdutos;

type
  TFr_Ctrl_Serie = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    SB_Sair_0: TSpeedButton;
    SB_Buscar: TSpeedButton;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Label11: TLabel;
    E_Pedido: TMaskEdit;
    Label1: TLabel;
    E_Nota: TMaskEdit;
    E_NumeroSerie: TMaskEdit;
    Label2: TLabel;
    Dbg_Pesquisa: TDBGrid;
    Qr_Series: TSTQuery;
    Ds_Series: TDataSource;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    Cb_Empresa: TComboBox;
    Qr_Empresa: TSTQuery;
    Qr_Produtos: TSTQuery;
    Fm_ListaProdutos: TFm_ListaProdutos;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_BuscarClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure Pc_FormataTela;
    procedure FormShow(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure Dbg_PesquisaTitleClick(Column: TColumn);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pc_Cb_Empresa;
    procedure Pc_Buscar;
    procedure Pc_ImagemBotao;
  end;

var
  Fr_Ctrl_Serie: TFr_Ctrl_Serie;

implementation

uses     Un_DM, Un_Produtos, UN_Sistema, UN_MSG, RN_Permissao, UN_Principal, env, Un_Regra_Negocio;
{$R *.DFM}


procedure TFr_Ctrl_Serie.Pc_CB_Empresa;
vAR
  Lc_SqlTxt : String;
Begin
  Lc_SqlTxt := 'SELECT EMP_CODIGO, EMP_FANTASIA, EMP_NOME '+
               'FROM TB_EMPRESA ';

  if ChBx_Nome.Checked     then Lc_SqlTxt := Lc_SqlTxt + 'ORDER BY EMP_NOME ';
  if ChBx_Fantasia.Checked then Lc_SqlTxt := Lc_SqlTxt + 'ORDER BY EMP_FANTASIA ';

  Qr_Empresa.Active := False;
  Qr_Empresa.SQL.Clear;
  Qr_Empresa.SQL.Add(Lc_SqlTxt);
  Qr_Empresa.Active := true;
  Cb_Empresa.Clear;
  Qr_Empresa.First;
  while not Qr_Empresa.Eof do
    Begin
    Cb_Empresa.Items.Add(Qr_Empresa.FieldByName('EMP_FANTASIA').AsString);
    Qr_Empresa.Next;
    end;
end;


procedure TFr_Ctrl_Serie.Pc_FormataTela;
Begin
  Pc_Cb_Empresa;
  E_Pedido.Clear;
  E_Nota.Clear;
  E_Data_Ini.Date:=Date;
  E_Data_Fim.Date:=Date;
end;

procedure TFr_Ctrl_Serie.FormClose(Sender: TObject;
var
    Action: TCloseAction);
begin
  Action:=caFree;
  Fr_Ctrl_Serie:=Nil;
end;

procedure TFr_Ctrl_Serie.Pc_Buscar;
var
  Lc_Sqltxt :string;
  Lc_Pedido, Lc_Nota,Lc_Empresa, Lc_Codpro, Lc_Produto, Lc_Serie :boolean;
begin
  Screen.Cursor:=crHourGlass;
  Lc_Sqltxt := '';
  Qr_Series.Active := false;
  Qr_Series.sql.Clear;

  if E_Pedido.Text       = '' Then Lc_Pedido   := False else Lc_Pedido   := True;
  if E_Nota.Text         = '' Then Lc_Nota     := False else Lc_Nota     := True;
  if Cb_Empresa.Text     = '' Then Lc_Empresa  := False else Lc_Empresa  := True;
  if Fm_ListaProdutos.E_Cd_Produto.Text       = '' then Lc_Codpro   := false else Lc_Codpro   := true;
  if Fm_ListaProdutos.E_Busca_Produto.Text    = '' then Lc_Produto  := false else Lc_Produto  := true;
  if E_NumeroSerie.Text  = '' then Lc_Serie    := false else Lc_Serie    := true;

  Lc_Sqltxt := 'SELECT SRP_CODIGO, SRP_NUMERO, PRO_CODIGOFAB,PRO_DESCRICAO,           '+
               'tb_entrada.PED_TIPO PED_ORIGEM, tb_entrada.PED_NUMERO PED_ENTRADA,    '+
               'tb_nf_entrada.NFL_DT_EMISSAO SRP_DT_ENTRADA,                          '+
               ' tb_nf_entrada.NFL_NUMERO NFL_ENTRADA,                                '+
               '                                                                      '+
               ' tb_saida.PED_TIPO PED_DESTINO, tb_saida.PED_NUMERO PED_SAIDA,        '+
               ' tb_nf_saida.NFL_DT_EMISSAO SRP_DT_SAIDA,                             '+
               ' tb_nf_saida.NFL_NUMERO NFL_SAIDA                                     '+
               ' FROM TB_SERIE_PRODUTO tb_serie                                       '+
               '    INNER JOIN TB_PRODUTO tb_produto                                  '+
               '   ON (tb_produto.PRO_CODIGO = tb_serie.SRP_CODPRO)                   '+
               '                                                                      '+
               '    LEFT OUTER JOIN tb_itens_nfl tb_itensentrada                      '+
               '    ON (tb_itensentrada.itf_codigo = tb_serie.srp_codent)             '+
               '    LEFT OUTER JOIN TB_PEDIDO tb_entrada                              '+
               '    ON (tb_entrada.ped_codigo = tb_itensentrada.ITF_CODPED)           '+
               '    LEFT OUTER JOIN TB_NOTA_FISCAL tb_nf_entrada                      '+
               '    ON (tb_nf_entrada.NFL_CODPED = tb_entrada.PED_CODIGO)             '+
               '                                                                      '+
               '    LEFT OUTER JOIN tb_itens_nfl tb_itenssaida                        '+
               '    ON (tb_itenssaida.itf_codigo = tb_serie.srp_codsai)               '+
               '    LEFT OUTER JOIN TB_PEDIDO tb_saida                                '+
               '    ON (tb_saida.ped_codigo = tb_itenssaida.ITF_CODPED)               '+
               '    LEFT OUTER JOIN TB_NOTA_FISCAL tb_nf_saida                        '+
               '    ON (tb_nf_saida.NFL_CODPED = tb_saida.PED_CODIGO)                 '+
               'WHERE (SRP_CODIGO IS NOT NULL)                                        ';


  if Lc_Pedido or Lc_Nota then
  Begin
    if Lc_Pedido then Lc_Sqltxt := Lc_Sqltxt +'AND ((tb_entrada.PED_NUMERO =:PED_NUMERO) OR (tb_saida.PED_NUMERO =:PED_NUMERO)) ';
    if Lc_Nota   then Lc_Sqltxt := Lc_Sqltxt +'AND ((tb_nf_entrada.NFL_NUMERO =:NFL_NUMERO) OR (tb_nf_saida.NFL_NUMERO =:NFL_NUMERO)) ';
  end
  else
  Begin
    if ChBx_Periodo.Checked then Lc_Sqltxt := Lc_Sqltxt +'AND ( (tb_nf_entrada.NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ) '+
                                                         ' OR   (tb_nf_saida.NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ) )';
    if Lc_Empresa then Lc_Sqltxt := Lc_Sqltxt +'AND ((EMP_NOME LIKE :EMP_NOME) or (EMP_FANTASIA LIKE :EMP_FANTASIA) ) ';


    if Trim(Fm_ListaProdutos.E_Cd_Produto.Text) <> '' then
    Begin
      IF (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S') then
      Begin
        If StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0) >0 then
        Begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGO =:PRO_CODIGO) or (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO) ) ';
        end
        else
        begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO) ) ';
        end;
      end
      else
      Begin
        If StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0) >0 then
        Begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGO LIKE :PRO_CODIGO) or (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) ) ';
        end
        else
        begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) ) ';
        end;
      end;
    end;





    if Lc_Produto then Lc_Sqltxt := Lc_Sqltxt+' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';
    if Lc_Serie then Lc_Sqltxt := Lc_Sqltxt+ ' AND (SRP_NUMERO LIKE :SRP_NUMERO) ';
  end;
    
  Qr_Series.SQL.Add(Lc_Sqltxt+' ORDER BY PRO_DESCRICAO ');

  if Lc_Pedido or Lc_Nota then
    Begin
    if Lc_Pedido then  Qr_Series.ParamByName('PED_NUMERO').AsString:= E_Pedido.Text;
    if Lc_Nota then  Qr_Series.ParamByName('NFL_NUMERO').AsString:=E_Nota.Text;
    end
  else
    Begin
    if ChBx_Periodo.Checked then
      Begin
      Qr_Series.ParamByName('DATAINI').AsDate:=E_Data_Ini.date;
      Qr_Series.ParamByName('DATAFIM').AsDate:=E_Data_Fim.date;
      end;
      
    if Lc_Empresa then Qr_Series.ParamByName('EMP_NOME').AsString:='%'+Cb_Empresa.Text+'%';

    if Trim(Fm_ListaProdutos.E_Cd_Produto.Text) <> '' then
    Begin
      IF (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S') then
      Begin
        Qr_Series.ParamByName('PRO_CODIGO').AsString := Fm_ListaProdutos.E_Cd_Produto.Text;
      end
      else
      Begin
        Qr_Series.ParamByName('PRO_CODIGO').AsString := '%' + Fm_ListaProdutos.E_Cd_Produto.Text + '%';
      end;
    End;
    if Lc_Produto then Qr_Series.ParamByName('PRO_DESCRICAO').AsString := '%'+Copy(Fm_ListaProdutos.E_Busca_Produto.Text,1,98)+'%';
    if Lc_Serie then Qr_Series.ParamByName('SRP_NUMERO').AsString := '%' + E_NumeroSerie.Text + '%';
    end;

  Qr_Series.Active:=true;

  Screen.Cursor:=crDefault;
end;


procedure TFr_Ctrl_Serie.SB_Sair_0Click(Sender: TObject);
begin
    Close;
end;

procedure TFr_Ctrl_Serie.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;

end;

procedure TFr_Ctrl_Serie.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
      case Key of
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
      end;
    end;
end;
procedure TFr_Ctrl_Serie.SB_BuscarClick(Sender: TObject);
begin
  Pc_Buscar;
end;

procedure TFr_Ctrl_Serie.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Ctrl_Serie.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_ImagemBotao;
end;

procedure TFr_Ctrl_Serie.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Buscar.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Ctrl_Serie.ChBx_NomeClick(Sender: TObject);
begin
  IF ChBx_Nome.Checked THEN
    Begin
    ChBx_Fantasia.Checked := False;
    Pc_Cb_Empresa;
    end;
end;

procedure TFr_Ctrl_Serie.ChBx_FantasiaClick(Sender: TObject);
begin
  IF ChBx_Fantasia.Checked THEN
    Begin
    ChBx_Nome.Checked := False;
    Pc_Cb_Empresa;
    end;
end;

procedure TFr_Ctrl_Serie.Dbg_PesquisaTitleClick(Column: TColumn);
begin
   Pc_Pintar_Grid_Ordenar(Dbg_Pesquisa, Column);
end;

end.
