/*******************************************
 Author     : Shubham Mishra
 Created On : 16th Feb
 PURPOSE    : DimCriteriaTopicFlat 
 *******************************************/
--drop view dm.view_criteria_topic_flat
CREATE VIEW dm.view_criteria_topic_flat
AS
(
		SELECT DISTINCT A.criteriaId
					    ,STUFF(
						 (SELECT DISTINCT ',' + topicCode
						  FROM dm.view_criteria_topic
						  WHERE criteriaId = a.criteriaId
						  FOR XML PATH (''))
						  , 1, 1, '')  AS topicCodes
					    ,STUFF(
						 (SELECT DISTINCT ',' + topicTxt
						  FROM dm.view_criteria_topic
						  WHERE criteriaId = a.criteriaId
						  FOR XML PATH (''))
						  , 1, 1, '')  AS topicTxts
		FROM dm.view_criteria_topic AS a
		GROUP BY criteriaId
		);

DROP TABLE dm.criteria_topic_flat;

SELECT *
INTO dm.dim_criteria_topic_flat
FROM dm.view_criteria_topic_flat;

ALTER TABLE dm.dim_criteria_topic_flat ADD CONSTRAINT dimCriteriaTopic_pk PRIMARY KEY (criteriaId);

SELECT *
FROM dm.view_criteria_topic_flat

SELECT COUNT(*)
FROM dwh.AT_CriteriaToTopic

SELECT *
FROM [dm].[dim_criteria]
