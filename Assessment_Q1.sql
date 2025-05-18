SELECT
    u.id AS owner_id, -- "Alright, first I'm grabbing each user's unique ID and calling it 'owner_id'."
    u.username AS name, -- "Then, I'm getting their username and simply calling it 'name'."
    -- "Now, for the savings count, I'm checking each account. If its type is '1', I count it as a savings account."
    COUNT(CASE WHEN s.transaction_type_id = '1' THEN s.savings_id END) AS savings_count,
    -- "Similarly, for investments, if an account's type is '2', I count it as an investment."
    COUNT(CASE WHEN s.transaction_type_id = '2' THEN s.savings_id END) AS investment_count,
    -- "Finally, I'm adding up the balances of all their accounts to get the 'total_deposits'."
    SUM(s.new_balance) AS total_deposits
FROM
    users_customuser u -- "I'm starting with our 'users_customuser' table, and I'll just call it 'u' for short."
JOIN
    savings_savingsaccount s ON u.id = s.owner_id -- "Then, I'm connecting it to the 'savings_savingsaccount' table (I'll call it 's') based on matching user IDs."
WHERE
    s.transaction_status = 'success'  -- "I only want to look at accounts that are marked as 'success' in their status."
    AND s.transaction_type_id IN ('1', '2') -- "And I'm specifically interested in accounts that have a type of '1' or '2'."
GROUP BY
    u.id,       -- "I want to group all the results by each unique user ID..."
    u.username  -- "...and their username, so I get one row of results per user."
ORDER BY
    u.id;       -- "Lastly, I'm just sorting the results by the user ID."