/****** Object:  View [dm].[view_fact_nsc_event_analysis]    Script Date: 13/05/2021 8:21:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 13th May, 2021
 PURPOSE    : Event Analysis Nespresso Dataset
 *******************************************/

--drop view [dm].[view_bridge_nsp_event_to_invited_entities]		
CREATE VIEW [dm].[view_bridge_nsp_event_to_invited_entities]
AS
(
		SELECT DISTINCT A.interactionId
						,A.eventId
						,A.entityId
		FROM [dwh].[IT_Interaction] AS A
		INNER JOIN [dwh].[CT_Organisation] AS B
		ON A.organisationId = B.organisationId
		AND B.lineOfBusiness IN ('GLOBAL', 'NESPRESSO')
		AND A.type = 'EVENT'
		AND A.status = 'COMPLETED'
		);
GO

select * from [dwh].[IT_Interaction] where eventId IN (select distinct eventId from [dm].[view_fact_nsc_event_analysis]
where eventId NOT IN (select distinct eventId from [dm].[view_bridge_nsc_event_to_entity]));

drop table [dm].[bridge_nsp_event_to_invited_entities];

select * into
[dm].[bridge_nsp_event_to_invited_entities]
from [dm].[view_bridge_nsp_event_to_invited_entities];

ALTER TABLE [dm].[bridge_nsp_event_to_invited_entities] ADD CONSTRAINT brdgNspEventToInvEnt PRIMARY KEY (interactionId);