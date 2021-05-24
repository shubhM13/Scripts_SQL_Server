SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 20th May, 2021
 PURPOSE    : Authorisation Framework
 *******************************************/
--drop view dm.view_dim_geonode_to_entities	
CREATE VIEW [dm].[view_dim_geonode_to_entities]
AS
(
		SELECT DISTINCT A.geoNodeId
			,A.entityId
		FROM [dwh].[ET_Entity] AS A
		WHERE A.status <> 'DELETED'
		);