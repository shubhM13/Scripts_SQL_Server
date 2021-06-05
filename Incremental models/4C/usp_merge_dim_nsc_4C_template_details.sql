/*******************************************
 Name 		: dm.usp_merge_dim_nsc_4C_template_details
 Author     : Shubham Mishra
 Created On : 04, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
ALTER PROCEDURE dm.usp_merge_dim_nsc_4C_template_details (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_nsc_4C_template_details AS D
		USING dm.view_dim_nsc_4C_template_details AS S
			ON (D.templateId = S.templateId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[criteriaId]
					,[criteriaId]
					,[templateId]
					,[templateId]
					,[checkPoint]
					,[checkPoint]
					,[principle]
					,[principle]
					,[criteria]
					,[criteria]
					,[verificationGuidance]
					,[verificationGuidance]
					,[templateTitle]
					,[templateTitle]
					,[templateDesc]
					,[templateDesc]
					,[templateStatus]
					,[templateStatus]
					,[templateType]
					,[templateType]
					,[sortOrder]
					,[sortOrder]
					,[sectionTitle]
					,[sectionTitle]
					,[sectionDesc]
					,[sectionDesc]
					)
				VALUES (
					S.[criteriaId]
					,S.[criteriaId]
					,S.[templateId]
					,S.[templateId]
					,S.[checkPoint]
					,S.[checkPoint]
					,S.[principle]
					,S.[principle]
					,S.[criteria]
					,S.[criteria]
					,S.[verificationGuidance]
					,S.[verificationGuidance]
					,S.[templateTitle]
					,S.[templateTitle]
					,S.[templateDesc]
					,S.[templateDesc]
					,S.[templateStatus]
					,S.[templateStatus]
					,S.[templateType]
					,S.[templateType]
					,S.[sortOrder]
					,S.[sortOrder]
					,S.[sectionTitle]
					,S.[sectionTitle]
					,S.[sectionDesc]
					,S.[sectionDesc]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [criteriaId] = S.[criteriaId]
					,[templateId] = S.[templateId]
					,[checkPoint] = S.[checkPoint]
					,[checkPoint] = S.[checkPoint]
					,[principle] = S.[principle]
					,[principle] = S.[principle]
					,[criteria] = S.[criteria]
					,[criteria] = S.[criteria]
					,[verificationGuidance] = S.[verificationGuidance]
					,[verificationGuidance] = S.[verificationGuidance]
					,[templateTitle] = S.[templateTitle]
					,[templateTitle] = S.[templateTitle]
					,[templateDesc] = S.[templateDesc]
					,[templateDesc] = S.[templateDesc]
					,[templateStatus] = S.[templateStatus]
					,[templateStatus] = S.[templateStatus]
					,[templateType] = S.[templateType]
					,[templateType] = S.[templateType]
					,[sortOrder] = S.[sortOrder]
					,[sortOrder] = S.[sortOrder]
					,[sectionTitle] = S.[sectionTitle]
					,[sectionTitle] = S.[sectionTitle]
					,[sectionDesc] = S.[sectionDesc]
					,[sectionDesc] = S.[sectionDesc]
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
			,'dim_nsc_4C_template_details'
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
			,'dim_nsc_4C_template_details'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO

