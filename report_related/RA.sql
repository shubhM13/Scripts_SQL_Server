select B.criteriaId, B.shortDescription, B.title, A.sortOrder from 
[dwh].[AT_CriteriaToCriteriaGroup] AS A
INNER JOIN [dwh].[AT_Criteria_Txt] AS B
ON A.criteriaId = B.criteriaId
AND B.language = 'E'
AND A.templateId = '2019_4C'
ORDER BY A.sortOrder ASC