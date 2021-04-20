/*******************************************
 Author     : Shubham Mishra
 Created On : 14th March, 2021
 PURPOSE    : dm.view_multiselect_answers_flat
 *******************************************/
--drop view dm.view_multiselect_answers_flat
CREATE VIEW dm.view_multiselect_answers_flat
AS
(
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
				 (SELECT DISTINCT '; ' + answerText
				  FROM dm.view_multiselect_answers
				  WHERE observationId = a.observationId
				  FOR XML PATH (''))
				  , 1, 1, '')  AS answerText
			 ,STUFF(
				 (SELECT DISTINCT ',' + CAST(answerScore AS varchar)
				  FROM dm.view_multiselect_answers
				  WHERE observationId = a.observationId
				  FOR XML PATH (''))
				  , 1, 1, '')  AS answerScore
		FROM dm.view_multiselect_answers AS a
		GROUP BY observationId
);

drop table [dm].[dim_multiselect_answers_flat];

SELECT *
INTO [dm].[dim_multiselect_answers_flat]
FROM dm.view_multiselect_answers_flat;

ALTER TABLE [dm].[dim_multiselect_answers_flat] ADD CONSTRAINT dimMultiSelect_pk PRIMARY KEY (observationId);

select count(*) from [dm].[view_multiselect_answers_flat];
select count(*) from [dm].[dim_multiselect_answers_flat];
select top(1000) * from [dm].[dim_multiselect_answers_flat];