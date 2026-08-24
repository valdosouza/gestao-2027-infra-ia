unit Un_EnviaPedidoNota;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, Mask, QEdit_Setes, STDatabase, DB, STTransaction;

type
  TFr_EnviaPedidoNota = class(TForm)
    Pnl_CopiaDoc: TPanel;
    SB_Env_CopiaDoc: TSpeedButton;
    Sb_Can_CopiaDoc: TSpeedButton;
    Label4: TLabel;
    Rg_TipoMovimentacao: TRadioGroup;
    Rg_TipoDoc: TRadioGroup;
    E_Nr_Doc: TEdit_Setes;
    IBD_BancoDestino: TSTDatabase;
    IB_Transacao: TSTTransaction;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    E_Tx_Altera_Unit: TEdit_Setes;
    Rb_Acrescimo: TRadioButton;
    Rb_Desconto: TRadioButton;
    procedure SB_Env_CopiaDocClick(Sender: TObject);
    procedure Sb_Can_CopiaDocClick(Sender: TObject);
    procedure Rg_TipoDocClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    It_cd_Pedido : Integer;
    It_Tipo_Pedido : Integer;
    It_Confirma :Boolean;
    procedure Pc_FormataTela;
    procedure Pc_ImagemBotao;
    function Fc_ValidaCopia: boolean;

  end;

var
  Fr_EnviaPedidoNota: TFr_EnviaPedidoNota;

implementation

uses     UN_Principal, env, UN_MSG, RN_Pedido, RN_Crud, Un_Funcoes, UN_Sistema;
{$R *.dfm}


procedure TFr_EnviaPedidoNota.Pc_FormataTela;
begin
  Pc_ImagemBotao;
end;

procedure TFr_EnviaPedidoNota.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Painel da Copia
    SB_Env_CopiaDoc.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    SB_Can_CopiaDoc.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    END;
end;

function TFr_EnviaPedidoNota.Fc_ValidaCopia: boolean;
Var
  Lc_Result:TStringList;
  Lc_Texto:String;
  lc_Valor : Array of String;
  Lc_Cd_empresa : Integer;
begin
  Result:= true;
  if TRIM(E_Nr_Doc.Text) ='' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Preencha com o número válido '+EOLN+
                   'para copiar copiar os itens.'+EOLN,
               ['OK'],[bEscape],mpAlerta);
    result:=false;
    E_Nr_Doc.SetFocus;
    exit;
  end;

  Lc_Result := TStringList.Create;
  if Rg_TipoDoc.itemindex = 0 then
  Begin
    SetLength(Lc_Valor,3);
    Lc_Texto := 'Pedido';
    //Campos para pesquisar
    //Valores para pesquisar
    Lc_Valor[0] := E_Nr_Doc.Text;
    case Rg_TipoMovimentacao.ItemIndex of
      0:Lc_Valor[1] := '2';
      1:Lc_Valor[1] := '1';
      2:Lc_Valor[1] := '3';
      end;
    Lc_Valor[2] := IntToStr( gb_codmha);
    Lc_Result := Fc_VerificaRegistro('TB_PEDIDO',['PED_NUMERO','PED_TIPO','PED_CODMHA'],lc_valor,['PED_CODIGO']);
  end
  else
  Begin
    Lc_Texto := 'Nota Fiscal';
    //Valores para pesquisar
    SetLength(Lc_Valor,3);
    Lc_Valor[0] := StrZero(StrToIntDef(E_Nr_Doc.Text,0),6,0);
    Lc_Valor[1] := 'SI';
    Lc_Valor[2] := IntToStr(gb_codmha);
    Lc_Result := Fc_VerificaRegistro('TB_NOTA_FISCAL',['NFL_NUMERO','NFL_TIPO','NFL_CODMHA'],Lc_Valor,['NFL_CODPED']);
  end;

  It_cd_Pedido := StrToIntDef(Lc_Result.Strings[0],0);
  if (It_cd_Pedido = 0)  then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   ' Número de ' + Lc_Texto + ' informado não encontrado. ' +EOLN +
                   ' Verifique e tente novamente.'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result:=false;
    exit;
  end;

  //FAz a conexão com o banco de dados
  try
    if not IBD_BancoDestino.Connected then
    Begin
      IBD_BancoDestino.Connected := false;
      IBD_BancoDestino.DatabaseName := trim(Fc_Tb_Geral('L','PED_G_BANCO_DESTINO',''));
      IBD_BancoDestino.Connected := True;
    End;
  except
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   ' Não foi possivel conectar ao banco de dados de destino. ' +EOLN +
                   ' Verifique e tente novamente.'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result:=false;
    exit;
  end;
end;

procedure TFr_EnviaPedidoNota.SB_Env_CopiaDocClick(Sender: TObject);
Var
  Lc_Altera:String;
  Lc_Tx_Altera : Real;
  Result : boolean;
begin
  if Fc_ValidaCopia then
  Begin
    Lc_Tx_Altera := StrToFloatDef(E_Tx_Altera_Unit.Text,0);
    Lc_Altera := 'N';
    if Lc_Tx_Altera > 0 then
    Begin
      if Rb_Acrescimo.Checked then
        Lc_Altera := 'A'
      else
        Lc_Altera := 'D'
    end;
    Result := Fc_EnviaPedido(IBD_BancoDestino, IB_Transacao, It_cd_Pedido,It_Tipo_Pedido,Lc_Altera,Lc_Tx_Altera);
    if Result then
    Begin
      MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                     'Pedido enviado com sucesso'+EOLN,
                     ['OK'],[bEscape],mpInformacao);
      Close;
    End
    else
    BEgin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Não foi possível enviar o pedido'+EOLN,
                     ['OK'],[bEscape],mpErro);
    End;
  end;
end;

procedure TFr_EnviaPedidoNota.Sb_Can_CopiaDocClick(Sender: TObject);
begin
  It_Confirma := False;
  Close;
end;

procedure TFr_EnviaPedidoNota.Rg_TipoDocClick(Sender: TObject);
begin
  IF Rg_TipoDoc.ItemIndex = 0 then
    Begin
    Rg_TipoMovimentacao.Enabled := True;
    Rg_TipoMovimentacao.ItemIndex := 0;
    end
  else
    Begin
    Rg_TipoMovimentacao.Enabled := False;
    Rg_TipoMovimentacao.ItemIndex := -1;
    end;    
end;

procedure TFr_EnviaPedidoNota.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
end;

end.
