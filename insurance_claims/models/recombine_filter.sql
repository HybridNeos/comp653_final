SELECT
    -- Vanilla columns
    ins.row_number,
    ins.months_as_customer,
    ins.umbrella_limit,
    ins.insured_relationship,
    ins.capital_gains,
    ins.capital_loss,
    ins.authorities_contacted,
    ins.incident_hour_of_the_day,
    ins.number_of_vehicles_involved,
    ins.bodily_injuries,
    ins.witnesses,
    -- Ordinal
    ord.rank_incident_severity,
    ord.rank_insured_education_level,
    -- Feature engineered
    fe.policy_amt,
    fe.csl_amt,
    fe.in_state,
    fe.claim_capital_percent,
    -- Third party
    tpd.violent_rate,
    tpd.non_violent_rate,
    tpd.deaths_per_100k,
    tpd.deaths_per_100mil_vehicle_miles,
    tpd.avg_car_price,
    -- Target variable and train / test split column
    CASE
        WHEN ins.fraud_reported = 'Y'
        THEN 1
        ELSE 0
    END as label,
    ROUND(ABS(RAND()),1) AS split_field
FROM
    {{ ref('insurance_claims') }} ins
    INNER JOIN {{ ref('ordinal_transform') }} ord
        ON ins.row_number = ord.row_number
    INNER JOIN {{ ref('feature_engineering') }} fe
        ON ins.row_number = fe.row_number
    INNER JOIN {{ ref('third_party_data') }} tpd
        ON ins.row_number = tpd.row_number