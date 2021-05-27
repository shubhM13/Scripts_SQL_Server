/*******************************************
 Name 		: dm.usp_merge_fact_employee_mobile_sync_analysis
 Author     : Shubham Mishra
 Created On : 26, May, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
ALTER PROCEDURE dm.usp_merge_fact_employee_mobile_sync_analysis (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.fact_employee_mobile_sync_analysis AS D
		USING dm.view_fact_employee_mobile_sync_analysis AS S
			ON (D.employeeId = S.employeeId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[employeeId]
					,[empUserName]
					,[employeeName]
					,[employeeEmail]
					,[empOrgId]
					,[empOrgName]
					,[empOrgLoB]
					,[empCountry]
					,[recordAvlblInUserSettings]
					,[hasOfflineMobileGroup]
					,[offlineMobileGroupId]
					,[offlineMobileGroupName]
					,[allEntityCount]
					,[offlineEntityCount]
					,[SyncInProgressTime]
					,[SyncStartTime]
					,[SyncEndTime]
					,[lastSyncStatus]
					,[syncTimeDuration]
					,[Year]
					,[Month]
					,[Day]
					,[appLogTime]
					,[userRole]
					,[logDescription]
					,[syncType]
					,[buildVersion]
					,[deviceLogTime]
					,[devicePlatform]
					,[deviceModel]
					,[deviceManufacturer]
					,[OSVersion]
					,[cordovaVersion]
					)
				VALUES (
					S.[employeeId]
					,S.[empUserName]
					,S.[employeeName]
					,S.[employeeEmail]
					,S.[empOrgId]
					,S.[empOrgName]
					,S.[empOrgLoB]
					,S.[empCountry]
					,S.[recordAvlblInUserSettings]
					,S.[hasOfflineMobileGroup]
					,S.[offlineMobileGroupId]
					,S.[offlineMobileGroupName]
					,S.[allEntityCount]
					,S.[offlineEntityCount]
					,S.[SyncInProgressTime]
					,S.[SyncStartTime]
					,S.[SyncEndTime]
					,S.[lastSyncStatus]
					,S.[syncTimeDuration]
					,S.[Year]
					,S.[Month]
					,S.[Day]
					,S.[appLogTime]
					,S.[userRole]
					,S.[logDescription]
					,S.[syncType]
					,S.[buildVersion]
					,S.[deviceLogTime]
					,S.[devicePlatform]
					,S.[deviceModel]
					,S.[deviceManufacturer]
					,S.[OSVersion]
					,S.[cordovaVersion]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [empUserName] = S.[empUserName]
					,[employeeName] = S.[employeeName]
					,[employeeEmail] = S.[employeeEmail]
					,[empOrgId] = S.[empOrgId]
					,[empOrgName] = S.[empOrgName]
					,[empOrgLoB] = S.[empOrgLoB]
					,[empCountry] = S.[empCountry]
					,[recordAvlblInUserSettings] = S.[recordAvlblInUserSettings]
					,[hasOfflineMobileGroup] = S.[hasOfflineMobileGroup]
					,[offlineMobileGroupId] = S.[offlineMobileGroupId]
					,[offlineMobileGroupName] = S.[offlineMobileGroupName]
					,[allEntityCount] = S.[allEntityCount]
					,[offlineEntityCount] = S.[offlineEntityCount]
					,[SyncInProgressTime] = S.[SyncInProgressTime]
					,[SyncStartTime] = S.[SyncStartTime]
					,[SyncEndTime] = S.[SyncEndTime]
					,[lastSyncStatus] = S.[lastSyncStatus]
					,[syncTimeDuration] = S.[syncTimeDuration]
					,[Year] = S.[Year]
					,[Month] = S.[Month]
					,[Day] = S.[Day]
					,[appLogTime] = S.[appLogTime]
					,[userRole] = S.[userRole]
					,[logDescription] = S.[logDescription]
					,[syncType] = S.[syncType]
					,[buildVersion] = S.[buildVersion]
					,[deviceLogTime] = S.[deviceLogTime]
					,[devicePlatform] = S.[devicePlatform]
					,[deviceModel] = S.[deviceModel]
					,[deviceManufacturer] = S.[deviceManufacturer]
					,[OSVersion] = S.[OSVersion]
					,[cordovaVersion] = S.[cordovaVersion]
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
			,'fact_employee_mobile_sync_analysis'
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
			,'fact_employee_mobile_sync_analysis'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO;



EXEC dm.usp_merge_fact_employee_mobile_sync_analysis;
select * from [AUDIT].[data_model_merge_log];



