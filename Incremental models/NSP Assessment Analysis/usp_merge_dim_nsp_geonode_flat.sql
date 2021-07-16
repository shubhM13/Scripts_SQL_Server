/*******************************************
 Name 		: dm.usp_merge_dim_nsp_geonode_flat
 Author     : Shubham Mishra
 Created On : 17, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
ALTER PROCEDURE dm.usp_merge_dim_nsp_geonode_flat (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_nsp_geonode_flat AS D
		USING dm.view_dim_nsp_geonode_flat AS S
			ON (D.geoNodeId = S.geoNodeId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[geoNodeId]
					,[type]
					,[name]
					,[status]
					,[subCluster]
					,[subClusterName]
					,[cluster]
					,[clusterName]
					,[country]
					,[countryName]
					,[countryCode]
					,[currencyCode]
					)
				VALUES (
					S.[geoNodeId]
					,S.[type]
					,S.[name]
					,S.[status]
					,S.[subCluster]
					,S.[subClusterName]
					,S.[cluster]
					,S.[clusterName]
					,S.[country]
					,S.[countryName]
					,S.[countryCode]
					,S.[currencyCode]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [type] = S.[type]
					,[name] = S.[name]
					,[status] = S.[status]
					,[subCluster] = S.[subCluster]
					,[subClusterName] = S.[subClusterName]
					,[cluster] = S.[cluster]
					,[clusterName] = S.[clusterName]
					,[country] = S.[country]
					,[countryName] = S.[countryName]
					,[countryCode] = S.[countryCode]
					,[currencyCode] = S.[currencyCode]
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
			,'dim_nsp_geonode_flat'
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
			,'dim_nsp_geonode_flat'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO

EXEC dm.usp_merge_dim_nsp_geonode_flat;
