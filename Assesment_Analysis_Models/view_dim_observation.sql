/****** Object:  View [dm].[view_dim_observation]    Script Date: 30-06-2021 12:00:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*******************************************
 Author     : Shubham Mishra
 Created On : 17th Feb, 2021
 PURPOSE    : DimObservation
 *******************************************/
--drop view [dm].[view_dim_observation]
CREATE VIEW [dm].[view_dim_observation]
AS
(
		SELECT A.observationId AS observationId
			,cast(A.obsDateTime AS DATE) AS obsDate
			,CAST(FORMAT(cast(A.obsDateTime AS DATE), 'yyyyMMdd') AS INT) AS obsDateKey
			,ISNULL(A.entityId, '') AS observationEntityId
			,ISNULL(A.criteriaId, '') AS observationCriteriaId
			,ISNULL(A.interactionId, '') AS interactionId
			,ISNULL(CAST(A.notApplicableFlag AS BIT), 0) AS notApplicableFlag
			,A.answerType AS answerType
			,A.answerDate AS answerDate
			,CAST(FORMAT(cast(A.answerDate AS DATE), 'yyyyMMdd') AS INT) AS answerDateKey
			,A.answerDate2 AS answerDate2
			,CAST(FORMAT(cast(A.answerDate2 AS DATE), 'yyyyMMdd') AS INT) AS answerDate2Key
			,A.answerNumber AS answerNumber
			,A.answerText AS answerText
			,A.answerCode AS answerCode
			,C.label AS answerCodeTxt
			,C.score AS answerCodeScore
			,D.selectedCode AS multiListAnswerCode
			,D.answerText AS multiListAnswerCodeTxt
			,D.answerScore AS multiListAnswerCodeScore
			,ISNULL(A.unitOfMeasure, '') AS unitOfMeasure
			,ISNULL(F.label, '') AS unitOfMeasureTxt
			,ISNULL(A.currencyCode, '') AS currencyCode
			,ISNULL(G.label, '') AS currencyCodeTxt
			,ISNULL(CAST(A.isLatest AS BIT), 0) AS isLatest
			,ISNULL(CAST(A.isLatestByYear AS BIT), 0) AS isLatestByYear
		FROM dwh.AT_Observation AS A
		LEFT JOIN [dwh].[AT_Criteria] AS B ON A.criteriaId = B.criteriaId
		LEFT JOIN [dm].[dim_list_option] AS C ON C.setId = B.answerListSetId
			AND C.itemCode = A.answerCode
		LEFT JOIN [dm].[view_dim_multiselect_answers_flat] AS D ON D.observationId = A.observationId
		LEFT JOIN [dm].[dim_list_option] AS F ON F.setId = 'UOM'
			AND F.itemCode = A.unitOfMeasure
		LEFT JOIN [dm].[dim_list_option] AS G ON G.setId = 'CURRENCY_CODES'
			AND G.itemCode = A.currencyCode
		WHERE A.status = 'ACTIVE'
		);
GO

drop table [dm].[dim_observation];

select * 
into [dm].[dim_observation]
from [dm].[view_dim_observation];

ALTER TABLE [dm].[dim_observation] ADD CONSTRAINT dimObsPk PRIMARY KEY (observationId);


