SELECT E."geoNodeId" AS "GeoNodeId"
	,E."geoNodeType" AS "Type"
	,A."geoNodeId" AS "Sub_Cluster"
	,A."name" AS "Sub_Cluster_Name"
	,A."status" AS "Sub_Cluster_Status"
	,B."geoNodeId" AS "Cluster"
	,B."name" AS "Cluster_Name"
	,B."status" AS "Cluster_Status"
	,B."lineOfBusiness" AS "Cluster_lob"
	,C."geoNodeId" AS "Country"
	,C."name" AS "Country_Name"
	,C."status" AS "Country_Status"
FROM "nestle.dev.glb.farms.data.structure::CT.GeoNode" AS E
INNER JOIN "nestle.dev.glb.farms.data.structure::CT.GeoNode" AS A -- sub clusters
	ON E."geoNodeId" = A."geoNodeId"
	AND A."geoNodeType" = 'SUB_CLUSTER'
LEFT OUTER JOIN "nestle.dev.glb.farms.data.structure::CT.GeoNode" AS B -- sub cluster parent cluster
	ON A."parentId" = B."geoNodeId"
	AND B."geoNodeType" = 'CLUSTER'
LEFT OUTER JOIN "nestle.dev.glb.farms.data.structure::CT.GeoNode" AS C -- sub cluster parent country
	ON B."parentId" = C."geoNodeId"
	AND C."geoNodeType" = 'COUNTRY'

UNION

SELECT E."geoNodeId" AS "GeoNodeId"
	,E."geoNodeType" AS "Type"
	,NULL AS "Sub_Cluster"
	,NULL AS "Sub_Cluster_Name"
	,NULL AS "Sub_Cluster_Status"
	,F."geoNodeId" AS "Cluster"
	,F."name" AS "Cluster_Name"
	,F."status" AS "Cluster_Status"
	,F."lineOfBusiness" AS "Cluster_lob"
	,G."geoNodeId" AS "Country"
	,G."name" AS "Country_Name"
	,G."status" AS "Country_Status"
FROM "nestle.dev.glb.farms.data.structure::CT.GeoNode" AS E
INNER JOIN "nestle.dev.glb.farms.data.structure::CT.GeoNode" AS F -- cluster
	ON E."geoNodeId" = F."geoNodeId"
	AND F."geoNodeType" = 'CLUSTER'
	AND F."geoNodeId" != E."parentId"
LEFT OUTER JOIN "nestle.dev.glb.farms.data.structure::CT.GeoNode" AS G -- clusters parent country
	ON F."parentId" = G."geoNodeId"
	AND G."geoNodeType" = 'COUNTRY'

UNION

SELECT E."geoNodeId" AS "GeoNodeId"
	,E."geoNodeType" AS "Type"
	,NULL AS "Sub_Cluster"
	,NULL AS "Sub_Cluster_Name"
	,NULL AS "Sub_Cluster_Status"
	,NULL AS "Cluster"
	,NULL AS "Cluster_Name"
	,NULL AS "Cluster_Status"
	,NULL AS "Cluster_lob"
	,H."geoNodeId" AS "Country"
	,H."name" AS "Country_Name"
	,H."status" AS "Country_Status"
FROM "nestle.dev.glb.farms.data.structure::CT.GeoNode" AS E
INNER JOIN "nestle.dev.glb.farms.data.structure::CT.GeoNode" AS H -- country
	ON E."geoNodeId" = H."geoNodeId"
	AND H."geoNodeType" = 'COUNTRY'
	AND H."geoNodeId" != E."parentId"

UNION

SELECT E."geoNodeId" AS "GeoNodeId"
	,E."geoNodeType" AS "Type"
	,NULL AS "Sub_Cluster"
	,NULL AS "Sub_Cluster_Name"
	,NULL AS "Sub_Cluster_Status"
	,NULL AS "Cluster"
	,NULL AS "Cluster_Name"
	,NULL AS "Cluster_Status"
	,NULL AS "Cluster_lob"
	,I."geoNodeId" AS "Country"
	,I."name" AS "Country_Name"
	,I."status" AS "Country_Status"
FROM "nestle.dev.glb.farms.data.structure::CT.GeoNode" AS E
INNER JOIN "nestle.dev.glb.farms.data.structure::CT.GeoNode" AS I -- global
	ON E."geoNodeId" = I."geoNodeId"
	AND I."geoNodeType" = 'GLOBAL';