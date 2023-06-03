{{
    config(
        materialization='ephemeral'
    )
}}

WITH make_model_year as (
    SELECT
        Manufacturer,
        Model,
        Prod_year,
        AVG(price) as avg_price
    FROM
        {{ ref('car_prices_dataset') }}
    GROUP BY
        Manufacturer,
        Model,
        Prod_year
),
make_model as (
    SELECT
        Manufacturer,
        Model,
        NULL as Prod_year,
        AVG(price) as avg_price
    FROM
        {{ ref('car_prices_dataset') }}
    GROUP BY
        Manufacturer,
        Model
),
make as (
    SELECT
        Manufacturer,
        NULL as Model,
        NULL as Prod_year,
        AVG(price) as avg_price
    FROM
        {{ ref('car_prices_dataset') }}
    GROUP BY
        Manufacturer
)
SELECT
    Manufacturer as make,
    Model as model,
    Prod_year as year,
    avg_price
FROM
    make_model_year
UNION ALL
SELECT
    Manufacturer as make,
    Model as model,
    NULL as year,
    avg_price
FROM
    make_model
UNION ALL
SELECT
    Manufacturer as make,
    NULL as model,
    NULL as year,
    avg_price
FROM
    make