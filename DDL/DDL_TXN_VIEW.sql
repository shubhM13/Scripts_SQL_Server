CREATE VIEW dm.view_nsc_plantlet_distribution_txn AS
SELECT 
	A.movementId as movementId,
	A.movement_type as movement_type ,
	A.movement_status as movement_status,
	A.varietyId as varietyId,
	A.propagationMethod as propagationMethod,
	A.shipmentIdentifier as shipmentIdentifier ,
	A.start_end_EntityId as start_EntityId,
	B.start_end_EntityId as end_EntityId,
	A.start_end_GeoNodeId as start_GeoNodeId,
	B.start_end_GeoNodeId as end_GeoNodeId,
	A.sender_receiver_Id as sender_Id,
	B.sender_receiver_Id as receiver_Id ,
	A.[sent_received_date] as sent_date,
	B.[sent_received_date] as received_date,
	A.[sent_received_Qty] as sent_Qty,
	B.[sent_received_Qty] as received_Qty,
	A.[price.amount] as [price.amount],
	A.[price.currencyCode] as [price.currencyCode],
	A.[costOfProduction.amount] as [costOfProduction.amount],
	A.[costOfProduction.currencyCode] as [costOfProduction.currencyCode],
	A.[auditInfo.createdBy] as [auditInfo.createdBy],
	A.[auditInfo.createdOn] as [auditInfo.createdOn],
	A.[auditInfo.modifiedBy] as [auditInfo.modifiedBy],
	A.[auditInfo.modifiedOn] as [auditInfo.modifiedOn],
	A.[auditInfo.requestedBy] as [auditInfo.requestedBy],
	A.[auditInfo.modifiedReasonCode] as [auditInfo.modifiedReasonCode],
	A.[auditInfo.channel] as [auditInfo.channel],
	A.[lossReason] as lossReason,
	A.[distributionPurpose] as distributionPurpose,
	A.[start_end_entityPrimaryContact] as start_entityPrimaryContact,
	B.[start_end_entityPrimaryContact] as end_entityPrimaryContact
FROM dm.fact_nsc_plantlet_distribution AS A
INNER JOIN dm.fact_nsc_plantlet_distribution AS B
ON A.movementId = B.movementId
AND A.interaction_type = 'SENT'
AND B.interaction_type = 'RECEIVED';