/*******************************************
 Name 		: dm.usp_inc_merge_dim_template
 Author     : Shubham Mishra
 Created On : 21, Jul, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
--drop procedure dm.usp_inc_merge_dim_template
CREATE PROCEDURE dm.usp_inc_merge_dim_template (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_template AS D
		USING dm.view_inc_dim_template AS S
			ON (D.templateId = S.templateId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[templateId]
					,[templateStatus]
					,[templateType]
					,[templateApplyToAllGeoNodes]
					,[templateApplyToAllOrgs]
					,[templateActivityType]
					,[templateApplyToAllSuppliers]
					,[templateApplyToAllPartners]
					,[templateApplyToAllCertPartners]
					,[templateOrganisationId]
					,[templateTitle]
					,[templateDescription]
					,[templateTypeTxt]
					,[activityTypeTxt]
					,[templateStatusTxt]
					)
				VALUES (
					S.[templateId]
					,S.[templateStatus]
					,S.[templateType]
					,S.[templateApplyToAllGeoNodes]
					,S.[templateApplyToAllOrgs]
					,S.[templateActivityType]
					,S.[templateApplyToAllSuppliers]
					,S.[templateApplyToAllPartners]
					,S.[templateApplyToAllCertPartners]
					,S.[templateOrganisationId]
					,S.[templateTitle]
					,S.[templateDescription]
					,S.[templateTypeTxt]
					,S.[activityTypeTxt]
					,S.[templateStatusTxt]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [templateStatus] = S.[templateStatus]
					,[templateType] = S.[templateType]
					,[templateApplyToAllGeoNodes] = S.[templateApplyToAllGeoNodes]
					,[templateApplyToAllOrgs] = S.[templateApplyToAllOrgs]
					,[templateActivityType] = S.[templateActivityType]
					,[templateApplyToAllSuppliers] = S.[templateApplyToAllSuppliers]
					,[templateApplyToAllPartners] = S.[templateApplyToAllPartners]
					,[templateApplyToAllCertPartners] = S.[templateApplyToAllCertPartners]
					,[templateOrganisationId] = S.[templateOrganisationId]
					,[templateTitle] = S.[templateTitle]
					,[templateDescription] = S.[templateDescription]
					,[templateTypeTxt] = S.[templateTypeTxt]
					,[activityTypeTxt] = S.[activityTypeTxt]
					,[templateStatusTxt] = S.[templateStatusTxt]
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
			,'dim_template'
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
			,'dim_template'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO