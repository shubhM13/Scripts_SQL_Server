/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 22nd April, 2021
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
            ,ISNULL(A.entityId, '') AS interactionEntityId
            ,ISNULL(A.employeeId, '') AS interactionEmployeeId
            ,ISNULL(A.eventId, '') AS interactionEventId
            ,ISNULL(A.personId, '') AS interactionPersonId
            ,ISNULL(A.templateId, '') AS interactionTemplateId
            ,CAST(A.startDate AS DATE) AS interactionStartDate
            ,CAST(FORMAT(cast(A.startDate AS DATE), 'yyyyMMdd') AS INT) AS startDateKey
            ,CAST(A.endDate AS DATE) AS interactionEndDate
            ,CAST(FORMAT(cast(A.endDate AS DATE), 'yyyyMMdd') AS INT) AS endDateKey
            ,ISNULL(A.organisationId, '') AS interactionOrganisationId
            ,ISNULL(C.[contactInfo.email], '') AS agronomistEmail
            ,ISNULL(CAST(A.[auditInfo.modifiedOn] AS DATE), '') AS interactionModifiedOn
            ,CAST(FORMAT(cast(A.[auditInfo.modifiedOn] AS DATE), 'yyyyMMdd') AS INT) AS interactionModifiedOnKey
        FROM dwh.IT_Interaction AS A
        INNER JOIN [dwh].[CT_Organisation] AS B WITH (NOLOCK) ON A.organisationId = B.organisationId
            AND B.lineOfBusiness IN (
                'NESPRESSO'
                ,'GLOBAL'
                )
        LEFT JOIN [dwh].[CT_Employee] AS C WITH (NOLOCK) ON A.[auditInfo.modifiedBy] = C.userName
        LEFT JOIN [dm].[dim_list_option] AS D WITH (NOLOCK) ON A.type = D.itemCode
            AND D.setId = 'INTERACTION_TYPE'
        LEFT JOIN [dm].[dim_list_option] AS E WITH (NOLOCK) ON A.STATUS = E.itemCode
            AND E.setId = 'PERSONAL_INTERACTION_STATUS'
        WHERE A.STATUS <> 'CANCELLED'
            AND A.varietyTrialId IS NULL
            AND A.siteTrialId IS NULL
        );
GO

select *
into [dm].[fact_nsp_interaction_base]
from [dm].[view_fact_nsp_interaction_base];

ALTER TABLE [dm].[fact_nsp_interaction_base] ADD CONSTRAINT dimNspIntBase_pk PRIMARY KEY (interactionId);