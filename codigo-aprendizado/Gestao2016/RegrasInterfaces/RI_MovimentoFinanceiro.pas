unit RI_MovimentoFinanceiro;

interface

uses
      Forms, Controls, SysUtils, STQuery, STStoredProc, STDatabase, StdCtrls, classes, db, DBCtrls, Gauges, ACBrValidador, UN_Principal;

  function Fc_VerificaCaixaAberto(msg:Boolean):Boolean;
  function Fc_VerificaCaixaFechadoAtual(): Boolean;



implementation

uses     ControllerDskCashier, Un_DM, Un_Msg, Un_Lanca_Caixa, Un_Lanca_Banco, env, RN_FormaPagto;


function Fc_VerificaCaixaAberto(msg:Boolean):Boolean;
Var
  Lc_Cashier : TControllerDskCashier;
begin
  Try
    Result := False;
    Lc_Cashier := TControllerDskCashier.Create(nil);
    Lc_Cashier.Registro.Usuario := GB_Cd_Usuario;
    if Lc_Cashier.VerificaCaixaAberto then
    Begin
      Gb_CodigoCaixa := Lc_Cashier.Registro.Codigo;
      Gb_DataCaixa := Lc_Cashier.Registro.Data;
      Result := True;
    End
    else
    Begin
      if msg then
      Begin
        MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                       ' Não existe um caixa aberto para este Usuário.' + EOLN +
                       ' Abra o caixa e tente novamente.' + EOLN,
                       ['OK'], [bEscape], mpAlerta);
      End;
    End;
  Finally
    FreeAndNil(Lc_Cashier);
  End;

end;

function Fc_VerificaCaixaFechadoAtual(): Boolean;
Var
  Lc_Cashier : TControllerDskCashier;
begin
  Try
    Lc_Cashier := TControllerDskCashier.Create(nil);
    Lc_Cashier.Registro.Usuario := GB_Cd_Usuario;
    if Lc_Cashier.VerificaCaixaFechadoAtual(Date) then
    Begin
      REsult := True;
      Gb_CodigoCaixa := Lc_Cashier.Registro.Codigo;
      Gb_DataCaixa := Lc_Cashier.Registro.Data;
      MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                     'O último caixa aberto do dia ' + DateToStr(Lc_Cashier.Registro.Data) + ' está fechado.'+EOLN +
                     'O Encerramento foi feito no dia ' + DateTimeToStr(Lc_Cashier.Registro.Fechamento) + EOLN +
                     ' Este caixa só poderá ser aberto no dia seguinte.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
    End
    else
    Begin
      REsult := False;
    End;
  Finally
    FreeAndNil(Lc_Cashier);
  End;
end;

end.
