/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  StoredProcedure [dm].[usp_inc_merge_dim_nsp_entity_master]    Script Date: 22/07/2021 5:08:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Name 		: dm.usp_inc_merge_dim_nsp_entity_master
 Author     : Shubham Mishra
 Created On : 17, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
CREATE PROCEDURE [dm].[usp_inc_merge_dim_nsp_entity_master] (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_nsp_entity_master AS D
		USING dm.view_inc_dim_nsp_entity_master AS S
			ON (D.entityId = S.entityId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[entityId]
					,[externalSystemId]
					,[entityType]
					,[entityStatus]
					,[entityName]
					,[longX]
					,[latY]
					,[altZ]
					,[ownershipType]
					,[relationshipDateKey]
					,[relationshipDate]
					,[nurseryOnSite]
					,[millOnSite]
					,[coreAssessmentStatus]
					,[totalArea]
					,[arabicaProduction]
					,[robustaProduction]
					,[bourbonProduction]
					,[totalProduction]
					,[totalYield]
					,[numInteractions]
					,[numReceivedPlantlet]
					,[TotalNoofCoreNC]
					,[coffeeArea]
					,[locationVerified]
					,[isValidCoordinates]
					,[AAAEntryYear]
					,[AAAEnrolmentDateKey]
					,[AAAEnrolmentDate]
					,[AAAStatus]
					,[subClusterName]
					,[clusterName]
					,[countryName]
					)
				VALUES (
					S.[entityId]
					,S.[externalSystemId]
					,S.[entityType]
					,S.[entityStatus]
					,S.[entityName]
					,S.[longX]
					,S.[latY]
					,S.[altZ]
					,S.[ownershipType]
					,S.[relationshipDateKey]
					,S.[relationshipDate]
					,S.[nurseryOnSite]
					,S.[millOnSite]
					,S.[coreAssessmentStatus]
					,S.[totalArea]
					,S.[arabicaProduction]
					,S.[robustaProduction]
					,S.[bourbonProduction]
					,S.[totalProduction]
					,S.[totalYield]
					,S.[numInteractions]
					,S.[numReceivedPlantlet]
					,S.[TotalNoofCoreNC]
					,S.[coffeeArea]
					,S.[locationVerified]
					,S.[isValidCoordinates]
					,S.[AAAEntryYear]
					,S.[AAAEnrolmentDateKey]
					,S.[AAAEnrolmentDate]
					,S.[AAAStatus]
					,S.[subClusterName]
					,S.[clusterName]
					,S.[countryName]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [externalSystemId] = S.[externalSystemId]
					,[entityType] = S.[entityType]
					,[entityStatus] = S.[entityStatus]
					,[entityName] = S.[entityName]
					,[longX] = S.[longX]
					,[latY] = S.[latY]
					,[altZ] = S.[altZ]
					,[ownershipType] = S.[ownershipType]
					,[relationshipDateKey] = S.[relationshipDateKey]
					,[relationshipDate] = S.[relationshipDate]
					,[nurseryOnSite] = S.[nurseryOnSite]
					,[millOnSite] = S.[millOnSite]
					,[coreAssessmentStatus] = S.[coreAssessmentStatus]
					,[totalArea] = S.[totalArea]
					,[arabicaProduction] = S.[arabicaProduction]
					,[robustaProduction] = S.[robustaProduction]
					,[bourbonProduction] = S.[bourbonProduction]
					,[totalProduction] = S.[totalProduction]
					,[totalYield] = S.[totalYield]
					,[numInteractions] = S.[numInteractions]
					,[numReceivedPlantlet] = S.[numReceivedPlantlet]
					,[TotalNoofCoreNC] = S.[TotalNoofCoreNC]
					,[coffeeArea] = S.[coffeeArea]
					,[locationVerified] = S.[locationVerified]
					,[isValidCoordinates] = S.[isValidCoordinates]
					,[AAAEntryYear] = S.[AAAEntryYear]
					,[AAAEnrolmentDateKey] = S.[AAAEnrolmentDateKey]
					,[AAAEnrolmentDate] = S.[AAAEnrolmentDate]
					,[AAAStatus] = S.[AAAStatus]
					,[subClusterName] = S.[subClusterName]
					,[clusterName] = S.[clusterName]
					,[countryName] = S.[countryName]
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
			,'dim_nsp_entity_master'
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
			,'dim_nsp_entity_master'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO


