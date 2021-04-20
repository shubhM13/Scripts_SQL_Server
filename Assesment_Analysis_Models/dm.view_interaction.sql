/*******************************************
 Author     : Shubham Mishra
 Created On : 18th Feb, 2021
 PURPOSE    : DimInteraction
 *******************************************/
--drop view dm.view_interaction
CREATE VIEW dm.view_interaction
AS
(
		SELECT A.interactionId
			,ISNULL(A.type, '') AS interactionType
			,ISNULL(D.label, '') AS interactionTypeTxt
			,ISNULL(A.status, '') AS interactionStatus
			,ISNULL(E.label, '') AS interactionStatusTxt
			,ISNULL(A.entityId, '') AS interactionEntityId
			,ISNULL(A.employeeId, '') AS interactionEmployeeId
			,ISNULL(A.eventId,'') AS interactionEventId
			,ISNULL(A.personId, '') AS interactionPersonId
			,ISNULL(A.templateId, '') AS interactionTemplateId
			,CAST(A.startDate AS DATE) AS interactionStartDate
			,CAST(FORMAT(cast(A.startDate AS DATE), 'yyyyMMdd') AS INT) AS startDateKey
			,CAST(A.endDate AS DATE) AS interactionEndDate
			,CAST(FORMAT(cast(A.endDate AS DATE), 'yyyyMMdd') AS INT) AS endDateKey
			,ISNULL(A.organisationId, '') AS interactionOrganisationId
			,ISNULL(C.name, '') AS interactionOrgName
			,ISNULL(B.[contactInfo.email], '') AS agronomistEmail
			,ISNULL(CAST(A.[auditInfo.modifiedOn] AS DATE), '') AS interaction_modifiedOn
			,CAST(FORMAT(cast(A.[auditInfo.modifiedOn] AS DATE), 'yyyyMMdd') AS INT) AS interaction_modifiedOnKey
		FROM dwh.IT_Interaction AS A
		LEFT JOIN [dwh].[CT_Employee] AS B ON A.[auditInfo.modifiedBy] = B.userName
		LEFT JOIN [dwh].[CT_Organisation] AS C ON C.organisationId = A.organisationId
		LEFT JOIN [dm].[dim_list_option] AS D ON D.setId = 'INTERACTION_TYPE'
			AND D.itemCode = A.type
		LEFT JOIN [dm].[dim_list_option] AS E ON E.setId = 'PERSONAL_INTERACTION_STATUS'
			AND E.itemCode = A.status
		WHERE A.status <> 'CANCELLED' 
		AND A.varietyTrialId IS NULL
		AND A.siteTrialId IS NULL
		);

DROP TABLE [dm].[dim_interaction]

SELECT *
INTO [dm].[dim_interaction]
FROM dm.view_interaction;

ALTER TABLE [dm].[dim_interaction] ADD CONSTRAINT dimInteraction_pk PRIMARY KEY (interactionId);

SELECT COUNT(*)
FROM [dm].[dim_interaction]

SELECT COUNT(*)
FROM [dwh].[IT_interaction]

select distinct status from 
[dwh].[IT_interaction];