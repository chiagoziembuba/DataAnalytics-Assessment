# DataAnalytics-Assessment
<br><br>
<strong>Q1. High-Value Customers with Multiple Products</strong>
<br><br>
The objective of this particular SQL query was to provide a concise summary of user engagement with specific account types and their overall deposit activity. My approach to this question began by integrating data from the <b>users_customuser</b> table, which contains user identification details, with the <b>savings_savingsaccount</b> table, which records individual account transactions.
<br><br>
To achieve this, I employed the use of conditional aggregation. Specifically, using the <b>COUNT</b> function in conjunction with a <b>CASE</b> statement, I categorize and count the number of transactions associated with 'savings' accounts (<b>identified by a transaction_type_id of '1'</b>) and 'investment' accounts (<b>where transaction_type_id is '2'</b>) for each user.
<br><br>
Furthermore, I calculated the cumulative sum of successful deposits <b>(transaction_status = 'success')</b> across all the user's relevant accounts using the <b>SUM</b> function.
<br><br>
The <b>JOIN</b> clause ensures that I am considering only the transaction records that correspond to existing users. The <b>GROUP BY</b> clause is crucial as it aggregates these calculated metrics – the counts of savings and investment actions, and the total deposits – at the individual user level, providing a per-user summary. Finally, the <b>ORDER BY</b> clause is utilized for organizational purposes, presenting the resulting user summaries sorted by their unique identifier.
<br><br>
<strong>Challenges Faced:</strong>
<br>The major challenge faced was the <b>non-existence</b> of important columns relevant to the solution of the problem. Columns like <b>account_status</b> column which is meant to show the status of the account whether it is active or suspended or even disabled wasn't available in all the tables in the sql file. To solve this particular issue, i had to make use of the <b>"transaction_status"</b> column in the <b>savings_savingsaccount</b> table to be able to resolve this issue and it worked. The analogy behind it was that only an active account could perform transactions successfully so if the <b>"transaction_status"</b> of the account is <b>"success"</b>, then the status of the account is <b>"active"</b>. 
<br> Other minor issues include the uncertainty of the values under the <b>"transaction_type_id"</b> column in the savings_savingsaccount table with only numbers given and no explanation or translation for what each number references to. Since that wasn't available and it was critically needed to solve the issue, i had to make use of a formula that implies that <b>"savings" is identified by a "transaction_type_id" of '1' </b> and <b>"investment" is identified by a "transaction_type_id" of '2'</b>. That was able to solve the question and provide a highly credible SQL Query.
<br><br>
<strong>Q2. Transaction Frequency Analysis</strong>
<br><br>
The objective for this particular question was to categorize customers based on their transaction frequency per month. To achieve this, I employed a multi-step approach leveraging <b>Common Table Expressions (CTEs)</b> for clarity and modularity.
<br><br>
First, I created the <b>MonthlyTransactions</b> CTE. The purpose of this step was to determine the number of transactions each customer made within each specific month. I joined the <b>users_customuser</b> and <b>savings_savingsaccount</b> tables using the owner_id to link transactions to individual customers. Then, I used the <b>DATE_FORMAT</b> function to extract the year and month from the <b>transaction date</b>, effectively grouping transactions on a monthly basis for each customer. Finally, I used the <b>COUNT</b> aggregate function to count the <b>savings_id</b> (representing a transaction) within each of these customer-month groups.
<br><br>
Next, I built upon the <b>MonthlyTransactions CTE</b> to create the <b>CustomerAvgTransactions CTE</b>. In this step, my goal was to calculate the average number of monthly transactions for each customer across all the months present in the data. I grouped the results from <b>MonthlyTransactions</b> by <b>customer_id</b> and used the <b>AVG</b> aggregate function on the <b>monthly_transactions</b> calculated in the previous step.
<br><br>
Finally, in the main <b>SELECT</b> statement, I categorized the customers based on their <b>avg_transactions_per_month</b> using a <b>CASE</b> statement. Customers with an average of 10 or more transactions per month were labeled <b>'High Frequency'</b>, those with an average between 3 and 9 were <b>'Medium Frequency'</b>, and those with 2 or fewer were <b>'Low Frequency'</b>. I then used the <b>COUNT</b> aggregate function to determine the number of customers within each of these frequency categories and the <b>AVG</b> function again to calculate the average of the average monthly transactions for each category. The results were grouped by the <b>frequency_category</b> to provide the summary statistics for each segment, and an <b>ORDER BY</b> clause with a <b>CASE</b> statement was used to present the frequency categories in a logical order: <b>High, Medium, and then Low.</b>"
<br><br>
<strong>Q3. Account Inactivity Alert</strong>
<br><br>
