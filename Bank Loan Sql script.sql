--Loading the Table
use [Bank LoanDB];

SELECT COUNT(id) FROM Bank_Loan_Data;

-- Q1) Calculate the Total number of Loan Applications. 
SELECT COUNT(id) AS Total_Loan_Applications FROM Bank_Loan_Data;

-- Q2) Calculate the Month to Date number of Loan Applications for Dec. 
SELECT COUNT(id) AS MTD_Total_Loan_Applications FROM Bank_Loan_Data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

--Q3) Calculate the Month to Date number of Loan Applications from JAN - DEC 2021.
SELECT MONTH(issue_date) AS Month, COUNT(id) AS MTD_Total_Loan_Applications FROM Bank_Loan_Data
GROUP BY MONTH(issue_date) 
ORDER BY MONTH DESC;

--Q4) Calculate the Total Funded Amount of Loan Applications for DEC 2021.
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM Bank_Loan_Data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

--Q5) Calculate the Previous Month To Date (PMTD) Total Funded Amount of Loan Applications.
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM Bank_Loan_Data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--Q6) Calculate the Total Amount received back for Loan Applications.
SELECT SUM(total_payment) AS Total_Amount_Recived FROM Bank_Loan_Data;

--Q7) Calculate the Month to Date Total Amount received back for Loan Applications.
SELECT SUM(total_payment) AS MTD_Total_Amount_Recived FROM Bank_Loan_Data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

--Q8) Calculate the Avg interest rate for Loan Applications.
SELECT ROUND(AVG(int_rate),4)*100 AS Average_Interest_Rate FROM Bank_Loan_Data;

--Q9) Calculate the Month to Date avg interest rate for Loan Applications.
SELECT ROUND(AVG(int_rate),4)*100 AS MTD_Average_Interest_Rate FROM Bank_Loan_Data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

--Q10) Calculate the Previous Month to Date avg interest rate for Loan Applications.
SELECT ROUND(AVG(int_rate),4)*100 AS PMTD_Average_Interest_Rate FROM Bank_Loan_Data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--NOTE-- Higher the Avg or Interest rate its always beneficial for the bank.

--Q11) Calculate the Avg Debt-to-Income for Bank Loan Applications.

--ALTER TABLE Bank_Loan_Data
--ALTER COLUMN dti float(50);

SELECT Round(AVG(dti),4) * 100 AS Average_DTI FROM Bank_Loan_Data;

--Q12) Calculate the Avg Debt-to-Income forcurrent month Bank Loan Applications.
SELECT Round(AVG(dti),4) * 100 AS MTD_Average_DTI FROM Bank_Loan_Data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

--Q13) Calculate the Previous Month Avg Debt-to-Income for Bank Loan Applications.
SELECT Round(AVG(dti),4) * 100 AS MTD_Average_DTI FROM Bank_Loan_Data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--Q14) Calculate the Good Loan Percentage
SELECT 
    (COUNT(CASE WHEN  loan_status = 'Current' OR loan_status = 'Fully Paid' THEN id END)* 100)
	/
	COUNT(id) AS Good_Loan_Percentage
FROM Bank_Loan_Data;

--Q15) Calculate the Count of Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM Bank_Loan_Data
WHERE loan_status = 'Current' OR loan_status = 'Fully Paid';

--Q15) Calculate Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM bank_loan_data
WHERE loan_status = 'Current' OR loan_status = 'Fully Paid';

--Q16) Calculate the Good Loan Received_Amount 
SELECT SUM(total_payment) AS Good_Loan_Received_Amount FROM bank_loan_data
WHERE loan_status = 'Current' OR loan_status = 'Fully Paid';

--Q17) Calculate the Bad Loan Percentage
SELECT 
    (COUNT(CASE WHEN  loan_status = 'Charged Off'THEN id END)* 100)
	/
	COUNT(id) AS Bad_Loan_Percentage
FROM Bank_Loan_Data;

--Q18) Calculate the Count of Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM Bank_Loan_Data
WHERE loan_status = 'Charged Off';

--Q19) Calculate Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount FROM bank_loan_data
WHERE loan_status = 'Charged Off';

--Q20) Calculate the Bad Loan Received Amount 
SELECT SUM(total_payment) AS Bad_Loan_Received_Amount FROM bank_loan_data
WHERE loan_status = 'Charged Off';

--Q21) Analysing Different Majors from Data
SELECT loan_status,
COUNT(id) AS Total_Amount_Received,
SUM(total_payment)AS Total_Amount_Received,
SUM(loan_amount) AS Total_Funded_Amount,
AVG(int_rate * 100) AS Interest_Rate,
AVG(dti *100) AS DTI
FROM bank_loan_data
GROUP BY loan_status;

--Q21) Analysing Different Majors from Data with respect to Month to date 
SELECT loan_status,
SUM(total_payment)AS MTD_Total_Amount_Received,
SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status;

--Q22) 
SELECT 
DATENAME(MONTH, issue_date) AS Month_Name,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Recived_Amount
FROM bank_loan_data
GROUP BY DATENAME(MONTH, issue_date)
ORDER BY DATENAME(MONTH, issue_date) DESC;

--Q23) Montly Trends by Issue Date
SELECT 
MONTH(issue_date) AS Month_Number,
DATENAME(MONTH, issue_date) AS Month_Name,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Recived_Amount
FROM bank_loan_data
GROUP BY MONTH(issue_date) , DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date) ;

--Q24 Regional Analysis by State 
SELECT 
address_state,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Recived_Amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY COUNT(id) DESC;

-- Q25 Loan Term Analysis
 SELECT 
 term,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Recived_Amount
FROM bank_loan_data
GROUP BY term
ORDER BY term;

-- Q26 Employee Length Analysis
 SELECT 
 emp_length,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Recived_Amount
FROM bank_loan_data
GROUP BY emp_length
ORDER BY COUNT(id) DESC;

-- Q27 Loan Purpose Breakdown
 SELECT 
purpose,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Recived_Amount
FROM bank_loan_data
GROUP BY purpose 
ORDER BY COUNT(id) DESC;

--Home Ownership Analysis
SELECT 
home_ownership,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Recived_Amount
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;
 