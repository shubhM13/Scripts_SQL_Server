/*******************************************
 Name 		: dm.usp_inc_merge_fact_nsc_event_analysis
 Author     : Shubham Mishra
 Created On : 20, Jul, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
--drop procedure dm.usp_inc_merge_fact_nsc_event_analysis
CREATE PROCEDURE dm.usp_inc_merge_fact_nsc_event_analysis (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.fact_nsc_event_analysis AS D
		USING dm.view_inc_fact_nsc_event_analysis AS S
			ON (D.eventId = S.eventId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[eventId]
					,[employeeId]
					,[eventStartDate]
					,[eventStartDateKey]
					,[eventEndDate]
					,[eventEndDateKey]
					)
				VALUES (
					S.[eventId]
					,S.[employeeId]
					,S.[eventStartDate]
					,S.[eventStartDateKey]
					,S.[eventEndDate]
					,S.[eventEndDateKey]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [eventId] = S.[eventId]
					,[employeeId] = S.[employeeId]
					,[eventStartDate] = S.[eventStartDate]
					,[eventStartDateKey] = S.[eventStartDateKey]
					,[eventEndDate] = S.[eventEndDate]
					,[eventEndDateKey] = S.[eventEndDateKey]
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
			,'fact_nsc_event_analysis'
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
			,'fact_nsc_event_analysis'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO