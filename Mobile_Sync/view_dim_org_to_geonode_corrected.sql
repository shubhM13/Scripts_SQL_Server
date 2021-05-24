SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 20th May, 2021
 PURPOSE    : Authorisation Framework
 *******************************************/
--drop view dm.view_dim_org_to_geonode_corrected		
CREATE VIEW [dm].[view_dim_org_to_geonode_corrected]
AS
(
		SELECT DISTINCT A.organisationId
			,B.child AS geoNodeId
		FROM [dwh].[CT_OrgToGeoNode] AS A
		INNER JOIN [dwh].[CT_GeoNode_Closure] AS B ON A.geoNodeId = B.parent
		)

select * from [dm].[view_dim_org_to_geonode_corrected];
select organisationId, count(DISTINCT geoNodeId) from [dm].[view_dim_org_to_geonode_corrected] group by organisationId;
select * from [dm].[view_dim_geonode_to_entities];