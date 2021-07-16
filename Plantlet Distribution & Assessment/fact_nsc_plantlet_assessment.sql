/****** Object:  View [dm].[view_fact_nsc_plantlet_assessment]    Script Date: 09/06/2021 11:38:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 20th May 2021
 PURPOSE    : Plantlet Assessment Nescafe Dataset
 *******************************************/
--drop view [dm].[view_fact_nsc_plantlet_assessment]	
		
CREATE VIEW [dm].[view_fact_nsc_plantlet_assessment]
AS
(
		SELECT DISTINCT (A.observationId)
			,ISNULL(A.STATUS, '') AS STATUS
			,ISNULL(A.type, '') AS type
			,CAST(FORMAT(CAST(A.obsDateTime AS DATE), 'yyyyMMdd') AS INT) AS obsDateTime
			,ISNULL(A.entityId, '') AS entityId
			,ISNULL(A.criteriaId, '') AS criteriaId
			,ISNULL(A.interactionId, '') AS interactionId
			,ISNULL(A.parentObservationId, '') AS parentObservationId
			,ISNULL(CAST(A.notApplicableFlag AS BIT), 0) AS notApplicableFlag
			,ISNULL(A.riskyFlag, '') AS riskyFlag
			,ISNULL(A.answerType, '') AS answerType
			,ISNULL(A.answerDate, '') AS answerDate
			,ISNULL(A.answerDate2, '') AS answerDate2
			,ISNULL(A.answerText, '') AS answerText
			,ISNULL(A.answerNumber, '') AS answerNumber
			,ISNULL(A.unitOfMeasure, '') AS unitOfMeasure
			,ISNULL(A.currencyCode, '') AS currencyCode
			,ISNULL(A.answerCode, '') AS answerCode
			,ISNULL(CAST(isLatest AS BIT), 0) AS isLatest
			,ISNULL(CAST(isLatestByYear AS BIT), 0) AS isLatestByYear
			,ISNULL(B.geoNodeId, '') AS geoNodeId
			,A.[auditInfo.createdBy] AS [auditInfo.createdBy]
			,CAST(FORMAT(cast(A.[auditInfo.createdOn] AS DATE), 'yyyyMMdd') AS INT) AS [auditInfo.createdOn]
			,A.[auditInfo.modifiedBy] AS [auditInfo.modifiedBy]
			,CAST(FORMAT(cast(A.[auditInfo.modifiedOn] AS DATE), 'yyyyMMdd') AS INT) AS [auditInfo.modifiedOn]
			,A.[auditInfo.requestedBy] AS [auditInfo.requestedBy] 
			,A.[auditInfo.modifiedReasonCode] AS [auditInfo.modifiedReasonCode]
			,A.[auditInfo.channel] AS [auditInfo.channel]
		FROM [dwh].[AT_Observation] AS A
		LEFT JOIN [dwh].[ET_Entity] AS B WITH (NOLOCK)
			ON A.entityId = B.entityId
		INNER JOIN [dwh].[CT_GeoNode] AS C WITH (NOLOCK)
			ON B.geonodeId = C.geonodeId
				AND C.lineOfBusiness IN (
					'NESCAFE'
					,'GLOBAL'
					)
		WHERE A.criteriaId IN (
				'NESCAFE_ME_C_GAP_CH_4'
				,'NESCAFE_ME_C_GAP_CH_5'
				,'NESCAFE_ME_C_GAP_CH_9'
				,'NESCAFE_ME_C_GAP_CH_11'
				,'NESCAFE_DISTRIBUTION_FLAG'
				)
			AND A.interactionId IN (
				SELECT interactionId
				FROM [dwh].[IT_Interaction]
				WHERE STATUS = 'COMPLETED'
					AND type = 'ASSESSMENT'
				)
			AND  A.entityId IN (select distinct entityId from [dm].[dim_nsc_entity_master])
			OR A.entityId is null
			AND CAST(FORMAT(cast(A.obsDateTime AS DATE), 'yyyyMMdd') AS INT) IN (select distinct Datekey from [dm].[dim_date])
			OR A.obsDateTime is null
			AND C.[geoNodeId] IN (select distinct [geoNodeId]  from [dm].[dim_geonode_flat])
			OR C.[geoNodeId] is null

		);
GO


