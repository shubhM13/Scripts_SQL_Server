----------------------------------------- CREATE LOGIN TO DB -----------------------------------------------------------------------------
CREATE LOGIN farms_gis_user
	WITH PASSWORD = 'Esri4Coffeeecosystem@2021'
GO

CREATE LOGIN sde
	WITH PASSWORD = 'Esri4Farms@2021'
GO


----------------------------------------- CREATE USER IN MASTER & FARMS DB ----------------------------------------------------------------------
CREATE USER farms_gis_user
FOR LOGIN farms_gis_user
GO

CREATE USER sde
FOR LOGIN sde
GO


---------------------------------------Create SDE schema and grant select permission on other schema to sde user------------------------------
CREATE SCHEMA sde AUTHORIZATION sde

GRANT SELECT
	ON SCHEMA::dm
	TO sde

GRANT SELECT
	ON SCHEMA::dwh
	TO sde

GRANT SELECT
	ON SCHEMA::stg
	TO sde

GRANT SELECT
	ON SCHEMA::audit
	TO sde

GRANT SELECT
	ON SCHEMA::aaa
	TO sde

GRANT SELECT
	ON SCHEMA::sys
	TO sde

GRANT SELECT
	ON SCHEMA::INFORMATION_SCHEMA
	TO sde

GRANT SELECT
	ON SCHEMA::dbo
	TO sde
GO

GRANT SELECT
	ON SCHEMA::gis
	TO sde
GO

----------------------------------Create GIS Schema & Grant Select Permissions to Gis User -------------------------------------

CREATE SCHEMA gis AUTHORIZATION farms_gis_user

GRANT SELECT
	ON SCHEMA::dm
	TO farms_gis_user

GRANT SELECT
	ON SCHEMA::dwh
	TO farms_gis_user

GRANT SELECT
	ON SCHEMA::stg
	TO farms_gis_user

GRANT SELECT
	ON SCHEMA::audit
	TO farms_gis_user

GRANT SELECT
	ON SCHEMA::aaa
	TO farms_gis_user

GRANT SELECT
	ON SCHEMA::sys
	TO farms_gis_user

GRANT SELECT
	ON SCHEMA::INFORMATION_SCHEMA
	TO farms_gis_user

GRANT SELECT
	ON SCHEMA::dbo
	TO farms_gis_user
GO

GRANT SELECT
	ON SCHEMA::sde
	TO farms_gis_user
GO


-----------------------------------------------Grant Create Permission to sde and gis users on their own schema ------------------------------

GRANT CREATE TABLE, CREATE VIEW, CREATE FUNCTION, CREATE PROCEDURE TO sde;
GO

GRANT CREATE TABLE, CREATE VIEW, CREATE FUNCTION, CREATE PROCEDURE TO farms_gis_user;
GO
------------------------------------------- Test-----------------------------------------------------------------------------------------------
EXECUTE AS USER = 'sde';
GO

CREATE TABLE sde.students (
	student_id INT PRIMARY KEY
	,last_name VARCHAR(30) NOT NULL
	,course_id INT NULL
	);

DROP TABLE sde.students;

CREATE TABLE dm.students (
	student_id INT PRIMARY KEY
	,last_name VARCHAR(30) NOT NULL
	,course_id INT NULL
	);

DROP TABLE dm.students;

CREATE TABLE gis.students (
	student_id INT PRIMARY KEY
	,last_name VARCHAR(30) NOT NULL
	,course_id INT NULL
	);

DROP TABLE gis.students;

EXECUTE AS USER = 'farms_gis_user';
GO

CREATE TABLE sde.students (
	student_id INT PRIMARY KEY
	,last_name VARCHAR(30) NOT NULL
	,course_id INT NULL
	);

DROP TABLE sde.students;

CREATE TABLE dm.students (
	student_id INT PRIMARY KEY
	,last_name VARCHAR(30) NOT NULL
	,course_id INT NULL
	);

DROP TABLE dm.students;

CREATE TABLE gis.students (
	student_id INT PRIMARY KEY
	,last_name VARCHAR(30) NOT NULL
	,course_id INT NULL
	);

DROP TABLE gis.students;

select top(10)* from dm.dim_entity_master;
