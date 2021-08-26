/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_dim_nsp_employee]    Script Date: 22/07/2021 5:58:16 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 29th April, 2021
 PURPOSE    : Dim Employee Nespresso Dataset
 *******************************************/
--drop view dm.view_inc_dim_nsp_employee
CREATE VIEW [dm].[view_inc_dim_nsp_employee]
AS
(
		SELECT DISTINCT (A.employeeId)
			,ISNULL(A.organisationId, '') AS employeeOrganisationId
			,ISNULL(B.name, '') AS orgName
			,ISNULL(F.label, '') AS businessRole
			,ISNULL(A.STATUS, '') AS employeeStatus
			,ISNULL(A.userName, '') AS employeeUserName
			,CONCAT (
				A.[personInfo.firstName]
				,' '
				,A.[personInfo.lastName]
				) AS employeeName
			,A.[contactInfo.email] AS employeeEmail
			,ISNULL(G.label, '') AS employeeGender
			,ISNULL(I.label, '') AS employeeMaritalStatus
			,A.[contactInfo.mobilePhone] AS employeeMobilePhone
			,A.[contactInfo.fixedPhone] AS employeeFixedPhone
			,ISNULL(H.label, '') AS LANGUAGE
			,CAST(FORMAT(cast(A.startDate AS DATE), 'yyyyMMdd') AS INT) AS startDate
			,CAST(FORMAT(cast(A.endDate AS DATE), 'yyyyMMdd') AS INT) AS endDate
			,CONCAT (
				ISNULL(J.[personInfo.firstName], '')
				,' '
				,ISNULL(J.[personInfo.lastName], '')
				) AS managerName
			,ISNULL(J.[contactInfo.email], '') AS managerEmail
			,CASE 
				WHEN C.offlineMobileGroup IS NULL
					THEN 'NO'
				ELSE 'YES'
				END AS hasOfflineMobileGroupId
		FROM [dwh].[CT_Employee] AS A
		INNER JOIN [dwh].[CT_Organisation] AS B WITH (NOLOCK) ON B.organisationId = A.organisationId
			AND B.lineOfBusiness IN (
				'NESPRESSO'
				,'GLOBAL'
				)
		AND A.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'CT' and sqltablename = 'Employee')
		LEFT JOIN [dwh].[CT_UserSetting] AS C WITH (NOLOCK) ON C.userName = A.userName
		LEFT JOIN [dwh].[ET_Group] AS D WITH (NOLOCK) ON D.groupId = C.offlineMobileGroup
		LEFT JOIN [dm].[dim_list_option] AS E WITH (NOLOCK) ON A.organisationId = E.setId
		LEFT JOIN [dm].[dim_list_option] AS F WITH (NOLOCK) ON A.businessRole = F.itemCode
			AND F.setId = 'BUSINESS_ROLE'
		LEFT JOIN [dm].[dim_list_option] AS G WITH (NOLOCK) ON A.[personInfo.gender] = G.itemCode
			AND G.setId = 'GENDER'
		LEFT JOIN [dm].[dim_list_option] AS H WITH (NOLOCK) ON A.languageCode = H.itemCode
			AND H.setId = 'LANG_SAP_1CHAR'
		LEFT JOIN [dm].[dim_list_option] AS I WITH (NOLOCK) ON A.[personInfo.maritalStatus] = I.itemCode
			AND I.setId = 'MARITAL_STATUS'
		LEFT JOIN [dwh].[CT_Employee] AS J ON A.managerId = J.employeeId
		);
GO