{{
    config(
        materialized="model",
        ml_config={
            "model_type": "LOGISTIC_REG",
            "enable_global_explain": true,
            "early_stop": true,
            "data_split_method": "RANDOM",
            "data_split_eval_fraction": 0.2,
            "l2_reg": 0.1,
            "auto_class_weights": true
        }
    )
}}

SELECT * FROM {{ ref('train_data') }}