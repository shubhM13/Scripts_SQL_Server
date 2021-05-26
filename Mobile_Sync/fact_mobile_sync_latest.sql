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
			,ISNULL(C.userName, '') AS empUserName
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
			,CASE 
				WHEN A.userName IS NULL
					THEN 'No'
				ELSE 'Yes'
				END AS recordAvlblInUserSettings
			,CASE 
				WHEN A.offlineMobileGroup IS NULL
					THEN 'No'
				ELSE 'Yes'
				END AS hasOfflineMobileGroup
			,ISNULL(A.offlineMobileGroup, 'N/A') AS offlineMobileGroupId
			,ISNULL(J.offlineMobileGroupName, 'N/A') AS offlineMobileGroupName
			,ISNULL(G.entityCount, 0) AS allEntityCount
			,ISNULL(J.entityOfflineCount, 0) AS offlineEntityCount
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
			,B.logTime AS appLogTime
			,ISNULL(B.userRole, 'N/A') AS userRole
			,ISNULL(B.logDescription, 'N/A') AS logDescription
			,ISNULL(B.syncType, '') AS syncType
			,ISNULL(SUBSTRING(B.logDescription, CHARINDEX('Version No: ', B.logDescription) + 12, LEN(B.logDescription)), 'N/A') AS buildVersion
			,X.[auditInfo.createdOn] AS deviceLogTime
			,ISNULL(X.platform, 'N/A') AS devicePlatform
			,ISNULL(X.model, 'N/A') AS deviceModel
			,ISNULL(X.manufacturer, 'N/A') AS deviceManufacturer
			,ISNULL(X.osVersion, 'N/A') AS OSVersion
			,ISNULL(X.cordovaVersion, 'N/A') AS cordovaVersion
		FROM [dwh].[CT_Employee] AS C
		INNER JOIN [dwh].[CT_Organisation] AS I WITH (NOLOCK) ON C.Organisationid = I.Organisationid
		LEFT JOIN [dwh].[CT_GeoNode] AS H WITH (NOLOCK) ON C.[addressInfo.countryCode] = H.countryCode
			AND H.geoNodeType = 'COUNTRY'
		LEFT JOIN [dm].[view_dim_org_to_entity_count] AS G ON I.organisationId = G.organisationId
		LEFT JOIN [dm].[view_fact_employee_offline_group] J WITH (NOLOCK) ON C.userName = J.userName
		LEFT JOIN [dwh].[CT_UserSetting] AS A ON A.userName = C.userName
			AND C.STATUS = 'ACTIVE'
		LEFT JOIN (
			SELECT *
			FROM (
				SELECT logTime
					,userRole
					,logDescription
					,userName
					,eventType
					,logType
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
						PARTITION BY userName ORDER BY logTime DESC
							,logDescription DESC
						) AS rnk
				FROM [dwh].[CT_AppLog]
				) AS Z
			WHERE Z.rnk = 1
			) AS B ON A.userName = B.userName
			AND B.eventType = 'MobileSyncLog'
		LEFT JOIN (
			SELECT *
			FROM (
				SELECT *
					,RANK() OVER (
						PARTITION BY [auditInfo.createdBy] ORDER BY [auditInfo.createdBy]
							,[auditInfo.createdOn] DESC
						) AS rank_1
				FROM [dwh].[LT_DeviceInfo]
				) AS Q
			WHERE Q.rank_1 = 1
			) AS X ON B.userName = X.[auditInfo.createdBy]
			AND CAST(B.logTime AS DATE) = CAST(X.[auditInfo.createdOn] AS DATE)
			--WHERE X.[auditInfo.createdOn] IS NOT NULL
		);
GO

DROP TABLE [dm].[fact_employee_mobile_sync_analysis];

SELECT *
INTO [dm].[fact_employee_mobile_sync_analysis]
FROM [dm].[view_fact_employee_mobile_sync_analysis];

ALTER TABLE [dm].[fact_employee_mobile_sync_analysis] ADD CONSTRAINT dimMobSyncLatest_pk PRIMARY KEY (employeeId);

SELECT DISTINCT logDescription
	,SUBSTRING(logDescription, 1, 1)
FROM [dwh].[CT_AppLog]
WHERE errorCode IN (
		'1'
		,'2'
		,'3'
		,'4'
		,'5'
		,'6'
		)
ORDER BY SUBSTRING(logDescription, 1, 1)

SELECT *
FROM [dm].[fact_employee_mobile_sync_analysis]
WHERE employeeId = '13'

SELECT logDescription
	,buildVersion
FROM [dm].[fact_employee_mobile_sync_analysis]
WHERE logDescription <> 'N/A';

SELECT *
FROM [dm].[fact_employee_mobile_sync_analysis]
WHERE deviceLogTime IS NOT NULL;