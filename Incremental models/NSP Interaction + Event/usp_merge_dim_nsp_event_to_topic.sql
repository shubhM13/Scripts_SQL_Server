/*******************************************
 Name 		: dm.usp_merge_dim_nsp_event_to_topic
 Author     : Shubham Mishra
 Created On : 30, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
--drop procedure dm.usp_merge_dim_nsp_event_to_topic
ALTER PROCEDURE dm.usp_merge_dim_nsp_event_to_topic (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_nsp_event_to_topic AS D
		USING dm.view_dim_nsp_event_to_topic AS S
			ON (D.topicName = S.topicName)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[eventId]
					,[topicName]
					)
				VALUES (
					S.[eventId]
					,S.[topicName]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [eventId] = S.[eventId]
					,[topicName] = S.[topicName]
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
			,'dim_nsp_event_to_topic'
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
			,'dim_nsp_event_to_topic'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO

