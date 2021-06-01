/*******************************************
 Name 		: dm.usp_merge_dim_user
 Author     : Shubham Mishra
 Created On : 27, May, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
ALTER PROCEDURE dm.usp_merge_dim_user (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_user AS D
		USING dm.view_dim_user AS S
			ON (D.employeeId = S.employeeId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[userName]
					,[organisationId]
					,[orgName]
					,[lineOfBusiness]
					,[employeeId]
					,[employeeName]
					,[status]
					,[employeeEmail]
					,[gender]
					,[businessRole]
					,[country]
					)
				VALUES (
					S.[userName]
					,S.[organisationId]
					,S.[orgName]
					,S.[lineOfBusiness]
					,S.[employeeId]
					,S.[employeeName]
					,S.[status]
					,S.[employeeEmail]
					,S.[gender]
					,S.[businessRole]
					,S.[country]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [userName] = S.[userName]
					,[organisationId] = S.[organisationId]
					,[orgName] = S.[orgName]
					,[lineOfBusiness] = S.[lineOfBusiness]
					,[employeeName] = S.[employeeName]
					,[status] = S.[status]
					,[employeeEmail] = S.[employeeEmail]
					,[gender] = S.[gender]
					,[businessRole] = S.[businessRole]
					,[country] = S.[country]
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
			,'dim_user'
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
			,'dim_user'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO


EXEC dm.usp_merge_dim_user;
