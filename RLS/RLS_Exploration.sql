--Nescafe_IN - GeoNode mapping : TL, KA, KL
select * from [dwh].[CT_OrgToGeoNode]
where organisationId = 'NESCAFE_IN'

select * from [dwh].[CT_GeoNode]
where parentId IN ('R_IN_1', 'R_IN_2', 'R_IN_3')

select * from [dwh].[ET_Entity] AS A
INNER JOIN [dwh].[CT_GeoNode] AS B ON A.geoNodeId = B.geoNodeId
where B.parentId IN ('R_IN_1', 'R_IN_2', 'R_IN_3')

select * from [dwh].[ET_Entity] AS A
INNER JOIN [dwh].[CT_GeoNode] AS B ON A.geoNodeId = B.geoNodeId
where B.geoNodeId IN ('R_IN_1', 'R_IN_2', 'R_IN_3')

select distinct B.geoNodeType 
from [dwh].[CT_OrgToGeoNode] AS A
INNER JOIN [dwh].[CT_GeoNode] AS B
ON A.geoNodeId = B.geoNodeId

select organisationId
from [dwh].[CT_OrgToGeoNode] AS A
INNER JOIN [dwh].[CT_GeoNode] AS B
ON A.geoNodeId = B.geoNodeId
AND B.geoNodeType = 'SUB_CLUSTER'

select * from [dm].[view_geonode_flat] where country_name = 'India' AND Cluster_lob IN ('GLOBAL','NESCAFE')

select distinct criteriaId from [dwh].[AT_Observation] AS A
INNER JOIN [dwh].[ET_Entity] AS B ON A.entityId = B.entityId
INNER JOIN [dwh].[CT_GeoNode] AS C ON C.geoNodeId = B.geoNodeId
AND C.geoNodeId IN ('SR_IN_1_1', 'SR_IN_1_2', 'SR_IN_1_3', 'SR_IN_1_4', 'SR_IN_2_1', 'SR_IN_2_2', 'SR_IN_3_1', 'SR_IN_3_2')

select * from [dwh].[CT_GeoNode_Closure] where parent IN ('R_IN_1', 'R_IN_2', 'R_IN_3')
[dwh].[CT_Organisation_Closure]