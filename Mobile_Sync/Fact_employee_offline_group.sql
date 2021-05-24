/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dm].[view_fact_employee_offline_group]    Script Date: 17/05/2021 6:35:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 14th May, 2021
 PURPOSE    : Employee Offline Dataset
 *******************************************/
--drop view dm.view_fact_employee_offline_group				
CREATE VIEW [dm].[view_fact_employee_offline_group]
AS
(
		SELECT 
			distinct(A.employeeId) AS employeeIdOffline
			,ISNULL(A.userName, '') AS userName
			,CONCAT (
				ISNULL(A.[personInfo.firstName], '')
				,' '
				,ISNULL(A.[personInfo.lastName], '')
				,A.userName
				) AS employeeName
			,T.organisationIdUser
			,T.groupId AS offlineMobileGroupId
			,T.entityId AS entityIdOffline
			,T.entityOfflineCount
			,ISNULL(D.SyncInProgressTime, '') AS SyncInProgressTime
			,ISNULL(D.SyncStartTime, '') AS SyncStartTime
			,ISNULL(D.SyncEndTime, '') AS SyncEndTime
			,CASE 
				WHEN D.offlineMobileGroup IS NULL
					THEN 'No'
				ELSE 'Yes'
				END AS hasOfflineMobileGroup
			,F.name AS offlineMobileGroupName
		FROM [dwh].[CT_Employee] AS A
		INNER JOIN (
			SELECT * 
			FROM (
				SELECT distinct P.organisationIdUser
				,P.groupId,
				P.entityId 
					,SUM(CAST(P.entityOfflineCount AS INT)) AS entityOfflineCount
				FROM (
					SELECT DISTINCT (A.organisationId) AS organisationIdUser
						,W.*
					FROM [dwh].[CT_Employee] AS A
					INNER JOIN [dwh].[CT_OrgToGeoNode] AS B WITH (NOLOCK)
						ON A.organisationId = B.organisationId
					INNER JOIN [dwh].[CT_GeoNode_Closure] AS C WITH (NOLOCK)
						ON B.geoNodeId = C.parent
					LEFT JOIN (
						SELECT *
						FROM (
							SELECT DISTINCT (T.groupId)
								,S.entityId
								,cast(T.countEntityId AS INT) AS entityOfflineCount
								,V.geoNodeId
							FROM [dwh].[ET_GroupToEntity] AS S
							INNER JOIN [dm].[dim_group_to_entity] AS T
								ON S.groupId = T.groupId
							INNER JOIN [dwh].[ET_Group] AS U
								ON S.groupId = U.groupId
									AND U.type = 'MOBILE_OFFLINE'
							INNER JOIN [dwh].[ET_Entity] AS V
								ON S.entityId = V.entityId
									AND V.STATUS <> 'DELETED'
							) AS Q
						) AS W
						ON C.child = W.geoNodeId 
					) AS P
				GROUP BY P.organisationIdUser
					,P.groupId
					,P.entityId
				) AS M 
			) AS T
			ON A.organisationId = T.organisationIdUser
		INNER JOIN [dwh].[CT_UserSetting] AS D
			ON T.groupId = D.offlineMobileGroup
				AND A.userName = D.userName
		INNER JOIN [dwh].[ET_Group] AS F
			ON D.offlineMobileGroup = F.groupId
		) ;
GO


select *
into [dm].[fact_employee_offline_group]
from [dm].[view_fact_employee_offline_group];

ALTER TABLE [dm].[fact_employee_offline_group] ADD CONSTRAINT dimMobSyncLatest_pk PRIMARY KEY (employeeIdOffline);