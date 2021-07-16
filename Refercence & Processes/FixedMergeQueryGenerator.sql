ALTER PROCEDURE [dm].[GenerateFixedMergeSQL] 
@TgtSchemaName VARCHAR(100)
,@TgtTableName VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @sql VARCHAR(8000)

	SET @sql = '
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
			schema_name, table_name ,last_run_ts ,last_run_status, count, pipeline_name, run_id
			)
		VALUES (
			'+ '''' +@TgtSchemaName+ '''' +', ' + '''' + @TgtTableName + '''' +', CURRENT_TIMESTAMP, ''SUCCESS'', @ROW, @pipeline_name, @run_id
			);
	END TRY
	BEGIN CATCH
		EXEC @ERROR_PROC @pipeline_name = @pipeline_name
			,@run_id = @run_id;
		INSERT INTO [AUDIT].[data_model_merge_log] (
			schema_name, table_name ,last_run_ts ,last_run_status, count, pipeline_name, run_id
			)
		VALUES (
			'+ '''' +@TgtSchemaName+ '''' +', ' + '''' + @TgtTableName + '''' +', CURRENT_TIMESTAMP, ''FAIL'', NULL, @pipeline_name, @run_id
			);
	END CATCH
END 
GO'

	PRINT @SQL
END;

EXEC [dm].[GenerateFixedMergeSQL]  'dm', 'fact_employee_mobile_sync_analysis'
