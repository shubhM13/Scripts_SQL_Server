/*******************************************
 Author     : Shubham Mishra
 Created On : 1st October 2021
 PURPOSE    : Enity Variety Details 
 *******************************************/
--drop view dm.view_dim_entity_variety_details
CREATE VIEW dm.view_dim_entity_variety_details
AS
(
		SELECT DISTINCT a.entityId
					    ,STUFF(
						 (SELECT DISTINCT '; ' + Q.name + ' (' + R.label + '): ' + CAST(ROUND(percentage, 2) AS NVARCHAR(10)) + '%'
						  FROM [dwh].[PT_VarietyToEntity] AS P
						  INNER JOIN [dwh].[PT_Variety] AS Q
						  ON P.varietyId = Q.varietyId
						  LEFT JOIN [dm].[dim_list_option] AS R
						  ON Q.species = R.itemCode AND setId = 'TOPIC'
						  WHERE entityId = a.entityId
						  FOR XML PATH (''))
						  , 1, 1, '')  AS varietyDetails
		FROM [dwh].[PT_VarietyToEntity] AS a
		GROUP BY entityId
		);

select * from dm.view_dim_entity_variety_details;