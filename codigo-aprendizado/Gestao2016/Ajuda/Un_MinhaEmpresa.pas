unit Un_MinhaEmpresa;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Empresa, Data.DB, STQuery, Vcl.Menus, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.StdCtrls, QEdit_Setes, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, Un_Fm_ListaColaboradores,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFr_MinhaEmpresa = class(TFr_Empresa)
    tbs_Imagem: TTabSheet;
    ScrollBox1: TScrollBox;
    Label4: TLabel;
    Lb_Painel: TLabel;
    Label33: TLabel;
    Label39: TLabel;
    Sb_Logotipo_Grava: TSpeedButton;
    Sb_Logotipo_Exclui: TSpeedButton;
    Sb_LogoFrente_Grava: TSpeedButton;
    Sb_LogoFrente_Exclui: TSpeedButton;
    Sb_LogoDuplicata_Grava: TSpeedButton;
    Sb_LogoDuplicata_Exclui: TSpeedButton;
    Sb_LogoDesktop_Grava: TSpeedButton;
    Sb_LogoDesktop_Exclui: TSpeedButton;
    Label56: TLabel;
    Sb_MarcaDagua_Grava: TSpeedButton;
    Sb_MarcaDagua_Exclui: TSpeedButton;
    E_PathLogo: TEdit;
    E_PathPainel: TEdit;
    E_PathDuplicata: TEdit;
    E_PathFrentecaixa: TEdit;
    E_PathMarcaDagua: TEdit;
    OpenDialogo: TOpenDialog;
    RG_Tipo_Fat: TRadioGroup;
    Rg_Tipo_CRT: TGroupBox;
    Rb_Crt_1: TRadioButton;
    Rb_Crt_2: TRadioButton;
    Rb_Crt_3: TRadioButton;
    procedure Sb_Logotipo_GravaClick(Sender: TObject);
    procedure Sb_Logotipo_ExcluiClick(Sender: TObject);
    procedure Sb_LogoDesktop_GravaClick(Sender: TObject);
    procedure Sb_LogoDesktop_ExcluiClick(Sender: TObject);
    procedure Sb_LogoDuplicata_GravaClick(Sender: TObject);
    procedure Sb_LogoDuplicata_ExcluiClick(Sender: TObject);
    procedure Sb_LogoFrente_GravaClick(Sender: TObject);
    procedure Sb_LogoFrente_ExcluiClick(Sender: TObject);
    procedure Sb_MarcaDagua_GravaClick(Sender: TObject);
    procedure Sb_MarcaDagua_ExcluiClick(Sender: TObject);
    procedure Ds_EmpresaStateChange(Sender: TObject);

  private
    { Private declarations }

    procedure Pc_GravarImagens(Pc_Descricao: String;Pc_Path: String);
    function Pc_PreencherImagens(Pc_cd_Empresa: Integer;Pc_Descricao: String): String;
    procedure Pc_Cancela; Override;
    procedure Pc_GravarMinhaEmpresa;
  protected
    procedure Pc_Gravar; Override;
    procedure Pc_PreencheComDados;Override;
  public
    { Public declarations }
  end;

var
  Fr_MinhaEmpresa: TFr_MinhaEmpresa;

implementation

{$R *.dfm}

uses     Un_DM, UN_Principal, env, Un_Regra_Negocio;
procedure TFr_MinhaEmpresa.Pc_PreencheComDados;
Begin
  inherited;
  E_PathLogo.Text := Pc_PreencherImagens(Empresa.Registro.Codigo, 'LOGO');
  E_PathPainel.Text := Pc_PreencherImagens(Empresa.Registro.Codigo, 'PAINEL');
  E_PathDuplicata.Text := Pc_PreencherImagens(Empresa.Registro.Codigo, 'DUPLICATA');
  E_PathFrentecaixa.Text := Pc_PreencherImagens(Empresa.Registro.Codigo, 'FRENTECAIXA');
  E_PathMarcaDagua.Text := Pc_PreencherImagens(Empresa.Registro.Codigo, 'MARCADAGUA');
  E_Data.Date := Empresa.Registro.DataCadastro;

  RG_Tipo_Fat.ItemIndex := Empresa.Registro.TipoFaturamento;
  Rb_Crt_1.Checked := ( Empresa.Registro.CodigoRegimeTributario = 1);
  Rb_Crt_2.Checked := ( Empresa.Registro.CodigoRegimeTributario = 2);
  Rb_Crt_3.Checked := ( Empresa.Registro.CodigoRegimeTributario = 3);



End;

procedure TFr_MinhaEmpresa.Ds_EmpresaStateChange(Sender: TObject);
begin
  inherited;
  RG_Tipo_Fat.Enabled := ( ( EditionState = 'I' ) or ( EditionState = 'E' ) );
  Rg_Tipo_CRT.Enabled := ( ( EditionState = 'I' ) or ( EditionState = 'E' ));

end;

procedure TFr_MinhaEmpresa.Pc_Cancela;
begin
  inherited;
  RG_Tipo_Fat.ItemIndex := Empresa.Registro.TipoFaturamento;
  IF Empresa.Registro.CodigoRegimeTributario = 1 THEN
    Rb_Crt_1.Checked:= TRUE
  ELSE
  IF Empresa.Registro.CodigoRegimeTributario = 2 THEN
    Rb_Crt_2.Checked:= TRUE
  ELSE
  IF Empresa.Registro.CodigoRegimeTributario = 3 THEN
    Rb_Crt_3.Checked:= TRUE;
end;

procedure TFr_MinhaEmpresa.Pc_Gravar;
begin
  inherited;
  Pc_GravarMinhaEmpresa;
  Pc_AtivaEstabelecimento;
end;

procedure TFr_MinhaEmpresa.Pc_GravarImagens(Pc_Descricao: String;Pc_Path: String);
Var
  Lc_Qry: TSTQuery;
  Lc_Qry_Insere: TSTQuery;
  Lc_SqlTxt: String;
BEgin
  Lc_Qry := TSTQuery.Create(Self);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;


    Lc_Qry_Insere := TSTQuery.Create(Self);
    Lc_Qry_Insere.Database := DM.IBD_Gestao;
    Lc_Qry_Insere.Transaction := DM.IB_Transacao;
    Lc_Qry_Insere.ForcedRefresh := True;

    // Verifique se o registro já existe
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT * ' + 'FROM TB_IMG_EMPRESA ' +
      'WHERE (IMG_CODEMP =:IMG_CODEMP) AND (IMG_DESCRICAO =:IMG_DESCRICAO) ';
    SQL.Add(Lc_SqlTxt);
    ParamByName('IMG_CODEMP').AsInteger := Empresa.Registro.Codigo;
    ParamByName('IMG_DESCRICAO').AsString := Pc_Descricao;
    Active := True;
    FetchAll;
    If RecordCount = 0 then
    Begin
      if (Length(Pc_Path) > 0) then
      Begin
        // Inclui o registro
        Active := False;
        SQL.Clear;
        Lc_SqlTxt := 'insert into "TB_IMG_EMPRESA" ( ' +
          '   "IMG_CODIGO" ' +
          ' , "IMG_CODEMP" ' +
          ' , "IMG_DESCRICAO" ' +
          ' , "IMG_IMAGEM" ' +
          ' , "IMG_PATH" ) ' +
          ' values ( ' +
          '   :"IMG_CODIGO" ' +
          ' , :"IMG_CODEMP" ' +
          ' , :"IMG_DESCRICAO" ' +
          ' , :"IMG_IMAGEM"  ' +
          ' , :"IMG_PATH") ';
        Lc_Qry_Insere.SQL.Add(Lc_SqlTxt);
        Lc_Qry_Insere.ParamByName('IMG_CODIGO').AsInteger := 0; // Fc_Generator('GN_IMG_EMPRESA','TB_IMG_EMPRESA','IMG_CODIGO');
        Lc_Qry_Insere.ParamByName('IMG_CODEMP').AsInteger := Empresa.Registro.codigo;
        Lc_Qry_Insere.ParamByName('IMG_DESCRICAO').AsString := Pc_Descricao;
        Lc_Qry_Insere.ParamByName('IMG_IMAGEM').LoadFromFile(Pc_Path, ftBlob);
        Lc_Qry_Insere.ParamByName('IMG_PATH').AsString := Pc_Path;
        Lc_Qry_Insere.ExecSQL;
      end;
    end
    else
    Begin
      if (Length(Pc_Path) > 0) then
      Begin
        Active := False;
        SQL.Clear;
        Lc_SqlTxt := 'update "TB_IMG_EMPRESA"               ' +
          ' set                                  ' +
          '  "IMG_IMAGEM" = :"IMG_IMAGEM"        ' +
          ' , "IMG_PATH" = :"IMG_PATH"           ' +
          ' where IMG_DESCRICAO = :IMG_DESCRICAO ' +
          'and IMG_CODEMP=:IMG_CODEMP            ';

        Lc_Qry_Insere.SQL.Add(Lc_SqlTxt);
        Lc_Qry_Insere.ParamByName('IMG_DESCRICAO').AsString := Pc_Descricao;
        Lc_Qry_Insere.ParamByName('IMG_IMAGEM').LoadFromFile(Pc_Path, ftBlob);
        Lc_Qry_Insere.ParamByName('IMG_PATH').AsString := Pc_Path;
        Lc_Qry_Insere.ParamByName('IMG_CODEMP').AsInteger := Empresa.Registro.Codigo;
        Lc_Qry_Insere.ExecSQL;
      end
      else
      Begin
        Active := False;
        SQL.Clear;
        Lc_SqlTxt := 'DELETE FROM "TB_IMG_EMPRESA"        ' +
          ' where                              ' +
          '   "IMG_DESCRICAO" = :"IMG_DESCRICAO"     ';

        Lc_Qry_Insere.SQL.Add(Lc_SqlTxt);
        Lc_Qry_Insere.ParamByName('IMG_DESCRICAO').AsString := Pc_Descricao;
        Lc_Qry_Insere.ExecSQL;
      end;
    end;
    if (Pc_Descricao = 'PAINEL') then
    Begin
     Fc_BuscaImagemEmpresa(fr_principal.Img_Principal.Picture,'PAINEL');
    end;
  end;
  IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
  Lc_Qry.Close;
  Lc_Qry_Insere.Close;
  FreeAndNil(Lc_Qry);
  FreeAndNil(Lc_Qry_Insere);
end;

procedure TFr_MinhaEmpresa.Pc_GravarMinhaEmpresa;
begin
  Empresa.Registro.Tipo  := 0;
  Empresa.Registro.TipoFaturamento := RG_Tipo_Fat.ItemIndex ;
  if Rb_Crt_1.Checked then Empresa.Registro.CodigoRegimeTributario := 1;
  if Rb_Crt_2.Checked then Empresa.Registro.CodigoRegimeTributario := 2;
  if Rb_Crt_3.Checked then Empresa.Registro.CodigoRegimeTributario := 3;
  Empresa.salva;
end;

function TFr_MinhaEmpresa.Pc_PreencherImagens(Pc_cd_Empresa: Integer;Pc_Descricao: String): String;
Var
  Lc_Qry: TSTQuery;
  Lc_SqlTxt: String;
BEgin
  Lc_Qry := TSTQuery.Create(Self);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;


    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT IMG_PATH ' + 'FROM TB_IMG_EMPRESA ' +
      'WHERE (IMG_CODEMP =:IMG_CODEMP) AND (IMG_DESCRICAO =:IMG_DESCRICAO) ';
    SQL.Add(Lc_SqlTxt);
    ParamByName('IMG_CODEMP').AsInteger := Empresa.Registro.Codigo;
    ParamByName('IMG_DESCRICAO').AsString := Pc_Descricao;
    Active := True;
    FetchAll;
    Result := FieldByName('IMG_PATH').AsString;
  end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

procedure TFr_MinhaEmpresa.Sb_LogoDesktop_ExcluiClick(Sender: TObject);
begin
  E_PathPainel.Clear;
  Pc_GravarImagens('PAINEL', '');
end;

procedure TFr_MinhaEmpresa.Sb_LogoDesktop_GravaClick(Sender: TObject);
begin
  OpenDialogo.DefaultExt := '*.jpg';
  OpenDialogo.Filter :=
    'Arquivos de Imagens (*.jpg)|*.jpg|Arquivos JPG (*.JPG)|*.JPG|Todos os Arquivos (*.*)|*.*';
  if OpenDialogo.Execute then
  begin
    E_PathPainel.Text := OpenDialogo.FileName;
    Pc_GravarImagens('PAINEL', E_PathPainel.Text);
  end;
end;

procedure TFr_MinhaEmpresa.Sb_LogoDuplicata_ExcluiClick(Sender: TObject);
begin
  E_PathDuplicata.Clear;
  Pc_GravarImagens('DUPLICATA', '');
end;

procedure TFr_MinhaEmpresa.Sb_LogoDuplicata_GravaClick(Sender: TObject);
begin
  OpenDialogo.DefaultExt := '*.jpg';
  OpenDialogo.Filter :=
    'Arquivos de Imagens (*.jpg)|*.jpg|Arquivos JPG (*.JPG)|*.JPG|Todos os Arquivos (*.*)|*.*';
  if OpenDialogo.Execute then
  begin
    E_PathDuplicata.Text := OpenDialogo.FileName;
    Pc_GravarImagens('DUPLICATA', E_PathDuplicata.Text);
  end;

end;

procedure TFr_MinhaEmpresa.Sb_LogoFrente_ExcluiClick(Sender: TObject);
begin
  E_PathFrentecaixa.Clear;
  Pc_GravarImagens('FRENTECAIXA', '');
end;

procedure TFr_MinhaEmpresa.Sb_LogoFrente_GravaClick(Sender: TObject);
begin
  OpenDialogo.DefaultExt := '*.jpg';
  OpenDialogo.Filter :=
    'Arquivos de Imagens (*.jpg)|*.jpg|Arquivos JPG (*.JPG)|*.JPG|Todos os Arquivos (*.*)|*.*';
  if OpenDialogo.Execute then
  begin
    E_PathFrentecaixa.Text := OpenDialogo.FileName;
    Pc_GravarImagens('FRENTECAIXA', E_PathFrentecaixa.Text);
  end;

end;

procedure TFr_MinhaEmpresa.Sb_Logotipo_ExcluiClick(Sender: TObject);
begin
  E_PathLogo.Clear;
  Pc_GravarImagens('LOGO', '');
end;

procedure TFr_MinhaEmpresa.Sb_Logotipo_GravaClick(Sender: TObject);
begin
  OpenDialogo.DefaultExt := '*.jpg';
  OpenDialogo.Filter :=
    'Arquivos de Imagens (*.jpg)|*.jpg|Arquivos JPG (*.JPG)|*.JPG|Todos os Arquivos (*.*)|*.*';
  if OpenDialogo.Execute then
  begin
    E_PathLogo.Text := OpenDialogo.FileName;
    Pc_GravarImagens('LOGO', E_PathLogo.Text);
  end;
end;

procedure TFr_MinhaEmpresa.Sb_MarcaDagua_ExcluiClick(Sender: TObject);
begin
  E_PathMarcaDagua.Clear;
  Pc_GravarImagens('MARCADAGUA', '');

end;

procedure TFr_MinhaEmpresa.Sb_MarcaDagua_GravaClick(Sender: TObject);
begin
  OpenDialogo.DefaultExt := '*.jpg';
  OpenDialogo.Filter :=
    'Arquivos de Imagens (*.jpg)|*.jpg|Arquivos JPG (*.JPG)|*.JPG|Todos os Arquivos (*.*)|*.*';
  if OpenDialogo.Execute then
  begin
    E_PathMarcaDagua.Text := OpenDialogo.FileName;
    Pc_GravarImagens('MARCADAGUA', E_PathMarcaDagua.Text);
  end;

end;

end.


