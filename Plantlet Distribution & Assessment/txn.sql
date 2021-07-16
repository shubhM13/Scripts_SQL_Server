/****** Object:  View [dm].[view_nsc_plantlet_distribution_txn]    Script Date: 29-06-2021 13:28:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
drop view [dm].[view_nsc_plantlet_distribution_txn];
CREATE VIEW [dm].[view_nsc_plantlet_distribution_txn] AS
SELECT distinct
	A.movementId as movementId,
	A.movement_type as movement_type ,
	A.movement_status as movement_status,
	A.varietyId as varietyId,
	H.name as varietyName,
	A.propagationMethod as propagationMethod,
	A.shipmentIdentifier as shipmentIdentifier ,
	A.start_end_EntityId as start_EntityId,
	K.externalSystemId as ext_start_EntityId,
	K.name as start_entity_name,
	K.status as start_entity_status,
	B.start_end_EntityId as end_EntityId,
	L.externalSystemId as ext_end_EntityId,
	L.name as end_entity_name,
	L.status as end_entity_status,
	A.start_end_GeoNodeId as start_GeoNodeId,
	F.cluster_name as start_region_name,
	F.country_name as start_country_name,
	B.start_end_GeoNodeId as end_GeoNodeId,
	G.cluster_name as end_region_name,
	G.country_name as end_country_name,
	A.sender_receiver_Id as sender_Id,
	C.[contactInfo.email] as sender_email,
	B.sender_receiver_Id as receiver_Id ,
	D.[contactInfo.email] as receiver_email,
	I.[Date] as sent_date,
	I.[Year] as sent_year,
	J.[Date] as received_date,
	J.[Year] as received_year,
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
	E.externalSystemId as end_entityPrimaryContact,
	E.[personInfo.firstName] as personFirstName,
	E.[personInfo.lastName] as personLastName,
	E.relationToEntity as relationToEntity,
	E.[contactInfo.mobilePhone] as personMobilePhone,
	CASE WHEN E.[personInfo.firstName] IS NULL THEN '' ELSE 'YES' END AS isPrimaryContact
FROM dm.fact_nsc_plantlet_distribution AS A
INNER JOIN dm.fact_nsc_plantlet_distribution AS B
ON A.movementId = B.movementId
AND A.interaction_type = 'SENT'
AND B.interaction_type = 'RECEIVED'
LEFT OUTER JOIN [dm].[dim_employee] AS C
ON A.sender_receiver_Id = C.employeeId
LEFT OUTER JOIN [dm].[dim_employee] AS D
ON B.sender_receiver_Id = D.employeeId
LEFT OUTER JOIN [dm].[dim_person] AS E
ON B.start_end_entity_primary_contact = E.personId
AND primaryIndicator = 1
LEFT OUTER JOIN [dm].[dim_geonode_flat] AS F
ON A.start_end_GeoNodeId = F.geoNodeId
LEFT OUTER JOIN [dm].[dim_geonode_flat] AS G
ON B.start_end_GeoNodeId = G.geoNodeId
LEFT OUTER JOIN [dm].[dim_variety] AS H
ON H.varietyId = A.varietyId
LEFT OUTER JOIN [dm].[dim_date] AS I
ON A.sent_received_date_key = I.DateKey
LEFT OUTER JOIN [dm].[dim_date] AS J
ON B.sent_received_date_key = J.DateKey
LEFT OUTER JOIN [dm].[dim_entity] AS K
ON A.start_end_EntityId = K.entityId
LEFT OUTER JOIN [dm].[dim_entity] AS L 
ON B.start_end_EntityId = L.entityId
where A.shipmentIdentifier IS NOT NULL
AND B.shipmentIdentifier IS NOT NULL;
GO


