unit UN_RL_CurvaABC;

interface

uses
      Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, Qrctrls, QuickRpt, ExtCtrls, STQuery, Grids, DBGrids;

type
  TRL_CurvaABC = class(TForm)
    Qrpt: TQuickRep;
    Dtl_Produto: TQRBand;
    QRDBText2: TQRDBText;
    Rdp_Produto: TQRBand;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    Bnd_Titulo: TQRBand;
    QRLabel10: TQRLabel;
    Lb_Titulo: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel7: TQRLabel;
    Qr_ABC: TSTQuery;
    Grp_SubGrupo: TQRGroup;
    Grp_Grupo: TQRGroup;
    Grp_Produto: TQRGroup;
    QRDBText5: TQRDBText;
    Lb_MES1: TQRLabel;
    Lb_Resultado: TQRLabel;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    Lb_MES2: TQRLabel;
    Lb_MES3: TQRLabel;
    Lb_MES4: TQRLabel;
    Lb_MES5: TQRLabel;
    Lb_MES6: TQRLabel;
    Lb_6Mes: TQRLabel;
    QRLabel9: TQRLabel;
    Lb_Saldo: TQRLabel;
    Lb_5Mes: TQRLabel;
    Lb_4Mes: TQRLabel;
    Lb_3Mes: TQRLabel;
    Lb_2Mes: TQRLabel;
    Lb_1Mes: TQRLabel;
    DataSource1: TDataSource;
    QRLabel6: TQRLabel;
    QRLabel5: TQRLabel;
    Lb_sugestao: TQRLabel;
    QRDBText7: TQRDBText;
    Qr_Produtos: TSTQuery;
    Lb_Minimo: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText6: TQRDBText;
    QRBand1: TQRBand;
    QRLabel4: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel20: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Estoque: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Tab_Preco: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Ordenacao: TQRLabel;
    QRLabel22: TQRLabel;
    Lb_Gerar_Invent: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel19: TQRLabel;
    Lb_Grupo: TQRLabel;
    QRLabel23: TQRLabel;
    Lb_Subgrupo: TQRLabel;
    QRLabel24: TQRLabel;
    Lb_Marca: TQRLabel;
    QRLabel25: TQRLabel;
    Lb_Empresa: TQRLabel;
    QRLabel27: TQRLabel;
    Lb_Estoq_Min: TQRLabel;
    QRLabel28: TQRLabel;
    Lb_Saldo_Positivo: TQRLabel;
    QRLabel29: TQRLabel;
    Lb_Inativos: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Dtl_ProdutoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Rdp_ProdutoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Rdp_ProdutoAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    It_MesFinal   : Integer;
    It_MesInicial : Integer;
    It_AnoInicial : Integer;
    It_AnoFinal : Integer;
    It_Contador:Integer;
    It_MesAnoQtde:Array[1..6,1..3] of real;
    It_Soma : Real;
    It_Minimo : Real;
    It_Maximo : Real;
  public
    { Public declarations }
  It_Nr_Meses : Integer;
  It_Linha : Integer;
  It_Cd_Estoque : Integer;
  procedure Pc_LimitesData;
  procedure Pc_LabelData;
  procedure Pc_Buscar;
  procedure Pc_Parametros;
  end;

var
  RL_CurvaABC: TRL_CurvaABC;

implementation

uses     UN_Imp_Produtos, Un_DM, Un_Funcoes, UN_Sistema, DBCtrls, UN_Principal, env, Un_Regra_Negocio, RN_Estoque;
{$R *.DFM}



procedure TRL_CurvaABC.Pc_LimitesData;
begin
  with Fr_Imp_Produtos do
    Begin
    It_AnoFinal := StrToInt(Copy(DateToStr(E_Data_Fim.Date),7,4));
    It_MesFinal := StrToInt(Copy(DateToStr(E_Data_Fim.Date),4,2));
    if ( (It_MesFinal - 5) >= 1) then
      Begin
      It_MesInicial := (It_MesFinal - 5);
      It_AnoInicial := It_AnoFinal;
      end
    else
      Begin
      It_MesInicial := 12 + (It_MesFinal - 5);
      It_AnoInicial := It_AnoFinal - 1;
      end;
    end;
end;

procedure TRL_CurvaABC.Pc_LabelData;
Var
  Lc_I:Integer;

begin
  for Lc_I:=0 to 5 do
    Begin
    if ((It_MesInicial + Lc_I) <= 12) then
      begin
      It_MesAnoQtde[Lc_I+1,1] := It_MesInicial + Lc_I;
      It_MesAnoQtde[Lc_I+1,2] := It_AnoInicial;
      end
    else
      Begin
      It_MesAnoQtde[Lc_I+1,1] := (It_MesInicial + Lc_I) - 12 ;
      It_MesAnoQtde[Lc_I+1,2] := It_AnoFinal;
      end;
    end;

  Lb_1Mes.Caption := FloatToStr(It_MesAnoQtde[1,1]) + '/' + FloatToStr(It_MesAnoQtde[1,2]);
  Lb_2Mes.Caption := FloatToStr(It_MesAnoQtde[2,1]) + '/' + FloatToStr(It_MesAnoQtde[2,2]);
  Lb_3Mes.Caption := FloatToStr(It_MesAnoQtde[3,1]) + '/' + FloatToStr(It_MesAnoQtde[3,2]);
  Lb_4Mes.Caption := FloatToStr(It_MesAnoQtde[4,1]) + '/' + FloatToStr(It_MesAnoQtde[4,2]);
  Lb_5Mes.Caption := FloatToStr(It_MesAnoQtde[5,1]) + '/' + FloatToStr(It_MesAnoQtde[5,2]);
  Lb_6Mes.Caption := FloatToStr(It_MesAnoQtde[6,1]) + '/' + FloatToStr(It_MesAnoQtde[6,2]);
end;

procedure TRL_CurvaABC.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(QRPT);
  Action:=caFree;
  RL_CurvaABC:=Nil;
end;

procedure TRL_CurvaABC.Pc_Buscar;
Var
  sqltxt:String;
  Lc_Grupo, Lc_SubGrupo,Lc_Marca, Lc_Fornecedor, Lc_Produto: Boolean;
  Lc_I:Integer;
  Lc_Str_Excecao : String;
begin
  with Fr_Imp_Produtos do
    Begin
    Screen.Cursor:=crHourGlass;
    Pc_LimitesData;
    Pc_LabelData;
    It_Cd_Estoque := 0;
    It_Contador:=0;
    if DBLCB_Empresa.Text= '' then
      Begin
      Lb_Titulo.Caption :='Curva ABC';
      end
    else
      Begin
      Lb_Titulo.Caption :='Curva ABC - '+DBLCB_Empresa.Text;
      end;

    Qr_ABC.SQL.Clear;
    sqltxt:='SELECT ABC_CODPRO,ABC_CODFAB, ABC_CODFOR, ABC_DESCRIPRODUTO, '+
            'ABC_CUSTO , ABC_MINIMO, ABC_DESCRIGRUPO, ABC_DESCRISUBGRUPO, '+
            'ABC_DATA, SUM( ABC_QTDE) ABC_SQTDE '+
            'FROM VW_CURVAABC Vw_curvaabc    '+
            'WHERE ((ABC_DATA=:1MES) OR      '+
            '       (ABC_DATA=:2MES) OR      '+
            '       (ABC_DATA=:3MES) OR      '+
            '       (ABC_DATA=:4MES) OR      '+
            '       (ABC_DATA=:5MES) OR      '+
            '       (ABC_DATA=:6MES)) ';

    if (Trim(Fm_ListaEstoques.DBLCB_Estoque.Text) <> '') then
      Begin
      sqltxt := sqltxt +  ' AND (ABC_CODEST=:ABC_CODEST) ';
      It_Cd_Estoque := Fm_ListaEstoques.DBLCB_Estoque.KeyValue;
      end;

    if Trim(DBLCB_Grupos.Text)='' then Lc_Grupo:=false else Lc_Grupo:=true;
    if Trim(DBLCB_SubGrupos.Text)='' then Lc_SubGrupo:=false else Lc_SubGrupo:=true;
    if Trim(DBLCB_Marca.Text) ='' then Lc_Marca := False else Lc_Marca := True;
    if Trim(DBLCB_Empresa.Text)='' then Lc_Fornecedor:=false else Lc_Fornecedor:=true;
    if Trim(E_BuscaDescricaoProduto.Text)='' then Lc_Produto:=false else Lc_Produto:=true;

    if Lc_Grupo then sqltxt:=sqltxt+'AND (ABC_DESCRIGRUPO =:DESCRIGRUPO) ';
    if Lc_SubGrupo then sqltxt:=sqltxt+'AND (ABC_DESCRISUBGRUPO =:DESCRISUBGRUPO) ';
    if Lc_Marca then SqlTxt := SqlTxt +'AND (ABC_CODMARC =:ABC_CODMARC) ';
    if Lc_Produto then SqlTxt := SqlTxt +'AND (ABC_DESCRIPRODUTO LIKE :ABC_DESCRIPRODUTO) ';
    if Lc_Fornecedor then
      Begin
      Qr_Produtos.Active := False;
      Qr_Produtos.ParamByName('NFL_CODEMP').AsInteger := DBLCB_Empresa.KeyValue;
      Qr_Produtos.Active := true;
      Qr_Produtos.FetchAll;
      Qr_Produtos.First;
      if Qr_Produtos.RecordCount > 0 then
        Begin
        Lc_Str_Excecao := 'AND (ABC_CODPRO IN (';

        while not Qr_Produtos.Eof do
          Begin
          if Qr_Produtos.Bof then
            Lc_Str_Excecao := Lc_Str_Excecao + Qr_Produtos.FieldByname('PRO_CODIGO').AsString
          else
            Lc_Str_Excecao := Lc_Str_Excecao + ','+Qr_Produtos.FieldByname('PRO_CODIGO').AsString;
          Qr_Produtos.Next;
          end;

        sqltxt:= sqltxt + Lc_Str_Excecao +')) ';
        end;
      end;
    sqltxt:=sqltxt+'GROUP BY ABC_CODPRO, ABC_CODFAB, ABC_CODFOR, ABC_DESCRIPRODUTO, ABC_CUSTO , ABC_MINIMO,  ABC_DESCRIGRUPO, ABC_DESCRISUBGRUPO, ABC_DATA ';

    if CB_Ordena.ItemIndex = 0 then
      sqltxt := sqltxt+ 'ORDER BY ABC_DESCRIGRUPO, ABC_DESCRISUBGRUPO, ABC_DESCRIPRODUTO, ABC_CODPRO,ABC_DATA asc '
    else
      sqltxt := sqltxt+ 'ORDER BY ABC_DESCRIGRUPO, ABC_DESCRISUBGRUPO,  ABC_CODPRO, ABC_DESCRIPRODUTO, ABC_DATA asc ';



    Qr_ABC.SQL.Add(sqltxt);

    for Lc_I := 1 to 6 do
      Begin
      Qr_ABC.ParamByName(IntToStr(Lc_I)+'MES').AsString := FloatToStr(It_MesAnoQtde[Lc_I,2]) + '/' + FloatToStr(It_MesAnoQtde[Lc_I,1]);
      End;
    if (Trim(Fm_ListaEstoques.DBLCB_Estoque.Text) <> '') then
      Qr_ABC.ParamByName('ABC_CODEST').AsInteger := It_Cd_Estoque;
    if Lc_Grupo then Qr_ABC.ParamByName('DESCRIGRUPO').AsString:=DBLCB_Grupos.Text;
    if Lc_Subgrupo then Qr_ABC.ParamByName('DESCRISUBGRUPO').AsString:=DBLCB_SubGrupos.Text;
    if Lc_Marca then Qr_ABC.ParamByName('ABC_CODMARC').AsInteger:=DBLCB_Marca.KeyValue;
    if Lc_Produto then Qr_ABC.ParamByName('ABC_DESCRIPRODUTO').AsString := '%' + E_BuscaDescricaoProduto.Text + '%';

    Qr_ABC.Active:=true;
    It_minimo:=-1;
    It_Maximo:=Qr_ABC.FieldByname('ABC_SQTDE').AsFloat;
    Screen.Cursor:=crDefault;
    end;
end;

procedure TRL_CurvaABC.Dtl_ProdutoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  LC_I:Integer;
begin
  IF It_minimo=-1 THEN It_minimo:=Qr_ABC.FieldByname('ABC_SQTDE').AsFloat;
  IF It_Maximo=-1 THEN It_minimo:=Qr_ABC.FieldByname('ABC_SQTDE').AsFloat;
  It_contador := It_contador + 1;
  For LC_I:=1 to 6 do
    begin
    if ((FloatToStr(It_MesAnoQtde[LC_I,2]) + '/' + FloatToStr(It_MesAnoQtde[LC_I,1]))= Fc_RemoveEspacos(Qr_ABC.FieldByname('ABC_DATA').AsString)) then
      begin
      It_MesAnoQtde[LC_I,3]:=Qr_ABC.FieldByname('ABC_SQTDE').AsFloat
      end
    end;
    It_Soma:=It_Soma+Qr_ABC.FieldByname('ABC_SQTDE').AsFloat;
    if (Qr_ABC.FieldByname('ABC_SQTDE').AsFloat=0) THEN It_minimo:=0;

  IF (Qr_ABC.FieldByname('ABC_SQTDE').AsFloat<It_minimo)then
      It_minimo:=Qr_ABC.FieldByname('ABC_SQTDE').AsFloat;

    if It_Maximo<Qr_ABC.FieldByname('ABC_SQTDE').AsFloat then
      It_Maximo:=Qr_ABC.FieldByname('ABC_SQTDE').AsFloat;
end;

procedure TRL_CurvaABC.Rdp_ProdutoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_Qt_Abc : Real;
  Lc_Sld_Estoque : Real;
begin
  inc(It_Linha);
  if (It_Linha mod 2) = 0 then Rdp_Produto.Color := clSilver else Rdp_Produto.Color := clWhite;
  Lb_sugestao.Caption:='';
  Qr_ABC.FieldByname('ABC_DESCRIPRODUTO').AsString;
  Lb_MES1.Caption := FloatToStr(It_MesAnoQtde[1,3]);
  Lb_MES2.Caption := FloatToStr(It_MesAnoQtde[2,3]);
  Lb_MES3.Caption := FloatToStr(It_MesAnoQtde[3,3]);
  Lb_MES4.Caption := FloatToStr(It_MesAnoQtde[4,3]);
  Lb_MES5.Caption := FloatToStr(It_MesAnoQtde[5,3]);
  Lb_MES6.Caption := FloatToStr(It_MesAnoQtde[6,3]);
  Lc_Sld_Estoque := Fc_SaldoEstoque(Qr_ABC.FieldByname('ABC_CODPRO').AsInteger,It_Cd_Estoque); 
  Lb_Saldo.Caption:=   FloatToStr(Lc_Sld_Estoque);
  case It_Contador of
    1:Begin
        Try
          //Atribui a soma de todas as vendas
          Lc_Qt_Abc :=  It_Soma;
          //Multiplica pelos meses que deseja ter no estoque
          Lc_Qt_Abc := Lc_Qt_Abc * It_Nr_Meses;
          //Diminui a quantidade que tem em estoque
          Lc_Qt_Abc := Lc_Qt_Abc - Lc_Sld_Estoque;
          //Imprime valor no Relatorio
          Lb_Resultado.Caption := FloatToStrF(Lc_Qt_Abc,ffFixed,5,0);
        except
          if (Lc_Sld_Estoque >= 0) then
            Lb_Resultado.Caption:=FloatToStrF(Lc_Sld_Estoque,ffFixed,5,0)
          else
            Lb_Resultado.Caption:=FloatToStrF(Lc_Sld_Estoque * -1,ffFixed,5,0)
        end;
      end;
    2:Begin
        Try
          //Atribui a soma de todas as vendas
          Lc_Qt_Abc :=  It_Soma;
          //Aplica a Media dos 4 meses restantes
          Lc_Qt_Abc := (Lc_Qt_Abc / 2);
          //Multiplica pelos meses que deseja ter no estoque
          Lc_Qt_Abc := Lc_Qt_Abc * It_Nr_Meses;
          //Diminui a quantidade que tem em estoque
          Lc_Qt_Abc := Lc_Qt_Abc - Lc_Sld_Estoque;
          //Imprime valor no Relatorio
          Lb_Resultado.Caption := FloatToStrF(Lc_Qt_Abc,ffFixed,5,0);
        except
          if (Lc_Sld_Estoque >= 0) then
            Lb_Resultado.Caption:=FloatToStrF(Lc_Sld_Estoque,ffFixed,5,0)
          else
            Lb_Resultado.Caption:=FloatToStrF(Lc_Sld_Estoque * -1,ffFixed,5,0)
        end;
      end;
    3:Begin
        Try
          //Atribui a soma de todas as vendas
          Lc_Qt_Abc :=  It_Soma;
          //Aplica a Media dos 4 meses restantes
          Lc_Qt_Abc := (Lc_Qt_Abc / 3);
          //Multiplica pelos meses que deseja ter no estoque
          Lc_Qt_Abc := Lc_Qt_Abc * It_Nr_Meses;
          //Diminui a quantidade que tem em estoque
          Lc_Qt_Abc := Lc_Qt_Abc - Lc_Sld_Estoque;
          //Imprime valor no Relatorio
          Lb_Resultado.Caption := FloatToStrF(Lc_Qt_Abc,ffFixed,5,0);
        except
          if (Lc_Sld_Estoque >= 0) then
            Lb_Resultado.Caption:=FloatToStrF(Lc_Sld_Estoque,ffFixed,5,0)
          else
            Lb_Resultado.Caption:=FloatToStrF(Lc_Sld_Estoque * -1,ffFixed,5,0)
        end;
      end;
    4:Begin
        Try
          //Atribui a soma de todas as vendas
          Lc_Qt_Abc :=  It_Soma;
          //Aplica a Media dos 4 meses restantes
          Lc_Qt_Abc := (Lc_Qt_Abc / 4);
          //Multiplica pelos meses que deseja ter no estoque
          Lc_Qt_Abc := Lc_Qt_Abc * It_Nr_Meses;
          //Diminui a quantidade que tem em estoque
          Lc_Qt_Abc := Lc_Qt_Abc - Lc_Sld_Estoque;
          //Imprime valor no Relatorio
          Lb_Resultado.Caption := FloatToStrF(Lc_Qt_Abc,ffFixed,5,0);
        except
          if (Lc_Sld_Estoque >= 0) then
            Lb_Resultado.Caption:=FloatToStrF(Lc_Sld_Estoque,ffFixed,5,0)
          else
            Lb_Resultado.Caption:=FloatToStrF(Lc_Sld_Estoque * -1,ffFixed,5,0)
        end;
      end;
    5:Begin
        Try
          //Atribui a soma de todas as vendas
          Lc_Qt_Abc :=  It_Soma;
          //Retira a média do minimo e o Maximo
          Lc_Qt_Abc := Lc_Qt_Abc - ((It_minimo + It_Maximo)/2);
          //Aplica a Media dos 4 meses restantes
          Lc_Qt_Abc := (Lc_Qt_Abc / 4);
          //Multiplica pelos meses que deseja ter no estoque
          Lc_Qt_Abc := Lc_Qt_Abc * It_Nr_Meses;
          //Diminui a quantidade que tem em estoque
          Lc_Qt_Abc := Lc_Qt_Abc - Lc_Sld_Estoque;
          //Imprime valor no Relatorio
          Lb_Resultado.Caption := FloatToStrF(Lc_Qt_Abc,ffFixed,5,0);
        except
          if (Lc_Sld_Estoque >= 0) then
            Lb_Resultado.Caption:=FloatToStrF(Lc_Sld_Estoque,ffFixed,5,0)
          else
            Lb_Resultado.Caption:=FloatToStrF(Lc_Sld_Estoque * -1,ffFixed,5,0)
        end;
      end;
    6:Begin
        Try
          //Atribui a soma de todas as vendas
          Lc_Qt_Abc :=  It_Soma;
          //Retira o minimo e o Maximo
          Lc_Qt_Abc := Lc_Qt_Abc - (It_minimo + It_Maximo);
          //Aplica a Media dos 4 meses restantes
          Lc_Qt_Abc := (Lc_Qt_Abc / 4);
          //Multiplica pelos meses que deseja ter no estoque
          Lc_Qt_Abc := Lc_Qt_Abc * It_Nr_Meses;
          //Diminui a quantidade que tem em estoque
          Lc_Qt_Abc := Lc_Qt_Abc - Lc_Sld_Estoque;
          //Imprime valor no Relatorio
          Lb_Resultado.Caption := FloatToStrF(Lc_Qt_Abc,ffFixed,5,0);
        except
          if (Lc_Sld_Estoque >= 0) then
            Lb_Resultado.Caption:=FloatToStrF(Lc_Sld_Estoque,ffFixed,5,0)
          else
            Lb_Resultado.Caption:=FloatToStrF(Lc_Sld_Estoque * -1,ffFixed,5,0)
        end;
      end;
  end;

end;

procedure TRL_CurvaABC.Rdp_ProdutoAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
Var
  lc_I:Integer;
begin
  It_contador:=0;
  It_Soma:=0;
  For LC_I:=1 to 6 do
  begin
    It_MesAnoQtde[LC_I,3]:=0
  end;
  It_minimo:=-1;
  It_Maximo:=-1;
end;

procedure TRL_CurvaABC.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Buscar;
  Pc_Parametros;
end;

procedure TRL_CurvaABC.Pc_Parametros;
begin
  with Fr_Imp_Produtos do
    begin
    // Verifica tipos de documento
    case LBx_TipoRelatorio.ItemIndex of
      0 : Lb_Tipo_Doc.Caption := 'Cadastro de Produtos';
      1 : Lb_Tipo_Doc.Caption := 'Saldo do Estoque';
      2 : Lb_Tipo_Doc.Caption := 'Movimentação';
      3 : Lb_Tipo_Doc.Caption := 'Tabela de Produção';
      4 : Lb_Tipo_Doc.Caption := 'Curva ABC';
      5 : Lb_Tipo_Doc.Caption := 'Inventário';
    end;
    // Verifica data de Inatividade da empresa solicitada
    if ChBx_Periodo.Checked = true then
      begin
      Lb_Data_Ini.Caption := DateToStr( E_Data_Ini.Date);
      Lb_Data_Fim.Caption := DateToStr( E_Data_Fim.Date);
      end
    else
      begin
      QRLabel14.Font.Color := clWhite;
      QRLabel16.Font.Color := clWhite;
      Lb_Data_Ini.Font.Color := clWhite;
      Lb_Data_Fim.Font.Color := clWhite;
      end;
    // Verifica o nome do estoque foi preenchido
    if Fm_ListaEstoques.DBLCB_Estoque.Text = '' then
      Lb_Estoque.Caption := 'Todos'
    else
      Lb_Estoque.Caption := Fm_ListaEstoques.DBLCB_Estoque.Text;
    // Verifica se o campo cliente foi preenchido
    if DBLCB_Tabela_Preco.Text = '' then
      Lb_Tab_Preco.Caption := 'Todos'
    else
      Lb_Tab_Preco.Caption := DBLCB_Tabela_Preco.Text;
    // Verifica o nome do grupo foi preenchido
    if DBLCB_Grupos.Text = '' then
      Lb_Grupo.Caption := 'Todos'
    else
      Lb_Grupo.Caption := DBLCB_Grupos.Text;
    // Verifica se o subgrupo foi preenchido
    if DBLCB_SubGrupos.Text = '' then
      Lb_Subgrupo.Caption := 'Todos'
    else
      Lb_Subgrupo.Caption := DBLCB_SubGrupos.Text;
    // Verifica o nome da marca foi preenchido
    if DBLCB_Marca.Text = '' then
      Lb_Marca.Caption := 'Todos'
    else
      Lb_Marca.Caption := DBLCB_Marca.Text;
    // Verifica se o nome da empresa foi preenchido
    if trim(DBLCB_Empresa.Text) = '' then
      Lb_Empresa.Caption := 'Todos'
    else
      Lb_Empresa.Caption := DBLCB_Empresa.Text;
    // Verifica se a ordenação foi preenchida
    case Cb_Ordena.ItemIndex of
      0 : Lb_Ordenacao.Caption := 'Descrição';
      1 : Lb_Ordenacao.caption := 'Código de Fábrica';
      2 : Lb_Ordenacao.Caption := 'Código Interno';
    end;

    // Verifica opção Estoque Minimo
    if ChBx_Est_Min.Checked = true then
      begin
      Lb_Estoq_Min.Caption := SIM
      end
    else
      begin
      Lb_Estoq_Min.Caption := NAO;
      end;
    // Verifica opção Saldo Positivo
    if ChBx_Positivo.Checked = true then
      begin
      Lb_Saldo_Positivo.Caption := SIM
      end
    else
      begin
      Lb_Saldo_Positivo.Caption := NAO;
      end;
    // Verifica opção Mostrar Inativos
    if ChBx_Inativos.Checked = true then
      begin
      Lb_Inativos.Caption := SIM
      end
    else
      begin
      Lb_Inativos.Caption := NAO;
      end;
    end;
end;


procedure TRL_CurvaABC.FormCreate(Sender: TObject);
begin
  It_Linha := 0;
  It_Nr_Meses := StrToIntDef(Fr_Imp_Produtos.E_Curva_Nr_Mes.Text,1);
end;

end.
