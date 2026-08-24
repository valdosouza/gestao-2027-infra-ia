unit cad_base_troca;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, ControllerItensNFL, Vcl.ComCtrls, Vcl.StdCtrls, Un_Fm_ListaEmpresas, Un_Fm_ListaClientes, Vcl.Mask, QEdit_Setes, Un_Fm_ListaColaboradores, Un_Fm_ListaProdutos;

type
  TCadBaseTroca = class(TBaseRegistry)
    Fm_ListaProdutos: TFm_ListaProdutos;
    Fm_ListaEmpresas: TFm_ListaEmpresas;
    Fm_ListaVendedores: TFm_ListaColaboradores;
    E_Obs: TMemo;
    Label4: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    E_Data_Entrada: TDateTimePicker;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    E_Peso_Entrada: TEdit_Setes;
    E_Peso_Saida: TEdit_Setes;
    E_Peso_Saldo: TEdit_Setes;
    Label1: TLabel;
    E_Vl_Venda: TEdit_Setes;
    Label3: TLabel;
    E_VL_Troca: TEdit_Setes;
    Label5: TLabel;
    E_Data_Saida: TEdit_Setes;
    procedure E_Peso_EntradaExit(Sender: TObject);
  private
    { Private declarations }
    procedure CalculosaldoPeso;
  protected
    Pf_Inserir , Pf_Alterar, Pf_Excluir : Boolean;

    //Variaveis
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;

    procedure ShowData;Override;
    procedure ShowNoData;Override;
    procedure ClearAllFields;Override;
    procedure EditionControl;Override;
    //inserir
    function ValidaInsert():boolean;Override;
    procedure Insert;Override;
    //Editar
    function ValidateChange():boolean;Override;
    procedure Change;Override;
    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;
    //Cancelar
    function ValidateCancel():boolean;Override;
    procedure Cancel;Override;


  public
    { Public declarations }
    ItensNFL : TControllerItensNFL;
  end;

var
  CadBaseTroca: TCadBaseTroca;

implementation

uses
      UN_Principal, env, Un_Msg;

{$R *.dfm}

{ TBaseRegistry1 }

procedure TCadBaseTroca.CalculosaldoPeso;
begin
  E_Peso_Saldo.Text := FloatToStrF(ItensNFL.BaseTroca.Registro.PesoSaida - ItensNFL.BaseTroca.Registro.PesoEntrada  ,ffFixed,10,2) ;
end;

procedure TCadBaseTroca.Cancel;
begin
  inherited;
  Self.close;
end;

procedure TCadBaseTroca.Change;
begin
  inherited;
  Fm_ListaProdutos.E_Cd_Produto.SetFocus;
end;

procedure TCadBaseTroca.ClearAllFields;
begin
  inherited;

end;

procedure TCadBaseTroca.CriarVariaveis;
begin
  inherited;
  ItensNFL := TControllerItensNFL.Create(self);
end;

procedure TCadBaseTroca.Delete;
begin
  inherited;
  ItensNFL.BaseTroca.delete;
  close;
end;

procedure TCadBaseTroca.EditionControl;
begin

end;

procedure TCadBaseTroca.E_Peso_EntradaExit(Sender: TObject);
begin
  ItensNFL.BaseTroca.Registro.PesoEntrada := StrToFloatDef(E_Peso_Entrada.Text,0);
  CalculosaldoPeso;
end;

procedure TCadBaseTroca.IniciaVariaveis;
begin
  inherited;
  Fm_ListaEmpresas.Pc_AtivaEmpresa(1);
  Fm_ListaVendedores.ListaVendedor;
  CodigoRegistro := ItensNFL.BaseTroca.Registro.Item;
  if (CodigoRegistro > 0 ) then
  Begin
    ItensNFL.BaseTroca.getByKey;

    ItensNFL.Registro.Codigo := ItensNFL.BaseTroca.Registro.Item;
    ItensNFL.getById;
  End;
  inherited;
end;

procedure TCadBaseTroca.Insert;
begin
  inherited;
  ClearAllFields;
  ItensNFL.clear;
  ItensNFL.BaseTroca.clear;
  ShowNoData;
  Fm_ListaProdutos.E_Cd_Produto.SetFocus;
end;

procedure TCadBaseTroca.Save;
begin
  inherited;
  ItensNFL.BaseTroca.Registro.DataEntrada := E_Data_Entrada.DateTime;
  ItensNFL.BaseTroca.Registro.PesoEntrada := StrToFloatDeF( E_Peso_Entrada.Text,0);
  //ItensNFL.BaseTroca.Registro.DataSaida   := StrToFloatDeF( E_Data_Saida.Text,0);
  //ItensNFL.BaseTroca.Registro.PesoSaida   := StrToFloatDeF( E_Peso_Saida.Text,0);
  ItensNFL.BaseTroca.Registro.Observacao := E_Obs.Text;
  ItensNFL.BaseTroca.save;
  Self.close;
end;

procedure TCadBaseTroca.ShowData;
begin
  inherited;
  with ItensNFL.BaseTroca do
  Begin
    Fm_ListaProdutos.E_Cd_Produto.Text := Registro.Produto.ToString();
    Fm_ListaProdutos.E_Cd_ProdutoExit(Self);
    Fm_ListaEmpresas.E_Cd_Empresa.Text := Registro.Cliente.ToString();
    Fm_ListaEmpresas.E_Cd_EmpresaExit(self);
    Fm_ListaVendedores.Dblcb_Vendedor.KeyValue := Registro.Vendedor;

    if ItensNFL.BaseTroca.Registro.DataEntrada > 0 then
      E_Data_Entrada.DateTime := Registro.DataEntrada;
    E_Data_Saida.Text       := DateToStr(Registro.DataSaida);
    E_Vl_Venda.Text         := FloatToStrF(ItensNFL.Registro.ValorUnitario,ffFixed,10,2) ;
    E_VL_Troca.Text         := FloatToStrF(ItensNFL.BaseTroca.Registro.Preco,ffFixed,10,2) ;
    E_Peso_Saida.Text       := FloatToStrF(ItensNFL.BaseTroca.Registro.PesoSaida,ffFixed,10,2) ;
    E_Peso_Entrada.Text     := FloatToStrF(ItensNFL.BaseTroca.Registro.PesoEntrada,ffFixed,10,2) ;

    CalculosaldoPeso;
    E_Obs.Text := ItensNFL.BaseTroca.Registro.Observacao;
  End;
end;

procedure TCadBaseTroca.ShowNoData;
begin
  inherited;
  Fm_ListaProdutos.E_Cd_Produto.clear;
  Fm_ListaProdutos.E_Busca_Produto.clear;
  Fm_ListaEmpresas.E_Cd_Empresa.clear;
  Fm_ListaEmpresas.DBLCB_Empresa.KeyValue := null;
  Fm_ListaVendedores.Dblcb_Vendedor.KeyValue := null;

  E_Data_Entrada.DateTime := Now;
  E_Vl_Venda.Text := '0,00';
  E_VL_Troca.Text := '0,00';
  E_Peso_Saida.Text := '0,00';
  E_Peso_Entrada.Text := '0,00';
  E_Peso_Saldo.Text := '0,00';
end;

function TCadBaseTroca.ValidaInsert: boolean;
begin
  REsult := True;
end;

function TCadBaseTroca.ValidateCancel: boolean;
begin
  REsult := True;
end;

function TCadBaseTroca.ValidateChange: boolean;
begin
  REsult := True;
end;

function TCadBaseTroca.ValidateDelete: boolean;
begin
  Result := True;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir este lançamento de seus arquivos.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
  begin
    REsult := False;
  end;

end;

function TCadBaseTroca.ValidateSave: boolean;
begin
  REsult := True;
end;

end.
