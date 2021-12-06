SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 19th Nov, 2021
 PURPOSE    : OpenSC Model Nespresso
 *******************************************/
--drop view opensc.[view_dim_nsp_osc_entity]
CREATE VIEW [opensc].[view_dim_nsp_osc_entity]
AS
(
			SELECT distinct O.entityId
				,Entity.externalSystemId
				,Entity.name
				,Entity.entityType
				,ISNULL(Entity.ownershipType, '') AS ownershipType
				,CAST(Entity.[coordinates.longX] AS FLOAT(53)) AS longX
				,CAST(Entity.[coordinates.latY] AS FLOAT(53)) AS latY
				,CAST(Entity.altZ AS FLOAT(53)) AS altZ
				,CASE 
					WHEN Entity.locationVerified = 0
						OR Entity.locationVerified IS NULL
						THEN CAST(0 AS BIT)
					ELSE CAST(1 AS BIT)
					END AS locationVerified
				,CASE 
					WHEN Entity.[coordinates.longX] IS NOT NULL
						AND Entity.[coordinates.latY] IS NOT NULL
						AND Entity.[coordinates.longX] >= - 180
						AND Entity.[coordinates.longX] <= 180
						AND Entity.[coordinates.latY] >= - 90
						AND Entity.[coordinates.latY] <= 90
						THEN CAST(1 AS BIT)
					ELSE CAST(0 AS BIT)
					END AS isValidCoordinates
				,Geo.sub_cluster_name AS subClusterName
				,Geo.cluster_name AS clusterName
				,Geo.country_name AS countryName
				,Entity.STATUS
				,Entity.AAAEntryYear
				,Entity.AAAEnrolmentDate
				,Entity.AAAStatus
				,Entity.millOnSite
				,Entity.nurseryOnSite
				,Entity.[addressInfo.address1] AS addressInfo_address1
				,Entity.[addressInfo.address2] AS addressInfo_address2
				,Entity.[addressInfo.city] AS addressInfo_city
				,Entity.[addressInfo.district] AS addressInfo_district
				,Entity.[addressInfo.province] AS addressInfo_province
				,Entity.[addressInfo.countryCode] AS addressInfo_countryCode
				,Entity.[addressInfo.zipcode] AS addressInfo_zipcode
				,E.numberOfPlots
				,E.totalPlotArea
				,E.areaUoM AS plotAreaUoM
				,G.[Farm Area (Ha)]
				,G.[Coffee Area (Ha)]
				,E.totalNumberOfTrees
				,E.avgNumberOfStemsPerTree
				,E.avgRenovationPercent
				,E.avgReplantPercent
				,E.avgRejunvenationPercent
				,E.averageAge
				,E.avgTreesDensity
				,F.varietyDetails
			FROM [dwh].[OT_Delivery] AS O 
			INNER JOIN [dwh].[ET_Entity] AS Entity 
			ON O.entityId = Entity.entityId
			AND Entity.status = 'ACTIVE'
			AND O.lineOfBusiness IN (
				'NESPRESSO'
				,'GLOBAL'
				)
			INNER JOIN dm.dim_geonode_flat AS Geo ON Entity.geonodeId = Geo.geoNodeId
			AND Geo.country_name IN ('DR Congo')
			LEFT JOIN [dm].[view_dim_entity_plot_summary] AS E ON Entity.entityId = E.entityId
			LEFT JOIN [dm].[view_dim_entity_variety_details] AS F ON Entity.entityId = F.entityId
			LEFT JOIN [dm].[view_fact_entity_metrics_summary] AS G ON Entity.entityId = G.entityId
				AND G.isLatest = 1
);

drop table [opensc].[dim_nsp_osc_entity];

select *
INTO [opensc].[dim_nsp_osc_entity]
from [opensc].[view_dim_nsp_osc_entity];

ALTER TABLE [opensc].[dim_nsp_osc_entity] ALTER COLUMN entityId VARCHAR(50) NOT NULL;
ALTER TABLE [opensc].[dim_nsp_osc_entity] ADD CONSTRAINT pk_nsp_osc_entity PRIMARY KEY(entityId);

select count(*) from [opensc].[dim_nsp_osc_entity]; --2034
select count(*) from [opensc].[view_dim_nsp_osc_entity]; --2034



