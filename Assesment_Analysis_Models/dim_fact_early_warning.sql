/*******************************************
 Author     : Shubham Mishra
 Created On : 16th March, 2021
 PURPOSE    : Early Warning Report
 *******************************************/
--drop view dm.view_early_warning_base
CREATE VIEW dm.view_early_warning_base
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
			,ISNULL(B.[answerType], '') AS answerType
			,ISNULL(B.[answerCodeTxt], '') AS answerCodeTxt
			,B.[answerCodeScore] AS answerCodeScore
			,ISNULL(B.[isLatest], 0) AS isLatest
			,ISNULL(B.[isLatestByYear], 0) AS isLatestByYear
		FROM dm.dim_interaction AS A
		INNER JOIN dm.dim_observation AS B
		ON A.interactionId = B.interactionId
		AND A.interactionStatus = 'COMPLETED'
		INNER JOIN [dwh].[ET_Entity] AS C ON B.[observationEntityId] = C.entityId
		INNER JOIN [dwh].[CT_Organisation] AS D ON A.interactionOrganisationId = D.organisationId
		INNER JOIN [dm].[dim_employee] AS E
		ON A.interactionEmployeeId = E.employeeId
		WHERE A.[interactionEmployeeId] NOT IN ('1104','708','697','976')
		AND A.interactionTemplateId = 'NESCAFE_EARLY_WARNING_TMPLT'
		AND D.lineOfBusiness = 'NESCAFE'
		AND B.obsDateKey IN (select distinct dateKey from [dm].[dim_date])
		AND A.startDateKey IN (select distinct dateKey from [dm].[dim_date])
		AND A.interactionEmployeeId IN (select distinct employeeId from [dm].[dim_employee])
		AND A.interactionOrganisationId IN (select distinct organisationId from [dwh].[CT_Organisation])
		AND A.interactionTemplateId IN (select distinct templateId from [dm].[dim_template])
		AND B.observationEntityId IN (select distinct entityId from [dm].[dim_entity_master])
		AND C.geoNodeId IN (select distinct geoNodeId from [dm].[dim_geonode_flat])
		);

-- View top 1000
SELECT TOP(1000) *
FROM dm.view_early_warning_base;
select count(*) from  dm.view_early_warning_base;
select count(*) from  dm.view_early_warning_base where isLatestByYear = 1;

---------------------------------------------------------------------------------------------------------
/*******************************************
 Author     : Shubham Mishra
 Created On : 19th April, 2021
 PURPOSE    : Early Warning Report
 *******************************************/
--drop view dm.view_fact_early_warning
CREATE VIEW dm.view_fact_early_warning
AS
(
		SELECT distinct A.*
			  ,count(C.[observationId]) AS assessmentYearlyCount
		FROM dm.view_early_warning_base AS A
		INNER JOIN dm.view_early_warning_base AS C ON A.entityId = C.entityId
		AND A.criteriaId = C.criteriaId
		WHERE A.isLatestByYear = 1
		GROUP BY A.interactionId
				,A.interactionStartDate
				,A.startDateKey
				,A.orgName
				,A.employee_name
				,A.agronomistEmail
				,A.observationId
				,A.obsDate
				,A.obsDateKey
				,A.entityId
				,A.geoNodeId
				,A.criteriaId
				,A.answerType
				,A.answerCodeTxt
				,A.answerCodeScore
				,A.isLatest
				,A.isLatestByYear
);

select * from dm.view_early_warning_base
where entityId = '57FE172D0C2B9114E10000000A4E71D5'
AND criteriaId = 'NESCAFE_EARLY_WARNING_3'

select * from dm.view_fact_early_warning  where entityId = '57FE172D0C2B9114E10000000A4E71D5';

select count(*) from dm.view_early_warning_base
where isLatestByYear = 1;

select A.entityId, A.criteriaId, A.answerCodeTxt, A.isLatestByYear, B.YEAR, A.assessmentYearlyCount  FROM dm.view_fact_early_warning AS A
INNER JOIN dm.dim_date AS B ON A.obsDateKey = B.DateKey
ORDER BY entityId;

DROP TABLE [dm].[fact_nsc_early_warning]

SELECT *
INTO [dm].[fact_nsc_early_warning]
FROM dm.view_fact_early_warning;


select * from [dm].[fact_nsc_early_warning] where interactionId IS NULL or observationId IS NULL

ALTER TABLE [dm].[fact_nsc_early_warning] ALTER COLUMN interactionId varchar(50) NOT NULL;
ALTER TABLE [dm].[fact_nsc_early_warning] ALTER COLUMN observationId varchar(50) NOT NULL;
--ALTER TABLE [dm].[fact_nsc_early_warning] ADD CONSTRAINT dimfactEW_pk PRIMARY KEY (interactionId, observationId);

SELECT COUNT(*)
FROM [dm].[fact_nsc_early_warning]

SELECT COUNT(*)
FROM dm.view_fact_early_warning

select count(*) from dm.view_early_warning_base where isLatestByYear = 1



------------------------------------------------------------------------------------------------------------
 


