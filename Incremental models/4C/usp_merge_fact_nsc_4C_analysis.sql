/*******************************************
 Name 		: dm.usp_merge_fact_nsc_4C_analysis
 Author     : Shubham Mishra
 Created On : 04, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
ALTER PROCEDURE dm.usp_merge_fact_nsc_4C_analysis (@pipeline_name AS VARCHAR(100) = NULL, @run_id AS VARCHAR(100) = NULL)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000), @ROW INT
	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'
	BEGIN TRY
		MERGE dm.fact_nsc_4C_analysis AS D
		USING dm.view_fact_nsc_4C_analysis AS S
			ON (D.observationId = S.observationId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT ([interactionId],[interactionType],[interactionEmployeeId],[agronomistEmail],[interactionTemplateId],[interactionStartDate],[startDateKey],[interactionOrganisationId],[interactionOrgName],[interaction_modifiedOn],[interaction_modifiedOnKey],[observationId],[obsDate],[obsDateKey],[entityId],[geoNodeId],[observationCriteriaId],[notApplicableFlag],[answerType],[answerCode],[answerCodeTxt],[answerCodeScore],[isLatest],[isLatestByYear])
				VALUES (S.[interactionId],S.[interactionType],S.[interactionEmployeeId],S.[agronomistEmail],S.[interactionTemplateId],S.[interactionStartDate],S.[startDateKey],S.[interactionOrganisationId],S.[interactionOrgName],S.[interaction_modifiedOn],S.[interaction_modifiedOnKey],S.[observationId],S.[obsDate],S.[obsDateKey],S.[entityId],S.[geoNodeId],S.[observationCriteriaId],S.[notApplicableFlag],S.[answerType],S.[answerCode],S.[answerCodeTxt],S.[answerCodeScore],S.[isLatest],S.[isLatestByYear])
		WHEN MATCHED
			THEN
				UPDATE
				SET [interactionId] = S.[interactionId]
,[interactionType] = S.[interactionType]
,[interactionEmployeeId] = S.[interactionEmployeeId]
,[agronomistEmail] = S.[agronomistEmail]
,[interactionTemplateId] = S.[interactionTemplateId]
,[interactionStartDate] = S.[interactionStartDate]
,[startDateKey] = S.[startDateKey]
,[interactionOrganisationId] = S.[interactionOrganisationId]
,[interactionOrgName] = S.[interactionOrgName]
,[interaction_modifiedOn] = S.[interaction_modifiedOn]
,[interaction_modifiedOnKey] = S.[interaction_modifiedOnKey]
,[obsDate] = S.[obsDate]
,[obsDateKey] = S.[obsDateKey]
,[entityId] = S.[entityId]
,[geoNodeId] = S.[geoNodeId]
,[observationCriteriaId] = S.[observationCriteriaId]
,[notApplicableFlag] = S.[notApplicableFlag]
,[answerType] = S.[answerType]
,[answerCode] = S.[answerCode]
,[answerCodeTxt] = S.[answerCodeTxt]
,[answerCodeScore] = S.[answerCodeScore]
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
			schema_name, table_name ,last_run_ts ,last_run_status, count, pipeline_name, run_id
			)
		VALUES (
			'dm', 'fact_nsc_4C_analysis', CURRENT_TIMESTAMP, 'SUCCESS', @ROW, @pipeline_name, @run_id
			);
	END TRY
	BEGIN CATCH
		EXEC @ERROR_PROC @pipeline_name = @pipeline_name
			,@run_id = @run_id;
		INSERT INTO [AUDIT].[data_model_merge_log] (
			schema_name, table_name ,last_run_ts ,last_run_status, count, pipeline_name, run_id
			)
		VALUES (
			'dm', 'fact_nsc_4C_analysis', CURRENT_TIMESTAMP, 'FAIL', NULL, @pipeline_name, @run_id
			);
	END CATCH
END 
GO
