select "entityId"
from "FARMS"."nestle.dev.glb.farms.data.structure::ET.Entity" AS A
INNER JOIN 
(select "geoNodeId","geoNodeType", "lineOfBusiness"
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode"
where "lineOfBusiness" = 'GLOBAL') AS B
ON A."geoNodeId" = B."geoNodeId";

-- What are the different lobs of Orgs ? - NESCAFE | NESPRESSO | GLOBAL
select distinct "lineOfBusiness"
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.Organisation";

-- Are employeees mapped to ORG with lob = GLOBAL ? YES (only 2)
select *
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS A
INNER JOIN 
"FARMS"."nestle.dev.glb.farms.data.structure::CT.Organisation" AS B
ON A."organisationId" = B."organisationId"
where B."lineOfBusiness" = 'GLOBAL';

select * from "FARMS"."nestle.dev.glb.farms.data.structure::CT.ListOption"
where "itemCode" = 'TREES_HECTARE';

select A."geoNodeId", A."geoNodeType", A."lineOfBusiness", A."parentId" AS "Parent", B."geoNodeId" AS "Parent2", B."geoNodeType", B."lineOfBusiness"
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS B
ON A."parentId" = B."geoNodeId"
where A."lineOfBusiness" <> B."lineOfBusiness";

select A."geoNodeId", A."geoNodeType", A."lineOfBusiness"
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS A
where  A."parentId" = A."geoNodeId";

-- Is There One to one mapping between lob of cluster and sub cluster ? YES -- SCLU lob is same as its parent CLU lob
select B."geoNodeId" AS "Parent", B."geoNodeType", B."name" ,B."lineOfBusiness"
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS B
ON A."parentId" = B."geoNodeId"
where A."lineOfBusiness" <> B."lineOfBusiness"
AND B."geoNodeType" = 'CLUSTER';

-- What are the parent geonode with a child having different lob as compared to parent ? -> CTY - GLOBAL
select B."geoNodeId" AS "Parent", B."geoNodeType", B."name" ,B."lineOfBusiness"
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS B
ON A."parentId" = B."geoNodeId"
where A."lineOfBusiness" <> B."lineOfBusiness";


-- Children (Clusters) of above parents
select "geoNodeId" AS "Child_CLuster", "geoNodeType", "name", "lineOfBusiness"
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode"
where "parentId" IN (
    select B."geoNodeId"
    from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS A
    INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS B
    ON A."parentId" = B."geoNodeId"
    where A."lineOfBusiness" <> B."lineOfBusiness"
);

-- Child subclusters of above
select "geoNodeId" AS "Child_SubCluster", "geoNodeType", "name", "lineOfBusiness"
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode"
where "parentId" IN (
    select "geoNodeId"
    from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode"
    where "parentId" IN (
        select B."geoNodeId"
        from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS A
        INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS B
        ON A."parentId" = B."geoNodeId"
        where A."lineOfBusiness" <> B."lineOfBusiness"
    )
)
LIMIT 500 OFFSET 1000;

-- Entites mapped to these clusters, subclusters and ctys
select A."entityId", B."geoNodeId", C."geoNodeType", C."name", C."lineOfBusiness"  from 
"FARMS"."nestle.dev.glb.farms.data.structure::ET.Entity" AS A
INNER JOIN (
    select B."geoNodeId"  -- CTYs
    from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS A
    INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS B
    ON A."parentId" = B."geoNodeId"
    where A."lineOfBusiness" <> B."lineOfBusiness"
    
    UNION
    
    select "geoNodeId"   -- CLUs
    from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode"
    where "parentId" IN (
        select B."geoNodeId"
        from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS A
        INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS B
        ON A."parentId" = B."geoNodeId"
        where A."lineOfBusiness" <> B."lineOfBusiness"
    )
    
    UNION
    
    select "geoNodeId"   --  SCLUs
    from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode"
    where "parentId" IN (
        select "geoNodeId"
        from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode"
        where "parentId" IN (
            select B."geoNodeId"
            from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS A
            INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS B
            ON A."parentId" = B."geoNodeId"
            where A."lineOfBusiness" <> B."lineOfBusiness"
        )
    )
    ) AS B
    ON A."geoNodeId" = B."geoNodeId"
    INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS C
    ON B."geoNodeId" = C."geoNodeId"
    LIMIT 1000 OFFSET 1000;

-- LoBs at Country level - GLOBAL
select distinct "lineOfBusiness"
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" 
where "geoNodeType" = 'COUNTRY';

-- LoBs at Cluster level - NESPRESSO | NESCAFE
select distinct "lineOfBusiness"
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" 
where "geoNodeType" = 'CLUSTER';

-- LoBs at SubCluster level - NESPRESSO | NESCAFE
select distinct "lineOfBusiness"
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" 
where "geoNodeType" = 'SUB_CLUSTER';

-- Can entites be directly attached to a genonode of type - CTY ?  NO
select * 
from "FARMS"."nestle.dev.glb.farms.data.structure::ET.Entity" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS B
ON A."geoNodeId" = B."geoNodeId"
AND B."geoNodeType" = 'COUNTRY';

-- Is there ONE to ONE relation between STATUS of parent to child geonode ? NO
select B."geoNodeId" AS "Parent", B."geoNodeType", B."status"
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.GeoNode" AS B
ON A."parentId" = B."geoNodeId"
where A."status" <> B."status";


