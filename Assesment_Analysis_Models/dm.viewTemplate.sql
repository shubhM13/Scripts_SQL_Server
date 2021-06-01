/****** Object:  View [dm].[view_template]    Script Date: 31/05/2021 1:37:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 11th Feb, 2021
 PURPOSE    : DimTemplate 
 *******************************************/
--drop view [dm].[view_dim_template]
CREATE VIEW [dm].[view_dim_template]
AS
(
		SELECT DISTINCT A.templateId AS templateId
			,ISNULL(A.STATUS, '') AS templateStatus
			,ISNULL(A.type, '') AS templateType
			,CAST(ISNULL(A.applyToAllGeoNodes, 0) AS BIT) AS templateApplyToAllGeoNodes
			,CAST(ISNULL(A.applyToAllOrgs, 0) AS BIT) AS templateApplyToAllOrgs
			,ISNULL(A.activityType, '') AS templateActivityType
			,CAST(ISNULL(A.applyToAllSuppliers, 0) AS BIT) AS templateApplyToAllSuppliers
			,CAST(ISNULL(A.applyToAllPartners, 0) AS BIT) AS templateApplyToAllPartners
			,CAST(ISNULL(A.applyToAllCertPartners, 0) AS BIT) AS templateApplyToAllCertPartners
			,ISNULL(A.organisationId, '') AS templateOrganisationId
			,ISNULL(B.title, '') AS templateTitle
			,ISNULL(B.description, '') AS templateDescription
			,ISNULL(C.label, '') AS templateTypeTxt
			,ISNULL(D.label, '') AS activityTypeTxt
			,ISNULL(E.label, '') AS templateStatusTxt
		FROM dwh.AT_Template AS A
		LEFT JOIN dwh.AT_Template_Txt AS B ON A.templateId = B.templateId
			AND B.LANGUAGE = 'E'
		LEFT JOIN [dm].[dim_list_option] AS C ON C.setId = 'TEMPLATE_TYPE'
			AND C.itemCode = A.type
		LEFT JOIN [dm].[dim_list_option] AS D ON D.setId = 'ASSESSMENT_ACTIVITY_TYPE'
			AND D.itemCode = A.activityType
		LEFT JOIN [dm].[dim_list_option] AS E ON E.setId = 'CRITERIA_STATUS'
			AND E.itemCode = A.STATUS
		);
GO

DROP TABLE [dm].[dim_template]

SELECT *
INTO [dm].[dim_template]
FROM dm.view_template;

ALTER TABLE [dm].[dim_template] ADD CONSTRAINT dimTemplate_pk PRIMARY KEY (templateId);

SELECT COUNT(*)
FROM [dm].[dim_template]

SELECT COUNT(*)
FROM [dwh].[AT_template]