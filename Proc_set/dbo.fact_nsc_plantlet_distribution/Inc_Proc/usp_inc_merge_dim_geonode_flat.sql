/*******************************************
 Name 		: dm.usp_inc_merge_dim_geonode_flat
 Author     : Shubham Mishra
 Created On : 21, Jul, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
--drop procedure dm.usp_inc_merge_dim_geonode_flat
CREATE PROCEDURE dm.usp_inc_merge_dim_geonode_flat (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_geonode_flat AS D
		USING dm.view_inc_dim_geonode_flat AS S
			ON (D.geoNodeId = S.geoNodeId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[geoNodeId]
					,[type]
					,[sub_cluster]
					,[sub_cluster_name]
					,[sub_cluster_status]
					,[cluster]
					,[cluster_name]
					,[cluster_status]
					,[cluster_lob]
					,[country]
					,[country_name]
					,[country_status]
					,[countryCode]
					,[currencyCode]
					)
				VALUES (
					S.[geoNodeId]
					,S.[type]
					,S.[sub_cluster]
					,S.[sub_cluster_name]
					,S.[sub_cluster_status]
					,S.[cluster]
					,S.[cluster_name]
					,S.[cluster_status]
					,S.[cluster_lob]
					,S.[country]
					,S.[country_name]
					,S.[country_status]
					,S.[countryCode]
					,S.[currencyCode]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [type] = S.[type]
					,[sub_cluster] = S.[sub_cluster]
					,[sub_cluster_name] = S.[sub_cluster_name]
					,[sub_cluster_status] = S.[sub_cluster_status]
					,[cluster] = S.[cluster]
					,[cluster_name] = S.[cluster_name]
					,[cluster_status] = S.[cluster_status]
					,[cluster_lob] = S.[cluster_lob]
					,[country] = S.[country]
					,[country_name] = S.[country_name]
					,[country_status] = S.[country_status]
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
			,'dim_geonode_flat'
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
			,'dim_geonode_flat'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO