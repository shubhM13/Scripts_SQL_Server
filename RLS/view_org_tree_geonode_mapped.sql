SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 23rd March, 2021
 PURPOSE    : RLS 
 *******************************************/
--drop view [dm].[view_org_tree_geonode_mapped]
CREATE VIEW [dm].[view_org_tree_geonode_mapped]
AS
SELECT A.*
	  ,'(' + C.name + ',' + C.country_name + ')' AS countryMapping
FROM [dm].[view_nsc_org_tree] AS A
LEFT JOIN [dwh].[CT_OrgToGeoNode] AS B ON A.organisationId = B.organisationId
LEFT JOIN dm.view_geonode_flat AS C ON C.geoNodeId = B.geoNodeId
GO

select * from [dm].[view_org_tree_geonode_mapped] order by tree

select organisationIndent
	   ,name
	   ,parentId
	   ,STUFF((
				SELECT ',' + countryMapping
				FROM [dm].[view_org_tree_geonode_mapped]
				WHERE organisationIndent = A.organisationIndent
				FOR XML PATH('')
				), 1, 1, '') AS countryMappings
	  ,Tree
from [dm].[view_org_tree_geonode_mapped] AS A
GROUP BY organisationIndent, name, parentId, Tree
ORDER BY Tree

