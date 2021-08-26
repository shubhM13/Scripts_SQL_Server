/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  StoredProcedure [dm].[usp_inc_merge_dim_interaction]    Script Date: 22/07/2021 4:01:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Name 		: dm.usp_inc_merge_dim_interaction
 Author     : Shubham Mishra
 Created On : 30, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
--drop procedure dm.usp_inc_merge_dim_interaction
CREATE PROCEDURE [dm].[usp_inc_merge_dim_interaction] (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_interaction AS D
		USING dm.view_inc_dim_interaction AS S
			ON (D.interactionId = S.interactionId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[interactionId]
					,[interactionType]
					,[interactionTypeTxt]
					,[interactionStatus]
					,[interactionStatusTxt]
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
					,[interactionOrgName]
					,[agronomistEmail]
					,[interaction_modifiedOn]
					,[interaction_modifiedOnKey]
					)
				VALUES (
					S.[interactionId]
					,S.[interactionType]
					,S.[interactionTypeTxt]
					,S.[interactionStatus]
					,S.[interactionStatusTxt]
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
					,S.[interactionOrgName]
					,S.[agronomistEmail]
					,S.[interaction_modifiedOn]
					,S.[interaction_modifiedOnKey]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [interactionType] = S.[interactionType]
					,[interactionTypeTxt] = S.[interactionTypeTxt]
					,[interactionStatus] = S.[interactionStatus]
					,[interactionStatusTxt] = S.[interactionStatusTxt]
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
					,[interactionOrgName] = S.[interactionOrgName]
					,[agronomistEmail] = S.[agronomistEmail]
					,[interaction_modifiedOn] = S.[interaction_modifiedOn]
					,[interaction_modifiedOnKey] = S.[interaction_modifiedOnKey]
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
			,'dim_interaction'
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
			,'dim_interaction'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO


