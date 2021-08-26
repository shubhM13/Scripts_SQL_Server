/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_fact_nsc_4C_analysis]    Script Date: 22/07/2021 10:56:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 20th May, 2021
 PURPOSE    : 4C Assessments
 *******************************************/
--drop view dm.view_inc_fact_nsc_4C_analysis
CREATE VIEW [dm].[view_inc_fact_nsc_4C_analysis]
AS
(
		SELECT A.[interactionId]
			,ISNULL(A.[interactionType], '') AS interactionType
			,ISNULL(A.[interactionEmployeeId], '') AS interactionEmployeeId
			,ISNULL(A.[agronomistEmail], '') AS agronomistEmail
			,ISNULL(A.[interactionTemplateId], '') AS interactionTemplateId
			,A.[interactionStartDate] AS interactionStartDate
			,A.[startDateKey] AS startDateKey
			,ISNULL(A.[interactionOrganisationId], '') AS interactionOrganisationId
			,ISNULL(A.[interactionOrgName], '') AS interactionOrgName
			,A.[interaction_modifiedOn] AS interaction_modifiedOn
			,A.[interaction_modifiedOnKey] AS interaction_modifiedOnKey
			,B.[observationId] AS observationId
			,B.[obsDate] AS obsDate
			,B.[obsDateKey] AS obsDateKey
			,ISNULL(B.[observationEntityId], '') AS entityId
			,ISNULL(C.geoNodeId, '') AS geoNodeId
			,ISNULL(B.[observationCriteriaId], '') AS observationCriteriaId
			,ISNULL(B.[notApplicableFlag], '') AS notApplicableFlag
			,ISNULL(B.[answerType], '') AS answerType
			,ISNULL(B.[answerCode], '') AS answerCode
			,ISNULL(B.[answerCodeTxt], '') AS answerCodeTxt
			,B.[answerCodeScore] AS answerCodeScore
			,ISNULL(B.[isLatest], 0) AS isLatest
			,ISNULL(B.[isLatestByYear], 0) AS isLatestByYear
		FROM dm.dim_interaction AS A
		INNER JOIN dm.dim_observation AS B ON A.interactionId = B.interactionId
		AND A.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'IT' and sqltablename = 'Interaction')
		LEFT JOIN [dwh].[ET_Entity] AS C ON B.[observationEntityId] = C.entityId
		LEFT JOIN [dwh].[AT_TemplateToCriteria] AS E ON E.templateId = A.[interactionTemplateId]
			AND E.criteriaId = B.[observationCriteriaId]
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
			AND A.interactionEmployeeId IN (
				SELECT DISTINCT employeeId
				FROM [dm].[dim_nsc_employee]
				)
			AND A.interactionOrganisationId IN (
				SELECT DISTINCT organisationId
				FROM [dwh].[CT_Organisation]
				WHERE lineOfBusiness IN (
						'GLOBAL'
						,'NESCAFE'
						)
				)
			AND A.interactionTemplateId IN (
				'6F53E05F41993A4CE10000000A793047'
				,'8481E15FB4533A4CE10000000A793047'
				,'FBB5E15FB4533A4CE10000000A793047'
				)
			AND B.observationEntityId IN (
				SELECT DISTINCT entityId
				FROM [dm].[dim_nsc_entity_master]
				)
			AND C.geoNodeId IN (
				SELECT DISTINCT geoNodeId
				FROM [dm].[dim_geonode_flat]
				)
		);
GO