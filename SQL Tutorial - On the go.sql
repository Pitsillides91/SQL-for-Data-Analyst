-- Created by: Yiannis Pitsillides


---- SQL Tutorial Part 1:
-- Environment Set up: How to download and install SQL Server and SQL Server Management Studio
-- How to create a new Database
-- How to input data into SQL
-- How to master the SELECT query and the WHERE CLAUSE 
-- WHERE CLAUSE with Subqueries 


---- SQL Tutorial Part 2:
-- IFF Statement
-- CASE Statement
-- UPDATE
-- REPLACE
-- INSERT INTO 
-- DELETE
-- Aggregated Functions: SUM / MIN / MAX/ AVG/ COUNT


---- SQL Tutorial Part 3:
-- LEFT JOIN
-- FULL JOIN
-- CROSS JOIN
-- UNION ALL


-------------------------------------------------------------------------------------------------------------------
--------------------------------------------- Simple SQL Querries -------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

--------------------------------------
---- Shortcut Keys to know------------
--------------------------------------

-- CTRL + C = Copy
-- CTRL + X = Cut
-- CTRL + V = Paste
-- CTRL + Z = Undo / back
-- F5 in SQL = Run


-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- Data Types - ---------------------------------------------------
-------------------------------------------------------------------------------------------------------------------


-- VARCHAR(25) - Is for characters - you cannot apply aggregated functions on this
-- NVARCHAR (25)  - Is for characters - you cannot apply aggregated functions on this
-- FLOAT - Is for Number values with decimal; so you can aggregate the data - SUM/AVG/MIN/MAX
-- Int is for Number swith no decimal places
-- Date is for dates


-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- SELECT Query ---------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

-- * means all

USE Youtube_db

SELECT * FROM yt_Opportunities_Data --4,133

SELECT New_Account_No, Opportunity_ID FROM yt_Opportunities_Data



-- Exm 1 - 1 Condition: =
SELECT * FROM yt_Opportunities_Data WHERE Product_Category = 'Services' --1,269

-- Exm 2 - 1 Condition: <>
SELECT * FROM yt_Opportunities_Data WHERE Opportunity_Stage <> 'Stage - 0'

-- Exm 3 - 1 Condition: IN
SELECT * FROM yt_Opportunities_Data WHERE Opportunity_Stage IN ('Stage - 0','Stage - 1','Stage - 2','Stage - 3') 

-- Exm 4 - 1 Condition: NOT IN
SELECT * FROM yt_Opportunities_Data WHERE Opportunity_Stage NOT IN ('Stage - 0','Stage - 1','Stage - 2','Stage - 3') 

-- Exm 5 - 1 Condition: LIKE
SELECT * FROM yt_Opportunities_Data WHERE New_Opportunity_Name NOT LIKE '%Phase - 1%'

-- Exm 6 - 2 Condition: AND
SELECT * FROM yt_Opportunities_Data WHERE Product_Category = 'Services' AND Opportunity_Stage = 'Stage - 5'

-- Exm 7 - 2 Condition: OR
SELECT * FROM yt_Opportunities_Data WHERE Product_Category = 'Services' OR Opportunity_Stage = 'Stage - 5'

-- Exm 8 - 2 Condition: AND / OR
SELECT * FROM yt_Opportunities_Data WHERE (Product_Category = 'Services' AND Opportunity_Stage = 'Stage - 5') OR New_Opportunity_Name LIKE '%Phase - 7%'

-- Exm 9 - 1 Condition: >
SELECT * FROM yt_Opportunities_Data WHERE Est_opportunity_Value > '50000'

-- Exm 10 - 1 Condition: >
SELECT * FROM yt_Opportunities_Data WHERE Est_opportunity_Value < '50000'

-- Exm 10 - 1 Condition: BETWEEN
SELECT * FROM yt_Opportunities_Data WHERE Est_opportunity_Value BETWEEN 30000 AND 50000


-- IF YOU FEEL YOU GOT VALUE OUT OF THIS VIDEO PLEASE LIKE AND SUBSCRIBE!!!


-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- WHERE CLAUSE with SubQueries ----------------------------------
-------------------------------------------------------------------------------------------------------------------

SELECT * FROM yt_account_lookup
SELECT * FROM yt_Opportunities_Data 
SELECT * FROM yt_Calendar_lookup

--Exm 1 - 1 condition from another table
SELECT * FROM yt_Opportunities_Data WHERE New_Account_No IN (SELECT New_Account_No FROM yt_account_lookup WHERE Sector = 'Banking')

-- Exm 2 - 1 condition from another table - FY20
SELECT * FROM yt_Opportunities_Data WHERE Est_Completion_Month_ID IN (SELECT DISTINCT Month_ID FROM yt_Calendar_lookup WHERE Fiscal_Year = 'FY20')

-- Exm 2 - 1 condition from another table - FY20 & 1 Condition 
SELECT * FROM yt_Opportunities_Data WHERE Est_Completion_Month_ID IN (SELECT DISTINCT Month_ID FROM yt_Calendar_lookup WHERE Fiscal_Year = 'FY20') AND Est_Opportunity_Value > 50000


-- IF YOU FEEL YOU GOT VALUE OUT OF THIS VIDEO PLEASE LIKE AND SUBSCRIBE!!!

-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- IIF & Case Statements in SQL------------------------------------
-------------------------------------------------------------------------------------------------------------------

SELECT * FROM yt_Opportunities_Data 

-- Exm 1: 1 IIF Condition - same column names

SELECT New_Account_No, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID, IIF(Product_Category = 'Services', 'Services & Markting', Product_Category) AS Product_Category,
Opportunity_Stage, Est_Opportunity_Value FROM yt_Opportunities_Data 

-- Exm 2: Multible iif statements with a new column
SELECT * FROM
	(
	SELECT *,
	IIF(New_Opportunity_Name LIKE '%Phase - 1%', 'Phase 1',
	IIF(New_Opportunity_Name LIKE '%Phase - 2%', 'Phase 2',
	IIF(New_Opportunity_Name LIKE '%Phase - 3%', 'Phase 3',
	IIF(New_Opportunity_Name LIKE '%Phase - 4%', 'Phase 4',
	IIF(New_Opportunity_Name LIKE '%Phase - 5%', 'Phase 5', 'Need Mapping'))))) AS Opps_Phase
	FROM yt_Opportunities_Data 
	) a
WHERE Opps_Phase = 'Need Mapping'


-- Exm 1: Case 
SELECT New_Account_No, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID, 
CASE
	WHEN Product_Category = 'Services' THEN 'Services & Markting'
	ELSE Product_Category
	END AS Product_Category,
Opportunity_Stage, Est_Opportunity_Value FROM yt_Opportunities_Data --4,133

-- Exm 2: CASE with multible conditions

SELECT *,
CASE
	WHEN New_Opportunity_Name LIKE '%Phase - 1%' THEN 'Phase 1'
	WHEN New_Opportunity_Name LIKE '%Phase - 2%' THEN 'Phase 2'
	WHEN New_Opportunity_Name LIKE '%Phase - 3%' THEN 'Phase 3'
	WHEN New_Opportunity_Name LIKE '%Phase - 4%' THEN 'Phase 4'
	WHEN New_Opportunity_Name LIKE '%Phase - 5%' THEN 'Phase 5'
	ELSE 'Need Mapping'
	END AS Opps_Phase
FROM yt_Opportunities_Data


-- IF YOU FEEL YOU GOT VALUE OUT OF THIS VIDEO PLEASE LIKE AND SUBSCRIBE!!!

-------------------------------------------------------------------------------------------------------------------
---------------------------------------- UPDATE / REPLACE / INSERT INTO / DELETE-----------------------------------
-------------------------------------------------------------------------------------------------------------------

SELECT * FROM yt_account_lookup

--Exm 1: renaming a column

SELECT *, IIF(Sector = 'Capital Markets/Securities', 'Capital Markets', Sector) AS Sector2 FROM yt_account_lookup


UPDATE yt_account_lookup
SET Sector = IIF(Sector = 'Capital Markets/Securities', 'Capital Markets', Sector) 


--Exm 2: Replace

SELECT *, IIF(Sector = 'Capital Markets/Securities', 'Capital Markets', Sector) AS Sector2,
REPLACE(Account_Segment, 'PS', 'Public Sector') AS Account_Segment2
FROM yt_account_lookup

UPDATE yt_account_lookup
SET Account_Segment = REPLACE(Account_Segment, 'PS', 'Public Sector')



-- Exm 3: INSERT INTO

INSERT INTO yt_account_lookup
SELECT '12412431', 'New Account Name', 'Test Industry', NULL, NULL, NULL, NULL, 'Yiannis'

SELECT * FROM yt_account_lookup WHERE Industry_Manager = 'Yiannis'

-- Exm 4: deleting data
DELETE FROM yt_account_lookup WHERE Industry_Manager = 'Yiannis'


-- IF YOU FEEL YOU GOT VALUE OUT OF THIS VIDEO PLEASE LIKE AND SUBSCRIBE!!!


-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- Main Aggregate Functions in SQL---------------------------------
-------------------------------------------------------------------------------------------------------------------

SELECT * FROM yt_Opportunities_Data 

-- Exm 1: SUM - 1 COLUMN
SELECT Product_Category, Opportunity_Stage, SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM yt_Opportunities_Data 
WHERE Opportunity_Stage = 'Stage - 4'
GROUP BY Product_Category, Opportunity_Stage

-- Exm 2: SUM - 2 columns
SELECT Product_Category, Opportunity_Stage, SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM yt_Opportunities_Data 
--WHERE Opportunity_Stage = 'Stage - 4'
GROUP BY Product_Category, Opportunity_Stage
ORDER BY Product_Category, Opportunity_Stage

-- Exm 3: SUM - Order by Value
SELECT Product_Category, Opportunity_Stage, SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM yt_Opportunities_Data 
--WHERE Opportunity_Stage = 'Stage - 4'
GROUP BY Product_Category, Opportunity_Stage
ORDER BY SUM(Est_Opportunity_Value) DESC

-- Exm 4: COUNT - 1 COLUMN
SELECT Product_Category, COUNT(Opportunity_ID) AS No_Of_Opportunities FROM yt_Opportunities_Data 
GROUP BY Product_Category
ORDER BY COUNT(Opportunity_ID) DESC

-- Exm 5: MIN
SELECT Product_Category, MIN(Est_Opportunity_Value) AS MIN_Est_Opportunity_Value FROM yt_Opportunities_Data 
GROUP BY Product_Category

-- Exm 6: MAX
SELECT Product_Category, MAX(Est_Opportunity_Value) AS MAX_Est_Opportunity_Value FROM yt_Opportunities_Data 
GROUP BY Product_Category

SELECT * FROM yt_Opportunities_Data WHERE  Est_Opportunity_Value = 1000000


-- IF YOU FEEL YOU GOT VALUE OUT OF THIS VIDEO PLEASE LIKE AND SUBSCRIBE!!!

-------------------------------------------------------------------------------------------------------------------
---------------------------------------- LEFT/FULL/CROSS join Statements in SQL------------------------------------
-------------------------------------------------------------------------------------------------------------------

SELECT * FROM yt_Opportunities_Data
SELECT * FROM yt_account_lookup 

-- Exm 1: LEFT JOIN

-- 1. We need to SELECT the columns we need from the 2 or more tables we are going to JOIN
-- 2. Need to identify the column(s) that are identical in each table so we can JOIN them
-- 3. Need to specify on top which columns we need from each table


SELECT a.*, b.New_Account_Name, b.Industry
FROM
	(
	SELECT New_Account_No, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID, Product_Category, Opportunity_Stage, Est_Opportunity_Value FROM yt_Opportunities_Data
	) a -- 4,133

	LEFT JOIN
	(
	SELECT New_Account_No, New_Account_Name, Industry FROM yt_account_lookup
	) b -- 1,145
	ON a.New_Account_No = b.New_Account_No

	-- 4,133

SELECT DISTINCT New_Account_No FROM yt_Opportunities_Data --1,139
SELECT DISTINCT New_Account_No FROM yt_account_lookup -- 1,445


SELECT * FROM yt_account_lookup WHERE New_Account_No NOT IN (SELECT DISTINCT New_Account_No FROM yt_Opportunities_Data) --6 ACCOUNTS
--984131730
----

SELECT a.*, b.New_Account_Name, b.Industry FROM yt_Opportunities_Data a
LEFT JOIN yt_account_lookup b
ON a.New_Account_No = b.New_Account_No

-----

-- Exm 2: FULL JOIN


SELECT ISNULL(a.New_Account_No, b.New_Account_No) AS New_Account_No,
ISNULL(a.Opportunity_ID, 'No opportunities') AS Opportunity_ID,
a.New_Opportunity_Name, a.Est_Completion_Month_ID, a.Product_Category, a.Opportunity_Stage, a.Est_Opportunity_Value ,
b.New_Account_Name, b.Industry
FROM
	(
	SELECT New_Account_No, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID, Product_Category, Opportunity_Stage, Est_Opportunity_Value FROM yt_Opportunities_Data
	) a -- 4,133

	FULL JOIN
	(
	SELECT New_Account_No, New_Account_Name, Industry FROM yt_account_lookup
	) b -- 1,145
	ON a.New_Account_No = b.New_Account_No

	-- BEFORE: 4,133
	-- NOW: 4,139


-- Exm 3: CROSS JOIN
--SELECT * FROM yt_Calendar_lookup

SELECT * FROM yt_Opportunities_Data


SELECT a.*, b.*
FROM
	(
	SELECT Product_Category, SUM(Est_Opportunity_Value) AS BASELINE FROM yt_Opportunities_Data
	WHERE Est_Completion_Month_ID = (SELECT MAX(Est_Completion_Month_ID)-2 FROM yt_Opportunities_Data)
	GROUP BY Product_Category
	) a

	CROSS JOIN
	(
	SELECT DISTINCT Fiscal_Month FROM yt_Calendar_lookup WHERE Fiscal_Year = 'FY19' AND [Date] > (SELECT GETDATE()+30)
	) b

-- IF YOU FEEL YOU GOT VALUE OUT OF THIS VIDEO PLEASE LIKE AND SUBSCRIBE!!!

-------------------------------------------------------------------------------------------------------------------
---------------------------------------- UNION ALL Statements in SQL-----------------------------------------------
-------------------------------------------------------------------------------------------------------------------

--SELECT * FROM yt_Opportunities_Data

-- Exm 1
SELECT Product_Category, SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM yt_Opportunities_Data 
GROUP BY Product_Category

UNION ALL
SELECT 'Totals:' AS Whatever, SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM yt_Opportunities_Data 


-- Exm 2

SELECT 'FY20-Q1 Opps Value' AS [Period], SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM yt_Opportunities_Data 
WHERE Est_Completion_Month_ID IN (SELECT DISTINCT Month_ID FROM yt_Calendar_lookup WHERE Fiscal_Quarter = 'FY20-Q1')

UNION ALL
SELECT 'FY20-Q2 Opps Value' AS [Period], SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM yt_Opportunities_Data 
WHERE Est_Completion_Month_ID IN (SELECT DISTINCT Month_ID FROM yt_Calendar_lookup WHERE Fiscal_Quarter = 'FY20-Q2')

UNION ALL
SELECT 'FY20-Q3 Opps Value' AS [Period], SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM yt_Opportunities_Data 
WHERE Est_Completion_Month_ID IN (SELECT DISTINCT Month_ID FROM yt_Calendar_lookup WHERE Fiscal_Quarter = 'FY20-Q3')

UNION ALL
SELECT 'FY20-Q4 Opps Value' AS [Period], SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM yt_Opportunities_Data 
WHERE Est_Completion_Month_ID IN (SELECT DISTINCT Month_ID FROM yt_Calendar_lookup WHERE Fiscal_Quarter = 'FY20-Q4')


-- IF YOU FEEL YOU GOT VALUE OUT OF THIS VIDEO PLEASE LIKE AND SUBSCRIBE!!!




