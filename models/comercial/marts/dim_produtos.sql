with
    int_funcionarios as (
        select *
        from {{ ref('int_produtos_enriquecida') }}
    )

select *
from int_funcionarios
