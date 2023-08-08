{{
    config(
        materialized="model",
        ml_config={
            "model_type": "LOGISTIC_REG",
            "enable_global_explain": true,
            "learn_rate_strategy": "CONSTANT",
            "CLASS_WEIGHTS": [STRUCT('1', 3), STRUCT('0', 1)]
        }
    )
}}

SELECT * FROM {{ ref('train_data') }}
-- resample
-- UNION ALL
-- SELECT * FROM {{ ref('train_data') }} WHERE label = 1