/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  StoredProcedure [dm].[usp_inc_merge_dim_nsc_person]    Script Date: 22/07/2021 5:01:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Name 		: dm.usp_inc_merge_dim_nsc_person
 Author     : Shubham Mishra
 Created On : 09, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
CREATE PROCEDURE [dm].[usp_inc_merge_dim_nsc_person] (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_nsc_person AS D
		USING dm.view_inc_dim_nsc_person AS S
			ON (D.personId = S.personId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[personId]
					,[personExternalId]
					,[personFirstName]
					,[personLastName]
					,[personFullName]
					,[status]
					,[gender]
					,[maritalStatus]
					,[educationLevel]
					,[email]
					,[mobile]
					,[fixedPhone]
					,[personEntityId]
					,[entityBusinessId]
					,[entityName]
					,[entityPrimaryContact]
					,[yearStartedFarming]
					,[yearsOfSchooling]
					,[relationToEntity]
					,[livesAt]
					,[deliversCoffee]
					,[worksWithCoffee]
					,[yearOfBirth]
					)
				VALUES (
					S.[personId]
					,S.[personExternalId]
					,S.[personFirstName]
					,S.[personLastName]
					,S.[personFullName]
					,S.[status]
					,S.[gender]
					,S.[maritalStatus]
					,S.[educationLevel]
					,S.[email]
					,S.[mobile]
					,S.[fixedPhone]
					,S.[personEntityId]
					,S.[entityBusinessId]
					,S.[entityName]
					,S.[entityPrimaryContact]
					,S.[yearStartedFarming]
					,S.[yearsOfSchooling]
					,S.[relationToEntity]
					,S.[livesAt]
					,S.[deliversCoffee]
					,S.[worksWithCoffee]
					,S.[yearOfBirth]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [personExternalId] = S.[personExternalId]
					,[personFirstName] = S.[personFirstName]
					,[personLastName] = S.[personLastName]
					,[personFullName] = S.[personFullName]
					,[status] = S.[status]
					,[gender] = S.[gender]
					,[maritalStatus] = S.[maritalStatus]
					,[educationLevel] = S.[educationLevel]
					,[email] = S.[email]
					,[mobile] = S.[mobile]
					,[fixedPhone] = S.[fixedPhone]
					,[personEntityId] = S.[personEntityId]
					,[entityBusinessId] = S.[entityBusinessId]
					,[entityName] = S.[entityName]
					,[entityPrimaryContact] = S.[entityPrimaryContact]
					,[yearStartedFarming] = S.[yearStartedFarming]
					,[yearsOfSchooling] = S.[yearsOfSchooling]
					,[relationToEntity] = S.[relationToEntity]
					,[livesAt] = S.[livesAt]
					,[deliversCoffee] = S.[deliversCoffee]
					,[worksWithCoffee] = S.[worksWithCoffee]
					,[yearOfBirth] = S.[yearOfBirth]
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
			,'dim_nsc_person'
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
			,'dim_nsc_person'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO


