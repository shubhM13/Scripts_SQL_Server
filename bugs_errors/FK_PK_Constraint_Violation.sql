select * from "FARMS"."nestle.dev.glb.farms.data.structure::CT.ListOption_Txt"
where "setId" = 'DOCUMENTATION_STATUS'
AND "itemCode" = 'NO_PLAN';

select count("interactionId") from "FARMS"."nestle.dev.glb.farms.data.structure::AT.Observation"
WHERE "interactionId" NOT IN
(SELECT "interactionId" from "FARMS"."nestle.dev.glb.farms.data.structure::IT.Interaction");
