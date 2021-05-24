SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 20th May, 2021
 PURPOSE    : Authorisation Framework
 *******************************************/
--drop view dm.view_dim_org_to_entity_count		
CREATE VIEW [dm].[view_dim_org_to_entity_count]
AS
(
		SELECT DISTINCT A.organisationId
			,COUNT(DISTINCT B.entityId) AS entityCount
		FROM [dm].[view_dim_org_to_geonode_corrected] AS A
		INNER JOIN [dm].[view_dim_geonode_to_entities] AS B ON A.geoNodeId = B.geoNodeId
		GROUP BY A.organisationId
		)

select SUM(entityCount) from [dm].[view_dim_org_to_entity_count] where organisationId <> 'GLOBAL';
select * from [dm].[view_dim_org_to_entity_count] where organisationId = 'GLOBAL';
select * from [dm].[view_dim_org_to_geonode_corrected] where organisationId = 'GLOBAL';
