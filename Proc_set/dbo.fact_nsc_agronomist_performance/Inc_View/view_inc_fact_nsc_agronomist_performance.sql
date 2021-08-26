/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_fact_nsc_agronomist_performance]    Script Date: 22/07/2021 3:04:01 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 25rd April, 2021
 PURPOSE    : Agronomist Performance
 *******************************************/
--drop view dm.view_inc_fact_nsc_agronomist_performance				
CREATE VIEW [dm].[view_inc_fact_nsc_agronomist_performance]
AS
(
		SELECT DISTINCT (A.interactionId)
			,ISNULL(B.name, '') AS interactionOrgName
			,ISNULL(A.entityId, '') AS interactionEntityId
			,ISNULL(A.employeeId, '') AS interactionEmployeeId
			,ISNULL(A.templateId, '') AS interactionTemplateId
			,CAST(A.startDate AS DATETIME) AS interactionStartDate
			,CAST(FORMAT(cast(A.startDate AS DATE), 'yyyyMMdd') AS INT) AS startDateKey
			,CAST(A.endDate AS DATETIME) AS interactionEndDate
			,CAST(FORMAT(cast(A.endDate AS DATE), 'yyyyMMdd') AS INT) AS endDateKey
		FROM dwh.IT_Interaction AS A
		INNER JOIN [dwh].[CT_Organisation] AS B ON B.organisationId = A.organisationId
			AND B.lineOfBusiness IN (
				'NESCAFE'
				,'GLOBAL'
				)
			AND A.type = 'ASSESSMENT'
		AND A.[auditInfo.modifiedOn] >= (select LastTrigger from [AUDIT].[WaterMarkRT] where schemaname = 'IT' and tablename = 'Interaction')
		AND A.[auditInfo.modifiedOn] <= (select CurrentTrigger from [AUDIT].[WaterMarkRT] where schemaname = 'IT' and tablename = 'Interaction')
		LEFT JOIN [dwh].[CT_Employee] AS C ON A.[auditInfo.modifiedBy] = C.userName
		WHERE A.STATUS = 'COMPLETED'
			AND A.varietyTrialId IS NULL
			AND A.siteTrialId IS NULL
			AND A.entityId IN (
				SELECT DISTINCT entityId
				FROM [dm].[dim_nsc_entity_master]
				)
			AND A.employeeId IN (
				SELECT DISTINCT employeeId
				FROM [dm].[dim_nsc_employee]
				)
			AND CAST(FORMAT(cast(A.startDate AS DATE), 'yyyyMMdd') AS INT) IN (
				SELECT DISTINCT DateKey
				FROM [dm].[dim_date]
				)
			AND A.templateId IN (
				SELECT DISTINCT assessmentId
				FROM [dm].[dim_assessment]
				)
		);
GO