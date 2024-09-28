with
    int_funcionarios as (
        select *
        from {{ ref('int_funcionarios_preparacao') }}
    )

select *
from int_funcionarios
