{{
    config(
        materialized="model",
        ml_config={
            "model_type": "PCA",
            "scale_features": true,
            "PCA_EXPLAINED_VARIANCE_RATIO": 0.9
        }
    )
}}

-- doesn't work with package, expects a loss.
-- But compiled code can be run
SELECT * FROM {{ ref('train_data') }}