/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  StoredProcedure [dm].[usp_inc_merge_dim_nsc_entity_master]    Script Date: 22/07/2021 4:59:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Name 		: dm.usp_inc_merge_dim_nsc_entity_master
 Author     : Shubham Mishra
 Created On : 08, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
CREATE PROCEDURE [dm].[usp_inc_merge_dim_nsc_entity_master] (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_nsc_entity_master AS D
		USING dm.view_inc_dim_nsc_entity_master AS S
			ON (D.entityId = S.entityId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[entityId]
					,[externalSystemId]
					,[entityType]
					,[entityTypeTxt]
					,[entityStatus]
					,[entityStatusTxt]
					,[entityName]
					,[longX]
					,[latY]
					,[altZ]
					,[nestleOwned]
					,[ownershipType]
					,[ownershipTypeTxt]
					,[foundationYear]
					,[relationshipDateKey]
					,[relationshipDate]
					,[nurseryOnSite]
					,[millOnSite]
					,[isPartOfAgripreneurship]
					,[locationVerified]
					,[isValidCoordinates]
					,[status4C]
					,[status4CTxt]
					,[AAAEntryYear]
					,[AAAEnrolmentDateKey]
					,[AAAEnrolmentDate]
					,[AAAStatus]
					,[AAAStatusTxt]
					,[license4C]
					,[unit4C]
					,[subcluster_name]
					,[cluster_name]
					,[country_name]
					)
				VALUES (
					S.[entityId]
					,S.[externalSystemId]
					,S.[entityType]
					,S.[entityTypeTxt]
					,S.[entityStatus]
					,S.[entityStatusTxt]
					,S.[entityName]
					,S.[longX]
					,S.[latY]
					,S.[altZ]
					,S.[nestleOwned]
					,S.[ownershipType]
					,S.[ownershipTypeTxt]
					,S.[foundationYear]
					,S.[relationshipDateKey]
					,S.[relationshipDate]
					,S.[nurseryOnSite]
					,S.[millOnSite]
					,S.[isPartOfAgripreneurship]
					,S.[locationVerified]
					,S.[isValidCoordinates]
					,S.[status4C]
					,S.[status4CTxt]
					,S.[AAAEntryYear]
					,S.[AAAEnrolmentDateKey]
					,S.[AAAEnrolmentDate]
					,S.[AAAStatus]
					,S.[AAAStatusTxt]
					,S.[license4C]
					,S.[unit4C]
					,S.[subcluster_name]
					,S.[cluster_name]
					,S.[country_name]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [externalSystemId] = S.[externalSystemId]
					,[entityType] = S.[entityType]
					,[entityTypeTxt] = S.[entityTypeTxt]
					,[entityStatus] = S.[entityStatus]
					,[entityStatusTxt] = S.[entityStatusTxt]
					,[entityName] = S.[entityName]
					,[longX] = S.[longX]
					,[latY] = S.[latY]
					,[altZ] = S.[altZ]
					,[nestleOwned] = S.[nestleOwned]
					,[ownershipType] = S.[ownershipType]
					,[ownershipTypeTxt] = S.[ownershipTypeTxt]
					,[foundationYear] = S.[foundationYear]
					,[relationshipDateKey] = S.[relationshipDateKey]
					,[relationshipDate] = S.[relationshipDate]
					,[nurseryOnSite] = S.[nurseryOnSite]
					,[millOnSite] = S.[millOnSite]
					,[isPartOfAgripreneurship] = S.[isPartOfAgripreneurship]
					,[locationVerified] = S.[locationVerified]
					,[isValidCoordinates] = S.[isValidCoordinates]
					,[status4C] = S.[status4C]
					,[status4CTxt] = S.[status4CTxt]
					,[AAAEntryYear] = S.[AAAEntryYear]
					,[AAAEnrolmentDateKey] = S.[AAAEnrolmentDateKey]
					,[AAAEnrolmentDate] = S.[AAAEnrolmentDate]
					,[AAAStatus] = S.[AAAStatus]
					,[AAAStatusTxt] = S.[AAAStatusTxt]
					,[license4C] = S.[license4C]
					,[unit4C] = S.[unit4C]
					,[subcluster_name] = S.[subcluster_name]
					,[cluster_name] = S.[cluster_name]
					,[country_name] = S.[country_name]
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
			,'dim_nsc_entity_master'
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
			,'dim_nsc_entity_master'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO


