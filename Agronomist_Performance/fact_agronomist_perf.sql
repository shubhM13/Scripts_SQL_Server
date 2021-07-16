/*******************************************
 Author     : Shubham Mishra
 Created On : 25th April, 2021
 PURPOSE    : Agronomist Performance
 *******************************************/
--drop view dm.view_fact_nsc_agronomist_performance				
CREATE VIEW [dm].[view_fact_nsc_agronomist_performance]
AS
(
		SELECT DISTINCT (A.interactionId)
			,ISNULL(B.name, '') AS interactionOrgName
			,ISNULL(A.entityId, '') AS interactionEntityId
			,ISNULL(A.employeeId, '') AS interactionEmployeeId
			,ISNULL(A.templateId, '') AS interactionTemplateId
			,CAST(A.startDate AS DATE) AS interactionStartDate
			,CAST(FORMAT(cast(A.startDate AS DATE), 'yyyyMMdd') AS INT) AS startDateKey
			,CAST(A.endDate AS DATE) AS interactionEndDate
			,CAST(FORMAT(cast(A.endDate AS DATE), 'yyyyMMdd') AS INT) AS endDateKey
		FROM dwh.IT_Interaction AS A
		INNER JOIN [dwh].[CT_Organisation] AS B ON B.organisationId = A.organisationId
			AND B.lineOfBusiness IN ('NESCAFE', 'GLOBAL')
			AND A.type = 'ASSESSMENT'
		LEFT JOIN [dwh].[CT_Employee] AS C ON A.[auditInfo.modifiedBy] = C.userName
		WHERE A.STATUS = 'COMPLETED'
			AND A.varietyTrialId IS NULL
			AND A.siteTrialId IS NULL
			AND A.entityId IN (select distinct entityId from [dm].[dim_nsc_entity_master])
			AND A.employeeId IN (select distinct employeeId from [dm].[dim_nsc_employee])
			AND CAST(FORMAT(cast(A.startDate AS DATE), 'yyyyMMdd') AS INT) IN (select distinct DateKey from [dm].[dim_date])
			AND A.templateId IN (select distinct assessmentId from [dm].[dim_assessment])
		);
GO

select * from [dm].[view_fact_nsc_agronomist_performance];
drop table [dm].[dim_fact_nsc_agronomist_performance];

select * 
into [dm].[dim_fact_nsc_agronomist_performance]
from [dm].[view_fact_nsc_agronomist_performance];

ALTER TABLE [dm].[dim_fact_nsc_agronomist_performance]  ADD CONSTRAINT dimAgPer_pk PRIMARY KEY (interactionId);