/*******************************************
 Author     : Shubham Mishra
 Created On : 27th April, 2021
 PURPOSE    : Dim Assessment
 *******************************************/
--drop view dm.view_dim_assessment
CREATE VIEW dm.view_dim_assessment
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
		INNER JOIN [dwh].[CT_Organisation] AS C ON A.organisationId = C.organisationId
		WHERE A.status = 'ACTIVE'
		AND A.type = 'ASSESSMENT'
		);

DROP TABLE [dm].[dim_assessment]

SELECT *
INTO [dm].[dim_assessment]
FROM dm.view_dim_assessment;

ALTER TABLE [dm].[dim_assessment] ADD CONSTRAINT dimAssessm_pk PRIMARY KEY (assessmentId);

SELECT COUNT(*)
FROM [dm].[dim_assessment]
