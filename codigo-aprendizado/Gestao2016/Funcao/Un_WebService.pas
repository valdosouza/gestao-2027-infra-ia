unit Un_WebService;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs;
  //Relção com o cadastro de usuarios
  procedure Pc_Ws_Usuario(Pc_Operacao,pc_codigo: string);
  procedure Pc_Ws_Empresa(Pc_Operacao,Pc_Tipo,pc_codigo: string);
  procedure Pc_Ws_Estabelecimetno(Pc_Operacao,Pc_CNPJ: string);
  procedure Pc_Ws_Cliente(Pc_Operacao,Pc_CNPJ: string);
  procedure Pc_Ws_Endereco(Pc_Operacao,Pc_CNPJ_CPF,Pc_CEP: string);
  procedure Pc_Ws_Telefone(Pc_Operacao,Pc_Fone,Pc_Tipo,Pc_CNPJ_CPF,Pc_CEP: string);
  //Relção com o cadastro de produtos
  procedure Pc_Ws_Medida(Pc_Operacao,pc_codigo: string);
  procedure Pc_Ws_Embalagem(Pc_Operacao,pc_codigo: string);
  procedure Pc_Ws_Grupo(Pc_Operacao,Pc_codigo:String);
  procedure Pc_Ws_SubGrupo(Pc_Operacao,Pc_Cd_Grupo,Pc_Cd_SubGrupo:String);
  procedure Pc_Ws_MarcaProduto(Pc_Operacao,Pc_Codigo:String);
  procedure Pc_Ws_Produto(Pc_Operacao,Pc_Cd_Produto,Pc_Cd_Grupo:String);
  procedure Pc_Ws_TabelaPreco(Pc_Operacao,Pc_Cd_Produto:String);
  procedure Pc_Ws_PrecoProduto(Pc_Operacao,Pc_Cd_Produto:String);
  procedure Pc_Ws_Estoques(Pc_Operacao,Pc_Codigo:String);
  procedure Pc_Ws_Estoque(Pc_Operacao,Pc_Codigo:String);
  //Questionario
  procedure Pc_Ws_Questionario(Pc_Operacao,Pc_Cd_Questionario:String);
  //Relção com o cadastro de Veiculos
  procedure Pc_Ws_MarcaVeiculo(Pc_Operacao,pc_codigo: string);
  procedure Pc_Ws_ModeloVeiculo(Pc_Operacao,pc_codigo: string);
  procedure Pc_Ws_TipoVeiculo(Pc_Operacao,Pc_codigo:String);
  procedure Pc_Ws_CorVeiculo(Pc_Operacao,Pc_codigo:String);
  procedure Pc_Ws_Veiculo(Pc_Operacao,Pc_codigo:String);

implementation

uses     UN_Sistema, env;

//Relção com o cadastro de usuarios
procedure Pc_Ws_Usuario(Pc_Operacao,pc_codigo: string);
Begin
  Case Gb_Cd_Wsr of
    2:Begin
      //Desenvolver o Gestão 2013
      end;
  end;
end;

//Relção com o cadastro de entidades
procedure Pc_Ws_Empresa(Pc_Operacao,Pc_Tipo,pc_codigo: string);
Begin
  Case Gb_Cd_Wsr of
    2:Begin
      //Desenvolver o Gestão 2013
      end;     
  end;
end;

procedure Pc_Ws_Estabelecimetno(Pc_Operacao,Pc_CNPJ: string);
Begin
  Case Gb_Cd_Wsr of
    2:Begin
      //Desenvolver o Gestão 2013
      end;
  end;
end;

procedure Pc_Ws_Cliente(Pc_Operacao,Pc_CNPJ: string);
Begin
  Case Gb_Cd_Wsr of
    2:Begin
      //Desenvolver o Gestão 2013
      end;     
  end;
end;

procedure Pc_Ws_Endereco(Pc_Operacao,Pc_CNPJ_CPF,Pc_CEP: string);
Var
  Lc_Sqltxt : String;
Begin
  Case Gb_Cd_Wsr of
    2:Begin
      //Desenvolver o Gestão 2013
      end;
  end;
end;

procedure Pc_Ws_Telefone(Pc_Operacao,Pc_Fone,Pc_Tipo,Pc_CNPJ_CPF,Pc_CEP: string);
Begin
  Case Gb_Cd_Wsr of
    2:Begin
      //Desenvolver o Gestão 2013
      end;
  end;
end;

//Relção com o cadastro de produtos
procedure Pc_Ws_Medida(Pc_Operacao,pc_codigo: string);
Begin
  Case Gb_Cd_Wsr of
    2:Begin

      end;
  end;
end;

procedure Pc_Ws_Embalagem(Pc_Operacao,pc_codigo: string);
Begin
  Case Gb_Cd_Wsr of
    2:Begin

      end;
  end;
end;

procedure Pc_Ws_Grupo(Pc_Operacao,pc_codigo: string);
Begin
  Case Gb_Cd_Wsr of
    2:Begin

      end;
  end;
end;


procedure Pc_Ws_SubGrupo(Pc_Operacao,Pc_Cd_Grupo,Pc_Cd_SubGrupo:String);
BEgin
  Case Gb_Cd_Wsr of
    2:Begin
      //Este Web Service não tem Subgrupo pois trabalha direto com CAtegorias aninhadas
      end;
  end;
end;

procedure Pc_Ws_MarcaProduto(Pc_Operacao,Pc_Codigo:String);
Begin
  Case Gb_Cd_Wsr of
    2:Begin
      //Não existe atulizção de Marca para o Joomla
      end;
  end;
end;

procedure Pc_Ws_Produto(Pc_Operacao,Pc_Cd_Produto,Pc_Cd_Grupo:String);
Begin
  Case Gb_Cd_Wsr of
    2:Begin

      end;
  end;
end;

procedure Pc_Ws_TabelaPreco(Pc_Operacao,Pc_Cd_Produto:String);
Begin
  Case Gb_Cd_Wsr of
    2:Begin
      //Implementção feita direto no cadastro da minha empresa
      end;
  end;
end;

procedure Pc_Ws_PrecoProduto(Pc_Operacao,Pc_Cd_Produto:String);
Begin
  Case Gb_Cd_Wsr of
    2:Begin
      //Nao h� implementção em Joomla
      end;
  end;
end;

procedure Pc_Ws_Estoques(Pc_Operacao,Pc_Codigo:String);
Begin
  Case Gb_Cd_Wsr of
    2:Begin
      //Implementção feita direto no cadastro da minha empresa
      end;
  end;
end;

procedure Pc_Ws_Estoque(Pc_Operacao,Pc_Codigo:String);
Begin
  Case Gb_Cd_Wsr of
    2:Begin
      //Nao h� implementção em Joomla
      end;
  end;
end;

  //Questionario
procedure Pc_Ws_Questionario(Pc_Operacao,Pc_Cd_Questionario:String);
Begin
  Case Gb_Cd_Wsr of
    2:Begin
      //Não tem webService de questionario em joomla
      end;
  end;
end;

//Relção com o cadastro de Veiculos
procedure Pc_Ws_MarcaVeiculo(Pc_Operacao,pc_codigo: string);
Begin
  Case Gb_Cd_Wsr of
    2:Begin

      end;
  end;
end;

procedure Pc_Ws_ModeloVeiculo(Pc_Operacao,pc_codigo: string);
Begin
  Case Gb_Cd_Wsr of
    2:Begin

      end;
  end;
end;

procedure Pc_Ws_TipoVeiculo(Pc_Operacao,Pc_codigo:String);
Begin
  Case Gb_Cd_Wsr of
    2:Begin
      //Não tem webService de questionario em joomla
      end;
  end;
end;

procedure Pc_Ws_CorVeiculo(Pc_Operacao,Pc_codigo:String);
Begin
  Case Gb_Cd_Wsr of
    2:Begin

      end;
  end;
end;

procedure Pc_Ws_Veiculo(Pc_Operacao,Pc_codigo:String);
Begin
  Case Gb_Cd_Wsr of
    2:Begin

      end;
  end;
end;

end.


 