/*******************************************
 Name 		: dm.usp_merge_dim_nsp_organisation
 Author     : Shubham Mishra
 Created On : 17, Jun, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
ALTER PROCEDURE dm.usp_merge_dim_nsp_organisation (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_nsp_organisation AS D
		USING dm.view_dim_nsp_organisation AS S
			ON (D.organisationId = S.organisationId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[organisationId]
					,[orgBusinessId]
					,[isBusinessUnit]
					,[isAdminUnit]
					,[organisationType]
					,[orgName]
					,[parentOrgName]
					,[activationDate]
					,[coffeeForm]
					,[orgStatus]
					,[dilutionRate]
					,[productionUOM]
					,[totalWomen]
					,[totalMen]
					,[addressLine1]
					,[addressLine2]
					,[addressCity]
					,[addressDistrict]
					,[addressProvince]
					,[addressZipcode]
					,[addressCountryCode]
					,[latitude]
					,[longitude]
					,[countryName]
					)
				VALUES (
					S.[organisationId]
					,S.[orgBusinessId]
					,S.[isBusinessUnit]
					,S.[isAdminUnit]
					,S.[organisationType]
					,S.[orgName]
					,S.[parentOrgName]
					,S.[activationDate]
					,S.[coffeeForm]
					,S.[orgStatus]
					,S.[dilutionRate]
					,S.[productionUOM]
					,S.[totalWomen]
					,S.[totalMen]
					,S.[addressLine1]
					,S.[addressLine2]
					,S.[addressCity]
					,S.[addressDistrict]
					,S.[addressProvince]
					,S.[addressZipcode]
					,S.[addressCountryCode]
					,S.[latitude]
					,S.[longitude]
					,S.[countryName]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [orgBusinessId] = S.[orgBusinessId]
					,[isBusinessUnit] = S.[isBusinessUnit]
					,[isAdminUnit] = S.[isAdminUnit]
					,[organisationType] = S.[organisationType]
					,[orgName] = S.[orgName]
					,[parentOrgName] = S.[parentOrgName]
					,[activationDate] = S.[activationDate]
					,[coffeeForm] = S.[coffeeForm]
					,[orgStatus] = S.[orgStatus]
					,[dilutionRate] = S.[dilutionRate]
					,[productionUOM] = S.[productionUOM]
					,[totalWomen] = S.[totalWomen]
					,[totalMen] = S.[totalMen]
					,[addressLine1] = S.[addressLine1]
					,[addressLine2] = S.[addressLine2]
					,[addressCity] = S.[addressCity]
					,[addressDistrict] = S.[addressDistrict]
					,[addressProvince] = S.[addressProvince]
					,[addressZipcode] = S.[addressZipcode]
					,[addressCountryCode] = S.[addressCountryCode]
					,[latitude] = S.[latitude]
					,[longitude] = S.[longitude]
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
			,'dim_nsp_organisation'
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
			,'dim_nsp_organisation'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO

EXEC dm.usp_merge_dim_nsp_organisation ;

