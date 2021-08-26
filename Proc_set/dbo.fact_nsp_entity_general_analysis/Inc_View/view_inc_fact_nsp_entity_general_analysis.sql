/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dm].[view_inc_fact_nsp_entity_general_analysis]    Script Date: 27/07/2021 8:15:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 05th May, 2021
 PURPOSE    : EntityGeneralAnalysisFactNespressoDataset
 *******************************************/
--drop view dm.view_inc_fact_nsp_entity_general_analysis


CREATE VIEW [dm].[view_inc_fact_nsp_entity_general_analysis]
AS
(
		SELECT DISTINCT (A.entityId)
			,A.geoNodeId
			,CAST(A.[coordinates.longX] AS FLOAT(53)) AS coordinates_longX
			,CAST(A.[coordinates.latY] AS FLOAT(53)) AS coordinates_latY
			,C.latest4CGroupId AS entityPoint
			,D.name AS [4CUnit]
			,ISNULL(E.interactionOrgName, '') AS interactionOrgName
			,ISNULL(E.interactionStatus, '') AS interactionStatus
			,ISNULL(E.interactionId, '') AS interactionId
			,ISNULL(E.interactionType, '') AS interactionType
			,ISNULL(E.interactionEmployeeId, '') AS interactionEmployeeId
			,ISNULL(E.interactionEventId, '') AS interactionEventId
			,ISNULL(E.interactionPersonId, '') AS interactionPersonId
			,ISNULL(E.interactionTemplateId, '') AS interactionTemplateId
			,CAST(E.interactionStartDate AS DATE) AS interactionStartDate
			,E.startDateKey
			,CAST(E.interactionEndDate AS DATE) AS interactionEndDate
			,E.endDateKey
			,ISNULL(E.interactionOrganisationId, '') AS interactionOrganisationId
			,ISNULL(F.observationId, '') AS observationId
			,CAST(F.obsDate AS DATE) AS obsDate
			,F.obsDateKey
			,ISNULL(F.observationCriteriaId, '') AS observationCriteriaId
			,ISNULL(F.notApplicableFlag, '') AS notApplicableFlag
			,ISNULL(F.answerDate, '') AS answerDate
			,ISNULL(F.answerDate2, '') AS answerDate2
			,ISNULL(F.answerNumber, '') AS answerNumber
			,ISNULL(F.unitOfMeasureTxt, '') AS unitOfMeasure
			,ISNULL(F.answerCodeTxt, '') AS answerCodeTxt
			,ISNULL(F.answerCodeScore, '') AS answerCodeScore
			,ISNULL(F.currencyCodeTxt, '') AS currencyCode
			,ISNULL(F.isLatest, '') AS isLatestAssessment
			,ISNULL(F.isLatestByYear, '') AS isLatestAssessmentByYear
		FROM [dwh].[ET_entity] AS A
		INNER JOIN [dwh].[CT_GeoNode] AS B WITH (NOLOCK)
			ON A.geoNodeId = B.geoNodeId
			AND B.lineOfBusiness IN ('GLOBAL', 'NESPRESSO')
		AND A.[auditInfo.modifiedOn] >= (select LastTrigger from [AUDIT].[WaterMarkRT] where schemaname = 'ET' and tablename = 'entity')
		AND A.[auditInfo.modifiedOn] <= (select CurrentTrigger from [AUDIT].[WaterMarkRT] where schemaname = 'ET' and tablename = 'entity')
		LEFT JOIN [dwh].[MT_FarmSummary] AS C WITH (NOLOCK)
			ON A.entityId = C.entityId
		LEFT JOIN [dwh].[ET_Group] AS D WITH (NOLOCK)
			ON C.latest4CGroupId = D.groupId
		LEFT JOIN [dm].[fact_nsp_interaction_Base] E WITH (NOLOCK)
			ON A.entityId = E.interactionEntityId
		LEFT JOIN [dm].[fact_nsp_latest_observation_base] F WITH (NOLOCK)
			ON E.interactionId = F.interactionId
		where A.entityId IN (select distinct entityId from [dm].[dim_nsp_entity_master])
		and A.entityId in (select distinct certificationEntityId from [dm].[dim_nsp_certification_with_time])
		and A.geoNodeId in (select distinct geoNodeId from [dm].[dim_nsp_geonode_flat])
		and E.interactionEmployeeId in (select distinct employeeId from [dm].[dim_nsp_employee])
		and E.interactionEventId in (select distinct eventId from [dm].[dim_nsp_event_to_topic])
		--and F.observationCriteriaId in (Select distinct criteriaId from [dm].[dim_nsp_criteria])
		and A.entityId in (select distinct personentityId from [dm].[dim_nsp_person])
		and A.entityId in (select distinct groupEntityId from [dm].[dim_nsp_Groupwithentity])
		and E.interactionId in (select distinct interactionTopicInteractionId from [dm].[dim_nsp_interaction_topic])
		and E.interactionEventId in (select distinct eventId from [dm].[dim_nsp_event])
	--	and E.interactionTemplateId in (select distinct templateId from [dm].[dim_nsp_template])
		--and F.observationCriteriaId in (select distinct criteriaGroupCriteriaId from [dm].[dim_nsp_criteria_group])
		--and F.observationCriteriaId in (select distinct criteriaTopicCriteriaId from [dm].[dim_nsp_criteria_topic])
	);
GO