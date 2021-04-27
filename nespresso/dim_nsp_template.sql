/*******************************************
 Author     : Shubham Mishra
 Created On : 18th April, 2021
 PURPOSE    : DimTemplate 
 *******************************************/
--drop view dm.view_nsp_template
CREATE VIEW dm.view_nsp_template
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
			,A.organisationId
			,ISNULL(B.title, '') AS templateTitle
			,ISNULL(B.description, '') AS templateDescription
			,ISNULL(C.label, '') AS templateTypeTxt
			,ISNULL(D.label, '') AS activityTypeTxt
			,ISNULL(E.label, '') AS templateStatusTxt
			,F.lineOfBusiness
		FROM dwh.AT_Template AS A
		LEFT JOIN dwh.AT_Template_Txt AS B ON A.templateId = B.templateId
			AND B.LANGUAGE = 'E'
		LEFT JOIN [dm].[dim_list_option] AS C ON C.setId = 'TEMPLATE_TYPE'
			AND C.itemCode = A.type
		LEFT JOIN [dm].[dim_list_option] AS D ON D.setId = 'ASSESSMENT_ACTIVITY_TYPE'
			AND D.itemCode = A.activityType
		LEFT JOIN [dm].[dim_list_option] AS E ON E.setId = 'CRITERIA_STATUS'
			AND E.itemCode = A.STATUS
        LEFT JOIN dwh.CT_Organisation AS F ON A.organisationId = F.organisationId
        WHERE A.organisationId NOT LIKE '%NESCAFE%'
		OR A.organisationId IS NULL
		AND A.templateId NOT LIKE '%NESCAFE%'
		);

DROP TABLE [dm].[dim_nsp_template]

SELECT *
INTO [dm].[dim_nsp_template]
FROM dm.view_nsp_template;

ALTER TABLE [dm].[dim_nsp_template] ADD CONSTRAINT dimNspTemplate_pk PRIMARY KEY (templateId);

SELECT COUNT(*)
FROM [dm].[dim_nsp_template]

SELECT COUNT(*)
FROM dm.view_nsp_template;

select * from  [dm].[fact_nsp_assessment_analysis] where interactionTemplateId NOT IN (select templateId from [dm].[dim_nsp_template])

select * from dwh.AT_Template where templateId = '580503D231779114E10000000A4E71D5'