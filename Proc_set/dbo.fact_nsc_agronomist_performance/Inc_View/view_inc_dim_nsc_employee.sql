/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_dim_nsc_employee]    Script Date: 22/07/2021 7:31:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 29th April, 2021
 PURPOSE    : NSC Employee
 *******************************************/
--drop view dm.view_inc_dim_nsc_employee
CREATE VIEW [dm].[view_inc_dim_nsc_employee]
AS
(
		SELECT DISTINCT (A.employeeId)
			,A.userName AS userName
			,ISNULL(A.organisationId, '') AS employeeOrganisationId
			,ISNULL(F.label, '') AS businessRoleTxt
			,ISNULL(A.STATUS, '') AS employeestatus
			,CONCAT (
				A.[personInfo.firstName]
				,' '
				,A.[personInfo.lastName]
				) AS employeename
			,ISNULL(G.label, '') AS employeeGender
			,I.label AS employeeMaritalStatus
			,A.[contactInfo.email] AS employeeEmail
			,A.[contactInfo.mobilePhone] AS employeeMobilePhone
			,A.[contactInfo.fixedPhone] AS employeeFixedPhone
			,ISNULL(A.languageCode, '') AS languageCode
			,CAST(FORMAT(cast(A.startDate AS DATE), 'yyyyMMdd') AS INT) AS startDate
			,CAST(FORMAT(cast(A.endDate AS DATE), 'yyyyMMdd') AS INT) AS endDate
			,A.managerId
			,CASE 
				WHEN C.offlineMobileGroup IS NULL
					THEN 'NO'
				ELSE 'YES'
				END AS hasOfflineMobileGroupId
			,B.name AS orgName
		FROM [dwh].[CT_Employee] AS A
		LEFT JOIN [dwh].[CT_Organisation] AS B WITH (NOLOCK) ON B.organisationId = A.organisationId
			AND B.lineOfBusiness IN (
				'NESCAFE'
				,'GLOBAL'
				)
		AND A.[auditInfo.modifiedOn] >= (select LastTrigger from [AUDIT].[WaterMarkRT] where schemaname = 'CT' and tablename = 'Employee')
		AND A.[auditInfo.modifiedOn] <= (select CurrentTrigger from [AUDIT].[WaterMarkRT] where schemaname = 'CT' and tablename = 'Employee')
		LEFT JOIN [dwh].[CT_UserSetting] AS C WITH (NOLOCK) ON C.userName = A.userName
		LEFT JOIN [dwh].[ET_Group] AS D WITH (NOLOCK) ON D.groupId = C.offlineMobileGroup
			AND A.employeeId NOT IN (
				'986'
				,'982'
				,'984'
				,'1078'
				,'708'
				,'1103'
				,'697'
				,'976'
				)
		LEFT JOIN [dm].[dim_list_option] AS F WITH (NOLOCK) ON A.businessRole = F.itemCode
			AND F.setId = 'BUSINESS_ROLE'
		LEFT JOIN [dm].[dim_list_option] AS G WITH (NOLOCK) ON A.[personInfo.gender] = G.itemCode
			AND G.setId = 'GENDER'
		LEFT JOIN [dm].[dim_list_option] AS H WITH (NOLOCK) ON A.languageCode = H.itemCode
			AND H.setId = 'LANG_ISO'
		LEFT JOIN [dm].[dim_list_option] AS I WITH (NOLOCK) ON A.[personInfo.maritalStatus] = I.itemCode
			AND I.setId = 'MARITAL_STATUS'
		);
GO