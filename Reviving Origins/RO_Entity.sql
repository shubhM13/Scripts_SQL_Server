SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 11th Oct, 2021
 PURPOSE    : Reviving Model Nespresso
 *******************************************/
--drop view dm.[view_dim_nsp_ro_entity]
CREATE VIEW [dm].[view_dim_nsp_ro_entity]
AS
(
			SELECT distinct Entity.entityId
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
				,Geo.country_name AS subClusterName
				,Geo.cluster_name AS clusterName
				,Geo.sub_cluster_name AS countryName
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
			FROM [dwh].[OT_Delivery] AS O 
			INNER JOIN [dwh].[ET_Entity] AS Entity 
			ON O.entityId = Entity.entityId
			AND O.lineOfBusiness IN (
				'NESPRESSO'
				,'GLOBAL'
				)
			LEFT JOIN dm.dim_geonode_flat AS Geo ON Entity.geonodeId = Geo.geoNodeId
);

drop table [aaa].[dim_nsp_ro_entity];

select *
INTO [aaa].[dim_nsp_ro_entity]
from [dm].[view_dim_nsp_ro_entity];

ALTER TABLE [aaa].[dim_nsp_ro_entity] ALTER COLUMN entityId VARCHAR(50) NOT NULL;
ALTER TABLE [aaa].[dim_nsp_ro_entity] ADD CONSTRAINT pk_nsp_ro_entity PRIMARY KEY(entityId);

select * from [aaa].[dim_nsp_ro_entity];



