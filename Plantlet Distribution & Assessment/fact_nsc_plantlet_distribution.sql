/****** Object:  View [dm].[view_fact_nsc_plantlet_distribution]    Script Date: 6/9/2021 8:23:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 24th May, 2021
 PURPOSE    : Plantlet Distribution Nescafe Dataset
 *******************************************/
--drop view [dm].[view_fact_nsc_plantlet_distribution]
CREATE VIEW [dm].[view_fact_nsc_plantlet_distribution]
AS
(
		SELECT *
		FROM (
			SELECT DISTINCT (A.[movementId])
				,'SENT' AS interaction_type
				,A.[type] AS movement_type
				,A.[status] AS movement_status
				,A.[varietyId]
				,A.[propagationMethod]
				,A.[shipmentIdentifier]
				,A.[startEntityId] AS start_end_EntityId
				,B.[geoNodeId] AS start_end_GeoNodeId
				,A.[senderId] AS sender_receiver_Id
				,CAST(FORMAT(CAST(A.[sentOn] AS DATE), 'yyyyMMdd') AS INT) AS sent_received_date_key
				,A.[sentQty] AS sent_received_Qty
				,A.[price.amount] AS [price.amount]
				,A.[price.currencyCode]
				,A.[costOfProduction.amount] AS [costOfProduction.amount]
				,A.[costOfProduction.currencyCode] AS [costOfProduction.currencyCode]
				,A.[auditInfo.createdBy] AS [auditInfo.createdBy]
				,CAST(FORMAT(CAST(A.[auditInfo.createdOn] AS DATE), 'yyyyMMdd') AS INT) AS [auditInfo.createdOn]
				,A.[auditInfo.modifiedBy] AS [auditInfo.modifiedBy]
				,CAST(FORMAT(CAST(A.[auditInfo.modifiedOn] AS DATE), 'yyyyMMdd') AS INT) AS [auditInfo.modifiedOn]
				,A.[auditInfo.requestedBy] AS [auditInfo.requestedBy]
				,A.[auditInfo.modifiedReasonCode] AS [auditInfo.modifiedReasonCode]
				,A.[auditInfo.channel] AS [auditInfo.channel]
				,A.[lossReason]
				,A.[distributionPurpose]
				,B.personId AS start_end_entity_primary_contact
			FROM [dwh].[PT_Movement] AS A
			LEFT JOIN (
				SELECT X.personId
					,Z.entityId
					,Z.geoNodeId
				FROM dwh.ET_Entity AS Z
				LEFT JOIN (
					SELECT personId
						,entityId
					FROM (
						SELECT entityId
							,personId
							,RANK() OVER (
								PARTITION BY entityId ORDER BY [auditInfo.createdOn] DESC
								) AS rnk
						FROM [dwh].[ET_Person]
						) AS Y
					WHERE Y.rnk = 1
					) AS X ON X.entityId = Z.entityId
				INNER JOIN [dwh].[CT_GeoNode] AS W WITH (NOLOCK) ON Z.geonodeId = W.geonodeId
					AND W.lineOfBusiness IN (
						'NESCAFE'
						,'GLOBAL'
						)
				) AS B ON A.[startEntityId] = B.entityId
			WHERE B.personId IN (
					SELECT DISTINCT personId
					FROM [dm].[dim_nsc_person]
					)
				OR B.personId IS NULL
				AND CAST(FORMAT(cast(A.sentOn AS DATE), 'yyyyMMdd') AS INT) IN (
					SELECT DISTINCT DateKey
					FROM [dm].[dim_date]
					)
				OR A.sentOn IS NULL
				AND CAST(FORMAT(cast(A.receivedOn AS DATE), 'yyyyMMdd') AS INT) IN (
					SELECT DISTINCT DateKey
					FROM [dm].[dim_date]
					)
				OR A.receivedOn IS NULL
				AND A.varietyId IN (
					SELECT DISTINCT varietyId
					FROM [dm].[dim_variety]
					)
				OR A.varietyId IS NULL
				AND B.[geoNodeId] IN (
					SELECT DISTINCT [geoNodeId]
					FROM [dm].[dim_geonode_flat]
					)
				OR B.[geoNodeId] IS NULL
			
			UNION
			
			SELECT DISTINCT (A.[movementId])
				,'RECEIVED' AS interaction_type
				,A.[type] AS movement_type
				,A.[status] AS movement_status
				,A.[varietyId]
				,A.[propagationMethod]
				,A.[shipmentIdentifier]
				,A.[endEntityId] AS start_end_EntityId
				,B.geoNodeId AS start_end_GeoNodeId
				,A.[receiverId] AS sender_receiver_Id
				,CAST(FORMAT(CAST(A.[receivedOn] AS DATE), 'yyyyMMdd') AS INT) AS sent_received_date_key
				,A.[receivedQty] AS sent_received_Qty
				,A.[price.amount] AS [price.amount]
				,A.[price.currencyCode]
				,A.[costOfProduction.amount] AS [costOfProduction.amount]
				,A.[costOfProduction.currencyCode] AS [costOfProduction.currencyCode]
				,A.[auditInfo.createdBy] AS [auditInfo.createdBy]
				,CAST(FORMAT(CAST(A.[auditInfo.createdOn] AS DATE), 'yyyyMMdd') AS INT) AS [auditInfo.createdOn]
				,A.[auditInfo.modifiedBy] AS [auditInfo.modifiedBy]
				,CAST(FORMAT(CAST(A.[auditInfo.modifiedOn] AS DATE), 'yyyyMMdd') AS INT) AS [auditInfo.modifiedOn]
				,A.[auditInfo.requestedBy] AS [auditInfo.requestedBy]
				,A.[auditInfo.modifiedReasonCode] AS [auditInfo.modifiedReasonCode]
				,A.[auditInfo.channel] AS [auditInfo.channel]
				,A.[lossReason]
				,A.[distributionPurpose]
				,B.personId AS start_end_entity_primary_contact
			FROM [dwh].[PT_Movement] AS A
			LEFT JOIN (
				SELECT X.personId
					,Z.entityId
					,Z.geoNodeId
				FROM dwh.ET_Entity AS Z
				LEFT JOIN (
					SELECT personId
						,entityId
					FROM (
						SELECT entityId
							,personId
							,RANK() OVER (
								PARTITION BY entityId ORDER BY [auditInfo.createdOn] DESC
								) AS rnk
						FROM [dwh].[ET_Person]
						) AS Y
					WHERE Y.rnk = 1
					) AS X ON X.entityId = Z.entityId
				INNER JOIN [dwh].[CT_GeoNode] AS W WITH (NOLOCK) ON Z.geonodeId = W.geonodeId
					AND W.lineOfBusiness IN (
						'NESCAFE'
						,'GLOBAL'
						)
				) AS B ON A.endEntityId = B.entityId
			WHERE B.personId IN (
					SELECT DISTINCT personId
					FROM [dm].[dim_nsc_person]
					)
				OR B.personId IS NULL
				AND CAST(FORMAT(cast(A.sentOn AS DATE), 'yyyyMMdd') AS INT) IN (
					SELECT DISTINCT DateKey
					FROM [dm].[dim_date]
					)
				OR A.sentOn IS NULL
				AND CAST(FORMAT(cast(A.receivedOn AS DATE), 'yyyyMMdd') AS INT) IN (
					SELECT DISTINCT DateKey
					FROM [dm].[dim_date]
					)
				OR A.receivedOn IS NULL
				AND A.varietyId IN (
					SELECT DISTINCT varietyId
					FROM [dm].[dim_variety]
					)
				OR A.varietyId IS NULL
				AND B.[geoNodeId] IN (
					SELECT DISTINCT [geoNodeId]
					FROM [dm].[dim_geonode_flat]
					)
				OR B.[geoNodeId] IS NULL
			) U
		WHERE start_end_EntityId IN (
				SELECT DISTINCT entityId
				FROM [dm].[dim_nsc_entity_master]
				)
		);
GO





drop table [dm].[fact_nsc_plantlet_distribution];

select * 
into [dm].[fact_nsc_plantlet_distribution]
from [dm].[view_fact_nsc_plantlet_distribution];

ALTER TABLE [dm].[fact_nsc_plantlet_distribution] ADD CONSTRAINT factNscPlantletDistPK PRIMARY KEY (movementId, interaction_type);

select distinct start_end_entityId
from [dm].[view_fact_nsc_plantlet_distribution]
where start_end_entityId NOT IN (select distinct entityId from dm.dim_nsc_entity_master);
