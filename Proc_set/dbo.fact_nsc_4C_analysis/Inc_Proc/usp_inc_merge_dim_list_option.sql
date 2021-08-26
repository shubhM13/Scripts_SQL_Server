/*******************************************
 Name 		: dm.usp_inc_merge_dim_list_option
 Author     : Shubham Mishra
 Created On : 21, Jul, 2021
 PURPOSE    : Data Model Incremental Setup
 *******************************************/
--drop procedure dm.usp_inc_merge_dim_list_option
CREATE PROCEDURE dm.usp_inc_merge_dim_list_option (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.dim_list_option AS D
		USING dm.view_inc_dim_list_option AS S
			ON (D.setId  = S.setId 
			AND D.itemCode = S.itemCode)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[setId]
					,[itemCode]
					,[score]
					,[label]
					)
				VALUES (
					S.[setId]
					,S.[itemCode]
					,S.[score]
					,S.[label]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [itemCode] = S.[itemCode]
					,[score] = S.[score]
					,[label] = S.[label]
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
			,'dim_list_option'
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
			,'dim_list_option'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO