/****** Object:  View [dm].[view_dim_nsp_coffee_species]    Script Date: 28-07-2021 00:33:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*******************************************
 Author     : Shubham Mishra
 Created On : 13th April, 2021
 PURPOSE    : Delivery Nespresso Dataset
 *******************************************/
--drop view [dm].[view_dim_nsp_coffee_species]
CREATE VIEW [dm].[view_dim_nsp_coffee_species]
AS
(
		SELECT DISTINCT ISNULL(CAST(itemCode  AS nvarchar(510)), '') AS coffeeSpeciesCode
						,label AS coffeeSpecies
		FROM [dm].[dim_list_option]
		WHERE setId = 'VARIETY_SPECIES'
);
GO


