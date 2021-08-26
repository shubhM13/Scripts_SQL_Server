/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/

/****** Object:  View [dm].[view_inc_fact_nsp_delivery]    Script Date: 27/07/2021 8:01:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*******************************************
 Author     : Shubham Mishra
 Created On : 12th April, 2021
 PURPOSE    : Delivery Nespresso Dataset
 *******************************************/ 

--drop view dm.view_inc_fact_nsp_delivery
CREATE VIEW [dm].[view_inc_fact_nsp_delivery]
AS
(
		SELECT DISTINCT A.[deliveryNumber]
			,A.[deliveryId]
			,B.label AS commodityType
			,A.[entityId]
			,A.[deliveryDate]
			,CAST(FORMAT(cast(A.[deliveryDate] AS DATE), 'yyyyMMdd') AS INT) AS deliveryDateKey
			,A.[deliveredQuantity]
			,A.[deliveredUnit] AS deliveredUnit1
			,A.[purchasingPoint]
			,A.[pointOfPurchaseCode]
			,A.[invoiceNumber]
			,A.[purchaseExchangeRateVsUSD]
			,E.label AS coffeeState
			,A.[purchaseBasePrice]
			,A.[purchaseCurrency]
			,A.[purchaseNNTotal]
			,D.label AS coffeeSpecie
			,A.[location]
			,A.[premiumCurrency]
			,A.[physicalQuality]
			,A.[purchaseCertified]
			,A.[harvestPeriod]
			,A.[purchaseAAAPremium]
			,A.[cupQuality]
			,A.[purchaseDate]
			,CAST(FORMAT(cast(A.[purchaseDate] AS DATE), 'yyyyMMdd') AS INT) AS purchaseDateKey
			,A.[purchaseBENPremium]
			,A.[purchaseExchangePremiumRateVsUSD]
			,A.[status]
			,CASE 
				WHEN A.[purchaseExchangeRateVsUSD] IS NULL
					OR A.[purchaseExchangeRateVsUSD] = 0
					THEN A.[purchaseBasePrice]
				ELSE A.[purchaseBasePrice] / A.[purchaseExchangeRateVsUSD]
				END AS purchaseBaseprice_USD
			,CASE 
				WHEN A.[purchaseExchangeRateVsUSD] IS NULL
					OR A.[purchaseExchangeRateVsUSD] = 0
					THEN A.[purchaseNNTotal]
				ELSE A.[purchaseNNTotal] / A.[purchaseExchangeRateVsUSD]
				END AS purchaseNNTotal_USD
			,CASE 
				WHEN A.[purchaseExchangeRateVsUSD] IS NULL
					OR A.[purchaseExchangeRateVsUSD] = 0
					THEN A.[purchaseAAAPremium]
				ELSE A.[purchaseAAAPremium] / A.[purchaseExchangeRateVsUSD]
				END AS purchaseAAAPremium_USD
			,CASE 
				WHEN A.[purchaseExchangeRateVsUSD] IS NULL
					OR A.[purchaseExchangeRateVsUSD] = 0
					THEN A.[purchaseBENPremium]
				ELSE A.[purchaseBENPremium] / A.[purchaseExchangeRateVsUSD]
				END AS purchaseBENPremium_USD
			,C.[CONV_FACT]
			,CASE 
				WHEN C.[CONV_FACT] IS NULL
					THEN A.[deliveredQuantity]
				ELSE A.[deliveredQuantity] * C.[CONV_FACT]
				END AS deliveredQuantityKG
		FROM [dwh].[OT_Delivery] AS A
		INNER JOIN [dm].[dim_nsp_entity_master] AS F ON A.entityId = F.entityId
		AND A.lineOfBusiness in ('NESPRESSO','GLOBAL')
		AND A.[auditInfo.modifiedOn] >= (select LastTrigger from [AUDIT].[WaterMarkRT] where schemaname = 'OT' and tablename = 'Delivery')
		AND A.[auditInfo.modifiedOn] <= (select CurrentTrigger from [AUDIT].[WaterMarkRT] where schemaname = 'OT' and tablename = 'Delivery')
		INNER JOIN [dwh].[MT_UOMConversion] AS C ON A.deliveredUnit = C.ALT_UOM
		INNER JOIN [dm].[dim_list_option] AS B ON A.commodityType = B.itemCode
		AND B.setId = 'COMMODITY_TYPE'
		INNER JOIN [dm].[dim_list_option] AS D ON A.coffeeSpecie = D.itemCode
		AND D.setId = 'VARIETY_SPECIES'
		INNER JOIN [dm].[dim_list_option] AS E ON A.coffeeState = E.itemCode
		AND E.setId = 'COFFEE_FORM'
		WHERE
		 A.commodityType IN (select distinct itemCode from [dm].[dim_nsp_commodity_type])
		AND A.coffeeState IN (select distinct coffeeStateCode from [dm].[dim_nsp_coffee_state])
		AND A.coffeeSpecie IN (select distinct coffeeSpeciesCode from [dm].[dim_nsp_coffee_species])
		);
GO


