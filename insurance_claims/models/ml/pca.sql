{{
    config(
        materialized="model",
        ml_config={
            "model_type": "PCA",
            "scale_features": true,
            "PCA_EXPLAINED_VARIANCE_RATIO": 0.8
        }
    )
}}

-- doesn't work with package, expects a loss.
-- But compiled code can be run
SELECT * EXCEPT(row_number) FROM {{ ref('recombine_filter') }}