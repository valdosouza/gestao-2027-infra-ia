unit PrintPizzaria;

interface

uses
      Windows, SysUtils, StdCtrls, Classes, STDatabase, STQuery, Dialogs, Printers, WinSpool, BematechPrint, ControllerBase, Un_TPrin, ControllerPayBack, System.Generics.Collections, Vcl.Forms, un_dm, ControllerRestaurante, Vcl.Controls, PagamentoEscolhido, GeneralPrint;

type



  TPrintPizzaria = class(TComponent)
  private
    { Private declarations }
    M_Pedido : TMemo;
    Base : TControllerBase;
    ItDialImp : TPrintDialog;
    ItImpAtual : Integer;
    QryDadosPedido:TSTQuery;
    QryDadosItensPedido:TSTQuery;
    QryDadosItensCozinha:TSTQuery;
    QryDadosImpressora:TSTQuery;
    FParentAtual: TWinControl;


    procedure Imp_Piz_Matr_Caixa_1;

    procedure Imp_Piz_Matr_Cozin_1;
    procedure Imp_Piz_Termica_1;

    procedure VisualizaHistorico;
    procedure VisualizaHistoricoWhats;
    procedure setFParentAtual(const Value: TWinControl);

  protected
    { Protected declarations }
    Visualiza : Boolean;
    PortaVisualiza : String;
  public
    { Public declarations }
    CodigoConsumidor : Integer;
    CodigoPedido : Integer;
    NumeroItemPedido : Integer;
    CodigoImpressora : Integer;
    Estabelecimento : Integer;
    NomeEstabelecimento : String;
    FoneEstabelecimento : String;
    NomeUsuario : String;
    ValorRecebido :String;
    ValorTroco : String;
    ModeloImpressao :Integer;
    ModeloMatricial : Integer;
    ModeloTermica : Integer;
    Sache : Boolean;
    Palito : Boolean;
    Fatiado : Boolean;
    FormaPagto : TListaPagamentoEscolhido;
    Periodo : Boolean;
    DataInicial : TDateTime ;
    DataFinal : TDAtetime  ;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure PrepararEnvioWhatsApp;
    procedure AbreDadosPedido;
    procedure AbreDadosItensPedido;
    procedure AbreDadosItensCozinha;
    procedure AbreDadosImpressora;

    Procedure GetLastOrder;
    procedure getOrderWhatsApp;

    procedure PrintModeloPrincipal;

    procedure PrintModeloCozinha;
    procedure PrintModeloItemCozinha;

    procedure PrintVendaDetalhada;
    procedure PrintVendaPorGrupo;
    procedure PrintVendaPorTamanhoPizzaCalzone;
    procedure PrintVendaPorTamanhoBorda;
    procedure PrintVendaPorGrupoMassa;
    procedure PrintVendaPorGrupoBebidas;

    procedure AbreVendaDEtalhada;
    procedure AbreVendaPorGrupo;
    procedure AbreVendaporTamanhoPizzaCalzone;
    procedure AbreVendaPorTamanhoBorda;
    procedure AbreVendaPorGrupoMassa;
    procedure AbreVendaPorGrupoBebidas;

    Function ValorFrete:Real;
    Function ValorAdicional:Real;
    Function ValorDesconto:Real;
  public

  published
    { Published declarations }
    property ParentAtual : TWinControl Read FParentAtual write setFParentAtual;
  end;

procedure Register;

implementation

uses     DB, UN_Sistema, Un_Funcoes, WhatsApp, Un_REgra_Negocio;
procedure Register;
begin
  RegisterComponents('Setes', [TPrintPizzaria]);
end;

constructor TPrintPizzaria.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Base := TControllerBase.create(Nil);
  Visualiza := False;
  //Componente do Pedido
  QryDadosPedido := Base.GeraQuery;
  //Componente dos Itens do Pedido
  QryDadosItensPedido := Base.GeraQuery;
  //Componente dos Itens para a cozinha
  QryDadosItensCozinha := Base.GeraQuery;
  //Componente dados da Impressora
  QryDadosImpressora := Base.GeraQuery;
  CodigoPedido := 0;
  NumeroItemPedido := 0;
  FormaPagto := TListaPagamentoEscolhido.Create;
end;

destructor TPrintPizzaria.Destroy;
begin
  Base.FinalizaQuery(QryDadosPedido);
  Base.FinalizaQuery(QryDadosItensPedido);
  Base.FinalizaQuery(QryDadosItensCozinha);
  Base.FinalizaQuery(QryDadosImpressora);
  FreeAndNil(Base);
  FreeAndNil(FormaPagto);
  inherited Destroy;
end;


Procedure TPrintPizzaria.GetLastOrder;
Var
  Lc_Dir : String;
  Lc_I:Integer;
begin
  Lc_Dir := concat(ExtractFilePath(Application.ExeName),'temp');
  if not DirectoryExists(Lc_Dir) then
    ForceDirectories(Lc_Dir);
  PortaVisualiza := concat(Lc_Dir,'\','cupompizza.txt');
  Visualiza := True;
  AbreDadosPedido;
  AbreDadosItensPedido;
  AbreDadosImpressora;
  VisualizaHistorico;
end;

procedure TPrintPizzaria.getOrderWhatsApp;
Var
  Lc_Dir : String;
  Lc_I:Integer;
begin
  Lc_Dir := concat(ExtractFilePath(Application.ExeName),'temp');
  if not DirectoryExists(Lc_Dir) then
    ForceDirectories(Lc_Dir);
  PortaVisualiza := concat(Lc_Dir,'\','cupompizza.txt');
  Visualiza := True;
  AbreDadosPedido;
  AbreDadosItensPedido;
  AbreDadosImpressora;
  VisualizaHistoricoWhats;
end;

function TPrintPizzaria.ValorAdicional: Real;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Result := 0;
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT  SUM(P.PED_VL_ODESPESA) VALOR '+
              'FROM TB_NOTA_FISCAL n '+
              '  INNER JOIN TB_PEDIDO p '+
              '  ON (PED_CODIGO = NFL_CODPED)');
      if Periodo then
        SQL.Add('WHERE NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ');
      if Periodo then
      Begin
        ParamByName('DATAINI').AsDateTime := DataInicial;
        ParamByName('DATAFIM').AsDAtetime := DataFinal;
      End;
      Active := True;
      FetchAll;
      Result := FieldByName('VALOR').AsCurrency;
    end;
  Finally
    Base.FinalizaQuery(Lc_Qry);
  End;


end;

function TPrintPizzaria.ValorDesconto: Real;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Result := 0;
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT  SUM(P.PED_VL_DESCONTO) VALOR '+
              'FROM TB_NOTA_FISCAL n '+
              '  INNER JOIN TB_PEDIDO p '+
              '  ON (PED_CODIGO = NFL_CODPED)');
      if Periodo then
        SQL.Add('WHERE NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ');
      if Periodo then
      Begin
        ParamByName('DATAINI').AsDateTime := DataInicial;
        ParamByName('DATAFIM').AsDAtetime := DataFinal;
      End;
      Active := True;
      FetchAll;
      Result := FieldByName('VALOR').AsCurrency;
    end;
  Finally
    Base.FinalizaQuery(Lc_Qry);

  End;

end;

function TPrintPizzaria.ValorFrete: Real;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Result := 0;
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT  SUM(P.ped_vl_frete) VALOR '+
              'FROM TB_NOTA_FISCAL n '+
              '  INNER JOIN TB_PEDIDO p '+
              '  ON (PED_CODIGO = NFL_CODPED)');
      if Periodo then
        SQL.Add('WHERE NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ');
      if Periodo then
      Begin
        ParamByName('DATAINI').AsDateTime := DataInicial;
        ParamByName('DATAFIM').AsDAtetime := DataFinal;
      End;
      Active := True;
      FetchAll;
      Result := FieldByName('VALOR').AsCurrency;
    end;
  Finally
    Base.FinalizaQuery(Lc_Qry);
  End;
end;

procedure TPrintPizzaria.VisualizaHistorico;
Var
  Lc_Prin:TPrin;
  lc_I,Lc_IT_Atual,Lc_IT_Prior ,QITENS:Integer;
  Lc_J:Integer;
  Lc_K:Integer;
  Lc_Linha : Integer;
  Lc_Obs : TStringList;
  Lc_ColunaImpressao : Integer;
  Lc_StrAux:String;
  Lc_Tl_Itens : Integer;
  I : Integer;
  ListObs : TStringList;
  Lc_Finaliza: TextFile;
  Lc_Porta : String;
  LcPayBackTaxa: REal;
  LcPayBackMinimo : REal;
  LcPayBackAcumul : REal;
  LcPayBack : TControllerPayBack;
  LcUsouPayPack : Boolean;
  lcValorPayBAck : Real;
Label
  Desvio;
Begin
  Try
    LcPayBack := TControllerPayBack.create(nil);
    Lc_Prin := TPrin.Create(nil);
    With Lc_Prin, QryDadosPedido Do
    begin
      if Visualiza then
        Lc_Porta := PortaVisualiza
      else
        Lc_Porta := QryDadosImpressora.FieldByName('IMP_CAMINHO').AsString;
      Initialize(Lc_Porta);
      Lc_Linha := 0;
      Lc_ColunaImpressao := QryDadosImpressora.FieldByName('IMP_COLUNAS').AsInteger;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto(NomeEstabelecimento,Lc_ColunaImpressao,' '));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto(Fc_MascaraFone(FoneEstabelecimento),Lc_ColunaImpressao,' '));
      Lc_Linha := Lc_Linha + 2;
      case StrToIntDef(FieldByName('PED_TP_CONTATO').AsString,0) of
        0:TextOutLC(Lc_Linha,1,CentralizaTexto('ENTREGA',Lc_ColunaImpressao, '-'));
        1:TextOutLC(Lc_Linha,1,CentralizaTexto('BALCAO',Lc_ColunaImpressao, '-'));
        2:TextOutLC(Lc_Linha,1,CentralizaTexto(FieldByName('EMP_NOME').AsString,Lc_ColunaImpressao, '-'));
      end;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('ATENDENTE : ' + NomeUsuario,Lc_ColunaImpressao,' '));
      //Prin.Expandido(False);
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('PEDIDO: ' + StrZero(FieldByName('PED_NUMERO').AsInteger,4,0) + ' | ' + FieldByName('PED_DT_ALTERA').asstring,Lc_ColunaImpressao,' '));
      if FieldByName('PED_TP_CONTATO').AsInteger < 2 then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,copy('CLIENTE  : ' + FieldByName('EMP_NOME').AsString,1,Lc_ColunaImpressao));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,Copy('TELEFONE : ' + Fc_MascaraFone(FieldByName('END_FONE').AsString),1,Lc_ColunaImpressao));
      End;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'ITEM ');
      TextOutLC(Lc_Linha,6,'DESCRICAO');
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 11,'QTDE');
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 6,'VALOR');
      lc_I:=1;
      with QryDadosItensPedido do
      Begin
        Active:=True;
        First;
        FetchAll;
        Lc_IT_Prior:=0;
        For Lc_I:= 1 to RecordCount do
        Begin
          //Imprime item e descrição
          Lc_Linha := Lc_Linha + 1;
          if (FieldByName('ITR_NR_ITEM').AsInteger <> Lc_IT_Prior) then
            TextOutLC(Lc_Linha,1,PAdr(FieldByName('ITR_NR_ITEM').AsString,4));
          TextOutLC(Lc_Linha,6,copy(FieldByName('ITR_DESCRICAO').AsString,1,Lc_ColunaImpressao - 6));
          //Imprime se tiver observção
          if FieldByName('ITR_OBS').AsString<>'' then
          Begin
            Try
              ListObs := TStringList.Create;
              ExtractStrings(['|'],[], PChar(FieldByName('ITR_OBS').AsString), ListObs);
              for Lc_K := 0 to ( ListObs.count - 1) do
              Begin
                Lc_Linha := Lc_Linha + 1;
                if Lc_K = 0 then
                  TextOutLC(Lc_Linha,6,copy('Obs:  ' + ListObs.Strings[Lc_K],1,Lc_ColunaImpressao - 7))
                else
                  TextOutLC(Lc_Linha,6,copy('      ' + ListObs.Strings[Lc_K],1,Lc_ColunaImpressao - 7))
              End;
            Finally
              FreeAndNil(ListObs);
            End;
          end;
          //Imprime quantidade e valor
          if (FieldByName('ITR_QTDE').Asfloat > 0 ) then
          BEgin
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,Lc_ColunaImpressao - 11,PAdr(FieldByName('ITR_QTDE').AsString,4));
            TextOutLC(Lc_Linha,Lc_ColunaImpressao - 7,PAdr(FloatToStrF(FieldByName('ITR_VL_UNIT').AsCurrency,ffFixed,10,2),7));
          end;
          Lc_IT_Prior := FieldByName('ITR_NR_ITEM').AsInteger;
          Next;
        end;
      end;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
      LcUsouPayPack := False;
      lcValorPayBAck := 0;
      for I := 0 to (FormaPagto.Count - 1) do
      Begin
        Lc_Linha := Lc_Linha + 1;
        if I = 0 then
        Begin
          TextOutLC(Lc_Linha,1,'FORMA PAGTO: ');
          TextOutLC(Lc_Linha,14,Copy(FormaPagto[I].Forma,1,Lc_ColunaImpressao-22));
          TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF( FormaPagto[I].Valor ,ffFixed,10,2),8));
        End
        else
        Begin
          TextOutLC(Lc_Linha,14,Copy(FormaPagto[I].Forma,1,Lc_ColunaImpressao-22));
          TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF( FormaPagto[I].Valor ,ffFixed,10,2),8));
        End;
        if ( not LcUsouPayPack ) then
        Begin
          LcUsouPayPack := ( FormaPagto[I].Forma = 'PAYBACK');
          if LcUsouPayPack then
            lcValorPayBAck :=  FormaPagto[I].Valor;
        End;

      end;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));

      if (FieldByName('PED_VL_PRODUTO').AsCurrency > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'SUBTOTAL..:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_PRODUTO').AsCurrency,ffFixed,10,2),8));
      end;

      if (FieldByName('PED_VL_FRETE').AsCurrency > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'ENTREGA...:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_FRETE').AsCurrency,ffFixed,10,2),8));
      end;

      if (FieldByName('PED_VL_ODESPESA').AsCurrency > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'ADICIONAL.:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_ODESPESA').AsCurrency,ffFixed,10,2),8));
      end;

      if (FieldByName('PED_VL_DESCONTO').AsCurrency > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'DESCONTO..:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(CONCAT('-',FloatToStrF(FieldByName('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2)),8));
      end;

      if LcUsouPayPack then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'PAYBACK...:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(CONCAT('-',FloatToStrF(lcValorPayBAck,ffFixed,10,2)),8));
      end;

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'TOTAL.....:');
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_PEDIDO').AsCurrency-lcValorPayBAck,ffFixed,10,2),8));

      if (StrtoFloatDef(ValorRecebido,0) > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'RECEBIDO..:');
        if LcUsouPayPack then
        Begin
          ValorRecebido := FloatToStrF( StrToFloat(ValorRecebido) - lcValorPayBAck ,ffFixed,10,2);
        end;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(ValorRecebido ,8));
      end;

      if (StrtoFloatDef(ValorTroco,0) > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'TROCO.....:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(ValorTroco,8));
      end;
      //PROGRAMA PAYBACK
      if CodigoConsumidor <> FieldByName('EMP_CODIGO').AsInteger then
      Begin
        if ( Fc_Tb_Geral('L','PAYBACK_IMP_CREDIT','S') = 'S') then
        Begin
          LcPayBackTaxa   := StrToFloatDef(Fc_Tb_Geral('L','PAYBACK_TAXA','0'),0);
          if (  LcPayBackTaxa > 0 ) then
          Begin
            LcPayBackMinimo := StrToFloatDef( Fc_Tb_Geral('L','PAYBACK_VL_MINIMO','0'),0);
            LcPayBack.Parametros.Periodo := False;
            LcPayBack.Parametros.PayBack.Cliente := FieldByName('EMP_CODIGO').AsInteger;
            LcPayBack.Parametros.PayBack.estabelecimento := Estabelecimento;
            LcPayBack.Parametros.PayBack.Ordem := 0;
            LcPayBackAcumul := LcPayBack.getSaldo;
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,CentralizaTexto(Fc_Tb_Geral('L','PAYBACK_TITTLE','0'),Lc_ColunaImpressao, '-'));
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,CentralizaTexto(CONCAT('A CADA COMPRA VOCE PODE GANHAR ', FloatToStrF(LcPayBackTaxa,ffFixed,10,1) ,'% DE RETORNO'),Lc_ColunaImpressao, ' '));
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,CentralizaTexto(CONCAT('JUNTANDO UM VALOR MINIMO DE R$ ', FloatToStrF(LcPayBackMinimo,ffFixed,10,2)),Lc_ColunaImpressao, ' '));
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,CentralizaTexto('VOCE PODE UTILIZAR COMO DESCONTO NA SUA',Lc_ColunaImpressao, ' '));
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,CentralizaTexto('PROXIMA COMPRA COM A GENTE',Lc_ColunaImpressao, ' '));
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,'SALDO DISPONIVEL');
            TextOutLC(Lc_Linha,Lc_ColunaImpressao - 11,PAdr( FloatToStrF(LcPayBackAcumul,ffNumber,10,2) ,11));
          End;
        End;
      End;

      if (FieldByName('PED_TP_CONTATO').AsInteger  = 0 ) then
      Begin
        //bAIRRO
        Lc_Linha := Lc_Linha + 2;
        TextOutLC(Lc_Linha,1,CentralizaTexto(FieldByName('END_BAIRRO').AsString,Lc_ColunaImpressao,'-'));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,Copy(FieldByName('END_ENDER').AsString + ', ' + FieldByName('END_NUMERO').AsString,1,Lc_ColunaImpressao));
        if Length(FieldByName('END_COMPLEM').AsString) > 0 then
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,copy(FieldByName('END_COMPLEM').AsString,1,Lc_ColunaImpressao));
        end;
      End;
      Lc_StrAux := '';
      if Sache then
        Lc_StrAux := 'LEVAR SACHE';

      Lc_Obs := TStringList.Create;

      if Trim(FieldByName('PED_OBS').AsString) <> '' then
        Lc_Obs.Text := Trim(FieldByName('PED_OBS').AsString);
      Lc_Obs.Append(Lc_StrAux);

      For Lc_J:=0 to (Lc_Obs.Count-1) do
      Begin
        if Lc_J=0 then
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,Copy('OBS: '+Lc_Obs.Strings[lc_J],1,Lc_ColunaImpressao));
        end
        else
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,Copy(Lc_Obs.Strings[lc_J],1,Lc_ColunaImpressao));
        end;
      end;
      Reset;
      Finalize;
    end;
  Finally
    FreeAndNil(Lc_Prin);
    FreeAndNil(LcPayBack);
  End;


end;

procedure TPrintPizzaria.VisualizaHistoricoWhats;
Var
  Lc_Prin:TPrin;
  lc_I,Lc_IT_Atual,Lc_IT_Prior ,QITENS:Integer;
  Lc_J:Integer;
  Lc_K:Integer;
  Lc_Linha : Integer;
  Lc_Obs : TStringList;
  Lc_ColunaImpressao : Integer;
  Lc_StrAux:String;
  Lc_Tl_Itens : Integer;
  I : Integer;
  ListObs : TStringList;
  Lc_Finaliza: TextFile;
  Lc_Porta : String;
  LcPayBackTaxa: REal;
  LcPayBackMinimo : REal;
  LcPayBackAcumul : REal;
  LcPayBack : TControllerPayBack;
  LcUsouPayPack : Boolean;
  lcValorPayBAck : Real;
Label
  Desvio;
Begin
  Try
    LcPayBack := TControllerPayBack.create(nil);
    Lc_Prin := TPrin.Create(nil);
    With Lc_Prin, QryDadosPedido Do
    begin
      Lc_Porta := PortaVisualiza;
      Initialize(Lc_Porta);
      Lc_ColunaImpressao := 40;
      Lc_Linha := 1;
      //TextOutLC(Lc_Linha,1,CentralizaTexto('PEDIDO SENDO PREPARADO',Lc_ColunaImpressao, ''));
      TextOutLC(Lc_Linha,1,CentralizaTexto('Seu pedido está sendo preparado...',Lc_ColunaImpressao, ''));
      Lc_Linha := Lc_Linha + 2;

      case StrToIntDef(FieldByName('PED_TP_CONTATO').AsString,0) of
        0:TextOutLC(Lc_Linha,1,CentralizaTexto('ENTREGA',Lc_ColunaImpressao, '-'));
        1:TextOutLC(Lc_Linha,1,CentralizaTexto('BALCAO',Lc_ColunaImpressao, '-'));
        2:TextOutLC(Lc_Linha,1,CentralizaTexto(FieldByName('EMP_NOME').AsString,Lc_ColunaImpressao, '-'));
      end;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('ATENDENTE : ' + NomeUsuario,Lc_ColunaImpressao,' '));
      //Prin.Expandido(False);
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('PEDIDO: ' + StrZero(FieldByName('PED_NUMERO').AsInteger,4,0) + ' | ' + FieldByName('PED_DT_ALTERA').asstring,Lc_ColunaImpressao,' '));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'ITEM ');
      TextOutLC(Lc_Linha,6,'DESCRICAO');
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 11,'QTDE');
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 6,'VALOR');
      lc_I:=1;
      with QryDadosItensPedido do
      Begin
        Active:=True;
        First;
        FetchAll;
        Lc_IT_Prior:=0;
        For Lc_I:= 1 to RecordCount do
        Begin
          //Imprime item e descrição
          Lc_Linha := Lc_Linha + 1;
          if (FieldByName('ITR_NR_ITEM').AsInteger <> Lc_IT_Prior) then
            TextOutLC(Lc_Linha,1,PAdr(FieldByName('ITR_NR_ITEM').AsString,4));
          TextOutLC(Lc_Linha,6,copy(FieldByName('ITR_DESCRICAO').AsString,1,Lc_ColunaImpressao - 6));
          //Imprime se tiver observção
          if FieldByName('ITR_OBS').AsString<>'' then
          Begin
            Try
              ListObs := TStringList.Create;
              ExtractStrings(['|'],[], PChar(FieldByName('ITR_OBS').AsString), ListObs);
              for Lc_K := 0 to ( ListObs.count - 1) do
              Begin
                Lc_Linha := Lc_Linha + 1;
                if Lc_K = 0 then
                  TextOutLC(Lc_Linha,6,copy('Obs:  ' + ListObs.Strings[Lc_K],1,Lc_ColunaImpressao - 7))
                else
                  TextOutLC(Lc_Linha,6,copy('      ' + ListObs.Strings[Lc_K],1,Lc_ColunaImpressao - 7))
              End;
            Finally
              FreeAndNil(ListObs);
            End;
          end;
          //Imprime quantidade e valor
          if (FieldByName('ITR_QTDE').Asfloat > 0 ) then
          BEgin
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,Lc_ColunaImpressao - 11,PAdr(FieldByName('ITR_QTDE').AsString,4));
            TextOutLC(Lc_Linha,Lc_ColunaImpressao - 7,PAdr(FloatToStrF(FieldByName('ITR_VL_UNIT').AsCurrency,ffFixed,10,2),7));
          end;
          Lc_IT_Prior := FieldByName('ITR_NR_ITEM').AsInteger;
          Next;
        end;
      end;
      LcUsouPayPack := False;
      lcValorPayBAck := 0;
      if (FormaPagto.Count > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        for I := 0 to (FormaPagto.Count - 1) do
        Begin
          Lc_Linha := Lc_Linha + 1;
          if I = 0 then
          Begin
            TextOutLC(Lc_Linha,1,'FORMA PAGTO: ');
            TextOutLC(Lc_Linha,14,Copy(FormaPagto[I].Forma,1,Lc_ColunaImpressao-22));
            TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF( FormaPagto[I].Valor ,ffFixed,10,2),8));
          End
          else
          Begin
            TextOutLC(Lc_Linha,14,Copy(FormaPagto[I].Forma,1,Lc_ColunaImpressao-22));
            TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF( FormaPagto[I].Valor ,ffFixed,10,2),8));
          End;
          if ( not LcUsouPayPack ) then
          Begin
            LcUsouPayPack := ( FormaPagto[I].Forma = 'PAYBACK');
            if LcUsouPayPack then
              lcValorPayBAck :=  FormaPagto[I].Valor;
          End;

        end;
      End;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));

      if (FieldByName('PED_VL_PRODUTO').AsCurrency > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'SUBTOTAL..:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_PRODUTO').AsCurrency,ffFixed,10,2),8));
      end;

      if (FieldByName('PED_VL_FRETE').AsCurrency > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'ENTREGA...:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_FRETE').AsCurrency,ffFixed,10,2),8));
      end;

      if (FieldByName('PED_VL_ODESPESA').AsCurrency > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'ADICIONAL.:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_ODESPESA').AsCurrency,ffFixed,10,2),8));
      end;

      if (FieldByName('PED_VL_DESCONTO').AsCurrency > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'DESCONTO..:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(CONCAT('-',FloatToStrF(FieldByName('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2)),8));
      end;

      if LcUsouPayPack then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'PAYBACK...:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(CONCAT('-',FloatToStrF(lcValorPayBAck,ffFixed,10,2)),8));
      end;

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'TOTAL.....:');
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_PEDIDO').AsCurrency-lcValorPayBAck,ffFixed,10,2),8));

      if (StrtoFloatDef(ValorRecebido,0) > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'RECEBIDO..:');
        if LcUsouPayPack then
        Begin
          ValorRecebido := FloatToStrF( StrToFloat(ValorRecebido) - lcValorPayBAck ,ffFixed,10,2);
        end;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(ValorRecebido ,8));
      end;

      if (StrtoFloatDef(ValorTroco,0) > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'TROCO.....:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(ValorTroco,8));
      end;
      //PROGRAMA PAYBACK
      if CodigoConsumidor <> FieldByName('EMP_CODIGO').AsInteger then
      Begin
        if ( Fc_Tb_Geral('L','PAYBACK_IMP_CREDIT','S') = 'S') then
        Begin
          LcPayBackTaxa   := StrToFloatDef(Fc_Tb_Geral('L','PAYBACK_TAXA','0'),0);
          if (  LcPayBackTaxa > 0 ) then
          Begin
            LcPayBackMinimo := StrToFloatDef( Fc_Tb_Geral('L','PAYBACK_VL_MINIMO','0'),0);
            LcPayBack.Parametros.Periodo := False;
            LcPayBack.Parametros.PayBack.Cliente := FieldByName('EMP_CODIGO').AsInteger;
            LcPayBack.Parametros.PayBack.estabelecimento := Estabelecimento;
            LcPayBack.Parametros.PayBack.Ordem := 0;
            LcPayBackAcumul := LcPayBack.getSaldo;
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,CentralizaTexto(Fc_Tb_Geral('L','PAYBACK_TITTLE','0'),Lc_ColunaImpressao, '-'));
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,CentralizaTexto(CONCAT('A CADA COMPRA VOCE PODE GANHAR ', FloatToStrF(LcPayBackTaxa,ffFixed,10,1) ,'% DE RETORNO'),Lc_ColunaImpressao, ' '));
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,CentralizaTexto(CONCAT('JUNTANDO UM VALOR MINIMO DE R$ ', FloatToStrF(LcPayBackMinimo,ffFixed,10,2)),Lc_ColunaImpressao, ' '));
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,CentralizaTexto('VOCE PODE UTILIZAR COMO DESCONTO NA SUA',Lc_ColunaImpressao, ' '));
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,CentralizaTexto('PROXIMA COMPRA COM A GENTE',Lc_ColunaImpressao, ' '));
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,'SALDO DISPONIVEL');
            TextOutLC(Lc_Linha,Lc_ColunaImpressao - 11,PAdr( FloatToStrF(LcPayBackAcumul,ffNumber,10,2) ,11));
          End;
        End;
      End;

      if (FieldByName('PED_TP_CONTATO').AsInteger  = 0 ) then
      Begin
        //bAIRRO
        Lc_Linha := Lc_Linha + 2;
        TextOutLC(Lc_Linha,1,CentralizaTexto(FieldByName('END_BAIRRO').AsString,Lc_ColunaImpressao,'-'));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,Copy(FieldByName('END_ENDER').AsString + ', ' + FieldByName('END_NUMERO').AsString,1,Lc_ColunaImpressao));
        if Length(FieldByName('END_COMPLEM').AsString) > 0 then
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,copy(FieldByName('END_COMPLEM').AsString,1,Lc_ColunaImpressao));
        end;
      End;
      Lc_StrAux := '';
      if Sache then
        Lc_StrAux := 'LEVAR SACHE';

      Lc_Obs := TStringList.Create;

      if Trim(FieldByName('PED_OBS').AsString) <> '' then
        Lc_Obs.Text := Trim(FieldByName('PED_OBS').AsString);
      Lc_Obs.Append(Lc_StrAux);

      For Lc_J:=0 to (Lc_Obs.Count-1) do
      Begin
        if Lc_J=0 then
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,Copy('OBS: '+Lc_Obs.Strings[lc_J],1,Lc_ColunaImpressao));
        end
        else
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,Copy(Lc_Obs.Strings[lc_J],1,Lc_ColunaImpressao));
        end;
      end;
      Finalize;
    end;
  Finally
    FreeAndNil(Lc_Prin);
    FreeAndNil(LcPayBack);
  End;
end;

procedure TPrintPizzaria.AbreDadosPedido;
Begin
  with QryDadosPedido do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add('select '+
            ' PED_CODIGO, '+
            ' PED_NUMERO, '+
            ' FPT_DESCRICAO, '+
            ' PED_TP_CONTATO, '+
            ' PED_DT_ALTERA, '+
            ' EMP_CODIGO, '+
            ' DESCRICAO EMP_NOME, '+
            ' END_FONE, '+
            ' END_ENDER, '+
            ' END_NUMERO, '+
            ' END_BAIRRO, '+
            ' END_COMPLEM, '+
            ' PED_OBS, '+
            ' PED_VL_FRETE, '+
            ' PED_VL_ODESPESA, '+
            ' PED_VL_DESCONTO, '+
            ' PED_VL_PRODUTO, '+
            ' PED_VL_PEDIDO, '+
            ' PED_CODWEB '+
            ' FROM TB_PEDIDO '+
            '   INNER JOIN TB_EMPRESA '+
            '   ON (PED_CODEMP = EMP_CODIGO) '+
            '   INNER JOIN TB_ENDERECO '+
            '   ON (PED_CODEND = END_CODIGO) '+
            '   LEFT OUTER JOIN TB_FORMAPAGTO '+
            '   ON (FPT_CODIGO = PED_CODFPG) '+
            '   INNER JOIN TB_RESTAURANTE '+
            '   ON (TB_PEDIDO_ID = PED_CODIGO ) '+
            'WHERE PED_CODIGO=:PED_CODIGO');
    ParamByName('PED_CODIGO').AsInteger := CodigoPedido;
    Active := True;
    FetchAll;
  end;

end;

procedure TPrintPizzaria.AbreDadosItensPedido;
Begin
  with QryDadosItensPedido do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add('select '+
            ' ITF_CODIGO, '+
            ' ITF_CODPED, '+
            ' ITF_CODPRO, '+
            ' ITR_NR_ITEM, '+
            ' ITR_DESCRICAO, '+
            ' ITR_QTDE, '+
            ' ITR_VL_UNIT, '+
            ' (ITR_QTDE * ITR_VL_UNIT) ITR_SUBTOTAL, '+
            ' ITF_VL_DESC, '+
            ' ITF_ESTOQUE, '+
            ' ITR_OBS, '+
            ' ITR_CODGRC, '+
            ' ITR_CODSBG, '+
            ' ITR_CORTESIA '+
            'FROM tb_itens_nfl '+
            '  INNER JOIN tb_itens_rtr '+
            '  ON (ITR_CODITF = ITF_CODIGO) '+
            'WHERE ITF_CODPED =:PED_CODIGO ' +
            'ORDER BY ITR_NR_ITEM,ITR_DESCRICAO, ITF_CODIGO,  ITR_VL_UNIT ');
            //'ORDER BY ITR_NR_ITEM, ITR_VL_UNIT ');
    ParamByName('PED_CODIGO').AsInteger := CodigoPedido;
    Active := True;
    FetchAll;
  end;
end;

procedure TPrintPizzaria.AbreDadosItensCozinha;
Begin
  with QryDadosItensCozinha do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add('select '+
            ' ITR_NR_ITEM , '+
            ' ITR_DESCRICAO, '+
            ' ITR_QTDE, '+
            ' ITR_VL_UNIT, '+
            ' ITR_OBS, '+
            ' ITR_CODSBG, '+
            ' ITR_CORTESIA, '+
            ' m.imp_caminho, '+
            ' PED_TP_CONTATO, '+
            ' GRP_DESCRICAO, '+
            ' SBG_DESCRICAO '+
            'FROM tb_itens_nfl i '+
            '  inner join tb_pedido d '+
            '  ON ( d.ped_codigo = i.itf_codped ) '+
            '  INNER JOIN tb_itens_rtr r '+
            '  ON ( ITR_CODITF = ITF_CODIGO ) '+
            '  inner join tb_produto p '+
            '  on (p.pro_codigo = i.itf_codpro ) '+
            '  inner join tb_subgrupos s '+
            '  on (s.sbg_codigo = p.pro_codsbg) '+
            '  INNER JOIN TB_GRUPOS G '+
            '  ON (G.GRP_CODIGO = S.SBG_CODGRP ) '+
            '  inner join tb_impressora m '+
            '  on (m.imp_codigo  = s.sbg_codimp) '+
            'WHERE ITF_CODPED =:PED_CODIGO '+
            ' AND (M.imp_codigo = :IMP_CODIGO) ');
    if NumeroItemPedido > 0 then
      SQL.Add(' AND (ITR_NR_ITEM =:ITR_NR_ITEM) ');

    SQL.Add('ORDER BY ITR_NR_ITEM, ITR_VL_UNIT');

    ParamByName('PED_CODIGO').AsInteger := CodigoPedido;
    ParamByName('IMP_CODIGO').AsInteger := CodigoImpressora;
    if NumeroItemPedido > 0 then
      ParamByName('ITR_NR_ITEM').AsInteger := NumeroItemPedido;
    Active := True;
    FetchAll;
  end;
end;

procedure TPrintPizzaria.AbreDadosImpressora;
Begin
  with QryDadosImpressora do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT '+
            '  IMP_CODIGO, '+
            '  IMP_DESCRICAO, '+
            '  IMP_CAMINHO, '+
            '  IMP_TIPO, '+
            '  IMP_SALTO, '+
            '  IMP_VIAS, '+
            '  IMP_COLUNAS '+
            'FROM TB_IMPRESSORA ');
    Active := True;
    FetchAll;
  end;
end;

procedure TPrintPizzaria.printModeloPrincipal;
Var
  Lc_I:Integer;
begin
  AbreDadosPedido;
  AbreDadosItensPedido;
  AbreDadosImpressora;
  with QryDadosImpressora do
  Begin
    While not Eof do
    Begin
      case ModeloImpressao of
        0:Begin
            if ( FieldByName('IMP_TIPO').AsString = 'S' ) then
            Begin
              For Lc_I := 1 to FieldByName('IMP_VIAS').AsInteger do
                Imp_Piz_Matr_Caixa_1;
            End
          end;
        1:Begin
            if ( FieldByName('IMP_TIPO').AsString = 'S' ) then
            Begin
              For Lc_I := 1 to FieldByName('IMP_VIAS').AsInteger do
              Imp_Piz_Termica_1;
            End;
          end;
      end;
      Next;
    end;
  end;
end;


procedure TPrintPizzaria.PrepararEnvioWhatsApp;
begin
  M_Pedido := TMemo.Create(Self);
  M_Pedido.Visible := False;
  M_Pedido.Parent := FParentAtual;
  M_Pedido.Font.Name := 'Courier' ;
  M_Pedido.Font.Size := 10;
  M_Pedido.Width := 478;
end;

procedure TPrintPizzaria.printModeloCozinha;
Var
  Lc_I:Integer;
begin
  AbreDadosPedido;
  AbreDadosImpressora;
  with QryDadosImpressora do
  Begin
    While not Eof do
    Begin
      case ModeloImpressao of
        0:Begin
            if ( FieldByName('IMP_TIPO').AsString = 'N' ) then
            Begin
              CodigoImpressora := FieldByName('IMP_CODIGO').AsInteger;
              AbreDadosItensCozinha;
              For Lc_I := 1 to FieldByName('IMP_VIAS').AsInteger do
                Imp_Piz_Matr_Cozin_1;
            End;
          End;
        1:Begin
            Imp_Piz_Termica_1;
          end;
      end;
      Next;
    end;
  end;
end;


procedure TPrintPizzaria.PrintModeloItemCozinha;
Var
  Lc_I:Integer;
begin
  AbreDadosPedido;
  AbreDadosImpressora;
  with QryDadosImpressora do
  Begin
    While not Eof do
    Begin
      case ModeloImpressao of
        0:Begin
            if ( FieldByName('IMP_TIPO').AsString = 'N' ) then
            Begin
              CodigoImpressora := FieldByName('IMP_CODIGO').AsInteger;
              AbreDadosItensCozinha;
              For Lc_I := 1 to FieldByName('IMP_VIAS').AsInteger do
                Imp_Piz_Matr_Cozin_1;
            End;
          End;
        1:Begin
            Imp_Piz_Termica_1;
          end;
      end;
      Next;
    end;
  end;

End;

procedure TPrintPizzaria.Imp_Piz_Matr_Caixa_1;
Var
  Lc_Prin:TPrin;
  lc_I,Lc_IT_Atual,Lc_IT_Prior ,QITENS:Integer;
  Lc_J:Integer;
  Lc_K:Integer;
  Lc_Linha : Integer;
  Lc_Obs : TStringList;
  Lc_ColunaImpressao : Integer;
  Lc_StrAux:String;
  Lc_Tl_Itens : Integer;
  I : Integer;
  ListObs : TStringList;
  Lc_Finaliza: TextFile;
  Lc_Porta : String;
  LcPayBackTaxa: REal;
  LcPayBackMinimo : REal;
  LcPayBackAcumul : REal;
  LcPayBack : TControllerPayBack;
  LcUsouPayPack : Boolean;
  lcValorPayBAck : Real;
  Lc_Endereco: String;
  Lc_Ln_end : Integer;
  Lc_Col_end : Integer;
  Lc_Col_obs : Integer;
  Lc_Ln_obs : Integer;
  Lc_Txt_Obs : String;
Label
  Desvio;
Begin
  Try
    LcPayBack := TControllerPayBack.create(nil);
    Lc_Prin := TPrin.Create(nil);
    With Lc_Prin, QryDadosPedido Do
    begin
      if Visualiza then
        Lc_Porta := PortaVisualiza
      else
        Lc_Porta := QryDadosImpressora.FieldByName('IMP_CAMINHO').AsString;
      Initialize(Lc_Porta);
      Lc_Linha := 0;
      Lc_ColunaImpressao := QryDadosImpressora.FieldByName('IMP_COLUNAS').AsInteger;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto(NomeEstabelecimento,Lc_ColunaImpressao,' '));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto(Fc_MascaraFone(FoneEstabelecimento),Lc_ColunaImpressao,' '));
      Lc_Linha := Lc_Linha + 2;
      case FieldByName('PED_TP_CONTATO').AsInteger of
        0:TextOutLC(Lc_Linha,1,CentralizaTexto('ENTREGA',Lc_ColunaImpressao, '-'));
        1:TextOutLC(Lc_Linha,1,CentralizaTexto('BALCAO',Lc_ColunaImpressao, '-'));
        2:TextOutLC(Lc_Linha,1,CentralizaTexto(FieldByName('EMP_NOME').AsString,Lc_ColunaImpressao, '-'));
      end;
      Lc_Linha := Lc_Linha + 1;
      if (FieldByName('PED_CODWEB').AsInteger > 0) then
        TextOutLC(Lc_Linha,1,CentralizaTexto('ATENDENTE : APP DELIVERY',Lc_ColunaImpressao,' '))
      else
        TextOutLC(Lc_Linha,1,CentralizaTexto('ATENDENTE : ' + NomeUsuario,Lc_ColunaImpressao,' '));
      //Prin.Expandido(False);
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('PEDIDO: ' + StrZero(FieldByName('PED_NUMERO').AsInteger,4,0) + ' | ' + FieldByName('PED_DT_ALTERA').asstring,Lc_ColunaImpressao,' '));
      if FieldByName('PED_TP_CONTATO').AsInteger < 2 then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,copy('CLIENTE  : ' + FieldByName('EMP_NOME').AsString,1,Lc_ColunaImpressao));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,Copy('TELEFONE : ' + Fc_MascaraFone(FieldByName('END_FONE').AsString),1,Lc_ColunaImpressao));
      End;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'ITEM ');
      TextOutLC(Lc_Linha,6,'DESCRICAO');
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 11,'QTDE');
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 6,'VALOR');
      lc_I:=1;
      with QryDadosItensPedido do
      Begin
        Active:=True;
        First;
        FetchAll;
        Lc_IT_Prior:=0;
        For Lc_I:= 1 to RecordCount do
        Begin
          //Imprime item e descrição
          Lc_Linha := Lc_Linha + 1;
          if (FieldByName('ITR_NR_ITEM').AsInteger <> Lc_IT_Prior) then
            TextOutLC(Lc_Linha,1,PAdr(FieldByName('ITR_NR_ITEM').AsString,4));
          TextOutLC(Lc_Linha,6,copy(FieldByName('ITR_DESCRICAO').AsString,1,Lc_ColunaImpressao - 6));
          //Imprime se tiver observção
          if FieldByName('ITR_OBS').AsString<>'' then
          Begin
            Lc_Col_obs := Lc_ColunaImpressao - 7;
            //Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,'');
            Lc_Ln_obs := trunc( Length( FieldByName('ITR_OBS').AsString ) / Lc_Col_obs )+1;
            for Lc_Ln_obs := 1 to Lc_Ln_obs do
            Begin
              Lc_Linha := Lc_Linha + 1;
              if Lc_Ln_obs = 1 then
                TextOutLC(Lc_Linha,7,Copy('Obs: ' + FieldByName('ITR_OBS').AsString,(Lc_Col_obs * (Lc_Ln_obs -1) ),Lc_Col_obs))
              else
                TextOutLC(Lc_Linha,7,Copy('     ' + FieldByName('ITR_OBS').AsString,((Lc_Col_obs+1) * (Lc_Ln_obs -1) ),Lc_Col_obs));
            End;

          end;
          //Imprime quantidade e valor
          if (FieldByName('ITR_QTDE').Asfloat > 0 ) then
          BEgin
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,Lc_ColunaImpressao - 11,PAdr(FieldByName('ITR_QTDE').AsString,4));
            //TextOutLC(Lc_Linha,Lc_ColunaImpressao - 7,PAdr(FloatToStrF(FieldByName('ITR_VL_UNIT').AsFloat,ffFixed,10,2),7));//Alterado para mostrar o subttoal na impress�o linha de baixo
            TextOutLC(Lc_Linha,Lc_ColunaImpressao - 7,PAdr(FloatToStrF(FieldByName('ITR_VL_UNIT').AsCurrency * FieldByName('ITR_QTDE').Asfloat,ffFixed,10,2),7));
          end;
          Lc_IT_Prior := FieldByName('ITR_NR_ITEM').AsInteger;
          Next;
        end;
      end;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
      LcUsouPayPack := False;
      lcValorPayBAck := 0;
      for I := 0 to (FormaPagto.Count - 1) do
      Begin
        Lc_Linha := Lc_Linha + 1;
        if I = 0 then
        Begin
          TextOutLC(Lc_Linha,1,'FORMA PAGTO: ');
          TextOutLC(Lc_Linha,14,Copy(FormaPagto[I].Forma,1,Lc_ColunaImpressao-22));
          TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF( FormaPagto[I].Valor ,ffFixed,10,2),8));
        End
        else
        Begin
          TextOutLC(Lc_Linha,14,Copy(FormaPagto[I].Forma,1,Lc_ColunaImpressao-22));
          TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF( FormaPagto[I].Valor ,ffFixed,10,2),8));
        End;
        if ( not LcUsouPayPack ) then
        Begin
          LcUsouPayPack := ( FormaPagto[I].Forma = 'PAYBACK');
          if LcUsouPayPack then
            lcValorPayBAck :=  FormaPagto[I].Valor;
        End;

      end;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));

      if (FieldByName('PED_VL_PRODUTO').AsCurrency > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'SUBTOTAL..:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_PRODUTO').AsCurrency,ffFixed,10,2),8));
      end;

      if (FieldByName('PED_VL_FRETE').AsCurrency > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'ENTREGA...:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_FRETE').AsCurrency,ffFixed,10,2),8));
      end;

      if (FieldByName('PED_VL_ODESPESA').AsCurrency > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'ADICIONAL.:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_ODESPESA').AsCurrency,ffFixed,10,2),8));
      end;

      if (FieldByName('PED_VL_DESCONTO').AsCurrency > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'DESCONTO..:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(CONCAT('-',FloatToStrF(FieldByName('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2)),8));
      end;

      if LcUsouPayPack then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'PAYBACK...:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(CONCAT('-',FloatToStrF(lcValorPayBAck,ffFixed,10,2)),8));
      end;

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'TOTAL.....:');
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_PEDIDO').AsCurrency-lcValorPayBAck,ffFixed,10,2),8));

      if (StrtoFloatDef(ValorRecebido,0) > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'RECEBIDO..:');
        if LcUsouPayPack then
        Begin
          ValorRecebido := FloatToStrF( StrToFloat(ValorRecebido) - lcValorPayBAck ,ffFixed,10,2);
        end;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(ValorRecebido ,8));
      end;

      if (StrtoFloatDef(ValorTroco,0) > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'TROCO.....:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(ValorTroco,8));
      end;
      //PROGRAMA PAYBACK
      if CodigoConsumidor <> FieldByName('EMP_CODIGO').AsInteger then
      Begin
        if ( Fc_Tb_Geral('L','PAYBACK_IMP_CREDIT','S') = 'S') then
        Begin
          LcPayBackTaxa   := StrToFloatDef(Fc_Tb_Geral('L','PAYBACK_TAXA','0'),0);
          if (  LcPayBackTaxa > 0 ) then
          Begin
            LcPayBackMinimo := StrToFloatDef( Fc_Tb_Geral('L','PAYBACK_VL_MINIMO','0'),0);
            LcPayBack.Parametros.Periodo := False;
            LcPayBack.Parametros.PayBack.Cliente := FieldByName('EMP_CODIGO').AsInteger;
            LcPayBack.Parametros.PayBack.estabelecimento := Estabelecimento;
            LcPayBack.Parametros.PayBack.Ordem := 0;
            LcPayBackAcumul := LcPayBack.getSaldo;
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,CentralizaTexto(Fc_Tb_Geral('L','PAYBACK_TITTLE','0'),Lc_ColunaImpressao, '-'));
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,CentralizaTexto(CONCAT('A CADA COMPRA VOCE PODE GANHAR ', FloatToStrF(LcPayBackTaxa,ffFixed,10,1) ,'% DE RETORNO'),Lc_ColunaImpressao, ' '));
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,CentralizaTexto(CONCAT('JUNTANDO UM VALOR MINIMO DE R$ ', FloatToStrF(LcPayBackMinimo,ffFixed,10,2)),Lc_ColunaImpressao, ' '));
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,CentralizaTexto('VOCE PODE UTILIZAR COMO DESCONTO NA SUA',Lc_ColunaImpressao, ' '));
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,CentralizaTexto('PROXIMA COMPRA COM A GENTE',Lc_ColunaImpressao, ' '));
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,'SALDO DISPONIVEL');
            TextOutLC(Lc_Linha,Lc_ColunaImpressao - 11,PAdr( FloatToStrF(LcPayBackAcumul,ffNumber,10,2) ,11));
          End;
        End;
      End;

      if (FieldByName('PED_TP_CONTATO').AsInteger  = 0 ) then
      Begin
        //bAIRRO
        Lc_Linha := Lc_Linha + 2;

        TextOutLC(Lc_Linha,1,CentralizaTexto(FieldByName('END_BAIRRO').AsString,Lc_ColunaImpressao,'-'));
        Lc_Endereco := FieldByName('END_ENDER').AsString + ', ' + FieldByName('END_NUMERO').AsString;
        if Length(FieldByName('END_COMPLEM').AsString) > 0 then
        Begin
          Lc_Endereco := Lc_Endereco + ' - ' + copy(FieldByName('END_COMPLEM').AsString,1,Lc_ColunaImpressao);
        end;
        Lc_Col_end := Lc_ColunaImpressao;
        //Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'');
        Lc_Ln_end := trunc( Length( Lc_Endereco ) / Lc_Col_end )+1;
        for Lc_Ln_end := 1 to Lc_Ln_end do
        Begin
          Lc_Linha := Lc_Linha + 1;
          if Lc_Ln_end = 1 then
            TextOutLC(Lc_Linha,1,Copy(Lc_Endereco,(Lc_Col_end * (Lc_Ln_end -1) ),Lc_Col_end))
          else
            TextOutLC(Lc_Linha,1,Copy(Lc_Endereco,((Lc_Col_end+1) * (Lc_Ln_end -1) ),Lc_Col_end));
        End;


      End;
      Lc_StrAux := '';
      if Sache then
        Lc_StrAux := 'LEVAR SACHE';



      if Trim(FieldByName('PED_OBS').AsString) <> '' then
      BEgin
        Lc_Col_obs := Lc_ColunaImpressao;
        TextOutLC(Lc_Linha,1,'');
        Lc_Txt_Obs := StringReplace(FieldByName('PED_OBS').AsString, #13#10, ' ', [rfReplaceAll]);
        Lc_Ln_obs := trunc( Length( Lc_Txt_Obs ) / Lc_Col_obs )+1;
        for Lc_Ln_obs := 1 to Lc_Ln_obs do
        Begin
          Lc_Linha := Lc_Linha + 1;
          if Lc_Ln_obs = 1 then
            TextOutLC(Lc_Linha,1,Copy('Obs: ' + Lc_Txt_Obs,(Lc_Col_obs * (Lc_Ln_obs -1) ),Lc_Col_obs))
          else
            TextOutLC(Lc_Linha,1,Copy('     ' + Lc_Txt_Obs,((Lc_Col_obs+1) * (Lc_Ln_obs -1) ),Lc_Col_obs));
        End;
      End;

      //sALTO
      For Lc_K:=1 to QryDadosImpressora.FieldByName('IMP_SALTO').AsInteger do
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'');
      end;
      Reset;
      Finalize;
    end;
  Finally
    //Aciona a Guilhotina
    if ( Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_GUILHOTINA_ONEBYONE','S') = 'S') then
      Pc_AcionaGuilhotinaEpson(Lc_Porta);
    FreeAndNil(Lc_Prin);
    FreeAndNil(LcPayBack);
  End;
end;

procedure TPrintPizzaria.Imp_Piz_Matr_Cozin_1;
Var
  Lc_Prin:TPrin;
  lc_I,Lc_IT_Atual,Lc_IT_Prior ,QITENS:Integer;
  Lc_J:Integer;
  Lc_K:Integer;
  Lc_Linha : Integer;
  Lc_ColunaImpressao : Integer;
  Lc_StrAux:String;
  Lc_Tl_Itens : Integer;
  ListObs :  TStringList;
  Lc_Porta : String;
  LcTitProduto : String;
  Lc_Ln_obs : Integer;
  Lc_Col_obs : Integer;
Label
  Desvio;
Begin
  with QryDadosItensCozinha do
  Begin
    Active:=True;
    FetchAll;
    if recordcount > 0 then
    Begin
      Lc_Prin := TPrin.Create(Self);
      With Lc_Prin  Do
      begin
        Lc_Porta := QryDadosImpressora.FieldByName('IMP_CAMINHO').AsString;
        Initialize(Lc_Porta);
        Lc_Linha := 0;
        Lc_ColunaImpressao := QryDadosImpressora.FieldByName('IMP_COLUNAS').AsInteger;
        Lc_Linha := Lc_Linha + 1;
        case FieldByName('PED_TP_CONTATO').AsInteger of
          0:TextOutLC(Lc_Linha,1,CentralizaTexto('ENTREGA',Lc_ColunaImpressao, '-'));
          1:TextOutLC(Lc_Linha,1,CentralizaTexto('BALCAO',Lc_ColunaImpressao, '-'));
          2:TextOutLC(Lc_Linha,1,CentralizaTexto('MESA',Lc_ColunaImpressao, '-'));
        end;
        if FieldByName('PED_TP_CONTATO').AsInteger = 1 then
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,copy('CLIENTE  : ' + QryDadosPedido.FieldByName('EMP_NOME').AsString,1,Lc_ColunaImpressao));
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,Copy('TELEFONE : ' + Fc_MascaraFone(QryDadosPedido.FieldByName('END_FONE').AsString),1,Lc_ColunaImpressao));
        End;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('PEDIDO: ' + StrZero(QryDadosPedido.FieldByName('PED_NUMERO').AsInteger,4,0),Lc_ColunaImpressao,' '));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(QryDadosPedido.FieldByName('PED_DT_ALTERA').asstring,Lc_ColunaImpressao,' '));
        Lc_Linha := Lc_Linha + 1;

        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'ITEM ');
        TextOutLC(Lc_Linha,6,'DESCRICAO');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 6,'QTDE');

        lc_I:=1;
        First;
        Lc_IT_Prior:=0;
        For Lc_I:= 1 to RecordCount do
        Begin
          //Imprime item e descrição
          Lc_Linha := Lc_Linha + 1;
          if (FieldByName('ITR_NR_ITEM').AsInteger <> Lc_IT_Prior) then
          Begin
            TextOutLC(Lc_Linha,1,PAdr(FieldByName('ITR_NR_ITEM').AsString,4));
            TextOutLC(Lc_Linha,6,FieldByName('GRP_DESCRICAO').AsString);
            Lc_Linha := Lc_Linha + 1;
          End;
          TextOutLC(Lc_Linha,6,copy(FieldByName('ITR_DESCRICAO').AsString,1,Lc_ColunaImpressao - 11));
          //Imprime quantidade e valor
          if (FieldByName('ITR_QTDE').Asfloat > 0 ) then
          BEgin
            TextOutLC(Lc_Linha,Lc_ColunaImpressao - 4,PAdr(FieldByName('ITR_QTDE').AsString,4));
          end;
          //Imprime se tiver observção
          if FieldByName('ITR_OBS').AsString <>'' then
          Begin
            Lc_Col_obs := Lc_ColunaImpressao - 7;
            //Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,'');
            Lc_Ln_obs := trunc( Length( FieldByName('ITR_OBS').AsString ) / Lc_Col_obs )+1;
            for Lc_Ln_obs := 1 to Lc_Ln_obs do
            Begin
              Lc_Linha := Lc_Linha + 1;
              if Lc_Ln_obs = 1 then
                TextOutLC(Lc_Linha,7,Copy('Obs: ' + FieldByName('ITR_OBS').AsString,(Lc_Col_obs * (Lc_Ln_obs -1) ),Lc_Col_obs))
              else
                TextOutLC(Lc_Linha,7,Copy('     ' + FieldByName('ITR_OBS').AsString,((Lc_Col_obs+1) * (Lc_Ln_obs -1) ),Lc_Col_obs));
            End;

          end;
          Lc_IT_Prior := FieldByName('ITR_NR_ITEM').AsInteger;
          Next;
          if ( Lc_IT_Prior <> FieldByName('ITR_NR_ITEM').AsInteger) then
          Begin
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,1,CentralizaTexto('',Lc_ColunaImpressao, '-'));
          End;
        end;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('',Lc_ColunaImpressao, '-'));
        Lc_StrAux := '';
        if Fatiado then
          Lc_StrAux := 'FAVOR FATIAR';
        if Palito  then
        Begin
          if Trim(Lc_StrAux) <> '' then
            Lc_StrAux := Lc_StrAux + '/CORTAR PALITO'
          else
            Lc_StrAux := 'CORTAR PALITO';
        end;

        if Trim(QryDadosPedido.FieldByName('PED_OBS').AsString) <> '' then
          Lc_StrAux := Lc_StrAux + QryDadosPedido.FieldByName('PED_OBS').AsString
        else
          Lc_StrAux := QryDadosPedido.FieldByName('PED_OBS').AsString;

        if Trim(Lc_StrAux) <> '' then
        BEgin
          Lc_Col_obs := Lc_ColunaImpressao;
          TextOutLC(Lc_Linha,1,'');
          Lc_Ln_obs := trunc( Length( Lc_StrAux ) / Lc_Col_obs )+1;
          for Lc_Ln_obs := 1 to Lc_Ln_obs do
          Begin
            Lc_Linha := Lc_Linha + 1;
            if Lc_Ln_obs = 1 then
              TextOutLC(Lc_Linha,1,Copy('Obs: ' + Lc_StrAux,(Lc_Col_obs * (Lc_Ln_obs -1) ),Lc_Col_obs))
            else
              TextOutLC(Lc_Linha,1,Copy('     ' + Lc_StrAux,((Lc_Col_obs+1) * (Lc_Ln_obs -1) ),Lc_Col_obs));
          End;
        End;

       //sALTO
        For Lc_K:=1 to QryDadosImpressora.FieldByName('IMP_SALTO').AsInteger do
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,'');
        end;
        Reset;
        Finalize;
      end;
      FreeAndNil(Lc_Prin);
      Pc_AcionaGuilhotinaEpson(Lc_Porta);
    End;
  End;
End;


procedure TPrintPizzaria.Imp_Piz_Termica_1;
Var
  PrtGeneral : TGeneralPrint;
  Lc_Linha : Integer;
  Lc_ColunaImpressao : Integer;
  lc_I,Lc_IT_Atual,Lc_IT_Prior ,QITENS:Integer;
  Lc_J:Integer;
  Lc_K:Integer;
  Lc_Obs : TStringList;
  Lc_StrAux:String;
  Lc_Tl_Itens : Integer;
  I : Integer;
  ListObs : TStringList;
  Lc_Saltos : Integer;
Label
  Desvio;
Begin
  try
    PrtGeneral := TPrintGeneralFactory.criarPrint('BEMATECH - MP4200');
    With PrtGeneral, QryDadosPedido Do
    begin
      Porta := QryDadosImpressora.FieldByName('IMP_CAMINHO').AsString;
      Lc_Saltos := QryDadosImpressora.FieldByName('IMP_SALTO').AsInteger;
      TamanhoMargem := 3;
      Iniciar;
      Lc_Linha := 0;
      Lc_ColunaImpressao := QryDadosImpressora.FieldByName('IMP_COLUNAS').AsInteger;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,Copy(NomeEstabelecimento,1,Lc_ColunaImpressao));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,Pc_AlinhaC(Fc_MascaraFone(FoneEstabelecimento),Lc_ColunaImpressao,'-'));
      Lc_Linha := Lc_Linha + 2;
      case FieldByName('PED_TP_CONTATO').AsInteger of
        0:TextOutLC(Lc_Linha,1,Pc_AlinhaC('ENTREGA',Lc_ColunaImpressao, '-'));
        1:TextOutLC(Lc_Linha,1,Pc_AlinhaC('BALCAO',Lc_ColunaImpressao, '-'));
        2:TextOutLC(Lc_Linha,1,Pc_AlinhaC(FieldByName('EMP_NOME').AsString,Lc_ColunaImpressao, '-'));
      end;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,Pc_AlinhaC('ATENDENTE : ' + NomeUsuario,Lc_ColunaImpressao,' '));
      //Prin.Expandido(False);
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,Pc_AlinhaC('PEDIDO: ' + StrZero(FieldByName('PED_NUMERO').AsInteger,4,0) + ' | ' + FieldByName('PED_DT_ALTERA').asstring,Lc_ColunaImpressao,' '));
      if FieldByName('PED_TP_CONTATO').AsInteger < 2 then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,Pc_AlinhaC('-',Lc_ColunaImpressao, '-'));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,copy('CLIENTE  : ' + FieldByName('EMP_NOME').AsString,1,Lc_ColunaImpressao));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,Copy('TELEFONE : ' + Fc_MascaraFone(FieldByName('END_FONE').AsString),1,Lc_ColunaImpressao));
      End;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,Pc_AlinhaC('-',Lc_ColunaImpressao, '-'));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'ITEM ');
      TextOutLC(Lc_Linha,6,'DESCRICAO');
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 11,'QTDE');
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 6,'VALOR');
      lc_I:=1;
      with QryDadosItensPedido do
      Begin
        Active:=True;
        First;
        FetchAll;
        Lc_IT_Prior:=0;
        For Lc_I:= 1 to RecordCount do
        Begin
          //Imprime item e descrição
          Lc_Linha := Lc_Linha + 1;
          if (FieldByName('ITR_NR_ITEM').AsInteger <> Lc_IT_Prior) then
            TextOutLC(Lc_Linha,1,PAdr(FieldByName('ITR_NR_ITEM').AsString,4));
          TextOutLC(Lc_Linha,6,copy(FieldByName('ITR_DESCRICAO').AsString,1,Lc_ColunaImpressao - 6));
          //Imprime se tiver observção
          if FieldByName('ITR_OBS').AsString<>'' then
          Begin
            Try
              ListObs := TStringList.Create;
              ExtractStrings(['|'],[], PChar(FieldByName('ITR_OBS').AsString), ListObs);
              for Lc_K := 0 to ( ListObs.count - 1) do
              Begin
                Lc_Linha := Lc_Linha + 1;
                if Lc_K = 0 then
                  TextOutLC(Lc_Linha,6,copy('Obs:  ' + ListObs.Strings[Lc_K],1,Lc_ColunaImpressao - 7))
                else
                  TextOutLC(Lc_Linha,6,copy('      ' + ListObs.Strings[Lc_K],1,Lc_ColunaImpressao - 7))
              End;
            Finally
              FreeAndNil(ListObs);
            End;
          end;
          //Imprime quantidade e valor
          if (FieldByName('ITR_QTDE').Asfloat > 0 ) then
          BEgin
            Lc_Linha := Lc_Linha + 1;
            TextOutLC(Lc_Linha,Lc_ColunaImpressao - 11,PAdr(FieldByName('ITR_QTDE').AsString,4));
            TextOutLC(Lc_Linha,Lc_ColunaImpressao - 7,PAdr(FloatToStrF(FieldByName('ITR_VL_UNIT').AsCurrency,ffFixed,10,2),7));
          end;
          Lc_IT_Prior := FieldByName('ITR_NR_ITEM').AsInteger;
          Next;
        end;
      end;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,Pc_AlinhaC('-',Lc_ColunaImpressao, '-'));
      for I := 0 to (FormaPagto.Count - 1) do
      Begin
        Lc_Linha := Lc_Linha + 1;
        if I = 0 then
        Begin
          TextOutLC(Lc_Linha,1,'FORMA PAGTO: ');
          TextOutLC(Lc_Linha,14,Copy(FormaPagto[I].Forma,1,Lc_ColunaImpressao-22));
          TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF( FormaPagto[I].Valor ,ffFixed,10,2),8));
        End
        else
        Begin
          TextOutLC(Lc_Linha,14,Copy(FormaPagto[I].Forma,1,Lc_ColunaImpressao-22));
          TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF( FormaPagto[I].Valor ,ffFixed,10,2),8));
        End;
      end;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,Pc_AlinhaC('-',Lc_ColunaImpressao, '-'));

      if (FieldByName('PED_VL_PRODUTO').AsCurrency > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'SUBTOTAL..:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_PRODUTO').AsCurrency,ffFixed,10,2),8));
      end;

      if (FieldByName('PED_VL_FRETE').AsCurrency > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'ENTREGA...:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_FRETE').AsCurrency,ffFixed,10,2),8));
      end;

      if (FieldByName('PED_VL_ODESPESA').AsCurrency > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'ADICIONAL.:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_ODESPESA').AsCurrency,ffFixed,10,2),8));
      end;

      if (FieldByName('PED_VL_DESCONTO').AsCurrency > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'DESCONTO..:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2),8));
      end;

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'TOTAL.....:');
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(FloatToStrF(FieldByName('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2),8));

      if (StrtoFloatDef(ValorRecebido,0) > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'RECEBIDO..:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(ValorRecebido ,8));
      end;

      if (StrtoFloatDef(ValorTroco,0) > 0) then
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 20,'TROCO.....:');
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 8,PAdr(ValorTroco,8));
      end;

      //bAIRRO
      if (FieldByName('PED_TP_CONTATO').AsInteger = 0 ) then
      Begin
        Lc_Linha := Lc_Linha + 2;
        TextOutLC(Lc_Linha,1,Pc_AlinhaC(FieldByName('END_BAIRRO').AsString,Lc_ColunaImpressao,'-'));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,Copy(FieldByName('END_ENDER').AsString + ', ' + FieldByName('END_NUMERO').AsString,1,Lc_ColunaImpressao));
        if Length(FieldByName('END_COMPLEM').AsString) > 0 then
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,copy(FieldByName('END_COMPLEM').AsString,1,Lc_ColunaImpressao));
        end;
      End;
      Lc_StrAux := '';
      if Sache then
        Lc_StrAux := 'LEVAR SACHE';

      Lc_Obs := TStringList.Create;

      if Trim(FieldByName('PED_OBS').AsString) <> '' then
        Lc_Obs.Text := Trim(FieldByName('PED_OBS').AsString);
      Lc_Obs.Append(Lc_StrAux);

      For Lc_J:=0 to (Lc_Obs.Count-1) do
      Begin
        if Lc_J=0 then
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,Copy('OBS: '+Lc_Obs.Strings[lc_J],1,Lc_ColunaImpressao));
        end
        else
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,Copy(Lc_Obs.Strings[lc_J],1,Lc_ColunaImpressao));
        end;
      end;
      //sALTO
      For Lc_K:=1 to QryDadosImpressora.FieldByName('IMP_SALTO').AsInteger do
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'');
      end;
      Saltar(Lc_Saltos);
      CortarPapel(0);
      Fechar;
    end;
  finally
    FreeAndNil(PrtGeneral);
  end;
end;


procedure TPrintPizzaria.AbreVendaDEtalhada;
Begin
  with QryDadosPedido do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add(concat(
              'SELECT NFL_DT_EMISSAO, PED_NUMERO, NFL_VL_TL_NOTA ',
                'FROM TB_NOTA_FISCAL tb_nota_fiscal ',
                '  INNER JOIN TB_PEDIDO ',
                '  ON (PED_CODIGO = NFL_CODPED) '
    ));
    if Periodo then
      SQL.Add('WHERE NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ');
    if Periodo then
    Begin
      ParamByName('DATAINI').AsDateTime := DataInicial;
      ParamByName('DATAFIM').AsDAtetime := DataFinal;
    End;
    Active := True;
    FetchAll;
  end;
End;

procedure TPrintPizzaria.PrintVendaDetalhada;
Var
  Lc_Prin:TPrin;
  Lc_Linha : Integer;
  Lc_ColunaImpressao : Integer;
  Lc_Valor : Real;
  Lc_Aux : String;
  Lc_K : Integer;
Begin
  AbreDadosImpressora;
  AbreVendaDEtalhada;
  with QryDadosPedido do
  Begin
    Active:=True;
    FetchAll;
    if recordcount > 0 then
    Begin
      Lc_Prin := TPrin.Create(Self);
      With Lc_Prin  Do
      begin
        Initialize(QryDadosImpressora.FieldByName('IMP_CAMINHO').AsString);
        Lc_Linha := 1;
        Lc_ColunaImpressao := QryDadosImpressora.FieldByName('IMP_COLUNAS').AsInteger;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(NomeEstabelecimento,Lc_ColunaImpressao,' '));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(Fc_MascaraFone(FoneEstabelecimento),Lc_ColunaImpressao,' '));
        Lc_Linha := Lc_Linha + 2;
        TextOutLC(Lc_Linha,1,CentralizaTexto('VENDAS GERAL POR PEDIDO ' ,Lc_ColunaImpressao,' '));
        if Periodo then
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,CentralizaTexto('PERIODO DE '  + DateToStr(DataInicial) + ' ATE ' + DateToStr(DataFinal) ,Lc_ColunaImpressao,' '))
        end;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'NUMERO PEDIDO');
        TextOutLC(Lc_Linha,15,PadR('VALOR DO PEDIDO',Lc_ColunaImpressao - 15));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        First;
        Lc_Valor := 0;
        while not eof do
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,FieldByName('PED_NUMERO').AsString);
          Lc_Aux := copy( FloatToStrF(FieldByName('NFL_VL_TL_NOTA').AsCurrency,ffNumber,10,2),1,Lc_ColunaImpressao - 15);
          TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));
          Lc_Valor := Lc_Valor + FieldByName('NFL_VL_TL_NOTA').AsCurrency;
          next;
        End;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'VALOR TOTAL');
        Lc_Aux := copy( FloatToStrf( Lc_Valor,ffNumber, 10,2) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));
       //sALTO
        For Lc_K:=1 to QryDadosImpressora.FieldByName('IMP_SALTO').AsInteger do
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,'');
        end;
        Reset;
        Finalize;
      end;
      FreeAndNil(Lc_Prin);
    End;
  End;
End;

procedure TPrintPizzaria.AbreVendaPorGrupo;
Begin
  with QryDadosPedido do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT G.grp_descricao, sum(((r.itr_qtde * r.itr_vl_unit) - i.itf_vl_desc )) valor '+
            'FROM TB_NOTA_FISCAL n '+
            '  INNER JOIN TB_PEDIDO p '+
            '  ON (PED_CODIGO = NFL_CODPED) '+
            '  INNER JOIN TB_ITENS_NFL i '+
            '  ON (i.itf_codped = p.ped_codigo) '+
            '  INNER JOIN tb_itens_rtr r '+
            '  ON (r.itr_coditf = i.itf_codigo) '+
            '  inner join tb_produto pr '+
            '  on (pr.pro_codigo = i.itf_codpro) '+
            '  inner join tb_grupos g '+
            '  on (g.grp_codigo = pr.pro_codgrp)');
    if Periodo then
      SQL.Add('WHERE NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ');
    SQL.Add(' GROUP BY 1');
    if Periodo then
    Begin
      ParamByName('DATAINI').AsDateTime := DataInicial;
      ParamByName('DATAFIM').AsDAtetime := DataFinal;
    End;
    Active := True;
    FetchAll;
  End;
End;

procedure TPrintPizzaria.AbreVendaPorGrupoBebidas;
begin
  with QryDadosPedido do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add(concat(
            'SELECT ',
            'substring(g.grp_descricao FROM 1 FOR 3) TIPO, ',
            'substring(ITR_DESCRICAO FROM 1 FOR 18) DESCRICAO, ',
            'sum(r.itr_qtde ) Qtde, ',
            'sum(((r.itr_qtde * r.itr_vl_unit) - i.itf_vl_desc )) valor ',
            'FROM TB_NOTA_FISCAL n ',
            '  INNER JOIN TB_PEDIDO p ',
            '  ON (PED_CODIGO = NFL_CODPED) ',
            '  INNER JOIN TB_ITENS_NFL i ',
            '  ON (i.itf_codped = p.ped_codigo) ',
            '  INNER JOIN tb_itens_rtr r ',
            '  ON (r.itr_coditf = i.itf_codigo) ',
            '  inner join tb_produto pr ',
            '  on (pr.pro_codigo = i.itf_codpro) ',
            '  inner join tb_grupos g ',
            '  on (g.grp_codigo = pr.pro_codgrp) ',
            'where (  G.grp_descricao like ''BEB%'')  '
            ));
    if Periodo then
      SQL.Add(' AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ');
    SQL.Add(' GROUP BY 1,2 ');
    if Periodo then
    Begin
      ParamByName('DATAINI').AsDateTime := DataInicial;
      ParamByName('DATAFIM').AsDAtetime := DataFinal;
    End;
    Active := True;
    FetchAll;
  End;
end;

procedure TPrintPizzaria.AbreVendaPorGrupoMassa;
begin
  with QryDadosPedido do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add(concat(
            'SELECT ',
            'substring(g.grp_descricao FROM 1 FOR 3) TIPO, ',
            'substring(ITR_DESCRICAO FROM 1 FOR 18) DESCRICAO, ',
            'sum(r.itr_qtde ) Qtde, ',
            'sum(((r.itr_qtde * r.itr_vl_unit) - i.itf_vl_desc )) valor ',
            'FROM TB_NOTA_FISCAL n ',
            '  INNER JOIN TB_PEDIDO p ',
            '  ON (PED_CODIGO = NFL_CODPED) ',
            '  INNER JOIN TB_ITENS_NFL i ',
            '  ON (i.itf_codped = p.ped_codigo) ',
            '  INNER JOIN tb_itens_rtr r ',
            '  ON (r.itr_coditf = i.itf_codigo) ',
            '  inner join tb_produto pr ',
            '  on (pr.pro_codigo = i.itf_codpro) ',
            '  inner join tb_grupos g ',
            '  on (g.grp_codigo = pr.pro_codgrp) ',
            'where ( ( G.grp_descricao like ''MASSA%'')  ) '
            ));
    if Periodo then
      SQL.Add(' AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ');
    SQL.Add(' GROUP BY 1,2 ');
    if Periodo then
    Begin
      ParamByName('DATAINI').AsDateTime := DataInicial;
      ParamByName('DATAFIM').AsDAtetime := DataFinal;
    End;
    Active := True;
    FetchAll;
  End;

end;

procedure TPrintPizzaria.AbreVendaPorTamanhoBorda;
begin
  with QryDadosPedido do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add(concat(
            'SELECT ',
            'substring(g.grp_descricao FROM 1 FOR 3) TIPO, ',
            'substring(ITR_DESCRICAO FROM 1 FOR 3) TAMANHO, ',
            'sum(r.itr_qtde ) Qtde, ',
            'sum(((r.itr_qtde * r.itr_vl_unit) - i.itf_vl_desc )) valor ',
            'FROM TB_NOTA_FISCAL n ',
            '  INNER JOIN TB_PEDIDO p ',
            '  ON (PED_CODIGO = NFL_CODPED) ',
            '  INNER JOIN TB_ITENS_NFL i ',
            '  ON (i.itf_codped = p.ped_codigo) ',
            '  INNER JOIN tb_itens_rtr r ',
            '  ON (r.itr_coditf = i.itf_codigo) ',
            '  inner join tb_produto pr ',
            '  on (pr.pro_codigo = i.itf_codpro) ',
            '  inner join tb_grupos g ',
            '  on (g.grp_codigo = pr.pro_codgrp) ',
            'where ( ( G.grp_descricao like ''BORD%'')  ) '
            ));
    if Periodo then
      SQL.Add(' AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ');
    SQL.Add(' GROUP BY 1,2 ');
    if Periodo then
    Begin
      ParamByName('DATAINI').AsDateTime := DataInicial;
      ParamByName('DATAFIM').AsDAtetime := DataFinal;
    End;
    Active := True;
    FetchAll;
  End;

end;

procedure TPrintPizzaria.PrintVendaPorGrupoBebidas;
Var
  Lc_Prin:TPrin;
  Lc_Linha : Integer;
  Lc_ColunaImpressao : Integer;
  Lc_Valor : Real;
  Lc_Qtde : Real;
  Lc_Aux : String;
  Lc_K : Integer;
  LcLenghtText : Integer;
Begin
  AbreDadosImpressora;
  AbreVendaPorGrupoBebidas;
  with QryDadosPedido do
  Begin
    Active:=True;
    FetchAll;
    if recordcount > 0 then
    Begin
      Lc_Prin := TPrin.Create(Self);
      With Lc_Prin  Do
      begin
        Initialize(QryDadosImpressora.FieldByName('IMP_CAMINHO').AsString);
        Lc_Linha := 1;
        Lc_ColunaImpressao := QryDadosImpressora.FieldByName('IMP_COLUNAS').AsInteger;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(NomeEstabelecimento,Lc_ColunaImpressao,' '));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(Fc_MascaraFone(FoneEstabelecimento),Lc_ColunaImpressao,' '));
        Lc_Linha := Lc_Linha + 2;
        TextOutLC(Lc_Linha,1,CentralizaTexto('VENDAS POR GRUPO DE BEBIDAS' ,Lc_ColunaImpressao,' '));
        if Periodo then
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,CentralizaTexto('PERIODO DE '  + DateToStr(DataInicial) + ' ATE ' + DateToStr(DataFinal) ,Lc_ColunaImpressao,' '))
        end;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,' QTDE ');
        TextOutLC(Lc_Linha,8,'DESCRICAO ');
        TextOutLC(Lc_Linha,26,PadR('VALOR VENDA',Lc_ColunaImpressao - 26));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        First;
        Lc_Valor := 0;
        Lc_Qtde := 0;
        while not eof do
        Begin
          Lc_Linha := Lc_Linha + 1;
          //Qtde
          Lc_Aux := FloatToStrF(FieldByName('QTDE').AsFloat,ffNumber,4,0);
          TextOutLC(Lc_Linha,1,PadR(Lc_Aux,6));
          //Tamanho
          LcLenghtText  := Lc_ColunaImpressao - 17;
          TextOutLC(Lc_Linha,8,Copy(concat(' - ',Trim(FieldByName('DESCRICAO').AsString)),1,LcLenghtText));
          //Valor
          Lc_Aux := FloatToStrF(FieldByName('VALOR').AsCurrency,ffNumber,10,2);
          TextOutLC(Lc_Linha,LcLenghtText + 8 ,PadR(Lc_Aux,9));
          Lc_Valor := Lc_Valor + FieldByName('VALOR').AsCurrency;
          Lc_Qtde := Lc_Qtde + FieldByName('QTDE').AsFloat;
          next;
        End;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'QTDE TOTAL');
        Lc_Aux := copy( FloatToStrf( Lc_Qtde,ffNumber, 10,0) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'VALOR ENTREGA');
        Lc_Aux := copy( FloatToStrf( ValorFrete,ffNumber, 10,2) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));
        Lc_Valor := Lc_Valor + StrToFloatDef(Lc_Aux,0);

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'VALOR TOTAL');
        Lc_Aux := copy( FloatToStrf( Lc_Valor,ffNumber, 10,2) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));
       //sALTO
        For Lc_K:=1 to QryDadosImpressora.FieldByName('IMP_SALTO').AsInteger do
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,'');
        end;
        Reset;
        Finalize;
      end;
      FreeAndNil(Lc_Prin);
    End;
  End;


end;

procedure TPrintPizzaria.PrintVendaPorGrupoMassa;
Var
  Lc_Prin:TPrin;
  Lc_Linha : Integer;
  Lc_ColunaImpressao : Integer;
  Lc_Valor : Real;
  Lc_Qtde : Real;
  Lc_Aux : String;
  Lc_K : Integer;
  LcLenghtText : Integer;
Begin
  AbreDadosImpressora;
  AbreVendaPorGrupoMassa;
  with QryDadosPedido do
  Begin
    Active:=True;
    FetchAll;
    if recordcount > 0 then
    Begin
      Lc_Prin := TPrin.Create(Self);
      With Lc_Prin  Do
      begin
        Initialize(QryDadosImpressora.FieldByName('IMP_CAMINHO').AsString);
        Lc_Linha := 1;
        Lc_ColunaImpressao := QryDadosImpressora.FieldByName('IMP_COLUNAS').AsInteger;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(NomeEstabelecimento,Lc_ColunaImpressao,' '));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(Fc_MascaraFone(FoneEstabelecimento),Lc_ColunaImpressao,' '));
        Lc_Linha := Lc_Linha + 2;
        TextOutLC(Lc_Linha,1,CentralizaTexto('VENDAS POR GRUPO DE MASSAS' ,Lc_ColunaImpressao,' '));
        if Periodo then
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,CentralizaTexto('PERIODO DE '  + DateToStr(DataInicial) + ' ATE ' + DateToStr(DataFinal) ,Lc_ColunaImpressao,' '))
        end;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,' QTDE ');
        TextOutLC(Lc_Linha,8,'TIPO/DESCRICAO ');
        TextOutLC(Lc_Linha,26,PadR('VALOR VENDA',Lc_ColunaImpressao - 26));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        First;
        Lc_Valor := 0;
        Lc_Qtde := 0;
        while not eof do
        Begin
          Lc_Linha := Lc_Linha + 1;
          //Qtde
          Lc_Aux := FloatToStrF(FieldByName('QTDE').AsFloat,ffNumber,4,0);
          TextOutLC(Lc_Linha,1,PadR(Lc_Aux,6));
          //Tamanho
          LcLenghtText  := Lc_ColunaImpressao - 17;
          TextOutLC(Lc_Linha,8,Copy(concat(' - ',Trim(FieldByName('DESCRICAO').AsString)),1,LcLenghtText));
          //Valor
          Lc_Aux := FloatToStrF(FieldByName('VALOR').AsCurrency,ffNumber,10,2);
          TextOutLC(Lc_Linha,LcLenghtText + 8 ,PadR(Lc_Aux,9));
          Lc_Valor := Lc_Valor + FieldByName('VALOR').AsCurrency;
          Lc_Qtde := Lc_Qtde + FieldByName('QTDE').AsFloat;
          next;
        End;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'QTDE TOTAL');
        Lc_Aux := copy( FloatToStrf( Lc_Qtde,ffNumber, 10,0) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'VALOR ENTREGA');
        Lc_Aux := copy( FloatToStrf( ValorFrete,ffNumber, 10,2) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));
        Lc_Valor := Lc_Valor + StrToFloatDef(Lc_Aux,0);

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'VALOR TOTAL');
        Lc_Aux := copy( FloatToStrf( Lc_Valor,ffNumber, 10,2) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));
       //sALTO
        For Lc_K:=1 to QryDadosImpressora.FieldByName('IMP_SALTO').AsInteger do
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,'');
        end;
        Reset;
        Finalize;
      end;
      FreeAndNil(Lc_Prin);
    End;
  End;

end;

procedure TPrintPizzaria.PrintVendaPorGrupo;
Var
  Lc_Prin:TPrin;
  Lc_Linha : Integer;
  Lc_ColunaImpressao : Integer;
  Lc_Valor : Real;
  Lc_Aux : String;
  Lc_K : Integer;
Begin
  AbreDadosImpressora;
  AbreVendaPorGrupo;
  with QryDadosPedido do
  Begin
    Active:=True;
    FetchAll;
    if recordcount > 0 then
    Begin
      Lc_Prin := TPrin.Create(Self);
      With Lc_Prin  Do
      begin
        Initialize(QryDadosImpressora.FieldByName('IMP_CAMINHO').AsString);
        Lc_Linha := 1;
        Lc_ColunaImpressao := QryDadosImpressora.FieldByName('IMP_COLUNAS').AsInteger;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(NomeEstabelecimento,Lc_ColunaImpressao,' '));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(Fc_MascaraFone(FoneEstabelecimento),Lc_ColunaImpressao,' '));
        Lc_Linha := Lc_Linha + 2;
        TextOutLC(Lc_Linha,1,CentralizaTexto('VENDAS POR GRUPO DE CARDAPIO' ,Lc_ColunaImpressao,' '));
        if Periodo then
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,CentralizaTexto('PERIODO DE '  + DateToStr(DataInicial) + ' ATE ' + DateToStr(DataFinal) ,Lc_ColunaImpressao,' '))
        end;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'NOME DO GRUPO');
        TextOutLC(Lc_Linha,15,PadR('VALOR VENDA',Lc_ColunaImpressao - 15));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        First;
        Lc_Valor := 0;
        while not eof do
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,FieldByName('grp_descricao').AsString);
          Lc_Aux := copy( FloatToStrF(FieldByName('VALOR').AsCurrency,ffNumber,10,2),1,Lc_ColunaImpressao - 16);
          TextOutLC(Lc_Linha,16,PadR(Lc_Aux,Lc_ColunaImpressao - 15));
          Lc_Valor := Lc_Valor + FieldByName('VALOR').AsCurrency;
          next;
        End;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'VALOR DESCONTO');
        Lc_Aux := copy( FloatToStrf( ValorDesconto,ffNumber, 10,2) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));
        //Lc_Valor := Lc_Valor + StrToFloatDef(Lc_Aux,0);

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'VALOR ADICIONAL');
        Lc_Aux := copy( FloatToStrf( ValorAdicional,ffNumber, 10,2) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));
        Lc_Valor := Lc_Valor + StrToFloatDef(Lc_Aux,0);

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'VALOR ENTREGA');
        Lc_Aux := copy( FloatToStrf( ValorFrete,ffNumber, 10,2) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));
        Lc_Valor := Lc_Valor + StrToFloatDef(Lc_Aux,0);

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'VALOR TOTAL');
        Lc_Aux := copy( FloatToStrf( Lc_Valor,ffNumber, 10,2) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));
       //sALTO
        For Lc_K:=1 to QryDadosImpressora.FieldByName('IMP_SALTO').AsInteger do
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,'');
        end;
        Reset;
        Finalize;
      end;
      FreeAndNil(Lc_Prin);
    End;
  End;
End;

procedure TPrintPizzaria.AbreVendaporTamanhoPizzaCalzone;
Begin
  with QryDadosPedido do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add(concat(
            'SELECT ',
            'substring(g.grp_descricao FROM 1 FOR 3) TIPO, ',
            'substring(ITR_DESCRICAO FROM 1 FOR 3) TAMANHO, ',
            'sum(r.itr_qtde ) Qtde, ',
            'sum(((r.itr_qtde * r.itr_vl_unit) - i.itf_vl_desc )) valor ',
            'FROM TB_NOTA_FISCAL n ',
            '  INNER JOIN TB_PEDIDO p ',
            '  ON (PED_CODIGO = NFL_CODPED) ',
            '  INNER JOIN TB_ITENS_NFL i ',
            '  ON (i.itf_codped = p.ped_codigo) ',
            '  INNER JOIN tb_itens_rtr r ',
            '  ON (r.itr_coditf = i.itf_codigo) ',
            '  inner join tb_produto pr ',
            '  on (pr.pro_codigo = i.itf_codpro) ',
            '  inner join tb_grupos g ',
            '  on (g.grp_codigo = pr.pro_codgrp) ',
            'where ( ( G.grp_descricao like ''PIZZA%'') or ( G.grp_descricao like ''CALZONE%'') ) '
            ));
    if Periodo then
      SQL.Add(' AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ');
    SQL.Add(' GROUP BY 1,2 ');
    if Periodo then
    Begin
      ParamByName('DATAINI').AsDateTime := DataInicial;
      ParamByName('DATAFIM').AsDAtetime := DataFinal;
    End;
    Active := True;
    FetchAll;
  End;
End;


procedure TPrintPizzaria.PrintVendaPorTamanhoBorda;
Var
  Lc_Prin:TPrin;
  Lc_Linha : Integer;
  Lc_ColunaImpressao : Integer;
  Lc_Valor : Real;
  Lc_Qtde : Real;
  Lc_Aux : String;
  Lc_K : Integer;
Begin
  AbreDadosImpressora;
  AbreVendaPorTamanhoBorda;
  with QryDadosPedido do
  Begin
    Active:=True;
    FetchAll;
    if recordcount > 0 then
    Begin
      Lc_Prin := TPrin.Create(Self);
      With Lc_Prin  Do
      begin
        Initialize(QryDadosImpressora.FieldByName('IMP_CAMINHO').AsString);
        Lc_Linha := 1;
        Lc_ColunaImpressao := QryDadosImpressora.FieldByName('IMP_COLUNAS').AsInteger;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(NomeEstabelecimento,Lc_ColunaImpressao,' '));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(Fc_MascaraFone(FoneEstabelecimento),Lc_ColunaImpressao,' '));
        Lc_Linha := Lc_Linha + 2;
        TextOutLC(Lc_Linha,1,CentralizaTexto('VENDAS POR TAMANHO BORDA DE PIZZA' ,Lc_ColunaImpressao,' '));
        if Periodo then
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,CentralizaTexto('PERIODO DE '  + DateToStr(DataInicial) + ' ATE ' + DateToStr(DataFinal) ,Lc_ColunaImpressao,' '))
        end;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,' QTDE ');
        TextOutLC(Lc_Linha,8,'TIPO/TAMANHO ');
        TextOutLC(Lc_Linha,26,PadR('VALOR VENDA',Lc_ColunaImpressao - 26));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        First;
        Lc_Valor := 0;
        Lc_Qtde := 0;
        while not eof do
        Begin
          Lc_Linha := Lc_Linha + 1;
          //Qtde
          Lc_Aux := FloatToStrF(FieldByName('QTDE').AsFloat,ffNumber,4,0);
          TextOutLC(Lc_Linha,1,PadR(Lc_Aux,6));
          //Tamanho
          TextOutLC(Lc_Linha,8,concat(FieldByName('TIPO').AsString,' - ',FieldByName('TAMANHO').AsString));
          //Valor
          Lc_Aux := copy( FloatToStrF(FieldByName('VALOR').AsCurrency,ffNumber,10,2),1,Lc_ColunaImpressao - 15);
          TextOutLC(Lc_Linha,26,PadR(Lc_Aux,Lc_ColunaImpressao - 26));
          Lc_Valor := Lc_Valor + FieldByName('VALOR').AsCurrency;
          Lc_Qtde := Lc_Qtde + FieldByName('QTDE').AsFloat;
          next;
        End;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'QTDE TOTAL');
        Lc_Aux := copy( FloatToStrf( Lc_Qtde,ffNumber, 10,0) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'VALOR ENTREGA');
        Lc_Aux := copy( FloatToStrf( ValorFrete,ffNumber, 10,2) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));
        Lc_Valor := Lc_Valor + StrToFloatDef(Lc_Aux,0);

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'VALOR TOTAL');
        Lc_Aux := copy( FloatToStrf( Lc_Valor,ffNumber, 10,2) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));
       //sALTO
        For Lc_K:=1 to QryDadosImpressora.FieldByName('IMP_SALTO').AsInteger do
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,'');
        end;
        Reset;
        Finalize;
      end;
      FreeAndNil(Lc_Prin);
    End;
  End;


end;

procedure TPrintPizzaria.PrintVendaPorTamanhoPizzaCalzone;
Var
  Lc_Prin:TPrin;
  Lc_Linha : Integer;
  Lc_ColunaImpressao : Integer;
  Lc_Valor : Real;
  Lc_Qtde : Real;
  Lc_Aux : String;
  Lc_K : Integer;
Begin
  AbreDadosImpressora;
  AbreVendaporTamanhoPizzaCalzone;
  with QryDadosPedido do
  Begin
    Active:=True;
    FetchAll;
    if recordcount > 0 then
    Begin
      Lc_Prin := TPrin.Create(Self);
      With Lc_Prin  Do
      begin
        Initialize(QryDadosImpressora.FieldByName('IMP_CAMINHO').AsString);
        Lc_Linha := 1;
        Lc_ColunaImpressao := QryDadosImpressora.FieldByName('IMP_COLUNAS').AsInteger;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(NomeEstabelecimento,Lc_ColunaImpressao,' '));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(Fc_MascaraFone(FoneEstabelecimento),Lc_ColunaImpressao,' '));
        Lc_Linha := Lc_Linha + 2;
        TextOutLC(Lc_Linha,1,CentralizaTexto('VENDAS POR TAMANHO DE PIZZA/CALZONE' ,Lc_ColunaImpressao,' '));
        if Periodo then
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,CentralizaTexto('PERIODO DE '  + DateToStr(DataInicial) + ' ATE ' + DateToStr(DataFinal) ,Lc_ColunaImpressao,' '))
        end;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,' QTDE ');
        TextOutLC(Lc_Linha,8,'TIPO/TAMANHO ');
        TextOutLC(Lc_Linha,26,PadR('VALOR VENDA',Lc_ColunaImpressao - 26));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));
        First;
        Lc_Valor := 0;
        Lc_Qtde := 0;
        while not eof do
        Begin
          Lc_Linha := Lc_Linha + 1;
          //Qtde
          Lc_Aux := FloatToStrF(FieldByName('QTDE').AsFloat,ffNumber,4,0);
          TextOutLC(Lc_Linha,1,PadR(Lc_Aux,6));
          //Tamanho
          TextOutLC(Lc_Linha,8,concat(FieldByName('TIPO').AsString,' - ',FieldByName('TAMANHO').AsString));
          //Valor
          Lc_Aux := copy( FloatToStrF(FieldByName('VALOR').AsCurrency,ffNumber,10,2),1,Lc_ColunaImpressao - 15);
          TextOutLC(Lc_Linha,26,PadR(Lc_Aux,Lc_ColunaImpressao - 26));
          Lc_Valor := Lc_Valor + FieldByName('VALOR').AsCurrency;
          Lc_Qtde := Lc_Qtde + FieldByName('QTDE').AsFloat;
          next;
        End;
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_ColunaImpressao, '-'));

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'QTDE TOTAL');
        Lc_Aux := copy( FloatToStrf( Lc_Qtde,ffNumber, 10,0) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'VALOR ENTREGA');
        Lc_Aux := copy( FloatToStrf( ValorFrete,ffNumber, 10,2) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));
        Lc_Valor := Lc_Valor + StrToFloatDef(Lc_Aux,0);

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'VALOR TOTAL');
        Lc_Aux := copy( FloatToStrf( Lc_Valor,ffNumber, 10,2) ,1,Lc_ColunaImpressao - 15);
        TextOutLC(Lc_Linha,15,PadR(Lc_Aux,Lc_ColunaImpressao - 15));
       //sALTO
        For Lc_K:=1 to QryDadosImpressora.FieldByName('IMP_SALTO').AsInteger do
        Begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,'');
        end;
        Reset;
        Finalize;
      end;
      FreeAndNil(Lc_Prin);
    End;
  End;

end;


procedure TPrintPizzaria.setFParentAtual(const Value: TWinControl);
begin
  FParentAtual := Value
end;


end.
