/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_dim_nsp_criteria]    Script Date: 22/07/2021 5:51:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 20th April
 PURPOSE    : DimNspCriteria 
 *******************************************/
--drop view dm.view_inc_dim_nsp_criteria
CREATE VIEW [dm].[view_inc_dim_nsp_criteria]
AS
(
		SELECT DISTINCT A.criteriaId AS criteriaId
			,ISNULL(A.externalId, '') AS criteriaCode
			,ISNULL(A.STATUS, '') AS criteriaStatus
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
			SELECT *
			FROM (
				SELECT criteriaId
					,LANGUAGE
					,title
					,shortDescription
					,longDescription
					,RANK() OVER (
						PARTITION BY criteriaId ORDER BY LANGUAGE ASC
						) AS rnk
				FROM dwh.AT_Criteria_Txt
				WHERE LANGUAGE <> 'E'
				) AS P
			WHERE P.rnk = 1
			) AS B ON A.criteriaId = B.criteriaId
		AND A.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'AT' and sqltablename = 'Criteria')
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
		WHERE A.criteriaId IN (
				SELECT DISTINCT observationCriteriaId
				FROM [dm].[view_fact_nsp_assessment_analysis]
				)
		);
GO