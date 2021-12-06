 /*******************************************
   Author     : Shubham Mishra
   Created On : 10th August, 2021
   PURPOSE    : TASQ
   *******************************************/
  --drop view [dm].[view_fact_entity_metrics]    
  CREATE VIEW [dm].[view_fact_entity_metrics] AS WITH cte AS (
    SELECT 
      A.entityId, 
      B.externalSystemId AS entityBusinessId, 
      B.name AS entityName, 
      YEAR(A.obsDateTime) AS ObsYear, 
      A.criteriaId, 
      A.obsDateTime, 
      A.isLatest, 
      A.answerNumber, 
      A.answerType, 
      A.unitOfMeasure, 
      D.BASE_UOM, 
      D.CONV_FACT, 
      CASE WHEN (D.CONV_FACT IS NULL) THEN A.answerNumber ELSE D.CONV_FACT * A.answerNumber END AS afterUnitConversaion, 
      A.observationId, 
      C.interactionId, 
      C.templateId, 
      C.startDate, 
      C.endDate, 
      C.OrganisationId 
    FROM 
      dwh.AT_Observation AS A 
      INNER JOIN dwh.ET_Entity AS B ON A.entityId = B.entityId 
      AND A.STATUS = 'ACTIVE' 
      AND A.isLatestByYear = 1 
      AND A.notApplicableFlag = 0 
      INNER JOIN dwh.IT_Interaction AS C ON A.interactionId = C.interactionId 
      AND C.STATUS = 'COMPLETED' 
      AND C.type = 'ASSESSMENT' 
      LEFT JOIN dwh.MT_UOMConversion AS D ON A.unitOfMeasure = D.ALT_UOM 
    WHERE 
      A.criteriaId IN (
        'TASQ_3_40', 
        --arabica prod
        'TASQ_3_41', 
        --bourbon prod
        'TASQ_3_42', 
        --robusta prod
        'TASQ_3_43', 
        --robusta prod
        'TASQ_3_44', 
        --arabica prod
        'TASQ_3_125', 
        --total land
        'TASQ_3_252', 
        --arabica prod
        'TASQ_3_253', 
        --bourbon prod
        'TASQ_3_254', 
        --robusta prod
        'TASQ_3_255', 
        --robusta prod
        'TASQ_3_347', 
        --arabica prod
        'TASQ_3_487', 
        --coffee area
        'NESCAFE_PROD_ACT_ROBUSTA', 
        --robusta prod
        'NESCAFE_PROD_ACT_ARABICA', 
        --arabica prod
        'NESCAFE_ME_C_FM_30' --total land      
        )
  ) 
SELECT 
  *, 
  CASE WHEN (
    obsDateTime IS NOT NULL 
    AND criteriaId IN (
      'TASQ_3_125', 'NESCAFE_ME_C_FM_30'
    ) 
    AND answerType IN ('QUANTITY', 'AREA')
  ) THEN afterUnitConversaion ELSE 0 END AS totalArea, 
  CASE WHEN (
    criteriaId IN ('TASQ_3_487') 
    AND answerType IN ('QUANTITY', 'AREA') 
    AND obsDateTime IS NOT NULL
  ) THEN afterUnitConversaion ELSE 0 END AS coffeeArea, 
  CASE WHEN (
    criteriaId IN (
      'TASQ_3_40', 'TASQ_3_41', 'TASQ_3_42', 
      'TASQ_3_43', 'TASQ_3_44', 'TASQ_3_252', 
      'TASQ_3_253', 'TASQ_3_254', 'TASQ_3_255', 
      'TASQ_3_347', 'NESCAFE_PROD_ACT_ROBUSTA', 
      'NESCAFE_PROD_ACT_ARABICA'
    ) 
    AND answerType = 'QUANTITY' 
    AND obsDateTime IS NOT NULL
  ) THEN afterUnitConversaion ELSE 0 END AS totalProduction, 
  CASE WHEN (
    criteriaId IN (
      'TASQ_3_40', 'TASQ_3_44', 'TASQ_3_252', 
      'TASQ_3_347', 'NESCAFE_PROD_ACT_ARABICA'
    ) 
    AND answerType = 'QUANTITY' 
    AND obsDateTime IS NOT NULL
  ) THEN afterUnitConversaion ELSE 0 END AS arabicaProduction, 
  CASE WHEN (
    criteriaId IN (
      'TASQ_3_42', 'TASQ_3_43', 'TASQ_3_254', 
      'TASQ_3_255', 'NESCAFE_PROD_ACT_ROBUSTA'
    ) 
    AND answerType = 'QUANTITY' 
    AND obsDateTime IS NOT NULL
  ) THEN afterUnitConversaion ELSE 0 END AS robustaProduction, 
  CASE WHEN (
    criteriaId IN ('TASQ_3_41', 'TASQ_3_253') 
    AND answerType = 'QUANTITY' 
    AND obsDateTime IS NOT NULL
  ) THEN afterUnitConversaion ELSE 0 END AS bourbonProduction 
FROM 
  cte;

  --NFPR2
  --NFPR1