/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  StoredProcedure [dm].[usp_inc_merge_fact_nsc_plantlet_assessment]    Script Date: 22/07/2021 5:20:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Name 		: dm.usp_inc_merge_fact_nsc_plantlet_assessment
 Author     : Shubham Mishra
 Created On : 09, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
CREATE PROCEDURE [dm].[usp_inc_merge_fact_nsc_plantlet_assessment] (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.fact_nsc_plantlet_assessment AS D
		USING dm.view_inc_fact_nsc_plantlet_assessment AS S
			ON (D.observationId = S.observationId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[observationId]
					,[status]
					,[type]
					,[obsDateTime]
					,[entityId]
					,[criteriaId]
					,[interactionId]
					,[parentObservationId]
					,[notApplicableFlag]
					,[riskyFlag]
					,[answerType]
					,[answerDate]
					,[answerDate2]
					,[answerText]
					,[answerNumber]
					,[unitOfMeasure]
					,[currencyCode]
					,[answerCode]
					,[isLatest]
					,[isLatestByYear]
					,[geoNodeId]
					,[auditInfo.createdBy]
					,[auditInfo.createdOn]
					,[auditInfo.modifiedBy]
					,[auditInfo.modifiedOn]
					,[auditInfo.requestedBy]
					,[auditInfo.modifiedReasonCode]
					,[auditInfo.channel]
					)
				VALUES (
					S.[observationId]
					,S.[status]
					,S.[type]
					,S.[obsDateTime]
					,S.[entityId]
					,S.[criteriaId]
					,S.[interactionId]
					,S.[parentObservationId]
					,S.[notApplicableFlag]
					,S.[riskyFlag]
					,S.[answerType]
					,S.[answerDate]
					,S.[answerDate2]
					,S.[answerText]
					,S.[answerNumber]
					,S.[unitOfMeasure]
					,S.[currencyCode]
					,S.[answerCode]
					,S.[isLatest]
					,S.[isLatestByYear]
					,S.[geoNodeId]
					,S.[auditInfo.createdBy]
					,S.[auditInfo.createdOn]
					,S.[auditInfo.modifiedBy]
					,S.[auditInfo.modifiedOn]
					,S.[auditInfo.requestedBy]
					,S.[auditInfo.modifiedReasonCode]
					,S.[auditInfo.channel]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [status] = S.[status]
					,[type] = S.[type]
					,[obsDateTime] = S.[obsDateTime]
					,[entityId] = S.[entityId]
					,[criteriaId] = S.[criteriaId]
					,[interactionId] = S.[interactionId]
					,[parentObservationId] = S.[parentObservationId]
					,[notApplicableFlag] = S.[notApplicableFlag]
					,[riskyFlag] = S.[riskyFlag]
					,[answerType] = S.[answerType]
					,[answerDate] = S.[answerDate]
					,[answerDate2] = S.[answerDate2]
					,[answerText] = S.[answerText]
					,[answerNumber] = S.[answerNumber]
					,[unitOfMeasure] = S.[unitOfMeasure]
					,[currencyCode] = S.[currencyCode]
					,[answerCode] = S.[answerCode]
					,[isLatest] = S.[isLatest]
					,[isLatestByYear] = S.[isLatestByYear]
					,[geoNodeId] = S.[geoNodeId]
					,[auditInfo.createdBy] = S.[auditInfo.createdBy]
					,[auditInfo.createdOn] = S.[auditInfo.createdOn]
					,[auditInfo.modifiedBy] = S.[auditInfo.modifiedBy]
					,[auditInfo.modifiedOn] = S.[auditInfo.modifiedOn]
					,[auditInfo.requestedBy] = S.[auditInfo.requestedBy]
					,[auditInfo.modifiedReasonCode] = S.[auditInfo.modifiedReasonCode]
					,[auditInfo.channel] = S.[auditInfo.channel]
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
			,'fact_nsc_plantlet_assessment'
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
			,'fact_nsc_plantlet_assessment'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO


