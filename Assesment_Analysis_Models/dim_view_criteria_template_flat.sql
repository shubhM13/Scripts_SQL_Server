/*******************************************
 Author     : Shubham Mishra
 Created On : 16th March
 PURPOSE    : DimCriteriaTemplateFlat 
 *******************************************/
--drop view dm.view_criteria_template_flat
CREATE VIEW dm.view_criteria_template_flat
AS
(
		SELECT DISTINCT a.criteriaId
					    ,STUFF(
						 (SELECT DISTINCT ',' + templateId
						  FROM [dwh].[AT_TemplateToCriteria]
						  WHERE criteriaId = a.criteriaId
						  FOR XML PATH (''))
						  , 1, 1, '')  AS templateIds
		FROM [dwh].[AT_TemplateToCriteria] AS a
		GROUP BY criteriaId
		);

DROP TABLE dm.criteria_template_flat;

SELECT *
INTO dm.dim_criteria_template_flat
FROM dm.view_criteria_template_flat;

ALTER TABLE dm.dim_criteria_template_flat ADD CONSTRAINT dimCriteriaTemplate_pk PRIMARY KEY (criteriaId);

SELECT COUNT(*)
FROM dm.view_criteria_template_flat

SELECT COUNT(distinct criteriaId)
FROM [dwh].[AT_TemplateToCriteria]

SELECT COUNT(distinct criteriaId)
FROM [dm].[dim_criteria];
