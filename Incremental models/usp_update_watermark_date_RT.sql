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


insert into audit.WaterMarkRT(SchemaName
                              ,TableName
                              ,HanaTableName
                              ,LastTrigger
                              ,CurrentTrigger
                              ,AuditColumn)
values
('CT', 'ListOption', '"FARMS"."nestle.dev.glb.farms.data.structure::CT.ListOption"', CAST('05-05-2021' AS DATETIME), CAST('05-05-2021' AS DATETIME), '[auditInfo.modifiedOn]'),
('CT', 'ListOption_Txt', '"FARMS"."nestle.dev.glb.farms.data.structure::CT.ListOption_Txt"', CAST('05-05-2021' AS DATETIME), CAST('05-05-2021' AS DATETIME), NULL),
('CT', 'UserSetting', '"FARMS"."nestle.dev.glb.farms.data.structure::CT.UserSetting"', CAST('05-05-2021' AS DATETIME), CAST('05-05-2021' AS DATETIME), '[auditInfo.modifiedOn]'),
('CT', 'AppLog', '"FARMS"."nestle.dev.glb.farms.data.structure::CT.AppLog"', CAST('05-05-2021' AS DATETIME), CAST('05-05-2021' AS DATETIME), '[logTime]'),
('ET', 'Group', '"FARMS"."nestle.dev.glb.farms.data.structure::ET.Group"', CAST('05-05-2021' AS DATETIME), CAST('05-05-2021' AS DATETIME), '[auditInfo.modifiedOn]'),
('AT', 'Template', '"FARMS"."nestle.dev.glb.farms.data.structure::AT.Template"', CAST('05-05-2021' AS DATETIME), CAST('05-05-2021' AS DATETIME), '[auditInfo.modifiedOn]'),
('AT', 'Template_Txt', '"FARMS"."nestle.dev.glb.farms.data.structure::AT.Template_Txt"', CAST('05-05-2021' AS DATETIME), CAST('05-05-2021' AS DATETIME), '[auditInfo.modifiedOn]'),
('AT', 'Criteria', '"FARMS"."nestle.dev.glb.farms.data.structure::AT.Criteria"', CAST('05-05-2021' AS DATETIME), CAST('05-05-2021' AS DATETIME), '[auditInfo.modifiedOn]'),
('AT', 'Criteria_Txt', '"FARMS"."nestle.dev.glb.farms.data.structure::AT.Criteria_Txt"', CAST('05-05-2021' AS DATETIME), CAST('05-05-2021' AS DATETIME), NULL),
('AT', 'CriteriaToTopic', '"FARMS"."nestle.dev.glb.farms.data.structure::AT.CriteriaToTopic"', CAST('05-05-2021' AS DATETIME), CAST('05-05-2021' AS DATETIME), NULL),
('AT', 'CriteriaToCriteriaGroup', '"FARMS"."nestle.dev.glb.farms.data.structure::AT.CriteriaToCriteriaGroup"', CAST('05-05-2021' AS DATETIME), CAST('05-05-2021' AS DATETIME), NULL),
('IT', 'EventToTopic', '"FARMS"."nestle.dev.glb.farms.data.structure::IT.EventToTopic"', CAST('05-05-2021' AS DATETIME), CAST('05-05-2021' AS DATETIME), NULL),
('IT', 'EventToEmloyee', '"FARMS"."nestle.dev.glb.farms.data.structure::IT.EventToEmployee"', CAST('05-05-2021' AS DATETIME), CAST('05-05-2021' AS DATETIME), NULL);


select * from audit.WaterMarkRT
order by SchemaName, TableName ASC