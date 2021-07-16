/****** Object:  View [dm].[view_nsp_template]    Script Date: 10/05/2021 9:21:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 10th June, 2021
 PURPOSE    : Dim Nsp Organisation 
 *******************************************/
--drop view dm.view_dim_nsp_organisation
CREATE VIEW [dm].[view_dim_nsp_organisation]
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
			,A.status AS orgStatus
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
		LEFT JOIN dwh.CT_ListOption_Txt AS D ON A.organisationType = D.itemCode
		AND D.setId = 'ORG_TYPE'
		AND D.language = 'E'
		LEFT JOIN [dm].[country_code_mapping] AS C ON A.[addressInfo.countryCode] = C.country
		);
GO

select * 
into [dm].[dim_nsp_organisation]
from [dm].[view_dim_nsp_organisation]

ALTER TABLE [dm].[dim_nsp_organisation] ADD CONSTRAINT dimNspOrgPk PRIMARY KEY (organisationId);