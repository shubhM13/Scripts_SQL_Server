/****** Object:  View [AUDIT].[VIEW_STAR_SCHEMA]    Script Date: 09-08-2021 14:21:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*******************************************
 Author     : Shubham Mishra
 Created On : 28th May, 2021
 PURPOSE    : Data Catalog
 *******************************************/
--drop view [AUDIT].[VIEW_STAR_SCHEMA]		
CREATE VIEW [AUDIT].[VIEW_STAR_SCHEMA]
AS
(		SELECT	distinct diagram_id
				,'dbo.' + dig.name AS star_schema
				,map.ref_table_id
				,map.ref_table
		FROM [AUDIT].[SYSDIAGRAMS] AS dig
		INNER JOIN 
		(SELECT DISTINCT tab1.object_id AS [fact_table_id]
			,sch.name + '.' + tab1.name AS [fact_table]
			,tab2.object_id AS [ref_table_id]
			,sch.name + '.' + tab2.name AS [ref_table]
		FROM sys.foreign_key_columns fkc
		INNER JOIN sys.objects obj ON obj.object_id = fkc.constraint_object_id
		INNER JOIN sys.tables tab1 ON tab1.object_id = fkc.parent_object_id
		AND tab1.name LIKE '%fact%'
		INNER JOIN sys.schemas sch ON tab1.schema_id = sch.schema_id
		INNER JOIN sys.tables tab2 ON tab2.object_id = fkc.referenced_object_id
		UNION
		select distinct A.object_id AS [fact_table_id]
			,schema_name(A.schema_id) + '.' + A.name AS [fact_table]
			,A.object_id AS [ref_table_id]
			,schema_name(A.schema_id) + '.' + A.name AS [ref_table]
		FROM sys.tables AS A
		where name like '%fact%') map
		ON map.fact_table LIKE '%'+dig.name+'%'
		);
GO

select * from [AUDIT].[VIEW_STAR_SCHEMA];

DROP TABLE [AUDIT].[SYSDIAGRAMS];

SELECT *
INTO [AUDIT].[SYSDIAGRAMS]
FROM [dbo].[sysdiagrams];

