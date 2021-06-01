/*******************************************
 Name 		: dm.usp_merge_dim_criteria
 Author     : Shubham Mishra
 Created On : 01, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
CREATE PROCEDURE dm.usp_merge_dim_criteria (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_criteria AS D
		USING dm.view_dim_criteria AS S
			ON (D.criteriaId = S.criteriaId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[criteriaId]
					,[criteriaCode]
					,[criteriaStatus]
					,[criteriaClassification1]
					,[criteriaClassification2]
					,[criteriaClassification3]
					,[criteriaComplianceFlag]
					,[criteriaAnswerType]
					,[criteriaTitle]
					,[criteriaShortDescription]
					,[criteriaLongDescription]
					,[criteriaAnswerTypeTxt]
					,[classification1Txt]
					,[classification2Txt]
					,[classification3Txt]
					)
				VALUES (
					S.[criteriaId]
					,S.[criteriaCode]
					,S.[criteriaStatus]
					,S.[criteriaClassification1]
					,S.[criteriaClassification2]
					,S.[criteriaClassification3]
					,S.[criteriaComplianceFlag]
					,S.[criteriaAnswerType]
					,S.[criteriaTitle]
					,S.[criteriaShortDescription]
					,S.[criteriaLongDescription]
					,S.[criteriaAnswerTypeTxt]
					,S.[classification1Txt]
					,S.[classification2Txt]
					,S.[classification3Txt]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [criteriaCode] = S.[criteriaCode]
					,[criteriaStatus] = S.[criteriaStatus]
					,[criteriaClassification1] = S.[criteriaClassification1]
					,[criteriaClassification2] = S.[criteriaClassification2]
					,[criteriaClassification3] = S.[criteriaClassification3]
					,[criteriaComplianceFlag] = S.[criteriaComplianceFlag]
					,[criteriaAnswerType] = S.[criteriaAnswerType]
					,[criteriaTitle] = S.[criteriaTitle]
					,[criteriaShortDescription] = S.[criteriaShortDescription]
					,[criteriaLongDescription] = S.[criteriaLongDescription]
					,[criteriaAnswerTypeTxt] = S.[criteriaAnswerTypeTxt]
					,[classification1Txt] = S.[classification1Txt]
					,[classification2Txt] = S.[classification2Txt]
					,[classification3Txt] = S.[classification3Txt]
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
			,'dim_criteria'
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
			,'dim_criteria'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO

EXEC dm.usp_merge_dim_criteria;
select * from [AUDIT].[data_model_merge_log];
