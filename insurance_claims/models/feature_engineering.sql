SELECT
    row_number,
    policy_csl,
    SPLIT(policy_csl, '/')[0] as policy_amt,
    SPLIT(policy_csl, '/')[1] as csl_amt,
    policy_state,
    incident_state,
    CAST(policy_state = incident_state AS INT) as in_state,
    capital_gains,
    capital_loss,
    total_claim_amount,
    (capital_gains + capital_loss) / total_claim_amount as claim_capital_percent
FROM
    {{ ref('insurance_claims') }}