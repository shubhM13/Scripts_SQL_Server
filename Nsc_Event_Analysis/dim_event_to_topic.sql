/****** Object:  View [dm].[view_dim_nsc_event_topic]    Script Date: 13/05/2021 4:07:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 29th April, 2021
 PURPOSE    : Dim Event Topic Nespresso Dataset
 Modified By: Shubham Mishra On 13th may, 2020 // Code Review & Refactor 
 *******************************************/
--drop view dm.view_dim_nsc_event_to_topic
CREATE VIEW [dm].[view_dim_nsc_event_to_topic]
AS
(
		SELECT DISTINCT B.eventId AS eventId
			,ISNULL(D.label, 'N/A') AS topicName
		FROM [dwh].[IT_Event] AS A
        LEFT JOIN [dwh].[IT_EventToTopic] AS B
        ON B.eventId = A.eventId
		INNER JOIN [dwh].[CT_Organisation] AS C ON C.organisationId = A.organisationId
			AND C.lineOfBusiness IN (
				'GLOBAL'
				,'NESCAFE'
				)
		LEFT JOIN [dm].[dim_list_option] AS D ON B.topicCode = D.itemCode
		WHERE A.eventId IN (
				SELECT DISTINCT eventId
				FROM [dwh].[IT_Interaction] AS P
				INNER JOIN [dwh].[CT_Organisation] AS Q ON P.organisationId = Q.organisationId
					AND P.type = 'EVENT'
					AND P.STATUS = 'COMPLETED'
					AND Q.lineOfBusiness IN (
						'GLOBAL'
						,'NESCAFE'
						)
				)
		);
GO

drop table [dm].[dim_nsc_event_to_topic];

select * 
into [dm].[dim_nsc_event_to_topic]
from [dm].[view_dim_nsc_event_to_topic];

select * from [dm].[fact_nsc_event_analysis]
where eventId NOT IN (select distinct eventId from [dm].[dim_nsc_event_to_topic]);


-----------------------------------------------------------------------------------------

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 29th April, 2021
 PURPOSE    : Dim Event Topic Nespresso Dataset
 Modified By: Shubham Mishra On 13th may, 2020 // Code Review & Refactor 
 *******************************************/
--drop view dm.view_dim_nsc_event_to_topic
CREATE VIEW [dm].[view_dim_nsc_event_to_topic]
AS
(
		SELECT DISTINCT B.eventId AS eventId
			,ISNULL(D.label, 'N/A') AS topicName
		FROM [dwh].[IT_Event] AS A
        LEFT JOIN [dwh].[IT_EventToTopic] AS B
        ON B.eventId = A.eventId
		INNER JOIN [dwh].[CT_Organisation] AS C ON C.organisationId = A.organisationId
			AND C.lineOfBusiness IN (
				'GLOBAL'
				,'NESCAFE'
				)
		LEFT JOIN [dm].[dim_list_option] AS D ON B.topicCode = D.itemCode
		WHERE A.eventId IN (
				SELECT DISTINCT eventId
				FROM [dwh].[IT_Interaction] AS P
				INNER JOIN [dwh].[CT_Organisation] AS Q ON P.organisationId = Q.organisationId
					AND P.type = 'EVENT'
					AND P.STATUS = 'COMPLETED'
					AND Q.lineOfBusiness IN (
						'GLOBAL'
						,'NESCAFE'
						)
				)
		);
GO

/****** Object:  Table [dm].[dim_nsc_event_to_topic]    Script Date: 14/05/2021 3:01:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dm].[dim_nsc_event_to_topic](
	[eventId] [varchar](50) NULL,
	[topicName] [nvarchar](1000) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dm].[dim_nsc_event_to_topic]  WITH CHECK ADD  CONSTRAINT [FK_dim_nsc_event_to_topic_fact_nsc_event_analysis] FOREIGN KEY([eventId])
REFERENCES [dm].[fact_nsc_event_analysis] ([eventId])
GO

ALTER TABLE [dm].[dim_nsc_event_to_topic] CHECK CONSTRAINT [FK_dim_nsc_event_to_topic_fact_nsc_event_analysis]
GO






