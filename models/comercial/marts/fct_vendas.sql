with
    int_vendas as (
        select *
        from {{ ref('int_vendas_metricas') }}
    )

    , dim_produtos as (
        select *
        from {{ ref('dim_produtos') }}
    )

    , dim_funcionarios as (
        select *
        from {{ ref('dim_funcionarios') }}
    )

    , dim_clientes as (
        select *
        from {{ ref('dim_clientes') }}
    )

    , dim_transportadoras as (
        select *
        from {{ ref('dim_transportadoras') }}
    )

select *
from int_vendas
