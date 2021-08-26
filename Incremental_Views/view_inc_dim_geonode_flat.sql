/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_dim_geonode_flat]    Script Date: 22/07/2021 10:25:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 23rd March, 2021
 PURPOSE    : RLS 
 *******************************************/
--drop view [dm].[view_inc_dim_geonode_flat]
CREATE VIEW [dm].[view_inc_dim_geonode_flat]
AS
SELECT E.geoNodeId AS GeoNodeId
	,E.geoNodeType AS Type
	,E.name AS Name
	,A.geoNodeId AS Sub_Cluster
	,A.name AS Sub_Cluster_Name
	,A.STATUS AS Sub_Cluster_Status
	,B.geoNodeId AS Cluster
	,B.name AS Cluster_Name
	,B.STATUS AS Cluster_Status
	,B.lineOfBusiness AS Cluster_lob
	,C.geoNodeId AS Country
	,C.name AS Country_Name
	,C.STATUS AS Country_Status
	,C.countryCode AS countryCode
	,C.currencyCode AS currencyCode
FROM dwh.CT_GeoNode AS E
INNER JOIN dwh.CT_GeoNode AS A ON E.geoNodeId = A.geoNodeId
	AND A.geoNodeType = 'SUB_CLUSTER'
AND E.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'CT' and sqltablename = 'GeoNode')
LEFT OUTER JOIN dwh.CT_GeoNode AS B ON A.parentId = B.geoNodeId
	AND B.geoNodeType = 'CLUSTER'
LEFT OUTER JOIN dwh.CT_GeoNode AS C ON B.parentId = C.geoNodeId
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
	,F.STATUS AS Cluster_Status
	,F.lineOfBusiness AS Cluster_lob
	,G.geoNodeId AS Country
	,G.name AS Country_Name
	,G.STATUS AS Country_Status
	,G.countryCode AS countryCode
	,G.currencyCode AS currencyCode
FROM dwh.CT_GeoNode AS E
INNER JOIN dwh.CT_GeoNode AS F ON E.geoNodeId = F.geoNodeId
	AND F.geoNodeType = 'CLUSTER'
	AND F.geoNodeId != E.parentId
AND E.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'CT' and sqltablename = 'GeoNode')
LEFT OUTER JOIN dwh.CT_GeoNode AS G ON F.parentId = G.geoNodeId
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
	,H.STATUS AS Country_Status
	,H.countryCode AS countryCode
	,H.currencyCode AS currencyCode
FROM dwh.CT_GeoNode AS E
INNER JOIN dwh.CT_GeoNode AS H ON E.geoNodeId = H.geoNodeId
	AND H.geoNodeType = 'COUNTRY'
	AND H.geoNodeId != E.parentId
AND E.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'CT' and sqltablename = 'GeoNode')

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
	,I.STATUS AS Country_Status
	,I.countryCode AS countryCode
	,I.currencyCode AS currencyCode
FROM dwh.CT_GeoNode AS E
INNER JOIN dwh.CT_GeoNode AS I ON E.geoNodeId = I.geoNodeId
	AND I.geoNodeType = 'GLOBAL';
AND A.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'CT' and sqltablename = 'GeoNode')
GO