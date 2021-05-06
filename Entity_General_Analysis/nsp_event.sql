SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 30th April, 2021
 PURPOSE    : Dim Event Nespresso Dataset
 *******************************************/
--drop view dm.view_dim_nsp_event
CREATE VIEW [dm].[view_dim_nsp_event]
AS
(
		SELECT DISTINCT (A.eventId)
			,ISNULL(A.externalId, '') AS eventExternalId
			,ISNULL(B.name, '') AS eventOrgName
			,ISNULL(G.label, '') AS eventType
			,ISNULL(H.label, '') AS eventStatus
			,ISNULL(A.name, '') AS eventName
			,ISNULL(A.description, '') AS eventDescription
			,cast(A.startDate AS DATE) AS eventStartDate
			,CAST(FORMAT(cast(A.startDate AS DATE), 'yyyyMMdd') AS INT) AS startDateKey
			,cast(A.endDate AS DATE) AS eventEndDate
			,CAST(FORMAT(cast(A.endDate AS DATE), 'yyyyMMdd') AS INT) AS endDateKey
			,ISNULL(A.location, '') AS eventLocation
			,ISNULL(E.eventEmployees, '') AS employeeNames
			,ISNULL(E.employeeEmails, '') AS employeeEmails
			,ISNULL(E.employeeCount, '') AS employeeCount
			,ISNULL(F.personAttended, '') AS attendees
			,ISNULL(F.attendedCount, '') AS attendedPersonCount 
			,ISNULL(I.label, '') AS interactionType
			,D.status AS interactionStatus
		FROM [dwh].[IT_Event] AS A
		INNER JOIN [dwh].[CT_Organisation] AS B WITH (NOLOCK)
			ON B.organisationId = A.organisationId
				AND B.lineOfBusiness IN (
					'NESPRESSO'
					,'GLOBAL'
					)
		INNER JOIN [dwh].[IT_Interaction] AS D WITH (NOLOCK)
			ON A.eventId = D.eventId
				AND D.STATUS <> 'CANCELLED'
				AND D.type IN ('EVENT', 'ADHOC_EVENT','TRAINING', 'TRAINING_FEEDBACK')
		LEFT JOIN dm.view_event_to_employee_flat AS E WITH (NOLOCK) ON A.eventId = E.eventId  
		LEFT JOIN dm.view_event_to_person_flat AS F WITH (NOLOCK) ON A.eventId = F.eventId  
		LEFT JOIN [dm].[dim_list_option] AS G WITH (NOLOCK)
			ON A.eventType = G.itemCode
				AND G.setId = 'EVENT_TYPE'
		LEFT JOIN [dm].[dim_list_option] AS H WITH (NOLOCK)
			ON A.status = H.itemCode
				AND H.setId = 'EVENT_STATUS'
		LEFT JOIN [dm].[dim_list_option] AS I WITH (NOLOCK)
			ON D.type = I.itemCode
				AND I.setId = 'INTERACTION_TYPE'

		);
GO

select * from dm.dim_list_option where setId = 'INTERACTION_TYPE';
select distinct type from [dwh].[IT_Interaction];
select count(*) from [dm].[view_dim_nsp_Event];

drop table [dm].[dim_nsp_Event];
select *
into [dm].[dim_nsp_Event]
from [dm].[view_dim_nsp_Event];

select * from (select eventId, count(*) as count from [dm].[dim_nsp_Event] group by eventId)AS A where count > 1;
ALTER TABLE [dm].[dim_nsp_Event] ADD CONSTRAINT dimNspEvent_pk PRIMARY KEY (eventId);
select * from [dm].[dim_nsp_Event] where eventId = 'A119C05F41E63A4CE10000000A793047';

select * from [dm].[dim_nsp_Event];

