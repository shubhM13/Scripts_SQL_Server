/****** Object:  View [dm].[view_nsp_criteria]    Script Date: 31/05/2021 1:35:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 20th April
 PURPOSE    : DimNspCriteria 
 *******************************************/
--drop view dm.view_dim_nsp_criteria
CREATE VIEW [dm].[view_dim_nsp_criteria]
AS
(
		SELECT DISTINCT A.criteriaId AS criteriaId
						,ISNULL(A.externalId, '') AS criteriaCode
						,ISNULL(A.status, '') AS criteriaStatus
						,ISNULL(E.label, '') AS criteriaClassification1
						,ISNULL(F.label, '') AS criteriaClassification2
						,ISNULL(G.label, '') AS criteriaClassification3
						,CAST(ISNULL(A.complianceFlag, 0) AS BIT) AS criteriaComplianceFlag
						,ISNULL(D.label, '') AS criteriaAnswerType
						,CASE 
							WHEN C.title IS NOT NULL
							THEN C.title
							ELSE B.title
							END AS criteriaTitle
						,CASE 
							WHEN C.shortDescription IS NOT NULL
							THEN C.shortDescription
							ELSE B.shortDescription
							END AS criteriaShortDescription
						,CASE 
							WHEN C.longDescription IS NOT NULL
							THEN C.longDescription
							ELSE B.longDescription
							END AS criteriaLongDescription
		FROM dwh.AT_Criteria AS A
		LEFT JOIN (
			SELECT * FROM
				 (
				 SELECT criteriaId
					  , language
					  , title
					  , shortDescription
					  , longDescription
					  , RANK() OVER (PARTITION BY criteriaId ORDER BY language ASC) AS rnk
				   FROM dwh.AT_Criteria_Txt
				   WHERE language <> 'E'
				 ) AS P
				 where P.rnk = 1) AS B ON A.criteriaId = B.criteriaId
		LEFT JOIN dwh.AT_Criteria_Txt AS C ON A.criteriaId = C.criteriaId
			AND C.LANGUAGE = 'E'
		LEFT JOIN [dm].[dim_list_option] AS D ON D.setId = 'ANSWER_TYPE'
			AND D.itemCode = A.answerType
		LEFT JOIN [dm].[dim_list_option] AS E ON E.setId = 'CRITERIA_CLASS1'
			AND E.itemCode = A.classification1
		LEFT JOIN [dm].[dim_list_option] AS F ON F.setId = 'CRITERIA_CLASS2'
			AND F.itemCode = A.classification2
		LEFT JOIN [dm].[dim_list_option] AS G ON G.setId = 'CRITERIA_CLASS3'
			AND G.itemCode = A.classification3
		WHERE A.criteriaId IN (select distinct observationCriteriaId from [dm].[view_fact_assessment_analysis])
		);
GO




DROP TABLE [dm].[dim_nsp_criteria]

SELECT *
INTO [dm].[dim_nsp_criteria]
FROM dm.view_nsp_criteria;

ALTER TABLE [dm].[dim_nsp_criteria] ADD CONSTRAINT dimNspCriteria_pk PRIMARY KEY (criteriaId);

SELECT COUNT(*)
FROM [dm].[dim_nsp_criteria]

SELECT COUNT(*)
FROM [dwh].[AT_criteria]

SELECT *
FROM [dm].[dim_criteria]
