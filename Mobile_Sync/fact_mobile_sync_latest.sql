/*******************************************
 Author     : Shubham Mishra
 Created On : 15th June, 2021
 PURPOSE    : Data Model for Mobile Sync History Report
 *******************************************/
--drop view dm.view_fact_employee_mobile_sync_analysis_daily_history				
CREATE VIEW [dm].[view_fact_employee_mobile_sync_analysis_daily_history]
AS
(
		SELECT A.userName
			,A.logDate
			,E.name AS [Org Name]
			,E.lineOfBusiness AS [Line Of Business]
			,D.[contactInfo.email] AS [Employee Email]
			,CONCAT (
				CONCAT (
					D.[personInfo.firstName]
					,' '
					)
				,D.[personInfo.lastName]
				) AS [Employee Name]
			,D.[addressInfo.countryCode] AS country
			,A.attemptCount
			,B.successfulattemptCount
			,(A.attemptCount - B.successfulAttemptCount) AS failedAttemptCount
			,C.dailyLogDetails
			,X.[auditInfo.createdOn] AS devicelogTime
			,X.platform AS devicePlatform
			,X.model AS deviceModel
			,X.manufacturer AS deviceManufacturer
			,X.osVersion AS OSVersion
			,X.platform + ' ' + X.osVersion AS OS
			,X.cordovaVersion AS cordovaVersion
		FROM (
			SELECT userName
				,CAST(logTime AS DATE) AS logDate
				,count(errorCode) AS attemptCount
			FROM [dwh].[CT_AppLog]
			WHERE errorCode IN ('1')
			GROUP BY userName
				,CAST(logTime AS DATE)
			) A
		INNER JOIN (
			SELECT userName
				,CAST(logTime AS DATE) AS logDate
				,count(errorCode) AS successfulAttemptCount
			FROM [dwh].[CT_AppLog]
			WHERE errorCode IN ('6')
			GROUP BY userName
				,CAST(logTime AS DATE)
			) B ON A.userName = B.userName
			AND A.logDate = B.logDate
		INNER JOIN (
			SELECT userName
				,CAST(logTime AS DATE) AS logDate
				,STRING_AGG(CAST(CONCAT (
							CONCAT (
								CONCAT (
									CONCAT (
										CONCAT (
											'['
											,errorCode
											)
										,' : '
										)
									,SUBSTRING(logDescription, CASE 
											WHEN CHARINDEX('Version No: ', logDescription) = 0
												THEN LEN(logDescription)
											ELSE CHARINDEX('Version No: ', logDescription) + 12
											END, CASE 
											WHEN CHARINDEX('-DELTA', logDescription) = 0
												THEN 0
											ELSE CHARINDEX('-DELTA', logDescription) - CHARINDEX('Version No: ', logDescription) - 12
											END)
									)
								,CASE 
									WHEN logTime IS NOT NULL
										THEN ' | (' + CAST(logTime AS NVARCHAR(100)) + ')'
									ELSE ''
									END
								)
							,']'
							) AS NVARCHAR(MAX)), ' ; ') WITHIN
			GROUP (
					ORDER BY logTime ASC
					) AS dailyLogDetails
			FROM [dwh].[CT_AppLog]
			WHERE errorCode IN (
					'1'
					,'2'
					,'3'
					,'4'
					,'5'
					,'6'
					)
			GROUP BY userName
				,CAST(logTime AS DATE)
			) C ON A.userName = C.userName
			AND A.logDate = C.logDate
		LEFT JOIN (
			SELECT *
			FROM (
				SELECT *
					,RANK() OVER (
						PARTITION BY [auditInfo.createdBy]
						,CAST([auditInfo.createdOn] AS DATE) ORDER BY [auditInfo.createdBy]
							,[auditInfo.createdOn] DESC
						) AS rank_1
				FROM [dwh].[LT_DeviceInfo]
				) AS Q
			WHERE Q.rank_1 = 1
			) AS X ON B.userName = X.[auditInfo.createdBy]
			AND CAST(B.logDate AS DATE) = CAST(X.[auditInfo.createdOn] AS DATE)
		LEFT JOIN [dwh].[CT_Employee] AS D ON A.userName = D.userName
		LEFT JOIN [dwh].[CT_Organisation] AS E ON D.organisationId = E.organisationId
		);

-- select * from [dwh].[LT_DeviceInfo];
-- select * from [dm].[view_fact_employee_mobile_sync_analysis_daily_history] where devicelogTime is not null;
-- drop table [dm].[fact_employee_mobile_sync_analysis_daily_history];
SELECT *
INTO [dm].[fact_employee_mobile_sync_analysis_daily_history]
FROM [dm].[view_fact_employee_mobile_sync_analysis_daily_history];
	-- ALTER TABLE [dm].[fact_employee_mobile_sync_analysis_daily_history] ADD CONSTRAINT factMobHist PRIMARY KEY (userName, logDate);
	-- ALTER TABLE [dm].[fact_employee_mobile_sync_analysis_daily_history] ALTER COLUMN userName nvarchar(100) NOT NULL;
	-- ALTER TABLE [dm].[fact_employee_mobile_sync_analysis_daily_history] ALTER COLUMN logDate DATE NOT NULL;
