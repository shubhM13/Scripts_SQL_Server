/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_dim_nsp_geonode_flat]    Script Date: 22/07/2021 6:33:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 23rd March, 2021
 PURPOSE    : Nespresso Dataset
 *******************************************/
--drop view [dm].[view_inc_dim_nsp_geonode_flat]
CREATE VIEW [dm].[view_inc_dim_nsp_geonode_flat]
AS
SELECT E.geoNodeId AS geoNodeId
	,E.geoNodeType AS type
	,E.name AS name
	,E.STATUS AS STATUS
	,A.geoNodeId AS subCluster
	,A.name AS subClusterName
	,B.geoNodeId AS cluster
	,B.name AS clusterName
	,C.geoNodeId AS country
	,C.name AS countryName
	,C.countryCode AS countryCode
	,C.currencyCode AS currencyCode
FROM dwh.CT_GeoNode AS E
INNER JOIN dwh.CT_GeoNode AS A ON E.geoNodeId = A.geoNodeId
	AND E.lineOfBusiness IN (
		'NESPRESSO'
		,'GLOBAL'
		)
	AND A.geoNodeType = 'SUB_CLUSTER'
AND E.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'CT' and sqltablename = 'GeoNode')
LEFT OUTER JOIN dwh.CT_GeoNode AS B ON A.parentId = B.geoNodeId
	AND B.geoNodeType = 'CLUSTER'
LEFT OUTER JOIN dwh.CT_GeoNode AS C ON B.parentId = C.geoNodeId
	AND C.geoNodeType = 'COUNTRY'

UNION

SELECT E.geoNodeId AS geoNodeId
	,E.geoNodeType AS type
	,E.name AS name
	,E.STATUS AS STATUS
	,NULL AS subCluster
	,NULL AS subClusterName
	,F.geoNodeId AS cluster
	,F.name AS clusterName
	,G.geoNodeId AS country
	,G.name AS countryName
	,G.countryCode AS countryCode
	,G.currencyCode AS currencyCode
FROM dwh.CT_GeoNode AS E
INNER JOIN dwh.CT_GeoNode AS F ON E.geoNodeId = F.geoNodeId
	AND E.lineOfBusiness IN (
		'NESPRESSO'
		,'GLOBAL'
		)
	AND F.geoNodeType = 'CLUSTER'
	AND F.geoNodeId != E.parentId
AND E.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'CT' and sqltablename = 'GeoNode')
LEFT OUTER JOIN dwh.CT_GeoNode AS G ON F.parentId = G.geoNodeId
	AND G.geoNodeType = 'COUNTRY'

UNION

SELECT E.geoNodeId AS geoNodeId
	,E.geoNodeType AS type
	,E.name AS name
	,E.STATUS AS STATUS
	,NULL AS subCluster
	,NULL AS subClusterName
	,NULL AS cluster
	,NULL AS clusterName
	,H.geoNodeId AS country
	,H.name AS countryName
	,H.countryCode AS countryCode
	,H.currencyCode AS currencyCode
FROM dwh.CT_GeoNode AS E
INNER JOIN dwh.CT_GeoNode AS H ON E.geoNodeId = H.geoNodeId
	AND E.lineOfBusiness IN (
		'NESPRESSO'
		,'GLOBAL'
		)
	AND H.geoNodeType = 'COUNTRY'
	AND H.geoNodeId != E.parentId
AND E.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'CT' and sqltablename = 'GeoNode')

UNION

SELECT E.geoNodeId AS geoNodeId
	,E.geoNodeType AS type
	,E.name AS name
	,E.STATUS AS STATUS
	,NULL AS subCluster
	,NULL AS subClusterName
	,NULL AS cluster
	,NULL AS clusterName
	,I.geoNodeId AS country
	,I.name AS countryName
	,I.countryCode AS countryCode
	,I.currencyCode AS currencyCode
FROM dwh.CT_GeoNode AS E
INNER JOIN dwh.CT_GeoNode AS I ON E.geoNodeId = I.geoNodeId
	AND E.lineOfBusiness IN (
		'NESPRESSO'
		,'GLOBAL'
		)
	AND I.geoNodeType = 'GLOBAL'
AND E.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'CT' and sqltablename = 'GeoNode')
GO