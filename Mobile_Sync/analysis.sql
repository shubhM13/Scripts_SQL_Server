select * from (select "userName", count(*)as count from "FARMS"."nestle.dev.glb.farms.data.structure::CT.UserSetting"
group by "userName") where count > 1;
----------------------------------------

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

----------------------------------------

select "auditInfo.createdBy"
        ,"uuid"
from "FARMS"."nestle.dev.glb.farms.data.structure::LT.DeviceInfo"
order by "auditInfo.createdOn";

select distinct TO_DATE("auditInfo.createdOn") from "FARMS"."nestle.dev.glb.farms.data.structure::LT.DeviceInfo";
---------------------
select 
    "userName"
    ,TO_DATE("logTime") AS "logDate"
    ,count(*) AS "logCount"
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.AppLog" where TO_TIMESTAMP("logTime") >= TO_TIMESTAMP('04.05.2021 14:59:30')
AND "eventType" = 'MobileSyncLog'
group by "userName", TO_DATE("logTime")
order by "userName", "logDate";

---------------------
select 
    "auditInfo.createdBy" AS "userName"
    ,TO_DATE("auditInfo.createdOn") AS "logDate"
    ,count(*) AS "logCount"
from "FARMS"."nestle.dev.glb.farms.data.structure::LT.DeviceInfo"
group by "auditInfo.createdBy", TO_DATE("auditInfo.createdOn")
order by "userName", "logDate";

select TO_TIMESTAMP(MIN("auditInfo.createdOn")) from "FARMS"."nestle.dev.glb.farms.data.structure::LT.DeviceInfo";

------------------
select 
    "userName"
    ,"logTime"
    ,"eventType"
    ,"logType"
    ,"errorCode"
    ,"requestURL"
    ,"functionName"
    ,"logDescription"
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.AppLog" where TO_TIMESTAMP("logTime") >= TO_TIMESTAMP('04.05.2021 14:59:30')
AND "eventType" = 'MobileSyncLog'
AND "userName" IN ('P000850', 'P001126', 'P001272', 'P001457', 'P001701', 'P001817', 'P001828', 'P001832', 'P001833')
order by "userName", TO_DATE("logTime");

---------------------------
select * from "FARMS"."nestle.dev.glb.farms.data.structure::LT.DeviceInfo";

----------------------------------------------
--Excel Extract - 2021
select A."userName" AS "User Name"
       ,D."employeeId" AS "Employee Id"
       ,D."organisationId" AS "Organisation Id"
       ,E."name" AS "Org Name"
       ,E."lineOfBusiness" AS "Line Of Business"
       ,D."contactInfo.email" AS "Employee Email"
       ,CONCAT(CONCAT(D."personInfo.firstName",' '), D."personInfo.lastName") AS "Employee Name"
       ,A."SyncInProgressTime" AS "Sync In-Progress Time"
       ,A."SyncStartTime" AS "Sync Start Time"
       ,A."SyncEndTime" AS "Sync End Time"
       ,B."logTime" AS "App Log Time"
       ,C."auditInfo.createdOn" AS "Device Log Time"
       ,
       CASE WHEN A."SyncInProgressTime" IS NULL
       THEN 'User Never Synced'
       ELSE
           CASE WHEN A."SyncEndTime" IS NULL
           THEN 'Fail'
           ELSE
               CASE WHEN A."SyncEndTime" > A."SyncInProgressTime"
               THEN 'Success'
               ELSE 'Fail'
               END
            END
       END AS "Last Sync Status"
       ,CASE WHEN A."SyncEndTime" IS NULL
       THEN '0 mins'
       ELSE
       CONCAT((CONCAT(TO_VARCHAR(CAST((SECONDS_BETWEEN(A."SyncStartTime",A."SyncEndTime")/60) AS INT)), TO_VARCHAR(' mins '))), (CONCAT(TO_VARCHAR((MOD(SECONDS_BETWEEN(A."SyncStartTime",A."SyncEndTime"),60))), TO_VARCHAR(' secs'))))
       END AS "Sync Time Duration"
       ,CASE WHEN B."errorCode" IN ('1', '2', '3', '4', '5', '6')
       THEN 'DELTA'
       ELSE 'Non-Delta'
       END AS "Sync TYpe"
       ,B."logDescription" AS "App Log Description"
       ,C."platform" AS "Device Platform"
       ,C."model" AS "Device Model"
       ,C."osVersion" AS "OS Version"
       ,C."manufacturer" AS "Device Manufacturer"
       ,C."cordovaVersion" AS "Cordova Version"
       ,A."offlineMobileGroup" AS "Offline Mobile Group"
       ,CASE WHEN A."offlineMobileGroup" IS NULL
       THEN 'No'
       ELSE 'Yes'
       END AS "hasOfflineMobileGroup"
       from "FARMS"."nestle.dev.glb.farms.data.structure::CT.UserSetting" AS A
LEFT OUTER JOIN (
    select * from (
    select * 
    ,RANK() OVER (partition by "userName" ORDER BY "logTime" DESC) AS rank
    from "FARMS"."nestle.dev.glb.farms.data.structure::CT.AppLog"
    order by "userName"
    ) AS P where P.rank = 1
) AS B ON A."userName" = B."userName"
LEFT OUTER JOIN (
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
ON A."userName" = D."userName"
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Organisation" AS E
ON D."organisationId" = E."organisationId"
WHERE YEAR(A."SyncStartTime") = 2021
ORDER BY C."auditInfo.createdOn" DESC;

---------------------------
select 
        D."userName" AS "User Name"
       ,D."employeeId" AS "Employee Id"
       ,D."organisationId" AS "Organisation Id"
       ,E."name" AS "Org Name"
       ,E."lineOfBusiness" AS "Line Of Business"
       ,D."contactInfo.email" AS "Employee Email"
       ,CONCAT(CONCAT(D."personInfo.firstName",' '), D."personInfo.lastName") AS "Employee Name"
       , C."auditInfo.createdOn" AS "Device Log Time"     
       ,C."platform" AS "Device Platform"
       ,C."model" AS "Device Model"
       ,C."osVersion" AS "OS Version"
       ,C."manufacturer" AS "Device Manufacturer"
       ,C."cordovaVersion" AS "Cordova Version"
from "FARMS"."nestle.dev.glb.farms.data.structure::LT.DeviceInfo" AS C
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS D
ON C."auditInfo.createdBy" = D."userName"
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Organisation" AS E
ON D."organisationId" = E."organisationId";

----------------------------
select 
        D."userName" AS "User Name"
       ,D."employeeId" AS "Employee Id"
       ,D."organisationId" AS "Organisation Id"
       ,E."name" AS "Org Name"
       ,E."lineOfBusiness" AS "Line Of Business"
       ,D."contactInfo.email" AS "Employee Email"
       ,CONCAT(CONCAT(D."personInfo.firstName",' '), D."personInfo.lastName") AS "Employee Name"
       ,B.*
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.AppLog" AS B
LEFT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS D
ON B."userName" = D."userName"
LEFT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Organisation" AS E
ON D."organisationId" = E."organisationId"
WHERE YEAR(B."logTime") = 2021
AND D."userName" <> 'FARMS_TECH';
