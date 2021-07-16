/*******************************************
 Name 		: dm.usp_merge_dim_nsp_template
 Author     : Shubham Mishra
 Created On : 17, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
ALTER PROCEDURE dm.usp_merge_dim_nsp_template (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_nsp_template AS D
		USING dm.view_dim_nsp_template AS S
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
					,[organisationId]
					,[templateTitle]
					,[templateDescription]
					,[lineOfBusiness]
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
					,S.[organisationId]
					,S.[templateTitle]
					,S.[templateDescription]
					,S.[lineOfBusiness]
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
					,[organisationId] = S.[organisationId]
					,[templateTitle] = S.[templateTitle]
					,[templateDescription] = S.[templateDescription]
					,[lineOfBusiness] = S.[lineOfBusiness]
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
			,'dim_nsp_template'
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
			,'dim_nsp_template'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO



EXEC dm.usp_merge_dim_nsp_template;
