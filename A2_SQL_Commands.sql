-- A2: Demonstrate indexing and associated operations.
-- Indexing with only SQL commands:

/*Create a table*/
Create table employee
(
	empno integer not null
	constraint EMPLOYEE_PK_VIOLATION
	primary key,
	empname char(20) not null,
	sex char(1) not null
	Constraint EMPLOYEE_SEX_VIOLATION
	check (sex in ('m','f')),
	phone integer null,
	dob date default '01-jan-1901' not null
);

/*Insert data into table*/
Insert into employee  values(&eno,&ename,&sex,&phone,&dob);	

/*Create a Index on sex*/
Create INDEX empsex_index on employee(sex);

/*Query the data*/
Select * From employee where sex= ‘m’;

/*View the query execution plan*/
EXPLAIN PLAN FOR
SELECT * FROM employees WHERE sex = ‘m’;
SELECT * FROM table(DBMS_XPLAN.DISPLAY);

-- Output:
SQL> Create INDEX empsex_index on employee(sex);
-- Index created.
SQL> select * from employee where sex='m';
--      EMPNO EMPNAME              S      PHONE 	DOB
-- ---------- -------------------- - ---------- -------------  --------------
--          1 abdulbasith          	m 	9035789789 	05-MAY-03
--          2 bhanu                	m       	4165 		19-MAY-03
--          3 abhishek             	m        	897 		12-DEC-04
--          4 joy                  		m        	732 		18-AUG-05
--          5 pratham              	m         46 		17-JUN-12
--          6 lalit                		m       	7896 		14-SEP-05
--          7 akhil                		m        	135 		14-AUG-02
--          8 sagar                	m       	5285 		03-DEC-07
--          9 chinmay              	m      	45625 		23-NOV-12

-- SQL> Explain plan for
--   2  select * from employee where sex='m';
-- Explained.
-- SQL> SELECT * FROM table(DBMS_XPLAN.DISPLAY);

-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------
-- Plan hash value: 4021620938
-- --------------------------------------------------------------------------------
-- | Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)   | Time     |
-- --------------------------------------------------------------------------------
-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT            |              |     6 |   228 |     2   (0)
-- | 00:00:01 |

-- |   1 |  TABLE ACCESS BY INDEX ROWID| EMPLOYEE     |     6 |   228 |     2   (0)
-- | 00:00:01 |

-- |*  2 |   INDEX RANGE SCAN          | EMPSEX_INDEX |     6 |       |     1   (0)
-- | 00:00:01 |
-- --------------------------------------------------------------------------------
-- ------------
-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------
-- Predicate Information (identified by operation id):
-- ---------------------------------------------------
--    2 - access("SEX"='m')

-- 14 rows selected.

