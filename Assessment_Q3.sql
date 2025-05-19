SELECT
    p.id AS plan_id, -- "First, I'm selecting the plan's unique ID and calling it 'plan_id'."
    p.owner_id, -- "Then, I'm getting the ID of the account owner."
    CASE
        WHEN p.plan_type_id = 1 THEN 'Savings' -- "Now, I'm checking the plan type. If it's '1', it's a 'Savings' account..."
        WHEN p.plan_type_id = 2 THEN 'Investment' -- "...if it's '2', it's an 'Investment'..."
        ELSE 'Other' -- "...otherwise, I'm labeling it as 'Other'."
    END AS type, -- "And I'm calling this category 'type'."
    COALESCE(MAX(s.transaction_date), p.created_on) AS last_transaction_date, -- "To find the last activity, I'm looking for the latest transaction date. If there are no transactions, I'll use the date the plan was created."
    DATEDIFF(CURRENT_DATE, COALESCE(MAX(s.transaction_date), p.created_on)) AS inactivity_days -- "Then, I'm calculating how many days it's been since that last activity."
FROM
    plans_plan p -- "I'm starting with the 'plans_plan' table, and I'll call it 'p'."
LEFT JOIN
    savings_savingsaccount s ON p.id = s.plan_id -- "I'm joining it with the 'savings_savingsaccount' table (calling it 's') based on matching plan IDs. I'm using a 'LEFT JOIN' so I keep all plans even if they have no transactions."
WHERE
    p.status_id = 1 -- "I'm only interested in plans that have a status ID of '1' (which likely means 'active')."
GROUP BY
    p.id, p.owner_id, p.plan_type_id, p.created_on -- "I'm grouping the results by plan ID, owner ID, plan type ID, and the creation date to get one row per plan."
HAVING
    DATEDIFF(CURRENT_DATE, COALESCE(MAX(s.transaction_date), p.created_on)) < 365 -- "Finally, I'm only keeping the plans where the inactivity period is less than 365 days (meaning they've had some activity in the last year)."
ORDER BY
    p.id; -- "And I'm ordering the results by the plan ID."