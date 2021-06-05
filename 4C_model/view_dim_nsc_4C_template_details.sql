----------------------------------------------------------------------------------------------
/*******************************************
 Author     : Shubham Mishra
 Created On : 22th May, 2021
 PURPOSE    : 4C Assessments
 *******************************************/
--drop view dm.view_dim_nsc_4C_template_details
CREATE VIEW dm.view_dim_nsc_4C_template_details
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
		INNER JOIN [dwh].[AT_TemplateToCriteria] AS A ON C.templateId = A.templateId
		INNER JOIN [dwh].[AT_Criteria_Txt] AS B ON A.criteriaId = B.criteriaId
			AND B.LANGUAGE = 'E'
		INNER JOIN dwh.AT_Section AS P ON A.sectionId = P.sectionId
			AND D.templateId = P.templateId
		INNER JOIN dwh.AT_Section_Txt AS Q ON P.sectionId = Q.sectionId
			AND Q.LANGUAGE = 'E'
		);

SELECT *
INTO dm.dim_nsc_4C_template_details
FROM dm.view_dim_nsc_4C_template_details;

ALTER TABLE dm.dim_nsc_4C_template_details ADD CONSTRAINT dimNsc4CTemp PRIMARY KEY (
	criteriaId
	,templateId
	);