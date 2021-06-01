SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 28th May, 2021
 PURPOSE    : Data Catalog
 *******************************************/
--drop view [AUDIT].[VIEW_STAR_SCHEMA_FK]		
CREATE VIEW [AUDIT].[VIEW_STAR_SCHEMA_FK]
AS
(
		SELECT DISTINCT obj.object_id AS fk_id
			,obj.name AS fk_name
			,tab1.object_id AS [table_id]
			,sch.name + '.' + tab1.name AS [table]
			,col1.name AS [column]
			,tab2.object_id AS [ref_table_id]
			,sch.name + '.' + tab2.name AS [ref_table]
			,col2.name AS [ref_column]
		FROM sys.foreign_key_columns fkc
		INNER JOIN sys.objects obj ON obj.object_id = fkc.constraint_object_id
		INNER JOIN sys.tables tab1 ON tab1.object_id = fkc.parent_object_id
		INNER JOIN sys.schemas sch ON tab1.schema_id = sch.schema_id
		INNER JOIN sys.columns col1 ON col1.column_id = parent_column_id
			AND col1.object_id = tab1.object_id
		INNER JOIN sys.tables tab2 ON tab2.object_id = fkc.referenced_object_id
		INNER JOIN sys.columns col2 ON col2.column_id = referenced_column_id
			AND col2.object_id = tab2.object_id
		);

select * from [AUDIT].[VIEW_STAR_SCHEMA_FK];