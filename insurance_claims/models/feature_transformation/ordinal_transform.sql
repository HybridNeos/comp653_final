WITH first_transform as (
    SELECT
        DISTINCT
        claims.row_number,
        claims.incident_severity,
        omap.rank as rank_incident_severity,
        claims.insured_education_level -- need for next query
    FROM
        {{ ref('insurance_claims') }} as claims
        INNER JOIN {{ ref('ordinal_mappings') }} as omap
            ON claims.incident_severity = omap.value
            AND omap.column = "incident_severity"
)
SELECT
    DISTINCT
    claims.row_number,
    claims.incident_severity,
    claims.rank_incident_severity,
    claims.insured_education_level,
    omap.rank as rank_insured_education_level
FROM
    first_transform claims
    INNER JOIN {{ ref('ordinal_mappings') }} as omap
        ON claims.insured_education_level = omap.value
        AND omap.column = "insured_education_level"