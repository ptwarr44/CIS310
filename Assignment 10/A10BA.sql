--Patrick Warren
--CIS310-01
--A10BA
--Using Create and Alter statements to add and manipulate
--all of the constraints

--CREATE THE PRODUCTDIM TABLE
CREATE TABLE PRODUCTDIM
(
	PRODUCTID	INT IDENTITY NOT NULL,
	PROD_SKU	VARCHAR(15),
	PROD_DESCRIPT	VARCHAR(255),
	PROD_TYPE	VARCHAR(255),
	BRAND_ID	NUMERIC(4,0),
	BRAND_NAME	VARCHAR(100),
	BRAND_TYPE	VARCHAR(20)
)

--CREATE THE CUSTOMERDIM TABLE
CREATE TABLE CUSTOMERDIM
(
	CUSTOMERID	INT IDENTITY NOT NULL,
	CUST_CODE	NUMERIC(38,0),
	CUST_FNAME	VARCHAR(20),
	CUST_LNAME	VARCHAR(20),
	CUST_CITY	VARCHAR(50),
	CUST_STATE	CHAR(2),
	CUST_ZIP	CHAR(5)
)

--CREATE THE TIMEDIM TABLE
CREATE TABLE TIMEDIM
(
	TIMEID	INT IDENTITY NOT NULL,
	INV_DATE	DATE,
	YEAR	INT,
	MONTH	INT,
	QUARTER	INT
)

--CREATE THE EMPLOYEEDIM TABLE
CREATE TABLE EMPLOYEEDIM
(
	EMPLOYEEID	INT	IDENTITY NOT NULL,
	EMP_NUM		VARCHAR(20),
	EMP_FNAME	VARCHAR(25),
	EMP_LNAME	VARCHAR(25),
	EMP_TITLE	VARCHAR(45),
	DEPT_NUM	NUMERIC(5,0),
	DEPT_NAME	VARCHAR(50)
)

--CREATE THE FACT TABLE
CREATE TABLE FACT
(
	PRODUCTID	INT NOT NULL,
	TIMEID		INT NOT NULL,
	CUSTOMERID	INT NOT NULL,
	EMPLOYEEID	INT NOT NULL,
	LINE_QTY	NUMERIC(18,0),
	LINE_PRICE	NUMERIC(8,2)
)

--CREATE STAGING TABLE
CREATE TABLE STAGING
(
	PRODUCTID	INT,
	TIMEID		INT,
	CUSTOMERID	INT,
	EMPLOYEEID	INT,
	LINE_QTY	NUMERIC(18,0),
	LINE_PRICE	NUMERIC(8,2),
	EMP_NUM		VARCHAR(20),
	INV_DATE	DATE,
	CUST_CODE	NUMERIC(38,0),
	PROD_SKU	VARCHAR(15),
)

DROP TABLE STAGING

--ADD CONSTRAINTS TO TABLES
ALTER TABLE PRODUCTDIM
	ADD CONSTRAINT PK_PRODUCTDIM PRIMARY KEY (PRODUCTID)

ALTER TABLE CUSTOMERDIM
	ADD CONSTRAINT PK_CUSTOMERDIM PRIMARY KEY (CUSTOMERID)

ALTER TABLE TIMEDIM
	ADD CONSTRAINT PK_TIMEID PRIMARY KEY (TIMEID)

ALTER TABLE EMPLOYEEDIM
	ADD CONSTRAINT PK_EMPLOYEEID PRIMARY KEY (EMPLOYEEID)

ALTER TABLE FACT
	ADD CONSTRAINT PK_FACT PRIMARY KEY (PRODUCTID, CUSTOMERID, TIMEID, EMPLOYEEID),
		CONSTRAINT FK_FACT_PRODUCTDIM FOREIGN KEY (PRODUCTID) REFERENCES PRODUCTDIM,
		CONSTRAINT FK_FACT_CUSTMERDIM FOREIGN KEY (CUSTOMERID) REFERENCES CUSTOMERDIM,
		CONSTRAINT FK_FACT_TIMEDIM	FOREIGN KEY (TIMEID) REFERENCES TIMEDIM,
		CONSTRAINT FK_FACT_EMPLOYEEDIM FOREIGN KEY (EMPLOYEEID) REFERENCES EMPLOYEEDIM