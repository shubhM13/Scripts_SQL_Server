/*******************************************
 Name 		: dm.usp_inc_merge_dim_observation
 Author     : Shubham Mishra
 Created On : 21, Jul, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
--drop procedure dm.usp_inc_merge_dim_observation
CREATE PROCEDURE dm.usp_inc_merge_dim_observation (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_observation AS D
		USING dm.view_inc_dim_observation AS S
			ON (D.observationId = S.observationId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[observationId]
					,[obsDate]
					,[obsDateKey]
					,[observationEntityId]
					,[observationCriteriaId]
					,[interactionId]
					,[notApplicableFlag]
					,[answerType]
					,[answerDate]
					,[answerDateKey]
					,[answerDate2]
					,[answerDate2Key]
					,[answerNumber]
					,[answerText]
					,[answerCode]
					,[answerCodeTxt]
					,[answerCodeScore]
					,[multiListAnswerCode]
					,[multiListAnswerCodeTxt]
					,[multiListAnswerCodeScore]
					,[unitOfMeasure]
					,[unitOfMeasureTxt]
					,[currencyCode]
					,[currencyCodeTxt]
					,[isLatest]
					,[isLatestByYear]
					)
				VALUES (
					S.[observationId]
					,S.[obsDate]
					,S.[obsDateKey]
					,S.[observationEntityId]
					,S.[observationCriteriaId]
					,S.[interactionId]
					,S.[notApplicableFlag]
					,S.[answerType]
					,S.[answerDate]
					,S.[answerDateKey]
					,S.[answerDate2]
					,S.[answerDate2Key]
					,S.[answerNumber]
					,S.[answerText]
					,S.[answerCode]
					,S.[answerCodeTxt]
					,S.[answerCodeScore]
					,S.[multiListAnswerCode]
					,S.[multiListAnswerCodeTxt]
					,S.[multiListAnswerCodeScore]
					,S.[unitOfMeasure]
					,S.[unitOfMeasureTxt]
					,S.[currencyCode]
					,S.[currencyCodeTxt]
					,S.[isLatest]
					,S.[isLatestByYear]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [obsDate] = S.[obsDate]
					,[obsDateKey] = S.[obsDateKey]
					,[observationEntityId] = S.[observationEntityId]
					,[observationCriteriaId] = S.[observationCriteriaId]
					,[interactionId] = S.[interactionId]
					,[notApplicableFlag] = S.[notApplicableFlag]
					,[answerType] = S.[answerType]
					,[answerDate] = S.[answerDate]
					,[answerDateKey] = S.[answerDateKey]
					,[answerDate2] = S.[answerDate2]
					,[answerDate2Key] = S.[answerDate2Key]
					,[answerNumber] = S.[answerNumber]
					,[answerText] = S.[answerText]
					,[answerCode] = S.[answerCode]
					,[answerCodeTxt] = S.[answerCodeTxt]
					,[answerCodeScore] = S.[answerCodeScore]
					,[multiListAnswerCode] = S.[multiListAnswerCode]
					,[multiListAnswerCodeTxt] = S.[multiListAnswerCodeTxt]
					,[multiListAnswerCodeScore] = S.[multiListAnswerCodeScore]
					,[unitOfMeasure] = S.[unitOfMeasure]
					,[unitOfMeasureTxt] = S.[unitOfMeasureTxt]
					,[currencyCode] = S.[currencyCode]
					,[currencyCodeTxt] = S.[currencyCodeTxt]
					,[isLatest] = S.[isLatest]
					,[isLatestByYear] = S.[isLatestByYear]
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
			,'dim_observation'
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
			,'dim_observation'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO