SELECT E.geoNodeId AS GeoNodeId
	,E.geoNodeType AS Type
	,E.name AS Name
	,A.geoNodeId AS Sub_Cluster
	,A.name AS Sub_Cluster_Name
	,A.status AS Sub_Cluster_Status
	,B.geoNodeId AS Cluster
	,B.name AS Cluster_Name
	,B.status AS Cluster_Status
	,B.lineOfBusiness AS Cluster_lob
	,C.geoNodeId AS Country
	,C.name AS Country_Name
	,C.status AS Country_Status
    ,C.countryCode AS countryCode
    ,C.currencyCode AS currencyCode
FROM dwh.CT_GeoNode AS E
INNER JOIN dwh.CT_GeoNode AS A 
	ON E.geoNodeId = A.geoNodeId
	AND A.geoNodeType = 'SUB_CLUSTER'
LEFT OUTER JOIN dwh.CT_GeoNode AS B 
	ON A.parentId = B.geoNodeId
	AND B.geoNodeType = 'CLUSTER'
LEFT OUTER JOIN dwh.CT_GeoNode AS C 
	ON B.parentId = C.geoNodeId
	AND C.geoNodeType = 'COUNTRY'

UNION

SELECT E.geoNodeId AS GeoNodeId
	,E.geoNodeType AS Type
	,E.name AS Name
	,NULL AS Sub_Cluster
	,NULL AS Sub_Cluster_Name
	,NULL AS Sub_Cluster_Status
	,F.geoNodeId AS Cluster
	,F.name AS Cluster_Name
	,F.status AS Cluster_Status
	,F.lineOfBusiness AS Cluster_lob
	,G.geoNodeId AS Country
	,G.name AS Country_Name
	,G.status AS Country_Status
    ,G.countryCode AS countryCode
    ,G.currencyCode AS currencyCode
FROM dwh.CT_GeoNode AS E
INNER JOIN dwh.CT_GeoNode AS F 
	ON E.geoNodeId = F.geoNodeId
	AND F.geoNodeType = 'CLUSTER'
	AND F.geoNodeId != E.parentId
LEFT OUTER JOIN dwh.CT_GeoNode AS G 
	ON F.parentId = G.geoNodeId
	AND G.geoNodeType = 'COUNTRY'

UNION

SELECT E.geoNodeId AS GeoNodeId
	,E.geoNodeType AS Type
	,E.name AS Name
	,NULL AS Sub_Cluster
	,NULL AS Sub_Cluster_Name
	,NULL AS Sub_Cluster_Status
	,NULL AS Cluster
	,NULL AS Cluster_Name
	,NULL AS Cluster_Status
	,NULL AS Cluster_lob
	,H.geoNodeId AS Country
	,H.name AS Country_Name
	,H.status AS Country_Status
    ,H.countryCode AS countryCode
    ,H.currencyCode AS currencyCode
FROM dwh.CT_GeoNode AS E
INNER JOIN dwh.CT_GeoNode AS H 
	ON E.geoNodeId = H.geoNodeId
	AND H.geoNodeType = 'COUNTRY'
	AND H.geoNodeId != E.parentId

UNION

SELECT E.geoNodeId AS GeoNodeId
	,E.geoNodeType AS Type
	,E.name AS Name
	,NULL AS Sub_Cluster
	,NULL AS Sub_Cluster_Name
	,NULL AS Sub_Cluster_Status
	,NULL AS Cluster
	,NULL AS Cluster_Name
	,NULL AS Cluster_Status
	,NULL AS Cluster_lob
	,I.geoNodeId AS Country
	,I.name AS Country_Name
	,I.status AS Country_Status
    ,I.countryCode AS countryCode
    ,I.currencyCode AS currencyCode
FROM dwh.CT_GeoNode AS E
INNER JOIN dwh.CT_GeoNode AS I 
	ON E.geoNodeId = I.geoNodeId
	AND I.geoNodeType = 'GLOBAL';


CREATE INDEX ct_geonode_idx_geonodetype_geonodeid ON CT_GeoNode (geoNodeType,geoNodeId);
select COUNT(*) from dwh.CT_GeoNode