/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_dim_list_option]    Script Date: 22/07/2021 10:28:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 15th Feb
 PURPOSE    : DimListOption 
 *******************************************/
--drop view [dm].[view_inc_dim_list_option]
CREATE VIEW [dm].[view_inc_dim_list_option]
AS
(
		SELECT DISTINCT A.setId AS setId
			,ISNULL(A.itemCode, '') AS itemCode
			,ISNULL(A.score, 0) AS score
			,CASE 
				WHEN C.label IS NOT NULL
					THEN C.label
				ELSE B.label
				END AS label
		FROM dwh.CT_ListOption AS A
		LEFT JOIN (
			SELECT *
			FROM (
				SELECT setId
					,itemCode
					,LANGUAGE
					,label
					,RANK() OVER (
						PARTITION BY setId
						,itemCode ORDER BY LANGUAGE ASC
						) AS rnk
				FROM dwh.CT_ListOption_Txt
				WHERE LANGUAGE <> 'E'
				) AS P
			WHERE P.rnk = 1
			) AS B ON A.setId = B.setId
			AND A.itemCode = B.itemCode
		AND A.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'CT' and sqltablename = 'ListOption')
		LEFT JOIN dwh.CT_ListOption_Txt AS C ON A.setId = C.setId
			AND A.itemCode = C.itemCode
			AND C.LANGUAGE = 'E'
		);
GO