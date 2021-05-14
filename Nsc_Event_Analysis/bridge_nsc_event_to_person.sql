/****** Object:  View [dm].[view_bridge_nsc_event_person]    Script Date: 13/05/2021 4:07:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 18th may, 2021
 PURPOSE    : Event Analysis Nescafe
 *******************************************/
--drop view dm.view_bridge_nsc_event_to_person
CREATE VIEW [dm].[view_bridge_nsc_event_to_person]
AS
(
		SELECT DISTINCT B.eventId AS eventId
			,B.personId
		FROM [dwh].[IT_Event] AS A
        LEFT JOIN [dwh].[IT_EventToPerson] AS B
        ON B.eventId = A.eventId
		INNER JOIN [dwh].[CT_Organisation] AS C ON C.organisationId = A.organisationId
			AND C.lineOfBusiness IN (
				'GLOBAL'
				,'NESCAFE'
				)
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

drop table [dm].[bridge_nsc_event_to_person];

select * 
into [dm].[bridge_nsc_event_to_person]
from [dm].[view_bridge_nsc_event_to_person];

select * from [dm].[fact_nsc_event_analysis]
where eventId NOT IN (select distinct eventId from [dm].[bridge_nsc_event_to_person]);

select distinct personId from [dm].[bridge_nsc_event_to_person] where personId NOT IN (select distinct personId from  [dm].[dim_nsc_person])


-----------------------------------------

/****** Object:  Table [dm].[bridge_nsc_event_to_person]    Script Date: 14/05/2021 3:10:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dm].[bridge_nsc_event_to_person](
	[eventId] [varchar](50) NULL,
	[personId] [varchar](50) NULL
) ON [PRIMARY]
GO

ALTER TABLE [dm].[bridge_nsc_event_to_person]  WITH CHECK ADD  CONSTRAINT [FK_bridge_nsc_event_to_person_dim_nsc_person] FOREIGN KEY([personId])
REFERENCES [dm].[dim_nsc_person] ([personId])
GO

ALTER TABLE [dm].[bridge_nsc_event_to_person] CHECK CONSTRAINT [FK_bridge_nsc_event_to_person_dim_nsc_person]
GO

ALTER TABLE [dm].[bridge_nsc_event_to_person]  WITH CHECK ADD  CONSTRAINT [FK_bridge_nsc_event_to_person_fact_nsc_event_analysis] FOREIGN KEY([eventId])
REFERENCES [dm].[fact_nsc_event_analysis] ([eventId])
GO

ALTER TABLE [dm].[bridge_nsc_event_to_person] CHECK CONSTRAINT [FK_bridge_nsc_event_to_person_fact_nsc_event_analysis]
GO



