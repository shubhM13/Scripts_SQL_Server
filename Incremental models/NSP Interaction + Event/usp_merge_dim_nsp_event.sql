/*******************************************
 Name 		: dm.usp_merge_dim_nsp_event
 Author     : Shubham Mishra
 Created On : 28, Jul, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
--drop procedure dm.usp_merge_dim_nsp_event
CREATE PROCEDURE dm.usp_merge_dim_nsp_event (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_nsp_event AS D
		USING dm.view_dim_nsp_event AS S
			ON (D.eventId = S.eventId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[eventId]
					,[eventExternalId]
					,[eventName]
					,[interactionStatus]
					,[eventStatus]
					,[eventType]
					,[trainingFeedbackTaken]
					,[eventOrgName]
					,[eventStartDate]
					,[eventEndDate]
					,[eventLocation]
					,[employeeCount]
					,[employeeNames]
					,[employeeEmails]
					,[attendanceTaken]
					,[attendedPersonCount]
					,[topicCounts]
					)
				VALUES (
					S.[eventId]
					,S.[eventExternalId]
					,S.[eventName]
					,S.[interactionStatus]
					,S.[eventStatus]
					,S.[eventType]
					,S.[trainingFeedbackTaken]
					,S.[eventOrgName]
					,S.[eventStartDate]
					,S.[eventEndDate]
					,S.[eventLocation]
					,S.[employeeCount]
					,S.[employeeNames]
					,S.[employeeEmails]
					,S.[attendanceTaken]
					,S.[attendedPersonCount]
					,S.[topicCounts]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [eventExternalId] = S.[eventExternalId]
					,[eventName] = S.[eventName]
					,[interactionStatus] = S.[interactionStatus]
					,[eventStatus] = S.[eventStatus]
					,[eventType] = S.[eventType]
					,[trainingFeedbackTaken] = S.[trainingFeedbackTaken]
					,[eventOrgName] = S.[eventOrgName]
					,[eventStartDate] = S.[eventStartDate]
					,[eventEndDate] = S.[eventEndDate]
					,[eventLocation] = S.[eventLocation]
					,[employeeCount] = S.[employeeCount]
					,[employeeNames] = S.[employeeNames]
					,[employeeEmails] = S.[employeeEmails]
					,[attendanceTaken] = S.[attendanceTaken]
					,[attendedPersonCount] = S.[attendedPersonCount]
					,[topicCounts] = S.[topicCounts]
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
			,'dim_nsp_event'
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
			,'dim_nsp_event'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO

