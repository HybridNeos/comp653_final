{{
    config(
        materialized="model",
        ml_config={
            "model_type": "LOGISTIC_REG",
            "description": "something", 
            "early_stop": true,
            "data_split_method": "RANDOM",
            "data_split_eval_fraction": 0.2,
            "l2_reg": 0.01,
        }
    )
}}
--            "auto_class_weights": true,

SELECT * EXCEPT(row_number) FROM {{ ref('recombine_filter') }}