SELECT CASE 
		WHEN GeoNode3."geoNodeType" = 'GLOBAL'
			THEN GeoNode2."name"
		ELSE GeoNode3."name"
		END AS "Country"
	,CASE 
		WHEN GeoNode2."geoNodeType" = 'COUNTRY'
			THEN GeoNode."name"
		ELSE GeoNode2."name"
		END AS "Cluster"
	,CASE 
		WHEN GeoNode."geoNodeType" = 'CLUSTER'
			THEN ''
		ELSE GeoNode."name"
		END AS "Subcluster"
	,Entity."entityType" AS "Entity Type"
	,Entity."externalSystemId" AS "AAA ID"
	,Entity."entityId" AS "ENTITYID"
	,Entity."name" AS "Farm Name"
	,Entity."status" AS "Farm Status"
	,Entity."inactivatedOn" AS "Farm Inactivation Date"
	,Entity."AAAEntryYear" AS "Farm Entry Year"
	,Entity."AAAStatus" AS "AAA Status"
	,Person."personInfo.firstName" || ' ' || Person."personInfo.lastName" AS "Primary Contact"
	,Entity."coordinates.longX" AS "Longitude"
	,Entity."coordinates.latY" AS "Latitude"
	,Entity."altZ" AS "Altitude"
	,Entity."locationVerified" AS "Location Verified"
	,Entity."AAAEnrolmentDate" AS "AAA Enrollment Date"
	,max(RESULT_TABLE."obsDateTime") AS "Last Update Observation"
	,max(Entity."auditInfo.modifiedOn") AS "Last Update System"
	,SUM(CASE 
			WHEN "InteractionStatus" IS NOT NULL
				THEN 1
			ELSE 0
			END) AS "Total Answers"
	,SUM(CASE "InteractionStatus"
			WHEN 'COMPLETED'
				THEN 1
			ELSE 0
			END) AS "Completed Answers"
	,SUM(CASE "InteractionStatus"
			WHEN 'IN_PROGRESS'
				THEN 1
			ELSE 0
			END) AS "Draft Answers"
	,SUM(CASE "answerListSetId"
			WHEN 'ANS_COMPLIANCE'
				THEN 1
			ELSE 0
			END) AS "Total Compliance"
	,SUM(CASE "answerCode"
			WHEN 'COMPLIANT'
				THEN 1
			ELSE 0
			END) AS "Total Compliant"
	,SUM(CASE "answerCode"
			WHEN 'NON-COMPLIANT'
				THEN 1
			ELSE 0
			END) AS "Total Non-Compliant"
	,SUM(CASE "notApplicableFlag"
			WHEN 1
				THEN 1
			ELSE 0
			END) AS "Total Not Applicable"
	,SUM(CASE 
			WHEN "answerCode" = 'NON-COMPLIANT' AND "criteriaEvaluationContext" = 'PRE-REQUISITE'
				THEN 1
			ELSE 0
			END) AS "Total Non-Compliant PreRequisite"
	,CASE 
		WHEN SUM(CASE 
					WHEN "answerCode" IN ('COMPLIANT', 'NON-COMPLIANT')
						THEN 1
					ELSE 0
					END) > 0
			THEN round(SUM(CASE "answerCode"
							WHEN 'COMPLIANT'
								THEN 1
							ELSE 0
							END) / SUM(CASE 
							WHEN "answerCode" IN ('COMPLIANT', 'NON-COMPLIANT')
								THEN 1
							ELSE 0
							END), 5)
		ELSE 0
		END AS "Total Score"
	,CASE 
		WHEN SUM(CASE 
					WHEN "answerCode" IN ('COMPLIANT', 'NON-COMPLIANT') AND "classification" = 'SOCIAL'
						THEN 1
					ELSE 0
					END) > 0
			THEN round(SUM(CASE 
							WHEN "answerCode" = 'COMPLIANT' AND "classification" = 'SOCIAL'
								THEN 1
							ELSE 0
							END) / SUM(CASE 
							WHEN "answerCode" IN ('COMPLIANT', 'NON-COMPLIANT') AND "classification" = 'SOCIAL'
								THEN 1
							ELSE 0
							END), 5)
		ELSE 0
		END AS "Total Score Social"
	,CASE 
		WHEN SUM(CASE 
					WHEN "answerCode" IN ('COMPLIANT', 'NON-COMPLIANT') AND "classification" = 'PRODUCTIVITY'
						THEN 1
					ELSE 0
					END) > 0
			THEN round(SUM(CASE 
							WHEN "answerCode" = 'COMPLIANT' AND "classification" = 'PRODUCTIVITY'
								THEN 1
							ELSE 0
							END) / SUM(CASE 
							WHEN "answerCode" IN ('COMPLIANT', 'NON-COMPLIANT') AND "classification" = 'PRODUCTIVITY'
								THEN 1
							ELSE 0
							END), 5)
		ELSE 0
		END AS "Total Score Productivity"
	,CASE 
		WHEN SUM(CASE 
					WHEN "answerCode" IN ('COMPLIANT', 'NON-COMPLIANT') AND "classification" = 'ENVIRONMENT'
						THEN 1
					ELSE 0
					END) > 0
			THEN round(SUM(CASE 
							WHEN "answerCode" = 'COMPLIANT' AND "classification" = 'ENVIRONMENT'
								THEN 1
							ELSE 0
							END) / SUM(CASE 
							WHEN "answerCode" IN ('COMPLIANT', 'NON-COMPLIANT') AND "classification" = 'ENVIRONMENT'
								THEN 1
							ELSE 0
							END), 5)
		ELSE 0
		END AS "Total Score Environmental"
	,CASE 
		WHEN SUM(CASE 
					WHEN "answerCode" IN ('COMPLIANT', 'NON-COMPLIANT') AND "classification" = 'QUALITY'
						THEN 1
					ELSE 0
					END) > 0
			THEN round(SUM(CASE 
							WHEN "answerCode" = 'COMPLIANT' AND "classification" = 'QUALITY'
								THEN 1
							ELSE 0
							END) / SUM(CASE 
							WHEN "answerCode" IN ('COMPLIANT', 'NON-COMPLIANT') AND "classification" = 'QUALITY'
								THEN 1
							ELSE 0
							END), 5)
		ELSE 0
		END AS "Total Score Quality"
	,max(CASE "externalId"
			WHEN 'P1a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "P1a - Approved varieties"
	,max(CASE "externalId"
			WHEN 'P2a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "P2a - Farm map"
	,max(CASE "externalId"
			WHEN 'P2b'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "P2b - Renovation plan"
	,max(CASE "externalId"
			WHEN 'P2c'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "P2c - Planting density"
	,max(CASE "externalId"
			WHEN 'P2d'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "P2d - Correct pruning"
	,max(CASE "externalId"
			WHEN 'P3a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "P3a - Pest and descease awarness"
	,max(CASE "externalId"
			WHEN 'P4a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "P4a - Weed management"
	,max(CASE "externalId"
			WHEN 'P5a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "P5a - Fertilization practices"
	,max(CASE "externalId"
			WHEN 'P7a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "P7a - Coffee sales documents"
	,max(CASE "externalId"
			WHEN 'P7b'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "P7b - Cost sources"
	,max(CASE "externalId"
			WHEN 'Q1a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "Q1a - Harvest planning and supervision"
	,max(CASE "externalId"
			WHEN 'Q1b'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "Q1b - Same day processing and harvesting"
	,max(CASE "externalId"
			WHEN 'Q2a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "Q2a - Avoiding mixing during fermentation"
	,max(CASE "externalId"
			WHEN 'Q2b'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "Q2b - Avoiding over-fermentation"
	,max(CASE "externalId"
			WHEN 'Q2c'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "Q2c - Continuous drying"
	,max(CASE "externalId"
			WHEN 'Q2d'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "Q2d - Avoiding contamination during drying"
	,max(CASE "externalId"
			WHEN 'Q3a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "Q3a - Coffee storage conditions"
	,max(CASE "externalId"
			WHEN 'Q3b'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "Q3b - Clean storage bags"
	,max(CASE "externalId"
			WHEN 'Q4a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "Q4a - Equipment cleaning procedure"
	,max(CASE "externalId"
			WHEN 'Q4b'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "Q4b - Processing area"
	,max(CASE "externalId"
			WHEN 'Q4c'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "Q4c - Clean processing water"
	,max(CASE "externalId"
			WHEN 'Q4d'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "Q4d - Avoiding mixing during processing and storage"
	,max(CASE "externalId"
			WHEN 'Q4e'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "Q4e - Equipment maintenance"
	,max(CASE "externalId"
			WHEN 'S1a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "S1a - Forced labour"
	,max(CASE "externalId"
			WHEN 'S1b'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "S1b - Harassment and abuse"
	,max(CASE "externalId"
			WHEN 'S1c'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "S1c - Discrimination"
	,max(CASE "externalId"
			WHEN 'S1d'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "S1d - Minimum wage"
	,max(CASE "externalId"
			WHEN 'S1e'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "S1e - Freedom of association..."
	,max(CASE "externalId"
			WHEN 'S2a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "S2a - Child labor"
	,max(CASE "externalId"
			WHEN 'S3a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "S3a - Agrochemicals: Accident prevention "
	,max(CASE "externalId"
			WHEN 'S3b'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "S3b - Agrochemicals: Restricted products"
	,max(CASE "externalId"
			WHEN 'S3c'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "S3c - Agrochemicals: Safe storage"
	,max(CASE "externalId"
			WHEN 'E1a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "E1a - Water contamination"
	,max(CASE "externalId"
			WHEN 'E1b'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "E1b - Water consumption"
	,max(CASE "externalId"
			WHEN 'E1c'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "E1c - Irrigation water"
	,max(CASE "externalId"
			WHEN 'E2a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "E2a - Ecosystem protection"
	,max(CASE "externalId"
			WHEN 'E2b'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "E2b - Endangered species"
	,max(CASE "externalId"
			WHEN 'E2c'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "E2c - Transgenic crops"
	,max(CASE "externalId"
			WHEN 'E3a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							WHEN "answerType" = 'LIST_SINGLE'
								THEN "answerCode"
							END
						)
			END) AS "E3a - Soil coverage"
	,max(CASE "externalId"
			WHEN 'P6a'
				THEN "answerNumber"
			END) AS "P6a - Washed arabica production"
	,max(CASE "externalId"
			WHEN 'P6a'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							ELSE "label"
							END
						)
			END) AS "P6a - Washed arabica production Unit"
	,max(CASE "externalId"
			WHEN 'P6b'
				THEN "answerNumber"
			END) AS "P6b - Natural arabica production"
	,max(CASE "externalId"
			WHEN 'P6b'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							ELSE "label"
							END
						)
			END) AS "P6b - Natural arabica production Unit"
	,max(CASE "externalId"
			WHEN 'P6c'
				THEN "answerNumber"
			END) AS "P6c - Bourbon production"
	,max(CASE "externalId"
			WHEN 'P6c'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							ELSE "label"
							END
						)
			END) AS "P6c - Bourbon production Unit"
	,max(CASE "externalId"
			WHEN 'P6d'
				THEN "answerNumber"
			END) AS "P6d - Natural robusta production"
	,max(CASE "externalId"
			WHEN 'P6d'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							ELSE "label"
							END
						)
			END) AS "P6d - Natural robusta production Unit"
	,max(CASE "externalId"
			WHEN 'P6e'
				THEN "answerNumber"
			END) AS "P6e - Washed robusta production"
	,max(CASE "externalId"
			WHEN 'P6e'
				THEN (
						CASE 
							WHEN "notApplicableFlag" = 1
								THEN 'N/A'
							ELSE "label"
							END
						)
			END) AS "P6e - Washed robusta production Unit"
	,max(CASE "externalId"
			WHEN 'I4A'
				THEN "answerNumber"
			END) AS "I4A - Farm Area"
	,max(CASE "externalId"
			WHEN 'I4A'
				THEN "label"
			END) AS "I4A - Farm Area Unit"
	,max(CASE "externalId"
			WHEN 'I4B'
				THEN "answerNumber"
			END) AS "I4B - Coffee Area"
	,max(CASE "externalId"
			WHEN 'I4B'
				THEN "label"
			END) AS "I4B - Coffee Area Unit"
	,EntityCalculations."coffeeArea" AS "Coffee Area (Ha)"
	,EntityCalculations."totalArea" AS "Farm Area (Ha)"
	,EntityCalculations."totalProduction" AS "Total Production (KG)"
	,EntityCalculations."arabicaProduction" AS "Arabica Production (KG)"
	,EntityCalculations."robustaProduction" AS "Robusta Production (KG)"
	,EntityCalculations."bourbonProduction" AS "Bourbon Production (KG)"
	,EntityCalculations."totalYield" AS "Total Yield"
FROM (
	SELECT *
	FROM (
		SELECT Interaction."entityId"
			,Interaction."interactionId"
			,Interaction."status" "InteractionStatus"
			,Interaction."startDate"
			,Observation."status"
			,Observation."obsDateTime"
			,Observation."auditInfo.createdOn" "ObservationCreationDate"
			,Observation."notApplicableFlag"
			,Observation."answerType"
			,Observation."answerCode"
			,Observation."answerNumber"
			,Criteria."externalId"
			,CriteriaGroup."criteriaEvaluationContext"
			,Criteria."answerListSetId"
			,Criteria."classification1" AS "classification"
			,Label1."label" AS "classification1"
			,Label2."label" AS "classification2"
			,UnitLabel."label"
			,RANK() OVER (
				PARTITION BY Interaction."entityId"
				,Criteria."externalId" ORDER BY Observation."obsDateTime" DESC
					,Observation."observationId" DESC
				) AS ObsRank
		FROM "FARMS"."nestle.dev.glb.farms.data.structure::IT.Interaction" AS Interaction
		LEFT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::AT.Observation" AS Observation
			ON Observation."interactionId" = Interaction."interactionId"
		INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::AT.Criteria" AS Criteria
			ON Observation."criteriaId" = Criteria."criteriaId"
		LEFT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::AT.CriteriaToCriteriaGroup" AS CriteriaGroup
			ON Criteria."criteriaId" = CriteriaGroup."criteriaId"
		INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::AT.Criteria_Txt" AS Criteria_Text
			ON Criteria_Text."criteriaId" = Criteria."criteriaId" AND Criteria_Text."language" = 'E'
		INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.ListOption_Txt" AS Label1
			ON Label1."language" = 'E' AND Criteria."classification1" = Label1."itemCode" AND Label1."setId" = 'CRITERIA_CLASS1'
		INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.ListOption_Txt" AS Label2
			ON Label2."language" = 'E' AND Criteria."classification2" = Label2."itemCode" AND Label2."setId" = 'CRITERIA_CLASS2'
		LEFT JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.ListOption_Txt" AS Label3
			ON Label3."language" = 'E' AND Criteria."classification3" = Label3."itemCode" AND Label3."setId" = 'CRITERIA_CLASS3'
		LEFT JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.ListOption_Txt" AS UnitLabel
			ON UnitLabel."language" = 'E' AND Observation."unitOfMeasure" = UnitLabel."itemCode" AND UnitLabel."setId" = 'UOM'
		INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS Employee
			ON Employee."employeeId" = Interaction."employeeId"
		INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Organisation" AS Organisation
			ON Employee."organisationId" = Organisation."organisationId"
		WHERE Organisation."lineOfBusiness" = 'NESPRESSO' AND Interaction."status" != 'CANCELLED' AND Observation."status" = 'ACTIVE' AND CriteriaGroup."criteriaEvaluationContext" IN ('CORE', 'PRE-REQUISITE')
		)
	WHERE ObsRank = 1
	) RESULT_TABLE
RIGHT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::ET.Entity" AS Entity
	ON RESULT_TABLE."entityId" = Entity."entityId"
LEFT JOIN "FARMS"."nestle.dev.glb.farms.data.structure::ET.Person" AS Person
	ON Person."entityId" = Entity."entityId" AND Person."primaryIndicator" = 1 AND Person."status" = 'ACTIVE'
LEFT JOIN "_SYS_BIC"."nestle.dev.glb.farms.models.dataFoundation/EntityCalculations" AS EntityCalculations
	ON EntityCalculations."entityId" = Entity."entityId"
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS GeoNode
	ON GeoNode."geoNodeId" = Entity."geoNodeId"
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS GeoNode2
	ON GeoNode."parentId" = GeoNode2."geoNodeId"
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS GeoNode3
	ON GeoNode2."parentId" = GeoNode3."geoNodeId"
WHERE GeoNode."lineOfBusiness" = 'NESPRESSO'
GROUP BY CASE 
		WHEN GeoNode3."geoNodeType" = 'GLOBAL'
			THEN GeoNode2."name"
		ELSE GeoNode3."name"
		END
	,CASE 
		WHEN GeoNode2."geoNodeType" = 'COUNTRY'
			THEN GeoNode."name"
		ELSE GeoNode2."name"
		END
	,CASE 
		WHEN GeoNode."geoNodeType" = 'CLUSTER'
			THEN ''
		ELSE GeoNode."name"
		END
	,Entity."entityType"
	,Entity."externalSystemId"
	,Entity."entityId"
	,Entity."name"
	,Entity."status"
	,Entity."inactivatedOn"
	,Entity."AAAEntryYear"
	,Entity."AAAStatus"
	,Person."personInfo.firstName" || ' ' || Person."personInfo.lastName"
	,Entity."coordinates.longX"
	,Entity."coordinates.latY"
	,Entity."altZ"
	,Entity."locationVerified"
	,Entity."AAAEnrolmentDate"
	,EntityCalculations."coffeeArea"
	,EntityCalculations."totalArea"
	,EntityCalculations."totalYield"
	,EntityCalculations."totalProduction"
	,EntityCalculations."arabicaProduction"
	,EntityCalculations."robustaProduction"
	,EntityCalculations."bourbonProduction"
ORDER BY CASE 
		WHEN GeoNode3."geoNodeType" = 'GLOBAL'
			THEN GeoNode2."name"
		ELSE GeoNode3."name"
		END
	,CASE 
		WHEN GeoNode2."geoNodeType" = 'COUNTRY'
			THEN GeoNode."name"
		ELSE GeoNode2."name"
		END
	,CASE 
		WHEN GeoNode."geoNodeType" = 'CLUSTER'
			THEN ''
		ELSE GeoNode."name"
		END
	,Entity."externalSystemId"