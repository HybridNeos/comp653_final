SELECT
    * EXCEPT(row_number, split_field)
FROM
    {{ ref('recombine_filter') }}
WHERE
    split_field <= {{ var("train_percent") }}