SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 28th May, 2021
 PURPOSE    : Data Catalog
 *******************************************/
--drop view [AUDIT].[VIEW_TABLE_METADATA]		
CREATE VIEW [AUDIT].[VIEW_TABLE_METADATA]
AS
(
		SELECT T.object_id
			,SCHEMA_NAME(T.schema_id) AS schema_name
			,T.name AS table_name
			,CASE 
				WHEN SCHEMA_NAME(T.schema_id) = 'dm'
					AND T.name LIKE 'dim_%'
					THEN 'DIMENSION TABLE'
				WHEN SCHEMA_NAME(T.schema_id) = 'dm'
					AND T.name LIKE 'fact_%'
					THEN 'FACT TABLE'
				WHEN SCHEMA_NAME(T.schema_id) = 'dm'
					AND T.name LIKE 'bridge_%'
					THEN 'BRIDGE TABLE'
				WHEN SCHEMA_NAME(T.schema_id) = 'dm'
					AND (
						T.name NOT LIKE 'dim_%'
						OR T.name NOT LIKE 'fact_%'
						OR T.name NOT LIKE 'bridge_%'
						)
					THEN 'DIMENSION TABLE'
				WHEN SCHEMA_NAME(T.schema_id) = 'dwh'
					THEN 'DWH TABLE'
				WHEN SCHEMA_NAME(T.schema_id) = 'stg'
					THEN 'STG TABLE'
				WHEN SCHEMA_NAME(T.schema_id) = 'AUDIT'
					THEN 'AUDIT TABLE'
				END AS type
			,T.create_date
			,T.modify_date
			,T.max_column_id_used AS column_count
			,SUM(P.rows) AS record_count
			,CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS used_mb
			,CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS unused_mb
			,CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS total_mb
		FROM sys.tables AS T
		INNER JOIN sys.indexes I ON T.OBJECT_ID = I.object_id
		INNER JOIN sys.partitions P ON I.object_id = P.OBJECT_ID
			AND I.index_id = P.index_id
		INNER JOIN sys.allocation_units A ON P.partition_id = A.container_id
			AND T.TYPE = 'U'
		WHERE schema_id IN (
				SCHEMA_ID('dm')
				,SCHEMA_ID('dwh')
				,SCHEMA_ID('stg')
				,SCHEMA_ID('AUDIT')
				)
		GROUP BY T.object_id
			,T.schema_id
			,T.name
			,T.create_date
			,T.modify_date
			,T.max_column_id_used
		);

select * from [AUDIT].[view_table_metadata] order by type;

drop table [audit].[table_metadata];

select * 
into [AUDIT].[TABLE_METADATA]
from [AUDIT].[VIEW_TABLE_METADATA]
ORDER BY type;

ALTER TABLE [AUDIT].[TABLE_METADATA] ADD CONSTRAINT table_metadata_pk PRIMARY KEY (object_id);

select * from [AUDIT].[TABLE_METADATA];