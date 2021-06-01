SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 28th May, 2021
 PURPOSE    : Data Catalog
 *******************************************/
--drop view [AUDIT].[VIEW_DM_LAYER_TABLE_TO_VIEW_MAP];		
CREATE VIEW [AUDIT].[VIEW_DM_LAYER_TABLE_TO_VIEW_MAP]
AS
(
		SELECT DISTINCT A.object_id AS table_id
			,schema_name(A.schema_id) + '.' + A.name AS table_name
			,B.object_id AS view_id
			,schema_name(B.schema_id) + '.' + B.name AS view_name
		FROM sys.tables AS A
		INNER JOIN sys.VIEWS AS B
		ON B.name = 'view_'+ A.name
		);

drop table [AUDIT].[DM_LAYER_TABLE_TO_VIEW_MAP];

SELECT *
INTO [AUDIT].[DM_LAYER_TABLE_TO_VIEW_MAP]
FROM [AUDIT].[VIEW_DM_LAYER_TABLE_TO_VIEW_MAP];


select * from [AUDIT].[DM_LAYER_TABLE_TO_VIEW_MAP];