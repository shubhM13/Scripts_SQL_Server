/*******************************************
 Author     : Shubham Mishra
 Created On : 13th April, 2021
 PURPOSE    : Delivery Nespresso Dataset
 *******************************************/
--drop view dm.view_commodity_type
CREATE VIEW dm.view_commodity_type
AS
(
		SELECT DISTINCT itemCode
						,label AS commodityType
		FROM [dm].[dim_list_option]
		WHERE setId = 'COMMODITY_TYPE'
);


SELECT *
INTO [dm].[dim_nsp_commodity_type]
FROM dm.view_commodity_type;

--ALTER TABLE [dm].[dim_nsp_commodity_type] ADD CONSTRAINT nspCommType_pk PRIMARY KEY ([itemCode]);

/*******************************************
 Author     : Shubham Mishra
 Created On : 13th April, 2021
 PURPOSE    : Delivery Nespresso Dataset
 *******************************************/
--drop view dm.view_coffee_state
CREATE VIEW dm.view_coffee_state
AS
(
		SELECT DISTINCT ISNULL(CAST(itemCode  AS nvarchar(510)), '') AS coffeeStateCode
						,label AS coffeeState
		FROM [dm].[dim_list_option]
		WHERE setId = 'COFFEE_FORM'
);

drop table [dm].[dim_nsp_coffee_state]

SELECT *
INTO [dm].[dim_nsp_coffee_state]
FROM dm.view_coffee_state;

--ALTER TABLE [dm].[dim_nsp_coffee_state] ADD CONSTRAINT nspCoffeeState_pk PRIMARY KEY ([coffeeStateCode]);

/*******************************************
 Author     : Shubham Mishra
 Created On : 13th April, 2021
 PURPOSE    : Delivery Nespresso Dataset
 *******************************************/
--drop view dm.view_coffee_species
CREATE VIEW dm.view_coffee_species
AS
(
		SELECT DISTINCT ISNULL(CAST(itemCode  AS nvarchar(510)), '') AS coffeeSpeciesCode
						,label AS coffeeSpecies
		FROM [dm].[dim_list_option]
		WHERE setId = 'VARIETY_SPECIES'
);

drop table [dm].[dim_nsp_coffee_species]

SELECT *
INTO [dm].[dim_nsp_coffee_species]
FROM dm.view_coffee_species;

--ALTER TABLE [dm].[dim_nsp_coffee_species] ADD CONSTRAINT nspCoffeeSpecies_pk PRIMARY KEY ([coffeeSpeciesCode]);

select * from [dm].[dim_nsp_commodity_type];
select * from [dm].[dim_nsp_coffee_state];
select * from [dm].[dim_nsp_coffee_species];


