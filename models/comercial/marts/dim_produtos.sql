with
    int_produtos as (
        select *
        from {{ ref('int_produtos_enriquecida') }}
    )

select *
from int_produtos
