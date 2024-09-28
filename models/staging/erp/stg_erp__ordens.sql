with
    renomeado as (
        select
            cast(id as int) pk_pedido
            , cast(employeeid as int) as fk_funcionario
            , cast(customerid as string) as fk_cliente
            , cast(shipvia as int) as fk_transportadora
            , cast(id as int) numero_pedido
            , cast(orderdate as date) as data_do_pedido
            , cast(shippeddate as date) as data_do_envio
            , cast(requireddate as date) as data_requerida_entrega
            , cast(freight as numeric) as frete
            , cast(shipname as string) as nm_destinatario
            , cast(shipcity as string) as cidade_destinatario
            , cast(shipregion as string) as regiao_destinatario
            , cast(shipcountry as string) as pais_destinatario
        from {{ source('erp_northwind', '_order_') }}
    )

select *
from renomeado