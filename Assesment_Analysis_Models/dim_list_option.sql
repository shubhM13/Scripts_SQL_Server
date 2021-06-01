/****** Object:  View [dm].[view_list_option]    Script Date: 31/05/2021 1:34:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 15th Feb
 PURPOSE    : DimListOption 
 *******************************************/
--drop view [dm].[view_dim_list_option]
CREATE VIEW [dm].[view_dim_list_option]
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
			SELECT * FROM
				 (
				 SELECT setId
					  , itemCode
					  , language
					  , label
					  , RANK() OVER (PARTITION BY setId, itemCode ORDER BY language ASC) AS rnk
				   FROM dwh.CT_ListOption_Txt
				   WHERE language <> 'E'
				 ) AS P
				 where P.rnk = 1) AS B ON A.setId = B.setId
			AND A.itemCode = B.itemCode
		LEFT JOIN dwh.CT_ListOption_Txt AS C ON A.setId = C.setId
			AND A.itemCode = C.itemCode
			AND C.LANGUAGE = 'E'
		);
GO




DROP TABLE [dm].[dim_list_option]
SELECT *
INTO [dm].[dim_list_option]
FROM dm.view_list_option;

ALTER TABLE [dm].[dim_list_option] ADD CONSTRAINT dimlistOpt_pk PRIMARY KEY (setId, itemCode);

SELECT COUNT(*)
FROM [dm].[dim_list_option]

SELECT COUNT(*)
FROM dwh.CT_ListOption

SELECT *
FROM [dm].[dim_list_option]
