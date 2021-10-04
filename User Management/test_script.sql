EXECUTE AS USER = 'sde';
GO

--CREATE TABLE PRIVILEGE
CREATE TABLE sde.test_table (
	student_id INT PRIMARY KEY
	,last_name VARCHAR(30) NOT NULL
	,course_id INT NULL
	);

DROP TABLE sde.test_table;

--CREATE VIEW PRIVILEGE
CREATE VIEW sde.test_view
AS
(
		SELECT *
		FROM sde.test_table
		);

DROP VIEW sde.test_view;

--CREATE PROC PRIVILEGE
CREATE PROCEDURE sde.test_proc
AS
SELECT *
FROM sde.test_table GO;

DROP PROCEDURE sde.test_proc;

--CREATE FUNCTION PRIVILEGE
CREATE FUNCTION sde.test_function ()
RETURNS TABLE
AS
RETURN (
		SELECT *
		FROM sde.test_table
		);

DROP FUNCTION sde.test_function;

-- VIEW DATABASE STATE
SELECT TOP (10) *
FROM sys.dm_os_wait_stats;