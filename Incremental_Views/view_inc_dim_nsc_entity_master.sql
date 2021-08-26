/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_dim_nsc_entity_master]    Script Date: 22/07/2021 7:38:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 10th Feb, 2021
 PURPOSE    : NSC EntityMaster Model
 Modified	: Shubham Mishra On 8th June // isPartOfAgripreneurship data type change
 *******************************************/
--DROP VIEW dm.view_inc_dim_nsc_entity_master;
CREATE VIEW [dm].[view_inc_dim_nsc_entity_master]
AS
(
		SELECT DISTINCT A.entityId AS entityId
			,ISNULL(A.externalSystemId, '') AS externalSystemId
			,ISNULL(A.entityType, '') AS entityType
			,ISNULL(F.label, '') AS entityTypeTxt
			,ISNULL(A.STATUS, '') AS entityStatus
			,ISNULL(E.label, '') AS entityStatusTxt
			,ISNULL(A.name, '') AS entityName
			,CAST(A.[coordinates.longX] AS FLOAT(53)) AS longX
			,CAST(A.[coordinates.latY] AS FLOAT(53)) AS latY
			,CAST(A.altZ AS FLOAT(53)) AS altZ
			,ISNULL(CAST(A.nestleOwned AS BIT), 0) AS nestleOwned
			,ISNULL(A.ownershipType, '') AS ownershipType
			,ISNULL(G.label, '') AS ownershipTypeTxt
			,CAST(A.foundationYear AS INT) AS foundationYear
			,CAST(FORMAT(cast(A.relationshipDate AS DATE), 'yyyyMMdd') AS INT) AS relationshipDateKey
			,CAST(A.relationshipDate AS DATE) AS relationshipDate
			,ISNULL(CAST(A.nurseryOnSite AS BIT), 0) AS nurseryOnSite
			,ISNULL(CAST(A.millOnSite AS BIT), 0) AS millOnSite
			,ISNULL(A.isPartOfAgripreneurship, 'N/A') AS isPartOfAgripreneurship
			,CASE 
				WHEN A.locationVerified = 0
					OR A.locationVerified IS NULL
					THEN CAST(0 AS BIT)
				ELSE CAST(1 AS BIT)
				END AS locationVerified
			,CASE 
				WHEN A.[coordinates.longX] IS NOT NULL
					AND A.[coordinates.latY] IS NOT NULL
					AND A.[coordinates.longX] >= - 180
					AND A.[coordinates.longX] <= 180
					AND A.[coordinates.latY] >= - 90
					AND A.[coordinates.latY] <= 90
					THEN CAST(1 AS BIT)
				ELSE CAST(0 AS BIT)
				END AS isValidCoordinates
			,ISNULL(B.status4C, '') AS status4C
			,ISNULL(H.label, '') AS status4CTxt
			,CAST(A.AAAEntryYear AS INT) AS AAAEntryYear
			,CAST(FORMAT(cast(A.AAAEnrolmentDate AS DATE), 'yyyyMMdd') AS INT) AS AAAEnrolmentDateKey
			,CAST(A.AAAEnrolmentDate AS DATE) AS AAAEnrolmentDate
			,ISNULL(A.AAAStatus, '') AS AAAStatus
			,ISNULL(M.label, '') AS AAAStatusTxt
			,ISNULL(B.license4C, '') AS license4C
			,ISNULL(C.externalSystemId, '') AS unit4C
			,ISNULL(D.sub_cluster_name, '') AS subcluster_name
			,ISNULL(D.cluster_name, '') AS cluster_name
			,ISNULL(D.country_name, '') AS country_name
		FROM [dwh].[ET_Entity] AS A WITH (NOLOCK)
		INNER JOIN dm.dim_geonode_flat AS D WITH (NOLOCK) ON A.geoNodeId = D.geoNodeId
			AND D.cluster_lob IN (
				'NESCAFE'
				,'GLOBAL'
				)
		AND A.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'ET' and sqltablename = 'Entity')
		LEFT OUTER JOIN [dwh].[MT_FarmSummary] AS B WITH (NOLOCK) ON A.entityId = B.entityId
			AND A.STATUS != 'DELETED'
		LEFT OUTER JOIN dwh.ET_Group AS C WITH (NOLOCK) ON B.latest4CGroupId = C.groupId
			AND C.type = 'CERTIFICATION'
			AND C.certificationType = '4C'
		LEFT OUTER JOIN dwh.CT_ListOption_Txt AS E WITH (NOLOCK) ON A.STATUS = E.itemCode
			AND E.setId = 'ENTITY_STATUS'
			AND E.LANGUAGE = 'E'
		LEFT OUTER JOIN dwh.CT_ListOption_Txt AS F WITH (NOLOCK) ON A.entityType = F.itemCode
			AND F.setId = 'ENTITY_TYPE'
			AND F.LANGUAGE = 'E'
		LEFT OUTER JOIN dwh.CT_ListOption_Txt AS G WITH (NOLOCK) ON A.ownershipType = G.itemCode
			AND G.setId = 'OWNERSHIP_TYPE'
			AND G.LANGUAGE = 'E'
		LEFT OUTER JOIN dwh.CT_ListOption_Txt AS H WITH (NOLOCK) ON B.status4C = H.itemCode
			AND H.setId = '4C_STATUS'
			AND H.LANGUAGE = 'E'
		LEFT OUTER JOIN dwh.CT_ListOption_Txt AS M WITH (NOLOCK) ON A.AAAStatus = M.itemCode
			AND M.setId = 'AAA_LEVEL'
			AND M.LANGUAGE = 'E'
		);
GO