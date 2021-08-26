/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_fact_nsc_adoption]    Script Date: 22/07/2021 10:07:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 16th April, 2021
 PURPOSE    : Adoption Report
 *******************************************/
--drop view dm.view_inc_fact_nsc_adoption
CREATE VIEW [dm].[view_inc_fact_nsc_adoption]
AS
(
		SELECT A.[interactionId]
			,A.[interactionStartDate] AS interactionStartDate
			,A.[startDateKey] AS startDateKey
			,ISNULL(A.[interactionOrgName], '') AS orgName
			,E.[personInfo.firstName] + ' ' + E.[personInfo.lastName] AS employee_name
			,ISNULL(A.[agronomistEmail], '') AS agronomistEmail
			,B.[observationId] AS observationId
			,B.[obsDate] AS obsDate
			,B.[obsDateKey] AS obsDateKey
			,ISNULL(B.[observationEntityId], '') AS entityId
			,ISNULL(C.geoNodeId, '') AS geoNodeId
			,ISNULL(B.[observationCriteriaId], '') AS criteriaId
			,ISNULL(H.topicCodes, '') AS criteriaTopicCodes
			,ISNULL(H.topicTxts, '') AS criteriaTopicCodeTxts
			,ISNULL(B.[answerType], '') AS answerType
			,B.answerCode
			,ISNULL(B.[answerCodeTxt], '') AS answerCodeTxt
			,B.[answerCodeScore] AS answerCodeScore
			,B.answerNumber
			,F.label AS unitOfMeasure
			,ISNULL(B.[isLatest], 0) AS isLatest
			,ISNULL(B.[isLatestByYear], 0) AS isLatestByYear
		FROM dm.dim_interaction AS A
		INNER JOIN dm.dim_observation AS B ON A.interactionId = B.interactionId
			AND A.interactionStatus = 'COMPLETED'
		AND A.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'IT' and sqltablename = 'Interaction')
		INNER JOIN [dwh].[ET_Entity] AS C ON B.[observationEntityId] = C.entityId
		INNER JOIN [dwh].[CT_Organisation] AS D ON A.interactionOrganisationId = D.organisationId
		INNER JOIN [dm].[dim_employee] AS E ON A.interactionEmployeeId = E.employeeId
		LEFT JOIN [dm].[dim_list_option] F ON F.[itemCode] = B.unitOfMeasure
			AND F.setId = 'UOM'
		LEFT JOIN [dm].[dim_criteria_topic_flat] AS H ON B.observationCriteriaId = H.criteriaId
		WHERE A.[interactionEmployeeId] NOT IN (
				'1104'
				,'708'
				,'697'
				,'976'
				)
			AND A.interactionTemplateId = 'AD07565D3F690CD7E10000000A4E71D5'
			AND D.lineOfBusiness = 'NESCAFE'
			AND B.obsDateKey IN (
				SELECT DISTINCT dateKey
				FROM [dm].[dim_date]
				)
			AND A.startDateKey IN (
				SELECT DISTINCT dateKey
				FROM [dm].[dim_date]
				)
			AND A.interactionEmployeeId IN (
				SELECT DISTINCT employeeId
				FROM [dm].[dim_employee]
				)
			AND A.interactionOrganisationId IN (
				SELECT DISTINCT organisationId
				FROM [dwh].[CT_Organisation]
				)
			AND A.interactionTemplateId IN (
				SELECT DISTINCT templateId
				FROM [dm].[dim_template]
				)
			AND B.observationEntityId IN (
				SELECT DISTINCT entityId
				FROM [dm].[dim_entity_master]
				)
			AND C.geoNodeId IN (
				SELECT DISTINCT geoNodeId
				FROM [dm].[dim_geonode_flat]
				)
		);
GO