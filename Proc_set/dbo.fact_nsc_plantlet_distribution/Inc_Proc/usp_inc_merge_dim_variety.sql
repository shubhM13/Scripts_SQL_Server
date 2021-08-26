/*******************************************
 Name 		: dm.usp_inc_merge_dim_variety
 Author     : Shubham Mishra
 Created On : 21, Jul, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
--drop procedure dm.usp_inc_merge_dim_variety
CREATE PROCEDURE dm.usp_inc_merge_dim_variety (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_variety AS D
		USING dm.view_inc_dim_variety AS S
			ON (D.varietyId = S.varietyId)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[varietyId]
					,[name]
					,[referenceNumber]
					,[genericFlag]
					,[status]
					,[species]
					,[origin]
					,[genericStatus]
					,[arabicaShape]
					,[molecularSignature]
					,[organisationId]
					,[parents]
					,[propMethod]
					,[countryOfOrigin]
					)
				VALUES (
					S.[varietyId]
					,S.[name]
					,S.[referenceNumber]
					,S.[genericFlag]
					,S.[status]
					,S.[species]
					,S.[origin]
					,S.[genericStatus]
					,S.[arabicaShape]
					,S.[molecularSignature]
					,S.[organisationId]
					,S.[parents]
					,S.[propMethod]
					,S.[countryOfOrigin]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [name] = S.[name]
					,[referenceNumber] = S.[referenceNumber]
					,[genericFlag] = S.[genericFlag]
					,[status] = S.[status]
					,[species] = S.[species]
					,[origin] = S.[origin]
					,[genericStatus] = S.[genericStatus]
					,[arabicaShape] = S.[arabicaShape]
					,[molecularSignature] = S.[molecularSignature]
					,[organisationId] = S.[organisationId]
					,[parents] = S.[parents]
					,[propMethod] = S.[propMethod]
					,[countryOfOrigin] = S.[countryOfOrigin]
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
			,'dim_variety'
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
			,'dim_variety'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO