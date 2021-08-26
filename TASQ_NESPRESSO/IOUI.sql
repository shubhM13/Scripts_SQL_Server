/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dm].[view_fact_nsp_interaction_observationUI_temp]    Script Date: 01/07/2021 11:08:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 9th June, 2021
 PURPOSE    : TASQ Nespresso Dataset
 *******************************************/
--drop view [dm].[view_fact_nsp_interaction_observationUI_temp]
CREATE VIEW [dm].[view_fact_nsp_interaction_observationUI_temp]
AS
(
SELECT  *
	,CASE 
		WHEN (Q.TotalProduction IS NOT NULL) AND (Q.startDateInteraction = FORMAT(getdate(), 'yyyy-MM-dd'))
			THEN 1
		ELSE 0
		END AS totalProductionCurrentYearFlag
	,CASE 
		WHEN (Q.totalLand IS NOT NULL) AND (Q.startDateInteraction = FORMAT(getdate(), 'yyyy-MM-dd'))
			THEN 1
		ELSE 0
		END AS totalAreaCurrentYearFlag
	,cast(Q.totalProduction / (
			CASE 
				WHEN (Q.coffeeArea = 0)
					THEN NULL
				ELSE Q.coffeeArea
				END
			) AS DECIMAL) AS Totalyield
FROM (
	SELECT  *
		,CASE 
			WHEN ((Z.obsDateTime IS NOT NULL) AND (Z.observationCriteriaId IN ('TASQ_3_125', 'NESCAFE_ME_C_FM_30')) AND (Z.typeInteraction = 'ASSESSMENT') AND (Z.statusInteraction = 'COMPLETED') AND (Z.answerType IN ('QUANTITY', 'AREA')) AND (Z.notApplicableFlag = '0'))
				THEN Z.afterUnitConversaion
			ELSE 0
			END AS totalLand
		,CASE 
			WHEN ((Z.observationCriteriaId IN ('TASQ_3_40', 'TASQ_3_41', 'TASQ_3_42', 'TASQ_3_43', 'TASQ_3_44', 'TASQ_3_252', 'TASQ_3_253', 'TASQ_3_254', 'TASQ_3_255', 'TASQ_3_347', 'NESCAFE_PROD_ACT_ROBUSTA', 'NESCAFE_PROD_ACT_ARABICA')) AND (Z.typeInteraction = 'ASSESSMENT') AND (Z.statusInteraction = 'COMPLETED') AND (Z.answerType = 'QUANTITY') AND (z.obsDateTime IS NOT NULL) AND (Z.notApplicableFlag = 0))
				THEN Z.afterUnitConversaion
			ELSE 0
			END AS totalProduction
		,CASE 
			WHEN ((Z.obsDateTime IS NOT NULL) AND Z.observationCriteriaId IN ('TASQ_3_125', 'TASQ_3_127') AND (Z.typeInteraction = 'ASSESSMENT') AND (Z.statusInteraction = 'COMPLETED') AND (Z.answerType IN ('QUANTITY', 'AREA')) AND (Z.notApplicableFlag = 0))
				THEN CNT
			ELSE 0
			END AS noOfFarmsLand
		,CASE 
			WHEN ((Z.observationCriteriaId IN ('TASQ_3_40', 'TASQ_3_44', 'TASQ_3_252', 'TASQ_3_347', 'NESCAFE_PROD_ACT_ARABICA')) AND (Z.typeInteraction = 'ASSESSMENT') AND (Z.statusInteraction = 'COMPLETED') AND (Z.answerType = 'QUANTITY') AND (Z.obsDateTime IS NOT NULL) AND (Z.notApplicableFlag = 0))
				THEN Z.afterUnitConversaion
			ELSE 0
			END AS arabicaProduction
		,CASE 
			WHEN ((Z.observationCriteriaId IN ('TASQ_3_42', 'TASQ_3_43', 'TASQ_3_254', 'TASQ_3_255', 'NESCAFE_PROD_ACT_ROBUSTA')) AND (Z.typeInteraction = 'ASSESSMENT') AND (Z.statusInteraction = 'COMPLETED') AND (Z.answerType = 'QUANTITY') AND (Z.obsDateTime IS NOT NULL) AND (Z.notApplicableFlag = 0))
				THEN Z.afterUnitConversaion
			ELSE 0
			END AS robustaProduction
		,CASE 
			WHEN ((Z.observationCriteriaId IN ('TASQ_3_41', 'TASQ_3_253')) AND (Z.typeInteraction = 'ASSESSMENT') AND (Z.statusInteraction = 'COMPLETED') AND (Z.answerType = 'QUANTITY') AND (Z.notApplicableFlag = 0) AND (Z.obsDateTime IS NOT NULL))
				THEN Z.afterUnitConversaion
			ELSE 0
			END AS bourbonProduction
		,CASE 
			WHEN ((Z.observationCriteriaId IN ('TASQ_3_487')) AND (Z.typeInteraction = 'ASSESSMENT') AND (Z.statusInteraction = 'COMPLETED') AND (Z.answerType IN ('QUANTITY', 'AREA')) AND (Z.notApplicableFlag = 0) AND (Z.obsDateTime IS NOT NULL))
				THEN Z.afterUnitConversaion
			ELSE 0
			END AS coffeeArea
	FROM (
		SELECT A.observationId AS observationId
			,ISNULL(A.STATUS, '') AS STATUS
			,ISNULL(A.type, '') AS type
			,CAST(A.obsDateTime AS DATE) AS obsDateTime
			,CAST(FORMAT(cast(A.obsDateTime AS DATE), 'yyyyMMdd') AS INT) AS obsDate
			,ISNULL(A.entityId, '') AS observationEntityId
			,ISNULL(A.criteriaId, '') AS observationCriteriaId
			,ISNULL(A.interactionId, '') AS interactionId
			,ISNULL(A.parentObservationId, '') AS parentObservationId
			,ISNULL(CAST(A.notApplicableFlag AS BIT), 0) AS notApplicableFlag
			,ISNULL(A.answerType, '') AS answerType
			,A.answerDate AS answerDate
			,CAST(FORMAT(cast(A.answerDate AS DATE), 'yyyyMMdd') AS INT) AS answerDateKey
			,A.answerDate2 AS answerDate2
			,CAST(FORMAT(cast(A.answerDate2 AS DATE), 'yyyyMMdd') AS INT) AS answerDate2Key
			,A.answerNumber AS answerNumber
			,ISNULL(A.unitOfMeasure, '') AS unitOfMeasure
			,ISNULL(A.currencyCode, '') AS currencyCode
			,A.[auditInfo.createdBy] AS auditInfo_createdBy
			,A.[auditInfo.createdOn] AS auditInfo_createdOn
			,A.[auditInfo.modifiedBy] AS auditInfo_modifiedBy
			,A.[auditInfo.modifiedOn] AS auditInfo_modifiedOn
			,A.[auditInfo.requestedBy] AS auditInfo_requestedBy
			,A.[auditInfo.modifiedReasonCode] AS auditInfo_modifiedReasonCode
			,ISNULL(A.answerCode, '') AS answerCode
			,ISNULL(CAST(A.isLatest AS BIT), 0) AS isLatest
			,ISNULL(CAST(A.isLatestByYear AS BIT), 0) AS isLatestByYear
			,CASE 
				WHEN (A.answerCode = 'COMPLIANT')
					THEN 1
				ELSE 0
				END AS compliant
			,CASE 
				WHEN (A.answerCode = 'NON-COMPLIANT')
					THEN 1
				ELSE 0
				END AS nonCompliant
			,CASE 
				WHEN (A.notApplicableFlag = '1')
					THEN 1
				ELSE 0
				END AS notApplicableCount
			,B.BASE_UOM
			,B.CONV_FACT
			,CASE 
				WHEN ((Y.criteriaEvaluationContext = 'UNACCEPTABLE') AND (criteriaGroupCode = '4C'))
					THEN CASE 
							WHEN (A.answerCode = 'UNACCEPTABLE')
								THEN 1
							ELSE 0
							END
				ELSE 0
				END AS nonCompliant4C
			,Y.externalIdCriteria
			,Y.statusCriteria
			,Y.startDateCriteria
			,Y.endDateCriteria
			,Y.classification1
			,Y.classification2
			,Y.classification3
			,Y.complianceFlagCriteria
			,Y.answerListSetId
			,Y.titleObservation
			,Y.criteriaEvaluationContext
			,1 AS CNT
			,C.type AS typeInteraction
			,C.name AS nameInteraction
			,C.notes
			,C.location
			,C.STATUS AS statusInteraction
			,C.employeeId
			,C.eventId
			,C.varietyTrialId
			,C.siteTrialId
			,C.personId
			,C.templateId
			,CAST(C.startDate AS DATE) AS startDateInteraction
			,CAST(FORMAT(cast(C.startDate AS DATE), 'yyyyMMdd') AS INT) AS startDateInteractionKey
			,CAST(C.endDate AS DATE) AS endDateInteraction
			,C.geoNodeId
			,C.organisationId
			,C.[auditInfo.modifiedBy] AS auditInfo_modifiedByInteraction
			,C.[auditInfo.modifiedOn] AS auditInfo_modifiedOnInteraction
			,CASE 
				WHEN (C.endDate IS NULL)
					THEN C.startDate
				ELSE C.endDate
				END AS interactionEndDate
			,CASE 
				WHEN (B.CONV_FACT IS NULL)
					THEN A.answerNumber
				ELSE B.CONV_FACT * A.answerNumber
				END AS afterUnitConversaion
		FROM dwh.AT_Observation AS A
		LEFT JOIN [dwh].[MT_UOMConversion] AS B ON A.unitOfMeasure = B.ALT_UOM
		LEFT JOIN (
			SELECT *
			FROM (
				SELECT  P.criteriaId
					,P.externalId AS externalIdCriteria
					,P.STATUS AS statusCriteria
					,P.startDate AS startDateCriteria
					,P.endDate AS endDateCriteria
					,P.classification1
					,P.classification2
					,P.classification3
					,P.complianceFlag AS complianceFlagCriteria
					,P.answerListSetId
					,Q.title AS titleObservation
					,R.criteriaEvaluationContext
					,R.groupCode AS criteriaGroupCode
				FROM [dwh].[AT_Criteria] AS P
				INNER JOIN [dwh].[AT_Criteria_Txt] AS Q ON P.criteriaId = Q.criteriaId
				LEFT JOIN [dwh].[AT_CriteriaToCriteriaGroup] AS R ON P.criteriaId = R.criteriaId
				) AS X
			) AS Y ON Y.criteriaId = A.criteriaId
		LEFT JOIN dwh.[IT_Interaction] AS C ON A.entityId = C.entityId
		) AS Z
	) AS Q
	)
GO

