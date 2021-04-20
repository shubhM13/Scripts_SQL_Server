/*******************************************
 Author     : Shubham Mishra
 Created On : 13th March, 2021
 PURPOSE    : DimCriteriaGroupFlat
 *******************************************/
--drop view dm.view_criteria_group_flat
CREATE VIEW dm.view_criteria_group_flat
AS
(
		SELECT DISTINCT  criteriaId
						,STUFF(
							 (SELECT DISTINCT ',' + groupCode
							  FROM dm.view_criteria_group
							  WHERE criteriaId = a.criteriaId
							  FOR XML PATH (''))
							  , 1, 1, '')  AS groupCodes
		FROM dm.view_criteria_group AS a
		GROUP BY criteriaId
		);

select * from dm.view_criteria_group_flat

DROP TABLE [dm].[dim_criteria_group_flat]

SELECT *
INTO [dm].[dim_criteria_group_flat]
FROM dm.view_criteria_group_flat;

ALTER TABLE [dm].[dim_criteria_group_flat] ADD CONSTRAINT dimCriteriaGrp_pk PRIMARY KEY (criteriaId);


SELECT *
FROM [dm].[dim_criteria_group_flat]


select * from [dm].[dim_criteria_group_flat]
where groupCodes LIKE '%4CNEW%'

select * from [dwh].[AT_CriteriaToCriteriaGroup]

