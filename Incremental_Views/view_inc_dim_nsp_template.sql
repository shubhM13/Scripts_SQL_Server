/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_dim_nsp_template]    Script Date: 22/07/2021 6:44:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 18th April, 2021
 PURPOSE    : DimTemplate 
 *******************************************/
--drop view dm.view_inc_dim_nsp_template
CREATE VIEW [dm].[view_inc_dim_nsp_template]
AS
(
		SELECT DISTINCT A.templateId AS templateId
			,ISNULL(E.label, '') AS templateStatus
			,ISNULL(C.label, '') AS templateType
			,CAST(ISNULL(A.applyToAllGeoNodes, 0) AS BIT) AS templateApplyToAllGeoNodes
			,CAST(ISNULL(A.applyToAllOrgs, 0) AS BIT) AS templateApplyToAllOrgs
			,ISNULL(D.label, '') AS templateActivityType
			,CAST(ISNULL(A.applyToAllSuppliers, 0) AS BIT) AS templateApplyToAllSuppliers
			,CAST(ISNULL(A.applyToAllPartners, 0) AS BIT) AS templateApplyToAllPartners
			,CAST(ISNULL(A.applyToAllCertPartners, 0) AS BIT) AS templateApplyToAllCertPartners
			,A.organisationId
			,ISNULL(B.title, '') AS templateTitle
			,ISNULL(B.description, '') AS templateDescription
			,F.lineOfBusiness
		FROM dwh.AT_Template AS A
		LEFT JOIN dwh.AT_Template_Txt AS B ON A.templateId = B.templateId
			AND B.LANGUAGE = 'E'
		AND A.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'AT' and sqltablename = 'Template')
		LEFT JOIN [dm].[dim_list_option] AS C ON C.setId = 'TEMPLATE_TYPE'
			AND C.itemCode = A.type
		LEFT JOIN [dm].[dim_list_option] AS D ON D.setId = 'ASSESSMENT_ACTIVITY_TYPE'
			AND D.itemCode = A.activityType
		LEFT JOIN [dm].[dim_list_option] AS E ON E.setId = 'CRITERIA_STATUS'
			AND E.itemCode = A.STATUS
		LEFT JOIN dwh.CT_Organisation AS F ON A.organisationId = F.organisationId
		WHERE A.organisationId NOT LIKE '%NESCAFE%'
			AND A.organisationId IS NOT NULL
			AND A.templateId NOT LIKE '%NESCAFE%'
		);
GO