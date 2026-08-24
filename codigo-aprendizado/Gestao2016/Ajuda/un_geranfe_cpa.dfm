inherited Fr_geranfe_cpa: TFr_geranfe_cpa
  Caption = 'Nota Fiscal Eletronica - Compras'
  ClientWidth = 610
  ExplicitWidth = 616
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited pg_Principal: TPageControl
    Width = 610
    ExplicitWidth = 610
    inherited tbs_NF_e: TTabSheet
      ExplicitWidth = 602
      inherited Panel4: TPanel
        Width = 602
        ExplicitWidth = 602
      end
      inherited pnl_NF_e: TPanel
        Width = 602
        ExplicitWidth = 602
        inherited Lb_titulo: TLabel
          Width = 598
        end
        inherited MM_Acompanhamento: TMemo
          Width = 598
          ExplicitWidth = 598
        end
        inherited CkBx_Nota_Manual: TCheckBox
          Width = 592
          ExplicitWidth = 592
        end
        inherited ChBx_NF_Referenciada: TCheckBox
          Width = 592
          ExplicitWidth = 592
        end
        inherited ChBx_NF_PreExistente: TCheckBox
          Width = 592
          ExplicitWidth = 592
        end
        inherited ChBx_Otimiza_obs: TCheckBox
          Width = 592
          ExplicitWidth = 592
        end
      end
    end
  end
  inherited Pnl_Validade: TPanel
    Width = 604
    ExplicitWidth = 604
    inherited Pnl_Cert_Expira: TPanel
      Width = 340
      ExplicitWidth = 340
    end
  end
  inherited Qr_Nota: TSTQuery
    SQL.Strings = (
      'SELECT  '
      '   PED_CODIGO, '
      '  PED_TIPO,'
      '   NFL_CODIGO, '
      '   NAT_DESCRICAO,'
      '   NFL_SERIE, '
      '   NAT_CFOP, '
      '   PED_NUMERO,'
      '   PED_indPres,'
      '   NFL_NUMERO, '
      '   NFL_VL_TL_NOTA,'
      '   EMP_CODIGO,  '
      '   EMP_CONSUMIDOR,'
      '   EMP_NOME, '
      '   EMP_FANTASIA,'
      '   EMP_CNPJ, '
      '   EMP_EMAIL,'
      '   END_ENDER,'
      '   END_BAIRRO,'
      '   END_CEP,  '
      '   CDD_IBGE, '
      '   CDD_DESCRICAO,'
      '   END_FONE, '
      '   UFE_SIGLA, '
      '   UFE_CODIGO,'
      '   END_PAIS,  '
      '   EMP_INSC_EST, '
      '   NFL_DT_EMISSAO, '
      '   NFL_DT_SAIDA,  '
      '   NFL_BS_ICMS, '
      '   NFL_VL_ICMS, '
      '   NFL_BS_ICMS_SUBST, '
      '   NFL_VL_ICMS_SUBST, '
      '   NFL_VL_TL_PROD, '
      '   NFL_VL_FRETE,  '
      '   NFL_VL_SEGURO, '
      '   NFL_VL_DESP_ACESS, '
      '   NFL_VL_IPI,  '
      '   NFL_QT_PRODUTO, '
      '   NFL_ESPECIE,'
      '   NFL_MARCA, '
      '   NFL_PESO_BRUTO, '
      '   NFL_PESO_LIQ,   '
      '   CLB_NOME, '
      '   NFL_STATUS,'
      '   NFL_TIPO,  '
      '   PED_OBS,'
      '   NFL_VL_TL_SRV,'
      '   PED_VL_DESCONTO, '
      '   PED_DT_ALTERA, '
      '   PED_CODTRP,'
      '   END_NUMERO,'
      '   NFL_CODTRP,'
      '  NFL_VOL_NUMERO,'
      '  MDF_GRUPO,'
      '  NFL_PLC_VEICULO,'
      '  NFL_PLC_UF,'
      '  NFL_PLC_RNTC,'
      '  PAI_DESCRICAO,'
      '  PED_PRAZO,'
      '  PED_CODEND,'
      '  CLI_IND_IE_DEST'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal                           '
      '     INNER JOIN TB_PEDIDO tb_pedido                       '
      '     ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)   '
      '     INNER  JOIN TB_NATUREZA tb_natureza                  '
      '     ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT) '
      '     INNER JOIN TB_EMPRESA tb_empresa'
      '     ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)  '
      '     INNER JOIN TB_CLIENTE tb_cliente'
      '     ON (tb_cliente.CLI_CODEMP = tb_empresa.EMP_CODIGO)  '
      '     INNER  JOIN TB_ENDERECO tb_endereco                  '
      '     ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '     INNER JOIN TB_CIDADE tb_cidade'
      '     ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '     INNER JOIN TB_UF tb_uf'
      '     ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      '     INNER  JOIN TB_PAIS tb_pais'
      '     ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS)   '
      '     LEFT OUTER  JOIN TB_COLABORADOR tb_colaborador'
      '     ON (tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO)   '
      '     INNER  JOIN tb_modal_frete tb_modal_frete'
      
        '     ON (tb_modal_frete.mdf_codigo = tb_nota_fiscal.nfl_cta_fret' +
        'e)'
      'WHERE (tb_nota_fiscal.NFL_NUMERO ='#39'1'#39')')
  end
end
