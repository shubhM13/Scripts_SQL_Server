select * from "FARMS"."nestle.dev.glb.farms.data.structure::AT.Template_Txt"
where "title" = '4C Producer Assessment - 2019';

select "criteriaId"
from "FARMS"."nestle.dev.glb.farms.data.structure::AT.TemplateToCriteria"
where "templateId" = '2019_4C';

select distinct templateId from [dwh].[AT_TemplateToCriteria] where templateId LIKE '%4C%'
select * from dwh.AT_Template_Txt where title LIKE '%4C%'

--4C Producer Report
-- MT.FarmSummary & externalGroupId & certificationExpiry
-- 4C Unit - MT.FarmSummary.licence4c
-- PRINCIPLE REPORT
select distinct shortDescription from
(select D.templateId, C.title as templateTitle, C.description, D.status, D.type, D.startDate, D.endDate, B.criteriaId, B.title AS criteriaTitle, B.shortDescription, B.longDescription, A.sortOrder, Q.title as sectionTitle, Q.description AS sectionDesc from 
dwh.AT_Template AS D
INNER JOIN
dwh.AT_Template_Txt AS C ON D.templateId = C.templateId
AND D.templateId IN ('6F53E05F41993A4CE10000000A793047', '8481E15FB4533A4CE10000000A793047', 'FBB5E15FB4533A4CE10000000A793047')
INNER JOIN 
[dwh].[AT_TemplateToCriteria] AS A ON C.templateId = A.templateId
INNER JOIN [dwh].[AT_Criteria_Txt] AS B
ON A.criteriaId = B.criteriaId
AND B.language = 'E'
INNER JOIN dwh.AT_Section AS P ON A.sectionId = P.sectionId
AND D.templateId = P.templateId
INNER JOIN dwh.AT_Section_Txt AS Q ON P.sectionId = Q.sectionId
AND Q.language = 'E'
) A
order by shortDescription

[dwh].[MT_FarmSummary]

select distinct entityId, totalArea, totalPlotArea from [dwh].[MT_FarmSummary]
where totalArea IS NOT NULL