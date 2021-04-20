/*******************************************
 Author     : Shubham Mishra
 Created On : 22nd March, 2021
 PURPOSE    : EntityMaster Model for Nespresso
 Modified On: 20th April, 2021 for including MT.FarmSummary columns, removing nescafe specific columns and removing the itemCode columns

 *******************************************/
--DROP VIEW dm.view_nsp_entity_master;
CREATE VIEW dm.view_nsp_entity_master
AS
(
		SELECT DISTINCT A.entityId AS entityId
			,ISNULL(A.externalSystemId, '') AS externalSystemId
			,ISNULL(F.label, '') AS entityType
			,ISNULL(E.label, '') AS entityStatus
			,ISNULL(A.name, '') AS entityName
			,CAST(A.[coordinates.longX] AS FLOAT(53)) AS longX
			,CAST(A.[coordinates.latY] AS float(53)) AS latY
			,CAST(A.altZ AS FLOAT(53)) AS altZ
			,ISNULL(G.label, '') AS ownershipType
			,CAST(FORMAT(cast(A.relationshipDate AS DATE), 'yyyyMMdd') AS int) AS relationshipDateKey
			,CAST(A.relationshipDate AS DATE) AS relationshipDate
			,ISNULL(CAST(A.nurseryOnSite AS BIT), 0) AS nurseryOnSite
			,ISNULL(CAST(A.millOnSite AS BIT), 0) AS millOnSite
			,ISNULL(N.label, '') AS coreAssessmentStatus
			,B.totalArea
			,B.arabicaProduction
			,B.robustaProduction
			,B.bourbonProduction
			,B.totalProduction
			,B.totalYield
			,B.numInteractions
			,B.numReceivedPlantlet
			,B.TotalNoofCoreNC
			,B.coffeeArea
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
					THEN CAST(1 AS bit)
				ELSE CAST(0 AS bit)
				END AS isValidCoordinates
			,CAST(A.AAAEntryYear AS INT) AS AAAEntryYear
			,CAST(FORMAT(cast(A.AAAEnrolmentDate AS DATE), 'yyyyMMdd') AS INT) AS AAAEnrolmentDateKey
			,CAST(A.AAAEnrolmentDate AS DATE) AS AAAEnrolmentDate
			,ISNULL(M.label, '') AS AAAStatus
			,ISNULL(D.subClusterName, '') AS subClusterName
			,ISNULL(D.clusterName, '') AS clusterName
			,ISNULL(D.countryName, '') AS countryName
		FROM [dwh].[ET_Entity] AS A WITH (NOLOCK)
		LEFT OUTER JOIN [dwh].[MT_FarmSummary] AS B WITH (NOLOCK) ON A.entityId = B.entityId
			AND A.STATUS != 'DELETED'
		LEFT OUTER JOIN dwh.ET_Group AS C WITH (NOLOCK) ON B.latest4CGroupId = C.groupId
			AND C.type = 'CERTIFICATION'
			AND C.certificationType = '4C'
		INNER JOIN dm.dim_nsp_geonode_flat AS D WITH (NOLOCK) ON A.geoNodeId = D.geoNodeId
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
		LEFT OUTER JOIN dwh.CT_ListOption_Txt AS N WITH (NOLOCK) ON B.coreAssessmentStatus = N.itemCode
			AND N.setId = 'CORE_ASSESSMENT_STATUS'
			AND N.LANGUAGE = 'E'
		);

drop table [dm].[dim_nsp_entity_master];

SELECT
  *
INTO [dm].[dim_nsp_entity_master]
FROM [dm].[view_nsp_entity_master];


ALTER TABLE [dm].[dim_nsp_entity_master]
ADD CONSTRAINT nspEntiyMaster_pk PRIMARY KEY (entityId);

select count(*) from [dm].[view_nsp_entity_master];
select * from [dm].[dim_nsp_entity_master];
select distinct countryName from [dm].[dim_nsp_entity_master] order by countryName;
select distinct countryName from dm.dim_nsp_geonode_flat where cluster IS NOT NULL OR subCluster IS NOT NULL
select externalSystemId, count(*) from [dm].[dim_nsp_entity_master] group by externalSystemId

select COUNT(*) from [dm].[dim_nsp_entity_master]
select COUNT(*) from [dm].[dim_entity_master]

