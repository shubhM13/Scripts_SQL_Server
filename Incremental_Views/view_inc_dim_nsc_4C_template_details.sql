/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_dim_nsc_4C_template_details]    Script Date: 22/07/2021 10:33:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 22th May, 2021
 PURPOSE    : 4C Assessments
 *******************************************/
--drop view dm.view_inc_dim_nsc_4C_template_details
CREATE VIEW [dm].[view_inc_dim_nsc_4C_template_details]
AS
(
		SELECT DISTINCT B.criteriaId
			,D.templateId
			,B.title AS [checkPoint]
			,SUBSTRING(B.shortDescription, 0, 16) AS principle
			,SUBSTRING(B.shortDescription, 18, LEN(B.shortDescription)) AS criteria
			,SUBSTRING(B.longDescription, CHARINDEX('Verification Guidance: ', B.longDescription) + 23, LEN(B.longDescription)) AS verificationGuidance
			,C.title AS templateTitle
			,C.description AS templateDesc
			,D.STATUS AS templateStatus
			,D.type AS templateType
			,A.sortOrder
			,Q.title AS sectionTitle
			,Q.description AS sectionDesc
		FROM dwh.AT_Template AS D
		INNER JOIN dwh.AT_Template_Txt AS C ON D.templateId = C.templateId
			AND D.templateId IN (
				'6F53E05F41993A4CE10000000A793047'
				,'8481E15FB4533A4CE10000000A793047'
				,'FBB5E15FB4533A4CE10000000A793047'
				)
		AND A.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'AT' and sqltablename = 'Template')
		INNER JOIN [dwh].[AT_TemplateToCriteria] AS A ON C.templateId = A.templateId
		INNER JOIN [dwh].[AT_Criteria_Txt] AS B ON A.criteriaId = B.criteriaId
			AND B.LANGUAGE = 'E'
		INNER JOIN dwh.AT_Section AS P ON A.sectionId = P.sectionId
			AND D.templateId = P.templateId
		INNER JOIN dwh.AT_Section_Txt AS Q ON P.sectionId = Q.sectionId
			AND Q.LANGUAGE = 'E'
		);
GO