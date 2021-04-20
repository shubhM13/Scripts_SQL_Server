select * from [dwh].[AT_Template_Txt] where title = 'M&E Permanent FARM Visit Module' --NESCAFE_ME_VISIT
select * from [dwh].[AT_TemplateToCriteria]  where templateId = 'NESCAFE_ME_VISIT'

select B.criteriaId,C.externalId, B.shortDescription, B.title, A.sortOrder, B.longDescription from 
[dwh].[AT_TemplateToCriteria] AS A
INNER JOIN dwh.AT_Criteria AS C
ON A.criteriaId = C.criteriaId
INNER JOIN [dwh].[AT_Criteria_Txt] AS B
ON C.criteriaId = B.criteriaId
AND B.language = 'E'
AND A.templateId = 'NESCAFE_ME_VISIT'
ORDER BY A.sortOrder ASC

select * from 
[dwh].[AT_TemplateToCriteria] AS A
INNER JOIN [dwh].[AT_CriteriaToTopic] AS B
ON A.criteriaId = B.criteriaId
AND A.templateId = 'NESCAFE_ME_VISIT'
ORDER BY A.sortOrder ASC

select * from  [dwh].[IT_Interaction] AS P
INNER JOIN [dwh].[AT_Observation] AS Q
ON P.interactionId = Q.interactionId
where Q.criteriaId in (
select distinct criteriaId from 
[dwh].[AT_TemplateToCriteria] AS A
where A.templateId = 'NESCAFE_ME_VISIT'
)

-----------------------------------------------------------
select count(observationId) from  [dwh].[IT_Interaction] AS P
INNER JOIN [dwh].[AT_Observation] AS Q
ON P.interactionId = Q.interactionId
INNER JOIN dwh.ET_Entity AS R
ON Q.entityId = R.entityId
INNER JOIN dm.dim_geonode_flat AS T
ON R.geoNodeId = T.geoNodeId
--AND T.country_name = 'Vietnam'
AND Q.criteriaId in (
'NESCAFE_ME_C_FM_17'
)
AND YEAR(obsDateOnly) = 2018
AND answerCode = 'ENROLLED'
AND isLatestByYear = 1
AND P.status = 'COMPLETED'
AND R.status IN ('ACTIVE', 'INACTIVE')
AND T.cluster_status IN ('ACTIVE')
AND T.country_status IN ('ACTIVE');

-------------------------------------------------------

select count(distinct observationId) from 
[dwh].[AT_SelectedListAnswer] 
where observationId IN (
select observationId from  [dwh].[IT_Interaction] AS P
INNER JOIN [dwh].[AT_Observation] AS Q
ON P.interactionId = Q.interactionId
INNER JOIN dwh.ET_Entity AS R
ON Q.entityId = R.entityId
INNER JOIN dm.dim_geonode_flat AS T
ON R.geoNodeId = T.geoNodeId
AND T.country_name = 'Vietnam'
AND Q.criteriaId in (
'NESCAFE_ME_C_FM_38'
)
AND YEAR(obsDateOnly) = 2018
AND isLatestByYear = 1
AND P.status = 'COMPLETED'
AND R.status IN ('ACTIVE')
AND T.cluster_status IN ('ACTIVE')
AND T.country_status IN ('ACTIVE'));

--------------------------------------------------------------

select count(distinct Q.entityId)
from[dwh].[AT_Observation] AS Q
INNER JOIN dwh.ET_Entity AS R
ON Q.entityId = R.entityId
INNER JOIN dm.dim_geonode_flat AS T
ON R.geoNodeId = T.geoNodeId
AND T.country_name = 'Vietnam'
AND Q.criteriaId in (
'NESCAFE_ME_C_FM_30'
)
AND YEAR(obsDateOnly) = 2019
AND isLatestByYear = 1
AND R.status IN ('ACTIVE', 'INACTIVE')
AND T.cluster_status IN ('ACTIVE')
AND T.country_status IN ('ACTIVE')
AND Q.answerNumber = 2.0;

----------------------------------------------------------

select * from [dwh].[AT_SelectedListAnswer]
where observationId = '5DCA7E5B3243E414E10000000A4E71D5'

select distinct type from [dwh].[IT_Interaction]
where templateId = 'NESCAFE_ME_VISIT' 