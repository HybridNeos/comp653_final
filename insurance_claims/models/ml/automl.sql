{{
    config(
        materialized="model",
        ml_config={
            "model_type": "AUTOML_CLASSIFIER",
            "OPTIMIZATION_OBJECTIVE": "MAXIMIZE_AU_ROC"
        }
    )
}}
--            "auto_class_weights": true,

SELECT * EXCEPT(row_number, split_field) FROM {{ ref('recombine_filter') }}