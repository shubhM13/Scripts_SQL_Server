/****** Object:  View [dm].[view_dim_nsp_commodity_type]    Script Date: 28-07-2021 00:35:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*******************************************
 Author     : Shubham Mishra
 Created On : 13th April, 2021
 PURPOSE    : Delivery Nespresso Dataset
 *******************************************/
--drop view [dm].[view_dim_nsp_commodity_type]
CREATE VIEW [dm].[view_dim_nsp_commodity_type]
AS
(
		SELECT DISTINCT itemCode
						,label AS commodityType
		FROM [dm].[dim_list_option]
		WHERE setId = 'COMMODITY_TYPE'
);
GO


