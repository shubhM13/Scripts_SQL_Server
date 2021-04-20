select * from "FARMS"."nestle.dev.glb.farms.data.structure::AT.Observation"
where "criteriaId" IN(
select C."criteriaId"
from "FARMS"."nestle.dev.glb.farms.data.structure::AT.Template" AS A 
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::AT.TemplateToCriteria" AS B
ON A."templateId" = B."templateId"
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::AT.Criteria_Txt" AS C
ON B."criteriaId" = C."criteriaId"
where A."templateId" = 'NESCAFE_EARLY_WARNING_TMPLT');

