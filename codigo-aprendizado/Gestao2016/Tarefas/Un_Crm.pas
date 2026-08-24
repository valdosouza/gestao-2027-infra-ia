unit Un_Crm;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, StdCtrls, ComCtrls, ExtCtrls, Gauges, DB, STQuery, Mask, QEdit_Setes;

type

  TFr_Crm = class(TForm)
    SB_Qualificar: TSpeedButton;
    SB_Sair: TSpeedButton;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    E_DataIni: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    E_DataFim: TDateTimePicker;
    GroupBox3: TGroupBox;
    Label15: TLabel;
    E_Vl_Manual_1: TEdit_Setes;
    E_Vl_Manual_2: TEdit_Setes;
    E_Vl_Manual_3: TEdit_Setes;
    E_Vl_Manual_4: TEdit_Setes;
    E_Vl_Manual_5: TEdit_Setes;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Sb_Imprimir: TSpeedButton;
    Lb_Status: TLabel;
    GroupBox5: TGroupBox;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    E_Vl_Sistema_1: TEdit_Setes;
    E_Vl_Sistema_2: TEdit_Setes;
    E_Vl_Sistema_3: TEdit_Setes;
    E_Vl_Sistema_4: TEdit_Setes;
    E_Vl_Sistema_5: TEdit_Setes;
    GroupBox4: TGroupBox;
    Label21: TLabel;
    E_Qt_Sistema_1: TEdit_Setes;
    E_Qt_Sistema_2: TEdit_Setes;
    E_Qt_Sistema_3: TEdit_Setes;
    E_Qt_Sistema_4: TEdit_Setes;
    E_Qt_Sistema_5: TEdit_Setes;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    E_Vl_Periodo_1: TEdit_Setes;
    E_Vl_Periodo_2: TEdit_Setes;
    E_Vl_Periodo_3: TEdit_Setes;
    E_Vl_Periodo_4: TEdit_Setes;
    E_Vl_Periodo_5: TEdit_Setes;
    GroupBox8: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    E_Qt_Periodo_1: TEdit_Setes;
    E_Qt_Periodo_2: TEdit_Setes;
    E_Qt_Periodo_3: TEdit_Setes;
    E_Qt_Periodo_4: TEdit_Setes;
    E_Qt_Periodo_5: TEdit_Setes;
    Qr_Vendas: TSTQuery;
    sb_analise: TSpeedButton;
    sb_atualizar: TSpeedButton;
    Qr_Tabela: TSTQuery;
    Qr_ZeraEstrela: TSTQuery;
    Panel1: TPanel;
    ChBx_TabManual: TCheckBox;
    Panel2: TPanel;
    ChBx_ClienteMovim: TCheckBox;
    ChBx_RelPos: TCheckBox;
    ChBx_ClassGeral: TCheckBox;
    ChBx_TabAuto: TCheckBox;
    procedure Sb_ImprimirClick(Sender: TObject);
    procedure SB_SairClick(Sender: TObject);
    procedure sb_analiseClick(Sender: TObject);
    procedure SB_QualificarClick(Sender: TObject);
    procedure sb_atualizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChBx_TabAutoClick(Sender: TObject);
    procedure ChBx_TabManualClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    It_Vl_Class_1: Currency;
    It_Vl_Class_2: Currency;
    It_Vl_Class_3: Currency;
    It_Vl_Class_4: Currency;
    It_Vl_Class_5: Currency;
    It_Cla_Atual : String;
  public
    { Public declarations }
    It_Imprimir:Boolean;
    It_Qualifica:boolean;
    It_Atualizar:Boolean;
    It_Analise:Boolean;        
    It_Visualizar:Boolean;
    procedure Pc_Classificacao(Pc_Tipo : Char);
    procedure Pc_Segmentacao(Pc_Tipo : Char);
    function Fc_Totalvendas(Fc_Tipo : Char):Real;
    function Fc_TotalCliente(Fc_Res : Char; Fc_Tipo : Char; Pc_Vl_Min : Real; Pc_Vl_Max : Real):Integer;


    procedure Pc_Qualificacao(Pc_Tipo : Char);
    procedure Pc_AtualizaClientes;
    procedure Pc_AtualizaTabela;
    procedure Pc_PreencheTela;
    procedure Pc_PermissaoBotao(Pc_Menu: string);    
  end;


var
  Fr_Crm: TFr_Crm;

implementation

uses     Un_RL_Crm, Un_DM, UN_MSG, UN_Sistema, Un_Funcoes, Un_Principal, env;
{$R *.dfm}

procedure TFr_Crm.Pc_PreencheTela;
Begin
  Lb_Status.Caption := 'Preenchendo com os Dados';
  Application.ProcessMessages;
  Qr_Tabela.Active := True;
  Qr_Tabela.First;

  //1º Estela
  E_Vl_Sistema_1.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_VL_GERAL').AsCurrency,ffNumber,10,2);
  E_Qt_Sistema_1.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_QT_GERAL').AsFloat,ffNumber,10,0);
  E_Vl_Periodo_1.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_VL_PERIODO').AsCurrency,ffNumber,10,2);
  E_Qt_Periodo_1.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_QT_PERIODO').AsFloat,ffNumber,10,0);
  E_Vl_Manual_1.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_VL_MANUAL').AsCurrency,ffNumber,10,2);
  Qr_Tabela.Next;

  //º Estela
  E_Vl_Sistema_2.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_VL_GERAL').AsCurrency,ffNumber,10,2);
  E_Qt_Sistema_2.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_QT_GERAL').AsFloat,ffNumber,10,0);
  E_Vl_Periodo_2.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_VL_PERIODO').AsCurrency,ffNumber,10,2);
  E_Qt_Periodo_2.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_QT_PERIODO').AsFloat,ffNumber,10,0);
  E_Vl_Manual_2.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_VL_MANUAL').AsCurrency,ffNumber,10,2);
  Qr_Tabela.Next;

  //3º Estela
  E_Vl_Sistema_3.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_VL_GERAL').AsCurrency,ffNumber,10,2);
  E_Qt_Sistema_3.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_QT_GERAL').AsFloat,ffNumber,10,0);
  E_Vl_Periodo_3.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_VL_PERIODO').AsCurrency,ffNumber,10,2);
  E_Qt_Periodo_3.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_QT_PERIODO').AsFloat,ffNumber,10,0);
  E_Vl_Manual_3.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_VL_MANUAL').AsCurrency,ffNumber,10,2);
  Qr_Tabela.Next;

  //4º Estela
  E_Vl_Sistema_4.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_VL_GERAL').AsCurrency,ffNumber,10,2);
  E_Qt_Sistema_4.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_QT_GERAL').AsFloat,ffNumber,10,0);
  E_Vl_Periodo_4.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_VL_PERIODO').AsCurrency,ffNumber,10,2);
  E_Qt_Periodo_4.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_QT_PERIODO').AsFloat,ffNumber,10,0);
  E_Vl_Manual_4.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_VL_MANUAL').AsCurrency,ffNumber,10,2);
  Qr_Tabela.Next;

  //5º Estela
  E_Vl_Sistema_5.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_VL_GERAL').AsCurrency,ffNumber,10,2);
  E_Qt_Sistema_5.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_QT_GERAL').AsFloat,ffNumber,10,0);
  E_Vl_Periodo_5.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_VL_PERIODO').AsCurrency,ffNumber,10,2);
  E_Qt_Periodo_5.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_QT_PERIODO').AsFloat,ffNumber,10,0);
  E_Vl_Manual_5.Text := FloatToStrF(Qr_Tabela.FieldByName('CRM_VL_MANUAL').AsCurrency,ffNumber,10,2);
  Lb_Status.Caption := 'Dados Preenchidos';
  Application.ProcessMessages;
end;



function TFr_Crm.Fc_Totalvendas(Fc_Tipo : Char):Real;
Var
  Lc_Venda: TSTQuery;
  Lc_SqlTxt : String;
BEgin
  Screen.Cursor:=crHourGlass;
  Lb_Status.Caption := 'Calculando Total de Vendas';
  Application.ProcessMessages;
  Lc_Venda := TSTQuery.Create(Self);
  Lc_Venda.Database := DM.IBD_Gestao;
  Lc_Venda.Transaction := DM.IB_Transacao;
  Lc_Venda.SQL.Clear;

  Lc_SqlTxt := 'SELECT SUM(NFL_VL_TL_NOTA) as NFL_TOTAL '+
            'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
            '    INNER JOIN TB_PEDIDO tb_pedido '+
            '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
            'WHERE (NFL_CODIGO IS NOT NULL) AND (PED_TIPO = 1) ';

  if Fc_Tipo = 'P' then Lc_SqlTxt := Lc_SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';

  Lc_Venda.SQL.Add(Lc_SqlTxt);
  if Fc_Tipo = 'P' then Lc_Venda.ParamByName('DATAINI').AsDate:=E_DataINI.Date;
  if Fc_Tipo = 'P' then Lc_Venda.ParamByName('DATAFIM').AsDate:=E_DataFim.Date;
  Lc_Venda.Active := True;
  Lc_Venda.First;
  Screen.Cursor:=crDefault;

  Result := Lc_Venda.FieldByName('NFL_TOTAL').AsCurrency;
  Lb_Status.Caption := 'Total de Vendas Calculado';
  Application.ProcessMessages;
  Lc_Venda.Destroy;
  Lc_Venda := nil;
end;

function TFr_Crm.Fc_TotalCliente(Fc_Res : Char; Fc_Tipo : Char; Pc_Vl_Min : Real; Pc_Vl_Max : Real):Integer;
Var
  Lc_Venda: TSTQuery;
  Lc_SqlTxt : String;
BEgin
  Screen.Cursor:=crHourGlass;
  Lb_Status.Caption := 'Calculando total de Cliente';
  Application.ProcessMessages;
  Lc_Venda := TSTQuery.Create(Self);
  Lc_Venda.Database := DM.IBD_Gestao;
  Lc_Venda.Transaction := DM.IB_Transacao;
  Lc_Venda.SQL.Clear;

  Lc_SqlTxt := 'SELECT DISTINCT COUNT(NFL_CODEMP) as NFL_TOTAL '+
            'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
            '    INNER JOIN TB_PEDIDO tb_pedido '+
            '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
            'WHERE (NFL_CODIGO IS NOT NULL) AND (PED_TIPO = 1) ';


  if Fc_Res = 'P' then Lc_SqlTxt := Lc_SqlTxt +'AND (NFL_VL_TL_NOTA BETWEEN :VL_MIN AND :VL_MAX)  ';
  if Fc_Tipo = 'P' then Lc_SqlTxt := Lc_SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';

  Lc_Venda.SQL.Add(Lc_SqlTxt);
  if Fc_Tipo = 'P' then Lc_Venda.ParamByName('DATAINI').AsDate:=E_DataINI.Date;
  if Fc_Tipo = 'P' then Lc_Venda.ParamByName('DATAFIM').AsDate:=E_DataFim.Date;
  if Fc_Res = 'P' then Lc_Venda.ParamByName('VL_MIN').AsCurrency := Pc_Vl_Min;
  if Fc_Res = 'P' then Lc_Venda.ParamByName('VL_MAX').AsCurrency := Pc_Vl_Max;
  Lc_Venda.Active := True;
  Lc_Venda.First;
  Screen.Cursor:=crDefault;

  Result := Lc_Venda.FieldByName('NFL_TOTAL').AsInteger;
  Lb_Status.Caption := 'Total de Clientes Calculados';
  Application.ProcessMessages;
  Lc_Venda.Destroy;
  Lc_Venda := nil;
end;

procedure TFr_Crm.Pc_Qualificacao(Pc_Tipo : Char);
VaR
  Lc_SqlTxt:String;
  Lc_Cliente, Lc_Vendedor, Lc_Data:Boolean;
begin
  Screen.Cursor:=crHourGlass;
  Lb_Status.Caption := 'Qualificando os Clientes';
  Application.ProcessMessages;
  Qr_Vendas.Close;
  Qr_Vendas.SQL.Clear;
  Lc_SqlTxt := 'SELECT DISTINCT NFL_CODEMP, SUM(NFL_VL_TL_NOTA) TOTAL '+
               'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
               '    INNER JOIN TB_PEDIDO tb_pedido '+
               '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
               'WHERE (NFL_CODIGO IS NOT NULL) AND (PED_TIPO = 1) ';

  if Pc_Tipo = 'P' then Lc_SqlTxt := Lc_SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';

  Lc_SqlTxt := Lc_SqlTxt +'GROUP BY NFL_CODEMP ';

  Qr_Vendas.SQL.Add(Lc_SqlTxt);
  if Pc_Tipo = 'P' then Qr_Vendas.ParamByName('DATAINI').AsDate:=E_DataINI.Date;
  if Pc_Tipo = 'P' then Qr_Vendas.ParamByName('DATAFIM').AsDate:=E_DataFim.Date;
  Qr_Vendas.Open;
  Pc_AtualizaClientes();

  Lb_Status.Caption := 'Qualificação executada com Sucesso.';
  Application.ProcessMessages;
  Screen.Cursor:=crDefault;

end;

procedure TFr_Crm.Pc_Classificacao(Pc_Tipo : Char);
Var
  Lc_Valor : Real;
  Lc_Qtde : Integer;
  lc_Media : Real;
Begin
  Lb_Status.Caption := 'Criando Quadro de Classificação';
  Application.ProcessMessages;
  Lc_Valor := Fc_Totalvendas(Pc_Tipo);
  Lc_Qtde := Fc_TotalCliente('T',Pc_Tipo,0,0);
  if Lc_Qtde > 0 then
    lc_Media := Lc_Valor / Lc_Qtde
  else
    lc_Media := Lc_Valor;

  It_Vl_Class_1 := lc_Media - (lc_Media* 0.80);
  It_Vl_Class_2 := lc_Media - (lc_Media* 0.60);
  It_Vl_Class_3 := lc_Media;
  It_Vl_Class_4 := lc_Media + (lc_Media* 0.60);
  It_Vl_Class_5 := lc_Media + (lc_Media* 0.80);
  If Pc_Tipo = 'T' then
    Begin
    E_Vl_Sistema_1.Text := FloatToStrF(It_Vl_Class_1,ffNumber,10,2);
    E_Vl_Sistema_2.Text := FloatToStrF(It_Vl_Class_2,ffNumber,10,2);
    E_Vl_Sistema_3.Text := FloatToStrF(It_Vl_Class_3,ffNumber,10,2);
    E_Vl_Sistema_4.Text := FloatToStrF(It_Vl_Class_4,ffNumber,10,2);
    E_Vl_Sistema_5.Text := FloatToStrF(It_Vl_Class_5,ffNumber,10,2);
    end
  else
    Begin
    E_Vl_Periodo_1.Text := FloatToStrF(It_Vl_Class_1,ffNumber,10,2);
    E_Vl_Periodo_2.Text := FloatToStrF(It_Vl_Class_2,ffNumber,10,2);
    E_Vl_Periodo_3.Text := FloatToStrF(It_Vl_Class_3,ffNumber,10,2);
    E_Vl_Periodo_4.Text := FloatToStrF(It_Vl_Class_4,ffNumber,10,2);
    E_Vl_Periodo_5.Text := FloatToStrF(It_Vl_Class_5,ffNumber,10,2);
    end;
  Lb_Status.Caption := 'Quadro de Classificação Concluído.';
  Application.ProcessMessages;
end;

procedure TFr_Crm.Pc_Segmentacao(Pc_Tipo : Char);
Var
  Lc_Qtde_1, Lc_Qtde_2,Lc_Qtde_3,Lc_Qtde_4,Lc_Qtde_5 : Integer;
Begin
  Lb_Status.Caption := 'Executando Segmentação de Clientes.';
  Application.ProcessMessages;
  Lc_Qtde_1 := Fc_TotalCliente('P',Pc_Tipo,0,It_Vl_Class_1);
  Lc_Qtde_2 := Fc_TotalCliente('P',Pc_Tipo,It_Vl_Class_1 + 0.01 ,It_Vl_Class_2);
  Lc_Qtde_3 := Fc_TotalCliente('P',Pc_Tipo,It_Vl_Class_2 + 0.01,It_Vl_Class_3);
  Lc_Qtde_4 := Fc_TotalCliente('P',Pc_Tipo,It_Vl_Class_3 + 0.01,It_Vl_Class_4);
  Lc_Qtde_5 := Fc_TotalCliente('P',Pc_Tipo,It_Vl_Class_4 + 0.01,1000000);

  If Pc_Tipo = 'T' then
    Begin
    E_Qt_Sistema_1.Text := FloatToStrF(Lc_Qtde_1,ffNumber,10,0);
    E_Qt_Sistema_2.Text := FloatToStrF(Lc_Qtde_2,ffNumber,10,0);
    E_Qt_Sistema_3.Text := FloatToStrF(Lc_Qtde_3,ffNumber,10,0);
    E_Qt_Sistema_4.Text := FloatToStrF(Lc_Qtde_4,ffNumber,10,0);
    E_Qt_Sistema_5.Text := FloatToStrF(Lc_Qtde_5,ffNumber,10,0);
    end
  else
    Begin
    E_Qt_Periodo_1.Text := FloatToStrF(Lc_Qtde_1,ffNumber,10,0);
    E_Qt_Periodo_2.Text := FloatToStrF(Lc_Qtde_2,ffNumber,10,0);
    E_Qt_Periodo_3.Text := FloatToStrF(Lc_Qtde_3,ffNumber,10,0);
    E_Qt_Periodo_4.Text := FloatToStrF(Lc_Qtde_4,ffNumber,10,0);
    E_Qt_Periodo_5.Text := FloatToStrF(Lc_Qtde_5,ffNumber,10,0);
    end;
  Lb_Status.Caption := 'Segmentação de Clientes Concluida.';
  Application.ProcessMessages;
end;

procedure TFr_Crm.Pc_AtualizaClientes;
Var
  Lc_Atualiza: TSTQuery;
  Lc_SqlTxt : String;
BEgin
  Screen.Cursor:=crHourGlass;
  Lc_Atualiza := TSTQuery.Create(Self);
  Lc_Atualiza.Database := DM.IBD_Gestao;
  Lc_Atualiza.Transaction := DM.IB_Transacao;
  Lc_Atualiza.SQL.Clear;

  Lc_SqlTxt := 'UPDATE TB_EMPRESA '+
               'SET '+
               '   EMP_CLASSE = :EMP_CLASSE '+
               'WHERE (EMP_CODIGO =:EMP_CODIGO)' ;
  Lc_Atualiza.SQL.Add(Lc_SqlTxt);

  Qr_Vendas.First;
  Lb_Status.Caption := 'Atualizando Clientes '+ It_Cla_Atual;
  Application.ProcessMessages;
  while not Qr_Vendas.Eof do
    Begin
    if (Qr_Vendas.FieldByName('TOTAL').AsCurrency > 0) and (Qr_Vendas.FieldByName('TOTAL').AsCurrency <= It_Vl_Class_1) then  It_Cla_Atual := '1 estrela';
    if (Qr_Vendas.FieldByName('TOTAL').AsCurrency > (It_Vl_Class_1 + 0.01)) and (Qr_Vendas.FieldByName('TOTAL').AsCurrency <= It_Vl_Class_2) then  It_Cla_Atual := '2 estrelas';
    if (Qr_Vendas.FieldByName('TOTAL').AsCurrency > (It_Vl_Class_2 + 0.01)) and (Qr_Vendas.FieldByName('TOTAL').AsCurrency <= It_Vl_Class_3) then  It_Cla_Atual := '3 estrelas';
    if (Qr_Vendas.FieldByName('TOTAL').AsCurrency > (It_Vl_Class_3 + 0.01)) and (Qr_Vendas.FieldByName('TOTAL').AsCurrency <= It_Vl_Class_4) then  It_Cla_Atual := '4 estrelas';
    if (Qr_Vendas.FieldByName('TOTAL').AsCurrency > (It_Vl_Class_4 + 0.01)) and (Qr_Vendas.FieldByName('TOTAL').AsCurrency <= 999999.99) then  It_Cla_Atual := '5 estrelas';

    Lc_Atualiza.Active := False;
    Lc_Atualiza.ParamByName('EMP_CLASSE').AsString := It_Cla_Atual;
    Lc_Atualiza.ParamByName('EMP_CODIGO').AsString := Qr_Vendas.FieldByName('NFL_CODEMP').AsString;
    Lc_Atualiza.ExecSQL;
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    Qr_Vendas.Next;
    end;
  Lc_Atualiza.Destroy;
  Lc_Atualiza := Nil;

end;

procedure TFr_Crm.Pc_AtualizaTabela;
Var
  Lc_Atualiza: TSTQuery;
  Lc_SqlTxt : String;
BEgin
  Screen.Cursor:=crHourGlass;
  Lb_Status.Caption := 'Atualizando a Tabela de Geral.';
  Application.ProcessMessages;
  Lc_Atualiza := TSTQuery.Create(Self);
  Lc_Atualiza.Database := DM.IBD_Gestao;
  Lc_Atualiza.Transaction := DM.IB_Transacao;
  Lc_Atualiza.SQL.Clear;

  Lc_SqlTxt := 'UPDATE TB_CRM_CLASSES '+
               'SET '+
               'CRM_VL_GERAL=:CRM_VL_GERAL, '+
               'CRM_QT_GERAL=:CRM_QT_GERAL, '+
               'CRM_VL_PERIODO=:CRM_VL_PERIODO, '+
               'CRM_QT_PERIODO=:CRM_QT_PERIODO, '+
               'CRM_VL_MANUAL=:CRM_VL_MANUAL '+
               'WHERE (CRM_CODIGO =:CRM_CODIGO)' ;
  Lc_Atualiza.SQL.Add(Lc_SqlTxt);

  //1º Estrela
  Lc_Atualiza.Active := False;
  Lc_Atualiza.ParamByName('CRM_VL_GERAL').AsCurrency := StrToFloatDef(E_Vl_Sistema_1.Text,0);
  Lc_Atualiza.ParamByName('CRM_QT_GERAL').AsFloat := StrToFloatDef(E_Qt_Sistema_1.Text,0);
  Lc_Atualiza.ParamByName('CRM_VL_PERIODO').AsCurrency := StrToFloatDef(E_Vl_Periodo_1.Text,0);
  Lc_Atualiza.ParamByName('CRM_QT_PERIODO').AsFloat := StrToFloatDef(E_Qt_Periodo_1.Text,0);
  Lc_Atualiza.ParamByName('CRM_VL_MANUAL').AsCurrency := StrToFloatDef(E_Vl_Manual_1.Text,0);
  Lc_Atualiza.ParamByName('CRM_CODIGO').AsInteger := 1;
  Lc_Atualiza.Active := True;
  IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;

  //º Estrela
  Lc_Atualiza.Active := False;
  Lc_Atualiza.ParamByName('CRM_VL_GERAL').AsCurrency := StrToFloatDef(E_Vl_Sistema_2.Text,0);
  Lc_Atualiza.ParamByName('CRM_QT_GERAL').AsFloat := StrToFloatDef(E_Qt_Sistema_2.Text,0);
  Lc_Atualiza.ParamByName('CRM_VL_PERIODO').AsCurrency := StrToFloatDef(E_Vl_Periodo_2.Text,0);
  Lc_Atualiza.ParamByName('CRM_QT_PERIODO').AsFloat := StrToFloatDef(E_Qt_Periodo_2.Text,0);
  Lc_Atualiza.ParamByName('CRM_VL_MANUAL').AsCurrency := StrToFloatDef(E_Vl_Manual_2.Text,0);
  Lc_Atualiza.ParamByName('CRM_CODIGO').AsInteger := 2;
  Lc_Atualiza.Active := True;
  IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;

  //3º Estrela
  Lc_Atualiza.Active := False;
  Lc_Atualiza.ParamByName('CRM_VL_GERAL').AsCurrency := StrToFloatDef(E_Vl_Sistema_3.Text,0);
  Lc_Atualiza.ParamByName('CRM_QT_GERAL').AsFloat := StrToFloatDef(E_Qt_Sistema_3.Text,0);
  Lc_Atualiza.ParamByName('CRM_VL_PERIODO').AsCurrency := StrToFloatDef(E_Vl_Periodo_3.Text,0);
  Lc_Atualiza.ParamByName('CRM_QT_PERIODO').AsFloat := StrToFloatDef(E_Qt_Periodo_3.Text,0);
  Lc_Atualiza.ParamByName('CRM_VL_MANUAL').AsCurrency := StrToFloatDef(E_Vl_Manual_3.Text,0);
  Lc_Atualiza.ParamByName('CRM_CODIGO').AsInteger := 3;
  Lc_Atualiza.Active := True;
  IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;

  //4º Estrela
  Lc_Atualiza.Active := False;
  Lc_Atualiza.ParamByName('CRM_VL_GERAL').AsCurrency := StrToFloatDef(E_Vl_Sistema_4.Text,0);
  Lc_Atualiza.ParamByName('CRM_QT_GERAL').AsFloat := StrToFloatDef(E_Qt_Sistema_4.Text,0);
  Lc_Atualiza.ParamByName('CRM_VL_PERIODO').AsCurrency := StrToFloatDef(E_Vl_Periodo_4.Text,0);
  Lc_Atualiza.ParamByName('CRM_QT_PERIODO').AsFloat := StrToFloatDef(E_Qt_Periodo_4.Text,0);
  Lc_Atualiza.ParamByName('CRM_VL_MANUAL').AsCurrency := StrToFloatDef(E_Vl_Manual_4.Text,0);
  Lc_Atualiza.ParamByName('CRM_CODIGO').AsInteger := 4;
  Lc_Atualiza.Active := True;
  IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;

  //5º Estrela
  Lc_Atualiza.Active := False;
  Lc_Atualiza.ParamByName('CRM_VL_GERAL').AsCurrency := StrToFloatDef(E_Vl_Sistema_5.Text,0);
  Lc_Atualiza.ParamByName('CRM_QT_GERAL').AsFloat := StrToFloatDef(E_Qt_Sistema_5.Text,0);
  Lc_Atualiza.ParamByName('CRM_VL_PERIODO').AsCurrency := StrToFloatDef(E_Vl_Periodo_5.Text,0);
  Lc_Atualiza.ParamByName('CRM_QT_PERIODO').AsFloat := StrToFloatDef(E_Qt_Periodo_5.Text,0);
  Lc_Atualiza.ParamByName('CRM_VL_MANUAL').AsCurrency := StrToFloatDef(E_Vl_Manual_5.Text,0);
  Lc_Atualiza.ParamByName('CRM_CODIGO').AsInteger := 5;
  Lc_Atualiza.Active := True;
  IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.Commit;

  Lc_Atualiza.Destroy;
  Lc_Atualiza := Nil;
  Lb_Status.Caption := 'Tabela Geral Atualizada.';
  Application.ProcessMessages;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Crm.Sb_ImprimirClick(Sender: TObject);
begin
  if not Assigned(RL_Crm) then Application.CreateForm(TRL_Crm, RL_Crm);
  TRY
  RL_Crm.Qrpt.Preview;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a geração do relatório.'+EOLN+
                   'Verfique os parãmetros utilizados.'+EOLN,
                  ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Crm.SB_SairClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Crm.sb_analiseClick(Sender: TObject);
begin
  if ChBx_ClassGeral.Checked then
    Begin
    Pc_Classificacao('T');
    Pc_Segmentacao('T');
    Pc_Classificacao('P');
    Pc_Segmentacao('P');
    end
  else
    Begin
    Pc_Classificacao('P');
    Pc_Segmentacao('P');
    end;
end;

procedure TFr_Crm.SB_QualificarClick(Sender: TObject);
begin
  Qr_ZeraEstrela.Active := False;
  Qr_ZeraEstrela.ExecSQL;
  IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.Commit;
  if ChBx_TabManual.Checked then
    Begin
    It_Vl_Class_1 := StrToFloatDef(E_Vl_Manual_1.Text,0);
    It_Vl_Class_2 := StrToFloatDef(E_Vl_Manual_2.Text,0);
    It_Vl_Class_3 := StrToFloatDef(E_Vl_Manual_3.Text,0);
    It_Vl_Class_4 := StrToFloatDef(E_Vl_Manual_4.Text,0);
    It_Vl_Class_5 := StrToFloatDef(E_Vl_Manual_5.Text,0);
    end
  else
    Begin
    if ChBx_TabAuto.Checked then
      Begin
      It_Vl_Class_1 := StrToFloatDef(E_Vl_Periodo_1.Text,0);
      It_Vl_Class_2 := StrToFloatDef(E_Vl_Periodo_2.Text,0);
      It_Vl_Class_3 := StrToFloatDef(E_Vl_Periodo_3.Text,0);
      It_Vl_Class_4 := StrToFloatDef(E_Vl_Periodo_4.Text,0);
      It_Vl_Class_5 := StrToFloatDef(E_Vl_Periodo_5.Text,0);
      end
    else
      Begin
      It_Vl_Class_1 := StrToFloatDef(E_Vl_Sistema_1.Text,0);
      It_Vl_Class_2 := StrToFloatDef(E_Vl_Sistema_2.Text,0);
      It_Vl_Class_3 := StrToFloatDef(E_Vl_Sistema_3.Text,0);
      It_Vl_Class_4 := StrToFloatDef(E_Vl_Sistema_4.Text,0);
      It_Vl_Class_5 := StrToFloatDef(E_Vl_Sistema_5.Text,0);
      end;
    end;

  if ChBx_ClienteMovim.Checked then
    Pc_Qualificacao('P')
  else
    Pc_Qualificacao('T');
  Fc_Tb_Geral('G','CRM_QUALIFICA',DateToStr(Date));
  IF DM.IB_Transacao.InTransaction then DM.IB_Transacao.Commit;
  IF ChBx_RelPos.Checked THEN SB_ImprimirClick(Sender);
end;

procedure TFr_Crm.sb_atualizarClick(Sender: TObject);
begin
  Pc_AtualizaTabela;
end;

procedure TFr_Crm.FormShow(Sender: TObject);
begin
  Pc_PreencheTela;
  Pc_PermissaoBotao('CRM - Clientes');  
end;

procedure TFr_Crm.FormCreate(Sender: TObject);
Var
lc_Ultdia : String;
begin
  lc_Ultdia := IntToStr(UltDiaDoMes(date));
  E_DataIni.Date := StrToDate('01/01/2006');
  E_DataFim.Date := StrToDate('01/01/2100');
end;

procedure TFr_Crm.ChBx_TabAutoClick(Sender: TObject);
begin
  ChBx_TabManual.Checked := not ChBx_TabAuto.Checked;  
end;

procedure TFr_Crm.ChBx_TabManualClick(Sender: TObject);
begin
  ChBx_TabAuto.Checked := not ChBx_TabManual.Checked;
end;

procedure TFr_Crm.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Imprimir  := True;
    It_Qualifica := True;
    It_Atualizar := True;
    It_Analise   := True;
   end
  else
    begin
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    if not It_Visualizar then exit;
    It_Imprimir   := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    It_Qualifica  := Fc_HabilitaPermissao(Pc_Menu,'QUALIFICAR','S');
    It_Atualizar  := Fc_HabilitaPermissao(Pc_Menu,'ATUALIZAR','S');
    It_Analise    := Fc_HabilitaPermissao(Pc_Menu,'ANALISE','S');
    end;
   sb_analise.Enabled:= It_Analise;
   SB_Qualificar.Enabled:= It_Qualifica;
   sb_atualizar.Enabled:= It_Atualizar;
   SB_Imprimir.Enabled:= It_Imprimir;   
end;

procedure TFr_Crm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F2  : if sb_analise.Enabled then sb_analiseClick(Sender);
      VK_F3  : if SB_Qualificar.Enabled then SB_QualificarClick(Sender);
      VK_F4  : if sb_atualizar.Enabled then sb_atualizarClick(Sender);
      VK_F5  : if Sb_Imprimir.Enabled then Sb_ImprimirClick(Sender);            
      VK_Escape : if SB_Sair.Enabled then SB_SairClick(Sender);
    end;
  end;
end;

end.
