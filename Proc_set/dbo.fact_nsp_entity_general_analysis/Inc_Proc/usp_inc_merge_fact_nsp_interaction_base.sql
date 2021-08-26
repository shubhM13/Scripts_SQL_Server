/*******************************************
 Name 		: dm.usp_inc_merge_fact_nsp_interaction_base
 Author     : Shubham Mishra
 Created On : 21, Jul, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
--drop procedure dm.usp_inc_merge_fact_nsp_interaction_base
CREATE PROCEDURE dm.usp_inc_merge_fact_nsp_interaction_base (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.fact_nsp_interaction_base AS D
		USING dm.view_inc_fact_nsp_interaction_base AS S
			ON (D.interactionId = S.interactionId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[interactionId]
					,[interactionOrgName]
					,[interactionStatus]
					,[interactionType]
					,[interactionEntityId]
					,[interactionEmployeeId]
					,[interactionEventId]
					,[interactionPersonId]
					,[interactionTemplateId]
					,[interactionStartDate]
					,[startDateKey]
					,[interactionEndDate]
					,[endDateKey]
					,[interactionOrganisationId]
					,[agronomistEmail]
					,[interactionModifiedOn]
					,[interactionModifiedBy]
					)
				VALUES (
					S.[interactionId]
					,S.[interactionOrgName]
					,S.[interactionStatus]
					,S.[interactionType]
					,S.[interactionEntityId]
					,S.[interactionEmployeeId]
					,S.[interactionEventId]
					,S.[interactionPersonId]
					,S.[interactionTemplateId]
					,S.[interactionStartDate]
					,S.[startDateKey]
					,S.[interactionEndDate]
					,S.[endDateKey]
					,S.[interactionOrganisationId]
					,S.[agronomistEmail]
					,S.[interactionModifiedOn]
					,S.[interactionModifiedBy]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [interactionOrgName] = S.[interactionOrgName]
					,[interactionStatus] = S.[interactionStatus]
					,[interactionType] = S.[interactionType]
					,[interactionEntityId] = S.[interactionEntityId]
					,[interactionEmployeeId] = S.[interactionEmployeeId]
					,[interactionEventId] = S.[interactionEventId]
					,[interactionPersonId] = S.[interactionPersonId]
					,[interactionTemplateId] = S.[interactionTemplateId]
					,[interactionStartDate] = S.[interactionStartDate]
					,[startDateKey] = S.[startDateKey]
					,[interactionEndDate] = S.[interactionEndDate]
					,[endDateKey] = S.[endDateKey]
					,[interactionOrganisationId] = S.[interactionOrganisationId]
					,[agronomistEmail] = S.[agronomistEmail]
					,[interactionModifiedOn] = S.[interactionModifiedOn]
					,[interactionModifiedBy] = S.[interactionModifiedBy]
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
			,'fact_nsp_interaction_base'
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
			,'fact_nsp_interaction_base'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO