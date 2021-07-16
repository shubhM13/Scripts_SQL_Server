/*******************************************
 Name 		: dm.usp_merge_bridge_nsp_criteria_to_topic
 Author     : Shubham Mishra
 Created On : 29, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
--drop procedure dm.usp_merge_bridge_nsp_criteria_to_topic
CREATE PROCEDURE dm.usp_merge_bridge_nsp_criteria_to_topic (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.bridge_nsp_criteria_to_topic AS D
		USING dm.view_bridge_nsp_criteria_to_topic AS S
			ON (
					D.criteriaId = S.criteriaId
					AND D.topicCode = S.topicCode
					)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[criteriaId]
					,[topicCode]
					,[topicTxt]
					)
				VALUES (
					S.[criteriaId]
					,S.[topicCode]
					,S.[topicTxt]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [criteriaId] = S.[criteriaId]
					,[topicCode] = S.[topicCode]
					,[topicTxt] = S.[topicTxt]
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
			,'bridge_nsp_criteria_to_topic'
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
			,'bridge_nsp_criteria_to_topic'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO

EXEC dm.usp_merge_bridge_nsp_criteria_to_topic;

