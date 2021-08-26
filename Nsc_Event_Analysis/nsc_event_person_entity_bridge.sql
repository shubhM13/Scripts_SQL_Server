/****** Object:  View [dm].[view_bridge_nsc_event_person]    Script Date: 13/05/2021 4:07:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 1st August, 2021
 PURPOSE    : Event Analysis Nescafe
 *******************************************/
--drop view dm.view_bridge_nsc_event_to_attended_persons_entities
CREATE VIEW [dm].[view_bridge_nsc_event_to_attended_persons_entities]
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

drop table [dm].[bridge_nsc_event_to_attended_persons_entities];

select * 
into [dm].[bridge_nsc_event_to_attended_persons_entities]
from [dm].[view_bridge_nsc_event_to_attended_persons_entities];


ALTER TABLE [dm].[bridge_nsc_event_to_attended_persons_entities] ALTER COLUMN eventId varchar(50) NOT NULL;
ALTER TABLE [dm].[bridge_nsc_event_to_attended_persons_entities] ALTER COLUMN personId varchar(50) NOT NULL;
ALTER TABLE [dm].[bridge_nsc_event_to_attended_persons_entities] ALTER COLUMN entityId varchar(50) NOT NULL;

ALTER TABLE [dm].[bridge_nsc_event_to_attended_persons_entities] ADD CONSTRAINT bridgeNscEventPersonEntity PRIMARY KEY (
	eventId
	,personId
    ,entityId
	);