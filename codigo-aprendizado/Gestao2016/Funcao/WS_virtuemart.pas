unit WS_virtuemart;

interface

uses       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns, STQuery;

type

  server_ws_virtuemartPortType = interface(IInvokable)
  ['{34FD318E-B758-4532-D446-EAA87449999F}']
    function servico(const name: WideString; const modulo: WideString;const cnpj: WideString): WideString; stdcall;

  end;

    function Getserver_ws_virtuemartPortType(UseWSDL: Boolean=System.False; Addr: string='';
                                             HTTPRIO: THTTPRIO = nil): server_ws_virtuemartPortType;
    procedure Pc_Vm_Atu_Produto(Pc_Operacao,pc_codigo: string);
    procedure Pc_Vm_Atu_Grupo(Pc_Operacao,Pc_Codigo: string);
    procedure Pc_Vm_Del_Grupo(pc_codigo: string);
    procedure Pc_Vm_Atu_SubGrupo(Pc_Operacao,Pc_Cd_SubGrupo,Pc_Cd_Grupo:string);
Var
It_Site : String;

implementation

uses     UN_Sistema, Un_DM, UN_Principal, env;
function Getserver_ws_virtuemartPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): server_ws_virtuemartPortType;
const
  defSvc  = 'server.ws_virtuemart';
  defPrt  = 'server.ws_virtuemartPort';
var
  defWSDL : String;
  defURL : String;
  RIO: THTTPRIO;
begin
  defWSDL := gb_webservice + '?wsdl';
  defURL  := gb_webservice ;

  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as server_ws_virtuemartPortType);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;

procedure Pc_Vm_Atu_Produto(Pc_Operacao,pc_codigo: string);
Var
   Lc_codgrp: string;
   Lc_codsbg: string;
   Lc_codmrc: string;
   Lc_nome: string;
   Lc_descricao: string;
   Lc_valor_f: string;
   Lc_promocao: string;
   Lc_destaque: string;
   Lc_peso: string;
   Lc_disponivel: string;
   Lc_exclusivo: string;
   Lc_valor_r: string;
   Lc_publicar: string;
   Lc_Centimetro: String;
   Lc_Marca: String;
   Lc_publish, Lc_result: WideString;
   Lc_ws: server_ws_virtuemartPortType;
   Lc_XmlProdutos: TStringList;
   Lc_Qry : TSTQuery;
begin
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IBT_Estoque;
    ForcedRefresh := True;

    Active := False;
    SQL.Clear;
    SQL.Add('SELECT PRO_CODIGO, PRO_CODGRP, PRO_CODSBG, PRO_CODMRC, PRO_DESCRICAO, PRO_DETALHES, PRC_VL_VDA, '+
                 'PRO_CAMPANHA, PRO_DESTAQUE, PRO_PESO, PRO_INTERNET, PRO_EXCLUSIVO, EST_QTDE, MRC_DESCRICAO '+
                 'FROM TB_PRODUTO tb_produto '+
                 '  INNER JOIN TB_PRECO tb_preco '+
                 '  ON (tb_preco.PRC_CODPRO = tb_produto.PRO_CODIGO) '+
                 '  INNER JOIN TB_ESTOQUE tb_estoque '+
                 '  ON (tb_estoque.EST_CODPRO = tb_produto.PRO_CODIGO) '+
                 '  INNER JOIN TB_INTERNET tb_internet '+
                 '  ON (tb_internet.INT_CODTPR = tb_preco.PRC_CODTPR) '+
                 '  LEFT outer JOIN TB_MARCA_PRODUTO tb_marcaproduto  '+
                 '  ON (tb_produto.PRO_CODMRC = tb_marcaproduto.MRC_CODIGO) '+
                 'WHERE (PRO_CODIGO=:PRO_CODIGO) '+
                 '  AND (EST_CODETS=:EST_CODETS) '+
                 '  AND (INT_CODMHA=:INT_CODMHA) ');

    ParamByName('PRO_CODIGO').AsString := pc_codigo;
    ParamByName('INT_CODMHA').AsInteger := Gb_CodMha;
    ParamByName('EST_CODETS').AsInteger := Gb_Estoque;
    Active := True;
    FetchAll;
    Lc_codgrp := FieldByName('PRO_CODGRP').AsString ;
    Lc_codsbg := FieldByName('PRO_CODSBG').AsString ;
    Lc_codmrc := FieldByName('PRO_CODMRC').AsString ;
    Lc_nome := FieldByName('PRO_DESCRICAO').AsString ;
    Lc_descricao := FieldByName('PRO_DETALHES').AsString ;
    Lc_valor_f := FieldByName('PRC_VL_VDA').AsString ;
    Lc_promocao := FieldByName('PRO_CAMPANHA').AsString ;
    Lc_destaque := FieldByName('PRO_DESTAQUE').AsString ;
    Lc_peso := BuscaTroca(FieldByName('PRO_PESO').AsString,',','.');
    if Lc_Qry.FieldByName('EST_QTDE').AsFloat > 0 then
      Lc_disponivel := BuscaTroca(FieldByName('EST_QTDE').AsString,',','.')
    else
      Lc_disponivel := '0';
    Lc_exclusivo := FieldByName('PRO_EXCLUSIVO').AsString ;
    Lc_valor_r := FieldByName('PRC_VL_VDA').AsString ;
    Lc_publicar := FieldByName('PRO_INTERNET').AsString ;
    Lc_Marca := FieldByName('MRC_DESCRICAO').AsString ;

    try
      Lc_XmlProdutos := TStringList.Create;
      if (Lc_destaque = 'S') then
        Lc_destaque := 'Y'
      else
        Lc_destaque := 'N';
      if (Lc_publicar = 'S') then
        Lc_publicar := 'Y'
      else
        Lc_publicar := 'N';
      Lc_Centimetro := 'Cm';
      try
        Lc_XmlProdutos.Add('<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?> ');
        Lc_XmlProdutos.Add('<produtos  xmlns="' + gb_site + '">');
        Lc_XmlProdutos.Add(' <op>'+ Pc_Operacao+'</op>');
        Lc_XmlProdutos.Add(' <product_id>'+ pc_codigo + '</product_id>');
        Lc_XmlProdutos.Add(' <product_parent_id>0</product_parent_id>');
        Lc_XmlProdutos.Add(' <product_sku>'+ pc_codigo+'</product_sku> ');
        Lc_XmlProdutos.Add(' <product_name>'+Lc_nome+'</product_name>  ');
        Lc_XmlProdutos.Add(' <product_desc><![CDATA['+Lc_descricao+']]></product_desc> ');
        Lc_XmlProdutos.Add(' <product_s_desc><![CDATA['+Lc_descricao+']]></product_s_desc> ');
        Lc_XmlProdutos.Add(' <product_thumb_image>'+Pc_codigo+'_tb.jpg' +'</product_thumb_image> ');
        Lc_XmlProdutos.Add(' <product_full_image>'+Pc_codigo+'.jpg' +'</product_full_image> ');
        Lc_XmlProdutos.Add(' <product_publish>'+ Lc_publicar+'</product_publish> ');
        Lc_XmlProdutos.Add(' <product_weight>'+Lc_peso+'</product_weight> ');
        Lc_XmlProdutos.Add(' <product_weight_uom>'+'Kg'+'</product_weight_uom> ');
        Lc_XmlProdutos.Add(' <product_length>0</product_length> ');
        Lc_XmlProdutos.Add(' <product_width>0</product_width> ');
        Lc_XmlProdutos.Add(' <product_height>0</product_height> ');
        Lc_XmlProdutos.Add(' <product_lwh_uom>'+Lc_Centimetro+'</product_lwh_uom> ');
        Lc_XmlProdutos.Add(' <product_unit>0</product_unit> ');
        Lc_XmlProdutos.Add(' <product_packaging>0</product_packaging> ');
        Lc_XmlProdutos.Add(' <product_url>0</product_url> ');
        Lc_XmlProdutos.Add(' <product_in_stock>' + Lc_disponivel +'</product_in_stock> ');
        Lc_XmlProdutos.Add(' <attribute>0</attribute> ');
        Lc_XmlProdutos.Add(' <custom_attribute>0</custom_attribute> ');
        Lc_XmlProdutos.Add('<product_available_date> ' +FormatDateTime('yyy-mm-dd hh:nn:ss', Now)+ '</product_available_date>  ');
        Lc_XmlProdutos.Add('<product_availability>' +'on-order.gif'+ '</product_availability> ');
        Lc_XmlProdutos.Add('<product_special>' + Lc_destaque + '</product_special> ');
        Lc_XmlProdutos.Add('<child_options>0</child_options> ');
        Lc_XmlProdutos.Add('<quantity_options>0</quantity_options> ');
        Lc_XmlProdutos.Add('<product_discount_id>0</product_discount_id> ');
        Lc_XmlProdutos.Add('<cdate>' + FormatDateTime('yyy-mm-dd hh:nn:ss', Now) +'</cdate> ');
        Lc_XmlProdutos.Add('<mdate>' + FormatDateTime('yyy-mm-dd hh:nn:ss', Now) +'</mdate> ');
        Lc_XmlProdutos.Add('<product_tax_id>0</product_tax_id> ');
        Lc_XmlProdutos.Add('<child_option_ids>0</child_option_ids> ');
        Lc_XmlProdutos.Add('<product_order_levels>0</product_order_levels> ');
        Lc_XmlProdutos.Add('<marca>' + Lc_Marca + '</marca> ');
        Lc_XmlProdutos.Add('<category_ids>' + Lc_codsbg + '</category_ids> ');
        Lc_XmlProdutos.Add('<product_currency>' +'BRL'+ '</product_currency>  ');
        Lc_XmlProdutos.Add('<price_quantity_start>0</price_quantity_start> ');
        Lc_XmlProdutos.Add('<price_quantity_end>0</price_quantity_end> ');
        Lc_XmlProdutos.Add('<product_price_vdate>0</product_price_vdate> ');
        Lc_XmlProdutos.Add('<product_price_edate>0</product_price_edate> ');
        Lc_XmlProdutos.Add('<product_price>' +Lc_valor_f+ '</product_price>  ');
        Lc_XmlProdutos.Add('<cdate>' + FormatDateTime('yyy-mm-dd hh:nn:ss', Now) +'</cdate> ');
        Lc_XmlProdutos.Add('<mdate>' + FormatDateTime('yyy-mm-dd hh:nn:ss', Now) +'</mdate>  ');
        Lc_XmlProdutos.Add('<shopper_group_id>5</shopper_group_id> ');
        Lc_XmlProdutos.Add('</produtos> ');
        Lc_ws := Getserver_ws_virtuemartPortType();

        Lc_result := Lc_ws.servico(Lc_XmlProdutos.Text, 'produto',gb_CNPJ);

        Lc_XmlProdutos.SaveToFile('C:\xml_produto' + pc_codigo + '.xml');

        Lc_XmlProdutos.Clear;
      except
        Lc_XmlProdutos.SaveToFile('C:\xml_produto' + pc_codigo + '.xml');
        Lc_XmlProdutos.Clear;
        Lc_result := 'Não foi possível cadastrar o produto...';
      end;
    finally
      Lc_XmlProdutos.Destroy;
    end;
  end;
  Lc_Qry.close;
  FreeandNil(Lc_Qry);    
end;

procedure Pc_VM_Atu_Grupo(Pc_Operacao,Pc_Codigo: string);
var
   result: WideString;
   ws: server_ws_virtuemartPortType;
   xmlCategoria: TStringList;
   Lc_descricao : String;
begin
  try
    DM.Qr_Acao.Active := False;
    DM.Qr_Acao.Transaction := DM.IBT_Estoque;
    DM.Qr_Acao.SQL.Clear;
    DM.Qr_Acao.SQL.Add('SELECT '+
                       ' GRP_DESCRICAO '+
                       'From TB_GRUPOS '+
                       'WHERE GRP_CODIGO =:GRP_CODIGO ');
    DM.Qr_Acao.ParamByName('GRP_CODIGO').AsString := pc_codigo;
    DM.Qr_Acao.Active := True;
    DM.Qr_Acao.FetchAll;
    Lc_descricao := DM.Qr_Acao.FieldByName('GRP_DESCRICAO').AsString;
    xmlCategoria := TStringList.Create;
    try
      xmlCategoria.Add('<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?>');
      xmlCategoria.Add('<categorias>                                                 ');
      xmlCategoria.Add('    <xmlns></xmlns>                                          ');
      xmlCategoria.Add('    <op>' + Pc_Operacao +'</op>                                               ');
      xmlCategoria.Add('    <category_publish>Y</category_publish>                   ');
      xmlCategoria.Add('    <category_name>'+ Lc_descricao +'</category_name>        ');
      xmlCategoria.Add('    <category_description>'+ Lc_descricao +'</category_description> ');
      xmlCategoria.Add('    <currentpos></currentpos>                                ');
      xmlCategoria.Add('    <category_fk_gestao>'+ pc_codigo +'</category_fk_gestao> ');
      xmlCategoria.Add('    <parent_category_id></parent_category_id>                ');
      xmlCategoria.Add('    <current_parent_id></current_parent_id>                  ');
      xmlCategoria.Add('    <products_per_row>1</products_per_row>                   ');
      xmlCategoria.Add('    <category_browsepage>managed</category_browsepage>       ');
      xmlCategoria.Add('    <category_flypage>flypage.tpl</category_flypage>         ');
      xmlCategoria.Add('    <category_thumb_image_curr></category_thumb_image_curr>  ');
      xmlCategoria.Add('    <category_full_image_curr></category_full_image_curr>    ');
      xmlCategoria.Add('    <category_full_image_action>none</category_full_image_action>');
      xmlCategoria.Add('    <category_full_image_url></category_full_image_url>      ');
      xmlCategoria.Add('    <category_thumb_image_action>none</category_thumb_image_action>');
      xmlCategoria.Add('    <category_thumb_image_url></category_thumb_image_url>    ');
      xmlCategoria.Add('    <category_id></category_id>                              ');
      xmlCategoria.Add('    <page>product.product_category_list</page>               ');
      xmlCategoria.Add('    <no_menu>0</no_menu>                                     ');
      xmlCategoria.Add('    <switchmenu>3</switchmenu>                               ');
      xmlCategoria.Add('</categorias>                                                ');

//      xmlCategoria.SaveToFile('C:\xml_categoria' + pc_codigo + '.xml');

      ws := Getserver_ws_virtuemartPortType();
      result := ws.servico(xmlCategoria.Text, 'categoria', Gb_CNPJ);
      except
        xmlCategoria.SaveToFile('C:\xml_categoria' + pc_codigo + '.xml');
        result := 'Não foi possível cadastar o grupo...';
      end;
   finally
      xmlCategoria.Clear;
      xmlCategoria.Destroy;
   end;
end;

procedure Pc_VM_Atu_SubGrupo(Pc_Operacao,Pc_Cd_SubGrupo,Pc_Cd_Grupo:string);
var
   result: WideString;
   ws: server_ws_virtuemartPortType;
   xmlSub_Categoria: TStringList;
   Lc_descricao : String;
begin
   try
    DM.Qr_Acao.Active := False;
    DM.Qr_Acao.Transaction := DM.IBT_Estoque;
    DM.Qr_Acao.SQL.Clear;
    DM.Qr_Acao.SQL.Add('SELECT '+
                       ' SBG_DESCRICAO '+
                       'From TB_SUBGRUPOS '+
                       'WHERE SBG_CODIGO =:SBG_CODIGO ');
    DM.Qr_Acao.ParamByName('SBG_CODIGO').AsString := Pc_Cd_SubGrupo;
    DM.Qr_Acao.Active := True;
    DM.Qr_Acao.FetchAll;
    Lc_descricao     := DM.Qr_Acao.FieldByName('SBG_DESCRICAO').AsString;

      xmlSub_Categoria := TStringList.Create;
      try
        xmlSub_Categoria.Add('<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?>');
        xmlSub_Categoria.Add('<subcategoria>                                               ');
        xmlSub_Categoria.Add('     <xmlns></xmlns>                                         ');
        xmlSub_Categoria.Add('     <op>I</op>                                              ');
        xmlSub_Categoria.Add('     <category_publish>Y</category_publish>                  ');
        xmlSub_Categoria.Add('     <category_name>'+ Lc_descricao +'</category_name>       ');
        xmlSub_Categoria.Add('     <category_description>'+ Lc_descricao +'</category_description>');
        xmlSub_Categoria.Add('     <currentpos></currentpos>                               ');
        xmlSub_Categoria.Add('     <category_fk_gestao>'+ Pc_Cd_SubGrupo +'</category_fk_gestao>');
        xmlSub_Categoria.Add('     <parent_category_id>'+ Pc_Cd_Grupo +'</parent_category_id>');
        xmlSub_Categoria.Add('     <current_parent_id></current_parent_id>                 ');
        xmlSub_Categoria.Add('     <products_per_row>1</products_per_row>                  ');
        xmlSub_Categoria.Add('     <category_browsepage>managed</category_browsepage>      ');
        xmlSub_Categoria.Add('     <category_flypage>flypage.tpl</category_flypage>        ');
        xmlSub_Categoria.Add('     <category_thumb_image_curr></category_thumb_image_curr> ');
        xmlSub_Categoria.Add('     <category_full_image_curr></category_full_image_curr>   ');
        xmlSub_Categoria.Add('     <category_full_image_action>none</category_full_image_action>');
        xmlSub_Categoria.Add('     <category_full_image_url></category_full_image_url>     ');
        xmlSub_Categoria.Add('     <category_thumb_image_action>none</category_thumb_image_action>');
        xmlSub_Categoria.Add('     <category_thumb_image_url></category_thumb_image_url>   ');
        xmlSub_Categoria.Add('     <category_id></category_id>                             ');
        xmlSub_Categoria.Add('     <page>product.product_category_list</page>              ');
        xmlSub_Categoria.Add('     <no_menu></no_menu>                                     ');
        xmlSub_Categoria.Add('     <switchmenu>3</switchmenu>                              ');
        xmlSub_Categoria.Add('</subcategoria>                                              ');

        ws := Getserver_ws_virtuemartPortType();

//        xmlSub_Categoria.SaveToFile('C:\xml_subcategoria' + Pc_Cd_SubGrupo +  '.xml');

        result := ws.servico(xmlSub_Categoria.Text, 'categoria', Gb_CNPJ);
      except
        xmlSub_Categoria.SaveToFile('C:\xml_subcategoria' + Pc_Cd_SubGrupo +  '.xml');
        result := 'Não foi possível se conectar ao WebService...';
      end;
   finally
      xmlSub_Categoria.Clear;
      xmlSub_Categoria.Destroy;
   end;
end;

procedure Pc_VM_Del_Grupo(pc_codigo: string);
var
   Lc_publish, Lc_result: WideString;
   Lc_ws: server_ws_virtuemartPortType;
   Lc_xmlCategoria: TStringList;
begin
  try
    Lc_xmlCategoria := TStringList.Create;
    try
      Lc_xmlCategoria.Add('<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?>');
      Lc_xmlCategoria.Add('<categoryList xmlns="' + gb_site + '">');
      Lc_xmlCategoria.Add(Format('<category xmlns="" op="D" category_fk_gestao="%s" product_id="" />', [pc_codigo]));
      Lc_xmlCategoria.Add('</categoryList> ');

      Lc_ws := Getserver_ws_virtuemartPortType();

      Lc_result := Lc_ws.servico(Lc_xmlCategoria.Text, 'categoria',gb_CNPJ);

//      xmlCategoria.SaveToFile('C:\xml_del_cat_' + pc_codigo + '.xml');

      Lc_xmlCategoria.Clear;

    except
//      It_XmlProdutos.SaveToFile('C:\xml_produto' + pc_codigo + '.xml');
      Lc_xmlCategoria.Clear;
      Lc_result := 'Não foi possível cadastrar o produto...';
    end;
  finally
    Lc_xmlCategoria.Destroy;
  end;
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(server_ws_virtuemartPortType), 'urn:server.ws_virtuemart', 'ISO-8859-1', '', 'server.ws_virtuemartPortType');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(server_ws_virtuemartPortType), 'urn:server.ws_virtuemart#ws_virtuemart');


end.