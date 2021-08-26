/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  StoredProcedure [dm].[usp_inc_merge_dim_nsc_employee]    Script Date: 22/07/2021 4:02:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Name 		: dm.usp_inc_merge_dim_nsc_employee
 Author     : Shubham Mishra
 Created On : 01, Jul, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
--drop procedure dm.usp_inc_merge_dim_nsc_employee
CREATE PROCEDURE [dm].[usp_inc_merge_dim_nsc_employee] (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_nsc_employee AS D
		USING dm.view_inc_dim_nsc_employee AS S
			ON (D.employeeId = S.employeeId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[employeeId]
					,[userName]
					,[employeeOrganisationId]
					,[businessRoleTxt]
					,[employeestatus]
					,[employeename]
					,[employeeGender]
					,[employeeMaritalStatus]
					,[employeeEmail]
					,[employeeMobilePhone]
					,[employeeFixedPhone]
					,[languageCode]
					,[startDate]
					,[endDate]
					,[managerId]
					,[hasOfflineMobileGroupId]
					,[orgName]
					)
				VALUES (
					S.[employeeId]
					,S.[userName]
					,S.[employeeOrganisationId]
					,S.[businessRoleTxt]
					,S.[employeestatus]
					,S.[employeename]
					,S.[employeeGender]
					,S.[employeeMaritalStatus]
					,S.[employeeEmail]
					,S.[employeeMobilePhone]
					,S.[employeeFixedPhone]
					,S.[languageCode]
					,S.[startDate]
					,S.[endDate]
					,S.[managerId]
					,S.[hasOfflineMobileGroupId]
					,S.[orgName]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [userName] = S.[userName]
					,[employeeOrganisationId] = S.[employeeOrganisationId]
					,[businessRoleTxt] = S.[businessRoleTxt]
					,[employeestatus] = S.[employeestatus]
					,[employeename] = S.[employeename]
					,[employeeGender] = S.[employeeGender]
					,[employeeMaritalStatus] = S.[employeeMaritalStatus]
					,[employeeEmail] = S.[employeeEmail]
					,[employeeMobilePhone] = S.[employeeMobilePhone]
					,[employeeFixedPhone] = S.[employeeFixedPhone]
					,[languageCode] = S.[languageCode]
					,[startDate] = S.[startDate]
					,[endDate] = S.[endDate]
					,[managerId] = S.[managerId]
					,[hasOfflineMobileGroupId] = S.[hasOfflineMobileGroupId]
					,[orgName] = S.[orgName]
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
			schema_name
			,table_name
			,last_run_ts
			,last_run_status
			,count
			,pipeline_name
			,run_id
			)
		VALUES (
			'dm'
			,'dim_nsc_employee'
			,CURRENT_TIMESTAMP
			,'SUCCESS'
			,@ROW
			,@pipeline_name
			,@run_id
			);
	END TRY

	BEGIN CATCH
		EXEC @ERROR_PROC @pipeline_name = @pipeline_name
			,@run_id = @run_id;

		INSERT INTO [AUDIT].[data_model_merge_log] (
			schema_name
			,table_name
			,last_run_ts
			,last_run_status
			,count
			,pipeline_name
			,run_id
			)
		VALUES (
			'dm'
			,'dim_nsc_employee'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO


