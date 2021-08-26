/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_dim_nsc_event]    Script Date: 23/07/2021 6:23:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 18th May, 2021
 PURPOSE    : Dim Event Nescafe Dataset
 *******************************************/
--drop view dm.view_inc_dim_nsc_event
CREATE VIEW [dm].[view_inc_dim_nsc_event]
AS
(
		SELECT DISTINCT (A.eventId)
			,ISNULL(A.externalId, '') AS eventExternalId
			,ISNULL(A.name, '') AS eventName
			,ISNULL(J.label, '') AS interactionStatus
			,ISNULL(H.label, '') AS eventStatus
			,ISNULL(I.label, '') AS interactionType
			,ISNULL(G.label, '') AS eventType
			,CASE 
				WHEN Q.eventId IS NULL
					THEN 'No'
				ELSE 'Yes'
				END AS trainingFeedbackTaken
			,ISNULL(B.name, '') AS eventOrgName
			,ISNULL(A.description, '') AS eventDescription
			,CAST(A.startDate AS DATE) AS eventStartDate
			,CAST(A.endDate AS DATE) AS eventEndDate
			,ISNULL(A.location, '') AS eventLocation
			,ISNULL(E.employeeCount, 0) AS employeeCount
			,ISNULL(E.eventEmployees, '') AS employeeNames
			,ISNULL(E.employeeEmails, '') AS employeeEmails
			,CASE 
				WHEN P.eventId IS NULL
					THEN 'No'
				ELSE 'Yes'
				END AS attendanceTaken
			,ISNULL(F.attendedCount, 0) AS attendedPersonCount
			,ISNULL(F.personAttended, '') AS attendees
			,CASE 
				WHEN R.topics IS NULL
					OR R.topics = ''
					THEN 0
				ELSE ISNULL(R.topicCounts, 0)
				END AS topicCounts
			,ISNULL(R.topics, '') AS topics
		FROM [dwh].[IT_Event] AS A
		INNER JOIN [dwh].[CT_Organisation] AS B WITH (NOLOCK) ON B.organisationId = A.organisationId
			AND B.lineOfBusiness IN (
				'NESCAFE'
				,'GLOBAL'
				)
		AND A.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'IT' and sqltablename = 'Event')
		INNER JOIN [dwh].[IT_Interaction] AS D WITH (NOLOCK) ON A.eventId = D.eventId
			AND D.type = 'EVENT'
			AND D.STATUS = 'COMPLETED'
		LEFT JOIN [dwh].[IT_Interaction] AS P ON D.eventId = P.eventId
			AND P.type = 'EVENT_ATTENDANCE'
		LEFT JOIN [dwh].[IT_Interaction] AS Q ON D.eventId = Q.eventId
			AND Q.type = 'TRAINING_FEEDBACK'
		LEFT JOIN dm.dim_event_to_employee_flat AS E WITH (NOLOCK) ON A.eventId = E.eventId
		LEFT JOIN dm.dim_event_to_person_flat AS F WITH (NOLOCK) ON A.eventId = F.eventId
		LEFT JOIN dm.dim_event_to_topic_flat AS R WITH (NOLOCK) ON A.eventId = R.eventId
		LEFT JOIN [dm].[dim_list_option] AS G WITH (NOLOCK) ON A.eventType = G.itemCode
			AND G.setId = 'EVENT_TYPE'
		LEFT JOIN [dm].[dim_list_option] AS H WITH (NOLOCK) ON A.STATUS = H.itemCode
			AND H.setId = 'EVENT_STATUS'
		LEFT JOIN [dm].[dim_list_option] AS I WITH (NOLOCK) ON D.type = I.itemCode
			AND I.setId = 'INTERACTION_TYPE'
		LEFT JOIN [dm].[dim_list_option] AS J WITH (NOLOCK) ON D.STATUS = J.itemCode
			AND J.setId = 'PERSONAL_INTERACTION_STATUS'
		);
GO