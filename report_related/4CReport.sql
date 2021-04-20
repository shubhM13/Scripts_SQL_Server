select * from "FARMS"."nestle.dev.glb.farms.data.structure::AT.Template_Txt"
where "title" = '4C Producer Assessment - 2019';

select "criteriaId"
from "FARMS"."nestle.dev.glb.farms.data.structure::AT.TemplateToCriteria"
where "templateId" = '2019_4C';

--4C Producer Report
-- MT.FarmSummary & externalGroupId & certificationExpiry
-- 4C Unit - MT.FarmSummary.licence4c
-- PRINCIPLE REPORT
select B.criteriaId, B.shortDescription, B.title, A.sortOrder from 
[dwh].[AT_TemplateToCriteria] AS A
INNER JOIN [dwh].[AT_Criteria_Txt] AS B
ON A.criteriaId = B.criteriaId
AND B.language = 'E'
AND A.templateId = '2019_4C'
ORDER BY A.sortOrder ASC