unit cad_fat_ctrl_icms_st;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Data.DB, Datasnap.Provider, Datasnap.DBClient, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Menus, ControllerCtrlIcmsST, Vcl.StdCtrls, System.Math;

type
  TCadFatCtrlIcmsST = class(TFr_Base)
    Pnl_fundos: TPanel;
    Pnl_botao: TPanel;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    cds_produtos: TClientDataSet;
    Ds_produtos: TDataSource;
    cds_produtosPRO_CODIGO: TIntegerField;
    cds_produtosPRO_DESCRICAO: TWideStringField;
    cds_produtosVBCSTRET: TFMTBCDField;
    cds_produtosPST: TBCDField;
    cds_produtosVICMSSUBSTITUTO: TFMTBCDField;
    cds_produtosVICMSSTRET: TFMTBCDField;
    cds_produtosITF_ORIGEM_ID: TIntegerField;
    cds_produtosITF_DESTINO_ID: TIntegerField;
    cds_produtosQTDE: TIntegerField;
    cds_produtosVLVENDA: TFloatField;
    Label1: TLabel;
    Label2: TLabel;
    DBG_Produtos: TDBGrid;
    cds_produtosMVA: TFloatField;
    cds_produtosncm: TStringField;

    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure cds_produtosMVAChange(Sender: TField);
    procedure cds_produtosPSTChange(Sender: TField);
  private
    FEstabelecimento: Integer;
    procedure setFEstabelecimento(const Value: Integer);
    { Private declarations }
  protected
    procedure CriarVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    function Validasave:Boolean;
    procedure salva;
  public
    { Public declarations }
    CtrlICMSST : TControllerCtrlIcmsST;
    procedure ResetCalculos;
    property Estabelecimento : Integer read FEstabelecimento write setFEstabelecimento;
  end;

var
  CadFatCtrlIcmsST: TCadFatCtrlIcmsST;

implementation

{$R *.dfm}

uses     Un_Msg, env;
{ TCadFatCtrlIcmsST }

procedure TCadFatCtrlIcmsST.cds_produtosMVAChange(Sender: TField);
begin
  inherited;
  cds_produtosVBCSTRET.AsFloat := cds_produtosVLVENDA.AsFloat / cds_produtosMVA.AsFloat;
  cds_produtosVBCSTRET.AsFloat :=   RoundTo(cds_produtosVBCSTRET.AsFloat,-2);
end;

procedure TCadFatCtrlIcmsST.cds_produtosPSTChange(Sender: TField);
begin
  inherited;
  cds_produtosVICMSSUBSTITUTO.AsCurrency := (cds_produtosVBCSTRET.AsFloat * cds_produtosPST.AsFloat ) / 100;
  cds_produtosVICMSSUBSTITUTO.AsCurrency := RoundTo(cds_produtosVICMSSUBSTITUTO.AsCurrency,-2);
  cds_produtosVICMSSTRET.AsCurrency :=  (cds_produtosVLVENDA.AsFloat * cds_produtosPST.AsFloat ) / 100;
  cds_produtosVICMSSTRET.AsCurrency := cds_produtosVICMSSTRET.AsCurrency - cds_produtosVICMSSUBSTITUTO.AsCurrency;
  cds_produtosVICMSSTRET.AsCurrency := RoundTo(cds_produtosVICMSSTRET.AsCurrency,-2);
end;

procedure TCadFatCtrlIcmsST.CriarVariaveis;
begin
  inherited;
  //Talbez mudando o Owner este form não destrua a variavel que foi passada por referencia
  CtrlICMSST := TControllerCtrlIcmsST.create(self);
end;

procedure TCadFatCtrlIcmsST.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(CtrlICMSST);
end;

procedure TCadFatCtrlIcmsST.ResetCalculos;
begin
  cds_produtos.Close;
  cds_produtos.CreateDataSet;
  cds_produtos.EmptyDataSet;
end;

procedure TCadFatCtrlIcmsST.salva;
Var
  I,J : Integer;
begin
  cds_produtos.First;
  while not cds_produtos.Eof do
  BEgin
    for I := 1 to cds_produtosQTDE.AsInteger do
    Begin
      CtrlICMSST.Registro.Estabelecimento     := FEstabelecimento;
      CtrlICMSST.Registro.Codigo              := 0;
      CtrlICMSST.Registro.Origem              := 0;
      CtrlICMSST.Registro.Produto             := cds_produtosPRO_CODIGO.AsInteger;
      CtrlICMSST.Registro.ValorBaseSTRetido   := cds_produtosVBCSTRET.AsFloat / cds_produtosQTDE.AsInteger;
      CtrlICMSST.Registro.AliqST              := cds_produtosPST.AsFloat;
      CtrlICMSST.Registro.ValorICMSSubstituto := cds_produtosVICMSSUBSTITUTO.AsCurrency / cds_produtosQTDE.AsInteger;
      CtrlICMSST.Registro.ValorICMSSTRetido   := cds_produtosVICMSSTRET.AsCurrency / cds_produtosQTDE.AsInteger;
      CtrlICMSST.Registro.Destino             := cds_produtosITF_DESTINO_ID.AsInteger;
      CtrlICMSST.insere;
    End;
    cds_produtos.Next;
  End;

end;

procedure TCadFatCtrlIcmsST.SB_CancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCadFatCtrlIcmsST.SB_GravarClick(Sender: TObject);
begin
  if Validasave then
  Begin
    Salva;
    Close;
  End;
end;

procedure TCadFatCtrlIcmsST.setFEstabelecimento(const Value: Integer);
begin
  FEstabelecimento := Value;
end;

function TCadFatCtrlIcmsST.Validasave: Boolean;
begin
  Result := True;
  while not cds_produtos.Eof do
  BEgin
    if cds_produtosVBCSTRET.AsFloat <= 0 then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Informe a Base de Cálculo ICMS Retido na operação anterior.' + EOLN +
                     'Verifique a lista.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      break;
    end;
    if cds_produtosPST.AsFloat <= 0 then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Informe a Alíquota suportada pelo Consumidor Final.' + EOLN +
                     'Verifique a lista.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      break;
    end;
    if cds_produtosVICMSSUBSTITUTO.AsCurrency <= 0 then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Informe o Valor do ICMS próprio do Substituto.' + EOLN +
                     'Verifique a lista.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      break;
    end;
    if cds_produtosVICMSSTRET.AsCurrency <= 0 then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Informe o Valor do ICMS ST Retido na operação anterior.' + EOLN +
                     'Verifique a lista.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      break;
    end;
    cds_produtos.Next;
  End;
  if not Result then
  Begin
    Exit;
  End;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
              'Confirma a inclusão no Cadastro de ICMS ST Retido? ' + EOLN + EOLN +
              'Confirmar a operação ?',
              [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao2) then
  Begin
    REsult := False;
    exit;
  End;

end;
end.
