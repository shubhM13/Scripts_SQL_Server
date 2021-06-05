/*******************************************
 Name 		: dm.usp_merge_dim_nsc_4C_group
 Author     : Shubham Mishra
 Created On : 04, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
ALTER PROCEDURE dm.usp_merge_dim_nsc_4C_group (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_nsc_4C_group AS D
		USING dm.view_dim_nsc_4C_group AS S
			ON (D.entityCertId = S.entityCertId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[entityId]
					,[entityId]
					,[entityCertId]
					,[entityCertId]
					,[entityCertNumber]
					,[entityCertNumber]
					,[entityCertDate]
					,[entityCertDate]
					,[entityCertStatus]
					,[entityCertStatus]
					,[entityCertAvgScore]
					,[entityCertAvgScore]
					,[entityCertifiedBy]
					,[entityCertifiedBy]
					,[groupId]
					,[groupId]
					,[grpStatus]
					,[grpStatus]
					,[groupName]
					,[groupName]
					,[grpCertNumber]
					,[grpCertNumber]
					,[grpCertDate]
					,[grpCertDate]
					,[grpCertStatus]
					,[grpCertStatus]
					,[grpCertAvgScore]
					,[grpCertAvgScore]
					,[grpCertifiedBy]
					,[grpCertifiedBy]
					)
				VALUES (
					S.[entityId]
					,S.[entityId]
					,S.[entityCertId]
					,S.[entityCertId]
					,S.[entityCertNumber]
					,S.[entityCertNumber]
					,S.[entityCertDate]
					,S.[entityCertDate]
					,S.[entityCertStatus]
					,S.[entityCertStatus]
					,S.[entityCertAvgScore]
					,S.[entityCertAvgScore]
					,S.[entityCertifiedBy]
					,S.[entityCertifiedBy]
					,S.[groupId]
					,S.[groupId]
					,S.[grpStatus]
					,S.[grpStatus]
					,S.[groupName]
					,S.[groupName]
					,S.[grpCertNumber]
					,S.[grpCertNumber]
					,S.[grpCertDate]
					,S.[grpCertDate]
					,S.[grpCertStatus]
					,S.[grpCertStatus]
					,S.[grpCertAvgScore]
					,S.[grpCertAvgScore]
					,S.[grpCertifiedBy]
					,S.[grpCertifiedBy]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [entityId] = S.[entityId]
					,[entityCertId] = S.[entityCertId]
					,[entityCertNumber] = S.[entityCertNumber]
					,[entityCertNumber] = S.[entityCertNumber]
					,[entityCertDate] = S.[entityCertDate]
					,[entityCertDate] = S.[entityCertDate]
					,[entityCertStatus] = S.[entityCertStatus]
					,[entityCertStatus] = S.[entityCertStatus]
					,[entityCertAvgScore] = S.[entityCertAvgScore]
					,[entityCertAvgScore] = S.[entityCertAvgScore]
					,[entityCertifiedBy] = S.[entityCertifiedBy]
					,[entityCertifiedBy] = S.[entityCertifiedBy]
					,[groupId] = S.[groupId]
					,[groupId] = S.[groupId]
					,[grpStatus] = S.[grpStatus]
					,[grpStatus] = S.[grpStatus]
					,[groupName] = S.[groupName]
					,[groupName] = S.[groupName]
					,[grpCertNumber] = S.[grpCertNumber]
					,[grpCertNumber] = S.[grpCertNumber]
					,[grpCertDate] = S.[grpCertDate]
					,[grpCertDate] = S.[grpCertDate]
					,[grpCertStatus] = S.[grpCertStatus]
					,[grpCertStatus] = S.[grpCertStatus]
					,[grpCertAvgScore] = S.[grpCertAvgScore]
					,[grpCertAvgScore] = S.[grpCertAvgScore]
					,[grpCertifiedBy] = S.[grpCertifiedBy]
					,[grpCertifiedBy] = S.[grpCertifiedBy]
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
			,'dim_nsc_4C_group'
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
			,'dim_nsc_4C_group'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO

