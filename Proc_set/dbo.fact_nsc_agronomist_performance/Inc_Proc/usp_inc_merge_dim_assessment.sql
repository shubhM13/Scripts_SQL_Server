/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  StoredProcedure [dm].[usp_inc_merge_dim_assessment]    Script Date: 22/07/2021 5:26:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Name 		: dm.usp_inc_merge_dim_assessment
 Author     : Shubham Mishra
 Created On : 01, Jul, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
--drop procedure dm.usp_inc_merge_dim_assessment
CREATE PROCEDURE [dm].[usp_inc_merge_dim_assessment] (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_assessment AS D
		USING dm.view_inc_dim_assessment AS S
			ON (D.assessmentId = S.assessmentId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[assessmentId]
					,[assessmentName]
					,[assessmentCreatedByOrgId]
					,[assessmentCreatedByOrgLob]
					,[assessmentApplyToAllGeoNodes]
					,[assessmentApplyToAllOrgs]
					,[assessmentApplyToAllSuppliers]
					,[assessmentApplyToAllPartners]
					,[assessmentApplyToAllCertPartners]
					)
				VALUES (
					S.[assessmentId]
					,S.[assessmentName]
					,S.[assessmentCreatedByOrgId]
					,S.[assessmentCreatedByOrgLob]
					,S.[assessmentApplyToAllGeoNodes]
					,S.[assessmentApplyToAllOrgs]
					,S.[assessmentApplyToAllSuppliers]
					,S.[assessmentApplyToAllPartners]
					,S.[assessmentApplyToAllCertPartners]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [assessmentName] = S.[assessmentName]
					,[assessmentCreatedByOrgId] = S.[assessmentCreatedByOrgId]
					,[assessmentCreatedByOrgLob] = S.[assessmentCreatedByOrgLob]
					,[assessmentApplyToAllGeoNodes] = S.[assessmentApplyToAllGeoNodes]
					,[assessmentApplyToAllOrgs] = S.[assessmentApplyToAllOrgs]
					,[assessmentApplyToAllSuppliers] = S.[assessmentApplyToAllSuppliers]
					,[assessmentApplyToAllPartners] = S.[assessmentApplyToAllPartners]
					,[assessmentApplyToAllCertPartners] = S.[assessmentApplyToAllCertPartners]
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
			,'dim_assessment'
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
			,'dim_assessment'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO


