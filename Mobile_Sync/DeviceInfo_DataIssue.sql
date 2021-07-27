
select empUserName, CAST(appLogTime AS DATE) from dm.fact_employee_mobile_sync_analysis
where empUserName IN
('P000020','P000401','P000402','P000414','P000492','P000504','P000547','P000587','P000588','P000591','P000593','P000598','P000599','P000604','P000605','P000673','P000693','P000720','P000724','P000730','P000752','P000761','P000764','P000773','P000776','P000794','P000799','P000803','P000833','P000978','P001027','P001094','P001095','P001096','P001109','P001128','P001161','P001164','P001194','P001223','P001224','P001227','P001314','P001322','P001339','P001388','P001827','P001828')
AND deviceLogTime IS NULL;


select * from audit.WaterMark
where schemaname = 'LT';

select MAX([auditInfo.createdOn]) 
from dwh.LT_DeviceInfo


select * 
from 
dwh.LT_DeviceInfo
WHERE
[auditInfo.CreatedBy]  = 'P000588' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-21' AS DATE)
OR ([auditInfo.CreatedBy]  = 'P000598' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-22' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000599' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-21' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000604' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-23' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000773' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-05-11' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000776' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-06-11' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000761' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-24' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000752' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-24' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P001027' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-06-11' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P001109' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-05-23' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P001227' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-21' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000591' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-22' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P001224' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-22' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P001322' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-05-20' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P001827' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-05-03' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P001828' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-24' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000504' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-19' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000593' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-21' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000803' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-06-15' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000720' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-22' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000401' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-23' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000730' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-06-15' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000764' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-23' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P001094' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-06-08' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P001095' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-07' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P001128' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-23' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000020' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-05-18' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P001314' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-24' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P001388' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-23' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000402' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-06-03' AS DATE))
OR ([auditInfo.CreatedBy]  = 'P000673' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-22' AS DATE));


select * 
from 
dwh.LT_DeviceInfo
WHERE
CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-21' AS DATE);



--------------------------------------------------------------------

select * 
from "FARMS"."nestle.dev.glb.farms.data.structure::LT.DeviceInfo"
WHERE
("auditInfo.createdBy" = 'P000588' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-21'))
OR ("auditInfo.createdBy" = 'P000598' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-22'))
OR ("auditInfo.createdBy" = 'P000599' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-21'))
OR ("auditInfo.createdBy" = 'P000604' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-23'))
OR ("auditInfo.createdBy" = 'P000773' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-05-11'))
OR ("auditInfo.createdBy" = 'P000776' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-06-11'))
OR ("auditInfo.createdBy" = 'P000761' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-24'))
OR ("auditInfo.createdBy" = 'P000752' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-24'))
OR ("auditInfo.createdBy" = 'P001027' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-06-11'))
OR ("auditInfo.createdBy" = 'P001109' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-05-23'))
OR ("auditInfo.createdBy" = 'P001227' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-21'))
OR ("auditInfo.createdBy" = 'P000591' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-22'))
OR ("auditInfo.createdBy" = 'P001224' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-22'))
OR ("auditInfo.createdBy" = 'P001322' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-05-20'))
OR ("auditInfo.createdBy" = 'P001827' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-05-03'))
OR ("auditInfo.createdBy" = 'P001828' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-24'))
OR ("auditInfo.createdBy" = 'P000504' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-19'))
OR ("auditInfo.createdBy" = 'P000593' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-21'))
OR ("auditInfo.createdBy" = 'P000803' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-06-15'))
OR ("auditInfo.createdBy" = 'P000720' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-22'))
OR ("auditInfo.createdBy" = 'P000401' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-23'))
OR ("auditInfo.createdBy" = 'P000730' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-06-15'))
OR ("auditInfo.createdBy" = 'P000764' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-23'))
OR ("auditInfo.createdBy" = 'P001094' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-06-08'))
OR ("auditInfo.createdBy" = 'P001095' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-07'))
OR ("auditInfo.createdBy" = 'P001128' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-23'))
OR ("auditInfo.createdBy" = 'P000020' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-05-18'))
OR ("auditInfo.createdBy" = 'P001314' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-24'))
OR ("auditInfo.createdBy" = 'P001388' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-23'))
OR ("auditInfo.createdBy" = 'P000402' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-06-03'))
OR ("auditInfo.createdBy" = 'P000673' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-22'));











------------------------------------
27th July
------------------------------------

EXEC dm.usp_merge_fact_employee_mobile_sync_analysis;

select MAX(appLogTime) from dm.fact_employee_mobile_sync_analysis;
select MAX(deviceLogTime) from dm.fact_employee_mobile_sync_analysis;


select * from dm.fact_employee_mobile_sync_analysis
where empuserName IN ('P000020','P000401','P000402','P000414','P000492','P000504','P000547','P000587','P000588','P000591','P000593','P000598','P000599','P000604','P000605','P000673','P000693','P000720','P000724','P000730','P000752','P000761','P000764','P000773','P000776','P000794','P000799','P000803','P000833','P000978','P001027','P001094','P001095','P001096','P001109','P001128','P001161','P001164','P001194','P001223','P001224','P001227','P001314','P001322','P001339','P001388','P001827','P001828')
AND deviceLogTime IS NULL;

select empUserName, CAST(appLogTime AS DATE) from dm.fact_employee_mobile_sync_analysis
where empUserName IN
('P000020','P000401','P000402','P000414','P000492','P000504','P000547','P000587','P000588','P000591','P000593','P000598','P000599','P000604','P000605','P000673','P000693','P000720','P000724','P000730','P000752','P000761','P000764','P000773','P000776','P000794','P000799','P000803','P000833','P000978','P001027','P001094','P001095','P001096','P001109','P001128','P001161','P001164','P001194','P001223','P001224','P001227','P001314','P001322','P001339','P001388','P001827','P001828')
AND deviceLogTime IS NULL;


select * from audit.WaterMark
where schemaname = 'LT';

select MAX([auditInfo.createdOn]) 
from dwh.LT_DeviceInfo


select * 
from 
dwh.LT_DeviceInfo
WHERE
([auditInfo.CreatedBy]  = 'P000588' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-21' as DATE))
OR ([auditInfo.CreatedBy]  = 'P000598' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-22' as DATE))
OR ([auditInfo.CreatedBy]  = 'P000599' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-26' as DATE))
OR ([auditInfo.CreatedBy]  = 'P000604' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-23' as DATE))
OR ([auditInfo.CreatedBy]  = 'P000773' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-05-11' as DATE))
OR ([auditInfo.CreatedBy]  = 'P000776' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-06-11' as DATE))
OR ([auditInfo.CreatedBy]  = 'P001027' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-06-11' as DATE))
OR ([auditInfo.CreatedBy]  = 'P001109' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-05-23' as DATE))
OR ([auditInfo.CreatedBy]  = 'P001227' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-21' as DATE))
OR ([auditInfo.CreatedBy]  = 'P000591' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-26' as DATE))
OR ([auditInfo.CreatedBy]  = 'P001322' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-05-20' as DATE))
OR ([auditInfo.CreatedBy]  = 'P001827' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-05-03' as DATE))
OR ([auditInfo.CreatedBy]  = 'P000504' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-19' as DATE))
OR ([auditInfo.CreatedBy]  = 'P000593' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-26' as DATE))
OR ([auditInfo.CreatedBy]  = 'P000587' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-26' as DATE))
OR ([auditInfo.CreatedBy]  = 'P000803' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-06-15' as DATE))
OR ([auditInfo.CreatedBy]  = 'P000720' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-26' as DATE))
OR ([auditInfo.CreatedBy]  = 'P000730' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-06-15' as DATE))
OR ([auditInfo.CreatedBy]  = 'P001094' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-06-08' as DATE))
OR ([auditInfo.CreatedBy]  = 'P001095' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-07' as DATE))
OR ([auditInfo.CreatedBy]  = 'P000020' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-05-18' as DATE))
OR ([auditInfo.CreatedBy]  = 'P000402' AND CAST([auditInfo.createdOn] AS DATE) = CAST('2021-06-03' as DATE));


select * 
from 
dwh.LT_DeviceInfo
WHERE
CAST([auditInfo.createdOn] AS DATE) = CAST('2021-07-21' AS DATE);



--------------------------------------------------------------------

select * 
from "FARMS"."nestle.dev.glb.farms.data.structure::LT.DeviceInfo"
WHERE
("auditInfo.createdBy" = 'P000588' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-21'))
OR ("auditInfo.createdBy" = 'P000598' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-22'))
OR ("auditInfo.createdBy" = 'P000599' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-26'))
OR ("auditInfo.createdBy" = 'P000604' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-23'))
OR ("auditInfo.createdBy" = 'P000773' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-05-11'))
OR ("auditInfo.createdBy" = 'P000776' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-06-11'))
OR ("auditInfo.createdBy" = 'P001027' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-06-11'))
OR ("auditInfo.createdBy" = 'P001109' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-05-23'))
OR ("auditInfo.createdBy" = 'P001227' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-21'))
OR ("auditInfo.createdBy" = 'P000591' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-26'))
OR ("auditInfo.createdBy" = 'P001322' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-05-20'))
OR ("auditInfo.createdBy" = 'P001827' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-05-03'))
OR ("auditInfo.createdBy" = 'P000504' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-19'))
OR ("auditInfo.createdBy" = 'P000593' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-26'))
OR ("auditInfo.createdBy" = 'P000587' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-26'))
OR ("auditInfo.createdBy" = 'P000803' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-06-15'))
OR ("auditInfo.createdBy" = 'P000720' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-26'))
OR ("auditInfo.createdBy" = 'P000730' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-06-15'))
OR ("auditInfo.createdBy" = 'P001094' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-06-08'))
OR ("auditInfo.createdBy" = 'P001095' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-07-07'))
OR ("auditInfo.createdBy" = 'P000020' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-05-18'))
OR ("auditInfo.createdBy" = 'P000402' AND TO_DATE("auditInfo.createdOn") = TO_DATE('2021-06-03'));