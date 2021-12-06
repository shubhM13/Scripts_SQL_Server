/****** Object:  View [dm].[view_fact_nsp_reviving_origins]    Script Date: 11-10-2021 14:19:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 19th Nov, 2021
 PURPOSE    : OpenSC Model for DR Congo
 *******************************************/
--drop view [opensc].[view_fact_nsp_traceability]
CREATE VIEW [opensc].[view_fact_nsp_traceability]
AS
(
		SELECT DISTINCT A.deliveryNumber
			,A.entityId
			,A.deliveryDate
			,A.location AS deliveryLocation
			,A.purchasingPoint
			,A.purchaseCertified
			,A.purchaseDate
			,A.harvestPeriod
			,A.coffeeSpecie
			,A.coffeeState
			,A.physicalQuality
			,A.cupQuality
			,A.deliveredQuantity
			,L.label AS deliveredUnit
			,A.purchaseAAAPremium
			,A.purchaseBENPremium
		FROM [dwh].[OT_Delivery] AS A
		INNER JOIN [dwh].[ET_Entity] AS Entity
		ON A.entityId = Entity.entityId
		AND Entity.status = 'ACTIVE'
		INNER JOIN dm.dim_geonode_flat AS Geo ON Entity.geonodeId = Geo.geoNodeId
		AND Geo.country_name IN ('DR Congo')
		LEFT JOIN [dm].[dim_list_option] AS L ON A.deliveredUnit = L.itemCode
			AND L.setId = 'UOM'
		)
GO

select count(*) from [opensc].[view_fact_nsp_traceability]; --96885
select count(*) from [opensc].[fact_nsp_traceability]; --96885

drop table [opensc].[fact_nsp_traceability];

select * 
into [opensc].[fact_nsp_traceability]
from [opensc].[view_fact_nsp_traceability];

ALTER TABLE [opensc].[fact_nsp_traceability]
ADD CONSTRAINT pk_fact_osc PRIMARY KEY (deliveryNumber);

select distinct country_name from dm.dim_geonode_flat
