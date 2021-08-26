/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  StoredProcedure [dm].[usp_inc_merge_dim_nsp_employee]    Script Date: 22/07/2021 5:06:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Name 		: dm.usp_inc_merge_dim_nsp_employee
 Author     : Shubham Mishra
 Created On : 17, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
CREATE PROCEDURE [dm].[usp_inc_merge_dim_nsp_employee] (@pipeline_name AS VARCHAR(100) = NULL, @run_id AS VARCHAR(100) = NULL)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000), @ROW INT
	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'
	BEGIN TRY
		MERGE dm.dim_nsp_employee AS D
		USING dm.view_inc_dim_nsp_employee AS S
			ON (D.employeeId = S.employeeId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT ([employeeId],[employeeOrganisationId],[orgName],[businessRole],[employeeStatus],[employeeUserName],[employeeName],[employeeEmail],[employeeGender],[employeeMaritalStatus],[employeeMobilePhone],[employeeFixedPhone],[language],[startDate],[endDate],[managerName],[managerEmail],[hasOfflineMobileGroupId])
				VALUES (S.[employeeId],S.[employeeOrganisationId],S.[orgName],S.[businessRole],S.[employeeStatus],S.[employeeUserName],S.[employeeName],S.[employeeEmail],S.[employeeGender],S.[employeeMaritalStatus],S.[employeeMobilePhone],S.[employeeFixedPhone],S.[language],S.[startDate],S.[endDate],S.[managerName],S.[managerEmail],S.[hasOfflineMobileGroupId])
		WHEN MATCHED
			THEN
				UPDATE
				SET [employeeOrganisationId] = S.[employeeOrganisationId]
,[orgName] = S.[orgName]
,[businessRole] = S.[businessRole]
,[employeeStatus] = S.[employeeStatus]
,[employeeUserName] = S.[employeeUserName]
,[employeeName] = S.[employeeName]
,[employeeEmail] = S.[employeeEmail]
,[employeeGender] = S.[employeeGender]
,[employeeMaritalStatus] = S.[employeeMaritalStatus]
,[employeeMobilePhone] = S.[employeeMobilePhone]
,[employeeFixedPhone] = S.[employeeFixedPhone]
,[language] = S.[language]
,[startDate] = S.[startDate]
,[endDate] = S.[endDate]
,[managerName] = S.[managerName]
,[managerEmail] = S.[managerEmail]
,[hasOfflineMobileGroupId] = S.[hasOfflineMobileGroupId]

		WHEN NOT MATCHED BY SOURCE
			THEN
				DELETE
		OUTPUT $ACTION
			,Inserted.*
			,Deleted.*;
		SET @ROW = (
				SELECT @@ROWCOUNT
				);
		INSERT INTO [AUDIT].[data_model_merge_log] (
			schema_name, table_name ,last_run_ts ,last_run_status, count, pipeline_name, run_id
			)
		VALUES (
			'dm', 'dim_nsp_employee', CURRENT_TIMESTAMP, 'SUCCESS', @ROW, @pipeline_name, @run_id
			);
	END TRY
	BEGIN CATCH
		EXEC @ERROR_PROC @pipeline_name = @pipeline_name
			,@run_id = @run_id;
		INSERT INTO [AUDIT].[data_model_merge_log] (
			schema_name, table_name ,last_run_ts ,last_run_status, count, pipeline_name, run_id
			)
		VALUES (
			'dm', 'dim_nsp_employee', CURRENT_TIMESTAMP, 'FAIL', NULL, @pipeline_name, @run_id
			);
	END CATCH
END 
GO


