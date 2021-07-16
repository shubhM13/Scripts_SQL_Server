/****** Object:  View [dm].[view_bridge_nsc_event_person]    Script Date: 13/05/2021 4:07:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 18th may, 2021
 PURPOSE    : Event Analysis Nespresso
 *******************************************/
--drop view dm.view_bridge_nsp_event_to_attended_persons
CREATE VIEW [dm].[view_bridge_nsp_event_to_attended_persons_entities]
AS
(
		SELECT DISTINCT B.eventId AS eventId
			,B.personId
			,D.entityId
		FROM [dwh].[IT_Event] AS A
        LEFT JOIN [dwh].[IT_EventToPerson] AS B
        ON B.eventId = A.eventId
		INNER JOIN [dwh].[ET_Person] AS D
		ON B.personId = D.personId
		INNER JOIN [dwh].[CT_Organisation] AS C ON C.organisationId = A.organisationId
			AND C.lineOfBusiness IN (
				'GLOBAL'
				,'NESPRESSO'
				)
		WHERE A.eventId IN (
				SELECT DISTINCT eventId
				FROM [dwh].[IT_Interaction] AS P
				INNER JOIN [dwh].[CT_Organisation] AS Q ON P.organisationId = Q.organisationId
					AND P.type = 'EVENT'
					AND P.STATUS = 'COMPLETED'
					AND Q.lineOfBusiness IN (
						'GLOBAL'
						,'NESPRESSO'
						)
				)
		);
GO

drop table [dm].[bridge_nsp_event_to_attended_persons_entities];

select * 
into [dm].[bridge_nsp_event_to_attended_persons_entities]
from [dm].[view_bridge_nsp_event_to_attended_persons_entities];