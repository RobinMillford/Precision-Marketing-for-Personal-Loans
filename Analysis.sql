use projects;

select * from personal_data;

SELECT COUNT(*) AS total_records
FROM personal_data;

-- 1.the average income
SELECT AVG(Income) AS AverageIncome
FROM personal_data;

-- 2.the top 10 records based on income
SELECT *
FROM personal_data
ORDER BY Income DESC
LIMIT 10;

-- 3.the average income by education
SELECT Education, AVG(Income) AS AverageIncome
FROM personal_data
GROUP BY Education;

-- 4.the top 2 incomes for each education level 
WITH RankedData AS (
  SELECT
    Education,
    Income,
    RANK() OVER (PARTITION BY Education ORDER BY Income DESC) AS IncomeRank
  FROM
    personal_data
)
SELECT
  Education,
  Income
FROM
  RankedData
WHERE
  IncomeRank <= 2;
  
-- 5. Profiling Customer Demographics.
SELECT
  CASE
    WHEN Age BETWEEN 18 AND 30 THEN '18-30'
    WHEN Age BETWEEN 31 AND 45 THEN '31-45'
    WHEN Age BETWEEN 46 AND 60 THEN '46-60'
    ELSE '61+'
  END AS AgeGroup,
  COUNT(*) AS RecordCount
FROM
  personal_data
GROUP BY
  AgeGroup;
  
  
SELECT
  AVG(Age) AS AverageAge
FROM
  personal_data
WHERE
  CCAvg > (SELECT AVG(CCAvg) FROM personal_data);
  
-- 7.records with incomes above 1.5 times the overall average
SELECT *
FROM personal_data
WHERE Income > 1.5 * (SELECT AVG(Income) FROM personal_data);

-- 8.the youngest age in each family group
SELECT
  Family,
  MIN(Age) AS YoungestAge
FROM
  personal_data
GROUP BY
  Family;
  
  
-- 9.retrieve records with non-zero mortgage
SELECT *
FROM personal_data
WHERE Mortgage > 0;

-- 10.the count of customers for each education level 
SELECT
  Education,
  COUNT(*) AS CustomerCount
FROM
  personal_data
WHERE
  Mortgage > 0
GROUP BY
  Education;
  
-- 11.the Average Income for Customers with Personal Loans, Grouped by Education Level
SELECT
  Education,
  AVG(Income) AS AvgIncomeWithLoan
FROM
  personal_data
WHERE
  `Personal Loan` = 1
GROUP BY
  Education;
  
  
-- 12.the Percentage of Customers with CD Accounts in Each Account Holder Category
SELECT
  `Account_holder_category`,
  COUNT(CASE WHEN `CD Account` = 1 THEN 1 ELSE NULL END) / COUNT(*) * 100 AS CD_Account_Percentage
FROM
  personal_data
GROUP BY
  `Account_holder_category`;
  
  
-- 13. the Age Range with the Highest Credit Card Usage
SELECT
  CONCAT(CEIL(Age / 10) * 10 - 9, '-', CEIL(Age / 10) * 10) AS AgeRange,
  COUNT(*) AS CreditCardUsers
FROM
  personal_data
WHERE
  `CreditCard` = 1
GROUP BY
  AgeRange
ORDER BY
  CreditCardUsers DESC
LIMIT 1;


-- 14.the Average CCAG for Customers with Securities Accounts, Grouped by Family Size
SELECT
  Family,
  AVG(CCAvg) AS AvgCCAGWithSecurities
FROM
  personal_data
WHERE
  `Securities Account` = 1
GROUP BY
  Family;
  

-- 15.the Education Level with the Highest Percentage of Online Users
SELECT
  Education,
  COUNT(CASE WHEN Online = 1 THEN 1 ELSE NULL END) / COUNT(*) * 100 AS Online_Percentage
FROM
  personal_data
GROUP BY
  Education
ORDER BY
  Online_Percentage DESC
LIMIT 1;


-- 16.the Average Income for Customers with CD Accounts, Grouped by Family Size and Online Usage
SELECT
  Family,
  Online,
  AVG(Income) AS AvgIncomeWithCD
FROM
  personal_data
WHERE
  `CD Account` = 1
GROUP BY
  Family, Online;
  
  
-- 17. the Age Group with the Highest Proportion of Customers with Securities Accounts and Personal Loans
SELECT
  CONCAT(CEIL(Age / 10) * 10 - 9, '-', CEIL(Age / 10) * 10) AS AgeGroup,
  COUNT(CASE WHEN `Securities Account` = 1 AND `Personal Loan` = 1 THEN 1 ELSE NULL END) / COUNT(*) * 100 AS ProportionWithSecuritiesAndLoan
FROM
  personal_data
GROUP BY
  AgeGroup
ORDER BY
  ProportionWithSecuritiesAndLoan DESC
LIMIT 1;


-- 18.the Education Level with the Highest Average Mortgage Amount
SELECT
  Education,
  AVG(Mortgage) AS AvgMortgageAmount
FROM
  personal_data
GROUP BY
  Education
ORDER BY
  AvgMortgageAmount DESC
LIMIT 1;


-- 19.the Percentage of Customers with Personal Loans in Each Age Range
SELECT
  CONCAT(CEIL(Age / 10) * 10 - 9, '-', CEIL(Age / 10) * 10) AS AgeRange,
  COUNT(CASE WHEN `Personal Loan` = 1 THEN 1 ELSE NULL END) / COUNT(*) * 100 AS PersonalLoanPercentage
FROM
  personal_data
GROUP BY
  AgeRange;
  
  
-- 20.the Average Experience for Customers with a Credit Card, Grouped by Account Holder Category
SELECT
  `Account_holder_category`,
  AVG(Experience) AS AvgExperienceWithCreditCard
FROM
  personal_data
WHERE
  `CreditCard` = 1
GROUP BY
  `Account_holder_category`;