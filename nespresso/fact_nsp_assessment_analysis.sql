/*******************************************
 Author     : Shubham Mishra
 Created On : 23rd March, 2021
 PURPOSE    : FactAssessmentAnalysis Nespresso Dataset
 *******************************************/
--drop view dm.view_fact_nsp_assessment_analysis
CREATE VIEW dm.view_fact_nsp_assessment_analysis
AS
(
		SELECT A.[interactionId]
			,B.[observationId] AS observationId
			,ISNULL(A.[interactionStatusTxt], '') AS interactionStatus
			,ISNULL(A.[interactionTypeTxt], '') AS interactionType
			,ISNULL(B.[observationEntityId], '') AS entityId
			,ISNULL(A.[interactionOrganisationId], '') AS interactionOrganisationId
			,ISNULL(A.[interactionOrgName], '') AS interactionOrgName
			,ISNULL(A.[interactionEmployeeId], '') AS interactionEmployeeId
			,ISNULL(A.[agronomistEmail], '') AS agronomistEmail
			,ISNULL(A.[interactionTemplateId], '') AS interactionTemplateId
			,A.[interactionStartDate] AS interactionStartDate
			,A.[startDateKey] AS startDateKey
			,B.[obsDate] AS obsDate
			,B.[obsDateKey] AS obsDateKey
			,ISNULL(B.[observationCriteriaId], '') AS observationCriteriaId
			,ISNULL(D.groupCodes, '') AS criteriaGroupCodes
			,ISNULL(E.topicCodes, '') AS criteriaTopicCodes
			,ISNULL(E.topicTxts, '') AS criteriaTopicCodeTxts
			,ISNULL(B.[notApplicableFlag], '') AS notApplicableFlag
			,ISNULL(B.[answerType], '') AS answerType
			,B.[answerDate] AS answerDate
			,B.[answerDateKey]AS answerDateKey
			,B.[answerDate2] AS answerDate2
			,B.[answerDate2Key] AS answerDate2Key
			,B.[answerNumber] AS answerNumber
			,B.answerText AS answerText
			,ISNULL(B.[answerCodeTxt], '') AS answerCodeTxt
			,B.[answerCodeScore] AS answerCodeScore
			,ISNULL(B.[multiListAnswerCode], '') AS multiListAnswerCode
			,ISNULL(B.[multiListAnswerCodeTxt], '') AS multiListAnswerCodeTxt
			,B.[multiListAnswerCodeScore] AS multiListAnswerCodeScore
			,ISNULL(B.[unitOfMeasureTxt], '') AS unitOfMeasure
			,ISNULL(B.[currencyCodeTxt], '') AS currencyCode
			,ISNULL(B.[isLatest], 0) AS isLatest
			,ISNULL(B.[isLatestByYear], 0) AS isLatestByYear
		FROM dm.dim_interaction AS A
		INNER JOIN dm.dim_observation AS B
		ON A.interactionId = B.interactionId
		INNER JOIN [dm].[dim_nsp_entity_master] AS C ON B.[observationEntityId] = C.entityId
		LEFT JOIN [dm].[dim_criteria_group_flat] AS D ON B.observationCriteriaId = D.criteriaId
		LEFT JOIN [dm].[dim_criteria_topic_flat] AS E ON B.observationCriteriaId = E.criteriaId
		WHERE A.[interactionEmployeeId] NOT IN ('1104','708','697','976')
		AND B.obsDateKey IN (select distinct dateKey from [dm].[dim_date])
		AND A.interactionEmployeeId IN (select distinct employeeId from [dm].[dim_employee])
		AND A.interactionOrganisationId IN (select distinct organisationId from [dwh].[CT_Organisation])
		AND A.interactionTemplateId IN (select distinct templateId from [dm].[dim_nsp_template])
		);

-- VIew top 1000
SELECT TOP(1000) *
FROM [dm].[view_fact_nsp_assessment_analysis]

DROP TABLE [dm].[fact_nsp_assessment_analysis]

--ALTER TABLE [dm].[fact_nsp_assessment_analysis] ADD CONSTRAINT dimNspfactAss_pk PRIMARY KEY (interactionId, observationId);

SELECT COUNT(*)
FROM [dm].[view_fact_nsp_assessment_analysis]

SELECT COUNT(*)
FROM [dm].[dim_nsp_observation]

SELECT COUNT(*)
FROM [dm].[fact_nsp_assessment_analysis]



select distinct A.lineOfBusiness from [dwh].[CT_Organisation] AS A
INNER JOIN [dm].[fact_nsp_assessment_analysis] AS B ON A.organisationId = B.interactionOrganisationId
where A.lineOfBusiness NOT IN ('NESPRESSO', 'GLOBAL')

--LoB of Geonodes of entites
select A.lineOfBusiness, COUNT(distinct C.entityId)
from [dwh].[CT_GeoNode] AS A
INNER JOIN [dwh].[ET_Entity] AS B ON A.geoNodeId = B.geoNodeId
INNER JOIN [dm].[fact_nsp_assessment_analysis] AS C ON B.entityId = C.entityId
group By A.lineOfBusiness

--LoB of Organisation
select A.lineOfBusiness, COUNT(distinct B.interactionOrganisationId)
from [dwh].[CT_Organisation] AS A
INNER JOIN [dm].[fact_nsp_assessment_analysis] AS B ON A.organisationId = B.interactionOrganisationId
group By A.lineOfBusiness

-- LoB of Employees for Interactions corresponding to Entites with Geonode faling under Nespresso LoB
select A.lineOfBusiness, COUNT(distinct employeeId) from [dwh].[CT_Organisation] AS A
INNER JOIN [dwh].[CT_Employee] AS B on A.organisationId = B.organisationId
INNER JOIN [dm].[fact_nsp_assessment_analysis] AS C ON C.interactionEmployeeId = B.employeeId
GROUP BY A.lineOfBusiness

--LoB of Person
select A.lineOfBusiness, COUNT(distinct C.interactionPersonId)
from [dwh].[CT_GeoNode] AS A
INNER JOIN [dwh].[ET_Entity] AS B ON A.geoNodeId = B.geoNodeId
INNER JOIN [dwh].[ET_Person] AS D ON D.entityId = B.entityId 
INNER JOIN [dm].[fact_nsp_assessment_analysis] AS C ON D.personId = C.interactionPersonId
group By A.lineOfBusiness

select distinct interactionPersonId from [dm].[dim_interaction] AS A
INNER JOIN dm.dim_observation AS B ON A.interactionId = B.interactionId

select distinct personId
from [dwh].[IT_Interaction]