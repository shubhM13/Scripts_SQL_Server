/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_dim_nsp_organisation]    Script Date: 22/07/2021 6:39:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 10th June, 2021
 PURPOSE    : Dim Nsp Organisation 
 *******************************************/
--drop view dm.view_inc_dim_nsp_organisation
CREATE VIEW [dm].[view_inc_dim_nsp_organisation]
AS
(
		SELECT DISTINCT A.organisationId
			,ISNULL(A.externalSystemId, 'N/A') AS orgBusinessId
			,CASE 
				WHEN A.businessUnitFlag = 1
					THEN 'True'
				ELSE 'Flase'
				END AS isBusinessUnit
			,CASE 
				WHEN A.adminUnitFlag = 1
					THEN 'True'
				ELSE 'Flase'
				END AS isAdminUnit
			,ISNULL(D.label, 'N/A') AS organisationType
			,ISNULL(A.name, 'N/A') AS orgName
			,ISNULL(B.name, 'N/A') AS parentOrgName
			,A.activationDate
			,A.coffeeForm
			,A.STATUS AS orgStatus
			,A.dilutionRate
			,ISNULL(A.productionUOM, 'N/A') AS productionUOM
			,A.totalWomen
			,A.totalMen
			,ISNULL(A.[addressInfo.address1], '') AS addressLine1
			,ISNULL(A.[addressInfo.address2], '') AS addressLine2
			,ISNULL(A.[addressInfo.city], '') AS addressCity
			,ISNULL(A.[addressInfo.district], '') AS addressDistrict
			,ISNULL(A.[addressInfo.province], '') AS addressProvince
			,ISNULL(A.[addressInfo.zipcode], '') AS addressZipcode
			,ISNULL(A.[addressInfo.countryCode], '') AS addressCountryCode
			,C.latitude
			,C.longitude
			,ISNULL(C.name, '') AS countryName
		FROM dwh.CT_Organisation AS A
		LEFT JOIN dwh.CT_Organisation AS B ON A.parentId = B.organisationId
		AND A.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'CT' and sqltablename = 'Organisation')
		LEFT JOIN dwh.CT_ListOption_Txt AS D ON A.organisationType = D.itemCode
			AND D.setId = 'ORG_TYPE'
			AND D.LANGUAGE = 'E'
		LEFT JOIN [dm].[country_code_mapping] AS C ON A.[addressInfo.countryCode] = C.country
		);
GO