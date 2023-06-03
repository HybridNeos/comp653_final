SELECT
  'insured_education_level' as column,
  STRING_AGG(DISTINCT insured_education_level) as values
FROM
  {{ ref('insurance_claims') }}
UNION ALL
SELECT
  'insured_occupation' as column,
  STRING_AGG(DISTINCT insured_occupation) as values
FROM
  {{ ref('insurance_claims') }}
UNION ALL
SELECT
  'insured_relationship' as column,
  STRING_AGG(DISTINCT insured_relationship) as values
FROM
  {{ ref('insurance_claims') }}
UNION ALL
SELECT
  'collision_type' as column,
  STRING_AGG(DISTINCT collision_type) as values
FROM
  {{ ref('insurance_claims') }}
UNION ALL
SELECT
  'incident_severity' as column,
  STRING_AGG(DISTINCT incident_severity) as values
FROM
  {{ ref('insurance_claims') }}
UNION ALL
SELECT
  'authorities_contacted' as column,
  STRING_AGG(DISTINCT authorities_contacted) as values
FROM
  {{ ref('insurance_claims') }}

