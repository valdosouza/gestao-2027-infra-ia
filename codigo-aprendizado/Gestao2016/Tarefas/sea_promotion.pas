unit sea_promotion;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_base_Pesq, Vcl.StdCtrls, Vcl.Mask, Data.DB, STQuery, Vcl.Menus, Vcl.Grids, Vcl.Buttons, Vcl.ExtCtrls, QEdit_Setes;

type
  TSeaPromotion = class(TFr_Base_Pesq)
    Label28: TLabel;
    Label29: TLabel;
    E_Qtde: TMaskEdit;
    E_BuscaProduto: TMaskEdit;
    Qr_PesquisaID: TIntegerField;
    Qr_PesquisaDESCRIPTION: TStringField;
    Qr_PesquisaPRO_DESCRICAO: TStringField;
    Qr_PesquisaPRICE_TAG: TFMTBCDField;
    Qr_PesquisaQUANTITY: TBCDField;
    ChBx_Ativa: TCheckBox;
    Label26: TLabel;
    E_BuscaCodBarras: TEdit_Setes;
    Qr_PesquisaPRO_CODIGO: TIntegerField;
    Label1: TLabel;
    Label2: TLabel;
    E_ValorTotal: TMaskEdit;
  private
    { Private declarations }
  protected
    procedure IniciaVariaveis;Override;
    procedure setPerfil;Override;
    procedure FormataTela;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure PassagemParametros;Override;
    procedure Insere;Override;
    procedure Visualiza;Override;
  public
    { Public declarations }
  end;

var
  SeaPromotion: TSeaPromotion;

implementation

{$R *.dfm}

uses     UN_Principal, env, cad_promotion;

{ TSeaPromotion }


procedure TSeaPromotion.FormataTela;
begin
  inherited;

end;

procedure TSeaPromotion.IniciaVariaveis;
begin
  inherited;
  MultiSelect := False;
end;

procedure TSeaPromotion.InnerJoinSql;
begin
  SqlTxt := concat(
              SqlTxt,
              '  inner join tb_promotion_items pit ',
              '  on (pit.tb_promotion_id = p.id) and (pit.tb_institution_id = p.tb_institution_id) ',
              '  inner join tb_produto prd ',
              '  on (prd.pro_codigo = pit.tb_product_id) '
            );

end;

procedure TSeaPromotion.Insere;
Var
  Form:TCadPromotion;
begin
  Try
    Form := TCadPromotion.create(Self);
    Form.CodigoRegistro := 0;
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TSeaPromotion.OrderBy;
begin
  SqlTxt := concat(
              SqlTxt,
              ' order by PRO_DESCRICAO '
            );

end;

procedure TSeaPromotion.PassagemParametros;
Var
  LcDesc : string;
  LcQtde : REal;
  LcValor : Real;
begin
  //Passagem de parametro
  with Qr_Pesquisa do
  Begin
    ParamByName('institution_id').AsInteger := Gb_CodMha;
    if (E_Qtde.Text <> '') or (E_ValorTotal.Text <> '') then
    BEgin
      LcQtde := StrToFloatDef(E_Qtde.Text,0);
      LcDesc := concat(FloatToStrF(LcQtde,ffFixed,10,0),' X ');
      LcValor := StrToFloatDef(E_ValorTotal.Text,0);
      LcDesc := concat(LcDesc, FloatToStrF(LcValor,ffFixed,10,2));
      ParamByName('promocao').AsString := concat('%',LcDesc,'%');
    End;

    if E_BuscaCodBarras.Text <> '' then
      ParamByName('codigobar').AsString := E_BuscaCodBarras.Text;

    if E_BuscaProduto.Text <> '' then
      ParamByName('produto').AsString := concat('%',Copy(Trim(E_BuscaProduto.Text),1,98),'%');
  End;
end;


procedure TSeaPromotion.SelectSql;
begin
  SqlTxt := concat(
              'select p.id, p.description, prd.pro_descricao, p.price_tag, p.quantity, ',
              'prd.pro_codigo ',
              'from tb_promotion p '
            );
end;

procedure TSeaPromotion.setPerfil;
begin
  pfMenu := 'seaPromotion';//será o mesmo no cadastro
  inherited;
end;

procedure TSeaPromotion.Visualiza;
Var
  Form:TCadPromotion;
begin
  Try
    Form := TCadPromotion.create(Self);
    Form.CodigoRegistro := StrToIntDef(Grd_Pesquisa.cells[3,Grd_Pesquisa.Row],0);
    Form.Codigodetalhe := StrToIntDef(Grd_Pesquisa.cells[8,Grd_Pesquisa.Row],0);
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TSeaPromotion.WhereSql;
begin
  SqlTxt := concat(
              SqlTxt,
             'where p.tb_institution_id =:institution_id '
              );
    //incrementa SQL
  if ChBx_Ativa.Checked then
    SqlTxt := concat(
                  SqlTxt,
                  ' and (REG_ACTIVE = ''S'') '
                )
    else
    SqlTxt := concat(
                  SqlTxt,
                  'and (REG_ACTIVE = ''N'')'
                );

  if (E_Qtde.Text <> '') or (E_ValorTotal.Text <> '') then
  begin
    SqlTxt := concat(
                  SqlTxt,
                  ' and (p.description like :promocao)'
                );
  end;

  if E_BuscaCodBarras.Text <> '' then
    SqlTxt := concat(
                  SqlTxt,
                  ' and (prd.pro_codigobar =:codigobar) '
                );
  if E_BuscaProduto.Text <> '' then
    SqlTxt := concat(
                  SqlTxt,
                  ' and (prd.pro_descricao like :produto) '
                );

end;

end.
