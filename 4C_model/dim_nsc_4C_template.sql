SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 27th May, 2021
 PURPOSE    : 4C Data Model
 *******************************************/
--drop view dm.view_dim_nsc_4C_template		
CREATE VIEW [dm].[view_dim_nsc_4C_template]
AS
(
		SELECT distince D.templateId
			,B.criteriaId AS templateCriteriaId
			,ISNULL(C.title, 'N/A') AS templateTitle
			,ISNULL(C.description, 'N/A') AS templateDesc
			,ISNULL(D.STATUS, 'N/A') AS templateStatus
			,ISNULL(D.type, 'N/A') AS templateType
			,D.startDate AS templateStartDate
			,D.endDate AS templateEndDate
			,ISNULL(B.title, 'N/A') AS criteriaTitle
			,ISNULL(B.shortDescription, 'N/A') AS criteriaShortDesc
			,ISNULL(B.longDescription, 'N/A') AS criteriaLongDesc
			,ISNULL(A.sortOrder, 'N/A') AS criteriaSortOrder
			,ISNULL(Q.title, 'N/A') AS sectionTitle
			,ISNULL(Q.description, 'N/A') AS sectionDesc
		FROM dwh.AT_Template AS D
		INNER JOIN dwh.AT_Template_Txt AS C ON D.templateId = C.templateId
			AND D.templateId IN (
				'6F53E05F41993A4CE10000000A793047'
				,'8481E15FB4533A4CE10000000A793047'
				,'FBB5E15FB4533A4CE10000000A793047'
				)
		INNER JOIN [dwh].[AT_TemplateToCriteria] AS A ON C.templateId = A.templateId
		INNER JOIN [dwh].[AT_Criteria_Txt] AS B ON A.criteriaId = B.criteriaId
			AND B.LANGUAGE = 'E'
		INNER JOIN dwh.AT_Section AS P ON A.sectionId = P.sectionId
			AND D.templateId = P.templateId
		INNER JOIN dwh.AT_Section_Txt AS Q ON P.sectionId = Q.sectionId
			AND Q.LANGUAGE = 'E'
		)
GO

