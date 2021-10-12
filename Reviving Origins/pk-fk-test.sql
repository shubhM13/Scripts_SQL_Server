select distinct entityId
from [aaa].[fact_nsp_reviving_origins]
except
select distinct entityId
from [aaa].[dim_nsp_ro_entity];

select distinct entityId
from [aaa].[fact_nsp_reviving_origins]
except
select distinct entityId
from [aaa].[dim_nsp_ro_farmer_profiles];

select distinct entityId
from [aaa].[fact_nsp_reviving_origins]
except
select distinct entityId
from [aaa].[dim_nsp_ro_last_interaction];

select distinct entityId
from [aaa].[fact_nsp_reviving_origins]
except
select distinct entityId
from [aaa].[dim_nsp_ro_persons];

delete from 
[aaa].[dim_nsp_ro_persons]
where entityId NOT IN (
select distinct A.entityId
from dwh.OT_Delivery AS A
INNER JOIN dwh.ET_Entity AS B ON A.entityId = B.entityId
INNER JOIN dm.dim_geonode_flat AS C ON B.geoNodeId = C.geoNodeId
AND C.country_name IN ('Uganda', 'Zimbabwe'));


select * from [aaa].[fact_nsp_reviving_origins];
select * from [aaa].[dim_nsp_ro_farmer_profiles];
select * from [aaa].[dim_nsp_ro_last_interaction];
select * from [aaa].[dim_nsp_ro_persons];

select distinct country_name 
from dm.dim_geonode_flat;