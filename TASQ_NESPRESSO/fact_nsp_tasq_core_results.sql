/*******************************************
   Author     : Shubham Mishra
   Created On : 10th August, 2021
   PURPOSE    : TASQ
*******************************************/
--drop view [dm].[view_fact_nsp_tasq_core_results]    
CREATE VIEW [dm].[view_fact_nsp_tasq_core_results] AS 
SELECT 
  Geonode.countryName AS [Country], 
  Geonode.clusterName AS [Cluster], 
  Geonode.subClusterName AS [Subcluster], 
  Entity.entityType AS [Entity Type], 
  Entity.externalSystemId AS [AAA ID], 
  Entity.entityId AS [ENTITYID], 
  Entity.name AS [Farm Name], 
  Entity.STATUS AS [Farm Status], 
  Entity.inactivatedOn AS [Farm Inactivation Date], 
  Entity.AAAEntryYear AS [Farm Entry Year], 
  Entity.AAAStatus AS [AAA Status], 
  CONCAT (
    Person.[personInfo.firstName], ' ', 
    Person.[personInfo.lastName]
  ) AS [Primary Contact], 
  Entity.[coordinates.longX] AS [Longitude], 
  Entity.[coordinates.latY] AS [Latitude], 
  Entity.altZ AS [Altitude], 
  Entity.locationVerified AS [Location Verified], 
  Entity.AAAEnrolmentDate AS [AAA Enrollment Date], 
  max(RESULT_TABLE.obsDateTime) AS [Last 
Update 
  Observation], 
  max(Entity.[auditInfo.modifiedOn]) AS [Last 
Update 
  System], 
  SUM(
    CASE WHEN RESULT_TABLE.InteractionStatus IS NOT NULL THEN 1 ELSE 0 END
  ) AS [Total Answers], 
  SUM(
    CASE RESULT_TABLE.InteractionStatus WHEN 'COMPLETED' THEN 1 ELSE 0 END
  ) AS [Completed Answers], 
  SUM(
    CASE RESULT_TABLE.InteractionStatus WHEN 'IN_PROGRESS' THEN 1 ELSE 0 END
  ) AS [Draft Answers], 
  SUM(
    CASE RESULT_TABLE.answerListSetId WHEN 'ANS_COMPLIANCE' THEN 1 ELSE 0 END
  ) AS [Total Compliance], 
  SUM(
    CASE RESULT_TABLE.answerCode WHEN 'COMPLIANT' THEN 1 ELSE 0 END
  ) AS [Total Compliant], 
  SUM(
    CASE RESULT_TABLE.answerCode WHEN 'NON-COMPLIANT' THEN 1 ELSE 0 END
  ) AS [Total Non Compliant], 
  SUM(
    CASE RESULT_TABLE.notApplicableFlag WHEN 1 THEN 1 ELSE 0 END
  ) AS [Total Not Applicable], 
  SUM(
    CASE WHEN RESULT_TABLE.answerCode = 'NON-COMPLIANT' 
    AND RESULT_TABLE.criteriaEvaluationContext = 'PRE-REQUISITE' THEN 1 ELSE 0 END
  ) AS [Total Non Compliant PreRequisite], 
  CASE WHEN SUM(
    CASE WHEN RESULT_TABLE.answerCode IN ('COMPLIANT', 'NON-COMPLIANT') THEN 1 ELSE 0 END
  ) > 0 THEN round(
    SUM(
      CASE RESULT_TABLE.answerCode WHEN 'COMPLIANT' THEN 1 ELSE 0 END
    ) / SUM(
      CASE WHEN RESULT_TABLE.answerCode IN ('COMPLIANT', 'NON-COMPLIANT') THEN 1 ELSE 0 END
    ), 
    5
  ) ELSE 0 END AS [Total Score], 
  CASE WHEN SUM(
    CASE WHEN RESULT_TABLE.answerCode IN ('COMPLIANT', 'NON-COMPLIANT') 
    AND RESULT_TABLE.classification = 'SOCIAL' THEN 1 ELSE 0 END
  ) > 0 THEN round(
    SUM(
      CASE WHEN RESULT_TABLE.answerCode = 'COMPLIANT' 
      AND RESULT_TABLE.classification = 'SOCIAL' THEN 1 ELSE 0 END
    ) / SUM(
      CASE WHEN RESULT_TABLE.answerCode IN ('COMPLIANT', 'NON-COMPLIANT') 
      AND RESULT_TABLE.classification = 'SOCIAL' THEN 1 ELSE 0 END
    ), 
    5
  ) ELSE 0 END AS [Total Score Social], 
  CASE WHEN SUM(
    CASE WHEN RESULT_TABLE.answerCode IN ('COMPLIANT', 'NON-COMPLIANT') 
    AND RESULT_TABLE.classification = 'PRODUCTIVITY' THEN 1 ELSE 0 END
  ) > 0 THEN round(
    SUM(
      CASE WHEN RESULT_TABLE.answerCode = 'COMPLIANT' 
      AND RESULT_TABLE.classification = 'PRODUCTIVITY' THEN 1 ELSE 0 END
    ) / SUM(
      CASE WHEN RESULT_TABLE.answerCode IN ('COMPLIANT', 'NON-COMPLIANT') 
      AND RESULT_TABLE.classification = 'PRODUCTIVITY' THEN 1 ELSE 0 END
    ), 
    5
  ) ELSE 0 END AS [Total Score Productivity], 
  CASE WHEN SUM(
    CASE WHEN RESULT_TABLE.answerCode IN ('COMPLIANT', 'NON-COMPLIANT') 
    AND RESULT_TABLE.classification = 'ENVIRONMENT' THEN 1 ELSE 0 END
  ) > 0 THEN round(
    SUM(
      CASE WHEN RESULT_TABLE.answerCode = 'COMPLIANT' 
      AND RESULT_TABLE.classification = 'ENVIRONMENT' THEN 1 ELSE 0 END
    ) / SUM(
      CASE WHEN RESULT_TABLE.answerCode IN ('COMPLIANT', 'NON-COMPLIANT') 
      AND RESULT_TABLE.classification = 'ENVIRONMENT' THEN 1 ELSE 0 END
    ), 
    5
  ) ELSE 0 END AS [Total Score Environmental], 
  CASE WHEN SUM(
    CASE WHEN RESULT_TABLE.answerCode IN ('COMPLIANT', 'NON-COMPLIANT') 
    AND RESULT_TABLE.classification = 'QUALITY' THEN 1 ELSE 0 END
  ) > 0 THEN round(
    SUM(
      CASE WHEN RESULT_TABLE.answerCode = 'COMPLIANT' 
      AND RESULT_TABLE.classification = 'QUALITY' THEN 1 ELSE 0 END
    ) / SUM(
      CASE WHEN RESULT_TABLE.answerCode IN ('COMPLIANT', 'NON-COMPLIANT') 
      AND RESULT_TABLE.classification = 'QUALITY' THEN 1 ELSE 0 END
    ), 
    5
  ) ELSE 0 END AS [Total Score Quality], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P1a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [P1a Approved varieties], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P2a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [P2a Farm map], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P2b' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [P2b Renovation plan], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P2c' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [P2c Planting density], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P2d' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [P2d Correct pruning], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P3a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [P3a Pestanddesceaseawarness], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P4a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [P4a Weed management], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P5a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [P5a Fertilization practices], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P7a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [P7a Coffee sales documents], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P7b' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [P7b Cost sources], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'Q1a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [Q1a Harvest planning 
  and supervision], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'Q1b' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [Q1b Same day processing 
  and harvesting], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'Q2a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [Q2a Avoiding mixing during fermentation], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'Q2b' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [Q2b Avoiding over fermentation], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'Q2c' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [Q2c Continuous drying], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'Q2d' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [Q2d Avoiding contamination during drying], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'Q3a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [Q3a Coffee storage conditions], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'Q3b' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [Q3b Clean storage bags], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'Q4a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [Q4a Equipment cleaning procedure], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'Q4b' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [Q4b Processing area], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'Q4c' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [Q4c Clean processing water], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'Q4d' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [Q4d Avoiding mixing during processing 
  and storage], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'Q4e' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [Q4e Equipment maintenance], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'S1a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [S1a Forced labour], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'S1b' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [S1b Harassment 
  and abuse], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'S1c' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [S1c Discrimination], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'S1d' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [S1d Minimum wage], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'S1e' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [S1e Freedom of association], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'S2a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [S2a Child labor], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'S3a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [S3a AgrochemicalsAccident prevention], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'S3b' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [S3b AgrochemicalsRestricted products], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'S3c' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [S3c AgrochemicalsSafe storage], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'E1a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [E1a Water contamination], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'E1b' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [E1b Water consumption], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'E1c' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [E1c Irrigation water], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'E2a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [E2a Ecosystem protection], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'E2b' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [E2b Endangered species], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'E2c' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [E2c Transgenic crops], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'E3a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' WHEN RESULT_TABLE.answerType = 'LIST_SINGLE' THEN RESULT_TABLE.answerCode END
    ) END
  ) AS [E3a Soil coverage], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P6a' THEN RESULT_TABLE.answerNumber END
  ) AS [P6a Washed arabica production], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P6a' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' ELSE RESULT_TABLE.label END
    ) END
  ) AS [P6a Washed arabica production Unit], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P6b' THEN RESULT_TABLE.answerNumber END
  ) AS [P6b Natural arabica production], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P6b' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' ELSE RESULT_TABLE.label END
    ) END
  ) AS [P6b Natural arabica production Unit], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P6c' THEN RESULT_TABLE.answerNumber END
  ) AS [P6c Bourbon production], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P6c' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' ELSE RESULT_TABLE.label END
    ) END
  ) AS [P6c Bourbon production Unit], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P6d' THEN RESULT_TABLE.answerNumber END
  ) AS [P6d Natural robusta production], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P6d' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' ELSE RESULT_TABLE.label END
    ) END
  ) AS [P6d Natural robusta production Unit], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P6e' THEN RESULT_TABLE.answerNumber END
  ) AS [P6e Washed robusta production], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'P6e' THEN (
      CASE WHEN RESULT_TABLE.notApplicableFlag = 1 THEN 'N/A' ELSE RESULT_TABLE.label END
    ) END
  ) AS [P6e Washed robusta production Unit], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'I4A' THEN RESULT_TABLE.answerNumber END
  ) AS [I4A Farm Area], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'I4A' THEN RESULT_TABLE.label END
  ) AS [I4A Farm Area Unit], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'I4B' THEN RESULT_TABLE.answerNumber END
  ) AS [I4B Coffee Area], 
  max(
    CASE RESULT_TABLE.externalId WHEN 'I4B' THEN RESULT_TABLE.label END
  ) AS [I4B Coffee Area Unit], 
  EntityCalculations.[Coffee Area (Ha) ], 
  EntityCalculations.[Farm Area (Ha) ], 
  EntityCalculations.[Total Production (KG) ], 
  EntityCalculations.[Arabica Production (KG) ], 
  EntityCalculations.[Robusta Production (KG) ], 
  EntityCalculations.[Bourbon Production (KG) ], 
  EntityCalculations.[Total Yield (KG/Ha) ] 
FROM 
  (
    SELECT 
      * 
    FROM 
      (
        SELECT 
          Interaction.entityId, 
          Interaction.interactionId, 
          Interaction.STATUS InteractionStatus, 
          Interaction.startDate, 
          Observation.STATUS, 
          Observation.obsDateTime, 
          Observation.[auditInfo.createdOn] AS [ObservationCreationDate], 
          Observation.notApplicableFlag, 
          Observation.answerType, 
          Observation.answerCode, 
          Observation.answerNumber, 
          Criteria.externalId, 
          CriteriaGroup.criteriaEvaluationContext, 
          Criteria.answerListSetId, 
          Criteria.classification1 AS [classification], 
          Label1.label AS [classification1], 
          Label2.label AS [classification2], 
          UnitLabel.label, 
          RANK() OVER (
            PARTITION BY Interaction.entityId, 
            Criteria.externalId 
            ORDER BY 
              Observation.obsDateTime DESC, 
              Observation.observationId DESC
          ) AS [ObsRank] 
        FROM 
          [dwh].[IT_Interaction] AS [Interaction] 
          LEFT JOIN [dwh].[AT_Observation] AS [Observation] ON Observation.interactionId = Interaction.interactionId 
          INNER JOIN [dwh].[AT_Criteria] AS [Criteria] ON Observation.criteriaId = Criteria.criteriaId 
          LEFT JOIN [dwh].[AT_CriteriaToCriteriaGroup] AS [CriteriaGroup] ON Criteria.criteriaId = CriteriaGroup.criteriaId 
          INNER JOIN [dwh].[AT_Criteria_Txt] AS [Criteria_Text] ON Criteria_Text.criteriaId = Criteria.criteriaId 
          AND Criteria_Text.LANGUAGE = 'E' 
          INNER JOIN [dwh].[CT_ListOption_Txt] AS [Label1] ON Label1.LANGUAGE = 'E' 
          AND Criteria.classification1 = Label1.itemCode 
          AND Label1.setId = 'CRITERIA_CLASS1' 
          INNER JOIN [dwh].[CT_ListOption_Txt] AS [Label2] ON Label2.LANGUAGE = 'E' 
          AND Criteria.classification2 = Label2.itemCode 
          AND Label2.setId = 'CRITERIA_CLASS2' 
          LEFT JOIN [dwh].[CT_ListOption_Txt] AS [Label3] ON Label3.LANGUAGE = 'E' 
          AND Criteria.classification3 = Label3.itemCode 
          AND Label3.setId = 'CRITERIA_CLASS3' 
          LEFT JOIN [dwh].[CT_ListOption_Txt] AS [UnitLabel] ON UnitLabel.LANGUAGE = 'E' 
          AND Observation.unitOfMeasure = UnitLabel.itemCode 
          AND UnitLabel.setId = 'UOM' 
          INNER JOIN [dwh].[CT_Employee] AS [Employee] ON Employee.employeeId = Interaction.employeeId 
          INNER JOIN [dwh].[CT_Organisation] AS [Organisation] ON Employee.organisationId = Organisation.organisationId 
        WHERE 
          Organisation.lineOfBusiness = 'NESPRESSO' 
          AND Interaction.STATUS != 'CANCELLED' 
          AND Observation.STATUS = 'ACTIVE' 
          AND CriteriaGroup.criteriaEvaluationContext IN ('CORE', 'PRE-REQUISITE')
      ) AS [T] 
    WHERE 
      T.ObsRank = 1
  ) AS [RESULT_TABLE] 
  RIGHT JOIN [dwh].[ET_Entity] AS [Entity] ON [RESULT_TABLE].entityId = Entity.entityId 
  LEFT JOIN 
  (select * from (
      select *,
            rank() over(
                partition by entityId 
                order by [auditInfo.modifiedOn] DESC) as personRank 
      from [dwh].[ET_Person]
      where primaryIndicator = 1
      and status = 'ACTIVE'
   )AS [PrimaryPerson]
   where personRank = 1 )
   AS [Person] ON Person.entityId = Entity.entityId 
  LEFT JOIN [dm].[view_fact_entity_metrics_summary] AS [EntityCalculations] ON EntityCalculations.entityId = Entity.entityId 
  AND EntityCalculations.isLatest = 1 
  INNER JOIN dm.[dim_nsp_geonode_flat] AS Geonode ON Geonode.geoNodeId = Entity.geoNodeId 
GROUP BY 
  Geonode.countryName, 
  Geonode.clusterName, 
  Geonode.subClusterName, 
  Entity.entityType, 
  Entity.externalSystemId, 
  Entity.entityId, 
  Entity.name, 
  Entity.STATUS, 
  Entity.inactivatedOn, 
  Entity.AAAEntryYear, 
  Entity.AAAStatus, 
  Person.[personInfo.firstName], 
  Person.[personInfo.lastName], 
  Entity.[coordinates.longX], 
  Entity.[coordinates.latY], 
  Entity.altZ, 
  Entity.locationVerified, 
  Entity.AAAEnrolmentDate, 
  EntityCalculations.[Coffee Area (Ha)], 
  EntityCalculations.[Farm Area (Ha)], 
  EntityCalculations.[Total Production (KG)], 
  EntityCalculations.[Arabica Production (KG)], 
  EntityCalculations.[Robusta Production (KG)], 
  EntityCalculations.[Bourbon Production (KG)], 
  EntityCalculations.[Total Yield (KG/Ha)];


drop table [dm].[fact_nsp_tasq_core_results];

select *
into [dm].[fact_nsp_tasq_core_results]
from [dm].[view_fact_nsp_tasq_core_results];

ALTER TABLE [dm].[fact_nsp_tasq_core_results] ADD CONSTRAINT factTasqCoreRes PRIMARY KEY (
    ENTITYID
    );

select * from [dm].[fact_nsp_tasq_core_results];