# DataAnalytics-Assessment
<br><br>
<strong>Q1. High-Value Customers with Multiple Products</strong>
<br><br>
The objective of this SQL query wass to provide a concise summary of user engagement with specific account types and their overall deposit activity. My approach to this question began by integrating data from the users_customuser table, which contains user identification details, with the savings_savingsaccount table, which records individual account transactions.
<br><br>
To achieve this, I employed the use of conditional aggregation. Specifically, using the COUNT function in conjunction with a CASE statement, I categorize and count the number of transactions associated with 'savings' accounts (<b>identified by a transaction_type_id of '1'</b>) and 'investment' accounts (<b>where transaction_type_id is '2'</b>) for each user.
<br><br>
Furthermore, I calculate the cumulative sum of successful deposits (transaction_status = 'success') across all the user's relevant accounts using the SUM function.
<br><br>
The JOIN clause ensures that I am considering only the transaction records that correspond to existing users. The GROUP BY clause is crucial as it aggregates these calculated metrics – the counts of savings and investment actions, and the total deposits – at the individual user level, providing a per-user summary. Finally, the ORDER BY clause is utilized for organizational purposes, presenting the resulting user summaries sorted by their unique identifier.
