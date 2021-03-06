/*******************************************
 Author     : Shubham Mishra
 Created On : 2nd June, 2021
 PURPOSE    : InteractionBaseFact Nespresso Dataset
 *******************************************/
--drop view dm.view_fact_nsp_interaction_base                
CREATE VIEW [dm].[view_fact_nsp_interaction_base]
AS
(
        SELECT DISTINCT (A.interactionId)
            ,ISNULL(B.name, '') AS interactionOrgName
            ,ISNULL(E.label, '') AS interactionStatus
            ,ISNULL(D.label, '') AS interactionType
            ,A.entityId AS interactionEntityId
            ,A.employeeId AS interactionEmployeeId
            ,A.eventId AS interactionEventId
            ,A.personId AS interactionPersonId
            ,A.templateId AS interactionTemplateId
            ,CAST(A.startDate AS DATE) AS interactionStartDate
            ,CAST(FORMAT(cast(A.startDate AS DATE), 'yyyyMMdd') AS INT) AS startDateKey
            ,CAST(A.endDate AS DATE) AS interactionEndDate
            ,CAST(FORMAT(cast(A.endDate AS DATE), 'yyyyMMdd') AS INT) AS endDateKey
            ,A.organisationId AS interactionOrganisationId
            ,ISNULL(C.[contactInfo.email], '') AS agronomistEmail
            ,CAST(A.[auditInfo.modifiedOn] AS DATE) AS interactionModifiedOn
			,ISNULL(A.[auditInfo.modifiedBy], '') AS interactionModifiedBy
        FROM dwh.IT_Interaction AS A
        INNER JOIN [dwh].[CT_Organisation] AS B WITH (NOLOCK) ON A.organisationId = B.organisationId
            AND B.lineOfBusiness IN (
                'NESPRESSO'
                ,'GLOBAL'
                )
        INNER JOIN [dwh].[CT_Employee] AS C WITH (NOLOCK) ON A.employeeId = C.employeeId
		INNER JOIN dwh.CT_Organisation AS X ON C.organisationId = X.organisationId
		AND X.lineOfBusiness IN ('NESPRESSO', 'GLOBAL')
        LEFT JOIN [dm].[dim_list_option] AS D WITH (NOLOCK) ON A.type = D.itemCode
            AND D.setId = 'INTERACTION_TYPE'
        LEFT JOIN [dm].[dim_list_option] AS E WITH (NOLOCK) ON A.STATUS = E.itemCode
            AND E.setId = 'PERSONAL_INTERACTION_STATUS'
        WHERE A.status  <> 'CANCELLED'
			AND A.status <> 'DELETED'
            AND A.varietyTrialId IS NULL
            AND A.siteTrialId IS NULL
        );
GO

select * from [dm].[fact_nsp_interaction_base];
select * from [dm].[view_fact_nsp_interaction_base];

drop table [dm].[fact_nsp_interaction_base];

select *
into [dm].[fact_nsp_interaction_base]
from [dm].[view_fact_nsp_interaction_base];

ALTER TABLE [dm].[fact_nsp_interaction_base] ADD CONSTRAINT dimNspIntBase_pk PRIMARY KEY (interactionId);