WITH
    MonthlyTransactions AS (
        -- "First, let's figure out how many transactions each customer makes each month."
        SELECT
            u.id AS customer_id, -- "I'm grabbing the customer's ID..."
            DATE_FORMAT(s.transaction_date, '%Y-%m-01') AS transaction_month, -- "...and the month of the transaction..."
            COUNT(s.savings_id) AS monthly_transactions -- "...and counting those transactions for that month."
        FROM
            users_customuser u -- "I'm pulling data from the 'users_customuser' table..."
        JOIN
            savings_savingsaccount s ON u.id = s.owner_id -- "...and connecting it to 'savings_savingsaccount' using the customer's ID."
        GROUP BY
            u.id, -- "I'm grouping by customer..."
            DATE_FORMAT(s.transaction_date, '%Y-%m-01') -- "...and by the month, so I get counts per customer per month."
    ),
    CustomerAvgTransactions AS (
        -- "Now, let's calculate the *average* number of transactions each customer makes per month."
        SELECT
            customer_id, -- "I'm taking the customer ID..."
            AVG(monthly_transactions) AS avg_transactions_per_month -- "...and calculating the average monthly transactions."
        FROM
            MonthlyTransactions -- "Using the monthly counts I just figured out."
        GROUP BY
            customer_id -- "And grouping by customer again."
    )
SELECT
    CASE
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month >= 3 AND avg_transactions_per_month <= 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category, -- "I'm putting customers into categories based on their average:"
    COUNT(*) AS customer_count, -- "And counting how many customers are in each category."
    AVG(avg_transactions_per_month) AS avg_transactions_per_month -- "And getting the average of those averages for each category."
FROM
    CustomerAvgTransactions -- "Using the average monthly transactions I calculated."
GROUP BY
    frequency_category -- "Grouping by the frequency category."
ORDER BY
    CASE
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        ELSE 3
    END; -- "And ordering the categories so 'High' comes first, then 'Medium', then 'Low'."