select * from [dwh].[AT_Template_Txt] where title = 'ADOPTION ASSESSMENT'
select * from [dwh].[AT_TemplateToCriteria]  where templateId = 'AD07565D3F690CD7E10000000A4E71D5'

select B.criteriaId, B.shortDescription, B.title, A.sortOrder, B.longDescription from 
[dwh].[AT_TemplateToCriteria] AS A
INNER JOIN [dwh].[AT_Criteria_Txt] AS B
ON A.criteriaId = B.criteriaId
AND B.language = 'E'
AND A.templateId = 'AD07565D3F690CD7E10000000A4E71D5'
ORDER BY A.sortOrder ASC

select * from 
[dwh].[AT_TemplateToCriteria] AS A
INNER JOIN [dwh].[AT_CriteriaToTopic] AS B
ON A.criteriaId = B.criteriaId
AND A.templateId = 'AD07565D3F690CD7E10000000A4E71D5'
ORDER BY A.sortOrder ASC

select * from  [dwh].[IT_Interaction] AS P
INNER JOIN [dwh].[AT_Observation] AS Q
ON P.interactionId = Q.interactionId
where Q.criteriaId in (
select distinct criteriaId from 
[dwh].[AT_TemplateToCriteria] AS A
where A.templateId = 'AD07565D3F690CD7E10000000A4E71D5'
)

select distinct type from [dwh].[IT_Interaction]
where templateId = 'AD07565D3F690CD7E10000000A4E71D5' 