unit UN_RL_Listagem_Empresa;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_Listagem_Empresa = class(TForm)
    Qr_listagem: TSTQuery;
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    e_BAirro: TQRDBText;
    QRBand2: TQRBand;
    Lb_Empresa: TQRLabel;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    QRSysData3: TQRSysData;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand4: TQRBand;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    Lb_Tipo_Emp: TQRLabel;
    Lb_Nome_Emp: TQRLabel;
    Lb_Cidade: TQRLabel;
    Lb_Brro: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    QRLabel0: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    QRLabel1: TQRLabel;
    Lb_Localizacao: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel4: TQRLabel;
    Lb_Dt_Ultima_Compra: TQRLabel;
    QRLabel15: TQRLabel;
    Lb_Sm_Vendedor: TQRLabel;
    QRLabel16: TQRLabel;
    Lb_Sm_RamoAtividade: TQRLabel;
    QRDBText3: TQRDBText;
    E_Dt_Ultima_Compra: TQRDBText;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Qr_listagemCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Dt_Ultima_Compra : Boolean;
    procedure Pc_Busca;
    procedure Pc_Parametros;
    procedure Pc_FormataTela;
  end;

var
  RL_Listagem_Empresa: TRL_Listagem_Empresa;

implementation

uses     Un_DM, UN_Imp_Empresas, DBCtrls, Un_Excel, UN_Sistema, Un_Funcoes, UN_MSG, StdCtrls, Un_Regra_Negocio;
{$R *.dfm}



procedure TRL_Listagem_Empresa.Pc_Busca;
Var
  Lc_SqlTxt: String;
  Lc_TipoEmpresa: String;
  Lc_Cliente,Lc_Cidade, Lc_Vendedor,Lc_Bairro,Lc_Ramo:Boolean;
Begin
  with Fr_Imp_Empresa do
  Begin
    Qr_Listagem.SQL.Clear;
    Lc_SqlTxt := CONCAT('SELECT EMP_CODIGO, EMP_NOME, EMP_TIPO, EMP_FANTASIA, END_FONE, ',
                        ' END_FAX, END_CELULAR,	END_COMERCIAL,	END_PORTARIA, END_BAIRRO,',
                        ' emp_email,EMP_DT_ULT_MOV, END_PRINCIPAL ',
                        'FROM TB_EMPRESA '
                  );

              case Cb_Empresa.ItemIndex of
                -10:Begin
                      //Todas as empresas
                    end;
                0:Begin
                     //Estabelecimeto minha empresa
                  end;
                1:Begin
                    Lc_Sqltxt :=  Lc_Sqltxt + '  INNER JOIN TB_CLIENTE '+
                                              '  ON (CLI_CODEMP = EMP_CODIGO) ';

                  end;
                2:Begin
                    Lc_Sqltxt :=  Lc_Sqltxt + '  INNER JOIN TB_FORNECEDOR '+
                                              '  ON (FOR_CODEMP = EMP_CODIGO) ';
                  end;
                3:Begin
                    Lc_Sqltxt :=  Lc_Sqltxt + '  INNER JOIN TB_TRANSPORTADORA '+
                                              '  ON (TRP_CODEMP = EMP_CODIGO) ';
                  end;
                4:Begin
                  //Banco por enquanton não precisa Inner
                  end;
                5:Begin
                  //Não definido
                  end;
                6:Begin
                  //Não definido
                  end;
                7:Begin
                  //Não definido
                  end;
                8:Begin
                  //Cliente em prospeção não precisa inner
                  end;
                9:Begin
                  //Contabilidade não precisa inner
                  end;
              end;

              case Rg_Localidade.ItemIndex of
                0:Begin
                  Lc_SqlTxt := Lc_SqlTxt +
                  '  INNER JOIN TB_ENDERECO '+
                  '  ON (TB_ENDERECO.END_CODEMP = TB_EMPRESA.EMP_CODIGO) '+
                  '  INNER JOIN TB_CIDADE tb_cidade '+
                  '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD) '+
                  '  INNER JOIN TB_UF tb_uf '+
                  '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE) '+
                  'WHERE EMP_CODIGO IS NOT NULL ';
                  end;
                1:Begin
                  Lc_SqlTxt := Lc_SqlTxt +
                  '  LEFT OUTER JOIN TB_ENDERECO '+
                  '  ON (TB_ENDERECO.END_CODEMP = TB_EMPRESA.EMP_CODIGO) '+
                  '  INNER JOIN TB_CIDADE tb_cidade '+
                  '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD) '+
                  '  INNER JOIN TB_UF tb_uf '+
                  '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE) '+
                  'WHERE END_CODIGO IS NULL ';
                  end;
                2:Begin
                  Lc_SqlTxt := Lc_SqlTxt +   
                  '  LEFT OUTER JOIN TB_ENDERECO '+
                  '  ON (TB_ENDERECO.END_CODEMP = TB_EMPRESA.EMP_CODIGO) '+
                  '  LEFT OUTER JOIN TB_CIDADE tb_cidade '+
                  '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD) '+
                  '  LEFT OUTER JOIN TB_UF tb_uf '+
                  '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE) '+
                  'WHERE EMP_CODIGO IS NOT NULL ';
                  end;
                end;

    case rg_Movimentacao.ItemIndex of
      0: Lc_SqlTxt := Lc_SqlTxt + ' AND (EMP_DT_ULT_MOV BETWEEN :DATAINI AND :DATAFIM ) ';
      1: Lc_SqlTxt := Lc_SqlTxt + ' AND (EMP_DT_ULT_MOV not BETWEEN :DATAINI AND :DATAFIM ) ';
    end;

    
    if (DBLCB_Empresa.Text ='')THEN Lc_Cliente := False else Lc_Cliente := True;
    if (DBLCB_CIDADE.Text ='') THEN Lc_Cidade := False else Lc_Cidade := True;
    if (DBLCB_Bairro.Text ='') THEN Lc_Bairro := False else Lc_Bairro := True;
    if (DBLCB_Vendedor.Text ='')THEN Lc_Vendedor := False else Lc_Vendedor := True;
    if (Dblcb_RamoAtividade.Text ='')THEN Lc_Ramo := False else Lc_Ramo := True;

    if Lc_Cliente  then Lc_SqlTxt := Lc_SqlTxt +'AND (EMP_CODIGO =:EMP_CODIGO) ';
    if Lc_Cidade   then Lc_SqlTxt := Lc_SqlTxt +'AND (CDD_DESCRICAO =:CDD_DESCRICAO) ';
    if Lc_Bairro   then Lc_SqlTxt := Lc_SqlTxt +'AND (END_BAIRRO =:END_BAIRRO) ';
    if Lc_Vendedor then Lc_SqlTxt := Lc_SqlTxt +'AND (EMP_CODVDOR =:EMP_CODVDOR) ';
    if Lc_Ramo then Lc_SqlTxt := Lc_SqlTxt +'AND (TB_RAMO_ATIVIDADE_ID =:EMP_RAM_ATIV) ';
    if ChBx_email.Checked then Lc_SqlTxt := Lc_SqlTxt +' AND ( (EMP_EMAIL IS NOT NULL) AND (EMP_EMAIL <> '''') ) ';

    if ChBx_Nome.Checked then
      Qr_Listagem.SQL.Add(Lc_SqlTxt +'ORDER BY EMP_NOME ')
    else
      Qr_Listagem.SQL.Add(Lc_SqlTxt +'ORDER BY EMP_FANTASIA ');

    if ( rg_Movimentacao.ItemIndex < 2) then
    BEGIN
      Qr_Listagem.ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      Qr_Listagem.ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    END;
            
    if Lc_Cliente then (Qr_Listagem.ParamByName('EMP_CODIGO').AsInteger := DBLCB_Empresa.KeyValue);
    if Lc_Cidade then (Qr_Listagem.ParamByName('CDD_DESCRICAO').AsString := DBLCB_CIDADE.Text);
    if Lc_Bairro then (Qr_Listagem.ParamByName('END_BAIRRO').AsString := DBLCB_Bairro.Text);
    if Lc_Vendedor then (Qr_Listagem.ParamByName('EMP_CODVDOR').AsInteger := DBLCB_Vendedor.KeyValue);
    if Lc_Ramo then (Qr_Listagem.ParamByName('EMP_RAM_ATIV').Value := Dblcb_RamoAtividade.KeyValue);
    
    Qr_Listagem.Open;
    Screen.Cursor:=crDefault;
    end;
end;
procedure TRL_Listagem_Empresa.Pc_FormataTela;
Begin
  if It_Dt_Ultima_Compra then
    Begin
    Lb_Dt_Ultima_Compra.Font.Color := clBlack;
    E_Dt_Ultima_Compra.Font.Color := clBlack;
    E_BAirro.Width := 174;
    end
  else
    Begin
    Lb_Dt_Ultima_Compra.Font.Color := clWhite;
    E_Dt_Ultima_Compra.Font.Color := clWhite;
    E_BAirro.Width := 272;
    end;
end;

procedure TRL_Listagem_Empresa.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_FormataTela;
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Listagem_Empresa.Qr_listagemCalcFields(DataSet: TDataSet);
begin
  if It_Dt_Ultima_Compra then
    DataSet.FieldByName('DT_ULTIMA_COMPRA').AsString := Fc_Dt_Ultima_Compra(Qr_listagem.FieldByname('EMP_CODIGO').asinteger)
  Else
    DataSet.FieldByName('DT_ULTIMA_COMPRA').AsString := '';

  DataSet.FieldByName('END_FONE_MASK').AsString := fc_MascaraFone(Qr_Listagem.FieldByname('END_FONE').AsString)
end;

procedure TRL_Listagem_Empresa.Pc_Parametros;
begin
  with Fr_Imp_Empresa do
    begin
    // Verifica o tipo de empresa
    case Cb_Empresa.ItemIndex of
      0 : Lb_Tipo_Emp.Caption := 'Minha Empresa';
      1 : Lb_Tipo_Emp.Caption := 'Clientes';
      2 : Lb_Tipo_Emp.Caption := 'Fornecedores';
      3 : Lb_Tipo_Emp.Caption := 'Transportadoras';
      4 : Lb_Tipo_Emp.Caption := 'Bancos';
    end;
    // Verifica o tipo dO Relatorio
    case Cb_Tipo.ItemIndex of
      0 : Lb_Tipo_Rl.Caption := 'Listagem';
      1 : Lb_Tipo_Rl.Caption := 'Cadastro';
    end;
    // Verifica se o campo empresa foi preenchido
    if trim(DBLCB_Empresa.Text) = '' then
      Lb_Nome_Emp.Caption := 'Todos'
    else
      Lb_Nome_Emp.Caption := DBLCB_Empresa.Text;
    // Verifica o nome da Cidade
    if DBLCB_Cidade.text = '' then
      Lb_Cidade.Caption := 'Todos'
    else
      Lb_Cidade.Caption := DBLCB_Cidade.Text;
    // Verifica nome do Bairro
    if DBLCB_Bairro.Text = '' then
      Lb_Brro.Caption := 'Todos'
    else
      Lb_Brro.Caption := DBLCB_Bairro.Text;
    // Verificar o nome do Vendedor
    if trim(DBLCB_Vendedor.Text) = '' then
      Lb_Sm_Vendedor.Caption := 'Todos'
    else
      Lb_Sm_Vendedor.Caption := DBLCB_Vendedor.Text;

    // Verificar o Ramo Atividade
    if trim(Dblcb_RamoAtividade.Text) = '' then
      Lb_Sm_RamoAtividade.Caption := 'Todos'
    else
      Lb_Sm_RamoAtividade.Caption := Dblcb_RamoAtividade.Text;

    // Verifica qual localização cliente
    case Rg_Localidade.ItemIndex of
    0 : Lb_Localizacao.Caption := 'Apenas com Endereço';
    1 : Lb_Localizacao.Caption := 'Apenas sem Endereço';
    2 : Lb_Localizacao.Caption := 'Tanto Faz';
    end;
    // Verifica data de Inatividade da empresa solicitada
    if rg_Movimentacao.ItemIndex < 2 then
      begin
      Lb_Data_Ini.Caption := DateToStr( E_Data_Ini.Date);
      Lb_Data_Fim.Caption := DateToStr( E_Data_Fim.Date);
      end
    else
      begin
      QRLabel0.Font.Color := clWhite;
      QRLabel12.Font.Color := clWhite;
      QRLabel13.Font.Color := clWhite;
      Lb_Data_Ini.Font.Color := clWhite;
      Lb_Data_Fim.Font.Color := clWhite;
      end;
    end;
end;
end.

