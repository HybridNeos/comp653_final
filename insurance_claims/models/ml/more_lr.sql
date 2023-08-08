{{
    config(
        materialized="model",
        ml_config={
            "model_type": "LOGISTIC_REG",
            "enable_global_explain": true,
            "early_stop": true,
            "data_split_method": "RANDOM",
            "data_split_eval_fraction": 0.2,
            "l2_reg": 10,
            "auto_class_weights": true
        }
    )
}}

SELECT
    label,
    authorities_contacted,
    rank_incident_severity,	
    insured_relationship,	
    non_violent_rate,	
    number_of_vehicles_involved,	
    witnesses,
    policy_amt,	
    csl_amt,	
    umbrella_limit,	
    rank_insured_education_level
FROM
    {{ ref('recombine_filter') }}