/*******************************************
 Name 		: [AUDIT].[usp_update_watermark_date_RT]
 Author     : Shubham Mishra
 Created On : 26th Jul, 2021
 PURPOSE    : Near Real Time Incremental Data Setup
 *******************************************/
--drop procedure [AUDIT].[usp_update_watermark_date_RT]
CREATE PROCEDURE [AUDIT].[usp_update_watermark_date_RT] (
	@schema_name AS VARCHAR(100)
	,@table_name AS VARCHAR(100)
	,@current_trigger AS NVARCHAR(100)
	)
AS
BEGIN
	DECLARE @existing_trigger DATETIME2

	SET @existing_trigger = (
			SELECT CurrentTrigger
			FROM AUDIT.WaterMarkRT
			WHERE SchemaName = @schema_name
				AND TableName = @table_name
			);

	UPDATE AUDIT.WaterMarkRT
	SET LastTrigger = @existing_trigger
	WHERE SchemaName = @schema_name
		AND TableName = @table_name;

	UPDATE AUDIT.WaterMarkRT
	SET CurrentTrigger = CAST(@current_trigger AS DATETIME2)
	WHERE SchemaName = @schema_name
		AND TableName = @table_name;
END
GO

select * from audit.waterMarkRT;

EXEC [AUDIT].[usp_update_watermark_date_RT] 'AT', 'Observation', '2100-01-01 00:00:00';