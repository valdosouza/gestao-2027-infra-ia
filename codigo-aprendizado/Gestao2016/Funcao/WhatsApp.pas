unit WhatsApp;

interface


uses     System.Classes, REST.Client, REST.Types, Jsons, System.JSON, System.Math, System.SysUtils, STQuery, ControllerPayBack, System.Net.Mime, PrintPizzaria, ControllerRestaurante, Vcl.Forms, PagamentoEscolhido, ControllerWhatsAppCFG, ShellAPI, ControllerSendWhatsApp, System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent, System.IniFiles, Winapi.Windows;

type

  TWhatsApp = class(TComponent)
  private
    FWhatsAppCFG : TControllerWhatsAppCFG;
    FSendWhatsApp : TControllerSendWhatsApp;
    FReceiverNumber: String;
    FMensagem: String;
    FArquivo: String;
    function TrataNumber9(Number:String):String;
    procedure setFReceiverNumber(const Value: String);
    procedure setFMensagem(const Value: String);
    procedure setFArquivo(const Value: String);
    function valida:boolean;
    function  Ativo:Boolean;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RegisterMessage;
    procedure Send;

    property ReceiverNumber : String read FReceiverNumber write setFReceiverNumber;
    property Mensagem : String  read FMensagem write setFMensagem;
    property Arquivo : String  read FArquivo write setFArquivo;
  end;

implementation

{ TWhatsApp }

uses     UN_Sistema, Un_Funcoes, Un_DM, REST.JSON, Vcl.Dialogs, UN_MSG, env;


function TWhatsApp.Ativo: Boolean;
begin
  Result := ( Fc_Tb_Geral('L','WTA_LC_ATIVO','N') = 'S');
  if not Result then
  Begin
    MensagemPadrao( ATENCAO,
                   'O Envio do WhatsApp não está ativo.'+EOLN+
                   'Verifique com a Setes sobre os valores para liberação.'+EOLN+
                   'Clique em OK continuar .'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
  End;
end;

constructor TWhatsApp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWhatsAppCFG := TControllerWhatsAppCFG.create(self);
  FSendWhatsApp := TControllerSendWhatsApp.create(self);
end;

destructor TWhatsApp.Destroy;
begin
  FreeAndNil( FSendWhatsApp );
  FreeAndNil( FWhatsAppCFG );
  inherited;
end;


procedure TWhatsApp.RegisterMessage;
Begin
  if valida then
  Begin
    if FArquivo = EmptyStr then
    Begin
      FWhatsAppCFG.Registro.Descricao := 'TEXTO';
      FWhatsAppCFG.getByDescription;
      if FWhatsAppCFG.exist then
      Begin
        with FSendWhatsApp do
        Begin
          Registro.Estabelecimento := Gb_CodMha;
          Registro.Codigo := 0;
          Registro.NumeroEnviado := FReceiverNumber;
          Registro.Mensagem := FMensagem;
        End;
        FSendWhatsApp.Insert;
      End;
    End
    else
    Begin
      FWhatsAppCFG.Clear;
      FWhatsAppCFG.Registro.Descricao := 'ARQUIVO';
      FWhatsAppCFG.getByDescription;
      if FWhatsAppCFG.exist then
      Begin
        with FSendWhatsApp do
        Begin
          Registro.Estabelecimento := Gb_CodMha;
          Registro.Codigo := 0;
          Registro.NumeroEnviado := FReceiverNumber;
          Registro.Mensagem := FMensagem;
          Registro.PathFile := FArquivo;
        End;
        FSendWhatsApp.Insert;
      End;
    End;
  End;
end;

procedure TWhatsApp.Send;
begin
  WinExec(pAnsichar('SendWhatsApp.exe'),SW_NORMAL);
end;

procedure TWhatsApp.setFArquivo(const Value: String);
begin
  FArquivo := Value;
end;

procedure TWhatsApp.setFMensagem(const Value: String);
begin
  FMensagem := Value;
end;

procedure TWhatsApp.setFReceiverNumber(const Value: String);
Var
  Lc_Number : String;
begin
  Lc_Number := Fc_RemoveCaracterInformado(Value, ['(',')','-',' ']);
  case Length(Lc_Number) of
    8:Begin //'9911-2072'
        //quando o DDD for maior que 30 não colocar o 9
        FReceiverNumber := concat('5541',Lc_Number)
      End;
    9:Begin //'9-9911-2072'
        //quando o DDD for maior que 30 não colocar o 9
        FReceiverNumber := Copy(Lc_Number,2,8);
      End;
    10:Begin //41-9911-2072
        FReceiverNumber := TrataNumber9(Lc_Number);
      End;
    11:Begin //41-9-9911-2072
        FReceiverNumber := TrataNumber9(Lc_Number);
      End;
    else
    Begin
      FReceiverNumber := Lc_Number;
    End;
  end;
end;



function TWhatsApp.TrataNumber9(Number: String): String;
Var
  Lc_ddd: Integer;
begin
  Lc_ddd := StrToIntDef( Copy(Number,1,2),41);
  case Length(Number) of
    10:Begin //41-9911-2072
        if Lc_ddd > 30 then
          Result := concat('55',Number)
        else
          Result := concat('55',Lc_ddd.ToString(),'9',Copy(Number,3,8));
      End;
    11:Begin //41-9-9911-2072
        if Lc_ddd > 30 then
          Result := concat('55',Lc_ddd.ToString(),Copy(Number,4,8))
        else
          Result := concat('55',Number);
      End;
    else
    Begin
      FReceiverNumber := Number;
    End;
  end;

end;

function TWhatsApp.valida: boolean;
begin
  result := True;
  if not Ativo then
  Begin
    result := False;
    Exit;
  End;
  //'55-41-9-9911-2072' para dd menor ou igual que 30
  //'55-41-9911-2072' para dd maior que 30 não tem o 9 extra
  if Length(FReceiverNumber)<12 then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Número do whastApp parece estar errado.'+EOLN+
                   'Fone : ' + FReceiverNumber+'.'+EOLN+
                   'Verifique para continuar .'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    result := False;
    Exit;
  End;

end;

end.
