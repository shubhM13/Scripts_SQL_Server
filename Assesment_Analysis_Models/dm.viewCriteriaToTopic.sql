/*******************************************
 Author     : Shubham Mishra
 Created On : 16th Feb
 PURPOSE    : DimCriteriaTopic 
 *******************************************/
--drop view dm.view_criteria_topic
CREATE VIEW dm.view_criteria_topic
AS
(
		SELECT DISTINCT A.criteriaId
						,A.topicCode
					    ,STUFF(
						 (SELECT DISTINCT ',' + A.topicCode
						  FROM dm.view_multiselect_answers
						  WHERE observationId = a.observationId
						  FOR XML PATH (''))
						  , 1, 1, '')  AS topicCode
						,ISNULL(B.label, '') AS topicTxt
		FROM dwh.AT_CriteriaToTopic AS A
		LEFT JOIN [dm].[dim_list_option] AS B ON B.setId = 'TOPIC'
			AND B.itemCode = A.topicCode
		);

DROP TABLE [dm].[dim_criteria_topic_flat]
SELECT *
INTO [dm].[dim_criteria_topic_flat]
FROM dm.view_criteria_topic;

ALTER TABLE [dm].[dim_criteria_topic] ADD CONSTRAINT dimCriteriaTopic_pk PRIMARY KEY (criteriaId, topicCode);

SELECT COUNT(*)
FROM [dm].[dim_criteria_topic]

SELECT COUNT(*)
FROM dwh.AT_CriteriaToTopic

SELECT *
FROM [dm].[dim_criteria]
