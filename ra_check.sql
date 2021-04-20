select * from [dm].[view_rainforest_alliance] where interactionId = '1108175F91EAED6162'
select count(interactionId) from [dm].[view_rainforest_alliance]

select * from [dm].[fact_assessment_analysis] AS A 
INNER JOIN [dm].[dim_criteria] AS B 
ON A.observationCriteriaId = B.criteriaId
AND A.interactionId = '1108175F91EAED6162'
AND A.criteriaGroupCode = 'RA'
AND A.observationId = '1108175F91ED9D0163'

INNER JOIN [dm].[dim_list_option] AS C
ON C.setId = 'LIST_MULTI'
AND C.itemCode = A.multiListAnswerCode

select interactionId, observationId, multiListAnswerCode from [dm].[fact_assessment_analysis] where multiListAnswerCode <> ''