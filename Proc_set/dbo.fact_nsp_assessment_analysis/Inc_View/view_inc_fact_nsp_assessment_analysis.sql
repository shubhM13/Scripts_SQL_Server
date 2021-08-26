/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_fact_nsp_assessment_analysis]    Script Date: 22/07/2021 6:47:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 23rd March, 2021
 PURPOSE    : FactAssessmentAnalysis Nespresso Dataset
 *******************************************/
--drop view dm.view_inc_fact_nsp_assessment_analysis
CREATE VIEW [dm].[view_inc_fact_nsp_assessment_analysis]
AS
(
		SELECT A.[interactionId]
			,B.[observationId] AS observationId
			,ISNULL(A.[interactionStatusTxt], '') AS interactionStatus
			,ISNULL(A.[interactionTypeTxt], '') AS interactionType
			,B.[observationEntityId] AS entityId
			,A.[interactionOrganisationId] AS interactionOrganisationId
			,ISNULL(A.[interactionOrgName], '') AS interactionOrgName
			,A.[interactionEmployeeId] AS interactionEmployeeId
			,ISNULL(A.[agronomistEmail], '') AS agronomistEmail
			,A.[interactionTemplateId] AS interactionTemplateId
			,A.[interactionStartDate] AS interactionStartDate
			,A.[startDateKey] AS startDateKey
			,B.[obsDate] AS obsDate
			,B.[obsDateKey] AS obsDateKey
			,B.[observationCriteriaId] AS observationCriteriaId
			,ISNULL(B.[notApplicableFlag], '') AS notApplicableFlag
			,ISNULL(B.[answerType], '') AS answerType
			,B.[answerDate] AS answerDate
			,B.[answerDateKey] AS answerDateKey
			,B.[answerDate2] AS answerDate2
			,B.[answerDate2Key] AS answerDate2Key
			,B.[answerNumber] AS answerNumber
			,ISNULL(B.answerText, '') AS answerText
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
		INNER JOIN dm.dim_observation AS B ON A.interactionId = B.interactionId
		AND A.[auditInfo.modifiedOn] >= (select LastTrigger from [AUDIT].[WaterMarkRT] where schemaname = 'IT' and tablename = 'Interaction')
		AND A.[auditInfo.modifiedOn] <= (select CurrentTrigger from [AUDIT].[WaterMarkRT] where schemaname = 'IT' and tablename = 'Interaction')
		WHERE A.[interactionEmployeeId] NOT IN (
				'1104'
				,'708'
				,'697'
				,'976'
				)
			AND B.obsDateKey IN (
				SELECT DISTINCT dateKey
				FROM [dm].[dim_date]
				)
			AND A.interactionOrganisationId IN (
				SELECT DISTINCT organisationId
				FROM dm.dim_nsp_organisation
				)
			AND A.interactionTemplateId IN (
				SELECT DISTINCT templateId
				FROM [dm].[dim_nsp_template]
				)
			AND B.observationEntityId IN (
				SELECT DISTINCT entityId
				FROM dm.dim_nsp_entity_master
				)
			AND A.interactionTemplateId IN (
				SELECT DISTINCT templateId
				FROM dm.dim_nsp_template
				)
			AND B.observationCriteriaId IN (
				SELECT DISTINCT criteriaId
				FROM dm.dim_nsp_criteria
				)
			AND A.interactionEmployeeId IN (
				SELECT DISTINCT employeeId
				FROM dm.dim_nsp_employee
				)
		);
GO