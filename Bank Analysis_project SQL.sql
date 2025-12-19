create database Loan_analytics;
use loan_analytics;

#SQL Project Report – Loan Analytics KPI Queries

/* KPI 1 — Year Wise Loan Amount Stats
•	Total loan amount per year*/
SELECT 
    YEAR(STR_TO_DATE(issue_d, '%d-%m-%Y')) AS issue_year,
    SUM(loan_amnt) AS total_loan_amount
FROM finance_1
GROUP BY issue_year
ORDER BY issue_year;

/* KPI 2 — Grade and Sub-Grade Wise Revolving Balance
•	Revolving balance summary by grade & sub-grade*/
SELECT 
    f1.grade,
    f1.sub_grade,
    SUM(f2.revol_bal) AS total_revol_bal
FROM finance_1 f1
JOIN finance_2 f2 USING(id)
GROUP BY f1.grade, f1.sub_grade
ORDER BY f1.grade, f1.sub_grade;


/* KPI 3 — Total Payment for Verified vs Non-Verified Status
•	Total payments split by verification status*/
SELECT 
    f1.verification_status,
    SUM(f2.total_pymnt) AS total_payments
FROM finance_1 f1
JOIN finance_2 f2 USING(id)
GROUP BY f1.verification_status;

/* KPI 4 — State Wise & Last Credit Pull Date Wise Loan Status
•	Loan status by state and last credit pull year*/

select f1.addr_state, f2.last_credit_pull_d, f1.loan_status, count(*) as Total_loans 
from finance_1 f1 join finance_2 f2 on f1.id=f2.id 
group by f1.addr_state, f2.last_credit_pull_d, f1.loan_status order by f1.addr_state,
f2.last_credit_pull_d;


/* KPI 5 — Home Ownership vs Last Payment Date Stats
Version A — Show last payment date by home ownership */
SELECT
    home_ownership,
    MAX(last_pymnt_d) AS latest_payment_date
FROM finance_1 f1
JOIN finance_2 f2 USING(id)
GROUP BY home_ownership;

#Version B — Average last payment amount & count
SELECT
    f1.home_ownership,
    AVG(f2.last_pymnt_amnt) AS avg_last_payment_amount,
    COUNT(f2.last_pymnt_d) AS count_of_payments
FROM finance_1 f1
JOIN finance_2 f2 USING(id)
GROUP BY f1.home_ownership;






;

