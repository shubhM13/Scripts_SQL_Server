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