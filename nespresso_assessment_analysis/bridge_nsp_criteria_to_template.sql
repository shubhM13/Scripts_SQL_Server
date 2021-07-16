SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 13th June, 2021
 PURPOSE    : Bridge table between criteria to template
 *******************************************/

--drop view [dm].[view_bridge_nsp_criteria_to_template]	
CREATE VIEW [dm].[view_bridge_nsp_criteria_to_template]
AS
(
		SELECT DISTINCT A.criteriaId
						,A.templateId
						,A.sortOrder
		FROM [dwh].[AT_TemplateToCriteria] AS A
		INNER JOIN dwh.AT_Template AS B
		ON A.templateId = B.templateId
		AND A.templateId NOT LIKE '%NESCAFE%'
		INNER JOIN dwh.CT_Organisation AS C
		ON B.organisationId = C.organisationId
        AND C.organisationId NOT LIKE '%NESCAFE%'
		AND C.lineOfBusiness IN ('GLOBAL', 'NESPRESSO')
		);
GO

select * from [dm].[view_bridge_nsp_criteria_to_template];
select count(distinct templateId) from [dm].[view_bridge_nsp_criteria_to_template];

select distinct interactionTemplateId 
from dm.fact_nsp_assessment_analysis
EXCEPT 
select distinct templateId
from [dm].[bridge_nsp_criteria_to_template]


drop table [dm].[bridge_nsp_criteria_to_template];

select * into
[dm].[bridge_nsp_criteria_to_template]
from [dm].[view_bridge_nsp_criteria_to_template];

ALTER TABLE [dm].[bridge_nsp_criteria_to_template] ADD CONSTRAINT brdgNspCriteriaToTemplate PRIMARY KEY (criteriaId, templateId);

select * from [dm].[bridge_nsp_criteria_to_template];


