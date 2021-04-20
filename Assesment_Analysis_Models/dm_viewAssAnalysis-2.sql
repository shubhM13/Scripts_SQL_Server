/****** Object:  View [dm].[view_fact_assessment_analysis]    Script Date: 08-03-2021 14:46:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 19th Feb, 2021
 PURPOSE    : FactAssessmentAnalysis
 *******************************************/
--drop view dm.view_fact_assessment_analysis
CREATE VIEW [dm].[view_fact_assessment_analysis]
AS
(
		SELECT A.[interactionId]
			,ISNULL(A.[interactionType], '') AS interactionType
			,ISNULL(A.[interactionTypeTxt], '') AS interactionTypeTxt
			,ISNULL(A.[interactionEmployeeId], '') AS interactionEmployeeId
			,ISNULL(A.[interactionTemplateId], '') AS interactionTemplateId
			,A.[interactionStartDate] AS interactionStartDate
			,A.[startDateKey] AS startDateKey
			,ISNULL(A.[interactionOrganisationId], '') AS interactionOrganisationId
			,ISNULL(A.[interactionOrgName], '') AS interactionOrgName
			,ISNULL(A.[agronomistEmail], '') AS agronomistEmail
			,A.[interaction_modifiedOn] AS interaction_modifiedOn
			,A.[interaction_modifiedOnKey] AS interaction_modifiedOnKey
			,B.[observationId] AS observationId
			,B.[obsDate] AS obsDate
			,B.[obsDateKey] AS obsDateKey
			,ISNULL(B.[observationEntityId], '') AS entityId
			,ISNULL(C.geoNodeId, '') AS geoNodeId
			,ISNULL(B.[observationCriteriaId], '') AS observationCriteriaId
			,ISNULL(G.groupCode, '') AS criteriaGroupCode
			,ISNULL(G.criteriaGroupCodeTxt, '') AS criteriaGroupCodeTxt
			,ISNULL(G.criteriaEvaluationContextTxt, '') AS criteriaEvaluationContextTxt
			--,ISNULL(H.topicCode, '') AS criteriaTopicCode
			--,ISNULL(H.topicTxt, '') AS criteriaTopicCodeTxt
			,ISNULL(B.[notApplicableFlag], '') AS notApplicableFlag
			,ISNULL(B.[answerType], '') AS answerType
			,B.[answerDate] AS answerDate
			,B.[answerDateKey]AS answerDateKey
			,B.[answerDate2] AS answerDate2
			,B.[answerDate2Key] AS answerDate2Key
			,B.[answerNumber]AS answerNumber
			,B.answerText AS answerText
			,ISNULL(B.[answerCode], '') AS answerCode
			,ISNULL(B.[answerCodeTxt], '') AS answerCodeTxt
			,B.[answerCodeScore] AS answerCodeScore
			--,ISNULL(B.[multiListAnswerCode], '') AS multiListAnswerCode
			--,ISNULL(B.[multiListAnswerCodeTxt], '') AS multiListAnswerCodeTxt
			--,B.[multiListAnswerCodeScore] AS multiListAnswerCodeScore
			,ISNULL(B.[unitOfMeasure], '') AS unitOfMeasure
			,ISNULL(B.[unitOfMeasureTxt], '') AS unitOfMeasureTxt
			,ISNULL(B.[currencyCode], '') AS currencyCode
			,ISNULL(B.[currencyCodeTxt], '') AS currencyCodeTxt
			,ISNULL(B.[isLatest], 0) AS isLatest
			,ISNULL(B.[isLatestByYear], 0) AS isLatestByYear
			,ISNULL(D.title, '') AS section
			,ISNULL(E.sortOrder, '') AS sortOrder
			,ISNULL(E.sortOrderSection, '') AS sortOrderSection
		FROM dm.dim_interaction AS A
		INNER JOIN dm.dim_observation AS B
		ON A.interactionId = B.interactionId
		LEFT JOIN [dwh].[ET_Entity] AS C ON B.[observationEntityId] = C.entityId
		LEFT JOIN [dwh].[AT_TemplateToCriteria] AS E ON E.templateId = A.[interactionTemplateId]
			AND E.criteriaId = B.[observationCriteriaId]
		LEFT JOIN [dwh].[AT_Section] AS F ON E.templateId = F.templateId
			AND E.sectionId = F.sectionId
		LEFT JOIN [dwh].[AT_Section_Txt] AS D ON D.sectionId = F.sectionId
			AND D.language = 'E'
		LEFT JOIN [dm].[dim_criteria_group] AS G ON B.observationCriteriaId = G.criteriaId
		--LEFT JOIN [dm].[dim_criteria_topic] AS H ON B.observationCriteriaId = H.criteriaId
		WHERE A.[interactionEmployeeId] NOT IN ('1104','708','697','976')
		AND B.obsDateKey IN (select distinct dateKey from [dm].[dim_date])
		AND A.interactionEmployeeId IN (select distinct employeeId from [dm].[dim_employee])
		AND A.interactionOrganisationId IN (select distinct organisationId from [dwh].[CT_Organisation])
		AND A.interactionTemplateId IN (select distinct templateId from [dm].[dim_template])
		AND B.observationEntityId IN (select distinct entityId from [dm].[dim_entity_master])
		AND C.geoNodeId IN (select distinct geoNodeId from [dm].[dim_geonode_flat])
		);
GO

select COUNT(*) from [dm].[view_fact_assessment_analysis];
select COUNT(*) 
FROM dm.dim_interaction AS A
INNER JOIN dm.dim_observation AS B
ON A.interactionId = B.interactionId
