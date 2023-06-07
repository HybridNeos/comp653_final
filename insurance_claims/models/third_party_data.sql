WITH
-- average_prices as (
--     -- bigquery doesn't support grouping_sets
--     SELECT
--         Manufacturer,
--         Model,
--         Prod_year,
--         AVG(price) as avg_price,
--         CASE
--             WHEN Manufacturer IS NOT NULL AND Model IS NOT NULL AND Prod_year IS NOT NULL THEN 'make_model_year'
--             WHEN Manufacturer IS NOT NULL AND Model IS NOT NULL AND Prod_year IS NULL THEN 'make_model'
--             WHEN Manufacturer IS NOT NULL AND Model IS NULL AND Prod_year IS NULL THEN 'make'
--             WHEN Manufacturer IS NULL AND Model IS NULL AND Prod_year IS NULL THEN 'all_cars'
--             ELSE 'not_needed'
--         END AS average_over
--     FROM
--         {{ ref('car_prices_dataset') }}
--     GROUP BY
--         ROLLUP(Manufacturer, Model, Prod_year) 
-- ),
make_model_year as (
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
        AVG(price) as avg_price
    FROM
        {{ ref('car_prices_dataset') }}
    GROUP BY
        Manufacturer
)
SELECT
    DISTINCT
    claims.row_number,
    -- Crime / auto
    claims.incident_state,
    cr.violentRate as violent_rate,
    cr.nonViolentRate as non_violent_rate,
    fc.deaths_per_100k,
    fc.deaths_per_100mil_vehicle_miles,
    -- Car price
    claims.auto_make,
    claims.auto_model,
    claims.auto_year,
    COALESCE(m3.avg_price, m2.avg_price, m1.avg_price, (SELECT AVG(price) from {{ ref('car_prices_dataset') }})) as avg_price
    -- COALESCE(m3.avg_price, m2.avg_price, m1.avg_price, (SELECT avg_price from average_prices WHERE average_over = 'all_cars')) as avg_price
FROM
    {{ ref('insurance_claims') }} claims
    -- Crime / auto data
    INNER JOIN {{ ref('crime_rate_by_state') }} cr
        ON claims.incident_state = cr.state_abbrev
    INNER JOIN {{ ref('fatal_crash_2021') }} fc
        ON claims.incident_state = fc.state_abbrev
    -- Car price
    LEFT OUTER JOIN make_model_year m3
        ON  UPPER(claims.auto_make) = UPPER(m3.Manufacturer)
        AND UPPER(claims.auto_model) = UPPER(m3.Model)
        AND claims.auto_year = m3.Prod_year
    LEFT OUTER JOIN make_model m2
        ON  UPPER(claims.auto_make) = UPPER(m2.Manufacturer)
        AND UPPER(claims.auto_model) = UPPER(m2.Model)
    LEFT OUTER JOIN make m1
        ON  UPPER(claims.auto_make) = UPPER(m1.Manufacturer)
    -- better way?
    -- LEFT OUTER JOIN average_prices m3
    --     ON  UPPER(claims.auto_make) = m3.Manufacturer
    --     AND UPPER(claims.auto_model) = m3.Model
    --     AND claims.auto_year = m3.Prod_year
    --     AND m3.average_over = 'make_model_year'
    -- LEFT OUTER JOIN average_prices m2
    --     ON  UPPER(claims.auto_make) = m2.Manufacturer
    --     AND UPPER(claims.auto_model) = m2.Model
    --     AND m2.average_over = 'make_model'
    -- LEFT OUTER JOIN average_prices m1
    --     ON  UPPER(claims.auto_make) = m1.Manufacturer
    --     AND m1.average_over = 'make'