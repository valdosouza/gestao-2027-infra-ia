unit Un_tr_send_email_estoque_negativo;

interface

uses     Classes, SysUtils, Un_tr_send_email, ControllerBase, STQuery;

type
  // Envio de email automatico avisando produto com estoque zerado/negativo.
  // Usa o remetente automatico do sistema (sistemanfe@setes.com.br).
  TTRSendEmailEstoqueNegativo = class(TTRSendEmail)
  private
    FCodigoProduto    : Integer;
    FDescricaoProduto : String;
    FSaldoEstoque     : Real;
    FDataHora         : TDateTime;
    FCodigoPedido     : Integer;
    FBaseController   : TControllerBase;
    FQry              : TSTQuery;
    procedure GerarDadosPedido;
  protected
    function preparar: Boolean; override;
    function gerarCorpo: String; override;
  public
    constructor Create;
    destructor Destroy; override;

    property CodigoProduto    : Integer   read FCodigoProduto    write FCodigoProduto;
    property CodigoPedido     : Integer   read FCodigoPedido     write FCodigoPedido;
    property DescricaoProduto : String    read FDescricaoProduto write FDescricaoProduto;
    property SaldoEstoque     : Real      read FSaldoEstoque     write FSaldoEstoque;
    property DataHora         : TDateTime read FDataHora         write FDataHora;
  end;

implementation

uses
un_sistema;

{ TTRSendEmailEstoqueNegativo }

function TTRSendEmailEstoqueNegativo.preparar: Boolean;
var
  LcDestino : String;
begin
  LcDestino := '';

  // Fc_Tb_Geral acessa o banco -> precisa rodar na thread principal.
  Synchronize(
    procedure
    begin
      LcDestino := Trim(Fc_Tb_Geral('L', 'EST_IDENTIF_EMAIL', ''));
    end
  );

  if LcDestino = '' then
  Begin
    Result := False;
    Exit;
  End;

  FAssunto := 'Produto com estoque igual ou menor que zero';

  FDestino.Clear;
  FDestino.Add(LcDestino);
  FAnexo.Clear;
  FAnexo.Add('Sem anexo');

  configurarRemetenteAutomatico;

  GerarDadosPedido;

  Result := True;
end;


constructor TTRSendEmailEstoqueNegativo.Create;
begin
  inherited Create;
  FBaseController := TControllerBase.Create(nil);
  FQry := FBaseController.GeraQuery;
end;

destructor TTRSendEmailEstoqueNegativo.Destroy;
begin
  FBaseController.FinalizaQuery( FQry );
  FreeAndNil( FBaseController );
  inherited;
end;

function TTRSendEmailEstoqueNegativo.gerarCorpo: String;
var
  Lc_tipoPedido : String;
begin
  if ( FCodigoPedido > 0 ) then
    case FQry.FieldByName('PED_TIPO').AsInteger of
      1:Lc_tipoPedido := 'Pedido de Venda: ';
      2:Lc_tipoPedido := 'Pedido de Compra:';
      3:Lc_tipoPedido := 'Pedido de Ajuste:';
      4:Lc_tipoPedido := 'Pedido de Venda:';
    end;

  Result := concat(
                 '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> ',
                 '<html> ',
                 '<head> ',
                 '  <meta content="text/html; charset=ISO-8859-1" ',
                 ' http-equiv="content-type"> ',
                 '  <title>Produto com estoque igual ou menor que zero</title> ',
                 '</head> ',
                 '<body> ',
                 '<table style="text-align: left; width: 605px; height: 116px;"  ',
                 ' border="1" cellpadding="0" cellspacing="0"> ',
                 '  <tbody> ');

  if ( FCodigoPedido > 0 ) then
    Result := concat(Result,
                 '    <tr> ',
                 '      <td style="width: 159px;">Nº Pedido&nbsp;</td> ',
                 '      <td style="width: 790px;">',Lc_tipoPedido, FQry.FieldByName('PED_NUMERO').AsString ,'</td> ',
                 '    </tr> ');

  if ( FCodigoPedido > 0 ) then
    Result := concat(Result,
                 '    <tr> ',
                 '      <td style="width: 159px;">Data&nbsp;</td> ',
                 '      <td style="width: 790px;">',FQry.FieldByName('PED_DATA').AsString ,'</td> ',
                 '    </tr> ');

  if ( FCodigoPedido > 0 ) then
    Result := concat(Result,
                 '    <tr> ',
                 '      <td style="width: 159px;">Login Usuário&nbsp;</td> ',
                 '      <td style="width: 790px;">' , FQry.FieldByName('USU_LOGIN').AsString ,'</td> ',
                 '    </tr> ');

    Result := concat(Result,
                 '    <tr> ',
                 '      <td style="width: 159px;">Codigo Produto&nbsp;</td> ',
                 '      <td style="width: 790px;">' , IntToStr(FCodigoProduto) ,'</td> ',
                 '    </tr> ',

                 '    <tr> ',
                 '      <td style="width: 159px;">Descricao do produto</td> ',
                 '      <td style="width: 790px;">', FDescricaoProduto + '</td> ',
                 '    </tr>  ',

                 '    <tr> ',
                 '      <td style="width: 159px;">Saldo </td> ',
                 '      <td style="width: 790px;">' , FloatToStrF(FSaldoEstoque, ffFixed, 10, 2) ,'</td> ',
                 '    </tr> ',

                 '    <tr> ',
                 '      <td style="width: 159px;">Data e Hora </td> ',
                 '      <td style="width: 790px;">' , DateTimeToStr(FDataHora) ,'</td> ',
                 '    </tr> ',

                 '  </tbody> ',
                 '</table> ',
                 '</body> ',
                 '</html> '
  );
end;

procedure TTRSendEmailEstoqueNegativo.GerarDadosPedido;
begin
  if ( FCodigoPedido > 0 ) then
  Begin
    FQry.Active := False;
    FQry.SQL.Add(concat(
          'SELECT PED_CODIGO, PED_NUMERO,PED_DATA, PED_TIPO, USU_LOGIN ',
          'FROM TB_PEDIDO ',
          '   INNER JOIN TB_USUARIO ',
          '   ON (USU_CODIGO = PED_CODUSU) ',
          'WHERE PED_CODIGO=:PED_CODIGO '
    ));
    FQry.ParamByName('PED_CODIGO').AsInteger := FCodigoPedido;
    FQry.Active := True;
  End;
end;

end.
