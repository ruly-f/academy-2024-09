with
    ordens as (
        select *
        from {{ ref('stg_erp__ordens') }}
    )

    , pedido_itens as (
        select *
        from {{ ref('stg_erp__pedido_itens') }}
    )

    , joined as (
        select
            pedido_itens.PK_PEDIDO_ITEM
            , pedido_itens.FK_PRODUTO
            , ordens.FK_FUNCIONARIO
            , ordens.FK_CLIENTE
            , ordens.FK_TRANSPORTADORA
            , ordens.DATA_DO_PEDIDO
            , ordens.DATA_DO_ENVIO
            , ordens.DATA_REQUERIDA_ENTREGA
            , pedido_itens.DESCONTO_PERC
            , pedido_itens.PRECO_DA_UNIDADE
            , pedido_itens.QUANTIDADE
            , ordens.FRETE   
            , ordens.numero_pedido
            , ordens.NM_DESTINATARIO
            , ordens.CIDADE_DESTINATARIO
            , ordens.REGIAO_DESTINATARIO
            , ordens.PAIS_DESTINATARIO
        from pedido_itens
        inner join ordens on ordens.pk_pedido = pedido_itens.fk_pedido
    )

    , metricas as (
        select 
            *
            , quantidade * preco_da_unidade as valor_bruto
            , quantidade * preco_da_unidade * (1 - desconto_perc) as valor_liquido
            , frete / (count(*) over(partition by numero_pedido)) as frete_rateado
            , case
                when desconto_perc > 0 then true
                else false
            end as teve_desconto
        from joined
    )

    , final_select as (
        select
            PK_PEDIDO_ITEM
            , FK_PRODUTO
            , FK_FUNCIONARIO
            , FK_CLIENTE
            , FK_TRANSPORTADORA
            , DATA_DO_PEDIDO
            , DATA_DO_ENVIO
            , DATA_REQUERIDA_ENTREGA         
            , DESCONTO_PERC
            , PRECO_DA_UNIDADE
            , QUANTIDADE
            , VALOR_BRUTO
            , VALOR_LIQUIDO
            , cast(FRETE_RATEADO as numeric(18,2)) as frete_rateado
            , NUMERO_PEDIDO
            , NM_DESTINATARIO
            , CIDADE_DESTINATARIO
            , REGIAO_DESTINATARIO
            , PAIS_DESTINATARIO
            , TEVE_DESCONTO
        from metricas
    )

select *
from final_select