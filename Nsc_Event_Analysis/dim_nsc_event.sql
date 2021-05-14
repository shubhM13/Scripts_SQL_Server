/****** Object:  View [dm].[view_dim_nsc_event]    Script Date: 13/05/2021 5:07:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/*******************************************
 Author     : Shubham Mishra
 Created On : 18th May, 2021
 PURPOSE    : Dim Event Nescafe Dataset
 *******************************************/
--drop view dm.view_dim_nsc_event
CREATE VIEW [dm].[view_dim_nsc_event]
AS
(
		SELECT DISTINCT (A.eventId)
			,ISNULL(A.externalId, '') AS eventExternalId
			,ISNULL(A.name, '') AS eventName
			,ISNULL(J.label, '') AS interactionStatus
			,ISNULL(H.label, '') AS eventStatus
			,ISNULL(I.label, '') AS interactionType
			,ISNULL(G.label, '') AS eventType
			,CASE WHEN Q.eventId IS NULL	
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
			,CASE WHEN P.eventId IS NULL
				  THEN 'No'
				  ELSE 'Yes'
			 END AS attendanceTaken
			,ISNULL(F.attendedCount, 0) AS attendedPersonCount 
			,ISNULL(F.personAttended, '') AS attendees
			,CASE WHEN R.topics IS NULL OR R.topics = ''
			 THEN 0
			 ELSE ISNULL(R.topicCounts, 0) 
			 END AS topicCounts 
			,ISNULL(R.topics, '') AS topics
		FROM [dwh].[IT_Event] AS A
		INNER JOIN [dwh].[CT_Organisation] AS B WITH (NOLOCK)
			ON B.organisationId = A.organisationId
				AND B.lineOfBusiness IN (
					'NESCAFE'
					,'GLOBAL'
					)
		INNER JOIN [dwh].[IT_Interaction] AS D WITH (NOLOCK)
			ON A.eventId = D.eventId
				AND D.type = 'EVENT'
				AND D.status = 'COMPLETED'
		LEFT JOIN [dwh].[IT_Interaction] AS P 
			ON D.eventId = P.eventId
				AND P.type = 'EVENT_ATTENDANCE'
		LEFT JOIN [dwh].[IT_Interaction] AS Q
			ON D.eventId = Q.eventId
				AND Q.type = 'TRAINING_FEEDBACK'
		LEFT JOIN dm.dim_event_to_employee_flat AS E WITH (NOLOCK) ON A.eventId = E.eventId  
		LEFT JOIN dm.dim_event_to_person_flat AS F WITH (NOLOCK) ON A.eventId = F.eventId  
		LEFT JOIN dm.dim_event_to_topic_flat AS R WITH (NOLOCK) ON A.eventId = R.eventId
		LEFT JOIN [dm].[dim_list_option] AS G WITH (NOLOCK)
			ON A.eventType = G.itemCode
				AND G.setId = 'EVENT_TYPE'
		LEFT JOIN [dm].[dim_list_option] AS H WITH (NOLOCK)
			ON A.status = H.itemCode
				AND H.setId = 'EVENT_STATUS'
		LEFT JOIN [dm].[dim_list_option] AS I WITH (NOLOCK)
			ON D.type = I.itemCode
				AND I.setId = 'INTERACTION_TYPE'
		LEFT JOIN [dm].[dim_list_option] AS J WITH (NOLOCK)
			ON D.status = J.itemCode
				AND J.setId = 'PERSONAL_INTERACTION_STATUS'
		);
GO

----------------------
drop table [dm].[dim_nsc_event];

select * 
into [dm].[dim_nsc_event]
from [dm].[view_dim_nsc_event];

ALTER TABLE [dm].[dim_nsc_event] ADD CONSTRAINT dimNscEvent PRIMARY KEY (eventId);

select * from [dm].[dim_nsc_event];

------------------------

select distinct status from dwh.IT_Interaction;

select * from  [dm].[fact_nsc_event_analysis]
where eventId NOT IN 
(select distinct eventId 
from [dm].[dim_nsc_event])

select * from [dm].[dim_nsc_event]
where eventId NOT IN (
select distinct eventId from [dm].[fact_nsc_event_analysis]);

select A.eventId
		,A.type
		,B.eventId
		,B.type
from [dwh].[IT_Interaction] AS A
INNER JOIN [dwh].[IT_Interaction] AS B
ON A.eventId = B.eventId
AND B.type = 'TRAINING_FEEDBACK'
AND A.type = 'EVENT'

select * from [dwh].[IT_Event] where eventId = 'DA9D5F5A0CFD3148E10000000A4E71D5';

[dwh].[IT_EventToPerson]

select distinct eventId from dwh.IT_Interaction 
where type = 'TRAINING_FEEDBACK' --78
INTERSECT
select distinct eventId from dwh.IT_Interaction
where type = 'EVENT' -- 63771
INTERSECT
select distinct eventId from dwh.IT_Interaction
where type = 'EVENT_ATTENDANCE' --15713
INTERSECT
select distinct eventId from [dwh].[IT_EventToPerson]
INTERSECT
select distinct eventId from dwh.IT_Interaction
where type = 'EVENT' -- 63771

select count(*) from (
select distinct eventId from dwh.IT_Interaction
EXCEPT 
select distinct eventId from dwh.IT_EVENT) AS A;

select distinct eventId from dwh.IT_EVENT
EXCEPT 
select distinct eventId from dwh.IT_Interaction;

select distinct type from dwh.IT_Interaction;
select distinct status from dwh.IT_Interaction;
select * from dwh.IT_Interaction where eventId =  '76FD5559764E7929E10000000A4E71D5';

select * from dm.dim_list_option where setId = 'PERSONAL_INTERACTION_STATUS';

select * from dm.dim_nsc_event where eventId NOT IN (select distinct eventId from [dm].[fact_nsc_event_analysis]);


----------------------------------------------------
--------------------------------------------------------------------------------------------

/****** Object:  View [dm].[view_dim_nsc_event]    Script Date: 14/05/2021 2:42:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





/*******************************************
 Author     : Shubham Mishra
 Created On : 18th May, 2021
 PURPOSE    : Dim Event Nescafe Dataset
 *******************************************/
--drop view dm.view_dim_nsc_event
CREATE VIEW [dm].[view_dim_nsc_event]
AS
(
		SELECT DISTINCT (A.eventId)
			,ISNULL(A.externalId, '') AS eventExternalId
			,ISNULL(A.name, '') AS eventName
			,ISNULL(J.label, '') AS interactionStatus
			,ISNULL(H.label, '') AS eventStatus
			,ISNULL(I.label, '') AS interactionType
			,ISNULL(G.label, '') AS eventType
			,CASE WHEN Q.eventId IS NULL	
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
			,CASE WHEN P.eventId IS NULL
				  THEN 'No'
				  ELSE 'Yes'
			 END AS attendanceTaken
			,ISNULL(F.attendedCount, 0) AS attendedPersonCount 
			,ISNULL(F.personAttended, '') AS attendees
			,CASE WHEN R.topics IS NULL OR R.topics = ''
			 THEN 0
			 ELSE ISNULL(R.topicCounts, 0) 
			 END AS topicCounts 
			,ISNULL(R.topics, '') AS topics
		FROM [dwh].[IT_Event] AS A
		INNER JOIN [dwh].[CT_Organisation] AS B WITH (NOLOCK)
			ON B.organisationId = A.organisationId
				AND B.lineOfBusiness IN (
					'NESCAFE'
					,'GLOBAL'
					)
		INNER JOIN [dwh].[IT_Interaction] AS D WITH (NOLOCK)
			ON A.eventId = D.eventId
				AND D.type = 'EVENT'
				AND D.status = 'COMPLETED'
		LEFT JOIN [dwh].[IT_Interaction] AS P 
			ON D.eventId = P.eventId
				AND P.type = 'EVENT_ATTENDANCE'
		LEFT JOIN [dwh].[IT_Interaction] AS Q
			ON D.eventId = Q.eventId
				AND Q.type = 'TRAINING_FEEDBACK'
		LEFT JOIN dm.dim_event_to_employee_flat AS E WITH (NOLOCK) ON A.eventId = E.eventId  
		LEFT JOIN dm.dim_event_to_person_flat AS F WITH (NOLOCK) ON A.eventId = F.eventId  
		LEFT JOIN dm.dim_event_to_topic_flat AS R WITH (NOLOCK) ON A.eventId = R.eventId
		LEFT JOIN [dm].[dim_list_option] AS G WITH (NOLOCK)
			ON A.eventType = G.itemCode
				AND G.setId = 'EVENT_TYPE'
		LEFT JOIN [dm].[dim_list_option] AS H WITH (NOLOCK)
			ON A.status = H.itemCode
				AND H.setId = 'EVENT_STATUS'
		LEFT JOIN [dm].[dim_list_option] AS I WITH (NOLOCK)
			ON D.type = I.itemCode
				AND I.setId = 'INTERACTION_TYPE'
		LEFT JOIN [dm].[dim_list_option] AS J WITH (NOLOCK)
			ON D.status = J.itemCode
				AND J.setId = 'PERSONAL_INTERACTION_STATUS'
		);
GO


/****** Object:  Table [dm].[dim_nsc_event]    Script Date: 14/05/2021 2:44:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dm].[dim_nsc_event](
	[eventId] [varchar](50) NOT NULL,
	[eventExternalId] [nvarchar](50) NOT NULL,
	[eventName] [nvarchar](255) NOT NULL,
	[interactionStatus] [nvarchar](1000) NOT NULL,
	[eventStatus] [nvarchar](1000) NOT NULL,
	[interactionType] [nvarchar](1000) NOT NULL,
	[eventType] [nvarchar](1000) NOT NULL,
	[trainingFeedbackTaken] [varchar](3) NOT NULL,
	[eventOrgName] [nvarchar](255) NOT NULL,
	[eventDescription] [nvarchar](max) NOT NULL,
	[eventStartDate] [date] NULL,
	[eventEndDate] [date] NULL,
	[eventLocation] [nvarchar](max) NOT NULL,
	[employeeCount] [int] NOT NULL,
	[employeeNames] [nvarchar](max) NOT NULL,
	[employeeEmails] [nvarchar](max) NOT NULL,
	[attendanceTaken] [varchar](3) NOT NULL,
	[attendedPersonCount] [int] NOT NULL,
	[attendees] [nvarchar](max) NOT NULL,
	[topicCounts] [int] NOT NULL,
	[topics] [nvarchar](max) NOT NULL,
 CONSTRAINT [dimNscEvent] PRIMARY KEY CLUSTERED 
(
	[eventId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


