/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  StoredProcedure [dm].[usp_inc_merge_dim_nsp_event]    Script Date: 22/07/2021 5:07:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Name 		: dm.usp_inc_merge_dim_nsp_event
 Author     : Shubham Mishra
 Created On : 02, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
CREATE PROCEDURE [dm].[usp_inc_merge_dim_nsp_event] (
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
		USING dm.view_inc_dim_nsp_event AS S
			ON (D.eventId = S.eventId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[eventId]
					,[eventExternalId]
					,[eventName]
					,[interactionStatus]
					,[eventStatus]
					,[interactionType]
					,[eventType]
					,[trainingFeedbackTaken]
					,[eventOrgName]
					,[eventDescription]
					,[eventStartDate]
					,[eventEndDate]
					,[eventLocation]
					,[employeeCount]
					,[employeeNames]
					,[employeeEmails]
					,[attendanceTaken]
					,[attendedPersonCount]
					,[attendees]
					,[topicCounts]
					,[topics]
					)
				VALUES (
					S.[eventId]
					,S.[eventExternalId]
					,S.[eventName]
					,S.[interactionStatus]
					,S.[eventStatus]
					,S.[interactionType]
					,S.[eventType]
					,S.[trainingFeedbackTaken]
					,S.[eventOrgName]
					,S.[eventDescription]
					,S.[eventStartDate]
					,S.[eventEndDate]
					,S.[eventLocation]
					,S.[employeeCount]
					,S.[employeeNames]
					,S.[employeeEmails]
					,S.[attendanceTaken]
					,S.[attendedPersonCount]
					,S.[attendees]
					,S.[topicCounts]
					,S.[topics]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [eventExternalId] = S.[eventExternalId]
					,[eventName] = S.[eventName]
					,[interactionStatus] = S.[interactionStatus]
					,[eventStatus] = S.[eventStatus]
					,[interactionType] = S.[interactionType]
					,[eventType] = S.[eventType]
					,[trainingFeedbackTaken] = S.[trainingFeedbackTaken]
					,[eventOrgName] = S.[eventOrgName]
					,[eventDescription] = S.[eventDescription]
					,[eventStartDate] = S.[eventStartDate]
					,[eventEndDate] = S.[eventEndDate]
					,[eventLocation] = S.[eventLocation]
					,[employeeCount] = S.[employeeCount]
					,[employeeNames] = S.[employeeNames]
					,[employeeEmails] = S.[employeeEmails]
					,[attendanceTaken] = S.[attendanceTaken]
					,[attendedPersonCount] = S.[attendedPersonCount]
					,[attendees] = S.[attendees]
					,[topicCounts] = S.[topicCounts]
					,[topics] = S.[topics]
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


