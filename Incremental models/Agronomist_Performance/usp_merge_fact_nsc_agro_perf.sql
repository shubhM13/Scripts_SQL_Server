/*******************************************
 Name 		: dm.usp_merge_dim_fact_nsc_agronomist_performance
 Author     : Shubham Mishra
 Created On : 01, Jul, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
--drop procedure dm.usp_merge_dim_fact_nsc_agronomist_performance
ALTER PROCEDURE dm.usp_merge_dim_fact_nsc_agronomist_performance (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_fact_nsc_agronomist_performance AS D
		USING dm.view_fact_nsc_agronomist_performance AS S
			ON (D.interactionId = S.interactionId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[interactionId]
					,[interactionOrgName]
					,[interactionEntityId]
					,[interactionEmployeeId]
					,[interactionTemplateId]
					,[interactionStartDate]
					,[startDateKey]
					,[interactionEndDate]
					,[endDateKey]
					)
				VALUES (
					S.[interactionId]
					,S.[interactionOrgName]
					,S.[interactionEntityId]
					,S.[interactionEmployeeId]
					,S.[interactionTemplateId]
					,S.[interactionStartDate]
					,S.[startDateKey]
					,S.[interactionEndDate]
					,S.[endDateKey]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [interactionOrgName] = S.[interactionOrgName]
					,[interactionEntityId] = S.[interactionEntityId]
					,[interactionEmployeeId] = S.[interactionEmployeeId]
					,[interactionTemplateId] = S.[interactionTemplateId]
					,[interactionStartDate] = S.[interactionStartDate]
					,[startDateKey] = S.[startDateKey]
					,[interactionEndDate] = S.[interactionEndDate]
					,[endDateKey] = S.[endDateKey]
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
			,'dim_fact_nsc_agronomist_performance'
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
			,'dim_fact_nsc_agronomist_performance'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO

