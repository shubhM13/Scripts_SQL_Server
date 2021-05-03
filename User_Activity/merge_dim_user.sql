/*******************************************
 Name 		: [dm].[usp_merge_dim_user]
 Author     : Shubham Mishra
 Created On : 29th April
 PURPOSE    : User Activity History Model
 *******************************************/
--drop procedure [dm].[usp_merge_dim_user]
CREATE PROCEDURE [dm].[usp_merge_dim_user]
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
	DECLARE @ROW INT;

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_user AS D
		USING dm.view_dim_user AS S
			ON (D.employeeId = S.employeeId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[userName]
					,[organisationId]
					,[orgName]
					,[lineOfBusiness]
					,[employeeId]
					,[employeeName]
					,[status]
					,[employeeEmail]
					,[gender]
					,[businessRole]
					,[country]
					)
				VALUES (
					S.[userName]
					,S.[organisationId]
					,S.[orgName]
					,S.[lineOfBusiness]
					,S.[employeeId]
					,S.[employeeName]
					,S.[status]
					,S.[employeeEmail]
					,S.[gender]
					,S.[businessRole]
					,S.[country]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [userName] = S.[userName]
					,[organisationId] = S.[organisationId]
					,[orgName] = S.[orgName]
					,[lineOfBusiness] = S.[lineOfBusiness]
					,[employeeName] = S.[employeeName]
					,[status] = S.[status]
					,[employeeEmail] = S.[employeeEmail]
					,[gender] = S.[gender]
					,[businessRole] = S.[businessRole]
					,[country] = S.[country]
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
			)
		VALUES (
			'dm'
			,'dm.dim_user'
			,CURRENT_TIMESTAMP
			,'Completed'
			,@ROW
			);
	END TRY

	BEGIN CATCH
		EXEC (@ERROR_PROC);

		INSERT INTO [AUDIT].[data_model_merge_log] (
			schema_name
			,table_name
			,last_run_ts
			,last_run_status
			,count
			)
		VALUES (
			'dm'
			,'dm.dim_user'
			,CURRENT_TIMESTAMP
			,'Faied'
			,NULL
			);
	END CATCH
END
GO

-- EXEC [dm].[usp_merge_dim_user];
SELECT *
FROM [AUDIT].[data_model_merge_log];