/****** Object:  View [dm].[view_fact_employee_mobile_sync_analysis]    Script Date: 24-05-2021 16:13:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*******************************************
 Author     : Shubham Mishra
 Created On : 20th May, 2021
 PURPOSE    : Employee Mobile Sync Analysis Dataset
 *******************************************/
--drop view dm.view_fact_employee_mobile_sync_analysis				
CREATE VIEW [dm].[view_fact_employee_mobile_sync_analysis]
AS
(
		SELECT DISTINCT C.employeeId AS employeeId
			,CONCAT (
				C.[personInfo.firstName]
				,' '
				,C.[personInfo.lastName]
				) AS employeeName
			,C.[contactInfo.email] AS employeeEmail
			,ISNULL(C.organisationId, '') AS empOrgId
			,ISNULL(I.name, 'N/A') AS empOrgName
			,ISNULL(I.lineOfBusiness, 'N/A') AS empOrgLoB
			,ISNULL(H.name, 'N/A') AS empCountry
			,ISNULL(C.userName, '') AS empUserName
			,CASE 
				WHEN A.userName IS NULL
					THEN 'No'
				ELSE 'Yes'
				END AS recordAvlblInUserSettings
			,ISNULL(A.offlineMobileGroup, '') AS offlineMobileGroup
			,ISNULL(A.SyncInProgressTime, '') AS SyncInProgressTime
			,ISNULL(A.SyncStartTime, '') AS SyncStartTime
			,ISNULL(A.SyncEndTime, '') AS SyncEndTime
			,CASE 
				WHEN A.SyncInProgressTime IS NULL
					THEN 'User Never Synced'
				WHEN A.SyncEndTime IS NULL
					THEN 'Fail'
				WHEN A.SyncEndTime > A.SyncInProgressTime
					THEN 'Success'
				ELSE 'Fail'
				END AS lastSyncStatus
			,CASE 
				WHEN A.SyncEndTime IS NULL
					THEN '00:00:00'
				ELSE CAST(DATEDIFF(second, A.SyncStartTime, A.SyncEndTime) / 60 AS NVARCHAR(20)) + ' mins ' + CAST(DATEDIFF(second, A.SyncStartTime, A.SyncEndTime) % 60 AS NVARCHAR(20)) + ' secs '
				END AS "syncTimeDuration"
			,CASE 
				WHEN A.offlineMobileGroup IS NULL
					THEN 'No'
				ELSE 'Yes'
				END AS hasOfflineMobileGroup
			,CASE 
				WHEN A.SyncEndTime IS NULL
					THEN 0
				ELSE YEAR(A.SyncInProgressTime)
				END AS Year
			,CASE 
				WHEN A.SyncEndTime IS NULL
					THEN 0
				ELSE MONTH(A.SyncInProgressTime)
				END AS Month
			,CASE 
				WHEN A.SyncEndTime IS NULL
					THEN 0
				ELSE DAY(A.SyncInProgressTime)
				END AS Day
			,ISNULL(B.logDescription, '') AS logDescription
			,ISNULL(B.syncType, '') AS syncType
			,G.entityCount AS allEntityCount
			,J.entityOfflineCount AS offlineEntityCount
			,'N/A' AS buildVersion
			,CAST( '00:00:00' AS DATETIME) AS deviceLogTime
			,'N/A' AS devicePlatform
			,'N/A' AS deviceModel
			,'N/A' AS deviceManufacturer
			,'N/A' AS OSVersion
			,'N/A' AS cordovaVersion
		FROM [dwh].[CT_Employee] AS C
		INNER JOIN [dwh].[CT_GeoNode] AS H WITH (NOLOCK) ON C.[addressInfo.countryCode] = H.countryCode
			AND H.geoNodeType = 'COUNTRY'
		INNER JOIN [dwh].[CT_Organisation] AS I WITH (NOLOCK) ON C.Organisationid = I.Organisationid
		LEFT JOIN [dm].[view_dim_org_to_entity_count] AS G ON I.organisationId = G.organisationId
		LEFT JOIN [dwh].[CT_UserSetting] AS A ON A.userName = C.userName
			AND C.STATUS = 'ACTIVE'
		LEFT JOIN [dm].[view_fact_employee_offline_group] J WITH (NOLOCK) ON A.userName = J.userName
		LEFT JOIN (
			SELECT *
			FROM (
				SELECT logDescription
					,userName
					,eventType
					,CASE 
						WHEN errorCode IN (
								'1'
								,'2'
								,'3'
								,'4'
								,'5'
								,'6'
								)
							THEN 'Delta'
						WHEN errorCode IN (
								'U1000'
								,'S'
								)
							THEN 'Non-Delta'
						END AS syncType
					,RANK() OVER (
						PARTITION BY userName ORDER BY logTime,logDescription DESC
						) AS rnk
				FROM [dwh].[CT_AppLog]
				) AS Z
			WHERE Z.rnk = 1
			) AS B ON A.userName = B.userName
			AND B.eventType = 'MobileSyncLog'
		);
GO

drop table [dm].[fact_employee_mobile_sync_analysis];

select *
INTO [dm].[fact_employee_mobile_sync_analysis]
FROM [dm].[view_fact_employee_mobile_sync_analysis];

ALTER TABLE [dm].[fact_employee_mobile_sync_analysis] ADD CONSTRAINT dimMobSyncLatest_pk PRIMARY KEY (employeeId);

select * from [dm].[fact_employee_mobile_sync_analysis]
where employeeId = '13'
