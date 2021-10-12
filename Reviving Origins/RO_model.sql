/****** Object:  View [dm].[view_fact_nsp_reviving_origins]    Script Date: 11-10-2021 14:19:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 24th Aug, 2021
 PURPOSE    : Reviving Model Nespresso
 Updated	: 11th October, 2021 for Normalizing the table data
 *******************************************/
--drop view dm.[view_fact_nsp_reviving_origins]
ALTER VIEW [dm].[view_fact_nsp_reviving_origins]
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
		AND Geo.country_name IN ('Uganda', 'Zimbabwe')
		LEFT JOIN [dm].[dim_list_option] AS L ON A.deliveredUnit = L.itemCode
			AND L.setId = 'UOM'
		)
GO

select count(*) from [dm].[view_fact_nsp_reviving_origins]; --96885
select count(*) from [aaa].[fact_nsp_reviving_origins]; --96885

drop table [aaa].[fact_nsp_reviving_origins];

select * 
into [aaa].[fact_nsp_reviving_origins]
from [dm].[view_fact_nsp_reviving_origins];

ALTER TABLE [aaa].[fact_nsp_reviving_origins]
ADD CONSTRAINT pk_fact_ro PRIMARY KEY (deliveryNumber);

