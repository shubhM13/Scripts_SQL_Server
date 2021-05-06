SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 23rd April, 2021
 PURPOSE    : LatestObservationBaseFact Nespresso Dataset
 *******************************************/
--drop view dm.view_fact_nsp_latest_observation_base_fact				
CREATE VIEW [dm].[view_fact_nsp_latest_observation_base]
AS
(
		SELECT P.*
			,ISNULL(B.STATUS, '') AS interactionStatus
			,ISNULL(D.label, '') AS answerCodeTxt
			,ISNULL(D.score, '') AS answerCodeScore
			,ISNULL(E.label, '') AS unitOfMeasureTxt
			,ISNULL(F.label, '') AS currencyCodeTxt
		FROM (
			SELECT DISTINCT observationId
				,ISNULL(status, '') AS observationStatus
				,CAST(obsDateTime AS DATE) AS obsDate
				,CAST(FORMAT(CAST(obsDateTime AS DATE), 'yyyyMMdd') AS INT) AS obsDateKey
				,ISNULL(EntityId, '') AS observationEntityId
				,ISNULL(criteriaId, '') AS observationCriteriaId
				,ISNULL(interactionId, '') AS interactionId
				,ISNULL(CAST(notApplicableFlag AS BIT), 0) AS notApplicableFlag
				,ISNULL(answerType, '') AS answerType
				,CAST(FORMAT(CAST(answerDate AS DATE), 'yyyyMMdd') AS INT) AS answerDate
				,CAST(FORMAT(CAST(answerDate2 AS DATE), 'yyyyMMdd') AS INT) AS answerDate2
				,answerNumber
				,ISNULL(answerCode, '') AS answerCode
				,ISNULL(CAST(isLatestByYear AS BIT), 0) AS isLatestByYear
				,ISNULL(CAST(isLatest AS BIT), 0) AS isLatest
				,ISNULL(currencyCode, '') AS currencyCode
				,ISNULL(unitOfMeasure, '') AS unitOfMeasureCode
				,CASE 
					WHEN observationId IS NULL
						THEN 0
					ELSE 1
					END AS isLatestAssesment
				,RANK() OVER (
					PARTITION BY entityId
					,criteriaId ORDER BY obsDateTime DESC
					) AS observationId_1
			FROM [dwh].[AT_Observation]
			) AS P
		INNER JOIN [dwh].[IT_Interaction] AS B WITH (NOLOCK) ON P.interactionId = B.interactionId
			AND P.observationId_1 = 1
			AND P.observationStatus =  'ACTIVE'
			AND B.status NOT IN ('CANCELLED', 'DELETED')
		INNER JOIN [dwh].[CT_Organisation] AS G WITH (NOLOCK) ON B.organisationId = G.organisationId
			AND G.lineOfBusiness IN (
				'NESPRESSO'
				,'GLOBAL'
				)
		LEFT JOIN [dwh].[AT_Criteria] AS C WITH (NOLOCK) ON P.observationCriteriaId = C.criteriaId
		LEFT JOIN [dm].[dim_list_option] AS D WITH (NOLOCK) ON P.answerCode = D.itemCode
			AND C.answerListSetId = D.setId
		LEFT JOIN [dm].[dim_list_option] AS E WITH (NOLOCK) ON P.unitOfMeasureCode = E.itemCode
			AND E.setId = 'UOM'
		LEFT JOIN [dm].[dim_list_option] AS F WITH (NOLOCK) ON P.currencyCode = F.itemCode
			AND F.setId = 'CURRENCY_CODES'
		);
GO

select distinct status from [dwh].[IT_Interaction];

select * 
into [dm].[fact_nsp_latest_observation_base]
from [dm].[view_fact_nsp_latest_observation_base];

ALTER TABLE [dm].[fact_nsp_latest_observation_base] ADD CONSTRAINT dimNspObsBase_pk PRIMARY KEY (observationId);