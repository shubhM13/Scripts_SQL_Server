/*******************************************
   Author     : Shubham Mishra
   Created On : 10th August, 2021
   PURPOSE    : TASQ
*******************************************/
--drop view [dm].[view_fact_entity_metrics_summary]
CREATE VIEW [dm].[view_fact_entity_metrics_summary]
AS
WITH cte
AS (
	SELECT entityId
		,ObsYear
		,SUM(totalArea) AS [Farm Area (Ha)]
		,SUM(coffeeArea) AS [Coffee Area (Ha)]
		,SUM(totalProduction) AS [Total Production (KG)]
		,SUM(arabicaProduction) AS [Arabica Production (KG)]
		,SUM(robustaProduction) AS [Robusta Production (KG)]
		,SUM(bourbonProduction) AS [Bourbon Production (KG)]
        ,RANK() OVER(
            PARTITION BY entityId
            ORDER BY ObsYear DESC
        ) AS obsRank
	FROM [dm].[view_fact_entity_metrics]
	GROUP BY entityId
		,ObsYear
	)
SELECT entityId
	   ,ObsYear
       ,CASE 
            WHEN obsRank = 1
            THEN CAST(1 AS BIT)
            ELSE CAST(0 AS BIT)
            END AS [isLatest]
       ,[Farm Area (Ha)]
       ,[Coffee Area (Ha)]
       ,[Total Production (KG)]
       ,[Arabica Production (KG)]
       ,[Robusta Production (KG)]
       ,[Bourbon Production (KG)]
       ,CASE 
           WHEN [Coffee Area (Ha)] = 0
               THEN NULL
           ELSE CAST(ROUND([Total Production (KG)] / [Coffee Area (Ha)], 2) AS DECIMAL(10, 2))
           END AS [Total Yield (KG/Ha)]
FROM cte;





-----------------------------------------------

/*******************************************
   Author     : Shubham Mishra
   Created On : 10th August, 2021
   PURPOSE    : TASQ
*******************************************/
--drop view [dm].[view_fact_entity_metrics_summary]
CREATE VIEW [dm].[view_fact_entity_metrics_summary]
AS
WITH cte
AS (
	SELECT entityId
		,ObsYear
		,CASE 
            WHEN EXP(SUM(LOG(ABS(NULLIF(isLatest, 0))))) IS NULL
                THEN CAST(0 AS BIT)
            ELSE CAST(EXP(SUM(LOG(ABS(NULLIF(isLatest, 0))))) AS BIT)
            END AS [isLatest]
		,SUM(totalArea) AS [Farm Area (Ha)]
		,SUM(coffeeArea) AS [Coffee Area (Ha)]
		,SUM(totalProduction) AS [Total Production (KG)]
		,SUM(arabicaProduction) AS [Arabica Production (KG)]
		,SUM(robustaProduction) AS [Robusta Production (KG)]
		,SUM(bourbonProduction) AS [Bourbon Production (KG)]
	FROM [dm].[view_fact_entity_metrics]
	GROUP BY entityId
		,ObsYear
	)
SELECT *
	,CASE 
		WHEN [Coffee Area (Ha)] = 0
			THEN NULL
		ELSE CAST(ROUND([Total Production (KG)] / [Coffee Area (Ha)], 2) AS DECIMAL(10, 2))
		END AS [Total Yield (KG/Ha)]
FROM cte;


select * from dm.view_fact_entity_metrics_summary
where entityId = '116330';