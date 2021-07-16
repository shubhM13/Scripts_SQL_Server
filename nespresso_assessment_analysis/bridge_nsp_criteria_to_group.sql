SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 13th June, 2021
 PURPOSE    : Bridge table between criteria to criteriaGroup
 *******************************************/

--drop view [dm].[view_bridge_nsp_criteria_to_group]	
CREATE VIEW [dm].[view_bridge_nsp_criteria_to_group]
AS
(
		SELECT DISTINCT X.observationCriteriaId AS criteriaId
						,ISNULL(A.groupCode, 'N/A') AS groupCode
						,ISNULL(B.label, 'N/A') AS criteriaGroupCodeTxt
						,ISNULL(A.criteriaEvaluationContext, 'N/A') AS criteriaEvaluationContext
						,ISNULL(C.label, 'N/A') AS criteriaEvaluationContextTxt
		FROM dm.fact_nsp_assessment_analysis AS X
		LEFT JOIN dwh.AT_CriteriaToCriteriaGroup AS A
		ON X.observationCriteriaId = A.criteriaId
		LEFT JOIN [dm].[dim_list_option] AS B ON B.setId = 'CRITERIA_GROUPS'
			AND B.itemCode = A.groupCode
		LEFT JOIN [dm].[dim_list_option] AS C ON C.setId = 'CRITERIA_EVAL_CONTEXT'
			AND C.itemCode = A.criteriaEvaluationContext
		);
GO

select * from [dm].[view_bridge_nsp_criteria_to_group];

select distinct observationCriteriaId 
from dm.fact_nsp_assessment_analysis
EXCEPT 
select distinct criteriaId
from [dm].[view_bridge_nsp_criteria_to_group];

drop table [dm].[bridge_nsp_criteria_to_group];

select * into
[dm].[bridge_nsp_criteria_to_group]
from [dm].[view_bridge_nsp_criteria_to_group];

ALTER TABLE [dm].[bridge_nsp_criteria_to_group] ADD CONSTRAINT brdgNspCriteriaToGroup PRIMARY KEY (criteriaId, groupCode);

select * from [dm].[bridge_nsp_criteria_to_group];