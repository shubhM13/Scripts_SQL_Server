/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_dim_assessment]    Script Date: 22/07/2021 10:22:39 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 27th April, 2021
 PURPOSE    : Dim Assessment
 *******************************************/
--drop view dm.view_inc_dim_assessment
CREATE VIEW [dm].[view_inc_dim_assessment]
AS
(
		SELECT DISTINCT A.templateId AS assessmentId
			,ISNULL(B.title, '') AS assessmentName
			,ISNULL(A.organisationId, '') AS assessmentCreatedByOrgId
			,ISNULL(C.lineOfBusiness, '') AS assessmentCreatedByOrgLob
			,CAST(ISNULL(A.applyToAllGeoNodes, 0) AS BIT) AS assessmentApplyToAllGeoNodes
			,CAST(ISNULL(A.applyToAllOrgs, 0) AS BIT) AS assessmentApplyToAllOrgs
			,CAST(ISNULL(A.applyToAllSuppliers, 0) AS BIT) AS assessmentApplyToAllSuppliers
			,CAST(ISNULL(A.applyToAllPartners, 0) AS BIT) AS assessmentApplyToAllPartners
			,CAST(ISNULL(A.applyToAllCertPartners, 0) AS BIT) AS assessmentApplyToAllCertPartners
		FROM dwh.AT_Template AS A
		LEFT JOIN dwh.AT_Template_Txt AS B ON A.templateId = B.templateId
			AND B.LANGUAGE = 'E'
		AND A.[auditInfo.modifiedOn] >= (select LastTrigger from [AUDIT].[WaterMarkRT] where schemaname = 'AT' and tablename = 'Template')
		AND A.[auditInfo.modifiedOn] <= (select CurrentTrigger from [AUDIT].[WaterMarkRT] where schemaname = 'AT' and tablename = 'Template')
		INNER JOIN [dwh].[CT_Organisation] AS C ON A.organisationId = C.organisationId
		WHERE A.STATUS = 'ACTIVE'
			AND A.type = 'ASSESSMENT'
		);
GO