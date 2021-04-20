/*******************************************
 Author     : Shubham Mishra
 Created On : 25th March
 PURPOSE    : User Activity Model
 *******************************************/
--drop view dm.view_user_activity
CREATE VIEW dm.view_user_activity
AS
(
		SELECT  A.userName
				,A.organisationId
				,B.name AS orgName
				,B.lineOfBusiness AS lineOfBusiness
				,A.employeeId
				,A.[personInfo.firstName] + ' ' + A.[personInfo.lastName] AS employeeName
				,A.status 
				,A.[contactInfo.email] AS employeeEmail
				,A.[personInfo.gender] AS gender
				,A.businessRole AS businessRole
				,C.country_name AS country
				,D.LAST_SUCCESSFUL_CONNECT
		FROM [dwh].[CT_Employee] AS A
		INNER JOIN [dwh].[CT_Organisation] AS B ON A.organisationId = B.organisationId
		AND A.userName NOT IN ('FARMS_TECH', 'P000008')
		INNER JOIN [dm].[dim_geonode_flat] AS C ON A.[addressInfo.countryCode] = C.[countryCode]
		AND C.type = 'COUNTRY'
		INNER JOIN [dwh].[SYS_USERS] AS D ON A.userName = D.[USER_NAME]
		);

DROP TABLE dm.fact_user_activity;

SELECT *
INTO dm.fact_user_activity
FROM dm.view_user_activity;

--ALTER TABLE dm.fact_user_activity ADD CONSTRAINT dimUserAct_pk PRIMARY KEY (userName, LAST_SUCCESSFUL_CONNECT);

SELECT *
FROM dm.view_user_activity

SELECT *
FROM dm.fact_user_activity


