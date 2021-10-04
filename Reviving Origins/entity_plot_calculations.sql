SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 1st OCT 2021
 PURPOSE    : Reviving Origins
 *******************************************/
--drop view [dm].[view_dim_entity_plot_summary]	
ALTER VIEW [dm].[view_dim_entity_plot_summary]
AS
(
select distinct A.entityId
			  ,count(distinct A.plotId) AS numberOfPlots
			  ,ROUND(SUM(A.[area.quantity]*B.CONV_FACT), 2) AS totalPlotArea
			  ,'Hectare(s)' AS areaUoM
			  ,SUM(A.numTrees) AS totalNumberOfTrees
			  , CASE WHEN SUM(A.numTrees) IS NOT NULL AND SUM(A.numTrees) <> 0
              THEN ROUND(SUM(CAST(A.numStemsPerTree AS FLOAT)*A.[numTrees])/SUM(A.numTrees), 2)
              ELSE 0
              END AS avgNumberOfStemsPerTree
			  ,CASE WHEN SUM(A.[area.quantity]) IS NOT NULL AND SUM(A.[area.quantity]) <> 0
              THEN ROUND(SUM(CAST(A.renovationPercent AS FLOAT)*A.[area.quantity])/SUM(A.[area.quantity]), 2) 
              ELSE 0
              END AS avgRenovationPercent
			  ,CASE WHEN SUM(A.[area.quantity]) IS NOT NULL AND SUM(A.[area.quantity]) <> 0
              THEN ROUND(SUM(CAST(A.replantPercent AS FLOAT)*A.[area.quantity])/SUM(A.[area.quantity]), 2) 
              ELSE 0
              END AS avgReplantPercent
			  ,CASE WHEN SUM(A.[area.quantity]) IS NOT NULL AND SUM(A.[area.quantity]) <> 0
              THEN ROUND(SUM(CAST(A.rejunvenationPercent AS FLOAT)*A.[area.quantity])/SUM(A.[area.quantity]), 2)
              ELSE 0
              END AS avgRejunvenationPercent
			  ,CASE WHEN SUM(A.[area.quantity]) IS NOT NULL AND SUM(A.[area.quantity]) <> 0
              THEN ROUND(SUM(CAST(A.averageAge AS FLOAT)*A.[area.quantity])/SUM(A.[area.quantity]), 2) 
              ELSE 0
              END AS averageAge
			  ,CASE WHEN SUM(A.[area.quantity]) IS NOT NULL AND SUM(A.[area.quantity]) <> 0
              THEN ROUND(SUM(CAST(A.treesDensity AS FLOAT)*A.[area.quantity])/SUM(A.[area.quantity]), 2) 
              ELSE 0
              END AS avgTreesDensity
			  ,ROUND(AVG(A.productivity*C.CONV_FACT), 2) AS avgProductivity
              ,'Kilogram(s)' AS productivityUOM
from [dwh].[ET_Plot] AS A
LEFT JOIN [dwh].[MT_UOMConversion] AS B
ON A.[area.unitOfMeasure] = B.[ALT_UOM]
LEFT JOIN [dwh].[MT_UOMConversion] AS C
ON A.[productivityUOM] = C.[ALT_UOM]
group by entityId);

select * from [dm].[view_dim_entity_plot_summary];


----------------------
-- select A.[area.quantity]
-- ,A.[area.unitOfMeasure]
-- ,B.[BASE_UOM] AS areaUomBase
-- ,B.CONV_FACT AS c1
-- ,A.[area.quantity]*B.CONV_FACT as areaConverted
-- ,A.[productivity]
-- ,A.[productivityUOM]
-- ,C.[BASE_UOM] AS productivityUomBase
-- ,C.CONV_FACT AS c2
-- ,A.[productivity]*C.CONV_FACT as productivityConverted
-- from [dwh].[ET_Plot] AS A
-- left join [dwh].[MT_UOMConversion] AS B ON A.[area.unitOfMeasure] = B.ALT_UOM
-- left join [dwh].[MT_UOMConversion] AS C ON A.[productivityUOM] = C.ALT_UOM
-- where productivity IS NOT NULL;
--------------------------

