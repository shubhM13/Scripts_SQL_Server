/*******************************************
 Name		: dm.view_event_to_topic_flat
 Author     : Shubham Mishra
 Created On : 18th May
 PURPOSE    : Entity General Analysis | Event Analysis Model
 *******************************************/
 --drop view dm.view_dim_event_to_topic_flat;
CREATE VIEW dm.view_dim_event_to_topic_flat
AS
(
		SELECT DISTINCT a.eventId
					    ,STUFF(
						 (SELECT 
                          CASE WHEN Q.label IS NULL OR Q.label = 'NULL'
                          THEN  ''
                          ELSE '; ' + Q.[label]
                          END
						  FROM [dwh].[IT_EventToTopic] AS P
						  LEFT JOIN dm.dim_list_option AS Q ON P.topicCode = Q.itemCode
                          AND Q.setId = 'TOPIC'
						  WHERE P.eventId = a.eventId
						  FOR XML PATH (''))
						  , 1, 1, '')  AS topics
						,count(topicCode) AS topicCounts
		FROM [dwh].[IT_EventToTopic] AS a
		GROUP BY eventId
	);

drop table dm.dim_event_to_topic_flat;

select * into dm.dim_event_to_topic_flat
from dm.view_dim_event_to_topic_flat;

ALTER TABLE dm.dim_event_to_topic_flat ADD CONSTRAINT dimEventToTopic_pk PRIMARY KEY (eventId);

select * from dwh.IT_EventToTopic where eventId = '00F4425A75B23148E10000000A4E71D5';
select * from dm.dim_list_option where itemCode = 'COFFEE NUTRITION'