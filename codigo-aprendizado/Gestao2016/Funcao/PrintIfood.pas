unit PrintIfood;

interface

uses
      System.Classes, ControllerIfoodOrder, STQuery, BematechPrint, EpsonPrint, System.SysUtils, tblIfoodOrderItems, tblIfoodOrderItemsOptions, tblIfoodOrderBenefits, tblIfoodOrderPayment, GeneralPrint;

type
  TPrintIfood = class(TComponent)
  private
    OrderIfood : TControllerIfoodOrder;
    QryDadosImpressora:TSTQuery;
    Prin:TGeneralPrint;
    Linha : Integer;
    ColunaImpressao : Integer;
    FNomeEstabelecimento: String;
    procedure setFOrdem(const Value: String);
    procedure AbreDadosImpressora;
    procedure printPrincipal;

    procedure printCozinha;

    procedure printCabecalho;
    procedure printRestaurante;
    procedure printTime;
    procedure printCustomer;
    procedure printItems;
    procedure printRodape;

    procedure setFNomeEstabelecimento(const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Principal;
    procedure Cozinha;
    property Ordem : String write setFOrdem;
    property NomeEstabelecimento :String read FNomeEstabelecimento write setFNomeEstabelecimento;
  end;
implementation

{ TPrintIfood }

uses     Un_Regra_Negocio, UN_Sistema;
procedure TPrintIfood.AbreDadosImpressora;
begin
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
            '  IMP_COLUNAS, '+
            '  IMP_MODELO '+
            'FROM TB_IMPRESSORA ');
    Active := True;
    FetchAll;
  end;
end;


procedure TPrintIfood.Cozinha;
Var
  Lc_I:Integer;
begin
  Prin := nil;
  Prin := TPrintGeneralFactory.criarPrint(QryDadosImpressora.FieldByName('IMP_MODELO').AsString);

  AbreDadosImpressora;
  with QryDadosImpressora do
  Begin
    While not Eof do
    Begin
      if ( FieldByName('IMP_TIPO').AsString = 'N' ) then
      Begin
        For Lc_I := 1 to FieldByName('IMP_VIAS').AsInteger do
          printCozinha;
      End;
      Next;
    end;
  end;
end;

constructor TPrintIfood.Create(AOwner: TComponent);
begin
  inherited;
  OrderIfood := TControllerIfoodOrder.Create(Self);
  QryDadosImpressora := OrderIfood.GeraQuery;
  AbreDadosImpressora;
end;

destructor TPrintIfood.Destroy;
begin
  OrderIfood.FinalizaQuery(QryDadosImpressora);
  FreeAndNil(OrderIfood);
  FreeAndNil(Prin);
  inherited;
end;

procedure TPrintIfood.Principal;
Var
  Lc_I:Integer;
begin
  Prin := nil;
  Prin := TPrintGeneralFactory.criarPrint(QryDadosImpressora.FieldByName('IMP_MODELO').AsString);
  AbreDadosImpressora;
  with QryDadosImpressora do
  Begin
    While not Eof do
    Begin
      if ( FieldByName('IMP_TIPO').AsString = 'S' ) then
      Begin
        For Lc_I := 1 to FieldByName('IMP_VIAS').AsInteger do
          printPrincipal;
      End;
      Next;
    end;
  end;
end;

procedure TPrintIfood.printCabecalho;
begin
  With  Prin, OrderIfood Do
  begin
    //Linha := Linha + 1;
    TextOutLC(Linha,1,CentralizaTexto('iFood',ColunaImpressao ,' '));
    //Linha := Linha + 1;
    TextOutLC(Linha,1,CentralizaTexto('-',ColunaImpressao, '-'));
    //Linha := Linha + 1;
    TextOutLC(Linha,1,CentralizaTexto(concat('PEDIDO: #',Registro.DisplayId),ColunaImpressao ,' '));
    //Linha := Linha + 1;
    TextOutLC(Linha,1,CentralizaTexto(concat('LOCALIZADOR DO PEDIDO: #',Customer.Registro.LOCALIZER),ColunaImpressao ,' '));
    //Linha := Linha + 1;
    TextOutLC(Linha,1,CentralizaTexto('ENTREGA PROPRIA',ColunaImpressao ,' '));
    //Linha := Linha + 1;
    TextOutLC(Linha,1,CentralizaTexto('-',ColunaImpressao, '-'));
  end;

end;

procedure TPrintIfood.printCozinha;
Begin
  With Prin, OrderIfood Do
  begin
    Linha := 0;
    Porta := QryDadosImpressora.FieldByName('IMP_CAMINHO').AsString;
    ColunaImpressao := QryDadosImpressora.FieldByName('IMP_COLUNAS').AsInteger;
    Iniciar;
    printCabecalho;
    printTime;
    printItems;
    Saltar(QryDadosImpressora.FieldByName('IMP_SALTO').AsInteger);
    CortarPapel(0);
    Reset;
    Fechar;
  end;
end;

procedure TPrintIfood.printCustomer;
Var
  LcAux:String;
begin
  With Prin, OrderIfood Do
  begin
    if (OrderIfood.Customer.Registro.ORDERCOUNTONMERCHANT <= 1) then
      TextOutLC(Linha,1,'Primeiro pedidona sua loja')
    else
      TextOutLC(Linha,1,concat(OrderIfood.Customer.Registro.ORDERCOUNTONMERCHANT.ToString, ' pedidos na sua loja'));
    //Linha := Linha + 1;
    TextOutLC(Linha,1,'');
    //Linha := Linha + 1;
    TextOutLC(Linha,1,'Dados do cliente');
    //Linha := Linha + 1;
    TextOutLC(Linha,1,concat('Nome: ',Customer.Registro.NAME));
    //Linha := Linha + 1;
    TextOutLC(Linha,1,concat('Telefone: ',Customer.Registro.PHONENUMBER,' ID: ',Customer.Registro.LOCALIZER));

    LcAux := concat('Endereco: ',Delivery.Registro.StreetName,', ',Delivery.Registro.StreetNumber );
    if Length(LcAux) <= ColunaImpressao then
    Begin
      //Linha := Linha + 1;
      TextOutLC(Linha,1,LcAux);
    End
    else
    Begin
      //Linha := Linha + 1;
      TextOutLC(Linha,1,Copy(LcAux,1,ColunaImpressao));
      //Linha := Linha + 1;
      TextOutLC(Linha,1,Copy(LcAux,ColunaImpressao+1,ColunaImpressao));
    End;

    //Linha := Linha + 1;
    TextOutLC(Linha,1,concat('Bairro: ',Delivery.Registro.NeighBorHood));

    if (Delivery.Registro.Complement <> '') then
    Begin
      //Linha := Linha + 1;
      TextOutLC(Linha,1,concat('Comp: ',Delivery.Registro.Complement));
    End;

    if (Delivery.Registro.Reference <> '') then
    Begin
      //Linha := Linha + 1;
      TextOutLC(Linha,1,concat('Ref: ',Delivery.Registro.Reference));
    End;

    //Linha := Linha + 1;
    TextOutLC(Linha,1,concat('Cidade: ',Delivery.Registro.City,' - ',Delivery.Registro.State));
    //Linha := Linha + 1;
    TextOutLC(Linha,1,concat('CEP: ',Delivery.Registro.PostalCode));
  end;
end;

procedure TPrintIfood.printItems;
Var
  I,J,K: Integer;
  LcItem: TIfoodOrderItems;
  LcSubOptions: TIfoodOrderItemsOptions;
  Lc_TamDescItem : Integer;
  Lc_Quant : String;
  Lc_DescItem : String;
  Lc_Preco : String;
  Lc_Ln_obs : Integer;
  Lc_Col_obs : Integer;
begin
  With Prin, OrderIfood Do
  begin
    //Linha := Linha + 1;
    TextOutLC(Linha,1,'');

    //Linha := Linha + 1;
    TextOutLC(Linha,1,'ITens do pedido');
    //Linha := Linha + 1;
    TextOutLC(Linha,1,concat('Qtde  Item',Padr('Preco',ColunaImpressao-10) ));

    OrderIfood.Items.Registro.OrderId := OrderIfood.Registro.Codigo;
    OrderIfood.Items.getList;
    for I := 0 to OrderIfood.Items.Lista.Count -1 do
    Begin
      LcItem := OrderIfood.Items.Lista[I];
      //Linha := Linha + 1;

      //TextOutLC(Linha,1,FloatToStr(LcItem.QUANTITY));

      Lc_Quant := PadL(FloatToStr(LcItem.QUANTITY),4);
      Lc_Preco := PAdr(FloatToStrF( LcItem.TOTALPRICE ,ffFixed,10,2),7);

      Lc_TamDescItem := ColunaImpressao - 11;
      if (Length(LcItem.NAME) > Lc_TamDescItem) then
      Begin
        Lc_DescItem := Copy(LcItem.NAME,1,Lc_TamDescItem);
        TextOutLC(Linha,1,concat(Lc_Quant,Lc_DescItem));
        //Linha := Linha + 1;
        Lc_DescItem := Copy(LcItem.NAME,Lc_TamDescItem+1,Lc_TamDescItem);
        TextOutLC(Linha,8,concat(PADL(Lc_DescItem,Lc_TamDescItem),Lc_Preco));
      End
      else
      Begin
        TextOutLC(Linha,1,concat(Lc_Quant,PadL(LcItem.NAME,Lc_TamDescItem),Lc_Preco));
      End;

      //TextOutLC(Linha,ColunaImpressao - 7,Lc_Preco);
      OrderIfood.Items.Option.Registro.OrderId      := LcItem.OrderId;
      OrderIfood.Items.Option.Registro.OrderItemsId := LcItem.ID;
      OrderIfood.Items.Option.getList;
      for J := 0 to OrderIfood.Items.Option.Lista.Count-1 do
      Begin
        LcSubOptions := OrderIfood.Items.Option.Lista[J];
        //Linha := Linha + 1;

        Lc_Quant := PadL(FloatToStr(LcSubOptions.QUANTITY),3);
        Lc_Preco := PAdr(FloatToStrF( LcSubOptions.PRICE ,ffFixed,10,2),7);
        Lc_TamDescItem := ColunaImpressao - 14;
        if (Length(LcSubOptions.NAME) > Lc_TamDescItem) then
        Begin
          Lc_DescItem := Copy(LcSubOptions.NAME,1,Lc_TamDescItem);
          TextOutLC(Linha,5,concat(Lc_Quant,Lc_DescItem));
          //Linha := Linha + 1;
          Lc_DescItem := Copy(LcSubOptions.NAME,Lc_TamDescItem+1,Lc_TamDescItem);
          TextOutLC(Linha,8,concat(PadL(Lc_DescItem,Lc_TamDescItem),lc_preco));
        End
        else
        Begin
          TextOutLC(Linha,5,concat(Lc_Quant,Padl(LcSubOptions.NAME,Lc_TamDescItem),Lc_Preco));
        End;
        //TextOutLC(Linha,ColunaImpressao - 7,PAdr(FloatToStrF( LcSubOptions.PRICE ,ffFixed,10,2),8));
      End;
      if ( Length(Trim( LcItem.OBSERVATIONS ))>0 ) then
      Begin
        Lc_Col_obs := ColunaImpressao - 4;
        //Lc_Linha := Lc_Linha + 1;
        TextOutLC(Linha,1,'');
        Lc_Ln_obs := trunc( Length( LcItem.OBSERVATIONS ) / Lc_Col_obs )+1;
        for Lc_Ln_obs := 1 to Lc_Ln_obs do
        Begin
          if Lc_Ln_obs = 1 then
            TextOutLC(Linha,5,Copy('Obs: ' + LcItem.OBSERVATIONS,(Lc_Col_obs * (Lc_Ln_obs -1) ),Lc_Col_obs))
          else
            TextOutLC(Linha,5,Copy('     ' + LcItem.OBSERVATIONS,((Lc_Col_obs+1) * (Lc_Ln_obs -1) ),Lc_Col_obs));
        End;
      End;
      //Espaço entre os itens
      //Linha := Linha + 1;
      TextOutLC(Linha,1,'');
    End;
  end;
end;

procedure TPrintIfood.printPrincipal;
Begin
  With Prin, OrderIfood Do
  begin
    Linha := 0;
    Porta := QryDadosImpressora.FieldByName('IMP_CAMINHO').AsString;
    ColunaImpressao := QryDadosImpressora.FieldByName('IMP_COLUNAS').AsInteger;
    TamanhoMargem := 3;
    Iniciar;
    OrderIfood.Customer.Registro.OrderId := OrderIfood.Registro.Codigo;
    OrderIfood.Customer.getbyId;
    OrderIfood.Delivery.Registro.OrderId := OrderIfood.Registro.Codigo;
    OrderIfood.Delivery.getbyId;
    printCabecalho;
    printRestaurante;
    printCustomer;
    printItems;
    printRodape;
    Saltar(QryDadosImpressora.FieldByName('IMP_SALTO').AsInteger);
    CortarPapel(0);
    Reset;
    Fechar;
  end;
end;

procedure TPrintIfood.printRestaurante;
begin
  With Prin, OrderIfood Do
  begin
    //Linha := Linha + 1;
    TextOutLC(Linha,1,(concat('Restaurante: ',FNomeEstabelecimento)));
    printTime;
    //Linha := Linha + 1;
    TextOutLC(Linha,1,'Solicite o codigo de confirmacao na hora da entrega');
  end;
end;

procedure TPrintIfood.printRodape;
Var
  Lc_TotalBenefits : Real;
  I:Integer;
  LcBenefits : TIfoodOrderBenefits;
  LcPayment : TIfoodOrderPayment;
  Lc_TamDoc: Integer;
Begin
  With Prin, OrderIfood Do
  begin
    Total.Registro.OrderId := OrderIfood.Registro.Codigo;
    Total.getbyId;

    //Pega os dados de Beneficios para somar com o total price
    Benefits.Registro.Ordem := OrderIfood.Registro.Codigo;
    Benefits.getList;
    Lc_TotalBenefits := 0;
    for I := 0 to OrderIfood.Benefits.Lista.Count-1 do
    Begin
      Lc_TotalBenefits := Lc_TotalBenefits + OrderIfood.Benefits.Lista[I].TotalValue;
    End;

    //Linha := Linha + 1;
    TextOutLC(Linha,1,CentralizaTexto('-',ColunaImpressao, '-'));
    //Linha := Linha + 1;
    TextOutLC(Linha,1,concat(padl('Valor total do pedido',ColunaImpressao-8),PAdr(FloatToStrF(OrderIfood.Total.Registro.SUBTOTAL,ffFixed,10,2),8) ));

    //Linha := Linha + 1;
    TextOutLC(Linha,1,concat(padl('Taxa de entrega',ColunaImpressao-8),PAdr(FloatToStrF(OrderIfood.Total.Registro.DELIVERYFEE,ffFixed,10,2),8) ));

    //Linha := Linha + 1;
    for I := 0 to OrderIfood.Benefits.Lista.Count-1 do
    Begin
      Lcbenefits := OrderIfood.Benefits.Lista[I];
      Linha := Linha + I;
      TextOutLC(Linha,1,CentralizaTexto('-',ColunaImpressao, '-'));

      //Linha := Linha + 1;
      if (Lcbenefits.IfoodValue > 0) then
      Begin
        TextOutLC(Linha,1,concat(padl('Incentivos IFood',ColunaImpressao-8),PAdr(FloatToStrF(Lcbenefits.IfoodValue,ffFixed,10,2),8) ));
      End;
      if (Lcbenefits.MerchantValue > 0) then
      Begin
        TextOutLC(Linha,1,concat(padl('Incentivos da Loja',ColunaImpressao-8),PAdr(FloatToStrF(Lcbenefits.MerchantValue,ffFixed,10,2),8) ));
      End;
    End;

    Payment.Registro.OrderId := OrderIfood.Registro.Codigo;
    Payment.getList;
    //Linha := Linha + 1;
    //Linha := Linha + 1;
    TextOutLC(Linha,1,'Forma de Pagamento');
    //Linha := Linha + 1;
    for I := 0 to OrderIfood.Payment.Lista.Count-1 do
    Begin
      LcPayment := OrderIfood.Payment.Lista[I];
      if LcPayment.Tipo = 'ONLINE' then
      Begin


        TextOutLC(Linha,1,concat(padl(concat('Via Ifood - ',LcPayment.Metodo,' - ', LcPayment.MarcaCartao),ColunaImpressao-8),PAdr(FloatToStrF(LcPayment.Valor,ffFixed,10,2),8)));
        TextOutLC(Linha,1,CentralizaTexto('-',ColunaImpressao, '-'));
        TextOutLC(Linha,1,concat(padl('Cobrar Cliente',ColunaImpressao-8),PAdr(FloatToStrF(0,ffFixed,10,2),8) ));
        TextOutLC(Linha,1,CentralizaTexto('-',ColunaImpressao, '-'));


      End
      else
      Begin
        TextOutLC(Linha,1,concat(padl(LcPayment.Metodo,ColunaImpressao-8),PAdr(FloatToStrF(LcPayment.Valor,ffFixed,10,2),8) ));

        if (LcPayment.TrocoPara > 0) then
        Begin
          TextOutLC(Linha,1,concat(padl('Valor a Receber em Dinheiro : ' ,ColunaImpressao-8),PAdr(FloatToStrF(LcPayment.TrocoPara,ffFixed,10,2),8) ));
          TextOutLC(Linha,1,concat(padl('Valor para levar de troco : ',ColunaImpressao-8),PAdr(FloatToStrF(LcPayment.ValorTroco,ffFixed,10,2),8) ));
        End;
        TextOutLC(Linha,1,CentralizaTexto('-',ColunaImpressao, '-'));
        TextOutLC(Linha,1,concat(padl('Cobrar Cliente',ColunaImpressao-8),PAdr(FloatToStrF(OrderIfood.Total.Registro.PENDINGVALUE,ffFixed,10,2),8) ));
        TextOutLC(Linha,1,CentralizaTexto('-',ColunaImpressao, '-'));
      End;
    End;
    Lc_TamDoc := Length(OrderIfood.Customer.Registro.DOCUMENTNUMBER);
    if ( Lc_TamDoc >0) then
    Begin
      //Linha := Linha + 1;
      TextOutLC(Linha,1,concat('Incluir CPF na Nota Fiscal: ',OrderIfood.Customer.Registro.DOCUMENTNUMBER));
    End;
  end;
end;


procedure TPrintIfood.printTime;
begin
  With Prin, OrderIfood Do
  begin
    //Linha := Linha + 1;
    TextOutLC(Linha,1,(concat('Data: ', DateTimeToStr(Registro.CreatedAt))));
    if Registro.OrderTiming ='SCHEDULED' then
    Begin
      //Linha := Linha + 1;
      TextOutLC(Linha,1,concat(
            'Entrega Agendada entre: ',
            Copy(TimeToStr(Registro.DeliveryDateTimeStar),1,5),
            ' - ',
            Copy(TimeToStr(Registro.DeliveryDateTimeEnd),1,5)));
    End
    else
    Begin
      //Linha := Linha + 1;
      TextOutLC(Linha,1,concat(
            'Entrega Prevista: ',DateTimeToStr(Registro.DeliveryDateTime)));
    End;
    //Linha := Linha + 1;
    TextOutLC(Linha,1,'');
  end;
end;

procedure TPrintIfood.setFNomeEstabelecimento(const Value: String);
begin
  FNomeEstabelecimento := Value;
end;

procedure TPrintIfood.setFOrdem(const Value: String);
begin
  OrderIfood.Registro.Codigo := Value;
  OrderIfood.getbyId;
end;

end.
