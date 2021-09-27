SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 15th Sept, 2021
 PURPOSE    : User Activity Latest
 *******************************************/
--drop view dm.view_fact_user_activity_latest
CREATE VIEW [dm].[view_fact_user_activity_latest]
AS
(

		SELECT  distinct P.*
				,A.organisationId
				,B.name AS orgName
				,B.lineOfBusiness AS lineOfBusiness
				,A.employeeId
				,A.[personInfo.firstName] + ' ' + A.[personInfo.lastName] AS employeeName
				,A.status 
				,A.[contactInfo.email] AS employeeEmail
				,I.label AS gender
				,D.label AS businessRole
				,ISNULL(C.country_name, 'N/A') AS country
		FROM [dwh].[CT_Employee] AS A
		INNER JOIN [dwh].[CT_Organisation] AS B ON A.organisationId = B.organisationId
		AND A.userName IS NOT NULL
		LEFT JOIN [dm].[dim_geonode_flat] AS C ON A.[addressInfo.countryCode] = C.[countryCode]
		AND C.type = 'COUNTRY'
		LEFT JOIN [dm].[dim_list_option] AS D WITH (NOLOCK) ON A.businessRole = D.itemCode
			AND D.setId = 'BUSINESS_ROLE'
		LEFT JOIN [dm].[dim_list_option] AS I WITH (NOLOCK) ON A.[personInfo.gender] = I.itemCode
			AND I.setId = 'GENDER'
		RIGHT OUTER JOIN dwh.SYS_USERS AS P
		ON A.userName = P.USER_NAME);