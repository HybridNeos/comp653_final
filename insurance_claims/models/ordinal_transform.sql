WITH first_transform as (
    SELECT
        claims.*,
        omap.rank as rank_incident_severity
    FROM
        {{ ref('insurance_claims') }} as claims
        INNER JOIN {{ ref('ordinal_mappings') }} as omap
            ON claims.incident_severity = omap.value
            AND omap.column = "incident_severity"
)
SELECT
    claims.*,
    omap.rank as rank_insured_education_level
FROM
    first_transform claims
    INNER JOIN {{ ref('ordinal_mappings') }} as omap
        ON claims.insured_education_level = omap.value
        AND omap.column = "insured_education_level"