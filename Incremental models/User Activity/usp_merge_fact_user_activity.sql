/*******************************************
 Name 		: dm.usp_merge_fact_user_activity
 Author     : Shubham Mishra
 Created On : 22, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
--drop procedure dm.usp_merge_fact_user_activity
ALTER PROCEDURE dm.usp_merge_fact_user_activity (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.fact_user_activity AS D
		USING dm.view_fact_user_activity AS S
			ON (D.userName = S.userName
				AND D.year = S.year
				AND D.month = S.month)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[userName]
					,[employeeId]
					,[year]
					,[month]
					,[last_successful_connect_ts]
					,[last_successful_connect_dt]
					,[date_key]
					)
				VALUES (
					S.[userName]
					,S.[employeeId]
					,S.[year]
					,S.[month]
					,S.[last_successful_connect_ts]
					,S.[last_successful_connect_dt]
					,S.[date_key]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [userName] = S.[userName]
					,[employeeId] = S.[employeeId]
					,[year] = S.[year]
					,[month] = S.[month]
					,[last_successful_connect_ts] = S.[last_successful_connect_ts]
					,[last_successful_connect_dt] = S.[last_successful_connect_dt]
					,[date_key] = S.[date_key]
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
			,'fact_user_activity'
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
			,'fact_user_activity'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO

EXEC dm.usp_merge_fact_user_activity;

