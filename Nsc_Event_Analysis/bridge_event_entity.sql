/****** Object:  View [dm].[view_fact_nsc_event_analysis]    Script Date: 13/05/2021 8:21:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 13th May, 2021
 PURPOSE    : Event Analysis Nescafe Dataset
 *******************************************/

--drop view [dm].[view_bridge_nsc_event_to_entity]		
CREATE VIEW [dm].[view_bridge_nsc_event_to_entity]
AS
(
		SELECT DISTINCT A.interactionId
						,A.eventId
						,A.entityId
		FROM [dwh].[IT_Interaction] AS A
		INNER JOIN [dwh].[CT_Organisation] AS B
		ON A.organisationId = B.organisationId
		AND B.lineOfBusiness IN ('GLOBAL', 'NESCAFE')
		AND A.type = 'EVENT'
		AND A.status = 'COMPLETED'
		);
GO

select * from [dwh].[IT_Interaction] where eventId IN (select distinct eventId from [dm].[view_fact_nsc_event_analysis]
where eventId NOT IN (select distinct eventId from [dm].[view_bridge_nsc_event_to_entity]));

drop table [dm].[bridge_nsc_event_to_entity];

select * into
[dm].[bridge_nsc_event_to_entity]
from [dm].[view_bridge_nsc_event_to_entity];

ALTER TABLE [dm].[bridge_nsc_event_to_entity] ADD CONSTRAINT brdgNscEventToPerson PRIMARY KEY (interactionId);

select * from [dm].[fact_nsc_event_analysis] where eventId NOT IN (select distinct eventId from [dm].[bridge_nsc_event_to_entity]);

select * from [dm].[bridge_nsc_event_to_entity] where entityid NOT IN (select distinct entityId from [dm].[dim_nsc_entity_master])


--------------------------------------------

/****** Object:  Table [dm].[bridge_nsc_event_to_entity]    Script Date: 14/05/2021 3:09:16 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dm].[bridge_nsc_event_to_entity](
	[interactionId] [varchar](50) NOT NULL,
	[eventId] [varchar](50) NULL,
	[entityId] [varchar](50) NULL,
 CONSTRAINT [brdgNscEventToPerson] PRIMARY KEY CLUSTERED 
(
	[interactionId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dm].[bridge_nsc_event_to_entity]  WITH CHECK ADD  CONSTRAINT [FK_bridge_nsc_event_to_entity_dim_nsc_entity_master] FOREIGN KEY([entityId])
REFERENCES [dm].[dim_nsc_entity_master] ([entityId])
GO

ALTER TABLE [dm].[bridge_nsc_event_to_entity] CHECK CONSTRAINT [FK_bridge_nsc_event_to_entity_dim_nsc_entity_master]
GO

ALTER TABLE [dm].[bridge_nsc_event_to_entity]  WITH CHECK ADD  CONSTRAINT [FK_bridge_nsc_event_to_entity_fact_nsc_event_analysis] FOREIGN KEY([eventId])
REFERENCES [dm].[fact_nsc_event_analysis] ([eventId])
GO

ALTER TABLE [dm].[bridge_nsc_event_to_entity] CHECK CONSTRAINT [FK_bridge_nsc_event_to_entity_fact_nsc_event_analysis]
GO


