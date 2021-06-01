SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 28th May, 2021
 PURPOSE    : Data Catalog
 *******************************************/
--drop view [AUDIT].[DATA_MODEL_LINEAGE]		
CREATE VIEW [AUDIT].[DATA_MODEL_LINEAGE]
AS
(
		SELECT A.diagram_id
			,A.star_schema
			,A.ref_table_id AS star_join_tbl_id
			,A.ref_table AS star_join_tbl_name
			,B.view_id
			,B.view_name
			,C.ref_entity_id
			,C.referenced_schema_name + '.' + C.referenced_entity_name AS ref_entity_name
		FROM [AUDIT].[VIEW_STAR_SCHEMA] AS A
		LEFT JOIN [AUDIT].[VIEW_DM_LAYER_TABLE_TO_VIEW_MAP] AS B ON A.ref_table_id = B.table_id
		LEFT JOIN [AUDIT].[VIEW_VIEW_DEPENDENCY] AS C ON B.view_id = C.object_id
		);

select * from [AUDIT].[DATA_MODEL_LINEAGE];