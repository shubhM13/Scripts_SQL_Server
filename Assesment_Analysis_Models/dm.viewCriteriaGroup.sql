/*******************************************
 Author     : Shubham Mishra
 Created On : 17th Feb
 PURPOSE    : DimCriteriaGroup
 *******************************************/
--drop view dm.view_criteria_group
CREATE VIEW dm.view_criteria_group
AS
(
		SELECT DISTINCT A.criteriaId
						,A.groupCode
						,ISNULL(B.label, '') AS criteriaGroupCodeTxt
						,ISNULL(A.criteriaEvaluationContext, '') AS criteriaEvaluationContext
						,ISNULL(C.label, '') AS criteriaEvaluationContextTxt
		FROM dwh.AT_CriteriaToCriteriaGroup AS A
		LEFT JOIN [dm].[dim_list_option] AS B ON B.setId = 'CRITERIA_GROUPS'
			AND B.itemCode = A.groupCode
		LEFT JOIN [dm].[dim_list_option] AS C ON C.setId = 'CRITERIA_EVAL_CONTEXT'
			AND C.itemCode = A.criteriaEvaluationContext
		);

DROP TABLE [dm].[dim_criteria_group]
SELECT *
INTO [dm].[dim_criteria_group]
FROM dm.view_criteria_group;

ALTER TABLE [dm].[dim_criteria_group] ADD CONSTRAINT dimCriteriaGrp_pk PRIMARY KEY (criteriaId);

ALTER TABLE [dm].[dim_criteria_group]
DROP CONSTRAINT dimCriteriaGrp_pk

SELECT COUNT(*)
FROM [dm].[dim_criteria_group]

SELECT COUNT(*)
FROM dwh.AT_CriteriaToCriteriaGroup

select * from [dm].[dim_criteria_group]
where groupCode = '4CNEW'

select * from [dwh].[AT_CriteriaToCriteriaGroup]

