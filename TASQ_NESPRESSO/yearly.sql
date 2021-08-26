    SELECT 
      entityId, AnswerYear, count(*)
    FROM 
      (
        SELECT 
          Interaction.entityId, 
          Interaction.interactionId, 
          Interaction.STATUS InteractionStatus, 
          Interaction.startDate, 
          Observation.STATUS, 
          Observation.isLatest,
          Observation.isLatestByYear,
          YEAR(Observation.obsDateOnly) AS AnswerYear,
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
            Criteria.externalId, YEAR(Observation.obsDateTime)
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
 AS [RESULT_TABLE] 
  group by entityId, AnswerYear