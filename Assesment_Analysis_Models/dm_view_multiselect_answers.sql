/*******************************************
 Author     : Shubham Mishra
 Created On : 14th March, 2021
 PURPOSE    : dm.view_multiselect_answers
 *******************************************/
--drop view dm.view_multiselect_answers
CREATE VIEW dm.view_multiselect_answers
AS
(
	SELECT A.observationId
		   ,A.selectedCode
		   ,C.answerListSetId
		   ,D.label AS answerText
		   ,D.score AS answerScore
	FROM [dwh].[AT_SelectedListAnswer] AS A
	INNER JOIN [dwh].[AT_Observation] AS B ON A.observationId = B.observationId
	INNER JOIN [dwh].[AT_Criteria] AS C ON B.criteriaId = C.criteriaId
	INNER JOIN [dm].[dim_list_option] AS D ON C.answerListSetId = D.setId
	AND A.selectedCode = D.itemCode
);
select top(1000) * from dm.view_multiselect_answers
SELECT
     observationId
     ,STUFF(
         (SELECT DISTINCT ',' + selectedCode
          FROM dm.view_multiselect_answers
          WHERE observationId = a.observationId
          FOR XML PATH (''))
          , 1, 1, '')  AS selectedCode
     ,STUFF(
         (SELECT DISTINCT ',' + answerListSetId
          FROM dm.view_multiselect_answers
          WHERE observationId = a.observationId
          FOR XML PATH (''))
          , 1, 1, '')  AS answerListSetId
     ,STUFF(
         (SELECT DISTINCT ',' + answerText
          FROM dm.view_multiselect_answers
          WHERE observationId = a.observationId
          FOR XML PATH (''))
          , 1, 1, '')  AS answerText
FROM dm.view_multiselect_answers AS a
GROUP BY observationId