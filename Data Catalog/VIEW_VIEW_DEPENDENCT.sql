SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 28th May, 2021
 PURPOSE    : Data Catalog
 *******************************************/
--drop view [AUDIT].[VIEW_VIEW_DEPENDENCY]		
CREATE VIEW [AUDIT].[VIEW_VIEW_DEPENDENCY]
AS
(
		SELECT DISTINCT v.object_id
			,schema_name(v.schema_id) AS schema_name
			,v.name AS view_name
			,o.object_id AS ref_entity_id
			,schema_name(o.schema_id) AS referenced_schema_name
			,o.name AS referenced_entity_name
		FROM sys.VIEWS v
		INNER JOIN sys.sql_expression_dependencies d ON d.referencing_id = v.object_id
			AND d.referenced_id IS NOT NULL
		INNER JOIN sys.objects o ON o.object_id = d.referenced_id
		);

drop table [AUDIT].[VIEW_DEPENDENCY];

SELECT *
INTO [AUDIT].[VIEW_DEPENDENCY]
FROM [AUDIT].[VIEW_VIEW_DEPENDENCY];


select * from [AUDIT].[VIEW_DEPENDENCY];