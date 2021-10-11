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
CREATE VIEW [dm].[view_fact_nsp_reviving_origins]
AS
(
		SELECT DISTINCT A.deliveryNumber
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
			,E.numberOfPlots
			,E.totalPlotArea
			,E.areaUoM AS plotAreaUoM
			,G.[Farm Area (Ha)]
			,G.[Coffee Area (Ha)]
			,E.totalNumberOfTrees
			,E.avgNumberOfStemsPerTree
			,E.avgRenovationPercent
			,E.avgReplantPercent
			,E.avgRejunvenationPercent
			,E.averageAge
			,E.avgTreesDensity
			,F.varietyDetails
		FROM [dwh].[OT_Delivery] AS A
		LEFT JOIN [dm].[dim_list_option] AS L ON A.deliveredUnit = L.itemCode
			AND L.setId = 'UOM'
		LEFT JOIN [dm].[view_dim_entity_plot_summary] AS E ON A.entityId = E.entityId
		LEFT JOIN [dm].[view_dim_entity_variety_details] AS F ON A.entityId = F.entityId
		LEFT JOIN [dm].[view_fact_entity_metrics_summary] AS G ON A.entityId = G.entityId
			AND G.isLatest = 1
		)
GO

select * from [dm].[view_fact_nsp_reviving_origins];

drop table [aaa].[fact_nsp_reviving_origins];

select * 
into [aaa].[fact_nsp_reviving_origins]
from [dm].[view_fact_nsp_reviving_origins];

ALTER TABLE [aaa].[fact_nsp_reviving_origins]
ADD CONSTRAINT pk_fact_ro PRIMARY KEY (deliveryNumber);

select * 
from [aaa].[fact_nsp_reviving_origins]
where deliveryNumber = '246239C0A88C0B9F1700C600E7D00069';

select count(*) from [dm].[view_fact_nsp_reviving_origins];