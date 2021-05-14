/*******************************************
 Name		: dm.view_event_to_person_flat
 Author     : Shubham Mishra
 Created On : 4th May
 PURPOSE    : Entity General Analysis 
 *******************************************/
 --drop view dm.view_dim_event_to_person_flat;
CREATE VIEW dm.view_dim_event_to_person_flat
AS
(
		SELECT DISTINCT a.eventId
					    ,STUFF(
						 (SELECT DISTINCT '; ' + ISNULL(Q.[personInfo.firstName], '') + ' ' +  ISNULL(Q.[personInfo.lastName], '')
						  FROM [dwh].[IT_EventToPerson] AS P
						  INNER JOIN [dwh].[ET_Person] AS Q ON P.personId = Q.personId
						  WHERE P.eventId = a.eventId
						  FOR XML PATH (''))
						  , 1, 1, '')  AS personAttended
						,count(personId) AS attendedCount
		FROM [dwh].[IT_EventToPerson] AS a
		GROUP BY eventId
	);

drop table dm.dim_event_to_person_flat;

select * into dm.dim_event_to_person_flat
from dm.view_dim_event_to_person_flat;

ALTER TABLE dm.dim_event_to_person_flat ADD CONSTRAINT dimEventToPerson_pk PRIMARY KEY (eventId);