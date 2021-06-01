/*******************************************
 Name 		: dm.usp_merge_fact_nsc_adoption
 Author     : Shubham Mishra
 Created On : 01, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
CREATE PROCEDURE dm.usp_merge_fact_nsc_adoption (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.fact_nsc_adoption AS D
		USING dm.view_fact_nsc_adoption AS S
			ON (D.observationId = S.observationId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[interactionId]
					,[interactionStartDate]
					,[startDateKey]
					,[orgName]
					,[employee_name]
					,[agronomistEmail]
					,[observationId]
					,[obsDate]
					,[obsDateKey]
					,[entityId]
					,[geoNodeId]
					,[criteriaId]
					,[criteriaTopicCodes]
					,[criteriaTopicCodeTxts]
					,[answerType]
					,[answerCode]
					,[answerCodeTxt]
					,[answerCodeScore]
					,[answerNumber]
					,[unitOfMeasure]
					,[isLatest]
					,[isLatestByYear]
					)
				VALUES (
					S.[interactionId]
					,S.[interactionStartDate]
					,S.[startDateKey]
					,S.[orgName]
					,S.[employee_name]
					,S.[agronomistEmail]
					,S.[observationId]
					,S.[obsDate]
					,S.[obsDateKey]
					,S.[entityId]
					,S.[geoNodeId]
					,S.[criteriaId]
					,S.[criteriaTopicCodes]
					,S.[criteriaTopicCodeTxts]
					,S.[answerType]
					,S.[answerCode]
					,S.[answerCodeTxt]
					,S.[answerCodeScore]
					,S.[answerNumber]
					,S.[unitOfMeasure]
					,S.[isLatest]
					,S.[isLatestByYear]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [interactionId] = S.[interactionId]
					,[interactionStartDate] = S.[interactionStartDate]
					,[startDateKey] = S.[startDateKey]
					,[orgName] = S.[orgName]
					,[employee_name] = S.[employee_name]
					,[agronomistEmail] = S.[agronomistEmail]
					,[observationId] = S.[observationId]
					,[obsDate] = S.[obsDate]
					,[obsDateKey] = S.[obsDateKey]
					,[entityId] = S.[entityId]
					,[geoNodeId] = S.[geoNodeId]
					,[criteriaId] = S.[criteriaId]
					,[criteriaTopicCodes] = S.[criteriaTopicCodes]
					,[criteriaTopicCodeTxts] = S.[criteriaTopicCodeTxts]
					,[answerType] = S.[answerType]
					,[answerCode] = S.[answerCode]
					,[answerCodeTxt] = S.[answerCodeTxt]
					,[answerCodeScore] = S.[answerCodeScore]
					,[answerNumber] = S.[answerNumber]
					,[unitOfMeasure] = S.[unitOfMeasure]
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
			,'fact_nsc_adoption'
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
			,'fact_nsc_adoption'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO

EXEC dm.usp_merge_fact_nsc_adoption;
select * from [AUDIT].[data_model_merge_log];