/****** Object:  View [dm].[view_fact_nsp_reviving_origins]    Script Date: 04-10-2021 08:22:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/*******************************************
 Author     : Shubham Mishra
 Created On : 24th Aug, 2021
 PURPOSE    : Reviving Model Nespresso
 *******************************************/
--drop view dm.[view_fact_nsp_reviving_origins]
ALTER VIEW [dm].[view_fact_nsp_reviving_origins]
AS
(
		SELECT DISTINCT A.deliveryNumber
			,A.deliveryDate
			,A.location AS deliveryLocation
			,A.purchasingPoint
			,A.purchaseCertified
			,A.purchaseDate
			,A.harvestPeriod
			,A.coffeeSpecie
			,A.coffeeState
			,A.physicalQuality
			,A.cupQuality
			,A.deliveredQuantity
			,L.label AS deliveredUnit
			,A.purchaseAAAPremium
			,A.purchaseBENPremium
			,B.externalSystemId AS farmBusinessId
			,B.name AS farmName
			,B.entityType
			,ISNULL(B.ownershipType, '') AS ownershipType
			,CAST(B.[coordinates.longX] AS FLOAT(53)) AS longX
			,CAST(B.[coordinates.latY] AS FLOAT(53)) AS latY
			,CAST(B.altZ AS FLOAT(53)) AS altZ
			,CASE 
				WHEN B.locationVerified = 0
					OR B.locationVerified IS NULL
					THEN CAST(0 AS BIT)
				ELSE CAST(1 AS BIT)
				END AS locationVerified
			,CASE 
				WHEN B.[coordinates.longX] IS NOT NULL
					AND B.[coordinates.latY] IS NOT NULL
					AND B.[coordinates.longX] >= - 180
					AND B.[coordinates.longX] <= 180
					AND B.[coordinates.latY] >= - 90
					AND B.[coordinates.latY] <= 90
					THEN CAST(1 AS BIT)
				ELSE CAST(0 AS BIT)
				END AS isValidCoordinates
			,B.sub_cluster_name as subClusterName
			,B.cluster_name as clusterName
			,B.country_name as countryName
			,B.STATUS AS entityStatus
			,CAST(B.AAAEntryYear AS INT) AS AAAEntryYear
			,CAST(B.AAAEnrolmentDate AS DATE) AS AAAEnrolmentDate
			,ISNULL(B.AAAStatus, '') AS AAAStatus
			,B.millOnSite
			,B.nurseryOnSite
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
			,B.[addressInfo.address1] AS addressInfo_address1
			,B.[addressInfo.address2] AS addressInfo_address2
			,B.[addressInfo.city] AS addressInfo_city
			,B.[addressInfo.district] AS addressInfo_district
			,B.[addressInfo.province] AS addressInfo_province
			,B.[addressInfo.countryCode] AS addressInfo_countryCode
			,B.[addressInfo.zipcode] AS addressInfo_zipcode
			,(C.[personInfo.firstName] + ' ' + C.[personInfo.lastName]) AS primaryContactName
			,C.yearStartedFarming
			,C.relationToEntity
			,C.yearOfBirth
			,C.[personInfo.gender] as personInfo_gender
			,C.[personInfo.maritalStatus] AS personInfo_maritalStatus
			,C.educationLevel
			,C.yearsOfSchooling
			,C.worksWithCoffee
			,C.livesAt
			,D.attachmentId
			,D.binaryObject
			,D.fileSize
			,D.mimeType
		FROM [dwh].[OT_Delivery] AS A
		LEFT JOIN [dm].[dim_list_option] AS L ON A.deliveredUnit = L.itemCode
		AND L.setId = 'UOM'
		LEFT JOIN (
			SELECT Entity.entityId
				,Entity.externalSystemId
				,Entity.name
				,Entity.entityType
				,Entity.ownershipType
				,Entity.[coordinates.longX]
				,Entity.[coordinates.latY]
				,Entity.altZ
				,Entity.locationVerified
				,Geo.country_name
				,Geo.cluster_name
				,Geo.sub_cluster_name
				,Entity.STATUS
				,Entity.AAAEntryYear
				,Entity.AAAEnrolmentDate
				,Entity.AAAStatus
				,millOnSite
				,nurseryOnSite
				,[addressInfo.address1]
				,[addressInfo.address2]
				,[addressInfo.city]
				,[addressInfo.province]
				,[addressInfo.district]
				,[addressInfo.zipcode]
				,[addressInfo.countryCode]
			FROM [dwh].[ET_Entity] AS Entity
			LEFT JOIN dm.dim_geonode_flat AS Geo ON Entity.geonodeId = Geo.geoNodeId
			) AS B ON A.entityId = B.entityId
			AND A.deliveryNumber IS NOT NULL
			AND A.lineOfBusiness IN (
				'NESPRESSO'
				,'GLOBAL'
				)
		LEFT JOIN (
			SELECT *
			FROM (
				SELECT P1.[personInfo.firstName]
					,P1.[personInfo.lastName]
					,P1.entityId
					,P1.primaryIndicator
					,P1.ExternalSystemId AS personExternalSystemId
					,P1.[personInfo.gender]
					,P1.relationToEntity
					,P1.yearOfBirth
					,P1.yearStartedFarming
					,P1.yearsOfSchooling
					,P1.educationLevel
					,P1.worksWithCoffee
					,P1.[personInfo.maritalStatus]
					,P1.livesAt
					,rank() OVER (
						PARTITION BY entityId ORDER BY [auditInfo.modifiedOn] DESC
						) AS rnk
				FROM dwh.[ET_Person] AS P1
				WHERE P1.STATUS = 'ACTIVE'
					AND P1.primaryIndicator = 1
				) AS p2
			WHERE p2.rnk = 1
			) AS C ON C.entityId = A.entityId
		LEFT JOIN (
			SELECT *
			FROM (
				SELECT attachmentId
					,binaryObject
					,mimeType
					,fileName
					,title
					,fileSize
					,owningRecordId
					,rank() OVER (
						PARTITION BY owningRecordId ORDER BY [auditInfo.createdOn]
							,attachmentId DESC
						) AS rnk
				FROM dwh.[CT_Attachment]
				WHERE owningRecordType = 'ENTITY'
					AND primaryIndicator = 1
					AND documentType = 'PHOTO'
				) AS AT
			WHERE AT.rnk = 1
			) AS D ON D.owningRecordId = A.entityId
		LEFT JOIN [dm].[view_dim_entity_plot_summary] AS E ON A.entityId = E.entityId
		LEFT JOIN [dm].[view_dim_entity_variety_details] AS F ON A.entityId = F.entityId
		LEFT JOIN [dm].[view_fact_entity_metrics_summary] AS G ON A.entityId = G.entityId
		AND isLatest = 1
		WHERE B.status = 'ACTIVE'
		)
GO

select * from [dm].[view_fact_nsp_reviving_origins];

