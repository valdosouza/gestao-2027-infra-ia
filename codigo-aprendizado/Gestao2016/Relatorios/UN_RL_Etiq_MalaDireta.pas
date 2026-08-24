unit UN_RL_Etiq_MalaDireta;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, DB, STQuery, StdCtrls;

type
  TRL_Etiq_MalaDireta = class(TForm)
    Qrpt: TQuickRep;
    Qr_Etiqueta: TQRBand;
    Lb_Nome: TQRLabel;
    Lb_Endereco: TQRLabel;
    Lb_Cep: TQRLabel;
    Lb_Compl_bairro: TQRLabel;
    Qr_MalaDireta: TSTQuery;
    QRLabel1: TQRLabel;
    Qr_MalaDiretaEMP_CODIGO: TIntegerField;
    Qr_MalaDiretaEMP_TIPO: TIntegerField;
    Qr_MalaDiretaEMP_FANTASIA: TStringField;
    Qr_MalaDiretaEMP_NOME: TStringField;
    Qr_MalaDiretaEMP_DT_FUNDA: TDateField;
    Qr_MalaDiretaEMP_DT_CADASTRO: TDateField;
    Qr_MalaDiretaEND_ENDER: TStringField;
    Qr_MalaDiretaEND_CONTATO: TStringField;
    Qr_MalaDiretaEND_BAIRRO: TStringField;
    Qr_MalaDiretaEND_CEP: TStringField;
    Qr_MalaDiretaEND_COMPLEM: TStringField;
    Qr_MalaDiretaEND_NUMERO: TStringField;
    Qr_MalaDiretaCDD_DESCRICAO: TStringField;
    Qr_MalaDiretaUFE_SIGLA: TStringField;
    Lb_Impresso: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Qr_EtiquetaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    It_TipoEtiqueta : String;
    It_Qt_Etiqueta : String;
    It_Excecao : Boolean;
    It_Impresso : Boolean;
    procedure Pc_PosicionaCampos;
    procedure Pc_BuscarDestinario;
    procedure Pc_BuscarRemetente;
  end;

var
  RL_Etiq_MalaDireta: TRL_Etiq_MalaDireta;

implementation

uses     Un_Maladireta, UN_Sistema, Un_Principal, env;
{$R *.dfm}


procedure TRL_Etiq_MalaDireta.Pc_BuscarDestinario;
  var
  SqlTxt : string;
  Lc_I,Lc_J : Integer;
  Lc_Str_Excecao : String;
  Lc_Bln_Excecao : Boolean;
begin
  SqlTxt := '';
  Screen.Cursor:=crHourGlass;
  Qr_MalaDireta.Close;
  Qr_MalaDireta.Sql.Clear;
  Lc_Bln_Excecao:= TRUE;

  Sqltxt :='SELECT EMP_CODIGO, EMP_TIPO, EMP_FANTASIA, EMP_NOME, EMP_DT_FUNDA, EMP_DT_CADASTRO, END_ENDER, '+
           'END_BAIRRO, END_CEP, CDD_DESCRICAO, UFE_SIGLA, END_CONTATO, END_COMPLEM, END_NUMERO '+
           'FROM TB_EMPRESA tb_empresa '+
           '  INNER JOIN TB_ENDERECO tb_endereco '+
           '  ON(tb_endereco.END_CODEMP =  tb_empresa.EMP_CODIGO) '+
           '  INNER JOIN TB_CIDADE TB_CIDADE '+
           '  ON TB_CIDADE.CDD_CODIGO = TB_ENDERECO.END_CODCDD '+
           '  INNER JOIN tb_uf TB_uf  ON tb_uf.ufe_codigo = TB_ENDERECO.end_codufe '+
           'WHERE  (EMP_CODIGO IS not NULL) AND (END_PRINCIPAL = ''S'') ';

  if Lc_Bln_Excecao then
    Begin
    Lc_Str_Excecao := 'AND (EMP_CODIGO IN (';
    Lc_J := 0;
    For Lc_I := 0 to Fr_Maladireta.ChLBx_Nomes.Items.Count -1 do
      Begin
      if Fr_Maladireta.It_codigos[0,Lc_I] = 1 then
        Begin
        if Lc_j = 0 then
          begin
          Lc_Str_Excecao := Lc_Str_Excecao + IntToStr(Fr_Maladireta.It_codigos[1,Lc_I]);
          Inc(LC_j);
          end
        else
          Begin
          Lc_Str_Excecao := Lc_Str_Excecao + ','+IntToStr(Fr_Maladireta.It_codigos[1,Lc_I])
          end;
        end;
      end;
    sqltxt := sqltxt + Lc_Str_Excecao +')) ';
    end;


  Qr_MalaDireta.SQL.Add (SqlTxt+ 'ORDER BY EMP_FANTASIA ');

  Qr_MalaDireta.Active := True;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Etiq_MalaDireta.Pc_BuscarRemetente;
var
  SqlTxt : string;
begin
  Screen.Cursor:=crHourGlass;
  WITH Qr_MalaDireta DO
    Begin
    Close;
    Sql.Clear;
    Sqltxt :='SELECT First '+ It_Qt_Etiqueta + ' EMP_CODIGO, EMP_TIPO, EMP_FANTASIA, EMP_NOME, EMP_DT_FUNDA, EMP_DT_CADASTRO, '+
             'END_ENDER,  END_CONTATO, END_BAIRRO, END_CEP, CDD_DESCRICAO, UFE_SIGLA, END_COMPLEM, END_NUMERO '+
             ' FROM TB_EMPRESA tb_empresa '+
             '   INNER JOIN TB_ENDERECO tb_endereco '+
             '   ON(tb_endereco.END_CODEMP =  tb_empresa.EMP_CODIGO) '+
             '   INNER JOIN TB_CIDADE TB_CIDADE '+
             '  ON TB_CIDADE.CDD_CODIGO = TB_ENDERECO.END_CODCDD '+
             '  INNER JOIN tb_uf TB_uf  ON tb_uf.ufe_codigo = TB_ENDERECO.end_codufe '+
             '  left outer join tb_produto '+
             '  on (PRO_CODMHA = tb_empresa.EMP_CODIGO) '+
             ' WHERE EMP_CODIGO =:EMP_CODIGO ';

    SQL.Add (SqlTxt+ 'ORDER BY EMP_FANTASIA ');
    ParamByName('EMP_CODIGO').AsInteger := Gb_CodMha;
    Active := True;
    end;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Etiq_MalaDireta.Pc_PosicionaCampos;
Var
  Lc_topo : Integer;
Begin
  Lc_topo := 2;
  Lb_Nome.Top := Lc_topo;
  Lc_topo := Lc_topo + Lb_Nome.Height;
  Lb_Endereco.Top := Lc_topo;
  Lc_topo := Lc_topo + Lb_Endereco.Height;
  Lb_Compl_bairro.Top := Lc_topo;
  Lc_topo := Lc_topo + Lb_Compl_bairro.Height;
  Lb_Cep.Top := Lc_topo;
  Lc_topo := Lc_topo + Lb_Cep.Height;
  Lb_Impresso.Top := Lc_topo;
end;

procedure TRL_Etiq_MalaDireta.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  //Configura Etiqueta
  Qrpt.Page.Length:=Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_PG_ALTURA').AsFloat;
  Qrpt.Page.Width:=Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_PG_LARGURA').AsFloat;

  Qrpt.Page.TopMargin:=Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_SUPERIOR').AsFloat;
  Qrpt.Page.BottomMargin:=Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_INFERIOR').AsFloat;

  Qrpt.Page.ColumnSpace:=Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_DIS_COLUNA').AsFloat;
  Qrpt.Page.Columns:=Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_NR_COLUNA').AsInteger;

  Qrpt.Page.LeftMargin:=Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_ESQUERA').AsFloat;
  Qrpt.Page.RightMargin:=Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_DIREITA').AsFloat;
  Qr_Etiqueta.Size.Height:=Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_ET_ALTURA').AsFloat;
  Qr_Etiqueta.Size.Width:=Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_ET_LARGURA').AsFloat;

  Lb_Nome.Font.Size:=Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger;
  Lb_Endereco.Font.Size:=Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger;
  Lb_Compl_bairro.Font.Size:=Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger;
  Lb_Cep.Font.Size:=Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger;
  if It_Impresso then
    Begin
    Lb_Impresso.Font.Color := clBlack;
    Lb_Impresso.Font.Size:=Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger;
    end
  else
    Begin
    Lb_Impresso.Font.Color := clWhite;
    Lb_Impresso.Font.Size:=Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_SIZEFONTE').AsInteger;
    end;


  Qrpt.Font.Name := Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_TYPEFONTE').AsVariant;
 Lb_Nome.Font.Name := Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_TYPEFONTE').AsVariant;
  Lb_Endereco.Font.Name := Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_TYPEFONTE').AsVariant;
{  Lb_BairroCidadeUF.Name := Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_TYPEFONTE').AsVariant;
  Lb_Cep.Font.Name := Fr_Maladireta.Qr_Etiqueta.FieldByName('CGE_TYPEFONTE').AsVariant;
}
  Pc_PosicionaCampos;
  if (It_TipoEtiqueta = 'Remetente') then
    Pc_BuscarRemetente
  else
    Pc_BuscarDestinario;
end;

procedure TRL_Etiq_MalaDireta.Qr_EtiquetaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Nome.Caption := Qr_MalaDiretaEMP_NOME.AsString;
  Lb_Endereco.Caption := Qr_MalaDiretaEND_ENDER.AsString + ', ' + Qr_MalaDiretaEND_NUMERO.AsString;
  if Length(Qr_MalaDiretaEND_COMPLEM.AsString) > 0 then
    Begin
    Lb_Compl_bairro.Caption := Qr_MalaDiretaEND_COMPLEM.AsString +' - ' +  Qr_MalaDiretaEND_BAIRRO.AsString;
    Lb_Cep.Caption := Qr_MalaDiretaCDD_DESCRICAO.AsString + ' -  '+Qr_MalaDiretaUFE_SIGLA.AsString+' - CEP: ' + Fc_MascaraCep(Qr_MalaDiretaEND_CEP.AsString);
    end
  else
    Begin
    Lb_Compl_bairro.Caption := Qr_MalaDiretaEND_BAIRRO.AsString  + ' -  '+Qr_MalaDiretaCDD_DESCRICAO.AsString + ' - '+Qr_MalaDiretaUFE_SIGLA.AsString;
    Lb_Cep.Caption := 'CEP: ' + Fc_MascaraCep(Qr_MalaDiretaEND_CEP.AsString);
    end;

  QRLabel1.Caption := '';
  
end;

procedure TRL_Etiq_MalaDireta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action := Cafree;
  RL_Etiq_MalaDireta := Nil;
end;

end.
