/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  StoredProcedure [dm].[usp_inc_merge_fact_nsp_assessment_analysis]    Script Date: 22/07/2021 5:24:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Name 		: dm.usp_inc_merge_fact_nsp_assessment_analysis
 Author     : Shubham Mishra
 Created On : 17, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
CREATE PROCEDURE [dm].[usp_inc_merge_fact_nsp_assessment_analysis] (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.fact_nsp_assessment_analysis AS D
		USING dm.view_inc_fact_nsp_assessment_analysis AS S
			ON (D.observationId = S.observationId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[interactionId]
					,[observationId]
					,[interactionStatus]
					,[interactionType]
					,[entityId]
					,[interactionOrganisationId]
					,[interactionOrgName]
					,[interactionEmployeeId]
					,[agronomistEmail]
					,[interactionTemplateId]
					,[interactionStartDate]
					,[startDateKey]
					,[obsDate]
					,[obsDateKey]
					,[observationCriteriaId]
					,[criteriaGroupCodes]
					,[criteriaTopicCodes]
					,[criteriaTopicCodeTxts]
					,[notApplicableFlag]
					,[answerType]
					,[answerDate]
					,[answerDateKey]
					,[answerDate2]
					,[answerDate2Key]
					,[answerNumber]
					,[answerText]
					,[answerCodeTxt]
					,[answerCodeScore]
					,[multiListAnswerCode]
					,[multiListAnswerCodeTxt]
					,[multiListAnswerCodeScore]
					,[unitOfMeasure]
					,[currencyCode]
					,[isLatest]
					,[isLatestByYear]
					)
				VALUES (
					S.[interactionId]
					,S.[observationId]
					,S.[interactionStatus]
					,S.[interactionType]
					,S.[entityId]
					,S.[interactionOrganisationId]
					,S.[interactionOrgName]
					,S.[interactionEmployeeId]
					,S.[agronomistEmail]
					,S.[interactionTemplateId]
					,S.[interactionStartDate]
					,S.[startDateKey]
					,S.[obsDate]
					,S.[obsDateKey]
					,S.[observationCriteriaId]
					,S.[criteriaGroupCodes]
					,S.[criteriaTopicCodes]
					,S.[criteriaTopicCodeTxts]
					,S.[notApplicableFlag]
					,S.[answerType]
					,S.[answerDate]
					,S.[answerDateKey]
					,S.[answerDate2]
					,S.[answerDate2Key]
					,S.[answerNumber]
					,S.[answerText]
					,S.[answerCodeTxt]
					,S.[answerCodeScore]
					,S.[multiListAnswerCode]
					,S.[multiListAnswerCodeTxt]
					,S.[multiListAnswerCodeScore]
					,S.[unitOfMeasure]
					,S.[currencyCode]
					,S.[isLatest]
					,S.[isLatestByYear]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [interactionId] = S.[interactionId]
					,[interactionStatus] = S.[interactionStatus]
					,[interactionType] = S.[interactionType]
					,[entityId] = S.[entityId]
					,[interactionOrganisationId] = S.[interactionOrganisationId]
					,[interactionOrgName] = S.[interactionOrgName]
					,[interactionEmployeeId] = S.[interactionEmployeeId]
					,[agronomistEmail] = S.[agronomistEmail]
					,[interactionTemplateId] = S.[interactionTemplateId]
					,[interactionStartDate] = S.[interactionStartDate]
					,[startDateKey] = S.[startDateKey]
					,[obsDate] = S.[obsDate]
					,[obsDateKey] = S.[obsDateKey]
					,[observationCriteriaId] = S.[observationCriteriaId]
					,[criteriaGroupCodes] = S.[criteriaGroupCodes]
					,[criteriaTopicCodes] = S.[criteriaTopicCodes]
					,[criteriaTopicCodeTxts] = S.[criteriaTopicCodeTxts]
					,[notApplicableFlag] = S.[notApplicableFlag]
					,[answerType] = S.[answerType]
					,[answerDate] = S.[answerDate]
					,[answerDateKey] = S.[answerDateKey]
					,[answerDate2] = S.[answerDate2]
					,[answerDate2Key] = S.[answerDate2Key]
					,[answerNumber] = S.[answerNumber]
					,[answerText] = S.[answerText]
					,[answerCodeTxt] = S.[answerCodeTxt]
					,[answerCodeScore] = S.[answerCodeScore]
					,[multiListAnswerCode] = S.[multiListAnswerCode]
					,[multiListAnswerCodeTxt] = S.[multiListAnswerCodeTxt]
					,[multiListAnswerCodeScore] = S.[multiListAnswerCodeScore]
					,[unitOfMeasure] = S.[unitOfMeasure]
					,[currencyCode] = S.[currencyCode]
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
			,'fact_nsp_assessment_analysis'
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
			,'fact_nsp_assessment_analysis'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO


