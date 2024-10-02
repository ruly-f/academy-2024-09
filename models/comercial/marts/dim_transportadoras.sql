with
    fonte_transportadoras as (
        select *
        from {{ ref('stg_erp__transportadoras') }}
    )

select *
from fonte_transportadoras