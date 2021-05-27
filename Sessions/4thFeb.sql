

--2) Create a Table
CREATE TABLE a_demo.employee (
    employee_id varchar(20) NOT NULL,
    department varchar(20) NOT NULL,
    first_name varchar(20) NOT NULL,
    last_name varchar(20) NOT NULL,
    gender varchar(6) NOT NULL,
    role varchar(50) NOT NULL
    PRIMARY KEY (employee_id)
);

-- 3) Create a Custom Data Type
CREATE TYPE a_demo.EmployeeType AS TABLE(
    RowKey varchar(20) NOT NULL,
    PartitionKey varchar(20) NOT NULL,
    FirstName varchar(20) NOT NULL,
    LastName varchar(20) NOT NULL,
    Gender varchar(6) NOT NULL,
    Role varchar(50) NOT NULL
)

-- 4) Create a Stored Procedure
CREATE PROCEDURE a_demo.uspUpsertEmployee @employee a_demo.EmployeeType READONLY
AS
BEGIN
  MERGE a_demo.employee AS target_sqldb
  USING @employee AS source_tblstg
  ON (target_sqldb.employee_id = source_tblstg.RowKey)
  WHEN MATCHED THEN
      UPDATE SET 
      department = source_tblstg.PartitionKey,
      first_name = source_tblstg.FirstName,
      last_name = source_tblstg.LastName,
      gender = source_tblstg.Gender,
      role = source_tblstg.Role
  WHEN NOT MATCHED THEN
      INSERT (
          employee_id,
          department,
          first_name,
          last_name,
          gender,
          role
        )
      VALUES (
          source_tblstg.RowKey,
          source_tblstg.PartitionKey,
          source_tblstg.FirstName,
          source_tblstg.LastName,
          source_tblstg.Gender,
          source_tblstg.Role
        );
END

-- 5) Drop schema
DROP SCHEMA IF EXISTS a_demo;