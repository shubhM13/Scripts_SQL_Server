/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_fact_employee_mobile_sync_analysis]    Script Date: 05/05/2021 10:00:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 17th May, 2021
 PURPOSE    : EmployeeMobileSyncAnalysis Dataset
 *******************************************/
--drop view dm.view_fact_employee_mobile_sync_analysis				
CREATE VIEW [dm].[view_fact_employee_mobile_sync_analysis]
AS
(
		SELECT DISTINCT (A.userName)
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
		ELSE CAST(DATEDIFF(second,A.SyncStartTime, A.SyncEndTime)/60 as nvarchar(20)) + ' mins ' +          
			CAST(DATEDIFF(second, A.SyncStartTime, A.SyncEndTime)% 60 as nvarchar(20))  + ' secs '
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
		ELSE Month(A.SyncInProgressTime)
		END AS Month
	,CASE 
		WHEN A.SyncEndTime IS NULL
			THEN 0
		ELSE day(A.SyncInProgressTime)
		END AS Day
	,ISNULL(B.logDescription, '') AS logDescription
	,ISNULL(B.syncType, '') AS syncType
	,ISNULL(C.organisationId, '') AS organisationId
	,ISNULL(I.name, '') AS orgName  -- not in module
	,ISNULL(I.lineOfBusiness, '') AS lineOfBusiness
	,ISNULL(C.employeeId, '') AS employeeId
	,CONCAT (
		C.[personInfo.firstName]
		,' '
		,C.[personInfo.lastName]
		) AS employeeName
	,C.[contactInfo.email] AS contactInfo_email
	,H.name AS nameCountry
	,G.entityCountAccess
	,J.entityOfflineCount
FROM [dwh].[CT_UserSetting] AS A WITH (NOLOCK)
LEFT JOIN (
	SELECT *
	FROM (
		SELECT logDescription
			,userName
			,eventType
			,CASE 
				WHEN errorCode IN ('1', '2', '3', '4', '5', '6')
					THEN 'Delta'
				WHEN errorCode IN ('U1000', 'S')
					THEN 'Non-Delta'
				END AS syncType
			,RANK() OVER (
				PARTITION BY logTime ORDER BY logTime DESC
				) AS rnk
		FROM [dwh].[CT_AppLog]
		) AS Z
	WHERE Z.rnk = 1
	) AS B
	ON A.userName = B.userName
		AND B.eventType = 'MobileSyncLog'
LEFT JOIN [dwh].[CT_Employee] AS C WITH (NOLOCK)
	ON A.userName = C.userName
		AND C.STATUS = 'ACTIVE'
INNER JOIN (
	SELECT *
	FROM (
		SELECT Y.organisationId
			,SUM(Y.entityCountPerGeonode) AS entityCountAccess
		FROM (
			SELECT D.organisationId
				,F.geoNodeId
				,F.name
				,F.geoNodeType
				,F.entityCountPerGeonode  
			FROM [dwh].CT_OrgToGeoNode AS D
			-----Shubham's Code Started Here
			(SELECT X.geoNodeId
				,X.name
				,X.geoNodeType
				,sum(F.entityCountPerGeonode) AS entityCountPerCountry
				FROM [dwh].CT_GeoNode_Closure AS E
			INNER JOIN [dwh].[CT_GeoNode] AS X
			 ON E.parent = X.geoNodeId
			 AND X.geoNodeType ='COUNTRY'
			INNER JOIN (
					SELECT Q.geoNodeId
					,R.name
					,R.geoNodeType
					,COUNT(Q.entityId) AS entityCountPerGeonode
					FROM [dwh].ET_Entity AS Q
					INNER JOIN [dwh].[CT_GeoNode] AS R
						ON Q.geoNodeId = R.geoNodeId 
					WHERE Q.STATUS <> 'DELETED'
					GROUP BY Q.geoNodeId,R.name,R.geoNodeType
				) AS F
				ON F.geoNodeId = E.child 
				group by  X.geoNodeId,X.name,X.geoNodeType,F.entityCountPerGeonode
				order by X.name
				-----Shubham's Code Ended Here
			) AS Y
		GROUP BY Y.organisationId
		) AS W
	) AS G
	ON C.organisationId = G.organisationId		
INNER JOIN [dwh].[CT_GeoNode] AS H WITH (NOLOCK)
	ON C.[addressInfo.countryCode] = H.countryCode
		AND H.geoNodeType = 'COUNTRY'
LEFT JOIN [dwh].[CT_Organisation] AS I WITH (NOLOCK)
	ON C.Organisationid = I.Organisationid
LEFT JOIN [dm].[view_fact_employee_offline_group] J WITH (NOLOCK)
			ON A.userName = J.userName
		);
GO



select * from dm.view_fact_employee_mobile_sync_analysis 
where userName ='P000981'