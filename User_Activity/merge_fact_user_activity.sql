/*******************************************
 Name        : [dm].[usp_merge_fact_user_activity]
 Author     : Shubham Mishra
 Created On : 29th April
 PURPOSE    : User Activity History Model
 *******************************************/
--drop procedure [dm].[usp_merge_fact_user_activity]
CREATE PROCEDURE [dm].[usp_merge_fact_user_activity]
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
	DECLARE @ROW INT;

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.fact_user_activity AS D
		USING dm.view_user_activity AS S
			ON (D.[userName] = S.[userName])
				AND (D.[last_successful_connect_ts] = S.[last_successful_connect_ts])
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[userName]
					,[employeeId]
					,[last_successful_connect_ts]
					,[last_successful_connect_dt]
					,[date_key]
					)
				VALUES (
					S.[userName]
					,S.[employeeId]
					,S.[last_successful_connect_ts]
					,S.[last_successful_connect_dt]
					,S.[date_key]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [employeeId] = S.[employeeId]
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
			)
		VALUES (
			'dm'
			,'fact_user_activity'
			,CURRENT_TIMESTAMP
			,'Completed'
			,@ROW
			);
	END TRY

	BEGIN CATCH
		EXEC (@ERROR_PROC);

		INSERT INTO [AUDIT].[data_model_merge_log] (
			schema_name
			,table_name
			,last_run_ts
			,last_run_status
			,count
			)
		VALUES (
			'dm'
			,'fact_user_activity'
			,CURRENT_TIMESTAMP
			,'Faied'
			,NULL
			);
	END CATCH
END
GO

-- EXEC [dm].[usp_merge_fact_user_activity];
SELECT *
FROM [AUDIT].[data_model_merge_log];