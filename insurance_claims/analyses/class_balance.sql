SELECT
    fraud_reported,
    count(*) as num_rows,
    count(*)/(select count(*) from {{ ref('insurance_claims') }}) as percent
FROM
    {{ ref('insurance_claims') }}
GROUP BY
    fraud_reported