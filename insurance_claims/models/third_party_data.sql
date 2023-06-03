SELECT
    DISTINCT
    claims.row_number,
    claims.incident_state,
    cr.violentRate as violent_rate,
    cr.nonViolentRate as non_violent_rate,
    fc.deaths_per_100k,
    fc.deaths_per_100mil_vehicle_miles
FROM
    {{ ref('insurance_claims') }} claims
    INNER JOIN {{ ref('crime_rate_by_state') }} cr
        ON claims.incident_state = cr.state_abbrev
    INNER JOIN {{ ref('fatal_crash_2021') }} fc
        ON claims.incident_state = fc.state_abbrev