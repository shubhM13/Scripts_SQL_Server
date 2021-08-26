/****** Object:  View [dm].[view_dim_nsp_coffee_state]    Script Date: 28-07-2021 00:33:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*******************************************
 Author     : Shubham Mishra
 Created On : 13th April, 2021
 PURPOSE    : Delivery Nespresso Dataset
 *******************************************/
--drop view dm.view_dim_nsp_coffee_state
CREATE VIEW [dm].[view_dim_nsp_coffee_state]
AS
(
		SELECT DISTINCT ISNULL(CAST(itemCode  AS nvarchar(510)), '') AS coffeeStateCode
						,label AS coffeeState
		FROM [dm].[dim_list_option]
		WHERE setId = 'COFFEE_FORM'
);
GO


