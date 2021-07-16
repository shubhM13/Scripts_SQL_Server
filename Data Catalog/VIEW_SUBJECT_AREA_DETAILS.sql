/****** Object:  View [AUDIT].[VIEW_TABLE_METADATA]    Script Date: 07-06-2021 06:29:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*******************************************
 Author     : Shubham Mishra
 Created On : 5th June, 2021
 PURPOSE    : Data Catalog
 *******************************************/
--drop view [AUDIT].[VIEW_SUBJECT_AREA_DETAILS]		
CREATE VIEW [AUDIT].[VIEW_SUBJECT_AREA_DETAILS]	
AS
(
		SELECT T.object_id
			,SCHEMA_NAME(T.schema_id) AS [SQL Schema Name]
			,SUBSTRING(T.name, 0, 3) AS [Farms Subject Area]
			,T.name AS [Table Name]
			,T.create_date AS [Created Date]
			,T.modify_date AS [Modified Date]
			,T.max_column_id_used AS [Column Count]
			,SUM(P.rows) AS [Record Count]
			,CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS [Used MB]
			,CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS [Unused MB]
			,CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS [Total MB]
		FROM sys.tables AS T
		INNER JOIN sys.indexes I ON T.OBJECT_ID = I.object_id
		INNER JOIN sys.partitions P ON I.object_id = P.OBJECT_ID
			AND I.index_id = P.index_id
		INNER JOIN sys.allocation_units A ON P.partition_id = A.container_id
			AND T.TYPE = 'U'
		WHERE schema_id IN (
				SCHEMA_ID('dwh')
				,SCHEMA_ID('stg')
				)
		AND SUBSTRING(T.name, 0, 3) IN (
				'AT'
				,'CT'
				,'DT'
				,'ET'
				,'IT'
				,'LT'
				,'MT'
				,'OT'
				,'PT'
				)
		GROUP BY T.object_id
			,T.schema_id
			,SUBSTRING(T.name, 0, 3)
			,T.name
			,T.create_date
			,T.modify_date
			,T.max_column_id_used
		);
GO