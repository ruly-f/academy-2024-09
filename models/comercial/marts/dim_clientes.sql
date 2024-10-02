with
    fonte_clientes as (
        select *
        from {{ ref('stg_erp__clientes') }}
    )

select *
from fonte_clientes