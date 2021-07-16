SELECT A."userName"
    ,A.logDate
    ,E."name" AS "Org Name"
    ,E."lineOfBusiness" AS "Line Of Business"
    ,D."contactInfo.email" AS "Employee Email"
    ,CONCAT(CONCAT(D."personInfo.firstName",' '), D."personInfo.lastName") AS "Employee Name"
    ,D."addressInfo.countryCode" AS country
    ,A.attemptCount
	,B.successfulattemptCount
	,(A.attemptCount - B.successfulAttemptCount) AS failedAttemptCount
	,X."auditInfo.createdOn" AS devicelogTime
	,X."platform" AS devicePlatform 
	,X."model" AS deviceModel
    ,X."manufacturer" AS deviceManufacturer
    ,X."osVersion" AS OSVersion
    ,X."cordovaVersion" AS cordovaVersion
from 
(
    select "userName",
        CAST("logTime" AS DATE) AS logDate,
        count("errorCode") AS attemptCount
    from "FARMS"."nestle.dev.glb.farms.data.structure::CT.AppLog"
    where "errorCode" IN ('1') 
    GROUP BY "userName", CAST("logTime" AS DATE) 
) A
INNER JOIN (
    select "userName",
        CAST("logTime" AS DATE) AS logDate,
        count("errorCode") AS successfulAttemptCount
    from "FARMS"."nestle.dev.glb.farms.data.structure::CT.AppLog"
    where "errorCode" IN ('6') 
    GROUP BY "userName", CAST("logTime" AS DATE)
) B ON A."userName" = B."userName" AND A.logDate = B.logDate
LEFT OUTER JOIN (
    select * from
    (
        select *
              ,RANK() OVER (partition by "auditInfo.createdBy",TO_DATE("auditInfo.createdOn") ORDER BY "auditInfo.createdBy","auditInfo.createdOn" DESC) AS rank_1
        from "FARMS"."nestle.dev.glb.farms.data.structure::LT.DeviceInfo"
    ) AS Q where Q.rank_1 = 1
) AS X
ON B."userName" = X."auditInfo.createdBy"
AND TO_DATE(B.logDate) = TO_DATE(X."auditInfo.createdOn")
LEFT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS D
ON A."userName" = D."userName"
LEFT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Organisation" AS E
ON D."organisationId" = E."organisationId"
ORDER BY X."auditInfo.createdOn" DESC;


------------------------------------------------------------------------------------------------------


select A.*
    ,E."name" AS "Org Name"
    ,E."lineOfBusiness" AS "Line Of Business"
    ,D."contactInfo.email" AS "Employee Email"
    ,CONCAT(CONCAT(D."personInfo.firstName",' '), D."personInfo.lastName") AS "Employee Name"
    ,D."addressInfo.countryCode" AS country
from "FARMS"."nestle.dev.glb.farms.data.structure::CT.AppLog" AS A
LEFT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS D
ON A."userName" = D."userName"
LEFT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Organisation" AS E
ON D."organisationId" = E."organisationId"

---------------------------------------------------------------------------------------------------

select A.*
    ,E."name" AS "Org Name"
    ,E."lineOfBusiness" AS "Line Of Business"
    ,D."contactInfo.email" AS "Employee Email"
    ,CONCAT(CONCAT(D."personInfo.firstName",' '), D."personInfo.lastName") AS "Employee Name"
    ,D."addressInfo.countryCode" AS country
from "FARMS"."nestle.dev.glb.farms.data.structure::LT.DeviceInfo"AS A
LEFT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS D
ON A."auditInfo.createdBy" = D."userName"
LEFT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Organisation" AS E
ON D."organisationId" = E."organisationId"
ORDER BY A."auditInfo.createdOn" DESC

-----------------------------------------------------------------------------------------------

select * from (
    SELECT A."userName"
    ,A.logDate
    ,E."name" AS "Org Name"
    ,E."lineOfBusiness" AS "Line Of Business"
    ,D."contactInfo.email" AS "Employee Email"
    ,CONCAT(CONCAT(D."personInfo.firstName",' '), D."personInfo.lastName") AS "Employee Name"
    ,D."addressInfo.countryCode" AS country
    ,A.attemptCount
	,B.successfulattemptCount
	,(A.attemptCount - B.successfulAttemptCount) AS failedAttemptCount
	,X."auditInfo.createdOn" AS devicelogTime
	,X."platform" AS devicePlatform 
	,X."model" AS deviceModel
    ,X."manufacturer" AS deviceManufacturer
    ,X."osVersion" AS OSVersion
    ,X."cordovaVersion" AS cordovaVersion
from 
(
    select "userName",
        CAST("logTime" AS DATE) AS logDate,
        count("errorCode") AS attemptCount
    from "FARMS"."nestle.dev.glb.farms.data.structure::CT.AppLog"
    where "errorCode" IN ('1') 
    GROUP BY "userName", CAST("logTime" AS DATE) 
) A
INNER JOIN (
    select "userName",
        CAST("logTime" AS DATE) AS logDate,
        count("errorCode") AS successfulAttemptCount
    from "FARMS"."nestle.dev.glb.farms.data.structure::CT.AppLog"
    where "errorCode" IN ('6') 
    GROUP BY "userName", CAST("logTime" AS DATE)
) B ON A."userName" = B."userName" AND A.logDate = B.logDate
LEFT OUTER JOIN (
    select * from
    (
        select *
              ,RANK() OVER (partition by "auditInfo.createdBy",TO_DATE("auditInfo.createdOn") ORDER BY "auditInfo.createdBy","auditInfo.createdOn" DESC) AS rank_1
        from "FARMS"."nestle.dev.glb.farms.data.structure::LT.DeviceInfo"
    ) AS Q where Q.rank_1 = 1
) AS X
ON B."userName" = X."auditInfo.createdBy"
AND TO_DATE(B.logDate) = TO_DATE(X."auditInfo.createdOn")
LEFT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS D
ON A."userName" = D."userName"
LEFT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Organisation" AS E
ON D."organisationId" = E."organisationId"
ORDER BY X."auditInfo.createdOn" DESC
) P
WHERE YEAR(P.logDate) > 2020
LIMIT 500 OFFSET 3000;



SELECT A."userName"
    ,A.logDate
    ,E."name" AS "Org Name"
    ,E."lineOfBusiness" AS "Line Of Business"
    ,D."contactInfo.email" AS "Employee Email"
    ,CONCAT(CONCAT(D."personInfo.firstName",' '), D."personInfo.lastName") AS "Employee Name"
    ,D."addressInfo.countryCode" AS country
    ,A.attemptCount
	,B.successfulattemptCount
	,(A.attemptCount - B.successfulAttemptCount) AS failedAttemptCount
	,C.dailyLogDetails
	,X."auditInfo.createdOn" AS devicelogTime
	,X."platform" AS devicePlatform 
	,X."model" AS deviceModel
    ,X."manufacturer" AS deviceManufacturer
    ,X."osVersion" AS OSVersion
    ,X."cordovaVersion" AS cordovaVersion
from 
(
    select "userName",
        CAST("logTime" AS DATE) AS logDate,
        count("errorCode") AS attemptCount
    from "FARMS"."nestle.dev.glb.farms.data.structure::CT.AppLog"
    where "errorCode" IN ('1') 
    GROUP BY "userName", CAST("logTime" AS DATE) 
) A
INNER JOIN (
    select "userName",
        CAST("logTime" AS DATE) AS logDate,
        count("errorCode") AS successfulAttemptCount
    from "FARMS"."nestle.dev.glb.farms.data.structure::CT.AppLog"
    where "errorCode" IN ('6') 
    GROUP BY "userName", CAST("logTime" AS DATE)
) B ON A."userName" = B."userName" AND A.logDate = B.logDate
INNER JOIN (
SELECT "userName"
	,CAST("logTime" AS DATE) AS logDate
	,STRING_AGG(CONCAT (
			CONCAT (
				CONCAT (
					CONCAT (
						'['
						,"errorCode"
						)
					,' : '
					)
				,SUBSTRING("logDescription", LOCATE("logDescription", 'Version No: ') + 12, LOCATE("logDescription", '-DELTA') - LOCATE("logDescription", 'Version No: ') - 12)
				)
			,']'
			), ' ; ' ORDER BY "logTime") AS dailyLogDetails
FROM "FARMS"."nestle.dev.glb.farms.data.structure::CT.AppLog"
WHERE "errorCode" IN (
		'1'
		,'2'
		,'3'
		,'4'
		,'5'
		,'6'
		)
GROUP BY "userName"
	,CAST("logTime" AS DATE)
) C ON A."userName" = C."userName" AND A.logDate = C.logDate
LEFT OUTER JOIN (
    select * from
    (
        select *
              ,RANK() OVER (partition by "auditInfo.createdBy",TO_DATE("auditInfo.createdOn") ORDER BY "auditInfo.createdBy","auditInfo.createdOn" DESC) AS rank_1
        from "FARMS"."nestle.dev.glb.farms.data.structure::LT.DeviceInfo"
    ) AS Q where Q.rank_1 = 1
) AS X
ON B."userName" = X."auditInfo.createdBy"
AND TO_DATE(B.logDate) = TO_DATE(X."auditInfo.createdOn")
LEFT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS D
ON A."userName" = D."userName"
LEFT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Organisation" AS E
ON D."organisationId" = E."organisationId"
ORDER BY X."auditInfo.createdOn" DESC;

