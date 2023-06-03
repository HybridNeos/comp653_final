SELECT
    ROW_NUMBER() OVER (ORDER BY NULL) as row_number,
    months_as_customer,
    -- age discriminatory
    -- policy_number not useful
    policy_bind_date,
    policy_state,
    policy_csl,
    policy_deductable,
    policy_annual_premium,
    umbrella_limit,
    -- insured_zip too granular
    -- insured_sex discriminatory
    insured_education_level,
    insured_occupation,
    -- insured_hobbies not useful (maybe)
    insured_relationship,
    capital_gains,
    capital_loss,
    incident_date,
    collision_type,
    incident_severity,
    authorities_contacted,
    incident_state,
    -- incident_city too granular
    -- incident_location too granular
    incident_hour_of_the_day,
    number_of_vehicles_involved,
    property_damage,
    bodily_injuries,
    witnesses,
    police_report_available,
    total_claim_amount,
    injury_claim,
    property_claim,
    vehicle_claim,
    --auto_make decide if want to join to https://www.kaggle.com/datasets/sidharth178/car-prices-dataset
    --auto_model,
    --auto_year
    fraud_reported
FROM
    {{ ref('raw_insurance_claims') }}