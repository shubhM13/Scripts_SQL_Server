select * from (select "userName", count(*)as count from "FARMS"."nestle.dev.glb.farms.data.structure::CT.UserSetting"
group by "userName") where count > 1;

select A."userName"
       --,D."personInfo.firstName" + D."personInfo.lastName" AS name
       ,A."SyncStartTime"
       ,A."SyncEndTime"
       ,B."logTime"
       ,C."auditInfo.createdOn"
       ,A."offlineMobileGroup"
       ,A."SyncInProgressTime"
       ,B."userRole"
       ,B."organisation"
       ,B."farms_DU_Version"
       ,B."HANA_SPS_Version"
       ,B."eventType"
       ,B."functionName"
       ,B."moduleName"
       ,B."logType"
       ,B."logDescription"
       ,C."platform"
       ,C."model"
       ,C."osVersion"
       ,C."manufacturer"
       ,C."cordovaVersion"
       from "FARMS"."nestle.dev.glb.farms.data.structure::CT.UserSetting" AS A
LEFT OUTER JOIN (
    select * from (
    select * 
    ,RANK() OVER (partition by "userName" ORDER BY "logTime" DESC) AS rank
    from "FARMS"."nestle.dev.glb.farms.data.structure::CT.AppLog"
    order by "userName"
    ) AS P where P.rank = 1
) AS B ON A."userName" = B."userName"
INNER JOIN (
    select * from
    (
        select *
              ,RANK() OVER (partition by "auditInfo.createdBy",TO_DATE("auditInfo.createdOn") ORDER BY "auditInfo.createdBy","auditInfo.createdOn" DESC) AS rank_1
        from "FARMS"."nestle.dev.glb.farms.data.structure::LT.DeviceInfo"
    ) AS Q where Q.rank_1 = 1
) AS C
ON B."userName" = C."auditInfo.createdBy"
AND TO_DATE(B."logTime") = TO_DATE(C."auditInfo.createdOn")
LEFT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS D
ON A."userName" = D."userName";

select B."userName"
       ,B."logTime"
       ,B.rank AS App_Log_Rank
       ,C.rank_1 AS Device_Log_Rank
       ,C."auditInfo.createdOn"
       ,B."logDescription"
       ,B."userRole"
       ,B."organisation"
       ,B."farms_DU_Version"
       ,B."HANA_SPS_Version"
       ,B."eventType"
       ,B."functionName"
       ,B."moduleName"
       ,B."logType"
       ,C."platform"
       ,C."model"
       ,C."osVersion"
       ,C."manufacturer"
       ,C."cordovaVersion"
    from (
    select * from (
    select * 
    ,RANK() OVER (partition by "userName" ORDER BY "logTime" DESC) AS rank
    from "FARMS"."nestle.dev.glb.farms.data.structure::CT.AppLog"
    order by "userName"
    )
) AS B
INNER JOIN (
    select * from
    (
        select *
              ,RANK() OVER (partition by "auditInfo.createdBy",TO_DATE("auditInfo.createdOn") ORDER BY "auditInfo.createdBy","auditInfo.createdOn" DESC) AS rank_1
        from "FARMS"."nestle.dev.glb.farms.data.structure::LT.DeviceInfo"
    ) 
) AS C
ON B."userName" = C."auditInfo.createdBy"
AND TO_DATE(B."logTime") = TO_DATE(C."auditInfo.createdOn")
AND B.rank = C.rank_1
AND B."logDescription" LIKE '6%';

