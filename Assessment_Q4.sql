SELECT
    u.id AS customer_id, -- "Let's grab each customer's unique ID and call it 'customer_id'."
    u.username AS name, -- "And their username, which we'll call 'name'."
    FLOOR(DATEDIFF(CURDATE(), u.date_joined) / 30.44) AS tenure_months, -- "Now, to figure out how long they've been with us in months, I'm calculating the difference between today and when they joined, and then approximating it to months."
    COUNT(s.savings_id) AS total_transactions, -- "Let's also count up all the transactions each customer has made."
    (COUNT(s.savings_id) / FLOOR(DATEDIFF(CURDATE(), u.date_joined) / 30.44)) * 12 * AVG(s.amount * 0.001) AS estimated_clv -- "Here's the big one: I'm estimating their Customer Lifetime Value using a formula that considers their total transactions, how long they've been a customer (in years), and an assumed profit of 0.1% per transaction."
FROM
    users_customuser u -- "I'm starting with the 'users_customuser' table..."
JOIN
    savings_savingsaccount s ON u.id = s.owner_id -- "...and connecting it to the 'savings_savingsaccount' table based on matching customer IDs."
GROUP BY
    u.id, -- "I need to group the results by customer ID..."
    u.username, -- "...and username..."
    u.date_joined -- "...and their join date, so I get one CLV estimate per customer."
ORDER BY
    estimated_clv DESC; -- "Finally, I'm ordering the customers by their estimated CLV, from highest to lowest."